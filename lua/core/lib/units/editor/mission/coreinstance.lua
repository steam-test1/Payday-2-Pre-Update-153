CoreInstanceInputUnitElement = CoreInstanceInputUnitElement or class(MissionElement)
InstanceInputUnitElement = InstanceInputUnitElement or class(CoreInstanceInputUnitElement)
InstanceInputUnitElement.SAVE_UNIT_POSITION = false
InstanceInputUnitElement.SAVE_UNIT_ROTATION = false

function InstanceInputUnitElement:init(...)
	InstanceInputUnitElement.super.init(self, ...)
	self._hed.event = "none"
	table.insert(self._save_values, "event")
end

function InstanceInputUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local event = EWS:TextCtrl(panel, self._hed.event, "", "TE_PROCESS_ENTER")
	panel_sizer:add(event, 0, 0, "EXPAND")
	event:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = event, value = "event"})
	event:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = event, value = "event"})
end

CoreInstanceOutputUnitElement = CoreInstanceOutputUnitElement or class(MissionElement)
InstanceOutputUnitElement = InstanceOutputUnitElement or class(CoreInstanceOutputUnitElement)
InstanceOutputUnitElement.SAVE_UNIT_POSITION = false
InstanceOutputUnitElement.SAVE_UNIT_ROTATION = false

function InstanceOutputUnitElement:init(...)
	InstanceOutputUnitElement.super.init(self, ...)
	self._hed.event = "none"
	table.insert(self._save_values, "event")
end

function InstanceOutputUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local event = EWS:TextCtrl(panel, self._hed.event, "", "TE_PROCESS_ENTER")
	panel_sizer:add(event, 0, 0, "EXPAND")
	event:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = event, value = "event"})
	event:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = event, value = "event"})
end

CoreInstanceEventUnitElement = CoreInstanceEventUnitElement or class(MissionElement)
InstanceEventUnitElement = InstanceEventUnitElement or class(CoreInstanceEventUnitElement)
InstanceEventUnitElement.SAVE_UNIT_POSITION = false
InstanceEventUnitElement.SAVE_UNIT_ROTATION = false

function InstanceEventUnitElement:init(type, ...)
	InstanceEventUnitElement.super.init(self, ...)
	self._type = type
	self._hed.instance = nil
	self._hed.event = nil
	table.insert(self._save_values, "instance")
	table.insert(self._save_values, "event")
end

function InstanceEventUnitElement:selected()
	InstanceEventUnitElement.super.selected(self)
	local names = managers.world_instance:instance_names_by_script(self._unit:mission_element_data().script)
	if self._instance_params then
		CoreEws.update_combobox_options(self._instance_params, names)
	end
	if not table.contains(names, self._hed.instance) then
		self._hed.instance = nil
		self:_instance_changed()
	end
	if self._instance_params then
		CoreEws.change_combobox_value(self._instance_params, self._hed.instance)
	end
end

function InstanceEventUnitElement:update_selected(t, dt)
	if self._hed.instance then
		self:_draw_instance_link(t, dt, self._hed.instance)
	end
end

function InstanceEventUnitElement:update_editing(t, dt)
	local instance_name = self:_instance_name_raycast()
	if instance_name then
		self:_draw_instance_link(t, dt, instance_name)
	end
end

function InstanceEventUnitElement:_draw_instance_link(t, dt, instance_name)
	local r, g, b = self:get_link_color()
	managers.editor:layer("Instances"):external_draw_instance(t, dt, instance_name, r, g, b)
	if self._type == "input" then
		Application:draw_arrow(self._unit:position(), managers.world_instance:get_instance_data_by_name(instance_name).position, r, g, b, 0.2)
	else
		Application:draw_arrow(managers.world_instance:get_instance_data_by_name(instance_name).position, self._unit:position(), r, g, b, 0.2)
	end
end

function InstanceEventUnitElement:_instance_name_raycast()
	local ray = managers.editor:unit_by_raycast({
		mask = 1,
		ray_type = "body editor",
		skip_instance_check = true
	})
	if not ray or not ray.unit then
		return nil
	end
	local instance_name = ray.unit:unit_data().instance
	if not instance_name then
		return nil
	end
	local instance_data = managers.world_instance:get_instance_data_by_name(instance_name)
	return instance_data.script == self._unit:mission_element_data().script and instance_name or nil
end

function InstanceEventUnitElement:external_change_instance(instance)
	self._hed.instance = instance
	self:_instance_changed()
end

function InstanceEventUnitElement:_instance_changed()
	local events = {}
	if self._hed.instance then
		if self._type == "input" then
			events = managers.world_instance:get_mission_inputs_by_name(self._hed.instance)
		else
			events = managers.world_instance:get_mission_outputs_by_name(self._hed.instance)
		end
	end
	if not table.contains(events, self._hed.event) then
		self._hed.event = events[1]
	end
	if self._event_params then
		CoreEws.update_combobox_options(self._event_params, events)
		CoreEws.change_combobox_value(self._event_params, self._hed.event)
	end
