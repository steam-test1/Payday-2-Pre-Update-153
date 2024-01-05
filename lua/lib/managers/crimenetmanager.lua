require("lib/managers/menu/WalletGuiObject")
CrimeNetManager = CrimeNetManager or class()

function CrimeNetManager:init()
	self._tweak_data = tweak_data.gui.crime_net
	self._active = false
	self._active_jobs = {}
	self:_setup_vars()
end

function CrimeNetManager:_setup_vars()
	self._active_job_time = self._tweak_data.job_vars.active_job_time
	self._NEW_JOB_MIN_TIME = self._tweak_data.job_vars.new_job_min_time
	self._NEW_JOB_MAX_TIME = self._tweak_data.job_vars.new_job_max_time
	self._next_job_timer = (self._NEW_JOB_MIN_TIME + self._NEW_JOB_MAX_TIME) / 2
	self._MAX_ACTIVE_JOBS = self._tweak_data.job_vars.max_active_jobs
	self._max_active_server_jobs = self._tweak_data.job_vars.max_active_server_jobs
	self._refresh_server_t = 0
	self._REFRESH_SERVERS_TIME = self._tweak_data.job_vars.refresh_servers_time
	if Application:production_build() then
		self._debug_mass_spawning = tweak_data.gui.crime_net.debug_options.mass_spawn or false
	end
	self._active_server_jobs = {}
end

function CrimeNetManager:set_max_active_server_jobs(max_server_jobs)
	self._max_active_server_jobs = max_server_jobs
end

function CrimeNetManager:get_max_active_server_jobs()
	return self._max_active_server_jobs
end

function CrimeNetManager:_get_jobs_by_jc()
	local t = {}
	local plvl = managers.experience:current_level()
	local prank = managers.experience:current_rank()
	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local is_cooldown_ok = managers.job:check_ok_with_cooldown(job_id)
		local is_not_wrapped = not tweak_data.narrative.jobs[job_id].wrapped_to_job
		local dlc = tweak_data.narrative:job_data(job_id).dlc
		local is_not_dlc_or_got = not dlc or managers.dlc:has_dlc(dlc)
		local pass_all_tests = is_cooldown_ok and is_not_wrapped and is_not_dlc_or_got
		if pass_all_tests then
			local job_data = tweak_data.narrative:job_data(job_id)
			local start_difficulty = job_data.professional and 1 or 0
			local num_difficulties = Global.SKIP_OVERKILL_290 and 3 or job_data.professional and 4 or 4
			for i = start_difficulty, num_difficulties do
				local job_jc = math.clamp(job_data.jc + i * 10, 0, 100)
				local difficulty_id = 2 + i
				local difficulty = tweak_data:index_to_difficulty(difficulty_id)
				local level_lock = tweak_data.difficulty_level_locks[difficulty_id] or 0
				local is_not_level_locked = 1 <= prank or plvl >= level_lock
				if is_not_level_locked then
					t[job_jc] = t[job_jc] or {}
					table.insert(t[job_jc], {
						job_id = job_id,
						difficulty_id = difficulty_id,
						difficulty = difficulty
					})
				end
			end
		else
			print("SKIP DUE TO COOLDOWN OR THE JOB IS WRAPPED INSIDE AN OTHER JOB", job_id)
		end
	end
	return t
end

function CrimeNetManager:_number_of_jobs(jcs, jobs_by_jc)
	local amount = 0
	for _, jc in ipairs(jcs) do
		if jobs_by_jc[jc] then
			amount = amount + #jobs_by_jc[jc]
		end
	end
	return amount
end

