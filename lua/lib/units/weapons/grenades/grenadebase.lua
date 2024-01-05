local tmp_vec3 = Vector3()
GrenadeBase = GrenadeBase or class(UnitBase)
GrenadeBase.types = {
	Idstring("units/weapons/frag_grenade/frag_grenade")
}
GrenadeBase.EVENT_IDS = {detonate = 1}

function GrenadeBase.server_throw_grenade(grenade_type, pos, dir)
	local unit = World:spawn_unit(GrenadeBase.types[grenade_type], pos, Rotation())
	unit:base():throw({dir = dir})
	managers.network:session():send_to_peers_synched("sync_throw_grenade", unit, dir)
end

function GrenadeBase.spawn(unit_name, pos, rot)
	local unit = World:spawn_unit(Idstring(unit_name), pos, rot)
	return unit
end

function GrenadeBase:init(unit)
	UnitBase.init(self, unit, true)
	self._unit = unit
	if not Network:is_server() then
		return
	end
	self:_setup()
end

function GrenadeBase:_setup()
	self._slotmask = managers.slot:get_mask("trip_mine_targets")
	self._timer = self._init_timer or 3
end

function GrenadeBase:set_active(active)
	self._active = active
	self._unit:set_extension_update_enabled(Idstring("base"), self._active)
end

function GrenadeBase:active()
	return self._active
end

function GrenadeBase:_detect_and_give_dmg(hit_pos)
	local params = {}
	params.hit_pos = hit_pos
	params.collision_slotmask = self._collision_slotmask
	params.user = self._user
	params.damage = self._damage
	params.player_damage = self._player_damage or self._damage
	params.range = self._range
	params.ignore_unit = self._ignore_unit
	params.curve_pow = self._curve_pow
	params.col_ray = self._col_ray
	params.alert_filter = self._alert_filter
	params.owner = self._owner
	local hit_units, splinters = managers.explosion:detect_and_give_dmg(params)
	return hit_units, splinters
end

function GrenadeBase._explode_on_client(position, normal, user_unit, dmg, range, curve_pow, custom_params)
	managers.explosion:play_sound_and_effects(position, normal, range, custom_params)
	managers.explosion:client_damage_and_push(position, normal, user_unit, dmg, range, curve_pow)
end

function GrenadeBase._play_sound_and_effects(position, normal, range, custom_params)
	managers.explosion:play_sound_and_effects(position, normal, range, custom_params)
end

function GrenadeBase._dispose_of_sound(...)
end

function GrenadeBase:sync_throw_grenade(dir)
	self:throw({dir = dir})
end

function GrenadeBase:throw(params)
	self._owner = params.owner
	local velocity = params.dir * 250
	velocity = Vector3(velocity.x, velocity.y, velocity.z + 50)
	local mass = math.max(2 * (1 + math.min(0, params.dir.z)), 1)
	self._unit:push_at(mass, velocity, self._unit:position())
end

function GrenadeBase:_bounce(...)
	print("_bounce", ...)
end

function GrenadeBase:update(unit, t, dt)
	if self._timer then
		self._timer = self._timer - dt
		if self._timer <= 0 then
			self._timer = nil
			self:__detonate()
		end
	end
end

function GrenadeBase:detonate()
	if not self._active then
		return
	end
end

function GrenadeBase:__detonate()
	if not self._owner then
	end
	self:_detonate()
end

function GrenadeBase:_detonate()
	print("no _detonate function for grenade")
end

function GrenadeBase:_detonate_on_client()
	print("no _detonate_on_client function for grenade")
end

function GrenadeBase:sync_net_event(event_id)
	if event_id == GrenadeBase.EVENT_IDS.detonate then
		self:_detonate_on_client()
	end
end

function GrenadeBase:save(data)
	local state = {}
	state.timer = self._timer
	data.GrenadeBase = state
end

function GrenadeBase:load(data)
	local state = data.GrenadeBase
	self._timer = state.timer
end

function GrenadeBase:destroy()
end
