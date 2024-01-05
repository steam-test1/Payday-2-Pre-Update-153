HuskPlayerInventory = HuskPlayerInventory or class(PlayerInventory)
HuskPlayerInventory._index_to_weapon_list = {
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
	"wpn_fps_pis_g18c_npc",
	"wpn_fps_ass_m4_npc",
	"wpn_fps_ass_amcar_npc",
	"wpn_fps_ass_m16_npc",
	"wpn_fps_smg_olympic_npc",
	"wpn_fps_ass_74_npc",
	"wpn_fps_ass_akm_npc",
	"wpn_fps_smg_akmsu_npc",
	"wpn_fps_shot_saiga_npc",
	"wpn_fps_ass_ak5_npc",
	"wpn_fps_ass_aug_npc",
	"wpn_fps_ass_g36_npc",
	"wpn_fps_smg_p90_npc",
	"wpn_fps_ass_m14_npc",
	"wpn_fps_smg_mp9_npc",
	"wpn_fps_pis_deagle_npc",
	"wpn_fps_smg_mp5_npc",
	"wpn_fps_pis_1911_npc",
	"wpn_fps_smg_mac10_npc",
	"wpn_fps_shot_r870_npc",
	"wpn_fps_pis_g17_npc",
	"wpn_fps_pis_beretta_npc",
	"wpn_fps_shot_huntsman_npc",
	"wpn_fps_pis_rage_npc",
	"wpn_fps_saw_npc",
	"wpn_fps_shot_serbu_npc"
}

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

function HuskPlayerInventory:synch_equipped_weapon(weap_index, blueprint_string)
	local weapon_name = HuskPlayerInventory._index_to_weapon_list[weap_index]
	if type(weapon_name) == "string" then
		self:add_unit_by_factory_name(weapon_name, true, true, blueprint_string)
		return
	end
	self:add_unit_by_name(weapon_name, true, true)
end

function HuskPlayerInventory:add_peer_blackmarket_outfit(peer)
	local peer_id = peer:id()
	local blackmarket_outfit = peer and peer:blackmarket_outfit()
	for i = 1, peer_id - 1 do
		table.insert(self._peer_weapons, true)
	end
	if blackmarket_outfit then
		local primary = blackmarket_outfit.primary
		local secondary = blackmarket_outfit.secondary
		if primary then
			local factory_name_npc = tostring(primary.factory_id) .. "_npc"
			assert(factory_name_npc)
			table.insert(self._peer_weapons, {
				factory_name_npc,
				false,
				true,
				primary.blueprint
			})
		end
		for i = 1, 3 do
			table.insert(self._peer_weapons, true)
		end
		if secondary then
			local factory_name_npc = tostring(secondary.factory_id) .. "_npc"
			assert(factory_name_npc)
			table.insert(self._peer_weapons, {
				factory_name_npc,
				false,
				true,
				secondary.blueprint
			})
		end
	end
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

function HuskPlayerInventory:add_unit_by_factory_name(factory_name, equip, instant, blueprint_string)
	local blueprint = managers.weapon_factory:unpack_blueprint_from_string(factory_name, blueprint_string)
	self:add_unit_by_factory_blueprint(factory_name, equip, instant, blueprint)
end

function HuskPlayerInventory:add_unit_by_factory_blueprint(factory_name, equip, instant, blueprint)
	local factory_weapon = tweak_data.weapon.factory[factory_name]
	local ids_unit_name = Idstring(factory_weapon.unit)
	managers.dyn_resource:load(Idstring("unit"), ids_unit_name, "packages/dyn_resources", false)
	local new_unit = World:spawn_unit(Idstring(factory_weapon.unit), Vector3(), Rotation())
	new_unit:base():set_factory_data(factory_name)
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
end

function HuskPlayerInventory:synch_weapon_gadget_state(state)
	if self:equipped_unit():base().gadget_on then
		if state then
			self:equipped_unit():base():gadget_on()
			self._unit:movement():set_cbt_permanent(true)
		else
			self:equipped_unit():base():gadget_off()
			self._unit:movement():set_cbt_permanent(false)
		end
	end
end
