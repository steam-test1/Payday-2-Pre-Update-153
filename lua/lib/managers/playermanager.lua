PlayerManager = PlayerManager or class()
PlayerManager.WEAPON_SLOTS = 2

function PlayerManager:init()
	self._player_name = Idstring("units/multiplayer/mp_fps_mover/mp_fps_mover")
	self._players = {}
	self._nr_players = Global.nr_players or 1
	self._last_id = 1
	self._viewport_configs = {}
	self._viewport_configs[1] = {}
	self._viewport_configs[1][1] = {
		dimensions = {
			x = 0,
			y = 0,
			w = 1,
			h = 1
		}
	}
	self._viewport_configs[2] = {}
	self._viewport_configs[2][1] = {
		dimensions = {
			x = 0,
			y = 0,
			w = 1,
			h = 0.5
		}
	}
	self._viewport_configs[2][2] = {
		dimensions = {
			x = 0,
			y = 0.5,
			w = 1,
			h = 0.5
		}
	}
	self:_setup_rules()
	self._local_player_minions = 0
	self._local_player_body_bags = nil
	self._player_states = {
		standard = "ingame_standard",
		mask_off = "ingame_mask_off",
		bleed_out = "ingame_bleed_out",
		fatal = "ingame_fatal",
		arrested = "ingame_arrested",
		tased = "ingame_electrified",
		incapacitated = "ingame_incapacitated",
		clean = "ingame_clean",
		civilian = "ingame_civilian",
		carry = "ingame_standard",
		bipod = "ingame_standard",
		driving = "ingame_driving"
	}
	self._DEFAULT_STATE = "mask_off"
	self._current_state = self._DEFAULT_STATE
	self._sync_states = {
		"civilian",
		"clean",
		"mask_off",
		"standard"
	}
	self._current_sync_state = self._DEFAULT_STATE
	local ids_player = Idstring("player")
	self._player_timer = TimerManager:timer(ids_player) or TimerManager:make_timer(ids_player, TimerManager:pausable())
	self._hostage_close_to_local_t = 0
	self:_setup()
end

function PlayerManager:_setup()
	self._equipment = {
		selections = {},
		specials = {},
		selected_index = nil
	}
	self._listener_holder = EventListenerHolder:new()
	self._player_mesh_suffix = ""
	self._temporary_upgrades = {}
	if not Global.player_manager then
		Global.player_manager = {}
		Global.player_manager.upgrades = {}
		Global.player_manager.team_upgrades = {}
		Global.player_manager.weapons = {}
		Global.player_manager.equipment = {}
		Global.player_manager.grenades = {}
		Global.player_manager.kit = {
			weapon_slots = {"glock_17"},
			equipment_slots = {},
			special_equipment_slots = {}
		}
		Global.player_manager.viewed_content_updates = {}
	end
	Global.player_manager.default_kit = {
		weapon_slots = {"glock_17"},
		equipment_slots = {},
		special_equipment_slots = {"cable_tie"}
	}
	Global.player_manager.synced_bonuses = {}
	Global.player_manager.synced_equipment_possession = {}
	Global.player_manager.synced_deployables = {}
	Global.player_manager.synced_grenades = {}
	Global.player_manager.synced_cable_ties = {}
	Global.player_manager.synced_ammo_info = {}
	Global.player_manager.synced_carry = {}
	Global.player_manager.synced_team_upgrades = {}
	Global.player_manager.synced_vehicle_data = {}
	self._global = Global.player_manager
end

function PlayerManager:_setup_rules()
	self._rules = {no_run = 0}
end

function PlayerManager:aquire_default_upgrades()
	local default_upgrades = tweak_data.skilltree.default_upgrades or {}
	for _, upgrade in ipairs(default_upgrades) do
		if not managers.upgrades:aquired(upgrade, UpgradesManager.AQUIRE_STRINGS[1]) then
			managers.upgrades:aquire_default(upgrade, UpgradesManager.AQUIRE_STRINGS[1])
		end
	end
	for i = 1, PlayerManager.WEAPON_SLOTS do
		if not managers.player:weapon_in_slot(i) then
			self._global.kit.weapon_slots[i] = managers.player:availible_weapons(i)[1]
		end
	end
	self:_verify_equipment_kit(true)
end

function PlayerManager:update(t, dt)
	if self:has_category_upgrade("player", "close_to_hostage_boost") and (not self._hostage_close_to_local_t or t >= self._hostage_close_to_local_t) then
		local local_player = self:local_player()
		self._is_local_close_to_hostage = alive(local_player) and managers.groupai and managers.groupai:state():is_a_hostage_within(local_player:movement():m_pos(), tweak_data.upgrades.hostage_near_player_radius)
		self._hostage_close_to_local_t = t + tweak_data.upgrades.hostage_near_player_check_t
	end
	self:_update_hostage_skills()
end

function PlayerManager:add_listener(key, events, clbk)
	self._listener_holder:add(key, events, clbk)
end

function PlayerManager:remove_listener(key)
	self._listener_holder:remove(key)
end

function PlayerManager:preload()
end

function PlayerManager:_internal_load()
	local player = self:player_unit()
	if not player then
		return
	end
	local secondary = managers.blackmarket:equipped_secondary()
	local secondary_slot = managers.blackmarket:equipped_weapon_slot("secondaries")
	local texture_switches = managers.blackmarket:get_weapon_texture_switches("secondaries", secondary_slot, secondary)
	player:inventory():add_unit_by_factory_name(secondary.factory_id, true, false, secondary.blueprint, texture_switches)
	local primary = managers.blackmarket:equipped_primary()
	if primary then
		local primary_slot = managers.blackmarket:equipped_weapon_slot("primaries")
		local texture_switches = managers.blackmarket:get_weapon_texture_switches("primaries", primary_slot, primary)
		player:inventory():add_unit_by_factory_name(primary.factory_id, false, false, primary.blueprint, texture_switches)
	end
	player:inventory():set_melee_weapon(managers.blackmarket:equipped_melee_weapon())
	local peer_id = managers.network:session():local_peer():id()
	local grenade, amount = managers.blackmarket:equipped_grenade()
	amount = self:has_grenade(peer_id) and self:get_grenade_amount(peer_id) or amount
	self:_set_grenade({
		grenade = grenade,
		amount = math.min(amount, self:get_max_grenades())
	})
	self:_set_body_bags_amount(self._local_player_body_bags or self:total_body_bags())
	if self._respawn then
	else
		self:_add_level_equipment(player)
		for i, name in ipairs(self._global.default_kit.special_equipment_slots) do
			local ok_name = self._global.equipment[name] and name
			if ok_name then
				local upgrade = tweak_data.upgrades.definitions[ok_name]
				if upgrade and (upgrade.slot and upgrade.slot < 2 or not upgrade.slot) then
					self:add_equipment({
						equipment = upgrade.equipment_id,
						silent = true
					})
				end
			end
		end
		for i, name in ipairs(self._global.kit.equipment_slots) do
			local ok_name = self._global.equipment[name] and name or self._global.default_kit.equipment_slots[i]
			if ok_name then
				local upgrade = tweak_data.upgrades.definitions[ok_name]
				if upgrade then
					if upgrade.slot and upgrade.slot < 2 or not upgrade.slot then
						self:add_equipment({
							equipment = upgrade.equipment_id,
							silent = true
						})
						break
					end
					if not upgrade.slot or upgrade.slot == 2 then
					end
				end
			end
			break
		end
	end
end

function PlayerManager:_add_level_equipment(player)
	local id = Global.running_simulation and managers.editor:layer("Level Settings"):get_setting("simulation_level_id")
	id = id ~= "none" and id or nil
	id = id or Global.level_data.level_id
	if not id then
		return
	end
	local equipment = tweak_data.levels[id].equipment
	if not equipment then
		return
	end
	for _, eq in ipairs(equipment) do
		self:add_equipment({equipment = eq, silent = true})
	end
end

function PlayerManager:spawn_dropin_penalty(dead, bleed_out, health, used_deployable, used_cable_ties, used_body_bags)
	local player = self:player_unit()
	print("[PlayerManager:spawn_dropin_penalty]", dead, bleed_out, health, used_deployable, used_cable_ties, used_body_bags)
	if not alive(player) then
		return
	end
	if used_deployable then
		managers.player:clear_equipment()
		local equipped_deployable = Global.player_manager.kit.equipment_slots[1]
		local deployable_data = tweak_data.equipments[equipped_deployable]
		if deployable_data and deployable_data.dropin_penalty_function_name then
			local used_one, redirect = player:equipment()[deployable_data.dropin_penalty_function_name](player:equipment(), self._equipment.selected_index)
			if redirect then
				redirect(player)
			end
		end
	end
	for i = 1, used_cable_ties do
		self:remove_special("cable_tie")
	end
	self:_set_body_bags_amount(math.max(self:total_body_bags() - used_body_bags, 0))
	local min_health
	if dead or bleed_out then
		min_health = 0
	else
		min_health = 0.25
	end
	player:character_damage():set_health(math.max(min_health, health) * player:character_damage():_max_health())
	if dead or bleed_out then
		print("[PlayerManager:spawn_dead] Killing")
		player:network():send("sync_player_movement_state", "dead", player:character_damage():down_time(), player:id())
		managers.groupai:state():on_player_criminal_death(managers.network:session():local_peer():id())
		player:base():set_enabled(false)
		game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
		player:character_damage():set_invulnerable(true)
		player:character_damage():set_health(0)
		player:base():_unregister()
		World:delete_unit(player)
	end
end

function PlayerManager:nr_players()
	return self._nr_players
end

function PlayerManager:set_nr_players(nr)
	self._nr_players = nr
end

function PlayerManager:player_id(unit)
	local id = self._last_id
	for k, player in ipairs(self._players) do
		if player == unit then
			id = k
		end
	end
	return id
end

function PlayerManager:viewport_config()
	local configs = self._viewport_configs[self._last_id]
	if configs then
		return configs[1]
	end
end

function PlayerManager:setup_viewports()
	local configs = self._viewport_configs[self._last_id]
	if configs then
		for k, player in ipairs(self._players) do
		end
	else
		Application:error("Unsupported number of players: " .. tostring(self._last_id))
	end
end

function PlayerManager:player_states()
	local ret = {}
	for k, _ in pairs(self._player_states) do
		table.insert(ret, k)
	end
	return ret
end

function PlayerManager:current_state()
	return self._current_state
end

function PlayerManager:default_player_state()
	return self._DEFAULT_STATE
end

function PlayerManager:current_sync_state()
	return self._current_sync_state
end

function PlayerManager:set_player_state(state)
	state = state or self._current_state
	if state == "standard" and self:get_my_carry_data() then
		state = "carry"
	end
	if state == self._current_state then
		return
	end
	if state ~= "standard" and state ~= "carry" and state ~= "bipod" then
		local unit = self:player_unit()
		if unit then
			unit:character_damage():disable_berserker()
		end
	end
	if (state == "clean" or state == "mask_off" or state == "civilian") and self._current_state ~= "clean" and self._current_state ~= "mask_off" and self._current_state ~= "civilian" then
		managers.groupai:state():calm_ai()
	end
	if not self._player_states[state] then
		Application:error("State '" .. tostring(state) .. "' does not exist in list of available states.")
		state = self._DEFAULT_STATE
	end
	if table.contains(self._sync_states, state) then
		self._current_sync_state = state
	end
	self._current_state = state
	self:_change_player_state()
end

function PlayerManager:spawn_players(position, rotation, state)
	for var = 1, self._nr_players do
		self._last_id = var
	end
	self:spawned_player(self._last_id, safe_spawn_unit(self:player_unit_name(), position, rotation))
	return self._players[1]
end

function PlayerManager:spawned_player(id, unit)
	self._players[id] = unit
	self:setup_viewports()
	self:_internal_load()
	self:_change_player_state()
end

function PlayerManager:_change_player_state()
	local unit = self:player_unit()
	if not unit then
		return
	end
	self._listener_holder:call(self._current_state, unit)
	if game_state_machine:last_queued_state_name() ~= self._player_states[self._current_state] then
		game_state_machine:change_state_by_name(self._player_states[self._current_state])
	end
	unit:movement():change_state(self._current_state)
end

function PlayerManager:player_destroyed(id)
	self._players[id] = nil
	self._respawn = true
end

function PlayerManager:players()
	return self._players
end

function PlayerManager:player_unit_name()
	return self._player_name
end

function PlayerManager:player_unit(id)
	local p_id = id or 1
	return self._players[p_id]
