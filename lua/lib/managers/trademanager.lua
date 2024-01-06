TradeManager = TradeManager or class()

function TradeManager:init()
	self._criminals_to_respawn = {}
	self._criminals_to_add = {}
	self._trade_counter_tick = 1
	self._num_trades = 0
	self._hostage_trade_index = 0
	self:set_trade_countdown(true)
end

function TradeManager:save(save_data)
	if not next(self._criminals_to_respawn) then
		return
	end
	local my_save_data = {}
	save_data.trade = my_save_data
	my_save_data.criminals = self._criminals_to_respawn
	my_save_data.outfits = {}
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.peer_id then
			my_save_data.outfits[crim.peer_id] = {
				outfit = managers.network:session():peer(crim.peer_id):profile("outfit_string"),
				version = managers.network:session():peer(crim.peer_id):outfit_version()
			}
		end
	end
end

function TradeManager:load(load_data)
	local my_load_data = load_data.trade
	if not my_load_data then
		return
	end
	self._criminals_to_respawn = my_load_data.criminals
	self._criminals_to_add = {}
	for _, crim in ipairs(self._criminals_to_respawn) do
		if not crim.ai and not managers.network:session():peer(crim.peer_id) then
			if crim.peer_id then
				self._criminals_to_add[crim.peer_id] = crim
				local peer = managers.network:session():peer(crim.peer_id)
				local outfit = my_load_data.outfits[crim.peer_id]
				crim.outfit = outfit
			end
		else
			if crim.peer_id then
				local peer = managers.network:session():peer(crim.peer_id)
				local outfit = my_load_data.outfits[crim.peer_id]
				peer:set_outfit_string(outfit.outfit, outfit.version)
			end
			managers.criminals:add_character(crim.id, nil, crim.peer_id, crim.ai)
		end
	end
end

function TradeManager:handshake_complete(peer_id)
	local crim = self._criminals_to_add[peer_id]
	if crim then
		local peer = managers.network:session():peer(peer_id)
		peer:set_outfit_string(crim.outfit)
		managers.criminals:add_character(crim.id, nil, crim.peer_id, crim.ai)
		self._criminals_to_add[peer_id] = nil
	end
end

function TradeManager:is_peer_in_custody(peer_id)
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.peer_id == peer_id then
			return true
		end
	end
end

function TradeManager:is_criminal_in_custody(name)
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.id == name then
			return true
		end
	end
end

function TradeManager:respawn_delay_by_name(character_name)
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.id == character_name then
			return crim.respawn_penalty
		end
	end
	return 0
end

function TradeManager:hostages_killed_by_name(character_name)
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.id == character_name then
			return crim.hostages_killed
		end
	end
	return 0
end

