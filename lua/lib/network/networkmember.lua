NetworkMember = NetworkMember or class()

function NetworkMember:init(peer)
	self._peer = peer
end

function NetworkMember:delete()
	if managers.criminals then
		managers.criminals:remove_character_by_peer_id(self._peer:id())
	end
	if alive(self._unit) then
		if Network:is_server() then
			managers.network:session():send_to_peers_loaded_except(self._peer:id(), "remove_unit", self._unit)
		end
		if self._unit:id() ~= -1 then
			Network:detach_unit(self._unit)
		end
		if self._unit:base() and self._unit:base().set_slot then
			self._unit:base():set_slot(self._unit, 0)
		else
			self._unit:set_slot(0)
		end
	end
	self._unit = nil
end

function NetworkMember:load(data)
	self._peer = managers.network:session():peer(data.id)
end

function NetworkMember:save()
	local data = {}
	data.id = self._peer:id()
	return data
end

function NetworkMember:peer()
	return self._peer
end

function NetworkMember:unit()
	return self._unit
end

function NetworkMember:_get_old_entry()
	local peer_ident = SystemInfo:platform() == Idstring("WIN32") and self._peer:user_id() or self._peer:name()
	local old_plr_entry = managers.network:game()._old_players[peer_ident]
	local member_downed
	local health = 1
	local used_deployable = false
	local member_dead
	if old_plr_entry and old_plr_entry.t + 180 > Application:time() then
		member_downed = old_plr_entry.member_downed
		health = old_plr_entry.health
		used_deployable = old_plr_entry.used_deployable
		member_dead = old_plr_entry.member_dead
	end
	return member_downed, member_dead, health, used_deployable, old_plr_entry
end

function NetworkMember:spawn_unit(spawn_point_id, is_drop_in, spawn_as)
	if self._unit then
		return
	end
	if not self._peer:synched() then
		return
	end
	local peer_id = self._peer:id()
	self._spawn_unit_called = true
	local pos_rot
	if is_drop_in then
		local spawn_on
		if Global.local_member and alive(Global.local_member:unit()) then
			spawn_on = Global.local_member:unit()
		end
		if not spawn_on then
			local u_key, u_data = next(managers.groupai:state():all_char_criminals())
			if u_data and alive(u_data.unit) then
				spawn_on = u_data.unit
			end
		end
		if spawn_on then
			local pos = spawn_on:position()
			local rot = spawn_on:rotation()
			pos_rot = {pos, rot}
		else
			local spawn_point = managers.network:game():get_next_spawn_point() or managers.network:spawn_point(1)
			pos_rot = spawn_point.pos_rot
		end
	else
		pos_rot = managers.network:spawn_point(spawn_point_id).pos_rot
	end
	local member_downed, member_dead, health, used_deployable, old_plr_entry = self:_get_old_entry()
	if old_plr_entry then
		old_plr_entry.member_downed = nil
		old_plr_entry.member_dead = nil
	end
	local character_name = self:character_name()
	local trade_entry, spawn_in_custody
	print("[NetworkMember:spawn_unit] Member assigned as", character_name)
	local old_unit
	trade_entry, old_unit = managers.groupai:state():remove_one_teamAI(character_name, member_downed or member_dead)
	if trade_entry and member_dead then
		trade_entry.peer_id = peer_id
	end
	local has_old_unit = alive(old_unit)
	local ai_is_downed = false
	if alive(old_unit) then
		ai_is_downed = old_unit:character_damage():bleed_out() or old_unit:character_damage():fatal() or old_unit:character_damage():arrested() or old_unit:character_damage():need_revive() or old_unit:character_damage():dead()
		World:delete_unit(old_unit)
	end
	spawn_in_custody = (member_downed or member_dead) and (trade_entry or ai_is_downed or not trade_entry and not has_old_unit)
	local lvl_tweak_data = Global.level_data and Global.level_data.level_id and tweak_data.levels[Global.level_data.level_id]
	local unit_name_suffix = lvl_tweak_data and lvl_tweak_data.unit_suit or "suit"
	local unit_name = Idstring(tweak_data.blackmarket.characters[self._peer:character_id()].fps_unit)
	local unit
	if self == Global.local_member then
		unit = World:spawn_unit(unit_name, pos_rot[1], pos_rot[2])
	else
		unit = Network:spawn_unit_on_client(self._peer:rpc(), unit_name, pos_rot[1], pos_rot[2])
		local suspicion_mul, max_index = managers.blackmarket:get_suspicion_of_peer(self._peer)
		unit:base():set_suspicion_multiplier("equipment", suspicion_mul)
		unit:base():set_detection_multiplier("equipment", 1 / suspicion_mul)
	end
	self:set_unit(unit, character_name)
	managers.network:session():send_to_peers_synched("set_unit", unit, character_name, self._peer:profile().outfit_string, peer_id)
	if is_drop_in then
		self._peer:set_used_deployable(used_deployable)
		if self == Global.local_member then
			managers.player:spawn_dropin_penalty(spawn_in_custody, spawn_in_custody, health, used_deployable)
		else
			self._peer:send_queued_sync("spawn_dropin_penalty", spawn_in_custody, spawn_in_custody, health, used_deployable)
		end
	end
	return unit
