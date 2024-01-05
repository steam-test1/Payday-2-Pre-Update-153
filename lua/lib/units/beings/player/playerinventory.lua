PlayerInventory = PlayerInventory or class()
PlayerInventory._all_event_types = {
	"add",
	"equip",
	"unequip"
}
PlayerInventory._index_to_weapon_list = {
	Idstring("units/payday2/weapons/wpn_npc_c45/wpn_npc_c45"),
	Idstring("units/payday2/weapons/wpn_npc_beretta92/wpn_npc_beretta92"),
	Idstring("units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull"),
	Idstring("units/payday2/weapons/wpn_npc_m4/wpn_npc_m4"),
	Idstring("units/payday2/weapons/wpn_npc_ak47/wpn_npc_ak47"),
	Idstring("units/payday2/weapons/wpn_npc_r870/wpn_npc_r870"),
	Idstring("units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun"),
	Idstring("units/payday2/weapons/wpn_npc_mp5/wpn_npc_mp5"),
	Idstring("units/payday2/weapons/wpn_npc_smg_mp9/wpn_npc_smg_mp9"),
	Idstring("units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11"),
	Idstring("units/payday2/weapons/wpn_npc_sniper/wpn_npc_sniper"),
	Idstring("units/payday2/weapons/wpn_fps_pis_g18c/wpn_fps_pis_g18c"),
	Idstring("units/payday2/weapons/wpn_fps_ass_m4/wpn_fps_ass_m4"),
	Idstring("units/payday2/weapons/wpn_fps_ass_amcar/wpn_fps_ass_amcar"),
	Idstring("units/payday2/weapons/wpn_fps_ass_m16/wpn_fps_ass_m16"),
	Idstring("units/payday2/weapons/wpn_fps_smg_olympic/wpn_fps_smg_olympic"),
	Idstring("units/payday2/weapons/wpn_fps_ass_74/wpn_fps_ass_74"),
	Idstring("units/payday2/weapons/wpn_fps_ass_akm/wpn_fps_ass_akm"),
	Idstring("units/payday2/weapons/wpn_fps_smg_akmsu/wpn_fps_smg_akmsu"),
	Idstring("units/payday2/weapons/wpn_fps_shot_saiga/wpn_fps_shot_saiga"),
	Idstring("units/payday2/weapons/wpn_fps_ass_ak5/wpn_fps_ass_ak5"),
	Idstring("units/payday2/weapons/wpn_fps_ass_aug/wpn_fps_ass_aug"),
	Idstring("units/payday2/weapons/wpn_fps_ass_g36/wpn_fps_ass_g36"),
	Idstring("units/payday2/weapons/wpn_fps_smg_p90/wpn_fps_smg_p90"),
	Idstring("units/payday2/weapons/wpn_fps_ass_m14/wpn_fps_ass_m14"),
	Idstring("units/payday2/weapons/wpn_fps_smg_mp9/wpn_fps_smg_mp9"),
	Idstring("units/payday2/weapons/wpn_fps_pis_deagle/wpn_fps_pis_deagle"),
	Idstring("units/payday2/weapons/wpn_fps_smg_mp5/wpn_fps_smg_mp5"),
	Idstring("units/payday2/weapons/wpn_fps_pis_1911/wpn_fps_pis_1911"),
	Idstring("units/payday2/weapons/wpn_fps_smg_mac10/wpn_fps_smg_mac10"),
	Idstring("units/payday2/weapons/wpn_fps_shot_r870/wpn_fps_shot_r870"),
	Idstring("units/payday2/weapons/wpn_fps_pis_g17/wpn_fps_pis_g17"),
	Idstring("units/payday2/weapons/wpn_fps_pis_b92fs/wpn_fps_pis_beretta"),
	Idstring("units/payday2/weapons/wpn_fps_shot_huntsman/wpn_fps_shot_huntsman"),
	Idstring("units/payday2/weapons/wpn_fps_pis_rage/wpn_fps_pis_rage"),
	Idstring("units/payday2/weapons/wpn_fps_saw/wpn_fps_saw"),
	Idstring("units/payday2/weapons/wpn_fps_shot_shorty/wpn_fps_shot_shorty")
}

