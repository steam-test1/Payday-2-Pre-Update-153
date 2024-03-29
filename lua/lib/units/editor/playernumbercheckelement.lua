PlayerNumberCheckElement = PlayerNumberCheckElement or class(MissionElement)

function PlayerNumberCheckElement:init(unit)
	PlayerNumberCheckElement.super.init(self, unit)
	self._hed.num1 = true
	self._hed.num2 = true
	self._hed.num3 = true
	self._hed.num4 = true
	table.insert(self._save_values, "num1")
	table.insert(self._save_values, "num2")
	table.insert(self._save_values, "num3")
	table.insert(self._save_values, "num4")
end

function PlayerNumberCheckElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local num1 = EWS:CheckBox(panel, "1", "")
	num1:set_value(self._hed.num1)
	num1:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {ctrlr = num1, value = "num1"})
	panel_sizer:add(num1, 0, 0, "EXPAND")
	local num2 = EWS:CheckBox(panel, "2", "")
	num2:set_value(self._hed.num2)
	num2:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {ctrlr = num2, value = "num2"})
	panel_sizer:add(num2, 0, 0, "EXPAND")
	local num3 = EWS:CheckBox(panel, "3", "")
	num3:set_value(self._hed.num3)
	num3:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {ctrlr = num3, value = "num3"})
	panel_sizer:add(num3, 0, 0, "EXPAND")
	local num4 = EWS:CheckBox(panel, "4", "")
	num4:set_value(self._hed.num4)
	num4:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {ctrlr = num4, value = "num4"})
	panel_sizer:add(num4, 0, 0, "EXPAND")
	local help = {}
	help.text = "The element will only execute if the number of players is set to what you pick."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
