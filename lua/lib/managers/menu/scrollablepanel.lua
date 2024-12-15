ScrollablePanel = ScrollablePanel or class()
local PANEL_PADDING = 10
local FADEOUT_SPEED = 5
local SCROLL_SPEED = 28
ScrollablePanel.SCROLL_SPEED = SCROLL_SPEED

function ScrollablePanel:init(parent_panel, name, data)
	data = data or {}
	self._alphas = {}
	self._padding = data.padding ~= nil and data.padding or PANEL_PADDING
	self._force_scroll_indicators = data.force_scroll_indicators
	local layer = data.layer ~= nil and data.layer or 50
	self._panel = parent_panel:panel({
		name = name .. "Base"
	})
	self._scroll_panel = self._panel:panel({
		name = name .. "Scroll",
		x = self:padding(),
		y = self:padding(),
		w = self._panel:w() - self:padding() * 2,
		h = self._panel:h() - self:padding() * 2
	})
	self._canvas = self._scroll_panel:panel({
		name = name .. "Canvas",
		w = self._scroll_panel:w(),
		h = self._scroll_panel:h()
	})
	local scroll_up_indicator_shade = self:panel():panel({
		name = "scroll_up_indicator_shade",
		layer = layer,
		x = self:padding(),
		y = self:padding(),
		w = self:canvas():w(),
		halign = "right",
		valign = "top",
		alpha = 0
	})
	BoxGuiObject:new(scroll_up_indicator_shade, {
		sides = {
			0,
			0,
			2,
			0
		}
	}):set_aligns("scale", "scale")
	local scroll_down_indicator_shade = self:panel():panel({
		name = "scroll_down_indicator_shade",
		layer = layer,
		x = self:padding(),
		y = self:padding(),
		w = self:canvas():w(),
		h = self:panel():h() - self:padding() * 2,
		halign = "right",
		valign = "bottom",
		alpha = 0
	})
	BoxGuiObject:new(scroll_down_indicator_shade, {
		sides = {
			0,
			0,
			0,
			2
		}
	}):set_aligns("scale", "scale")
	local texture, rect = tweak_data.hud_icons:get_icon_data("scrollbar_arrow")
	local scroll_up_indicator_arrow = self:panel():bitmap({
		name = "scroll_up_indicator_arrow",
		texture = texture,
		texture_rect = rect,
		layer = layer,
		color = Color.white,
		halign = "right",
		valign = "top",
		alpha = 0
	})
	scroll_up_indicator_arrow:set_top(self:panel():top() + self:padding() + 6)
	scroll_up_indicator_arrow:set_right(self:panel():right() - self:scrollbar_padding())
	local scroll_down_indicator_arrow = self:panel():bitmap({
		name = "scroll_down_indicator_arrow",
		texture = texture,
		texture_rect = rect,
		layer = layer,
		color = Color.white,
		halign = "right",
		valign = "bottom",
		rotation = 180,
		alpha = 0
	})
	scroll_down_indicator_arrow:set_bottom(self:panel():bottom() - self:padding() - 6)
	scroll_down_indicator_arrow:set_right(self:panel():right() - self:scrollbar_padding())
	local bar_h = scroll_down_indicator_arrow:top() - scroll_up_indicator_arrow:bottom()
	self._scroll_bar = self:panel():panel({
		name = "scroll_bar",
		layer = layer - 1,
		h = bar_h,
		w = 4,
		halign = "right"
	})
	self._scroll_bar_box_class = BoxGuiObject:new(self._scroll_bar, {
		sides = {
			2,
			2,
			0,
			0
		}
	})
	self._scroll_bar_box_class:set_aligns("scale", "scale")
	self._scroll_bar:set_w(8)
	self._scroll_bar:set_bottom(scroll_down_indicator_arrow:top())
	self._scroll_bar:set_center_x(scroll_down_indicator_arrow:center_x())
	self._thread = self._panel:animate(self._update, self)
end

function ScrollablePanel:panel()
	return self._panel
end

function ScrollablePanel:scroll_panel()
	return self._scroll_panel
end

function ScrollablePanel:canvas()
	return self._canvas
end

function ScrollablePanel:padding()
	return self._padding
end

function ScrollablePanel:scrollbar_padding()
	if self._padding == 0 then
		return PANEL_PADDING
	else
		return self._padding
	end
end

function ScrollablePanel:set_pos(x, y)
	if x ~= nil then
		self:panel():set_x(x)
	end
	if y ~= nil then
		self:panel():set_y(y)
	end
end

