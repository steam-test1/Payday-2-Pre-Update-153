BaseInteractionExt = BaseInteractionExt or class()
BaseInteractionExt.SKILL_IDS = {}
BaseInteractionExt.SKILL_IDS.none = 1
BaseInteractionExt.SKILL_IDS.basic = 2
BaseInteractionExt.SKILL_IDS.aced = 3
BaseInteractionExt.INFO_IDS = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128
}

function BaseInteractionExt:init(unit)
	self._unit = unit
	self._unit:set_extension_update_enabled(Idstring("interaction"), false)
	self:refresh_material()
	self:set_tweak_data(self.tweak_data)
	self:set_active(self._tweak_data.start_active or self._tweak_data.start_active == nil and true)
	self:_upd_interaction_topology()
end

local ids_material = Idstring("material")

function BaseInteractionExt:refresh_material()
	self._materials = {}
	local all_materials = self._unit:get_objects_by_type(ids_material)
	for _, m in ipairs(all_materials) do
		if m:variable_exists(Idstring("contour_color")) then
			table.insert(self._materials, m)
		end
	end
end

function BaseInteractionExt:external_upd_interaction_topology()
	self:_upd_interaction_topology()
end

function BaseInteractionExt:_upd_interaction_topology()
	if self._tweak_data.interaction_obj then
		self._interact_obj = self._unit:get_object(self._tweak_data.interaction_obj)
	else
		self._interact_obj = self._interact_object and self._unit:get_object(Idstring(self._interact_object))
	end
	self._interact_position = self._interact_obj and self._interact_obj:position() or self._unit:position()
	local rotation = self._interact_obj and self._interact_obj:rotation() or self._unit:rotation()
	self._interact_axis = self._tweak_data.axis and rotation[self._tweak_data.axis](rotation) or nil
	self:_update_interact_position()
	self:_setup_ray_objects()
end

function BaseInteractionExt:set_tweak_data(id)
	local contour_id = self._contour_id
	local selected_contour_id = self._selected_contour_id
	if contour_id then
		self._unit:contour():remove_by_id(contour_id)
		self._contour_id = nil
	end
	if selected_contour_id then
		self._unit:contour():remove_by_id(selected_contour_id)
		self._selected_contour_id = nil
	end
	self.tweak_data = id
	self._tweak_data = tweak_data.interaction[id]
	if self._active and self._tweak_data.contour_preset then
		self._contour_id = self._unit:contour():add(self._tweak_data.contour_preset)
	end
	if self._active and self._is_selected and self._tweak_data.contour_preset_selected then
		self._selected_contour_id = self._unit:contour():add(self._tweak_data.contour_preset_selected)
	end
	self:_upd_interaction_topology()
	if alive(managers.interaction:active_object()) and self._unit == managers.interaction:active_object() then
		self:set_dirty(true)
	end
end

function BaseInteractionExt:set_dirty(dirty)
	self._dirty = dirty
end

function BaseInteractionExt:dirty()
	return self._dirty
end

function BaseInteractionExt:interact_position()
	self:_update_interact_position()
	return self._interact_position
end

function BaseInteractionExt:interact_axis()
	self:_update_interact_axis()
	return self._interact_axis
end

function BaseInteractionExt:_setup_ray_objects()
	if self._ray_object_names then
		self._ray_objects = {
			self._interact_obj or self._unit:orientation_object()
		}
		for _, object_name in ipairs(self._ray_object_names) do
			table.insert(self._ray_objects, self._unit:get_object(Idstring(object_name)))
		end
	end
end

function BaseInteractionExt:ray_objects()
	return self._ray_objects
end

function BaseInteractionExt:_update_interact_position()
	if self._unit:moving() or self._tweak_data.force_update_position then
		self._interact_position = self._interact_obj and self._interact_obj:position() or self._unit:position()
	end
end

function BaseInteractionExt:_update_interact_axis()
	if self._tweak_data.axis and self._unit:moving() then
		local rotation = self._interact_obj and self._interact_obj:rotation() or self._unit:rotation()
		self._interact_axis = self._tweak_data.axis and rotation[self._tweak_data.axis](rotation) or nil
	end
end

function BaseInteractionExt:interact_distance()
	return self._tweak_data.interact_distance or tweak_data.interaction.INTERACT_DISTANCE
end

function BaseInteractionExt:interact_dont_interupt_on_distance()
	return self._tweak_data.interact_dont_interupt_on_distance or false
end

function BaseInteractionExt:update(distance_to_player)
end

local is_PS3 = SystemInfo:platform() == Idstring("PS3")

function BaseInteractionExt:_btn_interact()
	if not managers.menu:is_pc_controller() then
		return nil
	end
	local type = managers.controller:get_default_wrapper_type()
	return "[" .. managers.controller:get_settings(type):get_connection("interact"):get_input_name_list()[1] .. "]"
end

