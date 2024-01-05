LootSecuredTriggerUnitElement = LootSecuredTriggerUnitElement or class(MissionElement)
LootSecuredTriggerUnitElement.SAVE_UNIT_POSITION = false
LootSecuredTriggerUnitElement.SAVE_UNIT_ROTATION = false

function LootSecuredTriggerUnitElement:init(unit)
	LootSecuredTriggerUnitElement.super.init(self, unit)
	self._hed.trigger_times = 1
	self._hed.amount = 0
	self._hed.include_instant_cash = false
	self._hed.report_only = false
	table.insert(self._save_values, "amount")
	table.insert(self._save_values, "include_instant_cash")
	table.insert(self._save_values, "report_only")
end

function LootSecuredTriggerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local amount_params = {
		name = "Amount:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.amount,
		floats = 0,
		tooltip = "Minimum amount of loot required to trigger",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local amount = CoreEWS.number_controller(amount_params)
	amount:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	amount:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	local include_instant_cash = EWS:CheckBox(panel, "Include instant cash", "")
	include_instant_cash:set_value(self._hed.include_instant_cash)
	include_instant_cash:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = include_instant_cash,
		value = "include_instant_cash"
	})
	panel_sizer:add(include_instant_cash, 0, 0, "EXPAND")
	local report_only = EWS:CheckBox(panel, "Report only", "")
	report_only:set_value(self._hed.report_only)
	report_only:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = report_only,
		value = "report_only"
	})
	panel_sizer:add(report_only, 0, 0, "EXPAND")
end
