NetworkMatchMakingXBL = NetworkMatchMakingXBL or class()
NetworkMatchMakingXBL.OPEN_SLOTS = 4
NetworkMatchMakingXBL.GAMEVERSION = 2
NetworkMatchMakingXBL.CANCEL_JOIN_SMARTMATCH_DELAY_T = 4
NetworkMatchMakingXBL.INEXACT_MATCH_CONFIRM_TIMEOUT = 30
NetworkMatchMakingXBL.SMARTMATCH_RE_ADVERTISE_PAUSE_T = 1
NetworkMatchMakingXBL.SMARTMATCH_HOST_TIMEOUT_T = 15
NetworkMatchMakingXBL.SMARTMATCH_CLIENT_TIMEOUT_T = 30
NetworkMatchMakingXBL.SMARTMATCH_CLIENT_TIMEOUT_T2 = 30
NetworkMatchMakingXBL.SMARTMATCH_STRICT = true

function NetworkMatchMakingXBL:init()
	self._callback_map = {}
	self._distance_filter = -1
	self._difficulty_filter = 0
	self._try_re_enter_lobby = nil
	self._players = {}
	self._next_cancel_callback_id = 0
	self._cancel_callback_map = {}
	self:set_server_joinable(true)
	print("[NetworkMatchMakingXBL:init]")
	managers.platform:add_event_callback("invite_accepted", callback(self, self, "invite_accepted_callback"))
end

function NetworkMatchMakingXBL:invite_accepted_callback(invitee_xuid)
	print("[NetworkMatchMakingXBL:invite_accepted_callback]", invitee_xuid)
	local invitation = XboxLive:accepted_invite()
	if not invitation then
		Application:error("NetworkMatchMakingXBL:invite_accepted_callback Invitation didn't contain anything")
		return
	end
	local invitee_xuid_str = tostring(invitee_xuid)
	Global.boot_invite = Global.boot_invite or {}
	if not Global.user_manager.user_index or not Global.user_manager.active_user_state_change_quit then
		print("BOOT UP INVITE")
		Global.boot_invite[invitee_xuid_str] = invitation
		return
	end
	if invitation.properties.NUMPLAYERS >= self.OPEN_SLOTS then
		print("game was already full")
		managers.menu:show_game_is_full()
		return
	end
	if managers.dlc:is_installing() then
		Global.boot_invite = nil
		managers.menu:show_game_is_installing()
		return
	end
	if not invitation.is_same_user then
		print("INACTIVE USER RECIEVED INVITE")
		Global.boot_invite[invitee_xuid_str] = nil
		managers.menu:show_inactive_user_accepted_invite({ok_func = nil})
		managers.user:invite_accepted_by_inactive_user()
		return
	end
	if game_state_machine:current_state_name() ~= "menu_main" then
		print("INGAME INVITE")
		Global.boot_invite[invitee_xuid_str] = invitation
		MenuCallbackHandler:_dialog_end_game_yes()
		return
	end
	if setup:has_queued_exec() then
		Global.queued_invite = invitation
		Global.queued_player = player_index
		return
	end
	self:_check_invite_requirements(invitation)
end

function NetworkMatchMakingXBL:join_boot_invite()
	local invitation = Global.boot_invite[tostring(managers.user:get_platform_id())]
	print("NetworkMatchMakingXBL:join_boot_invite()", invitation)
	if not invitation then
		return
	end
	if invitation.properties.NUMPLAYERS >= self.OPEN_SLOTS then
		print("game was already full")
		managers.menu:show_game_is_full()
		Global.boot_invite[tostring(managers.user:get_platform_id())] = nil
		return
	end
	if managers.dlc:is_installing() then
		Global.boot_invite = nil
		managers.menu:show_game_is_installing()
		return
	end
	self:_check_invite_requirements(invitation)
	Global.boot_invite[tostring(managers.user:get_platform_id())] = nil
end

function NetworkMatchMakingXBL:_check_invite_requirements(invitation)
	Global.game_settings.single_player = false
	self._test_invitation = invitation
	print("invitation\n", inspect(invitation))
	managers.menu:open_sign_in_menu(function(success)
		if not success then
			return
		end
		if self._session and self._session:id() == invitation.host_info:id() then
			print("Allready in that session")
			return
		end
		if invitation.host_info:id() == "(empty)" then
			managers.menu:show_invite_wrong_room_message()
			managers.menu:leave_online_menu()
			return
		end
		self._has_pending_invite = true
		self:_join_invite_accepted(invitation.host_info, invitation.properties.GAMERHOSTNAME)
	end)
end

function NetworkMatchMakingXBL:_join_invite_accepted(host_info, host_name)
	managers.system_menu:close("server_left_dialog")
	print("_join_invite_accepted", host_info)
	self._has_pending_invite = nil
	self._invite_host_info = host_info
	if self._session then
		print("MUST LEAVE session")
		MenuCallbackHandler:_dialog_leave_lobby_yes()
	end
	managers.system_menu:force_close_all()
	self:join_server_with_check(host_info:id(), true, {info = host_info, host_name = host_name})
end

function NetworkMatchMakingXBL:register_callback(event, callback)
	self._callback_map[event] = callback
end

function NetworkMatchMakingXBL:_call_callback(name, ...)
	if self._callback_map[name] then
		return self._callback_map[name](...)
	else
		Application:error("Callback " .. name .. " not found.")
	end
end

function NetworkMatchMakingXBL:_has_callback(name)
	if self._callback_map[name] then
		return true
	end
	return false
end

function NetworkMatchMakingXBL:_split_attribute_number(attribute_number, splitter)
	if not splitter or splitter == 0 or type(splitter) ~= "number" then
		Application:error("NetworkMatchMakingXBL:_split_attribute_number. splitter needs to be a non 0 number!", "attribute_number", attribute_number, "splitter", splitter)
		Application:stack_dump()
		return 1, 1
	end
	return attribute_number % splitter, math.floor(attribute_number / splitter)
end

function NetworkMatchMakingXBL:destroy_game()
	self:leave_game()
