SpawnGrenadeUnitElement = SpawnGrenadeUnitElement or class(MissionElement)

function SpawnGrenadeUnitElement:init(unit)
	SpawnGrenadeUnitElement.super.init(self, unit)
	self._hed.grenade_type = "frag"
	self._hed.spawn_dir = Vector3(0, 0, 1)
	self._hed.strength = 1
	table.insert(self._save_values, "grenade_type")
	table.insert(self._save_values, "spawn_dir")
	table.insert(self._save_values, "strength")
end

function SpawnGrenadeUnitElement:test_element()
	if self._hed.grenade_type == "frag" then
		GrenadeBase.server_throw_grenade(1, self._unit:position(), self._hed.spawn_dir * self._hed.strength)
	end
end

function SpawnGrenadeUnitElement:update_selected(time, rel_time)
	Application:draw_arrow(self._unit:position(), self._unit:position() + self._hed.spawn_dir * 35, 0.75, 0.75, 0.75, 0.075)
end

function SpawnGrenadeUnitElement:update_editing(time, rel_time)
	local kb = Input:keyboard()
	local speed = 60 * rel_time
	if kb:down(Idstring("left")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(speed, 0, 0))
	end
	if kb:down(Idstring("right")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(-speed, 0, 0))
	end
	if kb:down(Idstring("up")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(0, 0, speed))
	end
	if kb:down(Idstring("down")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(0, 0, -speed))
	end
	local from = self._unit:position()
	local to = from + self._hed.spawn_dir * 100000
	local ray = managers.editor:unit_by_raycast({
		from = from,
		to = to,
		mask = managers.slot:get_mask("statics_layer")
	})
	if ray and ray.unit then
		Application:draw_sphere(ray.position, 25, 1, 0, 0)
	end
end

function SpawnGrenadeUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local options = {}
	for grenade_name, _ in pairs(tweak_data.blackmarket.grenades) do
		table.insert(options, grenade_name)
	end
	local grenade_type_params = {
		name = "Grenade:",
		panel = panel,
		sizer = panel_sizer,
		options = options,
		value = self._hed.grenade_type,
		tooltip = "Select what type of grenade will be spawned.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local grenade_type = CoreEws.combobox(grenade_type_params)
	grenade_type:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = grenade_type,
		value = "grenade_type"
	})
	local strength_params = {
		name = "Strength:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.strength,
		floats = 1,
		tooltip = "Use this to add a strength to a physic push on the spawned grenade",
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local strength = CoreEWS.number_controller(strength_params)
	strength:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = strength, value = "strength"})
	strength:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = strength, value = "strength "})
	local help = {}
	help.text = "Spawns a grenade."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
