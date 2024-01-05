CoreToggleUnitElement = CoreToggleUnitElement or class(MissionElement)
CoreToggleUnitElement.SAVE_UNIT_POSITION = false
CoreToggleUnitElement.SAVE_UNIT_ROTATION = false
ToggleUnitElement = ToggleUnitElement or class(CoreToggleUnitElement)

function ToggleUnitElement:init(...)
	CoreToggleUnitElement.init(self, ...)
end

function CoreToggleUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.toggle = "on"
	self._hed.set_trigger_times = -1
	self._hed.elements = {}
	table.insert(self._save_values, "toggle")
	table.insert(self._save_values, "elements")
	table.insert(self._save_values, "set_trigger_times")
end

function CoreToggleUnitElement:draw_links(t, dt, selected_unit, all_units)
	MissionElement.draw_links(self, t, dt, selected_unit)
	for _, id in ipairs(self._hed.elements) do
		local unit = all_units[id]
		local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
		if draw then
			self:_draw_link({
				from_unit = self._unit,
				to_unit = unit,
				r = 0.75,
				g = 0,
				b = 0
			})
		end
	end
end

function CoreToggleUnitElement:update_editing()
end

function CoreToggleUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function CoreToggleUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function CoreToggleUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function CoreToggleUnitElement:add_unit_list_btn()
	local script = self._unit:mission_element_data().script
	
	local function f(unit)
		if not unit:mission_element_data() or unit:mission_element_data().script ~= script then
			return
		end
		local id = unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			return false
		end
		return managers.editor:layer("Mission"):category_map()[unit:type():s()]
	end
	
	local dialog = SelectUnitByNameModal:new("Add Unit", f)
	for _, unit in ipairs(dialog:selected_units()) do
		local id = unit:unit_data().unit_id
		table.insert(self._hed.elements, id)
	end
end

function CoreToggleUnitElement:remove_unit_list_btn()
	local function f(unit)
		return table.contains(self._hed.elements, unit:unit_data().unit_id)
	end
	
	local dialog = SelectUnitByNameModal:new("Remove Unit", f)
	for _, unit in ipairs(dialog:selected_units()) do
		local id = unit:unit_data().unit_id
		table.delete(self._hed.elements, id)
	end
end

function CoreToggleUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local toggle_params = {
		name = "Toggle:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"on",
			"off",
			"toggle"
		},
		value = self._hed.toggle,
		tooltip = "Select how you want to toggle an element",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local toggle = CoreEWS.combobox(toggle_params)
	toggle:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = toggle, value = "toggle"})
	local set_trigger_times_params = {
		name = "Set trigger times:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.set_trigger_times,
		floats = 0,
		tooltip = "Sets the elements trigger times when toggle on (-1 means do not use)",
		min = -1,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local set_trigger_times = CoreEWS.number_controller(set_trigger_times_params)
	set_trigger_times:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = set_trigger_times,
		value = "set_trigger_times"
	})
	set_trigger_times:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = set_trigger_times,
		value = "set_trigger_times"
	})
	self._btn_toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	self._btn_toolbar:add_tool("ADD_UNIT_LIST", "Add unit from unit list", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	self._btn_toolbar:connect("ADD_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "add_unit_list_btn"), nil)
	self._btn_toolbar:add_tool("REMOVE_UNIT_LIST", "Remove unit from unit list", CoreEws.image_path("toolbar\\delete_16x16.png"), nil)
	self._btn_toolbar:connect("REMOVE_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "remove_unit_list_btn"), nil)
	self._btn_toolbar:realize()
	panel_sizer:add(self._btn_toolbar, 0, 1, "EXPAND,LEFT")
end
