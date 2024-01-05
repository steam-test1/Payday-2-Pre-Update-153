MoneyManager = MoneyManager or class()

function MoneyManager:init()
	self:_setup()
end

function MoneyManager:_setup()
	if not Global.money_manager then
		Global.money_manager = {}
		Global.money_manager.total = Application:digest_value(0, true)
		Global.money_manager.total_collected = Application:digest_value(0, true)
		Global.money_manager.offshore = Application:digest_value(0, true)
		Global.money_manager.total_spent = Application:digest_value(0, true)
	end
	self._global = Global.money_manager
	self._heist_total = 0
	self._heist_spending = 0
	self._heist_offshore = 0
	self._active_multipliers = {}
	self._stage_payout = 0
	self._job_payout = 0
	self._bag_payout = 0
	self._small_loot_payout = 0
	self._crew_payout = 0
	self._cash_tousand_separator = managers.localization:text("cash_tousand_separator")
	self._cash_sign = managers.localization:text("cash_sign")
end

function MoneyManager:total_string_no_currency()
	local total = math.round(self:total())
	total = tostring(total)
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return string.reverse(s)
end

function MoneyManager:total_string()
	local total = math.round(self:total())
	total = tostring(total)
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return self._cash_sign .. string.reverse(s)
end

function MoneyManager:total_collected_string_no_currency()
	local total = math.round(self:total_collected())
	total = tostring(total)
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return string.reverse(s)
end

function MoneyManager:total_collected_string()
	local total = math.round(self:total_collected())
	total = tostring(total)
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return self._cash_sign .. string.reverse(s)
end

function MoneyManager:add_decimal_marks_to_string(string)
	local total = string
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return string.reverse(s)
end

function MoneyManager:use_multiplier(multiplier)
	if not tweak_data.money_manager.multipliers[multiplier] then
		Application:error("Unknown multiplier \"" .. tostring(multiplier) .. " in money manager.")
		return
	end
	self._active_multipliers[multiplier] = tweak_data.money_manager.multipliers[multiplier]
end

function MoneyManager:remove_multiplier(multiplier)
	if not tweak_data.money_manager.multipliers[multiplier] then
		Application:error("Unknown multiplier \"" .. tostring(multiplier) .. " in money manager.")
		return
	end
	self._active_multipliers[multiplier] = nil
end

function MoneyManager:perform_action(action)
	return
end

function MoneyManager:perform_action_interact(name)
	return
end

function MoneyManager:perform_action_money_wrap(amount)
	self:_add(amount)
end

function MoneyManager:get_civilian_deduction()
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	return math.round(tweak_data:get_value("money_manager", "killing_civilian_deduction", job_and_difficulty_stars))
end

function MoneyManager:civilian_killed()
	local deduct_amount = self:get_civilian_deduction()
	local text = managers.localization:text("hud_civilian_killed_message", {
		AMOUNT = managers.experience:cash_string(deduct_amount)
	})
	local title = managers.localization:text("hud_civilian_killed_title")
	managers.hud:present_mid_text({
		text = text,
		title = title,
		time = 4
	})
	self:_deduct_from_total(deduct_amount)
end

function MoneyManager:on_mission_completed(num_winners)
	if managers.job:skip_money() then
		managers.loot:set_postponed_small_loot()
		return
	end
	local stage_value, job_value, bag_value, small_value, crew_value, total_payout, risk_table = self:get_real_job_money_values(num_winners)
	managers.loot:clear_postponed_small_loot()
	self:_set_stage_payout(stage_value + risk_table.stage_risk)
	self:_set_job_payout(job_value + risk_table.job_risk)
	self:_set_bag_payout(bag_value + risk_table.bag_risk)
	self:_set_small_loot_payout(small_value + risk_table.small_risk)
	self:_set_crew_payout(crew_value)
	self:_add_to_total(total_payout)
end

