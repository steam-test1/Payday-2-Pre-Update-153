require("lib/managers/MotionPathPathFinder")
MotionPathManager = MotionPathManager or class()
MotionPathManager._VERSION = 0.1

function MotionPathManager:init()
	self._paths = {}
	self._selected_path = ""
	self._triggers = {}
	self._operations = {}
	self._rotations = {}
	self._consumed_triggers = {}
	self._path_types = {"airborne", "ground"}
	self._debug_output_offset = 0
end

function MotionPathManager:get_path_types()
	return self._path_types
end

function MotionPathManager:set_path_type(path_type)
	local path = self:get_path_by_id(self._selected_path)
	if not path then
		return
	end
	path.path_type = path_type
	for _, marker in ipairs(path.markers) do
		local marker_unit = self:_get_unit(marker)
		marker_unit:mission_element_data().path_type = path.path_type
	end
end

function MotionPathManager:get_save_data()
	return ScriptSerializer:to_generic_xml(self._paths)
end

function MotionPathManager:set_load_data(values)
	self._paths = values
end

function MotionPathManager:save(data)
	data.motion_path_manager = {}
	data.motion_path_manager.unit_info = {}
	local unit_info = self:get_units_info()
	data.motion_path_manager.unit_info = unit_info
	data.motion_path_manager.consumed_triggers = self._consumed_triggers
	data.motion_path_manager.operations = self._operations
	data.motion_path_manager.rotations = self._rotations
	data.motion_path_manager.disabled_bridges = {}
	for _, path in ipairs(self._paths) do
		for _, bridge in ipairs(path.bridges) do
			if bridge.disabled then
				table.insert(data.motion_path_manager.disabled_bridges, {
					from = bridge.marker_from,
					to = bridge.marker_to
				})
			end
		end
	end
end

function MotionPathManager:load(data)
	if data.motion_path_manager.unit_info then
		self:_assign_units_to_paths(data.motion_path_manager.unit_info)
	end
	if data.motion_path_manager.consumed_triggers then
		self._consumed_triggers = data.motion_path_manager.consumed_triggers
	end
	if data.motion_path_manager.operations then
		self._operations = data.motion_path_manager.operations
	end
	if data.motion_path_manager.rotations then
		self._rotations = data.motion_path_manager.rotations
	end
	for _, sync_bridge in ipairs(data.motion_path_manager.disabled_bridges) do
		for _, path in ipairs(self._paths) do
			for _, bridge in ipairs(path.bridges) do
				if sync_bridge.from == bridge.marker_from and sync_bridge.to == bridge.marker_to then
					bridge.disabled = true
				end
			end
		end
	end
	self:_get_path_finder():recreate_graph()
end

function MotionPathManager:_assign_units_to_paths(units_info)
	for _, path in ipairs(self._paths) do
		path.units = {}
	end
	for _, unit_info in ipairs(units_info) do
		local path = self:get_path_by_id(unit_info.path_id)
		table.insert(path.units, {
			unit = unit_info.unit_id,
			target_checkpoint = unit_info.target_checkpoint,
			initial_checkpoint = unit_info.initial_checkpoint
		})
	end
end

function MotionPathManager:operation_goto_marker(checkpoint_marker_id, goto_marker_id)
	table.insert(self._operations, {
		operation = "goto_marker",
		checkpoint_marker = checkpoint_marker_id,
		goto_marker = goto_marker_id
	})
end

function MotionPathManager:operation_teleport_to_marker(checkpoint_marker_id, teleport_to_marker_id)
	table.insert(self._operations, {
		operation = "teleport",
		checkpoint_marker = checkpoint_marker_id,
		teleport_to_marker = teleport_to_marker_id
	})
end

function MotionPathManager:operation_set_unit_target_rotation(checkpoint_marker_id, operator_id)
	table.insert(self._operations, {
		operation = "rotate",
		checkpoint_marker = checkpoint_marker_id,
		operator_id = operator_id
	})
end

function MotionPathManager:_operation_execute_goto_marker(path, goto_marker, unit_and_pos)
	local target_path = self:get_path_of_marker(goto_marker)
	if not target_path then
		Application:error("Motion path manager could not find a path for unit ", goto_marker)
		return
	end
	local target_checkpoint = self:_get_checkpoint_from_marker(target_path, goto_marker)
	self:_assign_unit_to_path(target_path, unit_and_pos, target_checkpoint)
	self:_remove_unit_from_path(unit_and_pos.unit, path)
