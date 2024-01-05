core:import("CoreEvent")
require("lib/managers/HUDManagerAnimatePD2")
require("lib/managers/hud/HUDTeammate")
require("lib/managers/hud/HUDInteraction")
require("lib/managers/hud/HUDStatsScreen")
require("lib/managers/hud/HUDObjectives")
require("lib/managers/hud/HUDPresenter")
require("lib/managers/hud/HUDAssaultCorner")
require("lib/managers/hud/HUDChat")
require("lib/managers/hud/HUDHint")
require("lib/managers/hud/HUDAccessCamera")
require("lib/managers/hud/HUDHeistTimer")
require("lib/managers/hud/HUDTemp")
require("lib/managers/hud/HUDSuspicion")
require("lib/managers/hud/HUDBlackScreen")
require("lib/managers/hud/HUDMissionBriefing")
require("lib/managers/hud/HUDStageEndScreen")
require("lib/managers/hud/HUDLootScreen")
require("lib/managers/hud/HUDHitConfirm")
require("lib/managers/hud/HUDHitDirection")
require("lib/managers/hud/HUDPlayerDowned")
require("lib/managers/hud/HUDPlayerCustody")
HUDManager.disabled = {}
HUDManager.disabled[Idstring("guis/player_info_hud"):key()] = true
HUDManager.disabled[Idstring("guis/player_info_hud_fullscreen"):key()] = true
HUDManager.disabled[Idstring("guis/player_hud"):key()] = true
HUDManager.disabled[Idstring("guis/experience_hud"):key()] = true
HUDManager.PLAYER_PANEL = 4

function HUDManager:controller_mod_changed()
	if self:alive("guis/mask_off_hud") then
		self:script("guis/mask_off_hud").mask_on_text:set_text(utf8.to_upper(managers.localization:text("hud_instruct_mask_on", {
			BTN_USE_ITEM = managers.localization:btn_macro("use_item")
		})))
	end
	if self._hud_temp then
		self._hud_temp:set_throw_bag_text()
	end
	if self._hud_player_downed then
		self._hud_player_downed:set_arrest_finished_text()
	end
	if alive(managers.interaction:active_object()) then
		managers.interaction:active_object():interaction():selected()
	end
end

function HUDManager:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end

function HUDManager:text_clone(text)
	return text:parent():text({
		font = tweak_data.hud.medium_font_noshadow,
		font_size = text:font_size(),
		text = text:text(),
		x = text:x(),
		y = text:y(),
		w = text:w(),
		h = text:h(),
		align = text:align(),
		vertical = text:vertical(),
		layer = text:layer(),
		color = text:color(),
		visible = text:visible()
	})
end

function HUDManager:set_player_location(location_id)
	if location_id then
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		hud.location_text:set_text(utf8.to_upper(managers.localization:text(location_id)))
	end
end

function HUDManager:add_weapon(data)
	self:_set_weapon(data)
	print("add_weapon", inspect(data))
	local teammate_panel = self._teammate_panels[HUDManager.PLAYER_PANEL]:panel()
	local mask = teammate_panel:child("mask")
	local pad = 4
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.unit:base():weapon_tweak_data().hud_icon)
	local weapon = teammate_panel:bitmap({
		name = "weapon" .. data.inventory_index,
		visible = data.is_equip,
		texture = icon,
		color = Color(1, 0.8, 0.8, 0.8),
		layer = 2,
		texture_rect = texture_rect,
		x = mask:right() + pad
	})
	weapon:set_bottom(mask:bottom())
	self._hud.weapons[data.inventory_index] = {
		texture_rect = texture_rect,
		bitmap = weapon,
		inventory_index = data.inventory_index,
		unit = data.unit
	}
	if data.is_equip then
		self:set_weapon_selected_by_inventory_index(data.inventory_index)
	end
	if not data.is_equip and (data.inventory_index == 1 or data.inventory_index == 2) then
		self:_update_second_weapon_ammo_info(HUDManager.PLAYER_PANEL, data.unit)
	end
end

function HUDManager:_set_weapon(data)
	if data.inventory_index > 2 then
		return
	end
end

function HUDManager:set_weapon_selected_by_inventory_index(inventory_index)
	self:_set_weapon_selected(inventory_index)
end

function HUDManager:_set_weapon_selected(id)
	self._hud.selected_weapon = id
	local icon = self._hud.weapons[self._hud.selected_weapon].unit:base():weapon_tweak_data().hud_icon
	self:_set_teammate_weapon_selected(HUDManager.PLAYER_PANEL, id, icon)
end

function HUDManager:_set_teammate_weapon_selected(i, id, icon)
	self._teammate_panels[i]:set_weapon_selected(id, icon)
	for i, data in pairs(self._hud.weapons) do
		if alive(data.bitmap) then
			data.bitmap:set_visible(false and id == i)
		end
		if id == i then
		end
	end
end

