PlayerDamage = PlayerDamage or class()
PlayerDamage._HEALTH_INIT = tweak_data.player.damage.HEALTH_INIT
PlayerDamage._ARMOR_INIT = tweak_data.player.damage.ARMOR_INIT
PlayerDamage._ARMOR_STEPS = tweak_data.player.damage.ARMOR_STEPS
PlayerDamage._ARMOR_DAMAGE_REDUCTION = tweak_data.player.damage.ARMOR_DAMAGE_REDUCTION
PlayerDamage._ARMOR_DAMAGE_REDUCTION_STEPS = tweak_data.player.damage.ARMOR_DAMAGE_REDUCTION_STEPS

function PlayerDamage:init(unit)
	self._unit = unit
	self._revives = Application:digest_value(0, true)
	self:replenish()
	self._bleed_out_health = Application:digest_value(tweak_data.player.damage.BLEED_OUT_HEALTH_INIT * managers.player:upgrade_value("player", "bleed_out_health_multiplier", 1), true)
	self._god_mode = Global.god_mode
	self._invulnerable = false
	self._gui = Overlay:newgui()
	self._ws = self._gui:create_screen_workspace()
	self._focus_delay_mul = 1
	self._listener_holder = EventListenerHolder:new()
	self._dmg_interval = tweak_data.player.damage.MIN_DAMAGE_INTERVAL
	self._next_allowed_dmg_t = Application:digest_value(-100, true)
	self._last_received_dmg = 0
	self._next_allowed_sup_t = -100
	self._last_received_sup = 0
	self._supperssion_data = {}
end

function PlayerDamage:post_init()
	self:_send_set_armor()
	self:_send_set_health()
end

function PlayerDamage:update(unit, t, dt)
	if self._regenerate_timer and not self._dead and not self._bleed_out then
		self._regenerate_timer = self._regenerate_timer - dt
		local top_fade = math.clamp(self._hurt_value - 0.8, 0, 1) / 0.2
		local hurt = self._hurt_value - (1 - top_fade) * ((1 + math.sin(t * 500)) / 2) / 10
		managers.environment_controller:set_hurt_value(hurt)
		if self._regenerate_timer < 0 then
			self:_regenerate_armor()
		end
	elseif self._hurt_value then
		if not self._bleed_out then
			self._hurt_value = math.min(1, self._hurt_value + dt)
			local top_fade = math.clamp(self._hurt_value - 0.8, 0, 1) / 0.2
			local hurt = self._hurt_value - (1 - top_fade) * ((1 + math.sin(t * 500)) / 2) / 10
			managers.environment_controller:set_hurt_value(hurt)
			local armor_value = math.max(self._armor_value or 0, self._hurt_value)
			managers.hud:set_player_armor({
				current = self:get_real_armor() * armor_value,
				total = self:_total_armor(),
				max = self:_max_armor()
			})
			SoundDevice:set_rtpc("shield_status", self._hurt_value * 100)
			if self._hurt_value >= 1 then
				self._hurt_value = nil
				managers.environment_controller:set_hurt_value(1)
			end
		else
			local hurt = self._hurt_value - (1 + math.sin(t * 500)) / 2 / 10
			managers.environment_controller:set_hurt_value(hurt)
		end
	end
	if self._tinnitus_data then
		self._tinnitus_data.intensity = (self._tinnitus_data.end_t - t) / self._tinnitus_data.duration
		if 0 >= self._tinnitus_data.intensity then
			self:_stop_tinnitus()
		else
			SoundDevice:set_rtpc("downed_state_progression", math.max(self._downed_progression or 0, self._tinnitus_data.intensity * 100))
		end
	end
	if not self._downed_timer and self._downed_progression then
		self._downed_progression = math.max(0, self._downed_progression - dt * 50)
		managers.environment_controller:set_downed_value(self._downed_progression)
		SoundDevice:set_rtpc("downed_state_progression", self._downed_progression)
		if self._downed_progression == 0 then
			self._unit:sound():play("critical_state_heart_stop")
			self._downed_progression = nil
		end
	end
	if self._auto_revive_timer then
		if not (not managers.platform:presence() ~= "Playing" and self._bleed_out) or self._dead or self:incapacitated() or self:arrested() then
			self._auto_revive_timer = nil
		else
			self._auto_revive_timer = self._auto_revive_timer - dt
			if 0 >= self._auto_revive_timer then
				self:revive(true)
				self._auto_revive_timer = nil
			end
		end
	end
	if self._revive_miss then
		self._revive_miss = self._revive_miss - dt
		if 0 >= self._revive_miss then
			self._revive_miss = nil
		end
	end
	self:_upd_suppression(t, dt)
	if not self._dead and not self._bleed_out then
		self:_upd_health_regen(t, dt)
	end
