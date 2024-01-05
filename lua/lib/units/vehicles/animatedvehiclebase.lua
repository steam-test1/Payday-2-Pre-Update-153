AnimatedVehicleBase = AnimatedVehicleBase or class(UnitBase)

function AnimatedVehicleBase:init(unit)
	AnimatedVehicleBase.super.init(self, unit, false)
	self._unit = unit
	self:_set_anim_lod(0)
	self._body_name = self._body_name or "a_body"
end

function AnimatedVehicleBase:update(unit, t, dt)
	local new_pos = self._obj_com:position()
	if new_pos ~= self._last_pos and alive(self._listener_obj) then
		local new_vel = new_pos - self._last_pos
		mvector3.divide(new_vel, dt)
		self._last_pos = new_pos
		local listener_pos = self._listener_obj:position()
		local listener_vec = listener_pos - new_pos
		local listener_dis = mvector3.normalize(listener_vec)
		local vel_dot = mvector3.dot(listener_vec, new_vel)
		vel_dot = math.clamp(vel_dot / 15000, -1, 1)
		self._sound_source:set_rtpc("vel_to_listener", vel_dot)
		self:_set_anim_lod(listener_dis)
	end
end

function AnimatedVehicleBase:_set_anim_lod(dis)
	if 9000 < dis then
		if self._lod_high then
			self._lod_high = false
			self._unit:set_animation_lod(2, 0, 0, 0)
		end
	elseif dis < 8000 and not self._lod_high then
		self._lod_high = true
		self._unit:set_animation_lod(1, 1000000, 1000000, 1000000)
	end
end

function AnimatedVehicleBase:start_doppler()
	self:set_enabled(true)
	self._obj_com = self._unit:get_object(Idstring(self._body_name))
	self._last_pos = self._obj_com:position()
	self._listener_obj = managers.listener:active_listener_obj()
	self._sound_source = self._unit:sound_source()
end

function AnimatedVehicleBase:stop_doppler()
	self:set_enabled(false)
	self._listener_obj = nil
	self._sound_source = nil
end

function AnimatedVehicleBase:set_enabled(state)
	if state then
		if self._ext_enabled_count then
			self._ext_enabled_count = self._ext_enabled_count + 1
		else
			self._ext_enabled_count = 1
			self._unit:set_extension_update_enabled(Idstring("base"), true)
		end
	elseif self._ext_enabled_count and self._ext_enabled_count > 1 then
		self._ext_enabled_count = self._ext_enabled_count - 1
	else
		self._ext_enabled_count = nil
		self._unit:set_extension_update_enabled(Idstring("base"), false)
	end
end

function AnimatedVehicleBase:anim_clbk_empty_full_blend(unit)
	self:stop_doppler()
	if not Application:editor() then
		unit:set_animations_enabled(false)
	end
end

function AnimatedVehicleBase:anim_clbk_empty_exit(unit)
	self:start_doppler()
	unit:set_animations_enabled(true)
end

function AnimatedVehicleBase:anim_clbk_animated_driving(unit, state)
	if state and self._driving ~= "animation" then
		self._unit:set_driving("animation")
		self._driving = "animation"
	elseif not state and self._driving ~= "orientation_object" then
		self._unit:set_driving("orientation_object")
		self._driving = "orientation_object"
	end
end
