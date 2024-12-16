CrimeSpreeTweakData = CrimeSpreeTweakData or class()

function CrimeSpreeTweakData:init(tweak_data)
	self.unlock_level = 60
	self.base_difficulty = "overkill_145"
	self.base_difficulty_index = 5
	self.starting_levels = {
		0,
		20,
		40
	}
	self.allow_highscore_continue = true
	self.initial_cost = 0
	self.cost_per_level = 0.5
	self.randomization_cost = 6
	self.randomization_multiplier = 2
	self.catchup_bonus = 0.035
	self.winning_streak = 0.005
	self.winning_streak_reset_on_failure = false
	self.continue_cost = {6, 0.7}
	self.crash_causes_loss = true
	self.protection_threshold = 16
	self.announce_modifier_stinger = "stinger_feedback_positive"
	self:init_missions(tweak_data)
	self:init_rewards(tweak_data)
	self:init_modifiers(tweak_data)
	self:init_gage_assets(tweak_data)
	self:init_gui(tweak_data)
end

function CrimeSpreeTweakData:init_missions(tweak_data)
	local debug_short_add = 5
	local debug_med_add = 7
	local debug_long_add = 10
	self.missions = {
		{
			{
				id = "bb_cash",
				add = debug_short_add,
				icon = "csm_branchbank",
				level = tweak_data.narrative.stages.branchbank_cash,
				stage_id = "branchbank_cash"
			},
			{
				id = "cage",
				add = debug_short_add,
				icon = "csm_carshop",
				level = tweak_data.narrative.stages.cage,
				stage_id = "cage"
			},
			{
				id = "kosugi",
				add = debug_short_add,
				icon = "csm_shadow_raid",
				level = tweak_data.narrative.stages.kosugi,
				stage_id = "kosugi"
			},
			{
				id = "dark",
				add = debug_short_add,
				icon = "csm_murky",
				level = tweak_data.narrative.stages.dark,
				stage_id = "dark"
			},
			{
				id = "fs_2",
				add = 5,
				icon = "csm_fs_2",
				level = tweak_data.narrative.stages.firestarter_2,
				stage_id = "firestarter_2"
			},
			{
				id = "hox_3",
				add = 4,
				icon = "csm_hoxvenge",
				level = tweak_data.narrative.stages.hox_3,
				stage_id = "hox_3"
			},
			{
				id = "fish",
				add = 4,
				icon = "csm_yacht",
				level = tweak_data.narrative.stages.fish,
				stage_id = "fish"
			},
			{
				id = "ed_2",
				add = 4,
				icon = "csm_election_2",
				level = tweak_data.narrative.stages.election_day_2,
				stage_id = "election_day_2"
			},
			{
				id = "crojob1",
				add = 8,
				icon = "csm_docks",
				level = tweak_data.narrative.stages.crojob1,
				stage_id = "crojob1"
			},
			{
				id = "framing_frame_3",
				add = debug_med_add,
				icon = "csm_framing_3",
				level = tweak_data.narrative.stages.framing_frame_3,
				stage_id = "framing_frame_3"
			},
			{
				id = "arm_for",
				add = debug_med_add,
				icon = "csm_train_forest",
				level = tweak_data.narrative.stages.arm_for,
				stage_id = "arm_for"
			},
			{
				id = "friend",
				add = 8,
				icon = "csm_friend",
				level = tweak_data.narrative.stages.friend,
				stage_id = "friend"
			},
			{
				id = "big",
				add = 13,
				icon = "csm_big",
				level = tweak_data.narrative.stages.big,
				stage_id = "big"
			},
			{
				id = "mus",
				add = debug_long_add,
				icon = "csm_diamond",
				level = tweak_data.narrative.stages.mus,
				stage_id = "mus"
			},
			{
				id = "roberts",
				add = debug_long_add,
				icon = "csm_go",
				level = tweak_data.narrative.stages.roberts,
				stage_id = "roberts"
			},
			{
				id = "red2",
				add = debug_long_add,
				icon = "csm_fwb",
				level = tweak_data.narrative.stages.red2,
				stage_id = "red2"
			}
		},
		{
			{
				id = "arm_cro",
				add = debug_short_add,
				icon = "csm_crossroads",
				level = tweak_data.narrative.stages.arm_cro,
				stage_id = "arm_cro"
			},
			{
				id = "help",
				add = debug_short_add,
				icon = "csm_prison",
				level = tweak_data.narrative.stages.help,
				stage_id = "help"
			},
			{
				id = "arm_und",
				add = debug_short_add,
				icon = "csm_overpass",
				level = tweak_data.narrative.stages.arm_und,
				stage_id = "cage"
			},
			{
				id = "arm_hcm",
				add = debug_short_add,
				icon = "csm_downtown",
				level = tweak_data.narrative.stages.arm_hcm,
				stage_id = "arm_hcm"
			},
			{
				id = "arm_par",
				add = debug_short_add,
				icon = "csm_park",
				level = tweak_data.narrative.stages.arm_par,
				stage_id = "arm_par"
			},
			{
				id = "arm_fac",
				add = debug_short_add,
				icon = "csm_harbor",
				level = tweak_data.narrative.stages.arm_fac,
				stage_id = "arm_fac"
			},
			{
				id = "biker_2",
				add = 3,
				icon = "csm_biker_2",
				level = tweak_data.narrative.stages.chew,
				stage_id = "chew"
			},
			{
				id = "fs_1",
				add = 4,
				icon = "csm_fs_1",
				level = tweak_data.narrative.stages.firestarter_1,
				stage_id = "firestarter_1"
			},
			{
				id = "nail",
				add = debug_short_add,
				icon = "csm_labrats",
				level = tweak_data.narrative.stages.nail,
				stage_id = "nail"
			},
			{
				id = "watchdogs_1_d",
				add = 6,
				icon = "csm_watchdogs_1",
				level = tweak_data.narrative.stages.watchdogs_1_d,
				stage_id = "watchdogs_1_d"
			},
			{
				id = "pines",
				add = debug_med_add,
				icon = "csm_white_xmas",
				level = tweak_data.narrative.stages.pines,
				stage_id = "pines"
			},
			{
				id = "moon",
				add = debug_med_add,
				icon = "csm_stealing_xmas",
				level = tweak_data.narrative.stages.moon,
				stage_id = "moon"
			},
			{
				id = "spa",
				add = 8,
				icon = "csm_brooklyn",
				level = tweak_data.narrative.stages.spa,
				stage_id = "spa"
			},
			{
				id = "cane",
				add = 8,
				icon = "csm_santas_workshop",
				level = tweak_data.narrative.stages.cane,
				stage_id = "cane"
			},
			{
				id = "mia_2",
				add = 8,
				icon = "csm_miami_2",
				level = tweak_data.narrative.stages.mia_2,
				stage_id = "mia_2"
			}
		},
		{
			{
				id = "pbr2",
				add = 9,
				icon = "csm_sky",
				level = tweak_data.narrative.stages.pbr2,
				stage_id = "pbr2"
			},
			{
				id = "pal",
				add = 9,
				icon = "csm_counterfeit",
				level = tweak_data.narrative.stages.pal,
				stage_id = "pal"
			},
			{
				id = "flat",
				add = 12,
				icon = "csm_panic_room",
				level = tweak_data.narrative.stages.flat,
				stage_id = "flat"
			},
			{
				id = "born",
				add = debug_long_add,
				icon = "csm_biker_1",
				level = tweak_data.narrative.stages.born,
				stage_id = "born"
			},
			{
				id = "hoxton_2",
				add = 15,
				icon = "csm_hoxout_2",
				level = tweak_data.narrative.stages.hox_2,
				stage_id = "hox_2"
			},
			{
				id = "hoxton_1",
				add = 10,
				icon = "csm_hoxout_1",
				level = tweak_data.narrative.stages.hox_1,
				stage_id = "hox_1"
			},
			{
				id = "bo_2",
				add = 14,
				icon = "csm_bigoil_2",
				level = tweak_data.narrative.stages.welcome_to_the_jungle_2,
				stage_id = "welcome_to_the_jungle_2"
			},
			{
				id = "mia_1",
				add = 10,
				icon = "csm_miami_1",
				level = tweak_data.narrative.stages.mia_1,
				stage_id = "mia_1"
			},
			{
				id = "cook_off",
				add = 13,
				icon = "csm_rats_1",
				level = tweak_data.narrative.stages.rat,
				stage_id = "rat"
			},
			{
				id = "pbr",
				add = debug_long_add,
				icon = "csm_mountain",
				level = tweak_data.narrative.stages.pbr,
				stage_id = "pbr"
			},
			{
				id = "glace",
				add = 12,
				icon = "csm_glace",
				level = tweak_data.narrative.stages.glace,
				stage_id = "glace"
			},
			{
				id = "run",
				add = 12,
				icon = "csm_run",
				level = tweak_data.narrative.stages.run,
				stage_id = "run"
			},
			{
				id = "man",
				add = debug_long_add,
				icon = "csm_undercover",
				level = tweak_data.narrative.stages.man,
				stage_id = "man"
			},
			{
				id = "dinner",
				add = 12,
				icon = "csm_slaughterhouse",
				level = tweak_data.narrative.stages.dinner,
				stage_id = "dinner"
			},
			{
				id = "jolly",
				add = 12,
				icon = "csm_aftershock",
				level = tweak_data.narrative.stages.jolly,
				stage_id = "jolly"
			}
		}
	}
