ContractBoxGui = ContractBoxGui or class()

function ContractBoxGui:init(ws, fullscreen_ws)
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._panel = self._ws:panel():panel()
	self._fullscreen_panel = self._fullscreen_ws:panel():panel()
	local crewpage_text = self._panel:text({
		name = "crewpage_text",
		text = managers.localization:to_upper_text("menu_crewpage"),
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text
	})
	local _, _, w, h = crewpage_text:text_rect()
	crewpage_text:set_size(w, h)
	local wfs_text
	if not Network:is_server() then
		wfs_text = self._panel:text({
			name = "wfs",
			text = managers.localization:to_upper_text("victory_client_waiting_for_server"),
			align = "right",
			vertical = "bottom",
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = tweak_data.screen_colors.text
		})
		local _, _, w, h = wfs_text:text_rect()
		wfs_text:set_size(w, h)
		wfs_text:set_rightbottom(self._panel:w(), self._panel:h())
	elseif not managers.job:has_active_job() then
		wfs_text = self._panel:text({
			name = "wfs",
			text = managers.localization:to_upper_text("menu_choose_new_contract"),
			align = "right",
			vertical = "bottom",
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = tweak_data.screen_colors.text
		})
		local _, _, w, h = wfs_text:text_rect()
		wfs_text:set_size(w, h)
		wfs_text:set_rightbottom(self._panel:w(), self._panel:h())
	end
	if not managers.menu:is_pc_controller() and wfs_text then
		wfs_text:set_rightbottom(self._panel:w() - 40, self._panel:h() - 150)
	end
	if MenuBackdropGUI then
		if crewpage_text then
			local bg_text = self._fullscreen_panel:text({
				name = "crewpage_text",
				text = managers.localization:to_upper_text("menu_crewpage"),
				h = 90,
				align = "left",
				vertical = "top",
				font_size = tweak_data.menu.pd2_massive_font_size,
				font = tweak_data.menu.pd2_massive_font,
				color = tweak_data.screen_colors.button_stage_3,
				alpha = 0.4,
				layer = 1
			})
			local x, y = managers.gui_data:safe_to_full_16_9(crewpage_text:world_x(), crewpage_text:world_center_y())
			bg_text:set_world_left(x)
			bg_text:set_world_center_y(y)
			bg_text:move(-13, 9)
			MenuBackdropGUI.animate_bg_text(self, bg_text)
		end
		if not managers.menu:is_pc_controller() or wfs_text then
			repeat
				do break end -- pseudo-goto
				local bg_text = self._fullscreen_panel:text({
					text = wfs_text:text(),
					h = 90,
					align = "right",
					vertical = "bottom",
					font_size = tweak_data.menu.pd2_massive_font_size,
					font = tweak_data.menu.pd2_massive_font,
					color = tweak_data.screen_colors.button_stage_3,
					alpha = 0.4,
					layer = 1
				})
				local x, y = managers.gui_data:safe_to_full_16_9(wfs_text:world_right(), wfs_text:world_center_y())
				bg_text:set_world_right(x)
				bg_text:set_world_center_y(y)
				bg_text:move(13, -9)
				MenuBackdropGUI.animate_bg_text(self, bg_text)
			until true
		end
	end
	self:create_contract_box()
end

