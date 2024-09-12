ButlerSound = ButlerSound or class(CivilianHeisterSound)
ButlerSound.RND_MIN = 4
ButlerSound.RND_MAX = 6
local _butler_talk_anims = {
	Idstring("so_butler_talk_loop_var2"),
	Idstring("so_butler_talk_loop_var3"),
	Idstring("so_butler_talk_loop_var4"),
	Idstring("so_butler_talk_loop"),
	Idstring("so_butler_talk_calm_gestures"),
	Idstring("so_butler_talk_arm_gestures")
}
local _butler_idle_anims = {
	Idstring("so_butler_look_up"),
	Idstring("so_butler_brush_jacket"),
	Idstring("so_butler_scratches_chin"),
	Idstring("so_butler_look_behind"),
	Idstring("so_butler_watch_look_calm")
}

function ButlerSound:init(unit)
	ButlerSound.super.init(self, unit)
	managers.enemy:add_delayed_clbk("ButlerSound", callback(self, self, "_mirroring_clbk"), TimerManager:game():time() + 2)
	self._speech_t = 0
	local player_unit = managers.player:player_unit()
	local player_character = managers.criminals:character_name_by_unit(player_unit)
	local player_voice = "rb1"
	for idx, data in ipairs(tweak_data.criminals.characters) do
		if data.name == player_character then
			player_voice = data.static_data.voice
			break
		end
	end
	self:set_interactor_voice(player_voice)
	local level = managers.custom_safehouse:avarage_level()
	self:set_room_level(level)
	self._unit:set_extension_update_enabled(Idstring("sound"), false)
end

function ButlerSound:_randomize_speech_time()
	self._speech_t = Application:time() + math.random(self.RND_MIN, self.RND_MAX)
end

function ButlerSound:_mirroring_clbk()
	if managers.butler_mirroring:has_sound_event() then
		self._snd_clbk = callback(self, self, "_mirroring_sound_callback")
		self._snd_start_clbk = callback(self, self, "_sound_start_mirroring")
		local count = #_butler_talk_anims
		local rnd_idx = math.random(1, count)
		self._unit:play_redirect(_butler_talk_anims[rnd_idx])
	else
		self._unit:set_extension_update_enabled(Idstring("sound"), true)
		self:_randomize_speech_time()
	end
end

function ButlerSound:sound_callback(instance, event_type, unit, sound_source, label, identifier, position)
	if not alive(unit) then
		return
	end
	unit:sound():snd_clbk()
	if event_type == "end_of_event" then
		unit:sound()._speaking = nil
	end
end

function ButlerSound:update(unit, t, dt)
	local is_speaking = self:speaking(t)
	if t >= self._speech_t then
		if not is_speaking then
			self:_sound_start_muttering()
			self._unit:set_extension_update_enabled(Idstring("sound"), false)
		else
			self:_randomize_speech_time()
		end
	end
end

function ButlerSound:sound_start(...)
	if self._snd_start_clbk then
		self._snd_start_clbk()
		self._snd_start_clbk = nil
	end
end

function ButlerSound:snd_clbk()
	if self._snd_clbk then
		self._snd_clbk()
	end
end

function ButlerSound:_mirroring_sound_callback()
	local count = #_butler_idle_anims
	local rnd_idx = math.random(1, count)
	self._unit:play_redirect(_butler_idle_anims[rnd_idx])
end

function ButlerSound:_on_muttering_done()
	self:_randomize_speech_time()
	self._unit:set_extension_update_enabled(Idstring("sound"), true)
	self._snd_clbk = nil
end

function ButlerSound:_sound_start_mirroring()
	local snd_event, debug = managers.butler_mirroring:get_sound_event()
	if snd_event then
		self:say(snd_event, false, true)
	end
end

function ButlerSound:_sound_start_muttering()
	self._snd_clbk = callback(self, self, "_on_muttering_done")
	self:say("Play_btl_idle", false, true)
end
