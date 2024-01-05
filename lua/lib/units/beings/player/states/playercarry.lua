PlayerCarry = PlayerCarry or class(PlayerStandard)

function PlayerCarry:init(unit)
	PlayerCarry.super.init(self, unit)
end

function PlayerCarry:enter(state_data, enter_data)
	PlayerCarry.super.enter(self, state_data, enter_data)
	self._unit:camera():camera_unit():base():set_target_tilt(-5)
end

function PlayerCarry:_enter(enter_data)
	local my_carry_data = managers.player:get_my_carry_data()
	if my_carry_data then
		local carry_data = tweak_data.carry[my_carry_data.carry_id]
		print("SET CARRY TYPE ON ENTER", carry_data.type)
		self._tweak_data_name = carry_data.type
	else
		self._tweak_data_name = "light"
	end
	if self._ext_movement:nav_tracker() then
		managers.groupai:state():on_criminal_recovered(self._unit)
	end
	if not self._state_data.ducking then
		self._ext_movement:set_attention_settings({
			"pl_enemy_cbt",
			"pl_team_idle_std",
			"pl_civ_cbt"
		})
	end
end

function PlayerCarry:exit(state_data, new_state_name)
	PlayerCarry.super.exit(self, state_data, new_state_name)
	self._unit:camera():camera_unit():base():set_target_tilt(0)
	local exit_data = {}
	exit_data.skip_equip = true
	self._dye_risk = nil
	return exit_data
end

function PlayerCarry:update(t, dt)
	PlayerCarry.super.update(self, t, dt)
	if self._dye_risk and t > self._dye_risk.next_t then
		self:_check_dye_explode()
	end
end

function PlayerCarry:set_tweak_data(name)
	self._tweak_data_name = name
	self:_check_dye_pack()
end

function PlayerCarry:_check_dye_pack()
	local my_carry_data = managers.player:get_my_carry_data()
	if my_carry_data.has_dye_pack then
		self._dye_risk = {}
		self._dye_risk.next_t = managers.player:player_timer():time() + 2 + math.random(3)
	end
end

function PlayerCarry:_check_dye_explode()
	local chance = math.rand(1)
	if chance < 0.25 then
		print("DYE BOOM")
		self._dye_risk = nil
		managers.player:dye_pack_exploded()
		return
	end
	self._dye_risk.next_t = managers.player:player_timer():time() + 2 + math.random(3)
end

function PlayerCarry:_update_check_actions(t, dt)
	local input = self:_get_input()
	self:_determine_move_direction()
	self:_update_interaction_timers(t)
	self:_update_reload_timers(t, dt, input)
	self:_update_melee_timers(t, input)
	self:_update_equip_weapon_timers(t, input)
	self:_update_running_timers(t)
	if input.btn_stats_screen_press then
		self._unit:base():set_stats_screen_visible(true)
	elseif input.btn_stats_screen_release then
		self._unit:base():set_stats_screen_visible(false)
	end
	self:_update_foley(t, input)
	local new_action
	new_action = new_action or self:_check_action_weapon_gadget(t, input)
	new_action = new_action or self:_check_action_melee(t, input)
	new_action = new_action or self:_check_action_reload(t, input)
	new_action = new_action or self:_check_change_weapon(t, input)
	new_action = new_action or self:_check_action_equip(t, input)
	if not new_action then
		new_action = self:_check_action_primary_attack(t, input)
		self._shooting = new_action
	end
	self:_check_action_interact(t, input)
	self:_check_action_jump(t, input)
	self:_check_action_run(t, input)
	self:_check_action_duck(t, input)
	self:_check_action_steelsight(t, input)
	self:_check_use_item(t, input)
	self:_find_pickups(t)
end

function PlayerCarry:_check_action_run(...)
	if tweak_data.carry.types[self._tweak_data_name].can_run then
		PlayerCarry.super._check_action_run(self, ...)
	end
end

function PlayerCarry:_check_use_item(t, input)
	local new_action
	local action_wanted = input.btn_use_item_press
	if action_wanted then
		local action_forbidden = self._use_item_expire_t or self:_changing_weapon() or self:_interacting() or self._ext_movement:has_carry_restriction()
		if not action_forbidden then
			managers.player:drop_carry()
			new_action = true
		end
	end
	return new_action
end

function PlayerCarry:_check_change_weapon(...)
	return PlayerCarry.super._check_change_weapon(self, ...)
end

function PlayerCarry:_check_action_equip(...)
	return PlayerCarry.super._check_action_equip(self, ...)
end

function PlayerCarry:_update_movement(t, dt)
	PlayerCarry.super._update_movement(self, t, dt)
end

function PlayerCarry:_start_action_jump(...)
	PlayerCarry.super._start_action_jump(self, ...)
end

function PlayerCarry:_perform_jump(jump_vec)
	mvector3.multiply(jump_vec, tweak_data.carry.types[self._tweak_data_name].jump_modifier)
	PlayerCarry.super._perform_jump(self, jump_vec)
end

function PlayerCarry:_get_max_walk_speed(...)
	local multiplier = tweak_data.carry.types[self._tweak_data_name].move_speed_modifier
	multiplier = math.clamp(multiplier * managers.player:upgrade_value("carry", "movement_speed_multiplier", 1), 0, 1)
	return PlayerCarry.super._get_max_walk_speed(self, ...) * multiplier
end

function PlayerCarry:_get_walk_headbob(...)
	return PlayerCarry.super._get_walk_headbob(self, ...) * tweak_data.carry.types[self._tweak_data_name].move_speed_modifier
end

function PlayerCarry:pre_destroy(unit)
end

function PlayerCarry:destroy()
end