function MoneyManager:get_contract_money_by_stars(job_stars, risk_stars, job_days)
	local job_and_difficulty_stars = job_stars + risk_stars
	local job_stars = job_stars
	local difficulty_stars = risk_stars
	local player_stars = managers.experience:level_to_stars()
	local params = {}
	params.job_stars = job_stars
	params.difficulty_stars = difficulty_stars
	params.success = true
	params.num_winners = 1
	params.on_last_stage = true
	params.player_stars = player_stars
	params.secured_bags = 0
	params.small_value = 0
	local stage_value, job_value, bag_value, small_value, crew_value, total_payout, risk_table = self:get_money_by_params(params)
	local stage_risk_value = risk_table.stage_risk
	local job_risk_value = risk_table.job_risk
	local total_stage_value = 0
	local total_stage_risk_value = 0
	for i = 1, job_days do
		total_stage_value = total_stage_value + stage_value
		total_stage_risk_value = total_stage_risk_value + stage_risk_value
	end
	local total_job_value = job_value
	local total_job_risk_value = job_risk_value
	total_payout = total_stage_value + total_stage_risk_value + total_job_value + total_job_risk_value
	return total_payout, {
		stage_value,
		total_stage_value,
		stage_risk_value,
		total_stage_risk_value
	}, {
		job_value,
		total_job_value,
		job_risk_value,
		total_job_risk_value
	}
end

function MoneyManager:get_money_by_params(params)
	local job_stars = params.job_stars or 0
	local difficulty_stars = params.difficulty_stars or params.risk_stars or 0
	local job_and_difficulty_stars = job_stars + difficulty_stars
	local success = params.success
	local num_winners = params.num_winners or 1
	local on_last_stage = params.on_last_stage
	local current_job_stage = params.current_stage or 1
	local player_stars = params.player_stars or managers.experience:level_to_stars() or 0
	local total_stars = math.min(job_stars, player_stars)
	local total_difficulty_stars = difficulty_stars
	local money_multiplier = managers.money:get_contract_difficulty_multiplier(total_difficulty_stars) or 0
	local small_loot_multiplier = managers.money:get_small_loot_difficulty_multiplier(total_difficulty_stars) or 0
	local secured_bags = params.secured_bags or managers.loot:get_secured_bonus_bags_value()
	local real_small_value = params.small_value or math.round(managers.loot:get_real_total_small_loot_value())
	local stage_value = self:get_stage_payout_by_stars(total_stars) or 0
	local job_value = 0
	local bag_value = 0
	local crew_value = 0
	local small_value = real_small_value + managers.loot:get_real_total_postponed_small_loot_value()
	local stage_risk = 0
	local job_risk = 0
	local bag_risk = 0
	local small_risk = 0
	if on_last_stage then
		job_value = self:get_job_payout_by_stars(total_stars) or 0
		bag_value = secured_bags * tweak_data:get_value("money_manager", "bag_value_multiplier", total_stars)
	end
	local total_payout = 0
	local is_level_limited = job_stars > player_stars
	if is_level_limited and 0 < stage_value then
		local unlimited_stage_value = self:get_stage_payout_by_stars(job_stars) or 0
		local unlimited_job_value = 0
		local unlimited_bag_value = 0
		local unlimited_small_value = real_small_value
		if managers.job:on_last_stage() then
			unlimited_job_value = self:get_job_payout_by_stars(job_stars) or 0
			unlimited_bag_value = secured_bags * tweak_data:get_value("money_manager", "bag_value_multiplier", job_stars)
		end
		local unlimited_payout = unlimited_stage_value + unlimited_job_value + unlimited_bag_value + unlimited_small_value
		total_payout = math.round(stage_value + job_value + bag_value + small_value)
		local diff_in_money = unlimited_payout - total_payout
		local diff_in_stars = job_stars - player_stars
		local tweak_multiplier = tweak_data:get_value("money_manager", "level_limit", "pc_difference_multipliers", diff_in_stars) or 0
		local new_total_payout = total_payout + math.round(diff_in_money * tweak_multiplier)
		local stage_ratio = stage_value / total_payout
		local small_ratio = small_value / total_payout
		local bag_ratio = bag_value / total_payout
		local job_ratio = job_value / total_payout
		stage_value = math.round(new_total_payout * stage_ratio)
		small_value = math.round(new_total_payout * small_ratio)
		bag_value = math.round(new_total_payout * bag_ratio)
		job_value = math.round(new_total_payout * job_ratio)
		local rounding_error = new_total_payout - (stage_value + small_value + bag_value + job_value)
		job_value = job_value + rounding_error
	end
	local stage_risk = math.round(stage_value * money_multiplier)
	local job_risk = math.round(job_value * money_multiplier)
	local bag_risk = math.round(bag_value * money_multiplier)
	local small_risk = math.round(small_value * small_loot_multiplier)
	total_payout = stage_value + job_value + bag_value + small_value
	total_payout = total_payout + stage_risk + job_risk + bag_risk + small_risk
	total_payout = math.round(total_payout)
	crew_value = total_payout
	total_payout = math.round(total_payout * (tweak_data:get_value("money_manager", "alive_humans_multiplier", num_winners) or 1))
	crew_value = math.round(total_payout - crew_value)
	total_payout = total_payout + tweak_data:get_value("money_manager", "flat_stage_completion")
	stage_value = stage_value + tweak_data:get_value("money_manager", "flat_stage_completion")
	if on_last_stage then
		total_payout = total_payout + tweak_data:get_value("money_manager", "flat_job_completion")
		job_value = job_value + tweak_data:get_value("money_manager", "flat_job_completion")
	end
	return stage_value, job_value, bag_value, small_value, crew_value, total_payout, {
		stage_risk = stage_risk,
		job_risk = job_risk,
		bag_risk = bag_risk,
		small_risk = small_risk
	}
