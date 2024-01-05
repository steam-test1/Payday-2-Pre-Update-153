local ids_lod = Idstring("lod")
local ids_lod1 = Idstring("lod1")
local ids_ik_aim = Idstring("ik_aim")
CopBase = CopBase or class(UnitBase)
CopBase._anim_lods = {
	{
		2,
		500,
		100,
		5000
	},
	{
		2,
		0,
		100,
		1
	},
	{
		3,
		0,
		100,
		1
	}
}
local material_translation_map = {}
do
	local payday2_characters_map = {
		"civ_female_bank_1",
		"civ_female_bank_manager_1",
		"civ_female_bikini_1",
		"civ_female_bikini_2",
		"civ_female_casual_1",
		"civ_female_casual_2",
		"civ_female_casual_3",
		"civ_female_casual_4",
		"civ_female_casual_5",
		"civ_female_crackwhore_1",
		"civ_female_hostess_apron_1",
		"civ_female_hostess_jacket_1",
		"civ_female_hostess_shirt_1",
		"civ_female_party_1",
		"civ_female_party_2",
		"civ_female_party_3",
		"civ_female_party_4",
		"civ_female_wife_trophy_1",
		"civ_female_wife_trophy_2",
		"civ_male_bank_1",
		"civ_male_bank_2",
		"civ_male_bank_manager_1",
		"civ_male_business_1",
		"civ_male_business_2",
		"civ_male_casual_1",
		"civ_male_casual_2",
		"civ_male_casual_3",
		"civ_male_casual_4",
		"civ_male_casual_5",
		"civ_male_casual_6",
		"civ_male_casual_7",
		"civ_male_casual_8",
		"civ_male_casual_9",
		"civ_male_dj_1",
		"civ_male_italian_robe_1",
		"civ_male_janitor_1",
		"civ_male_meth_cook_1",
		"civ_male_party_1",
		"civ_male_party_2",
		"civ_male_party_3",
		"civ_male_scientist_1",
		"civ_male_trucker_1",
		"civ_male_worker_docks_1",
		"civ_male_worker_docks_2",
		"civ_male_worker_docks_3",
		"ene_biker_1",
		"ene_biker_2",
		"ene_biker_3",
		"ene_biker_4",
		"ene_bulldozer_1",
		"ene_cop_1",
		"ene_cop_2",
		"ene_cop_3",
		"ene_cop_4",
		"ene_fbi_1",
		"ene_fbi_2",
		"ene_fbi_3",
		"ene_fbi_heavy_1",
		"ene_fbi_swat_1",
		"ene_fbi_swat_2",
		"ene_gang_black_1",
		"ene_gang_black_2",
		"ene_gang_black_3",
		"ene_gang_black_4",
		"ene_gang_mexican_1",
		"ene_gang_mexican_2",
		"ene_gang_mexican_3",
		"ene_gang_mexican_4",
		"ene_gang_russian_1",
		"ene_gang_russian_2",
		"ene_gang_russian_3",
		"ene_secret_service_1",
		"ene_secret_service_2",
		"ene_security_1",
		"ene_security_2",
		"ene_security_3",
		"ene_shield_1",
		"ene_shield_2",
		"ene_sniper_1",
		"ene_sniper_2",
		"ene_spook_1",
		"ene_swat_1",
		"ene_swat_2",
		"ene_swat_heavy_1",
		"ene_tazer_1"
	}
	local path_string = "units/payday2/characters/"
	local character_path = ""
	for _, character in ipairs(payday2_characters_map) do
		character_path = path_string .. character .. "/" .. character
		material_translation_map[tostring(Idstring(character_path):key())] = character_path .. "_contour"
		material_translation_map[tostring(Idstring(character_path .. "_contour"):key())] = character_path
	end
end

function CopBase:init(unit)
	UnitBase.init(self, unit, false)
	self._char_tweak = tweak_data.character[self._tweak_table]
	self._unit = unit
	self._visibility_state = true
	self._foot_obj_map = {}
	self._foot_obj_map.right = self._unit:get_object(Idstring("RightToeBase"))
	self._foot_obj_map.left = self._unit:get_object(Idstring("LeftToeBase"))
	self._is_in_original_material = true
end

function CopBase:post_init()
	self._ext_movement = self._unit:movement()
	self:set_anim_lod(1)
	self._lod_stage = 1
	self._ext_movement:post_init(true)
	self._unit:brain():post_init()
	managers.enemy:register_enemy(self._unit)
	self._allow_invisible = true
end

function CopBase:default_weapon_name()
	local default_weapon_id = self._default_weapon_id
	local weap_ids = tweak_data.character.weap_ids
	for i_weap_id, weap_id in ipairs(weap_ids) do
		if default_weapon_id == weap_id then
			return tweak_data.character.weap_unit_names[i_weap_id]
		end
	end
end

function CopBase:visibility_state()
	return self._visibility_state
end

function CopBase:lod_stage()
	return self._lod_stage
end

function CopBase:set_allow_invisible(allow)
	self._allow_invisible = allow
end