end

function PlayerManager:local_player()
	return self:player_unit()
end

function PlayerManager:warp_to(pos, rot, id)
	local player = self._players[id or 1]
	if alive(player) then
		player:movement():warp_to(pos, rot)
	end
end

function PlayerManager:on_out_of_world()
	local player_unit = managers.player:player_unit()
	if not alive(player_unit) then
		return
	end
	local player_pos = player_unit:position()
	local closest_pos, closest_distance
	for _, data in pairs(managers.groupai:state():all_player_criminals()) do
		if data.unit ~= player_unit then
			local pos = data.unit:position()
			local distance = mvector3.distance(player_pos, pos)
			if not closest_distance or closest_distance > distance then
				closest_distance = distance
				closest_pos = pos
			end
		end
	end
	if closest_pos then
		managers.player:warp_to(closest_pos, player_unit:rotation())
		return
	end
	local pos = player_unit:movement():nav_tracker():field_position()
	managers.player:warp_to(pos, player_unit:rotation())
end

function PlayerManager:aquire_weapon(upgrade, id)
	if self._global.weapons[id] then
		return
	end
	self._global.weapons[id] = upgrade
	local player = self:player_unit()
	if not player then
		return
	end
end

function PlayerManager:unaquire_weapon(upgrade, id)
	self._global.weapons[id] = upgrade
end

function PlayerManager:aquire_melee_weapon(upgrade, id)
end

function PlayerManager:unaquire_melee_weapon(upgrade, id)
end

function PlayerManager:aquire_grenade(upgrade, id)
end

function PlayerManager:unaquire_grenade(upgrade, id)
end

function PlayerManager:_verify_equipment_kit(loading)
	if not managers.player:equipment_in_slot(1) then
		if managers.blackmarket then
			managers.blackmarket:equip_deployable(managers.player:availible_equipment(1)[1], loading)
		else
			self._global.kit.equipment_slots[1] = managers.player:availible_equipment(1)[1]
		end
	end
end

function PlayerManager:aquire_equipment(upgrade, id, loading)
	if self._global.equipment[id] then
		return
	end
	self._global.equipment[id] = upgrade
	if upgrade.aquire then
		managers.upgrades:aquire_default(upgrade.aquire.upgrade, UpgradesManager.AQUIRE_STRINGS[1])
	end
	self:_verify_equipment_kit(loading)
end

function PlayerManager:on_killshot(killed_unit, variant)
	local player_unit = self:player_unit()
	if not player_unit then
		return
	end
	local t = Application:time()
	if self._on_killshot_t and t < self._on_killshot_t then
		return
	end
	local damage_ext = player_unit:character_damage()
	if not CopDamage.is_civilian(killed_unit:base()._tweak_table) then
		local regen_armor_bonus = managers.player:upgrade_value("player", "killshot_regen_armor_bonus", 0)
		local dist_sq = mvector3.distance_sq(player_unit:movement():m_pos(), killed_unit:movement():m_pos())
		local close_combat_sq = tweak_data.upgrades.close_combat_distance * tweak_data.upgrades.close_combat_distance
		if dist_sq <= close_combat_sq then
			regen_armor_bonus = regen_armor_bonus + managers.player:upgrade_value("player", "killshot_close_regen_armor_bonus", 0)
			local panic_chance = managers.player:upgrade_value("player", "killshot_close_panic_chance", 0)
			if 0 < panic_chance or panic_chance == -1 then
				local slotmask = managers.slot:get_mask("enemies")
				local units = World:find_units_quick("sphere", player_unit:movement():m_pos(), tweak_data.upgrades.killshot_close_panic_range, slotmask)
				for e_key, unit in pairs(units) do
					if alive(unit) and unit:character_damage() and not unit:character_damage():dead() then
						unit:character_damage():build_suppression(0, panic_chance)
					end
				end
			end
		end
		if damage_ext and 0 < regen_armor_bonus then
			damage_ext:restore_armor(regen_armor_bonus)
		end
		local regen_health_bonus = 0
		if variant == "melee" then
			regen_health_bonus = regen_health_bonus + managers.player:upgrade_value("player", "melee_kill_life_leech", 0)
		end
		if damage_ext and 0 < regen_health_bonus then
			damage_ext:restore_health(regen_health_bonus)
		end
		self._on_killshot_t = t + (tweak_data.upgrades.on_killshot_cooldown or 0)
	end
end

function PlayerManager:on_damage_dealt(unit, damage_info)
	local player_unit = self:player_unit()
	if not player_unit then
		return
	end
	local t = Application:time()
	self:_check_damage_to_hot(t, unit, damage_info)
	if self._on_damage_dealt_t and t < self._on_damage_dealt_t then
		return
	end
	self._on_damage_dealt_t = t + (tweak_data.upgrades.on_damage_dealt_cooldown or 0)
end

function PlayerManager:on_headshot_dealt()
	local player_unit = self:player_unit()
	if not player_unit then
		return
	end
	local t = Application:time()
	if self._on_headshot_dealt_t and t < self._on_headshot_dealt_t then
		return
	end
	self._on_headshot_dealt_t = t + (tweak_data.upgrades.on_headshot_dealt_cooldown or 0)
	local damage_ext = player_unit:character_damage()
	local regen_armor_bonus = managers.player:upgrade_value("player", "headshot_regen_armor_bonus", 0)
	if damage_ext and 0 < regen_armor_bonus then
		damage_ext:restore_armor(regen_armor_bonus)
	end
end

function PlayerManager:_check_damage_to_hot(t, unit, damage_info)
	local player_unit = self:player_unit()
	if not self:has_category_upgrade("player", "damage_to_hot") then
		return
	end
	if not alive(player_unit) or player_unit:character_damage():need_revive() or player_unit:character_damage():dead() then
		return
	end
	if not (alive(unit) and unit:base()) or not damage_info then
		return
	end
	if damage_info.is_fire_dot_damage then
		return
	end
	local data = tweak_data.upgrades.damage_to_hot_data
	if not data then
		return
	end
	if self._next_allowed_doh_t and t < self._next_allowed_doh_t then
		return
	end
	local add_stack_sources = data.add_stack_sources or {}
	if not add_stack_sources.swat_van and unit:base().sentry_gun then
		return
	elseif not add_stack_sources.civilian and CopDamage.is_civilian(unit:base()._tweak_table) then
		return
	end
	if not add_stack_sources[damage_info.variant] then
		return
	end
	local player_armor = managers.blackmarket:equipped_armor(data.works_with_armor_kit, true)
	if not table.contains(data.armors_allowed or {}, player_armor) then
		return
	end
	player_unit:character_damage():add_damage_to_hot()
	self._next_allowed_doh_t = t + data.stacking_cooldown
end

function PlayerManager:unaquire_equipment(upgrade, id)
	if not self._global.equipment[id] then
		return
	end
	local is_equipped = managers.player:equipment_in_slot(upgrade.slot) == id
	self._global.equipment[id] = nil
	if is_equipped then
		self._global.kit.equipment_slots[upgrade.slot] = nil
		self:_verify_equipment_kit(false)
	end
	if upgrade.aquire then
		managers.upgrades:unaquire(upgrade.aquire.upgrade, UpgradesManager.AQUIRE_STRINGS[1])
	end
end

function PlayerManager:aquire_upgrade(upgrade)
	self._global.upgrades[upgrade.category] = self._global.upgrades[upgrade.category] or {}
	self._global.upgrades[upgrade.category][upgrade.upgrade] = math.max(upgrade.value, self._global.upgrades[upgrade.category][upgrade.upgrade] or 0)
	local value = tweak_data.upgrades.values[upgrade.category][upgrade.upgrade][upgrade.value]
	if self[upgrade.upgrade] then
		self[upgrade.upgrade](self, value)
	end
end

function PlayerManager:unaquire_upgrade(upgrade)
	if not self._global.upgrades[upgrade.category] then
		Application:error("[PlayerManager:unaquire_upgrade] Can't unaquire upgrade of category", upgrade.category)
		return
	end
	if not self._global.upgrades[upgrade.category][upgrade.upgrade] then
		Application:error("[PlayerManager:unaquire_upgrade] Can't unaquire upgrade", upgrade.upgrade)
		return
	end
	self:unaquire_incremental_upgrade(upgrade)
end

function PlayerManager:aquire_incremental_upgrade(upgrade)
	self._global.upgrades[upgrade.category] = self._global.upgrades[upgrade.category] or {}
	local val = self._global.upgrades[upgrade.category][upgrade.upgrade]
	self._global.upgrades[upgrade.category][upgrade.upgrade] = (val or 0) + 1
	local value = tweak_data.upgrades.values[upgrade.category][upgrade.upgrade][self._global.upgrades[upgrade.category][upgrade.upgrade]]
	if self[upgrade.upgrade] then
		self[upgrade.upgrade](self, value)
	end
end

function PlayerManager:unaquire_incremental_upgrade(upgrade)
	if not self._global.upgrades[upgrade.category] then
		Application:error("[PlayerManager:unaquire_incremental_upgrade] Can't unaquire upgrade of category", upgrade.category)
		return
	end
	if not self._global.upgrades[upgrade.category][upgrade.upgrade] then
		Application:error("[PlayerManager:unaquire_incremental_upgrade] Can't unaquire upgrade", upgrade.upgrade)
		return
	end
	local val = self._global.upgrades[upgrade.category][upgrade.upgrade]
	val = val - 1
	self._global.upgrades[upgrade.category][upgrade.upgrade] = 0 < val and val or nil
	if self._global.upgrades[upgrade.category][upgrade.upgrade] then
		local value = tweak_data.upgrades.values[upgrade.category][upgrade.upgrade][self._global.upgrades[upgrade.category][upgrade.upgrade]]
		if self[upgrade.upgrade] then
			self[upgrade.upgrade](self, value)
		end
	end
end

function PlayerManager:upgrade_value(category, upgrade, default)
	if not self._global.upgrades[category] then
		return default or 0
	end
	if not self._global.upgrades[category][upgrade] then
		return default or 0
	end
	local level = self._global.upgrades[category][upgrade]
	local value = tweak_data.upgrades.values[category][upgrade][level]
	return value
end

function PlayerManager:list_level_rewards(dlcs)
	return managers.upgrades:list_level_rewards(dlcs)
end

function PlayerManager:activate_temporary_upgrade(category, upgrade)
	local upgrade_value = self:upgrade_value(category, upgrade)
	if upgrade_value == 0 then
		return
	end
	local time = upgrade_value[2]
	self._temporary_upgrades[category] = self._temporary_upgrades[category] or {}
	self._temporary_upgrades[category][upgrade] = {}
	self._temporary_upgrades[category][upgrade].expire_time = Application:time() + time
end

function PlayerManager:activate_temporary_upgrade_by_level(category, upgrade, level)
	local upgrade_level = self:upgrade_level(category, upgrade, 0) or 0
	if level > upgrade_level then
		return
	end
	local upgrade_value = self:upgrade_value_by_level(category, upgrade, level, 0)
	if upgrade_value == 0 then
		return
	end
	local time = upgrade_value[2]
	self._temporary_upgrades[category] = self._temporary_upgrades[category] or {}
	self._temporary_upgrades[category][upgrade] = {}
	self._temporary_upgrades[category][upgrade].upgrade_value = upgrade_value[1]
	self._temporary_upgrades[category][upgrade].expire_time = Application:time() + time
end

function PlayerManager:deactivate_temporary_upgrade(category, upgrade)
	local upgrade_value = self:upgrade_value(category, upgrade)
	if upgrade_value == 0 then
		return
	end
	if not self._temporary_upgrades[category] then
		return
	end
	self._temporary_upgrades[category][upgrade] = nil
end

function PlayerManager:has_activate_temporary_upgrade(category, upgrade)
	local upgrade_value = self:upgrade_value(category, upgrade)
	if upgrade_value == 0 then
		return false
	end
	if not self._temporary_upgrades[category] then
		return false
	end
	if not self._temporary_upgrades[category][upgrade] then
		return false
	end
	return self._temporary_upgrades[category][upgrade].expire_time > Application:time()
end

function PlayerManager:get_activate_temporary_expire_time(category, upgrade)
	local upgrade_value = self:upgrade_value(category, upgrade)
	if upgrade_value == 0 then
		return 0
	end
	if not self._temporary_upgrades[category] then
		return 0
	end
	if not self._temporary_upgrades[category][upgrade] then
		return 0
	end
	return self._temporary_upgrades[category][upgrade].expire_time or 0
