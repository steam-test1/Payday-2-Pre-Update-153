local mvec3_set_z = mvector3.set_z
local mvec3_set = mvector3.set
local mvec3_sub = mvector3.subtract
local mvec3_norm = mvector3.normalize
local mvec3_add = mvector3.add
local tmp_vec1 = Vector3()
local ids_aim = Idstring("aim")
CopActionAct = CopActionAct or class()
CopActionAct._ACT_CATEGORY_INDEX = {
	"script",
	"enemy_spawn",
	"civilian_spawn",
	"SO"
}
CopActionAct._act_redirects = {}
CopActionAct._act_redirects.script = {
	"attached_collar_enter",
	"suppressed_reaction",
	"surprised",
	"hands_up",
	"hands_back",
	"tied",
	"drop",
	"panic",
	"idle",
	"halt",
	"stand",
	"crouch",
	"revive",
	"untie",
	"arrest",
	"arrest_call",
	"gesture_stop",
	"sabotage_device_low",
	"sabotage_device_mid",
	"sabotage_device_high",
	"so_civ_dummy_act_loop"
}
CopActionAct._act_redirects.enemy_spawn = {
	"e_sp_car_exit_to_cbt_front_l",
	"e_sp_car_exit_to_cbt_front_r",
	"e_sp_car_exit_to_cbt_front_l_var2",
	"e_sp_car_exit_to_cbt_front_r_var2",
	"e_sp_jump_down_heli_cbt_right",
	"e_sp_jump_down_heli_cbt_left",
	"e_sp_hurt_from_truck",
	"e_sp_aim_rifle_crh",
	"e_sp_aim_rifle_std",
	"e_sp_crh_to_std_rifle",
	"e_sp_down_12m",
	"e_sp_down_17m",
	"e_sp_up_1_down_9_25m",
	"e_sp_up_2_75_down_1_25m",
	"e_sp_up_1_down_9m",
	"e_sp_up_1_down_13m",
	"e_sp_down_8m",
	"e_sp_down_12m_var2",
	"e_sp_down_8m_var2",
	"e_sp_down_4m_var2",
	"e_sp_down_9_6m",
	"e_sp_repel_into_window",
	"e_sp_down_16m_right",
	"e_sp_down_16m_left",
	"e_sp_up_1_down_9m_var2"
}
CopActionAct._act_redirects.civilian_spawn = {
	"cm_sp_dj_loop",
	"cm_sp_stand_idle",
	"cm_sp_stand_waiting",
	"cm_sp_stand_arms_crossed",
	"cm_sp_sit_normal_table",
	"cm_sp_sit_legs_crossed",
	"cm_sp_male_stripper",
	"cm_sp_smoking_left1",
	"cm_sp_standing_talk1",
	"cm_sp_lean_desk_1_2m_01",
	"cm_sp_sit_table_var1_01",
	"cm_sp_sit_table_var2_01",
	"cm_sp_talking_upset",
	"cm_sp_drunk_idle",
	"cm_sp_lean_wall_right",
	"cm_sp_talking_normal",
	"cm_sp_waiting_sway",
	"cm_sp_bar_standing",
	"cm_sp_smoking_right1",
	"cm_sp_lean_wall1",
	"cm_sp_lean_wall_ass1",
	"cm_sp_phone1",
	"cm_sp_phone2",
	"cm_sp_stretch1",
	"cm_sp_sit_idle1",
	"cm_sp_sit_legs_crossed_var2",
	"cm_sp_standing_idle_var2",
	"cm_sp_look_look_semi_down",
	"cm_sp_look_window",
	"cm_sp_sit_feet_table",
	"cm_sp_listen_music_idle",
	"cm_sp_one_hand_on_hip",
	"cm_sp_hands_on_hip",
	"cm_sp_stand_type",
	"cm_sp_window_observer",
	"cm_sp_sit_high_chair",
	"cm_sp_sit_talk_table",
	"cf_sp_stand_idle_var1",
	"cf_sp_stand_desk_1m",
	"cf_sp_stand_desk_1m",
	"cf_sp_look_window_var1",
	"cf_sp_sitting_var1",
	"cf_sp_stand_look_up",
	"cf_sp_stand_look_down",
	"cf_sp_dance_slow",
	"cf_sp_dance_sexy",
	"cf_sp_sit_hands_on_table_talk",
	"cf_sp_sit_table_hands_in_knee",
	"cf_sp_sit_high_chair",
	"cf_sp_window_observer",
	"cf_sp_stand_type",
	"cf_sp_sms_phone_var1",
	"cf_sp_smoking_var1",
	"cf_sp_pole_dancer_expert",
	"cf_sp_pole_dancer_basic",
	"cf_sp_stand_hands_on_hip_idle",
	"cf_sp_stand_listen_music",
	"cf_sp_stand_one_hand_on_hip",
	"cf_sp_stand_talk_normal",
	"cf_sp_stand_talk_upset",
	"cf_sp_stand_talk_calm",
	"cf_sp_stand_arms crossed",
	"cf_sp_lean_bar_desk",
	"cf_sp_lean_wall_right",
	"cf_sp_lean_wall_back"
}
CopActionAct._act_redirects.SO = {
	"e_nl_plant_run_through",
	"e_nl_open_door",
	"e_nl_climb_over_2m",
	"e_nl_jump_over_1m_var1",
	"e_nl_jump_over_1m_var2",
	"e_nl_jump_down_2_5m",
	"e_nl_down_5_5m",
	"e_nl_down_4m",
	"e_nl_up_0_8_down_1_25m",
	"e_nl_kick_enter",
	"e_nl_kick_enter_special",
	"e_nl_up_1_75m",
	"e_nl_down_1_75m",
	"e_nl_up_5_down_1m",
	"e_nl_up_1_25_down_0_8m",
	"e_nl_down_4_fwd_4m",
	"e_nl_fwd_4m",
	"e_nl_fwd_2m",
	"e_nl_up_1_down_3m",
	"e_nl_up_1_down_5m",
	"e_nl_up_2_75m",
	"e_nl_down_2_75m",
	"e_nl_down_4_25m",
	"e_nl_down_5m",
	"e_nl_down_7m",
	"e_nl_up_4_6_down_0_6m",
	"e_nl_up_1_down_13m",
	"e_nl_up_1_down_9m",
	"e_nl_over_3_35m",
	"e_nl_down_2_7_fwd_2m",
	"e_nl_up_3_down_1m",
	"e_nl_up_6m",
	"e_nl_up_6m_var2",
	"e_nl_up_6m_var3",
	"e_nl_down_12m",
	"e_nl_down_8m",
	"e_nl_down_2m",
	"e_nl_down_1_25m",
	"e_nl_down_1_5m",
	"e_nl_up_1_5m",
	"e_nl_up_1_fwd_1_5m",
	"e_nl_up_1_fwd_1_5m_var2",
	"e_nl_slide_fwd_4m",
	"e_nl_up_2_2_down_1m",
	"e_nl_up_6_2_down_1m_var2",
	"e_nl_up_6_2_down_1m",
	"e_nl_up_7_down_1m",
	"e_nl_down_stairs_4m",
	"e_nl_press_button_enter",
	"e_so_ntl_idle_tired",
	"e_so_ntl_idle_kickpebble",
	"e_so_ntl_idle_look",
	"e_so_ntl_idle_look2",
	"e_so_ntl_idle_clock",
	"e_so_ntl_idle_brush",
	"e_so_ntl_idle_stickygum",
	"e_so_ntl_idle_backoff",
	"e_so_ntl_wave_camera",
	"e_so_ntl_smoke_stand",
	"e_so_ntl_leanwall",
	"e_so_ntl_talk_phone",
	"e_so_plant_c4_low",
	"e_so_ntl_look_up_wall",
	"e_so_alarm_under_table",
	"e_so_std_alarm",
	"e_so_ntl_look_corner",
	"e_so_ntl_look_ledge_down",
	"e_so_ntl_look_ledge_up",
	"e_so_ntl_look_under_table",
	"e_so_ntl_look_under_car",
	"e_so_sneak_wait_crh",
	"e_so_sneak_wait_stand",
	"e_so_pull_lever",
	"e_so_ntl_bouncer_idle",
	"e_so_ntl_bouncer_step_right",
	"e_so_investigate_truck",
	"e_so_investigate_truck_slope",
	"cmf_so_lean_r_wall",
	"cmf_so_lean_bar",
	"cmf_so_call_police",
	"cmf_so_panic",
	"cmf_so_surrender",
	"cmf_sp_debug_tpose",
	"cmf_so_answer_phone",
	"cmf_so_sit_in_chair",
	"cmf_so_look_windows",
	"cmf_so_stand_type",
	"cmf_so_window_observer",
	"cmf_so_sit_table_right",
	"cmf_so_sit_table_left",
	"cmf_so_sit_high_chair",
	"cmf_so_talk",
	"cmf_so_idle",
	"cmf_so_press_alarm_wall",
	"cmf_so_press_alarm_table"
}

