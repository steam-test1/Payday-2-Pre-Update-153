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
			local card_layer = 50
			local num_cards = math.clamp(math.floor(amount / (data.card_inc or 1)), 1, data.max_cards)
			local upcard = self:create_card(panel, data.icon, card_layer, 10, 0, 1 < num_cards)
			for i = 1, num_cards - 1 do
				self:create_card(panel, data.icon, card_layer - i * 2, 10, 6, true)
			end
			local reward_name = panel:text({
				name = "reward" .. tostring(i),
				text = managers.localization:to_upper_text(data.name_id or ""),
				w = panel:w(),
				h = 32,
				align = "center",
				vertical = "center",
				font_size = tweak_data.menu.pd2_small_font_size * 0.8,
				font = tweak_data.menu.pd2_small_font,
				color = Color.white:with_alpha(0.4),
				layer = 11,
				wrap = true,
				word_wrap = true,
				blend_mode = "add"
			})
			reward_name:set_top(upcard:bottom() + padding * 2)
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
		local level_panel = self:panel():panel({layer = level_layer})
		level_panel:bitmap({
			name = "background",
			texture = "guis/textures/pd2/cs_warning_background",
			color = Color.white,
			layer = 10,
			w = level_panel:w(),
			h = 128
		})
		local suspend_text = level_panel:text({
			text = warning_title and managers.localization:to_upper_text(warning_title) or "",
			align = "left",
			vertical = "left",
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = Color.white,
			layer = 20,
			wrap = true,
			word_wrap = true
		})
		self:make_fine_text(suspend_text)
		suspend_text:set_top(padding * 2)
		suspend_text:set_left(padding * 4)
		local w_multi = 0.75
		local suspend_desc_text = level_panel:text({
			text = warning_text and managers.localization:text(warning_text) or "",
			x = self:panel():w() * ((1 - w_multi) * 0.5),
			w = self:panel():w() * w_multi,
			align = "left",
			vertical = "top",
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = Color.white,
			layer = 20,
			wrap = true,
			word_wrap = true
		})
		self:make_fine_text(suspend_desc_text)
		suspend_desc_text:set_top(suspend_text:bottom())
		suspend_desc_text:set_left(padding * 4)
		level_panel:rect({
			color = Color.black,
			alpha = 0.75
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

function CrimeSpreeRewardsDetailsPage:create_card(panel, icon, layer, rotation_amt, wiggle_amt, outline)
	local rotation = math.rand(-rotation_amt, rotation_amt)
	local wiggle_x = math.rand(-wiggle_amt, wiggle_amt)
	local wiggle_y = math.rand(-wiggle_amt, wiggle_amt)
	local scale = 0.35
	local upcard = self:_create_card(panel, icon, scale, layer, rotation, wiggle_x, wiggle_y)
	if outline then
		local outline_card
		local color = Color.black:with_alpha(0.4)
		outline_card = self:_create_card(panel, icon, scale, layer - 1, rotation, wiggle_x + 1, wiggle_y + 1)
		outline_card:set_color(color)
		outline_card = self:_create_card(panel, icon, scale, layer - 1, rotation, wiggle_x - 1, wiggle_y - 1)
		outline_card:set_color(color)
	end
	return upcard
end

function CrimeSpreeRewardsDetailsPage:_create_card(panel, icon, scale, layer, rotation, wiggle_x, wiggle_y)
	local texture, rect, coords = tweak_data.hud_icons:get_icon_data(icon or "downcard_overkill_deck")
	local upcard = panel:bitmap({
		name = "upcard",
		texture = texture,
		w = math.round(0.7111111 * panel:h() * scale),
		h = panel:h() * scale,
		layer = layer or 20,
		halign = "scale",
		valign = "scale"
	})
	upcard:set_center_x(panel:w() * 0.5 + wiggle_x)
	upcard:set_center_y(panel:h() * 0.3 + wiggle_y)
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
