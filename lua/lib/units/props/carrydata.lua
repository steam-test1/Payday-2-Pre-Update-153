CarryData = CarryData or class()

function CarryData:init(unit)
	self._unit = unit
	self._dye_initiated = false
	self._has_dye_pack = false
	self._dye_value_multiplier = 100
	if self._carry_id then
		self._value = managers.money:get_bag_value(self._carry_id)
	else
		self._value = tweak_data:get_value("money_manager", "bag_values", "default")
	end
end

function CarryData:set_mission_element(mission_element)
	self._mission_element = mission_element
end

function CarryData:trigger_load(instigator)
	if not self._mission_element then
		return
	end
	self._mission_element:trigger("load", instigator)
end

function CarryData:update(unit, t, dt)
	if not Network:is_server() then
		return
	end
	if self._dye_risk and t > self._dye_risk.next_t then
		self:_check_dye_explode()
	end
end

function CarryData:_check_dye_explode()
	local chance = math.rand(1)
	if chance < 0.25 then
		self._dye_risk = nil
		self:_dye_exploded()
		managers.network:session():send_to_peers_synched("sync_bag_dye_pack_exploded", self._unit)
		return
	end
	self._dye_risk.next_t = Application:time() + 2 + math.random(3)
end

function CarryData:sync_dye_exploded()
	self:_dye_exploded()
end

function CarryData:_dye_exploded()
	print("CarryData DYE BOOM")
	self._value = self._value * (1 - self._dye_value_multiplier / 100)
	self._value = math.round(self._value)
	self._has_dye_pack = false
	World:effect_manager():spawn({
		effect = Idstring("effects/payday2/particles/dye_pack/dye_pack_smoke"),
		parent = self._unit:orientation_object()
	})
end

function CarryData:clbk_out_of_world()
	if self._bodies_to_revert then
		for i_body, body in ipairs(self._bodies_to_revert) do
			body:set_dynamic()
		end
		self._bodies_to_revert = nil
		self._register_out_of_world_dynamic_clbk_id = nil
		return
	elseif self._unit:position().z < PlayerMovement.OUT_OF_WORLD_Z then
		self._bodies_to_revert = {}
		local bodies = self._unit:num_bodies()
		for i_body = 0, bodies - 1 do
			local body = self._unit:body(i_body)
			if body:enabled() and body:dynamic() then
				table.insert(self._bodies_to_revert, body)
				body:set_keyframed()
			end
		end
		local tracker = managers.navigation:create_nav_tracker(self._unit:position(), false)
		self._unit:set_position(tracker:field_position())
		managers.navigation:destroy_nav_tracker(tracker)
		self._register_out_of_world_dynamic_clbk_id = "BagOutOfWorldDynamic" .. tostring(self._unit:key())
		managers.enemy:add_delayed_clbk(self._register_out_of_world_dynamic_clbk_id, callback(self, self, "clbk_out_of_world"), TimerManager:game():time() + 0.2)
		self._register_out_of_world_clbk_id = nil
		return
	end
	managers.enemy:add_delayed_clbk(self._register_out_of_world_clbk_id, callback(self, self, "clbk_out_of_world"), TimerManager:game():time() + 2)
end

function CarryData:carry_id()
	return self._carry_id
end

function CarryData:set_carry_id(carry_id)
	self._carry_id = carry_id
	self._register_steal_SO_clbk_id = "CarryDataregiserSO" .. tostring(self._unit:key())
	managers.enemy:add_delayed_clbk(self._register_steal_SO_clbk_id, callback(self, self, "clbk_register_steal_SO"), 0)
end

function CarryData:clbk_register_steal_SO(carry_id)
	self._register_steal_SO_clbk_id = nil
	self:_chk_register_steal_SO()
end

function CarryData:set_dye_initiated(initiated)
	self._dye_initiated = initiated
end

function CarryData:dye_initiated()
	return self._dye_initiated
end

function CarryData:has_dye_pack()
	return self._has_dye_pack
end

function CarryData:dye_value_multiplier()
	return self._dye_value_multiplier
end