function CopActionAct:init(action_desc, common_data)
	self._common_data = common_data
	self._action_desc = action_desc
	self._ext_base = common_data.ext_base
	self._ext_movement = common_data.ext_movement
	self._ext_anim = common_data.ext_anim
	self._unit = common_data.unit
	self._machine = common_data.machine
	self._host_expired = action_desc.host_expired
	self._skipped_frames = 0
	self._last_vel_z = 0
	self:_init_ik()
	self:_create_blocks_table(action_desc.blocks)
	if self._ext_anim.act_idle then
		self._blocks.walk = nil
	end
	if action_desc.needs_full_blend and self._ext_anim.idle and (not self._ext_anim.idle_full_blend or self._ext_anim.to_idle) then
		self._waiting_full_blend = true
		self:_set_updator("_upd_wait_for_full_blend")
	elseif not self:_play_anim() then
		return
	end
	self:_sync_anim_play()
	self._ext_movement:enable_update()
	if self._host_expired and not self._waiting_full_blend then
		self._expired = true
	end
	return true
end

function CopActionAct:on_exit()
	if self._changed_driving then
		self._unit:set_driving("script")
		self._changed_driving = nil
		self._ext_movement:set_m_rot(self._unit:rotation())
		self._ext_movement:set_m_pos(self._unit:position())
	end
	self._ext_movement:drop_held_items()
	if self._ext_anim.stop_talk_on_action_exit then
		self._unit:sound():stop()
	end
	if self._modifier_on then
		self._modifier_on = nil
		self._machine:forbid_modifier(self._modifier_name)
	end
	if self._expired then
		CopActionWalk._chk_correct_pose(self)
	end
	if Network:is_client() then
		self._ext_movement:set_m_host_stop_pos(self._ext_movement:m_pos())
	elseif not self._expired then
		self._common_data.ext_network:send("action_act_end")
	end
