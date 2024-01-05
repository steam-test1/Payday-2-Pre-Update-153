JobManager = JobManager or class()

function JobManager:init()
	self:_setup()
end

function JobManager:_setup()
	if not Global.job_manager then
		Global.job_manager = {}
	end
	self._global = Global.job_manager
end

function JobManager:on_retry_job_stage()
	self._global.next_alternative_stage = nil
	self._global.next_interupt_stage = nil
end

function JobManager:synced_alternative_stage(alternative)
	self._global.alternative_stage = alternative
end

function JobManager:set_next_alternative_stage(alternative)
	self._global.next_alternative_stage = alternative
end

function JobManager:alternative_stage()
	return self._global.alternative_stage
end

function JobManager:synced_interupt_stage(interupt)
	self._global.interupt_stage = interupt
end

function JobManager:set_next_interupt_stage(interupt)
	self._global.next_interupt_stage = interupt
end

function JobManager:interupt_stage()
	return self._global.interupt_stage
end

function JobManager:has_active_job()
	return self._global.current_job and true or false
end

function JobManager:activate_job(job_id, current_stage)
	local job = tweak_data.narrative.jobs[job_id]
	if not job then
		Application:error("No job named", job_id, "!")
		return
	end
	self._global.current_job = {
		job_id = job_id,
		current_stage = current_stage or 1,
		last_completed_stage = 0,
		stages = #job.chain
	}
	self._global.start_time = TimerManager:wall_running():time()
	return true
end

function JobManager:deactivate_current_job()
	self._global.current_job = nil
	self._global.alternative_stage = nil
	self._global.next_alternative_stage = nil
	self._global.interupt_stage = nil
	self._global.next_interupt_stage = nil
	self._global.start_time = nil
	managers.loot:on_job_deactivated()
	managers.mission:on_job_deactivated()
end

function JobManager:complete_stage()
	self._global.current_job.current_stage = current_stage + 1
end

function JobManager:on_last_stage()
	if not self._global.current_job then
		return false
	end
	return self._global.current_job.current_stage == self._global.current_job.stages
end

function JobManager:is_job_finished()
	if not self._global.current_job then
		return false
	end
	return self._global.current_job.last_completed_stage == self._global.current_job.stages
end

function JobManager:next_stage()
	if not self:has_active_job() then
		return
	end
	self._global.current_job.last_completed_stage = self._global.current_job.current_stage
	if self:is_job_finished() then
		self:_check_add_to_cooldown()
		managers.achievment:award("no_turning_back")
		return
	end
	self._global.alternative_stage = self._global.next_alternative_stage
	self._global.next_alternative_stage = nil
	self._global.interupt_stage = self._global.next_interupt_stage
	self._global.next_interupt_stage = nil
	if not self._global.interupt_stage then
		self:set_current_stage(self._global.current_job.current_stage + 1)
	end
	Global.game_settings.level_id = managers.job:current_level_id()
	Global.game_settings.mission = managers.job:current_mission()
	if Network:is_server() then
		MenuCallbackHandler:update_matchmake_attributes()
		local level_id_index = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
		local interupt_level_id_index = self._global.interupt_stage and tweak_data.levels:get_index_from_level_id(self._global.interupt_stage) or 0
		managers.network:session():send_to_peers("sync_stage_settings", level_id_index, self._global.current_job.current_stage, self._global.alternative_stage or 0, interupt_level_id_index)
	end
end

function JobManager:set_current_stage(stage_num)
	self._global.current_job.current_stage = stage_num
end

function JobManager:current_job_data()
	if not self._global.current_job then
		return
	end
	return tweak_data.narrative.jobs[self._global.current_job.job_id]
end

function JobManager:current_job_id()
	if not self._global.current_job then
		return
	end
	return self._global.current_job.job_id
end

function JobManager:is_current_job_professional()
	if not self._global.current_job then
		return
	end
	return tweak_data.narrative.jobs[self._global.current_job.job_id].professional
end

function JobManager:is_job_professional_by_job_id(job_id)
	if not job_id or not tweak_data.narrative.jobs[job_id] then
		Application:error("[JobManager:is_job_professional_by_job_id] no job id or no job", job_id)
		return
	end
	return tweak_data.narrative.jobs[job_id].professional and true or false
end

function JobManager:current_stage()
	if not self._global.current_job then
		return
	end
	return self._global.current_job.current_stage
end

function JobManager:current_stage_data()
	if not self._global.current_job then
		return
	end
	local job_data = tweak_data.narrative.jobs[self._global.current_job.job_id]
	local stage = job_data.chain[self._global.current_job.current_stage]
	if 0 < #stage then
		return stage[self._global.alternative_stage or 1]
	end
	return stage
end

function JobManager:current_level_id()
	if not self._global.current_job then
		return
	end
	if self._global.interupt_stage then
		return self._global.interupt_stage
	end
	return self:current_stage_data().level_id
end

function JobManager:current_mission()
	if not self._global.current_job then
		return
	end
	if self._global.interupt_stage then
		return "none"
	end
	return self:current_stage_data().mission or "none"
end

function JobManager:current_mission_filter()
	if not self._global.current_job then
		return
	end
	return self:current_stage_data().mission_filter
end

function JobManager:current_level_data()
	if not self._global.current_job then
		return
	end
	return tweak_data.levels[self:current_level_id()]
end

function JobManager:current_contact_id()
	if not self._global.current_job then
		return
	end
	return tweak_data.narrative.jobs[self._global.current_job.job_id].contact
end

function JobManager:current_contact_data()
	if self._global.interupt_stage then
		return tweak_data.narrative.contacts.interupt
	end
	return tweak_data.narrative.contacts[self:current_contact_id()]
end

function JobManager:current_job_stars()
	return math.ceil(tweak_data.narrative.jobs[self._global.current_job.job_id].jc / 10)
end

function JobManager:current_difficulty_stars()
	local difficulty = Global.game_settings.difficulty or "easy"
	local difficulty_id = math.max(0, (tweak_data:difficulty_to_index(difficulty) or 0) - 2)
	return difficulty_id
end

function JobManager:current_job_and_difficulty_stars()
	local difficulty = Global.game_settings.difficulty or "easy"
	local difficulty_id = math.max(0, (tweak_data:difficulty_to_index(difficulty) or 0) - 2)
	return self:current_job_stars() + difficulty_id
end

function JobManager:set_stage_success(success)
	self._stage_success = success
end

function JobManager:stage_success()
	return self._stage_success
end

function JobManager:check_ok_with_cooldown(job_id)
	if not self._global.cooldown then
		return true
	end
	if not self._global.cooldown[job_id] then
		return true
	end
	return TimerManager:wall_running():time() > self._global.cooldown[job_id]
end

function JobManager:_check_add_to_cooldown()
	if Network:is_server() and self._global.start_time then
		local cooldown_time = self._global.start_time + tweak_data.narrative.CONTRACT_COOLDOWN_TIME - TimerManager:wall_running():time()
		if 0 < cooldown_time then
			self._global.cooldown = self._global.cooldown or {}
			self._global.cooldown[self:current_job_id()] = cooldown_time + TimerManager:wall_running():time()
		end
	end
end
