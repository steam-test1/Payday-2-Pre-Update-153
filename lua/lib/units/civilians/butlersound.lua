ButlerSound = ButlerSound or class(SafehouseNPCSound)
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
	self._unit:set_extension_update_enabled(Idstring("sound"), false)
	managers.enemy:add_delayed_clbk("ButlerSound", callback(self, self, "_mirroring_clbk"), TimerManager:game():time() + 2)
	self.character = "btl"
	local found = World:find_units_quick("all", 1)
	for k, v in pairs(found) do
		if string.ends(v:model_filename(), "rsu_prop_trophy_officer_footlocker") then
			self._chest_unit = v
			break
		end
	end
	self._raid_box_count = 1
	self._raid_idle_count = 1
end

function ButlerSound:_mirroring_clbk()
	if not alive(self._unit) then
		return
	end
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

function ButlerSound:_mirroring_sound_callback()
	local count = #_butler_idle_anims
	local rnd_idx = math.random(1, count)
	self._unit:play_redirect(_butler_idle_anims[rnd_idx])
end

function ButlerSound:_sound_start_mirroring()
	local snd_event, debug = managers.butler_mirroring:get_sound_event()
	if snd_event then
		self:say(snd_event, false, true)
	end
end

function ButlerSound:_sound_start_muttering()
	local override_sound
	local CLOSE_SQ = 1000000
	local CLOSE_Z = 200
	if self._last_chest then
		self._last_chest = false
	elseif self._chest_unit and (self._raid_box_count < 5 and math.random() < 0.8 or math.random() < 0.2) then
		local my_pos = self._unit:position()
		local chest_pos = self._chest_unit:position()
		local dist_sq = mvector3.distance_sq(my_pos, chest_pos)
		if CLOSE_SQ > dist_sq and CLOSE_Z > math.abs(my_pos.z - chest_pos.z) then
			override_sound = "Play_btl_raid_box_large"
			self._raid_box_count = self._raid_box_count + 1
			self._last_chest = true
		end
	end
	if self._last_promo then
		self._last_promo = false
	elseif not override_sound and (self._raid_idle_count < 6 and math.random() < 0.7 or math.random() < 0.1) then
		override_sound = "Play_btl_raid_promo_01"
		self._raid_idle_count = self._raid_idle_count + 1
		self._last_promo = true
	end
	ButlerSound.super._sound_start_muttering(self, override_sound)
end
