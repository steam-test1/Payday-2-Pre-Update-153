SpoocLogicAttack = class(CopLogicAttack)

function SpoocLogicAttack.enter(data, new_logic_name, enter_params)
	CopLogicBase.enter(data, new_logic_name, enter_params)
	data.unit:brain():cancel_all_pathing_searches()
	local old_internal_data = data.internal_data
	local my_data = {
		unit = data.unit
	}
	data.internal_data = my_data
	my_data.detection = data.char_tweak.detection.combat
	my_data.rsrv_pos = {}
	if old_internal_data then
		my_data.rsrv_pos = old_internal_data.rsrv_pos or my_data.rsrv_pos
		CopLogicAttack._set_best_cover(data, my_data, old_internal_data.best_cover)
		CopLogicAttack._set_nearest_cover(my_data, old_internal_data.nearest_cover)
	end
	local key_str = tostring(data.key)
	my_data.update_queue_id = "SpoocLogicAttack.queued_update" .. key_str
	CopLogicBase.queue_task(my_data, my_data.update_queue_id, SpoocLogicAttack.queued_update, data, data.t)
	my_data.detection_task_key = "CopLogicAttack._upd_enemy_detection" .. key_str
	CopLogicBase.queue_task(my_data, my_data.detection_task_key, CopLogicAttack._upd_enemy_detection, data, data.t)
	data.unit:brain():set_update_enabled_state(false)
	CopLogicTravel.reset_actions(data, my_data, old_internal_data, CopLogicTravel.allowed_transitional_actions)
	local objective = data.objective
	if objective then
		my_data.attitude = data.objective.attitude or "avoid"
	end
	my_data.weapon_range = data.char_tweak.weapon[data.unit:inventory():equipped_unit():base():weapon_tweak_data().usage].range
	local upper_body_action = data.unit:movement()._active_actions[3]
	if not upper_body_action or upper_body_action:type() ~= "shoot" then
		data.unit:movement():set_stance("hos")
	end
	data.unit:movement():set_cool(false)
	if my_data ~= data.internal_data then
		return
	end
	my_data.cover_test_step = 1
	data.unit:brain():set_attention_settings({cbt = true})
end

function SpoocLogicAttack.exit(data, new_logic_name, enter_params)
	CopLogicBase.exit(data, new_logic_name, enter_params)
	local my_data = data.internal_data
	data.unit:brain():cancel_all_pathing_searches()
	CopLogicBase.cancel_queued_tasks(my_data)
	CopLogicBase.cancel_delayed_clbks(my_data)
	if my_data.best_cover then
		managers.navigation:release_cover(my_data.best_cover[1])
	end
	if my_data.nearest_cover then
		managers.navigation:release_cover(my_data.nearest_cover[1])
	end
	local rsrv_pos = my_data.rsrv_pos
	if rsrv_pos.path then
		managers.navigation:unreserve_pos(rsrv_pos.path)
		rsrv_pos.path = nil
	end
	if rsrv_pos.move_dest then
		managers.navigation:unreserve_pos(rsrv_pos.move_dest)
		rsrv_pos.move_dest = nil
	end
	data.unit:brain():set_update_enabled_state(true)
end

function SpoocLogicAttack.queued_update(data)
	if CopLogicIdle._chk_relocate(data) then
		return
	end
	local t = TimerManager:game():time()
	data.t = t
	local unit = data.unit
	local my_data = data.internal_data
	if my_data.spooc_attack then
		CopLogicBase._report_detections(data.detected_attention_objects)
		SpoocLogicAttack.queue_update(data, my_data)
		return
	end
	if my_data.wants_stop_old_walk_action then
		if not data.unit:movement():chk_action_forbidden("walk") then
			data.unit:movement():action_request({type = "idle", body_part = 2})
			my_data.wants_stop_old_walk_action = nil
		end
		SpoocLogicAttack.queue_update(data, my_data)
		return
	end
	CopLogicAttack._process_pathing_results(data, my_data)
	if not data.attention_obj or data.attention_obj.reaction < AIAttentionObject.REACT_AIM then
		CopLogicAttack._upd_enemy_detection(data, true)
		if my_data ~= data.internal_data or not data.attention_obj then
			return
		end
	end
	SpoocLogicAttack._upd_spooc_attack(data, my_data)
	if my_data.spooc_attack then
		SpoocLogicAttack.queue_update(data, my_data)
		return
	end
	if data.attention_obj.reaction >= AIAttentionObject.REACT_COMBAT then
		my_data.want_to_take_cover = CopLogicAttack._chk_wants_to_take_cover(data, my_data)
		CopLogicAttack._update_cover(data)
		CopLogicAttack._upd_combat_movement(data)
	end
	SpoocLogicAttack.queue_update(data, my_data)
	CopLogicBase._report_detections(data.detected_attention_objects)
