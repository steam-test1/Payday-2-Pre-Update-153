core:import("CoreUnit")
require("lib/states/GameState")
IngameLobbyMenuState = IngameLobbyMenuState or class(GameState)
IngameLobbyMenuState.GUI_LOOTSCREEN = Idstring("guis/lootscreen/lootscreen_fullscreen")

function IngameLobbyMenuState:init(game_state_machine)
	GameState.init(self, "ingame_lobby_menu", game_state_machine)
	if managers.hud then
		self._setup = true
		managers.hud:load_hud(self.GUI_LOOTSCREEN, false, true, false, {}, nil, nil, true)
		managers.hud:hide(self.GUI_LOOTSCREEN)
	end
	self._continue_cb = callback(self, self, "_continue")
end

function IngameLobbyMenuState:setup_controller()
	if not self._controller then
		self._controller = managers.controller:create_controller("ingame_lobby_menu", managers.controller:get_default_wrapper_index(), false)
		if Network:is_server() or managers.dlc:is_trial() then
			self._controller:add_trigger("continue", self._continue_cb)
		end
		self._controller:set_enabled(true)
	end
end

function IngameLobbyMenuState:_clear_controller()
	if not self._controller then
		return
	end
	if Network:is_server() or managers.dlc:is_trial() then
		self._controller:remove_trigger("continue", self._continue_cb)
	end
	self._controller:set_enabled(false)
	self._controller:destroy()
	self._controller = nil
end

function IngameLobbyMenuState:_continue()
	self:continue()
end

function IngameLobbyMenuState:continue()
	if self:_continue_blocked() then
		return
	end
	if managers.network:session() and Network:is_server() then
		managers.network.matchmake:set_server_joinable(true)
	end
	if Global.game_settings.single_player then
		MenuCallbackHandler:_dialog_end_game_yes()
	elseif Network:is_server() or managers.dlc:is_trial() then
		MenuCallbackHandler:load_start_menu_lobby()
	else
		setup:load_start_menu()
	end
end

function IngameLobbyMenuState:_continue_blocked()
	local in_focus = managers.menu:active_menu() == self._loot_menu
	if not in_focus then
		return true
	end
	if managers.hud:showing_stats_screen() then
		return true
	end
	if managers.system_menu:is_active() then
		return true
	end
	if managers.menu_component:input_focus() == 1 then
		return true
	end
	if self._continue_block_timer > Application:time() then
		return true
	end
	return false
end

function IngameLobbyMenuState:set_controller_enabled(enabled)
	if self._controller then
	end
end

function IngameLobbyMenuState:update(t, dt)
end

