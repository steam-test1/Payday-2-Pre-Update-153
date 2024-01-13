PlayerAction.EscapeTase = {}
PlayerAction.EscapeTase.Priority = 1

function PlayerAction.EscapeTase.Function(player_manager, target_time)
	local time = Application:time()
	local controller = player_manager:player_unit():base():controller()
	local co = coroutine.running()
	while target_time > time and player_manager:current_state() == "tased" do
		time = Application:time()
		if controller:get_input_pressed("interact") then
			player_manager:send_message(Message.EscapeTase, nil, nil)
			break
		end
		coroutine.yield(co)
	end
end