function HUDManager:set_ammo_amount(selection_index, max_clip, current_clip, current_left, max)
	if 2 < selection_index then
		print("set_ammo_amount", selection_index, max_clip, current_clip, current_left, max)
		Application:stack_dump()
		debug_pause("WRONG SELECTION INDEX!")
	end
	managers.player:update_synced_ammo_info_to_peers(selection_index, max_clip, current_clip, current_left, max)
	self:set_teammate_ammo_amount(HUDManager.PLAYER_PANEL, selection_index, max_clip, current_clip, current_left, max)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	if hud.panel:child("ammo_test") then
		local panel = hud.panel:child("ammo_test")
		local ammo_rect = panel:child("ammo_test_rect")
		ammo_rect:set_w(panel:w() * current_clip / max_clip)
		ammo_rect:set_center_x(panel:w() / 2)
		panel:stop()
		panel:animate(callback(self, self, "_animate_ammo_test"))
	end
end

function HUDManager:set_teammate_ammo_amount(id, selection_index, max_clip, current_clip, current_left, max)
	local type = selection_index == 1 and "secondary" or "primary"
	self._teammate_panels[id]:set_ammo_amount_by_type(type, max_clip, current_clip, current_left, max)
end

function HUDManager:set_weapon_ammo_by_unit(unit)
	local second_weapon_index = self._hud.selected_weapon == 1 and 2 or 1
	if second_weapon_index == unit:base():weapon_tweak_data().use_data.selection_index then
		self:_update_second_weapon_ammo_info(HUDManager.PLAYER_PANEL, unit)
	end
end

function HUDManager:_update_second_weapon_ammo_info(i, unit)
end

function HUDManager:set_player_health(data)
	self:set_teammate_health(HUDManager.PLAYER_PANEL, data)
end

function HUDManager:set_teammate_health(i, data)
	self._teammate_panels[i]:set_health(data)
end

function HUDManager:set_player_armor(data)
	if data.current == 0 and not data.no_hint then
		managers.hint:show_hint("damage_pad")
	end
	self:set_teammate_armor(HUDManager.PLAYER_PANEL, data)
end

function HUDManager:set_teammate_armor(i, data)
	self._teammate_panels[i]:set_armor(data)
end

function HUDManager:set_teammate_name(i, teammate_name)
	self._teammate_panels[i]:set_name(teammate_name)
end

function HUDManager:set_teammate_callsign(i, id)
	self._teammate_panels[i]:set_callsign(id)
end

function HUDManager:set_cable_tie(i, data)
	self._teammate_panels[i]:set_cable_tie(data)
end

function HUDManager:set_cable_ties_amount(i, amount)
	self._teammate_panels[i]:set_cable_ties_amount(amount)
end

function HUDManager:set_teammate_state(i, state)
	self._teammate_panels[i]:set_state(state)
end

function HUDManager:add_special_equipment(data)
	self:add_teammate_special_equipment(HUDManager.PLAYER_PANEL, data)
end

function HUDManager:add_teammate_special_equipment(i, data)
	if not i then
		print("[HUDManager:add_teammate_special_equipment] - Didn't get a number")
		Application:stack_dump()
		return
	end
	self._teammate_panels[i]:add_special_equipment(data)
end

function HUDManager:remove_special_equipment(equipment)
	self:remove_teammate_special_equipment(HUDManager.PLAYER_PANEL, equipment)
end

function HUDManager:remove_teammate_special_equipment(panel_id, equipment)
	self._teammate_panels[panel_id]:remove_special_equipment(equipment)
end

function HUDManager:set_special_equipment_amount(equipment_id, amount)
	self:set_teammate_special_equipment_amount(HUDManager.PLAYER_PANEL, equipment_id, amount)
end

function HUDManager:set_teammate_special_equipment_amount(i, equipment_id, amount)
	self._teammate_panels[i]:set_special_equipment_amount(equipment_id, amount)
end

function HUDManager:_layout_special_equipments(i)
	if not i then
		return
	end
	self._teammate_panels[i]:layout_special_equipments()
end

function HUDManager:clear_player_special_equipments()
	self._teammate_panels[HUDManager.PLAYER_PANEL]:clear_special_equipment()
end

function HUDManager:set_perk_equipment(i, data)
	self._teammate_panels[i]:set_perk_equipment(data)
end

function HUDManager:add_item(data)
	self:set_deployable_equipment(HUDManager.PLAYER_PANEL, data)
end

function HUDManager:set_deployable_equipment(i, data)
	self._teammate_panels[i]:set_deployable_equipment(data)
end

function HUDManager:set_item_amount(index, amount)
	self:set_teammate_deployable_equipment_amount(HUDManager.PLAYER_PANEL, index, {amount = amount})
end

function HUDManager:set_teammate_deployable_equipment_amount(i, index, data)
	self._teammate_panels[i]:set_deployable_equipment_amount(index, data)
end

function HUDManager:set_player_condition(icon_data, text)
	self:set_teammate_condition(HUDManager.PLAYER_PANEL, icon_data, text)
end

function HUDManager:set_teammate_condition(i, icon_data, text)
	if not i then
		print("Didn't get a number")
		Application:stack_dump()
		return
	end
	self._teammate_panels[i]:set_condition(icon_data, text)
end

