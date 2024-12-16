SkillTreeTweakData = SkillTreeTweakData or class()

function SkillTreeTweakData:init()
	local digest = function(value)
		return Application:digest_value(value, true)
	end
	self.tier_unlocks = {
		digest(0),
		digest(1),
		digest(3),
		digest(18)
	}
	self.costs = {
		unlock_tree = digest(0),
		default = digest(1),
		pro = digest(3),
		hightier = digest(4),
		hightierpro = digest(8)
	}
	self.unlock_tree_cost = {
		digest(0),
		digest(0),
		digest(0),
		digest(0),
		digest(0)
	}
	self.skill_pages_order = {
		"mastermind",
		"enforcer",
		"technician",
		"ghost",
		"hoxton"
	}
	self.tier_cost = {
		{1, 3},
		{2, 4},
		{3, 6},
		{4, 8}
	}
	self.num_tiers = #self.tier_cost
	self.HIDE_TIER_BONUS = true
	self.skills = {}
	self.skilltree = {}
	self.skilltree.mastermind = {
		name_id = "st_menu_mastermind",
		desc_id = "st_menu_mastermind_desc"
	}
	self.skilltree.enforcer = {
		name_id = "st_menu_enforcer",
		desc_id = "st_menu_enforcer_desc"
	}
	self.skilltree.technician = {
		name_id = "st_menu_technician",
		desc_id = "st_menu_technician_desc"
	}
	self.skilltree.ghost = {
		name_id = "st_menu_ghost",
		desc_id = "st_menu_ghost_desc"
	}
	self.skilltree.hoxton = {
		name_id = "st_menu_hoxton_pack",
		desc_id = "st_menu_hoxton_pack_desc"
	}
	self.skills.black_marketeer = {
		name_id = "menu_black_marketeer_beta",
		desc_id = "menu_black_marketeer_beta_desc",
		icon_xy = {2, 10},
		[1] = {
			upgrades = {
				"player_hostage_health_regen_addend_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_hostage_health_regen_addend_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.gun_fighter = {
		name_id = "menu_gun_fighter_beta",
		desc_id = "menu_gun_fighter_beta_desc",
		icon_xy = {7, 11},
		[1] = {
			upgrades = {
				"pistol_damage_addend_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"pistol_damage_addend_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.combat_medic = {
		name_id = "menu_combat_medic_beta",
		desc_id = "menu_combat_medic_beta_desc",
		icon_xy = {5, 7},
		[1] = {
			upgrades = {
				"temporary_revive_damage_reduction_1",
				"player_revive_damage_reduction_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_revive_health_boost"
			},
			cost = self.costs.pro
		}
	}
	self.skills.control_freak = {
		name_id = "menu_control_freak_beta",
		desc_id = "menu_control_freak_beta_desc",
		icon_xy = {1, 10},
		[1] = {
			upgrades = {
				"player_minion_master_speed_multiplier",
				"player_passive_convert_enemies_health_multiplier_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_minion_master_health_multiplier",
				"player_passive_convert_enemies_health_multiplier_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.leadership = {
		name_id = "menu_leadership_beta",
		desc_id = "menu_leadership_beta_desc",
		icon_xy = {7, 7},
		[1] = {
			upgrades = {
				"team_pistol_recoil_index_addend",
				"team_pistol_suppression_recoil_index_addend"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"team_weapon_recoil_index_addend",
				"team_weapon_suppression_recoil_index_addend"
			},
			cost = self.costs.pro
		}
	}
	self.skills.inside_man = {
		name_id = "menu_inside_man_beta",
		desc_id = "menu_inside_man_beta_desc",
		icon_xy = {6, 7},
		[1] = {
			upgrades = {
				"player_civ_calming_alerts",
				"player_civ_intimidation_mul"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_additional_assets"
			},
			cost = self.costs.pro
		}
	}
	self.skills.target_mark = {
		name_id = "menu_target_mark_beta",
		desc_id = "menu_target_mark_beta_desc",
		icon_xy = {3, 7},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			cost = self.costs.pro
		}
	}
	self.skills.dominator = {
		name_id = "menu_dominator_beta",
		desc_id = "menu_dominator_beta_desc",
		icon_xy = {2, 8},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_intimidate_range_mul",
				"player_intimidate_aura"
			},
			cost = self.costs.pro
		}
	}
	self.skills.fast_learner = {
		name_id = "menu_fast_learner_beta",
		desc_id = "menu_fast_learner_beta_desc",
		icon_xy = {0, 10},
		[1] = {
			upgrades = {
				"player_revive_damage_reduction_level_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_revive_damage_reduction_level_2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.stockholm_syndrome = {
		name_id = "menu_stockholm_syndrome_beta",
		desc_id = "menu_stockholm_syndrome_beta_desc",
		icon_xy = {3, 8},
		[1] = {
			upgrades = {
				"player_civ_calming_alerts"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_super_syndrome_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.cable_guy = {
		name_id = "menu_cable_guy_beta",
		desc_id = "menu_cable_guy_beta_desc",
		icon_xy = {2, 8},
		[1] = {
			upgrades = {
				"player_intimidate_range_mul",
				"player_intimidate_aura",
				"player_civ_intimidation_mul"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_convert_enemies_max_minions_2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.tactician = {
		name_id = "menu_tactician_beta",
		desc_id = "menu_tactician_beta_desc",
		icon_xy = {3, 7},
		[1] = {
			upgrades = {
				"player_marked_enemy_extra_damage"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_buy_spotter_asset"
			},
			cost = self.costs.pro
		}
	}
	self.skills.triathlete = {
		name_id = "menu_triathlete_beta",
		desc_id = "menu_triathlete_beta_desc",
		icon_xy = {4, 7},
		[1] = {
			upgrades = {
				"cable_tie_quantity",
				"cable_tie_interact_speed_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"team_damage_hostage_absorption"
			},
			cost = self.costs.pro
		}
	}
	self.skills.equilibrium = {
		name_id = "menu_equilibrium_beta",
		desc_id = "menu_equilibrium_beta_desc",
		icon_xy = {3, 9},
		[1] = {
			upgrades = {
				"pistol_swap_speed_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"pistol_spread_index_addend"
			},
			cost = self.costs.pro
		}
	}
	self.skills.negotiator = {
		name_id = "menu_negotiator_beta",
		desc_id = "menu_negotiator_beta_desc",
		icon_xy = {7, 8},
		[1] = {
			upgrades = {},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"pistol_fire_rate_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.medic_2x = {
		name_id = "menu_medic_2x_beta",
		desc_id = "menu_medic_2x_beta_desc",
		icon_xy = {5, 8},
		[1] = {
			upgrades = {
				"doctor_bag_quantity"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"doctor_bag_amount_increase1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.joker = {
		name_id = "menu_joker_beta",
		desc_id = "menu_joker_beta_desc",
		icon_xy = {6, 8},
		[1] = {
			upgrades = {
				"player_convert_enemies",
				"player_convert_enemies_max_minions_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_convert_enemies_damage_multiplier",
				"player_convert_enemies_interaction_speed_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.inspire = {
		name_id = "menu_inspire_beta",
		desc_id = "menu_inspire_beta_desc",
		icon_xy = {4, 9},
		[1] = {
			upgrades = {
				"player_revive_interaction_speed_multiplier",
				"player_morale_boost"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"cooldown_long_dis_revive"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.messiah = {
		name_id = "menu_pistol_beta_messiah",
		desc_id = "menu_pistol_beta_messiah_desc",
		icon_xy = {2, 9},
		[1] = {
			upgrades = {
				"player_messiah_revive_from_bleed_out_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_recharge_messiah_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.ammo_reservoir = {
		name_id = "menu_ammo_reservoir_beta",
		desc_id = "menu_ammo_reservoir_beta_desc",
		icon_xy = {4, 5},
		[1] = {
			upgrades = {
				"temporary_no_ammo_cost_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"temporary_no_ammo_cost_2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.demolition_man = {
		name_id = "menu_demolition_man_beta",
		desc_id = "menu_demolition_man_beta_desc",
		icon_xy = {4, 5},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {},
			cost = self.costs.pro
		}
	}
	self.skills.oppressor = {
		name_id = "menu_oppressor_beta",
		desc_id = "menu_oppressor_beta_desc",
		icon_xy = {2, 12},
		[1] = {
			upgrades = {
				"player_armor_regen_time_mul_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_flashbang_multiplier_1",
				"player_flashbang_multiplier_2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.steroids = {
		name_id = "menu_steroids_beta",
		desc_id = "menu_steroids_beta_desc",
		icon_xy = {1, 3},
		[1] = {
			upgrades = {
				"player_non_special_melee_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_melee_damage_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.bandoliers = {
		name_id = "menu_bandoliers_beta",
		desc_id = "menu_bandoliers_beta_desc",
		icon_xy = {3, 0},
		[1] = {
			upgrades = {
				"extra_ammo_multiplier1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_pick_up_ammo_multiplier",
				"player_pick_up_ammo_multiplier_2",
				"player_regain_throwable_from_ammo_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.pack_mule = {
		name_id = "menu_pack_mule_beta",
		desc_id = "menu_pack_mule_beta_desc",
		icon_xy = {8, 8},
		[1] = {
			upgrades = {
				"carry_throw_distance_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_armor_carry_bonus_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.shotgun_impact = {
		name_id = "menu_shotgun_impact_beta",
		desc_id = "menu_shotgun_impact_beta_desc",
		icon_xy = {4, 1},
		[1] = {
			upgrades = {
				"shotgun_recoil_index_addend",
				"shotgun_damage_multiplier_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"shotgun_damage_multiplier_2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.portable_saw = {
		name_id = "menu_portable_saw_beta",
		desc_id = "menu_portable_saw_beta_desc",
		icon_xy = {0, 1},
		[1] = {
			upgrades = {
				"saw_secondary"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"saw_extra_ammo_multiplier",
				"player_saw_speed_multiplier_2",
				"saw_lock_damage_multiplier_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.tough_guy = {
		name_id = "menu_tough_guy_beta",
		desc_id = "menu_tough_guy_beta_desc",
		icon_xy = {0, 0},
		[1] = {
			upgrades = {
				"player_damage_shake_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_bleed_out_health_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.underdog = {
		name_id = "menu_underdog_beta",
		desc_id = "menu_underdog_beta_desc",
		icon_xy = {2, 1},
		[1] = {
			upgrades = {
				"player_damage_multiplier_outnumbered"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_damage_dampener_outnumbered"
			},
			cost = self.costs.pro
		}
	}
	self.skills.juggernaut = {
		name_id = "menu_juggernaut_beta",
		desc_id = "menu_juggernaut_beta_desc",
		icon_xy = {3, 1},
		[1] = {
			upgrades = {
				"player_armor_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"body_armor6"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.from_the_hip = {
		name_id = "menu_from_the_hip_beta",
		desc_id = "menu_from_the_hip_beta_desc",
		icon_xy = {4, 1},
		[1] = {
			upgrades = {
				"shotgun_hip_fire_spread_index_addend"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"weapon_hip_fire_spread_index_addend"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.shotgun_cqb = {
		name_id = "menu_shotgun_cqb_beta",
		desc_id = "menu_shotgun_cqb_beta_desc",
		icon_xy = {8, 7},
		[1] = {
			upgrades = {
				"shotgun_reload_speed_multiplier_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"shotgun_enter_steelsight_speed_multiplier",
				"shotgun_reload_speed_multiplier_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.shades = {
		name_id = "menu_shades_beta",
		desc_id = "menu_shades_beta_desc",
		icon_xy = {6, 1},
		[1] = {
			upgrades = {
				"player_flashbang_multiplier_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_flashbang_multiplier_2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.ammo_2x = {
		name_id = "menu_ammo_2x_beta",
		desc_id = "menu_ammo_2x_beta_desc",
		icon_xy = {7, 1},
		[1] = {
			upgrades = {
				"ammo_bag_quantity"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"ammo_bag_ammo_increase1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.carbon_blade = {
		name_id = "menu_carbon_blade_beta",
		desc_id = "menu_carbon_blade_beta_desc",
		icon_xy = {0, 2},
		[1] = {
			upgrades = {
				"saw_enemy_slicer"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"saw_ignore_shields_1",
				"saw_panic_when_kill_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.show_of_force = {
		name_id = "menu_show_of_force_beta",
		desc_id = "menu_show_of_force_beta_desc",
		icon_xy = {8, 9},
		[1] = {
			upgrades = {
				"player_interacting_damage_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_level_2_armor_addend",
				"player_level_3_armor_addend",
				"player_level_4_armor_addend"
			},
			cost = self.costs.pro
		}
	}
	self.skills.wolverine = {
		name_id = "menu_wolverine_beta",
		desc_id = "menu_wolverine_beta_desc",
		icon_xy = {2, 2},
		[1] = {
			upgrades = {
				"player_melee_damage_health_ratio_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_damage_health_ratio_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.overkill = {
		name_id = "menu_overkill_beta",
		desc_id = "menu_overkill_beta_desc",
		icon_xy = {3, 2},
		[1] = {
			upgrades = {
				"player_overkill_damage_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_overkill_all_weapons",
				"weapon_swap_speed_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.mag_plus = {
		name_id = "menu_mag_plus_beta",
		desc_id = "menu_mag_plus_beta_desc",
		icon_xy = {2, 0},
		[1] = {
			upgrades = {
				"weapon_clip_ammo_increase_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"weapon_clip_ammo_increase_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.iron_man = {
		name_id = "menu_iron_man_beta",
		desc_id = "menu_iron_man_beta_desc",
		icon_xy = {8, 10},
		[1] = {
			upgrades = {
				"team_armor_regen_time_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_shield_knock"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.rifleman = {
		name_id = "menu_rifleman_beta",
		desc_id = "menu_rifleman_beta_desc",
		icon_xy = {6, 5},
		[1] = {
			upgrades = {
				"weapon_enter_steelsight_speed_multiplier",
				"player_steelsight_normal_movement_speed"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"assault_rifle_zoom_increase",
				"snp_zoom_increase",
				"smg_zoom_increase",
				"lmg_zoom_increase",
				"pistol_zoom_increase",
				"assault_rifle_move_spread_index_addend",
				"snp_move_spread_index_addend",
				"smg_move_spread_index_addend"
			},
			cost = self.costs.pro
		}
	}
	self.skills.blast_radius = {
		name_id = "menu_blast_radius_beta",
		desc_id = "menu_blast_radius_beta_desc",
		icon_xy = {7, 9},
		[1] = {
			upgrades = {},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_carry_sentry_and_trip"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.insulation = {
		name_id = "menu_insulation_beta",
		desc_id = "menu_insulation_beta_desc",
		icon_xy = {3, 5},
		[1] = {
			upgrades = {
				"player_taser_malfunction"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_taser_self_shock",
				"player_escape_taser_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.hardware_expert = {
		name_id = "menu_hardware_expert_beta",
		desc_id = "menu_hardware_expert_beta_desc",
		icon_xy = {9, 6},
		[1] = {
			upgrades = {
				"player_drill_fix_interaction_speed_multiplier",
				"player_trip_mine_deploy_time_multiplier_2",
				"player_drill_alert",
				"player_silent_drill"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_drill_autorepair_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.trip_mine_expert = {
		name_id = "menu_trip_mine_expert_beta",
		desc_id = "menu_trip_mine_expert_beta_desc",
		icon_xy = {8, 0},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {},
			cost = self.costs.pro
		}
	}
	self.skills.sharpshooter = {
		name_id = "menu_sharpshooter_beta",
		desc_id = "menu_sharpshooter_beta_desc",
		icon_xy = {8, 1},
		[1] = {
			upgrades = {
				"weapon_single_spread_index_addend"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"single_shot_accuracy_inc_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.sentry_gun = {
		name_id = "menu_sentry_gun_beta",
		desc_id = "menu_sentry_gun_beta_desc",
		icon_xy = {7, 5},
		[1] = {
			upgrades = {"sentry_gun"},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"sentry_gun_armor_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.sentry_targeting_package = {
		name_id = "menu_sentry_targeting_package_beta",
		desc_id = "menu_sentry_targeting_package_beta_desc",
		icon_xy = {9, 1},
		[1] = {
			upgrades = {
				"sentry_gun_spread_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"sentry_gun_rot_speed_multiplier",
				"sentry_gun_extra_ammo_multiplier_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.sentry_2_0 = {
		name_id = "menu_sentry_2_0_beta",
		desc_id = "menu_sentry_2_0_beta_desc",
		icon_xy = {5, 6},
		[1] = {
			upgrades = {
				"sentry_gun_can_reload"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"sentry_gun_shield"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.drill_expert = {
		name_id = "menu_drill_expert_beta",
		desc_id = "menu_drill_expert_beta_desc",
		icon_xy = {3, 6},
		[1] = {
			upgrades = {
				"player_drill_speed_multiplier1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_drill_speed_multiplier2"
			},
			cost = self.costs.pro
		}
	}
	self.skills.military_grade = {
		name_id = "menu_military_grade_beta",
		desc_id = "menu_military_grade_beta_desc",
		icon_xy = {4, 6},
		[1] = {
			upgrades = {
				"trip_mine_quantity_increase_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {},
			cost = self.costs.hightierpro
		}
	}
	self.skills.dye_pack_removal = {
		name_id = "menu_dye_pack_removal_beta",
		desc_id = "menu_dye_pack_removal_beta_desc",
		icon_xy = {0, 6},
		[1] = {
			upgrades = {
				"player_dye_pack_chance_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_dye_pack_cash_loss_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.silent_drilling = {
		name_id = "menu_silent_drilling_beta",
		desc_id = "menu_silent_drilling_beta_desc",
		icon_xy = {2, 6},
		[1] = {
			upgrades = {},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {},
			cost = self.costs.hightierpro
		}
	}
	self.skills.discipline = {
		name_id = "menu_discipline_beta",
		desc_id = "menu_discipline_beta_desc",
		icon_xy = {6, 6},
		[1] = {
			upgrades = {
				"player_interacting_damage_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_steelsight_when_downed"
			},
			cost = self.costs.pro
		}
	}
	self.skills.trip_miner = {
		name_id = "menu_trip_miner_beta",
		desc_id = "menu_trip_miner_beta_desc",
		icon_xy = {2, 5},
		[1] = {
			upgrades = {
				"trip_mine_quantity_increase_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_trip_mine_deploy_time_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.shaped_charge = {
		name_id = "menu_shaped_charge_beta",
		desc_id = "menu_shaped_charge_beta_desc",
		icon_xy = {0, 7},
		[1] = {
			upgrades = {
				"trip_mine_quantity_increase_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_trip_mine_shaped_charge"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.ecm_booster = {
		name_id = "menu_ecm_booster_beta",
		desc_id = "menu_ecm_booster_beta_desc",
		icon_xy = {6, 3},
		[1] = {
			upgrades = {
				"ecm_jammer_duration_multiplier",
				"ecm_jammer_feedback_duration_boost"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"ecm_jammer_can_open_sec_doors"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.sprinter = {
		name_id = "menu_sprinter_beta",
		desc_id = "menu_sprinter_beta_desc",
		icon_xy = {10, 5},
		[1] = {
			upgrades = {
				"player_stamina_regen_timer_multiplier",
				"player_stamina_regen_multiplier",
				"player_run_speed_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_run_dodge_chance"
			},
			cost = self.costs.pro
		}
	}
	self.skills.smg_training = {
		name_id = "menu_smg_training_beta",
		desc_id = "menu_smg_training_beta_desc",
		icon_xy = {3, 3},
		[1] = {
			upgrades = {
				"smg_reload_speed_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"smg_recoil_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.smg_master = {
		name_id = "menu_smg_master_beta",
		desc_id = "menu_smg_master_beta_desc",
		icon_xy = {3, 3},
		[1] = {
			upgrades = {
				"smg_reload_speed_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"smg_fire_rate_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.transporter = {
		name_id = "menu_transporter_beta",
		desc_id = "menu_transporter_beta_desc",
		icon_xy = {4, 3},
		[1] = {
			upgrades = {
				"carry_interact_speed_multiplier_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_armor_carry_bonus_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.cat_burglar = {
		name_id = "menu_cat_burglar_beta",
		desc_id = "menu_cat_burglar_beta_desc",
		icon_xy = {0, 4},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_respawn_time_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.chameleon = {
		name_id = "menu_chameleon_beta",
		desc_id = "menu_chameleon_beta_desc",
		icon_xy = {6, 10},
		[1] = {
			upgrades = {
				"player_standstill_omniscience"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_buy_bodybags_asset",
				"player_additional_assets",
				"player_cleaner_cost_multiplier",
				"player_buy_spotter_asset"
			},
			cost = self.costs.pro
		}
	}
	self.skills.cleaner = {
		name_id = "menu_cleaner_beta",
		desc_id = "menu_cleaner_beta_desc",
		icon_xy = {7, 2},
		[1] = {
			upgrades = {
				"player_corpse_dispose_amount_2",
				"player_extra_corpse_dispose_amount"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"bodybags_bag_quantity"
			},
			cost = self.costs.pro
		}
	}
	self.skills.ecm_2x = {
		name_id = "menu_ecm_2x_beta",
		desc_id = "menu_ecm_2x_beta_desc",
		icon_xy = {3, 4},
		[1] = {
			upgrades = {
				"ecm_jammer_quantity_increase_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"ecm_jammer_duration_multiplier_2",
				"ecm_jammer_feedback_duration_boost_2",
				"ecm_jammer_affects_pagers"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.assassin = {
		name_id = "menu_assassin_beta",
		desc_id = "menu_assassin_beta_desc",
		icon_xy = {0, 3},
		[1] = {
			upgrades = {
				"player_walk_speed_multiplier",
				"player_crouch_speed_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_silent_kill"
			},
			cost = self.costs.pro
		}
	}
	self.skills.martial_arts = {
		name_id = "menu_martial_arts_beta",
		desc_id = "menu_martial_arts_beta_desc",
		icon_xy = {11, 7},
		[1] = {
			upgrades = {
				"player_melee_damage_dampener"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_melee_knockdown_mul"
			},
			cost = self.costs.pro
		}
	}
	self.skills.nine_lives = {
		name_id = "menu_nine_lives_beta",
		desc_id = "menu_nine_lives_beta_desc",
		icon_xy = {5, 2},
		[1] = {
			upgrades = {
				"player_bleed_out_health_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_additional_lives_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.ecm_feedback = {
		name_id = "menu_ecm_feedback_beta",
		desc_id = "menu_ecm_feedback_beta_desc",
		icon_xy = {6, 2},
		[1] = {
			upgrades = {},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {},
			cost = self.costs.hightierpro
		}
	}
	self.skills.moving_target = {
		name_id = "menu_moving_target_beta",
		desc_id = "menu_moving_target_beta_desc",
		icon_xy = {2, 4},
		[1] = {
			upgrades = {
				"player_can_strafe_run"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {},
			cost = self.costs.hightierpro
		}
	}
	self.skills.scavenger = {
		name_id = "menu_scavenger_beta",
		desc_id = "menu_scavenger_beta_desc",
		icon_xy = {10, 9},
		[1] = {
			upgrades = {
				"temporary_damage_speed_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_team_damage_speed_multiplier_send"
			},
			cost = self.costs.pro
		}
	}
	self.skills.hitman = {
		name_id = "menu_hitman_beta",
		desc_id = "menu_hitman_beta_desc",
		icon_xy = {5, 9},
		[1] = {
			upgrades = {
				"weapon_silencer_damage_multiplier_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"weapon_silencer_damage_multiplier_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.silence_expert = {
		name_id = "menu_silence_expert_beta",
		desc_id = "menu_silence_expert_beta_desc",
		icon_xy = {4, 4},
		[1] = {
			upgrades = {
				"weapon_silencer_recoil_index_addend",
				"weapon_silencer_enter_steelsight_speed_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"weapon_silencer_spread_index_addend"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.good_luck_charm = {
		name_id = "menu_good_luck_charm_beta",
		desc_id = "menu_good_luck_charm_beta_desc",
		icon_xy = {4, 2},
		[1] = {
			upgrades = {
				"player_tape_loop_duration_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {},
			cost = self.costs.hightierpro
		}
	}
	self.skills.disguise = {
		name_id = "menu_disguise_beta",
		desc_id = "menu_disguise_beta_desc",
		icon_xy = {6, 4},
		[1] = {
			cost = self.costs.hightier
		},
		[2] = {
			cost = self.costs.hightierpro
		}
	}
	self.skills.magic_touch = {
		name_id = "menu_magic_touch_beta",
		desc_id = "menu_magic_touch_beta_desc",
		icon_xy = {5, 4},
		[1] = {
			upgrades = {
				"player_pick_lock_easy",
				"player_pick_lock_easy_speed_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {},
			cost = self.costs.hightierpro
		}
	}
	self.skills.freedom_call = {
		name_id = "menu_freedom_call_beta",
		desc_id = "menu_freedom_call_beta_desc",
		icon_xy = {5, 10},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_on_zipline_dodge_chance"
			},
			cost = self.costs.pro
		}
	}
	self.skills.hidden_blade = {
		name_id = "menu_hidden_blade_beta",
		desc_id = "menu_hidden_blade_beta_desc",
		icon_xy = {4, 10},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {},
			cost = self.costs.pro
		}
	}
	self.skills.tea_time = {
		name_id = "menu_tea_time_beta",
		desc_id = "menu_tea_time_beta_desc",
		icon_xy = {1, 11},
		[1] = {
			upgrades = {
				"first_aid_kit_deploy_time_multiplier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"first_aid_kit_damage_reduction_upgrade"
			},
			cost = self.costs.pro
		}
	}
	self.skills.awareness = {
		name_id = "menu_awareness_beta",
		desc_id = "menu_awareness_beta_desc",
		icon_xy = {10, 6},
		[1] = {
			upgrades = {
				"player_movement_speed_multiplier",
				"player_climb_speed_multiplier_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_can_free_run",
				"player_run_and_reload"
			},
			cost = self.costs.pro
		}
	}
	self.skills.alpha_dog = {
		name_id = "menu_alpha_dog_beta",
		desc_id = "menu_alpha_dog_beta_desc",
		icon_xy = {0, 11},
		[1] = {
			upgrades = {
				"player_crouch_dodge_chance_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {},
			cost = self.costs.pro
		}
	}
	self.skills.tea_cookies = {
		name_id = "menu_tea_cookies_beta",
		desc_id = "menu_tea_cookies_beta_desc",
		icon_xy = {2, 11},
		[1] = {
			upgrades = {
				"first_aid_kit_quantity_increase_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"first_aid_kit_quantity_increase_2",
				"first_aid_kit_auto_recovery_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.cell_mates = {
		name_id = "menu_cell_mates_beta",
		desc_id = "menu_cell_mates_beta_desc",
		icon_xy = {4, 11},
		[1] = {
			upgrades = {
				"player_cheat_death_chance_1"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_cheat_death_chance_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.thug_life = {
		name_id = "menu_thug_life_beta",
		desc_id = "menu_thug_life_beta_desc",
		icon_xy = {3, 12},
		[1] = {
			upgrades = {},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"pistol_reload_speed_multiplier"
			},
			cost = self.costs.pro
		}
	}
	self.skills.thick_skin = {
		name_id = "menu_thick_skin_beta",
		desc_id = "menu_thick_skin_beta_desc",
		icon_xy = {10, 7},
		[1] = {
			upgrades = {
				"player_melee_concealment_modifier"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_ballistic_vest_concealment_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.backstab = {
		name_id = "menu_backstab_beta",
		desc_id = "menu_backstab_beta_desc",
		icon_xy = {0, 12},
		[1] = {
			upgrades = {
				"player_detection_risk_add_crit_chance_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_detection_risk_add_crit_chance_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.drop_soap = {
		name_id = "menu_drop_soap_beta",
		desc_id = "menu_drop_soap_beta_desc",
		icon_xy = {4, 12},
		[1] = {
			upgrades = {
				"player_counter_strike_melee"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_counter_strike_spooc"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.second_chances = {
		name_id = "menu_second_chances_beta",
		desc_id = "menu_second_chances_beta_desc",
		icon_xy = {10, 4},
		[1] = {
			upgrades = {
				"player_tape_loop_duration_1",
				"player_tape_loop_duration_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_pick_lock_hard",
				"player_pick_lock_easy_speed_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.trigger_happy = {
		name_id = "menu_trigger_happy_beta",
		desc_id = "menu_trigger_happy_beta_desc",
		icon_xy = {11, 2},
		[1] = {
			upgrades = {
				"pistol_stacking_hit_damage_multiplier_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"pistol_stacking_hit_damage_multiplier_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.perseverance = {
		name_id = "menu_perseverance_beta",
		desc_id = "menu_perseverance_beta_desc",
		icon_xy = {5, 12},
		[1] = {
			upgrades = {
				"temporary_berserker_damage_multiplier_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"temporary_berserker_damage_multiplier_2",
				"player_berserker_no_ammo_cost"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.jail_workout = {
		name_id = "menu_jail_workout_beta",
		desc_id = "menu_jail_workout_beta_desc",
		icon_xy = {5, 3},
		[1] = {
			upgrades = {
				"player_suspicion_bonus",
				"player_sec_camera_highlight_mask_off",
				"player_special_enemy_highlight_mask_off"
			},
			cost = self.costs.default
		},
		[2] = {
			upgrades = {
				"player_mask_off_pickup",
				"player_small_loot_multiplier_1"
			},
			cost = self.costs.pro
		}
	}
	self.skills.akimbo = {
		name_id = "menu_akimbo_skill_beta",
		desc_id = "menu_akimbo_skill_beta_desc",
		icon_xy = {3, 11},
		[1] = {
			upgrades = {
				"akimbo_recoil_index_addend_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"akimbo_extra_ammo_multiplier_1",
				"akimbo_extra_ammo_multiplier_2",
				"akimbo_recoil_index_addend_3"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.jail_diet = {
		name_id = "menu_jail_diet_beta",
		desc_id = "menu_jail_diet_beta_desc",
		icon_xy = {1, 12},
		[1] = {
			upgrades = {
				"player_detection_risk_add_dodge_chance_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_detection_risk_add_dodge_chance_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.prison_wife = {
		name_id = "menu_prison_wife_beta",
		desc_id = "menu_prison_wife_beta_desc",
		icon_xy = {6, 11},
		[1] = {
			upgrades = {
				"player_headshot_regen_armor_bonus_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_headshot_regen_armor_bonus_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.stable_shot = {
		name_id = "menu_stable_shot_beta",
		desc_id = "menu_stable_shot_beta_desc",
		icon_xy = {0, 5},
		[1] = {
			upgrades = {
				"player_stability_increase_bonus_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_not_moving_accuracy_increase_bonus_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.spotter_teamwork = {
		name_id = "menu_spotter_teamwork_beta",
		desc_id = "menu_spotter_teamwork_beta_desc",
		icon_xy = {8, 2},
		[1] = {
			upgrades = {
				"player_marked_enemy_extra_damage"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_marked_inc_dmg_distance_1",
				"weapon_steelsight_highlight_specials",
				"player_mark_enemy_time_multiplier",
				"player_marked_distance_mul"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.single_shot_ammo_return = {
		name_id = "menu_single_shot_ammo_return_beta",
		desc_id = "menu_single_shot_ammo_return_beta_desc",
		icon_xy = {8, 4},
		[1] = {
			upgrades = {
				"head_shot_ammo_return_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"head_shot_ammo_return_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.speedy_reload = {
		name_id = "menu_speedy_reload_beta",
		desc_id = "menu_speedy_reload_beta_desc",
		icon_xy = {8, 3},
		[1] = {
			upgrades = {
				"assault_rifle_reload_speed_multiplier",
				"smg_reload_speed_multiplier",
				"snp_reload_speed_multiplier"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"temporary_single_shot_fast_reload_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.far_away = {
		name_id = "menu_far_away_beta",
		desc_id = "menu_far_away_beta_desc",
		icon_xy = {8, 5},
		[1] = {
			upgrades = {
				"shotgun_steelsight_accuracy_inc_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"shotgun_steelsight_range_inc_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.close_by = {
		name_id = "menu_close_by_beta",
		desc_id = "menu_close_by_beta_desc",
		icon_xy = {8, 6},
		[1] = {
			upgrades = {
				"shotgun_hip_run_and_shoot_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"shotgun_hip_rate_of_fire_1",
				"shotgun_magazine_capacity_inc_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.scavenging = {
		name_id = "menu_scavenging_beta",
		desc_id = "menu_scavenging_beta_desc",
		icon_xy = {8, 11},
		[1] = {
			upgrades = {
				"player_increased_pickup_area_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_double_drop_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.defense_up = {
		name_id = "menu_defense_up_beta",
		desc_id = "menu_defense_up_beta_desc",
		icon_xy = {9, 0},
		[1] = {
			upgrades = {
				"sentry_gun_cost_reduction_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"sentry_gun_shield"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.eco_sentry = {
		name_id = "menu_eco_sentry_beta",
		desc_id = "menu_eco_sentry_beta_desc",
		icon_xy = {9, 2},
		[1] = {
			upgrades = {
				"sentry_gun_cost_reduction_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"sentry_gun_armor_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.engineering = {
		name_id = "menu_engineering_beta",
		desc_id = "menu_engineering_beta_desc",
		icon_xy = {9, 3},
		[1] = {
			upgrades = {
				"sentry_gun_silent"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"sentry_gun_ap_bullets",
				"sentry_gun_fire_rate_reduction_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.jack_of_all_trades = {
		name_id = "menu_jack_of_all_trades_beta",
		desc_id = "menu_jack_of_all_trades_beta_desc",
		icon_xy = {9, 4},
		[1] = {
			upgrades = {
				"deploy_interact_faster_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"second_deployable_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.tower_defense = {
		name_id = "menu_tower_defense_beta",
		desc_id = "menu_tower_defense_beta_desc",
		icon_xy = {9, 5},
		[1] = {
			upgrades = {
				"sentry_gun_quantity_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"sentry_gun_quantity_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.kick_starter = {
		name_id = "menu_kick_starter_beta",
		desc_id = "menu_kick_starter_beta_desc",
		icon_xy = {9, 8},
		[1] = {
			upgrades = {
				"player_drill_autorepair_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_drill_melee_hit_restart_chance_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.fire_trap = {
		name_id = "menu_fire_trap_beta",
		desc_id = "menu_fire_trap_beta_desc",
		icon_xy = {9, 9},
		[1] = {
			upgrades = {
				"trip_mine_fire_trap_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"trip_mine_fire_trap_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.fast_fire = {
		name_id = "menu_fast_fire_beta",
		desc_id = "menu_fast_fire_beta_desc",
		icon_xy = {10, 2},
		[1] = {
			upgrades = {
				"player_automatic_mag_increase_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_ap_bullets_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.steady_grip = {
		name_id = "menu_steady_grip_beta",
		desc_id = "menu_steady_grip_beta_desc",
		icon_xy = {9, 11},
		[1] = {
			upgrades = {
				"player_weapon_accuracy_increase_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_stability_increase_bonus_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.fire_control = {
		name_id = "menu_fire_control_beta",
		desc_id = "menu_fire_control_beta_desc",
		icon_xy = {9, 10},
		[1] = {
			upgrades = {
				"player_hip_fire_accuracy_inc_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_weapon_movement_stability_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.shock_and_awe = {
		name_id = "menu_shock_and_awe_beta",
		desc_id = "menu_shock_and_awe_beta_desc",
		icon_xy = {10, 0},
		[1] = {
			upgrades = {
				"player_run_and_shoot_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_automatic_faster_reload_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.heavy_impact = {
		name_id = "menu_heavy_impact_beta",
		desc_id = "menu_heavy_impact_beta_desc",
		icon_xy = {10, 1},
		[1] = {
			upgrades = {
				"weapon_knock_down_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"weapon_knock_down_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.body_expertise = {
		name_id = "menu_body_expertise_beta",
		desc_id = "menu_body_expertise_beta_desc",
		icon_xy = {10, 3},
		[1] = {
			upgrades = {
				"weapon_automatic_head_shot_add_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"weapon_automatic_head_shot_add_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.unseen_strike = {
		name_id = "menu_unseen_strike_beta",
		desc_id = "menu_unseen_strike_beta_desc",
		icon_xy = {10, 11},
		[1] = {
			upgrades = {
				"player_unseen_increased_crit_chance_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_unseen_increased_crit_chance_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.dire_need = {
		name_id = "menu_dire_need_beta",
		desc_id = "menu_dire_need_beta_desc",
		icon_xy = {10, 8},
		[1] = {
			upgrades = {
				"player_armor_depleted_stagger_shot_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_armor_depleted_stagger_shot_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.up_you_go = {
		name_id = "menu_up_you_go_beta",
		desc_id = "menu_up_you_go_beta_desc",
		icon_xy = {11, 4},
		[1] = {
			upgrades = {
				"player_revived_damage_resist_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_revived_health_regain_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.running_from_death = {
		name_id = "menu_running_from_death_beta",
		desc_id = "menu_running_from_death_beta_desc",
		icon_xy = {11, 3},
		[1] = {
			upgrades = {
				"player_temp_swap_weapon_faster_1",
				"player_temp_reload_weapon_faster_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_temp_increased_movement_speed_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.dance_instructor = {
		name_id = "menu_dance_instructor",
		desc_id = "menu_dance_instructor_desc",
		icon_xy = {11, 0},
		[1] = {
			upgrades = {
				"pistol_magazine_capacity_inc_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"pistol_fire_rate_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.expert_handling = {
		name_id = "menu_expert_handling",
		desc_id = "menu_expert_handling_desc",
		icon_xy = {11, 1},
		[1] = {
			upgrades = {
				"pistol_stacked_accuracy_bonus_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"pistol_reload_speed_multiplier"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.bloodthirst = {
		name_id = "menu_bloodthirst",
		desc_id = "menu_bloodthirst_desc",
		icon_xy = {11, 6},
		[1] = {
			upgrades = {
				"player_melee_damage_stacking_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_temp_melee_kill_increase_reload_speed_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.feign_death = {
		name_id = "menu_feign_death",
		desc_id = "menu_feign_death_desc",
		icon_xy = {11, 5},
		[1] = {
			upgrades = {
				"player_cheat_death_chance_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_cheat_death_chance_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.frenzy = {
		name_id = "menu_frenzy",
		desc_id = "menu_frenzy_desc",
		icon_xy = {11, 8},
		[1] = {
			upgrades = {
				"player_healing_reduction_1",
				"player_health_damage_reduction_1",
				"player_max_health_reduction_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_healing_reduction_2",
				"player_health_damage_reduction_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.optic_illusions = {
		name_id = "menu_optic_illusions",
		desc_id = "menu_optic_illusions_desc",
		icon_xy = {10, 10},
		[1] = {
			upgrades = {
				"player_camouflage_bonus_1",
				"player_camouflage_bonus_2"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"player_silencer_concealment_penalty_decrease_1",
				"player_silencer_concealment_increase_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.more_fire_power = {
		name_id = "menu_more_fire_power",
		desc_id = "menu_more_fire_power_desc",
		icon_xy = {9, 7},
		[1] = {
			upgrades = {
				"shape_charge_quantity_increase_1",
				"trip_mine_quantity_increase_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"shape_charge_quantity_increase_2",
				"trip_mine_quantity_increase_2"
			},
			cost = self.costs.hightierpro
		}
	}
	self.skills.combat_engineering = {
		name_id = "menu_combat_engineering",
		desc_id = "menu_combat_engineering_desc",
		icon_xy = {1, 5},
		[1] = {
			upgrades = {
				"trip_mine_explosion_size_multiplier_1"
			},
			cost = self.costs.hightier
		},
		[2] = {
			upgrades = {
				"trip_mine_damage_multiplier_1"
			},
			cost = self.costs.hightierpro
		}
	}
	self.trees = {
		{
			name_id = "st_menu_mastermind_inspire",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "mastermind",
			tiers = {
				{
					"combat_medic"
				},
				{
					"tea_time",
					"fast_learner"
				},
				{
					"tea_cookies",
					"medic_2x"
				},
				{"inspire"}
			}
		},
		{
			name_id = "st_menu_mastermind_dominate",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "mastermind",
			tiers = {
				{"triathlete"},
				{"cable_guy", "joker"},
				{
					"stockholm_syndrome",
					"control_freak"
				},
				{
					"black_marketeer"
				}
			}
		},
		{
			name_id = "st_menu_mastermind_single_shot",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "mastermind",
			tiers = {
				{
					"stable_shot"
				},
				{
					"rifleman",
					"sharpshooter"
				},
				{
					"spotter_teamwork",
					"speedy_reload"
				},
				{
					"single_shot_ammo_return"
				}
			}
		},
		{
			name_id = "st_menu_enforce_shotgun",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "enforcer",
			tiers = {
				{"underdog"},
				{
					"shotgun_cqb",
					"shotgun_impact"
				},
				{"far_away", "close_by"},
				{"overkill"}
			}
		},
		{
			name_id = "st_menu_enforcer_armor",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "enforcer",
			tiers = {
				{"oppressor"},
				{
					"show_of_force",
					"pack_mule"
				},
				{
					"iron_man",
					"prison_wife"
				},
				{"juggernaut"}
			}
		},
		{
			name_id = "st_menu_enforcer_ammo",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "enforcer",
			tiers = {
				{"scavenging"},
				{
					"ammo_reservoir",
					"portable_saw"
				},
				{
					"ammo_2x",
					"carbon_blade"
				},
				{"bandoliers"}
			}
		},
		{
			name_id = "st_menu_technician_sentry",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "technician",
			tiers = {
				{"defense_up"},
				{
					"sentry_targeting_package",
					"eco_sentry"
				},
				{
					"engineering",
					"jack_of_all_trades"
				},
				{
					"tower_defense"
				}
			}
		},
		{
			name_id = "st_menu_technician_breaching",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "technician",
			tiers = {
				{
					"hardware_expert"
				},
				{
					"combat_engineering",
					"drill_expert"
				},
				{
					"more_fire_power",
					"kick_starter"
				},
				{"fire_trap"}
			}
		},
		{
			name_id = "st_menu_technician_auto",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "technician",
			tiers = {
				{
					"steady_grip"
				},
				{
					"heavy_impact",
					"fire_control"
				},
				{
					"shock_and_awe",
					"fast_fire"
				},
				{
					"body_expertise"
				}
			}
		},
		{
			name_id = "st_menu_ghost_stealth",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "ghost",
			tiers = {
				{
					"jail_workout"
				},
				{"cleaner", "chameleon"},
				{
					"second_chances",
					"ecm_booster"
				},
				{"ecm_2x"}
			}
		},
		{
			name_id = "st_menu_ghost_concealed",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "ghost",
			tiers = {
				{"sprinter"},
				{"awareness", "thick_skin"},
				{"dire_need", "insulation"},
				{"jail_diet"}
			}
		},
		{
			name_id = "st_menu_ghost_silencer",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "ghost",
			tiers = {
				{"scavenger"},
				{
					"optic_illusions",
					"silence_expert"
				},
				{"backstab", "hitman"},
				{
					"unseen_strike"
				}
			}
		},
		{
			name_id = "st_menu_fugitive_pistol_akimbo",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "hoxton",
			tiers = {
				{
					"equilibrium"
				},
				{
					"dance_instructor",
					"akimbo"
				},
				{
					"gun_fighter",
					"expert_handling"
				},
				{
					"trigger_happy"
				}
			}
		},
		{
			name_id = "st_menu_fugitive_undead",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "hoxton",
			tiers = {
				{"nine_lives"},
				{
					"running_from_death",
					"up_you_go"
				},
				{
					"perseverance",
					"feign_death"
				},
				{"messiah"}
			}
		},
		{
			name_id = "st_menu_fugitive_berserker",
			background_texture = "guis/textures/pd2/skilltree/bg_mastermind",
			unlocked = true,
			skill = "hoxton",
			tiers = {
				{
					"martial_arts"
				},
				{
					"bloodthirst",
					"steroids"
				},
				{"drop_soap", "wolverine"},
				{"frenzy"}
			}
		}
	}
	self.default_upgrades = {
		"player_fall_damage_multiplier",
		"player_fall_health_damage_multiplier",
		"player_silent_kill",
		"player_primary_weapon_when_downed",
		"player_intimidate_enemies",
		"player_special_enemy_highlight",
		"player_hostage_trade",
		"player_sec_camera_highlight",
		"player_corpse_dispose",
		"player_corpse_dispose_amount_1",
		"player_civ_harmless_melee",
		"player_walk_speed_multiplier",
		"player_steelsight_when_downed",
		"player_crouch_speed_multiplier",
		"carry_interact_speed_multiplier_1",
		"carry_interact_speed_multiplier_2",
		"carry_movement_speed_multiplier",
		"trip_mine_sensor_toggle",
		"trip_mine_sensor_highlight",
		"trip_mine_can_switch_on_off",
		"ecm_jammer_can_activate_feedback",
		"ecm_jammer_interaction_speed_multiplier",
		"ecm_jammer_can_retrigger",
		"ecm_jammer_affects_cameras",
		"striker_reload_speed_default",
		"temporary_first_aid_damage_reduction",
		"temporary_passive_revive_damage_reduction_2",
		"akimbo_recoil_index_addend_1",
		"doctor_bag",
		"ammo_bag",
		"trip_mine",
		"ecm_jammer",
		"first_aid_kit",
		"sentry_gun",
		"bodybags_bag",
		"saw",
		"cable_tie",
		"jowi",
		"x_1911",
		"x_b92fs",
		"x_deagle",
		"x_g22c",
		"x_g17",
		"x_usp",
		"x_sr2",
		"x_mp5",
		"x_akmsu",
		"x_packrat"
	}
	self.skill_switches = {
		{
			name_id = "menu_st_skill_switch_1"
		},
		{
			name_id = "menu_st_skill_switch_2",
			locks = {level = 50}
		},
		{
			name_id = "menu_st_skill_switch_3",
			locks = {level = 75}
		},
		{
			name_id = "menu_st_skill_switch_4",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_5",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_6",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_7",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_8",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_9",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_10",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_11",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_12",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_13",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_14",
			locks = {level = 100}
		},
		{
			name_id = "menu_st_skill_switch_15",
			locks = {level = 100, achievement = "frog_1"}
		}
	}
	self.specialization_convertion_rate = {
		100,
		200,
		300,
		400,
		500,
		600,
		700,
		800,
		900,
		1000
	}
	local deck2 = {
		upgrades = {
			"weapon_passive_headshot_damage_multiplier"
		},
		cost = 300,
		icon_xy = {1, 0},
		name_id = "menu_deckall_2",
		desc_id = "menu_deckall_2_desc"
	}
	local deck4 = {
		upgrades = {
			"passive_player_xp_multiplier",
			"player_passive_suspicion_bonus",
			"player_passive_armor_movement_penalty_multiplier"
		},
		cost = 600,
		icon_xy = {3, 0},
		name_id = "menu_deckall_4",
		desc_id = "menu_deckall_4_desc"
	}
	local deck6 = {
		upgrades = {
			"armor_kit",
			"player_pick_up_ammo_multiplier"
		},
		cost = 1600,
		icon_xy = {5, 0},
		name_id = "menu_deckall_6",
		desc_id = "menu_deckall_6_desc"
	}
	local deck8 = {
		upgrades = {
			"weapon_passive_damage_multiplier",
			"passive_doctor_bag_interaction_speed_multiplier"
		},
		cost = 3200,
		icon_xy = {7, 0},
		name_id = "menu_deckall_8",
		desc_id = "menu_deckall_8_desc"
	}
	self.specializations = {
		{
			name_id = "menu_st_spec_1",
			desc_id = "menu_st_spec_1_desc",
			{
				upgrades = {
					"team_damage_reduction_1",
					"player_passive_damage_reduction_1"
				},
				cost = 200,
				icon_xy = {0, 0},
				name_id = "menu_deck1_1",
				desc_id = "menu_deck1_1_desc"
			},
			deck2,
			{
				upgrades = {
					"team_passive_stamina_multiplier_1",
					"player_passive_intimidate_range_mul",
					"player_damage_dampener_close_contact_1"
				},
				cost = 400,
				icon_xy = {2, 0},
				name_id = "menu_deck1_3",
				desc_id = "menu_deck1_3_desc"
			},
			deck4,
			{
				upgrades = {
					"team_passive_health_multiplier",
					"player_passive_health_multiplier_1"
				},
				cost = 1000,
				icon_xy = {4, 0},
				name_id = "menu_deck1_5",
				desc_id = "menu_deck1_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_tier_armor_multiplier_1",
					"team_passive_armor_multiplier"
				},
				cost = 2400,
				icon_xy = {6, 0},
				name_id = "menu_deck1_7",
				desc_id = "menu_deck1_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"team_hostage_health_multiplier",
					"team_hostage_stamina_multiplier",
					"team_hostage_damage_dampener_multiplier"
				},
				cost = 4000,
				icon_xy = {0, 1},
				name_id = "menu_deck1_9",
				desc_id = "menu_deck1_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_2",
			desc_id = "menu_st_spec_2_desc",
			{
				upgrades = {
					"player_passive_health_multiplier_1"
				},
				cost = 200,
				icon_xy = {0, 0},
				name_id = "menu_deck2_1",
				desc_id = "menu_deck2_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_passive_health_multiplier_2",
					"player_uncover_multiplier"
				},
				cost = 400,
				icon_xy = {1, 1},
				name_id = "menu_deck2_3",
				desc_id = "menu_deck2_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_passive_health_multiplier_3"
				},
				cost = 1000,
				icon_xy = {2, 1},
				name_id = "menu_deck2_5",
				desc_id = "menu_deck2_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_panic_suppression"
				},
				cost = 2400,
				icon_xy = {3, 1},
				name_id = "menu_deck2_7",
				desc_id = "menu_deck2_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_passive_health_multiplier_4",
					"player_passive_health_regen"
				},
				cost = 4000,
				icon_xy = {4, 1},
				name_id = "menu_deck2_9",
				desc_id = "menu_deck2_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_3",
			desc_id = "menu_st_spec_3_desc",
			{
				upgrades = {
					"player_tier_armor_multiplier_1",
					"player_tier_armor_multiplier_2"
				},
				cost = 200,
				icon_xy = {6, 0},
				name_id = "menu_deck3_1",
				desc_id = "menu_deck3_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_tier_armor_multiplier_3"
				},
				cost = 400,
				icon_xy = {5, 1},
				name_id = "menu_deck3_3",
				desc_id = "menu_deck3_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_tier_armor_multiplier_4"
				},
				cost = 1000,
				icon_xy = {7, 1},
				name_id = "menu_deck3_5",
				desc_id = "menu_deck3_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_armor_regen_timer_multiplier_passive",
					"temporary_armor_break_invulnerable_1"
				},
				cost = 2400,
				icon_xy = {6, 1},
				name_id = "menu_deck3_7",
				desc_id = "menu_deck3_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_tier_armor_multiplier_5",
					"player_tier_armor_multiplier_6",
					"team_passive_armor_regen_time_multiplier"
				},
				cost = 4000,
				icon_xy = {0, 2},
				name_id = "menu_deck3_9",
				desc_id = "menu_deck3_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_4",
			desc_id = "menu_st_spec_4_desc",
			{
				upgrades = {
					"player_passive_dodge_chance_1"
				},
				cost = 200,
				icon_xy = {1, 2},
				name_id = "menu_deck4_1",
				desc_id = "menu_deck4_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_camouflage_multiplier"
				},
				cost = 400,
				icon_xy = {4, 2},
				name_id = "menu_deck4_3",
				desc_id = "menu_deck4_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_passive_dodge_chance_2"
				},
				cost = 1000,
				icon_xy = {2, 2},
				name_id = "menu_deck4_5",
				desc_id = "menu_deck4_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_passive_dodge_chance_3"
				},
				cost = 2400,
				icon_xy = {3, 2},
				name_id = "menu_deck4_7",
				desc_id = "menu_deck4_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"weapon_passive_armor_piercing_chance",
					"weapon_passive_swap_speed_multiplier_1"
				},
				cost = 4000,
				icon_xy = {5, 2},
				name_id = "menu_deck4_9",
				desc_id = "menu_deck4_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_5",
			desc_id = "menu_st_spec_5_desc",
			{
				upgrades = {
					"player_perk_armor_regen_timer_multiplier_1"
				},
				cost = 200,
				icon_xy = {6, 2},
				name_id = "menu_deck5_1",
				desc_id = "menu_deck5_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_perk_armor_regen_timer_multiplier_2",
					"akimbo_recoil_index_addend_2",
					"akimbo_extra_ammo_multiplier_1"
				},
				cost = 400,
				icon_xy = {7, 2},
				name_id = "menu_deck5_3",
				desc_id = "menu_deck5_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_perk_armor_regen_timer_multiplier_3"
				},
				cost = 1000,
				icon_xy = {0, 3},
				name_id = "menu_deck5_5",
				desc_id = "menu_deck5_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_perk_armor_regen_timer_multiplier_4"
				},
				cost = 2400,
				icon_xy = {1, 3},
				name_id = "menu_deck5_7",
				desc_id = "menu_deck5_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_perk_armor_regen_timer_multiplier_5",
					"player_passive_always_regen_armor_1"
				},
				cost = 4000,
				icon_xy = {3, 3},
				name_id = "menu_deck5_9",
				desc_id = "menu_deck5_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_6",
			desc_id = "menu_st_spec_6_desc",
			{
				upgrades = {
					"player_passive_dodge_chance_1"
				},
				cost = 200,
				icon_xy = {1, 2},
				name_id = "menu_deck6_1",
				desc_id = "menu_deck6_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_level_2_dodge_addend_1",
					"player_level_3_dodge_addend_1",
					"player_level_4_dodge_addend_1",
					"player_level_2_armor_multiplier_1",
					"player_level_3_armor_multiplier_1",
					"player_level_4_armor_multiplier_1"
				},
				cost = 400,
				icon_xy = {4, 3},
				name_id = "menu_deck6_3",
				desc_id = "menu_deck6_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_level_2_dodge_addend_2",
					"player_level_3_dodge_addend_2",
					"player_level_4_dodge_addend_2",
					"player_level_2_armor_multiplier_2",
					"player_level_3_armor_multiplier_2",
					"player_level_4_armor_multiplier_2"
				},
				cost = 1000,
				icon_xy = {5, 3},
				name_id = "menu_deck6_5",
				desc_id = "menu_deck6_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_level_2_dodge_addend_3",
					"player_level_3_dodge_addend_3",
					"player_level_4_dodge_addend_3",
					"player_level_2_armor_multiplier_3",
					"player_level_3_armor_multiplier_3",
					"player_level_4_armor_multiplier_3"
				},
				cost = 2400,
				icon_xy = {6, 3},
				name_id = "menu_deck6_7",
				desc_id = "menu_deck6_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_armor_regen_timer_multiplier_tier"
				},
				cost = 4000,
				icon_xy = {6, 2},
				name_id = "menu_deck6_9",
				desc_id = "menu_deck6_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_7",
			desc_id = "menu_st_spec_7_desc",
			dlc = "character_pack_clover",
			{
				upgrades = {
					"player_tier_dodge_chance_1"
				},
				cost = 200,
				icon_xy = {1, 2},
				name_id = "menu_deck7_1",
				desc_id = "menu_deck7_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_stand_still_crouch_camouflage_bonus_1",
					"player_corpse_dispose_speed_multiplier"
				},
				cost = 400,
				icon_xy = {0, 4},
				name_id = "menu_deck7_3",
				desc_id = "menu_deck7_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_tier_dodge_chance_2",
					"player_stand_still_crouch_camouflage_bonus_2",
					"player_pick_lock_speed_multiplier"
				},
				cost = 1000,
				icon_xy = {7, 3},
				name_id = "menu_deck7_5",
				desc_id = "menu_deck7_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_tier_dodge_chance_3",
					"player_stand_still_crouch_camouflage_bonus_3",
					"player_alarm_pager_speed_multiplier"
				},
				cost = 2400,
				icon_xy = {1, 4},
				name_id = "menu_deck7_7",
				desc_id = "menu_deck7_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_armor_regen_timer_stand_still_multiplier",
					"player_crouch_speed_multiplier_2"
				},
				cost = 4000,
				icon_xy = {2, 4},
				name_id = "menu_deck7_9",
				desc_id = "menu_deck7_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_8",
			desc_id = "menu_st_spec_8_desc",
			dlc = "character_pack_dragan",
			{
				upgrades = {
					"player_damage_dampener_close_contact_1"
				},
				cost = 200,
				icon_xy = {3, 4},
				name_id = "menu_deck8_1",
				desc_id = "menu_deck8_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_damage_dampener_close_contact_2"
				},
				cost = 400,
				icon_xy = {4, 4},
				name_id = "menu_deck8_3",
				desc_id = "menu_deck8_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_damage_dampener_close_contact_3",
					"melee_stacking_hit_expire_t",
					"melee_stacking_hit_damage_multiplier_1"
				},
				cost = 1000,
				icon_xy = {5, 4},
				name_id = "menu_deck8_5",
				desc_id = "menu_deck8_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_damage_dampener_outnumbered_strong",
					"melee_stacking_hit_damage_multiplier_2"
				},
				cost = 2400,
				icon_xy = {6, 4},
				name_id = "menu_deck8_7",
				desc_id = "menu_deck8_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_melee_life_leech"
				},
				cost = 4000,
				icon_xy = {7, 4},
				name_id = "menu_deck8_9",
				desc_id = "menu_deck8_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_9",
			desc_id = "menu_st_spec_9_desc",
			dlc = "hlm2_deluxe",
			{
				upgrades = {
					"player_damage_dampener_close_contact_1"
				},
				cost = 200,
				icon_xy = {3, 4},
				name_id = "menu_deck9_1",
				desc_id = "menu_deck9_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_killshot_regen_armor_bonus"
				},
				cost = 400,
				icon_xy = {0, 5},
				name_id = "menu_deck9_3",
				desc_id = "menu_deck9_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_melee_kill_life_leech"
				},
				cost = 1000,
				icon_xy = {1, 5},
				name_id = "menu_deck9_5",
				desc_id = "menu_deck9_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_killshot_close_regen_armor_bonus"
				},
				cost = 2400,
				icon_xy = {2, 5},
				name_id = "menu_deck9_7",
				desc_id = "menu_deck9_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_killshot_close_panic_chance"
				},
				cost = 4000,
				icon_xy = {3, 5},
				name_id = "menu_deck9_9",
				desc_id = "menu_deck9_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_10",
			desc_id = "menu_st_spec_10_desc",
			{
				upgrades = {
					"temporary_loose_ammo_restore_health_1",
					"player_gain_life_per_players"
				},
				cost = 200,
				icon_xy = {4, 5},
				name_id = "menu_deck10_1",
				desc_id = "menu_deck10_1_desc"
			},
			deck2,
			{
				upgrades = {
					"temporary_loose_ammo_give_team"
				},
				cost = 400,
				icon_xy = {5, 5},
				name_id = "menu_deck10_3",
				desc_id = "menu_deck10_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_loose_ammo_restore_health_give_team"
				},
				cost = 1000,
				icon_xy = {6, 5},
				name_id = "menu_deck10_5",
				desc_id = "menu_deck10_5_desc"
			},
			deck6,
			{
				upgrades = {
					"temporary_loose_ammo_restore_health_2"
				},
				cost = 2400,
				icon_xy = {7, 5},
				name_id = "menu_deck10_7",
				desc_id = "menu_deck10_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"temporary_loose_ammo_restore_health_3"
				},
				cost = 4000,
				icon_xy = {0, 6},
				name_id = "menu_deck10_9",
				desc_id = "menu_deck10_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_11",
			desc_id = "menu_st_spec_11_desc",
			dlc = "character_pack_sokol",
			{
				upgrades = {
					"player_damage_to_hot_1"
				},
				cost = 200,
				icon_xy = {1, 6},
				name_id = "menu_deck11_1",
				desc_id = "menu_deck11_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_damage_to_hot_2",
					"player_passive_health_multiplier_1",
					"player_passive_health_multiplier_2"
				},
				cost = 400,
				icon_xy = {2, 6},
				name_id = "menu_deck11_3",
				desc_id = "menu_deck11_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_damage_to_hot_3",
					"player_armor_piercing_chance_1"
				},
				cost = 1000,
				icon_xy = {3, 6},
				name_id = "menu_deck11_5",
				desc_id = "menu_deck11_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_damage_to_hot_4",
					"player_passive_health_multiplier_3"
				},
				cost = 2400,
				icon_xy = {4, 6},
				name_id = "menu_deck11_7",
				desc_id = "menu_deck11_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_damage_to_hot_extra_ticks",
					"player_armor_piercing_chance_2"
				},
				cost = 4000,
				icon_xy = {5, 6},
				name_id = "menu_deck11_9",
				desc_id = "menu_deck11_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_12",
			desc_id = "menu_st_spec_12_desc",
			dlc = "dragon",
			{
				upgrades = {
					"player_armor_regen_damage_health_ratio_multiplier_1"
				},
				cost = 200,
				icon_xy = {6, 6},
				name_id = "menu_deck12_1",
				desc_id = "menu_deck12_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_movement_speed_damage_health_ratio_multiplier"
				},
				cost = 400,
				icon_xy = {7, 6},
				name_id = "menu_deck12_3",
				desc_id = "menu_deck12_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_armor_regen_damage_health_ratio_multiplier_2"
				},
				cost = 1000,
				icon_xy = {0, 7},
				name_id = "menu_deck12_5",
				desc_id = "menu_deck12_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_armor_regen_damage_health_ratio_multiplier_3"
				},
				cost = 2400,
				icon_xy = {1, 7},
				name_id = "menu_deck12_7",
				desc_id = "menu_deck12_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_armor_regen_damage_health_ratio_threshold_multiplier",
					"player_movement_speed_damage_health_ratio_threshold_multiplier"
				},
				cost = 4000,
				icon_xy = {2, 7},
				name_id = "menu_deck12_9",
				desc_id = "menu_deck12_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_13",
			desc_id = "menu_st_spec_13_desc",
			{
				upgrades = {
					"player_armor_health_store_amount_1"
				},
				cost = 200,
				icon_xy = {3, 7},
				name_id = "menu_deck13_1",
				desc_id = "menu_deck13_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_armor_health_store_amount_2",
					"player_passive_health_multiplier_1"
				},
				cost = 400,
				icon_xy = {4, 7},
				name_id = "menu_deck13_3",
				desc_id = "menu_deck13_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_armor_max_health_store_multiplier",
					"player_passive_health_multiplier_2",
					"player_passive_dodge_chance_1"
				},
				cost = 1000,
				icon_xy = {5, 7},
				name_id = "menu_deck13_5",
				desc_id = "menu_deck13_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_armor_health_store_amount_3",
					"player_passive_health_multiplier_3"
				},
				cost = 2400,
				icon_xy = {6, 7},
				name_id = "menu_deck13_7",
				desc_id = "menu_deck13_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_kill_change_regenerate_speed"
				},
				cost = 4000,
				icon_xy = {7, 7},
				name_id = "menu_deck13_9",
				desc_id = "menu_deck13_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_14",
			desc_id = "menu_st_spec_14_desc",
			{
				upgrades = {
					"player_cocaine_stacking_1"
				},
				cost = 200,
				icon_xy = {0, 0},
				texture_bundle_folder = "coco",
				name_id = "menu_deck14_1",
				desc_id = "menu_deck14_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_sync_cocaine_stacks"
				},
				cost = 400,
				icon_xy = {1, 0},
				texture_bundle_folder = "coco",
				name_id = "menu_deck14_3",
				desc_id = "menu_deck14_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_cocaine_stacks_decay_multiplier_1"
				},
				cost = 1000,
				icon_xy = {2, 0},
				texture_bundle_folder = "coco",
				name_id = "menu_deck14_5",
				desc_id = "menu_deck14_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_sync_cocaine_upgrade_level_1"
				},
				cost = 2400,
				icon_xy = {3, 0},
				texture_bundle_folder = "coco",
				name_id = "menu_deck14_7",
				desc_id = "menu_deck14_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_cocaine_stack_absorption_multiplier_1"
				},
				cost = 4000,
				icon_xy = {0, 1},
				texture_bundle_folder = "coco",
				name_id = "menu_deck14_9",
				desc_id = "menu_deck14_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_15",
			desc_id = "menu_st_spec_15_desc",
			dlc = "opera",
			{
				upgrades = {
					"player_armor_grinding_1",
					"temporary_armor_break_invulnerable_1"
				},
				cost = 200,
				icon_xy = {0, 0},
				texture_bundle_folder = "opera",
				name_id = "menu_deck15_1",
				desc_id = "menu_deck15_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_health_decrease_1",
					"player_armor_increase_1"
				},
				cost = 400,
				icon_xy = {1, 0},
				texture_bundle_folder = "opera",
				name_id = "menu_deck15_3",
				desc_id = "menu_deck15_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_armor_increase_2"
				},
				cost = 1000,
				icon_xy = {2, 0},
				texture_bundle_folder = "opera",
				name_id = "menu_deck15_5",
				desc_id = "menu_deck15_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_armor_increase_3"
				},
				cost = 2400,
				icon_xy = {3, 0},
				texture_bundle_folder = "opera",
				name_id = "menu_deck15_7",
				desc_id = "menu_deck15_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_damage_to_armor_1"
				},
				cost = 4000,
				icon_xy = {0, 1},
				texture_bundle_folder = "opera",
				name_id = "menu_deck15_9",
				desc_id = "menu_deck15_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_16",
			desc_id = "menu_st_spec_16_desc",
			dlc = "wild",
			{
				upgrades = {
					"player_wild_health_amount_1",
					"player_wild_armor_amount_1"
				},
				cost = 200,
				icon_xy = {0, 0},
				texture_bundle_folder = "wild",
				name_id = "menu_deck16_1",
				desc_id = "menu_deck16_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_less_health_wild_armor_1"
				},
				cost = 400,
				icon_xy = {1, 0},
				texture_bundle_folder = "wild",
				name_id = "menu_deck16_3",
				desc_id = "menu_deck16_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_less_health_wild_cooldown_1"
				},
				cost = 1000,
				icon_xy = {2, 0},
				texture_bundle_folder = "wild",
				name_id = "menu_deck16_5",
				desc_id = "menu_deck16_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_less_armor_wild_health_1"
				},
				cost = 2400,
				icon_xy = {3, 0},
				texture_bundle_folder = "wild",
				name_id = "menu_deck16_7",
				desc_id = "menu_deck16_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_less_armor_wild_cooldown_1"
				},
				cost = 4000,
				icon_xy = {0, 1},
				texture_bundle_folder = "wild",
				name_id = "menu_deck16_9",
				desc_id = "menu_deck16_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_17",
			desc_id = "menu_st_spec_17_desc",
			dlc = "chico",
			{
				upgrades = {
					"temporary_chico_injector_1",
					"chico_injector"
				},
				cost = 200,
				icon_xy = {0, 0},
				texture_bundle_folder = "chico",
				name_id = "menu_deck17_1",
				desc_id = "menu_deck17_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_passive_health_multiplier_1"
				},
				cost = 400,
				icon_xy = {1, 0},
				texture_bundle_folder = "chico",
				name_id = "menu_deck17_3",
				desc_id = "menu_deck17_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_chico_preferred_target",
					"player_passive_health_multiplier_2"
				},
				cost = 1000,
				icon_xy = {2, 0},
				texture_bundle_folder = "chico",
				name_id = "menu_deck17_5",
				desc_id = "menu_deck17_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_passive_health_multiplier_3",
					"player_chico_injector_low_health_multiplier"
				},
				cost = 2400,
				icon_xy = {3, 0},
				texture_bundle_folder = "chico",
				name_id = "menu_deck17_7",
				desc_id = "menu_deck17_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_passive_health_multiplier_4",
					"player_chico_injector_health_to_speed"
				},
				cost = 4000,
				icon_xy = {0, 1},
				texture_bundle_folder = "chico",
				name_id = "menu_deck17_9",
				desc_id = "menu_deck17_9_desc"
			}
		},
		{
			name_id = "menu_st_spec_18",
			desc_id = "menu_st_spec_18_desc",
			{
				upgrades = {
					"smoke_screen_grenade"
				},
				cost = 200,
				icon_xy = {0, 0},
				texture_bundle_folder = "max",
				name_id = "menu_deck18_1",
				desc_id = "menu_deck18_1_desc"
			},
			deck2,
			{
				upgrades = {
					"player_dodge_shot_gain"
				},
				cost = 400,
				icon_xy = {1, 0},
				texture_bundle_folder = "max",
				name_id = "menu_deck18_3",
				desc_id = "menu_deck18_3_desc"
			},
			deck4,
			{
				upgrades = {
					"player_passive_dodge_chance_1"
				},
				cost = 1000,
				icon_xy = {2, 0},
				texture_bundle_folder = "max",
				name_id = "menu_deck18_5",
				desc_id = "menu_deck18_5_desc"
			},
			deck6,
			{
				upgrades = {
					"player_dodge_replenish_armor"
				},
				cost = 2400,
				icon_xy = {3, 0},
				texture_bundle_folder = "max",
				name_id = "menu_deck18_7",
				desc_id = "menu_deck18_7_desc"
			},
			deck8,
			{
				upgrades = {
					"player_passive_loot_drop_multiplier",
					"player_smoke_screen_ally_dodge_bonus",
					"player_sicario_multiplier"
				},
				cost = 4000,
				icon_xy = {0, 1},
				texture_bundle_folder = "max",
				name_id = "menu_deck18_9",
				desc_id = "menu_deck18_9_desc"
			}
		}
	}
end

function SkillTreeTweakData:get_tier_position_from_skill_name(skill_name)
	for tree_idx in pairs(self.trees) do
		local count = 0
		local tree = self.trees[tree_idx]
		for tier_idx in pairs(tree.tiers) do
			count = count + 1
			local tier = tree.tiers[tier_idx]
			for skill_idx in pairs(tier) do
				if skill_name == tier[skill_idx] then
					return count
				end
			end
		end
	end
	return -1
end

function SkillTreeTweakData:get_tree(tree_name)
	local list = {}
	for i, tree in ipairs(self.trees) do
		if tree.skill == tree_name then
			table.insert(list, tree)
		end
	end
	return list
end

function SkillTreeTweakData:get_tiers(tree_idx)
	local tiers = deep_clone(self.trees[tree_idx].tiers)
	return tiers
end

function SkillTreeTweakData:get_tier_unlocks()
	local digest = function(value)
		return Application:digest_value(value, false)
	end
	local tier_unlocks = self.tier_unlocks
	local unlock_values = {}
	for i = 1, #tier_unlocks do
		table.insert(unlock_values, digest(tier_unlocks[i]))
	end
	return unlock_values
end

function SkillTreeTweakData:get_specialization_icon_data(spec, no_fallback)
	spec = spec or managers.skilltree:get_specialization_value("current_specialization")
	print(spec, type(spec))
	local data = tweak_data.skilltree.specializations[spec]
	local max_tier = managers.skilltree:get_specialization_value(spec, "tiers", "max_tier")
	local tier_data = data and data[max_tier]
	if not tier_data then
		if no_fallback then
			return
		else
			print("fallback")
			return tweak_data.hud_icons:get_icon_data("fallback")
		end
	end
	local guis_catalog = "guis/" .. (tier_data.texture_bundle_folder and "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/" or "")
	local x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
	local y = tier_data.icon_xy and tier_data.icon_xy[2] or 0
	return guis_catalog .. "textures/pd2/specialization/icons_atlas", {
		x * 64,
		y * 64,
		64,
		64
	}
end
