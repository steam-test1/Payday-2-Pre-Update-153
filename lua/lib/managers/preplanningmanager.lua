local debug_assert = function(chk, ...)
	if not chk then
		local s = ""
		for i, text in ipairs({
			...
		}) do
			s = s .. "  " .. text
		end
		assert(chk, s)
	end
end
PrePlanningManager = PrePlanningManager or class()

function PrePlanningManager:init()
	self._mission_elements_by_type = {}
	self._reserved_mission_elements = {}
	self._disabled_types = {}
end

function PrePlanningManager:post_init()
end

function PrePlanningManager:register_element(element)
	for _, type in ipairs(element:value("allowed_types")) do
		self._mission_elements_by_type[type] = self._mission_elements_by_type[type] or {}
		table.insert(self._mission_elements_by_type[type], element)
	end
end

function PrePlanningManager:_change_disabled_type(type, change)
	self._disabled_types[type] = self._disabled_types[type] or 0
	self._disabled_types[type] = self._disabled_types[type] + change
	if self._disabled_types[type] <= 0 then
		self._disabled_types[type] = nil
	end
end

function PrePlanningManager:unreserve_mission_element(id)
	if not managers.network:session() then
		return
	end
	local peer_id = managers.network:session():local_peer():id()
	if Network:is_server() then
		self:_server_unreserve_mission_element(id, peer_id)
	elseif self._reserved_mission_elements[id] and self._reserved_mission_elements[id].peer_id == peer_id then
		managers.network:session():send_to_host("reserve_preplanning", "", id, true)
	end
end

function PrePlanningManager:server_unreserve_mission_element(id, peer_id)
	self:_server_unreserve_mission_element(id, peer_id)
end

function PrePlanningManager:_server_unreserve_mission_element(id, peer_id)
	if self._reserved_mission_elements[id] and self._reserved_mission_elements[id].peer_id == peer_id then
		local type, index = unpack(self._reserved_mission_elements[id].pack)
		local mission_element = self._mission_elements_by_type[type][index]
		if mission_element then
			local disables_types = mission_element:value("disables_types") or {}
			for _, type in ipairs(disables_types) do
				self:_change_disabled_type(type, -1)
			end
		end
		self._reserved_mission_elements[id] = nil
		managers.network:session():send_to_peers_loaded("preplanning_reserved", "", id, peer_id, true)
		print("[UNRESERVED]", "type", type, "id", id, "peer_id", peer_id)
		managers.menu_component:update_preplanning_element(type, id)
	end
end

function PrePlanningManager:client_unreserve_mission_element(id)
	if self._reserved_mission_elements[id] then
		local type, index = unpack(self._reserved_mission_elements[id].pack)
		local mission_element = self._mission_elements_by_type[type][index]
		if mission_element then
			local disables_types = mission_element:value("disables_types") or {}
			for _, type in ipairs(disables_types) do
				self:_change_disabled_type(type, -1)
			end
		end
		self._reserved_mission_elements[id] = nil
		managers.menu_component:update_preplanning_element(type, id)
	end
end

function PrePlanningManager:on_client_gone(peer_id)
	if Network:is_server() then
		local owned_by_client = {}
		for id, reserved_mission_element in pairs(self._reserved_mission_elements) do
			if reserved_mission_element.peer_id == peer_id then
				table.insert(owned_by_client, id)
			end
		end
		for i, id in ipairs(owned_by_client) do
			local type, index = unpack(self._reserved_mission_elements[id].pack)
			local mission_element = self._mission_elements_by_type[type][index]
			if mission_element then
				local disables_types = mission_element:value("disables_types") or {}
				for _, type in ipairs(disables_types) do
					self:_change_disabled_type(type, -1)
				end
			end
			self._reserved_mission_elements[id] = nil
		end
		managers.network:session():send_to_peers_loaded("preplanning_reserved", "", id, peer_id, true)
	end
end

function PrePlanningManager:reserve_mission_element(type, id)
	if Network:is_server() then
		local peer_id = managers.network:session():local_peer():id()
		self:_server_reserve_mission_element(type, id, peer_id)
	elseif not self._reserved_mission_elements[id] then
		print("[SEND] reserve_preplanning")
		managers.network:session():send_to_host("reserve_preplanning", type, id, false)
	end
end

function PrePlanningManager:server_reserve_mission_element(type, id, peer_id)
	self:_server_reserve_mission_element(type, id, peer_id)
end

function PrePlanningManager:_server_reserve_mission_element(type, id, peer_id)
	local index = self:get_mission_element_index(id, type)
	if index and not self._reserved_mission_elements[id] then
		self._reserved_mission_elements[id] = {
			pack = {type, index},
			peer_id = peer_id
		}
		local disables_types = self._mission_elements_by_type[type][index]:value("disables_types") or {}
		for _, type in ipairs(disables_types) do
			self:_change_disabled_type(type, 1)
		end
		managers.network:session():send_to_peers_loaded("preplanning_reserved", type, id, peer_id, false)
		print("[RESERVED]", "type", type, "id", id, "peer_id", peer_id)
		managers.menu_component:update_preplanning_element(type, id)
	end
