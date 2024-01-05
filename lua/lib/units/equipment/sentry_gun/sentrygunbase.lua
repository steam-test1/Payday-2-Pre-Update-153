SentryGunBase = SentryGunBase or class(UnitBase)

function SentryGunBase:init(unit)
	SentryGunBase.super.init(self, unit, false)
	self._unit = unit
	self._unit:sound_source():post_event("turret_place")
	if Network:is_client() then
		self._validate_clbk_id = "sentry_gun_validate" .. tostring(unit:key())
		managers.enemy:add_delayed_clbk(self._validate_clbk_id, callback(self, self, "_clbk_validate"), Application:time() + 60)
	end
end

function SentryGunBase:_clbk_validate()
	self._validate_clbk_id = nil
	if not self._was_dropin then
		local peer = managers.network:session():server_peer()
		managers.chat:feed_system_message(ChatManager.GAME, managers.localization:text("menu_chat_peer_cheated_many_assets", {
			name = peer:name()
		}))
		peer:mark_cheater()
	end
end

function SentryGunBase:sync_setup(upgrade_lvl, peer_id)
	if self._validate_clbk_id then
		managers.enemy:remove_delayed_clbk(self._validate_clbk_id)
		self._validate_clbk_id = nil
	end
	managers.player:verify_equipment(peer_id, "sentry_gun")
end

function SentryGunBase:post_init()
	self._registered = true
	managers.groupai:state():register_criminal(self._unit)
	if Network:is_client() then
		self._unit:brain():set_active(true)
	end
end

function SentryGunBase.spawn(owner, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, peer_id)
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
	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, 0, peer_id or 0)
	unit:base():setup(owner, ammo_multiplier, armor_multiplier, damage_multiplier, spread_multiplier, rot_speed_multiplier, has_shield, attached_data)
	unit:brain():set_active(true)
	SentryGunBase.deployed = (SentryGunBase.deployed or 0) + 1
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
	self._ammo_multiplier = ammo_multiplier
	self._armor_multiplier = armor_multiplier
	self._damage_multiplier = damage_multiplier
	self._spread_multiplier = spread_multiplier
	self._rot_speed_multiplier = rot_speed_multiplier
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
	self._unit:movement():set_team(owner:movement():team())
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

function SentryGunBase:get_owner()
	return self._owner
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

function SentryGunBase:check_interact_blocked(player)
	local result = not alive(self._unit) or self._unit:character_damage():dead() or self._unit:weapon():ammo_ratio() == 1 or not self:get_net_event_id(player) or false
	return result
end

function SentryGunBase:can_interact(player)
	return not self:check_interact_blocked(player)
end

function SentryGunBase:show_blocked_hint(interaction_tweak_data, player, skip_hint)
	print("SentryGunBase:show_blocked_hint", interaction_tweak_data, player, skip_hint)
	local event_id, wanted, possible = self:get_net_event_id(player)
	if self._unit:weapon():ammo_ratio() == 1 or not wanted then
		managers.hint:show_hint("hint_full_sentry_gun")
	else
		managers.hint:show_hint("hint_nea_sentry_gun")
	end
end

local refill_ratios = {
	1,
	0.9375,
	0.875,
	0.8125,
	0.75,
	0.6875,
	0.625,
	0.5625,
	0.5,
	0.4375,
	0.375,
	0.3125,
	0.25,
	0.1875,
	0.125,
	0.0625
}

function SentryGunBase:get_net_event_id(player)
	local sentry_gun_reload_ratio = tweak_data.upgrades.sentry_gun_reload_ratio or 1
	if sentry_gun_reload_ratio == 0 then
		return 1
	end
	local ammo_needed = 1 - self._unit:weapon():ammo_ratio()
	local ammo_got = 0
	local i = 0
	for id, weapon in pairs(player:inventory():available_selections()) do
		ammo_got = ammo_got + weapon.unit:base():get_ammo_ratio()
		i = i + 1
	end
	ammo_got = ammo_got / math.max(i, 1)
	local ammo_wanted = ammo_needed
	local wanted_event_id
	local index = 1
	repeat
		if not refill_ratios[index] then
			break
		elseif ammo_wanted >= refill_ratios[index] then
			wanted_event_id = index
		end
		index = index + 1
	until wanted_event_id
	local ammo_possible = ammo_got / sentry_gun_reload_ratio
	local possible_event_id
	local index = 1
	repeat
		if not refill_ratios[index] then
			break
		elseif ammo_possible >= refill_ratios[index] then
			possible_event_id = index
		end
		index = index + 1
	until possible_event_id
	local event_id = wanted_event_id and possible_event_id and math.max(wanted_event_id, possible_event_id)
	return event_id, wanted_event_id, possible_event_id
end

function SentryGunBase:interaction_text_id()
	return "debug_interact_sentry_gun_reload"
end

function SentryGunBase:add_string_macros(macroes)
	local event_id, wanted_event_id, possible_event_id = self:get_net_event_id(managers.player:local_player())
	macroes.AMMO = wanted_event_id and string.format("%2.f%%", (1 - refill_ratios[wanted_event_id]) * 100) or "100%"
end

function SentryGunBase:sync_net_event(event_id, peer)
	print("SentryGunBase:sync_net_event", event_id, inspect(peer), Network:is_server())
	local player = managers.network:game():member(peer:id()):unit()
	local ammo_ratio = refill_ratios[event_id]
	self:refill(ammo_ratio)
	if alive(player) and alive(managers.player:local_player()) and player:key() == managers.player:local_player():key() then
		local sentry_gun_reload_ratio = tweak_data.upgrades.sentry_gun_reload_ratio or 1
		if 0 < sentry_gun_reload_ratio then
			local ammo_reduction = ammo_ratio * sentry_gun_reload_ratio
			for id, weapon in pairs(player:inventory():available_selections()) do
				weapon.unit:base():reduce_ammo_by_procentage_of_total(ammo_reduction)
				managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
			end
		end
	end
end

function SentryGunBase:refill(ammo_ratio)
	if self._unit:character_damage():dead() then
		return
	end
	if Network:is_server() then
		local ammo_total = self._unit:weapon():ammo_total()
		local ammo_max = self._unit:weapon():ammo_max()
		self._unit:weapon():change_ammo(math.ceil(ammo_max * ammo_ratio))
	end
	self._unit:brain():switch_on()
	self._unit:interaction():set_dirty(true)
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

function SentryGunBase:register()
	self._registered = true
	managers.groupai:state():register_criminal(self._unit)
end

function SentryGunBase:load(save_data)
	self._was_dropin = true
end

function SentryGunBase:pre_destroy()
	SentryGunBase.super.pre_destroy(self, self._unit)
	self:unregister()
	self._removed = true
	if self._validate_clbk_id then
		managers.enemy:remove_delayed_clbk(self._validate_clbk_id)
		self._validate_clbk_id = nil
	end
end
