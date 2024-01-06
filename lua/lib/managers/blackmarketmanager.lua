BlackMarketManager = BlackMarketManager or class()
local INV_TO_CRAFT = Idstring("inventory_to_crafted")
local CRAFT_TO_INV = Idstring("crafted_to_inventroy")
local INV_ADD = Idstring("add_to_inventory")
local INV_REMOVE = Idstring("remove_from_inventory")
local CRAFT_ADD = Idstring("add_to_crafted")
local CRAFT_REMOVE = Idstring("remove_from_crafted")

function BlackMarketManager:init()
	self:_setup()
end

function BlackMarketManager:_setup()
	self._defaults = {}
	self._defaults.mask = "character_locked"
	self._defaults.character = "locked"
	self._defaults.armor = "level_1"
	self._defaults.preferred_character = "russian"
	self._defaults.grenade = "frag"
	self._defaults.melee_weapon = "weapon"
	if not Global.blackmarket_manager then
		Global.blackmarket_manager = {}
		self:_setup_armors()
		self:_setup_weapons()
		self:_setup_characters()
		self:_setup_track_global_values()
		self:_setup_unlocked_mask_slots()
		self:_setup_unlocked_weapon_slots()
		self:_setup_grenades()
		self:_setup_melee_weapons()
		Global.blackmarket_manager.inventory = {}
		Global.blackmarket_manager.crafted_items = {}
		Global.blackmarket_manager.new_drops = {}
		Global.blackmarket_manager.new_item_type_unlocked = {}
	end
	self._global = Global.blackmarket_manager
	self._preloading_list = {}
	self._preloading_index = 0
	self._category_resource_loaded = {}
end

function BlackMarketManager:init_finalize()
	print("BlackMarketManager:init_finalize()")
end

function BlackMarketManager:_setup_armors()
	local armors = {}
	Global.blackmarket_manager.armors = armors
	for armor, _ in pairs(tweak_data.blackmarket.armors) do
		armors[armor] = {
			unlocked = false,
			owned = false,
			equipped = false
		}
	end
	armors[self._defaults.armor].owned = true
	armors[self._defaults.armor].equipped = true
	armors[self._defaults.armor].unlocked = true
end

function BlackMarketManager:_setup_grenades()
	local grenades = {}
	Global.blackmarket_manager.grenades = grenades
	for grenade_id, grenade in pairs(tweak_data.blackmarket.grenades) do
		if grenade.throwable then
			grenades[grenade_id] = {
				unlocked = false,
				equipped = false,
				level = 0,
				skill_based = false,
				amount = 0
			}
			local is_default, weapon_level = managers.upgrades:get_value(grenade_id, self._defaults.grenade)
			grenades[grenade_id].level = weapon_level
			grenades[grenade_id].skill_based = not is_default and weapon_level == 0 and not tweak_data.blackmarket.grenades[grenade_id].dlc
		end
	end
	grenades[self._defaults.grenade].equipped = false
	grenades[self._defaults.grenade].unlocked = false
	grenades[self._defaults.grenade].amount = 0
end

function BlackMarketManager:_setup_melee_weapons()
	local melee_weapons = {}
	Global.blackmarket_manager.melee_weapons = melee_weapons
	for melee_weapon, _ in pairs(tweak_data.blackmarket.melee_weapons) do
		melee_weapons[melee_weapon] = {
			unlocked = false,
			equipped = false,
			owned = false,
			durability = 1,
			level = 0,
			skill_based = false
		}
		local is_default, weapon_level = managers.upgrades:get_value(melee_weapon, self._defaults.melee_weapon)
		melee_weapons[melee_weapon].level = weapon_level
		melee_weapons[melee_weapon].skill_based = not is_default and weapon_level == 0 and not tweak_data.blackmarket.melee_weapons[melee_weapon].dlc
	end
	melee_weapons[self._defaults.melee_weapon].equipped = true
	melee_weapons[self._defaults.melee_weapon].owned = true
	melee_weapons[self._defaults.melee_weapon].level = 0
end

function BlackMarketManager:_setup_track_global_values()
	local global_value_items = self._global and self._global.global_value_items or {}
	Global.blackmarket_manager.global_value_items = global_value_items
	local new_to_track = false
	for gv, td in pairs(tweak_data.lootdrop.global_values) do
		if td.track then
			new_to_track = new_to_track or not global_value_items[gv] or not global_value_items[gv].crafted_items or not global_value_items[gv].inventory
			global_value_items[gv] = global_value_items[gv] or {}
			global_value_items[gv].crafted_items = global_value_items[gv].crafted_items or {}
			global_value_items[gv].inventory = global_value_items[gv].inventory or {}
		end
	end
	return new_to_track
end

function BlackMarketManager:_setup_masks()
	local masks = {}
	Global.blackmarket_manager.masks = masks
	for mask, _ in pairs(tweak_data.blackmarket.masks) do
		masks[mask] = {
			unlocked = true,
			owned = true,
			equipped = false
		}
	end
	masks[self._defaults.mask].owned = true
	masks[self._defaults.mask].equipped = true
end

function BlackMarketManager:_setup_characters()
	local characters = {}
	Global.blackmarket_manager.characters = characters
	for character, _ in pairs(tweak_data.blackmarket.characters) do
		characters[character] = {
			unlocked = true,
			owned = true,
			equipped = false
		}
	end
	characters[self._defaults.character].owned = true
	characters[self._defaults.character].equipped = true
	Global.blackmarket_manager._preferred_character = self._defaults.preferred_character
end

function BlackMarketManager:_setup_weapon_upgrades()
	local weapon_upgrades = {}
	Global.blackmarket_manager.weapon_upgrades = weapon_upgrades
	for weapon, _ in pairs(tweak_data.weapon_upgrades.weapon) do
		weapon_upgrades[weapon] = {}
		for upgrades, data in pairs(tweak_data.weapon_upgrades.weapon[weapon]) do
			for _, upgrade in ipairs(data) do
				weapon_upgrades[weapon][upgrade] = {
					unlocked = true,
					owned = true,
					attached = false
				}
			end
		end
	end
	weapon_upgrades.m4.m4_scope1.attached = false
	weapon_upgrades.m4.scope2.owned = false
	weapon_upgrades.m4.scope3.unlocked = false
	weapon_upgrades.m4.scope3.owned = false
	weapon_upgrades.m4.grip1.unlocked = false
	weapon_upgrades.m4.grip1.owned = false
	weapon_upgrades.m14.m14_scope1.attached = true
	weapon_upgrades.m14.m14_scope2.owned = false
	weapon_upgrades.m14.barrel1.owned = false
	weapon_upgrades.m14.scope3.unlocked = false
	weapon_upgrades.m14.scope3.owned = false
	weapon_upgrades.raging_bull.grip1.unlocked = false
	weapon_upgrades.raging_bull.grip1.owned = false
end

function BlackMarketManager:_setup_unlocked_mask_slots()
	local unlocked_mask_slots = {}
	Global.blackmarket_manager.unlocked_mask_slots = unlocked_mask_slots
	for i = 1, 9 do
		unlocked_mask_slots[i] = true
	end
end

function BlackMarketManager:_setup_unlocked_weapon_slots()
	local unlocked_weapon_slots = {}
	Global.blackmarket_manager.unlocked_weapon_slots = unlocked_weapon_slots
	unlocked_weapon_slots.primaries = unlocked_weapon_slots.primaries or {}
	unlocked_weapon_slots.secondaries = unlocked_weapon_slots.secondaries or {}
	for i = 1, 9 do
		unlocked_weapon_slots.primaries[i] = true
		unlocked_weapon_slots.secondaries[i] = true
	end
end

function BlackMarketManager:_setup_weapons()
	local weapons = {}
	Global.blackmarket_manager.weapons = weapons
	for weapon, data in pairs(tweak_data.weapon) do
		if data.autohit then
			local selection_index = data.use_data.selection_index
			local equipped = weapon == managers.player:weapon_in_slot(selection_index)
			local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon)
			weapons[weapon] = {
				owned = false,
				unlocked = false,
				factory_id = factory_id,
				selection_index = selection_index
			}
			local is_default, weapon_level, got_parent = managers.upgrades:get_value(weapon)
			weapons[weapon].level = weapon_level
			weapons[weapon].skill_based = got_parent or not is_default and weapon_level == 0 and not tweak_data.weapon[weapon].global_value
		end
	end
end

BlackMarketManager.weapons_to_buy = {}
BlackMarketManager.weapons_to_buy.mac11 = true
BlackMarketManager.weapons_to_buy.raging_bull = true

function BlackMarketManager:mask_data(mask)
	return Global.blackmarket_manager.masks[mask]
end

function BlackMarketManager:weapon_unlocked(weapon_id)
	return Global.blackmarket_manager.weapons[weapon_id].unlocked
end

function BlackMarketManager:weapon_level(weapon_id)
	for level, level_data in pairs(tweak_data.upgrades.level_tree) do
		for _, upgrade in ipairs(level_data.upgrades) do
			if upgrade == weapon_id then
				return level
			end
		end
	end
	return 0
end

function BlackMarketManager:equipped_item(category)
	if category == "primaries" then
		return self:equipped_primary()
	elseif category == "secondaries" then
		return self:equipped_secondary()
	elseif category == "masks" then
		return self:equipped_mask()
	elseif category == "character" then
		return self:equipped_character()
	elseif category == "armors" then
		return self:equipped_armor()
	elseif category == "melee_weapons" then
		return self:equipped_melee_weapon()
	elseif category == "grenades" then
		return self:equipped_grenade()
	end
end

function BlackMarketManager:equipped_character()
	for character_id, data in pairs(tweak_data.blackmarket.characters) do
		if Global.blackmarket_manager.characters[character_id].equipped then
			return character_id
		end
	end
end

function BlackMarketManager:equipped_mask()
	if not Global.blackmarket_manager.crafted_items.masks then
		self:aquire_default_masks()
	end
	for slot, data in pairs(Global.blackmarket_manager.crafted_items.masks) do
		if data.equipped then
			return data
		end
	end
end

function BlackMarketManager:equipped_mask_slot()
	if not Global.blackmarket_manager.crafted_items.masks then
		self:aquire_default_masks()
	end
	for slot, data in pairs(Global.blackmarket_manager.crafted_items.masks) do
		if data.equipped then
			return slot
		end
	end
end

function BlackMarketManager:equipped_armor(chk_armor_kit)
	if chk_armor_kit then
		local equipped_deployable = Global.player_manager.kit.equipment_slots[1]
		if equipped_deployable == "armor_kit" and (not managers.player:has_equipment(equipped_deployable) or managers.player:has_deployable_left(equipped_deployable)) then
			return self._defaults.armor
		end
	end
	local armor
	for armor_id, data in pairs(tweak_data.blackmarket.armors) do
		armor = Global.blackmarket_manager.armors[armor_id]
		if armor.equipped and armor.unlocked and armor.owned then
			return armor_id
		end
	end
	return self._defaults.armor
end

function BlackMarketManager:equipped_grenade()
	local grenade
	for grenade_id, data in pairs(tweak_data.blackmarket.grenades) do
		grenade = Global.blackmarket_manager.grenades[grenade_id]
		if data.throwable and grenade.equipped and grenade.unlocked then
			return grenade_id, grenade.amount or 0
		end
	end
	return self._defaults.grenade, Global.blackmarket_manager.grenades[self._defaults.grenade].amount
end

function BlackMarketManager:equipped_melee_weapon()
	local melee_weapon
	for melee_weapon_id, data in pairs(tweak_data.blackmarket.melee_weapons) do
		melee_weapon = Global.blackmarket_manager.melee_weapons[melee_weapon_id]
		if melee_weapon.equipped and melee_weapon.unlocked then
			return melee_weapon_id
		end
	end
	self:aquire_default_weapons()
	return self._defaults.melee_weapon
end

function BlackMarketManager:equipped_melee_weapon_damage_info(lerp_value)
	lerp_value = lerp_value or 0
	local melee_entry = self:equipped_melee_weapon()
	local stats = tweak_data.blackmarket.melee_weapons[melee_entry].stats
	local primary = self:equipped_primary()
	local bayonet_id = self:equipped_bayonet(primary.weapon_id)
	local player = managers.player:player_unit()
	if bayonet_id and player:movement():current_state()._equipped_unit:base():selection_index() == 2 and melee_entry == "weapon" then
		stats = tweak_data.weapon.factory.parts[bayonet_id].stats
	end
	local dmg = math.lerp(stats.min_damage, stats.max_damage, lerp_value)
	local dmg_effect = dmg * math.lerp(stats.min_damage_effect, stats.max_damage_effect, lerp_value)
	return dmg, dmg_effect
end

function BlackMarketManager:equipped_secondary()
	if not Global.blackmarket_manager.crafted_items.secondaries then
		self:aquire_default_weapons()
	end
	for slot, data in pairs(Global.blackmarket_manager.crafted_items.secondaries) do
		if data.equipped then
			return data
		end
	end
	self:aquire_default_weapons()
end

function BlackMarketManager:equipped_primary()
	if not Global.blackmarket_manager.crafted_items.primaries then
		self:aquire_default_weapons()
	end
	for slot, data in pairs(Global.blackmarket_manager.crafted_items.primaries) do
		if data.equipped then
			return data
		end
	end
	return nil
end

function BlackMarketManager:equipped_weapon_slot(category)
	if not Global.blackmarket_manager.crafted_items[category] then
		return nil
	end
	for slot, data in pairs(Global.blackmarket_manager.crafted_items[category]) do
		if data.equipped then
			return slot
		end
	end
	return nil
end

function BlackMarketManager:equipped_armor_slot()
	if not Global.blackmarket_manager.armors then
		return nil
	end
	for slot, data in pairs(Global.blackmarket_manager.armors) do
		if data.equipped then
			return slot
		end
	end
	return nil
end

function BlackMarketManager:equipped_grenade_slot()
	if not Global.blackmarket_manager.grenades then
		return nil
	end
	for slot, data in pairs(Global.blackmarket_manager.grenades) do
		if data.equipped then
			return slot
		end
	end
	return nil
end

function BlackMarketManager:equipped_melee_weapon_slot()
	if not Global.blackmarket_manager.melee_weapons then
		return nil
	end
	for slot, data in pairs(Global.blackmarket_manager.melee_weapons) do
		if data.equipped then
			return slot
		end
	end
	return nil
end

function BlackMarketManager:equipped_bayonet(weapon_id)
	local available_weapon_mods = managers.weapon_factory:get_parts_from_weapon_id(weapon_id)
	local equipped_weapon_mods = managers.blackmarket:equipped_item("primaries").blueprint
	if available_weapon_mods and available_weapon_mods.bayonet then
		for _, mod in ipairs(equipped_weapon_mods) do
			for _, bayonet in ipairs(available_weapon_mods.bayonet) do
				if mod == bayonet then
					return bayonet
				end
			end
		end
	end
	return nil
end

function BlackMarketManager:_check_achievements(category)
	local cat_ids = Idstring(category)
	if cat_ids == Idstring("primaries") then
		local equipped = self:equipped_primary()
		if equipped.weapon_id == tweak_data.achievement.steam_500k then
			managers.achievment:award("gage3_1")
		end
	elseif cat_ids == Idstring("secondaries") then
		local equipped = self:equipped_secondary()
		if equipped.weapon_id == tweak_data.achievement.unique_selling_point then
			managers.achievment:award("halloween_9")
		end
		if equipped.weapon_id == tweak_data.achievement.vote_for_change then
			managers.achievment:award("bob_1")
		end
	elseif cat_ids == Idstring("melee_weapons") then
		local equipped = managers.blackmarket:equipped_melee_weapon()
		if equipped == tweak_data.achievement.demise_knuckles then
			managers.achievment:award("death_31")
		end
	elseif cat_ids == Idstring("armors") then
		local equipped = managers.blackmarket:equipped_armor()
		if equipped ~= tweak_data.achievement.how_do_you_like_me_now then
			managers.achievment:award("how_do_you_like_me_now")
		end
		if equipped == tweak_data.achievement.iron_man then
			managers.achievment:award("iron_man")
		end
	elseif cat_ids == Idstring("masks") then
		local equipped = managers.blackmarket:equipped_mask()
		if equipped.mask_id == tweak_data.achievement.like_an_angry_bear then
			managers.achievment:award("like_an_angry_bear")
		end
		if equipped.mask_id == tweak_data.achievement.merry_christmas then
			managers.achievment:award("charliesierra_3")
		end
		if equipped.mask_id == tweak_data.achievement.heat_around_the_corner then
			managers.achievment:award("armored_11")
		end
	end
	if cat_ids == Idstring("primaries") or cat_ids == Idstring("secondaries") or cat_ids == Idstring("armors") then
		local equipped_primary = self:equipped_primary()
		local equipped_secondary = self:equipped_secondary()
		local equipped_armor = self:equipped_armor()
		local achievement = tweak_data.achievement.one_man_army
		if equipped_primary.weapon_id == achievement.equipped.primary and equipped_secondary.weapon_id == achievement.equipped.secondary and equipped_armor == achievement.equipped.armor then
			managers.achievment:award(achievement.award)
		end
	end
end

function BlackMarketManager:equip_weapon(category, slot)
	if not Global.blackmarket_manager.crafted_items[category] then
		return nil
	end
	for s, data in pairs(Global.blackmarket_manager.crafted_items[category]) do
		data.equipped = s == slot
	end
	self:_check_achievements(category)
	if managers.menu_scene then
		local data = category == "primaries" and self:equipped_primary() or self:equipped_secondary()
		managers.menu_scene:set_character_equipped_weapon(nil, data.factory_id, data.blueprint, category == "primaries" and "primary" or "secondary")
	end
	MenuCallbackHandler:_update_outfit_information()
	if managers.hud then
		managers.hud:recreate_weapon_firemode(HUDManager.PLAYER_PANEL)
	end
end

function BlackMarketManager:equip_deployable(deployable_id, loading)
	Global.player_manager.kit.equipment_slots[1] = deployable_id
	if not loading then
		MenuCallbackHandler:_update_outfit_information()
	end
end

