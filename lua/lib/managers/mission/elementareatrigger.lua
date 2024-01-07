core:import("CoreElementArea")
core:import("CoreClass")
ElementAreaTrigger = ElementAreaTrigger or class(CoreElementArea.ElementAreaTrigger)

function ElementAreaTrigger:init(...)
	ElementAreaTrigger.super.init(self, ...)
end

function ElementAreaTrigger:project_instigators()
	local instigators = {}
	if Network:is_client() then
		if self._values.instigator == "player" or self._values.instigator == "local_criminals" or self._values.instigator == "persons" then
			table.insert(instigators, managers.player:player_unit())
		end
		return instigators
	end
	if self._values.instigator == "player" then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "player_not_in_vehicle" then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "vehicle" then
		local vehicles = managers.vehicle:get_all_vehicles()
		for _, v in pairs(vehicles) do
			if not v:npc_vehicle_driving() then
				table.insert(instigators, v)
			end
		end
	elseif self._values.instigator == "npc_vehicle" then
		local vehicles = managers.vehicle:get_all_vehicles()
		for _, v in pairs(vehicles) do
			if v:npc_vehicle_driving() then
				table.insert(instigators, v)
			end
		end
	elseif self._values.instigator == "vehicle_with_players" then
		local vehicles = managers.vehicle:get_all_vehicles()
		for _, v in pairs(vehicles) do
			table.insert(instigators, v)
		end
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
	elseif self._values.instigator == "hostages" then
		if managers.groupai:state():police_hostage_count() > 0 then
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit:anim_data().surrender then
					table.insert(instigators, data.unit)
				end
			end
		end
		for _, data in pairs(managers.enemy:all_civilians()) do
			if data.unit:anim_data().tied then
				table.insert(instigators, data.unit)
			end
		end
	elseif self._values.instigator == "criminals" then
		for _, data in pairs(managers.groupai:state():all_char_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "local_criminals" then
		table.insert(instigators, managers.player:player_unit())
		for _, data in pairs(managers.groupai:state():all_AI_criminals()) do
			table.insert(instigators, data.unit)
		end
	elseif self._values.instigator == "persons" then
		table.insert(instigators, managers.player:player_unit())
		for _, data in pairs(managers.groupai:state():all_char_criminals()) do
			table.insert(instigators, data.unit)
		end
		for _, data in pairs(managers.enemy:all_civilians()) do
			table.insert(instigators, data.unit)
		end
		for _, data in pairs(managers.enemy:all_enemies()) do
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
				
				if carry_id == "gold" or carry_id == "goat" or carry_id == "present" or carry_id == "money" or carry_id == "diamonds" or carry_id == "coke" or carry_id == "coke_pure" or carry_id == "sandwich" or carry_id == "weapon" or carry_id == "painting" or carry_id == "circuit" or carry_id == "diamonds" or carry_id == "engine_01" or carry_id == "engine_02" or carry_id == "engine_03" or carry_id == "engine_04" or carry_id == "engine_05" or carry_id == "engine_06" or carry_id == "engine_07" or carry_id == "engine_08" or carry_id == "engine_09" or carry_id == "engine_10" or carry_id == "engine_11" or carry_id == "engine_12" or carry_id == "meth" or carry_id == "lance_bag" or carry_id == "lance_bag_large" or carry_id == "grenades" or carry_id == "ammo" or carry_id == "cage_bag" or carry_id == "turret" or carry_id == "artifact_statue" or carry_id == "samurai_suit" or carry_id == "equipment_bag" or carry_id == "cro_loot1" or carry_id == "cro_loot2" or carry_id == "ladder_bag" or carry_id == "hope_diamond" or carry_id == "mus_artifact" or carry_id == "mus_artifact_paint" or carry_id == "winch_part" or carry_id == "winch_part_e3" or carry_id == "fireworks" or carry_id == "evidence_bag" or carry_id == "watertank_empty" or carry_id == "watertank_full" or carry_id == "warhead" or carry_id == "paper_roll" or carry_id == "counterfeit_money" or carry_id == "unknown" or carry_id == "safe_wpn" or carry_id == "safe_ovk" or carry_id == "nail_muriatic_acid" or carry_id == "nail_caustic_soda" or carry_id == "nail_hydrogen_chloride" or carry_id == "nail_euphadrine_pills" or carry_id == "safe_secure_dummy" or carry_id == "din_pig" or carry_id == "meth_half" or carry_id == "parachute" or carry_id == "equipment_bag_global_event" or carry_id == "prototype" or carry_id == "master_server" or carry_id == "lost_artifact" or carry_id == "breaching_charges" or carry_id == "masterpiece_painting" then
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
	if self._values.instigator == "criminals" or self._values.instigator == "local_criminals" then
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
	return managers.network:session():amount_of_alive_players()
end

function ElementAreaTrigger:project_amount_inside()
	local counter = #self._inside
	if self._values.instigator == "vehicle_with_players" then
		for _, instigator in pairs(self._inside) do
			local vehicle = instigator:vehicle_driving()
			if vehicle then
				counter = vehicle:num_players_inside()
			end
		end
	elseif self._values.instigator == "player_not_in_vehicle" then
		counter = 0
		local vehicles = managers.vehicle:get_all_vehicles()
		for _, instigator in pairs(self._inside) do
			local in_vehicle = false
			for _, vehicle in pairs(vehicles) do
				in_vehicle = in_vehicle or vehicle:vehicle_driving():find_seat_for_player(instigator)
			end
			if not in_vehicle then
				counter = counter + 1
			end
		end
	end
	return counter
end

function ElementAreaTrigger:is_instigator_valid(unit)
	if self._values.instigator == "vehicle_with_players" and unit then
		local result = false
		local amount = self._values.amount == "all" and self:project_amount_all()
		amount = amount or tonumber(self._values.amount)
		local inside_vehicle = unit:vehicle_driving():num_players_inside()
		if unit:vehicle_driving() and 0 < inside_vehicle and amount <= inside_vehicle then
			result = true
		end
		return result
	elseif self._values.instigator == "player_not_in_vehicle" then
		local vehicles = managers.vehicle:get_all_vehicles()
		for _, instigator in pairs(self._inside) do
			for _, vehicle in pairs(vehicles) do
				if vehicle:vehicle_driving():find_seat_for_player(instigator) then
					return false
				end
			end
		end
	end
	return true
end

CoreClass.override_class(CoreElementArea.ElementAreaTrigger, ElementAreaTrigger)