end

function NetworkMatchMakingXBL:add_cancelable_callback()
	self._next_cancel_callback_id = self._next_cancel_callback_id + 1
	self._cancel_callback_map[self._next_cancel_callback_id] = false
	return self._next_cancel_callback_id
end

function NetworkMatchMakingXBL:_find_server_callback(cancel_id, servers, mode)
	self._searching_lobbys = nil
	if self:check_callback_canceled(cancel_id) then
		return
	end
	self._last_mode = mode
	print("find_server_callback", mode, inspect(servers))
	if not servers then
		print("SEaRCH FAILED")
		return
	end
	local info = {
		room_list = {},
		attribute_list = {}
	}
	for _, server in ipairs(servers) do
		self._test_server = server
		print(inspect(server))
		table.insert(info.room_list, {
			owner_id = nil,
			owner_name = server.properties.GAMERHOSTNAME,
			xuid = server.properties.GAMERHOSTXUID,
			room_id = server.info:id(),
			info = server.info
		})
		table.insert(info.attribute_list, {
			numbers = self:_server_to_numbers(server)
		})
	end
	self:_call_callback("search_lobby", info)
	local player_index = managers.user:get_platform_id()
end

function NetworkMatchMakingXBL:check_callback_canceled(id)
	local is_canceled = self._cancel_callback_map[id]
	self._cancel_callback_map[id] = nil
	if not next(self._cancel_callback_map) then
		self._next_cancel_callback_id = 0
	end
	return is_canceled
end

function NetworkMatchMakingXBL:leave_game()
	print("NetworkMatchMakingXBL:leave_game()", self._session and self._session:state())
	Application:stack_dump()
	for id in pairs(self._cancel_callback_map) do
		self._cancel_callback_map[id] = true
	end
	self._join_smartmatch = nil
	self._queued_join_by_smartmatch = nil
	if self._session then
		XboxLive:cancel_smartmatch()
		local player_index = managers.user:get_platform_id()
		print("managers.user:get_platform_id()", managers.user:get_platform_id())
		print("  _leave and destroy", self._session)
		XboxLive:leave_local(self._session, player_index)
		print(" has left")
		XboxLive:delete_session(self._session)
		print(" has deleted")
		if self:_is_server() then
			self._server_last_alive_t = nil
			self._next_time_out_check_t = nil
		end
		self._session = nil
		self:set_server_joinable(true)
		print("NetworkMatchMakingXBL:leave_game() done")
		Application:stack_dump()
	else
		cat_print("multiplayer", "Dont have a session!?")
	end
	self:_is_server(false)
	self:_is_client(false)
	self._game_owner_name = nil
end

function NetworkMatchMakingXBL:_load_globals()
	if Global.xbl and Global.xbl.match then
		self._session = Global.xbl.match.session
		self._server_rpc = Global.xbl.match.server_rpc
		self._game_owner_name = Global.xbl.match.game_owner_name
		self._num_players = Global.xbl.match.num_players
		self._is_server_var = Global.xbl.match.is_server
		self._is_client_var = Global.xbl.match.is_client
		self._players = Global.xbl.match.players
		self._hopper_variables = Global.xbl.match.hopper_variables
		self._host_session_attributes = Global.xbl.match.host_session_attributes
		Global.xbl.match = nil
	end
	if Global.queued_invite then
		Global.boot_invite[Global.queued_player] = Global.queued_invite
		MenuCallbackHandler:_dialog_end_game_yes()
		Global.queued_invite = nil
	end
end

function NetworkMatchMakingXBL:_save_globals()
	Global.xbl = Global.xbl or {}
	Global.xbl.match = {}
	Global.xbl.match.session = self._session
	Global.xbl.match.server_rpc = self._server_rpc
	Global.xbl.match.game_owner_name = self._game_owner_name
	Global.xbl.match.num_players = self._num_players
	Global.xbl.match.is_server = self._is_server_var
	Global.xbl.match.is_client = self._is_client_var
	Global.xbl.match.players = self._players
	Global.xbl.match.hopper_variables = self._hopper_variables
	Global.xbl.match.host_session_attributes = self._host_session_attributes
end

function NetworkMatchMakingXBL:update()
	self:_chk_advertise_session_for_smartmatch()
	self:_update_queued_join_by_smartmatch()
end

function NetworkMatchMakingXBL:_chk_advertise_session_for_smartmatch()
	if self._session and managers.network:session() and managers.network:session():is_host() and self:is_server_joinable() and XboxLive:smartmatch_state() ~= "searching" and self:is_host_lobby_public() then
		self._smartmatch_idle_start_t = self._smartmatch_idle_start_t or TimerManager:wall_running():time()
		if TimerManager:wall_running():time() - self._smartmatch_idle_start_t > self.SMARTMATCH_RE_ADVERTISE_PAUSE_T then
			print("[NetworkMatchMakingXBL:_chk_advertise_session_for_smartmatch] re-submitting session")
			self._smartmatch_idle_start_t = nil
			print([[

**************]] .. (self._host_smartmatch_strict and "SEARCHING STRICT" or "SEARCHING ANY") .. "**************\n")
			local smartmatch_params = {
				timeout = self.SMARTMATCH_HOST_TIMEOUT_T,
				hopper_name = self._host_smartmatch_strict and "hopper_match_game_strict_v1" or "hopper_match_game_any_v1",
				become_host = true
			}
			if self.SMARTMATCH_STRICT then
				self._host_smartmatch_strict = not self._host_smartmatch_strict
			end
			local progress_callback = callback(self, self, "clbk_smartmatch_host", {
				cancel_id = self:add_cancelable_callback(),
				smartmatch_params = smartmatch_params
			})
			self:_begin_smartmatch(smartmatch_params, progress_callback)
		else
			print("countdown to new smartmatch", self.SMARTMATCH_RE_ADVERTISE_PAUSE_T + self._smartmatch_idle_start_t - TimerManager:wall_running():time())
		end
	else
		self._smartmatch_idle_start_t = nil
	end
