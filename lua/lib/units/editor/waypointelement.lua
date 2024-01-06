WaypointUnitElement = WaypointUnitElement or class(MissionElement)

function WaypointUnitElement:init(unit)
	WaypointUnitElement.super.init(self, unit)
	self:_add_wp_options()
	self._icon_options = {
		"pd2_lootdrop",
		"pd2_escape",
		"pd2_talk",
		"pd2_kill",
		"pd2_drill",
		"pd2_generic_look",
		"pd2_phone",
		"pd2_c4",
		"pd2_power",
		"pd2_door",
		"pd2_computer",
		"pd2_wirecutter",
		"pd2_fire",
		"pd2_loot",
		"pd2_methlab",
		"pd2_generic_interact",
		"pd2_goto",
		"pd2_ladder",
		"pd2_fix",
		"pd2_question"
	}
	self._hed.icon = "pd2_goto"
	self._hed.text_id = "debug_none"
	table.insert(self._save_values, "icon")
	table.insert(self._save_values, "text_id")
end

function WaypointUnitElement:_add_wp_options()
	self._text_options = {"debug_none"}
	for _, id_string in ipairs(managers.localization:ids("strings/system_text")) do
		local s = id_string:s()
		if string.find(s, "wp_") then
			table.insert(self._text_options, s)
		end
	end
end

function WaypointUnitElement:_set_text()
	self._text:set_value(managers.localization:text(self._hed.text_id))
end

function WaypointUnitElement:set_element_data(params, ...)
	WaypointUnitElement.super.set_element_data(self, params, ...)
	if params.value == "text_id" then
		self:_set_text()
	end
end

function WaypointUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self:_build_value_combobox(panel, panel_sizer, "icon", self._icon_options, "Select an icon")
	self:_build_value_combobox(panel, panel_sizer, "text_id", self._text_options, "Select a text id")
	local text_sizer = EWS:BoxSizer("HORIZONTAL")
	text_sizer:add(EWS:StaticText(panel, "Text: ", "", ""), 1, 2, "ALIGN_CENTER_VERTICAL,RIGHT,EXPAND")
	self._text = EWS:StaticText(panel, managers.localization:text(self._hed.text_id), "", "")
	text_sizer:add(self._text, 2, 2, "RIGHT,TOP,EXPAND")
	panel_sizer:add(text_sizer, 1, 0, "EXPAND")
end
