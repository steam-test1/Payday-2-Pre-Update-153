require("lib/modifiers/BaseModifier")
require("lib/modifiers/ModifierCivilianAlarm")
require("lib/modifiers/ModifierCloakerKick")
require("lib/modifiers/ModifierEnemyDamage")
require("lib/modifiers/ModifierEnemyHealth")
require("lib/modifiers/ModifierEnemyHealthAndDamage")
require("lib/modifiers/ModifierExplosionImmunity")
require("lib/modifiers/ModifierHeavies")
require("lib/modifiers/ModifierLessConcealment")
require("lib/modifiers/ModifierLessPagers")
require("lib/modifiers/ModifierMoreSpecials")
require("lib/modifiers/ModifierMoreDozers")
require("lib/modifiers/ModifierNoHurtAnims")
require("lib/modifiers/ModifierShieldReflect")
require("lib/modifiers/ModifierSkulldozers")
require("lib/modifiers/ModifierHealSpeed")
require("lib/modifiers/ModifierMoreMedics")
require("lib/modifiers/boosts/GageModifier")
require("lib/modifiers/boosts/GageModifierMaxHealth")
require("lib/modifiers/boosts/GageModifierMaxArmor")
require("lib/modifiers/boosts/GageModifierMaxStamina")
require("lib/modifiers/boosts/GageModifierMaxAmmo")
require("lib/modifiers/boosts/GageModifierMaxLives")
require("lib/modifiers/boosts/GageModifierMaxBodyBags")
require("lib/modifiers/boosts/GageModifierMaxDeployables")
require("lib/modifiers/boosts/GageModifierMaxThrowables")
require("lib/modifiers/boosts/GageModifierQuickReload")
require("lib/modifiers/boosts/GageModifierQuickSwitch")
require("lib/modifiers/boosts/GageModifierQuickPagers")
require("lib/modifiers/boosts/GageModifierQuickLocks")
require("lib/modifiers/boosts/GageModifierFastCrouching")
require("lib/modifiers/boosts/GageModifierDamageAbsorption")
require("lib/modifiers/boosts/GageModifierExplosionImmunity")
require("lib/modifiers/boosts/GageModifierPassivePanic")
require("lib/modifiers/boosts/GageModifierMeleeInvincibility")
require("lib/modifiers/boosts/GageModifierLifeSteal")
CrimeSpreeManager = CrimeSpreeManager or class()

function CrimeSpreeManager:init()
	self:_setup()
end

function CrimeSpreeManager:_setup()
	if not Global.crime_spree then
		Global.crime_spree = {}
	end
	self._global = Global.crime_spree
	self:_setup_temporary_job()
	self:_setup_modifiers()
	if self:_is_active() then
		managers.assets:_setup_mission_assets()
	end
end

function CrimeSpreeManager:_setup_modifiers()
	if not self:_is_active() then
		return
	end
	local modifiers_to_activate = {}
	for _, active_data in ipairs(self:server_active_modifiers()) do
		local modifier = self:get_modifier(active_data.id)
		if modifier then
			local new_data = modifiers_to_activate[modifier.class] or {}
			for key, value_data in pairs(modifier.data) do
				local value = value_data[1]
				local stack_method = value_data[2]
				if stack_method == "none" then
					new_data[key] = value
				elseif stack_method == "add" then
					new_data[key] = (new_data[key] or 0) + value
				elseif stack_method == "sub" then
					new_data[key] = (new_data[key] or 0) - value
				elseif stack_method == "min" then
					new_data[key] = math.min(new_data[key] or math.huge, value)
				elseif stack_method == "max" then
					new_data[key] = math.max(new_data[key] or -math.huge, value)
				end
			end
			modifiers_to_activate[modifier.class] = new_data
		else
			Application:error("[CrimeSpreeManager] Can not activate modifier as it does not exist! Was it deleted?", active_data.id)
		end
	end
	if self._modifiers then
		for _, modifier in ipairs(self._modifiers) do
			modifier:destroy()
		end
	end
	self._modifiers = {}
	for class, data in pairs(modifiers_to_activate) do
		local mod_class = _G[class]
		if mod_class then
			table.insert(self._modifiers, mod_class:new(data))
		else
			Application:error("Can not activate modifier as it does not exist!", class)
		end
	end
end

function CrimeSpreeManager:get_modifier_stack_data(modifier_type)
	local stack_data = {}
	local modifiers = self:_is_active() and self:server_active_modifiers() or self:active_modifiers()
	for _, active_data in ipairs(modifiers) do
		local modifier = self:get_modifier(active_data.id)
		if modifier and modifier.class == modifier_type then
			for key, value_data in pairs(modifier.data) do
				local value = value_data[1]
				local stack_method = value_data[2]
				if stack_method == "none" then
					stack_data[key] = value
				elseif stack_method == "add" then
					stack_data[key] = (stack_data[key] or 0) + value
				elseif stack_method == "sub" then
					stack_data[key] = (stack_data[key] or 0) - value
				elseif stack_method == "min" then
					stack_data[key] = math.min(stack_data[key] or math.huge, value)
				elseif stack_method == "max" then
					stack_data[key] = math.max(stack_data[key] or -math.huge, value)
				end
			end
		end
	end
	return stack_data
end

function CrimeSpreeManager:clear()
	Global.crime_spree = nil
	self._global = nil
	self:_setup()
end

