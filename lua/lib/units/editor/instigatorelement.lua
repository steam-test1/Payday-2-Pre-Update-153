InstigatorUnitElement = InstigatorUnitElement or class(MissionElement)
InstigatorUnitElement.SAVE_UNIT_POSITION = false
InstigatorUnitElement.SAVE_UNIT_ROTATION = false

function InstigatorUnitElement:init(unit)
	InstigatorUnitElement.super.init(self, unit)
end

function InstigatorUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local help = {}
	help.text = "This element is a storage for an instigator. It can be used, set, etc from logic_instigator_operator."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end

InstigatorOperatorUnitElement = InstigatorOperatorUnitElement or class(MissionElement)
InstigatorOperatorUnitElement.SAVE_UNIT_POSITION = false
InstigatorOperatorUnitElement.SAVE_UNIT_ROTATION = false

function InstigatorOperatorUnitElement:init(unit)
	InstigatorOperatorUnitElement.super.init(self, unit)
	self._hed.elements = {}
	self._hed.operation = "none"
	self._hed.keep_on_use = false
	table.insert(self._save_values, "elements")
	table.insert(self._save_values, "operation")
	table.insert(self._save_values, "keep_on_use")
end

function InstigatorOperatorUnitElement:draw_links(t, dt, selected_unit, all_units)
	InstigatorOperatorUnitElement.super.draw_links(self, t, dt, selected_unit)
	for _, id in ipairs(self._hed.elements) do
		local unit = all_units[id]
		local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
		if draw then
			self:_draw_link({
				from_unit = self._unit,
				to_unit = unit,
				r = 0.85,
				g = 0.85,
				b = 0.25
			})
		end
	end
end

function InstigatorOperatorUnitElement:update_editing()
end

function InstigatorOperatorUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring("units/dev_tools/mission_elements/logic_instigator/logic_instigator") then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function InstigatorOperatorUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function InstigatorOperatorUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function InstigatorOperatorUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local operation_params = {
		name = "Operation:",
		panel = panel,
		sizer = panel_sizer,
		default = "none",
		options = {
			"set",
			"clear",
			"add_first",
			"add_last",
			"use_first",
			"use_last",
			"use_random",
			"use_all"
		},
		value = self._hed.operation,
		tooltip = "Select an operation for the selected elements",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local operation = CoreEWS.combobox(operation_params)
	operation:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = operation, value = "operation"})
	local keep_on_use = EWS:CheckBox(panel, "Keep on use", "")
	keep_on_use:set_value(self._hed.keep_on_use)
	keep_on_use:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = keep_on_use,
		value = "keep_on_use"
	})
	panel_sizer:add(keep_on_use, 0, 0, "EXPAND")
	local help = {}
	help.text = "This element is an operator to logic_instigator element."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end

InstigatorTriggerUnitElement = InstigatorTriggerUnitElement or class(MissionElement)
InstigatorTriggerUnitElement.SAVE_UNIT_POSITION = false
InstigatorTriggerUnitElement.SAVE_UNIT_ROTATION = false

function InstigatorTriggerUnitElement:init(unit)
	InstigatorTriggerUnitElement.super.init(self, unit)
	self._hed.trigger_type = "set"
	self._hed.elements = {}
	table.insert(self._save_values, "trigger_type")
	table.insert(self._save_values, "elements")
end

function InstigatorTriggerUnitElement:draw_links(t, dt, selected_unit, all_units)
	InstigatorTriggerUnitElement.super.draw_links(self, t, dt, selected_unit)
	for _, id in ipairs(self._hed.elements) do
		local unit = all_units[id]
		local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
		if draw then
			self:_draw_link({
				from_unit = unit,
				to_unit = self._unit,
				r = 0.85,
				g = 0.85,
				b = 0.25
			})
		end
	end
end

function InstigatorTriggerUnitElement:update_editing()
end

function InstigatorTriggerUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring("units/dev_tools/mission_elements/logic_instigator/logic_instigator") then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function InstigatorTriggerUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function InstigatorTriggerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function InstigatorTriggerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local trigger_type_params = {
		name = "Trigger Type:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"death",
			"set",
			"changed",
			"cleared"
		},
		value = self._hed.trigger_type,
		tooltip = "Select a trigger type for the selected elements",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local trigger_type = CoreEWS.combobox(trigger_type_params)
	trigger_type:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = trigger_type,
		value = "trigger_type"
	})
	local help = {}
	help.text = "This element is a trigger to logic_instigator element."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
