MenuNodeCrimenetGui = MenuNodeCrimenetGui or class(MenuNodeGui)

function MenuNodeCrimenetGui:init(node, layer, parameters)
	parameters.font = tweak_data.menu.pd2_small_font
	parameters.font_size = tweak_data.menu.pd2_small_font_size
	parameters.align = "left"
	parameters.row_item_blend_mode = "add"
	parameters.row_item_color = tweak_data.screen_colors.button_stage_3
	parameters.row_item_hightlight_color = tweak_data.screen_colors.button_stage_2
	parameters.marker_alpha = 1
	parameters.to_upper = true
	MenuNodeCrimenetGui.super.init(self, node, layer, parameters)
end

function MenuNodeCrimenetGui:_setup_item_panel(safe_rect, res)
	MenuNodeHiddenGui.super._setup_item_panel(self, safe_rect, res)
	local width = 900
	local height = 580
	if SystemInfo:platform() ~= Idstring("WIN32") then
		width = 800
		height = 500
	end
	self.item_panel:set_rightbottom(self.item_panel:parent():w() * 0.5 + width / 2 - 10, self.item_panel:parent():h() * 0.5 + height / 2 - 10)
	self:_set_topic_position()
end

MenuNodeCrimenetFiltersGui = MenuNodeCrimenetFiltersGui or class(MenuNodeGui)

function MenuNodeCrimenetFiltersGui:init(node, layer, parameters)
	parameters.font = tweak_data.menu.pd2_small_font
	parameters.font_size = tweak_data.menu.pd2_small_font_size
	parameters.align = "left"
	parameters.row_item_blend_mode = "add"
	parameters.row_item_color = tweak_data.screen_colors.button_stage_3
	parameters.row_item_hightlight_color = tweak_data.screen_colors.button_stage_2
	parameters.marker_alpha = 1
	parameters.to_upper = true
	self.static_y = node:parameters().static_y
	MenuNodeCrimenetFiltersGui.super.init(self, node, layer, parameters)
end

function MenuNodeCrimenetFiltersGui:close(...)
	MenuNodeCrimenetFiltersGui.super.close(self, ...)
end