end

function PrePlanningManager:client_reserve_mission_element(type, id, peer_id)
	local index = self:get_mission_element_index(id, type)
	if index then
		if self._reserved_mission_elements[id] then
			Application:error("[PrePlanningManager:client_reserve_mission_element] Point already reserved!", "type", type, "id", id, "peer_id", peer_id, "point", inspect(self._reserved_mission_elements[id]))
			local old_type = self._reserved_mission_elements[id].pack[1]
			local old_index = self._reserved_mission_elements[id].pack[2]
			local mission_element = self._mission_elements_by_type[old_type][old_index]
			if mission_element then
				local disables_types = mission_element:value("disables_types") or {}
				for _, type in ipairs(disables_types) do
					self:_change_disabled_type(type, -1)
				end
			end
			self._reserved_mission_elements[id] = nil
		end
		self._reserved_mission_elements[id] = {
			pack = {type, index},
			peer_id = peer_id
		}
		local disables_types = self._mission_elements_by_type[type][index]:value("disables_types") or {}
		for _, type in ipairs(disables_types) do
			self:_change_disabled_type(type, 1)
		end
		managers.menu_component:update_preplanning_element(type, id)
	end
end

function PrePlanningManager:get_reserved_mission_element(id)
	return self._reserved_mission_elements[id]
end

function PrePlanningManager:get_reserved_mission_element_data(id)
	return self._reserved_mission_elements[id] and self._reserved_mission_elements[id].pack
end

function PrePlanningManager:execute_reserved_mission_elements()
	if Network:is_server() then
		local index
		for id, data in pairs(self._reserved_mission_elements) do
			self:execute(unpack(data.pack))
		end
	end
	self._reserved_mission_elements = {}
end

function PrePlanningManager:execute(type, index)
	if self._mission_elements_by_type[type] and self._mission_elements_by_type[type][index] then
		local element = self._mission_elements_by_type[type][index]
		self:_check_spawn_deployable(type, element)
		element:on_executed(nil, "any")
		element:on_executed(nil, type)
		print("[PrePlanningManager:execute]", type, index)
	else
		Application:error("[PrePlanningManager:execute] Mission element not found!", "type", type, "index", index)
	end
end

function PrePlanningManager:_check_spawn_deployable(type, element)
	local type_data = tweak_data.preplanning.types[type]
	local deployable_id = type_data.deployable_id
	if not deployable_id then
		return
	end
	local pos, rot = element:get_orientation()
	if deployable_id == "doctor_bag" then
		DoctorBagBase.spawn(pos, rot, 0)
	elseif deployable_id == "ammo_bag" then
		AmmoBagBase.spawn(pos, rot, 0)
	elseif deployable_id == "grenade_crate" then
		GrenadeCrateBase.spawn(pos, rot, 0)
	elseif deployable_id == "bodybags_bag" then
		BodyBagsBagBase.spawn(pos, rot, 0)
	end
end

function PrePlanningManager:on_simulation_started()
end

function PrePlanningManager:on_simulation_ended()
	self._mission_elements_by_type = {}
	self._reserved_mission_elements = {}
	self._disabled_types = {}
end

function PrePlanningManager:get_element_types(mission_element)
	local allowed_types = mission_element:value("allowed_types")
end

function PrePlanningManager:get_mission_element_index(id, type)
	if not self._mission_elements_by_type[type] then
		Application:error("[PrePlanningManager:get_mission_element_index] Mission element type do not exist", "type", type, inspect(self._mission_elements_by_type))
		return
	end
	for index, element in ipairs(self._mission_elements_by_type[type]) do
		if element:id() == id then
			return index
		end
	end
end

function PrePlanningManager:get_type_name(type)
	local type_data = tweak_data:get_raw_value("preplanning", "types", type)
	debug_assert(type_data, "[PrePlanningManager:get_type_name] Type do not exist in tweak data!", "type", type)
	local name_id = type_data.name_id
	return name_id and managers.localization:text(name_id) or "MISSING NAME_ID: " .. type
end

function PrePlanningManager:get_category_name(category)
	return category
end

function PrePlanningManager:get_location_map_data_by_index(index)
	local location_data = self:_get_location_by_index(index)
	local texture = location_data.texture
	local x = location_data.map_x
	local y = location_data.map_y
	local size = location_data.map_size
	return texture, x, y, size
end

