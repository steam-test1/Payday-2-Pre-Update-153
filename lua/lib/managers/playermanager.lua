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
	self._player_states = {
		standard = "ingame_standard",
		mask_off = "ingame_mask_off",
		bleed_out = "ingame_bleed_out",
		fatal = "ingame_fatal",
		arrested = "ingame_arrested",
		tased = "ingame_electrified",
		incapacitated = "ingame_incapacitated",
		clean = "ingame_clean",
		carry = "ingame_standard"
	}
	self._DEFAULT_STATE = "mask_off"
	self._current_state = self._DEFAULT_STATE
	self._sync_states = {
		"clean",
		"mask_off",
		"standard"
	}
	self._current_sync_state = self._DEFAULT_STATE
	local ids_player = Idstring("player")
	self._player_timer = TimerManager:timer(ids_player) or TimerManager:make_timer(ids_player, TimerManager:pausable())
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
		Global.player_manager.kit = {
			weapon_slots = {"glock_17"},
			equipment_slots = {},
			special_equipment_slots = {}
		}
	end
	Global.player_manager.default_kit = {
		weapon_slots = {"glock_17"},
		equipment_slots = {},
		special_equipment_slots = {"cable_tie"}
	}
	Global.player_manager.synced_bonuses = {}
	Global.player_manager.synced_equipment_possession = {}
	Global.player_manager.synced_deployables = {}
	Global.player_manager.synced_cable_ties = {}
	Global.player_manager.synced_perks = {}
	Global.player_manager.synced_ammo_info = {}
	Global.player_manager.synced_carry = {}
	Global.player_manager.synced_team_upgrades = {}
	self._global = Global.player_manager
end

function PlayerManager:_setup_rules()
	self._rules = {no_run = 0}
end

function PlayerManager:aquire_default_upgrades()
	managers.upgrades:aquire_default("cable_tie")
	managers.upgrades:aquire_default("player_special_enemy_highlight")
	managers.upgrades:aquire_default("player_hostage_trade")
	managers.upgrades:aquire_default("player_sec_camera_highlight")
	for i = 1, PlayerManager.WEAPON_SLOTS do
		if not managers.player:weapon_in_slot(i) then
			self._global.kit.weapon_slots[i] = managers.player:availible_weapons(i)[1]
		end
	end
	self:_verify_equipment_kit()
end

function PlayerManager:update_kit_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	for i = 1, PlayerManager.WEAPON_SLOTS do
		local weapon = self:weapon_in_slot(i)
		if weapon then
			peer:send_after_load("set_kit_selection", peer_id, "weapon", weapon, i)
		end
	end
	for i = 1, 3 do
		local equipment = self:equipment_in_slot(i)
		if equipment then
			peer:send_after_load("set_kit_selection", peer_id, "equipment", equipment, i)
		end
	end
end

function PlayerManager:update(t, dt)
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
	player:inventory():add_unit_by_factory_name(secondary.factory_id, true, false, secondary.blueprint)
	local primary = managers.blackmarket:equipped_primary()
	if primary then
		player:inventory():add_unit_by_factory_name(primary.factory_id, false, false, primary.blueprint)
	end
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
					elseif upgrade.slot and upgrade.slot == 2 then
						managers.hud:set_perk_equipment(HUDManager.PLAYER_PANEL, upgrade)
						self:update_synced_perks_to_peers(ok_name)
					end
				end
			end
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

function PlayerManager:spawn_dropin_penalty(dead, bleed_out, health, used_deployable)
	local player = self:player_unit()
	print("[PlayerManager:spawn_dropin_penalty]", dead, bleed_out, health)
	if not alive(player) then
		return
	end
	if used_deployable then
		managers.player:clear_equipment()
	end
	local min_health
	if dead or bleed_out then
		min_health = 0
	else
		min_health = 0.25
	end
	player:character_damage():set_health(math.max(min_health, health) * player:character_damage():_max_health())
	player:inventory():set_ammo(0.5)
	if dead or bleed_out then
		print("[PlayerManager:spawn_dead] Killing")
		IngameFatalState.client_died()
		player:base():set_enabled(false)
		game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
		player:character_damage():set_invulnerable(true)
		player:base():_unregister()
		player:base():set_slot(player, 0)
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

