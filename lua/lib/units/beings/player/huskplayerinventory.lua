HuskPlayerInventory = HuskPlayerInventory or class(PlayerInventory)

function HuskPlayerInventory:init(unit)
	HuskPlayerInventory.super.init(self, unit)
	self._align_places.right_hand = {
		obj3d_name = Idstring("a_weapon_right_front"),
		on_body = true
	}
	self._align_places.left_hand = {
		obj3d_name = Idstring("a_weapon_left_front"),
		on_body = true
	}
	self._peer_weapons = {}
end

function HuskPlayerInventory:_send_equipped_weapon()
end

function HuskPlayerInventory:synch_equipped_weapon(weap_index, blueprint_string, cosmetics_string, peer)
	local weapon_name = self._get_weapon_name_from_sync_index(weap_index)
	if type(weapon_name) == "string" then
		self:add_unit_by_factory_name(weapon_name, true, true, blueprint_string, cosmetics_string or self:cosmetics_string_from_peer(peer, weapon_name))
		return
	end
	self:add_unit_by_name(weapon_name, true, true)
end

function HuskPlayerInventory:check_peer_weapon_spawn()
	if SystemInfo:platform() ~= Idstring("PS3") then
		return true
	end
	local next_in_line = self._peer_weapons[1]
	if next_in_line then
		if type(next_in_line) == "table" then
			print("[HuskPlayerInventory:check_peer_weapon_spawn()] Adding weapon to inventory.", inspect(next_in_line))
			self:add_unit_by_factory_blueprint(unpack(next_in_line))
		else
			print("[HuskPlayerInventory:check_peer_weapon_spawn()] waiting")
		end
		table.remove(self._peer_weapons, 1)
	else
		return true
	end
end

function HuskPlayerInventory:set_melee_weapon_by_peer(peer)
	local blackmarket_outfit = peer and peer:blackmarket_outfit()
	if blackmarket_outfit then
		self:set_melee_weapon(blackmarket_outfit.melee_weapon, true)
	end
end

function HuskPlayerInventory:add_unit_by_name(new_unit_name, equip, instant)
	local new_unit = World:spawn_unit(new_unit_name, Vector3(), Rotation())
	local setup_data = {}
	setup_data.user_unit = self._unit
	setup_data.ignore_units = {
		self._unit,
		new_unit
	}
	setup_data.expend_ammo = false
	setup_data.autoaim = false
	setup_data.alert_AI = false
	setup_data.user_sound_variant = "1"
	new_unit:base():setup(setup_data)
	self:add_unit(new_unit, equip, instant)
end

function HuskPlayerInventory:add_unit_by_factory_name(factory_name, equip, instant, blueprint_string, cosmetics_string)
	local factory_weapon = tweak_data.weapon.factory[factory_name]
	local ids_unit_name = Idstring(factory_weapon.unit)
	if not managers.dyn_resource:is_resource_ready(Idstring("unit"), ids_unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
		managers.dyn_resource:load(Idstring("unit"), ids_unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE, nil)
	end
	local blueprint = managers.weapon_factory:unpack_blueprint_from_string(factory_name, blueprint_string)
	local cosmetics
	local cosmetics_data = string.split(cosmetics_string, "-")
	local weapon_skin_id = cosmetics_data[1] or "nil"
	local quality_index_s = cosmetics_data[2] or "1"
	local bonus_id_s = cosmetics_data[3] or "0"
	if weapon_skin_id ~= "nil" then
		local quality = tweak_data.economy:get_entry_from_index("qualities", tonumber(quality_index_s))
		local bonus = bonus_id_s == "1" and true or false
		cosmetics = {
			id = weapon_skin_id,
			quality = quality,
			bonus = bonus
		}
	end
	self:add_unit_by_factory_blueprint(factory_name, equip, instant, blueprint, cosmetics)
end

function HuskPlayerInventory:add_unit_by_factory_blueprint(factory_name, equip, instant, blueprint, cosmetics)
	local factory_weapon = tweak_data.weapon.factory[factory_name]
	local new_unit = World:spawn_unit(Idstring(factory_weapon.unit), Vector3(), Rotation())
	new_unit:base():set_factory_data(factory_name)
	new_unit:base():set_cosmetics_data(cosmetics)
	new_unit:base():assemble_from_blueprint(factory_name, blueprint)
	new_unit:base():check_npc()
	local setup_data = {}
	setup_data.user_unit = self._unit
	setup_data.ignore_units = {
		self._unit,
		new_unit
	}
	setup_data.expend_ammo = false
	setup_data.autoaim = false
	setup_data.alert_AI = false
	setup_data.user_sound_variant = "1"
	new_unit:base():setup(setup_data)
	self:add_unit(new_unit, equip, instant)
	if new_unit:base().AKIMBO then
		new_unit:base():create_second_gun()
	end
end

function HuskPlayerInventory:synch_weapon_gadget_state(state)
	if self:equipped_unit():base().set_gadget_on then
		self:equipped_unit():base():set_gadget_on(state, true)
		if state and 0 < state then
			self._unit:movement():set_cbt_permanent(true)
		else
			self._unit:movement():set_cbt_permanent(false)
		end
	end
end

function HuskPlayerInventory:on_melee_item_shown()
	local selection = self._available_selections[self._equipped_selection]
	if not selection then
		return
	end
	if selection.use_data.equip.align_place == "left_hand" and alive(selection.unit) then
		self:_link_weapon(selection.unit, self._align_places.right_hand)
	end
end

function HuskPlayerInventory:on_melee_item_hidden()
	local selection = self._available_selections[self._equipped_selection]
	if not selection then
		return
	end
	if selection.use_data.equip.align_place == "left_hand" and alive(selection.unit) then
		self:_link_weapon(selection.unit, self._align_places.left_hand)
	end
end

function HuskPlayerInventory._get_weapon_name_from_sync_index(w_index)
	if w_index <= #tweak_data.character.weap_unit_names then
		return tweak_data.character.weap_unit_names[w_index]
	end
	w_index = w_index - #tweak_data.character.weap_unit_names
	HuskPlayerInventory._chk_create_w_factory_indexes()
	local fps_id = PlayerInventory._weapon_factory_indexed[w_index]
	if tweak_data.weapon.factory[fps_id .. "_npc"] then
		return fps_id .. "_npc"
	else
		return fps_id
	end
end

function HuskPlayerInventory:set_weapon_underbarrel(selection_index, underbarrel_id, is_on)
	selection_index = 2
	local selection = self._available_selections[selection_index]
	if not selection then
		return
	end
	selection.unit:base():set_underbarrel(underbarrel_id, is_on)
end