function CarryData:set_dye_pack_data(dye_initiated, has_dye_pack, dye_value_multiplier)
	self._dye_initiated = dye_initiated
	self._has_dye_pack = has_dye_pack
	self._dye_value_multiplier = dye_value_multiplier
	if not Network:is_server() then
		return
	end
	if self._has_dye_pack then
		self._dye_risk = {}
		self._dye_risk.next_t = Application:time() + 2 + math.random(3)
	end
end

function CarryData:dye_pack_data()
	return self._dye_initiated, self._has_dye_pack, self._dye_value_multiplier
end

function CarryData:_disable_dye_pack()
	self._dye_risk = false
end

function CarryData:value()
	return self._value
end

function CarryData:set_value(value)
	self._value = value
end

function CarryData:sequence_clbk_secured()
	self:_disable_dye_pack()
end

function CarryData:_unregister_steal_SO()
	if not self._steal_SO_data then
		return
	end
	if self._steal_SO_data.SO_registered then
		managers.groupai:state():remove_special_objective(self._steal_SO_data.SO_id)
		managers.groupai:state():unregister_loot(self._unit:key())
	elseif self._steal_SO_data.thief then
		local thief = self._steal_SO_data.thief
		self._steal_SO_data.thief = nil
		if self._steal_SO_data.picked_up then
			self:unlink()
		end
		if alive(thief) then
			thief:brain():set_objective(nil)
		end
	end
	self._steal_SO_data = nil
end

function CarryData:_chk_register_steal_SO()
	if not Network:is_server() or not managers.navigation:is_data_ready() then
		return
	end
	local tweak_info = tweak_data.carry[self._carry_id]
	local AI_carry = tweak_info.AI_carry
	if not AI_carry then
		return
	end
	if self._steal_SO_data then
		return
	end
	local body = self._unit:body("hinge_body_1") or self._unit:body(0)
	if not self._has_body_activation_clbk then
		self._has_body_activation_clbk = {
			[body:key()] = true
		}
		self._unit:add_body_activation_callback(callback(self, self, "clbk_body_active_state"))
		body:set_activate_tag(Idstring("bag_moving"))
		body:set_deactivate_tag(Idstring("bag_still"))
	end
	local is_body_active = body:active()
	if is_body_active then
		return
	end
	local SO_category = AI_carry.SO_category
	local SO_filter = managers.navigation:convert_SO_AI_group_to_access(SO_category)
	local tracker_pickup = managers.navigation:create_nav_tracker(self._unit:position(), false)
	local pickup_nav_seg = tracker_pickup:nav_segment()
	local pickup_pos = tracker_pickup:field_position()
	local pickup_area = managers.groupai:state():get_area_from_nav_seg_id(pickup_nav_seg)
	managers.navigation:destroy_nav_tracker(tracker_pickup)
	if pickup_area.enemy_loot_drop_points then
		return
	end
	local drop_pos, drop_nav_seg, drop_area
	local drop_point = managers.groupai:state():get_safe_enemy_loot_drop_point(pickup_nav_seg)
	if drop_point then
		drop_pos = mvector3.copy(drop_point.pos)
		drop_nav_seg = drop_point.nav_seg
		drop_area = drop_point.area
	elseif not self._register_steal_SO_clbk_id then
		self._register_steal_SO_clbk_id = "CarryDataregiserSO" .. tostring(self._unit:key())
		managers.enemy:add_delayed_clbk(self._register_steal_SO_clbk_id, callback(self, self, "clbk_register_steal_SO"), TimerManager:game():time() + 10)
		return
	end
	local drop_objective = {
		type = "act",
		pose = "crouch",
		haste = "walk",
		nav_seg = drop_nav_seg,
		pos = drop_pos,
		area = drop_area,
		interrupt_dis = 700,
		interrupt_health = 0.9,
		fail_clbk = callback(self, self, "on_secure_SO_failed"),
		complete_clbk = callback(self, self, "on_secure_SO_completed"),
		action = {
			type = "act",
			variant = "untie",
			body_part = 1,
			align_sync = true
		},
		action_duration = 2
	}
	local pickup_objective = {
		type = "act",
		haste = "run",
		pose = "crouch",
		destroy_clbk_key = false,
		nav_seg = pickup_nav_seg,
		area = pickup_area,
		pos = pickup_pos,
		interrupt_dis = 700,
		interrupt_health = 0.9,
		fail_clbk = callback(self, self, "on_pickup_SO_failed"),
		complete_clbk = callback(self, self, "on_pickup_SO_completed"),
		action = {
			type = "act",
			variant = "untie",
			body_part = 1,
			align_sync = true
		},
		action_duration = math.lerp(1, 2.5, math.random()),
		followup_objective = drop_objective
	}
	local so_descriptor = {
		objective = pickup_objective,
		base_chance = 1,
		chance_inc = 0,
		interval = 0,
		search_pos = pickup_objective.pos,
		verification_clbk = callback(self, self, "clbk_pickup_SO_verification"),
		usage_amount = 1,
		AI_group = AI_carry.SO_category,
		admin_clbk = callback(self, self, "on_pickup_SO_administered")
	}
	local so_id = "carrysteal" .. tostring(self._unit:key())
	self._steal_SO_data = {
		SO_id = so_id,
		SO_registered = true,
		pickup_area = pickup_area,
		picked_up = false,
		pickup_objective = pickup_objective
	}
	managers.groupai:state():add_special_objective(so_id, so_descriptor)
	managers.groupai:state():register_loot(self._unit, pickup_area)
