local _max_priority = 100000
local __max_priority = _max_priority - 1
local _pick_random_snd_event = function(snd_events)
	local count = #snd_events
	local rnd_idx = math.random(1, count)
	local snd_event = snd_events[rnd_idx]
	return snd_event
end
local _increase_priority = function(snd_event, inc, max)
	snd_event.priority = math.min(snd_event.priority * inc, max)
end
ButlerMirroringManager = ButlerMirroringManager or class()

function ButlerMirroringManager:init()
	self:_setup()
end

function ButlerMirroringManager:_setup()
	if not Global.butler_mirroring then
		Global.butler_mirroring = {}
		Global.butler_mirroring._queue = {}
		Global.butler_mirroring._current_sound_event = nil
	end
	self._global = Global.butler_mirroring
	managers.mission:add_global_event_listener("butler_mirroring_heist_complete", {
		Message.OnHeistComplete
	}, callback(self, self, "_on_heist_complete"))
	managers.mission:add_global_event_listener("butler_mirroring_achievement", {
		Message.OnAchievement
	}, callback(self, self, "_on_achievement"))
end

function ButlerMirroringManager:has_sound_event()
	return table.size(self._global._queue) > 0
end

function ButlerMirroringManager:get_sound_event()
	local snd_events
	local priority = 0
	local debug
	for _, snd in pairs(self._global._queue) do
		if priority < snd.priority then
			snd_events = snd.snd_events
			priority = snd.priority
			debug = snd.debug
		end
	end
	local snd_event = _pick_random_snd_event(snd_events)
	self._global._queue = {}
	return snd_event, debug
end

function ButlerMirroringManager:load(data, version)
	if data.butler_mirroring then
		self._global._has_entered_safehouse = data.butler_mirroring._has_entered_safehouse
		self._global._queue = deep_clone(data.butler_mirroring._queue)
	end
end

function ButlerMirroringManager:save(data)
	local save_data = deep_clone(self._global)
	data.butler_mirroring = save_data
end

function ButlerMirroringManager:_on_heist_complete(level_id, difficulty_id)
	local sound_event
	local heist_difficulties = {
		{
			{
				"overkill_290",
				"sm_wish"
			},
			"d"
		},
		{
			{
				"normal",
				"hard",
				"overkill",
				"overkill_145",
				"easy_wish",
				"overkill_290",
				"sm_wish"
			},
			"n"
		}
	}
	local heist_events = {
		gallery = "ag",
		branchbank_prof = "bh",
		branchbank_gold_prof = "bh",
		branchbank_cash = "bh",
		branchbank_deposit = "bh",
		cage = "cs",
		rat = "co",
		family = "ds",
		roberts = "gb",
		jewelry_store = "js",
		kosugi = "sr",
		arena = "ah",
		arm_cro = "at",
		arm_hcm = "at",
		arm_fac = "at",
		arm_par = "at",
		arm_und = "at",
		arm_for = "th",
		hox = "hb",
		hox_3 = "hr",
		big = "bb",
		mus = "td",
		kenaz = "gg",
		mia = "hm",
		welcome_to_the_jungle_prof = "bo",
		election_day = "ed",
		framing_frame = "ff",
		born = "bkr",
		firestarter = "fs",
		alex = "rat",
		watchdogs_wrapper = "wd",
		watchdogs = "wd",
		watchdogs_night = "wd",
		jolly = "as",
		four_stores = "fos",
		mallcrasher = "mc",
		shoutout_raid = "md",
		nightclub = "nc",
		cane = "sw",
		ukrainian_job_prof = "uj",
		pines = "wx",
		peta = "gs",
		crojob1 = "bd",
		crojob2 = "bf",
		mad = "bp",
		dark = "ms",
		pbr = "btm",
		pbr2 = "bos",
		red2 = "fwb",
		dinner = "slh",
		pal = "cf",
		man = "uc",
		nail = "lr",
		haunted = "sfn",
		chill_combat = "sfh",
		flat = "pr"
	}
	local level_event_id = heist_events[level_id]
	if level_event_id then
		local difficulty_event_id
		for _, diff_data in ipairs(heist_difficulties) do
			if table.contains(diff_data[1], difficulty_id) then
				difficulty_event_id = diff_data[2]
				break
			end
		end
		difficulty_event_id = difficulty_event_id or "n"
		sound_event = "Play_btl_hcr_" .. level_event_id .. difficulty_event_id .. "_01"
		print("[ButlerMirroringManager] queued sound event for heist: ", level_id, sound_event)
	else
		print("[ButlerMirroringManager] no sound_event for heist: ", level_id)
	end
	if not sound_event then
		return
	end
	local inc = 1.1
	if self._global._queue[Message.OnHeistComplete] then
		self._global._queue[Message.OnHeistComplete].snd_events = {sound_event}
		_increase_priority(self._global._queue[Message.OnHeistComplete], inc, __max_priority)
	else
		self._global._queue[Message.OnHeistComplete] = {
			snd_events = {sound_event},
			priority = 5.8,
			debug = "On heist complete VO"
		}
	end
end

function ButlerMirroringManager:_on_achievement(id)
	local l = {
		farm_6 = "Play_btl_ach_01",
		gage_8 = "Play_btl_ach_02",
		gorilla_1 = "Play_btl_ach_03",
		deer_7 = "Play_btl_ach_04",
		gage3_9 = "Play_btl_ach_05",
		gage2_8 = "Play_btl_ach_06",
		gage2_10 = "Play_btl_ach_07",
		the_wire = "Play_btl_ach_08",
		kosugi_4 = "Play_btl_ach_09",
		frog_1 = "Play_btl_ach_10",
		death_29 = "Play_btl_ach_11",
		halloween_nightmare_5 = "Play_btl_ach_12",
		short_fuse = "Play_btl_ach_13",
		death_30 = "Play_btl_ach_14",
		sinus_1 = "Play_btl_ach_15"
	}
	local snd_event = l[id]
	if snd_event then
		local inc = 100.1
		if self._global._queue[Message.OnAchievement] then
			_increase_priority(self._global._queue[Message.OnAchievement], inc, __max_priority)
		else
			self._global._queue[Message.OnAchievement] = {
				snd_events = {snd_event},
				priority = 200.8,
				debug = "On achievement VO"
			}
		end
	end
end

function ButlerMirroringManager:_on_level_up()
	local rnd = math.random()
	if 0.4 < rnd then
		local inc = 100.1
		if self._global._queue[Message.OnLevelUp] then
			_increase_priority(self._global._queue[Message.OnLevelUp], inc, __max_priority)
		else
			self._global._queue[Message.OnLevelUp] = {
				snd_events = {
					"Play_btl_lvl"
				},
				priority = 20.8,
				debug = "On level up VO"
			}
		end
	end
end
