CrimeSpreeResultTabItem = CrimeSpreeResultTabItem or class(StatsTabItem)
local padding = 10

function CrimeSpreeResultTabItem:init(panel, tab_panel, text, i)
	self._main_panel = panel
	self._tab_panel = tab_panel
	self._panel = self._main_panel:panel({
		h = self._main_panel:h() - 70
	})
	self._index = i
	local prev_item_title_text = tab_panel:child("tab_text_" .. tostring(i - 1))
	local offset = prev_item_title_text and prev_item_title_text:right() or 0
	self._tab_text = tab_panel:text({
		name = "tab_text_" .. tostring(self._index),
		text = text,
		h = 32,
		x = offset + 5,
		align = "center",
		vertical = "center",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = tweak_data.screen_colors.button_stage_3,
		layer = 1,
		blend_mode = "add"
	})
	local x, y, w, h = self._tab_text:text_rect()
	self._tab_text:set_size(w + 15, h + 10)
	self._select_rect = tab_panel:bitmap({
		name = "tab_select_rect_" .. tostring(self._index),
		texture = "guis/textures/pd2/shared_tab_box",
		layer = 0,
		color = tweak_data.screen_colors.text,
		visible = false
	})
	self._select_rect:set_shape(self._tab_text:shape())
	self._panel:set_top(self._tab_text:bottom() - 2)
	self._panel:grow(0, -self._panel:y())
	self:deselect()
	self:_setup()
end

function CrimeSpreeResultTabItem:_setup()
	self._cs_panel = self._panel:panel({
		w = self._panel:w() - padding * 2,
		h = self._panel:h() - padding * 2,
		x = padding,
		y = padding
	})
	local total_w = 0.75
	self:_create_level(total_w)
	self:_create_rewards(total_w)
	self:_create_timeline(1)
end

function CrimeSpreeResultTabItem:success()
	return managers.job:stage_success() and not managers.crime_spree:has_failed()
end

function CrimeSpreeResultTabItem:_create_level(total_w)
	self._level_panel = self._cs_panel:panel({})
	local level_gain = managers.crime_spree:mission_completion_gain()
	local gain_x = self._level_panel:w() * (1 - total_w) * 0.5
	local gain_y = self._level_panel:h() * 0.25
	local gain_text = "+" .. managers.localization:text("menu_cs_level", {
		level = managers.experience:cash_string(0, "")
	})
	local gain_color = self:success() and tweak_data.screen_colors.crime_spree_risk or tweak_data.screen_colors.important_1
	if not self:success() then
		gain_text = managers.localization:get_default_macro("BTN_SKULL")
	end
	local gain = self._level_panel:text({
		name = "gain",
		text = gain_text,
		w = 200,
		h = tweak_data.menu.pd2_large_font_size,
		align = "center",
		vertical = "center",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = gain_color,
		layer = 10,
		blend_mode = "add",
		alpha = 0
	})
	gain:set_center_x(gain_x)
	gain:set_center_y(gain_y)
	self._levels = {
		gain = gain,
		bonuses = {}
	}
	local bonus_i = 0
	
	local function add_bonus(text, level, color)
		local font = tweak_data.menu.pd2_small_font
		local font_size = tweak_data.menu.pd2_small_font_size
		local bonus = self._level_panel:text({
			name = "bonus" .. tostring(bonus_i),
			text = text or "",
			h = font_size,
			align = "center",
			vertical = "center",
			font_size = font_size,
			font = font,
			color = color or tweak_data.screen_colors.crime_spree_risk,
			layer = 10,
			blend_mode = "add",
			alpha = 0
		})
		self:make_fine_text(bonus)
		bonus:set_center_x(gain_x)
		bonus:set_top(gain:bottom() + 10)
		local bonus_amt
		if level ~= nil then
			bonus_amt = self._level_panel:text({
				name = "amount" .. tostring(bonus_i),
				text = "+" .. managers.localization:text("menu_cs_level", {
					level = level or 0
				}),
				w = 200,
				h = font_size,
				align = "center",
				vertical = "center",
				font_size = font_size,
				font = font,
				color = color or tweak_data.screen_colors.crime_spree_risk,
				layer = 10,
				blend_mode = "add",
				alpha = 0
			})
			bonus_amt:set_center_x(gain_x)
			bonus_amt:set_top(bonus:bottom())
		end
		table.insert(self._levels.bonuses, {
			bonus,
			bonus_amt,
			level
		})
		bonus_i = bonus_i + 1
	end
	
	if not self:success() then
		add_bonus(managers.localization:text("menu_cs_mission_failed"), nil, tweak_data.screen_colors.important_1)
	end
	if 0 < managers.crime_spree:catchup_bonus() and self:success() then
		add_bonus(managers.localization:text("menu_cs_catchup_bonus"), managers.crime_spree:catchup_bonus(), tweak_data.screen_colors.heat_warm_color)
	end
	if 0 < level_gain and self:success() then
		add_bonus(managers.localization:text("menu_cs_mission_complete"), level_gain)
	end
