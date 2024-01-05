core:import("CoreMenuManager")
core:import("CoreMenuCallbackHandler")
require("lib/managers/menu/MenuInput")
require("lib/managers/menu/MenuRenderer")
require("lib/managers/menu/MenuLobbyRenderer")
require("lib/managers/menu/MenuPauseRenderer")
require("lib/managers/menu/MenuKitRenderer")
require("lib/managers/menu/MenuHiddenRenderer")
require("lib/managers/menu/items/MenuItemColumn")
require("lib/managers/menu/items/MenuItemLevel")
require("lib/managers/menu/items/MenuItemChallenge")
require("lib/managers/menu/items/MenuItemKitSlot")
require("lib/managers/menu/items/MenuItemUpgrade")
require("lib/managers/menu/items/MenuItemMultiChoice")
require("lib/managers/menu/items/MenuItemChat")
require("lib/managers/menu/items/MenuItemFriend")
require("lib/managers/menu/items/MenuItemCustomizeController")
require("lib/managers/menu/nodes/MenuNodeTable")
require("lib/managers/menu/nodes/MenuNodeServerList")
core:import("CoreEvent")
MenuManager = MenuManager or class(CoreMenuManager.Manager)
MenuCallbackHandler = MenuCallbackHandler or class(CoreMenuCallbackHandler.CallbackHandler)
require("lib/managers/MenuManagerPD2")
MenuManager.ONLINE_AGE = 17
MenuManager.IS_NORTH_AMERICA = true
require("lib/managers/MenuManagerDialogs")

function MenuManager:init(is_start_menu)
	MenuManager.super.init(self)
	self._is_start_menu = is_start_menu
	self._active = false
	self._debug_menu_enabled = Global.DEBUG_MENU_ON or Application:production_build()
	self:create_controller()
	if is_start_menu then
		local menu_main = {
			name = "menu_main",
			id = "start_menu",
			content_file = "gamedata/menus/start_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuRenderer"
		}
		self:register_menu(menu_main)
	else
		local menu_pause = {
			name = "menu_pause",
			id = "pause_menu",
			content_file = "gamedata/menus/pause_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuPauseRenderer"
		}
		self:register_menu(menu_pause)
		local kit_menu = {
			name = "kit_menu",
			id = "kit_menu",
			content_file = "gamedata/menus/kit_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuKitRenderer"
		}
		self:register_menu(kit_menu)
		local mission_end_menu = {
			name = "mission_end_menu",
			id = "mission_end_menu",
			content_file = "gamedata/menus/mission_end_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuHiddenRenderer"
		}
		self:register_menu(mission_end_menu)
		local loot_menu = {
			name = "loot_menu",
			id = "loot_menu",
			content_file = "gamedata/menus/loot_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuHiddenRenderer"
		}
		self:register_menu(loot_menu)
	end
	self._controller:add_trigger("toggle_menu", callback(self, self, "toggle_menu_state"))
	self._controller:add_trigger("toggle_chat", callback(self, self, "toggle_chatinput"))
	if SystemInfo:platform() == Idstring("WIN32") then
		self._controller:add_trigger("push_to_talk", callback(self, self, "push_to_talk", true))
		self._controller:add_release_trigger("push_to_talk", callback(self, self, "push_to_talk", false))
	end
	self._active_changed_callback_handler = CoreEvent.CallbackEventHandler:new()
	managers.user:add_setting_changed_callback("brightness", callback(self, self, "brightness_changed"), true)
	managers.user:add_setting_changed_callback("camera_sensitivity", callback(self, self, "camera_sensitivity_changed"), true)
	managers.user:add_setting_changed_callback("camera_zoom_sensitivity", callback(self, self, "camera_sensitivity_changed"), true)
	managers.user:add_setting_changed_callback("rumble", callback(self, self, "rumble_changed"), true)
	managers.user:add_setting_changed_callback("invert_camera_x", callback(self, self, "invert_camera_x_changed"), true)
	managers.user:add_setting_changed_callback("invert_camera_y", callback(self, self, "invert_camera_y_changed"), true)
	managers.user:add_setting_changed_callback("subtitle", callback(self, self, "subtitle_changed"), true)
	managers.user:add_setting_changed_callback("music_volume", callback(self, self, "music_volume_changed"), true)
	managers.user:add_setting_changed_callback("sfx_volume", callback(self, self, "sfx_volume_changed"), true)
	managers.user:add_setting_changed_callback("voice_volume", callback(self, self, "voice_volume_changed"), true)
	managers.user:add_setting_changed_callback("use_lightfx", callback(self, self, "lightfx_changed"), true)
	managers.user:add_setting_changed_callback("effect_quality", callback(self, self, "effect_quality_changed"), true)
	managers.user:add_setting_changed_callback("dof_setting", callback(self, self, "dof_setting_changed"), true)
	managers.user:add_setting_changed_callback("fps_cap", callback(self, self, "fps_limit_changed"), true)
	managers.user:add_active_user_state_changed_callback(callback(self, self, "on_user_changed"))
	managers.user:add_storage_changed_callback(callback(self, self, "on_storage_changed"))
	managers.savefile:add_active_changed_callback(callback(self, self, "safefile_manager_active_changed"))
	self._delayed_open_savefile_menu_callback = nil
	self._save_game_callback = nil
	self:brightness_changed(nil, nil, managers.user:get_setting("brightness"))
	self:effect_quality_changed(nil, nil, managers.user:get_setting("effect_quality"))
	self:fps_limit_changed(nil, nil, managers.user:get_setting("fps_cap"))
	self:invert_camera_y_changed("invert_camera_y", nil, managers.user:get_setting("invert_camera_y"))
	self:dof_setting_changed("dof_setting", nil, managers.user:get_setting("dof_setting"))
	managers.system_menu:add_active_changed_callback(callback(self, self, "system_menu_active_changed"))
	self._sound_source = SoundDevice:create_source("MenuManager")
end

function MenuManager:post_event(event)
	local event = self._sound_source:post_event(event)
end

function MenuManager:_cb_matchmake_found_game(game_id, created)
	print("_cb_matchmake_found_game", game_id, created)
end

function MenuManager:_cb_matchmake_player_joined(player_info)
	print("_cb_matchmake_player_joined")
	if managers.network.group:is_group_leader() then
	end
end

function MenuManager:destroy()
	MenuManager.super.destroy(self)
	self:destroy_controller()
end

function MenuManager:set_delayed_open_savefile_menu_callback(callback_func)
	self._delayed_open_savefile_menu_callback = callback_func
end

function MenuManager:set_save_game_callback(callback_func)
	self._save_game_callback = callback_func
end

function MenuManager:system_menu_active_changed(active)
	local active_menu = self:active_menu()
	if not active_menu then
		return
	end
	if active then
		active_menu.logic:accept_input(false)
	else
		active_menu.renderer:disable_input(0.01)
	end
end

function MenuManager:set_and_send_sync_state(state)
	if not managers.network or not managers.network:session() then
		return
	end
	local index = tweak_data:menu_sync_state_to_index(state)
	if index then
		self:_set_peer_sync_state(managers.network:session():local_peer():id(), state)
		managers.network:session():send_to_peers("set_menu_sync_state_index", index)
	end
end

function MenuManager:_set_peer_sync_state(peer_id, state)
	Application:debug("MenuManager: " .. peer_id .. " sync state is now", state)
	self._peers_state = self._peers_state or {}
	self._peers_state[peer_id] = state
	if managers.menu_scene then
		managers.menu_scene:set_lobby_character_menu_state(peer_id, state)
	end
end

function MenuManager:set_peer_sync_state_index(peer_id, index)
	local state = tweak_data:index_to_menu_sync_state(index)
	self:_set_peer_sync_state(peer_id, state)
end

function MenuManager:get_all_peers_state()
	return self._peers_state
end

function MenuManager:get_peer_state(peer_id)
	return self._peers_state and self._peers_state[peer_id]
end

function MenuManager:_node_selected(menu_name, node)
	self:set_and_send_sync_state(node and node:parameters().sync_state)
end

