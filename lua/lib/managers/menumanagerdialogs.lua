function MenuManager:show_retrieving_servers_dialog()
	local dialog_data = {}
	
	dialog_data.title = managers.localization:text("dialog_retrieving_servers_title")
	dialog_data.text = managers.localization:text("dialog_wait")
	dialog_data.id = "find_server"
	dialog_data.no_buttons = true
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_get_world_list_dialog(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_logging_in")
	dialog_data.text = managers.localization:text("dialog_wait")
	dialog_data.id = "get_world_list"
	local cancel_button = {}
	cancel_button.text = managers.localization:text("dialog_cancel")
	cancel_button.callback_func = params.cancel_func
	dialog_data.button_list = {cancel_button}
	dialog_data.indicator = true
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_game_permission_changed_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_game_permission_changed")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_too_low_level()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_too_low_level")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_too_low_level_ovk145()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_too_low_level_ovk145")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_does_not_own_heist()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_does_not_own_heist")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_does_not_own_heist_info(heist, player)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_does_not_own_heist_info", {
		HEIST = string.upper(heist),
		PLAYER = string.upper(player)
	})
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_failed_joining_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_err_failed_joining_lobby")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_cant_join_from_game_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_err_cant_join_from_game")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_game_started_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_game_started")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_joining_lobby_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_joining_lobby_title")
	dialog_data.text = managers.localization:text("dialog_wait")
	dialog_data.id = "join_server"
	dialog_data.no_buttons = true
	dialog_data.indicator = true
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_no_connection_to_game_servers_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_no_connection_to_game_servers")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_person_joining(id, nick)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_dropin_title", {
		USER = string.upper(nick)
	})
	dialog_data.text = managers.localization:text("dialog_wait") .. " 0%"
	dialog_data.id = "user_dropin" .. id
	dialog_data.no_buttons = true
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_corrupt_dlc()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_fail_load_dlc_corrupt")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:close_person_joining(id)
	managers.system_menu:close("user_dropin" .. id)
end

function MenuManager:update_person_joining(id, progress_percentage)
	local dlg = managers.system_menu:get_dialog("user_dropin" .. id)
	if dlg then
		dlg:set_text(managers.localization:text("dialog_wait") .. " " .. tostring(progress_percentage) .. "%")
	end
end

function MenuManager:show_kick_peer_dialog()
end

function MenuManager:show_peer_kicked_dialog(params)
	local title = Global.on_remove_peer_message and "dialog_information_title" or "dialog_mp_kicked_out_title"
	local dialog_data = {}
	dialog_data.title = managers.localization:text(title)
	dialog_data.text = managers.localization:text(Global.on_remove_peer_message or "dialog_mp_kicked_out_message")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	ok_button.callback_func = params and params.ok_func
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
	Global.on_remove_peer_message = nil
end

