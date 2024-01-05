LootBagUnitElement = LootBagUnitElement or class(MissionElement)

function LootBagUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._test_units = {}
	self._hed.spawn_dir = Vector3(0, 0, 1)
	self._hed.push_multiplier = 0
	self._hed.carry_id = "none"
	self._hed.from_respawn = false
	table.insert(self._save_values, "spawn_dir")
	table.insert(self._save_values, "push_multiplier")
	table.insert(self._save_values, "carry_id")
	table.insert(self._save_values, "from_respawn")
end

function LootBagUnitElement:test_element()
	local unit_name = "units/payday2/pickups/gen_pku_lootbag/gen_pku_lootbag"
	local throw_distance_multiplier = 1
	if self._hed.carry_id ~= "none" then
		unit_name = tweak_data.carry[self._hed.carry_id].unit or unit_name
		local carry_type = tweak_data.carry[self._hed.carry_id].type
		throw_distance_multiplier = tweak_data.carry.types[carry_type].throw_distance_multiplier or throw_distance_multiplier
	end
	local unit = safe_spawn_unit(unit_name, self._unit:position(), self._unit:rotation())
	table.insert(self._test_units, unit)
	unit:push(100, 600 * self._hed.spawn_dir * self._hed.push_multiplier * throw_distance_multiplier)
end

function LootBagUnitElement:stop_test_element()
	for _, unit in ipairs(self._test_units) do
		if alive(unit) then
			World:delete_unit(unit)
		end
	end
	self._test_units = {}
end

function LootBagUnitElement:update_selected(time, rel_time)
	Application:draw_arrow(self._unit:position(), self._unit:position() + self._hed.spawn_dir * 50, 0.75, 0.75, 0.75, 0.1)
end

function LootBagUnitElement:update_editing(time, rel_time)
	local kb = Input:keyboard()
	local speed = 60 * rel_time
	if kb:down(Idstring("left")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(speed, 0, 0))
	end
	if kb:down(Idstring("right")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(-speed, 0, 0))
	end
	if kb:down(Idstring("up")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(0, 0, speed))
	end
	if kb:down(Idstring("down")) then
		self._hed.spawn_dir = self._hed.spawn_dir:rotate_with(Rotation(0, 0, -speed))
	end
	local from = self._unit:position()
	local to = from + self._hed.spawn_dir * 100000
	local ray = managers.editor:unit_by_raycast({
		from = from,
		to = to,
		mask = managers.slot:get_mask("statics_layer")
	})
	if ray and ray.unit then
		Application:draw_sphere(ray.position, 25, 1, 0, 0)
	end
end

function LootBagUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local push_multiplier_params = {
		name = "Push multiplier:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.push_multiplier,
		floats = 1,
		tooltip = "Use this to add a velocity to a physic push on the spawned unit",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local push_multiplier = CoreEWS.number_controller(push_multiplier_params)
	push_multiplier:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = push_multiplier,
		value = "push_multiplier"
	})
	push_multiplier:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = push_multiplier,
		value = "push_multiplier"
	})
	tweak_data.carry:get_carry_ids()
	local carry_id_params = {
		name = "Carry id:",
		panel = panel,
		sizer = panel_sizer,
		options = tweak_data.carry:get_carry_ids(),
		value = self._hed.carry_id,
		default = "none",
		tooltip = "Select a carry_id to be created.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local carry_id = CoreEWS.combobox(carry_id_params)
	carry_id:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = carry_id, value = "carry_id"})
	local from_respawn = EWS:CheckBox(panel, "From respawn", "")
	from_respawn:set_value(self._hed.from_respawn)
	from_respawn:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = from_respawn,
		value = "from_respawn"
	})
	panel_sizer:add(from_respawn, 0, 0, "EXPAND")
end

LootBagTriggerUnitElement = LootBagTriggerUnitElement or class(MissionElement)
LootBagTriggerUnitElement.SAVE_UNIT_POSITION = false
LootBagTriggerUnitElement.SAVE_UNIT_ROTATION = false

function LootBagTriggerUnitElement:init(unit)
	LootBagTriggerUnitElement.super.init(self, unit)
	self._hed.elements = {}
	self._hed.trigger_type = "load"
	table.insert(self._save_values, "elements")
	table.insert(self._save_values, "trigger_type")
end

function LootBagTriggerUnitElement:draw_links(t, dt, selected_unit, all_units)
	LootBagTriggerUnitElement.super.draw_links(self, t, dt, selected_unit)
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

function LootBagTriggerUnitElement:update_editing()
end

function LootBagTriggerUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and ray.unit:name() == Idstring("units/dev_tools/mission_elements/point_loot_bag/point_loot_bag") then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function LootBagTriggerUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function LootBagTriggerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function LootBagTriggerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local trigger_type_params = {
		name = "Trigger Type:",
		panel = panel,
		sizer = panel_sizer,
		options = {"load", "spawn"},
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
	help.text = "This element is a trigger to point_loot_bag element."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
