local debug_assert = function(chk, ...)
	if not chk then
		local s = ""
		for i, text in ipairs({
			...
		}) do
			s = s .. "  " .. text
		end
		debug_assert(chk, s)
	end
end
local make_fine_text = function(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
	return text:x(), text:y(), w, h
end
PrePlanningPoint = PrePlanningPoint or class()

function PrePlanningPoint:init(map_panel, element, shape, rotation)
	local width = 30
	local height = 30
	local length = 4
	local thick = 1
	local lx = element:get_orientation().x
	local ly = element:get_orientation().y
	local x, y, w, h = unpack(shape)
	local raw_x = (lx - x) / w - 0.5
	local raw_y = 1 - (ly - y) / h - 0.5
	local ax = math.cos(rotation) * raw_x - math.sin(rotation) * raw_y + 0.5
	local ay = math.sin(rotation) * raw_x + math.cos(rotation) * raw_y + 0.5
	self._x = ax
	self._y = ay
	self._element = element
	self._map_panel = map_panel
	self._panel = map_panel:panel({
		layer = 10,
		w = width,
		h = height
	})
	self._panel:set_center(self._x * self._map_panel:w(), self._y * self._map_panel:h())
	self._panel:set_halign({0, 0.002})
	self._panel:set_valign({0, 0.002})
	self._rect = self._panel:rect({
		layer = 0,
		color = Color.black,
		alpha = 0.5,
		halign = "grow",
		valign = "grow"
	})
	self._box = BoxGuiObject:new(self._panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._reserved_data = self._element and managers.preplanning:get_reserved_mission_element_data(self._element:id()) or false
	self._states = {}
end

function PrePlanningPoint:map_position()
	return self._x * self._map_panel:w(), self._y * self._map_panel:h()
end

function PrePlanningPoint:inside(x, y)
	return self._panel:inside(x, y)
end

function PrePlanningPoint:alive()
	return alive(self._panel)
end

function PrePlanningPoint:element()
	return self._element
end

function PrePlanningPoint:set_color(color)
	self._box:set_color(color)
	self._rect:set_color(color * Color.black)
end

function PrePlanningPoint:set_state(...)
	local states = {
		...
	}
	debug_assert(#states % 2 == 0, "[PrePlanningPoint:set_state] State is missing value", inspect(states))
	local state, value
	for i = 1, #states - 1, 2 do
		state = states[i]
		value = not not states[i + 1]
		if self._states[state] ~= value then
			self._states[state] = value
		end
	end
end

function PrePlanningPoint:dirty()
	if not self._need_update then
		self._need_update = true
		self:update_me()
	end
end

function PrePlanningPoint:update_me()
	if self._need_update then
		self._need_update = false
		self._panel:set_center(self._map_panel:w() * self._x, self._map_panel:h() * self._y)
		self._box:create_sides(self._panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		local reserved_data = self._element and managers.preplanning:get_reserved_mission_element_data(self._element:id()) or false
		if self._reserved_data ~= reserved_data then
			self._reserved_data = reserved_data
			local type = self._reserved_data[1]
			self._b = self._b or self._panel:rect({halign = "scale", valign = "scale"})
			self._b:set_color(tweak_data.preplanning.types[type] and tweak_data.preplanning.types[type].color or Color.black)
		end
		self:_update_state()
	end
end

function PrePlanningPoint:_update_state()
	self:set_color(self:_state_color())
end

function PrePlanningPoint:_state_color()
	if not self._states.visible then
		return Color(0, 0, 0, 0)
	elseif not self._states.selected then
		return tweak_data.screen_colors.text
	else
		return tweak_data.screen_colors.button_stage_2
	end
	return Color.red
end

function PrePlanningPoint:_chk_mouse_pos(x, y)
	if not self._states.visible or not self:inside(x, y) then
		return false
	end
	return true
end

function PrePlanningPoint:mouse_moved(x, y)
	local mouse_check = self:_chk_mouse_pos(x, y)
	if mouse_check then
		return true, "link"
	end
end

function PrePlanningPoint:mouse_pressed(x, y)
	if not self:_chk_mouse_pos(x, y) then
		return
	end
	self._pressed = true
	return true
end

function PrePlanningPoint:mouse_released(x, y)
	if not self._pressed then
		return false
	end
	self._pressed = false
	if not self:_chk_mouse_pos(x, y) then
		return false
	end
	managers.menu_component:post_event("menu_enter")
	MenuCallbackHandler:reserve_preplanning_mission_element_by_id(self._element:id())
	return true
end

PrePlanningLocation = PrePlanningLocation or class()

function PrePlanningLocation:init(panel, index, size)
	self._location = managers.preplanning:get_location_by_index(index)
	local location_group = managers.preplanning:convert_location_index_to_group(index)
	local location_rotation = self._location.rotation or 0
	local map_texture = self._location.texture
	local map_render_template = self._location.render_template
	local map_x = self._location.map_x or 0
	local map_y = self._location.map_y or 0
	local map_size = self._location.map_size or 1
	local x1 = self._location.x1 or 0
	local x2 = self._location.x2 or 0
	local y1 = self._location.y1 or 0
	local y2 = self._location.y2 or 0
	self._shape = {
		x1,
		y1,
		math.abs(x2 - x1),
		math.abs(y2 - y1)
	}
	self._rotation = location_rotation == 0 and 360 or location_rotation
	self._map_panel = panel
	self._panel = self._map_panel:panel({
		w = size * map_size,
		h = size * map_size,
		name = location_group,
		alpha = 0.9,
		valign = "scale",
		halign = "scale"
	})
	self._panel:set_center(self._map_panel:w() / 2 + map_x * size * 1.05, self._map_panel:h() / 2 + map_y * size * 1.05)
	self._map = self._panel:bitmap({
		name = "map",
		rotation = self._rotation,
		texture = map_texture,
		w = self._panel:w(),
		h = self._panel:h(),
		valign = "scale",
		halign = "scale",
		render_template = map_render_template,
		blend_mode = "add"
	})
	self._name = self._location.name_id and managers.localization:text(self._location.name_id) or "MISSING NAME_ID"
	local texts = self._location.texts
	local x, y, w, h = unpack(self._shape)
	if texts then
		local params, new_text
		for i, text in ipairs(texts) do
			params = deep_clone(text)
			if params.text_id then
				params.text = managers.localization:text(params.text_id)
			end
			if params.to_upper then
				params.text = utf8.to_upper(params.text)
			end
			params.font = params.font or tweak_data.menu.pd2_small_font
			params.font_size = params.font_size or tweak_data.menu.pd2_small_font_size
			params.x = params.x or 0
			params.y = params.y or 0
			params.rotation = params.rotation or 0
			params.text_id = nil
			params.to_upper = nil
			new_text = self._panel:text(params)
			make_fine_text(new_text)
			local raw_x = params.x / self._map:texture_width() - 0.5
			local raw_y = params.y / self._map:texture_height() - 0.5
			local ax = math.cos(location_rotation) * raw_x - math.sin(location_rotation) * raw_y + 0.5
			local ay = math.sin(location_rotation) * raw_x + math.cos(location_rotation) * raw_y + 0.5
			new_text:set_center(ax * self._map:w(), ay * self._map:h())
			new_text:set_rotation(params.rotation + location_rotation)
		end
	end
	self._index = index
	self._group = location_group
	self._points = {}
	self._points_by_type = {}
	self._active = true
	self._current_type_filter = nil
end

function PrePlanningLocation:name()
	return self._name
end

function PrePlanningLocation:index()
	return self._index
end

function PrePlanningLocation:group()
	return self._group
end

function PrePlanningLocation:add_point(type, index, element)
	self._points_by_type[type] = self._points_by_type[type] or {}
	debug_assert(not self._points_by_type[type][index], "[PrePlanningLocation:add_point] Point already added to location!", "location", self._group, "type", type, "index", index, "id", element:id(), "editor_name", element:editor_name())
	if self._points[element:id()] then
		self._points_by_type[type][index] = self._points[element:id()]
	else
		local new_point = PrePlanningPoint:new(self._panel, element, self._shape, self._rotation)
		new_point:set_state("visible", true)
		self._points[element:id()] = new_point
		self._points_by_type[type][index] = new_point
	end
end

function PrePlanningLocation:set_active(active)
	do return end
	active = not not active
	if self._active ~= active then
		self._active = active
		self._panel:set_visible(self._active)
	end
end

function PrePlanningLocation:set_type_filter(type_filter)
	if self._current_type_filter ~= type_filter then
		self._current_type_filter = type_filter
		if not self._current_type_filter then
			for i, point in pairs(self._points) do
				point:set_state("visible", true)
			end
		else
			for i, point in pairs(self._points) do
				point:set_state("visible", false)
			end
			if self._points_by_type[self._current_type_filter] then
				for i, point in pairs(self._points_by_type[self._current_type_filter]) do
					point:set_state("visible", true)
				end
			end
		end
	end
end

function PrePlanningLocation:_get_point(type, id)
	if type then
		if self._points_by_type[type] then
			for i, point in pairs(self._points_by_type[type]) do
				if point:element():id() == id then
					return point
				end
			end
		end
	else
		for i, point in pairs(self._points) do
			if point:element():id() == id then
				return point
			end
		end
	end
end

function PrePlanningLocation:update_element(type, id)
	local point = self:_get_point(type, id)
	if point then
		point:dirty()
	end
end

function PrePlanningLocation:update_me()
	for i, point in pairs(self._points) do
		point:dirty()
	end
end

function PrePlanningLocation:mouse_moved(x, y)
	if self._current_type_filter and self._points_by_type[self._current_type_filter] then
		local used, icon, eused, eicon
		for i, point in pairs(self._points_by_type[self._current_type_filter]) do
			eused, eicon = point:mouse_moved(x, y)
			if eused then
				used, icon = eused, eicon
				MenuCallbackHandler:select_preplanning_item_by_id(point:element():id())
			end
		end
		return used, icon
	end
end

function PrePlanningLocation:mouse_pressed(x, y)
	if self._current_type_filter and self._points_by_type[self._current_type_filter] then
		for i, point in pairs(self._points_by_type[self._current_type_filter]) do
			if point:mouse_pressed(x, y) then
				return true
			end
		end
	end
end

function PrePlanningLocation:mouse_released(x, y)
	if self._current_type_filter and self._points_by_type[self._current_type_filter] then
		for i, point in pairs(self._points_by_type[self._current_type_filter]) do
			if point:mouse_released(x, y) then
				return true
			end
		end
	end
end

function PrePlanningLocation:set_selected_point(element_id)
	for i, point in pairs(self._points) do
		point:set_state("selected", point:element():id() == element_id)
	end
	self:update_me()
end

PrePlanningMapGui = PrePlanningMapGui or class()

function PrePlanningMapGui:init(saferect_ws, fullscreen_ws)
	debug_assert(managers.preplanning:num_active_locations() > 0, "[PrePlanningMapGui:init] This level have on locations", "level_id", managers.job:current_level_id())
	self._saferect_root_panel = saferect_ws:panel()
	self._panel = self._saferect_root_panel:panel({
		name = "PrePlanningMapGui",
		layer = 45
	})
	self._fullscreen_root_panel = fullscreen_ws:panel()
	self._fullscreen_panel = self._fullscreen_root_panel:panel({
		name = "PrePlanningMapGui",
		layer = 40
	})
	self._text_buttons = {}
	self.is_pc_controller = managers.menu:is_pc_controller()
	self._blackborder_workspace = managers.gui_data:create_fullscreen_workspace()
	local top_border = self._blackborder_workspace:panel():rect({
		name = "top_border",
		layer = tweak_data.gui.MOUSE_LAYER - 100,
		color = Color.black,
		rotation = 360
	})
	local bottom_border = self._blackborder_workspace:panel():rect({
		name = "bottom_border",
		layer = tweak_data.gui.MOUSE_LAYER - 100,
		color = Color.black,
		rotation = 360
	})
	managers.gui_data:layout_fullscreen_workspace(self._blackborder_workspace)
	local border_w = self._blackborder_workspace:panel():w()
	local border_h = (self._blackborder_workspace:panel():h() - 720) / 2
	top_border:set_position(0, -2)
	top_border:set_size(border_w, border_h + 2)
	bottom_border:set_position(0, 720 + border_h)
	bottom_border:set_size(border_w, border_h + 2)
	local full_16_9 = managers.gui_data:full_16_9_size()
	self._fullscreen_panel:bitmap({
		name = "blur_top",
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_root_panel:w(),
		h = full_16_9.convert_y * 2,
		x = 0,
		y = -full_16_9.convert_y,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._fullscreen_panel:bitmap({
		name = "blur_right",
		texture = "guis/textures/test_blur_df",
		w = full_16_9.convert_x * 2,
		h = self._fullscreen_root_panel:h(),
		x = self._fullscreen_root_panel:w() - full_16_9.convert_x,
		y = 0,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._fullscreen_panel:bitmap({
		name = "blur_bottom",
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_root_panel:w(),
		h = full_16_9.convert_y * 2,
		x = 0,
		y = self._fullscreen_root_panel:h() - full_16_9.convert_y,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._fullscreen_panel:bitmap({
		name = "blur_left",
		texture = "guis/textures/test_blur_df",
		w = full_16_9.convert_x * 2,
		h = self._fullscreen_root_panel:h(),
		x = -full_16_9.convert_x,
		y = 0,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._panel:rect({
		w = self._panel:w(),
		h = 2,
		x = 0,
		y = 0,
		layer = 1000,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	})
	self._panel:rect({
		w = self._panel:w(),
		h = 2,
		x = 0,
		y = 0,
		layer = 1000,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	}):set_bottom(self._panel:h())
	self._panel:rect({
		w = 2,
		h = self._panel:h(),
		x = 0,
		y = 0,
		layer = 1000,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	}):set_right(self._panel:w())
	self._panel:rect({
		w = 2,
		h = self._panel:h(),
		x = 0,
		y = 0,
		layer = 1000,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	})
	self._fullscreen_panel:rect({
		name = "bg",
		color = Color.black,
		layer = -10,
		alpha = 1
	})
	self._fullscreen_panel:bitmap({
		name = "vignette",
		texture = "guis/textures/crimenet_map_vignette",
		layer = 6,
		color = Color(0.2, 1, 1, 1),
		blend_mode = "mul",
		x = -5,
		y = -5,
		w = self._fullscreen_panel:w() + 10,
		h = self._fullscreen_panel:h() + 10,
		rotation = 360
	})
	self._panel:text({
		name = "title_text",
		text = managers.localization:to_upper_text("menu_preplanning_title"),
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		color = tweak_data.screen_colors.text,
		blend_mode = "add",
		layer = 15,
		x = 10,
		y = 10
	})
	self._map_size = math.max(self._panel:w(), self._panel:h()) * 2
	self._map_panel = self._panel:panel({
		name = "map",
		layer = 0,
		w = self._map_size,
		h = self._map_size,
		alpha = 0.9
	})
	self._map_panel:set_center(self._panel:w() / 2, self._panel:h() / 2)
	self._grid_size = math.max(self._panel:w(), self._panel:h()) * 2
	self._map_grid = self._map_panel:bitmap({
		w = self._grid_size,
		h = self._grid_size,
		rotation = 360,
		texture = "guis/dlcs/big_bank/textures/pd2/pre_planning/bg_grid",
		texture_rect = {
			0,
			0,
			self._map_panel:w() * 2,
			self._map_panel:h() * 2
		},
		layer = -1,
		wrap_mode = "wrap",
		blend_mode = "add",
		halign = "scale",
		valign = "scale"
	})
	self._map_grid:set_center(self._map_panel:w() / 2, self._map_panel:h() / 2)
	self._map_x, self._map_y = self._map_panel:position()
	self._map_zoom = 1
	self._peer_draw_points = {}
	self._peer_draw_lines = {}
	for i = 1, 4 do
		self._peer_draw_points[i] = {}
		self._peer_draw_lines[i] = {}
	end
	self._location_size = math.min(self._panel:w(), self._panel:h())
	self._locations = {}
	self._current_location = false
	local button_panel, bleft, bright, btop, bbottom, new_location
	for i = 1, managers.preplanning:num_active_locations() do
		new_location = PrePlanningLocation:new(self._map_panel, i, self._location_size)
		debug_assert(not self._locations[new_location:group()], "[PrePlanningMapGui:init] Location already taken!", "location", new_location:group(), "new index", i)
		self._locations[new_location:group()] = new_location
	end
	local types = managers.preplanning:types_with_mission_elements()
	local location_group, location
	for _, type in ipairs(types) do
		if managers.preplanning:is_type_position_important(type) then
			for index, element in ipairs(managers.preplanning:get_mission_elements_by_type(type)) do
				location_group = element:value("location_group")
				location = self._locations[location_group]
				debug_assert(location, "[PrePlanningMapGui:init] Location is missing in GUI!", "location", location_group)
				location:add_point(type, index, element)
			end
		end
	end
	self._enabled = false
end

function PrePlanningMapGui:end_draw_lines(peer_id)
	table.insert(self._peer_draw_points[peer_id], false)
	self._draw_mode = nil
end

function PrePlanningMapGui:draw_next_line(x, y, peer_id)
	local start_point = self._peer_draw_points[peer_id][#self._peer_draw_points[peer_id]]
	local end_point = Vector3(x - self._map_panel:x(), y - self._map_panel:y(), 0)
	if start_point ~= end_point then
		local line = start_point and self._map_panel:polyline({
			points = {start_point, end_point},
			layer = 150,
			color = tweak_data.chat_colors[peer_id],
			line_width = 2,
			blend_mode = "normal",
			closed = false,
			valign = "scale",
			halign = "scale"
		})
		if line then
			table.insert(self._peer_draw_lines[peer_id], line)
			while #self._peer_draw_lines[peer_id] > 100 do
				self._map_panel:remove(table.remove(self._peer_draw_lines[peer_id], 1))
			end
		end
		table.insert(self._peer_draw_points[peer_id], end_point)
		print("DRAW", x, y, peer_id, #self._peer_draw_lines[peer_id])
	end
end

function PrePlanningMapGui:update_draws(t, dt)
end

function PrePlanningMapGui:set_location_clbk(button)
	if button and button.value then
		return self:set_location(button.value:group())
	end
end

function PrePlanningMapGui:set_location(group)
	if not self._locations[group] then
		return
	end
	if group ~= self._current_location then
		self._current_location = group
		for i, location in pairs(self._locations) do
			location:set_active(i == self._current_location)
		end
		for _, button in ipairs(self._text_buttons) do
			button.text:set_color(button.value:group() == self._current_location and tweak_data.screen_colors.text or tweak_data.screen_colors.button_stage_3)
		end
		return true
	end
end

function PrePlanningMapGui:set_type_filter(type_filter)
	if self._current_type_filter ~= type_filter then
		self._current_type_filter = type_filter
		for i, location in pairs(self._locations) do
			location:set_type_filter(self._current_type_filter)
			location:update_me()
		end
	end
end

function PrePlanningMapGui:current_type_filter()
	return self._current_type_filter
end

function PrePlanningMapGui:set_selected_element_item(item)
	if item then
		local selected_mission_element = item:name()
		for i, location in pairs(self._locations) do
			location:set_selected_point(selected_mission_element)
		end
	end
end

function PrePlanningMapGui:set_selected_element_index(index)
	do return end
	for i, data in ipairs(self._elements) do
		if data.gui:set_selected(i == index) then
			MenuCallbackHandler:set_preplanning_element(self._elements[index].element)
		end
	end
end

function PrePlanningMapGui:update_element(type, id)
	for i, location in pairs(self._locations) do
		location:update_element(type, id)
	end
end

function PrePlanningMapGui:create_text_button(params)
	local left = params.left or params.x
	local right = params.right
	local top = params.top or params.y
	local bottom = params.bottom
	local text = params.text or params.text_id and managers.localization:text(params.text_id) or ""
	if params.text_to_upper then
		text = utf8.to_upper(text)
	end
	local clbk = params.clbk
	local layer = params.layer or 4
	local hide_blur = params.hide_blur
	local disabled = params.disabled
	local value = params.value
	local font = params.font or tweak_data.menu.pd2_small_font
	local font_size = params.font_size or tweak_data.menu.pd2_small_font_size
	local is_win32 = SystemInfo:platform() == Idstring("WIN32")
	local button_panel = self._panel:panel({
		x = left,
		y = top,
		layer = layer,
		visible = not disabled
	})
	local gui_blur = button_panel:bitmap({
		name = "button_blur",
		texture = "guis/textures/test_blur_df",
		render_template = "VertexColorTexturedBlur3D",
		layer = -1,
		visible = not hide_blur
	})
	local gui_text = button_panel:text({
		name = "button_text",
		text = text,
		font = font,
		font_size = font_size,
		color = params.selected and tweak_data.screen_colors.text or tweak_data.screen_colors.button_stage_3,
		blend_mode = "add",
		layer = 0
	})
	make_fine_text(gui_text)
	button_panel:set_size(gui_text:size())
	gui_blur:set_size(button_panel:size())
	if right then
		button_panel:set_right(right)
	end
	if bottom then
		button_panel:set_bottom(bottom)
	end
	gui_blur:hide()
	local left, right, top, bottom
	for _, button in ipairs(self._text_buttons) do
		if alive(button.text) then
			left = button_panel:left() < button.panel:right()
			right = button_panel:right() > button.panel:left()
			top = button_panel:top() < button.panel:bottom()
			bottom = button_panel:bottom() > button.panel:top()
			if left and right and top and bottom then
				if button.panel:visible() and button_panel:visible() then
					Application:error("[MenuNodeBaseGui:create_text_button] Text button intersects with another text button", text, button.text:text())
				else
					Application:debug("[MenuNodeBaseGui:create_text_button] Text button intersects with another text button", text, button_panel:visible(), button.text:text(), button.panel:visible())
				end
			end
		end
	end
	table.insert(self._text_buttons, {
		panel = button_panel,
		text = gui_text,
		blur = gui_blur,
		highlighted = false,
		clbk = clbk,
		value = value
	})
	return button_panel
end

function PrePlanningMapGui:set_enabled(enabled)
	enabled = not not enabled
	if self._enabled ~= enabled then
		self._enabled = enabled
		self:set_location(managers.preplanning:first_location_group())
		for i, location in pairs(self._locations) do
			location:update_me()
		end
	end
end

function PrePlanningMapGui:update(t, dt)
	if not self._enabled then
		return
	end
	local size_min, width_padding, height_padding, left, right, top, bottom, mleft, mright, mtop, mbottom
	if self._released_map or not self._grabbed_map then
		size_min = math.min(self._panel:w(), self._panel:h())
		width_padding = (self._panel:w() - size_min) / 2
		height_padding = (self._panel:h() - size_min) / 2
		left = self._panel:w() * 0
		right = self._panel:w() * 1
		top = self._panel:h() * 0
		bottom = self._panel:h() * 1
		mleft = self._map_panel:left() - width_padding - left
		mright = self._map_panel:right() + width_padding - right
		mtop = self._map_panel:top() - height_padding - top
		mbottom = self._map_panel:bottom() + height_padding - bottom
	end
	if self._released_map then
		self._released_map.dx = math.lerp(self._released_map.dx, 0, dt * 2)
		self._released_map.dy = math.lerp(self._released_map.dy, 0, dt * 2)
		self:_move_map_position(self._released_map.dx, self._released_map.dy)
		if 0 <= mleft or mright <= 0 then
			self._released_map.dx = 0
		end
		if 0 <= mtop or mbottom <= 0 then
			self._released_map.dy = 0
		end
		self._released_map.t = self._released_map.t - dt
		if 0 > self._released_map.t then
			self._released_map = nil
		end
	end
	if not self._grabbed_map then
		local speed = 2
		local step = dt * speed
		if 0 < mleft then
			local mx = math.min(math.lerp(0, -mleft, step), math.step(0, -mleft, step * 25))
			self:_move_map_position(mx, 0)
		end
		if mright < 0 then
			local mx = math.max(math.lerp(0, -mright, step), math.step(0, -mright, step * 25))
			self:_move_map_position(mx, 0)
		end
		if 0 < mtop then
			local my = math.min(math.lerp(0, -mtop, step), math.step(0, -mtop, step * 25))
			self:_move_map_position(0, my)
		end
		if mbottom < 0 then
			local my = math.max(math.lerp(0, -mbottom, step), math.step(0, -mbottom, step * 25))
			self:_move_map_position(0, my)
		end
	end
	self:update_draws(t, d)
end

function PrePlanningMapGui:set_map_position_to_item(item)
	do return end
	for i, data in ipairs(self._elements) do
		if data.element:editor_name() == item:name() then
			self:set_map_position(data.gui:map_position())
			return
		end
	end
end

function PrePlanningMapGui:set_map_position(x, y, location)
	if type(location) == "string" then
		for i, d in ipairs(tweak_data.preplanning.location_groups) do
			if d == self._location_group then
				location = i
				break
			end
		end
	end
	self:_set_map_position(self._panel:w() * 0.5 - x, self._panel:h() * 0.5 - y, location)
end

function PrePlanningMapGui:_set_map_position(x, y, location)
	self._map_panel:set_position(x, y)
	local left = self._panel:w() * 0
	local right = self._panel:w() * 1
	local top = self._panel:h() * 0
	local bottom = self._panel:h() * 1
	local safe_scaled_size = managers.gui_data:corner_scaled_size()
	if self._map_panel:left() > left - self._map_grid:left() - safe_scaled_size.x then
		self._map_panel:set_left(left - self._map_grid:left() - safe_scaled_size.x)
	end
	if self._map_panel:left() < right - self._map_grid:right() + safe_scaled_size.x then
		self._map_panel:set_left(right - self._map_grid:right() + safe_scaled_size.x)
	end
	if self._map_panel:top() > top - self._map_grid:top() - safe_scaled_size.y then
		self._map_panel:set_top(top - self._map_grid:top() - safe_scaled_size.y)
	end
	if self._map_panel:top() < bottom - self._map_grid:bottom() + safe_scaled_size.y then
		self._map_panel:set_top(bottom - self._map_grid:bottom() + safe_scaled_size.y)
	end
	self._map_x, self._map_y = self._map_panel:position()
	if location then
		self:set_location(location)
	end
end

function PrePlanningMapGui:_move_map_position(mx, my)
	self:_set_map_position(self._map_x + mx, self._map_y + my)
end

function PrePlanningMapGui:_set_zoom(zoom, x, y)
	local min = 1
	local max = 5
	local new_zoom = math.clamp(zoom, min, max)
	if self._map_zoom ~= new_zoom then
		x, y = managers.gui_data:safe_to_full_16_9(x, y)
		local w1, h1 = self._map_panel:size()
		local wx1 = (x - self._map_x) / w1
		local wy1 = (y - self._map_y) / h1
		self._map_zoom = new_zoom
		self._map_panel:set_size(self._map_size * self._map_zoom, self._map_size * self._map_zoom)
		local w2, h2 = self._map_panel:size()
		self:_move_map_position((w1 - w2) * wx1, (h1 - h2) * wy1)
		for i, location in pairs(self._locations) do
			location:update_me()
		end
		return true
	else
		self._one_scroll_in_delay = true
	end
	return false
end

function PrePlanningMapGui:_change_zoom(zoom, x, y)
	return self:_set_zoom(self._map_zoom * zoom, x, y)
end

function PrePlanningMapGui:zoom_out(x, y)
	if self:_change_zoom(0.9, x, y) then
		managers.menu_component:post_event("zoom_out")
	end
end

function PrePlanningMapGui:zoom_in(x, y)
	if self:_change_zoom(1.1, x, y) then
		managers.menu_component:post_event("zoom_in")
	end
end

function PrePlanningMapGui:mouse_moved(o, x, y)
	if not self._enabled then
		return false, "arrow"
	end
	if self._draw_mode then
		if not ctrl() then
			self:end_draw_lines(1)
		else
			self:draw_next_line(x, y, 1)
			return true, "link"
		end
	elseif ctrl() then
		return true, "link"
	elseif alt() then
		return true, "link"
	elseif shift() then
	end
	local fx, fy = managers.gui_data:safe_to_full_16_9(x, y)
	local used, icon = false, "arrow"
	if self._panel:inside(x, y) then
		for _, button in ipairs(self._text_buttons) do
			if alive(button.panel) and button.panel:visible() then
				if button.panel:inside(x, y) then
					if not button.highlighted then
						button.highlighted = true
						if button.value:group() ~= self._current_location then
							managers.menu_component:post_event("highlight")
						end
						if alive(button.text) then
							button.text:set_color(button.value:group() == self._current_location and tweak_data.screen_colors.text or tweak_data.screen_colors.button_stage_2)
						end
					end
					if button.value:group() ~= self._current_location then
						used, icon = true, "link"
					end
				elseif button.highlighted then
					button.highlighted = false
					button.text:set_color(button.value:group() == self._current_location and tweak_data.screen_colors.text or tweak_data.screen_colors.button_stage_3)
				end
			end
		end
		if not used then
			local eused, eicon
			for i, location in pairs(self._locations) do
				eused, eicon = location:mouse_moved(x, y)
				if eused then
					self:set_selected_element_index(i)
					used, icon = eused, eicon
				end
			end
		end
	end
	if not used and self._grabbed_map then
		local left = x > self._grabbed_map.x
		local right = not left
		local up = y > self._grabbed_map.y
		local down = not up
		local mx = x - self._grabbed_map.x
		local my = y - self._grabbed_map.y
		table.insert(self._grabbed_map.dirs, 1, {mx, my})
		self._grabbed_map.dirs[10] = nil
		self:_move_map_position(mx, my)
		self._grabbed_map.x = x
		self._grabbed_map.y = y
		return true, "grab"
	end
	if not used and self._panel:inside(x, y) then
		used, icon = true, "hand"
	end
	return used, icon or "arrow"
end

function PrePlanningMapGui:mouse_pressed(button, x, y)
	if not self._enabled then
		return
	end
	if ctrl() then
		self._draw_mode = true
		return
	elseif alt() then
	elseif shift() then
	end
	local fx, fy = managers.gui_data:safe_to_full_16_9(x, y)
	local inside = self._panel:inside(x, y)
	if inside then
		if button == Idstring("0") then
			for _, button in ipairs(self._text_buttons) do
				if alive(button.panel) and button.panel:visible() and button.panel:inside(x, y) then
					if button.clbk and button.clbk(button) then
						managers.menu_component:post_event("menu_enter")
					end
					return true
				end
			end
			for i, location in pairs(self._locations) do
				if location:mouse_pressed(x, y) then
					return true
				end
			end
		elseif button == Idstring("mouse wheel down") then
			if self._one_scroll_out_delay then
				self._one_scroll_out_delay = nil
			end
			self:zoom_out(x, y)
			return true
		elseif button == Idstring("mouse wheel up") then
			if self._one_scroll_in_delay then
				self._one_scroll_in_delay = nil
			end
			self:zoom_in(x, y)
			return true
		end
	end
	if button == Idstring("0") and self._panel:inside(x, y) then
		self._released_map = nil
		self._grabbed_map = {
			x = x,
			y = y,
			dirs = {}
		}
	end
end

function PrePlanningMapGui:mouse_released(button, x, y)
	if not self._enabled then
		return
	end
	if button ~= Idstring("0") then
		return
	end
	self:end_draw_lines(1)
	local fx, fy = managers.gui_data:safe_to_full_16_9(x, y)
	if self._grabbed_map and #self._grabbed_map.dirs > 0 then
		local dx, dy = 0, 0
		for _, values in ipairs(self._grabbed_map.dirs) do
			dx = dx + values[1]
			dy = dy + values[2]
		end
		dx = dx / #self._grabbed_map.dirs
		dy = dy / #self._grabbed_map.dirs
		self._released_map = {
			t = 2,
			dx = dx,
			dy = dy
		}
		self._grabbed_map = nil
	end
	for i, location in pairs(self._locations) do
		if location:mouse_released(x, y) then
			return true
		end
	end
end

function PrePlanningMapGui:confirm_pressed()
end

function PrePlanningMapGui:next_page()
	self:set_location(self._location_index + 1)
end

function PrePlanningMapGui:previous_page()
	self:set_location(self._location_index - 1)
end

function PrePlanningMapGui:input_focus()
	return self._grabbed_map and true or false
end

function PrePlanningMapGui:close()
	self._saferect_root_panel:remove(self._panel)
	self._fullscreen_root_panel:remove(self._fullscreen_panel)
	Overlay:gui():destroy_workspace(self._blackborder_workspace)
end
