CoreRandomUnitElement = CoreRandomUnitElement or class(MissionElement)
CoreRandomUnitElement.SAVE_UNIT_POSITION = false
CoreRandomUnitElement.SAVE_UNIT_ROTATION = false
RandomUnitElement = RandomUnitElement or class(CoreRandomUnitElement)

function RandomUnitElement:init(...)
	CoreRandomUnitElement.init(self, ...)
end

function CoreRandomUnitElement:init(unit)
	CoreRandomUnitElement.super.init(self, unit)
	self._hed.amount = 1
	self._hed.ignore_disabled = false
	self._hed.counter_id = nil
	table.insert(self._save_values, "amount")
	table.insert(self._save_values, "ignore_disabled")
	table.insert(self._save_values, "counter_id")
end

function CoreRandomUnitElement:update_editing()
end

function CoreRandomUnitElement:draw_links(t, dt, selected_unit, all_units)
	CoreRandomUnitElement.super.draw_links(self, t, dt, selected_unit)
	if self._hed.counter_id then
		local unit = all_units[self._hed.counter_id]
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

function CoreRandomUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring("core/units/mission_elements/logic_counter/logic_counter") then
		local id = ray.unit:unit_data().unit_id
		if self._hed.counter_id == id then
			self._hed.counter_id = nil
		else
			self._hed.counter_id = id
		end
	end
end

function CoreRandomUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function CoreRandomUnitElement:remove_links(unit)
	if self._hed.counter_id and self._hed.counter_id == unit:unit_data().unit_id then
		self._hed.counter_id = nil
	end
end

function CoreRandomUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local amount_params = {
		name = "Amount:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.amount,
		floats = 0,
		tooltip = "Specifies how many times the counter should be executed before running its on executed",
		min = 1,
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local amount = CoreEWS.number_controller(amount_params)
	amount:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	amount:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	local ignore_disabled = EWS:CheckBox(panel, "Ignore disabled", "")
	ignore_disabled:set_value(self._hed.ignore_disabled)
	ignore_disabled:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = ignore_disabled,
		value = "ignore_disabled"
	})
	panel_sizer:add(ignore_disabled, 0, 0, "EXPAND")
end