function ContractBoxGui:create_contract_box()
	if not managers.network:session() then
		return
	end
	if self._contract_panel and alive(self._contract_panel) then
		self._panel:remove(self._contract_panel)
	end
	if self._contract_text_header and alive(self._contract_text_header) then
		self._panel:remove(self._contract_text_header)
	end
	if alive(self._panel:child("pro_text")) then
		self._panel:remove(self._panel:child("pro_text"))
	end
	self._contract_panel = nil
	self._contract_text_header = nil
	local contact_data = managers.job:current_contact_data()
	local job_data = managers.job:current_job_data()
	local job_id = managers.job:current_job_id()
	self._contract_panel = self._panel:panel({
		name = "contract_box_panel",
		w = 350,
		h = 100,
		layer = 0
	})
	self._contract_panel:rect({
		color = Color(0.5, 0, 0, 0),
		layer = -1,
		halign = "grow",
		valign = "grow"
	})
	local font = tweak_data.menu.pd2_small_font
	local font_size = tweak_data.menu.pd2_small_font_size
	if contact_data then
		self._contract_text_header = self._panel:text({
			text = utf8.to_upper(managers.localization:text(contact_data.name_id) .. ": " .. managers.localization:text(job_data.name_id)),
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = tweak_data.screen_colors.text,
			blend_mode = "add"
		})
		local length_text_header = self._contract_panel:text({
			text = managers.localization:to_upper_text("cn_menu_contract_length_header"),
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.text
		})
		local risk_text_header = self._contract_panel:text({
			text = managers.localization:to_upper_text("menu_lobby_difficulty_title"),
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.text
		})
		local exp_text_header = self._contract_panel:text({
			text = managers.localization:to_upper_text("menu_experience"),
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.text
		})
		local payout_text_header = self._contract_panel:text({
			text = managers.localization:to_upper_text("cn_menu_contract_jobpay_header"),
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.text
		})
		do
			local _, _, tw, th = self._contract_text_header:text_rect()
			self._contract_text_header:set_size(tw, th)
		end
		local w = 0
		do
			local _, _, tw, th = length_text_header:text_rect()
			w = math.max(w, tw)
			length_text_header:set_size(tw, th)
		end
		do
			local _, _, tw, th = risk_text_header:text_rect()
			w = math.max(w, tw)
			risk_text_header:set_size(tw, th)
		end
		do
			local _, _, tw, th = exp_text_header:text_rect()
			w = math.max(w, tw)
			exp_text_header:set_size(tw, th)
		end
		do
			local _, _, tw, th = payout_text_header:text_rect()
			w = math.max(w, tw)
			payout_text_header:set_size(tw, th)
		end
		w = w + 10
		length_text_header:set_right(w)
		risk_text_header:set_right(w)
		exp_text_header:set_right(w)
		payout_text_header:set_right(w)
		risk_text_header:set_top(10)
		length_text_header:set_top(risk_text_header:bottom())
		exp_text_header:set_top(length_text_header:bottom())
		payout_text_header:set_top(exp_text_header:bottom())
		local length_text = self._contract_panel:text({
			text = managers.localization:to_upper_text("cn_menu_contract_length", {
				stages = #job_data.chain
			}),
			align = "left",
			vertical = "top",
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.text
		})
		length_text:set_position(length_text_header:right() + 5, length_text_header:top())
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
		local job_stars = managers.job:current_job_stars()
		local job_and_difficulty_stars = managers.job:current_job_and_difficulty_stars()
		local difficulty_stars = managers.job:current_difficulty_stars()
		local risk_color = tweak_data.screen_colors.risk
		local cy = risk_text_header:center_y()
		local sx = risk_text_header:right() + 5
		local difficulty = tweak_data.difficulties[difficulty_stars + 2] or 1
		local difficulty_string_id = tweak_data.difficulty_name_ids[difficulty]
		local difficulty_text = self._contract_panel:text({
			font = font,
			font_size = font_size,
			text = managers.localization:to_upper_text(difficulty_string_id),
			color = tweak_data.screen_colors.text
		})
		do
			local _, _, tw, th = difficulty_text:text_rect()
			difficulty_text:set_size(tw, th)
		end
		difficulty_text:set_x(math.round(sx))
		difficulty_text:set_center_y(cy)
		difficulty_text:set_y(math.round(difficulty_text:y()))
		if 0 < difficulty_stars then
			difficulty_text:set_color(risk_color)
		end
		local plvl = managers.experience:current_level()
		local player_stars = math.max(math.ceil(plvl / 10), 1)
		local total_xp, base_xp, risk_xp = managers.experience:get_contract_xp_by_stars(job_id, job_stars, difficulty_stars, job_data.professional, #job_data.chain)
		local job_xp = self._contract_panel:text({
			font = font,
			font_size = font_size,
			text = managers.money:add_decimal_marks_to_string(tostring(math.round(total_xp))),
			color = tweak_data.screen_colors.text
		})
		do
			local _, _, tw, th = job_xp:text_rect()
			job_xp:set_size(tw, th)
		end
		job_xp:set_position(math.round(exp_text_header:right() + 5), math.round(exp_text_header:top()))
		local risk_xp = self._contract_panel:text({
			font = font,
			font_size = font_size,
			text = " +" .. tostring(math.round(risk_xp)),
			color = risk_color
		})
		do
			local _, _, tw, th = risk_xp:text_rect()
			risk_xp:set_size(tw, th)
		end
		risk_xp:set_position(math.round(job_xp:right()), job_xp:top())
		risk_xp:hide()
		local total_payout, stage_payout_table, job_payout_table = managers.money:get_contract_money_by_stars(job_stars, difficulty_stars, #job_data.chain, managers.job:current_job_id())
		local total_stage_value = stage_payout_table[2]
		local total_stage_risk_value = stage_payout_table[4]
		local total_job_value = job_payout_table[2]
		local total_job_risk_value = job_payout_table[4]
		local job_money = self._contract_panel:text({
			font = font,
			font_size = font_size,
			text = managers.experience:cash_string(math.round(total_payout)),
			color = tweak_data.screen_colors.text
		})
		do
			local _, _, tw, th = job_money:text_rect()
			job_money:set_size(tw, th)
		end
		job_money:set_position(math.round(payout_text_header:right() + 5), math.round(payout_text_header:top()))
		local risk_money = self._contract_panel:text({
			font = font,
			font_size = font_size,
			text = " +" .. managers.experience:cash_string(math.round(total_stage_risk_value + total_job_risk_value)),
			color = risk_color
		})
		do
			local _, _, tw, th = risk_money:text_rect()
			risk_money:set_size(tw, th)
		end
		risk_money:set_position(math.round(job_money:right()), job_money:top())
		risk_money:hide()
		self._contract_panel:set_h(payout_text_header:bottom() + 10)
	elseif managers.menu:debug_menu_enabled() then
		local debug_start = self._contract_panel:text({
			text = "Use DEBUG START to start your level",
			font_size = font_size,
			font = font,
			color = tweak_data.screen_colors.text,
			x = 10,
			y = 10,
			wrap = true,
			word_wrap = true
		})
		debug_start:grow(-debug_start:x() - 10, debug_start:y() - 10)
	end
	self._contract_panel:set_rightbottom(self._panel:w() - 10, self._panel:h() - 50)
	if self._contract_text_header then
		self._contract_text_header:set_bottom(self._contract_panel:top())
		self._contract_text_header:set_left(self._contract_panel:left())
		local wfs_text = self._panel:child("wfs")
		if wfs_text and not managers.menu:is_pc_controller() then
			wfs_text:set_rightbottom(self._panel:w() - 20, self._contract_text_header:top())
		end
	end
	local wfs = self._panel:child("wfs")
	if wfs then
		self._contract_panel:grow(0, wfs:h() + 5)
		self._contract_panel:move(0, -(wfs:h() + 5))
		if self._contract_text_header then
			self._contract_text_header:move(0, -(wfs:h() + 5))
		end
		wfs:set_world_rightbottom(self._contract_panel:world_right() - 5, self._contract_panel:world_bottom())
	end
	if self._contract_text_header and managers.job:is_current_job_professional() then
		local pro_text = self._panel:text({
			name = "pro_text",
			text = managers.localization:to_upper_text("cn_menu_pro_job"),
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			color = tweak_data.screen_colors.pro_color,
			blend_mode = "add"
		})
		local x, y, w, h = pro_text:text_rect()
		pro_text:set_size(w, h)
		pro_text:set_position(self._contract_text_header:right() + 10, self._contract_text_header:y())
	end
	BoxGuiObject:new(self._contract_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	for i = 1, 4 do
		local peer = managers.network:session():peer(i)
		if peer then
			local peer_pos = managers.menu_scene:character_screen_position(i)
			local peer_name = peer:name()
			if peer_pos then
				self:create_character_text(i, peer_pos.x, peer_pos.y, peer_name)
			end
		end
	end
	self._enabled = true
end

function ContractBoxGui:refresh()
	self:create_contract_box()
end

function ContractBoxGui:update(t, dt)
	for i = 1, 4 do
		self:update_character(i)
	end
end

function ContractBoxGui:create_character_text(peer_id, x, y, text, icon)
	self._peers = self._peers or {}
	local color_id = peer_id
	local color = tweak_data.chat_colors[color_id]
	self._peers[peer_id] = self._peers[peer_id] or self._panel:text({
		name = tostring(peer_id),
		text = "",
		align = "center",
		vertical = "center",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		layer = 0,
		color = color,
		blend_mode = "add"
	})
	self._peers[peer_id]:set_text(text or "")
	self._peers[peer_id]:set_visible(self._enabled)
	local _, _, w, h = self._peers[peer_id]:text_rect()
	self._peers[peer_id]:set_size(w, h)
	self._peers[peer_id]:set_center(x, y)
	self._peers_state = self._peers_state or {}
	self._peers_state[peer_id] = self._peers_state[peer_id] or self._panel:text({
		name = tostring(peer_id) .. "_state",
		text = "",
		align = "center",
		vertical = "top",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		layer = 0,
		color = tweak_data.screen_colors.text,
		blend_mode = "add"
	})
	self._peers_state[peer_id]:set_top(self._peers[peer_id]:bottom())
	self._peers_state[peer_id]:set_center_x(self._peers[peer_id]:center_x())
	if icon then
		local texture = tweak_data.hud_icons:get_icon_data("infamy_icon")
		self._peers_icon = self._peers_icon or {}
		self._peers_icon[peer_id] = self._peers_icon[peer_id] or self._panel:bitmap({
			w = 16,
			h = 32,
			texture = texture,
			color = color
		})
		self._peers_icon[peer_id]:set_right(self._peers[peer_id]:x())
		self._peers_icon[peer_id]:set_top(self._peers[peer_id]:y())
	elseif self._peers_icon and self._peers_icon[peer_id] then
		self._panel:remove(self._peers_icon[peer_id])
		self._peers_icon[peer_id] = nil
	end
end

function ContractBoxGui:update_character(peer_id)
	if not peer_id or not managers.network:session() then
		return
	end
	local x = 0
	local y = 0
	local text = ""
	local player_rank = 0
	local peer = managers.network:session():peer(peer_id)
	if peer then
		local local_peer = managers.network:session() and managers.network:session():local_peer()
		local peer_pos = managers.menu_scene:character_screen_position(peer_id)
		x = peer_pos.x
		y = peer_pos.y
		text = peer:name()
		local player_level = peer == local_peer and managers.experience:current_level() or peer:level()
		if player_level then
			player_rank = peer == local_peer and managers.experience:current_rank() or peer:rank()
			local experience = (0 < player_rank and managers.experience:rank_string(player_rank) .. "-" or "") .. player_level
			text = text .. " (" .. experience .. ")"
		end
	else
		self:update_character_menu_state(peer_id, nil)
	end
	self:create_character_text(peer_id, x, y, text, 0 < player_rank)
end

function ContractBoxGui:update_character_menu_state(peer_id, state)
	if not self._peers_state then
		return
	end
	if not self._peers_state[peer_id] then
		return
	end
	self._peers_state[peer_id]:set_text(state and managers.localization:to_upper_text("menu_lobby_menu_state_" .. state) or "")
end

function ContractBoxGui:_create_text_box(ws, title, text, content_data, config)
end

function ContractBoxGui:_create_lower_static_panel(lower_static_panel)
end

function ContractBoxGui:mouse_pressed(button, x, y)
	if not self:can_take_input() then
		return
	end
	if button == Idstring("0") then
	end
end

function ContractBoxGui:mouse_moved(x, y)
	if not self:can_take_input() then
		return
	end
	return false, nil
end

function ContractBoxGui:can_take_input()
	return false
end

function ContractBoxGui:moved_scroll_bar()
end

function ContractBoxGui:mouse_wheel_down()
end

function ContractBoxGui:mouse_wheel_up()
end

function ContractBoxGui:check_minimize()
	return false
end

function ContractBoxGui:check_grab_scroll_bar()
	return false
end

function ContractBoxGui:release_scroll_bar()
	return false
end

function ContractBoxGui:set_enabled(enabled)
	self._enabled = enabled
	if enabled then
	else
	end
	if self._contract_panel then
		self._contract_panel:set_visible(enabled)
	end
	if self._contract_text_header then
		self._contract_text_header:set_visible(enabled)
	end
	if self._panel:child("wfs") then
		self._panel:child("wfs"):set_visible(enabled)
	end
end

function ContractBoxGui:set_size(x, y)
end

function ContractBoxGui:set_visible(visible)
end

function ContractBoxGui:close()
	self._ws:panel():remove(self._panel)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
end
