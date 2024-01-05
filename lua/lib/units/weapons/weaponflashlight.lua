WeaponFlashLight = WeaponFlashLight or class(WeaponGadgetBase)
WeaponFlashLight.GADGET_TYPE = "flashlight"

function WeaponFlashLight:init(unit)
	WeaponFlashLight.super.init(self, unit)
	self._on_event = "gadget_flashlight_on"
	self._off_event = "gadget_flashlight_off"
	local obj = self._unit:get_object(Idstring("a_flashlight"))
	local is_haunted = managers.job and managers.job:current_job_id() == "haunted"
	self._g_light = self._unit:get_object(Idstring("g_light"))
	local texture = is_haunted and "units/lights/spot_light_projection_textures/spotprojection_21_flashlight_df" or "units/lights/spot_light_projection_textures/spotprojection_11_flashlight_df"
	self._light = World:create_light("spot|specular|plane_projection", texture)
	self._light:set_spot_angle_end(60)
	self._light:set_far_range(1000)
	self._light:set_multiplier(is_haunted and 2 or 2)
	if is_haunted then
		local blood = math.random() > 0.99
		local r = 255
		local g = blood and 200 or 255
		local b = 255
		self._light:set_color(Vector3(r, g, b) / 255)
	end
	self._light:link(obj)
	self._light:set_rotation(Rotation(obj:rotation():z(), -obj:rotation():x(), -obj:rotation():y()))
	self._light:set_enable(false)
	local effect_path = is_haunted and "effects/particles/weapons/flashlight_spooky/fp_flashlight" or "effects/particles/weapons/flashlight/fp_flashlight"
	self._light_effect = World:effect_manager():spawn({
		effect = Idstring(effect_path),
		parent = obj
	})
	World:effect_manager():set_hidden(self._light_effect, true)
end

function WeaponFlashLight:set_npc()
	if self._light_effect then
		World:effect_manager():kill(self._light_effect)
	end
	local obj = self._unit:get_object(Idstring("a_flashlight"))
	local is_haunted = managers.job and managers.job:current_job_id() == "haunted"
	local effect_path = is_haunted and "effects/particles/weapons/flashlight_spooky/flashlight" or "effects/particles/weapons/flashlight/flashlight"
	self._light_effect = World:effect_manager():spawn({
		effect = Idstring(effect_path),
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
