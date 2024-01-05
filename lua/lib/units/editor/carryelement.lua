CarryUnitElement = CarryUnitElement or class(MissionElement)
CarryUnitElement.SAVE_UNIT_POSITION = false
CarryUnitElement.SAVE_UNIT_ROTATION = false

function CarryUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.elements = {}
	self._hed.operation = "secure"
	self._hed.type_filter = "none"
	table.insert(self._save_values, "operation")
	table.insert(self._save_values, "type_filter")
end

function CarryUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local operation_params = {
		name = "Operation:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"remove",
			"freeze",
			"secure",
			"secure_silent",
			"add_to_respawn"
		},
		value = self._hed.operation,
		tooltip = "Select the operation to be performed.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local operation_box = CoreEWS.combobox(operation_params)
	operation_box:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "_set_operation"), {ctrlr = operation_box})
	local type_filter_params = {
		name = "Type filter:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.carry:get_carry_ids(),
		value = self._hed.type_filter,
		tooltip = "Selecta type filter to be used.",
		default = "none",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local type_filter = CoreEWS.combobox(type_filter_params)
	type_filter:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = type_filter,
		value = "type_filter"
	})
end

function CarryUnitElement:_set_operation(params)
	local value = params.ctrlr:get_value()
	self._hed.operation = value
end