function PrePlanningManager:get_location_shape_by_index(index)
	local location_data = self:_get_location_by_index(index)
	local x1 = location_data.x1
	local x2 = location_data.x2
	local y1 = location_data.y1
	local y2 = location_data.y2
	debug_assert(x1 and x2 and y1 and y2, "[PrePlanningManager:get_location_shape_by_index] Missing GUI data!", "x1", x1, "x2", x2, "y1", y1, "y2", y2, "location_data", inspect(location_data))
	return x1, y1, math.abs(x2 - x1), math.abs(y2 - y1)
end

function PrePlanningManager:get_location_shape_by_group(group)
	for index, location_group in ipairs(tweak_data.preplanning.location_groups) do
		if location_group == group then
			return self:get_location_shape_by_index(index)
		end
	end
end

function PrePlanningManager:num_active_locations()
	local location_data = self:_current_location_data()
	debug_assert(location_data, "[PrePlanningManager:num_active_locations] Missing location data for level", "level_id", managers.job:current_level_id())
	return #location_data
end

function PrePlanningManager:first_location_group()
	return tweak_data.preplanning.location_groups[1]
end

function PrePlanningManager:has_current_level_preplanning()
	return not not self:_current_location_data()
end

function PrePlanningManager:_current_location_data()
	local level_id = managers.job:current_level_id()
	return tweak_data.preplanning.locations[level_id]
end

function PrePlanningManager:get_location_by_index(index)
	return self:_get_location_by_index(index)
end

function PrePlanningManager:_get_location_by_index(index)
	local current_data = self:_current_location_data()
	debug_assert(current_data, "[PrePlanningManager:_get_location_by_index] No tweak_data for level!", "level_id", managers.job:current_level_id())
	local location_data = current_data[index]
	debug_assert(location_data, "[PrePlanningManager:_get_location_by_index] No location data for level!", "index", index, "level_id", managers.job:current_level_id())
	return location_data
end

function PrePlanningManager:get_location_group_by_index(index)
	local location_data = self:_get_location_by_index(index)
	local location_group = location_data.group
	debug_assert(location_group, "[PrePlanningManager:get_location_group_by_index] No group for location!", "index", index, "level_id", managers.job:current_level_id())
	return location_group
end

function PrePlanningManager:get_location_rotation_by_index(index)
	local location_data = self:_get_location_by_index(index)
	local location_group = location_data.rotation
	return location_group
end

function PrePlanningManager:get_location_name_by_index(index)
	local location_data = self:_get_location_by_index(index)
	local name_id = location_data.name_id
	debug_assert(name_id, "[PrePlanningManager:get_location_name_by_index] No name_id for location!", "index", index, "level_id", managers.job:current_level_id())
	return managers.localization:text(name_id)
end

function PrePlanningManager:_create_empty_locations_table()
	local locations = {}
	for i = 1, #tweak_data.preplanning.location_groups do
		table.insert(locations, {})
	end
	return locations
end

function PrePlanningManager:_get_location_groups_converter()
	local location_groups_converter = {}
	for location, group in ipairs(tweak_data.preplanning.location_groups) do
		location_groups_converter[group] = location
	end
	return location_groups_converter
end

function PrePlanningManager:convert_location_group_to_index(group)
	for index, location_group in ipairs(tweak_data.preplanning.location_groups) do
		if location_group == group then
			return index
		end
	end
end

function PrePlanningManager:convert_location_index_to_group(index)
	return tweak_data.preplanning.location_groups[index]
end

function PrePlanningManager:sort_mission_elements_into_locations(mission_elements)
	local location_groups_converter = self:_get_location_groups_converter()
	local locations = {}
	local group, index
	for element_index, element in ipairs(mission_elements) do
		group = element:value("location_group")
		index = location_groups_converter[group]
		locations[index] = locations[index] or {}
		table.insert(locations[index], {index = element_index, element = element})
	end
	return locations
end

function PrePlanningManager:is_type_position_important(type)
	debug_assert(tweak_data.preplanning.types[type], "[PrePlanningManager:is_type_position_important] type do not exist in tweak data!", type)
	return not tweak_data.preplanning.types[type].pos_not_important
end

function PrePlanningManager:get_mission_elements_by_type(type)
	return self._mission_elements_by_type[type]
end

function PrePlanningManager:types_with_mission_elements(optional_category)
	local t = {}
	for type, _ in pairs(self._mission_elements_by_type) do
		if not optional_category or (tweak_data.preplanning.types[type].category or "default") == optional_category then
			table.insert(t, type)
		end
	end
	table.sort(t)
	return t
end

function PrePlanningManager:categories_with_mission_elements()
	local t = {}
	for _, type in ipairs(self:types_with_mission_elements()) do
		t[tweak_data.preplanning.types[type].category or "default"] = true
	end
	local sorted_t = {}
	for value, _ in pairs(t) do
		table.insert(sorted_t, value)
	end
	table.sort(sorted_t)
	return sorted_t
end

function PrePlanningManager:types()
	local t = {}
	for type, _ in pairs(tweak_data.preplanning.types) do
		table.insert(t, type)
	end
	table.sort(t)
	return t
end