end

function NetworkMatchMakingXBL:get_friends_lobbies()
end

function NetworkMatchMakingXBL:search_friends_only()
	return self._search_friends_only
end

function NetworkMatchMakingXBL:distance_filter()
	return self._distance_filter
end

function NetworkMatchMakingXBL:set_distance_filter(filter)
	self._distance_filter = filter
end

function NetworkMatchMakingXBL:difficulty_filter()
	return self._difficulty_filter
end

function NetworkMatchMakingXBL:set_difficulty_filter(filter)
	self._difficulty_filter = filter
end

function NetworkMatchMakingXBL:get_lobby_return_count()
end

function NetworkMatchMakingXBL:set_lobby_return_count(lobby_return_count)
end

function NetworkMatchMakingXBL:lobby_filters()
end

function NetworkMatchMakingXBL:set_lobby_filters(filters)
end

function NetworkMatchMakingXBL:add_lobby_filter(key, value, comparision_type)
end

function NetworkMatchMakingXBL:search_lobby(friends_only)
	if self._searching_lobbys then
		print("Allready searching lobbys, waiting result")
		return
	end
	self._search_friends_only = friends_only
	if not self:_has_callback("search_lobby") then
		return
	end
	local prop = {}
	prop.MINLEVEL = managers.experience:current_level()
	prop.GAMEVERSION = self.GAMEVERSION
	local con = {}
	con.GAME_TYPE = "STANDARD"
	con.game_mode = "ONLINE"
	self._searching_lobbys = true
end

function NetworkMatchMakingXBL:_find_server_callback(cancel_id, servers, mode)
	self._searching_lobbys = nil
	if self:check_callback_canceled(cancel_id) then
		return
	end
	self._last_mode = mode
	print("find_server_callback", mode, inspect(servers))
	if not servers then
		print("SEaRCH FAILED")
		return
	end
	local info = {
		room_list = {},
		attribute_list = {}
	}
	for _, server in ipairs(servers) do
		self._test_server = server
		print(inspect(server))
		table.insert(info.room_list, {
			owner_id = nil,
			owner_name = server.properties.GAMERHOSTNAME,
			xuid = server.properties.GAMERHOSTXUID,
			room_id = server.info:id(),
			info = server.info
		})
		table.insert(info.attribute_list, {
			numbers = self:_server_to_numbers(server)
		})
	end
	self:_call_callback("search_lobby", info)
end

function NetworkMatchMakingXBL:searching_lobbys()
	return self._searching_lobbys
end

function NetworkMatchMakingXBL:search_lobby_done()
	managers.system_menu:close("find_server")
	self.browser = nil
end

function NetworkMatchMakingXBL:game_owner_name()
	return self._game_owner_name
end

function NetworkMatchMakingXBL:is_server_ok(friends_only, session_id, attributes_numbers)
	local permission = tweak_data:index_to_permission(attributes_numbers[3])
	local level_index, job_index = self:_split_attribute_number(attributes_numbers[1], 1000)
	if not tweak_data.levels:get_level_name_from_index(level_index) then
		Application:error("No level data for index " .. level_index .. ". Payday1 data not compatible with Payday2.")
		return false
	end
	if (not NetworkManager.DROPIN_ENABLED or attributes_numbers[6] == 0) and attributes_numbers[4] ~= 1 then
		return false, 1
	end
	if managers.experience:current_level() < attributes_numbers[7] then
		return false, 3
	end
	if permission == "private" then
		return false, 2
	end
	if permission == "public" then
		return true
	end
	return true
end

function NetworkMatchMakingXBL:join_server_with_check(session_id, skip_permission_check, data)
	print("NetworkMatchMakingXBL:join_server_with_check", session_id)
	local player_index = managers.user:get_platform_id()
	managers.menu:show_joining_lobby_dialog()
	local empty = function()
	end
	local cancel_id = self:add_cancelable_callback()
	
	local function f(servers)
		if self:check_callback_canceled(cancel_id) then
			return
		end
		print("servers", servers)
		if not servers or not servers[1] then
			managers.system_menu:close("join_server")
			if managers.user:signed_in_state() ~= "signed_in_to_live" then
				managers.menu:xbox_disconnected()
			else
				managers.menu:show_game_no_longer_exists()
			end
			return
		end
		print("NetworkMatchMakingXBL:join_server_with_check f", inspect(servers[1]))
		print("SELF", self, player_index)
		local server_ok, ok_error = true
		if server_ok then
			print("CALL JOIN SERVER", servers[1].info)
			self._game_owner_name = data.host_name
			self:join_server(session_id, servers[1], true)
		else
			managers.system_menu:close("join_server")
			if ok_error == 1 then
				managers.menu:show_game_started_dialog()
			elseif ok_error == 2 then
				managers.menu:show_game_permission_changed_dialog()
			elseif ok_error == 3 then
				managers.menu:show_too_low_level()
			elseif ok_error == 4 then
				managers.menu:show_does_not_own_heist()
			end
			self:search_lobby(self:search_friends_only())
		end
	end
	
	if data and data.info then
		f({
			{
				info = data.info,
				host_name = data.host_name,
				open_private_slots = 0
			}
		})
	else
		debug_pause("[NetworkMatchMakingXBL:join_server_with_check] Missing data.", inspect(data))
		f({})
	end
end

function NetworkMatchMakingXBL._on_data_update(...)
end

function NetworkMatchMakingXBL._on_chat_message(user, message)
	print("[NetworkMatchMakingXBL._on_chat_message]", user, message)
end

function NetworkMatchMakingXBL._handle_chat_message(user, message)
	local s = "" .. message
	managers.chat:receive_message_by_name(ChatManager.GLOBAL, user:name(), s)
end

