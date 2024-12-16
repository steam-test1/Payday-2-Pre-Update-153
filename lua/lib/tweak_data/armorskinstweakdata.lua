local sorting_groups = {crime_spree = 1, camo = 2}

function EconomyTweakData:get_real_armor_skin_id(skin_id)
	local lbv = "_lbv"
	if string.sub(skin_id, #skin_id - #lbv + 1, #skin_id) == lbv then
		return string.sub(skin_id, 1, #skin_id - #lbv)
	else
		return skin_id
	end
end

function EconomyTweakData:get_armor_skin_id(skin_id)
	local use_lbv = managers.blackmarket:equipped_armor() == "level_2"
	if use_lbv then
		local lbv_id = skin_id .. "_lbv"
		if tweak_data.economy.armor_skins[lbv_id] then
			return lbv_id
		end
	end
	return skin_id
end

function EconomyTweakData:_init_armor_skins()
	local ids_big = Idstring("units/payday2/characters/shared_textures/vest_big_01_df")
	local ids_small = Idstring("units/payday2/characters/shared_textures/vest_small_01_df")
	local armor_skins_configs = {
		["units/payday2/characters/npc_criminals_suit_1/mtr_bodhi"] = "units/payday2/characters/npc_criminals_suit_1/mtr_bodhi_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_chains"] = "units/payday2/characters/npc_criminals_suit_1/mtr_chains_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_dallas"] = "units/payday2/characters/npc_criminals_suit_1/mtr_dallas_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_dragan"] = "units/payday2/characters/npc_criminals_suit_1/mtr_dragan_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_hoxton"] = "units/payday2/characters/npc_criminals_suit_1/mtr_hoxton_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_jacket"] = "units/payday2/characters/npc_criminals_suit_1/mtr_jacket_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_jimmy"] = "units/payday2/characters/npc_criminals_suit_1/mtr_jimmy_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_jiro"] = "units/payday2/characters/npc_criminals_suit_1/mtr_jiro_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_john_wick"] = "units/payday2/characters/npc_criminals_suit_1/mtr_john_wick_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_old_hoxton"] = "units/payday2/characters/npc_criminals_suit_1/mtr_old_hoxton_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_sokol"] = "units/payday2/characters/npc_criminals_suit_1/mtr_sokol_cc",
		["units/payday2/characters/npc_criminals_suit_1/mtr_wolf"] = "units/payday2/characters/npc_criminals_suit_1/mtr_wolf_cc",
		["units/payday2/characters/npc_criminal_female_1/mtr_fem1"] = "units/payday2/characters/npc_criminal_female_1/mtr_fem1_cc",
		["units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/mtr_bonnie"] = "units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/mtr_bonnie_cc",
		["units/pd2_dlc_chico/characters/npc_criminals_terry/mtr_criminal_terry"] = "units/pd2_dlc_chico/characters/npc_criminals_terry/mtr_criminal_terry_cc",
		["units/pd2_dlc_opera/characters/npc_criminals_fem_3/mtr_criminal_sydney"] = "units/pd2_dlc_opera/characters/npc_criminals_fem_3/mtr_criminal_sydney_cc",
		["units/pd2_dlc_wild/characters/npc_criminals_wild_1/mtr_criminal_wild_1"] = "units/pd2_dlc_wild/characters/npc_criminals_wild_1/mtr_criminal_wild_1_cc"
	}
	self.armor_skins_configs = {}
	self.armor_skins_configs_map = {}
	for orig, cc in pairs(armor_skins_configs) do
		self.armor_skins_configs[Idstring(orig):key()] = Idstring(cc)
		self.armor_skins_configs_map[Idstring(cc):key()] = Idstring(orig)
	end
	self.character_cc_configs = {
		american = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_hoxton_cc"),
		german = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_wolf_cc"),
		russian = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_dallas_cc"),
		spanish = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_chains_cc"),
		jowi = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_john_wick_cc"),
		old_hoxton = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_old_hoxton_cc"),
		female_1 = Idstring("units/payday2/characters/npc_criminal_female_1/mtr_fem1_cc"),
		dragan = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_dragan_cc"),
		jacket = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_jacket_cc"),
		bonnie = Idstring("units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/mtr_bonnie_cc"),
		sokol = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_sokol_cc"),
		dragon = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_jiro_cc"),
		bodhi = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_bodhi_cc"),
		jimmy = Idstring("units/payday2/characters/npc_criminals_suit_1/mtr_jimmy_cc"),
		sydney = Idstring("units/pd2_dlc_opera/characters/npc_criminals_fem_3/mtr_criminal_sydney_cc"),
		wild = Idstring("units/pd2_dlc_wild/characters/npc_criminals_wild_1/mtr_criminal_wild_1_cc"),
		chico = Idstring("units/pd2_dlc_chico/characters/npc_criminals_terry/mtr_criminal_terry_cc")
	}
	self.armor_skins = {}
	self.armor_skins.none = {}
	self.armor_skins.none.name_id = "bm_askn_none"
	self.armor_skins.none.desc_id = "bm_askn_none_desc"
	self.armor_skins.none.reserve_quality = true
	self.armor_skins.none.sorted = false
	self.armor_skins.none.free = true
	self.armor_skins.none.unlocked = true
	self.armor_skins.none.ignore_cc = true
	self.armor_skins.none.default = true
	self.armor_skins.none.texture_bundle_folder = "cash/safes/cvc"
	self:_init_armor_skins_crime_spree()
	self:_init_armor_skins_armor_safe()