function BlackMarketManager:equip_character(character_id)
	for s, data in pairs(Global.blackmarket_manager.characters) do
		data.equipped = s == character_id
	end
	if managers.menu_scene then
		managers.menu_scene:set_character(character_id)
	end
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:equip_armor(armor_id)
	for s, data in pairs(Global.blackmarket_manager.armors) do
		data.equipped = s == armor_id
	end
	self:_check_achievements("armors")
	if managers.menu_scene then
		managers.menu_scene:set_character_armor(armor_id)
	end
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:equip_grenade(grenade_id)
	for s, data in pairs(Global.blackmarket_manager.grenades) do
		data.equipped = s == grenade_id
	end
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:equip_melee_weapon(melee_weapon_id)
	for s, data in pairs(Global.blackmarket_manager.melee_weapons) do
		data.equipped = s == melee_weapon_id
	end
	self:_check_achievements("melee_weapons")
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:_update_cached_mask()
	do return end
	if SystemInfo:platform() ~= Idstring("X360") then
		return
	end
	Application:debug("[BlackMarketManager:_update_cached_mask()]")
	local old_cached_mask = Global.cached_player_mask
	if old_cached_mask and old_cached_mask.mask_id ~= "character_locked" then
		local blueprint = old_cached_mask.blueprint
		local pattern_id = blueprint.pattern.id
		local material_id = blueprint.material.id
		local pattern = Idstring(tweak_data.blackmarket.textures[pattern_id].texture)
		local reflection = Idstring(tweak_data.blackmarket.materials[material_id].texture)
		managers.dyn_resource:unload(Idstring("unit"), Idstring(tweak_data.blackmarket.masks[old_cached_mask.mask_id].unit), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
		TextureCache:unretrieve(pattern)
		TextureCache:unretrieve(reflection)
	end
	Global.cached_player_mask = nil
end

function BlackMarketManager:equip_mask(slot)
	local category = "masks"
	if not Global.blackmarket_manager.crafted_items[category] then
		return nil
	end
	for s, data in pairs(Global.blackmarket_manager.crafted_items[category]) do
		data.equipped = s == slot
	end
	self:_check_achievements("masks")
	local new_mask_data = Global.blackmarket_manager.crafted_items[category][slot]
	if managers.menu_scene then
		managers.menu_scene:set_character_mask_by_id(new_mask_data.mask_id, new_mask_data.blueprint)
	end
	if SystemInfo:platform() == Idstring("X360") then
		repeat
			do break end -- pseudo-goto
			local old_cached_mask = Global.cached_player_mask
			Global.cached_player_mask = new_mask_data
			Application:debug("[BlackMarketManager:equip_mask()] Set cached mask")
			if new_mask_data and new_mask_data.mask_id ~= "character_locked" then
				local blueprint = new_mask_data.blueprint
				local pattern_id = blueprint.pattern.id
				local material_id = blueprint.material.id
				local pattern = tweak_data.blackmarket.textures[pattern_id].texture
				local reflection = tweak_data.blackmarket.materials[material_id].texture
				managers.dyn_resource:load(Idstring("unit"), Idstring(tweak_data.blackmarket.masks[new_mask_data.mask_id].unit), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
				TextureCache:retrieve(pattern, "NORMAL")
				TextureCache:retrieve(reflection, "NORMAL")
			end
			if old_cached_mask and old_cached_mask.mask_id ~= "character_locked" then
				local blueprint = old_cached_mask.blueprint
				local pattern_id = blueprint.pattern.id
				local material_id = blueprint.material.id
				local pattern = Idstring(tweak_data.blackmarket.textures[pattern_id].texture)
				local reflection = Idstring(tweak_data.blackmarket.materials[material_id].texture)
				managers.dyn_resource:unload(Idstring("unit"), Idstring(tweak_data.blackmarket.masks[old_cached_mask.mask_id].unit), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
				TextureCache:unretrieve(pattern)
				TextureCache:unretrieve(reflection)
			end
		until true
	end
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:mask_blueprint_from_outfit_string(outfit_string)
	local data = string.split(outfit_string or "", " ")
	local color_id = data[self:outfit_string_index("mask_color")] or "nothing"
	local pattern_id = data[self:outfit_string_index("mask_pattern")] or "no_color_no_material"
	local material_id = data[self:outfit_string_index("mask_material")] or "plastic"
	local blueprint = {}
	blueprint.color = {id = color_id}
	blueprint.pattern = {id = pattern_id}
	blueprint.material = {id = material_id}
	return blueprint
end

function BlackMarketManager:_outfit_string_mask()
	local s = ""
	local equipped = managers.blackmarket:equipped_mask()
	if type(equipped) == "string" then
		s = s .. " " .. equipped
		s = s .. " " .. "nothing"
		s = s .. " " .. "no_color_no_material"
		s = s .. " " .. "plastic"
	else
		s = s .. " " .. equipped.mask_id
		s = s .. " " .. equipped.blueprint.color.id
		s = s .. " " .. equipped.blueprint.pattern.id
		s = s .. " " .. equipped.blueprint.material.id
	end
	return s
end

function BlackMarketManager:outfit_string_index(type)
	if type == "mask" then
		return 1
	end
	if type == "mask_color" then
		return 2
	end
	if type == "mask_pattern" then
		return 3
	end
	if type == "mask_material" then
		return 4
	end
	if type == "armor" then
		return 5
	end
	if type == "character" then
		return 6
	end
	if type == "primary" then
		return 7
	end
	if type == "primary_blueprint" then
		return 8
	end
	if type == "secondary" then
		return 9
	end
	if type == "secondary_blueprint" then
		return 10
	end
	if type == "deployable" then
		return 11
	end
	if type == "deployable_amount" then
		return 12
	end
	if type == "concealment_modifier" then
		return 13
	end
	if type == "melee_weapon" then
		return 14
	end
	if type == "grenade" then
		return 15
	end
	if type == "skills" then
		return 16
	end
end

function BlackMarketManager:unpack_outfit_from_string(outfit_string)
	local data = string.split(outfit_string or "", " ")
	local outfit = {}
	outfit.character = data[self:outfit_string_index("character")] or self._defaults.character
	outfit.mask = {}
	outfit.mask.mask_id = data[self:outfit_string_index("mask")] or self._defaults.mask
	outfit.mask.blueprint = self:mask_blueprint_from_outfit_string(outfit_string)
	local armor_string = data[self:outfit_string_index("armor")] or tostring(self._defaults.armor)
	local armor_data = string.split(armor_string, "-")
	outfit.armor = armor_data[1]
	outfit.armor_current = armor_data[2] or outfit.armor
	outfit.primary = {}
	outfit.primary.factory_id = data[self:outfit_string_index("primary")] or "wpn_fps_ass_amcar"
	local primary_blueprint_string = data[self:outfit_string_index("primary_blueprint")]
	if primary_blueprint_string then
		primary_blueprint_string = string.gsub(primary_blueprint_string, "_", " ")
		outfit.primary.blueprint = managers.weapon_factory:unpack_blueprint_from_string(outfit.primary.factory_id, primary_blueprint_string)
	else
		outfit.primary.blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(outfit.primary.factory_id)
	end
	outfit.secondary = {}
	outfit.secondary.factory_id = data[self:outfit_string_index("secondary")] or "wpn_fps_pis_g17"
	local secondary_blueprint_string = data[self:outfit_string_index("secondary_blueprint")]
	if secondary_blueprint_string then
		secondary_blueprint_string = string.gsub(secondary_blueprint_string, "_", " ")
		outfit.secondary.blueprint = managers.weapon_factory:unpack_blueprint_from_string(outfit.secondary.factory_id, secondary_blueprint_string)
	else
		outfit.secondary.blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(outfit.secondary.factory_id)
	end
	outfit.melee_weapon = data[self:outfit_string_index("melee_weapon")] or self._defaults.melee_weapon
	outfit.grenade = data[self:outfit_string_index("grenade")] or self._defaults.grenade
	outfit.deployable = data[self:outfit_string_index("deployable")] or nil
	outfit.deployable_amount = tonumber(data[self:outfit_string_index("deployable_amount")] or "0")
	outfit.concealment_modifier = data[self:outfit_string_index("concealment_modifier")] or 0
	outfit.skills = managers.skilltree:unpack_from_string(data[self:outfit_string_index("skills")])
	return outfit
end

function BlackMarketManager:outfit_string()
	local s = ""
	s = s .. self:_outfit_string_mask()
	local armor_id = tostring(self:equipped_armor(false))
	local current_armor_id = tostring(self:equipped_armor(true))
	s = s .. " " .. armor_id .. "-" .. current_armor_id
	for character_id, data in pairs(tweak_data.blackmarket.characters) do
		if Global.blackmarket_manager.characters[character_id].equipped then
			s = s .. " " .. character_id
		end
	end
	local equipped_primary = self:equipped_primary()
	if equipped_primary then
		local primary_string = managers.weapon_factory:blueprint_to_string(equipped_primary.factory_id, equipped_primary.blueprint)
		primary_string = string.gsub(primary_string, " ", "_")
		s = s .. " " .. equipped_primary.factory_id .. " " .. primary_string
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end
	local equipped_secondary = self:equipped_secondary()
	if equipped_secondary then
		local secondary_string = managers.weapon_factory:blueprint_to_string(equipped_secondary.factory_id, equipped_secondary.blueprint)
		secondary_string = string.gsub(secondary_string, " ", "_")
		s = s .. " " .. equipped_secondary.factory_id .. " " .. secondary_string
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end
	local equipped_deployable = Global.player_manager.kit.equipment_slots[1]
	if equipped_deployable then
		s = s .. " " .. tostring(equipped_deployable)
		local deployable_tweak_data = tweak_data.equipments[equipped_deployable]
		local amount = (deployable_tweak_data.quantity or 0) + managers.player:equiptment_upgrade_value(equipped_deployable, "quantity")
		s = s .. " " .. tostring(amount)
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end
	local concealment_modifier = -self:visibility_modifiers() or 0
	s = s .. " " .. tostring(concealment_modifier)
	local equipped_melee_weapon = self:equipped_melee_weapon()
	s = s .. " " .. tostring(equipped_melee_weapon)
	local equipped_grenade = self:equipped_grenade()
	s = s .. " " .. tostring(equipped_grenade)
	s = s .. " " .. tostring(managers.skilltree:pack_to_string())
	return s
end

function BlackMarketManager:load_equipped_weapons()
	do
		local weapon = self:equipped_primary()
		managers.weapon_factory:preload_blueprint(weapon.factory_id, weapon.blueprint, false, callback(self, self, "resource_loaded_callback", "primaries"), false)
	end
	local weapon = self:equipped_secondary()
	managers.weapon_factory:preload_blueprint(weapon.factory_id, weapon.blueprint, false, callback(self, self, "resource_loaded_callback", "secondaries"), false)
end

function BlackMarketManager:load_all_crafted_weapons()
	print("--PRIMARIES-------------------------")
	for i, weapon in pairs(self._global.crafted_items.primaries) do
		print("loading crafted weapon", "index", i, "weapon", weapon)
		managers.weapon_factory:preload_blueprint(weapon.factory_id, weapon.blueprint, false, callback(self, self, "resource_loaded_callback", "primaries" .. tostring(i)), false)
	end
	print("--SECONDARIES-----------------------")
	for i, weapon in pairs(self._global.crafted_items.secondaries) do
		print("loading crafted weapon", "index", i, "weapon", weapon)
		managers.weapon_factory:preload_blueprint(weapon.factory_id, weapon.blueprint, false, callback(self, self, "resource_loaded_callback", "secondaries" .. tostring(i)), false)
	end
end

function BlackMarketManager:preload_equipped_weapons()
	self:preload_primary_weapon()
	self:preload_secondary_weapon()
end

function BlackMarketManager:preload_primary_weapon()
	local weapon = self:equipped_primary()
	self:preload_weapon_blueprint("primaries", weapon.factory_id, weapon.blueprint)
end

function BlackMarketManager:preload_secondary_weapon()
	local weapon = self:equipped_secondary()
	self:preload_weapon_blueprint("secondaries", weapon.factory_id, weapon.blueprint)
end

function BlackMarketManager:preload_weapon_blueprint(category, factory_id, blueprint)
	Application:debug("[BlackMarketManager] preload_weapon_blueprint():", "category", category, "factory_id", factory_id, "blueprint", inspect(blueprint))
	local parts = managers.weapon_factory:preload_blueprint(factory_id, blueprint, false, function()
	end, true)
	for part_id, part in pairs(parts) do
		local new_loading = {}
		if part.package then
			new_loading = {
				package = part.package
			}
		else
			new_loading = {load_me = part}
		end
		if Application:production_build() then
			new_loading.part_id = part_id
		end
		table.insert(self._preloading_list, new_loading)
	end
	table.insert(self._preloading_list, {category, parts})
end

function BlackMarketManager:resource_loaded_callback(category, loaded_table, parts)
	local loaded_category = self._category_resource_loaded[category]
	if loaded_category then
		for part_id, unload in pairs(loaded_category) do
			if unload.package then
				managers.weapon_factory:unload_package(unload.package)
			else
				managers.dyn_resource:unload(Idstring("unit"), unload.name, managers.dyn_resource.DYN_RESOURCES_PACKAGE, false)
			end
		end
	end
	self._category_resource_loaded[category] = loaded_table
end

function BlackMarketManager:release_preloaded_blueprints()
	for category, data in pairs(self._category_resource_loaded) do
		for part_id, unload in pairs(data) do
			if unload.package then
				managers.weapon_factory:unload_package(unload.package)
			else
				managers.dyn_resource:unload(Idstring("unit"), unload.name, managers.dyn_resource.DYN_RESOURCES_PACKAGE, false)
			end
		end
	end
	self._category_resource_loaded = {}
end

function BlackMarketManager:is_preloading_weapons()
	return #self._preloading_list > 0
end

function BlackMarketManager:create_preload_ws()
	if self._preload_ws then
		return
	end
	self._preload_ws = managers.gui_data:create_fullscreen_workspace()
	local panel = self._preload_ws:panel()
	panel:set_layer(10000)
	local new_script = {}
	new_script.progress = 1
	
	function new_script.step_progress()
		new_script.set_progress(new_script.progress + 1)
	end
	
	function new_script.set_progress(progress)
		new_script.progress = progress
		local square_panel = panel:child("square_panel")
		local progress_rect = panel:child("progress")
		if progress == 0 then
			progress_rect:hide()
		end
		for i, child in ipairs(square_panel:children()) do
			child:set_color(progress > i and Color.white or Color(0.3, 0.3, 0.3))
			if i == progress then
				progress_rect:set_world_position(child:world_position())
				progress_rect:move(-3, -3)
				progress_rect:show()
			end
		end
	end
	
	panel:set_script(new_script)
	local square_panel = panel:panel({
		name = "square_panel",
		layer = 1
	})
	local num_squares = 0
	for i, preload in ipairs(self._preloading_list) do
		if preload.package or preload.load_me then
			num_squares = num_squares + 1
		end
	end
	local rows = math.max(1, math.ceil(num_squares / 8))
	local next_row_at = math.ceil(num_squares / rows)
	local row_index = 0
	local x = 0
	local y = 0
	local last_rect
	local max_w = 0
	local max_h = 0
	for i = 1, num_squares do
		row_index = row_index + 1
		last_rect = square_panel:rect({
			x = x,
			y = y,
			w = 14,
			h = 14,
			color = Color(0.3, 0.3, 0.3),
			blend_mode = "add"
		})
		x = x + 24
		max_w = math.max(max_w, last_rect:right())
		max_h = math.max(max_h, last_rect:bottom())
		if row_index == next_row_at then
			row_index = 0
			y = y + 24
			x = 0
		end
	end
	square_panel:set_size(max_w, max_h)
	panel:rect({
		name = "progress",
		w = 20,
		h = 20,
		color = Color(0.3, 0.3, 0.3),
		layer = 2,
		blend_mode = "add"
	})
	local bg = panel:rect({
		color = Color.black,
		alpha = 0.8
	})
	local width = square_panel:w() + 20
	local height = square_panel:h() + 20
	bg:set_size(width, height)
	bg:set_center(panel:w() / 2, panel:h() / 2)
	square_panel:set_center(bg:center())
	local box_panel = panel:panel({layer = 2})
	box_panel:set_shape(bg:shape())
	BoxGuiObject:new(box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	panel:script().set_progress(1)
	local fade_in_animation = function(panel)
		panel:hide()
		coroutine.yield()
		panel:show()
	end
	panel:animate(fade_in_animation)
end

function BlackMarketManager:buy_unlock_mask_slot(slot)
	managers.money:on_buy_mask_slot(slot)
	self:_unlock_mask_slot(slot)
end

function BlackMarketManager:_unlock_mask_slot(slot)
	if not self._global.unlocked_mask_slots then
		self:_setup_unlocked_mask_slots()
	end
	self._global.unlocked_mask_slots[slot] = true
end

function BlackMarketManager:_lock_mask_slot(slot)
	if not self._global.unlocked_mask_slots then
		self:_setup_unlocked_mask_slots()
	end
	self._global.unlocked_mask_slots[slot] = false
end

function BlackMarketManager:is_mask_slot_unlocked(slot)
	return self._global.unlocked_mask_slots and self._global.unlocked_mask_slots[slot] or false
end

function BlackMarketManager:buy_unlock_weapon_slot(category, slot)
	managers.money:on_buy_weapon_slot(slot)
	self:_unlock_weapon_slot(category, slot)
end

function BlackMarketManager:_unlock_weapon_slot(category, slot)
	if not self._global.unlocked_weapon_slots then
		self:_setup_unlocked_weapon_slots()
	end
	self._global.unlocked_weapon_slots[category][slot] = true
end

function BlackMarketManager:_lock_weapon_slot(category, slot)
	if not self._global.unlocked_weapon_slots then
		self:_setup_unlocked_weapon_slots()
	end
	self._global.unlocked_weapon_slots[category][slot] = false
end

function BlackMarketManager:is_weapon_slot_unlocked(category, slot)
	return self._global.unlocked_weapon_slots and self._global.unlocked_weapon_slots[category] and self._global.unlocked_weapon_slots[category][slot] or false
end

function BlackMarketManager:is_crafted_weapon_modified(category, slot)
	local weapon = self._global.crafted_items[category][slot]
	if not weapon then
		Application:error("BlackMarketManager:is_weapon_modified", "category", category, "slot", slot)
		return false
	end
	local factory_id = weapon.factory_id
	local blueprint = weapon.blueprint
	return self:is_weapon_modified(factory_id, blueprint)
end

function BlackMarketManager:is_weapon_modified(factory_id, blueprint)
	local weapon = tweak_data.weapon.factory[factory_id]
	if not weapon then
		Application:error("BlackMarketManager:is_weapon_modified", "factory_id", factory_id, "blueprint", inspect(blueprint))
		return false
	end
	local default_blueprint = weapon.default_blueprint
	for _, part_id in ipairs(blueprint) do
		if not table.contains(default_blueprint, part_id) then
			return true
		end
	end
	return false
end

function BlackMarketManager:update(t, dt)
	if #self._preloading_list > 0 then
		if not self._preload_ws then
			self:create_preload_ws()
		else
			self._preloading_index = self._preloading_index + 1
			if self._preloading_index > #self._preloading_list then
				self._preloading_list = {}
				self._preloading_index = 0
				if self._preload_ws then
					Overlay:gui():destroy_workspace(self._preload_ws)
					self._preload_ws = nil
				end
			else
				local next_in_line = self._preloading_list[self._preloading_index]
				local is_load = next_in_line.package or next_in_line.load_me and true or false
				local is_done_cb = not is_load and next_in_line.done_cb and true or false
				if is_load then
					if next_in_line.part_id then
					end
					if self._preload_ws then
						self._preload_ws:panel():script().step_progress()
					end
					if next_in_line.package then
						managers.weapon_factory:load_package(next_in_line.package)
					else
						managers.dyn_resource:load(Idstring("unit"), next_in_line.load_me.name, managers.dyn_resource.DYN_RESOURCES_PACKAGE, false)
					end
				elseif is_done_cb then
					if self._preload_ws then
						self._preload_ws:panel():script().set_progress(self._preloading_index)
					end
					next_in_line.done_cb()
				else
					if self._preload_ws then
						self._preload_ws:panel():script().set_progress(self._preloading_index)
					end
					self:resource_loaded_callback(unpack(next_in_line))
				end
			end
		end
	end
end

function BlackMarketManager:add_to_inventory(global_value, category, id, not_new)
	if category == "cash" then
		local value_id = tweak_data.blackmarket[category][id].value_id
		managers.money:on_loot_drop_cash(value_id)
	elseif category == "xp" then
		local value_id = tweak_data.blackmarket[category][id].value_id
		managers.experience:on_loot_drop_xp(value_id)
	end
	self._global.inventory[global_value] = self._global.inventory[global_value] or {}
	self._global.inventory[global_value][category] = self._global.inventory[global_value][category] or {}
	self._global.inventory[global_value][category][id] = (self._global.inventory[global_value][category][id] or 0) + 1
	if category ~= "cash" and category ~= "xp" then
		if not not_new and self._global.inventory[global_value][category][id] > 0 then
			self._global.new_drops[global_value] = self._global.new_drops[global_value] or {}
			self._global.new_drops[global_value][category] = self._global.new_drops[global_value][category] or {}
			self._global.new_drops[global_value][category][id] = true
		end
		if self._global.new_item_type_unlocked[category] == nil then
			self._global.new_item_type_unlocked[category] = id
		end
	end
	self:alter_global_value_item(global_value, category, nil, id, INV_ADD)
end

function BlackMarketManager:_add_gvi_to_inventory(global_value, category, id)
	self._global.global_value_items[global_value].inventory[category] = self._global.global_value_items[global_value].inventory[category] or {}
	local inv_data = self._global.global_value_items[global_value].inventory[category]
	inv_data[id] = (inv_data[id] or 0) + 1
end

function BlackMarketManager:_remove_gvi_from_inventory(global_value, category, id)
	local inv_data = self._global.global_value_items[global_value].inventory[category]
	if inv_data then
		inv_data[id] = (inv_data[id] or 0) - 1
		if inv_data[id] <= 0 then
			inv_data[id] = nil
		end
	end
end

function BlackMarketManager:_add_gvi_to_crafted_item(global_value, category, slot, id)
	self._global.global_value_items[global_value].crafted_items[category] = self._global.global_value_items[global_value].crafted_items[category] or {}
	local craft_data = self._global.global_value_items[global_value].crafted_items[category]
	craft_data[slot] = craft_data[slot] or {}
	craft_data[slot][id] = (craft_data[slot][id] or 0) + 1
end

function BlackMarketManager:_remove_gvi_from_crafted_item(global_value, category, slot, id)
	local craft_data = self._global.global_value_items[global_value].crafted_items[category]
	if craft_data then
		craft_data = craft_data[slot]
		if craft_data then
			craft_data[id] = (craft_data[id] or 0) - 1
			if craft_data[id] <= 0 then
				craft_data[id] = nil
			end
		end
	end
end

function BlackMarketManager:alter_global_value_item(global_value, category, slot, id, ...)
	if not self._global.global_value_items or not self._global.global_value_items[global_value] then
		return
	end
	local args = {
		...
	}
	for _, arg in pairs(args) do
		if arg == INV_TO_CRAFT then
			Application:debug("INV_TO_CRAFT is bugged for weapons, if this is from a weapon, change it!")
			self:_remove_gvi_from_inventory(global_value, category, id)
			self:_add_gvi_to_crafted_item(global_value, category, slot, id)
		elseif arg == CRAFT_TO_INV then
			Application:debug("CRAFT_TO_INV is bugged for weapons, if this is from a weapon, change it!")
			self:_add_gvi_to_inventory(global_value, category, id)
			self:_remove_gvi_from_crafted_item(global_value, category, slot, id)
		elseif arg == INV_ADD then
			self:_add_gvi_to_inventory(global_value, category, id)
		elseif arg == INV_REMOVE then
			self:_remove_gvi_from_inventory(global_value, category, id)
		elseif arg == CRAFT_ADD then
			self:_add_gvi_to_crafted_item(global_value, category, slot, id)
		else
			if arg == CRAFT_REMOVE then
				self:_remove_gvi_from_crafted_item(global_value, category, slot, id)
			else
			end
		end
	end
end

function BlackMarketManager:fetch_new_items_unlocked()
	local data = {}
	for category, value in pairs(self._global.new_item_type_unlocked) do
		if value then
			table.insert(data, {category, value})
			if category == "announcements" then
				for announcement_id, data in pairs(value) do
					self._global.new_item_type_unlocked[category][announcement_id] = false
				end
			else
				self._global.new_item_type_unlocked[category] = false
			end
		end
	end
	return data
end

function BlackMarketManager:remove_new_drop(global_value, category, id)
	if not self._global.new_drops[global_value] then
		return
	end
	if not self._global.new_drops[global_value][category] then
		return
	end
	self._global.new_drops[global_value][category][id] = nil
	if table.size(self._global.new_drops[global_value][category]) == 0 then
		self._global.new_drops[global_value][category] = nil
		if table.size(self._global.new_drops[global_value]) == 0 then
			self._global.new_drops[global_value] = nil
		end
	end
end

function BlackMarketManager:get_weapon_new_part_drops(id)
	local uses_parts = managers.weapon_factory:get_parts_from_factory_id(id) or {}
	local new_parts = {}
	for type, parts in pairs(uses_parts) do
		for _, part in ipairs(parts) do
			if self:check_new_drop("normal", "weapon_mods", part) then
				table.insert(new_parts, part)
			end
			if self:check_new_drop("infamous", "weapon_mods", part) then
				table.insert(new_parts, part)
			end
		end
	end
	return new_parts
end

function BlackMarketManager:check_new_drop(global_value, category, id)
	if not self._global.new_drops[global_value] then
		return false
	end
	if not self._global.new_drops[global_value][category] then
		return false
	end
	return self._global.new_drops[global_value][category][id] and true or false
end

function BlackMarketManager:check_new_drop_category(global_value, category)
	if not self._global.new_drops[global_value] then
		return false
	end
	if not self._global.new_drops[global_value][category] then
		return false
	end
	return table.size(self._global.new_drops[global_value][category]) > 0 and true or false
end

function BlackMarketManager:got_any_new_drop()
	local amount_new_loot = table.size(self._global.new_drops)
	if 0 < amount_new_loot then
		return true
	end
	return false
end

function BlackMarketManager:got_new_drop(global_value, category, id)
	local category_ids = Idstring(category)
	if category_ids == Idstring("primaries") or category_ids == Idstring("secondaries") then
		local uses_parts = managers.weapon_factory:get_parts_from_factory_id(id) or {}
		for type, parts in pairs(uses_parts) do
			for _, part in ipairs(parts) do
				local gv = tweak_data.weapon.factory.parts[part].dlc or "normal"
				if self:check_new_drop(gv, "weapon_mods", part) then
					return true
				end
			end
		end
	elseif category_ids == Idstring("weapon_mods") then
		if self:check_new_drop(global_value, "weapon_mods", id) then
			return true
		end
	elseif category_ids == Idstring("weapon_tabs") then
		local uses_parts = managers.weapon_factory:get_parts_from_factory_id(id)
		local tab_parts = uses_parts and uses_parts[global_value] or {}
		for type, part in ipairs(tab_parts) do
			if self:check_new_drop("normal", "weapon_mods", part) then
				return true
			end
			if self:check_new_drop("infamous", "weapon_mods", part) then
				return true
			end
		end
	elseif category_ids == Idstring("mask_mods") then
		local textures = managers.blackmarket:get_inventory_category("textures")
		local colors = managers.blackmarket:get_inventory_category("colors")
		local got_table = {}
		for _, mmod in ipairs({
			"colors",
			"materials",
			"textures"
		}) do
			if self:check_new_drop_category("normal", mmod) then
				got_table[mmod] = true
			elseif self:check_new_drop_category("infamous", mmod) then
				got_table[mmod] = true
			end
		end
		if got_table.textures then
			return 0 < #colors
		end
		if got_table.colors then
			return 0 < #textures
		end
		return 0 < table.size(got_table)
	elseif category_ids == Idstring("mask_buy") then
		if self:check_new_drop_category("normal", "masks") then
			return true
		end
		if self:check_new_drop_category("infamous", "masks") then
			return true
		end
	elseif category_ids == Idstring("weapon_buy") then
		if self:check_new_drop("normal", global_value, id) then
			return true
		end
	elseif category_ids == Idstring("weapon_buy_empty") then
		if self:check_new_drop_category("normal", global_value) then
			return true
		end
	elseif not id then
		if not global_value then
			if self:check_new_drop_category("normal", category) then
				return true
			end
			if self:check_new_drop_category("infamous", category) then
				return true
			end
		else
			return self:check_new_drop_category(global_value, category)
		end
	else
		return self:check_new_drop(global_value, category, id)
	end
	return false
end

function BlackMarketManager:get_inventory_category(category)
	local t = {}
	for global_value, categories in pairs(self._global.inventory) do
		if categories[category] then
			for id, amount in pairs(categories[category]) do
				table.insert(t, {
					id = id,
					global_value = global_value,
					amount = amount
				})
			end
		end
	end
	return t
end

function BlackMarketManager:merge_inventory_masks()
	local normals = self._global.inventory.normal.masks or {}
	for global_value, categories in pairs(self._global.inventory) do
		if global_value ~= "normal" and global_value ~= "infamous" and categories.masks then
			for mask_id, amount in pairs(categories.masks) do
				normals[mask_id] = normals[mask_id] or 0
				normals[mask_id] = normals[mask_id] + amount
			end
		end
	end
	if self._global.inventory.superior then
		self._global.inventory.superior.masks = nil
	end
	if self._global.inventory.exceptional then
		self._global.inventory.exceptional.masks = nil
	end
end

function BlackMarketManager:get_inventory_masks()
	local masks = {}
	for global_value, categories in pairs(self._global.inventory) do
		if categories.masks then
			for mask_id, amount in pairs(categories.masks) do
				table.insert(masks, {
					mask_id = mask_id,
					global_value = global_value,
					amount = amount
				})
			end
		end
	end
	return masks
end

function BlackMarketManager:get_crafted_category(category)
	if not self._global.crafted_items then
		return
	end
	return self._global.crafted_items[category]
end

function BlackMarketManager:get_crafted_category_slot(category, slot)
	if not self._global.crafted_items then
		return
	end
	if not self._global.crafted_items[category] then
		return
	end
	return self._global.crafted_items[category][slot]
end

function BlackMarketManager:get_weapon_data(weapon_id)
	return self._global.weapons[weapon_id]
end

function BlackMarketManager:get_crafted_custom_name(category, slot, add_quotation)
	local crafted_slot = self:get_crafted_category_slot(category, slot)
	local custom_name = crafted_slot and crafted_slot.custom_name
	if custom_name then
		if add_quotation then
			return "\"" .. custom_name .. "\""
		end
		return custom_name
	end
end

function BlackMarketManager:set_crafted_custom_name(category, slot, custom_name)
	local crafted_slot = self:get_crafted_category_slot(category, slot)
	crafted_slot.custom_name = custom_name ~= "" and custom_name
end

function BlackMarketManager:get_mask_name_by_category_slot(category, slot)
	local crafted_slot = self:get_crafted_category_slot(category, slot)
	if crafted_slot then
		if crafted_slot.custom_name then
			return "\"" .. crafted_slot.custom_name .. "\""
		end
		return managers.localization:text(tweak_data.blackmarket.masks[crafted_slot.mask_id].name_id)
	end
	return ""
end

function BlackMarketManager:get_weapon_name_by_category_slot(category, slot)
	local crafted_slot = self:get_crafted_category_slot(category, slot)
	if crafted_slot then
		if crafted_slot.custom_name then
			return "\"" .. crafted_slot.custom_name .. "\""
		end
		return managers.weapon_factory:get_weapon_name_by_factory_id(crafted_slot.factory_id)
	end
	return ""
end

function BlackMarketManager:get_weapon_category(category)
	local weapon_index = {secondaries = 1, primaries = 2}
	local selection_index = weapon_index[category] or 1
	local t = {}
	for weapon_name, weapon_data in pairs(self._global.weapons) do
		if weapon_data.selection_index == selection_index then
			table.insert(t, weapon_data)
			t[#t].weapon_id = weapon_name
		end
	end
	return t
end

function BlackMarketManager:get_weapon_blueprint(category, slot)
	if not self._global.crafted_items then
		return
	end
	if not self._global.crafted_items[category] then
		return
	end
	if not self._global.crafted_items[category][slot] then
		return
	end
	return self._global.crafted_items[category][slot].blueprint
end

function BlackMarketManager:get_perks_from_weapon_blueprint(factory_id, blueprint)
	return managers.weapon_factory:get_perks(factory_id, blueprint)
end

function BlackMarketManager:get_perks_from_part(part_id)
	return managers.weapon_factory:get_perks_from_part_id(part_id)
end

function BlackMarketManager:get_melee_weapon_stats(melee_weapon_id)
	local data = self:get_melee_weapon_data(melee_weapon_id)
	if data then
		return data.stats
	end
	return {}
end

function BlackMarketManager:get_weapon_stats(category, slot)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:get_weapon_stats] Trying to get weapon stats on weapon that doesn't exist", category, slot)
		return
	end
	local blueprint = self:get_weapon_blueprint(category, slot)
	local weapon = self._global.crafted_items[category][slot]
	local weapon_tweak_data = tweak_data.weapon[weapon.weapon_id]
	if not (blueprint and weapon) or not weapon_tweak_data then
		return
	end
	local weapon_stats = managers.weapon_factory:get_stats(weapon.factory_id, blueprint)
	for stat, value in pairs(weapon_tweak_data.stats) do
		weapon_stats[stat] = (weapon_stats[stat] or 0) + weapon_tweak_data.stats[stat]
	end
	return weapon_stats
end

function BlackMarketManager:get_weapon_stats_without_mod(category, slot, part_id)
	return self:get_weapon_stats_with_mod(category, slot, part_id, true)
end

function BlackMarketManager:get_weapon_stats_with_mod(category, slot, part_id, remove_mod)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:get_weapon_stats_with_mod] Trying to get weapon stats on weapon that doesn't exist", category, slot)
		return
	end
	local blueprint = deep_clone(self:get_weapon_blueprint(category, slot))
	local weapon = self._global.crafted_items[category][slot]
	local weapon_tweak_data = tweak_data.weapon[weapon.weapon_id]
	if not (blueprint and weapon) or not weapon_tweak_data then
		return
	end
	managers.weapon_factory:change_part_blueprint_only(weapon.factory_id, part_id, blueprint, remove_mod)
	local weapon_stats = managers.weapon_factory:get_stats(weapon.factory_id, blueprint)
	for stat, value in pairs(weapon_tweak_data.stats) do
		weapon_stats[stat] = (weapon_stats[stat] or 0) + weapon_tweak_data.stats[stat]
	end
	return weapon_stats
end

function BlackMarketManager:calculate_weapon_visibility(weapon)
	return #tweak_data.weapon.stats.concealment - self:calculate_weapon_concealment(weapon)
end

function BlackMarketManager:calculate_armor_visibility(armor)
	return #tweak_data.weapon.stats.concealment - self:_calculate_armor_concealment(armor or self:equipped_armor(true))
end

function BlackMarketManager:calculate_melee_weapon_visibility(melee_weapon)
	return #tweak_data.weapon.stats.concealment - self:_calculate_melee_weapon_concealment(melee_weapon or self:equipped_melee_weapon())
end

function BlackMarketManager:calculate_weapon_concealment(weapon)
	if type(weapon) == "string" then
		weapon = weapon == "primaries" and self:equipped_primary() or weapon == "secondaries" and self:equipped_secondary()
	end
	return self:_calculate_weapon_concealment(weapon)
end

function BlackMarketManager:calculate_armor_concealment(armor)
	return self:_calculate_armor_concealment(armor or self:equipped_armor(true))
end

function BlackMarketManager:_calculate_weapon_concealment(weapon)
	local factory_id = weapon.factory_id
	local weapon_id = weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
	local blueprint = weapon.blueprint
	local base_stats = tweak_data.weapon[weapon_id].stats
	local modifiers_stats = tweak_data.weapon[weapon_id].stats_modifiers
	if not base_stats or not base_stats.concealment then
		return 0
	end
	local parts_stats = managers.weapon_factory:get_stats(factory_id, blueprint)
	return (base_stats.concealment + (parts_stats.concealment or 0)) * (modifiers_stats and modifiers_stats.concealment or 1)
end

function BlackMarketManager:_calculate_armor_concealment(armor)
	local armor_data = tweak_data.blackmarket.armors[armor]
	return managers.player:body_armor_value("concealment", armor_data.upgrade_level)
end

function BlackMarketManager:_calculate_melee_weapon_concealment(melee_weapon)
	local melee_weapon_data = tweak_data.blackmarket.melee_weapons[melee_weapon].stats
	return melee_weapon_data.concealment or #tweak_data.weapon.stats.concealment
end

function BlackMarketManager:_get_concealment(primary, secondary, armor, melee_weapon, modifier)
	local stats_tweak_data = tweak_data.weapon.stats
	local primary_visibility = self:calculate_weapon_visibility(primary)
	local secondary_visibility = self:calculate_weapon_visibility(secondary)
	local armor_visibility = self:calculate_armor_visibility(armor)
	local melee_weapon_visibility = self:calculate_melee_weapon_visibility(melee_weapon)
	local modifier = modifier or 0
	local total_visibility = math.clamp(primary_visibility + secondary_visibility + armor_visibility + melee_weapon_visibility + modifier, 1, #stats_tweak_data.concealment)
	local total_concealment = math.clamp(#stats_tweak_data.concealment - total_visibility, 1, #stats_tweak_data.concealment)
	return stats_tweak_data.concealment[total_concealment], total_concealment
end

function BlackMarketManager:_get_concealment_from_local_player()
	return self:_get_concealment(self:equipped_primary(), self:equipped_secondary(), self:equipped_armor(true), self:equipped_melee_weapon(), self:visibility_modifiers())
end

function BlackMarketManager:_get_concealment_from_outfit_string(outfit_string)
	return self:_get_concealment(outfit_string.primary, outfit_string.secondary, outfit_string.armor_current or outfit_string.armor, outfit_string.melee_weapon, -outfit_string.concealment_modifier)
end

function BlackMarketManager:_get_concealment_from_peer(peer)
	local outfit = peer:blackmarket_outfit()
	return self:_get_concealment(outfit.primary, outfit.secondary, outfit.armor_current or outfit.armor, outfit.melee_weapon, -outfit.concealment_modifier)
end

function BlackMarketManager:get_real_visibility_index_from_custom_data(data)
	local stats_tweak_data = tweak_data.weapon.stats
	local primary_visibility = self:calculate_weapon_visibility(data.primaries or "primaries")
	local secondary_visibility = self:calculate_weapon_visibility(data.secondaries or "secondaries")
	local armor_visibility = self:calculate_armor_visibility(data.armors)
	local melee_weapon_visibility = self:calculate_melee_weapon_visibility(data.melee_weapon)
	local modifier = self:visibility_modifiers()
	local total_visibility = primary_visibility + secondary_visibility + armor_visibility + melee_weapon_visibility + modifier
	local total_concealment = #stats_tweak_data.concealment - total_visibility
	return total_concealment
end

function BlackMarketManager:get_real_visibility_index_of_local_player()
	local stats_tweak_data = tweak_data.weapon.stats
	local primary_visibility = self:calculate_weapon_visibility("primaries")
	local secondary_visibility = self:calculate_weapon_visibility("secondaries")
	local armor_visibility = self:calculate_armor_visibility()
	local melee_weapon_visibility = self:calculate_melee_weapon_visibility()
	local modifier = self:visibility_modifiers()
	local total_visibility = primary_visibility + secondary_visibility + armor_visibility + melee_weapon_visibility + modifier
	local total_concealment = #stats_tweak_data.concealment - total_visibility
	return total_concealment
end

function BlackMarketManager:get_suspicion_of_local_player()
	return self:_get_concealment_from_local_player()
end

function BlackMarketManager:get_concealment_of_peer(peer)
	return self:_get_concealment_from_peer(peer)
end

function BlackMarketManager:_get_concealment_of_outfit_string(outfit_string)
	return self:_get_concealment_from_outfit_string(outfit_string)
end

function BlackMarketManager:_calculate_suspicion_offset(index, lerp)
	local con_val = tweak_data.weapon.stats.concealment[index]
	local min_val = tweak_data.weapon.stats.concealment[1]
	local max_val = tweak_data.weapon.stats.concealment[#tweak_data.weapon.stats.concealment]
	local max_ratio = max_val / min_val
	local mul_ratio = math.max(1, con_val / min_val)
	local susp_lerp = math.clamp(1 - (con_val - min_val) / (max_val - min_val), 0, 1)
	return math.lerp(0, lerp, susp_lerp)
end

function BlackMarketManager:get_suspicion_offset_of_outfit_string(outfit_string, lerp)
	local con_mul, index = self:_get_concealment_of_outfit_string(outfit_string)
	return self:_calculate_suspicion_offset(index, lerp), index == 1
end

function BlackMarketManager:get_suspicion_offset_of_peer(peer, lerp)
	local con_mul, index = self:get_concealment_of_peer(peer)
	return self:_calculate_suspicion_offset(index, lerp)
end

function BlackMarketManager:get_suspicion_offset_of_local(lerp)
	local con_mul, index = self:_get_concealment_from_local_player()
	local val = self:_calculate_suspicion_offset(index, lerp or 1)
	return val, index == 1
end

function BlackMarketManager:get_suspicion_offset_from_custom_data(data, lerp)
	local index = self:get_real_visibility_index_from_custom_data(data)
	index = math.clamp(index, 1, #tweak_data.weapon.stats.concealment)
	local val = self:_calculate_suspicion_offset(index, lerp or 1)
	return val, index == 1
end

function BlackMarketManager:visibility_modifiers()
	local skill_bonuses = 0
	skill_bonuses = skill_bonuses - managers.player:upgrade_value("player", "passive_concealment_modifier", 0)
	skill_bonuses = skill_bonuses - managers.player:upgrade_value("player", "concealment_modifier", 0)
	skill_bonuses = skill_bonuses - managers.player:upgrade_value("player", "melee_concealment_modifier", 0)
	return skill_bonuses
end

function BlackMarketManager:concealment_modifier(type)
	local modifier = 0
	if type == "armors" then
		modifier = modifier + managers.player:upgrade_value("player", "passive_concealment_modifier", 0)
		modifier = modifier + managers.player:upgrade_value("player", "concealment_modifier", 0)
	elseif type == "melee_weapons" then
		modifier = modifier + managers.player:upgrade_value("player", "melee_concealment_modifier", 0)
	end
	return modifier
end

function BlackMarketManager:get_lootdropable_mods_by_weapon_id(weapon_id, global_value)
	local droppable_parts = self:get_dropable_mods_by_weapon_id(weapon_id)
	local loot_table = {}
	if global_value == "all" then
		global_value = false
	end
	local chk_dlc_func = function(global_value)
		local all_dlc_data = Global.dlc_manager.all_dlc_data
		if all_dlc_data[global_value] and all_dlc_data[global_value].app_id and not managers.dlc:is_dlc_unlocked(global_value) then
			return false
		end
		return true
	end
	local gv
	for category, parts in pairs(droppable_parts) do
		for _, part_data in ipairs(parts) do
			gv = part_data[2] or "normal"
			if (not global_value or gv == global_value) and tweak_data.lootdrop.global_values[gv] and (not tweak_data.lootdrop.global_values[gv].dlc or managers.dlc:is_dlc_unlocked(gv)) and tweak_data.weapon.factory.parts[part_data[1]] and (tweak_data.weapon.factory.parts[part_data[1]].pc or tweak_data.weapon.factory.parts[part_data[1]].pcs and #tweak_data.weapon.factory.parts[part_data[1]].pcs > 0) then
				table.insert(loot_table, part_data)
			end
		end
	end
	return loot_table
end

function BlackMarketManager:get_dropable_mods_by_weapon_id(weapon_id, weapon_data)
	local parts_tweak_data = tweak_data.weapon.factory.parts
	local all_mods = tweak_data.blackmarket.weapon_mods
	local weapon_mods = managers.weapon_factory:get_parts_from_weapon_id(weapon_id)
	local dropable_mods = {}
	local dlc_mods = {}
	local blueprint, blueprint_gv
	if weapon_data then
		local w_category = weapon_data.category
		local w_slot = weapon_data.slot
		local crafted_item = self._global.crafted_items[w_category][w_slot]
		blueprint = crafted_item.blueprint
		blueprint_gv = crafted_item.global_values
	end
	for category, data in pairs(weapon_mods) do
		dropable_mods[category] = dropable_mods[category] or {}
		for _, part_id in ipairs(data) do
			local part = all_mods[part_id]
			if part and (part.pcs or part.pc) then
				local global_value = part.infamous and "infamous" or "normal"
				local is_infamous = part.infamous
				local part_dropable = true
				if not is_infamous then
					local dlcs = {}
					if part.dlcs then
						for i, dlc in ipairs(part.dlcs) do
							table.insert(dlcs, dlc)
						end
					end
					if part.dlc then
						table.insert(dlcs, part.dlc)
					end
					local is_dlc = 0 < #dlcs
					if is_dlc then
						for _, dlc in ipairs(dlcs) do
							local has_dlc = tweak_data.dlc[dlc] and tweak_data.dlc[dlc].free or managers.dlc:has_dlc(dlc)
							if has_dlc then
								global_value = dlc
								part_dropable = true
								break
							elseif tweak_data.lootdrop.global_values[dlc].hide_unavailable then
								part_dropable = false
								global_value = dlc
							else
								global_value = dlc
							end
						end
					end
					local dropped_global_values = {normal = true, infamous = true}
					if part_dropable then
						table.insert(dropable_mods[category], {part_id, global_value})
						dropped_global_values[global_value] = true
					end
					for gv, items in pairs(self._global.inventory) do
						if gv ~= global_value then
							local weapon_mods_data = items.weapon_mods
							local item = weapon_mods_data and weapon_mods_data[part_id]
							if item then
								table.insert(dropable_mods[category], {part_id, gv})
								dropped_global_values[gv] = true
							end
						end
					end
					local bp_global_value = blueprint_gv and blueprint_gv[part_id]
					if bp_global_value and not dropped_global_values[bp_global_value] then
						local has_in_blueprint = table.contains(blueprint, part_id)
						if has_in_blueprint then
							table.insert(dropable_mods[category], {part_id, bp_global_value})
							dropped_global_values[bp_global_value] = true
						end
					end
				end
			end
		end
	end
	for key, data in pairs(dropable_mods) do
		if #data == 0 then
			dropable_mods[key] = nil
		end
	end
	return dropable_mods
end

function BlackMarketManager:sell_item(item_data)
	if not self:remove_item(item_data.global_value, item_data.category, item_data.id) then
		Application:error("[BlackMarketManager:sell_item] Failed to sell item", item_data.global_value, item_data.category, item_data.id)
		return
	end
	self:_sell_item(item_data)
end

function BlackMarketManager:_sell_item(item_data)
	local item_def = tweak_data.blackmarket[item_data.category][item_data.id]
	local value_multiplier = tweak_data.lootdrop.global_values[item_data.global_value].value_multiplier
	local pc = item_def.pc or item_def.pcs[1]
	local money = pc * value_multiplier * managers.player:upgrade_value("player", "sell_cost_multiplier", 1)
	print("Sold for", money, "! (", pc, value_multiplier, managers.plater:upgrade_value("player", "sell_cost_multiplier", 1), ")")
end

function BlackMarketManager:apply_mask_craft_on_unit(unit, blueprint)
	local materials = unit:get_objects_by_type(Idstring("material"))
	local material = materials[#materials]
	print("apply_mask_craft_on_unit material", material, inspect(materials))
	local tint_color_a = Vector3(0, 0, 0)
	local tint_color_b = Vector3(0, 0, 0)
	local pattern_id = blueprint and blueprint.pattern.id or "no_color_no_material"
	local material_id = blueprint and blueprint.material.id or "plastic"
	if blueprint then
		local color_data = tweak_data.blackmarket.colors[blueprint.color.id]
		tint_color_a = Vector3(color_data.colors[1]:unpack())
		tint_color_b = Vector3(color_data.colors[2]:unpack())
	end
	material:set_variable(Idstring("tint_color_a"), tint_color_a)
	material:set_variable(Idstring("tint_color_b"), tint_color_b)
	local pattern = tweak_data.blackmarket.textures[pattern_id].texture
	print("pattern", pattern)
	local material_texture = TextureCache:retrieve(pattern, "normal")
	Application:set_material_texture(material, Idstring("material_texture"), material_texture)
	local reflection = tweak_data.blackmarket.materials[material_id].texture
	local material_amount = tweak_data.blackmarket.materials[material_id].material_amount or 1
	local reflection_texture = TextureCache:retrieve(reflection, "normal")
	Application:set_material_texture(material, Idstring("reflection_texture"), reflection_texture)
	material:set_variable(Idstring("material_amount"), material_amount)
	return material_texture, reflection_texture
end

function BlackMarketManager:test_craft_mask(slot)
	slot = slot or 1
	local blueprint = {}
	local masks = managers.blackmarket:get_inventory_category("masks")
	local entry = masks[math.random(#masks)]
	blueprint.masks = {
		id = entry.id,
		global_value = entry.global_value
	}
	local materials = managers.blackmarket:get_inventory_category("materials")
	local entry = materials[math.random(#materials)]
	blueprint.materials = {
		id = entry.id,
		global_value = entry.global_value
	}
	local colors = managers.blackmarket:get_inventory_category("colors")
	local entry = colors[math.random(#colors)]
	blueprint.colors = {
		id = entry.id,
		global_value = entry.global_value
	}
	local textures = managers.blackmarket:get_inventory_category("textures")
	local entry = textures[math.random(#textures)]
	blueprint.textures = {
		id = entry.id,
		global_value = entry.global_value
	}
	self:craft_item("masks", slot, blueprint)
end

function BlackMarketManager:has_parts_for_blueprint(category, blueprint)
	for category, data in pairs(blueprint) do
		if not self:has_item(data.global_value, category, data.id) then
			print("misses part", data.global_value, category, data.id)
			return false
		end
	end
	print("has all parts")
	return true
end

function BlackMarketManager:get_crafted_item_amount(category, id)
	local crafted_category = self._global.crafted_items[category]
	if not crafted_category then
		print("[BlackMarketManager:get_crafted_item_amount] No such category", category)
		return 0
	end
	local item_amount = 0
	for _, item in pairs(crafted_category) do
		if category == "primaries" or category == "secondaries" then
			if item.weapon_id == id then
				item_amount = item_amount + 1
			end
		elseif category == "masks" then
			if item.mask_id == id then
				item_amount = item_amount + 1
			end
		elseif category == "character" then
		elseif category == "armors" then
		else
			break
		end
	end
	return item_amount
end

function BlackMarketManager:get_crafted_part_global_value(category, slot, part_id)
	local global_values = self._global.crafted_items[category][slot].global_values
	if global_values then
		return global_values[part_id]
	end
end

function BlackMarketManager:get_inventory_item_global_values(category, id)
	local global_values = {}
	for global_value, data in pairs(self._global.inventory) do
		if self:get_item_amount(global_value, category, id, true) > 0 then
			table.insert(global_values, global_value)
		end
	end
	return global_values
end

function BlackMarketManager:has_inventory_item(default_global_value, category, id)
	if self:get_item_amount(default_global_value, category, id, true) > 0 then
		return true
	end
	for global_value, data in pairs(self._global.inventory) do
		if default_global_value ~= global_value and self:get_item_amount(global_value, category, id, true) > 0 then
			return true
		end
	end
end

function BlackMarketManager:get_item_amount(global_value, category, id, no_prints)
	local global_value_data = self._global.inventory[global_value]
	if not global_value_data then
		if not no_prints then
			print("[BlackMarketManager:get_item_amount] No such global value", global_value)
		end
		return 0
	end
	local category_data = global_value_data[category]
	if not category_data then
		if not no_prints then
			print("[BlackMarketManager:get_item_amount] No such category", category, "of global value", global_value)
		end
		return 0
	end
	local item_amount = category_data[id]
	if not item_amount then
		if not no_prints then
			print("[BlackMarketManager:get_item_amount] No such item id", id, "in category", category, "of global value", global_value)
		end
		return 0
	end
	local item_def = tweak_data.blackmarket[category][id]
	if not item_def then
		if not no_prints then
			print("[BlackMarketManager:get_item_amount] No item", category, id)
		end
		return 0
	end
	return item_amount
end

function BlackMarketManager:has_item(global_value, category, id)
	local global_value_data = self._global.inventory[global_value]
	if not global_value_data then
		print("[BlackMarketManager:has_item] No such global value", global_value)
		return false
	end
	local category_data = global_value_data[category]
	if not category_data then
		print("[BlackMarketManager:has_item] No such category", category, "of global value", global_value)
		return false
	end
	local item_amount = category_data[id]
	if not item_amount then
		print("[BlackMarketManager:has_item] No such item id", id, "in category", category, "of global value", global_value)
		return false
	end
	local item_def = tweak_data.blackmarket[category][id]
	if not item_def then
		print("[BlackMarketManager:has_item] No item", category, id)
		return false
	end
	return true
end

function BlackMarketManager:remove_item(global_value, category, id)
	if not self:has_item(global_value, category, id) then
		return false
	end
	local category_data = self._global.inventory[global_value][category]
	category_data[id] = category_data[id] - 1
	if category_data[id] <= 0 then
		print("Run out of", category, id)
		category_data[id] = nil
	end
	return true
end

function BlackMarketManager:craft_item(category, slot, blueprint)
	if not self:has_parts_for_blueprint(category, blueprint) then
		Application:error("[BlackMarketManager:craft_item] Blueprint not valid", category)
		return
	end
	for category, data in pairs(blueprint) do
		self:remove_item(data.global_value, category, data.id)
		self:alter_global_value_item(data.global_value, category, slot, data.id, INV_TO_CRAFT)
	end
	self._global.crafted_items[category] = self._global.crafted_items[category] or {}
	self._global.crafted_items[category][slot] = blueprint
end

function BlackMarketManager:sell_crafted_item(category, slot)
	if not self._global.crafted_items[category] then
		Application:error("[BlackMarketManager:sell_crafted_item] No crafted items of category", category)
		return
	end
	if not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:sell_crafted_item] No crafted items of category", category, "in slot", slot)
		return
	end
	local blueprint = self._global.crafted_items[category][slot]
	for category, data in pairs(blueprint) do
		self:_sell_item({
			global_value = data.global_value,
			category = category,
			id = data.id
		})
		self:alter_global_value_item(data.global_value, category, slot, data.id, CRAFT_TO_INV)
	end
	self:alter_global_value_item(self._global.crafted_items[category][slot].global_value, category, slot, self._global.crafted_items[category][slot].id, CRAFT_TO_INV)
	self._global.crafted_items[category][slot] = nil
end

function BlackMarketManager:uncraft_item(category, slot)
	if not self._global.crafted_items[category] then
		Application:error("[BlackMarketManager:uncraft_item] No crafted items of category", category)
		return
	end
	if not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:uncraft_item] No crafted items of category", category, "in slot", slot)
		return
	end
	local blueprint = self._global.crafted_items[category][slot]
	for category, data in pairs(blueprint) do
		self:add_to_inventory(data.global_value, category, data.id)
	end
	self._global.crafted_items[category][slot] = nil
end

function BlackMarketManager:check_will_have_free_slot(category)
	if not self._global.crafted_items[category] then
		return false
	end
	local max_rows = tweak_data.gui.MAX_WEAPON_ROWS or 3
	local max_items = max_rows * 3
	for i = 1, max_items do
		if self:is_weapon_slot_unlocked(category, i) then
			if not self._global.crafted_items[category][i] then
				return i
			else
				local weapon_id = self._global.crafted_items[category][i].weapon_id
				local weapon = self._global.weapons[weapon_id]
				if weapon and weapon.unlocked and weapon.level == 0 and not weapon.skill_based then
					return i
				end
			end
		end
	end
	return false
end

function BlackMarketManager:_get_free_weapon_slot(category)
	if not self._global.crafted_items[category] then
		return 1
	end
	local max_rows = tweak_data.gui.MAX_WEAPON_ROWS or 3
	local max_items = max_rows * 3
	for i = 1, max_items do
		if self:is_weapon_slot_unlocked(category, i) and not self._global.crafted_items[category][i] then
			return i
		end
	end
end

function BlackMarketManager:on_aquired_weapon_platform(upgrade, id, loading)
	self._global.weapons[id].unlocked = true
	local category = tweak_data.weapon[upgrade.weapon_id].use_data.selection_index == 2 and "primaries" or "secondaries"
	if upgrade.free then
		local slot = self:_get_free_weapon_slot(category)
		if slot then
			self:on_buy_weapon_platform(category, upgrade.weapon_id, slot, true)
		end
	elseif not loading and not self._global.weapons[id].skill_based and self._global.weapons[id].level > 0 then
		print("on_aquired_weapon_platform", inspect(upgrade), id)
		self._global.new_drops.normal = self._global.new_drops.normal or {}
		self._global.new_drops.normal[category] = self._global.new_drops.normal[category] or {}
		self._global.new_drops.normal[category][id] = true
		self._global.new_item_type_unlocked[category] = upgrade.factory_id
	end
end

function BlackMarketManager:on_unaquired_weapon_platform(upgrade, id)
	self._global.weapons[id].unlocked = false
	local equipped_primariy = managers.blackmarket:equipped_primary()
	if equipped_primariy and equipped_primariy.weapon_id == id then
		equipped_primariy.equipped = false
		self:_verfify_equipped_category("primaries")
		self:_update_menu_scene_primary()
	end
	local equipped_secondary = managers.blackmarket:equipped_secondary()
	if equipped_secondary and equipped_secondary.weapon_id == id then
		equipped_secondary.equipped = false
		self:_verfify_equipped_category("secondaries")
		self:_update_menu_scene_secondary()
	end
end

function BlackMarketManager:on_aquired_melee_weapon(upgrade, id, loading)
	if not self._global.melee_weapons[id] then
		Application:error("[BlackMarketManager:on_aquired_melee_weapon] Melee weapon do not exist in blackmarket", "melee_weapon_id", id)
		return
	end
	self._global.melee_weapons[id].unlocked = true
	self._global.melee_weapons[id].owned = true
	if not loading then
		self._global.new_drops.normal = self._global.new_drops.normal or {}
		self._global.new_drops.normal.melee_weapons = self._global.new_drops.normal.melee_weapons or {}
		self._global.new_drops.normal.melee_weapons[id] = true
	end
end

function BlackMarketManager:on_unaquired_melee_weapon(upgrade, id)
	self._global.melee_weapons[id].unlocked = false
	self._global.melee_weapons[id].owned = false
	local equipped_melee_weapon = managers.blackmarket:equipped_melee_weapon()
	if equipped_melee_weapon and equipped_melee_weapon == id then
		equipped_melee_weapon.equipped = false
		self:_verfify_equipped_category("melee_weapons")
	end
end

function BlackMarketManager:on_aquired_grenade(upgrade, id, loading)
	if not self._global.grenades[id] then
		Application:error("[BlackMarketManager:on_aquired_grenade] Grenade do not exist in blackmarket", "grenade_id", id)
		return
	end
	self._global.grenades[id].unlocked = true
	self._global.grenades[id].owned = true
	if not loading then
		self._global.new_drops.normal = self._global.new_drops.normal or {}
		self._global.new_drops.normal.grenades = self._global.new_drops.normal.grenades or {}
		self._global.new_drops.normal.grenades[id] = true
	end
end

function BlackMarketManager:on_unaquired_grenade(upgrade, id)
	self._global.grenades[id].unlocked = false
	self._global.grenades[id].owned = false
	local equipped_grenade = managers.blackmarket:equipped_grenade()
	if equipped_grenade and equipped_grenade == id then
		equipped_grenade.equipped = false
		self:_verfify_equipped_category("grenades")
	end
end

function BlackMarketManager:aquire_default_weapons(only_enable)
	local glock_17 = self._global and self._global.weapons and self._global.weapons.glock_17
	if glock_17 and (not self._global.crafted_items.secondaries or not glock_17.unlocked) and not managers.upgrades:aquired("glock_17", UpgradesManager.AQUIRE_STRINGS[1]) then
		if only_enable then
			managers.upgrades:enable_weapon("glock_17", UpgradesManager.AQUIRE_STRINGS[1])
			self._global.weapons.glock_17.unlocked = true
		else
			managers.upgrades:aquire("glock_17", nil, UpgradesManager.AQUIRE_STRINGS[1])
		end
	end
	local amcar = self._global and self._global.weapons and self._global.weapons.amcar
	if amcar and (not self._global.crafted_items.primaries or not amcar.unlocked) and not managers.upgrades:aquired("amcar", UpgradesManager.AQUIRE_STRINGS[1]) then
		if only_enable then
			managers.upgrades:enable_weapon("amcar", UpgradesManager.AQUIRE_STRINGS[1])
			self._global.weapons.amcar.unlocked = true
		else
			managers.upgrades:aquire("amcar", nil, UpgradesManager.AQUIRE_STRINGS[1])
		end
	end
	local melee_weapon = self._global and self._global.melee_weapons and self._global.melee_weapons[self._defaults.melee_weapon]
	if melee_weapon and not melee_weapon.unlocked and not managers.upgrades:aquired(self._defaults.melee_weapon) then
		if only_enable then
			self._global.melee_weapons[self._defaults.melee_weapon].unlocked = true
		else
			managers.upgrades:aquire(self._defaults.melee_weapon, nil, UpgradesManager.AQUIRE_STRINGS[1])
		end
	end
end

function BlackMarketManager:on_buy_weapon_platform(category, weapon_id, slot, free)
	if category ~= "primaries" and category ~= "secondaries" then
		return
	end
	self._global.crafted_items[category] = self._global.crafted_items[category] or {}
	local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id)
	local blueprint = deep_clone(managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id))
	self._global.crafted_items[category][slot] = {
		weapon_id = weapon_id,
		factory_id = factory_id,
		blueprint = blueprint,
		global_values = {}
	}
	self:_verfify_equipped_category(category)
	if category == "primaries" then
	end
	if not free then
		managers.money:on_buy_weapon_platform(weapon_id)
		managers.achievment:award("armed_to_the_teeth")
	end
	if self._global.crafted_items.primaries and self._global.crafted_items.secondaries then
		local amount = table.size(self._global.crafted_items.primaries) + table.size(self._global.crafted_items.secondaries)
		if amount >= tweak_data.achievement.fully_loaded then
			managers.achievment:award("fully_loaded")
		end
		if amount >= tweak_data.achievement.weapon_collector then
			managers.achievment:award("weapon_collector")
		end
		if amount >= tweak_data.achievement.arms_dealer then
			managers.achievment:award("gage_8")
		end
		local weapons_owned = {}
		for slot, crafted in pairs(self._global.crafted_items.primaries) do
			weapons_owned[crafted.weapon_id] = true
		end
		for slot, crafted in pairs(self._global.crafted_items.secondaries) do
			weapons_owned[crafted.weapon_id] = true
		end
		local award_achievement
		for award, data in pairs(tweak_data.achievement.weapons_owned) do
			award_achievement = true
			for _, weapon_id in ipairs(data) do
				if not weapons_owned[weapon_id] then
					award_achievement = false
					break
				end
			end
			if award_achievement then
				managers.achievment:award(award)
			end
		end
	end
end

function BlackMarketManager:on_sell_weapon_part(part_id, global_value)
	managers.money:on_sell_weapon_part(part_id, global_value)
	self:alter_global_value_item(global_value, "weapon_mods", nil, part_id, INV_REMOVE)
	self:remove_item(global_value, "weapon_mods", part_id)
end

function BlackMarketManager:on_sell_weapon(category, slot, skip_verification)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		return
	end
	local parts_tweak_data = tweak_data.weapon.factory.parts
	local global_values = self._global.crafted_items[category][slot].global_values or {}
	local blueprint = self._global.crafted_items[category][slot].blueprint
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(self._global.crafted_items[category][slot].factory_id)
	for _, default_part in ipairs(default_blueprint) do
		table.delete(blueprint, default_part)
	end
	for _, part_id in pairs(blueprint) do
		local global_value = global_values[part_id] or "normal"
		if parts_tweak_data[part_id] and not parts_tweak_data[part_id].is_a_unlockable then
			self:add_to_inventory(global_value, "weapon_mods", part_id, true)
			self:alter_global_value_item(global_value, category, slot, part_id, CRAFT_REMOVE)
		end
	end
	managers.money:on_sell_weapon(category, slot)
	self._global.crafted_items[category][slot] = nil
	if not skip_verification then
		self:_verfify_equipped_category(category)
		if category == "primaries" then
			self:_update_menu_scene_primary()
		elseif category == "secondaries" then
			self:_update_menu_scene_secondary()
		end
	end
end

function BlackMarketManager:_update_menu_scene_primary()
	if not managers.menu_scene then
		return
	end
	local primary = self:equipped_primary()
	if primary then
		managers.menu_scene:set_character_equipped_weapon(nil, primary.factory_id, primary.blueprint, "primary")
	else
		managers.menu_scene:set_character_equipped_weapon(nil, nil, nil, "primary")
	end
end

function BlackMarketManager:_update_menu_scene_secondary()
	if not managers.menu_scene then
		return
	end
	local secondary = self:equipped_secondary()
	if secondary then
		managers.menu_scene:set_character_equipped_weapon(nil, secondary.factory_id, secondary.blueprint, "secondary")
	else
		managers.menu_scene:set_character_equipped_weapon(nil, nil, nil, "secondary")
	end
end

function BlackMarketManager:get_modify_weapon_consequence(category, slot, part_id, remove_part)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:get_modify_weapon_consequence] Weapon doesn't exist", category, slot)
		return
	end
	local craft_data = self._global.crafted_items[category][slot]
	local replaces = managers.weapon_factory:get_replaces_parts(craft_data.factory_id, part_id, craft_data.blueprint, remove_part)
	local removes = managers.weapon_factory:get_removes_parts(craft_data.factory_id, part_id, craft_data.blueprint, remove_part)
	return replaces, removes
end

function BlackMarketManager:can_modify_weapon(category, slot, part_id)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:can_modify_weapon] Weapon doesn't exist", category, slot)
		return
	end
	local craft_data = self._global.crafted_items[category][slot]
	return managers.weapon_factory:can_add_part(craft_data.factory_id, part_id, craft_data.blueprint)
end

function BlackMarketManager:remove_weapon_part(category, slot, global_value, part_id)
	if not (part_id and self._global.crafted_items[category]) or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:remove_weapon_part] Trying to remove part", part_id, "from weapon that doesn't exist", category, slot)
		return false
	end
	self:modify_weapon(category, slot, global_value, part_id, true)
	return true
end

function BlackMarketManager:modify_weapon(category, slot, global_value, part_id, remove_part)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:modify_weapon] Trying to modify weapon that doesn't exist", category, slot)
		return
	end
	local replaces, removes = self:get_modify_weapon_consequence(category, slot, part_id, remove_part)
	local craft_data = self._global.crafted_items[category][slot]
	managers.weapon_factory:change_part_blueprint_only(craft_data.factory_id, part_id, craft_data.blueprint, remove_part)
	craft_data.global_values = craft_data.global_values or {}
	local old_gv = "" .. (craft_data.global_values[part_id] or "normal")
	if remove_part then
		craft_data.global_values[part_id] = nil
	else
		craft_data.global_values[part_id] = global_value or "normal"
	end
	local parts_tweak_data = tweak_data.blackmarket.weapon_mods
	local removed_parts = {}
	for _, part in pairs(replaces) do
		table.insert(removed_parts, part)
	end
	for _, part in pairs(removes) do
		table.insert(removed_parts, part)
	end
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(craft_data.factory_id)
	local default_t = {}
	for _, default_part in ipairs(default_blueprint) do
		default_t[default_part] = true
	end
	local global_value = "normal"
	for _, removed_part_id in pairs(removed_parts) do
		if removed_part_id == part_id then
			global_value = old_gv or "normal"
		else
			global_value = craft_data.global_values[removed_part_id] or "normal"
			craft_data.global_values[removed_part_id] = nil
		end
		if not default_t[removed_part_id] and parts_tweak_data[removed_part_id] and (parts_tweak_data[removed_part_id].pcs or parts_tweak_data[removed_part_id].pc) then
			if not parts_tweak_data[removed_part_id].is_a_unlockable then
				self:add_to_inventory(global_value, "weapon_mods", removed_part_id, true)
			end
			self:alter_global_value_item(global_value, category, slot, removed_part_id, CRAFT_REMOVE)
		end
	end
	self:_on_modified_weapon(category, slot)
end

function BlackMarketManager:buy_and_modify_weapon(category, slot, global_value, part_id, free_of_charge, no_consume)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:modify_weapon] Trying to buy and modify weapon that doesn't exist", category, slot)
		return
	end
	self:modify_weapon(category, slot, global_value, part_id)
	if not free_of_charge then
		managers.money:on_buy_weapon_modification(self._global.crafted_items[category][slot].weapon_id, part_id, global_value)
		managers.achievment:award("would_you_like_your_receipt")
	end
	if not no_consume then
		self:remove_item(global_value, "weapon_mods", part_id)
		self:alter_global_value_item(global_value, "weapon_mods", slot, part_id, INV_REMOVE)
		self:alter_global_value_item(global_value, category, slot, part_id, CRAFT_ADD)
	else
	end
end

function BlackMarketManager:_on_modified_weapon(category, slot)
	local crafted = self:get_crafted_category_slot(category, slot)
	local blueprint = crafted and crafted.blueprint or {}
	local pass_achievement
	for achievement, parts in pairs(tweak_data.achievement.weapon_blueprints) do
		pass_achievement = true
		for _, part_id in ipairs(parts) do
			if not table.contains(blueprint, part_id) then
				pass_achievement = false
				break
			end
		end
		if pass_achievement then
			managers.achievment:award(achievement)
		end
	end
	if self:equipped_weapon_slot(category) ~= slot then
		return
	end
	if managers.menu_scene then
		local data = category == "primaries" and self:equipped_primary() or self:equipped_secondary()
		if data then
			managers.menu_scene:set_character_equipped_weapon(nil, data.factory_id, data.blueprint, category == "primaries" and "primary" or "secondary")
		end
	end
end

function BlackMarketManager:view_weapon_platform(weapon_id, open_node_cb)
	local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id)
	local blueprint = deep_clone(managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id))
	self:preload_weapon_blueprint("preview", factory_id, blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(factory_id, blueprint)
		end
	})
	table.insert(self._preloading_list, {done_cb = open_node_cb})
end

function BlackMarketManager:view_weapon(category, slot, open_node_cb)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:view_weapon] Trying to view weapon that doesn't exist", category, slot)
		return
	end
	local weapon = self._global.crafted_items[category][slot]
	local texture_switches = self:get_weapon_texture_switches(category, slot, weapon)
	self:preload_weapon_blueprint("preview", weapon.factory_id, weapon.blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(weapon.factory_id, weapon.blueprint, texture_switches)
		end
	})
	table.insert(self._preloading_list, {done_cb = open_node_cb})
end

function BlackMarketManager:view_weapon_with_mod(category, slot, part_id, open_node_cb)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:view_weapon_with_mod] Trying to view weapon that doesn't exist", category, slot)
		return
	end
	local weapon = self._global.crafted_items[category][slot]
	local blueprint = deep_clone(weapon.blueprint)
	local texture_switches = self:get_weapon_texture_switches(category, slot, weapon)
	managers.weapon_factory:change_part_blueprint_only(weapon.factory_id, part_id, blueprint)
	self:preload_weapon_blueprint("preview", weapon.factory_id, weapon.blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(weapon.factory_id, blueprint, texture_switches)
		end
	})
	table.insert(self._preloading_list, {done_cb = open_node_cb})
end

function BlackMarketManager:view_weapon_without_mod(category, slot, part_id, open_node_cb)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:view_weapon_with_mod] Trying to view weapon that doesn't exist", category, slot)
		return
	end
	local weapon = self._global.crafted_items[category][slot]
	local blueprint = deep_clone(weapon.blueprint)
	local texture_switches = self:get_weapon_texture_switches(category, slot, weapon)
	managers.weapon_factory:change_part_blueprint_only(weapon.factory_id, part_id, blueprint, true)
	self:preload_weapon_blueprint("preview", weapon.factory_id, blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(weapon.factory_id, blueprint, texture_switches)
		end
	})
	table.insert(self._preloading_list, {done_cb = open_node_cb})
