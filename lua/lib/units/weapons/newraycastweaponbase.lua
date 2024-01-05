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
	self._has_gadget = false
end

function NewRaycastWeaponBase:is_npc()
	return false
end

function NewRaycastWeaponBase:skip_queue()
	return false
end

function NewRaycastWeaponBase:set_texture_switches(texture_switches)
	self._texture_switches = texture_switches
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
	local magazine = managers.weapon_factory:get_part_from_weapon_by_type("magazine", self._parts)
	if magazine then
		local bullet_objects = managers.weapon_factory:get_part_data_type_from_weapon_by_type("magazine", "bullet_objects", self._parts)
		if bullet_objects then
			self._bullet_objects = {}
			local prefix = bullet_objects.prefix
			for i = 1, bullet_objects.amount do
				local object = magazine.unit:get_object(Idstring(prefix .. i))
				if object then
					self._bullet_objects[i] = self._bullet_objects[i] or {}
					table.insert(self._bullet_objects[i], object)
				end
			end
		end
	end
	self:apply_texture_switches()
	self:check_npc()
	self:_set_parts_enabled(self._enabled)
end

function NewRaycastWeaponBase:apply_texture_switches()
	local parts_tweak = tweak_data.weapon.factory.parts
	self._parts_texture_switches = self._parts_texture_switches or {}
	if self._texture_switches then
		local texture_switch, part_data, unit, material_ids, material_config, switch_material
		for part_id, texture_data in pairs(self._texture_switches) do
			if self._parts_texture_switches[part_id] ~= texture_data then
				switch_material = nil
				texture_switch = parts_tweak[part_id] and parts_tweak[part_id].texture_switch
				part_data = self._parts and self._parts[part_id]
				if texture_switch and part_data then
					unit = part_data.unit
					material_ids = Idstring(texture_switch.material)
					material_config = unit:get_objects_by_type(Idstring("material"))
					for _, material in ipairs(material_config) do
						print(material:name())
						if material:name() == material_ids then
							switch_material = material
							break
						end
					end
					Application:debug(switch_material)
					if switch_material then
						local texture_id = managers.blackmarket:get_texture_switch_from_data(texture_data, part_id)
						if texture_id and DB:has(Idstring("texture"), texture_id) then
							local retrieved_texture = TextureCache:retrieve(texture_id, "normal")
							switch_material:set_texture(texture_switch.channel, retrieved_texture)
							if self._parts_texture_switches[part_id] then
								TextureCache:unretrieve(Idstring(self._parts_texture_switches[part_id]))
							end
							self._parts_texture_switches[part_id] = Idstring(texture_id)
						else
							Application:error("[NewRaycastWeaponBase:apply_texture_switches] Switch texture do not exists", texture_id)
						end
					end
				end
			end
		end
	end
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

function NewRaycastWeaponBase:got_silencer()
	return self._silencer
end

local ids_single = Idstring("single")
local ids_auto = Idstring("auto")