function MenuManager:active_menu(node_name, parameter_list)
	local active_menu = self._open_menus[#self._open_menus]
	if active_menu then
		return active_menu
	end
end

function MenuManager:open_menu(menu_name, position)
	MenuManager.super.open_menu(self, menu_name, position)
	self:activate()
end

function MenuManager:open_node(node_name, parameter_list)
	local active_menu = self._open_menus[#self._open_menus]
	if active_menu then
		active_menu.logic:select_node(node_name, true, unpack(parameter_list or {}))
	end
end

function MenuManager:back(queue, skip_nodes)
	local active_menu = self._open_menus[#self._open_menus]
	if active_menu then
		active_menu.input:back(queue, skip_nodes)
	end
end

function MenuManager:close_menu(menu_name)
	self:post_event("menu_exit")
	if Global.game_settings.single_player and menu_name == "menu_pause" then
		Application:set_pause(false)
		self:post_event("game_resume")
		SoundDevice:set_rtpc("ingame_sound", 1)
	end
	MenuManager.super.close_menu(self, menu_name)
end

function MenuManager:_menu_closed(menu_name)
	MenuManager.super._menu_closed(self, menu_name)
	self:deactivate()
end

function MenuManager:close_all_menus()
	local names = {}
	for _, menu in pairs(self._open_menus) do
		table.insert(names, menu.name)
	end
	for _, name in ipairs(names) do
		self:close_menu(name)
	end
end

function MenuManager:is_open(menu_name)
	for _, menu in ipairs(self._open_menus) do
		if menu.name == menu_name then
			return true
		end
	end
	return false
end

function MenuManager:is_in_root(menu_name)
	for _, menu in ipairs(self._open_menus) do
		if menu.name == menu_name then
			return #menu.renderer._node_gui_stack == 1
		end
	end
	return false
end

function MenuManager:is_pc_controller()
	return self:active_menu() and self:active_menu().input._controller.TYPE == "pc" or managers.controller:get_default_wrapper_type() == "pc"
end

function MenuManager:toggle_menu_state()
	if self._is_start_menu then
		return
	end
	if managers.hud:chat_focus() then
		return
	end
	if (not Application:editor() or Global.running_simulation) and not managers.system_menu:is_active() then
		if self:is_open("menu_pause") then
			if not self:is_pc_controller() or self:is_in_root("menu_pause") then
				self:close_menu("menu_pause")
				managers.savefile:save_setting(true)
			end
		elseif (not self:active_menu() or #self:active_menu().logic._node_stack == 1) and managers.menu_component:input_focus() ~= 1 then
			self:open_menu("menu_pause")
			if Global.game_settings.single_player then
				Application:set_pause(true)
				self:post_event("game_pause_in_game_menu")
				SoundDevice:set_rtpc("ingame_sound", 0)
				local player_unit = managers.player:player_unit()
				if alive(player_unit) and player_unit:movement():current_state().update_check_actions_paused then
					player_unit:movement():current_state():update_check_actions_paused()
				end
			end
		end
	end
end

function MenuManager:push_to_talk(enabled)
	if managers.network and managers.network.voice_chat then
		managers.network.voice_chat:set_recording(enabled)
	end
end

function MenuManager:toggle_chatinput()
	if Global.game_settings.single_player or Application:editor() then
		return
	end
	if not MenuCallbackHandler:is_pc_controller() then
		return
	end
	if self:active_menu() then
		return
	end
	if not managers.network:session() then
		return
	end
	if managers.hud then
		managers.hud:toggle_chatinput()
	end
end

function MenuManager:set_slot_voice(peer, peer_id, active)
	local kit_menu = managers.menu:get_menu("kit_menu")
	if kit_menu and kit_menu.renderer:is_open() then
		kit_menu.renderer:set_slot_voice(peer, peer_id, active)
	end
end

function MenuManager:create_controller()
	if not self._controller then
		self._controller = managers.controller:create_controller("MenuManager", nil, false)
		local setup = self._controller:get_setup()
		local look_connection = setup:get_connection("look")
		self._look_multiplier = look_connection:get_multiplier()
		if not managers.savefile:is_active() then
			self._controller:enable()
		end
	end
end

function MenuManager:get_controller()
	return self._controller
end

function MenuManager:safefile_manager_active_changed(active)
	if self._controller then
		if active then
			self._controller:disable()
		else
			self._controller:enable()
		end
	end
	if not active then
		if self._delayed_open_savefile_menu_callback then
			self._delayed_open_savefile_menu_callback()
		end
		if self._save_game_callback then
			self._save_game_callback()
		end
	end
end

function MenuManager:destroy_controller()
	if self._controller then
		self._controller:destroy()
		self._controller = nil
	end
end

function MenuManager:activate()
	if #self._open_menus == 1 then
		managers.rumble:set_enabled(false)
		self._active_changed_callback_handler:dispatch(true)
		self._active = true
	end
end

function MenuManager:deactivate()
	if #self._open_menus == 0 then
		managers.rumble:set_enabled(managers.user:get_setting("rumble"))
		self._active_changed_callback_handler:dispatch(false)
		self._active = false
	end
end

function MenuManager:is_active()
	return self._active
end

function MenuManager:add_active_changed_callback(callback_func)
	self._active_changed_callback_handler:add(callback_func)
end

function MenuManager:remove_active_changed_callback(callback_func)
	self._active_changed_callback_handler:remove(callback_func)
end

function MenuManager:brightness_changed(name, old_value, new_value)
	local brightness = math.clamp(new_value, _G.tweak_data.menu.MIN_BRIGHTNESS, _G.tweak_data.menu.MAX_BRIGHTNESS)
	Application:set_brightness(brightness)
end

function MenuManager:effect_quality_changed(name, old_value, new_value)
	World:effect_manager():set_quality(new_value)
end

function MenuManager:set_mouse_sensitivity(zoomed)
	if self:is_console() then
		return
	end
	local sens = zoomed and managers.user:get_setting("enable_camera_zoom_sensitivity") and managers.user:get_setting("camera_zoom_sensitivity") or managers.user:get_setting("camera_sensitivity")
	self._controller:get_setup():get_connection("look"):set_multiplier(sens * self._look_multiplier)
	managers.controller:rebind_connections()
end

function MenuManager:camera_sensitivity_changed(name, old_value, new_value)
	if self:is_console() then
		local setup = self._controller:get_setup()
		local look_connection = setup:get_connection("look")
		local look_mutliplier = new_value * self._look_multiplier
		look_connection:set_multiplier(look_mutliplier)
		managers.controller:rebind_connections()
		return
	end
	if alive(managers.player:player_unit()) then
		local plr_state = managers.player:player_unit():movement():current_state()
		local weapon_id = alive(plr_state._equipped_unit) and plr_state._equipped_unit:base():get_name_id()
		local stances = tweak_data.player.stances[weapon_id] or tweak_data.player.stances.default
		self:set_mouse_sensitivity(plr_state:in_steelsight() and stances.steelsight.zoom_fov)
	else
		self:set_mouse_sensitivity(false)
	end
end

function MenuManager:rumble_changed(name, old_value, new_value)
	managers.rumble:set_enabled(new_value)
end

function MenuManager:invert_camera_x_changed(name, old_value, new_value)
	local setup = self._controller:get_setup()
	local look_connection = setup:get_connection("look")
	local look_inversion = look_connection:get_inversion_unmodified()
	if new_value then
		look_inversion = look_inversion:with_x(-1)
	else
		look_inversion = look_inversion:with_x(1)
	end
	look_connection:set_inversion(look_inversion)
	managers.controller:rebind_connections()
end

function MenuManager:invert_camera_y_changed(name, old_value, new_value)
	local setup = self._controller:get_setup()
	local look_connection = setup:get_connection("look")
	local look_inversion = look_connection:get_inversion_unmodified()
	if new_value then
		look_inversion = look_inversion:with_y(-1)
	else
		look_inversion = look_inversion:with_y(1)
	end
	look_connection:set_inversion(look_inversion)
	managers.controller:rebind_connections()
end

function MenuManager:southpaw_changed(name, old_value, new_value)
	if self._controller.TYPE ~= "xbox360" and self._controller.TYPE ~= "ps3" then
		return
	end
	local setup = self._controller:get_setup()
	local look_connection = setup:get_connection("look")
	local move_connection = setup:get_connection("move")
	local look_input_name_list = look_connection:get_input_name_list()
	local move_input_name_list = move_connection:get_input_name_list()
	if Application:production_build() then
		local got_input_left = 0
		local got_input_right = 0
		for _, input_name in ipairs(look_input_name_list) do
			if input_name == "left" then
				got_input_left = got_input_left + 1
			elseif input_name == "right" then
				got_input_right = got_input_right + 1
			else
				Application:error("[MenuManager:southpaw_changed] Active controller got some other input other than left and right on look!", input_name)
			end
		end
		for _, input_name in ipairs(move_input_name_list) do
			if input_name == "left" then
				got_input_left = got_input_left + 1
			elseif input_name == "right" then
				got_input_right = got_input_right + 1
			else
				Application:error("[MenuManager:southpaw_changed] Active controller got some other input other than left and right on move!", input_name)
			end
		end
		if got_input_left ~= 1 or got_input_right ~= 1 then
			Application:error("[MenuManager:southpaw_changed] Controller look and move are not binded as expected", "got_input_left: " .. tostring(got_input_left), "got_input_right: " .. tostring(got_input_right), "look_input_name_list: " .. inspect(look_input_name_list), "move_input_name_list: " .. inspect(move_input_name_list))
		end
	end
	if new_value then
		move_connection:set_input_name_list({"right"})
		look_connection:set_input_name_list({"left"})
	else
		move_connection:set_input_name_list({"left"})
		look_connection:set_input_name_list({"right"})
	end
	managers.controller:rebind_connections()
end

function MenuManager:dof_setting_changed(name, old_value, new_value)
	managers.environment_controller:set_dof_setting(new_value)
end

function MenuManager:fps_limit_changed(name, old_value, new_value)
	if SystemInfo:platform() ~= Idstring("WIN32") then
		return
	end
	setup:set_fps_cap(new_value)
end

function MenuManager:subtitle_changed(name, old_value, new_value)
	managers.subtitle:set_visible(new_value)
end

function MenuManager:music_volume_changed(name, old_value, new_value)
	local tweak = _G.tweak_data.menu
	local percentage = (new_value - tweak.MIN_MUSIC_VOLUME) / (tweak.MAX_MUSIC_VOLUME - tweak.MIN_MUSIC_VOLUME)
	managers.music:set_volume(percentage)
end

function MenuManager:sfx_volume_changed(name, old_value, new_value)
	local tweak = _G.tweak_data.menu
	local percentage = (new_value - tweak.MIN_SFX_VOLUME) / (tweak.MAX_SFX_VOLUME - tweak.MIN_SFX_VOLUME)
	SoundDevice:set_rtpc("option_sfx_volume", percentage * 100)
	managers.video:volume_changed(percentage)
end

function MenuManager:voice_volume_changed(name, old_value, new_value)
	if managers.network and managers.network.voice_chat then
		managers.network.voice_chat:set_volume(new_value)
	end
end

function MenuManager:lightfx_changed(name, old_value, new_value)
	if managers.network and managers.network.account then
		managers.network.account:set_lightfx()
	end
end

function MenuManager:set_debug_menu_enabled(enabled)
	self._debug_menu_enabled = enabled
end

function MenuManager:debug_menu_enabled()
	return self._debug_menu_enabled
end

function MenuManager:add_back_button(new_node)
	new_node:delete_item("back")
	local params = {
		name = "back",
		text_id = "menu_back",
		visible_callback = "is_pc_controller",
		back = true,
		previous_node = true
	}
	local new_item = new_node:create_item(nil, params)
	new_node:add_item(new_item)
end

function MenuManager:reload()
	self:_recompile(managers.database:root_path() .. "assets\\guis\\")
end

function MenuManager:_recompile(dir)
	local source_files = self:_source_files(dir)
	local t = {
		platform = "win32",
		source_root = managers.database:root_path() .. "/assets",
		target_db_root = managers.database:root_path() .. "/packages/win32/assets",
		target_db_name = "all",
		source_files = source_files,
		verbose = false,
		send_idstrings = false
	}
	Application:data_compile(t)
	DB:reload()
	managers.database:clear_all_cached_indices()
	for _, file in ipairs(source_files) do
		PackageManager:reload(managers.database:entry_type(file):id(), managers.database:entry_path(file):id())
	end
end

function MenuManager:_source_files(dir)
	local files = {}
	local entry_path = managers.database:entry_path(dir) .. "/"
	for _, file in ipairs(SystemFS:list(dir)) do
		table.insert(files, entry_path .. file)
	end
	for _, sub_dir in ipairs(SystemFS:list(dir, true)) do
		for _, file in ipairs(SystemFS:list(dir .. "/" .. sub_dir)) do
			table.insert(files, entry_path .. sub_dir .. "/" .. file)
		end
	end
	return files
end

function MenuManager:progress_resetted()
	local dialog_data = {}
	dialog_data.title = "Dr Evil"
	dialog_data.text = "HAHA, your progress is gone!"
	local no_button = {}
	no_button.text = "Doh!"
	no_button.callback_func = callback(self, self, "_dialog_progress_resetted_ok")
	dialog_data.button_list = {no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:_dialog_progress_resetted_ok()
end

function MenuManager:relay_chat_message(message, id)
	for _, menu in pairs(self._open_menus) do
		if menu.renderer.sync_chat_message then
			menu.renderer:sync_chat_message(message, id)
		end
	end
	if self:is_console() then
		return
	end
	print("relay_chat_message", message, id)
	if managers.hud then
		managers.hud:sync_say(message, id)
	end
end

function MenuManager:is_console()
	return self:is_ps3() or self:is_x360()
end

function MenuManager:is_ps3()
	return SystemInfo:platform() == Idstring("PS3")
end

function MenuManager:is_x360()
	return SystemInfo:platform() == Idstring("X360")
end

function MenuManager:is_na()
	return MenuManager.IS_NORTH_AMERICA
end

function MenuManager:open_sign_in_menu(cb)
	if self:is_ps3() then
		managers.network.matchmake:register_callback("found_game", callback(self, self, "_cb_matchmake_found_game"))
		managers.network.matchmake:register_callback("player_joined", callback(self, self, "_cb_matchmake_player_joined"))
		self:open_ps3_sign_in_menu(cb)
	elseif self:is_x360() then
		if managers.network.account:signin_state() == "signed in" and managers.user:check_privilege(nil, "multiplayer_sessions") then
			self:open_x360_sign_in_menu(cb)
		else
			self:show_err_not_signed_in_dialog()
		end
	elseif managers.network.account:signin_state() == "signed in" then
		cb(true)
	else
		self:show_err_not_signed_in_dialog()
	end
end

function MenuManager:open_ps3_sign_in_menu(cb)
	local success = true
	if managers.network.account:signin_state() == "not signed in" then
		managers.network.account:show_signin_ui()
		if managers.network.account:signin_state() == "signed in" then
			print("SIGNED IN")
			if #PSN:get_world_list() == 0 then
				managers.network.matchmake:getting_world_list()
			end
			success = self:_enter_online_menus()
		else
			success = false
		end
	else
		if #PSN:get_world_list() == 0 then
			managers.network.matchmake:getting_world_list()
			PSN:init_matchmaking()
		end
		success = self:_enter_online_menus()
	end
	cb(success)
end

function MenuManager:open_x360_sign_in_menu(cb)
	local success = self:_enter_online_menus_x360()
	cb(success)
end

function MenuManager:external_enter_online_menus()
	if self:is_ps3() then
		self:_enter_online_menus()
	else
		if self:is_x360() then
			self:_enter_online_menus_x360()
		else
		end
	end
end

function MenuManager:_enter_online_menus()
	if PSN:user_age() < MenuManager.ONLINE_AGE and PSN:parental_control_settings_active() then
		Global.boot_invite = nil
		self:show_err_under_age()
		return false
	else
		managers.platform:set_presence("Signed_in")
		managers.network:ps3_determine_voice(false)
		managers.network.voice_chat:check_status_information()
		PSN:set_online_callback(callback(self, self, "ps3_disconnect"))
		return true
	end
end

function MenuManager:_enter_online_menus_x360()
	managers.platform:set_presence("Signed_in")
	managers.user:on_entered_online_menus()
	return true
end

function MenuManager:psn_disconnected()
	if managers.network:session() then
		managers.network:queue_stop_network()
		managers.platform:set_presence("Idle")
		managers.network.matchmake:leave_game()
		managers.network.friends:psn_disconnected()
		managers.network.voice_chat:destroy_voice(true)
		self:exit_online_menues()
	end
	self:show_mp_disconnected_internet_dialog({ok_func = nil})
end

function MenuManager:steam_disconnected()
	if managers.network:session() then
		managers.network:queue_stop_network()
		managers.platform:set_presence("Idle")
		managers.network.matchmake:leave_game()
		managers.network.voice_chat:destroy_voice(true)
		self:exit_online_menues()
	end
	self:show_mp_disconnected_internet_dialog({ok_func = nil})
end

function MenuManager:xbox_disconnected()
	print("xbox_disconnected()")
	if managers.network:session() then
		managers.network:queue_stop_network()
		managers.platform:set_presence("Idle")
		managers.network.matchmake:leave_game()
		managers.network.voice_chat:destroy_voice(true)
	end
	self:exit_online_menues()
	managers.user:on_exit_online_menus()
	self:show_mp_disconnected_internet_dialog({ok_func = nil})
end

function MenuManager:ps3_disconnect(connected)
	if not connected and not PSN:is_online() then
		managers.network:queue_stop_network()
		managers.platform:set_presence("Idle")
		managers.network.matchmake:leave_game()
		managers.network.friends:psn_disconnected()
		managers.network.voice_chat:destroy_voice(true)
		self:show_disconnect_message(true)
	end
	if managers.menu_component then
		managers.menu_component:refresh_player_profile_gui()
	end
end

function MenuManager:show_disconnect_message(requires_signin)
	if self._showing_disconnect_message then
		return
	end
	if self:is_ps3() then
		PS3:abort_display_keyboard()
	end
	self:exit_online_menues()
	self._showing_disconnect_message = true
	self:show_err_not_signed_in_dialog()
end

function MenuManager:created_lobby()
	Global.game_settings.single_player = false
	managers.network:host_game()
	Network:set_multiplayer(true)
	Network:set_server()
	self:on_enter_lobby()
end

function MenuManager:exit_online_menues()
	managers.system_menu:force_close_all()
	Global.controller_manager.connect_controller_dialog_visible = nil
	self:_close_lobby_menu_components()
	if self:active_menu() then
		self:close_menu(self:active_menu().name)
	end
	self:open_menu("menu_main")
	if not managers.menu:is_pc_controller() then
		managers.menu:active_menu().input:deactivate_controller_mouse()
	end
end

function MenuManager:leave_online_menu()
	if self:is_ps3() then
		PSN:set_online_callback(callback(self, self, "refresh_player_profile_gui"))
	end
	if self:is_x360() then
		managers.user:on_exit_online_menus()
	end
end

function MenuManager:refresh_player_profile_gui()
	if managers.menu_component then
		managers.menu_component:refresh_player_profile_gui()
	end
end

function MenuManager:_close_lobby_menu_components()
	managers.menu_scene:hide_all_lobby_characters()
	managers.menu_component:remove_game_chat()
	managers.menu_component:close_lobby_profile_gui()
	managers.menu_component:close_contract_gui()
	managers.menu_component:close_chat_gui()
end

function MenuManager:on_leave_lobby()
	local skip_destroy_matchmaking = self:is_ps3()
	managers.network:prepare_stop_network(skip_destroy_matchmaking)
	if self:is_x360() then
		managers.user:on_exit_online_menus()
	end
	managers.platform:set_rich_presence("Idle")
	managers.menu:close_menu("menu_main")
	managers.menu:open_menu("menu_main")
	managers.network.matchmake:leave_game()
	managers.network.voice_chat:destroy_voice()
	self:_close_lobby_menu_components()
	if Global.game_settings.difficulty == "overkill_145" and managers.experience:current_level() < 145 then
		Global.game_settings.difficulty = "overkill"
	end
	managers.job:deactivate_current_job()
end

function MenuManager:show_global_success(node)
	local node_gui
	if not node then
		local stack = managers.menu:active_menu().renderer._node_gui_stack
		node_gui = stack[#stack]
		if not node_gui.set_mini_info then
			print("No mini info to set!")
			return
		end
	end
	if not managers.network.account.get_win_ratio then
		if node_gui then
			node_gui:set_mini_info("")
		end
		return
	end
	local rate = managers.network.account:get_win_ratio(Global.game_settings.difficulty, Global.game_settings.level_id)
	if not rate then
		if node_gui then
			node_gui:set_mini_info("")
		end
		return
	end
	rate = rate * 100
	local rate_str
	if 10 <= rate then
		rate_str = string.format("%.0f", rate)
	else
		rate_str = string.format("%.1f", rate)
	end
	local diff_str = string.upper(managers.localization:text("menu_difficulty_" .. Global.game_settings.difficulty))
	local heist_str = string.upper(managers.localization:text(tweak_data.levels[Global.game_settings.level_id].name_id))
	rate_str = managers.localization:text("menu_global_success", {
		COUNT = rate_str,
		HEIST = heist_str,
		DIFFICULTY = diff_str
	})
	if node then
		node.mini_info = rate_str
	else
		node_gui:set_mini_info(rate_str)
	end
end

function MenuManager:change_theme(theme)
	managers.user:set_setting("menu_theme", theme)
	for _, menu in ipairs(self._open_menus) do
		menu.renderer:refresh_theme()
	end
end

function MenuManager:on_storage_changed(old_user_data, user_data)
	if old_user_data and old_user_data.storage_id and user_data and user_data.signin_state ~= "not_signed_in" and not old_user_data.has_signed_out and managers.user:get_platform_id() == user_data.platform_id then
		self:show_storage_removed_dialog()
		print("!!!!!!!!!!!!!!!!!!! STORAGE LOST")
		managers.savefile:break_loading_sequence()
		if game_state_machine:current_state().on_storage_changed then
			game_state_machine:current_state():on_storage_changed(old_user_data, user_data)
		end
	end
end

function MenuManager:on_user_changed(old_user_data, user_data)
	if old_user_data and (old_user_data.signin_state ~= "not_signed_in" or not old_user_data.username) then
		print("MenuManager:on_user_changed(), clear save data")
		if game_state_machine:current_state().on_user_changed then
			game_state_machine:current_state():on_user_changed(old_user_data, user_data)
		end
		self:reset_all_loaded_data()
	end
end

function MenuManager:reset_all_loaded_data()
	self:do_clear_progress()
	managers.user:reset_setting_map()
	managers.statistics:reset()
end

function MenuManager:do_clear_progress()
	managers.skilltree:reset()
	managers.experience:reset()
	managers.money:reset()
	managers.challenges:reset_challenges()
	managers.blackmarket:reset()
	managers.dlc:on_reset_profile()
	managers.mission:on_reset_profile()
	managers.crimenet:reset_seed()
	if Global.game_settings.difficulty == "overkill_145" then
		Global.game_settings.difficulty = "overkill"
	end
	managers.user:set_setting("mask_set", "clowns")
end

function MenuManager:on_user_sign_out()
	print("MenuManager:on_user_sign_out()")
	if managers.network:session() then
		managers.network:queue_stop_network()
		managers.platform:set_presence("Idle")
		if managers.network:session():_local_peer_in_lobby() then
			managers.network.matchmake:leave_game()
		else
			managers.network.matchmake:destroy_game()
		end
		managers.network.voice_chat:destroy_voice(true)
	end
end

function MenuCallbackHandler:init()
	MenuCallbackHandler.super.init(self)
	self._sound_source = SoundDevice:create_source("MenuCallbackHandler")
end

function MenuCallbackHandler:trial_buy()
	print("[MenuCallbackHandler:trial_buy]")
	managers.dlc:buy_full_game()
end

function MenuCallbackHandler:dlc_buy_pc()
	print("[MenuCallbackHandler:dlc_buy_pc]")
	Steam:overlay_activate("store", 218620)
end

function MenuCallbackHandler:dlc_buy_ps3()
	print("[MenuCallbackHandler:dlc_buy_ps3]")
	managers.dlc:buy_product("dlc1")
end

function MenuCallbackHandler:has_full_game()
	return managers.dlc:has_full_game()
end

function MenuCallbackHandler:is_trial()
	return managers.dlc:is_trial()
end

function MenuCallbackHandler:is_not_trial()
	return not self:is_trial()
end

function MenuCallbackHandler:has_preorder()
	return managers.dlc:has_preorder()
end

function MenuCallbackHandler:not_has_preorder()
	return not managers.dlc:has_preorder()
end

function MenuCallbackHandler:has_all_dlcs()
	return true
end

function MenuCallbackHandler:not_has_all_dlcs()
	return not self:has_all_dlcs()
end

function MenuCallbackHandler:reputation_check(data)
	return managers.experience:current_level() >= data:value()
end

function MenuCallbackHandler:non_overkill_145(data)
	return true
end

function MenuCallbackHandler:is_level_145()
	return managers.experience:current_level() >= 145
end

function MenuCallbackHandler:is_win32()
	return SystemInfo:platform() == Idstring("WIN32")
end

function MenuCallbackHandler:voice_enabled()
	return not self:is_ps3() and self:is_win32() and managers.network and managers.network.voice_chat and managers.network.voice_chat:enabled()
end

function MenuCallbackHandler:customize_controller_enabled()
	return true
end

function MenuCallbackHandler:is_win32_not_lan()
	return SystemInfo:platform() == Idstring("WIN32") and not Global.game_settings.playing_lan
end

function MenuCallbackHandler:is_console()
	return self:is_ps3() or self:is_x360()
end

function MenuCallbackHandler:is_ps3()
	return SystemInfo:platform() == Idstring("PS3")
end

function MenuCallbackHandler:is_x360()
	return SystemInfo:platform() == Idstring("X360")
end

function MenuCallbackHandler:is_not_x360()
	return not self:is_x360()
end

function MenuCallbackHandler:is_not_xbox()
	return not self:is_x360()
end

function MenuCallbackHandler:is_na()
	return MenuManager.IS_NORTH_AMERICA
end

function MenuCallbackHandler:has_dropin()
	return NetworkManager.DROPIN_ENABLED
end

function MenuCallbackHandler:is_server()
	return Network:is_server()
end

function MenuCallbackHandler:is_not_server()
	return not self:is_server()
end

function MenuCallbackHandler:is_online()
	return managers.network.account:signin_state() == "signed in"
end

function MenuCallbackHandler:is_singleplayer()
	return Global.game_settings.single_player
end

function MenuCallbackHandler:is_multiplayer()
	return not Global.game_settings.single_player
end

function MenuCallbackHandler:is_prof_job()
	return managers.job:is_current_job_professional()
end

function MenuCallbackHandler:is_normal_job()
	return not self:is_prof_job()
end

function MenuCallbackHandler:singleplayer_restart()
	return self:is_singleplayer() and self:has_full_game() and self:is_normal_job() and not managers.job:stage_success()
end

function MenuCallbackHandler:hidden()
	return false
end

function MenuCallbackHandler:chat_visible()
	return SystemInfo:platform() == Idstring("WIN32")
end

function MenuCallbackHandler:is_pc_controller()
	return managers.menu:is_pc_controller()
end

function MenuCallbackHandler:is_not_pc_controller()
	return not self:is_pc_controller()
end

function MenuCallbackHandler:is_not_editor()
	return not Application:editor()
end

function MenuCallbackHandler:show_credits()
	game_state_machine:change_state_by_name("menu_credits")
end

function MenuCallbackHandler:can_load_game()
	return not Application:editor() and not Network:multiplayer()
end

function MenuCallbackHandler:can_save_game()
	return not Application:editor() and not Network:multiplayer()
end

function MenuCallbackHandler:is_not_multiplayer()
	return not Network:multiplayer()
end

function MenuCallbackHandler:debug_menu_enabled()
	return managers.menu:debug_menu_enabled()
end

function MenuCallbackHandler:leave_online_menu()
	managers.menu:leave_online_menu()
end

function MenuCallbackHandler:on_visit_forum()
	Steam:overlay_activate("url", "http://forums.steampowered.com/forums/forumdisplay.php?f=1225")
end

function MenuCallbackHandler:on_visit_gamehub()
	Steam:overlay_activate("url", "http://steamcommunity.com/app/218620")
end

function MenuCallbackHandler:on_buy_dlc1()
	Steam:overlay_activate("store", 218620)
end

function MenuCallbackHandler:quit_game()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_are_you_sure_you_want_to_quit")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_dialog_quit_yes")
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = callback(self, self, "_dialog_quit_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:_dialog_quit_yes()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_ask_save_progress_backup")
	dialog_data.focus_button = 1
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_dialog_save_progress_backup_yes")
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = callback(self, self, "_dialog_save_progress_backup_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:_dialog_quit_no()
end

function MenuCallbackHandler:_dialog_save_progress_backup_yes()
	managers.savefile:save_progress("local_hdd")
	setup:quit()
end

function MenuCallbackHandler:_dialog_save_progress_backup_no()
	setup:quit()
end

function MenuCallbackHandler:toggle_god_mode(item)
	local god_mode_on = item:value() == "on"
	Global.god_mode = god_mode_on
	if managers.player:player_unit() then
		managers.player:player_unit():character_damage():set_god_mode(god_mode_on)
	end
end

function MenuCallbackHandler:toggle_post_effects(item)
	local post_effects_on = item:value() == "on"
	Global.debug_post_effects_enabled = post_effects_on
	if not post_effects_on then
		managers.environment_controller:set_suppression_value(0)
	end
end

function MenuCallbackHandler:toggle_alienware_mask(item)
	local use_mask = item:value() == "on"
	if SystemInfo:platform() ~= Idstring("WIN32") or not managers.network.account:has_alienware() then
		use_mask = false
	end
	managers.user:set_setting("alienware_mask", use_mask)
end

function MenuCallbackHandler:toggle_developer_mask(item)
	local use_mask = item:value() == "on"
	if SystemInfo:platform() ~= Idstring("WIN32") or not managers.network.account:is_developer() then
		use_mask = false
	end
	managers.user:set_setting("developer_mask", use_mask)
end

function MenuCallbackHandler:toggle_ready(item)
	local ready = item:value() == "on"
	if not managers.network:session() then
		return
	end
	managers.network:session():local_peer():set_waiting_for_player_ready(ready)
	managers.network:session():chk_send_local_player_ready()
	if managers.menu:active_menu() and managers.menu:active_menu().renderer and managers.menu:active_menu().renderer.set_ready_items_enabled then
		managers.menu:active_menu().renderer:set_ready_items_enabled(not ready)
	end
	managers.network:game():on_set_member_ready(managers.network:session():local_peer():id(), ready)
end

function MenuCallbackHandler:freeflight(item)
	if setup:freeflight() then
		setup:freeflight():enable()
		self:resume_game()
	end
end

function MenuCallbackHandler:change_nr_players(item)
	local nr_players = item:value()
	Global.nr_players = nr_players
	managers.player:set_nr_players(nr_players)
end

function MenuCallbackHandler:toggle_rumble(item)
	local rumble = item:value() == "on"
	managers.user:set_setting("rumble", rumble)
end

function MenuCallbackHandler:invert_camera_horisontally(item)
	local invert = item:value() == "on"
	managers.user:set_setting("invert_camera_x", invert)
end

function MenuCallbackHandler:invert_camera_vertically(item)
	local invert = item:value() == "on"
	managers.user:set_setting("invert_camera_y", invert)
end

function MenuCallbackHandler:toggle_southpaw(item)
end

function MenuCallbackHandler:toggle_dof_setting(item)
	local dof_setting = item:value() == "on"
	managers.user:set_setting("dof_setting", dof_setting and "standard" or "none")
end

function MenuCallbackHandler:hold_to_steelsight(item)
	local hold = item:value() == "on"
	managers.user:set_setting("hold_to_steelsight", hold)
end

function MenuCallbackHandler:hold_to_run(item)
	local hold = item:value() == "on"
	managers.user:set_setting("hold_to_run", hold)
end

function MenuCallbackHandler:hold_to_duck(item)
	local hold = item:value() == "on"
	managers.user:set_setting("hold_to_duck", hold)
end

function MenuCallbackHandler:toggle_fullscreen(item)
	local fullscreen = item:value() == "on"
	if RenderSettings.fullscreen == fullscreen then
		return
	end
	managers.viewport:set_fullscreen(fullscreen)
	managers.menu:show_accept_gfx_settings_dialog(function()
		managers.viewport:set_fullscreen(not fullscreen)
		item:set_value(not fullscreen and "on" or "off")
	end)
end

function MenuCallbackHandler:toggle_subtitle(item)
	local subtitle = item:value() == "on"
	managers.user:set_setting("subtitle", subtitle)
end

function MenuCallbackHandler:toggle_hit_indicator(item)
	local on = item:value() == "on"
	managers.user:set_setting("hit_indicator", on)
end

function MenuCallbackHandler:toggle_objective_reminder(item)
	local on = item:value() == "on"
	managers.user:set_setting("objective_reminder", on)
end

function MenuCallbackHandler:toggle_aim_assist(item)
	local on = item:value() == "on"
	managers.user:set_setting("aim_assist", on)
end

function MenuCallbackHandler:toggle_voicechat(item)
	local vchat = item:value() == "on"
	managers.user:set_setting("voice_chat", vchat)
end

function MenuCallbackHandler:toggle_push_to_talk(item)
	local vchat = item:value() == "on"
	managers.user:set_setting("push_to_talk", vchat)
end

function MenuCallbackHandler:toggle_team_AI(item)
	Global.criminal_team_AI_disabled = item:value() == "off"
	managers.groupai:state():on_criminal_team_AI_enabled_state_changed()
end

function MenuCallbackHandler:toggle_coordinates(item)
	if item:value() == "off" then
		managers.hud:debug_hide_coordinates()
	else
		managers.hud:debug_show_coordinates()
	end
end

function MenuCallbackHandler:change_resolution(item)
	local old_resolution = RenderSettings.resolution
	if item:parameters().resolution == old_resolution then
		return
	end
	managers.viewport:set_resolution(item:parameters().resolution)
	managers.viewport:set_aspect_ratio(item:parameters().resolution.x / item:parameters().resolution.y)
	managers.menu:show_accept_gfx_settings_dialog(function()
		managers.viewport:set_resolution(old_resolution)
		managers.viewport:set_aspect_ratio(old_resolution.x / old_resolution.y)
	end)
end

function MenuCallbackHandler:choice_test(item)
	local test = item:value()
	print("MenuCallbackHandler", test)
end

function MenuCallbackHandler:choice_mask(item)
	local mask_set = item:value()
	print("[MenuCallbackHandler:choice_mask]", mask_set)
	managers.user:set_setting("mask_set", mask_set)
	local peer = managers.network:session():local_peer()
	peer:set_mask_set(mask_set)
	if Global.game_settings.single_player then
		if managers.menu:active_menu().renderer.set_character then
			managers.menu:active_menu().renderer:set_character(peer:id(), peer:character())
		end
	else
		managers.menu:active_menu().renderer:set_character(peer:id(), peer:character())
		managers.network:session():send_to_peers("set_mask_set", peer:id(), mask_set)
	end
end

function MenuCallbackHandler:choice_distance_filter(item)
	local dist_filter = item:value()
	if managers.network.matchmake:distance_filter() == dist_filter then
		return
	end
	managers.network.matchmake:set_distance_filter(dist_filter)
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
end

function MenuCallbackHandler:choice_difficulty_filter(item)
	local diff_filter = item:value()
	print("diff_filter", diff_filter)
	if managers.network.matchmake:difficulty_filter() == diff_filter then
		return
	end
	managers.network.matchmake:set_difficulty_filter(diff_filter)
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
end

function MenuCallbackHandler:choice_difficulty_filter_ps3(item)
	local diff_filter = item:value()
	print("diff_filter", diff_filter)
	if managers.network.matchmake:difficulty_filter() == diff_filter then
		return
	end
	managers.network.matchmake:set_difficulty_filter(diff_filter)
	managers.network.matchmake:start_search_lobbys(managers.network.matchmake:searching_friends_only())
end

function MenuCallbackHandler:choice_lobby_difficulty(item)
	local difficulty = item:value()
	Global.game_settings.difficulty = difficulty
	if managers.menu:active_menu().renderer.update_difficulty then
		managers.menu:active_menu().renderer:update_difficulty()
	end
	if difficulty == "overkill_145" and Global.game_settings.reputation_permission < 145 then
		local item_reputation_permission = managers.menu:active_menu().logic:selected_node():item("lobby_reputation_permission")
		if item_reputation_permission and item_reputation_permission:visible() then
			item_reputation_permission:set_value(145)
			item_reputation_permission:trigger()
		end
	end
	managers.menu:show_global_success()
	self:update_matchmake_attributes()
end

function MenuCallbackHandler:choice_lobby_campaign(item)
	if not item:enabled() then
		return
	end
	Global.game_settings.level_id = item:parameter("level_id")
	MenuManager.refresh_level_select(managers.menu:active_menu().logic:selected_node(), true)
	if managers.menu:active_menu().renderer.update_level_id then
		managers.menu:active_menu().renderer:update_level_id(Global.game_settings.level_id)
	end
	if managers.menu:active_menu().renderer.update_difficulty then
		managers.menu:active_menu().renderer:update_difficulty()
	end
	managers.menu:show_global_success()
	self:update_matchmake_attributes()
end

function MenuCallbackHandler:choice_lobby_mission(item)
	if not item:enabled() then
		return
	end
	Global.game_settings.mission = item:value()
end

function MenuCallbackHandler:choice_friends_only(item)
	local choice_friends_only = item:value() == "on"
	Global.game_settings.search_friends_only = choice_friends_only
end

function MenuCallbackHandler:choice_lobby_permission(item)
	local permission = item:value()
	local level_id = item:value()
	Global.game_settings.permission = permission
	self:update_matchmake_attributes()
end

function MenuCallbackHandler:choice_lobby_reputation_permission(item)
	local reputation_permission = item:value()
	Global.game_settings.reputation_permission = reputation_permission
	self:update_matchmake_attributes()
end

function MenuCallbackHandler:choice_team_ai(item)
	local team_ai = item:value() == "on"
	Global.game_settings.team_ai = team_ai
end

function MenuCallbackHandler:choice_drop_in(item)
	local choice_drop_in = item:value() == "on"
	Global.game_settings.drop_in_allowed = choice_drop_in
	self:update_matchmake_attributes()
	if managers.network:session() then
		managers.network:session():chk_server_joinable_state()
	end
end

function MenuCallbackHandler:choice_crimenet_lobby_permission(item)
	local permission = item:value()
	Global.game_settings.permission = permission
end

function MenuCallbackHandler:choice_crimenet_lobby_reputation_permission(item)
	local reputation_permission = item:value()
	Global.game_settings.reputation_permission = reputation_permission
end

function MenuCallbackHandler:choice_crimenet_team_ai(item)
	local team_ai = item:value() == "on"
	Global.game_settings.team_ai = team_ai
end

function MenuCallbackHandler:choice_crimenet_drop_in(item)
	local choice_drop_in = item:value() == "on"
	Global.game_settings.drop_in_allowed = choice_drop_in
	if managers.network:session() then
		managers.network:session():chk_server_joinable_state()
	end
end

function MenuCallbackHandler:accept_crimenet_contract(item, node)
	managers.menu:active_menu().logic:navigate_back(true)
	local job_data = item:parameters().gui_node.node:parameters().menu_component_data
	if job_data.server then
		managers.network.matchmake:join_server_with_check(job_data.room_id, false, job_data)
	elseif Global.game_settings.single_player then
		MenuCallbackHandler:start_single_player_job(job_data)
	else
		MenuCallbackHandler:start_job(job_data)
	end
end

function MenuCallbackHandler:kit_menu_ready()
	managers.menu:close_menu("kit_menu")
end

function MenuCallbackHandler:set_lan_game()
	Global.game_settings.playing_lan = true
end

function MenuCallbackHandler:set_not_lan_game()
	Global.game_settings.playing_lan = nil
end

function MenuCallbackHandler:get_matchmake_attributes()
	local level_id = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
	local difficulty_id = tweak_data:difficulty_to_index(Global.game_settings.difficulty)
	local permission_id = tweak_data:permission_to_index(Global.game_settings.permission)
	local min_lvl = Global.game_settings.reputation_permission or 0
	local drop_in = Global.game_settings.drop_in_allowed and 1 or 0
	local job_id = tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id())
	return {
		numbers = {
			level_id + 1000 * job_id,
			difficulty_id,
			permission_id,
			nil,
			nil,
			drop_in,
			min_lvl
		}
	}
end

function MenuCallbackHandler:update_matchmake_attributes()
	managers.network.matchmake:set_server_attributes(self:get_matchmake_attributes())
end

function MenuCallbackHandler:create_lobby()
	managers.network.matchmake:create_lobby(self:get_matchmake_attributes())
end

function MenuCallbackHandler:play_single_player()
	Global.game_settings.single_player = true
	managers.network:host_game()
	Network:set_server()
	Global.game_settings.team_ai = true
end

function MenuCallbackHandler:play_online_game()
	Global.game_settings.single_player = false
	Global.game_settings.team_ai = true
end

function MenuCallbackHandler:play_safehouse(params)
	local function yes_func()
		self:play_single_player()
		
		Global.game_settings.team_ai = false
		Global.mission_manager.has_played_tutorial = true
		self:start_single_player_job({job_id = "safehouse", difficulty = "normal"})
	end
	
	if params.skip_question then
		yes_func()
		return
	end
	managers.menu:show_play_safehouse_question({yes_func = yes_func})
end

function MenuCallbackHandler:choice_choose_character(item)
	local character = item:value()
	local peer_id = managers.network:session():local_peer():id()
	if Network:is_server() then
		managers.network:game():on_peer_request_character(peer_id, character)
	elseif managers.network:session():server_peer() and not managers.network:session():server_peer():loading() then
		managers.network:session():send_to_host("request_character", peer_id, character)
	end
end

function MenuCallbackHandler:choice_choose_texture_quality(item)
	RenderSettings.texture_quality_default = item:value()
	Application:apply_render_settings()
	Application:save_render_settings()
end

function MenuCallbackHandler:choice_choose_anisotropic(item)
	RenderSettings.max_anisotropy = item:value()
	Application:apply_render_settings()
	Application:save_render_settings()
end

function MenuCallbackHandler:choice_fps_cap(item)
	setup:set_fps_cap(item:value())
	managers.user:set_setting("fps_cap", item:value())
end

function MenuCallbackHandler:choice_choose_color_grading(item)
	managers.user:set_setting("video_color_grading", item:value())
	if managers.environment_controller then
		managers.environment_controller:refresh_render_settings()
	end
end

function MenuCallbackHandler:choice_choose_menu_theme(item)
	managers.menu:change_theme(item:value())
end

function MenuCallbackHandler:choice_choose_anti_alias(item)
	managers.user:set_setting("video_anti_alias", item:value())
	if managers.environment_controller then
		managers.environment_controller:refresh_render_settings()
	end
end

function MenuCallbackHandler:choice_choose_anim_lod(item)
	managers.user:set_setting("video_animation_lod", item:value())
end

function MenuCallbackHandler:toggle_vsync(item)
	managers.viewport:set_vsync(item:value() == "on")
end

function MenuCallbackHandler:toggle_streaks(item)
	managers.user:set_setting("video_streaks", item:value() == "on")
	if managers.environment_controller then
		managers.environment_controller:refresh_render_settings()
	end
end

function MenuCallbackHandler:toggle_light_adaption(item)
	managers.user:set_setting("light_adaption", item:value() == "on")
	if managers.environment_controller then
		managers.environment_controller:refresh_render_settings()
	end
end

function MenuCallbackHandler:toggle_lightfx(item)
	managers.user:set_setting("use_lightfx", item:value() == "on")
end

function MenuCallbackHandler:set_fov_multiplier(item)
	local fov_multiplier = item:value()
	managers.user:set_setting("fov_multiplier", fov_multiplier)
	if alive(managers.player:player_unit()) then
		managers.player:player_unit():movement():current_state():update_fov_external()
	end
end

function MenuCallbackHandler:set_fov_standard(item)
	do return end
	local fov = item:value()
	managers.user:set_setting("fov_standard", fov)
	local item_fov_zoom = managers.menu:active_menu().logic:selected_node():item("fov_zoom")
	if fov < item_fov_zoom:value() then
		item_fov_zoom:set_value(fov)
		item_fov_zoom:trigger()
	end
	if alive(managers.player:player_unit()) then
		local plr_state = managers.player:player_unit():movement():current_state()
		local stance = plr_state:in_steelsight() and "steelsight" or plr_state._state_data.ducking and "crouched" or "standard"
		plr_state._camera_unit:base():set_stance_fov_instant(stance)
	end
end

function MenuCallbackHandler:set_fov_zoom(item)
	do return end
	local fov = item:value()
	managers.user:set_setting("fov_zoom", fov)
	local item_fov_standard = managers.menu:active_menu().logic:selected_node():item("fov_standard")
	if fov > item_fov_standard:value() then
		item_fov_standard:set_value(fov)
		item_fov_standard:trigger()
	end
	if alive(managers.player:player_unit()) then
		local plr_state = managers.player:player_unit():movement():current_state()
		local stance = plr_state:in_steelsight() and "steelsight" or plr_state._state_data.ducking and "crouched" or "standard"
		plr_state._camera_unit:base():set_stance_fov_instant(stance)
	end
end

function MenuCallbackHandler:retry_job_stage()
	managers.loot:on_retry_job_stage()
	managers.job:on_retry_job_stage()
	managers.mission:on_retry_job_stage()
	self:lobby_start_the_game()
end

function MenuCallbackHandler:on_stage_success()
	managers.mission:on_stage_success()
end

function MenuCallbackHandler:lobby_start_the_game()
	local level_id = Global.game_settings.level_id
	local level_name = level_id and tweak_data.levels[level_id].world_name
	if Global.boot_invite then
		Global.boot_invite.used = true
		Global.boot_invite.pending = false
	end
	local mission = Global.game_settings.mission ~= "none" and Global.game_settings.mission or nil
	managers.network:session():load_level(level_name, mission, nil, nil, level_id)
end

function MenuCallbackHandler:leave_lobby()
	if game_state_machine:current_state_name() == "ingame_lobby_menu" then
		self:end_game()
		return
	end
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_are_you_sure_you_want_leave")
	dialog_data.id = "leave_lobby"
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_dialog_leave_lobby_yes")
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = callback(self, self, "_dialog_leave_lobby_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:_dialog_leave_lobby_yes()
	if managers.network:session() then
		managers.network:session():local_peer():set_in_lobby(false)
		local peer_id = managers.network:session():local_peer():id()
		managers.network:session():send_to_peers("set_peer_left", peer_id)
	end
	managers.menu:on_leave_lobby()
end

function MenuCallbackHandler:_dialog_leave_lobby_no()
end

function MenuCallbackHandler:connect_to_host_rpc(item)
	local function f(res)
		if res == "JOINED_LOBBY" then
			self:on_enter_lobby()
		elseif res == "JOINED_GAME" then
			local level_id = tweak_data.levels:get_level_name_from_world_name(item:parameters().level_name)
			managers.network:session():load_level(item:parameters().level_name, nil, nil, nil, level_id, nil)
		elseif res == "KICKED" then
			managers.menu:show_peer_kicked_dialog()
		else
			Application:error("[MenuCallbackHandler:connect_to_host_rpc] FAILED TO START MULTIPLAYER!")
		end
	end
	
	managers.network:join_game_at_host_rpc(item:parameters().rpc, f)
end

function MenuCallbackHandler:host_multiplayer(item)
	managers.network:host_game()
	local level_id = item:parameters().level_id
	local level_name = level_id and tweak_data.levels[level_id].world_name
	level_id = level_id or tweak_data.levels:get_level_name_from_world_name(item:parameters().level)
	level_name = level_name or item:parameters().level or "bank"
	Global.game_settings.level_id = level_id
	managers.network:session():load_level(level_name, nil, nil, nil, level_id)
end

function MenuCallbackHandler:join_multiplayer()
	local f = function(new_host_rpc)
		if new_host_rpc then
			managers.menu:active_menu().logic:refresh_node("select_host")
		end
	end
	managers.network:discover_hosts(f)
end

function MenuCallbackHandler:find_lan_games()
	if self:is_win32() then
		local f = function(new_host_rpc)
			if new_host_rpc then
				managers.menu:active_menu().logic:refresh_node("play_lan")
			end
		end
		managers.network:discover_hosts(f)
	end
end

function MenuCallbackHandler:find_online_games_with_friends()
	self:_find_online_games(true)
end

function MenuCallbackHandler:find_online_games()
	self:_find_online_games()
end

function MenuCallbackHandler:_find_online_games(friends_only)
	if self:is_win32() then
		local function f(info)
			print("info in function")
			
			print(inspect(info))
			managers.network.matchmake:search_lobby_done()
			managers.menu:active_menu().logic:refresh_node("play_online", true, info, friends_only)
		end
		
		managers.network.matchmake:register_callback("search_lobby", f)
		managers.network.matchmake:search_lobby(friends_only)
		local usrs_f = function(success, amount)
			print("usrs_f", success, amount)
			if success then
				local stack = managers.menu:active_menu().renderer._node_gui_stack
				local node_gui = stack[#stack]
				if node_gui.set_mini_info then
					node_gui:set_mini_info(managers.localization:text("menu_players_online", {COUNT = amount}))
				end
			end
		end
		Steam:sa_handler():concurrent_users_callback(usrs_f)
		Steam:sa_handler():get_concurrent_users()
	end
	if self:is_ps3() then
		if #PSN:get_world_list() == 0 then
			return
		end
		
		local function f(info_list)
			print("info_list in function")
			print(inspect(info_list))
			managers.network.matchmake:search_lobby_done()
			managers.menu:active_menu().logic:refresh_node("play_online", true, info_list, friends_only)
		end
		
		managers.network.matchmake:register_callback("search_lobby", f)
		managers.network.matchmake:start_search_lobbys(friends_only)
	end
end

function MenuCallbackHandler:connect_to_lobby(item)
	managers.network.matchmake:join_server_with_check(item:parameters().room_id)
end

function MenuCallbackHandler:stop_multiplayer()
	Global.game_settings.single_player = false
	if managers.network:session() and managers.network:session():local_peer():id() == 1 then
		managers.network:stop_network(true)
	end
end

function MenuCallbackHandler:find_friends()
end

function MenuCallbackHandler:invite_friends()
	Steam:overlay_activate("game", "LobbyInvite")
end

function MenuCallbackHandler:invite_friend(item)
	if item:parameters().signin_status ~= "signed_in" then
		return
	end
	managers.network.matchmake:send_join_invite(item:parameters().friend)
end

function MenuCallbackHandler:invite_friends_X360()
	local platform_id = managers.user:get_platform_id()
	XboxLive:show_friends_ui(platform_id)
end

function MenuCallbackHandler:invite_xbox_live_party()
	local platform_id = managers.user:get_platform_id()
	XboxLive:show_party_ui(platform_id)
end

function MenuCallbackHandler:view_invites()
	print("View invites")
	print(PSN:display_message_invitation())
end

function MenuCallbackHandler:kick_player(item)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_mp_kick_player_title")
	dialog_data.text = managers.localization:text("dialog_mp_kick_player_message", {
		PLAYER = item:parameters().peer:name()
	})
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	
	function yes_button.callback_func()
		local peer = item:parameters().peer
		managers.network:session():send_to_peers("kick_peer", peer:id())
		managers.network:session():on_peer_kicked(peer, peer:id())
		managers.menu:back(true)
	end
	
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:mute_player(item)
	if managers.network.voice_chat then
		managers.network.voice_chat:mute_player(item:parameters().peer, item:value() == "on")
	end
end

function MenuCallbackHandler:mute_xbox_player(item)
	if managers.network.voice_chat then
		managers.network.voice_chat:set_muted(item:parameters().xuid, item:value() == "on")
	end
end

function MenuCallbackHandler:view_gamer_card(item)
	XboxLive:show_gamer_card_ui(managers.user:get_platform_id(), item:parameters().xuid)
end

function MenuCallbackHandler:save_settings()
	managers.savefile:save_setting(true)
end

function MenuCallbackHandler:save_progress()
	managers.savefile:save_progress()
end

function MenuCallbackHandler:debug_level_jump(item)
	local param_map = item:parameters()
	managers.network:host_game()
	local level_id = tweak_data.levels:get_level_name_from_world_name(param_map.level)
	managers.network:session():load_level(param_map.level, param_map.mission, param_map.world_setting, param_map.level_class_name, level_id, nil)
end

function MenuCallbackHandler:save_game(item)
	if not managers.savefile:is_active() then
		local param_map = item:parameters()
		managers.savefile:save_game(param_map.slot, false)
		if managers.savefile:is_active() then
			managers.menu:set_save_game_callback(callback(self, self, "save_game_callback"))
		else
			self:save_game_callback()
		end
	end
end

function MenuCallbackHandler:save_game_callback()
	managers.menu:set_save_game_callback(nil)
	managers.menu:back()
end

function MenuCallbackHandler:restart_game(item)
	managers.menu:show_restart_game_dialog({
		yes_func = function()
			if managers.job:stage_success() then
				print("No restart after stage success")
				return
			end
			managers.statistics:stop_session()
			managers.savefile:save_progress()
			managers.groupai:state():set_AI_enabled(false)
			if Network:multiplayer() and managers.network:game() and Global.local_member then
				Global.local_member:delete()
			end
			self:retry_job_stage()
		end
	})
end

function MenuCallbackHandler:start_credits(item)
	managers.timeline:debug_level_jump("credits_fortress2", nil, nil, "CreditsFotressLevel")
end

function MenuCallbackHandler:set_music_volume(item)
	local volume = item:value()
	local old_volume = managers.user:get_setting("music_volume")
	managers.user:set_setting("music_volume", volume)
	if volume > old_volume then
		self._sound_source:post_event("menu_music_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("menu_music_decrease")
	end
end

function MenuCallbackHandler:set_sfx_volume(item)
	local volume = item:value()
	local old_volume = managers.user:get_setting("sfx_volume")
	managers.user:set_setting("sfx_volume", volume)
	if volume > old_volume then
		self._sound_source:post_event("menu_sfx_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("menu_sfx_decrease")
	end
end

function MenuCallbackHandler:set_voice_volume(item)
	local volume = item:value()
	managers.user:set_setting("voice_volume", volume)
end

function MenuCallbackHandler:set_brightness(item)
	local brightness = item:value()
	managers.user:set_setting("brightness", brightness)
end

function MenuCallbackHandler:set_effect_quality(item)
	local effect_quality = item:value()
	managers.user:set_setting("effect_quality", effect_quality)
end

function MenuCallbackHandler:set_camera_sensitivity(item)
	local value = item:value()
	managers.user:set_setting("camera_sensitivity", value)
	if not managers.user:get_setting("enable_camera_zoom_sensitivity") then
		local item_other_sens = managers.menu:active_menu().logic:selected_node():item("camera_zoom_sensitivity")
		if item_other_sens and item_other_sens:visible() and math.abs(value - item_other_sens:value()) > 0.001 then
			item_other_sens:set_value(value)
			item_other_sens:trigger()
		end
	end
end

function MenuCallbackHandler:set_camera_zoom_sensitivity(item)
	local value = item:value()
	managers.user:set_setting("camera_zoom_sensitivity", value)
	if not managers.user:get_setting("enable_camera_zoom_sensitivity") then
		local item_other_sens = managers.menu:active_menu().logic:selected_node():item("camera_sensitivity")
		if item_other_sens and item_other_sens:visible() and math.abs(value - item_other_sens:value()) > 0.001 then
			item_other_sens:set_value(value)
			item_other_sens:trigger()
		end
	end
end

function MenuCallbackHandler:toggle_zoom_sensitivity(item)
	local value = item:value() == "on"
	managers.user:set_setting("enable_camera_zoom_sensitivity", value)
	if value == false then
		local item_sens = managers.menu:active_menu().logic:selected_node():item("camera_sensitivity")
		local item_sens_zoom = managers.menu:active_menu().logic:selected_node():item("camera_zoom_sensitivity")
		item_sens_zoom:set_value(item_sens:value())
		item_sens_zoom:trigger()
	end
end

function MenuCallbackHandler:is_current_resolution(item)
	return item:name() == string.format("%d x %d", RenderSettings.resolution.x, RenderSettings.resolution.y)
end

function MenuCallbackHandler:end_game()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_are_you_sure_you_want_to_leave_game")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_dialog_end_game_yes")
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = callback(self, self, "_dialog_end_game_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:_dialog_end_game_yes()
	managers.statistics:stop_session()
	managers.savefile:save_progress()
	managers.job:deactivate_current_job()
	if Network:multiplayer() then
		Network:set_multiplayer(false)
		local peer_id = managers.network:session():local_peer():id()
		managers.network:session():send_to_peers("set_peer_left", peer_id)
		managers.network:queue_stop_network()
	end
	managers.network.matchmake:destroy_game()
	managers.network.voice_chat:destroy_voice()
	managers.groupai:state():set_AI_enabled(false)
	managers.menu:post_event("menu_exit")
	managers.menu:close_menu("menu_pause")
	setup:load_start_menu()
end

function MenuCallbackHandler:leave_safehouse()
	local function yes_func()
		self:_dialog_end_game_yes()
	end
	
	managers.menu:show_leave_safehouse_dialog({yes_func = yes_func})
end

function MenuCallbackHandler:abort_mission()
	local function yes_func()
		self:load_start_menu_lobby()
	end
	
	managers.menu:show_abort_mission_dialog({yes_func = yes_func})
end

function MenuCallbackHandler:load_start_menu_lobby()
	managers.network:session():load_lobby()
end

function MenuCallbackHandler:_dialog_end_game_no()
end

function MenuCallbackHandler:set_default_options()
	managers.menu:show_default_option_dialog()
end

function MenuCallbackHandler:resume_game()
	managers.menu:close_menu("menu_pause")
end

function MenuCallbackHandler:change_upgrade(menu_item)
	cat_print("johan", "change upgrade")
end

function MenuCallbackHandler:delayed_open_savefile_menu(item)
	if not self._delayed_open_savefile_menu_callback then
		if managers.savefile:is_active() then
			managers.menu:set_delayed_open_savefile_menu_callback(callback(self, self, "open_savefile_menu", item))
		else
			self:open_savefile_menu(item)
		end
	end
end

function MenuCallbackHandler:open_savefile_menu(item)
	managers.menu:set_delayed_open_savefile_menu_callback(nil)
	local parameter_map = item:parameters()
	managers.menu:open_node(parameter_map.delayed_node, {parameter_map})
end

function MenuCallbackHandler:give_weapon()
	local player = managers.player:player_unit()
	if player then
		player:inventory():add_unit_by_name(Idstring("units/weapons/mp5/mp5"), false)
	end
end

function MenuCallbackHandler:give_experience()
	managers.experience:debug_add_points(2500, true)
end

function MenuCallbackHandler:give_more_experience()
	managers.experience:debug_add_points(250000, false)
end

function MenuCallbackHandler:give_max_experience()
	managers.experience:debug_add_points(360000, false)
end

function MenuCallbackHandler:debug_next_stage()
	game_state_machine:change_state_by_name("victoryscreen", {
		num_winners = 2,
		personal_win = alive(managers.player:player_unit())
	})
end

function MenuCallbackHandler:debug_give_alot_of_lootdrops()
	for i = 1, 7 do
		managers.lootdrop:debug_drop(1000, true, i)
	end
end

function MenuCallbackHandler:debug_give_money()
	managers.money:debug_job_completed(3)
end

function MenuCallbackHandler:debug_give_alot_of_money()
	for stars = 1, 7 do
		for i = 1, 10 do
			managers.money:debug_job_completed(stars)
		end
	end
end

function MenuCallbackHandler:debug_show_marketplace_ui()
	XboxLive:show_marketplace_ui(0)
end

function MenuCallbackHandler:hide_huds()
	managers.hud:set_disabled()
end

function MenuCallbackHandler:toggle_hide_huds(item)
	if item:value() == "on" then
		managers.hud:set_disabled()
	else
		managers.hud:set_enabled()
	end
end

function MenuCallbackHandler:toggle_mission_fading_debug_enabled(item)
	managers.mission:set_fading_debug_enabled(item:value() == "off")
end

function MenuCallbackHandler:clear_progress()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_are_you_sure_you_want_to_clear_progress")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_dialog_clear_progress_yes")
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = callback(self, self, "_dialog_clear_progress_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:_dialog_clear_progress_yes()
	managers.menu:do_clear_progress()
	if managers.menu_component then
		managers.menu_component:refresh_player_profile_gui()
	end
	managers.savefile:save_progress()
	managers.savefile:save_setting(true)
end

function MenuCallbackHandler:_dialog_clear_progress_no()
end

function MenuCallbackHandler:reset_statistics()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_are_you_sure_you_want_to_reset_statistics")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = callback(self, self, "_dialog_reset_statistics_yes")
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = callback(self, self, "_dialog_reset_statistics_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:_dialog_reset_statistics_yes()
	managers.statistics:reset()
	managers.savefile:save_progress()
end

function MenuCallbackHandler:_dialog_reset_statistics_no()
end

function MenuCallbackHandler:set_default_controller(item)
	managers.controller:load_settings("settings/controller_settings")
	managers.controller:clear_user_mod()
	managers.menu:back(true)
end

function MenuCallbackHandler:debug_modify_challenge(item)
	managers.challenges:debug_set_amount(item:parameters().challenge, item:parameters().count - 1)
	managers.menu:back(true)
	managers.menu:open_node("modify_active_challenges")
end

MenuChallenges = MenuChallenges or class()

function MenuChallenges:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	for _, data in pairs(managers.challenges:get_near_completion()) do
		local title_text = managers.challenges:get_title_text(data.id)
		local description_text = managers.challenges:get_description_text(data.id)
		local params = {
			name = data.id,
			text_id = string.upper(title_text),
			description_text = string.upper(description_text),
			localize = "false",
			challenge = data.id
		}
		local new_item = new_node:create_item({
			type = "MenuItemChallenge"
		}, params)
		new_node:add_item(new_item)
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuChallengesAwarded = MenuChallengesAwarded or class()

function MenuChallengesAwarded:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	for _, data in pairs(managers.challenges:get_completed()) do
		local params = {
			name = data.id,
			text_id = string.upper(data.name),
			description_text = string.upper(data.description),
			localize = "false",
			challenge = data.id,
			awarded = true
		}
		local new_item = new_node:create_item({
			type = "MenuItemChallenge"
		}, params)
		new_node:add_item(new_item)
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuModifyActiveChallenges = MenuModifyActiveChallenges or class()

function MenuModifyActiveChallenges:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	for _, data in pairs(managers.challenges:get_near_completion()) do
		if data.count > 1 then
			local title_text = managers.challenges:get_title_text(data.id)
			local description_text = managers.challenges:get_description_text(data.id)
			local params = {
				name = data.id,
				text_id = string.upper(title_text),
				description_text = string.upper(description_text),
				localize = "false",
				challenge = data.id,
				count = data.count,
				callback = "debug_modify_challenge"
			}
			local new_item = new_node:create_item({
				type = "MenuItemChallenge"
			}, params)
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuUpgrades = MenuUpgrades or class()

function MenuUpgrades:modify_node(node, up, ...)
	local new_node = up and node or deep_clone(node)
	local tree = new_node:parameters().tree
	local first_locked = true
	for i, upgrade_id in ipairs(tweak_data.upgrades.progress[tree]) do
		local title = managers.upgrades:title(upgrade_id) or managers.upgrades:name(upgrade_id)
		local subtitle = managers.upgrades:subtitle(upgrade_id)
		local params = {
			step = i,
			tree = tree,
			name = upgrade_id,
			upgrade_id = upgrade_id,
			text_id = string.upper(title and subtitle or title),
			topic_text = subtitle and title and string.upper(title),
			localize = "false"
		}
		if tweak_data.upgrades.visual.upgrade[upgrade_id] and not tweak_data.upgrades.visual.upgrade[upgrade_id].base and i <= managers.upgrades:progress_by_tree(tree) then
			params.callback = "toggle_visual_upgrade"
		end
		if managers.upgrades:is_locked(i) and first_locked then
			first_locked = false
			new_node:add_item(new_node:create_item({
				type = "MenuItemUpgrade"
			}, {
				name = "upgrade_lock",
				text_id = managers.localization:text("menu_upgrades_locked", {
					LEVEL = managers.upgrades:get_level_from_step(i)
				}),
				localize = "false",
				upgrade_lock = true
			}))
		end
		local new_item = new_node:create_item({
			type = "MenuItemUpgrade"
		}, params)
		new_node:add_item(new_item)
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

function MenuCallbackHandler:toggle_visual_upgrade(item)
	managers.upgrades:toggle_visual_weapon_upgrade(item:parameters().upgrade_id)
	managers.upgrades:setup_current_weapon()
	if managers.upgrades:visual_weapon_upgrade_active(item:parameters().upgrade_id) then
		self._sound_source:post_event("box_tick")
	else
		self._sound_source:post_event("box_untick")
	end
	print("Toggled", item:parameters().upgrade_id)
end

InviteFriendsPSN = InviteFriendsPSN or class()

function InviteFriendsPSN:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	local f2 = function(friends)
		managers.menu:active_menu().logic:refresh_node("invite_friends", true, friends)
	end
	managers.network.friends:register_callback("get_friends_done", f2)
	managers.network.friends:register_callback("status_change", function()
	end)
	managers.network.friends:get_friends(new_node)
	return new_node
end

function InviteFriendsPSN:refresh_node(node, friends)
	for i, friend in ipairs(friends) do
		if i < 103 then
			local name = tostring(friend._name)
			local signin_status = friend._signin_status
			local item = node:item(name)
			if not item then
				local params = {
					name = name,
					friend = friend._id,
					text_id = utf8.to_upper(friend._name),
					signin_status = signin_status,
					callback = "invite_friend",
					localize = "false"
				}
				local new_item = node:create_item({
					type = "MenuItemFriend"
				}, params)
				node:add_item(new_item)
			elseif item:parameters().signin_status ~= signin_status then
				item:parameters().signin_status = signin_status
			end
		end
	end
	return node
end

function InviteFriendsPSN:update_node(node)
	if self._update_friends_t and self._update_friends_t > Application:time() then
		return
	end
	self._update_friends_t = Application:time() + 2
	managers.network.friends:get_friends()
end

InviteFriendsSTEAM = InviteFriendsSTEAM or class()

function InviteFriendsSTEAM:modify_node(node, up)
	return node
end

function InviteFriendsSTEAM:refresh_node(node, friend)
	return node
end

function InviteFriendsSTEAM:update_node(node)
end

KickPlayer = KickPlayer or class()

function KickPlayer:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name(),
				callback = "kick_player",
				to_upper = false,
				localize = "false",
				rpc = peer:rpc(),
				peer = peer
			}
			local new_item = node:create_item(nil, params)
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MutePlayer = MutePlayer or class()

function MutePlayer:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name(),
				callback = "mute_player",
				to_upper = false,
				localize = "false",
				rpc = peer:rpc(),
				peer = peer
			}
			local data = {
				type = "CoreMenuItemToggle.ItemToggle",
				{
					_meta = "option",
					icon = "guis/textures/menu_tickbox",
					value = "on",
					x = 24,
					y = 0,
					w = 24,
					h = 24,
					s_icon = "guis/textures/menu_tickbox",
					s_x = 24,
					s_y = 24,
					s_w = 24,
					s_h = 24
				},
				{
					_meta = "option",
					icon = "guis/textures/menu_tickbox",
					value = "off",
					x = 0,
					y = 0,
					w = 24,
					h = 24,
					s_icon = "guis/textures/menu_tickbox",
					s_x = 0,
					s_y = 24,
					s_w = 24,
					s_h = 24
				}
			}
			local new_item = node:create_item(data, params)
			new_item:set_value(managers.network.voice_chat:is_muted(peer) and "on" or "off")
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MutePlayerX360 = MutePlayerX360 or class()

function MutePlayerX360:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name(),
				callback = "mute_xbox_player",
				to_upper = false,
				localize = "false",
				rpc = peer:rpc(),
				peer = peer,
				xuid = peer:xuid()
			}
			local data = {
				type = "CoreMenuItemToggle.ItemToggle",
				{
					_meta = "option",
					icon = "guis/textures/menu_tickbox",
					value = "on",
					x = 24,
					y = 0,
					w = 24,
					h = 24,
					s_icon = "guis/textures/menu_tickbox",
					s_x = 24,
					s_y = 24,
					s_w = 24,
					s_h = 24
				},
				{
					_meta = "option",
					icon = "guis/textures/menu_tickbox",
					value = "off",
					x = 0,
					y = 0,
					w = 24,
					h = 24,
					s_icon = "guis/textures/menu_tickbox",
					s_x = 0,
					s_y = 24,
					s_w = 24,
					s_h = 24
				}
			}
			local new_item = node:create_item(data, params)
			new_item:set_value(managers.network.voice_chat:is_muted(peer:xuid()) and "on" or "off")
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

ViewGamerCard = ViewGamerCard or class()

function ViewGamerCard:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name(),
				callback = "view_gamer_card",
				to_upper = false,
				localize = "false",
				xuid = peer:xuid()
			}
			local new_item = node:create_item(nil, params)
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuPSNHostBrowser = MenuPSNHostBrowser or class()

function MenuPSNHostBrowser:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	return new_node
end

function MenuPSNHostBrowser:update_node(node)
	if #PSN:get_world_list() == 0 then
		return
	end
	managers.network.matchmake:start_search_lobbys(managers.network.matchmake:searching_friends_only())
end

function MenuPSNHostBrowser:add_filter(node)
	if node:item("difficulty_filter") then
		return
	end
	local params = {
		name = "difficulty_filter",
		text_id = "menu_diff_filter",
		help_id = "menu_diff_filter_help",
		visible_callback = "is_ps3",
		callback = "choice_difficulty_filter_ps3",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_all",
			value = 0
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_easy",
			value = 1
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_normal",
			value = 2
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_hard",
			value = 3
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_overkill",
			value = 4
		}
	}
	if managers.experience:current_level() >= 145 then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_difficulty_overkill_145",
			value = 5
		})
	end
	local new_item = node:create_item(data_node, params)
	new_item:set_value(managers.network.matchmake:difficulty_filter())
	node:add_item(new_item)
end

function MenuPSNHostBrowser:refresh_node(node, info_list, friends_only)
	local new_node = node
	if not friends_only then
		self:add_filter(new_node)
	end
	if not info_list then
		return new_node
	end
	local dead_list = {}
	for _, item in ipairs(node:items()) do
		if not item:parameters().filter then
			dead_list[item:parameters().name] = true
		end
	end
	for _, info in ipairs(info_list) do
		local room_list = info.room_list
		local attribute_list = info.attribute_list
		for i, room in ipairs(room_list) do
			local name_str = tostring(room.owner_id)
			local friend_str = room.friend_id and tostring(room.friend_id)
			local attributes_numbers = attribute_list[i].numbers
			if managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers) then
				dead_list[name_str] = nil
				local host_name = name_str
				local level_id = attributes_numbers and tweak_data.levels:get_level_name_from_index(attributes_numbers[1] % 1000)
				local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id or "N/A"
				local level_name = name_id and managers.localization:text(name_id) or "LEVEL NAME ERROR"
				local difficulty = attributes_numbers and tweak_data:index_to_difficulty(attributes_numbers[2]) or "N/A"
				local state_string_id = attributes_numbers and tweak_data:index_to_server_state(attributes_numbers[4]) or nil
				local state_name = state_string_id and managers.localization:text("menu_lobby_server_state_" .. state_string_id) or "N/A"
				local state = attributes_numbers or "N/A"
				local item = new_node:item(name_str)
				local num_plrs = attributes_numbers and attributes_numbers[8] or 1
				if not item then
					local params = {
						name = name_str,
						text_id = name_str,
						room_id = room.room_id,
						columns = {
							string.upper(friend_str or host_name),
							string.upper(level_name),
							string.upper(state_name),
							tostring(num_plrs) .. "/4 "
						},
						level_name = level_id or "N/A",
						real_level_name = level_name,
						level_id = level_id,
						state_name = state_name,
						difficulty = difficulty,
						host_name = host_name,
						state = state,
						num_plrs = num_plrs,
						callback = "connect_to_lobby",
						localize = "false"
					}
					local new_item = new_node:create_item({
						type = "ItemServerColumn"
					}, params)
					new_node:add_item(new_item)
				else
					if item:parameters().real_level_name ~= level_name then
						item:parameters().columns[2] = string.upper(level_name)
						item:parameters().level_name = level_id
						item:parameters().level_id = level_id
						item:parameters().real_level_name = level_name
					end
					if item:parameters().state ~= state then
						item:parameters().columns[3] = state_name
						item:parameters().state = state
						item:parameters().state_name = state_name
					end
					if item:parameters().difficulty ~= difficulty then
						item:parameters().difficulty = difficulty
					end
					if item:parameters().room_id ~= room.room_id then
						item:parameters().room_id = room.room_id
					end
					if item:parameters().num_plrs ~= num_plrs then
						item:parameters().num_plrs = num_plrs
						item:parameters().columns[4] = tostring(num_plrs) .. "/4 "
					end
				end
			end
		end
	end
	for name, _ in pairs(dead_list) do
		new_node:delete_item(name)
	end
	return new_node
end

MenuSTEAMHostBrowser = MenuSTEAMHostBrowser or class()

function MenuSTEAMHostBrowser:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	return new_node
end

function MenuSTEAMHostBrowser:update_node(node)
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
end

function MenuSTEAMHostBrowser:add_filter(node)
	if node:item("server_filter") then
		return
	end
	local params = {
		name = "server_filter",
		text_id = "menu_dist_filter",
		help_id = "menu_dist_filter_help",
		visible_callback = "is_pc_controller",
		callback = "choice_distance_filter",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_dist_filter_close",
			value = -1
		},
		{
			_meta = "option",
			text_id = "menu_dist_filter_far",
			value = 2
		},
		{
			_meta = "option",
			text_id = "menu_dist_filter_worldwide",
			value = 3
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_value(managers.network.matchmake:distance_filter())
	node:add_item(new_item)
	local params = {
		name = "difficulty_filter",
		text_id = "menu_diff_filter",
		help_id = "menu_diff_filter_help",
		visible_callback = "is_pc_controller",
		callback = "choice_difficulty_filter",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_all",
			value = 0
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_easy",
			value = 1
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_normal",
			value = 2
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_hard",
			value = 3
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_overkill",
			value = 4
		}
	}
	if managers.experience:current_level() >= 145 then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_difficulty_overkill_145",
			value = 5
		})
	end
	local new_item = node:create_item(data_node, params)
	new_item:set_value(managers.network.matchmake:difficulty_filter())
	node:add_item(new_item)