function IngameLobbyMenuState:can_drop_weapon_mods()
	local plvl = managers.experience:current_level()
	local dropable_items = {}
	for item, item_tweak in pairs(tweak_data.blackmarket.weapon_mods) do
		if item_tweak.pc or item_tweak.pcs then
			local is_infamous = item_tweak.infamous or false
			local is_dlc = item_tweak.dlcs or item_tweak.dlc or false
			local got_qlvl = item_tweak.qlvl or false
			local pass_infamous = not is_infamous or infamous_success
			local pass_dlc = true
			local pass_qlvl = not got_qlvl or plvl >= got_qlvl
			local pass_max_in_inventory
			local global_value = "normal"
			if is_infamous then
				global_value = "infamous"
			elseif is_dlc then
				local dlcs = item_tweak.dlcs or {}
				if item_tweak.dlc then
					table.insert(dlcs, item_tweak.dlc)
				end
				local dlc_global_values = {}
				for _, dlc in pairs(dlcs) do
					if managers.dlc:has_dlc(dlc) then
						table.insert(dlc_global_values, dlc)
					end
				end
				if 0 < #dlc_global_values then
					global_value = dlc_global_values[math.random(#dlc_global_values)]
				else
					pass_dlc = false
				end
			end
			local amount_in_inventory = managers.blackmarket:get_item_amount(global_value, "weapon_mods", item, true)
			pass_max_in_inventory = not item_tweak.max_in_inventory or amount_in_inventory < item_tweak.max_in_inventory
			if pass_infamous and pass_dlc and pass_qlvl and pass_max_in_inventory then
				table.insert(dropable_items, true)
			end
		end
	end
	return 0 < #dropable_items
end

function IngameLobbyMenuState:new_fake_loot_pc(debug_pc, can_drop_weapon_mods)
	local sum = 0
	local to_drop = {
		colors = 1,
		textures = 1,
		materials = 1,
		masks = 1,
		cash = 3
	}
	if can_drop_weapon_mods then
		to_drop.weapon_mods = 2
	end
	local WEIGHTS = tweak_data.lootdrop.WEIGHTED_TYPE_CHANCE[(debug_pc or managers.experience:level_to_stars()) * 10]
	for type in pairs(to_drop) do
		sum = sum + WEIGHTS[type]
	end
	local variant = math.random(sum)
	for type, card in pairs(to_drop) do
		variant = variant - WEIGHTS[type]
		if variant <= 0 then
			return card
		end
	end
	return 1
end

function IngameLobbyMenuState:fake_loot_pc(debug_pc)
	local max_pc = debug_pc or math.ceil(math.min(managers.experience:current_level() / 10, managers.job:current_job_and_difficulty_stars()))
	local chance = 0.85 / math.max(2 ^ (#tweak_data.lootdrop.STARS[max_pc].pcs - 1), 1)
	chance = chance * managers.player:upgrade_value("player", "passive_loot_drop_multiplier", 1)
	for i = 1, 5 do
		if math.rand(1) < 0.2 then
			chance = chance + chance
		end
	end
	for i = 1, #tweak_data.lootdrop.STARS[max_pc].pcs do
		if chance > math.rand(1) then
			return math.ceil(tweak_data.lootdrop.STARS[max_pc].pcs[i] / 10)
		end
		chance = chance + chance
	end
	return 0
end

function IngameLobbyMenuState:at_enter()
	managers.music:stop()
	managers.platform:set_presence("Mission_end")
	managers.platform:set_rich_presence(Global.game_settings.single_player and "SPEnd" or "MPEnd")
	managers.hud:remove_updator("point_of_no_return")
	print("[IngameLobbyMenuState:at_enter()]")
	if managers.network:session() then
		if Network:is_server() then
			managers.network.matchmake:set_server_state("in_lobby")
			managers.network:session():set_state("in_lobby")
		else
			managers.network:session():send_to_peers_loaded("set_peer_entered_lobby")
		end
	end
	managers.mission:pre_destroy()
	self._continue_block_timer = Application:time() + 0.5
	managers.menu:close_menu()
	if managers.job:stage_success() then
		managers.job:next_stage()
	end
	if managers.job:is_job_finished() then
		if not self._setup then
			self._setup = true
			managers.hud:load_hud(self.GUI_LOOTSCREEN, false, true, false, {}, nil, nil, true)
		end
		managers.hud:show(self.GUI_LOOTSCREEN)
		managers.menu:open_menu("loot_menu")
		self._loot_menu = managers.menu:get_menu("loot_menu")
		managers.menu_component:set_max_lines_game_chat(6)
		managers.menu_component:pre_set_game_chat_leftbottom(0, 0)
		self._lootdrop_data = {}
		managers.lootdrop:new_make_drop(self._lootdrop_data)
		local can_drop_weapon_mods = self:can_drop_weapon_mods()
		local global_values = {
			normal = 1,
			superior = 2,
			exceptional = 3,
			infamous = 4
		}
		local peer = managers.network:session() and managers.network:session():local_peer() or false
		local global_value = global_values[self._lootdrop_data.global_value] or 1
		local item_category = self._lootdrop_data.type_items
		local item_id = self._lootdrop_data.item_entry
		local max_pc = self._lootdrop_data.total_stars
		local item_pc = self._lootdrop_data.joker and 0 or math.ceil(self._lootdrop_data.item_payclass / 10)
		local card_left_pc = self:new_fake_loot_pc(nil, can_drop_weapon_mods)
		local card_right_pc = self:new_fake_loot_pc(nil, can_drop_weapon_mods)
		local lootdrop_data = {
			peer,
			self._lootdrop_data.global_value,
			item_category,
			item_id,
			max_pc,
			item_pc,
			card_left_pc,
			card_right_pc
		}
		managers.hud:feed_lootdrop_hud(lootdrop_data)
		if not Global.game_settings.single_player and managers.network:session() then
			managers.network:session():send_to_peers("feed_lootdrop", global_value, item_category, item_id, max_pc, item_pc, card_left_pc, card_right_pc)
		end
	elseif Network:is_client() then
		if not self._setup then
			self._setup = true
			managers.hud:load_hud(self.GUI_LOOTSCREEN, false, true, false, {}, nil, nil, true)
		end
		managers.hud:hide(self.GUI_LOOTSCREEN)
		managers.menu:open_menu("loot_menu")
		self._loot_menu = managers.menu:get_menu("loot_menu")
		managers.menu_component:set_max_lines_game_chat(6)
		managers.menu_component:pre_set_game_chat_leftbottom(0, 0)
	end
	if (Network:is_server() or managers.dlc:is_trial()) and not managers.job:is_job_finished() then
		if managers.network:session() and Network:is_server() then
			managers.network.matchmake:set_server_joinable(true)
		end
		if not managers.job:stage_success() then
			if managers.job:is_current_job_professional() then
				MenuCallbackHandler:load_start_menu_lobby()
			else
				MenuCallbackHandler:retry_job_stage()
			end
		else
			MenuCallbackHandler:on_stage_success()
			MenuCallbackHandler:lobby_start_the_game()
		end
	end
end

function IngameLobbyMenuState:at_exit()
	print("[IngameLobbyMenuState:at_exit()]")
	if managers.job:is_job_finished() then
		managers.menu:close_menu("loot_menu")
		managers.hud:hide(self.GUI_LOOTSCREEN)
	end
	managers.menu_component:hide_game_chat_gui()
end

function IngameLobbyMenuState:on_server_left()
	Application:debug("IngameLobbyMenuState:on_server_left()")
	managers.menu_component:set_lootdrop_state("on_server_left")
end

function IngameLobbyMenuState:on_kicked()
	Application:debug("IngameLobbyMenuState:on_kicked()")
	managers.menu_component:set_lootdrop_state("on_kicked")
end

function IngameLobbyMenuState:on_disconnected()
	Application:debug("IngameLobbyMenuState:on_disconnected()")
	managers.menu_component:set_lootdrop_state("on_disconnected")
end
