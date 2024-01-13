local on_ammo_pickup = function(unit, pickup_chance, increase)
	local gained_throwable = false
	local chance = pickup_chance
	if unit == managers.player:player_unit() then
		local random = math.random()
		if chance > random then
			gained_throwable = true
			managers.player:add_grenade_amount(1, true)
		else
			chance = chance * increase
		end
	end
	return gained_throwable, chance
end
PlayerAction.FullyLoaded = {}
PlayerAction.FullyLoaded.Priority = 1

function PlayerAction.FullyLoaded.Function(player_manager, pickup_chance, increase)
	local co = coroutine.running()
	local gained_throwable = false
	local chance = pickup_chance
	do
		local function on_ammo_pickup_message(unit)
			gained_throwable, chance = on_ammo_pickup(unit, chance, increase)
		end
		
		player_manager:register_message(Message.OnAmmoPickup, co, on_ammo_pickup_message)
	end
	player_manager:register_message(Message.OnAmmoPickup, co, on_ammo_pickup)
	while not gained_throwable do
		coroutine.yield(co)
	end
	player_manager:unregister_message(Message.OnAmmoPickup, co)
end
