CopLogicInactive = class(CopLogicBase)

function CopLogicInactive.enter(data, new_logic_name, enter_params)
	CopLogicBase.enter(data, new_logic_name, enter_params)
	local old_internal_data = data.internal_data
	data.internal_data = {}
	local my_data = data.internal_data
	if data.has_outline then
		data.unit:base():set_contour(false)
		data.has_outline = nil
	end
	local attention_obj = data.attention_obj
	CopLogicBase._set_attention_obj(data, nil, nil)
	CopLogicBase._destroy_all_detected_attention_object_data(data)
	CopLogicBase._reset_attention(data)
	for c_key, c_data in pairs(managers.groupai:state():all_char_criminals()) do
		if c_data.engaged[data.key] then
			debug_pause_unit(data.unit, "inactive AI engaging player", data.unit, c_data.unit, inspect(attention_obj), inspect(data.attention_obj))
		end
	end
	local rsrv_pos = old_internal_data.rsrv_pos
	if rsrv_pos.path then
		managers.navigation:unreserve_pos(rsrv_pos.path)
		rsrv_pos.path = nil
	end
	if rsrv_pos.move_dest then
		managers.navigation:unreserve_pos(rsrv_pos.move_dest)
		rsrv_pos.move_dest = nil
	end
	if rsrv_pos.stand then
		managers.navigation:unreserve_pos(rsrv_pos.stand)
		rsrv_pos.stand = nil
	end
	if data.objective and data.objective.type == "follow" and data.objective.destroy_clbk_key then
		data.objective.follow_unit:base():remove_destroy_listener(data.objective.destroy_clbk_key)
		data.objective.destroy_clbk_key = nil
	end
	data.unit:brain():set_update_enabled_state(false)
	if data.objective then
		managers.groupai:state():on_objective_failed(data.unit, data.objective)
	end
	data.logic._register_attention(data, my_data)
	data.logic._set_interaction(data, my_data)
end

function CopLogicInactive.exit(data, new_logic_name, enter_params)
	CopLogicBase.exit(data, new_logic_name, enter_params)
	local my_data = data.internal_data
	if my_data.weapons_hot_listener_key then
		managers.groupai:state():remove_listener(my_data.weapons_hot_listener_key)
		my_data.weapons_hot_listener_key = nil
	end
	CopLogicBase.cancel_delayed_clbks(my_data)
end

function CopLogicInactive.is_available_for_assignment(data)
	return false
end

function CopLogicInactive.on_enemy_weapons_hot(_, data)
	local my_data = data.internal_data
	data.unit:brain():set_attention_settings({corpse_cbt = true})
	if data.unit:interaction():active() then
		data.unit:interaction():set_active(false, true, true)
	end
	if my_data.pager_alert_clbk_id then
		CopLogicBase.cancel_delayed_clbk(my_data, my_data.pager_alert_clbk_id)
		my_data.pager_alert_clbk_id = nil
	end
	if my_data.pager_reminder_clbk_id then
		CopLogicBase.cancel_delayed_clbk(my_data, my_data.pager_reminder_clbk_id)
		my_data.pager_reminder_clbk_id = nil
	end
end

function CopLogicInactive._register_attention(data, my_data)
	if data.unit:character_damage():dead() then
		if managers.groupai:state():enemy_weapons_hot() then
			data.unit:brain():set_attention_settings({corpse_cbt = true})
		else
			my_data.weapons_hot_listener_key = "CopLogicInactive_corpse" .. tostring(data.key)
			managers.groupai:state():add_listener(my_data.weapons_hot_listener_key, {
				"enemy_weapons_hot"
			}, callback(CopLogicInactive, CopLogicInactive, "on_enemy_weapons_hot", data))
			data.unit:brain():set_attention_settings({corpse_sneak = true})
		end
	else
		data.unit:brain():set_attention_settings(nil)
	end
end

