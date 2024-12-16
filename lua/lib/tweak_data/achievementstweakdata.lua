AchievementsTweakData = AchievementsTweakData or class()

function AchievementsTweakData:init(tweak_data)
	local normal_and_above = {
		"normal",
		"hard",
		"overkill",
		"overkill_145",
		"easy_wish",
		"overkill_290",
		"sm_wish"
	}
	local hard_and_above = {
		"hard",
		"overkill",
		"overkill_145",
		"easy_wish",
		"overkill_290",
		"sm_wish"
	}
	local veryhard_and_above = {
		"overkill",
		"overkill_145",
		"easy_wish",
		"overkill_290",
		"sm_wish"
	}
	local overkill_and_above = {
		"overkill_145",
		"easy_wish",
		"overkill_290",
		"sm_wish"
	}
	local easywish_and_above = {
		"easy_wish",
		"overkill_290",
		"sm_wish"
	}
	local deathwish_and_above = {
		"overkill_290",
		"sm_wish"
	}
	local sm_wish_and_above = {"sm_wish"}
	self.im_a_healer_tank_damage_dealer = 10
	self.iron_man = "level_7"
	self.going_places = 1000000
	self.spend_money_to_make_money = 1000000
	self.you_gotta_start_somewhere = 5
	self.guilty_of_crime = 10
	self.gone_in_30_seconds = 25
	self.armed_and_dangerous = 50
	self.big_shot = 75
	self.most_wanted = 100
	self.fully_loaded = 9
	self.weapon_collector = 18
	self.arms_dealer = 72
	self.how_do_you_like_me_now = "level_1"
	self.like_an_angry_bear = "bear"
	self.merry_christmas = "santa_happy"
	self.witch_doctor = {
		mask = "witch",
		stat = "halloween_4_stats"
	}
	self.its_alive_its_alive = {
		mask = "frank",
		stat = "halloween_5_stats"
	}
	self.pump_action = {
		mask = "pumpkin_king",
		stat = "halloween_6_stats"
	}
	self.cant_hear_you_scream = {
		mask = "venomorph",
		stat = "halloween_7_stats"
	}
	self.unique_selling_point = "usp"
	self.relation_with_bulldozer = {
		mask = "clinton",
		stat = "armored_8_stat"
	}
	self.no_we_cant = {
		mask = "obama",
		stat = "armored_10_stat"
	}
	self.heat_around_the_corner = "heat"
	self.fire_in_the_hole = {
		stat = "gage_9_stats",
		grenade = {
			"frag",
			"frag_com",
			"concussion",
			"dada_com"
		}
	}
	self.tango_4 = {
		award = "tango_achieve_4",
		count = 10,
		difficulty = overkill_and_above
	}
	self.infamous = {
		"ignominy_1",
		"ignominy_2",
		"ignominy_3",
		"ignominy_4",
		"ignominy_5",
		"ignominy_6",
		"ignominy_7",
		"ignominy_8",
		"ignominy_9",
		"ignominy_10",
		"ignominy_11",
		"ignominy_12",
		"ignominy_13",
		"ignominy_14",
		"ignominy_15",
		"ignominy_16",
		"ignominy_17",
		"ignominy_18",
		"ignominy_19",
		"ignominy_20",
		"ignominy_21",
		"ignominy_22",
		"ignominy_23",
		"ignominy_24",
		"ignominy_25"
	}
	self.final_rule = {
		stat = "gage2_3_stats",
		melee_type = "fists",
		heist = "nightclub"
	}
	self.easy_as_breathing = {
		award = "gage2_4",
		count = 10,
		weapon_type = "lmg"
	}
	self.first_blood = {
		award = "gage2_5",
		weapon_type = "lmg",
		count = 220
	}
	self.in_town_you_are_law = {award = "gage2_6", weapon_type = "shotgun"}
	self.dont_push_it = {award = "gage2_7", weapon = "deagle"}
	self.finally = {award = "gage2_8"}
	self.demise_knuckles = "brass_knuckles"
	self.vote_for_change = "g22c"
	self.steam_500k = "akm_gold"
	self.shotgun_one_o_one = {
		count = 50,
		accuracy = 101,
		award = "gage4_5"
	}
	self.close_and_personal = {
		award = "gage4_3",
		kill_type = "melee",
		count = 50
	}
	self.cavity = {award = "bulldog_4", melee_type = "toothbrush"}
	self.double_trouble = {
		award = "ovk_9",
		converted_cops = 4,
		difficulty = overkill_and_above
	}
	self.never_let_you_go = {
		award = "ovk_3",
		timer = 25,
		weapon_id = "m134"
	}
	self.nothing_to_see_here = {
		award = "slakt_2",
		total_value = 4,
		timer = 90
	}
	self.drive_away = "fort_2"
	self.disco_inferno = "grill_1"
	self.overgrill = "grill_4"
	self.pickup_sticks = {
		stat = "scorpion_1_stats",
		weapon_category = "bow"
	}
	self.pincushion = {
		award = "scorpion_3",
		enemy = "tank",
		count = 10,
		weapon_category = "bow"
	}
	self.jordan_1 = "brooklyn_1"
	self.jordan_2 = {
		award = "brooklyn_2",
		count = 100,
		timer = 30
	}
	self.one_man_army = {
		award = "gage5_3",
		equipped = {
			primary = "gre_m79",
			secondary = "serbu",
			armor = "level_7"
		}
	}
	self.man_5 = {
		award = "man_5",
		job = "man",
		difficulty = overkill_and_above,
		weapon_category = "grenade_launcher"
	}
	self.mad_5 = "mad_5"
	self.peta_4 = {
		award = "peta_4",
		count = 1,
		carry_id = "goat"
	}
	self.weapons_owned = {
		gage4_2 = {
			"huntsman",
			"r870",
			"saiga",
			"ksg",
			"striker",
			"serbu",
			"benelli"
		},
		gage5_4 = {
			"gre_m79",
			"g3",
			"galil",
			"famas"
		}
	}
	self.gage_assignments = {
		green_mantis = "gmod_1_stats",
		yellow_bull = "gmod_2_stats",
		red_spider = "gmod_3_stats",
		blue_eagle = "gmod_4_stats",
		purple_snake = "gmod_5_stats"
	}
	self.gonna_find_them_all = 1
	self.weapon_blueprints = {
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
		},
		eagle_4 = {
			"wpn_fps_pis_c96_nozzle",
			"wpn_fps_pis_c96_sight"
		}
	}
	self.explosion_achievements = {
		shock_awe = {
			count = 4,
			weapon_type = "shotgun",
			award = "gage4_9"
		}
	}
	self.dot_achievements = {
		turtles_4 = {
			count = 3,
			variant = "poison",
			award = "turtles_4"
		}
	}
	self.grenade_achievements = {
		bada_boom = {
			count = 4,
			grenade_type = "launcher_frag",
			award = "gage5_2",
			kill = true
		},
		artillery_barrage = {
			grenade_type = "launcher_frag",
			stat = "gage5_5_stats",
			distance = 4000,
			kill = true
		},
		boom_shakalaka = {
			grenade_type = "launcher_frag",
			award = "gage5_7",
			enemy = "spooc",
			flying_strike = true,
			kill = true
		},
		not_invited = {
			grenade_type = "launcher_frag_m32",
			award = "grill_3",
			timer = 10,
			kill_count = 10
		},
		threemite = {
			count = 3,
			grenade_type = "dynamite",
			award = "scorpion_2",
			kill = true
		},
		steel_3 = {
			grenade_type = "wpn_prj_jav",
			award = "steel_3",
			kill = true,
			enemy = "spooc"
		},
		pim_2 = {
			stat = "pim_2_stats",
			job = "dark",
			grenade_type = "wpn_prj_target",
			crouching = true,
			kill = true,
			success = true,
			is_civilian = false
		},
		tango_2 = {
			stat = "tango_2_stats",
			enemy = "sniper",
			kill = true,
			grenade_type = "launcher_frag_arbiter"
		},
		any_kills = {challenge_stat = "any_kills", kill = true},
		any_sniper_kills = {
			challenge_stat = "any_sniper_kills",
			kill = true,
			enemy = "sniper"
		},
		any_shield_kills = {
			challenge_stat = "any_shield_kills",
			kill = true,
			enemy = "shield"
		},
		any_taser_kills = {
			challenge_stat = "any_taser_kills",
			kill = true,
			enemy = "taser"
		},
		any_tank_kills = {
			challenge_stat = "any_tank_kills",
			kill = true,
			enemy = "tank"
		},
		any_spooc_kills = {
			challenge_stat = "any_spooc_kills",
			kill = true,
			enemy = "spooc"
		},
		trophy_special_kills = {
			trophy_stat = "trophy_special_kills",
			enemies = {
				"sniper",
				"shield",
				"taser",
				"tank",
				"spooc",
				"medic"
			},
			kill = true
		},
		trophy_ace = {
			trophy_stat = "trophy_ace",
			kill = true,
			grenade_type = "wpn_prj_ace",
			difficulties = overkill_and_above
		},
		trophy_washington = {
			trophy_stat = "trophy_washington",
			kill = true
		},
		trophy_medic = {
			trophy_stat = "trophy_medic",
			enemies = {"medic"},
			kill = true
		},
		daily_grenades = {
			trophy_stat = "daily_grenades",
			grenade_type = "frag",
			kill = true,
			is_civilian = false
		},
		daily_grenades_community = {
			trophy_stat = "daily_grenades",
			grenade_type = "frag_com",
			kill = true,
			is_civilian = false
		},
		daily_grenades_dynamite = {
			trophy_stat = "daily_grenades",
			grenade_type = "dynamite",
			kill = true,
			is_civilian = false
		},
		daily_grenades_dada = {
			trophy_stat = "daily_grenades",
			grenade_type = "dada_com",
			kill = true,
			is_civilian = false
		}
	}
	self.shotgun_single_shot_kills = {
		tango_1 = {
			award = "tango_achieve_1",
			count = 3,
			blueprint = {
				"wpn_fps_upg_ns_duck"
			},
			headshot = true,
			is_not_civilian = true
		}
	}
	self.enemy_kill_achievements = {
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
			weapon_type = "snp"
		},
		arachnes_curse = {
			stat = "gage3_4_stats",
			in_head = true,
			weapon_type = "snp"
		},
		pest_control = {
			stat = "gage3_5_stats",
			in_head = true,
			weapon_type = "snp"
		},
		seer_of_death = {
			stat = "gage3_6_stats",
			in_head = true,
			weapon_type = "snp"
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
			weapon_type = "snp"
		},
		grand_master_sniper = {
			stat = "gage3_14_stats",
			enemy = "sniper",
			weapon = "msr"
		},
		public_enemy_no_one = {
			stat = "gage3_17_stats",
			weapon = "msr"
		},
		knock_knock = {
			stat = "gage4_6_stats",
			enemy = "shield",
			weapon_type = "shotgun",
			part_id = "wpn_fps_upg_a_slug"
		},
		peek_a_boo = {
			stat = "gage4_8_stats",
			enemy = "sniper",
			weapon_type = "shotgun",
			part_id = "wpn_fps_upg_a_piercing"
		},
		seven_eleven = {
			award = "gage4_4",
			weapon_type = "shotgun",
			in_head = true,
			timer = 11,
			count = 7
		},
		bang_for_buck = {
			stat = "gage4_10_stats",
			enemy = "tank",
			weapon_type = "shotgun",
			parts = {
				"wpn_fps_upg_a_custom",
				"wpn_fps_upg_a_custom_free"
			}
		},
		grind_fest = {
			stat = "gage5_1_stats",
			enemy = "tank",
			weapon = "g3"
		},
		kill_streak = {
			stat = "gage5_9_stats",
			enemy = "spooc",
			weapon = "galil"
		},
		le_picnic = {
			stat = "gage5_10_stats",
			weapon = "famas"
		},
		repel_from_rope = {
			stat = "eagle_1_stats",
			weapon = "mosin",
			on_rope = true
		},
		bullet_hell = {
			award = "eagle_5",
			weapon = "mg42",
			timer = 10,
			count = 10
		},
		akm4_shootout = {
			stat = "ameno_08_stats",
			is_cop = true,
			weapons = {
				"ak74",
				"akm",
				"akm_gold",
				"saiga",
				"rpk",
				"amcar",
				"new_m4",
				"m16",
				"akmsu",
				"olympic",
				"flint"
			}
		},
		scorpion_4 = {
			award = "scorpion_4",
			weapon = "peacemaker",
			in_steelsight = false,
			timer = 6,
			count = 6
		},
		turtles_1 = {
			award = "turtles_1",
			weapon = "wa2000",
			count_no_reload = 11
		},
		turtles_2 = {
			award = "turtles_2",
			weapon = "polymer",
			kill_count = 100
		},
		berry_5 = {
			award = "berry_5",
			weapon = "model70",
			in_steelsight = false,
			in_head = true,
			count_in_row = 10
		},
		assault_rifle_kills = {
			challenge_stat = "assault_rifle_kills",
			weapon_type = "assault_rifle"
		},
		shotgun_kills = {
			challenge_stat = "shotgun_kills",
			weapon_type = "shotgun"
		},
		smg_kills = {challenge_stat = "smg_kills", weapon_type = "smg"},
		pistol_kills = {
			challenge_stat = "pistol_kills",
			weapon_type = "pistol"
		},
		any_kills = {challenge_stat = "any_kills"},
		any_headshot_kills = {
			challenge_stat = "any_headshot_kills",
			in_head = true
		},
		any_sniper_kills = {
			challenge_stat = "any_sniper_kills",
			enemy = "sniper"
		},
		any_shield_kills = {
			challenge_stat = "any_shield_kills",
			enemy = "shield"
		},
		any_taser_kills = {
			challenge_stat = "any_taser_kills",
			enemy = "taser"
		},
		any_tank_kills = {
			challenge_stat = "any_tank_kills",
			enemy = "tank"
		},
		any_spooc_kills = {
			challenge_stat = "any_spooc_kills",
			enemy = "spooc"
		},
		trophy_headshots = {
			trophy_stat = "trophy_headshots",
			in_head = true
		},
		trophy_washington = {
			trophy_stat = "trophy_washington"
		},
		trophy_smg = {
			trophy_stat = "trophy_smg",
			weapon_type = "smg",
			timer = 25,
			count = 25
		},
		trophy_special_kills = {
			trophy_stat = "trophy_special_kills",
			enemies = {
				"sniper",
				"shield",
				"taser",
				"tank",
				"spooc",
				"medic"
			}
		},
		trophy_medic = {
			trophy_stat = "trophy_medic",
			enemies = {"medic"}
		},
		pim_1 = {
			stat = "pim_1_stats",
			weapon = "desertfox",
			difficulty = overkill_and_above,
			enemies = {"sniper"}
		},
		pim_3 = {
			stat = "pim_3_stats",
			weapon = "schakal",
			difficulty = overkill_and_above,
			level_id = "mad",
			enemies = {
				"sniper",
				"shield",
				"taser",
				"tank",
				"spooc",
				"medic"
			}
		},
		grv_2 = {
			award = "grv_2",
			weapon = "coal",
			count_no_reload = 32
		},
		grv_3 = {
			stat = "grv_3_stats",
			weapons = {
				"siltstone",
				"flint",
				"coal"
			}
		}
	}
	self.enemy_melee_kill_achievements = {
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
			difficulty = overkill_and_above,
			health = 25
		},
		police_brutality = {
			award = "gage4_1",
			enemy = "shield",
			melee_id = "baton"
		},
		every_day_shovelin = {
			stat = "gage4_7_stats",
			level_id = "nightclub",
			melee_id = "shovel",
			is_cop = true
		},
		cant_touch_this = {
			stat = "gage5_8_stats",
			melee_id = "dingdong",
			is_gangster = true
		},
		hurting_people = {
			stat = "pig_3_stats",
			melee_id = "baseballbat",
			enemies = {
				"mobster",
				"mobster_boss",
				"biker_boss"
			},
			jobs = {"mia"}
		},
		special_operations = {
			stat = "eagle_2_stats",
			melee_id = "fairbair",
			is_not_civilian = true,
			is_stealth = true
		},
		knockout = {
			award = "gorilla_1",
			enemy = "tank",
			melee_id = "boxing_gloves"
		},
		stick_a_fork_in_me = {
			award = "grill_2",
			melee_id = "fork",
			is_on_fire = true,
			is_not_civilian = true
		},
		steel_2 = {
			award = "steel_2",
			melee_weapons = {
				"morning",
				"buck",
				"beardy",
				"great"
			},
			enemy_kills = {enemy = "shield", count = 10}
		},
		steel_4 = {
			award = "steel_4",
			melee_id = "great",
			enemy = "tank",
			enemy_weapon = "saiga"
		},
		melee_kills = {
			challenge_stat = "melee_kills",
			is_not_civilian = true
		},
		any_kills = {challenge_stat = "any_kills", is_not_civilian = true},
		any_sniper_kills = {
			challenge_stat = "any_sniper_kills",
			enemy = "sniper",
			is_not_civilian = true
		},
		any_shield_kills = {
			challenge_stat = "any_shield_kills",
			enemy = "shield",
			is_not_civilian = true
		},
		any_taser_kills = {
			challenge_stat = "any_taser_kills",
			enemy = "taser",
			is_not_civilian = true
		},
		any_tank_kills = {
			challenge_stat = "any_tank_kills",
			enemy = "tank",
			is_not_civilian = true
		},
		any_spooc_kills = {
			challenge_stat = "any_spooc_kills",
			enemy = "spooc",
			is_not_civilian = true
		},
		trophy_knockouts = {
			trophy_stat = "trophy_knockouts",
			enemies = {"tank", "tank_hw"},
			melee_id = "boxing_gloves",
			is_not_civilian = true
		},
		trophy_washington = {
			trophy_stat = "trophy_washington",
			is_not_civilian = true
		},
		trophy_medic = {
			trophy_stat = "trophy_medic",
			enemy = "medic",
			is_not_civilian = true
		},
		trophy_special_kills = {
			trophy_stat = "trophy_special_kills",
			enemies = {
				"sniper",
				"shield",
				"taser",
				"tank",
				"spooc",
				"medic"
			},
			is_not_civilian = true
		},
		daily_hangover = {
			trophy_stat = "daily_hangover",
			melee_id = "whiskey",
			is_not_civilian = true
		}
	}
	self.complete_heist_achievements = {
		in_soviet_russia = {
			stat = "halloween_10_stats",
			mask = "bear",
			difficulty = overkill_and_above,
			contract = "vlad"
		},
		i_take_scores = {
			stat = "armored_4_stat",
			mask = "heat",
			difficulty = overkill_and_above,
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
			difficulty = overkill_and_above,
			job = "roberts"
		},
		stealth_election_day = {
			award = "bob_3",
			stealth = true,
			job = "election_day"
		},
		death_stealth_election_day = {
			award = "bob_7",
			difficulty = deathwish_and_above,
			stealth = true,
			job = "election_day"
		},
		easywish_ukranian = {
			award = "pick_1",
			difficulty = easywish_and_above,
			job = "ukrainian_job_prof"
		},
		easywish_mallcrasher = {
			award = "pick_2",
			difficulty = easywish_and_above,
			job = "mallcrasher"
		},
		easywish_four_stores = {
			award = "pick_3",
			difficulty = easywish_and_above,
			job = "four_stores"
		},
		easywish_nightclub = {
			award = "pick_4",
			difficulty = easywish_and_above,
			job = "nightclub"
		},
		easywish_watchdogs = {
			award = "pick_5",
			difficulty = easywish_and_above,
			jobs = {
				"watchdogs_wrapper",
				"watchdogs_night",
				"watchdogs"
			}
		},
		easywish_rats = {
			award = "pick_7",
			difficulty = easywish_and_above,
			job = "alex"
		},
		easywish_firestarter = {
			award = "pick_9",
			difficulty = easywish_and_above,
			job = "firestarter"
		},
		easywish_framing_frame = {
			award = "pick_11",
			difficulty = easywish_and_above,
			job = "framing_frame"
		},
		easywish_big_oil = {
			award = "pick_13",
			difficulty = easywish_and_above,
			jobs = {
				"welcome_to_the_jungle_wrapper_prof",
				"welcome_to_the_jungle_night_prof",
				"welcome_to_the_jungle_prof"
			}
		},
		easywish_jewelry_store = {
			award = "pick_14",
			difficulty = easywish_and_above,
			job = "jewelry_store"
		},
		easywish_diamond_store = {
			award = "pick_15",
			difficulty = easywish_and_above,
			job = "family"
		},
		easywish_go_bank = {
			award = "pick_16",
			difficulty = easywish_and_above,
			job = "roberts"
		},
		easywish_bank_heist = {
			award = "pick_17",
			difficulty = easywish_and_above,
			job = "branchbank_prof"
		},
		easywish_bank_heist_gold = {
			award = "pick_18",
			difficulty = easywish_and_above,
			job = "branchbank_gold_prof"
		},
		easywish_bank_heist_cash = {
			award = "pick_19",
			difficulty = easywish_and_above,
			job = "branchbank_cash"
		},
		easywish_bank_heist_deposit = {
			award = "pick_20",
			difficulty = easywish_and_above,
			job = "branchbank_deposit"
		},
		easywish_transport_crossroads = {
			award = "pick_21",
			difficulty = easywish_and_above,
			job = "arm_cro"
		},
		easywish_transport_downtown = {
			award = "pick_22",
			difficulty = easywish_and_above,
			job = "arm_hcm"
		},
		easywish_transport_harbor = {
			award = "pick_23",
			difficulty = easywish_and_above,
			job = "arm_fac"
		},
		easywish_transport_park = {
			award = "pick_24",
			difficulty = easywish_and_above,
			job = "arm_par"
		},
		easywish_transport_underpass = {
			award = "pick_25",
			difficulty = easywish_and_above,
			job = "arm_und"
		},
		easywish_transport_train = {
			award = "pick_26",
			difficulty = easywish_and_above,
			job = "arm_for"
		},
		easywish_election_day = {
			award = "pick_27",
			difficulty = easywish_and_above,
			job = "election_day"
		},
		easywish_kosugi = {
			award = "pick_29",
			difficulty = easywish_and_above,
			job = "kosugi"
		},
		easywish_bigbank = {
			award = "pick_30",
			difficulty = easywish_and_above,
			job = "big"
		},
		easywish_miami = {
			award = "pick_31",
			difficulty = easywish_and_above,
			job = "mia"
		},
		easywish_artgallery = {
			award = "pick_33",
			difficulty = easywish_and_above,
			job = "gallery"
		},
		easywish_hoxton = {
			award = "pick_34",
			difficulty = easywish_and_above,
			job = "hox"
		},
		easywish_mus = {
			award = "pick_36",
			difficulty = easywish_and_above,
			job = "mus"
		},
		easywish_red = {
			award = "pick_37",
			difficulty = easywish_and_above,
			job = "red2"
		},
		easywish_dinner = {
			award = "pick_38",
			difficulty = easywish_and_above,
			job = "dinner"
		},
		easywish_hox_3 = {
			award = "pick_39",
			difficulty = easywish_and_above,
			job = "hox_3"
		},
		easywish_rat = {
			award = "pick_40",
			difficulty = easywish_and_above,
			job = "rat"
		},
		easywish_cage = {
			award = "pick_41",
			difficulty = easywish_and_above,
			job = "cage"
		},
		easywish_shoutout = {
			award = "pick_42",
			difficulty = easywish_and_above,
			job = "shoutout_raid"
		},
		easywish_arena = {
			award = "pick_43",
			difficulty = easywish_and_above,
			job = "arena"
		},
		easywish_kenaz = {
			award = "pick_44",
			difficulty = easywish_and_above,
			jobs = {"kenaz"}
		},
		easywish_sinus = {
			award = "pick_45",
			job = "jolly",
			difficulty = easywish_and_above
		},
		easywish_nails = {
			award = "pick_46",
			job = "nail",
			difficulty = easywish_and_above
		},
		easywish_berry = {
			award = "pick_47",
			difficulty = easywish_and_above,
			job = "pbr"
		},
		easywish_jerry = {
			award = "pick_48",
			difficulty = easywish_and_above,
			job = "pbr2"
		},
		easywish_peta = {
			award = "pick_49",
			difficulty = easywish_and_above,
			jobs = {"peta"}
		},
		easywish_pal = {
			award = "pick_51",
			difficulty = easywish_and_above,
			job = "pal"
		},
		easywish_man = {
			award = "pick_52",
			difficulty = easywish_and_above,
			job = "man"
		},
		easywish_dark = {
			award = "pick_53",
			difficulty = easywish_and_above,
			job = "dark"
		},
		easywish_cane = {
			award = "pick_54",
			difficulty = easywish_and_above,
			job = "cane"
		},
		easywish_flat = {
			award = "pick_55",
			difficulty = easywish_and_above,
			job = "flat"
		},
		easywish_mad = {
			award = "pick_56",
			difficulty = easywish_and_above,
			job = "mad"
		},
		easywish_born = {
			award = "pick_57",
			difficulty = easywish_and_above,
			job = "born"
		},
		easywish_help = {
			award = "orange_1",
			difficulty = easywish_and_above,
			job = "help"
		},
		easywish_moon = {
			award = "moon_1",
			difficulty = easywish_and_above,
			job = "moon"
		},
		easywish_friend = {
			award = "friend_1",
			difficulty = easywish_and_above,
			job = "friend"
		},
		easywish_spa = {
			award = "spa_1",
			difficulty = easywish_and_above,
			job = "spa"
		},
		easywish_fish = {
			award = "fish_1",
			difficulty = easywish_and_above,
			job = "fish"
		},
		easywish_glace = {
			award = "glace_5",
			difficulty = easywish_and_above,
			job = "glace"
		},
		easywish_run = {
			award = "run_5",
			difficulty = easywish_and_above,
			job = "run"
		},
		complete_pines_easywish = {
			award = "pick_59",
			difficulty = easywish_and_above,
			jobs = {"pines"}
		},
		complete_crojob_dock_easywish = {
			award = "pick_61",
			difficulty = easywish_and_above,
			jobs = {"crojob1"}
		},
		complete_crojob_for_easywish = {
			award = "pick_60",
			difficulty = easywish_and_above,
			jobs = {
				"crojob_wrapper",
				"crojob2",
				"crojob2_night"
			}
		},
		death_ukranian = {
			award = "death_1",
			difficulty = deathwish_and_above,
			job = "ukrainian_job_prof"
		},
		death_mallcrasher = {
			award = "death_2",
			difficulty = deathwish_and_above,
			job = "mallcrasher"
		},
		death_four_stores = {
			award = "death_3",
			difficulty = deathwish_and_above,
			job = "four_stores"
		},
		death_nightclub = {
			award = "death_4",
			difficulty = deathwish_and_above,
			job = "nightclub"
		},
		death_watchdogs = {
			award = "death_34",
			difficulty = deathwish_and_above,
			jobs = {
				"watchdogs_wrapper",
				"watchdogs_night",
				"watchdogs"
			}
		},
		death_rats = {
			award = "death_33",
			difficulty = deathwish_and_above,
			job = "alex"
		},
		death_firestarter = {
			award = "death_32",
			difficulty = deathwish_and_above,
			job = "firestarter"
		},
		death_framing_frame = {
			award = "death_35",
			difficulty = deathwish_and_above,
			job = "framing_frame"
		},
		death_big_oil = {
			award = "death_11",
			difficulty = deathwish_and_above,
			jobs = {
				"welcome_to_the_jungle_wrapper_prof",
				"welcome_to_the_jungle_night_prof",
				"welcome_to_the_jungle_prof"
			}
		},
		death_jewelry_store = {
			award = "death_13",
			difficulty = deathwish_and_above,
			job = "jewelry_store"
		},
		death_diamond_store = {
			award = "death_14",
			difficulty = deathwish_and_above,
			job = "family"
		},
		death_go_bank = {
			award = "death_15",
			difficulty = deathwish_and_above,
			job = "roberts"
		},
		death_bank_heist = {
			award = "death_16",
			difficulty = deathwish_and_above,
			job = "branchbank_prof"
		},
		death_bank_heist_gold = {
			award = "death_17",
			difficulty = deathwish_and_above,
			job = "branchbank_gold_prof"
		},
		death_bank_heist_cash = {
			award = "death_18",
			difficulty = deathwish_and_above,
			job = "branchbank_cash"
		},
		death_bank_heist_deposit = {
			award = "death_19",
			difficulty = deathwish_and_above,
			job = "branchbank_deposit"
		},
		death_transport_crossroads = {
			award = "death_20",
			difficulty = deathwish_and_above,
			job = "arm_cro"
		},
		death_transport_downtown = {
			award = "death_21",
			difficulty = deathwish_and_above,
			job = "arm_hcm"
		},
		death_transport_harbor = {
			award = "death_22",
			difficulty = deathwish_and_above,
			job = "arm_fac"
		},
		death_transport_park = {
			award = "death_23",
			difficulty = deathwish_and_above,
			job = "arm_par"
		},
		death_transport_underpass = {
			award = "death_24",
			difficulty = deathwish_and_above,
			job = "arm_und"
		},
		death_transport_train = {
			award = "death_25",
			difficulty = deathwish_and_above,
			job = "arm_for"
		},
		death_election_day = {
			award = "bob_9",
			difficulty = deathwish_and_above,
			job = "election_day"
		},
		death_kosugi = {
			award = "kosugi_6",
			difficulty = deathwish_and_above,
			job = "kosugi"
		},
		death_bigbank = {
			award = "bigbank_9",
			difficulty = deathwish_and_above,
			job = "big"
		},
		death_miami = {
			award = "pig_1",
			difficulty = deathwish_and_above,
			job = "mia"
		},
		death_artgallery = {
			award = "squek",
			difficulty = deathwish_and_above,
			job = "gallery"
		},
		death_hoxton = {
			award = "bulldog_2",
			difficulty = deathwish_and_above,
			job = "hox"
		},
		death_mus = {
			award = "bat_1",
			difficulty = deathwish_and_above,
			job = "mus"
		},
		death_red = {
			award = "green_5",
			difficulty = deathwish_and_above,
			job = "red2"
		},
		death_dinner = {
			award = "farm_5",
			difficulty = deathwish_and_above,
			job = "dinner"
		},
		death_hox_3 = {
			award = "payback_1",
			difficulty = deathwish_and_above,
			job = "hox_3"
		},
		death_rat = {
			award = "djur_1",
			difficulty = deathwish_and_above,
			job = "rat"
		},
		death_cage = {
			award = "fort_1",
			difficulty = deathwish_and_above,
			job = "cage"
		},
		death_shoutout = {
			award = "melt_1",
			difficulty = deathwish_and_above,
			job = "shoutout_raid"
		},
		death_arena = {
			award = "live_1",
			difficulty = deathwish_and_above,
			job = "arena"
		},
		death_kenaz = {
			award = "kenaz_1",
			difficulty = deathwish_and_above,
			jobs = {"kenaz"}
		},
		death_sinus = {
			award = "sinus_2",
			job = "jolly",
			difficulty = deathwish_and_above
		},
		death_nails = {
			award = "lab_3",
			job = "nail",
			difficulty = deathwish_and_above
		},
		death_berry = {
			award = "berry_1",
			difficulty = deathwish_and_above,
			job = "pbr"
		},
		death_jerry = {
			award = "jerry_1",
			difficulty = deathwish_and_above,
			job = "pbr2"
		},
		death_peta = {
			award = "peta_1",
			difficulty = deathwish_and_above,
			jobs = {"peta"}
		},
		death_pal = {
			award = "pal_1",
			difficulty = deathwish_and_above,
			job = "pal"
		},
		death_man = {
			award = "man_1",
			difficulty = deathwish_and_above,
			job = "man"
		},
		death_dark = {
			award = "dark_1",
			difficulty = deathwish_and_above,
			job = "dark"
		},
		death_cane = {
			award = "cane_1",
			difficulty = deathwish_and_above,
			job = "cane"
		},
		death_flat = {
			award = "flat_1",
			difficulty = deathwish_and_above,
			job = "flat"
		},
		death_mad = {
			award = "mad_1",
			difficulty = deathwish_and_above,
			job = "mad"
		},
		death_born = {
			award = "born_1",
			difficulty = deathwish_and_above,
			job = "born"
		},
		death_help = {
			award = "orange_2",
			difficulty = deathwish_and_above,
			job = "help"
		},
		death_moon = {
			award = "moon_2",
			difficulty = deathwish_and_above,
			job = "moon"
		},
		death_friend = {
			award = "friend_2",
			difficulty = deathwish_and_above,
			job = "friend"
		},
		death_spa = {
			award = "spa_2",
			difficulty = deathwish_and_above,
			job = "spa"
		},
		death_fish = {
			award = "fish_2",
			difficulty = deathwish_and_above,
			job = "fish"
		},
		death_glace = {
			award = "glace_6",
			difficulty = deathwish_and_above,
			job = "glace"
		},
		death_run = {
			award = "run_6",
			difficulty = deathwish_and_above,
			job = "run"
		},
		complete_pines_deathwish = {
			award = "deer_5",
			difficulty = deathwish_and_above,
			jobs = {"pines"}
		},
		complete_crojob_for_deathwish = {
			award = "cow_2",
			difficulty = deathwish_and_above,
			jobs = {
				"crojob_wrapper",
				"crojob2",
				"crojob2_night"
			}
		},
		complete_crojob_dock_deathwish = {
			award = "cow_7",
			difficulty = deathwish_and_above,
			jobs = {"crojob1"}
		},
		sm_wish_ukranian = {
			award = "axe_1",
			difficulty = sm_wish_and_above,
			job = "ukrainian_job_prof"
		},
		sm_wish_mallcrasher = {
			award = "axe_2",
			difficulty = sm_wish_and_above,
			job = "mallcrasher"
		},
		sm_wish_four_stores = {
			award = "axe_3",
			difficulty = sm_wish_and_above,
			job = "four_stores"
		},
		sm_wish_nightclub = {
			award = "axe_4",
			difficulty = sm_wish_and_above,
			job = "nightclub"
		},
		sm_wish_watchdogs = {
			award = "axe_5",
			difficulty = sm_wish_and_above,
			jobs = {
				"watchdogs_wrapper",
				"watchdogs_night",
				"watchdogs"
			}
		},
		sm_wish_rats = {
			award = "axe_7",
			difficulty = sm_wish_and_above,
			job = "alex"
		},
		sm_wish_firestarter = {
			award = "axe_9",
			difficulty = sm_wish_and_above,
			job = "firestarter"
		},
		sm_wish_framing_frame = {
			award = "axe_11",
			difficulty = sm_wish_and_above,
			job = "framing_frame"
		},
		sm_wish_big_oil = {
			award = "axe_13",
			difficulty = sm_wish_and_above,
			jobs = {
				"welcome_to_the_jungle_wrapper_prof",
				"welcome_to_the_jungle_night_prof",
				"welcome_to_the_jungle_prof"
			}
		},
		sm_wish_jewelry_store = {
			award = "axe_14",
			difficulty = sm_wish_and_above,
			job = "jewelry_store"
		},
		sm_wish_diamond_store = {
			award = "axe_15",
			difficulty = sm_wish_and_above,
			job = "family"
		},
		sm_wish_go_bank = {
			award = "axe_16",
			difficulty = sm_wish_and_above,
			job = "roberts"
		},
		sm_wish_bank_heist = {
			award = "axe_17",
			difficulty = sm_wish_and_above,
			job = "branchbank_prof"
		},
		sm_wish_bank_heist_gold = {
			award = "axe_18",
			difficulty = sm_wish_and_above,
			job = "branchbank_gold_prof"
		},
		sm_wish_bank_heist_cash = {
			award = "axe_19",
			difficulty = sm_wish_and_above,
			job = "branchbank_cash"
		},
		sm_wish_bank_heist_deposit = {
			award = "axe_20",
			difficulty = sm_wish_and_above,
			job = "branchbank_deposit"
		},
		sm_wish_transport_crossroads = {
			award = "axe_21",
			difficulty = sm_wish_and_above,
			job = "arm_cro"
		},
		sm_wish_transport_downtown = {
			award = "axe_22",
			difficulty = sm_wish_and_above,
			job = "arm_hcm"
		},
		sm_wish_transport_harbor = {
			award = "axe_23",
			difficulty = sm_wish_and_above,
			job = "arm_fac"
		},
		sm_wish_transport_park = {
			award = "axe_24",
			difficulty = sm_wish_and_above,
			job = "arm_par"
		},
		sm_wish_transport_underpass = {
			award = "axe_25",
			difficulty = sm_wish_and_above,
			job = "arm_und"
		},
		sm_wish_transport_train = {
			award = "axe_26",
			difficulty = sm_wish_and_above,
			job = "arm_for"
		},
		sm_wish_election_day = {
			award = "axe_27",
			difficulty = sm_wish_and_above,
			job = "election_day"
		},
		sm_wish_kosugi = {
			award = "axe_29",
			difficulty = sm_wish_and_above,
			job = "kosugi"
		},
		sm_wish_bigbank = {
			award = "axe_30",
			difficulty = sm_wish_and_above,
			job = "big"
		},
		sm_wish_miami = {
			award = "axe_31",
			difficulty = sm_wish_and_above,
			job = "mia"
		},
		sm_wish_artgallery = {
			award = "axe_33",
			difficulty = sm_wish_and_above,
			job = "gallery"
		},
		sm_wish_hoxton = {
			award = "axe_34",
			difficulty = sm_wish_and_above,
			job = "hox"
		},
		sm_wish_mus = {
			award = "axe_36",
			difficulty = sm_wish_and_above,
			job = "mus"
		},
		sm_wish_red = {
			award = "axe_37",
			difficulty = sm_wish_and_above,
			job = "red2"
		},
		sm_wish_dinner = {
			award = "axe_38",
			difficulty = sm_wish_and_above,
			job = "dinner"
		},
		sm_wish_hox_3 = {
			award = "axe_39",
			difficulty = sm_wish_and_above,
			job = "hox_3"
		},
		sm_wish_rat = {
			award = "axe_40",
			difficulty = sm_wish_and_above,
			job = "rat"
		},
		sm_wish_cage = {
			award = "axe_41",
			difficulty = sm_wish_and_above,
			job = "cage"
		},
		sm_wish_shoutout = {
			award = "axe_42",
			difficulty = sm_wish_and_above,
			job = "shoutout_raid"
		},
		sm_wish_arena = {
			award = "axe_43",
			difficulty = sm_wish_and_above,
			job = "arena"
		},
		sm_wish_kenaz = {
			award = "axe_44",
			difficulty = sm_wish_and_above,
			jobs = {"kenaz"}
		},
		sm_wish_sinus = {
			award = "axe_45",
			job = "jolly",
			difficulty = sm_wish_and_above
		},
		sm_wish_nails = {
			award = "axe_46",
			job = "nail",
			difficulty = sm_wish_and_above
		},
		sm_wish_berry = {
			award = "axe_47",
			difficulty = sm_wish_and_above,
			job = "pbr"
		},
		sm_wish_jerry = {
			award = "axe_48",
			difficulty = sm_wish_and_above,
			job = "pbr2"
		},
		sm_wish_peta = {
			award = "axe_49",
			difficulty = sm_wish_and_above,
			jobs = {"peta"}
		},
		sm_wish_pal = {
			award = "axe_51",
			difficulty = sm_wish_and_above,
			job = "pal"
		},
		sm_wish_man = {
			award = "axe_52",
			difficulty = sm_wish_and_above,
			job = "man"
		},
		sm_wish_dark = {
			award = "axe_53",
			difficulty = sm_wish_and_above,
			job = "dark"
		},
		sm_wish_cane = {
			award = "axe_54",
			difficulty = sm_wish_and_above,
			job = "cane"
		},
		sm_wish_flat = {
			award = "axe_55",
			difficulty = sm_wish_and_above,
			job = "flat"
		},
		sm_wish_mad = {
			award = "axe_56",
			difficulty = sm_wish_and_above,
			job = "mad"
		},
		sm_wish_born = {
			award = "axe_57",
			difficulty = sm_wish_and_above,
			job = "born"
		},
		sm_wish_help = {
			award = "orange_3",
			difficulty = sm_wish_and_above,
			job = "help"
		},
		sm_wish_moon = {
			award = "moon_3",
			difficulty = sm_wish_and_above,
			job = "moon"
		},
		sm_wish_friend = {
			award = "friend_3",
			difficulty = sm_wish_and_above,
			job = "friend"
		},
		sm_wish_spa = {
			award = "spa_3",
			difficulty = sm_wish_and_above,
			job = "spa"
		},
		sm_wish_fish = {
			award = "fish_3",
			difficulty = sm_wish_and_above,
			job = "fish"
		},
		sm_wish_glace = {
			award = "glace_7",
			difficulty = sm_wish_and_above,
			job = "glace"
		},
		sm_wish_run = {
			award = "run_7",
			difficulty = sm_wish_and_above,
			job = "run"
		},
		complete_pines_sm_wish = {
			award = "axe_59",
			difficulty = sm_wish_and_above,
			jobs = {"pines"}
		},
		complete_crojob_for_sm_wish = {
			award = "axe_60",
			difficulty = sm_wish_and_above,
			jobs = {
				"crojob_wrapper",
				"crojob2",
				"crojob2_night"
			}
		},
		complete_crojob_dock_sm_wish = {
			award = "axe_61",
			difficulty = sm_wish_and_above,
			jobs = {"crojob1"}
		},
		complete_hoxton = {
			award = "bulldog_1",
			jobs = {"hox"}
		},
		complete_pines_normal = {
			award = "deer_1",
			difficulty = normal_and_above,
			jobs = {"pines"}
		},
		complete_pines_hard = {
			award = "deer_2",
			difficulty = hard_and_above,
			jobs = {"pines"}
		},
		complete_pines_veryhard = {
			award = "deer_3",
			difficulty = veryhard_and_above,
			jobs = {"pines"}
		},
		complete_pines_overkill = {
			award = "deer_4",
			difficulty = overkill_and_above,
			jobs = {"pines"}
		},
		complete_crojob_for_all = {
			award = "cow_1",
			difficulty = normal_and_above,
			jobs = {
				"crojob_wrapper",
				"crojob2",
				"crojob2_night"
			}
		},
		complete_crojob_dock_all = {
			award = "cow_6",
			difficulty = normal_and_above,
			jobs = {"crojob1"}
		},
		farm_1 = {
			award = "farm_1",
			phalanx_vip_alive = true,
			difficulty = overkill_and_above,
			job = "dinner"
		},
		hox_3_silent = {
			award = "payback_2",
			stealth = true,
			job = "hox_3"
		},
		owe_saw = {
			award = "ameno_1",
			job = "nightclub",
			equipped_team = {
				primary = "wpn_fps_saw",
				secondary = "wpn_fps_saw_secondary"
			}
		},
		pain_train = {
			award = "ameno_4",
			jobs = {
				"firestarter"
			},
			need_full_job = true,
			num_players = 4,
			difficulty = overkill_and_above,
			loud = true,
			equipped_team = {
				primaries = {
					"wpn_fps_ass_74"
				},
				primary_unmodded = true,
				secondaries = {
					"wpn_fps_smg_olympic"
				},
				secondary_unmodded = true
			}
		},
		turtle_wins = {
			award = "ameno_6",
			job = "gallery",
			stealth = true,
			timer = 240,
			equipped_team = {
				armor = "level_7",
				deployable = "armor_kit",
				reverse_deployable = true
			}
		},
		anticimex = {
			award = "ovk_1",
			jobs = {"alex"},
			need_full_job = true,
			num_players = 4,
			difficulty = overkill_and_above,
			equipped_team = {
				primaries = {
					"wpn_fps_lmg_m134"
				},
				secondaries = {
					"wpn_fps_rpg7"
				},
				mask = "the_overkill_mask",
				armor = "level_6"
			}
		},
		modern_ninja = {
			award = "ovk_2",
			job = "kosugi",
			stealth = true,
			equipped = {
				primaries = {weapon_id = "m134"},
				secondaries = {weapon_id = "rpg7"}
			}
		},
		newbee = {
			award = "ovk_4",
			jobs = {
				"watchdogs_wrapper"
			},
			need_full_job = true,
			difficulty = overkill_and_above,
			equipped_team = {
				num_skills = 0,
				primaries = {
					"wpn_fps_ass_amcar"
				},
				secondaries = {
					"wpn_fps_pis_g17"
				}
			}
		},
		intel_thief = {
			award = "ovk_6",
			levels = {
				"welcome_to_the_jungle_1",
				"welcome_to_the_jungle_1_night"
			},
			difficulty = overkill_and_above,
			stealth = true
		},
		ovk_8 = {
			award = "ovk_8",
			jobs = {
				"welcome_to_the_jungle_wrapper_prof"
			},
			need_full_job = true,
			difficulty = overkill_and_above,
			num_players = 2,
			equipped_team = {
				primaries = {
					"wpn_fps_x_b92fs"
				},
				armor = "level_1"
			}
		},
		kenaz_silent = {
			award = "kenaz_2",
			jobs = {"kenaz"},
			stealth = true
		},
		kenaz_timed = {
			award = "kenaz_4",
			jobs = {"kenaz"},
			timer = 840
		},
		not_for_old_men = {
			award = "gage4_11",
			stealth = true,
			equipped = {
				secondaries = {
					weapon_id = "serbu",
					blueprint = {
						{
							"wpn_fps_upg_ns_shot_thick"
						}
					}
				}
			}
		},
		turtles_3 = {
			award = "turtles_3",
			stealth = true,
			civilians_killed = 0,
			killed_by_weapons = 0,
			killed_by_melee = 0,
			killed_by_grenade = 4,
			equipped = {
				grenades = "wpn_prj_four"
			}
		},
		jordan_3 = {
			award = "brooklyn_3",
			memory = {value = nil, is_shortterm = false}
		},
		jordan_4 = {
			award = "brooklyn_4",
			jump_timer = 4,
			memory = {value = true, is_shortterm = false}
		},
		steel_1 = {
			award = "steel_1",
			need_full_job = true,
			num_players = 4,
			difficulty = overkill_and_above,
			equipped_team = {
				primaries = {
					"wpn_fps_bow_long",
					"wpn_fps_bow_frankish",
					"wpn_fps_bow_arblast"
				},
				masks = {
					"mason_knight_veteran",
					"agatha_knight",
					"agatha_vanguard_veteran",
					"mason_vanguard_veteran"
				},
				armors = {
					"level_3",
					"level_4",
					"level_5",
					"level_6",
					"level_7"
				},
				melee_weapons = {
					"morning",
					"buck",
					"beardy",
					"great"
				}
			}
		},
		green_2 = {
			award = "green_2",
			job = "red2",
			num_players = 4,
			difficulty = overkill_and_above,
			equipped_team = {
				primaries = {
					"wpn_fps_shot_r870"
				},
				secondaries = {
					"wpn_fps_pis_beretta"
				},
				characters = {
					"russian",
					"german",
					"spanish",
					"old_hoxton"
				}
			}
		},
		jerry_5 = {
			award = "jerry_5",
			job = "pbr2",
			difficulty = overkill_and_above,
			equipped_team = {
				primary_category = "akimbo",
				secondary_category = "pistol",
				armor = "level_1"
			}
		},
		cane_4 = {
			award = "cane_4",
			job = "cane",
			equipped_team = {primary_category = "shotgun", secondary_category = "shotgun"}
		},
		mad_3 = {
			award = "mad_3",
			difficulty = veryhard_and_above,
			memory = {value = true, is_shortterm = false},
			job = "mad"
		},
		mad_4 = {
			award = "mad_4",
			difficulty = overkill_and_above,
			job = "mad",
			equipped_team = {
				primaries = {
					"wpn_fps_ass_akm_gold"
				},
				masks = {"rus_hat"}
			}
		},
		flake_1 = {
			award = "flake_1",
			jobs = {
				"framing_frame"
			},
			need_full_job = true,
			difficulty = overkill_and_above,
			equipped_team = {
				num_skills = 0,
				primaries = {
					"wpn_fps_snp_model70"
				},
				secondaries = {
					"wpn_fps_pis_judge"
				},
				armor = "level_1"
			}
		},
		pim_4 = {
			award = "pim_4",
			job = "firestarter",
			need_full_job = true,
			difficulty = overkill_and_above,
			shots_by_weapon = {"packrat", "x_packrat"},
			everyone_killed_by_melee = 0,
			everyone_killed_by_grenade = 0
		},
		orange_6 = {
			award = "orange_6",
			job = "help",
			need_full_job = true,
			difficulty = hard_and_above,
			characters = {"old_hoxton"},
			equipped_team = {
				melee_weapons = {"toothbrush"}
			},
			everyone_killed_by_grenade = 0,
			everyone_killed_by_weapons = 0
		},
		tango_3 = {
			award = "tango_achieve_3",
			difficulty = veryhard_and_above,
			killed_by_blueprint = {
				blueprint = "wpn_fps_upg_o_spot",
				amount = 200
			}
		},
		spa_4 = {
			award = "spa_4",
			job = "spa",
			difficulty = overkill_and_above,
			need_full_job = true,
			equipped_team = {
				primary_category = "snp",
				secondaries = {
					"wpn_fps_saw_secondary"
				}
			}
		},
		fish_4 = {
			award = "fish_4",
			job = "fish",
			timer = 360,
			difficulty = overkill_and_above
		},
		fish_5 = {
			award = "fish_5",
			job = "fish",
			everyone_killed_by_weapons = 0,
			everyone_killed_by_melee = 0,
			everyone_killed_by_grenade = 0
		},
		grv_1 = {
			award = "grv_1",
			difficulty = overkill_and_above,
			equipped_outfit = {
				primaries = {
					"wpn_fps_snp_siltstone",
					"wpn_fps_ass_flint"
				},
				secondary = "wpn_fps_smg_coal",
				melee_weapon = "oxide"
			}
		},
		grv_4 = {
			award = "grv_4",
			stealth = true,
			equipped_outfit = {
				primaries = {
					"wpn_fps_snp_siltstone",
					"wpn_fps_ass_flint"
				},
				secondary = "wpn_fps_smg_coal",
				melee_weapon = "oxide"
			}
		},
		glace_1 = {
			award = "glace_1",
			difficulty = normal_and_above,
			job = "glace"
		},
		glace_2 = {
			award = "glace_2",
			difficulty = hard_and_above,
			job = "glace"
		},
		glace_3 = {
			award = "glace_3",
			difficulty = veryhard_and_above,
			job = "glace"
		},
		glace_4 = {
			award = "glace_4",
			difficulty = overkill_and_above,
			job = "glace"
		},
		run_1 = {
			award = "run_1",
			difficulty = normal_and_above,
			job = "run"
		},
		run_2 = {
			award = "run_2",
			difficulty = hard_and_above,
			job = "run"
		},
		run_3 = {
			award = "run_3",
			difficulty = veryhard_and_above,
			job = "run"
		},
		run_4 = {
			award = "run_4",
			difficulty = overkill_and_above,
			job = "run"
		},
		bain_jobs = {
			challenge_stat = "bain_jobs",
			complete_job = true,
			contract = "bain"
		},
		vlad_jobs = {
			challenge_stat = "vlad_jobs",
			complete_job = true,
			contract = "vlad"
		},
		hector_jobs = {
			challenge_stat = "hector_jobs",
			complete_job = true,
			contract = "hector"
		},
		elephant_jobs = {
			challenge_stat = "elephant_jobs",
			complete_job = true,
			contract = "the_elephant"
		},
		dentist_jobs = {
			challenge_stat = "dentist_jobs",
			complete_job = true,
			contract = "the_dentist"
		},
		butcher_jobs = {
			challenge_stat = "butcher_jobs",
			complete_job = true,
			contract = "the_butcher"
		},
		any_jobs = {challenge_stat = "any_jobs", complete_job = true},
		monthly_rats = {
			challenge_award = "monthly_rats",
			jobs = {"alex"},
			need_full_job = true,
			difficulty = overkill_and_above,
			equipped_team = {
				num_skills = 0,
				primaries = {
					"wpn_fps_ass_amcar"
				},
				secondaries = {
					"wpn_fps_pis_g17"
				},
				armor = "level_1"
			}
		},
		monthly_firestarter = {
			challenge_award = "monthly_firestarter",
			jobs = {
				"firestarter"
			},
			need_full_job = true,
			difficulty = overkill_and_above,
			equipped_team = {
				num_skills = 0,
				primaries = {
					"wpn_fps_ass_amcar"
				},
				secondaries = {
					"wpn_fps_pis_g17"
				},
				armor = "level_1"
			}
		},
		monthly_shadowraid = {
			challenge_award = "monthly_shadowraid",
			job = "kosugi",
			need_full_job = true,
			difficulty = overkill_and_above,
			equipped_team = {
				num_skills = 0,
				primaries = {
					"wpn_fps_ass_amcar"
				},
				secondaries = {
					"wpn_fps_pis_g17"
				},
				armor = "level_1"
			}
		},
		trophy_transport_crossroads = {
			trophy_stat = "trophy_transport_crossroads",
			difficulty = overkill_and_above,
			job = "arm_cro"
		},
		trophy_transport_downtown = {
			trophy_stat = "trophy_transport_downtown",
			difficulty = overkill_and_above,
			job = "arm_hcm"
		},
		trophy_transport_harbor = {
			trophy_stat = "trophy_transport_harbor",
			difficulty = overkill_and_above,
			job = "arm_fac"
		},
		trophy_transport_park = {
			trophy_stat = "trophy_transport_park",
			difficulty = overkill_and_above,
			job = "arm_par"
		},
		trophy_transport_underpass = {
			trophy_stat = "trophy_transport_underpass",
			difficulty = overkill_and_above,
			job = "arm_und"
		},
		trophy_transport_train = {
			trophy_stat = "trophy_transport_train",
			difficulty = overkill_and_above,
			job = "arm_for"
		},
		trophy_escapes = {
			trophy_stat = "trophy_escapes",
			levels = {
				"escape_cafe",
				"escape_cafe_day",
				"escape_park",
				"escape_park_day",
				"escape_street",
				"escape_overpass",
				"escape_garage"
			}
		},
		trophy_basics_stealth = {
			trophy_stat = "trophy_basics_stealth",
			job = "short1"
		},
		trophy_basics_loud = {
			trophy_stat = "trophy_basics_loud",
			job = "short2"
		},
		trophy_car_shop = {
			trophy_stat = "trophy_car_shop",
			job = "cage"
		},
		trophy_golden_grin = {
			trophy_stat = "trophy_golden_grin",
			difficulty = deathwish_and_above,
			jobs = {"kenaz"},
			used_weapon_category = "pistol",
			equipped = {
				secondaries = {
					category = "pistol",
					blueprint_part_data = {sub_type = "silencer"}
				}
			}
		},
		trophy_nightclub_dw = {
			trophy_stat = "trophy_nightclub_dw",
			difficulty = deathwish_and_above,
			job = "nightclub",
			stealth = true
		},
		trophy_tiara = {
			trophy_stat = "trophy_tiara",
			difficulty = deathwish_and_above,
			job = "ukrainian_job_prof",
			equipped_team = {deployable = "ecm_jammer", reverse_deployable = true}
		},
		trophy_train_bomb = {
			trophy_stat = "trophy_train_bomb",
			difficulty = deathwish_and_above,
			jobs = {
				"crojob_wrapper",
				"crojob2",
				"crojob2_night"
			}
		},
		trophy_shoutout = {
			trophy_stat = "trophy_shoutout",
			difficulty = overkill_and_above,
			job = "shoutout_raid",
			timer = 420
		},
		trophy_stealth = {
			trophy_stat = "trophy_stealth",
			difficulty = overkill_and_above,
			stealth = true,
			jobs = {
				"gallery",
				"nightclub",
				"ukrainian_job_prof",
				"four_stores",
				"jewelry_store",
				"family",
				"roberts",
				"branchbank_prof",
				"branchbank_gold_prof",
				"branchbank_cash",
				"branchbank_deposit",
				"arm_for",
				"election_day",
				"kosugi",
				"big",
				"hox_3",
				"arena",
				"red2",
				"crojob1",
				"firestarter",
				"kenaz",
				"mus",
				"framing_frame",
				"dark",
				"friend",
				"fish"
			}
		},
		trophy_bank_heists = {
			trophy_stat = "trophy_bank_heists",
			difficulty = overkill_and_above,
			jobs = {
				"branchbank_prof",
				"branchbank_gold_prof",
				"branchbank_cash",
				"branchbank_deposit"
			}
		},
		trophy_carshop_stealth = {
			trophy_stat = "trophy_carshop_stealth",
			job = "cage",
			equipped_team = {
				detection = {min = 70, max = 100},
				deployable = "ecm_jammer",
				reverse_deployable = true
			}
		},
		trophy_watchout = {
			trophy_stat = "trophy_watchout",
			total_accuracy = 100,
			jobs = {
				"watchdogs_wrapper",
				"watchdogs_night",
				"watchdogs"
			},
			need_full_job = true,
			used_weapon_category = "snp",
			equipped = {
				primaries = {category = "snp"}
			}
		},
		trophy_piggy_bank = {
			trophy_stat = "trophy_piggy_bank",
			job = "big",
			difficulty = overkill_and_above,
			equipped_team = {num_skills = 0}
		},
		trophy_jfk = {
			trophy_stat = "trophy_jfk",
			job = "man",
			difficulty = overkill_and_above,
			everyone_used_weapon_category = "snp",
			everyone_killed_by_melee = 0,
			everyone_killed_by_grenade = 0,
			equipped_team = {
				num_skills = 0,
				primary_category = "snp",
				armor = "level_1"
			}
		},
		trophy_dance = {
			trophy_stat = "trophy_dance",
			job = "nightclub",
			killed_by_weapons = 0,
			killed_by_melee = 0,
			killed_by_grenade = 0,
			equipped_team = {deployable = "trip_mine"}
		},
		trophy_fbi = {
			trophy_stat = "trophy_fbi",
			levels = {
				"firestarter_2"
			},
			stealth = true
		},
		trophy_host = {
			trophy_stat = "trophy_host",
			need_full_job = true,
			is_host = true
		},
		trophy_framing_frame = {
			trophy_stat = "trophy_framing_frame",
			difficulty = overkill_and_above,
			jobs = {
				"framing_frame"
			},
			need_full_job = true,
			need_full_stealth = true
		},
		trophy_courtesy = {
			trophy_stat = "trophy_courtesy",
			difficulty = easywish_and_above,
			job = "pbr",
			complete_job = true,
			killed = {medic = 0}
		},
		trophy_evolution = {
			trophy_stat = "trophy_evolution",
			complete_job = true,
			mutators = true
		},
		trophy_flawless = {
			trophy_stat = "trophy_flawless",
			difficulty = deathwish_and_above,
			complete_job = true,
			mutators = {
				"MutatorFriendlyFire"
			},
			memory = {value = nil, is_shortterm = false},
			num_players = 4
		},
		trophy_defender = {
			trophy_stat = "trophy_defender",
			complete_job = true,
			difficulty = overkill_and_above,
			jobs = {
				"chill_combat"
			}
		},
		trophy_friendly_car = {
			trophy_stat = "trophy_friendly_car",
			complete_job = true,
			difficulty = easywish_and_above,
			job = "friend",
			stealth = false,
			equipped_team = {num_skills = 0, perk_deck = 14},
			num_players = 4
		},
		trophy_fish_trophy = {
			trophy_stat = "trophy_fish_trophy",
			job = "fish",
			need_full_job = true,
			equipped_team = {
				detection = {min = 75, max = 100}
			}
		},
		trophy_glace_completion = {
			trophy_stat = "trophy_glace_completion",
			difficulty = normal_and_above,
			job = "glace"
		},
		daily_classics = {
			trophy_stat = "daily_classics",
			jobs = {
				"red2",
				"flat",
				"dinner",
				"pal",
				"man",
				"run",
				"glace"
			}
		},
		daily_discord = {
			trophy_stat = "daily_discord",
			converted_cops = 1
		},
		daily_fwtd = {
			trophy_stat = "daily_fwtd",
			difficulty = overkill_and_above,
			everyone_weapons_used = {
				"sentry_gun",
				"swat_van_turret_module"
			},
			everyone_killed_by_melee = 0,
			everyone_killed_by_grenade = 0,
			job = "red2"
		},
		daily_gears = {
			trophy_stat = "daily_gears",
			difficulty = overkill_and_above,
			jobs = {
				"arm_cro",
				"arm_und",
				"arm_hcm",
				"arm_fac",
				"arm_par",
				"arm_for"
			},
			equipped_team = {
				primaries = {
					"wpn_fps_saw"
				},
				secondaries = {
					"wpn_fps_saw_secondary"
				}
			},
			memory = {value = nil, is_shortterm = true}
		},
		daily_spacetime = {
			trophy_stat = "daily_spacetime",
			jobs = {"hox"},
			need_full_job = true,
			characters = {"old_hoxton"}
		},
		daily_night_out = {
			trophy_stat = "daily_night_out",
			everyone_killed_by_weapons = 0,
			job = "nightclub"
		},
		daily_naked = {
			trophy_stat = "daily_naked",
			difficulty = overkill_and_above,
			jobs = {"pbr", "pbr2"},
			equipped_team = {
				armor = "level_1",
				num_skills = 0,
				perk_deck = 3
			}
		},
		daily_ninja = {
			trophy_stat = "daily_ninja",
			killed_by_weapons = 0,
			job = "arm_cro",
			equipped_outfit = {
				grenade = {
					"wpn_prj_ace",
					"wpn_prj_four",
					"wpn_prj_jav",
					"wpn_prj_hur",
					"wpn_prj_target",
					"chico_injector",
					"smoke_screen_grenade"
				}
			}
		},
		daily_whats_stealth = {
			trophy_stat = "daily_whats_stealth",
			job = "kosugi",
			difficulty = deathwish_and_above,
			equipped_team = {armor = "level_7"},
			need_full_job = true,
			memory = {value = nil, is_shortterm = true}
		},
		daily_akimbo = {
			trophy_stat = "daily_akimbo",
			total_accuracy = 80,
			equipped_outfit = {primary_category = "akimbo"},
			equipped = {
				secondaries = {
					category = "pistol",
					blueprint_part_data = {sub_type = "silencer"}
				}
			}
		}
	}
	self.check_equipment_memory_on_leave = {
		self.complete_heist_achievements.daily_whats_stealth,
		self.complete_heist_achievements.daily_gears
	}
	self.complete_heist_statistics_achievements = {
		immortal_ballot = {
			award = "ovk_5",
			num_players = 4,
			total_downs = 0,
			levels = {
				"election_day_3",
				"election_day_3_skip1",
				"election_day_3_skip2"
			},
			difficulty = deathwish_and_above
		},
		full_two_twenty = {
			award = "ovk_7",
			total_kills = 120,
			total_accuracy = 120,
			num_players = 4
		},
		berry_4 = {
			award = "berry_4",
			total_downs = 0,
			difficulty = overkill_and_above,
			level_id = "pbr",
			is_dropin = false
		},
		flat_5 = {
			award = "flat_5",
			total_accuracy = 200,
			level_id = "flat",
			success = true
		},
		daily_professional = {
			trophy_stat = "daily_professional",
			difficulty = overkill_and_above,
			total_headshots = {amount = 0, invert = true}
		}
	}
	self.loot_cash_achievements = {
		mallrunner = {
			award = "ameno_3",
			total_value = 1800000,
			jobs = {
				"mallcrasher"
			},
			difficulties = {
				"overkill_145"
			},
			total_time = 50
		},
		cane_5 = {
			award = "cane_5",
			job = "cane",
			secured = {carry_id = "present", total_amount = 10},
			no_assets = true,
			no_deployable = true
		},
		pal_2 = {
			award = "pal_2",
			job = "pal",
			secured = {
				carry_id = "counterfeit_money",
				value = 1000000
			}
		},
		trophy_tfturret = {
			trophy_stat = "trophy_tfturret",
			jobs = {"arm_for"},
			difficulties = overkill_and_above,
			secured = {
				{carry_id = "ammo", total_amount = 20},
				{carry_id = "turret", total_amount = 3}
			},
			is_dropin = false
		},
		daily_mortage = {
			trophy_stat = "daily_mortage",
			jobs = {"family"},
			secured = {carry_id = "diamonds", total_amount = 16},
			is_dropin = false
		},
		daily_toast = {
			trophy_stat = "daily_toast",
			jobs = {"pines"},
			secured = {carry_id = "sandwich", amount = 1},
			is_dropin = false
		},
		daily_lodsofemone = {
			trophy_stat = "daily_lodsofemone",
			secured = {carry_id = "money", amount = 1}
		},
		daily_heirloom = {
			trophy_stat = "daily_heirloom",
			jobs = {"kosugi"},
			secured = {
				carry_id = "samurai_suit",
				total_amount = 4
			},
			is_dropin = false
		},
		daily_candy = {
			trophy_stat = "daily_candy",
			secured = {
				{
					carry_id = {
						"coke",
						"coke_light",
						"coke_pure",
						"present",
						"yayo"
					},
					amount = 1
				}
			}
		},
		daily_art = {
			trophy_stat = "daily_art",
			jobs = {"gallery"},
			secured = {carry_id = "painting", total_amount = 9},
			is_dropin = false
		},
		trophy_coke = {
			trophy_stat = "trophy_coke",
			jobs = {"friend"},
			secured = {
				{
					carry_id = {"yayo"},
					amount = 1
				}
			}
		}
	}
	self.job_list = {}
	self.job_list.vlad = {
		"ukrainian_job_prof",
		"mallcrasher",
		"four_stores",
		"nightclub",
		"pines",
		"shoutout_raid",
		"jolly",
		"cane",
		"peta",
		"moon"
	}
	self.job_list.hector = {
		"watchdogs_wrapper",
		"alex",
		"firestarter"
	}
	self.job_list.the_elephant = {
		"framing_frame",
		"welcome_to_the_jungle_wrapper_prof",
		"election_day",
		"born"
	}
	self.job_list.bain = {
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
		"arm_for",
		"kosugi",
		"gallery",
		"rat",
		"cage",
		"arena"
	}
	self.job_list.the_dentist = {
		"big",
		"mia",
		"hox",
		"mus",
		"hox_3",
		"kenaz"
	}
	self.job_list.the_butcher = {
		"crojob_wrapper",
		"crojob1",
		"friend"
	}
	self.job_list.classic = {
		"red2",
		"dinner",
		"pal",
		"man",
		"flat",
		"run",
		"glace"
	}
	self.job_list.locke = {"pbr", "pbr2"}
	self.job_list.jimmy = {"mad", "dark"}
	self.job_list.events = {"nail", "help"}
	self.job_list.the_continental = {"spa", "fish"}
	local jobs = {}
	local job_data
	local available_jobs = {}
	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		if tweak_data.narrative:job_data(job_id).contact ~= "wip" and tweak_data.narrative:job_data(job_id).contact ~= "tests" then
			jobs[job_id] = true
			available_jobs[job_id] = tweak_data.narrative:job_data(job_id).contact
		end
	end
	for _, list in pairs(self.job_list) do
		for _, job_id in pairs(list) do
			if tweak_data.narrative:has_job_wrapper(job_id) then
				available_jobs[job_id] = nil
				for _, job_id in ipairs(tweak_data.narrative:job_data(job_id).job_wrapper) do
					available_jobs[job_id] = nil
				end
			elseif jobs[job_id] then
				available_jobs[job_id] = nil
			else
				Application:debug("[TWEAKDATA:ACHIEVEMENTS] Job missing in narrative", job_id)
			end
		end
	end
	if table.size(available_jobs) > 0 then
		Application:debug("[TWEAKDATA:ACHIEVEMENTS] Jobs not yet in achievement 'job_list':", inspect(available_jobs))
	end
	self.complete_heist_stats_achievements = {
		easywish_vlad = {
			award = "pick_62",
			difficulty = easywish_and_above,
			contact = "vlad"
		},
		easywish_hector = {
			award = "pick_63",
			difficulty = easywish_and_above,
			contact = "hector"
		},
		easywish_elephant = {
			award = "pick_64",
			difficulty = easywish_and_above,
			contact = "the_elephant"
		},
		easywish_bain = {
			award = "pick_65",
			difficulty = easywish_and_above,
			contact = "bain"
		},
		death_vlad = {
			award = "death_5",
			difficulty = deathwish_and_above,
			contact = "vlad"
		},
		death_hector = {
			award = "death_9",
			difficulty = deathwish_and_above,
			contact = "hector"
		},
		death_elephant = {
			award = "death_12",
			difficulty = deathwish_and_above,
			contact = "the_elephant"
		},
		death_bain = {
			award = "death_26",
			difficulty = deathwish_and_above,
			contact = "bain"
		},
		sm_vlad = {
			award = "axe_62",
			difficulty = sm_wish_and_above,
			contact = "vlad"
		},
		sm_hector = {
			award = "axe_63",
			difficulty = sm_wish_and_above,
			contact = "hector"
		},
		sm_elephant = {
			award = "axe_64",
			difficulty = sm_wish_and_above,
			contact = "the_elephant"
		},
		sm_bain = {
			award = "axe_65",
			difficulty = sm_wish_and_above,
			contact = "bain"
		},
		skull_hard = {
			award = "death_27",
			difficulty = hard_and_above,
			contact = "all"
		},
		skull_very_hard = {
			award = "death_28",
			difficulty = veryhard_and_above,
			contact = "all"
		},
		skull_overkill = {
			award = "death_29",
			difficulty = overkill_and_above,
			contact = "all"
		},
		skull_easywish = {
			award = "pick_66",
			difficulty = easywish_and_above,
			contact = "all"
		},
		skull_deathwish = {
			award = "death_30",
			difficulty = deathwish_and_above,
			contact = "all"
		},
		skull_smwish = {
			award = "axe_66",
			difficulty = sm_wish_and_above,
			contact = "all"
		},
		trophy_smwish = {
			trophy_stat = "trophy_smwish",
			difficulty = sm_wish_and_above,
			contact = "all"
		}
	}
	self.four_mask_achievements = {
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
				"skulloverkillplus",
				"gitgud_e_wish",
				"gitgud_sm_wish"
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
		},
		go_bananas = {
			award = "gage4_12",
			jobs = {"alex"},
			difficulties = overkill_and_above,
			masks = {
				"silverback",
				"mandril",
				"skullmonkey",
				"orangutang"
			}
		},
		animal_fight = {
			award = "pig_5",
			jobs = {"mia"},
			difficulties = hard_and_above,
			masks = {
				"white_wolf",
				"owl",
				"rabbit",
				"pig"
			}
		},
		guy_with_gun_now_with_night_jobs = {
			award = "gage5_6",
			jobs = {
				"watchdogs_wrapper",
				"watchdogs",
				"watchdogs_night"
			},
			difficulties = overkill_and_above,
			masks = {
				"galax",
				"crowgoblin",
				"evil",
				"volt"
			}
		},
		wind_of_change = {
			award = "eagle_3",
			jobs = {"hox"},
			difficulties = overkill_and_above,
			masks = {
				"churchill",
				"red_hurricane",
				"patton",
				"de_gaulle"
			}
		},
		xmas_2014 = {
			award = "deer_6",
			jobs = {"pines"},
			difficulties = deathwish_and_above,
			masks = {
				"krampus",
				"mrs_claus",
				"strinch",
				"robo_santa"
			}
		},
		blight = {
			award = "bat_5",
			jobs = {"mus"},
			difficulties = overkill_and_above,
			masks = {
				"medusa",
				"anubis",
				"pazuzu",
				"cursed_crown"
			}
		}
	}
	self.sniper_kill_achievements = {
		did_i_do_that = {
			award = "gage3_9",
			multi_kill = 3,
			weapon_type = "snp"
		},
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
	self.inventory = {}
	self.crime_spree = {
		{level = 50, id = "cee_1"},
		{level = 100, id = "cee_2"},
		{level = 250, id = "cee_3"}
	}
	local gage_5_1_achievement = {
		text_id = "bm_wp_gage5_1_achievment",
		stat = "gage5_1_stats",
		max_progress = 25
	}
	local gage_5_2_achievement = {
		text_id = "bm_wp_gage5_2_achievment",
		award = "gage5_2"
	}
	local gage_5_3_achievement = {
		text_id = "bm_wp_gage5_3_achievment",
		award = "gage5_3"
	}
	local gage_5_4_achievement = {
		text_id = "bm_wp_gage5_4_achievment",
		award = "gage5_4"
	}
	local gage_5_5_achievement = {
		text_id = "bm_wp_gage5_5_achievment",
		stat = "gage5_5_stats",
		max_progress = 25
	}
	local gage_5_6_achievement = {
		text_id = "bm_wp_gage5_6_achievment",
		award = "gage5_6"
	}
	local gage_5_7_achievement = {
		text_id = "bm_wp_gage5_7_achievment",
		award = "gage5_7"
	}
	local gage_5_9_achievement = {
		text_id = "bm_wp_gage5_9_achievment",
		stat = "gage5_9_stats",
		max_progress = 10
	}
	local gage_5_10_achievement = {
		text_id = "bm_wp_gage5_10_achievment",
		stat = "gage5_10_stats",
		max_progress = 200
	}
	local pig_1_achievement = {
		text_id = "bm_wp_pig_1_achievment",
		award = "pig_1"
	}
	local pig_2_achievement = {
		text_id = "bm_wp_pig_2_achievment",
		award = "pig_2"
	}
	local pig_3_achievement = {
		text_id = "bm_wp_pig_3_achievment",
		stat = "pig_3_stats",
		max_progress = 25
	}
	local pig_4_achievement = {
		text_id = "bm_wp_pig_4_achievment",
		award = "pig_4"
	}
	local pig_5_achievement = {
		text_id = "bm_wp_pig_5_achievment",
		award = "pig_5"
	}
	local eagle_1_achievement = {
		text_id = "bm_wp_eagle_1_achievment",
		stat = "eagle_1_stats",
		max_progress = 25
	}
	local eagle_2_achievement = {
		text_id = "bm_wp_eagle_2_achievment",
		stat = "eagle_2_stats",
		max_progress = 25
	}
	local eagle_3_achievement = {
		text_id = "bm_wp_eagle_3_achievment",
		award = "eagle_3"
	}
	local eagle_4_achievement = {
		text_id = "bm_wp_eagle_4_achievment",
		award = "eagle_4"
	}
	local eagle_5_achievement = {
		text_id = "bm_wp_eagle_5_achievment",
		award = "eagle_5"
	}
	local ameno_1_achievement = {
		text_id = "bm_wp_ameno_1_achievment",
		award = "ameno_1"
	}
	local ameno_2_achievement = {
		text_id = "bm_wp_ameno_2_achievment",
		award = "ameno_2"
	}
	local ameno_3_achievement = {
		text_id = "bm_wp_ameno_3_achievment",
		award = "ameno_3"
	}
	local ameno_4_achievement = {
		text_id = "bm_wp_ameno_4_achievment",
		award = "ameno_4"
	}
	local ameno_5_achievement = {
		text_id = "bm_wp_ameno_5_achievment",
		award = "ameno_5"
	}
	local ameno_6_achievement = {
		text_id = "bm_wp_ameno_6_achievment",
		award = "ameno_6"
	}
	local ameno_7_achievement = {
		text_id = "bm_wp_ameno_7_achievment",
		award = "ameno_7"
	}
	local ameno_8_achievement = {
		text_id = "bm_wp_ameno_8_achievment",
		stat = "ameno_08_stats",
		max_progress = 100
	}
	self.mask_tracker = {}
	self.weapon_part_tracker = {
		wpn_fps_snp_m95_barrel_long = {
			text_id = "bm_wp_m95_b_barrel_long_achievment",
			stat = "gage3_7_stats",
			max_progress = 25
		},
		wpn_fps_snp_r93_b_suppressed = {
			text_id = "bm_wp_r93_b_suppressed_achievment",
			award = "gage3_8"
		},
		wpn_fps_upg_o_45iron = {
			text_id = "bm_wp_upg_o_45iron_achievment",
			award = "gage3_9"
		},
		wpn_fps_snp_r93_b_short = {
			text_id = "bm_wp_r93_b_short_achievment",
			stat = "gage3_10_stats",
			max_progress = 10
		},
		wpn_fps_snp_m95_barrel_suppressed = {
			text_id = "bm_wp_m95_b_barrel_suppressed_achievment",
			stat = "gage3_11_stats",
			max_progress = 10
		},
		wpn_fps_snp_m95_barrel_short = {
			text_id = "bm_wp_m95_b_barrel_short_achievment",
			award = "gage3_12_stats",
			max_progress = 10
		},
		wpn_fps_upg_o_leupold = {
			text_id = "bm_wp_upg_o_leupold_achievment",
			stat = "gage3_13_stats",
			max_progress = 10
		},
		wpn_fps_snp_msr_body_msr = {
			text_id = "bm_wp_msr_body_msr_achievment",
			stat = "gage3_14_stats",
			max_progress = 25
		},
		wpn_fps_snp_r93_body_wood = {
			text_id = "bm_wp_r93_body_wood_achievment",
			stat = "gage3_15_stats",
			max_progress = 25
		},
		wpn_fps_snp_msr_ns_suppressor = {
			text_id = "bm_wp_snp_msr_ns_suppressor_achievment",
			stat = "gage3_16_stats",
			max_progress = 25
		},
		wpn_fps_snp_msr_b_long = {
			text_id = "bm_wp_snp_msr_b_long_achievment",
			stat = "gage3_17_stats",
			max_progress = 250
		},
		wpn_fps_ass_fal_fg_01 = {
			text_id = "bm_wp_fal_fg_01_achievment",
			award = "bigbank_7"
		},
		wpn_fps_ass_fal_fg_03 = {
			text_id = "bm_wp_fal_fg_03_achievment",
			award = "bigbank_8"
		},
		wpn_fps_ass_fal_fg_04 = {
			text_id = "bm_wp_fal_fg_04_achievment",
			award = "bigbank_3"
		},
		wpn_fps_ass_fal_fg_wood = {
			text_id = "bm_wp_fal_fg_wood_achievment",
			award = "bigbank_4"
		},
		wpn_fps_ass_fal_s_01 = {
			text_id = "bm_wp_fal_s_01_achievment",
			award = "bigbank_5"
		},
		wpn_fps_ass_fal_s_03 = {
			text_id = "bm_wp_fal_s_03_achievment",
			award = "bigbank_10"
		},
		wpn_fps_ass_fal_s_wood = {
			text_id = "bm_wp_fal_s_wood_achievment",
			award = "bigbank_6"
		},
		wpn_fps_ass_fal_g_01 = {
			text_id = "bm_wp_fal_g_01_achievment",
			award = "bigbank_1"
		},
		wpn_fps_ass_fal_m_01 = {
			text_id = "bm_wp_fal_m_01_achievment",
			award = "bigbank_2"
		},
		wpn_fps_upg_o_mbus_rear = {
			text_id = "bm_wp_upg_o_mbus_rear_achievment",
			award = "gage4_2"
		},
		wpn_fps_sho_ben_b_short = {
			text_id = "bm_wp_ben_b_short_achievment",
			award = "gage4_4"
		},
		wpn_fps_sho_ben_b_long = {
			text_id = "bm_wp_ben_b_long_achievment",
			award = "gage4_5"
		},
		wpn_fps_sho_ben_s_collapsed = {
			text_id = "bm_wp_ben_s_collapsed_achievment",
			stat = "gage4_6",
			max_progress = 50
		},
		wpn_fps_sho_ksg_b_short = {
			text_id = "bm_wp_ksg_b_short_achievment",
			stat = "gage4_7",
			max_progress = 25
		},
		wpn_fps_sho_ksg_b_long = {
			text_id = "bm_wp_ksg_b_long_achievment",
			stat = "gage4_8",
			max_progress = 10
		},
		wpn_fps_sho_ben_s_solid = {
			text_id = "bm_wp_ben_s_solid_achievment",
			award = "gage4_9"
		},
		wpn_fps_sho_striker_b_long = {
			text_id = "bm_wp_striker_b_long_achievment",
			stat = "gage4_10_stats",
			max_progress = 10
		},
		wpn_fps_sho_striker_b_suppressed = {
			text_id = "bm_wp_striker_b_suppressed_achievment",
			award = "gage4_11"
		},
		wpn_fps_gre_m79_barrel_short = gage_5_5_achievement,
		wpn_fps_gre_m79_stock_short = gage_5_2_achievement,
		wpn_fps_ass_g3_b_sniper = gage_5_1_achievement,
		wpn_fps_ass_g3_fg_psg = gage_5_1_achievement,
		wpn_fps_ass_g3_g_sniper = gage_5_1_achievement,
		wpn_fps_ass_g3_s_sniper = gage_5_1_achievement,
		wpn_fps_ass_g3_b_short = gage_5_4_achievement,
		wpn_fps_ass_g3_fg_retro_plastic = gage_5_4_achievement,
		wpn_fps_ass_g3_fg_railed = gage_5_6_achievement,
		wpn_fps_ass_g3_fg_retro = gage_5_7_achievement,
		wpn_fps_ass_g3_g_retro = gage_5_7_achievement,
		wpn_fps_ass_g3_s_wood = gage_5_7_achievement,
		wpn_fps_ass_galil_s_sniper = gage_5_1_achievement,
		wpn_fps_ass_galil_fg_sniper = gage_5_1_achievement,
		wpn_fps_ass_galil_g_sniper = gage_5_1_achievement,
		wpn_fps_ass_galil_fg_sar = gage_5_6_achievement,
		wpn_fps_ass_galil_fg_mar = gage_5_3_achievement,
		wpn_fps_ass_galil_s_plastic = gage_5_3_achievement,
		wpn_fps_ass_galil_s_light = gage_5_4_achievement,
		wpn_fps_ass_galil_s_wood = gage_5_5_achievement,
		wpn_fps_ass_galil_fg_fab = gage_5_9_achievement,
		wpn_fps_ass_galil_s_fab = gage_5_9_achievement,
		wpn_fps_ass_galil_s_skeletal = gage_5_9_achievement,
		wpn_fps_ass_famas_b_sniper = gage_5_1_achievement,
		wpn_fps_ass_famas_b_short = gage_5_4_achievement,
		wpn_fps_ass_famas_b_long = gage_5_6_achievement,
		wpn_fps_ass_famas_g_retro = gage_5_10_achievement,
		wpn_fps_ass_famas_b_suppressed = gage_5_10_achievement,
		wpn_fps_smg_scorpion_g_ergo = pig_1_achievement,
		wpn_fps_smg_scorpion_m_extended = pig_1_achievement,
		wpn_fps_smg_scorpion_s_unfolded = pig_1_achievement,
		wpn_fps_smg_uzi_fg_rail = pig_2_achievement,
		wpn_fps_smg_uzi_s_leather = pig_2_achievement,
		wpn_fps_smg_uzi_s_solid = pig_3_achievement,
		wpn_fps_smg_scorpion_g_wood = pig_3_achievement,
		wpn_fps_smg_tec9_ns_ext = pig_4_achievement,
		wpn_fps_smg_tec9_m_extended = pig_4_achievement,
		wpn_fps_smg_tec9_s_unfolded = pig_4_achievement,
		wpn_fps_smg_uzi_b_suppressed = pig_5_achievement,
		wpn_fps_smg_uzi_s_standard = pig_5_achievement,
		wpn_fps_smg_scorpion_b_suppressed = pig_5_achievement,
		wpn_fps_smg_scorpion_s_nostock = pig_5_achievement,
		wpn_fps_smg_tec9_b_standard = pig_5_achievement,
		wpn_fps_snp_mosin_b_sniper = eagle_1_achievement,
		wpn_fps_snp_mosin_b_standard = eagle_1_achievement,
		wpn_fps_smg_sterling_b_e11 = eagle_2_achievement,
		wpn_fps_pis_c96_nozzle = eagle_2_achievement,
		wpn_fps_pis_c96_sight = eagle_2_achievement,
		wpn_fps_smg_sterling_b_short = eagle_2_achievement,
		wpn_fps_smg_sterling_b_suppressed = eagle_2_achievement,
		wpn_fps_smg_sterling_m_short = eagle_2_achievement,
		wpn_fps_smg_sterling_s_folded = eagle_2_achievement,
		wpn_fps_smg_sterling_s_nostock = eagle_2_achievement,
		wpn_fps_smg_sterling_s_solid = eagle_2_achievement,
		wpn_fps_snp_mosin_body_black = eagle_3_achievement,
		wpn_fps_pis_c96_b_long = eagle_3_achievement,
		wpn_fps_snp_mosin_b_short = eagle_3_achievement,
		wpn_fps_smg_sterling_m_long = eagle_3_achievement,
		wpn_fps_smg_sterling_b_long = eagle_3_achievement,
		wpn_fps_lmg_mg42_b_vg38 = eagle_3_achievement,
		wpn_fps_pis_c96_m_extended = eagle_4_achievement,
		wpn_fps_pis_c96_s_solid = eagle_4_achievement,
		wpn_fps_lmg_mg42_b_mg34 = eagle_5_achievement,
		wpn_fps_upg_ass_m4_upper_reciever_core = ameno_1_achievement,
		wpn_fps_upg_ass_m4_lower_reciever_core = ameno_1_achievement,
		wpn_fps_upg_ass_m16_fg_stag = ameno_1_achievement,
		wpn_fps_upg_ak_g_rk3 = ameno_2_achievement,
		wpn_fps_upg_ak_fg_zenit = ameno_2_achievement,
		wpn_fps_upg_ass_m4_upper_reciever_ballos = ameno_2_achievement,
		wpn_fps_upg_o_ak_scopemount = ameno_3_achievement,
		wpn_fps_upg_ns_ass_pbs1 = ameno_3_achievement,
		wpn_fps_upg_ass_ak_b_zastava = ameno_4_achievement,
		wpn_fps_upg_ak_m_uspalm = ameno_4_achievement,
		wpn_fps_upg_ass_m4_fg_moe = ameno_5_achievement,
		wpn_fps_upg_smg_olympic_fg_lr300 = ameno_5_achievement,
		wpn_fps_upg_ass_m4_fg_lvoa = ameno_5_achievement,
		wpn_fps_upg_ak_s_solidstock = ameno_6_achievement,
		wpn_fps_upg_m4_s_ubr = ameno_6_achievement,
		wpn_fps_upg_ass_m4_b_beowulf = ameno_7_achievement,
		wpn_fps_upg_m4_m_l5 = ameno_7_achievement,
		wpn_fps_upg_ak_fg_trax = ameno_8_achievement,
		wpn_fps_upg_ak_fg_krebs = ameno_8_achievement,
		wpn_fps_upg_ak_b_ak105 = ameno_8_achievement
	}
	if SystemInfo:platform() == Idstring("PS4") or SystemInfo:platform() == Idstring("XB1") then
		self.weapon_part_tracker = {}
	end
end