function TradeManager:update(t, dt)
	self._t = t
	if not managers.criminals or not managers.hud then
		return
	end
	if not self._hostage_remind_t or t > self._hostage_remind_t then
		if not self._trading_hostage and not self._hostage_trade_clbk and #self._criminals_to_respawn > 0 and 0 >= managers.groupai:state():hostage_count() and not next(managers.groupai:state():all_converted_enemies()) and managers.groupai:state():is_AI_enabled() and managers.groupai:state():bain_state() then
			local cable_tie_data = managers.player:has_special_equipment("cable_tie")
			if cable_tie_data and 0 < Application:digest_value(cable_tie_data.amount, false) then
				managers.dialog:queue_dialog("ban_h01x", {})
			elseif self:get_criminal_to_trade() ~= nil then
				managers.dialog:queue_dialog("Play_ban_h22x", {})
			end
		end
		self._hostage_remind_t = t + math.random(60, 120)
	end
	self._trade_counter_tick = self._trade_counter_tick - dt
	if 0 >= self._trade_counter_tick then
		self._trade_counter_tick = self._trade_counter_tick + 1
		if self._hostage_to_trade and not alive(self._hostage_to_trade.unit) then
			self:cancel_trade()
		end
		for _, crim in ipairs(self._criminals_to_respawn) do
			local crim_data = managers.criminals:character_data_by_name(crim.id)
			local mugshot_id = crim_data and crim_data.mugshot_id
			local mugshot_data = mugshot_id and managers.hud:_get_mugshot_data(mugshot_id)
			if mugshot_data and not mugshot_data.state_name ~= "mugshot_in_custody" then
				managers.hud:set_mugshot_custody(mugshot_id)
				if 0 < crim.respawn_penalty then
				end
			end
			if 0 < crim.respawn_penalty then
				crim.respawn_penalty = self._trade_countdown and crim.respawn_penalty - 1 or crim.respawn_penalty
				if 0 >= crim.respawn_penalty then
					crim.respawn_penalty = 0
				end
			end
		end
	end
	if self._trade_countdown and Network:is_server() and not self._trading_hostage and not self._hostage_trade_clbk and #self._criminals_to_respawn > 0 and not managers.groupai:state():whisper_mode() and not self._speaker_snd_event then
		local trade = self:get_criminal_to_trade()
		if trade and Global.game_settings.single_player and not trade.ai then
			trade = nil
		end
		if not trade or managers.groupai:state():hostage_count() == 0 and not next(managers.groupai:state():all_converted_enemies()) then
		else
			self:_increment_trade_index()
			local respawn_t = self._t + math.random(2, 5)
			self._hostage_trade_clbk = "TradeManager"
			managers.enemy:add_delayed_clbk(self._hostage_trade_clbk, callback(self, self, "clbk_begin_hostage_trade_dialog", 1), respawn_t)
		end
	end
end

function TradeManager:_increment_trade_index()
	if self._hostage_trade_index > 10000 then
		self._hostage_trade_index = 1
	else
		self._hostage_trade_index = self._hostage_trade_index + 1
	end
end

function TradeManager:num_in_trade_queue()
	return #self._criminals_to_respawn
end

function TradeManager:get_criminal_to_trade()
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.respawn_penalty <= 0 then
			return crim
		end
	end
end

function TradeManager:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed, from_local)
	if not from_local then
		local crim_data = managers.criminals:character_data_by_name(criminal_name)
		if not crim_data then
			return
		end
		if crim_data.ai then
			self:on_AI_criminal_death(criminal_name, respawn_penalty, hostages_killed)
		else
			self:on_player_criminal_death(criminal_name, respawn_penalty, hostages_killed)
		end
	end
	self:play_custody_voice(criminal_name)
	if managers.criminals:local_character_name() == criminal_name and not Network:is_server() and game_state_machine:current_state_name() == "ingame_waiting_for_respawn" then
		game_state_machine:current_state():trade_death(respawn_penalty, hostages_killed)
	end
end

function TradeManager:_announce_spawn(criminal_name)
	if not managers.groupai:state():bain_state() then
		return
	end
	local character_code = managers.criminals:character_static_data_by_name(criminal_name).ssuffix
	managers.dialog:queue_dialog("ban_q02" .. character_code, {})
end

function TradeManager:sync_set_trade_spawn(criminal_name)
	local crim_data = managers.criminals:character_data_by_name(criminal_name)
	self:_announce_spawn(criminal_name)
	self._num_trades = self._num_trades + 1
	if crim_data then
		managers.hud:set_mugshot_normal(crim_data.mugshot_id)
	end
	for i, crim in ipairs(self._criminals_to_respawn) do
		if crim.id == criminal_name then
			table.remove(self._criminals_to_respawn, i)
			break
		end
	end
end

function TradeManager:sync_set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
	if replace_ai then
		self:replace_ai_with_player(criminal_name1, criminal_name2, respawn_penalty)
	else
		self:replace_player_with_ai(criminal_name1, criminal_name2, respawn_penalty)
	end
end