end

function BlackMarketManager:preview_grenade(grenade_id)
	managers.menu_scene:spawn_grenade(grenade_id)
end

function BlackMarketManager:preview_melee_weapon(melee_weapon_id)
	managers.menu_scene:spawn_melee_weapon(melee_weapon_id)
end

function BlackMarketManager:get_melee_weapon_data(melee_weapon_id)
	return tweak_data.blackmarket.melee_weapons[melee_weapon_id]
end

function BlackMarketManager:set_melee_weapon_favorite(melee_weapon_id, favorite)
	local weapon_data = self._global.melee_weapons[melee_weapon_id]
	if weapon_data then
		weapon_data.is_favorite = favorite
	end
end

function BlackMarketManager:get_hold_crafted_item()
	return self._hold_crafted_item
end

function BlackMarketManager:drop_hold_crafted_item()
	self._hold_crafted_item = nil
end

function BlackMarketManager:pickup_crafted_item(category, slot)
	self._hold_crafted_item = {category = category, slot = slot}
end

function BlackMarketManager:place_crafted_item(category, slot)
	if not self._hold_crafted_item then
		return
	end
	if self._hold_crafted_item.category ~= category then
		return
	end
	local tmp = self:get_crafted_category_slot(category, slot)
	self._global.crafted_items[category][slot] = self:get_crafted_category_slot(self._hold_crafted_item.category, self._hold_crafted_item.slot)
	self._global.crafted_items[self._hold_crafted_item.category][self._hold_crafted_item.slot] = tmp
	tmp = nil
	self._hold_crafted_item = nil
