PlayerEquipment = PlayerEquipment or class()

function PlayerEquipment:init(unit)
	self._unit = unit
end

function PlayerEquipment:on_deploy_interupted()
	if alive(self._dummy_unit) then
		World:delete_unit(self._dummy_unit)
		self._dummy_unit = nil
	end
end

function PlayerEquipment:valid_look_at_placement(equipment_data)
	local from = self._unit:movement():m_head_pos()
	local to = from + self._unit:movement():m_head_rot():y() * 200
	local ray = self._unit:raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
	if ray and equipment_data and equipment_data.dummy_unit then
		local pos = ray.position
		local rot = Rotation(ray.normal, math.UP)
		if not alive(self._dummy_unit) then
			self._dummy_unit = World:spawn_unit(Idstring(equipment_data.dummy_unit), pos, rot)
			self:_disable_contour(self._dummy_unit)
		end
		self._dummy_unit:set_position(pos)
		self._dummy_unit:set_rotation(rot)
	end
	if alive(self._dummy_unit) then
		self._dummy_unit:set_enabled(ray and true or false)
	end
	return ray
end

function PlayerEquipment:use_trip_mine()
	local ray = self:valid_look_at_placement()
	if ray then
		managers.statistics:use_trip_mine()
		local sensor_upgrade = managers.player:has_category_upgrade("trip_mine", "sensor_toggle")
		if Network:is_client() then
			managers.network:session():send_to_host("attach_device", ray.position, ray.normal, sensor_upgrade)
		else
			local rot = Rotation(ray.normal, math.UP)
			local unit = TripMineBase.spawn(ray.position, rot, sensor_upgrade, managers.network:session():local_peer():id())
			unit:base():set_active(true, self._unit)
		end
		return true
	end
	return false
end

function PlayerEquipment:valid_placement(equipment_data)
	local valid = not self._unit:movement():current_state():in_air()
	local pos = self._unit:movement():m_pos()
	local rot = self._unit:movement():m_head_rot()
	rot = Rotation(rot:yaw(), 0, 0)
	if equipment_data and equipment_data.dummy_unit then
		if not alive(self._dummy_unit) then
			self._dummy_unit = World:spawn_unit(Idstring(equipment_data.dummy_unit), pos, rot)
			self:_disable_contour(self._dummy_unit)
		end
		self._dummy_unit:set_position(pos)
		self._dummy_unit:set_rotation(rot)
		if alive(self._dummy_unit) then
			self._dummy_unit:set_enabled(valid)
		end
	end
	return valid
end

local ids_contour_color = Idstring("contour_color")
local ids_contour_opacity = Idstring("contour_opacity")
local ids_material = Idstring("material")

function PlayerEquipment:_disable_contour(unit)
	local materials = unit:get_objects_by_type(ids_material)
	for _, m in ipairs(materials) do
		m:set_variable(ids_contour_opacity, 0)
	end
end

function PlayerEquipment:use_ammo_bag()
	local ray = self:valid_shape_placement("ammo_bag")
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		PlayerStandard.say_line(self, "s01x_plu")
		managers.statistics:use_ammo_bag()
		local ammo_upgrade_lvl = managers.player:upgrade_level("ammo_bag", "ammo_increase")
		if Network:is_client() then
			managers.network:session():send_to_host("place_deployable_bag", "AmmoBagBase", pos, rot, ammo_upgrade_lvl)
		else
			local unit = AmmoBagBase.spawn(pos, rot, ammo_upgrade_lvl, managers.network:session():local_peer():id())
		end
		if managers.player:has_category_upgrade("temporary", "no_ammo_cost") then
			managers.player:activate_temporary_upgrade("temporary", "no_ammo_cost")
		end
		return true
	end
	return false
end

function PlayerEquipment:use_doctor_bag()
	local ray = self:valid_shape_placement("doctor_bag")
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		PlayerStandard.say_line(self, "s02x_plu")
		if managers.blackmarket:equipped_mask().mask_id == tweak_data.achievement.no_we_cant.mask then
			managers.achievment:award_progress(tweak_data.achievement.no_we_cant.stat)
		end
		managers.statistics:use_doctor_bag()
		local amount_upgrade_lvl = managers.player:upgrade_level("doctor_bag", "amount_increase")
		if Network:is_client() then
			managers.network:session():send_to_host("place_deployable_bag", "DoctorBagBase", pos, rot, amount_upgrade_lvl)
		else
			local unit = DoctorBagBase.spawn(pos, rot, amount_upgrade_lvl, managers.network:session():local_peer():id())
		end
		return true
	end
	return false