function CrimeNetManager:_setup()
	if self._presets then
		return
	end
	self._presets = {}
	local plvl = managers.experience:current_level()
	local player_stars = math.clamp(math.ceil((plvl + 1) / 10), 1, 10)
	local stars = player_stars
	local jc = math.lerp(0, 100, stars / 10)
	local jcs = tweak_data.narrative.STARS[stars].jcs
	local no_jcs = #jcs
	local chance_curve = tweak_data.narrative.STARS_CURVES[player_stars]
	local start_chance = tweak_data.narrative.JC_CHANCE
	local jobs_by_jc = self:_get_jobs_by_jc()
	local no_picks = self:_number_of_jobs(jcs, jobs_by_jc)
	local j = 0
	local tests = 0
	while no_picks > j do
		for i = 1, no_jcs do
			local chance
			if no_jcs - 1 == 0 then
				chance = 1
			else
				chance = math.lerp(start_chance, 1, math.pow((i - 1) / (no_jcs - 1), chance_curve))
			end
			if not jobs_by_jc[jcs[i]] then
			elseif #jobs_by_jc[jcs[i]] == 0 then
			else
				local job_data
				if self._debug_mass_spawning then
					job_data = jobs_by_jc[jcs[i]][math.random(#jobs_by_jc[jcs[i]])]
				else
					job_data = table.remove(jobs_by_jc[jcs[i]], math.random(#jobs_by_jc[jcs[i]]))
				end
				local job_tweak = tweak_data.narrative:job_data(job_data.job_id)
				local chance_multiplier = job_tweak and job_tweak.spawn_chance_multiplier or 1
				job_data.chance = chance * chance_multiplier
				table.insert(self._presets, job_data)
				j = j + 1
				break
			end
		end
		tests = tests + 1
		if self._debug_mass_spawning then
			if tests >= tweak_data.gui.crime_net.debug_options.mass_spawn_limit then
				break
			end
		elseif no_picks <= tests then
			break
		end
	end
	local old_presets = self._presets
	self._presets = {}
	while 0 < #old_presets do
		table.insert(self._presets, table.remove(old_presets, math.random(#old_presets)))
	end
end

function CrimeNetManager:reset_seed()
	self._presets = nil
end

function CrimeNetManager:update(t, dt)
	if not self._active then
		return
	end
	for id, job in pairs(self._active_jobs) do
		if not job.added then
			job.added = true
			managers.menu_component:add_crimenet_gui_preset_job(id)
		end
		job.active_timer = job.active_timer - dt
		managers.menu_component:update_crimenet_job(id, t, dt)
		managers.menu_component:feed_crimenet_job_timer(id, job.active_timer, self._active_job_time)
		if job.active_timer < 0 then
			managers.menu_component:remove_crimenet_gui_job(id)
			self._active_jobs[id] = nil
		end
	end
	local max_active_jobs = math.min(self._MAX_ACTIVE_JOBS, #self._presets)
	if self._debug_mass_spawning then
		max_active_jobs = math.min(tweak_data.gui.crime_net.debug_options.mass_spawn_limit, #self._presets)
	end
	if max_active_jobs > table.size(self._active_jobs) and table.size(self._active_jobs) + table.size(self._active_server_jobs) < tweak_data.gui.crime_net.job_vars.total_active_jobs then
		self._next_job_timer = self._next_job_timer - dt
		if 0 > self._next_job_timer then
			self._next_job_timer = math.rand(self._NEW_JOB_MIN_TIME, self._NEW_JOB_MAX_TIME)
			self:activate_job()
			if self._debug_mass_spawning then
				self._next_job_timer = tweak_data.gui.crime_net.debug_options.mass_spawn_timer
			end
		end
	end
	for id, job in pairs(self._active_server_jobs) do
		job.alive_time = job.alive_time + dt
		managers.menu_component:update_crimenet_job(id, t, dt)
		managers.menu_component:feed_crimenet_server_timer(id, job.alive_time)
	end
	managers.menu_component:update_crimenet_gui(t, dt)
	if not self._skip_servers then
		if self._refresh_server_t < Application:time() then
			self:find_online_games(Global.game_settings.search_friends_only)
			self._refresh_server_t = Application:time() + self._REFRESH_SERVERS_TIME
		end
	elseif self._refresh_server_t < Application:time() then
		self._refresh_server_t = Application:time() + self._REFRESH_SERVERS_TIME
	end
end

function CrimeNetManager:start_no_servers()
	self:start(true)
end

function CrimeNetManager:start(skip_servers)
	self:_setup()
	self._active_jobs = {}
	self._active = true
	self._active_server_jobs = {}
	self._refresh_server_t = 0
	self._skip_servers = skip_servers
	if #self._active_jobs == 0 then
		self._next_job_timer = 1
	end
end

function CrimeNetManager:no_servers()
	return self._skip_servers
end

function CrimeNetManager:stop()
	self._active = false
	for _, data in pairs(self._active_jobs) do
		data.added = false
	end
end

function CrimeNetManager:deactivate()
	self._active = false
end

function CrimeNetManager:activate()
	self._active = true
	self._refresh_server_t = 0
end

function CrimeNetManager:activate_job()
	local i = math.random(#self._presets)
	while i ~= i - 1 do
		local chance = self._presets[i].chance
		local roll = math.rand(1)
		if chance >= roll and not self._active_jobs[i] and i ~= 0 then
			print("-- activate", math.round(chance * 100) .. "%", self._presets[i].job_id, roll, chance)
			self._active_jobs[i] = {
				added = false,
				active_timer = self._active_job_time + math.random(5)
			}
			return
		end
		i = 1 + math.mod(i, #self._presets)
	end
end

function CrimeNetManager:preset(id)
	return self._presets[id]
end

function CrimeNetManager:find_online_games(friends_only)
	self:_find_online_games(friends_only)
end

function CrimeNetManager:_crimenet_gui()
	return managers.menu_component._crimenet_gui
end

local is_win32 = SystemInfo:platform() == Idstring("WIN32")
local is_ps3 = SystemInfo:platform() == Idstring("PS3")
local is_x360 = SystemInfo:platform() == Idstring("X360")

function CrimeNetManager:_find_online_games(friends_only)
	if is_win32 then
		self:_find_online_games_win32(friends_only)
	elseif is_ps3 then
		self:_find_online_games_ps3(friends_only)
	elseif is_x360 then
		self:_find_online_games_xbox360(friends_only)
	else
		Application:error("[CrimeNetManager] Unknown gaming platform trying to access Crime.net!")
	end
end

function CrimeNetManager:_find_online_games_xbox360(friends_only)
	local function f(info)
		local friends = managers.network.friends:get_friends_by_name()
		
		managers.network.matchmake:search_lobby_done()
		local room_list = info.room_list
		local attribute_list = info.attribute_list
		local dead_list = {}
		for id, _ in pairs(self._active_server_jobs) do
			dead_list[id] = true
		end
		for i, room in ipairs(room_list) do
			local name_str = tostring(room.owner_name)
			local attributes_numbers = attribute_list[i].numbers
			if managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers) then
				dead_list[room.room_id] = nil
				local host_name = name_str
				local level_id = tweak_data.levels:get_level_name_from_index(attributes_numbers[1] % 1000)
				local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id
				local level_name = name_id and managers.localization:text(name_id) or "LEVEL NAME ERROR"
				local difficulty_id = attributes_numbers[2]
				local difficulty = tweak_data:index_to_difficulty(difficulty_id)
				local job_id = tweak_data.narrative:get_job_name_from_index(math.floor(attributes_numbers[1] / 1000))
				local state_string_id = tweak_data:index_to_server_state(attributes_numbers[4])
				local state_name = state_string_id and managers.localization:text("menu_lobby_server_state_" .. state_string_id) or "UNKNOWN"
				local state = attributes_numbers[4]
				local num_plrs = attributes_numbers[5]
				local is_friend = friends[host_name] and true or false
				if name_id then
					if not self._active_server_jobs[room.room_id] then
						if table.size(self._active_jobs) + table.size(self._active_server_jobs) < tweak_data.gui.crime_net.job_vars.total_active_jobs then
							self._active_server_jobs[room.room_id] = {added = false, alive_time = 0}
							managers.menu_component:add_crimenet_server_job({
								room_id = room.room_id,
								info = room.info,
								id = room.room_id,
								level_id = level_id,
								difficulty = difficulty,
								difficulty_id = difficulty_id,
								num_plrs = num_plrs,
								host_name = host_name,
								state_name = state_name,
								state = state,
								level_name = level_name,
								job_id = job_id,
								is_friend = is_friend
							})
						end
					else
						managers.menu_component:update_crimenet_server_job({
							room_id = room.room_id,
							info = room.info,
							id = room.room_id,
							level_id = level_id,
							difficulty = difficulty,
							difficulty_id = difficulty_id,
							num_plrs = num_plrs,
							host_name = host_name,
							state_name = state_name,
							state = state,
							level_name = level_name,
							job_id = job_id,
							is_friend = is_friend
						})
					end
				end
			end
		end
		for id, _ in pairs(dead_list) do
			self._active_server_jobs[id] = nil
			managers.menu_component:remove_crimenet_gui_job(id)
		end
	end
	
	managers.network.matchmake:register_callback("search_lobby", f)
	managers.network.matchmake:search_lobby(friends_only)
end

function CrimeNetManager:_find_online_games_ps3(friends_only)
	local function f(info_list)
		managers.network.matchmake:search_lobby_done()
		
		local friend_names = managers.network.friends:get_names_friends_list()
		for _, info in ipairs(info_list) do
			local room_list = info.room_list
			local attribute_list = info.attribute_list
			for i, room in ipairs(room_list) do
				local name_str = tostring(room.owner_id)
				local friend_str = room.friend_id and tostring(room.friend_id)
				local attributes_numbers = attribute_list[i].numbers
				if managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers) then
					local host_name = name_str
					local level_id, name_id, level_name, difficulty_id, difficulty, job_id, state_string_id, state_name, state, num_plrs = self:_server_properties(attributes_numbers)
					local is_friend = friend_names[host_name] and true or false
					if name_id and not self._active_server_jobs[name_str] and table.size(self._active_jobs) + table.size(self._active_server_jobs) < tweak_data.gui.crime_net.job_vars.total_active_jobs then
						self._active_server_jobs[name_str] = {
							added = false,
							alive_time = 0,
							room_id = room.room_id
						}
						managers.menu_component:add_crimenet_server_job({
							room_id = room.room_id,
							id = name_str,
							level_id = level_id,
							difficulty = difficulty,
							difficulty_id = difficulty_id,
							num_plrs = num_plrs,
							host_name = host_name,
							state_name = state_name,
							state = state,
							level_name = level_name,
							job_id = job_id,
							is_friend = is_friend
						})
					else
					end
				end
			end
		end
	end
	
	if #PSN:get_world_list() == 0 then
		return
	end
	
	local function done_verify_func()
		managers.network.matchmake:register_callback("search_lobby", f)
		managers.network.matchmake:start_search_lobbys(friends_only)
	end
	
	local dead_list = {}
	local rooms_original = {}
	for id, data in pairs(self._active_server_jobs) do
		dead_list[id] = true
		table.insert(rooms_original, data.room_id)
	end
	local rooms = {}
	while 0 < #rooms_original do
		table.insert(rooms, table.remove(rooms_original, math.random(#rooms_original)))
	end
	
	local function updated_session_attributes(active_info_list)
		self._test_result = active_info_list
		if active_info_list then
			local friend_names = managers.network.friends:get_names_friends_list()
			for _, info in ipairs(active_info_list) do
				local room_list = info.room_list
				local attribute_list = info.attribute_list
				for i, room in ipairs(room_list) do
					local name_str = tostring(room.owner_id)
					local friend_str = room.friend_id and tostring(room.friend_id)
					local attributes_numbers = attribute_list[i].numbers
					if friends_only then
					end
					local is_friend = friend_names[name_str] and true or false
					if (not friends_only or is_friend) and managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers) then
						dead_list[name_str] = nil
						local host_name = name_str
						local level_id, name_id, level_name, difficulty_id, difficulty, job_id, state_string_id, state_name, state, num_plrs = self:_server_properties(attributes_numbers)
						if name_id and self._active_server_jobs[name_str] then
							managers.menu_component:update_crimenet_server_job({
								room_id = room.room_id,
								id = name_str,
								level_id = level_id,
								difficulty = difficulty,
								difficulty_id = difficulty_id,
								num_plrs = num_plrs,
								host_name = host_name,
								state_name = state_name,
								state = state,
								level_name = level_name,
								job_id = job_id,
								is_friend = is_friend
							})
						end
					end
				end
			end
			for id, _ in pairs(dead_list) do
				self._active_server_jobs[id] = nil
				managers.menu_component:remove_crimenet_gui_job(id)
			end
		end
		done_verify_func()
	end
	
	managers.network.matchmake:update_session_attributes(rooms, updated_session_attributes)
end

function CrimeNetManager:_server_properties(attributes_numbers)
	local level_id = tweak_data.levels:get_level_name_from_index(attributes_numbers[1] % 1000)
	local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id
	local level_name = name_id and managers.localization:text(name_id) or "LEVEL NAME ERROR"
	local difficulty_id = attributes_numbers[2]
	local difficulty = tweak_data:index_to_difficulty(difficulty_id)
	local job_id = tweak_data.narrative:get_job_name_from_index(math.floor(attributes_numbers[1] / 1000))
	local state_string_id = tweak_data:index_to_server_state(attributes_numbers[4])
	local state_name = state_string_id and managers.localization:text("menu_lobby_server_state_" .. state_string_id) or "UNKNOWN"
	local state = attributes_numbers[4]
	local num_plrs = attributes_numbers[8]
	return level_id, name_id, level_name, difficulty_id, difficulty, job_id, state_string_id, state_name, state, num_plrs
end

function CrimeNetManager:_find_online_games_win32(friends_only)
	local function f(info)
		managers.network.matchmake:search_lobby_done()
		
		local room_list = info.room_list
		local attribute_list = info.attribute_list
		local dead_list = {}
		for id, _ in pairs(self._active_server_jobs) do
			dead_list[id] = true
		end
		for i, room in ipairs(room_list) do
			local name_str = tostring(room.owner_name)
			local attributes_numbers = attribute_list[i].numbers
			if managers.network.matchmake:is_server_ok(friends_only, room.owner_id, attributes_numbers) then
				dead_list[room.room_id] = nil
				local host_name = name_str
				local level_id = tweak_data.levels:get_level_name_from_index(attributes_numbers[1] % 1000)
				local name_id = level_id and tweak_data.levels[level_id] and tweak_data.levels[level_id].name_id
				local level_name = name_id and managers.localization:text(name_id) or "LEVEL NAME ERROR"
				local difficulty_id = attributes_numbers[2]
				local difficulty = tweak_data:index_to_difficulty(difficulty_id)
				local job_id = tweak_data.narrative:get_job_name_from_index(math.floor(attributes_numbers[1] / 1000))
				local kick_option = attributes_numbers[8] == 0 and 0 or 1
				local state_string_id = tweak_data:index_to_server_state(attributes_numbers[4])
				local state_name = state_string_id and managers.localization:text("menu_lobby_server_state_" .. state_string_id) or "UNKNOWN"
				local state = attributes_numbers[4]
				local num_plrs = attributes_numbers[5]
				local is_friend = false
				if Steam:logged_on() and Steam:friends() then
					for _, friend in ipairs(Steam:friends()) do
						if friend:id() == room.owner_id then
							is_friend = true
							break
						end
					end
				end
				if name_id then
					if not self._active_server_jobs[room.room_id] then
						if table.size(self._active_jobs) + table.size(self._active_server_jobs) < tweak_data.gui.crime_net.job_vars.total_active_jobs and table.size(self._active_server_jobs) < self._max_active_server_jobs then
							self._active_server_jobs[room.room_id] = {added = false, alive_time = 0}
							managers.menu_component:add_crimenet_server_job({
								room_id = room.room_id,
								id = room.room_id,
								level_id = level_id,
								difficulty = difficulty,
								difficulty_id = difficulty_id,
								num_plrs = num_plrs,
								host_name = host_name,
								state_name = state_name,
								state = state,
								level_name = level_name,
								job_id = job_id,
								is_friend = is_friend,
								kick_option = kick_option
							})
						end
					else
						managers.menu_component:update_crimenet_server_job({
							room_id = room.room_id,
							id = room.room_id,
							level_id = level_id,
							difficulty = difficulty,
							difficulty_id = difficulty_id,
							num_plrs = num_plrs,
							host_name = host_name,
							state_name = state_name,
							state = state,
							level_name = level_name,
							job_id = job_id,
							is_friend = is_friend,
							kick_option = kick_option
						})
					end
				end
			end
		end
		for id, _ in pairs(dead_list) do
			self._active_server_jobs[id] = nil
			managers.menu_component:remove_crimenet_gui_job(id)
		end
	end
	
	managers.network.matchmake:register_callback("search_lobby", f)
	managers.network.matchmake:search_lobby(friends_only)
	local usrs_f = function(success, amount)
		print("usrs_f", success, amount)
		if success then
			managers.menu_component:set_crimenet_players_online(amount)
		end
	end
	Steam:sa_handler():concurrent_users_callback(usrs_f)
	Steam:sa_handler():get_concurrent_users()
end

function CrimeNetManager:save(data)
	data.crimenet = self._global
end

function CrimeNetManager:load(data)
	self._global = data.crimenet
end

CrimeNetGui = CrimeNetGui or class()

function CrimeNetGui:init(ws, fullscreeen_ws, node)
	self._tweak_data = tweak_data.gui.crime_net
	self._crimenet_enabled = true
	managers.menu_component:post_event("crime_net_startup")
	managers.menu_component:close_contract_gui()
	local no_servers = node:parameters().no_servers
	if no_servers then
		managers.crimenet:start_no_servers()
	else
		managers.crimenet:start()
	end
	managers.menu:active_menu().renderer.ws:hide()
	local safe_scaled_size = managers.gui_data:safe_scaled_size()
	self._ws = ws
	self._fullscreen_ws = fullscreeen_ws
	self._fullscreen_panel = self._fullscreen_ws:panel():panel({name = "fullscreen"})
	self._panel = self._ws:panel():panel({name = "main"})
	local full_16_9 = managers.gui_data:full_16_9_size()
	self._fullscreen_panel:bitmap({
		name = "blur_top",
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_ws:panel():w(),
		h = full_16_9.convert_y * 2,
		x = 0,
		y = -full_16_9.convert_y,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._fullscreen_panel:bitmap({
		name = "blur_right",
		texture = "guis/textures/test_blur_df",
		w = full_16_9.convert_x * 2,
		h = self._fullscreen_ws:panel():h(),
		x = self._fullscreen_ws:panel():w() - full_16_9.convert_x,
		y = 0,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._fullscreen_panel:bitmap({
		name = "blur_bottom",
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_ws:panel():w(),
		h = full_16_9.convert_y * 2,
		x = 0,
		y = self._fullscreen_ws:panel():h() - full_16_9.convert_y,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._fullscreen_panel:bitmap({
		name = "blur_left",
		texture = "guis/textures/test_blur_df",
		w = full_16_9.convert_x * 2,
		h = self._fullscreen_ws:panel():h(),
		x = -full_16_9.convert_x,
		y = 0,
		render_template = "VertexColorTexturedBlur3D",
		layer = 1001,
		rotation = 360
	})
	self._panel:rect({
		w = self._panel:w(),
		h = 2,
		x = 0,
		y = 0,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	})
	self._panel:rect({
		w = self._panel:w(),
		h = 2,
		x = 0,
		y = 0,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	}):set_bottom(self._panel:h())
	self._panel:rect({
		w = 2,
		h = self._panel:h(),
		x = 0,
		y = 0,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	}):set_right(self._panel:w())
	self._panel:rect({
		w = 2,
		h = self._panel:h(),
		x = 0,
		y = 0,
		layer = 1,
		color = tweak_data.screen_colors.crimenet_lines,
		blend_mode = "add"
	})
	self._rasteroverlay = self._fullscreen_panel:bitmap({
		name = "rasteroverlay",
		texture = "guis/textures/crimenet_map_rasteroverlay",
		texture_rect = {
			0,
			0,
			32,
			256
		},
		wrap_mode = "wrap",
		blend_mode = "mul",
		layer = 3,
		color = Color(1, 1, 1, 1),
		w = self._fullscreen_panel:w(),
		h = self._fullscreen_panel:h()
	})
	self._fullscreen_panel:bitmap({
		name = "vignette",
		texture = "guis/textures/crimenet_map_vignette",
		layer = 2,
		color = Color(1, 1, 1, 1),
		blend_mode = "mul",
		w = self._fullscreen_panel:w(),
		h = self._fullscreen_panel:h()
	})
	local bd_light = self._fullscreen_panel:bitmap({
		name = "bd_light",
		texture = "guis/textures/pd2/menu_backdrop/bd_light",
		layer = 4
	})
	bd_light:set_size(self._fullscreen_panel:size())
	bd_light:set_alpha(0)
	bd_light:set_blend_mode("add")
	
	local function light_flicker_animation(o)
		local alpha = 0
		local acceleration = 0
		local wanted_alpha = math.rand(1) * 0.3
		local flicker_up = true
		while true do
			wait(0.009, self._fixed_dt)
			over(0.045, function(p)
				o:set_alpha(math.lerp(alpha, wanted_alpha, p))
			end, self._fixed_dt)
			flicker_up = not flicker_up
			alpha = o:alpha()
			wanted_alpha = math.rand(flicker_up and alpha or 0.2, not flicker_up and alpha or 0.3)
		end
	end
	
	bd_light:animate(light_flicker_animation)
	local back_button = self._panel:text({
		name = "back_button",
		text = managers.localization:to_upper_text("menu_back"),
		align = "right",
		vertical = "bottom",
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.button_stage_3,
		layer = 40,
		blend_mode = "add"
	})
	self:make_fine_text(back_button)
	back_button:set_right(self._panel:w() - 10)
	back_button:set_bottom(self._panel:h() - 10)
	back_button:set_visible(managers.menu:is_pc_controller())
	do
		local blur_object = self._panel:bitmap({
			name = "controller_legend_blur",
			texture = "guis/textures/test_blur_df",
			render_template = "VertexColorTexturedBlur3D",
			layer = back_button:layer() - 1
		})
		blur_object:set_shape(back_button:shape())
		if not managers.menu:is_pc_controller() then
			blur_object:set_size(self._panel:w() * 0.5, tweak_data.menu.pd2_medium_font_size)
			blur_object:set_rightbottom(self._panel:w() - 2, self._panel:h() - 2)
		end
	end
	WalletGuiObject.set_wallet(self._panel)
	WalletGuiObject.set_layer(30)
	WalletGuiObject.move_wallet(10, -10)
	local text_id = Global.game_settings.single_player and "menu_crimenet_offline" or "cn_menu_num_players_offline"
	local num_players_text = self._panel:text({
		name = "num_players_text",
		text = managers.localization:to_upper_text(text_id, {amount = "1"}),
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = tweak_data.screen_colors.text,
		layer = 40
	})
	self:make_fine_text(num_players_text)
	num_players_text:set_left(10)
	num_players_text:set_top(10)
	do
		local blur_object = self._panel:bitmap({
			name = "num_players_blur",
			texture = "guis/textures/test_blur_df",
			render_template = "VertexColorTexturedBlur3D",
			layer = num_players_text:layer() - 1
		})
		blur_object:set_shape(num_players_text:shape())
	end
	local legends_button = self._panel:text({
		name = "legends_button",
		text = managers.localization:to_upper_text("menu_cn_legend_show", {
			BTN_X = managers.localization:btn_macro("menu_toggle_legends")
		}),
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = tweak_data.screen_colors.text,
		layer = 40,
		blend_mode = "add"
	})
	self:make_fine_text(legends_button)
	legends_button:set_left(num_players_text:left())
	legends_button:set_top(num_players_text:bottom())
	do
		local blur_object = self._panel:bitmap({
			name = "legends_button_blur",
			texture = "guis/textures/test_blur_df",
			render_template = "VertexColorTexturedBlur3D",
			layer = legends_button:layer() - 1
		})
		blur_object:set_shape(legends_button:shape())
	end
	if managers.menu:is_pc_controller() then
		legends_button:set_color(tweak_data.screen_colors.button_stage_3)
	end
	do
		local w, h
		local mw, mh = 0
		local legend_panel = self._panel:panel({
			name = "legend_panel",
			layer = 40,
			visible = false,
			x = 10,
			y = legends_button:bottom() + 4
		})
		local host_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_host",
			x = 10,
			y = 10
		})
		local host_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_icon:right() + 2,
			y = host_icon:top(),
			text = managers.localization:to_upper_text("menu_cn_legend_host"),
			blend_mode = "add"
		})
		mw = math.max(mw, self:make_fine_text(host_text))
		local join_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_join",
			x = 10,
			y = host_text:bottom()
		})
		local join_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = join_icon:top(),
			text = managers.localization:to_upper_text("menu_cn_legend_join"),
			blend_mode = "add"
		})
		mw = math.max(mw, self:make_fine_text(join_text))
		self:make_color_text(join_text, tweak_data.screen_colors.regular_color)
		local friends_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = join_text:bottom(),
			text = managers.localization:to_upper_text("menu_cn_legend_friends"),
			blend_mode = "add"
		})
		mw = math.max(mw, self:make_fine_text(friends_text))
		self:make_color_text(friends_text, tweak_data.screen_colors.friend_color)
		if managers.crimenet:no_servers() then
			join_icon:hide()
			join_text:hide()
			friends_text:hide()
			friends_text:set_bottom(host_text:bottom())
		end
		local risk_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_risklevel",
			x = 10,
			y = friends_text:bottom()
		})
		local risk_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = risk_icon:top(),
			text = managers.localization:to_upper_text("menu_cn_legend_risk"),
			color = tweak_data.screen_colors.risk,
			blend_mode = "add"
		})
		mw = math.max(mw, self:make_fine_text(risk_text))
		local pro_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = risk_text:bottom(),
			text = managers.localization:to_upper_text("menu_cn_legend_pro"),
			color = tweak_data.screen_colors.pro_color,
			blend_mode = "add"
		})
		mw = math.max(mw, self:make_fine_text(pro_text))
		local ghost_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_minighost",
			x = 7,
			y = pro_text:bottom() + 2 + 2,
			color = tweak_data.screen_colors.ghost_color
		})
		local ghost_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = pro_text:bottom(),
			text = managers.localization:to_upper_text("menu_cn_legend_ghostable"),
			blend_mode = "add",
			color = tweak_data.screen_colors.ghost_color
		})
		mw = math.max(mw, self:make_fine_text(ghost_text))
		local kick_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_kick_marker",
			x = 10,
			y = ghost_text:bottom() + 2
		})
		local kick_text = legend_panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = ghost_text:bottom(),
			text = managers.localization:to_upper_text("menu_cn_kick_disabled"),
			blend_mode = "add"
		})
		mw = math.max(mw, self:make_fine_text(kick_text))
		if managers.crimenet:no_servers() then
			kick_icon:hide()
			kick_text:hide()
			kick_text:set_bottom(ghost_text:bottom())
		end
		legend_panel:set_size(host_text:left() + mw + 10, kick_text:bottom() + 10)
		legend_panel:rect({
			color = Color.black,
			alpha = 0.4,
			layer = -1
		})
		BoxGuiObject:new(legend_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		legend_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			w = legend_panel:w(),
			h = legend_panel:h(),
			render_template = "VertexColorTexturedBlur3D",
			layer = -1
		})
	end
	do
		local w, h
		local mw, mh = 0
		local global_bonuses_panel = self._panel:panel({
			name = "global_bonuses_panel",
			layer = 40,
			y = 10,
			h = 30
		})
		local mul_to_procent_string = function(multiplier)
			local pro = math.round(multiplier * 100)
			local procent_string
			if pro == 0 and multiplier ~= 0 then
				procent_string = string.format("%0.2f", math.abs(multiplier * 100))
			else
				procent_string = tostring(math.abs(pro))
			end
			return procent_string, 0 <= multiplier
		end
		local has_ghost_bonus = managers.job:has_ghost_bonus()
		if has_ghost_bonus then
			repeat
				do
					local ghost_bonus_mul = managers.job:get_ghost_bonus()
					local job_ghost_string = mul_to_procent_string(ghost_bonus_mul)
					local ghost_text = global_bonuses_panel:text({
						font = tweak_data.menu.pd2_small_font,
						font_size = tweak_data.menu.pd2_small_font_size,
						align = "center",
						text = managers.localization:to_upper_text("menu_ghost_bonus", {exp_bonus = job_ghost_string}),
						blend_mode = "add",
						color = tweak_data.screen_colors.ghost_color
					})
				end
				do break end -- pseudo-goto
				local skill_bonus = managers.player:get_skill_exp_multiplier()
				skill_bonus = skill_bonus - 1
				if 0 < skill_bonus then
					local skill_string = mul_to_procent_string(skill_bonus)
					local skill_text = global_bonuses_panel:text({
						font = tweak_data.menu.pd2_small_font,
						font_size = tweak_data.menu.pd2_small_font_size,
						align = "center",
						text = managers.localization:to_upper_text("menu_cn_skill_bonus", {exp_bonus = skill_string}),
						blend_mode = "add",
						color = tweak_data.screen_colors.skill_color
					})
				end
				local infamy_bonus = managers.player:get_infamy_exp_multiplier()
				infamy_bonus = infamy_bonus - 1
				if 0 < infamy_bonus then
					local infamy_string = mul_to_procent_string(infamy_bonus)
					local infamy_text = global_bonuses_panel:text({
						font = tweak_data.menu.pd2_small_font,
						font_size = tweak_data.menu.pd2_small_font_size,
						align = "center",
						text = managers.localization:to_upper_text("menu_cn_infamy_bonus", {exp_bonus = infamy_string}),
						blend_mode = "add",
						color = tweak_data.lootdrop.global_values.infamy.color
					})
				end
				local limited_bonus = tweak_data:get_value("experience_manager", "limited_bonus_multiplier") or 1
				limited_bonus = limited_bonus - 1
				if 0 < limited_bonus then
					local limited_string = mul_to_procent_string(limited_bonus)
					local limited_text = global_bonuses_panel:text({
						font = tweak_data.menu.pd2_small_font,
						font_size = tweak_data.menu.pd2_small_font_size,
						align = "center",
						text = managers.localization:to_upper_text("menu_cn_limited_bonus", {exp_bonus = limited_string}),
						blend_mode = "add",
						color = tweak_data.screen_colors.button_stage_2
					})
				end
			until true
		end
		if 1 < #global_bonuses_panel:children() then
			for i, child in ipairs(global_bonuses_panel:children()) do
				child:set_alpha(0)
			end
			
			local function global_bonuses_anim(panel)
				local child_num = 1
				local viewing_child = panel:children()[child_num]
				local t = 0
				local dt = 0
				while alive(viewing_child) do
					if not self._crimenet_enabled then
						coroutine.yield()
					else
						viewing_child:set_alpha(0)
						over(0.5, function(p)
							viewing_child:set_alpha(math.sin(p * 90))
						end)
						viewing_child:set_alpha(1)
						over(4, function(p)
							viewing_child:set_alpha((math.cos(p * 360 * 2) + 1) * 0.5 * 0.2 + 0.8)
						end)
						over(0.5, function(p)
							viewing_child:set_alpha(math.cos(p * 90))
						end)
						viewing_child:set_alpha(0)
						child_num = child_num % #panel:children() + 1
						viewing_child = panel:children()[child_num]
					end
				end
			end
			
			global_bonuses_panel:animate(global_bonuses_anim)
		elseif #global_bonuses_panel:children() == 1 then
			local function global_bonuses_anim(panel)
				while alive(panel) do
					if not self._crimenet_enabled then
						coroutine.yield()
					else
						over(2, function(p)
							panel:set_alpha((math.sin(p * 360) + 1) * 0.5 * 0.2 + 0.8)
						end)
					end
				end
			end
			
			global_bonuses_panel:animate(global_bonuses_anim)
		end
	end
	if not no_servers then
		local id = is_x360 and "menu_cn_friends" or "menu_cn_filter"
		local filter_button = self._panel:text({
			name = "filter_button",
			text = managers.localization:to_upper_text(id, {
				BTN_Y = managers.localization:btn_macro("menu_toggle_filters")
			}),
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.screen_colors.text,
			layer = 40,
			blend_mode = "add"
		})
		self:make_fine_text(filter_button)
		filter_button:set_right(self._panel:w() - 10)
		filter_button:set_top(10)
		do
			local blur_object = self._panel:bitmap({
				name = "filter_button_blur",
				texture = "guis/textures/test_blur_df",
				render_template = "VertexColorTexturedBlur3D",
				layer = filter_button:layer() - 1
			})
			blur_object:set_shape(filter_button:shape())
		end
		if managers.menu:is_pc_controller() then
			filter_button:set_color(tweak_data.screen_colors.button_stage_3)
		end
		if is_ps3 then
			local invites_button = self._panel:text({
				name = "invites_button",
				text = managers.localization:get_default_macro("BTN_BACK") .. " " .. managers.localization:to_upper_text("menu_view_invites"),
				font_size = tweak_data.menu.pd2_medium_font_size,
				font = tweak_data.menu.pd2_medium_font,
				color = tweak_data.screen_colors.text,
				layer = 40,
				blend_mode = "add"
			})
			self:make_fine_text(invites_button)
			invites_button:set_right(filter_button:right())
			invites_button:set_top(filter_button:bottom())
			do
				local blur_object = self._panel:bitmap({
					name = "invites_button_blur",
					texture = "guis/textures/test_blur_df",
					render_template = "VertexColorTexturedBlur3D",
					layer = filter_button:layer() - 1
				})
				blur_object:set_shape(invites_button:shape())
			end
			if not self._ps3_invites_controller then
				local invites_cb = callback(self, self, "ps3_invites_callback")
				self._ps3_invites_controller = managers.controller:create_controller("ps3_invites_controller", managers.controller:get_default_wrapper_index(), false)
				self._ps3_invites_controller:add_trigger("back", invites_cb)
			end
			self._ps3_invites_controller:set_enabled(true)
		end
	end
	self._map_size_w = 2048
	self._map_size_h = 1024
	local aspect = 1.7777778
	local sw = math.min(self._map_size_w, self._map_size_h * aspect)
	local sh = math.min(self._map_size_h, self._map_size_w / aspect)
	local dw = self._map_size_w / sw
	local dh = self._map_size_h / sh
	self._map_size_w = dw * 1280
	self._map_size_h = dh * 720
	local pw, ph = self._map_size_w, self._map_size_h
	self._pan_panel_border = 2.7777777
	self._pan_panel_job_border_x = full_16_9.convert_x + self._pan_panel_border * 2
	self._pan_panel_job_border_y = full_16_9.convert_y + self._pan_panel_border * 2
	self._pan_panel = self._panel:panel({
		name = "pan",
		w = pw,
		h = ph,
		layer = 0
	})
	self._pan_panel:set_center(self._fullscreen_panel:w() / 2, self._fullscreen_panel:h() / 2)
	self._jobs = {}
	self._deleting_jobs = {}
	self._map_panel = self._fullscreen_panel:panel({
		name = "map",
		w = pw,
		h = ph
	})
	self._map_panel:bitmap({
		name = "map",
		texture = "guis/textures/crimenet_map",
		layer = 0,
		w = pw,
		h = ph
	})
	self._map_panel:child("map"):set_halign("scale")
	self._map_panel:child("map"):set_valign("scale")
	self._map_panel:set_shape(self._pan_panel:shape())
	self._map_x, self._map_y = self._map_panel:position()
	if not managers.menu:is_pc_controller() then
		managers.mouse_pointer:confine_mouse_pointer(self._panel)
		managers.menu:active_menu().input:activate_controller_mouse()
		managers.mouse_pointer:set_mouse_world_position(managers.gui_data:safe_to_full(self._panel:world_center()))
	end
	self.MIN_ZOOM = 1
	self.MAX_ZOOM = 9
	self._zoom = 1
	local cross_indicator_h1 = self._fullscreen_panel:bitmap({
		name = "cross_indicator_h1",
		texture = "guis/textures/pd2/skilltree/dottedline",
		w = self._fullscreen_panel:w(),
		h = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1,
		wrap_mode = "wrap"
	})
	local cross_indicator_h2 = self._fullscreen_panel:bitmap({
		name = "cross_indicator_h2",
		texture = "guis/textures/pd2/skilltree/dottedline",
		w = self._fullscreen_panel:w(),
		h = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1,
		wrap_mode = "wrap"
	})
	local cross_indicator_v1 = self._fullscreen_panel:bitmap({
		name = "cross_indicator_v1",
		texture = "guis/textures/pd2/skilltree/dottedline",
		h = self._fullscreen_panel:h(),
		w = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1,
		wrap_mode = "wrap"
	})
	local cross_indicator_v2 = self._fullscreen_panel:bitmap({
		name = "cross_indicator_v2",
		texture = "guis/textures/pd2/skilltree/dottedline",
		h = self._fullscreen_panel:h(),
		w = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1,
		wrap_mode = "wrap"
	})
	local line_indicator_h1 = self._fullscreen_panel:rect({
		name = "line_indicator_h1",
		w = 0,
		h = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1
	})
	local line_indicator_h2 = self._fullscreen_panel:rect({
		name = "line_indicator_h2",
		w = 0,
		h = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1
	})
	local line_indicator_v1 = self._fullscreen_panel:rect({
		name = "line_indicator_v1",
		h = 0,
		w = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1
	})
	local line_indicator_v2 = self._fullscreen_panel:rect({
		name = "line_indicator_v2",
		h = 0,
		w = 2,
		blend_mode = "add",
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines,
		alpha = 0.1
	})
	local fw = self._fullscreen_panel:w()
	local fh = self._fullscreen_panel:h()
	cross_indicator_h1:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
	cross_indicator_h2:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
	cross_indicator_v1:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
	cross_indicator_v2:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
	self:_create_locations()
	self._num_layer_jobs = 0
	local player_level = managers.experience:current_level()
	local positions_tweak_data = tweak_data.gui.crime_net.map_start_positions
	local start_position
	for _, position in ipairs(positions_tweak_data) do
		if player_level <= position.max_level then
			start_position = position
			break
		end
	end
	if start_position then
		self:_goto_map_position(start_position.x, start_position.y)
	end
	self._special_contracts_id = {}
	self:add_special_contracts(node:parameters().no_casino)
	managers.features:announce_feature("crimenet_welcome")
	if is_win32 and Steam:logged_on() and not managers.dlc:has_pd2_clan() and math.random() < 0.2 then
		managers.features:announce_feature("join_pd2_clan")
	end
	if managers.dlc:is_dlc_unlocked("gage_pack_jobs") then
		managers.features:announce_feature("dlc_gage_pack_jobs")
	end
	managers.features:announce_feature("crimenet_heat")
	managers.features:announce_feature("election_changes")
	return
