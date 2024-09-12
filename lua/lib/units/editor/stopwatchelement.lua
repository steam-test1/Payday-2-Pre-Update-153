StopwatchUnitElement = StopwatchUnitElement or class(MissionElement)
StopwatchUnitElement.ELEMENT_NAME = "units/dev_tools/mission_elements/logic_stopwatch/logic_stopwatch"

function StopwatchUnitElement:init(unit)
	StopwatchUnitElement.super.init(self, unit)
	self._digital_gui_units = {}
	self._hed.timer = {0, 0}
	self._hed.digital_gui_unit_ids = {}
	table.insert(self._save_values, "timer")
	table.insert(self._save_values, "digital_gui_unit_ids")
end

function StopwatchUnitElement:layer_finished()
	MissionElement.layer_finished(self)
	for _, id in pairs(self._hed.digital_gui_unit_ids) do
		local unit = managers.worlddefinition:get_unit_on_load(id, callback(self, self, "load_unit"))
		if unit then
			self._digital_gui_units[unit:unit_data().unit_id] = unit
		end
	end
end

function StopwatchUnitElement:load_unit(unit)
	if unit then
		self._digital_gui_units[unit:unit_data().unit_id] = unit
	end
end

function StopwatchUnitElement:update_selected()
	for _, id in pairs(self._hed.digital_gui_unit_ids) do
		if not alive(self._digital_gui_units[id]) then
			table.delete(self._hed.digital_gui_unit_ids, id)
			self._digital_gui_units[id] = nil
		end
	end
	for id, unit in pairs(self._digital_gui_units) do
		if not alive(unit) then
			table.delete(self._hed.digital_gui_unit_ids, id)
			self._digital_gui_units[id] = nil
		else
			local params = {
				from_unit = self._unit,
				to_unit = unit,
				r = 0,
				g = 1,
				b = 0
			}
			self:_draw_link(params)
			Application:draw(unit, 0, 1, 0)
		end
	end
end

function StopwatchUnitElement:update_unselected(t, dt, selected_unit, all_units)
	for _, id in pairs(self._hed.digital_gui_unit_ids) do
		if not alive(self._digital_gui_units[id]) then
			table.delete(self._hed.digital_gui_unit_ids, id)
			self._digital_gui_units[id] = nil
		end
	end
	for id, unit in pairs(self._digital_gui_units) do
		if not alive(unit) then
			table.delete(self._hed.digital_gui_unit_ids, id)
			self._digital_gui_units[id] = nil
		end
	end
end

function StopwatchUnitElement:draw_links_unselected(...)
	StopwatchUnitElement.super.draw_links_unselected(self, ...)
	for id, unit in pairs(self._digital_gui_units) do
		local params = {
			from_unit = self._unit,
			to_unit = unit,
			r = 0,
			g = 0.5,
			b = 0
		}
		self:_draw_link(params)
		Application:draw(unit, 0, 0.5, 0)
	end
end

function StopwatchUnitElement:update_editing()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit and ray.unit:digital_gui() and ray.unit:digital_gui():is_timer() then
		Application:draw(ray.unit, 0, 1, 0)
	end
end

function StopwatchUnitElement:select_unit()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit and ray.unit:digital_gui() and ray.unit:digital_gui():is_timer() then
		local unit = ray.unit
		if self._digital_gui_units[unit:unit_data().unit_id] then
			self:_remove_unit(unit)
		else
			self:_add_unit(unit)
		end
	end
end

function StopwatchUnitElement:_remove_unit(unit)
	self._digital_gui_units[unit:unit_data().unit_id] = nil
	table.delete(self._hed.digital_gui_unit_ids, unit:unit_data().unit_id)
end

function StopwatchUnitElement:_add_unit(unit)
	self._digital_gui_units[unit:unit_data().unit_id] = unit
	table.insert(self._hed.digital_gui_unit_ids, unit:unit_data().unit_id)
end

function StopwatchUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "select_unit"))
end

