PrePlanningUnitElement = PrePlanningUnitElement or class(MissionElement)

function PrePlanningUnitElement:init(unit)
	PrePlanningUnitElement.super.init(self, unit)
	self._hed.allowed_types = {}
	self._hed.disables_types = {}
	self._hed.location_group = tweak_data.preplanning.location_groups[1]
	self._hed.upgrade_lock = "none"
	self._hed.dlc_lock = "none"
	table.insert(self._save_values, "allowed_types")
	table.insert(self._save_values, "disables_types")
	table.insert(self._save_values, "location_group")
	table.insert(self._save_values, "upgrade_lock")
	table.insert(self._save_values, "dlc_lock")
end

function PrePlanningUnitElement:_create_dynamic_on_executed_alternatives()
	PrePlanningUnitElement.ON_EXECUTED_ALTERNATIVES = {"any"}
	for _, type in ipairs(managers.preplanning:types()) do
		table.insert(PrePlanningUnitElement.ON_EXECUTED_ALTERNATIVES, type)
	end
end

function PrePlanningUnitElement:_data_updated(value_type, value)
	self._hed[value_type] = value
end

function PrePlanningUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local upgrade_lock_params = {
		name = "Upgrade Lock:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.preplanning.upgrade_locks,
		value = self._hed.upgrade_lock,
		tooltip = "Select a upgrade lock from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local upgrade_lock = CoreEWS.combobox(upgrade_lock_params)
	upgrade_lock:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = upgrade_lock,
		value = "upgrade_lock"
	})
	local dlc_lock_params = {
		name = "DLC Lock:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.preplanning.dlc_locks,
		value = self._hed.dlc_lock,
		tooltip = "Select a DLC lock from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local dlc_lock = CoreEWS.combobox(dlc_lock_params)
	dlc_lock:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = dlc_lock, value = "dlc_lock"})
	local location_group_params = {
		name = "Location group:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.preplanning.location_groups,
		value = self._hed.location_group,
		tooltip = "Select a location group from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local location_group = CoreEWS.combobox(location_group_params)
	location_group:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = location_group,
		value = "location_group"
	})
	local allowed_params = {
		name = "Allowed Types:",
		panel = panel,
		sizer = panel_sizer,
		options = managers.preplanning:types(),
		value = self._hed.allowed_types,
		tooltip = "Select allowed preplanning types for this point",
		updated_callback = callback(self, self, "_data_updated", "allowed_types")
	}
	CoreEws.list_selector(allowed_params)
	local disables_params = {
		name = "Disables Types:",
		panel = panel,
		sizer = panel_sizer,
		options = managers.preplanning:types(),
		value = self._hed.disables_types,
		tooltip = "Select preplanning types that are disabled if point is used",
		updated_callback = callback(self, self, "_data_updated", "disables_types")
	}
	CoreEws.list_selector(disables_params)
end
