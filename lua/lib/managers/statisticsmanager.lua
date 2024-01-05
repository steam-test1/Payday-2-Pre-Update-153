StatisticsManager = StatisticsManager or class()

function StatisticsManager:init()
	self:_setup()
	self:_reset_session()
end

function StatisticsManager:_setup(reset)
	self._defaults = {}
	self._defaults.killed = {
		other = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		civilian = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		civilian_female = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		security = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		cop = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		swat = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		heavy_swat = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		total = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		shield = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		spooc = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		tank = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		taser = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		gangster = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		fbi = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		sniper = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		murky = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		},
		patrol = {
			count = 0,
			head_shots = 0,
			melee = 0,
			explosion = 0,
			tied = 0
		}
	}
	self._defaults.killed_by_melee = {}
	self._defaults.killed_by_weapon = {}
	self._defaults.shots_by_weapon = {}
	self._defaults.sessions = {count = 0, time = 0}
	self._defaults.sessions.levels = {}
	for _, lvl in ipairs(tweak_data.levels._level_index) do
		self._defaults.sessions.levels[lvl] = {
			started = 0,
			completed = 0,
			quited = 0,
			drop_in = 0,
			from_beginning = 0,
			time = 0
		}
	end
	self._defaults.sessions.jobs = {}
	self._defaults.revives = {npc_count = 0, player_count = 0}
	self._defaults.cameras = {count = 0}
	self._defaults.objectives = {count = 0}
	self._defaults.shots_fired = {total = 0, hits = 0}
	self._defaults.downed = {
		bleed_out = 0,
		fatal = 0,
		incapacitated = 0,
		death = 0
	}
	self._defaults.reloads = {count = 0}
	self._defaults.health = {amount_lost = 0}
	self._defaults.experience = {}
	self._defaults.misc = {}
	self._defaults.play_time = {minutes = 0}
	if not Global.statistics_manager or reset then
		Global.statistics_manager = deep_clone(self._defaults)
		self._global = Global.statistics_manager
		self._global.session = deep_clone(self._defaults)
		self:_calculate_average()
	end
	self._global = self._global or Global.statistics_manager
	self._m14_shots = 0
	self._m14_kills = 0
	self._last_kill = nil
	self._fbi_kills = 0
	self._patrol_bombed = 0
end

function StatisticsManager:reset()
	self:_setup(true)
end

function StatisticsManager:_reset_session()
	if self._global then
		self._global.session = deep_clone(self._defaults)
	end
end

function StatisticsManager:_write_log_header()
	local file_handle = SystemFS:open(self._data_log_name, "w")
	file_handle:puts(managers.network.account:username())
	file_handle:puts(Network:is_server() and "true" or "false")
end

function StatisticsManager:_flush_log()
	if not self._data_log or #self._data_log == 0 then
		return
	end
	local file_handle = SystemFS:open(self._data_log_name, "a")
	for _, line in ipairs(self._data_log) do
		local type = line[1]
		local time = line[2]
		local pos = line[3]
		if type == 1 then
			file_handle:puts("1 " .. time .. " " .. pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. line[4])
		elseif type == 2 then
			file_handle:puts("2 " .. time .. " " .. pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. line[4] .. " " .. tostring(line[5]))
		elseif type == 3 then
			file_handle:puts("3 " .. time .. " " .. pos.x .. " " .. pos.y .. " " .. pos.z .. " " .. line[4] .. " " .. line[5])
		end
	end
	self._data_log = {}
end

function StatisticsManager:update(t, dt)
	if self._data_log then
		self._log_timer = self._log_timer - dt
		if self._log_timer <= 0 and alive(managers.player:player_unit()) then
			self._log_timer = 0.25
			table.insert(self._data_log, {
				1,
				Application:time(),
				managers.player:player_unit():position(),
				1 / dt
			})
			if Network:is_server() then
				for u_key, u_data in pairs(managers.enemy:all_enemies()) do
					table.insert(self._data_log, {
						2,
						Application:time(),
						u_data.unit:position(),
						1,
						u_key
					})
				end
				for u_key, u_data in pairs(managers.groupai:state()._ai_criminals) do
					table.insert(self._data_log, {
						2,
						Application:time(),
						u_data.unit:position(),
						2,
						u_key
					})
				end
				for u_key, u_data in pairs(managers.enemy:all_civilians()) do
					table.insert(self._data_log, {
						2,
						Application:time(),
						u_data.unit:position(),
						3,
						u_key
					})
				end
			end
			if #self._data_log > 5000 then
				self:_flush_log()
			end
		end
	end
end

function StatisticsManager:start_session(data)
	if self._session_started then
		return
	end
	if not self._playing then
		self._playing = data.from_beginning and "beginning" or "dropin"
	end
	if Global.level_data.level_id then
		self._global.sessions.levels[Global.level_data.level_id].started = self._global.sessions.levels[Global.level_data.level_id].started + 1
		self._global.sessions.levels[Global.level_data.level_id].from_beginning = self._global.sessions.levels[Global.level_data.level_id].from_beginning + (data.from_beginning and 1 or 0)
		self._global.sessions.levels[Global.level_data.level_id].drop_in = self._global.sessions.levels[Global.level_data.level_id].drop_in + (data.drop_in and 1 or 0)
	end
	local job_id = managers.job:current_job_id()
	if job_id and managers.job:current_stage() == 1 then
		local job_stat = tostring(job_id) .. "_" .. tostring(Global.game_settings.difficulty)
		if data.from_beginning then
			self._global.sessions.jobs[job_stat .. "_started"] = (self._global.sessions.jobs[job_stat .. "_started"] or 0) + 1
		end
		if data.drop_in then
			self._global.sessions.jobs[job_stat .. "_started_dropin"] = (self._global.sessions.jobs[job_stat .. "_started_dropin"] or 0) + 1
		end
	end
	self._global.session = deep_clone(self._defaults)
	self._global.sessions.count = self._global.sessions.count + 1
	self._start_session_time = Application:time()
	self._start_session_from_beginning = data.from_beginning
	self._start_session_drop_in = data.drop_in
	self._session_started = true
end