end

function EconomyTweakData:_init_armor_skins_crime_spree()
	self.armor_skins.cvc_green = {}
	self.armor_skins.cvc_green.name_id = "bm_askn_cvc_green"
	self.armor_skins.cvc_green.desc_id = "bm_askn_cvc_green_desc"
	self.armor_skins.cvc_green.unlock_id = "bm_askn_find_in_crime_spree"
	self.armor_skins.cvc_green.rarity = "uncommon"
	self.armor_skins.cvc_green.reserve_quality = false
	self.armor_skins.cvc_green.steam_economy = false
	self.armor_skins.cvc_green.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_green.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_004_df")
	self.armor_skins.cvc_green.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_green.uv_scale = Vector3(12.086, 12.086, 1)
	self.armor_skins.cvc_green.uv_offset_rot = Vector3(-0.320689, 1.38638, 0)
	self.armor_skins.cvc_green.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_green.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_green.uv_scale = Vector3(9.32087, 11.1325, 1)
	self.armor_skins.cvc_green.uv_offset_rot = Vector3(-0.320768, 1.37938, 0)
	self.armor_skins.cvc_green.sorting_idx = sorting_groups.crime_spree
	self.armor_skins.cvc_black = {}
	self.armor_skins.cvc_black.name_id = "bm_askn_black"
	self.armor_skins.cvc_black.desc_id = "bm_askn_black_desc"
	self.armor_skins.cvc_black.unlock_id = "bm_askn_find_in_crime_spree"
	self.armor_skins.cvc_black.rarity = "uncommon"
	self.armor_skins.cvc_black.reserve_quality = false
	self.armor_skins.cvc_black.steam_economy = false
	self.armor_skins.cvc_black.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_black.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_001_df")
	self.armor_skins.cvc_black.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_black.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_black.uv_scale = Vector3(9.32087, 11.1325, 1)
	self.armor_skins.cvc_black.uv_offset_rot = Vector3(-0.320768, 1.37938, 0)
	self.armor_skins.cvc_black.sorting_idx = sorting_groups.crime_spree
	self.armor_skins.cvc_tan = {}
	self.armor_skins.cvc_tan.name_id = "bm_askn_cvc_tan"
	self.armor_skins.cvc_tan.desc_id = "bm_askn_cvc_tan_desc"
	self.armor_skins.cvc_tan.unlock_id = "bm_askn_find_in_crime_spree"
	self.armor_skins.cvc_tan.rarity = "uncommon"
	self.armor_skins.cvc_tan.reserve_quality = false
	self.armor_skins.cvc_tan.steam_economy = false
	self.armor_skins.cvc_tan.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_tan.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_007_df")
	self.armor_skins.cvc_tan.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_tan.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_tan.uv_scale = Vector3(9.32087, 11.1325, 1)
	self.armor_skins.cvc_tan.uv_offset_rot = Vector3(-0.320768, 1.37938, 0)
	self.armor_skins.cvc_tan.sorting_idx = sorting_groups.crime_spree
	self.armor_skins.cvc_grey = {}
	self.armor_skins.cvc_grey.name_id = "bm_askn_cvc_grey"
	self.armor_skins.cvc_grey.desc_id = "bm_askn_cvc_grey_desc"
	self.armor_skins.cvc_grey.unlock_id = "bm_askn_find_in_crime_spree"
	self.armor_skins.cvc_grey.rarity = "uncommon"
	self.armor_skins.cvc_grey.reserve_quality = false
	self.armor_skins.cvc_grey.steam_economy = false
	self.armor_skins.cvc_grey.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_grey.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_002_df")
	self.armor_skins.cvc_grey.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_grey.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_grey.uv_scale = Vector3(9.32087, 11.1325, 1)
	self.armor_skins.cvc_grey.uv_offset_rot = Vector3(-0.320768, 1.37938, 0)
	self.armor_skins.cvc_grey.sorting_idx = sorting_groups.crime_spree
	self.armor_skins.cvc_grey_lbv = {}
	self.armor_skins.cvc_grey_lbv.name_id = "bm_askn_cvc_grey_lbv"
	self.armor_skins.cvc_grey_lbv.desc_id = "bm_askn_cvc_grey_lbv_desc"
	self.armor_skins.cvc_grey_lbv.unlock_id = "bm_askn_find_in_crime_spree"
	self.armor_skins.cvc_grey_lbv.rarity = "uncommon"
	self.armor_skins.cvc_grey_lbv.reserve_quality = false
	self.armor_skins.cvc_grey_lbv.steam_economy = false
	self.armor_skins.cvc_grey_lbv.sorted = false
	self.armor_skins.cvc_grey_lbv.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_grey_lbv.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_002_c_df")
	self.armor_skins.cvc_grey_lbv.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_grey_lbv.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_grey_lbv.uv_scale = Vector3(9.32087, 11.1325, 1)
	self.armor_skins.cvc_grey_lbv.uv_offset_rot = Vector3(-0.320768, 1.37938, 0)
	self.armor_skins.cvc_grey_lbv.sorting_idx = sorting_groups.crime_spree
	self.armor_skins.cvc_navy_blue = {}
	self.armor_skins.cvc_navy_blue.name_id = "bm_askn_navy_blue"
	self.armor_skins.cvc_navy_blue.desc_id = "bm_askn_navy_blue_desc"
	self.armor_skins.cvc_navy_blue.unlock_id = "bm_askn_find_in_crime_spree"
	self.armor_skins.cvc_navy_blue.rarity = "uncommon"
	self.armor_skins.cvc_navy_blue.reserve_quality = false
	self.armor_skins.cvc_navy_blue.steam_economy = false
	self.armor_skins.cvc_navy_blue.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_navy_blue.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_008_df")
	self.armor_skins.cvc_navy_blue.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_001_df")
	self.armor_skins.cvc_navy_blue.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_navy_blue.uv_scale = Vector3(9.32087, 11.1325, 1)
	self.armor_skins.cvc_navy_blue.uv_offset_rot = Vector3(-0.320768, 1.37938, 0)
	self.armor_skins.cvc_navy_blue.sorting_idx = sorting_groups.crime_spree