end

function PlayerEquipment:use_first_aid_kit()
	local ray = self:valid_shape_placement("first_aid_kit")
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		PlayerStandard.say_line(self, "s12")
		managers.statistics:use_first_aid()
		local upgrade_lvl = managers.player:has_category_upgrade("first_aid_kit", "damage_reduction_upgrade") and 1 or 0
		if Network:is_client() then
			managers.network:session():send_to_host("place_deployable_bag", "FirstAidKitBase", pos, rot, upgrade_lvl)
		else
			local unit = FirstAidKitBase.spawn(pos, rot, upgrade_lvl, managers.network:session():local_peer():id())
		end
		return true
	end
	return false
end

function PlayerEquipment:use_armor_kit()
	local redirect = function()
		if Network:is_client() then
			managers.network:session():send_to_host("used_deployable")
		else
			managers.network:session():local_peer():set_used_deployable(true)
		end
		managers.statistics:use_armor_bag()
		MenuCallbackHandler:_update_outfit_information()
	end
	return true, redirect
end

function PlayerEquipment:use_armor_kit_dropin_penalty()
	MenuCallbackHandler:_update_outfit_information()
	return true
end

function PlayerEquipment:use_bodybags_bag()
	local ray = self:valid_shape_placement("bodybags_bag")
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		PlayerStandard.say_line(self, "s13")
		managers.statistics:use_body_bag()
		local amount_upgrade_lvl = 0
		if Network:is_client() then
			managers.network:session():send_to_host("place_deployable_bag", "BodyBagsBagBase", pos, rot, amount_upgrade_lvl)
		else
			local unit = BodyBagsBagBase.spawn(pos, rot, amount_upgrade_lvl, managers.network:session():local_peer():id())
		end
		return true
	end
	return false
end

function PlayerEquipment:use_ecm_jammer()
	if self._ecm_jammer_placement_requested then
		return
	end
	local ray = self:valid_look_at_placement()
	if ray then
		managers.statistics:use_ecm_jammer()
		local duration_multiplier = managers.player:upgrade_value("ecm_jammer", "duration_multiplier", 1) * managers.player:upgrade_value("ecm_jammer", "duration_multiplier_2", 1)
		if Network:is_client() then
			self._ecm_jammer_placement_requested = true
			managers.network:session():send_to_host("request_place_ecm_jammer", ray.position, ray.normal, duration_multiplier)
		else
			local rot = Rotation(ray.normal, math.UP)
			local unit = ECMJammerBase.spawn(ray.position, rot, duration_multiplier, self._unit, managers.network:session():local_peer():id())
			unit:base():set_active(true)
		end
		return true
	end
	return false
end

function PlayerEquipment:from_server_ecm_jammer_placement_result()
	self._ecm_jammer_placement_requested = nil
end

function PlayerEquipment:_spawn_dummy(dummy_name, pos, rot)
	if alive(self._dummy_unit) then
		return self._dummy_unit
	end
	self._dummy_unit = World:spawn_unit(Idstring(dummy_name), pos, rot)
	for i = 0, self._dummy_unit:num_bodies() - 1 do
		self._dummy_unit:body(i):set_enabled(false)
	end
	return self._dummy_unit
end

function PlayerEquipment:valid_shape_placement(equipment_id, equipment_data)
	local from = self._unit:movement():m_head_pos()
	local to = from + self._unit:movement():m_head_rot():y() * 220
	local ray = self._unit:raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
	local valid = ray and true or false
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		if not alive(self._dummy_unit) then
			self._dummy_unit = World:spawn_unit(Idstring(equipment_data.dummy_unit), pos, rot)
			self:_disable_contour(self._dummy_unit)
		end
		self._dummy_unit:set_position(pos)
		self._dummy_unit:set_rotation(rot)
		valid = valid and math.dot(ray.normal, math.UP) > 0.25
		local find_start_pos, find_end_pos, find_radius
		if equipment_id == "ammo_bag" then
			find_start_pos = pos + math.UP * 20
			find_end_pos = pos + math.UP * 21
			find_radius = 12
		elseif equipment_id == "doctor_bag" then
			find_start_pos = pos + math.UP * 22
			find_end_pos = pos + math.UP * 28
			find_radius = 15
		else
			find_start_pos = pos + math.UP * 30
			find_end_pos = pos + math.UP * 40
			find_radius = 17
		end
		local bodies = self._dummy_unit:find_bodies("intersect", "capsule", find_start_pos, find_end_pos, find_radius, managers.slot:get_mask("trip_mine_placeables") + 14 + 25)
		for _, body in ipairs(bodies) do
			if body:unit() ~= self._dummy_unit and body:has_ray_type(Idstring("body")) then
				valid = false
				break
			end
		end
	end
	if alive(self._dummy_unit) then
		self._dummy_unit:set_enabled(valid)
	end
	return valid and ray