end

function CopActionAct:_init_ik()
	self._look_vec = mvector3.copy(self._common_data.fwd)
	self._ik_update = callback(self, self, "_ik_update_func")
	self._m_head_pos = self._ext_movement:m_head_pos()
	self:on_attention(self._common_data.attention)
end

function CopActionAct:_ik_update_func(t)
	self:_update_ik_type()
	if self._attention and self._ik_type then
		local look_from_pos = self._m_head_pos
		self._look_vec = self._look_vec or mvector3.copy(self._common_data.fwd)
		local target_vec = self._look_vec
		if self._attention.handler or self._attention.unit then
			mvec3_set(target_vec, self._m_attention_head_pos)
			mvec3_sub(target_vec, look_from_pos)
		else
			mvec3_set(target_vec, self._attention.pos)
			mvec3_sub(target_vec, look_from_pos)
		end
		mvec3_set(tmp_vec1, target_vec)
		mvec3_set_z(tmp_vec1, 0)
		mvec3_norm(tmp_vec1)
		local fwd_dot = mvector3.dot(self._common_data.fwd, tmp_vec1)
		if fwd_dot < 0.2 then
			if self._modifier_on then
				self._modifier_on = nil
				self._machine:forbid_modifier(self._modifier_name)
			end
		elseif not self._modifier_on then
			self._modifier_on = true
			self._machine:force_modifier(self._modifier_name)
			local old_look_vec = self._modifier_name == Idstring("look_head") and self._unit:get_object(Idstring("Head")):rotation():z() or self._unit:get_object(ids_aim):rotation():y()
			local duration = math.lerp(0.1, 1, target_vec:angle(old_look_vec) / 90)
			self._look_trans = {
				start_t = TimerManager:game():time(),
				duration = duration,
				start_vec = old_look_vec
			}
		end
		if self._look_trans then
			local look_trans = self._look_trans
			local prog = (t - look_trans.start_t) / look_trans.duration
			if 1 < prog then
				self._look_trans = nil
			else
				local end_vec
				if look_trans.end_vec then
					end_vec = look_trans.end_vec
				else
					end_vec = tmp_vec1
					mvec3_set(end_vec, target_vec)
					mvec3_norm(end_vec)
				end
				local prog_smooth = math.bezier({
					0,
					0,
					1,
					1
				}, prog)
				mvector3.lerp(target_vec, look_trans.start_vec, end_vec, prog_smooth)
			end
		end
		if self._modifier_on then
			self._modifier:set_target_z(target_vec)
		end
	elseif self._modifier_on then
		self._modifier_on = nil
		self._machine:forbid_modifier(self._modifier_name)
	end