end

function BlackMarketManager:on_aquired_armor(upgrade, id, loading)
	if not self._global.armors[upgrade.armor_id] then
		Application:error("[BlackMarketManager:on_aquired_armor] Armor do not exist in blackmarket", "armor_id", upgrade.armor_id)
		return
	end
	self._global.armors[upgrade.armor_id].unlocked = true
	self._global.armors[upgrade.armor_id].owned = true
	if not loading then
		print("BlackMarketManager:on_aquired_armor", inspect(upgrade), id)
		self._global.new_drops.normal = self._global.new_drops.normal or {}
		self._global.new_drops.normal.armors = self._global.new_drops.normal.armors or {}
		self._global.new_drops.normal.armors[upgrade.armor_id] = true
		if self._global.new_item_type_unlocked.armors == nil then
			self._global.new_item_type_unlocked.armors = upgrade.armor_id
		end
	end
end

function BlackMarketManager:on_unaquired_armor(upgrade, id)
	self._global.armors[upgrade.armor_id].unlocked = false
	self._global.armors[upgrade.armor_id].owned = false
	if self._global.armors[upgrade.armor_id].equipped then
		self._global.armors[upgrade.armor_id].equipped = false
		self._global.armors[self._defaults.armor].owned = true
		self._global.armors[self._defaults.armor].equipped = true
		self._global.armors[self._defaults.armor].unlocked = true
		managers.menu_scene:set_character_armor(self._defaults.armor)
		MenuCallbackHandler:_update_outfit_information()
	end