function StatisticsManager:stop_session(data)
	if not self._session_started then
		return
	end
	self:_flush_log()
	self._data_log = nil
	self._session_started = nil
	local success = data and data.success
	local session_time = Application:time() - self._start_session_time
	if Global.level_data.level_id then
		self._global.sessions.levels[Global.level_data.level_id].time = self._global.sessions.levels[Global.level_data.level_id].time + session_time
		if success then
			self._global.sessions.levels[Global.level_data.level_id].completed = self._global.sessions.levels[Global.level_data.level_id].completed + 1
		else
			self._global.sessions.levels[Global.level_data.level_id].quited = self._global.sessions.levels[Global.level_data.level_id].quited + 1
		end
	end
	local job_id = managers.job:current_job_id()
	if job_id and data then
		local job_stat = tostring(job_id) .. "_" .. tostring(Global.game_settings.difficulty)
		if data.type == "victory" then
			if managers.job:on_last_stage() then
				if self._playing == "beginning" then
					self._global.sessions.jobs[job_stat .. "_completed"] = (self._global.sessions.jobs[job_stat .. "_completed"] or 0) + 1
				else
					self._global.sessions.jobs[job_stat .. "_completed_dropin"] = (self._global.sessions.jobs[job_stat .. "_completed_dropin"] or 0) + 1
				end
			end
		elseif data.type == "gameover" then
			if self._playing == "beginning" then
				self._global.sessions.jobs[job_stat .. "_failed"] = (self._global.sessions.jobs[job_stat .. "_failed"] or 0) + 1
			else
				self._global.sessions.jobs[job_stat .. "_failed_dropin"] = (self._global.sessions.jobs[job_stat .. "_failed_dropin"] or 0) + 1
			end
		end
	end
	self._global.sessions.time = self._global.sessions.time + session_time
	self._global.session.sessions.time = session_time
	self._global.last_session = deep_clone(self._global.session)
	self:_calculate_average()
	managers.challenges:session_stopped({
		success = success,
		from_beginning = self._start_session_from_beginning,
		drop_in = self._start_session_drop_in,
		last_session = self._global.last_session
	})
	managers.challenges:reset("session")
	if managers.job:on_last_stage() then
		self._playing = nil
	end
	if SystemInfo:platform() == Idstring("WIN32") then
		self:publish_to_steam(self._global.session, success)
	end
end

function StatisticsManager:started_session_from_beginning()
	return self._start_session_from_beginning
end

function StatisticsManager:_increment_misc(name, amount)
	if not self._global.misc then
		self._global.misc = {}
	end
	self._global.misc[name] = (self._global.misc[name] or 0) + amount
	self._global.session.misc[name] = (self._global.session.misc[name] or 0) + amount
	if self._data_log and alive(managers.player:player_unit()) then
		table.insert(self._data_log, {
			3,
			Application:time(),
			managers.player:player_unit():position(),
			name,
			amount
		})
	end
end

function StatisticsManager:use_trip_mine()
	self:_increment_misc("deploy_trip", 1)
end

function StatisticsManager:use_ammo_bag()
	self:_increment_misc("deploy_ammo", 1)
end

function StatisticsManager:use_doctor_bag()
	self:_increment_misc("deploy_medic", 1)
end

function StatisticsManager:use_ecm_jammer()
	self:_increment_misc("deploy_jammer", 1)
end

function StatisticsManager:use_sentry_gun()
	self:_increment_misc("deploy_sentry", 1)
end

function StatisticsManager:in_custody()
	self:_increment_misc("in_custody", 1)
end

function StatisticsManager:trade(data)
	self:_increment_misc("trade", 1)
end

function StatisticsManager:aquired_money(amount)
	self:_increment_misc("cash", amount * 1000)
end

function StatisticsManager:_get_stat_tables()
	local level_list = {
		"safehouse",
		"jewelry_store",
		"four_stores",
		"nightclub",
		"mallcrasher",
		"ukrainian_job",
		"branchbank",
		"framing_frame_1",
		"framing_frame_2",
		"framing_frame_3",
		"alex_1",
		"alex_2",
		"alex_3",
		"watchdogs_1",
		"watchdogs_2",
		"firestarter_1",
		"firestarter_2",
		"firestarter_3",
		"welcome_to_the_jungle_1",
		"welcome_to_the_jungle_2",
		"escape_cafe_day",
		"escape_park_day",
		"escape_cafe",
		"escape_park",
		"escape_street",
		"escape_overpass",
		"escape_garage",
		"family",
		"arm_cro",
		"arm_und",
		"arm_hcm",
		"arm_par",
		"arm_fac",
		"arm_for",
		"roberts",
		"election_day_1",
		"election_day_2",
		"election_day_3_skip1",
		"election_day_3_skip2"
	}
	local job_list = {
		"jewelry_store",
		"four_stores",
		"nightclub",
		"mallcrasher",
		"ukrainian_job_prof",
		"branchbank_deposit",
		"branchbank_cash",
		"branchbank_gold_prof",
		"branchbank_prof",
		"framing_frame",
		"framing_frame_prof",
		"alex",
		"alex_prof",
		"watchdogs",
		"watchdogs_prof",
		"firestarter",
		"firestarter_prof",
		"welcome_to_the_jungle_prof",
		"family",
		"arm_fac",
		"arm_par",
		"arm_hcm",
		"arm_und",
		"arm_cro",
		"roberts",
		"election_day",
		"election_day_prof"
	}
	return level_list, job_list
end

function StatisticsManager:publish_to_steam(session, success)
	if Application:editor() or not managers.criminals:local_character_name() then
		return
	end
	local session_time_seconds = Application:time() - self._start_session_time
	local session_time_minutes = session_time_seconds / 60
	local session_time = session_time_minutes / 60
	if session_time_seconds == 0 or session_time_minutes == 0 or session_time == 0 then
		return
	end
	if managers.network.account:get_stat("payday2") ~= 0 then
		self:clear_statistics()
	end
	local stats = {}
	self._global.play_time.minutes = math.ceil(self._global.play_time.minutes + session_time_minutes)
	local current_time = math.floor(self._global.play_time.minutes / 60)
	local time_found = false
	local play_times = {
		1000,
		500,
		250,
		200,
		150,
		100,
		80,
		40,
		20,
		10,
		0
	}
	for _, play_time in ipairs(play_times) do
		if not time_found and current_time >= play_time then
			stats["player_time_" .. play_time .. "h"] = {
				type = "int",
				method = "set",
				value = 1
			}
			time_found = true
		else
			stats["player_time_" .. play_time .. "h"] = {
				type = "int",
				method = "set",
				value = 0
			}
		end
	end
	local current_level = managers.experience:current_level()
	stats.player_level = {
		type = "int",
		method = "set",
		value = current_level
	}
	for i = 0, 100, 10 do
		stats["player_level_" .. i] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	local level_range = 100 <= current_level and 100 or math.floor(current_level / 10) * 10
	stats["player_level_" .. level_range] = {
		type = "int",
		method = "set",
		value = 1
	}
	local current_rank = managers.experience:current_rank()
	local current_rank_range = 5 < current_rank and 5 or current_rank
	for i = 0, 5 do
		stats["player_rank_" .. i] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	stats["player_rank_" .. current_rank_range] = {
		type = "int",
		method = "set",
		value = 1
	}
	local current_cash = managers.money:offshore()
	local cash_found = false
	local cash_amount = 1000000000
	current_cash = current_cash / 1000
	for i = 0, 9 do
		if not cash_found and cash_amount <= current_cash then
			stats["player_cash_" .. cash_amount .. "k"] = {
				type = "int",
				method = "set",
				value = 1
			}
			cash_found = true
		else
			stats["player_cash_" .. cash_amount .. "k"] = {
				type = "int",
				method = "set",
				value = 0
			}
		end
		cash_amount = cash_amount / 10
	end
	stats.player_cash_0k = {
		type = "int",
		method = "set",
		value = cash_found and 0 or 1
	}
	for weapon_name, weapon_data in pairs(session.shots_by_weapon) do
		if 0 < weapon_data.total and tweak_data.weapon[weapon_name].statistics then
			stats["weapon_used_" .. weapon_name] = {type = "int", value = 1}
		end
	end
	stats.gadget_used_ammo_bag = {
		type = "int",
		value = session.misc.deploy_ammo or 0
	}
	stats.gadget_used_doctor_bag = {
		type = "int",
		value = session.misc.deploy_medic or 0
	}
	stats.gadget_used_trip_mine = {
		type = "int",
		value = session.misc.deploy_trip or 0
	}
	stats.gadget_used_sentry_gun = {
		type = "int",
		value = session.misc.deploy_sentry or 0
	}
	stats.gadget_used_ecm_jammer = {
		type = "int",
		value = session.misc.deploy_jammer or 0
	}
	local mask_id = managers.blackmarket:equipped_mask().mask_id
	if tweak_data.blackmarket.masks[mask_id].statistics then
		stats["mask_used_" .. mask_id] = {type = "int", value = 1}
	end
	stats["difficulty_" .. Global.game_settings.difficulty] = {type = "int", value = 1}
	stats.heist_success = {
		type = "int",
		value = success and 1 or 0
	}
	stats.heist_failed = {
		type = "int",
		value = success and 0 or 1
	}
	local level_list, job_list = self:_get_stat_tables()
	local level_id = managers.job:current_level_id()
	for _, level in ipairs(level_list) do
		if level_id == level then
			stats["level_" .. level_id] = {type = "int", value = 1}
			break
		end
	end
	local job_id = managers.job:current_job_id()
	for _, job in ipairs(job_list) do
		if job_id == job then
			stats["job_" .. job_id] = {type = "int", value = 1}
			break
		end
	end
	if level_id == "election_day_2" then
		local stealth = managers.groupai and managers.groupai:state():whisper_mode()
		print("[StatisticsManager]: Election Day 2 Voting: " .. (stealth and "Swing Vote" or "Delayed Vote"))
		stats["stats_election_day_" .. (stealth and "s" or "n")] = {type = "int", value = 1}
	end
	managers.network.account:publish_statistics(stats)
