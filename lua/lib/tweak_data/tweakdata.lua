require("lib/tweak_data/WeaponTweakData")
require("lib/tweak_data/WeaponUpgradesTweakData")
require("lib/tweak_data/EquipmentsTweakData")
require("lib/tweak_data/CharacterTweakData")
require("lib/tweak_data/PlayerTweakData")
require("lib/tweak_data/StatisticsTweakData")
require("lib/tweak_data/LevelsTweakData")
require("lib/tweak_data/GroupAITweakData")
require("lib/tweak_data/DramaTweakData")
require("lib/tweak_data/SecretAssignmentTweakData")
require("lib/tweak_data/ChallengesTweakData")
require("lib/tweak_data/UpgradesTweakData")
require("lib/tweak_data/UpgradesVisualTweakData")
require("lib/tweak_data/HudIconsTweakData")
require("lib/tweak_data/TipsTweakData")
require("lib/tweak_data/BlackMarketTweakData")
require("lib/tweak_data/CarryTweakData")
require("lib/tweak_data/MissionDoorTweakData")
require("lib/tweak_data/AttentionTweakData")
require("lib/tweak_data/NarrativeTweakData")
require("lib/tweak_data/SkillTreeTweakData")
require("lib/tweak_data/TimeSpeedEffectTweakData")
require("lib/tweak_data/SoundTweakData")
require("lib/tweak_data/LootDropTweakData")
require("lib/tweak_data/GuiTweakData")
require("lib/tweak_data/MoneyTweakData")
require("lib/tweak_data/AssetsTweakData")
require("lib/tweak_data/DLCTweakData")
require("lib/tweak_data/InfamyTweakData")
require("lib/tweak_data/GageAssignmentTweakData")
require("lib/tweak_data/PrePlanningTweakData")
TweakData = TweakData or class()
require("lib/tweak_data/TweakDataPD2")
TweakData.RELOAD = true

function TweakData:digest_tweak_data()
	Application:debug("TweakData: Digesting tweak_data. <('O'<)")
	self:digest_recursive(self.money_manager)
	self:digest_recursive(self.experience_manager)
	self:digest_recursive(self.casino)
end

function TweakData:digest_recursive(key, parent)
	local value = parent and parent[key] or key
	if type(value) == "table" then
		for index, data in pairs(value) do
			self:digest_recursive(index, value)
		end
	elseif type(value) == "number" then
		parent[key] = Application:digest_value(value, true)
	end
end

function TweakData:get_value(...)
	local arg = {
		...
	}
	local value = self
	for _, v in ipairs(arg) do
		if not value[v] then
			return false
		end
		value = value[v]
	end
	if type(value) == "string" then
		return Application:digest_value(value, false)
	elseif type(value) == "table" then
		Application:debug("TweakData:get_value() value was a table, is this correct? returning false!", inspect(arg), inspect(value))
		return false
	end
	return value
end

function TweakData:get_raw_value(...)
	local arg = {
		...
	}
	local value = self
	local v
	for i = 1, #arg do
		v = arg[i]
		if not value[v] then
			return nil, v, i
		end
		value = value[v]
	end
	return value
end

function TweakData:set_mode()
	if not Global.game_settings then
		return
	end
	if Global.game_settings.single_player then
		self:_set_singleplayer()
	else
		self:_set_multiplayer()
	end
end

function TweakData:_set_singleplayer()
	self.player:_set_singleplayer()
end

function TweakData:_set_multiplayer()
	self.player:_set_multiplayer()
end

function TweakData:set_difficulty()
	if not Global.game_settings then
		return
	end
	if Global.game_settings.difficulty == "easy" then
		self:_set_easy()
	elseif Global.game_settings.difficulty == "normal" then
		self:_set_normal()
	elseif Global.game_settings.difficulty == "overkill" then
		self:_set_overkill()
	elseif Global.game_settings.difficulty == "overkill_145" then
		self:_set_overkill_145()
	elseif Global.game_settings.difficulty == "overkill_290" then
		self:_set_overkill_290()
	else
		self:_set_hard()
	end
end

function TweakData:_set_easy()
	self.player:_set_easy()
	self.character:_set_easy()
	self.money_manager:init(self)
	self.group_ai:init(self)
	self.weapon:_set_easy()
	self.experience_manager.civilians_killed = 15
	self.difficulty_name_id = self.difficulty_name_ids.easy
	self.experience_manager.total_level_objectives = 1000
	self.experience_manager.total_criminals_finished = 25
	self.experience_manager.total_objectives_finished = 750
end

function TweakData:_set_normal()
	self.player:_set_normal()
	self.character:_set_normal()
	self.money_manager:init(self)
	self.group_ai:init(self)
	self.weapon:_set_normal()
	self.experience_manager.civilians_killed = 35
	self.difficulty_name_id = self.difficulty_name_ids.normal
	self.experience_manager.total_level_objectives = 2000
	self.experience_manager.total_criminals_finished = 50
	self.experience_manager.total_objectives_finished = 1000
end

function TweakData:_set_hard()
	self.player:_set_hard()
	self.character:_set_hard()
	self.money_manager:init(self)
	self.group_ai:init(self)
	self.weapon:_set_hard()
	self.experience_manager.civilians_killed = 75
	self.difficulty_name_id = self.difficulty_name_ids.hard
	self.experience_manager.total_level_objectives = 2500
	self.experience_manager.total_criminals_finished = 150
	self.experience_manager.total_objectives_finished = 1500
end

function TweakData:_set_overkill()
	self.player:_set_overkill()
	self.character:_set_overkill()
	self.money_manager:init(self)
	self.group_ai:init(self)
	self.weapon:_set_overkill()
	self.experience_manager.civilians_killed = 150
	self.difficulty_name_id = self.difficulty_name_ids.overkill
	self.experience_manager.total_level_objectives = 5000
	self.experience_manager.total_criminals_finished = 500
	self.experience_manager.total_objectives_finished = 3000
end

function TweakData:_set_overkill_145()
	self.player:_set_overkill_145()
	self.character:_set_overkill_145()
	self.money_manager:init(self)
	self.group_ai:init(self)
	self.weapon:_set_overkill_145()
	self.experience_manager.civilians_killed = 550
	self.difficulty_name_id = self.difficulty_name_ids.overkill_145
	self.experience_manager.total_level_objectives = 5000
	self.experience_manager.total_criminals_finished = 2000
	self.experience_manager.total_objectives_finished = 3000
end

function TweakData:_set_overkill_290()
	self.player:_set_overkill_290()
	self.character:_set_overkill_290()
	self.money_manager:init(self)
	self.group_ai:init(self)
	self.weapon:_set_overkill_290()
	self.experience_manager.civilians_killed = 10000
	self.difficulty_name_id = self.difficulty_name_ids.overkill_290
	self.experience_manager.total_level_objectives = 5000
	self.experience_manager.total_criminals_finished = 2000
	self.experience_manager.total_objectives_finished = 3000
end

function TweakData:difficulty_to_index(difficulty)
	return table.index_of(self.difficulties, difficulty)
end

function TweakData:index_to_difficulty(index)
	return self.difficulties[index]
end

function TweakData:permission_to_index(permission)
	return table.index_of(self.permissions, permission)
end

function TweakData:index_to_permission(index)
	return self.permissions[index]
end

function TweakData:server_state_to_index(state)
	return table.index_of(self.server_states, state)
end

function TweakData:index_to_server_state(index)
	return self.server_states[index]
end

function TweakData:menu_sync_state_to_index(state)
	if not state then
		return false
	end
	for i, menu_sync in ipairs(self.menu_sync_states) do
		if menu_sync == state then
			return i
		end
	end
end

function TweakData:index_to_menu_sync_state(index)
	return self.menu_sync_states[index]
end