function BaseInteractionExt:can_select(player)
	if not self:_has_required_upgrade(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end
	if not self:_has_required_deployable() then
		return false
	end
	if not self:_is_in_required_state() then
		return false
	end
	if self._tweak_data.special_equipment_block and managers.player:has_special_equipment(self._tweak_data.special_equipment_block) then
		return false
	end
	return true
end

function BaseInteractionExt:selected(player)
	if not self:can_select(player) then
		return
	end
	self._is_selected = true
	local string_macros = {}
	self:_add_string_macros(string_macros)
	local text_id = not self._tweak_data.text_id and alive(self._unit) and self._unit:base().interaction_text_id and self._unit:base():interaction_text_id()
	local text = managers.localization:text(text_id, string_macros)
	local icon = self._tweak_data.icon
	if self._tweak_data.special_equipment and not managers.player:has_special_equipment(self._tweak_data.special_equipment) then
		local has_special_equipment = false
		if self._tweak_data.possible_special_equipment then
			for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
				if managers.player:has_special_equipment(special_equipment) then
					has_special_equipment = true
					break
				end
			end
		end
		if not has_special_equipment then
			text = managers.localization:text(self._tweak_data.equipment_text_id, string_macros)
			icon = self.no_equipment_icon or self._tweak_data.no_equipment_icon or icon
		end
	end
	if self._tweak_data.contour_preset or self._tweak_data.contour_preset_selected then
		if not self._selected_contour_id and self._tweak_data.contour_preset_selected and self._tweak_data.contour_preset ~= self._tweak_data.contour_preset_selected then
			self._selected_contour_id = self._unit:contour():add(self._tweak_data.contour_preset_selected)
		end
	else
		self:set_contour("selected_color")
	end
	managers.hud:show_interact({text = text, icon = icon})
	return true
end

function BaseInteractionExt:_add_string_macros(macros)
	macros.BTN_INTERACT = self:_btn_interact()
end

function BaseInteractionExt:unselect()
	self._is_selected = nil
	if self._tweak_data.contour_preset or self._tweak_data.contour_preset_selected then
		if self._selected_contour_id then
			self._unit:contour():remove_by_id(self._selected_contour_id)
		end
		self._selected_contour_id = nil
	else
		self:set_contour("standard_color")
	end
end

function BaseInteractionExt:_has_required_upgrade(movement_state)
	if not movement_state then
		return true
	end
	if movement_state == "mask_off" then
		if self._tweak_data.requires_mask_off_upgrade then
			local category = self._tweak_data.requires_mask_off_upgrade.category
			local upgrade = self._tweak_data.requires_mask_off_upgrade.upgrade
			return managers.player:has_category_upgrade(category, upgrade)
		end
		return false
	end
	if self._tweak_data.requires_upgrade then
		local category = self._tweak_data.requires_upgrade.category
		local upgrade = self._tweak_data.requires_upgrade.upgrade
		return managers.player:has_category_upgrade(category, upgrade)
	end
	return true
end

function BaseInteractionExt:_has_required_deployable()
	if self._tweak_data.required_deployable then
		return managers.player:has_deployable_left(self._tweak_data.required_deployable)
	end
	return true
end

function BaseInteractionExt:_allowed_in_movement_state(movement_state)
	if not movement_state then
		return false
	end
	return true
end

function BaseInteractionExt:_is_in_required_state()
	return true
end

function BaseInteractionExt:_interact_say(data)
	local player = data[1]
	local say_line = data[2]
	self._interact_say_clbk = nil
	player:sound():say(say_line, true)
end

function BaseInteractionExt:interact_start(player)
	local blocked, skip_hint, custom_hint = self:_interact_blocked(player)
	if blocked then
		if not skip_hint and (custom_hint or self._tweak_data.blocked_hint) then
			managers.hint:show_hint(custom_hint or self._tweak_data.blocked_hint)
		end
		return false
	end
	local has_equipment = not self._tweak_data.special_equipment and true or managers.player:has_special_equipment(self._tweak_data.special_equipment)
	local sound = has_equipment and (self._tweak_data.say_waiting or "") or self.say_waiting
	if sound and sound ~= "" then
		local delay = (self._tweak_data.timer or 0) * managers.player:toolset_value()
		delay = delay / 3 + math.random() * delay / 3
		local say_t = Application:time() + delay
		self._interact_say_clbk = "interact_say_waiting"
		managers.enemy:add_delayed_clbk(self._interact_say_clbk, callback(self, self, "_interact_say", {player, sound}), say_t)
	end
	if self._tweak_data.timer then
		if not self:can_interact(player) then
			if self._tweak_data.blocked_hint then
				managers.hint:show_hint(self._tweak_data.blocked_hint)
			end
			return false
		end
		local timer = self:_get_timer()
		if timer ~= 0 then
			self:_post_event(player, "sound_start")
			self:_at_interact_start(player, timer)
			return false, timer
		end
	end
	return self:interact(player)
end

function BaseInteractionExt:_get_timer()
	local modified_timer = self:_get_modified_timer()
	if modified_timer then
		return modified_timer
	end
	local multiplier = 1
	if self._tweak_data.upgrade_timer_multiplier then
		multiplier = managers.player:upgrade_value(self._tweak_data.upgrade_timer_multiplier.category, self._tweak_data.upgrade_timer_multiplier.upgrade, 1)
	end
	if managers.player:has_category_upgrade("player", "level_interaction_timer_multiplier") then
		local data = managers.player:upgrade_value("player", "level_interaction_timer_multiplier") or {}
		local player_level = managers.experience:current_level() or 0
		multiplier = multiplier * (1 - (data[1] or 0) * math.ceil(player_level / (data[2] or 1)))
	end
	return self._tweak_data.timer * multiplier * managers.player:toolset_value()
end

function BaseInteractionExt:_get_modified_timer()
	return nil
end

function BaseInteractionExt:check_interupt()
	return false
end

function BaseInteractionExt:interact_interupt(player, complete)
	local tweak_data_id = self._tweak_data_at_interact_start ~= self.tweak_data and self._tweak_data_at_interact_start
	self:_post_event(player, "sound_interupt", tweak_data_id)
	if self._interact_say_clbk then
		managers.enemy:remove_delayed_clbk(self._interact_say_clbk)
		self._interact_say_clbk = nil
	end
	self:_at_interact_interupt(player, complete)
end

function BaseInteractionExt:_post_event(player, sound_type, tweak_data_id)
	if not alive(player) then
		return
	end
	if player ~= managers.player:player_unit() then
		return
	end
	local tweak_data_table = self._tweak_data
	if tweak_data_id then
		tweak_data_table = tweak_data.interaction[tweak_data_id]
	end
	if tweak_data_table[sound_type] then
		player:sound():play(tweak_data_table[sound_type])
	end
end

function BaseInteractionExt:_at_interact_start()
	self._tweak_data_at_interact_start = self.tweak_data
end

function BaseInteractionExt:_at_interact_interupt(player, complete)
	self._tweak_data_at_interact_start = nil
end

function BaseInteractionExt:interact(player)
	self._tweak_data_at_interact_start = nil
	self:_post_event(player, "sound_done")
end

function BaseInteractionExt:can_interact(player)
	if not self:_has_required_upgrade(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end
	if not self:_has_required_deployable() then
		return false
	end
	if self._tweak_data.special_equipment_block and managers.player:has_special_equipment(self._tweak_data.special_equipment_block) then
		return false
	end
	if not self._tweak_data.special_equipment or self._tweak_data.dont_need_equipment then
		return true
	end
	return managers.player:has_special_equipment(self._tweak_data.special_equipment)
end

function BaseInteractionExt:_interact_blocked(player)
	return false
end

function BaseInteractionExt:active()
	return self._active
end

function BaseInteractionExt:set_active(active, sync)
	if not active and self._active then
		managers.interaction:remove_object(self._unit)
		if self._tweak_data.contour_preset or self._tweak_data.contour_preset_selected then
			if self._contour_id and self._unit:contour() then
				self._unit:contour():remove_by_id(self._contour_id)
			end
			self._contour_id = nil
			if self._selected_contour_id and self._unit:contour() then
				self._unit:contour():remove_by_id(self._selected_contour_id)
			end
			self._selected_contour_id = nil
		elseif not self._tweak_data.no_contour then
			managers.occlusion:add_occlusion(self._unit)
		end
		self._is_selected = nil
	elseif active and not self._active then
		managers.interaction:add_object(self._unit)
		if self._tweak_data.contour_preset then
			if not self._contour_id then
				self._contour_id = self._unit:contour():add(self._tweak_data.contour_preset)
			end
		elseif not self._tweak_data.no_contour then
			managers.occlusion:remove_occlusion(self._unit)
		end
	end
	self._active = active
	if not self._tweak_data.contour_preset then
		self:set_contour("standard_color")
	end
	if sync and managers.network:session() then
		local u_id = self._unit:id()
		if u_id == -1 then
			local u_data = managers.enemy:get_corpse_unit_data_from_key(self._unit:key())
			if u_data then
				u_id = u_data.u_id
			else
				debug_pause_unit(self._unit, "[BaseInteractionExt:set_active] could not sync interaction state.", self._unit)
				return
			end
		end
		managers.network:session():send_to_peers_synched("interaction_set_active", self._unit, u_id, active, self.tweak_data, self._unit:contour() and self._unit:contour():is_flashing() or false)
	end
end

function BaseInteractionExt:set_outline_flash_state(state, sync)
	if self._contour_id then
		self._unit:contour():flash(self._contour_id, state and self._tweak_data.contour_flash_interval or nil)
		self:set_active(self._active, sync)
	end
end

local ids_contour_color = Idstring("contour_color")
local ids_contour_opacity = Idstring("contour_opacity")

function BaseInteractionExt:set_contour(color, opacity)
	if self._tweak_data.no_contour or self._contour_override then
		return
	end
	for _, m in ipairs(self._materials) do
		m:set_variable(ids_contour_color, tweak_data.contour[self._tweak_data.contour or "interactable"][color])
		m:set_variable(ids_contour_opacity, opacity or self._active and 1 or 0)
	end
end

function BaseInteractionExt:set_contour_override(state)
	self._contour_override = state
end

function BaseInteractionExt:save(data)
	local state = {}
	state.active = self._active
	if self.drop_in_sync_tweak_data then
		state.tweak_data = self.tweak_data
	end
	if self._unit:contour() and self._unit:contour():is_flashing() then
		state.is_flashing = true
	end
	data.InteractionExt = state
end

function BaseInteractionExt:load(data)
	local state = data.InteractionExt
	if state then
		self:set_active(state.active)
		if state.tweak_data then
			self:set_tweak_data(state.tweak_data)
		end
		if state.is_flashing and self._contour_id then
			self._unit:contour():flash(self._contour_id, self._tweak_data.contour_flash_interval)
		end
	end
end

function BaseInteractionExt:remove_interact()
	if not managers.interaction:active_object() or self._unit == managers.interaction:active_object() then
		managers.hud:remove_interact()
	end
end

function BaseInteractionExt:destroy()
	self:remove_interact()
	self:set_active(false, false)
	if self._unit == managers.interaction:active_object() then
		self:_post_event(managers.player:player_unit(), "sound_interupt")
	end
	if self._tweak_data.contour_preset then
	elseif not self._tweak_data.no_contour then
		managers.occlusion:add_occlusion(self._unit)
	end
	if self._interacting_units then
		for u_key, unit in pairs(self._interacting_units) do
			if alive(unit) then
				unit:base():remove_destroy_listener(self._interacting_unit_destroy_listener_key)
			end
		end
		self._interacting_units = nil
	end
end

UseInteractionExt = UseInteractionExt or class(BaseInteractionExt)

function UseInteractionExt:unselect()
	UseInteractionExt.super.unselect(self)
	managers.hud:remove_interact()
end

function UseInteractionExt:interact(player)
	if not self:can_interact(player) then
		return
	end
	UseInteractionExt.super.interact(self, player)
	if self._tweak_data.equipment_consume then
		managers.player:remove_special(self._tweak_data.special_equipment)
		if self._tweak_data.special_equipment == "planks" and Global.level_data.level_id == "secret_stash" then
			UseInteractionExt._saviour_count = (UseInteractionExt._saviour_count or 0) + 1
		end
	end
	if self._tweak_data.deployable_consume then
		managers.player:remove_equipment(self._tweak_data.required_deployable)
	end
	if self._tweak_data.sound_event then
		player:sound():play(self._tweak_data.sound_event)
	end
	self:remove_interact()
	if self._unit:damage() then
		self._unit:damage():run_sequence_simple("interact", {unit = player})
	end
	managers.network:session():send_to_peers_synched("sync_interacted", self._unit, -2, self.tweak_data, 1)
	if self._global_event then
		managers.mission:call_global_event(self._global_event, player)
	end
	self:set_active(false)
end

function UseInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	if not self._active then
		return
	end
	local player = managers.network:game():member(peer:id()):unit()
	if not skip_alive_check and not alive(player) then
		return
	end
	self:remove_interact()
	self:set_active(false)
	if self._unit:damage() then
		self._unit:damage():run_sequence_simple("interact", {unit = player})
	end
end

function UseInteractionExt:destroy()
	UseInteractionExt.super.destroy(self)
end

MultipleChoiceInteractionExt = MultipleChoiceInteractionExt or class(UseInteractionExt)

function MultipleChoiceInteractionExt:can_interact(player)
	if not self:_has_required_upgrade(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end
	if not self:_has_required_deployable() then
		return false
	end
	if self._tweak_data.special_equipment_block and managers.player:has_special_equipment(self._tweak_data.special_equipment_block) then
		return false
	end
	if not self._tweak_data.special_equipment or self._tweak_data.dont_need_equipment then
		return true
	end
	if managers.player:has_special_equipment(self._tweak_data.special_equipment) then
		return true
	end
	if self._tweak_data.possible_special_equipment then
		for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
			if managers.player:has_special_equipment(special_equipment) then
				return true
			end
		end
	end
	return false
end

function MultipleChoiceInteractionExt:interact(player)
	if self._tweak_data.dont_need_equipment then
		MultipleChoiceInteractionExt.super.interact(self, player)
		return
	end
	if not managers.player:has_special_equipment(self._tweak_data.special_equipment) then
		if self._tweak_data.possible_special_equipment then
			for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
				if managers.player:has_special_equipment(special_equipment) then
					managers.player:remove_special(special_equipment)
				end
			end
		end
		if self._unit:damage() then
			self._unit:damage():run_sequence_simple("wrong", {unit = player})
		end
		managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "interaction", 1)
		return
	end
	MultipleChoiceInteractionExt.super.interact(self, player)
	managers.player:remove_special(self._tweak_data.special_equipment)
end

function MultipleChoiceInteractionExt:sync_net_event(event_id, player)
	if self._unit:damage() then
		self._unit:damage():run_sequence_simple("wrong", {unit = player})
	end
end

TripMineInteractionExt = TripMineInteractionExt or class(UseInteractionExt)

function TripMineInteractionExt:interact(player)
	if not self:can_interact(player) then
		return false
	end
	TripMineInteractionExt.super.super.interact(self, player)
	local armed = not self._unit:base():armed()
	self._unit:base():set_armed(armed)
end

function TripMineInteractionExt:selected(player)
	local result = TripMineInteractionExt.super.selected(self, player)
	if result then
		self._unit:base():contour_selected()
	end
	return result
end

function TripMineInteractionExt:unselect()
	TripMineInteractionExt.super.unselect(self)
	self._unit:base():contour_unselected()
end

ECMJammerInteractionExt = ECMJammerInteractionExt or class(UseInteractionExt)

function ECMJammerInteractionExt:interact(player)
	if not self:can_interact(player) then
		return false
	end
	ECMJammerInteractionExt.super.super.interact(self, player)
	self._unit:base():set_feedback_active()
	self:remove_interact()
end

function ECMJammerInteractionExt:can_interact(player)
	return ECMJammerInteractionExt.super.can_interact(self, player) and self._unit:base():owner() == player
end

function ECMJammerInteractionExt:selected(player)
	if not self:can_interact(player) then
		return
	end
	local result = ECMJammerInteractionExt.super.selected(self, player)
	if result then
		self._unit:base():contour_selected()
	end
	return result
end

function ECMJammerInteractionExt:unselect()
	ECMJammerInteractionExt.super.unselect(self)
	self._unit:base():contour_unselected()
end

function ECMJammerInteractionExt:set_active(active, sync, ...)
	ECMJammerInteractionExt.super.set_active(self, active, sync, ...)
	self._unit:base():contour_interaction()
end

ReviveInteractionExt = ReviveInteractionExt or class(BaseInteractionExt)

function ReviveInteractionExt:init(unit, ...)
	self._wp_id = "ReviveInteractionExt" .. unit:id()
	ReviveInteractionExt.super.init(self, unit, ...)
end

function ReviveInteractionExt:_at_interact_start(player, timer)
	ReviveInteractionExt.super._at_interact_start(self, player, timer)
	if self.tweak_data == "revive" then
		self:_at_interact_start_revive(player, timer)
	elseif self.tweak_data == "free" then
		self:_at_interact_start_free(player)
	end
	self:set_waypoint_paused(true)
	managers.network:session():send_to_peers_synched("interaction_set_waypoint_paused", self._unit, true)
end

function ReviveInteractionExt:_at_interact_start_revive(player, timer)
	if self._unit:base().is_husk_player then
		local revive_rpc_params = {
			"start_revive_player",
			timer
		}
		self._unit:network():send_to_unit(revive_rpc_params)
	else
		self._unit:character_damage():pause_bleed_out()
	end
	if player:base().is_local_player then
		managers.achievment:set_script_data("player_reviving", true)
	end
end

function ReviveInteractionExt:_at_interact_start_free(player)
	if self._unit:base().is_husk_player then
		local revive_rpc_params = {
			"start_free_player"
		}
		self._unit:network():send_to_unit(revive_rpc_params)
	else
		self._unit:character_damage():pause_arrested_timer()
	end
end

function ReviveInteractionExt:_at_interact_interupt(player, complete)
	ReviveInteractionExt.super._at_interact_interupt(self, player, complete)
	if self.tweak_data == "revive" then
		self:_at_interact_interupt_revive(player)
	elseif self.tweak_data == "free" then
		self:_at_interact_interupt_free(player)
	end
	self:set_waypoint_paused(false)
	if self._unit:id() ~= -1 then
		managers.network:session():send_to_peers_synched("interaction_set_waypoint_paused", self._unit, false)
	end
end

function ReviveInteractionExt:_at_interact_interupt_revive(player)
	if self._unit:base().is_husk_player then
		local revive_rpc_params = {
			"interupt_revive_player"
		}
		self._unit:network():send_to_unit(revive_rpc_params)
	else
		self._unit:character_damage():unpause_bleed_out()
	end
	if player:base().is_local_player then
		managers.achievment:set_script_data("player_reviving", false)
	end
end

function ReviveInteractionExt:_at_interact_interupt_free(player)
	if self._unit:base().is_husk_player then
		local revive_rpc_params = {
			"interupt_free_player"
		}
		self._unit:network():send_to_unit(revive_rpc_params)
	else
		self._unit:character_damage():unpause_arrested_timer()
	end
end

function ReviveInteractionExt:set_waypoint_paused(paused)
	if self._active_wp then
		managers.hud:set_waypoint_timer_pause(self._wp_id, paused)
		if managers.criminals:character_data_by_unit(self._unit) then
			managers.hud:pause_teammate_timer(managers.criminals:character_data_by_unit(self._unit).panel_id, paused)
		end
	end
end

function ReviveInteractionExt:get_waypoint_time()
	if self._active_wp then
		local data = managers.hud:get_waypoint_data(self._wp_id)
		if data then
			return data.timer
		end
	end
	return nil
end

local is_win32 = SystemInfo:platform() == Idstring("WIN32")

function ReviveInteractionExt:set_active(active, sync, down_time)
	ReviveInteractionExt.super.set_active(self, active)
	if not managers.hud:exists("guis/player_hud") then
		return
	end
	local panel_id
	if managers.criminals:character_data_by_unit(self._unit) then
		panel_id = managers.criminals:character_data_by_unit(self._unit).panel_id
	end
	if self._active then
		local hint = self.tweak_data == "revive" and "teammate_downed" or "teammate_arrested"
		if hint == "teammate_downed" then
			managers.achievment:set_script_data("stand_together_fail", true)
		end
		local location_id = self._unit:movement():get_location_id()
		local location = location_id and " " .. managers.localization:text(location_id) or ""
		managers.hint:show_hint(hint, nil, false, {
			TEAMMATE = self._unit:base():nick_name(),
			LOCATION = location
		})
		if not self._active_wp then
			down_time = down_time or 999
			local text = managers.localization:text(self.tweak_data == "revive" and "debug_team_mate_need_revive" or "debug_team_mate_need_free")
			local icon = self.tweak_data == "revive" and "wp_revive" or "wp_rescue"
			if self.tweak_data == "revive" then
			end
			local timer = self._unit:base().is_husk_player and down_time or tweak_data.character[self._unit:base()._tweak_table].damage.DOWNED_TIME or self._unit:base().is_husk_player and tweak_data.player.damage.ARRESTED_TIME or tweak_data.character[self._unit:base()._tweak_table].damage.ARRESTED_TIME
			managers.hud:add_waypoint(self._wp_id, {
				text = text,
				icon = icon,
				unit = self._unit,
				distance = is_win32,
				present_timer = 1,
				timer = timer
			})
			self._active_wp = true
			managers.hud:start_teammate_timer(panel_id, timer)
		end
	elseif self._active_wp then
		managers.hud:remove_waypoint(self._wp_id)
		self._active_wp = false
		if panel_id then
			managers.hud:stop_teammate_timer(panel_id)
		end
	end
end

function ReviveInteractionExt:unselect()
	ReviveInteractionExt.super.unselect(self)
	managers.hud:remove_interact()
end

function ReviveInteractionExt:interact(reviving_unit)
	if reviving_unit and reviving_unit == managers.player:player_unit() then
		if not self:can_interact(reviving_unit) then
			return
		end
		if self._tweak_data.equipment_consume then
			managers.player:remove_special(self._tweak_data.special_equipment)
		end
		if self._tweak_data.sound_event then
			reviving_unit:sound():play(self._tweak_data.sound_event)
		end
		ReviveInteractionExt.super.interact(self, reviving_unit)
		managers.achievment:set_script_data("player_reviving", false)
		managers.player:activate_temporary_upgrade("temporary", "combat_medic_damage_multiplier")
		managers.player:activate_temporary_upgrade("temporary", "combat_medic_enter_steelsight_speed_multiplier")
	end
	self:remove_interact()
	if self._unit:damage() and self._unit:damage():has_sequence("interact") then
		self._unit:damage():run_sequence_simple("interact")
	end
	if self._unit:base().is_husk_player then
		local revive_rpc_params = {
			"revive_player",
			managers.player:upgrade_value("player", "revive_health_boost", 0),
			managers.player:upgrade_value("player", "revive_damage_reduction_level", 0)
		}
		managers.statistics:revived({npc = false, reviving_unit = reviving_unit})
		self._unit:network():send_to_unit(revive_rpc_params)
	else
		self._unit:character_damage():revive(reviving_unit)
		managers.statistics:revived({npc = true, reviving_unit = reviving_unit})
	end
	if Network:is_server() and reviving_unit:in_slot(managers.slot:get_mask("criminals")) then
		local hint = self.tweak_data == "revive" and 2 or 3
		managers.network:session():send_to_peers_synched("sync_teammate_helped_hint", hint, self._unit, reviving_unit)
		managers.trade:sync_teammate_helped_hint(self._unit, reviving_unit, hint)
	end
	if managers.blackmarket:equipped_mask().mask_id == tweak_data.achievement.witch_doctor.mask then
		managers.achievment:award_progress(tweak_data.achievement.witch_doctor.stat)
	end
end

function ReviveInteractionExt:save(data)
	ReviveInteractionExt.super.save(self, data)
	local state = {}
	state.active_wp = self._active_wp
	state.wp_id = self._wp_id
	data.ReviveInteractionExt = state
end

function ReviveInteractionExt:load(data)
	local state = data.ReviveInteractionExt
	if state then
		self._active_wp = state.active_wp
		self._wp_id = state.wp_id
	end
	ReviveInteractionExt.super.load(self, data)
end

GageAssignmentInteractionExt = GageAssignmentInteractionExt or class(UseInteractionExt)

function GageAssignmentInteractionExt:init(unit)
	GageAssignmentInteractionExt.super.init(self, unit)
end

function GageAssignmentInteractionExt:_interact_blocked(player)
	if self._unit:base() and self._unit:base().interact_blocked then
		return self._unit:base() and self._unit:base():interact_blocked()
	end
	return GageAssignmentInteractionExt.super._interact_blocked(self, player)
end

function GageAssignmentInteractionExt:can_select(player)
	return GageAssignmentInteractionExt.super.can_select(self, player)
end

function GageAssignmentInteractionExt:interact(player)
	GageAssignmentInteractionExt.super.super.interact(self, player)
	if alive(player) and player:sound() then
		player:sound():say("g92", false, true)
	end
	return self._unit:base():pickup(player)
end

AmmoBagInteractionExt = AmmoBagInteractionExt or class(UseInteractionExt)

function AmmoBagInteractionExt:_interact_blocked(player)
	return not player:inventory():need_ammo()
end

function AmmoBagInteractionExt:interact(player)
	AmmoBagInteractionExt.super.super.interact(self, player)
	local interacted = self._unit:base():take_ammo(player)
	for id, weapon in pairs(player:inventory():available_selections()) do
		managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
	end
	return interacted
end

GrenadeCrateInteractionExt = GrenadeCrateInteractionExt or class(UseInteractionExt)

function GrenadeCrateInteractionExt:_interact_blocked(player)
	return managers.player:got_max_grenades()
end

function GrenadeCrateInteractionExt:interact(player)
	GrenadeCrateInteractionExt.super.super.interact(self, player)
	return self._unit:base():take_grenade(player)
end

BodyBagsBagInteractionExt = BodyBagsBagInteractionExt or class(UseInteractionExt)

function BodyBagsBagInteractionExt:_interact_blocked(player)
	return managers.player:has_max_body_bags()
end

function BodyBagsBagInteractionExt:interact(player)
	BodyBagsBagInteractionExt.super.super.interact(self, player)
	return self._unit:base():take_bodybag(player)
end

DoctorBagBaseInteractionExt = DoctorBagBaseInteractionExt or class(UseInteractionExt)

function DoctorBagBaseInteractionExt:_interact_blocked(player)
	return player:character_damage():full_health()
end

function DoctorBagBaseInteractionExt:interact(player)
	DoctorBagBaseInteractionExt.super.super.interact(self, player)
	local interacted = self._unit:base():take(player)
	return interacted
end

C4BagInteractionExt = C4BagInteractionExt or class(UseInteractionExt)

function C4BagInteractionExt:_interact_blocked(player)
	return not managers.player:can_pickup_equipment("c4")
end

function C4BagInteractionExt:interact(player)
	C4BagInteractionExt.super.super.interact(self, player)
	managers.player:add_special({name = "c4"})
	return true
end

VeilInteractionExt = VeilInteractionExt or class(UseInteractionExt)

function VeilInteractionExt:_interact_blocked(player)
	return not managers.player:can_pickup_equipment("blood_sample")
end

function VeilInteractionExt:interact(player)
	VeilInteractionExt.super.super.interact(self, player)
	managers.player:add_special({
		name = "blood_sample"
	})
	return true
end

VeilTakeInteractionExt = VeilTakeInteractionExt or class(UseInteractionExt)

function VeilTakeInteractionExt:_interact_blocked(player)
	return not managers.player:can_pickup_equipment("blood_sample_verified")
end

function VeilTakeInteractionExt:interact(player)
	VeilTakeInteractionExt.super.interact(self, player)
	managers.player:add_special({
		name = "blood_sample_verified"
	})
	if self._unit:damage():has_sequence("got_blood_sample") then
		self._unit:damage():run_sequence_simple("got_blood_sample")
	end
	return true
end

function VeilTakeInteractionExt:sync_interacted()
	if self._unit:damage():has_sequence("got_blood_sample") then
		self._unit:damage():run_sequence_simple("got_blood_sample")
	end
	VeilTakeInteractionExt.super.sync_interacted(self)
end

SmallLootInteractionExt = SmallLootInteractionExt or class(UseInteractionExt)

function SmallLootInteractionExt:interact(player)
	if not self._unit:damage() or not self._unit:damage():has_sequence("interact") then
		SmallLootInteractionExt.super.super.interact(self, player)
	else
		SmallLootInteractionExt.super.interact(self, player)
	end
	self._unit:base():take(player)
end

MoneyWrapInteractionExt = MoneyWrapInteractionExt or class(UseInteractionExt)

function MoneyWrapInteractionExt:interact(player)
	MoneyWrapInteractionExt.super.super.interact(self, player)
	self._unit:base():take_money(player)
end

DiamondInteractionExt = DiamondInteractionExt or class(UseInteractionExt)

function DiamondInteractionExt:interact(player)
	DiamondInteractionExt.super.interact(self, player)
	self._unit:base():take_money(player)
end

SecurityCameraInteractionExt = SecurityCameraInteractionExt or class(UseInteractionExt)

function SecurityCameraInteractionExt:interact_distance(...)
	local interact_distance = SecurityCameraInteractionExt.super.interact_distance(self, ...)
	return interact_distance * managers.player:upgrade_value("player", "tape_loop_interact_distance_mul", 1)
end

function SecurityCameraInteractionExt:can_select(player)
	if not managers.groupai:state():whisper_mode() then
		return false
	end
	if not self._unit:base():can_apply_tape_loop() then
		return false
	end
	return SecurityCameraInteractionExt.super.can_select(self, player)
end

function SecurityCameraInteractionExt:check_interupt()
	if alive(SecurityCamera.active_tape_loop_unit) then
		return true
	end
	return SecurityCameraInteractionExt.super.check_interupt(self)
end

function SecurityCameraInteractionExt:_interact_blocked(player)
	if alive(SecurityCamera.active_tape_loop_unit) then
		return true, nil, "tape_loop_limit_reached"
	end
	return false
end

function SecurityCameraInteractionExt:interact(player)
	SecurityCameraInteractionExt.super.super.interact(self, player)
	self._unit:base():start_tape_loop()
end

function SecurityCameraInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	if not self._active then
		return
	end
end

ZipLineInteractionExt = ZipLineInteractionExt or class(UseInteractionExt)

function ZipLineInteractionExt:can_select(player)
	return ZipLineInteractionExt.super.can_select(self, player)
end

function ZipLineInteractionExt:check_interupt()
	if alive(self._unit:zipline():user_unit()) then
		return true
	end
	return ZipLineInteractionExt.super.check_interupt(self)
end

function ZipLineInteractionExt:_interact_blocked(player)
	if self._unit:zipline():is_usage_type_bag() and not managers.player:is_carrying() then
		return true, nil, "zipline_no_bag"
	end
	if player:movement():in_air() then
		return true, nil, nil
	end
	if self._unit:zipline():is_interact_blocked() then
		return true, nil, nil
	end
	return false
end

function ZipLineInteractionExt:interact(player)
	ZipLineInteractionExt.super.super.interact(self, player)
	print("ZipLineInteractionExt:interact")
	self._unit:zipline():on_interacted(player)
end

IntimitateInteractionExt = IntimitateInteractionExt or class(BaseInteractionExt)
IntimitateInteractionExt.drop_in_sync_tweak_data = true

function IntimitateInteractionExt:init(unit, ...)
	IntimitateInteractionExt.super.init(self, unit, ...)
	self._nbr_interactions = 0
end

function IntimitateInteractionExt:unselect()
	UseInteractionExt.super.unselect(self)
	managers.hud:remove_interact()
end

function IntimitateInteractionExt:interact(player)
	if not self:can_interact(player) then
		return
	end
	local has_equipment = managers.player:has_special_equipment(self._tweak_data.special_equipment)
	if self._tweak_data.equipment_consume and has_equipment then
		managers.player:remove_special(self._tweak_data.special_equipment)
	end
	if self._tweak_data.sound_event then
		player:sound():play(self._tweak_data.sound_event)
	end
	if self._unit:damage() and self._unit:damage():has_sequence("interact") then
		self._unit:damage():run_sequence_simple("interact")
	end
	if self.tweak_data == "corpse_alarm_pager" then
		if Network:is_server() then
			self._nbr_interactions = 0
			if self._unit:character_damage():dead() then
				local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
				managers.network:session():send_to_peers_synched("alarm_pager_interaction", u_id, self.tweak_data, 3)
			else
				managers.network:session():send_to_peers_synched("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 3)
			end
			self._unit:brain():on_alarm_pager_interaction("complete", player)
			if alive(managers.interaction:active_object()) then
				managers.interaction:active_object():interaction():selected()
			end
		elseif managers.enemy:get_corpse_unit_data_from_key(self._unit:key()) then
			local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
			managers.network:session():send_to_host("alarm_pager_interaction", u_id, self.tweak_data, 3)
		else
			managers.network:session():send_to_host("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 3)
		end
		self:remove_interact()
	elseif self.tweak_data == "corpse_dispose" then
		managers.player:set_carry("person", 0)
		managers.player:on_used_body_bag()
		local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
		if Network:is_server() then
			self:remove_interact()
			self:set_active(false, true)
			self._unit:set_slot(0)
			managers.network:session():send_to_peers_synched("remove_corpse_by_id", u_id, true, managers.network:session():local_peer():id())
			managers.player:register_carry(managers.network:session():local_peer():id(), "person")
		else
			managers.network:session():send_to_host("sync_interacted_by_id", u_id, self.tweak_data)
			player:movement():set_carry_restriction(true)
		end
	elseif self._tweak_data.dont_need_equipment and not has_equipment then
		self:set_active(false)
		self._unit:brain():on_tied(player, true)
	elseif self.tweak_data == "hostage_trade" then
		self._unit:brain():on_trade(player)
		if managers.blackmarket:equipped_mask().mask_id == tweak_data.achievement.relation_with_bulldozer.mask then
			managers.achievment:award_progress(tweak_data.achievement.relation_with_bulldozer.stat)
		end
		managers.statistics:trade({
			name = self._unit:base()._tweak_table
		})
	elseif self.tweak_data == "hostage_convert" then
		if Network:is_server() then
			self:remove_interact()
			self:set_active(false, true)
			managers.groupai:state():convert_hostage_to_criminal(self._unit)
		else
			managers.network:session():send_to_host("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 1)
		end
	elseif self.tweak_data == "hostage_move" then
		if Network:is_server() then
			if self._unit:brain():on_hostage_move_interaction(player, "move") then
				self:remove_interact()
			end
		else
			managers.network:session():send_to_host("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 1)
		end
	elseif self.tweak_data == "hostage_stay" then
		if Network:is_server() then
			if self._unit:brain():on_hostage_move_interaction(player, "stay") then
				self:remove_interact()
			end
		else
			managers.network:session():send_to_host("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 1)
		end
	else
		self:remove_interact()
		self:set_active(false)
		player:sound():play("cable_tie_apply")
		self._unit:brain():on_tied(player)
	end
end

function IntimitateInteractionExt:_at_interact_start(player, timer)
	IntimitateInteractionExt.super._at_interact_start(self)
	if self.tweak_data == "corpse_alarm_pager" then
		if Network:is_server() then
			self._nbr_interactions = self._nbr_interactions + 1
		end
		if self._in_progress then
			return
		end
		self._in_progress = true
		player:sound():say("dsp_radio_checking_1", true, true)
		if Network:is_server() then
			self._unit:brain():on_alarm_pager_interaction("started")
		elseif managers.enemy:get_corpse_unit_data_from_key(self._unit:key()) then
			local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
			managers.network:session():send_to_host("alarm_pager_interaction", u_id, self.tweak_data, 1)
		else
			managers.network:session():send_to_host("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 1)
		end
	end
end

function IntimitateInteractionExt:_at_interact_interupt(player, complete)
	IntimitateInteractionExt.super._at_interact_interupt(self, player, complete)
	if self.tweak_data == "corpse_alarm_pager" then
		if not self._in_progress then
			return
		end
		player:sound():say("dsp_stop_all", false, true)
		if not complete then
			self._unit:base():set_material_state(true)
			if Network:is_server() then
				self._nbr_interactions = self._nbr_interactions - 1
				if self._nbr_interactions == 0 then
					self._in_progress = nil
					self._unit:brain():on_alarm_pager_interaction("interrupted", player)
				end
			else
				self._in_progress = nil
				if managers.enemy:get_corpse_unit_data_from_key(self._unit:key()) then
					local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
					managers.network:session():send_to_host("alarm_pager_interaction", u_id, self.tweak_data, 2)
				else
					managers.network:session():send_to_host("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 2)
				end
			end
		end
	end
end

function IntimitateInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	local function _get_unit()
		local unit = player
		
		if not unit then
			local member = managers.network:game():member(peer:id())
			unit = member and member:unit()
			if not unit then
				print("[IntimitateInteractionExt:sync_interacted] missing unit", inspect(peer))
			end
		end
		return unit
	end
	
	if self.tweak_data == "corpse_alarm_pager" then
		if Network:is_server() then
			self._interacting_unit_destroy_listener_key = "IntimitateInteractionExt_" .. tostring(self._unit:key())
			if status == 1 then
				status = "started"
			elseif status == 2 then
				status = "interrupted"
			elseif status == 3 then
				status = "complete"
			end
			if status == "started" then
				local husk_unit = _get_unit()
				if husk_unit then
					husk_unit:base():add_destroy_listener(self._interacting_unit_destroy_listener_key, callback(self, self, "on_interacting_unit_destroyed", peer))
					self._interacting_units = self._interacting_units or {}
					self._interacting_units[husk_unit:key()] = husk_unit
				end
				self._nbr_interactions = self._nbr_interactions + 1
				if self._in_progress then
					return
				end
				self._in_progress = true
				self._unit:brain():on_alarm_pager_interaction(status, _get_unit())
			else
				if not self._in_progress then
					return
				end
				local husk_unit = _get_unit()
				if husk_unit then
					husk_unit:base():remove_destroy_listener(self._interacting_unit_destroy_listener_key)
					self._interacting_units[husk_unit:key()] = nil
					if not next(self._interacting_units) then
						self._interacting_units = nil
					end
				end
				if status == "complete" then
					self._nbr_interactions = 0
					if managers.enemy:get_corpse_unit_data_from_key(self._unit:key()) then
						local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
						managers.network:session():send_to_peers_synched_except(peer:id(), "alarm_pager_interaction", u_id, self.tweak_data, 3)
					else
						managers.network:session():send_to_peers_synched_except(peer:id(), "sync_interacted", self._unit, self._unit:id(), self.tweak_data, 3)
					end
				else
					self._nbr_interactions = self._nbr_interactions - 1
				end
				if self._nbr_interactions == 0 then
					self._in_progress = nil
					self:remove_interact()
					self._unit:brain():on_alarm_pager_interaction(status, _get_unit())
				end
			end
		end
	elseif self.tweak_data == "corpse_dispose" then
		if peer then
			managers.player:register_carry(peer:id(), "person")
		end
		self:remove_interact()
		self:set_active(false, true)
		local u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
		self._unit:set_slot(0)
		managers.network:session():send_to_peers_synched("remove_corpse_by_id", u_id, true, peer:id())
		if Network:is_server() and peer then
			peer:on_used_body_bags()
		end
	elseif self.tweak_data == "hostage_convert" then
		self:remove_interact()
		self:set_active(false, true)
		managers.groupai:state():convert_hostage_to_criminal(self._unit, _get_unit())
	elseif self.tweak_data == "hostage_move" then
		if Network:is_server() and self._unit:brain():on_hostage_move_interaction(_get_unit(), "move") then
			self:remove_interact()
		end
	elseif self.tweak_data == "hostage_stay" and Network:is_server() and self._unit:brain():on_hostage_move_interaction(_get_unit(), "stay") then
		self:remove_interact()
	end
end

function IntimitateInteractionExt:_interact_blocked(player)
	if self.tweak_data == "corpse_dispose" then
		if managers.player:is_carrying() then
			return true
		end
		if managers.player:chk_body_bags_depleted() then
			return true, nil, "body_bag_limit_reached"
		end
		local has_upgrade = managers.player:has_category_upgrade("player", "corpse_dispose")
		if not has_upgrade then
			return true
		end
		return not managers.player:can_carry("person")
	elseif self.tweak_data == "hostage_convert" then
		return not managers.player:has_category_upgrade("player", "convert_enemies") or not not managers.player:chk_minion_limit_reached() or managers.groupai:state():whisper_mode()
	elseif self.tweak_data == "hostage_move" then
		if not self._unit:anim_data().tied then
			return true
		end
		local following_hostages = managers.groupai:state():get_following_hostages(player)
		if following_hostages and table.size(following_hostages) >= tweak_data.player.max_nr_following_hostages then
			return true, nil, "hint_hostage_follow_limit"
		end
	elseif self.tweak_data == "hostage_stay" then
		return not self._unit:anim_data().stand or self._unit:anim_data().to_idle
	end
end

function IntimitateInteractionExt:_is_in_required_state()
	if self.tweak_data == "corpse_dispose" and not managers.groupai:state():whisper_mode() then
		return false
	end
	return true
end

function IntimitateInteractionExt:on_interacting_unit_destroyed(peer, player)
	self:sync_interacted(peer, player, "interrupted", nil)
end

CarryInteractionExt = CarryInteractionExt or class(UseInteractionExt)

function CarryInteractionExt:_interact_blocked(player)
	local silent_block = managers.player:carry_blocked_by_cooldown() or self._unit:carry_data():is_attached_to_zipline_unit()
	if managers.player:is_carrying() or silent_block then
		return true, silent_block
	end
	return not managers.player:can_carry(self._unit:carry_data():carry_id())
end

function CarryInteractionExt:can_select(player)
	if managers.player:is_carrying() or managers.player:carry_blocked_by_cooldown() or self._unit:carry_data():is_attached_to_zipline_unit() then
		return false
	end
	return CarryInteractionExt.super.can_select(self, player)
end

function CarryInteractionExt:interact(player)
	CarryInteractionExt.super.super.interact(self, player)
	if self._has_modified_timer then
		managers.achievment:award("murphys_laws")
	end
	managers.player:set_carry(self._unit:carry_data():carry_id(), self._unit:carry_data():multiplier(), self._unit:carry_data():dye_pack_data())
	managers.network:session():send_to_peers_synched("sync_interacted", self._unit, self._unit:id(), self.tweak_data, 1)
	self:sync_interacted(nil, player)
	managers.player:register_carry(managers.network:session():local_peer():id(), self._unit:carry_data() and self._unit:carry_data():carry_id())
	if Network:is_client() then
		player:movement():set_carry_restriction(true)
	else
	end
	return true
end

function CarryInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	player = player or managers.network:game():member(peer:id()):unit()
	if peer and not managers.player:register_carry(peer:id(), self._unit:carry_data() and self._unit:carry_data():carry_id()) then
		return
	end
	if self._unit:damage():has_sequence("interact") then
		self._unit:damage():run_sequence_simple("interact", {unit = player})
	end
	if self._unit:damage():has_sequence("load") then
		self._unit:damage():run_sequence_simple("load", {unit = player})
	end
	if self._global_event then
		managers.mission:call_global_event(self._global_event, player)
	end
	if Network:is_server() then
		if self._remove_on_interact then
			if self._unit == managers.interaction:active_object() then
				self:interact_interupt(managers.player:player_unit(), false)
			end
			self:remove_interact()
			self:set_active(false, true)
			if alive(player) then
				self._unit:carry_data():trigger_load(player)
			end
			self._unit:set_slot(0)
		end
		if peer then
			managers.player:set_carry_approved(peer)
		end
	end
end

function CarryInteractionExt:_get_modified_timer()
	if self._has_modified_timer then
		return 0
	end
	if managers.player:has_category_upgrade("carry", "interact_speed_multiplier") then
		return self._tweak_data.timer * managers.player:upgrade_value("carry", "interact_speed_multiplier", 1)
	end
	return nil
end

function CarryInteractionExt:register_collision_callbacks()
	self._unit:set_body_collision_callback(callback(self, self, "_collision_callback"))
	self._has_modified_timer = true
	self._air_start_time = Application:time()
	for i = 0, self._unit:num_bodies() - 1 do
		local body = self._unit:body(i)
		body:set_collision_script_tag(Idstring("throw"))
		body:set_collision_script_filter(1)
		body:set_collision_script_quiet_time(1)
	end
end

function CarryInteractionExt:_collision_callback(tag, unit, body, other_unit, other_body, position, normal, velocity, ...)
	if self._has_modified_timer then
		self._has_modified_timer = nil
	end
	local air_time = Application:time() - self._air_start_time
	self._unit:carry_data():check_explodes_on_impact(velocity, air_time)
	self._air_start_time = Application:time()
	if self._unit:carry_data():can_explode() and not self._unit:carry_data():explode_sequence_started() then
		return
	end
	for i = 0, self._unit:num_bodies() - 1 do
		local body = self._unit:body(i)
		body:set_collision_script_tag(Idstring(""))
	end
end

LootBankInteractionExt = LootBankInteractionExt or class(UseInteractionExt)

function LootBankInteractionExt:_interact_blocked(player)
	return not managers.player:is_carrying()
end

function LootBankInteractionExt:interact(player)
	LootBankInteractionExt.super.super.interact(self, player)
	if Network:is_client() then
		managers.network:session():send_to_host("sync_interacted", self._unit, -2, self.tweak_data, 1)
	else
		self:sync_interacted(nil, player)
	end
	managers.player:bank_carry()
	return true
end

function LootBankInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	local player = player or managers.network:game():member(peer:id()):unit()
	self._unit:damage():run_sequence_simple("unload", {unit = player})
end

EventIDInteractionExt = EventIDInteractionExt or class(UseInteractionExt)

function EventIDInteractionExt:show_blocked_hint(player, skip_hint)
	local unit_base = alive(self._unit) and self._unit:base()
	if unit_base and unit_base.show_blocked_hint then
		unit_base:show_blocked_hint(self._tweak_data, player, skip_hint)
	end
end

function EventIDInteractionExt:_interact_blocked(player)
	local unit_base = alive(self._unit) and self._unit:base()
	if unit_base and unit_base.check_interact_blocked then
		return unit_base:check_interact_blocked(player)
	end
	return false
end

function EventIDInteractionExt:interact_start(player)
	local blocked, skip_hint = self:_interact_blocked(player)
	if blocked then
		self:show_blocked_hint(player, skip_hint)
		return false
	end
	local has_equipment = not self._tweak_data.special_equipment and true or managers.player:has_special_equipment(self._tweak_data.special_equipment)
	local sound = has_equipment and (self._tweak_data.say_waiting or "") or self.say_waiting
	if sound and sound ~= "" then
		local delay = (self._tweak_data.timer or 0) * managers.player:toolset_value()
		delay = delay / 3 + math.random() * delay / 3
		local say_t = Application:time() + delay
		self._interact_say_clbk = "interact_say_waiting"
		managers.enemy:add_delayed_clbk(self._interact_say_clbk, callback(self, self, "_interact_say", {player, sound}), say_t)
	end
	if self._tweak_data.timer then
		if not self:can_interact(player) then
			self:show_blocked_hint(player)
			return false
		end
		local timer = self:_get_timer()
		if timer ~= 0 then
			self:_post_event(player, "sound_start")
			self:_at_interact_start(player, timer)
			return false, timer
		end
	end
	return self:interact(player)
end

function EventIDInteractionExt:_add_string_macros(macros)
	EventIDInteractionExt.super._add_string_macros(self, macros)
	if alive(self._unit) and self._unit:base() and self._unit:base().add_string_macros then
		self._unit:base():add_string_macros(macros)
	end
end

function EventIDInteractionExt:interact(player)
	if not self:can_interact(player) then
		return false
	end
	local event_id = alive(self._unit) and self._unit:base() and self._unit:base().get_net_event_id and self._unit:base():get_net_event_id(player) or 1
	if event_id then
		managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "interaction", event_id)
		self:sync_net_event(event_id, managers.network:session():local_peer())
	end
end

function EventIDInteractionExt:can_interact(player)
	if not EventIDInteractionExt.super.can_interact(self, player) then
		return false
	end
	return alive(self._unit) and self._unit:base() and self._unit:base().can_interact and self._unit:base():can_interact(player)
end

function EventIDInteractionExt:selected(player)
	local result = EventIDInteractionExt.super.selected(self, player)
	if result and self._unit:base().contour_selected then
		self._unit:base():contour_selected()
	end
	return result
end

function EventIDInteractionExt:unselect()
	EventIDInteractionExt.super.unselect(self)
	if self._unit:base().contour_unselected then
		self._unit:base():contour_unselected()
	end
end

function EventIDInteractionExt:sync_net_event(event_id, peer)
	local unit_base = alive(self._unit) and self._unit:base()
	if unit_base and unit_base.sync_net_event then
		unit_base:sync_net_event(event_id, peer)
	end
end

MissionDoorDeviceInteractionExt = MissionDoorDeviceInteractionExt or class(UseInteractionExt)

function MissionDoorDeviceInteractionExt:interact(player)
	if not self:can_interact(player) then
		return
	end
	MissionDoorDeviceInteractionExt.super.super.interact(self, player)
	if Network:is_client() then
		managers.network:session():send_to_host("server_place_mission_door_device", self._unit, player)
	else
		local result = self:server_place_mission_door_device(player)
		self:result_place_mission_door_device(result)
	end
end

function MissionDoorDeviceInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	MissionDoorDeviceInteractionExt.super.sync_interacted(self, peer, nil, nil, true)
	self:check_for_upgrade()
end

function MissionDoorDeviceInteractionExt:server_place_mission_door_device(player)
	local can_place = not self._unit:mission_door_device() or self._unit:mission_door_device():can_place()
	local info_id = self:get_player_info_id(player)
	self:remove_interact()
	self:set_info_id(info_id)
	managers.network:session():send_to_peers_synched("sync_interaction_info_id", self._unit, info_id)
	if self._unit:damage() then
		self._unit:damage():run_sequence_simple("interact", {unit = player})
	end
	managers.network:session():send_to_peers_synched("sync_interacted", self._unit, -2, self.tweak_data, 1)
	self:set_active(false)
	self:check_for_upgrade()
	if self._unit:mission_door_device() then
		self._unit:mission_door_device():placed()
	end
	if self._tweak_data.sound_event then
		player:sound():play(self._tweak_data.sound_event)
	end
	return can_place
end

function MissionDoorDeviceInteractionExt:result_place_mission_door_device(placed)
	if placed then
		if self._tweak_data.equipment_consume then
			managers.player:remove_special(self._tweak_data.special_equipment)
		end
		if self._tweak_data.deployable_consume then
			managers.player:remove_equipment(self._tweak_data.required_deployable)
		else
		end
	end
end

function MissionDoorDeviceInteractionExt:check_for_upgrade()
	if self._unit:timer_gui() and self._unit:timer_gui():is_visible() and self._unit:base() and self._unit:timer_gui()._upgrade_tweak_data and self._unit:base().get_skill_upgrades then
		local player_info_id = self:get_player_info_id()
		local player_info_table = self:split_info_id(player_info_id)
		local unit_info_table = self._unit:base():get_skill_upgrades()
		for i in pairs(player_info_table) do
			if not unit_info_table[i] then
				self:set_tweak_data(self._unit:timer_gui()._upgrade_tweak_data)
				self:set_active(true)
				break
			end
		end
	end
end

function MissionDoorDeviceInteractionExt:get_player_info_id(player)
	local INFO_IDS = BaseInteractionExt.INFO_IDS
	local info_id = 0
	local is_saw = self._unit:base() and self._unit:base().is_saw
	local is_hacking = self._unit:base() and self._unit:base().is_hacking_device
	local is_drill = self._unit:base() and self._unit:base().is_drill
	local is_local_player = not player or player:base().is_local_player
	if is_saw then
		local saw_speed_upgrade_level = 0
		if is_local_player then
			saw_speed_upgrade_level = managers.player:upgrade_level("player", "saw_speed_multiplier", 0)
		else
			saw_speed_upgrade_level = player:base():upgrade_level("player", "saw_speed_multiplier") or 0
		end
		if saw_speed_upgrade_level == 1 then
			info_id = info_id + INFO_IDS[1]
		elseif saw_speed_upgrade_level == 2 then
			info_id = info_id + INFO_IDS[1] + INFO_IDS[2]
		elseif 3 <= saw_speed_upgrade_level then
			info_id = info_id + INFO_IDS[1] + INFO_IDS[2]
			Application:debug("MissionDoorDeviceInteractionExt:set_player_info_id", "saw speed upgrade level is above 2, syncing only supports 2 upgrade levels")
		end
	elseif is_hacking then
	else
		if is_drill then
			local drill_speed_upgrade_level = 0
			local got_reduced_alert = false
			local got_silent_drill = false
			local got_auto_repair = false
			if is_local_player then
				drill_speed_upgrade_level = managers.player:upgrade_level("player", "drill_speed_multiplier", 0)
				got_reduced_alert = managers.player:has_category_upgrade("player", "drill_alert_rad")
				got_silent_drill = managers.player:has_category_upgrade("player", "silent_drill")
				got_auto_repair = managers.player:has_category_upgrade("player", "drill_autorepair")
			else
				drill_speed_upgrade_level = player:base():upgrade_level("player", "drill_speed_multiplier") or 0
				got_reduced_alert = player:base():upgrade_level("player", "drill_alert_rad") == 1
				got_silent_drill = player:base():upgrade_level("player", "silent_drill") == 1
				got_auto_repair = player:base():upgrade_level("player", "drill_autorepair") == 1
			end
			if drill_speed_upgrade_level == 1 then
				info_id = info_id + INFO_IDS[1]
			elseif drill_speed_upgrade_level == 2 then
				info_id = info_id + INFO_IDS[1] + INFO_IDS[2]
			elseif 3 <= drill_speed_upgrade_level then
				info_id = info_id + INFO_IDS[1] + INFO_IDS[2]
				Application:debug("MissionDoorDeviceInteractionExt:set_player_info_id", "drill speed upgrade level is above 2, syncing only supports 2 upgrade levels")
			end
			if got_reduced_alert then
				info_id = info_id + INFO_IDS[3]
			end
			if got_silent_drill then
				info_id = info_id + INFO_IDS[4]
			end
			if got_auto_repair then
				info_id = info_id + INFO_IDS[5]
			end
		else
		end
	end
	return info_id
end

function MissionDoorDeviceInteractionExt:split_info_id(info_id)
	local INFO_IDS = BaseInteractionExt.INFO_IDS
	local info_table = {}
	local ids_left = info_id
	for i = #INFO_IDS, 1, -1 do
		local id = INFO_IDS[i]
		if ids_left >= id then
			ids_left = ids_left - id
			info_table[i] = true
		end
	end
	return info_table
end

function MissionDoorDeviceInteractionExt:set_info_id(info_id)
	local upgrades_gotten = self:split_info_id(info_id)
	local is_saw = self._unit:base() and self._unit:base().is_saw
	local is_hacking = self._unit:base() and self._unit:base().is_hacking_device
	local is_drill = self._unit:base() and self._unit:base().is_drill
	if is_saw then
		local saw_speed_tweak_data = tweak_data.upgrades.values.player.saw_speed_multiplier
		local timer_multiplier = 1
		if upgrades_gotten[2] then
			timer_multiplier = saw_speed_tweak_data[2]
		elseif upgrades_gotten[1] then
			timer_multiplier = saw_speed_tweak_data[1]
		end
		self._unit:timer_gui():set_timer_multiplier(timer_multiplier)
	elseif is_drill or is_hacking then
		self._unit:base():set_skill_upgrades(upgrades_gotten)
	end
end

function MissionDoorDeviceInteractionExt:sync_net_event(event_id)
	if self._unit:base() then
		self._unit:timer_gui():set_skill(event_id)
	end
end

SpecialEquipmentInteractionExt = SpecialEquipmentInteractionExt or class(UseInteractionExt)

function SpecialEquipmentInteractionExt:_interact_blocked(player)
	return not managers.player:can_pickup_equipment(self._special_equipment)
end

function SpecialEquipmentInteractionExt:interact(player)
	SpecialEquipmentInteractionExt.super.super.interact(self, player)
	managers.player:add_special({
		name = self._special_equipment
	})
	if self._remove_on_interact then
		self:remove_interact()
		self:set_active(false)
	end
	if Network:is_client() then
		managers.network:session():send_to_host("sync_interacted", self._unit, -2, self.tweak_data, 1)
	else
		self:sync_interacted(nil, player)
	end
	return true
end

function SpecialEquipmentInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	player = player or managers.network:game():member(peer:id()):unit()
	if self._unit:damage():has_sequence("load") then
		self._unit:damage():run_sequence_simple("load")
	end
	if self._global_event then
		managers.mission:call_global_event(self._global_event, player)
	end
	if self._remove_on_interact then
		self._unit:set_slot(0)
	end
end

AccessCameraInteractionExt = AccessCameraInteractionExt or class(UseInteractionExt)

function AccessCameraInteractionExt:_interact_blocked(player)
	return false
end

function AccessCameraInteractionExt:interact(player)
	AccessCameraInteractionExt.super.super.interact(self, player)
	game_state_machine:change_state_by_name("ingame_access_camera")
	return true
end