end

function StatisticsManager:publish_skills_to_steam()
	if Application:editor() then
		return
	end
	local stats = {}
	local skill_amount = {}
	local skill_data = tweak_data.skilltree.trees
	for tree_index, tree in ipairs(skill_data) do
		skill_amount[tree_index] = 0
		for _, tier in ipairs(tree.tiers) do
			for _, skill in ipairs(tier) do
				local skill_points = managers.skilltree:next_skill_step(skill)
				local skill_bought = 1 < skill_points and 1 or 0
				local skill_aced = 2 < skill_points and 1 or 0
				stats["skill_" .. tree.skill .. "_" .. skill] = {
					type = "int",
					method = "set",
					value = skill_bought
				}
				stats["skill_" .. tree.skill .. "_" .. skill .. "_ace"] = {
					type = "int",
					method = "set",
					value = skill_aced
				}
				skill_amount[tree_index] = skill_amount[tree_index] + skill_bought + skill_aced
			end
		end
	end
	for tree_index, tree in ipairs(skill_data) do
		stats["skill_" .. tree.skill] = {
			type = "int",
			method = "set",
			value = skill_amount[tree_index]
		}
		for i = 0, 35, 5 do
			stats["skill_" .. tree.skill .. "_" .. i] = {
				type = "int",
				method = "set",
				value = 0
			}
		end
		local skill_count = math.ceil(skill_amount[tree_index] / 5) * 5
		if 35 < skill_count then
			skill_count = 35
		end
		stats["skill_" .. tree.skill .. "_" .. skill_count] = {
			type = "int",
			method = "set",
			value = 1
		}
	end
	managers.network.account:publish_statistics(stats)
end

function StatisticsManager:clear_statistics()
	local stats = {}
	stats.player_time = {
		type = "int",
		method = "set",
		value = 0
	}
	local play_times = {
		1000,
		500,
		250,
		200,
		150,
		100,
		80,
		40,
		20,
		10,
		0
	}
	for _, play_time in ipairs(play_times) do
		stats["player_time_" .. play_time .. "h"] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	stats.player_level = {
		type = "int",
		method = "set",
		value = 0
	}
	for i = 0, 100, 10 do
		stats["player_level_" .. i] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	for i = 0, 5 do
		stats["player_rank_" .. i] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	stats.player_cash = {
		type = "int",
		method = "set",
		value = 0
	}
	local cash_amount = 1000000000
	for i = 0, 9 do
		stats["player_cash_" .. cash_amount .. "k"] = {
			type = "int",
			method = "set",
			value = 0
		}
		cash_amount = cash_amount / 10
	end
	stats.player_cash_0k = {
		type = "int",
		method = "set",
		value = 0
	}
	for weapon_name, weapon in pairs(tweak_data.weapon) do
		if weapon.autohit and weapon.statistics then
			stats["weapon_used_" .. weapon_name] = {
				type = "int",
				method = "set",
				value = 0
			}
		end
	end
	stats.gadget_used_ammo_bag = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.gadget_used_doctor_bag = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.gadget_used_trip_mine = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.gadget_used_sentry_gun = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.gadget_used_ecm_jammer = {
		type = "int",
		method = "set",
		value = 0
	}
	for mask_name, mask in pairs(tweak_data.blackmarket.masks) do
		if tweak_data.blackmarket.masks[mask_name].statistics then
			stats["mask_used_" .. mask_name] = {
				type = "int",
				method = "set",
				value = 0
			}
		end
	end
	for _, difficulty in pairs(tweak_data.difficulties) do
		stats["difficulty_" .. difficulty] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	stats.heist_success = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.heist_failed = {
		type = "int",
		method = "set",
		value = 0
	}
	local level_list, job_list = self:_get_stat_tables()
	local level_id = managers.job:current_level_id()
	for _, level in ipairs(level_list) do
		stats["level_" .. level] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	local job_id = managers.job:current_job_id()
	for _, job in ipairs(job_list) do
		stats["job_" .. job] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	stats.stats_election_day_s = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.stats_election_day_n = {
		type = "int",
		method = "set",
		value = 0
	}
	stats.payday2 = {
		type = "int",
		method = "set",
		value = 0
	}
	managers.network.account:publish_statistics(stats)
end

function StatisticsManager:clear_skills_statistics()
	local stats = {}
	local skill_data = tweak_data.skilltree.trees
	for tree_index, tree in ipairs(skill_data) do
		for _, tier in ipairs(tree.tiers) do
			for _, skill in ipairs(tier) do
				stats["skill_" .. tree.skill .. "_" .. skill] = {
					type = "int",
					method = "set",
					value = 0
				}
				stats["skill_" .. tree.skill .. "_" .. skill .. "_ace"] = {
					type = "int",
					method = "set",
					value = 0
				}
			end
		end
	end
	for tree_index, tree in ipairs(skill_data) do
		stats["skill_" .. tree.skill] = {
			type = "int",
			method = "set",
			value = 0
		}
		for i = 0, 35, 5 do
			stats["skill_" .. tree.skill .. "_" .. i] = {
				type = "int",
				method = "set",
				value = 0
			}
		end
	end
	local level_list, job_list = self:_get_stat_tables()
	for _, level_id in ipairs(level_list) do
		stats["level_" .. level_id] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	for _, job_id in ipairs(job_list) do
		stats["job_" .. job_id] = {
			type = "int",
			method = "set",
			value = 0
		}
	end
	managers.network.account:publish_statistics(stats)
