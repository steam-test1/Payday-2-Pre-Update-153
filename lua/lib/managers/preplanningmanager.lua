PrePlanningManager = PrePlanningManager or class()

function PrePlanningManager:init()
	self._mission_elements_by_type = {}
end

function PrePlanningManager:post_init()
end

function PrePlanningManager:register_element(element)
	for _, type in ipairs(element:value("allowed_types")) do
		self._mission_elements_by_type[type] = self._mission_elements_by_type[type] or {}
		table.insert(self._mission_elements_by_type[type], element)
	end
end

function PrePlanningManager:execute(type, index)
	local element = self._mission_elements_by_type[type][index]
	self:_check_spawn_deployable(type, element)
	element:on_executed(nil, "any")
	element:on_executed(nil, type)
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
end

function PrePlanningManager:types()
	local t = {}
	for type, _ in pairs(tweak_data.preplanning.types) do
		table.insert(t, type)
	end
	table.sort(t)
	return t
end
