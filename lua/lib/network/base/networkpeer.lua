local ids_unit = Idstring("unit")
local ids_NORMAL = Idstring("NORMAL")
NetworkPeer = NetworkPeer or class()
NetworkPeer.PRE_HANDSHAKE_CHK_TIME = 8

function NetworkPeer:init(name, rpc, id, loading, synced, in_lobby, character, user_id)
	self._name = name or managers.localization:text("menu_" .. tostring(character or "russian"))
	self._rpc = rpc
	self._id = id
	self._user_id = user_id
	self._xuid = ""
	self._xnaddr = ""
	local is_local_peer
	if self._rpc then
		if self._rpc:ip_at_index(0) == Network:self("TCP_IP"):ip_at_index(0) then
			is_local_peer = true
		end
	elseif self._steam_rpc and self._steam_rpc:ip_at_index(0) == Network:self("STEAM"):ip_at_index(0) then
		is_local_peer = true
	end
	if is_local_peer and (id ~= 1 or managers.network:session():is_host()) then
		print("[NetworkPeer:init] settng own id", self._id, self._name)
		Network:set_connection_id(nil, self._id)
	end
	print("[NetworkPeer:init] rpc", rpc, "id", id)
	if self._rpc then
		Network:set_connection_persistent(self._rpc, true)
		if not is_local_peer then
			Network:set_connection_id(self._rpc, self._id)
		end
		self._ip = self._rpc:ip_at_index(0)
	end
	if user_id and SystemInfo:platform() == Idstring("WIN32") then
		self._steam_rpc = Network:handshake(user_id, nil, "STEAM")
		Network:set_connection_persistent(self._steam_rpc, true)
		if not is_local_peer then
			Network:set_connection_id(self._steam_rpc, self._id)
		end
	end
	self:set_throttling_enabled(managers.user:get_setting("net_packet_throttling"))
	self._level = nil
	self._rank = 0
	self._in_lobby = in_lobby
	self._loading = loading
	self._synced = synced
	self._waiting_for_player_ready = false
	self._ip_verified = false
	self._dlcs = {
		dlc1 = false,
		dlc2 = false,
		dlc3 = false,
		dlc4 = false
	}
	self:chk_enable_queue()
	self._character = character
	self._overwriteable_msgs = deep_clone(managers.network.OVERWRITEABLE_MSGS)
	self._overwriteable_queue = {}
	self:_chk_flush_msg_queues()
	if in_lobby then
	end
	self._creation_t = TimerManager:wall_running():time()
	if self._rpc and not self._loading and managers.network.voice_chat.on_member_added and self._rpc:ip_at_index(0) ~= Network:self("TCP_IP"):ip_at_index(0) then
		managers.network.voice_chat:on_member_added(self)
	end
	self._profile = {
		level = nil,
		rank = nil,
		outfit_string = ""
	}
	self._handshakes = {}
	self._streaming_status = 0
	self._outfit_assets = {
		unit = {},
		texture = {}
	}
	self._outfit_version = 0
end

function NetworkPeer:set_rpc(rpc)
	self._rpc = rpc
	if self._rpc then
		Network:set_connection_persistent(rpc, true)
		self._ip = self._rpc:ip_at_index(0)
		Network:set_throttling_disabled(self._rpc, not managers.user:get_setting("net_packet_throttling"))
		Network:set_connection_id(self._rpc, self._id)
		self:_chk_flush_msg_queues()
		if managers.network.voice_chat.on_member_added then
			managers.network.voice_chat:on_member_added(self)
		end
	end
end

function NetworkPeer:create_ticket()
	if SystemInfo:platform() == Idstring("WIN32") then
		return Steam:create_ticket(self._user_id)
	end
	return ""
end

function NetworkPeer:begin_ticket_session(ticket)
	if SystemInfo:platform() == Idstring("WIN32") then
		self._ticket_wait_response = true
		self._begin_ticket_session_called = true
		local result = Steam:begin_ticket_session(self._user_id, ticket, callback(self, self, "on_verify_ticket"))
		self._begin_ticket_session_called = nil
		return result
	end
	return true
end

function NetworkPeer:on_verify_ticket(result, reason)
	self._ticket_wait_response = nil
	if not result then
		print("[NetworkPeer:on_verify_ticket] Steam ID Authentication failed for peer '" .. tostring(self._name) .. "' (ID: " .. tostring(self._id) .. ") because '" .. tostring(reason) .. "'.")
		if Network:is_server() then
			if not self._begin_ticket_session_called then
				managers.network:session():send_to_peers("kick_peer", self._id, 2)
				managers.network:session():on_peer_kicked(self, self._id, 2)
			end
		else
			managers.network:session():on_peer_kicked(managers.network:session():local_peer(), managers.network:session():local_peer():id(), 3)
		end
	else
		print("[NetworkPeer:on_verify_ticket] Steam ID Authentication succeeded for peer '" .. tostring(self._name) .. "' (ID: " .. tostring(self._id) .. ").")
		if self._profile.outfit_string ~= "" then
			self:verify_outfit()
		end
		if not Network:is_server() then
			self:verify_job(managers.job:current_job_id())
			self:verify_character()
		end
	end
