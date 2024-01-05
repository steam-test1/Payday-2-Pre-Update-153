SlowMotionElement = SlowMotionElement or class(MissionElement)
SlowMotionElement.SAVE_UNIT_POSITION = false
SlowMotionElement.SAVE_UNIT_ROTATION = false

function SlowMotionElement:init(unit)
	SlowMotionElement.super.init(self, unit)
	self._hed.eff_name = ""
	table.insert(self._save_values, "eff_name")
end

function SlowMotionElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local eff_names_indexed = {}
	for id, data in pairs(tweak_data.timespeed.mission_effects) do
		table.insert(eff_names_indexed, id)
	end
	local eff_name_params = {
		name = "Effect:",
		panel = panel,
		sizer = panel_sizer,
		options = eff_names_indexed,
		value = self._hed.eff_name,
		tooltip = "Choose effect. Descriptions in lib/TimeSpeedEffectTweakData.lua.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local eff_name_combobox = CoreEWS.combobox(eff_name_params)
	eff_name_combobox:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = eff_name_combobox, value = "eff_name"})
end
