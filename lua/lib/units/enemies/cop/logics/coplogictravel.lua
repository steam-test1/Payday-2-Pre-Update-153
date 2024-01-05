local tmp_vec1 = Vector3()
local tmp_vec2 = Vector3()
CopLogicTravel = class(CopLogicBase)
CopLogicTravel.allowed_transitional_actions = {
	{
		"idle",
		"hurt",
		"dodge"
	},
	{"idle", "turn"},
	{
		"idle",
		"shoot",
		"reload"
	},
	{
		"hurt",
		"stand",
		"crouch"
	}
}
CopLogicTravel.allowed_transitional_actions_nav_link = {
	{
		"idle",
		"hurt",
		"dodge"
	},
	{
		"idle",
		"turn",
		"walk"
	},
	{
		"idle",
		"shoot",
		"reload"
	},
	{
		"hurt",
		"stand",
		"crouch"
	}
}
CopLogicTravel.damage_clbk = CopLogicIdle.damage_clbk
CopLogicTravel.death_clbk = CopLogicAttack.death_clbk
CopLogicTravel.on_detected_enemy_destroyed = CopLogicAttack.on_detected_enemy_destroyed
CopLogicTravel.on_criminal_neutralized = CopLogicAttack.on_criminal_neutralized
CopLogicTravel.on_alert = CopLogicIdle.on_alert
CopLogicTravel.on_new_objective = CopLogicIdle.on_new_objective