function MenuNodeCrimenetFiltersGui:_setup_item_panel(safe_rect, res)
	MenuNodeCrimenetFiltersGui.super._setup_item_panel(self, safe_rect, res)
	local max_layer = 10000
	local min_layer = 0
	local child_layer = 0
	for _, child in ipairs(self.item_panel:children()) do
		child:set_halign("right")
		child_layer = child:layer()
		if 0 < child_layer then
			min_layer = math.min(min_layer, child_layer)
		end
		max_layer = math.max(max_layer, child_layer)
	end
	for _, child in ipairs(self.item_panel:children()) do
	end
	self.item_panel:set_w(safe_rect.width * (1 - self._align_line_proportions))
	self.item_panel:set_center(self.item_panel:parent():w() / 2, self.item_panel:parent():h() / 2)
	local static_y = self.static_y and safe_rect.height * self.static_y
	if static_y and static_y < self.item_panel:y() then
		self.item_panel:set_y(static_y)
	end
	self.item_panel:set_position(math.round(self.item_panel:x()), math.round(self.item_panel:y()))
	self:_rec_round_object(self.item_panel)
	if alive(self.box_panel) then
		self.item_panel:parent():remove(self.box_panel)
		self.box_panel = nil
	end
	self.box_panel = self.item_panel:parent():panel()
	self.box_panel:set_x(self.item_panel:x())
	self.box_panel:set_w(self.item_panel:w())
	if self.item_panel:h() > self._align_data.panel:h() then
		self.box_panel:set_y(0)
		self.box_panel:set_h(self.item_panel:parent():h())
	else
		self.box_panel:set_y(self.item_panel:top())
		self.box_panel:set_h(self.item_panel:h())
	end
	self.box_panel:grow(20, 20)
	self.box_panel:move(-10, -10)
	self.box_panel:set_layer(51)
	self.boxgui = BoxGuiObject:new(self.box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self.boxgui:set_clipping(false)
	self.boxgui:set_layer(1000)
	self.box_panel:rect({
		color = Color.black,
		alpha = 0.6,
		rotation = 360
	})
	self._align_data.panel:set_left(self.box_panel:left())
	self._list_arrows.up:set_world_left(self._align_data.panel:world_left())
	self._list_arrows.up:set_world_top(self._align_data.panel:world_top() - 10)
	self._list_arrows.up:set_width(self.box_panel:width())
	self._list_arrows.up:set_rotation(360)
	self._list_arrows.up:set_layer(1050)
	self._list_arrows.down:set_world_left(self._align_data.panel:world_left())
	self._list_arrows.down:set_world_bottom(self._align_data.panel:world_bottom() + 10)
	self._list_arrows.down:set_width(self.box_panel:width())
	self._list_arrows.down:set_rotation(360)
	self._list_arrows.down:set_layer(1050)
	self:_set_topic_position()
end

function MenuNodeCrimenetFiltersGui:_setup_item_panel_parent(safe_rect, shape)
	shape = shape or {}
	shape.x = shape.x or safe_rect.x
	shape.y = shape.y or safe_rect.y + 0
	shape.w = shape.w or safe_rect.width
	shape.h = shape.h or safe_rect.height - 0
	MenuNodeCrimenetFiltersGui.super._setup_item_panel_parent(self, safe_rect, shape)
end

function MenuNodeCrimenetFiltersGui:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function MenuNodeCrimenetFiltersGui:_setup_item_rows(node)
	MenuNodeCrimenetFiltersGui.super._setup_item_rows(self, node)
end

function MenuNodeCrimenetFiltersGui:reload_item(item)
	MenuNodeCrimenetFiltersGui.super.reload_item(self, item)
	local row_item = self:row_item(item)
	if row_item and alive(row_item.gui_panel) then
		row_item.gui_panel:set_halign("right")
		row_item.gui_panel:set_right(self.item_panel:w())
	end
end

function MenuNodeCrimenetFiltersGui:_align_marker(row_item)
	MenuNodeCrimenetFiltersGui.super._align_marker(self, row_item)
	if row_item.item:parameters().pd2_corner then
		self._marker_data.marker:set_world_right(row_item.gui_panel:world_right())
		return
	end
	self._marker_data.marker:set_world_right(self.item_panel:world_right())
end

function MenuNodeCrimenetFiltersGui:_highlight_row_item(row_item, mouse_over)
	MenuNodeCrimenetFiltersGui.super._highlight_row_item(self, row_item, mouse_over)
end

MenuNodeCrimenetCasinoGui = MenuNodeCrimenetCasinoGui or class(MenuNodeGui)

function MenuNodeCrimenetCasinoGui:init(node, layer, parameters)
	parameters.font = tweak_data.menu.pd2_small_font
	parameters.font_size = tweak_data.menu.pd2_small_font_size
	parameters.align = "left"
	parameters.row_item_blend_mode = "add"
	parameters.row_item_color = tweak_data.screen_colors.button_stage_3
	parameters.row_item_hightlight_color = tweak_data.screen_colors.button_stage_2
	parameters.marker_alpha = 1
	parameters.to_upper = true
	MenuNodeCrimenetCasinoGui.super.init(self, node, layer, parameters)
	self:_setup_layout()
end

function MenuNodeCrimenetCasinoGui:_setup_item_panel(safe_rect, res)
	MenuNodeCrimenetCasinoGui.super._setup_item_panel(self, safe_rect, res)
	local width, height, space_x, space_y, start_x = self:_get_sizes(safe_rect.width, safe_rect.height)
	self.item_panel:set_right(start_x + width)
	self.item_panel:set_bottom(self.item_panel:parent():h() - space_y - tweak_data.menu.pd2_large_font_size)
end

function MenuNodeCrimenetCasinoGui:_get_sizes(safe_width, safe_height)
	local space_x = safe_width * 0.05
	local space_y = safe_width * 0.05
	local width = safe_width * 0.42
	local height = safe_height - tweak_data.menu.pd2_large_font_size * 2 - space_y * 2
	local start_x = safe_width - (width + space_x) * 2
	return width, height, space_x, space_y, start_x
end

function MenuNodeCrimenetCasinoGui:_set_cards(amount, card)
	local texture, rect, coords = tweak_data.hud_icons:get_icon_data(card or "downcard_overkill_deck")
	local offset = 20
	local count = amount == 0 and 3 or amount
	local height
	local width = math.round(0.7111111 * self._betting_cards_panel:h())
	local x_offset = 0
	local y_offset = 0
	if amount == 0 then
		height = self._betting_cards_panel:h() * 0.6
		x_offset = math.round(0.7111111 * height / 2)
		y_offset = (self._betting_cards_panel:h() - height) / 2
	else
		height = self._betting_cards_panel:h()
	end
	local x = self._betting_cards_panel:w() / 2 - count * (width + offset) / 2
	local flip_cards
	if 0 < amount or self._current_amount ~= amount then
		self._current_amount = amount
		flip_cards = true
	end
	for i = 1, 3 do
		if coords then
			self._betting_cards[i]:set_texture_coordinates(Vector3(coords[1][1], coords[1][2], 0), Vector3(coords[2][1], coords[2][2], 0), Vector3(coords[3][1], coords[3][2], 0), Vector3(coords[4][1], coords[4][2], 0))
		else
			self._betting_cards[i]:set_texture_rect(unpack(rect))
		end
		self._betting_cards[i]:set_alpha(0 < amount and 1 or 0.25)
		self._betting_cards[i]:set_w(math.round(0.7111111 * height))
		self._betting_cards[i]:set_h(height)
		self._betting_cards[i]:set_x(x + x_offset)
		self._betting_cards[i]:set_y(y_offset)
		x = x + width + offset
		if flip_cards then
			self._betting_cards[i]:set_rotation(math.random(14) - 7)
			self._betting_cards[i]:animate(callback(self, self, "flipcard", self._betting_cards[i]), 1.5)
		end
		self._betting_cards[i]:set_visible(0 < count)
		count = count - 1
	end
end

function MenuNodeCrimenetCasinoGui:flipcard(bitmap)
	local start_w = bitmap:w()
	local cx, cy = bitmap:center()
	over(0.25, function(p)
		bitmap:set_w(start_w * math.sin(p * 90))
		bitmap:set_center(cx, cy)
	end)
end

function MenuNodeCrimenetCasinoGui:_round_value(value)
	local mult = 10
	return math.floor(value * mult + 0.5) / mult
end

function MenuNodeCrimenetCasinoGui:_setup_layout()
	local parent_layer = managers.menu:active_menu().renderer:selected_node():layer()
	self._panel = self.ws:panel():panel({
		layer = parent_layer + 1
	})
	local width, height, space_x, space_y, start_x = self:_get_sizes(self._panel:w(), self._panel:h())
	local large_font = tweak_data.menu.pd2_large_font
	local medium_font = tweak_data.menu.pd2_medium_font
	local small_font = tweak_data.menu.pd2_small_font
	local large_font_size = tweak_data.menu.pd2_large_font_size
	local medium_font_size = tweak_data.menu.pd2_medium_font_size
	local small_font_size = tweak_data.menu.pd2_small_font_size
	local option_size = self._panel:w() * (1 - self._align_line_proportions)
	local content_offset = 20
	local text_title = self._panel:text({
		text = managers.localization:to_upper_text("menu_casino_title_main"),
		font_size = large_font_size,
		font = large_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	local _, _, w, h = text_title:text_rect()
	self._main_panel = self._panel:panel({
		x = 0,
		y = h,
		w = self._panel:w(),
		h = self._panel:h() - h
	})
	local text_betting = self._main_panel:text({
		text = managers.localization:to_upper_text("menu_casino_title_betting"),
		font_size = medium_font_size,
		font = medium_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	text_betting:set_position(start_x, 0)
	local _, _, _, h = text_betting:text_rect()
	text_betting:set_h(h)
	self._betting_panel = self._main_panel:panel({
		y = text_betting:bottom(),
		w = width,
		h = height,
		layer = 1
	})
	self._betting_panel:set_x(text_betting:x())
	BoxGuiObject:new(self._betting_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local text_options = self._main_panel:panel({
		w = width - option_size,
		h = self.item_panel:h(),
		layer = 1
	})
	text_options:set_x(self._betting_panel:x())
	text_options:set_y(self.item_panel:y())
	local betting_titles = {
		{
			id = "prefer",
			text = "menu_casino_option_prefer_title"
		},
		{
			id = "infamous",
			text = "menu_casino_option_infamous_title"
		},
		{
			id = "safecards",
			text = "menu_casino_option_safecard_title"
		},
		{skip = true},
		{skip = true}
	}
	self._betting_titles = {}
	local i = 1
	local y = 0
	for _, item in ipairs(self.row_items) do
		if item.type ~= "divider" then
			if not betting_titles[i].skip then
				self._betting_titles[betting_titles[i].id] = text_options:text({
					text = managers.localization:to_upper_text(betting_titles[i].text),
					y = y,
					align = "right",
					font_size = small_font_size,
					font = small_font,
					color = tweak_data.screen_colors.text,
					blend_mode = "add"
				})
			end
			i = i + 1
		end
		y = y + item.gui_panel:h()
	end
	self._betting_carddeck = {
		none = "downcard_overkill_deck",
		weapon_mods = "upcard_weapon",
		masks = "upcard_mask",
		materials = "upcard_material",
		textures = "upcard_pattern",
		colors = "upcard_color",
		cash = "upcard_cash",
		xp = "upcard_xp"
	}
	self._betting_cards_panel = self._betting_panel:panel({
		x = content_offset,
		y = content_offset + 15,
		w = self._betting_panel:w() - content_offset * 2,
		layer = 1
	})
	self._betting_cards_panel:set_h((self.item_panel:y() - content_offset * 2) * 0.6)
	local texture, rect, coords = tweak_data.hud_icons:get_icon_data(self._betting_carddeck.none)
	self._betting_cards = {}
	for i = 1, 3 do
		self._betting_cards[i] = self._betting_cards_panel:bitmap({
			name = "upcard",
			texture = texture,
			w = math.round(0.7111111 * self._betting_cards_panel:h()),
			h = self._betting_cards_panel:h(),
			blend_mode = "add",
			layer = 1,
			halign = "scale",
			valign = "scale"
		})
		self._betting_cards[i]:set_rotation(math.random(14) - 7)
	end
	self:_set_cards(0)
	self._stats_panel = self._main_panel:panel({
		x = text_betting:x(),
		y = text_betting:bottom(),
		w = width,
		h = height / 2 - space_y / 2,
		layer = 1
	})
	self._stats_panel:set_x(self._betting_panel:right() + space_x)
	BoxGuiObject:new(self._stats_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local text_stats = self._main_panel:text({
		text = managers.localization:to_upper_text("menu_casino_title_stats"),
		font_size = medium_font_size,
		font = medium_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	local _, _, _, h = text_stats:text_rect()
	text_stats:set_h(h)
	text_stats:set_x(self._stats_panel:x())
	text_stats:set_bottom(self._betting_panel:top())
	self._stats_cards = {
		"weapon_mods",
		"masks",
		"materials",
		"textures",
		"colors"
	}
	local stat_columns = {
		{
			name = "base",
			color = Color(0.5, 0.5, 0.5),
			color_inf = Color(1, 0.1, 1)
		},
		{
			name = "bets",
			color = tweak_data.screen_colors.risk
		},
		{
			name = "skill",
			color = tweak_data.screen_colors.resource
		},
		{
			name = "total",
			color = tweak_data.screen_colors.text,
			color_inf = Color(1, 0.1, 1)
		}
	}
	self._stat_values = {}
	local title_width = 150
	local column_width = 70
	local text_panel
	local x = title_width + column_width * 0.55
	local y = content_offset
	for _, column in pairs(stat_columns) do
		self._stats_panel:text({
			text = managers.localization:to_upper_text("menu_casino_stat_" .. column.name),
			x = x,
			y = y,
			font_size = small_font_size,
			font = small_font,
			color = column.color or tweak_data.screen_colors.text,
			blend_mode = "add"
		})
		x = x + column_width
	end
	y = content_offset + small_font_size + 10
	for _, stat in pairs(self._stats_cards) do
		self._stat_values[stat] = {}
		x = title_width
		for _, column in pairs(stat_columns) do
			text_panel = self._stats_panel:panel({
				layer = 1,
				x = x,
				y = y,
				w = column_width,
				h = small_font_size
			})
			self._stat_values[stat][column.name] = text_panel:text({
				align = "right",
				font_size = small_font_size,
				font = small_font,
				color = column.color or tweak_data.screen_colors.text,
				blend_mode = "add",
				alpha = 1
			})
			x = x + column_width
		end
		y = y + small_font_size
	end
	y = content_offset + small_font_size + 10
	for _, stat in pairs(self._stats_cards) do
		text_panel = self._stats_panel:panel({
			layer = 1,
			x = 0,
			y = y,
			w = title_width,
			h = small_font_size
		})
		self._stat_values[stat].title = text_panel:text({
			text = managers.localization:to_upper_text("menu_casino_stat_" .. stat),
			font_size = small_font_size,
			font = small_font,
			align = "right",
			color = tweak_data.screen_colors.text,
			blend_mode = "add",
			alpha = 1
		})
		y = y + small_font_size
	end
	self._infamous_values = {}
	y = y + small_font_size
	text_panel = self._stats_panel:panel({
		layer = 1,
		x = 0,
		y = y,
		w = title_width,
		h = small_font_size
	})
	text_panel:text({
		text = managers.localization:to_upper_text("bm_global_value_infamous"),
		font_size = small_font_size,
		font = small_font,
		align = "right",
		color = Color(1, 0.1, 1),
		blend_mode = "add"
	})
	x = title_width
	for _, column in pairs(stat_columns) do
		text_panel = self._stats_panel:panel({
			layer = 1,
			x = x,
			y = y,
			w = column_width,
			h = small_font_size
		})
		self._infamous_values[column.name] = text_panel:text({
			align = "right",
			font_size = small_font_size,
			font = small_font,
			color = column.color_inf or column.color or tweak_data.screen_colors.text,
			blend_mode = "add",
			alpha = column.alpha or 1
		})
		x = x + column_width
	end
	local stars = managers.experience:level_to_stars()
	local item_pc = tweak_data.lootdrop.STARS[stars].pcs[1]
	local skip_types = {cash = true, xp = true}
	local droppable_items = managers.lootdrop:droppable_items(item_pc, true, skip_types)
	local pc = stars * 10
	local weighted_type_chance = tweak_data.lootdrop.WEIGHTED_TYPE_CHANCE[pc]
	local sum = 0
	for type, items in pairs(droppable_items) do
		sum = sum + weighted_type_chance[type]
	end
	self._base_chances = {}
	for _, item in pairs(self._stats_cards) do
		self._base_chances[item] = 0
	end
	for type, items in pairs(droppable_items) do
		self._base_chances[type] = self:_round_value(weighted_type_chance[type] / sum * 100)
	end
	for _, stat in pairs(self._stats_cards) do
		local value = string.format("%.1f", self._base_chances[stat])
		self._stat_values[stat].base:set_text(value .. "%")
		self._stat_values[stat].total:set_text(value .. "%")
	end
	local items_total = 0
	local items_infamous = 0
	for type, items in pairs(droppable_items) do
		items_total = items_total + #items
		for _, item in pairs(items) do
			if item.global_value == "infamous" then
				items_infamous = items_infamous + 1
			end
		end
	end
	local infamous_chance = 0 < items_total and managers.lootdrop:infamous_chance() * (items_infamous / items_total) or 0
	local infamous_mod = managers.player:upgrade_value("player", "passive_loot_drop_multiplier", 1) * managers.player:upgrade_value("player", "loot_drop_multiplier", 1)
	self._infamous_chance = {}
	self._infamous_chance.base = infamous_chance
	self._infamous_chance.skill = infamous_mod
	local value = self:_round_value(infamous_chance * 100)
	local skill = self:_round_value((infamous_chance * infamous_mod - infamous_chance) * 100)
	self._infamous_chance.value_base = value
	self._infamous_chance.value_skill = skill
	self._infamous_values.base:set_text(string.format("%.1f", value) .. "%")
	self._infamous_values.skill:set_text(1 < infamous_mod and "+" .. string.format("%.1f", skill) .. "%" or "")
	self._infamous_values.total:set_text(string.format("%.1f", value + skill) .. "%")
	self._breakdown_panel = self._main_panel:panel({
		w = width,
		h = self._betting_panel:h() - self._stats_panel:h() - space_y,
		layer = 1
	})
	self._breakdown_panel:set_x(self._stats_panel:x())
	self._breakdown_panel:set_top(self._stats_panel:bottom() + space_y)
	BoxGuiObject:new(self._breakdown_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local text_breakdown = self._main_panel:text({
		text = managers.localization:to_upper_text("menu_casino_title_breakdown"),
		font_size = medium_font_size,
		font = medium_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	local _, _, _, h = text_breakdown:text_rect()
	text_breakdown:set_h(h)
	text_breakdown:set_x(self._breakdown_panel:x())
	text_breakdown:set_bottom(self._breakdown_panel:top())
	self._breakdown_titles = self._breakdown_panel:text({
		x = content_offset,
		y = content_offset,
		font_size = small_font_size,
		font = small_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	self._breakdown_costs = self._breakdown_panel:text({
		x = self._breakdown_panel:w() * 0.4,
		y = content_offset,
		font_size = small_font_size,
		font = small_font,
		color = tweak_data.screen_colors.risk,
		blend_mode = "add"
	})
	self._offshore_text = self._main_panel:text({
		font_size = small_font_size,
		font = small_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	self:set_offshore_text()
	local _, _, w, h = self._offshore_text:text_rect()
	self._offshore_text:set_h(h)
	self._offshore_text:set_x(self._betting_panel:x())
	self._offshore_text:set_y(self._betting_panel:bottom() + h + 16)
	local secured_cards = 0
	local increase_infamous = false
	local preferred_card = "none"
	local text_string = managers.localization:to_upper_text("menu_casino_total_bet", {
		casino_bet = managers.experience:cash_string(managers.money:get_cost_of_casino_fee(secured_cards, increase_infamous, preferred_card))
	})
	self._total_bet = self._panel:text({
		text = text_string,
		font_size = large_font_size,
		font = large_font,
		color = tweak_data.screen_colors.text,
		blend_mode = "add",
		align = "right"
	})
	local _, _, _, h = self._total_bet:text_rect()
	self._total_bet:set_h(h)
	self._total_bet:set_right(self._breakdown_panel:right())
	self._total_bet:set_y(self._betting_panel:bottom() + h + 16)
	self:set_update_values(preferred_card, secured_cards, increase_infamous, false, false)
end

function MenuNodeCrimenetCasinoGui:set_update_values(preferred_card, secured_cards, increase_infamous, infamous_enabled, safecards_enabled)
	local breakdown_titles = managers.localization:to_upper_text("menu_casino_cost_fee") .. ":"
	local breakdown_costs = managers.experience:cash_string(managers.money:get_cost_of_casino_entrance())
	if preferred_card ~= "none" then
		breakdown_titles = breakdown_titles .. "\n" .. managers.localization:to_upper_text("menu_casino_option_prefer_title") .. ":"
		breakdown_costs = breakdown_costs .. "\n" .. managers.experience:cash_string(tweak_data:get_value("casino", "prefer_cost"))
	end
	if increase_infamous then
		breakdown_titles = breakdown_titles .. "\n" .. managers.localization:to_upper_text("menu_casino_option_infamous_title") .. ":"
		breakdown_costs = breakdown_costs .. "\n" .. managers.experience:cash_string(tweak_data:get_value("casino", "infamous_cost"))
	end
	if 0 < secured_cards then
		breakdown_titles = breakdown_titles .. "\n" .. managers.localization:to_upper_text("menu_casino_option_safecard_title") .. ":"
		for i = 1, secured_cards do
			breakdown_costs = breakdown_costs .. "\n" .. managers.experience:cash_string(tweak_data:get_value("casino", "secure_card_cost", i))
		end
	end
	self._breakdown_titles:set_text(breakdown_titles)
	self._breakdown_costs:set_text(breakdown_costs)
	local text_string = managers.localization:to_upper_text("menu_casino_total_bet", {
		casino_bet = managers.experience:cash_string(managers.money:get_cost_of_casino_fee(secured_cards, increase_infamous, preferred_card))
	})
	self._total_bet:set_text(text_string)
	local nbr_types = 0
	for _, card in pairs(self._stats_cards) do
		for _, item in pairs(self._stat_values[card]) do
			item:set_alpha((secured_cards == 0 or preferred_card == "none") and 1 or 0.5)
		end
		nbr_types = nbr_types + ((0 < self._base_chances[card] or card == preferred_card) and 1 or 0)
	end
	if preferred_card == "none" then
		for _, card in pairs(self._stats_cards) do
			self._stat_values[card].bets:set_text("")
			self._stat_values[card].total:set_text(string.format("%.1f", self._base_chances[card]) .. "%")
		end
		self:_set_cards(0)
	elseif 1 < nbr_types then
		local secured_value = 100 * secured_cards
		local preferred_chance = tweak_data:get_value("casino", "prefer_chance") * 100 * (3 - secured_cards)
		local preferred_left = preferred_chance / (nbr_types - 1)
		for _, card in pairs(self._stats_cards) do
			local non_secured_value = self._base_chances[card] * (3 - secured_cards)
			if preferred_card ~= "none" then
				non_secured_value = non_secured_value + (card == preferred_card and preferred_chance or -preferred_left)
				if non_secured_value < 0 then
					non_secured_value = 0
				end
			end
			local value = (non_secured_value + (card == preferred_card and secured_value or 0)) / 3 - self._base_chances[card]
			value = self:_round_value(value)
			self._stat_values[card].bets:set_text(value == 0 and "" or (0 < value and "+" .. string.format("%.1f", value) or string.format("%.1f", value)) .. "%")
			self._stat_values[card].total:set_text(string.format("%.1f", value + self._base_chances[card]) .. "%")
			if card == preferred_card then
				for _, item in pairs(self._stat_values[card]) do
					item:set_alpha(1)
				end
			end
		end
		self:_set_cards(secured_cards, 0 < secured_cards and self._betting_carddeck[preferred_card])
	end
	local base_value = self._infamous_chance.value_base + self._infamous_chance.value_skill
	local bets_value = increase_infamous and self:_round_value(base_value * tweak_data:get_value("casino", "infamous_chance") - base_value) or 0
	self._infamous_values.bets:set_text(increase_infamous and "+" .. string.format("%.1f", bets_value) .. "%" or "")
	self._infamous_values.total:set_text(string.format("%.1f", base_value + bets_value) .. "%")
	self._betting_titles.safecards:set_alpha(safecards_enabled and 1 or 0.5)
	self._betting_titles.infamous:set_alpha(infamous_enabled and 1 or 0.5)
end

function MenuNodeCrimenetCasinoGui:set_offshore_text()
	self._offshore_text:set_text(managers.localization:to_upper_text("menu_offshore_account") .. ": " .. managers.experience:cash_string(managers.money:offshore()))
end