end

function CrimeSpreeResultTabItem:_create_timeline(total_w)
	self._timeline_panel = self._cs_panel:panel({
		h = self._cs_panel:h() * 0.5,
		y = self._cs_panel:h() * 0.5
	})
	local start_level = self:success() and managers.crime_spree:mission_start_spree_level() or managers.crime_spree:spree_level()
	local modifier_levels = {}
	local max_step = 0
	for _, step in pairs(tweak_data.crime_spree.modifier_levels) do
		if step > max_step then
			max_step = step
		end
	end
	for category, step in pairs(tweak_data.crime_spree.modifier_levels) do
		local count = managers.crime_spree:modifiers_to_select(category)
		for i = 0, math.min(count, math.floor(max_step / step) - 1) do
			local level = managers.crime_spree:next_modifier_level(category, start_level, i)
			if level then
				table.insert(modifier_levels, level)
			end
		end
	end
	local timeline_w = self._timeline_panel:w() * total_w - padding * 2
	local timeline_h = 24
	local timeline_x = self._timeline_panel:w() * (1 - total_w) + padding
	local timeline_y = self._timeline_panel:h() * 0.5
	local edge_padding = 48
	local timeline_zero = timeline_x + edge_padding
	local timeline_max = timeline_x + timeline_w - edge_padding
	local end_val = managers.crime_spree:spree_level()
	for _, level in ipairs(modifier_levels) do
		if level > end_val then
			end_val = level
		end
	end
	local real_w = timeline_max - timeline_zero
	local bg_rect = self._timeline_panel:rect({
		x = timeline_x,
		y = timeline_y,
		w = timeline_w,
		h = timeline_h,
		color = Color.black,
		alpha = 0.4,
		layer = 10
	})
	local start_cap_rect = self._timeline_panel:rect({
		x = timeline_x,
		y = timeline_y,
		w = edge_padding,
		h = timeline_h,
		color = tweak_data.screen_colors.crime_spree_risk,
		layer = 11
	})
	local fg_rect = self._timeline_panel:rect({
		x = timeline_zero,
		y = timeline_y,
		w = real_w * 0,
		h = timeline_h,
		color = tweak_data.screen_colors.crime_spree_risk,
		layer = 11
	})
	local current_level_ticket = self._timeline_panel:text({
		name = "current_level_ticket",
		text = managers.localization:get_default_macro("BTN_SPREE_TICKET"),
		h = 32,
		align = "center",
		vertical = "center",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = tweak_data.screen_colors.crime_spree_risk,
		layer = 12,
		blend_mode = "add"
	})
	self:make_fine_text(current_level_ticket)
	current_level_ticket:set_center_x(timeline_zero + real_w * 0)
	current_level_ticket:set_bottom(timeline_y)
	local current_level = self._timeline_panel:text({
		name = "current_level",
		text = managers.experience:cash_string(start_level, ""),
		h = 32,
		align = "center",
		vertical = "center",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = tweak_data.screen_colors.crime_spree_risk,
		layer = 12,
		blend_mode = "add"
	})
	self:make_fine_text(current_level)
	current_level:set_right(current_level_ticket:left() - 1)
	current_level:set_bottom(timeline_y)
	local marker_i = 1
	local level_gap = 5
	local used_levels = {}
	
	local function add_modifier_marker(level, text)
		local p = 1 / ((end_val - start_level) / (level - start_level))
		if level == start_level then
			p = 0
		end
		local cx = timeline_zero + real_w * p
		local cy = timeline_y + timeline_h + 3
		local marker_w = 3
		local ticket = self._timeline_panel:text({
			name = "ticket" .. tostring(marker_i),
			text = managers.localization:get_default_macro("BTN_SPREE_TICKET"),
			h = 32,
			align = "center",
			vertical = "center",
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = Color.white,
			alpha = 0.7,
			layer = 11,
			blend_mode = "add"
		})
		self:make_fine_text(ticket)
		ticket:set_center_x(cx + math.floor(marker_w * 0.5))
		ticket:set_top(cy)
		local marker = self._timeline_panel:text({
			name = "marker" .. tostring(marker_i),
			text = text,
			h = 32,
			align = "center",
			vertical = "center",
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = Color.white,
			alpha = 0.7,
			layer = 11,
			blend_mode = "add"
		})
		self:make_fine_text(marker)
		marker:set_right(ticket:left() - 1)
		marker:set_top(cy)
		local marker_line = self._timeline_panel:rect({
			y = timeline_y,
			w = marker_w,
			h = timeline_h,
			color = Color.black,
			alpha = 0.4,
			layer = 11
		})
		marker_line:set_x(cx - math.floor(marker_w * 0.5))
		for i = level - level_gap, level + level_gap do
			used_levels[i] = true
		end
		marker_i = marker_i + 1
		return {ticket, marker}
	end
	
	local markers = {}
	for _, level in ipairs(modifier_levels) do
		local marker = add_modifier_marker(level, managers.experience:cash_string(level, ""))
		table.insert(markers, {level, marker})
	end
	self._timeline = {
		width = real_w,
		end_val = end_val,
		bar = fg_rect,
		level_ticket = current_level_ticket,
		level_text = current_level,
		markers = markers
	}