end

function PlayerEquipment:use_sentry_gun(selected_index)
	if self._sentrygun_placement_requested then
		return
	end
	local ray = self:valid_shape_placement()
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		managers.statistics:use_sentry_gun()
		local ammo_multiplier = managers.player:upgrade_value("sentry_gun", "extra_ammo_multiplier", 1)
		local armor_multiplier = 1 + (managers.player:upgrade_value("sentry_gun", "armor_multiplier", 1) - 1) + (managers.player:upgrade_value("sentry_gun", "armor_multiplier2", 1) - 1)
		local damage_multiplier = managers.player:upgrade_value("sentry_gun", "damage_multiplier", 1)
		if Network:is_client() then
			managers.network:session():send_to_host("place_sentry_gun", pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, selected_index, self._unit)
			self._sentrygun_placement_requested = true
			return false
		else
			local shield = managers.player:has_category_upgrade("sentry_gun", "shield")
			local sentry_gun_unit = SentryGunBase.spawn(self._unit, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, managers.network:session():local_peer():id())
			if sentry_gun_unit then
				managers.network:session():send_to_peers_synched("from_server_sentry_gun_place_result", managers.network:session():local_peer():id(), selected_index, sentry_gun_unit, sentry_gun_unit:movement()._rot_speed_mul, sentry_gun_unit:weapon()._setup.spread_mul, shield)
			else
				return false
			end
		end
		return true
	end
	return false
end

function PlayerEquipment:use_flash_grenade()
	self._grenade_name = "units/weapons/flash_grenade/flash_grenade"
	return true, "throw_grenade"
end

function PlayerEquipment:use_smoke_grenade()
	self._grenade_name = "units/weapons/smoke_grenade/smoke_grenade"
	return true, "throw_grenade"
end

function PlayerEquipment:use_frag_grenade()
	self._grenade_name = "units/weapons/frag_grenade/frag_grenade"
	return true, "throw_grenade"
end

function PlayerEquipment:throw_flash_grenade()
	if not self._grenade_name then
		Application:error("Tried to throw a grenade with no name")
	end
	local from = self._unit:movement():m_head_pos()
	local to = from + self._unit:movement():m_head_rot():y() * 35 + Vector3(0, 0, 0)
	local unit = GrenadeBase.spawn(self._grenade_name, to, Rotation())
	unit:base():throw({
		dir = self._unit:movement():m_head_rot():y(),
		owner = self._unit
	})
	self._grenade_name = nil
end

function PlayerEquipment:throw_grenade()
	local from = self._unit:movement():m_head_pos()
	local pos = from + self._unit:movement():m_head_rot():y() * 30 + Vector3(0, 0, 0)
	local dir = self._unit:movement():m_head_rot():y()
	self._unit:sound():play("g43", nil, true)
	if Network:is_client() then
		managers.network:session():send_to_host("server_throw_grenade", 1, pos, dir)
	else
		GrenadeBase.server_throw_grenade(1, pos, dir, managers.network:session():local_peer():id())
		managers.player:verify_grenade(managers.network:session():local_peer():id())
	end
	managers.player:on_throw_grenade()
end

function PlayerEquipment:use_duck()
	local soundsource = SoundDevice:create_source("duck")
	soundsource:post_event("footstep_walk")
	return true
end

function PlayerEquipment:from_server_sentry_gun_place_result()
	self._sentrygun_placement_requested = nil
end

function PlayerEquipment:destroy()
	if alive(self._dummy_unit) then
		World:delete_unit(self._dummy_unit)
		self._dummy_unit = nil
	end
end
