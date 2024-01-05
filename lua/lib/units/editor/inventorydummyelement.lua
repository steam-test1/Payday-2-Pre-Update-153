InventoryDummyUnitElement = InventoryDummyUnitElement or class(MissionElement)

function InventoryDummyUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.category = "none"
	self._hed.slot = 1
	table.insert(self._save_values, "category")
	table.insert(self._save_values, "slot")
end

function InventoryDummyUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local category_params = {
		name = "Category:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"secondaries",
			"primaries",
			"masks"
		},
		value = self._hed.category,
		default = "none",
		tooltip = "Select a crafted category.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local category = CoreEWS.combobox(category_params)
	category:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = category, value = "category"})
	local slot_params = {
		name = "Slot:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.slot,
		floats = 0,
		tooltip = "Set inventory slot to spawn",
		min = 1,
		max = 9,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local slot = CoreEWS.number_controller(slot_params)
	slot:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = slot, value = "slot"})
	slot:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = slot, value = "slot"})
end