function CopBase:set_visibility_state(stage)
	local state = stage and true
	if not state and not self._allow_invisible then
		state = true
		stage = 1
	end
	if self._lod_stage == stage then
		return
	end
	local inventory = self._unit:inventory()
	local weapon = inventory and inventory.get_weapon and inventory:get_weapon()
	if weapon then
		weapon:base():set_flashlight_light_lod_enabled(stage ~= 2 and not not stage)
	end
	if self._visibility_state ~= state then
		local unit = self._unit
		if inventory then
			inventory:set_visibility_state(state)
		end
		unit:set_visible(state)
		if state or self._unit:anim_data().can_freeze then
			unit:set_animatable_enabled(ids_lod, state)
			unit:set_animatable_enabled(ids_ik_aim, state)
		end
		self._visibility_state = state
	end
	if state then
		self:set_anim_lod(stage)
		self._unit:movement():enable_update(true)
		if stage == 1 then
			self._unit:set_animatable_enabled(ids_lod1, true)
		elseif self._lod_stage == 1 then
			self._unit:set_animatable_enabled(ids_lod1, false)
		end
	end
	self._lod_stage = stage
	self:chk_freeze_anims()
end

function CopBase:set_anim_lod(stage)
	self._unit:set_animation_lod(unpack(self._anim_lods[stage]))
end

function CopBase:on_death_exit()
	self._unit:set_animations_enabled(false)
end

function CopBase:chk_freeze_anims()
	if (not self._lod_stage or self._lod_stage > 1) and self._unit:anim_data().can_freeze then
		if not self._anims_frozen then
			self._anims_frozen = true
			self._unit:set_animations_enabled(false)
			self._ext_movement:on_anim_freeze(true)
		end
	elseif self._anims_frozen then
		self._anims_frozen = nil
		self._unit:set_animations_enabled(true)
		self._ext_movement:on_anim_freeze(false)
	end
end

function CopBase:anim_act_clbk(unit, anim_act, nav_link)
	if nav_link then
		unit:movement():on_anim_act_clbk(anim_act)
	elseif unit:unit_data().mission_element then
		unit:unit_data().mission_element:event(anim_act, unit)
	end
end

function CopBase:save(data)
	if self._contour_state then
		data.base_contour_on = true
	elseif not self._is_in_original_material then
		data.swap_material = true
	end
	if self._unit:interaction() and self._unit:interaction().tweak_data == "hostage_trade" then
		data.is_hostage_trade = true
	end
end

function CopBase:load(data)
	if data.base_contour_on or data.swap_material then
		self._contour_on_clbk_id = "clbk_set_contour_on" .. tostring(self._unit:key())
		managers.enemy:add_delayed_clbk(self._contour_on_clbk_id, callback(self, self, "clbk_set_contour_on", data.swap_material), TimerManager:game():time() + 1)
	end
	if data.is_hostage_trade then
		CopLogicTrade.hostage_trade(self._unit, true, false)
	end
end

function CopBase:clbk_set_contour_on(swap_material_only)
	if not self._contour_on_clbk_id or not alive(self._unit) then
		return
	end
	self._contour_on_clbk_id = nil
	self:set_contour(true, swap_material_only)
end

local ids_materials = Idstring("material")
local ids_contour_color = Idstring("contour_color")
local ids_contour_opacity = Idstring("contour_opacity")

function CopBase:set_contour(state, swap_material_only)
	if not alive(self._unit) then
		return
	end
	if (self._contour_state or false) == (state or false) then
		return
	end
	if Network:is_server() then
		self._unit:network():send("set_contour", state)
	end
	if not self._unit:interaction() then
		return
	end
	self:swap_material_config()
	if swap_material_only then
		return
	end
	local opacity
	if state then
		managers.occlusion:remove_occlusion(self._unit)
		self._unit:interaction():set_tweak_data(self._unit:interaction().orig_tweak_data_contour or "intimidate_with_contour")
		self._unit:base():set_allow_invisible(false)
		self:set_visibility_state(1)
		opacity = 1
	else
		managers.occlusion:add_occlusion(self._unit)
		self._unit:interaction():set_tweak_data(self._unit:interaction().orig_tweak_data or "intimidate")
		self._unit:base():set_allow_invisible(true)
		opacity = 0
	end
	local materials = self._unit:get_objects_by_type(ids_materials)
	for _, m in ipairs(materials) do
		m:set_variable(ids_contour_color, tweak_data.contour.interactable.standard_color)
		m:set_variable(ids_contour_opacity, opacity)
	end
	self._contour_state = state
end

function CopBase:swap_material_config()
	local new_material = material_translation_map[tostring(self._unit:material_config():key())]
	if new_material then
		self._is_in_original_material = not self._is_in_original_material
		self._unit:set_material_config(Idstring(new_material), true)
		if self._unit:interaction() then
			self._unit:interaction():refresh_material()
		end
	else
		print("[CopBase:swap_material_config] fail", self._unit:material_config(), self._unit)
		Application:stack_dump()
	end
end

function CopBase:is_in_original_material()
	return self._is_in_original_material
end

function CopBase:set_material_state(original)
	if not (not original or self._is_in_original_material) or not original and self._is_in_original_material then
		self:swap_material_config()
	end
end

function CopBase:char_tweak()
	return self._char_tweak
end

function CopBase:pre_destroy(unit)
	if unit:unit_data().secret_assignment_id and alive(unit) then
		managers.secret_assignment:unregister_unit(unit)
	end
	if self._contour_on_clbk_id then
		managers.enemy:remove_delayed_clbk(self._contour_on_clbk_id)
	end
	unit:brain():pre_destroy(unit)
	self._ext_movement:pre_destroy()
	self._unit:inventory():pre_destroy()
	UnitBase.pre_destroy(self, unit)
end
