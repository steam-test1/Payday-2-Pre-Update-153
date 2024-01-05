require("lib/managers/menu/SkillTreeGui")
require("lib/managers/menu/BlackMarketGui")
require("lib/managers/menu/MissionBriefingGui")
require("lib/managers/menu/StageEndScreenGui")
require("lib/managers/menu/LootDropScreenGUI")
require("lib/managers/menu/CrimeNetContractGui")
require("lib/managers/menu/CrimeNetFiltersGui")
require("lib/managers/menu/MenuSceneGui")
require("lib/managers/menu/PlayerProfileGuiObject")
require("lib/managers/menu/IngameContractGui")
require("lib/managers/menu/IngameManualGui")
MenuComponentManager = MenuComponentManager or class()

function MenuComponentManager:init()
	self._ws = Overlay:gui():create_screen_workspace()
	self._fullscreen_ws = managers.gui_data:create_fullscreen_16_9_workspace()
	managers.gui_data:layout_workspace(self._ws)
	self._main_panel = self._ws:panel():panel()
	self._cached_textures = {}
	self._requested_textures = {}
	self._removing_textures = {}
	self._requested_index = {}
	self._REFRESH_FRIENDS_TIME = 5
	self._refresh_friends_t = TimerManager:main():time() + self._REFRESH_FRIENDS_TIME
	self._sound_source = SoundDevice:create_source("MenuComponentManager")
	self._resolution_changed_callback_id = managers.viewport:add_resolution_changed_func(callback(self, self, "resolution_changed"))
	self._request_done_clbk_func = callback(self, self, "_request_done_callback")
	self._active_components = {}
	self._active_components.news = {
		create = callback(self, self, "_create_newsfeed_gui"),
		close = callback(self, self, "close_newsfeed_gui")
	}
	self._active_components.profile = {
		create = callback(self, self, "_create_profile_gui"),
		close = callback(self, self, "_disable_profile_gui")
	}
	self._active_components.friends = {
		create = callback(self, self, "_create_friends_gui"),
		close = callback(self, self, "_disable_friends_gui")
	}
	self._active_components.chats = {
		create = callback(self, self, "_create_chat_gui"),
		close = callback(self, self, "_disable_chat_gui")
	}
	self._active_components.lobby_chats = {
		create = callback(self, self, "_create_lobby_chat_gui"),
		close = callback(self, self, "hide_lobby_chat_gui")
	}
	self._active_components.contract = {
		create = callback(self, self, "_create_contract_gui"),
		close = callback(self, self, "_disable_contract_gui")
	}
	self._active_components.server_info = {
		create = callback(self, self, "_create_server_info_gui"),
		close = callback(self, self, "_disable_server_info_gui")
	}
	self._active_components.debug_strings = {
		create = callback(self, self, "_create_debug_strings_gui"),
		close = callback(self, self, "_disable_debug_strings_gui")
	}
	self._active_components.debug_fonts = {
		create = callback(self, self, "_create_debug_fonts_gui"),
		close = callback(self, self, "_disable_debug_fonts_gui")
	}
	self._active_components.skilltree = {
		create = callback(self, self, "_create_skilltree_gui"),
		close = callback(self, self, "close_skilltree_gui")
	}
	self._active_components.crimenet = {
		create = callback(self, self, "_create_crimenet_gui"),
		close = callback(self, self, "close_crimenet_gui")
	}
	self._active_components.crimenet_contract = {
		create = callback(self, self, "_create_crimenet_contract_gui"),
		close = callback(self, self, "close_crimenet_contract_gui")
	}
	self._active_components.crimenet_filters = {
		create = callback(self, self, "_create_crimenet_filters_gui"),
		close = callback(self, self, "close_crimenet_filters_gui")
	}
	self._active_components.blackmarket = {
		create = callback(self, self, "_create_blackmarket_gui"),
		close = callback(self, self, "close_blackmarket_gui")
	}
	self._active_components.mission_briefing = {
		create = callback(self, self, "_create_mission_briefing_gui"),
		close = callback(self, self, "_hide_mission_briefing_gui")
	}
	self._active_components.stage_endscreen = {
		create = callback(self, self, "_create_stage_endscreen_gui"),
		close = callback(self, self, "_hide_stage_endscreen_gui")
	}
	self._active_components.lootdrop = {
		create = callback(self, self, "_create_lootdrop_gui"),
		close = callback(self, self, "_hide_lootdrop_gui")
	}
	self._active_components.menuscene_info = {
		create = callback(self, self, "_create_menuscene_info_gui"),
		close = callback(self, self, "_close_menuscene_info_gui")
	}
	self._active_components.player_profile = {
		create = callback(self, self, "_create_player_profile_gui"),
		close = callback(self, self, "close_player_profile_gui")
	}
	self._active_components.ingame_contract = {
		create = callback(self, self, "_create_ingame_contract_gui"),
		close = callback(self, self, "close_ingame_contract_gui")
	}
	self._active_components.ingame_manual = {
		create = callback(self, self, "_create_ingame_manual_gui"),
		close = callback(self, self, "close_ingame_manual_gui")
	}
end

function MenuComponentManager:resolution_changed()
	managers.gui_data:layout_workspace(self._ws)
	managers.gui_data:layout_fullscreen_16_9_workspace(self._fullscreen_ws)
	if self._tcst then
		managers.gui_data:layout_fullscreen_16_9_workspace(self._tcst)
	end
end

function MenuComponentManager:set_active_components(components, node)
	local to_close = {}
	for component, _ in pairs(self._active_components) do
		to_close[component] = true
	end
	for _, component in ipairs(components) do
		if self._active_components[component] then
			to_close[component] = nil
			self._active_components[component].create(node)
		end
	end
	for component, _ in pairs(to_close) do
		self._active_components[component]:close()
	end
end

function MenuComponentManager:on_job_updated()
	if self._contract_gui then
		self._contract_gui:refresh()
	end
end

function MenuComponentManager:update(t, dt)
	if table.size(self._removing_textures) > 0 then
		for key, texture_ids in pairs(self._removing_textures) do
			if self._cached_textures[key] and self._cached_textures[key] ~= 0 then
				Application:error("[MenuComponentManager] update(): Still holds references of texture!", texture_ids, self._cached_textures[key])
			end
			self._cached_textures[key] = nil
			self._requested_textures[key] = nil
			self._requested_index[key] = nil
			TextureCache:unretrieve(texture_ids)
		end
		self._removing_textures = {}
	end
	self:_update_newsfeed_gui(t, dt)
	if t > self._refresh_friends_t then
		self:_update_friends_gui()
		self._refresh_friends_t = t + self._REFRESH_FRIENDS_TIME
	end
	if self._lobby_profile_gui then
		self._lobby_profile_gui:update(t, dt)
	end
	if self._profile_gui then
		self._profile_gui:update(t, dt)
	end
	if self._view_character_profile_gui then
		self._view_character_profile_gui:update(t, dt)
	end
	if self._contract_gui then
		self._contract_gui:update(t, dt)
	end
	if self._menuscene_info_gui then
		self._menuscene_info_gui:update(t, dt)
	end
	if self._crimenet_contract_gui then
		self._crimenet_contract_gui:update(t, dt)
	end
	if self._lootdrop_gui then
		self._lootdrop_gui:update(t, dt)
	end
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:update(t, dt)
	end
	if self._mission_briefing_gui then
		self._mission_briefing_gui:update(t, dt)
	end
	if self._ingame_manual_gui then
		self._ingame_manual_gui:update(t, dt)
	end
