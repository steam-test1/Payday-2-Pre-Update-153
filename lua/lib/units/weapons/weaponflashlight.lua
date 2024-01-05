WeaponFlashLight = WeaponFlashLight or class(WeaponGadgetBase)

function WeaponFlashLight:init(unit)
	WeaponFlashLight.super.init(self, unit)
	self._on_event = "gadget_flashlight_on"
	self._off_event = "gadget_flashlight_off"
	local obj = self._unit:get_object(Idstring("a_flashlight"))
	self._g_light = self._unit:get_object(Idstring("g_light"))
	self._light = World:create_light("spot|specular|plane_projection", "units/lights/spot_light_projection_textures/spotprojection_11_flashlight_df")
	self._light:set_spot_angle_end(60)
	self._light:set_far_range(1000)
	self._light:set_multiplier(2)
	self._light:link(obj)
	self._light:set_rotation(Rotation(obj:rotation():z(), -obj:rotation():x(), -obj:rotation():y()))
	self._light:set_enable(false)
	self._light_effect = World:effect_manager():spawn({
		effect = Idstring("effects/particles/weapons/flashlight/fp_flashlight"),
		parent = obj
	})
	World:effect_manager():set_hidden(self._light_effect, true)
end

function WeaponFlashLight:set_npc()
	if self._light_effect then
		World:effect_manager():kill(self._light_effect)
	end
	local obj = self._unit:get_object(Idstring("a_flashlight"))
	self._light_effect = World:effect_manager():spawn({
		effect = Idstring("effects/particles/weapons/flashlight/flashlight"),
		parent = obj
	})
	World:effect_manager():set_hidden(self._light_effect, true)
end

function WeaponFlashLight:_check_state()
	WeaponFlashLight.super._check_state(self)
	self._light:set_enable(self._on)
	self._g_light:set_visibility(self._on)
	World:effect_manager():set_hidden(self._light_effect, not self._on)
end

function WeaponFlashLight:destroy(unit)
	WeaponFlashLight.super.destroy(self, unit)
	if alive(self._light) then
		World:delete_light(self._light)
	end
	if self._light_effect then
		World:effect_manager():kill(self._light_effect)
		self._light_effect = nil
	end
end