end

function CopActionAct:on_attention(attention)
	self:_update_ik_type()
	self._m_attention_head_pos = attention and (not attention.handler or not attention.handler:get_attention_m_pos()) and attention.unit and attention.unit:movement():m_head_pos()
	self._attention = attention
	if self._modifier_on then
		self._modifier_on = nil
		self._machine:forbid_modifier(self._modifier_name)
	end
	self._ext_movement:enable_update()
end

function CopActionAct:_update_ik_type()
	local new_ik_type = self._ext_anim.ik_type
	if self._ik_type ~= new_ik_type then
		if self._modifier_on then
			self._machine:forbid_modifier(self._modifier_name)
			self._modifier_on = nil
		end
		if new_ik_type == "head" then
			self._ik_type = new_ik_type
			self._modifier_name = Idstring("look_head")
			self._modifier = self._machine:get_modifier(self._modifier_name)
		elseif new_ik_type == "upper_body" then
			self._ik_type = new_ik_type
			self._modifier_name = Idstring("look_upper_body")
			self._modifier = self._machine:get_modifier(self._modifier_name)
		else
			self._ik_type = nil
		end
	end
end

function CopActionAct:_upd_wait_for_full_blend()
	if not self._ext_anim.idle or self._ext_anim.idle_full_blend and not self._ext_anim.to_idle then
		self._waiting_full_blend = nil
		if not self:_play_anim() then
			if Network:is_server() then
				self._expired = true
				self._common_data.ext_network:send("action_act_end")
			end
			return
		end
		if self._host_expired then
			self._expired = true
		end
	end
end

function CopActionAct:_clamping_update(t)
	if self._ext_anim.act then
		local dt = TimerManager:game():delta_time()
		self._last_pos = CopActionHurt._get_pos_clamped_to_graph(self)
		CopActionWalk._set_new_pos(self, dt)
		local new_rot = self._unit:get_animation_delta_rotation()
		new_rot = self._common_data.rot * new_rot
		mrotation.set_yaw_pitch_roll(new_rot, new_rot:yaw(), 0, 0)
		self._ext_movement:set_rotation(new_rot)
	else
		self._expired = true
	end
	if self._ik_update then
		self._ik_update(t)
	end
end

function CopActionAct:update(t)
	local vis_state = self._ext_base:lod_stage()
	vis_state = vis_state or 4
	if vis_state == 1 or self._freefall then
	elseif vis_state > self._skipped_frames then
		self._skipped_frames = self._skipped_frames + 1
		return
	else
		self._skipped_frames = 1
	end
	if self._ik_update then
		self._ik_update(t)
	end
	if self._freefall then
		if self._ext_anim.freefall then
			local pos_new = tmp_vec1
			local delta_pos = self._unit:get_animation_delta_position()
			self._unit:m_position(pos_new)
			mvec3_add(pos_new, delta_pos)
			self._ext_movement:upd_ground_ray(pos_new, true)
			local gnd_z = self._common_data.gnd_ray.position.z
			if gnd_z < pos_new.z then
				self._last_vel_z = CopActionWalk._apply_freefall(pos_new, self._last_vel_z, gnd_z, TimerManager:game():delta_time())
			else
				if gnd_z > pos_new.z then
					mvec3_set_z(pos_new, gnd_z)
				end
				self._last_vel_z = 0
			end
			local new_rot = self._unit:get_animation_delta_rotation()
			new_rot = self._common_data.rot * new_rot
			mrotation.set_yaw_pitch_roll(new_rot, new_rot:yaw(), 0, 0)
			self._ext_movement:set_rotation(new_rot)
			self._ext_movement:set_position(pos_new)
		else
			self._freefall = nil
			self._last_vel_z = nil
			self._unit:set_driving("animation")
			self._changed_driving = true
		end
	else
		self._ext_movement:set_m_rot(self._unit:rotation())
		self._ext_movement:set_m_pos(self._unit:position())
	end
	if not self._ext_anim.act then
		self._expired = true
		CopActionWalk._chk_correct_pose(self)
	end
end

function CopActionAct:type()
	return "act"
end