end

function CrimeSpreeTweakData:init_modifiers(tweak_data)
	local health_increase = 25
	local damage_increase = 25
	self.max_modifiers_displayed = 3
	self.modifier_levels = {
		forced = 50,
		loud = 20,
		stealth = 26
	}
	self.modifiers = {
		forced = {
			{
				id = "damage_health_1",
				class = "ModifierEnemyHealthAndDamage",
				icon = "crime_spree_health",
				level = 50,
				data = {
					health = {20, "add"},
					damage = {15, "add"}
				}
			}
		},
		loud = {
			{
				id = "shield_reflect",
				class = "ModifierShieldReflect",
				icon = "crime_spree_shield_reflect",
				data = {}
			},
			{
				id = "cloaker_smoke",
				class = "ModifierCloakerKick",
				icon = "crime_spree_cloaker_smoke",
				data = {
					effect = {"smoke", "none"}
				}
			},
			{
				id = "medic_heal_1",
				class = "ModifierHealSpeed",
				icon = "crime_spree_medic_speed",
				data = {
					speed = {20, "add"}
				}
			},
			{
				id = "no_hurt",
				class = "ModifierNoHurtAnims",
				icon = "crime_spree_no_hurt",
				data = {}
			},
			{
				id = "taser_overcharge",
				class = "ModifierTaserOvercharge",
				icon = "crime_spree_taser_overcharge",
				data = {
					speed = {50, "add"}
				}
			},
			{
				id = "heavies",
				class = "ModifierHeavies",
				icon = "crime_spree_heavies",
				data = {}
			},
			{
				id = "medic_1",
				class = "ModifierMoreMedics",
				icon = "crime_spree_more_medics",
				data = {
					inc = {2, "add"}
				}
			},
			{
				id = "heavy_sniper",
				class = "ModifierHeavySniper",
				icon = "crime_spree_heavy_sniper",
				data = {
					spawn_chance = {5, "add"}
				}
			},
			{
				id = "dozer_rage",
				class = "ModifierDozerRage",
				icon = "crime_spree_dozer_rage",
				data = {
					damage = {100, "add"}
				}
			},
			{
				id = "cloaker_tear_gas",
				class = "ModifierCloakerTearGas",
				icon = "crime_spree_cloaker_tear_gas",
				data = {
					diameter = {4, "none"},
					damage = {30, "none"},
					duration = {10, "none"}
				}
			},
			{
				id = "dozer_1",
				class = "ModifierMoreDozers",
				icon = "crime_spree_more_dozers",
				data = {
					inc = {2, "add"}
				}
			},
			{
				id = "medic_heal_2",
				class = "ModifierHealSpeed",
				icon = "crime_spree_medic_speed",
				data = {
					speed = {20, "add"}
				}
			},
			{
				id = "dozer_lmg",
				class = "ModifierSkulldozers",
				icon = "crime_spree_dozer_lmg",
				data = {}
			},
			{
				id = "medic_adrenaline",
				class = "ModifierMedicAdrenaline",
				icon = "crime_spree_medic_adrenaline",
				data = {
					damage = {100, "add"}
				}
			},
			{
				id = "shield_phalanx",
				class = "ModifierShieldPhalanx",
				icon = "crime_spree_shield_phalanx",
				data = {}
			},
			{
				id = "dozer_2",
				class = "ModifierMoreDozers",
				icon = "crime_spree_more_dozers",
				data = {
					inc = {2, "add"}
				}
			},
			{
				id = "medic_deathwish",
				class = "ModifierMedicDeathwish",
				icon = "crime_spree_medic_deathwish",
				data = {}
			},
			{
				id = "dozer_minigun",
				class = "ModifierDozerMinigun",
				icon = "crime_spree_dozer_minigun",
				data = {}
			},
			{
				id = "medic_2",
				class = "ModifierMoreMedics",
				icon = "crime_spree_more_medics",
				data = {
					inc = {2, "add"}
				}
			},
			{
				id = "dozer_immunity",
				class = "ModifierExplosionImmunity",
				icon = "crime_spree_dozer_explosion",
				data = {}
			},
			{
				id = "dozer_medic",
				class = "ModifierDozerMedic",
				icon = "crime_spree_dozer_medic",
				data = {}
			},
			{
				id = "assault_extender",
				class = "ModifierAssaultExtender",
				icon = "crime_spree_assault_extender",
				data = {
					duration = {50, "add"},
					spawn_pool = {50, "add"},
					deduction = {4, "add"},
					max_hostages = {8, "none"}
				}
			},
			{
				id = "cloaker_arrest",
				class = "ModifierCloakerArrest",
				icon = "crime_spree_cloaker_arrest",
				data = {}
			},
			{
				id = "medic_rage",
				class = "ModifierMedicRage",
				icon = "crime_spree_medic_rage",
				data = {
					damage = {20, "add"}
				}
			}
		},
		stealth = {
			{
				id = "pagers_1",
				class = "ModifierLessPagers",
				icon = "crime_spree_pager",
				level = 26,
				data = {
					count = {1, "max"}
				}
			},
			{
				id = "civs_1",
				class = "ModifierCivilianAlarm",
				icon = "crime_spree_civs_killed",
				level = 26,
				data = {
					count = {10, "min"}
				}
			},
			{
				id = "conceal_1",
				class = "ModifierLessConcealment",
				icon = "crime_spree_concealment",
				level = 26,
				data = {
					conceal = {3, "add"}
				}
			},
			{
				id = "civs_2",
				class = "ModifierCivilianAlarm",
				icon = "crime_spree_civs_killed",
				level = 52,
				data = {
					count = {7, "min"}
				}
			},
			{
				id = "pagers_2",
				class = "ModifierLessPagers",
				icon = "crime_spree_pager",
				level = 78,
				data = {
					count = {2, "max"}
				}
			},
			{
				id = "conceal_2",
				class = "ModifierLessConcealment",
				icon = "crime_spree_concealment",
				level = 104,
				data = {
					conceal = {3, "add"}
				}
			},
			{
				id = "pagers_3",
				class = "ModifierLessPagers",
				icon = "crime_spree_pager",
				level = 130,
				data = {
					count = {3, "max"}
				}
			},
			{
				id = "civs_3",
				class = "ModifierCivilianAlarm",
				icon = "crime_spree_civs_killed",
				level = 156,
				data = {
					count = {4, "min"}
				}
			},
			{
				id = "pagers_4",
				class = "ModifierLessPagers",
				icon = "crime_spree_pager",
				level = 182,
				data = {
					count = {4, "max"}
				}
			}
		}
	}
	self.repeating_modifiers = {
		forced = {
			{
				id = "damage_health_rpt_",
				class = "ModifierEnemyHealthAndDamage",
				icon = "crime_spree_health",
				level = 5,
				data = {
					health = {20, "add"},
					damage = {15, "add"}
				}
			}
		}
	}
