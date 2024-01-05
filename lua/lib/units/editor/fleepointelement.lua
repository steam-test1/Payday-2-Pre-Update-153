FleePointElement = FleePointElement or class(MissionElement)
FleePointElement.SAVE_UNIT_ROTATION = false

function FleePointElement:init(unit)
	FleePointElement.super.init(self, unit)
	self._hed.functionality = "flee_point"
	table.insert(self._save_values, "functionality")
end

function FleePointElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local functionality_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(functionality_sizer, 0, 1, "EXPAND,LEFT")
	local functionality_names = {"flee_point", "loot_drop"}
	local functionality_params = {
		name = "Functionality:",
		panel = panel,
		sizer = functionality_sizer,
		options = functionality_names,
		value = self._hed.functionality,
		tooltip = "Select the functionality of the point.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local functionality_box = CoreEws.combobox(functionality_params)
	functionality_box:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = functionality_box,
		value = "functionality"
	})
end
