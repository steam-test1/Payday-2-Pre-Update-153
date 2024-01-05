DLCTweakData = DLCTweakData or class()

function DLCTweakData:init(tweak_data)
	self.starter_kit = {}
	self.starter_kit.free = true
	self.starter_kit.content = {}
	self.starter_kit.content.loot_global_value = "normal"
	self.starter_kit.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_ns_pis_medium",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_m4_uupg_m_std",
			amount = 1
		}
	}
	self.starter_kit.content.upgrades = {"fists"}
	do
		local all_normal_masks = {
			"alienware",
			"babyrhino",
			"mr_sinister",
			"day_of_the_dead",
			"irondoom",
			"greek_tragedy",
			"hockey",
			"kawaii",
			"demonictender",
			"monkeybiss",
			"rubber_male",
			"scarecrow",
			"tounge",
			"rubber_female",
			"oni",
			"biglips",
			"brainiack",
			"bullet",
			"outlandish_a",
			"clowncry",
			"dripper",
			"gagball",
			"hog",
			"demon",
			"jaw",
			"mummy",
			"outlandish_b",
			"outlandish_c",
			"stonekisses",
			"buha",
			"shogun",
			"shrunken",
			"clown_56",
			"troll",
			"dawn_of_the_dead",
			"vampire",
			"zipper",
			"zombie"
		}
		local lootdrops = {}
		for i, mask_id in ipairs(all_normal_masks) do
			table.insert(lootdrops, {
				type_items = "masks",
				item_entry = mask_id,
				amount = 1
			})
		end
		self.starter_kit_mask = {}
		self.starter_kit_mask.free = true
		self.starter_kit_mask.content = {}
		self.starter_kit_mask.content.loot_global_value = "normal"
		self.starter_kit_mask.content.loot_drops = {lootdrops}
	end
	self.pd2_clan = {}
	self.pd2_clan.content = {}
	self.pd2_clan.dlc = "has_pd2_clan"
	self.pd2_clan.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "bear",
			amount = 1
		}
	}
	self.pd2_clan2 = {}
	self.pd2_clan2.content = {}
	self.pd2_clan2.dlc = "has_pd2_clan"
	self.pd2_clan2.content.loot_global_value = "pd2_clan"
	self.pd2_clan2.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_fl_pis_tlr1",
			amount = 1
		}
	}
	self.pd2_clan2.content.upgrades = {"usp"}
	self.pd2_clan3 = {}
	self.pd2_clan3.content = {}
	self.pd2_clan3.dlc = "has_pd2_clan"
	self.pd2_clan3.content.loot_global_value = "pd2_clan"
	self.pd2_clan3.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "heat",
			amount = 1
		}
	}
	self.pd2_clan4 = {}
	self.pd2_clan4.content = {}
	self.pd2_clan4.dlc = "has_pd2_clan"
	self.pd2_clan4.content.loot_global_value = "pd2_clan"
	self.pd2_clan4.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "santa_happy",
			amount = 1
		}
	}
	self.pd2_clan5 = {}
	self.pd2_clan5.content = {}
	self.pd2_clan5.dlc = "has_pd2_clan"
	self.pd2_clan5.content.loot_global_value = "pd2_clan"
	self.pd2_clan5.content.loot_drops = {}
	self.pd2_clan5.content.upgrades = {
		"brass_knuckles"
	}
	self.preorder = {}
	self.preorder.dlc = "has_preorder"
	self.preorder.content = {}
	self.preorder.content.loot_drops = {
		{
			type_items = "colors",
			item_entry = "red_black",
			amount = 1
		},
		{
			type_items = "textures",
			item_entry = "fan",
			amount = 1
		},
		{
			type_items = "masks",
			item_entry = "skull",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_o_aimpoint_2",
			amount = 1
		},
		{
			type_items = "cash",
			item_entry = "cash_preorder",
			amount = 1
		}
	}
	self.preorder.content.upgrades = {
		"player_crime_net_deal"
	}
	self.cce = {}
	self.cce.dlc = "has_cce"
	self.cce.content = {}
	self.cce.content.loot_drops = {}
	self.cce.content.upgrades = {
		"player_crime_net_deal_2"
	}
	self.soundtrack = {}
	self.soundtrack.dlc = "has_soundtrack"
	self.soundtrack.content = {}
	self.soundtrack.content.loot_drops = {}
	self.halloween_nightmare_1 = {}
	self.halloween_nightmare_1.dlc = "has_achievement"
	self.halloween_nightmare_1.achievement_id = "halloween_nightmare_1"
	self.halloween_nightmare_1.content = {}
	self.halloween_nightmare_1.content.loot_global_value = "halloween"
	self.halloween_nightmare_1.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "baby_happy",
			amount = 1
		}
	}
	self.halloween_nightmare_2 = {}
	self.halloween_nightmare_2.dlc = "has_achievement"
	self.halloween_nightmare_2.achievement_id = "halloween_nightmare_2"
	self.halloween_nightmare_2.content = {}
	self.halloween_nightmare_2.content.loot_global_value = "halloween"
	self.halloween_nightmare_2.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "brazil_baby",
			amount = 1
		}
	}
	self.halloween_nightmare_3 = {}
	self.halloween_nightmare_3.dlc = "has_achievement"
	self.halloween_nightmare_3.achievement_id = "halloween_nightmare_3"
	self.halloween_nightmare_3.content = {}
	self.halloween_nightmare_3.content.loot_global_value = "halloween"
	self.halloween_nightmare_3.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "baby_angry",
			amount = 1
		}
	}
	self.halloween_nightmare_4 = {}
	self.halloween_nightmare_4.dlc = "has_achievement"
	self.halloween_nightmare_4.achievement_id = "halloween_nightmare_4"
	self.halloween_nightmare_4.content = {}
	self.halloween_nightmare_4.content.loot_global_value = "halloween"
	self.halloween_nightmare_4.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "baby_cry",
			amount = 1
		}
	}
	self.armored_transport = {}
	self.armored_transport.content = {}
	self.armored_transport.dlc = "has_armored_transport"
	self.armored_transport.content.loot_drops = {
		{
			{
				type_items = "masks",
				item_entry = "clinton",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "bush",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "obama",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "nixon",
				amount = 1
			}
		},
		{
			{
				type_items = "materials",
				item_entry = "cash",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "jade",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "redwhiteblue",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "marble",
				amount = 1
			}
		},
		{
			{
				type_items = "textures",
				item_entry = "racestripes",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "americaneagle",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "stars",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "forestcamo",
				amount = 1
			}
		}
	}
	self.armored_transport.content.upgrades = {
		"m45",
		"s552",
		"ppk"
	}
	self.gage_pack = {}
	self.gage_pack.content = {}
	self.gage_pack.dlc = "has_gage_pack"
	self.gage_pack.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_i_singlefire",
			amount = 5
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_i_autofire",
			amount = 5
		},
		{
			{
				type_items = "masks",
				item_entry = "goat",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "panda",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "pitbull",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "eagle",
				amount = 1
			}
		},
		{
			{
				type_items = "materials",
				item_entry = "fur",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "galvanized",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "heavymetal",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "oilmetal",
				amount = 1
			}
		},
		{
			{
				type_items = "textures",
				item_entry = "army",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "commando",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "hunter",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "digitalcamo",
				amount = 1
			}
		}
	}
	self.gage_pack.content.upgrades = {
		"mp7",
		"scar",
		"p226"
	}
	self.gage_pack_lmg = {}
	self.gage_pack_lmg.content = {}
	self.gage_pack_lmg.dlc = "has_gage_pack_lmg"
	self.gage_pack_lmg.content.loot_drops = {
		{
			{
				type_items = "masks",
				item_entry = "cloth_commander",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "gage_blade",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "gage_rambo",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "gage_deltaforce",
				amount = 1
			}
		},
		{
			{
				type_items = "materials",
				item_entry = "gunmetal",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "mud",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "splinter",
				amount = 1
			},
			{
				type_items = "materials",
				item_entry = "erdl",
				amount = 1
			}
		},
		{
			{
				type_items = "textures",
				item_entry = "styx",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "fingerpaint",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "fighter",
				amount = 1
			},
			{
				type_items = "textures",
				item_entry = "warrior",
				amount = 1
			}
		}
	}
	self.gage_pack_lmg.content.upgrades = {"rpk", "kabar"}
	self.gage_pack_snp = {}
	self.gage_pack_snp.content = {}
	self.gage_pack_snp.dlc = "has_gage_pack_snp"
	self.gage_pack_snp.content.loot_drops = {}
	self.gage_pack_snp.content.upgrades = {}
	self.ach_gage3_3 = {}
	self.ach_gage3_3.dlc = "has_achievement"
	self.ach_gage3_3.achievement_id = "gage3_3"
	self.ach_gage3_3.content = {}
	self.ach_gage3_3.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_3.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "robberfly",
			amount = 1
		},
		{
			type_items = "materials",
			item_entry = "carapace",
			amount = 1
		},
		{
			type_items = "textures",
			item_entry = "bugger",
			amount = 1
		}
	}
	self.ach_gage3_4 = {}
	self.ach_gage3_4.dlc = "has_achievement"
	self.ach_gage3_4.achievement_id = "gage3_4"
	self.ach_gage3_4.content = {}
	self.ach_gage3_4.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_4.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "spider",
			amount = 1
		},
		{
			type_items = "materials",
			item_entry = "insectoid",
			amount = 1
		},
		{
			type_items = "textures",
			item_entry = "spidereyes",
			amount = 1
		}
	}
	self.ach_gage3_5 = {}
	self.ach_gage3_5.dlc = "has_achievement"
	self.ach_gage3_5.achievement_id = "gage3_5"
	self.ach_gage3_5.content = {}
	self.ach_gage3_5.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_5.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "wasp",
			amount = 1
		},
		{
			type_items = "materials",
			item_entry = "bugshell",
			amount = 1
		},
		{
			type_items = "textures",
			item_entry = "venomous",
			amount = 1
		}
	}
	self.ach_gage3_6 = {}
	self.ach_gage3_6.dlc = "has_achievement"
	self.ach_gage3_6.achievement_id = "gage3_6"
	self.ach_gage3_6.content = {}
	self.ach_gage3_6.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_6.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "mantis",
			amount = 1
		},
		{
			type_items = "materials",
			item_entry = "hardshell",
			amount = 1
		},
		{
			type_items = "textures",
			item_entry = "wingsofdeath",
			amount = 1
		}
	}
	self.ach_gage3_7 = {}
	self.ach_gage3_7.dlc = "has_achievement"
	self.ach_gage3_7.achievement_id = "gage3_7"
	self.ach_gage3_7.content = {}
	self.ach_gage3_7.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_7.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_m95_barrel_long",
			amount = 1
		}
	}
	self.ach_gage3_8 = {}
	self.ach_gage3_8.dlc = "has_achievement"
	self.ach_gage3_8.achievement_id = "gage3_8"
	self.ach_gage3_8.content = {}
	self.ach_gage3_8.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_8.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_r93_b_suppressed",
			amount = 1
		}
	}
	self.ach_gage3_9 = {}
	self.ach_gage3_9.dlc = "has_achievement"
	self.ach_gage3_9.achievement_id = "gage3_9"
	self.ach_gage3_9.content = {}
	self.ach_gage3_9.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_9.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_o_45iron",
			amount = 1
		}
	}
	self.ach_gage3_10 = {}
	self.ach_gage3_10.dlc = "has_achievement"
	self.ach_gage3_10.achievement_id = "gage3_10"
	self.ach_gage3_10.content = {}
	self.ach_gage3_10.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_10.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_r93_b_short",
			amount = 1
		}
	}
	self.ach_gage3_11 = {}
	self.ach_gage3_11.dlc = "has_achievement"
	self.ach_gage3_11.achievement_id = "gage3_11"
	self.ach_gage3_11.content = {}
	self.ach_gage3_11.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_11.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_m95_barrel_suppressed",
			amount = 1
		}
	}
	self.ach_gage3_12 = {}
	self.ach_gage3_12.dlc = "has_achievement"
	self.ach_gage3_12.achievement_id = "gage3_12"
	self.ach_gage3_12.content = {}
	self.ach_gage3_12.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_12.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_m95_barrel_short",
			amount = 1
		}
	}
	self.ach_gage3_13 = {}
	self.ach_gage3_13.dlc = "has_achievement"
	self.ach_gage3_13.achievement_id = "gage3_13"
	self.ach_gage3_13.content = {}
	self.ach_gage3_13.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_13.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_o_leupold",
			amount = 1
		}
	}
	self.ach_gage3_14 = {}
	self.ach_gage3_14.dlc = "has_achievement"
	self.ach_gage3_14.achievement_id = "gage3_14"
	self.ach_gage3_14.content = {}
	self.ach_gage3_14.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_14.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_msr_body_msr",
			amount = 1
		}
	}
	self.ach_gage3_15 = {}
	self.ach_gage3_15.dlc = "has_achievement"
	self.ach_gage3_15.achievement_id = "gage3_15"
	self.ach_gage3_15.content = {}
	self.ach_gage3_15.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_15.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_r93_body_wood",
			amount = 1
		}
	}
	self.ach_gage3_16 = {}
	self.ach_gage3_16.dlc = "has_achievement"
	self.ach_gage3_16.achievement_id = "gage3_16"
	self.ach_gage3_16.content = {}
	self.ach_gage3_16.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_16.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_msr_ns_suppressor",
			amount = 1
		}
	}
	self.ach_gage3_17 = {}
	self.ach_gage3_17.dlc = "has_achievement"
	self.ach_gage3_17.achievement_id = "gage3_17"
	self.ach_gage3_17.content = {}
	self.ach_gage3_17.content.loot_global_value = "gage_pack_snp"
	self.ach_gage3_17.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_snp_msr_b_long",
			amount = 1
		}
	}
	self.skull_mask_1 = {}
	self.skull_mask_1.dlc = "has_achievement"
	self.skull_mask_1.achievement_id = "death_27"
	self.skull_mask_1.content = {}
	self.skull_mask_1.content.loot_global_value = "infamous"
	self.skull_mask_1.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "skullhard",
			amount = 1
		}
	}
	self.skull_mask_2 = {}
	self.skull_mask_2.dlc = "has_achievement"
	self.skull_mask_2.achievement_id = "death_28"
	self.skull_mask_2.content = {}
	self.skull_mask_2.content.loot_global_value = "infamous"
	self.skull_mask_2.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "skullveryhard",
			amount = 1
		}
	}
	self.skull_mask_3 = {}
	self.skull_mask_3.dlc = "has_achievement"
	self.skull_mask_3.achievement_id = "death_29"
	self.skull_mask_3.content = {}
	self.skull_mask_3.content.loot_global_value = "infamous"
	self.skull_mask_3.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "skulloverkill",
			amount = 1
		}
	}
	self.skull_mask_4 = {}
	self.skull_mask_4.dlc = "has_achievement"
	self.skull_mask_4.achievement_id = "death_30"
	self.skull_mask_4.content = {}
	self.skull_mask_4.content.loot_global_value = "infamous"
	self.skull_mask_4.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "skulloverkillplus",
			amount = 1
		}
	}
	self.charliesierra = {}
	self.charliesierra.content = {}
	self.charliesierra.free = true
	self.charliesierra.content.loot_global_value = "normal"
	self.charliesierra.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_o_acog",
			amount = 1
		}
	}
	self.xmas_soundtrack = {}
	self.xmas_soundtrack.content = {}
	self.xmas_soundtrack.dlc = "has_xmas_soundtrack"
	self.xmas_soundtrack.content.loot_drops = {
		{
			{
				type_items = "masks",
				item_entry = "santa_mad",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "santa_drunk",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "santa_surprise",
				amount = 1
			}
		}
	}
	self.gage_pack_jobs = {}
	self.gage_pack_jobs = {}
	self.gage_pack_jobs.content = {}
	self.gage_pack_jobs.dlc = "has_gage_pack_jobs"
	self.gage_pack_jobs.content.loot_drops = {}
	self.sweettooth = {}
	self.sweettooth.content = {}
	self.sweettooth.dlc = "has_sweettooth"
	self.sweettooth.content.loot_drops = {
		{
			type_items = "masks",
			item_entry = "sweettooth",
			amount = 1
		}
	}
end
