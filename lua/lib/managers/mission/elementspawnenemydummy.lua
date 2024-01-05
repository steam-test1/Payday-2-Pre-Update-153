core:import("CoreMissionScriptElement")
ElementSpawnEnemyDummy = ElementSpawnEnemyDummy or class(CoreMissionScriptElement.MissionScriptElement)
ElementSpawnEnemyDummy._unit_destroy_clbk_key = "ElementSpawnEnemyDummy"
ElementSpawnEnemyDummy._spawn_stance_types = {
	"neutral",
	"hostile",
	"combat"
}

function ElementSpawnEnemyDummy:init(...)
	ElementSpawnEnemyDummy.super.init(self, ...)
	self._enemy_name = self._values.enemy and Idstring(self._values.enemy) or Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")
	self._units = {}
	self._events = {}
end

function ElementSpawnEnemyDummy:enemy_name()
	return self._enemy_name
end

function ElementSpawnEnemyDummy:units()
	return self._units
end

function ElementSpawnEnemyDummy:produce(params)
	if not managers.groupai:state():is_AI_enabled() then
		return
	end
	if params then
		local unit = safe_spawn_unit(params.name, self._values.position, self._values.rotation)
		unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
		unit:unit_data().mission_element = self
		local spawn_ai = self:_create_spawn_AI_parametric(params.stance, params.objective, self._values)
		unit:brain():set_spawn_ai(spawn_ai)
		table.insert(self._units, unit)
		self:event("spawn", unit)
		if self._values.force_pickup and self._values.force_pickup ~= "none" then
			unit:character_damage():set_pickup(self._values.force_pickup)
		end
	else
		local unit = safe_spawn_unit(self._enemy_name, self._values.position, self._values.rotation)
		unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
		unit:unit_data().mission_element = self
		local objective
		local action = self:_create_action_data(self._values)
		local stance = managers.groupai:state():enemy_weapons_hot() and "cbt" or "ntl"
		if action.type == "act" then
			objective = {
				type = "act",
				action = action,
				stance = stance
			}
		end
		local spawn_ai = {init_state = "idle", objective = objective}
		unit:brain():set_spawn_ai(spawn_ai)
		if self._values.participate_to_group_ai ~= false then
			managers.groupai:state():assign_enemy_to_group_ai(unit)
		end
		table.insert(self._units, unit)
		self:event("spawn", unit)
		if self._values.force_pickup and self._values.force_pickup ~= "none" then
			unit:character_damage():set_pickup(self._values.force_pickup)
		end
	end
	return self._units[#self._units]
end

function ElementSpawnEnemyDummy.produce_test(data, unit)
	local action_desc = ElementSpawnEnemyDummy._create_action_data(nil, data)
	unit:movement():action_request(action_desc)
	unit:movement():set_position(unit:position())
end

function ElementSpawnEnemyDummy:clbk_unit_destroyed(unit)
	local u_key = unit:key()
	for i, owned_unit in ipairs(self._units) do
		if owned_unit:key() == u_key then
			table.remove(self._units, i)
		end
	end
end

function ElementSpawnEnemyDummy:event(name, unit)
	if self._events[name] then
		for _, callback in ipairs(self._events[name]) do
			callback(unit)
		end
	end
end

function ElementSpawnEnemyDummy:add_event_callback(name, callback)
	self._events[name] = self._events[name] or {}
	table.insert(self._events[name], callback)
end

function ElementSpawnEnemyDummy:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	if not managers.groupai:state():is_AI_enabled() and not Application:editor() then
		return
	end
	local unit = self:produce()
	ElementSpawnEnemyDummy.super.on_executed(self, unit)
end

function ElementSpawnEnemyDummy:_create_spawn_AI_parametric(stance, objective, spawn_properties)
	local entry_action = self:_create_action_data(spawn_properties)
	if entry_action.type == "act" then
		local followup_objective = objective
		objective = {
			type = "act",
			action = entry_action,
			followup_objective = followup_objective
		}
	end
	return {
		init_state = "idle",
		stance = stance,
		objective = objective,
		params = {scan = true}
	}
end

function ElementSpawnEnemyDummy:_create_action_data(spawn_properties)
	local action_name = spawn_properties.spawn_action or spawn_properties.state
	if not action_name or action_name == "none" then
		return {
			type = "idle",
			body_part = 1,
			sync = true
		}
	else
		return {
			type = "act",
			variant = action_name,
			body_part = 1,
			blocks = {
				action = -1,
				walk = -1,
				hurt = -1,
				heavy_hurt = -1
			},
			align_sync = true
		}
	end
end

function ElementSpawnEnemyDummy:unspawn_all_units()
	for _, unit in ipairs(self._units) do
		if alive(unit) then
			unit:brain():set_active(false)
			unit:base():set_slot(unit, 0)
		end
	end
end

function ElementSpawnEnemyDummy:kill_all_units()
	for _, unit in ipairs(self._units) do
		if alive(unit) then
			unit:character_damage():damage_mission({damage = 1000})
		end
	end
end

function ElementSpawnEnemyDummy:execute_on_all_units(func)
	for _, unit in ipairs(self._units) do
		if alive(unit) then
			func(unit)
		end
	end
end