end

function PlayerDamage:recover_health()
	if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
		self:revive(true)
	end
	self:_regenerated(true)
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
end

function PlayerDamage:replenish()
	if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
		self:revive(true)
	end
	self:_regenerated()
	self:_regenerate_armor()
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	managers.hud:set_player_armor({
		current = self:get_real_armor(),
		total = self:_total_armor(),
		max = self:_max_armor()
	})
	SoundDevice:set_rtpc("shield_status", 100)
	SoundDevice:set_rtpc("downed_state_progression", 0)
end

function PlayerDamage:_regenerate_armor()
	if self._unit:sound() then
		self._unit:sound():play("shield_full_indicator")
	end
	self:set_armor(self:_max_armor())
	self._regenerate_timer = nil
	self:_send_set_armor()
end

function PlayerDamage:_regenerated(no_messiah)
	self:set_health(self:_max_health())
	self:_send_set_health()
	self:_set_health_effect()
	self._said_hurt = false
	self._revives = Application:digest_value(tweak_data.player.damage.LIVES_INIT + managers.player:upgrade_value("player", "additional_lives", 0), true)
	self._revive_health_i = 1
	managers.environment_controller:set_last_life(false)
	self._down_time = tweak_data.player.damage.DOWNED_TIME
	self._regenerate_timer = nil
	if not no_messiah then
		self._messiah_charges = managers.player:upgrade_value("player", "pistol_revive_from_bleed_out", 0)
	end
end

function PlayerDamage:consume_messiah_charge()
	if self:got_messiah_charges() then
		self._messiah_charges = self._messiah_charges - 1
		return true
	end
	return false
end

function PlayerDamage:got_messiah_charges()
	return self._messiah_charges and self._messiah_charges > 0
end

function PlayerDamage:get_real_health()
	return Application:digest_value(self._health, false)
end

function PlayerDamage:get_real_armor()
	return Application:digest_value(self._armor, false)
end

function PlayerDamage:change_health(change_of_health)
	self:set_health(self:get_real_health() + change_of_health)
end

function PlayerDamage:set_health(health)
	local max_health = self:_max_health()
	self._health = Application:digest_value(math.clamp(health, 0, max_health), true)
	self:_send_set_health()
	self:_set_health_effect()
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = max_health,
		revives = Application:digest_value(self._revives, false)
	})
end

function PlayerDamage:set_armor(armor)
	self._armor = Application:digest_value(math.clamp(armor, 0, self:_max_armor()), true)
end

function PlayerDamage:down_time()
	return self._down_time
end

function PlayerDamage:health_ratio()
	return self:get_real_health() / self:_max_health()
end

function PlayerDamage:_max_health()
	return (self._HEALTH_INIT + managers.player:thick_skin_value()) * managers.player:upgrade_value("player", "health_multiplier", 1) * managers.player:upgrade_value("player", "passive_health_multiplier", 1)
end

function PlayerDamage:_total_armor()
	return (self._ARMOR_INIT + managers.player:body_armor_value()) * managers.player:upgrade_value("player", "passive_armor_multiplier", 1) * managers.player:upgrade_value("player", "armor_multiplier", 1)
end

function PlayerDamage:_max_armor()
	return (self:_total_armor())
end

function PlayerDamage:_armor_steps()
	return self._ARMOR_STEPS
end

function PlayerDamage:_armor_damage_reduction()
	return 0
end

function PlayerDamage:full_health()
	return self:get_real_health() == self:_max_health()
end

function PlayerDamage:damage_tase(attack_data)
	if self._god_mode then
		return
	end
	local cur_state = self._unit:movement():current_state_name()
	if cur_state ~= "tased" and cur_state ~= "fatal" then
		self._tase_data = attack_data
		managers.player:set_player_state("tased")
		local damage_info = {
			result = {type = "hurt", variant = "tase"}
		}
		self:_call_listeners(damage_info)
	end
end

function PlayerDamage:tase_data()
	return self._tase_data
end

function PlayerDamage:erase_tase_data()
	self._tase_data = nil
end

function PlayerDamage:damage_melee(attack_data)
	self:damage_bullet(attack_data)
	self._unit:movement():push(attack_data.push_vel)
end

function PlayerDamage:_look_for_friendly_fire(unit)
	local players = managers.player:players()
	for _, player in ipairs(players) do
		if player == unit then
			return true
		end
	end
	local criminals = managers.groupai:state():all_criminals()
	if unit and criminals[unit:key()] then
		return true
	end
	return false
end

function PlayerDamage:play_whizby(position)
	self._unit:sound():play_whizby({position = position})
	self._unit:camera():play_shaker("whizby", 0.1)
	managers.rumble:play("bullet_whizby")
end

