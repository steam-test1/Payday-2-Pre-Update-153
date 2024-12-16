CrimeSpreeModifierDetailsPage = CrimeSpreeModifierDetailsPage or class(CrimeSpreeDetailsPage)
local padding = 10
local table_split = 0.125

function CrimeSpreeModifierDetailsPage:init(...)
	CrimeSpreeModifierDetailsPage.super.init(self, ...)
	local modifiers = managers.crime_spree:server_active_modifiers()
	local next_modifiers_h = tweak_data.menu.pd2_small_font_size * 2
	local line_h = tweak_data.menu.pd2_small_font_size * 1.5
	self._next_panel = self:panel():panel({h = next_modifiers_h})
	local name_id = managers.crime_spree:in_progress() and "menu_cs_next_modifiers" or "menu_cs_not_in_progress"
	local name_color = managers.crime_spree:in_progress() and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1
	local params = {
		loud = managers.crime_spree:next_modifier_level("loud") - managers.crime_spree:server_spree_level(),
		stealth = managers.crime_spree:next_modifier_level("stealth") - managers.crime_spree:server_spree_level()
	}
	self._next_text = self._next_panel:text({
		text = managers.localization:text(name_id, params),
		valign = "center",
		vertical = "center",
		align = "left",
		halign = "left",
		layer = 1,
		x = padding,
		y = padding * 0.5,
		color = name_color,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		h = tweak_data.menu.pd2_small_font_size
	})
	self._cached_server_level = managers.crime_spree:server_spree_level()
	local modifiers_panel = self:panel():panel({
		y = self._next_panel:h() - padding,
		h = self:panel():h() - self._next_panel:h() + padding
	})
	local modifiers_h = CrimeSpreeModifierDetailsPage.add_modifiers_panel(self, modifiers_panel)
	modifiers_h = modifiers_h + line_h
	self:panel():bitmap({
		texture = "guis/textures/test_blur_df",
		w = self:panel():w(),
		h = modifiers_h,
		render_template = "VertexColorTexturedBlur3D",
		halign = "scale",
		valign = "scale",
		layer = -1,
		alpha = 1
	})
	self:panel():rect({
		color = Color.black,
		h = modifiers_h,
		alpha = 0.5,
		halign = "scale",
		valign = "scale"
	})
	local outline_panel = self:panel():panel({h = modifiers_h})
	BoxGuiObject:new(outline_panel, {
		sides = {
			4,
			4,
			2,
			1
		}
	})
end

function CrimeSpreeModifierDetailsPage:mouse_wheel_up(x, y)
	self._scroll:scroll(x, y, 1)
end

function CrimeSpreeModifierDetailsPage:mouse_wheel_down(x, y)
	self._scroll:scroll(x, y, -1)
end

function CrimeSpreeModifierDetailsPage:update(t, dt)
	if not managers.menu:is_pc_controller() and self._gui and self._gui._right_axis_vector and not mvector3.is_zero(self._gui._right_axis_vector) then
		local x = mvector3.x(self._gui._right_axis_vector)
		local y = mvector3.y(self._gui._right_axis_vector)
		self._scroll:perform_scroll(ScrollablePanel.SCROLL_SPEED * dt * 24, y)
	end
	if self._cached_server_level ~= managers.crime_spree:server_spree_level() then
		local params = {
			loud = managers.crime_spree:next_modifier_level("loud") - managers.crime_spree:server_spree_level(),
			stealth = managers.crime_spree:next_modifier_level("stealth") - managers.crime_spree:server_spree_level()
		}
		self._next_text:set_text(managers.localization:text("menu_cs_next_modifiers", params))
		self._cached_server_level = managers.crime_spree:server_spree_level()
	end
end

function CrimeSpreeModifierDetailsPage:add_modifiers_panel(parent, modifiers)
	self._scroll = ScrollablePanel:new(parent, "modifiers_scroll", {
		layer = 1,
		padding = 0,
		force_scroll_indicators = true
	})
	modifiers = modifiers or managers.crime_spree:server_active_modifiers()
	local count = 0
	local next_y = 0
	for i = #modifiers, 1, -1 do
		local modifier_data = modifiers[i]
		local modifier = managers.crime_spree:get_modifier(modifier_data.id)
		if modifier then
			local modifier_class = _G[modifier.class] or {}
			local panel = self._scroll:canvas():panel({
				w = self._scroll:canvas():w(),
				y = next_y
			})
			local desc = panel:text({
				text = modifier_class:get_description(modifier_data.id),
				valign = "top",
				vertical = "top",
				align = "left",
				halign = "left",
				layer = 1,
				x = padding + panel:w() * table_split,
				y = 5,
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				w = panel:w() * (1 - table_split) - padding * 3,
				h = tweak_data.menu.pd2_small_font_size,
				color = Color.white,
				alpha = 0.8,
				wrap = true,
				word_wrap = true
			})
			local level = panel:text({
				text = managers.experience:cash_string(modifier_data.level, ""),
				valign = "top",
				vertical = "top",
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
			local _, _, dw, dh = desc:text_rect()
			desc:set_h(dh)
			panel:set_h(dh + desc:y() * 2)
			panel:rect({
				color = Color.black,
				alpha = count % 2 == 1 and 0.4 or 0
			})
			next_y = panel:bottom()
			count = count + 1
		end
	end
	self._scroll:update_canvas_size()
	return next_y
end
