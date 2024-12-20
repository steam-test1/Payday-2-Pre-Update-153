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
require("lib/managers/menu/items/MenuItemToggle")
require("lib/managers/menu/items/MenuItemChat")
require("lib/managers/menu/items/MenuItemGenerics")
require("lib/managers/menu/items/MenuItemFriend")
require("lib/managers/menu/items/MenuItemCustomizeController")
require("lib/managers/menu/items/MenuItemInput")
require("lib/managers/menu/items/MenuItemTextBox")
require("lib/managers/menu/items/MenuItemDummy")
require("lib/managers/menu/nodes/MenuNodeTable")
require("lib/managers/menu/nodes/MenuNodeServerList")
require("lib/managers/menu/items/MenuItemCrimeSpreeItem")
core:import("CoreEvent")
MenuManager = MenuManager or class(CoreMenuManager.Manager)
MenuCallbackHandler = MenuCallbackHandler or class(CoreMenuCallbackHandler.CallbackHandler)
require("lib/managers/MenuManagerPD2")
require("lib/managers/menu/MenuManagerCrimeSpreeCallbacks")
MenuManager.IS_NORTH_AMERICA = SystemInfo:platform() == Idstring("WIN32") or Application:is_northamerica()
MenuManager.ONLINE_AGE = (SystemInfo:platform() == Idstring("PS3") or SystemInfo:platform() == Idstring("PS4")) and MenuManager.IS_NORTH_AMERICA and 17 or 18
require("lib/managers/MenuManagerDialogs")
require("lib/managers/MenuManagerDebug")

function MenuManager:init(is_start_menu)
	MenuManager.super.init(self)
	self._is_start_menu = is_start_menu
	self._active = false
	self._debug_menu_enabled = Global.DEBUG_MENU_ON or Application:production_build()
	Global.debug_contour_enabled = nil
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
		local custom_safehouse_menu = {
			name = "custom_safehouse_menu",
			id = "custom_safehouse_menu",
			content_file = "gamedata/menus/custom_safehouse_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuHiddenRenderer"
		}
		self:register_menu(custom_safehouse_menu)
		local heister_interact_menu = {
			name = "heister_interact_menu",
			id = "heister_interact_menu",
			content_file = "gamedata/menus/heister_interact_menu",
			callback_handler = MenuCallbackHandler:new(),
			input = "MenuInput",
			renderer = "MenuHiddenRenderer"
		}
		self:register_menu(heister_interact_menu)
	end
	self._controller:add_trigger("toggle_menu", callback(self, self, "toggle_menu_state"))
	if MenuCallbackHandler:is_pc_controller() and MenuCallbackHandler:is_not_steam_controller() then
		self._controller:add_trigger("toggle_chat", callback(self, self, "toggle_chatinput"))
	end
	if SystemInfo:platform() == Idstring("WIN32") then
		self._controller:add_trigger("push_to_talk", callback(self, self, "push_to_talk", true))
		self._controller:add_release_trigger("push_to_talk", callback(self, self, "push_to_talk", false))
	end
	self._active_changed_callback_handler = CoreEvent.CallbackEventHandler:new()
	managers.user:add_setting_changed_callback("brightness", callback(self, self, "brightness_changed"), true)
	managers.user:add_setting_changed_callback("camera_sensitivity_x", callback(self, self, "camera_sensitivity_x_changed"), true)
	managers.user:add_setting_changed_callback("camera_sensitivity_y", callback(self, self, "camera_sensitivity_y_changed"), true)
	managers.user:add_setting_changed_callback("camera_zoom_sensitivity_x", callback(self, self, "camera_sensitivity_x_changed"), true)
	managers.user:add_setting_changed_callback("camera_zoom_sensitivity_y", callback(self, self, "camera_sensitivity_y_changed"), true)
	managers.user:add_setting_changed_callback("rumble", callback(self, self, "rumble_changed"), true)
	managers.user:add_setting_changed_callback("invert_camera_x", callback(self, self, "invert_camera_x_changed"), true)
	managers.user:add_setting_changed_callback("invert_camera_y", callback(self, self, "invert_camera_y_changed"), true)
	managers.user:add_setting_changed_callback("southpaw", callback(self, self, "southpaw_changed"), true)
	managers.user:add_setting_changed_callback("subtitle", callback(self, self, "subtitle_changed"), true)
	managers.user:add_setting_changed_callback("music_volume", callback(self, self, "music_volume_changed"), true)
	managers.user:add_setting_changed_callback("sfx_volume", callback(self, self, "sfx_volume_changed"), true)
	managers.user:add_setting_changed_callback("voice_volume", callback(self, self, "voice_volume_changed"), true)
	managers.user:add_setting_changed_callback("use_lightfx", callback(self, self, "lightfx_changed"), true)
	managers.user:add_setting_changed_callback("effect_quality", callback(self, self, "effect_quality_changed"), true)
	managers.user:add_setting_changed_callback("dof_setting", callback(self, self, "dof_setting_changed"), true)
	managers.user:add_setting_changed_callback("chromatic_setting", callback(self, self, "chromatic_setting_changed"), true)
	managers.user:add_setting_changed_callback("fps_cap", callback(self, self, "fps_limit_changed"), true)
	managers.user:add_setting_changed_callback("net_packet_throttling", callback(self, self, "net_packet_throttling_changed"), true)
	managers.user:add_setting_changed_callback("net_forwarding", callback(self, self, "net_forwarding_changed"), true)
	managers.user:add_setting_changed_callback("net_use_compression", callback(self, self, "net_use_compression_changed"), true)
	managers.user:add_setting_changed_callback("flush_gpu_command_queue", callback(self, self, "flush_gpu_command_queue_changed"), true)
	managers.user:add_setting_changed_callback("use_thq_weapon_parts", callback(self, self, "use_thq_weapon_parts_changed"), true)
	managers.user:add_active_user_state_changed_callback(callback(self, self, "on_user_changed"))
	managers.user:add_storage_changed_callback(callback(self, self, "on_storage_changed"))
	managers.savefile:add_active_changed_callback(callback(self, self, "safefile_manager_active_changed"))
	self._delayed_open_savefile_menu_callback = nil
	self._save_game_callback = nil
	self:brightness_changed(nil, nil, managers.user:get_setting("brightness"))
	self:effect_quality_changed(nil, nil, managers.user:get_setting("effect_quality"))
	self:fps_limit_changed(nil, nil, managers.user:get_setting("fps_cap"))
	self:net_packet_throttling_changed(nil, nil, managers.user:get_setting("net_packet_throttling"))
	self:net_forwarding_changed(nil, nil, managers.user:get_setting("net_forwarding"))
	self:net_use_compression_changed(nil, nil, managers.user:get_setting("net_use_compression"))
	self:flush_gpu_command_queue_changed(nil, nil, managers.user:get_setting("flush_gpu_command_queue"))
	self:invert_camera_y_changed("invert_camera_y", nil, managers.user:get_setting("invert_camera_y"))
	self:southpaw_changed("southpaw", nil, managers.user:get_setting("southpaw"))
	self:dof_setting_changed("dof_setting", nil, managers.user:get_setting("dof_setting"))
	self:chromatic_setting_changed("chromatic_setting", nil, managers.user:get_setting("chromatic_setting"))
	managers.system_menu:add_active_changed_callback(callback(self, self, "system_menu_active_changed"))
	self._sound_source = SoundDevice:create_source("MenuManager")
	managers.user:add_setting_changed_callback("video_ao", callback(self, self, "video_ao_changed"), true)
	self:video_ao_changed(nil, nil, managers.user:get_setting("video_ao"))
	managers.user:add_setting_changed_callback("parallax_mapping", callback(self, self, "parallax_mapping_changed"), true)
	self:parallax_mapping_changed(nil, nil, managers.user:get_setting("parallax_mapping"))
	managers.user:add_setting_changed_callback("video_aa", callback(self, self, "video_aa_changed"), true)
	self:video_aa_changed(nil, nil, managers.user:get_setting("video_aa"))
	managers.user:add_setting_changed_callback("workshop", callback(self, self, "workshop_changed"), true)
	self:workshop_changed(nil, nil, managers.user:get_setting("workshop"))
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
		managers.network:session():send_to_peers_loaded("set_menu_sync_state_index", index)
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
	managers.vote:message_vote()
	self:set_and_send_sync_state(node and node:parameters().sync_state)
end

