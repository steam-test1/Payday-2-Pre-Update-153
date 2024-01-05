ExperienceManager = ExperienceManager or class()
ExperienceManager.LEVEL_CAP = Application:digest_value(100, true)

function ExperienceManager:init()
	self:_setup()
end

function ExperienceManager:_setup()
	self._total_levels = #tweak_data.experience_manager.levels
	if not Global.experience_manager then
		Global.experience_manager = {}
		Global.experience_manager.total = Application:digest_value(0, true)
		Global.experience_manager.level = Application:digest_value(0, true)
	end
	self._global = Global.experience_manager
	if not self._global.next_level_data then
		self:_set_next_level_data(1)
	end
	self._cash_tousand_separator = managers.localization:text("cash_tousand_separator")
	self._cash_sign = managers.localization:text("cash_sign")
	self:present()
end

function ExperienceManager:_set_next_level_data(level)
	if level > self._total_levels then
		Application:error("Reached the level cap")
		if self._experience_progress_data then
			table.insert(self._experience_progress_data, {
				level = self._total_levels,
				current = tweak_data:get_value("experience_manager", "levels", self._total_levels, "points"),
				total = tweak_data:get_value("experience_manager", "levels", self._total_levels, "points")
			})
		end
		return
	end
	local level_data = tweak_data.experience_manager.levels[level]
	self._global.next_level_data = {}
	self:_set_next_level_data_points(level_data.points)
	self:_set_next_level_data_current_points(0)
	if self._experience_progress_data then
		table.insert(self._experience_progress_data, {
			level = level,
			current = 0,
			total = tweak_data:get_value("experience_manager", "levels", level, "points")
		})
	end
end

function ExperienceManager:next_level_data_points()
	return self._global.next_level_data and Application:digest_value(self._global.next_level_data.points, false) or 0
end

function ExperienceManager:_set_next_level_data_points(value)
	self._global.next_level_data.points = value
end

function ExperienceManager:next_level_data_current_points()
	return self._global.next_level_data and Application:digest_value(self._global.next_level_data.current_points, false) or 0
end

function ExperienceManager:_set_next_level_data_current_points(value)
	self._global.next_level_data.current_points = Application:digest_value(value, true)
end

function ExperienceManager:next_level_data()
	return {
		points = self:next_level_data_points(),
		current_points = self:next_level_data_current_points()
	}
end

function ExperienceManager:perform_action_interact(name)
end

function ExperienceManager:perform_action(action)
	if managers.platform:presence() ~= "Playing" and managers.platform:presence() ~= "Mission_end" then
		return
	end
	if not tweak_data.experience_manager.actions[action] then
		Application:error("Unknown action \"" .. tostring(action) .. " in experience manager.")
		return
	end
	local size = tweak_data.experience_manager.actions[action]
	local points = tweak_data.experience_manager.values[size]
	if not points then
		Application:error("Unknown size \"" .. tostring(size) .. " in experience manager.")
		return
	end
	managers.statistics:recieved_experience({action = action, size = size})
	self:add_points(points, true)
end

function ExperienceManager:debug_add_points(points, present_xp)
	self:add_points(points, present_xp, true)
end