function PlayerDamage:damage_bullet(attack_data)
	local damage_info = {
		result = {type = "hurt", variant = "bullet"},
		attacker_unit = attack_data.attacker_unit
	}
	if managers.player:upgrade_value("player", "passive_dodge_chance", 0) >= math.rand(1) or self._unit:movement():running() and managers.player:upgrade_value("player", "run_dodge_chance", 0) >= math.rand(1) then
		if 0 < attack_data.damage then
			self:_send_damage_drama(attack_data, attack_data.damage)
		end
		self:_call_listeners(damage_info)
		self:_hit_direction(attack_data.col_ray)
		return
	end
	local dmg_mul = managers.player:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered", 1) * managers.player:upgrade_value("player", "damage_dampener", 1)
	if self._unit:movement()._current_state and self._unit:movement()._current_state:_interacting() then
		dmg_mul = dmg_mul * managers.player:upgrade_value("player", "interacting_damage_multiplier", 1)
	end
	attack_data.damage = attack_data.damage * dmg_mul
	if self._god_mode then
		if 0 < attack_data.damage then
			self:_send_damage_drama(attack_data, attack_data.damage)
		end
		self:_call_listeners(damage_info)
		return
	elseif self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	elseif PlayerDamage:_look_for_friendly_fire(attack_data.attacker_unit) then
		return
	elseif self:_chk_dmg_too_soon(attack_data.damage) then
		return
	elseif self._revive_miss and math.random() < self._revive_miss then
		self:play_whizby(attack_data.col_ray.position)
		return
	end
	if attack_data.attacker_unit:base()._tweak_table == "tank" then
		managers.achievment:set_script_data("dodge_this_fail", true)
	end
	if 0 < self:get_real_armor() then
		self._unit:sound():play("player_hit")
	else
		self._unit:sound():play("player_hit_permadamage")
	end
	local shake_multiplier = math.clamp(attack_data.damage, 0.2, 2) * managers.player:upgrade_value("player", "damage_shake_multiplier", 1)
	self._unit:camera():play_shaker("player_bullet_damage", 1 * shake_multiplier)
	managers.rumble:play("damage_bullet")
	self:_hit_direction(attack_data.col_ray)
	managers.player:check_damage_carry(attack_data)
	if self._bleed_out then
		self:_bleed_out_damage(attack_data)
		return
	end
	if not self:is_suppressed() then
		return
	end
	local armor_reduction_multiplier = 0
	if 0 >= self:get_real_armor() then
		armor_reduction_multiplier = 1
	end
	local health_subtracted = self:_calc_armor_damage(attack_data)
	attack_data.damage = attack_data.damage * armor_reduction_multiplier
	health_subtracted = health_subtracted + self:_calc_health_damage(attack_data)
	managers.player:activate_temporary_upgrade("temporary", "wolverine_health_regen")
	self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + self._dmg_interval, true)
	self._last_received_dmg = health_subtracted
	if not self._bleed_out and 0 < health_subtracted then
		self:_send_damage_drama(attack_data, health_subtracted)
	elseif self._bleed_out then
		managers.challenges:set_flag("bullet_to_bleed_out")
	end
	self:_call_listeners(damage_info)
end

function PlayerDamage:_calc_armor_damage(attack_data)
	local health_subtracted = 0
	if 0 < self:get_real_armor() then
		health_subtracted = self:get_real_armor()
		self:set_armor(self:get_real_armor() - attack_data.damage)
		health_subtracted = health_subtracted - self:get_real_armor()
		self:_damage_screen()
		managers.hud:set_player_armor({
			current = self:get_real_armor(),
			total = self:_total_armor(),
			max = self:_max_armor()
		})
		SoundDevice:set_rtpc("shield_status", self:get_real_armor() / self:_total_armor() * 100)
		self:_send_set_armor()
		if 0 >= self:get_real_armor() then
			self._unit:sound():play("player_armor_gone_stinger")
		end
	end
	return health_subtracted
end

function PlayerDamage:_calc_health_damage(attack_data)
	local health_subtracted = 0
	health_subtracted = self:get_real_health()
	self:change_health(-attack_data.damage)
	health_subtracted = health_subtracted - self:get_real_health()
	if self:get_real_health() == 0 and attack_data.variant and attack_data.variant == "bullet" and Application:digest_value(self._revives, false) > 1 and managers.player:has_category_upgrade("player", "cheat_death_chance") then
		local r = math.rand(1)
		if r <= managers.player:upgrade_value("player", "cheat_death_chance") then
			self._auto_revive_timer = 1
		end
	end
	self:_damage_screen()
	self:_check_bleed_out()
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	self:_send_set_health()
	self:_set_health_effect()
	managers.statistics:health_subtracted(health_subtracted)
	return health_subtracted
end

