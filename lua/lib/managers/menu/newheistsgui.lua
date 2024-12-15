NewHeistsGui = NewHeistsGui or class(MenuGuiComponent)
NewHeistsGui.make_fine_text = BlackMarketGui.make_fine_text
local PANEL_PADDING = 10
local IMAGE_H = 123
local IMAGE_W = 416
local TIME_PER_PAGE = 5

function NewHeistsGui:init(ws)
	local tweak = tweak_data.gui.new_heists
	self._page_count = math.min(#tweak, 5)
	self._current_page = 1
	self._panel = ws:panel()
	self._content_panel = self._panel:panel({w = IMAGE_W})
	self._content_panel:set_right(self._panel:width())
	local header_h = tweak_data.menu.pd2_medium_font_size + PANEL_PADDING
	self._contents = {}
	self._internal_content_panel = self._content_panel:panel()
	self._internal_image_panel = self._internal_content_panel:panel({y = header_h, h = IMAGE_H})
	local max_h = 0
	for i = 1, self._page_count do
		local content_panel = self._internal_content_panel:panel({
			x = (i == 1 and 0 or 1) * self._content_panel:w()
		})
		local font_size = tweak_data.menu.pd2_medium_font_size
		local text = content_panel:text({
			text = managers.localization:to_upper_text(tweak[i].name_id),
			font = tweak_data.menu.pd2_medium_font,
			font_size = font_size,
			y = PANEL_PADDING
		})
		self:make_fine_text(text)
		while text:w() > content_panel:w() do
			font_size = font_size - 0.5
			text:set_font_size(font_size)
			self:make_fine_text(text)
		end
		text:set_right(content_panel:w())
		local image_panel = content_panel:panel({y = header_h, height = IMAGE_H})
		image_panel:bitmap({
			texture = tweak[i].texture_path
		})
		content_panel:set_h(image_panel:bottom())
		max_h = math.max(max_h, image_panel:bottom())
		table.insert(self._contents, content_panel)
	end
	BoxGuiObject:new(self._internal_image_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._internal_content_panel:set_h(max_h)
	self._page_panel = self._content_panel:panel({
		y = self._internal_content_panel:bottom() + PANEL_PADDING,
		h = 20
	})
	self._page_buttons = {}
	for i = 1, self._page_count do
		local page_button = self._page_panel:bitmap({
			texture = i == self._current_page and "guis/textures/pd2/menu_page_buttons" or "guis/textures/pd2/menu_page_buttons_empty"
		})
		page_button:set_center_x(i / (self._page_count + 1) * self._page_panel:w() / 2 + self._page_panel:w() / 4)
		page_button:set_center_y(self._page_panel:h() / 2)
		table.insert(self._page_buttons, page_button)
	end
	self._content_panel:set_h(self._page_panel:bottom())
	if managers.menu_component._player_profile_gui then
		self._content_panel:set_y(managers.menu_component._player_profile_gui._panel:y() - header_h)
	else
		self._content_panel:set_bottom(self._panel:height() - PANEL_PADDING * 2)
	end
	self._queued_page = nil
end

local animating

function NewHeistsGui:update(t, dt)
	local ng = managers.menu:active_menu().renderer:active_node_gui()
	local node = ng and ng.node
	if node and node:parameters() then
		self:set_enabled(node:parameters().name == "main")
	end
	if self._page_count <= 1 then
		return
	end
	self._next_time = self._next_time or t + TIME_PER_PAGE
	if t >= self._next_time then
		self:_next_page()
		self._next_time = t + TIME_PER_PAGE
	end
	if not animating and self._queued_page then
		self:_move_to_page(self._queued_page)
		self._queued_page = nil
	end
end

function NewHeistsGui:_move_pages(pages)
	local function swipe_func(o, other_object, swipe_distance, time, end_pos)
		if not alive(o) then
			return
		end
		if not alive(other_object) then
			return
		end
		local speed = swipe_distance / math.max(1.0E-4, time or 1)
		local start_pos = o:x()
		local final_pos = start_pos - swipe_distance - 5
		while alive(o) and alive(other_object) and final_pos <= o:x() do
			local dt = coroutine.yield()
			o:move(-dt * speed, 0)
			if start_pos <= other_object:x() then
				other_object:set_left(o:right() - 5)
			end
		end
		if end_pos then
			o:set_x(end_pos)
		end
		other_object:set_x(start_pos)
		animating = false
	end
	
	if pages <= 0 then
		return
	end
	local target_page = (self._current_page + pages - 1) % self._page_count + 1
	self._contents[self._current_page]:stop()
	self._contents[target_page]:stop()
	self._contents[self._current_page]:animate(swipe_func, self._contents[target_page], self._content_panel:w(), 0.75, self._content_panel:w())
	self._page_buttons[self._current_page]:set_image("guis/textures/pd2/menu_page_buttons_empty")
	self._page_buttons[target_page]:set_image("guis/textures/pd2/menu_page_buttons")
	animating = true
	self._current_page = target_page
end

function NewHeistsGui:_next_page()
	self:_move_pages(1)
end

function NewHeistsGui:_move_to_page(page)
	if animating then
		self._queued_page = page
		return
	end
	local num_pages = page - self._current_page
	if num_pages < 0 then
		num_pages = num_pages + self._page_count
	end
	if num_pages ~= 0 then
		self:_move_pages(num_pages)
	end
	self._next_time = Application:time() + TIME_PER_PAGE
end

function NewHeistsGui:close()
	self._panel:remove(self._content_panel)
end

function NewHeistsGui:mouse_pressed(button, x, y)
	if not self._enabled or button ~= Idstring("0") then
		return
	end
	if not self._content_panel:inside(x, y) then
		return
	end
	if self._contents[self._current_page]:inside(x, y) then
		Steam:overlay_activate("url", tweak_data.gui.new_heists[self._current_page].url)
		return true
	end
	for i, button in ipairs(self._page_buttons) do
		if i ~= self._current_page and button:inside(x, y) then
			self:_move_to_page(i)
			return true
		end
	end
end

function NewHeistsGui:mouse_moved(o, x, y)
	if not self._enabled then
		return
	end
	if self._internal_content_panel:inside(x, y) then
		return true, "link"
	end
	for i, button in ipairs(self._page_buttons) do
		if button:inside(x, y) then
			return true, "link"
		end
	end
end

function NewHeistsGui:set_enabled(enabled)
	self._enabled = enabled
	self._content_panel:set_visible(enabled)
end
