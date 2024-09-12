MultiProfileItemGui = MultiProfileItemGui or class()

function MultiProfileItemGui:init(ws, panel)
	self._ws = ws
	local profile_panel = self._panel or panel:panel({w = 280, h = 36})
	profile_panel:set_bottom(panel:bottom() - 4)
	profile_panel:set_center_x(panel:w() / 2)
	self._panel = profile_panel
	self._box_panel = panel:panel()
	self._box_panel:set_shape(profile_panel:shape())
	self._box = BoxGuiObject:new(self._box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._caret = self._panel:rect({
		name = "caret",
		x = 0,
		y = 0,
		w = 0,
		h = 0,
		color = Color(0.1, 1, 1, 1),
		blend_mode = "add"
	})
	self._max_length = 15
	self._name_editing_enabled = true
	self:update()
end

function MultiProfileItemGui:panel()
	return self._panel
end

function MultiProfileItemGui:set_name_editing_enabled(enabled)
	self._name_editing_enabled = enabled
end

function MultiProfileItemGui:update()
	local mult = managers.multi_profile
	local name = mult:current_profile_name()
	self._name_text = self._panel:child("name")
	if alive(self._name_text) then
		self._panel:remove(self._name_text)
	end
	self._name_text = self._panel:text({
		name = "name",
		text = name,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		align = "center",
		vertical = "center",
		color = tweak_data.screen_colors.button_stage_3
	})
	local text_width = self._name_text:w()
	self._name_text:set_w(text_width * 0.8)
	self._name_text:set_left(text_width * 0.1)
	local arrow_left = self._panel:child("arrow_left")
	arrow_left = arrow_left or self._panel:bitmap({
		name = "arrow_left",
		texture = "guis/textures/menu_arrows",
		texture_rect = {
			0,
			0,
			24,
			24
		},
		color = mult:has_previous() and tweak_data.screen_colors.button_stage_3 or tweak_data.menu.default_disabled_text_color,
		size = 32
	})
	local arrow_right = self._panel:child("arrow_right")
	arrow_right = arrow_right or self._panel:bitmap({
		name = "arrow_right",
		texture = "guis/textures/menu_arrows",
		texture_rect = {
			0,
			0,
			24,
			24
		},
		rotation = 180,
		color = mult:has_next() and tweak_data.screen_colors.button_stage_3 or tweak_data.menu.default_disabled_text_color,
		size = 32
	})
	arrow_left:set_left(0)
	arrow_right:set_right(self._panel:w())
	arrow_left:set_center_y(self._panel:h() / 2)
	arrow_right:set_center_y(self._panel:h() / 2)
	self:_update_caret()
end

function MultiProfileItemGui:mouse_moved(x, y)
	local anim_func = function(o, large)
		local current_width = o:w()
		local current_height = o:h()
		local end_width = large and 32 or 24
		local end_height = end_width
		local cx, cy = o:center()
		over(0.2, function(p)
			o:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
			o:set_center(cx, cy)
		end)
	end
	local mult = managers.multi_profile
	local pointer, used
	local arrow_left = self._panel:child("arrow_left")
	if arrow_left and mult:has_previous() then
		if arrow_left:inside(x, y) then
			if self._arrow_selection ~= "left" then
				arrow_left:animate(anim_func, true)
				managers.menu_component:post_event("highlight")
			end
			self._arrow_selection = "left"
			pointer = "link"
			used = true
		elseif self._arrow_selection == "left" then
			arrow_left:animate(anim_func, false)
			self._arrow_selection = nil
		end
	end
	local arrow_right = self._panel:child("arrow_right")
	if arrow_right and mult:has_next() then
		if arrow_right:inside(x, y) then
			if self._arrow_selection ~= "right" then
				arrow_right:animate(anim_func, true)
				managers.menu_component:post_event("highlight")
			end
			self._arrow_selection = "right"
			pointer = "link"
			used = true
		elseif self._arrow_selection == "right" then
			arrow_right:animate(anim_func, false)
			self._arrow_selection = nil
		end
	end
	if self._name_text:inside(x, y) then
		if not self._name_selection then
			self._name_text:set_color(tweak_data.screen_colors.button_stage_2)
			managers.menu_component:post_event("highlight")
		end
		self._name_selection = true
		pointer = "link"
		used = true
	elseif self._name_selection then
		self._name_text:set_color(tweak_data.screen_colors.button_stage_3)
		self._name_selection = false
	end
	return used, pointer
end

function MultiProfileItemGui:mouse_pressed(button, x, y)
	if button == Idstring("0") then
		if self:arrow_selection() == "left" then
			managers.multi_profile:previous_profile()
			managers.menu_component:post_event("menu_enter")
		elseif self:arrow_selection() == "right" then
			managers.multi_profile:next_profile()
			managers.menu_component:post_event("menu_enter")
		end
		if self._name_selection then
			self:trigger()
		end
	end
end

function MultiProfileItemGui:arrow_selection()
	return self._arrow_selection
end

function MultiProfileItemGui:set_editing(editing)
	if not self._name_editing_enabled then
		return
	end
	self._editing = editing
	if editing then
		managers.menu:active_menu().input:set_back_enabled(false)
		managers.menu:active_menu().input:accept_input(false)
		managers.menu:active_menu().input:set_force_input(false)
		managers.menu:active_menu().input:deactivate_mouse()
		self._ws:connect_keyboard(Input:keyboard())
		self._panel:key_press(callback(self, self, "key_press"))
		self._panel:key_release(callback(self, self, "key_release"))
		self._panel:enter_text(callback(self, self, "enter_text"))
		local n = utf8.len(self._name_text:text())
		self._name_text:set_selection(n, n)
	else
		managers.menu:active_menu().input:activate_mouse()
		managers.menu:active_menu().input:accept_input(true)
		managers.menu:active_menu().input:set_back_enabled(true)
		self._ws:disconnect_keyboard()
		self._panel:key_press(nil)
		self._panel:key_release(nil)
		self._panel:enter_text(nil)
	end
end

function MultiProfileItemGui.blink(o)
	while true do
		o:set_color(Color(0.05, 1, 1, 1))
		wait(0.4)
		o:set_color(Color(0.9, 1, 1, 1))
		wait(0.4)
	end
end

function MultiProfileItemGui:set_blinking(b)
	local caret = self._caret
	if b == self._blinking then
		return
	end
	if b then
		caret:animate(self.blink)
	else
		caret:stop()
	end
	self._blinking = b
	if not self._blinking then
		caret:set_color(Color(0.9, 1, 1, 1))
	end
end

function MultiProfileItemGui:_update_caret()
	local text = self._name_text
	local caret = self._caret
	local s, e = text:selection()
	local x, y, w, h = text:selection_rect()
	if s == 0 and e == 0 and utf8.len(text:text()) == 0 then
		x = text:world_center()
		y = text:world_y() + 6
	end
	h = text:line_height()
	if w < 3 then
		w = 3
	end
	if not self._editing then
		w = 0
		h = 0
	end
	caret:set_world_shape(x, y + 2, w, h, -8)
	self:set_blinking(s == e and self._editing)
end

function MultiProfileItemGui:update_key_down(o, k)
	wait(0.6)
	while self._key_pressed == k do
		self:handle_key(k, true)
		self:_update_caret()
		wait(0.03)
	end
end

function MultiProfileItemGui:key_press(o, k)
	if not self._editing then
		return
	end
	local text = self._name_text
	self._key_pressed = k
	text:stop()
	text:animate(callback(self, self, "update_key_down"), k)
	self:handle_key(k, true)
	self:_update_caret()
end

function MultiProfileItemGui:key_release(o, k)
	if not self._editing then
		return
	end
	if self._key_pressed == k then
		self._key_pressed = nil
	end
	self:handle_key(k, false)
	self:_update_caret()
end

function MultiProfileItemGui:trigger()
	if not self._editing then
		self:set_editing(true)
	else
		local mult = managers.multi_profile
		if mult:current_profile() then
			mult:current_profile().name = self._name_text:text()
		end
		self:set_editing(false)
	end
	self:_update_caret()
end

function MultiProfileItemGui:enter_text(o, s)
	if not self._editing then
		return
	end
	local s_len = utf8.len(self._name_text:text())
	s = utf8.sub(s, 1, self._max_length - s_len)
	self._name_text:replace_text(s)
end

function MultiProfileItemGui:handle_key(k, pressed)
	local text = self._name_text
	local s, e = text:selection()
	local n = utf8.len(text:text())
	local d = math.abs(e - s)
	if pressed then
		if k == Idstring("backspace") then
			if s == e and 0 < s then
				text:set_selection(s - 1, e)
			end
			text:replace_text("")
		elseif k == Idstring("delete") then
			if s == e and s < n then
				text:set_selection(s, e + 1)
			end
			text:replace_text("")
		elseif k == Idstring("left") then
			if s < e then
				text:set_selection(s, s)
			elseif 0 < s then
				text:set_selection(s - 1, s - 1)
			end
		elseif k == Idstring("right") then
			if s < e then
				text:set_selection(e, e)
			elseif s < n then
				text:set_selection(s + 1, s + 1)
			end
		elseif k == Idstring("home") then
			text:set_selection(0, 0)
		elseif k == Idstring("end") then
			text:set_selection(n, n)
		end
	elseif k == Idstring("enter") then
		self:trigger()
	elseif k == Idstring("esc") then
		text:set_text(managers.multi_profile:current_profile_name())
		self:set_editing(false)
	end
end
