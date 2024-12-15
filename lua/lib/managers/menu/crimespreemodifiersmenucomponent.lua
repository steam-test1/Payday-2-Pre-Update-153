CrimeSpreeModifiersMenuComponent = CrimeSpreeModifiersMenuComponent or class(MenuGuiComponentGeneric)
local padding = 10

function CrimeSpreeModifiersMenuComponent:init(ws, fullscreen_ws, node)
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._init_layer = self._ws:panel():layer()
	self._buttons = {}
	self:_setup()
end

function CrimeSpreeModifiersMenuComponent:close()
	self._ws:panel():remove(self._panel)
	self._ws:panel():remove(self._text_header)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
end

function CrimeSpreeModifiersMenuComponent:_setup()
	local modifiers, modifiers_name = self:get_modifers()
	local parent = self._ws:panel()
	if alive(self._panel) then
		parent:remove(self._panel)
	end
	self._panel = self._ws:panel():panel({layer = 51})
	self._fullscreen_panel = self._fullscreen_ws:panel():panel({layer = 50})
	self._fullscreen_panel:rect({
		color = Color.black,
		alpha = 0.75,
		layer = 0
	})
	local blur = self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_ws:panel():w(),
		h = self._fullscreen_ws:panel():h(),
		render_template = "VertexColorTexturedBlur3D"
	})
	local func = function(o)
		local start_blur = 0
		over(0.6, function(p)
			o:set_alpha(math.lerp(start_blur, 1, p))
		end)
	end
	blur:animate(func)
	self._panel:set_w((CrimeSpreeModifierButton.size.w + padding) * tweak_data.crime_spree.max_modifiers_displayed + padding)
	self._panel:set_h(CrimeSpreeModifierButton.size.h + padding * 3 + tweak_data.menu.pd2_large_font_size)
	self._panel:set_center_x(parent:center_x())
	self._panel:set_center_y(parent:center_y())
	self._text_header = self._ws:panel():text({
		text = managers.localization:to_upper_text("menu_cs_modifiers_" .. tostring(modifiers_name)),
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text,
		layer = 51
	})
	local x, y, w, h = self._text_header:text_rect()
	self._text_header:set_size(self._panel:w(), h)
	self._text_header:set_left(self._panel:left())
	self._text_header:set_bottom(self._panel:top())
	self._modifiers_panel = self._panel:panel({
		w = self._panel:w(),
		h = self._panel:h() - tweak_data.menu.pd2_large_font_size - padding * 2
	})
	self._button_panel = self._panel:panel({
		y = self._modifiers_panel:bottom() + padding,
		w = self._panel:w(),
		h = tweak_data.menu.pd2_large_font_size
	})
	for i, modifier in ipairs(modifiers) do
		local btn = CrimeSpreeModifierButton:new(self._modifiers_panel, i, modifier)
		btn:set_callback(callback(self, self, "_on_select_modifier", btn))
		table.insert(self._buttons, btn)
	end
	local finalize_btn = CrimeSpreeButton:new(self._button_panel)
	finalize_btn:set_text(managers.localization:to_upper_text("menu_cs_select_modifier"))
	finalize_btn:set_callback(callback(self, self, "_on_finalize_modifier"))
	table.insert(self._buttons, finalize_btn)
	for i, modifier in ipairs(modifiers) do
		local btn = self._buttons[i]
		if 1 < i then
			btn:set_link("left", self._buttons[i - 1])
		end
		if i < #modifiers then
			btn:set_link("right", self._buttons[i + 1])
		end
		btn:set_link("down", finalize_btn)
	end
	finalize_btn:set_link("up", self._buttons[1])
	BoxGuiObject:new(self._panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	if not managers.menu:is_pc_controller() then
		self:_move_selection("up")
	end
end

function CrimeSpreeModifiersMenuComponent:get_modifers()
	local loud = managers.crime_spree:modifiers_to_select("loud")
	local stealth = managers.crime_spree:modifiers_to_select("stealth")
	if 0 < loud then
		return managers.crime_spree:get_loud_modifiers(), "loud"
	elseif 0 < stealth then
		return managers.crime_spree:get_stealth_modifiers(), "stealth"
	else
		Application:error("Showing Crime Spree modifiers menu when there are no modifiers to select!")
		return {}, "loud"
	end
end

function CrimeSpreeModifiersMenuComponent:_on_select_modifier(item)
	if self._selected_modifier then
		self._selected_modifier:set_active(false)
	end
	self._selected_modifier = item
	self._selected_modifier:set_active(true)
	managers.menu_component:post_event("menu_enter")
end

function CrimeSpreeModifiersMenuComponent:_on_finalize_modifier()
	if not self._selected_modifier then
		managers.menu:post_event("menu_error")
		return
	end
	managers.crime_spree:select_modifier(self._selected_modifier:data().id)
	MenuCallbackHandler:save_progress()
	managers.menu:back(false)
	managers.menu:active_menu().logic:refresh_node("crime_spree_lobby")
	managers.menu_component:post_event("item_buy")
end

function CrimeSpreeModifiersMenuComponent:update(t, dt)
	for idx, btn in ipairs(self._buttons) do
		btn:update(t, dt)
	end
end

function CrimeSpreeModifiersMenuComponent:confirm_pressed()
	if self._selected_item and self._selected_item:callback() then
		self._selected_item:callback()()
	end
end

function CrimeSpreeModifiersMenuComponent:mouse_moved(o, x, y)
	if not managers.menu:is_pc_controller() then
		return
	end
	local used, pointer
	self._selected_item = nil
	for idx, btn in ipairs(self._buttons) do
		btn:set_selected(btn:inside(x, y))
		if btn:is_selected() then
			self._selected_item = btn
			used, pointer = true, "link"
		end
	end
	return used, pointer
end

function CrimeSpreeModifiersMenuComponent:mouse_pressed(o, button, x, y)
	for idx, btn in ipairs(self._buttons) do
		if btn:is_selected() and btn:callback() then
			btn:callback()()
			return true
		end
	end
end

function CrimeSpreeModifiersMenuComponent:_move_selection(dir)
	if not self._selected_item then
		self._selected_item = self._buttons[1]
		self._selected_item:set_selected(true)
	else
		local new_item = self._selected_item:get_link(dir)
		if new_item then
			self._selected_item:set_selected(false)
			new_item:set_selected(true)
			self._selected_item = new_item
		end
	end
end

function CrimeSpreeModifiersMenuComponent:move_up()
	self:_move_selection("up")
end

function CrimeSpreeModifiersMenuComponent:move_down()
	self:_move_selection("down")
end

function CrimeSpreeModifiersMenuComponent:move_left()
	self:_move_selection("left")
end

function CrimeSpreeModifiersMenuComponent:move_right()
	self:_move_selection("right")
end

CrimeSpreeModifierButton = CrimeSpreeModifierButton or class(MenuGuiItem)
CrimeSpreeModifierButton._type = "CrimeSpreeModifierButton"
CrimeSpreeModifierButton.size = {w = 208, h = 256}

function CrimeSpreeModifierButton:init(parent, idx, data)
	self._data = data
	self._index = idx
	self._links = {}
	local modifier_class = _G[self._data.class]
	self._panel = parent:panel({
		w = CrimeSpreeModifierButton.size.w,
		h = CrimeSpreeModifierButton.size.h,
		layer = 1000
	})
	self._panel:set_x(padding + (CrimeSpreeModifierButton.size.w + padding) * (idx - 1))
	self._panel:set_y(padding)
	local top_padding = padding * 2
	self._image_size = 128
	self._size_modifier = 0.8
	self._image = self._panel:panel({
		y = top_padding,
		w = self._image_size,
		h = self._image_size
	})
	self._image:set_center_x(self._panel:w() * 0.5)
	self._image_pos = {
		x = self._image:center_x(),
		y = self._image:center_y()
	}
	local texture, rect = tweak_data.hud_icons:get_icon_data(self._data.icon)
	local image = self._image:bitmap({
		name = "chat_blur",
		texture = texture,
		texture_rect = rect,
		layer = 10,
		valign = "grow",
		halign = "grow",
		blend_mode = "add"
	})
	self._desc = self._panel:text({
		text = modifier_class:get_description(self._data.id),
		align = "center",
		vertical = "top",
		x = padding,
		y = self._image:bottom() + top_padding,
		w = self._panel:w() - padding * 2,
		h = self._panel:h() - self._image:bottom() - top_padding - padding,
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = tweak_data.screen_colors.text,
		wrap = true,
		wrap_word = true
	})
	self._bg = self._panel:rect({
		color = Color.black,
		alpha = 0.4,
		layer = -1
	})
	self._highlight = self._panel:rect({
		color = tweak_data.screen_colors.button_stage_3,
		blend_mode = "add",
		alpha = 0.4,
		layer = 10
	})
	BoxGuiObject:new(self._panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._active_outline = BoxGuiObject:new(self._panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	self._image:set_size(self._image_size * self._size_modifier, self._image_size * self._size_modifier)
	self._image:set_center(self._image_pos.x, self._image_pos.y)
	self:refresh()
end

function CrimeSpreeModifierButton:refresh()
	self._bg:set_visible(not self:is_selected())
	self._highlight:set_visible(self:is_selected())
	self._active_outline:set_visible(self:is_active())
end

function CrimeSpreeModifierButton:inside(x, y)
	return self._panel:inside(x, y)
end

function CrimeSpreeModifierButton:data()
	return self._data
end

function CrimeSpreeModifierButton:callback()
	return self._callback
end

function CrimeSpreeModifierButton:set_callback(clbk)
	self._callback = clbk
end

function CrimeSpreeModifierButton:get_link(dir)
	return self._links[dir]
end

function CrimeSpreeModifierButton:set_link(dir, item)
	self._links[dir] = item
end

function CrimeSpreeModifierButton:update(t, dt)
	local desired_size = self._image_size * ((self:is_selected() or self:is_active()) and 1 or 0.8)
	local s = self:smoothstep(self._image:w(), desired_size, 500 * dt, 100)
	self._image:set_size(s, s)
	self._image:set_center_x(self._image_pos.x)
	self._image:set_center_y(self._image_pos.y)
end

function CrimeSpreeModifierButton:smoothstep(a, b, step, n)
	local v = step / n
	v = 1 - (1 - v) * (1 - v)
	local x = a * (1 - v) + b * v
	return x
end

CrimeSpreeButton = CrimeSpreeButton or class(MenuGuiItem)
CrimeSpreeButton._type = "CrimeSpreeButton"

function CrimeSpreeButton:init(parent)
	self._w = 0.35
	self._color = tweak_data.screen_colors.button_stage_3
	self._selected_color = tweak_data.screen_colors.button_stage_2
	self._links = {}
	self._panel = parent:panel({
		x = parent:w() * (1 - self._w) - padding,
		w = parent:w() * self._w,
		h = tweak_data.menu.pd2_medium_font_size,
		layer = 1000
	})
	self._panel:set_bottom(parent:h())
	self._text = self._panel:text({
		text = "",
		align = "right",
		halign = "right",
		layer = 1,
		x = 0,
		y = 0,
		color = self._color,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		blend_mode = "add"
	})
	self._highlight = self._panel:rect({
		color = self._color,
		alpha = 0.3,
		blend_mode = "add",
		layer = 10
	})
	self:refresh()
end

function CrimeSpreeButton:refresh()
	self._highlight:set_visible(self:is_selected())
	self._highlight:set_color(self:is_selected() and self._selected_color or self._color)
	self._text:set_color(self:is_selected() and self._selected_color or self._color)
end

function CrimeSpreeButton:inside(x, y)
	return self._panel:inside(x, y)
end

function CrimeSpreeButton:callback()
	return self._callback
end

function CrimeSpreeButton:set_callback(clbk)
	self._callback = clbk
end

function CrimeSpreeButton:set_button(btn)
	self._btn = btn
end

function CrimeSpreeButton:set_text(text)
	local prefix = not managers.menu:is_pc_controller() and self._btn and managers.localization:get_default_macro(self._btn) or ""
	self._text:set_text(prefix .. text)
end

function CrimeSpreeButton:get_link(dir)
	return self._links[dir]
end

function CrimeSpreeButton:set_link(dir, item)
	self._links[dir] = item
end

function CrimeSpreeButton:update(t, dt)
end