function CrimeSpreeManager:save(data)
	local available_missions = {}
	for _, mission in pairs(self._global.available_missions or {}) do
		table.insert(available_missions, mission.id)
	end
	data.in_progress = self._global.in_progress or false
	data.spree_level = self._global.spree_level or 0
	data.reward_level = self._global.reward_level or 0
	data.missions = available_missions
	data.randomization_cost = self._global.randomization_cost or false
	data.start_data = self._global.start_data or nil
	data.failure = self._global.failure_data or nil
	data.highest_level = self._global.highest_level or 0
	data.modifiers = self._global.modifiers or false
	data.refund_allowed = self._global.refund_allowed
	data.unshown_rewards = self._global.unshown_rewards or {}
	data.winning_streak = self._global.winning_streak or 0
end

function CrimeSpreeManager:load(data, version)
	self._global.in_progress = data.in_progress or false
	self._global.spree_level = data.spree_level or 0
	self._global.reward_level = data.reward_level or 0
	self._global.randomization_cost = data.randomization_cost or false
	self._global.start_data = data.start_data or nil
	self._global.failure_data = data.failure or nil
	self._global.highest_level = data.highest_level or 0
	self._global.modifiers = data.modifiers or {}
	self._global.refund_allowed = data.refund_allowed
	self._global.unshown_rewards = data.unshown_rewards or {}
	self._global.winning_streak = data.winning_streak or 0
	self._global.available_missions = {}
	for _, id in pairs(data.missions or {}) do
		local mission = self:get_mission(id)
		if mission then
			table.insert(self._global.available_missions, mission)
		end
	end
end

function CrimeSpreeManager:sync_save(data)
	data.crime_spree = {}
	data.crime_spree.level = self:spree_level()
	data.crime_spree.mission_id = self:current_mission()
	data.crime_spree.unlocked_assets = self._unlocked_assets
	data.crime_spree.unlocked_assets_peers = self._unlocked_assets_peers
end

function CrimeSpreeManager:sync_load(data)
	if not data.crime_spree then
		return
	end
	if data.crime_spree.level then
		self:set_peer_spree_level(1, data.crime_spree.level)
	end
	if data.crime_spree.mission_id then
		self._global.current_mission = data.crime_spree.mission_id
	end
	for _, asset_id in ipairs(data.crime_spree.unlocked_assets or {}) do
		self:_on_asset_unlocked(asset_id, nil, true)
	end
	for _, id in ipairs(data.crime_spree.unlocked_assets_peers or {}) do
		if id == managers.network:session():local_peer():user_id() then
			self._has_unlocked_asset = true
		end
	end
end

function CrimeSpreeManager:update(t, dt)
	if tweak_data.crime_spree.crash_causes_loss and game_state_machine:current_state_name() == "menu_main" and self._global.start_data and self._global.start_data.mission_id then
		self:_on_mission_failed(self._global.start_data.mission_id)
		self._show_crash_dialog = true
	end
	if self._frame_callbacks then
		local clbks = self._frame_callbacks
		self._frame_callbacks = nil
		for _, clbk in ipairs(clbks) do
			clbk()
		end
	end
end

function CrimeSpreeManager:reset_crime_spree()
	self._global.in_progress = false
	self._global.spree_level = 0
	self._global.reward_level = 0
	self._global.winning_streak = 0
	self._global.available_missions = {}
	self._global.randomization_cost = false
	self._global.current_mission = nil
	self._global.failure_data = nil
	self._global.refund_allowed = true
	self._global.unshown_rewards = {}
	self._global.modifiers = {}
end

function CrimeSpreeManager:_add_frame_callback(clbk)
	self._frame_callbacks = self._frame_callbacks or {}
	table.insert(self._frame_callbacks, clbk)
end

function CrimeSpreeManager:_is_host()
	return Network:is_server() or Global.game_settings.single_player
end

function CrimeSpreeManager:_is_active()
	if game_state_machine then
		return game_state_machine:gamemode().id == GamemodeCrimeSpree.id
	else
		return Global.game_settings.gamemode == GamemodeCrimeSpree.id
	end
end

function CrimeSpreeManager:unlocked()
	return managers.experience:current_level() >= tweak_data.crime_spree.unlock_level or managers.experience:current_rank() > 0
end

function CrimeSpreeManager:in_progress()
	return self._global.in_progress
end

function CrimeSpreeManager:spree_level()
	return self:in_progress() and (self._global.spree_level or 0) or -1
end

function CrimeSpreeManager:server_spree_level()
	if not self:_is_host() then
		return self:get_peer_spree_level(1)
	else
		return self:spree_level()
	end
end

function CrimeSpreeManager:reward_level()
	return self:in_progress() and (self._global.reward_level or 0) or -1
end

function CrimeSpreeManager:spree_level_gained()
	return self._spree_add or 0
end

function CrimeSpreeManager:catchup_bonus()
	return math.floor(self._catchup_bonus or 0)
end

function CrimeSpreeManager:winning_streak_bonus()
	return math.floor(self._winning_streak or 0)
end

function CrimeSpreeManager:mission_start_spree_level()
	if self._global.start_data then
		return self._global.start_data and self._global.start_data.spree_level
	elseif self._global._start_data then
		return self._global._start_data and self._global._start_data.spree_level
	end
end

function CrimeSpreeManager:missions()
	return self._global.available_missions or {}
end

function CrimeSpreeManager:server_missions()
	if not self:_is_host() then
		return self._global.server_missions or {}
	else
		return self:missions()
	end
end

function CrimeSpreeManager:randomization_cost()
	return self._global.randomization_cost or tweak_data.crime_spree.randomization_cost