end

function MoneyManager:get_real_job_money_values(num_winners)
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local current_stage = has_active_job and managers.job:current_stage() or 1
	local is_professional = has_active_job and managers.job:is_current_job_professional() or false
	local on_last_stage = has_active_job and managers.job:on_last_stage()
	return self:get_money_by_params({
		job_stars = job_stars,
		difficulty_stars = difficulty_stars,
		current_stage = current_stage,
		professional = is_professional,
		success = true,
		num_winners = num_winners,
		on_last_stage = on_last_stage
	})
end

function MoneyManager:on_stage_completed(num_winners)
	if not managers.job:has_active_job() then
		return 0
	end
	local stage_value = self:_get_contract_money(false, nil)
	local amount = stage_value
	amount = math.round(amount * tweak_data:get_value("money_manager", "alive_humans_multiplier", num_winners))
	self:_add_to_total(amount)
	self:_set_stage_payout(stage_value)
	self:_set_crew_payout(amount - stage_value)
	return amount
end

function MoneyManager:on_job_completed(num_winners)
	if not managers.job:has_active_job() then
		return 0
	end
	local stage_value = self:_get_contract_money(false, nil)
	local job_value = self:_get_contract_money(true, nil)
	local bag_value = self:get_secured_bonus_bags_money()
	local amount = stage_value + job_value
	amount = amount + bag_value
	amount = math.round(amount * tweak_data:get_value("money_manager", "alive_humans_multiplier", num_winners))
	self:_add_to_total(amount)
	self:_set_stage_payout(stage_value)
	self:_set_job_payout(job_value)
	self:_set_bag_payout(bag_value)
	self:_set_crew_payout(amount - stage_value - job_value - bag_value)
	return amount
end

function MoneyManager:get_secured_bonus_bags_money()
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local player_stars = managers.experience:level_to_stars()
	local is_level_limited = job_and_difficulty_stars > player_stars
	local total_stars = job_and_difficulty_stars
	local total_difficulty_stars = math.max(0, total_stars - job_stars)
	local money_multiplier = managers.money:get_contract_difficulty_multiplier(total_difficulty_stars) or 0
	total_stars = math.min(job_stars, total_stars)
	local secured_bags = managers.loot:get_secured_bonus_bags_value()
	local bag_value = 0
	bag_value = secured_bags * tweak_data:get_value("money_manager", "bag_value_multiplier", total_stars)
	bag_value = math.round(bag_value)
	return bag_value
end

function MoneyManager:_get_contract_money(is_job, success)
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local player_stars = managers.experience:level_to_stars()
	local total_stars = math.min(job_and_difficulty_stars, player_stars + 1)
	local total_difficulty_stars = math.max(0, total_stars - job_stars)
	local money_multiplier = self:get_contract_difficulty_multiplier(total_difficulty_stars)
	total_stars = math.min(job_stars, total_stars)
	local contract_money = 0
	if is_job then
		contract_money = contract_money + self:get_job_payout_by_stars(total_stars)
	else
		contract_money = contract_money + self:get_stage_payout_by_stars(total_stars)
	end
	contract_money = contract_money + contract_money * money_multiplier
	return math.round(contract_money)
end

function MoneyManager:get_job_bag_value()
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	return tweak_data:get_value("money_manager", "bag_value_multiplier", job_and_difficulty_stars)
end

