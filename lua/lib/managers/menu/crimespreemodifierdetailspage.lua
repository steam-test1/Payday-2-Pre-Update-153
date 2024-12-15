CrimeSpreeModifierDetailsPage = CrimeSpreeModifierDetailsPage or class(CrimeSpreeDetailsPage)
local padding = 10

function CrimeSpreeModifierDetailsPage:init(...)
	CrimeSpreeModifierDetailsPage.super.init(self, ...)
	local modifiers = managers.crime_spree:server_active_modifiers()
	local clip_modifiers = #modifiers >= tweak_data.crime_spree.gui.modifiers_before_scroll
	local next_modifiers_h = tweak_data.menu.pd2_small_font_size * 2
	local line_h = tweak_data.menu.pd2_small_font_size * 1.5
	local table_split = 0.125
	local background_h = not clip_modifiers and next_modifiers_h + line_h * #modifiers - padding or nil
	self:panel():bitmap({
		texture = "guis/textures/test_blur_df",
		w = self:panel():w(),
		h = background_h,
		render_template = "VertexColorTexturedBlur3D",
		halign = "scale",
		valign = "scale",
		layer = -1,
		alpha = 1
	})
	self:panel():rect({
		color = Color.black,
		h = background_h,
		alpha = 0.5,
		halign = "scale",
		valign = "scale"
	})
	if not clip_modifiers then
		local outline_panel = self:panel():panel({h = background_h})
		BoxGuiObject:new(outline_panel, {
			sides = {
				4,
				4,
				2,
				1
			}
		})
	end
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
	self._scroll = ScrollablePanel:new(modifiers_panel, "modifiers_scroll", {
		layer = 1,
		padding = 0,
		force_scroll_indicators = true
	})
	local count = 0
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
		self._scroll:perform_scroll(ScrollablePanel.SCROLL_SPEED * dt * 200, y)
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
