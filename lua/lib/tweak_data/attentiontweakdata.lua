AttentionTweakData = AttentionTweakData or class()

function AttentionTweakData:init()
	self.settings = {}
	self.indexes = {}
	self:_init_player()
	self:_init_team_AI()
	self:_init_civilian()
	self:_init_enemy()
	self:_init_drill()
	self:_init_sentry_gun()
	self:_init_prop()
	self:_init_custom()
	self:_post_init()
end

function AttentionTweakData:_init_player()
	self.settings.pl_team_cur_peaceful = {
		reaction = "REACT_IDLE",
		filter = "criminal",
		max_range = 1000,
		notice_delay_mul = 1,
		verification_interval = 4,
		release_delay = 3,
		duration = {2, 5},
		pause = {15, 25},
		notice_requires_FOV = false
	}
	self.settings.pl_team_idle_std = {
		reaction = "REACT_IDLE",
		filter = "criminal",
		max_range = 1000,
		notice_delay_mul = 0,
		verification_interval = 4,
		release_delay = 3,
		duration = {1.7, 2.5},
		pause = {45, 90},
		notice_requires_FOV = false
	}
	self.settings.pl_gangster_cur_peaceful = {
		reaction = "REACT_SUSPICIOUS",
		filter = "gangster",
		max_range = 600,
		suspicion_range = 500,
		suspicion_duration = 5.5,
		turn_around_range = 250,
		uncover_range = 90,
		notice_delay_mul = 0.3,
		verification_interval = 0.02,
		release_delay = 2,
		notice_requires_FOV = true
	}
	self.settings.pl_gangster_cbt = {
		reaction = "REACT_COMBAT",
		filter = "gangster",
		verification_interval = 1,
		release_delay = 1,
		uncover_range = 550,
		notice_requires_FOV = true
	}
	self.settings.pl_law_susp_peaceful = {
		reaction = "REACT_SUSPICIOUS",
		filter = "law_enforcer",
		max_range = 600,
		suspicion_range = 500,
		suspicion_duration = 4,
		turn_around_range = 250,
		uncover_range = 150,
		notice_delay_mul = 0.3,
		verification_interval = 0.02,
		release_delay = 2,
		notice_requires_FOV = true
	}
	self.settings.pl_enemy_cur_peaceful = {
		reaction = "REACT_CURIOUS",
		filter = "all_enemy",
		max_range = 600,
		notice_delay_mul = 0.5,
		verification_interval = 2,
		release_delay = 1,
		duration = {1.5, 3.5},
		pause = {25, 50},
		notice_requires_FOV = true
	}
	self.settings.pl_enemy_cbt = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		verification_interval = 1,
		notice_interval = 0.1,
		uncover_range = 550,
		release_delay = 1,
		notice_clbk = "clbk_attention_notice_sneak",
		notice_requires_FOV = true
	}
	self.settings.pl_enemy_cbt_crh = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		verification_interval = 0.1,
		uncover_range = 350,
		release_delay = 1,
		notice_delay_mul = 2,
		notice_requires_FOV = true
	}
	self.settings.pl_enemy_sneak = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		verification_interval = 0.1,
		uncover_range = 350,
		release_delay = 1,
		notice_delay_mul = 2,
		max_range = 1500,
		notice_clbk = "clbk_attention_notice_sneak",
		notice_requires_FOV = true
	}
	self.settings.pl_civ_idle_peaceful = {
		reaction = "REACT_IDLE",
		filter = "civilian",
		max_range = 600,
		notice_delay_mul = 0,
		notice_interval = 0.5,
		attract_chance = 0.5,
		verification_interval = 2,
		release_delay = 3,
		duration = {2, 15},
		pause = {10, 60},
		notice_requires_FOV = true
	}
	self.settings.pl_civ_sneak = {
		reaction = "REACT_COMBAT",
		filter = "civilian",
		verification_interval = 0.1,
		uncover_range = 200,
		release_delay = 1,
		notice_delay_mul = 3,
		max_range = 1500,
		notice_clbk = "clbk_attention_notice_sneak",
		notice_requires_FOV = true
	}
	self.settings.pl_civ_cbt = {
		reaction = "REACT_COMBAT",
		filter = "civilian",
		verification_interval = 0.1,
		uncover_range = 550,
		release_delay = 1,
		notice_delay_mul = 1.5,
		notice_clbk = "clbk_attention_notice_sneak",
		notice_requires_FOV = true
	}