end

function CrimeSpreeManager:current_mission()
	return self._global.current_mission
end

function CrimeSpreeManager:current_played_mission()
	if self._global.start_data and self._global.start_data.mission_id then
		return self._global.start_data.mission_id
	elseif self._global._start_data and self._global._start_data.mission_id then
		return self._global._start_data.mission_id
	elseif self._global.failure_data and self._global.failure_data.mission_id then
		return self._global.failure_data.mission_id
	end
end

function CrimeSpreeManager:has_failed()
	return self._global.failure_data ~= nil
end

function CrimeSpreeManager:server_has_failed()
	if self._global.peers_spree_state and self._global.peers_spree_state[1] then
		return self._global.peers_spree_state[1] == "failed"
	end
	return false
end

function CrimeSpreeManager:show_crash_dialog()
	return self._show_crash_dialog and self:has_failed()
end

function CrimeSpreeManager:clear_crash_dialog()
	self._show_crash_dialog = nil
end

function CrimeSpreeManager:highest_level()
	return self._global.highest_level or 0
end

function CrimeSpreeManager:active_modifiers()
	return self._global.modifiers
end

function CrimeSpreeManager:server_active_modifiers()
	if not self:_is_host() then
		return self._global.server_modifiers or {}
	else
		return self:in_progress() and self:active_modifiers() or {}
	end
end

function CrimeSpreeManager:active_modifier_classes()
	return self._modifiers or {}
end

function CrimeSpreeManager:modifiers_to_select(table_name)
	local modifiers_table = tweak_data.crime_spree.modifiers[table_name]
	local base_number = self:server_spree_level() / tweak_data.crime_spree.modifier_levels[table_name]
	local active_number = 0
	for _, modifier_data in ipairs(self:active_modifiers()) do
		local contains = false
		for _, modifier in ipairs(modifiers_table) do
			if modifier.id == modifier_data.id then
				contains = true
				break
			end
		end
		if contains then
			active_number = active_number + 1
		else
			local repeating, tbl = self:is_repeating_modifier(modifier_data.id)
			if repeating and tbl == table_name then
				active_number = active_number + 1
			end
		end
	end
	return math.floor(math.max(base_number - active_number, 0))
end

function CrimeSpreeManager:next_modifier_level(table_name, level, additional)
	local num = (level or self:server_spree_level()) / tweak_data.crime_spree.modifier_levels[table_name]
	return (math.floor(num) + 1 + (additional or 0)) * tweak_data.crime_spree.modifier_levels[table_name]
end

function CrimeSpreeManager:active_gage_assets()
	return self._active_assets or {}
end

function CrimeSpreeManager:can_refund_entry_fee()
	return self._global.refund_allowed
end

function CrimeSpreeManager:get_narrative_tweak_data_for_mission_level(mission_id)
	local mission = self:get_mission(mission_id)
	local narrative_id, narrative_data, day, variant
	for job_id, data in pairs(tweak_data.narrative.jobs) do
		for idx, level_data in ipairs(data.chain or {}) do
			if type(level_data) == "table" and not level_data.level_id then
				local found = false
				for variant_idx, level_data in ipairs(level_data) do
					if level_data == mission.level then
						narrative_id = job_id
						narrative_data = data
						day = idx
						variant = variant_idx
						found = true
						break
					end
				end
				if found then
					break
				end
			elseif level_data == mission.level then
				narrative_id = job_id
				narrative_data = data
				day = idx
				break
			end
		end
	end
	if narrative_data then
		for job_id, data in pairs(tweak_data.narrative.jobs) do
			if data.job_wrapper and table.contains(data.job_wrapper, narrative_id) then
				narrative_data = data
				break
			end
		end
	end
	return narrative_data, day, variant
end

function CrimeSpreeManager:get_mission(mission_id)
	mission_id = mission_id or self:current_mission()
	for category, tbl in pairs(tweak_data.crime_spree.missions) do
		for idx, data in pairs(tbl) do
			if data.id == mission_id then
				return data
			end
		end
	end
end

function CrimeSpreeManager:_get_random_mission(missions_table, stealth)
	local mission
	while true do
		mission = table.random(missions_table)
		if not mission.level.dlc or managers.dlc:is_dlc_unlocked(mission.level.dlc) then
			if stealth then
				local level_tweak = tweak_data.levels[mission.level.level_id]
				if level_tweak and level_tweak.ghost_bonus then
					break
				end
			else
				break
			end
		end
	end
	return mission
end

function CrimeSpreeManager:get_random_missions(prev_missions)
	local stealthable = math.random(3)
	local short = self:_get_random_mission(tweak_data.crime_spree.missions.short, stealthable == 1)
	local med = self:_get_random_mission(tweak_data.crime_spree.missions.medium, stealthable == 2)
	local long = self:_get_random_mission(tweak_data.crime_spree.missions.long, stealthable == 3)
	return {
		short,
		med,
		long
	}
end

function CrimeSpreeManager:get_random_mission()
	return table.random(self:get_random_missions())
end

function CrimeSpreeManager:get_start_cost(level)
	return math.floor(tweak_data.crime_spree.initial_cost + tweak_data.crime_spree.cost_per_level * (level or 0))
end

function CrimeSpreeManager:get_continue_cost(level)
	return math.floor(tweak_data.crime_spree.continue_cost[1] + tweak_data.crime_spree.continue_cost[2] * (level or 0))
end

function CrimeSpreeManager:set_starting_level(level)
	self._starting_level = level
end

