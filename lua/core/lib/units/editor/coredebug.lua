CoreDebugUnitElement = CoreDebugUnitElement or class(MissionElement)
DebugUnitElement = DebugUnitElement or class(CoreDebugUnitElement)
DebugUnitElement.SAVE_UNIT_POSITION = false
DebugUnitElement.SAVE_UNIT_ROTATION = false

function DebugUnitElement:init(...)
	CoreDebugUnitElement.init(self, ...)
end

function CoreDebugUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.debug_string = "none"
	self._hed.as_subtitle = false
	self._hed.show_instigator = false
	self._hed.color = nil
	table.insert(self._save_values, "debug_string")
	table.insert(self._save_values, "as_subtitle")
	table.insert(self._save_values, "show_instigator")
	table.insert(self._save_values, "color")
end

function CoreDebugUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local debug = EWS:TextCtrl(panel, self._hed.debug_string, "", "TE_PROCESS_ENTER")
	panel_sizer:add(debug, 0, 0, "EXPAND")
	debug:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = debug,
		value = "debug_string"
	})
	debug:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = debug,
		value = "debug_string"
	})
	local as_subtitle = EWS:CheckBox(panel, "Show as subtitle", "")
	as_subtitle:set_value(self._hed.as_subtitle)
	as_subtitle:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = as_subtitle,
		value = "as_subtitle"
	})
	panel_sizer:add(as_subtitle, 0, 0, "EXPAND")
	local show_instigator = EWS:CheckBox(panel, "Show instigator", "")
	show_instigator:set_value(self._hed.show_instigator)
	show_instigator:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = show_instigator,
		value = "show_instigator"
	})
	panel_sizer:add(show_instigator, 0, 0, "EXPAND")
end