end

function CarryData:clbk_pickup_SO_verification(candidate_unit)
	if not self._steal_SO_data or not self._steal_SO_data.SO_id then
		debug_pause_unit(self._unit, "[CarryData:clbk_pickup_SO_verification] SO is not registered", self._unit, candidate_unit, inspect(self._steal_SO_data))
		return
	end
	if candidate_unit:movement():cool() then
		return
	end
	local nav_seg = candidate_unit:movement():nav_tracker():nav_segment()
	if not self._steal_SO_data.pickup_area.nav_segs[nav_seg] then
		return
	end
	return true
end

function CarryData:on_pickup_SO_administered(thief)
	if self._steal_SO_data.thief then
		debug_pause("[CarryData:on_pickup_SO_administered] Already had a thief!!!!", thief, self._steal_SO_data.thief)
	end
	self._steal_SO_data.thief = thief
	self._steal_SO_data.SO_registered = false
	managers.groupai:state():unregister_loot(self._unit:key())
end

function CarryData:on_pickup_SO_completed(thief)
	if thief ~= self._steal_SO_data.thief then
		debug_pause_unit(thief, "[CarryData:on_pickup_SO_completed] idiot thinks he is stealing", thief)
		return
	end
	self._steal_SO_data.picked_up = true
	self:link_to(thief)
end

function CarryData:on_pickup_SO_failed(thief)
	if not self._steal_SO_data.thief then
		return
	end
	if thief ~= self._steal_SO_data.thief then
		debug_pause_unit(thief, "[CarryData:on_pickup_SO_failed] idiot thinks he is stealing", thief)
		return
	end
	self._steal_SO_data = nil
	self:_chk_register_steal_SO()
end

function CarryData:on_secure_SO_completed(thief)
	if thief ~= self._steal_SO_data.thief then
		debug_pause_unit(sympathy_civ, "[CarryData:on_secure_SO_completed] idiot thinks he is stealing", thief)
		return
	end
	self._steal_SO_data = nil
	managers.mission:call_global_event("loot_lost")
	self._steal_SO_data = nil
	self:unlink()
end

function CarryData:on_secure_SO_failed(thief)
	if not self._steal_SO_data.thief then
		return
	end
	if thief ~= self._steal_SO_data.thief then
		debug_pause_unit(thief, "[CarryData:on_pickup_SO_failed] idiot thinks he is stealing", thief)
		return
	end
	self._steal_SO_data = nil
	self:_chk_register_steal_SO()
	self:unlink()
end

