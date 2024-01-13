PlayerAction.ExpertHandling = {}
PlayerAction.ExpertHandling.Priority = 1

function PlayerAction.ExpertHandling.Function(player_manager, accuracy_bonus, max_stacks, max_time)
	local co = coroutine.running()
	local current_time = Application:time()
	local current_stacks = 0
	do
		local function on_hit()
			current_stacks = current_stacks + 1
			
			if current_stacks <= max_stacks then
				player_manager:mul_to_property("desperado", accuracy_bonus)
			end
		end
		
		on_hit()
		player_manager:register_message(Message.OnEnemyShot, co, on_hit)
	end
	while max_time > current_time do
		current_time = Application:time()
		if not player_manager:is_current_weapon_of_category("pistol") then
			break
		end
		coroutine.yield(co)
	end
	player_manager:remove_property("desperado")
	player_manager:unregister_message(Message.OnEnemyShot, co)
end