end

function MotionPathManager:_operation_execute_teleport_to_marker(path, teleport_to_marker, unit_and_pos)
	local target_path = self:get_path_of_marker(teleport_to_marker)
	if not target_path then
		Application:error("Motion path manager could not find a path for unit ", teleport_to_marker)
		return
	end
	local target_checkpoint = self:_get_checkpoint_from_marker(target_path, teleport_to_marker)
	self:_assign_unit_to_path(target_path, unit_and_pos, target_checkpoint)
	self:_remove_unit_from_path(unit_and_pos.unit, path)
	local unit = self:_get_unit(unit_and_pos.unit)
	unit:set_position(target_path.points[target_checkpoint].point)
end

function MotionPathManager:_operation_execute_set_unit_target_rotation(operator_id, unit_id)
	Application:trace("MotionPathManager:motion_operation_set_rotation( operator_id, unit_id)", operator_id, unit_id)
	local operator_rotation = self:_get_mop_marker_data(operator_id)
	if operator_rotation then
		self._rotations[unit_id] = operator_rotation.rotation
	else
		Application:error("MotionPathManager:_operation_execute_set_rotation( operator_id, unit_id): Could not acquire operator unit ", operator_id)
	end
end

function MotionPathManager:_assign_unit_to_path(path, unit_and_pos, checkpoint)
	table.insert(path.units, {
		unit = unit_and_pos.unit,
		target_checkpoint = checkpoint,
		initial_checkpoint = checkpoint,
		direction = unit_and_pos.direction
	})
end

function MotionPathManager:_get_checkpoint_from_marker(path, marker)
	for checkpoint, marker_id in pairs(path.marker_checkpoints) do
		if marker == marker_id then
			return checkpoint
		end
	end
	return nil
end

function MotionPathManager:change_unit_path(from_path, target_path, target_marker, unit_and_pos)
	local point_on_path, target_point_id
	for idx, marker_id in pairs(target_path.marker_checkpoints) do
		if marker_id == target_marker then
			target_point_id = idx
		end
	end
	if not target_point_id then
		return
	end
	if not unit_and_pos.direction or unit_and_pos.direction == "fwd" then
		point_on_path = target_point_id
	else
		point_on_path = #target_path.points - target_point_id + 1
	end
	self:_assign_unit_to_path(target_path, unit_and_pos, point_on_path)
	self:_remove_unit_from_path(unit_and_pos.unit, from_path)
end

function MotionPathManager:add_trigger(marker_id, path_id, trigger_id, outcome, callback)
	if path_id then
		if not self._triggers[path_id] then
			self._triggers[path_id] = {}
		end
		table.insert(self._triggers[path_id], {marker_id = marker_id, callback = callback})
	else
		Application:error("MotionPathManager:add_trigger(marker_id, path_id, trigger_id, outcome, callback) - path id is not supplied. Trigger not added.")
	end
end

function MotionPathManager:_is_same_path(markers, linked_markers)
	for _, marker in ipairs(markers) do
		local marker_found = table.contains(linked_markers, marker)
		if not marker_found then
			return false
		end
	end
	return true
end

function MotionPathManager:update_path(motion_path, skip_recreate)
	local path_id = motion_path.id
	local path_found = false
	for key, path in ipairs(self._paths) do
		if path_id == path.id then
			path_found = true
			local speed_limit = self._paths[key].default_speed_limit
			local path_type = self._paths[key].path_type
			self._paths[key] = motion_path
			self._paths[key].default_speed_limit = speed_limit
			self._paths[key].path_type = path_type
			break
		end
	end
	if not path_found and #motion_path.markers > 1 then
		table.insert(self._paths, motion_path)
	end
	if not skip_recreate then
		self:recreate_paths()
	end
end

function MotionPathManager:select_path(path_id)
	self._selected_path = path_id
end

function MotionPathManager:set_default_speed_limit(speed_limit)
	local path = self:get_path_by_id(self._selected_path)
	if not path then
		return
	end
	path.default_speed_limit = speed_limit
end

local AUTO_DRIVE_TEST = true