function MenuManager:show_default_option_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_default_options_title")
	dialog_data.text = managers.localization:text("dialog_default_options_message")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	
	function yes_button.callback_func()
		managers.user:reset_setting_map()
	end
	
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_err_not_signed_in_dialog()
	local dialog_data = {}
	dialog_data.title = string.upper(managers.localization:text("dialog_error_title"))
	dialog_data.text = managers.localization:text("dialog_err_not_signed_in")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	
	function ok_button.callback_func()
		self._showing_disconnect_message = nil
	end
	
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_mp_disconnected_internet_dialog(params)
	local dialog_data = {}
	dialog_data.title = string.upper(managers.localization:text("dialog_warning_title"))
	dialog_data.text = managers.localization:text("dialog_mp_disconnected_internet")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	ok_button.callback_func = params.ok_func
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_err_no_chat_parental_control()
	local dialog_data = {}
	dialog_data.title = string.upper(managers.localization:text("dialog_information_title"))
	dialog_data.text = managers.localization:text("dialog_no_chat_parental_control")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_err_under_age()
	local dialog_data = {}
	dialog_data.title = string.upper(managers.localization:text("dialog_information_title"))
	dialog_data.text = managers.localization:text("dialog_age_restriction")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_waiting_for_server_response(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_waiting_for_server_response_title")
	dialog_data.text = managers.localization:text("dialog_wait")
	dialog_data.id = "waiting_for_server_response"
	dialog_data.indicator = true
	local cancel_button = {}
	cancel_button.text = managers.localization:text("dialog_cancel")
	cancel_button.callback_func = params.cancel_func
	dialog_data.button_list = {cancel_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_request_timed_out_dialog()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_request_timed_out_title")
	dialog_data.text = managers.localization:text("dialog_request_timed_out_message")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_restart_game_dialog(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_show_restart_game_message")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_no_invites_message()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text("dialog_mp_no_invites_message")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_invite_wrong_version_message()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text("dialog_mp_invite_wrong_version_message")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_invite_join_message(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text("dialog_mp_invite_join_message")
	dialog_data.id = "invite_join_message"
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	ok_button.callback_func = params.ok_func
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_pending_invite_message(params)
	local dialog_data = {}
	dialog_data.title = string.upper(managers.localization:text("dialog_information_title"))
	dialog_data.text = managers.localization:text("dialog_mp_pending_invite_short_message")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	ok_button.callback_func = params.ok_func
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_NPCommerce_open_fail(params)
	local dialog_data = {}
	dialog_data.title = string.upper(managers.localization:text("dialog_error_title"))
	dialog_data.text = managers.localization:text("dialog_npcommerce_fail_open")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_NPCommerce_checkout_fail(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_npcommerce_checkout_fail")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_waiting_NPCommerce_open(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_wait")
	dialog_data.text = managers.localization:text("dialog_npcommerce_opening")
	dialog_data.id = "waiting_for_NPCommerce_open"
	dialog_data.no_upper = true
	dialog_data.no_buttons = true
	dialog_data.indicator = true
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_NPCommerce_browse_fail()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_npcommerce_browse_fail")
	dialog_data.no_upper = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_NPCommerce_browse_success()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_transaction_successful")
	dialog_data.text = managers.localization:text("dialog_npcommerce_need_install")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_new_message_dialog(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text(params.title)
	dialog_data.text = managers.localization:text(params.text, {
		player = tostring(managers.network.account:username() or managers.blackmarket:get_preferred_character_real_name())
	})
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	dialog_data.texture = "guis/textures/pd2/feature_crimenet_heat"
	dialog_data.text_blend_mode = "add"
	dialog_data.use_text_formating = true
	dialog_data.w = 620
	dialog_data.h = 532
	dialog_data.image_w = 64
	dialog_data.image_h = 64
	dialog_data.image_valign = "top"
	dialog_data.title_font = tweak_data.menu.pd2_medium_font
	dialog_data.title_font_size = tweak_data.menu.pd2_medium_font_size
	dialog_data.font = tweak_data.menu.pd2_small_font
	dialog_data.font_size = tweak_data.menu.pd2_small_font_size
	managers.system_menu:show_new_unlock(dialog_data)
end

function MenuManager:show_announce_crimenet_heat()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("menu_feature_heat_title")
	dialog_data.text = managers.localization:text("menu_feature_heat_desc", {
		player = tostring(managers.network.account:username() or managers.blackmarket:get_preferred_character_real_name())
	})
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	dialog_data.texture = "guis/textures/pd2/feature_crimenet_heat"
	dialog_data.text_blend_mode = "add"
	dialog_data.use_text_formating = true
	dialog_data.w = 620
	dialog_data.h = 532
	dialog_data.image_w = 64
	dialog_data.image_h = 64
	dialog_data.image_valign = "top"
	dialog_data.title_font = tweak_data.menu.pd2_medium_font
	dialog_data.title_font_size = tweak_data.menu.pd2_medium_font_size
	dialog_data.font = tweak_data.menu.pd2_small_font
	dialog_data.font_size = tweak_data.menu.pd2_small_font_size
	managers.system_menu:show_new_unlock(dialog_data)
end

function MenuManager:show_accept_gfx_settings_dialog(func)
	local count = 10
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_accept_changes_title")
	dialog_data.text = managers.localization:text("dialog_accept_changes", {TIME = count})
	dialog_data.id = "accept_changes"
	local cancel_button = {}
	cancel_button.text = managers.localization:text("dialog_cancel")
	cancel_button.callback_func = func
	cancel_button.cancel_button = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button, cancel_button}
	dialog_data.counter = {
		1,
		function()
			count = count - 1
			if count < 0 then
				func()
				managers.system_menu:close(dialog_data.id)
			else
				local dlg = managers.system_menu:get_dialog(dialog_data.id)
				if dlg then
					dlg:set_text(managers.localization:text("dialog_accept_changes", {TIME = count}), true)
				end
			end
		end
	}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_key_binding_collision(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_key_binding_collision", params)
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_key_binding_forbidden(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_key_binding_forbidden", params)
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_new_item_gained(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_new_unlock_title")
	dialog_data.text = managers.localization:text("dialog_new_unlock_" .. params.category, params)
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	local texture, render_template, shapes
	local guis_catalog = "guis/"
	local category = params.data[1]
	local id = params.data[2]
	if category == "weapon_mods" then
		local part_id = id
		local bundle_folder = tweak_data.blackmarket.weapon_mods[part_id] and tweak_data.blackmarket.weapon_mods[part_id].texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		texture = guis_catalog .. "textures/pd2/blackmarket/icons/mods/" .. tostring(part_id)
	elseif category == "colors" then
		local color_tweak_data = _G.tweak_data.blackmarket.colors[id]
		local shape_template = {
			type = "bitmap",
			texture = "guis/textures/pd2/blackmarket/icons/colors/color_bg",
			color = tweak_data.screen_colors.text,
			w = 128,
			h = 128,
			layer = 1,
			x = 0.5,
			y = 0.5
		}
		shapes = {}
		table.insert(shapes, shape_template)
		shape_template = deep_clone(shape_template)
		shape_template.layer = 0
		shape_template.color = color_tweak_data.colors[1]
		shape_template.texture = "guis/textures/pd2/blackmarket/icons/colors/color_01"
		table.insert(shapes, shape_template)
		shape_template = deep_clone(shape_template)
		shape_template.color = color_tweak_data.colors[2]
		shape_template.texture = "guis/textures/pd2/blackmarket/icons/colors/color_02"
		table.insert(shapes, shape_template)
	elseif category == "primaries" or category == "secondaries" then
		local weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(id)
		if weapon_id then
			local bundle_folder = tweak_data.weapon[weapon_id] and tweak_data.weapon[weapon_id].texture_bundle_folder
			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end
			local texture_name = tweak_data.weapon[weapon_id].texture_name or tostring(weapon_id)
			texture = guis_catalog .. "textures/pd2/blackmarket/icons/weapons/" .. texture_name
		end
	elseif category == "textures" then
		texture = _G.tweak_data.blackmarket.textures[id].texture
		render_template = Idstring("VertexColorTexturedPatterns")
	elseif category == "announcements" then
	else
		local bundle_folder = tweak_data.blackmarket[category] and tweak_data.blackmarket[category][id] and tweak_data.blackmarket[category][id].texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		texture = guis_catalog .. "textures/pd2/blackmarket/icons/" .. tostring(category) .. "/" .. tostring(id)
	end
	dialog_data.texture = texture
	dialog_data.render_template = render_template
	dialog_data.shapes = shapes
	dialog_data.sound_event = params.sound_event
	managers.system_menu:show_new_unlock(dialog_data)
end

function MenuManager:show_mask_mods_available(params)
	local dialog_data = {}
	dialog_data.title = ""
	dialog_data.text = params.text_block
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	dialog_data.text_blend_mode = "add"
	dialog_data.use_text_formating = true
	dialog_data.text_formating_color = Color.white
	dialog_data.text_formating_color_table = params.color_table
	managers.system_menu:show_new_unlock(dialog_data)
end

function MenuManager:show_weapon_mods_available(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("bm_menu_available_mods")
	dialog_data.text = params.text_block
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	local guis_catalog = "guis/"
	local weapon_id = params.weapon_id
	local bundle_folder = tweak_data.weapon[weapon_id] and tweak_data.weapon[weapon_id].texture_bundle_folder
	if bundle_folder then
		guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
	end
	local texture_name = tweak_data.weapon[weapon_id].texture_name or tostring(weapon_id)
	dialog_data.texture = guis_catalog .. "textures/pd2/blackmarket/icons/weapons/" .. texture_name
	dialog_data.text_blend_mode = "add"
	dialog_data.use_text_formating = true
	dialog_data.text_formating_color = Color.white
	dialog_data.text_formating_color_table = params.color_table
	managers.system_menu:show_new_unlock(dialog_data)
end

function MenuManager:show_confirm_skillpoints(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_skills_place_title")
	dialog_data.text = managers.localization:text(params.text_string, {
		skill = params.skill_name_localized,
		points = params.points,
		remaining_points = params.remaining_points,
		cost = managers.experience:cash_string(params.cost)
	})
	dialog_data.focus_button = 1
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_respec_skilltree(params)
	local tree_name = managers.localization:text(tweak_data.skilltree.trees[params.tree].name_id)
	local cost = managers.money:get_skilltree_tree_respec_cost(params.tree)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_skills_respec_title")
	dialog_data.text = managers.localization:text("dialog_respec_skilltree", {
		tree = tree_name,
		cost = managers.experience:cash_string(cost)
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	dialog_data.no_upper = true
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_skilltree_reseted()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_skills_reseted_title")
	dialog_data.text = managers.localization:text("dialog_skilltree_reseted")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_infamypoints(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_skills_place_title")
	dialog_data.text = managers.localization:text(params.text_string, {
		item = params.infamy_item,
		points = params.points,
		remaining_points = params.remaining_points
	})
	dialog_data.focus_button = 1
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_infamytree_reseted()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_infamy_reseted_title")
	dialog_data.text = managers.localization:text("dialog_infamytree_reseted")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_sell_no_slot(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_mask_sell_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_item", {
		item = params.name
	}) .. [[


]] .. managers.localization:text("dialog_blackmarket_slot_item_sell", {
		money = params.money
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_mask_remove(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_crafted_sell_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_slot_item", {
		slot = params.slot,
		item = params.name
	}) .. [[


]] .. managers.localization:text("dialog_blackmarket_slot_mask_remove", {
		suffix = params.skip_money and "" or " " .. managers.localization:text("dialog_blackmarket_slot_mask_remove_suffix", {
			money = params.money
		})
	})
	if params.mods_readded and #params.mods_readded > 0 then
		dialog_data.text = dialog_data.text .. "\n"
		for _, mod_id in ipairs(params.mods_readded) do
			dialog_data.text = dialog_data.text .. "\n" .. managers.localization:text("dialog_blackmarket_mask_sell_mod_readded", {mod = mod_id})
		end
	end
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_mask_sell(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_crafted_sell_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_slot_item", {
		slot = params.slot,
		item = params.name
	}) .. [[


]] .. managers.localization:text("dialog_blackmarket_slot_item_sell", {
		money = params.money
	})
	if params.mods_readded and #params.mods_readded > 0 then
		dialog_data.text = dialog_data.text .. "\n"
		for _, mod_id in ipairs(params.mods_readded) do
			dialog_data.text = dialog_data.text .. "\n" .. managers.localization:text("dialog_blackmarket_mask_sell_mod_readded", {mod = mod_id})
		end
	end
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_sell(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_crafted_sell_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_slot_item", {
		slot = params.slot,
		item = params.name
	}) .. [[


]] .. managers.localization:text("dialog_blackmarket_slot_item_sell", {
		money = params.money
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_buy_weapon_slot(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_weapon_buy_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_buy_weapon_slot", {
		money = params.money
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_buy_mask_slot(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_weapon_buy_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_buy_mask_slot", {
		money = params.money
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_buy(params)
	local num_in_inventory = ""
	local num_of_same = managers.blackmarket:get_crafted_item_amount(params.category, params.weapon)
	if 0 < num_of_same then
		num_in_inventory = managers.localization:text("dialog_blackmarket_num_in_inventory", {
			item = params.name,
			amount = num_of_same
		})
	end
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_weapon_buy_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_buy_item", {
		item = params.name,
		money = params.money,
		num_in_inventory = num_in_inventory
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_mod(params)
	local l_local = managers.localization
	local dialog_data = {}
	dialog_data.focus_button = 2
	dialog_data.title = l_local:text("dialog_bm_weapon_modify_title")
	dialog_data.text = l_local:text("dialog_blackmarket_slot_item", {
		slot = params.slot,
		item = params.weapon_name
	}) .. [[


]] .. l_local:text("dialog_blackmarket_mod_" .. (params.add and "add" or "remove"), {
		mod = params.name
	}) .. "\n"
	local warn_lost_mods = false
	if params.add and params.replaces and #params.replaces > 0 then
		dialog_data.text = dialog_data.text .. l_local:text("dialog_blackmarket_mod_replace", {
			mod = managers.weapon_factory:get_part_name_by_part_id(params.replaces[1])
		}) .. "\n"
		warn_lost_mods = true
	end
	if params.removes and 0 < #params.removes then
		local mods = ""
		for _, mod_name in ipairs(params.removes) do
			mods = mods .. "\n" .. managers.weapon_factory:get_part_name_by_part_id(mod_name)
		end
		dialog_data.text = dialog_data.text .. "\n" .. l_local:text("dialog_blackmarket_mod_conflict", {mods = mods}) .. "\n"
		warn_lost_mods = true
	end
	if not params.ignore_lost_mods and (warn_lost_mods or not params.add) then
		dialog_data.text = dialog_data.text .. "\n" .. l_local:text("dialog_blackmarket_lost_mods_warning")
	end
	if params.add and params.money then
		dialog_data.text = dialog_data.text .. "\n" .. l_local:text("dialog_blackmarket_mod_cost", {
			money = params.money
		})
	else
	end
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_assemble(params)
	local num_in_inventory = ""
	local num_of_same = managers.blackmarket:get_crafted_item_amount(params.category, params.weapon)
	if 0 < num_of_same then
		num_in_inventory = managers.localization:text("dialog_blackmarket_num_in_inventory", {
			item = params.name,
			amount = num_of_same
		})
	end
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_mask_assemble_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_assemble_item", {
		item = params.name,
		num_in_inventory = num_in_inventory
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_abort(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_mask_custom_abort")
	dialog_data.text = managers.localization:text("dialog_blackmarket_abort_mask_warning")
	dialog_data.focus_button = 1
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_blackmarket_finalize(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_bm_mask_custom_final_title")
	dialog_data.text = managers.localization:text("dialog_blackmarket_finalize_item", {
		money = params.money,
		ITEM = managers.localization:text("dialog_blackmarket_slot_item", {
			item = params.name,
			slot = params.slot
		})
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_mission_asset_buy(params)
	local asset_tweak_data = managers.assets:get_asset_tweak_data_by_id(params.asset_id)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_assets_buy_title")
	dialog_data.text = managers.localization:text("dialog_mission_asset_buy", {
		asset_desc = managers.localization:text(asset_tweak_data.unlock_desc_id or "menu_asset_unknown_unlock_desc"),
		cost = managers.experience:cash_string(managers.money:get_mission_asset_cost_by_id(params.asset_id))
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_buy_premium_contract(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_premium_buy_title")
	dialog_data.text = managers.localization:text("menu_cn_premium_buy_fee", {
		contract_fee = params.contract_fee,
		offshore = params.offshore
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("menu_cn_premium_buy_accept")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_pay_casino_fee(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_casino_pay_title")
	dialog_data.text = managers.localization:text("menu_cn_casino_pay_fee", {
		contract_fee = params.contract_fee,
		offshore = params.offshore
	})
	dialog_data.focus_button = 2
	local yes_button = {}
	yes_button.text = managers.localization:text("menu_cn_casino_pay_accept")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_accept_crime_net_job(params)
	local dialog_data = {}
	dialog_data.title = params.title
	dialog_data.text = params.player_text .. [[


]] .. params.desc
	dialog_data.focus_button = 1
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_accept")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_storage_removed_dialog(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_storage_removed_warning_X360")
	dialog_data.force = true
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_continue")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show_platform(dialog_data)
end

function MenuManager:show_game_is_full(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_err_room_is_full")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_game_no_longer_exists(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_err_room_no_longer_exists")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_game_is_full(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_err_room_is_full")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_wrong_version_message()
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text("dialog_err_wrong_version_message")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_inactive_user_accepted_invite(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text("dialog_inactive_user_accepted_invite")
	dialog_data.id = "inactive_user_accepted_invite"
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	ok_button.callback_func = params.ok_func
	dialog_data.button_list = {ok_button}
	managers.system_menu:add_init_show(dialog_data)
end

function MenuManager:show_question_start_tutorial(params)
	local dialog_data = {}
	dialog_data.focus_button = 1
	dialog_data.title = managers.localization:text("dialog_safehouse_title")
	dialog_data.text = managers.localization:text("dialog_safehouse_text")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_leave_safehouse_dialog(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_safehouse_title")
	dialog_data.text = managers.localization:text("dialog_are_you_sure_you_want_to_leave_game")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_save_settings_failed(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_error_title")
	dialog_data.text = managers.localization:text("dialog_save_settings_failed")
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_continue")
	dialog_data.button_list = {ok_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_play_safehouse_question(params)
	local dialog_data = {}
	dialog_data.focus_button = 1
	dialog_data.title = managers.localization:text("dialog_safehouse_title")
	dialog_data.text = managers.localization:text("dialog_safehouse_goto_text")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.cancel_button = true
	no_button.text = managers.localization:text("dialog_no")
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_savefile_wrong_version(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text(params.error_msg)
	dialog_data.id = "wrong_version"
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:add_init_show(dialog_data)
end

function MenuManager:show_savefile_wrong_user(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_information_title")
	dialog_data.text = managers.localization:text("dialog_load_wrong_user")
	dialog_data.id = "wrong_user"
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	managers.system_menu:add_init_show(dialog_data)
end

function MenuManager:show_abort_mission_dialog(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_warning_title")
	dialog_data.text = managers.localization:text("dialog_abort_mission_text")
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = params.yes_func
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	dialog_data.button_list = {yes_button, no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:show_confirm_become_infamous(params)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_become_infamous")
	local no_button = {}
	no_button.callback_func = params.no_func
	no_button.cancel_button = true
	if params.yes_func then
		no_button.text = managers.localization:text("dialog_no")
		local yes_button = {}
		yes_button.text = managers.localization:text("dialog_yes")
		yes_button.callback_func = params.yes_func
		dialog_data.text = managers.localization:text("menu_dialog_become_infamous", {
			level = 100,
			cash = params.cost
		})
		dialog_data.focus_button = 2
		dialog_data.button_list = {yes_button, no_button}
		local got_usable_primary_weapon = managers.blackmarket:check_will_have_free_slot("primaries")
		local got_usable_secondary_weapon = managers.blackmarket:check_will_have_free_slot("secondaries")
		local add_weapon_replace_warning = not got_usable_primary_weapon or not got_usable_secondary_weapon
		if add_weapon_replace_warning then
			local primary_weapon = managers.blackmarket:get_crafted_category_slot("primaries", 1)
			local secondary_weapon = managers.blackmarket:get_crafted_category_slot("secondaries", 1)
			local warning_text_id = "menu_dialog_warning_infamy_replace_pri_sec"
			if got_usable_primary_weapon then
				warning_text_id = "menu_dialog_warning_infamy_replace_secondary"
			elseif got_usable_secondary_weapon then
				warning_text_id = "menu_dialog_warning_infamy_replace_primary"
			end
			local params = {
				primary = primary_weapon and managers.localization:to_upper_text(tweak_data.weapon[primary_weapon.weapon_id].name_id),
				secondary = secondary_weapon and managers.localization:to_upper_text(tweak_data.weapon[secondary_weapon.weapon_id].name_id),
				amcar = managers.localization:to_upper_text(tweak_data.weapon.amcar.name_id),
				glock_17 = managers.localization:to_upper_text(tweak_data.weapon.glock_17.name_id)
			}
			dialog_data.text = dialog_data.text .. [[


]] .. managers.localization:text(warning_text_id, params)
		end
	else
		no_button.text = managers.localization:text("dialog_ok")
		dialog_data.text = managers.localization:text("menu_dialog_become_infamous_no_cash", {
			cash = params.cost
		})
		dialog_data.focus_button = 1
		dialog_data.button_list = {no_button}
	end
	dialog_data.w = 620
	dialog_data.h = 500
	managers.system_menu:show_new_unlock(dialog_data)
end

function MenuManager:show_infamous_message(can_become_infamous)
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_infamous_info_title")
	local no_button = {}
	no_button.cancel_button = true
	no_button.text = managers.localization:text("dialog_ok")
	if can_become_infamous then
		dialog_data.text = managers.localization:text("dialog_can_become_infamous_desc", {
			become_infamous_menu_item = managers.localization:to_upper_text("menu_become_infamous")
		})
	else
		dialog_data.text = managers.localization:text("dialog_infamous_info_desc", {
			level = 100,
			cash = managers.experience:cash_string(Application:digest_value(tweak_data.infamy.ranks[managers.experience:current_rank() + 1], false))
		})
	end
	dialog_data.focus_button = 1
	dialog_data.button_list = {no_button}
	managers.system_menu:show(dialog_data)
end

function MenuManager:dialog_gage_assignment_completed(params)
	params = {
		player = params.player or tostring(managers.network.account:username() or managers.blackmarket:get_preferred_character_real_name()),
		time = params.time or Application:date("%H:%M"),
		date = params.date or Application:date("%Y-%m-%d"),
		completed = params.completed or ""
	}
	local dialog_data = {}
	dialog_data.title = managers.localization:text("dialog_gage_assignment_completed_title")
	dialog_data.text = managers.localization:text("dialog_gage_assignment_completed", params)
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	dialog_data.button_list = {ok_button}
	dialog_data.texture = "guis/textures/pd2/feature_crimenet_heat"
	dialog_data.text_blend_mode = "add"
	dialog_data.use_text_formating = true
	dialog_data.w = 620
	dialog_data.h = 532
	dialog_data.image_w = 64
	dialog_data.image_h = 64
	dialog_data.image_valign = "top"
	dialog_data.title_font = tweak_data.menu.pd2_medium_font
	dialog_data.title_font_size = tweak_data.menu.pd2_medium_font_size
	dialog_data.font = tweak_data.menu.pd2_small_font
	dialog_data.font_size = tweak_data.menu.pd2_small_font_size
	managers.system_menu:show_new_unlock(dialog_data)
end