end

function StatisticsManager:debug_estimate_steam_players()
	local key
	local stats = {}
	local account = managers.network.account
	local days = 10000
	local num_players = 0
	local play_times = {
		0,
		10,
		20,
		40,
		80,
		100,
		150,
		200,
		250,
		500,
		1000
	}
	for _, play_time in ipairs(play_times) do
		key = "player_time_" .. play_time .. "h"
		num_players = num_players + account:get_global_stat(key)
	end
	Application:debug(managers.money:add_decimal_marks_to_string(tostring(num_players)) .. " players have summited statistics to Steam the last 60 days.")
end

function StatisticsManager:debug_print_stats(global_flag, days)
	local key
	local stats = {}
	local account = managers.network.account
	days = days or nil
	local num_players = 0
	local play_times = {
		0,
		10,
		20,
		40,
		80,
		100,
		150,
		200,
		250,
		500,
		1000
	}
	local play_stat
	for _, play_time in ipairs(play_times) do
		key = "player_time_" .. play_time .. "h"
		play_stat = account:get_global_stat(key, days)
		num_players = num_players + (0 <= play_stat and play_stat or 0)
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = play_stat
		})
	end
	table.insert(stats, {
		name = "player_level",
		loc = account:get_stat("player_level"),
		glo = account:get_global_stat("player_level", days)
	})
	for i = 0, 100, 10 do
		key = "player_level_" .. i
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
	end
	for i = 0, 5 do
		key = "player_rank_" .. i
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
	end
	table.insert(stats, {
		name = "player_cash_0k",
		loc = account:get_stat("player_cash_0k"),
		glo = account:get_global_stat("player_cash_0k", days)
	})
	local cash_amount = 1
	for i = 0, 9 do
		key = "player_cash_" .. cash_amount .. "k"
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
		cash_amount = cash_amount * 10
	end
	local skill_data = tweak_data.skilltree.trees
	for tree_index, tree in ipairs(skill_data) do
		for _, tier in ipairs(tree.tiers) do
			for _, skill in ipairs(tier) do
				key = "skill_" .. tree.skill .. "_" .. skill
				table.insert(stats, {
					name = key,
					loc = account:get_stat(key),
					glo = account:get_global_stat(key, days)
				})
				key = "skill_" .. tree.skill .. "_" .. skill .. "_ace"
				table.insert(stats, {
					name = key,
					loc = account:get_stat(key),
					glo = account:get_global_stat(key, days)
				})
			end
		end
	end
	for tree_index, tree in ipairs(skill_data) do
		key = "skill_" .. tree.skill
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
		for i = 0, 35, 5 do
			key = "skill_" .. tree.skill .. "_" .. i
			table.insert(stats, {
				name = key,
				loc = account:get_stat(key),
				glo = account:get_global_stat(key, days)
			})
		end
	end
	for weapon_name, weapon in pairs(tweak_data.weapon) do
		if weapon.autohit and weapon.statistics then
			key = "weapon_used_" .. weapon_name
			table.insert(stats, {
				name = key,
				loc = account:get_stat(key),
				glo = account:get_global_stat(key, days)
			})
		end
	end
	table.insert(stats, {
		name = "gadget_used_ammo_bag",
		loc = account:get_stat("gadget_used_ammo_bag"),
		glo = account:get_global_stat("gadget_used_ammo_bag", days)
	})
	table.insert(stats, {
		name = "gadget_used_doctor_bag",
		loc = account:get_stat("gadget_used_doctor_bag"),
		glo = account:get_global_stat("gadget_used_doctor_bag", days)
	})
	table.insert(stats, {
		name = "gadget_used_trip_mine",
		loc = account:get_stat("gadget_used_trip_mine"),
		glo = account:get_global_stat("gadget_used_trip_mine", days)
	})
	table.insert(stats, {
		name = "gadget_used_sentry_gun",
		loc = account:get_stat("gadget_used_sentry_gun"),
		glo = account:get_global_stat("gadget_used_sentry_gun", days)
	})
	table.insert(stats, {
		name = "gadget_used_ecm_jammer",
		loc = account:get_stat("gadget_used_ecm_jammer"),
		glo = account:get_global_stat("gadget_used_ecm_jammer", days)
	})
	for mask_name, mask in pairs(tweak_data.blackmarket.masks) do
		if tweak_data.blackmarket.masks[mask_name].statistics then
			key = "mask_used_" .. mask_name
			table.insert(stats, {
				name = key,
				loc = account:get_stat(key),
				glo = account:get_global_stat(key, days)
			})
		end
	end
	for _, difficulty in pairs(tweak_data.difficulties) do
		key = "difficulty_" .. difficulty
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
	end
	table.insert(stats, {
		name = "heist_success",
		loc = account:get_stat("heist_success"),
		glo = account:get_global_stat("heist_success", days)
	})
	table.insert(stats, {
		name = "heist_failed",
		loc = account:get_stat("heist_failed"),
		glo = account:get_global_stat("heist_failed", days)
	})
	local level_list, job_list = self:_get_stat_tables()
	for _, level_id in ipairs(level_list) do
		key = "level_" .. level_id
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
	end
	for _, job_id in ipairs(job_list) do
		key = "job_" .. job_id
		table.insert(stats, {
			name = key,
			loc = account:get_stat(key),
			glo = account:get_global_stat(key, days)
		})
	end
	table.insert(stats, {
		name = "stats_election_day_s",
		loc = account:get_stat("stats_election_day_s"),
		glo = account:get_global_stat("stats_election_day_s", days)
	})
	table.insert(stats, {
		name = "stats_election_day_n",
		loc = account:get_stat("stats_election_day_n"),
		glo = account:get_global_stat("stats_election_day_n", days)
	})
	table.insert(stats, {
		name = "payday2",
		loc = account:get_stat("payday2"),
		glo = account:get_global_stat("payday2", days)
	})
	print("----------------------------------")
	print((global_flag and "GLOBAL" or "LOCAL") .. " STEAM STATISTICS FOR " .. (days == 1 and "TODAY" or days == -1 and "YESTERDAY" or not days and "ALLTIME" or "LAST " .. days .. " DAYS"))
	print("----------------------------------")
	for key, data in pairs(stats) do
		print(data.name, global_flag and data.glo or data.loc)
	end
	if global_flag then
		print("----------------------------------")
		print("Average Players Per Day: " .. managers.money:add_decimal_marks_to_string(tostring(num_players)))
	end
	print("----------------------------------")
end