end

function CrimeNetGui:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
	return w, h
end

function CrimeNetGui:make_color_text(text_object, color)
	local text = text_object:text()
	local text_dissected = utf8.characters(text)
	local idsp = Idstring("#")
	local start_ci = {}
	local end_ci = {}
	local first_ci = true
	for i, c in ipairs(text_dissected) do
		if Idstring(c) == idsp then
			local next_c = text_dissected[i + 1]
			if next_c and Idstring(next_c) == idsp then
				if first_ci then
					table.insert(start_ci, i)
				else
					table.insert(end_ci, i)
				end
				first_ci = not first_ci
			end
		end
	end
	if #start_ci ~= #end_ci then
	else
		for i = 1, #start_ci do
			start_ci[i] = start_ci[i] - ((i - 1) * 4 + 1)
			end_ci[i] = end_ci[i] - (i * 4 - 1)
		end
	end
	text = string.gsub(text, "##", "")
	text_object:set_text(text)
	text_object:clear_range_color(1, utf8.len(text))
	if #start_ci ~= #end_ci then
		Application:error("CrimeNetGui:make_color_text: Not even amount of ##'s in text", #start_ci, #end_ci)
	else
		for i = 1, #start_ci do
			text_object:set_range_color(start_ci[i], end_ci[i], color or tweak_data.screen_colors.resource)
		end
	end
end

function CrimeNetGui:_create_polylines()
	local regions = tweak_data.gui.crime_net.regions
	if alive(self._region_panel) then
		self._map_panel:remove(self._region_panel)
		self._region_panel = nil
	end
	self._region_panel = self._map_panel:panel({halign = "scale", valign = "scale"})
	self._region_locations = {}
	local xs, ys, num, vectors, my_polyline
	local tw = math.max(self._map_panel:child("map"):texture_width(), 1)
	local th = math.max(self._map_panel:child("map"):texture_height(), 1)
	local region_text_data, region_text, x, y
	for _, region in ipairs(regions) do
		xs = region[1]
		ys = region[2]
		num = math.min(#xs, #ys)
		vectors = {}
		my_polyline = self._region_panel:polyline({
			line_width = 2,
			alpha = 0.6,
			layer = 1,
			closed = region.closed,
			blend_mode = "add",
			halign = "scale",
			valign = "scale",
			color = tweak_data.screen_colors.crimenet_lines
		})
		for i = 1, num do
			table.insert(vectors, Vector3(xs[i] / tw * self._map_size_w * self._zoom, ys[i] / th * self._map_size_h * self._zoom, 0))
		end
		my_polyline:set_points(vectors)
		vectors = {}
		my_polyline = self._region_panel:polyline({
			line_width = 5,
			alpha = 0.2,
			layer = 1,
			closed = region.closed,
			blend_mode = "add",
			halign = "scale",
			valign = "scale",
			color = tweak_data.screen_colors.crimenet_lines
		})
		for i = 1, num do
			table.insert(vectors, Vector3(xs[i] / tw * self._map_size_w * self._zoom, ys[i] / th * self._map_size_h * self._zoom, 0))
		end
		my_polyline:set_points(vectors)
		region_text_data = region.text
		if region_text_data then
			x = region_text_data.x / tw * self._map_size_w * self._zoom
			y = region_text_data.y / th * self._map_size_h * self._zoom
			if region_text_data.title_id then
				region_text = self._region_panel:text({
					font = tweak_data.menu.pd2_large_font,
					font_size = tweak_data.menu.pd2_large_font_size,
					text = managers.localization:to_upper_text(region_text_data.title_id),
					layer = 1,
					alpha = 0.6,
					blend_mode = "add",
					halign = "scale",
					valign = "scale",
					rotation = 0
				})
				local _, _, w, h = region_text:text_rect()
				region_text:set_size(w, h)
				region_text:set_center(x, y)
				table.insert(self._region_locations, {
					object = region_text,
					size = region_text:font_size()
				})
			end
			if region_text_data.sub_id then
				region_text = self._region_panel:text({
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					text = managers.localization:to_upper_text(region_text_data.sub_id),
					align = "center",
					vertical = "center",
					layer = 1,
					alpha = 0.6,
					blend_mode = "add",
					halign = "scale",
					valign = "scale",
					rotation = 0
				})
				local _, _, w, h = region_text:text_rect()
				region_text:set_size(w, h)
				if region_text_data.title_id then
					region_text:set_position(self._region_locations[#self._region_locations].object:left(), self._region_locations[#self._region_locations].object:bottom() - 5)
				else
					region_text:set_center(x, y)
				end
				table.insert(self._region_locations, {
					object = region_text,
					size = region_text:font_size()
				})
			end
		end
	end
	if Application:production_build() and tweak_data.gui.crime_net.debug_options.regions then
		for _, data in ipairs(tweak_data.gui.crime_net.locations) do
			local location = data[1]
			if location and location.dots then
				for _, dot in ipairs(location.dots) do
					self._region_panel:rect({
						w = 1,
						h = 1,
						color = Color.red,
						x = dot[1] / tw * self._map_size_w * self._zoom,
						y = dot[2] / th * self._map_size_h * self._zoom,
						halign = "scale",
						valign = "scale",
						layer = 1000
					})
				end
			end
		end
	end
end

function CrimeNetGui:set_players_online(players)
	local players_string = managers.money:add_decimal_marks_to_string(string.format("%.3d", players))
	local num_players_text = self._panel:child("num_players_text")
	num_players_text:set_text(managers.localization:to_upper_text("cn_menu_num_players_online", {amount = players_string}))
	self:make_fine_text(num_players_text)
	self._panel:child("num_players_blur"):set_shape(num_players_text:shape())
end

function CrimeNetGui:_create_locations()
	self._locations = deep_clone(self._tweak_data.locations) or {}
	self:_create_polylines()
end

function CrimeNetGui:_add_location(contact, data)
	do return end
	self._locations[contact] = self._locations[contact] or {}
	table.insert(self._locations[contact], data)
end

function CrimeNetGui:_get_contact_locations()
	return self._locations[1]
end

function CrimeNetGui:_get_random_location()
	return self._pan_panel_job_border_x + math.random(self._map_size_w - 2 * self._pan_panel_job_border_x), self._pan_panel_job_border_y + math.random(self._map_size_h - 2 * self._pan_panel_job_border_y)
end

function CrimeNetGui:_get_job_location(data)
	local locations = self:_get_contact_locations()
	if locations and 0 < #locations then
		local found_point = false
		local x, y, randomized_location
		local break_limit = 100
		local dots = locations[1].dots
		local randomized_dot = math.random(#dots)
		local choosen_dot = randomized_dot
		randomized_location = dots[choosen_dot]
		while randomized_location[3] do
			choosen_dot = choosen_dot % #dots + 1
			randomized_location = dots[choosen_dot]
			if choosen_dot == randomized_dot then
				Application:error("[CrimeNetGui:_get_job_location] All spawning points are taken!")
				return self:_get_random_location()
			end
		end
		x = randomized_location[1]
		y = randomized_location[2]
		if x and y then
			local tw = math.max(self._map_panel:child("map"):texture_width(), 1)
			local th = math.max(self._map_panel:child("map"):texture_height(), 1)
			x = math.round(x / tw * self._map_size_w)
			y = math.round(y / th * self._map_size_h)
			return x, y, randomized_location
		end
	end
	return self:_get_random_location()
end

function CrimeNetGui:add_special_contracts(no_casino)
	for index, special_contract in ipairs(tweak_data.gui.crime_net.special_contracts) do
		local id = special_contract.id
		if id and not self._jobs[id] and (not special_contract.unlock or special_contract.unlock and managers.experience:current_level() >= tweak_data:get_value(special_contract.id, special_contract.unlock)) and (special_contract.id ~= "casino" or not no_casino) then
			local gui_data = self:_create_job_gui(special_contract, "special")
			gui_data.server = true
			gui_data.special_node = special_contract.menu_node
			gui_data.dlc = special_contract.dlc
			if special_contract.pulse then
				local animate_pulse = function(o)
					while true do
						over(1, function(p)
							o:set_alpha(math.sin(p * 180) * 0.4 + 0.2)
						end)
					end
				end
				gui_data.glow_panel:animate(animate_pulse)
				gui_data.pulse = special_contract.pulse and 21
			end
			self._jobs[id] = gui_data
		end
	end
end

function CrimeNetGui:add_preset_job(preset_id)
	self:remove_job(preset_id, true)
	local preset = managers.crimenet:preset(preset_id)
	local gui_data = self:_create_job_gui(preset, "preset")
	gui_data.preset_id = preset_id
	self._jobs[preset_id] = gui_data
end

function CrimeNetGui:add_server_job(data)
	local gui_data = self:_create_job_gui(data, "server")
	gui_data.server = true
	gui_data.host_name = data.host_name
	self._jobs[data.id] = gui_data
end

function CrimeNetGui:_create_job_gui(data, type, fixed_x, fixed_y, fixed_location)
	local level_id = data.level_id
	local level_data = tweak_data.levels[level_id]
	local narrative_data = data.job_id and tweak_data.narrative:job_data(data.job_id)
	local is_special = type == "special"
	local is_server = type == "server"
	local is_professional = narrative_data and narrative_data.professional
	local got_job = data.job_id and true or false
	local x = fixed_x
	local y = fixed_y
	local location = fixed_location
	if is_special then
		x = data.x
		y = data.y
		if x and y then
			local tw = math.max(self._map_panel:child("map"):texture_width(), 1)
			local th = math.max(self._map_panel:child("map"):texture_height(), 1)
			x = math.round(x / tw * self._map_size_w)
			y = math.round(y / th * self._map_size_h)
		end
	end
	if not x and not y then
		x, y, location = self:_get_job_location(data)
	end
	if location and location[3] then
		Application:error("[CrimeNetGui:_create_job_gui] Location already taken!", x, y)
	end
	local color = Color.white
	local friend_color = tweak_data.screen_colors.friend_color
	local regular_color = tweak_data.screen_colors.regular_color
	local pro_color = tweak_data.screen_colors.pro_color
	local side_panel = self._pan_panel:panel({layer = 26, alpha = 0})
	local heat_glow
	local stars_panel = side_panel:panel({
		name = "stars_panel",
		layer = -1,
		visible = true,
		w = 100
	})
	local num_stars = 0
	local star_size = 16
	local job_num = 0
	local job_cash = 0
	local difficulty_name = side_panel:text({
		name = "difficulty_name",
		text = "",
		vertical = "center",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = color,
		blend_mode = "add",
		layer = 0
	})
	local heat_name = side_panel:text({
		name = "heat_name",
		text = "",
		vertical = "center",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = color,
		blend_mode = "add",
		layer = 0
	})
	local got_heat = false
	local range_colors = {}
	local text_string = managers.localization:to_upper_text("menu_exp_short")
	local mul_to_procent_string = function(multiplier)
		local pro = math.round(multiplier * 100)
		local procent_string
		if pro == 0 and multiplier ~= 0 then
			procent_string = string.format("%0.2f", math.abs(multiplier * 100))
		else
			procent_string = tostring(math.abs(pro))
		end
		return (multiplier < 0 and " -" or " +") .. procent_string .. "%"
	end
	local got_heat_text = false
	local has_ghost_bonus = managers.job:has_ghost_bonus()
	if has_ghost_bonus then
		repeat
			do
				local ghost_bonus_mul = managers.job:get_ghost_bonus()
				local job_ghost_string = mul_to_procent_string(ghost_bonus_mul)
				local s = utf8.len(text_string)
				text_string = text_string .. job_ghost_string
				table.insert(range_colors, {
					s,
					utf8.len(text_string),
					tweak_data.screen_colors.ghost_color
				})
				got_heat_text = true
			end
			do break end -- pseudo-goto
			local skill_bonus = managers.player:get_skill_exp_multiplier()
			skill_bonus = skill_bonus - 1
			if 0 < skill_bonus then
				local s = utf8.len(text_string)
				local skill_string = mul_to_procent_string(skill_bonus)
				text_string = text_string .. skill_string
				table.insert(range_colors, {
					s,
					utf8.len(text_string),
					tweak_data.screen_colors.skill_color
				})
				got_heat_text = true
			end
			local infamy_bonus = managers.player:get_infamy_exp_multiplier()
			infamy_bonus = infamy_bonus - 1
			if 0 < infamy_bonus then
				local s = utf8.len(text_string)
				local infamy_string = mul_to_procent_string(infamy_bonus)
				text_string = text_string .. infamy_string
				table.insert(range_colors, {
					s,
					utf8.len(text_string),
					tweak_data.lootdrop.global_values.infamy.color
				})
				got_heat_text = true
			end
			local limited_bonus = tweak_data:get_value("experience_manager", "limited_bonus_multiplier") or 1
			limited_bonus = limited_bonus - 1
			if 0 < limited_bonus then
				local s = utf8.len(text_string)
				local limited_string = mul_to_procent_string(limited_bonus)
				text_string = text_string .. limited_string
				table.insert(range_colors, {
					s,
					utf8.len(text_string),
					tweak_data.screen_colors.button_stage_2
				})
				got_heat_text = true
			end
		until true
	end
	local job_heat = managers.job:get_job_heat(data.job_id) or 0
	local job_heat_mul = managers.job:heat_to_experience_multiplier(job_heat) - 1
	if data.job_id then
		local x = 0
		local y = 0
		local job_stars = math.ceil(tweak_data.narrative:job_data(data.job_id).jc / 10)
		local difficulty_stars = data.difficulty_id - 2
		local job_and_difficulty_stars = job_stars + difficulty_stars
		local start_difficulty = 1
		local num_difficulties = Global.SKIP_OVERKILL_290 and 3 or 4
		for i = start_difficulty, num_difficulties do
			stars_panel:bitmap({
				texture = "guis/textures/pd2/cn_miniskull",
				x = x,
				y = y,
				w = 12,
				h = 16,
				texture_rect = {
					0,
					0,
					12,
					16
				},
				alpha = i > difficulty_stars and 0.5 or 1,
				blend_mode = i > difficulty_stars and "normal" or "add",
				layer = 0,
				color = i > difficulty_stars and Color.black or tweak_data.screen_colors.risk
			})
			x = x + 11
			num_stars = num_stars + 1
		end
		job_num = #tweak_data.narrative:job_chain(data.job_id)
		local total_payout, stage_payout_table, job_payout_table = managers.money:get_contract_money_by_stars(job_stars, difficulty_stars, job_num, data.job_id)
		job_cash = managers.experience:cash_string(math.round(total_payout))
		local difficulty_string = managers.localization:to_upper_text(tweak_data.difficulty_name_ids[tweak_data.difficulties[data.difficulty_id]])
		difficulty_name:set_text(difficulty_string)
		difficulty_name:set_color(0 < difficulty_stars and tweak_data.screen_colors.risk or tweak_data.screen_colors.text)
		local heat_alpha = math.abs(job_heat) / 100
		local heat_size = 1
		local heat_color = managers.job:get_job_heat_color(data.job_id)
		heat_glow = self._pan_panel:bitmap({
			texture = "guis/textures/pd2/hot_cold_glow",
			layer = 11,
			w = 256 * heat_size,
			h = 256 * heat_size,
			blend_mode = "add",
			color = heat_color,
			alpha = 0
		})
		if job_heat_mul ~= 0 then
			local s = utf8.len(text_string)
			local heat_string = mul_to_procent_string(job_heat_mul)
			text_string = text_string .. heat_string
			table.insert(range_colors, {
				s,
				utf8.len(text_string),
				heat_color
			})
			got_heat = true
			got_heat_text = true
			heat_glow:set_alpha(heat_alpha)
		end
	end
	heat_name:set_text(text_string)
	for i, range in ipairs(range_colors) do
		if i == 1 then
			local s, e, c = unpack(range)
			heat_name:set_range_color(0, e, c)
		else
			heat_name:set_range_color(unpack(range))
		end
	end
	local job_tweak = tweak_data.narrative:job_data(data.job_id)
	local host_string = data.host_name or is_professional and managers.localization:to_upper_text("cn_menu_pro_job") or " "
	local job_string = data.job_id and managers.localization:to_upper_text(job_tweak.name_id) or data.level_name or "NO JOB"
	local contact_string = utf8.to_upper(data.job_id and managers.localization:text(tweak_data.narrative.contacts[job_tweak.contact].name_id)) or "BAIN"
	contact_string = contact_string .. ": "
	local info_string = managers.localization:to_upper_text("cn_menu_contract_short_" .. (1 < job_num and "plural" or "singular"), {days = job_num, money = job_cash})
	info_string = info_string .. (data.state_name and " / " .. data.state_name or "")
	if is_special then
		job_string = data.name_id and managers.localization:to_upper_text(data.name_id) or ""
		info_string = data.desc_id and managers.localization:to_upper_text(data.desc_id) or ""
	end
	local host_name = side_panel:text({
		name = "host_name",
		text = host_string,
		vertical = "center",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = data.is_friend and friend_color or is_server and regular_color or pro_color,
		blend_mode = "add",
		layer = 0
	})
	local job_name = side_panel:text({
		name = "job_name",
		text = job_string,
		vertical = "center",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = color,
		blend_mode = "add",
		layer = 0
	})
	local contact_name = side_panel:text({
		name = "contact_name",
		text = contact_string,
		vertical = "center",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = color,
		blend_mode = "add",
		layer = 0
	})
	local info_name = side_panel:text({
		name = "info_name",
		text = info_string,
		vertical = "center",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = color,
		blend_mode = "add",
		layer = 0
	})
	stars_panel:set_w(star_size * math.min(11, #stars_panel:children()))
	stars_panel:set_h(star_size)
	local focus = self._pan_panel:bitmap({
		name = "focus",
		texture = "guis/textures/crimenet_map_circle",
		layer = 10,
		color = color:with_alpha(0.6),
		blend_mode = "add"
	})
	do
		local _, _, w, h = host_name:text_rect()
		host_name:set_size(w, h - 4)
		host_name:set_position(0, 0)
		if not is_server then
		end
	end
	do
		local _, _, w, h = job_name:text_rect()
		job_name:set_size(w, h - 4)
		job_name:set_position(0, host_name:bottom())
	end
	do
		local _, _, w, h = contact_name:text_rect()
		contact_name:set_size(w, h - 4)
		contact_name:set_top(job_name:top())
		contact_name:set_right(0)
	end
	do
		local _, _, w, h = info_name:text_rect()
		info_name:set_size(w, h - 4)
		info_name:set_top(contact_name:bottom())
		info_name:set_right(0)
	end
	do
		local _, _, w, h = difficulty_name:text_rect()
		difficulty_name:set_size(w, h - 4)
		difficulty_name:set_top(info_name:bottom())
		difficulty_name:set_right(0)
	end
	do
		local _, _, w, h = heat_name:text_rect()
		heat_name:set_size(w, h - 4)
		heat_name:set_top(difficulty_name:bottom())
		heat_name:set_right(0)
	end
	if not got_heat_text then
		heat_name:set_text(" ")
		heat_name:set_w(1, 0)
		heat_name:set_position(0, host_name:bottom())
	end
	if is_special then
		contact_name:set_text(" ")
		contact_name:set_size(0, 0)
		contact_name:set_position(0, host_name:bottom())
		difficulty_name:set_text(" ")
		difficulty_name:set_w(0, 0)
		difficulty_name:set_position(0, host_name:bottom())
		heat_name:set_text(" ")
		heat_name:set_w(0, 0)
		heat_name:set_position(0, host_name:bottom())
	elseif not got_job then
		job_name:set_text(data.state_name or managers.localization:to_upper_text("menu_lobby_server_state_in_lobby"))
		local _, _, w, h = job_name:text_rect()
		job_name:set_size(w, h)
		job_name:set_position(0, host_name:bottom())
		contact_name:set_text(" ")
		contact_name:set_w(0, 0)
		contact_name:set_position(0, host_name:bottom())
		info_name:set_text(" ")
		info_name:set_size(0, 0)
		info_name:set_position(0, host_name:bottom())
		difficulty_name:set_text(" ")
		difficulty_name:set_w(0, 0)
		difficulty_name:set_position(0, host_name:bottom())
		heat_name:set_text(" ")
		heat_name:set_w(0, 0)
		heat_name:set_position(0, host_name:bottom())
	end
	stars_panel:set_position(0, job_name:bottom())
	side_panel:set_h(math.round(host_name:h() + job_name:h() + stars_panel:h()))
	side_panel:set_w(300)
	self._num_layer_jobs = (self._num_layer_jobs + 1) % 1
	local marker_panel = self._pan_panel:panel({
		w = 36,
		h = 66,
		layer = 11 + self._num_layer_jobs * 3,
		alpha = 0
	})
	local select_panel = marker_panel:panel({
		name = "select_panel",
		w = 36,
		h = 38,
		x = -2,
		y = 0
	})
	local glow_panel = self._pan_panel:panel({
		w = 960,
		h = 192,
		layer = 10,
		alpha = 0
	})
	local glow_center = glow_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_marker_glow",
		w = 192,
		h = 192,
		blend_mode = "add",
		alpha = 0.55,
		color = data.pulse_color or is_professional and pro_color or regular_color
	})
	local glow_stretch = glow_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_marker_glow",
		w = 960,
		h = 75,
		blend_mode = "add",
		alpha = 0.55,
		color = data.pulse_color or is_professional and pro_color or regular_color
	})
	local glow_center_dark = glow_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_marker_glow",
		w = 175,
		h = 175,
		blend_mode = "normal",
		alpha = 0.7,
		color = Color.black,
		layer = -1
	})
	local glow_stretch_dark = glow_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_marker_glow",
		w = 990,
		h = 75,
		blend_mode = "normal",
		alpha = 0.75,
		color = Color.black,
		layer = -1
	})
	glow_center:set_center(glow_panel:w() / 2, glow_panel:h() / 2)
	glow_stretch:set_center(glow_panel:w() / 2, glow_panel:h() / 2)
	glow_center_dark:set_center(glow_panel:w() / 2, glow_panel:h() / 2)
	glow_stretch_dark:set_center(glow_panel:w() / 2, glow_panel:h() / 2)
	local marker_dot_texture = (is_special and data.icon or "guis/textures/pd2/crimenet_marker_" .. (is_server and "join" or "host")) .. (is_professional and "_pro" or "")
	local marker_dot = marker_panel:bitmap({
		name = "marker_dot",
		texture = marker_dot_texture,
		color = color,
		w = 32,
		h = 64,
		x = 2,
		y = 2,
		layer = 1
	})
	if is_professional then
		marker_panel:bitmap({
			name = "marker_pro_outline",
			texture = "guis/textures/pd2/crimenet_marker_pro_outline",
			w = 64,
			h = 64,
			x = 0,
			y = 0,
			rotation = 0,
			layer = 0,
			alpha = 1,
			blend_mode = "add"
		})
	end
	local timer_rect, peers_panel
	local icon_panel = self._pan_panel:panel({
		layer = 26,
		alpha = 1,
		h = 64,
		w = 18
	})
	if data.job_id and managers.job:is_job_ghostable(data.job_id) then
		local ghost_icon = icon_panel:bitmap({
			name = "ghost_icon",
			texture = "guis/textures/pd2/cn_minighost",
			blend_mode = "add",
			color = tweak_data.screen_colors.ghost_color
		})
		local y = 0
		for i = 1, #icon_panel:children() - 1 do
			y = math.max(y, icon_panel:children()[i]:bottom())
		end
		ghost_icon:set_y(y)
	end
	if is_server then
		peers_panel = self._pan_panel:panel({
			layer = 11 + self._num_layer_jobs * 3,
			visible = true,
			w = 32,
			h = 62,
			alpha = 0
		})
		local cx = 0
		local cy = 0
		for i = 1, 4 do
			cx = 3 + 6 * (i - 1)
			cy = 8
			local player_marker = peers_panel:bitmap({
				name = tostring(i),
				texture = "guis/textures/pd2/crimenet_marker_peerflag",
				w = 8,
				h = 16,
				color = color,
				layer = 2,
				blend_mode = "normal",
				visible = i <= data.num_plrs
			})
			player_marker:set_position(cx, cy)
		end
		local kick_icon = icon_panel:bitmap({
			name = "kick_icon",
			texture = "guis/textures/pd2/cn_kick_marker",
			blend_mode = "add",
			alpha = 0
		})
		local y = 0
		for i = 1, #icon_panel:children() - 1 do
			y = math.max(y, icon_panel:children()[i]:bottom())
		end
		kick_icon:set_y(y)
	elseif not is_special then
		timer_rect = marker_panel:bitmap({
			name = "timer_rect",
			texture = "guis/textures/pd2/crimenet_timer",
			color = Color.white,
			w = 32,
			h = 32,
			x = 1,
			y = 2,
			render_template = "VertexColorTexturedRadial",
			layer = 2
		})
		timer_rect:set_texture_rect(32, 0, -32, 32)
	end
	marker_panel:set_center(x * self._zoom, y * self._zoom)
	focus:set_center(marker_panel:center())
	glow_panel:set_world_center(marker_panel:child("select_panel"):world_center())
	if heat_glow then
		heat_glow:set_world_center(marker_panel:child("select_panel"):world_center())
	end
	local num_containers = managers.job:get_num_containers()
	local middle_container = math.ceil(num_containers / 2)
	local job_container_index = managers.job:get_job_container_index(data.job_id) or middle_container
	local diff_containers = job_container_index - middle_container
	if diff_containers == 0 then
		if job_heat_mul < 0 then
			diff_containers = -1
		elseif 0 < job_heat_mul then
			diff_containers = 1
		end
	end
	local container_panel
	if diff_containers ~= 0 and job_heat_mul ~= 0 then
		container_panel = self._pan_panel:panel({
			layer = 11 + self._num_layer_jobs * 3,
			alpha = 0
		})
		container_panel:set_w(math.abs(num_containers - middle_container) * 10 + 6)
		container_panel:set_h(8)
		container_panel:set_center_x(marker_panel:center_x())
		container_panel:set_bottom(marker_panel:top())
		container_panel:set_x(math.round(container_panel:x()))
		local texture = "guis/textures/pd2/blackmarket/stat_plusminus"
		local texture_rect = 0 < diff_containers and {
			0,
			0,
			8,
			8
		} or {
			8,
			0,
			8,
			8
		}
		for i = 1, math.abs(diff_containers) do
			container_panel:bitmap({
				texture = texture,
				texture_rect = texture_rect,
				x = (i - 1) * 10 + 3
			})
		end
	end
	local text_on_right = x < self._map_size_w - 200
	if text_on_right then
		side_panel:set_left(marker_panel:right())
	else
		job_name:set_text(contact_name:text() .. job_name:text())
		contact_name:set_text("")
		contact_name:set_w(0)
		local _, _, w, h = job_name:text_rect()
		job_name:set_size(w, h)
		host_name:set_right(side_panel:w())
		job_name:set_right(side_panel:w())
		contact_name:set_left(side_panel:w())
		info_name:set_left(side_panel:w())
		difficulty_name:set_left(side_panel:w())
		heat_name:set_left(side_panel:w())
		stars_panel:set_right(side_panel:w())
		side_panel:set_right(marker_panel:left())
	end
	side_panel:set_top(marker_panel:top() - job_name:top() + 1)
	if icon_panel then
		if text_on_right then
			icon_panel:set_right(marker_panel:left() + 2)
		else
			icon_panel:set_left(marker_panel:right() - 2)
		end
		icon_panel:set_top(math.round(marker_panel:top() + 1))
	end
	if peers_panel then
		peers_panel:set_center_x(marker_panel:center_x())
		peers_panel:set_center_y(marker_panel:center_y())
	end
	if not Application:production_build() or peers_panel then
	end
	local callout
	if narrative_data and narrative_data.crimenet_callouts and 0 < #narrative_data.crimenet_callouts then
		local variant = math.random(#narrative_data.crimenet_callouts)
		callout = narrative_data.crimenet_callouts[variant]
	end
	if location then
		location[3] = true
	end
	managers.menu:post_event("job_appear")
	local job = {
		room_id = data.room_id,
		job_id = data.job_id,
		level_id = level_id,
		level_data = level_data,
		marker_panel = marker_panel,
		peers_panel = peers_panel,
		kick_option = data.kick_option,
		container_panel = container_panel,
		timer_rect = timer_rect,
		side_panel = side_panel,
		icon_panel = icon_panel,
		focus = focus,
		difficulty = data.difficulty,
		difficulty_id = data.difficulty_id,
		num_plrs = data.num_plrs,
		job_x = x,
		job_y = y,
		state = data.state,
		layer = 11 + self._num_layer_jobs * 3,
		glow_panel = glow_panel,
		callout = callout,
		text_on_right = text_on_right,
		location = location,
		heat_glow = heat_glow
	}
	self:update_job_gui(job, 3)
	return job
end

function CrimeNetGui:remove_job(id, instant)
	local data = self._jobs[id]
	if not data then
		if self._deleting_jobs[id] then
			self._deleting_jobs[id].marker_panel:stop()
			self:_remove_gui_job(self._deleting_jobs[id])
			self._deleting_jobs[id] = nil
		end
		return false
	end
	if not alive(self._panel) then
		return
	end
	if instant then
		self:_remove_gui_job(data)
	elseif data.server then
		repeat
			do break end -- pseudo-goto
			self:_remove_gui_job(data)
		until true
	else
		self._deleting_jobs[id] = data
		data.marker_panel:animate(callback(self, self, "_anim_remove_job_gui"), id)
	end
	self._jobs[id] = nil
	return true
end

function CrimeNetGui:_anim_remove_job_gui(o, id)
	local data = self._deleting_jobs[id]
	local side_alpha = data.side_panel:alpha()
	local glow_alpha = data.glow_panel:alpha()
	local focus_alpha = data.focus:alpha()
	local heat_alpha = data.heat_glow and data.heat_glow:alpha()
	local icon_alpha = data.icon_panel and data.icon_panel:alpha()
	local peers_alpha = data.peers_panel and data.peers_panel:alpha()
	local container_alpha = data.container_panel and data.container_panel:alpha()
	local inv_p
	data.glow_panel:stop()
	over(0.2, function(p)
		inv_p = 1 - p
		data.glow_panel:set_alpha(glow_alpha * inv_p)
		data.side_panel:set_alpha(side_alpha * inv_p)
		data.focus:set_alpha(focus_alpha * inv_p)
		if data.heat_glow then
			data.heat_glow:set_alpha(heat_alpha * inv_p)
		end
		if data.icon_panel then
			data.icon_panel:set_alpha(icon_alpha * inv_p)
		end
		if data.peers_panel then
			data.peers_panel:set_alpha(peers_alpha * inv_p)
		end
		if data.container_panel then
			data.container_panel:set_alpha(container_alpha * inv_p)
		end
	end)
	local x, y = data.marker_panel:center()
	local w, h = data.marker_panel:size()
	for i, child in ipairs(data.marker_panel:children()) do
		child:set_halign("scale")
		child:set_valign("scale")
	end
	over(0.1, function(p)
		inv_p = 1 - p
		x, y = data.marker_panel:center()
		data.marker_panel:set_size((w - 5) * inv_p + 5, h)
		data.marker_panel:set_center(x, y)
	end)
	over(0.1, function(p)
		inv_p = 1 - p
		x, y = data.marker_panel:center()
		data.marker_panel:set_size(5 * inv_p, h * inv_p)
		data.marker_panel:set_center(x, y)
	end)
	self._deleting_jobs[id] = nil
	self:_remove_gui_job(data)
end

function CrimeNetGui:_remove_gui_job(data)
	self._pan_panel:remove(data.marker_panel)
	self._pan_panel:remove(data.glow_panel)
	if data.heat_glow then
		self._pan_panel:remove(data.heat_glow)
	end
	if data.container_panel then
		self._pan_panel:remove(data.container_panel)
	end
	self._pan_panel:remove(data.side_panel)
	self._pan_panel:remove(data.focus)
	if data.icon_panel then
		self._pan_panel:remove(data.icon_panel)
	end
	if data.location then
		data.location[3] = nil
	end
	if data.peers_panel then
		self._pan_panel:remove(data.peers_panel)
	end
end

function CrimeNetGui:update_server_job(data, i)
	local job_index = data.id or i
	local job = self._jobs[job_index]
	if not job then
		return
	end
	local level_id = data.level_id
	local level_data = tweak_data.levels[level_id]
	local updated_room = self:_update_job_variable(job_index, "room_id", data.room_id)
	local updated_job = self:_update_job_variable(job_index, "job_id", data.job_id)
	local updated_level_id = self:_update_job_variable(job_index, "level_id", level_id)
	local updated_level_data = self:_update_job_variable(job_index, "level_data", level_data)
	local updated_difficulty = self:_update_job_variable(job_index, "difficulty", data.difficulty)
	local updated_difficulty_id = self:_update_job_variable(job_index, "difficulty_id", data.difficulty_id)
	local updated_state = self:_update_job_variable(job_index, "state", data.state)
	local recreate_job = updated_room or updated_job or updated_level_id or updated_level_data or updated_difficulty or updated_difficulty_id or updated_state
	self:_update_job_variable(job_index, "state_name", data.state_name)
	if self:_update_job_variable(job_index, "num_plrs", data.num_plrs) and job.peers_panel then
		for i, peer_icon in ipairs(job.peers_panel:children()) do
			peer_icon:set_visible(i <= job.num_plrs)
		end
	end
	if recreate_job then
		print("[CrimeNetGui] update_server_job", "job_index", job_index)
		local is_server = job.server
		local x = job.job_x
		local y = job.job_y
		local location = job.location
		self:remove_job(job_index, true)
		local gui_data = self:_create_job_gui(data, is_server and "server" or "contract", x, y, location)
		gui_data.server = is_server
		self._jobs[job_index] = gui_data
	end
end

function CrimeNetGui:_update_job_variable(id, variable, value)
	local data = self._jobs[id]
	if not data then
		return
	end
	local updated = data[variable] ~= value
	data[variable] = value
	return updated
end

function CrimeNetGui:update_job(id, t, dt)
	local data = self._jobs[id]
	if not data then
		return
	end
	if data.pulse then
		data.pulse = math.step(data.pulse, 0, dt * 2)
		if data.pulse < 1 then
			data.pulse = nil
			data.glow_panel:stop()
		end
	end
	data.focus:set_alpha(data.focus:alpha() - dt / 2)
	data.focus:set_size(data.focus:w() + dt * 200, data.focus:h() + dt * 200)
	data.focus:set_center(data.marker_panel:center())
end

function CrimeNetGui:feed_timer(id, t, max_t)
	local data = self._jobs[id]
	if not data then
		return
	end
	if not data.timer_rect then
		return
	end
	data.timer_rect:set_color(Color(t / max_t, 1, 1))
	if max_t - t < 4 then
	else
		if t < 4 then
		else
		end
	end
end

function CrimeNetGui:update(t, dt)
	if Global.debug_cn_locations and Application:production_build() and is_win32 then
		self._prev_loc = self._prev_loc or {}
		for i, d in pairs(self._locations[1][1].dots) do
			if d[3] and not self._prev_loc[i] then
				Application:debug("Location taken:", i, d[1], d[2])
			elseif not d[3] and self._prev_loc[i] then
				Application:debug("Location removed:", i)
			end
			self._prev_loc[i] = d[3]
		end
	end
	self._rasteroverlay:set_texture_rect(0, -math.mod(Application:time() * 5, 32), 32, 640)
	if self._released_map then
		self._released_map.dx = math.lerp(self._released_map.dx, 0, dt * 2)
		self._released_map.dy = math.lerp(self._released_map.dy, 0, dt * 2)
		self:_set_map_position(self._released_map.dx, self._released_map.dy)
		if self._map_panel:x() >= -5 or -5 <= self._fullscreen_panel:w() - self._map_panel:right() then
			self._released_map.dx = 0
		end
		if -5 <= self._map_panel:y() or -5 <= self._fullscreen_panel:h() - self._map_panel:bottom() then
			self._released_map.dy = 0
		end
		self._released_map.t = self._released_map.t - dt
		if 0 > self._released_map.t then
			self._released_map = nil
		end
	end
	if not self._grabbed_map then
		local speed = 5
		if self._map_panel:x() > -self:_get_pan_panel_border() then
			local mx = math.lerp(0, -self:_get_pan_panel_border() - self._map_panel:x(), dt * speed)
			self:_set_map_position(mx, 0)
		end
		if self._fullscreen_panel:w() - self._map_panel:right() > -self:_get_pan_panel_border() then
			local mx = math.lerp(0, self:_get_pan_panel_border() - (self._map_panel:right() - self._fullscreen_panel:w()), dt * speed)
			self:_set_map_position(mx, 0)
		end
		if self._map_panel:y() > -self:_get_pan_panel_border() then
			local my = math.lerp(0, -self:_get_pan_panel_border() - self._map_panel:y(), dt * speed)
			self:_set_map_position(0, my)
		end
		if self._fullscreen_panel:h() - self._map_panel:bottom() > -self:_get_pan_panel_border() then
			local my = math.lerp(0, self:_get_pan_panel_border() - (self._map_panel:bottom() - self._fullscreen_panel:h()), dt * speed)
			self:_set_map_position(0, my)
		end
	end
	if not managers.menu:is_pc_controller() and managers.mouse_pointer:mouse_move_x() == 0 and managers.mouse_pointer:mouse_move_y() == 0 then
		local closest_job
		local closest_dist = 100000000
		local closest_job_x, closest_job_y = 0, 0
		local mouse_pos_x, mouse_pos_y = managers.mouse_pointer:modified_mouse_pos()
		local job_x, job_y
		local dist = 0
		local x, y
		for id, job in pairs(self._jobs) do
			job_x, job_y = job.marker_panel:child("select_panel"):world_center()
			x = job_x - mouse_pos_x
			y = job_y - mouse_pos_y
			dist = x * x + y * y
			if closest_dist > dist then
				closest_job = job
				closest_dist = dist
				closest_job_x = job_x
				closest_job_y = job_y
			end
		end
		if closest_job then
			closest_dist = math.sqrt(closest_dist)
			if closest_dist < self._tweak_data.controller.snap_distance then
				managers.mouse_pointer:force_move_mouse_pointer(math.lerp(mouse_pos_x, closest_job_x, dt * self._tweak_data.controller.snap_speed) - mouse_pos_x, math.lerp(mouse_pos_y, closest_job_y, dt * self._tweak_data.controller.snap_speed) - mouse_pos_y)
			end
		end
	end
	for index, special_contract in ipairs(tweak_data.gui.crime_net.special_contracts) do
		if self._jobs[special_contract.id] then
			self:update_job(special_contract.id, t, dt)
		end
	end
end

function CrimeNetGui:feed_server_timer(id, t)
	local data = self._jobs[id]
	if not data then
		return
	end
	if not data.timer_rect then
		return
	end
	if t < 4 then
		data.timer_rect:set_visible(true)
		data.timer_rect:set_color(Color(math.sin(t * 750), 1, 1))
	else
		data.timer_rect:set_visible(false)
	end
end

function CrimeNetGui:toggle_legend()
	managers.menu_component:post_event("menu_enter")
	self._panel:child("legend_panel"):set_visible(not self._panel:child("legend_panel"):visible())
	self._panel:child("legends_button"):set_text(managers.localization:to_upper_text(self._panel:child("legend_panel"):visible() and "menu_cn_legend_hide" or "menu_cn_legend_show", {
		BTN_X = managers.localization:btn_macro("menu_toggle_legends")
	}))
	self:make_fine_text(self._panel:child("legends_button"))
	self._panel:child("legends_button_blur"):set_shape(self._panel:child("legends_button"):shape())
end

function CrimeNetGui:mouse_button_click(button)
	return button == Idstring("0")
end

function CrimeNetGui:button_wheel_scroll_up(button)
	return button == Idstring("mouse wheel up")
end

function CrimeNetGui:button_wheel_scroll_down(button)
	return button == Idstring("mouse wheel down")
end

function CrimeNetGui:confirm_pressed()
	if not self._crimenet_enabled then
		return false
	end
	return self:check_job_pressed(managers.mouse_pointer:modified_mouse_pos())
end

function CrimeNetGui:special_btn_pressed(button)
	if not self._crimenet_enabled then
		return false
	end
	if button == Idstring("menu_toggle_legends") then
		self:toggle_legend()
		return true
	end
	if self._panel:child("filter_button") and button == Idstring("menu_toggle_filters") then
		managers.menu_component:post_event("menu_enter")
		if is_x360 then
			XboxLive:show_friends_ui(managers.user:get_platform_id())
		else
			managers.menu:open_node("crimenet_filters", {})
		end
		return true
	end
	return false
end

function CrimeNetGui:previous_page()
	if not self._crimenet_enabled then
		return
	end
	self:_set_zoom("out", managers.mouse_pointer:modified_mouse_pos())
	return true
end

function CrimeNetGui:next_page()
	if not self._crimenet_enabled then
		return
	end
	self:_set_zoom("in", managers.mouse_pointer:modified_mouse_pos())
	return true
end

function CrimeNetGui:input_focus()
	return self._crimenet_enabled and 1
end

function CrimeNetGui:check_job_mouse_over(x, y)
end

function CrimeNetGui:check_job_pressed(x, y)
	for id, job in pairs(self._jobs) do
		if job.mouse_over == 1 then
			job.expanded = not job.expanded
			local data = {
				difficulty = job.difficulty,
				difficulty_id = job.difficulty_id,
				job_id = job.job_id,
				level_id = job.level_id,
				id = id,
				room_id = job.room_id,
				server = job.server or false,
				num_plrs = job.num_plrs or 0,
				state = job.state,
				host_name = job.host_name,
				special_node = job.special_node,
				dlc = job.dlc
			}
			managers.menu_component:post_event("menu_enter")
			if not data.dlc or managers.dlc:is_dlc_unlocked(data.dlc) then
				local node = job.special_node or Global.game_settings.single_player and "crimenet_contract_singleplayer" or job.server and "crimenet_contract_join" or "crimenet_contract_host"
				managers.menu:open_node(node, {data})
			elseif is_win32 then
				local dlc_data = Global.dlc_manager.all_dlc_data[data.dlc]
				local app_id = dlc_data and dlc_data.app_id
				if app_id then
					Steam:overlay_activate("store", app_id)
				end
			end
			if job.expanded then
				for id2, job2 in pairs(self._jobs) do
					if job2 ~= job then
						job2.expanded = false
					end
				end
			end
			return true
		end
	end
end

function CrimeNetGui:mouse_pressed(o, button, x, y)
	if not self._crimenet_enabled then
		return
	end
	if self:mouse_button_click(button) then
		if self._panel:child("back_button"):inside(x, y) then
			managers.menu:back()
			return
		end
		if self._panel:child("legends_button"):inside(x, y) then
			self:toggle_legend()
			return
		end
		if self._panel:child("filter_button") and self._panel:child("filter_button"):inside(x, y) then
			managers.menu_component:post_event("menu_enter")
			managers.menu:open_node("crimenet_filters", {})
			return
		end
		if self:check_job_pressed(x, y) then
			return true
		end
		if self._panel:inside(x, y) then
			self._released_map = nil
			self._grabbed_map = {
				x = x,
				y = y,
				dirs = {}
			}
		end
	elseif self:button_wheel_scroll_down(button) then
		if self._one_scroll_out_delay then
			self._one_scroll_out_delay = nil
		end
		self:_set_zoom("out", x, y)
		return true
	elseif self:button_wheel_scroll_up(button) then
		if self._one_scroll_in_delay then
			self._one_scroll_in_delay = nil
		end
		self:_set_zoom("in", x, y)
		return true
	end
	return true
end

function CrimeNetGui:start_job()
	for id, job in pairs(self._jobs) do
		if job.expanded then
			if job.preset_id then
				MenuCallbackHandler:start_job(job)
				self:remove_job(job.preset_id)
				return true
			else
				print("Is a server, don't want to join", id, job.side_panel:child("host_name"):text() == "WWWWWWWWWWWW\194\181QQW")
				managers.network.matchmake:join_server_with_check(id)
				return
			end
		end
	end
end

function CrimeNetGui:mouse_released(o, button, x, y)
	if not self._crimenet_enabled then
		return
	end
	if not self:mouse_button_click(button) then
		return
	end
	if self._grabbed_map and #self._grabbed_map.dirs > 0 then
		local dx, dy = 0, 0
		for _, values in ipairs(self._grabbed_map.dirs) do
			dx = dx + values[1]
			dy = dy + values[2]
		end
		dx = dx / #self._grabbed_map.dirs
		dy = dy / #self._grabbed_map.dirs
		self._released_map = {
			t = 2,
			dx = dx,
			dy = dy
		}
		self._grabbed_map = nil
	end
end

function CrimeNetGui:_get_pan_panel_border()
	return self._pan_panel_border * self._zoom
end

function CrimeNetGui:_set_map_position(mx, my)
	local x = self._map_x + mx
	local y = self._map_y + my
	self._pan_panel:set_position(x, y)
	if self._pan_panel:left() > 0 then
		self._pan_panel:set_left(0)
	end
	if self._pan_panel:right() < self._fullscreen_panel:w() then
		self._pan_panel:set_right(self._fullscreen_panel:w())
	end
	if 0 < self._pan_panel:top() then
		self._pan_panel:set_top(0)
	end
	if self._pan_panel:bottom() < self._fullscreen_panel:h() then
		self._pan_panel:set_bottom(self._fullscreen_panel:h())
	end
	self._map_x, self._map_y = self._pan_panel:position()
	self._pan_panel:set_position(math.round(self._map_x), math.round(self._map_y))
	x, y = self._map_x, self._map_y
	self._map_panel:set_shape(self._pan_panel:shape())
	self._pan_panel:set_position(managers.gui_data:full_16_9_to_safe(x, y))
	local full_16_9 = managers.gui_data:full_16_9_size()
	local w_ratio = self._fullscreen_panel:w() / self._map_panel:w()
	local h_ratio = self._fullscreen_panel:h() / self._map_panel:h()
	local panel_x = -(self._map_panel:x() / self._fullscreen_panel:w()) * w_ratio
	local panel_y = -(self._map_panel:y() / self._fullscreen_panel:h()) * h_ratio
	local cross_indicator_h1 = self._fullscreen_panel:child("cross_indicator_h1")
	local cross_indicator_h2 = self._fullscreen_panel:child("cross_indicator_h2")
	local cross_indicator_v1 = self._fullscreen_panel:child("cross_indicator_v1")
	local cross_indicator_v2 = self._fullscreen_panel:child("cross_indicator_v2")
	local line_indicator_h1 = self._fullscreen_panel:child("line_indicator_h1")
	local line_indicator_h2 = self._fullscreen_panel:child("line_indicator_h2")
	local line_indicator_v1 = self._fullscreen_panel:child("line_indicator_v1")
	local line_indicator_v2 = self._fullscreen_panel:child("line_indicator_v2")
	cross_indicator_h1:set_y(full_16_9.convert_y + self._panel:h() * panel_y)
	cross_indicator_h2:set_bottom(self._fullscreen_panel:child("cross_indicator_h1"):y() + self._panel:h() * h_ratio)
	cross_indicator_v1:set_x(full_16_9.convert_x + self._panel:w() * panel_x)
	cross_indicator_v2:set_right(self._fullscreen_panel:child("cross_indicator_v1"):x() + self._panel:w() * w_ratio)
	line_indicator_h1:set_position(cross_indicator_v1:x(), cross_indicator_h1:y())
	line_indicator_h2:set_position(cross_indicator_v1:x(), cross_indicator_h2:y())
	line_indicator_v1:set_position(cross_indicator_v1:x(), cross_indicator_h1:y())
	line_indicator_v2:set_position(cross_indicator_v2:x(), cross_indicator_h1:y())
	line_indicator_h1:set_w(cross_indicator_v2:x() - cross_indicator_v1:x())
	line_indicator_h2:set_w(cross_indicator_v2:x() - cross_indicator_v1:x())
	line_indicator_v1:set_h(cross_indicator_h2:y() - cross_indicator_h1:y())
	line_indicator_v2:set_h(cross_indicator_h2:y() - cross_indicator_h1:y())
end

function CrimeNetGui:goto_lobby(lobby)
	print(lobby:id())
	local job = self._jobs[lobby:id()]
	if job then
		local x = job.marker_panel:child("select_panel"):center_x() + job.marker_panel:w() / 2
		local y = job.marker_panel:child("select_panel"):center_y() + job.marker_panel:h() - 2
		job.focus:set_size(job.focus:texture_width(), job.focus:texture_height())
		job.focus:set_color(job.focus:color():with_alpha(1))
		self:_goto_map_position(x, y)
	end
end

function CrimeNetGui:goto_bain()
	for _, job in pairs(self._jobs) do
	end
end

function CrimeNetGui:_goto_map_position(x, y)
	local tw = math.max(self._map_panel:child("map"):texture_width(), 1)
	local th = math.max(self._map_panel:child("map"):texture_height(), 1)
	local mx = self._map_panel:x() + x / tw * self._map_size_w * self._zoom - self._fullscreen_panel:w() * 0.5
	local my = self._map_panel:y() + y / th * self._map_size_h * self._zoom - self._fullscreen_panel:h() * 0.5
	self:_set_map_position(-mx, -my)
end

function CrimeNetGui:_set_zoom(zoom, x, y)
	local w1, h1 = self._pan_panel:size()
	local wx1 = (-self._fullscreen_panel:x() - self._pan_panel:x() + x) / self._pan_panel:w()
	local wy1 = (-self._fullscreen_panel:y() - self._pan_panel:y() + y) / self._pan_panel:h()
	local prev_zoom = self._zoom
	if zoom == "in" then
		local new_zoom = math.clamp(self._zoom * 1.1, self.MIN_ZOOM, self.MAX_ZOOM)
		if new_zoom ~= self._zoom then
			managers.menu_component:post_event("zoom_in")
		end
		self._zoom = new_zoom
	else
		local new_zoom = math.clamp(self._zoom / 1.1, self.MIN_ZOOM, self.MAX_ZOOM)
		if new_zoom ~= self._zoom then
			managers.menu_component:post_event("zoom_out")
		end
		self._zoom = new_zoom
	end
	self._pan_panel_border = 6.25 * self._zoom
	if prev_zoom == self._zoom then
		if zoom == "in" then
			self._one_scroll_out_delay = true
		else
			self._one_scroll_in_delay = true
		end
	end
	local cx, cy = self._pan_panel:center()
	self._pan_panel:set_size(self._map_size_w * self._zoom, self._map_size_h * self._zoom)
	self._pan_panel:set_center(cx, cy)
	local w2, h2 = self._pan_panel:size()
	self:_set_map_position((w1 - w2) * wx1, (h1 - h2) * wy1)
	local all_jobs = {}
	for i, data in pairs(self._jobs) do
		all_jobs[i] = data
	end
	for i, data in pairs(self._deleting_jobs) do
		all_jobs[i] = data
	end
	for id, job in pairs(all_jobs) do
		job.marker_panel:set_center(job.job_x * self._zoom, job.job_y * self._zoom)
		job.glow_panel:set_world_center(job.marker_panel:child("select_panel"):world_center())
		if job.heat_glow then
			job.heat_glow:set_world_center(job.marker_panel:child("select_panel"):world_center())
		end
		job.focus:set_center(job.marker_panel:center())
		if job.container_panel then
			job.container_panel:set_center_x(job.marker_panel:center_x())
			job.container_panel:set_bottom(job.marker_panel:top())
			job.container_panel:set_x(math.round(job.container_panel:x()))
		end
		if job.text_on_right then
			job.side_panel:set_left(job.marker_panel:right())
		else
			job.side_panel:set_right(job.marker_panel:left())
		end
		job.side_panel:set_top(job.marker_panel:top() - job.side_panel:child("job_name"):top() + 1)
		if job.icon_panel then
			if job.text_on_right then
				job.icon_panel:set_right(job.marker_panel:left() + 2)
			else
				job.icon_panel:set_left(job.marker_panel:right() - 2)
			end
			job.icon_panel:set_top(math.round(job.marker_panel:top() + 1))
		end
		if job.peers_panel then
			job.peers_panel:set_center_x(job.marker_panel:center_x())
			job.peers_panel:set_center_y(job.marker_panel:center_y())
		end
	end
	for _, region_location in ipairs(self._region_locations) do
		region_location.object:set_font_size(self._zoom * region_location.size)
	end
end

function CrimeNetGui:update_job_gui(job, inside)
	if job.mouse_over ~= inside then
		job.mouse_over = inside
		
		local function animate_alpha(o, objects, job, alphas, inside)
			local wanted_alpha = alphas[1]
			local wanted_text_alpha = alphas[2]
			local wanted_icon_alpha = inside and (job.kick_option == 0 and 1 or 0) or 0
			local start_h = job.side_panel:h()
			local h = start_h
			local host_name = job.side_panel:child("host_name")
			local job_name = job.side_panel:child("job_name")
			local contact_name = job.side_panel:child("contact_name")
			local info_name = job.side_panel:child("info_name")
			local difficulty_name = job.side_panel:child("difficulty_name")
			local heat_name = job.side_panel:child("heat_name")
			local stars_panel = job.side_panel:child("stars_panel")
			local base_h = math.round(host_name:h() + job_name:h() + stars_panel:h())
			local expand_h = math.round(base_h + info_name:h() + difficulty_name:h() + heat_name:h() + math.max(contact_name:h() - job_name:h(), 0))
			local start_x = 0
			local max_x = math.round(math.max(contact_name:w(), info_name:w(), difficulty_name:w(), heat_name:w()))
			if job.text_on_right then
				start_x = math.round(math.max(contact_name:right(), info_name:right(), difficulty_name:right(), heat_name:right()))
			else
				start_x = math.round(job.side_panel:w() - math.min(contact_name:left(), info_name:left(), difficulty_name:left(), heat_name:left()))
			end
			local x = start_x
			local object_alpha = {}
			local text_alpha = job.side_panel:alpha()
			local icon_alpha = job.icon_panel and job.icon_panel:child("kick_icon") and job.icon_panel:child("kick_icon"):alpha() or 0
			local alpha_met = false
			local glow_met = false
			local expand_met = false
			local pushout_met = x == 0
			local dt
			while not (alpha_met and glow_met and expand_met) or not pushout_met do
				dt = coroutine.yield()
				if not alpha_met then
					alpha_met = true
					for i, object in ipairs(objects) do
						if object and alive(object) then
							object_alpha[i] = object_alpha[i] or object:alpha()
							object_alpha[i] = math.step(object_alpha[i], wanted_alpha, dt)
							object:set_alpha(object_alpha[i])
							alpha_met = alpha_met and object_alpha[i] == wanted_alpha
						end
					end
					text_alpha = math.step(text_alpha, wanted_text_alpha, dt * 2)
					job.side_panel:set_alpha(text_alpha)
					if job.icon_panel then
						job.icon_panel:set_alpha(text_alpha)
					end
					if job.icon_panel and job.icon_panel:child("kick_icon") then
						icon_alpha = math.step(icon_alpha, wanted_icon_alpha, dt * 2)
						job.icon_panel:child("kick_icon"):set_alpha(icon_alpha)
					end
					alpha_met = alpha_met and text_alpha == wanted_text_alpha and icon_alpha == wanted_icon_alpha
					if not alpha_met or inside then
					end
				end
				if not glow_met then
					job.glow_panel:set_alpha(math.step(job.glow_panel:alpha(), inside and 0.2 or 0, dt * 5))
					glow_met = job.glow_panel:alpha() == (inside and 0.2 or 0)
					if glow_met and inside then
						local animate_pulse = function(o)
							while true do
								over(1, function(p)
									o:set_alpha(math.sin(p * 180) * 0.4 + 0.2)
								end)
							end
						end
						job.glow_panel:animate(animate_pulse)
					end
				end
				if not expand_met and pushout_met then
					h = math.step(h, inside and expand_h or base_h, (inside and expand_h or base_h) * dt * 4)
					job.side_panel:set_h(h)
					job.side_panel:set_top(o:top() - job_name:top() + 1)
					stars_panel:set_bottom(job.side_panel:h())
					expand_met = h == (inside and expand_h or base_h)
					if expand_met then
						pushout_met = x == (inside and max_x or 0)
					end
				end
				if not pushout_met then
					x = math.step(x, inside and max_x or 0, max_x * dt * 4)
					stars_panel:set_alpha(1 - x / math.min(max_x, 1))
					if job.text_on_right then
						job_name:set_left(math.round(math.min(x, contact_name:w())))
						contact_name:set_left(math.round(math.min(x - contact_name:w(), 0)))
						info_name:set_left(math.round(math.min(x - info_name:w(), 0)))
						difficulty_name:set_left(math.round(math.min(x - difficulty_name:w(), 0)))
						heat_name:set_left(math.round(math.min(x - heat_name:w(), 0)))
					else
						job_name:set_right(math.round(job.side_panel:w() - math.min(x, contact_name:w())))
						contact_name:set_right(math.round(job.side_panel:w() - math.min(x - contact_name:w(), 0)))
						info_name:set_right(math.round(job.side_panel:w() - math.min(x - info_name:w(), 0)))
						difficulty_name:set_right(math.round(job.side_panel:w() - math.min(x - difficulty_name:w(), 0)))
						heat_name:set_right(math.round(job.side_panel:w() - math.min(x - heat_name:w(), 0)))
					end
					pushout_met = x == (inside and max_x or 0)
				end
			end
			if inside and job.callout and self._crimenet_enabled then
				Application:debug(job.callout)
				managers.menu_component:post_event(job.callout, true)
			end
		end
		
		local text_alpha = inside == 1 and 1 or inside == 2 and 0 or 1
		local object_alpha = inside == 1 and 1 or inside == 2 and 0.3 or 1
		local alphas = {object_alpha, text_alpha}
		local objects = {
			job.marker_panel,
			job.peers_panel
		}
		if job.container_panel then
			table.insert(objects, job.container_panel)
		end
		if not job.pulse then
			job.glow_panel:stop()
		end
		if inside == 1 then
			managers.menu_component:post_event("highlight")
			job.side_panel:child("job_name"):set_blend_mode("add")
			job.side_panel:child("contact_name"):set_blend_mode("add")
			job.side_panel:child("info_name"):set_blend_mode("add")
			job.side_panel:child("difficulty_name"):set_blend_mode("add")
			job.side_panel:child("heat_name"):set_blend_mode("add")
		else
			job.side_panel:child("job_name"):set_blend_mode("add")
			job.side_panel:child("contact_name"):set_blend_mode("add")
			job.side_panel:child("info_name"):set_blend_mode("add")
			job.side_panel:child("difficulty_name"):set_blend_mode("add")
			job.side_panel:child("heat_name"):set_blend_mode("add")
		end
		job.marker_panel:stop()
		if job.peers_panel then
			job.peers_panel:set_layer(inside == 1 and 20 or job.layer)
		end
		job.marker_panel:set_layer(inside == 1 and 20 or job.layer)
		job.glow_panel:set_layer(job.marker_panel:layer() - 1)
		if job.container_panel then
			job.container_panel:set_layer(inside == 1 and 20 or job.layer)
		end
		job.marker_panel:animate(animate_alpha, objects, job, alphas, inside == 1)
	end
end

function CrimeNetGui:mouse_moved(o, x, y)
	if not self._crimenet_enabled then
		return false
	end
	if managers.menu:is_pc_controller() then
		if self._panel:child("back_button"):inside(x, y) then
			if not self._back_highlighted then
				self._back_highlighted = true
				self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end
			return true, "link"
		elseif self._back_highlighted then
			self._back_highlighted = false
			self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_3)
		end
		if self._panel:child("legends_button"):inside(x, y) then
			if not self._legend_highlighted then
				self._legend_highlighted = true
				self._panel:child("legends_button"):set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end
			return true, "link"
		elseif self._legend_highlighted then
			self._legend_highlighted = false
			self._panel:child("legends_button"):set_color(tweak_data.screen_colors.button_stage_3)
		end
		if self._panel:child("filter_button") then
			if self._panel:child("filter_button"):inside(x, y) then
				if not self._filter_highlighted then
					self._filter_highlighted = true
					self._panel:child("filter_button"):set_color(tweak_data.screen_colors.button_stage_2)
					managers.menu_component:post_event("highlight")
				end
				return true, "link"
			elseif self._filter_highlighted then
				self._filter_highlighted = false
				self._panel:child("filter_button"):set_color(tweak_data.screen_colors.button_stage_3)
			end
		end
	end
	if self._grabbed_map then
		local left = x > self._grabbed_map.x
		local right = not left
		local up = y > self._grabbed_map.y
		local down = not up
		local mx = x - self._grabbed_map.x
		local my = y - self._grabbed_map.y
		if left and self._map_panel:x() > -self:_get_pan_panel_border() then
			mx = math.lerp(mx, 0, 1 - self._map_panel:x() / -self:_get_pan_panel_border())
		end
		if right and self._fullscreen_panel:w() - self._map_panel:right() > -self:_get_pan_panel_border() then
			mx = math.lerp(mx, 0, 1 - (self._fullscreen_panel:w() - self._map_panel:right()) / -self:_get_pan_panel_border())
		end
		if up and self._map_panel:y() > -self:_get_pan_panel_border() then
			my = math.lerp(my, 0, 1 - self._map_panel:y() / -self:_get_pan_panel_border())
		end
		if down and self._fullscreen_panel:h() - self._map_panel:bottom() > -self:_get_pan_panel_border() then
			my = math.lerp(my, 0, 1 - (self._fullscreen_panel:h() - self._map_panel:bottom()) / -self:_get_pan_panel_border())
		end
		table.insert(self._grabbed_map.dirs, 1, {mx, my})
		self._grabbed_map.dirs[10] = nil
		self:_set_map_position(mx, my)
		self._grabbed_map.x = x
		self._grabbed_map.y = y
		return true, "grab"
	end
	local closest_job
	local closest_dist = 100000000
	local closest_job_x, closest_job_y = 0, 0
	local job_x, job_y
	local dist = 0
	local inside_any_job = false
	local math_x, math_y
	for id, job in pairs(self._jobs) do
		local inside = job.marker_panel:child("select_panel"):inside(x, y) and self._panel:inside(x, y)
		inside_any_job = inside_any_job or inside
		if inside then
			job_x, job_y = job.marker_panel:child("select_panel"):world_center()
			math_x = job_x - x
			math_y = job_y - y
			dist = math_x * math_x + math_y * math_y
			if closest_dist > dist then
				closest_job = job
				closest_dist = dist
				closest_job_x = job_x
				closest_job_y = job_y
			end
		end
	end
	for id, job in pairs(self._jobs) do
		local inside = job == closest_job and 1 or inside_any_job and 2 or 3
		self:update_job_gui(job, inside)
	end
	if not managers.menu:is_pc_controller() then
		local to_left = x
		local to_right = self._panel:w() - x - 19
		local to_top = y
		local to_bottom = self._panel:h() - y - 23
		local panel_border = self._pan_panel_border
		to_left = 1 - math.clamp(to_left / panel_border, 0, 1)
		to_right = 1 - math.clamp(to_right / panel_border, 0, 1)
		to_top = 1 - math.clamp(to_top / panel_border, 0, 1)
		to_bottom = 1 - math.clamp(to_bottom / panel_border, 0, 1)
		local mouse_pointer_move_x = managers.mouse_pointer:mouse_move_x()
		local mouse_pointer_move_y = managers.mouse_pointer:mouse_move_y()
		local mp_left = -math.min(0, mouse_pointer_move_x)
		local mp_right = -math.max(0, mouse_pointer_move_x)
		local mp_top = -math.min(0, mouse_pointer_move_y)
		local mp_bottom = -math.max(0, mouse_pointer_move_y)
		local push_x = mp_left * to_left + mp_right * to_right
		local push_y = mp_top * to_top + mp_bottom * to_bottom
		if push_x ~= 0 or push_y ~= 0 then
			self:_set_map_position(push_x, push_y)
		end
	end
	if inside_any_job then
		return true, "link"
	end
	if self._panel:inside(x, y) then
		return true, "hand"
	end