end

function CrimeSpreeResultTabItem:_create_rewards(total_w)
	self._reward_panel = self._cs_panel:panel({
		x = self._cs_panel:w() * (1 - total_w),
		y = padding,
		w = self._cs_panel:w() * total_w - padding * 2,
		h = self._cs_panel:h() * 0.5
	})
	local w = self._reward_panel:w() / #tweak_data.crime_spree.rewards
	local create_card = function(idx, panel, icon, rotation)
		local scale = 0.65
		if idx == 1 then
		end
		local texture, rect, coords = tweak_data.hud_icons:get_icon_data(icon or "downcard_overkill_deck" or "downcard_overkill_deck")
		local upcard = panel:bitmap({
			name = "upcard",
			texture = texture,
			w = math.round(0.7111111 * panel:h() * scale),
			h = panel:h() * scale,
			layer = 20 - idx,
			halign = "scale",
			valign = "scale"
		})
		upcard:set_center_x(panel:w() * 0.5)
		upcard:set_rotation(rotation)
		if coords then
			local tl = Vector3(coords[1][1], coords[1][2], 0)
			local tr = Vector3(coords[2][1], coords[2][2], 0)
			local bl = Vector3(coords[3][1], coords[3][2], 0)
			local br = Vector3(coords[4][1], coords[4][2], 0)
			upcard:set_texture_coordinates(tl, tr, bl, br)
		else
			upcard:set_texture_rect(unpack(rect))
		end
		return upcard
	end
	self._rewards = {}
	local count = 0
	for i, data in ipairs(tweak_data.crime_spree.rewards) do
		local amount = managers.crime_spree:get_reward_amount(data.id)
		if 0 < amount then
			local cards = {}
			local panel = self._reward_panel:panel({
				w = w,
				x = count * w,
				alpha = 0
			})
			local first_card_panel = self._reward_panel:panel({
				w = w,
				x = count * w
			})
			local card
			local rotation = math.rand(-10, 10)
			local num_cards = 1
			for i = 1, num_cards do
				card = create_card(i, i == 1 and first_card_panel or panel, data.icon, rotation)
				card:hide()
				table.insert(cards, card)
			end
			local reward_amount = panel:text({
				name = "reward" .. tostring(i),
				text = managers.experience:cash_string(amount, data.cash_string or ""),
				w = panel:w(),
				h = 32,
				align = "center",
				vertical = "center",
				font_size = tweak_data.menu.pd2_small_font_size,
				font = tweak_data.menu.pd2_small_font,
				color = Color.white,
				layer = 11,
				wrap = true,
				word_wrap = true,
				blend_mode = "add"
			})
			reward_amount:set_top(card:bottom() + padding)
			local x, y, w, h = reward_amount:text_rect()
			reward_amount:set_h(h)
			managers.crime_spree:flush_reward_amount(data.id)
			table.insert(self._rewards, {
				cards = cards,
				first_card_panel = first_card_panel,
				panel = panel
			})
			count = count + 1
		end
	end