end

function NetworkPeer:end_ticket_session()
	if SystemInfo:platform() == Idstring("WIN32") then
		self._ticket_wait_response = nil
		Steam:end_ticket_session(self._user_id)
		Steam:destroy_ticket(self._user_id)
	end
end

function NetworkPeer:change_ticket_callback()
	if SystemInfo:platform() == Idstring("WIN32") then
		Steam:change_ticket_callback(self._user_id, callback(self, self, "on_verify_ticket"))
	end
end

function NetworkPeer:verify_job(job)
	if SystemInfo:platform() ~= Idstring("WIN32") then
		return
	end
	local job_tweak = tweak_data.narrative:job_data(job)
	if not job_tweak or not job_tweak.dlc then
		return
	end
	local dlc_data = Global.dlc_manager.all_dlc_data[job_tweak.dlc]
	if not dlc_data or not dlc_data.app_id then
		return
	end
	if not Steam:is_user_product_owned(self._user_id, dlc_data.app_id) then
		self:mark_cheater(VoteManager.REASON.invalid_job, Network:is_server())
	end
end

function NetworkPeer:verify_character()
	if SystemInfo:platform() ~= Idstring("WIN32") then
		return
	end
	if not self:is_host() then
		return
	end
	local character_data = tweak_data.blackmarket.characters[self._character]
	if not character_data or not character_data.dlc then
		return
	end
	local dlc_data = Global.dlc_manager.all_dlc_data[character_data.dlc]
	if not dlc_data or not dlc_data.app_id then
		return
	end
	if not Steam:is_user_product_owned(self._user_id, dlc_data.app_id) then
		self:mark_cheater(VoteManager.REASON.invalid_character, Network:is_server())
	end
end

function NetworkPeer:verify_outfit()
	local failed = self:_verify_outfit_data()
	if failed then
		self:mark_cheater(failed == 1 and VoteManager.REASON.invalid_mask or VoteManager.REASON.invalid_weapon, Network:is_server())
	end
end

function NetworkPeer:_verify_outfit_data()
	if not managers.network:session() or self._id == managers.network:session():local_peer():id() then
		return nil
	end
	local outfit = self:blackmarket_outfit()
	local mask_blueprint_lookup = {
		color = "colors",
		material = "materials",
		pattern = "textures"
	}
	for item_type, item in pairs(outfit) do
		if item_type == "mask" then
			if not self:_verify_content("masks", item.mask_id) then
				return self:_verify_cheated_outfit("masks", item.mask_id, 1)
			end
			for mask_type, mask_item in pairs(item.blueprint) do
				local mask_type_lookup = mask_blueprint_lookup[mask_type]
				local skip_default = false
				local mask_tweak = tweak_data.blackmarket.masks[item.mask_id]
				if mask_tweak and mask_tweak.default_blueprint and mask_tweak.default_blueprint[mask_type_lookup] == mask_item.id then
					skip_default = true
				end
				if not skip_default and not self:_verify_content(mask_type_lookup, mask_item.id) then
					return self:_verify_cheated_outfit(mask_type_lookup, mask_item.id, 1)
				end
			end
		elseif item_type == "primary" or item_type == "secondary" then
			if not self:_verify_content("weapon", managers.weapon_factory:get_weapon_id_by_factory_id(item.factory_id)) then
				return self:_verify_cheated_outfit("weapon", item.factory_id, 2)
			end
			local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(item.factory_id)
			for _, mod_item in pairs(item.blueprint) do
				if not table.contains(blueprint, mod_item) and not self:_verify_content("weapon_mods", mod_item) then
					return self:_verify_cheated_outfit("weapon_mods", mod_item, 2)
				end
			end
		elseif item_type == "melee_weapon" and not self:_verify_content("melee_weapons", item) then
			return self:_verify_cheated_outfit("melee_weapons", item, 2)
		end
	end
	return nil
end

function NetworkPeer:_verify_cheated_outfit(item_type, item_id, result)
	self._cheated_items = self._cheated_items or {}
	local item = tostring(item_type) .. "_" .. tostring(item_id)
	if self._cheated_items[item] then
		return
	end
	print("[NetworkPeer:_verify_cheated_outfit] Invalid item '" .. tostring(item_id) .. "' on peer '" .. tostring(self._name) .. "'.")
	self._cheated_items[item] = true
	return result
end

function NetworkPeer:_verify_content(item_type, item_id)
	if SystemInfo:platform() ~= Idstring("WIN32") then
		return true
	end
	local dlc_item, dlc_list, item_data
	if item_type == "weapon" then
		item_data = tweak_data.weapon[item_id]
		dlc_item = item_data and item_data.global_value
	else
		local item = tweak_data.blackmarket[item_type]
		item_data = item and item[item_id]
		if item_type == "masks" and item_data.name_id == "bm_msk_cheat_error" then
			return false
		end
		dlc_item = item_data and item_data.dlc
		dlc_list = item_data and item_data.dlc_list
	end
	if not item_data then
		return false
	end
	if dlc_list then
		for _, dlc in pairs(dlc_list) do
			local dlc_data = Global.dlc_manager.all_dlc_data[dlc]
			if dlc_data and dlc_data.app_id and not dlc_data.external and not Steam:is_user_product_owned(self._user_id, dlc_data.app_id) then
				return false
			end
		end
	else
		local dlc_data = Global.dlc_manager.all_dlc_data[dlc_item]
		if dlc_data and dlc_data.app_id and not dlc_data.external then
			return Steam:is_user_product_owned(self._user_id, dlc_data.app_id)
		end
	end
	return true
