core:import("CoreMissionManager")
core:import("CoreClass")
require("lib/managers/mission/MissionScriptElement")
require("lib/managers/mission/ElementSpawnEnemyGroup")
require("lib/managers/mission/ElementEnemyPrefered")
require("lib/managers/mission/ElementAIGraph")
require("lib/managers/mission/ElementWaypoint")
require("lib/managers/mission/ElementSpawnCivilian")
require("lib/managers/mission/ElementSpawnCivilianGroup")
require("lib/managers/mission/ElementLookAtTrigger")
require("lib/managers/mission/ElementMissionEnd")
require("lib/managers/mission/ElementObjective")
require("lib/managers/mission/ElementConsoleCommand")
require("lib/managers/mission/ElementDialogue")
require("lib/managers/mission/ElementHeat")
require("lib/managers/mission/ElementHint")
require("lib/managers/mission/ElementMoney")
require("lib/managers/mission/ElementFleePoint")
require("lib/managers/mission/ElementAiGlobalEvent")
require("lib/managers/mission/ElementEquipment")
require("lib/managers/mission/ElementAreaMinPoliceForce")
require("lib/managers/mission/ElementPlayerState")
require("lib/managers/mission/ElementKillZone")
require("lib/managers/mission/ElementActionMessage")
require("lib/managers/mission/ElementGameDirection")
require("lib/managers/mission/ElementPressure")
require("lib/managers/mission/ElementDangerZone")
require("lib/managers/mission/ElementScenarioEvent")
require("lib/managers/mission/ElementSpecialObjective")
require("lib/managers/mission/ElementSpecialObjectiveTrigger")
require("lib/managers/mission/ElementSpecialObjectiveGroup")
require("lib/managers/mission/ElementSecretAssignment")
require("lib/managers/mission/ElementDifficulty")
require("lib/managers/mission/ElementBlurZone")
require("lib/managers/mission/ElementAIRemove")
require("lib/managers/mission/ElementFlashlight")
require("lib/managers/mission/ElementTeammateComment")
require("lib/managers/mission/ElementCharacterOutline")
require("lib/managers/mission/ElementFakeAssaultState")
require("lib/managers/mission/ElementWhisperState")
require("lib/managers/mission/ElementDifficultyLevelCheck")
require("lib/managers/mission/ElementAwardAchievment")
require("lib/managers/mission/ElementPlayerNumberCheck")
require("lib/managers/mission/ElementPointOfNoReturn")
require("lib/managers/mission/ElementFadeToBlack")
require("lib/managers/mission/ElementAlertTrigger")
require("lib/managers/mission/ElementFeedback")
require("lib/managers/mission/ElementExplosion")
require("lib/managers/mission/ElementFilter")
require("lib/managers/mission/ElementDisableUnit")
require("lib/managers/mission/ElementEnableUnit")
require("lib/managers/mission/ElementSmokeGrenade")
require("lib/managers/mission/ElementDisableShout")
require("lib/managers/mission/ElementSetOutline")
require("lib/managers/mission/ElementExplosionDamage")
require("lib/managers/mission/ElementSequenceCharacter")
require("lib/managers/mission/ElementPlayerStyle")
require("lib/managers/mission/ElementDropinState")
require("lib/managers/mission/ElementBainState")
require("lib/managers/mission/ElementBlackscreenVariant")
require("lib/managers/mission/ElementAccessCamera")
require("lib/managers/mission/ElementAIAttention")
require("lib/managers/mission/ElementMissionFilter")
require("lib/managers/mission/ElementAIArea")
require("lib/managers/mission/ElementSecurityCamera")
require("lib/managers/mission/ElementCarry")
require("lib/managers/mission/ElementLootBag")
require("lib/managers/mission/ElementJobValue")
require("lib/managers/mission/ElementJobStageAlternative")
require("lib/managers/mission/ElementNavObstacle")
require("lib/managers/mission/ElementLootSecuredTrigger")
require("lib/managers/mission/ElementMandatoryBags")
require("lib/managers/mission/ElementAssetTrigger")
require("lib/managers/mission/ElementSpawnDeployable")
require("lib/managers/mission/ElementInventoryDummy")
require("lib/managers/mission/ElementProfileFilter")
require("lib/managers/mission/ElementFleePoint")
require("lib/managers/mission/ElementPlayerSpawner")
require("lib/managers/mission/ElementAreaTrigger")
require("lib/managers/mission/ElementSpawnEnemyDummy")
require("lib/managers/mission/ElementEnemyDummyTrigger")
MissionManager = MissionManager or class(CoreMissionManager.MissionManager)

