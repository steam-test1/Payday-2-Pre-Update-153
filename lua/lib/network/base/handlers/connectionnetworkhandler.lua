ConnectionNetworkHandler = ConnectionNetworkHandler or class(BaseNetworkHandler)

function ConnectionNetworkHandler:server_up(sender)
	if not self._verify_in_session() or Application:editor() then
		return
	end
	managers.network:session():on_server_up_received(sender)
end

function ConnectionNetworkHandler:request_host_discover_reply(sender)
	if not self._verify_in_server_session() then
		return
	end
	managers.network:on_discover_host_received(sender)
end

function ConnectionNetworkHandler:discover_host(sender)
	if not self._verify_in_server_session() or Application:editor() then
		return
	end
	managers.network:on_discover_host_received(sender)
end

function ConnectionNetworkHandler:discover_host_reply(sender_name, level_id, level_name, my_ip, state, difficulty, sender)
	if not self._verify_in_client_session() then
		return
	end
	if level_name == "" then
		level_name = tweak_data.levels:get_world_name_from_index(level_id)
		if not level_name then
			cat_print("multiplayer_base", "[ConnectionNetworkHandler:discover_host_reply] Ignoring host", sender_name, ". I do not have this level in my revision.")
			return
		end
	end
	managers.network:on_discover_host_reply(sender, sender_name, level_name, my_ip, state, difficulty)
end

function ConnectionNetworkHandler:request_join(peer_name, preferred_character, dlcs, xuid, peer_level, gameversion, join_attempt_identifier, sender)
	if not self._verify_in_server_session() then
		return
	end
	managers.network:session():on_join_request_received(peer_name, preferred_character, dlcs, xuid, peer_level, gameversion, join_attempt_identifier, sender)
end

function ConnectionNetworkHandler:join_request_reply(reply_id, my_peer_id, my_character, level_index, difficulty_index, state, server_character, user_id, mission, job_id_index, job_stage, alternative_job_stage, interupt_job_stage_level_index, xuid, sender)
	print(" 1 ConnectionNetworkHandler:join_request_reply", reply_id, my_peer_id, my_character, level_index, difficulty_index, state, server_character, user_id, mission, job_id_index, job_stage, alternative_job_stage, interupt_job_stage_level_index, xuid, sender)
	if not self._verify_in_client_session() then
		return
	end
	managers.network:session():on_join_request_reply(reply_id, my_peer_id, my_character, level_index, difficulty_index, state, server_character, user_id, mission, job_id_index, job_stage, alternative_job_stage, interupt_job_stage_level_index, xuid, sender)
end

function ConnectionNetworkHandler:peer_handshake(name, peer_id, ip, in_lobby, loading, synched, character, slot, mask_set, xuid, xnaddr)
	print(" 1 ConnectionNetworkHandler:peer_handshake", name, peer_id, ip, in_lobby, loading, synched, character, slot, mask_set, xuid, xnaddr)
	if not self._verify_in_client_session() then
		return
	end
	print(" 2 ConnectionNetworkHandler:peer_handshake")
	managers.network:session():peer_handshake(name, peer_id, ip, in_lobby, loading, synched, character, slot, mask_set, xuid, xnaddr)
end

function ConnectionNetworkHandler:request_player_name(sender)
	if not self._verify_sender(sender) then
		return
	end
	local name = managers.network:session():local_peer():name()
	sender:request_player_name_reply(name)
end

function ConnectionNetworkHandler:request_player_name_reply(name, sender)
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	sender_peer:set_name(name)
end

function ConnectionNetworkHandler:peer_exchange_info(peer_id, sender)
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	if self._verify_in_client_session() then
		if sender_peer:id() == 1 then
			managers.network:session():on_peer_requested_info(peer_id)
		elseif peer_id == sender_peer:id() then
			managers.network:session():send_to_host("peer_exchange_info", peer_id)
		end
	elseif self._verify_in_server_session() then
		managers.network:session():on_peer_connection_established(sender_peer, peer_id)
	end
end

function ConnectionNetworkHandler:connection_established(peer_id, sender)
	if not self._verify_in_server_session() then
		return
	end
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	managers.network:session():on_peer_connection_established(sender_peer, peer_id)
end

function ConnectionNetworkHandler:mutual_connection(other_peer_id)
	print("[ConnectionNetworkHandler:mutual_connection]", other_peer_id)
	if not self._verify_in_client_session() then
		return
	end
	managers.network:session():on_mutual_connection(other_peer_id)
end

