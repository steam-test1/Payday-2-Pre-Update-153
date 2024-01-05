local tmp_vec1 = Vector3()
ECMJammerBase = ECMJammerBase or class(UnitBase)
ECMJammerBase._NET_EVENTS = {
	battery_low = 1,
	battery_empty = 2,
	feedback_start = 3,
	feedback_stop = 4,
	jammer_active = 5
}

function ECMJammerBase.spawn(pos, rot, battery_life_upgrade_lvl, owner)
	local unit = World:spawn_unit(Idstring("units/payday2/equipment/gen_equipment_jammer/gen_equipment_jammer"), pos, rot)
	unit:base():setup(battery_life_upgrade_lvl, owner)
	return unit
end

function ECMJammerBase:set_server_information(peer_id)
	self._server_information = {owner_peer_id = peer_id}
	managers.network:game():member(peer_id):peer():set_used_deployable(true)
end

function ECMJammerBase:server_information()
	return self._server_information
end

function ECMJammerBase:init(unit)
	UnitBase.init(self, unit, true)
	self._unit = unit
	self._position = self._unit:position()
	self._rotation = self._unit:rotation()
	self._g_glow_jammer_green = self._unit:get_object(Idstring("g_glow_func1_green"))
	self._g_glow_jammer_red = self._unit:get_object(Idstring("g_glow_func1_red"))
	self._g_glow_feedback_green = self._unit:get_object(Idstring("g_glow_func2_green"))
	self._g_glow_feedback_red = self._unit:get_object(Idstring("g_glow_func2_red"))
	self._max_battery_life = tweak_data.upgrades.ecm_jammer_base_battery_life
	self._battery_life = self._max_battery_life
	self._low_battery_life = tweak_data.upgrades.ecm_jammer_base_low_battery_life
	self._feedback_active = false
	self._jammer_active = false
end

function ECMJammerBase:get_name_id()
	return "ecm_jammer"
end

function ECMJammerBase:set_owner(owner)
	self._owner = owner
end

function ECMJammerBase:owner()
	return self._owner
end

function ECMJammerBase:battery_life()
	return self._battery_life or 0
end

function ECMJammerBase:sync_net_event(event_id)
	local net_events = self._NET_EVENTS
	if event_id == net_events.battery_low then
		self:_set_battery_low()
	elseif event_id == net_events.battery_empty then
		self:_set_battery_empty()
	elseif event_id == net_events.feedback_start then
		self:_set_feedback_active(true)
	elseif event_id == net_events.feedback_stop then
		self:_set_feedback_active(false)
	elseif event_id == net_events.jammer_active then
		self:set_active(true)
	end
end

function ECMJammerBase:_send_net_event(event_id)
	managers.network:session():send_to_peers_synched("sync_unit_event_id_8", self._unit, "base", event_id)
end

function ECMJammerBase:_send_net_event_to_host(event_id)
	managers.network:session():send_to_host("sync_unit_event_id_8", self._unit, "base", event_id)
end

function ECMJammerBase:setup(battery_life_upgrade_lvl, owner)
	self._slotmask = managers.slot:get_mask("trip_mine_targets")
	self._max_battery_life = tweak_data.upgrades.ecm_jammer_base_battery_life * battery_life_upgrade_lvl
	self._battery_life = self._max_battery_life
	self._owner = owner
end

function ECMJammerBase:set_active(active)
	active = active and true
	if self._jammer_active == active then
		return
	end
	if Network:is_server() then
		if active then
			self._owner_peer_id = managers.network:session():local_peer():id()
			local from_pos = self._unit:position() + self._unit:rotation():y() * 10
			local to_pos = self._unit:position() + self._unit:rotation():y() * -10
			local ray = self._unit:raycast("ray", from_pos, to_pos, "slot_mask", managers.slot:get_mask("trip_mine_placeables"))
			if ray then
				self._attached_data = {}
				self._attached_data.body = ray.body
				self._attached_data.position = ray.body:position()
				self._attached_data.rotation = ray.body:rotation()
				self._attached_data.index = 1
				self._attached_data.max_index = 3
			end
			self._alert_filter = self._owner:movement():SO_access()
			local jam_cameras
			if managers.network:game():member_from_unit(self._owner):peer():id() == 1 then
				jam_cameras = managers.player:has_category_upgrade("ecm_jammer", "affects_cameras")
			else
				jam_cameras = self._owner:base():upgrade_value("ecm_jammer", "affects_cameras")
			end
			managers.groupai:state():register_ecm_jammer(self._unit, {call = true, camera = jam_cameras})
			self:_send_net_event(self._NET_EVENTS.jammer_active)
		else
			managers.groupai:state():register_ecm_jammer(self._unit, false)
		end
	end
	if active then
		if not self._jam_sound_event then
			self._jam_sound_event = self._unit:sound_source():post_event("ecm_jammer_jam_signal")
		end
	elseif self._jam_sound_event then
		self._jam_sound_event:stop()
		self._jam_sound_event = nil
		self._unit:sound_source():post_event("ecm_jammer_jam_signal_stop")
	end
	self._jammer_active = active