function MotionPathManager:update(t, dt)
	if Application:editor() and not Global.running_simulation then
		for _, path in ipairs(self._paths) do
			if path.points then
				for j = 1, #path.points do
					if path.points[j + 1] and path.points[j + 1].point then
						local spline_color = path.id == self._selected_path and {
							1,
							1,
							0
						} or {
							1,
							1,
							1
						}
						Application:draw_line(path.points[j].point, path.points[j + 1].point, unpack(spline_color))
					end
				end
			end
		end
		if not AUTO_DRIVE_TEST then
			return
		end
	end
	for _, path in ipairs(self._paths) do
		for _, unit_and_pos in ipairs(path.units) do
			local default_distance_threshold
			if path.path_type == "airborne" then
				default_distance_threshold = 10
			elseif path.path_type == "ground" then
				default_distance_threshold = 400
			else
				default_distance_threshold = 10
			end
			local unit = self:_get_unit(unit_and_pos.unit)
			if alive(unit) then
				local target_checkpoint_vector, distance_to_checkpoint, move_direction, move_vector, movement_distance
				local find_next_checkpoint = true
				self._check_for_operations(path, unit_and_pos)
				local points_in_direction
				if not unit_and_pos.direction or unit_and_pos.direction == "fwd" then
					points_in_direction = path.points
				else
					points_in_direction = path.points_bck
				end
				repeat
					if points_in_direction[unit_and_pos.target_checkpoint] then
						local current_marker = managers.mission:get_element_by_id(path.marker_checkpoints[unit_and_pos.target_checkpoint])
						if current_marker and current_marker._values.motion_state == "wait" then
							find_next_checkpoint = false
						end
						target_checkpoint_vector = points_in_direction[unit_and_pos.target_checkpoint].point - unit:position()
						distance_to_checkpoint = target_checkpoint_vector:length()
						move_direction = target_checkpoint_vector:normalized()
						move_vector = move_direction * points_in_direction[unit_and_pos.target_checkpoint].speed * dt
						movement_distance = move_vector:length()
						if distance_to_checkpoint >= movement_distance then
							find_next_checkpoint = false
						else
							find_next_checkpoint = self:_proceed_to_next_checkpoint(path, unit_and_pos)
						end
						if default_distance_threshold > distance_to_checkpoint then
							local vehicle_ai = unit:npc_vehicle_driving()
							if path.path_type == "ground" and #points_in_direction == unit_and_pos.target_checkpoint and vehicle_ai and vehicle_ai:is_chasing() then
								local npc_vehicle = unit:npc_vehicle_driving()
								if npc_vehicle then
									npc_vehicle._last_checkpoint_reached = true
								else
									Application:error("Non vehicle unit using 'ground' motion path. Unit: " .. unit_and_pos.unit .. " on motion path '" .. path.id .. "'")
								end
							end
							move_vector = target_checkpoint_vector
							find_next_checkpoint = false
							self:_proceed_to_next_checkpoint(path, unit_and_pos)
						end
						if path.path_type == "ground" then
							if alive(unit) and unit.npc_vehicle_driving then
								local vehicle_ai = unit:npc_vehicle_driving()
								if vehicle_ai and vehicle_ai:is_chasing() then
									vehicle_ai:drive_to_point(path, unit_and_pos)
								end
							end
						else
							local target_rotation = self:_get_target_rotation_for_unit(unit, move_direction)
							local current_rotation = unit:rotation()
							local smooth_rot = current_rotation:slerp(target_rotation, dt * 2)
							unit:move(move_vector)
							unit:set_rotation(smooth_rot)
						end
					else
						self:_check_for_triggers(path, unit_and_pos)
						find_next_checkpoint = false
					end
				until not find_next_checkpoint
			end
		end
	end
end

function MotionPathManager:_get_target_rotation_for_unit(unit, move_direction)
	local unit_id = unit:unit_data().unit_id
	local target_rotation
	if self._rotations[unit_id] then
		target_rotation = self._rotations[unit_id]
		local rotation_difference = Rotation:rotation_difference(unit:rotation(), target_rotation)
		if math.abs(rotation_difference:yaw()) < 2 and 2 > math.abs(rotation_difference:pitch()) and 2 > math.abs(rotation_difference:roll()) then
			self._rotations[unit_id] = nil
		end
	else
		target_rotation = Rotation:look_at(move_direction, math.UP)
	end
	return target_rotation
end

function MotionPathManager:_remove_unit_from_path(unit, path)
	for idx, u in ipairs(path.units) do
		if u.unit == unit then
			table.remove(path.units, idx)
		end
	end