function StatisticsManager:_calculate_average()
	local t = self._global.sessions.count ~= 0 and self._global.sessions.count or 1
	self._global.average = {}
	self._global.average.killed = deep_clone(self._global.killed)
	self._global.average.sessions = deep_clone(self._global.sessions)
	self._global.average.revives = deep_clone(self._global.revives)
	for _, data in pairs(self._global.average.killed) do
		data.count = math.round(data.count / t)
		data.head_shots = math.round(data.head_shots / t)
		data.melee = math.round(data.melee / t)
		data.explosion = math.round(data.explosion / t)
	end
	self._global.average.sessions.time = self._global.average.sessions.time / t
	for lvl, data in pairs(self._global.average.sessions.levels) do
		data.time = data.time / t
	end
	for counter, value in pairs(self._global.average.revives) do
		self._global.average.revives[counter] = math.round(value / t)
	end
	self._global.average.shots_fired = deep_clone(self._global.shots_fired)
	self._global.average.shots_fired.total = math.round(self._global.average.shots_fired.total / t)
	self._global.average.shots_fired.hits = math.round(self._global.average.shots_fired.hits / t)
	self._global.average.downed = deep_clone(self._global.downed)
	self._global.average.downed.bleed_out = math.round(self._global.average.downed.bleed_out / t)
	self._global.average.downed.fatal = math.round(self._global.average.downed.fatal / t)
	self._global.average.downed.incapacitated = math.round(self._global.average.downed.incapacitated / t)
	self._global.average.downed.death = math.round(self._global.average.downed.death / t)
	self._global.average.reloads = deep_clone(self._global.reloads)
	self._global.average.reloads.count = math.round(self._global.average.reloads.count / t)
	self._global.average.experience = deep_clone(self._global.experience)
	for size, data in pairs(self._global.average.experience) do
		if data.actions then
			data.count = math.round(data.count / t)
			for action, count in pairs(data.actions) do
				data.actions[action] = math.round(count / t)
			end
		end
	end
end

function StatisticsManager:killed_by_anyone(data)
	local by_explosion = data.variant == "explosion"
	local name_id = data.weapon_unit and data.weapon_unit:base():get_name_id()
	managers.achievment:set_script_data("pacifist_fail", true)
	if name_id ~= "m79" and name_id ~= "m79_npc" then
		managers.achievment:set_script_data("blow_out_fail", true)
	end
	if by_explosion and data.name == "patrol" and name_id ~= "m79" then
		self._patrol_bombed = self._patrol_bombed + 1
		if self._patrol_bombed >= 12 and Global.level_data.level_id == "diamond_heist" then
			managers.challenges:set_flag("bomb_man")
		end
	end
end

function StatisticsManager:killed(data)
	data.type = tweak_data.character[data.name] and tweak_data.character[data.name].challenges.type
	if not self._global.killed[data.name] then
		Application:error("Bad name id applied to killed, " .. tostring(data.name) .. ". Defaulting to 'other'")
		data.name = "other"
	end
	local by_bullet = data.variant == "bullet"
	local by_melee = data.variant == "melee"
	local by_explosion = data.variant == "explosion"
	local type = self._global.killed[data.name]
	type.count = type.count + 1
	type.head_shots = type.head_shots + (data.head_shot and 1 or 0)
	type.melee = type.melee + (by_melee and 1 or 0)
	type.explosion = type.explosion + (by_explosion and 1 or 0)
	self._global.killed.total.count = self._global.killed.total.count + 1
	self._global.killed.total.head_shots = self._global.killed.total.head_shots + (data.head_shot and 1 or 0)
	self._global.killed.total.melee = self._global.killed.total.melee + (by_melee and 1 or 0)
	self._global.killed.total.explosion = self._global.killed.total.explosion + (by_explosion and 1 or 0)
	local type = self._global.session.killed[data.name]
	type.count = type.count + 1
	type.head_shots = type.head_shots + (data.head_shot and 1 or 0)
	type.melee = type.melee + (by_melee and 1 or 0)
	type.explosion = type.explosion + (by_explosion and 1 or 0)
	self._global.session.killed.total.count = self._global.session.killed.total.count + 1
	self._global.session.killed.total.head_shots = self._global.session.killed.total.head_shots + (data.head_shot and 1 or 0)
	self._global.session.killed.total.melee = self._global.session.killed.total.melee + (by_melee and 1 or 0)
	self._global.session.killed.total.explosion = self._global.session.killed.total.explosion + (by_explosion and 1 or 0)
	if by_bullet then
		local name_id = data.weapon_unit:base():get_name_id()
		self._global.session.killed_by_weapon[name_id] = self._global.session.killed_by_weapon[name_id] or {count = 0, headshots = 0}
		self._global.session.killed_by_weapon[name_id].count = self._global.session.killed_by_weapon[name_id].count + 1
		self._global.session.killed_by_weapon[name_id].headshots = self._global.session.killed_by_weapon[name_id].headshots + (data.head_shot and 1 or 0)
		self._global.killed_by_weapon[name_id] = self._global.killed_by_weapon[name_id] or {count = 0, headshots = 0}
		self._global.killed_by_weapon[name_id].count = self._global.killed_by_weapon[name_id].count + 1
		self._global.killed_by_weapon[name_id].headshots = (self._global.killed_by_weapon[name_id].headshots or 0) + (data.head_shot and 1 or 0)
		self:_bullet_challenges(data)
		if self._global.session.killed_by_weapon[name_id].count == tweak_data.achievement.first_blood.count then
			local category = data.weapon_unit:base():weapon_tweak_data().category
			if category == tweak_data.achievement.first_blood.weapon_type then
				managers.achievment:award(tweak_data.achievement.first_blood.award)
			end
		end
		if name_id == "sentry_gun" then
			managers.challenges:count_up("sentry_gun_law_row_kills")
			if game_state_machine:last_queued_state_name() == "ingame_waiting_for_respawn" then
				managers.challenges:count_up("grim_reaper")
			end
		else
			managers.challenges:reset_counter("sentry_gun_law_row_kills")
		end
		if data.name == "tank" then
			managers.achievment:set_script_data("dodge_this_active", true)
			if name_id == "r870_shotgun" or name_id == "mossberg" then
				managers.challenges:set_flag("cheney")
			end
		end
		if name_id == "m14" then
			if self._m14_kills == self._m14_shots then
				if self._m14_kills == 29 then
					managers.challenges:set_flag("one_shot_one_kill")
				end
			else
				self._m14_kills = 0
				self._m14_shots = 0
			end
			self._m14_kills = self._m14_kills + 1
		end
	elseif by_melee then
		local name_id = data.name_id
		self._global.session.killed_by_melee[name_id] = (self._global.session.killed_by_melee[name_id] or 0) + 1
		self._global.killed_by_melee[name_id] = (self._global.killed_by_melee[name_id] or 0) + 1
		self:_melee_challenges(data)
		managers.challenges:reset_counter("sentry_gun_law_row_kills")
	elseif by_explosion then
		local name_id = data.weapon_unit and data.weapon_unit:base():get_name_id()
		if name_id == "m79" then
			self._global.session.killed_by_weapon[name_id] = self._global.session.killed_by_weapon[name_id] or {count = 0, headshots = 0}
			self._global.session.killed_by_weapon[name_id].count = self._global.session.killed_by_weapon[name_id].count + 1
			self._global.session.killed_by_weapon[name_id].headshots = self._global.session.killed_by_weapon[name_id].headshots + (data.head_shot and 1 or 0)
			self._global.killed_by_weapon[name_id] = self._global.killed_by_weapon[name_id] or {count = 0, headshots = 0}
			self._global.killed_by_weapon[name_id].count = self._global.killed_by_weapon[name_id].count + 1
			self._global.killed_by_weapon[name_id].headshots = (self._global.killed_by_weapon[name_id].headshots or 0) + (data.head_shot and 1 or 0)
			self:_bullet_challenges(data)
		end
		self:_explosion_challenges(data)
		managers.challenges:reset_counter("sentry_gun_law_row_kills")
	end
	self._last_kill = data.name
	if self:session_total_law_enforcer_kills() >= 100 then
		managers.challenges:set_flag("civil_disobedience")
	end
	if data.name == "fbi" then
		self._fbi_kills = self._fbi_kills + 1
		if self._fbi_kills >= 25 then
			managers.challenges:set_flag("federal_crime")
		end
	else
		self._fbi_kills = 0
	end