function NetworkMatchMakingXBL:_update_queued_join_by_smartmatch()
	if not self._queued_join_by_smartmatch then
		return
	end
	if self._last_join_smartmatch_cancel_t and TimerManager:wall():time() - self._last_join_smartmatch_cancel_t < self.CANCEL_JOIN_SMARTMATCH_DELAY_T then
		print("timing out smartmatch join request", self._last_join_smartmatch_cancel_t + self.CANCEL_JOIN_SMARTMATCH_DELAY_T - TimerManager:wall():time())
		return
	end
	if self._join_smartmatch then
		print("[NetworkMatchMakingXBL:join_by_smartmatch] smartmatch already in progress")
		return
	end
	local params = self._queued_join_by_smartmatch
	self._queued_join_by_smartmatch = nil
	self:_join_by_smartmatch(params.job_id_filter, params.difficulty_filter)
end

function NetworkMatchMakingXBL:_join_by_smartmatch(job_id_filter, difficulty_filter)
	print("[NetworkMatchMakingXBL:_join_by_smartmatch] job_id_filter", job_id_filter, "difficulty_filter", difficulty_filter)
	self._server_rpc = nil
	self._session = nil
	if job_id_filter == -1 then
		print("[NetworkMatchMakingXBL:_join_by_smartmatch] searching inexact")
		self._smartmatch_search_inexact = true
	else
		print("[NetworkMatchMakingXBL:_join_by_smartmatch] searching exact")
		self._smartmatch_search_inexact = nil
	end
	self._join_smartmatch = "search"
	local player_index = managers.user:get_platform_id()
	if self._session then
		XboxLive:leave_local(self._session, player_index)
		XboxLive:delete_session(self._session)
		self._session = nil
	end
	XboxLive:clear_sessions()
	XboxLive:set_context("GAME_TYPE", "STANDARD")
	XboxLive:set_context("game_mode", "ONLINE")
	self._hopper_variables = {
		NrHosts = 0,
		NrClients = 1,
		PrefMission = tostring(job_id_filter == -1 and job_id_filter or tweak_data.narrative:get_index_from_job_id(job_id_filter)),
		PrefDifficulty = difficulty_filter,
		PlayerLevel = self:_get_smartmatch_player_level()
	}
	local clbk_params = {
		cancel_id = self:add_cancelable_callback()
	}
	local progress_clbk = callback(self, self, "clbk_create_client_lobby", clbk_params)
	local status = XboxLive:create_session("smartmatch_host_game_v1", false, progress_clbk)
	print(" [NetworkMatchMakingXBL:join_by_smartmatch] create_session status", status)
	if not status then
		print(" failed to create session")
		managers.menu:show_failed_joining_dialog()
		self:leave_game()
		return
	end
end

function NetworkMatchMakingXBL:join_by_smartmatch(job_id_filter, difficulty_filter)
	print("[NetworkMatchMakingXBL:join_by_smartmatch] job_id_filter", job_id_filter, "difficulty_filter", difficulty_filter)
	if self._join_smartmatch then
		return
	end
	if not self._queued_join_by_smartmatch then
		local dialog_params = {
			cancel_func = callback(self, self, "clbk_btn_cancel_match")
		}
		managers.menu:show_searching_match_dialog(dialog_params)
	end
	self._queued_join_by_smartmatch = {job_id_filter = job_id_filter, difficulty_filter = difficulty_filter}
	return true
end

function NetworkMatchMakingXBL:clbk_btn_cancel_match()
	print("[NetworkMatchMakingXBL:clbk_btn_cancel_match]")
	self._join_smartmatch = nil
	self._queued_join_by_smartmatch = nil
	self._last_join_smartmatch_cancel_t = TimerManager:wall():time()
	self:leave_game()
end

function NetworkMatchMakingXBL:clbk_create_client_lobby(params, session)
	print("[NetworkMatchMakingXBL:clbk_create_client_lobby] session", session)
	if not self._join_smartmatch then
		self:leave_game()
		return
	end
	if not session then
		self:leave_game()
		managers.menu:show_failed_joining_dialog()
		return
	end
	self._session = session
	local smartmatch_params = {
		timeout = self.SMARTMATCH_CLIENT_TIMEOUT_T,
		hopper_name = self._smartmatch_search_inexact and "hopper_match_game_any_v1" or "hopper_match_game_strict_v1",
		become_host = false
	}
	local progress_callback = callback(self, self, "clbk_smartmatch_client", {
		cancel_id = self:add_cancelable_callback(),
		smartmatch_params = smartmatch_params
	})
	local status = self:_begin_smartmatch(smartmatch_params, progress_callback)
	if not status then
		print(" smartmatch failed to start")
		managers.menu:show_failed_joining_dialog()
		self:leave_game()
		return
	end
end

function NetworkMatchMakingXBL:clbk_join_session_result(status)
	print("[NetworkMatchMakingXBL:clbk_join_session_result] self._session", self._session, "status", status)
	managers.system_menu:close("join_server")
	managers.system_menu:close("search_match")
	if status == "search_failed" then
		self:leave_game()
		managers.menu:show_smartmatch_contract_not_found_dialog()
		return
	elseif status == "p2p_error" then
		self:leave_game()
		managers.menu:show_failed_joining_dialog()
		return
	elseif not status then
		local is_full = self._session:nr_members() >= self.OPEN_SLOTS
		self:leave_game()
		if is_full then
			managers.menu:show_game_is_full()
		else
			managers.menu:show_failed_joining_dialog()
		end
		return
	end
	self._server_rpc = self._session and Network:handshake(self._session:ip(), managers.network.DEFAULT_PORT, "TCP_IP")
	print(" Server RPC:", self._server_rpc and self._server_rpc:ip_at_index(0))
	if not self._server_rpc then
		self:leave_game()
		managers.menu:show_failed_joining_dialog()
		return
	end
	self._players = {}
	self:_is_server(false)
	self:_is_client(true)
	managers.network.voice_chat:open_session()
	managers.network:start_client()
	managers.menu:show_waiting_for_server_response({
		cancel_func = function()
			managers.network:session():on_join_request_cancelled()
		end
	})
	local joined_game = function(res, level_index, difficulty_index, state_index)
		managers.system_menu:close("waiting_for_server_response")
		print("[NetworkMatchMakingXBL:clbk_join_session_result:joined_game] res", res, "level_index", level_index, "difficulty_index", difficulty_index, "state_index", state_index)
		if res == "JOINED_LOBBY" then
			MenuCallbackHandler:crimenet_focus_changed(nil, false)
			managers.menu:on_enter_lobby()
		elseif res == "JOINED_GAME" then
			local level_id = tweak_data.levels:get_level_name_from_index(level_index)
			Global.game_settings.level_id = level_id
		elseif res == "KICKED" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_peer_kicked_dialog()
		elseif res == "TIMED_OUT" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_request_timed_out_dialog()
		elseif res == "GAME_STARTED" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_game_started_dialog()
		elseif res == "DO_NOT_OWN_HEIST" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_does_not_own_heist()
		elseif res == "CANCELLED" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
		elseif res == "FAILED_CONNECT" or res == "AUTH_FAILED" or res == "AUTH_HOST_FAILED" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_failed_joining_dialog()
		elseif res == "GAME_FULL" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_game_is_full()
		elseif res == "LOW_LEVEL" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_too_low_level()
		elseif res == "WRONG_VERSION" then
			managers.network.matchmake:leave_game()
			managers.network.voice_chat:destroy_voice()
			managers.network:queue_stop_network()
			managers.menu:show_wrong_version_message()
		else
			Application:error("[NetworkMatchMakingXBL:join_server] FAILED TO START MULTIPLAYER!", res)
		end
	end
	managers.network:join_game_at_host_rpc(self._server_rpc, joined_game)