function PlayerManager:setup_viewports()
	local configs = self._viewport_configs[self._last_id]
	if configs then
		for k, player in ipairs(self._players) do
			player:camera():setup_viewport(configs[k])
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

function PlayerManager:set_player_state(state)
	state = state or self._current_state
	if state == "standard" and self:get_my_carry_data() then
		state = "carry"
	end
	if state == self._current_state then
		return
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
	if state == "clean" or state == "mask_off" then
		managers.groupai:state():calm_ai()
	end
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

function PlayerManager:_verify_equipment_kit()
	for i = 1, 3 do
		if not managers.player:equipment_in_slot(i) then
			self._global.kit.equipment_slots[i] = managers.player:availible_equipment(i)[1]
		end
	end
end

function PlayerManager:aquire_equipment(upgrade, id)
	if self._global.equipment[id] then
		return
	end
	self._global.equipment[id] = upgrade
	if upgrade.aquire then
		managers.upgrades:aquire_default(upgrade.aquire.upgrade)
	end
	self:_verify_equipment_kit()
end

function PlayerManager:unaquire_equipment(upgrade, id)
	if not self._global.equipment[id] then
		return
	end
	local is_equipped = managers.player:equipment_in_slot(upgrade.slot) == id
	self._global.equipment[id] = nil
	if is_equipped then
		self._global.kit.equipment_slots[upgrade.slot] = nil
		self:_verify_equipment_kit()
	end
	if upgrade.aquire then
		managers.upgrades:unaquire(upgrade.aquire.upgrade)
	end
end

function PlayerManager:aquire_upgrade(upgrade)
	self._global.upgrades[upgrade.category] = self._global.upgrades[upgrade.category] or {}
	self._global.upgrades[upgrade.category][upgrade.upgrade] = upgrade.value
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

function PlayerManager:body_armor_value()
	local armor_data = tweak_data.blackmarket.armors[managers.blackmarket:equipped_armor()]
	return self:upgrade_value_by_level("player", "body_armor", armor_data.upgrade_level, 0)
end

function PlayerManager:body_armor_movement_penalty()
	local armor_data = tweak_data.blackmarket.armors[managers.blackmarket:equipped_armor()]
	return self:upgrade_value_by_level("player", "armor_movement_penalty", armor_data.movement_penalty, 1)
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
		peer:send_after_load("sync_deployable_equipment", peer_id, deployable, amount)
	end
end

function PlayerManager:update_deployable_equipment_amount_to_peers(equipment, amount)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_deployable_equipment", peer_id, equipment, amount)
	self:set_synced_deployable_equipment(peer_id, equipment, amount)
end

function PlayerManager:set_synced_deployable_equipment(peer_id, deployable, amount)
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
	if peer_id ~= local_peer_id and managers.network:game():member(peer_id) then
		local unit = managers.network:game():member(peer_id):unit()
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
		peer:send_after_load("sync_cable_ties", peer_id, amount)
	end
end

function PlayerManager:update_synced_cable_ties_to_peers(amount)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_cable_ties", peer_id, amount)
	self:set_synced_cable_ties(peer_id, amount)
end

function PlayerManager:set_synced_cable_ties(peer_id, amount)
	local only_update_amount = false
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

function PlayerManager:update_perks_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_perks[peer_id] then
		local perk = self._global.synced_perks[peer_id].perk
		peer:send_after_load("sync_perk_equipment", peer_id, perk)
	end
end

function PlayerManager:update_synced_perks_to_peers(perk)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_perk_equipment", peer_id, perk)
	self:set_synced_perk(peer_id, perk)
end

function PlayerManager:set_synced_perk(peer_id, perk)
	self._global.synced_perks[peer_id] = {perk = perk}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		local icon = tweak_data.upgrades.definitions[perk].icon
		managers.hud:set_perk_equipment(character_data.panel_id, {icon = icon})
	end
end

function PlayerManager:get_synced_perk(peer_id)
	return self._global.synced_perks[peer_id]
end

function PlayerManager:update_ammo_info_to_peer(peer)
	local peer_id = managers.network:session():local_peer():id()
	if self._global.synced_ammo_info[peer_id] then
		for selection_index, ammo_info in pairs(self._global.synced_ammo_info[peer_id]) do
			peer:send_after_load("sync_ammo_amount", peer_id, selection_index, unpack(ammo_info))
		end
	end