function TradeManager:play_custody_voice(criminal_name)
	if managers.criminals:local_character_name() == criminal_name then
		return
	end
	if #self._criminals_to_respawn == 3 then
		local criminal_left
		for _, crim_data in pairs(managers.groupai:state():all_char_criminals()) do
			if not crim_data.unit:movement():downed() then
				criminal_left = managers.criminals:character_name_by_unit(crim_data.unit)
				break
			end
		end
		if managers.criminals:local_character_name() == criminal_left then
			managers.achievment:set_script_data("last_man_standing", true)
			if managers.groupai:state():bain_state() then
				local character_code = managers.criminals:character_static_data_by_name(criminal_left).ssuffix
				managers.dialog:queue_dialog("Play_ban_i20" .. character_code, {})
			end
			return
		end
	end
	if managers.groupai:state():bain_state() then
		local character_code = managers.criminals:character_static_data_by_name(criminal_name).ssuffix
		managers.dialog:queue_dialog("Play_ban_h11" .. character_code, {})
	end
end

function TradeManager:on_AI_criminal_death(criminal_name, respawn_penalty, hostages_killed, skip_netsend)
	print("[TradeManager:on_AI_criminal_death]", criminal_name, respawn_penalty, hostages_killed, skip_netsend)
	if not managers.hud then
		return
	end
	local crim_data = managers.criminals:character_data_by_name(criminal_name)
	if crim_data then
		managers.hud:set_mugshot_custody(crim_data.mugshot_id)
	end
	local crim = {
		id = criminal_name,
		ai = true,
		respawn_penalty = respawn_penalty,
		hostages_killed = hostages_killed
	}
	table.insert(self._criminals_to_respawn, crim)
	if Network:is_server() and not skip_netsend then
		managers.network:session():send_to_peers_synched("set_trade_death", criminal_name, respawn_penalty, hostages_killed)
		self:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed, true)
	end
	return crim
end

function TradeManager:on_player_criminal_death(criminal_name, respawn_penalty, hostages_killed, skip_netsend)
	for _, crim in ipairs(self._criminals_to_respawn) do
		if crim.id == criminal_name then
			debug_pause("[TradeManager:on_player_criminal_death] criminal already dead", criminal_name)
			return
		end
	end
	if tweak_data.player.damage.automatic_respawn_time then
		respawn_penalty = math.min(respawn_penalty, tweak_data.player.damage.automatic_respawn_time)
	end
	local crim_data = managers.criminals:character_data_by_name(criminal_name)
	if crim_data then
		if managers.hud then
			managers.hud:set_mugshot_custody(crim_data.mugshot_id)
		else
			debug_pause("[TradeManager:on_player_criminal_death] no hud manager! criminal_name:", criminal_name)
		end
	end
	local crim = {
		id = criminal_name,
		ai = false,
		respawn_penalty = respawn_penalty,
		hostages_killed = hostages_killed,
		peer_id = managers.criminals:character_peer_id_by_name(criminal_name)
	}
	local inserted = false
	for i, crim_to_respawn in ipairs(self._criminals_to_respawn) do
		if crim_to_respawn.ai or respawn_penalty < crim_to_respawn.respawn_penalty then
			table.insert(self._criminals_to_respawn, i, crim)
			inserted = true
			break
		end
	end
	if not inserted then
		table.insert(self._criminals_to_respawn, crim)
	end
	if Network:is_server() and not skip_netsend then
		managers.network:session():send_to_peers_synched("set_trade_death", criminal_name, respawn_penalty, hostages_killed)
		self:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed, true)
	end
	print("[TradeManager:on_player_criminal_death]", criminal_name, ". Respawn queue:")
	for i, crim_to_respawn in ipairs(self._criminals_to_respawn) do
		print(inspect(crim_to_respawn))
	end
	return crim
end

function TradeManager:set_trade_countdown(enabled)
	self._trade_countdown = enabled
	if Network:is_server() and managers.network then
		managers.network:session():send_to_peers_synched("set_trade_countdown", enabled)
	end
end

