local tmp_vec3 = Vector3()
GrenadeBase = GrenadeBase or class(UnitBase)
GrenadeBase.types = {"frag"}
GrenadeBase.EVENT_IDS = {detonate = 1}

function GrenadeBase.server_throw_grenade(grenade_type, pos, dir, owner_peer_id)
	local grenade_entry = GrenadeBase.types[grenade_type]
	local unit_name = Idstring(tweak_data.blackmarket.grenades[grenade_entry].unit)
	local unit = World:spawn_unit(unit_name, pos, Rotation())
	if owner_peer_id and managers.network:game() then
		local member = managers.network:game():member(owner_peer_id)
		local thrower_unit = member and member:unit()
		if alive(thrower_unit) then
			unit:base():set_thrower_unit(thrower_unit)
		end
	end
	unit:base():throw({dir = dir, grenade_entry = grenade_entry})
	managers.network:session():send_to_peers_synched("sync_throw_grenade", unit, dir, grenade_type, owner_peer_id or 0)
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

function GrenadeBase:set_thrower_unit(unit)
	self._thrower_unit = unit
end

function GrenadeBase:thrower_unit()
	return alive(self._thrower_unit) and self._thrower_unit or nil
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

function GrenadeBase:sync_throw_grenade(dir, grenade_type)
	local grenade_entry = GrenadeBase.types[grenade_type]
	self:throw({dir = dir, grenade_entry = grenade_entry})
end

local mvec1 = Vector3()

function GrenadeBase:throw(params)
	self._owner = params.owner
	local velocity = params.dir * 250
	velocity = Vector3(velocity.x, velocity.y, velocity.z + 50)
	local mass = math.max(2 * (1 + math.min(0, params.dir.z)), 1)
	self._unit:push_at(mass, velocity, self._unit:position())
	if params.grenade_entry then
		local unit_name = tweak_data.blackmarket.grenades[params.grenade_entry].sprint_unit
		if unit_name then
			local sprint = World:spawn_unit(Idstring(unit_name), self._unit:position(), self._unit:rotation())
			local rot = Rotation(params.dir, math.UP)
			mrotation.x(rot, mvec1)
			mvector3.multiply(mvec1, 0.25)
			mvector3.add(mvec1, params.dir)
			mvector3.add(mvec1, math.UP / 2)
			mvector3.multiply(mvec1, 100)
			sprint:push_at(mass, mvec1, sprint:position())
		end
	end
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