function NewRaycastWeaponBase:_update_stats_values()
	self:_check_sound_switch()
	self._silencer = managers.weapon_factory:has_perk("silencer", self._factory_id, self._blueprint)
	self._locked_fire_mode = (not managers.weapon_factory:has_perk("fire_mode_auto", self._factory_id, self._blueprint) or not ids_auto) and managers.weapon_factory:has_perk("fire_mode_single", self._factory_id, self._blueprint) and ids_single
	self._fire_mode = self._locked_fire_mode or Idstring(self:weapon_tweak_data().FIRE_MODE or "single")
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
		if stats[stat] < 1 or stats[stat] > #tweak_data[stat] then
			Application:error("[NewRaycastWeaponBase] Base weapon stat is out of bound!", "stat: " .. stat, "index: " .. stats[stat], "max_index: " .. #tweak_data[stat], "This stat will be clamped!")
		end
		if parts_stats[stat] then
			stats[stat] = math_clamp(stats[stat] + parts_stats[stat], 1, #tweak_data[stat])
		end
		stats[stat] = math_clamp(stats[stat], 1, #tweak_data[stat])
	end
	self._current_stats = {}
	for stat, i in pairs(stats) do
		self._current_stats[stat] = tweak_data[stat][i]
	end
	self._current_stats.alert_size = tweak_data.alert_size[math_clamp(stats.alert_size, 1, #tweak_data.alert_size)]
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
	self._has_gadget = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("gadget", self._factory_id, self._blueprint)
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
	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end
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
	local translation = Vector3()
	local rotation = Rotation()
	local factory = tweak_data.weapon.factory
	for part_id, data in pairs(self._parts) do
		if factory.parts[part_id].stance_mod and factory.parts[part_id].stance_mod[self._factory_id] then
			local part_translation = factory.parts[part_id].stance_mod[self._factory_id].translation
			if part_translation then
				mvector3.add(translation, part_translation)
			end
			local part_rotation = factory.parts[part_id].stance_mod[self._factory_id].rotation
			if part_rotation then
				mrotation.multiply(rotation, part_rotation)
			end
		end
	end
	return {translation = translation, rotation = rotation}
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
	NewRaycastWeaponBase.super.tweak_data_anim_stop(self, anim)
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

function NewRaycastWeaponBase:fire_mode()
	self._fire_mode = self._locked_fire_mode or self._fire_mode or Idstring(tweak_data.weapon[self._name_id].FIRE_MODE or "single")
	return self._fire_mode == ids_single and "single" or "auto"
end

function RaycastWeaponBase:recoil_wait()
	local tweak_is_auto = tweak_data.weapon[self._name_id].FIRE_MODE == "auto"
	local weapon_is_auto = self:fire_mode() == "auto"
	if not tweak_is_auto then
		return nil
	end
	local multiplier = tweak_is_auto == weapon_is_auto and 1 or 2
	return self:weapon_tweak_data().fire_mode_data.fire_rate * multiplier
end

function NewRaycastWeaponBase:can_toggle_firemode()
	return tweak_data.weapon[self._name_id].CAN_TOGGLE_FIREMODE
end

function NewRaycastWeaponBase:toggle_firemode()
	local can_toggle = not self._locked_fire_mode and self:can_toggle_firemode()
	if can_toggle then
		if self._fire_mode == ids_single then
			self._fire_mode = ids_auto
			self._sound_fire:post_event("wp_auto_switch_on")
		else
			self._fire_mode = ids_single
			self._sound_fire:post_event("wp_auto_switch_off")
		end
		return true
	end
	return false
end

function NewRaycastWeaponBase:set_ammo_remaining_in_clip(...)
	NewRaycastWeaponBase.super.set_ammo_remaining_in_clip(self, ...)
	self:check_bullet_objects()
end

function NewRaycastWeaponBase:check_bullet_objects()
	if self._bullet_objects then
		self:_update_bullet_objects(self:get_ammo_remaining_in_clip())
	end
end

function NewRaycastWeaponBase:predict_bullet_objects()
	self:_update_bullet_objects(self:get_ammo_total())
end

function NewRaycastWeaponBase:_update_bullet_objects(ammo)
	if self._bullet_objects then
		for i, objects in pairs(self._bullet_objects) do
			for _, object in ipairs(objects) do
				object:set_visibility(i <= ammo)
			end
		end
	end
end

function NewRaycastWeaponBase:has_gadget()
	return self._has_gadget
end

function NewRaycastWeaponBase:is_gadget_on()
	return self._gadget_on and self._gadget_on > 0 and self._gadget_on or false
end

function NewRaycastWeaponBase:gadget_on()
	self:set_gadget_on(1, true)
end

function NewRaycastWeaponBase:gadget_off()
	self:set_gadget_on(0, true)
end

function NewRaycastWeaponBase:set_gadget_on(gadget_on, ignore_enable, gadgets)
	if not ignore_enable and not self._enabled then
		return
	end
	self._gadget_on = gadget_on or self._gadget_on
	gadgets = gadgets or managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("gadget", self._factory_id, self._blueprint)
	if gadgets then
		local xd, yd
		local part_factory = tweak_data.weapon.factory.parts
		table.sort(gadgets, function(x, y)
			xd = self._parts[x]
			yd = self._parts[y]
			if not xd then
				return false
			end
			if not yd then
				return true
			end
			return xd.unit:base().GADGET_TYPE > yd.unit:base().GADGET_TYPE
		end)
		local gadget
		for i, id in ipairs(gadgets) do
			gadget = self._parts[id]
			if gadget then
				gadget.unit:base():set_state(self._gadget_on == i, self._sound_fire)
			end
		end
	end
end

function NewRaycastWeaponBase:toggle_gadget()
	if not self._enabled then
		return false
	end
	local gadget_on = self._gadget_on or 0
	local gadgets = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("gadget", self._factory_id, self._blueprint)
	if gadgets then
		gadget_on = (gadget_on + 1) % (#gadgets + 1)
		self:set_gadget_on(gadget_on, false, gadgets)
		return true
	end
	do return false end
	if not self._enabled then
		return
	end
	self._gadget_on = self._gadget_on or 0
	local gadgets = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("gadget", self._factory_id, self._blueprint)
	if gadgets then
		self._gadget_on = ((self._gadget_on or 0) + 1) % (#gadgets + 1)
		local gadget
		for _, i in ipairs(gadgets) do
			gadget = self._parts[i]
			gadget.unit:base():set_state(self._gadget_on == i, self._sound_fire)
		end
	end
end

function NewRaycastWeaponBase:gadget_update()
	self:set_gadget_on(false, true)
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
	self._current_stats.alert_size = tweak_data.alert_size[math_clamp(stats.alert_size, 1, #tweak_data.alert_size)]
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

function NewRaycastWeaponBase:fire_rate_multiplier()
	local user_unit = self._setup and self._setup.user_unit
	local current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state
	return managers.blackmarket:fire_rate_multiplier(self._name_id, self:weapon_tweak_data().category, self._silencer, nil, current_state, self._blueprint)
end

function NewRaycastWeaponBase:damage_multiplier()
	local user_unit = self._setup and self._setup.user_unit
	local current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state
	return managers.blackmarket:damage_multiplier(self._name_id, self:weapon_tweak_data().category, self._silencer, nil, current_state, self._blueprint)
end

function NewRaycastWeaponBase:melee_damage_multiplier()
	return managers.player:upgrade_value(self._name_id, "melee_multiplier", 1)
end

function NewRaycastWeaponBase:spread_multiplier(current_state)
	return managers.blackmarket:accuracy_multiplier(self._name_id, self:weapon_tweak_data().category, self._silencer, current_state, self:fire_mode(), self._blueprint)
end

function NewRaycastWeaponBase:recoil_multiplier()
	return managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().category, self._silencer, self._blueprint)
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
	if self._setup and alive(self._setup.user_unit) and self._setup.user_unit:movement() then
		local morale_boost_bonus = self._setup.user_unit:movement():morale_boost()
		if morale_boost_bonus then
			multiplier = multiplier + (1 - morale_boost_bonus.reload_speed_bonus)
		end
	end
	return self:_convert_add_to_mul(multiplier)
end

function NewRaycastWeaponBase:destroy(unit)
	NewRaycastWeaponBase.super.destroy(self, unit)
	if self._parts_texture_switches then
		for part_id, texture_ids in pairs(self._parts_texture_switches) do
			print("BYE BYE ")
			TextureCache:unretrieve(texture_ids)
		end
	end
	managers.weapon_factory:disassemble(self._parts)
end