end

function BlackMarketManager:set_preferred_character(character)
	self._global._preferred_character = character
	local new_name = CriminalsManager.convert_old_to_new_character_workname(character)
	local char_tweak = tweak_data.blackmarket.characters.locked[new_name] or tweak_data.blackmarket.characters[new_name]
	if char_tweak.dlc and not managers.dlc:is_dlc_unlocked(char_tweak.dlc) then
		return
	end
	if tweak_data.blackmarket.characters.locked[new_name] then
		if self:equipped_character() ~= "locked" then
			self:equip_character("locked")
		end
	elseif self:equipped_character() ~= character then
		self:equip_character(character)
	end
	if managers.menu_scene then
		managers.menu_scene:on_set_preferred_character()
	end
end

function BlackMarketManager:get_character_id_by_character_name(character_name)
	local new_name = CriminalsManager.convert_old_to_new_character_workname(character_name)
	if tweak_data.blackmarket.characters.locked[new_name] then
		return "locked"
	end
	return character_name
end

function BlackMarketManager:get_preferred_character()
	return self._global._preferred_character
end

function BlackMarketManager:get_preferred_character_real_name()
	return managers.localization:text("menu_" .. tostring(self._global._preferred_character or "russian"))
end

function BlackMarketManager:get_category_default(category)
	return self._defaults and self._defaults[category]
end

function BlackMarketManager:set_part_texture_switch(category, slot, part_id, data_string)
	local part_data = tweak_data.weapon.factory.parts[part_id]
	if not part_data then
		Applicaton:error("[BlackMarketManager:set_part_texture_switch] Part do not exist", "category", category, "slot", slot, "part_id", part_id, "texture_id", texture_id)
		return
	end
	if not part_data.texture_switch then
		return
	end
	local crafted_category = self._global.crafted_items[category]
	local crafted_item = crafted_category and crafted_category[slot]
	if not crafted_item then
		Application:error("[BlackMarketManager:set_part_texture_switch] crafted_item do not exist", "category", category, "slot", slot, "part_id", part_id, "texture_id", texture_id)
		return
	end
	crafted_item.texture_switches = crafted_item.texture_switches or {}
	crafted_item.texture_switches[part_id] = data_string
end

function BlackMarketManager:get_part_texture_switch_data(category, slot, part_id)
	local crafted_category = self._global.crafted_items[category]
	local crafted_item = crafted_category and crafted_category[slot]
	local texture_switches = crafted_item and crafted_item.texture_switches
	local data_string = texture_switches and texture_switches[part_id] or "1 1"
	local color_index, type_index = unpack(string.split(data_string, " "))
	color_index = tonumber(color_index)
	type_index = tonumber(type_index)
	return color_index, type_index
end

function BlackMarketManager:get_part_texture_switch(category, slot, part_id)
	local crafted_category = self._global.crafted_items[category]
	local crafted_item = crafted_category and crafted_category[slot]
	local texture_switches = crafted_item and crafted_item.texture_switches
	if not texture_switches then
		return
	end
	local data_string = texture_switches and texture_switches[part_id] or "1 1"
	return self:get_texture_switch_from_data(data_string, part_id)
end

function BlackMarketManager:get_texture_switch_from_data(data_string, part_id)
	local part_data = tweak_data.weapon.factory.parts[part_id]
	if not part_data then
		Application:error("[BlackMarketManager:get_part_texture_switch] Part do not exists", "category", category, "slot", slot, "part_id", part_id)
		return
	end
	if not part_data.texture_switch then
		return
	end
	local color_index, type_index = unpack(string.split(data_string, " "))
	color_index = tonumber(color_index) or 1
	type_index = tonumber(type_index) or 1
	local switch_data = tweak_data.gui.weapon_texture_switches.types[part_data.type]
	local weapon_texture_switch = switch_data and switch_data[type_index]
	weapon_texture_switch = weapon_texture_switch and weapon_texture_switch.texture_path or ""
	if color_index == 1 then
		return weapon_texture_switch
	end
	local color = tweak_data:get_raw_value("gui", "weapon_texture_switches", "color_indexes", color_index, "color")
	if not color then
		return
	end
	local texture
	local suffix = switch_data.suffix
	if suffix then
		local pattern = "(%d+)(" .. suffix .. ")"
		local replace = "%1_" .. color .. "%2"
		texture = string.gsub(weapon_texture_switch, pattern, replace)
	else
		texture = weapon_texture_switch .. "_" .. color
	end
	return texture
end

function BlackMarketManager:get_weapon_texture_switches(category, slot, weapon)
	weapon = weapon or self._global.crafted_items[category][slot]
	if not weapon then
		return
	end
	return weapon.texture_switches
end

function BlackMarketManager:aquire_default_masks()
	print("BlackMarketManager:aquire_default_masks()", self._global.crafted_items.masks)
	if not self._global.crafted_items.masks then
		self:on_buy_mask(self._defaults.mask, "normal", 1)
	end
end

function BlackMarketManager:can_modify_mask(slot)
	local mask = managers.blackmarket:get_crafted_category("masks")[slot]
	if not mask or mask.modded then
		return false
	end
	local materials = managers.blackmarket:get_inventory_category("materials")
	local textures = managers.blackmarket:get_inventory_category("textures")
	local colors = managers.blackmarket:get_inventory_category("colors")
	return true
end

function BlackMarketManager:start_customize_mask(slot)
	print("start_customize_mask", slot)
	local mask = managers.blackmarket:get_crafted_category("masks")[slot]
	self._customize_mask = {}
	self._customize_mask.slot = slot
	self._customize_mask.mask_id = mask.mask_id
	self._customize_mask.global_value = mask.global_value
	self._customize_mask.default_blueprint = self:get_mask_default_blueprint(mask.mask_id) or {}
	local default_color = self._customize_mask.default_blueprint.color or {}
	local default_pattern = self._customize_mask.default_blueprint.pattern or {}
	local default_material = self._customize_mask.default_blueprint.material or {}
	if default_color.id ~= "nothing" then
		self._customize_mask.colors = default_color
	end
	if default_pattern.id ~= "no_color_no_material" then
		self._customize_mask.textures = default_pattern
	else
		self._customize_mask.textures = {
			id = "no_color_full_material",
			global_value = "normal"
		}
	end
	if default_material.id ~= "plastic" then
		self._customize_mask.materials = default_material
	end
	self:view_mask(slot)
end

function BlackMarketManager:select_customize_mask(category, id, global_value)
	if not self._customize_mask then
		Application:error("BlackMarketManager:select_customize_mask( category ), self._customize_mask is nil", category, id, global_value)
		return false
	end
	print("select_customize_mask", category, id)
	self._customize_mask[category] = {
		id = id,
		global_value = global_value or "normal"
	}
	if self:can_view_customized_mask() then
		managers.menu_scene:update_mask(self:get_customized_mask_blueprint())
	end
	return true
end

function BlackMarketManager:customize_mask_category_id(category)
	if not self._customize_mask then
		Application:error("BlackMarketManager:customize_mask_category_id( category ), self._customize_mask is nil", category)
		return
	end
	return self._customize_mask[category] and self._customize_mask[category].id or ""
end

function BlackMarketManager:customize_mask_category_default(category, include_color)
	local default_blueprint = self._customize_mask and self._customize_mask.default_blueprint or {}
	if category == "colors" then
		if include_color then
			return default_blueprint.colors or {id = "nothing", global_value = "normal"}
		end
	elseif category == "textures" then
		return default_blueprint.textures or {
			id = "no_color_full_material",
			global_value = "normal"
		}
	elseif category == "materials" then
		return default_blueprint.materials or {id = "plastic", global_value = "normal"}
	end
