CopLogicTrade = class(CopLogicBase)
CopLogicTrade.butchers_traded = 0

function CopLogicTrade.enter(data, new_logic_name, enter_params)
	CopLogicBase.enter(data, new_logic_name, enter_params)
	data.unit:brain():cancel_all_pathing_searches()
	local old_internal_data = data.internal_data
	local my_data = {
		unit = data.unit
	}
	data.internal_data = my_data
	data.unit:movement():set_allow_fire(false)
	CopLogicBase._reset_attention(data)
	local skip_hint = enter_params and enter_params.skip_hint or false
	my_data._trade_enabled = true
	data.unit:network():send("hostage_trade", true, false, skip_hint)
	CopLogicTrade.hostage_trade(data.unit, true, false, skip_hint)
	data.unit:brain():set_update_enabled_state(true)
	data.unit:brain():set_attention_settings({peaceful = true})
end

function CopLogicTrade.hostage_trade(unit, enable, trade_success, skip_hint)
	local wp_id = "wp_hostage_trade"
	print("[CopLogicTrade.hostage_trade]", unit, enable, trade_success)
	if enable then
		local text = managers.localization:text("debug_trade_hostage")
		managers.hud:add_waypoint(wp_id, {
			text = text,
			icon = "wp_trade",
			position = unit:movement():m_pos(),
			distance = SystemInfo:platform() == Idstring("WIN32")
		})
		if managers.network:session() and not managers.trade:is_peer_in_custody(managers.network:session():local_peer():id()) and not skip_hint then
			managers.hint:show_hint("trade_offered")
		end
		if Network:is_server() and managers.enemy:all_civilians()[unit:key()] and unit:anim_data().stand and unit:brain():is_tied() then
			unit:brain():on_hostage_move_interaction(nil, "stay")
		end
		unit:character_damage():set_invulnerable(true)
		if Network:is_server() then
			unit:interaction():set_tweak_data("hostage_trade")
			unit:interaction():set_active(true, true)
		end
		if Network:is_server() and not unit:anim_data().hands_tied and not unit:anim_data().tied then
			local action_data
			if managers.enemy:all_civilians()[unit:key()] then
				if not unit:brain():is_tied() then
					action_data = {
						type = "act",
						body_part = 1,
						variant = "tied",
						clamp_to_graph = true,
						blocks = {
							light_hurt = -1,
							hurt = -1,
							heavy_hurt = -1,
							walk = -1
						}
					}
				end
			else
				action_data = {
					type = "act",
					body_part = 1,
					variant = "tied_all_in_one",
					clamp_to_graph = true,
					blocks = {
						light_hurt = -1,
						hurt = -1,
						heavy_hurt = -1,
						walk = -1
					}
				}
			end
			if action_data then
				unit:brain():action_request(action_data)
			end
		end
	else
		managers.hud:remove_waypoint(wp_id)
		if trade_success then
			unit:interaction():set_active(false, false)
		else
			unit:interaction():set_active(false, false)
			if managers.enemy:all_civilians()[unit:key()] then
				unit:interaction():set_tweak_data("hostage_move")
			else
				unit:interaction():set_tweak_data("intimidate")
			end
			unit:interaction():set_active(false, false)
		end
	end
end

function CopLogicTrade.exit(data, new_logic_name, enter_params)
	CopLogicBase.exit(data, new_logic_name, enter_params)
	local my_data = data.internal_data
	if my_data._trade_enabled then
		my_data._trade_enabled = false
		data.unit:network():send("hostage_trade", false, false, false)
		CopLogicTrade.hostage_trade(data.unit, false, false)
	end
	data.unit:character_damage():set_invulnerable(false)
	data.unit:network():send("set_unit_invulnerable", false)
end

function CopLogicTrade.on_trade(data, pos, rotation, free_criminal)
	if not data.internal_data._trade_enabled then
		return
	end
	if free_criminal then
		managers.trade:on_hostage_traded(pos, rotation)
	end
	data.internal_data._trade_enabled = false
	data.unit:network():send("hostage_trade", false, true, false)
	CopLogicTrade.hostage_trade(data.unit, false, true)
	managers.groupai:state():on_hostage_state(false, data.key, managers.enemy:all_enemies()[data.key] and true or false)
	if data.is_converted then
		managers.groupai:state():remove_minion(data.key, nil)
	end
	local flee_pos = managers.groupai:state():flee_point(data.unit:movement():nav_tracker():nav_segment())
	if flee_pos then
		data.internal_data.fleeing = true
		data.internal_data.flee_pos = flee_pos
		if data.unit:anim_data().hands_tied or data.unit:anim_data().tied then
			local new_action
			if data.unit:anim_data().stand and data.is_tied then
				new_action = {
					type = "act",
					variant = "panic",
					body_part = 1
				}
				data.is_tied = nil
				data.unit:movement():set_stance("hos")
			else
				new_action = {
					type = "act",
					variant = "stand",
					body_part = 1
				}
			end
			data.unit:brain():action_request(new_action)
		end
		data.unit:contour():add("hostage_trade", true, nil)
	else
		data.unit:set_slot(0)
	end
end

function CopLogicTrade.update(data)
	local my_data = data.internal_data
	CopLogicTrade._process_pathing_results(data, my_data)
	if my_data.pathing_to_flee_pos then
	elseif my_data.flee_path then
		if not data.unit:movement():chk_action_forbidden("walk") and data.unit:anim_data().idle_full_blend then
			data.unit:brain()._current_logic._chk_request_action_walk_to_flee_pos(data, my_data)
		end
	elseif my_data.flee_pos then
		local to_pos = my_data.flee_pos
		my_data.flee_pos = nil
		my_data.pathing_to_flee_pos = true
		my_data.flee_path_search_id = tostring(data.unit:key()) .. "flee"
		data.unit:brain():search_for_path(my_data.flee_path_search_id, to_pos)
	end
end

function CopLogicTrade._process_pathing_results(data, my_data)
	if data.pathing_results then
		local pathing_results = data.pathing_results
		data.pathing_results = nil
		local path = pathing_results[my_data.flee_path_search_id]
		if path then
			if path ~= "failed" then
				my_data.flee_path = path
			else
				data.unit:set_slot(0)
			end
			my_data.pathing_to_flee_pos = nil
			my_data.flee_path_search_id = nil
		end
	end
end

function CopLogicTrade._chk_request_action_walk_to_flee_pos(data, my_data, end_rot)
	local new_action_data = {}
	new_action_data.type = "walk"
	new_action_data.nav_path = my_data.flee_path
	new_action_data.variant = "run"
	new_action_data.body_part = 2
	my_data.flee_path = nil
	my_data.walking_to_flee_pos = data.unit:brain():action_request(new_action_data)
end

function CopLogicTrade.action_complete_clbk(data, action)
	local my_data = data.internal_data
	local action_type = action:type()
	if action_type == "walk" and my_data.walking_to_flee_pos then
		my_data.walking_to_flee_pos = nil
		data.unit:set_slot(0)
		managers.trade:trade_complete()
	end
end

function CopLogicTrade.can_activate()
	return false
end

function CopLogicTrade.is_available_for_assignment(data)
	return false
end

function CopLogicTrade._get_all_paths(data)
	return {
		flee_path = data.internal_data.flee_path
	}
end

function CopLogicTrade._set_verified_paths(data, verified_paths)
	data.internal_data.flee_path = verified_paths.flee_path
end

function CopLogicTrade.pre_destroy(data)
	managers.trade:change_hostage()
end