end

function MotionPathManager:_proceed_to_next_checkpoint(path, unit_and_pos)
	self:_check_for_triggers(path, unit_and_pos)
	local current_marker = managers.mission:get_element_by_id(path.marker_checkpoints[unit_and_pos.target_checkpoint])
	if current_marker and current_marker._values.motion_state == "move" or not current_marker then
		unit_and_pos.target_checkpoint = unit_and_pos.target_checkpoint + 1
		if unit_and_pos.target_checkpoint > #path.points then
			unit_and_pos.target_checkpoint = #path.points
			return false
		end
		self:_allow_triggers_for_unit(unit_and_pos.unit)
	end
	if current_marker and current_marker._values.motion_state == "wait" then
		return false
	end
	return true
end

function MotionPathManager:_check_for_triggers(path, unit_and_pos)
	if not self._triggers[path.id] then
		return
	end
	for trig_id, trigger in ipairs(self._triggers[path.id]) do
		if trigger.marker_id == path.marker_checkpoints[unit_and_pos.target_checkpoint] and self:_is_trigger_allowed_to_fire_for_unit(unit_and_pos, trig_id) then
			trigger.callback()
			self:_trigger_consumed_for_unit(unit_and_pos, trig_id)
		end
	end
	self:_check_for_operations(path, unit_and_pos)
end

function MotionPathManager:_trigger_consumed_for_unit(unit_and_pos, trig_id)
	self._consumed_triggers[unit_and_pos.unit] = {}
	table.insert(self._consumed_triggers[unit_and_pos.unit], trig_id)
end

function MotionPathManager:_is_trigger_allowed_to_fire_for_unit(unit_and_pos, trig_id)
	if not self._consumed_triggers then
		return true
	end
	if not self._consumed_triggers[unit_and_pos.unit] then
		return true
	end
	for _, trig in ipairs(self._consumed_triggers[unit_and_pos.unit]) do
		if trig == trig_id then
			return false
		end
	end
	return true
end

function MotionPathManager:_allow_triggers_for_unit(unit_id)
	if self._consumed_triggers[unit_id] then
		self._consumed_triggers[unit_id] = nil
	end
end

function MotionPathManager:_check_for_operations(path, unit_and_pos)
	if not self._operations or self._operations and #self._operations == 0 then
		return
	end
	for idx, op in ipairs(self._operations) do
		if path.marker_checkpoints[unit_and_pos.target_checkpoint] == op.checkpoint_marker then
			if op.operation == "goto_marker" then
				self:_operation_execute_goto_marker(path, op.goto_marker, unit_and_pos)
				table.remove(self._operations, idx)
				idx = idx - 1
			elseif op.operation == "teleport" then
				self:_operation_execute_teleport_to_marker(path, op.teleport_to_marker, unit_and_pos)
				table.remove(self._operations, idx)
				idx = idx - 1
			elseif op.operation == "rotate" then
				self:_operation_execute_set_unit_target_rotation(op.operator_id, unit_and_pos.unit)
			end
		end
	end
end

function MotionPathManager:on_simulation_started()
	self._brush = Draw:brush(Color(1, 1, 1))
	self._brush:set_blend_mode("opacity_add")
	self._direction_brush = Draw:brush(Color(1, 0, 0))
	self._direction_brush:set_blend_mode("opacity_add")
	for _, path in ipairs(self._paths) do
		for _, unit_and_pos in ipairs(path.units) do
			unit_and_pos.target_checkpoint = unit_and_pos.initial_checkpoint
		end
	end
	self:_get_path_finder():recreate_graph()
end

function MotionPathManager:on_simulation_ended()
	self._triggers = {}
	self._operations = {}
	self._rotations = {}
	self._debug_output_offset = 0
	for _, path in ipairs(self._paths) do
		for _, unit_and_pos in ipairs(path.units) do
			unit_and_pos.target_checkpoint = unit_and_pos.initial_checkpoint
		end
		for _, bridge in ipairs(path.bridges) do
			bridge.disabled = nil
		end
	end
end

function MotionPathManager:_get_unit(unit_id)
	if Global.running_simulation then
		return managers.editor:unit_with_id(unit_id)
	elseif Application:editor() then
		return managers.editor:unit_with_id(unit_id)
	else
		return managers.worlddefinition:get_unit(unit_id)
	end
end