end

function ECMJammerBase:active()
	return self._jammer_active
end

function ECMJammerBase:update(unit, t, dt)
	if self._battery_life > 0 then
		self._battery_life = self._battery_life - dt
		self:check_battery()
	end
	self:_check_body()
end

function ECMJammerBase:check_battery()
	if self._battery_life <= 0 then
		self:set_battery_empty()
	elseif self._battery_life <= self._low_battery_life then
		self:set_battery_low()
	end
end

function ECMJammerBase:set_battery_empty()
	if self._battery_empty then
		return
	end
	self._battery_life = 0
	self:_set_battery_empty()
end

function ECMJammerBase:_set_battery_empty()
	self._battery_empty = true
	self._g_glow_jammer_green:set_visibility(false)
	self._g_glow_jammer_red:set_visibility(false)
	self:set_active(false)
	if Network:is_server() then
		self:_send_net_event(self._NET_EVENTS.battery_empty)
	end
end

function ECMJammerBase:set_battery_low()
	if self._battery_low then
		return
	end
	self._battery_life = self._low_battery_life
	self:_set_battery_low()
end

function ECMJammerBase:_set_battery_low()
	self._battery_low = true
	self._g_glow_jammer_red:set_visibility(true)
	if Network:is_server() then
		self:_send_net_event(self._NET_EVENTS.battery_low)
	end
end

function ECMJammerBase:sync_set_battery_life(battery_life)
	self._battery_life = battery_life
	self:check_battery()
end

function ECMJammerBase:_check_body()
	if not self._attached_data then
		return
	end
	if self._attached_data.index == 1 then
		if not alive(self._attached_data.body) or not self._attached_data.body:enabled() then
			self:_force_remove()
		end
	elseif self._attached_data.index == 2 then
		if not alive(self._attached_data.body) or not mrotation.equal(self._attached_data.rotation, self._attached_data.body:rotation()) then
			self:_force_remove()
		end
	elseif self._attached_data.index == 3 and (not alive(self._attached_data.body) or mvector3.not_equal(self._attached_data.position, self._attached_data.body:position())) then
		self:_force_remove()
	end
	self._attached_data.index = (self._attached_data.index < self._attached_data.max_index and self._attached_data.index or 0) + 1
end

function ECMJammerBase:feedback_active()
	return self._feedback_active
end

function ECMJammerBase:set_feedback_active()
	if not managers.network:session() then
		return
	end
	if Network:is_client() then
		self:_send_net_event_to_host(self._NET_EVENTS.feedback_start)
	else
		self:_set_feedback_active(true)
	end
end

function ECMJammerBase:_set_feedback_active(state)
	state = state and true
	if state == self._feedback_active then
		return
	end
	if Network:is_server() then
		if state then
			self._unit:interaction():set_active(false, true)
			local t = TimerManager:game():time()
			self._feedback_clbk_id = "ecm_feedback" .. tostring(self._unit:key())
			self._feedback_interval = 1.5
			self._feedback_range = 1000
			local duration_mul = 1
			if managers.network:game():member_from_unit(self._owner):peer():id() == 1 then
				duration_mul = duration_mul * managers.player:upgrade_value("ecm_jammer", "feedback_duration_boost", 1)
				duration_mul = duration_mul * managers.player:upgrade_value("ecm_jammer", "feedback_duration_boost_2", 1)
			else
				duration_mul = duration_mul * (self._owner:base():upgrade_value("ecm_jammer", "feedback_duration_boost") or 1)
				duration_mul = duration_mul * (self._owner:base():upgrade_value("ecm_jammer", "feedback_duration_boost_2") or 1)
			end
			self._feedback_duration = math.lerp(15, 20, math.random()) * duration_mul
			self._feedback_expire_t = t + self._feedback_duration
			local first_impact_t = t + math.lerp(0.1, 1, math.random())
			managers.enemy:add_delayed_clbk(self._feedback_clbk_id, callback(self, self, "clbk_feedback"), first_impact_t)
			self:_send_net_event(self._NET_EVENTS.feedback_start)
		else
			if self._feedback_clbk_id then
				managers.enemy:remove_delayed_clbk(self._feedback_clbk_id)
				self._feedback_clbk_id = nil
			end
			self:_send_net_event(self._NET_EVENTS.feedback_stop)
		end
	end
	if state then
		self._g_glow_feedback_green:set_visibility(true)
		self._g_glow_feedback_red:set_visibility(false)
		if not self._puke_sound_event then
			self._puke_sound_event = self._unit:sound_source():post_event("ecm_jammer_puke_signal")
		end
	else
		self._g_glow_feedback_green:set_visibility(false)
		self._g_glow_feedback_red:set_visibility(false)
		if self._puke_sound_event then
			self._puke_sound_event:stop()
			self._puke_sound_event = nil
			self._unit:sound_source():post_event("ecm_jammer_puke_stop")
		end
	end
	self._feedback_active = state