function ScrollablePanel:set_size(w, h)
	self:panel():set_size(w, h)
	self:scroll_panel():set_size(w - self:padding() * 2, h - self:padding() * 2)
	self:scroll_panel():set_position(self:padding(), self:padding())
	local scroll_up_indicator_arrow = self:panel():child("scroll_up_indicator_arrow")
	scroll_up_indicator_arrow:set_top(self:panel():top() + self:padding() + 6)
	scroll_up_indicator_arrow:set_right(self:panel():right() - self:scrollbar_padding())
	local scroll_down_indicator_arrow = self:panel():child("scroll_down_indicator_arrow")
	scroll_down_indicator_arrow:set_bottom(self:panel():bottom() - self:padding() - 6)
	scroll_down_indicator_arrow:set_right(self:panel():right() - self:scrollbar_padding())
	self._scroll_bar:set_bottom(scroll_down_indicator_arrow:top())
	self._scroll_bar:set_center_x(scroll_down_indicator_arrow:center_x())
end

function ScrollablePanel:on_canvas_updated_callback(callback)
	self._on_canvas_updated = callback
end

function ScrollablePanel:canvas_max_width()
	return self:scroll_panel():w()
end

function ScrollablePanel:canvas_scroll_width()
	return self:scroll_panel():w() - self:padding() - 5
end

function ScrollablePanel:canvas_scroll_height()
	return self:scroll_panel():h()
end

function ScrollablePanel:update_canvas_size()
	local orig_w = self:canvas():w()
	local max_h = 0
	for i, panel in ipairs(self:canvas():children()) do
		local h = panel:y() + panel:h()
		if max_h < h then
			max_h = h
		end
	end
	local show_scrollbar = max_h > self:canvas_scroll_height()
	local max_w = show_scrollbar and self:canvas_scroll_width() or self:canvas_max_width()
	self:canvas():grow(max_w - self:canvas():w(), max_h - self:canvas():h())
	if self._on_canvas_updated then
		self._on_canvas_updated(max_w)
	end
	max_h = 0
	for i, panel in ipairs(self:canvas():children()) do
		local h = panel:y() + panel:h()
		if max_h < h then
			max_h = h
		end
	end
	if max_h <= self:scroll_panel():h() then
		max_h = self:scroll_panel():h()
	end
	self:set_canvas_size(nil, max_h)
end

function ScrollablePanel:set_canvas_size(w, h)
	if w == nil then
		w = self:canvas():w()
	end
	if h == nil then
		h = self:canvas():h()
	end
	if h <= self:scroll_panel():h() then
		h = self:scroll_panel():h()
		self:canvas():set_y(0)
	end
	self:canvas():set_size(w, h)
	local show_scrollbar = h > self:scroll_panel():h()
	if not show_scrollbar then
		self._scroll_bar:set_alpha(0)
		self._scroll_bar:set_visible(false)
		self._scroll_bar_box_class:hide()
		self:set_element_alpha_target("scroll_up_indicator_arrow", 0, 100)
		self:set_element_alpha_target("scroll_down_indicator_arrow", 0, 100)
		self:set_element_alpha_target("scroll_up_indicator_shade", 0, 100)
		self:set_element_alpha_target("scroll_down_indicator_shade", 0, 100)
	else
		self._scroll_bar:set_alpha(1)
		self._scroll_bar:set_visible(true)
		self._scroll_bar_box_class:show()
		self:_set_scroll_indicator()
		self:_check_scroll_indicator_states()
	end
end

function ScrollablePanel:set_element_alpha_target(element, target, speed)
	local element_name = type(element) == "string" and element or element:name()
	self._alphas[element_name] = {
		current = self._alphas[element_name] and self._alphas[element_name].current or element.alpha and element:alpha() or 1,
		target = target,
		speed = speed or self._alphas[element_name] and self._alphas[element_name].speed or 5
	}
end

function ScrollablePanel:is_scrollable()
	return self:canvas():h() > self:scroll_panel():h()
end

function ScrollablePanel:scroll(x, y, direction)
	if self:panel():inside(x, y) then
		self:perform_scroll(SCROLL_SPEED * TimerManager:main():delta_time() * 200, direction)
		return true
	end
end

function ScrollablePanel:perform_scroll(speed, direction)
	if self:canvas():h() <= self:scroll_panel():h() then
		return
	end
	local scroll_amount = speed * direction
	local max_h = self:canvas():h() - self:scroll_panel():h()
	max_h = max_h * -1
	local new_y = math.clamp(self:canvas():y() + scroll_amount, max_h, 0)
	self:canvas():set_y(new_y)
	self:_set_scroll_indicator()
	self:_check_scroll_indicator_states()
end

