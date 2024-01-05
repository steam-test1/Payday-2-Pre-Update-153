local mvec3_set = mvector3.set
local mvec3_add = mvector3.add
local mvec3_dot = mvector3.dot
local mvec3_sub = mvector3.subtract
local mvec3_mul = mvector3.multiply
local mvec3_norm = mvector3.normalize
local mvec3_dir = mvector3.direction
local mvec3_set_l = mvector3.set_length
local mvec3_len = mvector3.length
local math_clamp = math.clamp
local math_lerp = math.lerp
local tmp_vec1 = Vector3()
local tmp_vec2 = Vector3()
NewRaycastWeaponBase = NewRaycastWeaponBase or class(RaycastWeaponBase)

function NewRaycastWeaponBase:init(unit)
	NewRaycastWeaponBase.super.init(self, unit)
end

function NewRaycastWeaponBase:is_npc()
	return false
end

function NewRaycastWeaponBase:skip_queue()
	return false
end

function NewRaycastWeaponBase:set_factory_data(factory_id)
	self._factory_id = factory_id
end

function NewRaycastWeaponBase:assemble(factory_id)
	local third_person = self:is_npc()
	local skip_queue = self:skip_queue()
	self._parts, self._blueprint = managers.weapon_factory:assemble_default(factory_id, self._unit, third_person, callback(self, self, "_assemble_completed"), skip_queue)
	self:_update_stats_values()
	do return end
	local third_person = self:is_npc()
	self._parts, self._blueprint = managers.weapon_factory:assemble_default(factory_id, self._unit, third_person)
	self:_update_fire_object()
	self:_update_stats_values()
end

function NewRaycastWeaponBase:assemble_from_blueprint(factory_id, blueprint)
	local third_person = self:is_npc()
	local skip_queue = self:skip_queue()
	self._parts, self._blueprint = managers.weapon_factory:assemble_from_blueprint(factory_id, self._unit, blueprint, third_person, callback(self, self, "_assemble_completed"), skip_queue)
	self:_update_stats_values()
	do return end
	local third_person = self:is_npc()
	self._parts, self._blueprint = managers.weapon_factory:assemble_from_blueprint(factory_id, self._unit, blueprint, third_person)
	self:_update_fire_object()
	self:_update_stats_values()
end

function NewRaycastWeaponBase:_assemble_completed(parts, blueprint)
	print("NewRaycastWeaponBase:_assemble_completed", parts, blueprint)
	self._parts = parts
	self._blueprint = blueprint
	self:_update_fire_object()
	self:_update_stats_values()
	self:check_npc()
	self:_set_parts_enabled(self._enabled)
end

function NewRaycastWeaponBase:check_npc()
end

function NewRaycastWeaponBase:change_part(part_id)
	self._parts = managers.weapon_factory:change_part(self._unit, self._factory_id, part_id or "wpn_fps_m4_uupg_b_sd", self._parts, self._blueprint)
	self:_update_fire_object()
	self:_update_stats_values()
end

function NewRaycastWeaponBase:remove_part(part_id)
	self._parts = managers.weapon_factory:remove_part(self._unit, self._factory_id, part_id, self._parts, self._blueprint)
	self:_update_fire_object()
	self:_update_stats_values()
end

function NewRaycastWeaponBase:remove_part_by_type(type)
	self._parts = managers.weapon_factory:remove_part_by_type(self._unit, self._factory_id, type, self._parts, self._blueprint)
	self:_update_fire_object()
	self:_update_stats_values()
end

function NewRaycastWeaponBase:change_blueprint(blueprint)
	self._blueprint = blueprint
	self._parts = managers.weapon_factory:change_blueprint(self._unit, self._factory_id, self._parts, blueprint)
	self:_update_fire_object()
	self:_update_stats_values()
end

function NewRaycastWeaponBase:blueprint_to_string()
	local s = managers.weapon_factory:blueprint_to_string(self._factory_id, self._blueprint)
	return s
end