end

function InstanceEventUnitElement:_set_instance_by_raycast()
	local instance_name = self:_instance_name_raycast()
	if instance_name then
		self._hed.instance = instance_name
		CoreEws.change_combobox_value(self._instance_params, instance_name)
		self:_instance_changed()
	end
end

function InstanceEventUnitElement:destroy_panel(...)
	InstanceEventUnitElement.super.destroy_panel(self, ...)
	self._instance_params = nil
	self._event_params = nil
end

function InstanceEventUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self:selected()
	local instance_params = {
		name = "Instance:",
		panel = panel,
		sizer = panel_sizer,
		options = managers.world_instance:instance_names_by_script(self._unit:mission_element_data().script),
		value = self._hed.instance,
		tooltip = "Select an instance",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local instance = CoreEWS.combobox(instance_params)
	instance:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = instance, value = "instance"})
	instance:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "_instance_changed"), {ctrlr = instance})
	self._instance_params = instance_params
	local event_params = {
		name = "Event:",
		panel = panel,
		sizer = panel_sizer,
		options = {},
		value = self._hed.event,
		tooltip = "Select an event",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local event = CoreEWS.combobox(event_params)
	event:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = event, value = "event"})
	self._event_params = event_params
	self:_instance_changed()
end

function InstanceEventUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "_set_instance_by_raycast"))
end

CoreInstanceInputEventUnitElement = CoreInstanceInputEventUnitElement or class(InstanceEventUnitElement)
InstanceInputEventUnitElement = InstanceInputEventUnitElement or class(CoreInstanceInputEventUnitElement)

function InstanceInputEventUnitElement:init(...)
	InstanceInputEventUnitElement.super.init(self, "input", ...)
end

CoreInstanceOutputEventUnitElement = CoreInstanceOutputEventUnitElement or class(InstanceEventUnitElement)
InstanceOutputEventUnitElement = InstanceOutputEventUnitElement or class(CoreInstanceOutputEventUnitElement)

function InstanceOutputEventUnitElement:init(...)
	InstanceOutputEventUnitElement.super.init(self, "output", ...)
end

CoreInstancePointUnitElement = CoreInstancePointUnitElement or class(MissionElement)
InstancePointUnitElement = InstancePointUnitElement or class(CoreInstancePointUnitElement)

function InstancePointUnitElement:init(...)
	InstancePointUnitElement.super.init(self, ...)
	self._hed.instance = nil
	table.insert(self._save_values, "instance")
end

function InstancePointUnitElement:update_selected(t, dt)
	if self._hed.instance then
		InstanceEventUnitElement._draw_instance_link(self, t, dt, self._hed.instance)
	end
end

function InstancePointUnitElement:update_editing(t, dt)
	local instance_name = self:_instance_name_raycast()
	if instance_name then
		InstanceEventUnitElement._draw_instance_link(self, t, dt, instance_name)
	end
end

function InstancePointUnitElement:selected()
	InstanceEventUnitElement.super.selected(self)
	local names = self:_get_options()
	if self._instance_params then
		CoreEws.update_combobox_options(self._instance_params, names)
	end
	if not table.contains(names, self._hed.instance) then
		self._hed.instance = nil
	end
	if self._instance_params then
		CoreEws.change_combobox_value(self._instance_params, self._hed.instance)
	end
end

function InstancePointUnitElement:external_change_instance(instance)
	self._hed.instance = instance
end

function InstancePointUnitElement:_set_instance_by_raycast()
	local instance_name = self:_instance_name_raycast()
	if instance_name then
		self._hed.instance = instance_name
		CoreEws.change_combobox_value(self._instance_params, instance_name)
	end
end

function InstancePointUnitElement:_instance_name_raycast()
	local ray = managers.editor:unit_by_raycast({
		mask = 1,
		ray_type = "body editor",
		skip_instance_check = true
	})
	if not ray or not ray.unit then
		return nil
	end
	local instance_name = ray.unit:unit_data().instance
	if not instance_name then
		return nil
	end
	local instance_data = managers.world_instance:get_instance_data_by_name(instance_name)
	return instance_data.mission_placed and instance_data.script == self._unit:mission_element_data().script and instance_name or nil
end

function InstancePointUnitElement:_get_options()
	local _names = managers.world_instance:instance_names_by_script(self._unit:mission_element_data().script)
	local names = {}
	for _, name in ipairs(_names) do
		if managers.world_instance:get_instance_data_by_name(name).mission_placed then
			table.insert(names, name)
		end
	end
	return names
end

function InstancePointUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local instance_params = {
		name = "Instance:",
		panel = panel,
		sizer = panel_sizer,
		options = self:_get_options(),
		value = self._hed.instance,
		tooltip = "Select an instance",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = false
	}
	local instance = CoreEWS.combobox(instance_params)
	instance:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = instance, value = "instance"})
	self._instance_params = instance_params
end

function InstancePointUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "_set_instance_by_raycast"))
end