function PlayerDamage:_send_damage_drama(attack_data, health_subtracted)
	local dmg_percent = health_subtracted / self._HEALTH_INIT
	local attacker
	if not attacker or attack_data.attacker_unit:id() == -1 then
		attacker = self._unit
	end
	self._unit:network():send("criminal_hurt", attacker, math.clamp(math.ceil(dmg_percent * 100), 1, 100))
	if Network:is_server() then
		attacker = attack_data.attacker_unit
		if attacker and not attack_data.attacker_unit:movement() then
			attacker = nil
		end
		managers.groupai:state():criminal_hurt_drama(self._unit, attacker, dmg_percent)
	end
	if Network:is_client() then
		self._unit:network():send_to_host("damage_bullet", attacker, 1, 1, 1, false)
	end
end

function PlayerDamage:damage_killzone(attack_data)
	local damage_info = {
		result = {type = "hurt", variant = "killzone"}
	}
	if self._god_mode or self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	end
	self._unit:sound():play("player_hit")
	self:_hit_direction(attack_data.col_ray)
	if self._bleed_out then
		return
	end
	local armor_reduction_multiplier = 0
	if 0 >= self:get_real_armor() then
		armor_reduction_multiplier = 1
	end
	local health_subtracted = self:_calc_armor_damage(attack_data)
	attack_data.damage = attack_data.damage * armor_reduction_multiplier
	health_subtracted = health_subtracted + self:_calc_health_damage(attack_data)
	self:_call_listeners(damage_info)
end

function PlayerDamage:damage_fall(data)
	local damage_info = {
		result = {type = "hurt", variant = "fall"}
	}
	if self._god_mode or self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	end
	local height_limit = 300
	local death_limit = 631
	if height_limit > data.height then
		return
	end
	local die = death_limit < data.height
	self._unit:sound():play("player_hit")
	managers.environment_controller:hit_feedback_down()
	managers.hud:on_hit_direction("down")
	if self._bleed_out then
		return
	end
	local health_damage_multiplier = 0
	if die then
		self:set_health(0)
	else
		health_damage_multiplier = managers.player:upgrade_value("player", "fall_damage_multiplier", 1) * managers.player:upgrade_value("player", "fall_health_damage_multiplier", 1)
		self:change_health(-(tweak_data.player.fall_health_damage * health_damage_multiplier))
	end
	if die or 0 < health_damage_multiplier then
		local alert_rad = tweak_data.player.fall_damage_alert_size or 500
		local new_alert = {
			"vo_cbt",
			self._unit:movement():m_head_pos(),
			alert_rad,
			self._unit:movement():SO_access(),
			self._unit
		}
		managers.groupai:state():propagate_alert(new_alert)
	end
	local max_armor = self:_max_armor()
	if die then
		self:set_armor(0)
	else
		self:set_armor(self:get_real_armor() - max_armor * managers.player:upgrade_value("player", "fall_damage_multiplier", 1))
	end
	managers.hud:set_player_armor({
		current = self:get_real_armor(),
		total = self:_total_armor(),
		max = max_armor,
		no_hint = true
	})
	SoundDevice:set_rtpc("shield_status", 0)
	self:_send_set_armor()
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	self:_send_set_health()
	self:_set_health_effect()
	self:_damage_screen()
	self:_check_bleed_out()
	if die then
		managers.challenges:set_flag("fall_to_bleed_out")
	end
	self:_call_listeners(damage_info)
	return true
end

function PlayerDamage:damage_explosion(attack_data)
	local damage_info = {
		result = {type = "hurt", variant = "explosion"}
	}
	if self._god_mode or self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	end
	local distance = mvector3.distance(attack_data.position, self._unit:position())
	if distance > attack_data.range then
		return
	end
	local damage = (attack_data.damage or 1) * (1 - distance / attack_data.range)
	if self._bleed_out then
		return
	end
	attack_data.damage = damage
	local armor_subtracted = self:_calc_armor_damage(attack_data)
	attack_data.damage = attack_data.damage - (armor_subtracted or 0)
	local health_subtracted = self:_calc_health_damage(attack_data)
	self:_call_listeners(damage_info)
end

function PlayerDamage:update_downed(t, dt)
	if self._downed_timer and self._downed_paused_counter == 0 then
		self._downed_timer = self._downed_timer - dt
		if self._downed_start_time == 0 then
			self._downed_progression = 100
		else
			self._downed_progression = math.clamp(1 - self._downed_timer / self._downed_start_time, 0, 1) * 100
		end
		managers.environment_controller:set_downed_value(self._downed_progression)
		SoundDevice:set_rtpc("downed_state_progression", self._downed_progression)
		return self._downed_timer <= 0
	end
	return false
end