function HUDManager:set_teammate_carry_info(i, carry_id, value)
	if i == HUDManager.PLAYER_PANEL then
		return
	end
	self._teammate_panels[i]:set_carry_info(carry_id, value)
end

function HUDManager:remove_teammate_carry_info(i)
	if i == HUDManager.PLAYER_PANEL then
		return
	end
	self._teammate_panels[i]:remove_carry_info()
end

function HUDManager:start_teammate_timer(i, time)
	self._teammate_panels[i]:start_timer(time)
end

function HUDManager:is_teammate_timer_running(i)
	return self._teammate_panels[i]:is_timer_running()
end

function HUDManager:pause_teammate_timer(i, pause)
	self._teammate_panels[i]:set_pause_timer(pause)
end

function HUDManager:stop_teammate_timer(i)
	self._teammate_panels[i]:stop_timer()
end

function HUDManager:_setup_player_info_hud_pd2()
	print("_setup_player_info_hud_pd2")
	if not self:alive(PlayerBase.PLAYER_INFO_HUD_PD2) then
		return
	end
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	hud.location_text:set_font_size(tweak_data.hud.location_font_size)
	hud.location_text:set_top(0)
	hud.location_text:set_center_x(hud.location_text:parent():w() / 2)
	self:_create_teammates_panel(hud)
	self:_create_present_panel(hud)
	self:_create_interaction(hud)
	self:_create_progress_timer(hud)
	self:_create_objectives(hud)
	self:_create_hint(hud)
	self:_create_heist_timer(hud)
	self:_create_temp_hud(hud)
	self:_create_suspicion(hud)
	self:_create_hit_confirm(hud)
	self:_create_hit_direction(hud)
	self:_create_downed_hud()
	self:_create_custody_hud()
	self:_create_hud_chat()
	self:_create_assault_corner()
end

function HUDManager:_create_ammo_test()
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	if hud.panel:child("ammo_test") then
		hud.panel:remove(hud.panel:child("ammo_test"))
	end
	local panel = hud.panel:panel({
		name = "ammo_test",
		w = 100,
		h = 4,
		x = 550,
		y = 200
	})
	panel:set_center_y(hud.panel:h() / 2 - 40)
	panel:set_center_x(hud.panel:w() / 2)
	panel:rect({
		name = "ammo_test_bg_rect",
		color = Color.black:with_alpha(0.5)
	})
	panel:rect({
		name = "ammo_test_rect",
		color = Color.white,
		layer = 1
	})
end

function HUDManager:_create_hud_chat()
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	if self._hud_chat then
		self._hud_chat:remove()
	end
	self._hud_chat = HUDChat:new(self._saferect, hud)
end

function HUDManager:_create_assault_corner()
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	local full_hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	full_hud.panel:clear()
	self._hud_assault_corner = HUDAssaultCorner:new(hud, full_hud)
end

function HUDManager:add_teammate_panel(character_name, player_name, ai, peer_id)
	for i, data in ipairs(self._hud.teammate_panels_data) do
		if not data.taken then
			self._teammate_panels[i]:add_panel()
			self._teammate_panels[i]:set_peer_id(peer_id)
			self._teammate_panels[i]:set_ai(ai)
			self:set_teammate_callsign(i, ai and 5 or peer_id)
			self:set_teammate_name(i, player_name)
			self:set_teammate_state(i, ai and "ai" or "player")
			if peer_id then
				local peer_equipment = managers.player:get_synced_equipment_possession(peer_id) or {}
				for equipment, amount in pairs(peer_equipment) do
					self:add_teammate_special_equipment(i, {
						id = equipment,
						icon = tweak_data.equipments.specials[equipment].icon,
						amount = amount
					})
				end
				local peer_deployable_equipment = managers.player:get_synced_deployable_equipment(peer_id)
				if peer_deployable_equipment then
					local icon = tweak_data.equipments[peer_deployable_equipment.deployable].icon
					self:set_deployable_equipment(i, {
						icon = icon,
						amount = peer_deployable_equipment.amount
					})
				end
				local peer_cable_ties = managers.player:get_synced_cable_ties(peer_id)
				if peer_cable_ties then
					local icon = tweak_data.equipments.specials.cable_tie.icon
					self:set_cable_tie(i, {
						icon = icon,
						amount = peer_cable_ties.amount
					})
				end
				local peer_perk = managers.player:get_synced_perk(peer_id)
				if peer_perk then
					local icon = tweak_data.upgrades.definitions[peer_perk.perk].icon
					self:set_perk_equipment(i, {icon = icon})
				end
			end
			local unit = managers.criminals:character_unit_by_name(character_name)
			if alive(unit) then
				local weapon = unit:inventory():equipped_unit()
				if alive(weapon) then
					local icon = weapon:base():weapon_tweak_data().hud_icon
					local equipped_selection = unit:inventory():equipped_selection()
					self:_set_teammate_weapon_selected(i, equipped_selection, icon)
				end
			end
			local peer_ammo_info = managers.player:get_synced_ammo_info(peer_id)
			if peer_ammo_info then
				for selection_index, ammo_info in pairs(peer_ammo_info) do
					self:set_teammate_ammo_amount(i, selection_index, unpack(ammo_info))
				end
			end
			local peer_carry_data = managers.player:get_synced_carry(peer_id)
			if peer_carry_data then
				self:set_teammate_carry_info(i, peer_carry_data.carry_id, managers.loot:get_real_value(peer_carry_data.carry_id, peer_carry_data.value))
			end
			data.taken = true
			return i
		end
	end
