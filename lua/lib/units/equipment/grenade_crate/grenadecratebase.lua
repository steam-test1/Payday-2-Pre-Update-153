GrenadeCrateBase = GrenadeCrateBase or class(UnitBase)

function GrenadeCrateBase.spawn(pos, rot)
	local unit_name = "units/payday2/equipment/gen_equipment_grenade_crate/gen_equipment_grenade_crate"
	local unit = World:spawn_unit(Idstring(unit_name), pos, rot)
	return unit
end

function GrenadeCrateBase:set_server_information(peer_id)
	self._server_information = {owner_peer_id = peer_id}
end

function GrenadeCrateBase:server_information()
	return self._server_information
end

function GrenadeCrateBase:init(unit)
	UnitBase.init(self, unit, false)
	self._unit = unit
	self._max_grenade_amount = tweak_data.upgrades.grenade_crate_base
	self._unit:sound_source():post_event("ammo_bag_drop")
	self:setup()
end

function GrenadeCrateBase:setup()
	self._grenade_amount = tweak_data.upgrades.grenade_crate_base
	self._empty = false
	self:_set_visual_stage()
	if Network:is_server() then
		local from_pos = self._unit:position() + self._unit:rotation():z() * 10
		local to_pos = self._unit:position() + self._unit:rotation():z() * -10
		local ray = self._unit:raycast("ray", from_pos, to_pos, "slot_mask", managers.slot:get_mask("world_geometry"))
		if ray then
			self._attached_data = {}
			self._attached_data.body = ray.body
			self._attached_data.position = ray.body:position()
			self._attached_data.rotation = ray.body:rotation()
			self._attached_data.index = 1
			self._attached_data.max_index = 3
			self._unit:set_extension_update_enabled(Idstring("base"), true)
		end
	end
end

function GrenadeCrateBase:update(unit, t, dt)
	self:_check_body()
end

function GrenadeCrateBase:_check_body()
	if self._is_dynamic then
		return
	end
	if not alive(self._attached_data.body) then
		self:server_set_dynamic()
		return
	end
	if self._attached_data.index == 1 then
		if not self._attached_data.body:enabled() then
			self:server_set_dynamic()
		end
	elseif self._attached_data.index == 2 then
		if not mrotation.equal(self._attached_data.rotation, self._attached_data.body:rotation()) then
			self:server_set_dynamic()
		end
	elseif self._attached_data.index == 3 and mvector3.not_equal(self._attached_data.position, self._attached_data.body:position()) then
		self:server_set_dynamic()
	end
	self._attached_data.index = (self._attached_data.index < self._attached_data.max_index and self._attached_data.index or 0) + 1
end

function GrenadeCrateBase:server_set_dynamic()
	self:_set_dynamic()
	if managers.network:session() then
		managers.network:session():send_to_peers_synched("sync_unit_event_id_8", self._unit, "base", 2)
	end
end

function GrenadeCrateBase:sync_net_event(event_id)
	if event_id == 1 then
		self:sync_grenade_taken(1)
	elseif event_id == 2 then
		self:_set_dynamic()
	end
end

function GrenadeCrateBase:_set_dynamic()
	self._is_dynamic = true
	self._unit:body("dynamic"):set_enabled(true)
end

function GrenadeCrateBase:take_grenade(unit)
	if self._empty then
		return
	end
	local can_take_grenade = self:_can_take_grenade() and 1 or 0
	if can_take_grenade == 1 then
		unit:sound():play("pickup_ammo")
		managers.player:add_grenade_amount(1)
		managers.network:session():send_to_peers_synched("sync_unit_event_id_8", self._unit, "base", 1)
		self._grenade_amount = self._grenade_amount - 1
		print("Took " .. 1 .. " grenades, " .. self._grenade_amount .. " left")
	end
	if 0 >= self._grenade_amount then
		self:_set_empty()
	end
	self:_set_visual_stage()
	return can_take_grenade
end

function GrenadeCrateBase:_set_visual_stage()
	if alive(self._unit) and self._unit:damage() then
		local state = "state_" .. tostring(math.clamp(self._max_grenade_amount - self._grenade_amount, 1, self._max_grenade_amount))
		if self._unit:damage():has_sequence(state) then
			self._unit:damage():run_sequence_simple(state)
		end
	end
end

function GrenadeCrateBase:sync_grenade_taken(amount)
	self._grenade_amount = self._grenade_amount - amount
	if self._grenade_amount <= 0 then
		self:_set_empty()
	end
	self:_set_visual_stage()
end

function GrenadeCrateBase:_can_take_grenade(unit)
	if self._empty or self._grenade_amount < 1 or managers.player:got_max_grenades() then
		return false
	end
	return true
end

function GrenadeCrateBase:_set_empty()
	self._empty = true
	if alive(self._unit) then
		self._unit:interaction():set_active(false)
	end
end

function GrenadeCrateBase:save(data)
	local state = {}
	state.grenade_amount = self._grenade_amount
	state.is_dynamic = self._is_dynamic
	data.GrenadeCrateBase = state
end

function GrenadeCrateBase:load(data)
	local state = data.GrenadeCrateBase
	self._grenade_amount = state.grenade_amount
	if state.is_dynamic then
		self:_set_dynamic()
	end
	if self._grenade_amount <= 0 then
		self:_set_empty()
	end
	self:_set_visual_stage()
end

function GrenadeCrateBase:destroy()
end