function ExperienceManager:give_experience(xp)
	self._experience_progress_data = {}
	self._experience_progress_data.gained = xp
	self._experience_progress_data.start_t = {}
	self._experience_progress_data.start_t.level = self:current_level()
	self._experience_progress_data.start_t.current = self._global.next_level_data and self:next_level_data_current_points() or 0
	self._experience_progress_data.start_t.total = self._global.next_level_data and self:next_level_data_points() or 1
	self._experience_progress_data.start_t.xp = self:xp_gained()
	table.insert(self._experience_progress_data, {
		level = self:current_level() + 1,
		current = self:next_level_data_current_points(),
		total = self:next_level_data_points()
	})
	local level_cap_xp_leftover = self:add_points(xp, true, false)
	if level_cap_xp_leftover then
		self._experience_progress_data.gained = self._experience_progress_data.gained - level_cap_xp_leftover
	end
	self._experience_progress_data.end_t = {}
	self._experience_progress_data.end_t.level = self:current_level()
	self._experience_progress_data.end_t.current = self._global.next_level_data and self:next_level_data_current_points() or 0
	self._experience_progress_data.end_t.total = self._global.next_level_data and self:next_level_data_points() or 1
	self._experience_progress_data.end_t.xp = self:xp_gained()
	table.remove(self._experience_progress_data, #self._experience_progress_data)
	local return_data = deep_clone(self._experience_progress_data)
	self._experience_progress_data = nil
	return return_data
end

function ExperienceManager:on_loot_drop_xp(value_id)
	local amount = tweak_data:get_value("experience_manager", "loot_drop_value", value_id) or 0
	self:add_points(amount, false)
end

function ExperienceManager:add_points(points, present_xp, debug)
	if not debug and managers.platform:presence() ~= "Playing" and managers.platform:presence() ~= "Mission_end" then
		return
	end
	if not managers.dlc:has_full_game() and self:current_level() >= 10 then
		self:_set_total(self:total() + points)
		self:_set_next_level_data_current_points(0)
		self:present()
		managers.challenges:aquired_money()
		managers.statistics:aquired_money(points)
		return points
	end
	if self:current_level() >= self:level_cap() then
		self:_set_total(self:total() + points)
		managers.challenges:aquired_money()
		managers.statistics:aquired_money(points)
		return points
	end
	if present_xp then
		self:_present_xp(points)
	end
	local points_left = self:next_level_data_points() - self:next_level_data_current_points()
	if points < points_left then
		self:_set_total(self:total() + points)
		self:_set_xp_gained(self:total())
		self:_set_next_level_data_current_points(self:next_level_data_current_points() + points)
		self:present()
		managers.challenges:aquired_money()
		managers.statistics:aquired_money(points)
		return
	end
	self:_set_total(self:total() + points_left)
	self:_set_xp_gained(self:total())
	self:_set_next_level_data_current_points(self:next_level_data_current_points() + points_left)
	self:present()
	self:_level_up()
	managers.statistics:aquired_money(points_left)
	return self:add_points(points - points_left, present_xp, debug)
end

function ExperienceManager:_level_up()
	self:_set_current_level(self:current_level() + 1)
	self:_set_next_level_data(self:current_level() + 1)
	local player = managers.player:player_unit()
	if alive(player) and tweak_data:difficulty_to_index(Global.game_settings.difficulty) < 4 then
		player:base():replenish()
	end
	managers.challenges:check_active_challenges()
	self:_check_achievements()
	if managers.network:session() then
		managers.network:session():send_to_peers_synched("sync_level_up", managers.network:session():local_peer():id(), self:current_level())
	end
	if self:current_level() >= 145 then
		managers.challenges:set_flag("president")
	end
	managers.upgrades:level_up()
	managers.skilltree:level_up()
end

function ExperienceManager:_check_achievements()
	if self:current_level() >= tweak_data.achievement.you_gotta_start_somewhere then
		managers.achievment:award("you_gotta_start_somewhere")
	end
	if self:current_level() >= tweak_data.achievement.guilty_of_crime then
		managers.achievment:award("guilty_of_crime")
	end
	if self:current_level() >= tweak_data.achievement.gone_in_30_seconds then
		managers.achievment:award("gone_in_30_seconds")
	end
	if self:current_level() >= tweak_data.achievement.armed_and_dangerous then
		managers.achievment:award("armed_and_dangerous")
	end
	if self:current_level() >= tweak_data.achievement.big_shot then
		managers.achievment:award("big_shot")
	end
	if self:current_level() >= tweak_data.achievement.most_wanted then
		managers.achievment:award("most_wanted")
	end
end

function ExperienceManager:present()
end

function ExperienceManager:_present_xp(amount)
	local event = "money_collect_small"
	if 999 < amount then
		event = "money_collect_large"
	elseif 101 < amount then
		event = "money_collect_medium"
	end
end

function ExperienceManager:current_level()
	return self._global.level and Application:digest_value(self._global.level, false) or 0
end

function ExperienceManager:_set_current_level(value)
	self._global.level = Application:digest_value(value, true)
end

function ExperienceManager:level_to_stars()
	local plvl = managers.experience:current_level()
	local player_stars = math.clamp(math.ceil((plvl + 1) / 10), 1, 10)
	return player_stars
end

function ExperienceManager:xp_gained()
	return self._global.xp_gained and Application:digest_value(self._global.xp_gained, false) or 0
end

function ExperienceManager:_set_xp_gained(value)
	self._global.xp_gained = Application:digest_value(value, true)
end

function ExperienceManager:total()
	return Application:digest_value(self._global.total, false)
end

function ExperienceManager:_set_total(value)
	self._global.total = Application:digest_value(value, true)
end

function ExperienceManager:cash_string(cash)
	local sign = ""
	if cash < 0 then
		sign = "-"
	end
	local total = tostring(math.round(math.abs(cash)))
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return sign .. self._cash_sign .. string.reverse(s)
end

function ExperienceManager:experience_string(xp)
	local total = tostring(math.round(math.abs(xp)))
	local reverse = string.reverse(total)
	local s = ""
	for i = 1, string.len(reverse) do
		s = s .. string.sub(reverse, i, i) .. (math.mod(i, 3) == 0 and i ~= string.len(reverse) and self._cash_tousand_separator or "")
	end
	return string.reverse(s)
end

function ExperienceManager:total_cash_string()
	return self:cash_string(self:total()) .. (self:total() > 0 and self._cash_tousand_separator .. "000" or "")
end

function ExperienceManager:actions()
	local t = {}
	for action, _ in pairs(tweak_data.experience_manager.actions) do
		table.insert(t, action)
	end
	table.sort(t)
	return t
end

function ExperienceManager:get_job_xp_by_stars(stars)
	local amount = tweak_data:get_value("experience_manager", "job_completion", stars)
	return amount
end

function ExperienceManager:get_stage_xp_by_stars(stars)
	local amount = tweak_data:get_value("experience_manager", "stage_completion", stars)
	return amount
end

function ExperienceManager:get_contract_difficulty_multiplier(stars)
	local multiplier = tweak_data:get_value("experience_manager", "difficulty_multiplier", stars)
	return multiplier or 0
end

function ExperienceManager:get_current_stage_xp_by_stars(stars, diff_stars)
	local amount = self:get_stage_xp_by_stars(stars) + self:get_stage_xp_by_stars(stars) * self:get_contract_difficulty_multiplier(diff_stars)
	return amount
end

function ExperienceManager:get_current_job_xp_by_stars(stars, diff_stars)
	local amount = self:get_job_xp_by_stars(stars) + self:get_job_xp_by_stars(stars) * self:get_contract_difficulty_multiplier(diff_stars)
	return amount
end

function ExperienceManager:get_current_job_day_multiplier()
	if not managers.job:has_active_job() then
		return 1
	end
	local current_job_day = managers.job:current_stage()
	local is_current_job_professional = managers.job:is_current_job_professional()
	return is_current_job_professional and tweak_data:get_value("experience_manager", "pro_day_multiplier", current_job_day) or tweak_data:get_value("experience_manager", "day_multiplier", current_job_day)
end

function ExperienceManager:get_on_completion_xp()
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local on_last_stage = managers.job:on_last_stage()
	local amount = self:get_current_stage_xp_by_stars(job_stars, difficulty_stars)
	if on_last_stage then
		amount = amount + self:get_current_job_xp_by_stars(job_stars, difficulty_stars)
	end
	return amount
end

function ExperienceManager:get_contract_xp_by_stars(job_stars, risk_stars, professional, job_days, debug_player_level)
	local job_and_difficulty_stars = job_stars + risk_stars
	local job_stars = job_stars
	local difficulty_stars = risk_stars
	local player_stars = debug_player_level and math.max(math.ceil(debug_player_level / 10), 1) or managers.experience:level_to_stars()
	local params = {}
	params.job_stars = job_stars
	params.difficulty_stars = difficulty_stars
	params.current_stage = job_days
	params.professional = professional
	params.success = true
	params.num_winners = 1
	params.on_last_stage = true
	params.player_stars = player_stars
	local total_base_xp = 0
	local total_risk_xp = 0
	local total_xp = 0
	for i = 1, job_days do
		params.current_stage = i
		params.on_last_stage = i == job_days
		local total_xp, dissection_table = self:get_xp_by_params(params)
		total_base_xp = total_base_xp + dissection_table.base + dissection_table.bonus_days_job
		total_risk_xp = total_risk_xp + dissection_table.bonus_risk + dissection_table.bonus_days_risk
	end
	total_xp = total_base_xp + total_risk_xp
	return total_xp, total_base_xp, total_risk_xp
end

function ExperienceManager:get_xp_by_params(params)
	local job_stars = params.job_stars or 0
	local difficulty_stars = params.difficulty_stars or params.risk_stars or 0
	local job_and_difficulty_stars = job_stars + difficulty_stars
	local success = params.success
	local num_winners = params.num_winners or 1
	local on_last_stage = params.on_last_stage
	local player_stars = params.player_stars or managers.experience:level_to_stars() or 0
	local current_job_stage = params.current_stage or 1
	local days_multiplier = params.professional and tweak_data:get_value("experience_manager", "pro_day_multiplier", current_job_stage) or tweak_data:get_value("experience_manager", "day_multiplier", current_job_stage)
	local total_stars = math.min(job_stars, player_stars)
	local total_difficulty_stars = difficulty_stars
	local xp_multiplier = managers.experience:get_contract_difficulty_multiplier(total_difficulty_stars)
	local contract_xp = 0
	local total_xp = 0
	local stage_xp_dissect = 0
	local job_xp_dissect = 0
	local level_limit_dissect = 0
	local risk_dissect = 0
	local failed_level_dissect = 0
	local alive_crew_dissect = 0
	local skill_dissect = 0
	local base_xp = 0
	local days_dissect = 0
	if success and on_last_stage then
		job_xp_dissect = managers.experience:get_job_xp_by_stars(total_stars)
		level_limit_dissect = level_limit_dissect + managers.experience:get_job_xp_by_stars(job_stars)
	end
	stage_xp_dissect = managers.experience:get_stage_xp_by_stars(total_stars)
	level_limit_dissect = level_limit_dissect + managers.experience:get_stage_xp_by_stars(job_stars)
	contract_xp = job_xp_dissect + stage_xp_dissect
	local is_level_limited = job_stars > player_stars
	if is_level_limited and 0 < stage_xp_dissect then
		local diff_in_experience = level_limit_dissect - contract_xp
		local diff_in_stars = job_stars - player_stars
		local tweak_multiplier = tweak_data:get_value("experience_manager", "level_limit", "pc_difference_multipliers", diff_in_stars) or 0
		contract_xp = contract_xp + math.round(diff_in_experience * tweak_multiplier)
		local stage_xp_ratio = stage_xp_dissect / (job_xp_dissect + stage_xp_dissect)
		local job_xp_ratio = job_xp_dissect / (job_xp_dissect + stage_xp_dissect)
		stage_xp_dissect = math.round(contract_xp * stage_xp_ratio)
		job_xp_dissect = math.round(contract_xp * job_xp_ratio)
		local rounding_error = contract_xp - (stage_xp_dissect + job_xp_dissect)
		job_xp_dissect = job_xp_dissect + rounding_error
	end
	base_xp = contract_xp
	risk_dissect = math.round(contract_xp * xp_multiplier)
	contract_xp = contract_xp + risk_dissect
	level_limit_dissect = level_limit_dissect + math.round(level_limit_dissect * xp_multiplier)
	level_limit_dissect = contract_xp - level_limit_dissect
	if not success then
		failed_level_dissect = contract_xp
		contract_xp = math.round(contract_xp * (tweak_data:get_value("experience_manager", "stage_failed_multiplier") or 1))
		failed_level_dissect = contract_xp - failed_level_dissect
	end
	total_xp = contract_xp
	if success then
		local num_players_bonus = num_winners and tweak_data:get_value("experience_manager", "alive_humans_multiplier", num_winners) or 1
		alive_crew_dissect = math.round(contract_xp * num_players_bonus - contract_xp)
		total_xp = total_xp + alive_crew_dissect
	end
	local multiplier = managers.player:upgrade_value("player", "xp_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value("player", "passive_xp_multiplier", 1)
	multiplier = multiplier * managers.player:team_upgrade_value("xp", "multiplier", 1)
	skill_dissect = math.round(contract_xp * multiplier - contract_xp)
	total_xp = total_xp + skill_dissect
	days_dissect = math.round(contract_xp * days_multiplier - contract_xp)
	total_xp = total_xp + days_dissect
	local days_dissect_risk = math.round(days_dissect * (risk_dissect / (base_xp + risk_dissect)))
	local days_dissect_job = days_dissect - days_dissect_risk
	local limited_bonus = tweak_data:get_value("experience_manager", "limited_bonus_multiplier") or 1
	if 1 < limited_bonus then
		base_xp = base_xp * limited_bonus
		total_xp = total_xp * limited_bonus
		risk_dissect = risk_dissect * limited_bonus
		alive_crew_dissect = alive_crew_dissect * limited_bonus
		failed_level_dissect = failed_level_dissect * limited_bonus
		level_limit_dissect = level_limit_dissect * limited_bonus
		skill_dissect = skill_dissect * limited_bonus
		days_dissect = days_dissect * limited_bonus
		days_dissect_job = days_dissect_job * limited_bonus
		days_dissect_risk = days_dissect_risk * limited_bonus
		stage_xp_dissect = stage_xp_dissect * limited_bonus
		job_xp_dissect = job_xp_dissect * limited_bonus
	end
	local dissection_table = {
		bonus_risk = math.round(risk_dissect),
		bonus_num_players = math.round(alive_crew_dissect),
		bonus_failed = math.round(failed_level_dissect),
		bonus_low_level = math.round(level_limit_dissect),
		bonus_skill = math.round(skill_dissect),
		bonus_days = math.round(days_dissect),
		bonus_days_job = math.round(days_dissect_job),
		bonus_days_risk = math.round(days_dissect_risk),
		stage_xp = math.round(stage_xp_dissect),
		job_xp = math.round(job_xp_dissect),
		base = math.round(base_xp),
		total = math.round(total_xp),
		last_stage = on_last_stage
	}
	if Application:production_build() then
		local rounding_error = dissection_table.total - (dissection_table.stage_xp + dissection_table.job_xp + dissection_table.bonus_risk + dissection_table.bonus_num_players + dissection_table.bonus_failed + dissection_table.bonus_skill + dissection_table.bonus_days)
		dissection_table.rounding_error = rounding_error
	else
		dissection_table.rounding_error = 0
	end
	return math.round(total_xp), dissection_table
end

function ExperienceManager:get_xp_dissected(success, num_winners)
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local current_stage = has_active_job and managers.job:current_stage() or 1
	local is_professional = has_active_job and managers.job:is_current_job_professional() or false
	local on_last_stage = has_active_job and managers.job:on_last_stage()
	return self:get_xp_by_params({
		job_stars = job_stars,
		difficulty_stars = difficulty_stars,
		current_stage = current_stage,
		professional = is_professional,
		success = success,
		num_winners = num_winners,
		on_last_stage = on_last_stage
	})
end

function ExperienceManager:level_cap()
	return Application:digest_value(self.LEVEL_CAP, false)
end

function ExperienceManager:reached_level_cap()
	return self:current_level() >= self:level_cap()
end

function ExperienceManager:save(data)
	local state = {
		total = self._global.total,
		xp_gained = self._global.xp_gained,
		next_level_data = self._global.next_level_data,
		level = self._global.level
	}
	data.ExperienceManager = state
end

function ExperienceManager:load(data)
	local state = data.ExperienceManager
	if state then
		self._global.total = state.total
		self._global.xp_gained = state.xp_gained or state.total
		self._global.next_level_data = state.next_level_data
		self._global.level = state.level or Application:digest_value(0, true)
		self:_set_current_level(math.min(self:current_level(), self:level_cap()))
		for level = 1, self:current_level() do
			managers.upgrades:aquire_from_level_tree(level, true)
		end
		if not (self._global.next_level_data and tweak_data.experience_manager.levels[self:current_level() + 1]) or self:next_level_data_points() ~= tweak_data:get_value("experience_manager", "levels", self:current_level() + 1, "points") then
			self:_set_next_level_data(self:current_level() + 1)
		end
	end
	managers.network.account:experience_loaded()
end

function ExperienceManager:reset()
	managers.upgrades:reset()
	managers.player:reset()
	Global.experience_manager = nil
	self:_setup()
end

function ExperienceManager:chk_ask_use_backup(savegame_data, backup_savegame_data)
	local savegame_exp_total, backup_savegame_exp_total
	local state = savegame_data.ExperienceManager
	if state then
		savegame_exp_total = state.total
	end
	state = backup_savegame_data.ExperienceManager
	if state then
		backup_savegame_exp_total = state.total
	end
	if savegame_exp_total and backup_savegame_exp_total and Application:digest_value(savegame_exp_total, false) < Application:digest_value(backup_savegame_exp_total, false) then
		return true
	end
end