function MotionPathManager:_get_mop_marker_data(unit_id)
	local unit = managers.mission:get_element_by_id(unit_id)
	if unit then
		return unit._values
	end
	return unit
end

function MotionPathManager:paths_exist()
	if #self._paths > 0 then
		return true
	end
	return false
end

function MotionPathManager:sanitize_paths()
	local paths = {}
	for idx, path in ipairs(self._paths) do
		if #path.markers <= 1 then
			table.remove(self._paths, idx)
			idx = idx - 1
		end
	end
end

function MotionPathManager:get_path_of_marker(marker)
	for _, path in ipairs(self._paths) do
		if table.contains(path.markers, marker) then
			return path
		end
	end
	return nil
end

function MotionPathManager:get_path_by_id(path_id)
	for _, path in ipairs(self._paths) do
		if path.id == path_id then
			return path
		end
	end
	return nil
end

function MotionPathManager:get_path_id(linked_markers)
	for _, path in ipairs(self._paths) do
		if self:_is_same_path(path.markers, linked_markers) then
			return path.id
		end
	end
	return "motion_path_" .. #self._paths + 1
end

function MotionPathManager:get_all_paths()
	return self._paths
end

function MotionPathManager:_get_path_finder()
	if not self._path_finder then
		self._path_finder = MotionPathPathFinder.new()
		self._path_finder:recreate_graph()
	end
	return self._path_finder
end

function MotionPathManager:recreate_paths()
	self._paths = {}
	local mission_elements = managers.worlddefinition._mission_element_units
	for _, me in pairs(mission_elements) do
		if alive(me) and me:name() == Idstring("units/dev_tools/mission_elements/motion_path_marker/motion_path_marker") then
			me:mission_element():_recreate_motion_path(me, true, true)
		end
	end
	for _, path in ipairs(self._paths) do
		for _, bridge in ipairs(path.bridges) do
			local path_to = self:get_path_of_marker(bridge.marker_to)
			if path_to then
				bridge.path_id = path_to.id
			else
				Application:error("MotionPathManager:recreate_paths() target path does not exist.", inspect(bridge))
			end
		end
	end
	self:_get_path_finder():recreate_graph()
end

function MotionPathManager:find_next_path(start_pos, end_pos)
	local next_path = self:_get_path_finder():find_path(start_pos, end_pos)
	return next_path
end

function MotionPathManager:delete_paths()
	self._paths = {}
	self._operations = {}
	self._rotations = {}
end

function MotionPathManager:get_units_info()
	local units_info = {}
	for _, path in ipairs(self._paths) do
		for _, unit_and_pos in ipairs(path.units) do
			table.insert(units_info, {
				unit_id = unit_and_pos.unit,
				path_id = path.id,
				target_checkpoint = unit_and_pos.target_checkpoint,
				initial_checkpoint = unit_and_pos.initial_checkpoint
			})
		end
	end
	return units_info
end

function MotionPathManager:motion_operation_activate_bridge(marker_ids)
	for _, path in ipairs(self._paths) do
		for _, bridge in ipairs(path.bridges) do
			if table.index_of(marker_ids, bridge.marker_from) ~= -1 and table.index_of(marker_ids, bridge.marker_to) ~= -1 then
				bridge.disabled = nil
			end
		end
	end
	self._path_finder:recreate_graph()
end

function MotionPathManager:motion_operation_deactivate_bridge(marker_ids)
	for _, path in ipairs(self._paths) do
		for _, bridge in ipairs(path.bridges) do
			if table.index_of(marker_ids, bridge.marker_from) ~= -1 and table.index_of(marker_ids, bridge.marker_to) ~= -1 then
				bridge.disabled = true
			end
		end
	end
	self._path_finder:recreate_graph()
end

function MotionPathManager:show_npc_vehicle_stats(enabled)
	self._npc_vehicle_debug_show = enabled
end

function MotionPathManager:npc_vehicle_debug_output_enabled()
	return self._npc_vehicle_debug_show
end

function MotionPathManager:show_bridges()
	for _, path in ipairs(self._paths) do
		for _, bridge in ipairs(path.bridges) do
			local marker_from = self:_get_unit(bridge.marker_from)
			local marker_to = self:_get_unit(bridge.marker_to)
			if alive(marker_from) and alive(marker_to) then
				Application:draw_arrow(marker_from:position(), marker_to:position(), 1, 0, 0, 1)
			end
		end
	end
end