function CopLogicInactive.on_alarm_pager_interaction(data, status, player)
	print("[CopLogicInactive.on_alarm_pager_interaction]", status, player)
	if managers.groupai:state():enemy_weapons_hot() then
		return
	end
	local my_data = data.internal_data
	if status == "started" then
		CopLogicBase.cancel_delayed_clbk(my_data, my_data.pager_alert_clbk_id)
		my_data.pager_alert_clbk_id = nil
		if my_data.pager_reminder_clbk_id then
			CopLogicBase.cancel_delayed_clbk(my_data, my_data.pager_reminder_clbk_id)
			my_data.pager_reminder_clbk_id = nil
		end
	elseif status == "complete" then
		local nr_previous_bluffs = managers.groupai:state():get_nr_successful_alarm_pager_bluffs()
		local has_upgrade
		if player:base().is_local_player then
			has_upgrade = managers.player:has_category_upgrade("player", "corpse_alarm_pager_bluff")
		else
			has_upgrade = player:base():upgrade_value("player", "corpse_alarm_pager_bluff")
		end
		local chance_table = tweak_data.player.alarm_pager[has_upgrade and "bluff_success_chance_w_skill" or "bluff_success_chance"]
		local chance_index = math.min(nr_previous_bluffs + 1, #chance_table)
		local is_last = chance_table[math.min(chance_index + 1, #chance_table)] == 0
		local rand_nr = math.random()
		local success = 0 < chance_table[chance_index] and rand_nr < chance_table[chance_index]
		print("nr_previous_bluffs", nr_previous_bluffs, "has_upgrade", has_upgrade, "chance_index", chance_index, "rand_nr", rand_nr, "chance_table", inspect(chance_table), "success", success)
		if success then
			data.unit:interaction():set_tweak_data("corpse_dispose")
			data.unit:interaction():set_active(true, true, true)
			managers.groupai:state():on_successful_alarm_pager_bluff()
			data.unit:sound():stop()
			local cue_index = is_last and 4 or chance_index
			data.unit:sound():corpse_play("dsp_radio_fooled_" .. tostring(cue_index), nil, true)
		else
			managers.groupai:state():on_police_called("alarm_pager_bluff_failed")
			data.unit:interaction():set_active(false, true, true)
			data.unit:sound():stop()
			data.unit:sound():corpse_play("dsp_radio_alarm_1", nil, true)
		end
	elseif status == "interrupted" then
		managers.groupai:state():on_police_called("alarm_pager_hang_up")
		data.unit:interaction():set_active(false, true, true)
		data.unit:sound():stop()
		data.unit:sound():corpse_play("dsp_radio_alarm_1", nil, true)
	end
end

function CopLogicInactive._set_interaction(data, my_data)
	if data.unit:character_damage():dead() and managers.groupai:state():whisper_mode() then
		local my_data = data.internal_data
		if data.char_tweak.has_alarm_pager then
			local pager_delay = math.lerp(tweak_data.player.alarm_pager.ring_delay[1], tweak_data.player.alarm_pager.ring_delay[2], math.random())
			my_data.pager_alert_clbk_id = "alarm_pager" .. tostring(data.key)
			CopLogicBase.add_delayed_clbk(my_data, my_data.pager_alert_clbk_id, callback(CopLogicInactive, CopLogicInactive, "clbk_alarm_pager_triggered", data), TimerManager:game():time() + pager_delay)
		else
			data.unit:interaction():set_tweak_data("corpse_dispose")
			data.unit:interaction():set_active(true, true, true)
		end
	end
end

function CopLogicInactive.clbk_alarm_pager_triggered(ignore_this, data)
	print("[CopLogicInactive.clbk_alarm_pager_triggered]")
	local my_data = data.internal_data
	CopLogicBase.on_delayed_clbk(my_data, my_data.pager_alert_clbk_id)
	my_data.pager_alert_clbk_id = nil
	if managers.groupai:state():enemy_weapons_hot() then
		return
	end
	data.unit:base():set_material_state(false)
	local u_id = managers.enemy:get_corpse_unit_data_from_key(data.key).u_id
	managers.network:session():send_to_peers_synched("set_corpse_material_config", u_id, false)
	data.unit:interaction():set_tweak_data("corpse_alarm_pager")
	data.unit:interaction():set_active(true, true, true)
	data.unit:sound():stop()
	data.unit:sound():corpse_play("dsp_radio_query_1", nil, true)
	local pager_delay = math.lerp(tweak_data.player.alarm_pager.ring_duration[1], tweak_data.player.alarm_pager.ring_duration[2], math.random())
	my_data.hang_up_t = TimerManager:game():time() + pager_delay
	my_data.pager_alert_clbk_id = "alarm_pager_hang_up" .. tostring(data.key)
	CopLogicBase.add_delayed_clbk(my_data, my_data.pager_alert_clbk_id, callback(CopLogicInactive, CopLogicInactive, "clbk_alarm_pager_not_answered", data), TimerManager:game():time() + pager_delay)
	local reminder_delay = math.lerp(tweak_data.player.alarm_pager.ring_reminder[1], tweak_data.player.alarm_pager.ring_reminder[2], math.random())
	my_data.pager_reminder_clbk_id = "alarm_pager_reminder" .. tostring(data.key)
	CopLogicBase.add_delayed_clbk(my_data, my_data.pager_reminder_clbk_id, callback(CopLogicInactive, CopLogicInactive, "clbk_alarm_pager_reminder", data), TimerManager:game():time() + reminder_delay)
end

function CopLogicInactive.clbk_alarm_pager_reminder(ignore_this, data)
	print("[CopLogicInactive.clbk_alarm_pager_reminder]")
	local my_data = data.internal_data
	CopLogicBase.on_delayed_clbk(my_data, my_data.pager_reminder_clbk_id)
	my_data.pager_reminder_clbk_id = nil
	if managers.groupai:state():enemy_weapons_hot() then
		return
	end
	if not my_data.pager_alert_clbk_id or my_data.hang_up_t - TimerManager:game():time() < 1.5 then
		return
	end
	data.unit:sound():stop()
	data.unit:sound():corpse_play("dsp_radio_reminder_1", nil, true)
	local reminder_delay = math.lerp(tweak_data.player.alarm_pager.ring_reminder[1], tweak_data.player.alarm_pager.ring_reminder[2], math.random())
	my_data.pager_reminder_clbk_id = "alarm_pager_reminder" .. tostring(data.key)
	CopLogicBase.add_delayed_clbk(my_data, my_data.pager_reminder_clbk_id, callback(CopLogicInactive, CopLogicInactive, "clbk_alarm_pager_reminder", data), TimerManager:game():time() + reminder_delay)
end

function CopLogicInactive.clbk_alarm_pager_not_answered(ignore_this, data)
	print("[CopLogicInactive.clbk_alarm_pager_not_answered]")
	local my_data = data.internal_data
	CopLogicBase.on_delayed_clbk(my_data, my_data.pager_alert_clbk_id)
	my_data.pager_alert_clbk_id = nil
	if managers.groupai:state():enemy_weapons_hot() then
		return
	end
	data.unit:base():swap_material_config()
	data.unit:interaction():set_active(false, true, true)
	managers.groupai:state():on_police_called("alarm_pager_not_answered")
	data.unit:sound():stop()
	data.unit:sound():corpse_play("pln_alm_any_any", nil, true)
end

function CopLogicInactive.on_new_objective(data, old_objective)
	debug_pause_unit(data.unit, "[CopLogicInactive.on_new_objective]", data.unit, "new_objective", data.objective and inspect(data.objective), "old_objective", old_objective and inspect(old_objective))
	CopLogicBase.on_new_objective(data, old_objective)
end

function CopLogicInactive.pre_destroy(data)
	local my_data = data.internal_data
	if my_data.weapons_hot_listener_key then
		managers.groupai:state():remove_listener(my_data.weapons_hot_listener_key)
		my_data.weapons_hot_listener_key = nil
	end
	if my_data.pager_alert_clbk_id then
		managers.enemy:remove_delayed_clbk(my_data.pager_alert_clbk_id)
		my_data.pager_alert_clbk_id = nil
	end
	if my_data.pager_reminder_clbk_id then
		managers.enemy:remove_delayed_clbk(my_data.pager_reminder_clbk_id)
		my_data.pager_reminder_clbk_id = nil
	end
end