end

function EconomyTweakData:_init_armor_skins_armor_safe()
	self.armor_skins.cvc_woodland_camo = {}
	self.armor_skins.cvc_woodland_camo.name_id = "bm_askn_cvc_woodland_camo"
	self.armor_skins.cvc_woodland_camo.desc_id = "bm_askn_cvc_woodland_camo_desc"
	self.armor_skins.cvc_woodland_camo.rarity = "uncommon"
	self.armor_skins.cvc_woodland_camo.reserve_quality = false
	self.armor_skins.cvc_woodland_camo.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_woodland_camo.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_012_df")
	self.armor_skins.cvc_woodland_camo.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_004_df")
	self.armor_skins.cvc_woodland_camo.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_003_df")
	self.armor_skins.cvc_woodland_camo.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_006_df")
	self.armor_skins.cvc_woodland_camo.uv_scale = Vector3(20, 18.5698, 1)
	self.armor_skins.cvc_woodland_camo.uv_offset_rot = Vector3(0.216614, 0.925013, 0)
	self.armor_skins.cvc_woodland_camo.pattern_tweak = Vector3(1.87455, 0, 1)
	self.armor_skins.cvc_woodland_camo.pattern_pos = Vector3(0.216075, 0.445028, 0)
	self.armor_skins.cvc_woodland_camo.sorting_idx = sorting_groups.camo
	self.armor_skins.cvc_city_camo = {}
	self.armor_skins.cvc_city_camo.name_id = "bm_askn_cvc_city_camo"
	self.armor_skins.cvc_city_camo.desc_id = "bm_askn_cvc_city_camo_desc"
	self.armor_skins.cvc_city_camo.rarity = "uncommon"
	self.armor_skins.cvc_city_camo.reserve_quality = false
	self.armor_skins.cvc_city_camo.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_city_camo.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_002_df")
	self.armor_skins.cvc_city_camo.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df")
	self.armor_skins.cvc_city_camo.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
	self.armor_skins.cvc_city_camo.pattern_tweak = Vector3(1.87455, 0, 1)
	self.armor_skins.cvc_city_camo.pattern_pos = Vector3(0.216075, 0.445028, 0)
	self.armor_skins.cvc_city_camo.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_006_df")
	self.armor_skins.cvc_city_camo.uv_scale = Vector3(20, 18.5698, 1)
	self.armor_skins.cvc_city_camo.uv_offset_rot = Vector3(0.216614, 0.925013, 0)
	self.armor_skins.cvc_city_camo.sorting_idx = sorting_groups.camo
	self.armor_skins.cvc_city_camo_lbv = {}
	self.armor_skins.cvc_city_camo_lbv.name_id = "bm_askn_cvc_city_camo_lbv"
	self.armor_skins.cvc_city_camo_lbv.desc_id = "bm_askn_cvc_city_camo_lbv_desc"
	self.armor_skins.cvc_city_camo_lbv.rarity = "uncommon"
	self.armor_skins.cvc_city_camo_lbv.reserve_quality = true
	self.armor_skins.cvc_city_camo_lbv.sorted = false
	self.armor_skins.cvc_city_camo_lbv.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_city_camo_lbv.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_002_b_df")
	self.armor_skins.cvc_city_camo_lbv.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df")
	self.armor_skins.cvc_city_camo_lbv.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
	self.armor_skins.cvc_city_camo_lbv.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_006_df")
	self.armor_skins.cvc_city_camo_lbv.pattern_tweak = Vector3(1.77916, 0, 1)
	self.armor_skins.cvc_city_camo_lbv.pattern_pos = Vector3(0.216075, 0.473647, 0)
	self.armor_skins.cvc_city_camo_lbv.uv_scale = Vector3(20, 18.5698, 1)
	self.armor_skins.cvc_city_camo_lbv.uv_offset_rot = Vector3(0.216614, 0.925013, 0)
	self.armor_skins.cvc_city_camo_lbv.sorting_idx = sorting_groups.camo
	self.armor_skins.cvc_desert_camo = {}
	self.armor_skins.cvc_desert_camo.name_id = "bm_askn_desert_camo"
	self.armor_skins.cvc_desert_camo.desc_id = "bm_askn_desert_camo_desc"
	self.armor_skins.cvc_desert_camo.rarity = "uncommon"
	self.armor_skins.cvc_desert_camo.reserve_quality = false
	self.armor_skins.cvc_desert_camo.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_desert_camo.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_009_df")
	self.armor_skins.cvc_desert_camo.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_005_df")
	self.armor_skins.cvc_desert_camo.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.armor_skins.cvc_desert_camo.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_006_df")
	self.armor_skins.cvc_desert_camo.uv_scale = Vector3(20, 18.5698, 1)
	self.armor_skins.cvc_desert_camo.uv_offset_rot = Vector3(0.216614, 0.925013, 0)
	self.armor_skins.cvc_desert_camo.pattern_tweak = Vector3(2.82853, 0, 1)
	self.armor_skins.cvc_desert_camo.uv_scale = Vector3(20, 18.5698, 1)
	self.armor_skins.cvc_desert_camo.sorting_idx = sorting_groups.camo
	self.armor_skins.cvc_desert_camo_lbv = {}
	self.armor_skins.cvc_desert_camo_lbv.name_id = "bm_askn_cvc_desert_camo_lbv"
	self.armor_skins.cvc_desert_camo_lbv.desc_id = "bm_askn_cvc_desert_camo_lbv_desc"
	self.armor_skins.cvc_desert_camo_lbv.rarity = "common"
	self.armor_skins.cvc_desert_camo_lbv.reserve_quality = true
	self.armor_skins.cvc_desert_camo_lbv.sorted = false
	self.armor_skins.cvc_desert_camo_lbv.texture_bundle_folder = "cash/safes/wip"
	self.armor_skins.cvc_desert_camo_lbv.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_009_b_df")
	self.armor_skins.cvc_desert_camo_lbv.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_006_df")
	self.armor_skins.cvc_desert_camo_lbv.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.armor_skins.cvc_desert_camo_lbv.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_006_df")
	self.armor_skins.cvc_desert_camo_lbv.pattern_tweak = Vector3(1.92225, 0, 1)
	self.armor_skins.cvc_desert_camo_lbv.uv_scale = Vector3(20, 18.5698, 1)
	self.armor_skins.cvc_desert_camo_lbv.uv_offset_rot = Vector3(0.216614, 0.925013, 0)
	self.armor_skins.cvc_desert_camo_lbv.sorting_idx = sorting_groups.camo
	self.armor_skins.cvc_avenger = {}
	self.armor_skins.cvc_avenger.name_id = "bm_askn_cvc_avenger"
	self.armor_skins.cvc_avenger.desc_id = "bm_askn_cvc_avenger_desc"
	self.armor_skins.cvc_avenger.rarity = "rare"
	self.armor_skins.cvc_avenger.reserve_quality = false
	self.armor_skins.cvc_avenger.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_avenger.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_013_df")
	self.armor_skins.cvc_avenger.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_003_df")
	self.armor_skins.cvc_avenger.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.armor_skins.cvc_avenger.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_005_df")
	self.armor_skins.cvc_avenger.pattern_tweak = Vector3(2.01765, 0, 1)
	self.armor_skins.cvc_avenger.pattern_pos = Vector3(0.216075, 0.445028, 0)
	self.armor_skins.cvc_avenger.uv_offset_rot = Vector3(0.00374075, 0.996331, 0)
	self.armor_skins.cvc_avenger.uv_scale = Vector3(1, 1, 1)
	self.armor_skins.cvc_avenger_lbv = {}
	self.armor_skins.cvc_avenger_lbv.name_id = "bm_askn_cvc_avenger_lbv"
	self.armor_skins.cvc_avenger_lbv.desc_id = "bm_askn_cvc_avenger_lbv_desc"
	self.armor_skins.cvc_avenger_lbv.rarity = "rare"
	self.armor_skins.cvc_avenger_lbv.sorted = false
	self.armor_skins.cvc_avenger_lbv.reserve_quality = true
	self.armor_skins.cvc_avenger_lbv.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_avenger_lbv.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_011_df")
	self.armor_skins.cvc_avenger_lbv.pattern_gradient = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_003_df")
	self.armor_skins.cvc_avenger_lbv.pattern = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
	self.armor_skins.cvc_avenger_lbv.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_005_b_df")
	self.armor_skins.cvc_avenger_lbv.pattern_tweak = Vector3(2.01765, 0, 1)
	self.armor_skins.cvc_avenger_lbv.pattern_pos = Vector3(0.216075, 0.445028, 0)
	self.armor_skins.cvc_avenger_lbv.uv_scale = Vector3(1.3592, 2.26502, 1)
	self.armor_skins.cvc_avenger_lbv.uv_offset_rot = Vector3(-0.00333866, 1.33222, 3.13635)
	self.armor_skins.cvc_swat = {}
	self.armor_skins.cvc_swat.name_id = "bm_askn_cvc_swat"
	self.armor_skins.cvc_swat.desc_id = "bm_askn_cvc_swat_desc"
	self.armor_skins.cvc_swat.rarity = "rare"
	self.armor_skins.cvc_swat.reserve_quality = false
	self.armor_skins.cvc_swat.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_swat.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_006_df")
	self.armor_skins.cvc_swat.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_002_df")
	self.armor_skins.cvc_swat.uv_scale = Vector3(1, 1, 0)
	self.armor_skins.cvc_swat.uv_offset_rot = Vector3(0, 0.99987, 0)
	self.armor_skins.cvc_swat_lbv = {}
	self.armor_skins.cvc_swat_lbv.name_id = "bm_askn_cvc_swat_lbv"
	self.armor_skins.cvc_swat_lbv.desc_id = "bm_askn_cvc_swat_lbv_desc"
	self.armor_skins.cvc_swat_lbv.rarity = "epic"
	self.armor_skins.cvc_swat_lbv.sorted = false
	self.armor_skins.cvc_swat_lbv.reserve_quality = true
	self.armor_skins.cvc_swat_lbv.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_swat_lbv.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_008_df")
	self.armor_skins.cvc_swat_lbv.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_002_b_df")
	self.armor_skins.cvc_swat_lbv.uv_scale = Vector3(1.97897, 2.83711, 0)
	self.armor_skins.cvc_swat_lbv.uv_offset_rot = Vector3(0.0168202, 1.28452, 3.13635)
	self.armor_skins.cvc_bone = {}
	self.armor_skins.cvc_bone.name_id = "bm_askn_cvc_bone"
	self.armor_skins.cvc_bone.desc_id = "bm_askn_cvc_bone_desc"
	self.armor_skins.cvc_bone.rarity = "epic"
	self.armor_skins.cvc_bone.reserve_quality = false
	self.armor_skins.cvc_bone.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_bone.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_011_df")
	self.armor_skins.cvc_bone.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_004_df")
	self.armor_skins.cvc_bone.uv_scale = Vector3(1, 1, 1)
	self.armor_skins.cvc_bone.uv_offset_rot = Vector3(-0.001, 0.994791, 0)
	self.armor_skins.cvc_bone.cubemap_pattern_control = Vector3(0, 0.001, 0)
	self.armor_skins.cvc_bone_lbv = {}
	self.armor_skins.cvc_bone_lbv.name_id = "bm_askn_cvc_bone"
	self.armor_skins.cvc_bone_lbv.desc_id = "bm_askn_cvc_bone_desc"
	self.armor_skins.cvc_bone_lbv.rarity = "rare"
	self.armor_skins.cvc_bone_lbv.sorted = false
	self.armor_skins.cvc_bone_lbv.reserve_quality = true
	self.armor_skins.cvc_bone_lbv.texture_bundle_folder = "cash/safes/cvc"
	self.armor_skins.cvc_bone_lbv.base_gradient = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_011_df")
	self.armor_skins.cvc_bone_lbv.sticker = Idstring("units/payday2_cash/safes/cvc/sticker/cvc_sticker_004_df")
	self.armor_skins.cvc_bone_lbv.uv_scale = Vector3(0.69175, 0.834774, 1)
	self.armor_skins.cvc_bone_lbv.uv_offset_rot = Vector3(0.416408, 1.14143, 3.12136)
	self.armor_skins.cvc_bone_lbv.cubemap_pattern_control = Vector3(0, 0.001, 0)
end