end

function NetworkMatchMakingXBL:join_server(session_id, server, skip_showing_dialog)
	local xs_info = server.info
	if not skip_showing_dialog then
		managers.menu:show_joining_lobby_dialog()
	end
	local player_index = managers.user:get_platform_id()
	print("[NetworkMatchMakingXBL:join_server]", xs_info, xs_info:id())
	if self._session then
		XboxLive:leave_local(self._session, player_index)
		XboxLive:delete_session(self._session)
	end
	XboxLive:clear_sessions()
	XboxLive:set_context("GAME_TYPE", "STANDARD")
	XboxLive:set_context("game_mode", "ONLINE")
	local permission = server.open_private_slots > 0 and "private" or "public"
	local pub_slots = self.OPEN_SLOTS
	local priv_slots = 0
	self._private = false
	if permission == "private" then
		pub_slots = 0
		priv_slots = self.OPEN_SLOTS
		self._private = true
	end
	self._session = XboxLive:create_session_object_from_info("live_multiplayer_standard", player_index, pub_slots, priv_slots, xs_info)
	local result = "success"
	if not self._session then
		print(" [NetworkMatchMakingXBL:join_server] FAILED TO CREATE CLIENT SESSION")
		result = "failed"
	end
	if not XboxLive:join_local(self._session, player_index, self._private, callback(self, self, "clbk_join_session_result")) then
		self:leave_game()
		managers.menu:show_failed_joining_dialog()
		self:search_lobby(self:search_friends_only())
	end
end

function NetworkMatchMakingXBL:send_join_invite(friend)
end

function NetworkMatchMakingXBL:set_server_attributes(settings)
	self:set_attributes(settings)
	if self._session then
		XboxLive:modify_session(self._session)
	end
end

function NetworkMatchMakingXBL:create_lobby(settings)
	local attributes_numbers = settings.numbers
	self._num_players = nil
	self:set_server_joinable(true)
	print("[NetworkMatchMakingXBL:create_lobby]", inspect(settings))
	settings.numbers[4] = 1
	self:set_attributes(settings)
	local player_index = managers.user:get_platform_id()
	local gt = "STANDARD"
	local gm = "ONLINE"
	XboxLive:set_context("GAME_TYPE", gt)
	XboxLive:set_context("game_mode", gm)
	if self._session and self._session:state() == "started" then
		XboxLive:leave_local(self._session, player_index)
		XboxLive:delete_session(self._session, function()
			print("DELETED SESSION")
		end)
	end
	local permission = tweak_data:index_to_permission(attributes_numbers[3])
	local pub_slots = self.OPEN_SLOTS
	local priv_slots = 0
	self._private = false
	if permission == "private" then
		pub_slots = 0
		priv_slots = self.OPEN_SLOTS
		self._private = true
	end
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_creating_lobby_title")
	dialog_data.text = managers.localization:text("dialog_wait")
	dialog_data.id = "create_lobby"
	dialog_data.no_buttons = true
	managers.system_menu:show(dialog_data)
	if self:is_host_lobby_public() then
		self._hopper_variables = {
			NrHosts = 1,
			NrClients = 0,
			PrefMission = tostring(tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id())),
			PrefDifficulty = tweak_data:difficulty_to_index(Global.game_settings.difficulty),
			PlayerLevel = self:_get_smartmatch_player_level()
		}
	end
	local success = XboxLive:create_session("smartmatch_host_game_v1", true, callback(self, self, "_create_lobby_callback", {
		cancel_id = self:add_cancelable_callback(),
		settings = settings
	}))
	print("[NetworkMatchMakingXBL:create_lobby] create_session result", success)
end

function NetworkMatchMakingXBL:_create_lobby_failed()
	self:_create_lobby_done()
	local title = managers.localization:text("dialog_error_title")
	local dialog_data = {
		title = title,
		text = managers.localization:text("dialog_err_failed_creating_lobby")
	}
	dialog_data.button_list = {
		{
			text = managers.localization:text("dialog_ok")
		}
	}
	managers.system_menu:show(dialog_data)
end

function NetworkMatchMakingXBL:_create_lobby_done()
	self._creating_lobby = nil
	managers.system_menu:close("create_lobby")
end

function NetworkMatchMakingXBL:clbk_smartmatch_host(params, session, smartmatch_status)
	print("[NetworkMatchMakingXBL:clbk_smartmatch_host] params\n", inspect(params), "session", session, "status:", smartmatch_status)
end