end

function CrimeSpreeTweakData:get_reward_icon(reward)
	for _, data in ipairs(self.rewards) do
		if data.id == reward then
			return data.icon
		end
	end
	return "downcard_overkill_deck"
end

function CrimeSpreeTweakData:init_rewards(tweak_data)
	self.loot_drop_reward_pay_class = 40
	local offshore_rate = tweak_data.money_manager.offshore_rate
	self.rewards = {
		{
			id = "experience",
			amount = 20000,
			name_id = "menu_challenge_xp_drop",
			icon = "upcard_xp",
			card_inc = 200000,
			max_cards = 10,
			always_show = true
		},
		{
			id = "cash",
			amount = 400000,
			name_id = "menu_challenge_cash_drop",
			cash_string = "$",
			icon = "upcard_cash",
			card_inc = 4000000,
			max_cards = 10,
			always_show = true
		},
		{
			id = "continental_coins",
			amount = 0.4,
			name_id = "menu_cs_coins",
			icon = "upcard_coins",
			card_inc = 4,
			max_cards = 5
		},
		{
			id = "loot_drop",
			amount = 0.2,
			name_id = "menu_challenge_loot_drop",
			icon = "upcard_random",
			card_inc = 5,
			max_cards = 5
		},
		{
			id = "random_cosmetic",
			amount = 0.007,
			name_id = "menu_challenge_cosmetic_drop",
			icon = "upcard_cosmetic",
			card_inc = 1,
			max_cards = 5
		}
	}
	self.all_cosmetics_reward = {
		type = "continental_coins",
		amount = 6
	}
	self.cosmetic_rewards = {
		{type = "armor", id = "cvc_green"},
		{type = "armor", id = "cvc_black"},
		{type = "armor", id = "cvc_grey"},
		{type = "armor", id = "cvc_tan"},
		{
			type = "armor",
			id = "cvc_navy_blue"
		},
		{
			type = "armor",
			id = "drm_tree_stump"
		},
		{
			type = "armor",
			id = "drm_gray_raider"
		},
		{
			type = "armor",
			id = "drm_desert_twilight"
		},
		{
			type = "armor",
			id = "drm_navy_breeze"
		},
		{
			type = "armor",
			id = "drm_woodland_tech"
		},
		{
			type = "armor",
			id = "drm_khaki_eclipse"
		},
		{
			type = "armor",
			id = "drm_desert_tech"
		},
		{
			type = "armor",
			id = "drm_misted_grey"
		},
		{
			type = "armor",
			id = "drm_khaki_regular"
		},
		{
			type = "armor",
			id = "drm_somber_woodland"
		}
	}