function CopActionAct:expired()
	return self._expired
end

function CopActionAct:save(save_data)
	for k, v in pairs(self._action_desc) do
		save_data[k] = v
	end
	save_data.blocks = save_data.blocks or {
		act = -1,
		walk = -1,
		action = -1
	}
	save_data.start_anim_time = self._machine:segment_real_time(Idstring("base"))
	if save_data.variant then
		local state_name = self._machine:segment_state(Idstring("base"))
		local state_index = self._machine:state_name_to_index(state_name)
		save_data.variant = state_index
	end
end

function CopActionAct:need_upd()
	return self._attention or self._waiting_full_blend
end

function CopActionAct:chk_block(action_type, t)
	local unblock_t = self._blocks[action_type]
	return unblock_t and (unblock_t == -1 or t < unblock_t)
end

function CopActionAct:_create_blocks_table(block_desc)
	local blocks = self._blocks or {}
	if block_desc then
		local t = TimerManager:game():time()
		for action_type, block_duration in pairs(block_desc) do
			blocks[action_type] = block_duration == -1 and -1 or t + block_duration
		end
	end
	self._blocks = blocks
end

function CopActionAct:_get_act_index(anim_name)
	local cat_offset = 0
	for _, category_name in ipairs(self._ACT_CATEGORY_INDEX) do
		local category = self._act_redirects[category_name]
		for i_anim, test_anim_name in ipairs(category) do
			if test_anim_name == anim_name then
				return i_anim + cat_offset
			end
		end
		cat_offset = cat_offset + #category
	end
	debug_pause("[CopActionAct:_get_act_index] animation", anim_name, "not found on look-up table.")
	return 1
end

function CopActionAct:_get_act_name_from_index(index)
	for _, category_name in ipairs(self._ACT_CATEGORY_INDEX) do
		local category = self._act_redirects[category_name]
		if index <= #category then
			return category[index]
		end
		index = index - #category
	end
	debug_pause("[CopActionAct:_get_act_name_from_index] index", index, "is out of limits.")
end

function CopActionAct:_play_anim()
	local redir_name, redir_res
	if type(self._action_desc.variant) == "number" then
		redir_name = self._machine:index_to_state_name(self._action_desc.variant)
		redir_res = self._ext_movement:play_state_idstr(redir_name, self._action_desc.start_anim_time)
	else
		redir_name = self._action_desc.variant
		redir_res = self._ext_movement:play_redirect(redir_name, self._action_desc.start_anim_time)
	end
	if not redir_res then
		debug_pause_unit(self._unit, "[CopActionAct:_play_anim] redirect", redir_name, "failed in", self._machine:segment_state(Idstring("base")), self._unit)
		self._expired = true
		return
	end
	if Network:is_client() and self._action_desc.start_rot then
		self._ext_movement:set_rotation(self._action_desc.start_rot)
		self._ext_movement:set_position(self._action_desc.start_pos)
	end
	if self._action_desc.clamp_to_graph then
		self:_set_updator("_clamping_update")
	else
		if not self._ext_anim.freefall then
			self._unit:set_driving("animation")
			self._changed_driving = true
		end
		self:_set_updator()
	end
	if self._ext_anim.freefall then
		self._freefall = true
		self._last_vel_z = 0
	end
	self._ext_movement:set_root_blend(false)
	self._ext_movement:spawn_wanted_items()
	if self._ext_anim.ik_type then
		self:_update_ik_type()
	end
	return true
end

function CopActionAct:_sync_anim_play()
	if Network:is_server() then
		local action_index = self:_get_act_index(self._action_desc.variant)
		if action_index then
			if self._action_desc.align_sync then
				local yaw = mrotation.yaw(self._common_data.rot)
				if yaw < 0 then
					yaw = 360 + yaw
				end
				local sync_yaw = 1 + math.ceil(yaw * 254 / 360)
				self._common_data.ext_network:send("action_act_start_align", action_index, self._blocks.heavy_hurt and true or false, sync_yaw, mvector3.copy(self._common_data.pos))
			else
				self._common_data.ext_network:send("action_act_start", action_index, self._blocks.heavy_hurt and true or false)
			end
		else
			print("[CopActionAct:_sync_anim_play] redirect", self._action_desc.variant, "not found")
		end
	end
end

function CopActionAct:_set_updator(func_name)
	self.update = func_name and self[func_name] or nil
end

CopActionAct._apply_freefall = CopActionWalk._apply_freefall
