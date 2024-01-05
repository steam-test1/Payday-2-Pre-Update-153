PlayerStateUnitElement = PlayerStateUnitElement or class(MissionElement)

function PlayerStateUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.state = managers.player:default_player_state()
	self._hed.use_instigator = false
	table.insert(self._save_values, "state")
	table.insert(self._save_values, "use_instigator")
end

function PlayerStateUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local states_params = {
		name = "States:",
		panel = panel,
		sizer = panel_sizer,
		options = mixin_add(managers.player:player_states(), {
			"electrocution"
		}),
		value = self._hed.state,
		tooltip = "Select a state from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local states = CoreEWS.combobox(states_params)
	states:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = states, value = "state"})
	local use_instigator = EWS:CheckBox(panel, "On instigator", "")
	use_instigator:set_value(self._hed.use_instigator)
	use_instigator:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = use_instigator,
		value = "use_instigator"
	})
	panel_sizer:add(use_instigator, 0, 0, "EXPAND")
	local help = {}
	help.text = "Set the state the players should change to."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
