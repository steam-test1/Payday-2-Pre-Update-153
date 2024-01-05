MenuNodeUpdatesGui = MenuNodeUpdatesGui or class(MenuNodeGui)

function MenuNodeUpdatesGui:init(node, layer, parameters)
	MenuNodeUpdatesGui.super.init(self, node, layer, parameters)
	local ws = self.ws
	local panel = ws:panel()
	local title_text = managers.localization:to_upper_text("menu_content_updates")
	panel:text({
		text = title_text,
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text
	})
	local back_button = panel:text({
		name = "back_button",
		text = managers.localization:to_upper_text("menu_back"),
		align = "right",
		vertical = "bottom",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.button_stage_3
	})
	self:make_fine_text(back_button)
	back_button:set_right(panel:w())
	back_button:set_bottom(panel:h())
	back_button:set_visible(managers.menu:is_pc_controller())
	if MenuBackdropGUI then
		local bg_text = panel:text({
			text = title_text,
			align = "left",
			vertical = "top",
			font_size = tweak_data.menu.pd2_massive_font_size,
			font = tweak_data.menu.pd2_massive_font,
			color = tweak_data.screen_colors.button_stage_3,
			alpha = 0.4,
			layer = -1,
			rotation = 360
		})
		self:make_fine_text(bg_text)
		bg_text:move(-13, -9)
		MenuBackdropGUI.animate_bg_text(self, bg_text)
		if managers.menu:is_pc_controller() then
			local bg_back = panel:text({
				text = managers.localization:to_upper_text("menu_back"),
				align = "right",
				vertical = "bottom",
				font_size = tweak_data.menu.pd2_massive_font_size,
				font = tweak_data.menu.pd2_massive_font,
				color = tweak_data.screen_colors.button_stage_3,
				alpha = 0.4,
				layer = -1,
				rotation = 360
			})
			self:make_fine_text(bg_back)
			bg_back:move(13, 9)
			MenuBackdropGUI.animate_bg_text(self, bg_back)
		end
	end
	self._requested_textures = {}
	local num_previous_updates = tweak_data.gui.num_previous_updates
	local content_updates = tweak_data.gui.content_updates or {}
	local previous_updates = {}
	local latest_update = content_updates[#content_updates]
	for i = #content_updates - 1, math.max(#content_updates - num_previous_updates, 1), -1 do
		table.insert(previous_updates, content_updates[i])
	end
	self._lastest_content_update = latest_update
	self._previous_content_updates = previous_updates
	local latest_update_panel = panel:panel({
		name = "lastest_content_update",
		w = panel:w() / 2,
		h = panel:w() / 4,
		x = 0,
		y = 70
	})
	local selected = BoxGuiObject:new(latest_update_panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	BoxGuiObject:new(latest_update_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._selects = {}
	self._selects[latest_update.id] = selected
	self._select_x = 0
	self._select_y = 0
	local texture_count = managers.menu_component:request_texture(latest_update.image, callback(self, self, "texture_done_clbk", latest_update_panel))
	table.insert(self._requested_textures, {
		count = texture_count,
		texture = latest_update.image
	})
	local w = latest_update_panel:w()
	local padding = 10
	local latest_desc_panel = panel:panel({
		name = "latest_description",
		w = panel:w() - latest_update_panel:w() - 30,
		h = latest_update_panel:h(),
		x = latest_update_panel:right() + 30,
		y = latest_update_panel:top()
	})
	BoxGuiObject:new(latest_desc_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local title_string = managers.localization:to_upper_text(latest_update.name_id)
	local date_string = managers.localization:to_upper_text(latest_update.date_id)
	local desc_string = managers.localization:text(latest_update.desc_id)
	local title_text = latest_desc_panel:text({
		name = "title_text",
		text = title_string,
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		color = tweak_data.screen_colors.text,
		x = padding,
		y = padding,
		wrap = true,
		word_wrap = true
	})
	local date_text = latest_desc_panel:text({
		name = "date_text",
		text = date_string,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text,
		x = padding,
		wrap = true,
		word_wrap = true
	})
	local desc_text = latest_desc_panel:text({
		name = "desc_text",
		text = desc_string,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.text,
		x = padding,
		wrap = true,
		word_wrap = true
	})
	do
		local x, y, w, h = title_text:text_rect()
		title_text:set_size(w, h)
	end
	do
		local x, y, w, h = date_text:text_rect()
		date_text:set_size(w, h)
	end
	do
		local x, y, w, h = desc_text:text_rect()
		desc_text:set_size(w, h)
	end
	date_text:set_top(title_text:bottom())
	desc_text:set_top(date_text:bottom())
	local small_width = w / num_previous_updates - padding * 2
	local previous_updates_panel = panel:panel({
		name = "previous_content_updates",
		w = latest_update_panel:w(),
		h = small_width / 2 + padding * 2,
		x = 0,
		y = latest_update_panel:bottom() + 40
	})
	local previous_update_text = panel:text({
		name = "previous_update_text",
		text = managers.localization:to_upper_text("menu_content_updates_previous"),
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text
	})
	self:make_fine_text(previous_update_text)
	previous_update_text:set_leftbottom(previous_updates_panel:left(), previous_updates_panel:top())
	local data
	for index, data in ipairs(previous_updates) do
		local w = small_width
		local h = small_width / 2
		local x = padding + (index - 1) * (w + padding * 2)
		local y = padding
		local content_panel = previous_updates_panel:panel({
			name = data.id,
			w = w,
			h = h,
			x = x,
			y = y
		})
		local texture_count = managers.menu_component:request_texture(data.image, callback(self, self, "texture_done_clbk", content_panel))
		table.insert(self._requested_textures, {
			count = texture_count,
			texture = data.image
		})
		local text = panel:text({
			name = data.name_id,
			text = managers.localization:to_upper_text(data.name_id),
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.text
		})
		self:make_fine_text(text)
		if index == 1 then
			previous_updates_panel:grow(0, text:h() + padding * 0.5)
		end
		text:set_world_x(content_panel:world_x())
		text:set_bottom(previous_updates_panel:bottom() - padding + 1)
		local selected = BoxGuiObject:new(content_panel, {
			sides = {
				2,
				2,
				2,
				2
			}
		})
		self._selects[data.id] = selected
	end
	BoxGuiObject:new(previous_updates_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	for i, box in pairs(self._selects) do
		box:hide()
	end
end

function MenuNodeUpdatesGui:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(x), math.round(y))
end

function MenuNodeUpdatesGui:texture_done_clbk(panel, texture_ids)
	panel:bitmap({
		texture = texture_ids,
		w = panel:w(),
		h = panel:h()
	})
	self._requested_textures[texture_ids:key()] = nil
end

function MenuNodeUpdatesGui:check_inside(x, y)
	local ws = self.ws
	local panel = ws:panel()
	local latest_update_panel = panel:child("lastest_content_update")
	local previous_updates_panel = panel:child("previous_content_updates")
	if latest_update_panel:inside(x, y) then
		self._select_y = 1
		return self._lastest_content_update
	elseif previous_updates_panel:inside(x, y) then
		local child
		for index, data in ipairs(self._previous_content_updates) do
			child = previous_updates_panel:child(data.id)
			if alive(child) and child:inside(x, y) then
				self._select_x = index
				self._select_y = 2
				return data
			end
		end
	end
	return nil
end

function MenuNodeUpdatesGui:mouse_moved(o, x, y)
	local moved = self._mouse_x ~= x or self._mouse_y ~= y
	self._mouse_x = x
	self._mouse_y = y
	local ws = self.ws
	local panel = ws:panel()
	local back_button = panel:child("back_button")
	local back_highlighted = back_button:inside(x, y)
	if back_highlighted then
		if not self._back_button_highlighted then
			self._back_button_highlighted = true
			back_button:set_color(tweak_data.screen_colors.button_stage_2)
			managers.menu_component:post_event("highlight")
		end
		return true, self._pressed and "arrow" or "link"
	elseif self._back_button_highlighted then
		self._back_button_highlighted = false
		back_button:set_color(tweak_data.screen_colors.button_stage_3)
	end
	local content_highlighted = self:check_inside(x, y)
	for id, box in pairs(self._selects) do
		box:set_visible(content_highlighted and content_highlighted.id == id)
	end
	if content_highlighted then
		if moved and self._content_highlighted ~= content_highlighted then
			self._content_highlighted = content_highlighted
			managers.menu_component:post_event("highlight")
		end
		return true, self._pressed and (self._pressed == content_highlighted and "link" or "arrow") or "link"
	elseif self._content_highlighted then
		self._content_highlighted = false
	end
	return true, "arrow"
end

function MenuNodeUpdatesGui:mouse_pressed(button, x, y)
	self._pressed = self:check_inside(x, y)
	local ws = self.ws
	local panel = ws:panel()
	local back_button = panel:child("back_button")
	if back_button:inside(x, y) then
		managers.menu:back(true)
	end
end

function MenuNodeUpdatesGui:mouse_released(button, x, y)
	local released = self:check_inside(x, y)
	if released and released == self._pressed then
		self:open(released)
	end
	self._pressed = nil
end

function MenuNodeUpdatesGui:confirm_pressed()
	if self._content_highlighted then
		self:open(self._content_highlighted)
	end
end

function MenuNodeUpdatesGui:open(content_update)
	self._content_highlighted = content_update
	managers.menu_component:post_event("menu_enter")
	managers.player:set_content_update_viewed(content_update.id)
	if content_update.webpage then
		Steam:overlay_activate("url", content_update.webpage)
	elseif content_update.store then
		Steam:overlay_activate("store", content_update.store)
	end
end

function MenuNodeUpdatesGui:input_focus()
	return 1
end

function MenuNodeUpdatesGui:move_highlight(x, y)
	local ws = self.ws
	local panel = ws:panel()
	local latest_update_panel = panel:child("lastest_content_update")
	local previous_updates_panel = panel:child("previous_content_updates")
	local content_highlighted = self._content_highlighted
	if not content_highlighted then
		content_highlighted = self._lastest_content_update
		self._select_y = 1
	else
		self._select_x = math.clamp(self._select_x + x, 1, #self._previous_content_updates)
		self._select_y = math.clamp(self._select_y + y, 1, 2)
		if self._select_y == 1 then
			content_highlighted = self._lastest_content_update
		else
			content_highlighted = self._previous_content_updates[self._select_x]
		end
	end
	for id, box in pairs(self._selects) do
		box:set_visible(content_highlighted and content_highlighted.id == id)
	end
	if content_highlighted then
		if self._content_highlighted ~= content_highlighted then
			self._content_highlighted = content_highlighted
			managers.menu_component:post_event("highlight")
		end
	elseif self._content_highlighted then
		self._content_highlighted = false
	end
end

function MenuNodeUpdatesGui:move_up()
	self:move_highlight(0, -1)
	return true
end

function MenuNodeUpdatesGui:move_down()
	self:move_highlight(0, 1)
	return true
end

function MenuNodeUpdatesGui:move_left()
	self:move_highlight(-1, 0)
	return true
end

function MenuNodeUpdatesGui:move_right()
	self:move_highlight(1, 0)
	return true
end

function MenuNodeUpdatesGui:close()
	for i, data in pairs(self._requested_textures) do
		managers.menu_component:unretrieve_texture(data.texture, data.texture_count)
	end
	MenuNodeUpdatesGui.super.close(self)
end

function MenuNodeUpdatesGui:_setup_panels(node)
	MenuNodeUpdatesGui.super._setup_panels(self, node)
end