function TweakData:init()
	self.difficulties = {
		"easy",
		"normal",
		"hard",
		"overkill",
		"overkill_145",
		"overkill_290"
	}
	self.difficulty_level_locks = {
		0,
		0,
		0,
		0,
		0,
		80
	}
	self.permissions = {
		"public",
		"friends_only",
		"private"
	}
	self.server_states = {
		"in_lobby",
		"loading",
		"in_game"
	}
	self.menu_sync_states = {
		"crimenet",
		"skilltree",
		"options",
		"lobby",
		"blackmarket",
		"blackmarket_weapon",
		"blackmarket_mask"
	}
	self.difficulty_name_ids = {}
	self.difficulty_name_ids.easy = "menu_difficulty_easy"
	self.difficulty_name_ids.normal = "menu_difficulty_normal"
	self.difficulty_name_ids.hard = "menu_difficulty_hard"
	self.difficulty_name_ids.overkill = "menu_difficulty_very_hard"
	self.difficulty_name_ids.overkill_145 = "menu_difficulty_overkill"
	self.difficulty_name_ids.overkill_290 = "menu_difficulty_apocalypse"
	self.hud_icons = HudIconsTweakData:new()
	self.weapon = WeaponTweakData:new()
	self.weapon_upgrades = WeaponUpgradesTweakData:new()
	self.equipments = EquipmentsTweakData:new()
	self.player = PlayerTweakData:new()
	self.character = CharacterTweakData:new(self)
	self.statistics = StatisticsTweakData:new()
	self.levels = LevelsTweakData:new()
	self.narrative = NarrativeTweakData:new()
	self.group_ai = GroupAITweakData:new(self)
	self.drama = DramaTweakData:new()
	self.secret_assignment_manager = SecretAssignmentTweakData:new()
	self.challenges = ChallengesTweakData:new()
	self.upgrades = UpgradesTweakData:new()
	self.skilltree = SkillTreeTweakData:new()
	self.upgrades.visual = UpgradesVisualTweakData:new()
	self.tips = TipsTweakData:new()
	self.money_manager = MoneyTweakData:new(self)
	self.blackmarket = BlackMarketTweakData:new(self)
	self.carry = CarryTweakData:new(self)
	self.mission_door = MissionDoorTweakData:new()
	self.attention = AttentionTweakData:new()
	self.timespeed = TimeSpeedEffectTweakData:new()
	self.sound = SoundTweakData:new()
	self.lootdrop = LootDropTweakData:new(self)
	self.gui = GuiTweakData:new()
	self.assets = AssetsTweakData:new(self)
	self.dlc = DLCTweakData:new(self)
	self.infamy = InfamyTweakData:new(self)
	self.gage_assignment = GageAssignmentTweakData:new(self)
	self.preplanning = PrePlanningTweakData:new(self)
	self.EFFECT_QUALITY = 0.5
	if SystemInfo:platform() == Idstring("X360") then
		self.EFFECT_QUALITY = 0.5
	elseif SystemInfo:platform() == Idstring("PS3") then
		self.EFFECT_QUALITY = 0.5
	end
	self:set_scale()
	self:_init_pd2()
	self.menu_themes = {
		old = {
			bg_startscreen = "guis/textures/menu/old_theme/bg_startscreen",
			bg_dlc = "guis/textures/menu/old_theme/bg_dlc",
			bg_setupgame = "guis/textures/menu/old_theme/bg_setupgame",
			bg_creategame = "guis/textures/menu/old_theme/bg_creategame",
			bg_challenge = "guis/textures/menu/old_theme/bg_challenge",
			bg_upgrades = "guis/textures/menu/old_theme/bg_upgrades",
			bg_stats = "guis/textures/menu/old_theme/bg_stats",
			bg_options = "guis/textures/menu/old_theme/bg_options",
			bg_assault = "guis/textures/menu/old_theme/bg_assault",
			bg_sharpshooter = "guis/textures/menu/old_theme/bg_sharpshooter",
			bg_support = "guis/textures/menu/old_theme/bg_support",
			bg_technician = "guis/textures/menu/old_theme/bg_technician",
			bg_lobby_fullteam = "guis/textures/menu/old_theme/bg_lobby_fullteam",
			bg_hoxton = "guis/textures/menu/old_theme/bg_hoxton",
			bg_wolf = "guis/textures/menu/old_theme/bg_wolf",
			bg_dallas = "guis/textures/menu/old_theme/bg_dallas",
			bg_chains = "guis/textures/menu/old_theme/bg_chains",
			background = "guis/textures/menu/old_theme/background"
		},
		fire = {
			bg_startscreen = "guis/textures/menu/fire_theme/bg_startscreen",
			bg_dlc = "guis/textures/menu/fire_theme/bg_dlc",
			bg_setupgame = "guis/textures/menu/fire_theme/bg_setupgame",
			bg_creategame = "guis/textures/menu/fire_theme/bg_creategame",
			bg_challenge = "guis/textures/menu/fire_theme/bg_challenge",
			bg_upgrades = "guis/textures/menu/fire_theme/bg_upgrades",
			bg_stats = "guis/textures/menu/fire_theme/bg_stats",
			bg_options = "guis/textures/menu/fire_theme/bg_options",
			bg_assault = "guis/textures/menu/fire_theme/bg_assault",
			bg_sharpshooter = "guis/textures/menu/fire_theme/bg_sharpshooter",
			bg_support = "guis/textures/menu/fire_theme/bg_support",
			bg_technician = "guis/textures/menu/fire_theme/bg_technician",
			bg_lobby_fullteam = "guis/textures/menu/fire_theme/bg_lobby_fullteam",
			bg_hoxton = "guis/textures/menu/fire_theme/bg_hoxton",
			bg_wolf = "guis/textures/menu/fire_theme/bg_wolf",
			bg_dallas = "guis/textures/menu/fire_theme/bg_dallas",
			bg_chains = "guis/textures/menu/fire_theme/bg_chains",
			background = "guis/textures/menu/fire_theme/background"
		},
		zombie = {
			bg_startscreen = "guis/textures/menu/zombie_theme/bg_startscreen",
			bg_dlc = "guis/textures/menu/fire_theme/bg_dlc",
			bg_setupgame = "guis/textures/menu/zombie_theme/bg_setupgame",
			bg_creategame = "guis/textures/menu/zombie_theme/bg_creategame",
			bg_challenge = "guis/textures/menu/zombie_theme/bg_challenge",
			bg_upgrades = "guis/textures/menu/zombie_theme/bg_upgrades",
			bg_stats = "guis/textures/menu/zombie_theme/bg_stats",
			bg_options = "guis/textures/menu/zombie_theme/bg_options",
			bg_assault = "guis/textures/menu/zombie_theme/bg_assault",
			bg_sharpshooter = "guis/textures/menu/zombie_theme/bg_sharpshooter",
			bg_support = "guis/textures/menu/zombie_theme/bg_support",
			bg_technician = "guis/textures/menu/zombie_theme/bg_technician",
			bg_lobby_fullteam = "guis/textures/menu/zombie_theme/bg_lobby_fullteam",
			bg_hoxton = "guis/textures/menu/zombie_theme/bg_hoxton",
			bg_wolf = "guis/textures/menu/zombie_theme/bg_wolf",
			bg_dallas = "guis/textures/menu/zombie_theme/bg_dallas",
			bg_chains = "guis/textures/menu/zombie_theme/bg_chains",
			background = "guis/textures/menu/zombie_theme/background"
		}
	}
	self.states = {}
	self.states.title = {}
	self.states.title.ATTRACT_VIDEO_DELAY = 90
	self.menu = {}
	self.menu.BRIGHTNESS_CHANGE = 0.05
	self.menu.MIN_BRIGHTNESS = 0.5
	self.menu.MAX_BRIGHTNESS = 1.5
	self.menu.MUSIC_CHANGE = 10
	self.menu.MIN_MUSIC_VOLUME = 0
	self.menu.MAX_MUSIC_VOLUME = 100
	self.menu.SFX_CHANGE = 10
	self.menu.MIN_SFX_VOLUME = 0
	self.menu.MAX_SFX_VOLUME = 100
	self.menu.VOICE_CHANGE = 0.05
	self.menu.MIN_VOICE_VOLUME = 0
	self.menu.MAX_VOICE_VOLUME = 1
	self:set_menu_scale()
	local orange = Vector3(204, 161, 102) / 255
	local green = Vector3(194, 252, 151) / 255
	local brown = Vector3(178, 104, 89) / 255
	local blue = Vector3(120, 183, 204) / 255
	local team_ai = Vector3(0.2, 0.8, 1)
	self.peer_vector_colors = {
		green,
		blue,
		brown,
		orange,
		team_ai
	}
	self.peer_colors = {
		"mrgreen",
		"mrblue",
		"mrbrown",
		"mrorange",
		"mrai"
	}
	self.system_chat_color = Color(255, 255, 212, 0) / 255
	self.chat_colors = {
		Color(self.peer_vector_colors[1]:unpack()),
		Color(self.peer_vector_colors[2]:unpack()),
		Color(self.peer_vector_colors[3]:unpack()),
		Color(self.peer_vector_colors[4]:unpack()),
		Color(self.peer_vector_colors[5]:unpack())
	}
	self.preplanning_peer_colors = {
		Color("ff82991e"),
		Color("ff0055ff"),
		Color("ffff7800"),
		Color("ffffff00")
	}
	self.screen_colors = {}
	self.screen_colors.text = Color(255, 255, 255, 255) / 255
	self.screen_colors.resource = Color(255, 77, 198, 255) / 255
	self.screen_colors.important_1 = Color(255, 255, 51, 51) / 255
	self.screen_colors.important_2 = Color(125, 255, 51, 51) / 255
	self.screen_colors.item_stage_1 = Color(255, 255, 255, 255) / 255
	self.screen_colors.item_stage_2 = Color(255, 89, 115, 128) / 255
	self.screen_colors.item_stage_3 = Color(255, 23, 33, 38) / 255
	self.screen_colors.button_stage_1 = Color(255, 0, 0, 0) / 255
	self.screen_colors.button_stage_2 = Color(255, 77, 198, 255) / 255
	self.screen_colors.button_stage_3 = Color(127, 0, 170, 255) / 255
	self.screen_colors.crimenet_lines = Color(255, 127, 157, 182) / 255
	self.screen_colors.risk = Color(255, 255, 204, 0) / 255
	self.screen_colors.friend_color = Color(255, 41, 204, 122) / 255
	self.screen_colors.regular_color = Color(255, 41, 150, 240) / 255
	self.screen_colors.pro_color = Color(255, 255, 51, 51) / 255
	self.screen_colors.dlc_color = Color(255, 255, 212, 0) / 255
	self.screen_colors.skill_color = Color(255, 77, 198, 255) / 255
	self.screen_colors.ghost_color = Color("4ca6ff")
	self.screen_colors.extra_bonus_color = Color(255, 255, 255, 255) / 255
	self.screen_colors.heat_cold_color = Color(255, 255, 51, 51) / 255
	self.screen_colors.heat_warm_color = Color("ff7f00")
	self.screen_colors.heat_standard_color = Color(255, 255, 255, 255) / 255
	self.screen_colors.heat_color = self.screen_colors.heat_standard_color
	self.screen_colors.stats_positive = Color(255, 191, 221, 125) / 255
	self.screen_colors.stats_negative = Color(255, 254, 93, 99) / 255
	self.screen_colors.stats_mods = Color(255, 229, 229, 76) / 255
	if Global.test_new_colors then
		for i, d in pairs(self.screen_colors) do
			self.screen_colors[i] = Color.purple
		end
	end
	if Global.old_colors_purple then
		self.screen_color_white = Color.purple
		self.screen_color_red = Color.purple
		self.screen_color_green = Color.purple
		self.screen_color_grey = Color.purple
		self.screen_color_light_grey = Color.purple
		self.screen_color_blue = Color.purple
		self.screen_color_blue_selected = Color.purple
		self.screen_color_blue_highlighted = Color.purple
		self.screen_color_blue_noselected = Color.purple
		self.screen_color_yellow = Color.purple
		self.screen_color_yellow_selected = Color.purple
		self.screen_color_yellow_noselected = Color.purple
	else
		self.screen_color_white = Color(1, 1, 1)
		self.screen_color_red = Color(0.7137255, 0.24705882, 0.21176471)
		self.screen_color_green = Color(0.1254902, 1, 0.5176471)
		self.screen_color_grey = Color(0.39215687, 0.39215687, 0.39215687)
		self.screen_color_light_grey = Color(0.78431374, 0.78431374, 0.78431374)
		self.screen_color_blue = Color(0.3019608, 0.7764706, 1)
		self.screen_color_blue_selected = Color(0.3019608, 0.7764706, 1)
		self.screen_color_blue_highlighted = self.screen_color_blue_selected:with_alpha(0.75)
		self.screen_color_blue_noselected = self.screen_color_blue_selected:with_alpha(0.5)
		self.screen_color_yellow = Color(0.8627451, 0.6745098, 0.1764706)
		self.screen_color_yellow_selected = Color(1, 0.8, 0)
		self.screen_color_yellow_noselected = Color(0.73333335, 0.42745098, 0.078431375)
	end
	self.dialog = {}
	self.dialog.WIDTH = 400
	self.dialog.HEIGHT = 300
	self.dialog.PADDING = 30
	self.dialog.BUTTON_PADDING = 5
	self.dialog.BUTTON_SPACING = 10
	self.dialog.FONT = self.menu.default_font
	self.dialog.BG_COLOR = self.menu.default_menu_background_color
	self.dialog.TITLE_TEXT_COLOR = Color(1, 1, 1, 1)
	self.dialog.TEXT_COLOR = self.menu.default_font_row_item_color
	self.dialog.BUTTON_BG_COLOR = Color(0, 0.5, 0.5, 0.5)
	self.dialog.BUTTON_TEXT_COLOR = self.menu.default_font_row_item_color
	self.dialog.SELECTED_BUTTON_BG_COLOR = self.menu.default_font_row_item_color
	self.dialog.SELECTED_BUTTON_TEXT_COLOR = self.menu.default_hightlight_row_item_color
	self.dialog.TITLE_SIZE = self.menu.topic_font_size
	self.dialog.TEXT_SIZE = self.menu.dialog_text_font_size
	self.dialog.BUTTON_SIZE = self.menu.dialog_title_font_size
	self.dialog.TITLE_TEXT_SPACING = 20
	self.dialog.BUTTON_TEXT_SPACING = 3
	self.dialog.DEFAULT_PRIORITY = 1
	self.dialog.MINIMUM_DURATION = 2
	self.dialog.DURATION_PER_CHAR = 0.07
	self.hud = {}
	self:set_hud_values()
	self.interaction = {}
	self.interaction.CULLING_DISTANCE = 2000
	self.interaction.INTERACT_DISTANCE = 200
	self.interaction.copy_machine_smuggle = {}
	self.interaction.copy_machine_smuggle.icon = "equipment_thermite"
	self.interaction.copy_machine_smuggle.text_id = "debug_interact_copy_machine"
	self.interaction.copy_machine_smuggle.interact_distance = 305
	self.interaction.safety_deposit = {}
	self.interaction.safety_deposit.icon = "develop"
	self.interaction.safety_deposit.text_id = "debug_interact_safety_deposit"
	self.interaction.paper_pickup = {}
	self.interaction.paper_pickup.icon = "develop"
	self.interaction.paper_pickup.text_id = "debug_interact_paper_pickup"
	self.interaction.thermite = {}
	self.interaction.thermite.icon = "equipment_thermite"
	self.interaction.thermite.text_id = "debug_interact_thermite"
	self.interaction.thermite.equipment_text_id = "debug_interact_equipment_thermite"
	self.interaction.thermite.special_equipment = "thermite"
	self.interaction.thermite.equipment_consume = true
	self.interaction.thermite.interact_distance = 300
	self.interaction.gasoline = {}
	self.interaction.gasoline.icon = "equipment_thermite"
	self.interaction.gasoline.text_id = "debug_interact_gas"
	self.interaction.gasoline.equipment_text_id = "debug_interact_equipment_gas"
	self.interaction.gasoline.special_equipment = "gas"
	self.interaction.gasoline.equipment_consume = true
	self.interaction.gasoline.interact_distance = 300
	self.interaction.gasoline_engine = {}
	self.interaction.gasoline_engine.icon = "equipment_thermite"
	self.interaction.gasoline_engine.text_id = "debug_interact_gas"
	self.interaction.gasoline_engine.equipment_text_id = "debug_interact_equipment_gas"
	self.interaction.gasoline_engine.special_equipment = "gas"
	self.interaction.gasoline_engine.equipment_consume = true
	self.interaction.gasoline_engine.interact_distance = 300
	self.interaction.gasoline_engine.timer = 20
	self.interaction.train_car = {}
	self.interaction.train_car.icon = "develop"
	self.interaction.train_car.text_id = "debug_interact_train_car"
	self.interaction.train_car.equipment_text_id = "debug_interact_equipment_gas"
	self.interaction.train_car.special_equipment = "gas"
	self.interaction.train_car.equipment_consume = true
	self.interaction.train_car.interact_distance = 400
	self.interaction.walkout_van = {}
	self.interaction.walkout_van.icon = "develop"
	self.interaction.walkout_van.text_id = "debug_interact_walkout_van"
	self.interaction.walkout_van.equipment_text_id = "debug_interact_equipment_gold"
	self.interaction.walkout_van.special_equipment = "gold"
	self.interaction.walkout_van.equipment_consume = true
	self.interaction.walkout_van.interact_distance = 400
	self.interaction.alaska_plane = {}
	self.interaction.alaska_plane.icon = "develop"
	self.interaction.alaska_plane.text_id = "debug_interact_alaska_plane"
	self.interaction.alaska_plane.equipment_text_id = "debug_interact_equipment_organs"
	self.interaction.alaska_plane.special_equipment = "organs"
	self.interaction.alaska_plane.equipment_consume = true
	self.interaction.alaska_plane.interact_distance = 400
	self.interaction.suburbia_door_crowbar = {}
	self.interaction.suburbia_door_crowbar.icon = "equipment_crowbar"
	self.interaction.suburbia_door_crowbar.text_id = "debug_interact_crowbar"
	self.interaction.suburbia_door_crowbar.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.suburbia_door_crowbar.special_equipment = "crowbar"
	self.interaction.suburbia_door_crowbar.timer = 5
	self.interaction.suburbia_door_crowbar.start_active = false
	self.interaction.suburbia_door_crowbar.sound_start = "bar_crowbar"
	self.interaction.suburbia_door_crowbar.sound_interupt = "bar_crowbar_cancel"
	self.interaction.suburbia_door_crowbar.sound_done = "bar_crowbar_end"
	self.interaction.suburbia_door_crowbar.interact_distance = 130
	self.interaction.secret_stash_trunk_crowbar = {}
	self.interaction.secret_stash_trunk_crowbar.icon = "equipment_crowbar"
	self.interaction.secret_stash_trunk_crowbar.text_id = "debug_interact_crowbar2"
	self.interaction.secret_stash_trunk_crowbar.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.secret_stash_trunk_crowbar.special_equipment = "crowbar"
	self.interaction.secret_stash_trunk_crowbar.timer = 20
	self.interaction.secret_stash_trunk_crowbar.start_active = false
	self.interaction.secret_stash_trunk_crowbar.sound_start = "und_crowbar_trunk"
	self.interaction.secret_stash_trunk_crowbar.sound_interupt = "und_crowbar_trunk_cancel"
	self.interaction.secret_stash_trunk_crowbar.sound_done = "und_crowbar_trunk_finished"
	self.interaction.requires_crowbar_interactive_template = {}
	self.interaction.requires_crowbar_interactive_template.icon = "equipment_crowbar"
	self.interaction.requires_crowbar_interactive_template.text_id = "debug_interact_crowbar_breach"
	self.interaction.requires_crowbar_interactive_template.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.requires_crowbar_interactive_template.special_equipment = "crowbar"
	self.interaction.requires_crowbar_interactive_template.timer = 8
	self.interaction.requires_crowbar_interactive_template.start_active = false
	self.interaction.requires_crowbar_interactive_template.sound_start = "crowbar_metal_work_loop"
	self.interaction.requires_crowbar_interactive_template.sound_interupt = "crowbar_metal_cancel"
	self.interaction.requires_crowbar_interactive_template.sound_done = "crowbar_metal_cancel"
	self.interaction.requires_saw_blade = {}
	self.interaction.requires_saw_blade.icon = "develop"
	self.interaction.requires_saw_blade.text_id = "hud_int_hold_add_blade"
	self.interaction.requires_saw_blade.equipment_text_id = "hud_equipment_no_saw_blade"
	self.interaction.requires_saw_blade.special_equipment = "saw_blade"
	self.interaction.requires_saw_blade.timer = 2
	self.interaction.requires_saw_blade.start_active = false
	self.interaction.requires_saw_blade.equipment_consume = true
	self.interaction.saw_blade = {}
	self.interaction.saw_blade.text_id = "hud_int_hold_take_blade"
	self.interaction.saw_blade.action_text_id = "hud_action_taking_saw_blade"
	self.interaction.saw_blade.timer = 0.5
	self.interaction.saw_blade.start_active = false
	self.interaction.saw_blade.special_equipment_block = "saw_blade"
	self.interaction.open_slash_close_sec_box = {}
	self.interaction.open_slash_close_sec_box.text_id = "hud_int_hold_open_slash_close_sec_box"
	self.interaction.open_slash_close_sec_box.action_text_id = "hud_action_opening_slash_closing_sec_box"
	self.interaction.open_slash_close_sec_box.timer = 0.5
	self.interaction.open_slash_close_sec_box.start_active = false
	self.interaction.activate_camera = {}
	self.interaction.activate_camera.text_id = "hud_int_hold_activate_camera"
	self.interaction.activate_camera.action_text_id = "hud_action_activating_camera"
	self.interaction.activate_camera.timer = 0.5
	self.interaction.activate_camera.start_active = false
	self.interaction.requires_ecm_jammer = {}
	self.interaction.requires_ecm_jammer.icon = "equipment_ecm_jammer"
	self.interaction.requires_ecm_jammer.contour = "interactable_icon"
	self.interaction.requires_ecm_jammer.text_id = "hud_int_use_ecm_jammer"
	self.interaction.requires_ecm_jammer.required_deployable = "ecm_jammer"
	self.interaction.requires_ecm_jammer.deployable_consume = true
	self.interaction.requires_ecm_jammer.timer = 4
	self.interaction.requires_ecm_jammer.sound_start = "bar_c4_apply"
	self.interaction.requires_ecm_jammer.sound_interupt = "bar_c4_apply_cancel"
	self.interaction.requires_ecm_jammer.sound_done = "bar_c4_apply_finished"
	self.interaction.requires_ecm_jammer.axis = "y"
	self.interaction.requires_ecm_jammer.action_text_id = "hud_action_placing_ecm_jammer"
	self.interaction.requires_ecm_jammer.requires_upgrade = {
		category = "ecm_jammer",
		upgrade = "can_open_sec_doors"
	}
	self.interaction.requires_ecm_jammer_atm = deep_clone(self.interaction.requires_ecm_jammer)
	self.interaction.requires_ecm_jammer_atm.timer = 8
	self.interaction.requires_ecm_jammer_atm.requires_upgrade = {
		category = "ecm_jammer",
		upgrade = "affects_cameras"
	}
	self.interaction.weapon_cache_drop_zone = {}
	self.interaction.weapon_cache_drop_zone.icon = "equipment_vial"
	self.interaction.weapon_cache_drop_zone.text_id = "debug_interact_hospital_veil_container"
	self.interaction.weapon_cache_drop_zone.equipment_text_id = "debug_interact_equipment_blood_sample_verified"
	self.interaction.weapon_cache_drop_zone.special_equipment = "blood_sample"
	self.interaction.weapon_cache_drop_zone.equipment_consume = true
	self.interaction.weapon_cache_drop_zone.start_active = false
	self.interaction.weapon_cache_drop_zone.timer = 2
	self.interaction.secret_stash_limo_roof_crowbar = {}
	self.interaction.secret_stash_limo_roof_crowbar.icon = "develop"
	self.interaction.secret_stash_limo_roof_crowbar.text_id = "debug_interact_hold_to_breach"
	self.interaction.secret_stash_limo_roof_crowbar.timer = 5
	self.interaction.secret_stash_limo_roof_crowbar.start_active = false
	self.interaction.secret_stash_limo_roof_crowbar.sound_start = "und_limo_chassis_open"
	self.interaction.secret_stash_limo_roof_crowbar.sound_interupt = "und_limo_chassis_open_stop"
	self.interaction.secret_stash_limo_roof_crowbar.sound_done = "und_limo_chassis_open_stop"
	self.interaction.secret_stash_limo_roof_crowbar.axis = "y"
	self.interaction.suburbia_iron_gate_crowbar = {}
	self.interaction.suburbia_iron_gate_crowbar.icon = "equipment_crowbar"
	self.interaction.suburbia_iron_gate_crowbar.text_id = "debug_interact_crowbar"
	self.interaction.suburbia_iron_gate_crowbar.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.suburbia_iron_gate_crowbar.special_equipment = "crowbar"
	self.interaction.suburbia_iron_gate_crowbar.timer = 5
	self.interaction.suburbia_iron_gate_crowbar.start_active = false
	self.interaction.suburbia_iron_gate_crowbar.sound_start = "crowbar_metal_work_loop"
	self.interaction.suburbia_iron_gate_crowbar.sound_interupt = "crowbar_metal_cancel"
	self.interaction.apartment_key = {}
	self.interaction.apartment_key.icon = "equipment_chavez_key"
	self.interaction.apartment_key.text_id = "debug_interact_apartment_key"
	self.interaction.apartment_key.equipment_text_id = "debug_interact_equiptment_apartment_key"
	self.interaction.apartment_key.special_equipment = "chavez_key"
	self.interaction.apartment_key.equipment_consume = true
	self.interaction.apartment_key.interact_distance = 150
	self.interaction.hospital_sample_validation_machine = {}
	self.interaction.hospital_sample_validation_machine.icon = "equipment_vial"
	self.interaction.hospital_sample_validation_machine.text_id = "debug_interact_sample_validation"
	self.interaction.hospital_sample_validation_machine.equipment_text_id = "debug_interact_equiptment_sample_validation"
	self.interaction.hospital_sample_validation_machine.special_equipment = "blood_sample"
	self.interaction.hospital_sample_validation_machine.equipment_consume = true
	self.interaction.hospital_sample_validation_machine.start_active = false
	self.interaction.hospital_sample_validation_machine.interact_distance = 150
	self.interaction.hospital_sample_validation_machine.axis = "y"
	self.interaction.methlab_bubbling = {}
	self.interaction.methlab_bubbling.icon = "develop"
	self.interaction.methlab_bubbling.text_id = "hud_int_methlab_bubbling"
	self.interaction.methlab_bubbling.equipment_text_id = "hud_int_no_acid"
	self.interaction.methlab_bubbling.special_equipment = "acid"
	self.interaction.methlab_bubbling.equipment_consume = true
	self.interaction.methlab_bubbling.start_active = false
	self.interaction.methlab_bubbling.timer = 1
	self.interaction.methlab_bubbling.action_text_id = "hud_action_methlab_bubbling"
	self.interaction.methlab_bubbling.sound_start = "liquid_pour"
	self.interaction.methlab_bubbling.sound_interupt = "liquid_pour_stop"
	self.interaction.methlab_bubbling.sound_done = "liquid_pour_stop"
	self.interaction.methlab_caustic_cooler = {}
	self.interaction.methlab_caustic_cooler.icon = "develop"
	self.interaction.methlab_caustic_cooler.text_id = "hud_int_methlab_caustic_cooler"
	self.interaction.methlab_caustic_cooler.equipment_text_id = "hud_int_no_caustic_soda"
	self.interaction.methlab_caustic_cooler.special_equipment = "caustic_soda"
	self.interaction.methlab_caustic_cooler.equipment_consume = true
	self.interaction.methlab_caustic_cooler.start_active = false
	self.interaction.methlab_caustic_cooler.timer = 1
	self.interaction.methlab_caustic_cooler.action_text_id = "hud_action_methlab_caustic_cooler"
	self.interaction.methlab_caustic_cooler.sound_start = "liquid_pour"
	self.interaction.methlab_caustic_cooler.sound_interupt = "liquid_pour_stop"
	self.interaction.methlab_caustic_cooler.sound_done = "liquid_pour_stop"
	self.interaction.methlab_gas_to_salt = {}
	self.interaction.methlab_gas_to_salt.icon = "develop"
	self.interaction.methlab_gas_to_salt.text_id = "hud_int_methlab_gas_to_salt"
	self.interaction.methlab_gas_to_salt.equipment_text_id = "hud_int_no_hydrogen_chloride"
	self.interaction.methlab_gas_to_salt.special_equipment = "hydrogen_chloride"
	self.interaction.methlab_gas_to_salt.equipment_consume = true
	self.interaction.methlab_gas_to_salt.start_active = false
	self.interaction.methlab_gas_to_salt.timer = 1
	self.interaction.methlab_gas_to_salt.action_text_id = "hud_action_methlab_gas_to_salt"
	self.interaction.methlab_gas_to_salt.sound_start = "bar_bag_generic"
	self.interaction.methlab_gas_to_salt.sound_interupt = "bar_bag_generic_cancel"
	self.interaction.methlab_gas_to_salt.sound_done = "bar_bag_generic_finished"
	self.interaction.methlab_drying_meth = {}
	self.interaction.methlab_drying_meth.icon = "develop"
	self.interaction.methlab_drying_meth.text_id = "hud_int_methlab_drying_meth"
	self.interaction.methlab_drying_meth.equipment_text_id = "hud_int_no_liquid_meth"
	self.interaction.methlab_drying_meth.special_equipment = "liquid_meth"
	self.interaction.methlab_drying_meth.equipment_consume = true
	self.interaction.methlab_drying_meth.start_active = false
	self.interaction.methlab_drying_meth.timer = 1
	self.interaction.methlab_drying_meth.action_text_id = "hud_action_methlab_drying_meth"
	self.interaction.methlab_drying_meth.sound_start = "liquid_pour"
	self.interaction.methlab_drying_meth.sound_interupt = "liquid_pour_stop"
	self.interaction.methlab_drying_meth.sound_done = "liquid_pour_stop"
	self.interaction.muriatic_acid = {}
	self.interaction.muriatic_acid.icon = "develop"
	self.interaction.muriatic_acid.text_id = "hud_int_take_acid"
	self.interaction.muriatic_acid.start_active = false
	self.interaction.muriatic_acid.interact_distance = 225
	self.interaction.muriatic_acid.special_equipment_block = "acid"
	self.interaction.caustic_soda = {}
	self.interaction.caustic_soda.icon = "develop"
	self.interaction.caustic_soda.text_id = "hud_int_take_caustic_soda"
	self.interaction.caustic_soda.start_active = false
	self.interaction.caustic_soda.interact_distance = 225
	self.interaction.caustic_soda.special_equipment_block = "caustic_soda"
	self.interaction.hydrogen_chloride = {}
	self.interaction.hydrogen_chloride.icon = "develop"
	self.interaction.hydrogen_chloride.text_id = "hud_int_take_hydrogen_chloride"
	self.interaction.hydrogen_chloride.start_active = false
	self.interaction.hydrogen_chloride.interact_distance = 225
	self.interaction.hydrogen_chloride.special_equipment_block = "hydrogen_chloride"
	self.interaction.elevator_button = {}
	self.interaction.elevator_button.icon = "interaction_elevator"
	self.interaction.elevator_button.text_id = "debug_interact_elevator_door"
	self.interaction.elevator_button.start_active = false
	self.interaction.use_computer = {}
	self.interaction.use_computer.icon = "interaction_elevator"
	self.interaction.use_computer.text_id = "hud_int_use_computer"
	self.interaction.use_computer.start_active = false
	self.interaction.use_computer.timer = 2
	self.interaction.elevator_button_roof = {}
	self.interaction.elevator_button_roof.icon = "interaction_elevator"
	self.interaction.elevator_button_roof.text_id = "debug_interact_elevator_door_roof"
	self.interaction.elevator_button_roof.start_active = false
	self.interaction.key = {}
	self.interaction.key.icon = "equipment_bank_manager_key"
	self.interaction.key.text_id = "hud_int_equipment_keycard"
	self.interaction.key.equipment_text_id = "hud_int_equipment_no_keycard"
	self.interaction.key.special_equipment = "bank_manager_key"
	self.interaction.key.equipment_consume = true
	self.interaction.key.axis = "x"
	self.interaction.key.interact_distance = 100
	self.interaction.numpad = {}
	self.interaction.numpad.icon = "equipment_bank_manager_key"
	self.interaction.numpad.text_id = "debug_interact_numpad"
	self.interaction.numpad.start_active = false
	self.interaction.numpad.axis = "z"
	self.interaction.numpad_keycard = {}
	self.interaction.numpad_keycard.icon = "equipment_bank_manager_key"
	self.interaction.numpad_keycard.text_id = "hud_int_numpad_keycard"
	self.interaction.numpad_keycard.equipment_text_id = "hud_int_numpad_no_keycard"
	self.interaction.numpad_keycard.special_equipment = "bank_manager_key"
	self.interaction.numpad_keycard.equipment_consume = true
	self.interaction.numpad_keycard.start_active = false
	self.interaction.numpad_keycard.axis = "z"
	self.interaction.timelock_panel = {}
	self.interaction.timelock_panel.icon = "equipment_bank_manager_key"
	self.interaction.timelock_panel.text_id = "hud_int_timelock_panel"
	self.interaction.timelock_panel.equipment_text_id = "hud_int_equipment_no_keycard"
	self.interaction.timelock_panel.special_equipment = "bank_manager_key"
	self.interaction.timelock_panel.equipment_consume = true
	self.interaction.timelock_panel.start_active = false
	self.interaction.timelock_panel.axis = "z"
	self.interaction.take_weapons = {}
	self.interaction.take_weapons.icon = "develop"
	self.interaction.take_weapons.text_id = "hud_int_take_weapons"
	self.interaction.take_weapons.action_text_id = "hud_action_taking_weapons"
	self.interaction.take_weapons.timer = 3
	self.interaction.take_weapons.axis = "x"
	self.interaction.take_weapons.interact_distance = 120
	self.interaction.take_weapons_not_active = deep_clone(self.interaction.take_weapons)
	self.interaction.take_weapons_not_active.start_active = false
	self.interaction.pick_lock_easy = {}
	self.interaction.pick_lock_easy.contour = "interactable_icon"
	self.interaction.pick_lock_easy.icon = "equipment_bank_manager_key"
	self.interaction.pick_lock_easy.text_id = "hud_int_pick_lock"
	self.interaction.pick_lock_easy.start_active = true
	self.interaction.pick_lock_easy.timer = 10
	self.interaction.pick_lock_easy.interact_distance = 100
	self.interaction.pick_lock_easy.requires_upgrade = {
		category = "player",
		upgrade = "pick_lock_easy"
	}
	self.interaction.pick_lock_easy.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "pick_lock_easy_speed_multiplier"
	}
	self.interaction.pick_lock_easy.action_text_id = "hud_action_picking_lock"
	self.interaction.pick_lock_easy.sound_start = "bar_pick_lock"
	self.interaction.pick_lock_easy.sound_interupt = "bar_pick_lock_cancel"
	self.interaction.pick_lock_easy.sound_done = "bar_pick_lock_finished"
	self.interaction.pick_lock_easy_no_skill = {}
	self.interaction.pick_lock_easy_no_skill.contour = "interactable_icon"
	self.interaction.pick_lock_easy_no_skill.icon = "equipment_bank_manager_key"
	self.interaction.pick_lock_easy_no_skill.text_id = "hud_int_pick_lock"
	self.interaction.pick_lock_easy_no_skill.start_active = true
	self.interaction.pick_lock_easy_no_skill.timer = 7
	self.interaction.pick_lock_easy_no_skill.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "pick_lock_easy_speed_multiplier"
	}
	self.interaction.pick_lock_easy_no_skill.action_text_id = "hud_action_picking_lock"
	self.interaction.pick_lock_easy_no_skill.interact_distance = 100
	self.interaction.pick_lock_easy_no_skill.sound_start = "bar_pick_lock"
	self.interaction.pick_lock_easy_no_skill.sound_interupt = "bar_pick_lock_cancel"
	self.interaction.pick_lock_easy_no_skill.sound_done = "bar_pick_lock_finished"
	self.interaction.pick_lock_hard = {}
	self.interaction.pick_lock_hard.contour = "interactable_icon"
	self.interaction.pick_lock_hard.icon = "equipment_bank_manager_key"
	self.interaction.pick_lock_hard.text_id = "hud_int_pick_lock"
	self.interaction.pick_lock_hard.start_active = true
	self.interaction.pick_lock_hard.timer = 45
	self.interaction.pick_lock_hard.requires_upgrade = {
		category = "player",
		upgrade = "pick_lock_hard"
	}
	self.interaction.pick_lock_hard.action_text_id = "hud_action_picking_lock"
	self.interaction.pick_lock_hard.sound_start = "bar_pick_lock"
	self.interaction.pick_lock_hard.sound_interupt = "bar_pick_lock_cancel"
	self.interaction.pick_lock_hard.sound_done = "bar_pick_lock_finished"
	self.interaction.pick_lock_hard_no_skill = {}
	self.interaction.pick_lock_hard_no_skill.contour = "interactable_icon"
	self.interaction.pick_lock_hard_no_skill.icon = "equipment_bank_manager_key"
	self.interaction.pick_lock_hard_no_skill.text_id = "hud_int_pick_lock"
	self.interaction.pick_lock_hard_no_skill.start_active = true
	self.interaction.pick_lock_hard_no_skill.timer = 20
	self.interaction.pick_lock_hard_no_skill.action_text_id = "hud_action_picking_lock"
	self.interaction.pick_lock_hard_no_skill.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "pick_lock_easy_speed_multiplier"
	}
	self.interaction.pick_lock_hard_no_skill.interact_distance = 100
	self.interaction.pick_lock_hard_no_skill.sound_start = "bar_pick_lock"
	self.interaction.pick_lock_hard_no_skill.sound_interupt = "bar_pick_lock_cancel"
	self.interaction.pick_lock_hard_no_skill.sound_done = "bar_pick_lock_finished"
	self.interaction.pick_lock_deposit_transport = deep_clone(self.interaction.pick_lock_hard_no_skill)
	self.interaction.pick_lock_deposit_transport.timer = 15
	self.interaction.pick_lock_deposit_transport.axis = "y"
	self.interaction.pick_lock_deposit_transport.interact_distance = 80
	self.interaction.open_door_with_keys = {}
	self.interaction.open_door_with_keys.contour = "interactable_icon"
	self.interaction.open_door_with_keys.icon = "equipment_bank_manager_key"
	self.interaction.open_door_with_keys.text_id = "hud_int_try_keys"
	self.interaction.open_door_with_keys.start_active = false
	self.interaction.open_door_with_keys.timer = 5
	self.interaction.open_door_with_keys.action_text_id = "hud_action_try_keys"
	self.interaction.open_door_with_keys.interact_distance = 100
	self.interaction.open_door_with_keys.sound_start = "bar_pick_lock"
	self.interaction.open_door_with_keys.sound_interupt = "bar_pick_lock_cancel"
	self.interaction.open_door_with_keys.sound_done = "bar_pick_lock_finished"
	self.interaction.open_door_with_keys.special_equipment = "keychain"
	self.interaction.open_door_with_keys.equipment_text_id = "hud_action_try_keys_no_key"
	self.interaction.cant_pick_lock = {}
	self.interaction.cant_pick_lock.icon = "equipment_bank_manager_key"
	self.interaction.cant_pick_lock.text_id = "hud_int_pick_lock"
	self.interaction.cant_pick_lock.start_active = false
	self.interaction.cant_pick_lock.interact_distance = 80
	self.interaction.hospital_veil_container = {}
	self.interaction.hospital_veil_container.icon = "equipment_vialOK"
	self.interaction.hospital_veil_container.text_id = "debug_interact_hospital_veil_container"
	self.interaction.hospital_veil_container.equipment_text_id = "debug_interact_equipment_blood_sample_verified"
	self.interaction.hospital_veil_container.special_equipment = "blood_sample_verified"
	self.interaction.hospital_veil_container.equipment_consume = true
	self.interaction.hospital_veil_container.start_active = false
	self.interaction.hospital_veil_container.timer = 2
	self.interaction.hospital_veil_container.axis = "y"
	self.interaction.hospital_phone = {}
	self.interaction.hospital_phone.icon = "interaction_answerphone"
	self.interaction.hospital_phone.text_id = "debug_interact_hospital_phone"
	self.interaction.hospital_phone.start_active = false
	self.interaction.hospital_security_cable = {}
	self.interaction.hospital_security_cable.text_id = "debug_interact_hospital_security_cable"
	self.interaction.hospital_security_cable.icon = "interaction_wirecutter"
	self.interaction.hospital_security_cable.start_active = false
	self.interaction.hospital_security_cable.timer = 5
	self.interaction.hospital_security_cable.interact_distance = 75
	self.interaction.hospital_veil = {}
	self.interaction.hospital_veil.icon = "equipment_vial"
	self.interaction.hospital_veil.text_id = "debug_interact_hospital_veil_hold"
	self.interaction.hospital_veil.start_active = false
	self.interaction.hospital_veil.timer = 2
	self.interaction.hospital_veil_take = {}
	self.interaction.hospital_veil_take.icon = "equipment_vial"
	self.interaction.hospital_veil_take.text_id = "debug_interact_hospital_veil_take"
	self.interaction.hospital_veil_take.start_active = false
	self.interaction.hospital_sentry = {}
	self.interaction.hospital_sentry.icon = "interaction_sentrygun"
	self.interaction.hospital_sentry.text_id = "debug_interact_hospital_sentry"
	self.interaction.hospital_sentry.start_active = false
	self.interaction.hospital_sentry.timer = 2
	self.interaction.drill = {}
	self.interaction.drill.icon = "equipment_drill"
	self.interaction.drill.contour = "interactable_icon"
	self.interaction.drill.text_id = "hud_int_equipment_drill"
	self.interaction.drill.equipment_text_id = "hud_int_equipment_no_drill"
	self.interaction.drill.timer = 3
	self.interaction.drill.blocked_hint = "no_drill"
	self.interaction.drill.sound_start = "bar_drill_apply"
	self.interaction.drill.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.drill.sound_done = "bar_drill_apply_finished"
	self.interaction.drill.axis = "y"
	self.interaction.drill.action_text_id = "hud_action_placing_drill"
	self.interaction.drill_upgrade = {}
	self.interaction.drill_upgrade.icon = "equipment_drill"
	self.interaction.drill_upgrade.contour = "upgradable"
	self.interaction.drill_upgrade.text_id = "hud_int_equipment_drill_upgrade"
	self.interaction.drill_upgrade.timer = 10
	self.interaction.drill_upgrade.sound_start = "bar_drill_apply"
	self.interaction.drill_upgrade.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.drill_upgrade.sound_done = "bar_drill_apply_finished"
	self.interaction.drill_upgrade.action_text_id = "hud_action_upgrading_drill"
	self.interaction.drill_jammed = {}
	self.interaction.drill_jammed.icon = "equipment_drill"
	self.interaction.drill_jammed.text_id = "hud_int_equipment_drill_jammed"
	self.interaction.drill_jammed.timer = 10
	self.interaction.drill_jammed.sound_start = "bar_drill_fix"
	self.interaction.drill_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.drill_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.drill_jammed.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "drill_fix_interaction_speed_multiplier"
	}
	self.interaction.drill_jammed.action_text_id = "hud_action_fixing_drill"
	self.interaction.lance = {}
	self.interaction.lance.icon = "equipment_drill"
	self.interaction.lance.contour = "interactable_icon"
	self.interaction.lance.text_id = "hud_int_equipment_lance"
	self.interaction.lance.equipment_text_id = "hud_int_equipment_no_lance"
	self.interaction.lance.timer = 3
	self.interaction.lance.blocked_hint = "no_lance"
	self.interaction.lance.sound_start = "bar_thermal_lance_apply"
	self.interaction.lance.sound_interupt = "bar_thermal_lance_apply_cancel"
	self.interaction.lance.sound_done = "bar_thermal_lance_apply_finished"
	self.interaction.lance.action_text_id = "hud_action_placing_lance"
	self.interaction.lance_jammed = {}
	self.interaction.lance_jammed.icon = "equipment_drill"
	self.interaction.lance_jammed.text_id = "hud_int_equipment_lance_jammed"
	self.interaction.lance_jammed.timer = 10
	self.interaction.lance_jammed.sound_start = "bar_thermal_lance_fix"
	self.interaction.lance_jammed.sound_interupt = "bar_thermal_lance_fix_cancel"
	self.interaction.lance_jammed.sound_done = "bar_thermal_lance_fix_finished"
	self.interaction.lance_jammed.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "drill_fix_interaction_speed_multiplier"
	}
	self.interaction.lance_jammed.action_text_id = "hud_action_fixing_lance"
	self.interaction.lance_upgrade = {}
	self.interaction.lance_upgrade.icon = "equipment_drill"
	self.interaction.lance_upgrade.contour = "upgradable"
	self.interaction.lance_upgrade.text_id = "hud_int_equipment_lance_upgrade"
	self.interaction.lance_upgrade.timer = 10
	self.interaction.lance_upgrade.sound_start = "bar_drill_apply"
	self.interaction.lance_upgrade.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.lance_upgrade.sound_done = "bar_drill_apply_finished"
	self.interaction.lance_upgrade.action_text_id = "hud_action_upgrading_lance"
	self.interaction.glass_cutter = {}
	self.interaction.glass_cutter.icon = "equipment_cutter"
	self.interaction.glass_cutter.text_id = "debug_interact_glass_cutter"
	self.interaction.glass_cutter.equipment_text_id = "debug_interact_equipment_glass_cutter"
	self.interaction.glass_cutter.special_equipment = "glass_cutter"
	self.interaction.glass_cutter.timer = 3
	self.interaction.glass_cutter.blocked_hint = "no_glass_cutter"
	self.interaction.glass_cutter.sound_start = "bar_drill_apply"
	self.interaction.glass_cutter.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.glass_cutter.sound_done = "bar_drill_apply_finished"
	self.interaction.glass_cutter_jammed = {}
	self.interaction.glass_cutter_jammed.icon = "equipment_cutter"
	self.interaction.glass_cutter_jammed.text_id = "debug_interact_cutter_jammed"
	self.interaction.glass_cutter_jammed.timer = 10
	self.interaction.glass_cutter_jammed.sound_start = "bar_drill_fix"
	self.interaction.glass_cutter_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.glass_cutter_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.hack_ipad = {}
	self.interaction.hack_ipad.icon = "equipment_hack_ipad"
	self.interaction.hack_ipad.text_id = "debug_interact_hack_ipad"
	self.interaction.hack_ipad.timer = 3
	self.interaction.hack_ipad.sound_start = "bar_drill_apply"
	self.interaction.hack_ipad.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.hack_ipad.sound_done = "bar_drill_apply_finished"
	self.interaction.hack_ipad.axis = "x"
	self.interaction.hack_ipad_jammed = {}
	self.interaction.hack_ipad_jammed.icon = "equipment_hack_ipad"
	self.interaction.hack_ipad_jammed.text_id = "debug_interact_hack_ipad_jammed"
	self.interaction.hack_ipad_jammed.timer = 10
	self.interaction.hack_ipad_jammed.sound_start = "bar_drill_fix"
	self.interaction.hack_ipad_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.hack_ipad_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.hack_suburbia = {}
	self.interaction.hack_suburbia.icon = "equipment_hack_ipad"
	self.interaction.hack_suburbia.text_id = "debug_interact_hack_ipad"
	self.interaction.hack_suburbia.timer = 5
	self.interaction.hack_suburbia.sound_start = "bar_keyboard"
	self.interaction.hack_suburbia.sound_interupt = "bar_keyboard_cancel"
	self.interaction.hack_suburbia.sound_done = "bar_keyboard_finished"
	self.interaction.hack_suburbia.axis = "x"
	self.interaction.hack_suburbia.contour = "contour_off"
	self.interaction.hack_suburbia_jammed = {}
	self.interaction.hack_suburbia_jammed.icon = "equipment_hack_ipad"
	self.interaction.hack_suburbia_jammed.text_id = "debug_interact_hack_ipad_jammed"
	self.interaction.hack_suburbia_jammed.timer = 5
	self.interaction.hack_suburbia_jammed.sound_start = "bar_keyboard"
	self.interaction.hack_suburbia_jammed.sound_interupt = "bar_keyboard_cancel"
	self.interaction.hack_suburbia_jammed.sound_done = "bar_keyboard_finished"
	self.interaction.security_station = {}
	self.interaction.security_station.icon = "equipment_hack_ipad"
	self.interaction.security_station.text_id = "debug_interact_security_station"
	self.interaction.security_station.timer = 3
	self.interaction.security_station.sound_start = "bar_drill_apply"
	self.interaction.security_station.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.security_station.sound_done = "bar_drill_apply_finished"
	self.interaction.security_station.axis = "z"
	self.interaction.security_station.start_active = false
	self.interaction.security_station.sound_start = "bar_keyboard"
	self.interaction.security_station.sound_interupt = "bar_keyboard_cancel"
	self.interaction.security_station.sound_done = "bar_keyboard_finished"
	self.interaction.security_station_keyboard = {}
	self.interaction.security_station_keyboard.icon = "interaction_keyboard"
	self.interaction.security_station_keyboard.text_id = "debug_interact_security_station"
	self.interaction.security_station_keyboard.timer = 6
	self.interaction.security_station_keyboard.axis = "z"
	self.interaction.security_station_keyboard.start_active = false
	self.interaction.security_station_keyboard.interact_distance = 150
	self.interaction.security_station_keyboard.sound_start = "bar_keyboard"
	self.interaction.security_station_keyboard.sound_interupt = "bar_keyboard_cancel"
	self.interaction.security_station_keyboard.sound_done = "bar_keyboard_finished"
	self.interaction.big_computer_hackable = {}
	self.interaction.big_computer_hackable.icon = "interaction_keyboard"
	self.interaction.big_computer_hackable.text_id = "hud_int_big_computer_hackable"
	self.interaction.big_computer_hackable.timer = 6
	self.interaction.big_computer_hackable.start_active = false
	self.interaction.big_computer_hackable.interact_distance = 200
	self.interaction.big_computer_hackable.sound_start = "bar_keyboard"
	self.interaction.big_computer_hackable.sound_interupt = "bar_keyboard_cancel"
	self.interaction.big_computer_hackable.sound_done = "bar_keyboard_finished"
	self.interaction.big_computer_not_hackable = {}
	self.interaction.big_computer_not_hackable.icon = "interaction_keyboard"
	self.interaction.big_computer_not_hackable.text_id = "hud_int_big_computer_hackable"
	self.interaction.big_computer_not_hackable.timer = 6
	self.interaction.big_computer_not_hackable.start_active = false
	self.interaction.big_computer_not_hackable.interact_distance = 200
	self.interaction.big_computer_not_hackable.sound_start = "bar_keyboard"
	self.interaction.big_computer_not_hackable.sound_interupt = "bar_keyboard_cancel"
	self.interaction.big_computer_not_hackable.sound_done = "bar_keyboard_finished"
	self.interaction.big_computer_not_hackable.equipment_text_id = "hud_int_big_computer_unhackable"
	self.interaction.big_computer_not_hackable.special_equipment = "nothing"
	self.interaction.big_computer_server = {}
	self.interaction.big_computer_server.icon = "interaction_keyboard"
	self.interaction.big_computer_server.text_id = "hud_int_big_computer_server"
	self.interaction.big_computer_server.timer = 6
	self.interaction.big_computer_server.start_active = false
	self.interaction.big_computer_server.interact_distance = 150
	self.interaction.big_computer_server.sound_start = "bar_keyboard"
	self.interaction.big_computer_server.sound_interupt = "bar_keyboard_cancel"
	self.interaction.big_computer_server.sound_done = "bar_keyboard_finished"
	self.interaction.security_station_jammed = {}
	self.interaction.security_station_jammed.icon = "interaction_keyboard"
	self.interaction.security_station_jammed.text_id = "debug_interact_security_station_jammed"
	self.interaction.security_station_jammed.timer = 10
	self.interaction.security_station_jammed.sound_start = "bar_drill_fix"
	self.interaction.security_station_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.security_station_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.security_station_jammed.axis = "z"
	self.interaction.apartment_drill = {}
	self.interaction.apartment_drill.icon = "equipment_drill"
	self.interaction.apartment_drill.text_id = "debug_interact_drill"
	self.interaction.apartment_drill.equipment_text_id = "debug_interact_equipment_drill"
	self.interaction.apartment_drill.timer = 3
	self.interaction.apartment_drill.blocked_hint = "no_drill"
	self.interaction.apartment_drill.sound_start = "bar_drill_apply"
	self.interaction.apartment_drill.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.apartment_drill.sound_done = "bar_drill_apply_finished"
	self.interaction.apartment_drill.interact_distance = 200
	self.interaction.apartment_drill_jammed = {}
	self.interaction.apartment_drill_jammed.icon = "equipment_drill"
	self.interaction.apartment_drill_jammed.text_id = "debug_interact_drill_jammed"
	self.interaction.apartment_drill_jammed.timer = 3
	self.interaction.apartment_drill_jammed.sound_start = "bar_drill_fix"
	self.interaction.apartment_drill_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.apartment_drill_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.apartment_drill_jammed.interact_distance = 200
	self.interaction.suburbia_drill = {}
	self.interaction.suburbia_drill.icon = "equipment_drill"
	self.interaction.suburbia_drill.text_id = "debug_interact_drill"
	self.interaction.suburbia_drill.equipment_text_id = "debug_interact_equipment_drill"
	self.interaction.suburbia_drill.timer = 3
	self.interaction.suburbia_drill.blocked_hint = "no_drill"
	self.interaction.suburbia_drill.sound_start = "bar_drill_apply"
	self.interaction.suburbia_drill.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.suburbia_drill.sound_done = "bar_drill_apply_finished"
	self.interaction.suburbia_drill.interact_distance = 200
	self.interaction.suburbia_drill_jammed = {}
	self.interaction.suburbia_drill_jammed.icon = "equipment_drill"
	self.interaction.suburbia_drill_jammed.text_id = "debug_interact_drill_jammed"
	self.interaction.suburbia_drill_jammed.timer = 3
	self.interaction.suburbia_drill_jammed.sound_start = "bar_drill_fix"
	self.interaction.suburbia_drill_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.suburbia_drill_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.suburbia_drill_jammed.interact_distance = 200
	self.interaction.goldheist_drill = {}
	self.interaction.goldheist_drill.icon = "equipment_drill"
	self.interaction.goldheist_drill.text_id = "debug_interact_drill"
	self.interaction.goldheist_drill.equipment_text_id = "debug_interact_equipment_drill"
	self.interaction.goldheist_drill.timer = 3
	self.interaction.goldheist_drill.blocked_hint = "no_drill"
	self.interaction.goldheist_drill.sound_start = "bar_drill_apply"
	self.interaction.goldheist_drill.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.goldheist_drill.sound_done = "bar_drill_apply_finished"
	self.interaction.goldheist_drill.interact_distance = 200
	self.interaction.goldheist_drill_jammed = {}
	self.interaction.goldheist_drill_jammed.icon = "equipment_drill"
	self.interaction.goldheist_drill_jammed.text_id = "debug_interact_drill_jammed"
	self.interaction.goldheist_drill_jammed.timer = 3
	self.interaction.goldheist_drill_jammed.sound_start = "bar_drill_fix"
	self.interaction.goldheist_drill_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.goldheist_drill_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.goldheist_drill_jammed.interact_distance = 200
	self.interaction.hospital_saw_teddy = {}
	self.interaction.hospital_saw_teddy.icon = "equipment_saw"
	self.interaction.hospital_saw_teddy.text_id = "debug_interact_hospital_saw_teddy"
	self.interaction.hospital_saw_teddy.start_active = false
	self.interaction.hospital_saw_teddy.timer = 2
	self.interaction.hospital_saw = {}
	self.interaction.hospital_saw.icon = "equipment_saw"
	self.interaction.hospital_saw.text_id = "debug_interact_saw"
	self.interaction.hospital_saw.equipment_text_id = "debug_interact_equipment_saw"
	self.interaction.hospital_saw.special_equipment = "saw"
	self.interaction.hospital_saw.timer = 3
	self.interaction.hospital_saw.sound_start = "bar_drill_apply"
	self.interaction.hospital_saw.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.hospital_saw.sound_done = "bar_drill_apply_finished"
	self.interaction.hospital_saw.interact_distance = 200
	self.interaction.hospital_saw.axis = "z"
	self.interaction.hospital_saw_jammed = {}
	self.interaction.hospital_saw_jammed.icon = "equipment_saw"
	self.interaction.hospital_saw_jammed.text_id = "debug_interact_saw_jammed"
	self.interaction.hospital_saw_jammed.timer = 3
	self.interaction.hospital_saw_jammed.sound_start = "bar_drill_fix"
	self.interaction.hospital_saw_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.hospital_saw_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.hospital_saw_jammed.interact_distance = 200
	self.interaction.hospital_saw_jammed.axis = "z"
	self.interaction.hospital_saw_jammed.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "drill_fix_interaction_speed_multiplier"
	}
	self.interaction.apartment_saw = {}
	self.interaction.apartment_saw.icon = "equipment_saw"
	self.interaction.apartment_saw.text_id = "debug_interact_saw"
	self.interaction.apartment_saw.equipment_text_id = "debug_interact_equipment_saw"
	self.interaction.apartment_saw.special_equipment = "saw"
	self.interaction.apartment_saw.timer = 3
	self.interaction.apartment_saw.sound_start = "bar_drill_apply"
	self.interaction.apartment_saw.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.apartment_saw.sound_done = "bar_drill_apply_finished"
	self.interaction.apartment_saw.interact_distance = 200
	self.interaction.apartment_saw.axis = "z"
	self.interaction.apartment_saw_jammed = {}
	self.interaction.apartment_saw_jammed.icon = "equipment_saw"
	self.interaction.apartment_saw_jammed.text_id = "debug_interact_saw_jammed"
	self.interaction.apartment_saw_jammed.timer = 3
	self.interaction.apartment_saw_jammed.sound_start = "bar_drill_fix"
	self.interaction.apartment_saw_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.apartment_saw_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.apartment_saw_jammed.interact_distance = 200
	self.interaction.apartment_saw_jammed.axis = "z"
	self.interaction.apartment_saw_jammed.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "drill_fix_interaction_speed_multiplier"
	}
	self.interaction.secret_stash_saw = {}
	self.interaction.secret_stash_saw.icon = "equipment_saw"
	self.interaction.secret_stash_saw.text_id = "debug_interact_saw"
	self.interaction.secret_stash_saw.equipment_text_id = "debug_interact_equipment_saw"
	self.interaction.secret_stash_saw.special_equipment = "saw"
	self.interaction.secret_stash_saw.timer = 3
	self.interaction.secret_stash_saw.sound_start = "bar_drill_apply"
	self.interaction.secret_stash_saw.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.secret_stash_saw.sound_done = "bar_drill_apply_finished"
	self.interaction.secret_stash_saw.interact_distance = 200
	self.interaction.secret_stash_saw.axis = "z"
	self.interaction.secret_stash_saw_jammed = {}
	self.interaction.secret_stash_saw_jammed.icon = "equipment_saw"
	self.interaction.secret_stash_saw_jammed.text_id = "debug_interact_saw_jammed"
	self.interaction.secret_stash_saw_jammed.timer = 3
	self.interaction.secret_stash_saw_jammed.sound_start = "bar_drill_fix"
	self.interaction.secret_stash_saw_jammed.sound_interupt = "bar_drill_fix_cancel"
	self.interaction.secret_stash_saw_jammed.sound_done = "bar_drill_fix_finished"
	self.interaction.secret_stash_saw_jammed.interact_distance = 200
	self.interaction.secret_stash_saw_jammed.axis = "z"
	self.interaction.secret_stash_saw_jammed.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "drill_fix_interaction_speed_multiplier"
	}
	self.interaction.revive = {}
	self.interaction.revive.icon = "interaction_help"
	self.interaction.revive.text_id = "debug_interact_revive"
	self.interaction.revive.start_active = false
	self.interaction.revive.interact_distance = 300
	self.interaction.revive.axis = "z"
	self.interaction.revive.timer = 6
	self.interaction.revive.sound_start = "bar_helpup"
	self.interaction.revive.sound_interupt = "bar_helpup_cancel"
	self.interaction.revive.sound_done = "bar_helpup_finished"
	self.interaction.revive.action_text_id = "hud_action_reviving"
	self.interaction.revive.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "revive_interaction_speed_multiplier"
	}
	self.interaction.revive.contour_preset = "teammate_downed"
	self.interaction.revive.contour_preset_selected = "teammate_downed_selected"
	self.interaction.free = {}
	self.interaction.free.icon = "interaction_free"
	self.interaction.free.text_id = "debug_interact_free"
	self.interaction.free.start_active = false
	self.interaction.free.interact_distance = 300
	self.interaction.free.no_contour = true
	self.interaction.free.timer = 1
	self.interaction.free.sound_start = "bar_rescue"
	self.interaction.free.sound_interupt = "bar_rescue_cancel"
	self.interaction.free.sound_done = "bar_rescue_finished"
	self.interaction.free.action_text_id = "hud_action_freeing"
	self.interaction.hostage_trade = {}
	self.interaction.hostage_trade.icon = "interaction_trade"
	self.interaction.hostage_trade.text_id = "debug_interact_trade"
	self.interaction.hostage_trade.start_active = true
	self.interaction.hostage_trade.timer = 3
	self.interaction.hostage_trade.requires_upgrade = {
		category = "player",
		upgrade = "hostage_trade"
	}
	self.interaction.hostage_trade.action_text_id = "hud_action_trading"
	self.interaction.hostage_trade.contour_preset = "generic_interactable"
	self.interaction.hostage_trade.contour_preset_selected = "generic_interactable_selected"
	self.interaction.hostage_move = {}
	self.interaction.hostage_move.icon = "interaction_trade"
	self.interaction.hostage_move.text_id = "debug_interact_hostage_move"
	self.interaction.hostage_move.start_active = true
	self.interaction.hostage_move.timer = 1
	self.interaction.hostage_move.action_text_id = "hud_action_standing_up"
	self.interaction.hostage_move.no_contour = true
	self.interaction.hostage_move.interaction_obj = Idstring("Spine")
	self.interaction.hostage_stay = {}
	self.interaction.hostage_stay.icon = "interaction_trade"
	self.interaction.hostage_stay.text_id = "debug_interact_hostage_stay"
	self.interaction.hostage_stay.start_active = true
	self.interaction.hostage_stay.timer = 0.4
	self.interaction.hostage_stay.action_text_id = "hud_action_getting_down"
	self.interaction.hostage_stay.no_contour = true
	self.interaction.hostage_stay.interaction_obj = Idstring("Spine2")
	self.interaction.trip_mine = {}
	self.interaction.trip_mine.icon = "equipment_trip_mine"
	self.interaction.trip_mine.contour = "deployable"
	self.interaction.trip_mine.requires_upgrade = {
		category = "trip_mine",
		upgrade = "can_switch_on_off"
	}
	self.interaction.sentry_gun_refill = {}
	self.interaction.sentry_gun_refill.icon = "equipment_ammo_bag"
	self.interaction.sentry_gun_refill.text_id = "debug_interact_grenade_crate_take_grenades"
	self.interaction.sentry_gun_refill.contour = "deployable"
	self.interaction.sentry_gun_refill.requires_upgrade = {category = "sentry_gun", upgrade = "can_reload"}
	self.interaction.sentry_gun_refill.timer = 1.5
	self.interaction.sentry_gun_refill.blocked_hint = "full_grenades"
	self.interaction.sentry_gun_refill.sound_start = "bar_bag_generic"
	self.interaction.sentry_gun_refill.sound_interupt = "bar_bag_generic_cancel"
	self.interaction.sentry_gun_refill.sound_done = "bar_bag_generic_finished"
	self.interaction.sentry_gun_refill.action_text_id = "hud_action_taking_grenades"
	self.interaction.bodybags_bag = {}
	self.interaction.bodybags_bag.icon = "equipment_ammo_bag"
	self.interaction.bodybags_bag.text_id = "debug_interact_bodybags_bag_take_bodybag"
	self.interaction.bodybags_bag.contour = "deployable"
	self.interaction.bodybags_bag.timer = 1.5
	self.interaction.bodybags_bag.blocked_hint = "full_bodybags"
	self.interaction.bodybags_bag.sound_start = "bar_bag_generic"
	self.interaction.bodybags_bag.sound_interupt = "bar_bag_generic_cancel"
	self.interaction.bodybags_bag.sound_done = "bar_bag_generic_finished"
	self.interaction.bodybags_bag.action_text_id = "hud_action_grabbing_bag"
	self.interaction.grenade_crate = {}
	self.interaction.grenade_crate.icon = "equipment_ammo_bag"
	self.interaction.grenade_crate.text_id = "debug_interact_grenade_crate_take_grenades"
	self.interaction.grenade_crate.contour = "deployable"
	self.interaction.grenade_crate.timer = 1.5
	self.interaction.grenade_crate.blocked_hint = "full_grenades"
	self.interaction.grenade_crate.sound_start = "bar_bag_generic"
	self.interaction.grenade_crate.sound_interupt = "bar_bag_generic_cancel"
	self.interaction.grenade_crate.sound_done = "bar_bag_generic_finished"
	self.interaction.grenade_crate.action_text_id = "hud_action_taking_grenades"
	self.interaction.ammo_bag = {}
	self.interaction.ammo_bag.icon = "equipment_ammo_bag"
	self.interaction.ammo_bag.text_id = "debug_interact_ammo_bag_take_ammo"
	self.interaction.ammo_bag.contour = "deployable"
	self.interaction.ammo_bag.timer = 3.5
	self.interaction.ammo_bag.blocked_hint = "full_ammo"
	self.interaction.ammo_bag.sound_start = "bar_bag_generic"
	self.interaction.ammo_bag.sound_interupt = "bar_bag_generic_cancel"
	self.interaction.ammo_bag.sound_done = "bar_bag_generic_finished"
	self.interaction.ammo_bag.action_text_id = "hud_action_taking_ammo"
	self.interaction.doctor_bag = {}
	self.interaction.doctor_bag.icon = "equipment_doctor_bag"
	self.interaction.doctor_bag.text_id = "debug_interact_doctor_bag_heal"
	self.interaction.doctor_bag.contour = "deployable"
	self.interaction.doctor_bag.timer = 3.5
	self.interaction.doctor_bag.blocked_hint = "full_health"
	self.interaction.doctor_bag.sound_start = "bar_helpup"
	self.interaction.doctor_bag.sound_interupt = "bar_helpup_cancel"
	self.interaction.doctor_bag.sound_done = "bar_helpup_finished"
	self.interaction.doctor_bag.action_text_id = "hud_action_healing"
	self.interaction.doctor_bag.upgrade_timer_multiplier = {
		category = "doctor_bag",
		upgrade = "interaction_speed_multiplier"
	}
	self.interaction.ecm_jammer = {}
	self.interaction.ecm_jammer.icon = "equipment_ecm_jammer"
	self.interaction.ecm_jammer.text_id = "hud_int_equipment_ecm_feedback"
	self.interaction.ecm_jammer.contour = "deployable"
	self.interaction.ecm_jammer.requires_upgrade = {
		category = "ecm_jammer",
		upgrade = "can_activate_feedback"
	}
	self.interaction.ecm_jammer.upgrade_timer_multiplier = {
		category = "ecm_jammer",
		upgrade = "interaction_speed_multiplier"
	}
	self.interaction.ecm_jammer.timer = 2
	self.interaction.laptop_objective = {}
	self.interaction.laptop_objective.icon = "laptop_objective"
	self.interaction.laptop_objective.start_active = false
	self.interaction.laptop_objective.text_id = "debug_interact_laptop_objective"
	self.interaction.laptop_objective.timer = 15
	self.interaction.laptop_objective.sound_start = "bar_keyboard"
	self.interaction.laptop_objective.sound_interupt = "bar_keyboard_cancel"
	self.interaction.laptop_objective.sound_done = "bar_keyboard_finished"
	self.interaction.laptop_objective.say_waiting = "i01x_any"
	self.interaction.laptop_objective.axis = "z"
	self.interaction.laptop_objective.interact_distance = 100
	self.interaction.money_bag = {}
	self.interaction.money_bag.icon = "equipment_money_bag"
	self.interaction.money_bag.text_id = "debug_interact_money_bag"
	self.interaction.money_bag.equipment_text_id = "debug_interact_equipment_money_bag"
	self.interaction.money_bag.special_equipment = "money_bag"
	self.interaction.money_bag.equipment_consume = false
	self.interaction.money_bag.sound_event = "ammo_bag_drop"
	self.interaction.apartment_helicopter = {}
	self.interaction.apartment_helicopter.icon = "develop"
	self.interaction.apartment_helicopter.text_id = "debug_interact_apartment_helicopter"
	self.interaction.apartment_helicopter.sound_event = "ammo_bag_drop"
	self.interaction.apartment_helicopter.timer = 13
	self.interaction.apartment_helicopter.interact_distance = 350
	self.interaction.test_interactive_door = {}
	self.interaction.test_interactive_door.icon = "develop"
	self.interaction.test_interactive_door.text_id = "debug_interact_temp_interact_box"
	self.interaction.test_interactive_door.sound_event = "ammo_bag_drop"
	self.interaction.test_interactive_door_one_direction = {}
	self.interaction.test_interactive_door_one_direction.icon = "develop"
	self.interaction.test_interactive_door_one_direction.text_id = "debug_interact_temp_interact_box"
	self.interaction.test_interactive_door_one_direction.sound_event = "ammo_bag_drop"
	self.interaction.test_interactive_door_one_direction.axis = "y"
	self.interaction.temp_interact_box = {}
	self.interaction.temp_interact_box.icon = "develop"
	self.interaction.temp_interact_box.text_id = "debug_interact_temp_interact_box"
	self.interaction.temp_interact_box.sound_event = "ammo_bag_drop"
	self.interaction.temp_interact_box.timer = 4
	self.interaction.requires_cable_ties = {}
	self.interaction.requires_cable_ties.icon = "develop"
	self.interaction.requires_cable_ties.text_id = "debug_interact_temp_interact_box"
	self.interaction.requires_cable_ties.equipment_text_id = "debug_interact_equipment_requires_cable_ties"
	self.interaction.requires_cable_ties.sound_event = "ammo_bag_drop"
	self.interaction.requires_cable_ties.special_equipment = "cable_tie"
	self.interaction.requires_cable_ties.equipment_consume = true
	self.interaction.requires_cable_ties.timer = 5
	self.interaction.requires_cable_ties.requires_upgrade = {
		category = "cable_tie",
		upgrade = "can_cable_tie_doors"
	}
	self.interaction.requires_cable_ties.upgrade_timer_multiplier = {
		category = "cable_tie",
		upgrade = "interact_speed_multiplier"
	}
	self.interaction.temp_interact_box_no_timer = {}
	self.interaction.temp_interact_box_no_timer.icon = "develop"
	self.interaction.temp_interact_box_no_timer.text_id = "debug_interact_temp_interact_box"
	self.interaction.access_camera = {}
	self.interaction.access_camera.icon = "develop"
	self.interaction.access_camera.text_id = "hud_int_access_camera"
	self.interaction.access_camera.interact_distance = 125
	self.interaction.interaction_ball = {}
	self.interaction.interaction_ball.icon = "develop"
	self.interaction.interaction_ball.text_id = "debug_interact_interaction_ball"
	self.interaction.interaction_ball.timer = 5
	self.interaction.interaction_ball.sound_start = "cft_hose_loop"
	self.interaction.interaction_ball.sound_interupt = "cft_hose_cancel"
	self.interaction.interaction_ball.sound_done = "cft_hose_end"
	self.interaction.invisible_interaction_open = {}
	self.interaction.invisible_interaction_open.icon = "develop"
	self.interaction.invisible_interaction_open.text_id = "hud_int_invisible_interaction_open"
	self.interaction.invisible_interaction_open.timer = 0.5
	self.interaction.fork_lift_sound = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.fork_lift_sound.text_id = "hud_int_fork_lift_sound"
	self.interaction.money_briefcase = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.money_briefcase.axis = "x"
	self.interaction.grenade_briefcase = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.grenade_briefcase.contour = "deployable"
	self.interaction.cash_register = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.cash_register.axis = "x"
	self.interaction.cash_register.interact_distance = 110
	self.interaction.atm_interaction = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.atm_interaction.start_active = false
	self.interaction.atm_interaction.contour = "interactable_icon"
	self.interaction.weapon_case = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.weapon_case.axis = "x"
	self.interaction.weapon_case.interact_distance = 110
	self.interaction.weapon_case_close = deep_clone(self.interaction.weapon_case)
	self.interaction.weapon_case_close.text_id = "hud_int_invisible_interaction_close"
	self.interaction.invisible_interaction_close = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.invisible_interaction_close.text_id = "hud_int_invisible_interaction_close"
	self.interaction.interact_gen_pku_loot_take = {}
	self.interaction.interact_gen_pku_loot_take.icon = "develop"
	self.interaction.interact_gen_pku_loot_take.text_id = "debug_interact_gen_pku_loot_take"
	self.interaction.interact_gen_pku_loot_take.timer = 2
	self.interaction.water_tap = {}
	self.interaction.water_tap.icon = "develop"
	self.interaction.water_tap.text_id = "debug_interact_water_tap"
	self.interaction.water_tap.timer = 3
	self.interaction.water_tap.start_active = false
	self.interaction.water_tap.axis = "y"
	self.interaction.water_manhole = {}
	self.interaction.water_manhole.icon = "develop"
	self.interaction.water_manhole.text_id = "debug_interact_water_tap"
	self.interaction.water_manhole.timer = 3
	self.interaction.water_manhole.start_active = false
	self.interaction.water_manhole.axis = "z"
	self.interaction.water_manhole.interact_distance = 200
	self.interaction.sewer_manhole = {}
	self.interaction.sewer_manhole.icon = "develop"
	self.interaction.sewer_manhole.text_id = "debug_interact_sewer_manhole"
	self.interaction.sewer_manhole.timer = 3
	self.interaction.sewer_manhole.start_active = false
	self.interaction.sewer_manhole.interact_distance = 200
	self.interaction.sewer_manhole.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.circuit_breaker = {}
	self.interaction.circuit_breaker.icon = "interaction_powerbox"
	self.interaction.circuit_breaker.text_id = "debug_interact_circuit_breaker"
	self.interaction.circuit_breaker.start_active = false
	self.interaction.circuit_breaker.axis = "z"
	self.interaction.transformer_box = {}
	self.interaction.transformer_box.icon = "interaction_powerbox"
	self.interaction.transformer_box.text_id = "debug_interact_transformer_box"
	self.interaction.transformer_box.start_active = false
	self.interaction.transformer_box.axis = "y"
	self.interaction.transformer_box.timer = 5
	self.interaction.stash_server_cord = {}
	self.interaction.stash_server_cord.icon = "interaction_powercord"
	self.interaction.stash_server_cord.text_id = "debug_interact_stash_server_cord"
	self.interaction.stash_server_cord.start_active = false
	self.interaction.stash_server_cord.axis = "z"
	self.interaction.stash_planks = {}
	self.interaction.stash_planks.icon = "equipment_planks"
	self.interaction.stash_planks.contour = "interactable_icon"
	self.interaction.stash_planks.text_id = "debug_interact_stash_planks"
	self.interaction.stash_planks.start_active = false
	self.interaction.stash_planks.timer = 2.5
	self.interaction.stash_planks.equipment_text_id = "debug_interact_equipment_stash_planks"
	self.interaction.stash_planks.special_equipment = "planks"
	self.interaction.stash_planks.equipment_consume = true
	self.interaction.stash_planks.sound_start = "bar_barricade_window"
	self.interaction.stash_planks.sound_interupt = "bar_barricade_window_cancel"
	self.interaction.stash_planks.sound_done = "bar_barricade_window_finished"
	self.interaction.stash_planks.action_text_id = "hud_action_barricading"
	self.interaction.stash_planks.axis = "z"
	self.interaction.stash_planks_pickup = {}
	self.interaction.stash_planks_pickup.icon = "equipment_planks"
	self.interaction.stash_planks_pickup.text_id = "debug_interact_stash_planks_pickup"
	self.interaction.stash_planks_pickup.start_active = false
	self.interaction.stash_planks_pickup.timer = 2
	self.interaction.stash_planks_pickup.axis = "z"
	self.interaction.stash_planks_pickup.special_equipment_block = "planks"
	self.interaction.stash_planks_pickup.sound_start = "bar_pick_up_planks"
	self.interaction.stash_planks_pickup.sound_interupt = "bar_pick_up_planks_cancel"
	self.interaction.stash_planks_pickup.sound_done = "bar_pick_up_planks_finished"
	self.interaction.stash_planks_pickup.action_text_id = "hud_action_grabbing_planks"
	self.interaction.stash_server = {}
	self.interaction.stash_server.icon = "equipment_stash_server"
	self.interaction.stash_server.text_id = "debug_interact_stash_server"
	self.interaction.stash_server.timer = 2
	self.interaction.stash_server.start_active = false
	self.interaction.stash_server.axis = "z"
	self.interaction.stash_server.equipment_text_id = "debug_interact_equipment_stash_server"
	self.interaction.stash_server.special_equipment = "server"
	self.interaction.stash_server.equipment_consume = true
	self.interaction.stash_server_pickup = {}
	self.interaction.stash_server_pickup.icon = "equipment_stash_server"
	self.interaction.stash_server_pickup.text_id = "hud_int_hold_take_hdd"
	self.interaction.stash_server_pickup.timer = 1
	self.interaction.stash_server_pickup.start_active = false
	self.interaction.stash_server_pickup.axis = "z"
	self.interaction.stash_server_pickup.special_equipment_block = "server"
	self.interaction.shelf_sliding_suburbia = {}
	self.interaction.shelf_sliding_suburbia.icon = "develop"
	self.interaction.shelf_sliding_suburbia.text_id = "debug_interact_move_bookshelf"
	self.interaction.shelf_sliding_suburbia.start_active = false
	self.interaction.shelf_sliding_suburbia.timer = 3
	self.interaction.tear_painting = {}
	self.interaction.tear_painting.icon = "develop"
	self.interaction.tear_painting.text_id = "debug_interact_tear_painting"
	self.interaction.tear_painting.start_active = false
	self.interaction.tear_painting.axis = "y"
	self.interaction.ejection_seat_interact = {}
	self.interaction.ejection_seat_interact.icon = "equipment_ejection_seat"
	self.interaction.ejection_seat_interact.text_id = "debug_interact_temp_interact_box"
	self.interaction.ejection_seat_interact.timer = 4
	self.interaction.diamond_pickup = {}
	self.interaction.diamond_pickup.icon = "interaction_diamond"
	self.interaction.diamond_pickup.text_id = "hud_int_take_jewelry"
	self.interaction.diamond_pickup.sound_event = "money_grab"
	self.interaction.diamond_pickup.start_active = false
	self.interaction.safe_loot_pickup = deep_clone(self.interaction.diamond_pickup)
	self.interaction.safe_loot_pickup.start_active = true
	self.interaction.safe_loot_pickup.text_id = "hud_int_take"
	self.interaction.tiara_pickup = {}
	self.interaction.tiara_pickup.icon = "develop"
	self.interaction.tiara_pickup.text_id = "hud_int_pickup_tiara"
	self.interaction.tiara_pickup.sound_event = "money_grab"
	self.interaction.tiara_pickup.start_active = false
	self.interaction.patientpaper_pickup = {}
	self.interaction.patientpaper_pickup.icon = "interaction_patientfile"
	self.interaction.patientpaper_pickup.text_id = "debug_interact_patient_paper"
	self.interaction.patientpaper_pickup.timer = 2
	self.interaction.patientpaper_pickup.start_active = false
	self.interaction.diamond_case = {}
	self.interaction.diamond_case.icon = "interaction_diamond"
	self.interaction.diamond_case.text_id = "debug_interact_diamond_case"
	self.interaction.diamond_case.start_active = false
	self.interaction.diamond_case.axis = "x"
	self.interaction.diamond_case.interact_distance = 150
	self.interaction.diamond_single_pickup = {}
	self.interaction.diamond_single_pickup.icon = "interaction_diamond"
	self.interaction.diamond_single_pickup.text_id = "debug_interact_temp_interact_box_press"
	self.interaction.diamond_single_pickup.sound_event = "ammo_bag_drop"
	self.interaction.diamond_single_pickup.start_active = false
	self.interaction.suburbia_necklace_pickup = {}
	self.interaction.suburbia_necklace_pickup.icon = "interaction_diamond"
	self.interaction.suburbia_necklace_pickup.text_id = "debug_interact_temp_interact_box_press"
	self.interaction.suburbia_necklace_pickup.sound_event = "ammo_bag_drop"
	self.interaction.suburbia_necklace_pickup.start_active = false
	self.interaction.suburbia_necklace_pickup.interact_distance = 100
	self.interaction.temp_interact_box2 = {}
	self.interaction.temp_interact_box2.icon = "develop"
	self.interaction.temp_interact_box2.text_id = "debug_interact_temp_interact_box"
	self.interaction.temp_interact_box2.sound_event = "ammo_bag_drop"
	self.interaction.temp_interact_box2.timer = 20
	self.interaction.printing_plates = {}
	self.interaction.printing_plates.icon = "develop"
	self.interaction.printing_plates.text_id = "debug_interact_printing_plates"
	self.interaction.printing_plates.timer = 0.25
	self.interaction.c4 = {}
	self.interaction.c4.icon = "equipment_c4"
	self.interaction.c4.text_id = "debug_interact_c4"
	self.interaction.c4.timer = 4
	self.interaction.c4.sound_start = "bar_c4_apply"
	self.interaction.c4.sound_interupt = "bar_c4_apply_cancel"
	self.interaction.c4.sound_done = "bar_c4_apply_finished"
	self.interaction.c4.action_text_id = "hud_action_placing_c4"
	self.interaction.c4_diffusible = {}
	self.interaction.c4_diffusible.icon = "equipment_c4"
	self.interaction.c4_diffusible.text_id = "debug_c4_diffusible"
	self.interaction.c4_diffusible.timer = 4
	self.interaction.c4_diffusible.sound_start = "bar_c4_apply"
	self.interaction.c4_diffusible.sound_interupt = "bar_c4_apply_cancel"
	self.interaction.c4_diffusible.sound_done = "bar_c4_apply_finished"
	self.interaction.c4_diffusible.axis = "z"
	self.interaction.open_trunk = {}
	self.interaction.open_trunk.icon = "develop"
	self.interaction.open_trunk.text_id = "debug_interact_open_trunk"
	self.interaction.open_trunk.timer = 0.5
	self.interaction.open_trunk.axis = "x"
	self.interaction.open_trunk.action_text_id = "hud_action_opening_trunk"
	self.interaction.open_door = {}
	self.interaction.open_door.icon = "interaction_open_door"
	self.interaction.open_door.text_id = "debug_interact_open_door"
	self.interaction.open_door.interact_distance = 200
	self.interaction.embassy_door = {}
	self.interaction.embassy_door.start_active = false
	self.interaction.embassy_door.icon = "interaction_open_door"
	self.interaction.embassy_door.text_id = "debug_interact_embassy_door"
	self.interaction.embassy_door.interact_distance = 150
	self.interaction.embassy_door.timer = 5
	self.interaction.c4_special = {}
	self.interaction.c4_special.icon = "equipment_c4"
	self.interaction.c4_special.text_id = "debug_interact_c4"
	self.interaction.c4_special.equipment_text_id = "debug_interact_equipment_c4"
	self.interaction.c4_special.equipment_consume = true
	self.interaction.c4_special.timer = 4
	self.interaction.c4_special.sound_start = "bar_c4_apply"
	self.interaction.c4_special.sound_interupt = "bar_c4_apply_cancel"
	self.interaction.c4_special.sound_done = "bar_c4_apply_finished"
	self.interaction.c4_special.axis = "z"
	self.interaction.c4_special.action_text_id = "hud_action_placing_c4"
	self.interaction.c4_bag = {}
	self.interaction.c4_bag.text_id = "debug_interact_c4_bag"
	self.interaction.c4_bag.timer = 8
	self.interaction.c4_bag.contour = "interactable"
	self.interaction.c4_bag.axis = "z"
	self.interaction.c4_bag.sound_start = "bar_bag_generic"
	self.interaction.c4_bag.sound_interupt = "bar_bag_generic_cancel"
	self.interaction.c4_bag.sound_done = "bar_bag_generic_finished"
	self.interaction.money_wrap = {}
	self.interaction.money_wrap.icon = "interaction_money_wrap"
	self.interaction.money_wrap.text_id = "debug_interact_money_wrap_take_money"
	self.interaction.money_wrap.start_active = false
	self.interaction.money_wrap.timer = 3
	self.interaction.money_wrap.action_text_id = "hud_action_taking_money"
	self.interaction.money_wrap.blocked_hint = "carry_block"
	self.interaction.money_wrap.sound_start = "bar_bag_money"
	self.interaction.money_wrap.sound_interupt = "bar_bag_money_cancel"
	self.interaction.money_wrap.sound_done = "bar_bag_money_finished"
	self.interaction.suburbia_money_wrap = {}
	self.interaction.suburbia_money_wrap.icon = "interaction_money_wrap"
	self.interaction.suburbia_money_wrap.text_id = "debug_interact_money_printed_take_money"
	self.interaction.suburbia_money_wrap.start_active = false
	self.interaction.suburbia_money_wrap.timer = 3
	self.interaction.suburbia_money_wrap.action_text_id = "hud_action_taking_money"
	self.interaction.money_wrap_single_bundle = {}
	self.interaction.money_wrap_single_bundle.icon = "interaction_money_wrap"
	self.interaction.money_wrap_single_bundle.text_id = "debug_interact_money_wrap_single_bundle_take_money"
	self.interaction.money_wrap_single_bundle.start_active = false
	self.interaction.money_wrap_single_bundle.interact_distance = 110
	self.interaction.christmas_present = {}
	self.interaction.christmas_present.icon = "interaction_christmas_present"
	self.interaction.christmas_present.text_id = "debug_interact_take_christmas_present"
	self.interaction.christmas_present.start_active = true
	self.interaction.christmas_present.interact_distance = 125
	self.interaction.gold_pile = {}
	self.interaction.gold_pile.icon = "interaction_gold"
	self.interaction.gold_pile.text_id = "debug_interact_gold_pile_take_money"
	self.interaction.gold_pile.start_active = false
	self.interaction.gold_pile.timer = 1
	self.interaction.gold_pile.action_text_id = "hud_action_taking_gold"
	self.interaction.gold_pile.blocked_hint = "carry_block"
	self.interaction.gold_bag = {}
	self.interaction.gold_bag.icon = "interaction_gold"
	self.interaction.gold_bag.text_id = "debug_interact_gold_bag"
	self.interaction.gold_bag.start_active = false
	self.interaction.gold_bag.timer = 1
	self.interaction.gold_bag.special_equipment_block = "gold_bag_equip"
	self.interaction.gold_bag.action_text_id = "hud_action_taking_gold"
	self.interaction.requires_gold_bag = {}
	self.interaction.requires_gold_bag.icon = "interaction_gold"
	self.interaction.requires_gold_bag.text_id = "debug_interact_requires_gold_bag"
	self.interaction.requires_gold_bag.equipment_text_id = "debug_interact_equipment_requires_gold_bag"
	self.interaction.requires_gold_bag.special_equipment = "gold_bag_equip"
	self.interaction.requires_gold_bag.start_active = true
	self.interaction.requires_gold_bag.equipment_consume = true
	self.interaction.requires_gold_bag.timer = 1
	self.interaction.requires_gold_bag.sound_event = "ammo_bag_drop"
	self.interaction.requires_gold_bag.axis = "x"
	self.interaction.intimidate = {}
	self.interaction.intimidate.icon = "equipment_cable_ties"
	self.interaction.intimidate.text_id = "debug_interact_intimidate"
	self.interaction.intimidate.equipment_text_id = "debug_interact_equipment_cable_tie"
	self.interaction.intimidate.start_active = false
	self.interaction.intimidate.special_equipment = "cable_tie"
	self.interaction.intimidate.equipment_consume = true
	self.interaction.intimidate.no_contour = true
	self.interaction.intimidate.timer = 2
	self.interaction.intimidate.upgrade_timer_multiplier = {
		category = "cable_tie",
		upgrade = "interact_speed_multiplier"
	}
	self.interaction.intimidate.action_text_id = "hud_action_cable_tying"
	self.interaction.intimidate_and_search = {}
	self.interaction.intimidate_and_search.icon = "equipment_cable_ties"
	self.interaction.intimidate_and_search.text_id = "debug_interact_intimidate"
	self.interaction.intimidate_and_search.equipment_text_id = "debug_interact_search_key"
	self.interaction.intimidate_and_search.start_active = false
	self.interaction.intimidate_and_search.special_equipment = "cable_tie"
	self.interaction.intimidate_and_search.equipment_consume = true
	self.interaction.intimidate_and_search.dont_need_equipment = true
	self.interaction.intimidate_and_search.no_contour = true
	self.interaction.intimidate_and_search.timer = 3.5
	self.interaction.intimidate_and_search.action_text_id = "hud_action_cable_tying"
	self.interaction.intimidate_with_contour = deep_clone(self.interaction.intimidate)
	self.interaction.intimidate_with_contour.no_contour = false
	self.interaction.intimidate_and_search_with_contour = deep_clone(self.interaction.intimidate_and_search)
	self.interaction.intimidate_and_search_with_contour.no_contour = false
	self.interaction.computer_test = {}
	self.interaction.computer_test.icon = "develop"
	self.interaction.computer_test.text_id = "debug_interact_computer_test"
	self.interaction.computer_test.start_active = false
	self.interaction.carry_drop = {}
	self.interaction.carry_drop.icon = "develop"
	self.interaction.carry_drop.text_id = "hud_int_hold_grab_the_bag"
	self.interaction.carry_drop.sound_event = "ammo_bag_drop"
	self.interaction.carry_drop.timer = 1
	self.interaction.carry_drop.force_update_position = true
	self.interaction.carry_drop.action_text_id = "hud_action_grabbing_bag"
	self.interaction.carry_drop.blocked_hint = "carry_block"
	self.interaction.painting_carry_drop = {}
	self.interaction.painting_carry_drop.icon = "develop"
	self.interaction.painting_carry_drop.text_id = "hud_int_hold_grab_the_painting"
	self.interaction.painting_carry_drop.sound_event = "ammo_bag_drop"
	self.interaction.painting_carry_drop.timer = 1
	self.interaction.painting_carry_drop.force_update_position = true
	self.interaction.painting_carry_drop.action_text_id = "hud_action_grabbing_painting"
	self.interaction.painting_carry_drop.blocked_hint = "carry_block"
	self.interaction.corpse_alarm_pager = {}
	self.interaction.corpse_alarm_pager.icon = "develop"
	self.interaction.corpse_alarm_pager.text_id = "hud_int_disable_alarm_pager"
	self.interaction.corpse_alarm_pager.sound_event = "ammo_bag_drop"
	self.interaction.corpse_alarm_pager.timer = 10
	self.interaction.corpse_alarm_pager.force_update_position = true
	self.interaction.corpse_alarm_pager.action_text_id = "hud_action_disabling_alarm_pager"
	self.interaction.corpse_alarm_pager.contour_preset = "generic_interactable"
	self.interaction.corpse_alarm_pager.contour_preset_selected = "generic_interactable_selected"
	self.interaction.corpse_alarm_pager.contour_flash_interval = 0.15
	self.interaction.corpse_dispose = {}
	self.interaction.corpse_dispose.icon = "develop"
	self.interaction.corpse_dispose.text_id = "hud_int_dispose_corpse"
	self.interaction.corpse_dispose.sound_event = "ammo_bag_drop"
	self.interaction.corpse_dispose.timer = 2
	self.interaction.corpse_dispose.requires_upgrade = {
		category = "player",
		upgrade = "corpse_dispose"
	}
	self.interaction.corpse_dispose.action_text_id = "hud_action_disposing_corpse"
	self.interaction.corpse_dispose.no_contour = true
	self.interaction.shaped_sharge = {}
	self.interaction.shaped_sharge.icon = "equipment_c4"
	self.interaction.shaped_sharge.text_id = "hud_int_equipment_shaped_charge"
	self.interaction.shaped_sharge.contour = "interactable_icon"
	self.interaction.shaped_sharge.required_deployable = "trip_mine"
	self.interaction.shaped_sharge.deployable_consume = true
	self.interaction.shaped_sharge.timer = 4
	self.interaction.shaped_sharge.sound_start = "bar_c4_apply"
	self.interaction.shaped_sharge.sound_interupt = "bar_c4_apply_cancel"
	self.interaction.shaped_sharge.sound_done = "bar_c4_apply_finished"
	self.interaction.shaped_sharge.requires_upgrade = {
		category = "player",
		upgrade = "trip_mine_shaped_charge"
	}
	self.interaction.shaped_sharge.action_text_id = "hud_action_placing_shaped_charge"
	self.interaction.hostage_convert = {}
	self.interaction.hostage_convert.icon = "develop"
	self.interaction.hostage_convert.text_id = "hud_int_hostage_convert"
	self.interaction.hostage_convert.sound_event = "ammo_bag_drop"
	self.interaction.hostage_convert.blocked_hint = "convert_enemy_failed"
	self.interaction.hostage_convert.timer = 1.5
	self.interaction.hostage_convert.requires_upgrade = {
		category = "player",
		upgrade = "convert_enemies"
	}
	self.interaction.hostage_convert.upgrade_timer_multiplier = {
		category = "player",
		upgrade = "convert_enemies_interaction_speed_multiplier"
	}
	self.interaction.hostage_convert.action_text_id = "hud_action_converting_hostage"
	self.interaction.hostage_convert.no_contour = true
	self.interaction.break_open = {}
	self.interaction.break_open.icon = "develop"
	self.interaction.break_open.text_id = "hud_int_break_open"
	self.interaction.break_open.start_active = false
	self.interaction.cut_fence = {}
	self.interaction.cut_fence.text_id = "hud_int_hold_cut_fence"
	self.interaction.cut_fence.action_text_id = "hud_action_cutting_fence"
	self.interaction.cut_fence.contour = "interactable_icon"
	self.interaction.cut_fence.timer = 0.5
	self.interaction.cut_fence.start_active = true
	self.interaction.cut_fence.sound_start = "bar_cut_fence"
	self.interaction.cut_fence.sound_interupt = "bar_cut_fence_cancel"
	self.interaction.cut_fence.sound_done = "bar_cut_fence_finished"
	self.interaction.burning_money = {}
	self.interaction.burning_money.text_id = "hud_int_hold_ignite_money"
	self.interaction.burning_money.action_text_id = "hud_action_igniting_money"
	self.interaction.burning_money.timer = 2
	self.interaction.burning_money.start_active = false
	self.interaction.burning_money.interact_distance = 250
	self.interaction.hold_take_painting = {}
	self.interaction.hold_take_painting.text_id = "hud_int_hold_take_painting"
	self.interaction.hold_take_painting.action_text_id = "hud_action_taking_painting"
	self.interaction.hold_take_painting.start_active = false
	self.interaction.hold_take_painting.axis = "y"
	self.interaction.hold_take_painting.timer = 2
	self.interaction.hold_take_painting.sound_start = "bar_steal_painting"
	self.interaction.hold_take_painting.sound_interupt = "bar_steal_painting_cancel"
	self.interaction.hold_take_painting.sound_done = "bar_steal_painting_finished"
	self.interaction.hold_take_painting.blocked_hint = "carry_block"
	self.interaction.barricade_fence = deep_clone(self.interaction.stash_planks)
	self.interaction.barricade_fence.contour = "interactable_icon"
	self.interaction.barricade_fence.sound_start = "bar_barricade_fence"
	self.interaction.barricade_fence.sound_interupt = "bar_barricade_fence_cancel"
	self.interaction.barricade_fence.sound_done = "bar_barricade_fence_finished"
	self.interaction.hack_numpad = {}
	self.interaction.hack_numpad.text_id = "hud_int_hold_hack_numpad"
	self.interaction.hack_numpad.action_text_id = "hud_action_hacking_numpad"
	self.interaction.hack_numpad.start_active = false
	self.interaction.hack_numpad.timer = 15
	self.interaction.pickup_phone = {}
	self.interaction.pickup_phone.text_id = "hud_int_pickup_phone"
	self.interaction.pickup_phone.start_active = false
	self.interaction.pickup_tablet = deep_clone(self.interaction.pickup_phone)
	self.interaction.pickup_tablet.text_id = "hud_int_pickup_tablet"
	self.interaction.hold_take_server = {}
	self.interaction.hold_take_server.text_id = "hud_int_hold_take_server"
	self.interaction.hold_take_server.action_text_id = "hud_action_taking_server"
	self.interaction.hold_take_server.timer = 4
	self.interaction.hold_take_server.sound_start = "bar_steal_circuit"
	self.interaction.hold_take_server.sound_interupt = "bar_steal_circuit_cancel"
	self.interaction.hold_take_server.sound_done = "bar_steal_circuit_finished"
	self.interaction.hold_take_blueprints = {}
	self.interaction.hold_take_blueprints.text_id = "hud_int_hold_take_blueprints"
	self.interaction.hold_take_blueprints.action_text_id = "hud_action_taking_blueprints"
	self.interaction.hold_take_blueprints.start_active = false
	self.interaction.hold_take_blueprints.timer = 0.5
	self.interaction.hold_take_blueprints.sound_start = "bar_steal_painting"
	self.interaction.hold_take_blueprints.sound_interupt = "bar_steal_painting_cancel"
	self.interaction.hold_take_blueprints.sound_done = "bar_steal_painting_finished"
	self.interaction.take_confidential_folder = {}
	self.interaction.take_confidential_folder.text_id = "hud_int_take_confidential_folder"
	self.interaction.take_confidential_folder.start_active = false
	self.interaction.take_confidential_folder_event = {}
	self.interaction.take_confidential_folder_event.text_id = "hud_int_take_confidential_folder_event"
	self.interaction.take_confidential_folder_event.start_active = false
	self.interaction.hold_take_gas_can = {}
	self.interaction.hold_take_gas_can.text_id = "hud_int_hold_take_gas"
	self.interaction.hold_take_gas_can.action_text_id = "hud_action_taking_gasoline"
	self.interaction.hold_take_gas_can.start_active = false
	self.interaction.hold_take_gas_can.timer = 0.5
	self.interaction.hold_take_gas_can.special_equipment_block = "gas"
	self.interaction.gen_ladyjustice_statue = {}
	self.interaction.gen_ladyjustice_statue.text_id = "hud_int_ladyjustice_statue"
	self.interaction.hold_place_gps_tracker = {}
	self.interaction.hold_place_gps_tracker.text_id = "hud_int_hold_place_gps_tracker"
	self.interaction.hold_place_gps_tracker.action_text_id = "hud_action_placing_gps_tracker"
	self.interaction.hold_place_gps_tracker.contour = "interactable_icon"
	self.interaction.hold_place_gps_tracker.start_active = false
	self.interaction.hold_place_gps_tracker.timer = 1.5
	self.interaction.hold_place_gps_tracker.interact_distance = 200
	self.interaction.keyboard_no_time = deep_clone(self.interaction.security_station_keyboard)
	self.interaction.keyboard_no_time.timer = 2.5
	self.interaction.keyboard_eday_1 = deep_clone(self.interaction.security_station_keyboard)
	self.interaction.keyboard_eday_1.timer = 2.5
	self.interaction.keyboard_eday_1.text_id = "hud_int_keyboard_eday_1"
	self.interaction.keyboard_eday_2 = deep_clone(self.interaction.security_station_keyboard)
	self.interaction.keyboard_eday_2.timer = 2.5
	self.interaction.keyboard_eday_2.text_id = "hud_int_keyboard_eday_2"
	self.interaction.hold_use_computer = {}
	self.interaction.hold_use_computer.start_active = false
	self.interaction.hold_use_computer.text_id = "hud_int_hold_use_computer"
	self.interaction.hold_use_computer.action_text_id = "hud_action_using_computer"
	self.interaction.hold_use_computer.timer = 1
	self.interaction.hold_use_computer.axis = "z"
	self.interaction.hold_use_computer.interact_distance = 100
	self.interaction.use_server_device = {}
	self.interaction.use_server_device.text_id = "hud_int_hold_use_device"
	self.interaction.use_server_device.action_text_id = "hud_action_using_device"
	self.interaction.use_server_device.timer = 1
	self.interaction.use_server_device.start_active = false
	self.interaction.iphone_answer = {}
	self.interaction.iphone_answer.text_id = "hud_int_answer_phone"
	self.interaction.iphone_answer.start_active = false
	self.interaction.use_flare = {}
	self.interaction.use_flare.text_id = "hud_int_use_flare"
	self.interaction.use_flare.start_active = false
	self.interaction.steal_methbag = {}
	self.interaction.steal_methbag.text_id = "hud_int_hold_steal_meth"
	self.interaction.steal_methbag.action_text_id = "hud_action_stealing_meth"
	self.interaction.steal_methbag.start_active = true
	self.interaction.steal_methbag.timer = 3
	self.interaction.pickup_keycard = {}
	self.interaction.pickup_keycard.text_id = "hud_int_pickup_keycard"
	self.interaction.pickup_keycard.sound_done = "pick_up_key_card"
	self.interaction.open_from_inside = {}
	self.interaction.open_from_inside.text_id = "hud_int_invisible_interaction_open"
	self.interaction.open_from_inside.start_active = true
	self.interaction.open_from_inside.interact_distance = 100
	self.interaction.open_from_inside.timer = 0.2
	self.interaction.open_from_inside.axis = "x"
	self.interaction.money_luggage = deep_clone(self.interaction.money_wrap)
	self.interaction.money_luggage.start_active = true
	self.interaction.money_luggage.axis = "x"
	self.interaction.hold_pickup_lance = {}
	self.interaction.hold_pickup_lance.text_id = "hud_int_hold_pickup_lance"
	self.interaction.hold_pickup_lance.action_text_id = "hud_action_grabbing_lance"
	self.interaction.hold_pickup_lance.sound_event = "ammo_bag_drop"
	self.interaction.hold_pickup_lance.timer = 1
	self.interaction.barrier_numpad = {}
	self.interaction.barrier_numpad.text_id = "hud_int_barrier_numpad"
	self.interaction.barrier_numpad.start_active = false
	self.interaction.barrier_numpad.axis = "z"
	self.interaction.timelock_numpad = {}
	self.interaction.timelock_numpad.text_id = "hud_int_timelock_numpad"
	self.interaction.timelock_numpad.start_active = false
	self.interaction.timelock_numpad.axis = "z"
	self.interaction.pickup_asset = {}
	self.interaction.pickup_asset.text_id = "hud_int_pickup_asset"
	self.interaction.pickup_asset.sound_event = "ammo_bag_drop"
	self.interaction.open_slash_close = {}
	self.interaction.open_slash_close.text_id = "hud_int_open_slash_close"
	self.interaction.open_slash_close.start_active = false
	self.interaction.open_slash_close.axis = "y"
	self.interaction.open_slash_close.interact_distance = 200
	self.interaction.open_slash_close_act = {}
	self.interaction.open_slash_close_act.text_id = "hud_int_open_slash_close"
	self.interaction.open_slash_close_act.action_text_id = "hud_action_open_slash_close"
	self.interaction.open_slash_close_act.timer = 1
	self.interaction.open_slash_close_act.start_active = true
	self.interaction.raise_balloon = {}
	self.interaction.raise_balloon.text_id = "hud_int_hold_raise_balloon"
	self.interaction.raise_balloon.action_text_id = "hud_action_raise_balloon"
	self.interaction.raise_balloon.start_active = false
	self.interaction.raise_balloon.timer = 2
	self.interaction.stn_int_place_camera = {}
	self.interaction.stn_int_place_camera.text_id = "hud_int_place_camera"
	self.interaction.stn_int_place_camera.start_active = true
	self.interaction.stn_int_take_camera = {}
	self.interaction.stn_int_take_camera.text_id = "hud_int_take_camera"
	self.interaction.stn_int_take_camera.start_active = true
	self.interaction.exit_to_crimenet = {}
	self.interaction.exit_to_crimenet.text_id = "hud_int_exit_to_crimenet"
	self.interaction.exit_to_crimenet.start_active = false
	self.interaction.exit_to_crimenet.timer = 0.5
	self.interaction.gage_assignment = {}
	self.interaction.gage_assignment.icon = "develop"
	self.interaction.gage_assignment.text_id = "debug_interact_gage_assignment_take"
	self.interaction.gage_assignment.start_active = true
	self.interaction.gage_assignment.timer = 1
	self.interaction.gage_assignment.action_text_id = "hud_action_taking_gage_assignment"
	self.interaction.gage_assignment.blocked_hint = "hint_gage_mods_dlc_block"
	self.interaction.gen_pku_fusion_reactor = {}
	self.interaction.gen_pku_fusion_reactor.text_id = "hud_int_hold_take_reaktor"
	self.interaction.gen_pku_fusion_reactor.action_text_id = "hud_action_taking_reaktor"
	self.interaction.gen_pku_fusion_reactor.blocked_hint = "carry_block"
	self.interaction.gen_pku_fusion_reactor.start_active = false
	self.interaction.gen_pku_fusion_reactor.timer = 3
	self.interaction.gen_pku_fusion_reactor.no_contour = true
	self.interaction.gen_pku_fusion_reactor.sound_start = "bar_bag_money"
	self.interaction.gen_pku_fusion_reactor.sound_interupt = "bar_bag_money_cancel"
	self.interaction.gen_pku_fusion_reactor.sound_done = "bar_bag_money_finished"
	self.interaction.gen_pku_cocaine = {}
	self.interaction.gen_pku_cocaine.text_id = "hud_int_hold_take_cocaine"
	self.interaction.gen_pku_cocaine.action_text_id = "hud_action_taking_cocaine"
	self.interaction.gen_pku_cocaine.timer = 3
	self.interaction.gen_pku_cocaine.sound_start = "bar_bag_money"
	self.interaction.gen_pku_cocaine.sound_interupt = "bar_bag_money_cancel"
	self.interaction.gen_pku_cocaine.sound_done = "bar_bag_money_finished"
	self.interaction.gen_pku_cocaine.blocked_hint = "carry_block"
	self.interaction.gen_pku_artifact_statue = {}
	self.interaction.gen_pku_artifact_statue.text_id = "hud_int_hold_take_artifact"
	self.interaction.gen_pku_artifact_statue.action_text_id = "hud_action_taking_artifact"
	self.interaction.gen_pku_artifact_statue.timer = 3
	self.interaction.gen_pku_artifact_statue.start_active = false
	self.interaction.gen_pku_artifact_statue.sound_start = "bar_bag_money"
	self.interaction.gen_pku_artifact_statue.sound_interupt = "bar_bag_money_cancel"
	self.interaction.gen_pku_artifact_statue.sound_done = "bar_bag_money_finished"
	self.interaction.gen_pku_artifact_statue.blocked_hint = "carry_block"
	self.interaction.gen_pku_jewelry = {}
	self.interaction.gen_pku_jewelry.text_id = "hud_int_hold_take_jewelry"
	self.interaction.gen_pku_jewelry.action_text_id = "hud_action_taking_jewelry"
	self.interaction.gen_pku_jewelry.timer = 3
	self.interaction.gen_pku_jewelry.sound_start = "bar_bag_jewelry"
	self.interaction.gen_pku_jewelry.sound_interupt = "bar_bag_jewelry_cancel"
	self.interaction.gen_pku_jewelry.sound_done = "bar_bag_jewelry_finished"
	self.interaction.gen_pku_jewelry.blocked_hint = "carry_block"
	self.interaction.taking_meth = {}
	self.interaction.taking_meth.text_id = "hud_int_hold_take_meth"
	self.interaction.taking_meth.action_text_id = "hud_action_taking_meth"
	self.interaction.taking_meth.timer = 3
	self.interaction.taking_meth.sound_start = "bar_bag_money"
	self.interaction.taking_meth.sound_interupt = "bar_bag_money_cancel"
	self.interaction.taking_meth.sound_done = "bar_bag_money_finished"
	self.interaction.taking_meth.blocked_hint = "carry_block"
	self.interaction.gen_pku_crowbar = {}
	self.interaction.gen_pku_crowbar.text_id = "hud_int_take_crowbar"
	self.interaction.gen_pku_crowbar.special_equipment_block = "crowbar"
	self.interaction.gen_pku_crowbar.sound_done = "pick_up_crowbar"
	self.interaction.gen_pku_thermite = {}
	self.interaction.gen_pku_thermite.text_id = "hud_int_take_thermite"
	self.interaction.gen_pku_thermite.special_equipment_block = "thermite"
	self.interaction.gen_pku_thermite_paste = {}
	self.interaction.gen_pku_thermite_paste.text_id = "hud_int_take_thermite_paste"
	self.interaction.gen_pku_thermite_paste.special_equipment_block = "thermite_paste"
	self.interaction.gen_pku_thermite_paste.contour = "deployable"
	self.interaction.gen_pku_thermite_paste.sound_done = "pick_up_thermite"
	self.interaction.button_infopad = {}
	self.interaction.button_infopad.text_id = "hud_int_press_for_info"
	self.interaction.button_infopad.start_active = false
	self.interaction.button_infopad.axis = "z"
	self.interaction.crate_loot = {}
	self.interaction.crate_loot.text_id = "hud_int_hold_crack_crate"
	self.interaction.crate_loot.action_text_id = "hud_action_cracking_crate"
	self.interaction.crate_loot.timer = 2
	self.interaction.crate_loot.start_active = false
	self.interaction.crate_loot.sound_start = "bar_open_crate"
	self.interaction.crate_loot.sound_interupt = "bar_open_crate_cancel"
	self.interaction.crate_loot.sound_done = "bar_open_crate_finished"
	self.interaction.crate_loot_crowbar = deep_clone(self.interaction.crate_loot)
	self.interaction.crate_loot_crowbar.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.crate_loot_crowbar.special_equipment = "crowbar"
	self.interaction.crate_loot_crowbar.sound_start = "bar_crowbar"
	self.interaction.crate_loot_crowbar.sound_interupt = "bar_crowbar_cancel"
	self.interaction.crate_loot_crowbar.sound_done = "bar_crowbar_end"
	self.interaction.weapon_case_not_active = deep_clone(self.interaction.weapon_case)
	self.interaction.weapon_case_not_active.start_active = false
	self.interaction.crate_weapon_crowbar = deep_clone(self.interaction.weapon_case)
	self.interaction.crate_weapon_crowbar.equipment_text_id = "debug_interact_equipment_crowbar"
	self.interaction.crate_weapon_crowbar.timer = 2
	self.interaction.crate_weapon_crowbar.start_active = false
	self.interaction.crate_weapon_crowbar.special_equipment = "crowbar"
	self.interaction.crate_weapon_crowbar.sound_start = "bar_crowbar_plastic"
	self.interaction.crate_weapon_crowbar.sound_interupt = "bar_crowbar_plastic_cancel"
	self.interaction.crate_weapon_crowbar.sound_done = "bar_crowbar_plastic_finished"
	self.interaction.crate_loot_close = {}
	self.interaction.crate_loot_close.text_id = "hud_int_hold_close_crate"
	self.interaction.crate_loot_close.action_text_id = "hud_action_closing_crate"
	self.interaction.crate_loot_close.timer = 2
	self.interaction.crate_loot_close.start_active = false
	self.interaction.crate_loot_close.sound_start = "bar_close_crate"
	self.interaction.crate_loot_close.sound_interupt = "bar_close_crate_cancel"
	self.interaction.crate_loot_close.sound_done = "bar_close_crate_finished"
	self.interaction.halloween_trick = {}
	self.interaction.halloween_trick.text_id = "hud_int_trick_treat"
	self.interaction.disassemble_turret = {}
	self.interaction.disassemble_turret.text_id = "hud_int_hold_disassemble_turret"
	self.interaction.disassemble_turret.action_text_id = "hud_action_disassemble_turret"
	self.interaction.disassemble_turret.blocked_hint = "carry_block"
	self.interaction.disassemble_turret.start_active = false
	self.interaction.disassemble_turret.timer = 3
	self.interaction.disassemble_turret.sound_start = "bar_steal_circuit"
	self.interaction.disassemble_turret.sound_interupt = "bar_steal_circuit_cancel"
	self.interaction.disassemble_turret.sound_done = "bar_steal_circuit_finished"
	self.interaction.take_ammo = {}
	self.interaction.take_ammo.text_id = "hud_int_hold_pack_shells"
	self.interaction.take_ammo.action_text_id = "hud_action_packing_shells"
	self.interaction.take_ammo.blocked_hint = "carry_block"
	self.interaction.take_ammo.start_active = false
	self.interaction.take_ammo.timer = 2
	self.interaction.bank_note = {}
	self.interaction.bank_note.text_id = "hud_int_bank_note"
	self.interaction.bank_note.start_active = false
	self.interaction.bank_note.timer = 3
	self.interaction.pickup_boards = {}
	self.interaction.pickup_boards.text_id = "hud_int_hold_pickup_boards"
	self.interaction.pickup_boards.action_text_id = "hud_action_picking_up"
	self.interaction.pickup_boards.start_active = false
	self.interaction.pickup_boards.timer = 2
	self.interaction.pickup_boards.axis = "z"
	self.interaction.pickup_boards.special_equipment_block = "boards"
	self.interaction.pickup_boards.sound_start = "bar_pick_up_planks"
	self.interaction.pickup_boards.sound_interupt = "bar_pick_up_planks_cancel"
	self.interaction.pickup_boards.sound_done = "bar_pick_up_planks_finished"
	self.interaction.need_boards = {}
	self.interaction.need_boards.contour = "interactable_icon"
	self.interaction.need_boards.text_id = "debug_interact_stash_planks"
	self.interaction.need_boards.action_text_id = "hud_action_barricading"
	self.interaction.need_boards.start_active = false
	self.interaction.need_boards.timer = 2.5
	self.interaction.need_boards.equipment_text_id = "hud_equipment_need_boards"
	self.interaction.need_boards.special_equipment = "boards"
	self.interaction.need_boards.equipment_consume = true
	self.interaction.need_boards.sound_start = "bar_barricade_window"
	self.interaction.need_boards.sound_interupt = "bar_barricade_window_cancel"
	self.interaction.need_boards.sound_done = "bar_barricade_window_finished"
	self.interaction.need_boards.axis = "z"
	self.interaction.uload_database = {}
	self.interaction.uload_database.text_id = "hud_int_hold_use_computer"
	self.interaction.uload_database.action_text_id = "hud_action_using_computer"
	self.interaction.uload_database.timer = 4
	self.interaction.uload_database.start_active = false
	self.interaction.uload_database.sound_start = "bar_keyboard"
	self.interaction.uload_database.sound_interupt = "bar_keyboard_cancel"
	self.interaction.uload_database.sound_done = "bar_keyboard_finished"
	self.interaction.uload_database.axis = "x"
	self.interaction.uload_database.contour = "contour_off"
	self.interaction.uload_database_jammed = {}
	self.interaction.uload_database_jammed.text_id = "hud_int_hold_resume_upload"
	self.interaction.uload_database_jammed.action_text_id = "hud_action_resuming_upload"
	self.interaction.uload_database_jammed.timer = 1
	self.interaction.uload_database_jammed.sound_start = "bar_keyboard"
	self.interaction.uload_database_jammed.sound_interupt = "bar_keyboard_cancel"
	self.interaction.uload_database_jammed.sound_done = "bar_keyboard_finished"
	self.interaction.uload_database_jammed.axis = "x"
	self.interaction.votingmachine2 = {}
	self.interaction.votingmachine2.text_id = "debug_interact_hack_ipad"
	self.interaction.votingmachine2.timer = 5
	self.interaction.votingmachine2.sound_start = "bar_keyboard"
	self.interaction.votingmachine2.sound_interupt = "bar_keyboard_cancel"
	self.interaction.votingmachine2.sound_done = "bar_keyboard_finished"
	self.interaction.votingmachine2_jammed = {}
	self.interaction.votingmachine2_jammed.text_id = "debug_interact_hack_ipad_jammed"
	self.interaction.votingmachine2_jammed.timer = 5
	self.interaction.votingmachine2_jammed.sound_start = "bar_keyboard"
	self.interaction.votingmachine2_jammed.sound_interupt = "bar_keyboard_cancel"
	self.interaction.votingmachine2_jammed.sound_done = "bar_keyboard_finished"
	self.interaction.sc_tape_loop = {}
	self.interaction.sc_tape_loop.icon = "interaction_help"
	self.interaction.sc_tape_loop.text_id = "hud_int_tape_loop"
	self.interaction.sc_tape_loop.start_active = true
	self.interaction.sc_tape_loop.interact_distance = 150
	self.interaction.sc_tape_loop.no_contour = true
	self.interaction.sc_tape_loop.timer = 4
	self.interaction.sc_tape_loop.action_text_id = "hud_action_tape_looping"
	self.interaction.sc_tape_loop.requires_upgrade = {
		category = "player",
		upgrade = "tape_loop_duration"
	}
	self.interaction.money_scanner = deep_clone(self.interaction.invisible_interaction_open)
	self.interaction.money_scanner.axis = "y"
	self.interaction.money_small = deep_clone(self.interaction.money_wrap)
	self.interaction.money_small.sound_start = "bar_bag_pour_money"
	self.interaction.money_small.sound_interupt = "bar_bag_pour_money_cancel"
	self.interaction.money_small.sound_done = "bar_bag_pour_money_finished"
	self.interaction.shape_charge_plantable = {}
	self.interaction.shape_charge_plantable.text_id = "debug_interact_c4"
	self.interaction.shape_charge_plantable.action_text_id = "hud_action_placing_c4"
	self.interaction.shape_charge_plantable.equipment_text_id = "debug_interact_equipment_c4"
	self.interaction.shape_charge_plantable.special_equipment = "c4"
	self.interaction.shape_charge_plantable.contour = "interactable_icon"
	self.interaction.shape_charge_plantable.equipment_consume = true
	self.interaction.shape_charge_plantable.timer = 4
	self.interaction.shape_charge_plantable.sound_start = "bar_c4_apply"
	self.interaction.shape_charge_plantable.sound_interupt = "bar_c4_apply_cancel"
	self.interaction.shape_charge_plantable.sound_done = "bar_c4_apply_finished"
	self.interaction.player_zipline = {}
	self.interaction.player_zipline.text_id = "hud_int_use_zipline"
	self.interaction.bag_zipline = {}
	self.interaction.bag_zipline.text_id = "hud_int_bag_zipline"
	self.interaction.huge_lance = {}
	self.interaction.huge_lance.text_id = "hud_int_equipment_huge_lance"
	self.interaction.huge_lance.action_text_id = "hud_action_placing_huge_lance"
	self.interaction.huge_lance.timer = 3
	self.interaction.huge_lance.sound_start = "bar_huge_lance_fix"
	self.interaction.huge_lance.sound_interupt = "bar_huge_lance_fix_cancel"
	self.interaction.huge_lance.sound_done = "bar_huge_lance_fix_finished"
	self.interaction.huge_lance_jammed = {}
	self.interaction.huge_lance_jammed.text_id = "hud_int_equipment_huge_lance_jammed"
	self.interaction.huge_lance_jammed.action_text_id = "hud_action_fixing_huge_lance"
	self.interaction.huge_lance_jammed.special_equipment = "lance_part"
	self.interaction.huge_lance_jammed.equipment_text_id = "hud_int_equipment_no_lance_part"
	self.interaction.huge_lance_jammed.blocked_hint = "no_huge_lance"
	self.interaction.huge_lance_jammed.equipment_consume = true
	self.interaction.huge_lance_jammed.timer = 10
	self.interaction.huge_lance_jammed.sound_start = "bar_huge_lance_fix"
	self.interaction.huge_lance_jammed.sound_interupt = "bar_huge_lance_fix_cancel"
	self.interaction.huge_lance_jammed.sound_done = "bar_huge_lance_fix_finished"
	self.interaction.gen_pku_lance_part = {}
	self.interaction.gen_pku_lance_part.text_id = "hud_int_take_lance_part"
	self.interaction.gen_pku_lance_part.special_equipment_block = "lance_part"
	self.interaction.gen_pku_lance_part.sound_done = "drill_fix_end"
	self.interaction.crane_joystick_left = {}
	self.interaction.crane_joystick_left.text_id = "hud_int_crane_left"
	self.interaction.crane_joystick_left.start_active = false
	self.interaction.crane_joystick_lift = {}
	self.interaction.crane_joystick_lift.text_id = "hud_int_crane_lift"
	self.interaction.crane_joystick_lift.start_active = false
	self.interaction.crane_joystick_right = {}
	self.interaction.crane_joystick_right.text_id = "hud_int_crane_right"
	self.interaction.crane_joystick_right.start_active = false
	self.interaction.crane_joystick_release = {}
	self.interaction.crane_joystick_release.text_id = "hud_int_crane_release"
	self.interaction.crane_joystick_release.start_active = false
	self.interaction.gen_int_thermite_rig = {}
	self.interaction.gen_int_thermite_rig.text_id = "hud_int_hold_assemble_thermite"
	self.interaction.gen_int_thermite_rig.action_text_id = "hud_action_assemble_thermite"
	self.interaction.gen_int_thermite_rig.special_equipment = "thermite"
	self.interaction.gen_int_thermite_rig.equipment_text_id = "debug_interact_equipment_thermite"
	self.interaction.gen_int_thermite_rig.equipment_consume = true
	self.interaction.gen_int_thermite_rig.contour = "interactable_icon"
	self.interaction.gen_int_thermite_rig.timer = 20
	self.interaction.gen_int_thermite_rig.sound_start = "bar_drill_apply"
	self.interaction.gen_int_thermite_rig.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.gen_int_thermite_rig.sound_done = "bar_drill_apply_finished"
	self.interaction.gen_int_thermite_apply = {}
	self.interaction.gen_int_thermite_apply.text_id = "hud_int_hold_ignite_thermite"
	self.interaction.gen_int_thermite_apply.action_text_id = "hud_action_ignite_thermite"
	self.interaction.gen_int_thermite_apply.contour = "interactable_icon"
	self.interaction.gen_int_thermite_apply.timer = 2
	self.interaction.gen_int_thermite_apply.sound_start = "bar_thermal_lance_fix"
	self.interaction.gen_int_thermite_apply.sound_interupt = "bar_thermal_lance_fix_cancel"
	self.interaction.gen_int_thermite_apply.sound_done = "bar_thermal_lance_fix_finished"
	self.interaction.apply_thermite_paste = {}
	self.interaction.apply_thermite_paste.text_id = "hud_int_hold_ignite_thermite_paste"
	self.interaction.apply_thermite_paste.action_text_id = "hud_action_ignite_thermite_paste"
	self.interaction.apply_thermite_paste.special_equipment = "thermite_paste"
	self.interaction.apply_thermite_paste.equipment_text_id = "hud_int_need_thermite_paste"
	self.interaction.apply_thermite_paste.equipment_consume = true
	self.interaction.apply_thermite_paste.start_active = false
	self.interaction.apply_thermite_paste.contour = "interactable_icon"
	self.interaction.apply_thermite_paste.timer = 2
	self.interaction.apply_thermite_paste.sound_start = "bar_thermal_lance_fix"
	self.interaction.apply_thermite_paste.sound_interupt = "bar_thermal_lance_fix_cancel"
	self.interaction.apply_thermite_paste.sound_done = "bar_thermal_lance_fix_finished"
	self.interaction.set_off_alarm = {}
	self.interaction.set_off_alarm.text_id = "hud_int_set_off_alarm"
	self.interaction.set_off_alarm.action_text_id = "hud_action_setting_off_alarm"
	self.interaction.set_off_alarm.timer = 0.5
	self.interaction.set_off_alarm.start_active = false
	self.interaction.hold_open_vault = {}
	self.interaction.hold_open_vault.text_id = "hud_int_hold_open_vault"
	self.interaction.hold_open_vault.action_text_id = "hud_action_opening_vault"
	self.interaction.hold_open_vault.timer = 4
	self.interaction.hold_open_vault.axis = "y"
	self.interaction.hold_open_vault.start_active = false
	self.interaction.samurai_armor = {}
	self.interaction.samurai_armor.text_id = "hud_int_hold_bag_sa_armor"
	self.interaction.samurai_armor.action_text_id = "hud_action_bagging_sa_armor"
	self.interaction.samurai_armor.blocked_hint = "carry_block"
	self.interaction.samurai_armor.start_active = false
	self.interaction.samurai_armor.timer = 3
	self.interaction.samurai_armor.sound_start = "bar_bag_armor"
	self.interaction.samurai_armor.sound_interupt = "bar_bag_armor_cancel"
	self.interaction.samurai_armor.sound_done = "bar_bag_armor_finished"
	self.interaction.fingerprint_scanner = {}
	self.interaction.fingerprint_scanner.text_id = "hud_int_use_scanner"
	self.interaction.fingerprint_scanner.start_active = false
	self.interaction.enter_code = {}
	self.interaction.enter_code.text_id = "hud_int_enter_code"
	self.interaction.enter_code.action_text_id = "hud_action_enter_code"
	self.interaction.enter_code.timer = 1
	self.interaction.enter_code.start_active = false
	self.interaction.enter_code.sound_start = "bar_keyboard"
	self.interaction.enter_code.sound_interupt = "bar_keyboard_cancel"
	self.interaction.enter_code.sound_done = "bar_keyboard_finished"
	self.interaction.take_keys = {}
	self.interaction.take_keys.text_id = "hud_int_take_keys"
	self.interaction.push_button = {}
	self.interaction.push_button.text_id = "hud_int_push_button"
	self.interaction.breach_door = {}
	self.interaction.breach_door.text_id = "debug_interact_crowbar"
	self.interaction.breach_door.action_text_id = "hud_action_breaching_door"
	self.interaction.breach_door.start_active = false
	self.interaction.breach_door.timer = 2
	self.interaction.breach_door.sound_start = "bar_pry_open_elevator_door"
	self.interaction.breach_door.sound_interupt = "bar_pry_open_elevator_door_cancel"
	self.interaction.breach_door.sound_done = "bar_pry_open_elevator_door_finished"
	self.interaction.bus_wall_phone = {}
	self.interaction.bus_wall_phone.text_id = "hud_int_use_phone_signal_bus"
	self.interaction.bus_wall_phone.start_active = false
	self.interaction.zipline_mount = {}
	self.interaction.zipline_mount.text_id = "hud_int_setup_zipline"
	self.interaction.zipline_mount.action_text_id = "hud_action_setting_zipline"
	self.interaction.zipline_mount.start_active = false
	self.interaction.zipline_mount.timer = 2
	self.interaction.zipline_mount.sound_start = "bar_drill_apply"
	self.interaction.zipline_mount.sound_interupt = "bar_drill_apply_cancel"
	self.interaction.zipline_mount.sound_done = "bar_drill_apply_finished"
	self.interaction.rewire_timelock = deep_clone(self.interaction.security_station)
	self.interaction.rewire_timelock.text_id = "hud_int_rewire_timelock"
	self.interaction.rewire_timelock.action_text_id = "hud_action_rewiring_timelock"
	self.interaction.rewire_timelock.axis = "x"
	self.interaction.pick_lock_x_axis = deep_clone(self.interaction.pick_lock_hard_no_skill)
	self.interaction.pick_lock_x_axis.axis = "x"
	self.interaction.money_wrap_single_bundle_active = deep_clone(self.interaction.money_wrap_single_bundle)
	self.interaction.money_wrap_single_bundle_active.start_active = true
	self.interaction.pku_barcode_downtown = {}
	self.interaction.pku_barcode_downtown.text_id = "hud_int_hold_barcode"
	self.interaction.pku_barcode_downtown.action_text_id = "hud_action_barcode"
	self.interaction.pku_barcode_downtown.special_equipment_block = "barcode_downtown"
	self.interaction.pku_barcode_downtown.timer = 2
	self.interaction.pku_barcode_brickell = deep_clone(self.interaction.pku_barcode_downtown)
	self.interaction.pku_barcode_brickell.special_equipment_block = "barcode_brickell"
	self.interaction.pku_barcode_edgewater = deep_clone(self.interaction.pku_barcode_downtown)
	self.interaction.pku_barcode_edgewater.special_equipment_block = "barcode_edgewater"
	self.interaction.pku_barcode_isles_beach = deep_clone(self.interaction.pku_barcode_downtown)
	self.interaction.pku_barcode_isles_beach.special_equipment_block = "barcode_isles_beach"
	self.interaction.pku_barcode_opa_locka = deep_clone(self.interaction.pku_barcode_downtown)
	self.interaction.pku_barcode_opa_locka.special_equipment_block = "barcode_opa_locka"
	self.interaction.read_barcode_downtown = {}
	self.interaction.read_barcode_downtown.text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_downtown.action_text_id = "hud_action_read_barcode"
	self.interaction.read_barcode_downtown.special_equipment = "barcode_downtown"
	self.interaction.read_barcode_downtown.dont_need_equipment = true
	self.interaction.read_barcode_downtown.possible_special_equipment = {
		"barcode_downtown",
		"barcode_brickell",
		"barcode_edgewater",
		"barcode_isles_beach",
		"barcode_opa_locka"
	}
	self.interaction.read_barcode_downtown.equipment_text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_downtown.equipment_consume = true
	self.interaction.read_barcode_downtown.start_active = false
	self.interaction.read_barcode_downtown.timer = 2
	self.interaction.read_barcode_brickell = {}
	self.interaction.read_barcode_brickell.text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_brickell.action_text_id = "hud_action_read_barcode"
	self.interaction.read_barcode_brickell.special_equipment = "barcode_brickell"
	self.interaction.read_barcode_brickell.dont_need_equipment = true
	self.interaction.read_barcode_brickell.possible_special_equipment = {
		"barcode_downtown",
		"barcode_brickell",
		"barcode_edgewater",
		"barcode_isles_beach",
		"barcode_opa_locka"
	}
	self.interaction.read_barcode_brickell.equipment_text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_brickell.equipment_consume = true
	self.interaction.read_barcode_brickell.start_active = false
	self.interaction.read_barcode_brickell.timer = 2
	self.interaction.read_barcode_edgewater = {}
	self.interaction.read_barcode_edgewater.text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_edgewater.action_text_id = "hud_action_read_barcode"
	self.interaction.read_barcode_edgewater.special_equipment = "barcode_edgewater"
	self.interaction.read_barcode_edgewater.dont_need_equipment = true
	self.interaction.read_barcode_edgewater.possible_special_equipment = {
		"barcode_downtown",
		"barcode_brickell",
		"barcode_edgewater",
		"barcode_isles_beach",
		"barcode_opa_locka"
	}
	self.interaction.read_barcode_edgewater.equipment_text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_edgewater.equipment_consume = true
	self.interaction.read_barcode_edgewater.start_active = false
	self.interaction.read_barcode_edgewater.timer = 2
	self.interaction.read_barcode_isles_beach = {}
	self.interaction.read_barcode_isles_beach.text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_isles_beach.action_text_id = "hud_action_read_barcode"
	self.interaction.read_barcode_isles_beach.special_equipment = "barcode_isles_beach"
	self.interaction.read_barcode_isles_beach.dont_need_equipment = true
	self.interaction.read_barcode_isles_beach.possible_special_equipment = {
		"barcode_downtown",
		"barcode_brickell",
		"barcode_edgewater",
		"barcode_isles_beach",
		"barcode_opa_locka"
	}
	self.interaction.read_barcode_isles_beach.equipment_text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_isles_beach.equipment_consume = true
	self.interaction.read_barcode_isles_beach.start_active = false
	self.interaction.read_barcode_isles_beach.timer = 2
	self.interaction.read_barcode_opa_locka = {}
	self.interaction.read_barcode_opa_locka.text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_opa_locka.action_text_id = "hud_action_read_barcode"
	self.interaction.read_barcode_opa_locka.special_equipment = "barcode_opa_locka"
	self.interaction.read_barcode_opa_locka.dont_need_equipment = true
	self.interaction.read_barcode_opa_locka.possible_special_equipment = {
		"barcode_downtown",
		"barcode_brickell",
		"barcode_edgewater",
		"barcode_isles_beach",
		"barcode_opa_locka"
	}
	self.interaction.read_barcode_opa_locka.equipment_text_id = "hud_int_hold_read_barcode"
	self.interaction.read_barcode_opa_locka.equipment_consume = true
	self.interaction.read_barcode_opa_locka.start_active = false
	self.interaction.read_barcode_opa_locka.timer = 2
	self.gui = self.gui or {}
	self.gui.BOOT_SCREEN_LAYER = 1
	self.gui.TITLE_SCREEN_LAYER = 1
	self.gui.MENU_LAYER = 200
	self.gui.MENU_COMPONENT_LAYER = 300
	self.gui.ATTRACT_SCREEN_LAYER = 400
	self.gui.LOADING_SCREEN_LAYER = 1000
	self.gui.CRIMENET_CHAT_LAYER = 1000
	self.gui.DIALOG_LAYER = 1100
	self.gui.MOUSE_LAYER = 1200
	self.gui.SAVEFILE_LAYER = 1400
	self.overlay_effects = {}
	self.overlay_effects.spectator = {
		blend_mode = "normal",
		sustain = nil,
		fade_in = 3,
		fade_out = 2,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	self.overlay_effects.level_fade_in = {
		blend_mode = "normal",
		sustain = 1,
		fade_in = 0,
		fade_out = 3,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:game(),
		play_paused = true
	}
	self.overlay_effects.fade_in = {
		blend_mode = "normal",
		sustain = 0,
		fade_in = 0,
		fade_out = 3,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	self.overlay_effects.fade_out = {
		blend_mode = "normal",
		sustain = 30,
		fade_in = 3,
		fade_out = 0,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	self.overlay_effects.fade_out_permanent = {
		blend_mode = "normal",
		fade_in = 1,
		fade_out = 0,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	self.overlay_effects.fade_out_in = {
		blend_mode = "normal",
		sustain = 1,
		fade_in = 1,
		fade_out = 1,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	self.overlay_effects.element_fade_in = {
		blend_mode = "normal",
		sustain = 0,
		fade_in = 0,
		fade_out = 3,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	self.overlay_effects.element_fade_out = {
		blend_mode = "normal",
		sustain = 0,
		fade_in = 3,
		fade_out = 0,
		color = Color(1, 0, 0, 0),
		timer = TimerManager:main(),
		play_paused = true
	}
	local d_color = Color(0.75, 1, 1, 1)
	local d_sustain = 0.1
	local d_fade_out = 0.9
	self.overlay_effects.damage = {
		blend_mode = "add",
		sustain = d_sustain,
		fade_in = 0,
		fade_out = d_fade_out,
		color = d_color
	}
	self.overlay_effects.damage_left = {
		blend_mode = "add",
		sustain = d_sustain,
		fade_in = 0,
		fade_out = d_fade_out,
		color = d_color,
		gradient_points = {
			0,
			d_color,
			0.1,
			d_color,
			0.15,
			Color():with_alpha(0),
			1,
			Color():with_alpha(0)
		},
		orientation = "horizontal"
	}
	self.overlay_effects.damage_right = {
		blend_mode = "add",
		sustain = d_sustain,
		fade_in = 0,
		fade_out = d_fade_out,
		color = d_color,
		gradient_points = {
			1,
			d_color,
			0.9,
			d_color,
			0.85,
			Color():with_alpha(0),
			0,
			Color():with_alpha(0)
		},
		orientation = "horizontal"
	}
	self.overlay_effects.damage_up = {
		blend_mode = "add",
		sustain = d_sustain,
		fade_in = 0,
		fade_out = d_fade_out,
		color = d_color,
		gradient_points = {
			0,
			d_color,
			0.1,
			d_color,
			0.15,
			Color():with_alpha(0),
			1,
			Color():with_alpha(0)
		},
		orientation = "vertical"
	}
	self.overlay_effects.damage_down = {
		blend_mode = "add",
		sustain = d_sustain,
		fade_in = 0,
		fade_out = d_fade_out,
		color = d_color,
		gradient_points = {
			1,
			d_color,
			0.9,
			d_color,
			0.85,
			Color():with_alpha(0),
			0,
			Color():with_alpha(0)
		},
		orientation = "vertical"
	}
	self.overlay_effects.maingun_zoomed = {
		blend_mode = "add",
		sustain = 0,
		fade_in = 0,
		fade_out = 0.4,
		color = Color(0.1, 1, 1, 1)
	}
	self.materials = {}
	self.materials[Idstring("concrete"):key()] = "concrete"
	self.materials[Idstring("ceramic"):key()] = "ceramic"
	self.materials[Idstring("marble"):key()] = "marble"
	self.materials[Idstring("flesh"):key()] = "flesh"
	self.materials[Idstring("parket"):key()] = "parket"
	self.materials[Idstring("sheet_metal"):key()] = "sheet_metal"
	self.materials[Idstring("iron"):key()] = "iron"
	self.materials[Idstring("wood"):key()] = "wood"
	self.materials[Idstring("gravel"):key()] = "gravel"
	self.materials[Idstring("cloth"):key()] = "cloth"
	self.materials[Idstring("cloth_no_decal"):key()] = "cloth"
	self.materials[Idstring("cloth_stuffed"):key()] = "cloth_stuffed"
	self.materials[Idstring("dirt"):key()] = "dirt"
	self.materials[Idstring("grass"):key()] = "grass"
	self.materials[Idstring("carpet"):key()] = "carpet"
	self.materials[Idstring("metal"):key()] = "metal"
	self.materials[Idstring("glass_breakable"):key()] = "glass_breakable"
	self.materials[Idstring("glass_unbreakable"):key()] = "glass_unbreakable"
	self.materials[Idstring("glass_no_decal"):key()] = "glass_unbreakable"
	self.materials[Idstring("rubber"):key()] = "rubber"
	self.materials[Idstring("plastic"):key()] = "plastic"
	self.materials[Idstring("asphalt"):key()] = "asphalt"
	self.materials[Idstring("foliage"):key()] = "foliage"
	self.materials[Idstring("stone"):key()] = "stone"
	self.materials[Idstring("sand"):key()] = "sand"
	self.materials[Idstring("thin_layer"):key()] = "thin_layer"
	self.materials[Idstring("no_decal"):key()] = "silent_material"
	self.materials[Idstring("plaster"):key()] = "plaster"
	self.materials[Idstring("no_material"):key()] = "no_material"
	self.materials[Idstring("paper"):key()] = "paper"
	self.materials[Idstring("metal_hollow"):key()] = "metal_hollow"
	self.materials[Idstring("metal_chassis"):key()] = "metal_chassis"
	self.materials[Idstring("metal_catwalk"):key()] = "metal_catwalk"
	self.materials[Idstring("hardwood"):key()] = "hardwood"
	self.materials[Idstring("fence"):key()] = "fence"
	self.materials[Idstring("steel"):key()] = "steel"
	self.materials[Idstring("steel_no_decal"):key()] = "steel"
	self.materials[Idstring("tile"):key()] = "tile"
	self.materials[Idstring("water_deep"):key()] = "water_deep"
	self.materials[Idstring("water_puddle"):key()] = "water_puddle"
	self.materials[Idstring("water_shallow"):key()] = "water_shallow"
	self.materials[Idstring("shield"):key()] = "shield"
	self.materials[Idstring("heavy_swat_steel_no_decal"):key()] = "shield"
	self.screen = {}
	self.screen.fadein_delay = 1
	self.experience_manager = {}
	self.experience_manager.values = {}
	self.experience_manager.values.size02 = 0
	self.experience_manager.values.size03 = 10
	self.experience_manager.values.size04 = 15
	self.experience_manager.values.size06 = 25
	self.experience_manager.values.size08 = 40
	self.experience_manager.values.size10 = 80
	self.experience_manager.values.size12 = 100
	self.experience_manager.values.size14 = 150
	self.experience_manager.values.size16 = 250
	self.experience_manager.values.size18 = 500
	self.experience_manager.values.size20 = 1000
	self.experience_manager.loot_drop_value = {}
	self.experience_manager.loot_drop_value.xp10 = 2000
	self.experience_manager.loot_drop_value.xp20 = 4000
	self.experience_manager.loot_drop_value.xp30 = 6000
	self.experience_manager.loot_drop_value.xp40 = 10000
	self.experience_manager.loot_drop_value.xp50 = 12000
	self.experience_manager.loot_drop_value.xp60 = 15000
	self.experience_manager.loot_drop_value.xp70 = 20000
	self.experience_manager.loot_drop_value.xp80 = 24000
	self.experience_manager.loot_drop_value.xp90 = 28000
	self.experience_manager.loot_drop_value.xp100 = 32000
	self.experience_manager.stage_completion = {
		200,
		250,
		300,
		350,
		425,
		475,
		550
	}
	self.experience_manager.job_completion = {
		750,
		1000,
		1500,
		2000,
		2500,
		3000,
		4000
	}
	self.experience_manager.stage_failed_multiplier = 0.1
	self.experience_manager.in_custody_multiplier = 0.7
	self.experience_manager.difficulty_multiplier = {
		2,
		5,
		10,
		13
	}
	self.experience_manager.alive_humans_multiplier = {
		1,
		1.1,
		1.2,
		1.3
	}
	self.experience_manager.limited_bonus_multiplier = 1
	self.experience_manager.level_limit = {}
	self.experience_manager.level_limit.low_cap_level = -1
	self.experience_manager.level_limit.low_cap_multiplier = 0.75
	self.experience_manager.level_limit.pc_difference_multipliers = {
		0.9,
		0.8,
		0.7,
		0.6,
		0.5,
		0.4,
		0.3,
		0.2,
		0.1,
		0.01
	}
	self.experience_manager.civilians_killed = 0
	self.experience_manager.day_multiplier = {
		1,
		2,
		3,
		4,
		5,
		6,
		7
	}
	self.experience_manager.pro_day_multiplier = {
		1,
		2.5,
		5,
		5.5,
		7,
		8.5,
		10
	}
	self.experience_manager.total_level_objectives = 500
	self.experience_manager.total_criminals_finished = 50
	self.experience_manager.total_objectives_finished = 500
	local multiplier = 1
	self.experience_manager.levels = {}
	self.experience_manager.levels[1] = {
		points = 900 * multiplier
	}
	self.experience_manager.levels[2] = {
		points = 1250 * multiplier
	}
	self.experience_manager.levels[3] = {
		points = 1550 * multiplier
	}
	self.experience_manager.levels[4] = {
		points = 1850 * multiplier
	}
	self.experience_manager.levels[5] = {
		points = 2200 * multiplier
	}
	self.experience_manager.levels[6] = {
		points = 2600 * multiplier
	}
	self.experience_manager.levels[7] = {
		points = 3000 * multiplier
	}
	self.experience_manager.levels[8] = {
		points = 3500 * multiplier
	}
	self.experience_manager.levels[9] = {
		points = 4000 * multiplier
	}
	local exp_step_start = 10
	local exp_step_end = 100
	local exp_step = 1 / (exp_step_end - exp_step_start)
	local exp_step_last_points = 4600
	local exp_step_curve = 3
	for i = exp_step_start, exp_step_end do
		self.experience_manager.levels[i] = {
			points = math.round((1000000 - exp_step_last_points) * math.pow(exp_step * (i - exp_step_start), exp_step_curve) + exp_step_last_points) * multiplier
		}
	end
	local exp_step_start = 5
	local exp_step_end = 193
	local exp_step = 1 / (exp_step_end - exp_step_start)
	for i = 146, exp_step_end do
		self.experience_manager.levels[i] = {
			points = math.round(22000 * (exp_step * (i - exp_step_start)) - 6000) * multiplier
		}
	end
	self.achievement = {}
	self.achievement.im_a_healer_tank_damage_dealer = 10
	self.achievement.iron_man = "level_7"
	self.achievement.going_places = 1000000
	self.achievement.spend_money_to_make_money = 1000000
	self.achievement.you_gotta_start_somewhere = 5
	self.achievement.guilty_of_crime = 10
	self.achievement.gone_in_30_seconds = 25
	self.achievement.armed_and_dangerous = 50
	self.achievement.big_shot = 75
	self.achievement.most_wanted = 100
	self.achievement.fully_loaded = 9
	self.achievement.weapon_collector = 18
	self.achievement.arms_dealer = 72
	self.achievement.how_do_you_like_me_now = "level_1"
	self.achievement.like_an_angry_bear = "bear"
	self.achievement.merry_christmas = "santa_happy"
	self.achievement.witch_doctor = {
		mask = "witch",
		stat = "halloween_4_stats"
	}
	self.achievement.its_alive_its_alive = {
		mask = "frank",
		stat = "halloween_5_stats"
	}
	self.achievement.pump_action = {
		mask = "pumpkin_king",
		stat = "halloween_6_stats"
	}
	self.achievement.cant_hear_you_scream = {
		mask = "venomorph",
		stat = "halloween_7_stats"
	}
	self.achievement.unique_selling_point = "usp"
	self.achievement.relation_with_bulldozer = {
		mask = "clinton",
		stat = "armored_8_stat"
	}
	self.achievement.no_we_cant = {
		mask = "obama",
		stat = "armored_10_stat"
	}
	self.achievement.heat_around_the_corner = "heat"
	self.achievement.fire_in_the_hole = {
		grenade = "frag",
		stat = "gage_9_stats"
	}
	self.achievement.infamous = {
		"ignominy_1",
		"ignominy_2",
		"ignominy_3",
		"ignominy_4",
		"ignominy_5"
	}
	self.achievement.final_rule = {
		stat = "gage2_3_stats",
		melee_type = "fists",
		heist = "nightclub"
	}
	self.achievement.easy_as_breathing = {
		award = "gage2_4",
		count = 10,
		weapon_type = "lmg"
	}
	self.achievement.first_blood = {
		award = "gage2_5",
		weapon_type = "lmg",
		count = 220
	}
	self.achievement.in_town_you_are_law = {award = "gage2_6", weapon_type = "shotgun"}
	self.achievement.dont_push_it = {award = "gage2_7", weapon = "deagle"}
	self.achievement.finally = {award = "gage2_8"}
	self.achievement.demise_knuckles = "brass_knuckles"
	self.achievement.vote_for_change = "g22c"
	self.achievement.steam_500k = "akm_gold"
	self.achievement.gage_assignments = {
		green_mantis = "gmod_1_stats",
		yellow_bull = "gmod_2_stats",
		red_spider = "gmod_3_stats",
		blue_eagle = "gmod_4_stats",
		purple_snake = "gmod_5_stats"
	}
	self.achievement.gonna_find_them_all = 1
	self.achievement.weapon_blueprints = {
		gmod_7 = {
			"wpn_fps_upg_fg_jp",
			"wpn_fps_upg_m4_m_quad",
			"wpn_fps_upg_ass_ns_jprifles"
		},
		gmod_8 = {
			"wpn_fps_upg_o_rmr",
			"wpn_fps_upg_pis_ns_flash"
		},
		gmod_9 = {
			"wpn_fps_upg_fg_smr",
			"wpn_fps_upg_ass_ns_surefire",
			"wpn_fps_upg_o_eotech_xps",
			"wpn_fps_upg_m4_s_crane",
			"wpn_fps_upg_fl_ass_peq15"
		},
		gmod_10 = {
			"wpn_fps_upg_fg_midwest",
			"wpn_fps_upg_ak_b_draco",
			"wpn_fps_upg_ak_m_quad",
			"wpn_fps_upg_ass_ns_linear"
		}
	}
	self.achievement.enemy_kill_achievements = {
		try_out_your_usp = {
			weapon = "usp",
			stat = "halloween_8_stats"
		},
		license_to_kill = {
			weapon = "ppk",
			stat = "armored_5_stat"
		},
		im_not_a_crook = {
			mask = "nixon",
			weapon = "s552",
			enemy = "sniper",
			stat = "armored_7_stat"
		},
		fool_me_once = {
			mask = "bush",
			weapon = "m45",
			enemy = "shield",
			stat = "armored_9_stat"
		},
		wanted = {
			mask = "goat",
			weapon = "ak5",
			stat = "gage_1_stats"
		},
		three_thousand_miles = {
			mask = "panda",
			weapon = "p90",
			stat = "gage_2_stats"
		},
		commando = {
			mask = "pitbull",
			weapon = "aug",
			stat = "gage_3_stats"
		},
		public_enemies = {
			mask = "eagle",
			weapon = "colt_1911",
			stat = "gage_4_stats"
		},
		inception = {
			weapon = "scar",
			stat = "gage_5_stats"
		},
		hard_corps = {
			weapon = "mp7",
			stat = "gage_6_stats"
		},
		above_the_law = {
			weapon = "p226",
			stat = "gage_7_stats"
		},
		surprise_motherfucker = {
			weapon = "m95",
			stat = "gage3_12_stats",
			enemy = "tank"
		},
		man_with_golden_gun = {
			stat = "gage3_2_stats",
			weapon = "akm_gold",
			enemy = "tank",
			enemy_weapon = "m249"
		},
		lord_of_flies = {
			stat = "gage3_3_stats",
			in_head = true,
			weapons = {
				"m95",
				"msr",
				"r93"
			}
		},
		arachnes_curse = {
			stat = "gage3_4_stats",
			in_head = true,
			weapons = {
				"m95",
				"msr",
				"r93"
			}
		},
		pest_control = {
			stat = "gage3_5_stats",
			in_head = true,
			weapons = {
				"m95",
				"msr",
				"r93"
			}
		},
		seer_of_death = {
			stat = "gage3_6_stats",
			in_head = true,
			weapons = {
				"m95",
				"msr",
				"r93"
			}
		},
		far_far_away = {
			stat = "gage3_7_stats",
			distance = 4000,
			weapon = "m95"
		},
		last_action_villian = {
			award = "gage3_8",
			in_head = true,
			on_zipline = true,
			weapon = "r93"
		},
		dodge_this = {
			stat = "gage3_11_stats",
			in_head = true,
			enemy = "spooc",
			weapon = "m95"
		},
		didnt_see_this_coming = {
			stat = "gage3_13_stats",
			on_zipline = true,
			weapons = {
				"m95",
				"msr",
				"r93"
			}
		},
		grand_master_sniper = {
			stat = "gage3_14_stats",
			enemy = "sniper",
			weapon = "msr"
		},
		public_enemy_no_one = {
			stat = "gage3_17_stats",
			weapon = "msr"
		}
	}
	self.achievement.enemy_melee_kill_achievements = {
		cloak_n_dagger = {
			award = "gage2_2",
			enemy = "spooc",
			melee_type = "knife"
		},
		are_you_kidding_me = {
			award = "gage2_10",
			enemy = "tank",
			melee_type = "knife"
		},
		no_time_to_bleed = {
			stat = "gage2_9_stats",
			enemies = {
				"fbi_swat",
				"fbi_heavy_swat"
			},
			melee_type = "knife",
			difficulty = {
				"overkill_145",
				"overkill_290"
			},
			health = 25
		}
	}
	self.achievement.complete_heist_achievements = {
		in_soviet_russia = {
			stat = "halloween_10_stats",
			mask = "bear",
			difficulty = {
				"overkill_145",
				"overkill_290"
			},
			contract = "vlad"
		},
		i_take_scores = {
			stat = "armored_4_stat",
			mask = "heat",
			difficulty = {
				"overkill_145",
				"overkill_290"
			},
			jobs = {
				"arm_cro",
				"arm_und",
				"arm_hcm",
				"arm_par",
				"arm_fac"
			}
		},
		eco_round = {
			award = "charliesierra_7",
			no_shots = "primaries",
			difficulty = {
				"overkill_145",
				"overkill_290"
			},
			job = "roberts"
		},
		death_ukranian = {
			award = "death_1",
			difficulty = {
				"overkill_290"
			},
			job = "ukrainian_job_prof"
		},
		death_mallcrasher = {
			award = "death_2",
			difficulty = {
				"overkill_290"
			},
			job = "mallcrasher"
		},
		death_four_stores = {
			award = "death_3",
			difficulty = {
				"overkill_290"
			},
			job = "four_stores"
		},
		death_nightclub = {
			award = "death_4",
			difficulty = {
				"overkill_290"
			},
			job = "nightclub"
		},
		death_watchdogs = {
			award = "death_34",
			difficulty = {
				"overkill_290"
			},
			job = "watchdogs"
		},
		death_watchdogs_prof = {
			award = "death_6",
			difficulty = {
				"overkill_290"
			},
			job = "watchdogs_prof"
		},
		death_rats = {
			award = "death_33",
			difficulty = {
				"overkill_290"
			},
			job = "alex"
		},
		death_rats_prof = {
			award = "death_7",
			difficulty = {
				"overkill_290"
			},
			job = "alex_prof"
		},
		death_firestarter = {
			award = "death_32",
			difficulty = {
				"overkill_290"
			},
			job = "firestarter"
		},
		death_firestarter_prof = {
			award = "death_8",
			difficulty = {
				"overkill_290"
			},
			job = "firestarter_prof"
		},
		death_framing_frame = {
			award = "death_35",
			difficulty = {
				"overkill_290"
			},
			job = "framing_frame"
		},
		death_framing_frame_prof = {
			award = "death_10",
			difficulty = {
				"overkill_290"
			},
			job = "framing_frame_prof"
		},
		death_big_oil = {
			award = "death_11",
			difficulty = {
				"overkill_290"
			},
			job = "welcome_to_the_jungle_prof"
		},
		death_jewelry_store = {
			award = "death_13",
			difficulty = {
				"overkill_290"
			},
			job = "jewelry_store"
		},
		death_diamond_store = {
			award = "death_14",
			difficulty = {
				"overkill_290"
			},
			job = "family"
		},
		death_go_bank = {
			award = "death_15",
			difficulty = {
				"overkill_290"
			},
			job = "roberts"
		},
		death_bank_heist = {
			award = "death_16",
			difficulty = {
				"overkill_290"
			},
			job = "branchbank_prof"
		},
		death_bank_heist_gold = {
			award = "death_17",
			difficulty = {
				"overkill_290"
			},
			job = "branchbank_gold_prof"
		},
		death_bank_heist_cash = {
			award = "death_18",
			difficulty = {
				"overkill_290"
			},
			job = "branchbank_cash"
		},
		death_bank_heist_deposit = {
			award = "death_19",
			difficulty = {
				"overkill_290"
			},
			job = "branchbank_deposit"
		},
		death_transport_crossroads = {
			award = "death_20",
			difficulty = {
				"overkill_290"
			},
			job = "arm_cro"
		},
		death_transport_downtown = {
			award = "death_21",
			difficulty = {
				"overkill_290"
			},
			job = "arm_hcm"
		},
		death_transport_harbor = {
			award = "death_22",
			difficulty = {
				"overkill_290"
			},
			job = "arm_fac"
		},
		death_transport_park = {
			award = "death_23",
			difficulty = {
				"overkill_290"
			},
			job = "arm_par"
		},
		death_transport_underpass = {
			award = "death_24",
			difficulty = {
				"overkill_290"
			},
			job = "arm_und"
		},
		death_transport_train = {
			award = "death_25",
			difficulty = {
				"overkill_290"
			},
			job = "arm_for"
		},
		death_election_day = {
			award = "bob_9",
			difficulty = {
				"overkill_290"
			},
			job = "election_day"
		},
		death_election_day_prof = {
			award = "bob_2",
			difficulty = {
				"overkill_290"
			},
			job = "election_day_prof"
		},
		death_kosugi = {
			award = "kosugi_6",
			difficulty = {
				"overkill_290"
			},
			job = "kosugi"
		},
		death_bigbank = {
			award = "bigbank_9",
			difficulty = {
				"overkill_290"
			},
			job = "big"
		}
	}
	self.achievement.job_list = {}
	self.achievement.job_list.vlad = {
		"ukrainian_job_prof",
		"mallcrasher",
		"four_stores",
		"nightclub"
	}
	self.achievement.job_list.hector = {
		"watchdogs",
		"watchdogs_prof",
		"alex",
		"alex_prof",
		"firestarter",
		"firestarter_prof"
	}
	self.achievement.job_list.elephant = {
		"framing_frame",
		"framing_frame_prof",
		"welcome_to_the_jungle_prof",
		"election_day",
		"election_day_prof"
	}
	self.achievement.job_list.bain = {
		"jewelry_store",
		"family",
		"roberts",
		"branchbank_prof",
		"branchbank_gold_prof",
		"branchbank_cash",
		"branchbank_deposit",
		"arm_cro",
		"arm_hcm",
		"arm_fac",
		"arm_par",
		"arm_und",
		"kosugi"
	}
	self.achievement.job_list.dentist = {"big"}
	self.achievement.complete_heist_stats_achievements = {
		death_vlad = {
			award = "death_5",
			difficulty = "overkill_290",
			contact = "vlad"
		},
		death_hector = {
			award = "death_9",
			difficulty = "overkill_290",
			contact = "hector"
		},
		death_elephant = {
			award = "death_12",
			difficulty = "overkill_290",
			contact = "elephant"
		},
		death_bain = {
			award = "death_26",
			difficulty = "overkill_290",
			contact = "bain"
		},
		skull_hard = {
			award = "death_27",
			difficulty = "hard",
			contact = "all"
		},
		skull_very_hard = {
			award = "death_28",
			difficulty = "overkill",
			contact = "all"
		},
		skull_overkill = {
			award = "death_29",
			difficulty = "overkill_145",
			contact = "all"
		},
		skull_deathwish = {
			award = "death_30",
			difficulty = "overkill_290",
			contact = "all"
		}
	}
	self.achievement.four_mask_achievements = {
		reindeer_games = {
			award = "charliesierra_9",
			masks = {
				"santa_happy",
				"santa_mad",
				"santa_drunk",
				"santa_surprise"
			}
		},
		ghost_riders = {
			award = "bob_10",
			masks = {
				"skullhard",
				"skullveryhard",
				"skulloverkill",
				"skulloverkillplus"
			}
		},
		funding_father = {
			award = "bigbank_10",
			masks = {
				"franklin",
				"lincoln",
				"grant",
				"washington"
			}
		}
	}
	self.achievement.sniper_kill_achievements = {
		did_i_do_that = {award = "gage3_9", multi_kill = 3},
		max_peneration = {
			stat = "gage3_10_stats",
			weapon = "r93",
			obstacle = "shield",
			enemy = "shield"
		},
		you_cant_hide = {
			stat = "gage3_15_stats",
			weapon = "r93",
			obstacle = "wall"
		},
		two_for_one = {
			stat = "gage3_16_stats",
			weapon = "msr",
			multi_kill = 2
		}
	}
	self.achievement.weapon_part_tracker = {}
	self.achievement.weapon_part_tracker.wpn_fps_snp_m95_barrel_long = {
		text_id = "bm_wp_m95_b_barrel_long_achievment",
		stat = "gage3_7_stats",
		max_progress = 25
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_r93_b_suppressed = {
		text_id = "bm_wp_r93_b_suppressed_achievment",
		award = "gage3_8"
	}
	self.achievement.weapon_part_tracker.wpn_fps_upg_o_45iron = {
		text_id = "bm_wp_upg_o_45iron_achievment",
		award = "gage3_9"
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_r93_b_short = {
		text_id = "bm_wp_r93_b_short_achievment",
		stat = "gage3_10_stats",
		max_progress = 10
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_m95_barrel_suppressed = {
		text_id = "bm_wp_m95_b_barrel_suppressed_achievment",
		stat = "gage3_11_stats",
		max_progress = 10
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_m95_barrel_short = {
		text_id = "bm_wp_m95_b_barrel_short_achievment",
		award = "gage3_12_stats",
		max_progress = 10
	}
	self.achievement.weapon_part_tracker.wpn_fps_upg_o_leupold = {
		text_id = "bm_wp_upg_o_leupold_achievment",
		stat = "gage3_13_stats",
		max_progress = 10
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_msr_body_msr = {
		text_id = "bm_wp_msr_body_msr_achievment",
		stat = "gage3_14_stats",
		max_progress = 25
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_r93_body_wood = {
		text_id = "bm_wp_r93_body_wood_achievment",
		stat = "gage3_15_stats",
		max_progress = 25
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_msr_ns_suppressor = {
		text_id = "bm_wp_snp_msr_ns_suppressor_achievment",
		stat = "gage3_16_stats",
		max_progress = 25
	}
	self.achievement.weapon_part_tracker.wpn_fps_snp_msr_b_long = {
		text_id = "bm_wp_snp_msr_b_long_achievment",
		stat = "gage3_17_stats",
		max_progress = 250
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_fg_01 = {
		text_id = "bm_wp_fal_fg_01_achievment",
		award = "bigbank_7"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_fg_03 = {
		text_id = "bm_wp_fal_fg_03_achievment",
		award = "bigbank_8"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_fg_04 = {
		text_id = "bm_wp_fal_fg_04_achievment",
		award = "bigbank_3"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_fg_wood = {
		text_id = "bm_wp_fal_fg_wood_achievment",
		award = "bigbank_4"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_s_01 = {
		text_id = "bm_wp_fal_s_01_achievment",
		award = "bigbank_5"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_s_03 = {
		text_id = "bm_wp_fal_s_03_achievment",
		award = "bigbank_10"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_s_wood = {
		text_id = "bm_wp_fal_s_wood_achievment",
		award = "bigbank_6"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_g_01 = {
		text_id = "bm_wp_fal_g_01_achievment",
		award = "bigbank_1"
	}
	self.achievement.weapon_part_tracker.wpn_fps_ass_fal_m_01 = {
		text_id = "bm_wp_fal_m_01_achievment",
		award = "bigbank_2"
	}
	self.pickups = {}
	self.pickups.ammo = {
		unit = Idstring("units/pickups/ammo/ammo_pickup")
	}
	self.pickups.bank_manager_key = {
		unit = Idstring("units/pickups/pickup_bank_manager_key/pickup_bank_manager_key")
	}
	self.pickups.chavez_key = {
		unit = Idstring("units/pickups/pickup_chavez_key/pickup_chavez_key")
	}
	self.pickups.drill = {
		unit = Idstring("units/pickups/pickup_drill/pickup_drill")
	}
	self.pickups.keycard = {
		unit = Idstring("units/payday2/pickups/gen_pku_keycard/gen_pku_keycard")
	}
	self.danger_zones = {
		0.6,
		0.5,
		0.35,
		0.1
	}
	self.contour = {}
	self.contour.character = {}
	self.contour.character.standard_color = Vector3(0.1, 1, 0.5)
	self.contour.character.friendly_color = Vector3(0.2, 0.8, 1)
	self.contour.character.downed_color = Vector3(1, 0.5, 0)
	self.contour.character.dead_color = Vector3(1, 0.1, 0.1)
	self.contour.character.dangerous_color = Vector3(0.6, 0.2, 0.2)
	self.contour.character.more_dangerous_color = Vector3(1, 0.1, 0.1)
	self.contour.character.standard_opacity = 0
	self.contour.character_interactable = {}
	self.contour.character_interactable.standard_color = Vector3(1, 0.5, 0)
	self.contour.character_interactable.selected_color = Vector3(1, 1, 1)
	self.contour.interactable = {}
	self.contour.interactable.standard_color = Vector3(1, 0.5, 0)
	self.contour.interactable.selected_color = Vector3(1, 1, 1)
	self.contour.contour_off = {}
	self.contour.contour_off.standard_color = Vector3(0, 0, 0)
	self.contour.contour_off.selected_color = Vector3(0, 0, 0)
	self.contour.contour_off.standard_opacity = 0
	self.contour.deployable = {}
	self.contour.deployable.standard_color = Vector3(0.1, 1, 0.5)
	self.contour.deployable.selected_color = Vector3(1, 1, 1)
	self.contour.upgradable = {}
	self.contour.upgradable.standard_color = Vector3(0.1, 0.5, 1)
	self.contour.upgradable.selected_color = Vector3(1, 1, 1)
	self.contour.pickup = {}
	self.contour.pickup.standard_color = Vector3(0.1, 1, 0.5)
	self.contour.pickup.selected_color = Vector3(1, 1, 1)
	self.contour.pickup.standard_opacity = 1
	self.contour.interactable_icon = {}
	self.contour.interactable_icon.standard_color = Vector3(0, 0, 0)
	self.contour.interactable_icon.selected_color = Vector3(0, 1, 0)
	self.contour.interactable_icon.standard_opacity = 0
	self.music = {}
	self.music.hit = {}
	self.music.hit.intro = "music_hit_setup"
	self.music.hit.anticipation = "music_hit_anticipation"
	self.music.hit.assault = "music_hit_assault"
	self.music.hit.fake_assault = "music_hit_assault"
	self.music.hit.control = "music_hit_control"
	self.music.stress = {}
	self.music.stress.intro = "music_stress_setup"
	self.music.stress.anticipation = "music_stress_anticipation"
	self.music.stress.assault = "music_stress_assault"
	self.music.stress.fake_assault = "music_stress_assault"
	self.music.stress.control = "music_stress_control"
	self.music.stealth = {}
	self.music.stealth.intro = "music_stealth_setup"
	self.music.stealth.anticipation = "music_stealth_anticipation"
	self.music.stealth.assault = "music_stealth_assault"
	self.music.stealth.fake_assault = "music_stealth_assault"
	self.music.stealth.control = "music_stealth_control"
	self.music.heist = {}
	self.music.heist.intro = "music_heist_setup"
	self.music.heist.anticipation = "music_heist_anticipation"
	self.music.heist.assault = "music_heist_assault"
	self.music.heist.fake_assault = "music_heist_assault"
	self.music.heist.control = "music_heist_control"
	self.music.heist.switches = {
		"track_01",
		"track_02",
		"track_03",
		"track_04",
		"track_05",
		"track_06",
		"track_07",
		"track_08",
		"track_09",
		"track_10",
		"track_12",
		"track_13"
	}
	self.music.heist.switches_infamous = {"track_11"}
	self.music.big_bank = {}
	self.music.big_bank.intro = "music_heist_setup"
	self.music.big_bank.anticipation = "music_heist_anticipation"
	self.music.big_bank.assault = "music_heist_assault"
	self.music.big_bank.fake_assault = "music_heist_assault"
	self.music.big_bank.control = "music_heist_control"
	self.music.big_bank.switches = {"track_14"}
	self.music.big_bank.switches_infamous = {"track_11"}
	self.music.default = deep_clone(self.music.heist)
	self.blame = {}
	self.blame.default = "hint_blame_missing"
	self.blame.empty = nil
	self.blame.cam_criminal = "hint_cam_criminal"
	self.blame.cam_dead_body = "hint_cam_dead_body"
	self.blame.cam_hostage = "hint_cam_hostage"
	self.blame.cam_distress = "hint_cam_distress"
	self.blame.cam_body_bag = "hint_body_bag"
	self.blame.cam_gunfire = "hint_gunfire"
	self.blame.cam_drill = "hint_cam_drill"
	self.blame.cam_saw = "hint_cam_saw"
	self.blame.cam_sentry_gun = "hint_sentry_gun"
	self.blame.cam_trip_mine = "hint_trip_mine"
	self.blame.cam_ecm_jammer = "hint_ecm_jammer"
	self.blame.cam_c4 = "hint_c4"
	self.blame.cam_computer = "hint_computer"
	self.blame.cam_glass = "hint_glass"
	self.blame.cam_broken_cam = "hint_cam_broken_cam"
	self.blame.cam_vault = "hint_vault"
	self.blame.cam_fire = "hint_fire"
	self.blame.cam_voting = "hint_voting"
	self.blame.cam_breaking_entering = "hint_breaking_entering"
	self.blame.civ_criminal = "hint_civ_criminal"
	self.blame.civ_dead_body = "hint_civ_dead_body"
	self.blame.civ_hostage = "hint_civ_hostage"
	self.blame.civ_distress = "hint_civ_distress"
	self.blame.civ_body_bag = "hint_civ_body_bag"
	self.blame.civ_gunfire = "hint_civ_gunfire"
	self.blame.civ_drill = "hint_civ_drill"
	self.blame.civ_saw = "hint_civ_saw"
	self.blame.civ_sentry_gun = "hint_civ_sentry_gun"
	self.blame.civ_trip_mine = "hint_civ_trip_mine"
	self.blame.civ_ecm_jammer = "hint_civ_ecm_jammer"
	self.blame.civ_c4 = "hint_civ_c4"
	self.blame.civ_computer = "hint_civ_computer"
	self.blame.civ_glass = "hint_civ_glass"
	self.blame.civ_broken_cam = "hint_civ_broken_cam"
	self.blame.civ_vault = "hint_civ_vault"
	self.blame.civ_fire = "hint_civ_fire"
	self.blame.civ_voting = "hint_civ_voting"
	self.blame.civ_breaking_entering = "hint_civ_breaking_entering"
	self.blame.cop_criminal = "hint_cop_criminal"
	self.blame.cop_dead_body = "hint_cop_dead_body"
	self.blame.cop_hostage = "hint_cop_hostage"
	self.blame.cop_distress = "hint_cop_distress"
	self.blame.cop_body_bag = "hint_cop_body_bag"
	self.blame.cop_gunfire = "hint_cop_gunfire"
	self.blame.cop_drill = "hint_cop_drill"
	self.blame.cop_saw = "hint_cop_saw"
	self.blame.cop_sentry_gun = "hint_cop_sentry_gun"
	self.blame.cop_trip_mine = "hint_cop_trip_mine"
	self.blame.cop_ecm_jammer = "hint_cop_ecm_jammer"
	self.blame.cop_c4 = "hint_cop_c4"
	self.blame.cop_computer = "hint_cop_computer"
	self.blame.cop_glass = "hint_cop_glass"
	self.blame.cop_broken_cam = "hint_cop_broken_cam"
	self.blame.cop_vault = "hint_cop_vault"
	self.blame.cop_fire = "hint_cop_fire"
	self.blame.cop_voting = "hint_cop_voting"
	self.blame.cop_breaking_entering = "hint_cop_breaking_entering"
	self.blame.sys_explosion = "hint_alert_explosion"
	self.blame.civ_explosion = "hint_alert_explosion"
	self.blame.cop_explosion = "hint_alert_explosion"
	self.blame.gan_explosion = "hint_alert_explosion"
	self.blame.cam_explosion = "hint_alert_explosion"
	self.blame.sys_blackmailer = "hint_blame_blackmailer"
	self.blame.sys_gensec = "hint_blame_gensec"
	self.blame.sys_police_alerted = "hint_blame_police_alerted"
	self.blame.sys_csgo_gunfire = "hint_blame_csgo_gunfire"
	self.blame.met_criminal = "hint_met_criminal"
	self.blame.mot_criminal = "hint_mot_criminal"
	self.blame.gls_alarm = "hint_alarm_glass"
	self.blame.alarm_pager_bluff_failed = "hint_alarm_pager_bluff_failed"
	self.blame.alarm_pager_not_answered = "hint_alarm_pager_not_answered"
	self.blame.alarm_pager_hang_up = "hint_alarm_pager_hang_up"
	self.blame.civ_alarm = "hint_alarm_civ"
	self.blame.cop_alarm = "hint_alarm_cop"
	self.blame.gan_alarm = "hint_alarm_cop"
	self.blame.cam_crate_open = "hint_cam_crate_open"
	self.blame.civ_crate_open = "hint_civ_crate_open"
	self.blame.cop_crate_open = "hint_cop_crate_open"
	self.blame.gan_crate_open = "hint_cop_crate_open"
	self.casino = {}
	self.casino.unlock_level = 10
	self.casino.entrance_level = {
		14,
		28,
		42,
		56,
		70,
		84,
		100
	}
	self.casino.entrance_fee = {
		1000000,
		3000000,
		9000000,
		15000000,
		20000000,
		25000000,
		30000000
	}
	self.casino.prefer_cost = 1500000
	self.casino.prefer_chance = 0.1
	self.casino.secure_card_cost = {
		10000000,
		33000000,
		65000000
	}
	self.casino.secure_card_level = {
		10,
		40,
		60
	}
	self.casino.infamous_cost = 30000000
	self.casino.infamous_chance = 3
	self.grenades = {}
	self.grenades.frag = {}
	self.grenades.frag.damage = 30
	self.grenades.frag.player_damage = 10
	self.grenades.frag.range = 1000
	self:set_difficulty()
	self:set_mode()
	self:digest_tweak_data()
end

function TweakData:_execute_reload_clbks()
	if self._reload_clbks then
		for key, clbk_data in pairs(self._reload_clbks) do
			if clbk_data.func then
				clbk_data.func(clbk_data.clbk_object)
			end
		end
	end
end

function TweakData:add_reload_callback(object, func)
	self._reload_clbks = self._reload_clbks or {}
	table.insert(self._reload_clbks, {clbk_object = object, func = func})
end

function TweakData:remove_reload_callback(object)
	if self._reload_clbks then
		for i, k in ipairs(self._reload_clbks) do
			if k.clbk_object == object then
				table.remove(self._reload_clbks, i)
				return
			end
		end
	end
end

function TweakData:set_scale()
	local lang_key = SystemInfo:language():key()
	local lang_mods = {
		[Idstring("german"):key()] = {
			large = 0.9,
			small = 1,
			sd_large = 0.9,
			sd_small = 0.9,
			sd_menu_border_multiplier = 0.9,
			stats_upgrade_kern = -1,
			level_up_text_kern = -1.5,
			objectives_text_kern = -1,
			menu_logo_multiplier = 0.9,
			kit_desc_large = 0.9,
			sd_w_interact_multiplier = 1.55,
			w_interact_multiplier = 1.65
		}
	}
	lang_mods[Idstring("french"):key()] = {
		large = 0.9,
		small = 1,
		sd_large = 0.9,
		sd_small = 0.95,
		victory_screen_kern = -0.5,
		objectives_text_kern = -0.8,
		level_up_text_kern = -1.5,
		sd_level_up_font_multiplier = 0.9,
		stats_upgrade_kern = -1,
		kit_desc_large = 0.9,
		sd_w_interact_multiplier = 1.3,
		w_interact_multiplier = 1.4,
		subtitle_multiplier = 0.85
	}
	lang_mods[Idstring("italian"):key()] = {
		large = 1,
		small = 1,
		sd_large = 1,
		sd_small = 1,
		objectives_text_kern = -0.8,
		kit_desc_large = 0.9,
		sd_w_interact_multiplier = 1.5,
		w_interact_multiplier = 1.35
	}
	lang_mods[Idstring("spanish"):key()] = {
		large = 1,
		small = 1,
		sd_large = 1,
		sd_small = 0.9,
		sd_menu_border_multiplier = 0.85,
		stats_upgrade_kern = -1,
		upgrade_menu_kern = -1.25,
		level_up_text_kern = -1.5,
		menu_logo_multiplier = 0.9,
		objectives_text_kern = -0.8,
		objectives_desc_text_kern = 0,
		level_up_text_kern = -1.5,
		sd_level_up_font_multiplier = 0.9,
		kit_desc_large = 0.9,
		sd_w_interact_multiplier = 1.5,
		w_interact_multiplier = 1.6,
		server_list_font_multiplier = 0.9,
		victory_title_multiplier = 0.9
	}
	local lang_l_mod = lang_mods[lang_key] and lang_mods[lang_key].large or 1
	local lang_s_mod = lang_mods[lang_key] and lang_mods[lang_key].small or 1
	local lang_lsd_mod = lang_mods[lang_key] and lang_mods[lang_key].sd_large or 1
	local lang_ssd_mod = lang_mods[lang_key] and lang_mods[lang_key].sd_large or 1
	local sd_menu_border_multiplier = lang_mods[lang_key] and lang_mods[lang_key].sd_menu_border_multiplier or 1
	local stats_upgrade_kern = lang_mods[lang_key] and lang_mods[lang_key].stats_upgrade_kern or 0
	local level_up_text_kern = lang_mods[lang_key] and lang_mods[lang_key].level_up_text_kern or 0
	local victory_screen_kern = lang_mods[lang_key] and lang_mods[lang_key].victory_screen_kern
	local upgrade_menu_kern = lang_mods[lang_key] and lang_mods[lang_key].upgrade_menu_kern
	local mugshot_name_kern = lang_mods[lang_key] and lang_mods[lang_key].mugshot_name_kern
	local menu_logo_multiplier = lang_mods[lang_key] and lang_mods[lang_key].menu_logo_multiplier or 1
	local objectives_text_kern = lang_mods[lang_key] and lang_mods[lang_key].objectives_text_kern
	local objectives_desc_text_kern = lang_mods[lang_key] and lang_mods[lang_key].objectives_desc_text_kern
	local kit_desc_large = lang_mods[lang_key] and lang_mods[lang_key].kit_desc_large or 1
	local sd_level_up_font_multiplier = lang_mods[lang_key] and lang_mods[lang_key].sd_level_up_font_multiplier or 1
	local sd_w_interact_multiplier = lang_mods[lang_key] and lang_mods[lang_key].sd_w_interact_multiplier or 1
	local w_interact_multiplier = lang_mods[lang_key] and lang_mods[lang_key].w_interact_multiplier or 1
	local server_list_font_multiplier = lang_mods[lang_key] and lang_mods[lang_key].server_list_font_multiplier or 1
	local victory_title_multiplier = lang_mods[lang_key] and lang_mods[lang_key].victory_title_multiplier
	local subtitle_multiplier = lang_mods[lang_key] and lang_mods[lang_key].subtitle_multiplier or 1
	local res = RenderSettings.resolution
	self.sd_scale = {}
	self.sd_scale.is_sd = true
	self.sd_scale.title_image_multiplier = 0.6
	self.sd_scale.menu_logo_multiplier = 0.575 * menu_logo_multiplier
	self.sd_scale.menu_border_multiplier = 0.6 * sd_menu_border_multiplier
	self.sd_scale.default_font_multiplier = 0.6 * lang_lsd_mod
	self.sd_scale.small_font_multiplier = 0.8 * lang_ssd_mod
	self.sd_scale.lobby_info_font_size_scale_multiplier = 0.65
	self.sd_scale.lobby_name_font_size_scale_multiplier = 0.6
	self.sd_scale.server_list_font_size_multiplier = 0.55
	self.sd_scale.multichoice_arrow_multiplier = 0.7
	self.sd_scale.align_line_padding_multiplier = 0.4
	self.sd_scale.menu_arrow_padding_multiplier = 0.5
	self.sd_scale.briefing_text_h_multiplier = 0.5
	self.sd_scale.experience_bar_multiplier = 0.825
	self.sd_scale.hud_equipment_icon_multiplier = 0.65
	self.sd_scale.hud_default_font_multiplier = 0.7
	self.sd_scale.hud_ammo_clip_multiplier = 0.75
	self.sd_scale.hud_ammo_clip_large_multiplier = 0.5
	self.sd_scale.hud_health_multiplier = 0.75
	self.sd_scale.hud_mugshot_multiplier = 0.75
	self.sd_scale.hud_assault_image_multiplier = 0.5
	self.sd_scale.hud_crosshair_offset_multiplier = 0.75
	self.sd_scale.hud_objectives_pad_multiplier = 0.65
	self.sd_scale.experience_upgrade_multiplier = 0.75
	self.sd_scale.level_up_multiplier = 0.7
	self.sd_scale.next_upgrade_font_multiplier = 0.75
	self.sd_scale.level_up_font_multiplier = 0.51 * sd_level_up_font_multiplier
	self.sd_scale.present_multiplier = 0.75
	self.sd_scale.lobby_info_offset_multiplier = 0.7
	self.sd_scale.info_padding_multiplier = 0.4
	self.sd_scale.loading_challenge_bar_scale = 0.8
	self.sd_scale.kit_menu_bar_scale = 0.65
	self.sd_scale.kit_menu_description_h_scale = 1.22
	self.sd_scale.button_layout_multiplier = 0.7
	self.sd_scale.subtitle_pos_multiplier = 0.7
	self.sd_scale.subtitle_font_multiplier = 0.65
	self.sd_scale.subtitle_lang_multiplier = subtitle_multiplier
	self.sd_scale.default_font_kern = 0
	self.sd_scale.stats_upgrade_kern = stats_upgrade_kern or 0
	self.sd_scale.level_up_text_kern = level_up_text_kern or 0
	self.sd_scale.victory_screen_kern = victory_screen_kern or -0.5
	self.sd_scale.upgrade_menu_kern = upgrade_menu_kern or 0
	self.sd_scale.mugshot_name_kern = mugshot_name_kern or -1
	self.sd_scale.objectives_text_kern = objectives_text_kern or 0
	self.sd_scale.objectives_desc_text_kern = objectives_desc_text_kern or 0
	self.sd_scale.kit_description_multiplier = 0.8 * lang_ssd_mod
	self.sd_scale.chat_multiplier = 0.68
	self.sd_scale.chat_menu_h_multiplier = 0.34
	self.sd_scale.w_interact_multiplier = 0.8 * sd_w_interact_multiplier
	self.sd_scale.victory_title_multiplier = victory_title_multiplier and victory_title_multiplier * 0.95 or 1
	self.scale = {}
	self.scale.is_sd = false
	self.scale.title_image_multiplier = 1
	self.scale.menu_logo_multiplier = 1
	self.scale.menu_border_multiplier = 1
	self.scale.default_font_multiplier = 1 * lang_l_mod
	self.scale.small_font_multiplier = 1 * lang_s_mod
	self.scale.lobby_info_font_size_scale_multiplier = 1 * lang_l_mod
	self.scale.lobby_name_font_size_scale_multiplier = 1 * lang_l_mod
	self.scale.server_list_font_size_multiplier = 1 * lang_l_mod * server_list_font_multiplier
	self.scale.multichoice_arrow_multiplier = 1
	self.scale.align_line_padding_multiplier = 1
	self.scale.menu_arrow_padding_multiplier = 1
	self.scale.briefing_text_h_multiplier = 1 * lang_s_mod
	self.scale.experience_bar_multiplier = 1
	self.scale.hud_equipment_icon_multiplier = 1
	self.scale.hud_default_font_multiplier = 1 * lang_l_mod
	self.scale.hud_ammo_clip_multiplier = 1
	self.scale.hud_health_multiplier = 1
	self.scale.hud_mugshot_multiplier = 1
	self.scale.hud_assault_image_multiplier = 1
	self.scale.hud_crosshair_offset_multiplier = 1
	self.scale.hud_objectives_pad_multiplier = 1
	self.scale.experience_upgrade_multiplier = 1
	self.scale.level_up_multiplier = 1
	self.scale.next_upgrade_font_multiplier = 1 * lang_l_mod
	self.scale.level_up_font_multiplier = 1 * lang_l_mod
	self.scale.present_multiplier = 1
	self.scale.lobby_info_offset_multiplier = 1
	self.scale.info_padding_multiplier = 1
	self.scale.loading_challenge_bar_scale = 1
	self.scale.kit_menu_bar_scale = 1
	self.scale.kit_menu_description_h_scale = 1
	self.scale.button_layout_multiplier = 1
	self.scale.subtitle_pos_multiplier = 1
	self.scale.subtitle_font_multiplier = 1 * lang_l_mod
	self.scale.subtitle_lang_multiplier = subtitle_multiplier
	self.scale.default_font_kern = 0
	self.scale.stats_upgrade_kern = stats_upgrade_kern or 0
	self.scale.level_up_text_kern = 0
	self.scale.victory_screen_kern = victory_screen_kern or 0
	self.scale.upgrade_menu_kern = 0
	self.scale.mugshot_name_kern = 0
	self.scale.objectives_text_kern = objectives_text_kern or 0
	self.scale.objectives_desc_text_kern = objectives_desc_text_kern or 0
	self.scale.kit_description_multiplier = 1 * kit_desc_large
	self.scale.chat_multiplier = 1
	self.scale.chat_menu_h_multiplier = 1
	self.scale.w_interact_multiplier = 1 * w_interact_multiplier
	self.scale.victory_title_multiplier = victory_title_multiplier or 1
end

function TweakData:set_menu_scale()
	local lang_mods_def = {
		[Idstring("german"):key()] = {
			topic_font_size = 0.8,
			challenges_font_size = 1,
			upgrades_font_size = 1,
			mission_end_font_size = 1
		},
		[Idstring("french"):key()] = {
			topic_font_size = 1,
			challenges_font_size = 1,
			upgrades_font_size = 1,
			mission_end_font_size = 1
		},
		[Idstring("italian"):key()] = {
			topic_font_size = 1,
			challenges_font_size = 1,
			upgrades_font_size = 1,
			mission_end_font_size = 0.95
		},
		[Idstring("spanish"):key()] = {
			topic_font_size = 0.95,
			challenges_font_size = 0.95,
			upgrades_font_size = 1,
			mission_end_font_size = 1
		}
	}
	local lang_mods = lang_mods_def[SystemInfo:language():key()] or {
		topic_font_size = 1,
		challenges_font_size = 1,
		upgrades_font_size = 1,
		mission_end_font_size = 1
	}
	local scale_multiplier = self.scale.default_font_multiplier
	local small_scale_multiplier = self.scale.small_font_multiplier
	self.menu.default_font = "fonts/font_medium_shadow_mf"
	self.menu.default_font_no_outline = "fonts/font_medium_noshadow_mf"
	self.menu.default_font_id = Idstring(self.menu.default_font)
	self.menu.default_font_no_outline_id = Idstring(self.menu.default_font_no_outline)
	self.menu.small_font = "fonts/font_small_shadow_mf"
	self.menu.small_font_size = 14 * small_scale_multiplier
	self.menu.small_font_noshadow = "fonts/font_small_noshadow_mf"
	self.menu.medium_font = "fonts/font_medium_shadow_mf"
	self.menu.medium_font_no_outline = "fonts/font_medium_noshadow_mf"
	self.menu.meidum_font_size = 24 * scale_multiplier
	self.menu.eroded_font = "fonts/font_eroded"
	self.menu.eroded_font_size = 80
	self.menu.pd2_massive_font = "fonts/font_large_mf"
	self.menu.pd2_massive_font_id = Idstring(self.menu.pd2_massive_font)
	self.menu.pd2_massive_font_size = 80
	self.menu.pd2_large_font = "fonts/font_large_mf"
	self.menu.pd2_large_font_id = Idstring(self.menu.pd2_large_font)
	self.menu.pd2_large_font_size = 44
	self.menu.pd2_medium_font = "fonts/font_medium_mf"
	self.menu.pd2_medium_font_id = Idstring(self.menu.pd2_medium_font)
	self.menu.pd2_medium_font_size = 24
	self.menu.pd2_small_font = "fonts/font_small_mf"
	self.menu.pd2_small_font_id = Idstring(self.menu.pd2_small_font)
	self.menu.pd2_small_font_size = 20
	self.menu.default_font_size = 24 * scale_multiplier
	self.menu.default_font_row_item_color = Color.white
	self.menu.default_hightlight_row_item_color = Color(1, 0, 0, 0)
	self.menu.default_menu_background_color = Color(1, 0.3254902, 0.37254903, 0.39607844)
	self.menu.highlight_background_color_left = Color(1, 1, 0.65882355, 0)
	self.menu.highlight_background_color_right = Color(1, 1, 0.65882355, 0)
	self.menu.default_changeable_text_color = Color(255, 77, 198, 255) / 255
	self.menu.default_disabled_text_color = Color(1, 0.5, 0.5, 0.5)
	self.menu.arrow_available = Color(1, 1, 0.65882355, 0)
	self.menu.arrow_unavailable = Color(1, 0.5, 0.5, 0.5)
	self.menu.arrow_unavailable = Color(1, 0.5, 0.5, 0.5)
	self.menu.upgrade_locked_color = Color(0.75, 0, 0)
	self.menu.upgrade_not_aquired_color = Color(0.5, 0.5, 0.5)
	self.menu.awarded_challenge_color = self.menu.default_font_row_item_color
	self.menu.dialog_title_font_size = 28 * self.scale.small_font_multiplier
	self.menu.dialog_text_font_size = 24 * self.scale.small_font_multiplier
	self.menu.info_padding = 10 * self.scale.info_padding_multiplier
	self.menu.topic_font_size = 32 * scale_multiplier * lang_mods.topic_font_size
	self.menu.main_menu_background_color = Color(1, 0, 0, 0)
	self.menu.kit_default_font_size = 24 * scale_multiplier
	self.menu.stats_font_size = 24 * scale_multiplier
	self.menu.customize_controller_size = 21 * scale_multiplier
	self.menu.server_list_font_size = 22 * self.scale.server_list_font_size_multiplier
	self.menu.challenges_font_size = 24 * scale_multiplier * lang_mods.challenges_font_size
	self.menu.upgrades_font_size = 24 * scale_multiplier * lang_mods.upgrades_font_size
	self.menu.multichoice_font_size = 24 * scale_multiplier
	self.menu.mission_end_font_size = 20 * scale_multiplier * lang_mods.mission_end_font_size
	self.menu.sd_mission_end_font_size = 14 * small_scale_multiplier * lang_mods.mission_end_font_size
	self.menu.lobby_info_font_size = 22 * self.scale.lobby_info_font_size_scale_multiplier
	self.menu.lobby_name_font_size = 22 * self.scale.lobby_name_font_size_scale_multiplier
	self.menu.loading_challenge_progress_font_size = 22 * small_scale_multiplier
	self.menu.loading_challenge_name_font_size = 22 * small_scale_multiplier
	self.menu.upper_saferect_border = 64 * self.scale.menu_border_multiplier
	self.menu.border_pad = 8 * self.scale.menu_border_multiplier
	self.menu.kit_description_font_size = 14 * self.scale.kit_description_multiplier
	self.load_level = {}
	self.load_level.briefing_text = {
		h = 192 * self.scale.briefing_text_h_multiplier
	}
	self.load_level.upper_saferect_border = self.menu.upper_saferect_border
	self.load_level.border_pad = self.menu.border_pad
	self.load_level.stonecold_small_logo = "guis/textures/game_small_logo"
end

function TweakData:set_hud_values()
	local lang_mods_def = {
		[Idstring("german"):key()] = {
			hint_font_size = 0.9,
			stats_challenges_font_size = 0.7,
			active_objective_title_font_size = 0.9,
			present_mid_text_font_size = 0.8,
			next_player_font_size = 0.85,
			location_font_size = 1
		},
		[Idstring("french"):key()] = {
			hint_font_size = 0.825,
			stats_challenges_font_size = 1,
			active_objective_title_font_size = 1,
			present_mid_text_font_size = 1,
			next_player_font_size = 0.85,
			location_font_size = 1
		},
		[Idstring("italian"):key()] = {
			hint_font_size = 1,
			stats_challenges_font_size = 1,
			active_objective_title_font_size = 1,
			present_mid_text_font_size = 1,
			next_player_font_size = 0.85,
			location_font_size = 1
		},
		[Idstring("spanish"):key()] = {
			hint_font_size = 1,
			stats_challenges_font_size = 1,
			active_objective_title_font_size = 1,
			present_mid_text_font_size = 1,
			next_player_font_size = 0.85,
			location_font_size = 0.7
		}
	}
	local lang_mods = lang_mods_def[SystemInfo:language():key()] or {
		hint_font_size = 1,
		stats_challenges_font_size = 1,
		active_objective_title_font_size = 1,
		present_mid_text_font_size = 1,
		next_player_font_size = 1,
		location_font_size = 1
	}
	self.hud.medium_font = "fonts/font_medium_mf"
	self.hud.medium_font_noshadow = "fonts/font_medium_mf"
	self.hud.small_font = "fonts/font_small_mf"
	self.hud.small_font_size = 14 * self.scale.small_font_multiplier
	self.hud.location_font_size = 28 * self.scale.hud_default_font_multiplier * lang_mods.location_font_size
	self.hud.assault_title_font_size = 30 * self.scale.hud_default_font_multiplier
	self.hud.default_font_size = 32 * self.scale.hud_default_font_multiplier
	self.hud.present_mid_text_font_size = 32 * self.scale.hud_default_font_multiplier * lang_mods.present_mid_text_font_size
	self.hud.timer_font_size = 40 * self.scale.hud_default_font_multiplier
	self.hud.medium_deafult_font_size = 28 * self.scale.hud_default_font_multiplier
	self.hud.ammo_font_size = 30 * self.scale.hud_default_font_multiplier
	self.hud.weapon_ammo_font_size = 24 * self.scale.hud_default_font_multiplier
	self.hud.name_label_font_size = 24 * self.scale.hud_default_font_multiplier
	self.hud.equipment_font_size = 24 * self.scale.hud_default_font_multiplier
	self.hud.hint_font_size = 28 * self.scale.hud_default_font_multiplier * lang_mods.hint_font_size
	self.hud.active_objective_title_font_size = 24 * self.scale.hud_default_font_multiplier * lang_mods.active_objective_title_font_size
	self.hud.completed_objective_title_font_size = 20 * self.scale.hud_default_font_multiplier
	self.hud.upgrade_awarded_font_size = 26 * self.scale.hud_default_font_multiplier
	self.hud.next_upgrade_font_size = 14 * self.scale.next_upgrade_font_multiplier
	self.hud.level_up_font_size = 32 * self.scale.level_up_font_multiplier
	self.hud.next_player_font_size = 24 * self.scale.hud_default_font_multiplier * lang_mods.next_player_font_size
	self.hud.stats_challenges_font_size = 32 * self.scale.hud_default_font_multiplier * lang_mods.stats_challenges_font_size
	self.hud.chatinput_size = 22 * self.scale.hud_default_font_multiplier
	self.hud.chatoutput_size = 14 * self.scale.small_font_multiplier
	self.hud.prime_color = Color(1, 1, 0.65882355, 0)
	self.hud.suspicion_color = Color(1, 0, 0.46666667, 0.69803923)
	self.hud.detected_color = Color(1, 1, 0.2, 0)
end

function TweakData:resolution_changed()
	self:set_scale()
	self:set_menu_scale()
	self:set_hud_values()
end

if (not tweak_data or tweak_data.RELOAD) and managers.dlc then
	local reload = tweak_data and tweak_data.RELOAD
	local reload_clbks = tweak_data and tweak_data._reload_clbks
	tweak_data = TweakData:new()
	tweak_data._reload_clbks = reload_clbks
	if reload then
		tweak_data:_execute_reload_clbks()
	end
end

function TweakData:get_controller_help_coords()
	if managers.controller:get_default_wrapper_type() == "pc" then
		return false
	end
	local coords = {}
	if SystemInfo:platform() == Idstring("PS3") then
		coords.menu_button_sprint = {
			x = 195,
			y = 255,
			align = "right",
			vertical = "top"
		}
		coords.menu_button_move = {
			x = 195,
			y = 280,
			align = "right",
			vertical = "top"
		}
		coords.menu_button_melee = {
			x = 319,
			y = 255,
			align = "left",
			vertical = "top"
		}
		coords.menu_button_look = {
			x = 319,
			y = 280,
			align = "left",
			vertical = "top"
		}
		coords.menu_button_switch_weapon = {
			x = 511,
			y = 112,
			align = "left"
		}
		coords.menu_button_reload = {
			x = 511,
			y = 214,
			align = "left"
		}
		coords.menu_button_crouch = {
			x = 511,
			y = 146,
			align = "left"
		}
		coords.menu_button_jump = {
			x = 511,
			y = 178,
			align = "left"
		}
		coords.menu_button_shout = {
			x = 511,
			y = 8,
			align = "left"
		}
		coords.menu_button_fire_weapon = {
			x = 511,
			y = 36,
			align = "left"
		}
		coords.menu_button_deploy = {
			x = 0,
			y = 8,
			align = "right"
		}
		coords.menu_button_aim_down_sight = {
			x = 0,
			y = 36,
			align = "right"
		}
		coords.menu_button_ingame_menu = {
			x = 280,
			y = 0,
			align = "left",
			vertical = "bottom"
		}
		coords.menu_button_stats_screen = {
			x = 230,
			y = 0,
			align = "right",
			vertical = "bottom"
		}
		coords.menu_button_weapon_gadget = {
			x = 0,
			y = 171,
			align = "right",
			vertical = "center"
		}
		coords.menu_button_throw_grenade = {
			x = 0,
			y = 145,
			align = "right",
			vertical = "center"
		}
		coords.menu_button_weapon_firemode = {
			x = 0,
			y = 87,
			align = "right",
			vertical = "center"
		}
	else
		coords.menu_button_sprint = {
			x = 0,
			y = 138,
			align = "right",
			vertical = "bottom"
		}
		coords.menu_button_move = {
			x = 0,
			y = 138,
			align = "right",
			vertical = "top"
		}
		coords.menu_button_melee = {
			x = 302,
			y = 256,
			align = "left",
			vertical = "top"
		}
		coords.menu_button_look = {
			x = 302,
			y = 281,
			align = "left",
			vertical = "top"
		}
		coords.menu_button_switch_weapon = {
			x = 512,
			y = 97,
			align = "left"
		}
		coords.menu_button_reload = {
			x = 512,
			y = 180,
			align = "left"
		}
		coords.menu_button_crouch = {
			x = 512,
			y = 125,
			align = "left"
		}
		coords.menu_button_jump = {
			x = 512,
			y = 153,
			align = "left"
		}
		coords.menu_button_shout = {
			x = 512,
			y = 49,
			align = "left"
		}
		coords.menu_button_fire_weapon = {
			x = 512,
			y = 19,
			align = "left"
		}
		coords.menu_button_deploy = {
			x = 0,
			y = 49,
			align = "right"
		}
		coords.menu_button_aim_down_sight = {
			x = 0,
			y = 19,
			align = "right"
		}
		coords.menu_button_ingame_menu = {
			x = 288,
			y = 0,
			align = "left",
			vertical = "bottom"
		}
		coords.menu_button_stats_screen = {
			x = 223,
			y = 0,
			align = "right",
			vertical = "bottom"
		}
		coords.menu_button_weapon_gadget = {
			x = 0,
			y = 243,
			align = "right",
			vertical = "center"
		}
		coords.menu_button_throw_grenade = {
			x = 0,
			y = 208,
			align = "right",
			vertical = "center"
		}
		coords.menu_button_weapon_firemode = {
			x = 226,
			y = 256,
			align = "right",
			vertical = "top"
		}
		if SystemInfo:platform() == Idstring("WIN32") then
			coords.menu_button_push_to_talk = {
				x = 0,
				y = 174,
				align = "right",
				vertical = "center"
			}
		end
	end
	if managers.user and managers.user:get_setting("southpaw") then
		local tmp = coords.menu_button_move
		coords.menu_button_move = coords.menu_button_look
		coords.menu_button_look = tmp
	end
	return coords
end