end

function MenuSTEAMHostBrowser:refresh_node(node, info, friends_only)
	local new_node = node
	if not friends_only then
		self:add_filter(new_node)
	end
	if not info then
		managers.menu:add_back_button(new_node)
		return new_node
	end
	local room_list = info.room_list
	local attribute_list = info.attribute_list
	local dead_list = {}
	for _, item in ipairs(node:items()) do
		if not item:parameters().back and not item:parameters().filter then
			dead_list[item:parameters().room_id] = true
		end
	end
	for i, room in ipairs(room_list) do
		local name_str = tostring(room.owner_name)
		local attributes_numbers = attribute_list[i].numbers
		if managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers) then
			dead_list[room.room_id] = nil
			local host_name = name_str
			local level_id = tweak_data.levels:get_level_name_from_index(attributes_numbers[1] % 1000)
			local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id
			local level_name = name_id and managers.localization:text(name_id) or "LEVEL NAME ERROR"
			local difficulty = tweak_data:index_to_difficulty(attributes_numbers[2])
			local state_string_id = tweak_data:index_to_server_state(attributes_numbers[4])
			local state_name = state_string_id and managers.localization:text("menu_lobby_server_state_" .. state_string_id) or "blah"
			local state = attributes_numbers[4]
			local num_plrs = attributes_numbers[5]
			local item = new_node:item(room.room_id)
			if not item then
				print("ADD", name_str)
				local params = {
					name = room.room_id,
					text_id = name_str,
					room_id = room.room_id,
					columns = {
						string.upper(host_name),
						string.upper(level_name),
						string.upper(state_name),
						tostring(num_plrs) .. "/4 "
					},
					level_name = level_id,
					real_level_name = level_name,
					level_id = level_id,
					state_name = state_name,
					difficulty = difficulty,
					host_name = host_name,
					state = state,
					num_plrs = num_plrs,
					callback = "connect_to_lobby",
					localize = "false"
				}
				local new_item = new_node:create_item({
					type = "ItemServerColumn"
				}, params)
				new_node:add_item(new_item)
			else
				if item:parameters().real_level_name ~= level_name then
					item:parameters().columns[2] = string.upper(level_name)
					item:parameters().level_name = level_id
					item:parameters().level_id = level_id
					item:parameters().real_level_name = level_name
				end
				if item:parameters().state ~= state then
					item:parameters().columns[3] = state_name
					item:parameters().state = state
					item:parameters().state_name = state_name
				end
				if item:parameters().difficulty ~= difficulty then
					item:parameters().difficulty = difficulty
				end
				if item:parameters().room_id ~= room.room_id then
					item:parameters().room_id = room.room_id
				end
				if item:parameters().num_plrs ~= num_plrs then
					item:parameters().num_plrs = num_plrs
					item:parameters().columns[4] = tostring(num_plrs) .. "/4 "
				end
			end
		end
	end
	for name, _ in pairs(dead_list) do
		new_node:delete_item(name)
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuLANHostBrowser = MenuLANHostBrowser or class()

