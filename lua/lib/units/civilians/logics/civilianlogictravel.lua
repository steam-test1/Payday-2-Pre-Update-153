CivilianLogicTravel = class(CopLogicBase)
CivilianLogicTravel.on_alert = CivilianLogicIdle.on_alert
CivilianLogicTravel.on_new_objective = CivilianLogicIdle.on_new_objective
CivilianLogicTravel.action_complete_clbk = CopLogicTravel.action_complete_clbk
CivilianLogicTravel.is_available_for_assignment = CopLogicTravel.is_available_for_assignment

function CivilianLogicTravel.enter(data, new_logic_name, enter_params)
	CopLogicBase.enter(data, new_logic_name, enter_params)
	data.unit:brain():cancel_all_pathing_searches()
	local old_internal_data = data.internal_data
	local my_data = {
		unit = data.unit
	}
	data.internal_data = my_data
	local is_cool = data.unit:movement():cool()
	if is_cool then
		my_data.detection = data.char_tweak.detection.ntl
	else
		my_data.detection = data.char_tweak.detection.cbt
	end
	my_data.rsrv_pos = {}
	if old_internal_data then
		my_data.rsrv_pos = old_internal_data.rsrv_pos or my_data.rsrv_pos
	end
	data.unit:brain():set_update_enabled_state(true)
	CivilianLogicEscort._get_objective_path_data(data, my_data)
	my_data.tmp_vec3 = Vector3()
	local key_str = tostring(data.key)
	if not data.been_outlined and data.char_tweak.outline_on_discover then
		my_data.outline_detection_task_key = "CivilianLogicIdle._upd_outline_detection" .. key_str
		CopLogicBase.queue_task(my_data, my_data.outline_detection_task_key, CivilianLogicIdle._upd_outline_detection, data, data.t + 2)
	end
	my_data.detection_task_key = "CivilianLogicTravel_upd_detection" .. key_str
	CopLogicBase.queue_task(my_data, my_data.detection_task_key, CivilianLogicIdle._upd_detection, data, data.t + 1)
	if not data.unit:movement():cool() then
		my_data.registered_as_fleeing = true
		managers.groupai:state():register_fleeing_civilian(data.key, data.unit)
	end
	if data.objective and data.objective.stance then
		data.unit:movement():set_stance(data.objective.stance)
	end
	local attention_settings
	if is_cool then
		attention_settings = {
			"civ_all_peaceful"
		}
	elseif not managers.groupai:state():enemy_weapons_hot() then
		attention_settings = {
			"civ_enemy_cbt",
			"civ_civ_cbt"
		}
		my_data.enemy_weapons_hot_listen_id = "CivilianLogicTravel" .. tostring(data.key)
		managers.groupai:state():add_listener(my_data.enemy_weapons_hot_listen_id, {
			"enemy_weapons_hot"
		}, callback(CivilianLogicIdle, CivilianLogicIdle, "clbk_enemy_weapons_hot", data))
	end
	data.unit:brain():set_attention_settings(attention_settings)
end

function CivilianLogicTravel.exit(data, new_logic_name, enter_params)
	CopLogicBase.exit(data, new_logic_name, enter_params)
	local my_data = data.internal_data
	data.unit:brain():cancel_all_pathing_searches()
	CopLogicBase.cancel_delayed_clbks(my_data)
	CopLogicBase.cancel_queued_tasks(my_data)
	if my_data.registered_as_fleeing then
		managers.groupai:state():unregister_fleeing_civilian(data.key)
	end
	if my_data.enemy_weapons_hot_listen_id then
		managers.groupai:state():remove_listener(my_data.enemy_weapons_hot_listen_id)
	end
	if new_logic_name ~= "inactive" then
		data.unit:brain():set_update_enabled_state(true)
	end
end

function CivilianLogicTravel.update(data)
	local my_data = data.internal_data
	local unit = data.unit
	local objective = data.objective
	local t = data.t
	if my_data.processing_advance_path or my_data.processing_coarse_path then
		CivilianLogicEscort._upd_pathing(data, my_data)
	elseif my_data.advancing then
	elseif my_data.advance_path then
		CopLogicAttack._correct_path_start_pos(data, my_data.advance_path)
		local end_rot
		if my_data.coarse_path_index == #my_data.coarse_path - 1 then
			end_rot = objective and objective.rot
		end
		local haste = objective and objective.haste or "walk"
		local new_action_data = {
			type = "walk",
			nav_path = my_data.advance_path,
			variant = haste,
			body_part = 2,
			end_rot = end_rot
		}
		my_data.starting_advance_action = true
		my_data.advancing = data.unit:brain():action_request(new_action_data)
		my_data.starting_advance_action = false
		if my_data.advancing then
			my_data.advance_path = nil
			my_data.rsrv_pos.move_dest = my_data.rsrv_pos.path
			my_data.rsrv_pos.path = nil
			if my_data.rsrv_pos.stand then
				managers.navigation:unreserve_pos(my_data.rsrv_pos.stand)
				my_data.rsrv_pos.stand = nil
			end
		end
	elseif objective then
		if my_data.coarse_path then
			local coarse_path = my_data.coarse_path
			local cur_index = my_data.coarse_path_index
			local total_nav_points = #coarse_path
			if cur_index >= total_nav_points then
				objective.in_place = true
				if objective.type ~= "escort" and objective.type ~= "act" and not objective.action_duration then
					managers.groupai:state():on_civilian_objective_complete(unit, objective)
				else
					CivilianLogicTravel.on_new_objective(data)
				end
				return
			else
				my_data.rsrv_pos.path = nil
				local to_pos
				if objective.pos and cur_index == total_nav_points - 1 then
					to_pos = objective.pos
				else
					to_pos = coarse_path[cur_index + 1][2]
				end
				my_data.advance_path_search_id = tostring(unit:key()) .. "advance"
				my_data.processing_advance_path = true
				unit:brain():search_for_path(my_data.advance_path_search_id, to_pos)
			end
		else
			local search_id = tostring(unit:key()) .. "coarse"
			if unit:brain():search_for_coarse_path(search_id, objective.nav_seg) then
				my_data.coarse_path_search_id = search_id
				my_data.processing_coarse_path = true
			end
		end
	else
		CopLogicBase._exit(data.unit, "idle")
	end
end

function CivilianLogicTravel.on_intimidated(data, amount, aggressor_unit)
	if not CivilianLogicIdle.is_obstructed(data, aggressor_unit) then
		return
	end
	local new_objective = {
		type = "surrender",
		amount = amount,
		aggressor_unit = aggressor_unit
	}
	local anim_data = data.unit:anim_data()
	if anim_data.run then
		new_objective.initial_act = "halt"
	end
	data.unit:sound():say("a02x_any", true)
	data.unit:brain():set_objective(new_objective)
end