function CrimeSpreeManager:starting_level()
	return self._starting_level or 0
end

function CrimeSpreeManager:get_loud_modifiers()
	return self:_get_modifiers("loud")
end

function CrimeSpreeManager:get_stealth_modifiers()
	return self:_get_modifiers("stealth")
end

function CrimeSpreeManager:_get_modifiers(table_name)
	local modifiers = {}
	local modifiers_table = tweak_data.crime_spree.modifiers[table_name]
	local repeating_modifiers_table = tweak_data.crime_spree.repeating_modifiers[table_name]
	if not modifiers_table or not modifiers_table[1] then
		Application:error("Can not get modifiers from table as there is no starting modifier: ", table_name)
		return {}
	end
	if self:server_spree_level() < modifiers_table[1].level then
		return {}
	end
	for _, modifier in ipairs(modifiers_table) do
		if modifier.level <= self:server_spree_level() then
			local contains = false
			for _, modifier_data in ipairs(self:active_modifiers()) do
				if modifier_data.id == modifier.id then
					contains = true
					break
				end
			end
			if not contains then
				table.insert(modifiers, modifier)
				if #modifiers >= tweak_data.crime_spree.max_modifiers_displayed then
					break
				end
			end
		end
	end
	local diff = tweak_data.crime_spree.max_modifiers_displayed - #modifiers
	if 0 < diff then
		for i = 1, diff do
			local idx = i % #repeating_modifiers_table + 1
			local mod_data = repeating_modifiers_table[idx]
			local new_mod = deep_clone(mod_data)
			new_mod.id = new_mod.id .. tostring(math.floor(self:server_spree_level() / new_mod.level) * i)
			table.insert(modifiers, new_mod)
		end
	end
	return modifiers
end

function CrimeSpreeManager:select_modifier(modifier_id)
	if table.contains(self._global.modifiers, modifier_id) then
		Application:error("Can not add the same modifier twice! ", modifier_id)
		return false
	end
	local data = {
		id = modifier_id,
		level = self:spree_level()
	}
	table.insert(self._global.modifiers, data)
	if self:_is_host() then
		self:send_crime_spree_modifier(nil, data, true)
	end
	return true
end

function CrimeSpreeManager:get_modifier(modifier_id)
	for _, modifiers_table in pairs(tweak_data.crime_spree.modifiers) do
		for _, data in pairs(modifiers_table) do
			if data.id == modifier_id then
				return data
			end
		end
	end
	for _, mod_table in pairs(tweak_data.crime_spree.repeating_modifiers) do
		for _, mod_data in pairs(mod_table) do
			if string.sub(modifier_id, 1, string.len(mod_data.id)) == mod_data.id then
				return mod_data
			end
		end
	end
end

function CrimeSpreeManager:is_repeating_modifier(modifier_id)
	for id, mod_table in pairs(tweak_data.crime_spree.repeating_modifiers) do
		for _, mod_data in pairs(mod_table) do
			if string.sub(modifier_id, 1, string.len(mod_data.id)) == mod_data.id then
				return true, id
			end
		end
	end
end

function CrimeSpreeManager:get_reward_amount(reward_id)
	self._global.unshown_rewards = self._global.unshown_rewards or {}
	return math.floor(self._global.unshown_rewards[reward_id] or 0)
end

function CrimeSpreeManager:flush_reward_amount(reward_id)
	self._global.unshown_rewards = self._global.unshown_rewards or {}
	if self._global.unshown_rewards[reward_id] then
		self._global.unshown_rewards[reward_id] = self._global.unshown_rewards[reward_id] - math.floor(self._global.unshown_rewards[reward_id])
	end
end

function CrimeSpreeManager:_get_modifier_tables()
	return {
		self:active_modifier_classes(),
		self:active_gage_assets()
	}
end

function CrimeSpreeManager:run_func(func_name, ...)
	for _, modifiers_table in ipairs(self:_get_modifier_tables()) do
		for i, modifier in pairs(modifiers_table) do
			if modifier and modifier[func_name] then
				modifier[func_name](modifier, ...)
			end
		end
	end
end

function CrimeSpreeManager:modify_value(id, value, ...)
	for _, modifiers_table in ipairs(self:_get_modifier_tables()) do
		for i, modifier in pairs(modifiers_table) do
			if modifier and modifier.modify_value then
				local new_value, override = modifier:modify_value(id, value, ...)
				if new_value ~= nil or override then
					value = new_value
				end
			end
		end
	end
	return value
end

function CrimeSpreeManager:start_crime_spree(starting_level)
	print("CrimeSpreeManager:start_crime_spree")
	if not self:can_start_spree(starting_level) then
		return false
	end
	local cost = self:get_start_cost(starting_level)
	managers.custom_safehouse:deduct_coins(cost)
	self:reset_crime_spree()
	self._global.in_progress = true
	self._global.spree_level = starting_level or 0
	self:generate_new_mission_set()
	return true
end

function CrimeSpreeManager:continue_crime_spree()
	if not self:can_continue_spree() then
		return false
	end
	local cost = self:get_continue_cost(self:spree_level())
	managers.custom_safehouse:deduct_coins(cost)
	self._global.failure_data = nil
	self._global.randomization_cost = false
	self:generate_new_mission_set()
	self:_send_crime_spree_level_to_peers()
	return true
end

function CrimeSpreeManager:generate_new_mission_set()
	if not self:in_progress() then
		Application:error("Can not generate new missions if a crime spree is not in progress!")
		return
	end
	self._global.available_missions = self:get_random_missions(self._global.available_missions)
	if self:_is_host() then
		for i, mission in pairs(self._global.available_missions) do
			self:send_crime_spree_mission_data(i, mission.id, false, false)
		end
	end
