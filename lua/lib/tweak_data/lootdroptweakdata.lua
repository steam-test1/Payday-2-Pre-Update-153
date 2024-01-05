LootDropTweakData = LootDropTweakData or class()

function LootDropTweakData:init(tweak_data)
	self.PC_STEP = 10
	self.no_drop = {}
	self.no_drop.BASE = 35
	self.no_drop.HUMAN_STEP_MODIFIER = 10
	self.joker_chance = 0
	self.level_limit = 1
	self.risk_pc_multiplier = {
		0,
		0,
		0,
		0
	}
	self.risk_infamous_multiplier = {
		1,
		2,
		3
	}
	self.PC_CHANCE = {}
	self.PC_CHANCE[1] = 0.7
	self.PC_CHANCE[2] = 0.7
	self.PC_CHANCE[3] = 0.7
	self.PC_CHANCE[4] = 0.7
	self.PC_CHANCE[5] = 0.9
	self.PC_CHANCE[6] = 0.91
	self.PC_CHANCE[7] = 0.92
	self.PC_CHANCE[8] = 0.93
	self.PC_CHANCE[9] = 0.94
	self.PC_CHANCE[10] = 0.95
	self.STARS = {}
	self.STARS[1] = {
		pcs = {10, 10}
	}
	self.STARS[2] = {
		pcs = {20, 20}
	}
	self.STARS[3] = {
		pcs = {30, 30}
	}
	self.STARS[4] = {
		pcs = {40, 40}
	}
	self.STARS[5] = {
		pcs = {40, 40}
	}
	self.STARS[6] = {
		pcs = {40, 40}
	}
	self.STARS[7] = {
		pcs = {40, 40}
	}
	self.STARS[8] = {
		pcs = {40, 40}
	}
	self.STARS[9] = {
		pcs = {40, 40}
	}
	self.STARS[10] = {
		pcs = {40, 40}
	}
	self.STARS_CURVES = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
	self.WEIGHTED_TYPE_CHANCE = {}
	local min = 10
	local max = 100
	local range = {
		cash = {20, 5},
		weapon_mods = {50, 45},
		colors = {6, 11},
		textures = {7, 12},
		materials = {7, 12},
		masks = {10, 15},
		xp = {8, 0}
	}
	for i = min, max, 10 do
		local cash = math.lerp(range.cash[1], range.cash[2], i / max)
		local weapon_mods = math.lerp(range.weapon_mods[1], range.weapon_mods[2], i / max)
		local colors = math.lerp(range.colors[1], range.colors[2], i / max)
		local textures = math.lerp(range.textures[1], range.textures[2], i / max)
		local materials = math.lerp(range.materials[1], range.materials[2], i / max)
		local masks = math.lerp(range.masks[1], range.masks[2], i / max)
		local xp = math.lerp(range.xp[1], range.xp[2], i / max)
		self.WEIGHTED_TYPE_CHANCE[i] = {
			cash = cash,
			weapon_mods = weapon_mods,
			colors = colors,
			textures = textures,
			materials = materials,
			masks = masks,
			xp = xp
		}
	end
	self.DEFAULT_WEIGHT = 1
	self.got_item_weight_mod = 0.5
	self.type_weight_mod_funcs = {}
	
	function self.type_weight_mod_funcs.weapon_mods(global_value, category, id)
		local weapons = managers.weapon_factory:get_weapons_uses_part(id)
		local primaries = managers.blackmarket:get_crafted_category("primaries")
		local secondaries = managers.blackmarket:get_crafted_category("secondaries")
		local crafted_weapons = {}
		for _, weapon in pairs(primaries) do
			table.insert(crafted_weapons, weapon.factory_id)
		end
		for _, weapon in pairs(secondaries) do
			table.insert(crafted_weapons, weapon.factory_id)
		end
		table.list_union(crafted_weapons)
		for _, factory_id in pairs(weapons) do
			if table.contains(crafted_weapons, factory_id) then
				return 2
			end
		end
		return 1
	end
	
	self.global_values = {}
	self.global_values.normal = {}
	self.global_values.normal.name_id = "bm_global_value_normal"
	self.global_values.normal.desc_id = "menu_l_global_value_normal"
	self.global_values.normal.color = Color.white
	self.global_values.normal.dlc = false
	self.global_values.normal.chance = 0.84
	self.global_values.normal.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "normal")
	self.global_values.normal.durability_multiplier = 1
	self.global_values.normal.drops = true
	self.global_values.normal.track = false
	self.global_values.normal.sort_number = 0
	self.global_values.superior = {}
	self.global_values.superior.name_id = "bm_global_value_superior"
	self.global_values.superior.desc_id = "menu_l_global_value_superior"
	self.global_values.superior.color = Color.blue
	self.global_values.superior.dlc = false
	self.global_values.superior.chance = 0.1
	self.global_values.superior.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "superior")
	self.global_values.superior.durability_multiplier = 1.5
	self.global_values.superior.drops = false
	self.global_values.superior.track = false
	self.global_values.superior.sort_number = 100
	self.global_values.exceptional = {}
	self.global_values.exceptional.name_id = "bm_global_value_exceptional"
	self.global_values.exceptional.desc_id = "menu_l_global_value_exceptional"
	self.global_values.exceptional.color = Color.yellow
	self.global_values.exceptional.dlc = false
	self.global_values.exceptional.chance = 0.05
	self.global_values.exceptional.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "exceptional")
	self.global_values.exceptional.durability_multiplier = 2.25
	self.global_values.exceptional.drops = false
	self.global_values.exceptional.track = false
	self.global_values.exceptional.sort_number = 200
	self.global_values.infamous = {}
	self.global_values.infamous.name_id = "bm_global_value_infamous"
	self.global_values.infamous.desc_id = "menu_l_global_value_infamous"
	self.global_values.infamous.color = Color(1, 0.1, 1)
	self.global_values.infamous.dlc = false
	self.global_values.infamous.chance = 0.05
	self.global_values.infamous.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "infamous")
	self.global_values.infamous.durability_multiplier = 3
	self.global_values.infamous.drops = true
	self.global_values.infamous.track = false
	self.global_values.infamous.sort_number = 300
	self.global_values.preorder = {}
	self.global_values.preorder.name_id = "bm_global_value_preorder"
	self.global_values.preorder.desc_id = "menu_l_global_value_preorder"
	self.global_values.preorder.color = Color(255, 255, 140, 0) / 255
	self.global_values.preorder.dlc = true
	self.global_values.preorder.chance = 1
	self.global_values.preorder.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "preorder")
	self.global_values.preorder.durability_multiplier = 1
	self.global_values.preorder.drops = false
	self.global_values.preorder.track = true
	self.global_values.preorder.sort_number = -5
	self.global_values.preorder.hide_unavailable = true
	self.global_values.pd2_clan = {}
	self.global_values.pd2_clan.name_id = "bm_global_value_pd2_clan"
	self.global_values.pd2_clan.desc_id = "menu_l_global_value_pd2_clan"
	self.global_values.pd2_clan.unlock_id = "bm_global_value_pd2_clan_unlock"
	self.global_values.pd2_clan.color = Color(255, 59, 174, 254) / 255
	self.global_values.pd2_clan.dlc = true
	self.global_values.pd2_clan.chance = 1
	self.global_values.pd2_clan.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "pd2_clan")
	self.global_values.pd2_clan.durability_multiplier = 1
	self.global_values.pd2_clan.drops = true
	self.global_values.pd2_clan.track = true
	self.global_values.pd2_clan.sort_number = -10
	self.global_values.pd2_clan.unique_lock_icon = "guis/textures/pd2/lock_community"
	self.global_values.halloween = {}
	self.global_values.halloween.name_id = "bm_global_value_halloween"
	self.global_values.halloween.desc_id = "menu_l_global_value_halloween"
	self.global_values.halloween.color = Color(255, 255, 145, 0) / 255
	self.global_values.halloween.dlc = false
	self.global_values.halloween.chance = 1
	self.global_values.halloween.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "halloween")
	self.global_values.halloween.durability_multiplier = 1
	self.global_values.halloween.drops = true
	self.global_values.halloween.track = true
	self.global_values.halloween.sort_number = 200
	self.global_values.armored_transport = {}
	self.global_values.armored_transport.name_id = "bm_global_value_armored_transport"
	self.global_values.armored_transport.desc_id = "menu_l_global_value_armored_transport"
	self.global_values.armored_transport.unlock_id = "bm_global_value_armored_transport_unlock"
	self.global_values.armored_transport.color = Color(255, 255, 212, 0) / 255
	self.global_values.armored_transport.dlc = true
	self.global_values.armored_transport.chance = 1
	self.global_values.armored_transport.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "armored_transport")
	self.global_values.armored_transport.durability_multiplier = 1
	self.global_values.armored_transport.drops = true
	self.global_values.armored_transport.track = true
	self.global_values.armored_transport.sort_number = 400
	self.global_values.gage_pack = {}
	self.global_values.gage_pack.name_id = "bm_global_value_gage_pack"
	self.global_values.gage_pack.desc_id = "menu_l_global_value_gage_pack"
	self.global_values.gage_pack.unlock_id = "bm_global_value_gage_pack_unlock"
	self.global_values.gage_pack.color = Color(255, 255, 212, 0) / 255
	self.global_values.gage_pack.dlc = true
	self.global_values.gage_pack.chance = 1
	self.global_values.gage_pack.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "gage_pack")
	self.global_values.gage_pack.durability_multiplier = 1
	self.global_values.gage_pack.drops = true
	self.global_values.gage_pack.track = true
	self.global_values.gage_pack.sort_number = 410
	self.global_values.legendary = {}
	self.global_values.legendary.name_id = "bm_global_value_legendary"
	self.global_values.legendary.desc_id = "menu_l_global_value_legendary"
	self.global_values.legendary.color = Color(255, 0, 255, 212) / 255
	self.global_values.legendary.dlc = false
	self.global_values.legendary.chance = 1
	self.global_values.legendary.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "legendary")
	self.global_values.legendary.durability_multiplier = 1
	self.global_values.legendary.drops = false
	self.global_values.legendary.track = false
	self.global_values.legendary.sort_number = 1
	self.global_values.sweettooth = {}
	self.global_values.sweettooth.name_id = "bm_global_value_sweettooth"
	self.global_values.sweettooth.desc_id = "menu_l_global_value_sweettooth"
	self.global_values.sweettooth.unlock_id = "bm_global_value_sweettooth_unlock"
	self.global_values.sweettooth.color = Color(255, 59, 174, 254) / 255
	self.global_values.sweettooth.dlc = true
	self.global_values.sweettooth.chance = 1
	self.global_values.sweettooth.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "sweettooth")
	self.global_values.sweettooth.durability_multiplier = 1
	self.global_values.sweettooth.drops = true
	self.global_values.sweettooth.track = true
	self.global_values.sweettooth.sort_number = 200
	self.global_value_list_index = {
		"normal",
		"infamous",
		"pre_order",
		"pd2_clan",
		"halloween",
		"armored_transport"
	}
	self.global_value_list_map = {}
	for i, d in ipairs(self.global_value_list_index) do
		self.global_value_list_map[d] = i
	end
end