end

function PlayerManager:temporary_upgrade_value(category, upgrade, default)
	local upgrade_value = self:upgrade_value(category, upgrade)
	if upgrade_value == 0 then
		return default or 0
	end
	if not self._temporary_upgrades[category] then
		return default or 0
	end
	if not self._temporary_upgrades[category][upgrade] then
		return default or 0
	end
	if self._temporary_upgrades[category][upgrade].expire_time < Application:time() then
		return default or 0
	end
	if self._temporary_upgrades[category][upgrade].upgrade_value then
		return self._temporary_upgrades[category][upgrade].upgrade_value
	end
	return upgrade_value[1]
end

function PlayerManager:equiptment_upgrade_value(category, upgrade, default)
	if category == "trip_mine" and upgrade == "quantity" then
		return self:upgrade_value(category, "quantity_1", default) + self:upgrade_value(category, "quantity_2", default) + self:upgrade_value(category, "quantity_3", default)
	end
	return self:upgrade_value(category, upgrade, default)
end

function PlayerManager:upgrade_level(category, upgrade, default)
	if not self._global.upgrades[category] then
		return default or 0
	end
	if not self._global.upgrades[category][upgrade] then
		return default or 0
	end
	local level = self._global.upgrades[category][upgrade]
	return level
end

function PlayerManager:upgrade_value_by_level(category, upgrade, level, default)
	return tweak_data.upgrades.values[category][upgrade][level] or default or 0
end

function PlayerManager:equipped_upgrade_value(equipped, category, upgrade)
	if not self:has_category_upgrade(category, upgrade) then
		return 0
	end
	if not table.contains(self._global.kit.equipment_slots, equipped) then
		return 0
	end
	return self:upgrade_value(category, upgrade)
end

function PlayerManager:has_category_upgrade(category, upgrade)
	if not self._global.upgrades[category] then
		return false
	end
	if not self._global.upgrades[category][upgrade] then
		return false
	end
	return true
end

function PlayerManager:body_armor_value(category, override_value, default)
	local armor_data = tweak_data.blackmarket.armors[managers.blackmarket:equipped_armor(true, true)]
	return self:upgrade_value_by_level("player", "body_armor", category, {})[override_value or armor_data.upgrade_level] or default or 0
end

function PlayerManager:get_infamy_exp_multiplier()
	local multiplier = 1
	if managers.experience:current_rank() > 0 then
		for infamy, item in pairs(tweak_data.infamy.items) do
			if managers.infamy:owned(infamy) and item.upgrades and item.upgrades.infamous_xp then
				multiplier = multiplier + math.abs(item.upgrades.infamous_xp - 1)
			end
		end
	end
	return multiplier
end

function PlayerManager:get_skill_exp_multiplier(whisper_mode)
	local multiplier = 1
	multiplier = multiplier + managers.player:upgrade_value("player", "xp_multiplier", 1) - 1
	multiplier = multiplier + managers.player:upgrade_value("player", "passive_xp_multiplier", 1) - 1
	multiplier = multiplier + managers.player:team_upgrade_value("xp", "multiplier", 1) - 1
	if whisper_mode then
		multiplier = multiplier + managers.player:team_upgrade_value("xp", "stealth_multiplier", 1) - 1
	end
	return multiplier
end

function PlayerManager:update_hostage_skills()
	self._hostage_skills_update = true
end

function PlayerManager:_update_hostage_skills()
	if self._hostage_skills_update then
		if self:get_hostage_bonus_multiplier("health") ~= 1 then
			local player_unit = self:player_unit()
			if alive(player_unit) then
				local damage_ext = player_unit:character_damage()
				if damage_ext then
					damage_ext:change_health(0)
				end
			end
		end
		self._hostage_skills_update = nil
	end
end

function PlayerManager:get_hostage_bonus_multiplier(category)
	local hostages = managers.groupai and managers.groupai:state():hostage_count() or 0
	local minions = self:num_local_minions() or 0
	local multiplier = 0
	hostages = hostages + minions
	local hostage_max_num = tweak_data:get_raw_value("upgrades", "hostage_max_num", category)
	if hostage_max_num then
		hostages = math.min(hostages, hostage_max_num)
	end
	multiplier = multiplier + self:team_upgrade_value(category, "hostage_multiplier", 1) - 1
	multiplier = multiplier + self:team_upgrade_value(category, "passive_hostage_multiplier", 1) - 1
	multiplier = multiplier + self:upgrade_value("player", "hostage_" .. category .. "_multiplier", 1) - 1
	multiplier = multiplier + self:upgrade_value("player", "passive_hostage_" .. category .. "_multiplier", 1) - 1
	local local_player = self:local_player()
	if self:has_category_upgrade("player", "close_to_hostage_boost") and self._is_local_close_to_hostage then
		multiplier = multiplier * tweak_data.upgrades.hostage_near_player_multiplier
	end
	return 1 + multiplier * hostages
end

function PlayerManager:get_hostage_bonus_addend(category)
	local hostages = managers.groupai and managers.groupai:state():hostage_count() or 0
	local minions = self:num_local_minions() or 0
	local addend = 0
	hostages = hostages + minions
	local hostage_max_num = tweak_data:get_raw_value("upgrades", "hostage_max_num", category)
	if hostage_max_num then
		hostages = math.min(hostages, hostage_max_num)
	end
	addend = addend + self:team_upgrade_value(category, "hostage_addend", 0)
	addend = addend + self:team_upgrade_value(category, "passive_hostage_addend", 0)
	addend = addend + self:upgrade_value("player", "hostage_" .. category .. "_addend", 0)
	addend = addend + self:upgrade_value("player", "passive_hostage_" .. category .. "_addend", 0)
	local local_player = self:local_player()
	if self:has_category_upgrade("player", "close_to_hostage_boost") and self._is_local_close_to_hostage then
		addend = addend * tweak_data.upgrades.hostage_near_player_multiplier
	end
	return addend * hostages
end

function PlayerManager:movement_speed_multiplier(speed_state, bonus_multiplier, upgrade_level, health_ratio)
	local multiplier = 1
	local armor_penalty = self:mod_movement_penalty(self:body_armor_value("movement", upgrade_level, 1))
	multiplier = multiplier + armor_penalty - 1
	if bonus_multiplier then
		multiplier = multiplier + bonus_multiplier - 1
	end
	if speed_state then
		multiplier = multiplier + self:upgrade_value("player", speed_state .. "_speed_multiplier", 1) - 1
	end
	multiplier = multiplier + self:get_hostage_bonus_multiplier("speed") - 1
	multiplier = multiplier + self:upgrade_value("player", "movement_speed_multiplier", 1) - 1
	if self:num_local_minions() > 0 then
		multiplier = multiplier + self:upgrade_value("player", "minion_master_speed_multiplier", 1) - 1
	end
	if self:has_category_upgrade("player", "secured_bags_speed_multiplier") then
		local bags = 0
		bags = bags + (managers.loot:get_secured_mandatory_bags_amount() or 0)
		bags = bags + (managers.loot:get_secured_bonus_bags_amount() or 0)
		multiplier = multiplier + bags * (self:upgrade_value("player", "secured_bags_speed_multiplier", 1) - 1)
	end
	if managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier") then
		multiplier = multiplier * (tweak_data.upgrades.berserker_movement_speed_multiplier or 1)
	end
	if health_ratio then
		local damage_health_ratio = self:get_damage_health_ratio(health_ratio, "movement_speed")
		multiplier = multiplier * (1 + managers.player:upgrade_value("player", "movement_speed_damage_health_ratio_multiplier", 0) * damage_health_ratio)
	end
	return multiplier
end

function PlayerManager:mod_movement_penalty(movement_penalty)
	local skill_mods = self:upgrade_value("player", "passive_armor_movement_penalty_multiplier", 1)
	if skill_mods < 1 and movement_penalty < 1 then
		local penalty = 1 - movement_penalty
		penalty = penalty * skill_mods
		movement_penalty = 1 - penalty
	end
	return movement_penalty
end

function PlayerManager:body_armor_skill_multiplier(override_armor)
	local multiplier = 1
	multiplier = multiplier + self:upgrade_value("player", "tier_armor_multiplier", 1) - 1
	multiplier = multiplier + self:upgrade_value("player", "passive_armor_multiplier", 1) - 1
	multiplier = multiplier + self:upgrade_value("player", "armor_multiplier", 1) - 1
	multiplier = multiplier + self:team_upgrade_value("armor", "multiplier", 1) - 1
	multiplier = multiplier + self:get_hostage_bonus_multiplier("armor") - 1
	multiplier = multiplier + self:upgrade_value("player", "perk_armor_loss_multiplier", 1) - 1
	multiplier = multiplier + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_armor_multiplier", 1) - 1
	return multiplier
end

function PlayerManager:body_armor_regen_multiplier(moving, health_ratio)
	local multiplier = 1
	multiplier = multiplier * self:upgrade_value("player", "armor_regen_timer_multiplier_tier", 1)
	multiplier = multiplier * self:upgrade_value("player", "armor_regen_timer_multiplier", 1)
	multiplier = multiplier * self:upgrade_value("player", "armor_regen_timer_multiplier_passive", 1)
	multiplier = multiplier * self:team_upgrade_value("armor", "regen_time_multiplier", 1)
	multiplier = multiplier * self:team_upgrade_value("armor", "passive_regen_time_multiplier", 1)
	multiplier = multiplier * self:upgrade_value("player", "perk_armor_regen_timer_multiplier", 1)
	if not moving then
		multiplier = multiplier * managers.player:upgrade_value("player", "armor_regen_timer_stand_still_multiplier", 1)
	end
	if health_ratio then
		local damage_health_ratio = self:get_damage_health_ratio(health_ratio, "armor_regen")
		multiplier = multiplier * (1 - managers.player:upgrade_value("player", "armor_regen_damage_health_ratio_multiplier", 0) * damage_health_ratio)
	end
	return multiplier
end

function PlayerManager:body_armor_skill_addend(override_armor)
	local addend = 0
	addend = addend + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_armor_addend", 0)
	return addend
end

function PlayerManager:skill_dodge_chance(running, crouching, on_zipline, override_armor, detection_risk)
	local chance = self:upgrade_value("player", "passive_dodge_chance", 0)
	chance = chance + self:upgrade_value("player", "tier_dodge_chance", 0)
	if running then
		chance = chance + self:upgrade_value("player", "run_dodge_chance", 0)
	end
	if crouching then
		chance = chance + self:upgrade_value("player", "crouch_dodge_chance", 0)
	end
	if on_zipline then
		chance = chance + self:upgrade_value("player", "on_zipline_dodge_chance", 0)
	end
	local detection_risk_add_dodge_chance = managers.player:upgrade_value("player", "detection_risk_add_dodge_chance")
	chance = chance + self:get_value_from_risk_upgrade(detection_risk_add_dodge_chance, detection_risk)
	chance = chance + self:upgrade_value("player", tostring(override_armor or managers.blackmarket:equipped_armor(true, true)) .. "_dodge_addend", 0)
	return chance
end

function PlayerManager:stamina_multiplier()
	local multiplier = 1
	multiplier = multiplier + self:upgrade_value("player", "stamina_multiplier", 1) - 1
	multiplier = multiplier + self:team_upgrade_value("stamina", "multiplier", 1) - 1
	multiplier = multiplier + self:team_upgrade_value("stamina", "passive_multiplier", 1) - 1
	multiplier = multiplier + self:get_hostage_bonus_multiplier("stamina") - 1
	return multiplier
end

function PlayerManager:critical_hit_chance()
	local multiplier = 0
	multiplier = multiplier + self:upgrade_value("player", "critical_hit_chance", 0)
	multiplier = multiplier + self:upgrade_value("weapon", "critical_hit_chance", 0)
	multiplier = multiplier + self:team_upgrade_value("critical_hit", "chance", 0)
	multiplier = multiplier + self:get_hostage_bonus_multiplier("critical_hit") - 1
	local detection_risk_add_crit_chance = managers.player:upgrade_value("player", "detection_risk_add_crit_chance")
	multiplier = multiplier + self:get_value_from_risk_upgrade(detection_risk_add_crit_chance)
	return multiplier
end

