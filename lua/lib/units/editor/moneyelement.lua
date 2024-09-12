MoneyUnitElement = MoneyUnitElement or class(MissionElement)
MoneyUnitElement.actions = {
	"none",
	"AddOffshore",
	"DeductOffshore"
}

function MoneyUnitElement:init(unit)
	MoneyUnitElement.super.init(self, unit)
	self._hed.action = "none"
	self._hed.amount = 0
	self._hed.only_local_player = true
	table.insert(self._save_values, "action")
	table.insert(self._save_values, "amount")
	table.insert(self._save_values, "only_local_player")
end

function MoneyUnitElement:toggle_local_only()
	self._hed.only_local_player = self._toggle_local:get_value()
end

function MoneyUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self:_build_value_combobox(panel, panel_sizer, "action", MoneyUnitElement.actions, "Action")
	self:_build_value_number(panel, panel_sizer, "amount", {floats = false}, nil, "Amount")
	self._toggle_local = EWS:CheckBox(panel, "Execute only if local player is instigator", "tooltip test")
	self._toggle_local:connect("EVT_COMMAND_CHECKBOX_CLICKED", CoreEvent.callback(self, self, "toggle_local_only"))
	panel_sizer:add(self._toggle_local, 0, 1, "EXPAND,LEFT")
	self._toggle_local:set_value(self._hed.only_local_player)
	local help = {}
	help.text = [[
Used to add or deduct money from the player's offshore account.
Enable "only if local player is instigator" if the player activates this, instead of a mission script. ie. offshore gambling]]
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