end

function AttentionTweakData:_init_team_AI()
	self.settings.team_team_idle = {
		reaction = "REACT_IDLE",
		filter = "criminal",
		max_range = 1000,
		verification_interval = 3,
		release_delay = 2,
		duration = {1.5, 4},
		pause = {25, 40},
		notice_requires_FOV = false
	}
	self.settings.team_enemy_idle = {
		reaction = "REACT_IDLE",
		filter = "all_enemy",
		max_range = 550,
		verification_interval = 3,
		release_delay = 1,
		duration = {1.5, 3},
		pause = {35, 60},
		notice_requires_FOV = false
	}
	self.settings.team_enemy_cbt = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		max_range = 20000,
		notice_interval = 1,
		verification_interval = 1.5,
		uncover_range = 400,
		release_delay = 1,
		notice_requires_FOV = true,
		weight_mul = 0.5
	}
end

function AttentionTweakData:_init_civilian()
	self.settings.civ_all_peaceful = {
		reaction = "REACT_IDLE",
		filter = "all",
		max_range = 2000,
		verification_interval = 3,
		release_delay = 2,
		duration = {1.5, 6},
		pause = {35, 60},
		notice_requires_FOV = true
	}
	self.settings.civ_enemy_cbt = {
		reaction = "REACT_SCARED",
		filter = "all_enemy",
		max_range = 8000,
		uncover_range = 300,
		notice_delay_mul = 0.6,
		verification_interval = 0.1,
		release_delay = 6,
		duration = {3, 6},
		notice_clbk = "clbk_attention_notice_corpse",
		notice_requires_FOV = true
	}
	self.settings.civ_enemy_corpse_sneak = {
		reaction = "REACT_SCARED",
		filter = "civilians_enemies",
		max_range = 2500,
		uncover_range = 300,
		notice_delay_mul = 0.05,
		verification_interval = 0.1,
		release_delay = 6,
		notice_requires_FOV = true
	}
	self.settings.civ_civ_cbt = {
		reaction = "REACT_SCARED",
		filter = "civilian",
		uncover_range = 300,
		notice_delay_mul = 0.05,
		verification_interval = 0.1,
		release_delay = 6,
		duration = {3, 6},
		notice_requires_FOV = true
	}
end

