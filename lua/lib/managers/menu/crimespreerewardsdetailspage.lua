CrimeSpreeRewardsDetailsPage = CrimeSpreeRewardsDetailsPage or class(CrimeSpreeDetailsPage)
local padding = 10

function CrimeSpreeRewardsDetailsPage:init(...)
	CrimeSpreeRewardsDetailsPage.super.init(self, ...)
	self:panel():bitmap({
		texture = "guis/textures/test_blur_df",
		w = self:panel():w(),
		h = self:panel():h(),
		render_template = "VertexColorTexturedBlur3D",
		halign = "scale",
		valign = "scale",
		layer = -1,
		alpha = 1
	})
	self:panel():rect({
		color = Color.black,
		alpha = 0.5,
		halign = "scale",
		valign = "scale"
	})
	local outline_panel = self:panel():panel({})
	BoxGuiObject:new(outline_panel, {
		sides = {
			4,
			4,
			2,
			1
		}
	})
	local w = (self:panel():w() - padding) / #tweak_data.crime_spree.rewards
	local count = 0
	for i, data in ipairs(tweak_data.crime_spree.rewards) do
		local amount = math.max(math.floor(data.amount * managers.crime_spree:reward_level()), 0)
		if 0 < amount or data.always_show then
			local panel = self:panel():panel({
				w = w,
				x = count * w
			})
			local rotation = math.rand(-10, 10)
			local scale = 0.5
			local texture, rect, coords = tweak_data.hud_icons:get_icon_data(data.icon or "downcard_overkill_deck")
			local upcard = panel:bitmap({
				name = "upcard",
				texture = texture,
				w = math.round(0.7111111 * panel:h() * scale),
				h = panel:h() * scale,
				layer = 20,
				halign = "scale",
				valign = "scale"
			})
			upcard:set_center_x(panel:w() * 0.5)
			upcard:set_center_y(panel:h() * 0.35)
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
			local reward_name = panel:text({
				name = "reward" .. tostring(i),
				text = managers.localization:text(data.name_id or ""),
				w = panel:w(),
				h = 32,
				align = "center",
				vertical = "center",
				font_size = tweak_data.menu.pd2_medium_font_size,
				font = tweak_data.menu.pd2_medium_font,
				color = Color.white,
				layer = 11,
				wrap = true,
				word_wrap = true,
				blend_mode = "add"
			})
			reward_name:set_top(upcard:bottom() + padding)
			local x, y, w, h = reward_name:text_rect()
			reward_name:set_h(h)
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
			reward_amount:set_top(reward_name:bottom())
			local x, y, w, h = reward_amount:text_rect()
			reward_amount:set_h(h)
			count = count + 1
		end
	end
	local warning_title, warning_text
	if managers.crime_spree:server_spree_level() < managers.crime_spree:spree_level() then
		warning_title = "menu_cs_rewards_suspended"
		warning_text = "menu_cs_rewards_suspended_desc"
	elseif not managers.crime_spree:in_progress() then
		warning_title = "menu_cs_rewards_not_in_progress"
		warning_text = "menu_cs_rewards_not_in_progress_desc"
	elseif managers.crime_spree:has_failed() then
		warning_title = "menu_cs_rewards_has_failed"
		warning_text = "menu_cs_rewards_has_failed_desc"
	end
	if warning_title then
		local level_layer = 50
		local level_panel = self:panel():panel({
			h = tweak_data.menu.pd2_large_font_size,
			layer = level_layer
		})
		level_panel:set_center_y(self:panel():h() * 0.4)
		level_panel:rect({
			color = tweak_data.screen_colors.important_1,
			alpha = 0.4
		})
		local suspend_text = level_panel:text({
			text = warning_title and managers.localization:to_upper_text(warning_title) or "",
			align = "center",
			vertical = "center",
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = Color.white,
			layer = 10,
			wrap = true,
			word_wrap = true,
			blend_mode = "add"
		})
		suspend_text:set_center_y(level_panel:h() * 0.5)
		local w_multi = 0.75
		local suspend_desc_text = self:panel():text({
			text = warning_text and managers.localization:text(warning_text) or "",
			x = self:panel():w() * ((1 - w_multi) * 0.5),
			w = self:panel():w() * w_multi,
			align = "center",
			vertical = "top",
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = Color.white,
			layer = level_layer + 1,
			wrap = true,
			word_wrap = true,
			blend_mode = "add"
		})
		suspend_desc_text:set_top(level_panel:bottom() + padding)
		self:panel():rect({
			color = Color.black,
			alpha = 0.6,
			layer = level_layer - 10
		})
		outline_panel:set_layer(level_layer + 10)
	end
end

function CrimeSpreeRewardsDetailsPage:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
	return x, y, w, h
end