function NetworkMatchMakingXBL:_begin_smartmatch(params, progress_clbk)
	print("[NetworkMatchMakingXBL:_begin_smartmatch] self._hopper_variables", inspect(self._hopper_variables))
	local status = XboxLive:begin_smartmatch(self._session, progress_clbk, params.timeout, params.hopper_name, params.become_host, self._hopper_variables)
	if not status then
		print("[NetworkMatchMakingXBL:_begin_smartmatch] smartmatch failed to start", status)
	end
	return status
end

function NetworkMatchMakingXBL:_create_lobby_callback(params, session)
	if self:check_callback_canceled(params.cancel_id) then
		cat_print("lobby", "create_server canceled")
		return
	end
	print("[NetworkMatchMakingXBL:_create_lobby_callback]", inspect(params.settings))
	if not session then
		print(" CREATE SESSION FAILED")
		self:_create_lobby_failed()
		return
	end
	if alive(self._session) then
		cat_print("lobby", "Trying to remove self._session", self._session:id(), "in state", self._session:state())
		cat_stack_dump("lobby")
	end
	self._session = session
	print(" Created mm session ", self._session:id())
	self._trytime = nil
	self._players = {}
	self._server_rpc = nil
	self:_is_server(true)
	self:_is_client(false)
	managers.network.voice_chat:open_session()
	self:_create_lobby_done()
	managers.menu:created_lobby()
end

function NetworkMatchMakingXBL:clbk_smartmatch_client_inexact_join_yes()
	self:clbk_join_session_result(true)
end

function NetworkMatchMakingXBL:clbk_smartmatch_client_inexact_join_no()
	managers.system_menu:close("join_server")
	managers.system_menu:close("search_match")
	self:leave_game()
end

function NetworkMatchMakingXBL:clbk_smartmatch_client(params, session, smartmatch_status)
	print("[NetworkMatchMakingXBL:clbk_smartmatch_client] params", inspect(params), "session", session, "status:", smartmatch_status)
	if self:check_callback_canceled(params.cancel_id) then
		cat_print("lobby", "smartmatch was canceled")
		return
	end
	if self._server_rpc then
		return
	end
	if self._join_smartmatch ~= "search" then
		return
	end
	if smartmatch_status == "found" then
		print("[NetworkMatchMakingXBL:clbk_smartmatch_client] " .. (self._smartmatch_search_inexact and "result any" or "result strict"))
		local pref_mission = self._hopper_variables.PrefMission
		local pref_difficulty = self._hopper_variables.PrefDifficulty
		local session_mission_nr = session:get_property("LEVELINDEX", "NUMBER")
		if not session_mission_nr then
			print(" broken session_mission_nr")
			self._session = session
			self:clbk_join_session_result(false)
			self._session = nil
			return
		end
		session_mission_nr = math.floor(session_mission_nr / 1000)
		local session_mission = tostring(session_mission_nr)
		local session_difficulty = session:get_property("DIFFICULTY", "NUMBER")
		if not session_difficulty then
			print(" broken session_difficulty")
			self._session = session
			self:clbk_join_session_result(false)
			self._session = nil
			return
		end
		self._session = session
		print("requested: pref_mission", pref_mission, "pref_difficulty", pref_difficulty)
		print("found: session_mission", session_mission, "session_difficulty", session_difficulty)
		local is_inexact_match
		if pref_mission == "-1" then
		elseif not is_inexact_match then
			if pref_mission ~= session_mission then
				is_inexact_match = true
				print(" mission mismatch")
			elseif pref_difficulty ~= session_difficulty then
				is_inexact_match = true
				print(" difficulty mismatch")
			end
		end
		if is_inexact_match then
			print(" inexact match")
			managers.system_menu:close("search_match")
			self._join_smartmatch = "confirm_inexact"
			local params = {
				yes_clbk = callback(self, self, "clbk_smartmatch_client_inexact_join_yes"),
				no_clbk = callback(self, self, "clbk_smartmatch_client_inexact_join_no"),
				timeout_clbk = callback(self, self, "clbk_smartmatch_client_inexact_join_no"),
				timeout = self.INEXACT_MATCH_CONFIRM_TIMEOUT,
				host_name = session:get_property("GAMERHOSTNAME", "STRING"),
				job_name = managers.localization:text(tweak_data.narrative.jobs[tweak_data.narrative:get_job_name_from_index(session_mission_nr)].name_id),
				difficulty = managers.localization:text(tweak_data.difficulty_name_ids[tweak_data.difficulties[session_difficulty]])
			}
			managers.menu:show_smartmatch_inexact_match_dialog(params)
		else
			self:clbk_join_session_result(true)
		end
	elseif smartmatch_status == "failed" then
		local searching_again
		if not self._smartmatch_search_inexact and self.SMARTMATCH_STRICT then
			print(" searching inexact")
			local dialog = managers.system_menu:get_dialog("search_match")
			local new_text = managers.localization:text("dialog_exact_match_not_found") .. " " .. managers.localization:text("dialog_wait")
			dialog:set_text(new_text, true)
			self._smartmatch_search_inexact = true
			local smartmatch_params = {
				timeout = self.SMARTMATCH_CLIENT_TIMEOUT_T2,
				hopper_name = "hopper_match_game_any_v1",
				become_host = false
			}
			local progress_callback = callback(self, self, "clbk_smartmatch_client", {
				cancel_id = self:add_cancelable_callback(),
				smartmatch_params = smartmatch_params
			})
			local status = self:_begin_smartmatch(smartmatch_params, progress_callback)
			if status then
				searching_again = true
			else
				print(" non-strict smartmatch failed to start")
			end
		end
		if not searching_again then
			self._session = session
			self:clbk_join_session_result("search_failed")
			self._session = nil
		end
	elseif smartmatch_status == "error" then
		self._session = session
		self:clbk_join_session_result("search_failed")
		self._session = nil
	elseif smartmatch_status == "p2p_error" then
		self._session = session
		self:clbk_join_session_result(smartmatch_status)
		self._session = nil
	end
end