function PlayerInventory:init(unit)
	self._unit = unit
	self._available_selections = {}
	self._equipped_selection = nil
	self._latest_addition = nil
	self._selected_primary = nil
	self._use_data_alias = "player"
	self._align_places = {}
	self._align_places.right_hand = {
		obj3d_name = Idstring("a_weapon_right"),
		on_body = false
	}
	self._align_places.left_hand = {
		obj3d_name = Idstring("a_weapon_left"),
		on_body = false
	}
	self._listener_id = "PlayerInventory" .. tostring(unit:key())
	self._listener_holder = EventListenerHolder:new()
	self._mask_unit = nil
	self._mask_unit_name = nil
end

function PlayerInventory:pre_destroy(unit)
	self:destroy_all_items()
	if alive(self._mask_unit) then
		for _, linked_unit in ipairs(self._mask_unit:children()) do
			linked_unit:unlink()
			World:delete_unit(linked_unit)
		end
		World:delete_unit(self._mask_unit)
		self._mask_unit = nil
	end
	if self._mask_unit_name then
		managers.dyn_resource:unload(Idstring("unit"), self._mask_unit_name, DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
		self._mask_unit_name = nil
	end
end

function PlayerInventory:destroy_all_items()
	local names = {}
	for i_sel, selection_data in pairs(self._available_selections) do
		selection_data.unit:base():remove_destroy_listener(self._listener_id)
		if managers.dyn_resource:has_resource(Idstring("unit"), selection_data.unit:name(), "packages/dyn_resources") then
			table.insert(names, selection_data.unit:name())
			selection_data.unit:base():set_slot(selection_data.unit, 0)
			World:delete_unit(selection_data.unit)
		else
			selection_data.unit:base():set_slot(selection_data.unit, 0)
		end
	end
	self._equipped_selection = nil
	self._available_selections = {}
	for _, name in pairs(names) do
		managers.dyn_resource:unload(Idstring("unit"), name, "packages/dyn_resources", false)
	end
end

function PlayerInventory:equipped_selection()
	return self._equipped_selection
end

function PlayerInventory:equipped_unit()
	return self._equipped_selection and self._available_selections[self._equipped_selection].unit
end

function PlayerInventory:unit_by_selection(selection)
	return self._available_selections[selection] and self._available_selections[selection].unit
end

function PlayerInventory:is_selection_available(selection_index)
	return self._available_selections[selection_index] and true or false
end

function PlayerInventory:add_unit(new_unit, is_equip, equip_is_instant)
	local new_selection = {}
	local use_data = new_unit:base():get_use_data(self._use_data_alias)
	new_selection.use_data = use_data
	new_selection.unit = new_unit
	new_unit:base():add_destroy_listener(self._listener_id, callback(self, self, "clbk_weapon_unit_destroyed"))
	local selection_index = use_data.selection_index
	if self._available_selections[selection_index] then
		local old_weapon_unit = self._available_selections[selection_index].unit
		is_equip = is_equip or old_weapon_unit == self:equipped_unit()
		old_weapon_unit:base():remove_destroy_listener(self._listener_id)
		old_weapon_unit:base():set_slot(old_weapon_unit, 0)
		local old_weapon_name_ids = old_weapon_unit:name()
		if managers.dyn_resource:has_resource(Idstring("unit"), old_weapon_name_ids, "packages/dyn_resources") then
			World:delete_unit(old_weapon_unit)
			managers.dyn_resource:unload(Idstring("unit"), old_weapon_name_ids, "packages/dyn_resources", false)
		end
		if self._equipped_selection == selection_index then
			self._equipped_selection = nil
		end
	end
	self._available_selections[selection_index] = new_selection
	self._latest_addition = selection_index
	self._selected_primary = self._selected_primary or selection_index
	self:_call_listeners("add")
	if is_equip then
		self:equip_latest_addition(equip_is_instant)
	else
		self:_place_selection(selection_index, is_equip)
	end
end

function PlayerInventory:clbk_weapon_unit_destroyed(weap_unit)
	local weapon_key = weap_unit:key()
	for i_sel, sel_data in pairs(self._available_selections) do
		if sel_data.unit:key() == weapon_key then
			managers.dyn_resource:unload(Idstring("unit"), weap_unit:name(), "packages/dyn_resources", false)
			self:remove_selection(i_sel, true)
			break
		end
	end
end

function PlayerInventory:get_latest_addition_hud_data()
	local unit = self._available_selections[self._latest_addition].unit
	local _, _, amount = unit:base():ammo_info()
	return {
		is_equip = self._latest_addition == self._selected_primary,
		amount = amount,
		inventory_index = self._latest_addition,
		unit = unit
	}
end

function PlayerInventory:add_unit_by_name(new_unit_name, equip, instant)
	for _, selection in pairs(self._available_selections) do
		if selection.unit:name() == new_unit_name then
			return
		end
	end
	local new_unit = World:spawn_unit(new_unit_name, Vector3(), Rotation())
	local setup_data = {}
	setup_data.user_unit = self._unit
	setup_data.ignore_units = {
		self._unit,
		new_unit
	}
	setup_data.expend_ammo = true
	setup_data.autoaim = true
	setup_data.alert_AI = true
	setup_data.alert_filter = self._unit:movement():SO_access()
	new_unit:base():setup(setup_data)
	self:add_unit(new_unit, equip, instant)
end

function PlayerInventory:add_unit_by_factory_name(factory_name, equip, instant, blueprint)
	local factory_weapon = tweak_data.weapon.factory[factory_name]
	local ids_unit_name = Idstring(factory_weapon.unit)
	managers.dyn_resource:load(Idstring("unit"), ids_unit_name, "packages/dyn_resources", false)
	local new_unit = World:spawn_unit(ids_unit_name, Vector3(), Rotation())
	new_unit:base():set_factory_data(factory_name)
	if blueprint then
		new_unit:base():assemble_from_blueprint(factory_name, blueprint)
	else
		new_unit:base():assemble(factory_name)
	end
	local setup_data = {}
	setup_data.user_unit = self._unit
	setup_data.ignore_units = {
		self._unit,
		new_unit
	}
	setup_data.expend_ammo = true
	setup_data.autoaim = true
	setup_data.alert_AI = true
	setup_data.alert_filter = self._unit:movement():SO_access()
	new_unit:base():setup(setup_data)
	self:add_unit(new_unit, equip, instant)
end

function PlayerInventory:remove_selection(selection_index, instant)
	selection_index = selection_index or self._equipped_selection
	local weap_unit = self._available_selections[selection_index].unit
	if alive(weap_unit) then
		weap_unit:base():remove_destroy_listener(self._listener_id)
	end
	self._available_selections[selection_index] = nil
	if self._equipped_selection == selection_index then
		self._equipped_selection = nil
	end
	if selection_index == self._selected_primary then
		self._selected_primary = self:_select_new_primary()
	end
end

function PlayerInventory:equip_latest_addition(instant)
	return self:equip_selection(self._latest_addition, instant)
end

function PlayerInventory:equip_selected_primary(instant)
	return self:equip_selection(self._selected_primary, instant)
end

function PlayerInventory:equip_next(instant)
	local i = self._selected_primary
	for i = self._selected_primary, self._selected_primary + 9 do
		local selection = 1 + math.mod(i, 10)
		if self._available_selections[selection] then
			return self:equip_selection(selection, instant)
		end
	end
	return false
end

function PlayerInventory:equip_previous(instant)
	local i = self._selected_primary
	for i = self._selected_primary, self._selected_primary - 9, -1 do
		local selection = 1 + math.mod(8 + i, 10)
		if self._available_selections[selection] then
			return self:equip_selection(selection, instant)
		end
	end
	return false
end

function PlayerInventory:equip_selection(selection_index, instant)
	if selection_index and selection_index ~= self._equipped_selection and self._available_selections[selection_index] then
		if self._equipped_selection then
			self:unequip_selection(nil, instant)
		end
		self._equipped_selection = selection_index
		self:_place_selection(selection_index, true)
		self._selected_primary = selection_index
		self:_send_equipped_weapon()
		self:_call_listeners("equip")
		if self._unit:unit_data().mugshot_id then
			local hud_icon_id = self:equipped_unit():base():weapon_tweak_data().hud_icon
			managers.hud:set_mugshot_weapon(self._unit:unit_data().mugshot_id, hud_icon_id, self:equipped_unit():base():weapon_tweak_data().use_data.selection_index)
		end
		self:equipped_unit():base():set_flashlight_enabled(true)
		return true
	else
	end
	return false
end

function PlayerInventory:_send_equipped_weapon()
	local eq_weap_name = self:equipped_unit():name()
	local index = self:_get_weapon_sync_index_from_name(eq_weap_name)
	if not index then
		debug_pause("[PlayerInventory:_send_equipped_weapon] cannot sync weapon", eq_weap_name, self._unit)
		return
	end
	local blueprint_string = self:equipped_unit():base().blueprint_to_string and self:equipped_unit():base():blueprint_to_string() or ""
	self._unit:network():send("set_equipped_weapon", index, blueprint_string)
end

function PlayerInventory:add_peer_blackmarket_outfit()
end

function PlayerInventory:unequip_selection(selection_index, instant)
	if not selection_index or selection_index == self._equipped_selection then
		self:equipped_unit():base():set_flashlight_enabled(false)
		selection_index = selection_index or self._equipped_selection
		self:_place_selection(selection_index, false)
		self._equipped_selection = nil
		self:_call_listeners("unequip")
	end
end

function PlayerInventory:is_equipped(index)
	return index == self._equipped_selection
end

function PlayerInventory:available_selections()
	return self._available_selections
end

function PlayerInventory:num_selections()
	return table.size(self._available_selections)
end

function PlayerInventory:_place_selection(selection_index, is_equip)
	local selection = self._available_selections[selection_index]
	local unit = selection.unit
	local weap_align_data = selection.use_data[is_equip and "equip" or "unequip"]
	local align_place = self._align_places[weap_align_data.align_place]
	if align_place then
		if is_equip then
			unit:set_enabled(true)
			unit:base():on_enabled()
		end
		local parent_unit = align_place.on_body and self._unit or self._unit:camera()._camera_unit
		local res = parent_unit:link(align_place.obj3d_name, unit, unit:orientation_object():name())
	else
		unit:unlink()
		unit:set_enabled(false)
		unit:base():on_disabled()
		if unit:base().gadget_on and self._unit:movement().set_cbt_permanent then
			self._unit:movement():set_cbt_permanent(false)
		end
	end
end

function PlayerInventory:_select_new_primary()
	for index, use_data in pairs(self._available_selections) do
		return index
	end
end

function PlayerInventory:add_listener(key, events, clbk)
	events = events or self._all_event_types
	self._listener_holder:add(key, events, clbk)
end

function PlayerInventory:remove_listener(key)
	self._listener_holder:remove(key)
end

function PlayerInventory:_call_listeners(event)
	self._listener_holder:call(event, self._unit, event)
end

function PlayerInventory:on_death_exit()
	for i, selection in pairs(self._available_selections) do
		selection.unit:unlink()
	end
end

function PlayerInventory:_get_weapon_sync_index_from_name(wanted_weap_name)
	for i, weap_name in pairs(self._index_to_weapon_list) do
		if (type(weap_name) == "string" and type(wanted_weap_name) == "string" or type(weap_name) ~= "string" and type(wanted_weap_name) ~= "string") and weap_name == wanted_weap_name then
			return i
		end
	end
end

function PlayerInventory:hide_equipped_unit()
	if self._equipped_selection and self._available_selections[self._equipped_selection].unit then
		self._available_selections[self._equipped_selection].unit:set_visible(false)
		self._available_selections[self._equipped_selection].unit:base():on_disabled()
	end
end

function PlayerInventory:show_equipped_unit()
	if self._equipped_selection and self._available_selections[self._equipped_selection].unit then
		self._available_selections[self._equipped_selection].unit:set_visible(true)
		self._available_selections[self._equipped_selection].unit:base():on_enabled()
	end
end

function PlayerInventory:save(data)
	if self._equipped_selection then
		local eq_weap_name = self:equipped_unit():base()._factory_id or self._available_selections[self._equipped_selection].unit:name()
		local index = self:_get_weapon_sync_index_from_name(eq_weap_name) or self:_get_weapon_sync_index_from_name(self._available_selections[self._equipped_selection].unit:name())
		data.equipped_weapon_index = index
		data.mask_visibility = self._mask_visibility
		data.blueprint_string = self:equipped_unit():base().blueprint_to_string and self:equipped_unit():base():blueprint_to_string() or nil
		data.gadget_on = self:equipped_unit():base().gadget_on and self:equipped_unit():base()._gadget_on
	end
end

function PlayerInventory:load(data)
	if data.equipped_weapon_index then
		local eq_weap_name = self._index_to_weapon_list[data.equipped_weapon_index]
		if type(eq_weap_name) == "string" then
			self:add_unit_by_factory_name(eq_weap_name, true, true, data.blueprint_string)
			self:synch_weapon_gadget_state(data.gadget_on)
		else
			self._unit:inventory():add_unit_by_name(eq_weap_name, true, true)
		end
		if self._unit:unit_data().mugshot_id then
			local icon = self:equipped_unit():base():weapon_tweak_data().hud_icon
			managers.hud:set_mugshot_weapon(self._unit:unit_data().mugshot_id, icon, self:equipped_unit():base():weapon_tweak_data().use_data.selection_index)
		end
	end
	self._mask_visibility = data.mask_visibility and true or false
end

function PlayerInventory:set_mask_visibility(state)
	self._mask_visibility = state
	if self._unit == managers.player:player_unit() then
		return
	end
	local character_name = managers.criminals:character_name_by_unit(self._unit)
	if not character_name then
		return
	end
	if alive(self._mask_unit) then
		if not state then
			for _, linked_unit in ipairs(self._mask_unit:children()) do
				linked_unit:unlink()
				World:delete_unit(linked_unit)
			end
			self._mask_unit:unlink()
			local name = self._mask_unit:name()
			World:delete_unit(self._mask_unit)
			managers.dyn_resource:unload(Idstring("unit"), name, DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
		end
		return
	end
	if not state then
		return
	end
	local mask_unit_name = managers.criminals:character_data_by_name(character_name).mask_obj
	mask_unit_name = mask_unit_name[Global.level_data.level_id] or mask_unit_name.default or mask_unit_name
	local mask_align = self._unit:get_object(Idstring("Head"))
	managers.dyn_resource:load(Idstring("unit"), Idstring(mask_unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
	local mask_unit = World:spawn_unit(Idstring(mask_unit_name), mask_align:position(), mask_align:rotation())
	mask_unit:base():apply_blueprint(managers.criminals:character_data_by_name(character_name).mask_blueprint)
	self._unit:link(mask_align:name(), mask_unit, mask_unit:orientation_object():name())
	self._mask_unit = mask_unit
	self._mask_unit_name = mask_unit:name()
	local backside = World:spawn_unit(Idstring("units/payday2/masks/msk_backside/msk_backside"), mask_align:position(), mask_align:rotation())
	self._mask_unit:link(self._mask_unit:orientation_object():name(), backside, backside:orientation_object():name())
end

function PlayerInventory:set_ammo(ammo)
	for id, weapon in pairs(self._available_selections) do
		weapon.unit:base():set_ammo(ammo)
		managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
	end
end

function PlayerInventory:need_ammo()
	for _, weapon in pairs(self._available_selections) do
		if not weapon.unit:base():ammo_full() then
			return true
		end
	end
	return false
end

function PlayerInventory:all_out_of_ammo()
	for _, weapon in pairs(self._available_selections) do
		if not weapon.unit:base():out_of_ammo() then
			return false
		end
	end
	return true
end

function PlayerInventory:anim_clbk_equip_exit(unit)
	self:set_mask_visibility(true)
end

function PlayerInventory:set_visibility_state(state)
	for i, sel_data in pairs(self._available_selections) do
		sel_data.unit:base():set_visibility_state(state)
	end
	if alive(self._shield_unit) then
		self._shield_unit:set_visible(state)
	end
end
