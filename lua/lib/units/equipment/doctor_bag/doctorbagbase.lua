DoctorBagBase = DoctorBagBase or class(UnitBase)

function DoctorBagBase.spawn(pos, rot, amount_upgrade_lvl)
	local unit_name = "units/payday2/equipment/gen_equipment_medicbag/gen_equipment_medicbag"
	local unit = World:spawn_unit(Idstring(unit_name), pos, rot)
	managers.network:session():send_to_peers_synched("sync_doctor_bag_setup", unit, amount_upgrade_lvl)
	unit:base():setup(amount_upgrade_lvl)
	return unit
end

function DoctorBagBase:set_server_information(peer_id)
	self._server_information = {owner_peer_id = peer_id}
	managers.network:game():member(peer_id):peer():set_used_deployable(true)
end

function DoctorBagBase:server_information()
	return self._server_information
end

function DoctorBagBase:init(unit)
	UnitBase.init(self, unit, false)
	self._unit = unit
	self._unit:sound_source():post_event("ammo_bag_drop")
	self._max_amount = tweak_data.upgrades.doctor_bag_base + managers.player:upgrade_value_by_level("doctor_bag", "amount_increase", 1)
end

function DoctorBagBase:sync_setup(amount_upgrade_lvl)
	self:setup(amount_upgrade_lvl)
end

function DoctorBagBase:setup(amount_upgrade_lvl)
	self._amount = tweak_data.upgrades.doctor_bag_base + managers.player:upgrade_value_by_level("doctor_bag", "amount_increase", amount_upgrade_lvl)
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

function DoctorBagBase:update(unit, t, dt)
	self:_check_body()
end

function DoctorBagBase:_check_body()
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

function DoctorBagBase:server_set_dynamic()
	self:_set_dynamic()
	if managers.network:session() then
		managers.network:session():send_to_peers_synched("sync_unit_event_id_8", self._unit, "base", 1)
	end
end

function DoctorBagBase:sync_net_event(event_id)
	self:_set_dynamic()
end

function DoctorBagBase:_set_dynamic()
	self._is_dynamic = true
	self._unit:body("dynamic"):set_enabled(true)
end

function DoctorBagBase:take(unit)
	if self._empty then
		return
	end
	local taken = self:_take(unit)
	if 0 < taken then
		unit:sound():play("pickup_ammo")
		managers.network:session():send_to_peers_synched("sync_doctor_bag_taken", self._unit, taken)
	end
	if 0 >= self._amount then
		self:_set_empty()
	else
		self:_set_visual_stage()
	end
	return 0 < taken
end

function DoctorBagBase:_set_visual_stage()
	local percentage = self._amount / self._max_amount
	if self._unit:damage() then
		local state = "state_" .. math.ceil(percentage * 4)
		if self._unit:damage():has_sequence(state) then
			self._unit:damage():run_sequence_simple(state)
		end
	end
end

function DoctorBagBase:sync_taken(amount)
	self._amount = self._amount - amount
	if self._amount <= 0 then
		self:_set_empty()
	else
		self:_set_visual_stage()
	end
end

function DoctorBagBase:_take(unit)
	local taken = 1
	self._amount = self._amount - taken
	unit:character_damage():recover_health()
	return taken
end

function DoctorBagBase:_set_empty()
	self._empty = true
	self._unit:set_slot(0)
end

function DoctorBagBase:save(data)
	local state = {}
	state.amount = self._amount
	state.is_dynamic = self._is_dynamic
	data.DoctorBagBase = state
end

function DoctorBagBase:load(data)
	local state = data.DoctorBagBase
	self._amount = state.amount
	if state.is_dynamic then
		self:_set_dynamic()
	end
	self:_set_visual_stage()
end

function DoctorBagBase:destroy()
end