end

function StatisticsManager:completed_job(job_id, difficulty)
	return self._global.sessions.jobs[tostring(job_id) .. "_" .. tostring(difficulty) .. "_completed"] or 0
end

function StatisticsManager:_bullet_challenges(data)
	managers.challenges:count_up(data.type .. "_kill")
	managers.challenges:count_up(data.name .. "_kill")
	if data.head_shot then
		managers.challenges:count_up(data.type .. "_head_shot")
	else
		managers.challenges:count_up(data.type .. "_body_shot")
	end
	if data.attacker_state and data.attacker_state == "bleed_out" then
		local weapon_name_id = data.weapon_unit:base():get_name_id()
		if weapon_name_id ~= "sentry_gun" then
			managers.challenges:count_up("bleed_out_kill")
			managers.challenges:count_up("bleed_out_multikill")
		end
	end
	local weapon_tweak_data = data.weapon_unit:base():weapon_tweak_data()
	if weapon_tweak_data.challenges then
		if weapon_tweak_data.challenges.weapon then
			managers.challenges:count_up(weapon_tweak_data.challenges.weapon .. "_" .. data.type .. "_kill")
			managers.challenges:count_up(weapon_tweak_data.challenges.weapon .. "_" .. data.name .. "_kill")
		else
			managers.challenges:count_up((weapon_tweak_data.challenges.group or weapon_tweak_data.challenges.prefix) .. "_kill")
		end
		if data.head_shot then
			if weapon_tweak_data.challenges.weapon then
				managers.challenges:count_up(weapon_tweak_data.challenges.weapon .. "_" .. data.type .. "_head_shot")
				managers.challenges:count_up(weapon_tweak_data.challenges.weapon .. "_" .. data.name .. "_head_shot")
			else
				managers.challenges:count_up((weapon_tweak_data.challenges.group or weapon_tweak_data.challenges.prefix) .. "_head_shot")
			end
		elseif weapon_tweak_data.challenges.weapon then
			managers.challenges:count_up(weapon_tweak_data.challenges.weapon .. "_" .. data.type .. "_body_shot")
			managers.challenges:count_up(weapon_tweak_data.challenges.weapon .. "_" .. data.name .. "_body_shot")
		else
			managers.challenges:count_up((weapon_tweak_data.challenges.group or weapon_tweak_data.challenges.prefix) .. "_body_shot")
		end
	end
end

function StatisticsManager:_melee_challenges(data)
	if data.type == "law" then
		managers.challenges:count_up("melee_law_kill")
	end
end

function StatisticsManager:_explosion_challenges(data)
	if game_state_machine:last_queued_state_name() == "ingame_waiting_for_respawn" then
		managers.challenges:count_up("grim_reaper")
	end
	local weapon_id = data.weapon_unit and data.weapon_unit:base():get_name_id()
	if weapon_id == "m79" then
		managers.challenges:count_up("m79_law_simultaneous_kills")
		if data.name == "shield" or data.name == "spooc" or data.name == "tank" or data.name == "taser" then
			managers.challenges:count_up("m79_simultaneous_specials")
		end
	elseif weapon_id == "trip_mine" and data.type == "law" then
		managers.challenges:count_up("trip_mine_law_kill")
	end
end

function StatisticsManager:tied(data)
	data.type = tweak_data.character[data.name] and tweak_data.character[data.name].challenges.type
	if not self._global.killed[data.name] then
		Application:error("Bad name id applied to tied, " .. tostring(data.name) .. ". Defaulting to 'other'")
		data.name = "other"
	end
	if data.name == "heavy_swat" then
		managers.challenges:set_flag("intimidating")
	end
	self._global.killed[data.name].tied = (self._global.killed[data.name].tied or 0) + 1
	self._global.session.killed[data.name].tied = self._global.session.killed[data.name].tied + 1
	local type = tweak_data.character[data.name] and tweak_data.character[data.name].challenges.type
	if type then
		managers.challenges:count_up("tiedown_" .. type)
	end
	managers.challenges:count_up("tiedown_" .. data.name)
	if self._data_log and alive(managers.player:player_unit()) then
		table.insert(self._data_log, {
			3,
			Application:time(),
			managers.player:player_unit():position(),
			"tiedown",
			1
		})
	end
end

function StatisticsManager:revived(data)
	if not data.reviving_unit or data.reviving_unit ~= managers.player:player_unit() then
		return
	end
	local counter = data.npc and "npc_count" or "player_count"
	self._global.revives[counter] = self._global.revives[counter] + 1
	self._global.session.revives[counter] = self._global.session.revives[counter] + 1
	managers.challenges:count_up("revive")
	if self._data_log and alive(managers.player:player_unit()) then
		table.insert(self._data_log, {
			3,
			Application:time(),
			managers.player:player_unit():position(),
			"revive",
			1
		})
	end
end

function StatisticsManager:camera_destroyed(data)
	self._global.cameras.count = self._global.cameras.count + 1
	self._global.session.cameras.count = self._global.session.cameras.count + 1
end

function StatisticsManager:objective_completed(data)
	if managers.platform:presence() ~= "Playing" and managers.platform:presence() ~= "Mission_end" then
		return
	end
	self._global.objectives.count = self._global.objectives.count + 1
	self._global.session.objectives.count = self._global.session.objectives.count + 1
end

function StatisticsManager:health_subtracted(amount)
	self._global.health.amount_lost = self._global.health.amount_lost + amount
	self._global.session.health.amount_lost = self._global.session.health.amount_lost + amount
end

function StatisticsManager:shot_fired(data)
	self._global.shots_fired.total = self._global.shots_fired.total + 1
	self._global.session.shots_fired.total = self._global.session.shots_fired.total + 1
	local name_id = data.weapon_unit:base():get_name_id()
	self._global.session.shots_by_weapon[name_id] = self._global.session.shots_by_weapon[name_id] or {hits = 0, total = 0}
	self._global.session.shots_by_weapon[name_id].total = self._global.session.shots_by_weapon[name_id].total + 1
	self._global.shots_by_weapon[name_id] = self._global.shots_by_weapon[name_id] or {hits = 0, total = 0}
	self._global.shots_by_weapon[name_id].total = self._global.shots_by_weapon[name_id].total + 1
	if data.hit then
		self._global.shots_fired.hits = self._global.shots_fired.hits + 1
		self._global.session.shots_fired.hits = self._global.session.shots_fired.hits + 1
		self._global.session.shots_by_weapon[name_id].hits = self._global.session.shots_by_weapon[name_id].hits + 1
		self._global.shots_by_weapon[name_id].hits = self._global.shots_by_weapon[name_id].hits + 1
	end
	if name_id == "m14" then
		self._m14_shots = self._m14_shots + 1
	end