function PlayerDamage:_check_bleed_out()
	if self:get_real_health() == 0 then
		self._revives = Application:digest_value(Application:digest_value(self._revives, false) - 1, true)
		managers.environment_controller:set_last_life(Application:digest_value(self._revives, false) <= 1)
		if Application:digest_value(self._revives, false) == 0 then
			self._down_time = 0
		end
		self._bleed_out = true
		managers.player:set_player_state("bleed_out")
		self._critical_state_heart_loop_instance = self._unit:sound():play("critical_state_heart_loop")
		managers.environment_controller:set_downed_value(0)
		SoundDevice:set_rtpc("downed_state_progression", 0)
		self._slomo_sound_instance = self._unit:sound():play("downed_slomo_fx")
		self._bleed_out_health = Application:digest_value(tweak_data.player.damage.BLEED_OUT_HEALTH_INIT * managers.player:upgrade_value("player", "bleed_out_health_multiplier", 1), true)
		self._hurt_value = 0.2
		if managers.player:has_category_upgrade("temporary", "pistol_revive_from_bleed_out") then
			local upgrade_value = managers.player:upgrade_value("temporary", "pistol_revive_from_bleed_out")
			if upgrade_value == 0 then
			else
				local time = upgrade_value[2]
				managers.player:activate_temporary_upgrade("temporary", "pistol_revive_from_bleed_out")
			end
		end
		self:_drop_blood_sample()
		self:on_downed()
	elseif not self._said_hurt and 0.2 > self:get_real_health() / self:_max_health() then
		self._said_hurt = true
		PlayerStandard.say_line(self, "g80x_plu")
	end
end

function PlayerDamage:_drop_blood_sample()
	local remove = math.rand(1) < 0.5
	if not remove then
		return
	end
	local removed = false
	if managers.player:has_special_equipment("blood_sample") then
		removed = true
		managers.player:remove_special("blood_sample")
		managers.hint:show_hint("dropped_blood_sample")
	end
	if managers.player:has_special_equipment("blood_sample_verified") then
		removed = true
		managers.player:remove_special("blood_sample_verified")
		managers.hint:show_hint("dropped_blood_sample")
	end
	if removed then
		self._unit:sound():play("vial_break_2d")
		self._unit:sound():say("g29", false)
		if managers.groupai:state():bain_state() then
			managers.dialog:queue_dialog("hos_ban_139", {})
		end
		local splatter_from = self._unit:position() + math.UP * 5
		local splatter_to = self._unit:position() - math.UP * 45
		local splatter_ray = World:raycast("ray", splatter_from, splatter_to, "slot_mask", managers.game_play_central._slotmask_world_geometry)
		if splatter_ray then
			World:project_decal(Idstring("blood_spatter"), splatter_ray.position, splatter_ray.ray, splatter_ray.unit, nil, splatter_ray.normal)
		end
	end
end

function PlayerDamage:on_downed()
	self._downed_timer = self:down_time()
	self._downed_start_time = self._downed_timer
	self._downed_paused_counter = 0
	managers.hud:pd_start_timer({
		time = self._downed_timer
	})
	managers.hud:on_downed()
	self:_stop_tinnitus()
end

function PlayerDamage:pause_downed_timer(timer)
	self._downed_paused_counter = self._downed_paused_counter + 1
	if self._downed_paused_counter == 1 then
		managers.hud:pd_pause_timer()
		managers.hud:pd_start_progress(0, timer or tweak_data.interaction.revive.timer, "debug_interact_being_revived", "interaction_help")
	end
end

function PlayerDamage:unpause_downed_timer()
	self._downed_paused_counter = self._downed_paused_counter - 1
	if self._downed_paused_counter == 0 then
		managers.hud:pd_unpause_timer()
		managers.hud:pd_stop_progress()
	end
end

function PlayerDamage:update_arrested(t, dt)
	if self._arrested_timer and self._arrested_paused_counter == 0 then
		self._arrested_timer = self._arrested_timer - dt
		return not self:arrested()
	end
	return false
end

function PlayerDamage:on_freed()
	self._arrested_timer = nil
	self._arrested = nil
end

function PlayerDamage:on_arrested()
	self._bleed_out = false
	self._arrested_timer = tweak_data.player.damage.ARRESTED_TIME
	self._arrested_paused_counter = 0
	managers.hud:pd_start_timer({
		time = self._arrested_timer
	})
	managers.hud:on_arrested()
end

function PlayerDamage:pause_arrested_timer()
	if not self._arrested_timer or self._arrested_timer <= 0 then
		return
	end
	self._arrested_paused_counter = self._arrested_paused_counter + 1
	if self._arrested_paused_counter == 1 then
		managers.hud:pd_pause_timer()
		managers.hud:pd_start_progress(0, tweak_data.interaction.free.timer, "debug_interact_being_freed", "interaction_free")
	end
end

