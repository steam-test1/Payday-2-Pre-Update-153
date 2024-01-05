EnableUnitUnitElement = EnableUnitUnitElement or class(MissionElement)

function EnableUnitUnitElement:init(unit)
	EnableUnitUnitElement.super.init(self, unit)
	self._units = {}
	self._hed.unit_ids = {}
	table.insert(self._save_values, "unit_ids")
end

function EnableUnitUnitElement:layer_finished()
	MissionElement.layer_finished(self)
	for _, id in pairs(self._hed.unit_ids) do
		local unit = managers.worlddefinition:get_unit_on_load(id, callback(self, self, "load_unit"))
		if unit then
			self._units[unit:unit_data().unit_id] = unit
		end
	end
end

function EnableUnitUnitElement:load_unit(unit)
	if unit then
		self._units[unit:unit_data().unit_id] = unit
	end
end

function EnableUnitUnitElement:update_selected()
	for _, id in pairs(self._hed.unit_ids) do
		if not alive(self._units[id]) then
			table.delete(self._hed.unit_ids, id)
			self._units[id] = nil
		end
	end
	for id, unit in pairs(self._units) do
		if not alive(unit) then
			table.delete(self._hed.unit_ids, id)
			self._units[id] = nil
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

function EnableUnitUnitElement:update_unselected(t, dt, selected_unit, all_units)
	for _, id in pairs(self._hed.unit_ids) do
		if not alive(self._units[id]) then
			table.delete(self._hed.unit_ids, id)
			self._units[id] = nil
		end
	end
	for id, unit in pairs(self._units) do
		if not alive(unit) then
			table.delete(self._hed.unit_ids, id)
			self._units[id] = nil
		end
	end
end

function EnableUnitUnitElement:draw_links_unselected(...)
	EnableUnitUnitElement.super.draw_links_unselected(self, ...)
	for id, unit in pairs(self._units) do
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

function EnableUnitUnitElement:update_editing()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit then
		Application:draw(ray.unit, 0, 1, 0)
	end
end

function EnableUnitUnitElement:select_unit()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit then
		local unit = ray.unit
		if self._units[unit:unit_data().unit_id] then
			self._units[unit:unit_data().unit_id] = nil
			table.delete(self._hed.unit_ids, unit:unit_data().unit_id)
		else
			self._units[unit:unit_data().unit_id] = unit
			table.insert(self._hed.unit_ids, unit:unit_data().unit_id)
		end
	end
end

function EnableUnitUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "select_unit"))
end

function EnableUnitUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
end
