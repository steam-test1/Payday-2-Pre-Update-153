TestAPI = TestAPI or class()

function TestAPI.get_jobs()
	local jobs = {}
	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local job_data = tweak_data.narrative:job_data(job_id)
		local stages = #job_data.chain
		table.insert(jobs, {job = job_id, stages = stages})
	end
	return {jobs = jobs}
end

function TestAPI.start_job(job_id, difficulty, stage)
	difficulty = difficulty or "normal"
	stage = stage or 1
	Global.game_settings.single_player = true
	managers.network:host_game()
	Network:set_server()
	managers.job:activate_job(job_id)
	if 1 < stage then
		managers.job:set_current_stage(stage)
	end
	Global.game_settings.level_id = managers.job:current_level_id()
	Global.game_settings.mission = managers.job:current_mission()
	Global.game_settings.world_setting = managers.job:current_world_setting()
	Global.game_settings.difficulty = difficulty
	local level_name = tweak_data.levels[Global.game_settings.level_id].world_name
	if Global.boot_invite then
		Global.boot_invite.used = true
		Global.boot_invite.pending = false
	end
	local mission = Global.game_settings.mission ~= "none" and Global.game_settings.mission or nil
	managers.network:session():load_level(level_name, mission, Global.game_settings.world_setting, nil, Global.game_settings.level_id)
end

function TestAPI.close_loadout_screen()
	managers.network:session():local_peer():set_waiting_for_player_ready(true)
	managers.network:session():on_set_member_ready(managers.network:session():local_peer():id(), true, true, false)
end

function TestAPI.check_game_state_group(state_group)
	return {
		group_matched = BaseNetworkHandler._gamestate_filter[state_group][game_state_machine:current_state_name()] and true or false
	}
end

function TestAPI.get_game_state()
	return {
		current_state = game_state_machine:current_state():name()
	}
end