function CopLogicTravel.enter(data, new_logic_name, enter_params)
	CopLogicBase.enter(data, new_logic_name, enter_params)
	data.unit:brain():cancel_all_pathing_searches()
	local old_internal_data = data.internal_data
	local my_data = {
		unit = data.unit
	}
	local is_cool = data.unit:movement():cool()
	if is_cool then
		my_data.detection = data.char_tweak.detection.ntl
	else
		my_data.detection = data.char_tweak.detection.recon
	end
	my_data.rsrv_pos = {}
	if old_internal_data then
		my_data.rsrv_pos = old_internal_data.rsrv_pos or my_data.rsrv_pos
		if old_internal_data.nearest_cover then
			my_data.nearest_cover = old_internal_data.nearest_cover
			managers.navigation:reserve_cover(my_data.nearest_cover[1], data.pos_rsrv_id)
		end
		if old_internal_data.best_cover then
			my_data.best_cover = old_internal_data.best_cover
			managers.navigation:reserve_cover(my_data.best_cover[1], data.pos_rsrv_id)
		end
		my_data.attention_unit = old_internal_data.attention_unit
	end
	if data.char_tweak.announce_incomming then
		my_data.announce_t = data.t + 2
	end
	data.internal_data = my_data
	local key_str = tostring(data.unit:key())
	my_data.upd_task_key = "CopLogicTravel.queued_update" .. key_str
	CopLogicTravel.queue_update(data, my_data)
	my_data.cover_update_task_key = "CopLogicTravel._update_cover" .. key_str
	if my_data.nearest_cover or my_data.best_cover then
		CopLogicBase.add_delayed_clbk(my_data, my_data.cover_update_task_key, callback(CopLogicTravel, CopLogicTravel, "_update_cover", data), data.t + 1)
	end
	local allowed_actions
	if data.unit:movement():chk_action_forbidden("walk") and data.unit:movement()._active_actions[2] then
		allowed_actions = CopLogicTravel.allowed_transitional_actions_nav_link
		my_data.wants_stop_old_walk_action = true
	else
		allowed_actions = CopLogicTravel.allowed_transitional_actions
	end
	CopLogicTravel.reset_actions(data, my_data, old_internal_data, allowed_actions)
	if data.char_tweak.no_stand and data.unit:anim_data().stand then
		CopLogicAttack._chk_request_action_crouch(data)
	end
	local objective = data.objective
	if objective.pose then
		if data.objective.pose == "crouch" then
			if data.char_tweak.allow_crouch and not data.unit:anim_data().crouch and not data.unit:anim_data().crouching then
				CopLogicAttack._chk_request_action_crouch(data)
			end
		elseif not data.char_tweak.no_stand and not data.is_suppressed then
			CopLogicAttack._chk_request_action_stand(data)
		end
	end
	local path_data = objective.path_data
	if path_data then
		local path_style = objective.path_style
		if path_style == "precise" then
			local path = {
				mvector3.copy(data.m_pos)
			}
			for _, point in ipairs(path_data.points) do
				table.insert(path, mvector3.copy(point.position))
			end
			my_data.advance_path = path
			my_data.coarse_path_index = 1
			local start_seg = data.unit:movement():nav_tracker():nav_segment()
			local end_pos = mvector3.copy(path[#path])
			local end_seg = managers.navigation:get_nav_seg_from_pos(end_pos)
			my_data.coarse_path = {
				{start_seg},
				{end_seg, end_pos}
			}
			my_data.path_is_precise = true
		elseif path_style == "coarse" then
			local nav_manager = managers.navigation
			local f_get_nav_seg = nav_manager.get_nav_seg_from_pos
			local start_seg = data.unit:movement():nav_tracker():nav_segment()
			local path = {
				{start_seg}
			}
			for _, point in ipairs(path_data.points) do
				local pos = mvector3.copy(point.position)
				local nav_seg = f_get_nav_seg(nav_manager, pos)
				table.insert(path, {nav_seg, pos})
			end
			my_data.coarse_path = path
			my_data.coarse_path_index = CopLogicTravel.complete_coarse_path(data, my_data, path)
		elseif path_style == "coarse_complete" then
			my_data.coarse_path_index = 1
			my_data.coarse_path = deep_clone(objective.path_data)
			my_data.coarse_path_index = CopLogicTravel.complete_coarse_path(data, my_data, my_data.coarse_path)
		end
	end
	if objective.stance then
		local upper_body_action = data.unit:movement()._active_actions[3]
		if not upper_body_action or upper_body_action:type() ~= "shoot" then
			data.unit:movement():set_stance(objective.stance)
		end
	end
	if data.attention_obj and data.attention_obj.reaction > AIAttentionObject.REACT_AIM then
		data.unit:movement():set_cool(false, managers.groupai:state().analyse_giveaway(data.unit:base()._tweak_table, data.attention_obj.unit))
	end
	if is_cool then
		data.unit:brain():set_attention_settings({peaceful = true})
	else
		data.unit:brain():set_attention_settings({cbt = true})
	end
	my_data.weapon_range = data.char_tweak.weapon[data.unit:inventory():equipped_unit():base():weapon_tweak_data().usage].range
	data.unit:brain():set_update_enabled_state(false)
end

function CopLogicTravel.reset_actions(data, internal_data, old_internal_data, allowed_actions)
	local busy_body_parts = {
		false,
		false,
		false,
		false
	}
	local active_actions = {}
	for body_part = 1, 4 do
		local active_action = data.unit:movement()._active_actions[body_part]
		if active_action then
			local aa_type = active_action:type()
			for _, allowed_action in ipairs(allowed_actions[body_part]) do
				if aa_type == allowed_action then
					busy_body_parts[body_part] = true
					table.insert(active_actions, aa_type)
					break
				end
			end
		end
	end
	local shoot_interrupted = true
	for _, active_action in ipairs(active_actions) do
		if active_action == "shoot" then
			internal_data.shooting = old_internal_data.shooting
			internal_data.firing = old_internal_data.firing
			shoot_interrupted = false
		elseif active_action == "turn" then
			internal_data.turning = old_internal_data.turning
		end
	end
	if shoot_interrupted then
		data.unit:movement():set_allow_fire(false)
		CopLogicBase._reset_attention(data)
		internal_data.attention_unit = nil
	end
	local idle_body_part
	if busy_body_parts[1] or busy_body_parts[2] and busy_body_parts[3] then
		idle_body_part = 0
	elseif busy_body_parts[2] then
		idle_body_part = 3
	elseif busy_body_parts[3] then
		idle_body_part = 2
	else
		idle_body_part = 1
	end
	if 0 < idle_body_part then
		local new_action = {
			type = "idle",
			body_part = idle_body_part,
			sync = true
		}
		data.unit:brain():action_request(new_action)
	end
	return idle_body_part
end

function CopLogicTravel.exit(data, new_logic_name, enter_params)
	CopLogicBase.exit(data, new_logic_name, enter_params)
	local my_data = data.internal_data
	data.unit:brain():cancel_all_pathing_searches()
	CopLogicBase.cancel_queued_tasks(my_data)
	CopLogicBase.cancel_delayed_clbks(my_data)
	if my_data.moving_to_cover then
		managers.navigation:release_cover(my_data.moving_to_cover[1])
	end
	if my_data.nearest_cover then
		managers.navigation:release_cover(my_data.nearest_cover[1])
	end
	if my_data.best_cover then
		managers.navigation:release_cover(my_data.best_cover[1])
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

function CopLogicTravel.queued_update(data)
	local unit = data.unit
	local my_data = data.internal_data
	local objective = data.objective
	local t = TimerManager:game():time()
	data.t = t
	local delay = CopLogicTravel._upd_enemy_detection(data)
	if data.internal_data ~= my_data then
		return
	end
	if my_data.wants_stop_old_walk_action then
		if not data.unit:movement():chk_action_forbidden("walk") then
			data.unit:movement():action_request({type = "idle", body_part = 2})
			my_data.wants_stop_old_walk_action = nil
		end
	elseif my_data.advancing then
		if my_data.announce_t and t > my_data.announce_t then
			CopLogicTravel._try_anounce(data, my_data)
		end
	elseif my_data.processing_advance_path or my_data.processing_coarse_path or my_data.cover_leave_t or my_data.advance_path then
	elseif objective and (objective.nav_seg or objective.type == "follow") then
		if my_data.coarse_path then
			local coarse_path = my_data.coarse_path
			local cur_index = my_data.coarse_path_index
			local total_nav_points = #coarse_path
			if cur_index == total_nav_points then
				objective.in_place = true
				if objective.type == "investigate_area" or objective.type == "free" then
					if not objective.action_duration then
						managers.groupai:state():on_objective_complete(unit, objective)
						return
					end
				elseif objective.type == "defend_area" then
					if objective.grp_objective and objective.grp_objective.type == "retire" then
						data.unit:brain():set_active(false)
						data.unit:base():set_slot(data.unit, 0)
						return
					else
						managers.groupai:state():on_defend_travel_end(unit, objective)
					end
				end
				CopLogicTravel.on_new_objective(data)
				return
			else
				local start_pathing = CopLogicTravel.chk_group_ready_to_move(data, my_data)
				if start_pathing then
					local to_pos
					if cur_index == total_nav_points - 1 then
						local new_occupation = CopLogicTravel._determine_destination_occupation(data, objective)
						if new_occupation then
							if new_occupation.type == "guard" then
								local guard_door = new_occupation.door
								local guard_pos = CopLogicTravel._get_pos_accross_door(guard_door, objective.nav_seg)
								if guard_pos then
									local reservation = CopLogicTravel._reserve_pos_along_vec(guard_door.center, guard_pos)
									if reservation then
										if my_data.rsrv_pos.path then
											managers.navigation:unreserve_pos(my_data.rsrv_pos.path)
										end
										my_data.rsrv_pos.path = reservation
										local guard_object = {
											type = "door",
											door = guard_door,
											from_seg = new_occupation.from_seg
										}
										objective.guard_obj = guard_object
										to_pos = reservation.pos
									end
								end
							elseif new_occupation.type == "defend" then
								if new_occupation.cover then
									to_pos = new_occupation.cover[1][1]
									if data.char_tweak.wall_fwd_offset then
										to_pos = CopLogicTravel.apply_wall_offset_to_cover(data, my_data, new_occupation.cover[1], data.char_tweak.wall_fwd_offset)
									end
									managers.navigation:reserve_cover(new_occupation.cover[1], data.pos_rsrv_id)
									my_data.moving_to_cover = new_occupation.cover
								elseif new_occupation.pos then
									to_pos = new_occupation.pos
									local reservation = {
										position = mvector3.copy(to_pos),
										radius = 60,
										filter = data.pos_rsrv_id
									}
									managers.navigation:add_pos_reservation(reservation)
									if my_data.rsrv_pos.path then
										managers.navigation:unreserve_pos(reservation)
									end
									my_data.rsrv_pos.path = reservation
								end
							else
								to_pos = new_occupation.pos
								if to_pos then
									local reservation = {
										position = mvector3.copy(to_pos),
										radius = 60,
										filter = data.pos_rsrv_id
									}
									managers.navigation:add_pos_reservation(reservation)
									if my_data.rsrv_pos.path then
										managers.navigation:unreserve_pos(my_data.rsrv_pos.path)
									end
									my_data.rsrv_pos.path = reservation
								end
							end
						end
						if not to_pos then
							to_pos = managers.navigation:find_random_position_in_segment(objective.nav_seg)
							to_pos = CopLogicTravel._get_pos_on_wall(to_pos)
							local reservation = {
								position = mvector3.copy(to_pos),
								radius = 60,
								filter = data.pos_rsrv_id
							}
							managers.navigation:add_pos_reservation(reservation)
							if my_data.rsrv_pos.path then
								managers.navigation:unreserve_pos(my_data.rsrv_pos.path)
							end
							my_data.rsrv_pos.path = reservation
						end
					else
						local end_pos = coarse_path[cur_index + 1][2]
						local cover = CopLogicTravel._find_cover(data, coarse_path[cur_index + 1][1])
						if cover then
							managers.navigation:reserve_cover(cover, data.pos_rsrv_id)
							my_data.moving_to_cover = {cover}
							to_pos = cover[1]
						else
							to_pos = managers.navigation:find_random_position_in_segment(coarse_path[cur_index + 1][1])
							my_data.moving_to_cover = nil
						end
					end
					my_data.advance_path_search_id = tostring(unit:key()) .. "advance"
					my_data.processing_advance_path = true
					local nav_segs = CopLogicTravel._get_allowed_travel_nav_segs(data, my_data, to_pos)
					unit:brain():search_for_path(my_data.advance_path_search_id, to_pos, nil, nil, nav_segs)
				end
			end
		else
			local search_id = tostring(unit:key()) .. "coarse"
			local verify_clbk
			if not my_data.coarse_search_failed then
				verify_clbk = callback(CopLogicTravel, CopLogicTravel, "_investigate_coarse_path_verify_clbk")
			end
			local nav_seg
			if objective.follow_unit then
				nav_seg = objective.follow_unit:movement():nav_tracker():nav_segment()
			else
				nav_seg = objective.nav_seg
			end
			if unit:brain():search_for_coarse_path(search_id, nav_seg, verify_clbk) then
				my_data.coarse_path_search_id = search_id
				my_data.processing_coarse_path = true
			end
		end
	else
		CopLogicBase._exit(data.unit, "idle")
		return
	end
	if my_data.processing_advance_path or my_data.processing_coarse_path then
		CopLogicTravel._upd_pathing(data, my_data)
		if data.internal_data ~= my_data then
			return
		end
	end
	if my_data.advancing then
	elseif my_data.cover_leave_t then
		if not my_data.turning and not unit:movement():chk_action_forbidden("walk") and not data.unit:anim_data().reload then
			if t > my_data.cover_leave_t then
				my_data.cover_leave_t = nil
			elseif data.attention_obj and data.attention_obj.reaction >= AIAttentionObject.REACT_SCARED and not CopLogicTravel._chk_request_action_turn_to_cover(data, my_data) and (not my_data.best_cover or not my_data.best_cover[4]) and not unit:anim_data().crouch and data.char_tweak.allow_crouch then
				CopLogicAttack._chk_request_action_crouch(data)
			end
		end
	elseif my_data.advance_path and not data.unit:movement():chk_action_forbidden("walk") then
		local haste
		if objective and objective.haste then
			haste = objective.haste
		elseif data.unit:movement():cool() then
			haste = "walk"
		else
			haste = "run"
		end
		local pose
		if not data.char_tweak.crouch_move then
			pose = "stand"
		elseif data.char_tweak.no_stand then
			pose = "crouch"
		else
			pose = data.is_suppressed and "crouch" or objective and objective.pose or "stand"
		end
		if not unit:anim_data()[pose] then
			CopLogicAttack["_chk_request_action_" .. pose](data)
		end
		local end_rot
		if my_data.coarse_path_index == #my_data.coarse_path - 1 then
			end_rot = objective and objective.rot
		end
		local no_strafe
		CopLogicTravel._chk_request_action_walk_to_advance_pos(data, my_data, haste, end_rot, no_strafe)
	end
	CopLogicTravel.queue_update(data, my_data, delay)
end

function CopLogicTravel._upd_enemy_detection(data)
	managers.groupai:state():on_unit_detection_updated(data.unit)
	local my_data = data.internal_data
	local delay = CopLogicBase._upd_attention_obj_detection(data, nil, nil)
	local new_attention, new_prio_slot, new_reaction = CopLogicIdle._get_priority_attention(data, data.detected_attention_objects, nil)
	local old_att_obj = data.attention_obj
	CopLogicBase._set_attention_obj(data, new_attention, new_reaction)
	local objective = data.objective
	local allow_trans, obj_failed = CopLogicBase.is_obstructed(data, objective, nil, new_attention)
	if allow_trans and (not (not obj_failed and objective) or objective.type ~= "follow") then
		local wanted_state = CopLogicBase._get_logic_state_from_reaction(data)
		if wanted_state and wanted_state ~= data.name then
			if obj_failed then
				managers.groupai:state():on_objective_failed(data.unit, data.objective)
			end
			if my_data == data.internal_data and not objective.is_default then
				debug_pause_unit(data.unit, "[CopLogicTravel._upd_enemy_detection] exiting without discarding objective", data.unit, inspect(objective))
				CopLogicBase._exit(data.unit, wanted_state)
			end
			CopLogicBase._report_detections(data.detected_attention_objects)
			return
		end
	end
	if my_data == data.internal_data then
		if new_reaction == AIAttentionObject.REACT_SUSPICIOUS and CopLogicBase._upd_suspicion(data, my_data, new_attention) then
			CopLogicBase._report_detections(data.detected_attention_objects)
			return
		elseif new_reaction and new_reaction <= AIAttentionObject.REACT_SCARED then
			local set_attention = data.unit:movement():attention()
			if not set_attention or set_attention.u_key ~= new_attention.u_key then
				CopLogicBase._set_attention(data, new_attention, nil)
			end
		end
		CopLogicAttack._upd_aim(data, my_data)
	end
	CopLogicBase._report_detections(data.detected_attention_objects)
	return delay
end

function CopLogicTravel._upd_pathing(data, my_data)
	if data.pathing_results then
		local pathing_results = data.pathing_results
		data.pathing_results = nil
		local path = pathing_results[my_data.advance_path_search_id]
		if path then
			my_data.processing_advance_path = nil
			my_data.advance_path_search_id = nil
			if path ~= "failed" then
				my_data.advance_path = path
			else
				print("[CopLogicTravel:_upd_pathing] advance_path failed", data.unit, my_data.coarse_path_index, inspect(my_data.coarse_path))
				managers.groupai:state():on_objective_failed(data.unit, data.objective)
				return
			end
		end
		path = pathing_results[my_data.coarse_path_search_id]
		if path then
			my_data.processing_coarse_path = nil
			my_data.coarse_path_search_id = nil
			if path ~= "failed" then
				my_data.coarse_path = path
				my_data.coarse_path_index = 1
			elseif my_data.coarse_search_failed then
				print("[CopLogicTravel:_upd_pathing] coarse_path failed unsafe", data.unit, my_data.coarse_path_index, inspect(my_data.coarse_path))
				data.path_fail_t = data.t
				managers.groupai:state():on_objective_failed(data.unit, data.objective)
				return
			else
				my_data.coarse_search_failed = true
			end
		end
	end
end

function CopLogicTravel._update_cover(ignore_this, data)
	local my_data = data.internal_data
	CopLogicBase.on_delayed_clbk(my_data, my_data.cover_update_task_key)
	local cover_release_dis = 100
	local nearest_cover = my_data.nearest_cover
	local best_cover = my_data.best_cover
	local m_pos = data.m_pos
	if not my_data.in_cover and nearest_cover and cover_release_dis < mvector3.distance(nearest_cover[1][1], m_pos) then
		managers.navigation:release_cover(nearest_cover[1])
		my_data.nearest_cover = nil
		nearest_cover = nil
	end
	if best_cover and cover_release_dis < mvector3.distance(best_cover[1][1], m_pos) then
		managers.navigation:release_cover(best_cover[1])
		my_data.best_cover = nil
		best_cover = nil
	end
	if nearest_cover or best_cover then
		CopLogicBase.add_delayed_clbk(my_data, my_data.cover_update_task_key, callback(CopLogicTravel, CopLogicTravel, "_update_cover", data), data.t + 1)
	end
end

function CopLogicTravel._chk_request_action_turn_to_cover(data, my_data)
	local fwd = data.unit:movement():m_rot():y()
	mvector3.set(tmp_vec1, my_data.best_cover[1][2])
	mvector3.negate(tmp_vec1)
	local error_spin = tmp_vec1:to_polar_with_reference(fwd, math.UP).spin
	if math.abs(error_spin) > 25 then
		local new_action_data = {}
		new_action_data.type = "turn"
		new_action_data.body_part = 2
		new_action_data.angle = error_spin
		if data.unit:brain():action_request(new_action_data) then
			my_data.turning = new_action_data.angle
			return true
		end
	end
end

function CopLogicTravel._chk_cover_height(data, cover, slotmask)
	local ray_from = tmp_vec1
	mvector3.set(ray_from, math.UP)
	mvector3.multiply(ray_from, 110)
	mvector3.add(ray_from, cover[1])
	local ray_to = tmp_vec2
	mvector3.set(ray_to, cover[2])
	mvector3.multiply(ray_to, 200)
	mvector3.add(ray_to, ray_from)
	local ray = World:raycast("ray", ray_from, ray_to, "slot_mask", slotmask, "ray_type", "ai_vision", "report")
	return ray
end

function CopLogicTravel.action_complete_clbk(data, action)
	local my_data = data.internal_data
	local action_type = action:type()
	if action_type == "walk" then
		my_data.advancing = nil
		my_data.rsrv_pos.stand = my_data.rsrv_pos.move_dest
		my_data.rsrv_pos.move_dest = nil
		if action:expired() and not my_data.starting_advance_action and my_data.coarse_path_index then
			my_data.coarse_path_index = my_data.coarse_path_index + 1
		end
		if my_data.moving_to_cover then
			if action:expired() then
				if my_data.best_cover then
					managers.navigation:release_cover(my_data.best_cover[1])
				end
				my_data.best_cover = my_data.moving_to_cover
				CopLogicBase.chk_cancel_delayed_clbk(my_data, my_data.cover_update_task_key)
				local high_ray = CopLogicTravel._chk_cover_height(data, my_data.best_cover[1], data.visibility_slotmask)
				my_data.best_cover[4] = high_ray
				my_data.in_cover = true
				local cover_wait_t = my_data.cover_wait_t or {0.7, 0.8}
				my_data.cover_leave_t = data.t + cover_wait_t[1] + cover_wait_t[2] * math.random()
			else
				managers.navigation:release_cover(my_data.moving_to_cover[1])
				if my_data.best_cover then
					local dis = mvector3.distance(my_data.best_cover[1][1], data.unit:movement():m_pos())
					if 100 < dis then
						managers.navigation:release_cover(my_data.best_cover[1])
						my_data.best_cover = nil
					end
				end
			end
			my_data.moving_to_cover = nil
		elseif my_data.best_cover then
			local dis = mvector3.distance(my_data.best_cover[1][1], data.unit:movement():m_pos())
			if 100 < dis then
				managers.navigation:release_cover(my_data.best_cover[1])
				my_data.best_cover = nil
			end
		end
	elseif action_type == "turn" then
		data.internal_data.turning = nil
	elseif action_type == "shoot" then
		data.internal_data.shooting = nil
	elseif action_type == "dodge" then
		local objective = data.objective
		local allow_trans, obj_failed = CopLogicBase.is_obstructed(data, objective, nil, nil)
		if allow_trans then
			local wanted_state = data.logic._get_logic_state_from_reaction(data)
			if wanted_state and wanted_state ~= data.name and obj_failed then
				if data.unit:in_slot(managers.slot:get_mask("enemies")) or data.unit:in_slot(17) then
					managers.groupai:state():on_objective_failed(data.unit, data.objective)
				elseif data.unit:in_slot(managers.slot:get_mask("criminals")) then
					managers.groupai:state():on_criminal_objective_failed(data.unit, data.objective, false)
				end
				if my_data == data.internal_data then
					debug_pause_unit(data.unit, "[CopLogicTravel.action_complete_clbk] exiting without discarding objective", data.unit, inspect(data.objective))
					CopLogicBase._exit(data.unit, wanted_state)
				end
			end
		end
	end
end

function CopLogicTravel._get_pos_accross_door(guard_door, nav_seg)
	local rooms = guard_door.rooms
	local room_1_seg = guard_door.low_seg
	local accross_vec = guard_door.high_pos - guard_door.low_pos
	local rot_angle = 90
	if room_1_seg == nav_seg then
		if guard_door.low_pos.y == guard_door.high_pos.y then
			rot_angle = rot_angle * -1
		end
	elseif guard_door.low_pos.x == guard_door.high_pos.x then
		rot_angle = rot_angle * -1
	end
	mvector3.rotate_with(accross_vec, Rotation(rot_angle))
	local max_dis = 1500
	mvector3.set_length(accross_vec, 1500)
	local door_pos = guard_door.center
	local door_tracker = managers.navigation:create_nav_tracker(mvector3.copy(door_pos))
	local accross_positions = managers.navigation:find_walls_accross_tracker(door_tracker, accross_vec)
	if accross_positions then
		local optimal_dis = math.lerp(max_dis * 0.6, max_dis, math.random())
		local best_error_dis, best_pos, best_is_hit, best_is_miss, best_has_too_much_error
		for _, accross_pos in ipairs(accross_positions) do
			local error_dis = math.abs(mvector3.distance(accross_pos[1], door_pos) - optimal_dis)
			local too_much_error = 0.3 < error_dis / optimal_dis
			local is_hit = accross_pos[2]
			if best_is_hit then
				if is_hit then
					if best_error_dis > error_dis then
						best_pos = accross_pos[1]
						best_error_dis = error_dis
						best_has_too_much_error = too_much_error
					end
				elseif best_has_too_much_error then
					best_pos = accross_pos[1]
					best_error_dis = error_dis
					best_is_miss = true
					best_is_hit = nil
				end
			elseif best_is_miss then
				if not too_much_error then
					best_pos = accross_pos[1]
					best_error_dis = error_dis
					best_has_too_much_error = nil
					best_is_miss = nil
					best_is_hit = true
				end
			else
				best_pos = accross_pos[1]
				best_is_hit = is_hit
				best_is_miss = not is_hit
				best_has_too_much_error = too_much_error
				best_error_dis = error_dis
			end
		end
		managers.navigation:destroy_nav_tracker(door_tracker)
		return best_pos
	end
	managers.navigation:destroy_nav_tracker(door_tracker)
end

function CopLogicTravel.is_available_for_assignment(data, new_objective)
	if new_objective and new_objective.forced then
		return true
	elseif data.objective and data.objective.type == "act" then
		return
	else
		return CopLogicAttack.is_available_for_assignment(data, new_objective)
	end
end

function CopLogicTravel.is_advancing(data)
	if data.internal_data.advancing then
		return data.internal_data.rsrv_pos.move_dest.position
	end
end

function CopLogicTravel._reserve_pos_along_vec(look_pos, wanted_pos)
	local step_vec = look_pos - wanted_pos
	local max_pos_mul = math.floor(mvector3.length(step_vec) / 65)
	mvector3.set_length(step_vec, 65)
	local data = {
		start_pos = wanted_pos,
		step_vec = step_vec,
		step_mul = 0 < max_pos_mul and 1 or -1,
		block = max_pos_mul == 0,
		max_pos_mul = max_pos_mul
	}
	local step_clbk = callback(CopLogicTravel, CopLogicTravel, "_rsrv_pos_along_vec_step_clbk", data)
	local res_data = managers.navigation:reserve_pos(nil, nil, wanted_pos, step_clbk, 40, data.pos_rsrv_id)
	return res_data
end

function CopLogicTravel._rsrv_pos_along_vec_step_clbk(shait, data, test_pos)
	local step_mul = data.step_mul
	local nav_manager = managers.navigation
	local step_vec = data.step_vec
	mvector3.set(test_pos, step_vec)
	mvector3.multiply(test_pos, step_mul)
	mvector3.add(test_pos, data.start_pos)
	local params = {
		pos_from = data.start_pos,
		pos_to = test_pos,
		allow_entry = false
	}
	local blocked = nav_manager:raycast(params)
	if blocked then
		if data.block then
			return false
		end
		data.block = true
		if 0 < step_mul then
			data.step_mul = -step_mul
		else
			data.step_mul = -step_mul + 1
			if data.step_mul > data.max_pos_mul then
				return
			end
		end
		return CopLogicTravel._rsrv_pos_along_vec_step_clbk(shait, data, test_pos)
	elseif data.block then
		data.step_mul = step_mul + math.sign(step_mul)
		if data.step_mul > data.max_pos_mul then
			return
		end
	elseif 0 < step_mul then
		data.step_mul = -step_mul
	else
		data.step_mul = -step_mul + 1
		if data.step_mul > data.max_pos_mul then
			data.block = true
			data.step_mul = -data.step_mul
		end
	end
	return true
end

function CopLogicTravel._investigate_coarse_path_verify_clbk(shait, nav_seg)
	return managers.groupai:state():is_nav_seg_safe(nav_seg)
end

function CopLogicTravel.on_intimidated(data, amount, aggressor_unit)
	local surrender = CopLogicIdle.on_intimidated(data, amount, aggressor_unit)
	if surrender and data.objective then
		managers.groupai:state():on_objective_failed(data.unit, data.objective)
	end
end

function CopLogicTravel._chk_request_action_walk_to_advance_pos(data, my_data, speed, end_rot, no_strafe)
	if not data.unit:movement():chk_action_forbidden("walk") or data.unit:anim_data().act_idle then
		CopLogicAttack._correct_path_start_pos(data, my_data.advance_path)
		local path = my_data.advance_path
		local new_action_data = {
			type = "walk",
			nav_path = path,
			variant = speed or "run",
			body_part = 2,
			end_rot = end_rot,
			path_simplified = my_data.path_is_precise,
			no_strafe = no_strafe
		}
		my_data.advance_path = nil
		my_data.starting_advance_action = true
		my_data.advancing = data.unit:brain():action_request(new_action_data)
		my_data.starting_advance_action = false
		if my_data.advancing then
			if my_data.rsrv_pos.path then
				my_data.rsrv_pos.move_dest = my_data.rsrv_pos.path
				my_data.rsrv_pos.path = nil
			else
				local end_pos = mvector3.copy(path[#path])
				local rsrv_desc = {
					filter = data.pos_rsrv_id,
					position = end_pos,
					radius = 30
				}
				managers.navigation:add_pos_reservation(rsrv_desc)
				my_data.rsrv_pos.move_dest = rsrv_desc
			end
			if my_data.rsrv_pos.stand then
				managers.navigation:unreserve_pos(my_data.rsrv_pos.stand)
				my_data.rsrv_pos.stand = nil
			end
			if my_data.nearest_cover and (not my_data.delayed_clbks or not my_data.delayed_clbks[my_data.cover_update_task_key]) then
				CopLogicBase.add_delayed_clbk(my_data, my_data.cover_update_task_key, callback(CopLogicTravel, CopLogicTravel, "_update_cover", data), data.t + 1)
			end
		end
	end
end

function CopLogicTravel._determine_destination_occupation(data, objective)
	local occupation
	if objective.type == "investigate_area" then
		if objective.guard_obj then
			occupation = managers.groupai:state():verify_occupation_in_area(objective) or objective.guard_obj
			occupation.type = "guard"
		else
			occupation = managers.groupai:state():find_occupation_in_area(objective.nav_seg)
		end
	elseif objective.type == "defend_area" then
		if objective.cover then
			occupation = {
				type = "defend",
				seg = objective.nav_seg,
				cover = objective.cover,
				radius = objective.radius
			}
		elseif objective.pos then
			occupation = {
				type = "defend",
				seg = objective.nav_seg,
				pos = objective.pos,
				radius = objective.radius
			}
		else
			local near_pos = objective.follow_unit and objective.follow_unit:movement():nav_tracker():field_position()
			local cover = CopLogicTravel._find_cover(data, objective.nav_seg, near_pos)
			if cover then
				local cover_entry = {cover}
				occupation = {
					type = "defend",
					seg = objective.nav_seg,
					cover = cover_entry,
					radius = objective.radius
				}
			else
				near_pos = CopLogicTravel._get_pos_on_wall(managers.navigation._nav_segments[objective.nav_seg].pos, 700)
				occupation = {
					type = "defend",
					seg = objective.nav_seg,
					pos = near_pos,
					radius = objective.radius
				}
			end
		end
	elseif objective.type == "act" then
		occupation = {
			type = "act",
			seg = objective.nav_seg,
			pos = objective.pos
		}
	elseif objective.type == "follow" then
		local follow_pos, follow_nav_seg
		local follow_unit_objective = objective.follow_unit:brain() and objective.follow_unit:brain():objective()
		if not follow_unit_objective or follow_unit_objective.in_place or not follow_unit_objective.nav_seg then
			follow_pos = objective.follow_unit:movement():m_pos()
			follow_nav_seg = objective.follow_unit:movement():nav_tracker():nav_segment()
		else
			follow_pos = follow_unit_objective.pos or objective.follow_unit:movement():m_pos()
			follow_nav_seg = follow_unit_objective.nav_seg
		end
		local distance = objective.distance and math.lerp(objective.distance * 0.5, objective.distance, math.random()) or 700
		local to_pos = CopLogicTravel._get_pos_on_wall(follow_pos, distance)
		occupation = {
			type = "defend",
			nav_seg = follow_nav_seg,
			pos = to_pos
		}
	else
		occupation = {
			seg = objective.nav_seg,
			pos = objective.pos
		}
	end
	return occupation
end

function CopLogicTravel._get_pos_on_wall(from_pos, max_dist, step_offset, is_recurse)
	local nav_manager = managers.navigation
	local nr_rays = 7
	local ray_dis = max_dist or 1000
	local step = 360 / nr_rays
	local offset = step_offset or math.random(360)
	local step_rot = Rotation(step)
	local offset_rot = Rotation(offset)
	local offset_vec = Vector3(ray_dis, 0, 0)
	mvector3.rotate_with(offset_vec, offset_rot)
	local to_pos = mvector3.copy(from_pos)
	mvector3.add(to_pos, offset_vec)
	local from_tracker = nav_manager:create_nav_tracker(from_pos)
	local ray_params = {
		tracker_from = from_tracker,
		allow_entry = false,
		pos_to = to_pos,
		trace = true
	}
	local rsrv_desc = {false, 60}
	local fail_position
	repeat
		to_pos = mvector3.copy(from_pos)
		mvector3.add(to_pos, offset_vec)
		ray_params.pos_to = to_pos
		local ray_res = nav_manager:raycast(ray_params)
		if ray_res then
			rsrv_desc.position = ray_params.trace[1]
			local is_free = nav_manager:is_pos_free(rsrv_desc)
			if is_free then
				managers.navigation:destroy_nav_tracker(from_tracker)
				return ray_params.trace[1]
			else
			end
		elseif not fail_position then
			rsrv_desc.position = ray_params.trace[1]
			local is_free = nav_manager:is_pos_free(rsrv_desc)
			if is_free then
				fail_position = to_pos
			end
		end
		mvector3.rotate_with(offset_vec, step_rot)
		nr_rays = nr_rays - 1
	until nr_rays == 0
	managers.navigation:destroy_nav_tracker(from_tracker)
	if fail_position then
		return fail_position
	end
	if not is_recurse then
		return CopLogicTravel._get_pos_on_wall(from_pos, ray_dis * 0.5, offset + step * 0.5, true)
	end
	return from_pos
end

function CopLogicTravel.queue_update(data, my_data, delay)
	if data.important then
		delay = 0
	else
		delay = delay or 0.3
	end
	CopLogicBase.queue_task(my_data, my_data.upd_task_key, CopLogicTravel.queued_update, data, data.t + delay, data.important and true)
end

function CopLogicTravel._try_anounce(data, my_data)
	local my_pos = data.m_pos
	local max_dis_sq = 250000
	local my_key = data.key
	local announce_type = data.char_tweak.announce_incomming
	for u_key, u_data in pairs(managers.enemy:all_enemies()) do
		if u_key ~= my_key and tweak_data.character[u_data.unit:base()._tweak_table].chatter[announce_type] and max_dis_sq > mvector3.distance_sq(my_pos, u_data.m_pos) and not u_data.unit:sound():speaking(data.t) and (u_data.unit:anim_data().idle or u_data.unit:anim_data().move) then
			managers.groupai:state():chk_say_enemy_chatter(u_data.unit, u_data.m_pos, announce_type)
			my_data.announce_t = data.t + 15
			break
		end
	end
end

function CopLogicTravel._get_all_paths(data)
	return {
		advance_path = data.internal_data.advance_path
	}
end

function CopLogicTravel._set_verified_paths(data, verified_paths)
	data.internal_data.advance_path = verified_paths.advance_path
end

function CopLogicTravel.chk_should_turn(data, my_data)
	return not my_data.advancing and not my_data.turning and not data.unit:movement():chk_action_forbidden("walk")
end

function CopLogicTravel.complete_coarse_path(data, my_data, coarse_path)
	local first_seg_id = coarse_path[1][1]
	local current_seg_id = data.unit:movement():nav_tracker():nav_segment()
	local all_nav_segs = managers.navigation._nav_segments
	local i_nav_point = 1
	while i_nav_point < #coarse_path do
		local nav_seg_id = coarse_path[i_nav_point][1]
		local next_nav_seg_id = coarse_path[i_nav_point + 1][1]
		local nav_seg = all_nav_segs[nav_seg_id]
		if not nav_seg.neighbours[next_nav_seg_id] then
			local search_params = {
				from_seg = nav_seg_id,
				to_seg = next_nav_seg_id,
				id = "CopLogicTravel_complete_coarse_path",
				access_pos = "cop"
			}
			local ins_coarse_path = managers.navigation:search_coarse(search_params)
			if not ins_coarse_path then
				my_data.coarse_path = nil
				return
			end
			local i_insert = #ins_coarse_path - 1
			while 1 < i_insert do
				table.insert(coarse_path, i_nav_point + 1, ins_coarse_path[i_insert])
				i_insert = i_insert - 1
			end
		end
		i_nav_point = i_nav_point + 1
	end
	local start_index
	for i, nav_point in ipairs(coarse_path) do
		if current_seg_id == nav_point[1] then
			start_index = i
		end
	end
	if start_index then
		start_index = math.min(start_index, #coarse_path - 1)
		return start_index
	end
	local to_search_segs = {current_seg_id}
	local found_segs = {
		[current_seg_id] = "init"
	}
	repeat
		local search_seg_id = table.remove(to_search_segs, 1)
		local search_seg = all_nav_segs[search_seg_id]
		for other_seg_id, door_list in pairs(search_seg.neighbours) do
			local other_seg = all_nav_segs[other_seg_id]
			if not other_seg.disabled and not found_segs[other_seg_id] then
				found_segs[other_seg_id] = search_seg_id
				if other_seg_id == first_seg_id then
					local last_added_seg_id = other_seg_id
					while found_segs[last_added_seg_id] ~= "init" do
						last_added_seg_id = found_segs[last_added_seg_id]
						table.insert(coarse_path, 1, {
							last_added_seg_id,
							all_nav_segs[last_added_seg_id].pos
						})
					end
					return 1
				else
					table.insert(to_search_segs, other_seg_id)
				end
			end
		end
	until #to_search_segs == 0
	return 1
end

function CopLogicTravel.chk_group_ready_to_move(data, my_data)
	local my_objective = data.objective
	if not my_objective.grp_objective then
		return true
	end
	local my_dis = mvector3.distance_sq(my_objective.area.pos, data.m_pos)
	if 4000000 < my_dis then
		return true
	end
	my_dis = my_dis * 1.15 * 1.15
	for u_key, u_data in pairs(data.group.units) do
		if u_key ~= data.key then
			local his_objective = u_data.unit:brain():objective()
			if his_objective and his_objective.grp_objective == my_objective.grp_objective and not his_objective.in_place then
				local his_dis = mvector3.distance_sq(his_objective.area.pos, u_data.m_pos)
				if my_dis < his_dis then
					return false
				end
			end
		end
	end
	return true
end

function CopLogicTravel.apply_wall_offset_to_cover(data, my_data, cover, wall_fwd_offset)
	local to_pos_fwd = tmp_vec1
	mvector3.set(to_pos_fwd, cover[2])
	mvector3.multiply(to_pos_fwd, wall_fwd_offset)
	mvector3.add(to_pos_fwd, cover[1])
	local ray_params = {
		tracker_from = cover[3],
		pos_to = to_pos_fwd,
		trace = true
	}
	local collision = managers.navigation:raycast(ray_params)
	if not collision then
		return cover[1]
	end
	local col_pos_fwd = ray_params.trace[1]
	local space_needed = mvector3.distance(col_pos_fwd, to_pos_fwd) + wall_fwd_offset * 1.05
	local to_pos_bwd = tmp_vec2
	mvector3.set(to_pos_bwd, cover[2])
	mvector3.multiply(to_pos_bwd, -space_needed)
	mvector3.add(to_pos_bwd, cover[1])
	local ray_params = {
		tracker_from = cover[3],
		pos_to = to_pos_bwd,
		trace = true
	}
	local collision = managers.navigation:raycast(ray_params)
	return collision and ray_params.trace[1] or mvector3.copy(to_pos_bwd)
end

function CopLogicTravel._find_cover(data, search_nav_seg, near_pos)
	local cover
	local search_area = managers.groupai:state():get_area_from_nav_seg_id(search_nav_seg)
	if data.unit:movement():cool() then
		cover = managers.navigation:find_cover_in_nav_seg_1(search_area.nav_segs)
	else
		local optimal_threat_dis, threat_pos
		if data.objective.attitude == "engage" then
			optimal_threat_dis = data.internal_data.weapon_range.optimal
		else
			optimal_threat_dis = data.internal_data.weapon_range.far
		end
		near_pos = near_pos or search_area.pos
		local all_criminals = managers.groupai:state():all_char_criminals()
		local closest_crim_u_data, closest_crim_dis
		for u_key, u_data in pairs(all_criminals) do
			local crim_area = managers.groupai:state():get_area_from_nav_seg_id(u_data.tracker:nav_segment())
			if crim_area == search_area then
				threat_pos = u_data.m_pos
				break
			else
				local crim_dis = mvector3.distance_sq(near_pos, u_data.m_pos)
				if not closest_crim_dis or closest_crim_dis > crim_dis then
					threat_pos = u_data.m_pos
					closest_crim_dis = crim_dis
				end
			end
		end
		cover = managers.navigation:find_cover_from_threat(search_area.nav_segs, optimal_threat_dis, near_pos, threat_pos)
	end
	return cover
end

function CopLogicTravel._get_allowed_travel_nav_segs(data, my_data, to_pos)
	local nav_segs = {}
	local added_segs = {}
	for _, nav_point in ipairs(my_data.coarse_path) do
		local area = managers.groupai:state():get_area_from_nav_seg_id(nav_point[1])
		for nav_seg_id, _ in pairs(area.nav_segs) do
			if not added_segs[nav_seg_id] then
				added_segs[nav_seg_id] = true
				table.insert(nav_segs, nav_seg_id)
			end
		end
	end
	local end_nav_seg = managers.navigation:get_nav_seg_from_pos(to_pos, true)
	local end_area = managers.groupai:state():get_area_from_nav_seg_id(end_nav_seg)
	for nav_seg_id, _ in pairs(end_area.nav_segs) do
		if not added_segs[nav_seg_id] then
			added_segs[nav_seg_id] = true
			table.insert(nav_segs, nav_seg_id)
		end
	end
	local standing_nav_seg = data.unit:movement():nav_tracker():nav_segment()
	if not added_segs[standing_nav_seg] then
		table.insert(nav_segs, standing_nav_seg)
		added_segs[standing_nav_seg] = true
	end
	return nav_segs
end
