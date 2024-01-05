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
	if not Global.feature_manager then
		Global.feature_manager = {}
		Global.feature_manager.announcements = {}
		for id, _ in pairs(self._default.announcements) do
			Global.feature_manager.announcements[id] = 0
		end
		Global.feature_manager.announcements.crimenet_welcome = 3
		Global.feature_manager.announcements.dlc_gage_pack_jobs = 1
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
