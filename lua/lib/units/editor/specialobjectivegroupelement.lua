SpecialObjectiveGroupElement = SpecialObjectiveGroupElement or class(MissionElement)

function SpecialObjectiveGroupElement:init(unit)
	SpecialObjectiveGroupElement.super.init(self, unit)
	self._enemies = {}
	self._hed.base_chance = 1
	self._hed.use_instigator = false
	self._hed.followup_elements = nil
	self._hed.spawn_instigator_ids = nil
	table.insert(self._save_values, "base_chance")
	table.insert(self._save_values, "use_instigator")
	table.insert(self._save_values, "followup_elements")
	table.insert(self._save_values, "spawn_instigator_ids")
end

function SpecialObjectiveGroupElement:post_init()
end

function SpecialObjectiveGroupElement:draw_links(t, dt, selected_unit, all_units)
	SpecialObjectiveUnitElement.super.draw_links(self, t, dt, selected_unit)
	self:_draw_follow_up(selected_unit, all_units)
end

function SpecialObjectiveGroupElement:update_selected(t, dt, selected_unit, all_units)
	self:_draw_follow_up(selected_unit, all_units)
	if self._hed.spawn_instigator_ids then
		for _, id in ipairs(self._hed.spawn_instigator_ids) do
			local unit = all_units[id]
			local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
			if draw then
				self:_draw_link({
					from_unit = unit,
					to_unit = self._unit,
					r = 0,
					g = 0,
					b = 0.75
				})
			end
		end
	end
end

function SpecialObjectiveGroupElement:update_unselected(t, dt, selected_unit, all_units)
	if self._hed.followup_elements then
		local followup_elements = self._hed.followup_elements
		local i = #followup_elements
		while 0 < i do
			local element_id = followup_elements[i]
			if not alive(all_units[element_id]) then
				table.remove(followup_elements, i)
			end
			i = i - 1
		end
	end
	if self._hed.spawn_instigator_ids then
		local spawn_instigator_ids = self._hed.spawn_instigator_ids
		local i = #spawn_instigator_ids
		while 0 < i do
			local id = spawn_instigator_ids[i]
			if not alive(all_units[id]) then
				table.remove(self._hed.spawn_instigator_ids, i)
			end
			i = i - 1
		end
	end
end

function SpecialObjectiveGroupElement:_draw_follow_up(selected_unit, all_units)
	SpecialObjectiveUnitElement._draw_follow_up(self, selected_unit, all_units)
end

function SpecialObjectiveGroupElement:update_editing()
	self:_so_raycast()
	self:_spawn_raycast()
	self:_raycast()
end

function SpecialObjectiveGroupElement:_so_raycast()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and (string.find(ray.unit:name():s(), "point_special_objective", 1, true) or string.find(ray.unit:name():s(), "ai_so_group", 1, true)) then
		local id = ray.unit:unit_data().unit_id
		Application:draw(ray.unit, 0, 1, 0)
		return id
	end
	return nil
end

function SpecialObjectiveGroupElement:_spawn_raycast()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if not ray or not ray.unit then
		return
	end
	local id
	if string.find(ray.unit:name():s(), "ai_enemy_group", 1, true) or string.find(ray.unit:name():s(), "ai_spawn_enemy", 1, true) or string.find(ray.unit:name():s(), "ai_civilian_group", 1, true) or string.find(ray.unit:name():s(), "ai_spawn_civilian", 1, true) then
		id = ray.unit:unit_data().unit_id
		Application:draw(ray.unit, 0, 0, 1)
	end
	return id
end

function SpecialObjectiveGroupElement:_raycast()
	local from = managers.editor:get_cursor_look_point(0)
	local to = managers.editor:get_cursor_look_point(100000)
	local ray = World:raycast(from, to, nil, managers.slot:get_mask("all"))
	if ray and ray.position then
		Application:draw_sphere(ray.position, 10, 1, 1, 1)
		return ray.position
	end
	return nil
end

function SpecialObjectiveGroupElement:_lmb()
	local id = self:_so_raycast()
	if id then
		if self._hed.followup_elements then
			for i, element_id in ipairs(self._hed.followup_elements) do
				if element_id == id then
					table.remove(self._hed.followup_elements, i)
					return
				end
			end
		end
		self._hed.followup_elements = self._hed.followup_elements or {}
		table.insert(self._hed.followup_elements, id)
		return
	end
	local id = self:_spawn_raycast()
	if id then
		if self._hed.spawn_instigator_ids then
			for i, si_id in ipairs(self._hed.spawn_instigator_ids) do
				if si_id == id then
					table.remove(self._hed.spawn_instigator_ids, i)
					return
				end
			end
		end
		self._hed.spawn_instigator_ids = self._hed.spawn_instigator_ids or {}
		table.insert(self._hed.spawn_instigator_ids, id)
		return
	end
end

function SpecialObjectiveGroupElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "_lmb"))
end

function SpecialObjectiveGroupElement:selected()
	SpecialObjectiveUnitElement.super.selected(self)
end

function SpecialObjectiveGroupElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local use_instigator = EWS:CheckBox(panel, "Use instigator", "")
	use_instigator:set_value(self._hed.use_instigator)
	use_instigator:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = use_instigator,
		value = "use_instigator"
	})
	panel_sizer:add(use_instigator, 0, 0, "EXPAND")
	local base_chance_params = {
		name = "Base chance:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.base_chance,
		floats = 2,
		tooltip = "Used to specify chance to happen (1==absolutely!)",
		min = 0,
		max = 1,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local base_chance = CoreEws.number_controller(base_chance_params)
	base_chance:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = base_chance,
		value = "base_chance"
	})
	base_chance:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = base_chance,
		value = "base_chance"
	})
end

function SpecialObjectiveGroupElement:add_to_mission_package()
end