function PlayerDamage:unpause_arrested_timer()
	if not self._arrested_timer or self._arrested_timer <= 0 then
		return
	end
	self._arrested_paused_counter = self._arrested_paused_counter - 1
	if self._arrested_paused_counter == 0 then
		managers.hud:pd_unpause_timer()
		managers.hud:pd_stop_progress()
	end
end

function PlayerDamage:update_incapacitated(t, dt)
	return self:update_downed(t, dt)
end

function PlayerDamage:on_incapacitated()
	self:on_downed()
	self._incapacitated = true
end

function PlayerDamage:bleed_out()
	return self._bleed_out
end

function PlayerDamage:incapacitated()
	return self._incapacitated
end

function PlayerDamage:arrested()
	return self._arrested_timer or self._arrested
end

function PlayerDamage:_bleed_out_damage(attack_data)
	local health_subtracted = Application:digest_value(self._bleed_out_health, false)
	self._bleed_out_health = Application:digest_value(math.max(0, health_subtracted - attack_data.damage), true)
	health_subtracted = health_subtracted - Application:digest_value(self._bleed_out_health, false)
	self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + self._dmg_interval, true)
	self._last_received_dmg = health_subtracted
	if Application:digest_value(self._bleed_out_health, false) <= 0 then
		managers.player:set_player_state("fatal")
	end
	if 0 < health_subtracted then
		self:_send_damage_drama(attack_data, health_subtracted)
	end
end

function PlayerDamage:_hit_direction(col_ray)
	if col_ray then
		local dir = col_ray.ray
		local infront = math.dot(self._unit:camera():forward(), dir)
		if infront < -0.9 then
			managers.environment_controller:hit_feedback_front()
		elseif 0.9 < infront then
			managers.environment_controller:hit_feedback_back()
			managers.hud:on_hit_direction("right")
		else
			local polar = self._unit:camera():forward():to_polar_with_reference(-dir, Vector3(0, 0, 1))
			local direction = Vector3(polar.spin, polar.pitch, 0):normalized()
			if math.abs(direction.x) > math.abs(direction.y) then
				if 0 > direction.x then
					managers.environment_controller:hit_feedback_left()
					managers.hud:on_hit_direction("left")
				else
					managers.environment_controller:hit_feedback_right()
					managers.hud:on_hit_direction("right")
				end
			elseif 0 > direction.y then
				managers.environment_controller:hit_feedback_up()
				managers.hud:on_hit_direction("up")
			else
				managers.environment_controller:hit_feedback_down()
				managers.hud:on_hit_direction("down")
			end
		end
	else
	end
end

function PlayerDamage:_damage_screen()
	self:set_regenerate_timer_to_max()
	self._hurt_value = 1 - math.clamp(0.8 - math.pow(self:get_real_armor() / self:_max_armor(), 2), 0, 1)
	self._armor_value = math.clamp(self:get_real_armor() / self:_max_armor(), 0, 1)
	managers.environment_controller:set_hurt_value(self._hurt_value)
end

function PlayerDamage:set_revive_boost(revive_health_level)
	self._revive_health_multiplier = tweak_data.upgrades.revive_health_multiplier[revive_health_level]
	print("PlayerDamage:set_revive_boost", "revive_health_level", revive_health_level, "revive_health_multiplier", tostring(self._revive_health_multiplier))
end