end

function MenuComponentManager:accept_input(accept)
	if not self._weapon_text_box then
		return
	end
	if not accept then
		self._weapon_text_box:release_scroll_bar()
	end
end

function MenuComponentManager:input_focus()
	if managers.system_menu and managers.system_menu:is_active() and not managers.system_menu:is_closing() then
		return true
	end
	if self._game_chat_gui then
		local input_focus = self._game_chat_gui:input_focus()
		if input_focus == true then
			return self._lobby_chat_gui_active or false
		elseif input_focus == 1 then
			return 1
		end
	end
	if self._skilltree_gui and self._skilltree_gui:input_focus() then
		return 1
	end
	if self._blackmarket_gui then
		return self._blackmarket_gui:input_focus()
	end
	if self._mission_briefing_gui then
		return self._mission_briefing_gui:input_focus()
	end
	if self._stage_endscreen_gui then
		return self._stage_endscreen_gui:input_focus()
	end
	if self._crimenet_gui then
		return self._crimenet_gui:input_focus()
	end
	if self._lootdrop_gui then
		return self._lootdrop_gui:input_focus()
	end
	if self._ingame_manual_gui then
		return self._ingame_manual_gui:input_focus()
	end
end

function MenuComponentManager:scroll_up()
	if not self._weapon_text_box then
		return
	end
	self._weapon_text_box:scroll_up()
	if self._mission_briefing_gui and self._mission_briefing_gui:scroll_up() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:scroll_up() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:scroll_up() then
		return true
	end
end

function MenuComponentManager:scroll_down()
	if not self._weapon_text_box then
		return
	end
	self._weapon_text_box:scroll_down()
	if self._mission_briefing_gui and self._mission_briefing_gui:scroll_down() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:scroll_down() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:scroll_down() then
		return true
	end
end

function MenuComponentManager:move_up()
	if self._skilltree_gui and self._skilltree_gui:move_up() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_up() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_up() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_up() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_up() then
		return true
	end
end

function MenuComponentManager:move_down()
	if self._skilltree_gui and self._skilltree_gui:move_down() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_down() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_down() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_down() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_down() then
		return true
	end
end

function MenuComponentManager:move_left()
	if self._skilltree_gui and self._skilltree_gui:move_left() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_left() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_left() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_left() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_left() then
		return true
	end
end

function MenuComponentManager:move_right()
	if self._skilltree_gui and self._skilltree_gui:move_right() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:move_right() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:move_right() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:move_right() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:move_right() then
		return true
	end
end

function MenuComponentManager:next_page()
	if self._skilltree_gui and self._skilltree_gui:next_page(true) then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:next_page() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:next_page() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:next_page() then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:next_page() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:next_page() then
		return true
	end
	if self._ingame_manual_gui and self._ingame_manual_gui:next_page() then
		return true
	end
end

function MenuComponentManager:previous_page()
	if self._skilltree_gui and self._skilltree_gui:previous_page(true) then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:previous_page() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:previous_page() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:previous_page() then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:previous_page() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:previous_page() then
		return true
	end
	if self._ingame_manual_gui and self._ingame_manual_gui:previous_page() then
		return true
	end
end

function MenuComponentManager:confirm_pressed()
	if self._skilltree_gui and self._skilltree_gui:confirm_pressed() then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:confirm_pressed() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:confirm_pressed() then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:confirm_pressed() then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:confirm_pressed() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:confirm_pressed() then
		return true
	end
	if Application:production_build() and self._debug_font_gui then
		self._debug_font_gui:toggle()
	end
end

function MenuComponentManager:back_pressed()
	if self._mission_briefing_gui and self._mission_briefing_gui:back_pressed() then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:back_pressed() then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:back_pressed() then
		return true
	end
end

function MenuComponentManager:special_btn_pressed(...)
	if self._skilltree_gui and self._skilltree_gui:special_btn_pressed(...) then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:special_btn_pressed(...) then
		return true
	end
	if self._crimenet_contract_gui and self._crimenet_contract_gui:special_btn_pressed(...) then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:special_btn_pressed(...) then
		return true
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:special_btn_pressed(...) then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:special_btn_pressed(...) then
		return true
	end
end

