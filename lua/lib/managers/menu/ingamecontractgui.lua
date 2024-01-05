IngameContractGui = IngameContractGui or class()

function IngameContractGui:init(ws)
	self._panel = ws:panel():panel({
		w = math.round(ws:panel():w() / 2.2),
		h = math.round(ws:panel():h() / 1.2)
	})
	self._panel:set_y(CoreMenuRenderer.Renderer.border_height + tweak_data.menu.pd2_large_font_size)
	local job_data = managers.job:current_job_data()
	if job_data and managers.job:current_job_id() == "safehouse" and Global.mission_manager.saved_job_values.playedSafeHouseBefore then
		self._panel:set_visible(false)
	end
	local contract_text = self._panel:text({
		layer = 1,
		rotation = 360,
		vertical = "bottom",
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		text = "",
		color = tweak_data.screen_colors.text
	})
	contract_text:set_text(self:get_text("cn_menu_contract_header") .. " " .. (job_data and self:get_text(job_data.name_id) or ""))
	contract_text:set_bottom(0)
	local text_panel = self._panel:panel({
		layer = 1,
		w = self._panel:w() - 32,
		h = self._panel:h() - 32
	})
	text_panel:set_center(self._panel:w() / 2, self._panel:h() / 2)
	local briefing_title = text_panel:text({
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		text = "",
		color = tweak_data.screen_colors.text
	})
	briefing_title:set_text(self:get_text("menu_briefing"))
	managers.hud:make_fine_text(briefing_title)
	local font_size = tweak_data.menu.pd2_small_font_size
	local text = job_data and managers.localization:text(job_data.briefing_id) or ""
	local briefing_description = text_panel:text({
		name = "briefing_description",
		text = text,
		font = tweak_data.menu.pd2_small_font,
		font_size = font_size,
		color = tweak_data.screen_colors.text,
		align = "left",
		vertical = "top",
		wrap = true,
		word_wrap = true,
		h = 128
	})
	managers.hud:make_fine_text(briefing_description)
	briefing_description:set_h(briefing_description:h() + 10)
	briefing_description:set_top(briefing_title:bottom())
	local modifiers_text = text_panel:text({
		name = "modifiers_text",
		text = managers.localization:to_upper_text("menu_cn_modifiers"),
		font = tweak_data.menu.pd2_small_font,
		font_size = font_size,
		color = tweak_data.screen_colors.text,
		align = "left",
		vertical = "top"
	})
	managers.hud:make_fine_text(modifiers_text)
	modifiers_text:set_bottom(text_panel:h() / 2)
	local job_heat_mul = managers.job:get_job_heat_multipliers(managers.job:current_job_id()) - 1
	local job_heat = math.round(job_heat_mul * 100)
	local job_heat_string = tostring(math.abs(job_heat))
	local is_job_heated = job_heat ~= 0 or job_heat_mul ~= 0
	if job_heat == 0 and job_heat_mul ~= 0 then
		job_heat_string = string.format("%0.2f", math.abs(job_heat_mul * 100))
	else
	end
	local heat_warning_text
	local heat_color = managers.job:get_job_heat_color(managers.job:current_job_id())
	if is_job_heated then
		heat_warning_text = text_panel:text({
			name = "heat_warning_text",
			text = managers.localization:to_upper_text("menu_heat_" .. (0 < job_heat_mul and "warm" or job_heat_mul < 0 and "cold" or "ok"), {job_heat = job_heat_string}),
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			color = heat_color,
			align = "left",
			vertical = "top",
			wrap = true,
			word_wrap = true
		})
		managers.hud:make_fine_text(heat_warning_text)
		heat_warning_text:set_top(modifiers_text:bottom())
		heat_warning_text:set_left(10)
	end
	local pro_warning_text
	if managers.job:is_current_job_professional() then
		pro_warning_text = text_panel:text({
			name = "pro_warning_text",
			text = self:get_text("menu_pro_warning"),
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			color = tweak_data.screen_colors.pro_color,
			align = "left",
			vertical = "top",
			wrap = true,
			word_wrap = true,
			h = 128
		})
		managers.hud:make_fine_text(pro_warning_text)
		pro_warning_text:set_h(pro_warning_text:h())
		pro_warning_text:set_top(is_job_heated and heat_warning_text:bottom() or modifiers_text:bottom())
		pro_warning_text:set_left(10)
	end
	modifiers_text:set_visible(heat_warning_text and heat_warning_text:visible() or pro_warning_text and pro_warning_text:visible())
	local risk_color = tweak_data.screen_colors.risk
	local risk_title = text_panel:text({
		font = tweak_data.menu.pd2_small_font,
		font_size = font_size,
		text = self:get_text("menu_risk"),
		color = risk_color
	})
	managers.hud:make_fine_text(risk_title)
	risk_title:set_top((pro_warning_text and pro_warning_text:visible() and pro_warning_text:bottom() or heat_warning_text and heat_warning_text:visible() and heat_warning_text:bottom() or math.round(text_panel:h() / 2)) + 5)
	risk_title:set_visible(job_data and true or false)
	local menu_risk_id = "menu_risk_pd"
	if Global.game_settings.difficulty == "hard" then
		menu_risk_id = "menu_risk_swat"
	elseif Global.game_settings.difficulty == "overkill" then
		menu_risk_id = "menu_risk_fbi"
	elseif Global.game_settings.difficulty == "overkill_145" then
		menu_risk_id = "menu_risk_special"
	elseif Global.game_settings.difficulty == "overkill_290" then
		menu_risk_id = "menu_risk_elite"
	end
	local risk_stats_panel = text_panel:panel({
		name = "risk_stats_panel"
	})
	risk_stats_panel:set_h(risk_title:h() + 5)
	if job_data then
		local job_stars = managers.job:current_job_stars()
		local job_and_difficulty_stars = managers.job:current_job_and_difficulty_stars()
		local difficulty_stars = managers.job:current_difficulty_stars()
		local job_id = managers.job:current_job_id()
		local rsx = 15
		local risks = {
			"risk_pd",
			"risk_swat",
			"risk_fbi",
			"risk_death_squad"
		}
		if not Global.SKIP_OVERKILL_290 then
			table.insert(risks, "risk_murder_squad")
		end
		local max_y = 0
		local max_x = 0
		for i, name in ipairs(risks) do
			if i ~= 1 then
				local texture, rect = tweak_data.hud_icons:get_icon_data(name)
				local active = i <= difficulty_stars + 1
				local color = active and i ~= 1 and risk_color or tweak_data.screen_colors.text
				local alpha = active and 1 or 0.25
				local risk = text_panel:bitmap({
					texture = texture,
					texture_rect = rect,
					x = 0,
					y = 0,
					alpha = alpha,
					color = color
				})
				risk:set_x(rsx)
				risk:set_top(math.round(risk_title:bottom()))
				rsx = rsx + risk:w() + 2
				local stat = managers.statistics:completed_job(job_id, tweak_data:index_to_difficulty(i + 1))
				local risk_stat = risk_stats_panel:text({
					name = name,
					font = tweak_data.menu.pd2_small_font,
					font_size = font_size,
					text = tostring(stat),
					align = "center"
				})
				managers.hud:make_fine_text(risk_stat)
				risk_stat:set_world_center_x(risk:world_center_x())
				local this_difficulty = i == difficulty_stars + 1
				active = i <= difficulty_stars + 1
				color = active and risk_color or Color.white
				alpha = this_difficulty and 1 or active and 0.5 or 0.25
				risk_stat:set_color(color)
				risk_stat:set_alpha(alpha)
				max_y = math.max(max_y, risk:bottom())
				max_x = math.max(max_x, risk:right() + 5)
				max_x = math.max(max_x, risk_stat:right() + risk_stats_panel:left() + 10)
			end
		end
		risk_stats_panel:set_top(math.round(max_y + 2))
		local stat = managers.statistics:completed_job(job_id, tweak_data:index_to_difficulty(difficulty_stars + 2))
		local risk_text = text_panel:text({
			x = max_x,
			w = text_panel:w() - max_x,
			h = text_panel:h(),
			name = "risk_text",
			text = self:get_text(menu_risk_id) .. " " .. managers.localization:to_upper_text("menu_stat_job_completed", {
				stat = tostring(stat)
			}) .. " ",
			font = tweak_data.hud_stats.objective_desc_font,
			font_size = font_size,
			color = risk_color,
			align = "left",
			vertical = "top",
			wrap = true,
			word_wrap = true
		})
		risk_text:set_top(math.round(risk_title:bottom() + 4))
		risk_text:set_h(risk_stats_panel:bottom() - risk_text:top())
		local potential_rewards_title = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = self:get_text("menu_potential_rewards"),
			color = tweak_data.screen_colors.text
		})
		managers.hud:make_fine_text(potential_rewards_title)
		potential_rewards_title:set_top(risk_stats_panel:bottom() + 4)
		local jobpay_title = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = managers.localization:to_upper_text("cn_menu_contract_jobpay_header"),
			color = tweak_data.screen_colors.text,
			x = 10
		})
		managers.hud:make_fine_text(jobpay_title)
		jobpay_title:set_top(math.round(potential_rewards_title:bottom()))
		local experience_title = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = self:get_text("menu_experience"),
			color = tweak_data.screen_colors.text,
			x = 10
		})
		managers.hud:make_fine_text(experience_title)
		experience_title:set_top(math.round(jobpay_title:bottom()))
		local sx = math.max(jobpay_title:right(), experience_title:right())
		sx = sx + 8
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
		local cy = jobpay_title:center_y()
		local plvl = managers.experience:current_level()
		local player_stars = math.max(math.ceil(plvl / 10), 1)
		local cy = experience_title:center_y()
		local num_days = #job_data.chain or 1
		local days_multiplier = 0
		local total_xp, base_xp, risk_xp, heat_base_xp, heat_risk_xp = managers.experience:get_contract_xp_by_stars(job_id, job_stars, difficulty_stars, job_data.professional, num_days)
		local job_xp = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = "",
			color = tweak_data.screen_colors.text
		})
		job_xp:set_text(managers.money:add_decimal_marks_to_string(tostring(math.round(base_xp))))
		managers.hud:make_fine_text(job_xp)
		job_xp:set_x(sx)
		job_xp:set_center_y(cy)
		local heat_xp = math.round(heat_base_xp + heat_risk_xp)
		local risk_prefix = 0 <= risk_xp and " +" or " -"
		local heat_prefix = 0 <= heat_xp and " +" or " -"
		local abs_risk_xp = math.abs(math.round(risk_xp))
		local abs_heat_xp = math.abs(heat_xp)
		local add_xp = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = "",
			color = risk_color
		})
		add_xp:set_text(risk_prefix .. managers.money:add_decimal_marks_to_string(tostring(abs_risk_xp)))
		managers.hud:make_fine_text(add_xp)
		add_xp:set_x(job_xp:right())
		add_xp:set_center_y(cy)
		local heat_add_xp = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = "",
			color = heat_color
		})
		heat_add_xp:set_text(heat_prefix .. managers.money:add_decimal_marks_to_string(tostring(abs_heat_xp)))
		managers.hud:make_fine_text(heat_add_xp)
		heat_add_xp:set_x(math.round(add_xp:right()))
		heat_add_xp:set_center_y(math.round(cy))
		heat_add_xp:set_visible(is_job_heated)
		local gain_xp = total_xp
		local levels_gained = managers.experience:get_levels_gained_from_xp(gain_xp)
		local reached_level_cap = managers.experience:reached_level_cap()
		local levelup_text = reached_level_cap and managers.localization:to_upper_text("menu_reached_level_cap") or managers.localization:to_upper_text("menu_levelup", {
			levels = string.format("%0.1d%%", levels_gained * 100)
		})
		local potential_level_up_text = text_panel:text({
			layer = 3,
			name = "potential_level_up_text",
			blend_mode = "normal",
			visible = true,
			text = levelup_text,
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.hud_stats.potential_xp_color
		})
		managers.hud:make_fine_text(potential_level_up_text)
		potential_level_up_text:set_left(math.round((heat_add_xp:visible() and heat_add_xp:right() or add_xp:right()) + 4))
		potential_level_up_text:set_top(math.round(heat_add_xp:top()))
		potential_level_up_text:set_visible(not managers.job:stage_success() or not managers.job:on_last_stage())
		local total_payout, stage_payout_table, job_payout_table = managers.money:get_contract_money_by_stars(job_stars, difficulty_stars, num_days, managers.job:current_job_id())
		local stage_value = stage_payout_table[1]
		local stage_risk_value = stage_payout_table[3]
		local job_value = job_payout_table[1]
		local job_risk_value = job_payout_table[3]
		local cy = jobpay_title:center_y()
		local job_cash = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = "",
			color = tweak_data.screen_colors.text
		})
		job_cash:set_text(managers.experience:cash_string(math.round(job_value)))
		managers.hud:make_fine_text(job_cash)
		job_cash:set_x(sx)
		job_cash:set_center_y(cy)
		local add_cash = text_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = font_size,
			text = "",
			color = risk_color
		})
		add_cash:set_text(" +" .. managers.experience:cash_string(math.round(job_risk_value)))
		managers.hud:make_fine_text(add_cash)
		add_cash:set_x(job_cash:right())
		add_cash:set_center_y(cy)
		local payday_value = total_payout
		local payday_text = text_panel:text({
			font = tweak_data.menu.pd2_large_font,
			font_size = tweak_data.menu.pd2_large_font_size,
			text = self:get_text("menu_payday", {
				MONEY = managers.experience:cash_string(math.round(payday_value))
			}),
			color = tweak_data.screen_colors.text
		})
		managers.hud:make_fine_text(payday_text)
		payday_text:set_bottom(text_panel:h())
	end
	self:_rec_round_object(self._panel)
	self._sides = BoxGuiObject:new(self._panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
end

function IngameContractGui:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function IngameContractGui:set_layer(layer)
	self._panel:set_layer(layer)
end

function IngameContractGui:get_text(text, macros)
	return utf8.to_upper(managers.localization:text(text, macros))
end

function IngameContractGui:_make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
end

function IngameContractGui:close()
	if self._panel and alive(self._panel) then
		self._panel:parent():remove(self._panel)
		self._panel = nil
	end
end