function MenuLANHostBrowser:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	return new_node
end

function MenuLANHostBrowser:refresh_node(node)
	local new_node = node
	local hosts = managers.network:session():discovered_hosts()
	for _, host_data in ipairs(hosts) do
		local host_rpc = host_data.rpc
		local name_str = host_data.host_name .. ", " .. host_rpc:to_string()
		local level_id = tweak_data.levels:get_level_name_from_world_name(host_data.level_name)
		local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id
		local level_name = name_id and managers.localization:text(name_id) or host_data.level_name
		local state_name = host_data.state == 1 and managers.localization:text("menu_lobby_server_state_in_lobby") or managers.localization:text("menu_lobby_server_state_in_game")
		local item = new_node:item(name_str)
		if not item then
			local params = {
				name = name_str,
				text_id = name_str,
				columns = {
					string.upper(host_data.host_name),
					string.upper(level_name),
					string.upper(state_name)
				},
				rpc = host_rpc,
				level_name = host_data.level_name,
				real_level_name = level_name,
				level_id = level_id,
				state_name = state_name,
				difficulty = host_data.difficulty,
				host_name = host_data.host_name,
				state = host_data.state,
				callback = "connect_to_host_rpc",
				localize = "false"
			}
			local new_item = new_node:create_item({
				type = "ItemServerColumn"
			}, params)
			new_node:add_item(new_item)
		else
			if item:parameters().real_level_name ~= level_name then
				item:parameters().columns[2] = string.upper(level_name)
				item:parameters().level_name = host_data.level_name
				item:parameters().real_level_name = level_name
			end
			if item:parameters().state ~= host_data.state then
				item:parameters().columns[3] = state_name
				item:parameters().state = host_data.state
			end
			if item:parameters().difficulty ~= host_data.difficulty then
				item:parameters().difficulty = host_data.difficulty
			end
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuMPHostBrowser = MenuMPHostBrowser or class()

