EnemyPreferedAddUnitElement = EnemyPreferedAddUnitElement or class(MissionElement)
EnemyPreferedAddUnitElement.SAVE_UNIT_POSITION = false
EnemyPreferedAddUnitElement.SAVE_UNIT_ROTATION = false

function EnemyPreferedAddUnitElement:init(unit)
	EnemyPreferedRemoveUnitElement.super.init(self, unit)
	table.insert(self._save_values, "spawn_points")
	table.insert(self._save_values, "spawn_groups")
end

function EnemyPreferedAddUnitElement:draw_links(t, dt, selected_unit, all_units)
	EnemyPreferedRemoveUnitElement.super.draw_links(self, t, dt, selected_unit, all_units)
end

function EnemyPreferedAddUnitElement:update_selected(t, dt, selected_unit, all_units)
	local function _draw_func(element_ids)
		if not element_ids then
			return
		end
		for _, id in ipairs(element_ids) do
			local unit = all_units[id]
			local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
			if draw then
				self:_draw_link({
					from_unit = self._unit,
					to_unit = unit,
					r = 0,
					g = 0,
					b = 0.75
				})
			end
		end
	end
	
	_draw_func(self._hed.spawn_points)
	_draw_func(self._hed.spawn_groups)
end

function EnemyPreferedAddUnitElement:update_editing()
end

function EnemyPreferedAddUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit then
		local is_group, id
		if string.find(ray.unit:name():s(), "ai_spawn_enemy", 1, true) then
			id = ray.unit:unit_data().unit_id
		elseif string.find(ray.unit:name():s(), "ai_enemy_group", 1, true) then
			id = ray.unit:unit_data().unit_id
			is_group = true
		end
		if id then
			if is_group then
				if self._hed.spawn_groups and table.contains(self._hed.spawn_groups, id) then
					table.delete(self._hed.spawn_groups, id)
					if not next(self._hed.spawn_groups) then
						self._hed.spawn_groups = nil
					end
				else
					self._hed.spawn_groups = self._hed.spawn_groups or {}
					table.insert(self._hed.spawn_groups, id)
				end
			elseif self._hed.spawn_points and table.contains(self._hed.spawn_points, id) then
				table.delete(self._hed.spawn_points, id)
				if not next(self._hed.spawn_points) then
					self._hed.spawn_points = nil
				end
			else
				self._hed.spawn_points = self._hed.spawn_points or {}
				table.insert(self._hed.spawn_points, id)
			end
		end
	end
end

function EnemyPreferedAddUnitElement:remove_links(unit)
	local rem_u_id = unit:unit_data().unit_id
	
	local function _rem_func(element_ids)
		if not element_ids then
			return
		end
		for _, id in ipairs(element_ids) do
			if id == rem_u_id then
				table.delete(element_ids, id)
			end
		end
	end
	
	_rem_func(self._hed.spawn_points)
	_rem_func(self._hed.spawn_groups)
end

function EnemyPreferedAddUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function EnemyPreferedAddUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
end

EnemyPreferedRemoveUnitElement = EnemyPreferedRemoveUnitElement or class(MissionElement)
EnemyPreferedRemoveUnitElement.SAVE_UNIT_POSITION = false
EnemyPreferedRemoveUnitElement.SAVE_UNIT_ROTATION = false

function EnemyPreferedRemoveUnitElement:init(unit)
	EnemyPreferedRemoveUnitElement.super.init(self, unit)
	self._hed.elements = {}
	table.insert(self._save_values, "elements")
end

function EnemyPreferedRemoveUnitElement:update_editing()
end

function EnemyPreferedRemoveUnitElement:draw_links(t, dt, selected_unit, all_units)
	EnemyPreferedRemoveUnitElement.super.draw_links(self, t, dt, selected_unit)
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

function EnemyPreferedRemoveUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit and string.find(ray.unit:name():s(), "ai_enemy_prefered_add", 1, true) then
		local id = ray.unit:unit_data().unit_id
		if table.contains(self._hed.elements, id) then
			table.delete(self._hed.elements, id)
		else
			table.insert(self._hed.elements, id)
		end
	end
end

function EnemyPreferedRemoveUnitElement:remove_links(unit)
	for _, id in ipairs(self._hed.elements) do
		if id == unit:unit_data().unit_id then
			table.delete(self._hed.elements, id)
		end
	end
end

function EnemyPreferedRemoveUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end