end

function HUDManager:remove_teammate_panel(id)
	self._teammate_panels[id]:remove_panel()
	self._hud.teammate_panels_data[id].taken = false
	local is_ai = self._teammate_panels[HUDManager.PLAYER_PANEL]._ai
	if self._teammate_panels[HUDManager.PLAYER_PANEL]._peer_id and self._teammate_panels[HUDManager.PLAYER_PANEL]._peer_id ~= managers.network:session():local_peer():id() or is_ai then
		print(" MOVE!!!", self._teammate_panels[HUDManager.PLAYER_PANEL]._peer_id, is_ai)
		local peer_id = self._teammate_panels[HUDManager.PLAYER_PANEL]._peer_id
		self:remove_teammate_panel(HUDManager.PLAYER_PANEL)
		if is_ai then
			local character_name = managers.criminals:character_name_by_panel_id(HUDManager.PLAYER_PANEL)
			local name = managers.localization:text("menu_" .. character_name)
			local panel_id = self:add_teammate_panel(character_name, name, true, nil)
			managers.criminals:character_data_by_name(character_name).panel_id = panel_id
		else
			local character_name = managers.criminals:character_name_by_peer_id(peer_id)
			local panel_id = self:add_teammate_panel(character_name, managers.network:session():peer(peer_id):name(), false, peer_id)
			managers.criminals:character_data_by_name(character_name).panel_id = panel_id
		end
	end
	managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]:add_panel()
	managers.hud._teammate_panels[HUDManager.PLAYER_PANEL]:set_state("player")
end

function HUDManager:teampanels_height()
	return 120
end

