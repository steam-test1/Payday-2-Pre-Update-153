CrimeNetContractGui = CrimeNetContractGui or class()

function CrimeNetContractGui:init(ws, fullscreen_ws, node)
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._panel = self._ws:panel():panel({layer = 51})
	self._fullscreen_panel = self._fullscreen_ws:panel():panel({layer = 50})
	self._fullscreen_panel:rect({
		color = Color.black,
		alpha = 0.75,
		layer = 0
	})
	self._node = node
	local job_data = self._node:parameters().menu_component_data
	self._customizable = job_data.customize_contract or false
	local is_win_32 = SystemInfo:platform() == Idstring("WIN32")
	local width = 900
	local height = 580
	if not is_win_32 then
		width = 850
		height = 500
	end
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
	self._contact_text_header = self._panel:text({
		text = " ",
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text
	})
	do
		local x, y, w, h = self._contact_text_header:text_rect()
		self._contact_text_header:set_size(width, h)
		self._contact_text_header:set_center_x(self._panel:w() * 0.5)
	end
	self._contract_panel = self._panel:panel({
		h = height,
		w = width,
		layer = 1,
		x = self._contact_text_header:x(),
		y = self._contact_text_header:bottom()
	})
	self._contract_panel:set_center_y(self._panel:h() * 0.5)
	self._contact_text_header:set_bottom(self._contract_panel:top())
	if not job_data.job_id then
		local bottom = self._contract_panel:bottom()
		self._contract_panel:set_h(160)
		self._contract_panel:set_bottom(bottom)
		self._contact_text_header:set_bottom(self._contract_panel:top())
		local host_name = job_data.host_name or ""
		local num_players = job_data.num_plrs or 1
		local server_text = managers.localization:to_upper_text("menu_lobby_server_title") .. " " .. host_name
		local players_text = managers.localization:to_upper_text("menu_players_online", {
			COUNT = tostring(num_players)
		})
		self._contact_text_header:set_text(server_text .. "\n" .. players_text)
		self._contact_text_header:set_font(tweak_data.menu.pd2_medium_font_id)
		self._contact_text_header:set_font_size(tweak_data.menu.pd2_medium_font_size)
		local x, y, w, h = self._contact_text_header:text_rect()
		self._contact_text_header:set_size(width, h)
		self._contact_text_header:set_top(self._contract_panel:top())
		self._contact_text_header:move(10, 10)
		BoxGuiObject:new(self._contract_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		self._step = 1
		self._steps = {}
		return
	end
	BoxGuiObject:new(self._contract_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	job_data.job_id = job_data.job_id or "ukrainian_job"
	local narrative = tweak_data.narrative.jobs[job_data.job_id]
	local w = is_win_32 and 389 or 356
	local text_w = width - w
	local font_size = tweak_data.menu.pd2_small_font_size
	local font = tweak_data.menu.pd2_small_font
	local risk_color = tweak_data.screen_colors.risk
	self._contact_text_header:set_text(managers.localization:to_upper_text("menu_cn_contract_title", {
		job = managers.localization:text(narrative.name_id)
	}))
	local contract_text = self._contract_panel:text({
		text = managers.localization:text(narrative.briefing_id),
		align = "left",
		vertical = "top",
		w = text_w,
		font_size = font_size,
		font = font,
		color = tweak_data.screen_colors.text,
		wrap = true,
		wrap_word = true,
		x = 10,
		y = 10
	})
	do
		local _, _, _, h = contract_text:text_rect()
		local scale = 1
		if h + contract_text:top() > math.round(self._contract_panel:h() * 0.5) - font_size then
			scale = (math.round(self._contract_panel:h() * 0.5) - font_size) / (h + contract_text:top())
		end
		contract_text:set_font_size(font_size * scale)
	end
	local contact_w = width - (text_w + 20) - 10
	local contact_h = contact_w / 1.7777778
	local contact_panel = self._contract_panel:panel({
		w = contact_w,
		h = contact_h,
		x = text_w + 20,
		y = 10
	})
	local contact_image = contact_panel:rect({
		color = Color(0.3, 0, 0, 0)
	})
	local crimenet_videos = narrative.crimenet_videos
	if crimenet_videos then
		local variant = math.random(#crimenet_videos)
		contact_panel:video({
			video = "movies/" .. crimenet_videos[variant],
			width = contact_panel:w(),
			height = contact_panel:h(),
			blend_mode = "add",
			loop = true,
			color = tweak_data.screen_colors.button_stage_2
		})
	end
	local contact_text = self._contract_panel:text({
		text = managers.localization:to_upper_text(tweak_data.narrative.contacts[narrative.contact].name_id),
		font_size = font_size,
		font = font,
		color = tweak_data.screen_colors.text
	})
	do
		local x, y, w, h = contact_text:text_rect()
		contact_text:set_size(w, h)
	end
	contact_text:set_position(contact_panel:left(), contact_panel:bottom() + 5)
	BoxGuiObject:new(contact_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local pro_warning_text = self._contract_panel:text({
		name = "pro_warning_text",
		text = managers.localization:to_upper_text("menu_pro_warning"),
		font = font,
		font_size = font_size,
		color = tweak_data.screen_colors.pro_color,
		align = "left",
		vertical = "top",
		wrap = true,
		word_wrap = true,
		h = 128,
		x = 10,
		w = text_w
	})
	self:make_fine_text(pro_warning_text)
	pro_warning_text:set_h(pro_warning_text:h() + 10)
	pro_warning_text:set_bottom(math.round(self._contract_panel:h() * 0.5) + 64)
	pro_warning_text:set_visible(narrative.professional)
	local risk_title = self._contract_panel:text({
		font = font,
		font_size = font_size,
		text = managers.localization:to_upper_text("menu_risk"),
		color = risk_color,
		x = 10
	})
	self:make_fine_text(risk_title)
	risk_title:set_top(math.round(self._contract_panel:h() * 0.5) + 64)
	local menu_risk_id = "menu_risk_pd"
	if job_data.difficulty == "hard" then
		menu_risk_id = "menu_risk_swat"
	elseif job_data.difficulty == "overkill" then
		menu_risk_id = "menu_risk_fbi"
	elseif job_data.difficulty == "overkill_145" then
		menu_risk_id = "menu_risk_special"
	end
	local risk_text = self._contract_panel:text({
		name = "risk_text",
		w = text_w,
		text = managers.localization:to_upper_text(menu_risk_id) .. " ",
		font = font,
		font_size = font_size,
		color = risk_color,
		align = "left",
		vertical = "top",
		wrap = true,
		word_wrap = true,
		x = 10
	})
	self:make_fine_text(risk_text)
	risk_text:set_h(risk_text:h() + 10)
	risk_text:set_top(math.round(risk_title:bottom() + 10))
	risk_text:hide()
	local potential_rewards_title = self._contract_panel:text({
		font = font,
		font_size = font_size,
		text = managers.localization:to_upper_text("menu_potential_rewards"),
		color = tweak_data.screen_colors.text,
		x = 10
	})
	self:make_fine_text(potential_rewards_title)
	potential_rewards_title:set_top(math.round(risk_text:bottom() + 4))
	local paygrade_title = self._contract_panel:text({
		font = font,
		font_size = font_size,
		text = managers.localization:to_upper_text("cn_menu_contract_paygrade_header"),
		color = tweak_data.screen_colors.text,
		x = 10
	})
	self:make_fine_text(paygrade_title)
	paygrade_title:set_top(math.round(potential_rewards_title:bottom() + 4))
	local experience_title = self._contract_panel:text({
		font = font,
		font_size = font_size,
		text = managers.localization:to_upper_text("menu_experience"),
		color = tweak_data.screen_colors.text,
		x = 10
	})
	self:make_fine_text(experience_title)
	experience_title:set_top(math.round(paygrade_title:bottom()))
	local sx = math.max(paygrade_title:w(), experience_title:w())
	sx = sx + 24
	local plvl = managers.experience:current_level()
	local player_stars = math.max(math.ceil(plvl / 10), 1)
	local job_stars = math.ceil(narrative.jc / 10)
	local difficulty_stars = job_data.difficulty_id - 2
	local job_and_difficulty_stars = job_stars + difficulty_stars
	local rsx = risk_title:right() + 12
	for i, name in ipairs({
		"risk_pd",
		"risk_swat",
		"risk_fbi",
		"risk_death_squad"
	}) do
		if i ~= 1 then
			local texture, rect = tweak_data.hud_icons:get_icon_data(name)
			local active = false
			local color = active and i ~= 1 and risk_color or Color.white
			local alpha = active and 1 or 0.25
			local risk = self._contract_panel:bitmap({
				name = name,
				texture = texture,
				texture_rect = rect,
				x = 0,
				y = 0,
				alpha = alpha,
				color = color
			})
			risk:set_x(rsx)
			risk:set_center_y(math.round(risk_title:center_y()))
			rsx = rsx + risk:w() + 12
		end
	end
	local filled_star_rect = {
		0,
		32,
		32,
		32
	}
	local empty_star_rect = {
		32,
		32,
		32,
		32
	}
	local cy = paygrade_title:center_y()
	local texture, rect = tweak_data.hud_icons:get_icon_data("risk_death_squad")
	local level_data = {
		texture = "guis/textures/pd2/mission_briefing/difficulty_icons",
		texture_rect = filled_star_rect,
		w = 20,
		h = 20,
		color = tweak_data.screen_colors.text,
		alpha = 0
	}
	local risk_data = {
		texture = texture,
		texture_rect = rect,
		w = 20,
		h = 20,
		color = tweak_data.screen_colors.text,
		alpha = 0
	}
	local max_stars_text = self._contract_panel:text({
		name = "max_stars_text",
		w = 100,
		h = 20,
		x = 0,
		y = 0,
		color = tweak_data.screen_colors.pro_color,
		visible = false,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		text = managers.localization:to_upper_text("menu_cn_max_jc")
	})
	self:make_fine_text(max_stars_text)
	for i = 1, 10 do
		local is_risk = job_stars < i
		local num_risk = math.max(i - job_stars - 1, 0)
		local star_data = is_risk and risk_data or level_data
		star_data.name = "star" .. tostring(i)
		local star = self._contract_panel:bitmap(star_data)
		star:set_x(math.round(sx + (i - 1) * 22) - num_risk * 3)
		star:set_center_y(math.round(cy) + (is_risk and 1 or 0))
		star:set_y(math.round(star:y()))
		star:set_visible(job_and_difficulty_stars >= i)
	end
	local cy = experience_title:center_y()
	local total_xp, base_xp, risk_xp = managers.experience:get_contract_xp_by_stars(job_stars, difficulty_stars, job_data.professional, #narrative.chain)
	local job_xp = self._contract_panel:text({
		name = "job_xp",
		font = font,
		font_size = font_size,
		text = "0",
		color = tweak_data.screen_colors.text
	})
	self:make_fine_text(job_xp)
	job_xp:set_x(sx)
	job_xp:set_center_y(math.round(cy))
	local add_xp = self._contract_panel:text({
		name = "add_xp",
		font = font,
		font_size = font_size,
		text = "",
		color = risk_color
	})
	add_xp:set_text(" +" .. math.round(0))
	self:make_fine_text(add_xp)
	add_xp:set_x(math.round(job_xp:right()))
	add_xp:set_center_y(math.round(cy))
	local total_payout, stage_payout_table, job_payout_table = managers.money:get_contract_money_by_stars(job_stars, difficulty_stars, #narrative.chain, job_data.job_id)
	local stage_value = stage_payout_table[1]
	local stage_risk_value = stage_payout_table[3]
	local job_value = job_payout_table[1]
	local job_risk_value = job_payout_table[3]
	local total_stage_value = stage_payout_table[2]
	local total_stage_risk_value = stage_payout_table[4]
	local total_job_value = job_payout_table[2]
	local total_job_risk_value = job_payout_table[4]
	local payday_money = math.round(total_payout)
	local payday_text = self._contract_panel:text({
		name = "payday_text",
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		text = managers.localization:to_upper_text("menu_payday", {
			MONEY = managers.experience:cash_string(0)
		}),
		color = tweak_data.screen_colors.text,
		x = 10
	})
	self:make_fine_text(payday_text)
	payday_text:set_bottom(self._contract_panel:h() - 10)
	self._briefing_event = narrative.briefing_event
	if self._briefing_event then
		self._briefing_len_panel = self._contract_panel:panel({
			w = contact_image:w(),
			h = font_size * 2 + 20
		})
		self._briefing_len_panel:rect({
			name = "duration",
			w = 0,
			color = tweak_data.screen_colors.button_stage_3:with_alpha(0.2),
			alpha = 0.6,
			blend_mode = "add",
			halign = "grow",
			valign = "grow"
		})
		self._briefing_len_panel:text({
			name = "text",
			font = font,
			font_size = font_size,
			text = "",
			color = tweak_data.screen_colors.text,
			x = 10,
			y = 10,
			layer = 1,
			blend_mode = "add"
		})
		local button_text = self._briefing_len_panel:text({
			name = "button_text",
			font = font,
			font_size = font_size,
			text = " ",
			color = tweak_data.screen_colors.text,
			x = 10,
			y = 10,
			layer = 1,
			blend_mode = "add"
		})
		local _, _, _, h = button_text:text_rect()
		self._briefing_len_panel:set_h(h * 2 + 20)
		if managers.menu:is_pc_controller() then
			button_text:set_color(tweak_data.screen_colors.button_stage_3)
		end
		BoxGuiObject:new(self._briefing_len_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		self._briefing_len_panel:set_position(contact_text:left(), contact_text:bottom() + 10)
	end
	local days_multiplier = 0
	for i = 1, #narrative.chain do
		local day_mul = narrative.professional and tweak_data:get_value("experience_manager", "pro_day_multiplier", i) or tweak_data:get_value("experience_manager", "day_multiplier", i)
		days_multiplier = days_multiplier + (day_mul - 1)
	end
	days_multiplier = 1 + days_multiplier / #narrative.chain
	local last_day_mul = narrative.professional and tweak_data:get_value("experience_manager", "pro_day_multiplier", #narrative.chain) or tweak_data:get_value("experience_manager", "day_multiplier", #narrative.chain)
	self._data = {}
	self._data.experience = base_xp
	self._data.add_experience = risk_xp
	self._data.num_stages_string = tostring(#narrative.chain) .. " x "
	self._data.payday_money = payday_money
	self._data.counted_payday_money = 0
	self._data.stars = {
		job_and_difficulty_stars = job_and_difficulty_stars,
		job_stars = job_stars,
		difficulty_stars = difficulty_stars
	}
	self._data.gui_objects = {}
	self._data.gui_objects.risk_text = risk_text
	self._data.gui_objects.payday_text = payday_text
	self._data.gui_objects.add_xp = add_xp
	self._data.gui_objects.job_xp = job_xp
	self._data.gui_objects.risks = {
		"risk_pd",
		"risk_swat",
		"risk_fbi",
		"risk_death_squad"
	}
	self._data.gui_objects.num_stars = 10
	self._wait_t = 0
	local next_level_data = managers.experience:next_level_data() or {}
	local gain_xp = self._data.experience + self._data.add_experience
	local at_max_level = managers.experience:current_level() == managers.experience:level_cap()
	local can_lvl_up = not at_max_level and gain_xp >= next_level_data.points - next_level_data.current_points
	if not at_max_level and can_lvl_up then
		local text = managers.localization:to_upper_text("hud_potential_level_up")
		local potential_level_up_text = self._contract_panel:text({
			layer = 3,
			name = "potential_level_up_text",
			blend_mode = "normal",
			visible = false,
			text = text,
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.hud_stats.potential_xp_color
		})
		self:make_fine_text(potential_level_up_text)
		potential_level_up_text:set_left(math.round(add_xp:right() + 4))
		potential_level_up_text:set_top(math.round(add_xp:top()))
		self._data.gui_objects.potential_level_up_text = potential_level_up_text
		self._data.gui_objects.when_to_level_up = next_level_data.points - next_level_data.current_points
	end
	self._step = 1
	self._steps = {
		"set_time",
		"start_sound",
		"count_job_stars",
		"count_difficulty_stars",
		"start_count_payday",
		"count_payday",
		"end_count_payday",
		"free_memory"
	}
	if self._customizable then
		if self._briefing_len_panel then
			self._briefing_len_panel:hide()
		end
		if not is_win_32 then
			contact_panel:hide()
			contact_text:set_top(contact_panel:top())
			contact_text:set_text("")
		end
		local premium_text = self._contract_panel:text({
			name = "premium_text",
			text = "  ",
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.button_stage_3,
			blend_mode = "add",
			wrap = true,
			word_wrap = true
		})
		premium_text:set_top(contact_text:bottom() + 10)
		premium_text:set_left(contact_text:left())
		premium_text:set_w(contact_image:w())
		self._contact_text_header:set_text(managers.localization:to_upper_text("menu_cn_premium_buy_desc") .. ": " .. managers.localization:to_upper_text(narrative.name_id))
		self._step = 1
		self._steps = {
			"set_all",
			"free_memory"
		}
	end
	self._current_job_star = 0
	self._current_difficulty_star = 0
	self._post_event_params = {
		show_subtitle = false,
		listener = {
			clbk = callback(self, self, "sound_event_callback"),
			duration = true,
			end_of_event = true
		}
	}
	managers.menu:active_menu().input:deactivate_controller_mouse()
	self:_rec_round_object(self._panel)
end

function CrimeNetContractGui:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function CrimeNetContractGui:set_time(t, dt)
	self._wait_t = t + 1
	self._step = self._step + 1
end

function CrimeNetContractGui:start_sound(t, dt)
	self:toggle_post_event()
	self._step = self._step + 1
end

function CrimeNetContractGui:count_job_stars(t, dt)
	if self._data.stars.job_stars == 0 then
		self._step = self._step + 1
		return
	end
	self._current_job_star = self._current_job_star + 1
	local stars = self._data.stars.job_stars
	local gui_panel = self._contract_panel
	local xp = math.round(self._data.experience * (self._current_job_star / stars))
	local gui_xp = self._data.gui_objects.job_xp
	local gui_add_xp = self._data.gui_objects.add_xp
	gui_xp:set_text(managers.money:add_decimal_marks_to_string(tostring(xp)))
	self:make_fine_text(gui_xp)
	gui_add_xp:set_x(math.round(gui_xp:right()))
	if self._data.gui_objects.potential_level_up_text then
		self._data.gui_objects.potential_level_up_text:set_left(math.round(gui_add_xp:right() + 4))
		self._data.gui_objects.potential_level_up_text:set_visible(xp > self._data.gui_objects.when_to_level_up)
	end
	gui_panel:child("star" .. self._current_job_star):set_alpha(1)
	gui_panel:child("star" .. self._current_job_star):set_color(Color.white)
	managers.menu_component:post_event("count_1_finished")
	self._counting_sound = false
	self._wait_t = t + 0.5
	if self._current_job_star == self._data.stars.job_stars then
		self._wait_t = t + 1
		self._step = self._step + 1
	end
end

function CrimeNetContractGui:count_difficulty_stars(t, dt)
	if self._data.stars.difficulty_stars == 0 then
		self._data.gui_objects.risk_text:show()
		self._step = self._step + 1
		self._wait_t = t + 0.5
		return
	end
	self._current_difficulty_star = self._current_difficulty_star + 1
	local stars = self._data.stars.difficulty_stars
	local gui_panel = self._contract_panel
	local xp = math.round(self._data.add_experience * (self._current_difficulty_star / stars))
	local gui_add_xp = self._data.gui_objects.add_xp
	gui_add_xp:set_text(" +" .. managers.money:add_decimal_marks_to_string(tostring(xp)))
	self:make_fine_text(gui_add_xp)
	if self._data.gui_objects.potential_level_up_text then
		self._data.gui_objects.potential_level_up_text:set_left(math.round(gui_add_xp:right() + 4))
		self._data.gui_objects.potential_level_up_text:set_visible(self._data.experience + xp > self._data.gui_objects.when_to_level_up)
	end
	gui_panel:child("star" .. self._current_job_star + self._current_difficulty_star):set_alpha(1)
	gui_panel:child("star" .. self._current_job_star + self._current_difficulty_star):set_color(tweak_data.screen_colors.risk)
	gui_panel:child(self._data.gui_objects.risks[self._current_difficulty_star + 1]):set_alpha(1)
	gui_panel:child(self._data.gui_objects.risks[self._current_difficulty_star + 1]):set_color(tweak_data.screen_colors.risk)
	managers.menu_component:post_event("count_1_finished")
	self._counting_sound = false
	self._wait_t = t + 0.5
	if self._current_difficulty_star == self._data.stars.difficulty_stars then
		self._wait_t = t + 1
		self._step = self._step + 1
		self._data.gui_objects.risk_text:show()
	end
end

function CrimeNetContractGui:start_count_payday(t, dt)
	managers.menu_component:post_event("count_1")
	self._counting_sound = true
	self._step = self._step + 1
end

function CrimeNetContractGui:count_payday(t, dt)
	self._data.counted_payday_money = math.round(math.step(self._data.counted_payday_money, self._data.payday_money, dt * math.max(self._data.payday_money / (math.rand(1) + 3.5), 40000)))
	self._data.gui_objects.payday_text:set_text(managers.localization:to_upper_text("menu_payday", {
		MONEY = managers.experience:cash_string(self._data.counted_payday_money)
	}))
	self:make_fine_text(self._data.gui_objects.payday_text)
	if self._data.counted_payday_money == self._data.payday_money then
		self._step = self._step + 1
	end
end

function CrimeNetContractGui:end_count_payday(t, dt)
	managers.menu_component:post_event("count_1_finished")
	self._counting_sound = false
	self._wait_t = t + 1.5
	self._step = self._step + 1
end

function CrimeNetContractGui:set_all(t, dt)
	local job_data = self._node:parameters().menu_component_data
	local narrative = tweak_data.narrative.jobs[job_data.job_id]
	local job_stars = narrative.jc / 10
	local difficulty_stars = job_data.difficulty_id - 2
	local gui_panel = self._contract_panel
	local potential_level_up_text = gui_panel:child("potential_level_up_text")
	local total_xp, base_xp, risk_xp = managers.experience:get_contract_xp_by_stars(job_stars, difficulty_stars, job_data.professional, #narrative.chain)
	local total_payout, stage_payout_table, job_payout_table = managers.money:get_contract_money_by_stars(job_stars, difficulty_stars, #narrative.chain, job_data.job_id)
	local stage_value = stage_payout_table[1]
	local stage_risk_value = stage_payout_table[3]
	local job_value = job_payout_table[1]
	local job_risk_value = job_payout_table[3]
	local total_stage_value = stage_payout_table[2]
	local total_stage_risk_value = stage_payout_table[4]
	local total_job_value = job_payout_table[2]
	local total_job_risk_value = job_payout_table[4]
	local num_stages_string = tostring(#narrative.chain) .. " x "
	local xp = base_xp
	local gui_xp = gui_panel:child("job_xp")
	local gui_add_xp = gui_panel:child("add_xp")
	gui_xp:set_text(managers.money:add_decimal_marks_to_string(tostring(xp)))
	self:make_fine_text(gui_xp)
	gui_add_xp:set_x(math.round(gui_xp:right()))
	local xp = risk_xp
	local gui_add_xp = gui_panel:child("add_xp")
	gui_add_xp:set_text(" +" .. managers.money:add_decimal_marks_to_string(tostring(xp)))
	self:make_fine_text(gui_add_xp)
	if potential_level_up_text then
		local next_level_data = managers.experience:next_level_data() or {}
		potential_level_up_text:set_left(math.round(gui_add_xp:right() + 4))
		potential_level_up_text:set_visible(total_xp > next_level_data.points - next_level_data.current_points)
	end
	local max_num_stars = managers.job:get_max_jc_for_player() / 10
	local max_stars_text = gui_panel:child("max_stars_text")
	for i = 1, 10 do
		local star = gui_panel:child("star" .. tostring(i))
		star:set_alpha(1)
		star:set_color(job_stars < i and tweak_data.screen_colors.risk or Color.white)
		star:set_visible(i <= job_stars + difficulty_stars)
		if i == max_num_stars then
			max_stars_text:set_left(star:right() + 2)
			max_stars_text:set_center_y(star:center_y())
			max_stars_text:set_y(math.round(max_stars_text:y()) + 1)
			max_stars_text:set_visible(i ~= 10 and i == job_stars + difficulty_stars and difficulty_stars < 3)
		end
	end
	for i, risk in ipairs({
		"risk_swat",
		"risk_fbi",
		"risk_death_squad"
	}) do
		gui_panel:child(risk):set_alpha(difficulty_stars >= i and 1 or 0.25)
		gui_panel:child(risk):set_color(difficulty_stars >= i and tweak_data.screen_colors.risk or Color.white)
	end
	gui_panel:child("risk_text"):show()
	gui_panel:child("payday_text"):set_text(managers.localization:to_upper_text("menu_payday", {
		MONEY = managers.experience:cash_string(total_payout)
	}))
	self:make_fine_text(gui_panel:child("payday_text"))
	local can_afford = managers.money:can_afford_buy_premium_contract(job_data.job_id, job_data.difficulty_id)
	local text_string = managers.localization:to_upper_text("menu_cn_premium_buy_fee", {
		contract_fee = "##" .. managers.experience:cash_string(managers.money:get_cost_of_premium_contract(job_data.job_id, job_data.difficulty_id)) .. "##",
		offshore = "##" .. managers.experience:cash_string(managers.money:offshore()) .. "##"
	})
	local text_dissected = utf8.characters(text_string)
	local idsp = Idstring("#")
	local start_ci = {}
	local end_ci = {}
	local first_ci = true
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
	text_string = string.gsub(text_string, "##", "")
	gui_panel:child("premium_text"):set_text(text_string)
	gui_panel:child("premium_text"):clear_range_color(1, utf8.len(text_string))
	if #start_ci ~= #end_ci then
		Application:error("CrimeNetContractGui: Not even amount of ##'s in skill description string!", #start_ci, #end_ci)
	else
		for i = 1, #start_ci do
			gui_panel:child("premium_text"):set_range_color(start_ci[i], end_ci[i], not (i ~= 1 or can_afford) and tweak_data.screen_colors.pro_color or tweak_data.screen_colors.button_stage_2)
		end
	end
	if self._step == 1 then
		self._step = self._step + 1
	end
end

function CrimeNetContractGui:free_memory(t, dt)
	self._data = nil
	self._step = self._step + 1
	if self._counting_sound then
		managers.menu_component:post_event("count_1_finished")
		self._counting_sound = false
	end
end

function CrimeNetContractGui:sound_event_callback(event_type, duration)
	if event_type == "end_of_event" then
		self._briefing_duration = nil
		self._briefing_remaining = nil
		self._briefing_len_panel:child("duration"):set_w(0)
		self._briefing_len_panel:child("text"):set_text(managers.localization:to_upper_text("menu_cn_message_stopped"))
		self._briefing_len_panel:child("button_text"):set_text(managers.localization:to_upper_text("menu_play_sound", {
			BTN_X = managers.localization:btn_macro("menu_toggle_voice_message")
		}))
		self:make_fine_text(self._briefing_len_panel:child("text"))
		self:make_fine_text(self._briefing_len_panel:child("button_text"))
		self._briefing_len_panel:child("button_text"):set_position(self._briefing_len_panel:child("text"):left(), self._briefing_len_panel:child("text"):bottom())
	elseif event_type == "duration" and 6 < duration then
		self._briefing_duration = duration
		self._briefing_remaining = self._briefing_duration
	end
end

function CrimeNetContractGui:toggle_post_event()
	if not self._briefing_event then
		return
	end
	if managers.briefing:event_playing() then
		managers.briefing:stop_event()
	else
		managers.briefing:post_event(self._briefing_event, self._post_event_params)
		self._briefing_len_panel:child("text"):set_text(managers.localization:to_upper_text("menu_cn_message_playing"))
		self._briefing_len_panel:child("button_text"):set_text(managers.localization:to_upper_text("menu_stop_sound", {
			BTN_X = managers.localization:btn_macro("menu_toggle_voice_message")
		}))
		self:make_fine_text(self._briefing_len_panel:child("text"))
		self:make_fine_text(self._briefing_len_panel:child("button_text"))
		self._briefing_len_panel:child("button_text"):set_position(self._briefing_len_panel:child("text"):left(), self._briefing_len_panel:child("text"):bottom())
	end
end

function CrimeNetContractGui:update(t, dt)
	if self._wait_t then
		if t > self._wait_t then
			self._wait_t = nil
		end
	else
		local current_step = self._steps[self._step]
		if current_step then
			self[current_step](self, t, dt)
		end
	end
	if self._briefing_duration and self._briefing_remaining then
		self._briefing_remaining = math.max(self._briefing_remaining - dt, 0)
		if self._briefing_remaining > 0 then
			self._briefing_len_panel:child("duration"):set_w(self._briefing_len_panel:w() * (1 - self._briefing_remaining / self._briefing_duration))
		else
			self._briefing_len_panel:child("duration"):set_w(self._briefing_len_panel:w())
			self._briefing_duration = nil
			self._briefing_remaining = nil
		end
	end
end

function CrimeNetContractGui:mouse_moved(o, x, y)
	if alive(self._briefing_len_panel) and self._briefing_len_panel:visible() then
		if self._briefing_len_panel:child("button_text"):inside(x, y) then
			if not self._button_highlight then
				self._button_highlight = true
				self._briefing_len_panel:child("button_text"):set_color(tweak_data.screen_colors.button_stage_2)
			end
			return true, "link"
		elseif self._button_highlight then
			self._briefing_len_panel:child("button_text"):set_color(tweak_data.screen_colors.button_stage_3)
			self._button_highlight = false
		end
	end
	if x > self._contract_panel:left() + 270 and y > self._contract_panel:bottom() - 140 and x < self._contract_panel:right() and y < self._contract_panel:bottom() then
		return false
	end
	return false, "arrow"
end

function CrimeNetContractGui:mouse_pressed(o, button, x, y)
	if alive(self._briefing_len_panel) and self._step > 2 and self._briefing_len_panel:child("button_text"):inside(x, y) then
		self:toggle_post_event()
	end
end

function CrimeNetContractGui:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end

function CrimeNetContractGui:special_btn_pressed(button)
	if button == Idstring("voice_message") then
		self:toggle_post_event()
		return true
	end
	return false
end

function CrimeNetContractGui:set_difficulty_id(difficulty_id)
	local job_data = self._node:parameters().menu_component_data
	local diffs = {
		"easy",
		"normal",
		"hard",
		"overkill",
		"overkill_145"
	}
	job_data.difficulty_id = difficulty_id
	job_data.difficulty = diffs[difficulty_id]
	local menu_risk_id = "menu_risk_pd"
	if job_data.difficulty == "hard" then
		menu_risk_id = "menu_risk_swat"
	elseif job_data.difficulty == "overkill" then
		menu_risk_id = "menu_risk_fbi"
	elseif job_data.difficulty == "overkill_145" then
		menu_risk_id = "menu_risk_special"
	end
	local risk_text = self._contract_panel:child("risk_text")
	risk_text:set_text(managers.localization:to_upper_text(menu_risk_id))
	risk_text:set_w(self._contact_text_header:w() - 360)
	self:make_fine_text(risk_text)
	risk_text:set_h(risk_text:h() + 10)
	self:set_all()
end

function CrimeNetContractGui:close()
	if not managers.menu:is_pc_controller() then
		managers.menu:active_menu().input:activate_controller_mouse()
	end
	self._ws:panel():remove(self._panel)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
	if self._counting_sound then
		managers.menu_component:post_event("count_1_finished")
		self._counting_sound = false
	end
	managers.briefing:stop_event(true)
end
