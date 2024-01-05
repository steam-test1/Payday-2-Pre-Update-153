core:import("CoreMissionScriptElement")
ElementSpecialObjective = ElementSpecialObjective or class(CoreMissionScriptElement.MissionScriptElement)
ElementSpecialObjective._pathing_types = {
	"destination",
	"precise",
	"coarse"
}
ElementSpecialObjective._pathing_type_default = "destination"

function ElementSpecialObjective:init(...)
	ElementSpecialObjective.super.init(self, ...)
	if type(self._values.SO_access) ~= "string" then
		self._values.SO_access = "0"
	end
	local access_filter_version = self._values.access_flag_version or 1
	if access_filter_version ~= managers.navigation.ACCESS_FLAGS_VERSION then
		print("[ElementSpecialObjective:init] converting access flag", access_filter_version, self._values.SO_access)
		self._values.SO_access = managers.navigation:upgrade_access_filter(self._values.SO_access, access_filter_version)
		print("[ElementSpecialObjective:init] converted to", self._values.SO_access)
	else
		self._values.SO_access = managers.navigation:convert_access_filter_to_number(self._values.SO_access)
	end
	if self._values.follow_up_id then
		self._values.followup_elements = {
			self._values.follow_up_id
		}
		self._values.follow_up_id = nil
	end
	if self._values.followup_elements and not next(self._values.followup_elements) then
		self._values.followup_elements = nil
	end
	if self._values.spawn_instigator_ids and not next(self._values.spawn_instigator_ids) then
		self._values.spawn_instigator_ids = nil
	end
	if self._values.interrupt_on then
		if self._values.interrupt_on == "obstructed" then
			self._values.interrupt_dis = 7
			self._values.interrupt_dmg = 0
		elseif self._values.interrupt_on == "contact" then
			self._values.interrupt_dis = -1
			self._values.interrupt_dmg = 0
		else
			self._values.interrupt_dis = 0
			self._values.interrupt_dmg = -1
		end
		print("[function ElementSpecialObjective:init] converted interrupt_on to: interrupt_dis", self._values.interrupt_dis, "interrupt_dmg", self._values.interrupt_dmg)
		self._values.interrupt_on = nil
	end
	self._events = {}
end

function ElementSpecialObjective:event(name, unit)
	if self._events[name] then
		for _, callback in ipairs(self._events[name]) do
			callback(unit)
		end
	end
end

function ElementSpecialObjective:clbk_objective_action_start(unit)
	self:event("anim_start", unit)
end

function ElementSpecialObjective:clbk_objective_administered(unit)
	if self._values.needs_pos_rsrv then
		self._pos_rsrv = self._pos_rsrv or {}
		local unit_rsrv = self._pos_rsrv[unit:key()]
		if unit_rsrv then
			managers.navigation:unreserve_pos(unit_rsrv)
		else
			unit_rsrv = {
				position = self._values.align_position and self._values.position or unit:position(),
				radius = 30
			}
			self._pos_rsrv[unit:key()] = unit_rsrv
		end
		unit_rsrv.filter = unit:movement():pos_rsrv_id()
		managers.navigation:add_pos_reservation(unit_rsrv)
	end
	self._receiver_units = self._receiver_units or {}
	self._receiver_units[unit:key()] = unit
	self:event("administered", unit)
end

function ElementSpecialObjective:clbk_objective_complete(unit)
	if self._pos_rsrv then
		local unit_rsrv = self._pos_rsrv[unit:key()]
		if unit_rsrv then
			managers.navigation:unreserve_pos(unit_rsrv)
			self._pos_rsrv[unit:key()] = nil
		end
	end
	if self._receiver_units then
		self._receiver_units[unit:key()] = nil
		if not next(self._receiver_units) then
			self._receiver_units = nil
		end
	end
	self:event("complete", unit)
end

