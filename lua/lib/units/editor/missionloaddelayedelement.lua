MissionLoadDelayedElement = MissionLoadDelayedElement or class(MissionElement)
MissionLoadDelayedElement.SAVE_UNIT_POSITION = false
MissionLoadDelayedElement.SAVE_UNIT_ROTATION = false

function MissionLoadDelayedElement:init(unit)
	MissionLoadDelayedElement.super.init(self, unit)
	self._units = {}
	self._hed.unit_ids = {}
	table.insert(self._save_values, "unit_ids")
end

function MissionLoadDelayedElement:layer_finished()
	MissionElement.layer_finished(self)
	for _, id in pairs(self._hed.unit_ids) do
		local unit = managers.worlddefinition:get_unit_on_load(id, callback(self, self, "save_unit_data"))
		self:save_unit_data(unit)
	end
end

function MissionLoadDelayedElement:save_unit_data(unit)
	if unit then
		self._units[unit:unit_data().unit_id] = unit
	end
end

function MissionLoadDelayedElement:update_selected()
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
				r = 1,
				g = 0,
				b = 1
			}
			self:_draw_link(params)
			Application:draw(unit, 1, 0, 1)
		end
	end
end

function MissionLoadDelayedElement:update_unselected(t, dt, selected_unit, all_units)
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

function MissionLoadDelayedElement:draw_links_unselected(...)
	MissionLoadDelayedElement.super.draw_links_unselected(self, ...)
	for id, unit in pairs(self._units) do
		local params = {
			from_unit = self._unit,
			to_unit = unit,
			r = 0.5,
			g = 0,
			b = 0.5
		}
		self:_draw_link(params)
		Application:draw(unit, 0.5, 0, 0.5)
	end
end

function MissionLoadDelayedElement:update_editing()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit then
		Application:draw(ray.unit, 1, 0, 1)
	end
end

function MissionLoadDelayedElement:select_unit()
	local ray = managers.editor:unit_by_raycast({
		sample = true,
		mask = managers.slot:get_mask("all"),
		ray_type = "body editor"
	})
	if ray and ray.unit then
		local unit = ray.unit
		if self._units[unit:unit_data().unit_id] then
			self:_remove_unit(unit)
		else
			self:_add_unit(unit)
		end
	end
end

function MissionLoadDelayedElement:_remove_unit(unit)
	self._units[unit:unit_data().unit_id] = nil
	table.delete(self._hed.unit_ids, unit:unit_data().unit_id)
end

function MissionLoadDelayedElement:_add_unit(unit)
	self:save_unit_data(unit)
	table.insert(self._hed.unit_ids, unit:unit_data().unit_id)
end

function MissionLoadDelayedElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "select_unit"))
end

function MissionLoadDelayedElement:add_unit_list_btn()
	local function filter_p(unit)
		if self._units[unit:unit_data().unit_id] then
			return false
		end
		if unit:unit_data().delayed_load then
			return managers.editor:layer("Statics"):category_map()[unit:type():s()]
		end
		return false
	end
	
	local dialog = SelectUnitByNameModal:new("Add Unit", filter_p)
	for _, unit in ipairs(dialog:selected_units()) do
		if not self._units[unit:unit_data().unit_id] then
			self:_add_unit(unit)
		end
	end
end

function MissionLoadDelayedElement:remove_unit_list_btn()
	local function filter_p(unit)
		return self._units[unit:unit_data().unit_id]
	end
	
	local dialog = SelectUnitByNameModal:new("Remove Unit", filter_p)
	for _, unit in ipairs(dialog:selected_units()) do
		if self._units[unit:unit_data().unit_id] then
			self:_remove_unit(unit)
		end
	end
end

function MissionLoadDelayedElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self._btn_toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	self._btn_toolbar:add_tool("ADD_UNIT_LIST", "Add unit from unit list", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	self._btn_toolbar:connect("ADD_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "add_unit_list_btn"), nil)
	self._btn_toolbar:add_tool("REMOVE_UNIT_LIST", "Remove unit from unit list", CoreEws.image_path("toolbar\\delete_16x16.png"), nil)
	self._btn_toolbar:connect("REMOVE_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "remove_unit_list_btn"), nil)
	self._btn_toolbar:realize()
	panel_sizer:add(self._btn_toolbar, 0, 1, "EXPAND,LEFT")
end
