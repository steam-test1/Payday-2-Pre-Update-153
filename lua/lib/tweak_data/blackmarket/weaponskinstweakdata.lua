function BlackMarketTweakData:_init_weapon_skins()
	self.weapon_skins = {}
	
	self.weapon_skins.serbu_woodland = {}
	self.weapon_skins.serbu_woodland.name_id = "bm_wskn_serbu_woodland"
	self.weapon_skins.serbu_woodland.desc_id = "bm_wskn_serbu_woodland_desc"
	self.weapon_skins.serbu_woodland.weapon_id = "serbu"
	self.weapon_skins.serbu_woodland.rarity = "common"
	self.weapon_skins.serbu_woodland.bonus = "concealment_p1"
	self.weapon_skins.serbu_woodland.reserve_quality = true
	self.weapon_skins.serbu_woodland.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.serbu_woodland.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df")
	self.weapon_skins.p90_woodland = {}
	self.weapon_skins.p90_woodland.name_id = "bm_wskn_p90_woodland"
	self.weapon_skins.p90_woodland.desc_id = "bm_wskn_p90_woodland_desc"
	self.weapon_skins.p90_woodland.weapon_id = "p90"
	self.weapon_skins.p90_woodland.rarity = "common"
	self.weapon_skins.p90_woodland.bonus = "recoil_p1"
	self.weapon_skins.p90_woodland.reserve_quality = true
	self.weapon_skins.p90_woodland.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.p90_woodland.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_004_df")
	self.weapon_skins.p90_woodland.pattern_tweak = Vector3(6.35822, 0, 0)
	self.weapon_skins.p90_woodland.pattern_pos = Vector3(0.826616, -0.375387, 0)
	self.weapon_skins.p90_woodland.parts = {
		wpn_fps_smg_p90_body_p90 = {
			[Idstring("p90"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stars_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df")
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stars_df"),
				pattern_pos = Vector3(0.111138, -0.0987357, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df"),
				pattern_tweak = Vector3(1.77916, 0, 1)
			}
		}
	}
	self.weapon_skins.plainsrider_woodland = {}
	self.weapon_skins.plainsrider_woodland.name_id = "bm_wskn_plainsrider_woodland"
	self.weapon_skins.plainsrider_woodland.desc_id = "bm_wskn_plainsrider_woodland_desc"
	self.weapon_skins.plainsrider_woodland.weapon_id = "plainsrider"
	self.weapon_skins.plainsrider_woodland.rarity = "common"
	self.weapon_skins.plainsrider_woodland.bonus = "concealment_p1"
	self.weapon_skins.plainsrider_woodland.reserve_quality = true
	self.weapon_skins.plainsrider_woodland.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.plainsrider_woodland.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df")
	self.weapon_skins.plainsrider_woodland.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_004_df")
	self.weapon_skins.plainsrider_woodland.pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_pixel_camo_df")
	self.weapon_skins.plainsrider_woodland.pattern_tweak = Vector3(3.44861, 0, 0.997)
	self.weapon_skins.plainsrider_woodland.pattern_pos = Vector3(1.40516, 1.00779, 0)
	self.weapon_skins.rpg7_woodland = {}
	self.weapon_skins.rpg7_woodland.name_id = "bm_wskn_rpg7_woodland"
	self.weapon_skins.rpg7_woodland.desc_id = "bm_wskn_rpg7_woodland_desc"
	self.weapon_skins.rpg7_woodland.weapon_id = "rpg7"
	self.weapon_skins.rpg7_woodland.rarity = "common"
	self.weapon_skins.rpg7_woodland.bonus = "spread_p1"
	self.weapon_skins.rpg7_woodland.reserve_quality = true
	self.weapon_skins.rpg7_woodland.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.rpg7_woodland.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_001_df")
	self.weapon_skins.rpg7_woodland.pattern_tweak = Vector3(5.26115, 0, 2)
	self.weapon_skins.rpg7_woodland.pattern_pos = Vector3(-1.17618, -0.715976, 0)
	self.weapon_skins.rpg7_woodland.parts = {
		wpn_fps_rpg7_m_rocket = {
			[Idstring("mtr_rocket"):key()] = {
				pattern_tweak = Vector3(3.44861, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_type_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df")
			}
		}
	}
	self.weapon_skins.ppk_woodland = {}
	self.weapon_skins.ppk_woodland.name_id = "bm_wskn_ppk_woodland"
	self.weapon_skins.ppk_woodland.desc_id = "bm_wskn_ppk_woodland_desc"
	self.weapon_skins.ppk_woodland.weapon_id = "ppk"
	self.weapon_skins.ppk_woodland.rarity = "common"
	self.weapon_skins.ppk_woodland.bonus = "recoil_p1"
	self.weapon_skins.ppk_woodland.reserve_quality = true
	self.weapon_skins.ppk_woodland.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.ppk_woodland.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_005_df")
	self.weapon_skins.ppk_woodland.parts = {
		wpn_fps_pis_ppk_body_standard = {
			[Idstring("mtr_frame"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_leopard_df"),
				pattern_tweak = Vector3(2.06535, 0, 1)
			}
		},
		wpn_fps_pis_ppk_b_standard = {
			[Idstring("mtr_slide"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_leopard_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df"),
				pattern_tweak = Vector3(1.49297, 0, 1)
			}
		},
		wpn_fps_pis_ppk_b_long = {
			[Idstring("mtr_slide_long"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_leopard_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df"),
				pattern_tweak = Vector3(1.49297, 0, 1)
			}
		}
	}
	self.weapon_skins.judge_woodland = {}
	self.weapon_skins.judge_woodland.name_id = "bm_wskn_judge_woodland"
	self.weapon_skins.judge_woodland.desc_id = "bm_wskn_judge_woodland_desc"
	self.weapon_skins.judge_woodland.weapon_id = "judge"
	self.weapon_skins.judge_woodland.reserve_quality = true
	self.weapon_skins.judge_woodland.rarity = "common"
	self.weapon_skins.judge_woodland.bonus = "concealment_p1"
	self.weapon_skins.judge_woodland.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.judge_woodland.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df")
	self.weapon_skins.judge_woodland.parts = {
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_frame"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_002_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_pixel_camo_df"),
				pattern_tweak = Vector3(1.01598, 0, 1)
			}
		}
	}
	self.weapon_skins.new_m4_goldstripes = {}
	self.weapon_skins.new_m4_goldstripes.name_id = "bm_wskn_new_m4_goldstripes"
	self.weapon_skins.new_m4_goldstripes.desc_id = "bm_wskn_new_m4_goldstripes_desc"
	self.weapon_skins.new_m4_goldstripes.weapon_id = "new_m4"
	self.weapon_skins.new_m4_goldstripes.rarity = "uncommon"
	self.weapon_skins.new_m4_goldstripes.bonus = "concealment_p1"
	self.weapon_skins.new_m4_goldstripes.reserve_quality = true
	self.weapon_skins.new_m4_goldstripes.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.new_m4_goldstripes.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.new_m4_goldstripes.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_009_df")
	self.weapon_skins.new_m4_goldstripes.pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_flag_stripes_df")
	self.weapon_skins.new_m4_goldstripes.pattern_tweak = Vector3(2.82853, 0, 0)
	self.weapon_skins.new_raging_bull_goldstripes = {}
	self.weapon_skins.new_raging_bull_goldstripes.weapon_id = "new_raging_bull"
	self.weapon_skins.new_raging_bull_goldstripes.name_id = "bm_wskn_new_raging_bull_goldstripes"
	self.weapon_skins.new_raging_bull_goldstripes.desc_id = "bm_wskn_new_raging_bull_goldstripes_desc"
	self.weapon_skins.new_raging_bull_goldstripes.rarity = "uncommon"
	self.weapon_skins.new_raging_bull_goldstripes.bonus = "recoil_p1"
	self.weapon_skins.new_raging_bull_goldstripes.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_004_df")
	self.weapon_skins.new_raging_bull_goldstripes.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.new_raging_bull_goldstripes.reserve_quality = true
	self.weapon_skins.flamethrower_mk2_goldstripes = {}
	self.weapon_skins.flamethrower_mk2_goldstripes.name_id = "bm_wskn_flamethrower_mk2_goldstripes"
	self.weapon_skins.flamethrower_mk2_goldstripes.desc_id = "bm_wskn_flamethrower_mk2_goldstripes_desc"
	self.weapon_skins.flamethrower_mk2_goldstripes.weapon_id = "flamethrower_mk2"
	self.weapon_skins.flamethrower_mk2_goldstripes.rarity = "uncommon"
	self.weapon_skins.flamethrower_mk2_goldstripes.bonus = "damage_p1"
	self.weapon_skins.flamethrower_mk2_goldstripes.reserve_quality = true
	self.weapon_skins.flamethrower_mk2_goldstripes.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.flamethrower_mk2_goldstripes.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.flamethrower_mk2_goldstripes.parts = {
		wpn_fps_fla_mk2_mag = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stbasil_df"),
				pattern_pos = Vector3(-0.308609, -0.237292, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_005_df"),
				pattern_tweak = Vector3(1.96995, 4.72475, 1)
			}
		},
		wpn_fps_fla_mk2_mag_rare = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stbasil_df"),
				pattern_pos = Vector3(-0.308609, -0.237292, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_004_df"),
				pattern_tweak = Vector3(1.96995, 4.72475, 1)
			}
		},
		wpn_fps_fla_mk2_mag_welldone = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stbasil_df"),
				pattern_pos = Vector3(-0.308609, -0.237292, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df"),
				pattern_tweak = Vector3(1.96995, 4.72475, 1)
			}
		}
	}
	self.weapon_skins.g36_goldstripes = {}
	self.weapon_skins.g36_goldstripes.name_id = "bm_wskn_g36_goldstripes"
	self.weapon_skins.g36_goldstripes.desc_id = "bm_wskn_g36_goldstripes_desc"
	self.weapon_skins.g36_goldstripes.weapon_id = "g36"
	self.weapon_skins.g36_goldstripes.rarity = "uncommon"
	self.weapon_skins.g36_goldstripes.reserve_quality = true
	self.weapon_skins.g36_goldstripes.bonus = "spread_p1"
	self.weapon_skins.g36_goldstripes.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.g36_goldstripes.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_006_df")
	self.weapon_skins.g36_goldstripes.pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_004_df")
	self.weapon_skins.g36_goldstripes.pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_leopard_df")
	self.weapon_skins.g36_goldstripes.pattern_tweak = Vector3(1.2, 0, 1)
	self.weapon_skins.new_m14_luxury = {}
	self.weapon_skins.new_m14_luxury.name_id = "bm_wskn_new_m14_luxury"
	self.weapon_skins.new_m14_luxury.desc_id = "bm_wskn_new_m14_luxury_desc"
	self.weapon_skins.new_m14_luxury.weapon_id = "new_m14"
	self.weapon_skins.new_m14_luxury.reserve_quality = true
	self.weapon_skins.new_m14_luxury.rarity = "rare"
	self.weapon_skins.new_m14_luxury.bonus = "recoil_p1"
	self.weapon_skins.new_m14_luxury.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.new_m14_luxury.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df")
	self.weapon_skins.new_m14_luxury.parts = {
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_sputnik_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_galaxy_df"),
				base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df"),
				uv_offset_rot = Vector3(0.0920584, 0.874315, 6.28319),
				pattern_pos = Vector3(0.769378, 0, 0),
				uv_scale = Vector3(8.8918, 8.8918, 0),
				pattern_tweak = Vector3(0.634393, 0.828668, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_002_df")
			}
		},
		wpn_fps_upg_o_m14_scopemount = {
			[Idstring("mtr_mount"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df"),
				pattern_tweak = Vector3(1, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df")
			}
		},
		wpn_fps_ass_m14_body_jae = {
			[Idstring("jae"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_sputnik_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_galaxy_df"),
				cubemap_pattern_control = Vector3(1, 1, 0),
				base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df"),
				uv_offset_rot = Vector3(-0.376308, 0.920473, 0),
				pattern_pos = Vector3(0, 0.187455, 0),
				uv_scale = Vector3(8.22535, 9.41622, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df"),
				pattern_tweak = Vector3(1.01598, 0, 1)
			}
		},
		wpn_fps_ass_m14_body_upper = {
			[Idstring("base"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stars_df"),
				pattern_pos = Vector3(0, 0.158836, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df"),
				cubemap_pattern_control = Vector3(0, 1, 0),
				pattern_tweak = Vector3(14.0854, 0, 1)
			}
		},
		wpn_fps_ass_m14_body_lower = {
			[Idstring("lower"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_001_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_stars_df"),
				pattern_tweak = Vector3(20, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df")
			}
		}
	}
	self.weapon_skins.new_m14_luxury.default_blueprint = {
		"wpn_fps_ass_m14_b_standard",
		"wpn_fps_ass_m14_body_lower",
		"wpn_fps_ass_m14_body_upper",
		"wpn_fps_ass_m14_m_standard",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_ass_m14_body_jae",
		"wpn_fps_upg_o_acog",
		"wpn_fps_upg_o_m14_scopemount"
	}
	self.weapon_skins.m95_luxury = {}
	self.weapon_skins.m95_luxury.name_id = "bm_wskn_m95_luxury"
	self.weapon_skins.m95_luxury.desc_id = "bm_wskn_m95_luxury_desc"
	self.weapon_skins.m95_luxury.weapon_id = "m95"
	self.weapon_skins.m95_luxury.reserve_quality = true
	self.weapon_skins.m95_luxury.rarity = "rare"
	self.weapon_skins.m95_luxury.bonus = "total_ammo_p1"
	self.weapon_skins.m95_luxury.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.m95_luxury.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.m95_luxury.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df")
	self.weapon_skins.m95_luxury.parts = {
		wpn_fps_snp_m95_upper_reciever = {
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_matryoshka_heisters_df"),
				uv_offset_rot = Vector3(0.0634394, 0.982791, 0),
				pattern_pos = Vector3(0.0920584, 0.216075, 0),
				uv_scale = Vector3(7.84295, 11.6569, 1),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_faberge_df"),
				pattern_tweak = Vector3(12.7498, 4.70977, 1)
			}
		},
		wpn_fps_snp_m95_lower_reciever = {
			[Idstring("mtr_lower"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_matryoshka_heisters_df"),
				uv_offset_rot = Vector3(0.108598, 1.02295, 0),
				pattern_pos = Vector3(-0.0550372, 0.0583599, 0),
				uv_scale = Vector3(10.2267, 10.179, 1),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_faberge_df"),
				pattern_tweak = Vector3(14.7285, 0, 1)
			}
		}
	}
	self.weapon_skins.m95_luxury.default_blueprint = {
		"wpn_fps_snp_m95_bipod",
		"wpn_fps_snp_m95_lower_reciever",
		"wpn_fps_snp_m95_upper_reciever",
		"wpn_fps_snp_m95_magazine",
		"wpn_fps_snp_m95_barrel_long",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_upg_o_leupold"
	}
	self.weapon_skins.b92fs_luxury = {}
	self.weapon_skins.b92fs_luxury.name_id = "bm_wskn_b92fs_luxury"
	self.weapon_skins.b92fs_luxury.desc_id = "bm_wskn_b92fs_luxury_desc"
	self.weapon_skins.b92fs_luxury.weapon_id = "b92fs"
	self.weapon_skins.b92fs_luxury.rarity = "rare"
	self.weapon_skins.b92fs_luxury.bonus = "concealment_p3"
	self.weapon_skins.b92fs_luxury.reserve_quality = true
	self.weapon_skins.b92fs_luxury.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.b92fs_luxury.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_004_df")
	self.weapon_skins.b92fs_luxury.default_blueprint = {
		"wpn_fps_pis_beretta_body_beretta",
		"wpn_fps_pis_beretta_b_std",
		"wpn_fps_pis_beretta_m_std",
		"wpn_fps_pis_beretta_o_std",
		"wpn_fps_upg_ns_pis_large",
		"wpn_fps_pis_beretta_g_ergo",
		"wpn_fps_pis_beretta_sl_brigadier"
	}
	self.weapon_skins.b92fs_luxury.parts = {
		wpn_fps_pis_beretta_body_beretta = {
			[Idstring("body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_bear_df"),
				uv_scale = Vector3(6.74644, 2.36036, 0),
				uv_offset_rot = Vector3(-0.470784, 0.906234, 0)
			}
		},
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_bear_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_flag_stripes_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_010_df"),
				pattern_pos = Vector3(-0.213212, 0.254233, 0),
				uv_scale = Vector3(2.21734, 2.31269, 0),
				uv_offset_rot = Vector3(-0.332768, 0.987251, 4.73174),
				pattern_tweak = Vector3(4.64107, 3.43605, 0)
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_bear_df"),
				uv_offset_rot = Vector3(-0.28907, 0.916393, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_010_df"),
				pattern_pos = Vector3(0, -0.140434, 0),
				uv_scale = Vector3(7.27086, 7.27086, 0.105652),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_flag_stripes_df"),
				pattern_tweak = Vector3(5.64274, 3.40608, 0)
			}
		}
	}
	self.weapon_skins.famas_hypno = {}
	self.weapon_skins.famas_hypno.name_id = "bm_wskn_famas_hypno"
	self.weapon_skins.famas_hypno.desc_id = "bm_wskn_famas_hypno_desc"
	self.weapon_skins.famas_hypno.weapon_id = "famas"
	self.weapon_skins.famas_hypno.reserve_quality = true
	self.weapon_skins.famas_hypno.rarity = "epic"
	self.weapon_skins.famas_hypno.bonus = "damage_p2"
	self.weapon_skins.famas_hypno.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.famas_hypno.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_tactical_001_df")
	self.weapon_skins.famas_hypno.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/pattern_gradient_camo_snow_001_df")
	self.weapon_skins.famas_hypno.pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_wheat_df")
	self.weapon_skins.famas_hypno.pattern_tweak = Vector3(1.20678, 3.40608, 1)
	self.weapon_skins.famas_hypno.parts = {
		wpn_fps_ass_famas_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_topowl_df"),
				uv_offset_rot = Vector3(-0.324149, 0.941092, 5.62385),
				uv_scale = Vector3(4.7441, 4.7441, 0),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_wheat_df"),
				pattern_tweak = Vector3(5.30885, 0, 1)
			},
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_topowl_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_wheat_df"),
				pattern_pos = Vector3(-0.108275, -0.499403, 0),
				uv_scale = Vector3(1.1685, 1.26385, 0),
				uv_offset_rot = Vector3(0.0363599, 0.71052, 0),
				pattern_tweak = Vector3(3.01532, 0, 1)
			},
			[Idstring("mtr_charge"):key()] = {
				pattern_pos = Vector3(-0.022418, 0, 0),
				pattern_tweak = Vector3(0.872886, 2.64185, 1)
			}
		},
		wpn_fps_ass_famas_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_wheat_df"),
				pattern_tweak = Vector3(2.78083, 0, 1)
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				pattern_pos = Vector3(-0.136895, -0.461245, 0),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_wheat_df"),
				pattern_tweak = Vector3(0.443599, 0.012, 1)
			}
		}
	}
	self.weapon_skins.famas_hypno.default_blueprint = {
		"wpn_fps_ass_famas_body_standard",
		"wpn_fps_ass_famas_m_standard",
		"wpn_fps_ass_famas_b_sniper",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_ass_famas_g_retro"
	}
	self.weapon_skins.huntsman_hypno = {}
	self.weapon_skins.huntsman_hypno.name_id = "bm_wskn_huntsman_hypno"
	self.weapon_skins.huntsman_hypno.desc_id = "bm_wskn_huntsman_hypno_desc"
	self.weapon_skins.huntsman_hypno.weapon_id = "huntsman"
	self.weapon_skins.huntsman_hypno.reserve_quality = true
	self.weapon_skins.huntsman_hypno.rarity = "epic"
	self.weapon_skins.huntsman_hypno.bonus = "spread_n1"
	self.weapon_skins.huntsman_hypno.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.huntsman_hypno.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_006_df")
	self.weapon_skins.huntsman_hypno.parts = {
		wpn_fps_shot_huntsman_b_long = {
			[Idstring("long_barrel"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_009_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_khokloma_df"),
				uv_offset_rot = Vector3(0.120677, 0.922013, 0),
				pattern_pos = Vector3(0, -1.66517, 0),
				uv_scale = Vector3(3.93363, 3.83828, 1),
				pattern_tweak = Vector3(3.87489, 0.169331, 1)
			}
		},
		wpn_fps_shot_huntsman_b_short = {
			[Idstring("short_barrel"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_009_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_khokloma_df"),
				uv_offset_rot = Vector3(0.120677, 0.922013, 0),
				pattern_pos = Vector3(0, -1.66517, 0),
				uv_scale = Vector3(3.93363, 3.83828, 1),
				pattern_tweak = Vector3(3.87489, 0.169331, 1)
			}
		},
		wpn_fps_shot_huntsman_s_long = {
			[Idstring("long_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_bear_bullets_df"),
				pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_009_df"),
				uv_scale = Vector3(1.32152, 1.28318, 1),
				uv_offset_rot = Vector3(-0.27999, 0.340091, 0),
				pattern_tweak = Vector3(2.06535, 0, 1)
			}
		}
	}
	self.weapon_skins.huntsman_hypno.default_blueprint = {
		"wpn_fps_shot_huntsman_body_standard",
		"wpn_fps_shot_huntsman_b_long",
		"wpn_fps_shot_huntsman_s_long",
		"wpn_fps_upg_a_slug"
	}
	self.weapon_skins.ak74_rodina = {}
	self.weapon_skins.ak74_rodina.name_id = "bm_wskn_ak74_rodina"
	self.weapon_skins.ak74_rodina.desc_id = "bm_wskn_ak74_rodina_desc"
	self.weapon_skins.ak74_rodina.weapon_id = "ak74"
	self.weapon_skins.ak74_rodina.reserve_quality = true
	self.weapon_skins.ak74_rodina.rarity = "legendary"
	self.weapon_skins.ak74_rodina.bonus = "spread_p1"
	self.weapon_skins.ak74_rodina.texture_bundle_folder = "cash/safes/sputnik"
	self.weapon_skins.ak74_rodina.unique_name_id = "bm_wskn_ak74_rodina"
	self.weapon_skins.ak74_rodina.locked = true
	self.weapon_skins.ak74_rodina.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_005_df")
	self.weapon_skins.ak74_rodina.default_blueprint = {
		"wpn_fps_ass_74_body_upperreceiver",
		"wpn_fps_ass_ak_body_lowerreceiver",
		"wpn_fps_ass_74_b_legend",
		"wpn_fps_upg_ak_m_uspalm",
		"wpn_upg_ak_s_legend",
		"wpn_upg_ak_g_legend",
		"wpn_upg_ak_fg_legend",
		"wpn_upg_ak_fl_legend",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_o_ak_scopemount"
	}
	self.weapon_skins.ak74_rodina.parts = {
		wpn_fps_upg_ak_m_uspalm = {
			[Idstring("mtr_uspalm"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_russian_flag_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_flag_stripes_df"),
				pattern_tweak = Vector3(2.35154, 3.49599, 1),
				pattern_pos = Vector3(-0.156974, -1.42476, 0),
				uv_scale = Vector3(0.01, 1.12082, 0),
				uv_offset_rot = Vector3(0.244694, 0.979251, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_004_df")
			}
		},
		wpn_fps_ass_74_body_upperreceiver = {
			[Idstring("ak74_dustcover"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_starbomb_df"),
				uv_scale = Vector3(2.69309, 2.69377, 1),
				uv_offset_rot = Vector3(-0.165514, 0.893394, 0)
			}
		},
		wpn_fps_ass_ak_body_lowerreceiver = {
			[Idstring("ak_base"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_starbomb_df"),
				uv_scale = Vector3(4.26735, 4.69642, 1),
				uv_offset_rot = Vector3(-0.223752, 0.977171, 0)
			}
		},
		wpn_upg_ak_fg_legend = {
			[Idstring("mtr_fore"):key()] = {
				uv_scale = Vector3(11.1802, 10.2744, 1),
				uv_offset_rot = Vector3(0.406869, 1.00787, 0)
			},
			[Idstring("handguard_upper_wood"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/sputnik/sticker/sticker_stbasil_df"),
				uv_scale = Vector3(1.54989, 1.1685, 1),
				uv_offset_rot = Vector3(-0.108275, 0.960172, 0)
			}
		}
	}
	self.weapon_skins.m95_forest = {}
	self.weapon_skins.m95_forest.name_id = "bm_wskn_m95_forest"
	self.weapon_skins.m95_forest.desc_id = "bm_wskn_m95_forest_desc"
	self.weapon_skins.m95_forest.weapon_id = "m95"
	self.weapon_skins.m95_forest.reserve_quality = true
	self.weapon_skins.m95_forest.rarity = "common"
	self.weapon_skins.m95_forest.bonus = "total_ammo_p1"
	self.weapon_skins.m95_forest.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df")
	self.weapon_skins.m95_forest.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.famas_forest = {}
	self.weapon_skins.famas_forest.name_id = "bm_wskn_famas_forest"
	self.weapon_skins.famas_forest.desc_id = "bm_wskn_famas_forest_desc"
	self.weapon_skins.famas_forest.weapon_id = "famas"
	self.weapon_skins.famas_forest.reserve_quality = true
	self.weapon_skins.famas_forest.rarity = "common"
	self.weapon_skins.famas_forest.bonus = "spread_p1"
	self.weapon_skins.famas_forest.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.famas_forest.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_007_df")
	self.weapon_skins.famas_forest.parts = {
		wpn_fps_ass_famas_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				pattern_tweak = Vector3(17.1858, 6.02844, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_goldcoins_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_new_002_df")
			}
		}
	}
	self.weapon_skins.huntsman_forest = {}
	self.weapon_skins.huntsman_forest.name_id = "bm_wskn_huntsman_forest"
	self.weapon_skins.huntsman_forest.desc_id = "bm_wskn_huntsman_forest_desc"
	self.weapon_skins.huntsman_forest.weapon_id = "huntsman"
	self.weapon_skins.huntsman_forest.reserve_quality = true
	self.weapon_skins.huntsman_forest.rarity = "common"
	self.weapon_skins.huntsman_forest.bonus = "recoil_p1"
	self.weapon_skins.huntsman_forest.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.huntsman_forest.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df")
	self.weapon_skins.r93_forest = {}
	self.weapon_skins.r93_forest.name_id = "bm_wskn_r93_forest"
	self.weapon_skins.r93_forest.desc_id = "bm_wskn_r93_forest_desc"
	self.weapon_skins.r93_forest.weapon_id = "r93"
	self.weapon_skins.r93_forest.reserve_quality = true
	self.weapon_skins.r93_forest.rarity = "common"
	self.weapon_skins.r93_forest.bonus = "recoil_p1"
	self.weapon_skins.r93_forest.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.r93_forest.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_005_df")
	self.weapon_skins.r93_forest.parts = {
		wpn_fps_snp_r93_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				uv_offset_rot = Vector3(-0.29907, 0, 0),
				pattern_pos = Vector3(0, -0.556642, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_005_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/fire_pattern_df"),
				pattern_tweak = Vector3(1.11138, 0, 1)
			}
		},
		wpn_fps_snp_r93_body_standard = {
			[Idstring("mtr_body"):key()] = {
				pattern_tweak = Vector3(1.49297, 0, 1)
			},
			[Idstring("mtr_upper"):key()] = {
				pattern_tweak = Vector3(0.491297, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/fire_pattern_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_005_df")
			}
		},
		wpn_fps_upg_o_shortdot = {
			[Idstring("mtr_shortdot"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/fire_pattern_df"),
				pattern_pos = Vector3(0.883854, 0.168376, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_005_df"),
				pattern_tweak = Vector3(0.538996, 0, 1)
			}
		},
		wpn_fps_snp_r93_m_std = {
			[Idstring("mtr_mag"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_005_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/fire_pattern_df"),
				pattern_tweak = Vector3(0.300503, 0, 1)
			}
		}
	}
	self.weapon_skins.b92fs_forest = {}
	self.weapon_skins.b92fs_forest.name_id = "bm_wskn_b92fs_forest"
	self.weapon_skins.b92fs_forest.desc_id = "bm_wskn_b92fs_forest_desc"
	self.weapon_skins.b92fs_forest.weapon_id = "b92fs"
	self.weapon_skins.b92fs_forest.reserve_quality = true
	self.weapon_skins.b92fs_forest.rarity = "common"
	self.weapon_skins.b92fs_forest.bonus = "recoil_p1"
	self.weapon_skins.b92fs_forest.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.b92fs_forest.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_003_df")
	self.weapon_skins.m134_forest = {}
	self.weapon_skins.m134_forest.name_id = "bm_wskn_m134_forest"
	self.weapon_skins.m134_forest.desc_id = "bm_wskn_m134_forest_desc"
	self.weapon_skins.m134_forest.weapon_id = "m134"
	self.weapon_skins.m134_forest.reserve_quality = true
	self.weapon_skins.m134_forest.rarity = "common"
	self.weapon_skins.m134_forest.bonus = "spread_p1"
	self.weapon_skins.m134_forest.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.m134_forest.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df")
	self.weapon_skins.m134_forest.parts = {
		wpn_fps_lmg_m134_body = {
			[Idstring("mtr_body"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crimenet_df"),
				pattern_pos = Vector3(0.158836, -0.0701165, 0),
				pattern_tweak = Vector3(3.5917, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_bones_df")
			}
		}
	}
	self.weapon_skins.serbu_camohex = {}
	self.weapon_skins.serbu_camohex.weapon_id = "serbu"
	self.weapon_skins.serbu_camohex.name_id = "bm_wskn_serbu_camohex"
	self.weapon_skins.serbu_camohex.desc_id = "bm_wskn_serbu_camohex_desc"
	self.weapon_skins.serbu_camohex.rarity = "uncommon"
	self.weapon_skins.serbu_camohex.bonus = "spread_n1"
	self.weapon_skins.serbu_camohex.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_002_df")
	self.weapon_skins.serbu_camohex.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.serbu_camohex.reserve_quality = true
	self.weapon_skins.new_m14_camohex = {}
	self.weapon_skins.new_m14_camohex.weapon_id = "new_m14"
	self.weapon_skins.new_m14_camohex.name_id = "bm_wskn_new_m14_camohex"
	self.weapon_skins.new_m14_camohex.desc_id = "bm_wskn_new_m14_camohex_desc"
	self.weapon_skins.new_m14_camohex.rarity = "uncommon"
	self.weapon_skins.new_m14_camohex.bonus = "recoil_p1"
	self.weapon_skins.new_m14_camohex.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_new_m14_df")
	self.weapon_skins.new_m14_camohex.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.new_m14_camohex.reserve_quality = true
	self.weapon_skins.judge_camohex = {}
	self.weapon_skins.judge_camohex.weapon_id = "judge"
	self.weapon_skins.judge_camohex.name_id = "bm_wskn_judge_camohex"
	self.weapon_skins.judge_camohex.desc_id = "bm_wskn_judge_camohex_desc"
	self.weapon_skins.judge_camohex.rarity = "uncommon"
	self.weapon_skins.judge_camohex.bonus = "spread_n1"
	self.weapon_skins.judge_camohex.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_002_df")
	self.weapon_skins.judge_camohex.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.judge_camohex.reserve_quality = true
	self.weapon_skins.mg42_camohex = {}
	self.weapon_skins.mg42_camohex.weapon_id = "mg42"
	self.weapon_skins.mg42_camohex.name_id = "bm_wskn_mg42_camohex"
	self.weapon_skins.mg42_camohex.desc_id = "bm_wskn_mg42_camohex_desc"
	self.weapon_skins.mg42_camohex.rarity = "uncommon"
	self.weapon_skins.mg42_camohex.bonus = "spread_p1"
	self.weapon_skins.mg42_camohex.reserve_quality = true
	self.weapon_skins.mg42_camohex.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.mg42_camohex.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_003_df")
	self.weapon_skins.mg42_camohex.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_001_df")
	self.weapon_skins.mg42_camohex.pattern_tweak = Vector3(0.634393, 2.64684, 0.942682)
	self.weapon_skins.mg42_camohex.parts = {
		wpn_fps_lmg_mg42_reciever = {
			[Idstring("wpn_fps_ass_fal_base_nm"):key()] = {
				pattern_tweak = Vector3(11.8435, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_bones_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_bones_df")
			}
		}
	}
	self.weapon_skins.p90_luxury = {}
	self.weapon_skins.p90_luxury.name_id = "bm_wskn_p90_luxury"
	self.weapon_skins.p90_luxury.desc_id = "bm_wskn_p90_luxury_desc"
	self.weapon_skins.p90_luxury.weapon_id = "p90"
	self.weapon_skins.p90_luxury.reserve_quality = true
	self.weapon_skins.p90_luxury.rarity = "rare"
	self.weapon_skins.p90_luxury.bonus = "concealment_p2"
	self.weapon_skins.p90_luxury.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.p90_luxury.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_tactical_001_df")
	self.weapon_skins.p90_luxury.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_binary_df")
	self.weapon_skins.p90_luxury.parts = {
		wpn_fps_smg_p90_body_p90 = {
			[Idstring("p90"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_hoxton_hacks_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/binary_pattern_df"),
				pattern_pos = Vector3(0.024, 0.014, 0),
				uv_scale = Vector3(5.17317, 5.36387, 1),
				uv_offset_rot = Vector3(-0.337228, 0.927013, 6.22325),
				pattern_tweak = Vector3(6.63141, 0, 1)
			}
		},
		wpn_fps_smg_p90_b_ninja = {
			[Idstring("mtr_ninja"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_hoxton_hacks_df"),
				uv_scale = Vector3(2.21734, 2.21734, 0.804436),
				uv_offset_rot = Vector3(0.0443599, 1.16651, 3.19629)
			}
		}
	}
	self.weapon_skins.p90_luxury.default_blueprint = {
		"wpn_fps_smg_p90_body_p90",
		"wpn_fps_smg_p90_m_std",
		"wpn_fps_smg_p90_b_ninja",
		"wpn_fps_upg_o_eotech"
	}
	self.weapon_skins.ak74_luxury = {}
	self.weapon_skins.ak74_luxury.name_id = "bm_wskn_ak74_luxury"
	self.weapon_skins.ak74_luxury.desc_id = "bm_wskn_ak74_luxury_desc"
	self.weapon_skins.ak74_luxury.weapon_id = "ak74"
	self.weapon_skins.ak74_luxury.reserve_quality = true
	self.weapon_skins.ak74_luxury.rarity = "rare"
	self.weapon_skins.ak74_luxury.bonus = "spread_p1"
	self.weapon_skins.ak74_luxury.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.ak74_luxury.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_002_df")
	self.weapon_skins.ak74_luxury.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_002_df")
	self.weapon_skins.ak74_luxury.parts = {
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_sad_almir_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_dead_birds_df"),
				pattern_pos = Vector3(-0.184593, 0, 0),
				uv_scale = Vector3(4.02898, 4.172, 1),
				uv_offset_rot = Vector3(0.177916, 0.998331, 0.184315),
				pattern_tweak = Vector3(5.49964, 0, 0.33699)
			}
		},
		wpn_fps_ass_74_body_upperreceiver = {
			[Idstring("ak74_dustcover"):key()] = {
				pattern_pos = Vector3(0, 0.0920584, 0),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_dead_birds_df"),
				pattern_tweak = Vector3(3.21011, 0, 1)
			}
		},
		wpn_fps_ass_ak_body_lowerreceiver = {
			[Idstring("ak_base"):key()] = {
				uv_offset_rot = Vector3(0.130217, 0.931553, 0.0944058),
				pattern_pos = Vector3(0.0348201, 0, 0),
				uv_scale = Vector3(14.8511, 14.6128, 0),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_dead_birds_df"),
				pattern_tweak = Vector3(4.78417, 0, 1)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_sad_almir_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_dead_birds_df"),
				pattern_tweak = Vector3(7.78917, 0, 1),
				uv_scale = Vector3(7.99564, 7.98598, 1),
				uv_offset_rot = Vector3(-0.371387, 0.578663, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_binary_df")
			}
		}
	}
	self.weapon_skins.ak74_luxury.default_blueprint = {
		"wpn_fps_ass_74_body_upperreceiver",
		"wpn_fps_ass_ak_body_lowerreceiver",
		"wpn_fps_upg_ak_b_ak105",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ak_fg_trax",
		"wpn_fps_upg_ak_g_pgrip",
		"wpn_fps_upg_ak_m_quad",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_o_ak_scopemount"
	}
	self.weapon_skins.ppk_luxury = {}
	self.weapon_skins.ppk_luxury.name_id = "bm_wskn_ppk_luxury"
	self.weapon_skins.ppk_luxury.desc_id = "bm_wskn_ppk_luxury_desc"
	self.weapon_skins.ppk_luxury.weapon_id = "ppk"
	self.weapon_skins.ppk_luxury.reserve_quality = true
	self.weapon_skins.ppk_luxury.rarity = "rare"
	self.weapon_skins.ppk_luxury.bonus = "recoil_p1"
	self.weapon_skins.ppk_luxury.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.ppk_luxury.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_003_df")
	self.weapon_skins.ppk_luxury.parts = {
		wpn_fps_pis_ppk_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				pattern_tweak = Vector3(2.59003, 0, 1)
			}
		},
		wpn_fps_pis_ppk_body_standard = {
			[Idstring("mtr_frame"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_cloaker_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/dungeon_pattern_df"),
				pattern_tweak = Vector3(3.5917, 0, 0.410923),
				uv_scale = Vector3(1.69292, 1.97897, 0.148581),
				uv_offset_rot = Vector3(0.0423599, 1.02295, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_new_004_df")
			}
		},
		wpn_fps_pis_ppk_b_standard = {
			[Idstring("mtr_slide"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_cloaker_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/dungeon_pattern_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_new_004_df"),
				uv_scale = Vector3(1.74059, 2.12199, 0.141426),
				uv_offset_rot = Vector3(-0.022418, 0.874315, 0),
				pattern_tweak = Vector3(2.97162, 0, 0.623182)
			},
			[Idstring("mtr_barrel"):key()] = {
				uv_scale = Vector3(1.31152, 1.50222, 1),
				uv_offset_rot = Vector3(-0.222752, 1.12235, 0),
				pattern_tweak = Vector3(2.25614, 0, 1)
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				pattern_pos = Vector3(0, -0.00333858, 0),
				uv_scale = Vector3(1.12082, 2.31269, 0.363224),
				uv_offset_rot = Vector3(0.0634394, 0.864775, 0)
			}
		},
		wpn_fps_pis_ppk_b_long = {
			[Idstring("mtr_slide_long"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_cloaker_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/dungeon_pattern_df"),
				base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_005_df"),
				uv_offset_rot = Vector3(-0.022418, 0.902934, 0),
				pattern_pos = Vector3(0, -0.0987357, 0),
				uv_scale = Vector3(1.50222, 1.74059, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_new_004_df"),
				pattern_tweak = Vector3(2.73313, 0, 1)
			}
		}
	}
	self.weapon_skins.ppk_luxury.default_blueprint = {
		"wpn_fps_pis_ppk_body_standard",
		"wpn_fps_pis_ppk_m_standard",
		"wpn_fps_pis_ppk_b_long",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_pis_ppk_g_laser"
	}
	self.weapon_skins.plainsrider_linked = {}
	self.weapon_skins.plainsrider_linked.name_id = "bm_wskn_plainsrider_linked"
	self.weapon_skins.plainsrider_linked.desc_id = "bm_wskn_plainsrider_linked_desc"
	self.weapon_skins.plainsrider_linked.weapon_id = "plainsrider"
	self.weapon_skins.plainsrider_linked.rarity = "epic"
	self.weapon_skins.plainsrider_linked.bonus = "total_ammo_p3"
	self.weapon_skins.plainsrider_linked.reserve_quality = true
	self.weapon_skins.plainsrider_linked.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.plainsrider_linked.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_005_df")
	self.weapon_skins.plainsrider_linked.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_005_df")
	self.weapon_skins.plainsrider_linked.pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_waves_df")
	self.weapon_skins.plainsrider_linked.sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_thebomb_df")
	self.weapon_skins.plainsrider_linked.pattern_tweak = Vector3(8.55235, 0, 1)
	self.weapon_skins.plainsrider_linked.pattern_pos = Vector3(0.058, 0.036, 0)
	self.weapon_skins.plainsrider_linked.uv_scale = Vector3(20, 20, 1)
	self.weapon_skins.plainsrider_linked.uv_offset_rot = Vector3(-0.037418, 1.21774, 0)
	self.weapon_skins.plainsrider_linked.default_blueprint = {
		"wpn_fps_bow_plainsrider_b_standard",
		"wpn_fps_bow_plainsrider_body_standard",
		"wpn_fps_upg_a_bow_explosion"
	}
	self.weapon_skins.new_m4_payday = {}
	self.weapon_skins.new_m4_payday.name_id = "bm_wskn_new_m4_payday"
	self.weapon_skins.new_m4_payday.desc_id = "bm_wskn_new_m4_payday_desc"
	self.weapon_skins.new_m4_payday.weapon_id = "new_m4"
	self.weapon_skins.new_m4_payday.reserve_quality = true
	self.weapon_skins.new_m4_payday.rarity = "epic"
	self.weapon_skins.new_m4_payday.bonus = "spread_p1"
	self.weapon_skins.new_m4_payday.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.new_m4_payday.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_002_df")
	self.weapon_skins.new_m4_payday.pattern_tweak = Vector3(0.968283, 0, 1)
	self.weapon_skins.new_m4_payday.pattern_pos = Vector3(0.187455, -0.0510372, 0)
	self.weapon_skins.new_m4_payday.parts = {
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_pixel_safe_df"),
				uv_offset_rot = Vector3(0.216075, 1.18912, 3.36112),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df"),
				uv_scale = Vector3(5.84062, 6.17434, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crackled_ground_df"),
				pattern_tweak = Vector3(0.72979, 0, 1)
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crackled_ground_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df"),
				pattern_tweak = Vector3(0.538996, 0, 1)
			}
		},
		wpn_fps_ass_l85a2_m_emag = {
			[Idstring("mtr_emag"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_pixel_safe_df"),
				uv_offset_rot = Vector3(-0.179133, 0.673981, 5.98349),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df"),
				uv_scale = Vector3(2.78944, 2.98014, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crackled_ground_df"),
				pattern_tweak = Vector3(0.443599, 0, 1)
			}
		},
		wpn_fps_m4_lower_reciever = {
			[Idstring("m4_lower_reciever"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_pixel_safe_df"),
				uv_offset_rot = Vector3(0.243773, 0.731219, 0.109391),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df"),
				pattern_pos = Vector3(0, -0.318149, 0),
				uv_scale = Vector3(3.36153, 4.02898, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crackled_ground_df"),
				pattern_tweak = Vector3(0.682091, 0, 1)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_pixel_safe_df"),
				uv_offset_rot = Vector3(0.33471, 0.954712, 6.0734),
				uv_scale = Vector3(7.69993, 7.98598, 1),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crackled_ground_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df")
			}
		},
		wpn_fps_upg_ass_m4_fg_moe = {
			[Idstring("mtr_moe"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_pixel_safe_df"),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_crackled_ground_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_001_df"),
				uv_scale = Vector3(6.12667, 6.55574, 0),
				uv_offset_rot = Vector3(0.265233, 0.880774, 6.2682),
				pattern_tweak = Vector3(0.920584, 0, 1)
			}
		}
	}
	self.weapon_skins.new_m4_payday.default_blueprint = {
		"wpn_fps_m4_uupg_draghandle",
		"wpn_fps_upg_m4_s_ubr",
		"wpn_fps_upg_ass_m4_fg_moe",
		"wpn_fps_m4_uupg_b_long",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_m4_lower_reciever",
		"wpn_fps_ass_l85a2_m_emag",
		"wpn_fps_upg_o_acog",
		"wpn_fps_upg_ass_m4_upper_reciever_ballos"
	}
	self.weapon_skins.deagle_bling = {}
	self.weapon_skins.deagle_bling.name_id = "bm_wskn_deagle_bling"
	self.weapon_skins.deagle_bling.desc_id = "bm_wskn_deagle_bling_desc"
	self.weapon_skins.deagle_bling.weapon_id = "deagle"
	self.weapon_skins.deagle_bling.rarity = "legendary"
	self.weapon_skins.deagle_bling.bonus = "recoil_p2"
	self.weapon_skins.deagle_bling.reserve_quality = true
	self.weapon_skins.deagle_bling.texture_bundle_folder = "cash/safes/cf15"
	self.weapon_skins.deagle_bling.unique_name_id = "bm_wskn_deagle_bling"
	self.weapon_skins.deagle_bling.locked = true
	self.weapon_skins.deagle_bling.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_004_df")
	self.weapon_skins.deagle_bling.default_blueprint = {
		"wpn_fps_pis_deagle_body_standard",
		"wpn_fps_pis_deagle_m_standard",
		"wpn_fps_pis_deagle_b_legend",
		"wpn_fps_pis_deagle_g_ergo",
		"wpn_fps_upg_o_rmr"
	}
	self.weapon_skins.deagle_bling.parts = {
		wpn_fps_pis_deagle_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_tactical_001_df")
			},
			[Idstring("grip"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_goldcoins_df"),
				pattern_tweak = Vector3(4.54567, 0, 1),
				uv_scale = Vector3(2.64641, 2.64641, 1),
				uv_offset_rot = Vector3(-0.170117, 1.01187, 4.70977),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_005_df")
			}
		},
		wpn_fps_pis_deagle_b_legend = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df"),
				uv_offset_rot = Vector3(0.244694, 1.07465, 0),
				pattern_pos = Vector3(0.005, 0.769457, 0),
				uv_scale = Vector3(3.45688, 3.93363, 1),
				pattern_tweak = Vector3(0.641791, 0, 0)
			},
			[Idstring("mtr_legendcomp"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/fire_pattern_df"),
				pattern_tweak = Vector3(0.200805, 4.71977, 0),
				pattern_pos = Vector3(0.530885, 1.03795, 0),
				uv_scale = Vector3(2.07432, 2.21734, 1),
				uv_offset_rot = Vector3(-0.0128784, 0.712139, 4.72674),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_gold_df")
			}
		},
		wpn_fps_pis_deagle_b_standard = {
			[Idstring("barrel"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df"),
				pattern_pos = Vector3(0.0443599, -0.0128784, 0),
				cubemap_pattern_control = Vector3(0, 5, 0),
				pattern_tweak = Vector3(0.825187, 0, 1)
			}
		},
		wpn_fps_pis_deagle_body_standard = {
			[Idstring("base"):key()] = {
				pattern_tweak = Vector3(0.292202, 0, 0),
				pattern = Idstring("units/payday2_cash/safes/cf15/pattern/fire_pattern_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_gold_df")
			}
		},
		wpn_fps_pis_deagle_co_short = {
			[Idstring("comp2"):key()] = {
				cubemap_pattern_control = Vector3(0, 5, 0),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df"),
				pattern_tweak = Vector3(1, 0, 1.06511)
			}
		}
	}
	self.weapon_skins.new_m4_skullimov = {}
	self.weapon_skins.new_m4_skullimov.name_id = "bm_wskn_new_m4_skullimov"
	self.weapon_skins.new_m4_skullimov.desc_id = "bm_wskn_new_m4_skullimov_desc"
	self.weapon_skins.new_m4_skullimov.weapon_id = "new_m4"
	self.weapon_skins.new_m4_skullimov.reserve_quality = true
	self.weapon_skins.new_m4_skullimov.rarity = "rare"
	self.weapon_skins.new_m4_skullimov.bonus = "spread_p1_tem_p1"
	self.weapon_skins.new_m4_skullimov.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.new_m4_skullimov.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_ferrar_df")
	self.weapon_skins.new_m4_skullimov.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_zebrafade_df")
	self.weapon_skins.new_m4_skullimov.pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df")
	self.weapon_skins.new_m4_skullimov.sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_zebra_df")
	self.weapon_skins.new_m4_skullimov.pattern_tweak = Vector3(0.252805, 0, 0)
	self.weapon_skins.new_m4_skullimov.pattern_pos = Vector3(0.645361, 0, 0)
	self.weapon_skins.new_m4_skullimov.uv_scale = Vector3(0.405702, 0.405702, 1)
	self.weapon_skins.new_m4_skullimov.uv_offset_rot = Vector3(0, 0, 2.23725)
	self.weapon_skins.new_m4_skullimov.cubemap_pattern_control = Vector3(0, 1, 0)
	self.weapon_skins.new_m4_skullimov.default_blueprint = {
		"wpn_fps_m4_lower_reciever",
		"wpn_fps_m4_uupg_draghandle",
		"wpn_fps_upg_ass_m4_fg_moe",
		"wpn_fps_ass_l85a2_m_emag",
		"wpn_fps_m4_uupg_b_short",
		"wpn_fps_upg_ass_m4_upper_reciever_ballos",
		"wpn_fps_upg_m4_s_ubr",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_o_acog",
		"wpn_fps_upg_m4_g_hgrip"
	}
	self.weapon_skins.new_m4_skullimov.parts = {
		wpn_fps_upg_ass_m4_fg_moe = {
			[Idstring("mtr_moe"):key()] = {
				pattern_pos = Vector3(-0.194133, 0.00620103, 0),
				pattern_tweak = Vector3(0.3959, 0, 1)
			}
		},
		wpn_fps_upg_ass_m4_upper_reciever_ballos = {
			[Idstring("mtr_balios"):key()] = {
				pattern_pos = Vector3(0.492726, 0, 0)
			}
		},
		wpn_fps_upg_m4_g_hgrip = {
			[Idstring("mtr_hogue"):key()] = {
				pattern_pos = Vector3(0.301932, 0, 0)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				pattern_pos = Vector3(1.36084, 2, 0)
			}
		},
		wpn_fps_m4_uupg_b_short = {
			[Idstring("m4_barrel"):key()] = {
				pattern_pos = Vector3(-0.900071, 0, 0)
			}
		},
		wpn_fps_upg_m4_s_adapter = {
			[Idstring("stock_adapter"):key()] = {
				pattern_pos = Vector3(0.912473, 0.263773, 0)
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				pattern_pos = Vector3(-2, 0, 0)
			}
		},
		wpn_fps_upg_m4_s_standard_vanilla = {
			[Idstring("stock_standard"):key()] = {
				pattern_pos = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				pattern_pos = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				pattern_pos = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_ubr"):key()] = {
				pattern_pos = Vector3(2, 2, 0)
			}
		}
	}
	self.weapon_skins.deagle_skullimov = {}
	self.weapon_skins.deagle_skullimov.name_id = "bm_wskn_deagle_skullimov"
	self.weapon_skins.deagle_skullimov.desc_id = "bm_wskn_deagle_skullimov_desc"
	self.weapon_skins.deagle_skullimov.weapon_id = "deagle"
	self.weapon_skins.deagle_skullimov.reserve_quality = true
	self.weapon_skins.deagle_skullimov.rarity = "rare"
	self.weapon_skins.deagle_skullimov.bonus = "recoil_p1_tem_p1"
	self.weapon_skins.deagle_skullimov.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.deagle_skullimov.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_007_df")
	self.weapon_skins.deagle_skullimov.parts = {
		wpn_fps_pis_deagle_g_ergo = {
			[Idstring("grip"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_boom_df"),
				uv_scale = Vector3(1.64524, 1.50222, 1),
				uv_offset_rot = Vector3(-0.191434, 1.02241, 4.96451)
			}
		},
		wpn_fps_pis_deagle_co_long = {
			[Idstring("comp1"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_boom_df"),
				uv_scale = Vector3(1.45455, 1.02547, 1),
				uv_offset_rot = Vector3(-0.528023, 0.883854, 0)
			}
		},
		wpn_fps_pis_deagle_b_standard = {
			[Idstring("barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_boom_df"),
				uv_scale = Vector3(1.59757, 1.1685, 1),
				uv_offset_rot = Vector3(0.0348201, 0.883854, 0.033)
			}
		},
		wpn_fps_pis_deagle_body_standard = {
			[Idstring("base"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_boom_df"),
				uv_offset_rot = Vector3(0.218075, 0.928013, 0),
				uv_scale = Vector3(2.88479, 2.12399, 1)
			}
		},
		wpn_fps_pis_deagle_m_extended = {
			[Idstring("extended_mag"):key()] = {
				uv_scale = Vector3(2.59874, 2.55106, 1),
				uv_offset_rot = Vector3(-0.203673, 0.807537, 0)
			}
		}
	}
	self.weapon_skins.deagle_skullimov.default_blueprint = {
		"wpn_fps_pis_deagle_body_standard",
		"wpn_fps_pis_deagle_b_standard",
		"wpn_fps_pis_deagle_co_long",
		"wpn_fps_pis_deagle_m_extended",
		"wpn_fps_pis_deagle_g_ergo",
		"wpn_fps_pis_deagle_extra",
		"wpn_upg_o_marksmansight_rear"
	}
	self.weapon_skins.p90_skullimov = {}
	self.weapon_skins.p90_skullimov.name_id = "bm_wskn_p90_skullimov"
	self.weapon_skins.p90_skullimov.desc_id = "bm_wskn_p90_skullimov_desc"
	self.weapon_skins.p90_skullimov.weapon_id = "p90"
	self.weapon_skins.p90_skullimov.reserve_quality = true
	self.weapon_skins.p90_skullimov.rarity = "rare"
	self.weapon_skins.p90_skullimov.bonus = "spread_p1_tem_p1"
	self.weapon_skins.p90_skullimov.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.p90_skullimov.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.p90_skullimov.uv_scale = Vector3(1.21617, 1.1685, 0)
	self.weapon_skins.p90_skullimov.uv_offset_rot = Vector3(-0.00333858, 0.836156, 0)
	self.weapon_skins.p90_skullimov.cubemap_pattern_control = Vector3(0, 0.0484141, 0)
	self.weapon_skins.p90_skullimov.parts = {
		wpn_fps_smg_p90_body_p90 = {
			[Idstring("p90"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_overkill_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df"),
				uv_offset_rot = Vector3(-0.346768, 0.969712, 5.11436),
				pattern_pos = Vector3(0.216075, -0.566182, 0),
				uv_scale = Vector3(2.21734, 2.16967, 0.389459),
				pattern_tweak = Vector3(0.491297, 5.45901, 1)
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				pattern_pos = Vector3(0, -0.194133, 0),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df"),
				pattern_tweak = Vector3(0.348202, 5.56391, 1)
			}
		}
	}
	self.weapon_skins.p90_skullimov.default_blueprint = {
		"wpn_fps_smg_p90_body_p90",
		"wpn_fps_smg_p90_m_std",
		"wpn_fps_smg_p90_b_long",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_ass_ns_jprifles"
	}
	self.weapon_skins.plainsrider_skullimov = {}
	self.weapon_skins.plainsrider_skullimov.name_id = "bm_wskn_plainsrider_skullimov"
	self.weapon_skins.plainsrider_skullimov.desc_id = "bm_wskn_plainsrider_skullimov_desc"
	self.weapon_skins.plainsrider_skullimov.weapon_id = "plainsrider"
	self.weapon_skins.plainsrider_skullimov.reserve_quality = true
	self.weapon_skins.plainsrider_skullimov.rarity = "rare"
	self.weapon_skins.plainsrider_skullimov.bonus = "total_ammo_p3_tem_p1"
	self.weapon_skins.plainsrider_skullimov.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.plainsrider_skullimov.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_004_df")
	self.weapon_skins.plainsrider_skullimov.uv_scale = Vector3(1.21617, 1.1685, 1)
	self.weapon_skins.plainsrider_skullimov.uv_offset_rot = Vector3(-0.00333858, 0.836156, 0)
	self.weapon_skins.plainsrider_skullimov.parts = {
		wpn_fps_bow_plainsrider_body_standard = {
			[Idstring("mtr_bow"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_headshot_skull_df"),
				uv_offset_rot = Vector3(-0.015418, 1.05057, 1.02347),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df"),
				pattern_pos = Vector3(0.540425, 0, 0),
				uv_scale = Vector3(19.995, 15.4709, 0.270212),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df"),
				pattern_tweak = Vector3(3.21011, 1.57791, 1)
			}
		}
	}
	self.weapon_skins.plainsrider_skullimov.default_blueprint = {
		"wpn_fps_bow_plainsrider_b_standard",
		"wpn_fps_bow_plainsrider_body_standard",
		"wpn_fps_bow_plainsrider_m_standard"
	}
	self.weapon_skins.m95_bombmatta = {}
	self.weapon_skins.m95_bombmatta.weapon_id = "m95"
	self.weapon_skins.m95_bombmatta.rarity = "rare"
	self.weapon_skins.m95_bombmatta.bonus = "total_ammo_p1_tem_p1"
	self.weapon_skins.m95_bombmatta.name_id = "bm_wskn_m95_bombmatta"
	self.weapon_skins.m95_bombmatta.desc_id = "bm_wskn_m95_bombmatta_desc"
	self.weapon_skins.m95_bombmatta.reserve_quality = true
	self.weapon_skins.m95_bombmatta.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.m95_bombmatta.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df")
	self.weapon_skins.m95_bombmatta.pattern_tweak = Vector3(1.3439, 0, 1.04841)
	self.weapon_skins.m95_bombmatta.uv_scale = Vector3(1.14466, 7.10995, 1)
	self.weapon_skins.m95_bombmatta.uv_offset_rot = Vector3(-0.245409, 0.931552, 0)
	self.weapon_skins.m95_bombmatta.cubemap_pattern_control = Vector3(0.01, 0.01, 0)
	self.weapon_skins.m95_bombmatta.parts = {
		wpn_fps_snp_m95_upper_reciever = {
			[Idstring("mtr_upper"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_blurred_df"),
				pattern_pos = Vector3(0.979251, 0.0920584, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_002_df"),
				pattern_tweak = Vector3(4.68877, 0, 1)
			},
			[Idstring("mtr_pin"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_blurred_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_002_df")
			}
		},
		wpn_fps_upg_o_leupold = {
			[Idstring("leupold"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_002_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_blurred_df"),
				pattern_tweak = Vector3(3.92559, 0, 1)
			}
		},
		wpn_fps_snp_m95_barrel_suppressed = {
			[Idstring("mtr_suppressed"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_hypetrain_df"),
				uv_offset_rot = Vector3(0.0634394, 0.941092, 0),
				uv_scale = Vector3(1.93129, 2.98014, 0),
				pattern_tweak = Vector3(1.63606, 0, 1)
			}
		},
		wpn_fps_snp_m95_lower_reciever = {
			[Idstring("mtr_lower"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_blurred_df"),
				pattern_pos = Vector3(-0.0319577, 0.216075, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_002_df"),
				pattern_tweak = Vector3(4.87956, 0, 1)
			}
		},
		wpn_fps_snp_m95_bipod = {
			[Idstring("mtr_bipod"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_blurred_df"),
				pattern_pos = Vector3(-0.0510372, 0.072979, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_002_df"),
				pattern_tweak = Vector3(1.54067, 0, 1)
			}
		}
	}
	self.weapon_skins.m95_bombmatta.default_blueprint = {
		"wpn_fps_snp_m95_bipod",
		"wpn_fps_snp_m95_lower_reciever",
		"wpn_fps_snp_m95_upper_reciever",
		"wpn_fps_snp_m95_magazine",
		"wpn_fps_upg_o_leupold",
		"wpn_fps_snp_m95_barrel_suppressed",
		"wpn_fps_upg_m4_g_sniper"
	}
	self.weapon_skins.huntsman_bloodsplat = {}
	self.weapon_skins.huntsman_bloodsplat.name_id = "bm_wskn_huntsman_bloodsplat"
	self.weapon_skins.huntsman_bloodsplat.desc_id = "bm_wskn_huntsman_bloodsplat_desc"
	self.weapon_skins.huntsman_bloodsplat.weapon_id = "huntsman"
	self.weapon_skins.huntsman_bloodsplat.reserve_quality = true
	self.weapon_skins.huntsman_bloodsplat.rarity = "rare"
	self.weapon_skins.huntsman_bloodsplat.bonus = "spread_n1_tem_p1"
	self.weapon_skins.huntsman_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.huntsman_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.huntsman_bloodsplat.pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df")
	self.weapon_skins.huntsman_bloodsplat.pattern_tweak = Vector3(2.25614, 1.45804, 2)
	self.weapon_skins.huntsman_bloodsplat.uv_offset_rot = Vector3(0.607203, 0.979251, 3.03145)
	self.weapon_skins.huntsman_bloodsplat.parts = {
		wpn_fps_shot_huntsman_b_short = {
			[Idstring("slug"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_002_df")
			},
			[Idstring("short_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_angrybomb_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hex_001_df"),
				pattern_pos = Vector3(-0.022418, -0.0796564, 0),
				uv_scale = Vector3(1.45455, 1.78827, 0.780587),
				uv_offset_rot = Vector3(0.139757, 0.998331, 4.66481),
				pattern_tweak = Vector3(0.72979, 0, 1)
			}
		},
		wpn_fps_shot_huntsman_b_long = {
			[Idstring("long_barrel"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hex_001_df"),
				pattern_pos = Vector3(0, -1.66517, 0),
				pattern_tweak = Vector3(3.87489, 0.169331, 1)
			}
		},
		wpn_fps_shot_huntsman_s_short = {
			[Idstring("short_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_angrybomb_df"),
				uv_offset_rot = Vector3(-0.0281166, 1.04149, 4.61986),
				uv_scale = Vector3(6.46039, 7.27086, 1),
				pattern_tweak = Vector3(0.872886, 0, 1)
			}
		}
	}
	self.weapon_skins.huntsman_bloodsplat.default_blueprint = {
		"wpn_fps_shot_huntsman_body_standard",
		"wpn_fps_shot_huntsman_b_short",
		"wpn_fps_shot_huntsman_s_short"
	}
	self.weapon_skins.r93_bloodsplat = {}
	self.weapon_skins.r93_bloodsplat.name_id = "bm_wskn_r93_bloodsplat"
	self.weapon_skins.r93_bloodsplat.desc_id = "bm_wskn_r93_bloodsplat_desc"
	self.weapon_skins.r93_bloodsplat.weapon_id = "r93"
	self.weapon_skins.r93_bloodsplat.reserve_quality = true
	self.weapon_skins.r93_bloodsplat.rarity = "rare"
	self.weapon_skins.r93_bloodsplat.bonus = "recoil_p1_tem_p1"
	self.weapon_skins.r93_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.r93_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_007_df")
	self.weapon_skins.r93_bloodsplat.parts = {
		wpn_fps_snp_r93_body_wood = {
			[Idstring("mtr_wooden"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_shark_df"),
				uv_scale = Vector3(3.79061, 4.88712, 0.549249),
				uv_offset_rot = Vector3(0.110598, 0.950632, 0.0194812)
			},
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_shark_df"),
				uv_offset_rot = Vector3(-0.30807, 1.42808, 3.2862),
				pattern_pos = Vector3(0, 0.597663, 0),
				uv_scale = Vector3(1.50222, 2.07432, 0.0388744),
				cubemap_pattern_control = Vector3(0, 0.011, 0)
			}
		}
	}
	self.weapon_skins.r93_bloodsplat.default_blueprint = {
		"wpn_fps_snp_r93_b_standard",
		"wpn_fps_snp_r93_m_std",
		"wpn_fps_snp_r93_body_wood",
		"wpn_fps_upg_o_leupold"
	}
	self.weapon_skins.judge_wooh = {}
	self.weapon_skins.judge_wooh.name_id = "bm_wskn_judge_wooh"
	self.weapon_skins.judge_wooh.desc_id = "bm_wskn_judge_wooh_desc"
	self.weapon_skins.judge_wooh.weapon_id = "judge"
	self.weapon_skins.judge_wooh.reserve_quality = true
	self.weapon_skins.judge_wooh.rarity = "rare"
	self.weapon_skins.judge_wooh.bonus = "spread_p1_tem_p1"
	self.weapon_skins.judge_wooh.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.judge_wooh.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_checker_df")
	self.weapon_skins.judge_wooh.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_checker_df")
	self.weapon_skins.judge_wooh.pattern_tweak = Vector3(0.272407, 0, 0)
	self.weapon_skins.judge_wooh.pattern_pos = Vector3(-1.88266, -1.30628, 0)
	self.weapon_skins.judge_wooh.cubemap_pattern_control = Vector3(0.883139, 1, 0)
	self.weapon_skins.judge_wooh.default_blueprint = {
		"wpn_fps_pis_judge_body_standard",
		"wpn_fps_pis_judge_b_standard",
		"wpn_fps_pis_judge_g_standard",
		"wpn_fps_upg_a_explosive",
		"wpn_fps_upg_shot_ns_king"
	}
	self.weapon_skins.judge_wooh.parts = {
		wpn_fps_pis_judge_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_004_df"),
				uv_offset_rot = Vector3(-0.384927, 1.00787, 4.88959),
				pattern_pos = Vector3(0.005, 0.027, 0),
				uv_scale = Vector3(1.78827, 1.74059, 0.773432),
				pattern_tweak = Vector3(0.748188, 0.364135, 1)
			}
		},
		wpn_fps_upg_shot_ns_king = {
			[Idstring("mtr_king"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bloodsplat_df"),
				uv_offset_rot = Vector3(1.16051, 1.26544, 0),
				uv_scale = Vector3(0.374378, 0.374703, 0.787741),
				pattern_tweak = Vector3(2.25614, 0, 1)
			}
		},
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_mech"):key()] = {
				uv_offset_rot = Vector3(-0.241831, 1.13189, 0)
			},
			[Idstring("mtr_cylinder"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bloodsplat_df"),
				uv_offset_rot = Vector3(0.950632, 1.12235, 0.723773),
				uv_scale = Vector3(0.453377, 0.501052, 0.82113),
				pattern_tweak = Vector3(0.300503, 0, 1)
			},
			[Idstring("mtr_frame"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bloodsplat_df"),
				uv_offset_rot = Vector3(0.597663, 1.04603, 0),
				uv_scale = Vector3(0.7871, 0.7871, 0.618412),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_checker_001_df"),
				pattern_tweak = Vector3(1.73146, 0, 1)
			}
		}
	}
	self.weapon_skins.b92fs_bloodsplat = {}
	self.weapon_skins.b92fs_bloodsplat.name_id = "bm_wskn_b92fs_bloodsplat"
	self.weapon_skins.b92fs_bloodsplat.desc_id = "bm_wskn_b92fs_bloodsplat_desc"
	self.weapon_skins.b92fs_bloodsplat.weapon_id = "b92fs"
	self.weapon_skins.b92fs_bloodsplat.reserve_quality = true
	self.weapon_skins.b92fs_bloodsplat.rarity = "rare"
	self.weapon_skins.b92fs_bloodsplat.bonus = "spread_p1_tem_p1"
	self.weapon_skins.b92fs_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.b92fs_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_008_df")
	self.weapon_skins.b92fs_bloodsplat.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_smoker_df")
	self.weapon_skins.b92fs_bloodsplat.pattern_tweak = Vector3(2.44694, 1.45804, 2)
	self.weapon_skins.b92fs_bloodsplat.uv_offset_rot = Vector3(0.607203, 0.979251, 3.03145)
	self.weapon_skins.b92fs_bloodsplat.parts = {
		wpn_fps_pis_beretta_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_8ball_df"),
				uv_offset_rot = Vector3(-7.98971E-4, 0.855235, 5.98349),
				pattern_pos = Vector3(-0.117815, -0.0414975, 0),
				uv_scale = Vector3(6.88946, 7.12783, 1),
				pattern_tweak = Vector3(2.25614, 1.96752, 1)
			}
		},
		wpn_fps_pis_beretta_g_std = {
			[Idstring("std_grips"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_005_df")
			}
		},
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				pattern_pos = Vector3(0.290074, -0.34637, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_psybilly_df"),
				pattern_tweak = Vector3(3.16242, 0.553073, 1)
			}
		},
		wpn_fps_pis_beretta_body_beretta = {
			[Idstring("body"):key()] = {
				pattern_pos = Vector3(0.261836, -0.0184975, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_psybilly_df"),
				pattern_tweak = Vector3(4.45028, 1.36813, 1)
			}
		},
		wpn_fps_pis_beretta_o_std = {
			[Idstring("std_sight"):key()] = {
				pattern_tweak = Vector3(1.82686, 0, 1)
			}
		},
		wpn_fps_pis_beretta_m_extended = {
			[Idstring("extd"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_8ball_df"),
				uv_offset_rot = Vector3(-0.0641165, 1.38346, 1.15834),
				uv_scale = Vector3(11.5616, 11.5616, 1),
				pattern_tweak = Vector3(5.49964, 0, 1)
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_8ball_df"),
				uv_offset_rot = Vector3(0.348471, 1.00787, 4.0804),
				uv_scale = Vector3(4.50573, 4.50573, 1),
				pattern_tweak = Vector3(2.06535, 0.439059, 1)
			}
		}
	}
	self.weapon_skins.b92fs_bloodsplat.default_blueprint = {
		"wpn_fps_pis_beretta_body_beretta",
		"wpn_fps_pis_beretta_b_std",
		"wpn_fps_pis_beretta_sl_brigadier",
		"wpn_fps_pis_beretta_m_extended",
		"wpn_fps_pis_beretta_g_engraved",
		"wpn_fps_upg_ns_pis_jungle",
		"wpn_fps_pis_beretta_o_std"
	}
	self.weapon_skins.mg42_bloodsplat = {}
	self.weapon_skins.mg42_bloodsplat.name_id = "bm_wskn_mg42_bloodsplat"
	self.weapon_skins.mg42_bloodsplat.desc_id = "bm_wskn_mg42_bloodsplat_desc"
	self.weapon_skins.mg42_bloodsplat.weapon_id = "mg42"
	self.weapon_skins.mg42_bloodsplat.reserve_quality = true
	self.weapon_skins.mg42_bloodsplat.rarity = "rare"
	self.weapon_skins.mg42_bloodsplat.bonus = "spread_p1_tem_p1"
	self.weapon_skins.mg42_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.mg42_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_006_df")
	self.weapon_skins.mg42_bloodsplat.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_008_df")
	self.weapon_skins.mg42_bloodsplat.pattern_tweak = Vector3(5.26115, 1.11338, 2)
	self.weapon_skins.mg42_bloodsplat.uv_offset_rot = Vector3(0.607203, 0.979251, 3.03145)
	self.weapon_skins.mg42_bloodsplat.parts = {
		wpn_fps_lmg_mg42_b_mg34 = {
			[Idstring("wpn_fps_ass_fal_barrel_mg34_nm"):key()] = {
				pattern_tweak = Vector3(12.3682, 0, 1)
			}
		},
		wpn_fps_lmg_mg42_reciever = {
			[Idstring("wpn_fps_ass_fal_base_nm"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_burning_skull_df"),
				uv_offset_rot = Vector3(0.0422805, 0.721679, 5.32415),
				pattern_pos = Vector3(0, -0.006, 0),
				uv_scale = Vector3(8.84412, 9.0825, 0.282137),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_rockabilly_df"),
				pattern_tweak = Vector3(13.9423, 0.006, 0.997)
			}
		}
	}
	self.weapon_skins.mg42_bloodsplat.default_blueprint = {
		"wpn_fps_lmg_mg42_n42",
		"wpn_fps_lmg_mg42_reciever",
		"wpn_fps_lmg_mg42_b_mg34"
	}
	self.weapon_skins.m134_bloodsplat = {}
	self.weapon_skins.m134_bloodsplat.name_id = "bm_wskn_m134_bloodsplat"
	self.weapon_skins.m134_bloodsplat.desc_id = "bm_wskn_m134_bloodsplat_desc"
	self.weapon_skins.m134_bloodsplat.weapon_id = "m134"
	self.weapon_skins.m134_bloodsplat.reserve_quality = true
	self.weapon_skins.m134_bloodsplat.rarity = "rare"
	self.weapon_skins.m134_bloodsplat.bonus = "spread_p1_tem_p1"
	self.weapon_skins.m134_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.m134_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.m134_bloodsplat.parts = {
		wpn_fps_lmg_m134_body = {
			[Idstring("mtr_body"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_rosered_df"),
				pattern_pos = Vector3(0.101598, 0.0252805, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_008_df"),
				pattern_tweak = Vector3(8.12306, 0, 1)
			}
		},
		wpn_fps_lmg_m134_body_upper = {
			[Idstring("mtr_handle"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_dabomb_df"),
				uv_scale = Vector3(11.2755, 11.2279, 0),
				uv_offset_rot = Vector3(0.123217, 1.03649, 1.57791)
			}
		}
	}
	self.weapon_skins.m134_bloodsplat.default_blueprint = {
		"wpn_fps_lmg_m134_body",
		"wpn_fps_lmg_m134_body_upper",
		"wpn_fps_lmg_m134_m_standard",
		"wpn_fps_lmg_m134_barrel_extreme"
	}
	self.weapon_skins.flamethrower_mk2_bloodsplat = {}
	self.weapon_skins.flamethrower_mk2_bloodsplat.name_id = "bm_wskn_flamethrower_mk2_bloodsplat"
	self.weapon_skins.flamethrower_mk2_bloodsplat.desc_id = "bm_wskn_flamethrower_mk2_bloodsplat_desc"
	self.weapon_skins.flamethrower_mk2_bloodsplat.weapon_id = "flamethrower_mk2"
	self.weapon_skins.flamethrower_mk2_bloodsplat.reserve_quality = true
	self.weapon_skins.flamethrower_mk2_bloodsplat.rarity = "rare"
	self.weapon_skins.flamethrower_mk2_bloodsplat.bonus = "damage_p1_tem_p1"
	self.weapon_skins.flamethrower_mk2_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.flamethrower_mk2_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_008_df")
	self.weapon_skins.flamethrower_mk2_bloodsplat.pattern_tweak = Vector3(2.25614, 1.45804, 2)
	self.weapon_skins.flamethrower_mk2_bloodsplat.uv_scale = Vector3(1, 0.999, 1)
	self.weapon_skins.flamethrower_mk2_bloodsplat.uv_offset_rot = Vector3(0.35917, 0.979251, 3.03145)
	self.weapon_skins.flamethrower_mk2_bloodsplat.parts = {
		wpn_fps_fla_mk2_body = {
			[Idstring("body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/dw_skull_df"),
				uv_offset_rot = Vector3(0.0443599, 0.922013, 6.05841),
				pattern_pos = Vector3(0.168376, -0.00333858, 0),
				uv_scale = Vector3(3.79061, 4.172, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_flames_df"),
				pattern_tweak = Vector3(5.88123, 1.66782, 1)
			}
		},
		wpn_fps_fla_mk2_mag_rare = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_flames_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_overkill_logo_df"),
				pattern_pos = Vector3(0.111138, 0.147836, 0),
				uv_scale = Vector3(8.60575, 8.55807, 0.775817),
				uv_offset_rot = Vector3(0.196995, 0.883854, 1.69779),
				pattern_tweak = Vector3(4.02099, 3.36112, 1)
			}
		}
	}
	self.weapon_skins.flamethrower_mk2_bloodsplat.default_blueprint = {
		"wpn_fps_fla_mk2_empty",
		"wpn_fps_fla_mk2_body",
		"wpn_fps_fla_mk2_mag_rare"
	}
	self.weapon_skins.rpg7_bloodsplat = {}
	self.weapon_skins.rpg7_bloodsplat.name_id = "bm_wskn_rpg7_bloodsplat"
	self.weapon_skins.rpg7_bloodsplat.desc_id = "bm_wskn_rpg7_bloodsplat_desc"
	self.weapon_skins.rpg7_bloodsplat.weapon_id = "rpg7"
	self.weapon_skins.rpg7_bloodsplat.reserve_quality = true
	self.weapon_skins.rpg7_bloodsplat.rarity = "rare"
	self.weapon_skins.rpg7_bloodsplat.bonus = "spread_p1_tem_p1"
	self.weapon_skins.rpg7_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.rpg7_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df")
	self.weapon_skins.rpg7_bloodsplat.uv_scale = Vector3(0.01, 0.548726, 1)
	self.weapon_skins.rpg7_bloodsplat.parts = {
		wpn_fps_rpg7_m_rocket = {
			[Idstring("mtr_rocket"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_trex_df"),
				uv_scale = Vector3(0.977799, 1.58791, 1),
				uv_offset_rot = Vector3(-0.0319577, 1.00033, 6.28319)
			}
		},
		wpn_fps_rpg7_body = {
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_trex_df"),
				uv_offset_rot = Vector3(0.301932, 0.998331, 6.28319),
				uv_scale = Vector3(0.930124, 1.59757, 0),
				pattern_tweak = Vector3(6.8829, 1.02347, 1)
			}
		}
	}
	self.weapon_skins.g36_bloodsplat = {}
	self.weapon_skins.g36_bloodsplat.name_id = "bm_wskn_g36_bloodsplat"
	self.weapon_skins.g36_bloodsplat.desc_id = "bm_wskn_g36_bloodsplat_desc"
	self.weapon_skins.g36_bloodsplat.weapon_id = "g36"
	self.weapon_skins.g36_bloodsplat.rarity = "rare"
	self.weapon_skins.g36_bloodsplat.reserve_quality = true
	self.weapon_skins.g36_bloodsplat.bonus = "spread_p1_tem_p1"
	self.weapon_skins.g36_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.g36_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_002_df")
	self.weapon_skins.g36_bloodsplat.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_overkill_logo_df")
	self.weapon_skins.g36_bloodsplat.pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_flames_df")
	self.weapon_skins.g36_bloodsplat.pattern_tweak = Vector3(1.34987, 1.69779, 1)
	self.weapon_skins.g36_bloodsplat.default_blueprint = {
		"wpn_fps_ass_g36_m_standard",
		"wpn_fps_ass_g36_b_long",
		"wpn_fps_ass_g36_fg_ksk",
		"wpn_fps_upg_fl_ass_utg",
		"wpn_fps_ass_g36_s_sl8",
		"wpn_fps_upg_ass_ns_surefire"
	}
	self.weapon_skins.g36_bloodsplat.parts = {
		wpn_fps_ass_g36_fg_ksk = {
			[Idstring("ksk"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bloodsplat_df"),
				uv_offset_rot = Vector3(0.235154, 0.635822, 1.69779),
				uv_scale = Vector3(0.739425, 0.834774, 1),
				pattern_tweak = Vector3(1.34987, 1.69779, 1)
			}
		},
		wpn_fps_ass_g36_body_sl8 = {
			[Idstring("base"):key()] = {
				pattern_tweak = Vector3(2.11305, 1.66782, 1)
			}
		},
		wpn_fps_ass_g36_b_long = {
			[Idstring("barrel"):key()] = {
				pattern_pos = Vector3(-0.384927, 0, 0),
				pattern_tweak = Vector3(0.872886, 1.8926, 1)
			}
		},
		wpn_fps_ass_g36_s_sl8 = {
			[Idstring("sl8"):key()] = {
				pattern_tweak = Vector3(1, 1.86263, 1)
			}
		},
		wpn_fps_upg_fl_ass_utg = {
			[Idstring("mtr_led"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bloodsplat_df"),
				uv_offset_rot = Vector3(0.540425, 1.02695, 2.56692),
				uv_scale = Vector3(0.739425, 0.548726, 1),
				pattern_tweak = Vector3(1.58836, 1.7877, 1)
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bloodsplat_df"),
				uv_offset_rot = Vector3(0.282853, 0.759838, 0),
				uv_scale = Vector3(0.644076, 1.02547, 1)
			}
		}
	}
	self.weapon_skins.serbu_stunner = {}
	self.weapon_skins.serbu_stunner.name_id = "bm_wskn_serbu_stunner"
	self.weapon_skins.serbu_stunner.desc_id = "bm_wskn_serbu_stunner_desc"
	self.weapon_skins.serbu_stunner.weapon_id = "serbu"
	self.weapon_skins.serbu_stunner.reserve_quality = true
	self.weapon_skins.serbu_stunner.rarity = "epic"
	self.weapon_skins.serbu_stunner.bonus = "spread_p1_tem_p1"
	self.weapon_skins.serbu_stunner.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.serbu_stunner.default_blueprint = {
		"wpn_fps_shot_r870_body_standard",
		"wpn_fps_shot_r870_b_short",
		"wpn_fps_shot_r870_fg_small",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_upg_m4_g_ergo",
		"wpn_fps_shot_shorty_m_extended_short",
		"wpn_fps_shot_shorty_s_solid_short",
		"wpn_fps_upg_a_explosive"
	}
	self.weapon_skins.serbu_stunner.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_007_df")
	self.weapon_skins.serbu_stunner.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_003_df")
	self.weapon_skins.serbu_stunner.pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_smoke_df")
	self.weapon_skins.serbu_stunner.pattern_tweak = Vector3(0.340202, 0, 1)
	self.weapon_skins.serbu_stunner.pattern_pos = Vector3(-1.00501, 0, 0)
	self.weapon_skins.serbu_stunner.parts = {
		wpn_fps_upg_m4_g_ergo = {
			[Idstring("ergo_grip"):key()] = {
				pattern_pos = Vector3(-0.232292, 0.36871, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_smoke_df"),
				pattern_tweak = Vector3(0.240805, 0, 1)
			}
		},
		wpn_fps_shot_r870_b_short = {
			[Idstring("short_barrel"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df")
			}
		},
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bombs_away_df"),
				pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df"),
				uv_scale = Vector3(1.21617, 1.97897, 0),
				uv_offset_rot = Vector3(-0.034799, 1.00087, 6.28319)
			}
		},
		wpn_fps_shot_shorty_s_solid_short = {
			[Idstring("solid"):key()] = {
				pattern_pos = Vector3(-0.909611, -0.026, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_smoke_df"),
				pattern_tweak = Vector3(0.321202, 0, 1)
			},
			[Idstring("big_rail"):key()] = {
				pattern_pos = Vector3(-0.737896, -0.00333858, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_smoke_df"),
				pattern_tweak = Vector3(0.272503, 0, 1)
			}
		},
		wpn_fps_shot_r870_s_solid = {
			[Idstring("solid"):key()] = {
				pattern_pos = Vector3(-0.909611, -0.026, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_smoke_df"),
				pattern_tweak = Vector3(0.321202, 0, 1)
			}
		},
		wpn_fps_shot_r870_fg_small = {
			[Idstring("short_pump"):key()] = {
				pattern_pos = Vector3(2, -0.155974, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_smoke_df"),
				pattern_tweak = Vector3(0.348202, 0, 1)
			}
		},
		wpn_fps_shot_shorty_m_extended_short = {
			[Idstring("extension"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df")
			}
		}
	}
	self.weapon_skins.new_m14_bloodsplat = {}
	self.weapon_skins.new_m14_bloodsplat.name_id = "bm_wskn_new_m14_bloodsplat"
	self.weapon_skins.new_m14_bloodsplat.desc_id = "bm_wskn_new_m14_bloodsplat_desc"
	self.weapon_skins.new_m14_bloodsplat.weapon_id = "new_m14"
	self.weapon_skins.new_m14_bloodsplat.reserve_quality = true
	self.weapon_skins.new_m14_bloodsplat.rarity = "epic"
	self.weapon_skins.new_m14_bloodsplat.bonus = "recoil_p1_tem_p1"
	self.weapon_skins.new_m14_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.new_m14_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_008_df")
	self.weapon_skins.new_m14_bloodsplat.parts = {
		wpn_fps_ass_m14_body_upper = {
			[Idstring("base"):key()] = {
				pattern_pos = Vector3(0.454567, 0.149297, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_overkill_logo_df"),
				pattern_tweak = Vector3(1.58836, 1.02347, 1)
			}
		},
		wpn_fps_ass_m14_body_lower = {
			[Idstring("lower"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_overkill_logo_df"),
				pattern_tweak = Vector3(2.01765, 0.948547, 1)
			}
		},
		wpn_fps_ass_m14_m_standard = {
			[Idstring("mag"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_pinupp_df"),
				uv_offset_rot = Vector3(0.029201, 0.570584, 0),
				uv_scale = Vector3(2.83711, 2.83711, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_overkill_logo_df"),
				pattern_tweak = Vector3(2.14075, 1.02152, 1)
			}
		},
		wpn_fps_ass_m14_body_jae = {
			[Idstring("jae"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_005_df")
			}
		}
	}
	self.weapon_skins.new_m14_bloodsplat.default_blueprint = {
		"wpn_fps_ass_m14_b_standard",
		"wpn_fps_ass_m14_body_lower",
		"wpn_fps_ass_m14_body_upper",
		"wpn_fps_ass_m14_m_standard",
		"wpn_fps_ass_m14_body_jae",
		"wpn_fps_upg_o_acog",
		"wpn_fps_upg_o_m14_scopemount",
		"wpn_fps_upg_ns_ass_smg_large"
	}
	self.weapon_skins.new_raging_bull_bloodsplat = {}
	self.weapon_skins.new_raging_bull_bloodsplat.name_id = "bm_wskn_new_raging_bull_bloodsplat"
	self.weapon_skins.new_raging_bull_bloodsplat.desc_id = "bm_wskn_new_raging_bull_bloodsplat_desc"
	self.weapon_skins.new_raging_bull_bloodsplat.weapon_id = "new_raging_bull"
	self.weapon_skins.new_raging_bull_bloodsplat.reserve_quality = true
	self.weapon_skins.new_raging_bull_bloodsplat.rarity = "epic"
	self.weapon_skins.new_raging_bull_bloodsplat.bonus = "concealment_p3_tem_p1"
	self.weapon_skins.new_raging_bull_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.new_raging_bull_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_005_df")
	self.weapon_skins.new_raging_bull_bloodsplat.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_008_df")
	self.weapon_skins.new_raging_bull_bloodsplat.pattern_tweak = Vector3(1.44527, 0, 1)
	self.weapon_skins.new_raging_bull_bloodsplat.parts = {
		wpn_fps_pis_rage_body_smooth = {
			[Idstring("smooth"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_stripes_df"),
				pattern_pos = Vector3(-0.561642, -0.342388, 0),
				uv_scale = Vector3(1.1685, 1.1685, 1),
				uv_offset_rot = Vector3(-0.219292, 0.756838, 5.21925),
				pattern_tweak = Vector3(1.30217, 2.11737, 1)
			},
			[Idstring("base"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.146434, 0, 0),
				pattern_tweak = Vector3(0.300503, 0, 1)
			}
		},
		wpn_fps_pis_rage_body_standard = {
			[Idstring("cylinder"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_stripes_df"),
				pattern_pos = Vector3(-0.561642, -0.342388, 0),
				uv_scale = Vector3(1.1685, 1.1685, 1),
				uv_offset_rot = Vector3(-0.219292, 0.756838, 5.21925),
				pattern_tweak = Vector3(1.30217, 2.11737, 1)
			},
			[Idstring("base"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.146434, 0, 0),
				pattern_tweak = Vector3(0.300503, 0, 1)
			}
		},
		wpn_fps_pis_rage_b_standard = {
			[Idstring("barrel_standard"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.241831, -0.0605769, 0),
				pattern_tweak = Vector3(0.443599, 3.34614, 0)
			}
		},
		wpn_fps_pis_rage_b_long = {
			[Idstring("barrel_long"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.241831, -0.0605769, 0),
				pattern_tweak = Vector3(0.443599, 3.34614, 0)
			}
		},
		wpn_fps_pis_rage_b_comp1 = {
			[Idstring("comp1"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.241831, -0.0605769, 0),
				pattern_tweak = Vector3(0.443599, 3.34614, 0)
			}
		},
		wpn_fps_pis_rage_b_comp2 = {
			[Idstring("comp2"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.241831, -0.0605769, 0),
				pattern_tweak = Vector3(0.443599, 3.34614, 0)
			}
		},
		wpn_fps_pis_rage_b_short = {
			[Idstring("barrel_short"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_fade_001_df"),
				pattern_pos = Vector3(-0.241831, -0.0605769, 0),
				pattern_tweak = Vector3(0.443599, 3.34614, 0)
			}
		},
		wpn_fps_pis_rage_g_standard = {
			[Idstring("grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_001_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df"),
				pattern_pos = Vector3(0.0252805, -0.0796564, 0),
				pattern_tweak = Vector3(0.72979, 1.53296, 1)
			}
		},
		wpn_fps_pis_rage_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_001_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df"),
				pattern_pos = Vector3(0.0252805, -0.0796564, 0),
				pattern_tweak = Vector3(0.72979, 1.53296, 1)
			}
		}
	}
	self.weapon_skins.new_raging_bull_bloodsplat.default_blueprint = {
		"wpn_fps_pis_rage_g_ergo",
		"wpn_fps_pis_rage_b_long",
		"wpn_fps_pis_rage_body_smooth"
	}
	self.weapon_skins.famas_bloodsplat = {}
	self.weapon_skins.famas_bloodsplat.name_id = "bm_wskn_famas_bloodsplat"
	self.weapon_skins.famas_bloodsplat.desc_id = "bm_wskn_famas_bloodsplat_desc"
	self.weapon_skins.famas_bloodsplat.weapon_id = "famas"
	self.weapon_skins.famas_bloodsplat.reserve_quality = true
	self.weapon_skins.famas_bloodsplat.rarity = "epic"
	self.weapon_skins.famas_bloodsplat.bonus = "concealment_p3_tem_p1"
	self.weapon_skins.famas_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.famas_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/sputnik/base_gradient/base_sput_004_df")
	self.weapon_skins.famas_bloodsplat.pattern_tweak = Vector3(2.25614, 1.45804, 2)
	self.weapon_skins.famas_bloodsplat.uv_scale = Vector3(1, 1, 0)
	self.weapon_skins.famas_bloodsplat.uv_offset_rot = Vector3(0.607203, 0.979251, 3.03145)
	self.weapon_skins.famas_bloodsplat.parts = {
		wpn_fps_ass_famas_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				uv_scale = Vector3(0.358028, 0.739425, 1),
				uv_offset_rot = Vector3(0.645361, 0.988791, 0)
			}
		},
		wpn_fps_ass_famas_g_standard = {
			[Idstring("mtr_grip_2"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_verdunne_df"),
				uv_scale = Vector3(0.405702, 0.548726, 0),
				uv_offset_rot = Vector3(0.244694, 1.57071, 0)
			}
		},
		wpn_fps_ass_famas_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_verdunne_df"),
				uv_offset_rot = Vector3(0.066979, 1.08419, 0),
				pattern_pos = Vector3(0, 0.0252805, 0),
				uv_scale = Vector3(1.50355, 3.50456, 0)
			},
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_verdunne_df"),
				uv_offset_rot = Vector3(0.0267406, 0.666521, 6.28319),
				uv_scale = Vector3(0.7871, 2.12199, 0)
			}
		}
	}
	self.weapon_skins.famas_bloodsplat.default_blueprint = {
		"wpn_fps_ass_famas_body_standard",
		"wpn_fps_ass_famas_g_standard",
		"wpn_fps_ass_famas_m_standard",
		"wpn_fps_ass_famas_b_short"
	}
	self.weapon_skins.r93_wooh = {}
	self.weapon_skins.r93_wooh.name_id = "bm_wskn_r93_wooh"
	self.weapon_skins.r93_wooh.desc_id = "bm_wskn_r93_wooh_desc"
	self.weapon_skins.r93_wooh.weapon_id = "r93"
	self.weapon_skins.r93_wooh.reserve_quality = true
	self.weapon_skins.r93_wooh.rarity = "epic"
	self.weapon_skins.r93_wooh.bonus = "recoil_p1_tem_p1"
	self.weapon_skins.r93_wooh.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.r93_wooh.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_ferrar_df")
	self.weapon_skins.r93_wooh.default_blueprint = {
		"wpn_fps_snp_r93_b_standard",
		"wpn_fps_snp_r93_m_std",
		"wpn_fps_upg_o_leupold",
		"wpn_fps_snp_r93_body_standard"
	}
	self.weapon_skins.r93_wooh.parts = {
		wpn_fps_snp_r93_body_standard = {
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_falcogini_df"),
				uv_offset_rot = Vector3(-0.157974, 1.00033, 4.71377),
				uv_scale = Vector3(5.60224, 5.55457, 1),
				pattern_tweak = Vector3(20, 0, 1)
			},
			[Idstring("mtr_body"):key()] = {
				uv_scale = Vector3(12.5151, 12.6104, 1),
				uv_offset_rot = Vector3(0.0634394, 0.931553, 0)
			}
		},
		wpn_fps_upg_o_leupold = {
			[Idstring("leupold"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_falcogini_text_df"),
				uv_offset_rot = Vector3(0.332551, 0.971172, 0),
				uv_scale = Vector3(4.3627, 6.03132, 1),
				cubemap_pattern_control = Vector3(0.198665, 0, 0),
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_005_df")
			}
		},
		wpn_fps_snp_r93_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_falcogini_text_df"),
				uv_scale = Vector3(1.31152, 0.405702, 1),
				uv_offset_rot = Vector3(-0.0987357, 1.11281, 0)
			}
		}
	}
	self.weapon_skins.ak74_bloodsplat = {}
	self.weapon_skins.ak74_bloodsplat.name_id = "bm_wskn_ak74_bloodsplat"
	self.weapon_skins.ak74_bloodsplat.desc_id = "bm_wskn_ak74_bloodsplat_desc"
	self.weapon_skins.ak74_bloodsplat.weapon_id = "ak74"
	self.weapon_skins.ak74_bloodsplat.reserve_quality = true
	self.weapon_skins.ak74_bloodsplat.rarity = "epic"
	self.weapon_skins.ak74_bloodsplat.bonus = "spread_p1_tem_p1"
	self.weapon_skins.ak74_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.ak74_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_005_df")
	self.weapon_skins.ak74_bloodsplat.parts = {
		wpn_fps_ass_74_body_upperreceiver = {
			[Idstring("ak74_dustcover"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_houston_df"),
				uv_scale = Vector3(3.69526, 3.83828, 1),
				uv_offset_rot = Vector3(0.235154, 0.864775, 0)
			}
		},
		wpn_fps_upg_ak_g_pgrip = {
			[Idstring("mtr_akgrip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_orange_prison_suit_df"),
				pattern_pos = Vector3(0.072979, 0.177916, 0),
				pattern_tweak = Vector3(1.63606, 1.48801, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df")
			}
		},
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_orange_prison_suit_df"),
				pattern_pos = Vector3(0.158836, -0.0510372, 0),
				pattern_tweak = Vector3(2.82853, 1.30819, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df")
			}
		},
		wpn_fps_ass_ak_body_lowerreceiver = {
			[Idstring("ak_base"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cf15/sticker/sticker_houston_df"),
				uv_scale = Vector3(5.84062, 5.64992, 1),
				uv_offset_rot = Vector3(0.0302805, 0.968632, 0)
			}
		},
		wpn_fps_upg_ak_s_solidstock = {
			[Idstring("mtr_solid"):key()] = {
				uv_offset_rot = Vector3(-0.089196, 0.836156, 0),
				pattern_tweak = Vector3(1.63606, 0.0194812, 1),
				pattern_pos = Vector3(-0.480324, 0, 0),
				uv_scale = Vector3(2.93246, 4.02898, 1),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_orange_prison_suit_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df")
			}
		}
	}
	self.weapon_skins.ak74_bloodsplat.default_blueprint = {
		"wpn_fps_ass_74_body_upperreceiver",
		"wpn_fps_ass_ak_body_lowerreceiver",
		"wpn_fps_upg_ak_b_ak105",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ak_fg_trax",
		"wpn_fps_upg_ak_g_pgrip",
		"wpn_fps_upg_ak_m_quad",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_o_ak_scopemount"
	}
	self.weapon_skins.ppk_bloodsplat = {}
	self.weapon_skins.ppk_bloodsplat.name_id = "bm_wskn_ppk_bloodsplat"
	self.weapon_skins.ppk_bloodsplat.desc_id = "bm_wskn_ppk_bloodsplat_desc"
	self.weapon_skins.ppk_bloodsplat.weapon_id = "ppk"
	self.weapon_skins.ppk_bloodsplat.reserve_quality = true
	self.weapon_skins.ppk_bloodsplat.rarity = "epic"
	self.weapon_skins.ppk_bloodsplat.bonus = "concealment_p3_tem_p1"
	self.weapon_skins.ppk_bloodsplat.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.ppk_bloodsplat.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_008_df")
	self.weapon_skins.ppk_bloodsplat.parts = {
		wpn_fps_pis_ppk_b_long = {
			[Idstring("mtr_slide_long"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_009_df"),
				pattern_tweak = Vector3(8.88624, 0, 1)
			}
		},
		wpn_fps_pis_ppk_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_009_df"),
				pattern_tweak = Vector3(8.88624, 0, 1)
			}
		}
	}
	self.weapon_skins.ppk_bloodsplat.default_blueprint = {
		"wpn_fps_pis_ppk_body_standard",
		"wpn_fps_pis_ppk_m_standard",
		"wpn_fps_pis_ppk_b_long",
		"wpn_fps_pis_ppk_g_laser",
		"wpn_fps_upg_ns_pis_jungle"
	}
	self.weapon_skins.b92fs_wooh = {}
	self.weapon_skins.b92fs_wooh.name_id = "bm_wskn_b92fs_wooh"
	self.weapon_skins.b92fs_wooh.desc_id = "bm_wskn_b92fs_wooh_desc"
	self.weapon_skins.b92fs_wooh.weapon_id = "b92fs"
	self.weapon_skins.b92fs_wooh.reserve_quality = true
	self.weapon_skins.b92fs_wooh.rarity = "epic"
	self.weapon_skins.b92fs_wooh.bonus = "spread_p1_tem_p1"
	self.weapon_skins.b92fs_wooh.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.b92fs_wooh.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_005_df")
	self.weapon_skins.b92fs_wooh.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df")
	self.weapon_skins.b92fs_wooh.pattern = Idstring("units/payday2_cash/safes/cf15/pattern/pattern_waves_df")
	self.weapon_skins.b92fs_wooh.pattern_tweak = Vector3(1.82686, 0, 1)
	self.weapon_skins.b92fs_wooh.default_blueprint = {
		"wpn_fps_pis_beretta_body_beretta",
		"wpn_fps_pis_beretta_b_std",
		"wpn_fps_pis_beretta_sl_brigadier",
		"wpn_fps_pis_beretta_m_extended",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_pis_beretta_g_engraved",
		"wpn_fps_pis_beretta_co_co1"
	}
	self.weapon_skins.b92fs_wooh.parts = {
		wpn_fps_pis_beretta_body_beretta = {
			[Idstring("body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_whiskey_label_df"),
				uv_scale = Vector3(4.60008, 8.08133, 1),
				uv_offset_rot = Vector3(0.276853, 1.09873, 0)
			}
		},
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_whiskey_label_df"),
				uv_scale = Vector3(3.02281, 5.50689, 1),
				uv_offset_rot = Vector3(0.236614, 0.910473, 0)
			}
		}
	}
	self.weapon_skins.flamethrower_mk2_fire = {}
	self.weapon_skins.flamethrower_mk2_fire.name_id = "bm_wskn_flamethrower_mk2_fire"
	self.weapon_skins.flamethrower_mk2_fire.desc_id = "bm_wskn_flamethrower_mk2_fire_desc"
	self.weapon_skins.flamethrower_mk2_fire.weapon_id = "flamethrower_mk2"
	self.weapon_skins.flamethrower_mk2_fire.reserve_quality = true
	self.weapon_skins.flamethrower_mk2_fire.rarity = "legendary"
	self.weapon_skins.flamethrower_mk2_fire.bonus = "damage_p1_tem_p1"
	self.weapon_skins.flamethrower_mk2_fire.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.flamethrower_mk2_fire.unique_name_id = "bm_wskn_flamethrower_mk2_fire"
	self.weapon_skins.flamethrower_mk2_fire.locked = true
	self.weapon_skins.flamethrower_mk2_fire.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.flamethrower_mk2_fire.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_gold_df")
	self.weapon_skins.flamethrower_mk2_fire.pattern_tweak = Vector3(5.07036, 1.62287, 1)
	self.weapon_skins.flamethrower_mk2_fire.uv_scale = Vector3(1, 0.999, 1)
	self.weapon_skins.flamethrower_mk2_fire.default_blueprint = {
		"wpn_fps_fla_mk2_empty",
		"wpn_fps_fla_mk2_body_fierybeast",
		"wpn_fps_fla_mk2_mag"
	}
	self.weapon_skins.flamethrower_mk2_fire.parts = {
		wpn_fps_fla_mk2_body_fierybeast = {
			[Idstring("body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/dragons_df"),
				uv_offset_rot = Vector3(0.101598, 0.998331, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_overkill_logo_df"),
				uv_scale = Vector3(2.78944, 2.78944, 0.401383),
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_003_df"),
				pattern_tweak = Vector3(10.2218, 4.66481, 1)
			},
			[Idstring("mtr_head"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_004_df")
			}
		},
		wpn_fps_fla_mk2_mag = {
			[Idstring("flame_fuel_can"):key()] = {
				cubemap_pattern_control = Vector3(0.1772, 0.444312, 0),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_dragon_scales_df")
			}
		}
	}
	self.weapon_skins.rpg7_boom = {}
	self.weapon_skins.rpg7_boom.name_id = "bm_wskn_rpg7_boom"
	self.weapon_skins.rpg7_boom.desc_id = "bm_wskn_rpg7_boom_desc"
	self.weapon_skins.rpg7_boom.weapon_id = "rpg7"
	self.weapon_skins.rpg7_boom.reserve_quality = true
	self.weapon_skins.rpg7_boom.rarity = "legendary"
	self.weapon_skins.rpg7_boom.bonus = "spread_p1_tem_p1"
	self.weapon_skins.rpg7_boom.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.rpg7_boom.unique_name_id = "bm_wskn_rpg7_boom"
	self.weapon_skins.rpg7_boom.locked = true
	self.weapon_skins.rpg7_boom.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_007_df")
	self.weapon_skins.rpg7_boom.pattern_tweak = Vector3(0.999, 0, 1)
	self.weapon_skins.rpg7_boom.default_blueprint = {
		"wpn_fps_rpg7_body",
		"wpn_fps_rpg7_m_grinclown",
		"wpn_fps_rpg7_barrel",
		"wpn_fps_upg_o_rx30"
	}
	self.weapon_skins.rpg7_boom.parts = {
		wpn_fps_rpg7_m_rocket = {
			[Idstring("mtr_rocket"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df"),
				cubemap_pattern_control = Vector3(0.0245649, 0.141426, 0)
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_004_df")
			}
		},
		wpn_fps_rpg7_m_grinclown = {
			[Idstring("mtr_rocket"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_006_df")
			},
			[Idstring("mtr_custom_rocket"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_005_df")
			}
		},
		wpn_fps_rpg7_sight = {
			[Idstring("mtr_sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_004_df")
			}
		},
		wpn_fps_rpg7_body = {
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/golden_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_dollar_bling_df"),
				cubemap_pattern_control = Vector3(0.484856, 0.0555689, 0),
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_007_df"),
				uv_offset_rot = Vector3(0.312392, 0.964172, 0),
				uv_scale = Vector3(2.21734, 4.02898, 0),
				pattern_tweak = Vector3(11.1281, 0.169331, 0.780587),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df")
			}
		}
	}
	self.weapon_skins.m134_bulletstorm = {}
	self.weapon_skins.m134_bulletstorm.name_id = "bm_wskn_m134_bulletstorm"
	self.weapon_skins.m134_bulletstorm.desc_id = "bm_wskn_m134_bulletstorm_desc"
	self.weapon_skins.m134_bulletstorm.weapon_id = "m134"
	self.weapon_skins.m134_bulletstorm.reserve_quality = true
	self.weapon_skins.m134_bulletstorm.rarity = "legendary"
	self.weapon_skins.m134_bulletstorm.bonus = "spread_p1_tem_p1"
	self.weapon_skins.m134_bulletstorm.texture_bundle_folder = "cash/safes/cop"
	self.weapon_skins.m134_bulletstorm.unique_name_id = "bm_wskn_m134_bulletstorm"
	self.weapon_skins.m134_bulletstorm.locked = true
	self.weapon_skins.m134_bulletstorm.base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_008_df")
	self.weapon_skins.m134_bulletstorm.default_blueprint = {
		"wpn_fps_lmg_m134_body",
		"wpn_fps_lmg_m134_m_standard",
		"wpn_fps_lmg_m134_barrel_legendary",
		"wpn_fps_lmg_m134_body_upper_spikey",
		"wpn_fps_upg_fl_ass_utg"
	}
	self.weapon_skins.m134_bulletstorm.parts = {
		wpn_fps_lmg_m134_body_upper_spikey = {
			[Idstring("mtr_spikey"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_spikey_df")
			},
			[Idstring("mtr_handle"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_overkill_df"),
				uv_offset_rot = Vector3(0.403869, 1.06965, 4.72475),
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_008_df"),
				uv_scale = Vector3(11.7046, 11.5616, 1),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_flames_df"),
				pattern_tweak = Vector3(4.35488, 1.7877, 1)
			}
		},
		wpn_fps_lmg_m134_barrel_legendary = {
			[Idstring("mtr_spikey"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_spikey_df")
			},
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cop/sticker/sticker_bdsm_df"),
				uv_offset_rot = Vector3(-0.30007, 1.43362, 3.12136),
				pattern_pos = Vector3(0, 0.00620103, 0),
				uv_scale = Vector3(6.98481, 6.98481, 1),
				pattern_tweak = Vector3(16.4703, 0, 1)
			}
		},
		wpn_fps_lmg_m134_body = {
			[Idstring("mtr_body"):key()] = {
				uv_offset_rot = Vector3(0.196995, 1.22728, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_gold_df"),
				pattern = Idstring("units/payday2_cash/safes/cop/pattern/pattern_flames_df"),
				pattern_tweak = Vector3(7.55068, 1.71278, 1)
			}
		}
	}
	self.weapon_skins.p90_golddigger = {}
	self.weapon_skins.p90_golddigger.name_id = "bm_wskn_p90_golddigger"
	self.weapon_skins.p90_golddigger.desc_id = "bm_wskn_p90_golddigger_desc"
	self.weapon_skins.p90_golddigger.weapon_id = "p90"
	self.weapon_skins.p90_golddigger.rarity = "common"
	self.weapon_skins.p90_golddigger.bonus = "recoil_p1"
	self.weapon_skins.p90_golddigger.reserve_quality = true
	self.weapon_skins.p90_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.p90_golddigger.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_004_df")
	self.weapon_skins.huntsman_golddigger = {}
	self.weapon_skins.huntsman_golddigger.name_id = "bm_wskn_huntsman_golddigger"
	self.weapon_skins.huntsman_golddigger.desc_id = "bm_wskn_huntsman_golddigger_desc"
	self.weapon_skins.huntsman_golddigger.weapon_id = "huntsman"
	self.weapon_skins.huntsman_golddigger.rarity = "common"
	self.weapon_skins.huntsman_golddigger.bonus = "recoil_p1"
	self.weapon_skins.huntsman_golddigger.reserve_quality = true
	self.weapon_skins.huntsman_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.huntsman_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_007_df")
	self.weapon_skins.huntsman_golddigger.pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_ornaments_df")
	self.weapon_skins.huntsman_golddigger.parts = {
		wpn_fps_shot_huntsman_b_short = {
			[Idstring("short_barrel"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_ornaments_df"),
				pattern_pos = Vector3(-1.63471, -1.52969, 0),
				pattern_tweak = Vector3(2.54233, 1.53296, 1)
			}
		},
		wpn_fps_shot_huntsman_b_long = {
			[Idstring("long_barrel"):key()] = {
				pattern_pos = Vector3(-1.63701, -1.52576, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_ornaments_df"),
				pattern_tweak = Vector3(3.97529, 1.55488, 1)
			}
		},
		wpn_fps_shot_huntsman_body_standard = {
			[Idstring("mech"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_ornaments_df"),
				pattern_pos = Vector3(-0.365848, 0.187455, 0),
				pattern_tweak = Vector3(0.825187, 1.63785, 1)
			}
		}
	}
	self.weapon_skins.r93_golddigger = {}
	self.weapon_skins.r93_golddigger.name_id = "bm_wskn_r93_golddigger"
	self.weapon_skins.r93_golddigger.desc_id = "bm_wskn_r93_golddigger_desc"
	self.weapon_skins.r93_golddigger.weapon_id = "r93"
	self.weapon_skins.r93_golddigger.rarity = "common"
	self.weapon_skins.r93_golddigger.bonus = "spread_p1"
	self.weapon_skins.r93_golddigger.reserve_quality = true
	self.weapon_skins.r93_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.r93_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_005_df")
	self.weapon_skins.r93_golddigger.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_gold_df")
	self.weapon_skins.r93_golddigger.pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_stains_df")
	self.weapon_skins.r93_golddigger.pattern_tweak = Vector3(11.2712, 0.813683, 1)
	self.weapon_skins.r93_golddigger.pattern_pos = Vector3(1.26982, 0.0538995, 0)
	self.weapon_skins.ak74_golddigger = {}
	self.weapon_skins.ak74_golddigger.name_id = "bm_wskn_ak74_golddigger"
	self.weapon_skins.ak74_golddigger.desc_id = "bm_wskn_ak74_golddigger_desc"
	self.weapon_skins.ak74_golddigger.weapon_id = "ak74"
	self.weapon_skins.ak74_golddigger.rarity = "rare"
	self.weapon_skins.ak74_golddigger.bonus = "spread_p1"
	self.weapon_skins.ak74_golddigger.reserve_quality = true
	self.weapon_skins.ak74_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.ak74_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.ak74_golddigger.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_gold_df")
	self.weapon_skins.ak74_golddigger.pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_lines_df")
	self.weapon_skins.ak74_golddigger.pattern_tweak = Vector3(1.30217, 0.547939, 1)
	self.weapon_skins.ak74_golddigger.pattern_pos = Vector3(0, -0.528023, 0)
	self.weapon_skins.ak74_golddigger.default_blueprint = {
		"wpn_fps_ass_74_body_upperreceiver",
		"wpn_fps_ass_ak_body_lowerreceiver",
		"wpn_fps_upg_ak_b_ak105",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ak_fg_trax",
		"wpn_fps_upg_ak_g_pgrip",
		"wpn_fps_upg_ak_m_quad",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_o_ak_scopemount"
	}
	self.weapon_skins.ak74_golddigger.parts = {
		wpn_fps_ass_74_body_upperreceiver = {
			[Idstring("ak74_dustcover"):key()] = {
				pattern_pos = Vector3(-0.94023, -0.0510372, 0),
				pattern_tweak = Vector3(1.34987, 0.573924, 1)
			}
		},
		wpn_fps_upg_ak_g_pgrip = {
			[Idstring("mtr_akgrip"):key()] = {
				pattern_pos = Vector3(0, -0.559102, 0)
			}
		},
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				pattern_pos = Vector3(-0.957309, -0.510262, 0),
				pattern_tweak = Vector3(0.876186, 0.410075, 1)
			}
		},
		wpn_fps_upg_ak_s_solidstock = {
			[Idstring("mtr_solid"):key()] = {
				pattern_pos = Vector3(0.022, -1.50915, 0)
			}
		},
		wpn_fps_upg_o_ak_scopemount = {
			[Idstring("mtr_kv04"):key()] = {
				pattern_pos = Vector3(0, -0.677578, 0)
			}
		}
	}
	self.weapon_skins.m134_golddigger = {}
	self.weapon_skins.m134_golddigger.name_id = "bm_wskn_m134_golddigger"
	self.weapon_skins.m134_golddigger.desc_id = "bm_wskn_m134_golddigger_desc"
	self.weapon_skins.m134_golddigger.weapon_id = "m134"
	self.weapon_skins.m134_golddigger.rarity = "uncommon"
	self.weapon_skins.m134_golddigger.bonus = "recoil_p1"
	self.weapon_skins.m134_golddigger.reserve_quality = true
	self.weapon_skins.m134_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.m134_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_005_df")
	self.weapon_skins.serbu_golddigger = {}
	self.weapon_skins.serbu_golddigger.name_id = "bm_wskn_serbu_golddigger"
	self.weapon_skins.serbu_golddigger.desc_id = "bm_wskn_serbu_golddigger_desc"
	self.weapon_skins.serbu_golddigger.weapon_id = "serbu"
	self.weapon_skins.serbu_golddigger.rarity = "rare"
	self.weapon_skins.serbu_golddigger.bonus = "spread_n1"
	self.weapon_skins.serbu_golddigger.reserve_quality = true
	self.weapon_skins.serbu_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.serbu_golddigger.base_gradient = Idstring("units/payday2_cash/safes/red/base_gradient/base_red_fleur_df")
	self.weapon_skins.serbu_golddigger.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_002_df")
	self.weapon_skins.serbu_golddigger.parts = {
		wpn_fps_shot_shorty_s_solid_short = {
			[Idstring("solid"):key()] = {
				pattern_pos = Vector3(0.216075, -0.327689, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_fleur_de_lis_df"),
				pattern_tweak = Vector3(3.30551, 0.139361, 1)
			},
			[Idstring("big_rail"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_fleur_de_lis_df"),
				pattern_pos = Vector3(-0.130736, 0.121138, 0),
				uv_offset_rot = Vector3(-0.136895, 0, 0),
				pattern_tweak = Vector3(4.02099, 0, 1)
			}
		},
		wpn_fps_shot_r870_b_short = {
			[Idstring("short_barrel"):key()] = {
				pattern_pos = Vector3(0.301932, 0.177916, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_fleur_de_lis_df"),
				pattern_tweak = Vector3(2.16075, 0, 1)
			}
		},
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				pattern_pos = Vector3(-0.029418, 0.721679, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_fleur_de_lis_df"),
				pattern_tweak = Vector3(2.88422, 0, 1)
			}
		}
	}
	self.weapon_skins.serbu_golddigger.default_blueprint = {
		"wpn_fps_shot_r870_body_standard",
		"wpn_fps_shot_r870_b_short",
		"wpn_fps_shot_r870_fg_small",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_upg_fl_ass_utg",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_shot_shorty_m_extended_short",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_shot_r870_body_rack",
		"wpn_fps_shot_shorty_s_solid_short"
	}
	self.weapon_skins.famas_golddigger = {}
	self.weapon_skins.famas_golddigger.name_id = "bm_wskn_famas_golddigger"
	self.weapon_skins.famas_golddigger.desc_id = "bm_wskn_famas_golddigger_desc"
	self.weapon_skins.famas_golddigger.weapon_id = "famas"
	self.weapon_skins.famas_golddigger.rarity = "epic"
	self.weapon_skins.famas_golddigger.bonus = "spread_p1"
	self.weapon_skins.famas_golddigger.reserve_quality = true
	self.weapon_skins.famas_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.famas_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df")
	self.weapon_skins.famas_golddigger.parts = {
		wpn_fps_ass_famas_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				uv_offset_rot = Vector3(0.002, 0, 0)
			}
		},
		wpn_fps_ass_famas_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/red/sticker/sticker_yggdrasil_df"),
				uv_scale = Vector3(2.09764, 2.93246, 0.537324),
				uv_offset_rot = Vector3(0.183916, 1.03449, 5.00451)
			},
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/red/sticker/sticker_yggdrasil_df"),
				uv_scale = Vector3(1.31152, 1.64524, 0.639876),
				uv_offset_rot = Vector3(0.0193599, 0.615282, 4.93454)
			}
		},
		wpn_fps_ass_famas_g_retro = {
			[Idstring("mtr_grip"):key()] = {
				uv_scale = Vector3(0.358028, 0.501052, 1),
				uv_offset_rot = Vector3(0.35917, 0.111138, 0)
			}
		}
	}
	self.weapon_skins.famas_golddigger.default_blueprint = {
		"wpn_fps_ass_famas_body_standard",
		"wpn_fps_ass_famas_m_standard",
		"wpn_fps_ass_famas_b_sniper",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_ass_famas_g_retro",
		"wpn_fps_upg_o_reflex"
	}
	self.weapon_skins.new_m14_golddigger = {}
	self.weapon_skins.new_m14_golddigger.name_id = "bm_wskn_new_m14_golddigger"
	self.weapon_skins.new_m14_golddigger.desc_id = "bm_wskn_new_m14_golddigger_desc"
	self.weapon_skins.new_m14_golddigger.weapon_id = "new_m14"
	self.weapon_skins.new_m14_golddigger.rarity = "uncommon"
	self.weapon_skins.new_m14_golddigger.bonus = "recoil_p1"
	self.weapon_skins.new_m14_golddigger.reserve_quality = true
	self.weapon_skins.new_m14_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.new_m14_golddigger.base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_004_df")
	self.weapon_skins.ppk_golddigger = {}
	self.weapon_skins.ppk_golddigger.name_id = "bm_wskn_ppk_golddigger"
	self.weapon_skins.ppk_golddigger.desc_id = "bm_wskn_ppk_golddigger_desc"
	self.weapon_skins.ppk_golddigger.weapon_id = "ppk"
	self.weapon_skins.ppk_golddigger.rarity = "common"
	self.weapon_skins.ppk_golddigger.bonus = "recoil_p1"
	self.weapon_skins.ppk_golddigger.reserve_quality = true
	self.weapon_skins.ppk_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.ppk_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_005_df")
	self.weapon_skins.ppk_golddigger.pattern_tweak = Vector3(5.48065, 5.50196, 1)
	self.weapon_skins.ppk_golddigger.pattern_pos = Vector3(-0.007, -0.05, 0)
	self.weapon_skins.ppk_golddigger.parts = {
		wpn_fps_pis_ppk_body_standard = {
			[Idstring("mtr_frame"):key()] = {
				pattern_pos = Vector3(2, -0.0881166, 0),
				pattern_tweak = Vector3(6.7875, 5.48198, 1)
			}
		},
		wpn_fps_pis_ppk_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_marble_floor_df"),
				pattern_pos = Vector3(0.126217, -0.0481165, 0),
				pattern_tweak = Vector3(4.83186, 2.37212, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df")
			}
		},
		wpn_fps_pis_ppk_b_standard = {
			[Idstring("mtr_slide"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_marble_floor_df"),
				pattern_pos = Vector3(0.025, 0.0167406, 0),
				pattern_tweak = Vector3(4.91926, 0.786698, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df")
			}
		},
		wpn_fps_pis_ppk_g_laser = {
			[Idstring("mtr_grip_laser"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_marble_floor_df"),
				pattern_pos = Vector3(0.283677, -0.176, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
				pattern_tweak = Vector3(5.16575, 2.37212, 1)
			}
		},
		wpn_fps_pis_ppk_b_long = {
			[Idstring("mtr_slide_long"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/pattern_marble_floor_df"),
				pattern_pos = Vector3(0.0378201, -0.0251799, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
				pattern_tweak = Vector3(5.69044, 0.782743, 1)
			}
		}
	}
	self.weapon_skins.m95_golddigger = {}
	self.weapon_skins.m95_golddigger.name_id = "bm_wskn_m95_golddigger"
	self.weapon_skins.m95_golddigger.desc_id = "bm_wskn_m95_golddigger_desc"
	self.weapon_skins.m95_golddigger.weapon_id = "m95"
	self.weapon_skins.m95_golddigger.rarity = "uncommon"
	self.weapon_skins.m95_golddigger.bonus = "total_ammo_p1"
	self.weapon_skins.m95_golddigger.reserve_quality = true
	self.weapon_skins.m95_golddigger.texture_bundle_folder = "cash/safes/red"
	self.weapon_skins.m95_golddigger.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_004_df")
	self.weapon_skins.m95_golddigger.pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/gradient_france_df")
	self.weapon_skins.m95_golddigger.parts = {
		wpn_fps_snp_m95_barrel_standard = {
			[Idstring("mtr_medium"):key()] = {
				pattern_pos = Vector3(-0.213212, 0, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_tweak = Vector3(0.491297, 0, 1)
			},
			[Idstring("mtr_muzzlebreak"):key()] = {
				pattern_pos = Vector3(0.0825188, 2, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_tweak = Vector3(0.205106, 0, 1)
			}
		},
		wpn_fps_snp_m95_bipod = {
			[Idstring("mtr_bipod"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_pos = Vector3(0.616742, 0, 0),
				cubemap_pattern_control = Vector3(0.136656, 0.143811, 0),
				pattern_tweak = Vector3(0.109709, 0, 1)
			}
		},
		wpn_fps_upg_o_shortdot = {
			[Idstring("mtr_shortdot"):key()] = {
				pattern_pos = Vector3(0.110979, -0.108275, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_tweak = Vector3(0.860585, 0, 1)
			}
		},
		wpn_fps_snp_m95_lower_reciever = {
			[Idstring("mtr_lower"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/red/sticker/b2_france_df"),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_pos = Vector3(0.206535, 0, 0),
				uv_scale = Vector3(9.0825, 8.74877, 0.277367),
				uv_offset_rot = Vector3(0.101058, 1.01033, 6.28319),
				pattern_tweak = Vector3(0.831488, 0, 1)
			}
		},
		wpn_fps_snp_m95_magazine = {
			[Idstring("mtr_clip"):key()] = {
				pattern_pos = Vector3(0.788457, 0.645361, 0),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_tweak = Vector3(0.538996, 0, 1)
			}
		},
		wpn_fps_snp_m95_upper_reciever = {
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/red/sticker/b2_france_df"),
				pattern = Idstring("units/payday2_cash/safes/red/pattern/france_df"),
				pattern_pos = Vector3(0.337631, 0.954552, 0),
				uv_scale = Vector3(6.98481, 7.03248, 0),
				uv_offset_rot = Vector3(0.0543599, 0.973251, 0),
				pattern_tweak = Vector3(0.634393, 0, 1)
			}
		}
	}
	self.weapon_skins.judge_bloodbath = {}
	self.weapon_skins.judge_bloodbath.name_id = "bm_wskn_judge_bloodbath"
	self.weapon_skins.judge_bloodbath.desc_id = "bm_wskn_judge_bloodbath_desc"
	self.weapon_skins.judge_bloodbath.weapon_id = "judge"
	self.weapon_skins.judge_bloodbath.rarity = "common"
	self.weapon_skins.judge_bloodbath.bonus = "spread_p1"
	self.weapon_skins.judge_bloodbath.reserve_quality = true
	self.weapon_skins.judge_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.judge_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_001_df")
	self.weapon_skins.judge_bloodbath.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_003_df")
	self.weapon_skins.judge_bloodbath.pattern_tweak = Vector3(0.586694, 0, 1)
	self.weapon_skins.judge_bloodbath.pattern_pos = Vector3(0.254233, -0.364308, 0)
	self.weapon_skins.judge_bloodbath.parts = {
		wpn_fps_pis_judge_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df")
			}
		},
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_cylinder"):key()] = {
				pattern_pos = Vector3(0.39463, -0.442546, 0),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df"),
				pattern_tweak = Vector3(0.513996, 0, 1)
			},
			[Idstring("mtr_frame"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_hypnotic_001_df")
			}
		}
	}
	self.weapon_skins.b92fs_bloodbath = {}
	self.weapon_skins.b92fs_bloodbath.name_id = "bm_wskn_b92fs_bloodbath"
	self.weapon_skins.b92fs_bloodbath.desc_id = "bm_wskn_b92fs_bloodbath_desc"
	self.weapon_skins.b92fs_bloodbath.weapon_id = "b92fs"
	self.weapon_skins.b92fs_bloodbath.rarity = "uncommon"
	self.weapon_skins.b92fs_bloodbath.bonus = "spread_p1"
	self.weapon_skins.b92fs_bloodbath.reserve_quality = true
	self.weapon_skins.b92fs_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.b92fs_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_002_df")
	self.weapon_skins.b92fs_bloodbath.pattern_gradient = Idstring("units/payday2_cash/safes/default/pattern_gradient/gradient_default_df")
	self.weapon_skins.b92fs_bloodbath.parts = {
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_003_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_scales_df"),
				pattern_pos = Vector3(0, 0.048, 0),
				pattern_tweak = Vector3(2.44694, 0, 1)
			}
		},
		wpn_fps_pis_beretta_sl_std = {
			[Idstring("std_slide"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_001_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_scales_df"),
				pattern_pos = Vector3(0, -0.432626, 0),
				pattern_tweak = Vector3(3.01932, 0, 1)
			}
		}
	}
	self.weapon_skins.new_raging_bull_bloodbath = {}
	self.weapon_skins.new_raging_bull_bloodbath.name_id = "bm_wskn_new_raging_bull_bloodbath"
	self.weapon_skins.new_raging_bull_bloodbath.desc_id = "bm_wskn_new_raging_bull_bloodbath_desc"
	self.weapon_skins.new_raging_bull_bloodbath.weapon_id = "new_raging_bull"
	self.weapon_skins.new_raging_bull_bloodbath.rarity = "common"
	self.weapon_skins.new_raging_bull_bloodbath.bonus = "recoil_p1"
	self.weapon_skins.new_raging_bull_bloodbath.reserve_quality = true
	self.weapon_skins.new_raging_bull_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.new_raging_bull_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_001_df")
	self.weapon_skins.new_raging_bull_bloodbath.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_017_df")
	self.weapon_skins.new_raging_bull_bloodbath.pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_stains_df")
	self.weapon_skins.new_raging_bull_bloodbath.pattern_tweak = Vector3(0.830488, 0.037, 1)
	self.weapon_skins.new_raging_bull_bloodbath.pattern_pos = Vector3(0.521345, 0.37825, 0)
	self.weapon_skins.new_raging_bull_bloodbath.parts = {
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				pattern_tweak = Vector3(1.39757, 0, 1)
			}
		},
		wpn_fps_pis_rage_g_standard = {
			[Idstring("grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/red/base_gradient/base_red_fleur_df")
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				pattern_tweak = Vector3(1.63606, 0, 1)
			}
		},
		wpn_fps_pis_rage_body_standard = {
			[Idstring("cylinder"):key()] = {
				pattern_pos = Vector3(0, -0.232292, 0),
				pattern_tweak = Vector3(3.21011, 0, 1)
			}
		},
		wpn_fps_pis_rage_b_comp1 = {
			[Idstring("comp1"):key()] = {
				pattern_pos = Vector3(0.759838, -0.019, 0)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				pattern_tweak = Vector3(1.68376, 0, 1)
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				pattern_tweak = Vector3(1.63606, 0, 1)
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				pattern_tweak = Vector3(3.5917, 0, 1)
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				pattern_tweak = Vector3(1.34987, 0, 1)
			}
		},
		wpn_fps_pis_rage_o_adapter = {
			[Idstring("mtr_rail"):key()] = {
				pattern_tweak = Vector3(2.16075, 0, 1)
			}
		},
		wpn_fps_pis_rage_b_comp2 = {
			[Idstring("comp2"):key()] = {
				pattern_pos = Vector3(-0.690198, 0, 0)
			}
		},
		wpn_fps_pis_rage_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/red/base_gradient/base_red_fleur_df")
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				pattern_tweak = Vector3(1.63606, 0, 1)
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				pattern_tweak = Vector3(1.68376, 0, 1)
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				pattern_tweak = Vector3(1.73146, 0, 0.997)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				pattern_tweak = Vector3(1.39757, 0, 1)
			}
		},
		wpn_fps_pis_rage_b_long = {
			[Idstring("barrel_long"):key()] = {
				pattern_tweak = Vector3(1.06368, 0, 1)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				pattern_tweak = Vector3(1.96995, 0, 1)
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				pattern_tweak = Vector3(1.73146, 0, 1)
			}
		},
		wpn_fps_pis_rage_body_smooth = {
			[Idstring("smooth"):key()] = {
				pattern_tweak = Vector3(1.87455, 0, 1)
			}
		}
	}
	self.weapon_skins.mg42_bloodbath = {}
	self.weapon_skins.mg42_bloodbath.name_id = "bm_wskn_mg42_bloodbath"
	self.weapon_skins.mg42_bloodbath.desc_id = "bm_wskn_mg42_bloodbath_desc"
	self.weapon_skins.mg42_bloodbath.weapon_id = "mg42"
	self.weapon_skins.mg42_bloodbath.rarity = "rare"
	self.weapon_skins.mg42_bloodbath.bonus = "spread_p1"
	self.weapon_skins.mg42_bloodbath.reserve_quality = true
	self.weapon_skins.mg42_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.mg42_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_002_df")
	self.weapon_skins.mg42_bloodbath.default_blueprint = {
		"wpn_fps_lmg_mg42_reciever",
		"wpn_fps_lmg_mg42_b_mg34",
		"wpn_fps_upg_ass_ns_jprifles",
		"wpn_fps_upg_fl_ass_utg"
	}
	self.weapon_skins.mg42_bloodbath.parts = {
		wpn_fps_lmg_mg42_reciever = {
			[Idstring("wpn_fps_ass_fal_base_nm"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dinner/sticker/sticker_butcher_df"),
				uv_offset_rot = Vector3(0.406869, 0.998331, 5.06941),
				pattern_gradient = Idstring("units/payday2_cash/safes/dinner/pattern_gradient/gradient_din_meat_df"),
				pattern_pos = Vector3(0.401488, 0.156757, 0),
				uv_scale = Vector3(8.79645, 8.5104, 0),
				pattern = Idstring("units/payday2_cash/safes/dinner/pattern/pattern_meat_hook_df"),
				pattern_tweak = Vector3(6.9783, 0.648849, 1)
			}
		}
	}
	self.weapon_skins.plainsrider_bloodbath = {}
	self.weapon_skins.plainsrider_bloodbath.name_id = "bm_wskn_plainsrider_bloodbath"
	self.weapon_skins.plainsrider_bloodbath.desc_id = "bm_wskn_plainsrider_bloodbath_desc"
	self.weapon_skins.plainsrider_bloodbath.weapon_id = "plainsrider"
	self.weapon_skins.plainsrider_bloodbath.rarity = "common"
	self.weapon_skins.plainsrider_bloodbath.bonus = "concealment_p1"
	self.weapon_skins.plainsrider_bloodbath.reserve_quality = true
	self.weapon_skins.plainsrider_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.plainsrider_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_001_df")
	self.weapon_skins.new_m4_bloodbath = {}
	self.weapon_skins.new_m4_bloodbath.name_id = "bm_wskn_new_m4_bloodbath"
	self.weapon_skins.new_m4_bloodbath.desc_id = "bm_wskn_new_m4_bloodbath_desc"
	self.weapon_skins.new_m4_bloodbath.weapon_id = "new_m4"
	self.weapon_skins.new_m4_bloodbath.rarity = "uncommon"
	self.weapon_skins.new_m4_bloodbath.bonus = "spread_p1"
	self.weapon_skins.new_m4_bloodbath.reserve_quality = true
	self.weapon_skins.new_m4_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.new_m4_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_001_df")
	self.weapon_skins.g36_bloodbath = {}
	self.weapon_skins.g36_bloodbath.name_id = "bm_wskn_g36_bloodbath"
	self.weapon_skins.g36_bloodbath.desc_id = "bm_wskn_g36_bloodbath_desc"
	self.weapon_skins.g36_bloodbath.weapon_id = "g36"
	self.weapon_skins.g36_bloodbath.rarity = "epic"
	self.weapon_skins.g36_bloodbath.bonus = "spread_p1"
	self.weapon_skins.g36_bloodbath.reserve_quality = true
	self.weapon_skins.g36_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.g36_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_003_df")
	self.weapon_skins.g36_bloodbath.pattern_gradient = Idstring("units/payday2_cash/safes/dinner/pattern_gradient/gradient_din_warning_df")
	self.weapon_skins.g36_bloodbath.pattern = Idstring("units/payday2_cash/safes/dinner/pattern/pattern_warning_tape_df")
	self.weapon_skins.g36_bloodbath.cubemap_pattern_control = Vector3(0.3, 0.3, 0)
	self.weapon_skins.g36_bloodbath.default_blueprint = {
		"wpn_fps_ass_g36_m_standard",
		"wpn_fps_ass_g36_b_long",
		"wpn_fps_ass_g36_fg_ksk",
		"wpn_fps_upg_fl_ass_utg",
		"wpn_fps_ass_g36_s_sl8",
		"wpn_fps_upg_ass_ns_surefire"
	}
	self.weapon_skins.g36_bloodbath.parts = {
		wpn_fps_ass_g36_fg_ksk = {
			[Idstring("ksk"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df")
			}
		},
		wpn_fps_upg_g36_fg_long = {
			[Idstring("mtr_fg_g36"):key()] = {
				pattern_tweak = Vector3(2.30384, 0, 1),
				pattern_pos = Vector3(-0.28953, 0.225614, 0)
			}
		},
		wpn_fps_ass_g36_s_sl8 = {
			[Idstring("sl8"):key()] = {
				pattern_pos = Vector3(0.0157406, 0.282853, 0)
			}
		},
		wpn_fps_ass_g36_body_sl8 = {
			[Idstring("base"):key()] = {
				pattern_tweak = Vector3(1.68376, 0, 1),
				uv_offset_rot = Vector3(-0.112275, 0.831616, 0),
				uv_scale = Vector3(2.12199, 6.22201, 0.475316),
				pattern_pos = Vector3(0.0920584, -0.0605769, 0),
				sticker = Idstring("units/payday2_cash/safes/dinner/sticker/sticker_assaultinprogress")
			}
		},
		wpn_fps_ass_g36_body_standard = {
			[Idstring("base"):key()] = {
				pattern_tweak = Vector3(1.82686, 0, 1),
				uv_offset_rot = Vector3(-0.0916564, 0.836695, 0),
				uv_scale = Vector3(1.88362, 6.50806, 0.174815),
				pattern_pos = Vector3(0.079979, 0.027, 0),
				sticker = Idstring("units/payday2_cash/safes/dinner/sticker/sticker_assaultinprogress")
			}
		}
	}
	self.weapon_skins.flamethrower_mk2_bloodbath = {}
	self.weapon_skins.flamethrower_mk2_bloodbath.name_id = "bm_wskn_flamethrower_mk2_bloodbath"
	self.weapon_skins.flamethrower_mk2_bloodbath.desc_id = "bm_wskn_flamethrower_mk2_bloodbath_desc"
	self.weapon_skins.flamethrower_mk2_bloodbath.weapon_id = "flamethrower_mk2"
	self.weapon_skins.flamethrower_mk2_bloodbath.rarity = "uncommon"
	self.weapon_skins.flamethrower_mk2_bloodbath.bonus = "damage_p1"
	self.weapon_skins.flamethrower_mk2_bloodbath.reserve_quality = true
	self.weapon_skins.flamethrower_mk2_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.flamethrower_mk2_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_002_df")
	self.weapon_skins.flamethrower_mk2_bloodbath.pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_stripe_df")
	self.weapon_skins.flamethrower_mk2_bloodbath.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_005_df")
	self.weapon_skins.flamethrower_mk2_bloodbath.parts = {
		wpn_fps_fla_mk2_body = {
			[Idstring("body"):key()] = {
				pattern_pos = Vector3(0, -0.0128784, 0),
				pattern_tweak = Vector3(3.8302, 2.11741, 1)
			}
		},
		wpn_fps_fla_mk2_mag = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern_pos = Vector3(0, -0.0128784, 0),
				pattern_tweak = Vector3(1.30217, 2.11741, 1)
			}
		},
		wpn_fps_fla_mk2_mag_rare = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern_pos = Vector3(0, -0.0128784, 0),
				pattern_tweak = Vector3(1.30217, 2.11741, 1)
			}
		},
		wpn_fps_fla_mk2_mag_welldone = {
			[Idstring("flame_fuel_can"):key()] = {
				pattern_pos = Vector3(0, -0.0128784, 0),
				pattern_tweak = Vector3(1.30217, 2.11741, 1)
			}
		}
	}
	self.weapon_skins.deagle_bloodbath = {}
	self.weapon_skins.deagle_bloodbath.name_id = "bm_wskn_deagle_bloodbath"
	self.weapon_skins.deagle_bloodbath.desc_id = "bm_wskn_deagle_bloodbath_desc"
	self.weapon_skins.deagle_bloodbath.weapon_id = "deagle"
	self.weapon_skins.deagle_bloodbath.rarity = "common"
	self.weapon_skins.deagle_bloodbath.bonus = "recoil_p1"
	self.weapon_skins.deagle_bloodbath.reserve_quality = true
	self.weapon_skins.deagle_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.deagle_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_004_df")
	self.weapon_skins.deagle_bloodbath.parts = {
		wpn_fps_pis_deagle_body_standard = {
			[Idstring("base"):key()] = {
				uv_offset_rot = Vector3(0.137297, 0.896394, 0),
				sticker = Idstring("units/payday2_cash/safes/dinner/sticker/sticker_assaultinprogress"),
				uv_scale = Vector3(3.12316, 13.7546, 0)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
			}
		}
	}
	self.weapon_skins.rpg7_bloodbath = {}
	self.weapon_skins.rpg7_bloodbath.name_id = "bm_wskn_rpg7_bloodbath"
	self.weapon_skins.rpg7_bloodbath.desc_id = "bm_wskn_rpg7_bloodbath_desc"
	self.weapon_skins.rpg7_bloodbath.weapon_id = "rpg7"
	self.weapon_skins.rpg7_bloodbath.rarity = "rare"
	self.weapon_skins.rpg7_bloodbath.bonus = "spread_p1"
	self.weapon_skins.rpg7_bloodbath.reserve_quality = true
	self.weapon_skins.rpg7_bloodbath.texture_bundle_folder = "cash/safes/dinner"
	self.weapon_skins.rpg7_bloodbath.base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_002_df")
	self.weapon_skins.rpg7_bloodbath.parts = {
		wpn_fps_rpg7_m_rocket = {
			[Idstring("mtr_rocket"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_005_df"),
				uv_offset_rot = Vector3(0.225614, 1.05557, 0.663833),
				sticker = Idstring("units/payday2_cash/safes/dinner/sticker/sticker_radioactive"),
				uv_scale = Vector3(8.36738, 8.36738, 1)
			}
		},
		wpn_fps_rpg7_body = {
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dinner/sticker/sticker_maycauseharm"),
				uv_scale = Vector3(1.45455, 10.4651, 1),
				uv_offset_rot = Vector3(0.145836, 1.02895, 3.13535)
			}
		}
	}
	self.weapon_skins.new_raging_bull_dallas = {}
	self.weapon_skins.new_raging_bull_dallas.name_id = "bm_wskn_new_raging_bull_dallas"
	self.weapon_skins.new_raging_bull_dallas.desc_id = "bm_wskn_new_raging_bull_dallas_desc"
	self.weapon_skins.new_raging_bull_dallas.weapon_id = "new_raging_bull"
	self.weapon_skins.new_raging_bull_dallas.rarity = "common"
	self.weapon_skins.new_raging_bull_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.new_raging_bull_dallas.reserve_quality = true
	self.weapon_skins.new_raging_bull_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.new_raging_bull_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df")
	self.weapon_skins.new_raging_bull_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df")
	self.weapon_skins.new_raging_bull_dallas.pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df")
	self.weapon_skins.new_raging_bull_dallas.pattern_tweak = Vector3(1.25447, 0, 1)
	self.weapon_skins.new_raging_bull_dallas.pattern_pos = Vector3(-0.00333858, -1.27212, 0)
	self.weapon_skins.mg42_dallas = {}
	self.weapon_skins.mg42_dallas.name_id = "bm_wskn_mg42_dallas"
	self.weapon_skins.mg42_dallas.desc_id = "bm_wskn_mg42_dallas_desc"
	self.weapon_skins.mg42_dallas.weapon_id = "mg42"
	self.weapon_skins.mg42_dallas.reserve_quality = true
	self.weapon_skins.mg42_dallas.rarity = "common"
	self.weapon_skins.mg42_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.mg42_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.mg42_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.famas_dallas = {}
	self.weapon_skins.famas_dallas.name_id = "bm_wskn_famas_dallas"
	self.weapon_skins.famas_dallas.desc_id = "bm_wskn_famas_dallas_desc"
	self.weapon_skins.famas_dallas.weapon_id = "famas"
	self.weapon_skins.famas_dallas.reserve_quality = true
	self.weapon_skins.famas_dallas.rarity = "common"
	self.weapon_skins.famas_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.famas_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.famas_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
	self.weapon_skins.famas_dallas.parts = {
		wpn_fps_ass_famas_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df"),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
				pattern_pos = Vector3(0.0920584, 0.244694, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df"),
				pattern_tweak = Vector3(7.12139, 0, 1)
			}
		},
		wpn_fps_ass_famas_g_retro = {
			[Idstring("mtr_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df"),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
				pattern_pos = Vector3(0.37825, -0.108275, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df"),
				pattern_tweak = Vector3(1.92225, 0, 1)
			}
		},
		wpn_fps_ass_famas_g_standard = {
			[Idstring("mtr_grip_2"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df"),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
				pattern_pos = Vector3(0.37825, -0.108275, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df"),
				pattern_tweak = Vector3(1.92225, 0, 1)
			}
		}
	}
	self.weapon_skins.flamethrower_mk2_dallas = {}
	self.weapon_skins.flamethrower_mk2_dallas.name_id = "bm_wskn_flamethrower_mk2_dallas"
	self.weapon_skins.flamethrower_mk2_dallas.desc_id = "bm_wskn_flamethrower_mk2_dallas_desc"
	self.weapon_skins.flamethrower_mk2_dallas.weapon_id = "flamethrower_mk2"
	self.weapon_skins.flamethrower_mk2_dallas.rarity = "common"
	self.weapon_skins.flamethrower_mk2_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.flamethrower_mk2_dallas.reserve_quality = true
	self.weapon_skins.flamethrower_mk2_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.flamethrower_mk2_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.flamethrower_mk2_dallas.types = {
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
		}
	}
	self.weapon_skins.huntsman_dallas = {}
	self.weapon_skins.huntsman_dallas.name_id = "bm_wskn_huntsman_dallas"
	self.weapon_skins.huntsman_dallas.desc_id = "bm_wskn_huntsman_dallas_desc"
	self.weapon_skins.huntsman_dallas.weapon_id = "huntsman"
	self.weapon_skins.huntsman_dallas.rarity = "common"
	self.weapon_skins.huntsman_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.huntsman_dallas.reserve_quality = true
	self.weapon_skins.huntsman_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.huntsman_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_004_df")
	self.weapon_skins.huntsman_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df")
	self.weapon_skins.huntsman_dallas.pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_snakeskin_df")
	self.weapon_skins.huntsman_dallas.pattern_tweak = Vector3(2.54233, 0, 1)
	self.weapon_skins.r93_dallas = {}
	self.weapon_skins.r93_dallas.name_id = "bm_wskn_r93_dallas"
	self.weapon_skins.r93_dallas.desc_id = "bm_wskn_r93_dallas_desc"
	self.weapon_skins.r93_dallas.weapon_id = "r93"
	self.weapon_skins.r93_dallas.reserve_quality = true
	self.weapon_skins.r93_dallas.rarity = "common"
	self.weapon_skins.r93_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.r93_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.r93_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
	self.weapon_skins.r93_dallas.pattern_tweak = Vector3(5.97663, 0, 1)
	self.weapon_skins.r93_dallas.parts = {
		wpn_fps_snp_r93_body_standard = {
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df"),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_snakeskin_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df")
			}
		},
		wpn_fps_snp_r93_body_wood = {
			[Idstring("mtr_wooden"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df"),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_snakeskin_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df"),
				pattern_tweak = Vector3(7.35989, 0, 1)
			},
			[Idstring("mtr_pouch"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_tactical_001_df")
			}
		}
	}
	self.weapon_skins.ak74_dallas = {}
	self.weapon_skins.ak74_dallas.name_id = "bm_wskn_ak74_dallas"
	self.weapon_skins.ak74_dallas.desc_id = "bm_wskn_ak74_dallas_desc"
	self.weapon_skins.ak74_dallas.weapon_id = "ak74"
	self.weapon_skins.ak74_dallas.reserve_quality = true
	self.weapon_skins.ak74_dallas.rarity = "uncommon"
	self.weapon_skins.ak74_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.ak74_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.ak74_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df")
	self.weapon_skins.ak74_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df")
	self.weapon_skins.ak74_dallas.pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_snakeskin_df")
	self.weapon_skins.ak74_dallas.pattern_tweak = Vector3(2.11305, 0, 1)
	self.weapon_skins.ak74_dallas.pattern_pos = Vector3(0, 0.101598, 0)
	self.weapon_skins.ak74_dallas.types = {
		magazine = {
			pattern_tweak = Vector3(2.92392, 0, 1)
		}
	}
	self.weapon_skins.ppk_dallas = {}
	self.weapon_skins.ppk_dallas.name_id = "bm_wskn_ppk_dallas"
	self.weapon_skins.ppk_dallas.desc_id = "bm_wskn_ppk_dallas_desc"
	self.weapon_skins.ppk_dallas.weapon_id = "ppk"
	self.weapon_skins.ppk_dallas.reserve_quality = true
	self.weapon_skins.ppk_dallas.rarity = "uncommon"
	self.weapon_skins.ppk_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.ppk_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.ppk_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.ppk_dallas.parts = {
		wpn_fps_pis_ppk_b_standard = {
			[Idstring("mtr_slide"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_eagle_wings_df"),
				uv_scale = Vector3(1.54989, 2.31269, 1),
				uv_offset_rot = Vector3(0.340091, 0.962251, 0)
			}
		},
		wpn_fps_pis_ppk_b_long = {
			[Idstring("mtr_slide_long"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_eagle_wings_df"),
				uv_offset_rot = Vector3(0.174678, 0.973711, 0),
				uv_scale = Vector3(2.21834, 2.83911, 1)
			}
		}
	}
	self.weapon_skins.deagle_dallas = {}
	self.weapon_skins.deagle_dallas.name_id = "bm_wskn_deagle_dallas"
	self.weapon_skins.deagle_dallas.desc_id = "bm_wskn_deagle_dallas_desc"
	self.weapon_skins.deagle_dallas.weapon_id = "deagle"
	self.weapon_skins.deagle_dallas.rarity = "uncommon"
	self.weapon_skins.deagle_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.deagle_dallas.reserve_quality = true
	self.weapon_skins.deagle_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.deagle_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
	self.weapon_skins.deagle_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_004_df")
	self.weapon_skins.deagle_dallas.pattern_tweak = Vector3(1.39757, 3.15133, 1)
	self.weapon_skins.deagle_dallas.pattern_pos = Vector3(0.187455, -0.117815, 0)
	self.weapon_skins.deagle_dallas.types = {
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df"),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_snakeskin_df"),
			pattern_tweak = Vector3(1.54067, 0, 1)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df"),
			pattern_pos = Vector3(0.168376, -0.089196, 0),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_snakeskin_df"),
			pattern_tweak = Vector3(0.967981, 0, 1)
		}
	}
	self.weapon_skins.new_m14_dallas = {}
	self.weapon_skins.new_m14_dallas.name_id = "bm_wskn_new_m14_dallas"
	self.weapon_skins.new_m14_dallas.desc_id = "bm_wskn_new_m14_dallas_desc"
	self.weapon_skins.new_m14_dallas.weapon_id = "new_m14"
	self.weapon_skins.new_m14_dallas.rarity = "uncommon"
	self.weapon_skins.new_m14_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.new_m14_dallas.reserve_quality = true
	self.weapon_skins.new_m14_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.new_m14_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df")
	self.weapon_skins.new_m14_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_002_df")
	self.weapon_skins.new_m14_dallas.pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df")
	self.weapon_skins.new_m14_dallas.pattern_tweak = Vector3(6.9783, 0, 1)
	self.weapon_skins.new_m14_dallas.parts = {
		wpn_fps_ass_m14_body_dmr = {
			[Idstring("dmr1"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_texaslonghorn_df"),
				uv_scale = Vector3(2.88479, 2.69409, 0),
				uv_offset_rot = Vector3(0.069979, 0.926473, 0.22927)
			}
		},
		wpn_fps_ass_m14_body_upper = {
			[Idstring("base"):key()] = {
				uv_scale = Vector3(1.02547, 0.834774, 1),
				uv_offset_rot = Vector3(0.310932, 0.598203, 0.109391)
			}
		},
		wpn_fps_ass_m14_body_ebr = {
			[Idstring("ebr"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_texaslonghorn_df"),
				uv_scale = Vector3(3.02781, 4.02898, 1),
				uv_offset_rot = Vector3(0.05682, 0.909473, 0.28921)
			}
		},
		wpn_fps_ass_m14_m_standard = {
			[Idstring("mag"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_texaslonghorn_df"),
				uv_scale = Vector3(1.21617, 1.26385, 1),
				uv_offset_rot = Vector3(0.00666143, 0.801917, 0.22927)
			}
		},
		wpn_fps_ass_m14_body_jae = {
			[Idstring("jae"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_texaslonghorn_df"),
				uv_scale = Vector3(3.45688, 3.31386, 0),
				uv_offset_rot = Vector3(0.151297, 0.932553, 0.1993)
			}
		},
		wpn_fps_ass_m14_body_lower = {
			[Idstring("lower"):key()] = {
				uv_scale = Vector3(1.3592, 0.69175, 1),
				uv_offset_rot = Vector3(0.120677, 0.874536, 0)
			}
		}
	}
	self.weapon_skins.judge_dallas = {}
	self.weapon_skins.judge_dallas.name_id = "bm_wskn_judge_dallas"
	self.weapon_skins.judge_dallas.desc_id = "bm_wskn_judge_dallas_desc"
	self.weapon_skins.judge_dallas.weapon_id = "judge"
	self.weapon_skins.judge_dallas.reserve_quality = true
	self.weapon_skins.judge_dallas.rarity = "rare"
	self.weapon_skins.judge_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.judge_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.judge_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.judge_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df")
	self.weapon_skins.judge_dallas.default_blueprint = {
		"wpn_fps_pis_judge_body_standard",
		"wpn_fps_pis_judge_b_standard",
		"wpn_fps_pis_judge_g_standard",
		"wpn_fps_upg_a_explosive",
		"wpn_fps_upg_shot_ns_king"
	}
	self.weapon_skins.judge_dallas.parts = {
		wpn_fps_pis_judge_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_american_flag_df"),
				uv_scale = Vector3(0.596401, 0.548726, 0.243978),
				uv_offset_rot = Vector3(0, 1.06065, 0)
			}
		},
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_cylinder"):key()] = {
				pattern_pos = Vector3(0, -0.442165, 0),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
				pattern_tweak = Vector3(2.87622, 0, 0)
			},
			[Idstring("mtr_frame"):key()] = {
				pattern_pos = Vector3(0, -0.0409577, 0),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
				pattern_tweak = Vector3(4.92726, 0, 1)
			}
		}
	}
	self.weapon_skins.b92fs_dallas = {}
	self.weapon_skins.b92fs_dallas.name_id = "bm_wskn_b92fs_dallas"
	self.weapon_skins.b92fs_dallas.desc_id = "bm_wskn_b92fs_dallas_desc"
	self.weapon_skins.b92fs_dallas.weapon_id = "b92fs"
	self.weapon_skins.b92fs_dallas.reserve_quality = true
	self.weapon_skins.b92fs_dallas.rarity = "rare"
	self.weapon_skins.b92fs_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.b92fs_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.b92fs_dallas.base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
	self.weapon_skins.b92fs_dallas.pattern_tweak = Vector3(4.45028, 1.45804, 1)
	self.weapon_skins.b92fs_dallas.parts = {
		wpn_fps_pis_beretta_g_std = {
			[Idstring("std_grips"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_dallas_logo_df"),
				uv_scale = Vector3(11.7046, 11.7046, 1),
				uv_offset_rot = Vector3(0.0147406, 0.770139, 6.05841)
			}
		},
		wpn_fps_pis_beretta_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df"),
				uv_offset_rot = Vector3(-0.0510372, 0.7026, 6.04343),
				pattern_pos = Vector3(0, -0.308609, 0),
				uv_scale = Vector3(9.32087, 8.8918, 0),
				cubemap_pattern_control = Vector3(0.0555689, 1, 0),
				pattern_tweak = Vector3(2.35154, 1.56293, 1)
			}
		}
	}
	self.weapon_skins.b92fs_dallas.types = {
		grip = {
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df")
		}
	}
	self.weapon_skins.b92fs_dallas.default_blueprint = {
		"wpn_fps_pis_beretta_body_beretta",
		"wpn_fps_pis_beretta_b_std",
		"wpn_fps_pis_beretta_sl_brigadier",
		"wpn_fps_pis_beretta_m_extended",
		"wpn_fps_pis_beretta_g_std",
		"wpn_fps_upg_ns_pis_jungle",
		"wpn_fps_pis_beretta_o_std"
	}
	self.weapon_skins.serbu_dallas = {}
	self.weapon_skins.serbu_dallas.name_id = "bm_wskn_serbu_dallas"
	self.weapon_skins.serbu_dallas.desc_id = "bm_wskn_serbu_dallas_desc"
	self.weapon_skins.serbu_dallas.weapon_id = "serbu"
	self.weapon_skins.serbu_dallas.rarity = "rare"
	self.weapon_skins.serbu_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.serbu_dallas.reserve_quality = true
	self.weapon_skins.serbu_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.serbu_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.serbu_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df")
	self.weapon_skins.serbu_dallas.cubemap_pattern_control = Vector3(0.329836, 0.625566, 0)
	self.weapon_skins.serbu_dallas.default_blueprint = {
		"wpn_fps_shot_r870_body_standard",
		"wpn_fps_shot_r870_b_short",
		"wpn_fps_shot_r870_fg_small",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_upg_m4_g_ergo",
		"wpn_fps_shot_shorty_m_extended_short",
		"wpn_fps_shot_shorty_s_solid_short",
		"wpn_fps_upg_a_explosive"
	}
	self.weapon_skins.serbu_dallas.types = {
		lower_reciever = {
			pattern_pos = Vector3(0, -0.003, 0),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
			pattern_tweak = Vector3(2.16075, 0, 1)
		},
		stock = {
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
			pattern_tweak = Vector3(2.54233, 0, 1)
		},
		lower_body = {
			pattern_tweak = Vector3(2.25614, 0, 1)
		}
	}
	self.weapon_skins.serbu_dallas.parts = {
		wpn_fps_shot_r870_fg_small = {
			[Idstring("short_pump"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_american_flag_df"),
				uv_scale = Vector3(0.596401, 0.69175, 0),
				uv_offset_rot = Vector3(-0.00333858, 1.01741, 0)
			}
		}
	}
	self.weapon_skins.g36_dallas = {}
	self.weapon_skins.g36_dallas.name_id = "bm_wskn_g36_dallas"
	self.weapon_skins.g36_dallas.desc_id = "bm_wskn_g36_dallas_desc"
	self.weapon_skins.g36_dallas.weapon_id = "g36"
	self.weapon_skins.g36_dallas.rarity = "epic"
	self.weapon_skins.g36_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.g36_dallas.reserve_quality = true
	self.weapon_skins.g36_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.g36_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.g36_dallas.default_blueprint = {
		"wpn_fps_ass_g36_m_standard",
		"wpn_fps_ass_g36_b_long",
		"wpn_fps_ass_g36_fg_ksk",
		"wpn_fps_upg_fl_ass_utg",
		"wpn_fps_ass_g36_s_sl8",
		"wpn_fps_upg_ass_ns_surefire"
	}
	self.weapon_skins.g36_dallas.parts = {
		wpn_fps_ass_g36_s_sl8 = {
			[Idstring("sl8"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_do_not_thread_df"),
				uv_scale = Vector3(0.882449, 1.26385, 0.5),
				uv_offset_rot = Vector3(0.769378, 0.211455, 5.54892)
			}
		},
		wpn_fps_ass_g36_body_sl8 = {
			[Idstring("base"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_do_not_thread_df"),
				uv_scale = Vector3(0.888449, 1.11248, 0.5),
				uv_offset_rot = Vector3(-0.489864, 0.594884, 5.84862)
			}
		},
		wpn_fps_ass_g36_g_standard = {
			[Idstring("grip"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_do_not_thread_df"),
				uv_scale = Vector3(0.548726, 0.882449, 1),
				uv_offset_rot = Vector3(0.0261216, 0.715679, 6.06543)
			}
		},
		wpn_fps_ass_g36_body_standard = {
			[Idstring("base"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_do_not_thread_df"),
				uv_scale = Vector3(1, 1.02547, 1),
				uv_offset_rot = Vector3(-0.241831, 0.578583, 5.93853)
			}
		}
	}
	self.weapon_skins.g36_dallas.types = {
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
		}
	}
	self.weapon_skins.m95_dallas = {}
	self.weapon_skins.m95_dallas.name_id = "bm_wskn_m95_dallas"
	self.weapon_skins.m95_dallas.desc_id = "bm_wskn_m95_dallas_desc"
	self.weapon_skins.m95_dallas.weapon_id = "m95"
	self.weapon_skins.m95_dallas.rarity = "epic"
	self.weapon_skins.m95_dallas.bonus = "team_exp_money_p3"
	self.weapon_skins.m95_dallas.reserve_quality = true
	self.weapon_skins.m95_dallas.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.m95_dallas.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_002_df")
	self.weapon_skins.m95_dallas.pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_stars_df")
	self.weapon_skins.m95_dallas.default_blueprint = {
		"wpn_fps_snp_m95_bipod",
		"wpn_fps_snp_m95_lower_reciever",
		"wpn_fps_snp_m95_upper_reciever",
		"wpn_fps_snp_m95_magazine",
		"wpn_fps_snp_m95_barrel_long",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_upg_o_leupold"
	}
	self.weapon_skins.m95_dallas.parts = {
		wpn_fps_snp_m95_upper_reciever = {
			[Idstring("mtr_upper"):key()] = {
				pattern_pos = Vector3(0, -0.005, 0),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
				pattern_tweak = Vector3(6.11973, 0.184315, 1)
			}
		},
		wpn_fps_snp_m95_lower_reciever = {
			[Idstring("mtr_lower"):key()] = {
				pattern_pos = Vector3(0.230154, -0.658499, 0),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
				pattern_tweak = Vector3(5.30885, 0.304195, 1)
			}
		},
		wpn_fps_snp_m95_barrel_short = {
			[Idstring("mtr_muzzlebreak"):key()] = {
				uv_scale = Vector3(0.358028, 0.358028, 1),
				uv_offset_rot = Vector3(1.72335, 1.4467, 0)
			},
			[Idstring("mtr_long1"):key()] = {
				uv_scale = Vector3(0.405702, 0.405702, 1),
				uv_offset_rot = Vector3(1.00787, 1.4944, 0)
			}
		},
		wpn_fps_snp_m95_barrel_suppressed = {
			[Idstring("mtr_suppressed"):key()] = {
				uv_scale = Vector3(1.63957, 1.45455, 1),
				uv_offset_rot = Vector3(0.062979, 0.970154, 0)
			}
		}
	}
	self.weapon_skins.m95_dallas.types = {
		barrel = {
			sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_american_flag_df"),
			uv_scale = Vector3(1.26385, 1.12082, 1),
			uv_offset_rot = Vector3(0.173059, 0.969712, 0),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_waveylines_df"),
			pattern_tweak = Vector3(7.026, 0.169331, 1)
		}
	}
	self.weapon_skins.p90_dallas_sallad = {}
	self.weapon_skins.p90_dallas_sallad.name_id = "bm_wskn_p90_dallas_sallad"
	self.weapon_skins.p90_dallas_sallad.desc_id = "bm_wskn_p90_dallas_sallad_desc"
	self.weapon_skins.p90_dallas_sallad.weapon_id = "p90"
	self.weapon_skins.p90_dallas_sallad.rarity = "legendary"
	self.weapon_skins.p90_dallas_sallad.bonus = "team_exp_money_p3"
	self.weapon_skins.p90_dallas_sallad.reserve_quality = true
	self.weapon_skins.p90_dallas_sallad.unique_name_id = "bm_wskn_p90_dallas_sallad"
	self.weapon_skins.p90_dallas_sallad.locked = true
	self.weapon_skins.p90_dallas_sallad.texture_bundle_folder = "cash/safes/dallas"
	self.weapon_skins.p90_dallas_sallad.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_005_df")
	self.weapon_skins.p90_dallas_sallad.pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df")
	self.weapon_skins.p90_dallas_sallad.pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_smoke_df")
	self.weapon_skins.p90_dallas_sallad.pattern_tweak = Vector3(1, 0, 0)
	self.weapon_skins.p90_dallas_sallad.default_blueprint = {
		"wpn_fps_smg_p90_body_p90",
		"wpn_fps_smg_p90_m_std",
		"wpn_fps_smg_p90_b_legend",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_fl_ass_utg"
	}
	self.weapon_skins.p90_dallas_sallad.parts = {
		wpn_fps_smg_p90_body_p90 = {
			[Idstring("p90"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_molon_labe_df"),
				uv_scale = Vector3(2.64641, 5.26852, 0.0555689),
				uv_offset_rot = Vector3(-0.194212, 0.896394, 0)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/dallas/sticker/sticker_delta_df"),
				uv_scale = Vector3(7.35821, 8.93947, 0.401383),
				uv_offset_rot = Vector3(-0.380086, 0.584203, 0)
			}
		}
	}
	self.weapon_skins.p90_dallas_sallad.types = {
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_001_df"),
			pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/default/pattern_gradient/gradient_default_df")
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df"),
			pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/default/pattern_gradient/gradient_default_df")
		}
	}
	self.weapon_skins.akm_waves = {}
	self.weapon_skins.akm_waves.name_id = "bm_wskn_akm_waves"
	self.weapon_skins.akm_waves.desc_id = "bm_wskn_akm_waves_desc"
	self.weapon_skins.akm_waves.weapon_id = "akm"
	self.weapon_skins.akm_waves.rarity = "common"
	self.weapon_skins.akm_waves.bonus = "spread_p1"
	self.weapon_skins.akm_waves.reserve_quality = true
	self.weapon_skins.akm_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.akm_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_001_df")
	self.weapon_skins.asval_waves = {}
	self.weapon_skins.asval_waves.name_id = "bm_wskn_asval_waves"
	self.weapon_skins.asval_waves.desc_id = "bm_wskn_asval_waves_desc"
	self.weapon_skins.asval_waves.weapon_id = "asval"
	self.weapon_skins.asval_waves.rarity = "common"
	self.weapon_skins.asval_waves.bonus = "spread_p1"
	self.weapon_skins.asval_waves.reserve_quality = true
	self.weapon_skins.asval_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.asval_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_002_df")
	self.weapon_skins.asval_waves.types = {
		foregrip = {
			pattern_pos = Vector3(-0.404006, 0.797997, 0),
			pattern_tweak = Vector3(1.68376, 1.5929, 1),
			pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_003b_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_003_df")
		}
	}
	self.weapon_skins.m16_waves = {}
	self.weapon_skins.m16_waves.name_id = "bm_wskn_m16_waves"
	self.weapon_skins.m16_waves.desc_id = "bm_wskn_m16_waves_desc"
	self.weapon_skins.m16_waves.weapon_id = "m16"
	self.weapon_skins.m16_waves.rarity = "common"
	self.weapon_skins.m16_waves.bonus = "recoil_p1"
	self.weapon_skins.m16_waves.reserve_quality = true
	self.weapon_skins.m16_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.m16_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_003_df")
	self.weapon_skins.baka_waves = {}
	self.weapon_skins.baka_waves.name_id = "bm_wskn_baka_waves"
	self.weapon_skins.baka_waves.desc_id = "bm_wskn_baka_waves_desc"
	self.weapon_skins.baka_waves.weapon_id = "baka"
	self.weapon_skins.baka_waves.rarity = "common"
	self.weapon_skins.baka_waves.bonus = "recoil_p1"
	self.weapon_skins.baka_waves.reserve_quality = true
	self.weapon_skins.baka_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.baka_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_005_df")
	self.weapon_skins.baka_waves.pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_003_df")
	self.weapon_skins.baka_waves.pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_003b_df")
	self.weapon_skins.baka_waves.pattern_tweak = Vector3(1.96995, 0, 1)
	self.weapon_skins.s552_waves = {}
	self.weapon_skins.s552_waves.name_id = "bm_wskn_s552_waves"
	self.weapon_skins.s552_waves.desc_id = "bm_wskn_s552_waves_desc"
	self.weapon_skins.s552_waves.weapon_id = "s552"
	self.weapon_skins.s552_waves.rarity = "common"
	self.weapon_skins.s552_waves.bonus = "spread_p1"
	self.weapon_skins.s552_waves.reserve_quality = true
	self.weapon_skins.s552_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.s552_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_005_df")
	self.weapon_skins.s552_waves.pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_003_df")
	self.weapon_skins.s552_waves.pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_003b_df")
	self.weapon_skins.s552_waves.pattern_tweak = Vector3(2.30384, 0.768728, 1)
	self.weapon_skins.s552_waves.pattern_pos = Vector3(-0.0701165, -0.27999, 0)
	self.weapon_skins.usp_waves = {}
	self.weapon_skins.usp_waves.name_id = "bm_wskn_usp_waves"
	self.weapon_skins.usp_waves.desc_id = "bm_wskn_usp_waves_desc"
	self.weapon_skins.usp_waves.weapon_id = "usp"
	self.weapon_skins.usp_waves.rarity = "common"
	self.weapon_skins.usp_waves.bonus = "spread_p1"
	self.weapon_skins.usp_waves.reserve_quality = true
	self.weapon_skins.usp_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.usp_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_006_df")
	self.weapon_skins.mac10_waves = {}
	self.weapon_skins.mac10_waves.name_id = "bm_wskn_mac10_waves"
	self.weapon_skins.mac10_waves.desc_id = "bm_wskn_mac10_waves_desc"
	self.weapon_skins.mac10_waves.weapon_id = "mac10"
	self.weapon_skins.mac10_waves.rarity = "uncommon"
	self.weapon_skins.mac10_waves.bonus = "recoil_p1"
	self.weapon_skins.mac10_waves.reserve_quality = true
	self.weapon_skins.mac10_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.mac10_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_007_df")
	self.weapon_skins.mac10_waves.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_009_df")
	self.weapon_skins.mac10_waves.pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_001_df")
	self.weapon_skins.mac10_waves.pattern_tweak = Vector3(9.60172, 3.13635, 1)
	self.weapon_skins.mac10_waves.pattern_pos = Vector3(-0.127355, 0.177916, 0)
	self.weapon_skins.mac10_waves.uv_offset_rot = Vector3(-1.23396, 0, 6.28319)
	self.weapon_skins.mac10_waves.cubemap_pattern_control = Vector3(0.286907, 1, 0)
	self.weapon_skins.mac10_waves.parts = {
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				pattern_pos = Vector3(0.36179, 0.405249, 0),
				pattern_tweak = Vector3(1.73146, 1.54794, 1)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		}
	}
	self.weapon_skins.aug_waves = {}
	self.weapon_skins.aug_waves.name_id = "bm_wskn_aug_waves"
	self.weapon_skins.aug_waves.desc_id = "bm_wskn_aug_waves_desc"
	self.weapon_skins.aug_waves.weapon_id = "aug"
	self.weapon_skins.aug_waves.rarity = "uncommon"
	self.weapon_skins.aug_waves.bonus = "recoil_p1"
	self.weapon_skins.aug_waves.reserve_quality = true
	self.weapon_skins.aug_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.aug_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_008_df")
	self.weapon_skins.aug_waves.parts = {
		wpn_fps_aug_body_aug = {
			[Idstring("aug"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_004_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_005_df"),
				pattern_pos = Vector3(-0.0244975, -0.00387842, 0),
				pattern_tweak = Vector3(1, 3.16632, 1)
			}
		},
		wpn_fps_aug_body_f90 = {
			[Idstring("mtr_f90"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_004_df"),
				pattern_pos = Vector3(0.00620103, 0.68352, 0),
				pattern_tweak = Vector3(1.15908, 3.04644, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_005_df")
			}
		}
	}
	self.weapon_skins.aug_waves.types = {
		vertical_grip = {
			base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_008_b_df")
		}
	}
	self.weapon_skins.scar_waves = {}
	self.weapon_skins.scar_waves.name_id = "bm_wskn_scar_waves"
	self.weapon_skins.scar_waves.desc_id = "bm_wskn_scar_waves_desc"
	self.weapon_skins.scar_waves.weapon_id = "scar"
	self.weapon_skins.scar_waves.rarity = "uncommon"
	self.weapon_skins.scar_waves.bonus = "spread_p1"
	self.weapon_skins.scar_waves.reserve_quality = true
	self.weapon_skins.scar_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.scar_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_009_b_df")
	self.weapon_skins.scar_waves.types = {
		barrel_ext = {
			pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_001_df"),
			pattern_pos = Vector3(-0.0701165, 0.36871, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_004_df"),
			pattern_tweak = Vector3(0.586694, 4.72475, 1)
		}
	}
	self.weapon_skins.scar_waves.parts = {
		wpn_fps_ass_scar_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_009_df")
			},
			[Idstring("mtr_upper"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_001_df"),
				pattern_pos = Vector3(0.177916, -0.909611, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_004_df"),
				pattern_tweak = Vector3(1.06368, 0, 1)
			}
		},
		wpn_fps_upg_vg_ass_smg_afg = {
			[Idstring("afg"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_009_df")
			}
		},
		wpn_fps_ass_scar_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_009_df")
			}
		}
	}
	self.weapon_skins.colt_1911_waves = {}
	self.weapon_skins.colt_1911_waves.name_id = "bm_wskn_colt_1911_waves"
	self.weapon_skins.colt_1911_waves.desc_id = "bm_wskn_colt_1911_waves_desc"
	self.weapon_skins.colt_1911_waves.weapon_id = "colt_1911"
	self.weapon_skins.colt_1911_waves.rarity = "uncommon"
	self.weapon_skins.colt_1911_waves.bonus = "spread_p1"
	self.weapon_skins.colt_1911_waves.reserve_quality = true
	self.weapon_skins.colt_1911_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.colt_1911_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_010_df")
	self.weapon_skins.colt_1911_waves.parts = {
		wpn_fps_pis_1911_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_010_df")
			}
		},
		wpn_fps_pis_1911_g_bling = {
			[Idstring("bling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_010_b_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_005_df"),
				pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_002_df")
			}
		}
	}
	self.weapon_skins.colt_1911_waves.types = {
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_010_b_df")
		},
		barrel_ext = {
			pattern_pos = Vector3(0, -0.327689, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_005_df"),
			pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_002_df"),
			pattern_tweak = Vector3(1.68376, 0, 1)
		},
		slide = {
			pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_002_df"),
			pattern_pos = Vector3(-0.146434, -0.27045, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_005_df"),
			pattern_tweak = Vector3(3.7378, 0, 1)
		}
	}
	self.weapon_skins.polymer_waves = {}
	self.weapon_skins.polymer_waves.name_id = "bm_wskn_polymer_waves"
	self.weapon_skins.polymer_waves.desc_id = "bm_wskn_polymer_waves_desc"
	self.weapon_skins.polymer_waves.weapon_id = "polymer"
	self.weapon_skins.polymer_waves.rarity = "rare"
	self.weapon_skins.polymer_waves.bonus = "spread_p1"
	self.weapon_skins.polymer_waves.reserve_quality = true
	self.weapon_skins.polymer_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.polymer_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_011_df")
	self.weapon_skins.polymer_waves.default_blueprint = {
		"wpn_fps_smg_polymer_body_standard",
		"wpn_fps_smg_polymer_bolt_standard",
		"wpn_fps_smg_polymer_dh_standard",
		"wpn_fps_smg_polymer_extra_sling",
		"wpn_fps_smg_polymer_fg_standard",
		"wpn_fps_smg_polymer_barrel_standard",
		"wpn_fps_smg_polymer_m_standard",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_o_reflex",
		"wpn_fps_upg_m4_s_mk46"
	}
	self.weapon_skins.polymer_waves.parts = {
		wpn_fps_smg_polymer_body_standard = {
			[Idstring("mtr_body"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_004_df"),
				pattern_pos = Vector3(-0.112275, 0.00566143, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_checker_df"),
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_011_b_df"),
				pattern_tweak = Vector3(1.20678, 0, 1)
			}
		}
	}
	self.weapon_skins.polymer_waves.types = {
		barrel_ext = {
			pattern_pos = Vector3(0.0443599, 1.46578, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_checker_df"),
			pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_004_df"),
			pattern_tweak = Vector3(0.443599, 0, 1)
		}
	}
	self.weapon_skins.ak5_waves = {}
	self.weapon_skins.ak5_waves.name_id = "bm_wskn_ak5_waves"
	self.weapon_skins.ak5_waves.desc_id = "bm_wskn_ak5_waves_desc"
	self.weapon_skins.ak5_waves.weapon_id = "ak5"
	self.weapon_skins.ak5_waves.rarity = "rare"
	self.weapon_skins.ak5_waves.bonus = "spread_p1"
	self.weapon_skins.ak5_waves.reserve_quality = true
	self.weapon_skins.ak5_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.ak5_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_012_df")
	self.weapon_skins.ak5_waves.pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_002_b_df")
	self.weapon_skins.ak5_waves.pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_003c_df")
	self.weapon_skins.ak5_waves.pattern_tweak = Vector3(4.25948, 0, 0)
	self.weapon_skins.ak5_waves.pattern_pos = Vector3(-0.00333858, 0.225614, 0)
	self.weapon_skins.ak5_waves.default_blueprint = {
		"wpn_fps_ass_ak5_body_ak5",
		"wpn_fps_ass_ak5_b_short",
		"wpn_fps_ass_ak5_s_ak5b",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_m4_m_quad",
		"wpn_fps_ass_ak5_fg_ak5c",
		"wpn_fps_upg_ass_ns_surefire"
	}
	self.weapon_skins.ak5_waves.parts = {
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_bodhi_df"),
				uv_scale = Vector3(5.07782, 5.64992, 1),
				uv_offset_rot = Vector3(-0.379387, 0.585123, 0)
			}
		}
	}
	self.weapon_skins.mosin_waves = {}
	self.weapon_skins.mosin_waves.name_id = "bm_wskn_mosin_waves"
	self.weapon_skins.mosin_waves.desc_id = "bm_wskn_mosin_waves_desc"
	self.weapon_skins.mosin_waves.weapon_id = "mosin"
	self.weapon_skins.mosin_waves.rarity = "rare"
	self.weapon_skins.mosin_waves.bonus = "total_ammo_p1"
	self.weapon_skins.mosin_waves.reserve_quality = true
	self.weapon_skins.mosin_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.mosin_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_013_df")
	self.weapon_skins.mosin_waves.pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_001_df")
	self.weapon_skins.mosin_waves.pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df")
	self.weapon_skins.mosin_waves.pattern_tweak = Vector3(6.31052, 0, 1)
	self.weapon_skins.mosin_waves.pattern_pos = Vector3(-0.0128784, -0.194133, 0)
	self.weapon_skins.mosin_waves.default_blueprint = {
		"wpn_fps_snp_mosin_m_standard",
		"wpn_fps_snp_mosin_body_black",
		"wpn_fps_upg_o_leupold",
		"wpn_fps_snp_mosin_b_short"
	}
	self.weapon_skins.mosin_waves.parts = {
		wpn_fps_snp_mosin_b_sniper = {
			[Idstring("mtr_sniper"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_013_b_df"),
				pattern_tweak = Vector3(12.3682, 5.474, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_002_df"),
				pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_001_df")
			}
		},
		wpn_fps_snp_mosin_body_standard = {
			[Idstring("mtr_body"):key()] = {
				uv_offset_rot = Vector3(-0.00141802, 0.986171, 3.05149),
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(1.20017, 4.45805, 1)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df")
			}
		},
		wpn_fps_upg_o_box = {
			[Idstring("mtr_box"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_003_df")
			}
		},
		wpn_fps_snp_mosin_body_black = {
			[Idstring("mtr_body"):key()] = {
				uv_offset_rot = Vector3(-0.00141802, 0.986171, 3.05149),
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(1.20017, 4.45805, 1)
			}
		}
	}
	self.weapon_skins.mosin_waves.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_013_c_df")
		}
	}
	self.weapon_skins.striker_waves = {}
	self.weapon_skins.striker_waves.name_id = "bm_wskn_striker_waves"
	self.weapon_skins.striker_waves.desc_id = "bm_wskn_striker_waves_desc"
	self.weapon_skins.striker_waves.weapon_id = "striker"
	self.weapon_skins.striker_waves.rarity = "epic"
	self.weapon_skins.striker_waves.bonus = "spread_p1"
	self.weapon_skins.striker_waves.reserve_quality = true
	self.weapon_skins.striker_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.striker_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_014_df")
	self.weapon_skins.striker_waves.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df")
	self.weapon_skins.striker_waves.pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_001_df")
	self.weapon_skins.striker_waves.pattern_tweak = Vector3(7.78917, 2.32716, 1)
	self.weapon_skins.striker_waves.default_blueprint = {
		"wpn_fps_sho_striker_body_standard",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_shot_ns_king",
		"wpn_fps_sho_striker_b_standard"
	}
	self.weapon_skins.striker_waves.parts = {
		wpn_fps_sho_striker_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(0.644076, 1.83594, 0),
				uv_offset_rot = Vector3(-0.62034, 0.623583, 3.13635)
			}
		},
		wpn_fps_sho_striker_b_long = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(0.644076, 1.83594, 0),
				uv_offset_rot = Vector3(-0.62034, 0.623583, 3.13635)
			}
		},
		wpn_fps_sho_striker_b_suppressed = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(0.644076, 1.83594, 0),
				uv_offset_rot = Vector3(-0.62034, 0.623583, 3.13635)
			}
		},
		wpn_fps_sho_striker_body_standard = {
			[Idstring("mtr_rail"):key()] = {
				uv_scale = Vector3(3.40921, 0.882449, 1),
				uv_offset_rot = Vector3(0.0268201, 0.931553, 1.62287)
			},
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(0.834774, 3.17083, 0),
				uv_offset_rot = Vector3(0.206995, 0.951632, 3.15235)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
				uv_scale = Vector3(1.50222, 0.69175, 1),
				uv_offset_rot = Vector3(0.349631, 0.902934, 1.36813)
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				uv_scale = Vector3(3.93363, 1, 1),
				uv_offset_rot = Vector3(-0.0987357, 0.979251, 1.51798)
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				uv_scale = Vector3(2.83711, 0.69175, 1),
				uv_offset_rot = Vector3(0.0538995, 1.13189, 4.73974)
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				uv_scale = Vector3(2.16967, 0.739425, 1),
				uv_offset_rot = Vector3(0.153678, 0.998331, 1.50299)
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				uv_scale = Vector3(2.26502, 0.596401, 1),
				uv_offset_rot = Vector3(0.169376, 1.21774, 1.53296)
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				uv_scale = Vector3(2.02664, 0.69175, 1),
				uv_offset_rot = Vector3(0.134757, 1.06957, 4.76971)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				uv_scale = Vector3(2.26502, 0.644076, 1),
				uv_offset_rot = Vector3(-0.0414975, 0.454567, 1.50299)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				uv_scale = Vector3(2.36004, 0.834774, 1),
				uv_offset_rot = Vector3(0.032582, 1.31314, 1.50299)
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				uv_scale = Vector3(1.17817, 0.413027, 1),
				uv_offset_rot = Vector3(-0.00133858, 1.52125, 1.57791)
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				uv_scale = Vector3(2.55106, 0.69175, 1),
				uv_offset_rot = Vector3(0.0915188, 0.530885, 4.64888)
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				uv_scale = Vector3(1.64524, 0.531727, 1),
				uv_offset_rot = Vector3(0.220075, 1.399, 1.49997)
			}
		}
	}
	self.weapon_skins.striker_waves.types = {
		sight = {
			sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_waves_df"),
			uv_scale = Vector3(1.59757, 0.760425, 1),
			uv_offset_rot = Vector3(0.244694, 1.24636, 1.50001)
		}
	}
	self.weapon_skins.x_g22c_waves = {}
	self.weapon_skins.x_g22c_waves.name_id = "bm_wskn_x_g22c_waves"
	self.weapon_skins.x_g22c_waves.desc_id = "bm_wskn_x_g22c_waves_desc"
	self.weapon_skins.x_g22c_waves.weapon_id = "x_g22c"
	self.weapon_skins.x_g22c_waves.rarity = "epic"
	self.weapon_skins.x_g22c_waves.bonus = "recoil_p1"
	self.weapon_skins.x_g22c_waves.reserve_quality = true
	self.weapon_skins.x_g22c_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.x_g22c_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_015_df")
	self.weapon_skins.x_g22c_waves.pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_005_df")
	self.weapon_skins.x_g22c_waves.pattern = Idstring("units/payday2_cash/safes/surf/pattern/pattern_surf_002b_df")
	self.weapon_skins.x_g22c_waves.pattern_tweak = Vector3(3.49631, 0, 1)
	self.weapon_skins.x_g22c_waves.pattern_pos = Vector3(0.216075, -0.432626, 0)
	self.weapon_skins.x_g22c_waves.cubemap_pattern_control = Vector3(0.3513, 1, 0)
	self.weapon_skins.x_g22c_waves.default_blueprint = {
		"wpn_fps_pis_g22c_b_standard",
		"wpn_fps_pis_g22c_body_standard",
		"wpn_fps_pis_g18c_m_mag_33rnd",
		"wpn_fps_pis_g18c_g_ergo",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_upg_ns_pis_ipsccomp"
	}
	self.weapon_skins.x_g22c_waves.parts = {
		wpn_fps_pis_g22c_b_standard = {
			[Idstring("mtr_g22c"):key()] = {
				pattern_pos = Vector3(0, 0.35917, 0),
				pattern_tweak = Vector3(2.68543, 0, 1)
			}
		},
		wpn_fps_upg_fl_pis_crimson = {
			[Idstring("mtr_crimson"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_009_df")
			}
		},
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_010_b_df")
			}
		}
	}
	self.weapon_skins.x_g22c_waves.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_015_b_df")
		}
	}
	self.weapon_skins.r870_waves = {}
	self.weapon_skins.r870_waves.name_id = "bm_wskn_r870_waves"
	self.weapon_skins.r870_waves.desc_id = "bm_wskn_r870_waves_desc"
	self.weapon_skins.r870_waves.weapon_id = "r870"
	self.weapon_skins.r870_waves.rarity = "legendary"
	self.weapon_skins.r870_waves.bonus = "spread_n1"
	self.weapon_skins.r870_waves.reserve_quality = true
	self.weapon_skins.r870_waves.texture_bundle_folder = "cash/safes/surf"
	self.weapon_skins.r870_waves.unique_name_id = "bm_wskn_r870_waves"
	self.weapon_skins.r870_waves.locked = true
	self.weapon_skins.r870_waves.base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_017_df")
	self.weapon_skins.r870_waves.default_blueprint = {
		"wpn_fps_shot_r870_body_standard",
		"wpn_fps_shot_r870_b_legendary",
		"wpn_fps_shot_r870_fg_legendary",
		"wpn_fps_shot_r870_s_legendary"
	}
	self.weapon_skins.r870_waves.parts = {
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_legendary_big_df"),
				uv_scale = Vector3(0.78745, 0.787775, 1),
				uv_offset_rot = Vector3(-0.132736, 1.12235, 0)
			}
		},
		wpn_fps_shot_r870_b_legendary = {
			[Idstring("long_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_legendary_big_df"),
				uv_scale = Vector3(0.834774, 0.930124, 1),
				uv_offset_rot = Vector3(-0.165514, 1.10327, 3.15133)
			},
			[Idstring("mtr_legendary_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_legendary_big_df"),
				uv_offset_rot = Vector3(0.184614, 1.15697, 1.61487),
				uv_scale = Vector3(2.79044, 2.59874, 1),
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_tactical_001_df")
			}
		}
	}
	self.weapon_skins.r870_waves.types = {
		foregrip = {
			pattern_pos = Vector3(-0.842833, 0.130217, 0),
			pattern_tweak = Vector3(2.92392, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_002_df")
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/surf/sticker/sticker_legendary_small_df"),
			uv_offset_rot = Vector3(-0.323229, 0.956632, 4.91956),
			pattern_tweak = Vector3(2.73313, 1.5929, 1),
			pattern_pos = Vector3(-0.127355, -0.585261, 0),
			uv_scale = Vector3(19.9523, 20, 1),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_002_df")
		}
	}
	self.weapon_skins.saiga_ginger = {}
	self.weapon_skins.saiga_ginger.name_id = "bm_wskn_saiga_ginger"
	self.weapon_skins.saiga_ginger.desc_id = "bm_wskn_saiga_ginger_desc"
	self.weapon_skins.saiga_ginger.weapon_id = "saiga"
	self.weapon_skins.saiga_ginger.rarity = "common"
	self.weapon_skins.saiga_ginger.bonus = "total_ammo_p1"
	self.weapon_skins.saiga_ginger.reserve_quality = true
	self.weapon_skins.saiga_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.saiga_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_001_df")
	self.weapon_skins.saiga_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/flake_pattern_gradient_01_df")
	self.weapon_skins.saiga_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_01_df")
	self.weapon_skins.saiga_ginger.pattern_tweak = Vector3(0.491297, 1.17332, 1)
	self.weapon_skins.saiga_ginger.pattern_pos = Vector3(-0.642499, 0, 0)
	self.weapon_skins.saiga_ginger.cubemap_pattern_control = Vector3(1, 0, 0)
	self.weapon_skins.saiga_ginger.parts = {
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				pattern_tweak = Vector3(2.39924, 0, 1)
			}
		}
	}
	self.weapon_skins.p226_ginger = {}
	self.weapon_skins.p226_ginger.name_id = "bm_wskn_p226_ginger"
	self.weapon_skins.p226_ginger.desc_id = "bm_wskn_p226_ginger_desc"
	self.weapon_skins.p226_ginger.weapon_id = "p226"
	self.weapon_skins.p226_ginger.rarity = "common"
	self.weapon_skins.p226_ginger.bonus = "spread_p1"
	self.weapon_skins.p226_ginger.reserve_quality = true
	self.weapon_skins.p226_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.p226_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_002_df")
	self.weapon_skins.p226_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/flake_pattern_gradient_01_df")
	self.weapon_skins.p226_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_01_df")
	self.weapon_skins.p226_ginger.pattern_tweak = Vector3(2.39924, 1.26323, 0)
	self.weapon_skins.p226_ginger.pattern_pos = Vector3(-0.480324, -0.480324, 0)
	self.weapon_skins.new_mp5_ginger = {}
	self.weapon_skins.new_mp5_ginger.name_id = "bm_wskn_new_mp5_ginger"
	self.weapon_skins.new_mp5_ginger.desc_id = "bm_wskn_new_mp5_ginger_desc"
	self.weapon_skins.new_mp5_ginger.weapon_id = "new_mp5"
	self.weapon_skins.new_mp5_ginger.rarity = "common"
	self.weapon_skins.new_mp5_ginger.bonus = "spread_p1"
	self.weapon_skins.new_mp5_ginger.reserve_quality = true
	self.weapon_skins.new_mp5_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.new_mp5_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003_df")
	self.weapon_skins.new_mp5_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_003b_df")
	self.weapon_skins.new_mp5_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_03_df")
	self.weapon_skins.new_mp5_ginger.pattern_tweak = Vector3(1, 0, 0)
	self.weapon_skins.new_mp5_ginger.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003c_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003c_df")
		}
	}
	self.weapon_skins.m249_ginger = {}
	self.weapon_skins.m249_ginger.name_id = "bm_wskn_m249_ginger"
	self.weapon_skins.m249_ginger.desc_id = "bm_wskn_m249_ginger_desc"
	self.weapon_skins.m249_ginger.weapon_id = "m249"
	self.weapon_skins.m249_ginger.rarity = "common"
	self.weapon_skins.m249_ginger.bonus = "spread_p1"
	self.weapon_skins.m249_ginger.reserve_quality = true
	self.weapon_skins.m249_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.m249_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_004_df")
	self.weapon_skins.m249_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_002_df")
	self.weapon_skins.m249_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_01_df")
	self.weapon_skins.m249_ginger.pattern_tweak = Vector3(2.64073, 0, 0)
	self.weapon_skins.m249_ginger.pattern_pos = Vector3(0.159836, 0.445409, 0)
	self.weapon_skins.m249_ginger.types = {
		gadget = {
			pattern_tweak = Vector3(0.777488, 0, 1)
		},
		barrel = {
			pattern_pos = Vector3(-0.308609, -0.127355, 0),
			pattern_tweak = Vector3(0.348202, 0, 1)
		},
		stock = {
			pattern_pos = Vector3(0.158836, 0.0252805, 0),
			pattern_tweak = Vector3(1.30217, 0, 1)
		},
		upper_reciever = {
			pattern_pos = Vector3(-0.105196, 0.0853599, 0),
			pattern_tweak = Vector3(1.21038, 0, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_004_b_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_004_b_df")
		},
		barrel_ext = {
			pattern_pos = Vector3(0, 0.0323599, 0),
			pattern_tweak = Vector3(0.703091, 0, 1)
		}
	}
	self.weapon_skins.x_b92fs_ginger = {}
	self.weapon_skins.x_b92fs_ginger.name_id = "bm_wskn_x_b92fs_ginger"
	self.weapon_skins.x_b92fs_ginger.desc_id = "bm_wskn_x_b92fs_ginger_desc"
	self.weapon_skins.x_b92fs_ginger.weapon_id = "x_b92fs"
	self.weapon_skins.x_b92fs_ginger.rarity = "uncommon"
	self.weapon_skins.x_b92fs_ginger.bonus = "recoil_p1"
	self.weapon_skins.x_b92fs_ginger.reserve_quality = true
	self.weapon_skins.x_b92fs_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.x_b92fs_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_df")
	self.weapon_skins.x_b92fs_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_001_df")
	self.weapon_skins.x_b92fs_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_02_df")
	self.weapon_skins.x_b92fs_ginger.pattern_tweak = Vector3(1.37487, 3.14536, 1)
	self.weapon_skins.x_b92fs_ginger.pattern_pos = Vector3(0.0764394, 0.447488, 0)
	self.weapon_skins.x_b92fs_ginger.parts = {
		wpn_fps_pis_beretta_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_b_df")
			}
		},
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				pattern_pos = Vector3(-0.032, -0.27599, 0)
			}
		},
		wpn_fps_pis_beretta_sl_std = {
			[Idstring("std_slide"):key()] = {
				pattern_pos = Vector3(0.14444, 0.428488, 0)
			}
		},
		wpn_fps_pis_beretta_body_rail = {
			[Idstring("front_rail"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_b_df"),
				pattern_pos = Vector3(0.00620103, 0, 0)
			}
		},
		wpn_fps_pis_beretta_body_beretta = {
			[Idstring("body"):key()] = {
				pattern_pos = Vector3(-0.039, -0.26572, 0),
				pattern_tweak = Vector3(1.96995, 0, 1)
			}
		}
	}
	self.weapon_skins.x_b92fs_ginger.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_b_df")
		},
		lower_reciever = {
			pattern_pos = Vector3(0.00620103, 0.0157406, 0)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_b_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_b_df")
		}
	}
	self.weapon_skins.ksg_ginger = {}
	self.weapon_skins.ksg_ginger.name_id = "bm_wskn_ksg_ginger"
	self.weapon_skins.ksg_ginger.desc_id = "bm_wskn_ksg_ginger_desc"
	self.weapon_skins.ksg_ginger.weapon_id = "ksg"
	self.weapon_skins.ksg_ginger.rarity = "uncommon"
	self.weapon_skins.ksg_ginger.bonus = "spread_n1"
	self.weapon_skins.ksg_ginger.reserve_quality = true
	self.weapon_skins.ksg_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.ksg_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_006_df")
	self.weapon_skins.ksg_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_002_df")
	self.weapon_skins.ksg_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_02_df")
	self.weapon_skins.ksg_ginger.parts = {
		wpn_fps_sho_ksg_body_standard = {
			[Idstring("mat_body"):key()] = {
				pattern_pos = Vector3(0.155297, 0.339011, 0),
				pattern_tweak = Vector3(2.20844, 1.57791, 1)
			}
		},
		wpn_fps_sho_ksg_fg_short = {
			[Idstring("mat_pump"):key()] = {
				pattern_pos = Vector3(0.0322805, 0.387789, 0),
				pattern_tweak = Vector3(1.73146, 1.62287, 1)
			}
		},
		wpn_fps_upg_ns_sho_salvo_large = {
			[Idstring("mtr_salvo_large"):key()] = {
				pattern_pos = Vector3(0.012, -0.995468, 0),
				pattern_tweak = Vector3(1.11138, 1.5769, 1)
			}
		}
	}
	self.weapon_skins.ksg_ginger.types = {
		sight = {
			pattern_tweak = Vector3(0.825187, 1.56293, 1)
		},
		foregrip = {
			pattern_pos = Vector3(-0.006, 0.055, 0),
			pattern_tweak = Vector3(1.54067, 1.54396, 1)
		},
		gadget = {
			pattern_pos = Vector3(0.35917, 0.511806, 0),
			pattern_tweak = Vector3(0.634393, 1.57791, 1)
		},
		barrel = {
			pattern_pos = Vector3(0.0784394, 0.797997, 0),
			pattern_tweak = Vector3(1.25447, 1.5929, 1)
		},
		barrel_ext = {
			pattern_tweak = Vector3(0.348202, 1.57791, 1)
		}
	}
	self.weapon_skins.m1928_ginger = {}
	self.weapon_skins.m1928_ginger.name_id = "bm_wskn_m1928_ginger"
	self.weapon_skins.m1928_ginger.desc_id = "bm_wskn_m1928_ginger_desc"
	self.weapon_skins.m1928_ginger.weapon_id = "m1928"
	self.weapon_skins.m1928_ginger.rarity = "uncommon"
	self.weapon_skins.m1928_ginger.bonus = "spread_p1"
	self.weapon_skins.m1928_ginger.reserve_quality = true
	self.weapon_skins.m1928_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.m1928_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003b_df")
	self.weapon_skins.m1928_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_003b_df")
	self.weapon_skins.m1928_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_09_df")
	self.weapon_skins.m1928_ginger.pattern_tweak = Vector3(7.55068, 1.87761, 0)
	self.weapon_skins.m1928_ginger.pattern_pos = Vector3(-0.0796564, -0.508943, 0)
	self.weapon_skins.m1928_ginger.uv_scale = Vector3(1, 1, 0)
	self.weapon_skins.m1928_ginger.types = {
		foregrip = {
			pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_003_df"),
			pattern_tweak = Vector3(4.25948, 0.25924, 1)
		},
		stock = {
			pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_003_df"),
			pattern_tweak = Vector3(4.64107, 0, 1)
		},
		grip = {
			pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_003_df"),
			pattern_tweak = Vector3(3.35321, 1.38311, 1)
		}
	}
	self.weapon_skins.g22c_ginger = {}
	self.weapon_skins.g22c_ginger.name_id = "bm_wskn_g22c_ginger"
	self.weapon_skins.g22c_ginger.desc_id = "bm_wskn_g22c_ginger_desc"
	self.weapon_skins.g22c_ginger.weapon_id = "g22c"
	self.weapon_skins.g22c_ginger.rarity = "rare"
	self.weapon_skins.g22c_ginger.bonus = "spread_p1"
	self.weapon_skins.g22c_ginger.reserve_quality = true
	self.weapon_skins.g22c_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.g22c_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_008_df")
	self.weapon_skins.g22c_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_002_df")
	self.weapon_skins.g22c_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_02_df")
	self.weapon_skins.g22c_ginger.uv_scale = Vector3(1, 1, 0)
	self.weapon_skins.g22c_ginger.cubemap_pattern_control = Vector3(0.630336, 0.635106, 0)
	self.weapon_skins.g22c_ginger.default_blueprint = {
		"wpn_fps_pis_g22c_body_standard",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_pis_g18c_g_ergo",
		"wpn_fps_pis_g18c_m_mag_33rnd",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_pis_g22c_b_standard",
		"wpn_fps_upg_ns_pis_ipsccomp"
	}
	self.weapon_skins.g22c_ginger.parts = {
		wpn_fps_pis_g22c_b_standard = {
			[Idstring("mtr_g22c"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/flake/sticker/sticker_g22c_df"),
				uv_offset_rot = Vector3(0.109058, 1.05979, 0),
				pattern_pos = Vector3(0.099598, 0.306472, 0),
				uv_scale = Vector3(2.26502, 2.26502, 0),
				pattern_tweak = Vector3(1.77916, 0, 1)
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				pattern_pos = Vector3(-0.089196, 0.177455, 0)
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				pattern_pos = Vector3(-0.0656563, 0.165297, 0)
			}
		},
		wpn_fps_pis_g18c_co_1 = {
			[Idstring("comp1"):key()] = {
				pattern_pos = Vector3(0.288853, 0.273773, 0),
				pattern_tweak = Vector3(0.872886, 1.54794, 1)
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				pattern_pos = Vector3(0.0157406, -0.572721, 0),
				pattern_tweak = Vector3(1.20678, 0, 1)
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				pattern_pos = Vector3(-0.251371, 0.226694, 0)
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				pattern_pos = Vector3(0.330551, 0.242694, 0),
				pattern_tweak = Vector3(1.25447, 0, 1)
			}
		},
		wpn_fps_upg_pis_ns_flash = {
			[Idstring("mtr_flash"):key()] = {
				pattern_pos = Vector3(0.168376, 0.473726, 0),
				pattern_tweak = Vector3(1.39757, 0, 1)
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				pattern_pos = Vector3(0, -0.433086, 0),
				pattern_tweak = Vector3(1.39757, 0, 1)
			}
		},
		wpn_fps_pis_g22c_body_standard = {
			[Idstring("mtr_magwell"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_008_b_df")
			}
		}
	}
	self.weapon_skins.g22c_ginger.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_008_b_df"),
			pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_01_df"),
			pattern_tweak = Vector3(0.968283, 0, 1)
		},
		lower_reciever = {
			pattern_pos = Vector3(0, 0.890235, 0),
			pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_01_df"),
			pattern_tweak = Vector3(1.68376, 0, 1)
		},
		upper_reciever = {
			pattern_tweak = Vector3(1.39757, 0, 1)
		},
		sight = {
			pattern = Idstring("units/payday2_cash/safes/flake/pattern/pattern_xmasknit_01_df")
		},
		barrel_ext = {
			pattern_pos = Vector3(0, 0.159836, 0)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_008_b_df")
		}
	}
	self.weapon_skins.wa2000_ginger = {}
	self.weapon_skins.wa2000_ginger.name_id = "bm_wskn_wa2000_ginger"
	self.weapon_skins.wa2000_ginger.desc_id = "bm_wskn_wa2000_ginger_desc"
	self.weapon_skins.wa2000_ginger.weapon_id = "wa2000"
	self.weapon_skins.wa2000_ginger.rarity = "rare"
	self.weapon_skins.wa2000_ginger.bonus = "recoil_p1"
	self.weapon_skins.wa2000_ginger.reserve_quality = true
	self.weapon_skins.wa2000_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.wa2000_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_009_df")
	self.weapon_skins.wa2000_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_01_df")
	self.weapon_skins.wa2000_ginger.pattern_tweak = Vector3(0.825187, 0, 0)
	self.weapon_skins.wa2000_ginger.pattern_pos = Vector3(-0.652039, 0.0825188, 0)
	self.weapon_skins.wa2000_ginger.uv_scale = Vector3(1, 1, 0)
	self.weapon_skins.wa2000_ginger.default_blueprint = {
		"wpn_fps_snp_wa2000_body_standard",
		"wpn_fps_snp_wa2000_m_standard",
		"wpn_fps_snp_wa2000_s_standard",
		"wpn_fps_snp_wa2000_b_long",
		"wpn_fps_snp_wa2000_g_walnut",
		"wpn_fps_upg_o_leupold",
		"wpn_fps_upg_o_45iron"
	}
	self.weapon_skins.wa2000_ginger.parts = {
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_015_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_o_box = {
			[Idstring("mtr_box"):key()] = {
				pattern_tweak = Vector3(0, 0, 1)
			}
		}
	}
	self.weapon_skins.wa2000_ginger.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_009b_df"),
			pattern_tweak = Vector3(1, 0, 0)
		},
		grip = {
			pattern_tweak = Vector3(4.73647, 0, 0),
			sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_helper_df"),
			uv_scale = Vector3(14.5651, 13.3732, 1),
			pattern_pos = Vector3(-0.337228, -0.575721, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/gradient_flake_009_df"),
			uv_offset_rot = Vector3(-0.259451, 0.664901, 0),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df")
		}
	}
	self.weapon_skins.akmsu_ginger = {}
	self.weapon_skins.akmsu_ginger.name_id = "bm_wskn_akmsu_ginger"
	self.weapon_skins.akmsu_ginger.desc_id = "bm_wskn_akmsu_ginger_desc"
	self.weapon_skins.akmsu_ginger.weapon_id = "akmsu"
	self.weapon_skins.akmsu_ginger.rarity = "epic"
	self.weapon_skins.akmsu_ginger.bonus = "spread_p1"
	self.weapon_skins.akmsu_ginger.reserve_quality = true
	self.weapon_skins.akmsu_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.akmsu_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_010_df")
	self.weapon_skins.akmsu_ginger.pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/flake_pattern_gradient_01_df")
	self.weapon_skins.akmsu_ginger.pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_01_df")
	self.weapon_skins.akmsu_ginger.pattern_tweak = Vector3(1.39757, 0, 1)
	self.weapon_skins.akmsu_ginger.pattern_pos = Vector3(0.664441, -0.127355, 0)
	self.weapon_skins.akmsu_ginger.default_blueprint = {
		"wpn_fps_smg_akmsu_body_lowerreceiver",
		"wpn_fps_ass_akm_body_upperreceiver_vanilla",
		"wpn_fps_smg_akmsu_b_standard",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_o_ak_scopemount",
		"wpn_fps_smg_akmsu_fg_rail",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_ak_m_quad"
	}
	self.weapon_skins.akmsu_ginger.parts = {
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_wonderland_df"),
				uv_scale = Vector3(1.59757, 1.54989, 1),
				uv_offset_rot = Vector3(0, 1.06511, 0)
			}
		},
		wpn_upg_ak_s_psl = {
			[Idstring("psl"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/flake_pattern_gradient_01_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_ak_s_solidstock = {
			[Idstring("mtr_solid"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_wonderland_df"),
				uv_offset_rot = Vector3(0.0443599, 0.998331, 0),
				pattern_pos = Vector3(0, -0.29907, 0),
				uv_scale = Vector3(1.1685, 1.26385, 1),
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_001_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_wonderland_df"),
				uv_scale = Vector3(0.882449, 0.882449, 1),
				uv_offset_rot = Vector3(-0.232292, 1.2082, 0)
			}
		}
	}
	self.weapon_skins.akmsu_ginger.types = {
		sight = {
			pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/flake_pattern_gradient_01_df"),
			pattern_tweak = Vector3(0, 0, 1)
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_wonderland_df"),
			uv_scale = Vector3(1.02547, 1.02547, 1),
			uv_offset_rot = Vector3(-0.232292, 1.17005, 0),
			pattern_tweak = Vector3(0, 0, 1)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_001_df"),
			uv_offset_rot = Vector3(0.00620103, 1.03649, 0),
			pattern_pos = Vector3(-0.814214, 0, 0),
			uv_scale = Vector3(1.26385, 1.1685, 1),
			sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_wonderland_df"),
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.x_1911_ginger = {}
	self.weapon_skins.x_1911_ginger.name_id = "bm_wskn_x_1911_ginger"
	self.weapon_skins.x_1911_ginger.desc_id = "bm_wskn_x_1911_ginger_desc"
	self.weapon_skins.x_1911_ginger.weapon_id = "x_1911"
	self.weapon_skins.x_1911_ginger.rarity = "legendary"
	self.weapon_skins.x_1911_ginger.bonus = "recoil_p1"
	self.weapon_skins.x_1911_ginger.reserve_quality = true
	self.weapon_skins.x_1911_ginger.texture_bundle_folder = "cash/safes/flake"
	self.weapon_skins.x_1911_ginger.unique_name_id = "bm_wskn_x_1911_ginger"
	self.weapon_skins.x_1911_ginger.locked = true
	self.weapon_skins.x_1911_ginger.base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_005_b_df")
	self.weapon_skins.x_1911_ginger.default_blueprint = {
		"wpn_fps_pis_1911_g_legendary",
		"wpn_fps_pis_1911_fl_legendary",
		"wpn_fps_pis_1911_body_standard",
		"wpn_fps_pis_1911_b_long",
		"wpn_fps_pis_1911_o_long",
		"wpn_fps_pis_1911_m_standard"
	}
	self.weapon_skins.x_1911_ginger.parts = {
		wpn_fps_pis_1911_o_long = {
			[Idstring("sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003_df")
			}
		},
		wpn_fps_pis_1911_b_long = {
			[Idstring("slide_long"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_swirl_df"),
				pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_04_df"),
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003_df"),
				uv_offset_rot = Vector3(-0.146434, 1.01741, 0),
				pattern_pos = Vector3(0.301932, 0, 0),
				uv_scale = Vector3(1.78827, 2.88479, 1),
				pattern_tweak = Vector3(1.06368, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/pattern_gradient_001_df")
			},
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003_df")
			}
		},
		wpn_fps_pis_1911_fl_legendary = {
			[Idstring("mtr_legend_laser"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/flake/sticker/flake_sticker_swirl_df"),
				uv_offset_rot = Vector3(0.158836, 1.00787, 3.36112),
				pattern_tweak = Vector3(1.87455, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/flake/pattern/flake_pattern_04_df"),
				uv_scale = Vector3(2.78944, 6.03132, 1),
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_003_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/flake/pattern_gradient/pattern_gradient_001_df")
			}
		},
		wpn_fps_pis_1911_g_legendary = {
			[Idstring("mtr_legend_grip"):key()] = {
				pattern_tweak = Vector3(5.21345, 3.04644, 1),
				pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/dallas/pattern_gradient/gradient_dallas_wood_001_df")
			}
		}
	}
	self.weapon_skins.ak5_baaah = {}
	self.weapon_skins.ak5_baaah.name_id = "bm_wskn_ak5_baaah"
	self.weapon_skins.ak5_baaah.desc_id = "bm_wskn_ak5_baaah_desc"
	self.weapon_skins.ak5_baaah.weapon_id = "ak5"
	self.weapon_skins.ak5_baaah.rarity = "common"
	self.weapon_skins.ak5_baaah.bonus = "spread_p1"
	self.weapon_skins.ak5_baaah.reserve_quality = true
	self.weapon_skins.ak5_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.ak5_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_001_df")
	self.weapon_skins.ak5_baaah.parts = {
		wpn_fps_m4_uupg_m_std_vanilla = {
			[Idstring("m4_mag_std"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
				pattern_tweak = Vector3(1, 1.54794, 1),
				pattern_pos = Vector3(-0.205673, -0.326149, 0),
				uv_scale = Vector3(3.79061, 3.79061, 0),
				uv_offset_rot = Vector3(0.00620103, -0.00333858, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_003_df")
			}
		},
		wpn_fps_ass_ak5_body_ak5 = {
			[Idstring("ak5"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_003b_df"),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_001_df"),
				pattern_tweak = Vector3(2.94533, 6.24419, 1),
				pattern_pos = Vector3(1.12119, 1.33322, 0),
				uv_scale = Vector3(3.21851, 2.74176, 0.0293347),
				uv_offset_rot = Vector3(-0.014418, 0.857315, 0.40909),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_003_df")
			}
		},
		wpn_fps_ass_ak5_s_ak5a = {
			[Idstring("stock_adam"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_001_df"),
				uv_offset_rot = Vector3(-0.0319577, -0.0319577, 4.81466),
				pattern_pos = Vector3(-0.776055, 2, 0),
				uv_scale = Vector3(2.31269, 0.01, 1),
				pattern_tweak = Vector3(0.634393, 0.22927, 1)
			}
		},
		wpn_fps_ass_ak5_b_std = {
			[Idstring("barrel"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
				pattern_tweak = Vector3(0.589694, 3.09939, 1),
				pattern_pos = Vector3(0.244694, 0.176916, 0),
				uv_scale = Vector3(1.1685, 1.07315, 1),
				uv_offset_rot = Vector3(0.597663, 0.750298, 1.53296),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_003_df")
			}
		}
	}
	self.weapon_skins.ak5_baaah.types = {
		grip = {
			uv_offset_rot = Vector3(0.559504, -0.547102, 0),
			uv_scale = Vector3(0.358028, 0.262678, 1)
		}
	}
	self.weapon_skins.wa2000_baaah = {}
	self.weapon_skins.wa2000_baaah.name_id = "bm_wskn_wa2000_baaah"
	self.weapon_skins.wa2000_baaah.desc_id = "bm_wskn_wa2000_baaah_desc"
	self.weapon_skins.wa2000_baaah.weapon_id = "wa2000"
	self.weapon_skins.wa2000_baaah.rarity = "common"
	self.weapon_skins.wa2000_baaah.bonus = "recoil_p1"
	self.weapon_skins.wa2000_baaah.reserve_quality = true
	self.weapon_skins.wa2000_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.wa2000_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df")
	self.weapon_skins.wa2000_baaah.parts = {
		wpn_fps_snp_wa2000_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_007_df"),
				uv_scale = Vector3(0.405702, 0.155329, 0),
				uv_offset_rot = Vector3(0.178376, -0.413546, 0)
			}
		},
		wpn_fps_upg_o_shortdot = {
			[Idstring("mtr_shortdot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_b_df")
			}
		},
		wpn_fps_snp_wa2000_s_standard = {
			[Idstring("mtr_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_007_df"),
				uv_scale = Vector3(0.310353, 0.215003, 1),
				uv_offset_rot = Vector3(0.001, 0, 0)
			}
		},
		wpn_fps_snp_wa2000_body_standard = {
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_004_df"),
				uv_offset_rot = Vector3(-0.0701165, 0.912473, 0.498999),
				pattern_tweak = Vector3(0.538996, 0, 1),
				pattern_pos = Vector3(-0.995468, -0.424086, 0),
				uv_scale = Vector3(9.89297, 8.84412, 0),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df")
			}
		}
	}
	self.weapon_skins.wa2000_baaah.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
			pattern_pos = Vector3(-0.547102, -0.0605769, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df"),
			pattern_tweak = Vector3(0.348202, 3.14035, 1)
		}
	}
	self.weapon_skins.r870_baaah = {}
	self.weapon_skins.r870_baaah.name_id = "bm_wskn_r870_baaah"
	self.weapon_skins.r870_baaah.desc_id = "bm_wskn_r870_baaah_desc"
	self.weapon_skins.r870_baaah.weapon_id = "r870"
	self.weapon_skins.r870_baaah.rarity = "common"
	self.weapon_skins.r870_baaah.bonus = "concealment_p1"
	self.weapon_skins.r870_baaah.reserve_quality = true
	self.weapon_skins.r870_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.r870_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_df")
	self.weapon_skins.r870_baaah.pattern_pos = Vector3(0, 0.0157406, 0)
	self.weapon_skins.r870_baaah.parts = {
		wpn_fps_shot_r870_fg_wood = {
			[Idstring("wood_pump"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_b_df")
			}
		},
		wpn_fps_shot_r870_fg_big = {
			[Idstring("big_pump"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_b_df")
			}
		},
		wpn_fps_shot_r870_b_long = {
			[Idstring("long_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_001a_df"),
				uv_offset_rot = Vector3(-0.356308, 0.740759, 0),
				uv_scale = Vector3(2.07432, 2.07432, 0),
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_b_df")
			}
		},
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_002a_df"),
				pattern_pos = Vector3(0.154836, 0.00320103, 0),
				uv_scale = Vector3(1.31152, 3.50456, 0),
				uv_offset_rot = Vector3(0.0538995, 0.864775, 0),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_004_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df")
			}
		}
	}
	self.weapon_skins.r870_baaah.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_b_df")
		}
	}
	self.weapon_skins.x_g22c_baaah = {}
	self.weapon_skins.x_g22c_baaah.name_id = "bm_wskn_x_g22c_baaah"
	self.weapon_skins.x_g22c_baaah.desc_id = "bm_wskn_x_g22c_baaah_desc"
	self.weapon_skins.x_g22c_baaah.weapon_id = "x_g22c"
	self.weapon_skins.x_g22c_baaah.rarity = "common"
	self.weapon_skins.x_g22c_baaah.bonus = "recoil_p1"
	self.weapon_skins.x_g22c_baaah.reserve_quality = true
	self.weapon_skins.x_g22c_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.x_g22c_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_004_df")
	self.weapon_skins.x_g22c_baaah.parts = {
		wpn_fps_pis_g18c_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_004_b_df")
			}
		},
		wpn_fps_pis_g22c_body_standard = {
			[Idstring("frame"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_003b_df"),
				uv_scale = Vector3(4.07665, 4.07665, 0),
				uv_offset_rot = Vector3(-0.175053, 0.817076, 5.78868)
			}
		}
	}
	self.weapon_skins.x_g22c_baaah.types = {
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_b_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_004_b_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
			pattern_pos = Vector3(0.00435994, -0.035, 0),
			pattern_tweak = Vector3(0.955001, 0, 0.284522),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		}
	}
	self.weapon_skins.usp_baaah = {}
	self.weapon_skins.usp_baaah.name_id = "bm_wskn_usp_baaah"
	self.weapon_skins.usp_baaah.desc_id = "bm_wskn_usp_baaah_desc"
	self.weapon_skins.usp_baaah.weapon_id = "usp"
	self.weapon_skins.usp_baaah.rarity = "uncommon"
	self.weapon_skins.usp_baaah.bonus = "spread_p1"
	self.weapon_skins.usp_baaah.reserve_quality = true
	self.weapon_skins.usp_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.usp_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_005_df")
	self.weapon_skins.usp_baaah.parts = {
		wpn_fps_pis_usp_b_expert = {
			[Idstring("mtr_expert"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df"),
				uv_offset_rot = Vector3(0.118217, 1.04203, 0),
				pattern_pos = Vector3(0, 0.00620103, 0),
				uv_scale = Vector3(2.59874, 2.59874, 0),
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_001c_df")
			}
		},
		wpn_fps_pis_usp_b_tactical = {
			[Idstring("mtr_tactical"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_001c_df"),
				uv_offset_rot = Vector3(0.0825188, 1.07465, 6.20826),
				uv_scale = Vector3(1.93129, 1.93129, 0.205819),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df")
			}
		},
		wpn_fps_pis_usp_b_match = {
			[Idstring("mtr_match"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_001c_df"),
				uv_scale = Vector3(2.16967, 2.64641, 0),
				uv_offset_rot = Vector3(0.149297, 1.02695, 6.28319)
			}
		}
	}
	self.weapon_skins.usp_baaah.types = {
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		}
	}
	self.weapon_skins.polymer_baaah = {}
	self.weapon_skins.polymer_baaah.name_id = "bm_wskn_polymer_baaah"
	self.weapon_skins.polymer_baaah.desc_id = "bm_wskn_polymer_baaah_desc"
	self.weapon_skins.polymer_baaah.weapon_id = "polymer"
	self.weapon_skins.polymer_baaah.rarity = "uncommon"
	self.weapon_skins.polymer_baaah.bonus = "spread_p1"
	self.weapon_skins.polymer_baaah.reserve_quality = true
	self.weapon_skins.polymer_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.polymer_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_df")
	self.weapon_skins.polymer_baaah.parts = {
		wpn_fps_smg_polymer_fg_standard = {
			[Idstring("mtr_fg"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_006_df"),
				pattern_pos = Vector3(-0.184593, -1.23396, 0),
				pattern_tweak = Vector3(0.300503, 0, 0.277367),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df")
			}
		}
	}
	self.weapon_skins.polymer_baaah.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_b_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_b_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_b_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_006_df"),
			pattern_tweak = Vector3(1, 0, 0.315526)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_b_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_003b_df"),
			uv_scale = Vector3(3.88595, 3.88595, 0),
			uv_offset_rot = Vector3(0.0598995, 0.797997, 0)
		}
	}
	self.weapon_skins.m16_baaah = {}
	self.weapon_skins.m16_baaah.name_id = "bm_wskn_m16_baaah"
	self.weapon_skins.m16_baaah.desc_id = "bm_wskn_m16_baaah_desc"
	self.weapon_skins.m16_baaah.weapon_id = "m16"
	self.weapon_skins.m16_baaah.rarity = "uncommon"
	self.weapon_skins.m16_baaah.bonus = "spread_p1"
	self.weapon_skins.m16_baaah.reserve_quality = true
	self.weapon_skins.m16_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.m16_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_df")
	self.weapon_skins.m16_baaah.parts = {
		wpn_fps_ass_l85a2_m_emag = {
			[Idstring("mtr_emag"):key()] = {
				pattern_pos = Vector3(-1.39614, -0.28953, 0),
				pattern_tweak = Vector3(0.269804, 3.93456, 1)
			}
		},
		wpn_fps_upg_m4_m_l5 = {
			[Idstring("mtr_l5"):key()] = {
				pattern_pos = Vector3(-0.882514, -0.485165, 0),
				pattern_tweak = Vector3(1.26256, 1.15237, 1)
			}
		},
		wpn_fps_m4_uupg_m_std = {
			[Idstring("m4_mag_std"):key()] = {
				pattern_pos = Vector3(-0.205673, -0.326149, 0),
				uv_offset_rot = Vector3(0.00620103, -0.00333858, 0),
				pattern_tweak = Vector3(1, 1.54794, 1)
			}
		},
		wpn_fps_upg_m4_m_pmag = {
			[Idstring("pmag"):key()] = {
				pattern_pos = Vector3(0.825156, -0.195831, 0),
				pattern_tweak = Vector3(1.11138, 1.69779, 1)
			}
		},
		wpn_fps_upg_m4_m_quad = {
			[Idstring("mtr_quad"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df"),
				uv_offset_rot = Vector3(-0.108275, 0.0252805, 0),
				pattern_pos = Vector3(-1.63063, 0.922013, 0),
				pattern_tweak = Vector3(1.05768, 2.98147, 0.999)
			}
		},
		wpn_fps_ass_m16_os_frontsight = {
			[Idstring("handle"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
			}
		}
	}
	self.weapon_skins.m16_baaah.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_007_df"),
			pattern_pos = Vector3(-0.29907, -0.528023, 0),
			pattern_tweak = Vector3(4.49797, 2.47701, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_007_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_004_df"),
			pattern_pos = Vector3(-0.00333858, 0.998331, 0),
			pattern_tweak = Vector3(1, 3.14631, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_003_df")
		},
		magazine = {
			pattern_pos = Vector3(0.855235, 0.902934, 0),
			pattern_tweak = Vector3(1.34987, 1.62687, 1),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_005_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_003_df")
		},
		grip = {
			pattern_pos = Vector3(-0.890532, 0.464107, 0),
			pattern_tweak = Vector3(0.252805, 0, 0.453852),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_001_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_001b_df"),
			uv_scale = Vector3(2.21734, 2.50339, 0),
			uv_offset_rot = Vector3(0.196995, 0.822536, 0)
		},
		upper_reciever = {
			sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_001b_df"),
			uv_scale = Vector3(2.12199, 2.36036, 0),
			uv_offset_rot = Vector3(0.00628047, 0.767838, 0.244255)
		},
		sight_special = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		}
	}
	self.weapon_skins.m249_baaah = {}
	self.weapon_skins.m249_baaah.name_id = "bm_wskn_m249_baaah"
	self.weapon_skins.m249_baaah.desc_id = "bm_wskn_m249_baaah_desc"
	self.weapon_skins.m249_baaah.weapon_id = "m249"
	self.weapon_skins.m249_baaah.rarity = "rare"
	self.weapon_skins.m249_baaah.bonus = "spread_p1"
	self.weapon_skins.m249_baaah.reserve_quality = true
	self.weapon_skins.m249_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.m249_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_008_df")
	self.weapon_skins.m249_baaah.default_blueprint = {
		"wpn_fps_lmg_m249_body_standard",
		"wpn_fps_lmg_m249_m_standard",
		"wpn_fps_lmg_m249_upper_reciever",
		"wpn_fps_lmg_m249_b_long",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_m4_s_mk46",
		"wpn_fps_lmg_m249_fg_mk46"
	}
	self.weapon_skins.m249_baaah.parts = {
		wpn_fps_lmg_m249_upper_reciever = {
			[Idstring("mtr_rearsight"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_010_df")
			},
			[Idstring("mtr_dustcover"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_008_df")
			}
		},
		wpn_fps_lmg_m249_s_para = {
			[Idstring("mtr_para"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_008_b_df"),
				uv_offset_rot = Vector3(0.626282, 2, 6.28319),
				pattern_pos = Vector3(-0.776055, -0.0796564, 0),
				uv_scale = Vector3(0.358028, 0.262678, 1),
				pattern_tweak = Vector3(2.92392, 1.47302, 1)
			}
		},
		wpn_fps_lmg_m249_fg_mk46 = {
			[Idstring("mtr_mk46"):key()] = {
				uv_scale = Vector3(1, 1, 0),
				uv_offset_rot = Vector3(0.272313, 0.263773, 0),
				pattern_tweak = Vector3(5.35655, 0, 1)
			}
		},
		wpn_fps_lmg_m249_fg_standard = {
			[Idstring("mtr_plastic"):key()] = {
				pattern_pos = Vector3(0.0157406, -0.107736, 0),
				pattern_tweak = Vector3(0.825187, 0, 1)
			}
		},
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				uv_scale = Vector3(0.739425, 0.834774, 0),
				uv_offset_rot = Vector3(-0.136895, 1.00787, 0),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_lmg_m249_body_standard = {
			[Idstring("mtr_body"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_003_df"),
				pattern_pos = Vector3(-0.499403, 0.507806, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_006_df"),
				pattern_tweak = Vector3(0.586694, 1.93755, 1)
			}
		},
		wpn_fps_lmg_m249_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_008_b_df"),
				uv_offset_rot = Vector3(-0.244752, 0.906394, 4.6798),
				pattern_pos = Vector3(-0.0128784, 0.797997, 0),
				uv_scale = Vector3(1.69292, 1.88362, 0),
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_010_df"),
				pattern_tweak = Vector3(3.25781, 4.73974, 1)
			},
			[Idstring("mtr_lid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_008_b_df"),
				pattern_tweak = Vector3(0.920584, 0, 1)
			}
		},
		wpn_fps_lmg_m249_s_modern = {
			[Idstring("mtr_modern"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df"),
				uv_offset_rot = Vector3(-1.66325, 0, 0.723773),
				pattern_pos = Vector3(-1.46291, -1.27212, 0),
				uv_scale = Vector3(0.310353, 0.167329, 0.212974),
				pattern_tweak = Vector3(1.44527, 0, 1)
			}
		}
	}
	self.weapon_skins.m249_baaah.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_004_b_df"),
			uv_offset_rot = Vector3(-0.0796564, -0.0796564, 3.15133),
			pattern_pos = Vector3(-0.146434, -0.652039, 0),
			uv_scale = Vector3(4.9348, 4.88712, 0),
			pattern_tweak = Vector3(2.97162, 0, 1)
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_b_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_df"),
			uv_offset_rot = Vector3(-0.0997357, 0.282853, 0),
			pattern_pos = Vector3(0.0252805, 0.511806, 0),
			uv_scale = Vector3(0.310353, 0.167329, 0.291677),
			cubemap_pattern_control = Vector3(0.286907, 0.420463, 0)
		},
		grip = {
			uv_offset_rot = Vector3(0.0825188, -0.461245, 0)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_008_df"),
			uv_offset_rot = Vector3(-0.413546, 0.836156, 0),
			pattern_tweak = Vector3(9.41092, 0, 1),
			pattern_pos = Vector3(0, -0.022418, 0),
			uv_scale = Vector3(2.98014, 3.02781, 0),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_006_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		},
		upper_reciever = {
			wear_and_tear = 0.8,
			uv_offset_rot = Vector3(-0.318149, 0.645361, 0),
			uv_scale = Vector3(1.78827, 1.78827, 0),
			pattern_tweak = Vector3(6.40592, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df")
		},
		vertical_grip = {
			uv_offset_rot = Vector3(0.569044, -0.62342, 0)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		},
		stock_adapter = {
			uv_offset_rot = Vector3(0.654901, -1.13856, 0)
		}
	}
	self.weapon_skins.x_1911_baaah = {}
	self.weapon_skins.x_1911_baaah.name_id = "bm_wskn_x_1911_baaah"
	self.weapon_skins.x_1911_baaah.desc_id = "bm_wskn_x_1911_baaah_desc"
	self.weapon_skins.x_1911_baaah.weapon_id = "x_1911"
	self.weapon_skins.x_1911_baaah.rarity = "rare"
	self.weapon_skins.x_1911_baaah.bonus = "recoil_p1"
	self.weapon_skins.x_1911_baaah.reserve_quality = true
	self.weapon_skins.x_1911_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.x_1911_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
	self.weapon_skins.x_1911_baaah.default_blueprint = {
		"wpn_fps_pis_1911_body_standard",
		"wpn_fps_upg_ns_pis_ipsccomp",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_pis_1911_g_engraved",
		"wpn_fps_pis_1911_b_long",
		"wpn_fps_pis_1911_m_standard"
	}
	self.weapon_skins.x_1911_baaah.parts = {
		wpn_fps_pis_1911_b_long = {
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_010_df"),
				sticker = Idstring("units/payday2_cash/safes/default/sticker/sticker_default_df")
			}
		}
	}
	self.weapon_skins.x_1911_baaah.types = {
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_b_df")
		},
		extra = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_b_df")
		},
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_b_df"),
			uv_offset_rot = Vector3(-0.337228, 0.988791, 0.00449621),
			pattern_pos = Vector3(0.00620103, 0, 0),
			uv_scale = Vector3(1.31152, 2.59874, 0),
			sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_006_df"),
			pattern_tweak = Vector3(0, 0, 1)
		},
		mag = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		}
	}
	self.weapon_skins.ksg_baaah = {}
	self.weapon_skins.ksg_baaah.name_id = "bm_wskn_ksg_baaah"
	self.weapon_skins.ksg_baaah.desc_id = "bm_wskn_ksg_baaah_desc"
	self.weapon_skins.ksg_baaah.weapon_id = "ksg"
	self.weapon_skins.ksg_baaah.rarity = "epic"
	self.weapon_skins.ksg_baaah.bonus = "concealment_p1"
	self.weapon_skins.ksg_baaah.reserve_quality = true
	self.weapon_skins.ksg_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.ksg_baaah.base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_010_df")
	self.weapon_skins.ksg_baaah.default_blueprint = {
		"wpn_fps_sho_ksg_body_standard",
		"wpn_fps_sho_ksg_b_long",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_upg_fl_ass_peq15",
		"wpn_fps_upg_o_cmore"
	}
	self.weapon_skins.ksg_baaah.parts = {
		wpn_fps_sho_ksg_fg_standard = {
			[Idstring("mat_pump"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_008_df"),
				uv_scale = Vector3(2.45571, 2.45571, 0.112807),
				uv_offset_rot = Vector3(0.0825188, 0.817076, 0)
			}
		},
		wpn_fps_sho_ksg_body_standard = {
			[Idstring("mat_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_009_df"),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_001_df"),
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df"),
				uv_offset_rot = Vector3(-0.394467, 0.972712, 1.50299),
				pattern_pos = Vector3(1.28522, -0.0128784, 0),
				uv_scale = Vector3(1.59757, 1.1685, 0.0984976),
				pattern_tweak = Vector3(0.252805, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_stripes_df")
			}
		}
	}
	self.weapon_skins.ksg_baaah.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
		},
		lower_body = {
			pattern_pos = Vector3(0.292392, -0.183672, 0),
			uv_scale = Vector3(5.07782, 4.12433, 0),
			uv_offset_rot = Vector3(-0.0289577, 1.00425, 0),
			pattern_tweak = Vector3(0.72979, 0, 1)
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df"),
			uv_offset_rot = Vector3(0.244694, 0.626282, 0),
			uv_scale = Vector3(1.54989, 1.50222, 0),
			pattern_tweak = Vector3(4.78417, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
		}
	}
	self.weapon_skins.model70_baaah = {}
	self.weapon_skins.model70_baaah.name_id = "bm_wskn_model70_baaah"
	self.weapon_skins.model70_baaah.desc_id = "bm_wskn_model70_baaah_desc"
	self.weapon_skins.model70_baaah.weapon_id = "model70"
	self.weapon_skins.model70_baaah.rarity = "legendary"
	self.weapon_skins.model70_baaah.bonus = "recoil_p1"
	self.weapon_skins.model70_baaah.reserve_quality = true
	self.weapon_skins.model70_baaah.texture_bundle_folder = "cash/safes/bah"
	self.weapon_skins.model70_baaah.unique_name_id = "bm_wskn_model70_baaah"
	self.weapon_skins.model70_baaah.locked = true
	self.weapon_skins.model70_baaah.base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
	self.weapon_skins.model70_baaah.default_blueprint = {
		"wpn_fps_snp_model70_b_legend",
		"wpn_fps_snp_model70_body_standard",
		"wpn_fps_snp_model70_s_legend",
		"wpn_fps_snp_model70_m_standard",
		"wpn_fps_upg_o_leupold",
		"wpn_fps_upg_fl_ass_peq15"
	}
	self.weapon_skins.model70_baaah.parts = {
		wpn_fps_snp_model70_b_legend = {
			[Idstring("mtr_skull"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_003_df")
			},
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df")
			}
		},
		wpn_fps_snp_model70_s_legend = {
			[Idstring("mtr_legend"):key()] = {
				uv_scale = Vector3(4.5534, 4.02898, 0),
				uv_offset_rot = Vector3(-0.308609, 1.01741, 0.513984)
			},
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_005_df"),
				uv_offset_rot = Vector3(-0.0188784, 0.924013, 0.469029),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
				pattern_pos = Vector3(-0.140053, 0.322472, 0),
				uv_scale = Vector3(3.12316, 4.79177, 0),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_007_df"),
				pattern_tweak = Vector3(6.21612, 0.012, 1)
			}
		},
		wpn_fps_upg_o_leupold = {
			[Idstring("leupold"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_002b_df"),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_001_df"),
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df"),
				uv_offset_rot = Vector3(0.36663, 0.969712, 6.28319),
				pattern_pos = Vector3(-0.037418, 0.807537, 0),
				uv_scale = Vector3(3.21851, 11.8953, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df"),
				pattern_tweak = Vector3(0.532996, 0, 0)
			}
		},
		wpn_fps_snp_model70_body_standard = {
			[Idstring("mtr_receiver"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/bah/sticker/sticker_bah_005_df"),
				uv_scale = Vector3(1.50222, 1.1685, 0),
				uv_offset_rot = Vector3(0.222376, 1.08273, 5.22823)
			}
		}
	}
	self.weapon_skins.striker_wolf = {}
	self.weapon_skins.striker_wolf.name_id = "bm_wskn_striker_wolf"
	self.weapon_skins.striker_wolf.desc_id = "bm_wskn_striker_wolf_desc"
	self.weapon_skins.striker_wolf.weapon_id = "striker"
	self.weapon_skins.striker_wolf.rarity = "common"
	self.weapon_skins.striker_wolf.bonus = "recoil_p1"
	self.weapon_skins.striker_wolf.reserve_quality = true
	self.weapon_skins.striker_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.striker_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
	self.weapon_skins.striker_wolf.pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_005_df")
	self.weapon_skins.striker_wolf.pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df")
	self.weapon_skins.striker_wolf.pattern_tweak = Vector3(2.11305, 0, 1)
	self.weapon_skins.striker_wolf.cubemap_pattern_control = Vector3(1, 0, 0)
	self.weapon_skins.striker_wolf.parts = {
		wpn_fps_sho_striker_body_standard = {
			[Idstring("mtr_sling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_df"),
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_001_df"),
				pattern_pos = Vector3(0.0980584, 0.206535, 0),
				pattern_tweak = Vector3(2.63773, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df")
			}
		}
	}
	self.weapon_skins.mosin_wolf = {}
	self.weapon_skins.mosin_wolf.name_id = "bm_wskn_mosin_wolf"
	self.weapon_skins.mosin_wolf.desc_id = "bm_wskn_mosin_wolf_desc"
	self.weapon_skins.mosin_wolf.weapon_id = "mosin"
	self.weapon_skins.mosin_wolf.rarity = "common"
	self.weapon_skins.mosin_wolf.bonus = "concealment_p1"
	self.weapon_skins.mosin_wolf.reserve_quality = true
	self.weapon_skins.mosin_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.mosin_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_002_df")
	self.weapon_skins.mosin_wolf.parts = {
		wpn_fps_upg_o_leupold = {
			[Idstring("leupold"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_007_df"),
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				pattern_pos = Vector3(0, 0.254233, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df"),
				pattern_tweak = Vector3(2.44694, 0, 1)
			}
		},
		wpn_fps_snp_mosin_b_sniper = {
			[Idstring("mtr_sniper"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_b_df"),
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_002_df"),
				pattern_pos = Vector3(-0.117815, -0.117815, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_002_df"),
				pattern_tweak = Vector3(14.6101, 0, 0)
			}
		},
		wpn_fps_snp_mosin_b_short = {
			[Idstring("mtr_b_short"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				pattern_pos = Vector3(0.120677, 0.168376, 0),
				pattern_tweak = Vector3(1.92225, 6.20826, 0.477701),
				uv_offset_rot = Vector3(0.006, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		},
		wpn_fps_snp_mosin_b_medium = {
			[Idstring("mtr_b_medium"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				pattern_pos = Vector3(0.120677, 0.168376, 0),
				pattern_tweak = Vector3(1.92225, 6.20826, 0.477701),
				uv_offset_rot = Vector3(0.006, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		},
		wpn_fps_snp_mosin_b_standard = {
			[Idstring("mtr_b_standard"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				pattern_pos = Vector3(0.120677, 0.168376, 0),
				pattern_tweak = Vector3(1.92225, 6.20826, 0.477701),
				uv_offset_rot = Vector3(0.006, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		},
		wpn_fps_snp_mosin_body_standard = {
			[Idstring("mtr_bolt"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
			},
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df"),
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				pattern_pos = Vector3(0.008, 0.0691378, 0),
				pattern_tweak = Vector3(2.68543, 6.20826, 0.272597),
				uv_offset_rot = Vector3(0.006, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		},
		wpn_fps_snp_mosin_body_black = {
			[Idstring("mtr_bolt"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
			},
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df"),
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				pattern_pos = Vector3(0.008, 0.0691378, 0),
				pattern_tweak = Vector3(2.68543, 6.20826, 0.272597),
				uv_offset_rot = Vector3(0.006, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		}
	}
	self.weapon_skins.mosin_wolf.types = {
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df")
		}
	}
	self.weapon_skins.colt_1911_wolf = {}
	self.weapon_skins.colt_1911_wolf.name_id = "bm_wskn_colt_1911_wolf"
	self.weapon_skins.colt_1911_wolf.desc_id = "bm_wskn_colt_1911_wolf_desc"
	self.weapon_skins.colt_1911_wolf.weapon_id = "colt_1911"
	self.weapon_skins.colt_1911_wolf.rarity = "common"
	self.weapon_skins.colt_1911_wolf.bonus = "spread_p1"
	self.weapon_skins.colt_1911_wolf.reserve_quality = true
	self.weapon_skins.colt_1911_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.colt_1911_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_011_df")
	self.weapon_skins.colt_1911_wolf.parts = {
		wpn_fps_pis_1911_g_bling = {
			[Idstring("bling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
			}
		}
	}
	self.weapon_skins.colt_1911_wolf.types = {
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
		},
		extra = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_007_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_tweak = Vector3(1.30217, 0, 0)
		}
	}
	self.weapon_skins.scar_wolf = {}
	self.weapon_skins.scar_wolf.name_id = "bm_wskn_scar_wolf"
	self.weapon_skins.scar_wolf.desc_id = "bm_wskn_scar_wolf_desc"
	self.weapon_skins.scar_wolf.weapon_id = "scar"
	self.weapon_skins.scar_wolf.rarity = "common"
	self.weapon_skins.scar_wolf.bonus = "recoil_p1"
	self.weapon_skins.scar_wolf.reserve_quality = true
	self.weapon_skins.scar_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.scar_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df")
	self.weapon_skins.scar_wolf.parts = {
		wpn_fps_ass_scar_body_standard = {
			[Idstring("mtr_railcover"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df")
			}
		},
		wpn_fps_upg_vg_ass_smg_afg = {
			[Idstring("afg"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
			}
		}
	}
	self.weapon_skins.scar_wolf.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_007_df")
		},
		upper_reciever = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_fosterland_df"),
			uv_scale = Vector3(9.32087, 9.32087, 1),
			uv_offset_rot = Vector3(-0.0787356, 0.595663, 6.16331)
		},
		magazine = {
			pattern_pos = Vector3(0.161297, 0.0634394, 0),
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_b_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_004_df"),
			pattern_tweak = Vector3(6.07203, 0, 1)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df")
		}
	}
	self.weapon_skins.saiga_wolf = {}
	self.weapon_skins.saiga_wolf.name_id = "bm_wskn_saiga_wolf"
	self.weapon_skins.saiga_wolf.desc_id = "bm_wskn_saiga_wolf_desc"
	self.weapon_skins.saiga_wolf.weapon_id = "saiga"
	self.weapon_skins.saiga_wolf.rarity = "common"
	self.weapon_skins.saiga_wolf.bonus = "recoil_p1"
	self.weapon_skins.saiga_wolf.reserve_quality = true
	self.weapon_skins.saiga_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.saiga_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_b_df")
	self.weapon_skins.saiga_wolf.pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_006_df")
	self.weapon_skins.saiga_wolf.pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df")
	self.weapon_skins.saiga_wolf.pattern_tweak = Vector3(1.44527, 0, 1)
	self.weapon_skins.saiga_wolf.types = {
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df"),
			pattern_tweak = Vector3(1, 0, 0.565943)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_010_df"),
			pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df")
		}
	}
	self.weapon_skins.g22c_wolf = {}
	self.weapon_skins.g22c_wolf.name_id = "bm_wskn_g22c_wolf"
	self.weapon_skins.g22c_wolf.desc_id = "bm_wskn_g22c_wolf_desc"
	self.weapon_skins.g22c_wolf.weapon_id = "g22c"
	self.weapon_skins.g22c_wolf.rarity = "common"
	self.weapon_skins.g22c_wolf.bonus = "spread_p1"
	self.weapon_skins.g22c_wolf.reserve_quality = true
	self.weapon_skins.g22c_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.g22c_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df")
	self.weapon_skins.g22c_wolf.pattern_tweak = Vector3(1, 0, 0)
	self.weapon_skins.g22c_wolf.types = {
		slide = {
			pattern_pos = Vector3(0.137297, -0.308609, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/sputnik/pattern_gradient/gradient_sput_003_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_003_df"),
			pattern_tweak = Vector3(0.872886, 0.753743, 0.678035)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df")
		}
	}
	self.weapon_skins.mac10_wolf = {}
	self.weapon_skins.mac10_wolf.name_id = "bm_wskn_mac10_wolf"
	self.weapon_skins.mac10_wolf.desc_id = "bm_wskn_mac10_wolf_desc"
	self.weapon_skins.mac10_wolf.weapon_id = "mac10"
	self.weapon_skins.mac10_wolf.rarity = "uncommon"
	self.weapon_skins.mac10_wolf.bonus = "spread_p1"
	self.weapon_skins.mac10_wolf.reserve_quality = true
	self.weapon_skins.mac10_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.mac10_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_012_df")
	self.weapon_skins.mac10_wolf.pattern_tweak = Vector3(0, 0, 1)
	self.weapon_skins.mac10_wolf.pattern_pos = Vector3(0, 0.00620103, 0)
	self.weapon_skins.mac10_wolf.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_012_b_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_004_df"),
			pattern_pos = Vector3(-0.0982754, 0.203075, 0),
			pattern_tweak = Vector3(13.3222, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_003_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df")
		},
		stock = {
			pattern_pos = Vector3(0, 0.177916, 0),
			pattern_tweak = Vector3(13.7038, 0, 1)
		},
		magazine = {
			pattern_pos = Vector3(-0.127355, 0.00620103, 0),
			pattern_tweak = Vector3(6.45361, 0, 1)
		}
	}
	self.weapon_skins.p226_wolf = {}
	self.weapon_skins.p226_wolf.name_id = "bm_wskn_p226_wolf"
	self.weapon_skins.p226_wolf.desc_id = "bm_wskn_p226_wolf_desc"
	self.weapon_skins.p226_wolf.weapon_id = "p226"
	self.weapon_skins.p226_wolf.rarity = "uncommon"
	self.weapon_skins.p226_wolf.bonus = "spread_p1"
	self.weapon_skins.p226_wolf.reserve_quality = true
	self.weapon_skins.p226_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.p226_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df")
	self.weapon_skins.p226_wolf.types = {
		lower_reciever = {
			pattern_pos = Vector3(0.025201, -0.0371799, 0),
			pattern_tweak = Vector3(11.462, 0, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_002_df")
		},
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_pos = Vector3(0.101598, 0.36871, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df"),
			pattern_tweak = Vector3(4.97496, 0.40909, 0.129502)
		},
		grip = {
			pattern_tweak = Vector3(12.3205, 0, 1)
		}
	}
	self.weapon_skins.akm_wolf = {}
	self.weapon_skins.akm_wolf.name_id = "bm_wskn_akm_wolf"
	self.weapon_skins.akm_wolf.desc_id = "bm_wskn_akm_wolf_desc"
	self.weapon_skins.akm_wolf.weapon_id = "akm"
	self.weapon_skins.akm_wolf.rarity = "uncommon"
	self.weapon_skins.akm_wolf.bonus = "spread_p1"
	self.weapon_skins.akm_wolf.reserve_quality = true
	self.weapon_skins.akm_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.akm_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df")
	self.weapon_skins.akm_wolf.parts = {
		wpn_upg_ak_fg_standard = {
			[Idstring("handguard_upper_wood"):key()] = {
				pattern_pos = Vector3(-0.04, 0.13, 0)
			},
			[Idstring("handguard_lower_wood"):key()] = {
				pattern_pos = Vector3(0.157836, 0.089979, 0),
				pattern_tweak = Vector3(5.11806, 0, 1)
			}
		},
		wpn_fps_upg_ak_m_uspalm = {
			[Idstring("mtr_uspalm"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_011_df")
			}
		},
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_011_df")
			}
		},
		wpn_fps_upg_fg_midwest = {
			[Idstring("mtr_midwest"):key()] = {
				pattern_pos = Vector3(0.158836, 0.120677, 0),
				pattern_tweak = Vector3(6.07203, 0, 1)
			}
		},
		wpn_fps_upg_ak_fg_krebs = {
			[Idstring("mtr_krebs"):key()] = {
				pattern_pos = Vector3(0.0157406, -0.0128784, 0),
				pattern_tweak = Vector3(8.60005, 0, 1)
			}
		},
		wpn_fps_upg_ak_fg_tapco = {
			[Idstring("mtr_tapco"):key()] = {
				pattern_pos = Vector3(0.0684394, 0.0654394, 0),
				pattern_tweak = Vector3(6.33022, 3.15133, 1)
			},
			[Idstring("ultimak"):key()] = {
				pattern_pos = Vector3(0.0252805, 0.130217, 0),
				pattern_tweak = Vector3(4.11639, 0, 1)
			}
		},
		wpn_fps_upg_ak_fg_trax = {
			[Idstring("mtr_trax"):key()] = {
				pattern_pos = Vector3(0.177916, 0.406869, 0),
				pattern_tweak = Vector3(6.64441, 0, 1)
			}
		}
	}
	self.weapon_skins.akm_wolf.types = {
		lower_reciever = {
			pattern_pos = Vector3(1.58032, 1.02695, 0),
			pattern_tweak = Vector3(2.11305, 0.019, 0.585023)
		},
		upper_reciever = {
			pattern_pos = Vector3(-0.0207517, -0.220292, 0),
			pattern_tweak = Vector3(1.34987, 0.023, 1)
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_pos = Vector3(-0.62342, -0.241831, 0),
			pattern_tweak = Vector3(3.01932, 0.573924, 1),
			cubemap_pattern_control = Vector3(0, 1, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_004_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_013_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_002_df"),
			pattern_pos = Vector3(-0.585261, -0.926451, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			pattern_tweak = Vector3(2.82853, 0, 0.999)
		},
		grip = {
			pattern_pos = Vector3(0, -0.001, 0),
			pattern_tweak = Vector3(1.82686, 0, 1)
		}
	}
	self.weapon_skins.baka_wolf = {}
	self.weapon_skins.baka_wolf.name_id = "bm_wskn_baka_wolf"
	self.weapon_skins.baka_wolf.desc_id = "bm_wskn_baka_wolf_desc"
	self.weapon_skins.baka_wolf.weapon_id = "baka"
	self.weapon_skins.baka_wolf.rarity = "uncommon"
	self.weapon_skins.baka_wolf.bonus = "spread_p1"
	self.weapon_skins.baka_wolf.reserve_quality = true
	self.weapon_skins.baka_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.baka_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_013_df")
	self.weapon_skins.baka_wolf.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
		},
		barrel = {
			pattern_pos = Vector3(-0.0701165, 0.139757, 0),
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df"),
			pattern_tweak = Vector3(3.06702, 0, 1)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_014_df")
		},
		upper_reciever = {
			pattern_pos = Vector3(-0.470784, -0.022418, 0),
			pattern_tweak = Vector3(0.634393, 0, 0),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_002_df")
		},
		magazine = {
			pattern_pos = Vector3(0.225614, 0.590282, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_002_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_tweak = Vector3(1.34987, 0, 1)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df")
		}
	}
	self.weapon_skins.asval_wolf = {}
	self.weapon_skins.asval_wolf.name_id = "bm_wskn_asval_wolf"
	self.weapon_skins.asval_wolf.desc_id = "bm_wskn_asval_wolf_desc"
	self.weapon_skins.asval_wolf.weapon_id = "asval"
	self.weapon_skins.asval_wolf.rarity = "rare"
	self.weapon_skins.asval_wolf.bonus = "spread_p1"
	self.weapon_skins.asval_wolf.reserve_quality = true
	self.weapon_skins.asval_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.asval_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_010_df")
	self.weapon_skins.asval_wolf.default_blueprint = {
		"wpn_fps_ass_asval_body_standard",
		"wpn_fps_ass_asval_fg_standard",
		"wpn_fps_ass_asval_m_standard",
		"wpn_fps_ass_asval_s_solid",
		"wpn_fps_ass_asval_b_standard",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_fl_ass_utg"
	}
	self.weapon_skins.asval_wolf.parts = {
		wpn_fps_ass_asval_s_solid = {
			[Idstring("mtr_solid"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_vargtimmer_df"),
				uv_scale = Vector3(4.21968, 14.4697, 1),
				uv_offset_rot = Vector3(-0.127355, 0.951092, 6.2682)
			}
		},
		wpn_fps_ass_asval_b_standard = {
			[Idstring("mtr_clamp"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_007_df"),
				pattern = Idstring("units/payday2_cash/safes/default/pattern/pattern_default_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/default/pattern_gradient/gradient_default_df")
			},
			[Idstring("mtr_barrel"):key()] = {
				cubemap_pattern_control = Vector3(0, 1, 0)
			}
		},
		wpn_fps_ass_asval_scopemount = {
			[Idstring("mtr_mount_budget"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_vargtimmer_df"),
				uv_scale = Vector3(3.21851, 9.27319, 0),
				uv_offset_rot = Vector3(0.247154, 0.746298, 0)
			}
		},
		wpn_fps_ass_asval_fg_standard = {
			[Idstring("mtr_foregrip"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_drill_model_df"),
				uv_scale = Vector3(3.36153, 6.36504, 1),
				uv_offset_rot = Vector3(-0.148434, 0.783156, 0)
			}
		}
	}
	self.weapon_skins.asval_wolf.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005_df"),
			uv_offset_rot = Vector3(-0.184593, 0.941092, 0),
			pattern_tweak = Vector3(12.0343, 1.92257, 1),
			pattern_pos = Vector3(0, -0.00333858, 0),
			uv_scale = Vector3(1.0008, 1.00012, 1),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_drill_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
		}
	}
	self.weapon_skins.aug_wolf = {}
	self.weapon_skins.aug_wolf.name_id = "bm_wskn_aug_wolf"
	self.weapon_skins.aug_wolf.desc_id = "bm_wskn_aug_wolf_desc"
	self.weapon_skins.aug_wolf.weapon_id = "aug"
	self.weapon_skins.aug_wolf.rarity = "rare"
	self.weapon_skins.aug_wolf.bonus = "spread_p1"
	self.weapon_skins.aug_wolf.reserve_quality = true
	self.weapon_skins.aug_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.aug_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_009_df")
	self.weapon_skins.aug_wolf.default_blueprint = {
		"wpn_fps_upg_vg_ass_smg_verticalgrip",
		"wpn_fps_aug_m_pmag",
		"wpn_fps_aug_b_long",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_aug_fg_a3",
		"wpn_fps_upg_o_eotech",
		"wpn_fps_aug_body_f90"
	}
	self.weapon_skins.aug_wolf.parts = {
		wpn_fps_aug_body_f90 = {
			[Idstring("mtr_f90"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_vargtimmer_df"),
				uv_scale = Vector3(4.64875, 20, 0.489626),
				uv_offset_rot = Vector3(0.0825188, 0.962172, 0)
			}
		},
		wpn_fps_aug_fg_a3 = {
			[Idstring("a3"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_drill_model_df"),
				pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_flag_stripes_df"),
				pattern_tweak = Vector3(1, 2.35713, 1),
				pattern_pos = Vector3(0, 0.244694, 0),
				uv_scale = Vector3(7.55691, 13.7069, 1),
				uv_offset_rot = Vector3(-0.26599, 0.930553, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		},
		wpn_fps_aug_body_aug = {
			[Idstring("aug"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_vargtimmer_df"),
				uv_scale = Vector3(4.50573, 12.9441, 0),
				uv_offset_rot = Vector3(0.0217406, 0.959172, 6.28319)
			}
		}
	}
	self.weapon_skins.aug_wolf.types = {
		vertical_grip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df")
		},
		barrel_ext = {
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_drill_df"),
			pattern_tweak = Vector3(4.97496, 1.02347, 0.730503)
		},
		barrel = {
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_drill_df"),
			pattern_tweak = Vector3(10, 0.813683, 0.730503),
			uv_offset_rot = Vector3(0, 0, 1.66782),
			uv_scale = Vector3(4.31503, 1, 1),
			cubemap_pattern_control = Vector3(0.49678, 0, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_b_df")
		}
	}
	self.weapon_skins.x_deagle_wolf = {}
	self.weapon_skins.x_deagle_wolf.name_id = "bm_wskn_x_deagle_wolf"
	self.weapon_skins.x_deagle_wolf.desc_id = "bm_wskn_x_deagle_wolf_desc"
	self.weapon_skins.x_deagle_wolf.weapon_id = "x_deagle"
	self.weapon_skins.x_deagle_wolf.rarity = "rare"
	self.weapon_skins.x_deagle_wolf.bonus = "recoil_p1"
	self.weapon_skins.x_deagle_wolf.reserve_quality = true
	self.weapon_skins.x_deagle_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.x_deagle_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
	self.weapon_skins.x_deagle_wolf.default_blueprint = {
		"wpn_fps_pis_deagle_body_standard",
		"wpn_fps_pis_deagle_m_extended",
		"wpn_fps_pis_deagle_b_long",
		"wpn_fps_pis_deagle_g_bling"
	}
	self.weapon_skins.x_deagle_wolf.parts = {
		wpn_fps_pis_deagle_g_bling = {
			[Idstring("bling"):key()] = {
				uv_scale = Vector3(1.50222, 1.07315, 0),
				uv_offset_rot = Vector3(-0.232212, 1.00987, 4.73974)
			}
		},
		wpn_fps_pis_deagle_g_ergo = {
			[Idstring("ergo"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/default/sticker/sticker_default_df")
			}
		},
		wpn_fps_pis_deagle_b_standard = {
			[Idstring("barrel"):key()] = {
				uv_scale = Vector3(1.54989, 1.59757, 1),
				uv_offset_rot = Vector3(-0.535102, 0.989251, 4.06541)
			}
		}
	}
	self.weapon_skins.x_deagle_wolf.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_015_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_pos = Vector3(-0.671118, 0.969712, 0),
			pattern_tweak = Vector3(1.30217, 0.184315, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
		},
		slide = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_fenris_df"),
			uv_scale = Vector3(2.16967, 2.12199, 1),
			uv_offset_rot = Vector3(-0.527023, 0.987251, 4.06541)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_015_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_001_df"),
			pattern_pos = Vector3(-1.30074, 0.196995, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_004_df"),
			pattern_tweak = Vector3(0.348202, 3.55593, 1)
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_fenris_df"),
			uv_scale = Vector3(1.12082, 1.12082, 1),
			uv_offset_rot = Vector3(-0.00333858, 1.2132, 2.47701)
		},
		grip = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_001_df"),
			uv_offset_rot = Vector3(-0.207212, 1.00787, 4.72475),
			pattern_tweak = Vector3(1, 4.96451, 1),
			uv_scale = Vector3(1.54989, 0.977799, 0),
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_015_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/gradient_france_df")
		}
	}
	self.weapon_skins.s552_wolf = {}
	self.weapon_skins.s552_wolf.name_id = "bm_wskn_s552_wolf"
	self.weapon_skins.s552_wolf.desc_id = "bm_wskn_s552_wolf_desc"
	self.weapon_skins.s552_wolf.weapon_id = "s552"
	self.weapon_skins.s552_wolf.rarity = "epic"
	self.weapon_skins.s552_wolf.bonus = "recoil_p1"
	self.weapon_skins.s552_wolf.reserve_quality = true
	self.weapon_skins.s552_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.s552_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
	self.weapon_skins.s552_wolf.pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_001_df")
	self.weapon_skins.s552_wolf.pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df")
	self.weapon_skins.s552_wolf.pattern_tweak = Vector3(0.72979, 0, 1)
	self.weapon_skins.s552_wolf.default_blueprint = {
		"wpn_fps_ass_s552_m_standard",
		"wpn_fps_ass_s552_b_long",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_ass_s552_fg_standard_green",
		"wpn_fps_ass_s552_g_standard_green",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_ass_s552_s_standard_green",
		"wpn_fps_ass_s552_body_standard"
	}
	self.weapon_skins.s552_wolf.parts = {
		wpn_fps_ass_s552_s_standard_green = {
			[Idstring("mtr_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_002_df"),
				uv_scale = Vector3(7.36621, 6.93714, 0),
				uv_offset_rot = Vector3(0.210535, 0.967172, 5.30916)
			}
		},
		wpn_fps_ass_s552_fg_railed = {
			[Idstring("mtr_railed_handguard"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
			}
		}
	}
	self.weapon_skins.s552_wolf.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_002_df"),
			pattern_pos = Vector3(-0.966849, 0.259773, 0),
			pattern_tweak = Vector3(0.589296, 4.70782, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_004_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_b_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_002_df"),
			pattern_pos = Vector3(-1.54877, -1.71095, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_007_df"),
			pattern_tweak = Vector3(0.267106, 1.51798, 0)
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_002_df")
		}
	}
	self.weapon_skins.m16_wolf = {}
	self.weapon_skins.m16_wolf.name_id = "bm_wskn_m16_wolf"
	self.weapon_skins.m16_wolf.desc_id = "bm_wskn_m16_wolf_desc"
	self.weapon_skins.m16_wolf.weapon_id = "m16"
	self.weapon_skins.m16_wolf.rarity = "epic"
	self.weapon_skins.m16_wolf.bonus = "spread_p1"
	self.weapon_skins.m16_wolf.reserve_quality = true
	self.weapon_skins.m16_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.m16_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_011_df")
	self.weapon_skins.m16_wolf.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_004_df")
	self.weapon_skins.m16_wolf.pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_003_df")
	self.weapon_skins.m16_wolf.pattern_tweak = Vector3(0.491297, 0, 0)
	self.weapon_skins.m16_wolf.pattern_pos = Vector3(1.41808, 0.69306, 0)
	self.weapon_skins.m16_wolf.default_blueprint = {
		"wpn_fps_m4_lower_reciever",
		"wpn_fps_m4_uupg_draghandle",
		"wpn_fps_m4_uupg_b_long",
		"wpn_fps_upg_ass_m16_fg_stag",
		"wpn_fps_upg_fl_ass_utg",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_upg_m4_m_quad",
		"wpn_fps_upg_o_cmore",
		"wpn_fps_upg_m4_s_mk46",
		"wpn_fps_upg_ass_m4_upper_reciever_ballos",
		"wpn_fps_upg_ass_ns_surefire"
	}
	self.weapon_skins.m16_wolf.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_012_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_006_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_001_df"),
			pattern_pos = Vector3(0.301932, -0.0510372, 0),
			pattern_tweak = Vector3(1.10638, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_smoker_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_013_df"),
			pattern_pos = Vector3(-0.0605769, 1.2559, 0),
			pattern_tweak = Vector3(1, 5.57889, 1)
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_008_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df")
		}
	}
	self.weapon_skins.par_wolf = {}
	self.weapon_skins.par_wolf.name_id = "bm_wskn_par_wolf"
	self.weapon_skins.par_wolf.desc_id = "bm_wskn_par_wolf_desc"
	self.weapon_skins.par_wolf.weapon_id = "par"
	self.weapon_skins.par_wolf.rarity = "legendary"
	self.weapon_skins.par_wolf.bonus = "spread_p1"
	self.weapon_skins.par_wolf.reserve_quality = true
	self.weapon_skins.par_wolf.texture_bundle_folder = "cash/safes/pack"
	self.weapon_skins.par_wolf.unique_name_id = "bm_wskn_par_wolf"
	self.weapon_skins.par_wolf.locked = true
	self.weapon_skins.par_wolf.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
	self.weapon_skins.par_wolf.default_blueprint = {
		"wpn_fps_lmg_svinet_b_standard",
		"wpn_fps_lmg_par_body_standard",
		"wpn_fps_lmg_par_m_standard",
		"wpn_fps_lmg_svinet_s_legend",
		"wpn_fps_lmg_par_upper_reciever",
		"wpn_fps_upg_bp_lmg_lionbipod",
		"wpn_fps_upg_fl_ass_utg"
	}
	self.weapon_skins.par_wolf.parts = {
		wpn_fps_lmg_par_body_standard = {
			[Idstring("mtr_carry"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005b_df")
			},
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_004_df"),
				pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005b_df"),
				uv_offset_rot = Vector3(0.0443599, 0.941092, 0),
				pattern_pos = Vector3(-0.017, 0.301932, 0),
				uv_scale = Vector3(3.74293, 4.98247, 1),
				pattern_tweak = Vector3(3.92559, 0, 0.291677),
				pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
			}
		},
		wpn_fps_lmg_svinet_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/default/sticker/sticker_default_df")
			}
		}
	}
	self.weapon_skins.par_wolf.types = {
		barrel = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_004_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			uv_offset_rot = Vector3(-0.346768, 0.881774, 0.214285),
			pattern_pos = Vector3(0, -0.0605769, 0),
			uv_scale = Vector3(1.26385, 2.45571, 1),
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_b_df"),
			pattern_tweak = Vector3(1.49297, 1.02347, 1)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_002_df"),
			pattern_tweak = Vector3(3.7348, 0.603894, 1),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_b_df"),
			pattern_pos = Vector3(0.235154, 0, 0),
			uv_scale = Vector3(20, 16.4244, 1),
			uv_offset_rot = Vector3(-0.220292, 0.972791, 5.74373),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_005b_df"),
			pattern = Idstring("units/payday2_cash/safes/pack/pattern/pack_pattern_005_df"),
			pattern_pos = Vector3(0, 0.263773, 0),
			pattern_tweak = Vector3(5.59504, 0, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_003_df"),
			uv_scale = Vector3(11.8, 9.89297, 1),
			uv_offset_rot = Vector3(-0.014418, 0.716679, 6.22325)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/pack/sticker/sticker_pack_002_df"),
			uv_scale = Vector3(20, 20, 1),
			uv_offset_rot = Vector3(-0.208212, 1.05303, 2.0874)
		}
	}
	self.weapon_skins.glock_17_cola = {}
	self.weapon_skins.glock_17_cola.name_id = "bm_wskn_glock_17_cola"
	self.weapon_skins.glock_17_cola.desc_id = "bm_wskn_glock_17_cola_desc"
	self.weapon_skins.glock_17_cola.weapon_id = "glock_17"
	self.weapon_skins.glock_17_cola.rarity = "common"
	self.weapon_skins.glock_17_cola.bonus = "recoil_p1"
	self.weapon_skins.glock_17_cola.reserve_quality = true
	self.weapon_skins.glock_17_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.glock_17_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_001_df")
	self.weapon_skins.glock_17_cola.types = {
		slide = {
			pattern_pos = Vector3(1.982, -0.919151, 0),
			pattern_tweak = Vector3(0.348202, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_003_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/dinner/pattern_gradient/gradient_din_warning_df")
		}
	}
	self.weapon_skins.scorpion_cola = {}
	self.weapon_skins.scorpion_cola.name_id = "bm_wskn_scorpion_cola"
	self.weapon_skins.scorpion_cola.desc_id = "bm_wskn_scorpion_cola_desc"
	self.weapon_skins.scorpion_cola.weapon_id = "scorpion"
	self.weapon_skins.scorpion_cola.rarity = "common"
	self.weapon_skins.scorpion_cola.bonus = "spread_p1"
	self.weapon_skins.scorpion_cola.reserve_quality = true
	self.weapon_skins.scorpion_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.scorpion_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_004_df")
	self.weapon_skins.scorpion_cola.parts = {
		wpn_fps_smg_scorpion_body_standard = {
			[Idstring("mtr_upper"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
				pattern_pos = Vector3(0.216075, 0.184995, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df"),
				pattern_tweak = Vector3(3.97329, 3.13535, 1)
			}
		}
	}
	self.weapon_skins.scorpion_cola.types = {
		upper_reciever = {
			pattern_pos = Vector3(0.00620103, 0.301932, 0),
			pattern_tweak = Vector3(0.586694, 4.69478, 1)
		},
		magazine = {
			pattern_pos = Vector3(0.729679, 0.244694, 0),
			pattern_tweak = Vector3(0.3959, 4.69178, 1),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_002_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
		}
	}
	self.weapon_skins.amcar_cola = {}
	self.weapon_skins.amcar_cola.name_id = "bm_wskn_amcar_cola"
	self.weapon_skins.amcar_cola.desc_id = "bm_wskn_amcar_cola_desc"
	self.weapon_skins.amcar_cola.weapon_id = "amcar"
	self.weapon_skins.amcar_cola.rarity = "common"
	self.weapon_skins.amcar_cola.bonus = "spread_p1"
	self.weapon_skins.amcar_cola.reserve_quality = true
	self.weapon_skins.amcar_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.amcar_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_df")
	self.weapon_skins.amcar_cola.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_c_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_b_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_b_df")
		},
		stock_adapter = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_b_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_b_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_b_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_c_df")
		}
	}
	self.weapon_skins.uzi_cola = {}
	self.weapon_skins.uzi_cola.name_id = "bm_wskn_uzi_cola"
	self.weapon_skins.uzi_cola.desc_id = "bm_wskn_uzi_cola_desc"
	self.weapon_skins.uzi_cola.weapon_id = "uzi"
	self.weapon_skins.uzi_cola.rarity = "common"
	self.weapon_skins.uzi_cola.bonus = "spread_p1"
	self.weapon_skins.uzi_cola.reserve_quality = true
	self.weapon_skins.uzi_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.uzi_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_004_df")
	self.weapon_skins.uzi_cola.pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
	self.weapon_skins.uzi_cola.pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_012_df")
	self.weapon_skins.uzi_cola.pattern_tweak = Vector3(2.16075, 0, 1)
	self.weapon_skins.uzi_cola.pattern_pos = Vector3(-1.09087, 0.540425, 0)
	self.weapon_skins.uzi_cola.types = {
		foregrip = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_1_df"),
			uv_scale = Vector3(3.07548, 3.9813, 1),
			uv_offset_rot = Vector3(0.36471, 1.18912, 6.17829)
		},
		barrel = {
			pattern_tweak = Vector3(0.491297, 0, 1)
		},
		grip = {
			uv_scale = Vector3(3.17083, 4.172, 1)
		}
	}
	self.weapon_skins.fal_cola = {}
	self.weapon_skins.fal_cola.name_id = "bm_wskn_fal_cola"
	self.weapon_skins.fal_cola.desc_id = "bm_wskn_fal_cola_desc"
	self.weapon_skins.fal_cola.weapon_id = "fal"
	self.weapon_skins.fal_cola.rarity = "common"
	self.weapon_skins.fal_cola.bonus = "spread_p1"
	self.weapon_skins.fal_cola.reserve_quality = true
	self.weapon_skins.fal_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.fal_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_df")
	self.weapon_skins.fal_cola.parts = {
		wpn_fps_ass_fal_fg_01 = {
			[Idstring("mat_frontgrip"):key()] = {
				pattern_pos = Vector3(0, 0.35917, 0),
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_df"),
				pattern_tweak = Vector3(0.825187, 0, 1)
			}
		},
		wpn_fps_ass_fal_fg_wood = {
			[Idstring("mat_frontgrip02"):key()] = {
				pattern_pos = Vector3(0.540425, 0.732679, 0),
				pattern_tweak = Vector3(1.06368, 1.57191, 1)
			}
		},
		wpn_fps_ass_fal_fg_03 = {
			[Idstring("mat_frontgrip03"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_d_df")
			}
		}
	}
	self.weapon_skins.fal_cola.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_b_df"),
			pattern_pos = Vector3(1.06973, -1.51061, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_006_df"),
			pattern_tweak = Vector3(1.73146, 1.56293, 1)
		},
		stock = {
			uv_offset_rot = Vector3(0, 0, 3.1813)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_c_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_c_df"),
			pattern_pos = Vector3(1.43716, 1.17959, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		}
	}
	self.weapon_skins.x_usp_cola = {}
	self.weapon_skins.x_usp_cola.name_id = "bm_wskn_x_usp_cola"
	self.weapon_skins.x_usp_cola.desc_id = "bm_wskn_x_usp_cola_desc"
	self.weapon_skins.x_usp_cola.weapon_id = "x_usp"
	self.weapon_skins.x_usp_cola.rarity = "common"
	self.weapon_skins.x_usp_cola.bonus = "recoil_p1"
	self.weapon_skins.x_usp_cola.reserve_quality = true
	self.weapon_skins.x_usp_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.x_usp_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_006_df")
	self.weapon_skins.x_usp_cola.types = {
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_df")
		},
		slide = {
			uv_offset_rot = Vector3(-0.001, 0, 0),
			pattern_pos = Vector3(0.664441, 0.149297, 0),
			pattern_tweak = Vector3(1.39757, 0, 0.99523),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_013_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_006_b_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_013_df"),
			pattern_pos = Vector3(0, 0.168376, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df"),
			pattern_tweak = Vector3(0.586694, 0, 1)
		}
	}
	self.weapon_skins.m37_cola = {}
	self.weapon_skins.m37_cola.name_id = "bm_wskn_m37_cola"
	self.weapon_skins.m37_cola.desc_id = "bm_wskn_m37_cola_desc"
	self.weapon_skins.m37_cola.weapon_id = "m37"
	self.weapon_skins.m37_cola.rarity = "uncommon"
	self.weapon_skins.m37_cola.bonus = "spread_p1"
	self.weapon_skins.m37_cola.reserve_quality = true
	self.weapon_skins.m37_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.m37_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_007_df")
	self.weapon_skins.m37_cola.parts = {
		wpn_fps_shot_m37_fg_standard = {
			[Idstring("mtr_pump"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_007_b_df")
			}
		},
		wpn_fps_shot_m37_b_short = {
			[Idstring("mtr_barrel_short"):key()] = {
				pattern_pos = Vector3(0.247694, -0.00325937, 0)
			}
		}
	}
	self.weapon_skins.m37_cola.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_007_d_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_007_c_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
			pattern_pos = Vector3(-0.165514, -0.206673, 0),
			pattern_tweak = Vector3(1.06368, 1.58188, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
		},
		barrel = {
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_006_df"),
			pattern_pos = Vector3(0.401108, -0.717357, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df"),
			uv_offset_rot = Vector3(0.007, 0, 0),
			pattern_tweak = Vector3(2.83053, 0, 1)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_007_c_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
			pattern_pos = Vector3(-0.883532, 0.482647, 0),
			pattern_tweak = Vector3(1.66876, 0.007, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
		},
		lower_reciever = {
			pattern_pos = Vector3(-0.442165, -1.15764, 0),
			pattern_tweak = Vector3(0.634393, 3.15135, 1),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_006_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		}
	}
	self.weapon_skins.sparrow_cola = {}
	self.weapon_skins.sparrow_cola.name_id = "bm_wskn_sparrow_cola"
	self.weapon_skins.sparrow_cola.desc_id = "bm_wskn_sparrow_cola_desc"
	self.weapon_skins.sparrow_cola.weapon_id = "sparrow"
	self.weapon_skins.sparrow_cola.rarity = "uncommon"
	self.weapon_skins.sparrow_cola.bonus = "spread_p1"
	self.weapon_skins.sparrow_cola.reserve_quality = true
	self.weapon_skins.sparrow_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.sparrow_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_df")
	self.weapon_skins.sparrow_cola.parts = {
		wpn_fps_pis_sparrow_body_941 = {
			[Idstring("mtr_frame"):key()] = {
				pattern_pos = Vector3(0, -1.03363, 0),
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_df"),
				pattern_tweak = Vector3(1, 3.15133, 1)
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_b_df")
			}
		}
	}
	self.weapon_skins.sparrow_cola.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_b_df"),
			pattern_tweak = Vector3(0.872886, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_012_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_006_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_d_df")
		},
		slide = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			uv_offset_rot = Vector3(0.301932, 0.635822, 0),
			pattern_tweak = Vector3(1.20678, 1.53196, 1),
			pattern_pos = Vector3(1.74243, -0.737896, 0),
			uv_scale = Vector3(16.7581, 10.4174, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_010_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		},
		lower_reciever = {
			pattern_pos = Vector3(0.330551, 1.47532, 0),
			pattern_tweak = Vector3(1.54067, 1.56293, 1),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_012_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		}
	}
	self.weapon_skins.benelli_cola = {}
	self.weapon_skins.benelli_cola.name_id = "bm_wskn_benelli_cola"
	self.weapon_skins.benelli_cola.desc_id = "bm_wskn_benelli_cola_desc"
	self.weapon_skins.benelli_cola.weapon_id = "benelli"
	self.weapon_skins.benelli_cola.rarity = "uncommon"
	self.weapon_skins.benelli_cola.bonus = "recoil_p1"
	self.weapon_skins.benelli_cola.reserve_quality = true
	self.weapon_skins.benelli_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.benelli_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_009_df")
	self.weapon_skins.benelli_cola.pattern_tweak = Vector3(2.26314, 0, 1)
	self.weapon_skins.benelli_cola.parts = {
		wpn_fps_sho_ben_s_solid = {
			[Idstring("mtr_solid"):key()] = {
				pattern_pos = Vector3(0.559504, 0.445488, 0),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
				pattern_tweak = Vector3(0.572296, 0, 1)
			}
		},
		wpn_fps_sho_ben_s_collapsed = {
			[Idstring("mtr_collapse"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_002_df"),
				pattern_pos = Vector3(-0.213212, -1.45337, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df"),
				pattern_tweak = Vector3(0.236805, 0.011, 1)
			}
		},
		wpn_fps_sho_ben_b_long = {
			[Idstring("mtr_barrel"):key()] = {
				uv_scale = Vector3(5.26852, 6.55574, 0),
				uv_offset_rot = Vector3(0.294392, 0.967251, 0)
			}
		},
		wpn_fps_sho_ben_s_collapsable = {
			[Idstring("mtr_collapse"):key()] = {
				pattern_pos = Vector3(-0.226451, -1.31636, 0),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_002_df"),
				pattern_tweak = Vector3(0.252805, 0.02, 1)
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_004_df")
			}
		},
		wpn_fps_sho_ben_b_short = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_5_df"),
				uv_scale = Vector3(4.31503, 4.5534, 0),
				uv_offset_rot = Vector3(0.254233, 0.955092, 0)
			}
		}
	}
	self.weapon_skins.benelli_cola.types = {
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_12_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
			pattern_tweak = Vector3(0.491297, 0, 1),
			pattern_pos = Vector3(0, 0.182455, 0),
			uv_scale = Vector3(4.64875, 3.88595, 1),
			uv_offset_rot = Vector3(0.385789, 0.620742, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_009_b_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_004_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
			uv_offset_rot = Vector3(-0.28953, 1.11281, 0),
			pattern_pos = Vector3(1.10327, 1.66611, 0),
			uv_scale = Vector3(4.60108, 5.55457, 1),
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_5_df"),
			pattern_tweak = Vector3(1.20678, 0.009, 1)
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_009_b_df"),
			pattern_tweak = Vector3(0.682091, 0, 1),
			uv_offset_rot = Vector3(0.282853, 0.874315, 6.20526),
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			pattern_pos = Vector3(1.46578, 0.807537, 0),
			uv_scale = Vector3(12.9918, 8.93947, 1),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_005_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_009_c_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_pos = Vector3(-0.155974, 0.712139, 0),
			pattern_tweak = Vector3(0.905584, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_005_df")
		},
		barrel = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_5_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_003_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_004_df"),
			pattern_pos = Vector3(0.158836, 1.10327, 0),
			uv_scale = Vector3(4.7441, 11.5616, 0),
			uv_offset_rot = Vector3(0.292392, 0.969712, 0),
			pattern_tweak = Vector3(0.72979, 0, 1)
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_009_d_df"),
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.hunter_cola = {}
	self.weapon_skins.hunter_cola.name_id = "bm_wskn_hunter_cola"
	self.weapon_skins.hunter_cola.desc_id = "bm_wskn_hunter_cola_desc"
	self.weapon_skins.hunter_cola.weapon_id = "hunter"
	self.weapon_skins.hunter_cola.rarity = "uncommon"
	self.weapon_skins.hunter_cola.bonus = "total_ammo_p1"
	self.weapon_skins.hunter_cola.reserve_quality = true
	self.weapon_skins.hunter_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.hunter_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_df")
	self.weapon_skins.hunter_cola.pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
	self.weapon_skins.hunter_cola.pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_006_df")
	self.weapon_skins.hunter_cola.pattern_tweak = Vector3(0.443599, 0, 1)
	self.weapon_skins.hunter_cola.pattern_pos = Vector3(0.158836, -0.521483, 0)
	self.weapon_skins.hunter_cola.uv_scale = Vector3(1, 1, 0.387074)
	self.weapon_skins.hunter_cola.parts = {
		wpn_fps_bow_hunter_body_standard = {
			[Idstring("mtr_lever"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_b_df")
			},
			[Idstring("mtr_rear_sight"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
				uv_offset_rot = Vector3(-0.28099, 1.01087, 6.27619),
				uv_scale = Vector3(4.186, 4.7451, 1),
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_b_df")
			},
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_1_df"),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_009_df"),
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_df"),
				uv_offset_rot = Vector3(-0.0695769, 0.931553, 0),
				pattern_pos = Vector3(1.12235, 0.0776774, 0),
				uv_scale = Vector3(8.46272, 9.60692, 1),
				pattern_tweak = Vector3(0.70879, 1.5729, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
			}
		},
		wpn_fps_bow_hunter_o_standard = {
			[Idstring("mtr_rear_sight"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_b_df")
			}
		}
	}
	self.weapon_skins.hunter_cola.types = {
		barrel = {
			pattern_pos = Vector3(0.496266, 1.15097, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_006_df"),
			pattern_tweak = Vector3(1.68376, 1.56293, 1)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_b_df")
		}
	}
	self.weapon_skins.hs2000_cola = {}
	self.weapon_skins.hs2000_cola.name_id = "bm_wskn_hs2000_cola"
	self.weapon_skins.hs2000_cola.desc_id = "bm_wskn_hs2000_cola_desc"
	self.weapon_skins.hs2000_cola.weapon_id = "hs2000"
	self.weapon_skins.hs2000_cola.rarity = "rare"
	self.weapon_skins.hs2000_cola.bonus = "spread_p1"
	self.weapon_skins.hs2000_cola.reserve_quality = true
	self.weapon_skins.hs2000_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.hs2000_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_011_df")
	self.weapon_skins.hs2000_cola.default_blueprint = {
		"wpn_fps_pis_hs2000_body_standard",
		"wpn_fps_pis_hs2000_m_extended",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_pis_hs2000_sl_long"
	}
	self.weapon_skins.hs2000_cola.parts = {
		wpn_fps_pis_hs2000_sl_custom = {
			[Idstring("mtr_sl_custom"):key()] = {
				pattern_pos = Vector3(0.937553, -1.08133, 0),
				pattern_tweak = Vector3(0.351901, 0, 1)
			}
		}
	}
	self.weapon_skins.hs2000_cola.types = {
		slide = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_10_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_008_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df"),
			pattern_pos = Vector3(0.777218, -0.872452, 0),
			uv_scale = Vector3(19.999, 20, 1),
			uv_offset_rot = Vector3(-0.194133, 0.905934, 0),
			pattern_tweak = Vector3(0.406502, 0, 1)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_011_b_df")
		},
		magazine = {
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_009_df"),
			pattern_tweak = Vector3(0.682091, 1.57884, 0),
			pattern_pos = Vector3(0.979251, 0.120677, 0),
			uv_scale = Vector3(2.64641, 0.453377, 1),
			uv_offset_rot = Vector3(0.0252805, 0.912473, 1.62287),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df"),
			uv_offset_rot = Vector3(0.398329, 0.946552, 6.28319),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_014_df"),
			pattern_pos = Vector3(1.63749, 0.578583, 0),
			uv_scale = Vector3(20, 13.85, 1),
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_011_b_df"),
			pattern_tweak = Vector3(1.15908, 0, 1)
		},
		sight = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			uv_scale = Vector3(5.60224, 5.55457, 1),
			uv_offset_rot = Vector3(-0.165514, 1.00787, 6.28319)
		}
	}
	self.weapon_skins.olympic_cola = {}
	self.weapon_skins.olympic_cola.name_id = "bm_wskn_olympic_cola"
	self.weapon_skins.olympic_cola.desc_id = "bm_wskn_olympic_cola_desc"
	self.weapon_skins.olympic_cola.weapon_id = "olympic"
	self.weapon_skins.olympic_cola.rarity = "rare"
	self.weapon_skins.olympic_cola.bonus = "recoil_p1"
	self.weapon_skins.olympic_cola.reserve_quality = true
	self.weapon_skins.olympic_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.olympic_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_012_df")
	self.weapon_skins.olympic_cola.pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
	self.weapon_skins.olympic_cola.pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_010_df")
	self.weapon_skins.olympic_cola.pattern_tweak = Vector3(1.30217, 1.54794, 1)
	self.weapon_skins.olympic_cola.pattern_pos = Vector3(1.26998, 0.712139, 0)
	self.weapon_skins.olympic_cola.default_blueprint = {
		"wpn_fps_m4_uupg_draghandle",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_m4_uupg_b_short_vanilla",
		"wpn_fps_upg_smg_olympic_fg_lr300",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_upg_ass_m4_lower_reciever_core",
		"wpn_fps_upg_m4_m_quad",
		"wpn_fps_upg_m4_s_ubr",
		"wpn_fps_upg_ass_m4_upper_reciever_ballos",
		"wpn_fps_upg_o_rx30"
	}
	self.weapon_skins.olympic_cola.parts = {
		wpn_fps_m4_lower_reciever = {
			[Idstring("m4_lower_reciever"):key()] = {
				pattern_pos = Vector3(-1.40568, -1.34844, 0),
				pattern_tweak = Vector3(0.300503, 1.54794, 1)
			}
		}
	}
	self.weapon_skins.olympic_cola.types = {
		stock = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_1_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_pos = Vector3(0.674981, 1.20074, 0),
			uv_scale = Vector3(4.02898, 7.22318, 1),
			uv_offset_rot = Vector3(-0.0605769, 0.916553, 0),
			pattern_tweak = Vector3(1.92225, 3.14533, 1)
		},
		sight = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_pos = Vector3(1.07465, 0.817076, 0),
			uv_scale = Vector3(6.79411, 12.8011, 1),
			uv_offset_rot = Vector3(0.0443599, 1.24582, 0),
			pattern_tweak = Vector3(1.34987, 0, 1)
		},
		magazine = {
			pattern_pos = Vector3(0, -0.00333858, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_tweak = Vector3(2.82853, 3.24124, 1)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_012_d_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_6_df"),
			uv_offset_rot = Vector3(-0.152895, 0.755838, 0),
			pattern_pos = Vector3(1.48486, 0.960172, 0),
			uv_scale = Vector3(14.4221, 9.13017, 1),
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_012_df"),
			pattern_tweak = Vector3(0.491297, 1.57791, 1)
		},
		upper_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			uv_offset_rot = Vector3(0.213995, 0.874315, 0),
			pattern_pos = Vector3(-0.394467, -0.94377, 0),
			uv_scale = Vector3(6.55574, 8.55807, 1),
			pattern_tweak = Vector3(0.72079, 1.57791, 1)
		},
		drag_handle = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_012_b_df"),
			pattern_tweak = Vector3(0, 0, 1)
		},
		barrel_ext = {
			pattern_tweak = Vector3(0, 0, 1)
		},
		stock_adapter = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_012_b_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_012_c_df"),
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.g3_cola = {}
	self.weapon_skins.g3_cola.name_id = "bm_wskn_g3_cola"
	self.weapon_skins.g3_cola.desc_id = "bm_wskn_g3_cola_desc"
	self.weapon_skins.g3_cola.weapon_id = "g3"
	self.weapon_skins.g3_cola.rarity = "rare"
	self.weapon_skins.g3_cola.bonus = "spread_p1"
	self.weapon_skins.g3_cola.reserve_quality = true
	self.weapon_skins.g3_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.g3_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_e_df")
	self.weapon_skins.g3_cola.default_blueprint = {
		"wpn_fps_ass_g3_b_long",
		"wpn_fps_ass_g3_body_lower",
		"wpn_fps_ass_g3_body_upper",
		"wpn_fps_ass_g3_m_mag",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_ass_g3_fg_railed",
		"wpn_fps_ass_g3_g_sniper",
		"wpn_fps_upg_o_cs",
		"wpn_fps_ass_g3_s_wood"
	}
	self.weapon_skins.g3_cola.parts = {
		wpn_fps_ass_g3_fg_railed = {
			[Idstring("g3_foregrip_railed"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_5_df"),
				uv_scale = Vector3(9.71027, 7.31853, 1),
				uv_offset_rot = Vector3(-0.416546, 1.06257, 0)
			}
		},
		wpn_fps_ass_g3_b_long = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_009_df")
			}
		},
		wpn_fps_ass_g3_body_upper = {
			[Idstring("g3_upperbody"):key()] = {
				pattern_pos = Vector3(-1.39614, 1.66611, 0)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_df")
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_i_df")
			}
		},
		wpn_fps_ass_g3_g_sniper = {
			[Idstring("grip_sniper"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_e_df")
			}
		},
		wpn_fps_ass_g3_body_lower = {
			[Idstring("lower"):key()] = {
				pattern_pos = Vector3(0.673981, 1.81975, 0)
			}
		}
	}
	self.weapon_skins.g3_cola.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_f_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_011_df"),
			pattern_pos = Vector3(0.500726, 1.07465, 0),
			pattern_tweak = Vector3(1, 1.54794, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_g_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_018_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_007_df")
		},
		foregrip = {
			pattern_pos = Vector3(0.521345, 0.168376, 0),
			pattern_tweak = Vector3(0.72979, 1.56293, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_001_df"),
			uv_offset_rot = Vector3(0.0157406, 0.559504, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
			pattern_pos = Vector3(0, -0.108275, 0),
			uv_scale = Vector3(4.64875, 6.12667, 1),
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_10_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_j_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_h_df")
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_i_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_013_i_df")
		}
	}
	self.weapon_skins.b682_cola = {}
	self.weapon_skins.b682_cola.name_id = "bm_wskn_b682_cola"
	self.weapon_skins.b682_cola.desc_id = "bm_wskn_b682_cola_desc"
	self.weapon_skins.b682_cola.weapon_id = "b682"
	self.weapon_skins.b682_cola.rarity = "epic"
	self.weapon_skins.b682_cola.bonus = "recoil_p1"
	self.weapon_skins.b682_cola.reserve_quality = true
	self.weapon_skins.b682_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.b682_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_014_df")
	self.weapon_skins.b682_cola.default_blueprint = {
		"wpn_fps_shot_b682_body_standard",
		"wpn_fps_shot_b682_b_long",
		"wpn_fps_shot_b682_s_ammopouch"
	}
	self.weapon_skins.b682_cola.parts = {
		wpn_fps_shot_b682_s_long = {
			[Idstring("mtr_stock"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_010_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
			}
		},
		wpn_fps_shot_b682_s_short = {
			[Idstring("mtr_stock"):key()] = {
				pattern_pos = Vector3(-0.566182, -0.985929, 0),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_010_df"),
				pattern_tweak = Vector3(0.491297, 1.36813, 1)
			}
		},
		wpn_fps_shot_b682_s_ammopouch = {
			[Idstring("mtr_bag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_014_a_df"),
				uv_offset_rot = Vector3(0.282313, 0.893473, 6.25322),
				uv_scale = Vector3(9.42222, 10.6558, 1),
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_10_df")
			},
			[Idstring("mtr_stock"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_010_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
			}
		},
		wpn_fps_shot_b682_b_long = {
			[Idstring("mtr_foregrip"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_015_df"),
				pattern_pos = Vector3(-0.744055, 0.993791, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df"),
				pattern_tweak = Vector3(1.20678, 1.5749, 1)
			},
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_14_df"),
				uv_scale = Vector3(1.78827, 1.83594, 1),
				uv_offset_rot = Vector3(0.218535, 0.998331, 0.678818)
			}
		}
	}
	self.weapon_skins.b682_cola.types = {
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			uv_scale = Vector3(11.5616, 16.0907, 1),
			uv_offset_rot = Vector3(0.196995, 1.09373, 0.049451)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_5_df"),
			uv_offset_rot = Vector3(0.0504394, 0.883633, 0.015),
			pattern_pos = Vector3(1.56517, -0.556642, 0),
			uv_scale = Vector3(8.22435, 8.5104, 1),
			pattern_tweak = Vector3(1.40457, 1.57998, 1)
		},
		barrel = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			uv_scale = Vector3(9.70227, 12.8011, 1),
			uv_offset_rot = Vector3(-0.413546, 1.17959, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_015_df"),
			pattern_pos = Vector3(-0.744055, 0.993791, 0),
			pattern_tweak = Vector3(1.20678, 1.5749, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		}
	}
	self.weapon_skins.gre_m79_cola = {}
	self.weapon_skins.gre_m79_cola.name_id = "bm_wskn_gre_m79_cola"
	self.weapon_skins.gre_m79_cola.desc_id = "bm_wskn_gre_m79_cola_desc"
	self.weapon_skins.gre_m79_cola.weapon_id = "gre_m79"
	self.weapon_skins.gre_m79_cola.rarity = "epic"
	self.weapon_skins.gre_m79_cola.bonus = "concealment_p1"
	self.weapon_skins.gre_m79_cola.reserve_quality = true
	self.weapon_skins.gre_m79_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.gre_m79_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_015_df")
	self.weapon_skins.gre_m79_cola.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_015_b_df"),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_019_df"),
			pattern_tweak = Vector3(1.68376, 1.57885, 1),
			pattern_pos = Vector3(1.39, 0.466027, 0),
			uv_scale = Vector3(6.07899, 9.17785, 0),
			uv_offset_rot = Vector3(-0.190593, 1.08419, 0.169331),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_008_df")
		},
		barrel = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_2_df"),
			uv_offset_rot = Vector3(0.120598, 1.04995, 0),
			pattern_tweak = Vector3(1, 3.15133, 1),
			pattern_pos = Vector3(-0.232292, 1.68711, 0),
			uv_scale = Vector3(4.5534, 4.79177, 0),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_006_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		}
	}
	self.weapon_skins.m16_cola = {}
	self.weapon_skins.m16_cola.name_id = "bm_wskn_m16_cola"
	self.weapon_skins.m16_cola.desc_id = "bm_wskn_m16_cola_desc"
	self.weapon_skins.m16_cola.weapon_id = "m16"
	self.weapon_skins.m16_cola.rarity = "legendary"
	self.weapon_skins.m16_cola.bonus = "spread_p1"
	self.weapon_skins.m16_cola.reserve_quality = true
	self.weapon_skins.m16_cola.texture_bundle_folder = "cash/safes/cola"
	self.weapon_skins.m16_cola.unique_name_id = "bm_wskn_m16_cola"
	self.weapon_skins.m16_cola.locked = true
	self.weapon_skins.m16_cola.base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_016_df")
	self.weapon_skins.m16_cola.pattern_tweak = Vector3(1.15908, 1.5929, 1)
	self.weapon_skins.m16_cola.pattern_pos = Vector3(1.00787, -1.999, 0)
	self.weapon_skins.m16_cola.default_blueprint = {
		"wpn_fps_m4_uupg_draghandle",
		"wpn_fps_upg_m4_m_pmag",
		"wpn_fps_upg_o_acog",
		"wpn_fps_ass_m16_b_legend",
		"wpn_fps_ass_m16_fg_legend",
		"wpn_fps_ass_m16_s_legend",
		"wpn_fps_upg_m4_g_mgrip",
		"wpn_fps_upg_ass_m4_lower_reciever_core",
		"wpn_fps_upg_ass_m4_upper_reciever_core"
	}
	self.weapon_skins.m16_cola.parts = {
		wpn_fps_upg_m4_g_mgrip = {
			[Idstring("mtr_moek"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_df"),
				uv_offset_rot = Vector3(0.079979, 0.935553, 4.70975),
				pattern_pos = Vector3(1.2062, 0.866315, 0),
				uv_scale = Vector3(14.2314, 14.4697, 1),
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_14_df"),
				pattern_tweak = Vector3(1, 2.82166, 1)
			}
		},
		wpn_fps_ass_m16_b_legend = {
			[Idstring("mtr_b_legend"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_15_df"),
				uv_scale = Vector3(6.69876, 9.36854, 0),
				uv_offset_rot = Vector3(0.325011, 0.915013, 0)
			}
		},
		wpn_fps_upg_ass_m4_upper_reciever_core = {
			[Idstring("mtr_upper"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_18_df"),
				uv_offset_rot = Vector3(-0.309149, 1.18759, 2.95553),
				pattern_pos = Vector3(0, -0.337228, 0),
				uv_scale = Vector3(9.70227, 10.8941, 0)
			}
		},
		wpn_fps_ass_m16_s_legend = {
			[Idstring("mtr_s_legend"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_1_df"),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_017_df"),
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df"),
				uv_offset_rot = Vector3(0.244694, 0.941092, 0),
				pattern_pos = Vector3(1.08311, 0.916694, 0),
				uv_scale = Vector3(8.5104, 4.69642, 1),
				pattern_tweak = Vector3(0.854187, 1.5709, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_007_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_016_b_df")
			}
		},
		wpn_fps_ass_m16_fg_legend = {
			[Idstring("mtr_fg_legend"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_19_df"),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_004_df"),
				pattern_tweak = Vector3(0.438899, 1.5859, 1),
				pattern_pos = Vector3(-0.006, -0.991229, 0),
				uv_scale = Vector3(20, 3.64958, 0),
				uv_offset_rot = Vector3(-0.203673, 0.979251, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_002_df")
			}
		},
		wpn_fps_upg_m4_m_pmag = {
			[Idstring("pmag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_016_d_df"),
				uv_scale = Vector3(4.50573, 5.07782, 1),
				uv_offset_rot = Vector3(0.0157406, 0.597663, 0)
			}
		},
		wpn_fps_upg_ass_m4_lower_reciever_core = {
			[Idstring("mtr_lower"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_20_df"),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df"),
				pattern_pos = Vector3(0.340091, 0.712139, 0),
				uv_scale = Vector3(8.129, 6.36504, 1),
				uv_offset_rot = Vector3(-0.175053, 0.826616, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df")
			}
		}
	}
	self.weapon_skins.m16_cola.types = {
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_017_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_017_df")
		}
	}
	self.weapon_skins.gre_m79_burn = {}
	self.weapon_skins.gre_m79_burn.name_id = "bm_wskn_gre_m79_burn"
	self.weapon_skins.gre_m79_burn.desc_id = "bm_wskn_gre_m79_burn_desc"
	self.weapon_skins.gre_m79_burn.weapon_id = "gre_m79"
	self.weapon_skins.gre_m79_burn.rarity = "common"
	self.weapon_skins.gre_m79_burn.bonus = "concealment_p1"
	self.weapon_skins.gre_m79_burn.reserve_quality = true
	self.weapon_skins.gre_m79_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.gre_m79_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df")
	self.weapon_skins.gre_m79_burn.pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df")
	self.weapon_skins.gre_m79_burn.pattern_tweak = Vector3(2.82853, 1.57791, 1)
	self.weapon_skins.gre_m79_burn.pattern_pos = Vector3(0.216075, -0.766515, 0)
	self.weapon_skins.gre_m79_burn.parts = {
		wpn_fps_gre_m79_stock_short = {
			[Idstring("mtr_stock"):key()] = {
				uv_scale = Vector3(20, 20, 1)
			}
		}
	}
	self.weapon_skins.gre_m79_burn.types = {
		stock = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_offset_rot = Vector3(-0.316689, 0.883854, 3.2862),
			pattern_pos = Vector3(0.0252805, 0, 0),
			uv_scale = Vector3(4.7441, 4.83945, 0),
			pattern_tweak = Vector3(3.49631, 0.922533, 1)
		},
		barrel = {
			pattern_pos = Vector3(0.282853, -0.241831, 0),
			pattern_tweak = Vector3(1.44527, 0, 1)
		}
	}
	self.weapon_skins.b682_burn = {}
	self.weapon_skins.b682_burn.name_id = "bm_wskn_b682_burn"
	self.weapon_skins.b682_burn.desc_id = "bm_wskn_b682_burn_desc"
	self.weapon_skins.b682_burn.weapon_id = "b682"
	self.weapon_skins.b682_burn.rarity = "common"
	self.weapon_skins.b682_burn.bonus = "recoil_p1"
	self.weapon_skins.b682_burn.reserve_quality = true
	self.weapon_skins.b682_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.b682_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df")
	self.weapon_skins.b682_burn.pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df")
	self.weapon_skins.b682_burn.pattern_tweak = Vector3(4.16408, 0, 1)
	self.weapon_skins.b682_burn.pattern_pos = Vector3(0.0348201, -0.0605769, 0)
	self.weapon_skins.b682_burn.parts = {
		wpn_fps_shot_b682_s_ammopouch = {
			[Idstring("mtr_bag"):key()] = {
				uv_scale = Vector3(4.3627, 3.55223, 1),
				uv_offset_rot = Vector3(0.279313, 0.919933, 1.57791)
			},
			[Idstring("mtr_stock"):key()] = {
				uv_offset_rot = Vector3(0.979251, 0, 0)
			}
		},
		wpn_fps_shot_b682_s_short = {
			[Idstring("mtr_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
				uv_offset_rot = Vector3(0.235154, 1.00233, 3.15133),
				uv_scale = Vector3(2.59874, 2.59874, 1),
				pattern_tweak = Vector3(1.77916, 0, 1)
			}
		}
	}
	self.weapon_skins.b682_burn.types = {
		barrel = {
			pattern_pos = Vector3(0.158836, 0.435488, 0),
			pattern_tweak = Vector3(1.82686, 6.28319, 1)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df"),
			uv_scale = Vector3(3.40921, 3.45688, 1),
			uv_offset_rot = Vector3(0.148535, 0.995791, 3.15732)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_b_df")
		}
	}
	self.weapon_skins.g3_burn = {}
	self.weapon_skins.g3_burn.name_id = "bm_wskn_g3_burn"
	self.weapon_skins.g3_burn.desc_id = "bm_wskn_g3_burn_desc"
	self.weapon_skins.g3_burn.weapon_id = "g3"
	self.weapon_skins.g3_burn.rarity = "common"
	self.weapon_skins.g3_burn.bonus = "spread_p1"
	self.weapon_skins.g3_burn.reserve_quality = true
	self.weapon_skins.g3_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.g3_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_df")
	self.weapon_skins.g3_burn.pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
	self.weapon_skins.g3_burn.pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df")
	self.weapon_skins.g3_burn.pattern_tweak = Vector3(2.30384, 0, 1)
	self.weapon_skins.g3_burn.pattern_pos = Vector3(1.17005, 0, 0)
	self.weapon_skins.g3_burn.parts = {
		wpn_fps_ass_g3_s_sniper = {
			[Idstring("sniper"):key()] = {
				pattern_tweak = Vector3(5.40425, 0, 1)
			}
		},
		wpn_fps_ass_g3_fg_railed = {
			[Idstring("g3_foregrip_railed"):key()] = {
				uv_scale = Vector3(20, 20, 1),
				uv_offset_rot = Vector3(0.158836, 0.999949, 0)
			}
		}
	}
	self.weapon_skins.g3_burn.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_c_df"),
			pattern_pos = Vector3(0, 0.282853, 0)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_b_df"),
			uv_scale = Vector3(3.55223, 3.50456, 1),
			uv_offset_rot = Vector3(0.196995, 0.740759, 1.56293)
		},
		upper_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df"),
			uv_scale = Vector3(1.59757, 1.59757, 1),
			uv_offset_rot = Vector3(0.0443599, 0.884854, 4.71278)
		},
		foregrip = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_scale = Vector3(3.40921, 3.26618, 0),
			uv_offset_rot = Vector3(0.159376, 1.00441, 0)
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_scale = Vector3(5.03015, 4.41038, 1),
			uv_offset_rot = Vector3(0.0157406, 0.549964, 1.56293)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_d_df")
		}
	}
	self.weapon_skins.mp9_burn = {}
	self.weapon_skins.mp9_burn.name_id = "bm_wskn_mp9_burn"
	self.weapon_skins.mp9_burn.desc_id = "bm_wskn_mp9_burn_desc"
	self.weapon_skins.mp9_burn.weapon_id = "mp9"
	self.weapon_skins.mp9_burn.rarity = "common"
	self.weapon_skins.mp9_burn.bonus = "recoil_p1"
	self.weapon_skins.mp9_burn.reserve_quality = true
	self.weapon_skins.mp9_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.mp9_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_004_df")
	self.weapon_skins.mp9_burn.parts = {
		wpn_fps_smg_mp9_s_fold = {
			[Idstring("foldable"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df")
			}
		},
		wpn_fps_smg_mp9_body_mp9 = {
			[Idstring("stubby"):key()] = {
				pattern_pos = Vector3(0, -0.089196, 0),
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df"),
				pattern_tweak = Vector3(0.3959, 0, 1)
			}
		},
		wpn_fps_smg_mp9_s_skel = {
			[Idstring("skeletal"):key()] = {
				uv_scale = Vector3(20, 20, 1),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_smg_mp9_m_short = {
			[Idstring("mag_standard"):key()] = {
				pattern_pos = Vector3(0, -0.0605769, 0),
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df"),
				pattern_tweak = Vector3(0.348202, 0, 1)
			}
		}
	}
	self.weapon_skins.mp9_burn.types = {
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_11_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
			pattern_pos = Vector3(0.325091, 0.130217, 0),
			uv_scale = Vector3(1, 1, 0),
			pattern_tweak = Vector3(2.87622, 2.34215, 1)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df"),
			uv_scale = Vector3(2.74176, 2.78944, 1),
			uv_offset_rot = Vector3(-0.325149, 0.970251, 1.60788),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_004_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_004_b_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
			pattern_tweak = Vector3(2.06535, 0.753743, 1)
		}
	}
	self.weapon_skins.hs2000_burn = {}
	self.weapon_skins.hs2000_burn.name_id = "bm_wskn_hs2000_burn"
	self.weapon_skins.hs2000_burn.desc_id = "bm_wskn_hs2000_burn_desc"
	self.weapon_skins.hs2000_burn.weapon_id = "hs2000"
	self.weapon_skins.hs2000_burn.rarity = "common"
	self.weapon_skins.hs2000_burn.bonus = "spread_p1"
	self.weapon_skins.hs2000_burn.reserve_quality = true
	self.weapon_skins.hs2000_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.hs2000_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_005_df")
	self.weapon_skins.hs2000_burn.types = {
		slide = {
			pattern_pos = Vector3(0.140836, 0.642822, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_005_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
			pattern_tweak = Vector3(4.11639, 4.70578, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
			pattern_tweak = Vector3(3.35321, 0, 1)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_scale = Vector3(2.83711, 2.83711, 0.165276),
			uv_offset_rot = Vector3(0.282853, 0.941092, 1.56293)
		},
		barrel_ext = {
			pattern_pos = Vector3(-0.232292, -0.0867357, 0),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
			pattern_tweak = Vector3(2.92392, 0, 1)
		}
	}
	self.weapon_skins.hunter_burn = {}
	self.weapon_skins.hunter_burn.name_id = "bm_wskn_hunter_burn"
	self.weapon_skins.hunter_burn.desc_id = "bm_wskn_hunter_burn_desc"
	self.weapon_skins.hunter_burn.weapon_id = "hunter"
	self.weapon_skins.hunter_burn.rarity = "common"
	self.weapon_skins.hunter_burn.bonus = "total_ammo_p1"
	self.weapon_skins.hunter_burn.reserve_quality = true
	self.weapon_skins.hunter_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.hunter_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df")
	self.weapon_skins.hunter_burn.types = {
		lower_reciever = {
			pattern_pos = Vector3(-0.002, 0.544504, 0),
			pattern_tweak = Vector3(8.45695, 0.858638, 1),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_003_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_b_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_c_df")
		}
	}
	self.weapon_skins.benelli_burn = {}
	self.weapon_skins.benelli_burn.name_id = "bm_wskn_benelli_burn"
	self.weapon_skins.benelli_burn.desc_id = "bm_wskn_benelli_burn_desc"
	self.weapon_skins.benelli_burn.weapon_id = "benelli"
	self.weapon_skins.benelli_burn.rarity = "uncommon"
	self.weapon_skins.benelli_burn.bonus = "recoil_p1"
	self.weapon_skins.benelli_burn.reserve_quality = true
	self.weapon_skins.benelli_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.benelli_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_007_df")
	self.weapon_skins.benelli_burn.parts = {
		wpn_fps_sho_ben_s_solid = {
			[Idstring("mtr_solid"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df"),
				uv_scale = Vector3(2.88479, 2.74176, 1),
				uv_offset_rot = Vector3(0.139757, 1.00787, 4.69478)
			}
		},
		wpn_fps_upg_ns_sho_salvo_large = {
			[Idstring("mtr_salvo_large"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_005_df"),
				pattern_pos = Vector3(-0.0128784, 0.502266, 0),
				pattern_tweak = Vector3(2.20844, 2.34215, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df")
			}
		},
		wpn_fps_sho_ben_body_standard = {
			[Idstring("mtr_rearsight"):key()] = {
				pattern_pos = Vector3(0.244694, -0.747436, 0),
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_007_c_df"),
				pattern_tweak = Vector3(1.39757, 0, 1)
			}
		}
	}
	self.weapon_skins.benelli_burn.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_007_b_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_015_df"),
			pattern_pos = Vector3(-0.737896, 0.603043, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df"),
			pattern_tweak = Vector3(1.39757, 0, 1)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_offset_rot = Vector3(-0.369467, 0.848695, 4.14034),
			pattern_tweak = Vector3(2.92992, 0.0264962, 1),
			pattern_pos = Vector3(1.13627, 1.2659, 0),
			uv_scale = Vector3(1.38087, 1.45922, 0),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_005_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_004_df")
		},
		foregrip = {
			pattern_pos = Vector3(-0.27045, 0.072979, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_004_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_005_df"),
			pattern_tweak = Vector3(2.12075, 2.29719, 1)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_007_d_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_004_df"),
			pattern_tweak = Vector3(1.30217, 0, 1),
			uv_offset_rot = Vector3(0.40425, 0.628822, 3.14133),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_015_df"),
			pattern_pos = Vector3(-0.555182, 1.43616, 0),
			uv_scale = Vector3(4.7441, 5.1255, 0.260673),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_007_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df")
		}
	}
	self.weapon_skins.sparrow_burn = {}
	self.weapon_skins.sparrow_burn.name_id = "bm_wskn_sparrow_burn"
	self.weapon_skins.sparrow_burn.desc_id = "bm_wskn_sparrow_burn_desc"
	self.weapon_skins.sparrow_burn.weapon_id = "sparrow"
	self.weapon_skins.sparrow_burn.rarity = "uncommon"
	self.weapon_skins.sparrow_burn.bonus = "concealment_p1"
	self.weapon_skins.sparrow_burn.reserve_quality = true
	self.weapon_skins.sparrow_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.sparrow_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_008_df")
	self.weapon_skins.sparrow_burn.pattern_tweak = Vector3(1.82686, 0, 1)
	self.weapon_skins.sparrow_burn.pattern_pos = Vector3(0, 1.46578, 0)
	self.weapon_skins.sparrow_burn.parts = {
		wpn_fps_pis_sparrow_body_941 = {
			[Idstring("mtr_frame"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df"),
				uv_scale = Vector3(1.92629, 2.12199, 0),
				uv_offset_rot = Vector3(-0.152895, 0.761997, 6.27719)
			},
			[Idstring("mtr_controls"):key()] = {
				uv_scale = Vector3(1.002, 1, 1),
				uv_offset_rot = Vector3(0, 0.273313, 0)
			}
		},
		wpn_fps_pis_sparrow_body_rpl = {
			[Idstring("mtr_controls"):key()] = {
				uv_scale = Vector3(20, 20, 1)
			}
		},
		wpn_fps_pis_sparrow_g_dummy = {
			[Idstring("mtr_grips"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_005_df"),
				uv_scale = Vector3(0.7871, 0.834774, 0),
				uv_offset_rot = Vector3(0.130217, 1.00487, 5.05442)
			}
		},
		wpn_fps_pis_sparrow_g_cowboy = {
			[Idstring("mtr_cowboy"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_005_df"),
				uv_scale = Vector3(1.02547, 0.977799, 0),
				uv_offset_rot = Vector3(-0.0590372, 0.637822, 4.9795)
			}
		}
	}
	self.weapon_skins.sparrow_burn.types = {
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_005_df"),
			uv_scale = Vector3(2.36036, 1.02547, 0.086573),
			uv_offset_rot = Vector3(-0.0967357, 0.839315, 1.59587),
			pattern_tweak = Vector3(0.825187, 0, 0)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_001_df")
		},
		barrel_ext = {
			pattern_tweak = Vector3(1.34987, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_005_df")
		},
		slide = {
			pattern_pos = Vector3(-0.089196, -0.155974, 0),
			pattern_tweak = Vector3(1.20678, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		}
	}
	self.weapon_skins.m37_burn = {}
	self.weapon_skins.m37_burn.name_id = "bm_wskn_m37_burn"
	self.weapon_skins.m37_burn.desc_id = "bm_wskn_m37_burn_desc"
	self.weapon_skins.m37_burn.weapon_id = "m37"
	self.weapon_skins.m37_burn.rarity = "uncommon"
	self.weapon_skins.m37_burn.bonus = "recoil_p1"
	self.weapon_skins.m37_burn.reserve_quality = true
	self.weapon_skins.m37_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.m37_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_009_df")
	self.weapon_skins.m37_burn.parts = {
		wpn_fps_shot_m37_body_standard = {
			[Idstring("mtr_internal"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		}
	}
	self.weapon_skins.m37_burn.types = {
		gadget = {
			pattern_pos = Vector3(1.4467, -1.42476, 0),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_004_df"),
			pattern_tweak = Vector3(0.001, 1.53296, 1)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_010_df"),
			uv_scale = Vector3(1.1685, 0.930124, 0),
			uv_offset_rot = Vector3(-0.0625769, 0.950632, 1.56594)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_009_df"),
			pattern_tweak = Vector3(6.16742, 1.47302, 1),
			pattern_pos = Vector3(0.316011, -0.0358784, 0),
			uv_scale = Vector3(9.74994, 9.51157, 0),
			uv_offset_rot = Vector3(-0.134895, 0.999251, 3.13635),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_001_df")
		},
		foregrip = {
			pattern_pos = Vector3(1.51347, -1.06225, 0),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_004_df"),
			pattern_tweak = Vector3(0.948584, 1.57791, 1)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_009_c_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_009_b_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df"),
			pattern_tweak = Vector3(2.39924, 0, 1),
			pattern_pos = Vector3(-0.213212, 0.282853, 0),
			uv_scale = Vector3(2.02664, 2.16967, 1),
			uv_offset_rot = Vector3(0.130217, 0.988791, 1.57295),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		}
	}
	self.weapon_skins.spas12_burn = {}
	self.weapon_skins.spas12_burn.name_id = "bm_wskn_spas12_burn"
	self.weapon_skins.spas12_burn.desc_id = "bm_wskn_spas12_burn_desc"
	self.weapon_skins.spas12_burn.weapon_id = "spas12"
	self.weapon_skins.spas12_burn.rarity = "uncommon"
	self.weapon_skins.spas12_burn.bonus = "recoil_p1"
	self.weapon_skins.spas12_burn.reserve_quality = true
	self.weapon_skins.spas12_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.spas12_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_010_df")
	self.weapon_skins.spas12_burn.parts = {
		wpn_fps_sho_s_spas12_solid = {
			[Idstring("mtr_solid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df"),
				uv_offset_rot = Vector3(0.254233, 0.979251, 1.57791),
				uv_scale = Vector3(2.64641, 3.21851, 0)
			}
		},
		wpn_fps_sho_s_spas12_folded = {
			[Idstring("mtr_stock"):key()] = {
				uv_offset_rot = Vector3(2, 2, 0),
				uv_scale = Vector3(20, 20, 1)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df")
			}
		},
		wpn_fps_sho_b_spas12_short = {
			[Idstring("mtr_barrel"):key()] = {
				uv_offset_rot = Vector3(0.208455, 0.873775, 4.70977),
				uv_scale = Vector3(1.54989, 1.40687, 1)
			}
		}
	}
	self.weapon_skins.spas12_burn.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_010_b_df"),
			cubemap_pattern_control = Vector3(0, 0.436157, 0),
			uv_scale = Vector3(1, 1, 0.720964),
			pattern_pos = Vector3(-0.997468, -0.764595, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_003_df"),
			pattern_tweak = Vector3(1.25447, 3.24124, 1),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_017_df")
		},
		barrel = {
			pattern_tweak = Vector3(1.54067, 1.56293, 1),
			uv_offset_rot = Vector3(-0.227292, 0.759838, 0),
			uv_scale = Vector3(1.26385, 1.18817, 0.260673),
			pattern_pos = Vector3(0, -1.48199, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_006_df")
		},
		stock = {
			uv_offset_rot = Vector3(0.038979, 0.889774, 1.57991),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_scale = Vector3(1.64524, 1.69292, 0.246363)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_010_b_df"),
			pattern_tweak = Vector3(2.44594, 0.119376, 1),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df"),
			uv_scale = Vector3(2.45771, 2.45571, 0),
			pattern_pos = Vector3(-0.531562, 0.732139, 0),
			uv_offset_rot = Vector3(-0.0777356, 0.922473, 1.57793),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_001_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_012_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_005_df")
		}
	}
	self.weapon_skins.fal_burn = {}
	self.weapon_skins.fal_burn.name_id = "bm_wskn_fal_burn"
	self.weapon_skins.fal_burn.desc_id = "bm_wskn_fal_burn_desc"
	self.weapon_skins.fal_burn.weapon_id = "fal"
	self.weapon_skins.fal_burn.rarity = "rare"
	self.weapon_skins.fal_burn.bonus = "spread_p1"
	self.weapon_skins.fal_burn.reserve_quality = true
	self.weapon_skins.fal_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.fal_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_011_df")
	self.weapon_skins.fal_burn.default_blueprint = {
		"wpn_fps_ass_fal_body_standard",
		"wpn_fps_ass_fal_fg_wood",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_ass_fal_g_01",
		"wpn_fps_ass_fal_m_01",
		"wpn_fps_ass_fal_s_wood",
		"wpn_fps_upg_o_eotech"
	}
	self.weapon_skins.fal_burn.parts = {
		wpn_fps_ass_fal_s_03 = {
			[Idstring("mat_stock03"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_002_df"),
				pattern_pos = Vector3(0, 0.00620103, 0),
				uv_scale = Vector3(2.36036, 2.41404, 0),
				uv_offset_rot = Vector3(0.254233, 1.31768, 3.13032)
			}
		},
		wpn_fps_ass_fal_m_standard = {
			[Idstring("mat_magazine02"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_009_df"),
				uv_offset_rot = Vector3(-0.136895, 1.19866, 1.75773),
				pattern_pos = Vector3(-0.136434, 0.425948, 0),
				uv_scale = Vector3(1.74059, 2.02664, 0.18674)
			}
		},
		wpn_fps_ass_fal_fg_01 = {
			[Idstring("mat_frontgrip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_011_c_df"),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
				pattern_pos = Vector3(0.311472, 0.941092, 0),
				pattern_tweak = Vector3(2.63773, 2.35713, 1)
			}
		},
		wpn_fps_ass_fal_g_standard = {
			[Idstring("mat_grip02"):key()] = {
				uv_offset_rot = Vector3(-0.0987357, 1.04141, 0)
			}
		},
		wpn_fps_ass_fal_s_standard = {
			[Idstring("mat_stock02"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_011_df"),
				uv_offset_rot = Vector3(0.111138, 0.817076, 0.0944058),
				pattern_pos = Vector3(0.0538995, 0.727219, 0),
				uv_scale = Vector3(1.1685, 0.990798, 1),
				pattern_tweak = Vector3(1.25447, 0.184315, 1)
			}
		},
		wpn_fps_ass_fal_s_01 = {
			[Idstring("mat_stock"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df"),
				uv_offset_rot = Vector3(-0.146434, 0.995711, 1.57791),
				uv_scale = Vector3(3.74293, 3.59991, 1),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df")
			}
		}
	}
	self.weapon_skins.fal_burn.types = {
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_011_f_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_011_e_df"),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_009_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_005_df"),
			uv_offset_rot = Vector3(0.225614, 0.340091, 4.70977),
			pattern_pos = Vector3(1.05557, 0.549964, 0),
			uv_scale = Vector3(1.78827, 1.78827, 0.315526),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_df"),
			pattern_tweak = Vector3(2.59003, 2.29719, 1)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_011_df"),
			uv_offset_rot = Vector3(-0.0093386, 0.915092, 4.50698),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_002_df"),
			pattern_pos = Vector3(0.397329, -0.466165, 0),
			uv_scale = Vector3(1.1805, 1.26385, 0.232054),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_011_df"),
			pattern_tweak = Vector3(1.35787, 4.34613, 1)
		},
		upper_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df"),
			uv_scale = Vector3(2.88479, 2.98014, 0.1772),
			uv_offset_rot = Vector3(0.493266, 0.655361, 0.167346),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		},
		sight = {
			pattern_pos = Vector3(1.88552, 0.0443599, 0),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_011_d_df"),
			pattern_tweak = Vector3(0.920584, 0, 1)
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df"),
			uv_offset_rot = Vector3(-0.547102, 1.06011, 4.71475),
			pattern_tweak = Vector3(1, 4.88959, 1),
			pattern_pos = Vector3(0.883854, 0.282853, 0),
			uv_scale = Vector3(1.07315, 1, 0.16766),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_010_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_002_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_011_c_df")
		},
		grip = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_scale = Vector3(1.1685, 1.21617, 0.19151),
			uv_offset_rot = Vector3(-0.184593, 0.99687, 0)
		}
	}
	self.weapon_skins.glock_18c_burn = {}
	self.weapon_skins.glock_18c_burn.name_id = "bm_wskn_glock_18c_burn"
	self.weapon_skins.glock_18c_burn.desc_id = "bm_wskn_glock_18c_burn_desc"
	self.weapon_skins.glock_18c_burn.weapon_id = "glock_18c"
	self.weapon_skins.glock_18c_burn.rarity = "rare"
	self.weapon_skins.glock_18c_burn.bonus = "recoil_p1"
	self.weapon_skins.glock_18c_burn.reserve_quality = true
	self.weapon_skins.glock_18c_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.glock_18c_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_012_df")
	self.weapon_skins.glock_18c_burn.default_blueprint = {
		"wpn_fps_pis_g18c_body_frame",
		"wpn_fps_pis_g18c_b_standard",
		"wpn_fps_pis_g18c_s_stock",
		"wpn_fps_pis_g18c_m_mag_33rnd",
		"wpn_fps_pis_g26_g_laser",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_upg_ns_pis_ipsccomp"
	}
	self.weapon_skins.glock_18c_burn.parts = {
		wpn_fps_pis_g18c_co_1 = {
			[Idstring("comp1"):key()] = {
				uv_offset_rot = Vector3(-0.155974, 1.02395, 3.13635),
				uv_scale = Vector3(0.69175, 1.26385, 0)
			}
		},
		wpn_fps_pis_g18c_g_ergo = {
			[Idstring("ergo"):key()] = {
				pattern_pos = Vector3(1.37992, 1.2082, 0),
				pattern_tweak = Vector3(0, 0.0794209, 1)
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				uv_offset_rot = Vector3(-0.512244, 0.988791, 3.12136),
				uv_scale = Vector3(1, 1.54989, 0)
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				uv_offset_rot = Vector3(-0.394467, 1.02695, 3.22626)
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(-0.709277, 1.02203, 4.70977),
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df"),
				uv_scale = Vector3(0.982798, 1.26385, 0)
			}
		},
		wpn_fps_pis_g18c_m_mag_17rnd = {
			[Idstring("mag17rnd"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_012_c_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_001_df"),
				uv_scale = Vector3(0.01, 0.01, 1),
				uv_offset_rot = Vector3(2, 2, 0),
				pattern_tweak = Vector3(1.54067, 1.62287, 1),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df")
			}
		},
		wpn_fps_pis_g18c_co_comp_2 = {
			[Idstring("mtr_comp_2"):key()] = {
				uv_offset_rot = Vector3(-0.0541165, 1.02033, 3.14433),
				uv_scale = Vector3(0.644076, 1.40687, 0)
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				uv_offset_rot = Vector3(-0.356308, 1.02949, 3.15133),
				uv_scale = Vector3(1, 2.64641, 0)
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				uv_offset_rot = Vector3(-0.365848, 1.04249, 3.1813),
				uv_scale = Vector3(0.739425, 1.54989, 0)
			}
		},
		wpn_fps_pis_g26_g_gripforce = {
			[Idstring("mtr_gripforce"):key()] = {
				pattern_pos = Vector3(0.931553, -0.871452, 0),
				pattern_tweak = Vector3(0.252805, 0.0794209, 1)
			}
		},
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(-0.28953, 1.00787, 3.13038),
				uv_scale = Vector3(0.69175, 2.02664, 0)
			}
		},
		wpn_fps_upg_ns_pis_small = {
			[Idstring("small"):key()] = {
				uv_offset_rot = Vector3(-0.27999, 1.04603, 3.13635),
				uv_scale = Vector3(0.69175, 0.977799, 0)
			}
		}
	}
	self.weapon_skins.glock_18c_burn.types = {
		slide = {
			pattern_tweak = Vector3(0.682091, 0.28921, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_023_df"),
			uv_scale = Vector3(0.977799, 2.07432, 0),
			pattern_pos = Vector3(0.512345, 1.38946, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			uv_offset_rot = Vector3(-0.0300372, 0.817076, 0),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_012_df")
		},
		barrel_ext = {
			pattern_tweak = Vector3(0.443599, 0.768728, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_017_df"),
			uv_scale = Vector3(0.739425, 1.59757, 0),
			pattern_pos = Vector3(1.00787, -0.61388, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			uv_offset_rot = Vector3(-0.375387, 1.00125, 3.11832),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_017_df")
		},
		magazine = {
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_001_df"),
			pattern_tweak = Vector3(1.87455, 3.13635, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_016_df"),
			uv_scale = Vector3(2.26502, 1.93129, 1),
			pattern_pos = Vector3(1.4934, 0.69306, 0),
			uv_offset_rot = Vector3(-0.317609, 0.977171, 4.75472),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_012_b_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df")
		},
		stock = {
			uv_offset_rot = Vector3(-0.0550372, 0.955172, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_019_df"),
			uv_scale = Vector3(3.02781, 3.12316, 0)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_008_df"),
			uv_scale = Vector3(1, 1, 0),
			pattern_pos = Vector3(0.485186, -1.57739, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_003_df"),
			pattern_tweak = Vector3(0.348202, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_017_df")
		},
		lower_reciever = {
			pattern_tweak = Vector3(1.25447, 0, 0),
			uv_offset_rot = Vector3(-0.145815, 0.746378, 5.94352),
			uv_scale = Vector3(2.55106, 2.59874, 0),
			pattern_pos = Vector3(-0.155974, -0.327689, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_019_df")
		}
	}
	self.weapon_skins.uzi_burn = {}
	self.weapon_skins.uzi_burn.name_id = "bm_wskn_uzi_burn"
	self.weapon_skins.uzi_burn.desc_id = "bm_wskn_uzi_burn_desc"
	self.weapon_skins.uzi_burn.weapon_id = "uzi"
	self.weapon_skins.uzi_burn.rarity = "rare"
	self.weapon_skins.uzi_burn.bonus = "spread_p1"
	self.weapon_skins.uzi_burn.reserve_quality = true
	self.weapon_skins.uzi_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.uzi_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_013_df")
	self.weapon_skins.uzi_burn.default_blueprint = {
		"wpn_fps_smg_uzi_b_standard",
		"wpn_fps_smg_uzi_body_standard",
		"wpn_fps_smg_uzi_g_standard",
		"wpn_fps_smg_uzi_m_standard",
		"wpn_fps_smg_uzi_fg_rail",
		"wpn_fps_smg_uzi_s_leather"
	}
	self.weapon_skins.uzi_burn.parts = {
		wpn_fps_smg_uzi_fg_standard = {
			[Idstring("mat_foregrip"):key()] = {
				uv_scale = Vector3(3.45688, 4.31503, 0.229669),
				uv_offset_rot = Vector3(0.328091, 1.15651, 6.19328)
			}
		},
		wpn_fps_smg_uzi_s_solid = {
			[Idstring("mat_stock_2"):key()] = {
				pattern_pos = Vector3(0.0443599, -0.121196, 0),
				pattern_tweak = Vector3(1.01598, 0.244255, 1)
			}
		},
		wpn_fps_smg_uzi_s_unfolded = {
			[Idstring("mat_stock_1a"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df"),
				uv_scale = Vector3(2.64641, 1.50222, 1),
				uv_offset_rot = Vector3(0.445028, 1.08219, 1.57791)
			}
		},
		wpn_fps_smg_uzi_s_standard = {
			[Idstring("mat_stock_1a"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df")
			}
		}
	}
	self.weapon_skins.uzi_burn.types = {
		sight = {
			uv_offset_rot = Vector3(0.001, 0, 0),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_013_b_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_022_df"),
			uv_offset_rot = Vector3(-0.101736, 0.997791, 1.56293),
			pattern_tweak = Vector3(1.73146, 0, 0),
			pattern_pos = Vector3(0.759838, 1.67565, 0),
			uv_scale = Vector3(4.69342, 5.03015, 0.449082),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_004_df")
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_019_df"),
			pattern_tweak = Vector3(1.72576, 0.028, 1),
			pattern_pos = Vector3(1.14297, 1.07827, 0),
			uv_scale = Vector3(4.07665, 3.38253, 1),
			uv_offset_rot = Vector3(0.145757, 0.787537, 1.5819),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_001_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_001_df"),
			uv_offset_rot = Vector3(0.425948, 0.926013, 3.12136),
			uv_scale = Vector3(0.089654, 3.55223, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_007_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df")
		},
		vertical_grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_010_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_004_df"),
			pattern_pos = Vector3(1.06511, -0.413546, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			pattern_tweak = Vector3(0.300503, 0.139361, 1)
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_008_df"),
			pattern_tweak = Vector3(1.06368, 4.72475, 1),
			pattern_pos = Vector3(1.71835, -0.62342, 0),
			uv_scale = Vector3(0.739425, 0.977799, 1),
			uv_offset_rot = Vector3(-0.480324, 1.06511, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_005_df")
		},
		grip = {
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_017_df"),
			uv_scale = Vector3(1.02547, 2.21734, 0),
			uv_offset_rot = Vector3(-0.213133, 0.891854, 0.012)
		}
	}
	self.weapon_skins.glock_17_burn = {}
	self.weapon_skins.glock_17_burn.name_id = "bm_wskn_glock_17_burn"
	self.weapon_skins.glock_17_burn.desc_id = "bm_wskn_glock_17_burn_desc"
	self.weapon_skins.glock_17_burn.weapon_id = "glock_17"
	self.weapon_skins.glock_17_burn.rarity = "epic"
	self.weapon_skins.glock_17_burn.bonus = "spread_p1"
	self.weapon_skins.glock_17_burn.reserve_quality = true
	self.weapon_skins.glock_17_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.glock_17_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_014_df")
	self.weapon_skins.glock_17_burn.default_blueprint = {
		"wpn_fps_pis_g17_body_standard",
		"wpn_fps_pis_g17_b_standard",
		"wpn_fps_pis_g17_m_standard",
		"wpn_fps_pis_g26_g_laser",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_upg_ns_pis_ipsccomp"
	}
	self.weapon_skins.glock_17_burn.parts = {
		wpn_fps_pis_g26_g_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_df"),
				uv_offset_rot = Vector3(-0.394467, 1.00787, 4.72475),
				uv_scale = Vector3(0.501052, 0.739425, 0),
				pattern_pos = Vector3(0.464107, 0.35917, 0),
				pattern_tweak = Vector3(0.634393, 0, 1),
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df")
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				uv_offset_rot = Vector3(-0.0740372, 1.01949, 1.56195),
				uv_scale = Vector3(1.74059, 1.74059, 1)
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				uv_offset_rot = Vector3(0.0348201, 1.03695, 1.66782),
				uv_scale = Vector3(1.50222, 1.69292, 1)
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				uv_offset_rot = Vector3(0.0806774, 1.02695, 1.5929),
				uv_scale = Vector3(1.69292, 1.54989, 1)
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				uv_offset_rot = Vector3(-0.200673, 1.05557, 1.62287),
				uv_scale = Vector3(1.07315, 0.882449, 1)
			}
		},
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(0.00620103, 1.00325, 1.57791),
				uv_scale = Vector3(1.26385, 1.88362, 1)
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(0.0348201, 1.00141, 1.53296),
				uv_scale = Vector3(1.26385, 1.26385, 1)
			}
		}
	}
	self.weapon_skins.glock_17_burn.types = {
		slide = {
			pattern_tweak = Vector3(0.72979, 3.06142, 1),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_021_df"),
			uv_scale = Vector3(1.13982, 1.43454, 0),
			pattern_pos = Vector3(0.187455, -0.089196, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_003_df"),
			uv_offset_rot = Vector3(-0.0661165, 1.21313, 1.57791),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df")
		},
		barrel_ext = {
			pattern_tweak = Vector3(1.49297, 1.60788, 1),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_013_df"),
			uv_scale = Vector3(1.40687, 1.1685, 0),
			pattern_pos = Vector3(0.588123, -0.566182, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_001_df"),
			uv_offset_rot = Vector3(0.0658201, 0.991331, 1.57791),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_009_df")
		},
		magazine = {
			pattern_tweak = Vector3(6.73981, 1.57791, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			uv_offset_rot = Vector3(-0.29645, 0.729679, 0.0414209),
			uv_scale = Vector3(7.50923, 7.9383, 1),
			pattern_pos = Vector3(0, 0.177916, 0),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_c_df"),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_015_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_003_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_df"),
			uv_offset_rot = Vector3(0, 0.68352, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_002_df"),
			uv_scale = Vector3(0.644076, 0.977799, 1)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_014_df"),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_020_df"),
			uv_scale = Vector3(7.22318, 3.74293, 0.198665),
			pattern_pos = Vector3(0.235154, -0.518483, 0),
			pattern_tweak = Vector3(3.544, 2.22227, 0),
			uv_offset_rot = Vector3(-0.384927, 0.861235, 5.89358),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df")
		}
	}
	self.weapon_skins.scorpion_burn = {}
	self.weapon_skins.scorpion_burn.name_id = "bm_wskn_scorpion_burn"
	self.weapon_skins.scorpion_burn.desc_id = "bm_wskn_scorpion_burn_desc"
	self.weapon_skins.scorpion_burn.weapon_id = "scorpion"
	self.weapon_skins.scorpion_burn.rarity = "epic"
	self.weapon_skins.scorpion_burn.bonus = "spread_p1"
	self.weapon_skins.scorpion_burn.reserve_quality = true
	self.weapon_skins.scorpion_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.scorpion_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_df")
	self.weapon_skins.scorpion_burn.default_blueprint = {
		"wpn_fps_smg_scorpion_body_standard",
		"wpn_fps_smg_scorpion_b_standard",
		"wpn_fps_smg_scorpion_g_wood",
		"wpn_fps_smg_scorpion_s_standard",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_smg_scorpion_m_extended"
	}
	self.weapon_skins.scorpion_burn.parts = {
		wpn_fps_smg_scorpion_s_standard = {
			[Idstring("mtr_stock"):key()] = {
				pattern_tweak = Vector3(0.321202, 1.49497, 1),
				uv_scale = Vector3(1, 1, 0),
				pattern_pos = Vector3(0.235154, 1.03187, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_001_df"),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_002_df")
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				pattern_tweak = Vector3(1.15908, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_007_df"),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_004_df")
			}
		}
	}
	self.weapon_skins.scorpion_burn.types = {
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_d_df"),
			pattern_tweak = Vector3(0.300503, 0, 1)
		},
		magazine = {
			pattern_tweak = Vector3(2.49464, 1.57893, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df"),
			uv_offset_rot = Vector3(0.0274394, 0.898394, 1.60788),
			uv_scale = Vector3(3.40921, 2.78944, 1),
			pattern_pos = Vector3(-0.642499, 0.988791, 0),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_015_b_df"),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_009_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_df")
		},
		grip = {
			pattern_tweak = Vector3(0.634393, 2.3871, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_003_df"),
			uv_scale = Vector3(2.26502, 2.12199, 0.263058),
			pattern_pos = Vector3(0.314011, 0.267694, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df"),
			uv_offset_rot = Vector3(0.0348201, 1.21774, 3.07641),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_004_df")
		},
		upper_reciever = {
			pattern_tweak = Vector3(1.30217, 3.13635, 1),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_018_df"),
			uv_scale = Vector3(5.17317, 5.17317, 0),
			pattern_pos = Vector3(0.721679, 1.11696, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_001_df"),
			uv_offset_rot = Vector3(-0.252831, 0.930013, 0.22927),
			pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_018_df")
		}
	}
	self.weapon_skins.judge_burn = {}
	self.weapon_skins.judge_burn.name_id = "bm_wskn_judge_burn"
	self.weapon_skins.judge_burn.desc_id = "bm_wskn_judge_burn_desc"
	self.weapon_skins.judge_burn.weapon_id = "judge"
	self.weapon_skins.judge_burn.rarity = "legendary"
	self.weapon_skins.judge_burn.bonus = "spread_n1"
	self.weapon_skins.judge_burn.reserve_quality = true
	self.weapon_skins.judge_burn.texture_bundle_folder = "cash/safes/burn"
	self.weapon_skins.judge_burn.unique_name_id = "bm_wskn_judge_burn"
	self.weapon_skins.judge_burn.locked = true
	self.weapon_skins.judge_burn.base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_016_df")
	self.weapon_skins.judge_burn.default_blueprint = {
		"wpn_fps_pis_judge_body_standard",
		"wpn_fps_pis_judge_b_legend",
		"wpn_fps_pis_judge_g_legend",
		"wpn_fps_upg_a_custom"
	}
	self.weapon_skins.judge_burn.parts = {
		wpn_fps_pis_judge_g_legend = {
			[Idstring("mtr_grip_legendary"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_025_df"),
				uv_scale = Vector3(2.16967, 2.40804, 0.310756),
				uv_offset_rot = Vector3(-0.195752, 1.00125, 4.7108)
			}
		},
		wpn_fps_pis_judge_b_legend = {
			[Idstring("mtr_b_legendary"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_016_c_df"),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_001_df"),
				uv_offset_rot = Vector3(0.184455, 1.00579, 6.28319),
				pattern_pos = Vector3(0, 0.130217, 0),
				uv_scale = Vector3(2.40804, 2.50439, 1),
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_024_df"),
				pattern_tweak = Vector3(10.6034, 0.798698, 1)
			}
		},
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_buckshot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/surf/base_gradient/base_surf_003_df")
			},
			[Idstring("mtr_mech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_016_b_df")
			},
			[Idstring("mtr_cylinder"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_020_df"),
				pattern_pos = Vector3(0, 0.626822, 0),
				uv_scale = Vector3(1, 0.01, 1),
				pattern_tweak = Vector3(1.34987, 4.71775, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_006_df")
			},
			[Idstring("mtr_frame"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_026_df"),
				uv_offset_rot = Vector3(-0.0329577, 0.881854, 1.57491),
				uv_scale = Vector3(1.69292, 1.88362, 1),
				pattern_tweak = Vector3(0.920584, 0, 1)
			}
		}
	}
	self.weapon_skins.wa2000_buck = {}
	self.weapon_skins.wa2000_buck.name_id = "bm_wskn_wa2000_buck"
	self.weapon_skins.wa2000_buck.desc_id = "bm_wskn_wa2000_buck_desc"
	self.weapon_skins.wa2000_buck.weapon_id = "wa2000"
	self.weapon_skins.wa2000_buck.rarity = "common"
	self.weapon_skins.wa2000_buck.bonus = "recoil_p1"
	self.weapon_skins.wa2000_buck.reserve_quality = true
	self.weapon_skins.wa2000_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.wa2000_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
	self.weapon_skins.wa2000_buck.parts = {
		wpn_fps_snp_wa2000_g_walnut = {
			[Idstring("mtr_grip_walnut"):key()] = {
				pattern_pos = Vector3(-0.026418, 0.0920584, 0),
				pattern_tweak = Vector3(2.06535, 0, 1)
			}
		},
		wpn_fps_snp_wa2000_g_stealth = {
			[Idstring("mtr_grip_stealth"):key()] = {
				pattern_pos = Vector3(-0.0414975, 0.00620103, 0),
				pattern_tweak = Vector3(1.96995, 0, 1)
			}
		},
		wpn_fps_snp_wa2000_g_light = {
			[Idstring("mtr_grip_light"):key()] = {
				pattern_pos = Vector3(-0.28899, 0.338631, 0),
				pattern_tweak = Vector3(1.25447, 0, 1)
			}
		}
	}
	self.weapon_skins.wa2000_buck.types = {
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_b_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_003_df")
		},
		grip = {
			pattern_pos = Vector3(-0.0260372, 0.196217, 0),
			pattern_tweak = Vector3(2.25614, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_001_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_005_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df")
		}
	}
	self.weapon_skins.akmsu_buck = {}
	self.weapon_skins.akmsu_buck.name_id = "bm_wskn_akmsu_buck"
	self.weapon_skins.akmsu_buck.desc_id = "bm_wskn_akmsu_buck_desc"
	self.weapon_skins.akmsu_buck.weapon_id = "akmsu"
	self.weapon_skins.akmsu_buck.rarity = "common"
	self.weapon_skins.akmsu_buck.bonus = "spread_p1"
	self.weapon_skins.akmsu_buck.reserve_quality = true
	self.weapon_skins.akmsu_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.akmsu_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
	self.weapon_skins.akmsu_buck.parts = {
		wpn_fps_smg_akmsu_fg_rail = {
			[Idstring("akmsu_rail"):key()] = {
				pattern_pos = Vector3(-0.184593, 0.196995, 0),
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_004_df"),
				pattern_tweak = Vector3(1.30217, 0, 1)
			}
		},
		wpn_fps_upg_ak_fg_zenit = {
			[Idstring("mtr_zenit"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df"),
				pattern_pos = Vector3(-0.232292, 0.0538995, 0),
				pattern_tweak = Vector3(1.39757, 0, 1)
			}
		}
	}
	self.weapon_skins.akmsu_buck.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df")
		},
		foregrip = {
			pattern_pos = Vector3(0.920553, 1.68627, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_001_df"),
			pattern_tweak = Vector3(1.04798, 6.28319, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_005_df")
		}
	}
	self.weapon_skins.x_1911_buck = {}
	self.weapon_skins.x_1911_buck.name_id = "bm_wskn_x_1911_buck"
	self.weapon_skins.x_1911_buck.desc_id = "bm_wskn_x_1911_buck_desc"
	self.weapon_skins.x_1911_buck.weapon_id = "x_1911"
	self.weapon_skins.x_1911_buck.rarity = "common"
	self.weapon_skins.x_1911_buck.bonus = "spread_p1"
	self.weapon_skins.x_1911_buck.reserve_quality = true
	self.weapon_skins.x_1911_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.x_1911_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df")
	self.weapon_skins.x_1911_buck.parts = {
		wpn_fps_upg_fl_pis_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_fl_pis_tlr1 = {
			[Idstring("tlr1"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_fl_pis_x400v = {
			[Idstring("mtr_x400v"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_pis_1911_b_vented = {
			[Idstring("slide_vented"):key()] = {
				pattern_pos = Vector3(-0.222752, 0.492726, 0),
				pattern_tweak = Vector3(1.01598, 0, 1)
			}
		}
	}
	self.weapon_skins.x_1911_buck.types = {
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_010_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_003_df"),
			pattern_pos = Vector3(0.483186, 0.578583, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_002_df"),
			pattern_tweak = Vector3(1.39757, 0, 1)
		}
	}
	self.weapon_skins.rpk_buck = {}
	self.weapon_skins.rpk_buck.name_id = "bm_wskn_rpk_buck"
	self.weapon_skins.rpk_buck.desc_id = "bm_wskn_rpk_buck_desc"
	self.weapon_skins.rpk_buck.weapon_id = "rpk"
	self.weapon_skins.rpk_buck.rarity = "common"
	self.weapon_skins.rpk_buck.bonus = "recoil_p1"
	self.weapon_skins.rpk_buck.reserve_quality = true
	self.weapon_skins.rpk_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.rpk_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
	self.weapon_skins.rpk_buck.parts = {
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				pattern_pos = Vector3(-0.880992, 0.712139, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				pattern_tweak = Vector3(0, 4.70977, 1)
			}
		},
		wpn_upg_ak_s_folding = {
			[Idstring("folding"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_ak_g_rk3 = {
			[Idstring("mtr_rk3"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				pattern_pos = Vector3(-0.00333858, -0.0133386, 0),
				pattern_tweak = Vector3(1, 1.57791, 1)
			}
		},
		wpn_fps_lmg_rpk_fg_wood = {
			[Idstring("handguard_upper_wood"):key()] = {
				pattern_pos = Vector3(1.03495, -1.30574, 0),
				pattern_tweak = Vector3(0.924584, 1.58093, 1)
			}
		},
		wpn_fps_lmg_rpk_fg_standard = {
			[Idstring("mtr_rpk_handguard_waffle"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
				pattern_pos = Vector3(0.0951378, 0.578583, 0),
				pattern_tweak = Vector3(1.25447, 1.56293, 1)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				pattern_pos = Vector3(-0.194133, -1.15764, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_vg_ass_smg_verticalgrip = {
			[Idstring("mtr_vertical_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_ak_s_solidstock = {
			[Idstring("mtr_solid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		}
	}
	self.weapon_skins.rpk_buck.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
			pattern_tweak = Vector3(1.73146, 1.53296, 1),
			pattern_pos = Vector3(0.101598, -1.75864, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_bones_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_004_df"),
			pattern_pos = Vector3(0.0311216, -0.108275, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_001_df"),
			pattern_tweak = Vector3(1.06129, 1.54999, 1)
		},
		upper_reciever = {
			pattern_pos = Vector3(-0.222752, 0.282853, 0),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df"),
			pattern_tweak = Vector3(0.920584, 3.15133, 1)
		},
		foregrip = {
			pattern_pos = Vector3(1.24636, 0.503346, 0),
			pattern_tweak = Vector3(1.39657, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_004_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_001_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_b_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_005_df")
		}
	}
	self.weapon_skins.x_b92fs_buck = {}
	self.weapon_skins.x_b92fs_buck.name_id = "bm_wskn_x_b92fs_buck"
	self.weapon_skins.x_b92fs_buck.desc_id = "bm_wskn_x_b92fs_buck_desc"
	self.weapon_skins.x_b92fs_buck.weapon_id = "x_b92fs"
	self.weapon_skins.x_b92fs_buck.rarity = "common"
	self.weapon_skins.x_b92fs_buck.bonus = "recoil_p1"
	self.weapon_skins.x_b92fs_buck.reserve_quality = true
	self.weapon_skins.x_b92fs_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.x_b92fs_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df")
	self.weapon_skins.x_b92fs_buck.pattern_tweak = Vector3(1.87455, 0, 1)
	self.weapon_skins.x_b92fs_buck.parts = {
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		},
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
			}
		},
		wpn_fps_pis_beretta_sl_std = {
			[Idstring("std_slide"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_pis_beretta_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_c_df"),
				pattern_pos = Vector3(0.196995, 0.391329, 0),
				pattern_tweak = Vector3(2.54233, 0.109391, 1)
			}
		},
		wpn_fps_pis_beretta_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_c_df"),
				pattern_pos = Vector3(0, 0.301932, 0)
			}
		}
	}
	self.weapon_skins.x_b92fs_buck.types = {
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_002_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_003_df"),
			pattern_pos = Vector3(1.17058, 0.292392, 0),
			pattern_tweak = Vector3(2.63573, 6.22325, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_002_df")
		}
	}
	self.weapon_skins.ksg_buck = {}
	self.weapon_skins.ksg_buck.name_id = "bm_wskn_ksg_buck"
	self.weapon_skins.ksg_buck.desc_id = "bm_wskn_ksg_buck_desc"
	self.weapon_skins.ksg_buck.weapon_id = "ksg"
	self.weapon_skins.ksg_buck.rarity = "common"
	self.weapon_skins.ksg_buck.bonus = "spread_n1"
	self.weapon_skins.ksg_buck.reserve_quality = true
	self.weapon_skins.ksg_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.ksg_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
	self.weapon_skins.ksg_buck.parts = {
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		},
		wpn_fps_upg_o_mbus_rear = {
			[Idstring("mtr_mbus"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df")
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		}
	}
	self.weapon_skins.ksg_buck.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_b_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_003_df"),
			pattern_pos = Vector3(-0.118275, 1.02303, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_prisonsuit_df"),
			pattern_tweak = Vector3(1.01598, 0, 1)
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
		}
	}
	self.weapon_skins.m249_buck = {}
	self.weapon_skins.m249_buck.name_id = "bm_wskn_m249_buck"
	self.weapon_skins.m249_buck.desc_id = "bm_wskn_m249_buck_desc"
	self.weapon_skins.m249_buck.weapon_id = "m249"
	self.weapon_skins.m249_buck.rarity = "uncommon"
	self.weapon_skins.m249_buck.bonus = "recoil_p1"
	self.weapon_skins.m249_buck.reserve_quality = true
	self.weapon_skins.m249_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.m249_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
	self.weapon_skins.m249_buck.parts = {
		wpn_fps_lmg_m249_s_modern = {
			[Idstring("mtr_modern"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df")
			}
		},
		wpn_fps_lmg_m249_s_para = {
			[Idstring("mtr_sling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_tactical_002_df")
			},
			[Idstring("mtr_para"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_010_df")
			}
		},
		wpn_fps_lmg_m249_s_solid = {
			[Idstring("mtr_solid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df"),
				pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_010_df"),
				pattern_pos = Vector3(-0.00333858, 0.216075, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_012_df")
			}
		},
		wpn_fps_lmg_m249_upper_reciever = {
			[Idstring("mtr_dustcover"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_009_df"),
				uv_offset_rot = Vector3(-0.24315, 0.807076, 0),
				uv_scale = Vector3(3.59991, 3.88595, 0.103267),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		},
		wpn_fps_lmg_m249_m_standard = {
			[Idstring("mtr_lid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_2c_df")
			},
			[Idstring("mtr_mag"):key()] = {
				uv_scale = Vector3(4.31503, 4.83945, 1),
				uv_offset_rot = Vector3(-0.0575769, 0.883854, 0)
			}
		},
		wpn_fps_lmg_m249_fg_mk46 = {
			[Idstring("mtr_mk46"):key()] = {
				pattern_pos = Vector3(-1.11948, 0.549964, 0),
				pattern_tweak = Vector3(1.58836, 0, 1)
			}
		},
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_016_df")
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_010_df")
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_df"),
				pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_010_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_011_df")
			}
		}
	}
	self.weapon_skins.m249_buck.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_2b_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_010_df"),
			pattern_pos = Vector3(0.869315, 1.08419, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_012_df"),
			pattern_tweak = Vector3(4.06869, 6.28319, 1)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_016_df"),
			uv_scale = Vector3(1, 1, 0),
			cubemap_pattern_control = Vector3(1, 0.237823, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_006_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_016_df"),
			uv_offset_rot = Vector3(-0.0605769, 0.997409, 1.62287),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_012_df"),
			pattern_pos = Vector3(0.240694, -0.203514, 0),
			uv_scale = Vector3(9.13017, 7.31853, 0),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_010_df"),
			pattern_tweak = Vector3(1.38457, 0, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_016_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_005_df"),
			pattern_tweak = Vector3(1.01598, 0, 1),
			pattern_pos = Vector3(0, 0.206535, 0),
			uv_scale = Vector3(3.12316, 4.41038, 0),
			uv_offset_rot = Vector3(-0.0615769, 0.874315, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_002_df")
		}
	}
	self.weapon_skins.g22c_buck = {}
	self.weapon_skins.g22c_buck.name_id = "bm_wskn_g22c_buck"
	self.weapon_skins.g22c_buck.desc_id = "bm_wskn_g22c_buck_desc"
	self.weapon_skins.g22c_buck.weapon_id = "g22c"
	self.weapon_skins.g22c_buck.rarity = "uncommon"
	self.weapon_skins.g22c_buck.bonus = "spread_p1"
	self.weapon_skins.g22c_buck.reserve_quality = true
	self.weapon_skins.g22c_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.g22c_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_df")
	self.weapon_skins.g22c_buck.parts = {
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		},
		wpn_fps_pis_g22c_b_long = {
			[Idstring("mtr_g35"):key()] = {
				pattern_pos = Vector3(-0.0671165, 0.088598, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_b_df")
			}
		},
		wpn_fps_pis_g22c_b_standard = {
			[Idstring("mtr_sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_007_df"),
				pattern_pos = Vector3(-0.251371, 0.0348201, 0),
				pattern_tweak = Vector3(0, 0, 1)
			},
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_df")
			}
		},
		wpn_fps_pis_g18c_co_comp_2 = {
			[Idstring("mtr_comp_2"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		}
	}
	self.weapon_skins.g22c_buck.types = {
		slide = {
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_006_df"),
			pattern_pos = Vector3(0.576123, 0.845695, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_003_df"),
			cubemap_pattern_control = Vector3(0, 1, 0),
			pattern_tweak = Vector3(1.32387, 0, 1)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_014_df"),
			uv_offset_rot = Vector3(-0.172514, 0.893775, 0.049451),
			pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_007_df"),
			pattern_pos = Vector3(0.929553, -0.207212, 0),
			uv_scale = Vector3(10.5127, 10.036, 0),
			cubemap_pattern_control = Vector3(0.446697, 0.456237, 0),
			pattern_tweak = Vector3(1.39757, 0, 1)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
		}
	}
	self.weapon_skins.saw_buck = {}
	self.weapon_skins.saw_buck.name_id = "bm_wskn_saw_buck"
	self.weapon_skins.saw_buck.desc_id = "bm_wskn_saw_buck_desc"
	self.weapon_skins.saw_buck.weapon_id = "saw"
	self.weapon_skins.saw_buck.weapon_ids = {
		"saw",
		"saw_secondary"
	}
	self.weapon_skins.saw_buck.rarity = "uncommon"
	self.weapon_skins.saw_buck.bonus = "concealment_p1"
	self.weapon_skins.saw_buck.reserve_quality = true
	self.weapon_skins.saw_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.saw_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_010_df")
	self.weapon_skins.saw_buck.parts = {
		wpn_fps_saw_b_normal = {
			[Idstring("mtr_protection"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_010_df"),
				uv_scale = Vector3(2.21734, 2.26502, 1),
				uv_offset_rot = Vector3(-0.232292, 1.2559, 0)
			}
		}
	}
	self.weapon_skins.saw_buck.types = {
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_013_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_001_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_005_df"),
			pattern_pos = Vector3(0.301932, -0.29907, 0),
			uv_scale = Vector3(10.322, 8.98715, 0.17243),
			uv_offset_rot = Vector3(-0.362768, 0.995331, 4.68982),
			pattern_tweak = Vector3(2.63773, 0, 1)
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_010_df"),
			uv_offset_rot = Vector3(-0.245292, 1.00379, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_003_df"),
			pattern_pos = Vector3(0, 0.0343599, 0),
			uv_scale = Vector3(2.74176, 2.74176, 0),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_005_df"),
			pattern_tweak = Vector3(1.44527, 0, 1)
		}
	}
	self.weapon_skins.winchester1874_buck = {}
	self.weapon_skins.winchester1874_buck.name_id = "bm_wskn_winchester1874_buck"
	self.weapon_skins.winchester1874_buck.desc_id = "bm_wskn_winchester1874_buck_desc"
	self.weapon_skins.winchester1874_buck.weapon_id = "winchester1874"
	self.weapon_skins.winchester1874_buck.rarity = "uncommon"
	self.weapon_skins.winchester1874_buck.bonus = "recoil_p1"
	self.weapon_skins.winchester1874_buck.reserve_quality = true
	self.weapon_skins.winchester1874_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.winchester1874_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df")
	self.weapon_skins.winchester1874_buck.pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_004_df")
	self.weapon_skins.winchester1874_buck.pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_007_df")
	self.weapon_skins.winchester1874_buck.pattern_tweak = Vector3(1.25447, 0, 0)
	self.weapon_skins.winchester1874_buck.pattern_pos = Vector3(-0.0987357, 0.36871, 0)
	self.weapon_skins.winchester1874_buck.cubemap_pattern_control = Vector3(1, 0, 0)
	self.weapon_skins.winchester1874_buck.parts = {
		wpn_fps_snp_winchester_b_suppressed = {
			[Idstring("mtr_supp"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df"),
				uv_scale = Vector3(20, 20, 1),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_winchester_o_classic = {
			[Idstring("mtr_scope"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df"),
				pattern_pos = Vector3(-1.08133, -1.15764, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_004_df"),
				pattern_tweak = Vector3(0.300503, 0, 1)
			}
		}
	}
	self.weapon_skins.winchester1874_buck.types = {
		barrel = {
			pattern_pos = Vector3(0.855235, 0.216075, 0),
			uv_scale = Vector3(9.79962, 0.01, 0),
			uv_offset_rot = Vector3(0.177916, 2, 0),
			pattern_tweak = Vector3(2.11305, 0, 1)
		},
		stock = {
			uv_scale = Vector3(8.7011, 8.7011, 1),
			uv_offset_rot = Vector3(0.264773, 0.922013, 0.963532),
			pattern_tweak = Vector3(1.20678, 0, 1)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_013_df"),
			uv_scale = Vector3(7.79528, 9.13017, 0.0317196),
			uv_offset_rot = Vector3(-0.29707, 0.870854, 0),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_b_df")
		}
	}
	self.weapon_skins.m45_buck = {}
	self.weapon_skins.m45_buck.name_id = "bm_wskn_m45_buck"
	self.weapon_skins.m45_buck.desc_id = "bm_wskn_m45_buck_desc"
	self.weapon_skins.m45_buck.weapon_id = "m45"
	self.weapon_skins.m45_buck.rarity = "rare"
	self.weapon_skins.m45_buck.bonus = "spread_p1"
	self.weapon_skins.m45_buck.reserve_quality = true
	self.weapon_skins.m45_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.m45_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_011_df")
	self.weapon_skins.m45_buck.default_blueprint = {
		"wpn_fps_smg_m45_s_standard",
		"wpn_fps_smg_m45_b_green",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_smg_m45_g_ergo",
		"wpn_fps_smg_m45_m_extended",
		"wpn_fps_upg_o_reflex",
		"wpn_fps_smg_m45_body_green"
	}
	self.weapon_skins.m45_buck.parts = {
		wpn_fps_smg_m45_g_bling = {
			[Idstring("m45_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df")
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_smg_m45_m_mag = {
			[Idstring("m45_mag"):key()] = {
				uv_scale = Vector3(2.64641, 0.0243047, 1),
				uv_offset_rot = Vector3(-0.225292, 0.982331, 4.71278)
			}
		},
		wpn_fps_upg_ass_ns_battle = {
			[Idstring("mtr_battle"):key()] = {
				uv_scale = Vector3(0.7871, 0.01, 1),
				uv_offset_rot = Vector3(0, 2, 0)
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_medium = {
			[Idstring("medium"):key()] = {
				uv_scale = Vector3(1.31152, 0.01, 1),
				uv_offset_rot = Vector3(-0.318149, 0.196995, 4.75472)
			}
		},
		wpn_fps_upg_ns_ass_smg_small = {
			[Idstring("small"):key()] = {
				uv_offset_rot = Vector3(0, -2, 0)
			}
		},
		wpn_fps_smg_m45_g_standard = {
			[Idstring("m45_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				uv_scale = Vector3(1, 0.01, 1)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_large = {
			[Idstring("silencer_large"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_001_df"),
				uv_scale = Vector3(3.26618, 0.01, 0.108037),
				uv_offset_rot = Vector3(-0.417546, 0.996331, 4.70977)
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_001_df"),
				uv_scale = Vector3(1, 0.01, 0.18674),
				uv_offset_rot = Vector3(-2, 0.907394, 4.66481)
			}
		},
		wpn_fps_upg_ns_ass_smg_tank = {
			[Idstring("tank"):key()] = {
				uv_scale = Vector3(1, 0.01, 1)
			}
		}
	}
	self.weapon_skins.m45_buck.types = {
		barrel = {
			pattern_pos = Vector3(0.0634394, 0.0825188, 0),
			pattern_tweak = Vector3(1, 1.56293, 1),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_009_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_011_b_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df"),
			pattern_tweak = Vector3(1.05868, 1.54794, 1),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_011_df"),
			uv_offset_rot = Vector3(-0.027418, 0.940172, 0),
			pattern_pos = Vector3(0.155836, 0.0443599, 0),
			uv_scale = Vector3(2.21734, 6.60341, 0.0579538),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_007_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_009_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_011_b_df")
		},
		magazine = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_001_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_011_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_009_df"),
			pattern_pos = Vector3(0.206535, 0.922013, 0),
			uv_scale = Vector3(2.98014, 3.02781, 0.0913428),
			uv_offset_rot = Vector3(-0.232371, 1.01541, 4.71378),
			pattern_tweak = Vector3(1.15908, 4.71174, 1)
		},
		barrel_ext = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_001_df"),
			uv_scale = Vector3(1, 1, 0.160506),
			uv_offset_rot = Vector3(-0.023418, 1.06719, 4.70977),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_011_b_df")
		}
	}
	self.weapon_skins.saiga_buck = {}
	self.weapon_skins.saiga_buck.name_id = "bm_wskn_saiga_buck"
	self.weapon_skins.saiga_buck.desc_id = "bm_wskn_saiga_buck_desc"
	self.weapon_skins.saiga_buck.weapon_id = "saiga"
	self.weapon_skins.saiga_buck.rarity = "rare"
	self.weapon_skins.saiga_buck.bonus = "spread_n1"
	self.weapon_skins.saiga_buck.reserve_quality = true
	self.weapon_skins.saiga_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.saiga_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
	self.weapon_skins.saiga_buck.default_blueprint = {
		"wpn_fps_smg_akmsu_body_lowerreceiver",
		"wpn_fps_ass_akm_body_upperreceiver_vanilla",
		"wpn_fps_shot_saiga_b_standard",
		"wpn_fps_shot_saiga_m_5rnd",
		"wpn_fps_upg_a_custom_free",
		"wpn_fps_upg_o_ak_scopemount",
		"wpn_upg_saiga_fg_lowerrail",
		"wpn_fps_upg_ak_g_wgrip",
		"wpn_fps_upg_o_eotech",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_ns_shot_shark"
	}
	self.weapon_skins.saiga_buck.parts = {
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_001_df"),
				uv_offset_rot = Vector3(-2, -2, 1.69779)
			}
		},
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				uv_offset_rot = Vector3(-0.0605769, 2, 0),
				uv_scale = Vector3(6.50806, 7.12783, 1)
			}
		},
		wpn_fps_upg_ak_g_hgrip = {
			[Idstring("mtr_ergoak"):key()] = {
				uv_scale = Vector3(0.834774, 0.358028, 1)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_dinner_003_df"),
				uv_offset_rot = Vector3(0.192456, 0.857235, 0),
				uv_scale = Vector3(16.1383, 18.1407, 0)
			}
		},
		wpn_upg_ak_s_folding_vanilla = {
			[Idstring("folding"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_df"),
				uv_offset_rot = Vector3(2, 0.855235, 0),
				uv_scale = Vector3(1.64524, 0.69175, 1)
			}
		},
		wpn_fps_upg_ak_g_rk3 = {
			[Idstring("mtr_rk3"):key()] = {
				uv_scale = Vector3(0.548726, 0.363703, 0.0889579)
			}
		},
		wpn_upg_saiga_fg_lowerrail_short = {
			[Idstring("lower_rail_short"):key()] = {
				uv_offset_rot = Vector3(0.454567, 1.14143, 4.70977),
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_004_df"),
				uv_scale = Vector3(1.40687, 0.644076, 0)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				uv_offset_rot = Vector3(0.082979, 0.543504, 0),
				uv_scale = Vector3(8.74877, 12.8011, 0.100883)
			}
		},
		wpn_upg_ak_s_skfoldable = {
			[Idstring("sk_foldable"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df"),
				uv_offset_rot = Vector3(0, 0.902934, 0),
				uv_scale = Vector3(9.74994, 11.2279, 0.0269498)
			}
		},
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df"),
				uv_offset_rot = Vector3(2, 2, 4.6798)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				uv_offset_rot = Vector3(0.454567, 1.01787, 4.6968),
				uv_scale = Vector3(0.977799, 1.64524, 1)
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				uv_scale = Vector3(0.644076, 0.834774, 0.0603388)
			}
		},
		wpn_upg_saiga_fg_lowerrail = {
			[Idstring("lower_rail"):key()] = {
				uv_offset_rot = Vector3(0.187455, 1.06511, 4.70977),
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_004_df"),
				uv_scale = Vector3(0.834774, 0.834774, 0)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				uv_offset_rot = Vector3(0.0458995, 0.850775, 0),
				uv_scale = Vector3(9.51157, 10.7988, 0.086573)
			}
		},
		wpn_fps_sho_saiga_fg_holy = {
			[Idstring("mtr_holy"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				uv_offset_rot = Vector3(-2, -2, 1.62287),
				uv_scale = Vector3(0.739425, 0.548726, 1),
				pattern_pos = Vector3(0, 0.003, 0)
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				uv_offset_rot = Vector3(-0.378467, 1.18766, 1.62287),
				uv_scale = Vector3(10.9418, 10.7034, 0)
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				uv_offset_rot = Vector3(0, 2, 0)
			}
		},
		wpn_upg_ak_s_psl = {
			[Idstring("psl"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_012_df"),
				uv_offset_rot = Vector3(2, 1.02087, 4.68881),
				uv_scale = Vector3(1.69292, 0.930124, 0.0412594)
			}
		},
		wpn_fps_upg_m4_s_standard = {
			[Idstring("stock_standard"):key()] = {
				uv_offset_rot = Vector3(0.36871, 1.00787, 4.70977),
				uv_scale = Vector3(0.977799, 1, 0.0889579)
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				uv_offset_rot = Vector3(0.0825188, 0.893394, 0)
			}
		},
		wpn_fps_upg_o_ak_scopemount = {
			[Idstring("mtr_kv04"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				uv_offset_rot = Vector3(0.158836, 0.769378, 0),
				uv_scale = Vector3(11.2279, 12.7534, 1)
			}
		},
		wpn_fps_sho_saiga_b_short = {
			[Idstring("mtr_short"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df")
			}
		},
		wpn_upg_ak_g_standard = {
			[Idstring("pistolgrip"):key()] = {
				pattern_pos = Vector3(0.001, 0, 0),
				uv_offset_rot = Vector3(-0.26661, 0.917013, 1.53296),
				uv_scale = Vector3(0.7871, 0.501052, 1)
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				uv_offset_rot = Vector3(0.120217, 0.865155, 6.27619),
				uv_scale = Vector3(4.79177, 5.17317, 0.053184)
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_011_df"),
				uv_offset_rot = Vector3(-0.0605769, 0.756758, 0)
			}
		},
		wpn_fps_upg_ak_g_pgrip = {
			[Idstring("mtr_akgrip"):key()] = {
				uv_scale = Vector3(0.358028, 0.372703, 0.0579538)
			}
		},
		wpn_upg_saiga_fg_standard = {
			[Idstring("saiga_handguard"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df"),
				uv_offset_rot = Vector3(-0.401467, 0.750298, 1.56293),
				uv_scale = Vector3(0.501052, 0.405702, 0.124732)
			}
		}
	}
	self.weapon_skins.saiga_buck.types = {
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_c_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_c_df"),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_006_df"),
			uv_offset_rot = Vector3(0.114757, 0.807537, 0),
			uv_scale = Vector3(7.03248, 7.08016, 0.0698785)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_b_df"),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_005_df"),
			uv_offset_rot = Vector3(0.340091, 1.01287, 4.7108),
			uv_scale = Vector3(1.63624, 1.2135, 0.18674)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_002_df"),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_004_df"),
			uv_offset_rot = Vector3(-0.210133, 0.884934, 1.53501),
			uv_scale = Vector3(0.644076, 0.358028, 0.146196)
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
			uv_offset_rot = Vector3(0.158836, 1.04449, 4.73974),
			uv_scale = Vector3(0.834774, 0.930124, 0.148581),
			pattern_pos = Vector3(-0.108275, 0.111138, 0),
			pattern_tweak = Vector3(1.15908, 3.13635, 1),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_004_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_008_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_014_df"),
			uv_offset_rot = Vector3(-0.127895, 0.979251, 1.56293),
			uv_scale = Vector3(1.54989, 1.88362, 0.0412594),
			pattern_pos = Vector3(-0.423086, 0, 0),
			pattern_tweak = Vector3(1.87455, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_008_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_b_df"),
			uv_offset_rot = Vector3(-0.470324, 0.949172, 1.5929),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_004_df"),
			uv_scale = Vector3(0.407702, 0.8788, 0.0507991)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_001_df"),
			uv_offset_rot = Vector3(0.292853, 1.11281, 6.22325),
			uv_scale = Vector3(0.453377, 0.7871, 0.0984976),
			pattern_pos = Vector3(0.321011, 0.0157406, 0),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_004_df"),
			pattern_tweak = Vector3(0.872886, 4.6798, 1)
		}
	}
	self.weapon_skins.p226_buck = {}
	self.weapon_skins.p226_buck.name_id = "bm_wskn_p226_buck"
	self.weapon_skins.p226_buck.desc_id = "bm_wskn_p226_buck_desc"
	self.weapon_skins.p226_buck.weapon_id = "p226"
	self.weapon_skins.p226_buck.rarity = "rare"
	self.weapon_skins.p226_buck.bonus = "spread_p1"
	self.weapon_skins.p226_buck.reserve_quality = true
	self.weapon_skins.p226_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.p226_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_013_df")
	self.weapon_skins.p226_buck.default_blueprint = {
		"wpn_fps_pis_p226_body_standard",
		"wpn_fps_pis_p226_b_long",
		"wpn_fps_pis_p226_m_extended",
		"wpn_fps_pis_p226_g_ergo",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_upg_ns_pis_ipsccomp"
	}
	self.weapon_skins.p226_buck.parts = {
		wpn_fps_pis_p226_g_standard = {
			[Idstring("mtr_g_standard"):key()] = {
				uv_scale = Vector3(4.64875, 4.60108, 0.086573),
				uv_offset_rot = Vector3(0.188455, 0.890934, 0.049451)
			}
		}
	}
	self.weapon_skins.p226_buck.types = {
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_005_df"),
			pattern_pos = Vector3(0, 0.177916, 0),
			pattern_tweak = Vector3(0.872886, 3.27121, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_005_df")
		},
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_013_b_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_005_df"),
			pattern_pos = Vector3(0.826616, -0.461245, 0),
			pattern_tweak = Vector3(1.73146, 3.40608, 1),
			cubemap_pattern_control = Vector3(0.222514, 0.580253, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_005_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_013_b_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_005_df"),
			pattern_pos = Vector3(0.040979, -0.354609, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_005_df"),
			pattern_tweak = Vector3(2.30384, 5.99847, 1)
		},
		grip = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_012_df"),
			uv_scale = Vector3(5.41155, 5.03015, 0.115192),
			uv_offset_rot = Vector3(0.0252805, 0.902934, 6.22325)
		}
	}
	self.weapon_skins.new_mp5_buck = {}
	self.weapon_skins.new_mp5_buck.name_id = "bm_wskn_new_mp5_buck"
	self.weapon_skins.new_mp5_buck.desc_id = "bm_wskn_new_mp5_buck_desc"
	self.weapon_skins.new_mp5_buck.weapon_id = "new_mp5"
	self.weapon_skins.new_mp5_buck.rarity = "epic"
	self.weapon_skins.new_mp5_buck.bonus = "spread_p1"
	self.weapon_skins.new_mp5_buck.reserve_quality = true
	self.weapon_skins.new_mp5_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.new_mp5_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df")
	self.weapon_skins.new_mp5_buck.default_blueprint = {
		"wpn_fps_smg_mp5_body_mp5",
		"wpn_fps_smg_mp5_s_solid",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_smg_mp5_fg_mp5a5",
		"wpn_fps_smg_mp5_m_straight",
		"wpn_fps_upg_o_cmore"
	}
	self.weapon_skins.new_mp5_buck.parts = {
		wpn_fps_smg_mp5_s_adjust = {
			[Idstring("adjust"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df"),
				uv_offset_rot = Vector3(2, 2, 1.66782)
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				pattern_pos = Vector3(0, -0.165514, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df")
			}
		},
		wpn_fps_smg_mp5_s_ring = {
			[Idstring("ring"):key()] = {
				uv_offset_rot = Vector3(0, 2, 0)
			}
		},
		wpn_fps_smg_mp5_s_folding = {
			[Idstring("mtr_folding"):key()] = {
				pattern_tweak = Vector3(1.73146, 1.57791, 1),
				uv_offset_rot = Vector3(-2, -2, 1.56293),
				uv_scale = Vector3(20, 20, 1),
				pattern_pos = Vector3(0, -0.365848, 0)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
				pattern_pos = Vector3(0.158836, -0.823833, 0)
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_pos = Vector3(-0.0987357, -0.0987357, 0)
			}
		},
		wpn_fps_smg_mp5_fg_flash = {
			[Idstring("mtr_surefire"):key()] = {
				pattern_tweak = Vector3(2.92392, 1.5929, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_010_df"),
				uv_offset_rot = Vector3(-2, -2, 0),
				uv_scale = Vector3(20, 20, 0),
				pattern_pos = Vector3(0, -0.241831, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df"),
				pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_011_df")
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_smg_mp5_fg_mp5a4 = {
			[Idstring("mp5a4"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
				uv_offset_rot = Vector3(0.0870584, 0.990331, 4.6798),
				uv_scale = Vector3(2.31269, 2.40804, 0.143811),
				pattern_pos = Vector3(0, 0.321011, 0),
				pattern_tweak = Vector3(1, 1.44305, 1),
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_015_df")
			}
		},
		wpn_fps_smg_mp5_fg_m5k = {
			[Idstring("mp5k"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_015_df"),
				uv_offset_rot = Vector3(-0.0471165, 0.980251, 4.71278),
				uv_scale = Vector3(3.44988, 1.26385, 0.732888)
			}
		},
		wpn_fps_smg_mp5_m_std = {
			[Idstring("mag_std"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0.364135)
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_smg_mp5_fg_mp5sd = {
			[Idstring("mtr_sd"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
				uv_offset_rot = Vector3(-0.256451, 1.02241, 4.72475),
				uv_scale = Vector3(2.45571, 2.21734, 0.141426),
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_001_df")
			}
		},
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		}
	}
	self.weapon_skins.new_mp5_buck.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df"),
			pattern_tweak = Vector3(1.06368, 1.57791, 1),
			uv_offset_rot = Vector3(-0.142895, 0.986791, 4.70878),
			uv_scale = Vector3(2.12199, 1.5589, 0.112807),
			pattern_pos = Vector3(0.282853, 0.349631, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_010_df"),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_015_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_011_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_008_df"),
			uv_scale = Vector3(1.64524, 1.64524, 0),
			pattern_pos = Vector3(0, 0.404329, 0),
			pattern_tweak = Vector3(0.634393, 0, 1),
			uv_offset_rot = Vector3(0.0930584, 1.00849, 0.0344661),
			pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_003_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df"),
			uv_offset_rot = Vector3(0.387789, 0.721679, 0),
			uv_scale = Vector3(1, 1, 0.0627237),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_010_df"),
			pattern_tweak = Vector3(0.920584, 1.60788, 1),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_011_df")
		},
		stock = {
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_010_df"),
			pattern_tweak = Vector3(0.634393, 1.51097, 1),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_016_df"),
			uv_scale = Vector3(1.12082, 1.07315, 0.236823),
			pattern_pos = Vector3(0.626282, 0.647601, 0),
			uv_offset_rot = Vector3(0.0417406, 1.00217, 4.70977),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_b_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_011_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_2b_df"),
			uv_offset_rot = Vector3(-0.00987842, 0.730679, 0),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_016_df"),
			uv_scale = Vector3(2.02664, 2.16967, 0)
		},
		barrel_ext = {
			pattern_pos = Vector3(-0.008, -0.699737, 0),
			pattern_tweak = Vector3(0.586694, 1.53296, 1),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_2b_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_010_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_2b_df")
		}
	}
	self.weapon_skins.m1928_buck = {}
	self.weapon_skins.m1928_buck.name_id = "bm_wskn_m1928_buck"
	self.weapon_skins.m1928_buck.desc_id = "bm_wskn_m1928_buck_desc"
	self.weapon_skins.m1928_buck.weapon_id = "m1928"
	self.weapon_skins.m1928_buck.rarity = "epic"
	self.weapon_skins.m1928_buck.bonus = "spread_p1"
	self.weapon_skins.m1928_buck.reserve_quality = true
	self.weapon_skins.m1928_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.m1928_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
	self.weapon_skins.m1928_buck.default_blueprint = {
		"wpn_fps_smg_thompson_body",
		"wpn_fps_smg_thompson_drummag",
		"wpn_fps_smg_thompson_foregrip",
		"wpn_fps_smg_thompson_grip",
		"wpn_fps_smg_thompson_stock",
		"wpn_fps_smg_thompson_barrel_long",
		"wpn_fps_upg_ass_ns_surefire"
	}
	self.weapon_skins.m1928_buck.parts = {
		wpn_fps_smg_thompson_stock_nostock = {
			[Idstring("mtr_nostock"):key()] = {
				pattern_pos = Vector3(0, 0.721679, 0),
				pattern_tweak = Vector3(0.348202, 0, 1)
			}
		}
	}
	self.weapon_skins.m1928_buck.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_c_df"),
			uv_scale = Vector3(2.64641, 0.01, 0),
			uv_offset_rot = Vector3(-0.318149, 0.6896, 0)
		},
		stock = {
			pattern_pos = Vector3(-0.00325937, 0.298392, 0),
			pattern_tweak = Vector3(1.01098, 1.53296, 1),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_008_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_011_df")
		},
		upper_reciever = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_013_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_011_df"),
			uv_offset_rot = Vector3(-0.151736, 1.00187, 1.54794),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_d_df"),
			pattern_pos = Vector3(0.590504, 1.55025, 0),
			uv_scale = Vector3(10.5127, 9.56324, 0.1772),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_012_df"),
			pattern_tweak = Vector3(1.41757, 0.007, 1)
		},
		foregrip = {
			pattern_pos = Vector3(0.522266, -0.756976, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_011_df"),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_008_df"),
			pattern_tweak = Vector3(1.20678, 1.47302, 1)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_2b_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_b_df")
		},
		grip = {
			pattern_pos = Vector3(0.530885, -0.356308, 0),
			pattern_tweak = Vector3(0.72979, 4.47001, 1),
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_008_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_011_df")
		}
	}
	self.weapon_skins.boot_buck = {}
	self.weapon_skins.boot_buck.name_id = "bm_wskn_boot_buck"
	self.weapon_skins.boot_buck.desc_id = "bm_wskn_boot_buck_desc"
	self.weapon_skins.boot_buck.weapon_id = "boot"
	self.weapon_skins.boot_buck.rarity = "legendary"
	self.weapon_skins.boot_buck.bonus = "spread_n1"
	self.weapon_skins.boot_buck.reserve_quality = true
	self.weapon_skins.boot_buck.texture_bundle_folder = "cash/safes/buck"
	self.weapon_skins.boot_buck.unique_name_id = "bm_wskn_boot_buck"
	self.weapon_skins.boot_buck.locked = true
	self.weapon_skins.boot_buck.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_016_df")
	self.weapon_skins.boot_buck.default_blueprint = {
		"wpn_fps_sho_boot_b_legendary",
		"wpn_fps_sho_boot_fg_legendary",
		"wpn_fps_sho_boot_o_legendary",
		"wpn_fps_sho_boot_s_legendary",
		"wpn_fps_sho_boot_body_standard",
		"wpn_fps_sho_boot_em_extra",
		"wpn_fps_sho_boot_m_standard",
		"wpn_fps_upg_a_custom_free"
	}
	self.weapon_skins.boot_buck.parts = {
		wpn_fps_sho_boot_fg_legendary = {
			[Idstring("mtr_fg_legend"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_018_df"),
				uv_offset_rot = Vector3(-0.013418, 0.889093, 6.28319),
				uv_scale = Vector3(2.24234, 4.59908, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_013_df")
			}
		},
		wpn_fps_sho_boot_body_standard = {
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_017_df"),
				uv_offset_rot = Vector3(0.027582, 0.99787, 6.28319),
				uv_scale = Vector3(2.83711, 2.83711, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			},
			[Idstring("mtr_mech"):key()] = {
				uv_scale = Vector3(4.7441, 6.60341, 1),
				uv_offset_rot = Vector3(0, 1.19866, 1.57791)
			}
		},
		wpn_fps_sho_boot_b_legendary = {
			[Idstring("mtr_b_legend"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_016_b_df"),
				uv_offset_rot = Vector3(0.35517, 0.950632, 1.56293),
				pattern_pos = Vector3(0.645361, 0.473647, 0),
				uv_scale = Vector3(3.9813, 0.01, 1),
				pattern_tweak = Vector3(15.1347, 0.0794209, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_013_df")
			},
			[Idstring("mtr_axe"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_016_c_df"),
				uv_offset_rot = Vector3(0.257393, 0.823076, 3.12136),
				pattern_pos = Vector3(0.387789, -0.404006, 0),
				uv_scale = Vector3(2.27501, 3.40989, 0),
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_020_df"),
				pattern_tweak = Vector3(5.49964, 1.60788, 1)
			},
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df"),
				uv_offset_rot = Vector3(0.149297, 0.998331, 0),
				pattern_pos = Vector3(0, 0.206535, 0),
				uv_scale = Vector3(4.172, 5.84062, 0.150966),
				pattern_tweak = Vector3(7.26449, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_013_df")
			}
		},
		wpn_fps_sho_boot_s_legendary = {
			[Idstring("mtr_s_legend"):key()] = {
				pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_006_df"),
				pattern_pos = Vector3(-0.184593, 0.7056, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_013_df"),
				pattern_tweak = Vector3(2.30384, 0, 1)
			}
		},
		wpn_fps_sho_boot_o_legendary = {
			[Idstring("mtr_sight_legend"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_001_df"),
				uv_scale = Vector3(7.22318, 12.2767, 0.179585),
				uv_offset_rot = Vector3(-0.0841165, 1.05303, 1.56293)
			}
		}
	}
	self.weapon_skins.boot_buck.types = {
		foregrip = {
			pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_006_df"),
			pattern_pos = Vector3(0.157836, 0.0849156, 0),
			uv_scale = Vector3(1, 1, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_006_df"),
			pattern_tweak = Vector3(2.16075, 0, 1)
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df"),
			uv_scale = Vector3(6.50806, 6.74644, 1),
			uv_offset_rot = Vector3(0.301932, 1.03649, 0)
		},
		stock = {
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_019_df"),
			uv_offset_rot = Vector3(-0.275371, 1.02687, 4.73275),
			pattern_pos = Vector3(0, 0.00566143, 0),
			uv_scale = Vector3(3.74393, 2.69409, 0.115192),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_009_df"),
			pattern_tweak = Vector3(3.25781, 4.6798, 1)
		}
	}
	self.weapon_skins.amcar_same = {}
	self.weapon_skins.amcar_same.name_id = "bm_wskn_amcar_same"
	self.weapon_skins.amcar_same.desc_id = "bm_wskn_amcar_same_desc"
	self.weapon_skins.amcar_same.weapon_id = "amcar"
	self.weapon_skins.amcar_same.rarity = "common"
	self.weapon_skins.amcar_same.bonus = "spread_p1"
	self.weapon_skins.amcar_same.reserve_quality = true
	self.weapon_skins.amcar_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.amcar_same.base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_001_c_df")
	self.weapon_skins.amcar_same.parts = {
		wpn_fps_m4_lower_reciever = {},
		wpn_fps_upg_m4_s_adapter = {}
	}
	self.weapon_skins.amcar_same.parts.wpn_fps_upg_m4_s_adapter["13b9deba857ff839"] = {
		base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_001_df")
	}
	self.weapon_skins.amcar_same.parts.wpn_fps_m4_lower_reciever["6e91ed22414b0c28"] = {
		uv_offset_rot = Vector3(0.1, 0.778917, 0),
		uv_scale = Vector3(1.20187, 2.34606, 1),
		sticker = Idstring("units/payday2_cash/safes/same/sticker/sticker_same_001_df")
	}
	self.weapon_skins.amcar_same.types = {
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_001_b_df")
		}
	}
	self.weapon_skins.usp_same = {}
	self.weapon_skins.usp_same.name_id = "bm_wskn_usp_same"
	self.weapon_skins.usp_same.desc_id = "bm_wskn_usp_same_desc"
	self.weapon_skins.usp_same.weapon_id = "usp"
	self.weapon_skins.usp_same.rarity = "common"
	self.weapon_skins.usp_same.bonus = "spread_p1"
	self.weapon_skins.usp_same.reserve_quality = true
	self.weapon_skins.usp_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.usp_same.base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_002_df")
	self.weapon_skins.usp_same.pattern_gradient = Idstring("units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_002_df")
	self.weapon_skins.usp_same.pattern = Idstring("units/payday2_cash/safes/same/pattern/pattern_same_002_df")
	self.weapon_skins.gre_m79_same = {}
	self.weapon_skins.gre_m79_same.name_id = "bm_wskn_gre_m79_same"
	self.weapon_skins.gre_m79_same.desc_id = "bm_wskn_gre_m79_same_desc"
	self.weapon_skins.gre_m79_same.weapon_id = "gre_m79"
	self.weapon_skins.gre_m79_same.rarity = "common"
	self.weapon_skins.gre_m79_same.bonus = "concealment_p1"
	self.weapon_skins.gre_m79_same.reserve_quality = true
	self.weapon_skins.gre_m79_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.gre_m79_same.base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_003_df")
	self.weapon_skins.gre_m79_same.pattern_gradient = Idstring("units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_003_df")
	self.weapon_skins.gre_m79_same.pattern = Idstring("units/payday2_cash/safes/same/pattern/pattern_same_003_df")
	self.weapon_skins.gre_m79_same.pattern_tweak = Vector3(7.40759, 2.02746, 1)
	self.weapon_skins.gre_m79_same.pattern_pos = Vector3(2, 1.80921, 1)
	self.weapon_skins.gre_m79_same.parts = {
		wpn_fps_gre_m79_barrel_short = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/same/sticker/sticker_same_003_df"),
				uv_offset_rot = Vector3(-0.189974, 1.2479, 0),
				uv_scale = Vector3(3.88595, 5.17317, 0)
			}
		},
		wpn_fps_gre_m79_barrel = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/same/sticker/sticker_same_003_df"),
				uv_offset_rot = Vector3(0.37825, 1.23044, 0),
				uv_scale = Vector3(4.1587, 4.68212, 1)
			}
		}
	}
	self.weapon_skins.deagle_same = {}
	self.weapon_skins.deagle_same.name_id = "bm_wskn_deagle_same"
	self.weapon_skins.deagle_same.desc_id = "bm_wskn_deagle_same_desc"
	self.weapon_skins.deagle_same.weapon_id = "deagle"
	self.weapon_skins.deagle_same.rarity = "common"
	self.weapon_skins.deagle_same.bonus = "recoil_p1"
	self.weapon_skins.deagle_same.reserve_quality = true
	self.weapon_skins.deagle_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.deagle_same.base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df")
	self.weapon_skins.deagle_same.parts = {
		wpn_fps_upg_o_rmr = {
			[Idstring("mtr_rmr"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_c_df")
			}
		},
		wpn_fps_pis_deagle_g_ergo = {
			[Idstring("grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_b_df")
			},
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_df")
			}
		},
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_d_df")
			}
		},
		wpn_fps_pis_deagle_g_bling = {
			[Idstring("bling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_c_df")
			}
		},
		wpn_fps_pis_deagle_o_standard_rear = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
			}
		},
		wpn_fps_pis_deagle_o_standard_front = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
			}
		},
		wpn_fps_pis_deagle_m_standard = {
			[Idstring("mag"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
			}
		},
		wpn_fps_pis_deagle_g_standard = {
			[Idstring("grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_c_df")
			}
		}
	}
	self.weapon_skins.deagle_same.types = {
		slide = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_005_df",
			pattern_pos = Vector3(-0.0128784, -0.27999, 0),
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_005_df"
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_d_df")
		},
		stock = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
		},
		grip = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_005_df",
			pattern_pos = Vector3(-1.02409, -0.995468, 0),
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_c_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_005_df"
		},
		upper_reciever = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
		},
		foregrip = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
		},
		vertical_grip = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_c_df")
		},
		lower_reciever = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
		},
		magazine = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_005_df"
		}
	}
	self.weapon_skins.colt_1911_same = {}
	self.weapon_skins.colt_1911_same.name_id = "bm_wskn_colt_1911_same"
	self.weapon_skins.colt_1911_same.desc_id = "bm_wskn_colt_1911_same_desc"
	self.weapon_skins.colt_1911_same.weapon_id = "colt_1911"
	self.weapon_skins.colt_1911_same.rarity = "uncommon"
	self.weapon_skins.colt_1911_same.bonus = "spread_p1"
	self.weapon_skins.colt_1911_same.reserve_quality = true
	self.weapon_skins.colt_1911_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.colt_1911_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_004_df"
	self.weapon_skins.colt_1911_same.parts = {
		wpn_fps_pis_1911_body_standard = {
			[Idstring("body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_b_df")
			}
		},
		wpn_fps_pis_1911_g_standard = {
			[Idstring("grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		},
		wpn_fps_pis_1911_g_ergo = {
			[Idstring("grip"):key()] = {
				pattern_tweak = Vector3(1.11138, 4.70977, 1),
				pattern_pos = Vector3(-0.0796562, 0.0157409, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			},
			[Idstring("ergo"):key()] = {
				pattern_tweak = Vector3(1.06368, 4.66481, 1),
				pattern_pos = Vector3(-0.0701165, -0.127355, 0),
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_df")
			}
		},
		wpn_fps_pis_1911_g_bling = {
			[Idstring("bling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_003_df"),
				pattern_tweak = Vector3(0.920584, 4.6798, 1),
				pattern_pos = Vector3(0.120678, 0.00620119, 0)
			}
		},
		wpn_fps_pis_1911_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				pattern_tweak = Vector3(1, 4.72475, 1)
			}
		}
	}
	self.weapon_skins.colt_1911_same.types = {
		slide = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_004_b_df",
			pattern_pos = Vector3(0.139757, -1.08133, 0),
			pattern_tweak = Vector3(1.20678, 3.10638, 0.160506),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_004_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_004_b_df"
		},
		grip = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_004_df",
			pattern_pos = Vector3(0.0694394, 0.0725983, 0),
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df"),
			pattern_tweak = Vector3(1.14738, 0.046, 1),
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_004_df"
		},
		magazine = {
			uv_offset_rot = Vector3(-0.155974, 1.12235, 4.84463),
			sticker = "units/payday2_cash/safes/same/sticker/sticker_same_004_df",
			uv_scale = Vector3(2.93246, 2.93246, 0.997615)
		}
	}
	self.weapon_skins.b92fs_same = {}
	self.weapon_skins.b92fs_same.name_id = "bm_wskn_b92fs_same"
	self.weapon_skins.b92fs_same.desc_id = "bm_wskn_b92fs_same_desc"
	self.weapon_skins.b92fs_same.weapon_id = "b92fs"
	self.weapon_skins.b92fs_same.rarity = "rare"
	self.weapon_skins.b92fs_same.bonus = "spread_p1"
	self.weapon_skins.b92fs_same.reserve_quality = true
	self.weapon_skins.b92fs_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.b92fs_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_b_df"
	self.weapon_skins.b92fs_same.default_blueprint = {
		"wpn_fps_pis_beretta_body_beretta",
		"wpn_fps_pis_beretta_b_std",
		"wpn_fps_pis_beretta_m_extended",
		"wpn_fps_pis_beretta_sl_brigadier",
		"wpn_upg_o_marksmansight_rear",
		"wpn_fps_pis_beretta_g_ergo",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_upg_ns_pis_jungle"
	}
	self.weapon_skins.b92fs_same.parts = {
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_df",
				uv_offset_rot = Vector3(-0.106275, 0.998331, 0),
				uv_scale = Vector3(2.74176, 2.83711, 0),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_016_b_df"
			}
		},
		wpn_fps_pis_beretta_g_std = {
			[Idstring("std_grips"):key()] = {
				uv_offset_rot = Vector3(-0.0153385, 0.756378, 6.05841),
				sticker = Idstring("units/payday2_cash/safes/same/sticker/sticker_same_016_df"),
				uv_scale = Vector3(2.88379, 2.12199, 1)
			}
		},
		wpn_upg_o_marksmansight_front = {
			[Idstring("front1"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_df"
			}
		},
		wpn_fps_pis_beretta_m_extended = {
			[Idstring("extd"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_df",
				uv_offset_rot = Vector3(-0.0178784, 0.594203, 0),
				uv_scale = Vector3(8.74877, 5.64992, 1),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_016_c_df"
			}
		},
		wpn_fps_pis_beretta_body_rail = {
			[Idstring("front_rail"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_df"
			}
		},
		wpn_upg_o_marksmansight_rear = {
			[Idstring("rear"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_df"
			}
		},
		wpn_fps_pis_beretta_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_016_df",
				uv_offset_rot = Vector3(-0.0218782, 0.755917, 6.02844),
				uv_scale = Vector3(2.78944, 2.26502, 1),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_016_df"
			}
		}
	}
	self.weapon_skins.judge_same = {}
	self.weapon_skins.judge_same.name_id = "bm_wskn_judge_same"
	self.weapon_skins.judge_same.desc_id = "bm_wskn_judge_same_desc"
	self.weapon_skins.judge_same.weapon_id = "judge"
	self.weapon_skins.judge_same.rarity = "uncommon"
	self.weapon_skins.judge_same.bonus = "spread_n1"
	self.weapon_skins.judge_same.reserve_quality = true
	self.weapon_skins.judge_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.judge_same.parts = {
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_mech"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_006_df",
				pattern_tweak = Vector3(2.30384, 5.33913, 1),
				pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_006_df",
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_006_b_df"
			},
			[Idstring("mtr_frame"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_006_b_df"
			},
			[Idstring("mtr_cylinder"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_006_df",
				pattern_tweak = Vector3(1.58836, 5.95352, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_006_b_df"
			},
			[Idstring("mtr_buckshot"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_006_df"
			}
		},
		wpn_fps_pis_judge_fl_adapter = {
			[Idstring("mtr_rail"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_006_df",
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_006_b_df"
			}
		}
	}
	self.weapon_skins.judge_same.types = {
		lower_reciever = {},
		gadget = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_006_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_006_b_df"
		},
		barrel_ext = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_006_df",
			pattern_tweak = Vector3(2.68543, 5.81865, 1),
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_006_b_df"
		},
		sight = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_006_df",
			pattern_tweak = Vector3(2.92392, 0, 1),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_006_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_006_b_df"
		}
	}
	self.weapon_skins.p90_same = {}
	self.weapon_skins.p90_same.name_id = "bm_wskn_p90_same"
	self.weapon_skins.p90_same.desc_id = "bm_wskn_p90_same_desc"
	self.weapon_skins.p90_same.weapon_id = "p90"
	self.weapon_skins.p90_same.rarity = "common"
	self.weapon_skins.p90_same.bonus = "spread_p1"
	self.weapon_skins.p90_same.reserve_quality = true
	self.weapon_skins.p90_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.p90_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_007_df"
	self.weapon_skins.p90_same.pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_007_df"
	self.weapon_skins.p90_same.pattern = "units/payday2_cash/safes/same/pattern/pattern_same_007_df"
	self.weapon_skins.p90_same.pattern_tweak = Vector3(1.01598, 1.18831, 1)
	self.weapon_skins.p90_same.pattern_pos = Vector3(0.00620103, 0, 0)
	self.weapon_skins.p90_same.parts = {
		wpn_fps_smg_p90_body_p90 = {
			[Idstring("p90"):key()] = {
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_007_df",
				uv_offset_rot = Vector3(-0.376308, 0.901394, 0),
				uv_scale = Vector3(6.12667, 5.64992, 1)
			}
		}
	}
	self.weapon_skins.akm_same = {}
	self.weapon_skins.akm_same.name_id = "bm_wskn_akm_same"
	self.weapon_skins.akm_same.desc_id = "bm_wskn_akm_same_desc"
	self.weapon_skins.akm_same.weapon_id = "akm"
	self.weapon_skins.akm_same.rarity = "uncommon"
	self.weapon_skins.akm_same.bonus = "spread_p1"
	self.weapon_skins.akm_same.reserve_quality = true
	self.weapon_skins.akm_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.akm_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_008_df"
	self.weapon_skins.akm_same.parts = {
		wpn_fps_ass_ak_body_lowerreceiver = {
			[Idstring("ak_base"):key()] = {
				uv_offset_rot = Vector3(-0.184593, 0.912473, 6.11835),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_008_df",
				uv_scale = Vector3(9.92634, 9.92634, 1)
			}
		},
		wpn_upg_ak_fg_standard = {
			[Idstring("handguard_lower_wood"):key()] = {}
		}
	}
	self.weapon_skins.akm_same.types = {
		barrel = {},
		foregrip = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_008_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_008_df"
		},
		lower_reciever = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_008_df",
			pattern_tweak = Vector3(1, 1.63785, 1),
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_008_df"
		},
		upper_reciever = {
			pattern_pos = Vector3(1.46578, 0.00620103, 0),
			pattern_tweak = Vector3(1.63606, 0, 1),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_008_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_008_df"
		}
	}
	self.weapon_skins.ak5_same = {}
	self.weapon_skins.ak5_same.name_id = "bm_wskn_ak5_same"
	self.weapon_skins.ak5_same.desc_id = "bm_wskn_ak5_same_desc"
	self.weapon_skins.ak5_same.weapon_id = "ak5"
	self.weapon_skins.ak5_same.rarity = "rare"
	self.weapon_skins.ak5_same.bonus = "spread_p1"
	self.weapon_skins.ak5_same.reserve_quality = true
	self.weapon_skins.ak5_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.ak5_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_009_df"
	self.weapon_skins.ak5_same.default_blueprint = {
		"wpn_fps_ass_ak5_body_ak5",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_ass_ak5_fg_ak5c",
		"wpn_fps_upg_m4_m_l5",
		"wpn_fps_upg_o_cs",
		"wpn_fps_ass_ak5_s_ak5b",
		"wpn_fps_ass_ak5_b_short",
		"wpn_fps_upg_fl_ass_peq15"
	}
	self.weapon_skins.ak5_same.types = {
		lower_reciever = {
			uv_offset_rot = Vector3(-0.155974, 0.893394, 0),
			sticker = "units/payday2_cash/safes/same/sticker/sticker_same_009_df",
			uv_scale = Vector3(1.82164, 1.82164, 0.0722634)
		}
	}
	self.weapon_skins.baka_same = {}
	self.weapon_skins.baka_same.name_id = "bm_wskn_baka_same"
	self.weapon_skins.baka_same.desc_id = "bm_wskn_baka_same_desc"
	self.weapon_skins.baka_same.weapon_id = "baka"
	self.weapon_skins.baka_same.rarity = "uncommon"
	self.weapon_skins.baka_same.bonus = "spread_p1"
	self.weapon_skins.baka_same.reserve_quality = true
	self.weapon_skins.baka_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.baka_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_010_df"
	self.weapon_skins.baka_same.types = {
		barrel_ext = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_010_c_df",
			pattern_tweak = Vector3(1.30217, 0, 1),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_010_b_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_010_b_df"
		},
		magazine = {
			cubemap_pattern_control = Vector3(0.942762, 0.937992, 0),
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_010_c_df",
			pattern_tweak = Vector3(1.34987, 0, 1),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_010_b_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_010_b_df"
		},
		gadget = {
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_010_c_df",
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_010_b_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_010_b_df"
		},
		grip = {
			cubemap_pattern_control = Vector3(0.649416, 0.902218, 0),
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_010_b_df",
			pattern_tweak = Vector3(1.87455, 0, 0.580253),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_010_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_010_df"
		},
		upper_reciever = {
			cubemap_pattern_control = Vector3(0.923682, 0.918913, 0),
			base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_010_c_df",
			pattern_tweak = Vector3(1.68376, 0, 1),
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_010_b_df",
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_010_b_df"
		}
	}
	self.weapon_skins.model70_same = {}
	self.weapon_skins.model70_same.name_id = "bm_wskn_model70_same"
	self.weapon_skins.model70_same.desc_id = "bm_wskn_model70_same_desc"
	self.weapon_skins.model70_same.weapon_id = "model70"
	self.weapon_skins.model70_same.rarity = "epic"
	self.weapon_skins.model70_same.bonus = "recoil_p1"
	self.weapon_skins.model70_same.reserve_quality = true
	self.weapon_skins.model70_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.model70_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_011_df"
	self.weapon_skins.model70_same.default_blueprint = {
		"wpn_fps_snp_model70_b_standard",
		"wpn_fps_snp_model70_body_standard",
		"wpn_fps_snp_model70_s_standard",
		"wpn_fps_snp_model70_m_standard",
		"wpn_fps_snp_model70_ns_suppressor",
		"wpn_fps_upg_o_leupold"
	}
	self.weapon_skins.model70_same.parts = {
		wpn_fps_snp_model70_ns_suppressor = {
			[Idstring("mtr_supp"):key()] = {
				uv_offset_rot = Vector3(0.340091, 0.995331, 0),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_011_b_df",
				uv_scale = Vector3(4.39607, 4.39607, 0)
			}
		},
		wpn_fps_upg_o_leupold = {
			[Idstring("leupold"):key()] = {
				uv_offset_rot = Vector3(0.400249, 1.00987, 6.25322),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_011_b_df",
				uv_scale = Vector3(3.68095, 3.68095, 0)
			}
		}
	}
	self.weapon_skins.model70_same.types = {
		stock = {
			uv_offset_rot = Vector3(0.072979, 1.15404, 0.513984),
			sticker = "units/payday2_cash/safes/same/sticker/sticker_same_011_df",
			uv_scale = Vector3(0.915819, 0.915819, 0.785357)
		}
	}
	self.weapon_skins.new_raging_bull_same = {}
	self.weapon_skins.new_raging_bull_same.name_id = "bm_wskn_new_raging_bull_same"
	self.weapon_skins.new_raging_bull_same.desc_id = "bm_wskn_new_raging_bull_same_desc"
	self.weapon_skins.new_raging_bull_same.weapon_id = "new_raging_bull"
	self.weapon_skins.new_raging_bull_same.rarity = "epic"
	self.weapon_skins.new_raging_bull_same.bonus = "recoil_p1"
	self.weapon_skins.new_raging_bull_same.reserve_quality = true
	self.weapon_skins.new_raging_bull_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.new_raging_bull_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_012_df"
	self.weapon_skins.new_raging_bull_same.pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_012_b_df"
	self.weapon_skins.new_raging_bull_same.cubemap_pattern_control = Vector3(0.189125, 0, 0)
	self.weapon_skins.new_raging_bull_same.default_blueprint = {
		"wpn_fps_pis_rage_body_smooth",
		"wpn_fps_pis_rage_b_long",
		"wpn_fps_pis_rage_g_ergo"
	}
	self.weapon_skins.new_raging_bull_same.parts = {
		wpn_fps_pis_rage_body_smooth = {
			[Idstring("smooth"):key()] = {
				pattern_pos = Vector3(0.655441, -0.117815, 0),
				pattern_tweak = Vector3(0.682091, 1.57791, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_c_df"
			}
		},
		wpn_fps_pis_rage_b_comp1 = {
			[Idstring("comp1"):key()] = {
				pattern_pos = Vector3(-0.136895, -0.60434, 0),
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_df"
			}
		},
		wpn_fps_pis_rage_b_short = {
			[Idstring("barrel_short"):key()] = {
				pattern_pos = Vector3(-0.0605769, -0.632959, 0),
				pattern_tweak = Vector3(0.586694, 0, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_b_df"
			}
		},
		wpn_fps_pis_rage_b_comp2 = {
			[Idstring("comp2"):key()] = {
				pattern_pos = Vector3(-0.0701165, -0.741436, 0),
				pattern_tweak = Vector3(0.562695, 6.28319, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_df"
			}
		},
		wpn_fps_pis_rage_b_long = {
			[Idstring("barrel_long"):key()] = {
				pattern_pos = Vector3(-0.108275, -0.461245, 0),
				pattern_tweak = Vector3(0.72979, 6.26321, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_df"
			}
		},
		wpn_fps_pis_rage_b_standard = {
			[Idstring("barrel_standard"):key()] = {
				pattern_pos = Vector3(-0.0319577, -0.652579, 0),
				pattern_tweak = Vector3(0.608694, 0, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_df"
			}
		},
		wpn_fps_pis_rage_body_standard = {
			[Idstring("cylinder"):key()] = {
				pattern_pos = Vector3(-0.709277, -0.0605769, 0),
				pattern_tweak = Vector3(1.39757, 0, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_c_df"
			}
		}
	}
	self.weapon_skins.new_raging_bull_same.types = {
		barrel_ext = {
			pattern_pos = Vector3(0.540425, 2, 0),
			pattern_tweak = Vector3(0.0620104, 0, 1),
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_df"
		},
		grip = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_012_df",
			pattern_tweak = Vector3(2.68543, 0, 1),
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_012_d_df"
		}
	}
	self.weapon_skins.new_m14_same = {}
	self.weapon_skins.new_m14_same.name_id = "bm_wskn_new_m14_same"
	self.weapon_skins.new_m14_same.desc_id = "bm_wskn_new_m14_same_desc"
	self.weapon_skins.new_m14_same.weapon_id = "new_m14"
	self.weapon_skins.new_m14_same.rarity = "rare"
	self.weapon_skins.new_m14_same.bonus = "recoil_p1"
	self.weapon_skins.new_m14_same.reserve_quality = true
	self.weapon_skins.new_m14_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.new_m14_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_014_df"
	self.weapon_skins.new_m14_same.pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_014_df"
	self.weapon_skins.new_m14_same.pattern = "units/payday2_cash/safes/same/pattern/pattern_same_014_df"
	self.weapon_skins.new_m14_same.pattern_tweak = Vector3(3.30551, 0.498999, 1)
	self.weapon_skins.new_m14_same.pattern_pos = Vector3(-0.127355, -0.499403, 0)
	self.weapon_skins.new_m14_same.default_blueprint = {
		"wpn_fps_ass_m14_b_standard",
		"wpn_fps_ass_m14_body_lower",
		"wpn_fps_ass_m14_body_upper",
		"wpn_fps_ass_m14_m_standard",
		"wpn_fps_upg_ns_ass_smg_tank",
		"wpn_fps_ass_m14_body_jae",
		"wpn_fps_upg_fl_ass_smg_sho_peqbox",
		"wpn_fps_upg_o_acog"
	}
	self.weapon_skins.new_m14_same.parts = {
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_014_df",
				pattern_pos = Vector3(-0.27999, 0.0348201, 0),
				pattern_tweak = Vector3(1.15908, 0.304195, 1),
				pattern = "units/payday2_cash/safes/same/pattern/pattern_same_014_df"
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				pattern_tweak = Vector3(0.777489, 0, 1)
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
				pattern_tweak = Vector3(0.586694, 0, 1)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				pattern_tweak = Vector3(0.872886, 0, 1)
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df"),
				pattern_tweak = Vector3(1.01598, 0, 1),
				pattern_pos = Vector3(0, -0.251371, 0)
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_002_df"),
				pattern_tweak = Vector3(0.825187, 1.5929, 1),
				pattern_pos = Vector3(0.810076, -0.28199, 0)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				pattern_tweak = Vector3(0.634393, 0, 1)
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df"),
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern_pos = Vector3(0, -0.489864, 0)
			}
		}
	}
	self.weapon_skins.par_same = {}
	self.weapon_skins.par_same.name_id = "bm_wskn_par_same"
	self.weapon_skins.par_same.desc_id = "bm_wskn_par_same_desc"
	self.weapon_skins.par_same.weapon_id = "par"
	self.weapon_skins.par_same.rarity = "common"
	self.weapon_skins.par_same.bonus = "recoil_p1"
	self.weapon_skins.par_same.reserve_quality = true
	self.weapon_skins.par_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.par_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_017_df"
	self.weapon_skins.par_same.parts = {
		wpn_fps_lmg_par_body_standard = {
			[Idstring("mtr_feed"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_df")
			},
			[Idstring("mtr_sight"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_df")
			}
		},
		wpn_fps_lmg_par_upper_reciever = {
			[Idstring("mtr_dustcover"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_017_df"
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_017_df"
			}
		},
		wpn_fps_lmg_par_b_short = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_e_df")
			}
		},
		wpn_fps_upg_fl_ass_utg = {
			[Idstring("mtr_led"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_017_df"
			}
		},
		wpn_fps_lmg_par_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_same_018_e_df")
			}
		},
		wpn_fps_lmg_par_s_plastic = {
			[Idstring("mtr_stock"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_017_b_df"
			}
		}
	}
	self.weapon_skins.ksg_same = {}
	self.weapon_skins.ksg_same.name_id = "bm_wskn_ksg_same"
	self.weapon_skins.ksg_same.desc_id = "bm_wskn_ksg_same_desc"
	self.weapon_skins.ksg_same.weapon_id = "ksg"
	self.weapon_skins.ksg_same.rarity = "legendary"
	self.weapon_skins.ksg_same.bonus = "spread_n1"
	self.weapon_skins.ksg_same.reserve_quality = true
	self.weapon_skins.ksg_same.texture_bundle_folder = "cash/safes/same"
	self.weapon_skins.ksg_same.unique_name_id = "bm_wskn_ksg_same"
	self.weapon_skins.ksg_same.locked = true
	self.weapon_skins.ksg_same.base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_015_df"
	self.weapon_skins.ksg_same.default_blueprint = {
		"wpn_fps_sho_ksg_body_standard",
		"wpn_fps_sho_ksg_b_legendary",
		"wpn_fps_sho_ksg_fg_standard",
		"wpn_fps_upg_o_dd_rear",
		"wpn_fps_upg_a_custom_free"
	}
	self.weapon_skins.ksg_same.parts = {
		wpn_fps_sho_ksg_fg_standard = {
			[Idstring("mat_pump"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_015_d_df"),
				uv_offset_rot = Vector3(-0.308609, 0.740759, 4.14034),
				uv_scale = Vector3(0.01, 0.601377, 0),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_015_e_df"
			}
		},
		wpn_fps_upg_o_dd_rear = {
			[Idstring("mtr_dd"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_015_d_df")
			}
		},
		wpn_fps_upg_o_dd_front = {
			[Idstring("mtr_dd"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/same/base_gradient/base_gradient_same_015_d_df")
			}
		},
		wpn_fps_sho_ksg_b_legendary = {
			[Idstring("mat_body"):key()] = {
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_015_c_df"
			},
			[Idstring("mtr_comp"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				base_gradient = "units/payday2_cash/safes/same/base_gradient/base_gradient_same_015_b_df",
				sticker = Idstring("units/payday2_cash/safes/same/sticker/sticker_same_015_b_df"),
				uv_scale = Vector3(5.22085, 5.22085, 0.053184),
				uv_offset_rot = Vector3(-0.00333852, 0.993331, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
				pattern = Idstring("units/payday2_cash/safes/same/pattern/same_pattern_016_df")
			}
		},
		wpn_fps_sho_ksg_body_standard = {
			[Idstring("mat_body"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/same/pattern_gradient/gradient_same_016_df"),
				pattern_tweak = Vector3(0.983, 3.15932, 1),
				uv_offset_rot = Vector3(-0.093196, 1.00787, 6.28319),
				uv_scale = Vector3(3.12316, 3.07549, 0),
				pattern_pos = Vector3(1.10057, 1.2172, 0),
				sticker = "units/payday2_cash/safes/same/sticker/sticker_same_015_df",
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_010_df")
			}
		}
	}
	self.weapon_skins.ksg_same.types = {
		foregrip = {
			pattern_gradient = "units/payday2_cash/safes/same/pattern_gradient/pattern_gradient_same_015_df",
			pattern_pos = Vector3(-0.632959, -0.165514, 0),
			pattern_tweak = Vector3(4.02099, 0, 0),
			pattern = "units/payday2_cash/safes/same/pattern/pattern_same_015_df"
		}
	}
	self.weapon_skins.saiga_grunt = {}
	self.weapon_skins.saiga_grunt.name_id = "bm_wskn_saiga_grunt"
	self.weapon_skins.saiga_grunt.desc_id = "bm_wskn_saiga_grunt_desc"
	self.weapon_skins.saiga_grunt.weapon_id = "saiga"
	self.weapon_skins.saiga_grunt.rarity = "common"
	self.weapon_skins.saiga_grunt.bonus = "spread_n1"
	self.weapon_skins.saiga_grunt.reserve_quality = true
	self.weapon_skins.saiga_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.saiga_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
	self.weapon_skins.saiga_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_001_df")
	self.weapon_skins.saiga_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.saiga_grunt.parts = {
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df"),
				pattern_pos = Vector3(0.38779, 0.340091, 0),
				pattern_tweak = Vector3(1.34987, 0, 1)
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df")
			}
		},
		wpn_fps_upg_ns_shot_thick = {
			[Idstring("thick"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_o_ak_scopemount = {
			[Idstring("mtr_kv04"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_ak_g_rk3 = {
			[Idstring("mtr_rk3"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df")
			}
		},
		wpn_upg_ak_s_skfoldable = {
			[Idstring("sk_foldable"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_ak_g_wgrip = {
			[Idstring("mtr_woodgrip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_002_df")
			}
		},
		wpn_fps_upg_ns_sho_salvo_large = {
			[Idstring("mtr_salvo_large"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df")
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df")
			}
		},
		wpn_upg_saiga_fg_lowerrail = {
			[Idstring("lower_rail"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df")
			}
		},
		wpn_fps_upg_ns_shot_shark = {
			[Idstring("shark"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df")
			}
		},
		wpn_fps_upg_shot_ns_king = {
			[Idstring("mtr_king"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_shot_saiga_b_standard = {
			[Idstring("saiga_barrel"):key()] = {
				pattern_pos = Vector3(0, 0.235154, 0)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_011_df")
			}
		},
		wpn_upg_ak_s_psl = {
			[Idstring("psl"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_upg_ak_s_folding_vanilla = {
			[Idstring("folding"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df")
			}
		},
		wpn_fps_smg_akmsu_body_lowerreceiver = {
			[Idstring("ak_base"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_001_df")
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df")
			}
		},
		wpn_fps_upg_ak_s_solidstock = {
			[Idstring("mtr_solid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df"),
				pattern_tweak = Vector3(0.0620104, 0, 1)
			}
		},
		wpn_upg_ak_g_standard = {
			[Idstring("pistolgrip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_ak_g_pgrip = {
			[Idstring("mtr_akgrip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_ak_g_hgrip = {
			[Idstring("mtr_ergoak"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_005_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_upg_ak_s_adapter = {
			[Idstring("ak_stockadapter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df")
			}
		},
		wpn_upg_saiga_fg_standard = {
			[Idstring("saiga_handguard"):key()] = {
				uv_offset_rot = Vector3(-0.240292, 1.19013, 0),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_007_df"),
				uv_scale = Vector3(4.79177, 6.07899, 1)
			}
		}
	}
	self.weapon_skins.saiga_grunt.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_b_df")
		},
		foregrip = {
			pattern_tweak = Vector3(0, 0, 1),
			uv_scale = Vector3(1, 1, 0)
		},
		barrel = {
			pattern_pos = Vector3(0, 0.111138, 0),
			pattern_tweak = Vector3(2.08305, 1.18831, 1),
			uv_scale = Vector3(1, 1, 0)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_df"),
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.m1928_grunt = {}
	self.weapon_skins.m1928_grunt.name_id = "bm_wskn_m1928_grunt"
	self.weapon_skins.m1928_grunt.desc_id = "bm_wskn_m1928_grunt_desc"
	self.weapon_skins.m1928_grunt.weapon_id = "m1928"
	self.weapon_skins.m1928_grunt.rarity = "common"
	self.weapon_skins.m1928_grunt.bonus = "spread_p1"
	self.weapon_skins.m1928_grunt.reserve_quality = true
	self.weapon_skins.m1928_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.m1928_grunt.base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df")
	self.weapon_skins.m1928_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crime_df")
	self.weapon_skins.m1928_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
	self.weapon_skins.m1928_grunt.pattern_tweak = Vector3(0.72979, 0, 1)
	self.weapon_skins.m1928_grunt.parts = {
		wpn_fps_upg_fl_ass_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_smg_thompson_foregrip = {
			[Idstring("mtr_fg"):key()] = {
				pattern_tweak = Vector3(0.920584, 0, 1)
			}
		},
		wpn_fps_smg_thompson_drummag = {
			[Idstring("mtr_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		}
	}
	self.weapon_skins.m1928_grunt.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_010_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_002_df"),
			pattern_tweak = Vector3(0, 0, 0),
			wear_and_tear = 0.8,
			pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_016_df"),
			pattern_tweak = Vector3(0, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_002_df"),
			pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_004_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df"),
			pattern_tweak = Vector3(1.30217, 0, 1)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df")
		},
		barrel_ext = {
			pattern_pos = Vector3(0, 0.0252805, 0),
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_002_df"),
			pattern_tweak = Vector3(0.491297, 0, 1)
		},
		upper_reciever = {
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.m45_grunt = {}
	self.weapon_skins.m45_grunt.name_id = "bm_wskn_m45_grunt"
	self.weapon_skins.m45_grunt.desc_id = "bm_wskn_m45_grunt_desc"
	self.weapon_skins.m45_grunt.weapon_id = "m45"
	self.weapon_skins.m45_grunt.rarity = "common"
	self.weapon_skins.m45_grunt.bonus = "spread_p1"
	self.weapon_skins.m45_grunt.reserve_quality = true
	self.weapon_skins.m45_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.m45_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df")
	self.weapon_skins.m45_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_001_df")
	self.weapon_skins.m45_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.m45_grunt.parts = {
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df")
			}
		},
		wpn_fps_upg_ass_ns_battle = {
			[Idstring("mtr_battle"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_firepig = {
			[Idstring("firepig"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_ass_ns_linear = {
			[Idstring("mtr_linear"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_smg_m45_g_ergo = {
			[Idstring("m45_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_stubby = {
			[Idstring("stubby"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_small = {
			[Idstring("small"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_large = {
			[Idstring("silencer_large"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df"),
				pattern_tweak = Vector3(0.634393, 0, 1)
			}
		}
	}
	self.weapon_skins.m45_grunt.types = {
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_b_df")
		},
		upper_reciever = {
			uv_offset_rot = Vector3(0.470647, 2, 0),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_015_df"),
			uv_scale = Vector3(3.55223, 3.74293, 0)
		}
	}
	self.weapon_skins.p226_grunt = {}
	self.weapon_skins.p226_grunt.name_id = "bm_wskn_p226_grunt"
	self.weapon_skins.p226_grunt.desc_id = "bm_wskn_p226_grunt_desc"
	self.weapon_skins.p226_grunt.weapon_id = "p226"
	self.weapon_skins.p226_grunt.rarity = "common"
	self.weapon_skins.p226_grunt.bonus = "concealment_p1"
	self.weapon_skins.p226_grunt.reserve_quality = true
	self.weapon_skins.p226_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.p226_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
	self.weapon_skins.p226_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_006_df")
	self.weapon_skins.p226_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.p226_grunt.pattern_tweak = Vector3(1.49297, 0, 1)
	self.weapon_skins.p226_grunt.pattern_pos = Vector3(0, 0.244694, 0)
	self.weapon_skins.p226_grunt.parts = {
		wpn_fps_upg_o_rmr = {
			[Idstring("mtr_rmr"):key()] = {
				pattern_tweak = Vector3(0.348202, 0, 1)
			}
		},
		wpn_fps_pis_p226_g_standard = {
			[Idstring("mtr_g_standard"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_004_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
			}
		},
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
			}
		},
		wpn_fps_pis_p226_g_ergo = {
			[Idstring("mtr_g_ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_018_df")
			}
		},
		wpn_fps_pis_p226_o_standard = {
			[Idstring("mtr_sight"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
			}
		},
		wpn_fps_pis_p226_body_standard = {
			[Idstring("mtr_frame"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_df"),
				pattern_pos = Vector3(0, 2, 0),
				pattern_tweak = Vector3(0, 0, 1)
			}
		}
	}
	self.weapon_skins.p226_grunt.types = {
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_b_df"),
			pattern_tweak = Vector3(1.11138, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
		},
		grip = {
			pattern_tweak = Vector3(0, 0, 1),
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
		}
	}
	self.weapon_skins.new_mp5_grunt = {}
	self.weapon_skins.new_mp5_grunt.name_id = "bm_wskn_new_mp5_grunt"
	self.weapon_skins.new_mp5_grunt.desc_id = "bm_wskn_new_mp5_grunt_desc"
	self.weapon_skins.new_mp5_grunt.weapon_id = "new_mp5"
	self.weapon_skins.new_mp5_grunt.rarity = "common"
	self.weapon_skins.new_mp5_grunt.bonus = "spread_p1"
	self.weapon_skins.new_mp5_grunt.reserve_quality = true
	self.weapon_skins.new_mp5_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.new_mp5_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
	self.weapon_skins.new_mp5_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df")
	self.weapon_skins.new_mp5_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
	self.weapon_skins.new_mp5_grunt.pattern_tweak = Vector3(1.73146, 0, 1)
	self.weapon_skins.new_mp5_grunt.parts = {
		wpn_fps_upg_fl_ass_smg_sho_surefire = {
			[Idstring("surefire"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_001_df"),
				pattern_tweak = Vector3(0, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_003_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_tank = {
			[Idstring("tank"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_003_df"),
				pattern_tweak = Vector3(0.777489, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_018_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_003_df")
			}
		},
		wpn_fps_upg_fl_ass_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_firepig = {
			[Idstring("firepig"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/cola/pattern_gradient/gradient_cola_006_df"),
				pattern_tweak = Vector3(0.586694, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_001_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_medium = {
			[Idstring("medium"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df"),
				pattern_tweak = Vector3(1.06368, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
			}
		}
	}
	self.weapon_skins.new_mp5_grunt.types = {
		foregrip = {
			pattern_tweak = Vector3(2.35154, 6.14837, 1),
			pattern_pos = Vector3(0, 0.139757, 0)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df"),
			uv_offset_rot = Vector3(0.0629791, 0.792537, 0),
			uv_scale = Vector3(7.22318, 6.84179, 0),
			pattern_pos = Vector3(0.771378, -0.222752, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_022_df"),
			pattern_tweak = Vector3(1.39757, 0, 1)
		},
		magazine = {
			pattern_tweak = Vector3(0.825187, 0, 1)
		},
		stock = {
			pattern_tweak = Vector3(1.44527, 6.25319, 1),
			uv_offset_rot = Vector3(-0.443705, 2, 0),
			uv_scale = Vector3(1.26385, 4.83945, 0),
			pattern_pos = Vector3(0.330551, 0.445028, 0),
			sticker = Idstring("units/payday2_cash/safes/buck/sticker/buck_sticker_015_df")
		},
		gadget = {
			pattern_tweak = Vector3(0.72979, 0, 1)
		},
		barrel_ext = {
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df"),
			pattern_tweak = Vector3(0.777489, 0, 1),
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df"),
			pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
		}
	}
	self.weapon_skins.wa2000_grunt = {}
	self.weapon_skins.wa2000_grunt.name_id = "bm_wskn_wa2000_grunt"
	self.weapon_skins.wa2000_grunt.desc_id = "bm_wskn_wa2000_grunt_desc"
	self.weapon_skins.wa2000_grunt.weapon_id = "wa2000"
	self.weapon_skins.wa2000_grunt.rarity = "common"
	self.weapon_skins.wa2000_grunt.bonus = "recoil_p1"
	self.weapon_skins.wa2000_grunt.reserve_quality = true
	self.weapon_skins.wa2000_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.wa2000_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df")
	self.weapon_skins.wa2000_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_002_df")
	self.weapon_skins.wa2000_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
	self.weapon_skins.wa2000_grunt.pattern_tweak = Vector3(2.87622, 0, 1)
	self.weapon_skins.wa2000_grunt.parts = {
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				pattern_tweak = Vector3(0.586694, 0, 1)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df")
			}
		},
		wpn_fps_upg_fl_ass_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df"),
				pattern_tweak = Vector3(0.538996, 0, 1)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				pattern_tweak = Vector3(0.682091, 0, 1)
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				pattern_tweak = Vector3(0.348202, 0, 1),
				pattern_pos = Vector3(0, 0.301932, 0)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				pattern_tweak = Vector3(0.443599, 0, 1)
			}
		},
		wpn_fps_snp_wa2000_body_standard = {
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_tweak = Vector3(0.538996, 0, 1)
			}
		}
	}
	self.weapon_skins.wa2000_grunt.types = {
		stock = {
			pattern_tweak = Vector3(0.72979, 0, 1),
			pattern_pos = Vector3(-0.0796562, 0.0538997, 0)
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df"),
			pattern_tweak = Vector3(0.920584, 0, 1)
		}
	}
	self.weapon_skins.boot_grunt = {}
	self.weapon_skins.boot_grunt.name_id = "bm_wskn_boot_grunt"
	self.weapon_skins.boot_grunt.desc_id = "bm_wskn_boot_grunt_desc"
	self.weapon_skins.boot_grunt.weapon_id = "boot"
	self.weapon_skins.boot_grunt.rarity = "uncommon"
	self.weapon_skins.boot_grunt.bonus = "spread_n1"
	self.weapon_skins.boot_grunt.reserve_quality = true
	self.weapon_skins.boot_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.boot_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df")
	self.weapon_skins.boot_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_004_df")
	self.weapon_skins.boot_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_002_df")
	self.weapon_skins.boot_grunt.pattern_tweak = Vector3(2.11305, 1.51798, 1)
	self.weapon_skins.boot_grunt.pattern_pos = Vector3(0.244694, -0.222752, 0)
	self.weapon_skins.boot_grunt.parts = {
		wpn_fps_sho_boot_fg_standard = {
			[Idstring("mtr_fg"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_017_df"),
				uv_offset_rot = Vector3(-0.0319576, 0.998331, 0),
				uv_scale = Vector3(5.50689, 7.22318, 0)
			}
		},
		wpn_fps_sho_boot_body_standard = {
			[Idstring("mtr_mech"):key()] = {
				pattern_pos = Vector3(0, 0.569044, 0)
			},
			[Idstring("mtr_body"):key()] = {
				uv_offset_rot = Vector3(0.015, 0.893314, 5.80367),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_003_df"),
				uv_scale = Vector3(5.3162, 5.74527, 0)
			}
		},
		wpn_fps_sho_boot_s_long = {
			[Idstring("mtr_solid"):key()] = {
				uv_offset_rot = Vector3(-0.00379881, 0.998871, 1.51798),
				uv_scale = Vector3(4.5534, 4.31503, 1)
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				pattern_tweak = Vector3(0.682091, 0, 1)
			}
		},
		wpn_fps_sho_boot_s_short = {
			[Idstring("mtr_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_015_df")
			}
		},
		wpn_fps_upg_ns_sho_salvo_large = {
			[Idstring("mtr_salvo_large"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_sho_boot_body_exotic = {
			[Idstring("mtr_body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_003_df"),
				uv_offset_rot = Vector3(0.002, 0.896474, 5.98349),
				uv_scale = Vector3(5.98364, 5.84062, 1)
			}
		}
	}
	self.weapon_skins.boot_grunt.types = {
		stock = {
			uv_offset_rot = Vector3(-0.246831, 0.971393, 1.57791),
			sticker = Idstring("units/payday2_cash/safes/burn/sticker/burn_sticker_015_df"),
			uv_scale = Vector3(4.98247, 4.60108, 0)
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df"),
			uv_offset_rot = Vector3(0.001, 1.23682, 0),
			uv_scale = Vector3(1, 0.930124, 1),
			pattern_pos = Vector3(0.35917, -0.413546, 0),
			pattern_tweak = Vector3(2.01765, 0, 1)
		},
		barrel = {
			uv_offset_rot = Vector3(0.415869, 0.960172, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_002_df"),
			uv_scale = Vector3(0.285704, 0.236678, 1)
		},
		lower_reciever = {
			pattern_pos = Vector3(0.664441, 0.101598, 0),
			pattern_tweak = Vector3(1.44527, 2.0874, 1)
		}
	}
	self.weapon_skins.g22c_grunt = {}
	self.weapon_skins.g22c_grunt.name_id = "bm_wskn_g22c_grunt"
	self.weapon_skins.g22c_grunt.desc_id = "bm_wskn_g22c_grunt_desc"
	self.weapon_skins.g22c_grunt.weapon_id = "g22c"
	self.weapon_skins.g22c_grunt.rarity = "uncommon"
	self.weapon_skins.g22c_grunt.bonus = "concealment_p1"
	self.weapon_skins.g22c_grunt.reserve_quality = true
	self.weapon_skins.g22c_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.g22c_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df")
	self.weapon_skins.g22c_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/pack/pattern_gradient/gradient_pack_002_df")
	self.weapon_skins.g22c_grunt.pattern = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_pixel_camo_df")
	self.weapon_skins.g22c_grunt.pattern_tweak = Vector3(2.20844, 0, 1)
	self.weapon_skins.g22c_grunt.pattern_pos = Vector3(0.235154, -0.502943, 0)
	self.weapon_skins.g22c_grunt.parts = {
		wpn_fps_pis_g18c_m_mag_33rnd = {
			[Idstring("mtr_mag_extended"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_006_df"),
				pattern_pos = Vector3(0, 0.330551, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/gradient_france_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				pattern_tweak = Vector3(0.109709, 0, 1),
				pattern_pos = Vector3(0, -0.241831, 0)
			}
		},
		wpn_fps_pis_g22c_body_standard = {
			[Idstring("mtr_magwell"):key()] = {
				uv_offset_rot = Vector3(0.410249, 0.792138, 1.0984),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_013_df"),
				uv_scale = Vector3(6.60341, 5.3162, 1)
			},
			[Idstring("frame"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df"),
				uv_offset_rot = Vector3(-0.430086, 0.797997, 0),
				uv_scale = Vector3(10.4174, 8.36738, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_010_df")
			}
		},
		wpn_fps_upg_o_rmr = {
			[Idstring("mtr_rmr"):key()] = {
				pattern_tweak = Vector3(0.777489, 0, 1)
			}
		},
		wpn_fps_pis_g26_g_laser = {
			[Idstring("mtr_laser"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_010_df"),
				uv_scale = Vector3(2.93246, 3.69526, 1),
				uv_offset_rot = Vector3(0.0920586, 0.998331, 4.70977)
			}
		},
		wpn_fps_pis_g26_g_gripforce = {
			[Idstring("mtr_gripforce"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				uv_offset_rot = Vector3(-0.127355, 0.979251, 4.70977),
				uv_scale = Vector3(2.02664, 2.07432, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_010_df")
			}
		},
		wpn_fps_pis_g22c_b_standard = {
			[Idstring("mtr_sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_b_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			},
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_001_df")
			}
		},
		wpn_fps_pis_g22c_b_long = {
			[Idstring("mtr_barrel_long"):key()] = {
				pattern_tweak = Vector3(1.34987, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_010_df")
			},
			[Idstring("mtr_g35"):key()] = {
				uv_offset_rot = Vector3(-0.203672, 0.928093, 0),
				uv_scale = Vector3(10.6558, 11.2755, 1)
			}
		},
		wpn_fps_pis_g18c_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern_pos = Vector3(0.559504, 1.2082, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_001_df")
			}
		}
	}
	self.weapon_skins.g22c_grunt.types = {
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/cola/sticker/sticker_markings_7_df"),
			uv_offset_rot = Vector3(0.38371, 0.924013, 6.28319),
			uv_scale = Vector3(13.7556, 14.279, 1)
		},
		slide = {
			uv_offset_rot = Vector3(-0.260911, 0.906013, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_004_df"),
			uv_scale = Vector3(8.5104, 11.7046, 0)
		}
	}
	self.weapon_skins.m249_grunt = {}
	self.weapon_skins.m249_grunt.name_id = "bm_wskn_m249_grunt"
	self.weapon_skins.m249_grunt.desc_id = "bm_wskn_m249_grunt_desc"
	self.weapon_skins.m249_grunt.weapon_id = "m249"
	self.weapon_skins.m249_grunt.rarity = "uncommon"
	self.weapon_skins.m249_grunt.bonus = "spread_p1"
	self.weapon_skins.m249_grunt.reserve_quality = true
	self.weapon_skins.m249_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.m249_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df")
	self.weapon_skins.m249_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_001_df")
	self.weapon_skins.m249_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.m249_grunt.parts = {
		wpn_fps_lmg_m249_s_modern = {
			[Idstring("mtr_modern"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_001_df")
			}
		},
		wpn_fps_lmg_m249_s_para = {
			[Idstring("mtr_para"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_001_df"),
				pattern_pos = Vector3(0, -1.51061, 0)
			},
			[Idstring("mtr_sling"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
			}
		},
		wpn_fps_lmg_m249_fg_mk46 = {
			[Idstring("mtr_mk46"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_spikey_df"),
				pattern_tweak = Vector3(0.825187, 0, 1),
				pattern_pos = Vector3(0, 0.301932, 0)
			}
		},
		wpn_fps_lmg_m249_body_standard = {
			[Idstring("mtr_body"):key()] = {
				pattern_pos = Vector3(2, -0.451705, 0),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_lmg_m249_m_standard = {
			[Idstring("mtr_lid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				pattern_tweak = Vector3(0.443599, 0, 1)
			}
		},
		wpn_fps_lmg_m249_upper_reciever = {
			[Idstring("mtr_dustcover"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_001_df")
			}
		},
		wpn_fps_lmg_m249_fg_standard = {
			[Idstring("mtr_plastic"):key()] = {
				pattern_pos = Vector3(2, 2, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
			}
		},
		wpn_fps_upg_m4_s_standard = {
			[Idstring("stock_standard"):key()] = {
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern_pos = Vector3(0, 0.244694, 0)
			}
		}
	}
	self.weapon_skins.m249_grunt.types = {
		stock = {
			pattern_tweak = Vector3(0.538996, 0, 1)
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_007_df"),
			uv_offset_rot = Vector3(-0.322768, 0.873775, 0),
			uv_scale = Vector3(3.40921, 4.9348, 0.001)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_003_df")
		}
	}
	self.weapon_skins.ksg_grunt = {}
	self.weapon_skins.ksg_grunt.name_id = "bm_wskn_ksg_grunt"
	self.weapon_skins.ksg_grunt.desc_id = "bm_wskn_ksg_grunt_desc"
	self.weapon_skins.ksg_grunt.weapon_id = "ksg"
	self.weapon_skins.ksg_grunt.rarity = "uncommon"
	self.weapon_skins.ksg_grunt.bonus = "spread_n1"
	self.weapon_skins.ksg_grunt.reserve_quality = true
	self.weapon_skins.ksg_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.ksg_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_010_df")
	self.weapon_skins.ksg_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
	self.weapon_skins.ksg_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.ksg_grunt.pattern_tweak = Vector3(1.77916, 0, 1)
	self.weapon_skins.ksg_grunt.pattern_pos = Vector3(0.37825, -0.175053, 0)
	self.weapon_skins.ksg_grunt.parts = {
		wpn_fps_upg_fl_ass_smg_sho_surefire = {
			[Idstring("surefire"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_fps_upg_o_dd_front = {
			[Idstring("mtr_dd"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_df")
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				pattern_tweak = Vector3(0.682091, 0, 1),
				pattern_pos = Vector3(0, 0.216075, 0)
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_tweak = Vector3(1.01598, 0, 1)
			}
		},
		wpn_fps_sho_ksg_b_standard = {
			[Idstring("mat_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_016_df")
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_fps_upg_o_dd_rear = {
			[Idstring("mtr_dd"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
			}
		},
		wpn_fps_upg_fl_ass_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		}
	}
	self.weapon_skins.ksg_grunt.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_010_b_df")
		},
		lower_body = {
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_004_df"),
			uv_offset_rot = Vector3(-0.188593, 0.962712, 0),
			uv_scale = Vector3(10.5604, 13.5639, 1)
		}
	}
	self.weapon_skins.winchester1874_grunt = {}
	self.weapon_skins.winchester1874_grunt.name_id = "bm_wskn_winchester1874_grunt"
	self.weapon_skins.winchester1874_grunt.desc_id = "bm_wskn_winchester1874_grunt_desc"
	self.weapon_skins.winchester1874_grunt.weapon_id = "winchester1874"
	self.weapon_skins.winchester1874_grunt.rarity = "rare"
	self.weapon_skins.winchester1874_grunt.bonus = "recoil_p1"
	self.weapon_skins.winchester1874_grunt.reserve_quality = true
	self.weapon_skins.winchester1874_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.winchester1874_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_011_df")
	self.weapon_skins.winchester1874_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_002_df")
	self.weapon_skins.winchester1874_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_007_df")
	self.weapon_skins.winchester1874_grunt.sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df")
	self.weapon_skins.winchester1874_grunt.pattern_tweak = Vector3(1.49297, 0.469029, 1)
	self.weapon_skins.winchester1874_grunt.pattern_pos = Vector3(0.244694, 0, 0)
	self.weapon_skins.winchester1874_grunt.uv_scale = Vector3(1, 4.79177, 1)
	self.weapon_skins.winchester1874_grunt.parts = {
		wpn_fps_snp_winchester_m_standard = {
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_002_df")
			}
		},
		wpn_fps_snp_winchester_b_long = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_011_df")
			}
		},
		wpn_fps_snp_winchester_b_suppressed = {
			[Idstring("mtr_supp"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 1.57791),
				uv_scale = Vector3(20, 20, 1)
			},
			[Idstring("mtr_barrel"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_005_df"),
				uv_offset_rot = Vector3(0.310932, 1.2689, 1.54794),
				uv_scale = Vector3(3.83828, 4.98247, 1)
			}
		},
		wpn_fps_upg_winchester_o_classic = {
			[Idstring("mtr_scope"):key()] = {
				pattern_tweak = Vector3(0.249408, 1.56293, 1),
				uv_offset_rot = Vector3(0.397329, 0.907474, 4.70977),
				pattern_pos = Vector3(0, 0.31979, 0),
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_002_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_005_df"),
				uv_scale = Vector3(2.26502, 2.21734, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
				cubemap_pattern_control = Vector3(0.0150252, 0.513475, 0),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_009_df")
			}
		},
		wpn_fps_snp_winchester_body_standard = {
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_004_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			},
			[Idstring("mtr_trigger"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/flake/base_gradient/base_flake_002_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_scale = Vector3(20, 20, 1),
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		}
	}
	self.weapon_skins.winchester1874_grunt.types = {
		stock = {
			pattern_tweak = Vector3(2.11305, 0, 1),
			uv_offset_rot = Vector3(-0.250609, 1.00133, 4.71474),
			uv_scale = Vector3(1.64924, 1.21617, 0),
			pattern_pos = Vector3(0.130217, 0.0920586, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_005_df")
		},
		lower_reciever = {
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_006_df"),
			uv_offset_rot = Vector3(-0.0371959, 0.843696, 0.013),
			uv_scale = Vector3(1.31152, 2.93246, 0)
		},
		barrel = {
			pattern_tweak = Vector3(2.87622, 0, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_005_df"),
			uv_scale = Vector3(3.50456, 2.74176, 1),
			pattern_pos = Vector3(0.807537, 0.635822, 0),
			uv_offset_rot = Vector3(0.373932, 1.00341, 1.56594)
		}
	}
	self.weapon_skins.rpk_grunt = {}
	self.weapon_skins.rpk_grunt.name_id = "bm_wskn_rpk_grunt"
	self.weapon_skins.rpk_grunt.desc_id = "bm_wskn_rpk_grunt_desc"
	self.weapon_skins.rpk_grunt.weapon_id = "rpk"
	self.weapon_skins.rpk_grunt.rarity = "rare"
	self.weapon_skins.rpk_grunt.bonus = "spread_p1"
	self.weapon_skins.rpk_grunt.reserve_quality = true
	self.weapon_skins.rpk_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.rpk_grunt.base_gradient = Idstring("units/payday2_cash/safes/pack/base_gradient/base_pack_002_df")
	self.weapon_skins.rpk_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_007_df")
	self.weapon_skins.rpk_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.rpk_grunt.pattern_tweak = Vector3(1.49297, 0, 1)
	self.weapon_skins.rpk_grunt.pattern_pos = Vector3(-0.146434, -0.0605768, 0)
	self.weapon_skins.rpk_grunt.uv_scale = Vector3(1, 2.45571, 1)
	self.weapon_skins.rpk_grunt.default_blueprint = {
		"wpn_fps_lmg_rpk_b_standard",
		"wpn_fps_lmg_rpk_fg_wood",
		"wpn_lmg_rpk_m_drum",
		"wpn_fps_ass_74_body_upperreceiver",
		"wpn_fps_lmg_rpk_body_lowerreceiver",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_ak_g_wgrip",
		"wpn_fps_upg_ak_s_solidstock"
	}
	self.weapon_skins.rpk_grunt.parts = {
		wpn_fps_upg_vg_ass_smg_verticalgrip = {
			[Idstring("mtr_vertical_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern_pos = Vector3(0, 0.530885, 0)
			}
		},
		wpn_fps_upg_ass_ns_linear = {
			[Idstring("mtr_linear"):key()] = {
				pattern_tweak = Vector3(0.538996, 0, 1)
			}
		},
		wpn_fps_lmg_rpk_b_standard = {
			[Idstring("mtr_rpk_bipod"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df")
			},
			[Idstring("akm_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/gradient_france_df"),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_stubby = {
			[Idstring("stubby"):key()] = {
				pattern_tweak = Vector3(0.3959, 0, 1)
			}
		},
		wpn_fps_upg_ak_g_pgrip = {
			[Idstring("mtr_akgrip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_fps_upg_fl_ass_smg_sho_peqbox = {
			[Idstring("mtr_peqbox"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df"),
				pattern_tweak = Vector3(0.252805, 0, 1),
				pattern_pos = Vector3(0.111138, 0.282853, 0)
			}
		},
		wpn_fps_upg_ns_ass_smg_firepig = {
			[Idstring("firepig"):key()] = {
				pattern_tweak = Vector3(0.348202, 0, 1)
			}
		},
		wpn_fps_ak_bolt = {
			[Idstring("ak_base"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				uv_offset_rot = Vector3(-2, -2, 3.03145),
				uv_scale = Vector3(20, 20, 1)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_df"),
				uv_offset_rot = Vector3(0.296234, 0.979251, 1.44305),
				uv_scale = Vector3(2.50339, 2.59874, 1),
				pattern_pos = Vector3(0.0348203, 0, 0)
			}
		},
		wpn_upg_ak_s_folding = {
			[Idstring("folding"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_fl_ass_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df"),
				pattern_tweak = Vector3(0.491297, 0, 1)
			}
		},
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_ns_ass_smg_large = {
			[Idstring("silencer_large"):key()] = {
				pattern_pos = Vector3(0, 0.340091, 0)
			}
		},
		wpn_fps_upg_ns_ass_smg_medium = {
			[Idstring("medium"):key()] = {
				pattern_tweak = Vector3(0.586694, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df")
			}
		},
		wpn_fps_lmg_rpk_s_standard = {
			[Idstring("mtr_rpk_stock_plastic"):key()] = {
				uv_offset_rot = Vector3(0.177916, 1.05557, 1.51798),
				uv_scale = Vector3(2.74176, 0.977799, 1)
			}
		},
		wpn_fps_upg_fl_ass_smg_sho_surefire = {
			[Idstring("surefire"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df")
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				pattern_tweak = Vector3(0.252805, 0, 1)
			}
		},
		wpn_fps_lmg_rpk_fg_standard = {
			[Idstring("mtr_rpk_handguard_waffle"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_016_df"),
				uv_scale = Vector3(7.65226, 8.22435, 1),
				uv_offset_rot = Vector3(-0.292069, 0.817997, 0),
				pattern_tweak = Vector3(1.34987, 0, 1)
			},
			[Idstring("handguard_lower_wood"):key()] = {
				pattern_tweak = Vector3(0.109709, 0, 1),
				pattern_pos = Vector3(0, 1.82829, 0),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_fl_ass_utg = {
			[Idstring("mtr_led"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_lmg_rpk_s_wood = {
			[Idstring("mtr_rpk_stock_plastic"):key()] = {
				uv_offset_rot = Vector3(0.273313, 1.08419, 1.53296),
				uv_scale = Vector3(1.93129, 1.12082, 1)
			}
		},
		wpn_fps_lmg_rpk_body_lowerreceiver = {
			[Idstring("ak_base"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				uv_offset_rot = Vector3(-0.0605768, 0.912473, 0),
				uv_scale = Vector3(3.21851, 3.21851, 1),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_007_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_tank = {
			[Idstring("tank"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df")
			}
		},
		wpn_fps_upg_m4_s_standard = {
			[Idstring("stock_standard"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_ak_g_rk3 = {
			[Idstring("mtr_rk3"):key()] = {
				pattern_tweak = Vector3(0.968283, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_007_df")
			}
		},
		wpn_fps_lmg_rpk_fg_wood = {
			[Idstring("handguard_upper_wood"):key()] = {
				pattern_tweak = Vector3(0.825187, 0, 1),
				pattern_pos = Vector3(-1.32936, 1.17959, 0),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df")
			},
			[Idstring("aims"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_016_df"),
				uv_scale = Vector3(6.36504, 6.36504, 1),
				pattern_pos = Vector3(-0.249831, 0.572504, 0),
				uv_offset_rot = Vector3(-0.222752, 0.874315, 0)
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				uv_scale = Vector3(1.88362, 1.78827, 1)
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				pattern_tweak = Vector3(0.443599, 0, 1)
			}
		},
		wpn_fps_upg_bp_lmg_lionbipod = {
			[Idstring("mat_bipod"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df")
			}
		},
		wpn_upg_ak_s_adapter = {
			[Idstring("ak_stockadapter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_ns_ass_pbs1 = {
			[Idstring("mtr_pbs"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df"),
				pattern_tweak = Vector3(0.920584, 2.11737, 1)
			}
		}
	}
	self.weapon_skins.rpk_grunt.types = {
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_011_df"),
			uv_offset_rot = Vector3(-0.0834179, 0.993331, 4.69478),
			uv_scale = Vector3(3.69526, 8.7011, 1)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df"),
			pattern_tweak = Vector3(0.491297, 0, 1),
			pattern_pos = Vector3(0.235154, 0, 0)
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_014_df"),
			pattern_tweak = Vector3(3.06702, 0, 1)
		},
		stock = {
			pattern_pos = Vector3(0, -0.0414974, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_011_df"),
			uv_offset_rot = Vector3(-0.0436562, 0.997093, 4.70977),
			uv_scale = Vector3(1.97897, 1.21617, 1)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_b_df"),
			uv_offset_rot = Vector3(0.001, 0.740759, 0)
		},
		lower_reciever = {
			pattern_tweak = Vector3(2.39924, 0, 1),
			uv_offset_rot = Vector3(0.158837, 0.912473, 0),
			uv_scale = Vector3(9.55924, 10.7988, 1),
			pattern_pos = Vector3(-0.26945, 0.263773, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_007_df"),
			base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_014_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_002_df")
		}
	}
	self.weapon_skins.x_b92fs_grunt = {}
	self.weapon_skins.x_b92fs_grunt.name_id = "bm_wskn_x_b92fs_grunt"
	self.weapon_skins.x_b92fs_grunt.desc_id = "bm_wskn_x_b92fs_grunt_desc"
	self.weapon_skins.x_b92fs_grunt.weapon_id = "x_b92fs"
	self.weapon_skins.x_b92fs_grunt.rarity = "rare"
	self.weapon_skins.x_b92fs_grunt.bonus = "recoil_p1"
	self.weapon_skins.x_b92fs_grunt.reserve_quality = true
	self.weapon_skins.x_b92fs_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.x_b92fs_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df")
	self.weapon_skins.x_b92fs_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_006_df")
	self.weapon_skins.x_b92fs_grunt.pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_002_df")
	self.weapon_skins.x_b92fs_grunt.pattern_pos = Vector3(0, 0.263773, 0)
	self.weapon_skins.x_b92fs_grunt.default_blueprint = {
		"wpn_fps_pis_beretta_body_beretta",
		"wpn_fps_pis_beretta_b_std",
		"wpn_fps_pis_beretta_m_std",
		"wpn_fps_pis_beretta_o_std",
		"wpn_fps_upg_ns_pis_ipsccomp",
		"wpn_fps_pis_beretta_g_ergo",
		"wpn_fps_pis_beretta_sl_brigadier"
	}
	self.weapon_skins.x_b92fs_grunt.parts = {
		wpn_fps_upg_ns_pis_ipsccomp = {
			[Idstring("mtr_comp"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_e_df"),
				uv_offset_rot = Vector3(-1.83496, 0, 0),
				pattern_tweak = Vector3(1.68376, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_pis_beretta_sl_brigadier = {
			[Idstring("brig"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_004_df"),
				uv_scale = Vector3(8.27203, 8.3197, 0),
				uv_offset_rot = Vector3(0.0396615, 0.864775, 6.28319)
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_e_df"),
				cubemap_pattern_control = Vector3(0.749583, 0, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_pis_beretta_o_std = {
			[Idstring("std_sight"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_009_df")
			}
		},
		wpn_fps_pis_beretta_co_co1 = {
			[Idstring("comp_1"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_pis_beretta_m_extended = {
			[Idstring("extd"):key()] = {
				pattern_tweak = Vector3(1.34987, 0, 1),
				uv_offset_rot = Vector3(0, 0, 1.57791),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df"),
				pattern_pos = Vector3(0.177916, 0.301932, 0),
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_012_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				pattern_tweak = Vector3(1.01598, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_005_df")
			}
		},
		wpn_fps_pis_beretta_g_std = {
			[Idstring("std_grips"):key()] = {
				pattern_tweak = Vector3(0.968283, 0, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_018_df"),
				uv_scale = Vector3(0.977799, 1.02547, 0.272597),
				pattern_pos = Vector3(-0.0414974, 0.483187, 0),
				uv_offset_rot = Vector3(-0.0265768, 1.01457, 4.29019),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
			}
		},
		wpn_fps_upg_fl_pis_crimson = {
			[Idstring("mtr_crimson"):key()] = {
				pattern_tweak = Vector3(0.3959, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_c_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_pis_beretta_sl_std = {
			[Idstring("std_slide"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_c_df"),
				pattern_tweak = Vector3(1.58836, 0, 0.625566),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		},
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_pis_beretta_body_beretta = {
			[Idstring("body"):key()] = {
				uv_scale = Vector3(5.93597, 8.46273, 1)
			}
		},
		wpn_fps_upg_fl_pis_x400v = {
			[Idstring("mtr_x400v"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df"),
				pattern_tweak = Vector3(1.30217, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_005_df")
			}
		},
		wpn_fps_pis_beretta_body_rail = {
			[Idstring("front_rail"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
				pattern_pos = Vector3(0.130217, 0, 0),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_pis_beretta_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				pattern_tweak = Vector3(1.30217, 0, 1),
				uv_offset_rot = Vector3(-0.0534974, 1.02141, 4.33414),
				pattern_pos = Vector3(0.36871, -0.154974, 0),
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_df"),
				cubemap_pattern_control = Vector3(0.001, 0, 0),
				uv_scale = Vector3(0.930124, 0.977799, 0.315526),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
			}
		},
		wpn_fps_upg_fl_pis_tlr1 = {
			[Idstring("tlr1"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_c_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		},
		wpn_fps_pis_beretta_g_ergo = {
			[Idstring("ergo"):key()] = {
				pattern_tweak = Vector3(1.30217, 0, 1),
				uv_offset_rot = Vector3(-0.0534974, 1.02141, 4.33414),
				pattern_pos = Vector3(0.36871, -0.154974, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_001_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_018_df"),
				uv_scale = Vector3(0.930124, 0.977799, 0.315526),
				cubemap_pattern_control = Vector3(0.001, 0, 0),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_c_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_pis_beretta_co_co2 = {
			[Idstring("comp_2"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_d_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_pis_beretta_m_std = {
			[Idstring("std"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_d_df")
			}
		},
		wpn_fps_upg_ns_pis_small = {
			[Idstring("small"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_001_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_upg_ns_pis_medium = {
			[Idstring("medium"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		},
		wpn_fps_upg_pis_ns_flash = {
			[Idstring("mtr_flash"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
			}
		}
	}
	self.weapon_skins.x_b92fs_grunt.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_003_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df"),
			uv_offset_rot = Vector3(0.235154, 1.14635, 4.70977),
			uv_scale = Vector3(7.65226, 9.74994, 0),
			pattern_pos = Vector3(0, 0.235154, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_020_df"),
			pattern_tweak = Vector3(0, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_c_df"),
			pattern_tweak = Vector3(0.538996, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_005_df"),
			pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
			pattern_pos = Vector3(0.445028, 0.549965, 0),
			pattern_tweak = Vector3(0.968283, 2.91157, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df"),
			pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
			pattern_pos = Vector3(0.597663, 0.254234, 0),
			pattern_tweak = Vector3(1.25447, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df"),
			pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
		},
		upper_reciever = {
			pattern_tweak = Vector3(0.920584, 0, 1),
			pattern_pos = Vector3(0, 0.0252806, 0),
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_006_df"),
			pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
		}
	}
	self.weapon_skins.akmsu_grunt = {}
	self.weapon_skins.akmsu_grunt.name_id = "bm_wskn_akmsu_grunt"
	self.weapon_skins.akmsu_grunt.desc_id = "bm_wskn_akmsu_grunt_desc"
	self.weapon_skins.akmsu_grunt.weapon_id = "akmsu"
	self.weapon_skins.akmsu_grunt.rarity = "epic"
	self.weapon_skins.akmsu_grunt.bonus = "spread_p1"
	self.weapon_skins.akmsu_grunt.reserve_quality = true
	self.weapon_skins.akmsu_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.akmsu_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_016_df")
	self.weapon_skins.akmsu_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_009_df")
	self.weapon_skins.akmsu_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
	self.weapon_skins.akmsu_grunt.default_blueprint = {
		"wpn_fps_smg_akmsu_body_lowerreceiver",
		"wpn_fps_ass_akm_body_upperreceiver_vanilla",
		"wpn_fps_smg_akmsu_b_standard",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_o_ak_scopemount",
		"wpn_fps_smg_akmsu_fg_rail",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_ak_m_quad",
		"wpn_fps_upg_o_acog"
	}
	self.weapon_skins.akmsu_grunt.parts = {
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df"),
				uv_offset_rot = Vector3(0.282853, 0.988791, 0),
				uv_scale = Vector3(1.78827, 1.1685, 1)
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_offset_rot = Vector3(0.180376, 0.664441, 0),
				uv_scale = Vector3(1.59757, 2.16967, 1)
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df"),
				uv_offset_rot = Vector3(0.120678, 0.664441, 0),
				uv_scale = Vector3(2.36036, 2.16967, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df")
			}
		},
		wpn_fps_upg_ak_g_wgrip = {
			[Idstring("mtr_woodgrip"):key()] = {
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_ak_g_rk3 = {
			[Idstring("mtr_rk3"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df"),
				pattern_tweak = Vector3(1.06368, 0, 1)
			}
		},
		wpn_fps_smg_akmsu_fg_rail = {
			[Idstring("akmsu_rail"):key()] = {
				pattern_tweak = Vector3(0.872886, 0, 1),
				pattern_pos = Vector3(0.321012, 1.13189, 0)
			}
		},
		wpn_upg_ak_s_skfoldable = {
			[Idstring("sk_foldable"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_004_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df"),
				uv_scale = Vector3(1, 1.02547, 1),
				uv_offset_rot = Vector3(0.00620119, 1.2082, 0)
			}
		},
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df"),
				uv_offset_rot = Vector3(-0.0782753, 0.997871, 0),
				uv_scale = Vector3(1.21617, 1.59757, 1)
			}
		},
		wpn_fps_upg_ak_m_uspalm = {
			[Idstring("mtr_uspalm"):key()] = {
				uv_offset_rot = Vector3(0.177837, 1.18189, 5.89358),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_009_df"),
				uv_scale = Vector3(3.9813, 3.9813, 1)
			}
		},
		wpn_upg_ak_m_akm = {
			[Idstring("akm_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_003_b_df"),
				uv_offset_rot = Vector3(0.0484394, 0.832616, 0.169331),
				uv_scale = Vector3(5.64992, 5.60224, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_009_df")
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df"),
				uv_offset_rot = Vector3(0.192456, 1.00841, 0),
				uv_scale = Vector3(1.69292, 2.31269, 1),
				pattern_pos = Vector3(0.0634394, 0, 0),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_tweak = Vector3(1.15908, 0, 1),
				uv_offset_rot = Vector3(0.243154, 1.03357, 0),
				uv_scale = Vector3(1.59757, 2.16967, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_016_df")
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				uv_offset_rot = Vector3(0.157297, 0.598123, 0),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_scale = Vector3(1.74059, 1.97897, 1)
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_offset_rot = Vector3(-0.0725768, 0.992791, 0),
				uv_scale = Vector3(2.45571, 1.93129, 1)
			}
		},
		wpn_fps_upg_ns_ass_pbs1 = {
			[Idstring("mtr_pbs"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df")
			}
		},
		wpn_fps_smg_akmsu_fg_standard = {
			[Idstring("akmsu_handguard"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df")
			}
		},
		wpn_fps_upg_fl_ass_smg_sho_peqbox = {
			[Idstring("mtr_peqbox"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_scale = Vector3(1.64524, 1.97897, 1),
				uv_offset_rot = Vector3(-0.236212, 1.45532, 0)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df"),
				uv_offset_rot = Vector3(2, 2, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df"),
				pattern_tweak = Vector3(1.87455, 0, 1)
			}
		},
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df"),
				uv_offset_rot = Vector3(0.145297, 1.15697, 5.9685),
				uv_scale = Vector3(4.60108, 4.02898, 0),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_009_df")
			}
		},
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_offset_rot = Vector3(-0.0414974, 0.616743, 0),
				uv_scale = Vector3(2.31269, 1.88362, 1)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_df"),
				uv_offset_rot = Vector3(0.235154, 1.01087, 0),
				uv_scale = Vector3(1.45455, 1.1685, 0.127117),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df")
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df"),
				uv_offset_rot = Vector3(0.014, 0.997331, 0),
				uv_scale = Vector3(1.07315, 0.977799, 0.19151)
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_006_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_scale = Vector3(1.74059, 2.16967, 1),
				uv_offset_rot = Vector3(0.0920586, 1.04603, 0)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_df"),
				uv_offset_rot = Vector3(-2, -2, 0),
				uv_scale = Vector3(20, 2.02664, 1)
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_014_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_scale = Vector3(3.9813, 4.41038, 1),
				uv_offset_rot = Vector3(-0.108275, 1.02241, 3.16632)
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_offset_rot = Vector3(0.254234, 0.998331, 0),
				uv_scale = Vector3(3.79061, 4.31503, 1)
			}
		},
		wpn_fps_upg_fl_ass_utg = {
			[Idstring("mtr_led"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_004_df")
			}
		},
		wpn_upg_ak_s_psl = {
			[Idstring("psl"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df"),
				uv_offset_rot = Vector3(0.0538997, 0.998331, 0),
				uv_scale = Vector3(1.45455, 1.88362, 1)
			}
		},
		wpn_fps_upg_ak_fg_zenit = {
			[Idstring("mtr_zenit"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_tank = {
			[Idstring("tank"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df"),
				uv_scale = Vector3(1, 1, 0.999)
			}
		},
		wpn_fps_upg_ns_ass_smg_medium = {
			[Idstring("medium"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df")
			}
		},
		wpn_fps_upg_ak_g_pgrip = {
			[Idstring("mtr_akgrip"):key()] = {
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_ak_s_solidstock = {
			[Idstring("mtr_solid"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df"),
				uv_offset_rot = Vector3(0.011598, 0.99741, 0),
				uv_scale = Vector3(1.02547, 1.12082, 1)
			}
		},
		wpn_upg_ak_g_standard = {
			[Idstring("pistolgrip"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_003_df"),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_016_df"),
				pattern_pos = Vector3(-0.212212, -1.49153, 0),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_upg_m4_s_standard = {
			[Idstring("stock_standard"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_008_df"),
				uv_offset_rot = Vector3(0.0825189, 0.998331, 0),
				uv_scale = Vector3(1.21617, 1.97897, 1)
			}
		},
		wpn_fps_smg_akmsu_b_standard = {
			[Idstring("akmsu_barrel"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_001_df")
			}
		},
		wpn_fps_ass_akm_body_upperreceiver_vanilla = {
			[Idstring("cover"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_008_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_004_df")
			}
		},
		wpn_fps_upg_ak_g_hgrip = {
			[Idstring("mtr_ergoak"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df")
			}
		}
	}
	self.weapon_skins.akmsu_grunt.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_001_df"),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_007_df"),
			uv_scale = Vector3(1, 1, 0),
			pattern_pos = Vector3(0, 0.206535, 0),
			pattern_tweak = Vector3(0.968283, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_006_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df"),
			uv_offset_rot = Vector3(0.177916, 0.912854, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_016_df"),
			uv_scale = Vector3(5.41155, 8.22435, 0)
		},
		stock = {
			pattern_tweak = Vector3(1.11138, 0, 1),
			pattern_pos = Vector3(0.340091, 1.21774, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df")
		},
		magazine = {
			pattern_tweak = Vector3(1.25447, 0, 1),
			pattern_pos = Vector3(-0.0987356, 0.578584, 0)
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df"),
			pattern_tweak = Vector3(0.300503, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_009_df"),
			pattern_pos = Vector3(0, 0.406869, 0)
		},
		lower_reciever = {
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_fire_df"),
			uv_offset_rot = Vector3(-0.346768, 0.879013, 0),
			uv_scale = Vector3(9.74994, 11.1802, 1),
			pattern_pos = Vector3(0, 0.416409, 0),
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_013_df"),
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.x_1911_grunt = {}
	self.weapon_skins.x_1911_grunt.name_id = "bm_wskn_x_1911_grunt"
	self.weapon_skins.x_1911_grunt.desc_id = "bm_wskn_x_1911_grunt_desc"
	self.weapon_skins.x_1911_grunt.weapon_id = "x_1911"
	self.weapon_skins.x_1911_grunt.rarity = "epic"
	self.weapon_skins.x_1911_grunt.bonus = "recoil_p1"
	self.weapon_skins.x_1911_grunt.reserve_quality = true
	self.weapon_skins.x_1911_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.x_1911_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_015_df")
	self.weapon_skins.x_1911_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_005_df")
	self.weapon_skins.x_1911_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
	self.weapon_skins.x_1911_grunt.pattern_tweak = Vector3(0.682091, 0, 1)
	self.weapon_skins.x_1911_grunt.pattern_pos = Vector3(0, 0.483187, 0)
	self.weapon_skins.x_1911_grunt.default_blueprint = {
		"wpn_fps_pis_1911_body_standard",
		"wpn_fps_upg_ns_pis_ipsccomp",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_pis_1911_g_engraved",
		"wpn_fps_pis_1911_b_long",
		"wpn_fps_pis_1911_m_standard"
	}
	self.weapon_skins.x_1911_grunt.parts = {
		wpn_fps_pis_1911_body_standard = {
			[Idstring("body"):key()] = {
				pattern_tweak = Vector3(0.491297, 0, 1)
			}
		},
		wpn_fps_upg_ns_pis_ipsccomp = {
			[Idstring("mtr_comp"):key()] = {
				pattern_pos = Vector3(0, 1.38946, 0)
			}
		},
		wpn_fps_pis_1911_g_ergo = {
			[Idstring("grip"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_006_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_007_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				uv_offset_rot = Vector3(-0.241831, 0.874315, 4.73974),
				uv_scale = Vector3(1.12082, 0.930124, 1)
			}
		},
		wpn_fps_pis_1911_b_standard = {
			[Idstring("barrel"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			},
			[Idstring("slide"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df"),
				uv_offset_rot = Vector3(-0.127196, 1.01587, 0),
				uv_scale = Vector3(1.93129, 4.3627, 1)
			}
		},
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(-0.355308, 0.922013, 4.79968),
				uv_scale = Vector3(0.977799, 1.64524, 1)
			}
		},
		wpn_fps_upg_fl_pis_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_002_df")
			}
		},
		wpn_fps_pis_1911_b_vented = {
			[Idstring("slide_vented"):key()] = {
				uv_offset_rot = Vector3(-0.107355, 1.01787, 0),
				uv_scale = Vector3(2.36036, 4.02898, 1)
			},
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df"),
				uv_offset_rot = Vector3(-2, -2, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_002_df")
			}
		},
		wpn_fps_pis_1911_g_bling = {
			[Idstring("bling"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_006_df"),
				pattern_pos = Vector3(0.282853, 0, 0),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_008_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(-0.356308, 0.931553, 4.64983),
				uv_scale = Vector3(1, 1.21617, 1)
			}
		},
		wpn_fps_upg_fl_pis_x400v = {
			[Idstring("mtr_x400v"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_002_df")
			}
		},
		wpn_fps_pis_1911_b_long = {
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/red/base_gradient/base_red_fleur_df"),
				pattern_pos = Vector3(-0.413546, 2, 0),
				pattern_tweak = Vector3(0.0143119, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/buck/pattern/buck_pattern_005_df")
			}
		},
		wpn_fps_pis_1911_o_long = {
			[Idstring("sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df"),
				pattern_pos = Vector3(1.72335, 0.0729792, 0),
				pattern_tweak = Vector3(0.300503, 0, 1)
			}
		},
		wpn_fps_upg_fl_pis_tlr1 = {
			[Idstring("tlr1"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_002_df")
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(-0.320609, 0.873394, 4.75472),
				uv_scale = Vector3(1.07315, 1.31152, 1)
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				uv_offset_rot = Vector3(-0.326689, 0.921553, 4.70977),
				uv_scale = Vector3(1.07215, 1.74059, 1)
			}
		},
		wpn_fps_pis_1911_co_2 = {
			[Idstring("comp2"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_001_df"),
				uv_offset_rot = Vector3(2, 2, 0)
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				uv_offset_rot = Vector3(-0.356308, 0.931553, 4.73974),
				uv_scale = Vector3(1.54989, 1.97897, 1)
			}
		},
		wpn_fps_upg_ns_pis_medium = {
			[Idstring("medium"):key()] = {
				uv_offset_rot = Vector3(-0.356308, 0.864775, 4.81466),
				uv_scale = Vector3(0.882449, 1.1685, 1)
			}
		},
		wpn_fps_upg_ns_pis_small = {
			[Idstring("small"):key()] = {
				uv_offset_rot = Vector3(-0.184593, 0.893394, 4.6798),
				uv_scale = Vector3(1.07315, 1.50222, 1)
			}
		},
		wpn_fps_pis_1911_g_engraved = {
			[Idstring("mtr_engraved"):key()] = {
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/burn/pattern_gradient/gradient_burn_006_df"),
				uv_offset_rot = Vector3(-0.0128782, 0.817076, 4.72475),
				uv_scale = Vector3(4.50573, 3.55223, 0),
				pattern_pos = Vector3(0, -0.108275, 0),
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_011_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		},
		wpn_fps_pis_1911_co_1 = {
			[Idstring("comp1"):key()] = {
				uv_offset_rot = Vector3(2, 2, 0)
			}
		}
	}
	self.weapon_skins.x_1911_grunt.types = {
		barrel_ext = {
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_012_df"),
			uv_offset_rot = Vector3(-0.161053, 0.891934, 4.58989),
			uv_scale = Vector3(1.31152, 1.31152, 1)
		},
		slide = {
			sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_012_df"),
			uv_offset_rot = Vector3(-0.124292, 1.01133, 0),
			uv_scale = Vector3(2.07432, 4.31503, 1)
		}
	}
	self.weapon_skins.tecci_grunt = {}
	self.weapon_skins.tecci_grunt.name_id = "bm_wskn_tecci_grunt"
	self.weapon_skins.tecci_grunt.desc_id = "bm_wskn_tecci_grunt_desc"
	self.weapon_skins.tecci_grunt.weapon_id = "tecci"
	self.weapon_skins.tecci_grunt.rarity = "legendary"
	self.weapon_skins.tecci_grunt.bonus = "spread_p1"
	self.weapon_skins.tecci_grunt.reserve_quality = true
	self.weapon_skins.tecci_grunt.texture_bundle_folder = "cash/safes/grunt"
	self.weapon_skins.tecci_grunt.unique_name_id = "bm_wskn_tecci_grunt"
	self.weapon_skins.tecci_grunt.locked = true
	self.weapon_skins.tecci_grunt.base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_017_df")
	self.weapon_skins.tecci_grunt.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_001_df")
	self.weapon_skins.tecci_grunt.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.tecci_grunt.default_blueprint = {
		"wpn_fps_ass_tecci_dh_standard",
		"wpn_fps_ass_tecci_lower_reciever",
		"wpn_fps_ass_tecci_m_drum",
		"wpn_fps_ass_tecci_upper_reciever",
		"wpn_fps_ass_tecci_vg_standard",
		"wpn_fps_upg_m4_g_hgrip",
		"wpn_fps_upg_o_eotech",
		"wpn_fps_ass_tecci_b_legend",
		"wpn_fps_ass_tecci_fg_legend",
		"wpn_fps_ass_tecci_s_legend"
	}
	self.weapon_skins.tecci_grunt.parts = {
		wpn_fps_ass_tecci_lower_reciever = {
			[Idstring("mtr_lower"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_002_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_024_df"),
				uv_scale = Vector3(14.1837, 14.279, 0),
				uv_offset_rot = Vector3(0.12736, 0.674981, 6.28319)
			}
		},
		wpn_fps_ass_tecci_b_legend = {
			[Idstring("mtr_b_legend"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_002_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_ass_tecci_dh_standard = {
			[Idstring("mtr_drag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cf15/base_gradient/base_cf15_001_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_007_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_021_df"),
				uv_scale = Vector3(6.55574, 6.93714, 1),
				uv_offset_rot = Vector3(-7.98811E-4, 0.788918, 0),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
			}
		},
		wpn_fps_ass_tecci_upper_reciever = {
			[Idstring("mtr_upper"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_023_df"),
				uv_scale = Vector3(4.5534, 4.3627, 1),
				uv_offset_rot = Vector3(-0.0594179, 0.913934, 0),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_ass_tecci_vg_standard = {
			[Idstring("mtr_vg"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_019_df"),
				uv_scale = Vector3(2.69409, 3.12316, 0.263058),
				pattern_pos = Vector3(0.225614, 0.0825189, 0),
				uv_offset_rot = Vector3(0.0709791, 0.669981, 1.60788)
			}
		},
		wpn_fps_ass_tecci_s_legend = {
			[Idstring("mtr_s_legend"):key()] = {
				uv_offset_rot = Vector3(-0.271371, 1.00925, 6.28319),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_026_df"),
				uv_scale = Vector3(4.45805, 2.78944, 0)
			}
		},
		wpn_fps_ass_tecci_fg_legend = {
			[Idstring("mtr_fg_legend"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				uv_offset_rot = Vector3(0.248614, 0.952632, 6.28319),
				uv_scale = Vector3(11.9907, 14.6128, 0),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_025_df"),
				pattern = Idstring("units/payday2_cash/safes/bah/pattern/bah_pattern_006_df")
			}
		}
	}
	self.weapon_skins.china_lones = {}
	self.weapon_skins.china_lones.name_id = "bm_wskn_china_lones"
	self.weapon_skins.china_lones.desc_id = "bm_wskn_china_lones_desc"
	self.weapon_skins.china_lones.weapon_id = "china"
	self.weapon_skins.china_lones.rarity = "epic"
	self.weapon_skins.china_lones.bonus = "concealment_p1"
	self.weapon_skins.china_lones.reserve_quality = true
	self.weapon_skins.china_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.china_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_001_df")
	self.weapon_skins.china_lones.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_002_df")
	self.weapon_skins.china_lones.pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_002_df")
	self.weapon_skins.china_lones.pattern_tweak = Vector3(4.16408, 1.54794, 1)
	self.weapon_skins.china_lones.pattern_pos = Vector3(0, 0.321012, 0)
	self.weapon_skins.china_lones.default_blueprint = {
		"wpn_fps_gre_china_b_standard",
		"wpn_fps_gre_china_body_standard",
		"wpn_fps_gre_china_fg_standard",
		"wpn_fps_gre_m79_sight_up",
		"wpn_fps_gre_china_m_standard",
		"wpn_fps_gre_m79_grenade_whole",
		"wpn_fps_upg_a_grenade_launcher_incendiary",
		"wpn_fps_gre_china_s_standard"
	}
	self.weapon_skins.china_lones.parts = {
		wpn_fps_gre_china_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df"),
				uv_offset_rot = Vector3(0.432028, 0.839156, 0.109391),
				uv_scale = Vector3(4.98247, 3.79061, 1)
			}
		},
		wpn_fps_gre_china_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				uv_offset_rot = Vector3(0.196995, 0.960172, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_012_df"),
				uv_scale = Vector3(15.1849, 14.9465, 0)
			}
		},
		wpn_fps_gre_china_fg_standard = {
			[Idstring("mtr_fg"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_013_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		}
	}
	self.weapon_skins.china_lones.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_001_b_df"),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_013_df"),
			uv_scale = Vector3(2.04567, 2.45571, 1),
			uv_offset_rot = Vector3(-0.185053, 0.984791, 3.15133),
			pattern_tweak = Vector3(0, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
		},
		lower_receiver = {
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_013_df"),
			uv_offset_rot = Vector3(-0.0334179, 0.941093, 0.036),
			uv_scale = Vector3(3.26618, 3.9813, 1)
		}
	}
	self.weapon_skins.sparrow_lones = {}
	self.weapon_skins.sparrow_lones.name_id = "bm_wskn_sparrow_lones"
	self.weapon_skins.sparrow_lones.desc_id = "bm_wskn_sparrow_lones_desc"
	self.weapon_skins.sparrow_lones.weapon_id = "sparrow"
	self.weapon_skins.sparrow_lones.rarity = "rare"
	self.weapon_skins.sparrow_lones.bonus = "spread_p1"
	self.weapon_skins.sparrow_lones.reserve_quality = true
	self.weapon_skins.sparrow_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.sparrow_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_002_df")
	self.weapon_skins.sparrow_lones.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_001_df")
	self.weapon_skins.sparrow_lones.pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_002_df")
	self.weapon_skins.sparrow_lones.pattern_tweak = Vector3(3.92559, 1.57788, 1)
	self.weapon_skins.sparrow_lones.pattern_pos = Vector3(0.246773, -0.358847, 0)
	self.weapon_skins.sparrow_lones.default_blueprint = {
		"wpn_fps_pis_sparrow_g_dummy",
		"wpn_fps_pis_sparrow_m_standard",
		"wpn_fps_pis_sparrow_sl_rpl",
		"wpn_fps_pis_sparrow_b_threaded",
		"wpn_fps_upg_ns_pis_ipsccomp",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_pis_sparrow_body_941",
		"wpn_fps_upg_o_rmr"
	}
	self.weapon_skins.sparrow_lones.parts = {
		wpn_fps_pis_sparrow_g_cowboy = {
			[Idstring("mtr_cowboy"):key()] = {
				uv_offset_rot = Vector3(-0.108275, 1.01387, 4.73974),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_008_b_df"),
				uv_scale = Vector3(1.21617, 1.26385, 1)
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				uv_offset_rot = Vector3(-0.01, 1.03749, 0),
				uv_scale = Vector3(2.07432, 1.3592, 1)
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				uv_offset_rot = Vector3(-0.121196, 1.06611, 0),
				uv_scale = Vector3(2.93246, 1.12082, 1)
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(0.0538997, 1.01925, 0),
				uv_scale = Vector3(0.882449, 1.59757, 1)
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				uv_offset_rot = Vector3(0.0348203, 1.01741, 0),
				uv_scale = Vector3(1.88362, 2.02664, 1)
			}
		},
		wpn_fps_pis_sparrow_g_dummy = {
			[Idstring("mtr_grips"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_008_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/shared/pattern/pattern_acryl_001_df")
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0),
				uv_scale = Vector3(0.977799, 1.64524, 1)
			}
		},
		wpn_fps_pis_sparrow_body_rpl = {
			[Idstring("mtr_frame_rpl"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_008_b_df"),
				uv_offset_rot = Vector3(-0.146434, 0.514187, 1.27822),
				uv_scale = Vector3(2.45571, 1.31152, 1)
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				uv_offset_rot = Vector3(0, 1.02949, 0),
				uv_scale = Vector3(1.26385, 2.12199, 1)
			}
		}
	}
	self.weapon_skins.sparrow_lones.types = {
		slide = {
			uv_offset_rot = Vector3(0.0548997, 1.00233, 0),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_001_df"),
			uv_scale = Vector3(1.54989, 2.69409, 1)
		},
		barrel_ext = {
			pattern_tweak = Vector3(1.96995, 1.56293, 1),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_003_df"),
			uv_scale = Vector3(1.97897, 1.59757, 1),
			pattern_pos = Vector3(-0.0128782, -0.356308, 0),
			uv_offset_rot = Vector3(-0.0319576, 1.00033, 0)
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_002_b_df")
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_002_b_df")
		},
		grip = {
			uv_offset_rot = Vector3(0.0538997, 1.02295, 4.6828),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_008_df"),
			uv_scale = Vector3(0.632401, 0.753425, 0)
		}
	}
	self.weapon_skins.judge_lones = {}
	self.weapon_skins.judge_lones.name_id = "bm_wskn_judge_lones"
	self.weapon_skins.judge_lones.desc_id = "bm_wskn_judge_lones_desc"
	self.weapon_skins.judge_lones.weapon_id = "judge"
	self.weapon_skins.judge_lones.rarity = "rare"
	self.weapon_skins.judge_lones.bonus = "concealment_p1"
	self.weapon_skins.judge_lones.reserve_quality = true
	self.weapon_skins.judge_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.judge_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_003_df")
	self.weapon_skins.judge_lones.default_blueprint = {
		"wpn_fps_pis_judge_body_standard",
		"wpn_fps_pis_judge_b_standard",
		"wpn_fps_pis_judge_g_standard",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_upg_o_reflex",
		"wpn_fps_upg_fl_ass_smg_sho_peqbox"
	}
	self.weapon_skins.judge_lones.parts = {
		wpn_fps_upg_ns_shot_shark = {
			[Idstring("shark"):key()] = {
				uv_offset_rot = Vector3(-0.206593, 0.889473, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_010_df"),
				uv_scale = Vector3(2.93246, 3.07549, 1)
			}
		},
		wpn_fps_upg_shot_ns_king = {
			[Idstring("mtr_king"):key()] = {
				uv_offset_rot = Vector3(-0.191053, 0.830156, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_010_df"),
				uv_scale = Vector3(2.98014, 3.59991, 1)
			}
		},
		wpn_fps_upg_ns_shot_thick = {
			[Idstring("thick"):key()] = {
				uv_offset_rot = Vector3(-0.0128782, 0.879315, 0.0224661),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_010_df"),
				uv_scale = Vector3(5.69759, 6.31736, 1)
			}
		},
		wpn_fps_pis_judge_body_standard = {
			[Idstring("mtr_cylinder"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_006_df"),
				pattern_pos = Vector3(0.0252806, 0.0157409, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_001_df"),
				pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_001_df")
			},
			[Idstring("mtr_frame"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_003_df")
			}
		},
		wpn_fps_upg_ns_sho_salvo_large = {
			[Idstring("mtr_salvo_large"):key()] = {
				uv_offset_rot = Vector3(0.00620119, 0.826616, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_010_df"),
				uv_scale = Vector3(3.83828, 4.12433, 1)
			}
		},
		wpn_fps_pis_judge_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_003_d_df"),
				uv_offset_rot = Vector3(-0.0540371, 1.00833, 4.70977),
				uv_scale = Vector3(2.55106, 2.69409, 1),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_010_df")
			}
		}
	}
	self.weapon_skins.x_mp5_lones = {}
	self.weapon_skins.x_mp5_lones.name_id = "bm_wskn_x_mp5_lones"
	self.weapon_skins.x_mp5_lones.desc_id = "bm_wskn_x_mp5_lones_desc"
	self.weapon_skins.x_mp5_lones.weapon_id = "x_mp5"
	self.weapon_skins.x_mp5_lones.rarity = "rare"
	self.weapon_skins.x_mp5_lones.bonus = "recoil_p1"
	self.weapon_skins.x_mp5_lones.reserve_quality = true
	self.weapon_skins.x_mp5_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.x_mp5_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_df")
	self.weapon_skins.x_mp5_lones.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df")
	self.weapon_skins.x_mp5_lones.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.weapon_skins.x_mp5_lones.pattern_tweak = Vector3(1.58836, 0, 0.212974)
	self.weapon_skins.x_mp5_lones.default_blueprint = {
		"wpn_fps_smg_mp5_body_mp5",
		"wpn_fps_smg_mp5_s_ring_vanilla",
		"wpn_fps_smg_mp5_m_std",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_fl_ass_smg_sho_peqbox",
		"wpn_fps_smg_mp5_fg_mp5a5"
	}
	self.weapon_skins.x_mp5_lones.parts = {
		wpn_fps_upg_ass_ns_linear = {
			[Idstring("mtr_linear"):key()] = {
				pattern_tweak = Vector3(0.72979, 0, 1)
			}
		},
		wpn_fps_upg_ns_ass_smg_stubby = {
			[Idstring("stubby"):key()] = {
				pattern_tweak = Vector3(0.491297, 0, 1)
			}
		},
		wpn_fps_upg_ns_ass_smg_firepig = {
			[Idstring("firepig"):key()] = {
				pattern_tweak = Vector3(0.3959, 0, 1)
			}
		},
		wpn_fps_upg_ass_ns_battle = {
			[Idstring("mtr_battle"):key()] = {
				pattern_tweak = Vector3(0.777489, 0, 1)
			}
		},
		wpn_fps_smg_mp5_fg_mp5a4 = {
			[Idstring("mp5a4"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_df"),
				uv_offset_rot = Vector3(-2, -2, 4.66981),
				uv_scale = Vector3(20, 20, 1),
				pattern_pos = Vector3(0, 0.006, 0),
				pattern_tweak = Vector3(1.82686, 0, 1)
			}
		},
		wpn_fps_smg_mp5_fg_mp5sd = {
			[Idstring("mtr_sd"):key()] = {
				uv_offset_rot = Vector3(-0.652039, 1.36014, 1.56293),
				uv_scale = Vector3(2.16967, 1.1685, 0)
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				pattern_tweak = Vector3(0.682091, 0, 1)
			}
		},
		wpn_fps_smg_mp5_fg_m5k = {
			[Idstring("mp5k"):key()] = {
				uv_offset_rot = Vector3(-0.232292, 1.01741, 0),
				uv_scale = Vector3(2.02664, 6.36504, 1)
			}
		},
		wpn_fps_smg_mp5_s_ring_vanilla = {
			[Idstring("ring"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_c_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_small = {
			[Idstring("small"):key()] = {
				pattern_tweak = Vector3(0.72979, 0, 1)
			}
		},
		wpn_fps_upg_ns_ass_smg_large = {
			[Idstring("silencer_large"):key()] = {
				pattern_tweak = Vector3(0.872886, 0, 1)
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_003_df"),
				uv_offset_rot = Vector3(-0.59734, 0.797997, 6.26619),
				pattern_tweak = Vector3(0.777489, 0, 1),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_004_df")
			}
		}
	}
	self.weapon_skins.x_mp5_lones.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_005_df"),
			uv_offset_rot = Vector3(-0.130736, 1.02849, 1.56293),
			uv_scale = Vector3(2.16967, 1.60059, 0),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_004_df"),
			pattern_tweak = Vector3(0, 0, 1)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_df"),
			uv_offset_rot = Vector3(0.0494394, 1.01541, 0),
			uv_scale = Vector3(2.02664, 1.75927, 0),
			pattern_pos = Vector3(0.38779, 0.0825189, 0),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_005_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_001_df"),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_009_df"),
			uv_scale = Vector3(20, 20, 1),
			pattern_tweak = Vector3(1.01598, 0, 1),
			uv_offset_rot = Vector3(0.302392, 0.555504, 0.37912)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_df")
		},
		gadget = {
			pattern_tweak = Vector3(0.538996, 0, 1),
			pattern_pos = Vector3(0.673981, 0.216075, 0)
		}
	}
	self.weapon_skins.akmsu_lones = {}
	self.weapon_skins.akmsu_lones.name_id = "bm_wskn_akmsu_lones"
	self.weapon_skins.akmsu_lones.desc_id = "bm_wskn_akmsu_lones_desc"
	self.weapon_skins.akmsu_lones.weapon_id = "akmsu"
	self.weapon_skins.akmsu_lones.rarity = "rare"
	self.weapon_skins.akmsu_lones.bonus = "spread_p1"
	self.weapon_skins.akmsu_lones.reserve_quality = true
	self.weapon_skins.akmsu_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.akmsu_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_df")
	self.weapon_skins.akmsu_lones.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_005_df")
	self.weapon_skins.akmsu_lones.pattern_tweak = Vector3(1.77916, 2.37212, 1)
	self.weapon_skins.akmsu_lones.default_blueprint = {
		"wpn_fps_smg_akmsu_body_lowerreceiver",
		"wpn_fps_ass_akm_body_upperreceiver_vanilla",
		"wpn_fps_smg_akmsu_b_standard",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_upg_o_ak_scopemount",
		"wpn_fps_smg_akmsu_fg_rail",
		"wpn_fps_upg_ak_s_solidstock",
		"wpn_fps_upg_ak_m_quad",
		"wpn_fps_upg_o_cs"
	}
	self.weapon_skins.akmsu_lones.parts = {
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				uv_offset_rot = Vector3(-0.146434, 0.915013, 0)
			}
		},
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				uv_offset_rot = Vector3(-2, 2, 0)
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				uv_scale = Vector3(2.31269, 1.97897, 1)
			}
		},
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				uv_offset_rot = Vector3(-0.27045, 0.931553, 0),
				uv_scale = Vector3(8.3197, 10.2744, 1)
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				uv_offset_rot = Vector3(0.0920586, 0.960172, 0),
				uv_scale = Vector3(11.0372, 11.4186, 1)
			}
		},
		wpn_fps_upg_ak_m_uspalm = {
			[Idstring("mtr_uspalm"):key()] = {
				uv_offset_rot = Vector3(0.139757, 0.941093, 0.0194812),
				uv_scale = Vector3(4.98247, 6.50806, 1)
			}
		},
		wpn_upg_ak_m_akm = {
			[Idstring("akm_mag"):key()] = {
				uv_offset_rot = Vector3(0.149297, 0.616743, 0.648849),
				uv_scale = Vector3(8.22435, 8.03365, 1)
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				uv_offset_rot = Vector3(0.04436, 0.845696, 0.25924),
				uv_scale = Vector3(8.7011, 8.74877, 1)
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				uv_offset_rot = Vector3(0.231154, 0.923013, 0.274225),
				uv_scale = Vector3(10.7511, 13.9453, 1)
			}
		},
		wpn_upg_ak_s_psl = {
			[Idstring("psl"):key()] = {
				uv_offset_rot = Vector3(-0.0891959, 0.910474, 0),
				uv_scale = Vector3(4.7441, 4.64875, 1)
			}
		},
		wpn_fps_upg_ak_fg_zenit = {
			[Idstring("mtr_zenit"):key()] = {
				uv_offset_rot = Vector3(-0.163514, 0.912473, 0)
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				uv_offset_rot = Vector3(0.120678, 0.902934, 0.274225),
				uv_scale = Vector3(9.51157, 8.7011, 1)
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		},
		wpn_fps_upg_ak_m_quick = {
			[Idstring("mtr_magpul"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_010_df"),
				uv_offset_rot = Vector3(0.397329, 1.01141, 4.72475),
				uv_scale = Vector3(4.69642, 1.02547, 1),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_014_df")
			},
			[Idstring("ak74_mag"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0.394105),
				uv_scale = Vector3(7.03248, 3.74293, 1)
			}
		},
		wpn_fps_upg_m4_s_standard = {
			[Idstring("stock_standard"):key()] = {
				uv_offset_rot = Vector3(-0.127815, 0.930013, 0),
				uv_scale = Vector3(7.27086, 8.03365, 1)
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				uv_offset_rot = Vector3(-2, -2, 0)
			}
		}
	}
	self.weapon_skins.akmsu_lones.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_d_df"),
			uv_offset_rot = Vector3(0.189217, 0.897013, 6.28319),
			uv_scale = Vector3(7.89063, 11.8, 0)
		},
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_b_df"),
			uv_offset_rot = Vector3(-0.191593, 0.893394, 0),
			uv_scale = Vector3(11.4186, 9.70227, 1),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_011_df"),
			pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_003_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/cop/base_gradient/base_cop_spikey_df")
		},
		extra = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_006_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_b_df"),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_011_df"),
			uv_scale = Vector3(4.45805, 5.1255, 0),
			pattern_pos = Vector3(0.177916, 0.04436, 0),
			pattern_tweak = Vector3(1.82686, 0, 1),
			uv_offset_rot = Vector3(-0.260911, 0.883854, 6.28319),
			pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_003_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_005_b_df"),
			uv_offset_rot = Vector3(-0.00579881, 0.967172, 1.56293),
			uv_scale = Vector3(2.02764, 2.16967, 0.18674),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_014_df"),
			pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_003_df")
		},
		sight = {
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_015_df"),
			uv_offset_rot = Vector3(0.0348203, 0.910474, 3.39109),
			uv_scale = Vector3(6.69876, 6.84179, 0.18197)
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
		}
	}
	self.weapon_skins.par_lones = {}
	self.weapon_skins.par_lones.name_id = "bm_wskn_par_lones"
	self.weapon_skins.par_lones.desc_id = "bm_wskn_par_lones_desc"
	self.weapon_skins.par_lones.weapon_id = "par"
	self.weapon_skins.par_lones.rarity = "epic"
	self.weapon_skins.par_lones.bonus = "recoil_p1"
	self.weapon_skins.par_lones.reserve_quality = true
	self.weapon_skins.par_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.par_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_006_df")
	self.weapon_skins.par_lones.default_blueprint = {
		"wpn_fps_lmg_par_body_standard",
		"wpn_fps_lmg_par_m_standard",
		"wpn_fps_lmg_par_upper_reciever",
		"wpn_fps_upg_ass_ns_surefire",
		"wpn_fps_lmg_par_s_plastic",
		"wpn_fps_lmg_par_b_short"
	}
	self.weapon_skins.par_lones.parts = {
		wpn_fps_lmg_par_body_standard = {
			[Idstring("mtr_body"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/pattern_gradient_camo_snow_001_df"),
				uv_offset_rot = Vector3(-0.0635768, 0.971712, 6.2682),
				uv_scale = Vector3(12.4197, 12.4674, 0)
			},
			[Idstring("mtr_sight"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_001_df")
			}
		},
		wpn_fps_lmg_par_upper_reciever = {
			[Idstring("mtr_dustcover"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/grunt/base_gradient/base_grunt_011_df"),
				uv_offset_rot = Vector3(-0.0414974, 1.00033, 4.70977),
				uv_scale = Vector3(18.2837, 16.6151, 1),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_017_df")
			}
		},
		wpn_fps_lmg_par_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				pattern_tweak = Vector3(2.11305, 0, 0),
				uv_offset_rot = Vector3(-0.0278782, 0.7006, 6.01346),
				pattern_pos = Vector3(0.425948, 0.975712, 0),
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_006_d_df"),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_018_df"),
				uv_scale = Vector3(12.1814, 9.98832, 0.265443),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/pattern_gradient_camo_snow_001_df"),
				pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_008_df")
			}
		}
	}
	self.weapon_skins.par_lones.types = {
		stock = {
			pattern_tweak = Vector3(3.21011, 0, 1),
			uv_offset_rot = Vector3(-0.30545, 0.952172, 0.139361),
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_016_df"),
			uv_scale = Vector3(7.22318, 8.65342, 0.232054)
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/cola/base_gradient/base_cola_005_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_006_c_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_006_b_df"),
			cubemap_pattern_control = Vector3(0.325066, 0.513475, 0),
			pattern_pos = Vector3(0.241614, 0.594203, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/surf/pattern_gradient/gradient_surf_001_df"),
			pattern_tweak = Vector3(5.97663, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/dallas/pattern/pattern_wood_df")
		}
	}
	self.weapon_skins.model70_lones = {}
	self.weapon_skins.model70_lones.name_id = "bm_wskn_model70_lones"
	self.weapon_skins.model70_lones.desc_id = "bm_wskn_model70_lones_desc"
	self.weapon_skins.model70_lones.weapon_id = "model70"
	self.weapon_skins.model70_lones.rarity = "epic"
	self.weapon_skins.model70_lones.bonus = "recoil_p1"
	self.weapon_skins.model70_lones.reserve_quality = true
	self.weapon_skins.model70_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.model70_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_007_df")
	self.weapon_skins.model70_lones.sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_001_df")
	self.weapon_skins.model70_lones.default_blueprint = {
		"wpn_fps_snp_model70_b_standard",
		"wpn_fps_snp_model70_body_standard",
		"wpn_fps_snp_model70_s_standard",
		"wpn_fps_snp_model70_m_standard",
		"wpn_fps_upg_o_leupold"
	}
	self.weapon_skins.model70_lones.parts = {
		wpn_fps_snp_model70_b_standard = {
			[Idstring("mtr_sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_007_c_df")
			},
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_007_b_df"),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_002_df"),
				uv_scale = Vector3(0.01, 0.01, 1),
				uv_offset_rot = Vector3(-0.260911, 2, 3.66082)
			}
		}
	}
	self.weapon_skins.model70_lones.types = {
		stock = {
			sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_002_df"),
			uv_offset_rot = Vector3(-0.0204179, 1.20204, 0.513984),
			uv_scale = Vector3(0.915819, 0.676076, 0.372764)
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_009_df"),
			uv_offset_rot = Vector3(0, -2, 0)
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_007_b_df")
		}
	}
	self.weapon_skins.serbu_lones = {}
	self.weapon_skins.serbu_lones.name_id = "bm_wskn_serbu_lones"
	self.weapon_skins.serbu_lones.desc_id = "bm_wskn_serbu_lones_desc"
	self.weapon_skins.serbu_lones.weapon_id = "serbu"
	self.weapon_skins.serbu_lones.rarity = "legendary"
	self.weapon_skins.serbu_lones.bonus = "spread_n1"
	self.weapon_skins.serbu_lones.reserve_quality = true
	self.weapon_skins.serbu_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.serbu_lones.unique_name_id = "bm_wskn_serbu_lones"
	self.weapon_skins.serbu_lones.locked = true
	self.weapon_skins.serbu_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_008_df")
	self.weapon_skins.serbu_lones.pattern_tweak = Vector3(0, 0, 1)
	self.weapon_skins.serbu_lones.default_blueprint = {
		"wpn_fps_shot_r870_body_standard",
		"wpn_fps_shot_shorty_b_legendary",
		"wpn_fps_shot_shorty_fg_legendary",
		"wpn_fps_shot_shorty_s_legendary",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_upg_a_custom_free",
		"wpn_fps_upg_o_reflex"
	}
	self.weapon_skins.serbu_lones.parts = {
		wpn_fps_shot_shorty_s_legendary = {
			[Idstring("mtr_grip"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_005_df"),
				uv_offset_rot = Vector3(-0.224672, 0.998331, 6.27319),
				uv_scale = Vector3(10.6558, 1.69292, 0),
				pattern_tweak = Vector3(0, 0, 1),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_024_df")
			}
		},
		wpn_fps_shot_shorty_b_legendary = {
			[Idstring("short_barrel"):key()] = {
				pattern_tweak = Vector3(8.12306, 0, 1),
				cubemap_pattern_control = Vector3(0.325066, 0.468161, 0),
				uv_scale = Vector3(5.45922, 5.45922, 1),
				uv_offset_rot = Vector3(2, 1.3513, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_004_df")
			},
			[Idstring("mtr_comp"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_005_df"),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_025_df"),
				uv_scale = Vector3(2.45571, 3.07549, 1),
				uv_offset_rot = Vector3(-0.0335768, 0.808537, 0),
				pattern_tweak = Vector3(1.58836, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df")
			}
		},
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				pattern_tweak = Vector3(3.21011, 0, 1),
				cubemap_pattern_control = Vector3(1, 1, 0),
				uv_scale = Vector3(3.79061, 2.74176, 1),
				uv_offset_rot = Vector3(0.198995, 0.825235, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_019_df"),
				pattern = Idstring("units/payday2_cash/safes/cola/pattern/cola_pattern_005_df")
			}
		},
		wpn_fps_shot_shorty_fg_legendary = {
			[Idstring("mtr_fg"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				pattern_tweak = Vector3(1.58836, 0, 1)
			}
		}
	}
	self.weapon_skins.serbu_lones.types = {
		lower_reciever = {
			uv_offset_rot = Vector3(0, -0.0128782, 0)
		}
	}
	self.weapon_skins.new_m14_lones = {}
	self.weapon_skins.new_m14_lones.name_id = "bm_wskn_new_m14_lones"
	self.weapon_skins.new_m14_lones.desc_id = "bm_wskn_new_m14_lones_desc"
	self.weapon_skins.new_m14_lones.weapon_id = "new_m14"
	self.weapon_skins.new_m14_lones.rarity = "legendary"
	self.weapon_skins.new_m14_lones.bonus = "recoil_p1"
	self.weapon_skins.new_m14_lones.reserve_quality = true
	self.weapon_skins.new_m14_lones.texture_bundle_folder = "cash/safes/lones"
	self.weapon_skins.new_m14_lones.unique_name_id = "bm_wskn_new_m14_lones"
	self.weapon_skins.new_m14_lones.locked = true
	self.weapon_skins.new_m14_lones.base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_009_df")
	self.weapon_skins.new_m14_lones.pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_003_df")
	self.weapon_skins.new_m14_lones.pattern_tweak = Vector3(11.9389, 0, 1)
	self.weapon_skins.new_m14_lones.default_blueprint = {
		"wpn_fps_ass_m14_b_legendary",
		"wpn_fps_ass_m14_body_lower_legendary",
		"wpn_fps_ass_m14_body_upper_legendary",
		"wpn_fps_ass_m14_m_standard",
		"wpn_fps_ass_m14_body_legendary",
		"wpn_fps_upg_o_m14_scopemount",
		"wpn_fps_upg_o_acog",
		"wpn_fps_upg_ns_ass_smg_medium"
	}
	self.weapon_skins.new_m14_lones.parts = {
		wpn_fps_ass_m14_body_legendary = {
			[Idstring("mtr_body"):key()] = {
				pattern_tweak = Vector3(0.72979, 6.28319, 1),
				uv_offset_rot = Vector3(0.0495189, 1.01641, 6.23823),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_021_df"),
				uv_scale = Vector3(1.26385, 3.74293, 1),
				pattern_pos = Vector3(-0.165514, -0.117815, 0),
				cubemap_pattern_control = Vector3(0.382304, 0.456237, 0),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_020_df")
			},
			[Idstring("mtr_stock"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_009_c_df")
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_011_df"),
				uv_offset_rot = Vector3(0.117678, 0.796918, 3.15133),
				uv_scale = Vector3(6.55574, 5.03015, 0.150966)
			}
		},
		wpn_fps_ass_m14_b_legendary = {
			[Idstring("mtr_barrel"):key()] = {
				pattern_tweak = Vector3(1.20678, 0.184315, 1),
				uv_offset_rot = Vector3(0.0192806, 1.06157, 3.13635),
				pattern_pos = Vector3(-0.519483, -0.169974, 0),
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_009_c_df"),
				cubemap_pattern_control = Vector3(0, 0.001, 0),
				uv_scale = Vector3(11.4186, 10.179, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_022_df"),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_017_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_001_b_df"),
				uv_offset_rot = Vector3(0.150837, 1.04087, 0),
				uv_scale = Vector3(3.69526, 2.83711, 0.899833),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_023_df")
			}
		},
		wpn_fps_upg_o_m14_scopemount = {
			[Idstring("mtr_mount"):key()] = {
				uv_offset_rot = Vector3(0.008, 0.71214, 0),
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_026_df"),
				uv_scale = Vector3(2.21734, 2.64641, 1)
			}
		},
		wpn_fps_ass_m14_body_upper_legendary = {
			[Idstring("base"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_001_b_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_003_df"),
				pattern_pos = Vector3(0.0729792, -0.0224179, 0),
				pattern_tweak = Vector3(0.872886, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_017_df")
			}
		},
		wpn_fps_ass_m14_m_standard = {
			[Idstring("mag"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_020_df"),
				uv_scale = Vector3(2.26502, 1.07315, 1),
				cubemap_pattern_control = Vector3(0, 0.804436, 0),
				uv_offset_rot = Vector3(0.0227409, 0.999251, 0.0194812)
			}
		},
		wpn_fps_ass_m14_body_lower_legendary = {
			[Idstring("lower1"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/gradient_france_df"),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_014_df")
			}
		},
		wpn_fps_upg_ns_ass_smg_medium = {
			[Idstring("medium"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dallas/base_gradient/base_dallas_003_df"),
				uv_offset_rot = Vector3(0.002, 1.01741, 1.60788),
				uv_scale = Vector3(1.69292, 0.977799, 1),
				pattern_pos = Vector3(0.750298, 1.22728, 0),
				pattern_tweak = Vector3(0.3959, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/burn/pattern/burn_pattern_018_df")
			}
		}
	}
	self.weapon_skins.x_1911_smosh = {}
	self.weapon_skins.x_1911_smosh.name_id = "bm_wskn_x_1911_smosh"
	self.weapon_skins.x_1911_smosh.desc_id = "bm_wskn_x_1911_smosh_desc"
	self.weapon_skins.x_1911_smosh.weapon_id = "x_1911"
	self.weapon_skins.x_1911_smosh.rarity = "common"
	self.weapon_skins.x_1911_smosh.bonus = "recoil_p1"
	self.weapon_skins.x_1911_smosh.reserve_quality = true
	self.weapon_skins.x_1911_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.x_1911_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_e_df"
	self.weapon_skins.x_1911_smosh.parts = {
		wpn_fps_pis_1911_co_1 = {
			[Idstring("comp1"):key()] = {
				pattern_tweak = Vector3(0.348202, 1.84764, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_f_df",
				pattern_pos = Vector3(-0.60434, 0, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_002_df"
			}
		},
		wpn_fps_pis_1911_b_vented = {
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df")
			},
			[Idstring("slide_vented"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_f_df"
			}
		},
		wpn_fps_pis_1911_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_df"
			}
		},
		wpn_fps_upg_fl_pis_x400v = {
			[Idstring("mtr_x400v"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
			}
		},
		wpn_fps_pis_1911_b_long = {
			[Idstring("slide_long"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_f_df"
			},
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df")
			}
		},
		wpn_upg_o_marksmansight_front = {
			[Idstring("front1"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
			}
		},
		wpn_fps_pis_1911_o_standard = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_e_df"
			}
		},
		wpn_fps_pis_1911_co_2 = {
			[Idstring("comp2"):key()] = {
				pattern_tweak = Vector3(0.443599, 1.69779, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_f_df",
				pattern_pos = Vector3(-0.384927, 0.902934, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_002_df"
			}
		},
		wpn_fps_upg_ns_pis_medium = {
			[Idstring("medium"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
			}
		},
		wpn_upg_o_marksmansight_rear = {
			[Idstring("rear"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
			}
		},
		wpn_fps_pis_1911_g_bling = {
			[Idstring("bling"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_b_df"
			}
		},
		wpn_fps_pis_1911_body_standard = {
			[Idstring("body"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
				pattern_tweak = Vector3(2.44694, 4.75472, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_002_df"
			}
		}
	}
	self.weapon_skins.x_1911_smosh.types = {
		slide = {
			pattern_tweak = Vector3(2.82853, 1.96752, 1),
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_e_df",
			pattern_pos = Vector3(0.0920584, 0, 0),
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_002_df"
		},
		barrel_ext = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
		},
		gadget = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_002_c_df"
		}
	}
	self.weapon_skins.scar_smosh = {}
	self.weapon_skins.scar_smosh.name_id = "bm_wskn_scar_smosh"
	self.weapon_skins.scar_smosh.desc_id = "bm_wskn_scar_smosh_desc"
	self.weapon_skins.scar_smosh.weapon_id = "scar"
	self.weapon_skins.scar_smosh.rarity = "common"
	self.weapon_skins.scar_smosh.bonus = "spread_p1"
	self.weapon_skins.scar_smosh.reserve_quality = true
	self.weapon_skins.scar_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.scar_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_df"
	self.weapon_skins.scar_smosh.parts = {
		wpn_fps_ass_scar_s_standard = {
			[Idstring("mtr_stock"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/smosh/sticker/smosh_sticker_003_df"),
				uv_offset_rot = Vector3(-2, -2, 0),
				uv_scale = Vector3(5.41155, 5.93597, 1)
			}
		},
		wpn_fps_upg_ass_ns_jprifles = {
			[Idstring("mtr_jprifles"):key()] = {
				cubemap_pattern_control = Vector3(0, 0.016, 0)
			}
		},
		wpn_fps_ass_scar_s_sniper = {
			[Idstring("mtr_sniper"):key()] = {
				uv_offset_rot = Vector3(-0.0434975, 0.764758, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_003_df",
				uv_scale = Vector3(3.3949, 3.3949, 1)
			}
		},
		wpn_fps_ass_scar_body_standard = {
			[Idstring("mtr_railcover"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
				pattern_pos = Vector3(-0.213212, 0, 0),
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_003_df"
			},
			[Idstring("mtr_lower"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df"
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
				pattern_pos = Vector3(0.530885, 0.511806, 0),
				pattern_tweak = Vector3(1.15908, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_003_df"
			}
		},
		wpn_fps_ass_scar_fg_railext = {
			[Idstring("mtr_rail_ext"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_002_df"),
				uv_offset_rot = Vector3(0.111138, 1.20066, 0),
				uv_scale = Vector3(5.58094, 5.58094, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_003_b_df"
			}
		}
	}
	self.weapon_skins.scar_smosh.types = {
		barrel = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
			pattern_tweak = Vector3(1.68376, 0, 1),
			pattern_pos = Vector3(0.130217, 0.817076, 0),
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_003_df"
		},
		foregrip = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
			pattern_tweak = Vector3(1.44527, 0, 1),
			pattern_pos = Vector3(0.511806, 0.69306, 0),
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_003_df"
		},
		barrel_ext = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
			pattern_tweak = Vector3(0.72979, 0, 1),
			pattern_pos = Vector3(0.807537, 0.0538995, 0),
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_003_df"
		},
		upper_reciever = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_002_df",
			pattern_tweak = Vector3(2.20844, 0, 1),
			pattern_pos = Vector3(-0.365848, 1.63749, 0),
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_003_df"
		}
	}
	self.weapon_skins.colt_1911_smosh = {}
	self.weapon_skins.colt_1911_smosh.name_id = "bm_wskn_colt_1911_smosh"
	self.weapon_skins.colt_1911_smosh.desc_id = "bm_wskn_colt_1911_smosh_desc"
	self.weapon_skins.colt_1911_smosh.weapon_id = "colt_1911"
	self.weapon_skins.colt_1911_smosh.rarity = "common"
	self.weapon_skins.colt_1911_smosh.bonus = "spread_p1"
	self.weapon_skins.colt_1911_smosh.reserve_quality = true
	self.weapon_skins.colt_1911_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.colt_1911_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_d_df"
	self.weapon_skins.colt_1911_smosh.parts = {
		wpn_fps_pis_1911_body_standard = {
			[Idstring("body"):key()] = {
				sticker = Idstring("units/payday2_cash/safes/lones/sticker/lones_sticker_004_df")
			}
		},
		wpn_fps_pis_1911_b_vented = {
			[Idstring("slide_vented"):key()] = {
				uv_offset_rot = Vector3(-0.0540372, 0.942092, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_004_df",
				uv_scale = Vector3(7.97167, 7.97167, 1)
			},
			[Idstring("barrel_vented"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_d_df"
			}
		},
		wpn_fps_pis_1911_g_ergo = {
			[Idstring("ergo"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_b_df"
			}
		},
		wpn_fps_pis_1911_b_standard = {
			[Idstring("slide"):key()] = {
				uv_offset_rot = Vector3(-0.0484975, 0.934553, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_004_df",
				uv_scale = Vector3(6.63678, 6.63678, 1)
			},
			[Idstring("barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_d_df"
			}
		},
		wpn_fps_pis_1911_b_long = {
			[Idstring("slide_long"):key()] = {
				uv_offset_rot = Vector3(-0.0796562, 0.939093, 0),
				sticker = Idstring("units/payday2_cash/safes/smosh/sticker/smosh_sticker_004_df"),
				uv_scale = Vector3(6.96951, 6.96951, 1)
			},
			[Idstring("barrel_vented"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_d_df"
			}
		},
		wpn_fps_pis_1911_o_standard = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_c_df"
			}
		}
	}
	self.weapon_skins.colt_1911_smosh.types = {
		slide = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_b_df"
		},
		lower_reciever = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_df"
		},
		magazine = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_003_c_df"
		}
	}
	self.weapon_skins.scorpion_smosh = {}
	self.weapon_skins.scorpion_smosh.name_id = "bm_wskn_scorpion_smosh"
	self.weapon_skins.scorpion_smosh.desc_id = "bm_wskn_scorpion_smosh_desc"
	self.weapon_skins.scorpion_smosh.weapon_id = "scorpion"
	self.weapon_skins.scorpion_smosh.rarity = "common"
	self.weapon_skins.scorpion_smosh.bonus = "spread_p1"
	self.weapon_skins.scorpion_smosh.reserve_quality = true
	self.weapon_skins.scorpion_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.scorpion_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_006_b_df"
	self.weapon_skins.scorpion_smosh.parts = {
		wpn_fps_upg_ass_ns_linear = {
			[Idstring("mtr_linear"):key()] = {
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_006_df",
				uv_offset_rot = Vector3(0.340091, 0.998331, 0),
				uv_scale = Vector3(2.72746, 2.72746, 0)
			}
		},
		wpn_fps_upg_ns_ass_smg_small = {
			[Idstring("small"):key()] = {
				pattern_tweak = Vector3(3.92559, 1.56293, 0),
				uv_offset_rot = Vector3(0.365, 1.399, 0),
				pattern_pos = Vector3(0, -0.251371, 0),
				uv_scale = Vector3(4.06235, 4.06235, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_006_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_006_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_006_df"
			}
		},
		wpn_fps_smg_scorpion_b_suppressed = {
			[Idstring("mtr_supp"):key()] = {
				pattern_tweak = Vector3(5.92893, 1.59, 0),
				uv_offset_rot = Vector3(0.417, 0.725, 0),
				pattern_pos = Vector3(0.0538995, 0.196995, 0),
				uv_scale = Vector3(6.68446, 6.68446, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_006_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_006_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_006_df"
			}
		},
		wpn_fps_smg_scorpion_body_standard = {
			[Idstring("mtr_lower"):key()] = {
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_006_b_df",
				uv_offset_rot = Vector3(-0.375387, 0.912473, 0),
				uv_scale = Vector3(15.7426, 15.7426, 0.110422)
			},
			[Idstring("mtr_upper"):key()] = {
				pattern_tweak = Vector3(7.12139, 0, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_006_df",
				pattern_pos = Vector3(0.0348201, -0.346768, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_006_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_006_df"
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				pattern_tweak = Vector3(1.34987, 1.5929, 1),
				uv_offset_rot = Vector3(0.36871, 1.37038, 0),
				pattern_pos = Vector3(1.38946, 0.120677, 0),
				uv_scale = Vector3(3.44258, 3.44258, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_006_b_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_006_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_006_df"
			}
		}
	}
	self.weapon_skins.scorpion_smosh.types = {
		stock = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_006_df"
		},
		grip = {
			pattern_pos = Vector3(0, -0.203673, 0),
			pattern_tweak = Vector3(4.25948, 0, 0),
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_006_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_006_b_df"
		},
		barrel_ext = {
			pattern_tweak = Vector3(2.16075, 1.48, 0),
			pattern_pos = Vector3(0.301932, 1.23682, 0),
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_006_df",
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_006_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_006_df"
		}
	}
	self.weapon_skins.deagle_smosh = {}
	self.weapon_skins.deagle_smosh.name_id = "bm_wskn_deagle_smosh"
	self.weapon_skins.deagle_smosh.desc_id = "bm_wskn_deagle_smosh_desc"
	self.weapon_skins.deagle_smosh.weapon_id = "deagle"
	self.weapon_skins.deagle_smosh.rarity = "uncommon"
	self.weapon_skins.deagle_smosh.bonus = "spread_p1"
	self.weapon_skins.deagle_smosh.reserve_quality = true
	self.weapon_skins.deagle_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.deagle_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
	self.weapon_skins.deagle_smosh.parts = {
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_aug_df"
			}
		},
		wpn_fps_pis_deagle_g_bling = {
			[Idstring("bling"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_c_df",
				pattern_tweak = Vector3(1, 0, 0),
				pattern_pos = Vector3(-0.221673, -0.008, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_gadget_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_d_df"
			}
		},
		wpn_fps_upg_ns_pis_meatgrinder = {
			[Idstring("mtr_strikeface"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_rail_df"
			}
		},
		wpn_upg_o_marksmansight_rear = {
			[Idstring("rear"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_replacer_df"
			}
		},
		wpn_fps_upg_o_rmr = {
			[Idstring("mtr_rmr"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_sightlittle_df"
			}
		},
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_gadget_df"
			}
		},
		wpn_fps_upg_fl_pis_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_smallgadget_df"
			}
		},
		wpn_fps_pis_deagle_o_standard_front = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_gadget_df",
				cubemap_pattern_control = Vector3(0.379919, 1, 0),
				pattern_tweak = Vector3(2.34454, 0, 1),
				pattern_pos = Vector3(0.572044, 0.713679, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_c_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_h_df"
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_aug_df"
			}
		},
		wpn_fps_pis_deagle_b_standard = {
			[Idstring("barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_pis_deagle_o_standard_rear = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_pis_deagle_b_long = {
			[Idstring("longbarrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_ns_pis_small = {
			[Idstring("small"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_fl_pis_tlr1 = {
			[Idstring("tlr1"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_smallgadget_df",
				pattern_pos = Vector3(-0.0585769, 0.012, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_c_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_f_df"
			}
		},
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_barrelext_df"
			}
		},
		wpn_fps_upg_ns_pis_ipsccomp = {
			[Idstring("mtr_comp"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_barrelextlast_df"
			}
		},
		wpn_fps_pis_deagle_o_standard_front_long = {
			[Idstring("sights"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_ns_ass_filter = {
			[Idstring("mtr_filter"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/lones/base_gradient/base_lones_001_b_df"),
				uv_offset_rot = Vector3(-0.00133858, 0.759838, 0),
				uv_scale = Vector3(1.01, 1.01, 0.375149),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_008_b_df"
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_pis_deagle_g_ergo = {
			[Idstring("grip"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_df",
				pattern_tweak = Vector3(1, 0, 0),
				pattern_pos = Vector3(-0.160974, 0.007, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_grip_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_d_df"
			},
			[Idstring("ergo"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_grip_df"
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_barrelextlast_df"
			}
		},
		wpn_fps_pis_deagle_co_short = {
			[Idstring("comp2"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_barrelext_df"
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_quad_df"
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_replacer_df",
				cubemap_pattern_control = Vector3(0, 1, 0),
				pattern_tweak = Vector3(1, 0, 0),
				pattern_pos = Vector3(-0.0746564, 0.0478995, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_b_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_g_df"
			}
		},
		wpn_fps_upg_ns_pis_medium = {
			[Idstring("medium"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/dinner/base_gradient/base_assault_004_df")
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_aug_df"
			}
		},
		wpn_fps_pis_deagle_co_long = {
			[Idstring("comp1"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_barrelext_df"
			}
		},
		wpn_upg_o_marksmansight_front = {
			[Idstring("front1"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		},
		wpn_fps_upg_fl_pis_crimson = {
			[Idstring("mtr_crimson"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_gadget_df"
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_b_df",
				pattern_tweak = Vector3(1, 6.23823, 1),
				pattern_pos = Vector3(-0.186895, 0.127757, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_df"
			}
		},
		wpn_fps_upg_fl_pis_x400v = {
			[Idstring("mtr_x400v"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_gadgetflash_df",
				pattern_pos = Vector3(0.0634394, 0.062979, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_e_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_b_df"
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_holo_df",
				uv_offset_rot = Vector3(-0.393467, 1.403, 0),
				uv_scale = Vector3(3.87165, 3.87165, 0.1772),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_008_df"
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				pattern_tweak = Vector3(1.001, 0, 0),
				uv_offset_rot = Vector3(0.390869, 1.38546, 0),
				pattern_pos = Vector3(-0.333149, 0.431488, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_aug_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_008_c_df",
				uv_scale = Vector3(3.82398, 3.82398, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_e_df"
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				pattern_tweak = Vector3(1.001, 0, 0),
				uv_offset_rot = Vector3(-0.246831, 1.18612, 0),
				pattern_pos = Vector3(-0.0756564, 0.0785188, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_aug_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_008_c_df",
				uv_scale = Vector3(7.78097, 7.78097, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_e_df"
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_aug_df"
			}
		},
		wpn_fps_upg_ns_pis_large_kac = {
			[Idstring("silencer"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_rail_df"
			}
		},
		wpn_fps_pis_deagle_body_standard = {
			[Idstring("base"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_lower_df"
			}
		},
		wpn_fps_upg_ns_pis_jungle = {
			[Idstring("mtr_jungle"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_barrelextlast_df"
			}
		},
		wpn_fps_pis_deagle_g_standard = {
			[Idstring("grip"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_008_df",
				pattern_tweak = Vector3(1, 0, 0.492011),
				pattern_pos = Vector3(0.0488995, 0.005, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_grip_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_008_c_df"
			}
		},
		wpn_fps_pis_deagle_m_standard = {
			[Idstring("mag"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_rail_df"
			}
		},
		wpn_fps_pis_deagle_m_extended = {
			[Idstring("extended_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_008_df")
			}
		},
		wpn_fps_pis_rage_o_adapter = {
			[Idstring("mtr_rail"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_extra_df"
			}
		},
		wpn_fps_pis_deagle_fg_rail = {
			[Idstring("rail"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_rail_df"
			}
		},
		wpn_fps_upg_pis_ns_flash = {
			[Idstring("mtr_flash"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_008_df"
			}
		}
	}
	self.weapon_skins.r870_smosh = {}
	self.weapon_skins.r870_smosh.name_id = "bm_wskn_r870_smosh"
	self.weapon_skins.r870_smosh.desc_id = "bm_wskn_r870_smosh_desc"
	self.weapon_skins.r870_smosh.weapon_id = "r870"
	self.weapon_skins.r870_smosh.rarity = "common"
	self.weapon_skins.r870_smosh.bonus = "spread_n1"
	self.weapon_skins.r870_smosh.reserve_quality = true
	self.weapon_skins.r870_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.r870_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_010_df"
	self.weapon_skins.r870_smosh.pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_010_df"
	self.weapon_skins.r870_smosh.parts = {
		wpn_fps_shot_r870_b_long = {
			[Idstring("long_barrel"):key()] = {
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_010_d_df"
			}
		},
		wpn_fps_shot_r870_fg_big = {
			[Idstring("big_pump"):key()] = {
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_010_e_df"
			}
		},
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_010_b_df"
			}
		},
		wpn_fps_shot_r870_s_solid_vanilla = {
			[Idstring("solid"):key()] = {
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_010_c_df"
			}
		},
		wpn_fps_upg_m4_g_standard = {
			[Idstring("standard_grip"):key()] = {
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_010_df"
			}
		}
	}
	self.weapon_skins.m32_smosh = {}
	self.weapon_skins.m32_smosh.name_id = "bm_wskn_m32_smosh"
	self.weapon_skins.m32_smosh.desc_id = "bm_wskn_m32_smosh_desc"
	self.weapon_skins.m32_smosh.weapon_id = "m32"
	self.weapon_skins.m32_smosh.rarity = "uncommon"
	self.weapon_skins.m32_smosh.bonus = "concealment_p1"
	self.weapon_skins.m32_smosh.reserve_quality = true
	self.weapon_skins.m32_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.m32_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_011_df"
	self.weapon_skins.m32_smosh.parts = {
		wpn_fps_gre_m32_barrel = {
			[Idstring("body"):key()] = {
				pattern_pos = Vector3(-1.47245, -0.241831, 0),
				pattern_tweak = Vector3(2.20844, 0, 0.611257),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_011_df"
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_gre_m32_upper_reciever = {
			[Idstring("body"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_011_b_df"
			}
		}
	}
	self.weapon_skins.m32_smosh.types = {
		lower_reciever = {
			uv_offset_rot = Vector3(-0.203673, 1.04603, 1.87761),
			sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_011_b_df",
			uv_scale = Vector3(16.3624, 16.3624, 0.389459)
		},
		magazine = {
			pattern_tweak = Vector3(2.87622, 0, 1),
			sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_011_df",
			uv_scale = Vector3(10.4984, 10.4984, 1),
			pattern_pos = Vector3(-0.260911, 0.111138, 0),
			uv_offset_rot = Vector3(-0.0414975, 1.02695, 5.80367),
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_011_df"
		}
	}
	self.weapon_skins.hs2000_smosh = {}
	self.weapon_skins.hs2000_smosh.name_id = "bm_wskn_hs2000_smosh"
	self.weapon_skins.hs2000_smosh.desc_id = "bm_wskn_hs2000_smosh_desc"
	self.weapon_skins.hs2000_smosh.weapon_id = "hs2000"
	self.weapon_skins.hs2000_smosh.rarity = "rare"
	self.weapon_skins.hs2000_smosh.bonus = "spread_p1"
	self.weapon_skins.hs2000_smosh.reserve_quality = true
	self.weapon_skins.hs2000_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.hs2000_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_012_df"
	self.weapon_skins.hs2000_smosh.default_blueprint = {
		"wpn_fps_pis_hs2000_body_standard",
		"wpn_fps_pis_hs2000_m_extended",
		"wpn_fps_upg_o_rmr",
		"wpn_fps_pis_hs2000_sl_custom",
		"wpn_fps_upg_ns_pis_large",
		"wpn_fps_upg_fl_pis_m3x"
	}
	self.weapon_skins.hs2000_smosh.parts = {
		wpn_fps_upg_fl_pis_m3x = {
			[Idstring("mtr_m3x"):key()] = {
				uv_offset_rot = Vector3(0.36871, 0.998331, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_g_df",
				uv_scale = Vector3(6.97051, 6.97051, 1)
			}
		},
		wpn_fps_pis_hs2000_sl_standard = {
			[Idstring("mtr_sl_standard"):key()] = {
				uv_offset_rot = Vector3(0.101598, 0.988791, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_b_df",
				uv_scale = Vector3(1.44024, 1.44024, 0.539709)
			}
		},
		wpn_fps_upg_fl_pis_x400v = {
			[Idstring("mtr_x400v"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_012_b_df",
				uv_offset_rot = Vector3(0.387789, 0.654901, 0),
				uv_scale = Vector3(7.01818, 7.01818, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_g_df"
			}
		},
		wpn_fps_upg_fl_pis_tlr1 = {
			[Idstring("tlr1"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_012_b_df",
				uv_offset_rot = Vector3(0.36871, 0.712139, 0),
				uv_scale = Vector3(5.68329, 5.68329, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_g_df"
			}
		},
		wpn_fps_upg_fl_pis_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_012_b_df"
			}
		},
		wpn_fps_upg_ns_pis_medium_gem = {
			[Idstring("silencer"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_012_b_df"
			}
		},
		wpn_fps_upg_ns_pis_large = {
			[Idstring("large"):key()] = {
				uv_offset_rot = Vector3(0.0252805, 1.13189, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_e_df",
				uv_scale = Vector3(1.05884, 1.05884, 0.592178)
			}
		},
		wpn_fps_pis_hs2000_body_standard = {
			[Idstring("mtr_body_standard"):key()] = {
				uv_offset_rot = Vector3(0.0443599, 0.998331, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_d_df",
				uv_scale = Vector3(1.72629, 1.72629, 0.508705)
			}
		},
		wpn_fps_pis_hs2000_m_extended = {
			[Idstring("mtr_m_extended"):key()] = {
				uv_offset_rot = Vector3(-0.153894, 0.988791, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_f_df",
				uv_scale = Vector3(2.88479, 2.83711, 0)
			}
		},
		wpn_fps_upg_ns_pis_medium_slim = {
			[Idstring("silencer"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_012_b_df"
			}
		},
		wpn_fps_pis_hs2000_sl_custom = {
			[Idstring("mtr_sl_custom"):key()] = {
				uv_offset_rot = Vector3(0.0634394, 1.02695, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_df",
				uv_scale = Vector3(1.39257, 1.39257, 0.534939)
			}
		},
		wpn_fps_pis_hs2000_sl_long = {
			[Idstring("mtr_sl_long"):key()] = {
				uv_offset_rot = Vector3(0.111138, 0.988791, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_012_c_df",
				uv_scale = Vector3(1.67861, 1.67861, 0.577868)
			}
		}
	}
	self.weapon_skins.saw_smosh = {}
	self.weapon_skins.saw_smosh.name_id = "bm_wskn_saw_smosh"
	self.weapon_skins.saw_smosh.desc_id = "bm_wskn_saw_smosh_desc"
	self.weapon_skins.saw_smosh.weapon_id = "saw"
	self.weapon_skins.saw_smosh.weapon_ids = {
		"saw",
		"saw_secondary"
	}
	self.weapon_skins.saw_smosh.rarity = "uncommon"
	self.weapon_skins.saw_smosh.bonus = "concealment_p1"
	self.weapon_skins.saw_smosh.reserve_quality = true
	self.weapon_skins.saw_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.saw_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_d_df"
	self.weapon_skins.saw_smosh.parts = {
		wpn_fps_saw_body_speed = {
			[Idstring("mtr_fast_motor"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_b_df"
			},
			[Idstring("mtr_saw"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_c_df"
			}
		},
		wpn_fps_saw_body_silent = {
			[Idstring("mtr_silent"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_f_df"
			},
			[Idstring("mtr_silent_motor"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_e_df"
			}
		},
		wpn_fps_saw_m_blade = {
			[Idstring("mtr_blade"):key()] = {
				pattern_tweak = Vector3(1.30217, 0.738758, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_013_b_df",
				pattern_pos = Vector3(0.349631, -0.00333858, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_013_df"
			}
		},
		wpn_fps_saw_m_blade_sharp = {
			[Idstring("mtr_blade"):key()] = {},
			[Idstring("mtr_blade_sharp"):key()] = {
				pattern_tweak = Vector3(1.15908, 2.74674, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_013_c_df",
				pattern_pos = Vector3(0.511806, -0.919151, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_013_df"
			}
		},
		wpn_fps_saw_m_blade_durable = {
			[Idstring("mtr_blade"):key()] = {},
			[Idstring("mtr_blade_durable"):key()] = {
				pattern_tweak = Vector3(1.20678, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_013_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_013_df",
				pattern_pos = Vector3(-0.356308, 0.0634394, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_013_df"
			}
		}
	}
	self.weapon_skins.saw_smosh.types = {
		lower_reciever = {},
		upper_reciever = {}
	}
	self.weapon_skins.m1928_smosh = {}
	self.weapon_skins.m1928_smosh.name_id = "bm_wskn_m1928_smosh"
	self.weapon_skins.m1928_smosh.desc_id = "bm_wskn_m1928_smosh_desc"
	self.weapon_skins.m1928_smosh.weapon_id = "m1928"
	self.weapon_skins.m1928_smosh.rarity = "uncommon"
	self.weapon_skins.m1928_smosh.bonus = "spread_p1"
	self.weapon_skins.m1928_smosh.reserve_quality = true
	self.weapon_skins.m1928_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.m1928_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_c_df"
	self.weapon_skins.m1928_smosh.pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_015_d_df"
	self.weapon_skins.m1928_smosh.pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
	self.weapon_skins.m1928_smosh.parts = {
		wpn_fps_smg_thompson_drummag = {
			[Idstring("mtr_mag"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_015_c_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_e_df",
				uv_offset_rot = Vector3(0.0825188, 1.09373, 0),
				uv_scale = Vector3(4.82514, 4.82514, 1),
				cubemap_pattern_control = Vector3(0.582638, 1, 0),
				pattern_tweak = Vector3(4.73647, 0, 0.630336),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_df"
			}
		},
		wpn_fps_smg_thompson_stock_discrete = {
			[Idstring("mtr_stock"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_df",
				pattern_tweak = Vector3(2.44694, 1.57791, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_df",
				uv_scale = Vector3(2.20304, 1.39257, 1),
				uv_offset_rot = Vector3(-0.0701165, 0.998331, 0),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_015_b_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				pattern_tweak = Vector3(0, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_smg_thompson_grip = {
			[Idstring("mtr_grip"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_b_df",
				uv_offset_rot = Vector3(0, 1.21774, 3.76572),
				uv_scale = Vector3(5.34957, 5.34957, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_e_df",
				pattern_tweak = Vector3(0.825187, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		},
		wpn_fps_smg_thompson_foregrip_discrete = {
			[Idstring("mtr_fg"):key()] = {
				pattern_pos = Vector3(-0.423086, -0.62342, 0),
				pattern_tweak = Vector3(1.15908, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		},
		wpn_fps_smg_thompson_stock = {
			[Idstring("mtr_stock"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_b_df",
				uv_offset_rot = Vector3(-0.0701165, 0.998331, 0),
				uv_scale = Vector3(2.10769, 1.34489, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_b_df",
				pattern_tweak = Vector3(2.01765, 1.60788, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		},
		wpn_fps_smg_thompson_foregrip = {
			[Idstring("mtr_fg"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_015_df",
				pattern_tweak = Vector3(1.58836, 0, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_e_df",
				uv_scale = Vector3(9.16354, 9.16354, 1),
				uv_offset_rot = Vector3(0.196995, 0.855235, 4.73974),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_b_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		},
		wpn_fps_smg_thompson_barrel = {
			[Idstring("mtr_barrel"):key()] = {
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_c_df"
			}
		},
		wpn_fps_smg_thompson_grip_discrete = {
			[Idstring("mtr_grip"):key()] = {
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		},
		wpn_fps_smg_thompson_body = {
			[Idstring("mtr_body"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_015_df",
				uv_offset_rot = Vector3(-0.0796564, 0.998331, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_015_d_df",
				uv_scale = Vector3(2.01234, 2.82281, 1),
				pattern_pos = Vector3(-2, -2, 0),
				pattern_tweak = Vector3(2.11305, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_b_df"
			}
		},
		wpn_fps_smg_thompson_ns_standard = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_d_df",
				pattern_tweak = Vector3(0.348202, 0, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_015_c_df"
			}
		}
	}
	self.weapon_skins.m1928_smosh.types = {
		gadget = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_015_d_df"
		}
	}
	self.weapon_skins.mateba_smosh = {}
	self.weapon_skins.mateba_smosh.name_id = "bm_wskn_mateba_smosh"
	self.weapon_skins.mateba_smosh.desc_id = "bm_wskn_mateba_smosh_desc"
	self.weapon_skins.mateba_smosh.weapon_id = "mateba"
	self.weapon_skins.mateba_smosh.rarity = "epic"
	self.weapon_skins.mateba_smosh.bonus = "spread_p1"
	self.weapon_skins.mateba_smosh.reserve_quality = true
	self.weapon_skins.mateba_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.mateba_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_016_df"
	self.weapon_skins.mateba_smosh.default_blueprint = {
		"wpn_fps_pis_2006m_body_standard",
		"wpn_fps_pis_2006m_m_standard",
		"wpn_fps_pis_2006m_b_long",
		"wpn_fps_pis_2006m_g_bling",
		"wpn_fps_upg_fl_pis_crimson"
	}
	self.weapon_skins.mateba_smosh.parts = {
		wpn_fps_pis_2006m_fl_adapter = {
			[Idstring("mtr_adapter"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(0.187455, -0.043418, 0),
				pattern_tweak = Vector3(1, 3.15133, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_df"
			}
		},
		wpn_fps_pis_2006m_b_long = {
			[Idstring("mtr_barrel_long"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-0.0345769, -0.0460372, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_b_df"
			}
		},
		wpn_fps_pis_2006m_g_bling = {
			[Idstring("mtr_grip"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(0.147217, -0.530943, 0),
				pattern_tweak = Vector3(0.967981, 5.10242, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_e_df"
			}
		},
		wpn_fps_pis_2006m_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-0.890532, -0.728356, 0),
				pattern_tweak = Vector3(0.824488, 5.00947, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_g_df"
			}
		},
		wpn_fps_pis_2006m_b_short = {
			[Idstring("mtr_barrel_short"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-0.004, -0.003, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_f_df"
			}
		},
		wpn_fps_pis_2006m_b_medium = {
			[Idstring("mtr_barrel_medium"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-0.0144975, -0.363768, 0),
				pattern_tweak = Vector3(0.634393, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_d_df"
			}
		},
		wpn_fps_pis_2006m_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-1.53723, -1.1291, 0),
				pattern_tweak = Vector3(0.920584, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_h_df"
			}
		},
		wpn_fps_pis_2006m_b_standard = {
			[Idstring("mtr_barrel"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-0.0390372, -0.05, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_c_df"
			}
		},
		wpn_fps_pis_2006m_body_standard = {
			[Idstring("mtr_body"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_016_df",
				pattern_pos = Vector3(-1.51061, -0.0466564, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_016_df"
			}
		}
	}
	self.weapon_skins.new_raging_bull_smosh = {}
	self.weapon_skins.new_raging_bull_smosh.name_id = "bm_wskn_new_raging_bull_smosh"
	self.weapon_skins.new_raging_bull_smosh.desc_id = "bm_wskn_new_raging_bull_smosh_desc"
	self.weapon_skins.new_raging_bull_smosh.weapon_id = "new_raging_bull"
	self.weapon_skins.new_raging_bull_smosh.rarity = "legendary"
	self.weapon_skins.new_raging_bull_smosh.locked = false
	self.weapon_skins.new_raging_bull_smosh.bonus = "spread_p1"
	self.weapon_skins.new_raging_bull_smosh.reserve_quality = true
	self.weapon_skins.new_raging_bull_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.new_raging_bull_smosh.unique_name_id = "bm_wskn_new_raging_bull_smosh"
	self.weapon_skins.new_raging_bull_smosh.default_blueprint = {
		"wpn_fps_pis_rage_body_standard",
		"wpn_fps_pis_rage_b_long",
		"wpn_fps_pis_rage_extra",
		"wpn_fps_pis_rage_g_standard"
	}
	self.weapon_skins.new_raging_bull_smosh.parts = {
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_pis_rage_g_ergo = {
			[Idstring("ergo"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_017_e_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_i_df",
				uv_offset_rot = Vector3(0.0634394, 1.04603, 0.0194812),
				uv_scale = Vector3(1.05884, 1.05884, 1),
				pattern_tweak = Vector3(3.44861, 0, 0.203434),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_f_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_017_df"
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_pis_rage_g_standard = {
			[Idstring("grip"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_017_d_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_f_df",
				uv_offset_rot = Vector3(0.0348201, 0.979251, 0),
				uv_scale = Vector3(1.39257, 1.39257, 1),
				pattern_tweak = Vector3(0, 0, 0.806821),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_f_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_017_df"
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_pis_rage_b_comp1 = {
			[Idstring("comp1"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_e_df",
				uv_offset_rot = Vector3(-0.0605769, 1.07465, 0),
				uv_scale = Vector3(1.15419, 1.15419, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_b_df"
			}
		},
		wpn_fps_pis_rage_body_standard = {
			[Idstring("rearsight"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_f_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_j_df",
				uv_offset_rot = Vector3(-0.022418, 1.23682, 0)
			},
			[Idstring("cylinder"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_d_df",
				uv_offset_rot = Vector3(-0.136895, 1.04603, 0),
				uv_scale = Vector3(0.963495, 0.963495, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_g_df"
			},
			[Idstring("base"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_b_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_l_df",
				uv_offset_rot = Vector3(-0.337228, 1.00787, 0)
			},
			[Idstring("lock"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_b_df"
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_b_df"
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_aimpoint_2 = {
			[Idstring("aimpoint"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_pis_rage_b_long = {
			[Idstring("barrel_long"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_d_df",
				uv_offset_rot = Vector3(0.111138, 1.03649, 0),
				uv_scale = Vector3(0.677446, 0.677446, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_d_df"
			}
		},
		wpn_fps_pis_rage_body_smooth = {
			[Idstring("smooth"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_h_df",
				uv_offset_rot = Vector3(0.206535, 1.57071, 0),
				uv_scale = Vector3(0.963495, 0.963495, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_h_df"
			},
			[Idstring("lock"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_017_c_df",
				pattern_tweak = Vector3(0.0620104, 0, 1),
				pattern_pos = Vector3(-2, -0.451705, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_017_b_df"
			},
			[Idstring("rearsight"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_f_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_j_df",
				uv_offset_rot = Vector3(-0.022418, 1.23682, 0)
			},
			[Idstring("base"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_017_c_df",
				pattern_tweak = Vector3(0.205106, 0, 1),
				uv_offset_rot = Vector3(-0.337228, 1.00787, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_l_df",
				pattern_pos = Vector3(0.139757, -1.59647, 0),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_017_b_df"
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_c_df"
			}
		},
		wpn_fps_pis_rage_b_standard = {
			[Idstring("barrel_standard"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_d_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_df",
				uv_scale = Vector3(1.10652, 1.10652, 1),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_017_b_df",
				uv_offset_rot = Vector3(0.0538995, 1.07465, 0)
			}
		},
		wpn_fps_pis_rage_b_short = {
			[Idstring("barrel_short"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_d_df",
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_e_df",
				uv_scale = Vector3(0.820469, 0.820469, 1),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_017_df",
				uv_offset_rot = Vector3(0.330551, 1.10327, 0)
			}
		},
		wpn_fps_pis_rage_b_comp2 = {
			[Idstring("comp2"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_e_df",
				uv_offset_rot = Vector3(-0.022418, 1.08419, 0),
				uv_scale = Vector3(1.05884, 1.05884, 1),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_017_c_df"
			}
		},
		wpn_fps_pis_rage_o_adapter = {
			[Idstring("mtr_rail"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_g_df"
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df")
			}
		},
		wpn_fps_upg_pis_ns_flash = {
			[Idstring("mtr_flash"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_017_f_df"
			}
		}
	}
	self.weapon_skins.polymer_smosh = {}
	self.weapon_skins.polymer_smosh.name_id = "bm_wskn_polymer_smosh"
	self.weapon_skins.polymer_smosh.desc_id = "bm_wskn_polymer_smosh_desc"
	self.weapon_skins.polymer_smosh.weapon_id = "polymer"
	self.weapon_skins.polymer_smosh.rarity = "rare"
	self.weapon_skins.polymer_smosh.bonus = "spread_p1"
	self.weapon_skins.polymer_smosh.reserve_quality = true
	self.weapon_skins.polymer_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.polymer_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
	self.weapon_skins.polymer_smosh.default_blueprint = {
		"wpn_fps_smg_polymer_body_standard",
		"wpn_fps_smg_polymer_bolt_standard",
		"wpn_fps_smg_polymer_dh_standard",
		"wpn_fps_smg_polymer_extra_sling",
		"wpn_fps_smg_polymer_fg_standard",
		"wpn_fps_smg_polymer_barrel_standard",
		"wpn_fps_smg_polymer_m_standard",
		"wpn_fps_upg_o_cs",
		"wpn_fps_upg_m4_s_ubr",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_upg_fl_ass_utg"
	}
	self.weapon_skins.polymer_smosh.parts = {
		wpn_fps_upg_m4_s_mk46 = {
			[Idstring("mtr_crane_mk46"):key()] = {
				pattern_tweak = Vector3(2.63773, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern_pos = Vector3(0.00620103, -0.0128784, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_docter = {
			[Idstring("docter"):key()] = {
				pattern_tweak = Vector3(1.44527, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0, 0.0538995, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_rx01 = {
			[Idstring("rx01"):key()] = {
				pattern_tweak = Vector3(1.73146, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(-0.0128784, 0, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_eotech = {
			[Idstring("mtr_eotech"):key()] = {
				pattern_tweak = Vector3(1.77916, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0, -0.0605769, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_smg_polymer_s_adapter = {
			[Idstring("mtr_adapter"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_upg_o_cmore = {
			[Idstring("cmore"):key()] = {
				pattern_tweak = Vector3(1.06368, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0, -0.155974, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_reflex = {
			[Idstring("reflex"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_tweak = Vector3(1.63606, 0, 1),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_smg_polymer_body_standard = {
			[Idstring("mtr_body"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_tweak = Vector3(4.49797, 0, 1),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_smg_polymer_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_smg_polymer_bolt_standard = {
			[Idstring("mtr_bolt"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_upg_o_eotech_xps = {
			[Idstring("eotech"):key()] = {
				pattern_tweak = Vector3(1.58836, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(-0.0128784, -0.0414975, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_ns_ass_smg_small = {
			[Idstring("small"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_upg_ns_ass_smg_large = {
			[Idstring("silencer_large"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df"
			}
		},
		wpn_fps_smg_polymer_s_standard = {
			[Idstring("mtr_stock"):key()] = {
				pattern_tweak = Vector3(3.25781, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern_pos = Vector3(0, -0.089196, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_m4_s_crane = {
			[Idstring("mtr_lmt"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_tweak = Vector3(2.06535, 0, 1),
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_specter = {
			[Idstring("mtr_specter"):key()] = {
				pattern_tweak = Vector3(2.11305, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0, -0.0701165, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_ass_ns_surefire = {
			[Idstring("mtr_surefire"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_upg_o_cs = {
			[Idstring("mtr_cs"):key()] = {
				pattern_tweak = Vector3(2.11305, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0.0252805, -0.0319577, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_smg_polymer_barrel_precision = {
			[Idstring("mtr_precision"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df"
			}
		},
		wpn_fps_upg_o_t1micro = {
			[Idstring("mtr_t1micro"):key()] = {
				pattern_tweak = Vector3(1.30217, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(-0.0128784, -0.27045, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_m4_s_standard = {
			[Idstring("stock_standard"):key()] = {
				pattern_tweak = Vector3(2.16075, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern_pos = Vector3(0.254233, 0.0825188, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_tweak = Vector3(1.82686, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0, -0.0319577, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_m4_s_pts = {
			[Idstring("stock_pts"):key()] = {
				pattern_tweak = Vector3(2.01765, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern_pos = Vector3(0.0348201, -0.108275, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_o_rx30 = {
			[Idstring("rx30"):key()] = {
				pattern_tweak = Vector3(1.87455, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(-0.0701165, -0.0796564, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_m4_s_ubr = {
			[Idstring("mtr_ubr"):key()] = {
				pattern_tweak = Vector3(3.16242, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern_pos = Vector3(0, 0.072979, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_smg_polymer_o_iron = {
			[Idstring("mtr_dd"):key()] = {
				pattern_tweak = Vector3(1.96995, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_b_df",
				pattern_pos = Vector3(0.0252805, -0.136895, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_fl_ass_utg = {
			[Idstring("mtr_led"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_smg_polymer_barrel_standard = {
			[Idstring("mtr_barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		},
		wpn_fps_upg_o_aimpoint = {
			[Idstring("aimpoint"):key()] = {
				pattern_tweak = Vector3(2.49464, 0, 1),
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df",
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_018_df",
				pattern_pos = Vector3(0.101598, -0.108275, 0),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_018_df"
			}
		},
		wpn_fps_upg_ns_ass_smg_medium = {
			[Idstring("medium"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_df"
			}
		}
	}
	self.weapon_skins.polymer_smosh.types = {
		barrel_ext = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df"
		},
		gadget = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df"
		},
		barrel = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df"
		},
		magazine = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_018_b_df"
		}
	}
	self.weapon_skins.new_m4_smosh = {}
	self.weapon_skins.new_m4_smosh.name_id = "bm_wskn_new_m4_smosh"
	self.weapon_skins.new_m4_smosh.desc_id = "bm_wskn_new_m4_smosh_desc"
	self.weapon_skins.new_m4_smosh.weapon_id = "new_m4"
	self.weapon_skins.new_m4_smosh.rarity = "common"
	self.weapon_skins.new_m4_smosh.bonus = "spread_p1"
	self.weapon_skins.new_m4_smosh.reserve_quality = true
	self.weapon_skins.new_m4_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.new_m4_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_019_df"
	self.weapon_skins.new_m4_smosh.parts = {
		wpn_fps_m4_uupg_fg_rail = {
			[Idstring("m4_fg_rail"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_012_df")
			}
		}
	}
	self.weapon_skins.aug_smosh = {}
	self.weapon_skins.aug_smosh.name_id = "bm_wskn_aug_smosh"
	self.weapon_skins.aug_smosh.desc_id = "bm_wskn_aug_smosh_desc"
	self.weapon_skins.aug_smosh.weapon_id = "aug"
	self.weapon_skins.aug_smosh.rarity = "rare"
	self.weapon_skins.aug_smosh.bonus = "spread_p1"
	self.weapon_skins.aug_smosh.reserve_quality = true
	self.weapon_skins.aug_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.aug_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_020_b_df"
	self.weapon_skins.aug_smosh.pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_020_df"
	self.weapon_skins.aug_smosh.default_blueprint = {
		"wpn_fps_upg_vg_ass_smg_verticalgrip",
		"wpn_fps_aug_m_pmag",
		"wpn_fps_upg_ns_ass_smg_stubby",
		"wpn_fps_aug_fg_a3",
		"wpn_fps_aug_b_short",
		"wpn_fps_aug_body_f90",
		"wpn_fps_upg_fl_ass_smg_sho_peqbox",
		"wpn_fps_upg_o_acog"
	}
	self.weapon_skins.aug_smosh.parts = {
		wpn_fps_aug_body_f90 = {
			[Idstring("mtr_f90"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_020_b_df",
				pattern_pos = Vector3(-0.155974, 0.072979, 0),
				pattern_tweak = Vector3(1.25447, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_020_df"
			},
			[Idstring("aug"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_020_df"
			}
		},
		wpn_fps_aug_b_long = {
			[Idstring("barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_020_df"
			}
		},
		wpn_fps_aug_fg_a3 = {
			[Idstring("a3"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_020_b_df"),
				pattern_pos = Vector3(0.69306, 0.988791, 0),
				pattern_tweak = Vector3(1, 6.28319, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_020_df"
			}
		},
		wpn_fps_aug_b_short = {
			[Idstring("barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_020_df"
			}
		},
		wpn_fps_aug_b_medium = {
			[Idstring("barrel"):key()] = {
				base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_020_df"
			}
		},
		wpn_fps_aug_body_aug = {
			[Idstring("aug"):key()] = {
				pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_020_df",
				pattern_pos = Vector3(-0.136895, 0.0538995, 0),
				pattern_tweak = Vector3(1.15908, 0, 1),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_020_df"
			}
		},
		wpn_fps_upg_o_acog = {
			[Idstring("mtr_acog"):key()] = {
				pattern_pos = Vector3(-0.0510372, -0.00333858, 0),
				pattern_gradient = Idstring("units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_020_b_df"),
				pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_020_df"
			}
		}
	}
	self.weapon_skins.m37_smosh = {}
	self.weapon_skins.m37_smosh.name_id = "bm_wskn_m37_smosh"
	self.weapon_skins.m37_smosh.desc_id = "bm_wskn_m37_smosh_desc"
	self.weapon_skins.m37_smosh.weapon_id = "m37"
	self.weapon_skins.m37_smosh.rarity = "epic"
	self.weapon_skins.m37_smosh.bonus = "spread_n1"
	self.weapon_skins.m37_smosh.reserve_quality = true
	self.weapon_skins.m37_smosh.texture_bundle_folder = "cash/safes/smosh"
	self.weapon_skins.m37_smosh.base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_df"
	self.weapon_skins.m37_smosh.cubemap_pattern_control = Vector3(0.208204, 0.119962, 0)
	self.weapon_skins.m37_smosh.default_blueprint = {
		"wpn_fps_shot_m37_m_standard",
		"wpn_fps_shot_m37_body_standard",
		"wpn_fps_shot_m37_fg_standard",
		"wpn_fps_shot_m37_s_standard",
		"wpn_fps_upg_a_custom",
		"wpn_fps_upg_ns_shot_shark",
		"wpn_fps_shot_m37_b_short",
		"wpn_fps_upg_fl_ass_laser"
	}
	self.weapon_skins.m37_smosh.parts = {
		wpn_fps_shot_m37_s_short = {
			[Idstring("mtr_short_stock"):key()] = {
				uv_offset_rot = Vector3(-0.155974, 0.998331, 4.79968),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_021_b_df",
				uv_scale = Vector3(12.5961, 12.5961, 0.160506)
			}
		},
		wpn_fps_shot_m37_body_standard = {
			[Idstring("mtr_internal"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_008_df")
			}
		},
		wpn_fps_shot_m37_fg_standard = {
			[Idstring("mtr_pump"):key()] = {
				uv_offset_rot = Vector3(0.0920584, 0.864775, 3.15133),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_021_df",
				uv_scale = Vector3(5.63561, 5.63561, 0.310756)
			}
		},
		wpn_fps_upg_fl_ass_laser = {
			[Idstring("mtr_laser"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df")
			}
		},
		wpn_fps_upg_ns_shot_shark = {
			[Idstring("shark"):key()] = {
				pattern_tweak = Vector3(0.0984075, 0, 1)
			}
		},
		wpn_fps_shot_m37_s_standard = {
			[Idstring("mtr_stock"):key()] = {
				uv_offset_rot = Vector3(-0.337228, 0.969712, 0),
				sticker = "units/payday2_cash/safes/smosh/sticker/smosh_sticker_021_df",
				uv_scale = Vector3(5.49259, 5.49259, 0.189125)
			}
		},
		wpn_fps_upg_fl_ass_smg_sho_surefire = {
			[Idstring("surefire"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/burn/base_gradient/base_burn_006_df")
			}
		}
	}
	self.weapon_skins.m37_smosh.types = {
		foregrip = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_021_b_df",
			cubemap_pattern_control = Vector3(0.499165, 0.229669, 0),
			pattern_tweak = Vector3(2.59003, 0, 1),
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_b_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_b_df"
		},
		barrel = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_c_df",
			cubemap_pattern_control = Vector3(0.203434, 0.0889579, 0),
			pattern_pos = Vector3(0.158836, 0.235154, 0),
			pattern_tweak = Vector3(1.54067, 2.65683, 0.143811),
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_021_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_df"
		},
		stock = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_021_b_df",
			cubemap_pattern_control = Vector3(0.49678, 0.277367, 0),
			pattern_pos = Vector3(0.235154, 0.263773, 0),
			pattern_tweak = Vector3(2.78083, 0, 1),
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_b_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_b_df"
		},
		gadget = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_021_df",
			cubemap_pattern_control = Vector3(0.160506, 0.0460292, 0),
			pattern_tweak = Vector3(0.252805, 1.96752, 0),
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_c_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_df"
		},
		barrel_ext = {
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_021_df",
			cubemap_pattern_control = Vector3(0.239208, 0.115192, 0),
			pattern_tweak = Vector3(0.538996, 0, 0),
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_c_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_df"
		},
		lower_reciever = {
			base_gradient = "units/payday2_cash/safes/smosh/base_gradient/base_smosh_021_c_df",
			cubemap_pattern_control = Vector3(0.396613, 0.0818031, 0),
			pattern_pos = Vector3(-1.67279, -1.17672, 0),
			pattern_tweak = Vector3(0.443599, 0, 0),
			pattern_gradient = "units/payday2_cash/safes/smosh/pattern_gradient/gradient_smosh_021_df",
			pattern = "units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_df"
		}
	}
	self.weapon_skins.peacemaker_sfs = {}
	self.weapon_skins.peacemaker_sfs.name_id = "bm_wskn_peacemaker_sfs"
	self.weapon_skins.peacemaker_sfs.desc_id = "bm_wskn_peacemaker_sfs_desc"
	self.weapon_skins.peacemaker_sfs.weapon_id = "peacemaker"
	self.weapon_skins.peacemaker_sfs.rarity = "common"
	self.weapon_skins.peacemaker_sfs.bonus = "spread_p1"
	self.weapon_skins.peacemaker_sfs.reserve_quality = true
	self.weapon_skins.peacemaker_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.peacemaker_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_004_df")
	self.weapon_skins.peacemaker_sfs.cubemap_pattern_control = Vector3(0, 0.84975, 0)
	self.weapon_skins.peacemaker_sfs.parts = {
		wpn_fps_pis_peacemaker_body_standard = {
			[Idstring("mtr_body"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_004_b_df")
			}
		}
	}
	self.weapon_skins.peacemaker_sfs.types = {
		grip = {
			pattern_gradient = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crackled_ground_df"),
			pattern_pos = Vector3(0, 0.254234, 0),
			pattern_tweak = Vector3(0.538996, 3.00148, 1),
			pattern = Idstring("units/payday2_cash/safes/smosh/pattern/smosh_pattern_021_b_df")
		}
	}
	self.weapon_skins.x_akmsu_sfs = {}
	self.weapon_skins.x_akmsu_sfs.name_id = "bm_wskn_x_akmsu_sfs"
	self.weapon_skins.x_akmsu_sfs.desc_id = "bm_wskn_x_akmsu_sfs_desc"
	self.weapon_skins.x_akmsu_sfs.weapon_id = "x_akmsu"
	self.weapon_skins.x_akmsu_sfs.rarity = "common"
	self.weapon_skins.x_akmsu_sfs.bonus = "recoil_p1"
	self.weapon_skins.x_akmsu_sfs.reserve_quality = true
	self.weapon_skins.x_akmsu_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.x_akmsu_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_df")
	self.weapon_skins.x_akmsu_sfs.parts = {
		wpn_fps_upg_ak_m_quad = {
			[Idstring("mtr_quadstack"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_c_df")
			}
		},
		wpn_fps_upg_ak_m_quick = {
			[Idstring("ak74_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_c_df")
			}
		},
		wpn_fps_smg_akmsu_fg_rail = {
			[Idstring("akmsu_rail"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/shared/base_gradient/base_shared_001_df")
			}
		},
		wpn_fps_smg_akmsu_fg_standard = {
			[Idstring("akmsu_handguard"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_002_df")
			}
		},
		wpn_fps_upg_ak_m_uspalm = {
			[Idstring("mtr_uspalm"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_c_df"),
				uv_offset_rot = Vector3(0.001, 0.004, 0),
				pattern_pos = Vector3(0.001, 0, 0),
				pattern_tweak = Vector3(1, 0.001, 1),
				cubemap_pattern_control = Vector3(0, 0.006, 0)
			}
		}
	}
	self.weapon_skins.x_akmsu_sfs.types = {
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_002_df")
		}
	}
	self.weapon_skins.china_sfs = {}
	self.weapon_skins.china_sfs.name_id = "bm_wskn_china_sfs"
	self.weapon_skins.china_sfs.desc_id = "bm_wskn_china_sfs_desc"
	self.weapon_skins.china_sfs.weapon_id = "china"
	self.weapon_skins.china_sfs.rarity = "common"
	self.weapon_skins.china_sfs.bonus = "concealment_p1"
	self.weapon_skins.china_sfs.reserve_quality = true
	self.weapon_skins.china_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.china_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_df")
	self.weapon_skins.china_sfs.types = {
		foregrip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df"),
			pattern_tweak = Vector3(2.39924, 0, 1),
			wear_and_tear = 0.8,
			pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_008_df")
		},
		lower_receiver = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df"),
			pattern_tweak = Vector3(1, 6.28319, 1),
			uv_offset_rot = Vector3(-0.0184179, 0.870775, 0),
			uv_scale = Vector3(3.50456, 4.79177, 1)
		},
		extra = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_b_df")
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_df")
		}
	}
	self.weapon_skins.olympic_sfs = {}
	self.weapon_skins.olympic_sfs.name_id = "bm_wskn_olympic_sfs"
	self.weapon_skins.olympic_sfs.desc_id = "bm_wskn_olympic_sfs_desc"
	self.weapon_skins.olympic_sfs.weapon_id = "olympic"
	self.weapon_skins.olympic_sfs.rarity = "common"
	self.weapon_skins.olympic_sfs.bonus = "spread_p1"
	self.weapon_skins.olympic_sfs.reserve_quality = true
	self.weapon_skins.olympic_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.olympic_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_df")
	self.weapon_skins.olympic_sfs.parts = {
		wpn_fps_smg_olympic_s_adjust = {
			[Idstring("adjust"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
			}
		},
		wpn_fps_smg_olympic_s_short = {
			[Idstring("short"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_df")
			}
		}
	}
	self.weapon_skins.olympic_sfs.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_002_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/gradient_france_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_002_df")
		}
	}
	self.weapon_skins.desertfox_sfs = {}
	self.weapon_skins.desertfox_sfs.name_id = "bm_wskn_desertfox_sfs"
	self.weapon_skins.desertfox_sfs.desc_id = "bm_wskn_desertfox_sfs_desc"
	self.weapon_skins.desertfox_sfs.weapon_id = "desertfox"
	self.weapon_skins.desertfox_sfs.rarity = "common"
	self.weapon_skins.desertfox_sfs.bonus = "recoil_p1"
	self.weapon_skins.desertfox_sfs.reserve_quality = true
	self.weapon_skins.desertfox_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.desertfox_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_df")
	self.weapon_skins.msr_sfs = {}
	self.weapon_skins.msr_sfs.name_id = "bm_wskn_msr_sfs"
	self.weapon_skins.msr_sfs.desc_id = "bm_wskn_msr_sfs_desc"
	self.weapon_skins.msr_sfs.weapon_id = "msr"
	self.weapon_skins.msr_sfs.rarity = "common"
	self.weapon_skins.msr_sfs.bonus = "recoil_p1"
	self.weapon_skins.msr_sfs.reserve_quality = true
	self.weapon_skins.msr_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.msr_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_006_df")
	self.weapon_skins.msr_sfs.parts = {
		wpn_fps_snp_msr_body_wood = {
			[Idstring("mtr_wooden"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_006_b_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/shared/pattern_gradient/gradient_shared_003_df"),
				pattern_pos = Vector3(0, -1.25304, 0),
				pattern_tweak = Vector3(3.21011, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_002_df")
			}
		}
	}
	self.weapon_skins.hk21_sfs = {}
	self.weapon_skins.hk21_sfs.name_id = "bm_wskn_hk21_sfs"
	self.weapon_skins.hk21_sfs.desc_id = "bm_wskn_hk21_sfs_desc"
	self.weapon_skins.hk21_sfs.weapon_id = "hk21"
	self.weapon_skins.hk21_sfs.rarity = "uncommon"
	self.weapon_skins.hk21_sfs.bonus = "recoil_p1"
	self.weapon_skins.hk21_sfs.reserve_quality = true
	self.weapon_skins.hk21_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.hk21_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_010_df")
	self.weapon_skins.hk21_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df")
	self.weapon_skins.hk21_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
	self.weapon_skins.hk21_sfs.pattern_tweak = Vector3(1.73146, 0, 1)
	self.weapon_skins.hk21_sfs.pattern_pos = Vector3(0, 0.254234, 0)
	self.weapon_skins.hk21_sfs.parts = {
		wpn_fps_lmg_hk21_body_lower = {
			[Idstring("lower"):key()] = {
				uv_offset_rot = Vector3(-0.251911, 0.944093, 0),
				uv_scale = Vector3(11.5616, 13.2779, 0)
			}
		}
	}
	self.weapon_skins.hk21_sfs.types = {
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/bah/base_gradient/base_bah_007_b_df"),
			pattern_tweak = Vector3(0, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_001_df")
		}
	}
	self.weapon_skins.m16_sfs = {}
	self.weapon_skins.m16_sfs.name_id = "bm_wskn_m16_sfs"
	self.weapon_skins.m16_sfs.desc_id = "bm_wskn_m16_sfs_desc"
	self.weapon_skins.m16_sfs.weapon_id = "m16"
	self.weapon_skins.m16_sfs.rarity = "uncommon"
	self.weapon_skins.m16_sfs.bonus = "spread_p1"
	self.weapon_skins.m16_sfs.reserve_quality = true
	self.weapon_skins.m16_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.m16_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_df")
	self.weapon_skins.m16_sfs.parts = {
		wpn_fps_m4_upper_reciever_edge = {
			[Idstring("m4_upper_reciever_edge"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_df")
			}
		}
	}
	self.weapon_skins.m16_sfs.types = {
		stock = {
			pattern_tweak = Vector3(1.20678, 0, 1),
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_c_df"),
			pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
		},
		grip = {
			pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df"),
			pattern_pos = Vector3(0.292392, -0.165514, 0),
			pattern_tweak = Vector3(1.15908, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
		},
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_b_df")
		}
	}
	self.weapon_skins.uzi_sfs = {}
	self.weapon_skins.uzi_sfs.name_id = "bm_wskn_uzi_sfs"
	self.weapon_skins.uzi_sfs.desc_id = "bm_wskn_uzi_sfs_desc"
	self.weapon_skins.uzi_sfs.weapon_id = "uzi"
	self.weapon_skins.uzi_sfs.rarity = "uncommon"
	self.weapon_skins.uzi_sfs.bonus = "concealment_p1"
	self.weapon_skins.uzi_sfs.reserve_quality = true
	self.weapon_skins.uzi_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.uzi_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_008_df")
	self.weapon_skins.uzi_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df")
	self.weapon_skins.uzi_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
	self.weapon_skins.uzi_sfs.pattern_tweak = Vector3(2.06535, 0, 1)
	self.weapon_skins.uzi_sfs.pattern_pos = Vector3(0.120678, 0.0920586, 0)
	self.weapon_skins.uzi_sfs.parts = {
		wpn_fps_smg_uzi_body_standard = {
			[Idstring("mat_base"):key()] = {
				uv_offset_rot = Vector3(-0.203593, 0.856315, 0),
				uv_scale = Vector3(20, 20, 0)
			}
		},
		wpn_fps_smg_uzi_s_leather = {
			[Idstring("mat_stock_3"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_c_df")
			}
		}
	}
	self.weapon_skins.uzi_sfs.types = {
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_006_df")
		}
	}
	self.weapon_skins.spas12_sfs = {}
	self.weapon_skins.spas12_sfs.name_id = "bm_wskn_spas12_sfs"
	self.weapon_skins.spas12_sfs.desc_id = "bm_wskn_spas12_sfs_desc"
	self.weapon_skins.spas12_sfs.weapon_id = "spas12"
	self.weapon_skins.spas12_sfs.rarity = "uncommon"
	self.weapon_skins.spas12_sfs.bonus = "spread_n1"
	self.weapon_skins.spas12_sfs.reserve_quality = true
	self.weapon_skins.spas12_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.spas12_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_009_df")
	self.weapon_skins.spas12_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df")
	self.weapon_skins.spas12_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
	self.weapon_skins.spas12_sfs.pattern_tweak = Vector3(1.11138, 0, 1)
	self.weapon_skins.spas12_sfs.pattern_pos = Vector3(0, 0.244694, 0)
	self.weapon_skins.spas12_sfs.parts = {
		wpn_fps_sho_body_spas12_standard = {
			[Idstring("mtr_body"):key()] = {
				uv_offset_rot = Vector3(-0.450165, 0.998331, 4.75472),
				uv_scale = Vector3(20, 20, 1)
			}
		}
	}
	self.weapon_skins.spas12_sfs.types = {
		lower_reciever = {
			uv_offset_rot = Vector3(-0.327689, 0.922013, 0),
			uv_scale = Vector3(15.9953, 20, 1)
		}
	}
	self.weapon_skins.mateba_sfs = {}
	self.weapon_skins.mateba_sfs.name_id = "bm_wskn_mateba_sfs"
	self.weapon_skins.mateba_sfs.desc_id = "bm_wskn_mateba_sfs_desc"
	self.weapon_skins.mateba_sfs.weapon_id = "mateba"
	self.weapon_skins.mateba_sfs.rarity = "epic"
	self.weapon_skins.mateba_sfs.bonus = "spread_p1"
	self.weapon_skins.mateba_sfs.reserve_quality = true
	self.weapon_skins.mateba_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.mateba_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_016_df")
	self.weapon_skins.mateba_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/cop/pattern_gradient/gradient_cop_blurred_df")
	self.weapon_skins.mateba_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_004_df")
	self.weapon_skins.mateba_sfs.pattern_tweak = Vector3(1.44527, 3.46602, 1)
	self.weapon_skins.mateba_sfs.pattern_pos = Vector3(0.0920586, 0.931553, 0)
	self.weapon_skins.mateba_sfs.default_blueprint = {
		"wpn_fps_pis_2006m_body_standard",
		"wpn_fps_pis_2006m_m_standard",
		"wpn_fps_pis_2006m_g_standard",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_pis_2006m_b_standard"
	}
	self.weapon_skins.mateba_sfs.parts = {
		wpn_fps_upg_fl_pis_crimson = {
			[Idstring("mtr_crimson"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_b_df"),
				pattern_tweak = Vector3(0, 0, 1)
			}
		},
		wpn_fps_pis_2006m_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_001_df"),
				uv_offset_rot = Vector3(0, 0.193535, 5.18929),
				uv_scale = Vector3(1.59757, 1.21617, 0),
				pattern_pos = Vector3(0.0157409, -1.67279, 0),
				pattern_tweak = Vector3(1.39757, 1.96752, 1),
				pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_004_df")
			}
		},
		wpn_fps_pis_2006m_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_016_b_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_001_df"),
				pattern_pos = Vector3(-0.225752, -0.129275, 0),
				pattern_tweak = Vector3(3.44861, 1.5929, 1),
				pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_006_df")
			}
		}
	}
	self.weapon_skins.mateba_sfs.types = {
		barrel = {
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_001_df"),
			uv_offset_rot = Vector3(-0.00749735, 1.00679, 0),
			uv_scale = Vector3(1.45455, 1.93129, 0),
			pattern_pos = Vector3(-0.0605768, 0.0940586, 0),
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_016_c_df"),
			pattern_tweak = Vector3(1.22578, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_007_df")
		},
		grip = {
			pattern_tweak = Vector3(0, 0, 1)
		}
	}
	self.weapon_skins.mac10_sfs = {}
	self.weapon_skins.mac10_sfs.name_id = "bm_wskn_mac10_sfs"
	self.weapon_skins.mac10_sfs.desc_id = "bm_wskn_mac10_sfs_desc"
	self.weapon_skins.mac10_sfs.weapon_id = "mac10"
	self.weapon_skins.mac10_sfs.rarity = "rare"
	self.weapon_skins.mac10_sfs.bonus = "spread_p1"
	self.weapon_skins.mac10_sfs.reserve_quality = true
	self.weapon_skins.mac10_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.mac10_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_012_df")
	self.weapon_skins.mac10_sfs.default_blueprint = {
		"wpn_fps_smg_mac10_body_mac10",
		"wpn_fps_smg_mac10_b_dummy",
		"wpn_fps_smg_mac10_s_fold",
		"wpn_fps_upg_ns_ass_smg_large",
		"wpn_fps_smg_mac10_m_extended"
	}
	self.weapon_skins.mac10_sfs.types = {
		lower_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_012_b_df"),
			pattern_pos = Vector3(0.177916, 0.244694, 0),
			pattern_tweak = Vector3(2.16075, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_003_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_004_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_012_b_df"),
			uv_offset_rot = Vector3(0.0368203, 0.956251, 0),
			uv_scale = Vector3(0.930124, 1.97897, 1),
			pattern_pos = Vector3(1.33222, 0.139757, 0),
			pattern_tweak = Vector3(1.15908, 1.50299, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_008_df")
		}
	}
	self.weapon_skins.colt_1911_sfs = {}
	self.weapon_skins.colt_1911_sfs.name_id = "bm_wskn_colt_1911_sfs"
	self.weapon_skins.colt_1911_sfs.desc_id = "bm_wskn_colt_1911_sfs_desc"
	self.weapon_skins.colt_1911_sfs.weapon_id = "colt_1911"
	self.weapon_skins.colt_1911_sfs.rarity = "rare"
	self.weapon_skins.colt_1911_sfs.bonus = "spread_p1"
	self.weapon_skins.colt_1911_sfs.reserve_quality = true
	self.weapon_skins.colt_1911_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.colt_1911_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_014_df")
	self.weapon_skins.colt_1911_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_005_df")
	self.weapon_skins.colt_1911_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_004_df")
	self.weapon_skins.colt_1911_sfs.pattern_tweak = Vector3(1.20678, 0, 1)
	self.weapon_skins.colt_1911_sfs.default_blueprint = {
		"wpn_fps_pis_1911_body_standard",
		"wpn_fps_pis_1911_m_extended",
		"wpn_fps_upg_fl_pis_crimson",
		"wpn_fps_upg_ns_pis_large",
		"wpn_fps_pis_1911_g_standard",
		"wpn_fps_pis_1911_b_standard"
	}
	self.weapon_skins.colt_1911_sfs.parts = {
		wpn_fps_pis_1911_b_long = {
			[Idstring("slide_long"):key()] = {
				pattern_tweak = Vector3(0.252805, 0, 1),
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_013_df")
			},
			[Idstring("barrel_vented"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_df")
			}
		},
		wpn_fps_pis_1911_o_long = {
			[Idstring("sights"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_002_df")
			}
		}
	}
	self.weapon_skins.colt_1911_sfs.types = {
		slide = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_014_b_df"),
			uv_offset_rot = Vector3(-0.0510371, 0.969712, 0),
			uv_scale = Vector3(1.59757, 3.83828, 1),
			pattern_pos = Vector3(1.14143, 0.286392, 0),
			pattern_tweak = Vector3(1.66846, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_011_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_005_df"),
			pattern_pos = Vector3(-0.27999, 0.0538997, 0),
			pattern_tweak = Vector3(0, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df"),
			pattern_tweak = Vector3(0, 0, 1)
		},
		gadget = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_b_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_b_df"),
			pattern_pos = Vector3(-0.508943, -0.232292, 0),
			pattern_tweak = Vector3(1.06368, 0, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
		}
	}
	self.weapon_skins.r870_sfs = {}
	self.weapon_skins.r870_sfs.name_id = "bm_wskn_r870_sfs"
	self.weapon_skins.r870_sfs.desc_id = "bm_wskn_r870_sfs_desc"
	self.weapon_skins.r870_sfs.weapon_id = "r870"
	self.weapon_skins.r870_sfs.rarity = "epic"
	self.weapon_skins.r870_sfs.bonus = "spread_n1"
	self.weapon_skins.r870_sfs.reserve_quality = true
	self.weapon_skins.r870_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.r870_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_df")
	self.weapon_skins.r870_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_004_df")
	self.weapon_skins.r870_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
	self.weapon_skins.r870_sfs.default_blueprint = {
		"wpn_fps_shot_r870_body_standard",
		"wpn_fps_shot_r870_b_long",
		"wpn_fps_upg_shot_ns_king",
		"wpn_fps_shot_r870_fg_wood",
		"wpn_fps_upg_fl_ass_peq15",
		"wpn_fps_upg_m4_g_ergo",
		"wpn_fps_shot_r870_m_extended",
		"wpn_fps_shot_r870_s_solid_vanilla",
		"wpn_fps_upg_o_reflex"
	}
	self.weapon_skins.r870_sfs.parts = {
		wpn_fps_shot_r870_s_solid_vanilla = {
			[Idstring("solid"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_b_df"),
				uv_offset_rot = Vector3(0.002, 0.635822, 0)
			}
		},
		wpn_fps_shot_r870_body_standard = {
			[Idstring("receiver"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_b_df")
			}
		}
	}
	self.weapon_skins.r870_sfs.types = {
		foregrip = {
			uv_scale = Vector3(1.31152, 3.55223, 1)
		},
		lower_reciever = {
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
			uv_offset_rot = Vector3(0.11882, 0.999331, 0.008),
			uv_scale = Vector3(1.12082, 2.26502, 1),
			pattern_pos = Vector3(0.130297, 0.565044, 0),
			pattern_tweak = Vector3(1.37257, 1.56488, 1),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_009_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_c_df")
		}
	}
	self.weapon_skins.galil_sfs = {}
	self.weapon_skins.galil_sfs.name_id = "bm_wskn_galil_sfs"
	self.weapon_skins.galil_sfs.desc_id = "bm_wskn_galil_sfs_desc"
	self.weapon_skins.galil_sfs.weapon_id = "galil"
	self.weapon_skins.galil_sfs.rarity = "rare"
	self.weapon_skins.galil_sfs.bonus = "spread_p1"
	self.weapon_skins.galil_sfs.reserve_quality = true
	self.weapon_skins.galil_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.galil_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_df")
	self.weapon_skins.galil_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df")
	self.weapon_skins.galil_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_004_df")
	self.weapon_skins.galil_sfs.pattern_tweak = Vector3(1.63606, 0, 1)
	self.weapon_skins.galil_sfs.default_blueprint = {
		"wpn_fps_ass_galil_body_standard",
		"wpn_fps_ass_galil_m_standard",
		"wpn_fps_upg_fl_ass_peq15",
		"wpn_fps_ass_galil_g_sniper",
		"wpn_fps_upg_ns_ass_smg_medium",
		"wpn_fps_ass_galil_fg_sar",
		"wpn_fps_ass_galil_s_sniper",
		"wpn_fps_upg_o_cs"
	}
	self.weapon_skins.galil_sfs.types = {
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_003_df")
		},
		sight = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_004_df")
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_002_df")
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_b_df"),
			uv_offset_rot = Vector3(0, 0.397329, 0),
			pattern_gradient = Idstring("units/payday2_cash/safes/red/pattern_gradient/pattern_gradient_marble_floor_df"),
			pattern_tweak = Vector3(0, 0, 1),
			pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_003_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_c_df"),
			pattern_pos = Vector3(0.855235, -0.129037, 0),
			pattern_tweak = Vector3(2.25814, 6.25322, 1),
			pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
			pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_010_df")
		},
		upper_reciever = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_004_df")
		}
	}
	self.weapon_skins.contraband_sfs = {}
	self.weapon_skins.contraband_sfs.name_id = "bm_wskn_contraband_sfs"
	self.weapon_skins.contraband_sfs.desc_id = "bm_wskn_contraband_sfs_desc"
	self.weapon_skins.contraband_sfs.weapon_id = "contraband"
	self.weapon_skins.contraband_sfs.rarity = "legendary"
	self.weapon_skins.contraband_sfs.bonus = "spread_p1"
	self.weapon_skins.contraband_sfs.reserve_quality = true
	self.weapon_skins.contraband_sfs.texture_bundle_folder = "cash/safes/sfs"
	self.weapon_skins.contraband_sfs.unique_name_id = "bm_wskn_contraband_sfs"
	self.weapon_skins.contraband_sfs.locked = false
	self.weapon_skins.contraband_sfs.base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_017_b_df")
	self.weapon_skins.contraband_sfs.pattern_gradient = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_001_df")
	self.weapon_skins.contraband_sfs.pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_003_df")
	self.weapon_skins.contraband_sfs.pattern_tweak = Vector3(2.35154, 0, 1)
	self.weapon_skins.contraband_sfs.pattern_pos = Vector3(-0.184593, 0.406869, 0)
	self.weapon_skins.contraband_sfs.default_blueprint = {
		"wpn_fps_ass_contraband_b_standard",
		"wpn_fps_ass_contraband_body_standard",
		"wpn_fps_ass_contraband_dh_standard",
		"wpn_fps_ass_contraband_fg_standard",
		"wpn_fps_ass_contraband_g_standard",
		"wpn_fps_ass_contraband_gl_m203",
		"wpn_fps_ass_contraband_m_standard",
		"wpn_fps_ass_contraband_s_standard",
		"wpn_fps_ass_contraband_bolt_standard",
		"wpn_fps_upg_fl_ass_peq15",
		"wpn_fps_upg_ns_ass_smg_small",
		"wpn_fps_ass_contraband_o_standard"
	}
	self.weapon_skins.contraband_sfs.parts = {
		wpn_fps_ass_contraband_s_standard = {
			[Idstring("mtr_stock"):key()] = {
				uv_offset_rot = Vector3(-0.0500371, 0.946172, 0),
				uv_scale = Vector3(18.1884, 20, 1)
			}
		},
		wpn_fps_upg_o_spot = {
			[Idstring("mtr_spot"):key()] = {
				pattern_tweak = Vector3(2.97162, 0, 1)
			}
		},
		wpn_fps_ass_contraband_dh_standard = {
			[Idstring("mtr_drag"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df")
			}
		},
		wpn_fps_ass_contraband_gl_m203 = {
			[Idstring("mtr_m203"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_df"),
				pattern_tweak = Vector3(2.78083, 0, 1)
			}
		},
		wpn_fps_ass_contraband_b_standard = {
			[Idstring("mtr_gasblock"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_df")
			}
		},
		wpn_fps_ass_contraband_fg_standard = {
			[Idstring("mtr_fg"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_d_df"),
				pattern_tweak = Vector3(1.96995, 0, 1)
			}
		},
		wpn_fps_ass_contraband_body_standard = {
			[Idstring("mtr_upper"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_007_df"),
				uv_offset_rot = Vector3(0.08936, 0.893934, 6.27319),
				uv_scale = Vector3(20, 20, 1),
				pattern_pos = Vector3(0.149297, 1.04603, 0),
				pattern_tweak = Vector3(0, 0, 1),
				pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_001_df")
			},
			[Idstring("mtr_lower"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_e_df"),
				pattern_gradient = Idstring("units/payday2_cash/safes/lones/pattern_gradient/gradient_lones_005_df"),
				sticker = Idstring("units/payday2_cash/safes/grunt/sticker/grunt_sticker_022_df"),
				uv_scale = Vector3(20, 20, 1),
				pattern_tweak = Vector3(0, 0, 1),
				uv_offset_rot = Vector3(-0.143355, 0.913013, 6.22325),
				pattern = Idstring("units/payday2_cash/safes/lones/pattern/lones_pattern_003_df")
			}
		},
		wpn_fps_upg_fl_ass_peq15 = {
			[Idstring("mtr_peq15"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_b_df"),
				pattern_tweak = Vector3(0, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/buck/pattern_gradient/gradient_buck_003_df"),
				pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_006_df")
			}
		},
		wpn_fps_ass_contraband_m_standard = {
			[Idstring("mtr_mag"):key()] = {
				pattern_tweak = Vector3(1.39757, 4.76971, 0),
				cubemap_pattern_control = Vector3(1, 1, 0),
				pattern_pos = Vector3(0.537425, 1.21013, 0)
			}
		},
		wpn_fps_ass_contraband_g_standard = {
			[Idstring("mtr_grip"):key()] = {
				pattern_tweak = Vector3(3.01932, 0, 1),
				pattern_gradient = Idstring("units/payday2_cash/safes/sfs/pattern_gradient/gradient_sfs_002_df"),
				pattern_pos = Vector3(1.18413, 1.06765, 0),
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_005_b_df"),
				pattern = Idstring("units/payday2_cash/safes/sfs/pattern/sfs_pattern_012_df")
			}
		},
		wpn_fps_ass_contraband_bolt_standard = {
			[Idstring("mtr_upper"):key()] = {
				base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_b_df")
			}
		}
	}
	self.weapon_skins.contraband_sfs.types = {
		underbarrel = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_015_df"),
			pattern_tweak = Vector3(4.49797, 0, 1)
		},
		barrel = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_c_df")
		},
		magazine = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_f_df"),
			pattern_tweak = Vector3(0, 0, 1)
		},
		stock = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_c_df"),
			pattern_pos = Vector3(-0.146434, 0.06536, 0)
		},
		grip = {
			base_gradient = Idstring("units/payday2_cash/safes/buck/base_gradient/base_buck_010_df")
		},
		barrel_ext = {
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_001_df")
		},
		sight = {
			pattern_tweak = Vector3(0.682091, 0, 1),
			base_gradient = Idstring("units/payday2_cash/safes/sfs/base_gradient/base_sfs_018_b_df")
		}
	}
end