end

function BlackMarketManager:get_mask_default_blueprint(mask_id)
	local mask_tweak_data = tweak_data.blackmarket.masks[mask_id]
	local default_blueprint = {}
	default_blueprint.color = {id = "nothing", global_value = "normal"}
	default_blueprint.pattern = {
		id = "no_color_no_material",
		global_value = "normal"
	}
	default_blueprint.material = {id = "plastic", global_value = "normal"}
	default_blueprint.colors = default_blueprint.color
	default_blueprint.textures = default_blueprint.pattern
	default_blueprint.materials = default_blueprint.material
	if not mask_tweak_data then
		return default_blueprint
	end
	local mask_default_blueprint = mask_tweak_data.default_blueprint
	if mask_default_blueprint then
		local get_global_value_func = function(data)
			local global_value = data.infamous and "infamous" or data.global_value or data.dlc or data.dlcs and data.dlcs[1] or "normal"
			return global_value
		end
		local got_material = false
		local got_pattern = false
		local got_color = false
		local color_id = mask_default_blueprint.color or mask_default_blueprint.colors
		local color_tweak_data = color_id and tweak_data.blackmarket.colors[color_id]
		if color_tweak_data then
			local global_value = get_global_value_func(color_tweak_data)
			local color = color_tweak_data and {id = color_id, global_value = global_value}
			default_blueprint.color = color or default_blueprint.color
			default_blueprint.colors = default_blueprint.color
			got_color = true
		end
		local texture_id = mask_default_blueprint.pattern or mask_default_blueprint.textures
		local texture_tweak_data = texture_id and tweak_data.blackmarket.textures[texture_id]
		if texture_tweak_data then
			local global_value = get_global_value_func(texture_tweak_data)
			local pattern = texture_tweak_data and {id = texture_id, global_value = global_value}
			default_blueprint.pattern = pattern or default_blueprint.pattern
			default_blueprint.textures = default_blueprint.pattern
			got_pattern = true
		end
		local material_id = mask_default_blueprint.material or mask_default_blueprint.materials
		local material_tweak_data = material_id and tweak_data.blackmarket.materials[material_id]
		if material_tweak_data then
			local global_value = get_global_value_func(material_tweak_data)
			local material = material_tweak_data and {id = material_id, global_value = global_value}
			default_blueprint.material = material or default_blueprint.material
			default_blueprint.materials = default_blueprint.material
			got_material = true
		end
		if got_material and not got_pattern then
			default_blueprint.pattern = {
				id = "no_color_full_material",
				global_value = "normal"
			}
			default_blueprint.textures = default_blueprint.pattern
		end
	end
	return default_blueprint
end

function BlackMarketManager:get_customize_mask_id()
	if not self._customize_mask then
		return
	end
	do return self._customize_mask.mask_id end
	local mask = managers.blackmarket:get_crafted_category("masks")[self._customize_mask.slot]
	if mask then
		return mask.mask_id
	end
end

function BlackMarketManager:get_customize_mask_value()
	local blueprint = self:get_customized_mask_blueprint()
	return managers.money:get_mask_crafting_price_modified(self._customize_mask.mask_id, self._customize_mask.global_value, blueprint), managers.money:can_afford_mask_crafting(self._customize_mask.mask_id, self._customize_mask.global_value, blueprint)
end

function BlackMarketManager:warn_abort_customize_mask(params)
	if self._customize_mask then
		managers.menu:show_confirm_blackmarket_abort(params)
		return true
	end
end

function BlackMarketManager:currently_customizing_mask()
	return self._customize_mask and true or false
end

function BlackMarketManager:abort_customize_mask()
	self._customize_mask = nil
	managers.menu_scene:remove_item()
end

function BlackMarketManager:get_info_from_mask_blueprint(blueprint, mask_id)
	local got_material = blueprint.material
	local got_pattern = blueprint.pattern
	local got_color = blueprint.color
	local status = {}
	table.insert(status, {
		name = "materials",
		text = got_material and tweak_data.blackmarket.materials[blueprint.material.id].name_id or "bm_menu_materials",
		color = got_material and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1,
		id = got_material and blueprint.material.id,
		is_good = got_material and true or false
	})
	table.insert(status, {
		name = "textures",
		text = got_pattern and tweak_data.blackmarket.textures[blueprint.pattern.id].name_id or "bm_menu_textures",
		color = got_pattern and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1,
		id = got_pattern and blueprint.pattern.id,
		is_good = got_pattern and true or false
	})
	table.insert(status, {
		name = "colors",
		text = got_color and tweak_data.blackmarket.colors[blueprint.color.id].name_id or "bm_menu_colors",
		color = got_color and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1,
		id = got_color and blueprint.color.id,
		is_good = got_color and true or false
	})
	if got_material then
		status[1].price = managers.money:get_mask_part_price_modified("materials", blueprint.material.id, blueprint.material.global_value, mask_id)
	end
	if got_pattern then
		status[2].price = managers.money:get_mask_part_price_modified("textures", blueprint.pattern.id, blueprint.pattern.global_value, mask_id)
	end
	if got_color then
		status[3].price = managers.money:get_mask_part_price_modified("colors", blueprint.color.id, blueprint.color.global_value, mask_id)
	end
	if status[2].is_good and Idstring(blueprint.pattern.id) == Idstring("no_color_full_material") then
		status[2].override = "colors"
		status[3].overwritten = true
	end
	if status[2].is_good and Idstring(blueprint.pattern.id) == Idstring("solidfirst") then
		status[2].override = "materials"
		status[1].overwritten = true
	end
	if status[2].is_good and Idstring(blueprint.pattern.id) == Idstring("solidsecond") then
		status[2].override = "materials"
		status[1].overwritten = true
	end
	return status
end

function BlackMarketManager:get_customize_mask_blueprint()
	return {
		material = self._customize_mask.materials,
		pattern = self._customize_mask.textures,
		color = self._customize_mask.colors
	}
end

function BlackMarketManager:info_customize_mask()
	return self:get_info_from_mask_blueprint(self:get_customize_mask_blueprint(), self._customize_mask.mask_id)
end

function BlackMarketManager:can_view_customized_mask()
	return self:can_finish_customize_mask()
end

function BlackMarketManager:can_view_mask_blueprint(blueprint)
	if not blueprint then
		return false
	end
	if not blueprint.pattern then
		return false
	end
	local pattern_ids = Idstring(blueprint.pattern.id)
	if not blueprint.material and pattern_ids ~= Idstring("solidfirst") and pattern_ids ~= Idstring("solidsecond") then
		return false
	end
	if (not blueprint.color or Idstring(blueprint.color.id) == Idstring("nothing")) and pattern_ids ~= Idstring("no_color_full_material") then
		return false
	end
	return true
end

function BlackMarketManager:can_view_customized_mask_with_mod(category, id, global_value)
	if not self._customize_mask then
		return false
	end
	local modded = deep_clone(self._customize_mask)
	modded[category] = {id = id, global_value = global_value}
	if not modded.textures then
		return false
	end
	if not modded.materials and Idstring(modded.textures.id) ~= Idstring("solidfirst") and Idstring(modded.textures.id) ~= Idstring("solidsecond") then
		return false
	end
	if not modded.colors and Idstring(modded.textures.id) ~= Idstring("no_color_full_material") then
		return false
	end
	return true
end

function BlackMarketManager:view_customized_mask_with_mod(category, id)
	if not self._customize_mask then
		return
	end
	local blueprint = {}
	local modded = deep_clone(self._customize_mask)
	modded[category] = {id = id, global_value = "normal"}
	local slot = modded.slot
	blueprint.color = modded.colors
	blueprint.pattern = modded.textures
	blueprint.material = modded.materials
	if not blueprint.color then
		blueprint.pattern = self:customize_mask_category_default("textures")
		blueprint.color = self:customize_mask_category_default("colors", true)
	end
	self:view_mask_with_blueprint(slot, blueprint)
end

function BlackMarketManager:get_customized_mask_blueprint()
	local blueprint = {}
	blueprint.color = self._customize_mask.colors
	blueprint.pattern = self._customize_mask.textures
	blueprint.material = self._customize_mask.materials
	local default_blueprint = self._customize_mask.default_blueprint or {}
	if not blueprint.color then
		blueprint.color = default_blueprint.color or {id = "nothing", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) == Idstring("no_color_full_material") then
		blueprint.color = default_blueprint.color or {id = "nothing", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) == Idstring("solidfirst") then
		blueprint.material = default_blueprint.material or {id = "plastic", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) == Idstring("solidsecond") then
		blueprint.material = default_blueprint.material or {id = "plastic", global_value = "normal"}
	end
	return blueprint
end

function BlackMarketManager:view_customized_mask()
	if not self._customize_mask then
		return
	end
	local blueprint = self:get_customized_mask_blueprint()
	local slot = self._customize_mask.slot
	self:view_mask_with_blueprint(slot, blueprint)
end

function BlackMarketManager:can_afford_customize_mask()
	if not managers.money:can_afford_mask_crafting(self._customize_mask.mask_id, self._customize_mask.global_value, self:get_customized_mask_blueprint()) then
		return false
	end
	return true
end

function BlackMarketManager:can_finish_customize_mask(check_money)
	if not self._customize_mask then
		return false
	end
	if not self._customize_mask.textures then
		return false
	end
	if not self._customize_mask.materials and Idstring(self._customize_mask.textures.id) ~= Idstring("solidfirst") and Idstring(self._customize_mask.textures.id) ~= Idstring("solidsecond") then
		return false
	end
	if not self._customize_mask.colors and Idstring(self._customize_mask.textures.id) ~= Idstring("no_color_full_material") then
		return false
	end
	if check_money and not managers.money:can_afford_mask_crafting(self._customize_mask.mask_id, self._customize_mask.global_value, self:get_customized_mask_blueprint()) then
		return false
	end
	return true
end

function BlackMarketManager:finish_customize_mask()
	print("finish_customize_mask", inspect(self._customize_mask))
	local blueprint = self:get_customized_mask_blueprint()
	local default_blueprint = self._customize_mask.default_blueprint or {}
	local slot = self._customize_mask.slot
	managers.money:on_buy_mask(self._customize_mask.mask_id, self._customize_mask.global_value, blueprint, default_blueprint)
	self._customize_mask.textures = self._customize_mask.textures or default_blueprint.textures or {
		id = "no_color_full_material",
		global_value = "normal"
	}
	self._customize_mask.materials = self._customize_mask.materials or default_blueprint.materials or {id = "plastic", global_value = "normal"}
	local pattern_ids = Idstring(blueprint.pattern.id)
	if pattern_ids ~= Idstring("no_color_full_material") then
		local default_color = self:customize_mask_category_default("colors", true) or {}
		if blueprint.color.id ~= default_color.id then
			self:remove_item(blueprint.color.global_value, "colors", blueprint.color.id)
			self:alter_global_value_item(blueprint.color.global_value, "colors", slot, blueprint.color.id, INV_TO_CRAFT)
		else
			Application:debug("default color", blueprint.color.id)
		end
		local default_pattern = self:customize_mask_category_default("textures", true) or {}
		if blueprint.pattern.id ~= default_pattern.id then
			self:remove_item(blueprint.pattern.global_value, "textures", blueprint.pattern.id)
			self:alter_global_value_item(blueprint.pattern.global_value, "textures", slot, blueprint.pattern.id, INV_TO_CRAFT)
		else
			Application:debug("default pattern", blueprint.pattern.id)
		end
	else
		blueprint.color = default_blueprint.color or {id = "nothing", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) ~= Idstring("solidfirst") and Idstring(blueprint.pattern.id) ~= Idstring("solidsecond") then
		local default_material = self:customize_mask_category_default("materials", true) or {}
		if blueprint.material.id ~= default_material.id then
			self:remove_item(blueprint.material.global_value, "materials", blueprint.material.id)
			self:alter_global_value_item(blueprint.material.global_value, "materials", slot, blueprint.material.id, INV_TO_CRAFT)
		else
			Application:debug("default material", blueprint.material.id)
		end
	else
		blueprint.material = default_blueprint.material or {id = "plastic", global_value = "normal"}
	end
	self._customize_mask = nil
	self:set_mask_blueprint(slot, blueprint)
	local modified_slot = managers.blackmarket:get_crafted_category("masks")[slot]
	if modified_slot then
		modified_slot.modded = true
		if modified_slot.equipped then
			self:equip_mask(slot)
		end
	end
	managers.achievment:award("masked_villain")
end

function BlackMarketManager:on_buy_mask_to_inventory(mask_id, global_value, slot)
	self:on_buy_mask(mask_id, global_value, slot)
	self:remove_item(global_value, "masks", mask_id)
	self:alter_global_value_item(global_value, "masks", slot, mask_id, INV_TO_CRAFT)
end

function BlackMarketManager:on_buy_mask(mask_id, global_value, slot)
	local category = "masks"
	self._global.crafted_items[category] = self._global.crafted_items[category] or {}
	local default_blueprint = self:get_mask_default_blueprint(mask_id)
	local blueprint = {}
	blueprint.color = default_blueprint.color or {id = "nothing", global_value = "normal"}
	blueprint.pattern = default_blueprint.pattern or {
		id = "no_color_no_material",
		global_value = "normal"
	}
	blueprint.material = default_blueprint.material or {id = "plastic", global_value = "normal"}
	self._global.crafted_items[category][slot] = {
		mask_id = mask_id,
		global_value = global_value,
		blueprint = blueprint,
		modded = false
	}
	self:_verfify_equipped_category(category)
end

function BlackMarketManager:get_default_mask_blueprint()
	local blueprint = {}
	blueprint.color = {id = "nothing", global_value = "normal"}
	blueprint.pattern = {
		id = "no_color_no_material",
		global_value = "normal"
	}
	blueprint.material = {id = "plastic", global_value = "normal"}
	return blueprint
end

function BlackMarketManager:on_sell_inventory_mask(mask_id, global_value)
	local blueprint = {}
	blueprint.color = {id = "nothing", global_value = "normal"}
	blueprint.pattern = {
		id = "no_color_no_material",
		global_value = "normal"
	}
	blueprint.material = {id = "plastic", global_value = "normal"}
	if self:remove_item(global_value, "masks", mask_id) then
		managers.money:on_sell_mask(mask_id, global_value, blueprint)
		self:alter_global_value_item(global_value, "masks", nil, mask_id, INV_REMOVE)
	end
end

function BlackMarketManager:on_sell_mask(slot, skip_verification)
	local category = "masks"
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		return
	end
	local equipped_mask_slot = self:equipped_mask_slot()
	local mask = self._global.crafted_items[category][slot]
	managers.money:on_sell_mask(mask.mask_id, mask.global_value, mask.blueprint)
	local blueprint = mask.blueprint or {}
	for category, part in pairs(blueprint) do
		local converted_category = category == "color" and "colors" or category == "material" and "materials" or category == "pattern" and "textures" or category
		Application:debug(part.global_value, converted_category, slot, part.id, CRAFT_REMOVE)
		self:alter_global_value_item(part.global_value, converted_category, slot, part.id, CRAFT_REMOVE)
		local default = self:customize_mask_category_default(converted_category, true) or {}
		if default.id ~= part.id and part.id ~= "no_color_no_material" and managers.money:get_mask_part_price(converted_category, part.id, part.global_value) == 0 then
			managers.blackmarket:add_to_inventory(part.global_value, converted_category, part.id, true)
		end
	end
	self:alter_global_value_item(mask.global_value, category, slot, mask.mask_id, CRAFT_REMOVE)
	self._global.crafted_items[category][slot] = nil
	if managers.money:get_mask_sell_value(mask.mask_id, mask.global_value, {}) == 0 then
		managers.blackmarket:add_to_inventory(mask.global_value, category, mask.mask_id, true)
	end
	if not skip_verification then
		if slot == equipped_mask_slot then
			self:equip_mask(1)
		end
		self:_verfify_equipped_category(category)
	end
end

function BlackMarketManager:view_mask_with_mask_id(mask_id)
	managers.menu_scene:spawn_mask(mask_id)
end

function BlackMarketManager:view_mask(slot)
	local category = "masks"
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:view_mask] Trying to view mask that doesn't exist", category, slot)
		return
	end
	local data = self._global.crafted_items[category][slot]
	local mask_id = data.mask_id
	local blueprint = data.blueprint
	managers.menu_scene:spawn_mask(mask_id, blueprint)
end

function BlackMarketManager:view_mask_with_blueprint(slot, blueprint)
	local category = "masks"
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:view_mask_with_blueprint] Trying to view mask that doesn't exist", category, slot)
		return
	end
	local data = self._global.crafted_items[category][slot]
	local mask_id = data.mask_id
	if not self:can_view_mask_blueprint(blueprint) then
		managers.menu_scene:spawn_or_update_mask(mask_id, data.blueprint)
	else
		managers.menu_scene:spawn_or_update_mask(mask_id, blueprint)
	end
end

function BlackMarketManager:set_mask_blueprint(slot, blueprint)
	local category = "masks"
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:set_mask_blueprint] Trying to set blueprint for mask that doesn't exist", category, slot)
		return
	end
	if not blueprint then
		Application:error("[BlackMarketManager:set_mask_blueprint] Need to provide a blueprint")
		return
	end
	self._global.crafted_items[category][slot].blueprint = blueprint
end

function BlackMarketManager:get_real_character(mask_id, peer_id)
	local character
	if managers.network and managers.network:session() and managers.network:session():peer(peer_id) then
		character = managers.network:session():peer(peer_id):character()
	else
		character = self:get_preferred_character()
	end
	return CriminalsManager.convert_old_to_new_character_workname(character)
end

function BlackMarketManager:get_real_mask_id(mask_id, peer_id)
	if tweak_data.blackmarket.masks[mask_id].characters then
		local character = self:get_real_character(mask_id, peer_id)
		if not tweak_data.blackmarket.masks[mask_id].characters[character] and not Application:production_build() then
			for index, _ in pairs(tweak_data.blackmarket.masks[mask_id].characters) do
				character = index
				break
			end
		end
		return tweak_data.blackmarket.masks[mask_id].characters[character]
	end
	if mask_id ~= "character_locked" then
		if not tweak_data.blackmarket.masks[mask_id] then
			print("Missing mask:" .. mask_id)
		end
		return mask_id
	end
	local character = self:get_real_character(mask_id, peer_id)
	return tweak_data.blackmarket.masks[mask_id][character]
end

function BlackMarketManager:mask_unit_name_by_mask_id(mask_id, peer_id)
	return tweak_data.blackmarket.masks[self:get_real_mask_id(mask_id, peer_id)].unit
end

function BlackMarketManager:character_sequence_by_character_id(character_id, peer_id)
	if not peer_id and character_id ~= "locked" then
		return tweak_data.blackmarket.characters[character_id].sequence
	end
	local character = self:get_preferred_character()
	if managers.network and managers.network:session() and peer_id then
		print("character_sequence_by_character_id", managers.network:session(), peer_id, character)
		local peer = managers.network:session():peer(peer_id)
		if peer then
			character = peer:character() or character
			if not peer:character() then
				Application:error("character_sequence_by_character_id: Peer missing character", "peer_id", peer_id)
				print(inspect(peer))
			end
		end
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	print("character_sequence_by_character_id", "character", character, "character_id", character_id)
	if tweak_data.blackmarket.characters.locked[character] then
		return tweak_data.blackmarket.characters.locked[character].sequence
	end
	return tweak_data.blackmarket.characters[character].sequence
end

function BlackMarketManager:character_sequence_by_character_name(character, peer_id)
	if managers.network and managers.network:session() and peer_id then
		print("character_sequence_by_character_name", managers.network:session(), peer_id, character_name)
		local peer = managers.network:session():peer(peer_id)
		if peer then
			character = peer:character() or character
			if not peer:character() then
				Application:error("character_sequence_by_character_name: Peer missing character", "peer_id", peer_id)
				print(inspect(peer))
			end
		end
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	if tweak_data.blackmarket.characters.locked[character] then
		return tweak_data.blackmarket.characters.locked[character].sequence
	end
	return tweak_data.blackmarket.characters[character].sequence
end