function MenuMPHostBrowser:modify_node(node, up)
	local new_node = up and node or deep_clone(node)
	managers.menu:add_back_button(new_node)
	return new_node
end

function MenuMPHostBrowser:refresh_node(node)
	local new_node = node
	local hosts = managers.network:session():discovered_hosts()
	local j = 1
	for _, host_data in ipairs(hosts) do
		local host_rpc = host_data.rpc
		local name_str = host_data.host_name .. ", " .. host_rpc:to_string()
		local level_id = tweak_data.levels:get_level_name_from_world_name(host_data.level_name)
		local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id
		local level_name = name_id and managers.localization:text(name_id) or host_data.level_name
		local state_name = host_data.state == 1 and managers.localization:text("menu_lobby_server_state_in_lobby") or managers.localization:text("menu_lobby_server_state_in_game")
		local item = new_node:item(name_str)
		if not item then
			local params = {
				name = name_str,
				text_id = name_str,
				columns = {
					string.upper(host_data.host_name),
					string.upper(level_name),
					string.upper(state_name)
				},
				rpc = host_rpc,
				level_name = host_data.level_name,
				real_level_name = level_name,
				level_id = level_id,
				state_name = state_name,
				difficulty = host_data.difficulty,
				host_name = host_data.host_name,
				state = host_data.state,
				callback = "connect_to_host_rpc",
				localize = "false"
			}
			local new_item = new_node:create_item({
				type = "ItemServerColumn"
			}, params)
			new_node:add_item(new_item)
		else
			if item:parameters().real_level_name ~= level_name then
				print("Update level_name - ", level_name)
				item:parameters().columns[2] = string.upper(level_name)
				item:parameters().level_name = host_data.level_name
				item:parameters().real_level_name = level_name
			end
			if item:parameters().state ~= host_data.state then
				item:parameters().columns[3] = state_name
				item:parameters().state = host_data.state
			end
			if item:parameters().difficulty ~= host_data.difficulty then
				item:parameters().difficulty = host_data.difficulty
			end
		end
		j = j + 1
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuResolutionCreator = MenuResolutionCreator or class()

