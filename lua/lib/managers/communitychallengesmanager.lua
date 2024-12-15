CommunityChallengesManager = CommunityChallengesManager or class()
CommunityChallengesManager.FULL_CREW_COUNT = 4
CommunityChallengesManager.PER_CHALLENGE_BONUS = 0.01

function CommunityChallengesManager:init()
	self._full_crew_start = nil
	self._full_crew_time = 0
	self._message_system = MessageSystem:new()
	self._next_stat_request_limit = 0
	self:_migrate_old_statistic("sb17_challenge_1", "sb17_challenge_5", 0.016666668, 21600)
	self:_migrate_old_statistic("sb17_challenge_3", "sb17_challenge_6", 0.016666668, 21600)
	self._global = Global.community_challenges_manager or {active_bonus = 0}
	Global.community_challenges_manager = self._global
	self:fetch_community_challenge_data()
end

function CommunityChallengesManager:update(t, dt)
	self._message_system:update()
end

function CommunityChallengesManager:_migrate_old_statistic(old_stat, new_stat, ratio, limit)
	repeat
		local old_stat_value = Steam:sa_handler():get_stat(old_stat)
		local new_stat_value = Steam:sa_handler():get_stat(new_stat)
		local chunk = math.min(old_stat_value, limit)
		if 0 < old_stat_value and Steam:sa_handler():set_stat(old_stat, old_stat_value - chunk) and Steam:sa_handler():set_stat(new_stat, new_stat_value + math.floor(chunk * ratio)) then
			Steam:sa_handler():store_data()
		end
	until old_stat_value <= 0
end

function CommunityChallengesManager:fetch_community_challenge_data()
	if SystemInfo:distribution() == Idstring("STEAM") then
		local now = Application:time()
		if now <= self._next_stat_request_limit then
			return
		end
		self._next_stat_request_limit = now + 10
		Steam:sa_handler():refresh_global_stats_cb(callback(self, self, "_on_global_stats_refresh_complete"))
		Steam:sa_handler():refresh_global_stats()
	end
end

function CommunityChallengesManager:_on_global_stats_refresh_complete(success)
	if not success then
		return
	end
	self._global.challenge_data = {}
	self._global.active_bonus = 0
	local get_60_day_stat = function(stat_name)
		local stat_value = 0
		for _, value in ipairs(Steam:sa_handler():get_global_stat(stat_name, 60)) do
			stat_value = stat_value + value
		end
		return 0 < stat_value and stat_value or 0
	end
	local better_ceil = function(number)
		local mod = number % 1
		if 0 < mod then
			return number - mod + 1
		else
			return number
		end
	end
	local ratio = tweak_data.community_challenges_stage_multiplier
	for _, challenge in ipairs(tweak_data.community_challenges) do
		local base = challenge.base_target
		local stat_value = get_60_day_stat(challenge.statistic_id)
		if challenge.statistic_id == "sb17_challenge_5" then
			stat_value = stat_value + math.floor(get_60_day_stat("sb17_challenge_1") / 60)
		elseif challenge.statistic_id == "sb17_challenge_6" then
			stat_value = stat_value + math.floor(get_60_day_stat("sb17_challenge_3") / 60)
		end
		local total_value = math.floor(tonumber(stat_value * (challenge.display_multiplier or 1)))
		local stage = math.floor(math.log(1 - total_value * ((1 - ratio) / base)) / math.log(ratio))
		local stage_base_value = math.floor(base * ((1 - math.pow(ratio, stage)) / (1 - ratio)))
		self._global.challenge_data[challenge.statistic_id] = {
			stage = stage + 1,
			current_value = total_value - stage_base_value,
			target_value = better_ceil(base * math.pow(ratio, stage)),
			additional_zeroes = challenge.additional_zeroes
		}
		self._global.active_bonus = self._global.active_bonus + stage * CommunityChallengesManager.PER_CHALLENGE_BONUS
	end
	self._message_system:notify(Message.OnCommunityChallengeDataReceived, nil, self._global.challenge_data)
end

function CommunityChallengesManager:get_challenge_data()
	return self._global.challenge_data
end

function CommunityChallengesManager:get_active_experience_bonus()
	return self._global.active_bonus
end

function CommunityChallengesManager:increment_custom_statistic(stat_name, value)
	local val = managers.network.account:get_stat(stat_name)
	managers.statistics:publish_custom_stat_to_steam(stat_name, val + value)
end

function CommunityChallengesManager:on_mission_start()
	managers.criminals:add_listener("community_challenges:criminal_added", {
		"on_criminal_added"
	}, callback(self, self, "_on_criminal_added"))
	managers.criminals:add_listener("community_challenges:criminal_removed", {
		"on_criminal_removed"
	}, callback(self, self, "_on_criminal_removed"))
	if self:full_crew() then
		self:mark_full_crew_start()
	end
end

function CommunityChallengesManager:on_mission_end(success)
	local time_played = managers.game_play_central:get_heist_timer()
	self:increment_custom_statistic("sb17_challenge_5", math.round(time_played / 60))
	if success then
		local money_earned = managers.money:heist_spending() + managers.money:heist_offshore()
		self:increment_custom_statistic("sb17_challenge_7", math.round(money_earned / 1000000))
	end
	self:mark_full_crew_end()
	if self._full_crew_time > 0 then
		self:increment_custom_statistic("sb17_challenge_6", math.round(self._full_crew_time / 60))
	end
end

function CommunityChallengesManager:on_achievement_awarded(id)
	if id == "kosugi_5" then
		self:increment_custom_statistic("sb17_challenge_4", 1)
	end
end

function CommunityChallengesManager:_on_criminal_added()
	if self:full_crew() then
		self:mark_full_crew_start()
	end
end

function CommunityChallengesManager:_on_criminal_removed()
	if not self:full_crew() then
		self:mark_full_crew_end()
	end
end

function CommunityChallengesManager:full_crew()
	return managers.criminals:get_num_player_criminals() == CommunityChallengesManager.FULL_CREW_COUNT
end

function CommunityChallengesManager:mark_full_crew_start()
	self._full_crew_start = managers.game_play_central:get_heist_timer()
end

function CommunityChallengesManager:mark_full_crew_end()
	if self._full_crew_start then
		local time = managers.game_play_central:get_heist_timer() - self._full_crew_start
		self._full_crew_time = self._full_crew_time + time
		self._full_crew_start = nil
	end
end

function CommunityChallengesManager:add_event_listener(message, uid, func)
	self._message_system:register(message, uid, func)
end

function CommunityChallengesManager:remove_event_listener(message, uid)
	self._message_system:unregister(message, uid)
end
