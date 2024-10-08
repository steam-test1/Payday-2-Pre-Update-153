local massive_font = tweak_data.menu.pd2_massive_font
local large_font = tweak_data.menu.pd2_large_font
local medium_font = tweak_data.menu.pd2_medium_font
local small_font = tweak_data.menu.pd2_small_font
local massive_font_size = tweak_data.menu.pd2_massive_font_size
local large_font_size = tweak_data.menu.pd2_large_font_size
local medium_font_size = tweak_data.menu.pd2_medium_font_size
local small_font_size = tweak_data.menu.pd2_small_font_size
local PANEL_PADDING = 10
MutatorsCategoryPage = MutatorsCategoryPage or class(MenuGuiTabPage)
MutatorsCategoryPage.category = "all"

function MutatorsCategoryPage:init(page_id, page_panel, fullscreen_panel, gui)
	MutatorsCategoryPage.super.init(self, page_id, page_panel, fullscreen_panel, gui)
	self.make_fine_text = BlackMarketGui.make_fine_text
	self._scrollable_panels = {}
	self:_setup_mutators_list()
	self:_setup_help_panel()
	if not managers.menu:is_pc_controller() then
		self:_set_selected(self._items[1])
	end
end

function MutatorsCategoryPage:_setup_mutators_list()
	self._items = {}
	self._buttons = {}
	local mutators_list = {}
	local scroll = ScrollablePanel:new(self:panel(), "MutatorsPanel", {padding = 0})
	scroll:on_canvas_updated_callback(callback(self, self, "_on_mutators_panel_updated"))
	BoxGuiObject:new(scroll:panel(), {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	table.insert(self._scrollable_panels, scroll)
	self._mutators_scroll = scroll
	for i, mutator in ipairs(managers.mutators:mutators()) do
		if self.category == "all" or table.contains(mutator.categories, self.category) then
			table.insert(mutators_list, mutator)
		end
	end
	table.sort(mutators_list, function(a, b)
		return a:name() < b:name()
	end)
	local index = 0
	for i, mutator in ipairs(mutators_list) do
		local item = MutatorItem:new(scroll:canvas(), mutator, index)
		table.insert(self._items, item)
		index = index + 1
	end
	for i = 1, #self._items do
		if 1 < i then
			self._items[i]:link("prev", self._items[i - 1])
		end
		if i < #self._items then
			self._items[i]:link("next", self._items[i + 1])
		end
	end
	scroll:update_canvas_size()
	local new_h = self._items[#self._items]:bottom()
	scroll:set_canvas_size(scroll:canvas():w(), new_h)
end

function MutatorsCategoryPage:_on_mutators_panel_updated()
	if self._mutators_scroll:is_scrollable() then
		for i, mutator_item in ipairs(self._items) do
			mutator_item._panel:set_w(self._mutators_scroll:canvas():w() - 24)
		end
	end
end

function MutatorsCategoryPage:help_text_panel()
	return self._help_text_panel
end

function MutatorsCategoryPage:buttons_panel()
	return self._buttons_panel
end

function MutatorsCategoryPage:_setup_help_panel()
	self._help_text_panel = self:info_panel():panel({})
	self._buttons_panel = self:info_panel():panel({})
	local text_title = self:info_panel():text({
		name = "title_text",
		font_size = medium_font_size,
		font = medium_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.title,
		text = managers.localization:to_upper_text("menu_mutators"),
		w = self:info_panel():w() - PANEL_PADDING * 2,
		h = medium_font_size,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_title:set_left(PANEL_PADDING)
	text_title:set_top(PANEL_PADDING)
	local text_desc = self:info_panel():text({
		name = "help_text",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text,
		text = managers.localization:text("menu_mutators_desc"),
		wrap = true,
		word_wrap = true,
		w = self:info_panel():w() - PANEL_PADDING * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_desc:set_left(PANEL_PADDING)
	text_desc:set_top(text_title:bottom())
	local _, _, _, h = text_desc:text_rect()
	text_desc:set_h(h)
	local text_longdesc = self:info_panel():text({
		name = "mutator_longdesc_text",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.text,
		text = "",
		wrap = true,
		word_wrap = true,
		w = self:info_panel():w() - PANEL_PADDING * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_longdesc:set_left(PANEL_PADDING)
	text_longdesc:set_top(text_desc:bottom() + PANEL_PADDING)
	local _, _, _, h = text_longdesc:text_rect()
	text_longdesc:set_h(h)
	self._mutator_longdesc = text_longdesc
	local text_incompatibilities = self:info_panel():text({
		name = "incompatibilities_text",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.important_1,
		text = managers.localization:text("menu_mutators_incompatibilities"),
		wrap = true,
		word_wrap = true,
		w = self:info_panel():w() - PANEL_PADDING * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_incompatibilities:set_left(PANEL_PADDING)
	text_incompatibilities:set_top(text_longdesc:bottom() + PANEL_PADDING)
	local _, _, _, h = text_incompatibilities:text_rect()
	text_incompatibilities:set_h(h)
	text_incompatibilities:set_visible(false)
	self._incompatibilities_text = text_incompatibilities
	local text_achievements = self:info_panel():text({
		name = "achievement_text",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.important_1,
		text = managers.localization:text("menu_mutators_achievement_disabled"),
		wrap = true,
		word_wrap = true,
		w = self:info_panel():w() - PANEL_PADDING * 2,
		h = small_font_size * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_achievements:set_left(PANEL_PADDING)
	text_achievements:set_top(text_longdesc:bottom() + PANEL_PADDING)
	local _, _, _, h = text_achievements:text_rect()
	text_achievements:set_h(h)
	text_achievements:set_visible(managers.mutators:are_mutators_enabled())
	self._achievements_text = text_achievements
	local text_reduction = self:info_panel():text({
		name = "reduction_text",
		font_size = small_font_size,
		font = small_font,
		layer = 1,
		blend_mode = "add",
		color = tweak_data.screen_colors.important_1,
		text = managers.localization:text("menu_mutators_reduction", self:_get_reduction_macros()),
		wrap = true,
		word_wrap = true,
		w = self:info_panel():w() - PANEL_PADDING * 2,
		h = small_font_size * 2,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale"
	})
	text_reduction:set_left(PANEL_PADDING)
	text_reduction:set_top(text_achievements:bottom() + PANEL_PADDING)
	local _, _, _, h = text_reduction:text_rect()
	text_reduction:set_h(h)
	text_reduction:set_visible(managers.mutators:are_mutators_enabled() and (1 > managers.mutators:get_cash_multiplier() or 1 > managers.mutators:get_experience_multiplier()))
	self._reduction_text = text_reduction
	self._buttons = {}
	self._controllers_pc_mapping = {}
	self._controllers_mapping = {}
	local buttons = {
		{
			btn = "BTN_Y",
			pc_btn = "menu_modify_item",
			name_id = "menu_mutators_reset_all",
			callback = callback(self, self, "_reset_mutators")
		}
	}
	if not managers.menu:is_pc_controller() then
		table.insert(buttons, {
			btn = "BTN_A",
			pc_btn = nil,
			name_id = "menu_mutators_toggle",
			callback = nil,
			prio = 10
		})
		table.insert(buttons, {
			btn = "BTN_X",
			pc_btn = "menu_remove_item",
			name_id = "menu_mutators_change_options",
			callback = callback(self, self, "_open_selected_options")
		})
	end
	table.sort(buttons, function(a, b)
		return (a.prio or 0) > (b.prio or 0)
	end)
	local btn_x = 10
	for btn, btn_data in pairs(buttons) do
		local new_button = MenuGuiButtonItem:new(self:buttons_panel(), btn_data, btn_x, btn)
		self._buttons[btn] = new_button
		if btn_data.pc_btn then
			self._controllers_mapping[btn_data.pc_btn:key()] = new_button
		end
	end
	self:buttons_panel():set_h(table.size(buttons) * tweak_data.menu.pd2_small_font_size + 20)
	self:help_text_panel():set_h(self:help_text_panel():h() - self:buttons_panel():h() - 10)
	self:buttons_panel():set_top(self:help_text_panel():bottom() + 10)
	BoxGuiObject:new(self:help_text_panel(), {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	BoxGuiObject:new(self:buttons_panel(), {
		sides = {
			1,
			1,
			1,
			1
		}
	})
end

function MutatorsCategoryPage:refresh()
	MutatorsCategoryPage.super.refresh(self)
	local compatible, incompatible_mutator
	if self._selected_item then
		local longdesc = self._selected_item:mutator():longdesc()
		self._mutator_longdesc:set_text(longdesc and longdesc ~= "" and longdesc or "")
		local _, _, _, h = self._mutator_longdesc:text_rect()
		self._mutator_longdesc:set_h(h)
		compatible, incompatible_mutator = managers.mutators:can_enable_mutator(self._selected_item:mutator())
		if not compatible then
			self._incompatibilities_text:set_text(managers.localization:text("menu_mutators_incompatibilities", {
				mutators = incompatible_mutator:name()
			}))
			self._incompatibilities_text:set_visible(true)
			local _, _, _, h = self._incompatibilities_text:text_rect()
			self._incompatibilities_text:set_h(h)
			self._incompatibilities_text:set_top(self._mutator_longdesc:bottom() + PANEL_PADDING)
		else
			self._incompatibilities_text:set_text("")
			self._incompatibilities_text:set_h(0)
			self._incompatibilities_text:set_visible(false)
		end
	end
	if self._achievements_text then
		self._achievements_text:set_visible(managers.mutators:are_mutators_enabled())
		self._achievements_text:set_top((not compatible and self._incompatibilities_text or self._mutator_longdesc):bottom() + PANEL_PADDING)
	end
	if self._reduction_text then
		self._reduction_text:set_visible(managers.mutators:are_mutators_enabled() and (managers.mutators:get_cash_multiplier() < 1 or 1 > managers.mutators:get_experience_multiplier()))
		if managers.mutators:are_mutators_enabled() then
			self._reduction_text:set_text(managers.localization:text("menu_mutators_reduction", self:_get_reduction_macros()))
		end
		self._reduction_text:set_top(self._achievements_text:bottom() + PANEL_PADDING)
	end
	if self._items then
		for _, item in ipairs(self._items) do
			item:refresh()
		end
	end
end

function MutatorsCategoryPage:_get_reduction_macros()
	return {
		cash_reduction = math.round((1 - managers.mutators:get_cash_multiplier()) * 100),
		exp_reduction = math.round((1 - managers.mutators:get_experience_multiplier()) * 100)
	}
end

function MutatorsCategoryPage:_set_selected(item)
	if self._selected_item ~= item then
		if self._selected_item then
			self._selected_item:set_selected(false)
		end
		self._selected_item = item
		if item then
			self._selected_item:set_selected(true)
		end
		self:refresh()
	end
end

function MutatorsCategoryPage:_reset_mutators()
	managers.mutators:reset_all_mutators()
	self:refresh()
end

function MutatorsCategoryPage:_open_selected_options()
	if self:is_active() and self._selected_item then
		self._selected_item:trigger_options()
	end
end

function MutatorsCategoryPage:get_legend()
	return {}
end

function MutatorsCategoryPage:is_active()
	if managers.menu:active_menu().logic:selected_node():parameters().name == "mutators_options" then
		return false
	end
	return MutatorsCategoryPage.super.is_active(self)
end

function MutatorsCategoryPage:mouse_moved(button, x, y)
	if not self:is_active() then
		return
	end
	local allow_selection = true
	local used, pointer
	for i, panel in pairs(self._scrollable_panels) do
		if panel then
			local values = {
				panel:mouse_moved(button, x, y)
			}
			if values[1] ~= nil then
				return unpack(values)
			end
		end
	end
	for i, item in ipairs(self._items or {}) do
		local used, new_pointer = item:mouse_moved(button, x, y, allow_selection)
		if used then
			allow_selection = false
			pointer = new_pointer
			self:_set_selected(item)
		end
	end
	for _, button in ipairs(self._buttons) do
		if button:inside(x, y) then
			button:set_selected(true)
			used, pointer = true, "link"
		else
			button:set_selected(false)
		end
	end
	return pointer ~= nil, pointer
end

function MutatorsCategoryPage:mouse_pressed(button, x, y)
	if not self:is_active() then
		return
	end
	for i, panel in pairs(self._scrollable_panels) do
		if panel then
			local values = {
				panel:mouse_pressed(button, x, y)
			}
			if values[1] ~= nil then
				return unpack(values)
			end
		end
	end
	for _, item in ipairs(self._items) do
		if item:inside(x, y) then
			item:trigger(x, y)
			return
		end
	end
	for _, button in ipairs(self._buttons) do
		if button:inside(x, y) then
			button:trigger()
			return true
		end
	end
end

function MutatorsCategoryPage:mouse_released(button, x, y)
	if not self:is_active() then
		return
	end
	for i, panel in pairs(self._scrollable_panels) do
		if panel then
			local values = {
				panel:mouse_released(button, x, y)
			}
			if values[1] ~= nil then
				self._prevent_click = (self._prevent_click or 0) + 1
				return unpack(values)
			end
		end
	end
end

function MutatorsCategoryPage:mouse_wheel_up(x, y)
	if not self:is_active() then
		return
	end
	for i, panel in pairs(self._scrollable_panels) do
		if panel then
			local values = {
				panel:scroll(x, y, 1)
			}
			if values[1] ~= nil then
				return unpack(values)
			end
		end
	end
end

function MutatorsCategoryPage:mouse_wheel_down(x, y)
	if not self:is_active() then
		return
	end
	for i, panel in pairs(self._scrollable_panels) do
		if panel then
			local values = {
				panel:scroll(x, y, -1)
			}
			if values[1] ~= nil then
				return unpack(values)
			end
		end
	end
end

function MutatorsCategoryPage:confirm_pressed()
	if self:is_active() and self._selected_item then
		self._selected_item:trigger()
	end
end

function MutatorsCategoryPage:move_up()
	if self:is_active() and self._selected_item and self._selected_item:get_link("prev") then
		self:_set_selected(self._selected_item:get_link("prev"))
		self:_scroll(self._selected_item)
	end
end

function MutatorsCategoryPage:move_down()
	if self:is_active() and self._selected_item and self._selected_item:get_link("next") then
		self:_set_selected(self._selected_item:get_link("next"))
		self:_scroll(self._selected_item)
	end
end

function MutatorsCategoryPage:_scroll(target)
	local scroll_panel = self._mutators_scroll:scroll_panel()
	local y = self._mutators_scroll:canvas():y() + target:bottom()
	if y > scroll_panel:h() then
		self._mutators_scroll:perform_scroll(y - scroll_panel:h(), -1)
	else
		y = self._mutators_scroll:canvas():y() + target:top()
		if y < 0 then
			self._mutators_scroll:perform_scroll(math.abs(y), 1)
		end
	end
end

MutatorItem = class(MenuGuiItem)

function MutatorItem:init(parent_panel, mutator, index)
	MutatorItem.super.init(self)
	local h = 64
	local spacing = 4
	self._mutator = mutator
	self._selected_options = false
	self._panel = parent_panel:panel({
		w = parent_panel:w() - 16,
		h = h,
		x = 8,
		y = 8 + index * h + index * spacing
	})
	self._icon_panel = self._panel:panel({
		w = self._panel:h(),
		h = self._panel:h(),
		layer = 100
	})
	BoxGuiObject:new(self._icon_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local tex, rect = mutator:icon()
	self._icon = self._icon_panel:bitmap({
		name = "icon",
		texture = tex,
		texture_rect = rect,
		blend_mode = "add",
		alpha = self:icon_alpha(),
		w = self._icon_panel:w(),
		h = self._icon_panel:h()
	})
	self._title_text = self._panel:text({
		name = "title",
		text = mutator:name(),
		align = "left",
		x = self._icon_panel:w() + 10,
		y = 8,
		h = medium_font_size,
		font_size = medium_font_size,
		font = medium_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add",
		layer = 1,
		alpha = self:text_alpha()
	})
	self._desc_text = self._panel:text({
		name = "title",
		text = mutator:desc(),
		align = "left",
		x = self._icon_panel:w() + 10,
		y = 10,
		h = small_font_size,
		font_size = small_font_size,
		font = medium_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add",
		layer = 1,
		alpha = self:text_alpha()
	})
	self._desc_text:set_top(self._title_text:bottom() + 2)
	self._select_rect = self._panel:rect({
		name = "select_rect",
		blend_mode = "add",
		color = tweak_data.screen_colors.button_stage_3,
		alpha = self:selection_alpha(),
		valign = "scale",
		halign = "scale"
	})
	self._select_rect:set_visible(false)
	self._enabled_rect = self._panel:rect({
		name = "enabled_rect",
		blend_mode = "add",
		color = tweak_data.screen_colors.button_stage_3,
		alpha = 0.35,
		valign = "scale",
		halign = "scale"
	})
	self._enabled_rect:set_visible(self:mutator():is_enabled())
	if mutator.has_options then
		local option_size = self._panel:h() - spacing * 2
		self._option_panel = self._panel:panel({
			w = option_size,
			h = option_size,
			x = self._panel:w() - option_size - spacing,
			y = spacing,
			halign = "right"
		})
		BoxGuiObject:new(self._option_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		local icon_size = MutatorsManager._icon_size
		self._options_icon = self._option_panel:bitmap({
			name = "options_icon",
			texture = MutatorsManager._atlas_file,
			texture_rect = {
				icon_size * (MutatorsManager._options_icon_coord[1] - 1),
				icon_size * (MutatorsManager._options_icon_coord[2] - 1),
				icon_size,
				icon_size
			},
			blend_mode = "add",
			alpha = 0.5,
			w = self._option_panel:w(),
			h = self._option_panel:h()
		})
		self._options_select_rect = self._option_panel:rect({
			name = "select_rect",
			blend_mode = "add",
			color = tweak_data.screen_colors.button_stage_3,
			alpha = self:selection_alpha(),
			valign = "scale",
			halign = "scale"
		})
		self._options_select_rect:set_visible(false)
		self._options_fill = self._option_panel:rect({
			name = "option_fill_rect",
			blend_mode = "add",
			color = tweak_data.screen_colors.button_stage_3,
			alpha = 0.4,
			valign = "scale",
			halign = "scale",
			h = self._option_panel:h() * self:mutator():options_fill()
		})
		self._options_fill:set_visible(true)
	end
end

function MutatorItem:mutator()
	return self._mutator
end

function MutatorItem:icon_alpha()
	return self:mutator():is_enabled() and 1 or 0.35
end

function MutatorItem:text_alpha()
	return self:mutator():is_enabled() and 1 or 0.8
end

function MutatorItem:selection_alpha()
	return self:mutator():is_enabled() and 0.4 or 0.65
end

function MutatorItem:inside(x, y)
	return self._panel:inside(x, y)
end

function MutatorItem:trigger(x, y)
	if managers.menu:active_menu().logic:selected_node():parameters().name == "mutators_options" then
		return false
	end
	if self:mutator().has_options and self._option_panel:inside(x, y) then
		self:trigger_options()
	elseif managers.mutators:can_enable_mutator(self:mutator()) then
		managers.mutators:set_enabled(self:mutator(), not self:mutator():is_enabled())
		managers.menu_component:mutators_list_gui():refresh()
		managers.menu:active_menu().callback_handler:_update_mutators_info()
		MutatorItem.super.trigger(self)
	else
		managers.menu_component:post_event("menu_error")
	end
end

function MutatorItem:trigger_options()
	if managers.menu:active_menu().logic:selected_node():parameters().name == "mutators_options" then
		return false
	end
	managers.menu:open_node("mutators_options", {
		self:mutator()
	})
end

function MutatorItem:top()
	return self._panel:top() - PANEL_PADDING
end

function MutatorItem:bottom()
	return self._panel:bottom() + PANEL_PADDING
end

function MutatorItem:refresh()
	local compatible = managers.mutators:can_enable_mutator(self:mutator())
	local compatible_color = compatible and tweak_data.screen_colors.button_stage_3 or tweak_data.screen_colors.important_1
	local compatible_color_text = compatible and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1
	local selection_alpha = compatible and self:selection_alpha() or 0.4
	if self._options_icon then
		self._options_icon:set_alpha(self._selected_options and 1 or 0.5)
	end
	if self._options_select_rect then
		self._options_select_rect:set_visible(self._selected_options)
		self._options_select_rect:set_color(compatible_color)
		self._options_select_rect:set_alpha(selection_alpha)
	end
	self._select_rect:set_visible(self._selected)
	self._select_rect:set_color(compatible_color)
	self._select_rect:set_alpha(selection_alpha)
	self._title_text:set_text(self:mutator():name())
	self._title_text:set_color(compatible_color_text)
	self._title_text:set_alpha(self:text_alpha())
	self._desc_text:set_alpha(self:text_alpha())
	self._icon:set_alpha(self:icon_alpha())
	self._enabled_rect:set_visible(self:mutator():is_enabled())
	if self._options_fill then
		self._options_fill:set_h(self._option_panel:h() * self:mutator():options_fill())
		self._options_fill:set_y(self._option_panel:h() - self._options_fill:h())
	end
end

function MutatorItem:set_options_selected(selected, play_sound)
	if self._selected_options ~= selected then
		self._selected_options = selected
		self:refresh()
		if self._selected_options and play_sound ~= false then
			managers.menu_component:post_event("highlight")
		end
	end
end

function MutatorItem:mouse_moved(button, x, y, allow_selection)
	if allow_selection then
		if self:mutator().has_options and self._option_panel:inside(x, y) then
			self:set_options_selected(true)
			self:set_selected(false)
			return true, "link"
		elseif self._panel:inside(x, y) then
			self:set_options_selected(false)
			self:set_selected(true)
			return true, "link"
		end
	end
	self:set_options_selected(false)
	self:set_selected(false)
end

function MutatorItem:link(position, item)
	self._links = self._links or {}
	self._links[position] = item
end

function MutatorItem:get_link(position)
	self._links = self._links or {}
	return self._links[position]
end
