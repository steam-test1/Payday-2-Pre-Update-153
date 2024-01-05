MoneyTweakData = MoneyTweakData or class()

function MoneyTweakData._create_value_table(min, max, table_size, round, curve)
	local t = {}
	for i = 1, table_size do
		local v = math.lerp(min, max, math.pow((i - 1) / (table_size - 1), curve and curve or 1))
		if 999 < v then
			v = v * 0.001
			v = round and math.ceil(v) or v
			v = v * 1000
		elseif 99 < v then
			v = v * 0.01
			v = round and math.ceil(v) or v
			v = v * 100
		elseif 9 < v then
			v = v * 0.1
			v = round and math.ceil(v) or v
			v = v * 10
		else
			v = round and math.ceil(v) or v
		end
		table.insert(t, v)
	end
	return t
end

function MoneyTweakData._test_curves(pay, bags, alive_players, diff, days)
	local v
	local loot_bags = tweak_data:get_value("money_manager", "bag_value_multiplier", pay) * tweak_data:get_value("money_manager", "bag_values", "default")
	local diff_multiplier = 0
	if 0 < diff then
		diff_multiplier = tweak_data:get_value("money_manager", "difficulty_multiplier", diff + 1)
	end
	v = tweak_data:get_value("money_manager", "stage_completion", pay) + tweak_data:get_value("money_manager", "job_completion", pay) + loot_bags * bags + tweak_data:get_value("money_manager", "flat_stage_completion") + tweak_data:get_value("money_manager", "flat_job_completion")
	v = v * days
	v = v + v * diff_multiplier
	v = v * tweak_data:get_value("money_manager", "alive_humans_multiplier", alive_players)
	print(v, v * tweak_data:get_value("money_manager", "offshore_rate"))
end

