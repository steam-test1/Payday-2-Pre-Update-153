core:import("CoreElementArea")
core:import("CoreClass")
ElementAreaTrigger = ElementAreaTrigger or class(CoreElementArea.ElementAreaTrigger)

function ElementAreaTrigger:init(...)
	ElementAreaTrigger.super.init(self, ...)
end

function ElementAreaTrigger:project_instigators()
	local instigators = {}
	if Network:is_client() then
		if self._values.instigator == "player" then
			table.insert(instigators, managers.player:player_unit())
		end
		return instigators
	end
	if self._values.instigator == "player" then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "enemies" then
		if managers.groupai:state():police_hostage_count() <= 0 then
			for _, data in pairs(managers.enemy:all_enemies()) do
				table.insert(instigators, data.unit)
			end
		else
			for _, data in pairs(managers.enemy:all_enemies()) do
				if not data.unit:anim_data().surrender then
					table.insert(instigators, data.unit)
				end
			end
		end
	elseif self._values.instigator == "civilians" then
		for _, data in pairs(managers.enemy:all_civilians()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "escorts" then
		for _, data in pairs(managers.enemy:all_civilians()) do
			if tweak_data.character[data.unit:base()._tweak_table].is_escort then
				table.insert(instigators, data.unit)
			end
		end
	elseif self._values.instigator == "criminals" then
		for _, data in pairs(managers.groupai:state():all_char_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "ai_teammates" then
		for _, data in pairs(managers.groupai:state():all_AI_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "loot" or self._values.instigator == "unique_loot" then
		local all_found = World:find_units_quick("all", 14)
		local filter_func
		if self._values.instigator == "loot" then
			function filter_func(carry_data)
				local carry_id = carry_data:carry_id()
				
				if carry_id == "gold" or carry_id == "money" or carry_id == "diamonds" or carry_id == "coke" or carry_id == "weapon" or carry_id == "painting" or carry_id == "circuit" or carry_id == "diamonds" or carry_id == "engine_01" or carry_id == "engine_02" or carry_id == "engine_03" or carry_id == "engine_04" or carry_id == "engine_05" or carry_id == "engine_06" or carry_id == "engine_07" or carry_id == "engine_08" or carry_id == "engine_09" or carry_id == "engine_10" or carry_id == "engine_11" or carry_id == "engine_12" or carry_id == "meth" or carry_id == "lance_bag" then
					return true
				end
			end
		else
			function filter_func(carry_data)
				local carry_id = carry_data:carry_id()
				
				if tweak_data.carry[carry_id].is_unique_loot then
					return true
				end
			end
		end
		for _, unit in ipairs(all_found) do
			local carry_data = unit:carry_data()
			if carry_data and filter_func(carry_data) then
				table.insert(instigators, unit)
			end
		end
	end
	return instigators
end

function ElementAreaTrigger:project_amount_all()
	if self._values.instigator == "criminals" then
		local i = 0
		for _, data in pairs(managers.groupai:state():all_char_criminals()) do
			i = i + 1
		end
		return i
	elseif self._values.instigator == "ai_teammates" then
		local i = 0
		for _, data in pairs(managers.groupai:state():all_AI_criminals()) do
			i = i + 1
		end
		return i
	end
	return managers.network:game():amount_of_alive_players()
end

CoreClass.override_class(CoreElementArea.ElementAreaTrigger, ElementAreaTrigger)
