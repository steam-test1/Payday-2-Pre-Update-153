StatsTabItem = StatsTabItem or class()

function StatsTabItem:init(panel, text, i)
	self._main_panel = panel
	self._panel = self._main_panel:panel({
		h = self._main_panel:h() - 70
	})
	self._index = i
	local prev_item_title_text = self._main_panel:child("tab_text_" .. tostring(i - 1))
	local offset = prev_item_title_text and prev_item_title_text:right() or 0
	self._tab_text = self._main_panel:text({
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
	self._select_rect = self._main_panel:bitmap({
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
end

function StatsTabItem:reduce_to_small_font()
	self._tab_text:set_font(tweak_data.menu.pd2_small_font_id)
	self._tab_text:set_font_size(tweak_data.menu.pd2_small_font_size)
	local prev_item_title_text = self._main_panel:child("tab_text_" .. tostring(self._index - 1))
	local offset = prev_item_title_text and prev_item_title_text:right() or 0
	local x, y, w, h = self._tab_text:text_rect()
	self._tab_text:set_size(w + 15, h + 10)
	self._tab_text:set_x(offset + 5)
	self._select_rect:set_shape(self._tab_text:shape())
	self._panel:set_top(self._tab_text:bottom() - 2)
	self._panel:set_h(self._main_panel:h() - 70)
	self._panel:grow(0, -self._panel:y())
end

function StatsTabItem:show()
	self._panel:show()
end

function StatsTabItem:hide()
	self._panel:hide()
end

function StatsTabItem:panel()
	return self._panel
end

function StatsTabItem:index()
	return self._index
end

function StatsTabItem:select()
	self:show()
	if self._tab_text and alive(self._tab_text) then
		self._tab_text:set_color(tweak_data.screen_colors.button_stage_1)
		self._tab_text:set_blend_mode("normal")
		self._select_rect:show()
	end
	self._selected = true
end

function StatsTabItem:deselect()
	self:hide()
	if self._tab_text and alive(self._tab_text) then
		self._tab_text:set_color(tweak_data.screen_colors.button_stage_3)
		self._tab_text:set_blend_mode("add")
		self._select_rect:hide()
	end
	self._selected = false
end

function StatsTabItem:set_stats(stats_data)
	self._stats = stats_data or {}
	local prev_stat_panel
	local widest_text = 0
	for i, stat in ipairs(self._stats) do
		local new_stat_panel = self._panel:panel({
			name = tostring(stat),
			h = tweak_data.menu.pd2_medium_font_size,
			y = 10
		})
		local desc_text = new_stat_panel:text({
			name = "desc",
			text = managers.localization:to_upper_text("victory_" .. stat),
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.screen_colors.text,
			align = "right",
			vertical = "top",
			w = math.round(self._panel:w() / 2) - 5 - 10,
			x = 10,
			wrap = true,
			word_wrap = true
		})
		local stat_text = new_stat_panel:text({
			name = "stat",
			text = "",
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.screen_colors.text,
			align = "left",
			vertical = "top",
			w = math.round(self._panel:w() / 2) - 10,
			x = math.round(self._panel:w() / 2) + 5,
			wrap = true,
			word_wrap = true
		})
		if stat == "stage_cash_summary" then
			desc_text:hide()
			stat_text:set_w(new_stat_panel:w() - 20)
			desc_text:set_font(tweak_data.menu.pd2_medium_font_id)
			stat_text:set_font(tweak_data.menu.pd2_medium_font_id)
			desc_text:set_font_size(tweak_data.menu.pd2_medium_font_size)
			stat_text:set_font_size(tweak_data.menu.pd2_medium_font_size)
			new_stat_panel:set_h(self._panel:h() - new_stat_panel:y() - 10)
			stat_text:set_h(new_stat_panel:h())
			stat_text:set_x(10)
		end
		local _, _, _, dh = desc_text:text_rect()
		local _, _, _, sh = stat_text:text_rect()
		local max_h = math.max(dh, sh)
		desc_text:set_h(max_h)
		stat_text:set_h(max_h)
		new_stat_panel:set_h(max_h)
		if prev_stat_panel then
			new_stat_panel:set_top(prev_stat_panel:bottom())
		end
		prev_stat_panel = new_stat_panel
	end
end

function StatsTabItem:feed_statistics(stats_data)
	local text, stat_text
	for i, stat in ipairs(self._stats) do
		if stats_data[stat] then
			stat_text = self._panel:child(tostring(stat)):child("stat")
			text = stats_data[stat]
			stat_text:set_text(text)
		end
	end
	local desc, stat, prev_stat_panel
	for i, child in ipairs(self._panel:children()) do
		desc = child:child("desc")
		stat = child:child("stat")
		local _, _, _, dh = desc:text_rect()
		local _, _, _, sh = stat:text_rect()
		local max_h = math.max(dh, sh)
		desc:set_h(max_h)
		stat:set_h(max_h)
		child:set_h(max_h)
		if child:name() == "stage_cash_summary" then
			desc:hide()
			stat:set_w(child:w() - 20)
			child:set_h(self._panel:h() - child:y())
			stat:set_h(child:h() - 10)
			stat:set_x(10)
			local text = stat:text()
			local resource_color = tweak_data.screen_colors.friend_color
			local start_ci, end_ci, first_ci
			if resource_color then
				local text_dissected = utf8.characters(text)
				local idsp = Idstring("#")
				start_ci = {}
				end_ci = {}
				first_ci = true
				for i, c in ipairs(text_dissected) do
					if Idstring(c) == idsp then
						local next_c = text_dissected[i + 1]
						if next_c and Idstring(next_c) == idsp then
							if first_ci then
								table.insert(start_ci, i)
							else
								table.insert(end_ci, i)
							end
							first_ci = not first_ci
						end
					end
				end
				if #start_ci ~= #end_ci then
				else
					for i = 1, #start_ci do
						start_ci[i] = start_ci[i] - ((i - 1) * 4 + 1)
						end_ci[i] = end_ci[i] - (i * 4 - 1)
					end
				end
				text = string.gsub(text, "##", "")
			end
			stat:set_text(text)
			if resource_color then
				stat:clear_range_color(1, utf8.len(text))
				if #start_ci ~= #end_ci then
					Application:error("StatsTabItem: Not even amount of ##'s in :set_stats() string!", #start_ci, #end_ci)
				else
					for i = 1, #start_ci do
						stat:set_range_color(start_ci[i], end_ci[i], resource_color)
					end
				end
			end
			local _, _, _, h = stat:text_rect()
			if h > stat:h() then
				stat:set_font(tweak_data.menu.pd2_small_font_id)
				stat:set_font_size(tweak_data.menu.pd2_small_font_size)
			end
		end
		if prev_stat_panel then
			child:set_top(prev_stat_panel:bottom())
		end
		prev_stat_panel = child
	end
end

function StatsTabItem:mouse_moved(x, y)
	if self._selected then
		self._tab_text:set_color(tweak_data.screen_colors.button_stage_1)
	elseif self._tab_text:inside(x, y) then
		if not self._highlighted then
			self._highlighted = true
			managers.menu_component:post_event("highlight")
			self._tab_text:set_color(tweak_data.screen_colors.button_stage_2)
		end
	elseif self._highlighted then
		self._highlighted = false
		self._tab_text:set_color(tweak_data.screen_colors.button_stage_3)
	end
	return self._selected
end

function StatsTabItem:mouse_pressed(button, x, y)
	if button ~= Idstring("0") then
		return false
	end
	if not self._selected and self._tab_text:inside(x, y) then
		managers.menu_component:post_event("menu_enter")
		return true
	end
	return self._selected
end

function StatsTabItem:move_left()
end

function StatsTabItem:move_right()
end

function StatsTabItem:confirm_pressed()
end

function StatsTabItem.animate_select(o)
	local size = o:w()
	local center_x, center_y = o:center()
	if size == 100 then
		return
	end
	over(math.abs(100 - size) / 100, function(p)
		local s = math.lerp(size, 100, p)
		o:set_size(s, s)
		o:set_center(center_x, center_y)
	end)
end

function StatsTabItem.animate_deselect(o)
	local size = o:w()
	local center_x, center_y = o:center()
	if size == 65 then
		return
	end
	over(math.abs(65 - size) / 100, function(p)
		local s = math.lerp(size, 65, p)
		o:set_size(s, s)
		o:set_center(center_x, center_y)
	end)
end

StageEndScreenGui = StageEndScreenGui or class()

function StageEndScreenGui:init(saferect_ws, fullrect_ws, statistics_data)
	self._safe_workspace = saferect_ws
	self._full_workspace = fullrect_ws
	self._fullscreen_panel = self._full_workspace:panel():panel({layer = 1})
	self._panel = self._safe_workspace:panel():panel({
		w = self._safe_workspace:panel():w() / 2 - 10,
		h = self._safe_workspace:panel():h() * 0.5 - 10,
		layer = 6
	})
	self._panel:set_right(self._safe_workspace:panel():w())
	self._panel:set_bottom(self._safe_workspace:panel():h())
	self._continue_button = self._panel:text({
		name = "ready_button",
		text = utf8.to_upper(managers.localization:text("menu_es_calculating_experience", {
			CONTINUE = managers.localization:btn_macro("continue")
		})),
		h = 32,
		align = "right",
		vertical = "center",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.button_stage_3,
		layer = 1
	})
	local _, _, w, h = self._continue_button:text_rect()
	self._continue_button:set_size(w, h)
	self._continue_button:set_bottom(self._panel:h())
	self._continue_button:set_right(self._panel:w())
	self._button_not_clickable = true
	self._continue_button:set_color(tweak_data.screen_colors.item_stage_1)
	local big_text = self._fullscreen_panel:text({
		name = "continue_big_text",
		text = utf8.to_upper(managers.localization:text("menu_es_calculating_experience", {
			CONTINUE = managers.localization:btn_macro("continue")
		})),
		h = 90,
		align = "right",
		vertical = "bottom",
		font_size = tweak_data.menu.pd2_massive_font_size,
		font = tweak_data.menu.pd2_massive_font,
		color = tweak_data.screen_colors.button_stage_3,
		alpha = 0.4
	})
	local x, y = managers.gui_data:safe_to_full_16_9(self._continue_button:world_right(), self._continue_button:world_center_y())
	big_text:set_world_right(x)
	big_text:set_world_center_y(y)
	big_text:move(13, -9)
	if MenuBackdropGUI then
		MenuBackdropGUI.animate_bg_text(self, big_text)
	end
	if not managers.menu:is_pc_controller() then
		local prev_page = self._panel:text({
			name = "tab_text_0",
			y = 0,
			w = 0,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			layer = 2,
			text = managers.localization:get_default_macro("BTN_BOTTOM_L"),
			vertical = "top"
		})
		local _, _, w, h = prev_page:text_rect()
		prev_page:set_size(w, h + 10)
		prev_page:set_left(0)
		self._prev_page = prev_page
	end
	self._items = {}
	local item
	item = StatsTabItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_es_summary")), 1)
	item:set_stats({
		"stage_cash_summary"
	})
	table.insert(self._items, item)
	self._items[1]._panel:set_alpha(0)
	item = StatsTabItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_es_stats_crew")), 2)
	item:set_stats({
		"time_played",
		"most_downs",
		"best_accuracy",
		"best_killer",
		"best_special",
		"group_total_downed",
		"group_hit_accuracy",
		"criminals_finished"
	})
	table.insert(self._items, item)
	item = StatsTabItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_es_stats_personal")), 3)
	item:set_stats({
		"total_downed",
		"hit_accuracy",
		"total_kills",
		"total_specials_kills",
		"total_head_shots",
		"favourite_weapon",
		"civilians_killed_penalty"
	})
	table.insert(self._items, item)
	local max_x = self._panel:w()
	if not managers.menu:is_pc_controller() then
		local next_page = self._panel:text({
			name = "tab_text_" .. tostring(#self._items + 1),
			y = 0,
			w = 0,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			layer = 2,
			text = managers.localization:get_default_macro("BTN_BOTTOM_R"),
			vertical = "top"
		})
		local _, _, w, h = next_page:text_rect()
		next_page:set_size(w, h + 10)
		next_page:set_right(self._panel:w())
		self._next_page = next_page
		max_x = next_page:left() - 5
	end
	if max_x < self._items[#self._items]._tab_text:right() then
		for i, tab in ipairs(self._items) do
			tab:reduce_to_small_font()
		end
	end
	if self._console_subtitle_string_id then
		self:console_subtitle_callback(self._console_subtitle_string_id)
	end
	self:set_tab(1)
	self._items[self._selected_item]:select()
	local box_panel = self._panel:panel()
	box_panel:set_shape(self._items[self._selected_item]._panel:shape())
	BoxGuiObject:new(box_panel, {
		sides = {
			1,
			1,
			2,
			1
		}
	})
	if statistics_data then
		self:feed_statistics(statistics_data)
	end
	self._enabled = true
	if managers.job:stage_success() then
		self._bain_debrief_t = TimerManager:main():time() + 2.5
	end
end

function StageEndScreenGui:hide()
	self._enabled = false
	self._panel:set_alpha(0.5)
	self._fullscreen_panel:set_alpha(0.5)
end

function StageEndScreenGui:show()
	self._enabled = true
	self._panel:set_alpha(1)
	self._fullscreen_panel:set_alpha(1)
end

function StageEndScreenGui:play_bain_debrief()
	local variant = managers.groupai:state():endscreen_variant() or 0
	local level_data = Global.level_data.level_id and tweak_data.levels[Global.level_data.level_id]
	local outro_event = level_data and (variant == 0 and level_data.outro_event or level_data.outro_event[variant])
	Application:debug("StageEndScreenGui:play_bain_debrief()", outro_event)
	if outro_event then
		managers.briefing:post_event(outro_event, {
			show_subtitle = false,
			listener = {
				end_of_event = true,
				clbk = callback(self, self, "bain_debrief_end_callback")
			}
		})
		if managers.menu:is_console() then
			managers.briefing:add_listener({
				marker = true,
				clbk = callback(self, self, "console_subtitle_callback")
			})
		end
	else
		self:bain_debrief_end_callback()
	end
end

function StageEndScreenGui:console_subtitle_callback(event, string_id, duration, cookie)
	if not self._console_subtitle_panel then
		self._console_subtitle_panel = self._safe_workspace:panel():panel()
		self._console_subtitle_panel:set_size(self._panel:x() - 10 - 10, self._panel:h() - 70)
		self._console_subtitle_panel:set_leftbottom(0, self._panel:bottom() - 70)
		self._console_subtitle_panel:text({
			name = "subtitle_text",
			font = tweak_data.menu.pd2_medium_font,
			font_size = tweak_data.menu.pd2_medium_font_size,
			text = "",
			align = "center",
			vertical = "bottom",
			wrap = true,
			word_wrap = true
		})
	end
	if duration then
		local text = self._console_subtitle_panel:child("subtitle_text")
		text:set_text(managers.localization:text(string_id))
		self._console_subtitle_string_id = string_id
		self._console_subtitle_duration = TimerManager:main():time() + duration
	end
end

function StageEndScreenGui:bain_debrief_end_callback()
	self._contact_debrief_t = TimerManager:main():time() + 3.5
end

function StageEndScreenGui:update(t, dt)
	if self._bain_debrief_t and t > self._bain_debrief_t then
		self._bain_debrief_t = nil
		self:play_bain_debrief()
	end
	if self._contact_debrief_t and t > self._contact_debrief_t then
		self._contact_debrief_t = nil
		if managers.job:on_last_stage() then
			local job_data = managers.job:current_job_data()
			if job_data and job_data.debrief_event then
				managers.briefing:post_event(job_data.debrief_event)
				if managers.menu:is_console() then
					managers.briefing:add_listener({
						marker = true,
						clbk = callback(self, self, "console_subtitle_callback")
					})
				end
			end
		end
	end
	if self._console_subtitle_duration and t > self._console_subtitle_duration then
		local text = self._console_subtitle_panel:child("subtitle_text")
		text:set_text("")
		self._console_subtitle_string_id = nil
		self._console_subtitle_duration = nil
	end
end

function StageEndScreenGui:feed_statistics(data)
	data = data or {}
	data.total_objectives = managers.objectives:total_objectives(Global.level_data and Global.level_data.level_id)
	data.completed_ratio = data.success and managers.statistics:started_session_from_beginning() and 100 or data.total_objectives ~= 0 and math.round(managers.statistics:completed_objectives() / data.total_objectives * 100) or 0
	data.completed_objectives = managers.localization:text("menu_completed_objectives_of", {
		COMPLETED = managers.statistics:completed_objectives(),
		TOTAL = data.total_objectives,
		PERCENT = data.completed_ratio
	})
	data.time_played = managers.statistics:session_time_played()
	data.last_completed_challenge = managers.challenges:get_last_comleted_title_text()
	data.total_downed = managers.statistics:total_downed()
	data.favourite_weapon = managers.statistics:session_favourite_weapon()
	data.hit_accuracy = managers.statistics:session_hit_accuracy() .. "%"
	data.total_kills = managers.statistics:session_total_kills()
	data.total_specials_kills = managers.statistics:session_total_specials_kills()
	data.total_head_shots = managers.statistics:session_total_head_shots()
	data.civilians_killed_penalty = managers.statistics:session_total_civilian_kills()
	self._data = data or {}
	for i, item in ipairs(self._items) do
		item:feed_statistics(data)
	end
end

function StageEndScreenGui:show_cash_summary()
	self._items[1]._panel:set_alpha(1)
end

function StageEndScreenGui:set_continue_button_text(text, not_clickable)
	self._continue_button:set_text(text)
	self._fullscreen_panel:child("continue_big_text"):set_text(text)
	self._button_not_clickable = not_clickable
	local _, _, w = self._continue_button:text_rect()
	self._continue_button:set_width(w)
	self._continue_button:set_bottom(self._panel:h())
	self._continue_button:set_right(self._panel:w())
	self._continue_button:set_color(self._button_not_clickable and tweak_data.screen_colors.item_stage_1 or tweak_data.screen_colors.button_stage_3)
end

function StageEndScreenGui:next_tab(no_sound)
	local selected_item = math.min(self._selected_item + 1, #self._items)
	if selected_item == self._selected_item then
		return
	end
	self._items[self._selected_item]:deselect()
	self._selected_item = selected_item
	self._items[self._selected_item]:select()
	if not no_sound then
		managers.menu_component:post_event("highlight")
	end
	if self._prev_page then
		self._prev_page:set_visible(self._selected_item > 1)
	end
	if self._next_page then
		self._next_page:set_visible(self._selected_item < #self._items)
	end
	return self._selected_item
end

function StageEndScreenGui:prev_tab(no_sound)
	local selected_item = math.max(self._selected_item - 1, 1)
	if selected_item == self._selected_item then
		return
	end
	self._items[self._selected_item]:deselect()
	self._selected_item = selected_item
	self._items[self._selected_item]:select()
	if not no_sound then
		managers.menu_component:post_event("highlight")
	end
	if self._prev_page then
		self._prev_page:set_visible(self._selected_item > 1)
	end
	if self._next_page then
		self._next_page:set_visible(self._selected_item < #self._items)
	end
	return self._selected_item
end

function StageEndScreenGui:set_tab(i)
	self._selected_item = i
	if self._prev_page then
		self._prev_page:set_visible(self._selected_item > 1)
	end
	if self._next_page then
		self._next_page:set_visible(self._selected_item < #self._items)
	end
	return self._selected_item
end

function StageEndScreenGui:mouse_pressed(button, x, y)
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	if button == Idstring("mouse wheel down") then
		self:next_page(true)
		return
	elseif button == Idstring("mouse wheel up") then
		self:previous_page(true)
		return
	end
	if button ~= Idstring("0") then
		return
	end
	for index, tab in ipairs(self._items) do
		local pressed = tab:mouse_pressed(button, x, y)
		if pressed == true then
			self._items[self._selected_item]:deselect()
			self._items[index]:select()
			self._selected_item = index
		end
	end
	if not self._button_not_clickable and self._continue_button:inside(x, y) and game_state_machine:current_state()._continue_cb then
		managers.menu_component:post_event("menu_enter")
		game_state_machine:current_state()._continue_cb()
	end
	return self._selected_item
end

function StageEndScreenGui:mouse_moved(x, y)
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	for _, tab in ipairs(self._items) do
		tab:mouse_moved(x, y)
	end
	if self._button_not_clickable then
		self._continue_button:set_color(tweak_data.screen_colors.item_stage_1)
	elseif self._continue_button:inside(x, y) then
		if not self._continue_button_highlighted then
			self._continue_button_highlighted = true
			self._continue_button:set_color(tweak_data.screen_colors.button_stage_2)
			managers.menu_component:post_event("highlight")
		end
	elseif self._continue_button_highlighted then
		self._continue_button_highlighted = false
		self._continue_button:set_color(tweak_data.screen_colors.button_stage_3)
		managers.menu_component:post_event("highlight")
	end
	if managers.hud._hud_stage_endscreen and managers.hud._hud_stage_endscreen._backdrop then
		managers.hud._hud_stage_endscreen._backdrop:mouse_moved(x, y)
	end
end

function StageEndScreenGui:input_focus()
	return self._enabled
end

function StageEndScreenGui:scroll_up()
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	if self._items[self._selected_item] then
		self._items[self._selected_item]:move_right()
	end
end

function StageEndScreenGui:scroll_down()
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	if self._items[self._selected_item] then
		self._items[self._selected_item]:move_left()
	end
end

function StageEndScreenGui:move_up()
end

function StageEndScreenGui:move_down()
end

function StageEndScreenGui:move_left()
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	if self._items[self._selected_item] then
		self._items[self._selected_item]:move_left()
	end
end

function StageEndScreenGui:move_right()
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	if self._items[self._selected_item] then
		self._items[self._selected_item]:move_right()
	end
end

function StageEndScreenGui:confirm_pressed()
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return
	end
	if game_state_machine:current_state()._continue_cb() then
		game_state_machine:current_state()._continue_cb()
		return true
	end
end

function StageEndScreenGui:back_pressed()
	if not (alive(self._panel) and alive(self._fullscreen_panel)) or not self._enabled then
		return false
	end
end

function StageEndScreenGui:accept_input(accept)
	print("StageEndScreenGui:accept_input", accept)
end

function StageEndScreenGui:next_page(no_sound)
	if not self._enabled then
		return
	end
	self:next_tab(no_sound)
end

function StageEndScreenGui:previous_page(no_sound)
	if not self._enabled then
		return
	end
	self:prev_tab(no_sound)
end

function StageEndScreenGui:close()
	if self._panel and alive(self._panel) then
		self._panel:parent():remove(self._panel)
	end
	if self._fullscreen_panel and alive(self._fullscreen_panel) then
		self._fullscreen_panel:parent():remove(self._fullscreen_panel)
	end
	if alive(self._console_subtitle_panel) then
		self._console_subtitle_panel:parent():remove(self._console_subtitle_panel)
	end
end

function StageEndScreenGui:reload()
	self:close()
	StageEndScreenGui.init(self, self._safe_workspace, self._full_workspace, self._data)
end