function PlayerDamage:revive(helped_self)
	if Application:digest_value(self._revives, false) == 0 then
		self._revive_health_multiplier = nil
		return
	end
	local arrested = self:arrested()
	managers.player:set_player_state("standard")
	if not helped_self then
		PlayerStandard.say_line(self, "s05x_sin")
	end
	self._bleed_out = false
	self._incapacitated = nil
	self._downed_timer = nil
	self._downed_start_time = nil
	if not arrested then
		if true ~= helped_self then
			managers.challenges:count_up("revived")
		end
		self:set_health(self:_max_health() * tweak_data.player.damage.REVIVE_HEALTH_STEPS[self._revive_health_i] * (self._revive_health_multiplier or 1))
		self:set_armor(self:_total_armor())
		self._revive_health_i = math.min(#tweak_data.player.damage.REVIVE_HEALTH_STEPS, self._revive_health_i + 1)
		self._revive_miss = 2
	end
	self:_regenerate_armor()
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	self:_send_set_health()
	self:_set_health_effect()
	managers.hud:pd_stop_progress()
	self._revive_health_multiplier = nil
end

function PlayerDamage:need_revive()
	return self._bleed_out or self._incapacitated
end

function PlayerDamage:dead()
	return self._dead
end

function PlayerDamage:set_god_mode(state)
	Global.god_mode = state
	self._god_mode = state
	self:print("PlayerDamage god mode " .. (state and "ON" or "OFF"))
end

function PlayerDamage:god_mode()
	return self._god_mode
end

function PlayerDamage:print(...)
	cat_print("player_damage", ...)
end

function PlayerDamage:set_invulnerable(state)
	self._invulnerable = state
end

function PlayerDamage:set_danger_level(danger_level)
	self._danger_level = self._danger_level ~= danger_level and danger_level or nil
	self._focus_delay_mul = danger_level and tweak_data.danger_zones[self._danger_level] or 1
end

function PlayerDamage:focus_delay_mul()
	return self._focus_delay_mul
end

function PlayerDamage:shoot_pos_mid(m_pos)
	mvector3.set(m_pos, self._unit:movement():m_head_pos())
end

function PlayerDamage:set_regenerate_timer_to_max()
	self._regenerate_timer = tweak_data.player.damage.REGENERATE_TIME * managers.player:upgrade_value("player", "armor_regen_timer_multiplier", 1) * managers.player:team_upgrade_value("armor", "regen_time_multiplier", 1) * managers.player:team_upgrade_value("armor", "passive_regen_time_multiplier", 1)
end

function PlayerDamage:_send_set_health()
	if self._unit:network() then
		local hp = math.round(self:get_real_health() / self:_max_health() * 100)
		self._unit:network():send("set_health", math.clamp(hp, 0, 100))
	end
end

function PlayerDamage:_set_health_effect()
	local hp = self:get_real_health() / self:_max_health()
	math.clamp(hp, 0, 1)
	managers.environment_controller:set_health_effect_value(hp)
end

function PlayerDamage:_send_set_armor()
	if self._unit:network() then
		local armor = math.round(self:get_real_armor() / self:_total_armor() * 100)
		self._unit:network():send("set_armor", math.clamp(armor, 0, 100))
	end
end

function PlayerDamage:stop_heartbeat()
	if self._critical_state_heart_loop_instance then
		self._critical_state_heart_loop_instance:stop()
		self._critical_state_heart_loop_instance = nil
	end
	if self._slomo_sound_instance then
		self._slomo_sound_instance:stop()
		self._slomo_sound_instance = nil
	end
	managers.environment_controller:set_downed_value(0)
	SoundDevice:set_rtpc("downed_state_progression", 0)
	SoundDevice:set_rtpc("stamina", 100)
end

function PlayerDamage:pre_destroy()
	if alive(self._gui) and alive(self._ws) then
		self._gui:destroy_workspace(self._ws)
	end
	if self._critical_state_heart_loop_instance then
		self._critical_state_heart_loop_instance:stop()
	end
	if self._slomo_sound_instance then
		self._slomo_sound_instance:stop()
		self._slomo_sound_instance = nil
	end
	managers.environment_controller:set_last_life(false)
	managers.environment_controller:set_downed_value(0)
	SoundDevice:set_rtpc("downed_state_progression", 0)
	SoundDevice:set_rtpc("shield_status", 100)
	managers.environment_controller:set_hurt_value(1)
	managers.environment_controller:set_health_effect_value(1)
	managers.environment_controller:set_suppression_value(0)
end

function PlayerDamage:_call_listeners(damage_info)
	CopDamage._call_listeners(self, damage_info)
end

function PlayerDamage:add_listener(...)
	CopDamage.add_listener(self, ...)
end

function PlayerDamage:remove_listener(key)
	CopDamage.remove_listener(self, key)
end

function PlayerDamage:on_fatal_state_enter()
	local dmg_info = {
		result = {type = "death"}
	}
	self:_call_listeners(dmg_info)
end

function PlayerDamage:on_incapacitated_state_enter()
	local dmg_info = {
		result = {type = "death"}
	}
	self:_call_listeners(dmg_info)
end

function PlayerDamage:_chk_dmg_too_soon(damage)
	local next_allowed_dmg_t = type(self._next_allowed_dmg_t) == "number" and self._next_allowed_dmg_t or Application:digest_value(self._next_allowed_dmg_t, false)
	if damage <= self._last_received_dmg and next_allowed_dmg_t > managers.player:player_timer():time() then
		return true
	end
end

function PlayerDamage:_chk_suppression_too_soon(amount)
	if amount <= self._last_received_sup and managers.player:player_timer():time() < self._next_allowed_sup_t then
		return true
	end
end

function PlayerDamage.clbk_msg_overwrite_criminal_hurt(overwrite_data, msg_queue, msg_name, crim_unit, attacker_unit, dmg)
	if msg_queue then
		local crim_key = crim_unit:key()
		local attacker_key = attacker_unit:key()
		if overwrite_data.indexes[crim_key] and overwrite_data.indexes[crim_key][attacker_key] then
			local index = overwrite_data.indexes[crim_key][attacker_key]
			local old_msg = msg_queue[index]
			old_msg[4] = math.clamp(dmg + old_msg[4], 1, 100)
		else
			table.insert(msg_queue, {
				msg_name,
				crim_unit,
				attacker_unit,
				dmg
			})
			overwrite_data.indexes[crim_key] = {
				[attacker_key] = #msg_queue
			}
		end
	else
		overwrite_data.indexes = {}
	end
end

function PlayerDamage:build_suppression(amount)
	if self:_chk_suppression_too_soon(amount) then
		return
	end
	local data = self._supperssion_data
	amount = amount * managers.player:upgrade_value("player", "suppressed_multiplier", 1)
	local morale_boost_bonus = self._unit:movement():morale_boost()
	if morale_boost_bonus then
		amount = amount * morale_boost_bonus.suppression_resistance
	end
	amount = amount * tweak_data.player.suppression.receive_mul
	data.value = math.min(tweak_data.player.suppression.max_value, (data.value or 0) + amount * tweak_data.player.suppression.receive_mul)
	self._last_received_sup = amount
	self._next_allowed_sup_t = managers.player:player_timer():time() + self._dmg_interval
	data.decay_start_t = managers.player:player_timer():time() + tweak_data.player.suppression.decay_start_delay
end

function PlayerDamage:_upd_suppression(t, dt)
	local data = self._supperssion_data
	if data.value then
		if t > data.decay_start_t then
			data.value = data.value - dt
			if data.value <= 0 then
				data.value = nil
				data.decay_start_t = nil
				managers.environment_controller:set_suppression_value(0, 0)
			end
		elseif data.value == tweak_data.player.suppression.max_value and self._regenerate_timer then
			self:set_regenerate_timer_to_max()
		end
		if data.value then
			managers.environment_controller:set_suppression_value(self:effective_suppression_ratio(), self:suppression_ratio())
		end
	end
end

function PlayerDamage:_upd_health_regen(t, dt)
	if self._health_regen_update_timer then
		self._health_regen_update_timer = self._health_regen_update_timer - dt
		if self._health_regen_update_timer <= 0 then
			self._health_regen_update_timer = nil
		end
	end
	if not self._health_regen_update_timer then
		local regen_rate = 0 + managers.player:temporary_upgrade_value("temporary", "wolverine_health_regen", 0)
		local max_health = self:_max_health()
		if 0 < regen_rate and max_health > self:get_real_health() then
			self:change_health(max_health * regen_rate)
			self._health_regen_update_timer = 1
		end
	end
end

function PlayerDamage:suppression_ratio()
	return (self._supperssion_data.value or 0) / tweak_data.player.suppression.max_value
end

function PlayerDamage:effective_suppression_ratio()
	local effective_ratio = math.max(0, (self._supperssion_data.value or 0) - tweak_data.player.suppression.tolerance) / (tweak_data.player.suppression.max_value - tweak_data.player.suppression.tolerance)
	return effective_ratio
end

function PlayerDamage:is_suppressed()
	return self:effective_suppression_ratio() > 0
end

function PlayerDamage:reset_suppression()
	self._supperssion_data.value = nil
	self._supperssion_data.decay_start_t = nil
end

function PlayerDamage:on_flashbanged(sound_eff_mul)
	if self._downed_timer then
		return
	end
	self:_start_tinnitus(sound_eff_mul)
end

function PlayerDamage:_start_tinnitus(sound_eff_mul)
	if self._tinnitus_data then
		if sound_eff_mul < self._tinnitus_data.intensity then
			return
		end
		self._tinnitus_data.intensity = sound_eff_mul
		self._tinnitus_data.duration = 4 + sound_eff_mul * math.lerp(8, 12, math.random())
		self._tinnitus_data.end_t = managers.player:player_timer():time() + self._tinnitus_data.duration
		if self._tinnitus_data.snd_event then
			self._tinnitus_data.snd_event:stop()
		end
		SoundDevice:set_rtpc("downed_state_progression", math.max(self._downed_progression or 0, self._tinnitus_data.intensity * 100))
		self._tinnitus_data.snd_event = self._unit:sound():play("tinnitus_beep")
	else
		local duration = 4 + sound_eff_mul * math.lerp(8, 12, math.random())
		SoundDevice:set_rtpc("downed_state_progression", math.max(self._downed_progression or 0, sound_eff_mul * 100))
		self._tinnitus_data = {
			intensity = sound_eff_mul,
			duration = duration,
			end_t = managers.player:player_timer():time() + duration,
			snd_event = self._unit:sound():play("tinnitus_beep")
		}
	end
end

function PlayerDamage:_stop_tinnitus()
	if not self._tinnitus_data then
		return
	end
	self._unit:sound():play("tinnitus_beep_stop")
	self._tinnitus_data = nil
end
