CivilianHeisterSound = CivilianHeisterSound or class(PlayerSound)

function CivilianHeisterSound:init(unit)
	self._unit = unit
	unit:base():post_init()
	local ss = self._unit:sound_source()
	ss:set_switch("int_ext", "third")
end

function CivilianHeisterSound:set_room_level(level)
	local level_switches = {
		"state_01",
		"state_02",
		"state_03"
	}
	local ss = self._unit:sound_source()
	ss:set_switch("safehouse_state", level_switches[level] or level_switches[1])
end

function CivilianHeisterSound:set_interactor_voice(interactor_voice)
	local ss = self._unit:sound_source()
	ss:set_switch("safehouse_toggle_robber", interactor_voice)
end

function CivilianHeisterSound:set_minigame_response(state)
	local ss = self._unit:sound_source()
	ss:set_switch("safehouse_minigame", state)
end

function CivilianHeisterSound:anim_clbk_play_sound(unit, queue_name)
	self:_play(queue_name)
end

function CivilianHeisterSound:anim_clbk_stop_sound(unit, source_name)
	if source_name and source_name == Idstring("") then
		self:stop()
		return
	end
	self:stop(source_name)
end