function MenuResolutionCreator:modify_node(node)
	local new_node = deep_clone(node)
	if SystemInfo:platform() == Idstring("WIN32") then
		for _, res in ipairs(RenderSettings.modes) do
			local res_string = string.format("%d x %d", res.x, res.y)
			if not new_node:item(res_string) then
				local params = {
					name = res_string,
					text_id = res_string,
					resolution = res,
					callback = "change_resolution",
					localize = "false",
					icon = "guis/textures/scrollarrow",
					icon_rotation = 90,
					icon_visible_callback = "is_current_resolution"
				}
				local new_item = new_node:create_item(nil, params)
				new_node:add_item(new_item)
			end
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuSoundCreator = MenuSoundCreator or class()

function MenuSoundCreator:modify_node(node)
	local music_item = node:item("music_volume")
	if music_item then
		music_item:set_min(_G.tweak_data.menu.MIN_MUSIC_VOLUME)
		music_item:set_max(_G.tweak_data.menu.MAX_MUSIC_VOLUME)
		music_item:set_step(_G.tweak_data.menu.MUSIC_CHANGE)
		music_item:set_value(managers.user:get_setting("music_volume"))
	end
	local sfx_item = node:item("sfx_volume")
	if sfx_item then
		sfx_item:set_min(_G.tweak_data.menu.MIN_SFX_VOLUME)
		sfx_item:set_max(_G.tweak_data.menu.MAX_SFX_VOLUME)
		sfx_item:set_step(_G.tweak_data.menu.SFX_CHANGE)
		sfx_item:set_value(managers.user:get_setting("sfx_volume"))
	end
	local voice_item = node:item("voice_volume")
	if voice_item then
		voice_item:set_min(_G.tweak_data.menu.MIN_VOICE_VOLUME)
		voice_item:set_max(_G.tweak_data.menu.MAX_VOICE_VOLUME)
		voice_item:set_step(_G.tweak_data.menu.VOICE_CHANGE)
		voice_item:set_value(managers.user:get_setting("voice_volume"))
	end
	local option_value = "on"
	local st_item = node:item("toggle_voicechat")
	if st_item then
		if not managers.user:get_setting("voice_chat") then
			option_value = "off"
		end
		st_item:set_value(option_value)
	end
	option_value = "on"
	local st_item = node:item("toggle_push_to_talk")
	if st_item then
		if not managers.user:get_setting("push_to_talk") then
			option_value = "off"
		end
		st_item:set_value(option_value)
	end
	return node
