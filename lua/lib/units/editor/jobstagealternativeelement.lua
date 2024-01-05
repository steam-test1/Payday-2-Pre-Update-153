JobStageAlternativeUnitElement = JobStageAlternativeUnitElement or class(MissionElement)
JobStageAlternativeUnitElement.SAVE_UNIT_POSITION = false
JobStageAlternativeUnitElement.SAVE_UNIT_ROTATION = false

function JobStageAlternativeUnitElement:init(unit)
	JobStageAlternativeUnitElement.super.init(self, unit)
	self._hed.alternative = 1
	self._hed.interupt = "none"
	table.insert(self._save_values, "alternative")
	table.insert(self._save_values, "interupt")
end

function JobStageAlternativeUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local alternative_params = {
		name = "Alternative:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.alternative,
		floats = 0,
		tooltip = "Sets the next job stage alternative",
		min = 1,
		max = 4,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local alternative = CoreEWS.number_controller(alternative_params)
	alternative:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = alternative,
		value = "alternative"
	})
	alternative:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = alternative,
		value = "alternative"
	})
	local interupt_params = {
		name = "Escape level:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.levels.escape_levels,
		value = self._hed.interupt,
		default = "none",
		tooltip = "Select an escape level to be loaded between stages",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local interupt = CoreEWS.combobox(interupt_params)
	interupt:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = interupt, value = "interupt"})
end
