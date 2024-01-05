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
	self.PC_CHANCE = {}
	self.PC_CHANCE[1] = 0.7
	self.PC_CHANCE[2] = 0.7
	self.PC_CHANCE[3] = 0.7
	self.PC_CHANCE[4] = 0.7
	self.PC_CHANCE[5] = 0.7
	self.PC_CHANCE[6] = 0.7
	self.PC_CHANCE[7] = 0.7
	self.PC_CHANCE[8] = 0.7
	self.PC_CHANCE[9] = 0.7
	self.PC_CHANCE[10] = 0.7
	self.STARS = {}
	self.STARS[1] = {
		pcs = {
			10,
			100,
			100
		}
	}
	self.STARS[2] = {
		pcs = {
			20,
			100,
			100
		}
	}
	self.STARS[3] = {
		pcs = {
			30,
			100,
			100
		}
	}
	self.STARS[4] = {
		pcs = {
			40,
			100,
			100
		}
	}
	self.STARS[5] = {
		pcs = {
			40,
			100,
			100
		}
	}
	self.STARS[6] = {
		pcs = {
			40,
			100,
			100
		}
	}
	self.STARS[7] = {
		pcs = {
			40,
			100,
			100
		}
	}
	self.STARS[8] = {
		pcs = {
			40,
			100,
			100
		}
	}
	self.STARS[9] = {
		pcs = {
			40,
			100,
			100
		}
	}
	self.STARS[10] = {
		pcs = {
			40,
			100,
			100
		}
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
		cash = {20, 20},
		weapon_mods = {50, 50},
		colors = {6, 6},
		textures = {7, 7},
		materials = {7, 7},
		masks = {10, 10}
	}
	for i = min, max, 10 do
		local cash = math.lerp(range.cash[1], range.cash[2], i / max)
		local weapon_mods = math.lerp(range.weapon_mods[1], range.weapon_mods[2], i / max)
		local colors = math.lerp(range.colors[1], range.colors[2], i / max)
		local textures = math.lerp(range.textures[1], range.textures[2], i / max)
		local materials = math.lerp(range.materials[1], range.materials[2], i / max)
		local masks = math.lerp(range.masks[1], range.masks[2], i / max)
		self.WEIGHTED_TYPE_CHANCE[i] = {
			cash = cash,
			weapon_mods = weapon_mods,
			colors = colors,
			textures = textures,
			materials = materials,
			masks = masks
		}
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
	self.global_values.overkill = {}
	self.global_values.overkill.name_id = "bm_global_value_overkill"
	self.global_values.overkill.desc_id = "menu_l_global_value_overkill"
	self.global_values.overkill.color = Color(1, 0, 0)
	self.global_values.overkill.dlc = true
	self.global_values.overkill.chance = 1
	self.global_values.overkill.value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", "overkill")
	self.global_values.overkill.durability_multiplier = 1
	self.global_values.overkill.drops = false
	self.global_values.overkill.track = true
	self.global_values.overkill.sort_number = 0
end