function MissionManager:init(...)
	MissionManager.super.init(self, ...)
	self:add_area_instigator_categories("player")
	self:add_area_instigator_categories("enemies")
	self:add_area_instigator_categories("civilians")
	self:add_area_instigator_categories("escorts")
	self:add_area_instigator_categories("criminals")
	self:add_area_instigator_categories("ai_teammates")
	self:add_area_instigator_categories("loot")
	self:add_area_instigator_categories("unique_loot")
	self:set_default_area_instigator("player")
	self:set_global_event_list({
		"bankmanager_key",
		"chavez_key",
		"blue_key",
		"keycard",
		"start_assault",
		"end_assault",
		"police_called",
		"police_weapons_hot",
		"loot_lost",
		"special_event_a",
		"special_event_b",
		"special_event_c",
		"special_event_d",
		"special_event_e",
		"special_event_f",
		"special_event_g"
	})
	self._mission_filter = {}
	if not Global.mission_manager then
		Global.mission_manager = {}
		Global.mission_manager.stage_job_values = {}
		Global.mission_manager.job_values = {}
		Global.mission_manager.saved_job_values = {}
		Global.mission_manager.has_played_tutorial = false
	end
end

function MissionManager:set_saved_job_value(key, value)
	Global.mission_manager.saved_job_values[key] = value
end

function MissionManager:get_saved_job_value(key)
	return Global.mission_manager.saved_job_values[key]
end

function MissionManager:on_reset_profile()
	Global.mission_manager.saved_job_values.playedSafeHouseBefore = nil
end

function MissionManager:set_job_value(key, value)
	Global.mission_manager.stage_job_values[key] = value
end

function MissionManager:get_job_value(key)
	return Global.mission_manager.job_values[key] or Global.mission_manager.stage_job_values[key]
end

function MissionManager:on_job_deactivated()
	Global.mission_manager.job_values = {}
	Global.mission_manager.stage_job_values = {}
end

function MissionManager:on_retry_job_stage()
	Global.mission_manager.stage_job_values = {}
end

function MissionManager:on_stage_success()
	for key, value in pairs(Global.mission_manager.stage_job_values) do
		Global.mission_manager.job_values[key] = value
	end
	Global.mission_manager.stage_job_values = {}
end

function MissionManager:set_mission_filter(mission_filter)
	self._mission_filter = mission_filter
end

function MissionManager:check_mission_filter(value)
	return table.contains(self._mission_filter, value)
end

function MissionManager:default_instigator()
	return managers.player:player_unit()
end

function MissionManager:activate_script(...)
	MissionManager.super.activate_script(self, ...)
end

function MissionManager:client_run_mission_element(id, unit)
	for name, data in pairs(self._scripts) do
		if data:element(id) then
			data:element(id):client_on_executed(unit)
			return
		end
	end
end

function MissionManager:client_run_mission_element_end_screen(id, unit)
	for name, data in pairs(self._scripts) do
		if data:element(id) then
			if data:element(id).client_on_executed_end_screen then
				data:element(id):client_on_executed_end_screen(unit)
			end
			return
		end
	end
end

function MissionManager:server_run_mission_element_trigger(id, unit)
	for name, data in pairs(self._scripts) do
		local element = data:element(id)
		if element then
			element:on_executed(unit)
			return
		end
	end
end

function MissionManager:server_enter_area(id, unit)
	for name, data in pairs(self._scripts) do
		local element = data:element(id)
		if element then
			element:sync_enter_area(unit)
		end
	end
end

function MissionManager:server_exit_area(id, unit)
	for name, data in pairs(self._scripts) do
		local element = data:element(id)
		if element then
			element:sync_exit_area(unit)
		end
	end
end

function MissionManager:to_server_access_camera_trigger(id, trigger, instigator)
	for name, data in pairs(self._scripts) do
		local element = data:element(id)
		if element then
			element:check_triggers(trigger, instigator)
		end
	end
end

function MissionManager:save_job_values(data)
	local state = {
		saved_job_values = Global.mission_manager.saved_job_values,
		has_played_tutorial = Global.mission_manager.has_played_tutorial
	}
	data.ProductMissionManager = state
end

function MissionManager:load_job_values(data)
	local state = data.ProductMissionManager
	if state then
		Global.mission_manager.saved_job_values = state.saved_job_values
		Global.mission_manager.has_played_tutorial = state.has_played_tutorial
	end
end

function MissionManager:stop_simulation(...)
	MissionManager.super.stop_simulation(self, ...)
	Global.mission_manager.saved_job_values = {}
	self:on_job_deactivated()
	managers.loot:reset()
end

function MissionManager:debug_execute_mission_element_by_name(name)
	for _, data in pairs(self._scripts) do
		for id, element in pairs(data:elements()) do
			if element:editor_name() == name then
				element:on_executed()
				return
			end
		end
	end
end

CoreClass.override_class(CoreMissionManager.MissionManager, MissionManager)
MissionScript = MissionScript or class(CoreMissionManager.MissionScript)

function MissionScript:activate(...)
	if Network:is_server() then
		MissionScript.super.activate(self, ...)
		return
	end
	managers.mission:add_persistent_debug_output("")
	managers.mission:add_persistent_debug_output("Activate mission " .. self._name, Color(1, 0, 1, 0))
	for _, element in pairs(self._elements) do
		element:on_script_activated()
	end
	for _, element in pairs(self._elements) do
		if element:value("execute_on_startup") then
		end
	end
end

CoreClass.override_class(CoreMissionManager.MissionScript, MissionScript)
