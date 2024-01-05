AiGlobalEventUnitElement = AiGlobalEventUnitElement or class(MissionElement)

function AiGlobalEventUnitElement:init(unit)
	AiGlobalEventUnitElement.super.init(self, unit)
	self._wave_modes = {
		"none",
		"assault",
		"besiege",
		"blockade",
		"hunt",
		"quiet",
		"passive"
	}
	self._AI_events = {
		"none",
		"police_called",
		"police_weapons_hot",
		"gangsters_called",
		"gangster_weapons_hot"
	}
	self._blames = {
		"none",
		"empty",
		"cop",
		"gangster",
		"civilian",
		"metal_detector",
		"security_camera",
		"civilian_alarm",
		"cop_alarm",
		"gangster_alarm",
		"motion_sensor"
	}
	self._hed.blame = "none"
	table.insert(self._save_values, "wave_mode")
	table.insert(self._save_values, "AI_event")
	table.insert(self._save_values, "blame")
end

function AiGlobalEventUnitElement:post_init()
	if self._hed.event then
		self._hed.wave_mode = self._hed.event
		self._hed.event = nil
	end
end

function AiGlobalEventUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local wave_mode_params = {
		name = "Wave Mode:",
		panel = panel,
		sizer = panel_sizer,
		options = self._wave_modes,
		value = self._hed.wave_mode,
		default = "none",
		tooltip = "Select a wave mode from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local wave_mode = CoreEWS.combobox(wave_mode_params)
	wave_mode:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = wave_mode, value = "wave_mode"})
	local ai_event_params = {
		name = "AI Event:",
		panel = panel,
		sizer = panel_sizer,
		options = self._AI_events,
		value = self._hed.AI_event,
		default = "none",
		tooltip = "Select an AI event from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local ai_event = CoreEWS.combobox(ai_event_params)
	ai_event:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = ai_event, value = "AI_event"})
	local blame_params = {
		name = "Blame:",
		panel = panel,
		sizer = panel_sizer,
		options = self._blames,
		value = self._hed.blame,
		tooltip = "Select a blame from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local blame_event = CoreEWS.combobox(blame_params)
	blame_event:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = blame_event, value = "blame"})
end