function ElementSpecialObjective:clbk_objective_failed(unit)
	if self._pos_rsrv then
		local unit_rsrv = self._pos_rsrv[unit:key()]
		if unit_rsrv then
			managers.navigation:unreserve_pos(unit_rsrv)
			self._pos_rsrv[unit:key()] = nil
		end
	end
	if self._receiver_units then
		self._receiver_units[unit:key()] = nil
		if not next(self._receiver_units) then
			self._receiver_units = nil
		end
	end
	if managers.editor and managers.editor._stopping_simulation then
		return
	end
	self:event("fail", unit)
end

function ElementSpecialObjective:clbk_verify_administration(unit)
	if self._values.needs_pos_rsrv then
		self._tmp_pos_rsrv = self._tmp_pos_rsrv or {
			position = self._values.position,
			radius = 30
		}
		local pos_rsrv = self._tmp_pos_rsrv
		pos_rsrv.filter = unit:movement():pos_rsrv_id()
		if managers.navigation:is_pos_free(pos_rsrv) then
			return true
		else
			return false
		end
	end
	return true
end

function ElementSpecialObjective:add_event_callback(name, callback)
	self._events[name] = self._events[name] or {}
	table.insert(self._events[name], callback)
end

function ElementSpecialObjective:on_executed(instigator)
	if not self._values.enabled or Network:is_client() then
		return
	end
	if not managers.groupai:state():is_AI_enabled() and not Application:editor() then
	elseif self._values.spawn_instigator_ids then
		local chosen_units, objectives = self:_select_units_from_spawners()
		if chosen_units then
			for i, chosen_unit in ipairs(chosen_units) do
				self:_administer_objective(chosen_unit, objectives[i])
			end
		end
	elseif self._values.use_instigator then
		if self:_is_nav_link() then
			Application:error("[ElementSpecialObjective:on_executed] Ambiguous nav_link/SO. Element id:", self._id)
		elseif type_name(instigator) == "Unit" and alive(instigator) then
			if instigator:brain() then
				if (not instigator:character_damage() or not instigator:character_damage():dead()) and managers.navigation:check_access(self._values.SO_access, instigator:brain():SO_access(), 0) then
					local objective = self:get_objective(instigator)
					if objective then
						self:_administer_objective(instigator, objective)
					end
				end
			else
				Application:error("[ElementSpecialObjective:on_executed] Special Objective instigator is not an AI unit. Possibly improper \"use instigator\" flag use. Element id:", self._id)
			end
		elseif not instigator then
			Application:error("[ElementSpecialObjective:on_executed] Special Objective missing instigator. Possibly improper \"use instigator\" flag use. Element id:", self._id)
		end
	elseif self:_is_nav_link() then
		if self._values.so_action and self._values.so_action ~= "none" then
			managers.navigation:register_anim_nav_link(self)
		else
			Application:error("[ElementSpecialObjective:on_executed] Nav link without animation specified. Element id:", self._id)
		end
	else
		local objective = self:get_objective(instigator)
		if objective then
			local search_dis_sq = self._values.search_distance
			search_dis_sq = search_dis_sq ~= 0 and search_dis_sq * search_dis_sq or nil
			local so_descriptor = {
				objective = objective,
				base_chance = self._values.base_chance,
				chance_inc = self._values.chance_inc,
				interval = self._values.interval,
				search_dis_sq = search_dis_sq,
				search_pos = self._values.search_position,
				usage_amount = self._values.trigger_times,
				AI_group = self._values.ai_group or "enemies",
				access = self._values.SO_access and tonumber(self._values.SO_access) or managers.navigation:convert_SO_AI_group_to_access(self._values.ai_group or "enemies"),
				repeatable = self._values.repeatable,
				admin_clbk = callback(self, self, "clbk_objective_administered")
			}
			if so_descriptor.usage_amount and so_descriptor.usage_amount < 1 then
				so_descriptor.usage_amount = nil
			end
			managers.groupai:state():add_special_objective(self._id, so_descriptor)
		end
	end
	ElementSpecialObjective.super.on_executed(self, instigator)
end

