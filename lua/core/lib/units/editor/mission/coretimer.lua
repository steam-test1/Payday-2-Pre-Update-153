CoreTimerUnitElement = CoreTimerUnitElement or class(MissionElement)
CoreTimerUnitElement.SAVE_UNIT_POSITION = false
CoreTimerUnitElement.SAVE_UNIT_ROTATION = false
CoreTimerUnitElement.INSTANCE_VAR_NAMES = {
	{type = "number", value = "timer"}
}
TimerUnitElement = TimerUnitElement or class(CoreTimerUnitElement)

function TimerUnitElement:init(...)
	TimerUnitElement.super.init(self, ...)
end

function CoreTimerUnitElement:init(unit)
	CoreTimerUnitElement.super.init(self, unit)
	self._digital_gui_units = {}
	self._hed.timer = 0
	self._hed.digital_gui_unit_ids = {}
	table.insert(self._save_values, "timer")
	table.insert(self._save_values, "digital_gui_unit_ids")
end

function CoreTimerUnitElement:layer_finished()
	MissionElement.layer_finished(self)
	for _, id in pairs(self._hed.digital_gui_unit_ids) do
		local unit = managers.worlddefinition:get_unit_on_load(id, callback(self, self, "load_unit"))
		if unit then
			self._digital_gui_units[unit:unit_data().unit_id] = unit
		end
	end
end

function CoreTimerUnitElement:load_unit(unit)
	if unit then
		self._digital_gui_units[unit:unit_data().unit_id] = unit
	end
end

function CoreTimerUnitElement:update_selected()
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

function CoreTimerUnitElement:update_unselected(t, dt, selected_unit, all_units)
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

function CoreTimerUnitElement:draw_links_unselected(...)
	CoreTimerUnitElement.super.draw_links_unselected(self, ...)
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

function CoreTimerUnitElement:update_editing()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit and ray.unit:digital_gui() and ray.unit:digital_gui():is_timer() then
		Application:draw(ray.unit, 0, 1, 0)
	end
end

function CoreTimerUnitElement:select_unit()
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

function CoreTimerUnitElement:_remove_unit(unit)
	self._digital_gui_units[unit:unit_data().unit_id] = nil
	table.delete(self._hed.digital_gui_unit_ids, unit:unit_data().unit_id)
end

function CoreTimerUnitElement:_add_unit(unit)
	self._digital_gui_units[unit:unit_data().unit_id] = unit
	table.insert(self._hed.digital_gui_unit_ids, unit:unit_data().unit_id)
end

function CoreTimerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "select_unit"))
end

function CoreTimerUnitElement:add_unit_list_btn()
	local function f(unit)
		if self._digital_gui_units[unit:unit_data().unit_id] then
			return false
		end
		return unit:digital_gui() and unit:digital_gui():is_timer()
	end
	
	local dialog = SelectUnitByNameModal:new("Add Unit", f)
	for _, unit in ipairs(dialog:selected_units()) do
		if not self._digital_gui_units[unit:unit_data().unit_id] then
			self:_add_unit(unit)
		end
	end
end

function CoreTimerUnitElement:remove_unit_list_btn()
	local function f(unit)
		return self._digital_gui_units[unit:unit_data().unit_id]
	end
	
	local dialog = SelectUnitByNameModal:new("Remove Unit", f)
	for _, unit in ipairs(dialog:selected_units()) do
		if self._digital_gui_units[unit:unit_data().unit_id] then
			self:_remove_unit(unit)
		end
	end
end

function CoreTimerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local timer_params = {
		name = "Timer:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.timer,
		floats = 1,
		tooltip = "Specifies how long time (in seconds) to wait before execute",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local timer = CoreEWS.number_controller(timer_params)
	timer:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = timer, value = "timer"})
	timer:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = timer, value = "timer"})
	self._btn_toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	self._btn_toolbar:add_tool("ADD_UNIT_LIST", "Add unit from unit list", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	self._btn_toolbar:connect("ADD_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "add_unit_list_btn"), nil)
	self._btn_toolbar:add_tool("REMOVE_UNIT_LIST", "Remove unit from unit list", CoreEws.image_path("toolbar\\delete_16x16.png"), nil)
	self._btn_toolbar:connect("REMOVE_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "remove_unit_list_btn"), nil)
	self._btn_toolbar:realize()
	panel_sizer:add(self._btn_toolbar, 0, 1, "EXPAND,LEFT")
	local help = {}
	help.text = "Creates a timer element. When the timer runs out, execute will be run. The timer element can be operated on using the logic_timer_operator"
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end

CoreTimerOperatorUnitElement = CoreTimerOperatorUnitElement or class(MissionElement)
TimerOperatorUnitElement = TimerOperatorUnitElement or class(CoreTimerOperatorUnitElement)

function TimerOperatorUnitElement:init(...)
	TimerOperatorUnitElement.super.init(self, ...)
end

function CoreTimerOperatorUnitElement:init(unit)
	CoreTimerOperatorUnitElement.super.init(self, unit)
	self._hed.operation = "none"
	self._hed.time = 0
	self._hed.elements = {}
	table.insert(self._save_values, "operation")
	table.insert(self._save_values, "time")
	table.insert(self._save_values, "elements")
end

function CoreTimerOperatorUnitElement:draw_links(t, dt, selected_unit, all_units)
	CoreTimerOperatorUnitElement.super.draw_links(self, t, dt, selected_unit)
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

function CoreTimerOperatorUnitElement:update_editing()
end

function CoreTimerOperatorUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring("core/units/mission_elements/logic_timer/logic_timer") then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function CoreTimerOperatorUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function CoreTimerOperatorUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function CoreTimerOperatorUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local operation_params = {
		name = "Operation:",
		panel = panel,
		sizer = panel_sizer,
		default = "none",
		options = {
			"pause",
			"start",
			"add_time",
			"subtract_time",
			"reset",
			"set_time"
		},
		value = self._hed.operation,
		tooltip = "Select an operation for the selected elements",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local operation = CoreEWS.combobox(operation_params)
	operation:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = operation, value = "operation"})
	local time_params = {
		name = "Time:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.time,
		floats = 1,
		tooltip = "Amount of time to add, subtract or set to the timers.",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local time = CoreEWS.number_controller(time_params)
	time:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = time, value = "time"})
	time:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = time, value = "time"})
	local help = {}
	help.text = "This element can modify logic_timer element. Select timers to modify using insert and clicking on the elements."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end

CoreTimerTriggerUnitElement = CoreTimerTriggerUnitElement or class(MissionElement)
TimerTriggerUnitElement = TimerTriggerUnitElement or class(CoreTimerTriggerUnitElement)

function TimerTriggerUnitElement:init(...)
	TimerTriggerUnitElement.super.init(self, ...)
end

function CoreTimerTriggerUnitElement:init(unit)
	CoreTimerTriggerUnitElement.super.init(self, unit)
	self._hed.time = 0
	self._hed.elements = {}
	table.insert(self._save_values, "time")
	table.insert(self._save_values, "elements")
end

function CoreTimerTriggerUnitElement:draw_links(t, dt, selected_unit, all_units)
	CoreTimerTriggerUnitElement.super.draw_links(self, t, dt, selected_unit)
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

function CoreTimerTriggerUnitElement:update_editing()
end

function CoreTimerTriggerUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring("core/units/mission_elements/logic_timer/logic_timer") then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function CoreTimerTriggerUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function CoreTimerTriggerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function CoreTimerTriggerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local time_params = {
		name = "Time:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.time,
		floats = 1,
		tooltip = "Specify how much time should be left on the timer to trigger.",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local time = CoreEWS.number_controller(time_params)
	time:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = time, value = "time"})
	time:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = time, value = "time"})
	local help = {}
	help.text = "This element is a trigger to logic_timer element."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