end

function NetworkMember:set_unit(unit, character_name)
	local is_new_unit = unit and (not self._unit or self._unit:key() ~= unit:key())
	self._unit = unit
	if is_new_unit and self == Global.local_member then
		managers.player:spawned_player(1, unit)
	end
	if SystemInfo:platform() == Idstring("PS3") and is_new_unit and self ~= Global.local_member and unit:inventory() then
		unit:inventory():add_peer_blackmarket_outfit(self:peer())
	end
	if unit then
		if managers.criminals:character_peer_id_by_name(character_name) == self._peer:id() then
			managers.criminals:set_unit(character_name, unit)
		else
			if managers.criminals:is_taken(character_name) then
				managers.criminals:remove_character_by_name(character_name)
			end
			managers.criminals:add_character(character_name, unit, self._peer:id(), false)
		end
	end
	if is_new_unit then
		if unit:damage() then
			local sequence = managers.blackmarket:character_sequence_by_character_id(self._peer:character_id(), self._peer:id())
			unit:damage():run_sequence_simple(sequence)
			unit:damage():run_sequence_simple(tweak_data.blackmarket.armors[self._peer:armor_id()].sequence)
			managers.game_play_central:change_contour_material_by_unit(unit)
		end
		unit:movement():set_character_anim_variables()
		if self ~= Global.local_member then
		end
	end
end

function NetworkMember:sync_lobby_data(peer)
	print("[NetworkMember:sync_lobby_data] to", peer:id())
	local local_peer = managers.network:session():local_peer()
	local peer_id = local_peer:id()
	local level = managers.experience:current_level()
	local character = local_peer:character()
	local mask_set = "remove"
	local progress = managers.upgrades:progress()
	local menu_state = managers.menu:get_peer_state(local_peer:id())
	local menu_state_index = tweak_data:menu_sync_state_to_index(menu_state)
	cat_print("multiplayer_base", "NetworkMember:sync_lobby_data to", peer:id(), " : ", peer_id, level)
	local_peer:set_outfit_string(managers.blackmarket:outfit_string())
	peer:send_after_load("lobby_info", peer_id, level, character, mask_set, progress[1], progress[2], progress[3], progress[4] or -1)
	peer:send_after_load("sync_profile", level)
	peer:send_after_load("sync_outfit", managers.blackmarket:outfit_string())
	if menu_state_index then
		peer:send_after_load("set_menu_sync_state_index", menu_state_index)
	end
	if Network:is_server() then
		local level_id_index = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
		peer:send_after_load("lobby_sync_update_level_id", level_id_index)
		local difficulty = Global.game_settings.difficulty
		peer:send_after_load("lobby_sync_update_difficulty", difficulty)
	end
end

function NetworkMember:sync_data(peer)
	print("[NetworkMember:sync_data] to", peer:id())
	local level = managers.experience:current_level()
	peer:send_after_load("sync_profile", level)
	peer:send_after_load("sync_outfit", managers.blackmarket:outfit_string())
	managers.player:update_deployable_equipment_to_peer(peer)
	managers.player:update_cable_ties_to_peer(peer)
	managers.player:update_perks_to_peer(peer)
	managers.player:update_equipment_possession_to_peer(peer)
	managers.player:update_ammo_info_to_peer(peer)
	managers.player:update_carry_to_peer(peer)
	managers.player:update_team_upgrades_to_peer(peer)
	if self._unit then
	end
end

function NetworkMember:spawn_unit_called()
	return self._spawn_unit_called
end

function NetworkMember:drop_in_progress()
	return self._dropin_progress
end

function NetworkMember:set_drop_in_progress(dropin_progress)
	self._dropin_progress = dropin_progress
end

function NetworkMember:character_name()
	return self._peer:character()
end