end

function ECMJammerBase:sync_set_feedback_active()
	self:_set_feedback_active()
end

function ECMJammerBase:clbk_feedback()
	local t = TimerManager:game():time()
	self._feedback_clbk_id = "ecm_feedback" .. tostring(self._unit:key())
	if not managers.groupai:state():enemy_weapons_hot() then
		managers.groupai:state():propagate_alert({
			"vo_cbt",
			self._position,
			10000,
			self._alert_filter,
			self._unit
		})
	end
	self._detect_and_give_dmg(self._position + self._unit:rotation():y() * 15, self._unit, self._owner, self._feedback_range)
	if t > self._feedback_expire_t then
		self._feedback_clbk_id = nil
		self:_set_feedback_active(false)
	else
		if self._feedback_expire_t - t < self._feedback_duration * 0.1 then
			self._g_glow_feedback_red:set_visibility(true)
			self._g_glow_feedback_green:set_visibility(false)
		end
		managers.enemy:add_delayed_clbk(self._feedback_clbk_id, callback(self, self, "clbk_feedback"), t + self._feedback_interval + math.random() * 0.3)
	end
end

function ECMJammerBase._detect_and_give_dmg(hit_pos, device_unit, user_unit, range)
	local mvec3_dis_sq = mvector3.distance_sq
	local slotmask = managers.slot:get_mask("bullet_impact_targets")
	local splinters = {
		mvector3.copy(hit_pos)
	}
	local dirs = {
		Vector3(range, 0, 0),
		Vector3(-range, 0, 0),
		Vector3(0, range, 0),
		Vector3(0, -range, 0),
		Vector3(0, 0, range),
		Vector3(0, 0, -range)
	}
	local pos = tmp_vec1
	for _, dir in ipairs(dirs) do
		mvector3.set(pos, dir)
		mvector3.add(pos, hit_pos)
		local splinter_ray = World:raycast("ray", hit_pos, pos, "slot_mask", slotmask)
		pos = (splinter_ray and splinter_ray.position or pos) - dir:normalized() * math.min(splinter_ray and splinter_ray.distance or 0, 10)
		local near_splinter = false
		for _, s_pos in ipairs(splinters) do
			if mvector3.distance_sq(pos, s_pos) < 300 then
				near_splinter = true
				break
			end
		end
		if not near_splinter then
			table.insert(splinters, mvector3.copy(pos))
		end
	end
	local range_sq = range * range
	local half_range_sq = range * 0.5
	half_range_sq = half_range_sq * half_range_sq
	
	local function _chk_apply_dmg_to_char(u_data)
		if not u_data.char_tweak.ecm_vulnerability then
			return
		end
		if math.random() >= u_data.char_tweak.ecm_vulnerability then
			return
		end
		local head_pos = u_data.unit:movement():m_head_pos()
		local dis_sq = mvec3_dis_sq(head_pos, hit_pos)
		if dis_sq > range_sq then
			return
		end
		for i_splinter, s_pos in ipairs(splinters) do
			local ray_hit = World:raycast("ray", s_pos, head_pos, "slot_mask", slotmask, "ignore_unit", u_data.unit, "report")
			if not ray_hit and (i_splinter == 1 or dis_sq < half_range_sq) then
				local attack_data = {
					variant = "stun",
					damage = 0,
					attacker_unit = user_unit,
					weapon_unit = device_unit,
					col_ray = {
						position = mvector3.copy(head_pos),
						ray = (head_pos - s_pos):normalized()
					}
				}
				u_data.unit:character_damage():damage_explosion(attack_data)
				break
			end
		end
	end
	
	for u_key, u_data in pairs(managers.enemy:all_enemies()) do
		_chk_apply_dmg_to_char(u_data)
	end
	for u_key, u_data in pairs(managers.enemy:all_civilians()) do
		_chk_apply_dmg_to_char(u_data)
	end
end

function ECMJammerBase:_force_remove()
	self._unit:set_slot(0)
end

function ECMJammerBase:save(data)
	local state = {
		jammer_active = self._jammer_active or nil,
		feedback_active = self._feedback_active or nil,
		low_battery = self._battery_low or nil
	}
	data.ECMJammerBase = state
end

function ECMJammerBase:load(data)
	local state = data.ECMJammerBase
	if state.jammer_active then
		self:set_active(true)
		if state.low_battery then
			self:_set_battery_low()
		end
	else
		self:_set_battery_empty()
	end
	if state.feedback_active then
		self:_set_feedback_active(true)
	end
end

function ECMJammerBase:destroy()
	self:set_active(false)
	self:_set_feedback_active(false)
end