function TradeManager:replace_ai_with_player(ai_criminal, player_criminal, new_respawn_penalty)
	local first_crim = self._criminals_to_respawn[1]
	if first_crim and first_crim.id == ai_criminal then
		self:cancel_trade()
	end
	local respawn_penalty, hostages_killed
	for i, c in ipairs(self._criminals_to_respawn) do
		if c.id == ai_criminal then
			respawn_penalty = new_respawn_penalty or c.respawn_penalty
			hostages_killed = c.hostages_killed
			table.remove(self._criminals_to_respawn, i)
			break
		end
	end
	if respawn_penalty then
		if respawn_penalty <= 0 then
			respawn_penalty = 1
		end
		return self:on_player_criminal_death(player_criminal, respawn_penalty, hostages_killed, true)
	end
end

function TradeManager:replace_player_with_ai(player_criminal, ai_criminal, new_respawn_penalty)
	local first_crim = self._criminals_to_respawn[1]
	if first_crim and first_crim.id == player_criminal then
		self:cancel_trade()
	end
	local respawn_penalty, hostages_killed
	for i, c in ipairs(self._criminals_to_respawn) do
		if c.id == player_criminal then
			respawn_penalty = new_respawn_penalty or c.respawn_penalty
			hostages_killed = c.hostages_killed
			print("replacing player in custody. respawn_penalty", respawn_penalty, ". hostages_killed", hostages_killed)
			table.remove(self._criminals_to_respawn, i)
			break
		end
	end
	if respawn_penalty then
		if respawn_penalty <= 0 then
			respawn_penalty = 1
		end
		print("managers.criminals:nr_AI_criminals()", managers.criminals:nr_AI_criminals())
		if managers.groupai:state():team_ai_enabled() and managers.groupai:state():is_AI_enabled() and managers.criminals:nr_AI_criminals() <= CriminalsManager.MAX_NR_TEAM_AI then
			return self:on_AI_criminal_death(ai_criminal, respawn_penalty, hostages_killed, true)
		end
	end
end

function TradeManager:remove_from_trade(criminal)
	local first_crim = self._criminals_to_respawn[1]
	if first_crim and first_crim.id == criminal then
		self:cancel_trade()
	end
	for i, c in ipairs(self._criminals_to_respawn) do
		if c.id == criminal then
			table.remove(self._criminals_to_respawn, i)
			break
		end
	end
end

function TradeManager:_send_finish_trade(criminal, respawn_delay, hostages_killed)
	if criminal.ai == true then
		return
	end
	local peer_id = managers.criminals:character_peer_id_by_name(criminal.id)
	if peer_id == 1 then
		if game_state_machine:current_state_name() == "ingame_waiting_for_respawn" then
			game_state_machine:current_state():finish_trade()
		end
	else
		local peer = managers.network:session():peer(peer_id)
		if peer then
			peer:send_queued_sync("finish_trade")
		end
	end
end

function TradeManager:_send_begin_trade(criminal)
	if criminal.ai == true then
		return
	end
	local peer_id = managers.criminals:character_peer_id_by_name(criminal.id)
	if peer_id == 1 then
		if game_state_machine:current_state_name() == "ingame_waiting_for_respawn" then
			game_state_machine:current_state():begin_trade()
		end
	else
		local peer = managers.network:session():peer(peer_id)
		if peer then
			peer:send_queued_sync("begin_trade")
		end
	end
end

function TradeManager:_send_cancel_trade(criminal)
	if criminal.ai == true then
		return
	end
	local peer_id = managers.criminals:character_peer_id_by_name(criminal.id)
	if peer_id == 1 then
		if game_state_machine:current_state_name() == "ingame_waiting_for_respawn" then
			game_state_machine:current_state():cancel_trade()
		end
	else
		local peer = managers.network:session():peer(peer_id)
		if peer then
			peer:send_queued_sync("cancel_trade")
		end
	end
end

function TradeManager:change_hostage()
	self:sync_hostage_trade_dialog(6)
	managers.network:session():send_to_peers_synched("hostage_trade_dialog", 6)
	self:cancel_trade()