function MoneyTweakData:init()
	self.biggest_score = 4000000
	self.biggest_cashout = 800000
	self.offshore_rate = self.biggest_cashout / self.biggest_score
	self.alive_players_max = 1.1
	self.cashout_without_player_alive = self.biggest_cashout / self.alive_players_max
	self.cut_difficulty = 4
	self.max_mission_bags = 6
	self.cut_lootbag_bonus = self.cashout_without_player_alive * 0.3
	self.cut_lootbag_bonus = self.cut_lootbag_bonus / self.max_mission_bags / self.cut_difficulty
	self.max_days = 3
	self.cut_stage_complete = self.cashout_without_player_alive * 0.55
	self.cut_stage_complete = self.cut_stage_complete / self.cut_difficulty * 0.7
	self.cut_job_complete = self.cashout_without_player_alive * 0.15
	self.cut_job_complete = self.cut_job_complete / self.cut_difficulty
	self.bag_values = {}
	self.bag_values.default = 900
	self.bag_values.money = 750
	self.bag_values.gold = 1000
	self.bag_values.diamonds = 500
	self.bag_values.coke = 900
	self.bag_values.meth = 1000
	self.bag_values.weapon = 950
	self.bag_values.weapons = 950
	self.bag_values.shells = 2100
	self.bag_values.turret = 10000
	self.bag_value_multiplier = self._create_value_table(self.cut_lootbag_bonus / 5 / self.offshore_rate / self.bag_values.default, self.cut_lootbag_bonus / self.offshore_rate / self.bag_values.default, 7, true, 0.85)
	self.stage_completion = self._create_value_table(self.cut_stage_complete / 7 / self.offshore_rate, self.cut_stage_complete / self.offshore_rate, 7, true, 1)
	self.job_completion = self._create_value_table(self.cut_job_complete / 7 / self.offshore_rate, self.cut_job_complete / self.offshore_rate, 7, true, 1)
	self.flat_stage_completion = math.round(10000 / self.offshore_rate)
	self.flat_job_completion = 0
	self.level_limit = {}
	self.level_limit.low_cap_level = -1
	self.level_limit.low_cap_multiplier = 0.75
	self.level_limit.pc_difference_multipliers = {
		1,
		0.9,
		0.8,
		0.7,
		0.6,
		0.5,
		0.4,
		0.3,
		0.2,
		0.1
	}
	self.stage_failed_multiplier = 0.1
	self.difficulty_multiplier = {
		4,
		9,
		12,
		20,
		40
	}
	self.small_loot_difficulty_multiplier = self._create_value_table(0, 0, 4, false, 1)
	self.alive_humans_multiplier = self._create_value_table(1, self.alive_players_max, 4, false, 1)
	self.limited_bonus_multiplier = 1
	self.sell_weapon_multiplier = 0.25
	self.sell_mask_multiplier = 0.25
	self.killing_civilian_deduction = self._create_value_table(2000, 50000, 10, true, 2)
	self.buy_premium_multiplier = {
		easy = 0.5,
		normal = 0.75,
		hard = 1.25,
		overkill = 1.5,
		overkill_145 = 2,
		overkill_290 = 4
	}
	self.buy_premium_static_fee = {
		easy = 100000,
		normal = 100000,
		hard = 150000,
		overkill = 200000,
		overkill_145 = 300000,
		overkill_290 = 600000
	}
	self.global_value_multipliers = {}
	self.global_value_multipliers.normal = 1
	self.global_value_multipliers.superior = 1
	self.global_value_multipliers.exceptional = 1
	self.global_value_multipliers.infamous = 5
	self.global_value_multipliers.infamy = 0
	self.global_value_multipliers.preorder = 1
	self.global_value_multipliers.overkill = 0.01
	self.global_value_multipliers.pd2_clan = 1
	self.global_value_multipliers.halloween = 1
	self.global_value_multipliers.xmas = 1
	self.global_value_multipliers.armored_transport = 1.2
	self.global_value_multipliers.gage_pack = 1.4
	self.global_value_multipliers.gage_pack_lmg = 1.8
	self.global_value_multipliers.xmas_soundtrack = 1
	self.global_value_multipliers.sweettooth = 1
	self.global_value_multipliers.legendary = 1
	self.global_value_bonus_multiplier = {}
	self.global_value_bonus_multiplier.normal = 0
	self.global_value_bonus_multiplier.superior = 0.1
	self.global_value_bonus_multiplier.exceptional = 0.2
	self.global_value_bonus_multiplier.infamous = 1
	self.global_value_bonus_multiplier.infamy = 1
	self.global_value_bonus_multiplier.preorder = 0
	self.global_value_bonus_multiplier.overkill = 20
	self.global_value_bonus_multiplier.pd2_clan = 0
	self.global_value_bonus_multiplier.halloween = 0
	self.global_value_bonus_multiplier.xmas = 0
	self.global_value_bonus_multiplier.armored_transport = 0.5
	self.global_value_bonus_multiplier.gage_pack = 0.5
	self.global_value_bonus_multiplier.gage_pack_lmg = 0.5
	self.global_value_bonus_multiplier.xmas_soundtrack = 0
	self.global_value_bonus_multiplier.sweettooth = 0
	self.global_value_bonus_multiplier.legendary = 0
	local smallest_cashout = (self.stage_completion[1] + self.job_completion[1]) * self.offshore_rate
	local biggest_mask_cost = self.biggest_cashout * 40
	local biggest_mask_cost_deinfamous = math.round(biggest_mask_cost / self.global_value_multipliers.infamous)
	local biggest_mask_part_cost = math.round(smallest_cashout * 20)
	local smallest_mask_part_cost = math.round(smallest_cashout * 1.9)
	local biggest_weapon_cost = math.round(self.biggest_cashout * 1.15)
	local smallest_weapon_cost = math.round(smallest_cashout * 3)
	local biggest_weapon_mod_cost = math.round(self.biggest_cashout * 0.5)
	local smallest_weapon_mod_cost = math.round(smallest_cashout * 3)
	self.weapon_cost = self._create_value_table(smallest_weapon_cost, biggest_weapon_cost, 40, true, 1.1)
	self.modify_weapon_cost = self._create_value_table(smallest_weapon_mod_cost, biggest_weapon_mod_cost, 10, true, 1.2)
	self.remove_weapon_mod_cost_multiplier = self._create_value_table(1, 1, 10, true, 1)
	self.masks = {}
	self.masks.mask_value = self._create_value_table(smallest_mask_part_cost, smallest_mask_part_cost * 2, 10, true, 2)
	self.masks.material_value = self._create_value_table(smallest_mask_part_cost * 0.5, biggest_mask_part_cost, 10, true, 1.2)
	self.masks.pattern_value = self._create_value_table(smallest_mask_part_cost * 0.4, biggest_mask_part_cost, 10, true, 1.1)
	self.masks.color_value = self._create_value_table(smallest_mask_part_cost * 0.3, biggest_mask_part_cost, 10, true, 1)
	self.mission_asset_cost_by_pc = self._create_value_table(1, 1, 10, true, 1)
	self.mission_asset_cost_multiplier_by_pc = {
		0,
		0,
		0,
		0,
		0,
		0,
		1
	}
	self.mission_asset_cost_multiplier_by_risk = {
		0.5,
		1,
		2,
		4
	}
	self.mission_asset_cost_small = self._create_value_table(2500, 15000, 10, true, 1)
	self.mission_asset_cost_medium = self._create_value_table(10000, 45000, 10, true, 1)
	self.mission_asset_cost_large = self._create_value_table(55000, 400000, 10, true, 1)
	self.small_loot_value_multiplier = {
		100,
		100,
		100,
		100,
		100,
		100,
		100,
		100,
		100,
		100,
		100
	}
	self.small_loot = {}
	self.small_loot.money_bundle = 10
	self.small_loot.diamondheist_vault_bust = 12
	self.small_loot.diamondheist_vault_diamond = 15
	self.small_loot.diamondheist_big_diamond = 15
	self.small_loot.value_gold = 30
	self.small_loot.gen_atm = 220
	self.small_loot.special_deposit_box = 35
	self.small_loot.vault_loot_gold = 100
	self.small_loot.vault_loot_cash = 50
	self.small_loot.vault_loot_coins = 35
	self.small_loot.vault_loot_ring = 15
	self.small_loot.vault_loot_jewels = 25
	self.small_loot.vault_loot_macka = 0.01
	self.skilltree = {}
	self.skilltree.respec = {}
	self.skilltree.respec.base_cost = 200
	self.skilltree.respec.profile_cost_increaser_multiplier = {
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
	self.skilltree.respec.tier_cost = {}
	self.skilltree.respec.tier_cost[1] = 1500
	self.skilltree.respec.tier_cost[2] = 2000
	self.skilltree.respec.tier_cost[3] = 10000
	self.skilltree.respec.tier_cost[4] = 40000
	self.skilltree.respec.tier_cost[5] = 100000
	self.skilltree.respec.tier_cost[6] = 400000
	self.skilltree.respec.base_point_cost = 500
	self.skilltree.respec.point_tier_cost = self._create_value_table(4000, self.biggest_cashout * 0.18, 6, true, 1.1)
	self.skilltree.respec.respec_refund_multiplier = 0.6
	self.skilltree.respec.point_cost = 0
	self.skilltree.respec.point_multiplier_cost = 1
	local loot_drop_value = 10000
	self.loot_drop_cash = {}
	self.loot_drop_cash.cash10 = loot_drop_value * 2
	self.loot_drop_cash.cash20 = loot_drop_value * 4
	self.loot_drop_cash.cash30 = loot_drop_value * 6
	self.loot_drop_cash.cash40 = loot_drop_value * 8
	self.loot_drop_cash.cash50 = loot_drop_value * 9
	self.loot_drop_cash.cash60 = loot_drop_value * 10
	self.loot_drop_cash.cash70 = loot_drop_value * 11
	self.loot_drop_cash.cash80 = loot_drop_value * 12
	self.loot_drop_cash.cash90 = loot_drop_value * 13
	self.loot_drop_cash.cash100 = loot_drop_value * 14
	self.loot_drop_cash.cash_preorder = self.biggest_cashout / 10
	self.unlock_new_mask_slot_value = self.biggest_cashout
	self.unlock_new_weapon_slot_value = self.biggest_cashout
end