end

function CrimeNetGui:ps3_invites_callback()
	if managers.system_menu and managers.system_menu:is_active() and not managers.system_menu:is_closing() then
		return true
	end
	if managers.menu:active_menu() and managers.menu:active_menu().input:get_accept_input() then
		managers.menu:active_menu().renderer:disable_input(0.2)
		MenuCallbackHandler:view_invites()
	end
end

function CrimeNetGui:enable_crimenet()
	self._crimenet_enabled = true
	managers.crimenet:activate()
	if self._ps3_invites_controller then
		self._ps3_invites_controller:set_enabled(true)
	end
end

function CrimeNetGui:disable_crimenet()
	self._crimenet_enabled = false
	managers.crimenet:deactivate()
	if self._ps3_invites_controller then
		self._ps3_invites_controller:set_enabled(false)
	end
end

function CrimeNetGui:close()
	managers.crimenet:stop()
	if self._crimenet_ambience then
		self._crimenet_ambience:stop()
		self._crimenet_ambience = nil
	end
	managers.menu_component:stop_event()
	managers.menu:active_menu().renderer.ws:show()
	self._ws:panel():remove(self._panel)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
	if not managers.menu:is_pc_controller() then
		managers.menu:active_menu().input:deactivate_controller_mouse()
		managers.mouse_pointer:release_mouse_pointer()
	end
	if self._ps3_invites_controller then
		self._ps3_invites_controller:set_enabled(false)
		self._ps3_invites_controller:destroy()
		self._ps3_invites_controller = nil
	end
end
