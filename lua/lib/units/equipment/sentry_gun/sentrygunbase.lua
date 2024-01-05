SentryGunBase = SentryGunBase or class(UnitBase)

function SentryGunBase:init(unit)
	SentryGunBase.super.init(self, unit, false)
	self._unit = unit
	self._unit:sound_source():post_event("turret_place")
end

function SentryGunBase:post_init()
	self._registered = true
	managers.groupai:state():register_criminal(self._unit)
	if Network:is_client() then
		self._unit:brain():set_active(true)
	end
end

function SentryGunBase.spawn(owner, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier)
	local attached_data = SentryGunBase._attach(pos, rot)
	if not attached_data then
		return
	end
	local spread_multiplier, rot_speed_multiplier, has_shield
	if owner and owner:base().upgrade_value then
		spread_multiplier = owner:base():upgrade_value("sentry_gun", "spread_multiplier") or 1
		rot_speed_multiplier = owner:base():upgrade_value("sentry_gun", "rot_speed_multiplier") or 1
		has_shield = owner:base():upgrade_value("sentry_gun", "shield")
	else
		spread_multiplier = managers.player:upgrade_value("sentry_gun", "spread_multiplier", 1)
		rot_speed_multiplier = managers.player:upgrade_value("sentry_gun", "rot_speed_multiplier", 1)
		has_shield = managers.player:has_category_upgrade("sentry_gun", "shield")
	end
	local unit = World:spawn_unit(Idstring("units/payday2/equipment/gen_equipment_sentry/gen_equipment_sentry"), pos, rot)
	unit:base():setup(owner, ammo_multiplier, armor_multiplier, damage_multiplier, spread_multiplier, rot_speed_multiplier, has_shield, attached_data)
	unit:brain():set_active(true)
	SentryGunBase.deployed = (SentryGunBase.deployed or 0) + 1
	if SentryGunBase.deployed >= 4 then
		managers.challenges:set_flag("sentry_gun_resources")
	end
	return unit
end

function SentryGunBase:get_name_id()
	return "sentry_gun"
end

function SentryGunBase:set_server_information(peer_id)
	self._server_information = {owner_peer_id = peer_id}
	managers.network:game():member(peer_id):peer():set_used_deployable(true)
end

function SentryGunBase:server_information()
	return self._server_information
end

function SentryGunBase:setup(owner, ammo_multiplier, armor_multiplier, damage_multiplier, spread_multiplier, rot_speed_multiplier, has_shield, attached_data)
	self._attached_data = attached_data
	if has_shield then
		self:enable_shield()
	end
	local ammo_amount = tweak_data.upgrades.sentry_gun_base_ammo * ammo_multiplier
	self._unit:weapon():set_ammo(ammo_amount)
	local armor_amount = tweak_data.upgrades.sentry_gun_base_armor * armor_multiplier
	self._unit:character_damage():set_health(armor_amount)
	self._owner = owner
	self._unit:movement():setup(rot_speed_multiplier)
	self._unit:brain():setup(1 / rot_speed_multiplier)
	local setup_data = {}
	setup_data.user_unit = self._owner
	setup_data.ignore_units = {
		self._unit,
		self._owner
	}
	setup_data.expend_ammo = true
	setup_data.autoaim = true
	setup_data.alert_AI = true
	setup_data.alert_filter = self._owner:movement():SO_access()
	setup_data.spread_mul = spread_multiplier
	self._unit:weapon():setup(setup_data, damage_multiplier)
	self._unit:set_extension_update_enabled(Idstring("base"), true)
	return true
end

function SentryGunBase:update(unit, t, dt)
	self:_check_body()
end

function SentryGunBase:_check_body()
	if self._attached_data.index == 1 then
		if not self._attached_data.body:enabled() then
			self._attached_data = self._attach(nil, nil, self._unit)
			if not self._attached_data then
				self:remove()
				return
			end
		end
	elseif self._attached_data.index == 2 then
		if not alive(self._attached_data.body) or not mrotation.equal(self._attached_data.rotation, self._attached_data.body:rotation()) then
			self._attached_data = self._attach(nil, nil, self._unit)
			if not self._attached_data then
				self:remove()
				return
			end
		end
	elseif self._attached_data.index == 3 and (not alive(self._attached_data.body) or mvector3.not_equal(self._attached_data.position, self._attached_data.body:position())) then
		self._attached_data = self._attach(nil, nil, self._unit)
		if not self._attached_data then
			self:remove()
			return
		end
	end
	self._attached_data.index = (self._attached_data.index < self._attached_data.max_index and self._attached_data.index or 0) + 1
end

function SentryGunBase:remove()
	self._removed = true
	self._unit:set_slot(0)
end

function SentryGunBase._attach(pos, rot, sentrygun_unit)
	pos = pos or sentrygun_unit:position()
	rot = rot or sentrygun_unit:rotation()
	local from_pos = pos + rot:z() * 10
	local to_pos = pos + rot:z() * -10
	local ray
	if sentrygun_unit then
		ray = sentrygun_unit:raycast("ray", from_pos, to_pos, "slot_mask", managers.slot:get_mask("world_geometry"))
	else
		ray = World:raycast("ray", from_pos, to_pos, "slot_mask", managers.slot:get_mask("world_geometry"))
	end
	if ray then
		local attached_data = {
			body = ray.body,
			position = ray.body:position(),
			rotation = ray.body:rotation(),
			index = 1,
			max_index = 3
		}
		return attached_data
	end
end

function SentryGunBase:set_visibility_state(stage)
	local state = stage and true
	if self._visibility_state ~= state then
		self._unit:set_visible(state)
		self._visibility_state = state
	end
	self._lod_stage = stage
end

function SentryGunBase:weapon_tweak_data()
	return tweak_data.weapon[self._unit:weapon()._name_id]
end

function SentryGunBase:on_death()
	self._unit:set_extension_update_enabled(Idstring("base"), false)
	if self._registered then
		self._registered = nil
		managers.groupai:state():unregister_criminal(self._unit)
	end
end

function SentryGunBase:enable_shield()
	self._has_shield = true
	self._unit:get_object(Idstring("g_shield")):set_visibility(true)
	self._unit:get_object(Idstring("s_shield")):set_visibility(true)
	self._unit:decal_surface():set_mesh_enabled(Idstring("dm_metal_shield"), true)
	self._unit:body("shield"):set_enabled(true)
end

function SentryGunBase:has_shield()
	return self._has_shield
end

function SentryGunBase:unregister()
	if self._registered then
		self._registered = nil
		managers.groupai:state():unregister_criminal(self._unit)
	end
end

function SentryGunBase:pre_destroy()
	SentryGunBase.super.pre_destroy(self, self._unit)
	self:unregister()
	self._removed = true
end
