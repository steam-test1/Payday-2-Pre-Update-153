PlayerAction.TriggerHappy = {}
PlayerAction.TriggerHappy.Priority = 1

function PlayerAction.TriggerHappy.Function(player_manager, damage_bonus, max_stacks, max_time)
	local co = coroutine.running()
	local current_time = Application:time()
	local current_stacks = 1
	do
		local function on_hit(attacker_unit, unit, variant)
			if attacker_unit == player_manager:player_unit() and variant == "bullet" then
				current_stacks = current_stacks + 1
				
				if current_stacks <= max_stacks then
					player_manager:mul_to_property("trigger_happy", damage_bonus)
				end
			end
		end
		
		player_manager:mul_to_property("trigger_happy", damage_bonus)
		player_manager:register_message(Message.OnEnemyShot, co, on_hit)
	end
	while max_time > current_time do
		current_time = Application:time()
		if not player_manager:is_current_weapon_of_category("pistol") then
			break
		end
		coroutine.yield(co)
	end
	player_manager:remove_property("trigger_happy")
	player_manager:unregister_message(Message.OnEnemyShot, co)
end