end

function StatisticsManager:downed(data)
	managers.achievment:set_script_data("stand_together_fail", true)
	local counter = data.bleed_out and "bleed_out" or data.fatal and "fatal" or data.incapacitated and "incapacitated" or "death"
	self._global.downed[counter] = self._global.downed[counter] + 1
	self._global.session.downed[counter] = self._global.session.downed[counter] + 1
	if data.bleed_out then
		managers.challenges:reset("bleed_out")
	end
	if self._data_log and alive(managers.player:player_unit()) then
		table.insert(self._data_log, {
			3,
			Application:time(),
			managers.player:player_unit():position(),
			"downed",
			1
		})
	end
end

function StatisticsManager:reloaded(data)
	self._global.reloads.count = self._global.reloads.count + 1
	self._global.session.reloads.count = self._global.session.reloads.count + 1
	if self._data_log and alive(managers.player:player_unit()) then
		table.insert(self._data_log, {
			3,
			Application:time(),
			managers.player:player_unit():position(),
			"reloaded",
			1
		})
	end
end

function StatisticsManager:recieved_experience(data)
	self._global.experience[data.size] = self._global.experience[data.size] or {
		count = 0,
		actions = {}
	}
	self._global.experience[data.size].count = self._global.experience[data.size].count + 1
	self._global.experience[data.size].actions[data.action] = self._global.experience[data.size].actions[data.action] or 0
	self._global.experience[data.size].actions[data.action] = self._global.experience[data.size].actions[data.action] + 1
	self._global.session.experience[data.size] = self._global.session.experience[data.size] or {
		count = 0,
		actions = {}
	}
	self._global.session.experience[data.size].count = self._global.session.experience[data.size].count + 1
	self._global.session.experience[data.size].actions[data.action] = self._global.session.experience[data.size].actions[data.action] or 0
	self._global.session.experience[data.size].actions[data.action] = self._global.session.experience[data.size].actions[data.action] + 1
end

function StatisticsManager:get_killed()
	return self._global.killed
end

function StatisticsManager:count_up(id)
	if not self._statistics[id] then
		Application:stack_dump_error("Bad id to count up, " .. tostring(id) .. ".")
		return
	end
	self._statistics[id].count = self._statistics[id].count + 1
end

function StatisticsManager:print_stats()
	local time_text = self:_time_text(math.round(self._global.sessions.time))
	local time_average_text = self:_time_text(math.round(self._global.average.sessions.time))
	local t = self._global.sessions.count ~= 0 and self._global.sessions.count or 1
	print("- Sessions \t\t-")
	print("Total sessions:\t", self._global.sessions.count)
	print("Total time:\t\t", time_text)
	print("Average time:\t", time_average_text)
	print([[

- Levels 		-]])
	for name, data in pairs(self._global.sessions.levels) do
		local time_text = self:_time_text(math.round(data.time))
		print("Started: " .. data.started .. "\tBeginning: " .. data.from_beginning .. "\tDrop in: " .. data.drop_in .. "\tCompleted: " .. data.completed .. "\tQuited: " .. data.quited .. "\tTime: " .. time_text .. "\t- " .. name)
	end
	print([[

- Kills 		-]])
	for name, data in pairs(self._global.killed) do
		print("Count: " .. self:_amount_format(data.count) .. "/" .. self:_amount_format(self._global.average.killed[name].count, true) .. " Head shots: " .. self:_amount_format(data.head_shots) .. "/" .. self:_amount_format(self._global.average.killed[name].head_shots, true) .. " Melee: " .. self:_amount_format(data.melee) .. "/" .. self:_amount_format(self._global.average.killed[name].melee, true) .. " Explosion: " .. self:_amount_format(data.explosion) .. "/" .. self:_amount_format(self._global.average.killed[name].explosion, true) .. " " .. name)
	end
	print([[

- Revives 		-]])
	print("Count: " .. self._global.revives.npc_count .. "/" .. self._global.average.revives.npc_count .. "\t- Npcs")
	print("Count: " .. self._global.revives.player_count .. "/" .. self._global.average.revives.player_count .. "\t- Players")
	print([[

- Cameras 		-]])
	print("Count: " .. self._global.cameras.count)
	print([[

- Objectives 	-]])
	print("Count: " .. self._global.objectives.count)
	print([[

- Shots fired 	-]])
	print("Total: " .. self._global.shots_fired.total .. "/" .. self._global.average.shots_fired.total)
	print("Hits: " .. self._global.shots_fired.hits .. "/" .. self._global.average.shots_fired.hits)
	print("Hit percentage: " .. math.round(self._global.shots_fired.hits / (self._global.shots_fired.total ~= 0 and self._global.shots_fired.total or 1) * 100) .. "%")
	print([[

- Downed 	-]])
	print("Bleed out: " .. self._global.downed.bleed_out .. "/" .. self._global.average.downed.bleed_out)
	print("Fatal: " .. self._global.downed.fatal .. "/" .. self._global.average.downed.fatal)
	print("Incapacitated: " .. self._global.downed.incapacitated .. "/" .. self._global.average.downed.incapacitated)
	print("Death: " .. self._global.downed.death .. "/" .. self._global.average.downed.death)
	print([[

- Reloads 	-]])
	print("Count: " .. self._global.reloads.count .. "/" .. self._global.average.reloads.count)
	self:_print_experience_stats()
end

function StatisticsManager:is_dropin()
	return self._start_session_drop_in
end

function StatisticsManager:_print_experience_stats()
	local t = self._global.sessions.count ~= 0 and self._global.sessions.count or 1
	local average = self._global.average.experience
	local total = 0
	print([[

- Experience -]])
	for size, data in pairs(self._global.experience) do
		local exp = tweak_data.experience_manager.values[size]
		local average_count = average[size] and self:_amount_format(average[size].count, true) or "-"
		local average_exp = average[size] and self:_amount_format(exp * average[size].count, true) or "-"
		total = total + exp * data.count
		print([[

Size: ]] .. size .. " " .. self:_amount_format(exp, true) .. "" .. self:_amount_format(data.count) .. "/" .. average_count .. " " .. self:_amount_format(exp * data.count) .. "/" .. average_exp)
		for action, count in pairs(data.actions) do
			local average_count = average[size] and average[size].actions[action] and self:_amount_format(average[size].actions[action], true) or "-"
			local average_exp = average[size] and average[size].actions[action] and self:_amount_format(exp * average[size].actions[action], true) or "-"
			print("\tAction: " .. action)
			print("\t\tCount:" .. self:_amount_format(count) .. "/" .. average_count .. self:_amount_format(exp * count) .. "/" .. average_exp)
		end
	end
	print([[

Total:]] .. self:_amount_format(total) .. "/" .. self:_amount_format(total / t, true))
end