end

function NetworkPeer:is_cheater()
	return self._cheater
end

function NetworkPeer:mark_cheater(reason, auto_kick)
	if Application:editor() then
		return
	end
	self._cheater = true
	managers.chat:feed_system_message(ChatManager.GAME, managers.localization:text(managers.vote:kick_reason_to_string(reason), {
		name = self:name()
	}))
	if auto_kick and Global.game_settings.auto_kick then
		managers.vote:kick_auto(reason, self, self._begin_ticket_session_called)
	elseif managers.hud then
		managers.hud:mark_cheater(self._id)
	end
end

function NetworkPeer:set_steam_rpc(rpc)
	self._steam_rpc = rpc
	if self._steam_rpc then
		Network:set_connection_persistent(self._steam_rpc, true)
		Network:set_throttling_disabled(self._steam_rpc, not managers.user:get_setting("net_packet_throttling"))
		Network:set_connection_id(self._steam_rpc, self._id)
	end
end

function NetworkPeer:set_dlcs(dlcs)
	local i_dlcs = string.split(dlcs, " ")
	for _, dlc in ipairs(i_dlcs) do
		self._dlcs[dlc] = true
	end
end

function NetworkPeer:has_dlc(dlc)
	return self._dlcs[dlc]
end

function NetworkPeer:load(data)
	print("[NetworkPeer:load] data:", inspect(data))
	self._name = data.name
	if SystemInfo:platform() == Idstring("WIN32") then
		self._name = managers.network.account:username_by_id(data.user_id)
	end
	self._rpc = data.rpc
	self._steam_rpc = data.steam_rpc
	self._id = data.id
	if self._rpc then
		self._ip = self._rpc:ip_at_index(0)
	end
	print("LOAD IP", self._ip, "self._rpc ip", self._rpc and self._rpc:ip_at_index(0))
	self._synced = data.synced
	self._character = data.character
	self._ip_verified = data.ip_verified
	self._creation_t = data.creation_t
	self._dlcs = data.dlcs
	self._handshakes = data.handshakes
	self._loaded = data.loaded
	self._loading = data.loading
	self._msg_queues = data.msg_queues
	self._user_id = data.user_id
	self._force_open_lobby = data.force_open_lobby
	self._profile = data.profile
	self._xuid = data.xuid
	self._xnaddr = data.xnaddr
	self._join_attempt_identifier = data.join_attempt_identifier
	self._muted = data.muted
	self._rank = data.rank
	self._streaming_status = data.streaming_status
	self._ticket_wait_response = data.wait_ticket_response
	self._outfit_assets = data.outfit_assets
	self._other_peer_outfits_loaded = data.other_peer_outfits_loaded
	self._outfit_version = data.outfit_version
	if self._ticket_wait_response then
		self:change_ticket_callback()
	end
	self:chk_enable_queue()
	self:_chk_flush_msg_queues()
	if self._rpc and not self._loading and managers.network.voice_chat.on_member_added then
		managers.network.voice_chat:on_member_added(self)
	end
	self._expected_dropin_pause_confirmations = data.expected_dropin_pause_confirmations
end

function NetworkPeer:save(data)
	print("[NetworkPeer:save] ID:", self._id)
	data.name = self._name
	data.rpc = self._rpc
	data.steam_rpc = self._steam_rpc
	data.id = self._id
	print("SAVE IP", data.ip, "self._rpc ip", self._rpc and self._rpc:ip_at_index(0))
	data.synced = self._synced
	data.character = self._character
	data.ip_verified = self._ip_verified
	data.creation_t = self._creation_t
	data.dlcs = self._dlcs
	data.handshakes = self._handshakes
	data.loaded = self._loaded
	data.loading = self._loading
	data.expected_dropin_pause_confirmations = self._expected_dropin_pause_confirmations
	self:_clean_queue()
	data.msg_queues = self._msg_queues
	data.user_id = self._user_id
	data.force_open_lobby = self._force_open_lobby
	data.profile = self._profile
	data.xuid = self._xuid
	data.xnaddr = self._xnaddr
	data.join_attempt_identifier = self._join_attempt_identifier
	data.muted = self._muted
	data.rank = self._rank
	data.streaming_status = self._streaming_status
	data.wait_ticket_response = self._ticket_wait_response
	data.other_peer_outfits_loaded = self._other_peer_outfits_loaded
	data.outfit_version = self._outfit_version
	data.outfit_assets = self._outfit_assets
	print("[NetworkPeer:save]", inspect(data))
end

function NetworkPeer:name()
	return self._name
end

function NetworkPeer:ip()
	return self._ip
end

function NetworkPeer:id()
	return self._id
end

function NetworkPeer:rpc()
	return self._rpc
end