function NetworkMatchMakingXBL:set_num_players(num)
	print("NetworkMatchMakingXBL:set_num_players", num)
	local player_index = managers.user:get_platform_id()
	self._num_players = num
	XboxLive:set_property("NUMPLAYERS", self._num_players)
end

function NetworkMatchMakingXBL:set_server_state(state)
	local player_index = managers.user:get_platform_id()
	local state_id = tweak_data:server_state_to_index(state)
	XboxLive:set_property("SERVERSTATE", state_id)
end

function NetworkMatchMakingXBL:set_server_joinable(state)
	print("[NetworkMatchMakingXBL:set_server_joinable]", state)
	Application:stack_dump()
	self._server_joinable_state = state
	if self._session then
		XboxLive:set_joinable(self._session, state and true)
	end
end

function NetworkMatchMakingXBL:is_server_joinable()
	return self._server_joinable_state and XboxLive:is_joinable(self._session)
end

function NetworkMatchMakingXBL:server_state_name()
end

function NetworkMatchMakingXBL:on_peer_added(peer)
	print("NetworkMatchMakingXBL:on_peer_added", peer:id(), peer:xuid(), self._session, self._private)
	if managers.network:session() and managers.network:session():local_peer() == peer or type(peer:xuid()) == "string" then
		print("  Dont add local peer or empty string")
		return
	end
	if not self._session then
		Application:error("NetworkMatchMakingXBL:on_peer_added, had no session!")
		return
	end
	self._players[peer:id()] = peer:xuid()
	XboxLive:set_up_p2p_in_session(self._session)
	if SystemInfo:platform() == Idstring("XB1") and not peer:xnaddr() then
		return
	end
	XboxLive:join_remote(self._session, peer:xuid(), self._private or false)
	local player_info = {}
	player_info.name = peer:name()
	player_info.player_id = peer:xuid()
	player_info.external_address = peer:xnaddr()
	managers.network.voice_chat:open_channel_to(player_info, "game")
end

function NetworkMatchMakingXBL:on_peer_removed(peer)
	print("NetworkMatchMakingXBL:on_peer_removed", peer:id(), peer:xuid(), self._session)
	if type(peer:xuid()) == "string" then
		print("  Dont remove peer with empty string")
		return
	end
	if not self._session then
		Application:error("NetworkMatchMakingXBL:on_peer_removed, had no session!")
		return
	end
	self._players[peer:id()] = nil
	XboxLive:leave_remote(self._session, peer:xuid())
	local player_info = {}
	player_info.name = peer:name()
	player_info.player_id = peer:xuid()
	managers.network.voice_chat:close_channel_to(player_info)
end

function NetworkMatchMakingXBL:is_host_lobby_public()
	return self._host_session_attributes and self._host_session_attributes.numbers[3] == 1
end

function NetworkMatchMakingXBL:set_attributes(settings)
	local player_index = managers.user:get_platform_id()
	XboxLive:set_property("LEVELINDEX", settings.numbers[1])
	XboxLive:set_property("DIFFICULTY", settings.numbers[2])
	XboxLive:set_property("PERMISSION", settings.numbers[3])
	XboxLive:set_property("SERVERSTATE", settings.numbers[4] or XboxLive:get_property("SERVERSTATE"))
	XboxLive:set_property("NUMPLAYERS", self._num_players or 1)
	XboxLive:set_property("ALLOWDROPIN", settings.numbers[6])
	XboxLive:set_property("MINLEVEL", settings.numbers[7])
	XboxLive:set_property("GAMEVERSION", self.GAMEVERSION)
	self._host_session_attributes = settings
end

function NetworkMatchMakingXBL:_server_to_numbers(server)
	local properties = server.properties
	return {
		tonumber(properties.LEVELINDEX),
		tonumber(properties.DIFFICULTY),
		tonumber(properties.PERMISSION),
		tonumber(properties.SERVERSTATE),
		tonumber(properties.NUMPLAYERS),
		tonumber(properties.ALLOWDROPIN),
		tonumber(properties.MINLEVEL)
	}
end

function NetworkMatchMakingXBL:external_address(rpc)
	if not self._session then
		Application:error("NetworkMatchMakingXBL:translate_to_xnaddr, had no session!")
		return ""
	end
	return XboxLive:external_address(rpc)
end

function NetworkMatchMakingXBL:internal_address(xuid)
	if not self._session then
		Application:error("NetworkMatchMakingXBL:internal_address, had no session!")
		Application:stack_dump("error")
		return
	end
	local address = XboxLive:internal_address(self._session, xuid)
	print("[NetworkMatchMakingXBL:internal_address] xuid", xuid, address)
	Application:stack_dump()
	return address
end

function NetworkMatchMakingXBL:from_host_lobby_re_opened(status)
	print("[NetworkMatchMakingXBL::from_host_lobby_re_opened]", self._try_re_enter_lobby, status)
	if self._try_re_enter_lobby == "asked" then
		if status then
			self._try_re_enter_lobby = "open"
		else
			self._try_re_enter_lobby = nil
			managers.network.matchmake:leave_game()
		end
	end
end

function NetworkMatchMakingXBL:_test_search(settings)
	local player_index = managers.user:get_platform_id()
	local prop = {}
	prop.MINLEVEL = managers.experience:current_level()
	local con = {}
	con.GAME_TYPE = settings.game_type
	con.game_mode = settings.game_mode
	XboxLive:search_session("Find Matches", player_index, 25, prop, con, callback(self, self, "_find_test_server_callback", self:add_cancelable_callback()))
end

function NetworkMatchMakingXBL:_find_test_server_callback(cancel_id, servers, mode)
	if self:check_callback_canceled(cancel_id) then
		return
	end
	self._last_mode = mode
	print("_find_test_server_callback", mode, inspect(servers))
	if not servers then
		print("SEaRCH FAILED")
		return
	end
	self._test_servers = {}
	for _, server in ipairs(servers) do
		self._test_server = server
		table.insert(self._test_servers, server)
		print(inspect(server))
	end
	local player_index = managers.user:get_platform_id()
end