end

function TradeManager:cancel_trade()
	if self._hostage_trade_clbk then
		managers.enemy:remove_delayed_clbk(self._hostage_trade_clbk)
		self._hostage_trade_clbk = nil
	end
	self:_increment_trade_index()
	if not next(managers.groupai:state():all_player_criminals()) then
		return
	end
	self._trading_hostage = nil
	if #self._criminals_to_respawn > 0 then
		self:_send_cancel_trade(self._criminals_to_respawn[1])
	end
	if self._hostage_to_trade then
		if alive(self._hostage_to_trade.unit) and not self._hostage_to_trade.unit:character_damage():dead() then
			self._hostage_to_trade.unit:brain():cancel_trade()
		end
		if self._hostage_to_trade.death_clbk_key then
			self._hostage_to_trade.unit:character_damage():remove_listener(self._hostage_to_trade.death_clbk_key)
		end
		if self._hostage_to_trade.destroyed_clbk_key then
			self._hostage_to_trade.unit:base():remove_destroy_listener(self._hostage_to_trade.destroyed_clbk_key)
		end
		self._hostage_to_trade = nil
	end
end

function TradeManager:_get_megaphone_sound_source()
	local level_id = Global.level_data.level_id
	local pos
	if not level_id then
		pos = Vector3(0, 0, 0)
		Application:error("[TradeManager:_get_megaphone_sound_source] This level has no megaphone position!")
	elseif not tweak_data.levels[level_id].megaphone_pos then
		pos = Vector3(0, 0, 0)
	else
		pos = tweak_data.levels[level_id].megaphone_pos
	end
	local sound_source = SoundDevice:create_source("megaphone")
	sound_source:set_position(pos)
	return sound_source
end

function TradeManager:sync_hostage_trade_dialog(i)
	if game_state_machine:current_state_name() == "ingame_waiting_for_respawn" or not managers.groupai:state():bain_state() then
		return
	end
	if i == 1 then
		self:_get_megaphone_sound_source():post_event("mga_t01a_con_plu")
	elseif i == 2 then
		managers.dialog:queue_dialog("ban_h02a", {})
	elseif i == 3 then
		managers.dialog:queue_dialog("ban_h02b", {})
	elseif i == 4 then
		managers.dialog:queue_dialog("ban_h02c", {})
	elseif i == 5 then
		managers.dialog:queue_dialog("ban_h02d", {})
	elseif i == 6 then
		managers.dialog:queue_dialog("Play_ban_h50x", {})
	elseif i == 7 then
		managers.dialog:queue_dialog("Play_ban_h02", {})
	end
end

function TradeManager:clbk_vo_end_begin_hostage_trade_dialog(data)
	if data.hostage_trade_index ~= self._hostage_trade_index then
		return
	end
	self._speaker_snd_event = nil
	self:clbk_begin_hostage_trade_dialog(data.i)
end

function TradeManager:clbk_begin_hostage_trade_dialog(i)
	self._hostage_trade_clbk = nil
	local respawn_criminal = self:get_criminal_to_trade()
	if not respawn_criminal then
		return
	end
	local char_sync_index = i
	if i == 1 then
		self._megaphone_sound_source = self:_get_megaphone_sound_source()
		self._speaker_snd_event = self._megaphone_sound_source:post_event("mga_t01a_con_plu", callback(self, self, "clbk_vo_end_begin_hostage_trade_dialog", {
			i = 2,
			hostage_trade_index = self._hostage_trade_index
		}), nil, "end_of_event")
		if not self._speaker_snd_event then
			self:clbk_begin_hostage_trade_dialog(2)
			print("Megaphone fail")
		end
	elseif i == 2 then
		local ssuffix = managers.criminals:character_static_data_by_name(respawn_criminal.id).ssuffix
		if ssuffix == "a" then
			char_sync_index = 2
		elseif ssuffix == "b" then
			char_sync_index = 3
		elseif ssuffix == "c" then
			char_sync_index = 4
		elseif ssuffix == "d" then
			char_sync_index = 5
		else
			char_sync_index = 7
		end
		self:sync_hostage_trade_dialog(char_sync_index)
		local respawn_t = self._t + 5
		self._hostage_trade_clbk = "TradeManager"
		managers.enemy:add_delayed_clbk(self._hostage_trade_clbk, callback(self, self, "clbk_begin_hostage_trade"), respawn_t)
	end
	managers.network:session():send_to_peers_synched("hostage_trade_dialog", char_sync_index)
