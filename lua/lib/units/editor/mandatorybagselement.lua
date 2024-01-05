MandatoryBagsUnitElement = MandatoryBagsUnitElement or class(MissionElement)
MandatoryBagsUnitElement.SAVE_UNIT_POSITION = false
MandatoryBagsUnitElement.SAVE_UNIT_ROTATION = false

function MandatoryBagsUnitElement:init(unit)
	MandatoryBagsUnitElement.super.init(self, unit)
	self._hed.carry_id = "none"
	self._hed.amount = 0
	table.insert(self._save_values, "carry_id")
	table.insert(self._save_values, "amount")
end

function MandatoryBagsUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	tweak_data.carry:get_carry_ids()
	local carry_id_params = {
		name = "Carry id:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.carry:get_carry_ids(),
		value = self._hed.carry_id,
		default = "none",
		tooltip = "Select a carry_id to be mandatory.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local carry_id = CoreEWS.combobox(carry_id_params)
	carry_id:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = carry_id, value = "carry_id"})
	local amount_params = {
		name = "Amount:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.amount,
		floats = 0,
		tooltip = "Amount of mandatory bags.",
		min = 0,
		max = 100,
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local amount = CoreEWS.number_controller(amount_params)
	amount:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	amount:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
end
