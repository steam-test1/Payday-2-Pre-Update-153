local bezier3 = require("lib/utils/Bezier3")
VehicleMarkerUnitElement = VehicleMarkerUnitElement or class(MissionElement)
VehicleMarkerUnitElement._bezier_points = {}
VehicleMarkerUnitElement._linked_markers = {}

function VehicleMarkerUnitElement:init(unit)
	VehicleMarkerUnitElement.super.init(self, unit)
	self:_add_wp_options()
	self._hed.icon = "pd2_goto"
	self._hed.text_id = "debug_none"
	self._hed.cp_length = 10
	self._hed.markers = {}
	table.insert(self._save_values, "cp_length")
	table.insert(self._save_values, "markers")
end

function VehicleMarkerUnitElement:_add_wp_options()
	self._text_options = {"debug_none"}
	for _, id_string in ipairs(managers.localization:ids("strings/system_text")) do
		local s = id_string:s()
		if string.find(s, "wp_") then
			table.insert(self._text_options, s)
		end
	end
end

function VehicleMarkerUnitElement:_set_text()
	self._text:set_value(managers.localization:text(self._hed.text_id))
end

function VehicleMarkerUnitElement:set_element_data(params, ...)
	VehicleMarkerUnitElement.super.set_element_data(self, params, ...)
	if params.value == "text_id" then
		self:_set_text()
	end
end

function VehicleMarkerUnitElement:add_triggers(vc)
	vc:add_trigger(Idstring("lmb"), callback(self, self, "add_element"))
end

function VehicleMarkerUnitElement:clear()
	local id = self._unit:unit_data().unit_id
	for _, marker in ipairs(self._linked_markers) do
		if marker:mission_element_data().markers.parent == id then
			print("VehicleMarkerUnitElement:clear(): Removing parent from ", inspect(marker:mission_element_data().markers))
			marker:mission_element_data().markers.parent = nil
		end
		if marker:mission_element_data().markers.child == id then
			print("VehicleMarkerUnitElement:clear(): Removing child from ", inspect(marker:mission_element_data().markers))
			marker:mission_element_data().markers.child = nil
		end
	end
end

function VehicleMarkerUnitElement:add_element()
	local ray = managers.editor:unit_by_raycast({mask = 10, ray_type = "editor"})
	if ray and ray.unit then
		if ray.unit:name() == Idstring("units/dev_tools/mission_elements/point_vehicle_marker/point_vehicle_marker") then
			local id = ray.unit:unit_data().unit_id
			if self._hed.markers.child == id then
				print("VehicleMarkerUnitElement:add_element() Removing unit_id: ", self._unit:unit_data().unit_id)
				self._hed.markers.child = nil
				ray.unit:mission_element_data().markers.parent = nil
			else
				print("VehicleMarkerUnitElement:add_element() Adding unit_id: ", self._unit:unit_data().unit_id)
				self._hed.markers.child = id
				ray.unit:mission_element_data().markers.parent = self._unit:unit_data().unit_id
			end
		else
			Application:error("Only point_vehicle_marker(s) can be linked together.")
		end
	end
end

function VehicleMarkerUnitElement:draw_links(t, dt, selected_unit, all_units)
	VehicleMarkerUnitElement.super.draw_links(self, t, dt, selected_unit)
	if self._hed.markers.child then
		local unit = all_units[self._hed.markers.child]
		local draw = not selected_unit or unit == selected_unit or self._unit == selected_unit
		if draw then
			self:_draw_link({
				from_unit = unit,
				to_unit = self._unit,
				r = 0.514,
				g = 0.849,
				b = 0.01
			})
		end
	end
end

function VehicleMarkerUnitElement:update_editing()
end

function VehicleMarkerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local cp_length_params = {
		name = "Control Point Length:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.cp_length,
		floats = 3,
		min = 1,
		max = 10000,
		name_proportions = 1,
		ctrlr_proportions = 2,
		slider_ctrlr_proportions = 3,
		number_ctrlr_proportions = 1
	}
	CoreEws.slider_and_number_controller(cp_length_params)
	cp_length_params.slider_ctrlr:connect("EVT_SCROLL_THUMBTRACK", callback(self, self, "set_element_data"), {
		ctrlr = cp_length_params.number_ctrlr,
		value = "cp_length"
	})
	cp_length_params.slider_ctrlr:connect("EVT_SCROLL_CHANGED", callback(self, self, "set_element_data"), {
		ctrlr = cp_length_params.number_ctrlr,
		value = "cp_length"
	})
	cp_length_params.number_ctrlr:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = cp_length_params.number_ctrlr,
		value = "cp_length"
	})
	cp_length_params.number_ctrlr:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = cp_length_params.number_ctrlr,
		value = "cp_length"
	})
	self:_add_help_text("De Casteljau - Bezier spline end point and control point vector.")
end

local b2 = {
	100,
	500,
	100,
	200,
	1000,
	100,
	1000,
	500
}
local b21 = {
	1000,
	100,
	1000,
	100,
	1600,
	500,
	1600,
	500
}
local scale = 0.1
local width = 0
local angle_tolerance = 0
local cusp_limit = 0

function VehicleMarkerUnitElement:update_selected(t, dt, selected_unit, all_units)
	Application:draw_cylinder(self._unit:position(), self._unit:position() + self._unit:rotation():y() * self._hed.cp_length, 10, 0.514, 0.849, 0.01)
	local current_marker_unit = selected_unit
	local parent_marker_unit = all_units[selected_unit:mission_element_data().markers.parent]
	while parent_marker_unit do
		current_marker_unit = parent_marker_unit
		parent_marker_unit = all_units[parent_marker_unit:mission_element_data().markers.parent]
	end
	self._linked_markers = {}
	local child_marker_unit = all_units[current_marker_unit:mission_element_data().markers.child]
	table.insert(self._linked_markers, current_marker_unit)
	while child_marker_unit do
		table.insert(self._linked_markers, child_marker_unit)
		child_marker_unit = all_units[child_marker_unit:mission_element_data().markers.child]
	end
	local bline = {}
	for i = 1, #self._linked_markers do
		local from_unit = self._linked_markers[i]
		local to_unit = self._linked_markers[i + 1]
		if from_unit and to_unit then
			bline = self:_build_points(from_unit, to_unit)
			local n1 = self:bez_draw("bline", bline, 1)
			if self._bezier_points then
				for j = 1, #self._bezier_points do
					if self._bezier_points[j + 1] then
						Application:draw_line(self._bezier_points[j], self._bezier_points[j + 1], 1, 1, 1)
					end
				end
			end
		end
	end
end

function VehicleMarkerUnitElement:_build_points(from_unit, to_unit)
	local cp1 = from_unit:position() + from_unit:rotation():y() * from_unit:mission_element_data().cp_length * -1
	local x1 = from_unit:position().x
	local y1 = from_unit:position().y
	local x2 = cp1.x
	local y2 = cp1.y
	local x3 = 0
	local y3 = 0
	local x4 = 0
	local y4 = 0
	x4 = to_unit:position().x
	y4 = to_unit:position().y
	local cp2 = to_unit:position() + to_unit:rotation():y() * to_unit:mission_element_data().cp_length
	x3 = cp2.x
	y3 = cp2.y
	return {
		x1,
		y1,
		x2,
		y2,
		x3,
		y3,
		x4,
		y4
	}
end

function VehicleMarkerUnitElement:bez_interpolate(x1, y1, x2, y2, x3, y3, x4, y4, ...)
	local n = 0
	self._bezier_points = {}
	bezier3.interpolate(function(s, x, y)
		self._bezier_points[n + 1] = Vector3(x, y, 500)
		n = n + 1
	end, x1, y1, x2, y2, x3, y3, x4, y4, scale, angle_tolerance, cusp_limit)
	return n
end

function VehicleMarkerUnitElement:bez_draw(id, b, t)
	local x, y, w, h = bezier3.bounding_box(unpack(b))
	local ax1, ay1, ax2, ay2, ax3, ay3, ax4, ay4, bx1, by1, bx2, by2, bx3, by3, bx4, by4 = bezier3.split(t, unpack(b))
	local n1 = self:bez_interpolate(ax1, ay1, ax2, ay2, ax3, ay3, ax4, ay4, "#ffff00")
	return n1
end