end

function TradeManager:clbk_begin_hostage_trade()
	self._hostage_trade_clbk = nil
	self:_send_begin_trade(self._criminals_to_respawn[1])
	local possible_criminals = {}
	for u_key, u_data in pairs(managers.groupai:state():all_player_criminals()) do
		if u_data.status ~= "dead" then
			table.insert(possible_criminals, u_key)
		end
	end
	local rescuing_criminal = possible_criminals[math.random(1, #possible_criminals)]
	rescuing_criminal = managers.groupai:state():all_criminals()[rescuing_criminal]
	local rescuing_criminal_pos
	local civilians = managers.enemy:all_civilians()
	if rescuing_criminal then
		rescuing_criminal_pos = rescuing_criminal.m_pos
	else
		managers.enemy:add_delayed_clbk(self._hostage_trade_clbk, callback(self, self, "clbk_begin_hostage_trade"), self._t + 5)
		return
	end
	local trade_dist = tweak_data.group_ai.optimal_trade_distance
	local optimal_trade_dist = math.random(trade_dist[1], trade_dist[2])
	optimal_trade_dist = optimal_trade_dist * optimal_trade_dist
	local best_hostage_d, best_hostage
	for _, h_key in ipairs(managers.groupai:state():all_hostages()) do
		local civ = civilians[h_key]
		if civ and civ.unit:character_damage():pickup() then
			civ = nil
		end
		local hostage = civ or managers.enemy:all_enemies()[h_key]
		if hostage then
			local d = math.abs(mvector3.distance_sq(hostage.m_pos, rescuing_criminal_pos) - optimal_trade_dist)
			if civ then
				d = d * 0.5
			end
			if not best_hostage_d or best_hostage_d > d then
				best_hostage_d = d
				best_hostage = hostage
			end
		end
	end
	if not best_hostage then
		for u_key, unit in pairs(managers.groupai:state():all_converted_enemies()) do
			best_hostage = managers.enemy:all_enemies()[u_key]
		end
	end
	if best_hostage then
		self._trading_hostage = true
		self._hostage_to_trade = best_hostage
		best_hostage.unit:brain():set_logic("trade")
		local clbk_key = "TradeManager"
		self._hostage_to_trade.death_clbk_key = clbk_key
		self._hostage_to_trade.destroyed_clbk_key = clbk_key
		best_hostage.unit:character_damage():add_listener(clbk_key, {"death"}, callback(self, self, "clbk_hostage_died"))
		best_hostage.unit:base():add_destroy_listener(clbk_key, callback(self, self, "clbk_hostage_destroyed"))
		if not rescuing_criminal then
		end
	end
end

function TradeManager:clbk_hostage_destroyed(hostage_unit)
	if not self._hostage_to_trade or not self._hostage_to_trade.destroyed_clbk_key then
		return
	end
	self._hostage_to_trade.destroyed_clbk_key = nil
	self:cancel_trade()
end

function TradeManager:clbk_hostage_died(hostage_unit, damage_info)
	if not self._hostage_to_trade or not self._hostage_to_trade.death_clbk_key then
		return
	end
	self._hostage_to_trade.death_clbk_key = nil
	self:cancel_trade()
end

function TradeManager:on_hostage_traded(trading_unit)
	print("RC: Traded hostage!!")
	if self._criminal_respawn_clbk then
		return
	end
	self._hostage_to_trade = nil
	local respawn_criminal = self:get_criminal_to_trade()
	local respawn_delay = respawn_criminal.respawn_penalty
	self:_send_finish_trade(respawn_criminal, respawn_delay, respawn_criminal.hostages_killed)
	local respawn_t = self._t + 2
	local clbk_id = "Respawn_criminal_on_trade"
	self._criminal_respawn_clbk = clbk_id
	managers.enemy:add_delayed_clbk(clbk_id, callback(self, self, "clbk_respawn_criminal", trading_unit), respawn_t)
end

function TradeManager:clbk_respawn_criminal(trading_unit)
	self._criminal_respawn_clbk = nil
	self._trading_hostage = nil
	local spawn_on_unit = trading_unit
	if not alive(spawn_on_unit) then
		local possible_criminals = {}
		for u_key, u_data in pairs(managers.groupai:state():all_char_criminals()) do
			if u_data.status ~= "dead" then
				table.insert(possible_criminals, u_data.unit)
			end
		end
		if #possible_criminals <= 0 then
			return
		end
		spawn_on_unit = possible_criminals[math.random(1, #possible_criminals)]
	end
	local respawn_criminal = self:get_criminal_to_trade()
	if not respawn_criminal then
		return
	end
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("Found criminal to respawn ", respawn_criminal and inspect(respawn_criminal))
	for i, crim in ipairs(self._criminals_to_respawn) do
		if crim == respawn_criminal then
			print("Removing from list")
			table.remove(self._criminals_to_respawn, i)
			break
		end
	end
	self._num_trades = self._num_trades + 1
	managers.network:session():send_to_peers_synched("set_trade_spawn", respawn_criminal.id)
	self:_announce_spawn(respawn_criminal.id)
	local spawned_unit
	if respawn_criminal.ai then
		print("RC: respawn AI", respawn_criminal.id)
		spawned_unit = managers.groupai:state():spawn_one_teamAI(false, respawn_criminal.id, spawn_on_unit)
	else
		print("RC: respawn human", respawn_criminal.id)
		local sp_id = "clbk_respawn_criminal"
		local spawn_point = {
			position = spawn_on_unit:position(),
			rotation = spawn_on_unit:rotation()
		}
		managers.network:register_spawn_point(sp_id, spawn_point)
		local peer_id = managers.criminals:character_peer_id_by_name(respawn_criminal.id)
		spawned_unit = managers.network:game():spawn_member_by_id(peer_id, sp_id, true)
		managers.network:unregister_spawn_point(sp_id)
	end
	if alive(spawned_unit) and alive(trading_unit) then
		self:sync_teammate_helped_hint(spawned_unit, trading_unit, 1)
		managers.network:session():send_to_peers_synched("sync_teammate_helped_hint", 1, spawned_unit, trading_unit)
	end
end

function TradeManager:sync_teammate_helped_hint(helped_unit, helping_unit, hint)
	if not alive(helped_unit) or not alive(helping_unit) then
		return
	end
	local peer_id = managers.network:session():local_peer():id()
	if not managers.network:game():member(peer_id) then
		debug_pause("[TradeManager:sync_teammate_helped_hint] Couldn't get local unit! ", peer_id)
	end
	local local_unit = managers.criminals:character_unit_by_name(managers.criminals:local_character_name())
	local hint_id = "teammate"
	if local_unit == helped_unit then
		hint_id = "you_were"
	elseif local_unit == helping_unit then
		hint_id = "you"
	end
	if not hint or hint == 1 then
		hint_id = hint_id .. "_revived"
	elseif hint == 2 then
		hint_id = hint_id .. "_helpedup"
	elseif hint == 3 then
		hint_id = hint_id .. "_rescued"
	end
	if hint_id then
		managers.hint:show_hint(hint_id, nil, false, {
			TEAMMATE = helped_unit:base():nick_name(),
			HELPER = helping_unit:base():nick_name()
		})
	end
end
