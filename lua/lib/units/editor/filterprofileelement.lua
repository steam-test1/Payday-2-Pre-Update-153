FilterProfileUnitElement = FilterProfileUnitElement or class(MissionElement)

function FilterProfileUnitElement:init(unit)
	FilterProfileUnitElement.super.init(self, unit)
	self._hed.player_lvl = 0
	self._hed.money_earned = 0
	self._hed.money_offshore = 0
	self._hed.achievement = "none"
	table.insert(self._save_values, "player_lvl")
	table.insert(self._save_values, "money_earned")
	table.insert(self._save_values, "money_offshore")
	table.insert(self._save_values, "achievement")
end

function FilterProfileUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local player_lvl_params = {
		name = "Player lvl:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.player_lvl,
		floats = 0,
		tooltip = "Set player level filter",
		min = 0,
		max = 100,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local player_lvl = CoreEws.number_controller(player_lvl_params)
	player_lvl:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = player_lvl, value = "player_lvl"})
	player_lvl:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = player_lvl, value = "player_lvl"})
	local money_earned_params = {
		name = "Money Earned:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.money_earned,
		floats = 0,
		tooltip = "Set money earned filter, in thousands.",
		min = 0,
		max = 1000000,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local money_earned = CoreEws.number_controller(money_earned_params)
	money_earned:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = money_earned,
		value = "money_earned"
	})
	money_earned:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = money_earned,
		value = "money_earned"
	})
	local money_offshore_params = {
		name = "Money Offshore:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.money_offshore,
		floats = 0,
		tooltip = "Set money offshore filter, in thousands.",
		min = 0,
		max = 1000000,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local money_offshore = CoreEws.number_controller(money_offshore_params)
	money_offshore:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = money_offshore,
		value = "money_offshore"
	})
	money_offshore:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = money_offshore,
		value = "money_offshore"
	})
	local achievement_list = {}
	for ach, _ in pairs(managers.achievment.achievments) do
		table.insert(achievement_list, ach)
	end
	local achievement_params = {
		name = "Achievement:",
		panel = panel,
		sizer = panel_sizer,
		options = achievement_list,
		default = "none",
		value = self._hed.achievement,
		tooltip = "Select an achievement to award",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local achievement = CoreEws.combobox(achievement_params)
	achievement:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = achievement,
		value = "achievement"
	})
end