end

function CrimeSpreeManager:randomize_mission_set()
	if not self:in_progress() then
		Application:error("Can not randomize missions if a crime spree is not in progress!")
		return
	end
	if not self._global.randomization_cost then
		self._global.randomization_cost = tweak_data.crime_spree.randomization_cost
	else
		self._global.randomization_cost = self._global.randomization_cost * tweak_data.crime_spree.randomization_multiplier
	end
	self:generate_new_mission_set()
	if self:_is_host() then
		for idx, mission_data in ipairs(self:missions()) do
			self:send_crime_spree_mission_data(idx, mission_data.id, false, true)
		end
	end
end

function CrimeSpreeManager:calculate_rewards()
	local rewards = {}
	for _, reward in ipairs(tweak_data.crime_spree.rewards) do
		local amt = math.floor(reward.amount * self:reward_level())
		rewards[reward.id] = amt or 0
	end
	return rewards
end

function CrimeSpreeManager:generate_loot_drops(amount)
	local drop_data = {}
	managers.lootdrop:new_make_mass_drop(amount, tweak_data.crime_spree.loot_drop_reward_pay_class, drop_data)
	return drop_data.items
end

function CrimeSpreeManager:loot_drops()
	return self._loot_drops or {}
end

function CrimeSpreeManager:_give_all_cosmetics_reward(amount)
	local all_cosmetics_reward = tweak_data.crime_spree.all_cosmetics_reward
	local type, amt
	if all_cosmetics_reward then
		type = all_cosmetics_reward.type
		if all_cosmetics_reward.type == "continental_coins" then
			amt = all_cosmetics_reward.amount * amount
			managers.custom_safehouse:add_coins(amt)
		end
	end
	return {
		{type = type, amount = amt}
	}
end