function NetworkPeer:steam_rpc()
	return self._steam_rpc
end

function NetworkPeer:connection_info()
	return self._name, self._id, self._user_id or "", self._in_lobby, self._loading, self._synced, self._character, "remove", self._xuid, self._xnaddr
end

function NetworkPeer:synched()
	return self._synced
end

function NetworkPeer:loading()
	return self._loading
end

function NetworkPeer:loaded()
	return self._loaded
end

function NetworkPeer:in_lobby()
	return self._in_lobby
end

function NetworkPeer:character()
	return self._character
end

function NetworkPeer:used_deployable()
	return self._used_deployable
end

function NetworkPeer:set_used_deployable(used)
	self._used_deployable = used
end

function NetworkPeer:qos()
	if not self._rpc then
		return
	end
	return Network:qos(self._rpc)
end

function NetworkPeer:set_used_cable_ties(used_cable_ties)
	self._used_cable_ties = used_cable_ties
end

function NetworkPeer:on_used_cable_tie()
	self._used_cable_ties = (self._used_cable_ties or 0) + 1
end

function NetworkPeer:used_cable_ties()
	return self._used_cable_ties
end

function NetworkPeer:set_used_body_bags(used_body_bags)
	self._used_body_bags = used_body_bags
end

function NetworkPeer:on_used_body_bags()
	self._used_body_bags = (self._used_body_bags or 0) + 1
end

function NetworkPeer:used_body_bags()
	return self._used_body_bags or 0
end

function NetworkPeer:waiting_for_player_ready()
	return self._waiting_for_player_ready
end

function NetworkPeer:ip_verified()
	return self._ip_verified
end

function NetworkPeer:set_ip_verified(state)
	cat_print("multiplayer_base", "NetworkPeer:set_ip_verified", state, self._name, self._id)
	self._ip_verified = state
	self:_chk_flush_msg_queues()
end

function NetworkPeer:set_loading(state)
	cat_print("multiplayer_base", "[NetworkPeer:set_loading]", state, "was loading", self._loading, "id", self._id)
	if self._loading and not state then
		self._loaded = true
	end
	self._loading = state
	if state then
		self:chk_enable_queue()
	end
	self:_chk_flush_msg_queues()
	if self == managers.network:session():local_peer() then
		return
	end
	managers.network:game():on_peer_loading(self, state)
	if state then
		self._default_timeout_check_reset = nil
		if managers.network.voice_chat.on_member_removed then
			managers.network.voice_chat:on_member_removed(self)
		end
	elseif self._rpc and managers.network.voice_chat.on_member_added then
		managers.network.voice_chat:on_member_added(self)
	end
end

function NetworkPeer:set_loaded(state)
	self._loaded = state
end

function NetworkPeer:set_synched(state)
	if state and self.chk_timeout == self.pre_handshake_chk_timeout then
		self._default_timeout_check_reset = TimerManager:wall():time() + NetworkPeer.PRE_HANDSHAKE_CHK_TIME
	end
	self._synced = state
	if state then
		self._syncing = false
	end
	self:_chk_flush_msg_queues()
end

function NetworkPeer:on_sync_start()
	self._syncing = true
end

function NetworkPeer:set_entering_lobby(state)
	self._entering_lobby = state
end

function NetworkPeer:entering_lobby()
	return self._entering_lobby
end

function NetworkPeer:set_in_lobby(state)
	cat_print("multiplayer_base", "NetworkPeer:set_in_lobby", state, self._id)
	self._in_lobby = state
	if state and self.chk_timeout == self.pre_handshake_chk_timeout then
		self._entering_lobby = false
		self._default_timeout_check_reset = TimerManager:wall():time() + NetworkPeer.PRE_HANDSHAKE_CHK_TIME
	end
	self:_chk_flush_msg_queues()
end

function NetworkPeer:set_in_lobby_soft(state)
	self._in_lobby = state
end

function NetworkPeer:set_synched_soft(state)
	self._synced = state
	self:_chk_flush_msg_queues()
end

function NetworkPeer:set_character(character)
	self._character = character
	self:_reload_outfit()
	self:verify_character()
end

function NetworkPeer:set_waiting_for_player_ready(state)
	cat_print("multiplayer_base", "NetworkPeer:waiting_for_player_ready", state, self._id)
	self._waiting_for_player_ready = state
end

function NetworkPeer:set_statistics(total_kills, total_specials_kills, total_head_shots, accuracy, downs)
	self._statistics = {
		total_kills = total_kills,
		total_specials_kills = total_specials_kills,
		total_head_shots = total_head_shots,
		accuracy = accuracy,
		downs = downs
	}
end

function NetworkPeer:statistics()
	return self._statistics
end

function NetworkPeer:has_statistics()
	return self._statistics and true or false
end

function NetworkPeer:send(func_name, ...)
	if not self._ip_verified then
		debug_pause("[NetworkPeer:send] ip unverified:", func_name, ...)
		return
	end
	local rpc = self._rpc
	rpc[func_name](rpc, ...)
	local send_resume = Network:get_connection_send_status(rpc)
	if send_resume then
		local nr_queued_packets = 0
		for delivery_type, amount in pairs(send_resume) do
			nr_queued_packets = nr_queued_packets + amount
			if 100 < nr_queued_packets and send_resume.unreliable then
				print("[NetworkPeer:send] dropping unreliable packets", send_resume.unreliable)
				Network:drop_unreliable_packets_for_connection(rpc)
				break
			end
		end
	end