function HUDManager:_create_teammates_panel(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud.teammate_panels_data = self._hud.teammate_panels_data or {}
	self._teammate_panels = {}
	if hud.panel:child("teammates_panel") then
		hud.panel:remove(hud.panel:child("teammates_panel"))
	end
	local h = self:teampanels_height()
	local teammates_panel = hud.panel:panel({
		name = "teammates_panel",
		h = h,
		y = hud.panel:h() - h,
		valign = "bottom"
	})
	local teammate_w = 204
	local player_gap = 240
	local small_gap = (teammates_panel:w() - player_gap - teammate_w * 4) / 3
	for i = 1, 4 do
		local is_player = i == HUDManager.PLAYER_PANEL
		self._hud.teammate_panels_data[i] = {
			taken = false and is_player,
			special_equipments = {}
		}
		local pw = teammate_w + (is_player and 0 or 64)
		local teammate = HUDTeammate:new(i, teammates_panel, is_player, pw)
		local x = math.floor((pw + small_gap) * (i - 1) + (i == HUDManager.PLAYER_PANEL and player_gap or 0))
		teammate._panel:set_x(math.floor(x))
		table.insert(self._teammate_panels, teammate)
		if is_player then
			teammate:add_panel()
		end
	end
end

function HUDManager:_create_present_panel(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_presenter = HUDPresenter:new(hud)
end

function HUDManager:present(params)
	if self._hud_presenter then
		self._hud_presenter:present(params)
	end
end

function HUDManager:present_done()
end

function HUDManager:_create_interaction(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_interaction = HUDInteraction:new(hud)
end

function HUDManager:show_interact(data)
	self._hud_interaction:show_interact(data)
end

function HUDManager:remove_interact()
	if not self._hud_interaction then
		return
	end
	self._hud_interaction:remove_interact()
end

function HUDManager:show_interaction_bar(current, total)
	self._hud_interaction:show_interaction_bar(current, total)
end

function HUDManager:set_interaction_bar_width(current, total)
	self._hud_interaction:set_interaction_bar_width(current, total)
end

function HUDManager:hide_interaction_bar(complete)
	self._hud_interaction:hide_interaction_bar(complete)
end

function HUDManager:_create_progress_timer(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._progress_timer = HUDInteraction:new(hud, "progress_timer")
end

function HUDManager:show_progress_timer(data)
	self._progress_timer:show_interact(data)
end

function HUDManager:remove_progress_timer()
	self._progress_timer:remove_interact()
end

function HUDManager:show_progress_timer_bar(current, total)
	self._progress_timer:show_interaction_bar(current, total)
end

function HUDManager:set_progress_timer_bar_width(current, total)
	self._progress_timer:set_interaction_bar_width(current, total)
end

function HUDManager:set_progress_timer_bar_valid(valid, text_id)
	self._progress_timer:set_bar_valid(valid, text_id)
end

function HUDManager:hide_progress_timer_bar(complete)
	self._progress_timer:hide_interaction_bar(complete)
end

function HUDManager:set_control_info(data)
	self._hud_assault_corner:set_control_info(data)
end

function HUDManager:sync_start_assault(data)
	managers.music:post_event(tweak_data.levels:get_music_event("assault"))
	if not managers.groupai:state():get_hunt_mode() then
		managers.dialog:queue_dialog("gen_ban_b02c", {})
	end
	self._hud_assault_corner:sync_start_assault(data)
end

function HUDManager:sync_end_assault(result)
	managers.music:post_event(tweak_data.levels:get_music_event("control"))
	local result_diag = {
		"gen_ban_b12",
		"gen_ban_b11",
		"gen_ban_b10"
	}
	if result then
		managers.dialog:queue_dialog(result_diag[result + 1], {})
	end
	self._hud_assault_corner:sync_end_assault(result)
end

function HUDManager:show_casing()
	self._hud_assault_corner:show_casing()
end

function HUDManager:hide_casing()
	self._hud_assault_corner:hide_casing()
end

function HUDManager:_setup_stats_screen()
	print("HUDManager:_setup_stats_screen")
	if not self:alive(PlayerBase.PLAYER_INFO_HUD_PD2) then
		return
	end
	self._hud_statsscreen = HUDStatsScreen:new()
end

function HUDManager:show_stats_screen()
	local safe = self.STATS_SCREEN_SAFERECT
	local full = self.STATS_SCREEN_FULLSCREEN
	if not self:exists(safe) then
		self:load_hud(full, false, true, false, {})
		self:load_hud(safe, false, true, true, {})
	end
	self._hud_statsscreen:show()
	self._showing_stats_screen = true
end

function HUDManager:hide_stats_screen()
	self._showing_stats_screen = false
	if self._hud_statsscreen then
		self._hud_statsscreen:hide()
	end
end

function HUDManager:showing_stats_screen()
	return self._showing_stats_screen
end

function HUDManager:loot_value_updated()
	if self._hud_statsscreen then
		self._hud_statsscreen:loot_value_updated()
	end
end

function HUDManager:feed_point_of_no_return_timer(time, is_inside)
	self._hud_assault_corner:feed_point_of_no_return_timer(time, is_inside)
end

function HUDManager:show_point_of_no_return_timer()
	self._hud_assault_corner:show_point_of_no_return_timer()
end

function HUDManager:hide_point_of_no_return_timer()
	self._hud_assault_corner:hide_point_of_no_return_timer()
end

function HUDManager:flash_point_of_no_return_timer(beep)
	if beep then
		self._sound_source:post_event("last_10_seconds_beep")
	end
	self._hud_assault_corner:flash_point_of_no_return_timer(beep)
end

function HUDManager:_create_objectives(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_objectives = HUDObjectives:new(hud)
end

function HUDManager:activate_objective(data)
	self._hud_objectives:activate_objective(data)
end

function HUDManager:complete_sub_objective(data)
end

function HUDManager:update_amount_objective(data)
	print("HUDManager:update_amount_objective", inspect(data))
	self._hud_objectives:update_amount_objective(data)
end

function HUDManager:remind_objective(id)
	self._hud_objectives:remind_objective(id)
end

function HUDManager:complete_objective(data)
	self._hud_objectives:complete_objective(data)
end

function HUDManager:_create_hint(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_hint = HUDHint:new(hud)
end

function HUDManager:show_hint(params)
	self._hud_hint:show(params)
	if params.event then
		self._sound_source:post_event(params.event)
	end
end

function HUDManager:stop_hint()
	self._hud_hint:stop()
end

function HUDManager:_create_heist_timer(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_heist_timer = HUDHeistTimer:new(hud)
end

function HUDManager:feed_heist_time(time)
	self._hud_heist_timer:set_time(time)
end

function HUDManager:_create_temp_hud(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_temp = HUDTemp:new(hud)
end

function HUDManager:temp_show_carry_bag(carry_id, value)
	self._hud_temp:show_carry_bag(carry_id, value)
	self._sound_source:post_event("Play_bag_generic_pickup")
end

function HUDManager:temp_hide_carry_bag()
	self._hud_temp:hide_carry_bag()
	self._sound_source:post_event("Play_bag_generic_throw")
end

function HUDManager:set_stamina_value(value)
	self._hud_temp:set_stamina_value(value)
end

function HUDManager:set_max_stamina(value)
	self._hud_temp:set_max_stamina(value)
end

function HUDManager:_create_suspicion(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_suspicion = HUDSuspicion:new(hud, self._sound_source)
end

function HUDManager:set_suspicion(status)
	if type(status) == "boolean" then
		if status then
			self._hud_suspicion:discovered()
		else
			self._hud_suspicion:back_to_stealth()
		end
	else
		self._hud_suspicion:feed_value(status)
	end
end

function HUDManager:_create_hit_confirm(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_hit_confirm = HUDHitConfirm:new(hud)
end

function HUDManager:on_hit_confirmed()
	if not managers.user:get_setting("hit_indicator") then
		return
	end
	self._hud_hit_confirm:on_hit_confirmed()
end

function HUDManager:_create_hit_direction(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_hit_direction = HUDHitDirection:new(hud)
end

function HUDManager:on_hit_direction(dir)
	self._hud_hit_direction:on_hit_direction(dir)
end

function HUDManager:_create_downed_hud(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_DOWNED_HUD)
	self._hud_player_downed = HUDPlayerDowned:new(hud)
end

function HUDManager:on_downed()
	self._hud_player_downed:on_downed()
end

function HUDManager:on_arrested()
	self._hud_player_downed:on_arrested()
end

function HUDManager:_create_custody_hud(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_CUSTODY_HUD)
	self._hud_player_custody = HUDPlayerCustody:new(hud)
end

function HUDManager:set_custody_respawn_time(time)
	self._hud_player_custody:set_respawn_time(time)
end

function HUDManager:set_custody_timer_visibility(visible)
	self._hud_player_custody:set_timer_visibility(visible)
end

function HUDManager:set_custody_civilians_killed(amount)
	self._hud_player_custody:set_civilians_killed(amount)
end

function HUDManager:set_custody_trade_delay(time)
	self._hud_player_custody:set_trade_delay(time)
end

function HUDManager:set_custody_trade_delay_visible(visible)
	self._hud_player_custody:set_trade_delay_visible(visible)
end

function HUDManager:set_custody_negotiating_visible(visible)
	self._hud_player_custody:set_negotiating_visible(visible)
end

function HUDManager:set_custody_can_be_trade_visible(visible)
	self._hud_player_custody:set_can_be_trade_visible(visible)
end

function HUDManager:_add_name_label(data)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	local last_id = self._hud.name_labels[#self._hud.name_labels] and self._hud.name_labels[#self._hud.name_labels].id or 0
	local id = last_id + 1
	local character_name = data.name
	local peer_id
	local is_husk_player = data.unit:base().is_husk_player
	if is_husk_player then
		peer_id = data.unit:network():peer():id()
		local level = data.unit:network():peer():level()
		data.name = data.name .. " [" .. level .. "]"
	end
	local panel = hud.panel:panel({
		name = "name_label" .. id
	})
	local radius = 24
	local interact = CircleBitmapGuiObject:new(panel, {
		use_bg = true,
		radius = radius,
		blend_mode = "add",
		color = Color.white,
		layer = 0
	})
	interact:set_visible(false)
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bag_rect = {
		2,
		34,
		20,
		17
	}
	local color_id = managers.criminals:character_color_id_by_unit(data.unit)
	local crim_color = tweak_data.chat_colors[color_id]
	local bag = panel:bitmap({
		name = "bag",
		texture = tabs_texture,
		texture_rect = bag_rect,
		visible = false,
		layer = 0,
		color = (crim_color * 1.1):with_alpha(1),
		x = 1,
		y = 1
	})
	local text = panel:text({
		name = "text",
		text = utf8.to_upper(data.name),
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = crim_color,
		align = "right",
		vertical = "top",
		layer = -1,
		w = 256,
		h = 18
	})
	local action = panel:text({
		name = "action",
		rotation = 360,
		visible = false,
		text = utf8.to_upper("Fixing"),
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = (crim_color * 1.1):with_alpha(1),
		align = "left",
		vertical = "bottom",
		layer = -1,
		w = 256,
		h = 18
	})
	local _, _, w, h = text:text_rect()
	h = math.max(h, radius * 2)
	panel:set_size(w + 4 + radius * 2, h)
	text:set_size(panel:size())
	action:set_size(panel:size())
	action:set_x(radius * 2 + 4)
	panel:set_w(panel:w() + bag:w() + 4)
	bag:set_right(panel:w())
	bag:set_y(4)
	table.insert(self._hud.name_labels, {
		movement = data.unit:movement(),
		panel = panel,
		text = text,
		id = id,
		peer_id = peer_id,
		character_name = character_name,
		interact = interact,
		bag = bag
	})
	return id
end

function HUDManager:_remove_name_label(id)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	if not hud then
		return
	end
	for i, data in ipairs(self._hud.name_labels) do
		if data.id == id then
			hud.panel:remove(data.panel)
			table.remove(self._hud.name_labels, i)
			break
		end
	end
end

function HUDManager:_name_label_by_peer_id(peer_id)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	if not hud then
		return
	end
	for i, data in ipairs(self._hud.name_labels) do
		if data.peer_id == peer_id then
			return data
		end
	end
end

function HUDManager:set_name_label_carry_info(peer_id, carry_id, value)
	local name_label = self:_name_label_by_peer_id(peer_id)
	if name_label then
		name_label.panel:child("bag"):set_visible(true)
	end
end

function HUDManager:remove_name_label_carry_info(peer_id)
	local name_label = self:_name_label_by_peer_id(peer_id)
	if name_label then
		name_label.panel:child("bag"):set_visible(false)
	end
end

function HUDManager:teammate_progress(peer_id, type_index, enabled, tweak_data_id, timer, success)
	local name_label = self:_name_label_by_peer_id(peer_id)
	if name_label then
		name_label.interact:set_visible(enabled)
		name_label.panel:child("action"):set_visible(enabled)
		local action_text = ""
		if type_index == 1 then
			action_text = managers.localization:text(tweak_data.interaction[tweak_data_id].action_text_id or "hud_action_generic")
		elseif type_index == 2 then
			if enabled then
				local equipment_name = managers.localization:text(tweak_data.equipments[tweak_data_id].text_id)
				action_text = managers.localization:text("hud_deploying_equipment", {EQUIPMENT = equipment_name})
			end
		elseif type_index == 3 then
			action_text = managers.localization:text("hud_starting_heist")
		end
		name_label.panel:child("action"):set_text(utf8.to_upper(action_text))
		name_label.panel:stop()
		if enabled then
			name_label.panel:animate(callback(self, self, "_animate_label_interact"), name_label.interact, timer)
		elseif success then
			local panel = name_label.panel
			local bitmap = panel:bitmap({
				rotation = 360,
				texture = "guis/textures/pd2/hud_progress_active",
				blend_mode = "add",
				align = "center",
				valign = "center",
				layer = 2
			})
			bitmap:set_size(name_label.interact:size())
			bitmap:set_position(name_label.interact:position())
			local radius = name_label.interact:radius()
			local circle = CircleBitmapGuiObject:new(panel, {
				rotation = 360,
				radius = radius,
				color = Color.white:with_alpha(1),
				blend_mode = "normal",
				layer = 3
			})
			circle:set_position(name_label.interact:position())
			bitmap:animate(callback(HUDInteraction, HUDInteraction, "_animate_interaction_complete"), circle)
		end
	end
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)
	if character_data then
		self._teammate_panels[character_data.panel_id]:teammate_progress(enabled, tweak_data_id, timer, success)
	end
end

function HUDManager:_animate_label_interact(panel, interact, timer)
	local t = 0
	while timer >= t do
		local dt = coroutine.yield()
		t = t + dt
		interact:set_current(t / timer)
	end
	interact:set_current(1)
end

function HUDManager:toggle_chatinput()
	self:set_chat_focus(true)
end

function HUDManager:chat_focus()
	return self._chat_focus
end

function HUDManager:set_chat_focus(focus)
	if not self:alive(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2) then
		return
	end
	if self._chat_focus == focus then
		return
	end
	setup:add_end_frame_callback(function()
		self._chat_focus = focus
	end)
	self._chatinput_changed_callback_handler:dispatch(focus)
	if focus then
		self._hud_chat:_on_focus()
	else
		self._hud_chat:_loose_focus()
	end
end

function HUDManager:setup_access_camera_hud()
	local hud = managers.hud:script(IngameAccessCamera.GUI_SAFERECT)
	local full_hud = managers.hud:script(IngameAccessCamera.GUI_FULLSCREEN)
	self._hud_access_camera = HUDAccessCamera:new(hud, full_hud)
end

function HUDManager:set_access_camera_name(name)
	self._hud_access_camera:set_camera_name(name)
end

function HUDManager:set_access_camera_destroyed(destroyed, no_feed)
	self._hud_access_camera:set_destroyed(destroyed, no_feed)
end

function HUDManager:start_access_camera()
	self._hud_access_camera:start()
end

function HUDManager:stop_access_camera()
	self._hud_access_camera:stop()
end

function HUDManager:access_camera_track(i, cam, pos)
	self._hud_access_camera:draw_marker(i, self._workspace:world_to_screen(cam, pos))
end

function HUDManager:access_camera_track_max_amount(amount)
	self._hud_access_camera:max_markers(amount)
end

function HUDManager:setup_blackscreen_hud()
	local hud = managers.hud:script(IngameWaitingForPlayersState.LEVEL_INTRO_GUI)
	self._hud_blackscreen = HUDBlackScreen:new(hud)
end

function HUDManager:set_blackscreen_mid_text(...)
	self._hud_blackscreen:set_mid_text(...)
end

function HUDManager:blackscreen_fade_in_mid_text()
	self._hud_blackscreen:fade_in_mid_text()
end

function HUDManager:blackscreen_fade_out_mid_text()
	self._hud_blackscreen:fade_out_mid_text()
end

function HUDManager:set_blackscreen_job_data()
	self._hud_blackscreen:set_job_data()
end

function HUDManager:set_blackscreen_skip_circle(current, total)
	self._hud_blackscreen:set_skip_circle(current, total)
end

function HUDManager:blackscreen_skip_circle_done()
	self._hud_blackscreen:skip_circle_done()
end

function HUDManager:setup_mission_briefing_hud()
	local hud = managers.hud:script(IngameWaitingForPlayersState.GUI_FULLSCREEN)
	self._hud_mission_briefing = HUDMissionBriefing:new(hud, self._fullscreen_workspace)
end

function HUDManager:hide_mission_briefing_hud()
	if self._hud_mission_briefing then
		self._hud_mission_briefing:hide()
	end
end

function HUDManager:layout_mission_briefing_hud()
	if self._hud_mission_briefing then
		self._hud_mission_briefing:update_layout()
	end
end

function HUDManager:set_player_slot(nr, params)
	self._hud_mission_briefing:set_player_slot(nr, params)
end

function HUDManager:set_slot_joining(peer, peer_id)
	self._hud_mission_briefing:set_slot_joining(peer, peer_id)
end

function HUDManager:set_slot_ready(peer, peer_id)
	self._hud_mission_briefing:set_slot_ready(peer, peer_id)
end

function HUDManager:set_slot_not_ready(peer, peer_id)
	self._hud_mission_briefing:set_slot_not_ready(peer, peer_id)
end

function HUDManager:set_dropin_progress(peer_id, progress_percentage)
	self._hud_mission_briefing:set_dropin_progress(peer_id, progress_percentage)
end

function HUDManager:set_player_slots_kit(slot)
	self._hud_mission_briefing:set_player_slots_kit(slot)
end

function HUDManager:set_kit_selection(peer_id, category, id, slot)
	self._hud_mission_briefing:set_kit_selection(peer_id, category, id, slot)
end

function HUDManager:set_slot_voice(peer, peer_id, active)
	self._hud_mission_briefing:set_slot_voice(peer, peer_id, active)
end

function HUDManager:remove_player_slot_by_peer_id(peer, reason)
	self._hud_mission_briefing:remove_player_slot_by_peer_id(peer, reason)
end

function HUDManager:setup_endscreen_hud()
	local hud = managers.hud:script(MissionEndState.GUI_ENDSCREEN)
	self._hud_stage_endscreen = HUDStageEndScreen:new(hud, self._fullscreen_workspace)
end

function HUDManager:hide_endscreen_hud()
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:hide()
	end
end

function HUDManager:show_endscreen_hud()
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:show()
	end
end

function HUDManager:layout_endscreen_hud()
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:update_layout()
	end
end

function HUDManager:set_continue_button_text_endscreen_hud(text)
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:set_continue_button_text(text)
	end
end

function HUDManager:set_success_endscreen_hud(success, server_left)
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:set_success(success, server_left)
	end
end

function HUDManager:set_statistics_endscreen_hud(criminals_completed, success)
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:set_statistics(criminals_completed, success)
	end
end

function HUDManager:set_group_statistics_endscreen_hud(best_kills, best_kills_score, best_special_kills, best_special_kills_score, best_accuracy, best_accuracy_score, most_downs, most_downs_score, total_kills, total_specials_kills, total_head_shots, group_accuracy, group_downs)
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:set_group_statistics(best_kills, best_kills_score, best_special_kills, best_special_kills_score, best_accuracy, best_accuracy_score, most_downs, most_downs_score, total_kills, total_specials_kills, total_head_shots, group_accuracy, group_downs)
	end
end

function HUDManager:send_xp_data_endscreen_hud(data, done_clbk)
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:send_xp_data(data, done_clbk)
	end
end

function HUDManager:update_endscreen_hud(t, dt)
	if self._hud_stage_endscreen then
		self._hud_stage_endscreen:update(t, dt)
	end
end

function HUDManager:setup_lootscreen_hud()
	local hud = managers.hud:script(IngameLobbyMenuState.GUI_LOOTSCREEN)
	self._hud_lootscreen = HUDLootScreen:new(hud, self._fullscreen_workspace, self._saved_lootdrop, self._saved_selected, self._saved_card_chosen)
	self._saved_lootdrop = nil
	self._saved_selected = nil
	self._saved_card_chosen = nil
end

function HUDManager:hide_lootscreen_hud()
	if self._hud_lootscreen then
		self._hud_lootscreen:hide()
	end
end

function HUDManager:show_lootscreen_hud()
	if self._hud_lootscreen then
		self._hud_lootscreen:show()
	end
end

function HUDManager:feed_lootdrop_hud(lootdrop_data)
	if self._hud_lootscreen then
		self._hud_lootscreen:feed_lootdrop(lootdrop_data)
	else
		self._saved_lootdrop = self._saved_lootdrop or {}
		table.insert(self._saved_lootdrop, lootdrop_data)
	end
end

function HUDManager:set_selected_lootcard(peer_id, selected)
	if self._hud_lootscreen then
		self._hud_lootscreen:set_selected(peer_id, selected)
	else
		self._saved_selected = self._saved_selected or {}
		self._saved_selected[peer_id] = selected
	end
end

function HUDManager:confirm_choose_lootcard(peer_id, card_id)
	if self._hud_lootscreen then
		self._hud_lootscreen:begin_choose_card(peer_id, card_id)
	else
		self._saved_card_chosen = self._saved_card_chosen or {}
		self._saved_card_chosen[peer_id] = card_id
	end
end

function HUDManager:get_lootscreen_hud()
	return self._hud_lootscreen
end

function HUDManager:layout_lootscreen_hud()
	if self._hud_lootscreen then
		self._hud_lootscreen:update_layout()
	end
end

function HUDManager:_create_test_circle()
	if self._test_circle then
		self._test_circle:remove()
		self._test_circle = nil
	end
	self._test_circle = CircleGuiObject:new(managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel, {
		radius = 10,
		sides = 64,
		current = 10,
		total = 10
	})
	self._test_circle._circle:animate(callback(self, self, "_animate_test_circle"))
end