function StatisticsManager:_amount_format(amount, left)
	amount = math.round(amount)
	local s = ""
	for i = 6 - string.len(amount), 0, -1 do
		s = s .. " "
	end
	return left and amount .. s or s .. amount
end

function StatisticsManager:_time_text(time, params)
	local no_days = params and params.no_days
	local days = no_days and 0 or math.floor(time / 86400)
	time = time - days * 86400
	local hours = math.floor(time / 3600)
	time = time - hours * 3600
	local minutes = math.floor(time / 60)
	time = time - minutes * 60
	local seconds = math.round(time)
	return (no_days and "" or (days < 10 and "0" .. days or days) .. ":") .. (hours < 10 and "0" .. hours or hours) .. ":" .. (minutes < 10 and "0" .. minutes or minutes) .. ":" .. (seconds < 10 and "0" .. seconds or seconds)
end

function StatisticsManager:_check_loaded_data()
	if not self._global.downed.incapacitated then
		self._global.downed.incapacitated = 0
	end
	for name, data in pairs(self._defaults.killed) do
		self._global.killed[name] = self._global.killed[name] or deep_clone(self._defaults.killed[name])
	end
	for name, data in pairs(self._global.killed) do
		data.melee = data.melee or 0
		data.explosion = data.explosion or 0
	end
	for name, lvl in pairs(self._defaults.sessions.levels) do
		self._global.sessions.levels[name] = self._global.sessions.levels[name] or deep_clone(lvl)
	end
	for _, lvl in pairs(self._global.sessions.levels) do
		lvl.drop_in = lvl.drop_in or 0
		lvl.from_beginning = lvl.from_beginning or 0
	end
	self._global.sessions.jobs = self._global.sessions.jobs or {}
	self._global.experience = self._global.experience or deep_clone(self._defaults.experience)
end

function StatisticsManager:time_played()
	local time = math.round(self._global.sessions.time)
	local time_text = self:_time_text(time)
	return time_text, time
end

function StatisticsManager:favourite_level()
	local started = 0
	local c_name
	for name, data in pairs(self._global.sessions.levels) do
		c_name = started < data.started and name or c_name
		started = started < data.started and data.started or started
	end
	return c_name and tweak_data.levels:get_localized_level_name_from_level_id(c_name) or managers.localization:text("debug_undecided")
end

function StatisticsManager:total_completed_campaigns()
	local i = 0
	for name, data in pairs(self._global.sessions.levels) do
		i = i + data.completed
	end
	return i
end

function StatisticsManager:favourite_weapon()
	local weapon_id
	local count = 0
	for id, data in pairs(self._global.killed_by_weapon) do
		if count < data.count then
			count = data.count
			weapon_id = id
		end
	end
	return weapon_id and managers.localization:text(tweak_data.weapon[weapon_id].name_id) or managers.localization:text("debug_undecided")
end

function StatisticsManager:total_kills()
	return self._global.killed.total.count
end

function StatisticsManager:total_head_shots()
	return self._global.killed.total.head_shots
end

function StatisticsManager:hit_accuracy()
	if self._global.shots_fired.total == 0 then
		return 0
	end
	return math.floor(self._global.shots_fired.hits / self._global.shots_fired.total * 100)
end

function StatisticsManager:total_completed_objectives()
	return self._global.objectives.count
end

function StatisticsManager:total_downed()
	return self._global.session.downed.bleed_out + self._global.session.downed.incapacitated
end

function StatisticsManager:session_time_played()
	local time = math.round(self._global.session.sessions.time)
	local time_text = self:_time_text(time, {no_days = true})
	return time_text, time
end

function StatisticsManager:completed_objectives()
	return self._global.session.objectives.count
end

function StatisticsManager:session_favourite_weapon()
	local weapon_id
	local count = 0
	for id, data in pairs(self._global.session.killed_by_weapon) do
		if count < data.count then
			count = data.count
			weapon_id = id
		end
	end
	return weapon_id and managers.localization:text(tweak_data.weapon[weapon_id].name_id) or managers.localization:text("debug_undecided")
end

function StatisticsManager:session_total_kills()
	return self._global.session.killed.total.count
end

function StatisticsManager:session_total_shots(weapon_type)
	local weapon = weapon_type == "primaries" and managers.blackmarket:equipped_primary() or managers.blackmarket:equipped_secondary()
	local weapon_data = weapon and self._global.session.shots_by_weapon[weapon.weapon_id]
	return weapon_data and weapon_data.total or 0
end

function StatisticsManager:session_total_specials_kills()
	return self._global.session.killed.shield.count + self._global.session.killed.spooc.count + self._global.session.killed.tank.count + self._global.session.killed.taser.count
end

function StatisticsManager:session_total_head_shots()
	return self._global.session.killed.total.head_shots
end

function StatisticsManager:session_hit_accuracy()
	if self._global.session.shots_fired.total == 0 then
		return 0
	end
	return math.floor(self._global.session.shots_fired.hits / self._global.session.shots_fired.total * 100)
end

function StatisticsManager:session_total_civilian_kills()
	return self._global.session.killed.civilian.count + self._global.session.killed.civilian_female.count
end

function StatisticsManager:session_total_law_enforcer_kills()
	return self._global.session.killed.total.count - self._global.session.killed.civilian.count - self._global.session.killed.civilian_female.count - self._global.session.killed.gangster.count - self._global.session.killed.other.count
end

function StatisticsManager:send_statistics()
	if not managers.network:session() then
		return
	end
	local peer_id = managers.network:session():local_peer():id()
	local total_kills = self:session_total_kills()
	local total_specials_kills = self:session_total_specials_kills()
	local total_head_shots = self:session_total_head_shots()
	local accuracy = self:session_hit_accuracy()
	local downs = self:total_downed()
	if Network:is_server() then
		managers.network:game():on_statistics_recieved(peer_id, total_kills, total_specials_kills, total_head_shots, accuracy, downs)
	else
		managers.network:session():send_to_host("send_statistics", peer_id, total_kills, total_specials_kills, total_head_shots, accuracy, downs)
	end
end

function StatisticsManager:save(data)
	local state = {
		camera = self._global.cameras,
		downed = self._global.downed,
		killed = self._global.killed,
		objectives = self._global.objectives,
		reloads = self._global.reloads,
		revives = self._global.revives,
		sessions = self._global.sessions,
		shots_fired = self._global.shots_fired,
		experience = self._global.experience,
		killed_by_melee = self._global.killed_by_melee,
		killed_by_weapon = self._global.killed_by_weapon,
		shots_by_weapon = self._global.shots_by_weapon,
		health = self._global.health,
		misc = self._global.misc,
		play_time = self._global.play_time
	}
	data.StatisticsManager = state
end

function StatisticsManager:load(data)
	local state = data.StatisticsManager
	if state then
		for name, stats in pairs(state) do
			self._global[name] = stats
		end
		self:_check_loaded_data()
		self:_calculate_average()
	end
end