end

function CrimeSpreeResultTabItem:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
	return x, y, w, h
end

function CrimeSpreeResultTabItem:set_stats(stats_data)
end

function CrimeSpreeResultTabItem:feed_statistics(stats_data)
end

CrimeSpreeResultTabItem.stages = {
	{
		delay = 1,
		func = "_update_gain_calculate"
	},
	{
		delay = 1,
		func = "_update_level_gain"
	},
	{
		delay = 0.5,
		func = "_update_reward_gain"
	}
}

function CrimeSpreeResultTabItem:_advance_stage(delay)
	local idx = (self._update and self._update.idx or 0) + 1
	if not CrimeSpreeResultTabItem.stages[idx] then
		self._update = {done = true}
		return
	end
	self._update = {
		idx = idx,
		t = delay or CrimeSpreeResultTabItem.stages[idx].delay,
		func = CrimeSpreeResultTabItem.stages[idx].func
	}
end

function CrimeSpreeResultTabItem:update(t, dt)
	if not self._update then
		self:_advance_stage()
	end
	if self._update.done then
		return
	end
	self._update.t = self._update.t - dt
	if self._update.t <= 0 then
		self[self._update.func](self, t, dt)
	end
end

function CrimeSpreeResultTabItem.animate_modifier_unlock(o)
	over(0.6, function(p)
		o:set_alpha(math.lerp(0.4, 1, p * 2))
	end)
end

function CrimeSpreeResultTabItem:fade_in(element, duration, delay)
	if delay then
		wait(delay)
	end
	over(duration, function(p)
		element:set_alpha(math.lerp(0, 1, p))
	end)
end

function CrimeSpreeResultTabItem:fade_out(element, duration, delay)
	if delay then
		wait(delay)
	end
	over(duration, function(p)
		element:set_alpha(math.lerp(1, 0, p))
	end)
end

function CrimeSpreeResultTabItem:count_text(element, cash_string, start_val, end_val, duration, delay)
	if delay then
		wait(delay)
	end
	local v = start_val
	managers.menu_component:post_event("count_1")
	over(duration, function(p)
		v = math.lerp(start_val, end_val, p)
		element:set_text(managers.localization:text("menu_cs_level", {
			level = managers.experience:cash_string(v, cash_string)
		}))
	end)
	managers.menu_component:post_event("count_1_finished")
end

function CrimeSpreeResultTabItem:_update_gain_calculate(t, dt)
	local t = 0
	local fade_t = 0.5
	local count_t = 1.5
	local count_bonus_t = 0.75
	local gain_amt = 0
	self._levels.gain:animate(callback(self, self, "fade_in"), 0.5, t)
	t = t + 0.5
	for i, bonus in ipairs(self._levels.bonuses) do
		bonus[1]:animate(callback(self, self, "fade_in"), fade_t, t)
		t = t + 0.25
		if bonus[2] then
			bonus[2]:animate(callback(self, self, "fade_in"), fade_t, t)
			t = t + fade_t + 0.5
			self._levels.gain:animate(callback(self, self, "count_text"), "+", gain_amt, gain_amt + bonus[3], count_bonus_t, t)
			gain_amt = gain_amt + bonus[3]
		end
		t = t + count_bonus_t + 1
		if self:success() then
			if i ~= #self._levels.bonuses then
				bonus[1]:animate(callback(self, self, "fade_out"), fade_t * 0.66, t)
			end
			if bonus[2] then
				bonus[2]:animate(callback(self, self, "fade_out"), fade_t * 0.66, t)
			end
			t = t + 0.4
		end
	end
	self:_advance_stage(t)