function PlayerManager:get_value_from_risk_upgrade(risk_upgrade, detection_risk)
	local risk_value = 0
	if not detection_risk then
		detection_risk = managers.blackmarket:get_suspicion_offset_of_local(tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
		detection_risk = math.round(detection_risk * 100)
	end
	if risk_upgrade and type(risk_upgrade) == "table" then
		local value = risk_upgrade[1]
		local step = risk_upgrade[2]
		local operator = risk_upgrade[3]
		local threshold = risk_upgrade[4]
		local cap = risk_upgrade[5]
		local num_steps = 0
		if operator == "above" then
			num_steps = math.max(math.floor((detection_risk - threshold) / step), 0)
		elseif operator == "below" then
			num_steps = math.max(math.floor((threshold - detection_risk) / step), 0)
		end
		risk_value = num_steps * value
		risk_value = cap and math.min(cap, risk_value) or risk_value
	end
	return risk_value
end

function PlayerManager:health_skill_multiplier()
	local multiplier = 1
	multiplier = multiplier + self:upgrade_value("player", "health_multiplier", 1) - 1
	multiplier = multiplier + self:upgrade_value("player", "passive_health_multiplier", 1) - 1
	multiplier = multiplier + self:team_upgrade_value("health", "passive_multiplier", 1) - 1
	multiplier = multiplier + self:get_hostage_bonus_multiplier("health") - 1
	if self:num_local_minions() > 0 then
		multiplier = multiplier + self:upgrade_value("player", "minion_master_health_multiplier", 1) - 1
	end
	return multiplier
end

function PlayerManager:health_regen()
	local health_regen = tweak_data.player.damage.HEALTH_REGEN
	health_regen = health_regen + self:temporary_upgrade_value("temporary", "wolverine_health_regen", 0)
	health_regen = health_regen + self:get_hostage_bonus_addend("health_regen")
	health_regen = health_regen + self:upgrade_value("player", "passive_health_regen", 0)
	return health_regen
end

function PlayerManager:max_health()
	local base_health = PlayerDamage._HEALTH_INIT
	local health = (base_health + self:thick_skin_value()) * self:health_skill_multiplier()
	return health
end

function PlayerManager:damage_reduction_skill_multiplier(damage_type, current_state, enemy_type)
	local multiplier = 1
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered_strong", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "dmg_dampener_close_contact", 1)
	multiplier = multiplier * self:upgrade_value("player", "damage_dampener", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "first_aid_damage_reduction", 1)
	multiplier = multiplier * self:temporary_upgrade_value("temporary", "passive_revive_damage_reduction", 1)
	multiplier = multiplier * self:get_hostage_bonus_multiplier("damage_dampener")
	if damage_type == "melee" then
		multiplier = multiplier * managers.player:upgrade_value("player", "melee_damage_dampener", 1)
	end
	if current_state and current_state:_interacting() then
		multiplier = multiplier * managers.player:upgrade_value("player", "interacting_damage_multiplier", 1)
	end
	if CopDamage and CopDamage.is_gangster(enemy_type) then
		multiplier = multiplier * managers.player:upgrade_value("player", "gangster_damage_dampener", 1)
	end
	return multiplier
end

function PlayerManager:thick_skin_value()
	if not self:has_category_upgrade("player", "thick_skin") then
		return 0
	end
	if not table.contains(self._global.kit.equipment_slots, "thick_skin") then
		return 0
	end
	return self:upgrade_value("player", "thick_skin")
end

function PlayerManager:toolset_value()
	if not self:has_category_upgrade("player", "toolset") then
		return 1
	end
	if not table.contains(self._global.kit.equipment_slots, "toolset") then
		return 1
	end
	return self:upgrade_value("player", "toolset")
end

function PlayerManager:inspect_current_upgrades()
	for name, upgrades in pairs(self._global.upgrades) do
		print("Weapon " .. name .. ":")
		for upgrade, level in pairs(upgrades) do
			print("Upgrade:", upgrade, "is at level", level, "and has value", string.format("%.2f", tweak_data.upgrades.values[name][upgrade][level]))
		end
		print("\n")
	end
end

function PlayerManager:spread_multiplier()
	if not alive(self:player_unit()) then
		return
	end
	self:player_unit():movement()._current_state:_update_crosshair_offset()
end

function PlayerManager:weapon_upgrade_progress(weapon_id)
	local current = 0
	local total = 0
	if self._global.upgrades[weapon_id] then
		for upgrade, value in pairs(self._global.upgrades[weapon_id]) do
			current = current + value
		end
	end
	if tweak_data.upgrades.values[weapon_id] then
		for _, values in pairs(tweak_data.upgrades.values[weapon_id]) do
			total = total + #values
		end
	end
	return current, total
end

function PlayerManager:equipment_upgrade_progress(equipment_id)
	local current = 0
	local total = 0
	if tweak_data.upgrades.values[equipment_id] then
		if self._global.upgrades[equipment_id] then
			for upgrade, value in pairs(self._global.upgrades[equipment_id]) do
				current = current + value
			end
		end
		for _, values in pairs(tweak_data.upgrades.values[equipment_id]) do
			total = total + #values
		end
		return current, total
	end
	if tweak_data.upgrades.values.player[equipment_id] then
		if self._global.upgrades.player and self._global.upgrades.player[equipment_id] then
			current = self._global.upgrades.player[equipment_id]
		end
		total = #tweak_data.upgrades.values.player[equipment_id]
		return current, total
	end
	if tweak_data.upgrades.definitions[equipment_id] and tweak_data.upgrades.definitions[equipment_id].aquire then
		local upgrade = tweak_data.upgrades.definitions[tweak_data.upgrades.definitions[equipment_id].aquire.upgrade]
		return self:equipment_upgrade_progress(upgrade.upgrade.upgrade)
	end
	return current, total
end

function PlayerManager:has_weapon(name)
	return managers.player._global.weapons[name]
end

function PlayerManager:has_aquired_equipment(name)
	return managers.player._global.equipment[name]
end

function PlayerManager:availible_weapons(slot)
	local weapons = {}
	for name, _ in pairs(managers.player._global.weapons) do
		if not slot or slot and tweak_data.weapon[name].use_data.selection_index == slot then
			table.insert(weapons, name)
		end
	end
	return weapons
end

function PlayerManager:weapon_in_slot(slot)
	local weapon = self._global.kit.weapon_slots[slot]
	if self._global.weapons[weapon] then
		return weapon
	end
	local weapon = self._global.default_kit.weapon_slots[slot]
	return self._global.weapons[weapon] and weapon
end

function PlayerManager:availible_equipment(slot)
	local equipment = {}
	for name, _ in pairs(self._global.equipment) do
		if not slot or slot and tweak_data.upgrades.definitions[name].slot == slot then
			table.insert(equipment, name)
		end
	end
	return equipment
end

function PlayerManager:equipment_in_slot(slot)
	return self._global.kit.equipment_slots[slot]
end

function PlayerManager:toggle_player_rule(rule)
	self._rules[rule] = not self._rules[rule]
	if rule == "no_run" and self._rules[rule] then
		local player = self:player_unit()
		if player:movement():current_state()._interupt_action_running then
			player:movement():current_state():_interupt_action_running(Application:time())
		end
	end
end

function PlayerManager:set_player_rule(rule, value)
	self._rules[rule] = self._rules[rule] + (value and 1 or -1)
	if rule == "no_run" and self:get_player_rule(rule) then
		local player = self:player_unit()
		if player:movement():current_state()._interupt_action_running then
			player:movement():current_state():_interupt_action_running(Application:time())
		end
	end
end

function PlayerManager:get_player_rule(rule)
	return self._rules[rule] > 0
end

function PlayerManager:update_deployable_equipment_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_deployables[peer_id] then
		local deployable = self._global.synced_deployables[peer_id].deployable
		local amount = self._global.synced_deployables[peer_id].amount
		peer:send_queued_sync("sync_deployable_equipment", deployable, amount)
	end
end

function PlayerManager:update_deployable_equipment_amount_to_peers(equipment, amount)
	local peer = managers.network:session():local_peer()
	managers.network:session():send_to_peers_synched("sync_deployable_equipment", equipment, amount)
	self:set_synced_deployable_equipment(peer, equipment, amount)
end

function PlayerManager:set_synced_deployable_equipment(peer, deployable, amount)
	local peer_id = peer:id()
	local only_update_amount = self._global.synced_deployables[peer_id] and self._global.synced_deployables[peer_id].deployable == deployable
	self._global.synced_deployables[peer_id] = {deployable = deployable, amount = amount}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		local icon = tweak_data.equipments[deployable].icon
		if only_update_amount then
			managers.hud:set_teammate_deployable_equipment_amount(character_data.panel_id, 1, {icon = icon, amount = amount})
		else
			managers.hud:set_deployable_equipment(character_data.panel_id, {icon = icon, amount = amount})
		end
	end
	local local_peer_id = managers.network:session():local_peer():id()
	if peer_id ~= local_peer_id then
		local unit = peer:unit()
		if alive(unit) then
			unit:movement():set_visual_deployable_equipment(deployable, amount)
		end
	end
end

function PlayerManager:get_synced_deployable_equipment(peer_id)
	return self._global.synced_deployables[peer_id]
end

function PlayerManager:update_cable_ties_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_cable_ties[peer_id] then
		local amount = self._global.synced_cable_ties[peer_id].amount
		peer:send_queued_sync("sync_cable_ties", amount)
	end
end

function PlayerManager:update_synced_cable_ties_to_peers(amount)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers_synched("sync_cable_ties", amount)
	self:set_synced_cable_ties(peer_id, amount)
end

function PlayerManager:set_synced_cable_ties(peer_id, amount)
	local only_update_amount = false
	if self._global.synced_cable_ties[peer_id] and amount < self._global.synced_cable_ties[peer_id].amount and managers.network:session() and managers.network:session():peer(peer_id) then
		local peer = managers.network:session():peer(peer_id)
		peer:on_used_cable_tie()
	end
	self._global.synced_cable_ties[peer_id] = {amount = amount}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		local icon = tweak_data.equipments.specials.cable_tie.icon
		if only_update_amount then
			managers.hud:set_cable_ties_amount(character_data.panel_id, amount)
		else
			managers.hud:set_cable_tie(character_data.panel_id, {icon = icon, amount = amount})
		end
	end
end

function PlayerManager:get_synced_cable_ties(peer_id)
	return self._global.synced_cable_ties[peer_id]
end

function PlayerManager:update_ammo_info_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_ammo_info[peer_id] then
		for selection_index, ammo_info in pairs(self._global.synced_ammo_info[peer_id]) do
			peer:send_queued_sync("sync_ammo_amount", selection_index, unpack(ammo_info))
		end
	end
end

function PlayerManager:update_synced_ammo_info_to_peers(selection_index, max_clip, current_clip, current_left, max)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers_synched("sync_ammo_amount", selection_index, max_clip, current_clip, current_left, max)
	self:set_synced_ammo_info(peer_id, selection_index, max_clip, current_clip, current_left, max)
end

function PlayerManager:set_synced_ammo_info(peer_id, selection_index, max_clip, current_clip, current_left, max)
	self._global.synced_ammo_info[peer_id] = self._global.synced_ammo_info[peer_id] or {}
	self._global.synced_ammo_info[peer_id][selection_index] = {
		max_clip,
		current_clip,
		current_left,
		max
	}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_ammo_amount(character_data.panel_id, selection_index, max_clip, current_clip, current_left, max)
	end
end

function PlayerManager:get_synced_ammo_info(peer_id)
	return self._global.synced_ammo_info[peer_id]
end

function PlayerManager:update_carry_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_carry[peer_id] then
		local carry_id = self._global.synced_carry[peer_id].carry_id
		local multiplier = self._global.synced_carry[peer_id].multiplier
		local dye_initiated = self._global.synced_carry[peer_id].dye_initiated
		local has_dye_pack = self._global.synced_carry[peer_id].has_dye_pack
		local dye_value_multiplier = self._global.synced_carry[peer_id].dye_value_multiplier
		peer:send_queued_sync("sync_carry", carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	end
end

function PlayerManager:update_synced_carry_to_peers(carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	local peer = managers.network:session():local_peer()
	managers.network:session():send_to_peers_synched("sync_carry", carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	self:set_synced_carry(peer, carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
end

function PlayerManager:set_synced_carry(peer, carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	local peer_id = peer:id()
	self._global.synced_carry[peer_id] = {
		carry_id = carry_id,
		multiplier = multiplier,
		dye_initiated = dye_initiated,
		has_dye_pack = has_dye_pack,
		dye_value_multiplier = dye_value_multiplier
	}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_carry_info(character_data.panel_id, carry_id, managers.loot:get_real_value(carry_id, multiplier))
	end
	managers.hud:set_name_label_carry_info(peer_id, carry_id, managers.loot:get_real_value(carry_id, multiplier))
	local local_peer_id = managers.network:session():local_peer():id()
	if peer_id ~= local_peer_id then
		local unit = peer:unit()
		if alive(unit) then
			unit:movement():set_visual_carry(carry_id)
		end
	end
end

function PlayerManager:set_carry_approved(peer)
	self._global.synced_carry[peer:id()].approved = true
end

function PlayerManager:update_removed_synced_carry_to_peers()
	local peer = managers.network:session():local_peer()
	managers.network:session():send_to_peers_synched("sync_remove_carry")
	self:remove_synced_carry(peer)
end

function PlayerManager:remove_synced_carry(peer)
	local peer_id = peer:id()
	if not self._global.synced_carry[peer_id] then
		return
	end
	self._global.synced_carry[peer_id] = nil
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:remove_teammate_carry_info(character_data.panel_id)
	end
	managers.hud:remove_name_label_carry_info(peer_id)
	local local_peer_id = managers.network:session():local_peer():id()
	if peer_id ~= local_peer_id then
		local unit = peer:unit()
		if alive(unit) then
			unit:movement():set_visual_carry(nil)
		end
	end
end

function PlayerManager:get_my_carry_data()
	local peer_id = managers.network:session():local_peer():id()
	return self._global.synced_carry[peer_id]
end

function PlayerManager:get_synced_carry(peer_id)
	return self._global.synced_carry[peer_id]
end

function PlayerManager:from_server_interaction_reply(status)
	self:player_unit():movement():set_carry_restriction(false)
	if not status then
		self:clear_carry()
	end
end

function PlayerManager:get_all_synced_carry()
	return self._global.synced_carry
end

function PlayerManager:aquire_team_upgrade(upgrade)
	self._global.team_upgrades[upgrade.category] = self._global.team_upgrades[upgrade.category] or {}
	self._global.team_upgrades[upgrade.category][upgrade.upgrade] = upgrade.value
end

function PlayerManager:unaquire_team_upgrade(upgrade)
	if not self._global.team_upgrades[upgrade.category] then
		Application:error("[PlayerManager:unaquire_team_upgrade] Can't unaquire team upgrade of category", upgrade.category)
		return
	end
	if not self._global.team_upgrades[upgrade.category][upgrade.upgrade] then
		Application:error("[PlayerManager:unaquire_team_upgrade] Can't unaquire team upgrade", upgrade.upgrade)
		return
	end
	local val = self._global.team_upgrades[upgrade.category][upgrade.upgrade]
	val = val - 1
	self._global.team_upgrades[upgrade.category][upgrade.upgrade] = 0 < val and val or nil
end

function PlayerManager:team_upgrade_value(category, upgrade, default)
	for peer_id, categories in pairs(self._global.synced_team_upgrades) do
		if categories[category] and categories[category][upgrade] then
			local level = categories[category][upgrade]
			return tweak_data.upgrades.values.team[category][upgrade][level]
		end
	end
	if not self._global.team_upgrades[category] then
		return default or 0
	end
	if not self._global.team_upgrades[category][upgrade] then
		return default or 0
	end
	local level = self._global.team_upgrades[category][upgrade]
	local value = tweak_data.upgrades.values.team[category][upgrade][level]
	return value
end

function PlayerManager:has_team_category_upgrade(category, upgrade)
	for peer_id, categories in pairs(self._global.synced_team_upgrades) do
		if categories[category] and categories[category][upgrade] then
			return true
		end
	end
	if not self._global.team_upgrades[category] then
		return false
	end
	if not self._global.team_upgrades[category][upgrade] then
		return false
	end
	return true
end

function PlayerManager:update_team_upgrades_to_peers()
	for category, upgrades in pairs(self._global.team_upgrades) do
		for upgrade, level in pairs(upgrades) do
			managers.network:session():send_to_peers_synched("add_synced_team_upgrade", category, upgrade, level)
		end
	end
end

function PlayerManager:update_team_upgrades_to_peer(peer)
	for category, upgrades in pairs(self._global.team_upgrades) do
		for upgrade, level in pairs(upgrades) do
			peer:send_queued_sync("add_synced_team_upgrade", category, upgrade, level)
		end
	end
end

function PlayerManager:add_synced_team_upgrade(peer_id, category, upgrade, level)
	self._global.synced_team_upgrades[peer_id] = self._global.synced_team_upgrades[peer_id] or {}
	self._global.synced_team_upgrades[peer_id][category] = self._global.synced_team_upgrades[peer_id][category] or {}
	self._global.synced_team_upgrades[peer_id][category][upgrade] = level
end

function PlayerManager:remove_equipment_possession(peer_id, equipment)
	if not self._global.synced_equipment_possession[peer_id] then
		return
	end
	self._global.synced_equipment_possession[peer_id][equipment] = nil
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:remove_teammate_special_equipment(character_data.panel_id, equipment)
	end
end

function PlayerManager:get_synced_equipment_possession(peer_id)
	return self._global.synced_equipment_possession[peer_id]
end

function PlayerManager:update_equipment_possession_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_equipment_possession[peer_id] then
		for name, amount in pairs(self._global.synced_equipment_possession[peer_id]) do
			peer:send_queued_sync("sync_equipment_possession", peer_id, name, amount)
		end
	end
end

function PlayerManager:update_equipment_possession_to_peers(equipment, amount)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers_synched("sync_equipment_possession", peer_id, equipment, amount or 1)
	self:set_synced_equipment_possession(peer_id, equipment, amount)
end

function PlayerManager:set_synced_equipment_possession(peer_id, equipment, amount)
	local only_update_amount = self._global.synced_equipment_possession[peer_id] and self._global.synced_equipment_possession[peer_id][equipment]
	self._global.synced_equipment_possession[peer_id] = self._global.synced_equipment_possession[peer_id] or {}
	self._global.synced_equipment_possession[peer_id][equipment] = amount or 1
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		local equipment_data = tweak_data.equipments.specials[equipment]
		local icon = equipment_data.icon
		if only_update_amount then
			managers.hud:set_teammate_special_equipment_amount(character_data.panel_id, equipment, amount)
		else
			managers.hud:add_teammate_special_equipment(character_data.panel_id, {
				id = equipment,
				icon = icon,
				amount = amount
			})
		end
	end
end

function PlayerManager:transfer_special_equipment(peer_id, include_custody)
	if self._global.synced_equipment_possession[peer_id] then
		local local_peer = managers.network:session():local_peer()
		local local_peer_id = local_peer:id()
		local peers = {}
		local peers_loadout = {}
		local peers_custody = {}
		if local_peer_id ~= peer_id then
			if not local_peer:waiting_for_player_ready() then
				table.insert(peers_loadout, local_peer)
			elseif managers.trade:is_peer_in_custody(local_peer:id()) then
				if include_custody then
					table.insert(peers_custody, local_peer)
				end
			else
				table.insert(peers, local_peer)
			end
		end
		for _, peer in pairs(managers.network:session():peers()) do
			if peer:id() ~= peer_id then
				if not peer:waiting_for_player_ready() then
					table.insert(peers_loadout, peer)
				elseif managers.trade:is_peer_in_custody(peer:id()) then
					if include_custody then
						table.insert(peers_custody, peer)
					end
				elseif peer:is_host() then
					table.insert(peers, 1, peer)
				else
					table.insert(peers, peer)
				end
			end
		end
		peers = table.list_add(peers, peers_loadout)
		peers = table.list_add(peers, peers_custody)
		for name, amount in pairs(self._global.synced_equipment_possession[peer_id]) do
			local equipment_data = tweak_data.equipments.specials[name]
			if equipment_data and not equipment_data.avoid_tranfer then
				local equipment_lost = true
				local amount_to_transfer = amount
				local max_amount = equipment_data.transfer_quantity or 1
				for _, p in ipairs(peers) do
					local id = p:id()
					local peer_amount = self._global.synced_equipment_possession[id] and self._global.synced_equipment_possession[id][name] or 0
					if max_amount > peer_amount then
						local transfer_amount = math.min(amount_to_transfer, max_amount - peer_amount)
						amount_to_transfer = amount_to_transfer - transfer_amount
						if Network:is_server() then
							if id == local_peer_id then
								managers.player:add_special({
									name = name,
									amount = transfer_amount,
									transfer = true
								})
							else
								p:send("give_equipment", name, transfer_amount, true)
							end
						end
						if amount_to_transfer == 0 then
							equipment_lost = false
							break
						end
					end
				end
				if peer_id == local_peer_id then
					for i = 1, amount - amount_to_transfer do
						self:remove_special(name)
					end
				end
				if equipment_lost and name == "evidence" then
					managers.mission:call_global_event("equipment_evidence_lost")
				end
			end
		end
	end
end

function PlayerManager:peer_dropped_out(peer)
	local peer_id = peer:id()
	if Network:is_server() then
		self:transfer_special_equipment(peer_id, true)
		if self._global.synced_carry[peer_id] and self._global.synced_carry[peer_id].approved then
			local carry_id = self._global.synced_carry[peer_id].carry_id
			local carry_multiplier = self._global.synced_carry[peer_id].multiplier
			local dye_initiated = self._global.synced_carry[peer_id].dye_initiated
			local has_dye_pack = self._global.synced_carry[peer_id].has_dye_pack
			local dye_value_multiplier = self._global.synced_carry[peer_id].dye_value_multiplier
			local peer_unit = peer:unit()
			local position = Vector3()
			if alive(peer_unit) then
				if peer_unit:movement():zipline_unit() then
					position = peer_unit:movement():zipline_unit():position()
				else
					position = peer_unit:position()
				end
			end
			local dir = Vector3(0, 0, 0)
			self:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, Rotation(), dir, 0, nil, peer)
		end
	end
	self._global.synced_equipment_possession[peer_id] = nil
	self._global.synced_deployables[peer_id] = nil
	self._global.synced_cable_ties[peer_id] = nil
	self._global.synced_grenades[peer_id] = nil
	self._global.synced_ammo_info[peer_id] = nil
	self._global.synced_carry[peer_id] = nil
	self._global.synced_team_upgrades[peer_id] = nil
	local peer_unit = peer:unit()
	managers.vehicle:remove_player_from_all_vehicles(peer_unit)
end

function PlayerManager:add_equipment(params)
	if tweak_data.equipments[params.equipment or params.name] then
		self:_add_equipment(params)
		return
	end
	if tweak_data.equipments.specials[params.equipment or params.name] then
		self:add_special(params)
		return
	end
	Application:error("No equipment or special equipment named", params.equipment or params.name)
end

function PlayerManager:_add_equipment(params)
	if self:has_equipment(params.equipment) then
		print("Allready have equipment", params.equipment)
		return
	end
	local equipment = params.equipment
	local tweak_data = tweak_data.equipments[equipment]
	local amount = params.amount or (tweak_data.quantity or 0) + self:equiptment_upgrade_value(equipment, "quantity")
	local icon = params.icon or tweak_data and tweak_data.icon
	local use_function_name = params.use_function_name or tweak_data and tweak_data.use_function_name
	local use_function = use_function_name or nil
	table.insert(self._equipment.selections, {
		equipment = equipment,
		amount = Application:digest_value(0, true),
		use_function = use_function,
		action_timer = tweak_data.action_timer
	})
	self._equipment.selected_index = self._equipment.selected_index or 1
	self:update_deployable_equipment_amount_to_peers(equipment, amount)
	managers.hud:add_item({amount = amount, icon = icon})
	self:add_equipment_amount(equipment, amount)
end

function PlayerManager:add_equipment_amount(equipment, amount)
	local data, index = self:equipment_data_by_name(equipment)
	if data then
		local new_amount = Application:digest_value(data.amount, false) + amount
		data.amount = Application:digest_value(new_amount, true)
		managers.hud:set_item_amount(index, new_amount)
	end
end

function PlayerManager:set_equipment_amount(equipment, amount)
	local data, index = self:equipment_data_by_name(equipment)
	if data then
		local new_amount = amount
		data.amount = Application:digest_value(new_amount, true)
		managers.hud:set_item_amount(index, new_amount)
	end
end

function PlayerManager:equipment_data_by_name(equipment)
	for i, equipments in ipairs(self._equipment.selections) do
		if equipments.equipment == equipment then
			return equipments, i
		end
	end
	return nil
end

function PlayerManager:get_equipment_amount(equipment)
	for i, equipments in ipairs(self._equipment.selections) do
		if equipments.equipment == equipment then
			return Application:digest_value(equipments.amount, false)
		end
	end
	return 0
end

function PlayerManager:has_equipment(equipment)
	for i, equipments in ipairs(self._equipment.selections) do
		if equipments.equipment == equipment then
			return true
		end
	end
	return false
end

function PlayerManager:has_deployable_left(equipment)
	return self:get_equipment_amount(equipment) > 0
end

function PlayerManager:select_next_item()
	if not self._equipment.selected_index then
		return
	end
	self._equipment.selected_index = self._equipment.selected_index + 1 <= #self._equipment.selections and self._equipment.selected_index + 1 or 1
end

function PlayerManager:select_previous_item()
	if not self._equipment.selected_index then
		return
	end
	self._equipment.selected_index = 1 <= self._equipment.selected_index - 1 and self._equipment.selected_index - 1 or #self._equipment.selections
end

function PlayerManager:clear_equipment()
	for i, equipment in ipairs(self._equipment.selections) do
		equipment.amount = Application:digest_value(0, true)
		managers.hud:set_item_amount(i, 0)
		self:update_deployable_equipment_amount_to_peers(equipment.equipment, 0)
	end
end

function PlayerManager:from_server_equipment_place_result(selected_index, unit)
	if alive(unit) then
		unit:equipment():from_server_sentry_gun_place_result(selected_index ~= 0)
	end
	local equipment = self._equipment.selections[selected_index]
	if not equipment then
		return
	end
	local new_amount = Application:digest_value(equipment.amount, false) - 1
	equipment.amount = Application:digest_value(new_amount, true)
	local equipments_available = self._global.equipment or {}
	if managers.player:has_category_upgrade("player", "carry_sentry_and_trip") and equipments_available.sentry_gun and equipments_available.trip_mine and new_amount == 0 then
		if equipment.equipment == "trip_mine" and not self:has_equipment("sentry_gun") then
			self:add_equipment({equipment = "sentry_gun"})
			self:select_next_item()
			return
		elseif equipment.equipment == "sentry_gun" and not self:has_equipment("trip_mine") then
			self:add_equipment({equipment = "trip_mine"})
			self:select_next_item()
			return
		end
	end
	managers.hud:set_item_amount(self._equipment.selected_index, new_amount)
	self:update_deployable_equipment_amount_to_peers(equipment.equipment, new_amount)
end

function PlayerManager:can_use_selected_equipment(unit)
	local equipment = self._equipment.selections[self._equipment.selected_index]
	if not equipment or Application:digest_value(equipment.amount, false) == 0 then
		return false
	end
	return true
end

function PlayerManager:selected_equipment()
	local equipment = self._equipment.selections[self._equipment.selected_index]
	if not equipment or Application:digest_value(equipment.amount, false) == 0 then
		return nil
	end
	return equipment
end

function PlayerManager:selected_equipment_id()
	local equipment_data = self:selected_equipment()
	if not equipment_data then
		return nil
	end
	return equipment_data.equipment
end

function PlayerManager:selected_equipment_name()
	local equipment_data = self:selected_equipment()
	if not equipment_data then
		return ""
	end
	return managers.localization:text(tweak_data.equipments[equipment_data.equipment].text_id or "")
end

function PlayerManager:selected_equipment_limit_movement()
	local equipment_data = self:selected_equipment()
	if not equipment_data then
		return false
	end
	return tweak_data.equipments[equipment_data.equipment].limit_movement or false
end

function PlayerManager:selected_equipment_deploying_text()
	local equipment_data = self:selected_equipment()
	if not equipment_data or not tweak_data.equipments[equipment_data.equipment].deploying_text_id then
		return false
	end
	return managers.localization:text(tweak_data.equipments[equipment_data.equipment].deploying_text_id)
end

function PlayerManager:selected_equipment_sound_start()
	local equipment_data = self:selected_equipment()
	if not equipment_data then
		return false
	end
	return tweak_data.equipments[equipment_data.equipment].sound_start or false
end

function PlayerManager:selected_equipment_sound_interupt()
	local equipment_data = self:selected_equipment()
	if not equipment_data then
		return false
	end
	return tweak_data.equipments[equipment_data.equipment].sound_interupt or false
end

function PlayerManager:selected_equipment_sound_done()
	local equipment_data = self:selected_equipment()
	if not equipment_data then
		return false
	end
	return tweak_data.equipments[equipment_data.equipment].sound_done or false
end

function PlayerManager:use_selected_equipment(unit)
	local equipment = self._equipment.selections[self._equipment.selected_index]
	if not equipment or Application:digest_value(equipment.amount, false) == 0 then
		return
	end
	local used_one = false
	local redirect
	if equipment.use_function then
		used_one, redirect = unit:equipment()[equipment.use_function](unit:equipment(), self._equipment.selected_index)
	else
		used_one = true
	end
	if used_one then
		self:remove_equipment(equipment.equipment)
		if redirect then
			redirect(unit)
		end
	end
	return {
		expire_timer = equipment.action_timer,
		redirect = redirect
	}
end

function PlayerManager:check_selected_equipment_placement_valid(player)
	local equipment_data = managers.player:selected_equipment()
	if not equipment_data then
		return false
	end
	if equipment_data.equipment == "trip_mine" or equipment_data.equipment == "ecm_jammer" then
		return player:equipment():valid_look_at_placement(tweak_data.equipments[equipment_data.equipment]) and true or false
	elseif equipment_data.equipment == "sentry_gun" or equipment_data.equipment == "ammo_bag" or equipment_data.equipment == "doctor_bag" or equipment_data.equipment == "first_aid_kit" or equipment_data.equipment == "bodybags_bag" then
		return player:equipment():valid_shape_placement(equipment_data.equipment, tweak_data.equipments[equipment_data.equipment]) and true or false
	elseif equipment_data.equipment == "armor_kit" then
		return true
	end
	return player:equipment():valid_placement(tweak_data.equipments[equipment_data.equipment]) and true or false
end

function PlayerManager:selected_equipment_deploy_timer()
	local equipment_data = managers.player:selected_equipment()
	if not equipment_data then
		return 0
	end
	local equipment_tweak_data = tweak_data.equipments[equipment_data.equipment]
	local multiplier = 1
	if equipment_tweak_data.upgrade_deploy_time_multiplier then
		multiplier = managers.player:upgrade_value(equipment_tweak_data.upgrade_deploy_time_multiplier.category, equipment_tweak_data.upgrade_deploy_time_multiplier.upgrade, 1)
	end
	return (equipment_tweak_data.deploy_time or 1) * multiplier
end

function PlayerManager:remove_equipment(equipment_id)
	local equipment, index = self:equipment_data_by_name(equipment_id)
	local new_amount = Application:digest_value(equipment.amount, false) - 1
	equipment.amount = Application:digest_value(new_amount, true)
	local equipments_available = self._global.equipment or {}
	if managers.player:has_category_upgrade("player", "carry_sentry_and_trip") and equipments_available.sentry_gun and equipments_available.trip_mine and new_amount == 0 then
		if equipment.equipment == "trip_mine" and not self:has_equipment("sentry_gun") then
			self:add_equipment({equipment = "sentry_gun"})
			self:select_next_item()
			return
		elseif equipment.equipment == "sentry_gun" and not self:has_equipment("trip_mine") then
			self:add_equipment({equipment = "trip_mine"})
			self:select_next_item()
			return
		end
	end
	managers.hud:set_item_amount(index, new_amount)
	self:update_deployable_equipment_amount_to_peers(equipment.equipment, new_amount)
end

function PlayerManager:verify_equipment(peer_id, equipment_id)
	if peer_id == 0 then
		local id = "asset_" .. tostring(equipment_id)
		self._asset_equipment = self._asset_equipment or {}
		if not tweak_data.equipments.max_amount[id] or self._asset_equipment[id] and self._asset_equipment[id] + 1 > tweak_data.equipments.max_amount[id] then
			local peer = managers.network:session():server_peer()
			peer:mark_cheater(VoteManager.REASON.many_assets)
			return false
		end
		self._asset_equipment[id] = (self._asset_equipment[id] or 0) + 1
		return true
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return false
	end
	return peer:verify_deployable(equipment_id)
end

function PlayerManager:verify_grenade(peer_id)
	if not managers.network:session() then
		return true
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return false
	end
	return peer:verify_grenade(1)
end

function PlayerManager:register_grenade(peer_id)
	if not managers.network:session() then
		return true
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return false
	end
	return peer:verify_grenade(-1)
end

function PlayerManager:verify_carry(peer, carry_id)
	if Network:is_client() or not managers.network:session() then
		return true
	end
	if not peer then
		if Network:is_server() then
			return true
		end
		local level_id = managers.job:current_level_id()
		local amount_bags = tweak_data.levels[level_id] and tweak_data.levels[level_id].max_bags or 20
		self._total_bags = self._total_bags and self._total_bags + 1 or 1
		if amount_bags < self._total_bags then
			local peer = managers.network:session():server_peer()
			peer:mark_cheater(VoteManager.REASON.many_bags)
			return false
		end
	end
	return peer:verify_bag(carry_id, -1)
end

function PlayerManager:register_carry(peer, carry_id)
	if Network:is_client() or not managers.network:session() then
		return true
	end
	if not peer then
		return false
	end
	return peer:verify_bag(carry_id, 1)
end

function PlayerManager:add_special(params)
	local name = params.equipment or params.name
	if not tweak_data.equipments.specials[name] then
		Application:error("Special equipment " .. name .. " doesn't exist!")
		return
	end
	local unit = self:player_unit()
	local respawn = params.amount and true or false
	local equipment = tweak_data.equipments.specials[name]
	local special_equipment = self._equipment.specials[name]
	local amount = params.amount or equipment.quantity
	local extra = self:_equipped_upgrade_value(equipment) + self:upgrade_value(name, "quantity")
	if name == "cable_tie" then
		extra = self:upgrade_value(name, "quantity_1") + self:upgrade_value(name, "quantity_2")
	end
	if special_equipment then
		if equipment.max_quantity or equipment.quantity or params.transfer and equipment.transfer_quantity then
			local dedigested_amount = special_equipment.amount and Application:digest_value(special_equipment.amount, false) or 1
			local new_amount = self:has_category_upgrade(name, "quantity_unlimited") and -1 or math.min(dedigested_amount + amount, (params.transfer and equipment.transfer_quantity or equipment.max_quantity or equipment.quantity) + extra)
			special_equipment.amount = Application:digest_value(new_amount, true)
			if special_equipment.is_cable_tie then
				managers.hud:set_cable_ties_amount(HUDManager.PLAYER_PANEL, new_amount)
				self:update_synced_cable_ties_to_peers(new_amount)
			else
				managers.hud:set_special_equipment_amount(name, new_amount)
				self:update_equipment_possession_to_peers(name, new_amount)
			end
		end
		return
	end
	local icon = equipment.icon
	local action_message = equipment.action_message
	local dialog = equipment.dialog_id
	if not params.silent then
		local text = managers.localization:text(equipment.text_id)
		local title = managers.localization:text("present_obtained_mission_equipment_title")
		managers.hud:present_mid_text({
			text = text,
			title = title,
			icon = icon,
			time = 4
		})
		if dialog then
			managers.dialog:queue_dialog(dialog, {})
		end
		if action_message and alive(unit) then
			managers.network:session():send_to_peers_synched("sync_show_action_message", unit, action_message)
		end
	end
	local quantity = (not self:has_category_upgrade(name, "quantity_unlimited") or not -1) and equipment.quantity and (not respawn or not math.min(params.amount, (equipment.max_quantity or equipment.quantity or 1) + extra)) and equipment.quantity and math.min(amount + extra, (equipment.max_quantity or equipment.quantity or 1) + extra)
	local is_cable_tie = name == "cable_tie"
	if is_cable_tie then
		managers.hud:set_cable_tie(HUDManager.PLAYER_PANEL, {
			icon = icon,
			amount = quantity or nil
		})
		self:update_synced_cable_ties_to_peers(quantity)
	else
		local new_amount = params.transfer and params.amount or quantity
		managers.hud:add_special_equipment({
			id = name,
			icon = icon,
			amount = new_amount or equipment.transfer_quantity and 1 or nil
		})
		self:update_equipment_possession_to_peers(name, new_amount)
	end
	self._equipment.specials[name] = {
		amount = quantity and Application:digest_value(quantity, true) or nil,
		is_cable_tie = is_cable_tie
	}
	if equipment.player_rule then
		self:set_player_rule(equipment.player_rule, true)
	end
end

function PlayerManager:_equipped_upgrade_value(equipment)
	if not equipment.extra_quantity then
		return 0
	end
	local equipped_upgrade = equipment.extra_quantity.equipped_upgrade
	local category = equipment.extra_quantity.category
	local upgrade = equipment.extra_quantity.upgrade
	return self:equipped_upgrade_value(equipped_upgrade, category, upgrade)
end

function PlayerManager:has_special_equipment(name)
	return self._equipment.specials[name]
end

function PlayerManager:_can_pickup_special_equipment(special_equipment, name)
	if special_equipment.amount then
		local equipment = tweak_data.equipments.specials[name]
		local extra = self:_equipped_upgrade_value(equipment)
		return Application:digest_value(special_equipment.amount, false) < (equipment.max_quantity or equipment.quantity or 1) + extra, not not equipment.max_quantity
	end
	return false
end

function PlayerManager:can_pickup_equipment(name)
	local special_equipment = self._equipment.specials[name]
	if special_equipment then
		return self:_can_pickup_special_equipment(special_equipment, name)
	else
		local equipment = tweak_data.equipments.specials[name]
		if equipment and equipment.shares_pickup_with then
			for i, special_equipment_name in ipairs(equipment.shares_pickup_with) do
				if special_equipment_name ~= name then
					special_equipment = self._equipment.specials[special_equipment_name]
					if special_equipment and not self:_can_pickup_special_equipment(special_equipment, name) then
						return false
					end
				end
			end
		end
	end
	return true
end

function PlayerManager:remove_special(name)
	local special_equipment = self._equipment.specials[name]
	if not special_equipment then
		return
	end
	local special_amount = special_equipment.amount and Application:digest_value(special_equipment.amount, false)
	if special_amount and special_amount ~= -1 then
		special_amount = math.max(0, special_amount - 1)
		if special_equipment.is_cable_tie then
			managers.hud:set_cable_ties_amount(HUDManager.PLAYER_PANEL, special_amount)
			self:update_synced_cable_ties_to_peers(special_amount)
		else
			managers.hud:set_special_equipment_amount(name, special_amount)
			self:update_equipment_possession_to_peers(name, special_amount)
		end
		special_equipment.amount = Application:digest_value(special_amount, true)
	end
	if not special_amount or special_amount == 0 then
		if not special_equipment.is_cable_tie then
			managers.hud:remove_special_equipment(name)
			managers.network:session():send_to_peers_loaded("sync_remove_equipment_possession", managers.network:session():local_peer():id(), name)
			self:remove_equipment_possession(managers.network:session():local_peer():id(), name)
		end
		self._equipment.specials[name] = nil
		local equipment = tweak_data.equipments.specials[name]
		if equipment.player_rule then
			self:set_player_rule(equipment.player_rule, false)
		end
	end
end

function PlayerManager:_set_grenade(params)
	local grenade = params.grenade
	local tweak_data = tweak_data.blackmarket.projectiles[grenade]
	local amount = params.amount
	local icon = tweak_data.icon
	self:update_grenades_amount_to_peers(grenade, amount)
	managers.hud:set_teammate_grenades(HUDManager.PLAYER_PANEL, {amount = amount, icon = icon})
end

function PlayerManager:add_grenade_amount(amount)
	local peer_id = managers.network:session():local_peer():id()
	local grenade = self._global.synced_grenades[peer_id].grenade
	local icon = tweak_data.blackmarket.projectiles[grenade].icon
	amount = math.min(Application:digest_value(self._global.synced_grenades[peer_id].amount, false) + amount, self:get_max_grenades_by_peer_id(peer_id))
	managers.hud:set_teammate_grenades_amount(HUDManager.PLAYER_PANEL, {icon = icon, amount = amount})
	self:update_grenades_amount_to_peers(grenade, amount)
end

function PlayerManager:update_grenades_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_grenades[peer_id] then
		local grenade = self._global.synced_grenades[peer_id].grenade
		local amount = self._global.synced_grenades[peer_id].amount
		peer:send_queued_sync("sync_grenades", grenade, Application:digest_value(amount, false))
	end
end

function PlayerManager:update_grenades_amount_to_peers(grenade, amount)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers_synched("sync_grenades", grenade, amount)
	self:set_synced_grenades(peer_id, grenade, amount)
end

function PlayerManager:set_synced_grenades(peer_id, grenade, amount)
	local only_update_amount = self._global.synced_grenades[peer_id] and self._global.synced_grenades[peer_id].grenade == grenade
	local digested_amount = Application:digest_value(amount, true)
	self._global.synced_grenades[peer_id] = {grenade = grenade, amount = digested_amount}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		local icon = tweak_data.blackmarket.projectiles[grenade].icon
		if only_update_amount then
			managers.hud:set_teammate_grenades_amount(character_data.panel_id, {icon = icon, amount = amount})
		else
			managers.hud:set_teammate_grenades(character_data.panel_id, {icon = icon, amount = amount})
		end
	end
end

function PlayerManager:get_grenade_amount(peer_id)
	return Application:digest_value(self._global.synced_grenades[peer_id].amount, false)
end

function PlayerManager:get_synced_grenades(peer_id)
	return self._global.synced_grenades[peer_id]
end

function PlayerManager:can_throw_grenade()
	local peer_id = managers.network:session():local_peer():id()
	return self:get_grenade_amount(peer_id) > 0
end

function PlayerManager:get_max_grenades_by_peer_id(peer_id)
	local peer = managers.network:session() and managers.network:session():peer(peer_id)
	return peer and self:get_max_grenades(peer:grenade_id()) or 0
end

function PlayerManager:get_max_grenades(grenade_id)
	grenade_id = grenade_id or managers.blackmarket:equipped_grenade()
	return tweak_data:get_raw_value("blackmarket", "projectiles", grenade_id, "max_amount") or 0
end

function PlayerManager:got_max_grenades()
	local peer_id = managers.network:session():local_peer():id()
	return self:get_grenade_amount(peer_id) >= self:get_max_grenades_by_peer_id(peer_id)
end

function PlayerManager:has_grenade(peer_id)
	peer_id = peer_id or managers.network:session():local_peer():id()
	local synced_grenade = self:get_synced_grenades(peer_id)
	return synced_grenade and synced_grenade.grenade and true or false
end

function PlayerManager:on_throw_grenade()
	self:add_grenade_amount(-1)
	local peer_id = managers.network:session():local_peer():id()
	if tweak_data.achievement.fire_in_the_hole.grenade == self:get_synced_grenades(peer_id).grenade then
		managers.achievment:award_progress(tweak_data.achievement.fire_in_the_hole.stat)
	end
end

function PlayerManager:set_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	local carry_data = tweak_data.carry[carry_id]
	local carry_type = carry_data.type
	self:set_player_state("carry")
	local title = managers.localization:text("hud_carrying_announcement_title")
	local type_text = carry_data.name_id and managers.localization:text(carry_data.name_id)
	local text = managers.localization:text("hud_carrying_announcement", {CARRY_TYPE = type_text})
	local icon
	if not dye_initiated then
		dye_initiated = true
		if carry_data.dye then
			repeat
				local chance = tweak_data.carry.dye.chance * managers.player:upgrade_value("player", "dye_pack_chance_multiplier", 1)
				do break end -- pseudo-goto
				has_dye_pack = true
				dye_value_multiplier = math.round(tweak_data.carry.dye.value_multiplier * managers.player:upgrade_value("player", "dye_pack_cash_loss_multiplier", 1))
			until true
		end
	end
	self:update_synced_carry_to_peers(carry_id, carry_multiplier or 1, dye_initiated, has_dye_pack, dye_value_multiplier)
	managers.hud:set_teammate_carry_info(HUDManager.PLAYER_PANEL, carry_id, managers.loot:get_real_value(carry_id, carry_multiplier or 1))
	managers.hud:temp_show_carry_bag(carry_id, managers.loot:get_real_value(carry_id, carry_multiplier or 1))
	local player = self:player_unit()
	if not player then
		return
	end
	player:movement():current_state():set_tweak_data(carry_type)
	player:sound():play("Play_bag_generic_pickup", nil, false)
end

function PlayerManager:bank_carry()
	local carry_data = self:get_my_carry_data()
	managers.loot:secure(carry_data.carry_id, carry_data.multiplier)
	managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
	managers.hud:temp_hide_carry_bag()
	self:update_removed_synced_carry_to_peers()
	managers.player:set_player_state("standard")
end

function PlayerManager:drop_carry(zipline_unit)
	local carry_data = self:get_my_carry_data()
	if not carry_data then
		return
	end
	self._carry_blocked_cooldown_t = Application:time() + (1.2 + math.rand(0.3))
	local player = self:player_unit()
	if player then
		player:sound():play("Play_bag_generic_throw", nil, false)
	end
	local camera_ext = player:camera()
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	local throw_distance_multiplier_upgrade_level = managers.player:upgrade_level("carry", "throw_distance_multiplier", 0)
	if Network:is_client() then
		managers.network:session():send_to_host("server_drop_carry", carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit)
	else
		self:server_drop_carry(carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_distance_multiplier_upgrade_level, zipline_unit, managers.network:session():local_peer())
	end
	managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
	managers.hud:temp_hide_carry_bag()
	self:update_removed_synced_carry_to_peers()
	if self._current_state == "carry" then
		managers.player:set_player_state("standard")
	end
end

function PlayerManager:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer)
	if not self:verify_carry(peer, carry_id) then
		return
	end
	local unit_name = tweak_data.carry[carry_id].unit or "units/payday2/pickups/gen_pku_lootbag/gen_pku_lootbag"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_carry_data", unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer and peer:id() or 0)
	self:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit)
	return unit
end

function PlayerManager:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit)
	local throw_distance_multiplier = self:upgrade_value_by_level("carry", "throw_distance_multiplier", throw_distance_multiplier_upgrade_level, 1)
	local carry_type = tweak_data.carry[carry_id].type
	throw_distance_multiplier = throw_distance_multiplier * tweak_data.carry.types[carry_type].throw_distance_multiplier
	unit:carry_data():set_carry_id(carry_id)
	unit:carry_data():set_multiplier(carry_multiplier)
	unit:carry_data():set_value(managers.money:get_bag_value(carry_id, carry_multiplier))
	unit:carry_data():set_dye_pack_data(dye_initiated, has_dye_pack, dye_value_multiplier)
	if alive(zipline_unit) then
		zipline_unit:zipline():attach_bag(unit)
	else
		unit:push(100, dir * 600 * throw_distance_multiplier)
	end
	unit:interaction():register_collision_callbacks()
end

function PlayerManager:force_drop_carry()
	local carry_data = self:get_my_carry_data()
	if not carry_data then
		return
	end
	local player = self:player_unit()
	if not alive(player) then
		print("COULDN'T FORCE DROP! DIDN'T HAVE A UNIT")
		return
	end
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	local camera_ext = player:camera()
	if Network:is_client() then
		managers.network:session():send_to_host("server_drop_carry", carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), Vector3(0, 0, 0), 0, nil)
	else
		self:server_drop_carry(carry_data.carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), Vector3(0, 0, 0), 0, nil, managers.network:session():local_peer())
	end
	managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
	managers.hud:temp_hide_carry_bag()
	self:update_removed_synced_carry_to_peers()
