UnitNetworkHandler = UnitNetworkHandler or class(BaseNetworkHandler)

function UnitNetworkHandler:set_unit(unit, character_name, outfit_string, peer_id)
	print("[UnitNetworkHandler:set_unit]", unit, character_name, peer_id)
	Application:stack_dump()
	if not alive(unit) then
		return
	end
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if peer_id == 0 then
		local crim_data = managers.criminals:character_data_by_name(character_name)
		if not crim_data or not crim_data.ai then
			managers.criminals:add_character(character_name, unit, peer_id, true)
		else
			managers.criminals:set_unit(character_name, unit)
		end
		unit:movement():set_character_anim_variables()
		return
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return
	end
	peer:set_outfit_string(outfit_string)
	local member = managers.network:game():member_peer(peer)
	if member then
		member:set_unit(unit, character_name)
	elseif unit then
		if unit:base() and unit:base().set_slot then
			unit:base():set_slot(unit, 0)
		else
			unit:set_slot(0)
		end
	end
	self:_chk_flush_unit_too_early_packets(unit)
end

function UnitNetworkHandler:set_equipped_weapon(unit, item_index, blueprint_string, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:inventory():synch_equipped_weapon(item_index, blueprint_string)
end

function UnitNetworkHandler:set_weapon_gadget_state(unit, gadget_state, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:inventory():synch_weapon_gadget_state(gadget_state)
end

function UnitNetworkHandler:set_look_dir(unit, dir, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_look_dir(dir)
end

function UnitNetworkHandler:action_walk_start(unit, first_nav_point, nav_link_yaw, nav_link_act_index, from_idle, haste_code, end_yaw, no_walk, no_strafe)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local end_rot
	if end_yaw ~= 0 then
		end_rot = Rotation(360 * (end_yaw - 1) / 254, 0, 0)
	end
	local nav_path = {
		unit:position()
	}
	if nav_link_act_index ~= 0 then
		local nav_link_rot = Rotation(360 * nav_link_yaw / 255, 0, 0)
		local nav_link = unit:movement()._actions.walk.synthesize_nav_link(first_nav_point, nav_link_rot, unit:movement()._actions.act:_get_act_name_from_index(nav_link_act_index), from_idle)
		
		function nav_link.element.value(element, name)
			return element[name]
		end
		
		function nav_link.element.nav_link_wants_align_pos(element)
			return element.from_idle
		end
		
		table.insert(nav_path, nav_link)
	else
		table.insert(nav_path, first_nav_point)
	end
	local action_desc = {
		type = "walk",
		variant = haste_code == 1 and "walk" or "run",
		end_rot = end_rot,
		body_part = 2,
		nav_path = nav_path,
		path_simplified = true,
		persistent = true,
		no_walk = no_walk,
		no_strafe = no_strafe,
		blocks = {
			walk = -1,
			turn = -1,
			act = -1,
			idle = -1
		}
	}
	unit:movement():action_request(action_desc)
end

function UnitNetworkHandler:action_walk_nav_point(unit, nav_point, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_walk_nav_point(nav_point)
end

function UnitNetworkHandler:action_walk_stop(unit, pos)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_walk_stop(pos)
end

function UnitNetworkHandler:action_walk_nav_link(unit, pos, yaw, anim_index, from_idle)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local rot = Rotation(360 * yaw / 255, 0, 0)
	unit:movement():sync_action_walk_nav_link(pos, rot, anim_index, from_idle)
end

function UnitNetworkHandler:action_spooc_start(unit)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local action_desc = {
		type = "spooc",
		body_part = 1,
		block_type = "walk",
		nav_path = {
			unit:position()
		},
		path_index = 1,
		blocks = {
			walk = -1,
			turn = -1,
			act = -1,
			idle = -1
		}
	}
	unit:movement():action_request(action_desc)
end

function UnitNetworkHandler:action_spooc_stop(unit, pos, nav_index)
	if not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_spooc_stop(pos, nav_index)
end

function UnitNetworkHandler:action_spooc_nav_point(unit, pos, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_spooc_nav_point(pos)
end

function UnitNetworkHandler:action_spooc_strike(unit, pos, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:movement():sync_action_spooc_strike(pos)
end

function UnitNetworkHandler:friendly_fire_hit(subject_unit)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	subject_unit:character_damage():friendly_fire_hit()
end

function UnitNetworkHandler:damage_bullet(subject_unit, attacker_unit, damage, i_body, height_offset, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_bullet(attacker_unit, damage, i_body, height_offset, death)
end

function UnitNetworkHandler:damage_explosion(subject_unit, attacker_unit, damage, i_attack_variant, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_explosion(attacker_unit, damage, i_attack_variant, death)
end

function UnitNetworkHandler:damage_melee(subject_unit, attacker_unit, damage, damage_effect, i_body, height_offset, variant, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_melee(attacker_unit, damage, damage_effect, i_body, height_offset, variant, death)
end

function UnitNetworkHandler:from_server_damage_bullet(subject_unit, attacker_unit, hit_offset_height, result_index, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_bullet(attacker_unit, hit_offset_height, result_index)
end

function UnitNetworkHandler:from_server_damage_explosion(subject_unit, attacker_unit, result_index, i_attack_variant, sender)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_explosion(attacker_unit, result_index, i_attack_variant)
end

function UnitNetworkHandler:from_server_damage_melee(subject_unit, attacker_unit, hit_offset_height, result_index, sender)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end
	subject_unit:character_damage():sync_damage_melee(attacker_unit, attacker_unit, hit_offset_height, result_index)
end

function UnitNetworkHandler:from_server_damage_incapacitated(subject_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_damage_incapacitated()
end

function UnitNetworkHandler:from_server_damage_bleeding(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_damage_bleeding()
end

function UnitNetworkHandler:from_server_damage_tase(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_damage_tase()
end

function UnitNetworkHandler:from_server_unit_recovered(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end
	subject_unit:character_damage():sync_unit_recovered()
end

function UnitNetworkHandler:shot_blank(shooting_unit, impact, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end
	shooting_unit:movement():sync_shot_blank(impact)
end

function UnitNetworkHandler:reload_weapon(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_reload_weapon()
end

function UnitNetworkHandler:run_mission_element(id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		if self._verify_gamestate(self._gamestate_filter.any_end_game) then
			managers.mission:client_run_mission_element_end_screen(id, unit)
		end
		return
	end
	managers.mission:client_run_mission_element(id, unit)
end

function UnitNetworkHandler:run_mission_element_no_instigator(id)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		if self._verify_gamestate(self._gamestate_filter.any_end_game) then
			managers.mission:client_run_mission_element_end_screen(id)
		end
		return
	end
	managers.mission:client_run_mission_element(id)
end

function UnitNetworkHandler:to_server_mission_element_trigger(id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:server_run_mission_element_trigger(id, unit)
end

function UnitNetworkHandler:to_server_enter_area(id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:server_enter_area(id, unit)
end

function UnitNetworkHandler:to_server_exit_area(id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:server_exit_area(id, unit)
end

function UnitNetworkHandler:to_server_access_camera_trigger(id, trigger, instigator)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.mission:to_server_access_camera_trigger(id, trigger, instigator)
end

function UnitNetworkHandler:sync_body_damage_bullet(body, attacker, normal, position, direction, damage)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_bullet then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage damage_bullet function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_bullet(attacker, normal, position, direction, 1)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage)
end

function UnitNetworkHandler:sync_body_damage_bullet_no_attacker(body, normal, position, direction, damage)
	self:sync_body_damage_bullet(body, nil, normal, position, direction, damage)
end

function UnitNetworkHandler:sync_body_damage_lock(body, damage)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_lock then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage damage_lock function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_lock(nil, nil, nil, nil, damage)
end

function UnitNetworkHandler:sync_body_damage_explosion(body, attacker, normal, position, direction, damage)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_explosion then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no damage damage_explosion function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_explosion(attacker, normal, position, direction, damage)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage)
end

function UnitNetworkHandler:sync_body_damage_explosion_no_attacker(body, normal, position, direction, damage)
	self:sync_body_damage_explosion(body, nil, normal, position, direction, damage)
end

function UnitNetworkHandler:sync_body_damage_melee(body, attacker, normal, position, direction, damage)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(body) then
		return
	end
	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no damage extension", body:name(), body:unit():name())
		return
	end
	if not body:extension().damage.damage_melee then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no damage damage_melee function", body:name(), body:unit():name())
		return
	end
	body:extension().damage:damage_melee(attacker, normal, position, direction, damage)
end

function UnitNetworkHandler:sync_interacted(unit, unit_id, tweak_setting, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local peer = self._verify_sender(sender)
	if not peer then
		return
	end
	if Network:is_server() and unit_id ~= -2 then
		if alive(unit) and unit:interaction().tweak_data == tweak_setting and unit:interaction():active() then
			sender:sync_interaction_reply(true)
		else
			sender:sync_interaction_reply(false)
			return
		end
	end
	if alive(unit) then
		unit:interaction():sync_interacted(peer)
	end
end

function UnitNetworkHandler:sync_interacted_by_id(unit_id, tweak_setting, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) and not self._verify_sender(sender) then
		return
	end
	local u_data = managers.enemy:get_corpse_unit_data_from_id(unit_id)
	if not u_data then
		return
	end
	self:sync_interacted(u_data.unit, unit_id, tweak_setting, sender)
end

function UnitNetworkHandler:sync_interaction_reply(status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if not alive(managers.player:player_unit()) then
		return
	end
	managers.player:from_server_interaction_reply(status)
end

function UnitNetworkHandler:sync_interaction_set_active(unit, active, tweak_data, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:interaction():set_tweak_data(tweak_data)
	unit:interaction():set_active(active)
end

function UnitNetworkHandler:sync_interaction_set_active_by_id(u_id, active, tweak_data, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local u_data = managers.enemy:get_corpse_unit_data_from_id(u_id)
	if not u_data then
		debug_pause("no unit!")
		return
	end
	self:sync_interaction_set_active(u_data.unit, active, tweak_data, sender)
end

function UnitNetworkHandler:sync_teammate_progress(type_index, enabled, tweak_data_id, timer, success, sender)
	local sender_peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end
	local peer_id = sender_peer:id()
	managers.hud:teammate_progress(peer_id, type_index, enabled, tweak_data_id, timer, success)
end

function UnitNetworkHandler:action_aim_start(cop)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
		return
	end
	local shoot_action = {
		type = "shoot",
		body_part = 3,
		block_type = "action"
	}
	cop:movement():action_request(shoot_action)
end

function UnitNetworkHandler:action_aim_end(cop)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
		return
	end
	cop:movement():sync_action_aim_end()
end

function UnitNetworkHandler:action_hurt_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_hurt_end()
end

function UnitNetworkHandler:set_attention(unit, target_unit, reaction, sender)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_character(unit)) or not alive(target_unit) then
		return
	end
	local handler
	if target_unit:attention() then
		handler = target_unit:attention()
	elseif target_unit:brain() and target_unit:brain().attention_handler then
		handler = target_unit:brain():attention_handler()
	elseif target_unit:movement() and target_unit:movement().attention_handler then
		handler = target_unit:movement():attention_handler()
	elseif target_unit:base() and target_unit:base().attention_handler then
		handler = target_unit:base():attention_handler()
	end
	if not handler and (not target_unit:movement() or not target_unit:movement().m_head_pos) then
		debug_pause_unit(target_unit, "[UnitNetworkHandler:set_attention] no attention handler or m_head_pos", target_unit)
		return
	end
	unit:movement():synch_attention({
		unit = target_unit,
		u_key = target_unit:key(),
		handler = handler,
		reaction = reaction
	})
end

function UnitNetworkHandler:cop_set_attention_unit(unit, target_unit)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_character(unit)) or not self._verify_character(target_unit) then
		return
	end
	unit:movement():synch_attention({unit = target_unit})
end

function UnitNetworkHandler:cop_set_attention_pos(unit, pos)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():synch_attention({pos = pos})
end

function UnitNetworkHandler:cop_reset_attention(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():synch_attention()
end

function UnitNetworkHandler:cop_allow_fire(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():synch_allow_fire(true)
end

function UnitNetworkHandler:cop_forbid_fire(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():synch_allow_fire(false)
end

function UnitNetworkHandler:set_stance(unit, stance_code, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_stance(stance_code)
end

function UnitNetworkHandler:set_pose(unit, pose_code, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_pose(pose_code)
end

function UnitNetworkHandler:long_dis_interaction(target_unit, amount, aggressor_unit)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_character(target_unit)) or not self._verify_character(aggressor_unit) then
		return
	end
	local target_is_criminal = target_unit:in_slot(managers.slot:get_mask("criminals")) or target_unit:in_slot(managers.slot:get_mask("harmless_criminals"))
	local target_is_civilian = not target_is_criminal and target_unit:in_slot(21)
	local aggressor_is_criminal = aggressor_unit:in_slot(managers.slot:get_mask("criminals")) or aggressor_unit:in_slot(managers.slot:get_mask("harmless_criminals"))
	if target_is_criminal then
		if aggressor_is_criminal then
			managers.game_play_central:flash_contour(aggressor_unit)
			if target_unit:brain() then
				target_unit:movement():set_cool(false)
				target_unit:brain():on_long_dis_interacted(amount, aggressor_unit)
			elseif amount == 1 then
				target_unit:movement():on_morale_boost(aggressor_unit)
			end
		else
			target_unit:brain():on_intimidated(amount / 10, aggressor_unit)
		end
	elseif amount == 0 and target_is_civilian and aggressor_is_criminal then
		if self._verify_in_server_session() then
			aggressor_unit:movement():sync_call_civilian(target_unit)
		end
	else
		target_unit:brain():on_intimidated(amount / 10, aggressor_unit)
	end
end

function UnitNetworkHandler:alarm_pager_interaction(u_id, tweak_table, status, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local unit_data = managers.enemy:get_corpse_unit_data_from_id(u_id)
	if unit_data and unit_data.unit:interaction():active() and unit_data.unit:interaction().tweak_data == tweak_table then
		local peer = self._verify_sender(sender)
		if peer then
			local status_str
			if status == 1 then
				status_str = "started"
			elseif status == 2 then
				status_str = "interrupted"
			else
				status_str = "complete"
			end
			unit_data.unit:interaction():sync_interacted(peer, status_str)
		end
	end
end

function UnitNetworkHandler:set_corpse_material_config(u_id, original)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local unit_data = managers.enemy:get_corpse_unit_data_from_id(u_id)
	if not unit_data then
		return
	end
	unit_data.unit:base():set_material_state(original)
end

function UnitNetworkHandler:remove_corpse_by_id(u_id)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.enemy:remove_corpse_by_id(u_id)
end

function UnitNetworkHandler:unit_tied(unit, aggressor)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:brain():on_tied(aggressor)
end

function UnitNetworkHandler:unit_traded(unit, trader)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:brain():on_trade(trader)
end

function UnitNetworkHandler:hostage_trade(unit, enable, trade_success)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	CopLogicTrade.hostage_trade(unit, enable, trade_success)
end

function UnitNetworkHandler:set_unit_invulnerable(unit, enable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:character_damage():set_invulnerable(enable)
end

function UnitNetworkHandler:set_trade_countdown(enable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:set_trade_countdown(enable)
end

function UnitNetworkHandler:set_trade_death(criminal_name, respawn_penalty, hostages_killed)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed)
end

function UnitNetworkHandler:set_trade_spawn(criminal_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_set_trade_spawn(criminal_name)
end

function UnitNetworkHandler:set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.trade:sync_set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
end

function UnitNetworkHandler:action_idle_start(unit, body_part, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():action_request({type = "idle", body_part = body_part})
end

function UnitNetworkHandler:action_act_start(unit, act_index, blocks_hurt)
	self:action_act_start_align(unit, act_index, blocks_hurt, nil, nil)
end

function UnitNetworkHandler:action_act_start_align(unit, act_index, blocks_hurt, start_yaw, start_pos)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	local start_rot
	if start_yaw and start_yaw ~= 0 then
		start_rot = Rotation(360 * (start_yaw - 1) / 254, 0, 0)
	end
	unit:movement():sync_action_act_start(act_index, blocks_hurt, start_rot, start_pos)
end

function UnitNetworkHandler:action_act_end(unit)
	if not alive(unit) or unit:character_damage():dead() then
		return
	end
	unit:movement():sync_action_act_end()
end

function UnitNetworkHandler:action_dodge_start(unit, variation, side, rotation, speed)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_dodge_start(variation, side, rotation, speed)
end

function UnitNetworkHandler:action_dodge_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_dodge_end()
end

function UnitNetworkHandler:action_tase_start(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	local tase_action = {type = "tase", body_part = 3}
	unit:movement():action_request(tase_action)
end

function UnitNetworkHandler:action_tase_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():sync_action_tase_end()
end

function UnitNetworkHandler:action_tase_fire(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:movement():sync_taser_fire()
end

function UnitNetworkHandler:alert(alerted_unit, aggressor)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_character(alerted_unit)) or not self._verify_character(aggressor) then
		return
	end
	local record = managers.groupai:state():criminal_record(aggressor:key())
	if not record then
		return
	end
	local aggressor_pos
	if aggressor:movement() and aggressor:movement().m_head_pos then
		aggressor_pos = aggressor:movement():m_head_pos()
	else
		aggressor_pos = aggressor:position()
	end
	alerted_unit:brain():on_alert({
		"aggression",
		aggressor_pos,
		false,
		nil,
		aggressor
	})
end

function UnitNetworkHandler:revive_player(revive_health_level, sender)
	local peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.need_revive) or not peer then
		return
	end
	if 0 < revive_health_level then
		managers.player:player_unit():character_damage():set_revive_boost(revive_health_level)
	end
	managers.player:player_unit():character_damage():revive()
end

function UnitNetworkHandler:start_revive_player(timer, sender)
	if not self._verify_gamestate(self._gamestate_filter.downed) or not self._verify_sender(sender) then
		return
	end
	local player = managers.player:player_unit()
	player:character_damage():pause_downed_timer(timer)
end

function UnitNetworkHandler:interupt_revive_player(sender)
	if not self._verify_gamestate(self._gamestate_filter.downed) or not self._verify_sender(sender) then
		return
	end
	local player = managers.player:player_unit()
	player:character_damage():unpause_downed_timer()
end

function UnitNetworkHandler:start_free_player(sender)
	if not self._verify_gamestate(self._gamestate_filter.arrested) or not self._verify_sender(sender) then
		return
	end
	local player = managers.player:player_unit()
	player:character_damage():pause_arrested_timer()
end

function UnitNetworkHandler:interupt_free_player(sender)
	if not self._verify_gamestate(self._gamestate_filter.arrested) or not self._verify_sender(sender) then
		return
	end
	local player = managers.player:player_unit()
	player:character_damage():unpause_arrested_timer()
end

function UnitNetworkHandler:pause_arrested_timer(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:character_damage():pause_arrested_timer()
end

function UnitNetworkHandler:unpause_arrested_timer(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:character_damage():unpause_arrested_timer()
end

function UnitNetworkHandler:revive_unit(unit, reviving_unit)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_character(unit)) or not alive(reviving_unit) then
		return
	end
	unit:interaction():interact(reviving_unit)
end

function UnitNetworkHandler:pause_bleed_out(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:character_damage():pause_bleed_out()
end

function UnitNetworkHandler:unpause_bleed_out(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:character_damage():unpause_bleed_out()
end

function UnitNetworkHandler:interaction_set_waypoint_paused(unit, paused, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(unit) then
		return
	end
	if not unit:interaction() then
		return
	end
	unit:interaction():set_waypoint_paused(paused)
end

function UnitNetworkHandler:attach_device(pos, normal, sensor_upgrade, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) then
		return
	end
	local rot = Rotation(normal, math.UP)
	local peer = self._verify_sender(rpc)
	local unit = TripMineBase.spawn(pos, rot, sensor_upgrade)
	unit:base():set_server_information(peer:id())
	rpc:activate_trip_mine(unit)
end

function UnitNetworkHandler:activate_trip_mine(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if alive(unit) then
		unit:base():set_active(true, managers.player:player_unit())
	end
end

function UnitNetworkHandler:sync_trip_mine_setup(unit, sensor_upgrade)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:base():sync_setup(sensor_upgrade)
end

function UnitNetworkHandler:sync_trip_mine_explode(unit, user_unit, ray_from, ray_to, damage_size, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if not alive(user_unit) then
		user_unit = nil
	end
	if alive(unit) then
		unit:base():sync_trip_mine_explode(user_unit, ray_from, ray_to, damage_size, damage)
	end
end

function UnitNetworkHandler:sync_trip_mine_explode_no_user(unit, ray_from, ray_to, damage_size, damage, sender)
	self:sync_trip_mine_explode(unit, nil, ray_from, ray_to, damage_size, damage, sender)
end

function UnitNetworkHandler:sync_trip_mine_set_armed(unit, bool, length, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_trip_mine_set_armed(bool, length)
end

function UnitNetworkHandler:sync_trip_mine_beep_explode(unit, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_trip_mine_beep_explode()
end

function UnitNetworkHandler:sync_trip_mine_beep_sensor(unit, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_trip_mine_beep_sensor()
end

function UnitNetworkHandler:request_place_ecm_jammer(pos, normal, battery_life_upgrade_lvl, rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	local owner_unit = managers.network:game():member(peer:id()):unit()
	if not alive(owner_unit) or owner_unit:id() == -1 then
		rpc:from_server_ecm_jammer_place_rejected()
		return
	end
	local rot = Rotation(normal, math.UP)
	local peer = self._verify_sender(rpc)
	local unit = ECMJammerBase.spawn(pos, rot, battery_life_upgrade_lvl, owner_unit)
	unit:base():set_server_information(peer:id())
	unit:base():set_active(true)
	rpc:from_server_ecm_jammer_placed(unit)
end

function UnitNetworkHandler:from_server_ecm_jammer_placed(unit, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if alive(managers.player:player_unit()) then
		managers.player:player_unit():equipment():from_server_ecm_jammer_placement_result(true)
	end
	if not alive(unit) then
		return
	end
	unit:base():set_owner(managers.player:player_unit())
end

function UnitNetworkHandler:sync_unit_event_id_8(unit, ext_name, event_id, rpc)
	local peer = self._verify_sender(rpc)
	if not (peer and alive(unit)) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local extension = unit[ext_name](unit)
	if not extension then
		debug_pause("[UnitNetworkHandler:sync_unit_event_id_8] unit", unit, "does not have extension", ext_name)
		return
	end
	extension:sync_net_event(event_id)
end

function UnitNetworkHandler:from_server_ecm_jammer_rejected(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if alive(managers.player:player_unit()) then
		managers.player:player_unit():equipment():from_server_ecm_jammer_placement_result(false)
	end
end

function UnitNetworkHandler:m79grenade_explode_on_client(position, normal, user, damage, range, curve_pow, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(user, sender) then
		return
	end
	GrenadeBase._explode_on_client(position, normal, user, damage, range, curve_pow)
end

function UnitNetworkHandler:element_explode_on_client(position, normal, damage, range, curve_pow, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	GrenadeBase._client_damage_and_push(position, normal, nil, damage, range, curve_pow)
end

function UnitNetworkHandler:place_sentry_gun(pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, equipment_selection_index, user_unit, rpc)
	local peer = self._verify_sender(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end
	local unit = SentryGunBase.spawn(user_unit, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier)
	if unit then
		unit:base():set_server_information(peer:id())
	end
	if alive(user_unit) and user_unit:id() ~= -1 then
		managers.network:session():send_to_peers_synched("from_server_sentry_gun_place_result", peer:id(), unit and equipment_selection_index or 0, unit, unit:movement()._rot_speed_mul, unit:weapon()._setup.spread_mul, unit:base():has_shield() and true or false)
	end
end

function UnitNetworkHandler:from_server_sentry_gun_place_result(owner_peer_id, equipment_selection_index, sentry_gun_unit, rot_speed_mul, spread_mul, shield, rpc)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_sender(rpc) and alive(sentry_gun_unit)) or not managers.network:session():peer(owner_peer_id) then
		return
	end
	if owner_peer_id == managers.network:session():local_peer():id() and alive(Global.local_member:unit()) then
		managers.player:from_server_equipment_place_result(equipment_selection_index, Global.local_member:unit())
	end
	if shield then
		sentry_gun_unit:base():enable_shield()
	end
	sentry_gun_unit:movement():setup(rot_speed_mul)
	sentry_gun_unit:brain():setup(1 / rot_speed_mul)
	local setup_data = {spread_mul = spread_mul}
	sentry_gun_unit:weapon():setup(setup_data, 1)
end

function UnitNetworkHandler:place_ammo_bag(pos, rot, ammo_upgrade_lvl, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) then
		return
	end
	local peer = self._verify_sender(rpc)
	local unit = AmmoBagBase.spawn(pos, rot, ammo_upgrade_lvl)
	unit:base():set_server_information(peer:id())
end

function UnitNetworkHandler:sentrygun_ammo(unit, ammo_ratio)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:weapon():sync_ammo(ammo_ratio)
end

function UnitNetworkHandler:sentrygun_health(unit, health_ratio)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:character_damage():sync_health(health_ratio)
end

function UnitNetworkHandler:sync_ammo_bag_setup(unit, ammo_upgrade_lvl)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:base():sync_setup(ammo_upgrade_lvl)
end

function UnitNetworkHandler:sync_ammo_bag_ammo_taken(unit, amount, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_ammo_taken(amount)
end

function UnitNetworkHandler:place_doctor_bag(pos, rot, amount_upgrade_lvl, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) then
		return
	end
	local peer = self._verify_sender(rpc)
	local unit = DoctorBagBase.spawn(pos, rot, amount_upgrade_lvl)
	unit:base():set_server_information(peer:id())
end

function UnitNetworkHandler:sync_doctor_bag_setup(unit, amount_upgrade_lvl)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:base():sync_setup(amount_upgrade_lvl)
end

function UnitNetworkHandler:sync_doctor_bag_taken(unit, amount, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_taken(amount)
end

function UnitNetworkHandler:sync_money_wrap_money_taken(unit, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():sync_money_taken()
end

function UnitNetworkHandler:sync_pickup(unit)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:base():sync_pickup()
end

function UnitNetworkHandler:unit_sound_play(unit, event_id, source, sender)
	if not alive(unit) or not self._verify_sender(sender) then
		return
	end
	if source == "" then
		source = nil
	end
	unit:sound():play(event_id, source, false)
end

function UnitNetworkHandler:corpse_sound_play(unit_id, event_id, source)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local u_data = managers.enemy:get_corpse_unit_data_from_id(unit_id)
	if not u_data then
		return
	end
	if not u_data.unit then
		debug_pause("[UnitNetworkHandler:corpse_sound_play] u_data without unit", inspect(u_data))
		return
	end
	if not u_data.unit:sound() then
		return
	end
	u_data.unit:sound():play(event_id, source, false)
end

function UnitNetworkHandler:say(unit, event_id, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	if unit:in_slot(managers.slot:get_mask("all_criminals")) and not managers.groupai:state():is_enemy_converted_to_criminal(unit) then
		unit:sound():say(event_id, true, nil)
	else
		unit:sound():say(event_id, nil, true)
	end
end

function UnitNetworkHandler:sync_remove_one_teamAI(name, replace_with_player)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_remove_one_teamAI(name, replace_with_player)
end

function UnitNetworkHandler:sync_smoke_grenade(detonate_pos, shooter_pos, duration, flashbang)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_smoke_grenade(detonate_pos, shooter_pos, duration, flashbang)
end

function UnitNetworkHandler:sync_smoke_grenade_kill()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_smoke_grenade_kill()
end

function UnitNetworkHandler:sync_hostage_headcount(value)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_hostage_headcount(value)
end

function UnitNetworkHandler:play_distance_interact_redirect(unit, redirect, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:movement():play_redirect(redirect)
end

function UnitNetworkHandler:start_timer_gui(unit, timer, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:timer_gui():sync_start(timer)
end

function UnitNetworkHandler:set_jammed_timer_gui(unit, bool)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	unit:timer_gui():sync_set_jammed(bool)
end

function UnitNetworkHandler:give_equipment(equipment, amount, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:add_special({name = equipment, amount = amount})
end

function UnitNetworkHandler:killzone_set_unit(type)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.killzone:set_unit(managers.player:player_unit(), type)
end

function UnitNetworkHandler:dangerzone_set_level(level)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.player:player_unit():character_damage():set_danger_level(level)
end

function UnitNetworkHandler:sync_player_movement_state(unit, state, down_time, unit_id_str)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	self:_chk_unit_too_early(unit, unit_id_str, "sync_player_movement_state", 1, unit, state, down_time, unit_id_str)
	if not alive(unit) then
		return
	end
	if Global.local_member:unit() and unit:key() == Global.local_member:unit():key() then
		local valid_transitions = {
			standard = {
				bleed_out = true,
				arrested = true,
				tased = true,
				incapacitated = true,
				carry = true
			},
			carry = {
				bleed_out = true,
				arrested = true,
				tased = true,
				incapacitated = true,
				standard = true
			},
			mask_off = {
				standard = true,
				carry = true,
				arrested = true
			},
			bleed_out = {
				fatal = true,
				standard = true,
				carry = true
			},
			fatal = {standard = true, carry = true},
			arrested = {standard = true, carry = true},
			tased = {
				standard = true,
				carry = true,
				incapacitated = true
			},
			incapacitated = {standard = true, carry = true},
			clean = {
				mask_off = true,
				standard = true,
				carry = true,
				arrested = true
			}
		}
		if unit:movement():current_state_name() == state then
			return
		end
		if unit:movement():current_state_name() and valid_transitions[unit:movement():current_state_name()][state] then
			managers.player:set_player_state(state)
		else
			debug_pause_unit(unit, "[UnitNetworkHandler:sync_player_movement_state] received invalid transition", unit, unit:movement():current_state_name(), "->", state)
		end
	else
		unit:movement():sync_movement_state(state, down_time)
	end
end

function UnitNetworkHandler:sync_show_hint(id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.hint:sync_show_hint(id)
end

function UnitNetworkHandler:sync_show_action_message(unit, id, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	managers.action_messaging:sync_show_message(id, unit)
end

function UnitNetworkHandler:sync_waiting_for_player_start(variant)
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_players) then
		return
	end
	game_state_machine:current_state():sync_start(variant)
end

function UnitNetworkHandler:sync_waiting_for_player_skip()
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_players) then
		return
	end
	game_state_machine:current_state():sync_skip()
end

function UnitNetworkHandler:criminal_hurt(criminal_unit, attacker_unit, damage_ratio, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(criminal_unit, sender) then
		return
	end
	if not alive(attacker_unit) or criminal_unit:key() == attacker_unit:key() then
		attacker_unit = nil
	end
	managers.hud:set_mugshot_damage_taken(criminal_unit:unit_data().mugshot_id)
	managers.groupai:state():criminal_hurt_drama(criminal_unit, attacker_unit, damage_ratio * 0.01)
end

function UnitNetworkHandler:assign_secret_assignment(assignment)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.secret_assignment:assign(assignment)
end

function UnitNetworkHandler:complete_secret_assignment(assignment, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.secret_assignment:complete_secret_assignment(assignment)
end

function UnitNetworkHandler:failed_secret_assignment(assignment)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.secret_assignment:failed_secret_assignment(assignment)
end

function UnitNetworkHandler:secret_assignment_done(assignment, success)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.secret_assignment:secret_assignment_done(assignment, success)
end

function UnitNetworkHandler:arrested(unit)
	if not alive(unit) then
		return
	end
	unit:movement():sync_arrested()
end

function UnitNetworkHandler:suspect_uncovered(enemy_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local suspect_member = Global.local_member
	if not suspect_member then
		return
	end
	local suspect_unit = suspect_member:unit()
	if not suspect_unit then
		return
	end
	suspect_unit:movement():on_uncovered(enemy_unit)
end

function UnitNetworkHandler:add_synced_team_upgrade(category, upgrade, level, sender)
	local sender_peer = self._verify_sender(sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end
	local peer_id = sender_peer:id()
	managers.player:add_synced_team_upgrade(peer_id, category, upgrade, level)
end

function UnitNetworkHandler:sync_deployable_equipment(peer_id, deployable, amount, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_deployable_equipment(peer_id, deployable, amount)
end

function UnitNetworkHandler:sync_cable_ties(peer_id, amount, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_cable_ties(peer_id, amount)
end

function UnitNetworkHandler:sync_perk_equipment(peer_id, perk, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_perk(peer_id, perk)
end

function UnitNetworkHandler:sync_ammo_amount(peer_id, selection_index, max_clip, current_clip, current_left, max, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_ammo_info(peer_id, selection_index, max_clip, current_clip, current_left, max)
end

function UnitNetworkHandler:sync_carry(peer_id, carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_carry(peer_id, carry_id, value, dye_initiated, has_dye_pack, dye_value_multiplier)
end

function UnitNetworkHandler:sync_remove_carry(peer_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:remove_synced_carry(peer_id)
end

function UnitNetworkHandler:server_drop_carry(carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:server_drop_carry(carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level)
end

function UnitNetworkHandler:sync_carry_data(unit, carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	managers.player:sync_carry_data(unit, carry_id, carry_value, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level)
end

function UnitNetworkHandler:sync_bag_dye_pack_exploded(unit, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:carry_data():sync_dye_exploded()
end

function UnitNetworkHandler:server_secure_loot(carry_id, carry_value, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.loot:server_secure_loot(carry_id, carry_value)
end

function UnitNetworkHandler:sync_secure_loot(carry_id, carry_value, silent, sender)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) or self._verify_gamestate(self._gamestate_filter.any_end_game)) or not self._verify_sender(sender) then
		return
	end
	managers.loot:sync_secure_loot(carry_id, carry_value, silent)
end

function UnitNetworkHandler:sync_small_loot_taken(unit, multiplier_level, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():taken(multiplier_level)
end

function UnitNetworkHandler:server_unlock_asset(asset_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.assets:server_unlock_asset(asset_id)
end

function UnitNetworkHandler:sync_unlock_asset(asset_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.assets:sync_unlock_asset(asset_id)
end

function UnitNetworkHandler:sync_heist_time(time, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.game_play_central:sync_heist_time(time)
end

function UnitNetworkHandler:run_mission_door_sequence(unit, sequence_name, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:base():run_sequence_simple(sequence_name)
end

function UnitNetworkHandler:set_mission_door_device_powered(unit, powered, interaction_enabled, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	MissionDoor.set_mission_door_device_powered(unit, powered, interaction_enabled)
end

function UnitNetworkHandler:run_mission_door_device_sequence(unit, sequence_name, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	MissionDoor.run_mission_door_device_sequence(unit, sequence_name)
end

function UnitNetworkHandler:server_place_mission_door_device(unit, player, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	local result = unit:interaction():server_place_mission_door_device(player)
	sender:result_place_mission_door_device(unit, result)
end

function UnitNetworkHandler:result_place_mission_door_device(unit, result, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	unit:interaction():result_place_mission_door_device(result)
end

function UnitNetworkHandler:set_kit_selection(peer_id, category, id, slot, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.menu:get_menu("kit_menu").renderer:set_kit_selection(peer_id, category, id, slot)
end

function UnitNetworkHandler:set_armor(unit, percent, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_armor(character_data.panel_id, {
			current = percent / 100,
			total = 1,
			max = 1
		})
	else
		managers.hud:set_mugshot_armor(unit:unit_data().mugshot_id, percent / 100)
	end
end

function UnitNetworkHandler:set_health(unit, percent, sender)
	if not (alive(unit) and self._verify_gamestate(self._gamestate_filter.any_ingame)) or not self._verify_sender(sender) then
		return
	end
	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data and character_data.panel_id then
		managers.hud:set_teammate_health(character_data.panel_id, {
			current = percent / 100,
			total = 1,
			max = 1
		})
	else
		managers.hud:set_mugshot_health(unit:unit_data().mugshot_id, percent / 100)
	end
end

function UnitNetworkHandler:sync_equipment_possession(peer_id, equipment, amount, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.player:set_synced_equipment_possession(peer_id, equipment, amount)
end

function UnitNetworkHandler:sync_remove_equipment_possession(peer_id, equipment, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local equipment_peer = managers.network:session():peer(peer_id)
	if not equipment_peer then
		print("[UnitNetworkHandler:sync_remove_equipment_possession] unknown peer", peer_id)
		return
	end
	managers.player:remove_equipment_possession(peer_id, equipment)
end

function UnitNetworkHandler:sync_start_anticipation()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_start_anticipation()
end

function UnitNetworkHandler:sync_start_anticipation_music()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_start_anticipation_music()
end

function UnitNetworkHandler:sync_start_assault()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_start_assault()
end

function UnitNetworkHandler:sync_end_assault(result)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_end_assault(result)
end

function UnitNetworkHandler:sync_assault_dialog(index)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.hud:sync_assault_dialog(index)
end

function UnitNetworkHandler:set_contour(unit, state)
	if not alive(unit) then
		return
	end
	unit:base():set_contour(state)
end

function UnitNetworkHandler:mark_enemy(unit, marking_strength, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	managers.game_play_central:add_enemy_contour(unit, marking_strength)
end

function UnitNetworkHandler:mark_minion(unit, minion_owner_peer_id, convert_enemies_health_multiplier_level, passive_convert_enemies_health_multiplier_level, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	local health_multiplier = 1
	if 0 < convert_enemies_health_multiplier_level then
		health_multiplier = health_multiplier * tweak_data.upgrades.values.player.convert_enemies_health_multiplier[convert_enemies_health_multiplier_level]
	end
	if 0 < passive_convert_enemies_health_multiplier_level then
		health_multiplier = health_multiplier * tweak_data.upgrades.values.player.passive_convert_enemies_health_multiplier[passive_convert_enemies_health_multiplier_level]
	end
	unit:character_damage():convert_to_criminal(health_multiplier)
	managers.game_play_central:add_friendly_contour(unit)
	managers.groupai:state():sync_converted_enemy(unit)
	if minion_owner_peer_id == managers.network:session():local_peer():id() then
		managers.player:count_up_player_minions()
	end
end

function UnitNetworkHandler:count_down_player_minions()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.player:count_down_player_minions()
end

function UnitNetworkHandler:sync_teammate_helped_hint(hint, helped_unit, helping_unit, sender)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_character_and_sender(helped_unit, sender)) or not self._verify_character(helping_unit, sender) then
		return
	end
	managers.trade:sync_teammate_helped_hint(helped_unit, helping_unit, hint)
end

function UnitNetworkHandler:sync_assault_mode(enabled)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_assault_mode(enabled)
end

function UnitNetworkHandler:sync_hostage_killed_warning(warning)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_hostage_killed_warning(warning)
end

function UnitNetworkHandler:set_interaction_voice(unit, voice, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	unit:brain():set_interaction_voice(voice ~= "" and voice or nil)
end

function UnitNetworkHandler:award_achievment(achievment, sender)
	if not self._verify_sender(sender) then
		return
	end
	if not managers.statistics:is_dropin() then
		managers.challenges:set_flag(achievment)
	end
end

function UnitNetworkHandler:sync_teammate_comment(message, pos, pos_based, radius, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.groupai:state():sync_teammate_comment(message, pos, pos_based, radius)
end

function UnitNetworkHandler:sync_teammate_comment_instigator(unit, message)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.groupai:state():sync_teammate_comment_instigator(unit, message)
end

function UnitNetworkHandler:begin_gameover_fadeout()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():begin_gameover_fadeout()
end

function UnitNetworkHandler:send_statistics(peer_id, total_kills, total_specials_kills, total_head_shots, accuracy, downs)
	if not self._verify_gamestate(self._gamestate_filter.any_end_game) then
		return
	end
	managers.network:game():on_statistics_recieved(peer_id, total_kills, total_specials_kills, total_head_shots, accuracy, downs)
end

function UnitNetworkHandler:sync_statistics_result(...)
	if game_state_machine:current_state().on_statistics_result then
		game_state_machine:current_state():on_statistics_result(...)
	end
end

function UnitNetworkHandler:statistics_tied(name, sender)
	if not self._verify_sender(sender) then
		return
	end
	managers.statistics:tied({name = name})
end

function UnitNetworkHandler:bain_comment(bain_line, sender)
	if not self._verify_sender(sender) then
		return
	end
	if managers.dialog and managers.groupai and managers.groupai:state():bain_state() then
		managers.dialog:queue_dialog(bain_line, {})
	end
end

function UnitNetworkHandler:is_inside_point_of_no_return(is_inside, peer_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.groupai:state():set_is_inside_point_of_no_return(peer_id, is_inside)
end

function UnitNetworkHandler:mission_ended(win, num_is_inside, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	if managers.platform:presence() == "Playing" then
		if win then
			game_state_machine:change_state_by_name("victoryscreen", {
				num_winners = num_is_inside,
				personal_win = not managers.groupai:state()._failed_point_of_no_return and alive(managers.player:player_unit())
			})
		else
			game_state_machine:change_state_by_name("gameoverscreen")
		end
	end
end

function UnitNetworkHandler:sync_level_up(peer_id, level, sender)
	if not self._verify_sender(sender) then
		return
	end
	local peer = managers.network:session():peer(peer_id)
	if not peer then
		return
	end
	peer:set_level(level)
end

function UnitNetworkHandler:sync_set_outline(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	ElementSetOutline.sync_function(unit, state)
end

function UnitNetworkHandler:sync_disable_shout(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	ElementDisableShout.sync_function(unit, state)
end

function UnitNetworkHandler:sync_run_sequence_char(unit, seq, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	ElementSequenceCharacter.sync_function(unit, seq)
end

function UnitNetworkHandler:sync_player_kill_statistic(tweak_table_name, is_headshot, weapon_unit, variant, sender)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and self._verify_sender(sender)) or not alive(weapon_unit) then
		return
	end
	local data = {
		name = tweak_table_name,
		head_shot = is_headshot,
		weapon_unit = weapon_unit,
		variant = variant
	}
	managers.statistics:killed_by_anyone(data)
	local attacker_state = managers.player:current_state()
	data.attacker_state = attacker_state
	managers.statistics:killed(data)
end

function UnitNetworkHandler:set_attention_enabled(unit, setting_index, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end
	if unit:in_slot(managers.slot:get_mask("players")) and unit:base().is_husk_player then
		local setting_name = tweak_data.attention:get_attention_name(setting_index)
		unit:movement():set_attention_setting_enabled(setting_name, state, false)
	else
		debug_pause_unit(unit, "[UnitNetworkHandler:set_attention_enabled] invalid unit", unit)
	end
end

function UnitNetworkHandler:link_attention_no_rot(parent_unit, attention_object, parent_object, local_pos, sender)
	if not (self._verify_gamestate(self._gamestate_filter.any_ingame) and alive(parent_unit)) or not alive(attention_object) then
		return
	end
	attention_object:attention():link(parent_unit, parent_object, local_pos)
end

function UnitNetworkHandler:unlink_attention(attention_object, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(attention_object) then
		return
	end
	attention_object:attention():link(nil)
end

function UnitNetworkHandler:suspicion(suspect_peer_id, susp_value, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local suspect_member = managers.network:game():member(suspect_peer_id)
	if not suspect_member then
		return
	end
	local suspect_unit = suspect_member:unit()
	if not suspect_unit then
		return
	end
	if susp_value == 0 then
		susp_value = false
	elseif susp_value == 255 then
		susp_value = true
	else
		susp_value = susp_value / 254
	end
	suspect_unit:movement():on_suspicion(nil, susp_value)
end

function UnitNetworkHandler:suspicion_hud(observer_unit, status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(observer_unit) then
		return
	end
	if status == 0 then
		status = false
	elseif status == 1 then
		status = 1
	else
		status = true
	end
	managers.groupai:state():sync_suspicion_hud(observer_unit, status)
end

function UnitNetworkHandler:group_ai_event(event_id, blame_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	managers.groupai:state():sync_event(event_id, blame_id)
end

function UnitNetworkHandler:start_timespeed_effect(effect_id, timer_name, speed, fade_in, sustain, fade_out, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	local effect_desc = {
		timer = timer_name,
		speed = speed,
		fade_in = fade_in,
		sustain = sustain,
		fade_out = fade_out
	}
	managers.time_speed:play_effect(effect_id, effect_desc)
end

function UnitNetworkHandler:stop_timespeed_effect(effect_id, fade_out_duration, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end
	managers.time_speed:stop_effect(effect_id, fade_out_duration)
end

function UnitNetworkHandler:sync_upgrade(upgrade_category, upgrade_name, upgrade_level, sender)
	local peer = self._verify_sender(sender)
	if not peer then
		print("[UnitNetworkHandler:sync_upgrade] missing peer", upgrade_category, upgrade_name, upgrade_level, sender:ip_at_index(0))
		return
	end
	
	local function _get_unit()
		local unit = managers.network:game():member_peer(peer):unit()
		if not unit then
			print("[UnitNetworkHandler:sync_upgrade] missing unit", upgrade_category, upgrade_name, upgrade_level, sender:ip_at_index(0))
		end
		return unit
	end
	
	local unit = _get_unit()
	if not unit then
		return
	end
	unit:base():set_upgrade_value(upgrade_category, upgrade_name, upgrade_level)
end

function UnitNetworkHandler:suppression(unit, ratio, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	local sup_tweak = unit:base():char_tweak().suppression
	if not sup_tweak then
		debug_pause_unit(unit, "[UnitNetworkHandler:suppression] husk missing suppression settings", unit)
		return
	end
	local amount_max = (sup_tweak.brown_point or sup_tweak.react_point)[2]
	local amount = 0 < amount_max and amount_max * ratio / 255 or "max"
	unit:character_damage():build_suppression(amount)
end

function UnitNetworkHandler:suppressed_state(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end
	unit:movement():on_suppressed(state)
end

function UnitNetworkHandler:camera_yaw_pitch(cam_unit, yaw_255, pitch_255)
	if not alive(cam_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	local yaw = 360 * yaw_255 / 255 - 180
	local pitch = 180 * pitch_255 / 255 - 90
	cam_unit:base():apply_rotations(yaw, pitch)
end

function UnitNetworkHandler:loot_link(loot_unit, parent_unit, sender)
	if not (alive(loot_unit) and alive(parent_unit)) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end
	if loot_unit == parent_unit then
		loot_unit:carry_data():unlink()
	else
		loot_unit:carry_data():link_to(parent_unit)
	end
end

function UnitNetworkHandler:remove_unit(unit, sender)
	if not alive(unit) then
		return
	end
	if unit:id() ~= -1 then
		Network:detach_unit(unit)
	end
	unit:set_slot(0)
end
