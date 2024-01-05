TeamAILogicInactive = class(TeamAILogicBase)

function TeamAILogicInactive.enter(data, new_logic_name, enter_params)
	TeamAILogicBase.enter(data, new_logic_name, enter_params)
	local my_data = data.internal_data
	if my_data then
		local rsrv_pos = my_data.rsrv_pos
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
	end
	CopLogicBase._set_attention_obj(data, nil, nil)
	CopLogicBase._destroy_all_detected_attention_object_data(data)
	CopLogicBase._reset_attention(data)
	data.internal_data = {}
	data.unit:brain():set_update_enabled_state(false)
	if data.objective then
		managers.groupai:state():on_criminal_objective_failed(data.unit, data.objective, true)
		data.unit:brain():set_objective(nil)
	end
end

function TeamAILogicInactive.is_available_for_assignment(data)
	return false
end