end

function NetworkPeer:_send_queued(queue_name, func_name, ...)
	if self._msg_queues and self._msg_queues[queue_name] then
		self:_push_to_queue(queue_name, func_name, ...)
	else
		local overwrite_data = self._overwriteable_msgs[func_name]
		if overwrite_data then
			overwrite_data.clbk(overwrite_data, self._overwriteable_queue, func_name, ...)
			return
		end
		self:send(func_name, ...)
	end
end

function NetworkPeer:send_after_load(...)
	if not self._ip_verified then
		print("[NetworkPeer:send_after_load] ip unverified:", ...)
		return
	end
	self:_send_queued("load", ...)
end

function NetworkPeer:send_queued_sync(...)
	if not self._ip_verified then
		Application:error("[NetworkPeer:send_queued_sync] ip unverified:", ...)
		return
	end
	if self._synced or self._syncing then
		self:_send_queued("sync", ...)
	end
end

function NetworkPeer:_chk_flush_msg_queues()
	if not self._msg_queues or not self._ip_verified then
		return
	end
	if not self._loading then
		self:_flush_queue("load")
	end
	if self._synced then
		self:_flush_queue("sync")
	end
	if not next(self._msg_queues) then
		self._msg_queues = nil
	end
end

function NetworkPeer:chk_enable_queue()
	if self._loading then
		self._msg_queues = self._msg_queues or {}
		self._msg_queues.load = self._msg_queues.load or {}
	end
	if not self._synched then
		self._msg_queues = self._msg_queues or {}
		self._msg_queues.sync = self._msg_queues.sync or {}
	end
end

function NetworkPeer:_push_to_queue(queue_name, ...)
	table.insert(self._msg_queues[queue_name], {
		...
	})
end

function NetworkPeer:_clean_queue()
	if not self._msg_queues then
		return
	end
	for type, msg_queue in pairs(self._msg_queues) do
		local ok
		for i, msg in ipairs(msg_queue) do
			ok = true
			for _, param in ipairs(msg) do
				local param_type = type_name(param)
				if param_type == "Unit" then
					if not alive(param) or param:id() == -1 then
						ok = nil
						break
					end
				elseif param_type == "Body" and not alive(param) then
					ok = nil
					break
				end
			end
			if not ok then
				print("[NetworkPeer:_clean_queue]: Removing Message:", i)
				msg_queue[i] = nil
			end
		end
	end
end

function NetworkPeer:_flush_queue(queue_name)
	local msg_queue = self._msg_queues[queue_name]
	if not msg_queue then
		return
	end
	self._msg_queues[queue_name] = nil
	local ok
	for i, msg in ipairs(msg_queue) do
		ok = true
		for _, param in ipairs(msg) do
			local param_type = type_name(param)
			if param_type == "Unit" then
				if not alive(param) or param:id() == -1 then
					ok = nil
					break
				end
			elseif param_type == "Body" and not alive(param) then
				ok = nil
				break
			end
		end
		if ok then
			self:send(unpack(msg))
		end
	end
end

function NetworkPeer:chk_timeout(timeout)
	if not self._ip_verified then
		return
	end
	if self._rpc then
		local silent_time = Network:receive_silent_time(self._rpc)
		if timeout < silent_time then
			if self._steam_rpc then
				silent_time = math.min(silent_time, Network:receive_silent_time(self._steam_rpc))
			end
			if timeout < silent_time then
				print("PINGED OUT", self._ip, silent_time, timeout)
				self:_ping_timedout()
			end
		end
	else
		self:_ping_timedout()
	end
end

function NetworkPeer:pre_handshake_chk_timeout()
	local wall_t = TimerManager:wall():time()
	if self._default_timeout_check_reset and wall_t > self._default_timeout_check_reset then
		self._default_timeout_check_reset = nil
		self.chk_timeout = nil
	end
end

function NetworkPeer:on_lost()
	self._in_lobby = false
	self._loading = false
	self._synced = false
	self._waiting_for_player_ready = false
	self._msg_queue = nil
end

function NetworkPeer:_ping_timedout()
	managers.network:session():on_peer_lost(self, self._id)
end

function NetworkPeer:set_ip(my_ip)
	self._ip = my_ip
end

function NetworkPeer:set_id(my_id)
	self._id = my_id
	if self == managers.network:session():local_peer() then
		Network:set_connection_id(nil, self._id)
	else
		if self._rpc then
			Network:set_connection_id(self._rpc, self._id)
		end
		if self._steam_rpc then
			Network:set_connection_id(self._steam_rpc, self._id)
		end
	end
end

function NetworkPeer:set_name(name)
	self._name = name
end

function NetworkPeer:destroy()
	print("[NetworkPeer:destroy]", self:id())
	if self._rpc then
		Network:reset_connection(self._rpc)
		if managers.network.voice_chat.on_member_removed then
			managers.network.voice_chat:on_member_removed(self)
		end
	end
	if self._steam_rpc then
		Network:reset_connection(self._steam_rpc)
	end
	self:_unload_outfit()