function MenuManager:active_menu(node_name, parameter_list)
	local active_menu = self._open_menus[#self._open_menus]
	if active_menu then
		return active_menu
	end
end

function MenuManager:open_menu(menu_name, position, ...)
	MenuManager.super.open_menu(self, menu_name, position, ...)
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

function MenuManager:force_back(queue, skip_nodes)
	local active_menu = self._open_menus[#self._open_menus]
	if active_menu then
		active_menu.input:force_back(queue, skip_nodes)
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
	if managers.menu_component then
		managers.menu_component:close()
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
	return self:active_menu() and self:active_menu().input and self:active_menu().input._controller and self:active_menu().input._controller.TYPE == "pc" or managers.controller:get_default_wrapper_type() == "pc" or self:is_steam_controller()
end

function MenuManager:is_steam_controller()
	return self:active_menu() and self:active_menu().input and self:active_menu().input._controller and self:active_menu().input._controller.TYPE == "steam" or managers.controller:get_default_wrapper_type() == "steam"
end

function MenuManager:toggle_menu_state()
	if self._is_start_menu then
		return
	end
	if self._heister_interaction then
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
		elseif (not (self:active_menu() and #self:active_menu().logic._node_stack ~= 1 and managers.menu:active_menu().logic:selected_node()) or managers.menu:active_menu().logic:selected_node():parameters().allow_pause_menu) and managers.menu_component:input_focus() ~= 1 then
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
	if SystemInfo:platform() ~= Idstring("WIN32") then
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
		return true
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

function MenuManager:video_ao_changed(name, old_value, new_value)
	if managers.environment_controller then
		managers.environment_controller:set_ao_setting(new_value)
	end
end

function MenuManager:parallax_mapping_changed(name, old_value, new_value)
	if managers.environment_controller then
		managers.environment_controller:set_parallax_setting(new_value)
	end
end

function MenuManager:video_aa_changed(name, old_value, new_value)
	if managers.environment_controller then
		managers.environment_controller:set_aa_setting(new_value)
	end
end

function MenuManager:workshop_changed(name, old_value, new_value)
	if managers.workshop then
		managers.workshop:set_enabled(new_value)
	end
end

function MenuManager:brightness_changed(name, old_value, new_value)
	local brightness = math.clamp(new_value, _G.tweak_data.menu.MIN_BRIGHTNESS, _G.tweak_data.menu.MAX_BRIGHTNESS)
	Application:set_brightness(brightness)
end

function MenuManager:effect_quality_changed(name, old_value, new_value)
	World:effect_manager():set_quality(new_value)
end

function MenuManager:set_mouse_sensitivity(zoomed)
	local zoom_sense = zoomed
	local sense_x, sense_y
	if zoom_sense then
		sense_x = managers.user:get_setting("camera_zoom_sensitivity_x")
		sense_y = managers.user:get_setting("camera_zoom_sensitivity_y")
	else
		sense_x = managers.user:get_setting("camera_sensitivity_x")
		sense_y = managers.user:get_setting("camera_sensitivity_y")
	end
	if zoomed and managers.user:get_setting("enable_fov_based_sensitivity") and alive(managers.player:player_unit()) then
		local state = managers.player:player_unit():movement():current_state()
		if alive(state._equipped_unit) then
			local fov = managers.user:get_setting("fov_multiplier")
			local scale = (state._equipped_unit:base():zoom() or 65) * (fov + 1) / 2 / (65 * fov)
			sense_x = sense_x * scale
			sense_y = sense_y * scale
		end
	end
	local multiplier = Vector3()
	mvector3.set_x(multiplier, sense_x * self._look_multiplier.x)
	mvector3.set_y(multiplier, sense_y * self._look_multiplier.y)
	self._controller:get_setup():get_connection("look"):set_multiplier(multiplier)
	managers.controller:rebind_connections()
end

function MenuManager:camera_sensitivity_x_changed(name, old_value, new_value)
	local setup = self._controller:get_setup()
	local look_connection = setup:get_connection("look")
	local look_multiplier = Vector3()
	mvector3.set(look_multiplier, look_connection:get_multiplier())
	mvector3.set_x(look_multiplier, self._look_multiplier.x * new_value)
	look_connection:set_multiplier(look_multiplier)
	managers.controller:rebind_connections()
	if alive(managers.player:player_unit()) then
		local plr_state = managers.player:player_unit():movement():current_state()
		local weapon_id = alive(plr_state._equipped_unit) and plr_state._equipped_unit:base():get_name_id()
		local stances = tweak_data.player.stances[weapon_id] or tweak_data.player.stances.default
		self:set_mouse_sensitivity(plr_state:in_steelsight() and stances.steelsight.zoom_fov)
	else
		self:set_mouse_sensitivity(false)
	end
end

function MenuManager:camera_sensitivity_y_changed(name, old_value, new_value)
	local setup = self._controller:get_setup()
	local look_connection = setup:get_connection("look")
	local look_multiplier = Vector3()
	mvector3.set(look_multiplier, look_connection:get_multiplier())
	mvector3.set_y(look_multiplier, self._look_multiplier.y * new_value)
	look_connection:set_multiplier(look_multiplier)
	managers.controller:rebind_connections()
	if alive(managers.player:player_unit()) then
		local plr_state = managers.player:player_unit():movement():current_state()
		local weapon_id = alive(plr_state._equipped_unit) and plr_state._equipped_unit:base():get_name_id()
		local stances = tweak_data.player.stances[weapon_id] or tweak_data.player.stances.default
		self:set_mouse_sensitivity(plr_state:in_steelsight() and stances.steelsight.zoom_fov)
	else
		self:set_mouse_sensitivity(false)
	end
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
	if self._controller.TYPE ~= "xbox360" and self._controller.TYPE ~= "ps3" and self._controller.TYPE ~= "xb1" and self._controller.TYPE ~= "ps4" then
		return
	end
	local setup = self._controller:get_setup()
	local look_connection = setup:get_connection("look")
	local move_connection = setup:get_connection("move")
	local look_input_name_list = look_connection:get_input_name_list()
	local move_input_name_list = move_connection:get_input_name_list()
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

function MenuManager:chromatic_setting_changed(name, old_value, new_value)
	managers.environment_controller:set_chromatic_enabled(new_value == "standard")
end

function MenuManager:fps_limit_changed(name, old_value, new_value)
	if SystemInfo:platform() ~= Idstring("WIN32") then
		return
	end
	setup:set_fps_cap(new_value)
end

function MenuManager:net_packet_throttling_changed(name, old_value, new_value)
	if managers.network then
		managers.network:set_packet_throttling_enabled(new_value)
	end
end

function MenuManager:net_forwarding_changed(name, old_value, new_value)
	print("[Network:set_forwarding_enabled]", new_value)
	Network:set_forwarding_enabled(new_value)
end

function MenuManager:net_use_compression_changed(name, old_value, new_value)
	Network:set_use_compression(new_value)
end

function MenuManager:flush_gpu_command_queue_changed(name, old_value, new_value)
	RenderSettings.flush_gpu_command_queue = new_value
end

function MenuManager:use_thq_weapon_parts_changed(name, old_value, new_value)
	if managers.weapon_factory then
		managers.weapon_factory:set_use_thq_weapon_parts(managers.user:get_setting("use_thq_weapon_parts"))
	end
	if not game_state_machine or game_state_machine:current_state_name() ~= "menu_main" then
		return
	end
	if managers.network and managers.network:session() then
		for _, peer in ipairs(managers.network:session():peers()) do
			peer:force_reload_outfit()
		end
	end
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
		platform = string.lower(SystemInfo:platform():s()),
		source_root = managers.database:root_path() .. "/assets",
		target_db_root = Application:base_path() .. "assets",
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

function MenuManager:is_console()
	return self:is_ps3() or self:is_x360() or self:is_ps4() or self:is_xb1()
end

function MenuManager:is_ps3()
	return SystemInfo:platform() == Idstring("PS3")
end

function MenuManager:is_ps4()
	return SystemInfo:platform() == Idstring("PS4")
end

function MenuManager:is_x360()
	return SystemInfo:platform() == Idstring("X360")
end

function MenuManager:is_xb1()
	return SystemInfo:platform() == Idstring("XB1")
end

function MenuManager:is_na()
	return MenuManager.IS_NORTH_AMERICA
end

function MenuManager:open_sign_in_menu(cb)
	if self:is_ps3() then
		managers.network.matchmake:register_callback("found_game", callback(self, self, "_cb_matchmake_found_game"))
		managers.network.matchmake:register_callback("player_joined", callback(self, self, "_cb_matchmake_player_joined"))
		self:open_ps3_sign_in_menu(cb)
	elseif self:is_ps4() then
		managers.network.matchmake:register_callback("found_game", callback(self, self, "_cb_matchmake_found_game"))
		managers.network.matchmake:register_callback("player_joined", callback(self, self, "_cb_matchmake_player_joined"))
		if PSN:is_fetching_status() then
			self:show_fetching_status_dialog({
				cancel_func = function()
					PSN:fetch_cancel()
				end
			})
			
			local function f()
				self:open_ps4_sign_in_menu(cb)
			end
			
			PSN:set_matchmaking_callback("fetch_status", f)
			PSN:fetch_status()
		else
			self:open_ps4_sign_in_menu(cb)
		end
	elseif self:is_x360() then
		if managers.network.account:signin_state() == "signed in" and managers.user:check_privilege(nil, "multiplayer_sessions") then
			self:open_x360_sign_in_menu(cb)
		else
			self:show_err_not_signed_in_dialog()
		end
	elseif self:is_xb1() then
		self._queued_privilege_check_cb = nil
		managers.system_menu:close("fetching_status")
		if managers.network.account:signin_state() == "signed in" then
			if managers.user:check_privilege(nil, "multiplayer_sessions", callback(self, self, "_check_privilege_callback")) then
				self:show_fetching_status_dialog({
					cancel_func = function()
						self._queued_privilege_check_cb = nil
					end
				})
				self._queued_privilege_check_cb = cb
			else
				self:show_err_not_signed_in_dialog()
			end
		else
			self:show_err_not_signed_in_dialog()
		end
	elseif managers.network.account:signin_state() == "signed in" then
		cb(true)
	else
		self:show_err_not_signed_in_dialog()
	end
end

function MenuManager:_check_privilege_callback(is_success)
	if self._queued_privilege_check_cb then
		local cb = self._queued_privilege_check_cb
		managers.system_menu:close("fetching_status")
		self._queued_privilege_check_cb = nil
		if is_success then
			self:open_xb1_sign_in_menu(cb)
		else
			self:show_err_not_signed_in_dialog()
		end
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

function MenuManager:open_ps4_sign_in_menu(cb)
	if managers.system_menu:is_active_by_id("fetching_status") then
		managers.system_menu:close("fetching_status")
	end
	local success = true
	if PSN:needs_update() then
		Global.boot_invite = nil
		success = false
		self:show_err_new_patch()
	elseif not PSN:cable_connected() then
		self:show_internet_connection_required()
		success = false
	elseif managers.network.account:signin_state() == "not signed in" then
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
	elseif PSN:user_age() < MenuManager.ONLINE_AGE and PSN:parental_control_settings_active() then
		Global.boot_invite = nil
		success = false
		self:show_err_under_age()
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

function MenuManager:open_xb1_sign_in_menu(cb)
	local success = self:_enter_online_menus_xb1()
	cb(success)
end

function MenuManager:external_enter_online_menus()
	if self:is_ps3() then
		self:_enter_online_menus()
	elseif self:is_ps4() then
		self:_enter_online_menus_ps4()
	elseif self:is_x360() then
		self:_enter_online_menus_x360()
	else
		if self:is_xb1() then
			self:_enter_online_menus_xb1()
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
		local res = PSN:check_plus()
		if res == 1 then
			managers.platform:set_presence("Signed_in")
			print("voice chat from enter_online_menus")
			managers.network:ps3_determine_voice(false)
			managers.network.voice_chat:check_status_information()
			PSN:set_online_callback(callback(self, self, "ps3_disconnect"))
			return true
		elseif res ~= 2 then
			self:show_err_not_signed_in_dialog()
		end
	end
	return false
end

function MenuManager:_enter_online_menus_ps4()
	managers.platform:set_presence("Signed_in")
	print("voice chat from enter_online_menus_ps4")
	managers.network:ps3_determine_voice(false)
	managers.network.voice_chat:check_status_information()
	PSN:set_online_callback(callback(self, self, "ps3_disconnect"))
end

function MenuManager:_enter_online_menus_x360()
	managers.platform:set_presence("Signed_in")
	managers.user:on_entered_online_menus()
	return true
end

function MenuManager:_enter_online_menus_xb1()
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
	if managers.network:session() or managers.user:is_online_menu() then
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
	if not connected then
		managers.network:queue_stop_network()
		managers.platform:set_presence("Idle")
		managers.network.matchmake:leave_game()
		managers.network.matchmake:psn_disconnected()
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
	self:show_mp_disconnected_internet_dialog({
		ok_func = function()
			self._showing_disconnect_message = nil
		end
	})
end

function MenuManager:created_lobby()
	Global.game_settings.single_player = false
	managers.network:host_game()
	Network:set_multiplayer(true)
	Network:set_server()
	self:on_enter_lobby()
end

function MenuManager:exit_online_menues()
	local must_show_controller_disconnect
	if Global.controller_manager.connect_controller_dialog_visible then
		must_show_controller_disconnect = true
		managers.controller:_close_controller_changed_dialog(true)
	end
	managers.system_menu:force_close_all()
	self:_close_lobby_menu_components()
	if self:active_menu() then
		self:close_menu(self:active_menu().name)
	end
	self:open_menu("menu_main")
	if not managers.menu:is_pc_controller() then
	end
	if must_show_controller_disconnect then
		managers.controller:_show_controller_changed_dialog()
	end
end

function MenuManager:leave_online_menu()
	if self:is_ps3() or self:is_ps4() then
		PSN:set_online_callback(callback(self, self, "refresh_player_profile_gui"))
	end
	if self:is_x360() or self:is_xb1() then
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
	local skip_destroy_matchmaking = self:is_ps3() or self:is_ps4()
	managers.network:prepare_stop_network(skip_destroy_matchmaking)
	if self:is_x360() or self:is_xb1() then
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
	managers.gage_assignment:deactivate_assignments()
	managers.crime_spree:on_left_lobby()
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
	if old_user_data and old_user_data.storage_id and user_data and user_data.signin_state ~= "not_signed_in" and not old_user_data.has_signed_out and managers.user:get_platform_id() == user_data.platform_id and not self:is_xb1() then
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
	managers.achievment:on_user_signout()
end

function MenuManager:do_clear_progress()
	managers.skilltree:reset()
	managers.experience:reset()
	managers.money:reset()
	managers.blackmarket:reset()
	managers.dlc:on_reset_profile()
	managers.mission:on_reset_profile()
	managers.job:reset_job_heat()
	managers.job:reset_ghost_bonus()
	managers.infamy:reset()
	managers.gage_assignment:reset()
	managers.crimenet:reset_seed()
	managers.custom_safehouse:reset()
	managers.tango:reset()
	if Global.game_settings.difficulty == "overkill_145" then
		Global.game_settings.difficulty = "overkill"
	end
	managers.user:set_setting("mask_set", "clowns")
	if SystemInfo:distribution() == Idstring("STEAM") then
		managers.statistics:publish_level_to_steam()
	end
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
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_big_bank_pc()
	print("[MenuCallbackHandler:dlc_buy_big_bank_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_historical_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_historical_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_hl_miami_pc()
	print("[MenuCallbackHandler:dlc_buy_hl_miami_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_assault_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_assault_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_shotgun_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_shotgun_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_snp_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_snp_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_jobs_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_jobs_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_gage_pack_lmg_pc()
	print("[MenuCallbackHandler:dlc_buy_gage_pack_lmg_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_armadillo_pc()
	print("[MenuCallbackHandler:dlc_buy_armadillo_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_character_pack_clover_pc()
	print("[MenuCallbackHandler:dlc_buy_character_pack_clover_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_character_pack_dragan_pc()
	print("[MenuCallbackHandler:dlc_buy_character_pack_dragan_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_hope_diamond_pc()
	print("[MenuCallbackHandler:dlc_buy_hope_diamond_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_the_bomb_pc()
	print("[MenuCallbackHandler:dlc_buy_the_bomb_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_akm4_pack_pc()
	print("[MenuCallbackHandler:dlc_buy_akm4_pack_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_overkill_pack_pc()
	print("[MenuCallbackHandler:dlc_buy_overkill_pack_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_complete_overkill_pack_pc()
	print("[MenuCallbackHandler:dlc_buy_complete_overkill_pack_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_bbq_pc()
	print("[MenuCallbackHandler:dlc_buy_bbq_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_west_pc()
	print("[MenuCallbackHandler:dlc_buy_west_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_arena_pc()
	print("[MenuCallbackHandler:dlc_buy_arena_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_character_pack_sokol_pc()
	print("[MenuCallbackHandler:dlc_buy_character_pack_sokol_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_kenaz_pc()
	print("[MenuCallbackHandler:dlc_buy_kenaz_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_turtles_pc()
	print("[MenuCallbackHandler:dlc_buy_turtles_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_dragon_pc()
	print("[MenuCallbackHandler:dlc_buy_dragon_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_steel_pc()
	print("[MenuCallbackHandler:dlc_buy_steel_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_berry_pc()
	print("[MenuCallbackHandler:dlc_buy_berry_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_peta_pc()
	print("[MenuCallbackHandler:dlc_buy_peta_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_pal_pc()
	print("[MenuCallbackHandler:dlc_buy_pal_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_coco_pc()
	print("[MenuCallbackHandler:dlc_buy_coco_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_opera_pc()
	print("[MenuCallbackHandler:dlc_buy_opera_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_wild_pc()
	print("[MenuCallbackHandler:dlc_buy_wild_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_born_pc()
	print("[MenuCallbackHandler:dlc_buy_born_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_pim_pc()
	print("[MenuCallbackHandler:dlc_buy_pim_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_tango_pc()
	print("[MenuCallbackHandler:dlc_buy_tango_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_friend_pc()
	print("[MenuCallbackHandler:dlc_buy_friend_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_chico_pc()
	print("[MenuCallbackHandler:dlc_buy_chico_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_spa_pc()
	print("[MenuCallbackHandler:dlc_buy_spa_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_grv_pc()
	print("[MenuCallbackHandler:dlc_buy_grv_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_amp_pc()
	print("[MenuCallbackHandler:dlc_buy_amp_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_mp2_pc()
	print("[MenuCallbackHandler:dlc_buy_mp2_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:dlc_buy_max_pc()
	print("[MenuCallbackHandler:dlc_buy_max_pc]")
	Steam:overlay_activate("url", tweak_data.gui.store_page)
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
	return managers.dlc:is_dlc_unlocked("preorder")
end

function MenuCallbackHandler:not_has_preorder()
	return not managers.dlc:is_dlc_unlocked("preorder")
end

function MenuCallbackHandler:has_all_dlcs()
	return true
end

function MenuCallbackHandler:is_overlay_enabled()
	if SystemInfo:platform() ~= Idstring("WIN32") then
		return false
	end
	return true
end

function MenuCallbackHandler:is_installed()
	if SystemInfo:platform() == Idstring("WIN32") then
		return true
	end
	local is_installing, install_progress = managers.dlc:is_installing()
	return not is_installing
end

function MenuCallbackHandler:show_game_is_installing_menu()
	managers.menu:show_game_is_installing_menu()
end

function MenuCallbackHandler:bang_active()
	return true
end

function MenuCallbackHandler:choice_crimenet_lobby_job_plan(item)
	Global.game_settings.job_plan = item:value()
end

function MenuCallbackHandler:choice_lobby_job_plan(item)
	Global.game_settings.job_plan = item:value()
	self:update_matchmake_attributes()
	self:_on_host_setting_updated()
end

function MenuCallbackHandler:_on_host_setting_updated()
end

function MenuCallbackHandler:choice_job_plan_filter(item)
	local job_plan_filter = item:value()
	if managers.network.matchmake:get_lobby_filter("job_plan") == job_plan_filter then
		return
	end
	managers.network.matchmake:add_lobby_filter("job_plan", job_plan_filter, "equal")
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_tactic", job_plan_filter)
end

function MenuCallbackHandler:is_dlc_latest_locked(check_dlc)
	local dlcs = {
		"max",
		"mp2",
		"amp",
		"grv",
		"spa",
		"friend",
		"chico",
		"tango",
		"pim",
		"born",
		"wild",
		"opera",
		"pal",
		"peta",
		"berry",
		"steel",
		"dragon",
		"turtles",
		"character_pack_sokol",
		"kenaz",
		"arena",
		"west",
		"bbq",
		"overkill_pack",
		"akm4_pack",
		"character_pack_dragan",
		"the_bomb",
		"character_pack_clover",
		"hope_diamond",
		"gage_pack_historical",
		"hl_miami",
		"gage_pack_assault",
		"gage_pack_shotgun",
		"big_bank",
		"gage_pack_snp",
		"gage_pack_jobs",
		"gage_pack_lmg",
		"gage_pack",
		"armored_transport"
	}
	local dlc_tweak_data = tweak_data.dlc
	local has_dlc
	for _, dlc in ipairs(dlcs) do
		has_dlc = managers.dlc:is_dlc_unlocked(dlc)
		if not has_dlc then
			return dlc == check_dlc
		end
	end
	return false
end

function MenuCallbackHandler:visible_callback_armored_transport(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("armored_transport")
end

function MenuCallbackHandler:visible_callback_gage_pack(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack")
end

function MenuCallbackHandler:visible_callback_gage_pack_lmg(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack_lmg")
end

function MenuCallbackHandler:visible_callback_gage_pack_jobs(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack_jobs")
end

function MenuCallbackHandler:visible_callback_gage_pack_snp(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack_snp")
end

function MenuCallbackHandler:visible_callback_gage_pack_shotgun(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack_shotgun")
end

function MenuCallbackHandler:visible_callback_gage_pack_assault(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack_assault")
end

function MenuCallbackHandler:visible_callback_hl_miami(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("hl_miami")
end

function MenuCallbackHandler:visible_callback_big_bank(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("big_bank")
end

function MenuCallbackHandler:visible_callback_gage_pack_historical(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("gage_pack_historical")
end

function MenuCallbackHandler:visible_callback_character_pack_clover(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("character_pack_clover")
end

function MenuCallbackHandler:visible_callback_character_pack_dragan(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("character_pack_dragan")
end

function MenuCallbackHandler:visible_callback_hope_diamond(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("hope_diamond")
end

function MenuCallbackHandler:visible_callback_the_bomb(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("the_bomb")
end

function MenuCallbackHandler:visible_callback_akm4_pack(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("akm4_pack")
end

function MenuCallbackHandler:visible_callback_overkill_pack(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("overkill_pack")
end

function MenuCallbackHandler:visible_callback_complete_overkill_pack(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("complete_overkill_pack")
end

function MenuCallbackHandler:visible_callback_bbq(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("bbq")
end

function MenuCallbackHandler:visible_callback_west(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("west")
end

function MenuCallbackHandler:visible_callback_arena(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("arena")
end

function MenuCallbackHandler:visible_callback_character_pack_sokol(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("character_pack_sokol")
end

function MenuCallbackHandler:visible_callback_kenaz(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("kenaz")
end

function MenuCallbackHandler:visible_callback_turtles(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("turtles")
end

function MenuCallbackHandler:visible_callback_dragon(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("dragon")
end

function MenuCallbackHandler:visible_callback_steel(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("steel")
end

function MenuCallbackHandler:visible_callback_berry(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("berry")
end

function MenuCallbackHandler:visible_callback_peta(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("peta")
end

function MenuCallbackHandler:visible_callback_pal(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("pal")
end

function MenuCallbackHandler:visible_callback_opera(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("opera")
end

function MenuCallbackHandler:visible_callback_born(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("born")
end

function MenuCallbackHandler:visible_callback_wild(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("wild")
end

function MenuCallbackHandler:visible_callback_pim(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("pim")
end

function MenuCallbackHandler:visible_callback_tango(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("tango")
end

function MenuCallbackHandler:visible_callback_friend(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("friend")
end

function MenuCallbackHandler:visible_callback_chico(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("chico")
end

function MenuCallbackHandler:visible_callback_spa(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("spa")
end

function MenuCallbackHandler:visible_callback_grv(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("grv")
end

function MenuCallbackHandler:visible_callback_amp(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("amp")
end

function MenuCallbackHandler:visible_callback_mp2(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("mp2")
end

function MenuCallbackHandler:visible_callback_max(item)
	item:set_parameter("text_id", "menu_dlc_buy_ue")
	item:set_parameter("help_id", "menu_dlc_buy_ue_help")
	return self:is_dlc_latest_locked("max")
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

function MenuCallbackHandler:to_be_continued()
	return true
end

function MenuCallbackHandler:is_level_145()
	return managers.experience:current_level() >= 145
end

function MenuCallbackHandler:is_level_100()
	return managers.experience:current_level() >= 100
end

function MenuCallbackHandler:is_level_50()
	return managers.experience:current_level() >= 50
end

function MenuCallbackHandler:is_win32()
	return SystemInfo:platform() == Idstring("WIN32")
end

function MenuCallbackHandler:is_steam()
	return SystemInfo:distribution() == Idstring("STEAM")
end

function MenuCallbackHandler:is_fullscreen()
	return managers.viewport:is_fullscreen()
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
	return self:is_ps3() or self:is_x360() or self:is_ps4() or self:is_xb1()
end

function MenuCallbackHandler:is_ps3()
	return SystemInfo:platform() == Idstring("PS3")
end

function MenuCallbackHandler:is_ps4()
	return SystemInfo:platform() == Idstring("PS4")
end

function MenuCallbackHandler:is_x360()
	return SystemInfo:platform() == Idstring("X360")
end

function MenuCallbackHandler:is_xb1()
	return SystemInfo:platform() == Idstring("XB1")
end

function MenuCallbackHandler:is_not_xb1()
	return not self:is_xb1()
end

function MenuCallbackHandler:is_not_x360()
	return not self:is_x360()
end

function MenuCallbackHandler:is_not_xbox()
	return not self:is_x360()
end

function MenuCallbackHandler:is_not_x360_or_xb1()
	return not self:is_x360() and not self:is_xb1()
end

function MenuCallbackHandler:is_not_nextgen()
	return not self:is_xb1() and not self:is_ps4()
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

function MenuCallbackHandler:is_not_max_rank()
	return managers.experience:current_rank() < #tweak_data.infamy.ranks
end

function MenuCallbackHandler:can_become_infamous()
	return self:is_level_100() and self:is_not_max_rank()
end

function MenuCallbackHandler:singleplayer_restart()
	return self:is_singleplayer() and self:has_full_game() and self:is_normal_job() and not managers.job:stage_success()
end

function MenuCallbackHandler:kick_player_visible()
	return self:is_server() and self:is_multiplayer() and managers.platform:presence() ~= "Mission_end" and managers.vote:option_host_kick()
end

function MenuCallbackHandler:kick_vote_visible()
	return self:is_multiplayer() and managers.platform:presence() ~= "Mission_end" and managers.vote:option_vote_kick()
end

function MenuCallbackHandler:_restart_level_visible()
	if not self:is_multiplayer() or self:is_prof_job() or managers.job:stage_success() then
		return false
	end
	local state = game_state_machine:current_state_name()
	return state ~= "ingame_waiting_for_players" and state ~= "ingame_lobby_menu" and state ~= "empty"
end

function MenuCallbackHandler:restart_level_visible()
	return self:is_server() and self:_restart_level_visible() and managers.vote:option_host_restart()
end

function MenuCallbackHandler:restart_vote_visible()
	return self:_restart_level_visible() and managers.vote:option_vote_restart()
end

function MenuCallbackHandler:abort_mission_visible()
	if not (self:is_not_editor() and self:is_server()) or not self:is_multiplayer() then
		return false
	end
	if game_state_machine:current_state_name() == "disconnected" then
		return false
	end
	return true
end

function MenuCallbackHandler:is_custom_safehouse_unlocked()
	return managers.custom_safehouse:unlocked()
end

function MenuCallbackHandler:lobby_exist()
	return managers.network.matchmake.lobby_handler
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

function MenuCallbackHandler:is_steam_controller()
	return managers.menu:is_steam_controller()
end

function MenuCallbackHandler:is_not_steam_controller()
	return not self:is_steam_controller()
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

function MenuCallbackHandler:is_not_crime_spree()
	return not self:is_crime_spree()
end

function MenuCallbackHandler:is_crime_spree()
	return managers.crime_spree:is_active()
end

function MenuCallbackHandler:debug_menu_enabled()
	return managers.menu:debug_menu_enabled()
end

function MenuCallbackHandler:leave_online_menu()
	managers.menu:leave_online_menu()
end

function MenuCallbackHandler:has_peer_1()
	return not not managers.network:session() and managers.network:session():peer(1)
end

function MenuCallbackHandler:has_peer_2()
	return not not managers.network:session() and managers.network:session():peer(2)
end

function MenuCallbackHandler:has_peer_3()
	return not not managers.network:session() and managers.network:session():peer(3)
end

function MenuCallbackHandler:has_peer_4()
	return not not managers.network:session() and managers.network:session():peer(4)
end

function MenuCallbackHandler:on_visit_forum()
	if not MenuCallbackHandler:is_overlay_enabled() then
		managers.menu:show_enable_steam_overlay()
		return
	end
	Steam:overlay_activate("url", "http://forums.steampowered.com/forums/forumdisplay.php?f=1225")
end

function MenuCallbackHandler:on_visit_gamehub()
	if not MenuCallbackHandler:is_overlay_enabled() then
		managers.menu:show_enable_steam_overlay()
		return
	end
	Steam:overlay_activate("url", "http://steamcommunity.com/app/218620")
end

function MenuCallbackHandler:on_buy_dlc1()
	Steam:overlay_activate("url", tweak_data.gui.store_page)
end

function MenuCallbackHandler:on_account_picker()
	print("MenuCallbackHandler:on_account_picker()")
	local confirm_cb = function()
		local f = function(...)
			print("result", ...)
		end
		managers.system_menu:show_select_user({count = 1, callback_func = f})
	end
	managers.menu:show_account_picker_dialog({yes_func = confirm_cb})
end

function MenuCallbackHandler:on_menu_option_help()
	print("MenuCallbackHandler:on_menu_option_help()")
	XboxLive:show_help_ui()
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
	self:_dialog_save_progress_backup_no()
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

function MenuCallbackHandler:chk_dlc_content_updated()
	if SystemInfo:platform() ~= Idstring("XB1") and managers.dlc then
		managers.dlc:chk_content_updated()
	end
end

function MenuCallbackHandler:chk_dlc_content_updated_xb1()
	if SystemInfo:platform() == Idstring("XB1") and managers.dlc then
		managers.dlc:chk_content_updated()
	end
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
	managers.network:session():on_set_member_ready(managers.network:session():local_peer():id(), ready, true, false)
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
	local southpaw = item:value() == "on"
	managers.user:set_setting("southpaw", southpaw)
end

function MenuCallbackHandler:toggle_dof_setting(item)
	local dof_setting = item:value() == "on"
	managers.user:set_setting("dof_setting", dof_setting and "standard" or "none")
end

function MenuCallbackHandler:toggle_chromatic_setting(item)
	local chromatic_setting = item:value() == "on"
	managers.user:set_setting("chromatic_setting", chromatic_setting and "standard" or "none")
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
	if managers.viewport:is_fullscreen() == fullscreen then
		return
	end
	managers.viewport:set_fullscreen(fullscreen)
	managers.menu:show_accept_gfx_settings_dialog(function()
		managers.viewport:set_fullscreen(not fullscreen)
		item:set_value(not fullscreen and "on" or "off")
		self:refresh_node()
	end)
	self:refresh_node()
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

function MenuCallbackHandler:toggle_sticky_aim(item)
	local on = item:value() == "on"
	managers.user:set_setting("sticky_aim", on)
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
	Global.game_settings.team_ai = item:value() == "on"
	managers.groupai:state():on_criminal_team_AI_enabled_state_changed()
end

function MenuCallbackHandler:toggle_coordinates(item)
	Global.debug_show_coords = item:value() == "on"
	if Global.debug_show_coords then
		managers.hud:debug_show_coordinates()
	else
		managers.hud:debug_hide_coordinates()
	end
end

function MenuCallbackHandler:toggle_net_throttling(item)
	local state = item:value() == "on"
	managers.user:set_setting("net_packet_throttling", state, nil)
end

function MenuCallbackHandler:toggle_net_forwarding(item)
	local state = item:value() == "on"
	managers.user:set_setting("net_forwarding", state, nil)
end

function MenuCallbackHandler:toggle_net_use_compression(item)
	local state = item:value() == "on"
	print("[MenuCallbackHandler:toggle_net_use_compression]", state)
	managers.user:set_setting("net_use_compression", state, nil)
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

function MenuCallbackHandler:toggle_throwable_contour(item)
	local state = item:value() == "on"
	managers.user:set_setting("throwable_contour", state, nil)
	local throwables = World:find_units_quick("all", 20)
	for _, unit in ipairs(throwables) do
		if alive(unit) and unit:base() and unit:base().reload_contour then
			unit:base():reload_contour()
		end
	end
end

function MenuCallbackHandler:toggle_ammo_contour(item)
	local state = item:value() == "on"
	managers.user:set_setting("ammo_contour", state, nil)
	local pickups = World:find_units_quick("all", 23)
	for _, unit in ipairs(pickups) do
		if alive(unit) and unit:pickup() and unit:pickup().reload_contour then
			unit:pickup():reload_contour()
		end
	end
end

function MenuCallbackHandler:toggle_mute_heist_vo(item)
	managers.user:set_setting("mute_heist_vo", item:value() == "on", nil)
end

function MenuCallbackHandler:choice_test(item)
	local test = item:value()
	print("MenuCallbackHandler", test)
end

function MenuCallbackHandler:choice_premium_contact(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	managers.menu:active_menu().logic:selected_node():parameters().listed_contact = string.gsub(item:value(), "#", "")
	local logic = managers.menu:active_menu().logic
	if logic then
		logic:refresh_node()
	end
end

function MenuCallbackHandler:choice_controller_type(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	managers.menu:active_menu().logic:selected_node():parameters().controller_category = item:value()
	local logic = managers.menu:active_menu().logic
	if logic then
		logic:refresh_node()
	end
end

function MenuCallbackHandler:choice_max_lobbies_filter(item)
	if not managers.crimenet then
		return
	end
	local max_server_jobs_filter = item:value()
	managers.network.matchmake:set_lobby_return_count(max_server_jobs_filter)
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_max_servers", max_server_jobs_filter)
end

function MenuCallbackHandler:choice_distance_filter(item)
	local dist_filter = item:value()
	if managers.network.matchmake:distance_filter() == dist_filter then
		return
	end
	managers.network.matchmake:set_distance_filter(dist_filter)
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_distance", dist_filter)
end

function MenuCallbackHandler:choice_difficulty_filter(item)
	local diff_filter = item:value()
	if managers.network.matchmake:get_lobby_filter("difficulty") == diff_filter then
		return
	end
	managers.network.matchmake:add_lobby_filter("difficulty", diff_filter, "equal")
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_difficulty", diff_filter)
end

function MenuCallbackHandler:choice_job_id_filter(item)
	local job_id_filter = item:value()
	if managers.network.matchmake:get_lobby_filter("job_id") == job_id_filter then
		return
	end
	managers.network.matchmake:add_lobby_filter("job_id", job_id_filter, "equal")
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_contract", job_id_filter)
end

function MenuCallbackHandler:choice_new_servers_only(item)
	local num_players_filter = item:value()
	if managers.network.matchmake:get_lobby_filter("num_players") == num_players_filter then
		return
	end
	managers.network.matchmake:add_lobby_filter("num_players", num_players_filter, "equal")
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_new_servers_only", num_players_filter)
end

function MenuCallbackHandler:choice_kick_option(item)
	local kicking_filter = item:value()
	if managers.network.matchmake:get_lobby_filter("kick_option") == kicking_filter then
		return
	end
	managers.network.matchmake:add_lobby_filter("kick_option", kicking_filter, "equal")
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_kick", kicking_filter)
end

function MenuCallbackHandler:choice_job_appropriate_filter(item)
	local diff_appropriate = item:value()
	Global.game_settings.search_appropriate_jobs = diff_appropriate == "on" and true or false
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_level_appopriate", diff_appropriate == "on" and true or false)
end

function MenuCallbackHandler:choice_allow_safehouses_filter(item)
	local allow_safehouses = item:value() == "on" and true or false
	Global.game_settings.allow_search_safehouses = allow_safehouses
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_safehouses", allow_safehouses)
end

function MenuCallbackHandler:choice_mutated_lobbies_filter(item)
	local allow_mutators = item:value() == "on" and true or false
	Global.game_settings.search_mutated_lobbies = allow_mutators
	managers.user:set_setting("crimenet_filter_mutators", allow_mutators)
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
end

function MenuCallbackHandler:choice_server_state_lobby(item)
	local state_filter = item:value()
	if managers.network.matchmake:get_lobby_filter("state") == state_filter then
		return
	end
	managers.network.matchmake:add_lobby_filter("state", state_filter, "equal")
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
	managers.user:set_setting("crimenet_filter_in_lobby", state_filter)
end

function MenuCallbackHandler:save_crimenet_filters()
	managers.savefile:save_setting(true)
end

function MenuCallbackHandler:refresh_node(item)
	local logic = managers.menu:active_menu().logic
	if logic then
		logic:refresh_node()
	end
end

function MenuCallbackHandler:open_contract_node(item)
	local job_tweak = tweak_data.narrative:job_data(item:parameters().id)
	local is_professional = job_tweak and job_tweak.professional or false
	local is_competitive = job_tweak and job_tweak.competitive or false
	self._temp_job_data = job_tweak
	managers.menu:open_node(Global.game_settings.single_player and "crimenet_contract_singleplayer" or "crimenet_contract_host", {
		{
			job_id = item:parameters().id,
			difficulty = is_professional and "hard" or "normal",
			difficulty_id = is_professional and 3 or 2,
			professional = is_professional,
			competitive = is_competitive,
			customize_contract = true,
			contract_visuals = job_tweak.contract_visuals
		}
	})
end

function MenuCallbackHandler:is_contract_difficulty_allowed(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node():parameters().menu_component_data then
		return false
	end
	local job_data = managers.menu:active_menu().logic:selected_node():parameters().menu_component_data
	if not job_data.job_id then
		return false
	end
	if job_data.professional and item:value() < 3 then
		return false
	end
	if job_data.professional or item:value() > 5 then
	end
	local job_jc = tweak_data.narrative:job_data(job_data.job_id).jc
	local difficulty_jc = (item:value() - 2) * 10
	local plvl = managers.experience:current_level()
	local prank = managers.experience:current_rank()
	local level_lock = tweak_data.difficulty_level_locks[item:value()] or 0
	local is_not_level_locked = 1 <= prank or plvl >= level_lock
	return is_not_level_locked and managers.job:get_max_jc_for_player() >= math.clamp(job_jc + difficulty_jc, 0, 100)
end

function MenuCallbackHandler:buy_crimenet_contract(item, node)
	local job_data = item:parameters().gui_node.node:parameters().menu_component_data
	if not managers.money:can_afford_buy_premium_contract(job_data.job_id, job_data.difficulty_id or 3) then
		return
	end
	local params = {}
	params.contract_fee = managers.experience:cash_string(managers.money:get_cost_of_premium_contract(job_data.job_id, job_data.difficulty_id or 3))
	params.offshore = managers.experience:cash_string(managers.money:offshore())
	params.yes_func = callback(self, self, "_buy_crimenet_contract", item, node)
	managers.menu:show_confirm_buy_premium_contract(params)
end

function MenuCallbackHandler:_buy_crimenet_contract(item, node)
	local job_data = item:parameters().gui_node.node:parameters().menu_component_data
	if not managers.money:can_afford_buy_premium_contract(job_data.job_id, job_data.difficulty_id or 3) then
		return
	end
	managers.money:on_buy_premium_contract(job_data.job_id, job_data.difficulty_id or 3)
	managers.job:on_buy_job(job_data.job_id, job_data.difficulty_id or 3)
	managers.menu:active_menu().logic:navigate_back(true)
	managers.menu:active_menu().logic:navigate_back(true)
	self._sound_source:post_event("item_buy")
	if Global.game_settings.single_player then
		MenuCallbackHandler:start_single_player_job(job_data)
	else
		MenuCallbackHandler:start_job(job_data)
	end
	MenuCallbackHandler:save_progress()
end

function MenuCallbackHandler:crimenet_casino_secured_cards()
	local card1 = managers.menu:active_menu().logic:selected_node():item("secure_card_1"):value() == "on" and 1 or 0
	local card2 = managers.menu:active_menu().logic:selected_node():item("secure_card_2"):value() == "on" and 1 or 0
	local card3 = managers.menu:active_menu().logic:selected_node():item("secure_card_3"):value() == "on" and 1 or 0
	return card1 + card2 + card3
end

function MenuCallbackHandler:crimenet_casino_update(item)
	if item:enabled() then
		self:refresh_node()
	end
end

function MenuCallbackHandler:crimenet_casino_safe_card1(item)
	if managers.menu:active_menu().logic:selected_node():item("secure_card_1"):enabled() then
		if managers.menu:active_menu().logic:selected_node():item("secure_card_2"):value() == "on" then
			managers.menu:active_menu().logic:selected_node():item("secure_card_1"):set_value("on")
		end
		managers.menu:active_menu().logic:selected_node():item("secure_card_2"):set_value("off")
		managers.menu:active_menu().logic:selected_node():item("secure_card_3"):set_value("off")
		self:refresh_node()
	end
end

function MenuCallbackHandler:crimenet_casino_safe_card2(item)
	if managers.menu:active_menu().logic:selected_node():item("secure_card_2"):enabled() then
		if managers.menu:active_menu().logic:selected_node():item("secure_card_3"):value() == "on" then
			managers.menu:active_menu().logic:selected_node():item("secure_card_2"):set_value("on")
		end
		managers.menu:active_menu().logic:selected_node():item("secure_card_1"):set_value("on")
		managers.menu:active_menu().logic:selected_node():item("secure_card_3"):set_value("off")
		self:refresh_node()
	end
end

function MenuCallbackHandler:crimenet_casino_safe_card3(item)
	if managers.menu:active_menu().logic:selected_node():item("secure_card_3"):enabled() then
		managers.menu:active_menu().logic:selected_node():item("secure_card_1"):set_value("on")
		managers.menu:active_menu().logic:selected_node():item("secure_card_2"):set_value("on")
		self:refresh_node()
	end
end

function MenuCallbackHandler:not_customize_contract(item)
	return not self:customize_contract(item)
end

function MenuCallbackHandler:customize_contract(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node():parameters().menu_component_data then
		return false
	end
	return managers.menu:active_menu().logic:selected_node():parameters().menu_component_data.customize_contract
end

function MenuCallbackHandler:change_contract_difficulty(item)
	managers.menu_component:set_crimenet_contract_difficulty_id(item:value())
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	local job_data = item:parameters().gui_node.node:parameters().menu_component_data
	if not job_data or not job_data.job_id then
		return false
	end
	local buy_contract_item = managers.menu:active_menu().logic:selected_node():item("buy_contract")
	if not buy_contract_item then
		return false
	end
	local can_afford = managers.money:can_afford_buy_premium_contract(job_data.job_id, job_data.difficulty_id or 3)
	buy_contract_item:parameters().text_id = can_afford and "menu_cn_premium_buy_accept" or "menu_cn_premium_cannot_buy"
	buy_contract_item:set_enabled(can_afford)
	self:refresh_node()
end

function MenuCallbackHandler:choice_difficulty_filter_ps3(item)
	local diff_filter = item:value()
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

function MenuCallbackHandler:lobby_start_campaign(item)
	MenuCallbackHandler:choice_lobby_campaign(item)
	MenuCallbackHandler:start_the_game()
end

function MenuCallbackHandler:lobby_create_campaign(item)
	MenuCallbackHandler:choice_lobby_campaign(item)
	MenuCallbackHandler:create_lobby(item)
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
	managers.user:set_setting("crimenet_filter_friends_only", choice_friends_only)
end

function MenuCallbackHandler:choice_lobby_permission(item)
	local permission = item:value()
	local level_id = item:value()
	Global.game_settings.permission = permission
	self:update_matchmake_attributes()
	self:_on_host_setting_updated()
end

function MenuCallbackHandler:choice_lobby_reputation_permission(item)
	local reputation_permission = item:value()
	Global.game_settings.reputation_permission = reputation_permission
	self:update_matchmake_attributes()
	self:_on_host_setting_updated()
end

function MenuCallbackHandler:choice_team_ai(item)
	Global.game_settings.team_ai = item:value() ~= 0
	Global.game_settings.team_ai_option = item:value()
end

function MenuCallbackHandler:choice_drop_in(item)
	local choice_drop_in = item:value()
	Global.game_settings.drop_in_allowed = choice_drop_in ~= 0
	Global.game_settings.drop_in_option = choice_drop_in
	self:update_matchmake_attributes()
	if managers.network:session() then
		managers.network:session():chk_server_joinable_state()
	end
	self:_on_host_setting_updated()
end

function MenuCallbackHandler:choice_kicking_option(item)
	Global.game_settings.kick_option = item:value()
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
	Global.game_settings.team_ai = item:value() ~= 0
	Global.game_settings.team_ai_option = item:value()
	self:_on_host_setting_updated()
end

function MenuCallbackHandler:choice_crimenet_auto_kick(item)
	Global.game_settings.auto_kick = item:value() == "on"
	self:_on_host_setting_updated()
end

function MenuCallbackHandler:choice_crimenet_drop_in(item)
	local choice_drop_in = item:value()
	Global.game_settings.drop_in_allowed = choice_drop_in ~= 0
	Global.game_settings.drop_in_option = choice_drop_in
	if managers.network:session() then
		managers.network:session():chk_server_joinable_state()
	end
end

function MenuCallbackHandler:accept_crimenet_contract(item, node)
	managers.menu:active_menu().logic:navigate_back(true)
	local job_data = item:parameters().gui_node.node:parameters().menu_component_data
	if job_data.server then
		managers.crime_spree:join_server(job_data)
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
	local drop_in = Global.game_settings.drop_in_option
	local job_id = tweak_data.narrative:get_index_from_job_id(managers.job:current_real_job_id())
	local attributes = {
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
	if self:is_win32() then
		local kick_option = Global.game_settings.kick_option
		attributes.numbers[8] = kick_option
		local job_class = managers.job:calculate_job_class(managers.job:current_real_job_id(), difficulty_id)
		attributes.numbers[9] = job_class
		local job_plan = Global.game_settings.job_plan
		if tweak_data.quickplay.stealth_levels[managers.job:current_real_job_id()] then
			job_plan = 2
		end
		attributes.numbers[10] = job_plan
	end
	return attributes
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
end

function MenuCallbackHandler:play_online_game()
	Global.game_settings.single_player = false
	if managers.network.matchmake and managers.network.matchmake.load_user_filters then
		managers.network.matchmake:load_user_filters()
	end
end

function MenuCallbackHandler:play_safehouse(params)
	local function yes_func()
		self:play_single_player()
		
		Global.mission_manager.has_played_tutorial = true
		self:start_single_player_job({job_id = "safehouse", difficulty = "normal"})
	end
	
	if params.skip_question then
		yes_func()
		return
	end
	managers.menu:show_play_safehouse_question({yes_func = yes_func})
end

function MenuCallbackHandler:play_short_heist(item)
	Global.game_settings.team_ai = true
	Global.game_settings.team_ai_option = 2
	self:play_single_player()
	self:start_single_player_job({
		job_id = item and item:parameters().job or "short",
		difficulty = "normal"
	})
end

function MenuCallbackHandler:_increase_infamous(yes_clbk)
	managers.menu_scene:destroy_infamy_card()
	if managers.experience:current_level() < 100 or managers.experience:current_rank() >= #tweak_data.infamy.ranks then
		return
	end
	local rank = managers.experience:current_rank() + 1
	managers.experience:reset()
	managers.experience:set_current_rank(rank)
	local offshore_cost = Application:digest_value(tweak_data.infamy.ranks[rank], false)
	if 0 < offshore_cost then
		managers.money:deduct_from_total(managers.money:total())
		managers.money:deduct_from_offshore(offshore_cost)
	end
	managers.skilltree:infamy_reset()
	managers.blackmarket:reset_equipped()
	if managers.menu_component then
		managers.menu_component:refresh_player_profile_gui()
	end
	local logic = managers.menu:active_menu().logic
	if logic then
		logic:refresh_node()
		logic:select_item("crimenet")
	end
	managers.savefile:save_progress()
	managers.savefile:save_setting(true)
	managers.menu:post_event("infamous_player_join_stinger")
	if yes_clbk then
		yes_clbk()
	end
	if SystemInfo:distribution() == Idstring("STEAM") then
		managers.statistics:publish_level_to_steam()
	end
end

function MenuCallbackHandler:become_infamous(params)
	if not self:can_become_infamous() then
		return
	end
	local infamous_cost = Application:digest_value(tweak_data.infamy.ranks[managers.experience:current_rank() + 1], false)
	local yes_clbk = params and params.yes_clbk or false
	local no_clbk = params and params.no_clbk
	local params = {}
	params.cost = managers.experience:cash_string(infamous_cost)
	params.free = infamous_cost == 0
	if infamous_cost <= managers.money:offshore() and managers.experience:current_level() >= 100 then
		function params.yes_func()
			local rank = managers.experience:current_rank() + 1
			
			managers.menu:open_node("blackmarket_preview_node", {
				{
					back_callback = callback(MenuCallbackHandler, MenuCallbackHandler, "_increase_infamous", yes_clbk)
				}
			})
			managers.menu:post_event("infamous_stinger_level_" .. (rank < 10 and "0" or "") .. tostring(rank))
			managers.menu_scene:spawn_infamy_card(rank)
		end
	end
	
	function params.no_func()
		if no_clbk then
			no_clbk()
		end
	end
	
	managers.menu:show_confirm_become_infamous(params)
end

function MenuCallbackHandler:choice_choose_video_adapter(item)
	managers.viewport:set_adapter_index(item:value())
end

function MenuCallbackHandler:apply_and_save_render_settings()
	local func = function()
		Application:apply_render_settings()
		Application:save_render_settings()
	end
	local fullscreen_ws = managers.menu_component and managers.menu_component._fullscreen_ws
	repeat
		do break end -- pseudo-goto
		if alive(fullscreen_ws) then
			local black_overlay = fullscreen_ws:panel():panel({
				layer = tweak_data.gui.MOUSE_LAYER - 1
			})
			black_overlay:rect({
				color = Color.black
			})
			black_overlay:text({
				text = managers.localization:to_upper_text("menu_apply_render_settings"),
				font = tweak_data.menu.pd2_large_font,
				font_size = 50,
				align = "center",
				valign = "center",
				halign = "center",
				vertical = "center"
			})
			black_overlay:animate(function(o)
				coroutine.yield()
				coroutine.yield()
				func()
				over(0.05, function(p)
					black_overlay:set_alpha(1 - p)
				end)
				fullscreen_ws:panel():remove(black_overlay)
			end)
	until true
	else
		func()
	end
end

function MenuCallbackHandler:choice_choose_texture_quality(item)
	RenderSettings.texture_quality_default = item:value()
	MenuCallbackHandler:apply_and_save_render_settings()
end

function MenuCallbackHandler:choice_choose_shadow_quality(item)
	RenderSettings.shadow_quality_default = item:value()
	MenuCallbackHandler:apply_and_save_render_settings()
end

function MenuCallbackHandler:toggle_gpu_flush_setting(item)
	managers.user:set_setting("flush_gpu_command_queue", item:value() == "on")
end

function MenuCallbackHandler:choice_choose_anisotropic(item)
	RenderSettings.max_anisotropy = item:value()
	MenuCallbackHandler:apply_and_save_render_settings()
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

function MenuCallbackHandler:choice_corpse_limit(item)
	managers.user:set_setting("corpse_limit", item:value())
end

function MenuCallbackHandler:choice_choose_ao(item)
	managers.user:set_setting("video_ao", item:value())
end

function MenuCallbackHandler:toggle_parallax(item)
	managers.user:set_setting("parallax_mapping", item:value() == "on")
end

function MenuCallbackHandler:choice_choose_aa(item)
	managers.user:set_setting("video_aa", item:value())
end

function MenuCallbackHandler:toggle_workshop(item)
	managers.user:set_setting("workshop", item:value() == "on")
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

function MenuCallbackHandler:toggle_use_thq_weapon_parts(item)
	managers.user:set_setting("use_thq_weapon_parts", item:value() == "on")
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

function MenuCallbackHandler:choice_max_streaming_chunk(item)
	managers.user:set_setting("max_streaming_chunk", item:value())
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

function MenuCallbackHandler:toggle_headbob(item)
	managers.user:set_setting("use_headbob", item:value() == "on")
end

function MenuCallbackHandler:on_stage_success()
	managers.mission:on_stage_success()
end

function MenuCallbackHandler:lobby_start_the_game()
	MenuCallbackHandler:start_the_game()
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
	return true
end

function MenuCallbackHandler:_dialog_leave_lobby_yes()
	if managers.network:session() then
		managers.network:session():local_peer():set_in_lobby(false)
		managers.network:session():send_to_peers("set_peer_left")
	end
	managers.crime_spree:disable_crime_spree_gamemode()
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
		elseif res == "BANNED" then
			managers.menu:show_peer_banned_dialog()
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
	if self:is_ps3() or self:is_ps4() then
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
	if managers.network.matchmake.lobby_handler then
		if MenuCallbackHandler:is_overlay_enabled() then
			Steam:overlay_activate("invite", managers.network.matchmake.lobby_handler:id())
		else
			managers.menu:show_enable_steam_overlay()
		end
	end
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

function MenuCallbackHandler:invite_friends_XB1()
	if managers.network.matchmake._session then
		local platform_id = managers.user:get_platform_id()
		XboxLive:invite_friends_ui(platform_id, managers.network.matchmake._session)
	end
end

function MenuCallbackHandler:invite_xbox_live_party()
	local platform_id = managers.user:get_platform_id()
	XboxLive:show_party_ui(platform_id)
end

function MenuCallbackHandler:invite_friends_ps4()
	PSN:invite_friends()
end

function MenuCallbackHandler:view_invites()
	print("View invites")
	print(PSN:display_message_invitation())
end

function MenuCallbackHandler:waiting_players_visible(item)
	return #managers.wait:list_of_waiting() > 0
end

function MenuCallbackHandler:show_waiting_players(item)
	managers.wait:spawn_all_waiting()
end

function MenuCallbackHandler:kick_player(item)
	if managers.vote:option_host_kick() then
		managers.vote:message_host_kick(item:parameters().peer)
	elseif managers.vote:option_vote_kick() then
		managers.vote:kick(item:parameters().peer:id())
	end
end

function MenuCallbackHandler:mute_player(item)
	if managers.network.voice_chat then
		managers.network.voice_chat:mute_player(item:parameters().peer, item:value() == "on")
		item:parameters().peer:set_muted(item:value() == "on")
	end
end

function MenuCallbackHandler:mute_xbox_player(item)
	if managers.network.voice_chat then
		managers.network.voice_chat:set_muted(item:parameters().xuid, item:value() == "on")
		item:parameters().peer:set_muted(item:value() == "on")
	end
end

function MenuCallbackHandler:mute_xb1_player(item)
	if managers.network.voice_chat then
		managers.network.voice_chat:set_muted(item:parameters().xuid, item:value() == "on")
		item:parameters().peer:set_muted(item:value() == "on")
	end
end

function MenuCallbackHandler:mute_ps4_player(item)
	if managers.network.voice_chat then
		managers.network.voice_chat:mute_player(item:value() == "on", item:parameters().peer)
		item:parameters().peer:set_muted(item:value() == "on")
	end
end

function MenuCallbackHandler:restart_level(item)
	if not managers.vote:available() or managers.vote:is_restarting() then
		return
	end
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_mp_restart_level_title")
	dialog_data.text = managers.localization:text(managers.vote:option_vote_restart() and "dialog_mp_restart_level_message" or "dialog_mp_restart_level_host_message")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	
	function yes_button.callback_func()
		if managers.vote:option_vote_restart() then
			managers.vote:restart()
		else
			managers.vote:restart_auto()
		end
	end
	
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
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

function MenuCallbackHandler:start_the_game()
	local mutators_manager = managers.mutators
	if mutators_manager and mutators_manager:should_delay_game_start() then
		if not mutators_manager:_check_all_peers_are_ready() then
			mutators_manager:use_start_the_game_initial_delay()
		end
		mutators_manager:send_mutators_notification_to_clients(mutators_manager:delay_lobby_time())
		managers.menu:open_node("start_the_game_countdown")
		return
	end
	if self._game_started then
		return
	end
	self._game_started = true
	local level_id = Global.game_settings.level_id
	local level_name = level_id and tweak_data.levels[level_id].world_name
	if Global.boot_invite then
		Global.boot_invite.used = true
		Global.boot_invite.pending = false
	end
	local mission = Global.game_settings.mission ~= "none" and Global.game_settings.mission or nil
	local world_setting = Global.game_settings.world_setting
	managers.network:session():load_level(level_name, mission, world_setting, nil, level_id)
end

function MenuCallbackHandler:cancel_start_the_game_countdown()
	managers.mutators:start_the_game_countdown_cancelled()
end

function MenuCallbackHandler:restart_game(item)
	managers.menu:show_restart_game_dialog({
		yes_func = function()
			if managers.job:stage_success() then
				print("No restart after stage success")
				return
			end
			managers.game_play_central:restart_the_game()
		end
	})
end

function MenuCallbackHandler:set_music_volume(item)
	local volume = item:value()
	local old_volume = managers.user:get_setting("music_volume")
	managers.user:set_setting("music_volume", volume)
	if volume > old_volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

function MenuCallbackHandler:set_sfx_volume(item)
	local volume = item:value()
	local old_volume = managers.user:get_setting("sfx_volume")
	managers.user:set_setting("sfx_volume", volume)
	if volume > old_volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

function MenuCallbackHandler:set_voice_volume(item)
	local volume = item:value()
	local old_volume = managers.user:get_setting("voice_volume")
	managers.user:set_setting("voice_volume", volume)
	if volume > old_volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

function MenuCallbackHandler:set_brightness(item)
	local brightness = item:value()
	managers.user:set_setting("brightness", brightness)
end

function MenuCallbackHandler:set_effect_quality(item)
	local effect_quality = item:value()
	managers.user:set_setting("effect_quality", effect_quality)
end

function MenuCallbackHandler:_update_linked_sliders(linked_sliders, value)
	local triggers = {}
	for _, item in ipairs(linked_sliders) do
		local slider = managers.menu:active_menu().logic:selected_node():item(item)
		if slider and slider:visible() and math.abs(value - slider:value()) > 0.001 then
			slider:set_value(value)
			table.insert(triggers, slider)
		end
	end
	for _, slider in ipairs(triggers) do
		slider:trigger()
	end
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

function MenuCallbackHandler:set_camera_sensitivity_x(item)
	local value = item:value()
	managers.user:set_setting("camera_sensitivity_x", value)
	if not managers.user:get_setting("enable_camera_sensitivity_separate") then
		self:_update_linked_sliders({
			"camera_sensitivity_vertical",
			"camera_zoom_sensitivity_horizontal",
			"camera_zoom_sensitivity_vertical"
		}, value)
	end
end

function MenuCallbackHandler:set_camera_sensitivity_y(item)
	local value = item:value()
	managers.user:set_setting("camera_sensitivity_y", value)
	if not managers.user:get_setting("enable_camera_sensitivity_separate") then
		self:_update_linked_sliders({
			"camera_sensitivity_horizontal",
			"camera_zoom_sensitivity_horizontal",
			"camera_zoom_sensitivity_vertical"
		}, value)
	end
end

function MenuCallbackHandler:toggle_camera_sensitivity_separate(item)
	local value = item:value() == "on"
	managers.user:set_setting("enable_camera_sensitivity_separate", value)
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

function MenuCallbackHandler:set_camera_zoom_sensitivity_x(item)
	local value = item:value()
	managers.user:set_setting("camera_zoom_sensitivity_x", value)
	if not managers.user:get_setting("enable_camera_sensitivity_separate") then
		self:_update_linked_sliders({
			"camera_sensitivity_horizontal",
			"camera_sensitivity_vertical",
			"camera_zoom_sensitivity_vertical"
		}, value)
	end
end

function MenuCallbackHandler:set_camera_zoom_sensitivity_y(item)
	local value = item:value()
	managers.user:set_setting("camera_zoom_sensitivity_y", value)
	if not managers.user:get_setting("enable_camera_sensitivity_separate") then
		self:_update_linked_sliders({
			"camera_sensitivity_horizontal",
			"camera_sensitivity_vertical",
			"camera_zoom_sensitivity_horizontal"
		}, value)
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

function MenuCallbackHandler:toggle_fov_based_zoom(item)
	local value = item:value() == "on"
	managers.user:set_setting("enable_fov_based_sensitivity", value)
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
	managers.platform:set_playing(false)
	managers.job:clear_saved_ghost_bonus()
	managers.statistics:stop_session({quit = true})
	managers.savefile:save_progress()
	managers.job:deactivate_current_job()
	managers.gage_assignment:deactivate_assignments()
	managers.custom_safehouse:flush_completed_trophies()
	managers.crime_spree:on_left_lobby()
	if Network:multiplayer() then
		Network:set_multiplayer(false)
		managers.network:session():send_to_peers("set_peer_left")
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

function MenuCallbackHandler:leave_mission()
	if game_state_machine:current_state_name() ~= "disconnected" then
		if self:is_singleplayer() then
			setup:load_start_menu()
		else
			self:load_start_menu_lobby()
		end
	end
end

function MenuCallbackHandler:abort_mission()
	if game_state_machine:current_state_name() == "disconnected" then
		return
	end
	
	local function yes_func()
		if game_state_machine:current_state_name() ~= "disconnected" then
			self:load_start_menu_lobby()
		end
	end
	
	managers.menu:show_abort_mission_dialog({yes_func = yes_func})
end

function MenuCallbackHandler:load_start_menu_lobby()
	managers.job:clear_saved_ghost_bonus()
	managers.job:stop_sounds()
	managers.experience:mission_xp_clear()
	managers.custom_safehouse:flush_completed_trophies()
	managers.network:session():load_lobby()
end

function MenuCallbackHandler:_dialog_end_game_no()
end

function MenuCallbackHandler:_reset_mainmusic()
	managers.music:post_event("stop_all_music")
	managers.music:post_event(managers.music:jukebox_menu_track("mainmenu"))
end

function MenuCallbackHandler:show_steam_controller_binding_panel()
	if MenuCallbackHandler:is_not_steam_controller() then
		return
	end
	local controller = managers.controller:get_default_controller()
	if not controller or controller:show_binding_panel() then
	elseif MenuCallbackHandler:is_overlay_enabled() then
		managers.menu:show_requires_big_picture()
	else
		managers.menu:show_enable_steam_overlay()
	end
end

function MenuCallbackHandler:set_default_options()
	local params = {
		text = managers.localization:text("dialog_default_options_message"),
		callback = function()
			managers.user:reset_setting_map()
			managers.music:jukebox_set_defaults()
			self:_reset_mainmusic()
			if Global.crimenet then
				Global.crimenet.quickplay = {}
			end
			managers.mutators:reset_all_mutators()
		end
	}
	managers.menu:show_default_option_dialog(params)
end

function MenuCallbackHandler:set_default_control_options()
	local params = {
		text = managers.localization:text("dialog_default_controls_options_message"),
		callback = function()
			managers.user:reset_controls_setting_map()
			self:refresh_node()
		end
	}
	managers.menu:show_default_option_dialog(params)
end

function MenuCallbackHandler:set_default_video_options()
	local params = {
		text = managers.localization:text("dialog_default_video_options_message"),
		callback = function()
			managers.user:reset_video_setting_map()
			self:refresh_node()
		end
	}
	managers.menu:show_default_option_dialog(params)
end

function MenuCallbackHandler:set_default_sound_options()
	local params = {
		text = managers.localization:text("dialog_default_sound_options_message"),
		callback = function()
			managers.user:reset_sound_setting_map()
			managers.music:jukebox_set_defaults()
			self:refresh_node()
			self:_reset_mainmusic()
		end
	}
	managers.menu:show_default_option_dialog(params)
end

function MenuCallbackHandler:set_default_network_options()
	local params = {
		text = managers.localization:text("dialog_default_network_options_message"),
		callback = function()
			managers.user:reset_network_setting_map()
			self:refresh_node()
		end
	}
	managers.menu:show_default_option_dialog(params)
end

function MenuCallbackHandler:resume_game()
	managers.menu:close_menu("menu_pause")
end

function MenuManager:on_heister_interaction()
	self:open_menu("heister_interact_menu")
	self._heister_interaction = true
end

function MenuManager:on_resume_heister_interaction()
	self:close_menu("heister_interact_menu")
	self._heister_interaction = false
	local player_unit = managers.player:player_unit()
	if alive(player_unit) and player_unit:movement():current_state().update_check_actions_paused then
		player_unit:movement():current_state():update_check_actions_paused()
	end
end

function MenuCallbackHandler:heister_interaction_resume_game()
	managers.menu:on_resume_heister_interaction()
end

function MenuCallbackHandler:change_upgrade(menu_item)
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

function MenuCallbackHandler:menu_back()
	managers.menu:back()
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

function MenuCallbackHandler:set_default_controller(item)
	local params = {
		text = managers.localization:text("dialog_use_default_keys_message"),
		callback = function()
			managers.controller:load_settings("settings/controller_settings")
			managers.controller:clear_user_mod(item:parameters().category, MenuCustomizeControllerCreator.CONTROLS_INFO)
			local logic = managers.menu:active_menu().logic
			if logic then
				logic:refresh_node()
			end
		end
	}
	managers.menu:show_default_option_dialog(params)
end

function MenuCallbackHandler:choice_button_layout_category(item)
	local node_gui = managers.menu:active_menu().renderer:active_node_gui()
	node_gui:set_current_category(item:value())
end

function MenuCallbackHandler:debug_goto_custody()
	local player = managers.player:player_unit()
	if not alive(player) then
		return
	end
	if managers.player:current_state() ~= "bleed_out" then
		managers.player:set_player_state("bleed_out")
	end
	if managers.player:current_state() ~= "fatal" then
		managers.player:set_player_state("fatal")
	end
	managers.player:force_drop_carry()
	managers.statistics:downed({death = true})
	IngameFatalState.on_local_player_dead()
	game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
	player:character_damage():set_invulnerable(true)
	player:character_damage():set_health(0)
	player:base():_unregister()
	player:base():set_slot(player, 0)
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

PauseMenu = PauseMenu or class()

function PauseMenu:modify_node(node)
	local item = node:item("restart_vote")
	if item then
		item:set_enabled(managers.vote:available())
		item:set_parameter("help_id", managers.vote:help_text() or "")
	end
	if managers.vote:is_restarting() then
		item = node:item("restart_level")
		if item then
			item:set_enabled(false)
		end
	end
	return node
end

function PauseMenu:refresh_node(node)
	return self:modify_node(node)
end

KickPlayer = KickPlayer or class()

function KickPlayer:modify_node(node, up)
	node:clean_items()
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name() .. " (" .. (peer:rank() > 0 and managers.experience:rank_string(peer:rank()) .. "-" or "") .. (peer:level() or "") .. ")",
				callback = "kick_player",
				to_upper = false,
				rpc = peer:rpc(),
				peer = peer,
				help_id = peer:is_host() and managers.localization:text("menu_vote_kick_is_host") or managers.vote:option_vote_kick() and managers.vote:help_text() or "",
				localize = false,
				localize_help = false
			}
			local new_item = node:create_item(nil, params)
			if peer:is_host() or managers.vote:option_vote_kick() and not managers.vote:available() then
				new_item:set_enabled(false)
			end
			node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(node)
	return node
end

function KickPlayer:refresh_node(node)
	return self:modify_node(node)
end

MutePlayer = MutePlayer or class()

function MutePlayer:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name() .. " (" .. (peer:rank() > 0 and managers.experience:rank_string(peer:rank()) .. "-" or "") .. (peer:level() or "") .. ")",
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
			new_item:set_value(peer:is_muted() and "on" or "off")
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
			new_item:set_value(peer:is_muted() and "on" or "off")
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MutePlayerXB1 = MutePlayerXB1 or class()

function MutePlayerXB1:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name(),
				callback = "mute_xb1_player",
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
			new_item:set_value(peer:is_muted() and "on" or "off")
			new_node:add_item(new_item)
		end
	end
	managers.menu:add_back_button(new_node)
	return new_node
end

MutePlayerPS4 = MutePlayerPS4 or class()

function MutePlayerPS4:modify_node(node, up)
	local new_node = deep_clone(node)
	if managers.network:session() then
		for _, peer in pairs(managers.network:session():peers()) do
			local params = {
				name = peer:name(),
				text_id = peer:name(),
				callback = "mute_ps4_player",
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
			new_item:set_value(peer:is_muted() and "on" or "off")
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
			value = 0
		},
		{
			_meta = "option",
			text_id = "menu_dist_filter_default",
			value = 1
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
		if not item:parameters().back and not item:parameters().filter and not item:parameters().pd2_corner then
			dead_list[item:parameters().room_id] = true
		end
	end
	for i, room in ipairs(room_list) do
		local name_str = tostring(room.owner_name)
		local attributes_numbers = attribute_list[i].numbers
		local attributes_mutators = attribute_list[i].mutators
		if managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers, nil, attributes_mutators) then
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
						utf8.to_upper(host_name),
						utf8.to_upper(level_name),
						utf8.to_upper(state_name),
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
					item:parameters().columns[2] = utf8.to_upper(level_name)
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

function MenuSoundCreator:refresh_node(node)
	self:modify_node(node)
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
				min_difficulty = tonumber(item:parameter("difficulty"))
			elseif item:visible() then
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
	if (managers.menu:is_ps3() or managers.menu:is_ps4()) and not managers.network:session() then
		PSN:set_online_callback(callback(managers.menu, managers.menu, "refresh_player_profile_gui"))
	end
	return node
end

GlobalSuccessRateInitiator = GlobalSuccessRateInitiator or class()

function GlobalSuccessRateInitiator:modify_node(node)
	managers.menu:show_global_success(node)
	return node
end

LobbyOptionInitiator = LobbyOptionInitiator or class()

function LobbyOptionInitiator:modify_node(node)
	MenuManager.refresh_level_select(node, Network:is_server())
	local item_permission_campaign = node:item("lobby_permission")
	if item_permission_campaign then
		item_permission_campaign:set_value(Global.game_settings.permission)
	end
	local item_lobby_drop_in_option = node:item("lobby_drop_in_option")
	if item_lobby_drop_in_option then
		item_lobby_drop_in_option:set_value(Global.game_settings.drop_in_option)
	end
	local item_lobby_toggle_ai = node:item("toggle_ai")
	if item_lobby_toggle_ai then
		item_lobby_toggle_ai:set_value(Global.game_settings.team_ai and Global.game_settings.team_ai_option or 0)
	end
	local item_lobby_toggle_auto_kick = node:item("toggle_auto_kick")
	if item_lobby_toggle_auto_kick then
		item_lobby_toggle_auto_kick:set_value(Global.game_settings.auto_kick and "on" or "off")
	end
	local character_item = node:item("choose_character")
	if character_item then
		local value = managers.network:session() and managers.network:session():local_peer():character() or "random"
		character_item:set_value(value)
	end
	local reputation_permission_item = node:item("lobby_reputation_permission")
	if reputation_permission_item then
		reputation_permission_item:set_value(Global.game_settings.reputation_permission)
	end
	local item_lobby_job_plan = node:item("lobby_job_plan")
	if item_lobby_job_plan then
		item_lobby_job_plan:set_value(Global.game_settings.job_plan or -1)
		if tweak_data.quickplay.stealth_levels[managers.job:current_real_job_id()] then
			local stealth_option
			for _, option in ipairs(item_lobby_job_plan:options()) do
				if option:value() == 2 then
					stealth_option = option
					break
				end
			end
			item_lobby_job_plan:clear_options()
			item_lobby_job_plan:add_option(stealth_option)
		end
	end
	return node
end

VerifyLevelOptionInitiator = VerifyLevelOptionInitiator or class()

function VerifyLevelOptionInitiator:modify_node(node)
	MenuManager.refresh_level_select(node, true)
	return node
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
	"weapon_firemode",
	"throw_grenade",
	"run",
	"jump",
	"duck",
	"melee",
	"interact",
	"interact_secondary",
	"use_item",
	"toggle_chat",
	"push_to_talk",
	"cash_inspect",
	"deploy_bipod",
	"change_equipment",
	"drive",
	"hand_brake",
	"vehicle_change_camera",
	"vehicle_rear_camera",
	"vehicle_shooting_stance",
	"vehicle_exit",
	"toggle_hud",
	"drop_in_accept",
	"drop_in_return",
	"drop_in_kick"
}
MenuCustomizeControllerCreator.AXIS_ORDERED = {
	move = {
		"up",
		"down",
		"left",
		"right"
	},
	drive = {
		"accelerate",
		"brake",
		"turn_left",
		"turn_right"
	}
}
MenuCustomizeControllerCreator.CONTROLS_INFO = {}
MenuCustomizeControllerCreator.CONTROLS_INFO.move = {hidden = true, category = "normal"}
MenuCustomizeControllerCreator.CONTROLS_INFO.up = {
	text_id = "menu_button_move_forward",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.down = {
	text_id = "menu_button_move_back",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.left = {
	text_id = "menu_button_move_left",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.right = {
	text_id = "menu_button_move_right",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.primary_attack = {
	text_id = "menu_button_fire_weapon",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.secondary_attack = {
	text_id = "menu_button_aim_down_sight",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.primary_choice1 = {
	text_id = "menu_button_weapon_slot1",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.primary_choice2 = {
	text_id = "menu_button_weapon_slot2",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.switch_weapon = {
	text_id = "menu_button_switch_weapon",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.reload = {
	text_id = "menu_button_reload",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.weapon_gadget = {
	text_id = "menu_button_weapon_gadget",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.run = {
	text_id = "menu_button_sprint",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.jump = {
	text_id = "menu_button_jump",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.duck = {
	text_id = "menu_button_crouch",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.melee = {
	text_id = "menu_button_melee",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.interact = {
	text_id = "menu_button_shout",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.interact_secondary = {
	text_id = "menu_button_shout_secondary",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.use_item = {
	text_id = "menu_button_deploy",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.toggle_chat = {
	text_id = "menu_button_chat_message",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.push_to_talk = {
	text_id = "menu_button_push_to_talk",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.continue = {
	text_id = "menu_button_continue",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.throw_grenade = {
	text_id = "menu_button_throwable",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.weapon_firemode = {
	text_id = "menu_button_weapon_firemode",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.cash_inspect = {
	text_id = "menu_button_cash_inspect",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.deploy_bipod = {
	text_id = "menu_button_deploy_bipod",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.change_equipment = {
	text_id = "menu_button_change_equipment",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.toggle_hud = {
	text_id = "menu_button_toggle_hud",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.drive = {hidden = true, category = "vehicle"}
MenuCustomizeControllerCreator.CONTROLS_INFO.accelerate = {
	text_id = "menu_button_accelerate",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.brake = {
	text_id = "menu_button_brake",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.turn_left = {
	text_id = "menu_button_turn_left",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.turn_right = {
	text_id = "menu_button_turn_right",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.hand_brake = {
	text_id = "menu_button_handbrake",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.vehicle_change_camera = {
	text_id = "menu_button_vehicle_change_camera",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.vehicle_rear_camera = {
	text_id = "menu_button_vehicle_rear_camera",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.vehicle_shooting_stance = {
	text_id = "menu_button_vehicle_shooting_stance",
	category = "vehicle",
	block = {"normal"}
}
MenuCustomizeControllerCreator.CONTROLS_INFO.vehicle_exit = {
	text_id = "menu_button_vehicle_exit",
	category = "vehicle"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.drop_in_accept = {
	text_id = "menu_button_drop_in_accept",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.drop_in_return = {
	text_id = "menu_button_drop_in_return",
	category = "normal"
}
MenuCustomizeControllerCreator.CONTROLS_INFO.drop_in_kick = {
	text_id = "menu_button_drop_in_kick",
	category = "normal"
}

function MenuCustomizeControllerCreator.controls_info_by_category(category)
	local t = {}
	for _, name in ipairs(MenuCustomizeControllerCreator.CONTROLS) do
		if MenuCustomizeControllerCreator.CONTROLS_INFO[name].category == category then
			table.insert(t, name)
		end
	end
	return t
end

function MenuCustomizeControllerCreator:modify_node(original_node, data)
	local node = original_node
	return self:setup_node(node)
end

function MenuCustomizeControllerCreator:refresh_node(node)
	self:setup_node(node)
	return node
end

function MenuCustomizeControllerCreator:setup_node(node)
	local new_node = node
	local controller_category = node:parameters().controller_category or "normal"
	node:clean_items()
	local params = {
		name = "controller_type",
		text_id = "menu_controller_type",
		callback = "choice_controller_type"
	}
	local data_node = {
		type = "MenuItemMultiChoice"
	}
	table.insert(data_node, {
		_meta = "option",
		text_id = "menu_controller_normal",
		value = "normal"
	})
	table.insert(data_node, {
		_meta = "option",
		text_id = "menu_controller_vehicle",
		value = "vehicle"
	})
	local new_item = node:create_item(data_node, params)
	new_item:set_value(controller_category)
	node:add_item(new_item)
	local connections = managers.controller:get_settings(managers.controller:get_default_wrapper_type()):get_connection_map()
	for _, name in ipairs(self.controls_info_by_category(controller_category)) do
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
		callback = "set_default_controller",
		category = controller_category
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
		node:item("toggle_ai"):set_value(Global.game_settings.team_ai and Global.game_settings.team_ai_option or 0)
	elseif data.smart_matchmaking then
	elseif not data.server then
		node:item("lobby_job_plan"):set_value(Global.game_settings.job_plan)
		node:item("lobby_kicking_option"):set_value(Global.game_settings.kick_option)
		node:item("lobby_permission"):set_value(Global.game_settings.permission)
		node:item("lobby_reputation_permission"):set_value(Global.game_settings.reputation_permission)
		node:item("lobby_drop_in_option"):set_value(Global.game_settings.drop_in_option)
		node:item("toggle_ai"):set_value(Global.game_settings.team_ai and Global.game_settings.team_ai_option or 0)
		node:item("toggle_auto_kick"):set_value(Global.game_settings.auto_kick and "on" or "off")
		if tweak_data.quickplay.stealth_levels[data.job_id] then
			local job_plan_item = node:item("lobby_job_plan")
			local stealth_option
			for _, option in ipairs(job_plan_item:options()) do
				if option:value() == 2 then
					stealth_option = option
					break
				end
			end
			job_plan_item:clear_options()
			job_plan_item:add_option(stealth_option)
		end
	end
	if data.customize_contract then
		node:set_default_item_name("buy_contract")
		local job_data = data
		if job_data and job_data.job_id then
			local buy_contract_item = node:item("buy_contract")
			if buy_contract_item then
				local can_afford = managers.money:can_afford_buy_premium_contract(job_data.job_id, job_data.difficulty_id or 3)
				buy_contract_item:parameters().text_id = can_afford and "menu_cn_premium_buy_accept" or "menu_cn_premium_cannot_buy"
				buy_contract_item:parameters().disabled_color = Color(1, 0.6, 0.2, 0.2)
				buy_contract_item:set_enabled(can_afford)
			end
		end
	end
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	node:parameters().menu_component_data = data
	return node
end

function MenuCallbackHandler:set_contact_info(item)
	local parameters = item:parameters() or {}
	local id = parameters.name
	local name_id = parameters.text_id
	local files = parameters.files
	local sub_text = parameters.sub_text
	local active_node_gui = managers.menu:active_menu().renderer:active_node_gui()
	if active_node_gui and active_node_gui.set_contact_info and active_node_gui:get_contact_info() ~= item:name() then
		active_node_gui:set_contact_info(id, name_id, files, 1, sub_text)
	end
	local logic = managers.menu:active_menu().logic
	if logic then
		logic:refresh_node()
	end
end

function MenuCallbackHandler:is_current_contact_info(item)
	local active_node_gui = managers.menu:active_menu().renderer:active_node_gui()
	if active_node_gui and active_node_gui.get_contact_info then
		return active_node_gui:get_contact_info() == item:name()
	end
	return false
end

MenuCrimeNetContactInfoInitiator = MenuCrimeNetContactInfoInitiator or class()
MenuCrimeNetContactInfoInitiator.TWEAK_DATA = tweak_data.gui.crime_net.codex
MenuCrimeNetContactInfoInitiator.COUNT_ITEMS = true
MenuCrimeNetContactInfoInitiator.ALLOW_IMAGES = false
MenuCrimeNetContactInfoInitiator.USE_SUBTEXT = false
MenuCrimeNetContactInfoInitiator.DEFAULT_ITEM = "bain"

function MenuCrimeNetContactInfoInitiator:modify_node(original_node, data)
	local node = original_node
	local codex_data = {}
	local contacts = {}
	for _, codex_d in ipairs(self.TWEAK_DATA) do
		local codex = {}
		local codex_string = managers.localization:to_upper_text(codex_d.name_id)
		codex.id = codex_d.id
		codex.name_localized = codex_string .. (self.COUNT_ITEMS and " (" .. tostring(#codex_d) .. ")" or "")
		for _, info_data in ipairs(codex_d) do
			local data = {}
			data.id = info_data.id
			data.name_localized = managers.localization:to_upper_text(info_data.name_id)
			data.files = {}
			data.sub_text = self.USE_SUBTEXT and codex_string or nil
			for page, file_data in ipairs(info_data) do
				local file = {}
				file.desc_localized = file_data.desc_id and managers.localization:text(file_data.desc_id) or ""
				file.post_event = file_data.post_event
				file.videos = file_data.videos and deep_clone(file_data.videos) or {}
				file.lock = file_data.lock
				file.icon = file_data.icon
				file.icon_rect = file_data.icon_rect
				if file_data.video then
					table.insert(file.videos, file_data.video)
				end
				if self.ALLOW_IMAGES then
					file.images = file_data.images and deep_clone(file_data.images) or {}
					if file_data.image then
						table.insert(file.images, file_data.image)
					end
				end
				table.insert(data.files, file)
			end
			table.insert(codex, data)
		end
		table.insert(codex_data, codex)
	end
	node:clean_items()
	for i, codex in ipairs(codex_data) do
		self:create_divider(node, codex.id, codex.name_localized, nil, tweak_data.screen_colors.text)
		for i, info_data in ipairs(codex) do
			self:create_item(node, info_data)
		end
		self:create_divider(node, i)
	end
	local params = {
		name = "back",
		text_id = "menu_back",
		previous_node = "true",
		visible_callback = "is_pc_controller",
		align = "left",
		last_item = "true",
		gui_node_custom = "true",
		pd2_corner = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:set_default_item_name(self.DEFAULT_ITEM)
	node:select_item(self.DEFAULT_ITEM)
	return node
end

function MenuCrimeNetContactInfoInitiator:refresh_node(node)
	return node
end

function MenuCrimeNetContactInfoInitiator:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		localize = "false",
		size = size or 8,
		color = color
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function MenuCrimeNetContactInfoInitiator:create_item(node, contact)
	local text_id = contact.name_localized
	local sub_text = contact.sub_text
	local files = contact.files
	local video_id = contact.video
	local color_ranges
	local params = {
		name = contact.id,
		text_id = text_id,
		color_ranges = color_ranges,
		localize = "false",
		callback = "set_contact_info",
		files = files,
		sub_text = sub_text,
		icon = contact.icon or "guis/textures/scrollarrow",
		icon_rotation = contact.icon_rotation or 270,
		icon_visible_callback = contact.icon_visible_callback or "is_current_contact_info",
		hightlight_color = contact.hightlight_color,
		row_item_color = contact.row_item_color,
		disabled_color = contact.disabled_color,
		marker_color = contact.marker_color
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

MenuCrimeNetContactShortInitiator = MenuCrimeNetContactShortInitiator or class()

function MenuCrimeNetContactShortInitiator:modify_node(original_node, data)
	local node = original_node
	node:clean_items()
	for _, job_data in ipairs(tweak_data.narrative.tutorials) do
		local heist_tweak = tweak_data.narrative.jobs[job_data.job]
		local info_data = {}
		info_data.id = job_data.job
		info_data.text = managers.localization:to_upper_text(heist_tweak.name_id)
		info_data.enabled = true
		if job_data.complete_job then
			local completed = managers.statistics:sessions_jobs()
			info_data.enabled = completed and completed[job_data.complete_job .. "_normal_completed"]
		end
		self:create_item(node, info_data)
	end
	local params = {
		name = "back",
		text_id = "menu_back",
		previous_node = "true",
		visible_callback = "is_pc_controller",
		align = "left",
		last_item = "true",
		gui_node_custom = "true",
		pd2_corner = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:set_default_item_name(self.DEFAULT_ITEM)
	node:select_item(self.DEFAULT_ITEM)
	return node
end

function MenuCrimeNetContactShortInitiator:refresh_node(node)
	return node
end

function MenuCrimeNetContactShortInitiator:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		localize = "false",
		size = size or 8,
		color = color
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function MenuCrimeNetContactShortInitiator:create_item(node, data)
	local params = {
		name = data.id,
		text_id = data.text,
		localize = "false",
		callback = "play_short_heist",
		job = data.id
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(data.enabled)
	node:add_item(new_item)
end

function MenuCallbackHandler:play_chill_combat(item)
	if managers.job:has_active_job() then
		self:_dialog_leave_lobby_yes()
	end
	item:parameters().gui_node:remove_blur()
	local job_data = {
		job_id = "chill_combat",
		difficulty = item:parameters().gui_node:get_difficulty()
	}
	if Global.game_settings.single_player then
		MenuCallbackHandler:start_single_player_job(job_data)
	else
		MenuCallbackHandler:start_job(job_data)
	end
end

function MenuCallbackHandler:ignore_chill_combat(item)
	item:parameters().gui_node:remove_blur()
	managers.custom_safehouse:ignore_raid()
	managers.menu:back()
end

function MenuCallbackHandler:_on_chill_change_difficulty(item)
	item:parameters().gui_node:set_difficulty(item._options[item._current_index]:value())
end

MenuCrimeNetContactChillInitiator = MenuCrimeNetContactChillInitiator or class()

function MenuCrimeNetContactChillInitiator:modify_node(original_node, data)
	local node = original_node
	node:clean_items()
	local params = {
		name = "difficulty",
		text_id = "menu_lobby_difficulty_title",
		help_id = "menu_diff_help",
		callback = "_on_chill_change_difficulty",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_difficulty_normal",
			value = "normal"
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_hard",
			value = "hard"
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_very_hard",
			value = "overkill"
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_overkill",
			value = "overkill_145"
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_easy_wish",
			value = "easy_wish"
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_apocalypse",
			value = "overkill_290"
		},
		{
			_meta = "option",
			text_id = "menu_difficulty_sm_wish",
			value = "sm_wish"
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(true)
	node:add_item(new_item)
	params = {
		name = "CustomSafeHouseDefendBtn",
		text_id = "menu_cn_chill_combat_defend",
		callback = "play_chill_combat",
		align = "left"
	}
	data_node = {}
	new_item = node:create_item(data_node, params)
	new_item:set_enabled(true)
	node:add_item(new_item)
	params = {
		name = "CustomSafeHouseIgnoreBtn",
		text_id = "menu_cn_chill_combat_ignore_defend",
		callback = "ignore_chill_combat",
		align = "left"
	}
	data_node = {}
	new_item = node:create_item(data_node, params)
	new_item:set_enabled(true)
	node:add_item(new_item)
	params = {
		name = "back",
		text_id = "menu_back",
		previous_node = "true",
		visible_callback = "is_pc_controller",
		align = "left",
		last_item = "true"
	}
	data_node = {}
	new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:set_default_item_name(self.DEFAULT_ITEM)
	node:select_item(self.DEFAULT_ITEM)
	return node
end

function MenuCrimeNetContactChillInitiator:refresh_node(node)
	return node
end

function MenuCrimeNetContactChillInitiator:create_divider(node, id, text_id, size, color)
end

function MenuCrimeNetContactChillInitiator:create_item(node, data)
end

MenuJukeboxInitiator = MenuJukeboxInitiator or class()

function MenuJukeboxInitiator:modify_node(node, data)
	if not node:item("choose_jukebox_your_choice") then
		local track_list, track_locked = managers.music:jukebox_music_tracks()
		local option_data = {
			type = "MenuItemMultiChoiceWithIcon"
		}
		for _, track_name in ipairs(track_list) do
			if not track_locked[track_name] then
				table.insert(option_data, {
					_meta = "option",
					text_id = "menu_jukebox_" .. track_name,
					value = track_name
				})
			end
		end
		local params = {
			name = "choose_jukebox_your_choice",
			text_id = "",
			callback = "jukebox_track_selection",
			icon = tweak_data.hud_icons:get_icon_data("jukebox_playing_icon")
		}
		local item = node:create_item(option_data, params)
		item:set_enabled(false)
		node:add_item(item)
	end
	local track_name = managers.localization:text("menu_jukebox_playlist_heist")
	local job_data = Global.job_manager.current_job
	if job_data then
		local track = managers.music:jukebox_heist_specific()
		if track == "all" then
			track_name = track_name .. " (" .. managers.localization:text("menu_jukebox_playlist_all") .. ")"
		elseif track == "playlist" then
			track_name = track_name .. " (" .. managers.localization:text("menu_jukebox_random_heist_playlist") .. ")"
		else
			track_name = track_name .. " (" .. managers.localization:text("menu_jukebox_" .. track) .. ")"
		end
	end
	node:item("toggle_jukebox_playlist_heist"):set_parameter("localize", "false")
	node:item("toggle_jukebox_playlist_heist"):set_parameter("text_id", track_name)
	if Network:is_server() then
		if Global.music_manager.loadout_selection == "server" then
			Global.music_manager.loadout_selection = nil
		end
		node:item("toggle_jukebox_server_choice"):set_enabled(false)
	end
	if not Global.music_manager.loadout_selection then
		node:item("toggle_jukebox_playlist_all"):set_value("on")
	elseif Global.music_manager.loadout_selection == "global" then
		node:item("toggle_jukebox_playlist_global"):set_value("on")
	elseif Global.music_manager.loadout_selection == "heist" then
		node:item("toggle_jukebox_playlist_heist"):set_value("on")
	elseif Global.music_manager.loadout_selection == "server" then
		node:item("toggle_jukebox_server_choice"):set_value("on")
	else
		node:item("toggle_jukebox_your_choice"):set_value("on")
		local selection = node:item("choose_jukebox_your_choice")
		selection:set_enabled(true)
		selection:set_value(Global.music_manager.loadout_selection)
	end
	return node
end

MenuJukeboxHeistPlaylist = MenuJukeboxHeistPlaylist or class()

function MenuJukeboxHeistPlaylist:modify_node(node, data)
	managers.menu_component:show_contract_character(false)
	node:clean_items()
	local data = {
		type = "MenuItemToggleWithIcon",
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
	local item
	local track_list, track_locked = managers.music:jukebox_music_tracks()
	for _, track_name in pairs(track_list) do
		local locked = track_locked[track_name]
		local params = {
			name = track_name,
			text_id = "menu_jukebox_" .. track_name,
			help_id = locked and "menu_jukebox_locked_" .. locked,
			disabled_color = tweak_data.screen_colors.important_1,
			callback = "jukebox_option_heist_playlist",
			icon = tweak_data.hud_icons:get_icon_data("jukebox_playing_icon")
		}
		item = node:create_item(data, params)
		if locked then
			item:set_value("off")
			item:set_enabled(false)
		else
			item:set_value(managers.music:playlist_contains(track_name) and "on" or "off")
		end
		node:add_item(item)
	end
	managers.menu:add_back_button(node)
	return node
end

MenuJukeboxHeistTracks = MenuJukeboxHeistTracks or class()

function MenuJukeboxHeistTracks:modify_node(node, data)
	managers.menu_component:show_contract_character(false)
	node:clean_items()
	local track_list, track_locked = managers.music:jukebox_music_tracks()
	local option_data = {
		type = "MenuItemMultiChoiceWithIcon"
	}
	table.insert(option_data, {
		_meta = "option",
		text_id = "menu_jukebox_playlist_all",
		value = "all"
	})
	table.insert(option_data, {
		_meta = "option",
		text_id = "menu_jukebox_random_heist_playlist",
		value = "playlist"
	})
	for _, track_name in pairs(track_list) do
		if not track_locked[track_name] then
			table.insert(option_data, {
				_meta = "option",
				text_id = "menu_jukebox_" .. track_name,
				value = track_name
			})
		end
	end
	local track_list = {}
	local unique_jobs = {}
	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local job_tweak = tweak_data.narrative:job_data(job_id)
		if self:_have_music(job_id) and not table.contains(unique_jobs, job_tweak.name_id) then
			local text_id, color_ranges = tweak_data.narrative:create_job_name(job_id, true)
			local days = #tweak_data.narrative:job_chain(job_id)
			table.insert(unique_jobs, job_tweak.name_id)
			if 1 < days then
				for i = 1, days do
					table.insert(track_list, {
						job_id = job_id,
						name_id = job_tweak.name_id,
						day = i,
						sort_id = text_id,
						text_id = text_id .. " - " .. managers.localization:text("menu_jukebox_heist_day", {day = i}),
						color_ranges = color_ranges
					})
				end
			else
				table.insert(track_list, {
					job_id = job_id,
					name_id = job_tweak.name_id,
					sort_id = text_id,
					text_id = text_id,
					color_ranges = color_ranges
				})
			end
		end
	end
	table.sort(track_list, function(x, y)
		return x.sort_id == y.sort_id and x.text_id < y.text_id or x.sort_id < y.sort_id
	end)
	table.insert(track_list, {
		job_id = "escape",
		name_id = "escape",
		text_id = managers.localization:text("menu_jukebox_heist_escape")
	})
	for _, track_data in pairs(track_list) do
		local heist_name = track_data.name_id .. (track_data.day and track_data.day or "")
		local params = {
			name = heist_name,
			text_id = track_data.text_id,
			localize = "false",
			color_ranges = track_data.color_ranges,
			align = "left",
			callback = "jukebox_option_heist_tracks",
			text_offset = 100,
			heist_job = track_data.job_id,
			heist_days = track_data.day,
			icon = tweak_data.hud_icons:get_icon_data("jukebox_playing_icon")
		}
		local item = node:create_item(option_data, params)
		item:set_value(managers.music:track_attachment(heist_name) or "all")
		node:add_item(item)
	end
	managers.menu:add_back_button(node)
	return node
end

function MenuJukeboxHeistTracks:_have_music(job_id)
	local job_tweak = tweak_data.narrative.jobs[job_id]
	if not job_tweak or job_tweak.contact == "tests" or job_tweak.wrapped_to_job then
		return false
	end
	if job_tweak.job_wrapper then
		for _, wrapped_job in ipairs(job_tweak.job_wrapper) do
			for _, level_data in ipairs(tweak_data.narrative.jobs[wrapped_job].chain) do
				if tweak_data.levels[level_data.level_id].music ~= "no_music" then
					return true
				end
			end
		end
	else
		for _, level_data in ipairs(job_tweak.chain) do
			if tweak_data.levels[level_data.level_id].music ~= "no_music" then
				return true
			end
		end
	end
	return false
end

MenuJukeboxMenuPlaylist = MenuJukeboxMenuPlaylist or class()

function MenuJukeboxMenuPlaylist:modify_node(node, data)
	managers.menu_component:show_contract_character(false)
	node:clean_items()
	local data = {
		type = "MenuItemToggleWithIcon",
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
	local item
	local track_list, track_locked = managers.music:jukebox_menu_tracks()
	for _, track_name in pairs(track_list) do
		local locked = track_locked[track_name]
		local params = {
			name = track_name,
			text_id = "menu_jukebox_screen_" .. track_name,
			help_id = locked and "menu_jukebox_locked_" .. locked,
			disabled_color = tweak_data.screen_colors.important_1,
			callback = "jukebox_option_menu_playlist",
			icon = tweak_data.hud_icons:get_icon_data("jukebox_playing_icon")
		}
		item = node:create_item(data, params)
		if locked then
			item:set_value("off")
			item:set_enabled(false)
		else
			item:set_value(managers.music:playlist_menu_contains(track_name) and "on" or "off")
		end
		node:add_item(item)
	end
	managers.menu:add_back_button(node)
	return node
end

MenuJukeboxMenuTracks = MenuJukeboxMenuTracks or class()

function MenuJukeboxMenuTracks:modify_node(node, data)
	managers.menu_component:show_contract_character(false)
	node:clean_items()
	local track_list, track_locked = managers.music:jukebox_menu_tracks()
	local option_data = {
		type = "MenuItemMultiChoiceWithIcon"
	}
	table.insert(option_data, {
		_meta = "option",
		text_id = "menu_jukebox_playlist_all",
		value = "all"
	})
	table.insert(option_data, {
		_meta = "option",
		text_id = "menu_jukebox_random_menu_playlist",
		value = "playlist"
	})
	for _, track_name in pairs(track_list) do
		if not track_locked[track_name] then
			table.insert(option_data, {
				_meta = "option",
				text_id = "menu_jukebox_screen_" .. track_name,
				value = track_name
			})
		end
	end
	local menu_options = {
		"mainmenu",
		"loadout",
		"heistresult",
		"heistlost",
		"heistfinish",
		"credits"
	}
	for _, track_name in pairs(menu_options) do
		local params = {
			name = track_name,
			text_id = "menu_jukebox_screen_" .. track_name,
			align = "left",
			callback = "jukebox_option_menu_tracks",
			text_offset = 100,
			icon = tweak_data.hud_icons:get_icon_data("jukebox_playing_icon")
		}
		local item = node:create_item(option_data, params)
		item:set_value(managers.music:track_attachment(track_name))
		node:add_item(item)
	end
	managers.menu:add_back_button(node)
	return node
end

MenuPrePlanningInitiator = MenuPrePlanningInitiator or class(MenuCrimeNetContactInfoInitiator)

function MenuPrePlanningInitiator:modify_node(node, item_name, selected_item)
	node:clean_items()
	local name = node:parameters().name
	local func_name = "modifiy_node_" .. tostring(name)
	if self[func_name] then
		node, selected_item = self[func_name](self, node, item_name, selected_item)
	end
	if selected_item then
		node:set_default_item_name(selected_item)
		node:select_item(selected_item)
	end
	return node
end

function MenuPrePlanningInitiator:create_info_items(node, params, selected_item)
	self:create_divider(node, "info_div", nil, nil, nil)
	params.enabled = true
	self:create_divider(node, "cat_info", managers.localization:text("menu_pp_sub_info"), nil, tweak_data.screen_colors.text)
	if managers.preplanning:has_current_custom_points() then
		params.name = "custom_points"
		params.callback = "open_preplanning_custom_item"
		params.text_id = managers.localization:text("menu_pp_extra_info")
		params.tooltip.texture = tweak_data.preplanning.gui.custom_icons_path
		params.tooltip.texture_rect = tweak_data.preplanning:get_custom_texture_rect(45)
		params.tooltip.name = params.text_id
		params.tooltip.desc = managers.localization:text("menu_pp_extra_info_desc")
		params.tooltip.errors = {}
		self:create_item(node, params)
	end
	params.name = "preplanning_help"
	params.callback = "open_preplanning_help"
	params.text_id = managers.localization:text("menu_item_preplanning_help")
	params.tooltip = {}
	params.tooltip.texture = tweak_data.preplanning.gui.custom_icons_path
	params.tooltip.texture_rect = tweak_data.preplanning:get_custom_texture_rect(45)
	params.tooltip.name = params.text_id
	params.tooltip.desc = managers.localization:text("menu_item_preplanning_help_desc")
	self:create_item(node, params)
	return node, selected_item
end

function MenuPrePlanningInitiator:modifiy_node_view_only(node, item_name, selected_item)
	local subgroups = managers.preplanning:get_mission_element_subgroups()
	if not subgroups then
		return node, nil
	end
	node:parameters().current_viewing = true
	local params = {
		name = nil,
		text_id = nil,
		color_ranges = nil,
		localize = "false",
		callback = nil,
		tooltip = {
			texture = tweak_data.preplanning.gui.type_icons_path
		}
	}
	local finished_preplan = managers.preplanning:get_finished_preplan()
	local type_data, location_data, data
	for i = 1, #tweak_data.preplanning.location_groups do
		data = finished_preplan[i]
		if data then
			self:create_divider(node, "sub_" .. tostring(i), managers.localization:text(data.name_id), nil, tweak_data.screen_colors.text)
			for index = 1, #tweak_data.preplanning.location_groups do
				if data[index] then
					location_data = data[index]
					for id, type in pairs(location_data) do
						type_data = tweak_data:get_raw_value("preplanning", "types", type) or {}
						params.name = id
						params.text_id = managers.preplanning:get_type_name(type)
						params.tooltip.texture_rect = tweak_data.preplanning:get_type_texture_rect(type_data.icon)
						params.tooltip.name = params.text_id
						params.tooltip.desc = managers.preplanning:get_type_desc(type)
						self:create_item(node, params)
						selected_item = selected_item or params.name
					end
				end
			end
		end
	end
	self:create_info_items(node, params, selected_item)
	return node, selected_item
end

function MenuPrePlanningInitiator:set_locks_to_param(params, key, index)
	local data = tweak_data:get_raw_value("preplanning", key, index) or {}
	local enabled = params.enabled ~= false
	params.tooltip = params.tooltip or {}
	params.tooltip.errors = params.tooltip.errors or {}
	if data.dlc_lock then
		local dlc_unlocked = managers.dlc:is_dlc_unlocked(data.dlc_lock)
		if not dlc_unlocked then
			local error_text_id = tweak_data:get_raw_value("lootdrop", "global_values", data.dlc_lock, "unlock_id")
			table.insert(params.tooltip.errors, managers.localization:to_upper_text(error_text_id))
			enabled = false
		end
	elseif data.upgrade_lock then
		local upgrade_unlocked = managers.player:has_category_upgrade(data.upgrade_lock.category, data.upgrade_lock.upgrade)
		if not upgrade_unlocked then
			table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_asset_lock_" .. data.upgrade_lock.upgrade))
			enabled = false
		end
	end
	params.enabled = enabled
	params.ignore_disabled = true
end

function MenuPrePlanningInitiator:modifiy_node_preplanning(node, item_name, selected_item)
	if not managers.preplanning:can_edit_preplan() then
		return self:modifiy_node_view_only(node, item_name, selected_item)
	end
	local subgroups = managers.preplanning:get_mission_element_subgroups()
	if not subgroups then
		return node, nil
	end
	local params = {
		name = nil,
		text_id = nil,
		color_ranges = nil,
		localize = "false",
		callback = nil,
		tooltip = {
			texture = tweak_data.preplanning.gui.type_icons_path
		}
	}
	local type_data, first_type, category_data
	for i, data in ipairs(subgroups) do
		if #data.subgroup > 0 then
			self:create_divider(node, "cat_" .. tostring(i), managers.localization:text(data.name_id), nil, tweak_data.screen_colors.text)
			params.callback = data.callback
			for index, category in ipairs(data.subgroup) do
				first_type = managers.preplanning:get_first_type_in_category(category)
				type_data = tweak_data:get_raw_value("preplanning", "types", first_type) or {}
				params.name = category
				params.text_id = managers.preplanning:get_category_name(category)
				params.tooltip.texture_rect = tweak_data.preplanning:get_type_texture_rect(type_data.icon)
				params.tooltip.name = params.text_id
				params.tooltip.desc = managers.preplanning:get_category_desc(category)
				params.tooltip.errors = {}
				params.enabled = true
				self:set_locks_to_param(params, "categories", category)
				self:create_item(node, params)
				selected_item = selected_item or params.name
			end
			if i ~= #subgroups then
				self:create_divider(node, "end_" .. tostring(i), nil, nil, nil)
			end
		end
	end
	self:create_info_items(node, params, selected_item)
	return node, selected_item
end

function MenuPrePlanningInitiator:modifiy_node_preplanning_category(node, item_name, selected_item)
	node:parameters().current_category = item_name or node:parameters().current_category
	local current_category = node:parameters().current_category
	if not current_category then
		return node, nil
	end
	self:create_divider(node, 1, managers.preplanning:get_category_name(current_category), nil, tweak_data.screen_colors.text)
	local types = managers.preplanning:types_with_mission_elements(current_category)
	if not types or #types == 0 then
		return node, nil
	end
	local category_data = tweak_data:get_raw_value("preplanning", "categories", current_category) or {}
	local params = {
		name = nil,
		text_id = nil,
		color_ranges = nil,
		localize = "false",
		callback = "open_preplanning_type_item",
		tooltip = {
			texture = tweak_data.preplanning.gui.type_icons_path
		},
		enabled = true
	}
	local type_data, can_place, error_num, enabled
	local peer_id = managers.network:session():local_peer():id()
	for i, type in ipairs(types) do
		type_data = tweak_data:get_raw_value("preplanning", "types", type) or {}
		params.name = type
		params.text_id = managers.preplanning:get_type_name(type)
		params.tooltip.texture_rect = tweak_data.preplanning:get_type_texture_rect(type_data.icon)
		params.tooltip.name = params.text_id
		params.tooltip.desc = managers.preplanning:get_type_desc(type)
		params.tooltip.errors = {}
		enabled = true
		can_place, error_num = managers.preplanning:can_reserve_mission_element(type, peer_id)
		if not can_place then
			enabled = false
			if error_num == 1 then
				table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_not_enough_money"))
			elseif error_num == 2 then
				table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_not_enough_budget"))
			elseif error_num == 3 then
				table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_type_disabled"))
			elseif error_num == 4 then
				table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_cap_reached"))
			else
				table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_unknown"))
			end
		end
		params.enabled = enabled
		self:set_locks_to_param(params, "types", type)
		self:create_item(node, params)
		selected_item = selected_item or params.name
	end
	return node, selected_item
end

function MenuPrePlanningInitiator:modifiy_node_preplanning_type(node, item_name, selected_item)
	node:parameters().current_type = item_name or node:parameters().current_type
	local current_type = node:parameters().current_type
	if not current_type then
		return node, nil
	end
	local params = {
		name = nil,
		text_id = nil,
		color_ranges = nil,
		localize = "false",
		callback = "reserve_preplanning_mission_element_by_item",
		tooltip = nil
	}
	local mission_elements = managers.preplanning:get_mission_elements_by_type(current_type)
	local locations = managers.preplanning:sort_mission_elements_into_locations(mission_elements)
	self:create_divider(node, 1, managers.preplanning:get_type_name(current_type), nil, tweak_data.screen_colors.text)
	local peer_id = managers.network:session():local_peer():id()
	local can_place, error_num = managers.preplanning:can_reserve_mission_element(current_type, peer_id)
	local reserved, reserved_type, type_data, enabled, dlc_lock, upgrade_lock, last_location_index
	for index = 1, #tweak_data.preplanning.location_groups do
		if locations[index] then
			last_location_index = index
		end
	end
	last_location_index = last_location_index or 1
	for index = 1, #tweak_data.preplanning.location_groups do
		local elements = locations[index]
		if elements then
			self:create_divider(node, "div_" .. tostring(index), managers.preplanning:get_location_name_by_index(index), nil, tweak_data.screen_colors.text)
			for i, data in ipairs(elements) do
				params.name = data.element:id()
				params.text_id = managers.preplanning:get_element_name(data.element)
				params.index = data.index
				type_data = tweak_data:get_raw_value("preplanning", "types", current_type) or {}
				params.tooltip = {}
				params.tooltip.name = managers.localization:text("menu_pp_reserve_type", {
					type = managers.preplanning:get_type_name(current_type)
				})
				params.tooltip.desc = managers.preplanning:get_type_desc(current_type)
				params.tooltip.texture = tweak_data.preplanning.gui.type_icons_path
				params.tooltip.texture_rect = tweak_data.preplanning:get_type_texture_rect(type_data.icon)
				params.tooltip.errors = {}
				dlc_lock = data.element:value("dlc_lock")
				upgrade_lock = data.element:value("upgrade_lock")
				enabled = true
				if dlc_lock and dlc_lock ~= "none" then
					local dlc_unlocked = managers.dlc:is_dlc_unlocked(dlc_lock)
					if not dlc_unlocked then
						local error_text_id = tweak_data:get_raw_value("lootdrop", "global_values", type_data.dlc_lock, "unlock_id")
						table.insert(params.tooltip.errors, managers.localization:to_upper_text(error_text_id))
						enabled = false
					end
				elseif upgrade_lock and upgrade_lock ~= "none" then
					local upgrade_unlocked = managers.player:has_category_upgrade("player", upgrade_lock)
					if not upgrade_unlocked then
						table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_asset_lock_" .. upgrade_lock))
						enabled = false
					end
				end
				reserved = managers.preplanning:get_reserved_mission_element(data.element:id())
				if not reserved and enabled and not can_place then
					enabled = false
					if error_num == 1 then
						table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_not_enough_money"))
						params.flash_money = true
					elseif error_num == 2 then
						table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_not_enough_budget"))
						params.flash_budget = true
					elseif error_num == 3 then
						table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_type_disabled"))
					elseif error_num == 4 then
						table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_cap_reached"))
					else
						table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_unknown"))
					end
				end
				params.enabled = enabled
				self:set_locks_to_param(params, "types", current_type)
				if reserved then
					reserved_type = reserved.pack[1]
					type_data = tweak_data:get_raw_value("preplanning", "types", reserved_type) or {}
					params.enabled = true
					params.tooltip.texture = tweak_data.preplanning.gui.type_icons_path
					params.tooltip.texture_rect = tweak_data.preplanning:get_type_texture_rect(type_data.icon)
					params.tooltip.menu_color = tweak_data.chat_colors[reserved.peer_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
					if enabled and (reserved.peer_id == peer_id or Network:is_server() and managers.preplanning.server_master_planner) then
						params.tooltip.name = managers.localization:text("menu_pp_unreserve_type", {
							type = managers.preplanning:get_type_name(reserved_type)
						})
					else
						params.tooltip.name = managers.preplanning:get_type_name(reserved_type)
						params.enabled = false
					end
					params.tooltip.desc = managers.preplanning:get_type_desc(reserved_type)
					params.tooltip.errors = {}
					params.callback = "unreserve_preplanning_mission_element_by_item"
				else
					if not enabled then
						params.tooltip.name = managers.preplanning:get_type_name(current_type)
					end
					params.callback = "reserve_preplanning_mission_element_by_item"
				end
				self:create_item(node, params)
				selected_item = selected_item or params.name
			end
			if index ~= last_location_index then
				self:create_divider(node, "end_" .. tostring(index), nil, nil, nil)
			end
		end
	end
	return node, selected_item
end

function MenuPrePlanningInitiator:modifiy_node_preplanning_plan(node, item_name, selected_item)
	node:parameters().current_plan = item_name or node:parameters().current_plan
	local current_plan = node:parameters().current_plan
	if not current_plan then
		return node, nil
	end
	node:parameters().current_category = node:parameters().current_plan
	self:create_divider(node, 1, managers.preplanning:get_category_name(current_plan), nil, tweak_data.screen_colors.text)
	local types = managers.preplanning:types_with_mission_elements(current_plan)
	if not types or #types == 0 then
		return node
	end
	local category_data = tweak_data.preplanning.categories[current_plan]
	local params = {
		name = nil,
		text_id = nil,
		color_ranges = nil,
		localize = "false",
		callback = "vote_preplanning_mission_element_by_item",
		tooltip = {
			texture = tweak_data.preplanning.gui.type_icons_path
		},
		enabled = false,
		votes = nil
	}
	local type_data
	for _, type in pairs(types) do
		type_data = tweak_data:get_raw_value("preplanning", "types", type) or {}
		local enabled = true
		params.post_event = type_data.post_event
		params.tooltip.errors = {}
		if not managers.preplanning:can_vote_on_plan(type) then
			table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_pp_err_not_enough_budget"))
			params.flash_budget = true
			enabled = false
		elseif type_data.dlc_lock then
			local dlc_unlocked = managers.dlc:is_dlc_unlocked(type_data.dlc_lock)
			if not dlc_unlocked then
				local error_text_id = tweak_data:get_raw_value("lootdrop", "global_values", type_data.dlc_lock, "unlock_id")
				table.insert(params.tooltip.errors, managers.localization:to_upper_text(error_text_id))
				enabled = false
			end
		elseif type_data.upgrade_lock then
			local upgrade_unlocked = managers.player:has_category_upgrade(type_data.upgrade_lock.category, type_data.upgrade_lock.upgrade) and enabled or false
			if not upgrade_unlocked then
				table.insert(params.tooltip.errors, managers.localization:to_upper_text("menu_asset_lock_" .. type_data.upgrade_lock.upgrade))
				enabled = false
			end
		elseif not managers.money:can_afford_preplanning_type(type) then
		end
		params.enabled = enabled
		local mission_elements = managers.preplanning:get_mission_elements_by_type(type)
		for index, element in ipairs(mission_elements) do
			params.name = element:id()
			params.text_id = managers.preplanning:get_type_name(type)
			if 1 < #mission_elements then
				params.text_id = params.text_id .. " - " .. managers.preplanning:get_element_name(element)
			end
			params.index = index
			params.type = type
			params.tooltip.texture_rect = tweak_data.preplanning:get_type_texture_rect(type_data.icon)
			params.tooltip.name = params.text_id
			params.tooltip.desc = managers.preplanning:get_type_desc(type)
			params.votes = managers.preplanning:get_votes_on_element(category_data.plan, type, index)
			self:create_item(node, params)
			selected_item = selected_item or params.name
		end
	end
	return node, selected_item
end

function MenuPrePlanningInitiator:modifiy_node_preplanning_custom(node, item_name, selected_item)
	node:parameters().current_custom = item_name or node:parameters().current_custom
	local current_custom = node:parameters().current_custom
	if not current_custom then
		return node, nil
	end
	node:parameters().current_category = node:parameters().current_custom
	self:create_divider(node, 1, managers.localization:text("menu_pp_extra_info"), nil, tweak_data.screen_colors.text)
	local params = {
		name = "test",
		text_id = "TEST",
		color_ranges = nil,
		localize = "false",
		callback = "pressed_preplanning_custom_point"
	}
	local current_custom_points = managers.preplanning:get_current_custom_points()
	local last_custom_point_index
	for index = 1, #tweak_data.preplanning.location_groups do
		if current_custom_points[index] then
			last_custom_point_index = index
		end
	end
	last_custom_point_index = last_custom_point_index or 1
	for index = 1, #tweak_data.preplanning.location_groups do
		local custom_points = current_custom_points[index]
		if custom_points then
			self:create_divider(node, "div_" .. tostring(index), managers.preplanning:get_location_name_by_index(index), nil, tweak_data.screen_colors.text)
			for i, custom_point in pairs(custom_points) do
				params.name = tostring(index) .. "_" .. tostring(i)
				params.text_id = custom_point.text_id and managers.localization:text(custom_point.text_id) or " "
				params.post_event = custom_point.post_event
				self:create_item(node, params)
				selected_item = selected_item or params.name
			end
			if index ~= last_custom_point_index then
				self:create_divider(node, "end_" .. tostring(index), nil, nil, nil)
			end
		end
	end
	return node, selected_item
end

function MenuPrePlanningInitiator:refresh_node(node)
	local selected_item_name = node:selected_item() and node:selected_item():name()
	return self:modify_node(node, nil, selected_item_name)
end

function MenuPrePlanningInitiator:create_item(node, params)
	local data_node = {}
	local new_item = node:create_item(data_node, deep_clone(params))
	new_item:set_enabled(params.enabled == nil or not not params.enabled)
	node:add_item(new_item)
	return new_item
end

function MenuCallbackHandler:open_preplanning_plan_item(item)
	managers.menu:open_node("preplanning_plan", {
		item:name()
	})
end

function MenuCallbackHandler:open_preplanning_category_item(item)
	managers.menu:open_node("preplanning_category", {
		item:name()
	})
end

function MenuCallbackHandler:open_preplanning_custom_item(item)
	managers.menu:open_node("preplanning_custom", {
		item:name()
	})
end

function MenuCallbackHandler:open_preplanning_type_item(item)
	managers.menu:open_node("preplanning_type", {
		item:name()
	})
end

function MenuCallbackHandler:open_preplanning_to_type(category, type, item_name)
	local logic = managers.menu:active_menu() and managers.menu:active_menu().logic
	local node_name = logic and logic:selected_node() and logic:selected_node():parameters().name
	local in_main = false
	if node_name == "preplanning" then
		in_main = true
	elseif node_name == "preplanning_category" then
		if logic:selected_node():parameters().current_category ~= category then
			managers.menu:back(false)
			in_main = true
		end
	elseif node_name == "preplanning_type" then
		if logic:selected_node():parameters().current_type ~= type then
			local current_category = tweak_data:get_raw_value("preplanning", "types", logic:selected_node():parameters().current_type, "category")
			if current_category ~= category then
				managers.menu:back(false)
				in_main = true
			end
			managers.menu:back(false)
		end
	elseif node_name == "preplanning_plan" then
		managers.menu:back(false)
		in_main = true
	elseif node_name == "preplanning_custom" then
		managers.menu:back(false)
		in_main = true
	end
	if in_main then
		managers.menu:open_node("preplanning_category", {category, false})
	end
	managers.menu:open_node("preplanning_type", {type, item_name})
end

function MenuCallbackHandler:open_preplanning_to_plan(plan, item_name)
	local logic = managers.menu:active_menu() and managers.menu:active_menu().logic
	local node_name = logic and logic:selected_node() and logic:selected_node():parameters().name
	if node_name == "preplanning" then
	elseif node_name == "preplanning_category" then
		managers.menu:back(false)
	elseif node_name == "preplanning_type" then
		managers.menu:back(false)
		managers.menu:back(false)
	elseif node_name == "preplanning_plan" then
		if logic:selected_node():parameters().current_plan ~= plan then
			managers.menu:back(false)
		end
	elseif node_name == "preplanning_custom" then
		managers.menu:back(false)
	end
	print(plan, item_name)
	managers.menu:open_node("preplanning_plan", {plan, item_name})
end

function MenuCallbackHandler:stop_preplanning_post_event()
	managers.menu_component:preplanning_stop_event()
end

function MenuCallbackHandler:pressed_preplanning_custom_point(item)
	if item:parameters().post_event then
		managers.menu_component:preplanning_post_event(item:parameters().post_event, item:name())
		managers.menu_component:preplanning_start_custom_talk(item:name())
	end
end

function MenuCallbackHandler:set_preplanning_custom_filter(item)
	if item and item:enabled() then
		print("AAAAAAAAAAAAA ", item:name())
	end
end

function MenuCallbackHandler:set_preplanning_category_filter(item)
	if item and item:enabled() then
		managers.menu_component:set_preplanning_category_filter(item:name())
		managers.menu:open_node("preplanning_category", {
			item:name(),
			false
		})
	end
end

function MenuCallbackHandler:set_preplanning_type_filter(item)
	if item and item:enabled() then
		managers.menu_component:set_preplanning_type_filter(item:name())
		managers.menu:open_node("preplanning_type", {
			false,
			item:name()
		})
	end
end

function MenuCallbackHandler:vote_preplanning_mission_element_by_item(item)
	if item then
		if item:enabled() then
			managers.preplanning:vote_on_plan(item:parameters().type, item:name())
			local post_event = tweak_data:get_raw_value("preplanning", "types", item:parameters().type, "post_event")
			if post_event then
				managers.menu_component:preplanning_post_event(post_event)
			else
				managers.menu_component:preplanning_stop_event()
			end
		else
			managers.menu_component:preplanning_flash_error(item:name(), item:parameters().flash_budget, item:parameters().flash_money)
		end
	end
end

function MenuCallbackHandler:vote_preplanning_mission_element_by_id(id)
	local logic = managers.menu:active_menu() and managers.menu:active_menu().logic
	local item = logic and logic:selected_node() and logic:selected_node():item(id)
	if item then
		MenuCallbackHandler:vote_preplanning_mission_element_by_item(item)
	end
end

function MenuCallbackHandler:select_preplanning_mission_element_by_item(item)
end

function MenuCallbackHandler:reserve_preplanning_mission_element(type, id)
	print("[reserve_preplanning_mission_element]", "type", type, "id", id)
	managers.preplanning:reserve_mission_element(type, id)
end

function MenuCallbackHandler:reserve_preplanning_mission_element_by_item(item)
	if item then
		if item:enabled() then
			local logic = managers.menu:active_menu() and managers.menu:active_menu().logic
			local type = logic and logic:selected_node() and logic:selected_node():parameters().current_type
			if type then
				MenuCallbackHandler:reserve_preplanning_mission_element(type, item:name())
			end
		else
			managers.menu_component:preplanning_flash_error(item:name(), item:parameters().flash_budget, item:parameters().flash_money)
		end
	end
end

function MenuCallbackHandler:reserve_preplanning_mission_element_by_id(id)
	local logic = managers.menu:active_menu() and managers.menu:active_menu().logic
	local item = logic and logic:selected_node() and logic:selected_node():item(id)
	if item then
		MenuCallbackHandler:reserve_preplanning_mission_element_by_item(item)
	end
end

function MenuCallbackHandler:unreserve_preplanning_mission_element(id)
	print("[unreserve_preplanning_mission_element]", "id", id)
	managers.preplanning:unreserve_mission_element(id)
end

function MenuCallbackHandler:unreserve_preplanning_mission_element_by_item(item)
	if item and item:enabled() then
		MenuCallbackHandler:unreserve_preplanning_mission_element(item:name())
	end
end

function MenuCallbackHandler:unreserve_preplanning_mission_element_by_id(id)
	local logic = managers.menu:active_menu() and managers.menu:active_menu().logic
	local item = logic and logic:selected_node() and logic:selected_node():item(id)
	if item then
		MenuCallbackHandler:unreserve_preplanning_mission_element_by_item(item)
	end
end

function MenuCallbackHandler:swap_preplanning_mission_element_by_id(id)
	local logic = managers.menu:active_menu().logic
	if logic then
		if not logic:selected_node() then
			return false
		end
		local type = logic:selected_node():parameters().current_type
		assert(type and id, "[MenuCallbackHandler:swap_preplanning_mission_element_by_id] Mission element is missing!", "type", type, "id", id)
		MenuCallbackHandler:unreserve_preplanning_mission_element(id)
		MenuCallbackHandler:reserve_preplanning_mission_element(type, id)
	end
end

function MenuCallbackHandler:swap_preplanning_mission_element_by_item(item)
	if item and item:enabled() then
		MenuCallbackHandler:swap_preplanning_mission_element_by_id(item:name())
	end
end

function MenuCallbackHandler:select_preplanning_item_by_id(id)
	local logic = managers.menu:active_menu().logic
	if logic then
		if not logic:selected_node() then
			return false
		end
		if not logic:selected_node():selected_item() or logic:selected_node():selected_item():name() ~= id then
			logic:select_item(id, true)
		end
	end
end

function MenuCallbackHandler:chk_preplanning_type(item)
	return managers.menu_component:get_preplanning_filter() == item:name()
end

function MenuCallbackHandler:chk_preplanning_point(item)
	return false
end

function MenuCallbackHandler:clear_preplanning_category_filter()
	managers.menu_component:set_preplanning_category_filter(false)
end

function MenuCallbackHandler:clear_preplanning_type_filter()
	managers.menu_component:set_preplanning_type_filter(false)
end

function MenuCallbackHandler:open_preplanning_help(item)
	managers.menu:show_preplanning_help()
end

function MenuCallbackHandler:open_preplanning_drawboard_item(item)
	managers.menu:open_node("preplanning_drawboard")
end

function MenuCallbackHandler:toggle_preplanning_drawing(item)
	local peer_id = tonumber(item:name())
	managers.menu_component:toggle_preplanning_drawing(peer_id)
end

function MenuCallbackHandler:_jukebox_disable_items(selected_item)
	local your_choice = managers.menu:active_menu().logic:selected_node():item("toggle_jukebox_your_choice")
	local items = {}
	table.insert(items, managers.menu:active_menu().logic:selected_node():item("toggle_jukebox_playlist_all"))
	table.insert(items, managers.menu:active_menu().logic:selected_node():item("toggle_jukebox_playlist_global"))
	table.insert(items, managers.menu:active_menu().logic:selected_node():item("toggle_jukebox_playlist_heist"))
	table.insert(items, managers.menu:active_menu().logic:selected_node():item("toggle_jukebox_server_choice"))
	table.insert(items, your_choice)
	for _, item in ipairs(items) do
		item:set_value(item == selected_item and "on" or "off")
	end
	managers.menu:active_menu().logic:selected_node():item("choose_jukebox_your_choice"):set_enabled(selected_item == your_choice)
end

function MenuCallbackHandler:jukebox_playlist_all(item)
	if item:enabled() then
		self:_jukebox_disable_items(item)
		Global.music_manager.loadout_selection = nil
		managers.music:track_listen_start("stop_all_music")
		managers.menu:active_menu().logic:selected_node():item("choose_jukebox_your_choice"):set_icon_visible(false)
	end
end

function MenuCallbackHandler:jukebox_playlist_global(item)
	if item:enabled() then
		self:_jukebox_disable_items(item)
		Global.music_manager.loadout_selection = "global"
		managers.music:track_listen_start("stop_all_music")
		managers.menu:active_menu().logic:selected_node():item("choose_jukebox_your_choice"):set_icon_visible(false)
	end
end

function MenuCallbackHandler:jukebox_playlist_heist(item)
	if item:enabled() then
		self:_jukebox_disable_items(item)
		Global.music_manager.loadout_selection = "heist"
		managers.music:track_listen_start("stop_all_music")
		managers.menu:active_menu().logic:selected_node():item("choose_jukebox_your_choice"):set_icon_visible(false)
	end
end

function MenuCallbackHandler:jukebox_server_choice(item)
	if item:enabled() then
		self:_jukebox_disable_items(item)
		Global.music_manager.loadout_selection = "server"
		managers.music:track_listen_start("stop_all_music")
		managers.menu:active_menu().logic:selected_node():item("choose_jukebox_your_choice"):set_icon_visible(false)
	end
end

function MenuCallbackHandler:jukebox_your_choice(item)
	if item:enabled() then
		self:_jukebox_disable_items(item)
		Global.music_manager.loadout_selection = managers.menu:active_menu().logic:selected_node():item("choose_jukebox_your_choice"):value()
	end
end

function MenuCallbackHandler:jukebox_track_selection(item)
	local track = item:value()
	Global.music_manager.loadout_selection = track
	if track ~= "all" and track ~= "playlist" then
		managers.music:track_listen_start("music_heist_assault", track)
		managers.menu_component:on_ready_pressed_mission_briefing_gui(false)
		item:set_icon_visible(true)
	else
		managers.music:track_listen_stop()
		item:set_icon_visible(false)
	end
end

function MenuCallbackHandler:jukebox_option_heist_tracks(item)
	local track = item:value()
	local job = item:parameters().heist_job
	if job == "escape" then
		managers.music:track_attachment_add(job, track)
	else
		local job_tweak = tweak_data.narrative.jobs[job]
		if not job_tweak then
			return
		end
		local day = item:parameters().heist_days and item:parameters().heist_days or ""
		managers.music:track_attachment_add(job_tweak.name_id .. day, track)
	end
	local item_list = managers.menu:active_menu().logic:selected_node():items()
	for _, item_data in ipairs(item_list) do
		if item_data.set_icon_visible then
			item_data:set_icon_visible(false)
		end
	end
	if track ~= "all" and track ~= "playlist" then
		managers.music:track_listen_start("music_heist_assault", track)
		item:set_icon_visible(true)
	else
		managers.music:track_listen_stop()
	end
	managers.savefile:setting_changed()
end

function MenuCallbackHandler:jukebox_option_heist_playlist(item)
	local tracks_list = managers.music:jukebox_music_tracks()
	local empty_list = true
	for _, track_name in pairs(tracks_list) do
		if managers.menu:active_menu().logic:selected_node():item(track_name):value() == "on" then
			empty_list = false
			break
		end
	end
	local item_list = managers.menu:active_menu().logic:selected_node():items()
	for _, item_data in ipairs(item_list) do
		if item_data.set_icon_visible then
			item_data:set_icon_visible(false)
		end
	end
	if empty_list then
		item:set_value("on")
	else
		if item:value() == "on" then
			managers.music:playlist_add(item:name())
			managers.music:track_listen_start("music_heist_assault", item:name())
			item:set_icon_visible(true)
		else
			managers.music:playlist_remove(item:name())
			managers.music:track_listen_stop()
		end
		managers.savefile:setting_changed()
	end
end

function MenuCallbackHandler:jukebox_option_menu_playlist(item)
	local tracks_list = managers.music:jukebox_menu_tracks()
	local empty_list = true
	for _, track_name in pairs(tracks_list) do
		if managers.menu:active_menu().logic:selected_node():item(track_name):value() == "on" then
			empty_list = false
			break
		end
	end
	local item_list = managers.menu:active_menu().logic:selected_node():items()
	for _, item_data in ipairs(item_list) do
		if item_data.set_icon_visible then
			item_data:set_icon_visible(false)
		end
	end
	if empty_list then
		item:set_value("on")
	else
		if item:value() == "on" then
			managers.music:playlist_menu_add(item:name())
			managers.music:track_listen_start(item:name())
			item:set_icon_visible(true)
		else
			managers.music:playlist_menu_remove(item:name())
			managers.music:track_listen_stop()
		end
		managers.savefile:setting_changed()
	end
end

function MenuCallbackHandler:jukebox_option_menu_tracks(item)
	local track = item:value()
	local item_list = managers.menu:active_menu().logic:selected_node():items()
	for _, item_data in ipairs(item_list) do
		if item_data.set_icon_visible then
			item_data:set_icon_visible(false)
		end
	end
	managers.music:track_attachment_add(item:name(), track)
	if track ~= "all" and track ~= "playlist" then
		managers.music:track_listen_start(track)
		item:set_icon_visible(true)
	else
		managers.music:track_listen_stop()
	end
	managers.savefile:setting_changed()
end

function MenuCallbackHandler:jukebox_options_enter(item)
	managers.music:post_event("stop_all_music")
end

function MenuCallbackHandler:jukebox_option_back(item)
	managers.music:track_listen_stop()
	managers.music:post_event(managers.music:jukebox_menu_track("mainmenu"))
	managers.menu_component:show_contract_character(true)
end

MenuCrimeNetGageAssignmentInitiator = MenuCrimeNetGageAssignmentInitiator or class(MenuCrimeNetContactInfoInitiator)

function MenuCrimeNetGageAssignmentInitiator:modify_node(original_node, data)
	local node = original_node
	node:clean_items()
	self:create_divider(node, 1, managers.localization:text("menu_gage_assignment_div_menu"), nil, tweak_data.screen_colors.text)
	self:create_item(node, {
		id = "_introduction",
		name_localized = managers.localization:text("menu_gage_assignment_introduction_title")
	})
	self:create_item(node, {
		id = "_summary",
		name_localized = managers.localization:text("menu_gage_assignment_summary_title")
	})
	if SystemInfo:platform() ~= Idstring("XB1") then
		self:create_item(node, {
			id = "_video",
			name_localized = managers.localization:text("menu_gage_assignment_video_title")
		})
	end
	self:create_divider(node, 2)
	self:create_divider(node, 3, managers.localization:text("menu_gage_assignment_div_packages"), nil, tweak_data.screen_colors.text)
	local node_data = {}
	for assignment, data in pairs(tweak_data.gage_assignment:get_assignments()) do
		table.insert(node_data, {
			id = assignment,
			name_localized = managers.localization:text(data.name_id),
			aquire = data.aquire or 1
		})
	end
	table.sort(node_data, function(x, y)
		return x.aquire < y.aquire
	end)
	for assignment, data in ipairs(node_data) do
		self:create_item(node, data)
	end
	local params = {
		name = "back",
		text_id = "menu_back",
		previous_node = "true",
		visible_callback = "is_pc_controller",
		align = "left",
		last_item = "true",
		gui_node_custom = "true",
		pd2_corner = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	if not managers.gage_assignment:visited_gage_crimenet() then
		node:set_default_item_name("_introduction")
		node:select_item("_introduction")
		managers.menu:active_menu().logic:trigger_item(false, node:item("_introduction"))
		managers.gage_assignment:visit_gage_crimenet()
	else
		node:set_default_item_name("_summary")
		node:select_item("_summary")
		managers.menu:active_menu().logic:trigger_item(false, node:item("_summary"))
	end
	managers.gage_assignment:dialog_show_completed_assignments()
	return node
end

MenuCrimeNetSpecialInitiator = MenuCrimeNetSpecialInitiator or class()
MenuCrimeNetSpecialInitiator.job_callback = nil
MenuCrimeNetSpecialInitiator.choose_any_job = nil

function MenuCrimeNetSpecialInitiator:modify_node(original_node, data)
	local node = original_node
	return self:setup_node(node)
end

function MenuCrimeNetSpecialInitiator:refresh_node(node)
	self:setup_node(node)
	return node
end

function MenuCrimeNetSpecialInitiator:setup_node(node)
	local listed_contact = node:parameters().listed_contact
	MenuCallbackHandler:chk_dlc_content_updated()
	if not listed_contact then
		for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
			local job_tweak = tweak_data.narrative:job_data(job_id)
			if job_tweak.contact then
				if job_tweak.contact == "bain" then
					listed_contact = "bain"
					break
				else
					listed_contact = job_tweak.contact
				end
			end
		end
	end
	node:clean_items()
	if not node:item("divider_end") then
		if self.pre_create_clbk then
			self:pre_create_clbk(node)
		end
		local max_jc = managers.job:get_max_jc_for_player()
		local jobs = {}
		local contacts = {}
		for index, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
			local job_tweak = tweak_data.narrative:job_data(job_id)
			local contact = job_tweak.contact
			local contact_tweak = tweak_data.narrative.contacts[contact]
			if contact then
				local allow_contact = true
				allow_contact = not table.contains(contacts, contact) and (not contact_tweak or not contact_tweak.hidden)
				if allow_contact then
					table.insert(contacts, contact)
				end
				jobs[contact] = jobs[contact] or {}
				local dlc = job_tweak.dlc
				dlc = not dlc or managers.dlc:is_dlc_unlocked(dlc)
				if not tweak_data.narrative:is_wrapped_to_job(job_id) then
					table.insert(jobs[contact], {
						id = job_id,
						enabled = self.choose_any_job or dlc and max_jc >= (job_tweak.jc or 0) + (job_tweak.professional and 10 or 0)
					})
				end
			end
		end
		table.sort(contacts, function(x, y)
			return x < y
		end)
		for _, contracts in pairs(jobs) do
			table.sort(contracts, function(x, y)
				if x.enabled ~= y.enabled then
					return x.enabled
				end
				local job_tweak_x = tweak_data.narrative:job_data(x.id)
				local job_tweak_y = tweak_data.narrative:job_data(y.id)
				local string_x = managers.localization:to_upper_text(job_tweak_x.name_id)
				local string_y = managers.localization:to_upper_text(job_tweak_y.name_id)
				local ids_x = Idstring(string_x)
				local ids_y = Idstring(string_y)
				if ids_x ~= ids_y then
					return string_x < string_y
				end
				if job_tweak_x.jc ~= job_tweak_y.jc then
					return job_tweak_x.jc <= job_tweak_y.jc
				end
				return false
			end)
		end
		local params = {
			name = "contact_filter",
			text_id = "menu_contact_filter",
			callback = "choice_premium_contact",
			filter = true
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		local num_contact = 0
		for index, contact in ipairs(contacts) do
			if jobs[contact] then
				num_contact = num_contact + 1
			end
		end
		if 1 < num_contact then
			table.insert(data_node, {
				_meta = "option",
				no_text = true,
				text_id = "",
				value = contacts[#contacts] .. "#"
			})
		end
		for index, contact in ipairs(contacts) do
			if jobs[contact] then
				table.insert(data_node, {
					_meta = "option",
					text_id = tweak_data.narrative.contacts[contact].name_id,
					value = contact
				})
			end
		end
		if 1 < num_contact then
			table.insert(data_node, {
				_meta = "option",
				no_text = true,
				text_id = "",
				value = contacts[1] .. "#"
			})
		end
		local new_item = node:create_item(data_node, params)
		new_item:set_value(listed_contact)
		node:add_item(new_item)
		self:create_divider(node, "1")
		self:create_divider(node, "title", self.contract_divider_id or "menu_cn_premium_buy_title", nil, tweak_data.screen_colors.text)
		if jobs[listed_contact] then
			for _, contract in pairs(jobs[listed_contact]) do
				self:create_job(node, contract)
			end
		end
		if self.post_create_clbk then
			self:post_create_clbk(node)
		end
		self:create_divider(node, "end")
	end
	local params = {
		name = "back",
		text_id = "menu_back",
		previous_node = "true",
		visible_callback = "is_pc_controller",
		align = "right",
		last_item = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:set_default_item_name(self.default_item or "contact_filter")
	node:select_item(self.default_item or "contact_filter")
	return node
end

function MenuCrimeNetSpecialInitiator:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		size = size or 8,
		color = color
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function MenuCrimeNetSpecialInitiator:create_job(node, contract)
	local id = contract.id
	local enabled = contract.enabled
	local text_id, color_ranges = tweak_data.narrative:create_job_name(id)
	local help_id = ""
	local ghostable = managers.job:is_job_ghostable(id)
	if ghostable then
		text_id = text_id .. " " .. managers.localization:get_default_macro("BTN_GHOST")
	end
	if not enabled then
		local job_tweak = tweak_data.narrative:job_data(id)
		local player_stars = managers.experience:level_to_stars()
		local max_jc = managers.job:get_max_jc_for_player()
		local job_tweak = tweak_data.narrative:job_data(id)
		local jc_lock = math.clamp(job_tweak.jc, 0, 100)
		local min_stars = #tweak_data.narrative.STARS
		for i, d in ipairs(tweak_data.narrative.STARS) do
			if jc_lock <= d.jcs[1] then
				min_stars = i
				break
			end
		end
		local level_lock = (min_stars - 1) * 10
		local pass_dlc = not job_tweak.dlc or managers.dlc:is_dlc_unlocked(job_tweak.dlc)
		local pass_level = player_stars >= min_stars
		if not pass_dlc then
			local locks = job_tweak.gui_locks
			local unlock_id = ""
			if locks then
				do
					local dlc = locks.dlc
					local achievement = locks.achievement
					local saved_job_value = locks.saved_job_value
					local level = locks.level
					if dlc and not managers.dlc:is_dlc_unlocked(dlc) then
					else
						if achievement and managers.achievment:get_info(achievement) and not managers.achievment:get_info(achievement).awarded then
							text_id = text_id .. "  " .. managers.localization:to_upper_text("menu_bm_achievement_locked_" .. tostring(achievement))
						else
						end
					end
				end
			end
		else
			if not pass_level then
			else
			end
		end
	end
	local params = {
		name = "job_" .. id,
		text_id = text_id,
		color_ranges = color_ranges,
		localize = "false",
		callback = enabled and (self.job_callback or "open_contract_node"),
		disabled_color = tweak_data.screen_colors.important_1,
		id = id,
		customize_contract = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(enabled)
	node:add_item(new_item)
end

MenuReticleSwitchInitiator = MenuReticleSwitchInitiator or class(MenuCrimeNetSpecialInitiator)

function MenuReticleSwitchInitiator:modify_node(original_node, data)
	local node = original_node
	return self:setup_node(node, data)
end

function MenuReticleSwitchInitiator:setup_node(node, data)
	node:clean_items()
	data = data or node:parameters().menu_component_data
	local part_id = data.name
	local slot = data.slot
	local category = data.category
	local color_index, type_index = managers.blackmarket:get_part_texture_switch_data(category, slot, part_id)
	if not node:item("divider_end") then
		local params = {
			name = "reticle_type",
			text_id = "menu_reticle_type",
			callback = "update_weapon_texture_switch",
			filter = true
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		local pass_dlc
		for index, reticle_data in ipairs(tweak_data.gui.weapon_texture_switches.types.sight) do
			pass_dlc = not reticle_data.dlc or managers.dlc:is_dlc_unlocked(reticle_data.dlc)
			table.insert(data_node, {
				_meta = "option",
				text_id = reticle_data.name_id,
				value = index,
				color = not pass_dlc and tweak_data.screen_colors.important_1
			})
		end
		local new_item = node:create_item(data_node, params)
		node:add_item(new_item)
		new_item:set_value(type_index)
		local params = {
			name = "reticle_color",
			text_id = "menu_reticle_color",
			callback = "update_weapon_texture_switch",
			filter = true
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		for index, color_data in ipairs(tweak_data:get_raw_value("gui", "weapon_texture_switches", "color_indexes") or {}) do
			pass_dlc = not color_data.dlc or managers.dlc:is_dlc_unlocked(color_data.dlc)
			table.insert(data_node, {
				_meta = "option",
				text_id = "menu_recticle_color_" .. color_data.color,
				value = index,
				color = not pass_dlc and tweak_data.screen_colors.important_1
			})
		end
		local new_item = node:create_item(data_node, params)
		node:add_item(new_item)
		new_item:set_value(color_index)
		self:create_divider(node, "end", nil, 256)
	end
	local enabled = MenuCallbackHandler:is_reticle_applicable(node)
	local params = {
		name = "confirm",
		text_id = "dialog_apply",
		callback = "set_weapon_texture_switch",
		align = "right",
		enabled = enabled,
		disabled_color = tweak_data.screen_colors.important_1
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	local params = {
		name = "back",
		text_id = "dialog_cancel",
		previous_node = "true",
		align = "right",
		last_item = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:set_default_item_name("reticle_type")
	node:select_item("reticle_type")
	node:parameters().menu_component_data = data
	node:parameters().set_blackmarket_enabled = false
	return node
end

function MenuReticleSwitchInitiator:refresh_node(node, data)
	local confirm = node:item("confirm")
	local active_node_gui = managers.menu:active_menu().renderer:active_node_gui()
	if active_node_gui and active_node_gui.update_item_dlc_locks then
		local enabled = active_node_gui:update_item_dlc_locks()
		confirm:set_enabled(enabled)
	end
end

function MenuReticleSwitchInitiator:create_multichoice()
end

function MenuCallbackHandler:is_reticle_applicable(node)
	local type = node:item("reticle_type"):value()
	local color = node:item("reticle_color"):value()
	local type_data = tweak_data:get_raw_value("gui", "weapon_texture_switches", "types", "sight", type)
	local color_data = tweak_data:get_raw_value("gui", "weapon_texture_switches", "color_indexes", color)
	local type_dlc = type_data and type_data.dlc or false
	local color_dlc = color_data and color_data.dlc or false
	local pass_type = not type_dlc or managers.dlc:is_dlc_unlocked(type_dlc)
	local pass_color = not color_dlc or managers.dlc:is_dlc_unlocked(color_dlc)
	return pass_type and pass_color
end

function MenuCallbackHandler:update_weapon_texture_switch(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	local node = managers.menu:active_menu().logic:selected_node()
	local color = node:item("reticle_color"):value()
	local type = node:item("reticle_type"):value()
	local data = node:parameters().menu_component_data
	local part_id = data.name
	local data_string = tostring(color) .. " " .. tostring(type)
	local texture = managers.blackmarket:get_texture_switch_from_data(data_string, part_id)
	local active_node_gui = managers.menu:active_menu().renderer:active_node_gui()
	if active_node_gui and active_node_gui.set_reticle_texture and texture and active_node_gui:get_recticle_texture_ids() ~= Idstring(texture) then
		active_node_gui:set_reticle_texture(texture)
	end
	local logic = managers.menu:active_menu().logic
	if logic then
		logic:refresh_node()
	end
end

function MenuCallbackHandler:set_weapon_texture_switch(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	local node = managers.menu:active_menu().logic:selected_node()
	if not MenuCallbackHandler:is_reticle_applicable(node) then
		return
	end
	local color = node:item("reticle_color"):value()
	local type = node:item("reticle_type"):value()
	local data = node:parameters().menu_component_data
	local part_id = data.name
	local slot = data.slot
	local category = data.category
	local data_string = tostring(color) .. " " .. tostring(type)
	managers.blackmarket:set_part_texture_switch(category, slot, part_id, data_string)
	managers.menu:back()
end

MenuCrimeNetCasinoInitiator = MenuCrimeNetCasinoInitiator or class()

function MenuCrimeNetCasinoInitiator:modify_node(original_node, data)
	local node = deep_clone(original_node)
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	self:_create_items(node)
	node:parameters().menu_component_data = data
	return node
end

function MenuCrimeNetCasinoInitiator:refresh_node(node)
	local options = {}
	options.preferred = node:item("preferred_item"):value()
	options.infamous = node:item("increase_infamous"):value()
	options.card1 = node:item("secure_card_1"):value()
	options.card2 = node:item("secure_card_2"):value()
	options.card3 = node:item("secure_card_3"):value()
	node:clean_items()
	self:_create_items(node, options)
	return node
end

function MenuCallbackHandler:casino_betting_visible()
	return true
end

function MenuCrimeNetCasinoInitiator:_create_items(node, options)
	local visible_callback = "casino_betting_visible"
	local preferred_data = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_casino_option_prefer_none",
			value = "none"
		},
		{
			_meta = "option",
			text_id = "menu_casino_stat_weapon_mods",
			value = "weapon_mods"
		},
		{
			_meta = "option",
			text_id = "menu_casino_stat_masks",
			value = "masks"
		},
		{
			_meta = "option",
			text_id = "menu_casino_stat_materials",
			value = "materials"
		},
		{
			_meta = "option",
			text_id = "menu_casino_stat_textures",
			value = "textures"
		},
		{
			_meta = "option",
			text_id = "menu_casino_stat_colors",
			value = "colors"
		}
	}
	local preferred_params = {
		name = "preferred_item",
		text_id = "",
		callback = "crimenet_casino_update",
		visible_callback = visible_callback
	}
	local preferred_item = node:create_item(preferred_data, preferred_params)
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 1) then
		preferred_item:set_value("none")
		preferred_item:set_enabled(false)
	else
		preferred_item:set_value(options and options.preferred or "none")
	end
	node:add_item(preferred_item)
	local infamous_data = {
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
	local infamous_params = {
		name = "increase_infamous",
		text_id = "menu_casino_option_infamous_title",
		callback = "crimenet_casino_update",
		disabled_color = Color(0.25, 1, 1, 1),
		icon_by_text = true,
		visible_callback = visible_callback
	}
	local infamous_items = {
		weapon_mods = false,
		masks = true,
		materials = true,
		textures = true,
		colors = false
	}
	local preferred_value = preferred_item:value()
	local infamous_item = node:create_item(infamous_data, infamous_params)
	infamous_item:set_enabled(infamous_items[preferred_value])
	if not infamous_item:enabled() then
		infamous_item:set_value("off")
	else
		infamous_item:set_value(options and options.infamous or "off")
	end
	node:add_item(infamous_item)
	self:create_divider(node, "casino_divider_securecards")
	local card1_data = {
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
	local card1_params = {
		name = "secure_card_1",
		text_id = "menu_casino_option_safecard1",
		callback = "crimenet_casino_safe_card1",
		disabled_color = Color(0.25, 1, 1, 1),
		icon_by_text = true,
		visible_callback = visible_callback
	}
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 1) then
		card1_params.disabled_color = Color(1, 0.6, 0.2, 0.2)
		card1_params.text_id = managers.localization:to_upper_text("menu_casino_option_safecard1") .. " - " .. managers.localization:to_upper_text("menu_casino_option_safecard_lock", {
			level = tweak_data:get_value("casino", "secure_card_level", 1)
		})
		card1_params.localize = "false"
	end
	local card1_item = node:create_item(card1_data, card1_params)
	card1_item:set_value(preferred_item:value() ~= "none" and options and options.card1 or "off")
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 1) then
		card1_item:set_enabled(false)
	else
		card1_item:set_enabled(preferred_item:value() ~= "none")
	end
	node:add_item(card1_item)
	local card2_data = {
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
	local card2_params = {
		name = "secure_card_2",
		text_id = "menu_casino_option_safecard2",
		callback = "crimenet_casino_safe_card2",
		disabled_color = Color(0.25, 1, 1, 1),
		icon_by_text = true,
		visible_callback = visible_callback
	}
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 2) then
		card2_params.disabled_color = Color(1, 0.6, 0.2, 0.2)
		card2_params.text_id = managers.localization:to_upper_text("menu_casino_option_safecard2") .. " - " .. managers.localization:to_upper_text("menu_casino_option_safecard_lock", {
			level = tweak_data:get_value("casino", "secure_card_level", 2)
		})
		card2_params.localize = "false"
	end
	local card2_item = node:create_item(card2_data, card2_params)
	card2_item:set_value(preferred_item:value() ~= "none" and options and options.card2 or "off")
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 2) then
		card2_item:set_enabled(false)
	else
		card2_item:set_enabled(preferred_item:value() ~= "none")
	end
	node:add_item(card2_item)
	local card3_data = {
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
	local card3_params = {
		name = "secure_card_3",
		text_id = "menu_casino_option_safecard3",
		callback = "crimenet_casino_safe_card3",
		disabled_color = Color(0.25, 1, 1, 1),
		icon_by_text = true,
		visible_callback = visible_callback
	}
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 3) then
		card3_params.disabled_color = Color(1, 0.6, 0.2, 0.2)
		card3_params.text_id = managers.localization:to_upper_text("menu_casino_option_safecard3") .. " - " .. managers.localization:to_upper_text("menu_casino_option_safecard_lock", {
			level = tweak_data:get_value("casino", "secure_card_level", 3)
		})
		card3_params.localize = "false"
	end
	local card3_item = node:create_item(card3_data, card3_params)
	card3_item:set_value(preferred_item:value() ~= "none" and options and options.card3 or "off")
	if managers.experience:current_level() < tweak_data:get_value("casino", "secure_card_level", 3) then
		card3_item:set_enabled(false)
	else
		card3_item:set_enabled(preferred_item:value() ~= "none")
	end
	node:add_item(card3_item)
	self:create_divider(node, "casino_cost")
	local increase_infamous = infamous_item:value() == "on"
	local secured_cards = (card1_item:value() == "on" and 1 or 0) + (card2_item:value() == "on" and 1 or 0) + (card3_item:value() == "on" and 1 or 0)
	if options then
		managers.menu:active_menu().renderer:selected_node():set_update_values(preferred_item:value(), secured_cards, increase_infamous, infamous_item:enabled(), card1_item:enabled())
		managers.menu_component:can_afford()
	end
end

function MenuCrimeNetCasinoInitiator:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		size = size or 8,
		color = color,
		visible_callback = "casino_betting_visible"
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

MenuCrimeNetCasinoLootdropInitiator = MenuCrimeNetCasinoLootdropInitiator or class()

function MenuCrimeNetCasinoLootdropInitiator:modify_node(original_node, data)
	local node = deep_clone(original_node)
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	node:parameters().menu_component_data = data
	return node
end

MenuCrimeNetFiltersInitiator = MenuCrimeNetFiltersInitiator or class()

function MenuCrimeNetFiltersInitiator:modify_node(original_node, data)
	local node = original_node
	node:item("toggle_friends_only"):set_value(Global.game_settings.search_friends_only and "on" or "off")
	if MenuCallbackHandler:is_win32() then
		local matchmake_filters = managers.network.matchmake:lobby_filters()
		node:item("toggle_new_servers_only"):set_value(matchmake_filters.num_players and matchmake_filters.num_players.value or -1)
		node:item("toggle_server_state_lobby"):set_value(matchmake_filters.state and matchmake_filters.state.value or -1)
		node:item("toggle_job_appropriate_lobby"):set_value(Global.game_settings.search_appropriate_jobs and "on" or "off")
		node:item("toggle_allow_safehouses"):set_value(Global.game_settings.allow_search_safehouses and "on" or "off")
		node:item("toggle_mutated_lobby"):set_value(Global.game_settings.search_mutated_lobbies and "on" or "off")
		node:item("max_lobbies_filter"):set_value(managers.network.matchmake:get_lobby_return_count())
		node:item("server_filter"):set_value(managers.network.matchmake:distance_filter())
		node:item("difficulty_filter"):set_value(matchmake_filters.difficulty and matchmake_filters.difficulty.value or -1)
		node:item("job_plan_filter"):set_value(matchmake_filters.job_plan and matchmake_filters.job_plan.value or -1)
		node:item("gamemode_filter"):set_value(Global.game_settings.gamemode_filter or GamemodeStandard.id)
		node:item("max_spree_difference_filter"):set_value(Global.game_settings.crime_spree_max_lobby_diff or -1)
		local job_id_filter = node:item("job_id_filter")
		if job_id_filter then
			job_id_filter:set_value(managers.network.matchmake:get_lobby_filter("job_id") or -1)
		end
		local kick_option_filter = node:item("kick_option_filter")
		if kick_option_filter then
			kick_option_filter:set_value(managers.network.matchmake:get_lobby_filter("kick_option") or -1)
		end
		self:add_filters(node)
	end
	self:update_node(node)
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	node:parameters().menu_component_data = data
	return node
end

function MenuCrimeNetFiltersInitiator:update_node(node)
	if MenuCallbackHandler:is_win32() then
		local not_friends_only = not Global.game_settings.search_friends_only
		node:item("toggle_new_servers_only"):set_enabled(not_friends_only)
		node:item("toggle_server_state_lobby"):set_enabled(not_friends_only)
		node:item("toggle_job_appropriate_lobby"):set_enabled(not_friends_only)
		node:item("toggle_mutated_lobby"):set_enabled(not_friends_only)
		node:item("max_lobbies_filter"):set_enabled(not_friends_only)
		node:item("server_filter"):set_enabled(not_friends_only)
		node:item("difficulty_filter"):set_enabled(not_friends_only)
		node:item("kick_option_filter"):set_enabled(not_friends_only)
		node:item("job_id_filter"):set_enabled(not_friends_only)
		node:item("job_plan_filter"):set_enabled(not_friends_only)
		node:item("toggle_job_appropriate_lobby"):set_visible(self:is_standard())
		node:item("toggle_allow_safehouses"):set_visible(self:is_standard())
		node:item("toggle_mutated_lobby"):set_visible(self:is_standard())
		node:item("difficulty_filter"):set_visible(self:is_standard())
		node:item("job_id_filter"):set_visible(self:is_standard())
		node:item("max_spree_difference_filter"):set_visible(self:is_crime_spree())
	end
end

function MenuCrimeNetFiltersInitiator:is_standard()
	return not Global.game_settings or not Global.game_settings.gamemode_filter or Global.game_settings.gamemode_filter == GamemodeStandard.id
end

function MenuCrimeNetFiltersInitiator:is_crime_spree()
	return Global.game_settings and Global.game_settings.gamemode_filter == GamemodeCrimeSpree.id
end

function MenuCrimeNetFiltersInitiator:refresh_node(node)
	self:modify_node(node, {})
	self:update_node(node)
end

function MenuCrimeNetFiltersInitiator:add_filters(node)
	if node:item("divider_end") then
		return
	end
	local params = {
		name = "job_id_filter",
		text_id = "menu_job_id_filter",
		visible_callback = "is_multiplayer is_win32",
		callback = "choice_job_id_filter",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_any",
			value = -1
		}
	}
	for index, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local job_tweak = tweak_data.narrative.jobs[job_id]
		local contact = job_tweak.contact
		local contact_tweak = tweak_data.narrative.contacts[contact]
		local allow = not job_tweak.wrapped_to_job and contact ~= "tests" and (not job_tweak or not job_tweak.hidden)
		if allow then
			local text_id, color_data = tweak_data.narrative:create_job_name(job_id)
			local params = {
				_meta = "option",
				text_id = text_id,
				value = index,
				localize = false
			}
			for count, color in ipairs(color_data) do
				params["color" .. count] = color.color
				params["color_start" .. count] = color.start
				params["color_stop" .. count] = color.stop
			end
			table.insert(data_node, params)
		end
	end
	local new_item = node:create_item(data_node, params)
	new_item:set_value(managers.network.matchmake:get_lobby_filter("job_id") or -1)
	node:add_item(new_item)
	local params = {
		name = "kick_option_filter",
		text_id = "menu_kicking_allowed_filter",
		visible_callback = "is_multiplayer is_win32",
		callback = "choice_kick_option",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_any",
			value = -1
		}
	}
	local kick_filters = {
		{
			text_id = "menu_kick_server",
			value = 1
		},
		{
			text_id = "menu_kick_vote",
			value = 2
		},
		{
			text_id = "menu_kick_disabled",
			value = 0
		}
	}
	for index, filter in ipairs(kick_filters) do
		table.insert(data_node, {
			_meta = "option",
			text_id = filter.text_id,
			value = filter.value
		})
	end
	local new_item = node:create_item(data_node, params)
	new_item:set_value(managers.network.matchmake:get_lobby_filter("kick_option") or -1)
	node:add_item(new_item)
	local params = {
		name = "divider_end",
		no_text = true,
		size = 8
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	local params = {
		name = "reset_filters",
		text_id = "dialog_reset_filters",
		callback = "_reset_filters",
		align = "right"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	self:modify_node(node, {})
end

function MenuCallbackHandler:_reset_filters(item)
	if managers.network.matchmake.reset_filters then
		managers.network.matchmake:reset_filters()
		managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
		self:refresh_node(item)
	end
end

MenuMutatorOptionsInitiator = MenuMutatorOptionsInitiator or class(MenuCrimeNetSpecialInitiator)

function MenuMutatorOptionsInitiator:modify_node(original_node, data)
	local node = original_node
	return self:setup_node(node, data)
end

function MenuMutatorOptionsInitiator:setup_node(node, mutator)
	node:clean_items()
	mutator = mutator or node:parameters()._mutator
	local default_item = mutator:setup_options_gui(node)
	self:create_divider(node, "end", nil, 16)
	local params = {
		name = "reset",
		text_id = "menu_mutators_reset",
		callback = "reset_mutator",
		align = "right",
		disabled_color = tweak_data.screen_colors.important_1,
		mutator = mutator
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	local params = {
		name = "back",
		text_id = "dialog_accept",
		callback = "save_mutator_options",
		align = "right",
		last_item = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:parameters()._mutator = mutator
	if default_item then
		node:set_default_item_name(default_item:parameters().name)
		node:select_item(default_item:parameters().name)
	end
	return node
end

function MenuMutatorOptionsInitiator:refresh_node(node, data)
end

function MenuCallbackHandler:reset_mutator(item)
	item:parameters().mutator:reset_to_default()
end

function MenuCallbackHandler:save_mutator_options(item)
	local mutator = item:parameters().gui_node.node:parameters()._mutator
	if mutator then
		managers.mutators:set_enabled(mutator, true)
	end
	managers.menu:back()
	managers.menu_component:mutators_list_gui():refresh()
	self:_update_mutators_info()
end

function MenuCallbackHandler:_update_mutators_info()
	if Network:is_server() then
		managers.network.matchmake:set_server_attributes(self:get_matchmake_attributes())
		managers.mutators:update_lobby_info()
	end
end

MenuLobbyCountdownInitiator = MenuLobbyCountdownInitiator or class(MenuCrimeNetSpecialInitiator)

function MenuLobbyCountdownInitiator:modify_node(original_node, data)
	local node = original_node
	return self:setup_node(node, data)
end

function MenuLobbyCountdownInitiator:setup_node(node, mutator)
	node:clean_items()
	local params = {
		name = "back",
		text_id = "dialog_cancel",
		previous_node = "true",
		align = "right",
		last_item = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	node:set_default_item_name("back")
	node:select_item("back")
	return node
end

function MenuLobbyCountdownInitiator:refresh_node(node, data)
end

MenuCrimeNetSmartmatchmakeInitiator = MenuCrimeNetSmartmatchmakeInitiator or class()

function MenuCrimeNetSmartmatchmakeInitiator:modify_node(original_node, data)
	local node = original_node
	self:add_filters(node)
	if data and data.back_callback then
		table.insert(node:parameters().back_callback, data.back_callback)
	end
	node:parameters().menu_component_data = data
	return node
end

function MenuCrimeNetSmartmatchmakeInitiator:add_filters(node)
	if node:item("divider_end") then
		return
	end
	local params = {
		name = "job_id_filter",
		text_id = "menu_smm_job_id",
		visible_callback = "is_multiplayer",
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "menu_any",
			value = -1
		}
	}
	for index, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		if not tweak_data.narrative.jobs[job_id].wrapped_to_job and tweak_data.narrative.jobs[job_id].contact ~= "wip" then
			local text_id, color_data = tweak_data.narrative:create_job_name(job_id)
			local params = {
				_meta = "option",
				text_id = text_id,
				value = index,
				localize = false
			}
			for count, color in ipairs(color_data) do
				params["color" .. count] = color.color
				params["color_start" .. count] = color.start
				params["color_stop" .. count] = color.stop
			end
			table.insert(data_node, params)
		end
	end
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	local params = {
		name = "divider_end",
		no_text = true,
		size = 8
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function MenuCallbackHandler:start_smart_matchmaking(item)
	if item:name() == "quick_join" then
		local jobs = managers.crimenet:get_jobs_by_player_stars()
		local random_job = jobs[math.random(#jobs)]
		print("[MenuCallbackHandler:start_smart_matchmaking] QUICK JOIN", "difficulty_filter", random_job.difficulty_id, "job_id_filter", random_job.job_id)
		managers.network.matchmake:join_by_smartmatch(-1, random_job.difficulty_id)
	else
		managers.menu:active_menu().logic:navigate_back(true)
		local job_data = item:parameters().gui_node.node:parameters().menu_component_data
		local difficulty_filter = job_data.difficulty_id
		local job_id_filter = job_data.job_id
		print("[MenuCallbackHandler:start_smart_matchmaking] SEARCH", "difficulty_filter", difficulty_filter, "job_id_filter", job_id_filter)
		managers.network.matchmake:join_by_smartmatch(job_id_filter, difficulty_filter)
	end
end

function MenuCallbackHandler:open_contract_smart_matchmaking_node(item)
	local job_tweak = tweak_data.narrative:job_data(item:parameters().id)
	local is_professional = job_tweak and job_tweak.professional or false
	managers.menu:open_node("crimenet_join_smart_matchmaking", {
		{
			smart_matchmaking = true,
			job_id = item:parameters().id,
			difficulty = is_professional and "hard" or "normal",
			difficulty_id = is_professional and 3 or 2,
			professional = is_professional
		}
	})
end

MenuCrimeNetSmartMatchmakingInitiator = MenuCrimeNetSmartMatchmakingInitiator or class(MenuCrimeNetSpecialInitiator)
MenuCrimeNetSmartMatchmakingInitiator.job_callback = "open_contract_smart_matchmaking_node"
MenuCrimeNetSmartMatchmakingInitiator.choose_any_job = true
MenuCrimeNetSmartMatchmakingInitiator.contract_divider_id = "menu_cn_smart_matchmaking_divider_title"

function MenuCrimeNetSmartMatchmakingInitiator:pre_create_clbk(node)
	local params = {
		name = "quick_join",
		text_id = "menu_cn_quick_join",
		callback = "start_smart_matchmaking"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	self:create_divider(node, "smart")
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
	elseif node_name == "network_options" then
		return self:modify_network_options(node)
	elseif node_name == "gameplay_options" then
		return self:modify_gameplay_options(node)
	elseif node_name == "user_interface_options" then
		return self:modify_user_interface_options(node)
	end
end

function MenuOptionInitiator:refresh_node(node)
	self:modify_node(node)
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
	node:item("use_lightfx"):set_value(managers.user:get_setting("use_lightfx") and "on" or "off")
	node:item("choose_texture_quality"):set_value(RenderSettings.texture_quality_default)
	node:item("choose_shadow_quality"):set_value(RenderSettings.shadow_quality_default)
	node:item("choose_anisotropic"):set_value(RenderSettings.max_anisotropy)
	if node:item("fov_multiplier") then
		node:item("fov_multiplier"):set_value(managers.user:get_setting("fov_multiplier"))
	end
	node:item("choose_gpu_flush"):set_value(managers.user:get_setting("flush_gpu_command_queue") and "on" or "off")
	node:item("choose_fps_cap"):set_value(managers.user:get_setting("fps_cap"))
	node:item("use_headbob"):set_value(managers.user:get_setting("use_headbob") and "on" or "off")
	node:item("max_streaming_chunk"):set_value(managers.user:get_setting("max_streaming_chunk"))
	if node:item("toggle_use_thq_weapon_parts") then
		node:item("toggle_use_thq_weapon_parts"):set_value(managers.user:get_setting("use_thq_weapon_parts") and "on" or "off")
	end
	local toggle_hide_huds = node:item("toggle_hide_huds") or node:item("toggle_hide_huds_xb1") or node:item("toggle_hide_huds_ps4")
	if toggle_hide_huds then
		toggle_hide_huds:set_value(Global.hud_disabled and "on" or "off")
	end
	local option_value = "off"
	local dof_setting_item = node:item("toggle_dof")
	if dof_setting_item then
		if managers.user:get_setting("dof_setting") ~= "none" then
			option_value = "on"
		end
		dof_setting_item:set_value(option_value)
	end
	option_value = "off"
	local chromatic_setting_item = node:item("toggle_chromatic")
	if chromatic_setting_item then
		if managers.user:get_setting("chromatic_setting") ~= "none" then
			option_value = "on"
		end
		chromatic_setting_item:set_value(option_value)
	end
	if node:item("choose_ao") then
		node:item("choose_ao"):set_value(managers.user:get_setting("video_ao"))
	end
	if node:item("toggle_parallax") then
		node:item("toggle_parallax"):set_value(managers.user:get_setting("parallax_mapping") and "on" or "off")
	end
	if node:item("choose_aa") then
		node:item("choose_aa"):set_value(managers.user:get_setting("video_aa"))
	end
	node:item("choose_corpse_limit"):set_value(managers.user:get_setting("corpse_limit"))
	local color_grading_item = node:item("choose_color_grading")
	if color_grading_item then
		if #color_grading_item:options() == 0 then
			for id, data in ipairs(tweak_data.color_grading) do
				local option = CoreMenuItemOption.ItemOption:new(data)
				color_grading_item:add_option(option)
			end
		end
		color_grading_item:set_value(managers.user:get_setting("video_color_grading"))
	end
	return node
end

function MenuOptionInitiator:modify_video(node)
	local adapter_item = node:item("choose_video_adapter")
	if adapter_item and adapter_item:visible() then
		adapter_item:clear_options()
		for i = 0, RenderSettings.adapter_count - 1 do
			local option = CoreMenuItemOption.ItemOption:new({
				_meta = "option",
				localize = false,
				text_id = "" .. i + 1,
				value = i
			})
			adapter_item:add_option(option)
		end
		adapter_item:visible()
		adapter_item:set_value(RenderSettings.adapter_index)
		adapter_item:set_enabled(managers.viewport:is_fullscreen())
	end
	local option_value = "off"
	local fs_item = node:item("toggle_fullscreen")
	if fs_item then
		if managers.viewport:is_fullscreen() then
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
	local toggle_hide_huds = node:item("toggle_hide_huds") or node:item("toggle_hide_huds_xb1") or node:item("toggle_hide_huds_ps4")
	if toggle_hide_huds then
		toggle_hide_huds:set_value(Global.hud_disabled and "on" or "off")
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
	local southpaw_item = node:item("toggle_southpaw")
	if southpaw_item then
		if managers.user:get_setting("southpaw") then
			option_value = "on"
		end
		southpaw_item:set_value(option_value)
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
	option_value = "off"
	local sticky_aim_item = node:item("toggle_sticky_aim")
	if sticky_aim_item then
		if managers.user:get_setting("sticky_aim") then
			option_value = "on"
		end
		sticky_aim_item:set_value(option_value)
	end
	local cs_item = node:item("camera_sensitivity")
	if cs_item then
		cs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		cs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		cs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.1)
		cs_item:set_value(managers.user:get_setting("camera_sensitivity"))
	end
	local cs_item = node:item("camera_sensitivity_horizontal")
	if cs_item then
		cs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		cs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		cs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.05)
		cs_item:set_value(managers.user:get_setting("camera_sensitivity_x"))
	end
	local cs_item = node:item("camera_sensitivity_vertical")
	if cs_item then
		cs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		cs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		cs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.05)
		cs_item:set_value(managers.user:get_setting("camera_sensitivity_y"))
	end
	local czs_item = node:item("camera_zoom_sensitivity")
	if czs_item then
		czs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		czs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		czs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.05)
		czs_item:set_value(managers.user:get_setting("camera_zoom_sensitivity"))
	end
	local czs_item = node:item("camera_zoom_sensitivity_horizontal")
	if czs_item then
		czs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		czs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		czs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.05)
		czs_item:set_value(managers.user:get_setting("camera_zoom_sensitivity_x"))
	end
	local czs_item = node:item("camera_zoom_sensitivity_vertical")
	if czs_item then
		czs_item:set_min(tweak_data.player.camera.MIN_SENSITIVITY)
		czs_item:set_max(tweak_data.player.camera.MAX_SENSITIVITY)
		czs_item:set_step((tweak_data.player.camera.MAX_SENSITIVITY - tweak_data.player.camera.MIN_SENSITIVITY) * 0.05)
		czs_item:set_value(managers.user:get_setting("camera_zoom_sensitivity_y"))
	end
	local cs_item = node:item("toggle_zoom_sensitivity")
	if cs_item then
		cs_item:set_value(managers.user:get_setting("enable_camera_zoom_sensitivity") and "on" or "off")
	end
	local cs_item = node:item("toggle_camera_sensitivity_separate")
	if cs_item then
		cs_item:set_value(managers.user:get_setting("enable_camera_sensitivity_separate") and "on" or "off")
	end
	node:item("toggle_fov_based_zoom"):set_value(managers.user:get_setting("enable_fov_based_sensitivity") and "on" or "off")
	return node
end

function MenuOptionInitiator:modify_gameplay_options(node)
	local option_value = "off"
	local throwable_contour = node:item("toggle_throwable_contour")
	if throwable_contour then
		if managers.user:get_setting("throwable_contour") then
			option_value = "on"
		end
		throwable_contour:set_value(option_value)
	end
	option_value = "off"
	local ammo_contour = node:item("toggle_ammo_contour")
	if ammo_contour then
		if managers.user:get_setting("ammo_contour") then
			option_value = "on"
		end
		ammo_contour:set_value(option_value)
	end
	local mute_heist_vo = node:item("toggle_mute_heist_vo")
	if mute_heist_vo then
		mute_heist_vo:set_value(managers.user:get_setting("mute_heist_vo") and "on" or "off")
	end
	return node
end

function MenuOptionInitiator:modify_user_interface_options(node)
	local controller_hint_box = node:item("toggle_controller_hint")
	local controller_hint_setting = managers.user:get_setting("loading_screen_show_controller")
	if controller_hint_box then
		controller_hint_box:set_value(controller_hint_setting and "on" or "off")
	end
	local loading_hints_box = node:item("toggle_loading_hints")
	local loading_hints_setting = managers.user:get_setting("loading_screen_show_hints")
	if loading_hints_box then
		loading_hints_box:set_value(loading_hints_setting and "on" or "off")
	end
	return node
end

function MenuOptionInitiator:modify_debug_options(node)
	return node
end

function MenuOptionInitiator:modify_options(node)
	if node:item("toggle_workshop") then
		node:item("toggle_workshop"):set_value(managers.user:get_setting("workshop") and "on" or "off")
	end
	return node
end

function MenuOptionInitiator:modify_network_options(node)
	local toggle_throttling_item = node:item("toggle_throttling")
	if toggle_throttling_item then
		local toggle_throttling_value = managers.user:get_setting("net_packet_throttling") and "on" or "off"
		toggle_throttling_item:set_value(toggle_throttling_value)
	end
	local toggle_net_forwarding_item = node:item("toggle_net_forwarding")
	if toggle_net_forwarding_item then
		local toggle_net_forwarding_value = managers.user:get_setting("net_forwarding") and "on" or "off"
		toggle_net_forwarding_item:set_value(toggle_net_forwarding_value)
	end
	local net_use_compression_item = node:item("toggle_net_use_compression")
	if net_use_compression_item then
		local net_use_compression_value = managers.user:get_setting("net_use_compression") and "on" or "off"
		net_use_compression_item:set_value(net_use_compression_value)
	end
	return node
end

SkillSwitchInitiator = SkillSwitchInitiator or class()

function SkillSwitchInitiator:modify_node(node, data)
	node:clean_items()
	local hightlight_color, row_item_color, callback
	self:create_divider(node, "title", "menu_st_skill_switch_title_name", nil, tweak_data.screen_colors.text)
	for skill_switch, data in ipairs(Global.skilltree_manager.skill_switches) do
		hightlight_color = nil
		row_item_color = nil
		callback = nil
		local unlocked = data.unlocked
		local can_unlock = managers.skilltree:can_unlock_skill_switch(skill_switch)
		if unlocked then
			if managers.skilltree:get_selected_skill_switch() == skill_switch then
				hightlight_color = tweak_data.screen_colors.text
				row_item_color = tweak_data.screen_colors.text
				callback = "menu_back"
			else
				hightlight_color = tweak_data.screen_colors.button_stage_2
				row_item_color = tweak_data.screen_colors.button_stage_3
				callback = "set_active_skill_switch"
			end
		elseif can_unlock then
			hightlight_color = tweak_data.screen_colors.button_stage_2
			row_item_color = tweak_data.screen_colors.button_stage_3
			callback = "unlock_skill_switch"
		else
			hightlight_color = tweak_data.screen_colors.important_1
			row_item_color = tweak_data.screen_colors.important_2
		end
		self:create_item(node, {
			name = skill_switch,
			text_id = data.unlocked and managers.skilltree:get_skill_switch_name(skill_switch, true) or managers.localization:to_upper_text("menu_st_locked_skill_switch"),
			enabled = unlocked or can_unlock,
			disabled_color = row_item_color,
			localize = false,
			callback = callback,
			hightlight_color = hightlight_color,
			row_item_color = row_item_color
		})
	end
	self:create_divider(node, "back_div")
	self:add_back_button(node)
	node:set_default_item_name(1)
	return node
end

function SkillSwitchInitiator:refresh_node(node, data)
	local selected_item = node:selected_item() and node:selected_item():name()
	node = self:modify_node(node, data)
	if selected_item then
		node:select_item(selected_item)
	end
	return node
end

function SkillSwitchInitiator:create_item(node, params)
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	node:add_item(new_item)
end

function SkillSwitchInitiator:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		size = size or 8,
		color = color
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function SkillSwitchInitiator:add_back_button(node)
	node:delete_item("back")
	local params = {
		name = "back",
		text_id = "menu_back",
		visible_callback = "is_pc_controller",
		align = "right",
		previous_node = true
	}
	local new_item = node:create_item(nil, params)
	node:add_item(new_item)
end

function MenuCallbackHandler:unlock_skill_switch(item)
	local spending_cost = managers.money:get_unlock_skill_switch_spending_cost(item:parameters().name)
	local offshore_cost = managers.money:get_unlock_skill_switch_offshore_cost(item:parameters().name)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_unlock_skill_switch_title")
	local cost_text = ""
	if spending_cost ~= 0 and offshore_cost ~= 0 then
		cost_text = managers.localization:text("dialog_unlock_skill_switch_spending_offshore", {
			spending = managers.experience:cash_string(spending_cost),
			offshore = managers.experience:cash_string(offshore_cost)
		})
	elseif spending_cost ~= 0 then
		cost_text = managers.localization:text("dialog_unlock_skill_switch_spending", {
			spending = managers.experience:cash_string(spending_cost)
		})
	elseif offshore_cost ~= 0 then
		cost_text = managers.localization:text("dialog_unlock_skill_switch_offshore", {
			offshore = managers.experience:cash_string(offshore_cost)
		})
	else
		cost_text = managers.localization:text("dialog_unlock_skill_switch_free")
	end
	dialog_data.text = managers.localization:text("dialog_unlock_skill_switch", {cost_text = cost_text})
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	
	function yes_button.callback_func()
		managers.skilltree:on_skill_switch_unlocked(item:parameters().name)
		self:refresh_node()
	end
	
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	
	function no_button.callback_func()
		self:refresh_node()
	end
	
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:set_active_skill_switch(item)
	managers.skilltree:switch_skills(item:parameters().name)
	self:refresh_node()
end

function MenuCallbackHandler:has_installed_mods()
	return not self:is_console() and table.size(DB:mods()) > 0
end

ModMenuCreator = ModMenuCreator or class()

function ModMenuCreator:modify_node(original_node, data)
	local node = original_node
	self:create_mod_menu(node)
	return node
end

function ModMenuCreator:create_mod_menu(node)
	node:clean_items()
	local sorted_mods = {}
	local mods = {}
	local conflicted_content = {}
	local modded_content = {}
	local id_key = function(path)
		return Idstring(path):key()
	end
	for mod_name, mod_data in pairs(DB:mods()) do
		table.insert(sorted_mods, mod_name)
		mods[mod_name] = {
			content = {},
			conflicted = {}
		}
		for _, path in ipairs(mod_data.files or {}) do
			table.insert(mods[mod_name].content, path)
			modded_content[id_key(path)] = modded_content[id_key(path)] or {}
			table.insert(modded_content[id_key(path)], mod_name)
			if #modded_content[id_key(path)] == 2 then
				conflicted_content[id_key(path)] = modded_content[id_key(path)]
			end
		end
		table.sort(mods[mod_name].content)
	end
	for idk, conflicted_mods in pairs(conflicted_content) do
		for _, mod_name in ipairs(conflicted_mods) do
			mods[mod_name].conflicted[idk] = conflicted_mods
		end
	end
	table.sort(sorted_mods)
	local list_of_mods = {}
	local mod_item
	for _, mod_name in ipairs(sorted_mods) do
		local conflicts = table.size(mods[mod_name].conflicted) > 0
		mod_item = self:create_item(node, {
			name = mod_name,
			text_id = mod_name,
			localize = false,
			enabled = true,
			hightlight_color = conflicts and tweak_data.screen_colors.important_1,
			row_item_color = conflicts and tweak_data.screen_colors.important_2
		})
	end
	self:add_back_button(node)
	node:parameters().mods = mods
	node:parameters().sorted_mods = sorted_mods
	node:parameters().conflicted_content = conflicted_content
	node:parameters().modded_content = modded_content
end

function ModMenuCreator:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		size = size or 8,
		color = color
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function ModMenuCreator:create_item(node, params)
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	node:add_item(new_item)
end

function ModMenuCreator:create_toggle(node, params)
	local data_node = {
		type = "MenuItemToggleWithIcon",
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
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	node:add_item(new_item)
	return new_item
end

function ModMenuCreator:add_back_button(node)
	node:delete_item("back")
	local params = {
		name = "back",
		text_id = "menu_back",
		visible_callback = "is_pc_controller",
		back = true,
		previous_node = true
	}
	local new_item = node:create_item(nil, params)
	node:add_item(new_item)
end

function MenuCallbackHandler:save_mod_changes(node)
end

function MenuCallbackHandler:mod_option_toggle_enabled(item)
	print("mod_option_toggle_enabled", "mod", item:name(), "status", item:value())
	local enabled = item:value() == "on"
	DB:set_mod_enabled(item:name(), enabled)
end

MenuCrimeNetChallengeInitiator = MenuCrimeNetChallengeInitiator or class(MenuCrimeNetGageAssignmentInitiator)

function MenuCrimeNetChallengeInitiator:modify_node(original_node, data)
	local node, first_item = self:setup_node(original_node)
	if not managers.challenge:visited_crimenet() then
		node:set_default_item_name("_introduction")
		node:select_item("_introduction")
		managers.menu:active_menu().logic:trigger_item(false, node:item("_introduction"))
		managers.challenge:visit_crimenet()
	else
		node:set_default_item_name("_summary")
		node:select_item("_summary")
		managers.menu:active_menu().logic:trigger_item(false, node:item("_summary"))
	end
	return node
end

function MenuCrimeNetChallengeInitiator:refresh_node(node)
	local _, first_item = self:setup_node(node)
	if not node:selected_item() or not node:item(node:selected_item():name()) then
		node:set_default_item_name("_summary")
		node:select_item("_summary")
		managers.menu:active_menu().logic:trigger_item(false, node:item("_summary"))
	end
	return node
end

function MenuCallbackHandler:is_current_challenge(item)
	local active_node_gui = managers.menu:active_menu().renderer:active_node_gui()
	if active_node_gui and active_node_gui.get_contact_info then
		return active_node_gui:get_contact_info() == item:name() or managers.challenge:is_challenge_completed(item:name()) or managers.challenge:is_challenge_rewarded(item:name())
	end
	return false
end

function MenuCrimeNetChallengeInitiator:setup_node(node)
	node:clean_items()
	self:create_divider(node, 1, managers.localization:text("menu_gage_assignment_div_menu"), nil, tweak_data.screen_colors.text)
	self:create_item(node, {
		id = "_introduction",
		name_localized = managers.localization:text("menu_challenge_introduction_title")
	})
	self:create_item(node, {
		id = "_summary",
		name_localized = managers.localization:text("menu_challenge_summary_title")
	})
	self:create_divider(node, 2)
	local first_item
	if not managers.challenge:is_retrieving() and managers.challenge:is_validated() then
		local challenges = {}
		local categories = {}
		local category
		local current_timestamp = managers.challenge:get_timestamp()
		local timestamp, interval, expire_timestamp, expire_time
		for assignment, data in pairs(managers.challenge:get_all_active_challenges()) do
			timestamp = data.timestamp
			interval = data.interval
			expire_timestamp = interval + timestamp
			expire_time = expire_timestamp - current_timestamp
			if 0 <= expire_time then
				category = data.category or "daily"
				table.insert(categories, category)
				challenges[category] = challenges[category] or {}
				table.insert(challenges[category], data)
			end
		end
		categories = table.list_union(categories)
		table.sort(categories, function(x, y)
			return challenges[x][1].interval < challenges[y][1].interval
		end)
		local node_data
		local selected_item = node:selected_item() and node:selected_item():name()
		for _, category in ipairs(categories) do
			self:create_divider(node, category, managers.localization:text("menu_challenge_div_cat_" .. category), nil, tweak_data.screen_colors.text)
			node_data = {}
			local hightlight_color, row_item_color, marker_color, icon, icon_rotation, icon_visible_callback
			for assignment, challenge in ipairs(challenges[category]) do
				hightlight_color = challenge.rewarded and tweak_data.screen_colors.text:with_alpha(0.5) or challenge.completed and tweak_data.screen_colors.challenge_completed_color
				row_item_color = challenge.rewarded and tweak_data.screen_colors.text:with_alpha(0.5) or challenge.completed and tweak_data.screen_colors.challenge_completed_color
				marker_color = challenge.rewarded and tweak_data.screen_colors.text:with_alpha(0.5) or challenge.completed and tweak_data.screen_colors.challenge_completed_color:with_alpha(0.15)
				icon = selected_item ~= challenge.id and (challenge.rewarded and "guis/textures/menu_singletick" or challenge.completed and "guis/textures/pd2/icon_reward") or nil
				icon_rotation = selected_item ~= challenge.id and (challenge.rewarded and 360 or challenge.completed and 360) or nil
				icon_visible_callback = "is_current_challenge"
				table.insert(node_data, {
					name_localized = challenge.name_s or managers.localization:text(challenge.name_id),
					interval = challenge.interval,
					id = challenge.id,
					completed = challenge.completed,
					hightlight_color = hightlight_color,
					row_item_color = row_item_color,
					marker_color = marker_color,
					icon = icon,
					icon_rotation = icon_rotation,
					icon_visible_callback = icon_visible_callback
				})
			end
			table.sort(node_data, function(x, y)
				if x.completed ~= y.completed then
					return x.completed
				end
				if x.interval ~= y.interval then
					return x.interval < y.interval
				end
				return x.name_localized < y.name_localized
			end)
			for assignment, data in ipairs(node_data) do
				self:create_item(node, data)
				first_item = first_item or data.id
			end
		end
	else
		self:create_divider(node, "retrieving", managers.localization:text("menu_challenge_still_retrieving"), nil, tweak_data.screen_colors.text)
	end
	local params = {
		name = "back",
		text_id = "menu_back",
		previous_node = "true",
		visible_callback = "is_pc_controller",
		align = "left",
		last_item = "true",
		gui_node_custom = "true",
		pd2_corner = "true"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	first_item = first_item or "back"
	return node, first_item
end

function MenuCallbackHandler:update_challenge_menu_node()
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	if managers.menu:active_menu().logic:selected_node():parameters().name ~= "crimenet_contract_challenge" then
		return false
	end
	MenuCallbackHandler:refresh_node()
end

function MenuCallbackHandler:give_challenge_reward(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	local id = item:parameters().name
	local rewards = managers.challenge:on_give_rewards(id)
	if rewards then
		managers.menu:active_menu().logic:refresh_node()
		for _, reward in ipairs(rewards) do
			if reward.choose_weapon_reward then
				managers.menu:open_node("choose_weapon_reward")
			end
		end
	end
end

MenuChooseWeaponRewardInitiator = MenuChooseWeaponRewardInitiator or class()

function MenuChooseWeaponRewardInitiator:modify_node(original_node, data)
	local node = original_node
	if data and data.reward_data then
		node:parameters().reward_data = data.reward_data
	end
	local all_dlc_data = Global.dlc_manager.all_dlc_data
	local weapon_tweak = tweak_data.weapon
	local x_id, y_id, x_level, y_level, x_unlocked, y_unlocked, x_skill, y_skill, x_gv, y_gv, x_sn, y_sn
	local primaries = managers.blackmarket:get_weapon_category("primaries")
	local secondaries = managers.blackmarket:get_weapon_category("secondaries")
	local items = {}
	local chk_unlocked_func = function(weapon)
		return not not weapon.unlocked
	end
	
	local function chk_dlc_func(weapon)
		x_id = weapon.weapon_id
		x_gv = weapon_tweak[x_id].global_value
		if all_dlc_data[x_gv] and all_dlc_data[x_gv].app_id and not managers.dlc:is_dlc_unlocked(x_gv) then
			return false
		end
		return true
	end
	
	local chk_dropable_func = function(weapon)
		local loot_table = managers.blackmarket:get_lootdropable_mods_by_weapon_id(weapon.weapon_id, nil, true)
		return loot_table and 0 < #loot_table or false
	end
	
	local function chk_parent_func(weapon)
		return weapon_tweak[weapon.weapon_id] and not weapon_tweak[weapon.weapon_id].parent_weapon_id
	end
	
	local loot_table, data
	for i, category_data in ipairs({primaries, secondaries}) do
		for _, weapon_data in ipairs(category_data) do
			if chk_dlc_func(weapon_data) and chk_parent_func(weapon_data) then
				loot_table = managers.blackmarket:get_lootdropable_mods_by_weapon_id(weapon_data.weapon_id, nil, true)
				if 0 < #loot_table then
					data = deep_clone(weapon_data)
					data.loot_table = loot_table
					for _, category in ipairs(weapon_tweak[weapon_data.weapon_id].categories) do
						category = tweak_data.gui.buy_weapon_category_groups[category] or category
						items[category] = items[category] or {}
						table.insert(items[category], data)
					end
				end
			end
		end
	end
	
	local function sort_func(x, y)
		x_unlocked = x.unlocked
		y_unlocked = y.unlocked
		if x_unlocked ~= y_unlocked then
			return x_unlocked
		end
		x_id = x.weapon_id
		y_id = y.weapon_id
		x_gv = weapon_tweak[x_id].global_value
		y_gv = weapon_tweak[y_id].global_value
		x_sn = x_gv and tweak_data.lootdrop.global_values[x_gv].sort_number or 0
		y_sn = y_gv and tweak_data.lootdrop.global_values[y_gv].sort_number or 0
		if x_sn ~= y_sn then
			return x_sn < y_sn
		end
		x_skill = x.skill_based
		y_skill = y.skill_based
		if x_skill ~= y_skill then
			return y_skill
		end
		x_level = x.level or 0
		y_level = y.level or 0
		if x_level ~= y_level then
			return x_level < y_level
		end
		return x_id < y_id
	end
	
	local category_list = {}
	for category, data in pairs(items) do
		table.sort(data, sort_func)
		table.insert(category_list, category)
	end
	table.sort(category_list)
	node:parameters().first_weapons = {}
	for index, category in ipairs(category_list) do
		node:parameters().first_weapons[category] = items[category][1].weapon_id
	end
	node:parameters().category_list = category_list
	node:parameters().weapon_items = items
	node = self:setup_node(node)
	node:set_default_item_name("choose_weapon_category")
	node:select_item("choose_weapon_category")
	return node
end

function MenuChooseWeaponRewardInitiator:refresh_node(node)
	self:setup_node(node)
	return node
end

function MenuChooseWeaponRewardInitiator:setup_node(node)
	local listed_category = node:parameters().listed_category or "assault_rifle"
	local listed_weapon = node:parameters().listed_weapon or "amcar"
	local listed_global_value = node:parameters().listed_global_value or "all"
	node:parameters().listed_global_value = listed_global_value
	node:parameters().listed_weapon = listed_weapon
	node:parameters().listed_category = listed_category
	node:parameters().block_back = true
	node:parameters().clicked_category = false
	node:clean_items()
	if not node:item("divider_end") then
		local category_list = node:parameters().category_list
		local items = node:parameters().weapon_items
		local params = {
			name = "choose_weapon_category",
			text_id = "menu_challenge_choose_weapon_category",
			callback = "choice_challenge_choose_weapon_category",
			filter = true,
			text_offset = 75
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		table.insert(data_node, {
			_meta = "option",
			no_text = true,
			localize = false,
			text_id = "",
			value = category_list[#category_list] .. "#"
		})
		for index, category in ipairs(category_list) do
			table.insert(data_node, {
				_meta = "option",
				localize = false,
				text_id = managers.localization:to_upper_text("menu_" .. category),
				value = category
			})
			node:parameters().first_weapons[category] = items[category][1].weapon_id
		end
		table.insert(data_node, {
			_meta = "option",
			no_text = true,
			localize = false,
			text_id = "",
			value = category_list[1] .. "#"
		})
		local new_item = node:create_item(data_node, params)
		new_item:set_value(listed_category)
		node:add_item(new_item)
		local current_weapon_data
		local params = {
			name = "choose_weapon",
			text_id = "menu_challenge_choose_weapon",
			callback = "choice_challenge_choose_weapon",
			filter = true,
			text_offset = 75
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		table.insert(data_node, {
			_meta = "option",
			no_text = true,
			localize = false,
			text_id = "",
			value = items[listed_category][#items[listed_category]].weapon_id .. "#"
		})
		for index, weapon_data in ipairs(items[listed_category]) do
			table.insert(data_node, {
				_meta = "option",
				localize = false,
				text_id = managers.weapon_factory:get_weapon_name_by_weapon_id(weapon_data.weapon_id),
				value = weapon_data.weapon_id
			})
			if weapon_data.weapon_id == listed_weapon then
				current_weapon_data = weapon_data
			end
		end
		table.insert(data_node, {
			_meta = "option",
			no_text = true,
			localize = false,
			text_id = "",
			value = items[listed_category][1].weapon_id .. "#"
		})
		local new_item = node:create_item(data_node, params)
		new_item:set_value(listed_weapon)
		node:add_item(new_item)
		local weapon_data = current_weapon_data or {}
		local global_values = {}
		for _, data in pairs(weapon_data.loot_table or {}) do
			table.insert(global_values, data[2])
		end
		global_values = table.list_union(global_values)
		local x_sn, y_sn
		
		local function sort_func(x, y)
			if x == "normal" then
				return true
			elseif y == "normal" then
				return false
			end
			x_sn = tweak_data.lootdrop.global_values[x].sort_number or 0
			y_sn = tweak_data.lootdrop.global_values[y].sort_number or 0
			if x_sn ~= y_sn then
				return x_sn < y_sn
			end
			return x < y
		end
		
		table.sort(global_values, sort_func)
		local params = {
			name = "choose_global_value",
			text_id = "menu_challenge_choose_global_value",
			callback = "choice_challenge_choose_global_value",
			filter = true,
			text_offset = 75
		}
		local data_node = {
			type = "MenuItemMultiChoice"
		}
		if 1 < #global_values then
			table.insert(data_node, {
				_meta = "option",
				no_text = true,
				localize = false,
				text_id = "",
				value = global_values[#global_values] .. "#"
			})
		end
		local gv_all_text_id = #global_values == 1 and tweak_data:get_raw_value("lootdrop", "global_values", global_values[1], "name_id") or "menu_challenge_global_value_all"
		table.insert(data_node, {
			_meta = "option",
			localize = false,
			text_id = managers.localization:text(gv_all_text_id),
			value = "all"
		})
		if 1 < #global_values then
			for index, global_value in ipairs(global_values) do
				table.insert(data_node, {
					_meta = "option",
					localize = false,
					text_id = managers.localization:text(tweak_data:get_raw_value("lootdrop", "global_values", global_value, "name_id")),
					value = global_value
				})
			end
			table.insert(data_node, {
				_meta = "option",
				no_text = true,
				localize = false,
				text_id = "",
				value = "all#"
			})
		end
		node:parameters().listed_global_value = table.contains(global_values, listed_global_value) and listed_global_value or "all"
		listed_global_value = node:parameters().listed_global_value
		local new_item = node:create_item(data_node, params)
		new_item:set_value(listed_global_value)
		node:add_item(new_item)
		self:create_divider(node, "divider_end", nil, 32)
		local params = {
			name = "get_weapon_mod_reward",
			text_id = "menu_challenge_get_weapon_mod_reward",
			callback = "choice_challenge_get_weapon_mod_reward",
			filter = true,
			halign = "right",
			align = "right"
		}
		local data_node = {}
		local new_item = node:create_item(data_node, params)
		node:add_item(new_item)
	end
	return node
end

function MenuChooseWeaponRewardInitiator:create_divider(node, id, text_id, size, color, align)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		size = size or 8,
		color = color,
		halign = align,
		align = align
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
end

function MenuCallbackHandler:choice_challenge_choose_weapon_category(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	local node = managers.menu:active_menu().logic:selected_node()
	node:parameters().listed_category = string.gsub(item:value(), "#", "")
	if string.find(item:value(), "#") then
		item:set_value(string.gsub(item:value(), "#", ""))
	end
	node:parameters().clicked_category = true
	node:parameters().listed_weapon = node:parameters().first_weapons[item:value()]
	MenuCallbackHandler:refresh_node()
end

function MenuCallbackHandler:choice_challenge_choose_weapon(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	if managers.menu:active_menu().logic:selected_node():parameters().clicked_category then
		return false
	end
	managers.menu:active_menu().logic:selected_node():parameters().listed_weapon = string.gsub(item:value(), "#", "")
	if string.find(item:value(), "#") then
		item:set_value(string.gsub(item:value(), "#", ""))
	end
	MenuCallbackHandler:refresh_node()
end

function MenuCallbackHandler:choice_challenge_choose_global_value(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	if managers.menu:active_menu().logic:selected_node():parameters().clicked_category then
		return false
	end
	managers.menu:active_menu().logic:selected_node():parameters().listed_global_value = string.gsub(item:value(), "#", "")
	if string.find(item:value(), "#") then
		item:set_value(string.gsub(item:value(), "#", ""))
	end
	MenuCallbackHandler:refresh_node()
end

function MenuCallbackHandler:choice_challenge_get_weapon_mod_reward(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	local reward = {}
	local params = managers.menu:active_menu().logic:selected_node():parameters()
	if params.listed_weapon then
		if params.reward_data then
			print("managers.challenge:set_as_rewarded", unpack(params.reward_data))
			managers.challenge:set_as_rewarded(unpack(params.reward_data))
		end
		local weapon_id = managers.menu:active_menu().logic:selected_node():parameters().listed_weapon
		local global_value = managers.menu:active_menu().logic:selected_node():parameters().listed_global_value
		local entry = MenuCallbackHandler:roll_challenge_give_weapon_mod(weapon_id, global_value)
		managers.menu:active_menu().logic:selected_node():parameters().listed_weapon = nil
		if entry then
			reward.amount = 1
			reward.item_entry = entry[1]
			reward.type_items = "weapon_mods"
		end
	end
	managers.menu:active_menu().logic:selected_node():parameters().block_back = false
	managers.menu:back()
	managers.menu:show_challenge_reward(reward)
end

function MenuCallbackHandler:roll_challenge_give_weapon_mod(weapon_id, global_value)
	local loot_table, limited_loot_table = managers.blackmarket:get_lootdropable_mods_by_weapon_id(weapon_id, global_value, true)
	local my_loot_table = 0 < #limited_loot_table and limited_loot_table or loot_table
	if 0 < #my_loot_table then
		local entry = my_loot_table[math.random(#my_loot_table)]
		managers.blackmarket:add_to_inventory(entry[2] or "normal", "weapon_mods", entry[1])
		print("[MenuCallbackHandler:roll_challenge_give_weapon_mod] Drop", entry[2] or "normal", "weapon_mods", entry[1])
		return entry
	end
end