function ScrollablePanel:scroll_to(y)
	if self:canvas():h() <= self:scroll_panel():h() then
		return
	end
	local scroll_amount = -y
	local max_h = self:canvas():h() - self:scroll_panel():h()
	max_h = max_h * -1
	local new_y = math.clamp(scroll_amount, max_h, 0)
	self:canvas():set_y(new_y)
	self:_set_scroll_indicator()
	self:_check_scroll_indicator_states()
end

function ScrollablePanel:scroll_with_bar(target_y, current_y)
	local arrow_size = self:panel():child("scroll_up_indicator_arrow"):size()
	local scroll_panel = self:scroll_panel()
	local canvas = self:canvas()
	if target_y < current_y then
		if target_y < scroll_panel:world_bottom() - arrow_size then
			local mul = (scroll_panel:h() - arrow_size * 2) / canvas:h()
			self:perform_scroll((current_y - target_y) / mul, 1)
		end
		current_y = target_y
	elseif target_y > current_y then
		if target_y > scroll_panel:world_y() + arrow_size then
			local mul = (scroll_panel:h() - arrow_size * 2) / canvas:h()
			self:perform_scroll((target_y - current_y) / mul, -1)
		end
		current_y = target_y
	end
end

function ScrollablePanel:release_scroll_bar()
	self._pressing_arrow_up = false
	self._pressing_arrow_down = false
	if self._grabbed_scroll_bar then
		self._grabbed_scroll_bar = false
		return true
	end
end

function ScrollablePanel:_set_scroll_indicator()
	local bar_h = self:panel():child("scroll_down_indicator_arrow"):top() - self:panel():child("scroll_up_indicator_arrow"):bottom()
	if self:canvas():h() ~= 0 then
		self._scroll_bar:set_h(bar_h * self:scroll_panel():h() / self:canvas():h())
	end
end

function ScrollablePanel:_check_scroll_indicator_states()
	local up_alpha = self:canvas():top() < 0 and 1 or 0
	local down_alpha = self:canvas():bottom() > self:scroll_panel():h() and 1 or 0
	self:set_element_alpha_target("scroll_up_indicator_arrow", up_alpha, FADEOUT_SPEED)
	self:set_element_alpha_target("scroll_down_indicator_arrow", down_alpha, FADEOUT_SPEED)
	if 0 < self:padding() or self._force_scroll_indicators then
		self:set_element_alpha_target("scroll_up_indicator_shade", up_alpha, FADEOUT_SPEED)
		self:set_element_alpha_target("scroll_down_indicator_shade", down_alpha, FADEOUT_SPEED)
	end
	local up_arrow = self:panel():child("scroll_up_indicator_arrow")
	local sh = self:canvas():h() ~= 0 and self:canvas():h() or 1
	self._scroll_bar:set_top(up_arrow:bottom() - self:canvas():top() * (self:scroll_panel():h() - up_arrow:h() * 2 - 16) / sh)
end

function ScrollablePanel._update(o, self)
	while true do
		local dt = coroutine.yield()
		for element_name, data in pairs(self._alphas) do
			data.current = math.step(data.current, data.target, dt * data.speed)
			local element = self:panel():child(element_name)
			if alive(element) then
				element:set_alpha(data.current)
			end
		end
	end
end

function ScrollablePanel:mouse_moved(button, x, y)
	if self._grabbed_scroll_bar then
		self:scroll_with_bar(y, self._current_y)
		self._current_y = y
		return true, "grab"
	elseif alive(self._scroll_bar) and self._scroll_bar:visible() and self._scroll_bar:inside(x, y) then
		return true, "hand"
	elseif self:panel():child("scroll_up_indicator_arrow"):inside(x, y) then
		if self._pressing_arrow_up then
			self:perform_scroll(SCROLL_SPEED * 0.1, 1)
		end
		return true, "link"
	elseif self:panel():child("scroll_down_indicator_arrow"):inside(x, y) then
		if self._pressing_arrow_down then
			self:perform_scroll(SCROLL_SPEED * 0.1, -1)
		end
		return true, "link"
	end
end

function ScrollablePanel:mouse_clicked(o, button, x, y)
	if alive(self._scroll_bar) and self._scroll_bar:visible() and self._scroll_bar:inside(x, y) then
		return true
	end
end

function ScrollablePanel:mouse_pressed(button, x, y)
	if alive(self._scroll_bar) and self._scroll_bar:visible() and self._scroll_bar:inside(x, y) then
		self._grabbed_scroll_bar = true
		self._current_y = y
		return true
	elseif self:panel():child("scroll_up_indicator_arrow"):inside(x, y) then
		self._pressing_arrow_up = true
		return true
	elseif self:panel():child("scroll_down_indicator_arrow"):inside(x, y) then
		self._pressing_arrow_down = true
		return true
	end
end

function ScrollablePanel:mouse_released(button, x, y)
	return self:release_scroll_bar()
end
