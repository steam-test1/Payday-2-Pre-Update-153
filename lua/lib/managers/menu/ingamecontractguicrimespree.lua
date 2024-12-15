IngameContractGuiCrimeSpree = IngameContractGuiCrimeSpree or class()

function IngameContractGuiCrimeSpree:init(ws, node)
	local padding = SystemInfo:platform() == Idstring("WIN32") and 10 or 5
	self._panel = ws:panel():panel({
		w = math.round(ws:panel():w() * 0.6),
		h = math.round(ws:panel():h() * 1)
	})
	self._panel:set_y(CoreMenuRenderer.Renderer.border_height + tweak_data.menu.pd2_large_font_size - 5)
	self._panel:grow(0, -(self._panel:y() + tweak_data.menu.pd2_medium_font_size))
	self._node = node
	local job_data = managers.job:current_job_data()
	local job_chain = managers.job:current_job_chain_data()
	local mission = managers.crime_spree:get_mission(managers.crime_spree:current_played_mission())
	local contract_text = self._panel:text({
		layer = 1,
		rotation = 360,
		vertical = "bottom",
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size,
		text = "",
		color = tweak_data.screen_colors.text
	})
	contract_text:set_text(self:get_text("cn_crime_spree_level", {
		level = managers.experience:cash_string(managers.crime_spree:server_spree_level(), "")
	}))
	local range = {
		from = utf8.len(managers.localization:text("cn_crime_spree_level_no_num")),
		to = utf8.len(managers.localization:text(contract_text:text())),
		color = tweak_data.screen_colors.crime_spree_risk
	}
	contract_text:set_range_color(range.from, range.to, range.color)
	contract_text:set_bottom(5)
	local text_panel = self._panel:panel({
		layer = 1,
		w = self._panel:w() - padding * 2,
		h = self._panel:h() - padding * 2
	})
	text_panel:set_left(padding)
	text_panel:set_top(padding)
	local level_title = text_panel:text({
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		text = "",
		color = tweak_data.screen_colors.text
	})
	local level_id = managers.localization:to_upper_text(tweak_data.levels[mission.level.level_id].name_id) or ""
	level_title:set_text(level_id)
	managers.hud:make_fine_text(level_title)
	local briefing_title = text_panel:text({
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		text = "",
		color = tweak_data.screen_colors.text
	})
	briefing_title:set_text(self:get_text("menu_briefing"))
	managers.hud:make_fine_text(briefing_title)
	briefing_title:set_top(level_title:bottom())
	local font_size = tweak_data.menu.pd2_small_font_size
	local text = managers.localization:text(tweak_data.levels[mission.level.level_id].briefing_id) or ""
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
	local _, _, _, h = briefing_description:text_rect()
	briefing_description:set_h(h)
	briefing_description:set_top(briefing_title:bottom())
	local modifiers_title = text_panel:text({
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		text = "",
		color = tweak_data.screen_colors.text
	})
	modifiers_title:set_text(self:get_text("cn_crime_spree_modifiers"))
	managers.hud:make_fine_text(modifiers_title)
	modifiers_title:set_top(briefing_description:bottom() + padding)
	self._modifiers_panel = self._panel:panel({
		w = self._panel:w() - padding * 2,
		h = self._panel:h() - padding * 2 - modifiers_title:bottom(),
		x = padding,
		y = modifiers_title:bottom() + padding
	})
	self._scroll = ScrollablePanel:new(self._modifiers_panel, "modifiers_scroll", {padding = 0, force_scroll_indicators = true})
	local modifiers = managers.crime_spree:server_active_modifiers()
	local count = 0
	local line_h = tweak_data.menu.pd2_small_font_size * 1.5
	local table_split = 0.125
	for i = #modifiers, 1, -1 do
		local modifier_data = modifiers[i]
		local modifier = managers.crime_spree:get_modifier(modifier_data.id)
		if modifier then
			local modifier_class = _G[modifier.class] or {}
			local panel = self._scroll:canvas():panel({
				y = count * line_h,
				h = line_h
			})
			panel:rect({
				color = Color.black,
				alpha = count % 2 == 1 and 0.4 or 0
			})
			local desc = panel:text({
				text = modifier_class:get_description(modifier_data.id),
				valign = "center",
				vertical = "center",
				align = "left",
				halign = "left",
				layer = 1,
				x = padding + panel:w() * table_split,
				y = 5,
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				w = panel:w() * (1 - table_split),
				h = tweak_data.menu.pd2_small_font_size,
				color = Color.white,
				alpha = 0.8
			})
			local multi = 1
			local _, _, w, h = desc:text_rect()
			while w > (panel:w() - 24) * (1 - table_split) do
				multi = multi - 0.05
				desc:set_font_size(tweak_data.menu.pd2_small_font_size * multi)
				_, _, w, h = desc:text_rect()
			end
			local level = panel:text({
				text = managers.experience:cash_string(modifier_data.level, ""),
				valign = "center",
				vertical = "center",
				align = "right",
				halign = "right",
				layer = 1,
				x = padding,
				y = 2,
				color = Color.white,
				font = tweak_data.menu.pd2_medium_font,
				font_size = tweak_data.menu.pd2_medium_font_size,
				w = panel:w() * table_split - padding * 0.5,
				h = tweak_data.menu.pd2_medium_font_size
			})
			if modifier_class.stealth then
				level:set_text(managers.localization:get_default_macro("BTN_SPREE_STEALTH") .. level:text())
			end
			count = count + 1
		end
	end
	self._scroll:update_canvas_size()
	self._text_panel = text_panel
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

function IngameContractGuiCrimeSpree:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function IngameContractGuiCrimeSpree:set_layer(layer)
	if self._panel and alive(self._panel) then
		self._panel:set_layer(layer)
	end
end

function IngameContractGuiCrimeSpree:get_text(text, macros)
	return utf8.to_upper(managers.localization:text(text, macros))
end

function IngameContractGuiCrimeSpree:_make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
end

function IngameContractGuiCrimeSpree:mouse_moved(o, x, y)
end

function IngameContractGuiCrimeSpree:mouse_pressed(button, x, y)
end

function IngameContractGuiCrimeSpree:mouse_wheel_up(x, y)
	self._scroll:scroll(x, y, 1)
end

function IngameContractGuiCrimeSpree:mouse_wheel_down(x, y)
	self._scroll:scroll(x, y, -1)
end

function IngameContractGuiCrimeSpree:special_btn_pressed(button)
	if button == Idstring("menu_modify_item") then
		self:_toggle_potential_rewards()
	end
	return false
end

function IngameContractGuiCrimeSpree:close()
	if self._panel and alive(self._panel) then
		self._panel:parent():remove(self._panel)
		self._panel = nil
	end
end