function BlackMarketManager:character_mask_on_sequence_by_character_id(character_id, peer_id)
	if not peer_id and character_id ~= "locked" then
		return tweak_data.blackmarket.characters[character_id].mask_on_sequence
	end
	local character = self:get_preferred_character()
	if managers.network and managers.network:session() and peer_id then
		local peer = managers.network:session():peer(peer_id)
		if peer then
			character = peer:character() or character
			if not peer:character() then
				Application:error("character_sequence_by_character_id: Peer missing character", "peer_id", peer_id)
				print(inspect(peer))
			end
		end
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	print("character_sequence_by_character_id", "character", character, "character_id", character_id)
	if tweak_data.blackmarket.characters.locked[character] then
		return tweak_data.blackmarket.characters.locked[character].mask_on_sequence
	end
	return tweak_data.blackmarket.characters[character].mask_on_sequence
end

function BlackMarketManager:character_mask_off_sequence_by_character_id(character_id, peer_id)
	if not peer_id and character_id ~= "locked" then
		return tweak_data.blackmarket.characters[character_id].mask_off_sequence
	end
	local character = self:get_preferred_character()
	if managers.network and managers.network:session() and peer_id then
		local peer = managers.network:session():peer(peer_id)
		if peer then
			character = peer:character() or character
			if not peer:character() then
				Application:error("character_sequence_by_character_id: Peer missing character", "peer_id", peer_id)
				print(inspect(peer))
			end
		end
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	print("character_sequence_by_character_id", "character", character, "character_id", character_id)
	if tweak_data.blackmarket.characters.locked[character] then
		return tweak_data.blackmarket.characters.locked[character].mask_off_sequence
	end
	return tweak_data.blackmarket.characters[character].mask_off_sequence
end

function BlackMarketManager:character_mask_on_sequence_by_character_name(character, peer_id)
	if managers.network and managers.network:session() and peer_id then
		local peer = managers.network:session():peer(peer_id)
		if peer then
			character = peer:character() or character
			if not peer:character() then
				Application:error("character_sequence_by_character_id: Peer missing character", "peer_id", peer_id)
				print(inspect(peer))
			end
		end
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	if tweak_data.blackmarket.characters.locked[character] then
		return tweak_data.blackmarket.characters.locked[character].mask_on_sequence
	end
	return tweak_data.blackmarket.characters[character].mask_on_sequence
end

function BlackMarketManager:reset()
	self._global.inventory = {}
	self._global.crafted_items = {}
	self._global.global_value_items = {}
	self._global.new_drops = {}
	self._global.new_item_type_unlocked = {}
	self:_setup_weapons()
	self:_setup_characters()
	self:_setup_armors()
	self:_setup_grenades()
	self:_setup_melee_weapons()
	self:_setup_unlocked_mask_slots()
	self:_setup_unlocked_weapon_slots()
	self:_setup_track_global_values()
	self:aquire_default_weapons()
	self:aquire_default_masks()
	self:_verfify_equipped()
	if managers.menu_scene then
		managers.menu_scene:on_blackmarket_reset()
	end
end

function BlackMarketManager:reset_equipped()
	self._global.new_drops = {}
	self._global.new_item_type_unlocked = {}
	self:_setup_weapons()
	self:_setup_armors()
	self:_setup_grenades()
	self:_setup_melee_weapons()
	managers.dlc:give_dlc_package()
	self:_verify_dlc_items()
	self:aquire_default_weapons(true)
	self:_verfify_equipped()
	if managers.menu_scene then
		managers.menu_scene:on_blackmarket_reset()
	end
end

function BlackMarketManager:save(data)
	local save_data = deep_clone(self._global)
	save_data.equipped_armor = self:equipped_armor()
	save_data.equipped_grenade = self:equipped_grenade()
	save_data.equipped_melee_weapon = self:equipped_melee_weapon()
	save_data.armors = nil
	save_data.grenades = nil
	save_data.melee_weapons = nil
	save_data.masks = nil
	save_data.weapon_upgrades = nil
	save_data.weapons = nil
	data.blackmarket = save_data
end

function BlackMarketManager:load(data)
	if data.blackmarket then
		local default_global = self._global or {}
		Global.blackmarket_manager = data.blackmarket
		self._global = Global.blackmarket_manager
		if self._global.equipped_armor and type(self._global.equipped_armor) ~= "string" then
			self._global.equipped_armor = nil
		end
		self._global.armors = default_global.armors or {}
		for armor, _ in pairs(tweak_data.blackmarket.armors) do
			if not self._global.armors[armor] then
				self._global.armors[armor] = {
					unlocked = false,
					owned = false,
					equipped = false
				}
			else
				self._global.armors[armor].equipped = false
			end
		end
		if not self._global.equipped_armor or not self._global.armors[self._global.equipped_armor] then
			self._global.equipped_armor = self._defaults.armor
		end
		self._global.armors[self._global.equipped_armor].equipped = true
		self._global.equipped_armor = nil
		self._global.grenades = default_global.grenades or {}
		if self._global.grenades[self._defaults.grenade] then
			self._global.grenades[self._defaults.grenade].equipped = false
		end
		if self._global.grenades[self._global.equipped_grenade] then
			self._global.grenades[self._global.equipped_grenade].equipped = true
		else
			self._global.grenades[self._defaults.grenade].equipped = true
		end
		for grenade, data in pairs(self._global.grenades) do
			self._global.grenades[grenade].level = 0
			self._global.grenades[grenade].skill_based = false
		end
		self._global.equipped_grenade = nil
		self._global.melee_weapons = default_global.melee_weapons or {}
		if self._global.melee_weapons[self._defaults.melee_weapon] then
			self._global.melee_weapons[self._defaults.melee_weapon].equipped = false
		end
		if self._global.melee_weapons[self._global.equipped_melee_weapon] then
			self._global.melee_weapons[self._global.equipped_melee_weapon].equipped = true
		else
			self._global.melee_weapons[self._defaults.melee_weapon].equipped = true
		end
		for melee_weapon, data in pairs(self._global.melee_weapons) do
			local is_default, melee_weapon_level = managers.upgrades:get_value(melee_weapon)
			self._global.melee_weapons[melee_weapon].level = melee_weapon_level
			self._global.melee_weapons[melee_weapon].skill_based = not is_default and melee_weapon_level == 0 and not tweak_data.blackmarket.melee_weapons[melee_weapon].dlc and not tweak_data.blackmarket.melee_weapons[melee_weapon].free
		end
		self._global.equipped_melee_weapon = nil
		self._global.weapons = default_global.weapons or {}
		for weapon, data in pairs(tweak_data.weapon) do
			if not self._global.weapons[weapon] and data.autohit then
				local selection_index = data.use_data.selection_index
				local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon)
				self._global.weapons[weapon] = {
					owned = false,
					equipped = false,
					unlocked = false,
					factory_id = factory_id,
					selection_index = selection_index
				}
			end
		end
		for weapon, data in pairs(self._global.weapons) do
			local is_default, weapon_level, got_parent = managers.upgrades:get_value(weapon)
			self._global.weapons[weapon].level = weapon_level
			self._global.weapons[weapon].skill_based = got_parent or not is_default and weapon_level == 0 and not tweak_data.weapon[weapon].global_value
		end
		self._global._preferred_character = self._global._preferred_character or self._defaults.preferred_character
		local character_name = CriminalsManager.convert_old_to_new_character_workname(self._global._preferred_character)
		if not tweak_data.blackmarket.characters.locked[character_name] and not tweak_data.blackmarket.characters[character_name] then
			self._global._preferred_character = self._defaults.preferred_character
		end
		for character, _ in pairs(tweak_data.blackmarket.characters) do
			if not self._global.characters[character] then
				self._global.characters[character] = {
					unlocked = true,
					owned = true,
					equipped = false
				}
			end
		end
		for character, _ in pairs(clone(self._global.characters)) do
			if not tweak_data.blackmarket.characters[character] then
				self._global.characters[character] = nil
			end
		end
		if not self:equipped_character() then
			self._global.characters[self._defaults.character].equipped = true
		end
		self._global.inventory = self._global.inventory or {}
		self._global.crafted_items = self._global.crafted_items or {}
		if not self._global.unlocked_mask_slots then
			self:_setup_unlocked_mask_slots()
		end
		if not self._global.unlocked_weapon_slots then
			self:_setup_unlocked_weapon_slots()
		end
		self._global.new_drops = self._global.new_drops or {}
		self._global.new_item_type_unlocked = self._global.new_item_type_unlocked or {}
		local old_drops = {}
		for global_value, categories in pairs(self._global.new_drops) do
			for category, ids in pairs(categories) do
				for id in pairs(ids) do
					if id and tweak_data.blackmarket[category] and not tweak_data.blackmarket[category][id] then
						Application:error("[BlackMarketManager:load] New drop no longer exists!", "global_value", global_value, "category", category, "id", id)
						self._global.new_drops[global_value][category][id] = false
						old_drops[global_value] = old_drops[global_value] or {}
						old_drops[global_value][category] = old_drops[global_value][category] or {}
						old_drops[global_value][category][id] = true
					elseif category == "primaries" or category == "secondaries" then
						local weapon_id = id or managers.weapon_factory:get_weapon_id_by_factory_id(id)
						local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(id) or id
						if not (factory_id and tweak_data.weapon.factory[factory_id] and weapon_id) or not tweak_data.weapon[weapon_id] then
							Application:error("[BlackMarketManager:load] New drop weapon no longer exists!", "global_value", global_value, "category", category, "weapon_id", weapon_id, "factory_id", factory_id)
							self._global.new_drops[global_value][category][id] = false
							old_drops[global_value] = old_drops[global_value] or {}
							old_drops[global_value][category] = old_drops[global_value][category] or {}
							old_drops[global_value][category][id] = true
						end
					end
				end
			end
		end
		for global_value, categories in pairs(old_drops) do
			for category, ids in pairs(categories) do
				for id in pairs(ids) do
					if self._global.new_drops[global_value] then
						if self._global.new_drops[global_value][category] then
							self._global.new_drops[global_value][category][id] = nil
							if table.size(self._global.new_drops[global_value][category]) == 0 then
								self._global.new_drops[global_value][category] = nil
							end
						end
						if table.size(self._global.new_drops[global_value]) == 0 then
							self._global.new_drops[global_value] = nil
						end
					end
				end
			end
		end
		for category, id in pairs(self._global.new_item_type_unlocked) do
			if category == "announcements" then
				if type(id) ~= "table" then
					Application:error("[BlackMarketManager:load] 'New item type unlocked' announcements was not a table", "announcements", id)
					self._global.new_item_type_unlocked[category] = {}
				end
			elseif id and tweak_data.blackmarket[category] and not tweak_data.blackmarket[category][id] then
				debug_pause("[BlackMarketManager:load] 'New item type unlocked' no longer exists!", "category", category, "id", id)
				self._global.new_item_type_unlocked[category] = false
			elseif category == "primaries" or category == "secondaries" then
				local test_factory_id = id
				if test_factory_id ~= false and test_factory_id ~= true and not managers.weapon_factory:get_weapon_id_by_factory_id(test_factory_id) then
					local fixed
					for weapon_id, weapon_data in pairs(self._global.weapons) do
						if test_factory_id == managers.weapon_factory:get_weapon_name_by_factory_id(weapon_data.factory_id) then
							self._global.new_item_type_unlocked[category] = weapon_data.factory_id
							fixed = true
							Application:debug("[BlackMarketManager:load] Found weapon from string for 'new item type unlocked'", "test_name", test_factory_id, "weapon_id", weapon_id, "category", category)
							break
						end
					end
					if not fixed then
						debug_pause("[BlackMarketManager:load] Unknown weapon in 'new item type unlocked'", self._global.new_item_type_unlocked[category], "category", category)
						self._global.new_item_type_unlocked[category] = false
					end
				end
			end
		end
		self._refill_global_values = self:_setup_track_global_values() or nil
	end
end

function BlackMarketManager:refill_track_global_values()
	Application:debug("[BlackMarketManager:refill_track_global_values] Refilling Global.blackmarket_manager.global_value_items")
	local global_value_items = Global.blackmarket_manager.global_value_items
	local new_global_value_items = {}
	for global_value, data in pairs(global_value_items) do
		new_global_value_items[global_value] = {}
		new_global_value_items[global_value].crafted_items = {}
		new_global_value_items[global_value].inventory = {}
	end
	local crafted_items = Global.blackmarket_manager.crafted_items or {}
	local primaries = crafted_items.primaries
	local secondaries = crafted_items.secondaries
	local masks = crafted_items.masks
	local crafted_weapons = {primaries = primaries, secondaries = secondaries}
	local global_values
	
	local function add_crafted_item_func(global_value, category, slot, id)
		local global_value_item = new_global_value_items[global_value]
		if global_value_item and global_value_item.crafted_items then
			global_value_item.crafted_items[category] = global_value_item.crafted_items[category] or {}
			global_value_item.crafted_items[category][slot] = global_value_item.crafted_items[category][slot] or {}
			global_value_item.crafted_items[category][slot][id] = (global_value_item.crafted_items[category][slot][id] or 0) + 1
		end
	end
	
	local function add_inventory_item_func(global_value, category, id, num)
		local global_value_item = new_global_value_items[global_value]
		if global_value_item and global_value_item.inventory then
			global_value_item.inventory[category] = global_value_item.inventory[category] or {}
			global_value_item.inventory[category][id] = (global_value_item.inventory[category][id] or 0) + (num or 1)
		end
	end
	
	for category, category_data in pairs(crafted_weapons) do
		for slot, data in pairs(category_data) do
			global_values = data.global_values or {}
			for part_id, global_value in pairs(global_values) do
				add_crafted_item_func(global_value, category, slot, part_id)
			end
		end
	end
	for slot, data in pairs(masks) do
		local mask_global_value = data.global_value
		add_crafted_item_func(mask_global_value, "masks", slot, data.mask_id)
		for category, item in pairs(data.blueprint or {}) do
			local converted_category = category == "color" and "colors" or category == "material" and "materials" or category == "pattern" and "textures" or category
			add_crafted_item_func(item.global_value, converted_category, slot, item.id)
		end
	end
	for global_value, data in pairs(Global.blackmarket_manager.inventory) do
		for category, cat_data in pairs(data) do
			for id, num in pairs(cat_data) do
				add_inventory_item_func(global_value, category, id, num)
			end
		end
	end
	Application:debug("[BlackMarketManager:refill_track_global_values] Refill done")
	Global.blackmarket_manager.global_value_items = new_global_value_items
end

function BlackMarketManager:_load_done()
	Application:debug("BlackMarketManager:_load_done()")
	self:_verfify_equipped()
	self:aquire_default_weapons()
	self:aquire_default_masks()
	if managers.menu_scene then
		managers.menu_scene:set_character(self:equipped_character())
		managers.menu_scene:on_set_preferred_character()
		local equipped_mask = self:equipped_mask()
		if equipped_mask.mask_id then
			managers.menu_scene:set_character_mask_by_id(equipped_mask.mask_id, equipped_mask.blueprint)
		else
			managers.menu_scene:set_character_mask(tweak_data.blackmarket.masks[equipped_mask].unit)
		end
		managers.menu_scene:set_character_armor(self:equipped_armor())
		local rank = managers.experience:current_rank()
		if 0 < rank then
			managers.menu_scene:set_character_equipped_card(nil, rank - 1)
		else
			local secondary = self:equipped_secondary()
			if secondary then
				managers.menu_scene:set_character_equipped_weapon(nil, secondary.factory_id, secondary.blueprint, "secondary")
			end
		end
		local primary = self:equipped_primary()
		if primary then
			managers.menu_scene:set_character_equipped_weapon(nil, primary.factory_id, primary.blueprint, "primary")
		end
	end
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:verify_dlc_items()
	self:_cleanup_blackmarket()
	if self._refill_global_values then
		self._refill_global_values = nil
		self:refill_track_global_values()
	end
	self:_verify_dlc_items()
	self:_load_done()
end