end

function SpoocLogicAttack.action_complete_clbk(data, action)
	local action_type = action:type()
	local my_data = data.internal_data
	if action_type == "walk" then
		if my_data.moving_to_cover then
			if action:expired() then
				my_data.in_cover = my_data.moving_to_cover
				CopLogicAttack._set_nearest_cover(my_data, my_data.in_cover)
				my_data.cover_enter_t = data.t
				my_data.cover_sideways_chk = nil
			end
			my_data.moving_to_cover = nil
		elseif my_data.walking_to_cover_shoot_pos then
			my_data.walking_to_cover_shoot_pos = nil
		end
	elseif action_type == "shoot" then
		my_data.shooting = nil
	elseif action_type == "turn" then
		my_data.turning = nil
	elseif action_type == "spooc" and my_data.spooc_attack then
		my_data.spooc_attack = nil
	end
end

function SpoocLogicAttack._cancel_spooc_attempt(data, my_data)
	if my_data.spooc_attack then
		local new_action = {type = "idle", body_part = 2}
		data.unit:brain():action_request(new_action)
	end
end

function SpoocLogicAttack._upd_spooc_attack(data, my_data)
	local focus_enemy = data.attention_obj
	if focus_enemy.nav_tracker and focus_enemy.is_person and focus_enemy.criminal_record and not focus_enemy.criminal_record.status and not my_data.spooc_attack and focus_enemy.verified and focus_enemy.verified_dis < (not (my_data.attitude ~= "engage" or data.is_suppressed) and 1500 or 900) and not data.unit:movement():chk_action_forbidden("walk") and (not my_data.last_dmg_t or data.t - my_data.last_dmg_t > 0.6) then
		local enemy_tracker = focus_enemy.nav_tracker
		local ray_params = {
			tracker_from = data.unit:movement():nav_tracker(),
			tracker_to = enemy_tracker,
			trace = true
		}
		if enemy_tracker:lost() then
			ray_params.pos_to = enemy_tracker:field_position()
		end
		local col_ray = managers.navigation:raycast(ray_params)
		if not col_ray then
			local z_diff_abs = math.abs(ray_params.trace[1].z - focus_enemy.m_pos.z)
			if z_diff_abs < 200 and SpoocLogicAttack._chk_request_action_spooc_attack(data, my_data) then
				my_data.spooc_attack = {
					start_t = data.t,
					target_u_data = focus_enemy
				}
				return true
			end
		end
	end
end

function SpoocLogicAttack._chk_request_action_spooc_attack(data, my_data)
	if data.unit:anim_data().crouch then
		CopLogicAttack._chk_request_action_stand(data)
	end
	local new_action = {type = "idle", body_part = 3}
	data.unit:brain():action_request(new_action)
	local new_action_data = {type = "spooc", body_part = 1}
	if data.unit:brain():action_request(new_action_data) then
		if my_data.rsrv_pos.stand then
			managers.navigation:unreserve_pos(my_data.rsrv_pos.stand)
			my_data.rsrv_pos.stand = nil
		end
		return true
	end
end

function SpoocLogicAttack.on_criminal_neutralized(data, criminal_key)
	CopLogicAttack.on_criminal_neutralized(data, criminal_key)
end

function SpoocLogicAttack.on_detected_enemy_destroyed(data, enemy_unit)
	CopLogicAttack.on_detected_enemy_destroyed(data, enemy_unit)
end

function SpoocLogicAttack.damage_clbk(data, damage_info)
	data.internal_data.last_dmg_t = TimerManager:game():time()
	CopLogicIdle.damage_clbk(data, damage_info)
end

function SpoocLogicAttack.is_available_for_assignment(data)
	if data.internal_data.spooc_attack then
		return
	end
	return CopLogicAttack.is_available_for_assignment(data)
end

function SpoocLogicAttack.action_taken(data, my_data)
	return CopLogicAttack.action_taken(data, my_data) or my_data.spooc_attack
end
