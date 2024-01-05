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
	self.halloween = {}
	self.halloween.free = true
	self.halloween.content = {}
	self.halloween.content.loot_drops = {
		{
			{
				type_items = "masks",
				item_entry = "pumpkin_king",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "witch",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "venomorph",
				amount = 1
			},
			{
				type_items = "masks",
				item_entry = "frank",
				amount = 1
			}
		}
	}
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
end
