UnitDamage = UnitDamage or class(CoreUnitDamage)
UnitDamage.COLLISION_SFX_QUITE_TIME = 0.3
UnitDamage.SFX_COLLISION_TAG = Idstring("sfx_only")

function UnitDamage:init(unit, ...)
	CoreUnitDamage.init(self, unit, ...)
	if self:can_play_collision_sfx() then
		self._collision_sfx_quite_time = self._collision_sfx_quite_time or UnitDamage.COLLISION_SFX_QUITE_TIME
		self:setup_sfx_collision_body_tags()
	end
end

function UnitDamage:setup_sfx_collision_body_tags()
	for i = 0, self._unit:num_bodies() - 1 do
		local body = self._unit:body(i)
		if not self:_has_body_collision_damage(body:name()) then
			body:set_collision_script_tag(self.SFX_COLLISION_TAG)
		end
	end
end

function UnitDamage:_has_body_collision_damage(body_name)
	for name, data in pairs(self._unit_element._bodies) do
		if Idstring(name) == body_name then
			return data._first_endurance.collision and true or false
		end
	end
	return false
end

function UnitDamage:can_play_collision_sfx()
	return self._collision_event ~= nil
end

function UnitDamage:set_play_collision_sfx_quite_time(quite_time)
	if self._collision_sfx_quite_time == nil ~= (quite_time == nil) and quite_time then
		self:setup_sfx_collision_body_tags()
	end
	self._collision_sfx_quite_time = quite_time
end

function UnitDamage:body_collision_callback(tag, unit, body, other_unit, other_body, position, normal, collision_velocity, velocity, other_velocity)
	if self._collision_sfx_quite_time ~= nil and other_body and body then
		local t = TimerManager:game():time()
		if not self._play_collision_sfx_time or t >= self._play_collision_sfx_time then
			self:play_collision_sfx(other_unit, position, normal, collision_velocity)
			self._play_collision_sfx_time = t + self._collision_sfx_quite_time
		end
	end
	if tag ~= self.SFX_COLLISION_TAG then
		CoreUnitDamage.body_collision_callback(self, tag, unit, body, other_unit, other_body, position, normal, collision_velocity, velocity, other_velocity)
	end
end

function UnitDamage:play_collision_sfx(other_unit, position, normal, collision_velocity)
	local ss = SoundDevice:create_source("collision")
	ss:set_position(position)
	ss:post_event(self._collision_event)
end

function UnitDamage:set_update_callback(func_name, ...)
	if func_name == "update_proximity_list" and not Network:is_server() and self._unit:id() ~= -1 then
		return
	end
	UnitDamage.super.set_update_callback(self, func_name, ...)
end