function ConnectionNetworkHandler:remove_dead_peer(peer_id, sender)
	print("[ConnectionNetworkHandler:remove_dead_peer]", peer_id, sender:ip_at_index(0))
	if not self._verify_sender(sender) then
		return
	end
	sender:remove_peer_confirmation(peer_id)
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		print("[ConnectionNetworkHandler:remove_dead_peer] unknown peer", peer_id)
		return
	end
	managers.network:session():on_remove_dead_peer(peer, peer_id)
end

function ConnectionNetworkHandler:kick_peer(peer_id, sender)
	if not self._verify_sender(sender) then
		return
	end
	sender:remove_peer_confirmation(peer_id)
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		print("[ConnectionNetworkHandler:kick_peer] unknown peer", peer_id)
		return
	end
	managers.network:session():on_peer_kicked(peer, peer_id)
end

function ConnectionNetworkHandler:remove_peer_confirmation(removed_peer_id, sender)
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	managers.network:session():on_remove_peer_confirmation(sender_peer, removed_peer_id)
end

function ConnectionNetworkHandler:set_loading_state(state, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	managers.network:session():set_peer_loading_state(peer, state)
end

function ConnectionNetworkHandler:set_peer_synched(id, sender)
	if not self._verify_sender(sender) then
		return
	end
	managers.network:session():on_peer_synched(id)
end

function ConnectionNetworkHandler:set_dropin()
	if game_state_machine:current_state().set_dropin then
		game_state_machine:current_state():set_dropin(Global.local_member:character_name())
	end
end

function ConnectionNetworkHandler:spawn_dropin_penalty(dead, bleed_out, health, used_deployable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame_playing) then
		return
	end
	managers.player:spawn_dropin_penalty(dead, bleed_out, health, used_deployable)
end

function ConnectionNetworkHandler:ok_to_load_level(sender)
	print("ConnectionNetworkHandler:ok_to_load_level")
	if not self:_verify_in_client_session() then
		return
	end
	managers.network:session():ok_to_load_level()
end

function ConnectionNetworkHandler:ok_to_load_lobby(sender)
	print("ConnectionNetworkHandler:ok_to_load_lobby")
	if not self:_verify_in_client_session() then
		return
	end
	managers.network:session():ok_to_load_lobby()
end

function ConnectionNetworkHandler:set_peer_left(peer_id, sender)
	if not self._verify_sender(sender) then
		return
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		print("[ConnectionNetworkHandler:set_peer_left] unknown peer", peer_id)
		return
	end
	managers.network:session():on_peer_left(peer, peer_id)
end

function ConnectionNetworkHandler:set_menu_sync_state_index(index, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if managers.menu then
		managers.menu:set_peer_sync_state_index(peer:id(), index)
	end
end

function ConnectionNetworkHandler:enter_ingame_lobby_menu(sender)
	if not self._verify_sender(sender) then
		return
	end
	if managers.menu_component then
		managers.menu_component:close_stage_endscreen_gui()
	end
	game_state_machine:change_state_by_name("ingame_lobby_menu")
end

function ConnectionNetworkHandler:entered_lobby_confirmation(peer_id)
	managers.network:session():on_entered_lobby_confirmation(peer_id)
end

function ConnectionNetworkHandler:set_peer_entered_lobby(sender)
	if not self._verify_in_session() then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	managers.network:game():on_peer_entered_lobby(peer:id())
end

function ConnectionNetworkHandler:sync_game_settings(job_index, level_id_index, difficulty_index, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	local job_id = tweak_data.narrative:get_job_name_from_index(job_index)
	local level_id = tweak_data.levels:get_level_name_from_index(level_id_index)
	local difficulty = tweak_data:index_to_difficulty(difficulty_index)
	managers.job:activate_job(job_id)
	Global.game_settings.level_id = level_id
	Global.game_settings.mission = managers.job:current_mission()
	Global.game_settings.difficulty = difficulty
	if managers.menu_component then
		managers.menu_component:on_job_updated()
	end
end

function ConnectionNetworkHandler:sync_stage_settings(level_id_index, stage_num, alternative_stage, interupt_stage_level_id, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	local level_id = tweak_data.levels:get_level_name_from_index(level_id_index)
	Global.game_settings.level_id = level_id
	managers.job:set_current_stage(stage_num)
	if alternative_stage ~= 0 then
		managers.job:synced_alternative_stage(alternative_stage)
	else
		managers.job:synced_alternative_stage(nil)
	end
	if interupt_stage_level_id ~= 0 then
		local interupt_level = tweak_data.levels:get_level_name_from_index(interupt_stage_level_id)
		managers.job:synced_interupt_stage(interupt_level)
	else
		managers.job:synced_interupt_stage(nil)
	end
end

function ConnectionNetworkHandler:lobby_sync_update_level_id(level_id_index)
	local level_id = tweak_data.levels:get_level_name_from_index(level_id_index)
	local lobby_menu = managers.menu:get_menu("lobby_menu")
	if lobby_menu and lobby_menu.renderer:is_open() then
		lobby_menu.renderer:sync_update_level_id(level_id)
	end
	local kit_menu = managers.menu:get_menu("kit_menu")
	if kit_menu and kit_menu.renderer:is_open() then
		kit_menu.renderer:sync_update_level_id(level_id)
	end
end

function ConnectionNetworkHandler:lobby_sync_update_difficulty(difficulty)
	local lobby_menu = managers.menu:get_menu("lobby_menu")
	if lobby_menu and lobby_menu.renderer:is_open() then
		lobby_menu.renderer:sync_update_difficulty(difficulty)
	end
	local kit_menu = managers.menu:get_menu("kit_menu")
	if kit_menu and kit_menu.renderer:is_open() then
		kit_menu.renderer:sync_update_difficulty(difficulty)
	end
end

function ConnectionNetworkHandler:lobby_info(peer_id, level, character, mask_set, ass_progress, sha_progress, sup_progress, tech_progress, sender)
	print("ConnectionNetworkHandler:lobby_info", peer_id, level)
	local peer = self._verify_sender(sender)
	print("  IS THIS AN OK PEER?", peer and peer:id())
	if peer then
		peer:set_level(level)
		local progress = {
			ass_progress,
			sha_progress,
			sup_progress
		}
		if tech_progress ~= -1 then
			table.insert(progress, tech_progress)
		end
		local lobby_menu = managers.menu:get_menu("lobby_menu")
		if lobby_menu and lobby_menu.renderer:is_open() then
			lobby_menu.renderer:_set_player_slot(peer_id, {
				name = peer:name(),
				peer_id = peer_id,
				level = level,
				character = character,
				progress = progress
			})
		end
		local kit_menu = managers.menu:get_menu("kit_menu")
		if kit_menu and kit_menu.renderer:is_open() then
			kit_menu.renderer:_set_player_slot(peer_id, {
				name = peer:name(),
				peer_id = peer_id,
				level = level,
				character = character,
				progress = progress
			})
		end
	end
end

function ConnectionNetworkHandler:sync_chat_message(message, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	print("sync_chat_message peer", peer, peer:id())
	managers.menu:relay_chat_message(message, peer:id())
end

function ConnectionNetworkHandler:request_character(peer_id, character, sender)
	if not self._verify_sender(sender) then
		return
	end
	managers.network:game():on_peer_request_character(peer_id, character)
end

function ConnectionNetworkHandler:set_mask_set(peer_id, mask_set, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if not self._verify_gamestate(self._gamestate_filter.lobby) then
		return
	end
	peer:set_mask_set(mask_set)
	local lobby_menu = managers.menu:get_menu("lobby_menu")
	if lobby_menu and lobby_menu.renderer:is_open() then
		lobby_menu.renderer:set_character(peer_id, peer:character())
	end
	local kit_menu = managers.menu:get_menu("kit_menu")
	if kit_menu and kit_menu.renderer:is_open() then
		kit_menu.renderer:set_character(peer_id, peer:character())
	end
end

function ConnectionNetworkHandler:request_character_response(peer_id, character, sender)
	if not self._verify_sender(sender) then
		return
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return
	end
	peer:set_character(character)
	local lobby_menu = managers.menu:get_menu("lobby_menu")
	if lobby_menu and lobby_menu.renderer:is_open() then
		lobby_menu.renderer:set_character(peer_id, character)
	end
	local kit_menu = managers.menu:get_menu("kit_menu")
	if kit_menu and kit_menu.renderer:is_open() then
		kit_menu.renderer:set_character(peer_id, character)
	end
end

function ConnectionNetworkHandler:begin_trade()
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_respawn) then
		return
	end
	game_state_machine:current_state():begin_trade()
end

function ConnectionNetworkHandler:cancel_trade()
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_respawn) then
		return
	end
	game_state_machine:current_state():cancel_trade()
end

function ConnectionNetworkHandler:finish_trade()
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_respawn) then
		return
	end
	game_state_machine:current_state():finish_trade()
end

function ConnectionNetworkHandler:request_spawn_member(peer_id)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	IngameWaitingForRespawnState.request_player_spawn(peer_id)
end

function ConnectionNetworkHandler:hostage_trade_dialog(i)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_hostage_trade_dialog(i)
end

function ConnectionNetworkHandler:warn_about_civilian_free(i)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_warn_about_civilian_free(i)
end

function ConnectionNetworkHandler:request_drop_in_pause(peer_id, nickname, state, sender)
	managers.network:game():on_drop_in_pause_request_received(peer_id, nickname, state)
end

function ConnectionNetworkHandler:drop_in_pause_confirmation(dropin_peer_id, sender)
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	managers.network:session():on_drop_in_pause_confirmation_received(dropin_peer_id, sender_peer)
end

function ConnectionNetworkHandler:report_dead_connection(other_peer_id, sender)
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	managers.network:session():on_dead_connection_reported(sender_peer:id(), other_peer_id)
end

function ConnectionNetworkHandler:sanity_check_network_status(sender)
	if not self._verify_in_server_session() then
		sender:sanity_check_network_status_reply()
		return
	end
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		sender:sanity_check_network_status_reply()
		return
	end
end

function ConnectionNetworkHandler:sanity_check_network_status_reply(sender)
	if not self._verify_in_client_session() then
		return
	end
	local sender_peer = self._verify_sender(sender)
	if not sender_peer then
		return
	end
	local session = managers.network:session()
	if sender_peer ~= session:server_peer() then
		return
	end
	if session:is_expecting_sanity_chk_reply() then
		print("[ConnectionNetworkHandler:sanity_check_network_status_reply]")
		managers.network:session():on_peer_lost(sender_peer, sender_peer:id())
	end
end

function ConnectionNetworkHandler:dropin_progress(dropin_peer_id, progress_percentage, sender)
	if not self._verify_in_client_session() or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local session = managers.network:session()
	local dropin_peer = session:peer(dropin_peer_id)
	if not dropin_peer or dropin_peer_id == session:local_peer():id() then
		return
	end
	managers.network:game():on_dropin_progress_received(dropin_peer_id, progress_percentage)
end

function ConnectionNetworkHandler:set_member_ready(ready, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	local peer_id = peer:id()
	peer:set_waiting_for_player_ready(ready)
	managers.network:game():on_set_member_ready(peer_id, ready)
	if not Network:is_server() or game_state_machine:current_state().start_game_intro then
	elseif ready then
		managers.network:session():chk_spawn_member_unit(peer, peer_id)
	end
end

function ConnectionNetworkHandler:send_chat_message(channel_id, message, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	print("send_chat_message peer", peer, peer:id())
	managers.chat:receive_message_by_peer(channel_id, peer, message)
end

function ConnectionNetworkHandler:sync_outfit(outfit_string, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	peer:set_outfit_string(outfit_string)
	if managers.menu_scene then
		managers.menu_scene:set_lobby_character_out_fit(peer:id(), outfit_string)
	end
	local kit_menu = managers.menu:get_menu("kit_menu")
	if kit_menu then
		kit_menu.renderer:set_slot_outfit(peer:id(), peer:character(), outfit_string)
	end
end

function ConnectionNetworkHandler:sync_profile(level, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	peer:set_profile(level)
end

function ConnectionNetworkHandler:steam_p2p_ping(sender)
	print("[ConnectionNetworkHandler:steam_p2p_ping] from", sender:ip_at_index(0), sender:protocol_at_index(0))
	local session = managers.network:session()
	if not session or session:closing() then
		print("[ConnectionNetworkHandler:steam_p2p_ping] no session or closing")
		return
	end
	session:on_steam_p2p_ping(sender)
end

function ConnectionNetworkHandler:re_open_lobby_request(state, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		sender:re_open_lobby_reply(false)
		return
	end
	local session = managers.network:session()
	if session:closing() then
		sender:re_open_lobby_reply(false)
		return
	end
	session:on_re_open_lobby_request(peer, state)
end

function ConnectionNetworkHandler:re_open_lobby_reply(status, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	local session = managers.network:session()
	if session:closing() then
		return
	end
	managers.network.matchmake:from_host_lobby_re_opened(status)
end

function ConnectionNetworkHandler:feed_lootdrop(global_value, item_category, item_id, max_pc, item_pc, left_pc, right_pc, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if not managers.hud then
		return
	end
	local global_values = {
		"normal",
		"superior",
		"exceptional",
		"infamous"
	}
	local lootdrop_data = {
		peer,
		global_values[global_value] or "normal",
		item_category,
		item_id,
		max_pc,
		item_pc,
		left_pc,
		right_pc
	}
	managers.hud:feed_lootdrop_hud(lootdrop_data)
end

function ConnectionNetworkHandler:set_selected_lootcard(selected, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if managers.hud then
		managers.hud:set_selected_lootcard(peer:id(), selected)
	end
end

function ConnectionNetworkHandler:choose_lootcard(card_id, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if managers.hud then
		managers.hud:confirm_choose_lootcard(peer:id(), card_id)
	end
end