end

function NetworkPeer:on_send()
	self:flush_overwriteable_msgs()
end

function NetworkPeer:flush_overwriteable_msgs()
	local overwriteable_queue = self._overwriteable_queue
	if self._loading or not next(overwriteable_queue) then
		return
	end
	for msg_name, data in pairs(self._overwriteable_msgs) do
		data.clbk(data)
	end
	for msg_name, rpc_params in pairs(overwriteable_queue) do
		local ok = true
		for _, param in ipairs(rpc_params) do
			local param_type = type_name(param)
			if param_type == "Unit" then
				if not alive(param) or param:id() == -1 then
					ok = nil
					break
				end
			elseif param_type == "Body" and not alive(param) then
				ok = nil
				break
			end
		end
		if ok then
			self:send(unpack(rpc_params))
		else
			Application:error("[NetworkPeer:flush_overwriteable_msgs] msg with dead params peer_id:", self._id, "msg", msg_name, "params", unpack(rpc_params))
			Application:stack_dump("error")
		end
	end
	self._overwriteable_queue = {}
end

function NetworkPeer:set_expecting_drop_in_pause_confirmation(dropin_peer_id, state)
	print(" [NetworkPeer:set_expecting_drop_in_pause_confirmation] peer", self._id, "dropin_peer", dropin_peer_id, "state", state)
	if state then
		self._expected_dropin_pause_confirmations = self._expected_dropin_pause_confirmations or {}
		self._expected_dropin_pause_confirmations[dropin_peer_id] = state
	elseif self._expected_dropin_pause_confirmations then
		self._expected_dropin_pause_confirmations[dropin_peer_id] = nil
		if not next(self._expected_dropin_pause_confirmations) then
			self._expected_dropin_pause_confirmations = nil
		end
	end
end

function NetworkPeer:is_expecting_pause_confirmation(dropin_peer_id)
	return self._expected_dropin_pause_confirmations and self._expected_dropin_pause_confirmations[dropin_peer_id]
end

function NetworkPeer:expected_dropin_pause_confirmations()
	return self._expected_dropin_pause_confirmations
end

function NetworkPeer:set_expecting_pause_sequence(state)
	self._expecting_pause_sequence = state
end

function NetworkPeer:expecting_pause_sequence()
	return self._expecting_pause_sequence
end

function NetworkPeer:set_expecting_dropin(state)
	self._expecting_dropin = state
end

function NetworkPeer:expecting_dropin()
	return self._expecting_dropin
end

function NetworkPeer:creation_t()
	return self._creation_t
end

function NetworkPeer:set_level(level)
	self._level = level
	if managers.hud then
		managers.hud:update_name_label_by_peer(self)
	end
end

function NetworkPeer:level()
	return self._level
end

function NetworkPeer:set_rank(rank)
	self._rank = rank
	if managers.hud then
		managers.hud:update_name_label_by_peer(self)
	end
end

function NetworkPeer:rank()
	return self._rank
end

function NetworkPeer:set_profile(level, rank)
	self._profile.level = level
	self._profile.rank = rank
end

function NetworkPeer:set_outfit_string(outfit_string, outfit_version)
	print("[NetworkPeer:set_outfit_string] ID", self._id, outfit_string, outfit_version)
	Application:stack_dump()
	local old_outfit_string = self._profile.outfit_string
	self._profile.outfit_string = outfit_string
	if not self._ticket_wait_response then
		self:verify_outfit()
	end
	if old_outfit_string ~= outfit_string then
		self:_reload_outfit()
	end
	local member = managers.network and managers.network:game() and managers.network:game():member_peer(self)
	if member then
		member:update_equipped_armor()
	end
	if self == managers.network:session():local_peer() then
		self:_increment_outfit_version()
	else
		self._outfit_version = outfit_version or 0
	end
end

function NetworkPeer:profile(data)
	if data then
		return self._profile[data]
	end
	return self._profile
end

function NetworkPeer:character_id()
	return managers.blackmarket:get_character_id_by_character_name(self:character())
end

function NetworkPeer:mask_id()
	local outfit_string = self:profile("outfit_string")
	local data = string.split(outfit_string, " ")
	return data[managers.blackmarket:outfit_string_index("mask")]
end

function NetworkPeer:mask_blueprint()
	local outfit_string = self:profile("outfit_string")
	return managers.blackmarket:mask_blueprint_from_outfit_string(outfit_string)
end

function NetworkPeer:armor_id(get_current)
	local outfit_string = self:profile("outfit_string")
	local data = string.split(outfit_string, " ")
	local armor_string = data[managers.blackmarket:outfit_string_index("armor")]
	local armor_data = string.split(armor_string, "-")
	return get_current and armor_data[2] or armor_data[1]
end

function NetworkPeer:melee_id()
	local outfit_string = self:profile("outfit_string")
	local data = string.split(outfit_string, " ")
	return data[managers.blackmarket:outfit_string_index("melee_weapon")]
end