function CrimeSpreeManager:generate_cosmetic_drops(amount)
	local tradables_inventory = managers.blackmarket:get_inventory_tradable()
	local rewards_pool = {}
	local final_rewards = {}
	for i, reward in ipairs(tweak_data.crime_spree.cosmetic_rewards) do
		local unlocked
		if reward.type == "armor" then
			unlocked = managers.blackmarket:armor_skin_unlocked(reward.id)
			if not unlocked then
				for _, data in pairs(tradables_inventory) do
					if data.id == reward.id then
						unlocked = true
						break
					end
				end
			end
		end
		if not unlocked then
			table.insert(rewards_pool, reward)
		end
	end
	local num_rewards = #rewards_pool
	if num_rewards == 0 then
		return self:_give_all_cosmetics_reward(amount)
	end
	if amount > num_rewards then
		local rewards = self:_give_all_cosmetics_reward(amount - num_rewards)
		for _, reward in ipairs(rewards) do
			table.insert(final_rewards, reward)
		end
	end
	for i = 1, math.min(amount, num_rewards) do
		local idx = math.random(#rewards_pool)
		local reward = rewards_pool[idx]
		if reward.type == "armor" then
			managers.blackmarket:on_aquired_armor_skin(reward.id)
		end
		table.insert(final_rewards, reward)
		table.remove(rewards_pool, idx)
	end
	return final_rewards
end

function CrimeSpreeManager:cosmetic_rewards()
	return self._cosmetic_drops or {}
end

function CrimeSpreeManager:award_rewards(rewards_table)
	for id, amount in pairs(rewards_table) do
		if id == "experience" then
			managers.experience:give_experience(amount, true)
		elseif id == "cash" then
			managers.money:add_to_total(amount)
		elseif id == "continental_coins" then
			managers.custom_safehouse:add_coins(amount)
		elseif id == "loot_drop" then
			self._loot_drops = self:generate_loot_drops(amount)
		elseif id == "random_cosmetic" then
			self._cosmetic_drops = self:generate_cosmetic_drops(amount)
		end
	end
end

function CrimeSpreeManager:can_start_spree(starting_level)
	if self:in_progress() then
		Application:error("Can not start a Crime Spree if one is already in progress!")
		return false
	end
	local cost = self:get_start_cost(starting_level)
	if cost > managers.custom_safehouse:coins() then
		Application:error("Can not start a Crime Spree if you can not pay the cost! Cost: ", cost)
		return false
	end
	return true
end

function CrimeSpreeManager:can_select_mission(mission_id)
	for _, data in ipairs(self:missions()) do
		if mission_id == data[1] then
			return true
		end
	end
	return false
end

function CrimeSpreeManager:select_mission(mission_id)
	if mission_id == false then
		self._global.current_mission = nil
		return
	end
	local mission_data = self:get_mission(mission_id)
	if mission_data then
		self._global.current_mission = mission_data.id
		self:_setup_temporary_job()
		managers.job:activate_temporary_job("crime_spree", mission_data.level.level_id)
		self:_setup_global_from_mission_id(mission_id)
		if Network:is_server() then
			MenuCallbackHandler:update_matchmake_attributes()
		end
	end
end

function CrimeSpreeManager:_setup_global_from_mission_id(mission_id)
	local mission_data = self:get_mission(mission_id)
	if mission_data then
		Global.game_settings.difficulty = tweak_data.crime_spree.base_difficulty
		Global.game_settings.level_id = mission_data.level.level_id
		Global.game_settings.mission = mission_data.mission or "none"
	end
end

function CrimeSpreeManager:can_continue_spree()
	if not self:in_progress() then
		Application:error("Can not continue a Crime Spree if one is not in progress!")
		return false
	end
	local cost = self:get_continue_cost(self:spree_level())
	if cost > managers.custom_safehouse:coins() then
		Application:error("Can not continue a Crime Spree if you can not pay the cost! Cost: ", cost)
		return false
	end
	return true
end

CrimeSpreeManager.GageAssetEvents = {SendAlreadyUnlocked = 1, Unlock = 2}

function CrimeSpreeManager:can_unlock_asset_is_in_game()
	return game_state_machine:current_state_name() ~= "ingame_waiting_for_players" or managers.criminals:get_num_player_criminals() > 0
end

function CrimeSpreeManager:can_unlock_asset()
	if self:can_unlock_asset_is_in_game() then
		return false, "menu_cs_ga_in_progress"
	end
	local check_is_dropin = game_state_machine and game_state_machine:current_state() and game_state_machine:current_state().check_is_dropin and game_state_machine:current_state():check_is_dropin()
	return not self._has_unlocked_asset, "menu_cs_ga_limit_reached"
end

function CrimeSpreeManager:is_asset_unlocked(asset_id)
	if self._unlocked_assets then
		return table.contains(self._unlocked_assets, asset_id)
	else
		return false
	end
end

function CrimeSpreeManager:_can_asset_be_unlocked(asset_id)
	if self._unlocked_assets then
		return not table.contains(self._unlocked_assets, asset_id)
	else
		return true
	end
end

function CrimeSpreeManager:unlock_gage_asset(asset_id)
	local asset_tweak_data = tweak_data.crime_spree.assets[asset_id]
	if not asset_tweak_data then
		Application:error("Can not unlock gage asset that doesn't exist!", asset_id)
		return false
	end
	if not self:can_unlock_asset() then
		return false
	end
	if self._unlocked_assets and #self._unlocked_assets >= tweak_data.crime_spree.max_assets_unlocked then
		Application:error("Attempting to unlock a gage asset when the limit to gage assets has already been reached!", asset_id)
		return false
	end
	if not self:_can_asset_be_unlocked(asset_id) then
		return false
	end
	managers.custom_safehouse:deduct_coins(asset_tweak_data.cost)
	local params = {
		CrimeSpreeManager.GageAssetEvents.Unlock,
		asset_id
	}
	managers.network:session():send_to_peers("sync_crime_spree_gage_asset_event", unpack(params))
	self._has_unlocked_asset = true
	self:_on_asset_unlocked(asset_id)
	return true
end

function CrimeSpreeManager:_on_asset_unlocked(asset_id, peer, forced)
	local asset_tweak_data = tweak_data.crime_spree.assets[asset_id]
	peer = peer or managers.network:session():local_peer()
	if not asset_tweak_data then
		Application:error("Can not unlock gage asset that doesn't exist!", asset_id)
		return false
	end
	if self._unlocked_assets and #self._unlocked_assets >= tweak_data.crime_spree.max_assets_unlocked then
		Application:error("Attempting to unlock a gage asset when the limit to gage assets has already been reached!", asset_id, peer)
		return false
	end
	if not self:_can_asset_be_unlocked(asset_id) then
		return false
	end
	managers.menu_component:unlock_gage_asset_mission_briefing_gui(asset_id)
	if WalletGuiObject then
		WalletGuiObject.refresh()
	end
	if managers.chat and peer and not forced then
		managers.chat:feed_system_message(ChatManager.GAME, managers.localization:text("menu_chat_peer_unlocked_gage_asset", {
			name = peer:name(),
			asset = managers.localization:text(asset_tweak_data.name_id)
		}))
	end
	if not forced then
		self._unlocked_assets_peers = self._unlocked_assets_peers or {}
		table.insert(self._unlocked_assets_peers, peer:user_id())
	end
	self._unlocked_assets = self._unlocked_assets or {}
	table.insert(self._unlocked_assets, asset_id)
	local mod_class = _G[asset_tweak_data.class]
	if mod_class then
		self._active_assets = self._active_assets or {}
		table.insert(self._active_assets, mod_class:new(asset_tweak_data))
	else
		Application:error("Can not activate gage asset as it's modifier class does not exist!", class)
	end
	return true
end

function CrimeSpreeManager:on_gage_asset_event(event_id, asset_id, peer)
	if event_id == CrimeSpreeManager.GageAssetEvents.Unlock then
		self:_on_asset_unlocked(asset_id, peer)
	end
end

function CrimeSpreeManager:set_temporary_mission(mission_id)
	self._global.current_mission = mission_id
	self:_setup_global_from_mission_id(mission_id)
	self:_setup_temporary_job()
end

function CrimeSpreeManager:_setup_temporary_job()
	if not self:current_mission() then
		return
	end
	local mission_data = self:get_mission(self:current_mission())
	tweak_data.narrative.jobs.crime_spree.chain = {
		mission_data and mission_data.level
	}
end

function CrimeSpreeManager:on_mission_started(mission_id)
	if not self:_is_active() then
		return
	end
	self._global.start_data = {
		mission_id = mission_id,
		spree_level = self:spree_level(),
		server_spree_level = self:server_spree_level(),
		reward_level = self:reward_level()
	}
	self._global.refund_allowed = false
	MenuCallbackHandler:save_progress()
end

function CrimeSpreeManager:on_mission_completed(mission_id)
	if not self:_is_active() then
		return
	end
	if not self:has_failed() then
		local mission_data = self:get_mission(mission_id)
		local spree_add = mission_data.add
		if not self:_is_host() and self._global.start_data and self._global.start_data.server_spree_level then
			local server_level = self._global.start_data and self._global.start_data.server_spree_level or -1
			if server_level < 0 then
				server_level = self:server_spree_level()
			end
			self:set_peer_spree_level(1, server_level + spree_add)
		end
		if not self:_is_host() and self:server_spree_level() > self:spree_level() then
			local diff = self:server_spree_level() - self:spree_level()
			self._catchup_bonus = math.floor(diff * tweak_data.crime_spree.catchup_bonus)
			spree_add = spree_add + self._catchup_bonus
		end
		if not self:_is_host() and self:server_spree_level() < self:spree_level() then
			local diff = self:spree_level() - self:server_spree_level()
			spree_add = spree_add - diff
		end
		spree_add = math.max(math.floor(spree_add), 0)
		self._spree_add = spree_add
		local reward_add = spree_add
		if self:server_spree_level() >= self:spree_level() then
			self._global.winning_streak = (self._global.winning_streak or 1) + spree_add * tweak_data.crime_spree.winning_streak
			if 1 > self._global.winning_streak then
				self._global.winning_streak = self._global.winning_streak + 1
			end
			local pre_winning = reward_add
			reward_add = reward_add * self._global.winning_streak
			self._winning_streak = reward_add - pre_winning
		end
		reward_add = math.max(math.floor(reward_add), 0)
		if self:in_progress() then
			self._global.spree_level = self._global.spree_level + spree_add
			self._global.highest_level = math.max(self._global.highest_level or 0, self._global.spree_level or 0)
		end
		self._global.reward_level = self._global.reward_level + reward_add
		self._global.unshown_rewards = self._global.unshown_rewards or {}
		for _, reward in ipairs(tweak_data.crime_spree.rewards) do
			self._global.unshown_rewards[reward.id] = (self._global.unshown_rewards[reward.id] or 0) + reward_add * reward.amount
		end
	end
	self._global.current_mission = nil
	self._global._start_data = self._global.start_data
	self._global.start_data = nil
	self._global.randomization_cost = false
	self:generate_new_mission_set()
	self:check_achievements()
	MenuCallbackHandler:save_progress()
	if Network:is_server() then
		MenuCallbackHandler:update_matchmake_attributes()
	end
end

function CrimeSpreeManager:on_mission_failed(mission_id)
	if not self:_is_active() then
		return
	end
	self:_on_mission_failed(mission_id)
end

function CrimeSpreeManager:_on_mission_failed(mission_id)
	if not self:_is_host() and self:server_spree_level() + tweak_data.crime_spree.protection_threshold < self:spree_level() then
		return
	end
	self._global.failure_data = {
		mission_id = mission_id,
		highest_level = self._global.start_data.spree_level or self._global.spree_level,
		reward_level = self:reward_level()
	}
	self._global.start_data = nil
	if tweak_data.crime_spree.winning_streak_reset_on_failure then
		self._global.winning_streak = nil
	end
	self._global.current_mission = nil
	MenuCallbackHandler:save_progress()
end

function CrimeSpreeManager:check_achievements()
	if not self:_is_active() or not self:in_progress() then
		return
	end
	for i, achievement in ipairs(tweak_data.crime_spree.achievements.levels) do
		if achievement.level <= self:spree_level() then
			managers.achievment:award(achievement.id)
		end
	end
end

function CrimeSpreeManager:on_spree_complete()
	if not self:in_progress() then
		return
	end
	local rewards = self:calculate_rewards()
	self:award_rewards(rewards)
	self._global.highest_level = math.max(self._global.highest_level or 0, self:spree_level() or 0)
	self._global.in_progress = false
	MenuCallbackHandler:save_progress()
end

function CrimeSpreeManager:enable_crime_spree_gamemode()
	game_state_machine:change_gamemode_by_name("crime_spree")
end

function CrimeSpreeManager:disable_crime_spree_gamemode()
	game_state_machine:change_gamemode_by_name("standard")
end

function CrimeSpreeManager:apply_matchmake_attributes(lobby_attributes)
	print("[CrimeSpreeManager] Applying lobby attributes...")
	if self:in_progress() and self:_is_active() then
		lobby_attributes.crime_spree = self:spree_level()
		lobby_attributes.crime_spree_mission = self._global.current_mission
	else
		lobby_attributes.crime_spree = -1
	end
end

function CrimeSpreeManager:join_server(server_data)
	self:set_peer_spree_level(1, server_data.crime_spree)
	self._global.current_mission = server_data.crime_spree_mission
end

function CrimeSpreeManager:on_entered_lobby()
	if not self:_is_active() then
		return
	end
	if not self:_is_host() then
		local lobby_data = managers.network.matchmake.lobby_handler and managers.network.matchmake.lobby_handler:get_lobby_data()
		if lobby_data then
			local spree_level = tonumber(lobby_data.crime_spree)
			if spree_level and 0 <= spree_level then
				local peer_id
				for id, peer in pairs(managers.network:session():peers()) do
					if peer:is_host() then
						peer_id = id
						break
					end
				end
				if peer_id then
					self:set_peer_spree_level(peer_id, spree_level)
				end
			end
		end
	end
	self:_send_crime_spree_level_to_peers()
end

function CrimeSpreeManager:on_left_lobby()
	self:disable_crime_spree_gamemode()
	self._global.start_data = nil
	self._global.peer_spree_levels = nil
	self._global.peers_spree_state = nil
	self._global.server_missions = nil
	self._global.current_mission = nil
	self._global.server_modifiers = nil
end

function CrimeSpreeManager:on_peer_finished_loading(peer)
	local missions_gui = managers.menu_component:crime_spree_missions_gui()
	self:_send_crime_spree_level_to_peers()
	if self:_is_host() then
		for idx, mission_data in ipairs(self:missions()) do
			self:send_crime_spree_mission_data(idx, mission_data.id, missions_gui and missions_gui:get_selected_index() == idx, false)
		end
	end
	if self:_is_host() then
		for _, modifier_data in ipairs(self:active_modifiers()) do
			self:send_crime_spree_modifier(peer, modifier_data, false)
		end
		managers.network:session():send_to_peer(peer, "sync_crime_spree_modifiers_finalize")
	end
end

function CrimeSpreeManager:_send_crime_spree_level_to_peers()
	if not self:_is_active() then
		return
	end
	local params = {
		managers.network:session():local_peer():id(),
		self:in_progress() and self:spree_level() or -1,
		self:has_failed()
	}
	managers.network:session():send_to_peers("sync_crime_spree_level", unpack(params))
end

function CrimeSpreeManager:send_crime_spree_mission_data(mission_slot, mission_id, selected, perform_randomize)
	if not (self:_is_active() and mission_slot) or not mission_id then
		return
	end
	local params = {
		mission_slot,
		mission_id,
		selected ~= nil and selected or false,
		perform_randomize ~= nil and perform_randomize or false
	}
	managers.network:session():send_to_peers("sync_crime_spree_mission", unpack(params))
end

function CrimeSpreeManager:send_crime_spree_modifier(peer, modifier_data, announce)
	if not self:_is_active() or not modifier_data then
		return
	end
	local params = {
		modifier_data.id,
		modifier_data.level,
		announce or false
	}
	if peer then
		managers.network:session():send_to_peer(peer, "sync_crime_spree_modifier", unpack(params))
	else
		managers.network:session():send_to_peers("sync_crime_spree_modifier", unpack(params))
	end
end

function CrimeSpreeManager:get_peer_spree_level(peer_id)
	if Network:multiplayer() and managers.network:session() then
		local peer = managers.network:session():local_peer()
		if peer and peer:id() == peer_id then
			return self:spree_level()
		end
	end
	if self._global.peer_spree_levels then
		return self._global.peer_spree_levels[peer_id] or -1
	else
		return -1
	end
end

function CrimeSpreeManager:set_peer_spree_level(peer_id, level, has_failed)
	self._global.peer_spree_levels = self._global.peer_spree_levels or {}
	self._global.peer_spree_levels[peer_id] = level
	self._global.peers_spree_state = self._global.peers_spree_state or {}
	self._global.peers_spree_state[peer_id] = has_failed and "failed" or "normal"
	if managers.menu_component and managers.menu_component:crime_spree_missions_gui() then
		managers.menu_component:crime_spree_missions_gui():refresh()
	end
end

function CrimeSpreeManager:set_server_mission(mission_slot, mission_id, selected, perform_randomize)
	self._global.server_missions = self._global.server_missions or {}
	self._global.server_missions[mission_slot] = self:get_mission(mission_id)
	if selected then
		self._global.current_mission = mission_id
		self:_setup_global_from_mission_id(mission_id)
	end
	local missions_gui = managers.menu_component and managers.menu_component:crime_spree_missions_gui()
	if missions_gui then
		missions_gui:update_mission(mission_slot)
		if selected then
			missions_gui:_select_mission(mission_slot)
		end
		if perform_randomize then
			missions_gui:randomize_crimespree(mission_slot)
		end
	elseif selected then
		self:set_consumable_value("mission_gui_selected_slot", mission_slot)
	end
end

function CrimeSpreeManager:set_server_modifier(modifier_id, modifier_level, announce)
	self._global.server_modifiers = self._global.server_modifiers or {}
	for _, data in ipairs(self._global.server_modifiers) do
		if data.id == modifier_id then
			Application:error("Can not add the same server modifier twice!", modifier_id)
			return
		end
	end
	table.insert(self._global.server_modifiers, {id = modifier_id, level = modifier_level})
	self:_add_frame_callback(callback(managers.menu_component, managers.menu_component, "refresh_crime_spree_details_gui"))
	if announce then
		self:_add_frame_callback(callback(self, self, "_announce_modifier", modifier_id))
	end
end

function CrimeSpreeManager:_announce_modifier(modifier_id)
	if managers.menu_component and managers.menu_component:crime_spree_details_gui() then
		managers.menu_component:crime_spree_details_gui():show_new_modifier(modifier_id)
	else
		managers.menu:post_event(tweak_data.crime_spree.announce_modifier_stinger)
	end
end

function CrimeSpreeManager:on_finalize_modifiers()
	if not self:_is_host() then
		self:_setup_modifiers()
	end
end

function CrimeSpreeManager:set_consumable_value(name, value)
	self._consumable_values = self._consumable_values or {}
	self._consumable_values[name] = value
end

function CrimeSpreeManager:has_consumable_value(name)
	self._consumable_values = self._consumable_values or {}
	return self._consumable_values[name] ~= nil
end

function CrimeSpreeManager:consumable_value(name)
	self._consumable_values = self._consumable_values or {}
	if self._consumable_values[name] ~= nil then
		local value = self._consumable_values[name]
		self._consumable_values[name] = nil
		return value
	end
end