function NetworkMatchMakingXBL:_test_join(xs_info, skip_showing_dialog)
	xs_info = xs_info or self._test_server.info
	local player_index = managers.user:get_platform_id()
	print("_test_join", xs_info)
	if self._session then
		XboxLive:leave_local(self._session, player_index)
		XboxLive:delete_session(self._session)
	end
	self._session = XboxLive:create_session_object_from_info("live_multiplayer_standard", player_index, 4, 0, xs_info)
	if not self._session then
		print("FAILED CREATE CLIENT SESSION")
		return
	end
	if not XboxLive:join_local(self._session, player_index, true) then
		return
	end
	print("self._session", self._session)
	local result = "failed"
	print("[NetworkMatchMakingXBL:join_server:f]")
	managers.system_menu:close("join_server")
	if result == "success" then
		print("Success!")
		print("[NetworkMatchMakingXBL:join_server] server details", self._session:ip(), self._session:id())
		print("Gonna handshake now!")
		self._server_rpc = Network:handshake(self._session:ip(), nil, "TCP_IP")
		print("Handshook!")
		print("Server RPC:", self._server_rpc and self._server_rpc:ip_at_index(0))
		if not self._server_rpc then
			return
		end
		managers.network:start_client()
		managers.menu:show_waiting_for_server_response({
			cancel_func = function()
				managers.network:session():on_join_request_cancelled()
			end
		})
		local joined_game = function(res, level_index, difficulty_index, state_index)
			managers.system_menu:close("waiting_for_server_response")
			print("[NetworkMatchMakingXBL:join_server:joined_game]", res, level_index, difficulty_index, state_index)
			if res == "JOINED_LOBBY" then
				managers.network.voice_chat:open_session()
				MenuCallbackHandler:crimenet_focus_changed(nil, false)
				managers.menu:on_enter_lobby()
			elseif res == "JOINED_GAME" then
				local level_id = tweak_data.levels:get_level_name_from_index(level_index)
				Global.game_settings.level_id = level_id
			elseif res == "KICKED" then
				managers.network.matchmake:leave_game()
				managers.network.voice_chat:destroy_voice()
				managers.network:queue_stop_network()
				managers.menu:show_peer_kicked_dialog()
			elseif res == "TIMED_OUT" then
				managers.network.matchmake:leave_game()
				managers.network.voice_chat:destroy_voice()
				managers.network:queue_stop_network()
				managers.menu:show_request_timed_out_dialog()
			elseif res == "GAME_STARTED" then
				managers.network.matchmake:leave_game()
				managers.network.voice_chat:destroy_voice()
				managers.network:queue_stop_network()
				managers.menu:show_game_started_dialog()
			elseif res == "DO_NOT_OWN_HEIST" then
				managers.network.matchmake:leave_game()
				managers.network.voice_chat:destroy_voice()
				managers.network:queue_stop_network()
				managers.menu:show_does_not_own_heist()
			elseif res == "CANCELLED" then
				managers.network.matchmake:leave_game()
				managers.network.voice_chat:destroy_voice()
				managers.network:queue_stop_network()
			elseif res == "FAILED_CONNECT" or res == "AUTH_FAILED" or res == "AUTH_HOST_FAILED" then
				managers.network.matchmake:leave_game()
				managers.network.voice_chat:destroy_voice()
				managers.network:queue_stop_network()
				managers.menu:show_failed_joining_dialog()
			else
				Application:error("[NetworkMatchMakingXBL:join_server] FAILED TO START MULTIPLAYER!", res)
			end
		end
		managers.network:join_game_at_host_rpc(self._server_rpc, joined_game)
	else
		managers.menu:show_failed_joining_dialog()
		self:search_lobby(self:search_friends_only())
	end
end

function NetworkMatchMakingXBL:_join_server_callback()
end

function NetworkMatchMakingXBL:_get_smartmatch_player_level()
	return math.floor(managers.experience:current_level() / 20)
end

function NetworkMatchMakingXBL:_test_create(settings)
	print("settings\n", inspect(settings))
	if settings == nil then
	end
	local gt = settings.game_type
	local gm = settings.game_mode
	local skl = settings.skill
	local player_index = managers.user:get_platform_id()
	XboxLive:set_context("GAME_TYPE", gt)
	XboxLive:set_context("game_mode", gm)
	if self._session and self._session:state() == "started" then
		XboxLive:leave_local(self._session, player_index)
		XboxLive:delete_session(self._session, function()
			print("DELETED SESSION")
		end)
	end
	local create_prop = {
		"group_lobby"
	}
	if self._uses_arbitration == true then
		table.insert(create_prop, "uses_arbitration")
	end
	local pub_slots = self.OPEN_SLOTS
	local priv_slots = 0
	print("creating session\n", inspect(create_prop))
	local session = XboxLive:create_session("live_multiplayer_standard", player_index, pub_slots, priv_slots, callback(self, self, "_create_server_callback", self:add_cancelable_callback()))
	print("create return value", session)
end

function NetworkMatchMakingXBL:_create_server_callback(cancel_id, session)
	if self:check_callback_canceled(cancel_id) then
		cat_print("lobby", "create_server canceled")
		return
	end
	print("NetworkMatchMakingXBL:_create_server_callback")
	local player_index = managers.user:get_platform_id()
	if not session then
		print("CREATE SESSION FAILED")
		return
	end
	if not XboxLive:join_local(session, player_index, self._private) then
		return
	end
	if alive(self._session) then
		cat_print("lobby", "Trying to remove self._session", self._session:id(), "in state", self._session:state())
		cat_stack_dump("lobby")
	end
	self._session = session
	print(" Created mm session ", self._session:id())
	self._players = {}
	self._server_rpc = nil
end

function NetworkMatchMakingXBL:_is_server(set)
	if set == true or set == false then
		self._is_server_var = set
	else
		return self._is_server_var
	end
end

function NetworkMatchMakingXBL:_is_client(set)
	if set == true or set == false then
		self._is_client_var = set
	else
		return self._is_client_var
	end
end