function NetworkPeer:grenade_id()
	local outfit_string = self:profile("outfit_string")
	local data = string.split(outfit_string, " ")
	return data[managers.blackmarket:outfit_string_index("grenade")]
end

function NetworkPeer:skills()
	local outfit_string = self:profile("outfit_string")
	local data = string.split(outfit_string, " ")
	return data[managers.blackmarket:outfit_string_index("skills")]
end

function NetworkPeer:blackmarket_outfit()
	local outfit_string = self:profile("outfit_string")
	return managers.blackmarket:unpack_outfit_from_string(outfit_string)
end

function NetworkPeer:set_handshake_status(introduced_peer_id, status)
	print("[NetworkPeer:set_handshake_status]", self._id, introduced_peer_id, status)
	Application:stack_dump()
	self._handshakes[introduced_peer_id] = status
end

function NetworkPeer:handshakes()
	return self._handshakes
end

function NetworkPeer:has_queued_rpcs()
	if not self._msg_queues then
		return
	end
	for queue_name, queue in pairs(self._msg_queues) do
		if next(queue) then
			print("queued msgs in", queue_name)
			for i, rpc_info in ipairs(queue) do
				print(i)
				for _, blah in ipairs(rpc_info) do
					print(blah)
				end
			end
			return queue_name
		end
	end
end

function NetworkPeer:set_xuid(xuid)
	self._xuid = xuid
end

function NetworkPeer:xuid()
	return self._xuid
end

function NetworkPeer:set_xnaddr(xnaddr)
	self._xnaddr = xnaddr
end

function NetworkPeer:xnaddr()
	return self._xnaddr
end

function NetworkPeer:user_id()
	return self._user_id
end

function NetworkPeer:is_host()
	return self._id == 1
end

function NetworkPeer:next_steam_p2p_send_t()
	return self._next_steam_p2p_send_t
end

function NetworkPeer:set_next_steam_p2p_send_t(t)
	self._next_steam_p2p_send_t = t
end

function NetworkPeer:set_force_open_lobby_state(state)
	self._force_open_lobby = state or nil
end

function NetworkPeer:force_open_lobby_state()
	return self._force_open_lobby
end

function NetworkPeer:set_join_attempt_identifier(identifier)
	self._join_attempt_identifier = identifier
end

function NetworkPeer:join_attempt_identifier()
	return self._join_attempt_identifier
end

function NetworkPeer:set_muted(mute_flag)
	self._muted = mute_flag
end

function NetworkPeer:is_muted()
	return self._muted
end

function NetworkPeer:set_streaming_status(status)
	self._streaming_status = status
end

function NetworkPeer:is_streaming_complete()
	return self._streaming_status == 100
end

function NetworkPeer:streaming_status()
	return self._streaming_status
end

function NetworkPeer:is_outfit_loaded()
	return not self._loading_outfit_assets and self._profile.outfit_string ~= ""
end

function NetworkPeer:is_loading_outfit_assets()
	return self._loading_outfit_assets
end