end

function PlayerManager:update_synced_ammo_info_to_peers(selection_index, max_clip, current_clip, current_left, max)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers_loaded("sync_ammo_amount", peer_id, selection_index, max_clip, current_clip, current_left, max)
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
		local value = self._global.synced_carry[peer_id].value
		local dye_initiated = self._global.synced_carry[peer_id].dye_initiated
		local has_dye_pack = self._global.synced_carry[peer_id].has_dye_pack
		local dye_value_multiplier = self._global.synced_carry[peer_id].dye_value_multiplier
		peer:send_after_load("sync_carry", peer_id, carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
	end
end

function PlayerManager:update_synced_carry_to_peers(carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_carry", peer_id, carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
	self:set_synced_carry(peer_id, carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
end

function PlayerManager:set_synced_carry(peer_id, carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
	self._global.synced_carry[peer_id] = {
		carry_id = carry_id,
		value = value,
		dye_initiated = dye_initiated,
		has_dye_pack = has_dye_pack,
		dye_value_multiplier = dye_value_multiplier
	}
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_carry_info(character_data.panel_id, carry_id, managers.loot:get_real_value(carry_id, value))
	end
	managers.hud:set_name_label_carry_info(peer_id, carry_id, managers.loot:get_real_value(carry_id, value))
	local local_peer_id = managers.network:session():local_peer():id()
	if peer_id ~= local_peer_id and managers.network:game():member(peer_id) then
		local unit = managers.network:game():member(peer_id):unit()
		if alive(unit) then
			unit:movement():set_visual_carry(carry_id)
		end
	end
end

function PlayerManager:set_carry_approved(peer)
	self._global.synced_carry[peer:id()].approved = true
end

function PlayerManager:update_removed_synced_carry_to_peers()
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_remove_carry", peer_id)
	self:remove_synced_carry(peer_id)
end

function PlayerManager:remove_synced_carry(peer_id)
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
	if peer_id ~= local_peer_id and managers.network:game():member(peer_id) then
		local unit = managers.network:game():member(peer_id):unit()
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
			managers.network:session():send_to_peers("add_synced_team_upgrade", category, upgrade, level)
		end
	end
end

function PlayerManager:update_team_upgrades_to_peer(peer)
	for category, upgrades in pairs(self._global.team_upgrades) do
		for upgrade, level in pairs(upgrades) do
			peer:send_after_load("add_synced_team_upgrade", category, upgrade, level)
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
			peer:send_after_load("sync_equipment_possession", peer_id, name, amount)
		end
	end
end

function PlayerManager:update_equipment_possession_to_peers(equipment, amount)
	local peer_id = managers.network:session():local_peer():id()
	managers.network:session():send_to_peers("sync_equipment_possession", peer_id, equipment, amount or 1)
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

function PlayerManager:peer_dropped_out(peer)
	local peer_id = peer:id()
	if Network:is_server() then
		if self._global.synced_equipment_possession[peer_id] then
			local peers = {
				managers.network:session():local_peer()
			}
			for _, p in pairs(managers.network:session():peers()) do
				table.insert(peers, p)
			end
			for name, amount in pairs(self._global.synced_equipment_possession[peer_id]) do
				for _, p in pairs(peers) do
					local id = p:id()
					if not self._global.synced_equipment_possession[id] or not self._global.synced_equipment_possession[id][name] then
						if p == managers.network:session():local_peer() then
							managers.player:add_special({name = name, amount = amount})
							break
						end
						p:send("give_equipment", name, amount)
						break
					end
				end
			end
		end
		if self._global.synced_carry[peer_id] and self._global.synced_carry[peer_id].approved then
			local carry_id = self._global.synced_carry[peer_id].carry_id
			local carry_value = self._global.synced_carry[peer_id].value
			local dye_initiated = self._global.synced_carry[peer_id].dye_initiated
			local has_dye_pack = self._global.synced_carry[peer_id].has_dye_pack
			local dye_value_multiplier = self._global.synced_carry[peer_id].dye_value_multiplier
			local peer_unit = managers.network:game():member(peer_id):unit()
			local position = alive(peer_unit) and peer_unit:position() or Vector3()
			local dir = Vector3(0, 0, 0)
			self:server_drop_carry(carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, Rotation(), dir, 0)
		end
	end
	self._global.synced_equipment_possession[peer_id] = nil
	self._global.synced_deployables[peer_id] = nil
	self._global.synced_cable_ties[peer_id] = nil
	self._global.synced_perks[peer_id] = nil
	self._global.synced_ammo_info[peer_id] = nil
	self._global.synced_carry[peer_id] = nil
	self._global.synced_team_upgrades[peer_id] = nil
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
	managers.hud:set_next_item_selected()
end

function PlayerManager:select_previous_item()
	if not self._equipment.selected_index then
		return
	end
	self._equipment.selected_index = 1 <= self._equipment.selected_index - 1 and self._equipment.selected_index - 1 or #self._equipment.selections
	managers.hud:set_previous_item_selected()
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
	repeat
		equipment.amount = Application:digest_value(new_amount, true)
		do break end -- pseudo-goto
		if new_amount == 0 then
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
	until true
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
	return managers.localization:text(tweak_data.equipments[equipment_data.equipment].text_id)
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
	elseif equipment_data.equipment == "sentry_gun" or equipment_data.equipment == "ammo_bag" or equipment_data.equipment == "doctor_bag" then
		return player:equipment():valid_shape_placement(equipment_data.equipment, tweak_data.equipments[equipment_data.equipment]) and true or false
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
	repeat
		equipment.amount = Application:digest_value(new_amount, true)
		do break end -- pseudo-goto
		if new_amount == 0 then
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
	until true
	managers.hud:set_item_amount(index, new_amount)
	self:update_deployable_equipment_amount_to_peers(equipment.equipment, new_amount)
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
	if special_equipment then
		if equipment.quantity then
			local dedigested_amount = Application:digest_value(special_equipment.amount, false)
			local new_amount = self:has_category_upgrade(name, "quantity_unlimited") and -1 or math.min(dedigested_amount + amount, equipment.quantity + extra)
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
			managers.network:session():send_to_peers("sync_show_action_message", unit, action_message)
		end
	end
	local quantity = (not self:has_category_upgrade(name, "quantity_unlimited") or not -1) and equipment.quantity and (not respawn or not math.min(params.amount, equipment.quantity + extra)) and equipment.quantity and math.min(amount + extra, equipment.quantity + extra)
	local is_cable_tie = name == "cable_tie"
	if is_cable_tie then
		managers.hud:set_cable_tie(HUDManager.PLAYER_PANEL, {
			icon = icon,
			amount = quantity or nil
		})
		self:update_synced_cable_ties_to_peers(quantity)
	else
		managers.hud:add_special_equipment({
			id = name,
			icon = icon,
			amount = quantity or nil
		})
		self:update_equipment_possession_to_peers(name, quantity)
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

function PlayerManager:can_pickup_equipment(name)
	local special_equipment = self._equipment.specials[name]
	if special_equipment then
		if special_equipment.amount then
			local equipment = tweak_data.equipments.specials[name]
			local extra = self:_equipped_upgrade_value(equipment)
			return Application:digest_value(special_equipment.amount, false) < equipment.quantity + extra
		end
		return false
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

function PlayerManager:set_carry(carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier)
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
	self:update_synced_carry_to_peers(carry_id, carry_value or 100, dye_initiated, has_dye_pack, dye_value_multiplier)
	managers.hud:set_teammate_carry_info(HUDManager.PLAYER_PANEL, carry_id, managers.loot:get_real_value(carry_id, carry_value or 100))
	managers.hud:temp_show_carry_bag(carry_id, managers.loot:get_real_value(carry_id, carry_value or 100))
	local player = self:player_unit()
	if not player then
		return
	end
	player:movement():current_state():set_tweak_data(carry_type)
end

function PlayerManager:bank_carry()
	local carry_data = self:get_my_carry_data()
	managers.loot:secure(carry_data.carry_id, carry_data.value)
	managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
	managers.hud:temp_hide_carry_bag()
	self:update_removed_synced_carry_to_peers()
	managers.player:set_player_state("standard")
end

function PlayerManager:drop_carry()
	local carry_data = self:get_my_carry_data()
	if not carry_data then
		return
	end
	self._carry_blocked_cooldown_t = Application:time() + (1.2 + math.rand(0.3))
	local player = self:player_unit()
	local camera_ext = player:camera()
	local dye_initiated = carry_data.dye_initiated
	local has_dye_pack = carry_data.has_dye_pack
	local dye_value_multiplier = carry_data.dye_value_multiplier
	local throw_distance_multiplier_upgrade_level = managers.player:upgrade_level("carry", "throw_distance_multiplier", 0)
	if Network:is_client() then
		managers.network:session():send_to_host("server_drop_carry", carry_data.carry_id, carry_data.value, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_distance_multiplier_upgrade_level)
	else
		self:server_drop_carry(carry_data.carry_id, carry_data.value, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), player:camera():forward(), throw_distance_multiplier_upgrade_level)
	end
	managers.hud:remove_teammate_carry_info(HUDManager.PLAYER_PANEL)
	managers.hud:temp_hide_carry_bag()
	self:update_removed_synced_carry_to_peers()
	if self._current_state == "carry" then
		managers.player:set_player_state("standard")
	end
end

function PlayerManager:server_drop_carry(carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level)
	if carry_value <= 0 then
		return
	end
	local unit_name = tweak_data.carry[carry_id].unit or "units/payday2/pickups/gen_pku_lootbag/gen_pku_lootbag"
	local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
	managers.network:session():send_to_peers_synched("sync_carry_data", unit, carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level)
	self:sync_carry_data(unit, carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level)
	return unit
end

function PlayerManager:sync_carry_data(unit, carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level)
	local throw_distance_multiplier = self:upgrade_value_by_level("carry", "throw_distance_multiplier", throw_distance_multiplier_upgrade_level, 1)
	local carry_type = tweak_data.carry[carry_id].type
	throw_distance_multiplier = throw_distance_multiplier * tweak_data.carry.types[carry_type].throw_distance_multiplier
	unit:push(100, dir * 600 * throw_distance_multiplier)
	unit:carry_data():set_carry_id(carry_id)
	unit:carry_data():set_value(carry_value)
	unit:carry_data():set_dye_pack_data(dye_initiated, has_dye_pack, dye_value_multiplier)
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
		managers.network:session():send_to_host("server_drop_carry", carry_data.carry_id, carry_data.value, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), Vector3(0, 0, 0), 0)
	else
		self:server_drop_carry(carry_data.carry_id, carry_data.value, dye_initiated, has_dye_pack, dye_value_multiplier, camera_ext:position(), camera_ext:rotation(), Vector3(0, 0, 0), 0)
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

function PlayerManager:is_carrying()
	return self:get_my_carry_data() and true or false
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
	self:update_synced_carry_to_peers(carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
	managers.hud:set_teammate_carry_info(HUDManager.PLAYER_PANEL, carry_id, managers.loot:get_real_value(carry_id, value))
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
	self:update_synced_carry_to_peers(carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
	managers.hud:set_teammate_carry_info(HUDManager.PLAYER_PANEL, carry_id, managers.loot:get_real_value(carry_id, value))
end

function PlayerManager:count_up_player_minions()
	self._local_player_minions = math.min(self._local_player_minions + 1, self:upgrade_value("player", "convert_enemies_max_minions", 0))
end

function PlayerManager:count_down_player_minions()
	self._local_player_minions = math.max(self._local_player_minions - 1, 0)
end

function PlayerManager:reset_minions()
	self._local_player_minions = 0
end

function PlayerManager:chk_minion_limit_reached()
	return self._local_player_minions >= self:upgrade_value("player", "convert_enemies_max_minions", 0)
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

function PlayerManager:save(data)
	local state = {
		kit = self._global.kit
	}
	data.PlayerManager = state
end

function PlayerManager:load(data)
	self:aquire_default_upgrades()
	local state = data.PlayerManager
	if state then
		self._global.kit = state.kit or self._global.kit
		self:_verify_loaded_data()
	end
end

function PlayerManager:_verify_loaded_data()
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
		managers.hud:clear_items()
		managers.hud:clear_special_equipments()
		managers.hud:clear_player_special_equipments()
	end
	Global.player_manager = nil
	self:_setup()
	self:_setup_rules()
	self:aquire_default_upgrades()
end

function PlayerManager:soft_reset()
	self._listener_holder = EventListenerHolder:new()
end

function PlayerManager:on_peer_synch_request(peer)
	self:player_unit():network():synch_to_peer(peer)
end