function NewRaycastWeaponBase:_update_fire_object()
	local fire = managers.weapon_factory:get_part_from_weapon_by_type("barrel_ext", self._parts) or managers.weapon_factory:get_part_from_weapon_by_type("slide", self._parts) or managers.weapon_factory:get_part_from_weapon_by_type("barrel", self._parts)
	self:change_fire_object(fire.unit:get_object(Idstring("fire")))
end

function NewRaycastWeaponBase:_update_stats_values()
	self:_check_sound_switch()
	self._silencer = managers.weapon_factory:has_perk("silencer", self._factory_id, self._blueprint)
	if self._silencer then
		self._muzzle_effect = Idstring(self:weapon_tweak_data().muzzleflash_silenced or "effects/payday2/particles/weapons/9mm_auto_silence_fps")
	else
		self._muzzle_effect = Idstring(self:weapon_tweak_data().muzzleflash or "effects/particles/test/muzzleflash_maingun")
	end
	self._muzzle_effect_table = {
		effect = self._muzzle_effect,
		parent = self._obj_fire,
		force_synch = self._muzzle_effect_table.force_synch or false
	}
	local base_stats = self:weapon_tweak_data().stats
	if not base_stats then
		return
	end
	local parts_stats = managers.weapon_factory:get_stats(self._factory_id, self._blueprint)
	local stats = deep_clone(base_stats)
	local tweak_data = tweak_data.weapon.stats
	if stats.zoom then
		stats.zoom = math.min(stats.zoom + managers.player:upgrade_value(self:weapon_tweak_data().category, "zoom_increase", 0), #tweak_data.zoom)
	end
	for stat, _ in pairs(stats) do
		if parts_stats[stat] then
			stats[stat] = math_clamp(stats[stat] + parts_stats[stat], 1, #tweak_data[stat])
		end
	end
	self._current_stats = {}
	for stat, i in pairs(stats) do
		self._current_stats[stat] = tweak_data[stat][i]
	end
	self._current_stats.alert_size = tweak_data.alert_size[math_clamp(stats.suppression, 1, #tweak_data.alert_size)]
	if stats.concealment then
		stats.suspicion = math.clamp(#tweak_data.concealment - base_stats.concealment - (parts_stats.concealment or 0), 1, #tweak_data.concealment)
		self._current_stats.suspicion = tweak_data.concealment[stats.suspicion]
	end
	self._alert_size = self._current_stats.alert_size or self._alert_size
	self._suppression = self._current_stats.suppression or self._suppression
	self._zoom = self._current_stats.zoom or self._zoom
	self._spread = self._current_stats.spread or self._spread
	self._recoil = self._current_stats.recoil or self._recoil
	self._spread_moving = self._current_stats.spread_moving or self._spread_moving
	self._extra_ammo = self._current_stats.extra_ammo or self._extra_ammo
	self:replenish()
end

function NewRaycastWeaponBase:_check_sound_switch()
	local suppressed_switch = managers.weapon_factory:get_sound_switch("suppressed", self._factory_id, self._blueprint)
	self._sound_fire:set_switch("suppressed", suppressed_switch or "regular")
end

function NewRaycastWeaponBase:stance_id()
	return "new_m4"
end

function NewRaycastWeaponBase:weapon_hold()
	return self:weapon_tweak_data().weapon_hold
end

function NewRaycastWeaponBase:replenish()
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1)
	ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value(self:weapon_tweak_data().category, "extra_ammo_multiplier", 1)
	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()
	local ammo_max = math.round((tweak_data.weapon[self._name_id].AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier)
	self:set_ammo_max_per_clip(ammo_max_per_clip)
	self:set_ammo_max(ammo_max)
	self:set_ammo_total(ammo_max)
	self:set_ammo_remaining_in_clip(ammo_max_per_clip)
	self._ammo_pickup = tweak_data.weapon[self._name_id].AMMO_PICKUP
	self:update_damage()
end

function NewRaycastWeaponBase:update_damage()
	self._damage = (self._current_stats and self._current_stats.damage or 0) * self:damage_multiplier()
end

function NewRaycastWeaponBase:calculate_ammo_max_per_clip()
	local ammo = tweak_data.weapon[self._name_id].CLIP_AMMO_MAX
	ammo = ammo + managers.player:upgrade_value(self._name_id, "clip_ammo_increase")
	if not self:upgrade_blocked("weapon", "clip_ammo_increase") then
		ammo = ammo + managers.player:upgrade_value("weapon", "clip_ammo_increase", 0)
	end
	ammo = ammo + (self._extra_ammo or 0)
	return ammo
end

function NewRaycastWeaponBase:stance_mod()
	if not self._parts then
		return nil
	end
	local factory = tweak_data.weapon.factory
	for part_id, data in pairs(self._parts) do
		if factory.parts[part_id].stance_mod and factory.parts[part_id].stance_mod[self._factory_id] then
			return {
				translation = factory.parts[part_id].stance_mod[self._factory_id].translation
			}
		end
	end
	return nil
end

function NewRaycastWeaponBase:tweak_data_anim_play(anim, speed_multiplier)
	local data = tweak_data.weapon.factory[self._factory_id]
	if data.animations and data.animations[anim] then
		local anim_name = data.animations[anim]
		local length = self._unit:anim_length(Idstring(anim_name))
		speed_multiplier = speed_multiplier or 1
		self._unit:anim_stop(Idstring(anim_name))
		self._unit:anim_play_to(Idstring(anim_name), length, speed_multiplier)
	end
	for part_id, data in pairs(self._parts) do
		if data.animations and data.animations[anim] then
			local anim_name = data.animations[anim]
			local length = data.unit:anim_length(Idstring(anim_name))
			speed_multiplier = speed_multiplier or 1
			data.unit:anim_stop(Idstring(anim_name))
			data.unit:anim_play_to(Idstring(anim_name), length, speed_multiplier)
		end
	end
	NewRaycastWeaponBase.super.tweak_data_anim_play(self, anim, speed_multiplier)
	return true
end

function NewRaycastWeaponBase:tweak_data_anim_stop(anim)
	local data = tweak_data.weapon.factory[self._factory_id]
	if data.animations and data.animations[anim] then
		local anim_name = data.animations[anim]
		self._unit:anim_stop(Idstring(anim_name))
	end
	for part_id, data in pairs(self._parts) do
		if data.animations and data.animations[anim] then
			local anim_name = data.animations[anim]
			data.unit:anim_stop(Idstring(anim_name))
		end
	end
end

function NewRaycastWeaponBase:_set_parts_enabled(enabled)
	if self._parts then
		for part_id, data in pairs(self._parts) do
			if alive(data.unit) then
				data.unit:set_enabled(enabled)
			end
		end
	end
end

function NewRaycastWeaponBase:on_enabled(...)
	NewRaycastWeaponBase.super.on_enabled(self, ...)
	self:_set_parts_enabled(true)
end

function NewRaycastWeaponBase:on_disabled(...)
	NewRaycastWeaponBase.super.on_disabled(self, ...)
	self:gadget_off()
	self:_set_parts_enabled(false)
end

function NewRaycastWeaponBase:has_gadget()
	return managers.weapon_factory:get_part_from_weapon_by_type("gadget", self._parts) and true or false
end

function NewRaycastWeaponBase:gadget_on()
	self._gadget_on = true
	local gadget = managers.weapon_factory:get_part_from_weapon_by_type("gadget", self._parts)
	if gadget then
		gadget.unit:base():set_state(self._gadget_on, self._sound_fire)
	end
end

function NewRaycastWeaponBase:gadget_off()
	self._gadget_on = false
	local gadget = managers.weapon_factory:get_part_from_weapon_by_type("gadget", self._parts)
	if gadget then
		gadget.unit:base():set_state(self._gadget_on, self._sound_fire)
	end
end

function NewRaycastWeaponBase:toggle_gadget()
	self._gadget_on = not self._gadget_on
	local gadget = managers.weapon_factory:get_part_from_weapon_by_type("gadget", self._parts)
	if gadget then
		gadget.unit:base():set_state(self._gadget_on, self._sound_fire)
	end
end

function NewRaycastWeaponBase:check_stats()
	local base_stats = self:weapon_tweak_data().stats
	if not base_stats then
		print("no stats")
		return
	end
	local parts_stats = managers.weapon_factory:get_stats(self._factory_id, self._blueprint)
	local stats = deep_clone(base_stats)
	local tweak_data = tweak_data.weapon.stats
	stats.zoom = math.min(stats.zoom + managers.player:upgrade_value(self:weapon_tweak_data().category, "zoom_increase", 0), #tweak_data.zoom)
	for stat, _ in pairs(stats) do
		if parts_stats[stat] then
			stats[stat] = math_clamp(stats[stat] + parts_stats[stat], 1, #tweak_data[stat])
		end
	end
	self._current_stats = {}
	for stat, i in pairs(stats) do
		self._current_stats[stat] = tweak_data[stat][i]
	end
	self._current_stats.alert_size = tweak_data.alert_size[math_clamp(stats.suppression, 1, #tweak_data.alert_size)]
	return stats
end

function NewRaycastWeaponBase:_convert_add_to_mul(value)
	if 1 < value then
		return 1 / value
	elseif value < 1 then
		return math.abs(value - 1) + 1
	else
		return 1
	end
end

function NewRaycastWeaponBase:_get_spread(user_unit)
	local current_state = user_unit:movement()._current_state
	local spread_multiplier = self:spread_multiplier(current_state)
	return self._spread * spread_multiplier
end

function NewRaycastWeaponBase:damage_multiplier()
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(self._name_id, "damage_multiplier", 1))
	if self._silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_damage_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:melee_damage_multiplier()
	return managers.player:upgrade_value(self._name_id, "melee_multiplier", 1)
end

function NewRaycastWeaponBase:spread_multiplier(current_state)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", self:fire_mode() .. "_spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(self._name_id, "spread_multiplier", 1))
	if self._silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_spread_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "silencer_spread_multiplier", 1))
	end
	if current_state then
		if current_state._moving then
			multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "move_spread_multiplier", 1))
			multiplier = multiplier + (1 - (self._spread_moving or 1))
		end
		if current_state:in_steelsight() then
			multiplier = multiplier + (1 - tweak_data.weapon[self._name_id].spread[current_state._moving and "moving_steelsight" or "steelsight"])
		else
			multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "hip_fire_spread_multiplier", 1))
			if current_state._state_data.ducking then
				multiplier = multiplier + (1 - tweak_data.weapon[self._name_id].spread[current_state._moving and "moving_crouching" or "crouching"])
			else
				multiplier = multiplier + (1 - tweak_data.weapon[self._name_id].spread[current_state._moving and "moving_standing" or "standing"])
			end
		end
	end
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:recoil_multiplier()
	local category = self:weapon_tweak_data().category
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "recoil_multiplier", 1))
	if managers.player:player_unit() and managers.player:player_unit():character_damage():is_suppressed() then
		if managers.player:has_team_category_upgrade(category, "suppression_recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value(category, "suppression_recoil_multiplier", 1))
		end
		if managers.player:has_team_category_upgrade("weapon", "suppression_recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "suppression_recoil_multiplier", 1))
		end
	else
		if managers.player:has_team_category_upgrade(category, "recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value(category, "recoil_multiplier", 1))
		end
		if managers.player:has_team_category_upgrade("weapon", "recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "recoil_multiplier", 1))
		end
	end
	multiplier = multiplier + (1 - managers.player:upgrade_value(self._name_id, "recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "passive_recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "recoil_multiplier", 1))
	if self._silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_recoil_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "silencer_recoil_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:enter_steelsight_speed_multiplier()
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "enter_steelsight_speed_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:temporary_upgrade_value("temporary", "combat_medic_enter_steelsight_speed_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(self._name_id, "enter_steelsight_speed_multiplier", 1))
	if self._silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_enter_steelsight_speed_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "silencer_enter_steelsight_speed_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:fire_rate_multiplier()
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "fire_rate_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(self._name_id, "fire_rate_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "fire_rate_multiplier", 1))
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:reload_speed_multiplier()
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(self:weapon_tweak_data().category, "reload_speed_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "passive_reload_speed_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1))
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:destroy(unit)
	NewRaycastWeaponBase.super.destroy(self, unit)
	managers.weapon_factory:disassemble(self._parts)
end