end

function CrimeSpreeTweakData:init_gage_assets(tweak_data)
	local asset_cost = 18
	self.max_assets_unlocked = 4
	self.assets = {}
	self.assets.increased_health = {}
	self.assets.increased_health.name_id = "menu_cs_ga_increased_health"
	self.assets.increased_health.unlock_desc_id = "menu_cs_ga_increased_health_desc"
	self.assets.increased_health.icon = "csb_health"
	self.assets.increased_health.cost = asset_cost
	self.assets.increased_health.data = {health = 10}
	self.assets.increased_health.class = "GageModifierMaxHealth"
	self.assets.increased_armor = {}
	self.assets.increased_armor.name_id = "menu_cs_ga_increased_armor"
	self.assets.increased_armor.unlock_desc_id = "menu_cs_ga_increased_armor_desc"
	self.assets.increased_armor.icon = "csb_armor"
	self.assets.increased_armor.cost = asset_cost
	self.assets.increased_armor.data = {armor = 10}
	self.assets.increased_armor.class = "GageModifierMaxArmor"
	self.assets.increased_stamina = {}
	self.assets.increased_stamina.name_id = "menu_cs_ga_increased_stamina"
	self.assets.increased_stamina.unlock_desc_id = "menu_cs_ga_increased_stamina_desc"
	self.assets.increased_stamina.icon = "csb_stamina"
	self.assets.increased_stamina.cost = asset_cost
	self.assets.increased_stamina.data = {stamina = 100}
	self.assets.increased_stamina.class = "GageModifierMaxStamina"
	self.assets.increased_ammo = {}
	self.assets.increased_ammo.name_id = "menu_cs_ga_increased_ammo"
	self.assets.increased_ammo.unlock_desc_id = "menu_cs_ga_increased_ammo_desc"
	self.assets.increased_ammo.icon = "csb_ammo"
	self.assets.increased_ammo.cost = asset_cost
	self.assets.increased_ammo.data = {ammo = 15}
	self.assets.increased_ammo.class = "GageModifierMaxAmmo"
	self.assets.increased_lives = {}
	self.assets.increased_lives.name_id = "menu_cs_ga_increased_lives"
	self.assets.increased_lives.unlock_desc_id = "menu_cs_ga_increased_lives_desc"
	self.assets.increased_lives.icon = "csb_lives"
	self.assets.increased_lives.cost = asset_cost
	self.assets.increased_lives.data = {lives = 1}
	self.assets.increased_lives.class = "GageModifierMaxLives"
	self.assets.increased_throwables = {}
	self.assets.increased_throwables.name_id = "menu_cs_ga_increased_throwables"
	self.assets.increased_throwables.unlock_desc_id = "menu_cs_ga_increased_throwables_desc"
	self.assets.increased_throwables.icon = "csb_throwables"
	self.assets.increased_throwables.cost = asset_cost
	self.assets.increased_throwables.data = {throwables = 70}
	self.assets.increased_throwables.class = "GageModifierMaxThrowables"
	self.assets.increased_deployables = {}
	self.assets.increased_deployables.name_id = "menu_cs_ga_increased_deployables"
	self.assets.increased_deployables.unlock_desc_id = "menu_cs_ga_increased_deployables_desc"
	self.assets.increased_deployables.icon = "csb_deployables"
	self.assets.increased_deployables.cost = asset_cost
	self.assets.increased_deployables.data = {deployables = 50}
	self.assets.increased_deployables.class = "GageModifierMaxDeployables"
	self.assets.increased_absorption = {}
	self.assets.increased_absorption.name_id = "menu_cs_ga_increased_absorption"
	self.assets.increased_absorption.unlock_desc_id = "menu_cs_ga_increased_absorption_desc"
	self.assets.increased_absorption.icon = "csb_absorb"
	self.assets.increased_absorption.cost = asset_cost
	self.assets.increased_absorption.data = {absorption = 0.5}
	self.assets.increased_absorption.class = "GageModifierDamageAbsorption"
	self.assets.quick_reload = {}
	self.assets.quick_reload.name_id = "menu_cs_ga_quick_reload"
	self.assets.quick_reload.unlock_desc_id = "menu_cs_ga_quick_reload_desc"
	self.assets.quick_reload.icon = "csb_reload"
	self.assets.quick_reload.cost = asset_cost
	self.assets.quick_reload.data = {speed = 25}
	self.assets.quick_reload.class = "GageModifierQuickReload"
	self.assets.quick_switch = {}
	self.assets.quick_switch.name_id = "menu_cs_ga_quick_switch"
	self.assets.quick_switch.unlock_desc_id = "menu_cs_ga_quick_switch_desc"
	self.assets.quick_switch.icon = "csb_switch"
	self.assets.quick_switch.cost = asset_cost
	self.assets.quick_switch.data = {speed = 50}
	self.assets.quick_switch.class = "GageModifierQuickSwitch"
	self.assets.melee_invulnerability = {}
	self.assets.melee_invulnerability.name_id = "menu_cs_ga_melee_invulnerability"
	self.assets.melee_invulnerability.unlock_desc_id = "menu_cs_ga_melee_invulnerability_desc"
	self.assets.melee_invulnerability.icon = "csb_melee"
	self.assets.melee_invulnerability.cost = asset_cost
	self.assets.melee_invulnerability.data = {time = 5}
	self.assets.melee_invulnerability.class = "GageModifierMeleeInvincibility"
	self.assets.explosion_immunity = {}
	self.assets.explosion_immunity.name_id = "menu_cs_ga_explosion_immunity"
	self.assets.explosion_immunity.unlock_desc_id = "menu_cs_ga_explosion_immunity_desc"
	self.assets.explosion_immunity.icon = "csb_explosion"
	self.assets.explosion_immunity.cost = asset_cost
	self.assets.explosion_immunity.data = {}
	self.assets.explosion_immunity.class = "GageModifierExplosionImmunity"
	self.assets.life_steal = {}
	self.assets.life_steal.name_id = "menu_cs_ga_life_steal"
	self.assets.life_steal.unlock_desc_id = "menu_cs_ga_life_steal_desc"
	self.assets.life_steal.icon = "csb_lifesteal"
	self.assets.life_steal.cost = asset_cost
	self.assets.life_steal.data = {
		cooldown = 5,
		health_restored = 0.05,
		armor_restored = 0.05
	}
	self.assets.life_steal.class = "GageModifierLifeSteal"
	self.assets.quick_pagers = {}
	self.assets.quick_pagers.name_id = "menu_cs_ga_quick_pagers"
	self.assets.quick_pagers.unlock_desc_id = "menu_cs_ga_quick_pagers_desc"
	self.assets.quick_pagers.icon = "csb_pagers"
	self.assets.quick_pagers.cost = asset_cost
	self.assets.quick_pagers.data = {speed = 50}
	self.assets.quick_pagers.stealth = true
	self.assets.quick_pagers.class = "GageModifierQuickPagers"
	self.assets.increased_body_bags = {}
	self.assets.increased_body_bags.name_id = "menu_cs_ga_increased_body_bags"
	self.assets.increased_body_bags.unlock_desc_id = "menu_cs_ga_increased_body_bags_desc"
	self.assets.increased_body_bags.icon = "csb_bodybags"
	self.assets.increased_body_bags.cost = asset_cost
	self.assets.increased_body_bags.data = {bags = 2}
	self.assets.increased_body_bags.stealth = true
	self.assets.increased_body_bags.class = "GageModifierMaxBodyBags"
	self.assets.quick_locks = {}
	self.assets.quick_locks.name_id = "menu_cs_ga_quick_locks"
	self.assets.quick_locks.unlock_desc_id = "menu_cs_ga_quick_locks_desc"
	self.assets.quick_locks.icon = "csb_locks"
	self.assets.quick_locks.cost = asset_cost
	self.assets.quick_locks.data = {speed = 25}
	self.assets.quick_locks.stealth = true
	self.assets.quick_locks.class = "GageModifierQuickLocks"
end

function CrimeSpreeTweakData:init_gui(tweak_data)
	self.gui = {}
	self.gui.randomize_time = {1.25, 2.5}
	self.gui.spin_speed = 800
	self.gui.spin_speed_limit = {80, 1000}
	self.gui.max_chat_lines = {lobby = 11, preplanning = 11}
	self.gui.missions_displayed = 3
	self.gui.modifiers_before_scroll = 7
end
