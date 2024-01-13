PlayerAction.FullyLoaded = {}
PlayerAction.FullyLoaded.Priority = 1

function PlayerAction.FullyLoaded.Function(t, dt)
	print("START")
	local co = coroutine.running()
	local head_shots = 1
	
	local function on_head_shot(data)
		head_shots = head_shots + 1
		print("head shots ", head_shots)
	end
	
	local max_time = 10
	local current_time = 0
	managers.player:register_message(Message.OnHeadShot, co, on_head_shot)
	while max_time > current_time do
		current_time = current_time + dt
		coroutine.yield(co)
	end
	print("QUIT")
	managers.player:unregister_message(Message.OnHeadShot, co)
end