function NetworkPeer:_unload_outfit()
	for asset_id, asset_data in pairs(self._outfit_assets.unit) do
		managers.dyn_resource:unload(ids_unit, asset_data.name, DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
	end
	for asset_id, asset_data in pairs(self._outfit_assets.texture) do
		TextureCache:unretrieve(asset_data.name)
	end
	self._outfit_assets = {
		unit = {},
		texture = {}
	}
end

function NetworkPeer:_reload_outfit()
	if self._profile.outfit_string == "" then
		return
	end
	self._loading_outfit_assets = true
	local is_local_peer = self == managers.network:session():local_peer()
	local new_outfit_assets = {
		unit = {},
		texture = {}
	}
	local old_outfit_assets = self._outfit_assets
	print("[NetworkPeer:_reload_outfit]", is_local_peer and "local_peer" or self._id, self._profile.outfit_string)
	local asset_load_result_clbk = callback(self, self, "clbk_outfit_asset_loaded", new_outfit_assets)
	local texture_load_result_clbk = callback(self, self, "clbk_outfit_texture_loaded", new_outfit_assets)
	local complete_outfit = self:blackmarket_outfit()
	local mask_id = complete_outfit.mask.mask_id
	local mask_u_name = managers.blackmarket:mask_unit_name_by_mask_id(mask_id, self._id)
	local mask_asset_data = {
		name = Idstring(mask_u_name)
	}
	new_outfit_assets.unit.mask = mask_asset_data
	local mask_blueprint = self:mask_blueprint()
	local mask_pattern_id = mask_blueprint.pattern.id
	local mask_pattern_texture = tweak_data.blackmarket.textures[mask_pattern_id].texture
	local mask_pattern_texture_asset_data = {
		name = Idstring(mask_pattern_texture)
	}
	new_outfit_assets.texture.mask_pattern = mask_pattern_texture_asset_data
	local mask_material_id = mask_blueprint.material.id
	local mask_reflection_texture = tweak_data.blackmarket.materials[mask_material_id].texture
	local mask_reflection_texture_asset_data = {
		name = Idstring(mask_reflection_texture)
	}
	new_outfit_assets.texture.mask_reflection = mask_reflection_texture_asset_data
	if is_local_peer then
		local mask_backstraps_asset_data = {
			name = Idstring("units/payday2/masks/msk_fps_back_straps/msk_fps_back_straps")
		}
		new_outfit_assets.unit.mask_backstraps = mask_backstraps_asset_data
	end
	local ids_primary_u_name = Idstring(tweak_data.weapon.factory[complete_outfit.primary.factory_id .. (is_local_peer and "" or "_npc")].unit)
	new_outfit_assets.unit.primary_w = {name = ids_primary_u_name}
	local primary_w_parts = managers.weapon_factory:preload_blueprint(complete_outfit.primary.factory_id, complete_outfit.primary.blueprint, not is_local_peer, function()
	end, true)
	for part_id, part in pairs(primary_w_parts) do
		new_outfit_assets.unit["prim_w_part_" .. tostring(part_id)] = {
			name = part.name
		}
	end
	local ids_secondary_u_name = Idstring(tweak_data.weapon.factory[complete_outfit.secondary.factory_id .. (is_local_peer and "" or "_npc")].unit)
	new_outfit_assets.unit.secondary_w = {name = ids_secondary_u_name}
	local secondary_w_parts = managers.weapon_factory:preload_blueprint(complete_outfit.secondary.factory_id, complete_outfit.secondary.blueprint, not is_local_peer, function()
	end, true)
	for part_id, part in pairs(secondary_w_parts) do
		new_outfit_assets.unit["sec_w_part_" .. tostring(part_id)] = {
			name = part.name
		}
	end
	local melee_tweak_data = tweak_data.blackmarket.melee_weapons[complete_outfit.melee_weapon]
	local melee_u_name = is_local_peer and melee_tweak_data.unit or melee_tweak_data.third_unit
	if melee_u_name then
		new_outfit_assets.unit.melee_w = {
			name = Idstring(melee_u_name)
		}
	end
	self._outfit_assets = new_outfit_assets
	for asset_id, asset_data in pairs(new_outfit_assets.unit) do
		asset_data.is_streaming = true
		managers.dyn_resource:load(ids_unit, asset_data.name, DynamicResourceManager.DYN_RESOURCES_PACKAGE, asset_load_result_clbk)
	end
	for asset_id, asset_data in pairs(new_outfit_assets.texture) do
		asset_data.is_streaming = true
		TextureCache:request(asset_data.name, ids_NORMAL, texture_load_result_clbk, 90)
	end
	self._all_outfit_load_requests_sent = true
	self._outfit_assets = old_outfit_assets
	self:_unload_outfit()
	self._outfit_assets = new_outfit_assets
	self:_chk_outfit_loading_complete()
end

function NetworkPeer:clbk_outfit_asset_loaded(outfit_assets, status, asset_type, asset_name)
	if not self._loading_outfit_assets or self._outfit_assets ~= outfit_assets then
		return
	end
	for asset_id, asset_data in pairs(outfit_assets.unit) do
		if asset_data.name == asset_name then
			asset_data.is_streaming = nil
		end
	end
	if not Global.peer_loading_outfit_assets or not Global.peer_loading_outfit_assets[self._id] then
		self:_chk_outfit_loading_complete()
	end
end

function NetworkPeer:clbk_outfit_texture_loaded(outfit_assets, tex_name)
	if not self._loading_outfit_assets or self._outfit_assets ~= outfit_assets then
		return
	end
	for asset_id, asset_data in pairs(outfit_assets.texture) do
		if asset_data.name == tex_name then
			asset_data.is_streaming = nil
		end
	end
	if not Global.peer_loading_outfit_assets or not Global.peer_loading_outfit_assets[self._id] then
		self:_chk_outfit_loading_complete()
	end
end

function NetworkPeer:_chk_outfit_loading_complete()
	if not self._loading_outfit_assets or not self._all_outfit_load_requests_sent then
		return
	end
	for asset_type, asset_list in pairs(self._outfit_assets) do
		for asset_id, asset_data in pairs(asset_list) do
			if asset_data.is_streaming then
				return
			end
		end
	end
	self._all_outfit_load_requests_sent = nil
	self._loading_outfit_assets = nil
	print("[NetworkPeer:_chk_outfit_loading_complete] Complete!", self == managers.network:session():local_peer() and "local_peer" or self._id, "\n", inspect(self._outfit_assets.unit), inspect(self._outfit_assets.texture))
	managers.network:session():on_peer_outfit_loaded(self)
end

function NetworkPeer:set_other_peer_outfit_loaded_status(status)
	self._other_peer_outfits_loaded = status
end

function NetworkPeer:other_peer_outfit_loaded_status()
	return self._other_peer_outfits_loaded
end

function NetworkPeer:_increment_outfit_version()
	if self._outfit_version == 100 then
		self._outfit_version = 1
	else
		self._outfit_version = self._outfit_version + 1
	end
	return self._outfit_version
end

function NetworkPeer:outfit_version()
	return self._outfit_version
end

function NetworkPeer:set_throttling_enabled(state)
	if self._rpc then
		Network:set_throttling_disabled(self._rpc, not state)
	end
	if self._steam_rpc then
		Network:set_throttling_disabled(self._steam_rpc, not state)
	end
end