function StopwatchUnitElement:_add_unit_filter(unit)
	if self._digital_gui_units[unit:unit_data().unit_id] then
		return false
	end
	return unit:digital_gui() and unit:digital_gui():is_timer()
end

function StopwatchUnitElement:_remove_unit_filter(unit)
	return self._digital_gui_units[unit:unit_data().unit_id]
end

function StopwatchUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self:_build_add_remove_static_unit_from_list(panel, panel_sizer, {
		add_filter = callback(self, self, "_add_unit_filter"),
		add_result = callback(self, self, "_add_unit"),
		remove_filter = callback(self, self, "_remove_unit_filter"),
		remove_result = callback(self, self, "_remove_unit")
	})
	self:_add_help_text("Creates a stopwatch element. Coutinuously counts up once started until stopped or paused. Can be operated on using the logic_stopwatch_operator. Can be displayed on a digital gui.")
end

StopwatchOperatorUnitElement = StopwatchOperatorUnitElement or class(MissionElement)
StopwatchOperatorUnitElement.RANDOMS = {"time"}
StopwatchOperatorUnitElement.LINK_ELEMENTS = {"elements"}

function StopwatchOperatorUnitElement:init(unit)
	StopwatchOperatorUnitElement.super.init(self, unit)
	self._hed.operation = "none"
	self._hed.save_key = ""
	self._hed.condition = "always"
	self._hed.time = {0, 0}
	self._hed.elements = {}
	table.insert(self._save_values, "operation")
	table.insert(self._save_values, "save_key")
	table.insert(self._save_values, "condition")
	table.insert(self._save_values, "time")
	table.insert(self._save_values, "elements")
end

function StopwatchOperatorUnitElement:draw_links(t, dt, selected_unit, all_units)
	StopwatchOperatorUnitElement.super.draw_links(self, t, dt, selected_unit)
	for _, id in ipairs(self._hed.elements) do
		local unit = all_units[id]
		local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
		if draw then
			self:_draw_link({
				from_unit = self._unit,
				to_unit = unit,
				r = 0.75,
				g = 0.75,
				b = 0.25
			})
		end
	end
end

function StopwatchOperatorUnitElement:get_links_to_unit(...)
	StopwatchOperatorUnitElement.super.get_links_to_unit(self, ...)
	self:_get_links_of_type_from_elements(self._hed.elements, "operator", ...)
end

function StopwatchOperatorUnitElement:update_editing()
end

function StopwatchOperatorUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring(StopwatchUnitElement.ELEMENT_NAME) then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function StopwatchOperatorUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function StopwatchOperatorUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local names = {
		"logic_stopwatch/logic_stopwatch"
	}
	self:_build_add_remove_unit_from_list(panel, panel_sizer, self._hed.elements, names)
	self:_build_value_combobox(panel, panel_sizer, "operation", {
		"none",
		"pause",
		"start",
		"add_time",
		"subtract_time",
		"reset",
		"set_time",
		"save_time",
		"load_time"
	}, "Select an operation for the selected elements")
	self:_build_value_random_number(panel, panel_sizer, "time", {floats = 1, min = 0}, "Amount of time to add, subtract or set to the stopwatch. Used as the default time if can not load the stopwatch.")
	local key_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(key_sizer, 0, 0, "EXPAND")
	local key_name = EWS:StaticText(panel, "Save/Load Key:", 0, "")
	key_sizer:add(key_name, 1, 0, "ALIGN_CENTER_VERTICAL")
	local key = EWS:TextCtrl(panel, self._hed.save_key, "", "TE_PROCESS_ENTER")
	key_sizer:add(key, 2, 0, "ALIGN_CENTER_VERTICAL")
	key:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = key, value = "save_key"})
	key:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = key, value = "save_key"})
	self:_build_value_combobox(panel, panel_sizer, "condition", {
		"always",
		"equal",
		"less_than",
		"greater_than",
		"less_or_equal",
		"greater_or_equal"
	}, "Select a condition for which the stopwatch value will be saved if a value for the stopwatch is already saved. eg. save if less than the saved value.", "Save Condition")
	self:_add_help_text("This element can modify logic_stopwatch element. Select stopwatch to modify using insert and clicking on the elements.")
