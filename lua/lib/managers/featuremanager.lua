FeatureManager = FeatureManager or class()

function FeatureManager:init()
	self:_setup()
end

function FeatureManager:_setup()
	self._default = {}
	self._default.announcements = {}
	self._default.announcements.crimenet_heat = 3
	self._default.announcements.election_changes = 1
	self._default.announcements.crimenet_welcome = 0
	self._default.announcements.dlc_gage_pack_jobs = 1
	self._default.announcements.blackmarket_rename = 1
	self._default.announcements.join_pd2_clan = 50
	self._default.announcements.perk_deck = 3
	self._default.announcements.freed_old_hoxton = 1
	self._default.announcements.infamy_2_0 = 1
	self._default.announcements.thq_feature = 1
	if not Global.feature_manager then
		Global.feature_manager = {}
		Global.feature_manager.announcements = {}
		for id, _ in pairs(self._default.announcements) do
			Global.feature_manager.announcements[id] = 0
		end
		Global.feature_manager.announcements.crimenet_welcome = 3
		Global.feature_manager.announcements.dlc_gage_pack_jobs = 1
		Global.feature_manager.announcements.join_pd2_clan = 50
		Global.feature_manager.announcements.freed_old_hoxton = 1
		Global.feature_manager.announced = {}
	end
	self._global = Global.feature_manager
end

function FeatureManager:save(data)
	Application:debug("[FeatureManager:save]")
	local save_data = {}
	save_data.announcements = deep_clone(self._global.announcements)
	data.feature_manager = save_data
end

function FeatureManager:load(data, version)
	Application:debug("[FeatureManager:load]")
	for announcement, default in pairs(self._default.announcements) do
		Global.feature_manager.announcements[announcement] = default
	end
	if data.feature_manager then
		local announcements = data.feature_manager.announcements or {}
		for announcement, num in pairs(announcements) do
			Global.feature_manager.announcements[announcement] = num
		end
	end
end

function FeatureManager:announce_feature(feature_id)
	local announcement = self._global.announcements[feature_id]
	if not announcement then
		return
	end
	if self._global.announced[feature_id] then
		Application:debug("[FeatureManager:announce_feature] Feture already announced.", feature_id)
		return
	end
	if type(announcement) ~= "number" then
		self._global.announcements[feature_id] = 0
		return
	end
	if announcement <= 0 then
		return
	end
	local func = self[feature_id]
	if not func or not func() then
		Application:error("[FeatureManager:announce_feature] Failed announcing feature!", feature_id)
	end
	announcement = announcement - 1
	self._global.announcements[feature_id] = announcement
	self._global.announced[feature_id] = true
end

function FeatureManager:set_feature_announce_times(feature_id, num)
	local announcement = self._global.announcements[feature_id]
	if not announcement then
		return
	end
	self._global.announcements[feature_id] = num
end

function FeatureManager:crimenet_heat()
	print("FeatureManager:crimenet_heat()")
	managers.menu:show_announce_crimenet_heat()
	return true
end

function FeatureManager:election_changes()
	print("FeatureManager:election_changes()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_election_changes_title",
		text = "menu_feature_election_changes_desc"
	})
	return true
end

function FeatureManager:crimenet_welcome()
	print("FeatureManager:crimenet_welcome()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_crimenet_welcome_title",
		text = "menu_feature_crimenet_welcome_desc"
	})
	return true
end

function FeatureManager:dlc_gage_pack_jobs()
	print("FeatureManager:dlc_gage_pack_jobs()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_crimenet_thanks_gagemod",
		text = "menu_feature_crimenet_thanks_gagemod_desc"
	})
	return true
end

function FeatureManager:blackmarket_rename()
	print("FeatureManager:blackmarket_rename()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_blackmarket_rename",
		text = "menu_feature_blackmarket_rename_desc"
	})
	return true
end

function FeatureManager:join_pd2_clan()
	print("FeatureManager:join_pd2_clan()")
	local params = {
		title = "menu_feature_join_pd2_clan",
		text = "menu_feature_join_pd2_clan_desc",
		formating_color = tweak_data.screen_colors.button_stage_2,
		texture = false,
		video = "movies/join_community",
		image_blend_mode = "add",
		video_loop = true
	}
	local ok_button = {}
	ok_button.text = managers.localization:text("dialog_ok")
	ok_button.cancel_button = true
	local joining_pd2_clan_button = {}
	joining_pd2_clan_button.text = managers.localization:text("dialog_join_pd2_clan")
	
	function joining_pd2_clan_button.callback_func()
		Steam:overlay_activate("game", "OfficialGameGroup")
	end
	
	params.button_list = {joining_pd2_clan_button, ok_button}
	params.focus_button = 1
	managers.menu:show_video_message_dialog(params)
	return true
end

function FeatureManager:perk_deck()
	print("FeatureManager:perk_deck()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_perk_deck",
		text = "menu_feature_perk_deck_desc"
	})
	return true
end

function FeatureManager:freed_old_hoxton()
	print("FeatureManager:freed_old_hoxton()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_freed_old_hoxton",
		text = "menu_feature_freed_old_hoxton_desc"
	})
	return true
end

function FeatureManager:infamy_2_0()
	print("FeatureManager:infamy_2_0()")
	managers.menu:show_new_message_dialog({
		title = "menu_feature_infamy_2_0",
		text = "menu_feature_infamy_2_0_desc"
	})
	return true
end

function FeatureManager:thq_feature()
	print("FeatureManager:thq_feature()")
	if managers.user:get_setting("use_thq_weapon_parts") then
		return
	end
	local yes_function = function()
		managers.user:set_setting("use_thq_weapon_parts", true)
		managers.savefile:save_setting(true)
	end
	local button_list = {}
	local yes_button = {}
	yes_button.text = managers.localization:text("dialog_yes")
	yes_button.callback_func = yes_function
	local no_button = {}
	no_button.text = managers.localization:text("dialog_no")
	button_list = {yes_button, no_button}
	managers.menu:show_new_message_dialog({
		title = "dialog_feature_thq_title",
		text = "dialog_feature_thq",
		button_list = button_list
	})
	return true
end