end

function MenuManager.refresh_level_select(node, verify_dlc_owned)
	if verify_dlc_owned and tweak_data.levels[Global.game_settings.level_id].dlc then
		local dlcs = string.split(managers.dlc:dlcs_string(), " ")
		if not table.contains(dlcs, tweak_data.levels[Global.game_settings.level_id].dlc) then
			Global.game_settings.level_id = "bank"
		end
	end
	local min_difficulty = 0
	for _, item in ipairs(node:items()) do
		local level_id = item:parameter("level_id")
		if level_id then
			if level_id == Global.game_settings.level_id then
				item:set_value("on")
				min_difficulty = tonumber(item:parameter("difficulty"))
			elseif item:visible() then
				item:set_value("off")
			end
		end
	end
	Global.game_settings.difficulty = min_difficulty < tweak_data:difficulty_to_index(Global.game_settings.difficulty) and Global.game_settings.difficulty or tweak_data:index_to_difficulty(min_difficulty)
	local item_difficulty = node:item("lobby_difficulty")
	if item_difficulty then
		for i, option in ipairs(item_difficulty:options()) do
			option:parameters().exclude = min_difficulty > tonumber(option:parameters().difficulty)
		end
		item_difficulty:set_value(Global.game_settings.difficulty)
	end
	local lobby_mission_item = node:item("lobby_mission")
	local mission_data = tweak_data.levels[Global.game_settings.level_id].mission_data
	if lobby_mission_item then
		print("lobby_mission_item")
		local params = {
			name = "lobby_mission",
			text_id = "menu_choose_mission",
			callback = "choice_lobby_mission",
			localize = "false"
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		if mission_data then
			for _, data in ipairs(mission_data) do
				table.insert(data_node, {
					_meta = "option",
					localize = false,
					text_id = data.mission,
					value = data.mission
				})
			end
		else
			table.insert(data_node, {
				_meta = "option",
				localize = false,
				text_id = "none",
				value = "none"
			})
		end
		lobby_mission_item:init(data_node, params)
		lobby_mission_item:set_callback_handler(MenuCallbackHandler:new())
		lobby_mission_item:set_value(data_node[1].value)
	end
	Global.game_settings.mission = mission_data and mission_data[1] and mission_data[1].mission or "none"
end

MenuPSNPlayerProfileInitiator = MenuPSNPlayerProfileInitiator or class()

function MenuPSNPlayerProfileInitiator:modify_node(node)
	if managers.menu:is_ps3() and not managers.network:session() then
		PSN:set_online_callback(callback(managers.menu, managers.menu, "refresh_player_profile_gui"))
	end
	return node
end

GlobalSuccessRateInitiator = GlobalSuccessRateInitiator or class()

function GlobalSuccessRateInitiator:modify_node(node)
	managers.menu:show_global_success(node)
	return node
end

SinglePlayerOptionInitiator = SinglePlayerOptionInitiator or class()

function SinglePlayerOptionInitiator:modify_node(node)
	MenuManager.refresh_level_select(node, true)
	local item_lobby_toggle_ai = node:item("toggle_ai")
	item_lobby_toggle_ai:set_value(Global.game_settings.team_ai and "on" or "off")
	local character_item = node:item("choose_character")
	if character_item then
		managers.network:game():on_peer_request_character(1, character_item:value())
	end
	return node
end

LobbyOptionInitiator = LobbyOptionInitiator or class()

function LobbyOptionInitiator:modify_node(node)
	MenuManager.refresh_level_select(node, Network:is_server())
	local item_permission_campaign = node:item("lobby_permission")
	if item_permission_campaign then
		item_permission_campaign:set_value(Global.game_settings.permission)
	end
	local item_lobby_toggle_drop_in = node:item("toggle_drop_in")
	if item_lobby_toggle_drop_in then
		item_lobby_toggle_drop_in:set_value(Global.game_settings.drop_in_allowed and "on" or "off")
	end
	local item_lobby_toggle_ai = node:item("toggle_ai")
	if item_lobby_toggle_ai then
		item_lobby_toggle_ai:set_value(Global.game_settings.team_ai and "on" or "off")
	end
	local character_item = node:item("choose_character")
	if character_item then
		local value = managers.network:session() and managers.network:session():local_peer():character() or "random"
		character_item:set_value(value)
	end
	local reputation_permission_item = node:item("lobby_reputation_permission")
	if reputation_permission_item then
		print("reputation_permission_item", "set value", Global.game_settings.reputation_permission, type_name(Global.game_settings.reputation_permission))
		reputation_permission_item:set_value(Global.game_settings.reputation_permission)
	end
	return node
end

VerifyLevelOptionInitiator = VerifyLevelOptionInitiator or class()

function VerifyLevelOptionInitiator:modify_node(node)
	MenuManager.refresh_level_select(node, true)
	return node
end

MaskOptionInitiator = MaskOptionInitiator or class()

function MaskOptionInitiator:modify_node(node)
	local choose_mask = node:item("choose_mask")
	if not choose_mask then
		return node
	end
	local params = {
		name = "choose_mask",
		text_id = "menu_choose_mask",
		callback = "choice_mask"
	}
	if choose_mask:parameters().help_id then
		params.help_id = choose_mask:parameters().help_id
	end
	local data_node = {
		type = "MenuItemMultiChoice"
	}
	table.insert(data_node, {
		_meta = "option",
		text_id = "menu_mask_clowns",
		value = "clowns"
	})
	if managers.network.account:has_mask("developer") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_developer",
			value = "developer"
		})
	end
	if managers.network.account:has_mask("hockey_com") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_hockey_com",
			value = "hockey_com"
		})
	end
	if managers.network.account:has_mask("alienware") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_alienware",
			value = "alienware"
		})
	end
	table.insert(data_node, {
		_meta = "option",
		text_id = "menu_mask_bf3",
		value = "bf3"
	})
	if managers.network.account:has_mask("santa") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_santa",
			value = "santa"
		})
	end
	if managers.experience:current_level() >= 145 or managers.network.account:has_mask("president") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_president",
			value = "president"
		})
	end
	if managers.challenges:is_completed("golden_boy") or managers.network.account:has_mask("gold") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_gold",
			value = "gold"
		})
	end
	if SystemInfo:platform() == Idstring("WIN32") and (Steam:is_product_owned(500) or Steam:is_product_owned(550)) then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_zombie",
			value = "zombie"
		})
	end
	if managers.network.account:has_mask("troll") then
		table.insert(data_node, {
			_meta = "option",
			text_id = "menu_mask_troll",
			value = "troll"
		})
	end
	choose_mask:init(data_node, params)
	choose_mask:set_callback_handler(MenuCallbackHandler:new())
	choose_mask:set_value(managers.user:get_setting("mask_set"))
	return node
end

