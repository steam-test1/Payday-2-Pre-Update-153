ObjectiveUnitElement = ObjectiveUnitElement or class(MissionElement)

function ObjectiveUnitElement:init(unit)
	ObjectiveUnitElement.super.init(self, unit)
	self._hed.state = "activate"
	self._hed.objective = "none"
	self._hed.sub_objective = "none"
	self._hed.amount = 0
	table.insert(self._save_values, "state")
	table.insert(self._save_values, "objective")
	table.insert(self._save_values, "sub_objective")
	table.insert(self._save_values, "amount")
end

function ObjectiveUnitElement:update_sub_objectives()
	local sub_objectives = managers.objectives:sub_objectives_by_name(self._hed.objective)
	self._hed.sub_objective = "none"
	CoreEws.update_combobox_options(self._sub_objective_params, sub_objectives)
	CoreEws.change_combobox_value(self._sub_objective_params, self._hed.sub_objective)
end

function ObjectiveUnitElement:select_objective_btn(objective_params)
	local dialog = SelectNameModal:new("Select objective", managers.objectives:objectives_by_name())
	if dialog:cancelled() then
		return
	end
	for _, objective in ipairs(dialog:_selected_item_assets()) do
		self._hed.objective = objective
		CoreEws.change_combobox_value(objective_params, self._hed.objective)
	end
end

function ObjectiveUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local state_params = {
		name = "State:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"activate",
			"complete",
			"update",
			"remove"
		},
		value = self._hed.state,
		tooltip = "Select a state from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local state = CoreEWS.combobox(state_params)
	state:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = state, value = "state"})
	local objective_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(objective_sizer, 0, 1, "EXPAND,LEFT")
	local objective_params = {
		name = "Objective:",
		panel = panel,
		sizer = objective_sizer,
		options = managers.objectives:objectives_by_name(),
		value = self._hed.objective,
		default = "none",
		tooltip = "Select an objective from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local objective = CoreEWS.combobox(objective_params)
	objective:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = objective, value = "objective"})
	objective:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "update_sub_objectives"), nil)
	local toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	toolbar:add_tool("SELECT", "Select objective", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	toolbar:connect("SELECT", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "select_objective_btn"), objective_params)
	toolbar:realize()
	objective_sizer:add(toolbar, 0, 1, "EXPAND,LEFT")
	self._sub_objective_params = {
		name = "Sub objective:",
		panel = panel,
		sizer = panel_sizer,
		options = self._hed.objective ~= "none" and managers.objectives:sub_objectives_by_name(self._hed.objective) or {},
		value = self._hed.sub_objective,
		default = "none",
		tooltip = "Select a sub objective from the combobox (if availible)",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local sub_objective = CoreEWS.combobox(self._sub_objective_params)
	sub_objective:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = sub_objective,
		value = "sub_objective"
	})
	local amount_params = {
		name = "Amount:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.amount,
		floats = 0,
		tooltip = "Overrides objetive amount counter with this value.",
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