function AttentionTweakData:_init_enemy()
	self.settings.enemy_team_idle = {
		reaction = "REACT_IDLE",
		filter = "criminal",
		max_range = 2000,
		verification_interval = 3,
		release_delay = 1,
		duration = {2, 4},
		pause = {9, 40},
		notice_requires_FOV = false
	}
	self.settings.enemy_team_cbt = {
		reaction = "REACT_COMBAT",
		filter = "criminal",
		max_range = 20000,
		notice_delay_mul = 0,
		notice_interval = 0.2,
		verification_interval = 0.75,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.enemy_law_corpse_sneak = self.settings.civ_enemy_corpse_sneak
	self.settings.enemy_team_corpse_sneak = self.settings.civ_enemy_corpse_sneak
	self.settings.enemy_law_corpse_cbt = {
		reaction = "REACT_CURIOUS",
		filter = "law_enforcer",
		max_range = 800,
		notice_delay_mul = 0.1,
		verification_interval = 1.5,
		release_delay = 1,
		duration = {2, 3},
		pause = {30, 120},
		notice_requires_FOV = true
	}
	self.settings.enemy_team_corpse_cbt = {
		reaction = "REACT_IDLE",
		filter = "criminal",
		max_range = 800,
		notice_delay_mul = 2,
		verification_interval = 1.5,
		release_delay = 0,
		duration = {2, 3},
		pause = {50, 360},
		notice_requires_FOV = true
	}
	self.settings.enemy_enemy_cbt = {
		reaction = "REACT_SCARED",
		filter = "all_enemy",
		max_range = 8000,
		uncover_range = 300,
		notice_delay_mul = 0.5,
		verification_interval = 0.5,
		release_delay = 1,
		notice_requires_FOV = true
	}
	self.settings.enemy_civ_cbt = {
		reaction = "REACT_SCARED",
		filter = "civilian",
		max_range = 8000,
		uncover_range = 300,
		notice_delay_mul = 0.2,
		verification_interval = 0.5,
		release_delay = 6,
		duration = {1.5, 3},
		notice_requires_FOV = true
	}
end

function AttentionTweakData:_init_custom()
	self.settings.custom_void = {
		reaction = "REACT_IDLE",
		filter = "none",
		max_range = 2000,
		verification_interval = 10,
		release_delay = 10
	}
	self.settings.custom_team_idle = {
		reaction = "REACT_IDLE",
		filter = "criminal",
		max_range = 2000,
		verification_interval = 3,
		release_delay = 1,
		duration = {2, 4},
		pause = {9, 40},
		notice_requires_FOV = false
	}
	self.settings.custom_team_cbt = {
		reaction = "REACT_COMBAT",
		filter = "criminal",
		max_range = 20000,
		verification_interval = 1.5,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_team_shoot_const = {
		reaction = "REACT_SHOOT",
		filter = "criminal",
		max_range = 10000,
		verification_interval = 1.5,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_team_shoot_burst = {
		reaction = "REACT_SHOOT",
		filter = "criminal",
		max_range = 10000,
		verification_interval = 1.5,
		release_delay = 2,
		duration = {2, 4},
		notice_requires_FOV = false
	}
	self.settings.custom_team_aim_const = {
		reaction = "REACT_AIM",
		filter = "criminal",
		max_range = 10000,
		verification_interval = 1.5,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_enemy_forest_survive_kruka = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		max_range = 20000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_enemy_suburbia_shootout = {
		reaction = "REACT_SHOOT",
		filter = "all_enemy",
		max_range = 12000,
		verification_interval = 2,
		release_delay = 5,
		turn_around_range = 15000,
		notice_requires_FOV = true,
		weight_mul = 0.5
	}
	self.settings.custom_enemy_suburbia_shootout_cops = {
		reaction = "REACT_SHOOT",
		filter = "all_enemy",
		max_range = 2000,
		verification_interval = 2,
		release_delay = 5,
		turn_around_range = 15000,
		notice_requires_FOV = true
	}
	self.settings.custom_enemy_china_store_vase_shoot = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		max_range = 1200,
		verification_interval = 2,
		release_delay = 3,
		turn_around_range = 500,
		notice_requires_FOV = true
	}
	self.settings.custom_enemy_china_store_vase_melee = {
		reaction = "REACT_MELEE",
		filter = "all_enemy",
		max_range = 500,
		verification_interval = 5,
		release_delay = 10,
		pause = 10,
		turn_around_range = 250,
		notice_requires_FOV = true
	}
	self.settings.custom_enemy_china_store_vase_aim = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		max_range = 500,
		verification_interval = 5,
		release_delay = 10,
		pause = 10,
		notice_requires_FOV = false
	}
	self.settings.custom_enemy_shoot_const = {
		reaction = "REACT_SHOOT",
		filter = "all_enemy",
		max_range = 10000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = true
	}
	self.settings.custom_gangster_shoot_const = {
		reaction = "REACT_SHOOT",
		filter = "gangster",
		max_range = 10000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = true
	}
	self.settings.custom_law_shoot_const = {
		reaction = "REACT_SHOOT",
		filter = "law_enforcer",
		max_range = 100000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_law_look_in_container = {
		reaction = "REACT_AIM",
		filter = "law_enforcer",
		max_range = 100000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_law_shoot_const_escape_vehicle = {
		reaction = "REACT_COMBAT",
		filter = "law_enforcer",
		max_range = 4500,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_law_shoot_const_container = {
		reaction = "REACT_SHOOT",
		filter = "law_enforcer",
		max_range = 2000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_gangsters_shoot_warehouse = {
		reaction = "REACT_COMBAT",
		filter = "gangster",
		max_range = 2000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_gangster_sniper_apartment_suspicous = {
		reaction = "REACT_SCARED",
		filter = "law_enforcer",
		max_range = 850,
		verification_interval = 1,
		release_delay = 6,
		notice_requires_FOV = true,
		uncover_range = 350,
		notice_delay_mul = 0.1
	}
	self.settings.custom_gangster_docks_idle = {
		reaction = "REACT_CURIOUS",
		filter = "gangster",
		max_range = 10000,
		verification_interval = 1,
		release_delay = 6,
		notice_requires_FOV = true
	}
	self.settings.custom_enemy_civ_scared = {
		reaction = "REACT_SCARED",
		filter = "civilians_enemies",
		verification_interval = 5,
		release_delay = 2,
		duration = {2, 4},
		notice_requires_FOV = true
	}
	self.settings.custom_boat_gangster = {
		reaction = "REACT_COMBAT",
		filter = "gangster",
		max_range = 4000,
		verification_interval = 1,
		release_delay = 2,
		notice_requires_FOV = false
	}
	self.settings.custom_law_cbt = {
		reaction = "REACT_COMBAT",
		filter = "law_enforcer",
		verification_interval = 1,
		uncover_range = 350,
		release_delay = 1,
		notice_clbk = "clbk_attention_notice_sneak",
		notice_requires_FOV = true
	}
	self.settings.custom_airport_window = {
		reaction = "REACT_CURIOUS",
		filter = "all_enemy",
		max_range = 1500,
		uncover_range = 100,
		notice_delay_mul = 0.2,
		verification_interval = 1.5,
		release_delay = 6,
		duration = {3, 6},
		notice_requires_FOV = true
	}
	self.settings.custom_look_at = {
		reaction = "REACT_IDLE",
		filter = "all_enemy",
		max_range = 15000,
		notice_delay_mul = 0.2,
		verification_interval = 1,
		release_delay = 3,
		notice_requires_FOV = false
	}
	self.settings.custom_look_at_FOV = {
		reaction = "REACT_CURIOUS",
		filter = "all_enemy",
		max_range = 1500,
		notice_delay_mul = 0.2,
		verification_interval = 1.5,
		release_delay = 6,
		duration = {3, 6},
		notice_requires_FOV = true
	}
	self.settings.custom_server_room = {
		reaction = "REACT_SCARED",
		filter = "all_enemy",
		max_range = 350,
		uncover_range = 100,
		notice_delay_mul = 0.2,
		verification_interval = 1.5,
		release_delay = 6,
		duration = {3, 6},
		notice_requires_FOV = true
	}
end

function AttentionTweakData:_init_drill()
	self.settings.drill_civ_ene_ntl = {
		reaction = "REACT_SCARED",
		filter = "civilians_enemies",
		verification_interval = 0.4,
		uncover_range = 200,
		release_delay = 1,
		notice_requires_FOV = false
	}
end

function AttentionTweakData:_init_sentry_gun()
	self.settings.sentry_gun_enemy_cbt = {
		reaction = "REACT_COMBAT",
		filter = "all_enemy",
		verification_interval = 1.5,
		uncover_range = 300,
		release_delay = 1
	}
end

function AttentionTweakData:_init_prop()
	self.settings.prop_civ_ene_ntl = {
		reaction = "REACT_AIM",
		filter = "civilians_enemies",
		verification_interval = 0.4,
		uncover_range = 500,
		release_delay = 1,
		notice_requires_FOV = true
	}
	self.settings.prop_ene_ntl = {
		reaction = "REACT_AIM",
		filter = "all_enemy",
		verification_interval = 0.4,
		uncover_range = 500,
		release_delay = 1,
		notice_requires_FOV = true
	}
	self.settings.broken_cam_ene_ntl = {
		reaction = "REACT_AIM",
		filter = "law_enforcer",
		verification_interval = 0.4,
		uncover_range = 100,
		suspicion_range = 1000,
		max_range = 1200,
		release_delay = 1,
		notice_requires_FOV = true
	}
	self.settings.prop_law_scary = {
		reaction = "REACT_SCARED",
		filter = "law_enforcer",
		verification_interval = 0.4,
		uncover_range = 300,
		release_delay = 1,
		notice_requires_FOV = true
	}
	self.settings.prop_state_civ_ene_ntl = {
		reaction = "REACT_CURIOUS",
		filter = "civilians_enemies",
		verification_interval = 0.4,
		uncover_range = 200,
		release_delay = 1,
		notice_requires_FOV = true
	}
end

function AttentionTweakData:get_attention_index(setting_name)
	for i_setting, test_setting_name in ipairs(self.indexes) do
		if setting_name == test_setting_name then
			return i_setting
		end
	end
end

function AttentionTweakData:get_attention_name(index)
	return self.indexes[index]
end

function AttentionTweakData:_post_init()
	for setting_name, setting in pairs(self.settings) do
		table.insert(self.indexes, setting_name)
	end
end