end

StopwatchTriggerUnitElement = StopwatchTriggerUnitElement or class(MissionElement)
StopwatchTriggerUnitElement.LINK_ELEMENTS = {"elements"}

function StopwatchTriggerUnitElement:init(unit)
	StopwatchTriggerUnitElement.super.init(self, unit)
	self._hed.time = 0
	self._hed.elements = {}
	table.insert(self._save_values, "time")
	table.insert(self._save_values, "elements")
end

function StopwatchTriggerUnitElement:draw_links(t, dt, selected_unit, all_units)
	StopwatchTriggerUnitElement.super.draw_links(self, t, dt, selected_unit)
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

function StopwatchTriggerUnitElement:get_links_to_unit(...)
	StopwatchTriggerUnitElement.super.get_links_to_unit(self, ...)
	self:_get_links_of_type_from_elements(self._hed.elements, "trigger", ...)
end

function StopwatchTriggerUnitElement:update_editing()
end

function StopwatchTriggerUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit then
		if ray.unit:name() == Idstring(StopwatchUnitElement.ELEMENT_NAME) then
			local id = ray.unit:unit_data().unit_id
			if table.contains(self._hed.elements, id) then
				table.delete(self._hed.elements, id)
			else
				table.insert(self._hed.elements, id)
			end
		else
			self:add_on_executed(ray.unit)
		end
	end
end

function StopwatchTriggerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function StopwatchTriggerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local names = {
		"logic_stopwatch/logic_stopwatch"
	}
	self:_build_add_remove_unit_from_list(panel, panel_sizer, self._hed.elements, names)
	self:_build_value_number(panel, panel_sizer, "time", {floats = 1, min = 0}, "Specify at what time on the stopwatch this should trigger.")
	self:_add_help_text("This element is a trigger to logic_stopwatch element.")
end

StopwatchFilterUnitElement = StopwatchFilterUnitElement or class(MissionElement)
StopwatchFilterUnitElement.SAVE_UNIT_POSITION = false
StopwatchFilterUnitElement.SAVE_UNIT_ROTATION = false
StopwatchFilterUnitElement.LINK_ELEMENTS = {"elements"}

function StopwatchFilterUnitElement:init(unit)
	StopwatchFilterUnitElement.super.init(self, unit)
	self._hed.needed_to_execute = "all"
	self._hed.value = 0
	self._hed.elements = {}
	self._hed.check_type = "equal"
	table.insert(self._save_values, "needed_to_execute")
	table.insert(self._save_values, "value")
	table.insert(self._save_values, "elements")
	table.insert(self._save_values, "check_type")
end

function StopwatchFilterUnitElement:draw_links(t, dt, selected_unit, all_units)
	StopwatchFilterUnitElement.super.draw_links(self, t, dt, selected_unit)
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

function StopwatchFilterUnitElement:get_links_to_unit(...)
	StopwatchFilterUnitElement.super.get_links_to_unit(self, ...)
	self:_get_links_of_type_from_elements(self._hed.elements, "filter", ...)
end

function StopwatchFilterUnitElement:update_editing()
end

function StopwatchFilterUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring(StopwatchUnitElement.ELEMENT_NAME) then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function StopwatchFilterUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function StopwatchFilterUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local names = {
		"logic_counter/logic_counter"
	}
	self:_build_add_remove_unit_from_list(panel, panel_sizer, self._hed.elements, names)
	self:_build_value_combobox(panel, panel_sizer, "needed_to_execute", {"all", "any"}, "Select how many elements are needed to execute")
	self:_build_value_number(panel, panel_sizer, "value", {floats = 0}, "Specify value to trigger on.")
	self:_build_value_combobox(panel, panel_sizer, "check_type", {
		"equal",
		"less_than",
		"greater_than",
		"less_or_equal",
		"greater_or_equal"
	}, "Select which check operation to perform")
	self:_add_help_text("This element is a filter to logic_stopwatch element.")
end