end

function PlayerManager:clear_carry()
	local carry_data = self:get_my_carry_data()
	if not carry_data then
		return
	end
	local player = self:player_unit()
	if not alive(player) then
		print("COULDN'T FORCE DROP! DIDN'T HAVE A UNIT")
		return
	end
	managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
	managers.hud:temp_hide_carry_bag()
	self:update_removed_synced_carry_to_peers()
	if self._current_state == "carry" then
		managers.player:set_player_state("standard")
	end
end

function PlayerManager:is_berserker()
	local player_unit = self:player_unit()
	return alive(player_unit) and player_unit:character_damage() and player_unit:character_damage():is_berserker() or false
end

function PlayerManager:get_damage_health_ratio(health_ratio, category)
	local damage_ratio = 1 - health_ratio / math.max(0.01, self:_get_damage_health_ratio_threshold(category))
	return math.max(damage_ratio, 0)
end

function PlayerManager:_get_damage_health_ratio_threshold(category)
	local threshold = tweak_data.upgrades.player_damage_health_ratio_threshold
	if category then
		threshold = threshold * self:upgrade_value("player", category .. "_damage_health_ratio_threshold_multiplier", 1)
	end
	return threshold
end

function PlayerManager:is_damage_health_ratio_active(health_ratio)
	return self:has_category_upgrade("player", "melee_damage_health_ratio_multiplier") and self:get_damage_health_ratio(health_ratio, "melee") > 0 or self:has_category_upgrade("player", "armor_regen_damage_health_ratio_multiplier") and 0 < self:get_damage_health_ratio(health_ratio, "armor_regen") or self:has_category_upgrade("player", "damage_health_ratio_multiplier") and 0 < self:get_damage_health_ratio(health_ratio, "damage") or self:has_category_upgrade("player", "movement_speed_damage_health_ratio_multiplier") and 0 < self:get_damage_health_ratio(health_ratio, "movement_speed")