function ElementSpecialObjective:operation_remove()
	if self._nav_link then
		managers.navigation:unregister_anim_nav_link(self)
	else
		managers.groupai:state():remove_special_objective(self._id)
		if self._receiver_units then
			local cpy = clone(self._receiver_units)
			for u_key, unit in pairs(cpy) do
				if self._receiver_units[u_key] and unit:brain():is_available_for_assignment() then
					unit:brain():set_objective(nil)
				end
			end
		end
	end
end

function ElementSpecialObjective:get_objective(instigator)
	local is_AI_SO = self._is_AI_SO or string.begins(self._values.so_action, "AI")
	local pose, stance, attitude, path_style, pos, rot, interrupt_dis, interrupt_health, haste, trigger_on, interaction_voice = self:_get_misc_SO_params()
	local objective = {
		type = false,
		pos = pos,
		rot = rot,
		path_data = false,
		path_style = path_style,
		attitude = attitude,
		stance = stance,
		pose = pose,
		haste = haste,
		interrupt_dis = interrupt_dis,
		interrupt_health = interrupt_health,
		no_retreat = not interrupt_dis and not interrupt_health,
		trigger_on = trigger_on,
		action_duration = self:_get_action_duration(),
		interaction_voice = interaction_voice,
		followup_SO = self._values.followup_elements and self or nil,
		action_start_clbk = callback(self, self, "clbk_objective_action_start"),
		fail_clbk = callback(self, self, "clbk_objective_failed"),
		complete_clbk = callback(self, self, "clbk_objective_complete"),
		verification_clbk = callback(self, self, "clbk_verify_administration"),
		scan = self._values.scan,
		forced = self._values.forced,
		no_arrest = self._values.no_arrest
	}
	if self._values.followup_elements then
		local so_element = managers.mission:get_element_by_id(self._values.followup_elements[1])
		if so_element.get_objective_trigger and so_element:get_objective_trigger() then
			objective.followup_objective = so_element:get_objective()
			objective.followup_SO = nil
		end
	end
	if is_AI_SO then
		local objective_type = string.sub(self._values.so_action, 4)
		local last_pos, nav_seg
		if objective_type == "hunt" then
			nav_seg, last_pos = self:_get_hunt_location(instigator)
			if not nav_seg then
				return
			end
		else
			local path_name = self._values.patrol_path
			if path_name == "none" then
				last_pos = pos or self._values.position
			elseif path_style == "destination" then
				local path_data = managers.ai_data:destination_path(self._values.position, self._values.rotation)
				objective.path_data = path_data
				last_pos = self._values.position
			else
				local path_data = managers.ai_data:patrol_path(path_name)
				objective.path_data = path_data
				local points = path_data.points
				last_pos = points[#points].position
			end
		end
		if objective_type == "search" or objective_type == "hunt" then
			objective.type = "investigate_area"
			objective.nav_seg = nav_seg or last_pos and managers.navigation:get_nav_seg_from_pos(last_pos)
		elseif objective_type == "defend" then
			objective.type = "defend_area"
			objective.nav_seg = nav_seg or last_pos and managers.navigation:get_nav_seg_from_pos(last_pos)
		elseif objective_type == "idle" then
			objective.type = "free"
			objective.nav_seg = nav_seg or last_pos and managers.navigation:get_nav_seg_from_pos(last_pos)
		else
			objective.type = objective_type
			objective.nav_seg = nav_seg or pos and last_pos and managers.navigation:get_nav_seg_from_pos(last_pos)
			if objective_type == "sniper" then
				objective.no_retreat = true
			end
			if objective_type == "security" then
				objective.rubberband_rotation = true
			end
		end
	else
		local action
		if self._values.so_action ~= "none" then
			action = {
				type = "act",
				variant = self._values.so_action,
				body_part = 1,
				blocks = {
					action = -1,
					walk = -1,
					light_hurt = -1,
					hurt = -1,
					heavy_hurt = -1
				},
				align_sync = true,
				needs_full_blend = true
			}
			objective.type = "act"
		else
			objective.type = "free"
		end
		objective.action = action
		if self._values.align_position then
			objective.nav_seg = managers.navigation:get_nav_seg_from_pos(self._values.position)
			if path_style == "destination" then
				local path_data = managers.ai_data:destination_path(self._values.position, self._values.rotation)
				objective.path_data = path_data
			else
				local path_name = self._values.patrol_path
				local path_data = managers.ai_data:patrol_path(path_name)
				objective.path_data = path_data
				if not self._values.align_rotation then
					objective.rot = nil
				end
			end
		end
	end
	if objective.nav_seg then
		objective.area = managers.groupai:state():get_area_from_nav_seg_id(objective.nav_seg)
	end
	return objective
end

function ElementSpecialObjective:_get_hunt_location(instigator)
	if not alive(instigator) then
		return
	end
	local from_pos = instigator:movement():m_pos()
	local nearest_criminal, nearest_dis, nearest_pos
	local criminals = managers.groupai:state():all_criminals()
	for u_key, record in pairs(criminals) do
		if not record.status then
			local my_dis = mvector3.distance(from_pos, record.m_pos)
			if not nearest_dis or nearest_dis > my_dis then
				nearest_dis = my_dis
				nearest_criminal = record.unit
				nearest_pos = record.m_pos
			end
		end
	end
	if not nearest_criminal then
		print("[ElementSpecialObjective:_create_SO_hunt] Could not find a criminal to hunt")
		return
	end
	local criminal_tracker = nearest_criminal:movement():nav_tracker()
	local objective_nav_seg = criminal_tracker:nav_segment()
	return objective_nav_seg, criminal_tracker:field_position()
end

function ElementSpecialObjective:_get_misc_SO_params()
	local pose, stance, attitude, path_style, pos, rot, interrupt_dis, interrupt_health, haste, trigger_on, interaction_voice
	local values = self._values
	pos = values.align_position and values.position
	rot = values.align_rotation and values.rotation
	path_style = values.path_style
	attitude = values.attitude ~= "none" and values.attitude
	stance = values.path_stance ~= "none" and values.path_stance
	pose = values.pose ~= "none" and values.pose
	if values.interrupt_dis == -1 then
		interrupt_dis = -1
	elseif values.interrupt_dis ~= 0 then
		interrupt_dis = values.interrupt_dis * 100
	end
	interrupt_health = values.interrupt_dmg < 1 and 1 - values.interrupt_dmg or nil
	haste = values.path_haste ~= "none" and values.path_haste
	trigger_on = values.trigger_on ~= "none" and values.trigger_on
	interaction_voice = values.interaction_voice ~= "default" and values.interaction_voice
	return pose, stance, attitude, path_style, pos, rot, interrupt_dis, interrupt_health, haste, trigger_on, interaction_voice
end

function ElementSpecialObjective:nav_link_end_pos()
	return self._values.search_position
end

function ElementSpecialObjective:nav_link_access()
	local access
	if self._values.SO_access then
		access = tonumber(self._values.SO_access)
	else
		access = managers.navigation:convert_nav_link_maneuverability_to_SO_access(self._values.navigation_link)
	end
	return access
end

function ElementSpecialObjective:nav_link_delay()
	return self._values.interval
end

function ElementSpecialObjective:nav_link()
	return self._nav_link
end

function ElementSpecialObjective:_is_nav_link()
	return self._values.is_navigation_link or self._values.navigation_link and self._values.navigation_link ~= -1
end

function ElementSpecialObjective:set_nav_link(nav_link)
	self._nav_link = nav_link
end

function ElementSpecialObjective:nav_link_wants_align_pos()
	return self._values.align_position
end

function ElementSpecialObjective:_select_units_from_spawners()
	local candidates = {}
	local objectives = {}
	for _, element_id in ipairs(self._values.spawn_instigator_ids) do
		local spawn_element = managers.mission:get_element_by_id(element_id)
		for _, unit in ipairs(spawn_element:units()) do
			if alive(unit) and (not unit:character_damage() or not unit:character_damage():dead()) and managers.navigation:check_access(self._values.SO_access, unit:brain():SO_access(), 0) then
				local objective = self:get_objective(unit)
				if objective and (self._values.forced or unit:brain():is_available_for_assignment(objective)) then
					table.insert(candidates, unit)
					table.insert(objectives, objective)
				end
			end
		end
	end
	local wanted_nr_units
	if 0 >= self._values.trigger_times then
		return candidates, objectives
	else
		wanted_nr_units = self._values.trigger_times
	end
	wanted_nr_units = math.min(wanted_nr_units, #candidates)
	local chosen_units = {}
	local chosen_objectives = {}
	for i = 1, wanted_nr_units do
		local i_unit = math.random(#candidates)
		local chosen_unit = table.remove(candidates, i_unit)
		table.insert(chosen_units, chosen_unit)
		table.insert(chosen_objectives, table.remove(objectives, i_unit))
	end
	return chosen_units, chosen_objectives
end

function ElementSpecialObjective:get_objective_trigger()
	return self._values.trigger_on ~= "none" and self._values.trigger_on
end

function ElementSpecialObjective:_administer_objective(unit, objective)
	if objective.trigger_on == "interact" then
		if not unit:brain():objective() then
			local idle_objective = {type = "free", followup_objective = objective}
			unit:brain():set_objective(idle_objective)
		end
		unit:brain():set_followup_objective(objective)
		return
	end
	if self._values.forced or unit:brain():is_available_for_assignment(objective) or not unit:brain():objective() then
		if objective.area then
			local u_key = unit:key()
			local u_data = managers.enemy:all_enemies()[u_key]
			if u_data and u_data.assigned_area then
				managers.groupai:state():set_enemy_assigned(objective.area, u_key)
			end
		end
		unit:brain():set_objective(objective)
		self:clbk_objective_administered(unit)
	else
		unit:brain():set_followup_objective(objective)
	end
end

function ElementSpecialObjective:choose_followup_SO(unit, skip_element_ids)
	if not self._values.followup_elements then
		return
	end
	if skip_element_ids == nil then
		if self._values.allow_followup_self and self:enabled() then
			skip_element_ids = {}
		else
			skip_element_ids = {
				[self._id] = true
			}
		end
	end
	if self._values.SO_access and unit and not managers.navigation:check_access(self._values.SO_access, unit:brain():SO_access(), 0) then
		return
	end
	local total_weight = 0
	local pool = {}
	for _, followup_element_id in ipairs(self._values.followup_elements) do
		local weight
		local followup_element = managers.mission:get_element_by_id(followup_element_id)
		if followup_element:enabled() then
			followup_element, weight = followup_element:get_as_followup(unit, skip_element_ids)
			if followup_element and followup_element:enabled() and 0 < weight then
				table.insert(pool, {element = followup_element, weight = weight})
				total_weight = total_weight + weight
			end
		end
	end
	if not next(pool) or total_weight <= 0 then
		return
	end
	local lucky_w = math.random() * total_weight
	local accumulated_w = 0
	for i, followup_data in ipairs(pool) do
		accumulated_w = accumulated_w + followup_data.weight
		if lucky_w <= accumulated_w then
			return pool[i].element
		end
	end
end

function ElementSpecialObjective:get_as_followup(unit, skip_element_ids)
	if (not unit or managers.navigation:check_access(self._values.SO_access, unit:brain():SO_access(), 0) and self:clbk_verify_administration(unit)) and not skip_element_ids[self._id] then
		return self, self._values.base_chance
	end
end

function ElementSpecialObjective:_get_action_duration()
	if not self._values.action_duration_max or self._values.action_duration_max <= 0 then
		return
	else
		local min = math.min(self._values.action_duration_min, self._values.action_duration_max)
		local max = math.max(self._values.action_duration_min, self._values.action_duration_max)
		return math.lerp(min, max, math.random())
	end
end