end

function CrimeSpreeResultTabItem:_update_level_gain(t, dt)
	if not self:success() then
		self:_advance_stage()
		return
	end
	if self._update._wt then
		self._update._wt = self._update._wt - dt
		if self._update._wt <= 0 then
			self._update._wt = nil
		end
		return
	end
	local duration = 2
	self._update._t = (self._update._t or 0) + dt
	managers.menu:post_event("count_1")
	local s = managers.crime_spree:mission_start_spree_level()
	local p = 1 / ((self._timeline.end_val - s) / (managers.crime_spree:spree_level() - s))
	local target_w = self._timeline.width * p * (self._update._t / duration)
	self._timeline.bar:set_w(target_w)
	local lp = math.floor(managers.crime_spree:mission_start_spree_level() + (managers.crime_spree:spree_level() - managers.crime_spree:mission_start_spree_level()) * (self._update._t / duration))
	self._timeline.level_text:set_text(managers.experience:cash_string(lp, ""))
	self:make_fine_text(self._timeline.level_text)
	self._timeline.level_ticket:set_center_x(self._timeline.bar:x() + target_w)
	self._timeline.level_text:set_right(self._timeline.level_ticket:left() - 1)
	for i, data in ipairs(self._timeline.markers) do
		if lp >= data[1] and not data[3] then
			data[2][1]:animate(CrimeSpreeResultTabItem.animate_modifier_unlock)
			data[2][2]:animate(CrimeSpreeResultTabItem.animate_modifier_unlock)
			data[3] = true
			managers.menu:post_event("count_1_finished")
			managers.menu_component:post_event("stinger_new_weapon")
			self._update._wt = 1.25
		end
	end
	if duration <= self._update._t then
		managers.menu:post_event("count_1_finished")
		self._update._t = 0
		self:_advance_stage()
	end
end

function CrimeSpreeResultTabItem.animate_card_panel(o, reward_num)
	wait(reward_num * 0.5)
	over(0.5, function(p)
		o:set_alpha(math.lerp(0, 1, p))
	end)
end

function CrimeSpreeResultTabItem.flip_card(card, reward_num)
	wait(reward_num * 0.5)
	local start_rot = card:rotation()
	local start_w = card:w()
	local cx, cy = card:center()
	local start_rotation = card:rotation()
	local end_rotation = start_rotation * -1
	local diff = end_rotation - start_rotation
	card:set_valign("scale")
	card:set_halign("scale")
	card:show()
	card:set_w(0)
	managers.menu_component:post_event("loot_flip_card")
	over(0.25, function(p)
		card:set_rotation(start_rotation + math.sin(p * 45 + 45) * diff)
		if card:rotation() == 0 then
			card:set_rotation(360)
		end
		card:set_w(start_w * math.sin(p * 90))
		card:set_center(cx, cy)
	end)
end

function CrimeSpreeResultTabItem.animate_card(o, reward_num, card_idx)
	wait(reward_num * 0.5 + 0.5)
	o:show()
	over(0.25, function(p)
		o:set_rotation(o:rotation() + 0.375 * card_idx * (1 - p * p))
	end)
end

function CrimeSpreeResultTabItem:_update_reward_gain(t, dt)
	if not self:success() then
		self:_advance_stage()
		return
	end
	for reward_num, data in ipairs(self._rewards) do
		data.panel:animate(CrimeSpreeResultTabItem.animate_card_panel, reward_num)
		for idx, card in ipairs(data.cards or {}) do
			if idx == 1 then
				card:animate(CrimeSpreeResultTabItem.flip_card, reward_num)
			else
				card:animate(CrimeSpreeResultTabItem.animate_card, reward_num, idx)
			end
		end
	end
	self:_advance_stage()
end