end

function PlayerManager:is_carrying()
	return self:get_my_carry_data() and true or false
end

function PlayerManager:current_carry_id()
	local my_carry_data = self:get_my_carry_data()
	return my_carry_data and my_carry_data.carry_id or nil
end

function PlayerManager:carry_blocked_by_cooldown()
	return self._carry_blocked_cooldown_t and self._carry_blocked_cooldown_t > Application:time() or false
end

function PlayerManager:can_carry(carry_id)
	return true
end

function PlayerManager:check_damage_carry(attack_data)
	local carry_data = self:get_my_carry_data()
	if not carry_data then
		return
	end
	local carry_id = carry_data.carry_id
	local type = tweak_data.carry[carry_id].type
	if not tweak_data.carry.types[type].looses_value then
		return
	end
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	local value = math.max(carry_data.value - tweak_data.carry.types[type].looses_value_per_hit * attack_data.damage, 0)
	self:update_synced_carry_to_peers(carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	managers.hud:set_teammate_carry_info(HUDManager.PLAYER_PANEL, carry_id, managers.loot:get_real_value(carry_id, carry_data.multiplier))
end

function PlayerManager:dye_pack_exploded()
	local carry_data = self:get_my_carry_data()
	if not carry_data then
		return
	end
	local carry_id = carry_data.carry_id
	local type = tweak_data.carry[carry_id].type
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	local value = carry_data.value * (1 - dye_value_multiplier / 100)
	value = math.round(value)
	has_dye_pack = false
	self:update_synced_carry_to_peers(carry_id, carry_data.multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
	managers.hud:set_teammate_carry_info(HUDManager.PLAYER_PANEL, carry_id, managers.loot:get_real_value(carry_id, carry_data.multiplier))
end

function PlayerManager:count_up_player_minions()
	self._local_player_minions = math.min(self._local_player_minions + 1, self:upgrade_value("player", "convert_enemies_max_minions", 0))
	self:update_hostage_skills()
end

function PlayerManager:count_down_player_minions()
	self._local_player_minions = math.max(self._local_player_minions - 1, 0)
	self:update_hostage_skills()
end

function PlayerManager:reset_minions()
	self._local_player_minions = 0
end

function PlayerManager:num_local_minions()
	return self._local_player_minions
end

function PlayerManager:chk_minion_limit_reached()
	return self._local_player_minions >= self:upgrade_value("player", "convert_enemies_max_minions", 0)
end

function PlayerManager:on_used_body_bag()
	self:_set_body_bags_amount(self._local_player_body_bags - 1)
end

function PlayerManager:reset_used_body_bag()
	self:_set_body_bags_amount(self:total_body_bags())
end

function PlayerManager:chk_body_bags_depleted()
	return self._local_player_body_bags <= 0
end

function PlayerManager:_set_body_bags_amount(body_bags_amount)
	self._local_player_body_bags = math.clamp(body_bags_amount, 0, self:max_body_bags())
	managers.hud:on_ext_inventory_changed()
end

function PlayerManager:add_body_bags_amount(body_bags_amount)
	self:_set_body_bags_amount(self._local_player_body_bags + body_bags_amount)
end

function PlayerManager:get_body_bags_amount()
	return self._local_player_body_bags
end

function PlayerManager:has_total_body_bags()
	return self._local_player_body_bags == self:total_body_bags()
end

function PlayerManager:total_body_bags()
	return self:upgrade_value("player", "corpse_dispose_amount", 0)
end

function PlayerManager:has_max_body_bags()
	return self._local_player_body_bags == self:max_body_bags()
end

function PlayerManager:max_body_bags()
	return self:total_body_bags() + self:upgrade_value("player", "extra_corpse_dispose_amount", 0)
end

function PlayerManager:change_player_look(new_look)
	self._player_mesh_suffix = new_look
	for _, unit in pairs(managers.groupai:state():all_char_criminals()) do
		unit.unit:movement():set_character_anim_variables()
	end
end

function PlayerManager:player_timer()
	return self._player_timer
end

function PlayerManager:add_weapon_ammo_gain(name_id, amount)
	if Application:production_build() then
		self._debug_weapon_ammo_gains = self._debug_weapon_ammo_gains or {}
		self._debug_weapon_ammo_gains[name_id] = self._debug_weapon_ammo_gains[name_id] or {total = 0, index = 0}
		self._debug_weapon_ammo_gains[name_id].total = self._debug_weapon_ammo_gains[name_id].total + amount
		self._debug_weapon_ammo_gains[name_id].index = self._debug_weapon_ammo_gains[name_id].index + 1
	end
end

function PlayerManager:report_weapon_ammo_gains()
	if Application:production_build() then
		self._debug_weapon_ammo_gains = self._debug_weapon_ammo_gains or {}
		for name_id, data in pairs(self._debug_weapon_ammo_gains) do
			print("WEAPON: " .. tostring(name_id), "AVERAGE AMMO PICKUP: " .. string.format("%3.2f%%", data.total / data.index * 100))
		end
	end
end

function PlayerManager:save(data)
	local state = {
		kit = self._global.kit,
		viewed_content_updates = self._global.viewed_content_updates
	}
	data.PlayerManager = state
end

function PlayerManager:load(data)
	self:aquire_default_upgrades()
	local state = data.PlayerManager
	if state then
		self._global.kit = state.kit or self._global.kit
		self._global.viewed_content_updates = state.viewed_content_updates or self._global.viewed_content_updates
		managers.savefile:add_load_done_callback(callback(self, self, "_verify_loaded_data"))
	end
end

function PlayerManager:set_content_update_viewed(content_update)
	self._global.viewed_content_updates[content_update] = true
end

function PlayerManager:get_content_update_viewed(content_update)
	return self._global.viewed_content_updates[content_update] or false
end

function PlayerManager:_verify_loaded_data()
	local id = self._global.kit.equipment_slots[1]
	if id and not self._global.equipment[id] then
		print("PlayerManager:_verify_loaded_data()", inspect(self._global.equipment))
		self._global.kit.equipment_slots[1] = nil
		self:_verify_equipment_kit(true)
	end
end

function PlayerManager:sync_save(data)
	local state = {
		current_sync_state = self._current_sync_state,
		player_mesh_suffix = self._player_mesh_suffix
	}
	data.PlayerManager = state
end

function PlayerManager:sync_load(data)
	local state = data.PlayerManager
	if state then
		self:set_player_state(state.current_sync_state)
		self:change_player_look(state.player_mesh_suffix)
	end
end

function PlayerManager:on_simulation_started()
	self._respawn = false
end

function PlayerManager:reset()
	if managers.hud then
		managers.hud:clear_player_special_equipments()
	end
	Global.player_manager = nil
	self:_setup()
	self:_setup_rules()
	self:aquire_default_upgrades()
end

function PlayerManager:soft_reset()
	self._listener_holder = EventListenerHolder:new()
	self:reset_used_body_bag()
	self._equipment = {
		selections = {},
		specials = {},
		selected_index = nil
	}
	self._global.synced_grenades = {}
end

function PlayerManager:on_peer_synch_request(peer)
	self:player_unit():network():synch_to_peer(peer)
end

function PlayerManager:enter_vehicle(vehicle, locator)
	local peer_id = managers.network:session():local_peer():id()
	local player = self:local_player()
	local seat = vehicle:vehicle_driving():get_available_seat(locator:position())
	if not seat then
		return
	end
	if Network:is_server() then
		self:server_enter_vehicle(vehicle, peer_id, player, seat.name)
	else
		managers.network:session():send_to_host("sync_enter_vehicle_host", vehicle, seat.name, peer_id, player)
	end
end

function PlayerManager:server_enter_vehicle(vehicle, peer_id, player, seat_name)
	local vehicle_ext = vehicle:vehicle_driving()
	local seat
	if seat_name == nil then
		local pos = player:position()
		seat = vehicle_ext:reserve_seat(player, pos, nil)
	else
		seat = vehicle_ext:reserve_seat(player, nil, seat_name)
	end
	if seat ~= nil then
		managers.network:session():send_to_peers_synched("sync_vehicle_player", "enter", vehicle, peer_id, player, seat.name)
		self:_enter_vehicle(vehicle, peer_id, player, seat.name)
	end
end

function PlayerManager:sync_enter_vehicle(vehicle, peer_id, player, seat_name)
	self:_enter_vehicle(vehicle, peer_id, player, seat_name)
end

function PlayerManager:_enter_vehicle(vehicle, peer_id, player, seat_name)
	self._global.synced_vehicle_data[peer_id] = {vehicle_unit = vehicle, seat = seat_name}
	local vehicle_ext = vehicle:vehicle_driving()
	vehicle_ext:place_player_on_seat(player, seat_name)
	player:kill_mover()
	local seat = vehicle_ext:find_seat_for_player(player)
	local rot = seat.object:rotation()
	local pos = seat.object:position()
	player:set_rotation(rot)
	player:set_position(pos)
	vehicle:link(Idstring(VehicleDrivingExt.SEAT_PREFIX .. seat_name), player)
	if self:local_player() == player then
		self:set_player_state("driving")
	end
	managers.hud:update_vehicle_label_by_id(vehicle:unit_data().name_label_id, vehicle_ext:_number_in_the_vehicle())
	managers.vehicle:on_player_entered_vehicle(vehicle, player)
end

function PlayerManager:get_vehicle()
	if managers.network:session() then
		local peer_id = managers.network:session():local_peer():id()
		local vehicle = self._global.synced_vehicle_data[peer_id]
		return vehicle
	else
		return nil
	end
end

function PlayerManager:get_vehicle_for_peer(peer_id)
	if managers.network:session() then
		local vehicle = self._global.synced_vehicle_data[peer_id]
		return vehicle
	else
		return nil
	end
end

function PlayerManager:exit_vehicle()
	local peer_id = managers.network:session():local_peer():id()
	local vehicle_data = self._global.synced_vehicle_data[peer_id]
	if vehicle_data == nil then
		return
	end
	local player = self:local_player()
	managers.network:session():send_to_peers_synched("sync_vehicle_player", "exit", nil, peer_id, player, nil)
	self:_exit_vehicle(peer_id, player)
end

function PlayerManager:sync_exit_vehicle(peer_id, player)
	self:_exit_vehicle(peer_id, player)
end

function PlayerManager:_exit_vehicle(peer_id, player)
	local vehicle_data = self._global.synced_vehicle_data[peer_id]
	if vehicle_data == nil then
		return
	end
	player:unlink()
	local vehicle_ext = vehicle_data.vehicle_unit:vehicle_driving()
	vehicle_ext:exit_vehicle(player)
	self._global.synced_vehicle_data[peer_id] = nil
	managers.hud:update_vehicle_label_by_id(vehicle_data.vehicle_unit:unit_data().name_label_id, vehicle_ext:_number_in_the_vehicle())
	managers.vehicle:on_player_exited_vehicle(vehicle_data.vehicle, player)
end

function PlayerManager:on_hallowSPOOCed()
	local player = self:local_player()
	local t = Application:time()
	if alive(player) and (not self._halloween_t or t > self._halloween_t) then
		if math.rand(1) < 0.5 then
			player:sound():play("cloaker_taunt_after_assault", nil, nil)
		elseif math.rand(1) < 0.5 then
			local camera_unit = player:camera() and player:camera():camera_unit()
			if alive(camera_unit) then
				local vec = mvector3.copy(player:movement():m_head_rot():y())
				mvector3.set_z(vec, 0)
				mvector3.negate(vec)
				mvector3.normalize(vec)
				camera_unit:base():clbk_aim_assist({ray = vec})
				player:sound():play("cloaker_detect_mono", nil, nil)
			end
		end
		self._halloween_t = t + 30
	end
end
