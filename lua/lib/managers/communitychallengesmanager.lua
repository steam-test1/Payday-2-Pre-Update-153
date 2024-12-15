CommunityChallengesManager = CommunityChallengesManager or class()
CommunityChallengesManager.FULL_CREW_COUNT = 4
CommunityChallengesManager.PER_CHALLENGE_BONUS = 0.05

function CommunityChallengesManager:init()
	self._full_crew_start = nil
	self._full_crew_time = 0
	self._active_bonus = 0
	self._message_system = MessageSystem:new()
	self:fetch_community_challenge_data()
end

function CommunityChallengesManager:update(t, dt)
	self._message_system:update()
end

function CommunityChallengesManager:fetch_community_challenge_data()
	if SystemInfo:distribution() == Idstring("STEAM") then
		local challenges_progress_url = "http://fbi.overkillsoftware.com/_jpn/jpnstats.json"
		local response_callback = callback(self, self, "_on_challenge_progress_response")
		Steam:http_request(challenges_progress_url, response_callback, Idstring("CommunityChallengesManager"):key())
	end
end

function CommunityChallengesManager:_on_challenge_progress_response(success, response)
	print("[Debug] CommunityChallengesManager:_on_challenge_progress_response, success:", success)
	if not success then
		return
	end
	self._challenge_data = {}
	self._active_bonus = 0
	local find_challenge_tweak = function(statistic_id)
		for _, challenge in ipairs(tweak_data.community_challenges) do
			if challenge.statistic_id == statistic_id then
				return challenge
			end
		end
	end
	local ratio = tweak_data.community_challenges_stage_multiplier
	for key, value in string.gmatch(response, "\"([%a%d_]+)\"%s*:%s*\"(%d+)\"") do
		local challenge_tweak = find_challenge_tweak(key)
		if challenge_tweak then
			local base = challenge_tweak.base_target
			local total_value = math.floor(tonumber(value * (challenge_tweak.display_multiplier or 1)))
			local stage = math.floor(math.log(1 - total_value * ((1 - ratio) / base)) / math.log(ratio))
			local stage_base_value = math.floor(base * ((1 - math.pow(ratio, stage)) / (1 - ratio)))
			self._challenge_data[key] = {
				stage = stage + 1,
				current_value = total_value - stage_base_value,
				target_value = math.ceil(base * math.pow(ratio, stage))
			}
			self._active_bonus = self._active_bonus + stage * CommunityChallengesManager.PER_CHALLENGE_BONUS
		end
	end
	self._message_system:notify(Message.OnCommunityChallengeDataReceived, nil, self._challenge_data)
end

function CommunityChallengesManager:get_challenge_data()
	return self._challenge_data
end

function CommunityChallengesManager:get_active_experience_bonus()
	return self._active_bonus
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
	self:increment_custom_statistic("sb17_challenge_1", math.round(time_played))
	if success then
		local money_earned = managers.money:heist_spending() + managers.money:heist_offshore()
		self:increment_custom_statistic("sb17_challenge_2", money_earned)
	end
	self:mark_full_crew_end()
	if self._full_crew_time > 0 then
		self:increment_custom_statistic("sb17_challenge_3", math.round(self._full_crew_time))
	end
end

function CommunityChallengesManager:on_achievement_awarded(id)
	if id == "gage4_3" then
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
