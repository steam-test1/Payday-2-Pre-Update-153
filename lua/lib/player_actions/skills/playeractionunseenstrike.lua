PlayerAction.UnseenStrike = {}
PlayerAction.UnseenStrike.Priority = 1

function PlayerAction.UnseenStrike.Function(player_manager, min_time, max_duration, crit_chance)
	local co = coroutine.running()
	local current_time = Application:time()
	local target_time = Application:time() + min_time
	do
		local function on_damage_taken()
			target_time = Application:time() + min_time
		end
		
		player_manager:register_message(Message.OnPlayerDamage, co, on_damage_taken)
	end
	while true do
		current_time = Application:time()
		if target_time <= current_time then
			player_manager:add_coroutine(PlayerAction.UnseenStrikeStart, PlayerAction.UnseenStrikeStart, player_manager, max_duration, crit_chance)
			break
		end
		coroutine.yield(co)
	end
	player_manager:unregister_message(Message.OnPlayerDamage, co)
end

PlayerAction.UnseenStrikeStart = {}
PlayerAction.UnseenStrikeStart.Priority = 1

function PlayerAction.UnseenStrikeStart.Function(player_manager, max_duration, crit_chance)
	local co = coroutine.running()
	local quit = false
	local current_time = Application:time()
	local target_time = Application:time() + max_duration
	do
		local function on_damage_taken()
			quit = true
		end
		
		player_manager:register_message(Message.OnPlayerDamage, co, on_damage_taken)
	end
	player_manager:add_to_crit_mul(crit_chance - 1)
	while current_time <= target_time and not quit do
		local time = Application:time()
		current_time = time
		if target_time <= current_time and not quit then
			target_time = time + max_duration
		end
		coroutine.yield(co)
	end
	player_manager:sub_from_crit_mul(crit_chance - 1)
	player_manager:unregister_message(Message.OnPlayerDamage, co)
end