function MoneyManager:get_bag_value(carry_id)
	local carry_data = tweak_data.carry[carry_id]
	local bag_value_id = carry_data.bag_value or "default"
	local value = tweak_data:get_value("money_manager", "bag_values", bag_value_id)
	return math.round(value)
end

function MoneyManager:debug_job_completed(stars)
	local amount = tweak_data:get_value("money_manager", "job_completion", stars)
	self:_add_to_total(amount)
end

function MoneyManager:get_job_payout_by_stars(stars, cap_stars)
	if cap_stars then
		stars = math.clamp(stars, 1, #tweak_data.money_manager.stage_completion)
	end
	local amount = tweak_data:get_value("money_manager", "job_completion", stars)
	return amount
end

function MoneyManager:get_stage_payout_by_stars(stars, cap_stars)
	if cap_stars then
		stars = math.clamp(stars, 1, #tweak_data.money_manager.stage_completion)
	end
	local amount = tweak_data:get_value("money_manager", "stage_completion", stars)
	return amount
end

function MoneyManager:get_small_loot_difficulty_multiplier(stars)
	local multiplier = tweak_data:get_value("money_manager", "small_loot_difficulty_multiplier", stars)
	return multiplier or 0
end

function MoneyManager:get_contract_difficulty_multiplier(stars)
	local multiplier = tweak_data:get_value("money_manager", "difficulty_multiplier", stars)
	return multiplier or 0
end

function MoneyManager:get_potential_payout_from_current_stage()
	local stage_value, job_value, bag_value, small_value, crew_value, total_payout = self:get_real_job_money_values(1)
	return total_payout
end

function MoneyManager:can_afford_weapon(weapon_id)
	return self:total() >= self:get_weapon_price_modified(weapon_id)
end

function MoneyManager:get_weapon_price(weapon_id)
	local pc = self:_get_weapon_pc(weapon_id)
	if not tweak_data.money_manager.weapon_cost[pc] then
		pc = 1
	end
	return tweak_data:get_value("money_manager", "weapon_cost", pc)
end

function MoneyManager:get_weapon_price_modified(weapon_id)
	local pc = self:_get_weapon_pc(weapon_id)
	if not tweak_data.money_manager.weapon_cost[pc] then
		pc = 1
	end
	return math.round(tweak_data:get_value("money_manager", "weapon_cost", pc) * managers.player:upgrade_value("player", "buy_cost_multiplier", 1) * managers.player:upgrade_value("player", "crime_net_deal", 1))
end

function MoneyManager:get_weapon_slot_sell_value(category, slot)
	local crafted_item = managers.blackmarket:get_crafted_category_slot(category, slot)
	if not crafted_item then
		return 0
	end
	local weapon_id = crafted_item.weapon_id
	local blueprint = crafted_item.blueprint
	local base_value = self:get_weapon_price(weapon_id)
	local parts_value = 0
	return math.round((base_value + parts_value) * tweak_data:get_value("money_manager", "sell_weapon_multiplier") * managers.player:upgrade_value("player", "sell_cost_multiplier", 1))
end

function MoneyManager:get_weapon_sell_value(weapon_id)
	return math.round(self:get_weapon_price(weapon_id) * tweak_data:get_value("money_manager", "sell_weapon_multiplier") * managers.player:upgrade_value("player", "sell_cost_multiplier", 1))
end

function MoneyManager:_get_weapon_pc(weapon_id)
	local weapon_level
	for level, level_data in pairs(tweak_data.upgrades.level_tree) do
		for _, upgrade in ipairs(level_data.upgrades) do
			if upgrade == weapon_id then
				weapon_level = level
				break
			end
		end
	end
	if not weapon_level then
		Application:error("DIDN'T FIND LEVEL FOR", weapon_id)
		weapon_level = 1
	end
	local pc = math.ceil(weapon_level)
	return pc
end

function MoneyManager:on_buy_weapon_platform(weapon_id, discount)
	local amount = self:get_weapon_price_modified(weapon_id)
	self:_deduct_from_total(math.round(amount * (discount and tweak_data:get_value("money_manager", "sell_weapon_multiplier") or 1)))
end

function MoneyManager:on_sell_weapon(category, slot)
	local amount = self:get_weapon_slot_sell_value(category, slot)
	self:_add_to_total(amount, {no_offshore = true})
end

function MoneyManager:get_weapon_part_sell_value(part_id, global_value)
	local part = tweak_data.weapon.factory.parts[part_id]
	local mod_price = 1000
	if part then
		local pc_value = self:_get_pc_entry(part)
		if pc_value then
			local star_value = math.ceil(pc_value / 10)
			mod_price = tweak_data:get_value("money_manager", "modify_weapon_cost", star_value)
		end
		local stats_value = part.stats
		stats_value = stats_value and stats_value.value or 1
		mod_price = mod_price * tweak_data.weapon.stats.value[math.clamp(stats_value, 1, #tweak_data.weapon.stats.value)]
	end
	return math.round(mod_price * tweak_data:get_value("money_manager", "sell_weapon_multiplier") * managers.player:upgrade_value("player", "sell_cost_multiplier", 1))
end

function MoneyManager:on_sell_weapon_part(part_id, global_value)
	local amount = self:get_weapon_part_sell_value(part_id, global_value)
	Application:debug("value of removed weapon part", amount)
	self:_add_to_total(amount, {no_offshore = true})
end

function MoneyManager:on_sell_weapon_slot(category, slot)
	local amount = self:get_weapon_slot_sell_value(category, slot)
	self._add_to_total(amount, {no_offshore = true})
end

function MoneyManager:can_afford_mission_asset(asset_id)
	return self:total() >= self:get_mission_asset_cost_by_id(asset_id)
end

function MoneyManager:on_buy_mission_asset(asset_id)
	local amount = self:get_mission_asset_cost_by_id(asset_id)
	self:_deduct_from_total(amount)
	return amount
end

function MoneyManager:can_afford_spend_skillpoint(tree, tier, points)
	return self:total() >= self:get_skillpoint_cost(tree, tier, points)
end

function MoneyManager:can_afford_respec_skilltree(tree)
	return true
end

function MoneyManager:on_skillpoint_spent(tree, tier, points)
	local amount = self:get_skillpoint_cost(tree, tier, points)
	self:_deduct_from_total(amount)
end

function MoneyManager:on_respec_skilltree(tree, forced_respec_multiplier)
	local amount = self:get_skilltree_tree_respec_cost(tree, forced_respec_multiplier)
	self:_add_to_total(amount, {no_offshore = true})
end

function MoneyManager:refund_weapon_part(weapon_id, part_id, global_value)
	local pc_value = tweak_data.blackmarket.weapon_mods[part_id].value or 1
	local mod_price = tweak_data:get_value("money_manager", "modify_weapon_cost", pc_value)
	local global_value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", global_value or "normal")
	self:_add_to_total(math.round(mod_price * global_value_multiplier), {no_offshore = true})
end

function MoneyManager:get_weapon_modify_price(weapon_id, part_id, global_value)
	local star_value
	local pc_value = tweak_data.blackmarket.weapon_mods[part_id].value or 1
	local mod_price = tweak_data:get_value("money_manager", "modify_weapon_cost", pc_value)
	local global_value_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", global_value or "normal")
	local crafting_multiplier = managers.player:upgrade_value("player", "passive_crafting_weapon_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "crafting_weapon_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "buy_cost_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "crime_net_deal", 1)
	local total_price = mod_price * crafting_multiplier * global_value_multiplier
	return math.round(total_price)
end

function MoneyManager:can_afford_weapon_modification(weapon_id, part_id, global_value)
	return self:total() >= self:get_weapon_modify_price(weapon_id, part_id, global_value)
end

function MoneyManager:on_buy_weapon_modification(weapon_id, part_id, global_value)
	local amount = self:get_weapon_modify_price(weapon_id, part_id, global_value)
	self:_deduct_from_total(amount)
end

function MoneyManager:_get_pc_entry(entry)
	if not entry then
		Application:error("MoneyManager:_get_pc_entry. No entry")
		return 5
	end
	local pcs = entry.pcs
	local pc_value
	if not pcs then
		local pc = entry.pc
		if not pc then
		else
			pc_value = pc
		end
	else
		pc_value = pcs[1]
		for _, pcv in ipairs(pcs) do
			pc_value = math.min(pc_value, pcv)
		end
	end
	return pc_value
end

function MoneyManager:get_mask_part_price_modified(category, id, global_value)
	local mask_part_price = self:get_mask_part_price(category, id, global_value)
	local crafting_multiplier = managers.player:upgrade_value("player", "passive_crafting_mask_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "crafting_mask_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "buy_cost_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "crime_net_deal", 1)
	local total_price = mask_part_price * crafting_multiplier
	return math.round(total_price)
end

function MoneyManager:get_mask_crafting_price_modified(mask_id, global_value, blueprint)
	local mask_price = self:get_mask_crafting_price(mask_id, global_value, blueprint)
	local crafting_multiplier = managers.player:upgrade_value("player", "passive_crafting_mask_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "crafting_mask_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "buy_cost_multiplier", 1)
	crafting_multiplier = crafting_multiplier * managers.player:upgrade_value("player", "crime_net_deal", 1)
	local total_price = mask_price * crafting_multiplier
	return math.round(total_price)
end

function MoneyManager:get_mask_part_price(category, id, global_value)
	local part_pc = self:_get_pc_entry(tweak_data.blackmarket[category][id]) or 0
	local star_value = part_pc == 0 and part_pc or math.ceil(part_pc / 10)
	local part_name_converter = {
		textures = "pattern",
		materials = "material",
		colors = "color"
	}
	local gv_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", global_value)
	local value = tweak_data.blackmarket[category][id].value or 1
	local pv = tweak_data:get_value("money_manager", "masks", part_name_converter[category] .. "_value", value) or 0
	return math.round(pv * gv_multiplier)
end

function MoneyManager:get_mask_crafting_price(mask_id, global_value, blueprint)
	local bonus_global_values = {
		normal = 0,
		superior = 0,
		exceptional = 0,
		infamous = 0
	}
	local pc_value = tweak_data.blackmarket.masks[mask_id].value or 1
	local star_value = pc_value and math.ceil(pc_value) or 1
	local base_value = tweak_data:get_value("money_manager", "masks", "mask_value", star_value) * tweak_data:get_value("money_manager", "global_value_multipliers", global_value)
	local parts_value = 0
	local part_name_converter = {
		pattern = "textures",
		material = "materials",
		color = "colors"
	}
	bonus_global_values[global_value] = (bonus_global_values[global_value] or 0) + 1
	blueprint = blueprint or managers.blackmarket:get_default_mask_blueprint()
	for id, data in pairs(blueprint) do
		local part_pc = self:_get_pc_entry(tweak_data.blackmarket[part_name_converter[id]][data.id]) or 0
		star_value = tweak_data.blackmarket[part_name_converter[id]][data.id].value or 1
		local gv_multiplier = tweak_data:get_value("money_manager", "global_value_multipliers", data.global_value)
		bonus_global_values[data.global_value] = (bonus_global_values[data.global_value] or 0) + 1
		local pv = tweak_data:get_value("money_manager", "masks", id .. "_value", star_value) or 0
		parts_value = parts_value + pv * gv_multiplier
	end
	return math.round(base_value + parts_value), bonus_global_values
end

function MoneyManager:get_mask_sell_value(mask_id, global_value, blueprint)
	local sell_value, bonuses = self:get_mask_crafting_price(mask_id, global_value, blueprint)
	local bonus_multiplier
	for gv, amount in pairs(bonuses) do
		bonus_multiplier = tweak_data:get_value("money_manager", "global_value_bonus_multiplier", gv) * math.max(amount - 1, 0)
		sell_value = sell_value + sell_value * bonus_multiplier
	end
	return math.round(sell_value * tweak_data:get_value("money_manager", "sell_mask_multiplier") * managers.player:upgrade_value("player", "sell_cost_multiplier", 1))
end

function MoneyManager:get_mask_slot_sell_value(slot)
	local mask = managers.blackmarket:get_crafted_category_slot("masks", slot)
	if not mask then
		return 0
	end
	return math.round(self:get_mask_sell_value(mask.mask_id, mask.global_value, mask.blueprint))
end

function MoneyManager:can_afford_mask_crafting(mask_id, global_value, blueprint)
	return self:total() >= self:get_mask_crafting_price_modified(mask_id, global_value, blueprint)
end

function MoneyManager:on_buy_mask(mask_id, global_value, blueprint)
	local amount = self:get_mask_crafting_price_modified(mask_id, global_value, blueprint)
	self:_deduct_from_total(amount)
end

function MoneyManager:on_sell_mask(mask_id, global_value, blueprint)
	local amount = self:get_mask_sell_value(mask_id, global_value, blueprint)
	self:_add_to_total(amount, {no_offshore = true})
end

function MoneyManager:on_loot_drop_cash(value_id)
	local amount = tweak_data:get_value("money_manager", "loot_drop_cash", value_id) or 100
	self:_add_to_total(amount, {no_offshore = true})
end

function MoneyManager:get_skillpoint_cost(tree, tier, points)
	local respec_tweak_data = tweak_data.money_manager.skilltree.respec
	local exp_cost = 0
	local tier_cost = not tier and 0 or tweak_data:get_value("money_manager", "skilltree", "respec", "point_tier_cost", tier) * points
	local cost = tweak_data:get_value("money_manager", "skilltree", "respec", "base_point_cost") + tier_cost
	return math.round(cost)
end

function MoneyManager:get_skilltree_tree_respec_cost(tree, forced_respec_multiplier)
	local base_point_cost = tweak_data:get_value("money_manager", "skilltree", "respec", "base_point_cost")
	local value = base_point_cost
	for id, tier in ipairs(tweak_data.skilltree.trees[tree].tiers) do
		for _, skill_id in ipairs(tier) do
			local step = managers.skilltree:skill_step(skill_id)
			if 0 < step then
				local skill_tweak_data = tweak_data.skilltree.skills[skill_id]
				for i = 1, step do
					value = value + base_point_cost + Application:digest_value(skill_tweak_data[i].cost, false) * tweak_data:get_value("money_manager", "skilltree", "respec", "point_tier_cost", id)
				end
			end
		end
	end
	return math.round(value * (forced_respec_multiplier or tweak_data:get_value("money_manager", "skilltree", "respec", "respec_refund_multiplier")))
end

function MoneyManager:get_mission_asset_cost()
	local stars = managers.job:has_active_job() and managers.job:current_job_and_difficulty_stars() or 1
	return math.round(tweak_data:get_value("money_manager", "mission_asset_cost", stars) * managers.player:upgrade_value("player", "assets_cost_multiplier", 1) * managers.player:upgrade_value("player", "passive_assets_cost_multiplier", 1) * managers.player:upgrade_value("player", "buy_cost_multiplier", 1) * managers.player:upgrade_value("player", "crime_net_deal", 1))
end

function MoneyManager:get_mission_asset_cost_by_stars(stars)
	return math.round(tweak_data:get_value("money_manager", "mission_asset_cost", stars) * managers.player:upgrade_value("player", "assets_cost_multiplier", 1) * managers.player:upgrade_value("player", "passive_assets_cost_multiplier", 1) * managers.player:upgrade_value("player", "buy_cost_multiplier", 1) * managers.player:upgrade_value("player", "crime_net_deal", 1))
end

function MoneyManager:get_mission_asset_cost_by_id(id)
	local asset_tweak_data = managers.assets:get_asset_tweak_data_by_id(id)
	local value = asset_tweak_data and asset_tweak_data.money_lock or 0
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local pc_multiplier = tweak_data:get_value("money_manager", "mission_asset_cost_multiplier_by_pc", job_stars) or 0
	local risk_multiplier = 0 < difficulty_stars and tweak_data:get_value("money_manager", "mission_asset_cost_multiplier_by_risk", difficulty_stars) or 0
	value = value + value * pc_multiplier + value * risk_multiplier
	return math.round(value * managers.player:upgrade_value("player", "assets_cost_multiplier", 1) * managers.player:upgrade_value("player", "passive_assets_cost_multiplier", 1) * managers.player:upgrade_value("player", "buy_cost_multiplier", 1) * managers.player:upgrade_value("player", "crime_net_deal", 1))
end

function MoneyManager:total()
	return Application:digest_value(self._global.total, false)
end

function MoneyManager:_set_total(value)
	self._global.total = Application:digest_value(value, true)
end

function MoneyManager:total_collected()
	return Application:digest_value(self._global.total_collected, false)
end

function MoneyManager:_set_total_collected(value)
	self._global.total_collected = Application:digest_value(value, true)
end

function MoneyManager:offshore()
	return Application:digest_value(self._global.offshore, false)
end

function MoneyManager:_set_offshore(value)
	self._global.offshore = Application:digest_value(value, true)
end

function MoneyManager:total_spent()
	return Application:digest_value(self._global.total_spent, false)
end

function MoneyManager:_set_total_spent(value)
	self._global.total_spent = Application:digest_value(value, true)
end

function MoneyManager:add_to_total(amount)
	amount = math.round(amount)
	print("MoneyManager:add_to_total", amount)
	self:_add_to_total(amount)
end

function MoneyManager:_add_to_total(amount, params)
	local no_offshore = params and params.no_offshore
	local offshore = math.round(no_offshore and 0 or amount * (1 - tweak_data:get_value("money_manager", "offshore_rate")))
	local spending_cash = math.round(no_offshore and amount or amount * tweak_data:get_value("money_manager", "offshore_rate"))
	local rounding_error = math.round(amount - (offshore + spending_cash))
	spending_cash = spending_cash + rounding_error
	self:_set_total(self:total() + spending_cash)
	self:_set_total_collected(self:total_collected() + math.round(amount))
	self:_set_offshore(self:offshore() + offshore)
	self:_on_total_changed(amount, spending_cash, offshore)
end

function MoneyManager:deduct_from_total(amount)
	amount = math.round(amount)
	print("MoneyManager:deduct_from_total", amount)
	self:_deduct_from_total(amount)
end

function MoneyManager:_deduct_from_total(amount)
	amount = math.min(amount, self:total())
	self:_set_total(math.max(0, self:total() - amount))
	self:_set_total_spent(self:total_spent() + amount)
	self:_on_total_changed(-amount, -amount, 0)
end

function MoneyManager:_on_total_changed(amount, spending_cash, offshore)
	self._heist_total = self._heist_total + amount
	self._heist_offshore = self._heist_offshore + offshore
	if offshore and 0 < offshore then
		self._heist_spending = self._heist_spending + spending_cash
	end
	if self:total() >= tweak_data.achievement.going_places then
		managers.achievment:award("going_places")
	end
	if self:total_spent() >= tweak_data.achievement.spend_money_to_make_money then
		managers.achievment:award("spend_money_to_make_money")
	end
end

function MoneyManager:heist_total()
	return self._heist_total or 0
end

function MoneyManager:heist_spending()
	return self._heist_spending or 0
end

function MoneyManager:heist_offshore()
	return self._heist_offshore or 0
end

function MoneyManager:get_payouts()
	return self._stage_payout, self._job_payout, self._bag_payout, self._small_loot_payout, self._crew_payout
end

function MoneyManager:_set_stage_payout(amount)
	self._stage_payout = amount
end

function MoneyManager:_set_job_payout(amount)
	self._job_payout = amount
end

function MoneyManager:_set_bag_payout(amount)
	self._bag_payout = amount
end

function MoneyManager:_set_small_loot_payout(amount)
	self._small_loot_payout = amount
end

function MoneyManager:_set_crew_payout(amount)
	self._crew_payout = amount
end

function MoneyManager:_add(amount)
	amount = self:_check_multipliers(amount)
	self._heist_total = self._heist_total + amount
	self:_present(amount)
end

function MoneyManager:_check_multipliers(amount)
	for _, multiplier in pairs(self._active_multipliers) do
		amount = amount * multiplier
	end
	return math.round(amount)
end

function MoneyManager:_present(amount)
	local s_amount = tostring(amount)
	local reverse = string.reverse(s_amount)
	local present = ""
	for i = 1, string.len(reverse) do
		present = present .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and "," or "")
	end
	local event = "money_collect_small"
	if 999 < amount then
		event = "money_collect_large"
	elseif 101 < amount then
		event = "money_collect_medium"
	end
end

function MoneyManager:actions()
	local t = {}
	for action, _ in pairs(tweak_data.money_manager.actions) do
		table.insert(t, action)
	end
	table.sort(t)
	return t
end

function MoneyManager:multipliers()
	local t = {}
	for multiplier, _ in pairs(tweak_data.money_manager.multipliers) do
		table.insert(t, multiplier)
	end
	table.sort(t)
	return t
end

function MoneyManager:reset()
	Global.money_manager = nil
	self:_setup()
end

function MoneyManager:save(data)
	local state = {
		total = self._global.total,
		total_collected = self._global.total_collected,
		offshore = self._global.offshore,
		total_spent = self._global.total_spent
	}
	data.MoneyManager = state
end

function MoneyManager:load(data)
	local state = data.MoneyManager
	self._global.total = state.total
	self._global.total_collected = state.total_collected or Application:digest_value(0, true)
	self._global.offshore = state.offshore or Application:digest_value(0, true)
	self._global.total_spent = state.total_spent or Application:digest_value(0, true)
end