function BlackMarketManager:_cleanup_blackmarket()
	Application:debug("[BlackMarketManager:_cleanup_blackmarket] STARTING BLACKMARKET CLEANUP")
	Application:debug("----------------------------------------------------------------------")
	local crafted_items = self._global.crafted_items
	for category, data in pairs(crafted_items) do
		if not data or type(data) ~= "table" then
			Application:error("BlackMarketManager:_cleanup_blackmarket() Crafted items category invalid", "category", category, "data", inspect(data))
			self._global.crafted_items[category] = {}
		end
	end
	local crafted_masks = crafted_items.masks
	local chk_global_value_func = function(global_value)
		return tweak_data.lootdrop.global_values[global_value or "normal"] and true or false
	end
	local cleanup_mask = false
	for i, mask in pairs(crafted_masks) do
		cleanup_mask = not tweak_data.blackmarket.masks[mask.mask_id]
		cleanup_mask = cleanup_mask or not chk_global_value_func(mask.global_value)
		local blueprint = mask.blueprint or {}
		if not cleanup_mask then
			for part_type, data in pairs(blueprint) do
				local converted_category = part_type == "color" and "colors" or part_type == "material" and "materials" or part_type == "pattern" and "textures" or part_type
				cleanup_mask = not tweak_data.blackmarket[converted_category][data.id]
				cleanup_mask = cleanup_mask or not chk_global_value_func(data.global_value)
				if cleanup_mask then
					break
				end
			end
		end
		if cleanup_mask then
			if i == 1 then
				self._global.crafted_items.masks[i] = false
				self:on_buy_mask(self._defaults.mask, "normal", 1)
			else
				Application:error("BlackMarketManager:_cleanup_blackmarket() Mask or component of mask invalid, Selling the mask!", "mask_id", mask.mask_id, "global_value", mask.global_value, "blueprint", inspect(blueprint))
				self:on_sell_mask(i, true)
			end
		end
	end
	local invalid_weapons = {}
	local invalid_parts = {}
	
	local function invalid_add_weapon_remove_parts_func(slot, item, part_id)
		table.insert(invalid_weapons, slot)
		Application:error("BlackMarketManager:_cleanup_blackmarket() Part non-existent, weapon invalid", "weapon_id", item.weapon_id, "slot", slot)
		for i = #invalid_parts, 1, -1 do
			if invalid_parts[i] and invalid_parts[i].slot == slot then
				Application:error("removing part from invalid_parts", "part_id", part_id)
				table.remove(invalid_parts, i)
			end
		end
	end
	
	local factory = tweak_data.weapon.factory
	for _, category in ipairs({
		"primaries",
		"secondaries"
	}) do
		local crafted_category = self._global.crafted_items[category]
		invalid_weapons = {}
		invalid_parts = {}
		for slot, item in pairs(crafted_category) do
			local factory_id = item.factory_id
			local weapon_id = item.weapon_id
			local blueprint = item.blueprint
			local global_values = item.global_values or {}
			local texture_switches = item.texture_switches
			local index_table = {}
			local weapon_invalid = not tweak_data.weapon[weapon_id] or not tweak_data.weapon.factory[factory_id] or managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id) ~= factory_id or managers.weapon_factory:get_weapon_id_by_factory_id(factory_id) ~= weapon_id or not chk_global_value_func(tweak_data.weapon[weapon_id].global_value)
			if weapon_invalid then
				table.insert(invalid_weapons, slot)
			else
				item.global_values = item.global_values or {}
				for i, part_id in ipairs(factory[factory_id].uses_parts) do
					index_table[part_id] = i
				end
				for i, part_id in ipairs(blueprint) do
					if not index_table[part_id] or not chk_global_value_func(item.global_values[part_id]) then
						Application:error("BlackMarketManager:_cleanup_blackmarket() Weapon part no longer in uses parts or bad global value", "part_id", part_id, "weapon_id", item.weapon_id, "part_global_value", item.global_values[part_id])
						local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
						if table.contains(default_blueprint, part_id) then
							invalid_add_weapon_remove_parts_func(slot, item, part_id)
							break
						else
							local default_mod
							if tweak_data.weapon.factory.parts[part_id] then
								local ids_id = Idstring(tweak_data.weapon.factory.parts[part_id].type)
								for i, d_mod in ipairs(default_blueprint) do
									if Idstring(tweak_data.weapon.factory.parts[d_mod].type) == ids_id then
										default_mod = d_mod
										break
									end
								end
								if default_mod then
									table.insert(invalid_parts, {
										slot = slot,
										global_value = "normal",
										default_mod = default_mod,
										part_id = part_id
									})
								else
									table.insert(invalid_parts, {
										slot = slot,
										global_value = item.global_values[part_id] or "normal",
										part_id = part_id
									})
								end
							else
								invalid_add_weapon_remove_parts_func(slot, item, part_id)
								break
							end
						end
					end
				end
			end
			if texture_switches then
				local invalid_texture_switches = {}
				for part_id, texture_id in pairs(texture_switches) do
					if not tweak_data.weapon.factory.parts[part_id] then
						table.insert(invalid_texture_switches, part_id)
					else
						local texture = self:get_part_texture_switch(category, slot, part_id)
						if not texture or type(texture) ~= "string" or texture == "" then
							table.insert(invalid_texture_switches, part_id)
						end
					end
				end
				for _, part_id in ipairs(invalid_texture_switches) do
					texture_switches[part_id] = nil
					Application:error("BlackMarketManager:_cleanup_blackmarket() Removing invalid weapon texture switch", "category", category, "slot", slot, "part_id", part_id)
				end
			end
			local t = {}
			for part_id, gv in pairs(global_values) do
				if not table.contains(blueprint, part_id) then
					Application:debug("BlackMarketManager:_cleanup_blackmarket() part exists in weapons global values but not in its blueprint. Removing it", "category", category, "slot", slot, "part_id", part_id, "global_value", gv)
					table.insert(t, part_id)
				end
			end
			for i, part_id in ipairs(t) do
				global_values[part_id] = nil
			end
		end
		for _, slot in ipairs(invalid_weapons) do
			Application:error("BlackMarketManager:_cleanup_blackmarket() Removing invalid Weapon", "slot", slot, "inspect", inspect(crafted_category[slot]))
			self:on_sell_weapon(category, slot, true)
		end
		for _, data in ipairs(invalid_parts) do
			if crafted_category[data.slot] then
				Application:error("BlackMarketManager:_cleanup_blackmarket() Removing invalid Weapon part", "slot", data.slot, "part_id", data.part_id, "inspect", inspect(crafted_category[data.slot]), inspect(data))
				if data.default_mod then
					self:buy_and_modify_weapon(category, data.slot, data.global_value, data.default_mod, true, true)
				else
					self:remove_weapon_part(category, data.slot, data.global_value, data.part_id)
				end
				managers.money:refund_weapon_part(crafted_category[data.slot].weapon_id, data.part_id, data.global_value)
			else
				Application:error("BlackMarketManager:_cleanup_blackmarket() No crafted item in slot", "category", category, "slot", data.slot)
			end
		end
	end
	local bm_tweak_data = tweak_data.blackmarket
	local invalid_items = {}
	
	local function add_invalid_global_value_func(global_value)
		invalid_items[global_value] = true
		Application:error("BlackMarketManager:_cleanup_blackmarket() Invalid inventory global_value detected", "global_value", global_value)
	end
	
	local function add_invalid_category_func(global_value, category)
		invalid_items[global_value] = invalid_items[global_value] or {}
		invalid_items[global_value][category] = true
		Application:error("BlackMarketManager:_cleanup_blackmarket() Invalid inventory category detected", "global_value", global_value, "category", category)
	end
	
	local function add_invalid_item_func(global_value, category, item)
		invalid_items[global_value] = invalid_items[global_value] or {}
		invalid_items[global_value][category] = invalid_items[global_value][category] or {}
		invalid_items[global_value][category][item] = true
		Application:error("BlackMarketManager:_cleanup_blackmarket() Invalid inventory item detected", "global_value", global_value, "category", category, "item", item)
	end
	
	for global_value, categories in pairs(self._global.inventory or {}) do
		if not chk_global_value_func(global_value) then
			add_invalid_global_value_func(global_value)
		else
			for category, items in pairs(categories) do
				if not bm_tweak_data[category] then
					add_invalid_category_func(global_value, category)
				else
					for item, num in pairs(items) do
						local item_tweak_data = bm_tweak_data[category][item]
						if not item_tweak_data then
							add_invalid_item_func(global_value, category, item)
						else
							local global_values = {}
							if item_tweak_data.infamous then
								table.insert(global_values, "infamous")
							end
							if item_tweak_data.dlc then
								table.insert(global_values, item_tweak_data.dlc)
							end
							if item_tweak_data.dlcs then
								for _, dlc in ipairs(item_tweak_data.dlcs) do
									table.insert(global_values, dlc)
								end
							end
							if item_tweak_data.global_value then
								table.insert(global_values, item_tweak_data.global_value)
							end
							if #global_values == 0 then
								table.insert(global_values, "normal")
							end
							global_values = table.list_union(global_values)
							for _, gv in ipairs(global_values) do
								if not chk_global_value_func(gv) then
									add_invalid_item_func(global_value, category, item)
									break
								end
							end
						end
					end
				end
			end
		end
	end
	for global_value, categories in pairs(invalid_items) do
		if type(categories) == "boolean" then
			self._global.inventory[global_value] = nil
		else
			for category, items in pairs(categories) do
				if type(items) == "boolean" then
					if not self._global.inventory[global_value] then
						Application:error("[BlackMarketManager] global_value do not exists in inventory", global_value)
					else
						self._global.inventory[global_value][category] = nil
					end
				else
					for item, invalid in pairs(items) do
						if not self._global.inventory[global_value] then
							Application:error("[BlackMarketManager] global_value do not exists in inventory", global_value)
						elseif not self._global.inventory[global_value][category] then
							Application:error("[BlackMarketManager] category do not exists in inventory", category)
						else
							self._global.inventory[global_value][category][item] = nil
						end
					end
				end
			end
		end
	end
	Application:debug("----------------------------------------------------------------------")
	Application:debug("[BlackMarketManager:_cleanup_blackmarket] BLACKMARKET CLEANUP DONE")
end

function BlackMarketManager:test_clean()
end

function BlackMarketManager:_verify_dlc_items()
	Application:debug("-----------------------BlackMarketManager:_verify_dlc_items-----------------------")
	local owns_dlc
	for package_id, data in pairs(tweak_data.dlc) do
		if tweak_data.lootdrop.global_values[package_id] then
			owns_dlc = tweak_data.lootdrop.global_values[package_id].dlc and (data.free or managers.dlc:has_dlc(package_id)) or false
			print("owns_dlc", owns_dlc, "dlc", package_id, "not free", not data.free, "not has_dlc", not managers.dlc:has_dlc(package_id))
			if owns_dlc then
			elseif self._global.global_value_items[package_id] then
				print("You do not own " .. package_id .. ", will lock all related items.")
				local all_crafted_items = self._global.global_value_items[package_id].crafted_items or {}
				local primaries = all_crafted_items.primaries or {}
				local secondaries = all_crafted_items.secondaries or {}
				for slot, parts in pairs(primaries) do
					local crafted = managers.blackmarket:get_crafted_category("primaries")
					if not crafted then
						break
					end
					crafted = crafted[slot]
					if crafted then
						local factory_id = crafted.factory_id
						local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
						for part_id, only_one in pairs(parts) do
							if only_one ~= 1 then
								Application:error("[BlackMarketManager] _verify_dlc_items(): something wrong with", primaries, part_id, only_one)
							end
							local default_mod
							local ids_id = Idstring(tweak_data.weapon.factory.parts[part_id].type)
							for i, d_mod in ipairs(default_blueprint) do
								if Idstring(tweak_data.weapon.factory.parts[d_mod].type) == ids_id then
									default_mod = d_mod
									break
								end
							end
							if default_mod then
								self:buy_and_modify_weapon("primaries", slot, "normal", default_mod, true, true)
							else
								self:remove_weapon_part("primaries", slot, package_id, part_id)
							end
							managers.money:refund_weapon_part(crafted.weapon_id, part_id, package_id)
						end
					end
				end
				for slot, parts in pairs(secondaries) do
					local crafted = managers.blackmarket:get_crafted_category("secondaries")
					if not crafted then
						break
					end
					crafted = crafted[slot]
					if crafted then
						local factory_id = crafted.factory_id
						local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
						for part_id, only_one in pairs(parts) do
							if only_one ~= 1 then
								Application:error("[BlackMarketManager] _verify_dlc_items(): something wrong with", secondaries, part_id, only_one)
							end
							local default_mod
							local ids_id = Idstring(tweak_data.weapon.factory.parts[part_id].type)
							for i, d_mod in ipairs(default_blueprint) do
								if Idstring(tweak_data.weapon.factory.parts[d_mod].type) == ids_id then
									default_mod = d_mod
									break
								end
							end
							if default_mod then
								self:buy_and_modify_weapon("secondaries", slot, "normal", default_mod, true, true)
							else
								self:remove_weapon_part("secondaries", slot, package_id, part_id)
							end
							managers.money:refund_weapon_part(crafted.weapon_id, part_id, package_id)
						end
					end
				end
				local mask = managers.blackmarket:equipped_mask()
				if mask then
					local is_locked = mask.global_value == package_id
					local default_blueprint = tweak_data.blackmarket.masks[mask.mask_id] and tweak_data.blackmarket.masks[mask.mask_id].default_blueprint or {}
					local name_converter = {
						material = "materials",
						pattern = "textures",
						color = "colors"
					}
					if not is_locked then
						for type, part in pairs(mask.blueprint) do
							if default_blueprint[type] ~= part.id and default_blueprint[name_converter[type]] ~= part.id then
								is_locked = part.global_value == package_id
								if is_locked then
									break
								end
							end
						end
					end
					if is_locked then
						self:equip_mask(1)
					end
				end
			end
		end
	end
	self._global._preferred_character = self._global._preferred_character or self._defaults.preferred_character
	local character_name = CriminalsManager.convert_old_to_new_character_workname(self._global._preferred_character)
	local char_tweak = tweak_data.blackmarket.characters.locked[character_name] or tweak_data.blackmarket.characters[character_name]
	if char_tweak.dlc and not managers.dlc:is_dlc_unlocked(char_tweak.dlc) then
		self:set_preferred_character(self._defaults.preferred_character)
	end
	local player_level = managers.experience:current_level()
	local unlocked, level, skill_based, weapon_def, weapon_dlc, has_dlc
	for weapon_id, weapon in pairs(Global.blackmarket_manager.weapons) do
		unlocked = weapon.unlocked
		level = weapon.level
		skill_based = weapon.skill_based
		if not unlocked and player_level >= level and not skill_based then
			weapon_def = tweak_data.upgrades.definitions[weapon_id]
			if weapon_def then
				weapon_dlc = weapon_def.dlc
				if weapon_dlc then
					managers.upgrades:aquire(weapon_id, nil, UpgradesManager.AQUIRE_STRINGS[1])
					Global.blackmarket_manager.weapons[weapon_id].unlocked = managers.dlc:is_dlc_unlocked(weapon_dlc) or false
				else
					Application:error("[BlackMarketManager] Weapon locked by unknown source: " .. tostring(weapon_id))
				end
			else
				Application:error("[BlackMarketManager] Missing definition for weapon: " .. tostring(weapon_id))
			end
		end
	end
end

function BlackMarketManager:_verfify_equipped()
	self:_verfify_equipped_category("secondaries")
	self:_verfify_equipped_category("primaries")
	self:_verfify_equipped_category("masks")
	self:_verfify_equipped_category("armors")
	self:_verfify_equipped_category("grenades")
	self:_verfify_equipped_category("melee_weapons")
end

function BlackMarketManager:_verfify_equipped_category(category)
	if category == "armors" then
		local armor_id = self._defaults.armor
		for armor, craft in pairs(Global.blackmarket_manager.armors) do
			if craft.equipped and craft.unlocked and craft.owned then
				armor_id = armor
			end
		end
		for s, data in pairs(Global.blackmarket_manager.armors) do
			data.equipped = s == armor_id
		end
		if managers.menu_scene then
			managers.menu_scene:set_character_armor(armor_id)
		end
		return
	end
	if category == "grenades" then
		local grenade_id = self._defaults.grenade
		for grenade, craft in pairs(Global.blackmarket_manager.grenades) do
			if craft.equipped and craft.unlocked then
				grenade_id = grenade
			end
			local grenade_data = tweak_data.blackmarket.grenades[grenade] or {}
			craft.amount = (not grenade_data.dlc or managers.dlc:is_dlc_unlocked(grenade_data.dlc)) and managers.player:get_max_grenades(grenade) or 0
		end
		for s, data in pairs(Global.blackmarket_manager.grenades) do
			data.equipped = s == grenade_id
		end
		return
	end
	if category == "melee_weapons" then
		local melee_weapon_id = self._defaults.melee_weapon
		for melee_weapon, craft in pairs(Global.blackmarket_manager.melee_weapons) do
			local melee_weapon_data = tweak_data.blackmarket.melee_weapons[melee_weapon] or {}
			print(melee_weapon, inspect(craft))
			if craft.equipped and craft.unlocked and (not melee_weapon_data.dlc or managers.dlc:has_dlc(melee_weapon_data.dlc)) then
				melee_weapon_id = melee_weapon
			end
		end
		for s, data in pairs(Global.blackmarket_manager.melee_weapons) do
			data.equipped = s == melee_weapon_id
		end
		return
	end
	if not self._global.crafted_items[category] then
		return
	end
	local is_weapon = category == "secondaries" or category == "primaries"
	for slot, craft in pairs(self._global.crafted_items[category]) do
		if craft.equipped then
			if is_weapon then
				if self._global.weapons[craft.weapon_id].unlocked then
					return
				else
					craft.equipped = false
				end
			else
				return
			end
		end
	end
	for slot, craft in pairs(self._global.crafted_items[category]) do
		if is_weapon then
			if self._global.weapons[craft.weapon_id].unlocked then
				print("  Equip", category, slot)
				craft.equipped = true
				return
			end
		else
			print("  Equip", category, slot)
			craft.equipped = true
			return
		end
	end
	if category == "secondaries" or category == "primaries" then
		local free_slot = self:_get_free_weapon_slot(category) or 1
		self:on_sell_weapon(category, free_slot)
		local weapon_id = category == "primaries" and "amcar" or "glock_17"
		local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id)
		local blueprint = deep_clone(managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id))
		self._global.crafted_items[category][free_slot] = {
			weapon_id = weapon_id,
			factory_id = factory_id,
			blueprint = blueprint,
			equipped = true
		}
		managers.money:on_buy_weapon_platform(weapon_id, true)
		return
	end
end

function BlackMarketManager:_convert_add_to_mul(value)
	if 1 < value then
		return 1 / value
	elseif value < 1 then
		return math.abs(value - 1) + 1
	else
		return 1
	end
end

function BlackMarketManager:fire_rate_multiplier(name, category, silencer, detection_risk, current_state, blueprint)
	local multiplier = managers.player:upgrade_value(category, "fire_rate_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value(name, "fire_rate_multiplier", 1)
	return multiplier
end

function BlackMarketManager:damage_addend(name, category, silencer, detection_risk, current_state, blueprint)
	local value = 0
	if tweak_data.weapon[name] and tweak_data.weapon[name].ignore_damage_upgrades then
		return value
	end
	value = value + managers.player:upgrade_value("player", "damage_addend", 0)
	value = value + managers.player:upgrade_value("weapon", "damage_addend", 0)
	value = value + managers.player:upgrade_value(category, "damage_addend", 0)
	value = value + managers.player:upgrade_value(name, "damage_addend", 0)
	return value
end

function BlackMarketManager:damage_multiplier(name, category, silencer, detection_risk, current_state, blueprint)
	local multiplier = 1
	if tweak_data.weapon[name] and tweak_data.weapon[name].ignore_damage_upgrades then
		return multiplier
	end
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(name, "damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "passive_damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "passive_damage_multiplier", 1))
	if silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_damage_multiplier", 1))
	end
	local detection_risk_damage_multiplier = managers.player:upgrade_value("player", "detection_risk_damage_multiplier")
	multiplier = multiplier - managers.player:get_value_from_risk_upgrade(detection_risk_damage_multiplier, detection_risk)
	if managers.player:has_category_upgrade("player", "overkill_health_to_damage_multiplier") then
		local damage_ratio = managers.player:upgrade_value("player", "overkill_health_to_damage_multiplier", 1) - 1
		multiplier = multiplier + damage_ratio
	end
	if not current_state or current_state:in_steelsight() then
	else
		multiplier = multiplier + (1 - managers.player:upgrade_value(category, "hip_fire_damage_multiplier", 1))
	end
	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "modded_damage_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:threat_multiplier(name, category, silencer)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "suppression_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "suppression_multiplier2", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "passive_suppression_multiplier", 1))
	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:accuracy_multiplier(name, category, silencer, current_state, fire_mode, blueprint)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", fire_mode .. "_spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(name, "spread_multiplier", 1))
	if silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_spread_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(category, "silencer_spread_multiplier", 1))
	end
	if current_state then
		if current_state._moving then
			multiplier = multiplier + (1 - managers.player:upgrade_value(category, "move_spread_multiplier", 1))
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "move_spread_multiplier", 1))
			multiplier = multiplier + (1 - (self._spread_moving or 1))
		end
		if current_state:in_steelsight() then
			multiplier = multiplier + (1 - tweak_data.weapon[name].spread[current_state._moving and "moving_steelsight" or "steelsight"])
		else
			multiplier = multiplier + (1 - managers.player:upgrade_value(category, "hip_fire_spread_multiplier", 1))
			if current_state._state_data.ducking then
				multiplier = multiplier + (1 - tweak_data.weapon[name].spread[current_state._moving and "moving_crouching" or "crouching"])
			else
				multiplier = multiplier + (1 - tweak_data.weapon[name].spread[current_state._moving and "moving_standing" or "standing"])
			end
		end
	end
	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "modded_spread_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:recoil_addend(name, category, silencer, blueprint)
	local addend = 0
	return addend
end

function BlackMarketManager:recoil_multiplier(name, category, silencer, blueprint)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "passive_recoil_multiplier", 1))
	if managers.player:player_unit() and managers.player:player_unit():character_damage():is_suppressed() then
		if managers.player:has_team_category_upgrade(category, "suppression_recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value(category, "suppression_recoil_multiplier", 1))
		end
		if managers.player:has_team_category_upgrade("weapon", "suppression_recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "suppression_recoil_multiplier", 1))
		end
	else
		if managers.player:has_team_category_upgrade(category, "recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value(category, "recoil_multiplier", 1))
		end
		if managers.player:has_team_category_upgrade("weapon", "recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "recoil_multiplier", 1))
		end
	end
	multiplier = multiplier + (1 - managers.player:upgrade_value(name, "recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "passive_recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "recoil_multiplier", 1))
	if silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_recoil_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(category, "silencer_recoil_multiplier", 1))
	end
	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "modded_recoil_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:check_frog_1()
	if not managers.statistics or not managers.statistics:started_session_from_beginning() then
		return false
	end
	local frog_1_memory = managers.job:get_memory("frog_1")
	local is_correct_job = frog_1_memory ~= false and managers.job and managers.job:has_active_job() and (managers.job:current_real_job_id() == "hox" or managers.job:current_real_job_id() == "hox_prof") and (Global.game_settings.difficulty == "overkill_145" or Global.game_settings.difficulty == "overkill_290" and true) or false
	if is_correct_job then
		local pass_skills, pass_primary, pass_secondary, pass_armor, peer, outfit
		local all_members = managers.network:game() and managers.network:game():all_members() or {}
		local all_passed = true
		for id, member in pairs(all_members) do
			peer = member:peer()
			if all_passed and peer then
				if peer:is_outfit_loaded() then
					outfit = peer:blackmarket_outfit()
					pass_skills = true
					for tree, points in pairs(outfit.skills and outfit.skills.skills or {1}) do
						if tonumber(points) > 0 then
							pass_skills = false
							break
						end
					end
					pass_primary = outfit.primary.factory_id == "wpn_fps_ass_akm_gold"
					pass_secondary = outfit.secondary.factory_id == "wpn_fps_smg_thompson"
					pass_armor = outfit.armor == "level_1"
					all_passed = pass_skills and pass_primary and pass_secondary and pass_armor and true or false
				else
					all_passed = false
				end
			end
		end
		frog_1_memory = all_passed
		managers.job:set_memory("frog_1", frog_1_memory)
		return frog_1_memory
	end
	managers.job:set_memory("frog_1", false)
	return false
end

function BlackMarketManager:debug_inventory()
	local t = {}
	for gv, cat in pairs(self._global.inventory) do
		for type, entry in pairs(cat) do
			t[type] = t[type] or {amount = 0}
			for name, amount in pairs(entry) do
				t[type].amount = t[type].amount + amount
			end
		end
	end
	print(inspect(t))
end
