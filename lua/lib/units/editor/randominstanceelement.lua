RandomInstanceElement = RandomInstanceElement or class(MissionElement)
RandomInstanceElement.SAVE_UNIT_POSITION = false
RandomInstanceElement.SAVE_UNIT_ROTATION = false
RandomInstanceElement.LINK_ELEMENTS = {"instances"}
RandomInstanceElement._type = "input"

function RandomInstanceElement:init(unit)
	RandomInstanceElement.super.init(self, unit)
	self._hed.amount = 1
	self._hed.amount_random = 0
	self._hed.instances = {}
	table.insert(self._save_values, "amount")
	table.insert(self._save_values, "amount_random")
	table.insert(self._save_values, "instances")
end

function RandomInstanceElement:update_editing()
end

function RandomInstanceElement:draw_links_selected(t, dt, selected_unit)
	RandomInstanceElement.super.draw_links_selected(self, t, dt, selected_unit)
	local instance_layer = managers.editor:layer("Instances")
	for i, instance_data in ipairs(self._hed.instances) do
		local inst_data = managers.world_instance:get_instance_data_by_name(instance_data.instance)
		if inst_data then
			local r, g, b = self:get_element_color()
			Application:draw_arrow(self._unit:position(), inst_data.position, r, g, b, 0.2)
			instance_layer:external_draw_instance(t, dt, instance_data.instance, r, g, b)
		else
			table.remove(self._hed.instances, i)
		end
	end
end

function RandomInstanceElement:draw_links_unselected(t, dt, selected_unit)
	RandomInstanceElement.super.draw_links_unselected(self, t, dt, selected_unit)
	local instance_layer = managers.editor:layer("Instances")
	for i, instance_data in ipairs(self._hed.instances) do
		local inst_data = managers.world_instance:get_instance_data_by_name(instance_data.instance)
		if inst_data then
			local r, g, b = self:get_element_color()
			Application:draw_arrow(self._unit:position(), inst_data.position, r * 0.8, g * 0.8, b * 0.8, 0.2)
		else
			table.remove(self._hed.instances, i)
		end
	end
end

function RandomInstanceElement:has_element(instance_name)
	for i, instance_data in ipairs(self._hed.instances) do
		if instance_data.instance == instance_name then
			return true
		end
	end
	return false
end

function RandomInstanceElement:add_element()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	local instance_name = ray and ray.unit and ray.unit:unit_data().instance
	if instance_name then
		if not self:has_element(instance_name) then
			local data = {instance = instance_name, event = ""}
			self:add_link_element("instances", data)
			self:_add_instance_item(data)
		else
			self:remove_element(instance_name)
		end
	end
end

function RandomInstanceElement:remove_element(instance_name)
	for i, instance_data in ipairs(self._hed.instances) do
		if instance_data.instance == instance_name then
			self:remove_link_element("instances", instance_data)
			self:_remove_instance_item(i)
			return
		end
	end
end

function RandomInstanceElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function RandomInstanceElement:_add_counter_filter(unit)
	return unit:name() == Idstring("core/units/mission_elements/logic_counter/logic_counter")
end

function RandomInstanceElement:_set_counter_id(unit)
	self._hed.counter_id = unit:unit_data().unit_id
end

function RandomInstanceElement:_remove_counter_filter(unit)
	return self._hed.counter_id == unit:unit_data().unit_id
end

function RandomInstanceElement:_remove_counter_id(unit)
	self._hed.counter_id = nil
end

function RandomInstanceElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self:_build_value_number(panel, panel_sizer, "amount", {floats = 0, min = 1}, "Specifies the amount of instances to be executed")
	self:_build_value_number(panel, panel_sizer, "amount_random", {floats = 0, min = 0}, "Add a random amount to amount")
	self:_add_help_text("Use 'Amount' only to specify an exact amount of instances to execute. Use 'Amount Random' to add a random amount to 'Amount' ('Amount' + random('Amount Random').")
	self._panel:layout()
	self._gui_items = self._gui_items or {}
	for i, instance_data in ipairs(self._hed.instances) do
		self:_add_instance_item(instance_data)
	end
end

function RandomInstanceElement:_get_events(instance_name)
	if self._type == "input" then
		return managers.world_instance:get_mission_inputs_by_name(instance_name)
	else
		return managers.world_instance:get_mission_outputs_by_name(instance_name)
	end
end

function RandomInstanceElement:_add_instance_item(data)
	local panel = self._panel
	local panel_sizer = self._panel_sizer
	local unit_id = EWS:StaticText(self._panel, data.instance, 0, "")
	self._panel_sizer:add(unit_id, 0, 0, "EXPAND")
	local h_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(h_sizer, 0, 1, "EXPAND,LEFT")
	local event_params = {
		name = "Event:",
		panel = panel,
		sizer = h_sizer,
		options = self:_get_events(data.instance),
		default = data.event or "none",
		value = data.event or "none",
		tooltip = "Select an instance event from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local event, text = CoreEws.combobox(event_params)
	event:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "_on_set_instance_event"), {event = event, data = data})
	local toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	toolbar:add_tool("SELECT", "Remove", CoreEws.image_path("toolbar\\delete_16x16.png"), nil)
	toolbar:connect("SELECT", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "remove_element"), data.instance)
	toolbar:realize()
	h_sizer:add(toolbar, 0, 1, "EXPAND,LEFT")
	self._panel:layout()
	table.insert(self._gui_items, {
		event = event,
		unit_id = unit_id,
		toolbar = toolbar,
		text = text
	})
	return #self._gui_items
end

function RandomInstanceElement:_on_set_instance_event(data)
	local event_combo = data.event
	data.data.event = event_combo:get_value()
end

function RandomInstanceElement:_remove_instance_item(idx)
	if self._gui_items[idx] then
		self._gui_items[idx].event:destroy()
		self._gui_items[idx].unit_id:destroy()
		self._gui_items[idx].toolbar:destroy()
		self._gui_items[idx].text:destroy()
		table.remove(self._gui_items, idx)
	end
	self._panel:layout()
end

RandomInstanceElementInputEvent = RandomInstanceElementInputEvent or class(RandomInstanceElement)
RandomInstanceElementInputEvent._type = "input"
RandomInstanceElementOutputEvent = RandomInstanceElementOutputEvent or class(RandomInstanceElement)
RandomInstanceElementOutputEvent._type = "output"
