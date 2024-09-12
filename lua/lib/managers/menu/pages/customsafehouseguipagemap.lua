local massive_font = tweak_data.menu.pd2_massive_font
local large_font = tweak_data.menu.pd2_large_font
local medium_font = tweak_data.menu.pd2_medium_font
local small_font = tweak_data.menu.pd2_small_font
local massive_font_size = tweak_data.menu.pd2_massive_font_size
local large_font_size = tweak_data.menu.pd2_large_font_size
local medium_font_size = tweak_data.menu.pd2_medium_font_size
local small_font_size = tweak_data.menu.pd2_small_font_size
local IS_WIN_32 = SystemInfo:platform() == Idstring("WIN32")
local NOT_WIN_32 = not IS_WIN_32
local WIDTH_MULTIPLIER = NOT_WIN_32 and 0.68 or 0.71
local BOX_GAP = 13.5
local PANEL_PADDING = 8
local LINE_PADDING = 4
local anim_select = function(o, w, h, instant)
	local current_width = o:w()
	local current_height = o:h()
	local end_width = w
	local end_height = h
	local cx, cy = o:center()
	if instant then
		o:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
		o:set_center(cx, cy)
	else
		over(0.2, function(p)
			o:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
			o:set_center(cx, cy)
		end)
	end
end
local anim_deselect = function(o, w, h, instant)
	local current_width = o:w()
	local current_height = o:h()
	local end_width = w * 0.8
	local end_height = h * 0.8
	local cx, cy = o:center()
	if instant then
		o:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
		o:set_center(cx, cy)
	else
		over(0.2, function(p)
			o:set_size(math.lerp(current_width, end_width, p), math.lerp(current_height, end_height, p))
			o:set_center(cx, cy)
		end)
	end
end
local anim_invalid = function(o)
	local color = tweak_data.screen_colors.item_stage_1
	o:set_color(color)
	local lerp_color
	over(0.4, function(t)
		lerp_color = math.lerp(color, tweak_data.screen_colors.important_1, 1 - t)
		o:set_color(lerp_color)
	end)
end
CustomSafehouseGuiPageMap = CustomSafehouseGuiPageMap or class(CustomSafehouseGuiPage)

function CustomSafehouseGuiPageMap:init(page_id, page_panel, fullscreen_panel, gui)
	CustomSafehouseGuiPageMap.super.init(self, page_id, page_panel, fullscreen_panel, gui)
	self.make_fine_text = BlackMarketGui.make_fine_text
	self:panel():set_layer(45)
	self:_setup_info_panel()
	self:_setup_map()
	self:_setup_help_text()
end

