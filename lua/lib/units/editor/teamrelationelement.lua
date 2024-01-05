TeamRelationElement = TeamRelationElement or class(MissionElement)
TeamRelationElement.SAVE_UNIT_POSITION = false
TeamRelationElement.SAVE_UNIT_ROTATION = false

function TeamRelationElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.team1 = ""
	self._hed.team2 = ""
	self._hed.relation = "friend"
	self._hed.mutual = true
	table.insert(self._save_values, "team1")
	table.insert(self._save_values, "team2")
	table.insert(self._save_values, "relation")
	table.insert(self._save_values, "mutual")
end

function TeamRelationElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local mutual = EWS:CheckBox(panel, "mutual", "")
	mutual:set_value(self._hed.mutual)
	mutual:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {ctrlr = mutual, value = "mutual"})
	panel_sizer:add(mutual, 0, 0, "EXPAND")
	local team1_params = {
		name = "Team1:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.levels:get_team_names_indexed(),
		value = self._hed.team1,
		default = "",
		tooltip = "Select the team that will change attitude.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local team1_combo_box = CoreEWS.combobox(team1_params)
	team1_combo_box:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = team1_combo_box, value = "team1"})
	team1_combo_box:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = team1_combo_box, value = "team1"})
	local team2_params = {
		name = "Team2:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.levels:get_team_names_indexed(),
		value = self._hed.team2,
		default = "",
		tooltip = "Select the team that will change attitude.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local team2_combo_box = CoreEWS.combobox(team2_params)
	team2_combo_box:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = team2_combo_box, value = "team2"})
	team2_combo_box:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = team2_combo_box, value = "team2"})
	local relation_params = {
		name = "Relation:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"friend",
			"foe",
			"neutral"
		},
		value = self._hed.relation,
		default = "neutral",
		tooltip = "Select the new relation.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local relation_combo_box = CoreEWS.combobox(relation_params)
	relation_combo_box:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = relation_combo_box, value = "relation"})
	relation_combo_box:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = relation_combo_box, value = "relation"})
end