DynamicLevelCreator = DynamicLevelCreator or class()

function DynamicLevelCreator:modify_node(node)
	print("DynamicLevelCreator:modify_node", inspect(node))
	local single_player = node:parameters().single_player
	local new_node = deep_clone(node)
	for _, level_id in ipairs(tweak_data.levels:get_level_index()) do
		local level_data = tweak_data.levels[level_id]
		local params = {
			name = "pick_" .. level_id,
			level_id = level_id,
			text_id = managers.localization:text(level_data.name_id),
			difficulty = 1,
			localize = "false",
			callback = "choice_lobby_campaign",
			info_panel = "lobby_campaign",
			title_id = "menu_campaign"
		}
		local data = {
			type = "CoreMenuItemToggle.ItemToggle",
			{
				_meta = "option",
				icon = "guis/textures/menu_radiobutton",
				value = "on",
				x = 24,
				y = 0,
				w = 24,
				h = 24,
				s_icon = "guis/textures/menu_radiobutton",
				s_x = 24,
				s_y = 24,
				s_w = 24,
				s_h = 24
			},
			{
				_meta = "option",
				icon = "guis/textures/menu_radiobutton",
				value = "off",
				x = 0,
				y = 0,
				w = 24,
				h = 24,
				s_icon = "guis/textures/menu_radiobutton",
				s_x = 0,
				s_y = 24,
				s_w = 24,
				s_h = 24
			}
		}
		local new_item = new_node:create_item(data, params)
		new_node:add_item(new_item)
	end
	if single_player then
		local params = {
			name = "start_the_game",
			text_id = "menu_start_the_game",
			help_id = "menu_start_the_game_help",
			callback = "lobby_start_the_game"
		}
		local new_item = new_node:create_item(nil, params)
		new_node:add_item(new_item)
	else
		local params = {
			name = "create_lobby",
			text_id = "menu_create_lobby",
			help_id = "menu_start_lobby_help",
			callback = "create_lobby"
		}
		local new_item = new_node:create_item(nil, params)
		new_node:add_item(new_item)
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuCustomizeControllerCreator = MenuCustomizeControllerCreator or class()
MenuCustomizeControllerCreator.CONTROLS = {
	"move",
	"primary_attack",
	"secondary_attack",
	"primary_choice1",
	"primary_choice2",
	"switch_weapon",
	"reload",
	"weapon_gadget",
	"run",
	"jump",
	"duck",
	"melee",
	"interact",
	"use_item",
	"toggle_chat",
	"push_to_talk",
	"continue"
}
MenuCustomizeControllerCreator.AXIS_ORDERED = {
	move = {
		"up",
		"down",
		"left",
		"right"
	}
}
MenuCustomizeControllerCreator.CONTROLS_INFO = {}
MenuCustomizeControllerCreator.CONTROLS_INFO.up = {
	text_id = "menu_button_move_forward"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.down = {
	text_id = "menu_button_move_back"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.left = {
	text_id = "menu_button_move_left"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.right = {
	text_id = "menu_button_move_right"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.primary_attack = {
	text_id = "menu_button_fire_weapon"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.secondary_attack = {
	text_id = "menu_button_aim_down_sight"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.primary_choice1 = {
	text_id = "menu_button_weapon_slot1"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.primary_choice2 = {
	text_id = "menu_button_weapon_slot2"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.switch_weapon = {
	text_id = "menu_button_switch_weapon"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.reload = {
	text_id = "menu_button_reload"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.weapon_gadget = {
	text_id = "menu_button_weapon_gadget"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.run = {
	text_id = "menu_button_sprint"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.jump = {
	text_id = "menu_button_jump"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.duck = {
	text_id = "menu_button_crouch"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.melee = {
	text_id = "menu_button_melee"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.interact = {
	text_id = "menu_button_shout"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.use_item = {
	text_id = "menu_button_deploy"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.toggle_chat = {
	text_id = "menu_button_chat_message"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.push_to_talk = {
	text_id = "menu_button_push_to_talk"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.continue = {
	text_id = "menu_button_continue"
}

function MenuCustomizeControllerCreator:modify_node(node)
	local new_node = deep_clone(node)
	local connections = managers.controller:get_settings(managers.controller:get_default_wrapper_type()):get_connection_map()
	for _, name in ipairs(self.CONTROLS) do
		local name_id = name
		local connection = connections[name]
		if connection._btn_connections then
			local ordered = self.AXIS_ORDERED[name]
			for _, btn_name in ipairs(ordered) do
				local btn_connection = connection._btn_connections[btn_name]
				if btn_connection then
					local name_id = name
					local params = {
						name = btn_name,
						connection_name = name,
						text_id = utf8.to_upper(managers.localization:text(self.CONTROLS_INFO[btn_name].text_id)),
						binding = btn_connection.name,
						localize = "false",
						axis = connection._name,
						button = btn_name
					}
					local new_item = new_node:create_item({
						type = "MenuItemCustomizeController"
					}, params)
					new_node:add_item(new_item)
				end
			end
		else
			local params = {
				name = name_id,
				connection_name = name,
				text_id = utf8.to_upper(managers.localization:text(self.CONTROLS_INFO[name].text_id)),
				binding = connection:get_input_name_list()[1],
				localize = "false",
				button = name
			}
			local new_item = new_node:create_item({
				type = "MenuItemCustomizeController"
			}, params)
			new_node:add_item(new_item)
		end
	end
	local params = {
		name = "set_default_controller",
		text_id = "menu_set_default_controller",
		callback = "set_default_controller"
	}
	local new_item = new_node:create_item(nil, params)
	new_node:add_item(new_item)
	managers.menu:add_back_button(new_node)
	return new_node
end

MenuCrimeNetContractInitiator = MenuCrimeNetContractInitiator or class()

function MenuCrimeNetContractInitiator:modify_node(original_node, data)
	local node = deep_clone(original_node)
	if Global.game_settings.single_player then
		node:item("toggle_ai"):set_value(Global.game_settings.team_ai and "on" or "off")
	elseif not data.server then
		node:item("lobby_permission"):set_value(Global.game_settings.permission)
		node:item("lobby_reputation_permission"):set_value(Global.game_settings.reputation_permission)
		node:item("toggle_drop_in"):set_value(Global.game_settings.drop_in_allowed and "on" or "off")
		node:item("toggle_ai"):set_value(Global.game_settings.team_ai and "on" or "off")
	end
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	node:parameters().menu_component_data = data
	return node
end

MenuCrimeNetFiltersInitiator = MenuCrimeNetFiltersInitiator or class()

function MenuCrimeNetFiltersInitiator:modify_node(original_node, data)
	local node = deep_clone(original_node)
	node:item("toggle_friends_only"):set_value(Global.game_settings.search_friends_only and "on" or "off")
	if MenuCallbackHandler:is_win32() then
		node:item("server_filter"):set_value(managers.network.matchmake:distance_filter())
	end
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	node:parameters().menu_component_data = data
	return node
end

MenuOptionInitiator = MenuOptionInitiator or class()

function MenuOptionInitiator:modify_node(node)
	local node_name = node:parameters().name
	if node_name == "resolution" then
		return self:modify_resolution(node)
	elseif node_name == "video" then
		return self:modify_video(node)
	elseif node_name == "adv_video" then
		return self:modify_adv_video(node)
	elseif node_name == "controls" then
		return self:modify_controls(node)
	elseif node_name == "debug" then
		return self:modify_debug_options(node)
	elseif node_name == "options" then
		return self:modify_options(node)
	end
end

function MenuOptionInitiator:modify_resolution(node)
	if SystemInfo:platform() == Idstring("WIN32") then
		local res_name = string.format("%d x %d", RenderSettings.resolution.x, RenderSettings.resolution.y)
		node:set_default_item_name(res_name)
	end
	return node
end

function MenuOptionInitiator:modify_adv_video(node)
	node:item("toggle_vsync"):set_value(RenderSettings.v_sync and "on" or "off")
	if node:item("choose_streaks") then
		node:item("choose_streaks"):set_value(managers.user:get_setting("video_streaks") and "on" or "off")
	end
	if node:item("choose_light_adaption") then
		node:item("choose_light_adaption"):set_value(managers.user:get_setting("light_adaption") and "on" or "off")
	end
	if node:item("choose_anti_alias") then
		node:item("choose_anti_alias"):set_value(managers.user:get_setting("video_anti_alias"))
	end
	node:item("choose_anim_lod"):set_value(managers.user:get_setting("video_animation_lod"))
	if node:item("choose_color_grading") then
		node:item("choose_color_grading"):set_value(managers.user:get_setting("video_color_grading"))
	end
	node:item("use_lightfx"):set_value(managers.user:get_setting("use_lightfx") and "on" or "off")
	node:item("choose_texture_quality"):set_value(RenderSettings.texture_quality_default)
	node:item("choose_anisotropic"):set_value(RenderSettings.max_anisotropy)
	if node:item("fov_multiplier") then
		node:item("fov_multiplier"):set_value(managers.user:get_setting("fov_multiplier"))
	end
	node:item("choose_fps_cap"):set_value(managers.user:get_setting("fps_cap"))
	local option_value = "off"
	local dof_setting_item = node:item("toggle_dof")
	if dof_setting_item then
		if managers.user:get_setting("dof_setting") ~= "none" then
			option_value = "on"
		end
		dof_setting_item:set_value(option_value)
	end
	return node
end

function MenuOptionInitiator:modify_video(node)
	local option_value = "off"
	local fs_item = node:item("toggle_fullscreen")
	if fs_item then
		if RenderSettings.fullscreen then
			option_value = "on"
		end
		fs_item:set_value(option_value)
	end
	option_value = "off"
	local st_item = node:item("toggle_subtitle")
	if st_item then
		if managers.user:get_setting("subtitle") then
			option_value = "on"
		end
		st_item:set_value(option_value)
	end
	option_value = "off"
	local hit_indicator_item = node:item("toggle_hit_indicator")
	if hit_indicator_item then
		if managers.user:get_setting("hit_indicator") then
			option_value = "on"
		end
		hit_indicator_item:set_value(option_value)
	end
	option_value = "off"
	local objective_reminder_item = node:item("toggle_objective_reminder")
	if objective_reminder_item then
		if managers.user:get_setting("objective_reminder") then
			option_value = "on"
		end
		objective_reminder_item:set_value(option_value)
	end
	local br_item = node:item("brightness")
	if br_item then
		br_item:set_min(_G.tweak_data.menu.MIN_BRIGHTNESS)
		br_item:set_max(_G.tweak_data.menu.MAX_BRIGHTNESS)
		br_item:set_step(_G.tweak_data.menu.BRIGHTNESS_CHANGE)
		option_value = managers.user:get_setting("brightness")
		br_item:set_value(option_value)
	end
	local effect_quality_item = node:item("effect_quality")
	if effect_quality_item then
		option_value = managers.user:get_setting("effect_quality")
		effect_quality_item:set_value(option_value)
	end
	return node
end

function MenuOptionInitiator:modify_controls(node)
	local option_value = "off"
	local rumble_item = node:item("toggle_rumble")
	if rumble_item then
		if managers.user:get_setting("rumble") then
			option_value = "on"
		end
		rumble_item:set_value(option_value)
	end
	option_value = "off"
	local inv_cam_horizontally_item = node:item("toggle_invert_camera_horisontally")
	if inv_cam_horizontally_item then
		if managers.user:get_setting("invert_camera_x") then
			option_value = "on"
		end
		inv_cam_horizontally_item:set_value(option_value)
	end
	option_value = "off"
	local inv_cam_vertically_item = node:item("toggle_invert_camera_vertically")
	if inv_cam_vertically_item then
		if managers.user:get_setting("invert_camera_y") then
			option_value = "on"
		end
		inv_cam_vertically_item:set_value(option_value)
	end
	option_value = "off"
	local hold_to_steelsight_item = node:item("toggle_hold_to_steelsight")
	if hold_to_steelsight_item then
		if managers.user:get_setting("hold_to_steelsight") then
			option_value = "on"
		end
		hold_to_steelsight_item:set_value(option_value)
	end
	option_value = "off"
	local hold_to_run_item = node:item("toggle_hold_to_run")
	if hold_to_run_item then
		if managers.user:get_setting("hold_to_run") then
			option_value = "on"
		end
		hold_to_run_item:set_value(option_value)
	end
	option_value = "off"
	local hold_to_duck_item = node:item("toggle_hold_to_duck")
	if hold_to_duck_item then
		if managers.user:get_setting("hold_to_duck") then
			option_value = "on"
		end
		hold_to_duck_item:set_value(option_value)
	end
	option_value = "off"
	local aim_assist_item = node:item("toggle_aim_assist")
	if aim_assist_item then
		if managers.user:get_setting("aim_assist") then
			option_value = "on"
		end
		aim_assist_item:set_value(option_value)
	end
	local cs_item = node:item("camera_sensitivity")
	if cs_item then
		cs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		cs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		cs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.1)
		cs_item:set_value(managers.user:get_setting("camera_sensitivity"))
	end
	local czs_item = node:item("camera_zoom_sensitivity")
	if czs_item then
		czs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		czs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		czs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.1)
		czs_item:set_value(managers.user:get_setting("camera_zoom_sensitivity"))
	end
	node:item("toggle_zoom_sensitivity"):set_value(managers.user:get_setting("enable_camera_zoom_sensitivity") and "on" or "off")
	return node
end

function MenuOptionInitiator:modify_debug_options(node)
	local option_value = "off"
	local players_item = node:item("toggle_players")
	if players_item then
		players_item:set_value(Global.nr_players)
	end
	local god_mode_item = node:item("toggle_god_mode")
	if god_mode_item then
		local god_mode_value = Global.god_mode and "on" or "off"
		god_mode_item:set_value(god_mode_value)
	end
	local post_effects_item = node:item("toggle_post_effects")
	if post_effects_item then
		local post_effects_value = Global.debug_post_effects_enabled and "on" or "off"
		post_effects_item:set_value(post_effects_value)
	end
	local team_AI_mode_item = node:item("toggle_team_AI")
	if team_AI_mode_item then
		local team_AI_mode_value = Global.criminal_team_AI_disabled and "off" or "on"
		team_AI_mode_item:set_value(team_AI_mode_value)
	end
	return node
end

function MenuOptionInitiator:modify_options(node)
	return node
end
