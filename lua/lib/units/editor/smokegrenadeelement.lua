SmokeGrenadeElement = SmokeGrenadeElement or class(MissionElement)

function SmokeGrenadeElement:init(unit)
	SmokeGrenadeElement.super.init(self, unit)
	self._hed.duration = 15
	self._hed.immediate = false
	self._hed.ignore_control = false
	self._hed.effect_type = "smoke"
	table.insert(self._save_values, "duration")
	table.insert(self._save_values, "immediate")
	table.insert(self._save_values, "ignore_control")
	table.insert(self._save_values, "effect_type")
end

function SmokeGrenadeElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local duration_params = {
		name = "Duration (sec):",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.duration,
		floats = 0,
		tooltip = "Set the duration of the smoke grenade",
		min = 1,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local duration = CoreEWS.number_controller(duration_params)
	duration:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = duration, value = "duration"})
	duration:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = duration, value = "duration"})
	local immediate = EWS:CheckBox(panel, "Explode immediately", "")
	immediate:set_value(self._hed.immediate)
	immediate:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {ctrlr = immediate, value = "immediate"})
	panel_sizer:add(immediate, 0, 0, "EXPAND")
	local ignore_control = EWS:CheckBox(panel, "Ignore control/assault mode", "")
	ignore_control:set_value(self._hed.ignore_control)
	ignore_control:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = ignore_control,
		value = "ignore_control"
	})
	panel_sizer:add(ignore_control, 0, 0, "EXPAND")
	local effect_type_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(effect_type_sizer, 0, 1, "EXPAND,LEFT")
	local effect_type_params = {
		name = "Effect:",
		panel = panel,
		sizer = effect_type_sizer,
		options = {"smoke", "flash"},
		value = self._hed.effect_type,
		tooltip = "Select what type of effect will be spawned.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local effect_type_box = CoreEws.combobox(effect_type_params)
	effect_type_box:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = effect_type_box,
		value = "effect_type"
	})
	local help = {}
	help.text = "Spawns a smoke grenade."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