function CustomSafehouseGuiPageMap:_setup_map()
	self._scanline = self:panel():bitmap({
		name = "scanline",
		texture = "guis/dlcs/big_bank/textures/pd2/pre_planning/scanline",
		texture_rect = {
			0,
			0,
			self:panel():w(),
			64
		},
		h = 128,
		wrap_mode = "wrap",
		layer = 7,
		blend_mode = "add"
	})
	self._scanline:set_bottom(-math.random(100))
	self._map_size = tweak_data.safehouse.map.size
	self._map_panel = self:panel():panel({
		name = "map",
		layer = 0,
		w = self._map_size,
		h = self._map_size,
		alpha = 0.9
	})
	self._map_panel:set_center(self:panel():w() / 2, self:panel():h() / 2)
	self._map_x, self._map_y = self._map_panel:position()
	self._map_zoom = 0
	self._grid_panel = self._panel:panel({
		name = "grid",
		w = self._map_size,
		h = self._map_size
	})
	self._map_grid = self._grid_panel:bitmap({
		w = self._grid_panel:w(),
		h = self._grid_panel:h(),
		texture = "guis/dlcs/big_bank/textures/pd2/pre_planning/bg_grid",
		texture_rect = {
			0,
			0,
			self._grid_panel:w() * 2,
			self._grid_panel:h() * 2
		},
		layer = -1,
		wrap_mode = "wrap",
		blend_mode = "add",
		halign = "scale",
		valign = "scale"
	})
	self._min_zoom = 1
	self._max_zoom = 5
	self._lerp_map = {
		x = self._panel:w() / 2 - self._map_panel:w() / 2,
		y = self._panel:h() / 2 - self._map_panel:h() / 2,
		clbk = callback(self, self, "set_lerp_zoom", 0)
	}
	self._floors = {}
	self._all_points = {}
	self._selected_floor = 1
	for i, floor in ipairs(tweak_data.safehouse.map.floors) do
		local floor_map = CustomSafehouseMapFloor:new(self._panel, self._map_panel, floor)
		floor_map:hide()
		for _, id in pairs(floor.rooms) do
			local point = CustomSafehouseMapPoint:new(self, self._map_panel, id)
			floor_map:add_point(point)
			table.insert(self._all_points, point)
			point:hide()
		end
		self._floors[i] = floor_map
	end
	if not managers.menu:is_pc_controller() then
		self._mouse_pointer = self._panel:bitmap({
			name = "pointer",
			texture = "guis/textures/mouse_pointer",
			texture_rect = {
				0,
				0,
				19,
				23
			},
			x = self._panel:w() / 2,
			y = self._panel:h() / 2,
			w = 19,
			h = 23,
			color = Color(1, 0.7, 0.7, 0.7),
			rotation = 360,
			layer = 1000
		})
		self._mouse_pointer:hide()
		self._wanted_pointer = {
			x = self._mouse_pointer:world_x(),
			y = self._mouse_pointer:world_y()
		}
	end
	self._floor_control_panel = self._panel:panel({
		name = "FloorControlPanel",
		layer = 20
	})
	self._floor_control_panel:rect({
		color = Color.black:with_alpha(0.5),
		halign = "scale",
		valign = "scale"
	})
	local title = self._floor_control_panel:text({
		name = "FloorControlTitle",
		text = managers.localization:to_upper_text("menu_cs_change_floor"),
		x = PANEL_PADDING,
		y = PANEL_PADDING,
		font = medium_font,
		font_size = medium_font_size,
		layer = 21
	})
	self:make_fine_text(title)
	local max_w = title:w() + PANEL_PADDING * 2
	local button_panel = self._floor_control_panel:panel({
		name = "FloorContolButtonPanel",
		y = title:bottom(),
		layer = 21
	})
	self._floor_control_buttons = {}
	local h = 0
	for i, floor in ipairs(self._floors) do
		local new_button = CustomSafehouseGuiButtonItem:new(button_panel, {
			name_id = floor:name_id(),
			align = "left",
			y = h,
			color = tweak_data.screen_colors.button_stage_3,
			custom = floor:name_id(),
			callback = callback(self, self, "floor_button_pressed")
		}, 0)
		self:make_fine_text(new_button._btn_text)
		new_button._btn_text:set_left(PANEL_PADDING)
		table.insert(self._floor_control_buttons, new_button)
		max_w = math.max(new_button._btn_text:w() + PANEL_PADDING * 2, max_w)
		h = h + new_button._panel:h()
	end
	button_panel:set_w(max_w)
	button_panel:set_h(h + PANEL_PADDING)
	for _, btn in ipairs(self._floor_control_buttons) do
		btn._panel:set_w(max_w)
	end
	self._floor_control_panel:set_w(max_w)
	self._floor_control_panel:set_h(title:h() + button_panel:h() + PANEL_PADDING)
	self._floor_control_panel:set_left(PANEL_PADDING)
	self._floor_control_panel:set_bottom(self._panel:h() - PANEL_PADDING)
	BoxGuiObject:new(self._floor_control_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self:select_floor(self._selected_floor)
end

function CustomSafehouseGuiPageMap:map_to_panel(x, y)
	x = x + self._map_panel:x() / self:current_zoom()
	y = y + self._map_panel:y() / self:current_zoom()
	return x, y
end

function CustomSafehouseGuiPageMap:panel_to_map(x, y)
	x = x - self._map_panel:x() * self:current_zoom()
	y = y - self._map_panel:y() * self:current_zoom()
	return x, y
end

function CustomSafehouseGuiPageMap:map_to_world(x, y)
	x, y = self:map_to_panel(x, y)
	x = x + self._panel:world_x()
	y = y + self._panel:world_y()
	return x, y
end

function CustomSafehouseGuiPageMap:world_to_map(x, y)
	x = x - self._panel:world_x()
	y = y - self._panel:world_y()
	return self:panel_to_map(x, y)
end

function CustomSafehouseGuiPageMap:floor_button_pressed()
	if self._current_floor_button then
		self:select_floor(self._current_floor_button)
	else
		for i, button in ipairs(self._floor_control_buttons) do
			if button:is_selected() then
				self:select_floor(i)
				break
			end
		end
	end
end

function CustomSafehouseGuiPageMap:select_floor(floor)
	self:current_floor():hide()
	floor = math.clamp(floor, 1, #self._floors)
	self._selected_floor = floor
	local wanted_zoom = self:current_floor():start_zoom() and self:convert_zoom_to_map(self:current_floor():start_zoom()) or self._map_zoom
	self:_set_zoom(wanted_zoom, self._map_panel:w() / 2, self._map_panel:h() / 2)
	self:_set_map_position(-self._map_panel:w() / 2 + self._panel:w() / 2 - 240 * self:current_zoom(), -self._map_panel:h() / 2 + self._panel:h() / 2 + 200 * self:current_zoom())
	self:current_floor():set_zoom_value(self._map_zoom)
	self:current_floor():show()
	self:current_floor():update()
	self:refresh()
	self:set_title_text(managers.localization:to_upper_text(self:current_floor():name_id()))
	self:set_room_image(nil)
	self:set_warning_text("")
	self:set_help_text(self:current_floor():desc_id() and managers.localization:text(self:current_floor():desc_id()) or "")
	if self._mouse_pointer then
		self._mouse_pointer:set_visible(not self:current_floor():should_disable_cursor())
	end
	for i, button in ipairs(self._floor_control_buttons) do
		button:set_selected(i == floor)
		if i == floor then
			button:set_color(tweak_data.screen_colors.button_stage_3, tweak_data.screen_colors.text)
		else
			button:set_color(tweak_data.screen_colors.button_stage_3, tweak_data.screen_colors.button_stage_2)
		end
	end
end

function CustomSafehouseGuiPageMap:convert_zoom_to_map(wanted_zoom)
	return (wanted_zoom - self:current_floor():min_zoom() or self._min_zoom) / (self:current_floor():max_zoom() or self._max_zoom - self:current_floor():min_zoom() or self._min_zoom)
end

function CustomSafehouseGuiPageMap:cycle_floor()
	local floor = self._selected_floor % #self._floors + 1
	self:select_floor(floor)
end

function CustomSafehouseGuiPageMap:current_floor()
	return self._floors[self._selected_floor]
end

function CustomSafehouseGuiPageMap:_setup_info_panel()
	local buttons = {}
	if not managers.menu:is_pc_controller() then
		table.insert(buttons, {
			btn = "BTN_A",
			name_id = "menu_cs_upgrade_room"
		})
		table.insert(buttons, {
			btn = "BTN_Y",
			pc_btn = "menu_modify_item",
			name_id = "menu_cs_change_floor",
			callback = callback(self, self, "cycle_floor")
		})
	end
	local show_play_safehouse_btn = Global.game_settings.single_player or Network:is_server() or not managers.network:session()
	if show_play_safehouse_btn then
		table.insert(buttons, {
			btn = "BTN_X",
			pc_btn = "menu_remove_item",
			name_id = "menu_cs_enter_safehouse",
			callback = callback(self, self, "go_to_safehouse")
		})
	end
	local remaining_height = self:info_panel():h()
	
	local function new_info_panel(parent, name, h)
		local panel = parent:panel({
			name = name,
			layer = 1,
			w = parent:w(),
			h = h or remaining_height
		})
		BoxGuiObject:new(panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		remaining_height = remaining_height - h - BOX_GAP
		return panel
	end
	
	if show_play_safehouse_btn then
		self._buttons_panel = new_info_panel(self:info_panel(), "ButtonsPanel", small_font_size * #buttons + PANEL_PADDING * 2 + LINE_PADDING)
	end
	self._coins_panel = new_info_panel(self:info_panel(), "CoinsInfoPanel", small_font_size * 2 + PANEL_PADDING * 2 + LINE_PADDING)
	self._text_info_panel = new_info_panel(self:info_panel(), "TextInfoPanel", remaining_height)
	local panels = {
		self._text_info_panel,
		self._coins_panel
	}
	if show_play_safehouse_btn then
		table.insert(panels, self._buttons_panel)
	end
	self:stack_panels(BOX_GAP, panels)
	self._buttons = {}
	self._controllers_pc_mapping = {}
	self._controllers_mapping = {}
	local btn_x = 10
	for btn, btn_data in pairs(buttons) do
		local new_button = CustomSafehouseGuiButtonItem:new(self._buttons_panel, btn_data, btn_x, btn)
		self._buttons[btn] = new_button
		if btn_data.pc_btn then
			self._controllers_mapping[btn_data.pc_btn:key()] = new_button
		end
	end
	local coins_text = self._coins_panel:text({
		name = "CoinsText",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text,
		text = utf8.to_upper(managers.localization:text("menu_cs_coins"))
	})
	coins_text:set_left(PANEL_PADDING)
	coins_text:set_y(PANEL_PADDING)
	local coins_value = self._coins_panel:text({
		name = "CoinsValue",
		font_size = medium_font_size,
		font = medium_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text
	})
	coins_value:set_y(coins_text:y())
	self:update_coins_value()
	local total_upgrades_text = self._coins_panel:text({
		name = "TotalUpgradesText",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text,
		text = utf8.to_upper(managers.localization:text("menu_cs_total_upgrades"))
	})
	total_upgrades_text:set_left(PANEL_PADDING)
	total_upgrades_text:set_y(PANEL_PADDING + small_font_size + LINE_PADDING)
	local total_upgrades_value = self._coins_panel:text({
		name = "TotalUpgradesValue",
		font_size = medium_font_size,
		font = medium_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text,
		text = managers.localization:text("menu_cs_total_upgrades_value")
	})
	total_upgrades_value:set_y(total_upgrades_text:y())
	self:update_upgrades_purchased()
	local text_title = self._text_info_panel:text({
		name = "TitleText",
		font_size = medium_font_size,
		font = medium_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.title,
		text = "",
		w = self._text_info_panel:w() - PANEL_PADDING * 2,
		h = medium_font_size,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_title:set_left(PANEL_PADDING)
	text_title:set_top(PANEL_PADDING)
	local image_panel = self._text_info_panel:panel({
		name = "RoomImagePanel",
		layer = 10,
		x = PANEL_PADDING,
		w = self._text_info_panel:w() - PANEL_PADDING * 2
	})
	image_panel:set_h(image_panel:w() / 1.7777778)
	image_panel:set_top(text_title:bottom() + PANEL_PADDING)
	image_panel:set_visible(false)
	local room_image = image_panel:bitmap({
		name = "RoomImage",
		texture_rect = {
			0,
			0,
			512,
			256
		},
		layer = 40,
		w = image_panel:w(),
		h = image_panel:h()
	})
	local image_scanlines = image_panel:bitmap({
		name = "RoomImageScanlines",
		texture = "guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_effect",
		texture_rect = {
			0,
			0,
			512,
			512
		},
		wrap_mode = "wrap",
		layer = 50,
		w = image_panel:w(),
		h = image_panel:h() * 4,
		y = image_panel:h() * 2 * -1
	})
	self._scanline_effect = image_scanlines
	local text_warning = self._text_info_panel:text({
		name = "WarningText",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.important_1,
		text = "",
		wrap = true,
		word_wrap = true,
		w = self._text_info_panel:w() - PANEL_PADDING * 2,
		h = small_font_size * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_warning:set_left(PANEL_PADDING)
	text_warning:set_top(image_panel:bottom() + 10)
	local text_help = self._text_info_panel:text({
		name = "HelpText",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text,
		text = "",
		wrap = true,
		word_wrap = true,
		w = self._text_info_panel:w() - PANEL_PADDING * 2,
		h = self._text_info_panel:h() - PANEL_PADDING * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_help:set_left(PANEL_PADDING)
	text_help:set_top(text_warning:bottom())
end

function CustomSafehouseGuiPageMap:update_coins_value()
	local coins_value = self._coins_panel:child("CoinsValue")
	coins_value:set_text(managers.experience:cash_string(math.floor(managers.custom_safehouse:coins()), ""))
	self:_right_align(coins_value, self._coins_panel)
end

function CustomSafehouseGuiPageMap:update_upgrades_purchased()
	local macro = {
		owned = tostring(managers.custom_safehouse:total_room_unlocks_purchased()),
		total = tostring(managers.custom_safehouse:total_room_unlocks())
	}
	local upgrades_value = self._coins_panel:child("TotalUpgradesValue")
	upgrades_value:set_text(managers.localization:text("menu_cs_total_upgrades_value", macro))
	self:_right_align(upgrades_value, self._coins_panel)
end

function CustomSafehouseGuiPageMap:_right_align(text_element, panel)
	self:make_fine_text(text_element)
	text_element:set_right(panel:w() - 8)
end

function CustomSafehouseGuiPageMap:_go_to_safehouse()
	if Global.game_settings.single_player then
		MenuCallbackHandler:play_single_player()
		MenuCallbackHandler:start_single_player_job({job_id = "chill", difficulty = "normal"})
	else
		MenuCallbackHandler:start_job({job_id = "chill", difficulty = "normal"})
	end
end

function CustomSafehouseGuiPageMap:go_to_safehouse(params)
	if params and params.skip_question then
		self:_go_to_safehouse()
		return
	end
	local dialog_data = {}
	dialog_data.focus_button = 1
	dialog_data.title = managers.localization:text("dialog_safehouse_title")
	dialog_data.text = managers.localization:text("dialog_safehouse_goto_text")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_go_to_safehouse")
	local no_button = {}
	no_button.cancel_button = true
	no_button.text = managers.localization:text("dialog_no")
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function CustomSafehouseGuiPageMap:_setup_help_text()
	self._help_text = self._gui._panel:text({
		text = "",
		font = small_font,
		font_size = small_font_size,
		color = tweak_data.screen_colors.text,
		visible = false
	})
	self:make_fine_text(self._help_text)
	self._help_text:set_right(self._gui._panel:w())
end

function CustomSafehouseGuiPageMap:set_top_help_text(text_id, data)
	local text = ""
	if text_id then
		text = managers.localization:to_upper_text(text_id, data)
	end
	self._help_text:set_text(text)
	self:make_fine_text(self._help_text)
	self._help_text:set_right(self._gui._panel:w())
end

function CustomSafehouseGuiPageMap:get_legend()
	return {
		"move",
		"zoom",
		"back"
	}
end

function CustomSafehouseGuiPageMap:set_active(active)
	self._help_text:set_visible(active)
	CustomSafehouseGuiPageMap.super.set_active(self, active)
	if not managers.menu:is_pc_controller() and alive(self._mouse_pointer) then
		self._mouse_pointer:set_visible(active and not self:current_floor():should_disable_cursor())
	end
end

function CustomSafehouseGuiPageMap:set_pointer_image(type)
	local types = {
		arrow = {
			0,
			0,
			19,
			23
		},
		link = {
			20,
			0,
			19,
			23
		},
		hand = {
			40,
			0,
			19,
			23
		},
		grab = {
			60,
			0,
			19,
			23
		}
	}
	local rect = types[type]
	if rect and self._mouse_pointer_image ~= type then
		self._mouse_pointer_image = type
		self._mouse_pointer:set_texture_rect(rect[1], rect[2], rect[3], rect[4])
	end
end

function CustomSafehouseGuiPageMap:refresh()
	CustomSafehouseGuiPageMap.super.refresh(self)
	if not self._active then
		return
	end
	self:update_upgrades_purchased()
	self:update_coins_value()
	self:current_floor():refresh()
end

function CustomSafehouseGuiPageMap:set_title_text(text)
	local text_title = self._text_info_panel:child("TitleText")
	text_title:set_text(text)
	managers.menu_component:make_color_text(text_title)
	local image_panel = self._text_info_panel:child("RoomImagePanel")
	image_panel:set_top(text_title:bottom() + (IS_WIN_32 and 10 or 0))
	image_panel:set_visible(true)
	local text_warning = self._text_info_panel:child("WarningText")
	text_warning:set_top(image_panel:bottom() + (IS_WIN_32 and 10 or 0))
end

function CustomSafehouseGuiPageMap:set_room_image(image)
	local image_panel = self._text_info_panel:child("RoomImagePanel")
	local room_image = image_panel:child("RoomImage")
	if image then
		room_image:set_image(image)
		image_panel:set_visible(true)
	else
		image_panel:set_visible(false)
	end
end

function CustomSafehouseGuiPageMap:set_warning_text(text)
	if text and text ~= "" then
		local text_warning = self._text_info_panel:child("WarningText")
		text_warning:set_text(text)
		managers.menu_component:make_color_text(text_warning)
		local text_help = self._text_info_panel:child("HelpText")
		text_help:set_top(text_warning:bottom() + (IS_WIN_32 and 5 or 0))
	else
		local text_warning = self._text_info_panel:child("WarningText")
		text_warning:set_text("")
		self._text_info_panel:child("HelpText"):set_top(self._text_info_panel:child("RoomImagePanel"):bottom() + (IS_WIN_32 and 5 or 0))
	end
end

function CustomSafehouseGuiPageMap:set_help_text(text)
	local text_help = self._text_info_panel:child("HelpText")
	text_help:set_text(text)
	managers.menu_component:make_color_text(text_help)
	local image_panel = self._text_info_panel:child("RoomImagePanel")
	if image_panel:visible() then
		text_help:set_top(image_panel:bottom() + (IS_WIN_32 and 5 or 0))
	else
		text_help:set_top(image_panel:top())
	end
	self:_fix_help_text()
end

function CustomSafehouseGuiPageMap:_fix_help_text()
	local text_help = self._text_info_panel:child("HelpText")
	text_help:set_font_size(small_font_size)
	text_help:set_w(self._text_info_panel:w() - PANEL_PADDING * 2)
	self:make_fine_text(text_help)
	local max_h = self._text_info_panel:bottom() - self._text_info_panel:child("RoomImagePanel"):bottom()
	while max_h < text_help:h() do
		text_help:set_font_size(text_help:font_size() - 1)
		text_help:set_w(self._text_info_panel:w())
		self:make_fine_text(text_help)
	end
end

function CustomSafehouseGuiPageMap:confirm_pressed()
	self:current_floor():confirm_pressed()
end

function CustomSafehouseGuiPageMap:set_lerp_zoom(zoom)
	local min = self:min_zoom()
	local max = self:max_zoom()
	local new_zoom = math.clamp(zoom, min, max)
	if self._map_zoom ~= new_zoom then
		self._lerp_zoom = new_zoom
	end
end

function CustomSafehouseGuiPageMap:floor_offset()
	local floor_offset = {}
	floor_offset.x = (self:current_floor():x() or 0) * self._map_size * self:current_zoom()
	floor_offset.y = (self:current_floor():y() or 0) * self._map_size * self:current_zoom()
	floor_offset.w = (1 - (self:current_floor():w() or 1)) * self._map_size * self:current_zoom()
	floor_offset.h = (1 - (self:current_floor():h() or 1)) * self._map_size * self:current_zoom()
	return floor_offset
end

function CustomSafehouseGuiPageMap:update(t, dt)
	if not managers.menu:is_pc_controller() then
		if not (managers.system_menu and managers.system_menu:is_active()) or not not managers.system_menu:is_closing() then
			local axis_x, axis_y = managers.menu_component:get_left_controller_axis()
			if axis_x ~= 0 or axis_y ~= 0 then
				local speed = dt * 500
				self:_move_map_position(-axis_x * speed, axis_y * speed)
				self._lerp_map = nil
				self._lerp_zoom = nil
			end
			axis_x, axis_y = managers.menu_component:get_right_controller_axis()
			if axis_y ~= 0 then
				local zoomed = self:_change_zoom(axis_y * dt, self._mouse_pointer:x(), self._mouse_pointer:y())
				self._lerp_map = nil
				self._lerp_zoom = nil
				if zoomed and (not self._next_zoom or t > self._next_zoom) then
					self._next_zoom = t + math.lerp(0.2, 0.1, math.abs(axis_y))
					if 0 < axis_y then
						managers.menu_component:post_event("zoom_in")
					else
						managers.menu_component:post_event("zoom_out")
					end
				end
			else
				self._next_zoom = nil
			end
		end
		local x, y = self._mouse_pointer:world_position()
		local mouse_vec = Vector3(x, y, 0)
		local dist = 10000000
		local closest_point
		local point_selected = false
		for _, point in ipairs(self:current_floor():points()) do
			if not point_selected and point._panel:inside(x, y) then
				if not point:is_selected() then
					point:set_selected(true)
				end
				self:set_pointer_image("link")
				point_selected = true
			elseif point:is_selected() then
				point:set_selected(false)
				self:set_pointer_image("arrow")
			end
			local d = mvector3.distance(mouse_vec, Vector3(point._panel:world_center_x(), point._panel:world_center_y(), 0))
			if dist > d then
				closest_point = point
				dist = d
			end
		end
		local max_dist = 100
		if dist < max_dist then
			local px, py = closest_point._panel:world_center_x(), closest_point._panel:world_center_y()
			local dx, dy = math.abs(self._wanted_pointer.x - px), math.abs(self._wanted_pointer.y - py)
			if max_dist > dx and max_dist > dy then
				self._pointer_lerp = {x = px, y = py}
			else
				self._pointer_lerp = nil
			end
		else
			self._pointer_lerp = nil
		end
		local pforce = dt * 2
		if self._pointer_lerp then
			self._mouse_pointer:set_world_x(math.lerp(self._mouse_pointer:world_x(), self._pointer_lerp.x, pforce))
			self._mouse_pointer:set_world_y(math.lerp(self._mouse_pointer:world_y(), self._pointer_lerp.y, pforce))
		else
			self._mouse_pointer:set_world_x(math.lerp(self._mouse_pointer:world_x(), self._wanted_pointer.x, pforce))
			self._mouse_pointer:set_world_y(math.lerp(self._mouse_pointer:world_y(), self._wanted_pointer.y, pforce))
		end
	end
	if self._scanline then
		self._scanline:move(0, 50 * dt)
		if self._scanline:top() >= self:panel():h() + 25 then
			self._scanline:set_bottom(-25)
		end
	end
	if self._scanline_effect then
		local h = self._scanline_effect:h() * 0.25 * -1
		self._scanline_effect:move(0, 10 * dt)
		if h <= self._scanline_effect:top() then
			self._scanline_effect:set_top(self._scanline_effect:top() + h)
		end
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
		local floor_offset = self:floor_offset()
		mleft = -(left - self._grid_panel:left()) + floor_offset.x
		mright = -(right - self._grid_panel:right()) - floor_offset.w
		mtop = -(top - self._grid_panel:top()) + floor_offset.y
		mbottom = -(bottom - self._grid_panel:bottom()) - floor_offset.h
		if self._lerp_map then
			if -5 <= mleft or mright <= 5 then
				self._lerp_map.x = self._map_x
			end
			if -5 <= mtop or mbottom <= 5 then
				self._lerp_map.y = self._map_y
			end
			local speed = 5
			local step = dt * speed
			local dx = self._lerp_map.x - self._map_x
			local dy = self._lerp_map.y - self._map_y
			if dx ~= 0 or dy ~= 0 then
				local mx = step >= math.abs(dx) and dx or math.lerp(0, dx, step)
				local my = step >= math.abs(dy) and dy or math.lerp(0, dy, step)
				self:_move_map_position(mx, my)
				if self._lerp_map.clbk and math.abs(mx) < 1 and math.abs(my) < 1 then
					self._lerp_map.x = self._map_x
					self._lerp_map.y = self._map_y
				end
			else
				if self._lerp_map.clbk then
					self._lerp_map.clbk()
				end
				self._lerp_map = nil
			end
		end
		if self._lerp_zoom then
			local speed = 10
			local step = dt * speed
			local dz = self._lerp_zoom - self._map_zoom
			if dz ~= 0 then
				local mz = step >= math.abs(dz) and self._lerp_zoom or math.lerp(self._map_zoom, self._lerp_zoom, step)
				self:_set_zoom(mz, self._panel:w() / 2, self._panel:h() / 2)
			else
				self._lerp_zoom = nil
			end
		end
	else
		self._lerp_map = nil
		self._lerp_zoom = nil
	end
	if self._released_map then
		self._released_map.dx = math.lerp(self._released_map.dx, 0, dt * 2)
		self._released_map.dy = math.lerp(self._released_map.dy, 0, dt * 2)
		self:_move_map_position(self._released_map.dx, self._released_map.dy)
		if -5 <= mleft or mright <= 5 then
			self._released_map.dx = 0
		end
		if -5 <= mtop or mbottom <= 5 then
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
		local padding = 25
		if mleft > -padding then
			local mx = math.lerp(0, -padding - mleft, step)
			self:_move_map_position(mx, 0)
			if self._lerp_map and 0 < mx then
				self._lerp_map.x = self._map_x
			end
		end
		if mright < padding then
			local mx = math.lerp(0, padding - mright, step)
			self:_move_map_position(mx, 0)
			if self._lerp_map and mx < 0 then
				self._lerp_map.x = self._map_x
			end
		end
		if mtop > -padding then
			local my = math.lerp(0, -padding - mtop, step)
			self:_move_map_position(0, my)
			if self._lerp_map and 0 < my then
				self._lerp_map.y = self._map_y
			end
		end
		if mbottom < padding then
			local my = math.lerp(0, padding - mbottom, step)
			self:_move_map_position(0, my)
			if self._lerp_map and my < 0 then
				self._lerp_map.y = self._map_y
			end
		end
	end
	self._one_frame_input_delay = false
	self:current_floor():set_zoom_value(self._map_zoom)
end

function CustomSafehouseGuiPageMap:mouse_wheel_up(x, y)
	if self._one_scroll_in_delay then
		self._one_scroll_in_delay = nil
	end
	self:zoom_in(x, y)
	return true
end

function CustomSafehouseGuiPageMap:mouse_wheel_down(x, y)
	if self._one_scroll_out_delay then
		self._one_scroll_out_delay = nil
	end
	self:zoom_out(x, y)
	return true
end

function CustomSafehouseGuiPageMap:mouse_moved(o, x, y)
	if not self._active then
		return
	end
	local inside_panel = self:panel():inside(x, y)
	local used, pointer = false, "arrow"
	self._mouse_moved = not self._last_x or not self._last_y or self._last_x ~= x or self._last_y ~= y
	self._last_x = x
	self._last_y = y
	for _, button in ipairs(self._buttons) do
		if button:inside(x, y) then
			button:set_selected(true)
			used, pointer = true, "link"
		else
			button:set_selected(false)
		end
	end
	if not self:panel():inside(x, y) then
		return used, pointer
	end
	for i, button in ipairs(self._floor_control_buttons) do
		if not used and button:inside(x, y) and inside_panel then
			button:set_selected(true)
			used, pointer = true, "link"
		elseif i ~= self._selected_floor then
			button:set_selected(false)
		end
	end
	if self:current_floor():is_static_overlay() then
		return used, pointer
	end
	if not used then
		local u, p = self:current_floor():mouse_moved(o, x, y)
		if u then
			used, pointer = u, p
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
		used, pointer = true, "hand"
	end
	return used, pointer
end

function CustomSafehouseGuiPageMap:mouse_pressed(button, x, y)
	if button ~= Idstring("0") or not self._active then
		return
	end
	local ret
	for _, button in ipairs(self._buttons) do
		if button:inside(x, y) then
			button:trigger()
			ret = true
		end
	end
	if not self:panel():inside(x, y) then
		return ret
	end
	for i, button in ipairs(self._floor_control_buttons) do
		if button:inside(x, y) then
			self._current_floor_button = i
			button:trigger()
			return true
		end
	end
	if self:current_floor():is_static_overlay() then
		return ret
	end
	ret = self:current_floor():mouse_pressed(button, x, y) or ret
	if not ret and self._panel:inside(x, y) then
		self._released_map = nil
		self._grabbed_map = {
			x = x,
			y = y,
			dirs = {}
		}
		ret = true
	end
	return ret
end

function CustomSafehouseGuiPageMap:mouse_released(o, button, x, y)
	if button ~= Idstring("0") then
		return
	end
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
end

function CustomSafehouseGuiPageMap:_move_map_position(mx, my)
	self:_set_map_position(self._map_x + mx, self._map_y + my)
end

function CustomSafehouseGuiPageMap:_set_zoom(zoom, x, y, ignore_update)
	self._lerp_map = nil
	local new_zoom = math.clamp(zoom, 0, 1)
	if self:current_zoom(new_zoom) ~= self._last_zoom then
		local w1, h1 = self._map_panel:size()
		local wx1 = (x - self._map_x) / w1
		local wy1 = (y - self._map_y) / h1
		self._map_zoom = new_zoom
		self._map_panel:set_size(self._map_size * self:current_zoom(), self._map_size * self:current_zoom())
		self._grid_panel:set_size(self._map_size * self:current_zoom(), self._map_size * self:current_zoom())
		local w2, h2 = self._map_panel:size()
		self:_move_map_position((w1 - w2) * wx1, (h1 - h2) * wy1)
		self:current_floor():update()
		self._last_zoom = self:current_zoom()
		if self:current_floor():is_static_overlay() then
			return false
		end
		return true
	else
		self._one_scroll_in_delay = true
	end
	return false
end

function CustomSafehouseGuiPageMap:_change_zoom(zoom, x, y)
	return self:_set_zoom(self._map_zoom + zoom, x, y)
end

function CustomSafehouseGuiPageMap:zoom_out(x, y)
	if self:_change_zoom(-0.05, x, y) then
		managers.menu_component:post_event("zoom_out")
	end
end

function CustomSafehouseGuiPageMap:zoom_in(x, y)
	if self:_change_zoom(0.05, x, y) then
		managers.menu_component:post_event("zoom_in")
	end
end

function CustomSafehouseGuiPageMap:min_zoom()
	return self:current_floor():min_zoom() or self._min_zoom
end

function CustomSafehouseGuiPageMap:max_zoom()
	return self:current_floor():max_zoom() or self._max_zoom
end

function CustomSafehouseGuiPageMap:current_zoom(custom_zoom)
	return (custom_zoom or self._map_zoom) * (self:max_zoom() - self:min_zoom()) + self:min_zoom()
end

function CustomSafehouseGuiPageMap:_set_map_position(x, y, location)
	self._map_panel:set_position(x, y)
	self._grid_panel:set_center(self._map_panel:center())
	local floor_offset = self:floor_offset()
	local left = self._panel:w() * 0 - floor_offset.x
	local right = self._panel:w() * 1 + floor_offset.w
	local top = self._panel:h() * 0 - floor_offset.y
	local bottom = self._panel:h() * 1 + floor_offset.h
	if 0 > left - self._grid_panel:left() then
		self._map_panel:move(left - self._grid_panel:left(), 0)
	end
	if 0 < right - self._grid_panel:right() then
		self._map_panel:move(right - self._grid_panel:right(), 0)
	end
	if 0 > top - self._grid_panel:top() then
		self._map_panel:move(0, top - self._grid_panel:top())
	end
	if 0 < bottom - self._grid_panel:bottom() then
		self._map_panel:move(0, bottom - self._grid_panel:bottom())
	end
	self._map_x, self._map_y = self._map_panel:position()
	self._grid_panel:set_center(self._map_panel:center())
end

CustomSafehouseMapFloor = CustomSafehouseMapFloor or class()

function CustomSafehouseMapFloor:init(panel, map_panel, tweak)
	if tweak.static_overlay then
		if tweak.video then
			self._bg = panel:video({
				video = tweak.static_overlay,
				loop = true,
				layer = 10
			})
		else
			self._bg = panel:bitmap({
				texture = tweak.static_overlay,
				layer = 10
			})
		end
		local aspect = self._bg:w() / self._bg:h()
		local panel_aspect = panel:w() / panel:h()
		if aspect > panel_aspect then
			self._bg:set_h(panel:h())
			self._bg:set_w(panel:h() * aspect)
		else
			self._bg:set_w(panel:w())
			self._bg:set_h(panel:w() * aspect)
		end
		self._bg:set_center(panel:w() / 2, panel:h() / 2)
		self._static_overlay = true
	else
		self._bg = map_panel:bitmap({
			texture = tweak.texture,
			w = map_panel:w() / 2,
			h = map_panel:h() / 2,
			halign = "scale",
			valign = "scale",
			alpha = 0.5,
			layer = -1,
			blend_mode = "add"
		})
		self._bg:set_center(map_panel:w() / 2, map_panel:h() / 2)
	end
	self._name_id = tweak.name_id
	self._desc_id = tweak.desc_id
	self._alpha_limit = tweak.alpha_limit or 0.1
	self._min_zoom = tweak.min_zoom
	self._max_zoom = tweak.max_zoom
	self._start_zoom = tweak.start_zoom
	if not managers.menu:is_pc_controller() and tweak.controller_shape then
		self._x, self._y, self._w, self._h = unpack(tweak.controller_shape)
	elseif tweak.shape then
		self._x, self._y, self._w, self._h = unpack(tweak.shape)
	end
	self._disable_cursor = tweak.disable_cursor
	self._points = {}
end

function CustomSafehouseMapFloor:is_static_overlay()
	return self._static_overlay
end

function CustomSafehouseMapFloor:should_disable_cursor()
	return self._disable_cursor
end

function CustomSafehouseMapFloor:min_zoom()
	return self._min_zoom
end

function CustomSafehouseMapFloor:max_zoom()
	return self._max_zoom
end

function CustomSafehouseMapFloor:start_zoom()
	return self._start_zoom
end

function CustomSafehouseMapFloor:x()
	return self._x
end

function CustomSafehouseMapFloor:y()
	return self._y
end

function CustomSafehouseMapFloor:w()
	return self._w
end

function CustomSafehouseMapFloor:h()
	return self._h
end

function CustomSafehouseMapFloor:name_id()
	return self._name_id
end

function CustomSafehouseMapFloor:desc_id()
	return self._desc_id
end

function CustomSafehouseMapFloor:add_point(point)
	table.insert(self._points, point)
end

function CustomSafehouseMapFloor:points()
	return self._points
end

function CustomSafehouseMapFloor:hide()
	self._bg:hide()
	for _, point in ipairs(self._points) do
		point:hide()
	end
end

function CustomSafehouseMapFloor:show()
	self._bg:show()
	for _, point in ipairs(self._points) do
		point:show()
	end
end

function CustomSafehouseMapFloor:update()
	for _, point in ipairs(self._points) do
		point:update()
	end
end

function CustomSafehouseMapFloor:refresh()
	for _, point in ipairs(self._points) do
		point:refresh()
	end
end

function CustomSafehouseMapFloor:confirm_pressed()
	for _, point in ipairs(self._points) do
		if point:is_selected() then
			point:attempt_purchase()
			return
		end
	end
end

function CustomSafehouseMapFloor:mouse_moved(o, x, y)
	local used, pointer
	for _, point in ipairs(self._points) do
		local u, p = point:mouse_moved(o, x, y)
		if u then
			used, pointer = u, p
		end
	end
	return used, pointer
end

function CustomSafehouseMapFloor:mouse_pressed(button, x, y)
	local ret
	for _, point in ipairs(self._points) do
		ret = point:mouse_pressed(button, x, y) or ret
	end
	return ret
end

function CustomSafehouseMapFloor:set_zoom_value(zoom)
	for _, point in ipairs(self._points) do
		point:set_zoom_value(zoom, self._alpha_limit)
	end
end

CustomSafehouseMapPoint = CustomSafehouseMapPoint or class()
CustomSafehouseMapPoint.WIDTH = 64
CustomSafehouseMapPoint.HEIGHT = 64
CustomSafehouseMapPoint.FRAME_WIDTH = 96
CustomSafehouseMapPoint.FRAME_HEIGHT = 96
CustomSafehouseMapPoint.PADDING = 2
CustomSafehouseMapPoint.colors = {}
CustomSafehouseMapPoint.colors.selected = tweak_data.screen_colors.button_stage_2:with_alpha(1)
CustomSafehouseMapPoint.colors.locked = Color.white:with_alpha(0.25)
CustomSafehouseMapPoint.colors.unlocked = Color.white
CustomSafehouseMapPoint.colors.unavailable = tweak_data.screen_colors.important_1
CustomSafehouseMapPoint.colors.current = tweak_data.screen_colors.button_stage_3:with_alpha(1)

function CustomSafehouseMapPoint:init(parent, map_panel, id)
	self.make_fine_text = BlackMarketGui.make_fine_text
	self._parent = parent
	self._id = id
	self._room_data = table.find_value(tweak_data.safehouse.rooms, function(v)
		return v.room_id == id
	end)
	self._name_id = self._room_data.name_id
	self._map_width = map_panel:w()
	self._map_height = map_panel:h()
	self._map_panel = map_panel
	self._current_size_mod = 1
	self._alpha = 1
	self._current_tier = managers.custom_safehouse:get_room_current_tier(self._id)
	local tweak_table = tweak_data.safehouse.map.rooms[id]
	self._x = tweak_table.x / self._map_width
	self._y = tweak_table.y / self._map_height
	self._panel = map_panel:panel({halign = "scale", valign = "scale"})
	local title_text = managers.localization:to_upper_text(self._name_id)
	self._title = self._panel:text({
		name = "title",
		text = title_text,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.button_stage_2
	})
	self:make_fine_text(self._title)
	self._title:set_top(0)
	self._image = self._panel:bitmap({
		texture = "guis/dlcs/chill/textures/pd2/character_icon/" .. tweak_table.icon,
		w = CustomSafehouseMapPoint.WIDTH,
		h = CustomSafehouseMapPoint.HEIGHT,
		layer = 12
	})
	self._image:set_top(self._title:bottom() + CustomSafehouseMapPoint.PADDING)
	self._frame_image = self._panel:bitmap({
		texture = tweak_data.safehouse.map.frame_texture[1],
		w = CustomSafehouseMapPoint.FRAME_WIDTH,
		w = CustomSafehouseMapPoint.FRAME_HEIGHT,
		layer = 13
	})
	self:set_tier_image(self._current_tier)
	local _, _, text_w = self._title:text_rect()
	self._panel:set_h(self._frame_image:bottom())
	self._panel:set_w(math.max(CustomSafehouseMapPoint.FRAME_WIDTH, text_w))
	self._panel:set_center(self._map_width * self._x, self._map_height * self._y)
	self._width = self._panel:w()
	self._height = self._panel:h()
	self._image:set_center_x(self._panel:w() / 2)
	self._title:set_center_x(self._image:center_x())
	self._frame_image:set_center_x(self._image:center_x())
	self._frame_image:set_center_y(self._image:center_y())
	self._image:animate(anim_deselect, CustomSafehouseMapPoint.WIDTH, CustomSafehouseMapPoint.HEIGHT)
	self._frame_image:animate(anim_deselect, CustomSafehouseMapPoint.FRAME_WIDTH, CustomSafehouseMapPoint.FRAME_HEIGHT)
end

function CustomSafehouseMapPoint:set_tier_image(tier)
	self._frame_image:set_image(tweak_data.safehouse.map.frame_texture[tier])
end

function CustomSafehouseMapPoint:refresh()
	self._current_tier = managers.custom_safehouse:get_room_current_tier(self._id)
	self:set_tier_image(self._current_tier)
	if self._selected == self._image or self:is_selected() then
		self._image:animate(anim_select, CustomSafehouseMapPoint.WIDTH, CustomSafehouseMapPoint.HEIGHT)
		self._frame_image:animate(anim_select, CustomSafehouseMapPoint.FRAME_WIDTH, CustomSafehouseMapPoint.FRAME_HEIGHT)
	else
		self._image:animate(anim_deselect, CustomSafehouseMapPoint.WIDTH, CustomSafehouseMapPoint.HEIGHT)
		self._frame_image:animate(anim_deselect, CustomSafehouseMapPoint.FRAME_WIDTH, CustomSafehouseMapPoint.FRAME_HEIGHT)
	end
end

function CustomSafehouseMapPoint:update()
	self:_update_position()
end

function CustomSafehouseMapPoint:hide()
	self._panel:hide()
end

function CustomSafehouseMapPoint:show()
	self._panel:show()
end

function CustomSafehouseMapPoint:_update_position()
	local diff_width = 1 - self._map_width / self._map_panel:width()
	local diff_height = 1 - self._map_height / self._map_panel:height()
	self._panel:set_width(self._width * (self._current_size_mod or 1))
	self._panel:set_height(self._height * (self._current_size_mod or 1))
	self._panel:set_center(self._map_panel:w() * self._x, self._map_panel:h() * self._y)
end

function CustomSafehouseMapPoint:mouse_moved(o, x, y)
	local used, pointer, new_selected
	if self._image:inside(x, y) then
		new_selected = self._image
		used, pointer = true, "link"
	end
	if self._selected ~= new_selected then
		if self._selected == self._image then
			self:set_selected(false)
		elseif new_selected == self._image then
			self:set_selected(true)
			managers.menu_component:post_event("highlight")
		end
	end
	self._selected = new_selected
	return used, pointer
end

function CustomSafehouseMapPoint:mouse_pressed(button, x, y)
	if button ~= Idstring("0") then
		return
	end
	local ret
	if self._selected == self._image then
		self:attempt_purchase()
		ret = true
	end
	return ret
end

function CustomSafehouseMapPoint:set_selected(selected)
	self._is_selected = selected
	if selected then
		self._image:animate(anim_select, CustomSafehouseMapPoint.WIDTH, CustomSafehouseMapPoint.HEIGHT)
		self._frame_image:animate(anim_select, CustomSafehouseMapPoint.FRAME_WIDTH, CustomSafehouseMapPoint.FRAME_HEIGHT)
		self:update_help_text(self._current_tier)
		if managers.custom_safehouse:get_room_current_tier(self._id) == #tweak_data.safehouse.prices.rooms then
			self._parent:set_top_help_text("menu_cs_rooms_help_hover_no_upgrade")
		else
			self._parent:set_top_help_text("menu_cs_rooms_help_hover")
		end
	else
		self._image:animate(anim_deselect, CustomSafehouseMapPoint.WIDTH, CustomSafehouseMapPoint.HEIGHT)
		self._frame_image:animate(anim_deselect, CustomSafehouseMapPoint.FRAME_WIDTH, CustomSafehouseMapPoint.FRAME_HEIGHT)
	end
end

function CustomSafehouseMapPoint:is_selected()
	return self._is_selected
end

function CustomSafehouseMapPoint:select_tier(id)
	managers.custom_safehouse:set_room_tier(self._id, id)
	managers.menu_component:custom_safehouse_gui():call_refresh()
end

function CustomSafehouseMapPoint:attempt_purchase(step)
	step = step or 0
	local next_tier = managers.custom_safehouse:get_next_tier_unlocked(self._id) + step
	if next_tier <= managers.custom_safehouse:get_room_max_tier(self._id) then
		local can_afford = managers.custom_safehouse:can_afford_room_tier(self._id, next_tier)
		if can_afford then
			local dialog_macros = {
				character = managers.localization:text(self._name_id),
				cost = managers.custom_safehouse:get_upgrade_cost(self._id, next_tier)
			}
			local dialog_data = {}
			dialog_data.title = managers.localization:text("dialog_bm_weapon_buy_title")
			dialog_data.text = managers.localization:text("dialog_upgrade_safehouse", dialog_macros)
			dialog_data.focus_button = 2
			local room_data = table.find_value(tweak_data.safehouse.rooms, function(v)
				return v.room_id == self._id
			end)
			dialog_data.texture = room_data and room_data.images[next_tier]
			if dialog_data.texture then
				dialog_data.w = 620
				dialog_data.h = 532
				dialog_data.image_w = 560
				dialog_data.image_h = 300
				dialog_data.image_valign = "top"
				dialog_data.image_halign = "center"
			end
			dialog_data.text = managers.localization:text(room_data.help_id .. "_" .. next_tier) .. [[


]] .. dialog_data.text
			local yes_button = {}
			yes_button.text = managers.localization:text("dialog_yes")
			yes_button.callback_func = callback(self, self, "_confirm_purchase", {tier = next_tier})
			local no_button = {}
			no_button.text = managers.localization:text("dialog_no")
			no_button.cancel_button = true
			dialog_data.button_list = {yes_button, no_button}
			if next_tier ~= managers.custom_safehouse:get_room_max_tier(self._id) then
				local next_button = {}
				next_button.text = managers.localization:text("dialog_next_tier")
				next_button.callback_func = callback(self, self, "attempt_purchase", step + 1)
				table.insert(dialog_data.button_list, next_button)
			end
			if 0 < step then
				local previous_button = {}
				previous_button.text = managers.localization:text("dialog_previous_tier")
				previous_button.callback_func = callback(self, self, "attempt_purchase", step - 1)
				table.insert(dialog_data.button_list, previous_button)
			end
			managers.system_menu:show_new_unlock(dialog_data)
		else
			self:invalid_purchase(true)
		end
	end
end

function CustomSafehouseMapPoint:_confirm_purchase(data)
	local can_afford = managers.custom_safehouse:can_afford_tier(managers.custom_safehouse:get_next_tier_unlocked(self._id))
	if can_afford then
		managers.custom_safehouse:purchase_room_tier(self._id, data.tier)
		managers.custom_safehouse:set_room_tier(self._id, data.tier)
		managers.menu_component:custom_safehouse_gui():call_refresh()
		managers.menu_component:post_event("chill_upgrade_stinger")
		local effect_panel = self._panel:panel({layer = 100})
		SimpleGUIEffectSpewer.infamous_up(self._image:center_x(), self._image:center_y(), effect_panel)
		self:update_help_text(data.tier)
	end
end

function CustomSafehouseMapPoint:invalid_purchase(sound)
	if sound then
		managers.menu_component:post_event("menu_error")
	end
	self._image:animate(anim_invalid)
end

function CustomSafehouseMapPoint:update_help_text(tier_id)
	local next_tier = math.min(tier_id + 1, managers.custom_safehouse:get_room_max_tier(self._id))
	self._parent:set_title_text(utf8.to_upper(managers.localization:text(self._room_data.title_id)))
	self._parent:set_room_image(self._room_data.images[tier_id])
	local help_text = managers.localization:text(self._room_data.help_id .. "_" .. tier_id)
	if managers.custom_safehouse:is_room_tier_unlocked(self._id, next_tier) then
		if next_tier == #tweak_data.safehouse.prices.rooms then
			help_text = help_text .. [[


]] .. managers.localization:text("menu_cs_upgrade_max")
		else
			help_text = help_text .. [[


]] .. (next_tier == 1 and "" or managers.localization:text("menu_cs_upgrade_owned"))
		end
		self._parent:set_help_text(help_text)
		self._parent:set_warning_text(nil)
	else
		local macros = {
			cost = tweak_data.safehouse.prices.rooms[next_tier]
		}
		help_text = help_text .. [[


]] .. managers.localization:text("menu_cs_upgrade_cost", macros)
		self._parent:set_help_text(help_text)
		self._parent:set_warning_text(nil)
		if next_tier > managers.custom_safehouse:get_next_tier_unlocked(self._id) then
			self._parent:set_warning_text(utf8.to_upper(managers.localization:text("menu_cs_unlock_prev_tier")))
		elseif not managers.custom_safehouse:can_afford_tier(next_tier) then
			self._parent:set_warning_text(utf8.to_upper(managers.localization:text("menu_cs_cant_afford")))
		end
	end
end

function CustomSafehouseMapPoint:set_zoom_value(zoom, alpha_limit)
	self._alpha = math.clamp((zoom - alpha_limit) * 10, 0, 1)
	self._title:set_alpha(self._alpha)
end