function CarryData:link_to(parent_unit)
	local body = self._unit:body("hinge_body_1") or self._unit:body(0)
	body:set_keyframed()
	local parent_obj_name = Idstring("Neck")
	parent_unit:link(parent_obj_name, self._unit)
	local parent_obj = parent_unit:get_object(parent_obj_name)
	local parent_obj_rot = parent_obj:rotation()
	local world_pos = parent_obj:position() - parent_obj_rot:z() * 30 - parent_obj_rot:y() * 10
	self._unit:set_position(world_pos)
	local world_rot = Rotation(parent_obj_rot:x(), -parent_obj_rot:z())
	self._unit:set_rotation(world_rot)
	self._disabled_collisions = {}
	local nr_bodies = self._unit:num_bodies()
	for i_body = 0, nr_bodies - 1 do
		local body = self._unit:body(i_body)
		if body:collisions_enabled() then
			table.insert(self._disabled_collisions, body)
			body:set_collisions_enabled(false)
		end
	end
	if Network:is_server() then
		managers.network:session():send_to_peers_synched("loot_link", self._unit, parent_unit)
	end
end

function CarryData:unlink()
	self._unit:unlink()
	local body = self._unit:body("hinge_body_1") or self._unit:body(0)
	body:set_dynamic()
	if self._disabled_collisions then
		for _, body in ipairs(self._disabled_collisions) do
			body:set_collisions_enabled(true)
		end
		self._disabled_collisions = nil
	end
	if Network:is_server() then
		managers.network:session():send_to_peers_synched("loot_link", self._unit, self._unit)
	end
end

function CarryData:clbk_body_active_state(tag, unit, body, activated)
	if not self._has_body_activation_clbk[body:key()] then
		return
	end
	if activated then
		if not self._steal_SO_data or not self._steal_SO_data.picked_up then
			self:_unregister_steal_SO()
		end
		if not self._register_out_of_world_clbk_id then
			self._register_out_of_world_clbk_id = "BagOutOfWorld" .. tostring(self._unit:key())
			managers.enemy:add_delayed_clbk(self._register_out_of_world_clbk_id, callback(self, self, "clbk_out_of_world"), TimerManager:game():time() + 2)
		end
	else
		self:_chk_register_steal_SO()
		if self._register_out_of_world_clbk_id then
			managers.enemy:remove_delayed_clbk(self._register_out_of_world_clbk_id)
			self._register_out_of_world_clbk_id = nil
		end
	end
end

function CarryData:clbk_send_link()
	if alive(self._unit) and self._steal_SO_data or not self._steal_SO_data.thief and self._steal_SO_data.picked_up then
		managers.network:session():send_to_peers_synched("loot_link", self._unit, self._steal_SO_data.thief)
	end
end

function CarryData:save(data)
	local state = {}
	state.carry_id = self._carry_id
	state.value = self._value
	state.dye_initiated = self._dye_initiated
	state.has_dye_pack = self._has_dye_pack
	state.dye_value_multiplier = self._dye_value_multiplier
	if self._steal_SO_data and self._steal_SO_data.picked_up then
		managers.enemy:add_delayed_clbk("send_loot_link" .. tostring(self._unit:key()), callback(self, self, "clbk_send_link"), TimerManager:game():time() + 0.1)
	end
	data.CarryData = state
end

function CarryData:load(data)
	local state = data.CarryData
	self._carry_id = state.carry_id
	self._value = state.value
	self._dye_initiated = state.dye_initiated
	self._has_dye_pack = state.has_dye_pack
	self._dye_value_multiplier = state.dye_value_multiplier
end

function CarryData:destroy()
	if self._register_steal_SO_clbk_id then
		managers.enemy:remove_delayed_clbk(self._register_steal_SO_clbk_id)
		self._register_steal_SO_clbk_id = nil
	end
	if self._register_out_of_world_clbk_id then
		managers.enemy:remove_delayed_clbk(self._register_out_of_world_clbk_id)
		self._register_out_of_world_clbk_id = nil
	end
	if self._register_out_of_world_dynamic_clbk_id then
		managers.enemy:remove_delayed_clbk(self._register_out_of_world_dynamic_clbk_id)
		self._register_out_of_world_dynamic_clbk_id = nil
	end
	self:_unregister_steal_SO()
end
