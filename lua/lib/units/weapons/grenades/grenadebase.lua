local tmp_vec3 = Vector3()
GrenadeBase = GrenadeBase or class(UnitBase)
GrenadeBase.types = {
	"frag",
	"launcher_frag"
}
GrenadeBase.EVENT_IDS = {detonate = 1}
GrenadeBase.time_cheat = {}

function GrenadeBase.server_throw_grenade(grenade_type, pos, dir, owner_peer_id)
	local grenade_entry = GrenadeBase.types[grenade_type]
	if not GrenadeBase.check_time_cheat(grenade_type, owner_peer_id) then
		return
	end
	local unit_name = Idstring(tweak_data.blackmarket.grenades[grenade_entry].unit)
	local unit = World:spawn_unit(unit_name, pos, Rotation(dir, math.UP))
	if owner_peer_id and managers.network:game() then
		local member = managers.network:game():member(owner_peer_id)
		local thrower_unit = member and member:unit()
		if alive(thrower_unit) then
			unit:base():set_thrower_unit(thrower_unit)
		end
	end
	unit:base():throw({dir = dir, grenade_entry = grenade_entry})
	managers.network:session():send_to_peers_synched("sync_throw_grenade", unit, dir, grenade_type, owner_peer_id or 0)
	if tweak_data.blackmarket.grenades[grenade_entry].impact_detonation then
		unit:damage():add_body_collision_callback(callback(unit:base(), unit:base(), "_impact_cbk"))
		unit:base():create_sweep_data()
	end
	return unit
end

function GrenadeBase.check_time_cheat(grenade_type, owner_peer_id)
	if not owner_peer_id then
		return true
	end
	local grenade_entry = GrenadeBase.types[grenade_type]
	if tweak_data.blackmarket.grenades[grenade_entry].time_cheat then
		GrenadeBase.time_cheat[grenade_type] = GrenadeBase.time_cheat[grenade_type] or {}
		if GrenadeBase.time_cheat[grenade_type][owner_peer_id] and GrenadeBase.time_cheat[grenade_type][owner_peer_id] > Application:time() then
			return false
		end
		GrenadeBase.time_cheat[grenade_type][owner_peer_id] = Application:time() + tweak_data.blackmarket.grenades[grenade_entry].time_cheat
	end
	return true
end

function GrenadeBase.spawn(unit_name, pos, rot)
	local unit = World:spawn_unit(Idstring(unit_name), pos, rot)
	return unit
end

function GrenadeBase:init(unit)
	UnitBase.init(self, unit, true)
	self._unit = unit
	self._damage_results = {}
	self._spawn_position = self._unit:position()
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

function GrenadeBase:set_grenade_entry(grenade_entry)
	self._grenade_entry = grenade_entry
end

function GrenadeBase:grenade_entry()
	return self._grenade_entry or GrenadeBase.types[1]
end

local mvec1 = Vector3()
local mvec2 = Vector3()

function GrenadeBase:add_damage_result(unit, is_dead, damage_percent)
	if not alive(self._thrower_unit) or self._thrower_unit ~= managers.player:player_unit() then
		return
	end
	local unit_type = unit:base()._tweak_table
	local is_civlian = unit:character_damage():_type_civilian(unit_type)
	local is_gangster = unit:character_damage():_type_gangster(unit_type)
	local is_cop = not is_civlian and not is_gangster
	if is_civlian then
		return
	end
	local weapon_id = tweak_data.blackmarket.grenades[self:grenade_entry()].weapon_id
	if weapon_id then
		managers.statistics:shot_fired({
			hit = true,
			name_id = weapon_id,
			skip_bullet_count = true
		})
	end
	table.insert(self._damage_results, is_dead)
	local hit_count = #self._damage_results
	local kill_count = 0
	for i, death in ipairs(self._damage_results) do
		kill_count = kill_count + (death and 1 or 0)
	end
	local count_pass, grenade_type_pass, kill_pass, distance_pass, enemy_pass, flying_strike_pass, all_pass
	for achievement, achievement_data in pairs(tweak_data.achievement.grenade_achievements) do
		count_pass = not achievement_data.count or (achievement_data.kill and kill_count or hit_count) >= achievement_data.count
		grenade_type_pass = not achievement_data.grenade_type or achievement_data.grenade_type == self._grenade_entry
		kill_pass = not achievement_data.kill or is_dead
		enemy_pass = not achievement_data.enemy or unit_type == achievement_data.enemy
		flying_strike_pass = not achievement_data.flying_strike
		if unit_type == "spooc" then
			local spooc_action = unit:movement()._active_actions[1]
			if spooc_action and spooc_action:type() == "spooc" and not flying_strike_pass then
				flying_strike_pass = spooc_action:is_flying_strike()
			end
		end
		distance_pass = not achievement_data.distance
		if not distance_pass then
			mvector3.set(mvec1, self._spawn_position)
			mvector3.set(mvec2, unit:position())
			local distance = mvector3.distance_sq(mvec1, mvec2)
			distance_pass = distance >= achievement_data.distance * achievement_data.distance
		end
		all_pass = count_pass and grenade_type_pass and kill_pass and distance_pass and enemy_pass and flying_strike_pass
		if all_pass then
			if achievement_data.stat then
				managers.achievment:award_progress(achievement_data.stat)
			elseif achievement_data.award then
				managers.achievment:award(achievement_data.award)
			end
		end
	end
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

function GrenadeBase:_impact_cbk()
	self:_detonate()
end

function GrenadeBase:create_sweep_data()
	self._sweep_data = {}
	self._sweep_data.current_pos = self._unit:position()
	self._sweep_data.last_pos = mvector3.copy(self._sweep_data.current_pos)
	self._sweep_data.slot_mask = managers.slot:get_mask("trip_mine_targets")
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

function GrenadeBase:throw(params)
	self._owner = params.owner
	local velocity = params.dir * 250
	velocity = Vector3(velocity.x, velocity.y, velocity.z + 50)
	local mass_look_up_modifier = self._mass_look_up_modifier or 2
	local mass = math.max(mass_look_up_modifier * (1 + math.min(0, params.dir.z)), 1)
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
		self:set_grenade_entry(params.grenade_entry)
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
			return
		end
	end
	if self._sweep_data then
		self._unit:m_position(self._sweep_data.current_pos)
		local col_ray = World:raycast("ray", self._sweep_data.last_pos, self._sweep_data.current_pos, "slot_mask", self._sweep_data.slot_mask)
		if col_ray and col_ray.unit then
			for i = 0, self._unit:num_bodies() - 1 do
				self._unit:body(i):set_keyframed()
			end
			mvector3.direction(mvec1, self._sweep_data.last_pos, self._sweep_data.current_pos)
			mvector3.multiply(mvec1, -10)
			mvector3.add(mvec1, col_ray.position)
			self._unit:set_position(mvec1)
			self._unit:set_position(mvec1)
			self:__detonate()
		end
		self._unit:m_position(self._sweep_data.last_pos)
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
