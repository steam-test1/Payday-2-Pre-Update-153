require("lib/managers/menu/WalletGuiObject")
CrewManagementGui = CrewManagementGui or class()
local massive_font = tweak_data.menu.pd2_massive_font
local large_font = tweak_data.menu.pd2_large_font
local medium_font = tweak_data.menu.pd2_medium_font
local small_font = tweak_data.menu.pd2_small_font
local tiny_font = tweak_data.menu.tiny_font
local massive_font_size = tweak_data.menu.pd2_massive_font_size
local large_font_size = tweak_data.menu.pd2_large_font_size
local medium_font_size = tweak_data.menu.pd2_medium_font_size
local small_font_size = tweak_data.menu.pd2_small_font_size
local tiny_font_size = tweak_data.menu.pd2_tiny_font_size
local make_fine_text = function(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end
local fit_texture = function(bitmap, target_w, target_h)
	local texture_width = bitmap:texture_width()
	local texture_height = bitmap:texture_height()
	local panel_width, panel_height = bitmap:parent():size()
	target_w = target_w or bitmap:parent():w()
	target_h = target_h or bitmap:parent():h()
	local aspect = target_w / target_h
	local sw = math.max(texture_width, texture_height * aspect)
	local sh = math.max(texture_height, texture_width / aspect)
	local dw = texture_width / sw
	local dh = texture_height / sh
	bitmap:set_size(math.round(dw * target_w), math.round(dh * target_h))
end

function CrewManagementGui:init(ws, fullscreen_ws, node)
	managers.menu_component:close_contract_gui()
	managers.blackmarket:verfify_crew_loadout()
	managers.menu_scene:set_henchmen_visible(true)
	for i = 1, 3 do
		managers.menu_scene:set_henchmen_loadout(i)
	end
	if CrewManagementGui.panel_crash_protection then
		CrewManagementGui.panel_crash_protection:parent():remove(CrewManagementGui.panel_crash_protection)
	end
	self._panel = ws:panel():panel()
	CrewManagementGui.panel_crash_protection = self._panel
	self._item_w = 128
	self._item_h = 100
	self._image_max_h = 64
	self._buttons = {}
	self._buttons_no_nav = {}
	local title_text = self._panel:text({
		text = managers.localization:to_upper_text("menu_crew_management"),
		font = large_font,
		font_size = large_font_size
	})
	make_fine_text(title_text)
	local loadout_text = self._panel:text({
		text = managers.localization:text("menu_crew_loadout_order"),
		font = medium_font,
		font_size = medium_font_size,
		y = 20
	})
	make_fine_text(loadout_text)
	local info_panel
	if managers.menu:is_pc_controller() then
		info_panel = self._panel:panel({w = 30, h = 24})
		local info_icon = info_panel:bitmap({
			texture = "guis/textures/pd2/blackmarket/inv_newdrop"
		})
		info_icon:set_texture_coordinates(Vector3(0, 16, 0), Vector3(16, 16, 0), Vector3(0, 0, 0), Vector3(16, 0, 0))
		info_icon:set_center(info_panel:center())
		local info_button = CrewManagementGuiButton:new(self, callback(self, self, "show_help_dialog"), true)
		info_button._panel = info_panel
		info_button._select_col = Color.white:with_alpha(0.25)
		info_button._normal_col = Color.white
		
		function info_button:_selected_changed(state)
			info_icon:set_color(state and self._select_col or self._normal_col)
		end
	end
	self._1_panel = self._panel:panel({
		h = 0,
		w = self._item_w,
		y = loadout_text:bottom()
	})
	self._2_panel = self._panel:panel({
		h = 0,
		w = self._item_w,
		y = loadout_text:bottom()
	})
	self._3_panel = self._panel:panel({
		h = 0,
		w = self._item_w,
		y = loadout_text:bottom()
	})
	self._btn_panels = {
		self._1_panel,
		self._2_panel,
		self._3_panel
	}
	self._3_panel:set_right(self._panel:right() - 10)
	self._2_panel:set_right(self._3_panel:left() - 10)
	self._1_panel:set_right(self._2_panel:left() - 10)
	for i, panel in pairs(self._btn_panels) do
		local slot_text = self._panel:text({
			text = managers.localization:text("menu_crew_slot_index", {index = i}),
			font = small_font,
			font_size = small_font_size
		})
		make_fine_text(slot_text)
		slot_text:set_lefttop(panel:lefttop())
		panel:set_top(slot_text:bottom())
	end
	loadout_text:set_left(self._1_panel:left())
	if info_panel then
		info_panel:set_center_y(loadout_text:center_y())
		info_panel:set_left(loadout_text:right())
	end
	self:create_mask_button(self._1_panel, 1)
	self:create_mask_button(self._2_panel, 2)
	self:create_mask_button(self._3_panel, 3)
	self:new_row()
	self:create_weapon_button(self._1_panel, 1)
	self:create_weapon_button(self._2_panel, 2)
	self:create_weapon_button(self._3_panel, 3)
	self:new_row()
	self:create_ability_button(self._1_panel, 1)
	self:create_ability_button(self._2_panel, 2)
	self:create_ability_button(self._3_panel, 3)
	self:new_row()
	self:create_skill_button(self._1_panel, 1)
	self:create_skill_button(self._2_panel, 2)
	self:create_skill_button(self._3_panel, 3)
	self:new_row()
	local char_text = self._panel:text({
		text = managers.localization:text("menu_crew_character_order"),
		font = medium_font,
		font_size = medium_font_size
	})
	make_fine_text(char_text)
	char_text:set_top(self._1_panel:bottom() + 20)
	char_text:set_left(self._1_panel:left())
	local cc_panel = self._panel:panel({
		w = self._3_panel:right() - self._1_panel:left()
	})
	cc_panel:set_left(self._1_panel:left())
	cc_panel:set_top(char_text:bottom())
	local char_panel = cc_panel:panel({
		h = 0,
		h = 70,
		w = 0
	})
	for i = 1, CriminalsManager.MAX_NR_TEAM_AI do
		local character = managers.blackmarket:preferred_henchmen(i)
		local texture = character and managers.blackmarket:get_character_icon(character) or "guis/textures/pd2/dice_icon"
		self:_add_bitmap_panel_row(char_panel, {texture = texture}, 70, 64)
	end
	char_panel:set_center_x(cc_panel:w() / 2)
	char_panel:set_top(15)
	cc_panel:set_h(char_panel:h() + 30)
	local char_btn = CrewManagementGuiButton:new(self, callback(self, self, "open_character_menu", 1))
	char_btn._panel = cc_panel
	char_btn._select_panel = BoxGuiObject:new(cc_panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	char_btn._select_panel:set_visible(false)
	char_btn._selected_changed = CrewManagementGuiLoadoutItem._selected_changed
	do
		local v = cc_panel
		BoxGuiObject:new(v, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		v:bitmap({
			texture = "guis/textures/test_blur_df",
			render_template = "VertexColorTexturedBlur3D",
			w = v:w(),
			h = v:h(),
			halign = "scale",
			valign = "scale",
			layer = -1,
			alpha = 1
		})
		v:rect({
			color = Color.black,
			alpha = 0.4,
			layer = -1
		})
	end
	for _, v in pairs(self._btn_panels) do
		BoxGuiObject:new(v, {
			sides = {
				1,
				1,
				2,
				1
			}
		})
		v:bitmap({
			texture = "guis/textures/test_blur_df",
			render_template = "VertexColorTexturedBlur3D",
			w = v:w(),
			h = v:h(),
			halign = "scale",
			valign = "scale",
			layer = -1,
			alpha = 1
		})
		v:rect({
			color = Color.black,
			alpha = 0.4,
			layer = -1
		})
	end
	WalletGuiObject.set_wallet(self._panel)
	self:select_index(1, 1)
	local back_button = self._panel:text({
		name = "back_button",
		text = managers.localization:text("menu_back"),
		align = "right",
		vertical = "bottom",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.button_stage_3,
		layer = 40,
		blend_mode = "add"
	})
	make_fine_text(back_button)
	back_button:set_right(self._panel:w() - 10)
	back_button:set_bottom(self._panel:h() - 10)
	back_button:set_visible(managers.menu:is_pc_controller())
	local back = CrewManagementGuiButton:new(self, function()
		managers.menu:back(true)
	end, true)
	back._panel = back_button
	back._select_col = tweak_data.screen_colors.button_stage_2
	back._normal_col = tweak_data.screen_colors.button_stage_3
	back._selected_changed = CrewManagementGuiTextButton._selected_changed
end

function CrewManagementGui:_setup()
	if alive(self._panel) then
		self._panel:parent():remove(self._panel)
	end
end

function CrewManagementGui:new_row()
	self._items = self._items or {
		self._current_row
	}
	self._current_row = {}
	table.insert(self._items, self._current_row)
end

function CrewManagementGui:add_item(item, no_navigation)
	if no_navigation then
		table.insert(self._buttons_no_nav, item)
		return
	end
	self._current_row = self._current_row or {}
	self._items = self._items or {
		self._current_row
	}
	table.insert(self._current_row, item)
	table.insert(self._buttons, item)
	return {
		#self._current_row,
		#self._items
	}
end

function CrewManagementGui:_add_bitmap_panel(panel, config, w, h)
	local rtn = panel:panel({
		w = self._item_w,
		h = self._item_h
	})
	local item
	if config and type(config) == "table" then
		item = rtn:bitmap(config)
		fit_texture(item, w, h or self._image_max_h)
		item:set_center(rtn:center())
	else
		item = rtn:text({
			text = config or managers.localization:text("menu_crew_none"),
			font = medium_font,
			font_size = medium_font_size
		})
		make_fine_text(item)
		item:set_center(rtn:center())
	end
	rtn:set_center_x(self._item_w / 2)
	rtn:set_y(panel:h())
	panel:set_h(rtn:bottom())
	return rtn, item
end

function CrewManagementGui:_add_bitmap_panel_row(panel, config, w, h)
	local rtn = panel:panel({w = w, h = h})
	local item
	item = rtn:bitmap(config)
	fit_texture(item, w, h or self._image_max_h)
	item:set_center(rtn:center())
	rtn:set_center_y(panel:h() / 2)
	rtn:set_x(panel:w())
	panel:set_w(rtn:right())
	return rtn, item
end

function CrewManagementGui:create_mask_button(panel, index)
	local loadout = managers.blackmarket:henchman_loadout(index)
	local texture = managers.blackmarket:get_mask_icon(loadout.mask)
	return CrewManagementGuiLoadoutItem:new(self, panel, texture and {texture = texture}, callback(self, self, "open_mask_category_menu", index))
end

function CrewManagementGui:create_weapon_button(panel, index)
	local loadout = managers.blackmarket:henchman_loadout(index)
	local data = managers.blackmarket:get_crafted_category_slot("primaries", loadout.primary_slot) or {}
	local texture, rarity = managers.blackmarket:get_weapon_icon_path(data.weapon_id, data.cosmetics)
	local item = CrewManagementGuiLoadoutItem:new(self, panel, texture and {texture = texture, layer = 1} or managers.localization:to_upper_text("menu_crew_defualt"), callback(self, self, "open_weapon_menu", {"primaries", index}))
	if rarity then
		local rare_item = item._panel:bitmap({
			texture = rarity,
			blend_mode = "add",
			layer = 0
		})
		fit_texture(rare_item, item._panel:size())
		rare_item:set_world_center(item._panel:world_center())
	end
	return item
end

function CrewManagementGui:create_ability_button(panel, index)
	local loadout = managers.blackmarket:henchman_loadout(index)
	local data = tweak_data.upgrades.crew_ability_definitions[loadout.ability]
	local texture, texture_rect
	if data then
		texture, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	end
	return CrewManagementGuiLoadoutItem:new(self, panel, texture and {texture = texture, texture_rect = texture_rect}, callback(self, self, "open_ability_menu", index))
end

function CrewManagementGui:create_skill_button(panel, index)
	local loadout = managers.blackmarket:henchman_loadout(index)
	local data = tweak_data.upgrades.crew_skill_definitions[loadout.skill]
	local texture, texture_rect
	if data then
		texture, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	end
	return CrewManagementGuiLoadoutItem:new(self, panel, texture and {texture = texture, texture_rect = texture_rect}, callback(self, self, "open_skill_menu", {"skill", index}))
end

function CrewManagementGui:close()
	if self._panel then
		self._panel:parent():remove(self._panel)
		CrewManagementGui.panel_crash_protection = nil
	end
	WalletGuiObject.close_wallet(self._panel)
	managers.blackmarket:verfify_crew_loadout()
	managers.menu_scene:set_henchmen_visible(false)
end

function CrewManagementGui:create_button(panel, string, func)
	local btn = {
		panel = panel:panel(),
		trigger = func
	}
	local text = btn.panel:text({
		text = string,
		font_size = medium_font_size,
		font = medium_font
	})
	make_fine_text(text)
	btn.panel:set_size(text:size())
	btn.panel:set_y(panel:h())
	panel:set_h(btn.panel:bottom())
	return btn
end

function CrewManagementGui:show_help_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_crew_loadout_help_title")
	dialog_data.text = managers.localization:text("dialog_crew_loadout_help_text")
	dialog_data.type = "help_dialog"
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

CrewManagementGuiButton = CrewManagementGuiButton or class()

function CrewManagementGuiButton:init(parent, func, no_navigation)
	self._parent = parent
	self._func = func
	self._no_navigation = not not no_navigation
	self._enabled = true
	self._pos = parent:add_item(self, no_navigation)
end

function CrewManagementGuiButton:trigger(...)
	if self._func then
		self._func(...)
	end
end

function CrewManagementGuiButton:set_selected(state)
	if state and not self._enabled and not self._no_navigation then
		self._parent:select(self._select_instead)
		return
	end
	if self._selected == state then
		return
	end
	self._selected = state
	local _ = self._selected_changed and self:_selected_changed(state)
end

function CrewManagementGuiButton:select_instead(item)
	self._select_instead = item
	if self._selected and self._select_instead then
		self._parent:select(self._select_instead)
	end
end

function CrewManagementGuiButton:inside(x, y)
	if self._no_navigation then
		return self._panel:inside(x, y)
	end
	return self._enabled and self._panel and self._panel:inside(x, y)
end

function CrewManagementGuiButton:set_enabled(state)
	self._enabled = state
	local _ = self._item and self._item:set_color(state and Color.white or Color.black)
	if not state and self._selected then
		self._parent:select(self._select_instead)
	end
end

CrewManagementGuiLoadoutItem = CrewManagementGuiLoadoutItem or class(CrewManagementGuiButton)

function CrewManagementGuiLoadoutItem:init(parent, panel, texture, func, w, h)
	CrewManagementGuiLoadoutItem.super.init(self, parent, func)
	self._panel, self._item = parent:_add_bitmap_panel(panel, texture, w, h)
	self._select_panel = BoxGuiObject:new(self._panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	self._select_panel:set_visible(false)
end

function CrewManagementGuiButton:_selected_changed(state)
	local _ = self._select_panel and self._select_panel:set_visible(state)
end

CrewManagementGuiTextButton = CrewManagementGuiTextButton or class(CrewManagementGuiButton)

function CrewManagementGuiTextButton:init(parent, panel, text, func)
	CrewManagementGuiTextButton.super.init(self, parent, func, true)
	self._select_col = tweak_data.screen_colors.button_stage_2
	self._normal_col = tweak_data.screen_colors.button_stage_3
	self._panel = panel:text({
		text = text,
		font = small_font,
		font_size = small_font_size,
		color = self._normal_col
	})
	make_fine_text(self._panel)
	self._panel:set_left(panel:w())
	panel:set_w(self._panel:right())
end

function CrewManagementGuiTextButton:_selected_changed(state)
	self._panel:set_color(state and self._select_col or self._normal_col)
end

function CrewManagementGui:mouse_pressed(button, x, y)
	if button ~= Idstring("0") then
		return
	end
	for k, v in pairs(self._buttons_no_nav or {}) do
		if v:inside(x, y) then
			v:trigger()
			break
		end
	end
	for k, v in pairs(self._buttons) do
		if v:inside(x, y) then
			v:trigger()
			break
		end
	end
end

function CrewManagementGui:mouse_moved(o, x, y)
	for k, v in pairs(self._buttons_no_nav or {}) do
		v:set_selected(v:inside(x, y))
	end
	for k, v in pairs(self._buttons) do
		if v:inside(x, y) then
			self:select(v)
			break
		end
	end
end

function CrewManagementGui:special_btn_pressed(button)
	if Idstring("menu_respec_tree") == button then
		self:show_help_dialog()
	end
end

function CrewManagementGui:move_left()
	self:move_selection(-1, 0)
end

function CrewManagementGui:move_right()
	self:move_selection(1, 0)
end

function CrewManagementGui:move_up()
	self:move_selection(0, -1)
end

function CrewManagementGui:move_down()
	self:move_selection(0, 1)
end

function CrewManagementGui:move_selection(dx, dy)
	if not self._selected_btn then
		self:select_index(1, 1)
		return
	end
	local pos = self._selected_btn._pos
	self:select_index(pos[1] + dx, pos[2] + dy)
end

function CrewManagementGui:confirm_pressed()
	if self._selected_btn then
		self._selected_btn:trigger()
	end
end

function CrewManagementGui:input_focus()
	return alive(self._panel) and self._panel:visible() and 1
end

function CrewManagementGui:select_index(x, y, no_backup)
	y = self._items and math.clamp(y, 1, #self._items)
	local item = self._items[y]
	x = item and math.clamp(x, 1, #item)
	item = item and item[x]
	local _ = item and self:select(item)
end

function CrewManagementGui:select(btn, no_backup)
	if btn and btn._no_navigation then
		print(debug.traceback())
	end
	if btn ~= self._selected_btn then
		local _ = self._selected_btn and self._selected_btn:set_selected(false)
		self._selected_btn = btn
		local _ = btn and btn:set_selected(true)
		if not self._selected_btn and not no_backup then
			self:select_index(1, 1, true)
		end
	end
end

function CrewManagementGui:open_weapon_menu(params)
	self:open_weapon_category_menu(unpack(params))
end

function CrewManagementGui:create_pages(new_node_data, params, identifier, selected_slot, rows, columns, max_pages)
	local category = new_node_data.category
	rows = rows or 3
	columns = columns or 3
	max_pages = max_pages or 8
	local items_per_page = rows * columns
	local item_data
	local selected_tab = 1
	for page = 1, max_pages do
		local index = 1
		local start_i = 1 + items_per_page * (page - 1)
		item_data = {}
		for i = start_i, items_per_page * page do
			item_data[index] = i
			index = index + 1
			if i == selected_slot then
				selected_tab = page
			end
		end
		local name_id = managers.localization:to_upper_text("bm_menu_page", {
			page = tostring(page)
		})
		table.insert(new_node_data, {
			name = category,
			category = category,
			prev_node_data = false,
			start_i = start_i,
			allow_preview = true,
			name_localized = name_id,
			on_create_func = callback(self, self, "populate_" .. category, params),
			on_create_data = item_data,
			identifier = BlackMarketGui.identifiers[identifier],
			override_slots = {columns, rows}
		})
	end
	return selected_tab
end

function CrewManagementGui:open_custom_menu(params, category, custom_w, custom_h)
	local new_node_data = {category = category}
	local selected_tab = self:create_pages(new_node_data, params, "custom", nil, custom_w or 4, custom_h or 4, 1)
	new_node_data.can_move_over_tabs = false
	new_node_data.selected_tab = selected_tab
	new_node_data.scroll_tab_anywhere = false
	new_node_data.hide_detection_panel = true
	new_node_data.custom_callback = {
		custom_select = callback(self, self, "select_" .. category, params),
		custom_unselect = callback(self, self, "select_" .. category, params)
	}
	
	function new_node_data.custom_update_text_info(data, updated_texts, gui)
		updated_texts[1].text = data.name_localized
		updated_texts[2].text = managers.localization:text(data.name_id .. "_desc", tweak_data.upgrades.crew_descs[data.name]) or ""
		if data.unlocked then
			updated_texts[3].text = data.equipped_by and managers.localization:text("menu_data_crew_equipped_by", {
				equipped_by = tostring(data.equipped_by)
			}) or ""
		else
			updated_texts[3].text = data.lock_text
		end
	end
	
	new_node_data.topic_id = "bm_menu_" .. category
	new_node_data.topic_params = {
		weapon_category = managers.localization:text("bm_menu_" .. category)
	}
	managers.menu:open_node("blackmarket_node", {new_node_data})
end

function CrewManagementGui:open_ability_menu(henchman_index)
	self:open_custom_menu(henchman_index, "ability")
end

function CrewManagementGui:open_skill_menu(params)
	self:open_custom_menu(params, "skill")
end

function CrewManagementGui:open_character_menu(henchman_index)
	local category = "characters"
	local new_node_data = {category = category}
	local selected_tab = self:create_pages(new_node_data, henchman_index, "custom", nil, 3, 6, 1)
	new_node_data.can_move_over_tabs = true
	new_node_data.selected_tab = selected_tab
	new_node_data.scroll_tab_anywhere = true
	new_node_data.hide_detection_panel = true
	new_node_data.custom_callback = {
		custom_select = callback(self, self, "select_characters"),
		custom_unselect = callback(self, self, "select_characters"),
		c_clear_slots = callback(self, self, "clear_character_order")
	}
	
	function new_node_data.custom_update_text_info(data, updated_texts, gui)
		updated_texts[1].text = data.name_localized
		updated_texts[4].text = managers.localization:text(data.name .. "_desc")
		if not data.unlocked then
			updated_texts[3].text = managers.localization:text(data.dlc_locked)
		end
	end
	
	new_node_data.topic_id = "bm_menu_crew_characters"
	new_node_data.topic_params = {
		weapon_category = managers.localization:text("bm_menu_" .. category) .. " " .. tostring(henchman_index)
	}
	managers.menu:open_node("blackmarket_node", {new_node_data})
end

function CrewManagementGui:_create_member_loadout_map(member_name)
	local rtn = {}
	for i = 1, CriminalsManager.MAX_NR_TEAM_AI do
		local loadout = managers.blackmarket:henchman_loadout(i)
		local val = loadout[member_name]
		if val then
			rtn[val] = i
		end
	end
	return rtn
end

function CrewManagementGui:open_weapon_category_menu(category, henchman_index)
	local loadout = managers.blackmarket:henchman_loadout(henchman_index)
	local new_node_data = {category = category}
	local selected_tab = self:create_pages(new_node_data, henchman_index, "weapon", loadout.primary_slot, tweak_data.gui.WEAPON_ROWS_PER_PAGE, tweak_data.gui.WEAPON_COLUMNS_PER_PAGE, tweak_data.gui.MAX_WEAPON_PAGES)
	new_node_data.can_move_over_tabs = true
	new_node_data.selected_tab = selected_tab
	new_node_data.scroll_tab_anywhere = true
	new_node_data.hide_detection_panel = true
	new_node_data.custom_callback = {
		w_equip = callback(self, self, "select_weapon", henchman_index),
		w_unequip = callback(self, self, "select_weapon", henchman_index)
	}
	new_node_data.topic_id = "bm_menu_" .. category
	new_node_data.topic_params = {
		weapon_category = managers.localization:text("bm_menu_weapons")
	}
	managers.menu:open_node("blackmarket_node", {new_node_data})
end

function CrewManagementGui:open_mask_category_menu(henchman_index)
	local loadout = managers.blackmarket:henchman_loadout(henchman_index)
	loadout.mask_slot = loadout.mask_slot or 1
	local new_node_data = {category = "masks"}
	local selected_tab = self:create_pages(new_node_data, henchman_index, "mask", loadout.mask_slot, tweak_data.gui.MASK_ROWS_PER_PAGE, tweak_data.gui.MASK_COLUMNS_PER_PAGE, tweak_data.gui.MAX_MASK_PAGES)
	new_node_data.can_move_over_tabs = true
	new_node_data.selected_tab = selected_tab
	new_node_data.scroll_tab_anywhere = true
	new_node_data.hide_detection_panel = true
	new_node_data.custom_callback = {
		m_equip = callback(self, self, "select_mask", henchman_index)
	}
	new_node_data.topic_id = "bm_menu_masks"
	new_node_data.topic_params = {
		weapon_category = managers.localization:text("bm_menu_masks")
	}
	managers.menu:open_node("blackmarket_node", {new_node_data})
end

function CrewManagementGui:populate_primaries(henchman_index, data, gui)
	gui:populate_weapon_category_new(data)
	local loadout = managers.blackmarket:henchman_loadout(henchman_index)
	for k, v in ipairs(data) do
		local tweak = tweak_data.weapon[v.name]
		v.equipped = loadout.primary_slot == v.slot
		if tweak and not managers.blackmarket:is_weapon_category_allowed_for_crew(tweak.category) then
			v.buttons = {}
			v.unlocked = false
			v.lock_texture = "guis/textures/pd2/lock_incompatible"
			v.lock_text = managers.localization:text("menu_data_crew_not_allowed")
		elseif v.equipped then
			v.buttons = {"w_unequip"}
		elseif not v.empty_slot then
			v.buttons = {"w_equip"}
		end
		v.comparision_data = nil
		v.mini_icons = nil
	end
end

function CrewManagementGui:populate_masks(henchman_index, data, gui)
	gui:populate_masks_new(data)
	local loadout = managers.blackmarket:henchman_loadout(henchman_index)
	for k, v in ipairs(data) do
		v.equipped = loadout.mask_slot == v.slot
		if not v.empty_slot then
			v.buttons = {"m_equip"}
		end
	end
end

function CrewManagementGui:populate_skill(params, data, gui)
	local category, henchman_index = unpack(params)
	local skills = {
		"crew_healthy",
		"crew_sturdy",
		"crew_evasive",
		"crew_motivated",
		"crew_regen",
		"crew_quiet",
		"crew_generous",
		"crew_eager"
	}
	self:populate_custom(category, henchman_index, tweak_data.upgrades.crew_skill_definitions, skills, data, gui)
end

function CrewManagementGui:populate_ability(henchman_index, data, gui)
	local abilities = {
		"crew_interact",
		"crew_inspire",
		"crew_scavenge"
	}
	self:populate_custom("ability", henchman_index, tweak_data.upgrades.crew_ability_definitions, abilities, data, gui)
end

function CrewManagementGui:populate_custom(category, henchman_index, tweak, list, data, gui)
	local loadout = managers.blackmarket:henchman_loadout(henchman_index)
	local map = self:_create_member_loadout_map(category)
	local new_data = {}
	for i, name in pairs(list) do
		local v = tweak[name]
		new_data = {}
		new_data.name = name
		new_data.name_id = v.name_id
		new_data.name_localized = managers.localization:text(v.name_id)
		new_data.bitmap_texture = {
			tweak_data.hud_icons:get_icon_data(v.icon)
		}
		new_data.category = category
		new_data.unlocked = managers.blackmarket:is_crew_item_unlocked(name)
		new_data.equipped = loadout[category] == name
		new_data.equipped_by = map[name] ~= henchman_index and map[name] or nil
		if not new_data.unlocked then
			if managers.blackmarket:can_afford_crew_item(name) then
				new_data.lock_texture = "guis/textures/pd2/ccoin"
				new_data.lock_color = Color.white
			else
				new_data.lock_texture = "guis/textures/pd2/lock_ccoin"
			end
			new_data.lock_text = managers.localization:text("menu_data_crew_item_unlock_cost", {
				cost = managers.blackmarket:crew_item_cost(name)
			})
			new_data.buttons = {"ci_unlock"}
		elseif not new_data.equipped then
			new_data.buttons = {
				"custom_select"
			}
		else
			new_data.buttons = {
				"custom_unselect"
			}
		end
		data[i] = new_data
	end
	local max_slots = data.override_slots[1] * data.override_slots[2]
	for i = 1, max_slots do
		if not data[i] then
			new_data = {}
			new_data.name = "empty"
			new_data.name_localized = ""
			new_data.category = category
			new_data.unlocked = true
			new_data.equipped = false
			data[i] = new_data
		end
	end
end

function CrewManagementGui:populate_characters(henchman_index, data, gui)
	gui:populate_characters(data)
	local preferred = managers.blackmarket:preferred_henchmen()
	for k, v in ipairs(data) do
		local equipped_by = table.get_key(preferred, v.name)
		v.equipped = equipped_by
		v.equipped_by = equipped_by
		v.equipped_text = v.equipped_by and tostring(equipped_by) or nil
		if v.unlocked then
			v.buttons = {
				v.equipped and "custom_unselect" or "custom_select",
				"c_clear_slots"
			}
		else
			v.buttons = {}
		end
	end
end

function CrewManagementGui:select_weapon(index, data, gui)
	print("[CrewManagementGui]:select_weapon", index, data, gui)
	print(inspect(data))
	local loadout = managers.blackmarket:henchman_loadout(index)
	if data.equipped then
		loadout.primary = nil
		loadout.primary_slot = nil
	else
		local crafted = managers.blackmarket:get_crafted_category_slot(data.category, data.slot)
		loadout.primary = crafted.factory_id .. "_npc"
		loadout.primary_slot = data.slot
		print(loadout.primary_slot)
	end
	gui:reload()
end

function CrewManagementGui:select_mask(index, data, gui)
	print("[CrewManagementGui]:select_mask", index, data, gui)
	local loadout = managers.blackmarket:henchman_loadout(index)
	loadout.mask = data.name
	loadout.mask_slot = data.slot
	gui:reload()
end

function CrewManagementGui:select_ability(index, data, gui)
	self:select_skill({"ability", index}, data, gui)
end

function CrewManagementGui:select_skill(params, data, gui)
	local loadout_name, henchman_index = unpack(params)
	local map = self:_create_member_loadout_map(loadout_name)
	local loadout = managers.blackmarket:henchman_loadout(henchman_index)
	loadout[loadout_name] = data.name
	if map[data.name] then
		managers.blackmarket:henchman_loadout(map[data.name])[loadout_name] = nil
	end
	gui:reload()
end

function CrewManagementGui:select_characters(data, gui)
	local preferred = managers.blackmarket:preferred_henchmen()
	if data.equipped_by then
		print("unselect")
		managers.blackmarket:set_preferred_henchmen(data.equipped_by, nil)
	else
		local index = math.min(#preferred + 1, 3)
		print(index, #preferred)
		managers.blackmarket:set_preferred_henchmen(index, data.name)
	end
	gui:reload()
end

function CrewManagementGui:clear_character_order(data, gui)
	local preferred = managers.blackmarket:preferred_henchmen()
	for k, v in pairs(preferred) do
		preferred[k] = nil
	end
	gui:reload()
end