function MenuComponentManager:mouse_pressed(o, button, x, y)
	if self._skilltree_gui and self._skilltree_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._blackmarket_gui and self._blackmarket_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._game_chat_gui and self._game_chat_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._newsfeed_gui and self._newsfeed_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._profile_gui then
		if self._profile_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._profile_gui:check_minimize(x, y) then
				local minimized_data = {
					text = "PROFILE",
					help_text = "MAXIMIZE PROFILE WINDOW"
				}
				self._profile_gui:set_minimized(true, minimized_data)
				return true
			end
			if self._profile_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._profile_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._profile_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._contract_gui then
		if self._contract_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._contract_gui:check_minimize(x, y) then
				local minimized_data = {
					text = "CONTRACT",
					help_text = "MAXIMIZE CONTRACT WINDOW"
				}
				self._contract_gui:set_minimized(true, minimized_data)
				return true
			end
			if self._contract_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._contract_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._contract_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._server_info_gui then
		if self._server_info_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._server_info_gui:check_minimize(x, y) then
				local minimized_data = {
					text = "SERVER INFO",
					help_text = "MAXIMIZE SERVER INFO WINDOW"
				}
				self._server_info_gui:set_minimized(true, minimized_data)
				return true
			end
			if self._server_info_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._server_info_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._server_info_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._lobby_profile_gui then
		if self._lobby_profile_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._lobby_profile_gui:check_minimize(x, y) then
				return true
			end
			if self._lobby_profile_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._lobby_profile_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._lobby_profile_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._mission_briefing_gui and self._mission_briefing_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._stage_endscreen_gui and self._stage_endscreen_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._lootdrop_gui and self._lootdrop_gui:mouse_pressed(button, x, y) then
		return true
	end
	if self._view_character_profile_gui then
		if self._view_character_profile_gui:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._view_character_profile_gui:check_minimize(x, y) then
				return true
			end
			if self._view_character_profile_gui:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._view_character_profile_gui:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._view_character_profile_gui:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._test_profile1 then
		if self._test_profile1:check_grab_scroll_bar(x, y) then
			return true
		end
		if self._test_profile2:check_grab_scroll_bar(x, y) then
			return true
		end
		if self._test_profile3:check_grab_scroll_bar(x, y) then
			return true
		end
		if self._test_profile4:check_grab_scroll_bar(x, y) then
			return true
		end
	end
	if self._crimenet_contract_gui and self._crimenet_contract_gui:mouse_pressed(o, button, x, y) then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:mouse_pressed(o, button, x, y) then
		return true
	end
	if self._minimized_list and button == Idstring("0") then
		for i, data in ipairs(self._minimized_list) do
			if data.panel:inside(x, y) then
				data.callback(data)
				break
			end
		end
	end
	if self._friends_book then
		if self._friends_book:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._friends_book:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._friends_book:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._friends_book:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._debug_strings_book then
		if self._debug_strings_book:mouse_pressed(button, x, y) then
			return true
		end
		if button == Idstring("0") then
			if self._debug_strings_book:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._debug_strings_book:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._debug_strings_book:mouse_wheel_up(x, y) then
			return true
		end
	end
	if self._weapon_text_box then
		if button == Idstring("0") then
			if self._weapon_text_box:check_close(x, y) then
				self:close_weapon_box()
				return true
			end
			if self._weapon_text_box:check_minimize(x, y) then
				self._weapon_text_box:set_visible(false)
				self._weapon_text_minimized_id = self:add_minimized({
					callback = callback(self, self, "_maximize_weapon_box"),
					text = "WEAPON"
				})
				return true
			end
			if self._weapon_text_box:check_grab_scroll_bar(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel down") then
			if self._weapon_text_box:mouse_wheel_down(x, y) then
				return true
			end
		elseif button == Idstring("mouse wheel up") and self._weapon_text_box:mouse_wheel_up(x, y) then
			return true
		end
	end
end

function MenuComponentManager:mouse_clicked(o, button, x, y)
	if self._blackmarket_gui then
		return self._blackmarket_gui:mouse_clicked(o, button, x, y)
	end
end

function MenuComponentManager:mouse_double_click(o, button, x, y)
	if self._blackmarket_gui then
		return self._blackmarket_gui:mouse_double_click(o, button, x, y)
	end
end

function MenuComponentManager:mouse_released(o, button, x, y)
	if self._game_chat_gui and self._game_chat_gui:mouse_released(o, button, x, y) then
		return true
	end
	if self._crimenet_gui and self._crimenet_gui:mouse_released(o, button, x, y) then
		return true
	end
	if self._blackmarket_gui then
		return self._blackmarket_gui:mouse_released(button, x, y)
	end
	if self._friends_book and self._friends_book:release_scroll_bar() then
		return true
	end
	if self._skilltree_gui and self._skilltree_gui:mouse_released(button, x, y) then
		return true
	end
	if self._debug_strings_book and self._debug_strings_book:release_scroll_bar() then
		return true
	end
	if self._chat_book then
		local used, pointer = self._chat_book:release_scroll_bar()
		if used then
			return true, pointer
		end
	end
	if self._profile_gui and self._profile_gui:release_scroll_bar() then
		return true
	end
	if self._contract_gui and self._contract_gui:release_scroll_bar() then
		return true
	end
	if self._server_info_gui and self._server_info_gui:release_scroll_bar() then
		return true
	end
	if self._lobby_profile_gui and self._lobby_profile_gui:release_scroll_bar() then
		return true
	end
	if self._view_character_profile_gui and self._view_character_profile_gui:release_scroll_bar() then
		return true
	end
	if self._test_profile1 then
		if self._test_profile1:release_scroll_bar() then
			return true
		end
		if self._test_profile2:release_scroll_bar() then
			return true
		end
		if self._test_profile3:release_scroll_bar() then
			return true
		end
		if self._test_profile4:release_scroll_bar() then
			return true
		end
	end
	if self._weapon_text_box and self._weapon_text_box:release_scroll_bar() then
		return true
	end
	return false
end

function MenuComponentManager:mouse_moved(o, x, y)
	local wanted_pointer = "arrow"
	if self._skilltree_gui then
		local used, pointer = self._skilltree_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._blackmarket_gui then
		local used, pointer = self._blackmarket_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._crimenet_contract_gui then
		local used, pointer = self._crimenet_contract_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._crimenet_gui then
		local used, pointer = self._crimenet_gui:mouse_moved(o, x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._friends_book then
		local used, pointer = self._friends_book:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._friends_book:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._debug_strings_book then
		local used, pointer = self._debug_strings_book:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._debug_strings_book:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._game_chat_gui then
		local used, pointer = self._game_chat_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._profile_gui then
		local used, pointer = self._profile_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._profile_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._contract_gui then
		local used, pointer = self._contract_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._contract_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._server_info_gui then
		local used, pointer = self._server_info_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._server_info_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._backdrop_gui then
		local used, pointer = self._backdrop_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._mission_briefing_gui then
		local used, pointer = self._mission_briefing_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._stage_endscreen_gui then
		local used, pointer = self._stage_endscreen_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._lootdrop_gui then
		local used, pointer = self._lootdrop_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._lobby_profile_gui then
		local used, pointer = self._lobby_profile_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._lobby_profile_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._view_character_profile_gui then
		local used, pointer = self._view_character_profile_gui:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._view_character_profile_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
		if used then
			return true, wanted_pointer
		end
	end
	if self._test_profile1 then
		local used, pointer = self._test_profile1:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._test_profile2:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._test_profile3:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
		local used, pointer = self._test_profile4:moved_scroll_bar(x, y)
		if used then
			return true, pointer
		end
	end
	if self._newsfeed_gui then
		local _, pointer = self._newsfeed_gui:mouse_moved(x, y)
		wanted_pointer = pointer or wanted_pointer
	end
	if self._minimized_list then
		for i, data in ipairs(self._minimized_list) do
			if data.mouse_over ~= data.panel:inside(x, y) then
				data.mouse_over = data.panel:inside(x, y)
				data.text:set_font(data.mouse_over and tweak_data.menu.default_font_no_outline_id or Idstring(tweak_data.menu.default_font))
				data.text:set_color(data.mouse_over and Color.black or Color.white)
				data.selected:set_visible(data.mouse_over)
				data.help_text:set_visible(data.mouse_over)
			end
			data.help_text:set_position(x + 12, y + 12)
		end
	end
	if self._weapon_text_box and self._weapon_text_box:moved_scroll_bar(x, y) then
		return true, wanted_pointer
	end
	return false, wanted_pointer
end

function MenuComponentManager:on_peer_removed(peer, reason)
	if self._lootdrop_gui then
		self._lootdrop_gui:on_peer_removed(peer, reason)
	end
end

function MenuComponentManager:_create_crimenet_contract_gui(node)
	self:close_crimenet_contract_gui()
	self._crimenet_contract_gui = CrimeNetContractGui:new(self._ws, self._fullscreen_ws, node)
	self:disable_crimenet()
end

function MenuComponentManager:close_crimenet_contract_gui(...)
	if self._crimenet_contract_gui then
		self._crimenet_contract_gui:close()
		self._crimenet_contract_gui = nil
		self:enable_crimenet()
	end
end

function MenuComponentManager:_create_crimenet_filters_gui(node)
	self:close_crimenet_filters_gui()
	self._crimenet_filters_gui = CrimeNetFiltersGui:new(self._ws, self._fullscreen_ws, node)
	self:disable_crimenet()
end

function MenuComponentManager:close_crimenet_filters_gui(...)
	if self._crimenet_filters_gui then
		self._crimenet_filters_gui:close()
		self._crimenet_filters_gui = nil
		self:enable_crimenet()
	end
end

function MenuComponentManager:_create_crimenet_gui(...)
	if self._crimenet_gui then
		return
	end
	self._crimenet_gui = CrimeNetGui:new(self._ws, self._fullscreen_ws, ...)
end

function MenuComponentManager:start_crimenet_job()
	self:enable_crimenet()
	if self._crimenet_gui then
		self._crimenet_gui:start_job()
	end
end

function MenuComponentManager:enable_crimenet()
	if self._crimenet_gui then
		self._crimenet_gui:enable_crimenet()
	end
end

function MenuComponentManager:disable_crimenet()
	if self._crimenet_gui then
		self._crimenet_gui:disable_crimenet()
	end
end

function MenuComponentManager:update_crimenet_gui(t, dt)
	if self._crimenet_gui then
		self._crimenet_gui:update(t, dt)
	end
end

function MenuComponentManager:update_crimenet_job(...)
	self._crimenet_gui:update_job(...)
end

function MenuComponentManager:feed_crimenet_job_timer(...)
	self._crimenet_gui:feed_timer(...)
end

function MenuComponentManager:update_crimenet_server_job(...)
	if self._crimenet_gui then
		self._crimenet_gui:update_server_job(...)
	end
end

function MenuComponentManager:feed_crimenet_server_timer(...)
	self._crimenet_gui:feed_server_timer(...)
end

function MenuComponentManager:criment_goto_lobby(...)
	if self._crimenet_gui then
		self._crimenet_gui:goto_lobby(...)
	end
end

function MenuComponentManager:set_crimenet_players_online(amount)
	self._crimenet_gui:set_players_online(amount)
end

function MenuComponentManager:add_crimenet_gui_preset_job(id)
	self._crimenet_gui:add_preset_job(id)
end

function MenuComponentManager:add_crimenet_server_job(...)
	if self._crimenet_gui then
		self._crimenet_gui:add_server_job(...)
	end
end

function MenuComponentManager:remove_crimenet_gui_job(id)
	if self._crimenet_gui then
		self._crimenet_gui:remove_job(id)
	end
end

function MenuComponentManager:close_crimenet_gui()
	if self._crimenet_gui then
		self._crimenet_gui:close()
		self._crimenet_gui = nil
	end
end

function MenuComponentManager:create_weapon_box(w_id, params)
	local title = managers.localization:text(tweak_data.weapon[w_id].name_id)
	local text = managers.localization:text(tweak_data.weapon[w_id].description_id)
	local stats_list = {
		{
			type = "bar",
			text = "DAMAGE: 32(+6)",
			current = 32,
			total = 50
		},
		{type = "empty", h = 2},
		{
			type = "bar",
			text = "RELOAD SPEED: 4(-2)",
			current = 4,
			total = 20
		},
		{type = "empty", h = 2},
		{
			type = "bar",
			text = "RECOIL: 8 (+0)",
			current = 8,
			total = 10
		},
		{type = "empty", h = 2},
		{
			type = "condition",
			value = params.condition or 19
		},
		{type = "empty", h = 10},
		{
			type = "mods",
			list = {
				"SHORTENED BARREL",
				"SPEEDHOLSTER SLING",
				"ONMILTE TRITIUM SIGHTS"
			}
		},
		{type = "empty", h = 10}
	}
	if self._weapon_text_box then
		self._weapon_text_box:recreate_text_box(self._ws, title, text, {stats_list = stats_list}, {
			type = "weapon_stats",
			no_close_legend = true,
			use_minimize_legend = true
		})
	else
		self._weapon_text_box = TextBoxGui:new(self._ws, title, text, {stats_list = stats_list}, {
			type = "weapon_stats",
			no_close_legend = true,
			use_minimize_legend = true
		})
	end
end

function MenuComponentManager:close_weapon_box()
	if self._weapon_text_box then
		self._weapon_text_box:close()
	end
	self._weapon_text_box = nil
	if self._weapon_text_minimized_id then
		self:remove_minimized(self._weapon_text_minimized_id)
		self._weapon_text_minimized_id = nil
	end
end

function MenuComponentManager:_create_chat_gui()
	if managers.controller:get_default_wrapper_type() == "pc" and MenuCallbackHandler:is_multiplayer() then
		self._lobby_chat_gui_active = false
		if self._game_chat_gui then
			self:show_game_chat_gui()
			return
		end
		self:add_game_chat()
	end
end

function MenuComponentManager:_create_lobby_chat_gui()
	if managers.controller:get_default_wrapper_type() == "pc" and MenuCallbackHandler:is_multiplayer() then
		self._lobby_chat_gui_active = true
		if self._game_chat_gui then
			self:show_game_chat_gui()
			return
		end
		self:add_game_chat()
	end
end

function MenuComponentManager:create_chat_gui()
	self:close_chat_gui()
	local config = {
		w = 540,
		h = 220,
		x = 290,
		no_close_legend = true,
		use_minimize_legend = true,
		header_type = "fit"
	}
	self._chat_book = BookBoxGui:new(self._ws, nil, config)
	self._chat_book:set_layer(8)
	local global_gui = ChatGui:new(self._ws, "Global", "")
	global_gui:set_channel_id(ChatManager.GLOBAL)
	global_gui:set_layer(self._chat_book:layer())
	self._chat_book:add_page("Global", global_gui, false)
	self._chat_book:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end

function MenuComponentManager:add_game_chat()
	if managers.controller:get_default_wrapper_type() == "pc" then
		self._game_chat_gui = ChatGui:new(self._ws)
		if self._game_chat_params then
			self._game_chat_gui:set_params(self._game_chat_params)
			self._game_chat_params = nil
		end
	end
end

function MenuComponentManager:set_max_lines_game_chat(max_lines)
	if self._game_chat_gui then
		self._game_chat_gui:set_max_lines(max_lines)
	else
		self._game_chat_params = self._game_chat_params or {}
		self._game_chat_params.max_lines = max_lines
	end
end

function MenuComponentManager:pre_set_game_chat_leftbottom(from_left, from_bottom)
	if self._game_chat_gui then
		self._game_chat_gui:set_leftbottom(from_left, from_bottom)
	else
		self._game_chat_params = self._game_chat_params or {}
		self._game_chat_params.left = from_left
		self._game_chat_params.bottom = from_bottom
	end
end

function MenuComponentManager:remove_game_chat()
	if not self._chat_book then
		return
	end
	self._chat_book:remove_page("Game")
end

function MenuComponentManager:hide_lobby_chat_gui()
	if self._game_chat_gui and self._lobby_chat_gui_active then
		self._game_chat_gui:hide()
	end
end

function MenuComponentManager:hide_game_chat_gui()
	if self._game_chat_gui then
		self._game_chat_gui:hide()
	end
end

function MenuComponentManager:show_game_chat_gui()
	if self._game_chat_gui then
		self._game_chat_gui:show()
	end
end

function MenuComponentManager:_disable_chat_gui()
	if self._game_chat_gui and not self._lobby_chat_gui_active then
		self._game_chat_gui:set_enabled(false)
	end
end

function MenuComponentManager:close_chat_gui()
	if self._game_chat_gui then
		self._game_chat_gui:close()
		self._game_chat_gui = nil
	end
	if self._chat_book_minimized_id then
		self:remove_minimized(self._chat_book_minimized_id)
		self._chat_book_minimized_id = nil
	end
	self._game_chat_bottom = nil
	self._lobby_chat_gui_active = nil
end

function MenuComponentManager:_create_friends_gui()
	if managers.controller:get_default_wrapper_type() == "pc" then
		if self._friends_book then
			self._friends_book:set_enabled(true)
			return
		end
		self:create_friends_gui()
	end
end

function MenuComponentManager:create_friends_gui()
	self:close_friends_gui()
	self._friends_book = BookBoxGui:new(self._ws, nil, {no_close_legend = true, no_scroll_legend = true})
	self._friends_gui = FriendsBoxGui:new(self._ws, "Friends", "")
	self._friends2_gui = FriendsBoxGui:new(self._ws, "Test", "", nil, nil, "recent")
	self._friends3_gui = FriendsBoxGui:new(self._ws, "Test", "")
	self._friends_book:add_page("Friends", self._friends_gui, true)
	self._friends_book:add_page("Recent Players", self._friends2_gui)
	self._friends_book:add_page("Clan", self._friends3_gui)
	self._friends_book:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end

function MenuComponentManager:_update_friends_gui()
	if self._friends_gui then
		self._friends_gui:update_friends()
	end
end

function MenuComponentManager:_disable_friends_gui()
	if self._friends_book then
		self._friends_book:set_enabled(false)
	end
end

function MenuComponentManager:close_friends_gui()
	if self._friends_gui then
		self._friends_gui = nil
	end
	if self._friends_book then
		self._friends_book:close()
		self._friends_book = nil
	end
end

function MenuComponentManager:_create_contract_gui()
	if self._contract_gui then
		self._contract_gui:set_enabled(true)
		return
	end
	self:create_contract_gui()
end

function MenuComponentManager:create_contract_gui()
	self:close_contract_gui()
	self._contract_gui = ContractBoxGui:new(self._ws, self._fullscreen_ws)
	local peers_state = managers.menu:get_all_peers_state() or {}
	for i = 1, 4 do
		self._contract_gui:update_character_menu_state(i, peers_state[i])
	end
end

function MenuComponentManager:update_contract_character(peer_id)
	if self._contract_gui then
		self._contract_gui:update_character(peer_id)
	end
end

function MenuComponentManager:update_contract_character_menu_state(peer_id, state)
	if self._contract_gui then
		self._contract_gui:update_character_menu_state(peer_id, state)
	end
end

function MenuComponentManager:_disable_contract_gui()
	if self._contract_gui then
		self._contract_gui:set_enabled(false)
	end
end

function MenuComponentManager:close_contract_gui()
	if self._contract_gui then
		self._contract_gui:close()
		self._contract_gui = nil
	end
end

function MenuComponentManager:_create_skilltree_gui()
	self:create_skilltree_gui()
end

function MenuComponentManager:create_skilltree_gui(node)
	self:close_skilltree_gui()
	self._skilltree_gui = SkillTreeGui:new(self._ws, self._fullscreen_ws, node)
end

function MenuComponentManager:close_skilltree_gui()
	if self._skilltree_gui then
		self._skilltree_gui:close()
		self._skilltree_gui = nil
	end
end

function MenuComponentManager:on_tier_unlocked(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_tier_unlocked(...)
	end
end

function MenuComponentManager:on_skill_unlocked(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_skill_unlocked(...)
	end
end

function MenuComponentManager:on_points_spent(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_points_spent(...)
	end
end

function MenuComponentManager:_create_blackmarket_gui(node)
	self:create_blackmarket_gui(node)
end

function MenuComponentManager:create_blackmarket_gui(node)
	self:close_blackmarket_gui()
	self._blackmarket_gui = BlackMarketGui:new(self._ws, self._fullscreen_ws, node)
end

function MenuComponentManager:set_blackmarket_tab_positions()
	if self._blackmarket_gui then
		self._blackmarket_gui:set_tab_positions()
	end
end

function MenuComponentManager:close_blackmarket_gui()
	if self._blackmarket_gui then
		self._blackmarket_gui:close()
		self._blackmarket_gui = nil
	end
end

function MenuComponentManager:_create_server_info_gui()
	if self._server_info_gui then
		self:close_server_info_gui()
	end
	self:create_server_info_gui()
end

function MenuComponentManager:create_server_info_gui()
	self:close_server_info_gui()
	self._server_info_gui = ServerStatusBoxGui:new(self._ws)
	self._server_info_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end

function MenuComponentManager:_disable_server_info_gui()
	if self._server_info_gui then
		self._server_info_gui:set_enabled(false)
	end
end

function MenuComponentManager:close_server_info_gui()
	if self._server_info_gui then
		self._server_info_gui:close()
		self._server_info_gui = nil
	end
end

function MenuComponentManager:set_server_info_state(state)
	if self._server_info_gui then
		self._server_info_gui:set_server_info_state(state)
	end
end

function MenuComponentManager:_create_mission_briefing_gui(node)
	self:create_mission_briefing_gui(node)
end

function MenuComponentManager:create_mission_briefing_gui(node)
	if not self._mission_briefing_gui then
		self._mission_briefing_gui = MissionBriefingGui:new(self._ws, self._fullscreen_ws, node)
	else
		self._mission_briefing_gui:reload_loadout()
	end
	self._mission_briefing_gui:show()
end

function MenuComponentManager:_hide_mission_briefing_gui()
	self:hide_mission_briefing_gui()
end

function MenuComponentManager:hide_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:hide()
	end
end

function MenuComponentManager:show_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:show()
	end
end

function MenuComponentManager:close_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:close()
		self._mission_briefing_gui = nil
	end
end

function MenuComponentManager:set_mission_briefing_description(text_id)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:set_description_text_id(text_id)
	end
end

function MenuComponentManager:on_ready_pressed_mission_briefing_gui(ready)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:on_ready_pressed(ready)
	end
end

function MenuComponentManager:unlock_asset_mission_briefing_gui(asset_id)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:unlock_asset(asset_id)
	end
end

function MenuComponentManager:set_slot_outfit_mission_briefing_gui(slot, criminal_name, outfit)
	if self._mission_briefing_gui then
		self._mission_briefing_gui:set_slot_outfit(slot, criminal_name, outfit)
	end
end

function MenuComponentManager:create_asset_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:create_asset_tab()
	end
end

function MenuComponentManager:close_asset_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:close_asset()
	end
end

function MenuComponentManager:flash_ready_mission_briefing_gui()
	if self._mission_briefing_gui then
		self._mission_briefing_gui:flash_ready()
	end
end

function MenuComponentManager:_create_lootdrop_gui()
	print("_create_lootdrop_gui()")
	self:create_lootdrop_gui()
end

function MenuComponentManager:create_lootdrop_gui()
	if not self._lootdrop_gui then
		self._lootdrop_gui = LootDropScreenGui:new(self._ws, self._fullscreen_ws, managers.hud:get_lootscreen_hud(), self._saved_lootdrop_state)
		self._saved_lootdrop_state = nil
	end
	self:show_lootdrop_gui()
end

function MenuComponentManager:set_lootdrop_state(state)
	if self._lootdrop_gui then
		self._lootdrop_gui:set_state(state)
	else
		self._saved_lootdrop_state = state
	end
end

function MenuComponentManager:_hide_lootdrop_gui()
	self:hide_lootdrop_gui()
end

function MenuComponentManager:hide_lootdrop_gui()
	if self._lootdrop_gui then
		self._lootdrop_gui:hide()
	end
end

function MenuComponentManager:show_lootdrop_gui()
	if self._lootdrop_gui then
		self._lootdrop_gui:show()
	end
end

function MenuComponentManager:close_lootdrop_gui()
	if self._lootdrop_gui then
		self._lootdrop_gui:close()
		self._lootdrop_gui = nil
	end
end

function MenuComponentManager:lootdrop_is_now_active()
	if self._lootdrop_gui then
		self._lootdrop_gui._panel:show()
		self._lootdrop_gui._fullscreen_panel:show()
	end
end

function MenuComponentManager:_create_stage_endscreen_gui()
	self:create_stage_endscreen_gui()
end

function MenuComponentManager:create_stage_endscreen_gui()
	if not self._stage_endscreen_gui then
		self._stage_endscreen_gui = StageEndScreenGui:new(self._ws, self._fullscreen_ws)
	end
	game_state_machine:current_state():set_continue_button_text()
	self._stage_endscreen_gui:show()
	if self._endscreen_predata then
		if self._endscreen_predata.cash_summary then
			self:show_endscreen_cash_summary()
		end
		if self._endscreen_predata.stats then
			self:feed_endscreen_statistics(self._endscreen_predata.stats)
		end
		if self._endscreen_predata.continue then
			self:set_endscreen_continue_button_text(self._endscreen_predata.continue[1], self._endscreen_predata.continue[2])
		end
		self._endscreen_predata = nil
	end
end

function MenuComponentManager:_hide_stage_endscreen_gui()
	self:hide_stage_endscreen_gui()
end

function MenuComponentManager:hide_stage_endscreen_gui()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:hide()
	end
end

function MenuComponentManager:show_stage_endscreen_gui()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:show()
	end
end

function MenuComponentManager:close_stage_endscreen_gui()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:close()
		self._stage_endscreen_gui = nil
	end
end

function MenuComponentManager:show_endscreen_cash_summary()
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:show_cash_summary()
	else
		self._endscreen_predata = self._endscreen_predata or {}
		self._endscreen_predata.cash_summary = true
	end
end

function MenuComponentManager:feed_endscreen_statistics(data)
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:feed_statistics(data)
	else
		self._endscreen_predata = self._endscreen_predata or {}
		self._endscreen_predata.stats = data
	end
end

function MenuComponentManager:set_endscreen_continue_button_text(text, not_clickable)
	if self._stage_endscreen_gui then
		self._stage_endscreen_gui:set_continue_button_text(text, not_clickable)
	else
		self._endscreen_predata = self._endscreen_predata or {}
		self._endscreen_predata.continue = {text, not_clickable}
	end
end

function MenuComponentManager:_create_menuscene_info_gui(node)
	self:_close_menuscene_info_gui()
	if not self._menuscene_info_gui then
		self._menuscene_info_gui = MenuSceneGui:new(self._ws, self._fullscreen_ws, node)
	end
end

function MenuComponentManager:_close_menuscene_info_gui()
	if self._menuscene_info_gui then
		self._menuscene_info_gui:close()
		self._menuscene_info_gui = nil
	end
end

function MenuComponentManager:_create_player_profile_gui()
	self:create_player_profile_gui()
end

function MenuComponentManager:create_player_profile_gui()
	self:close_player_profile_gui()
	self._player_profile_gui = PlayerProfileGuiObject:new(self._ws)
end

function MenuComponentManager:refresh_player_profile_gui()
	if self._player_profile_gui then
		self:create_player_profile_gui()
	end
end

function MenuComponentManager:close_player_profile_gui()
	if self._player_profile_gui then
		self._player_profile_gui:close()
		self._player_profile_gui = nil
	end
end

function MenuComponentManager:_create_ingame_manual_gui()
	self:create_ingame_manual_gui()
end

function MenuComponentManager:create_ingame_manual_gui()
	self:close_ingame_manual_gui()
	self._ingame_manual_gui = IngameManualGui:new(self._ws, self._fullscreen_ws)
	self._ingame_manual_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end

function MenuComponentManager:ingame_manual_texture_done(texture_ids)
	if self._ingame_manual_gui then
		self._ingame_manual_gui:create_page(texture_ids)
	else
		local destroy_me = self._ws:panel():bitmap({
			texture = texture_ids,
			visible = false,
			w = 0,
			h = 0
		})
		destroy_me:parent():remove(destroy_me)
	end
end

function MenuComponentManager:close_ingame_manual_gui()
	if self._ingame_manual_gui then
		self._ingame_manual_gui:close()
		self._ingame_manual_gui = nil
	end
end

function MenuComponentManager:_create_ingame_contract_gui()
	self:create_ingame_contract_gui()
end

function MenuComponentManager:create_ingame_contract_gui()
	self:close_ingame_contract_gui()
	self._ingame_contract_gui = IngameContractGui:new(self._ws)
	self._ingame_contract_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end

function MenuComponentManager:close_ingame_contract_gui()
	if self._ingame_contract_gui then
		self._ingame_contract_gui:close()
		self._ingame_contract_gui = nil
	end
end

function MenuComponentManager:_create_profile_gui()
	if self._profile_gui then
		self._profile_gui:set_enabled(true)
		return
	end
	self:create_profile_gui()
end

function MenuComponentManager:create_profile_gui()
	self:close_profile_gui()
	self._profile_gui = ProfileBoxGui:new(self._ws)
	self._profile_gui:set_layer(tweak_data.gui.MENU_COMPONENT_LAYER)
end

function MenuComponentManager:_disable_profile_gui()
	if self._profile_gui then
		self._profile_gui:set_enabled(false)
	end
end

function MenuComponentManager:close_profile_gui()
	if self._profile_gui then
		self._profile_gui:close()
		self._profile_gui = nil
	end
end

function MenuComponentManager:create_test_profiles()
	self:close_test_profiles()
	self._test_profile1 = ProfileBoxGui:new(self._ws)
	self._test_profile1:set_title("")
	self._test_profile1:set_use_minimize_legend(false)
	self._test_profile2 = ProfileBoxGui:new(self._ws)
	self._test_profile2:set_title("")
	self._test_profile2:set_use_minimize_legend(false)
	self._test_profile3 = ProfileBoxGui:new(self._ws)
	self._test_profile3:set_title("")
	self._test_profile3:set_use_minimize_legend(false)
	self._test_profile4 = ProfileBoxGui:new(self._ws)
	self._test_profile4:set_title("")
	self._test_profile4:set_use_minimize_legend(false)
end

function MenuComponentManager:close_test_profiles()
	if self._test_profile1 then
		self._test_profile1:close()
		self._test_profile1 = nil
		self._test_profile2:close()
		self._test_profile2 = nil
		self._test_profile3:close()
		self._test_profile3 = nil
		self._test_profile4:close()
		self._test_profile4 = nil
	end
end

function MenuComponentManager:create_lobby_profile_gui(peer_id, x, y)
	self:close_lobby_profile_gui()
	self._lobby_profile_gui = LobbyProfileBoxGui:new(self._ws, nil, nil, nil, {
		h = 160,
		x = x,
		y = y
	}, peer_id)
	self._lobby_profile_gui:set_title(nil)
	self._lobby_profile_gui:set_use_minimize_legend(false)
end

function MenuComponentManager:close_lobby_profile_gui()
	if self._lobby_profile_gui then
		self._lobby_profile_gui:close()
		self._lobby_profile_gui = nil
	end
	if self._lobby_profile_gui_minimized_id then
		self:remove_minimized(self._lobby_profile_gui_minimized_id)
		self._lobby_profile_gui_minimized_id = nil
	end
end

function MenuComponentManager:create_view_character_profile_gui(user, x, y)
	self:close_view_character_profile_gui()
	self._view_character_profile_gui = ViewCharacterProfileBoxGui:new(self._ws, nil, nil, nil, {
		h = 160,
		w = 360,
		x = 837,
		y = 100
	}, user)
	self._view_character_profile_gui:set_title(nil)
	self._view_character_profile_gui:set_use_minimize_legend(false)
end

function MenuComponentManager:close_view_character_profile_gui()
	if self._view_character_profile_gui then
		self._view_character_profile_gui:close()
		self._view_character_profile_gui = nil
	end
	if self._view_character_profile_gui_minimized_id then
		self:remove_minimized(self._view_character_profile_gui_minimized_id)
		self._view_character_profile_gui_minimized_id = nil
	end
end

function MenuComponentManager:_create_newsfeed_gui()
	if self._newsfeed_gui then
		return
	end
	self:create_newsfeed_gui()
end

function MenuComponentManager:create_newsfeed_gui()
	self:close_newsfeed_gui()
	if SystemInfo:platform() == Idstring("WIN32") then
		self._newsfeed_gui = NewsFeedGui:new(self._ws)
	end
end

function MenuComponentManager:_update_newsfeed_gui(t, dt)
	if self._newsfeed_gui then
		self._newsfeed_gui:update(t, dt)
	end
end

function MenuComponentManager:close_newsfeed_gui()
	if self._newsfeed_gui then
		self._newsfeed_gui:close()
		self._newsfeed_gui = nil
	end
end

function MenuComponentManager:_create_debug_fonts_gui()
	if self._debug_fonts_gui then
		self._debug_fonts_gui:set_enabled(true)
		return
	end
	self:create_debug_fonts_gui()
end

function MenuComponentManager:create_debug_fonts_gui()
	self:close_debug_fonts_gui()
	self._debug_fonts_gui = DebugDrawFonts:new(self._fullscreen_ws)
end

function MenuComponentManager:_disable_debug_fonts_gui()
	if self._debug_fonts_gui then
		self._debug_fonts_gui:set_enabled(false)
	end
end

function MenuComponentManager:close_debug_fonts_gui()
	if self._debug_fonts_gui then
		self._debug_fonts_gui:close()
		self._debug_fonts_gui = nil
	end
end

function MenuComponentManager:toggle_debug_fonts_gui()
	if Application:production_build() and self._debug_fonts_gui then
		self._debug_fonts_gui:toggle_debug()
	end
end

function MenuComponentManager:reload_debug_fonts_gui()
	if self._debug_fonts_gui then
		self._debug_fonts_gui:reload()
	end
end

function MenuComponentManager:_create_debug_strings_gui()
	if self._debug_strings_book then
		self._debug_strings_book:set_enabled(true)
		return
	end
	self:create_debug_strings_gui()
end

function MenuComponentManager:create_debug_strings_gui()
	self:close_debug_strings_gui()
	self._debug_strings_book = BookBoxGui:new(self._ws, nil, {
		no_close_legend = true,
		no_scroll_legend = true,
		w = 1088,
		h = 612
	})
	self._debug_strings_book._info_box:close()
	self._debug_strings_book._info_box = nil
	for i, file_name in ipairs({
		"debug",
		"blackmarket",
		"challenges",
		"hud",
		"atmospheric_text",
		"subtitles",
		"heist",
		"menu",
		"savefile",
		"system_text",
		"systemmenu",
		"wip"
	}) do
		local gui = DebugStringsBoxGui:new(self._ws, "file", "", nil, nil, "strings/" .. file_name)
		self._debug_strings_book:add_page(file_name, gui, i == 1)
	end
	self._debug_strings_book:add_background()
	self._debug_strings_book:set_layer(tweak_data.gui.DIALOG_LAYER)
	self._debug_strings_book:set_centered()
end

function MenuComponentManager:_disable_debug_strings_gui()
	if self._debug_strings_book then
		self._debug_strings_book:set_enabled(false)
	end
end

function MenuComponentManager:close_debug_strings_gui()
	if self._debug_strings_book then
		self._debug_strings_book:close()
		self._debug_strings_book = nil
	end
end

function MenuComponentManager:_maximize_weapon_box(data)
	self._weapon_text_box:set_visible(true)
	self._weapon_text_minimized_id = nil
	self:remove_minimized(data.id)
end

function MenuComponentManager:add_minimized(config)
	self._minimized_list = self._minimized_list or {}
	self._minimized_id = (self._minimized_id or 0) + 1
	local panel = self._main_panel:panel({
		w = 100,
		h = 20,
		layer = tweak_data.gui.MENU_COMPONENT_LAYER
	})
	local text
	if config.text then
		text = panel:text({
			text = config.text,
			align = "center",
			halign = "left",
			vertical = "center",
			hvertical = "center",
			font = tweak_data.menu.default_font,
			font_size = 22,
			layer = 2
		})
		text:set_center_y(panel:center_y())
		local _, _, w, h = text:text_rect()
		text:set_size(w + 8, h)
		panel:set_size(w + 8, h)
	end
	local help_text = panel:parent():text({
		text = config.help_text or "CLICK TO MAXIMIZE WEAPON INFO",
		align = "left",
		halign = "left",
		vertical = "center",
		hvertical = "center",
		visible = false,
		font = tweak_data.menu.small_font,
		font_size = tweak_data.menu.small_font_size,
		color = Color.white,
		layer = 3
	})
	help_text:set_shape(help_text:text_rect())
	local unselected = panel:bitmap({
		texture = "guis/textures/menu_unselected",
		layer = 0
	})
	unselected:set_h(64 * panel:h() / 32)
	unselected:set_center_y(panel:center_y())
	local selected = panel:bitmap({
		texture = "guis/textures/menu_selected",
		layer = 1,
		visible = false
	})
	selected:set_h(64 * panel:h() / 32)
	selected:set_center_y(panel:center_y())
	panel:set_bottom(self._main_panel:h() - CoreMenuRenderer.Renderer.border_height)
	local top_line = panel:parent():bitmap({
		visible = false,
		texture = "guis/textures/headershadow",
		layer = 1,
		w = panel:w()
	})
	top_line:set_bottom(panel:top())
	table.insert(self._minimized_list, {
		id = self._minimized_id,
		panel = panel,
		selected = selected,
		text = text,
		help_text = help_text,
		top_line = top_line,
		callback = config.callback,
		mouse_over = false
	})
	self:_layout_minimized()
	return self._minimized_id
end

function MenuComponentManager:_layout_minimized()
	local x = 0
	for i, data in ipairs(self._minimized_list) do
		data.panel:set_x(x)
		data.top_line:set_x(x)
		x = x + data.panel:w() + 2
	end
end

function MenuComponentManager:remove_minimized(id)
	for i, data in ipairs(self._minimized_list) do
		if data.id == id then
			data.help_text:parent():remove(data.help_text)
			data.top_line:parent():remove(data.top_line)
			self._main_panel:remove(data.panel)
			table.remove(self._minimized_list, i)
			break
		end
	end
	self:_layout_minimized()
end

function MenuComponentManager:_request_done_callback(texture_ids)
	local key = texture_ids:key()
	local requests = self._requested_textures[key]
	if not requests then
		print("[MenuComponentManager] request_done_callback(): Have no requests for this texture", texture_ids)
		return
	end
	local count = self._cached_textures[key] or 0
	if self._cached_textures[key] then
		Application:error("[MenuComponentManager] request_done_callback(): Texture already in cache!", texture_ids)
		TextureCache:unretrieve(texture_ids)
	end
	for _, request_cb in pairs(requests) do
		count = count + 1
		request_cb(texture_ids)
	end
	self._cached_textures[key] = count
	self._requested_textures[key] = nil
	self._requested_index[key] = nil
end

function MenuComponentManager:request_texture(texture, done_cb)
	local texture_ids = Idstring(texture)
	local key = texture_ids:key()
	local is_removing = self._removing_textures[key] and true or false
	self._removing_textures[key] = nil
	if self._cached_textures[key] then
		self._cached_textures[key] = self._cached_textures[key] + 1
		done_cb(texture_ids)
		return
	elseif self._requested_textures[key] then
		local count = self._requested_index[key] + 1
		self._requested_index[key] = count
		self._requested_textures[key][count] = done_cb
		return count
	else
		self._requested_textures[key] = {}
		local count = 1
		self._requested_index[key] = count
		self._requested_textures[key][count] = done_cb
		if not is_removing then
			TextureCache:request(texture, "NORMAL", callback(self, self, "_request_done_callback"))
		else
			Application:debug("[MenuComponentManager] request_texture(): This code should no longer be used.")
		end
		return count
	end
end

function MenuComponentManager:unretrieve_texture(texture, index)
	local texture_ids = Idstring(texture)
	local key = texture_ids:key()
	local is_removing = self._removing_textures[key] and true or false
	if self._cached_textures[key] then
		self._cached_textures[key] = self._cached_textures[key] - 1
		if self._cached_textures[key] == 0 then
			if not is_removing then
				self._removing_textures[key] = texture_ids
			else
				Application:error("[MenuComponentManager] unretrieve_texture(self._cached_textures): Trying to unretrieve a texture that is already to be unretrieved!", texture)
			end
		elseif self._cached_textures[key] < 0 then
			Application:error("[MenuComponentManager] unretrieve_texture(): To many unretrieve calls done!", texture, self._cached_textures[key])
			self._cached_textures[key] = 0
		end
		return
	elseif self._requested_textures[key] then
		if not index then
			Application:error("[MenuComponentManager] unretrieve_texture(): Index parameter needed!", texture)
			Application:stack_dump()
			index = 1
		end
		self._requested_textures[key][index] = nil
		if table.size(self._requested_textures[key]) == 0 then
			if not is_removing then
				self._removing_textures[key] = texture_ids
			else
				Application:error("[MenuComponentManager] unretrieve_texture(self._requested_textures): Trying to unretrieve a texture that is already to be unretrieved!", texture)
			end
		end
		return
	elseif is_removing then
		Application:error("[MenuComponentManager] unretrieve_texture(): Texture not cache nor requested, but still already to be unretrieved?!", texture)
	else
		Application:error("[MenuComponentManager] unretrieve_texture(): Can't unretrieve texture that is not in the system!", texture)
	end
end

function MenuComponentManager:post_event(event, unique)
	if alive(self._post_event) then
		self._post_event:stop()
		self._post_event = nil
	end
	local post_event = self._sound_source:post_event(event)
	if unique then
		self._post_event = post_event
	end
	return post_event
end

function MenuComponentManager:stop_event()
	print("MenuComponentManager:stop_event()")
	if alive(self._post_event) then
		self._post_event:stop()
		self._post_event = nil
	end
end

function MenuComponentManager:close()
	self:close_friends_gui()
	self:close_newsfeed_gui()
	self:close_profile_gui()
	self:close_player_profile_gui()
	self:close_contract_gui()
	self:close_server_info_gui()
	self:close_chat_gui()
	self:close_crimenet_gui()
	self:close_blackmarket_gui()
	self:close_stage_endscreen_gui()
	self:close_lootdrop_gui()
	self:close_mission_briefing_gui()
	self:close_debug_fonts_gui()
	if self._resolution_changed_callback_id then
		managers.viewport:remove_resolution_changed_func(self._resolution_changed_callback_id)
	end
	if alive(self._post_event) then
		self._post_event:stop()
	end
	for texture_ids, users in pairs(self._texture_cache) do
		TextureCache:unretrieve(texture_ids)
	end
	self._texture_cache = {}
	for texture_ids, users in pairs(self._requested_textures) do
		TextureCache:unretrieve(texture_ids)
	end
	self._requested_textures = {}
end

function MenuComponentManager:test_camera_shutter_tech()
	if not self._tcst then
		self._tcst = managers.gui_data:create_fullscreen_16_9_workspace()
		local o = self._tcst:panel():panel({layer = 10000})
		local b = o:rect({
			name = "black",
			color = Color.black,
			layer = 5,
			halign = "scale",
			valign = "scale"
		})
		local one_frame_hide = function(o)
			o:hide()
			coroutine.yield()
			o:show()
		end
		b:animate(one_frame_hide)
	end
	local o = self._tcst:panel():children()[1]
	local animate_fade = function(o)
		local black = o:child("black")
		over(0.5, function(p)
			black:set_alpha(1 - p)
		end)
	end
	o:stop()
	o:animate(animate_fade)
end
