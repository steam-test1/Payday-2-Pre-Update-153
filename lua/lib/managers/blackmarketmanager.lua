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
	if not Global.blackmarket_manager then
		Global.blackmarket_manager = {}
		self:_setup_armors()
		self:_setup_weapons()
		self:_setup_characters()
		self:_setup_track_global_values()
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
	managers.savefile:add_load_sequence_done_callback_handler(callback(self, self, "_load_done"))
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

function BlackMarketManager:_setup_track_global_values()
	local global_value_items = self._global and self._global.global_value_items or {}
	Global.blackmarket_manager.global_value_items = global_value_items
	for gv, td in pairs(tweak_data.lootdrop.global_values) do
		if td.track then
			global_value_items[gv] = global_value_items[gv] or {}
			global_value_items[gv].crafted_items = global_value_items[gv].crafted_items or {}
			global_value_items[gv].inventory = global_value_items[gv].inventory or {}
		end
	end
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

function BlackMarketManager:equipped_armor()
	local armor
	for armor_id, data in pairs(tweak_data.blackmarket.armors) do
		armor = Global.blackmarket_manager.armors[armor_id]
		if armor.equipped and armor.unlocked and armor.owned then
			return armor_id
		end
	end
	return self._defaults.armor
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
		return nil
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

function BlackMarketManager:equip_weapon(category, slot)
	if not Global.blackmarket_manager.crafted_items[category] then
		return nil
	end
	for s, data in pairs(Global.blackmarket_manager.crafted_items[category]) do
		data.equipped = s == slot
	end
	if managers.menu_scene then
		local data = category == "primaries" and self:equipped_primary() or self:equipped_secondary()
		managers.menu_scene:set_character_equipped_weapon(nil, data.factory_id, data.blueprint, category == "primaries" and "primary" or "secondary")
	end
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:equip_deployable(deployable_id)
	Global.player_manager.kit.equipment_slots[1] = deployable_id
	MenuCallbackHandler:_update_outfit_information()
end

function BlackMarketManager:equip_armor(armor_id)
	for s, data in pairs(Global.blackmarket_manager.armors) do
		data.equipped = s == armor_id
	end
	local equipped = managers.blackmarket:equipped_armor()
	if equipped ~= tweak_data.achievement.how_do_you_like_me_now then
		managers.achievment:award("how_do_you_like_me_now")
	end
	if equipped == tweak_data.achievement.iron_man then
		managers.achievment:award("iron_man")
	end
	if managers.menu_scene then
		managers.menu_scene:set_character_armor(armor_id)
	end
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
	local data = string.split(outfit_string, " ")
	local color_id = data[self:outfit_string_index("mask_color")]
	local pattern_id = data[self:outfit_string_index("mask_pattern")]
	local material_id = data[self:outfit_string_index("mask_material")]
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
	if type == "concealment_modifier" then
		return 12
	end
end

function BlackMarketManager:unpack_outfit_from_string(outfit_string)
	local data = string.split(outfit_string, " ")
	local outfit = {}
	outfit.character = data[self:outfit_string_index("character")]
	outfit.mask = {}
	outfit.mask.mask_id = data[self:outfit_string_index("mask")]
	outfit.mask.blueprint = self:mask_blueprint_from_outfit_string(outfit_string)
	outfit.armor = data[self:outfit_string_index("armor")]
	local primary_blueprint_string = string.gsub(data[self:outfit_string_index("primary_blueprint")], "_", " ")
	local secondary_blueprint_string = string.gsub(data[self:outfit_string_index("secondary_blueprint")], "_", " ")
	outfit.primary = {}
	outfit.primary.factory_id = data[self:outfit_string_index("primary")]
	outfit.primary.blueprint = managers.weapon_factory:unpack_blueprint_from_string(outfit.primary.factory_id, primary_blueprint_string)
	outfit.secondary = {}
	outfit.secondary.factory_id = data[self:outfit_string_index("secondary")]
	outfit.secondary.blueprint = managers.weapon_factory:unpack_blueprint_from_string(outfit.secondary.factory_id, secondary_blueprint_string)
	outfit.deployable = data[self:outfit_string_index("deployable")]
	outfit.concealment_modifier = data[self:outfit_string_index("concealment_modifier")]
	return outfit
end

function BlackMarketManager:outfit_string()
	local s = ""
	s = s .. self:_outfit_string_mask()
	for armor_id, data in pairs(tweak_data.blackmarket.armors) do
		if Global.blackmarket_manager.armors[armor_id].equipped then
			s = s .. " " .. armor_id
		end
	end
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
	else
		s = s .. " " .. "nil"
	end
	local concealment_modifier = self:concealment_modifiers() or 0
	s = s .. " " .. tostring(concealment_modifier)
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
	managers.weapon_factory:preload_blueprint(factory_id, blueprint, false, callback(self, self, "preload_done_callback", category), true)
end

function BlackMarketManager:preload_done_callback(category, preload_table, parts)
	print("preload_done_callback", category, inspect(preload_table), inspect(parts))
	local new_loading
	for part_id, _preload in pairs(preload_table) do
		if _preload.package then
			new_loading = {
				package = _preload.package
			}
		else
			new_loading = {load_me = _preload}
		end
		if Application:production_build() then
			new_loading.part_id = part_id
		end
		table.insert(self._preloading_list, new_loading)
	end
	table.insert(self._preloading_list, {
		category,
		preload_table,
		parts
	})
end

function BlackMarketManager:resource_loaded_callback(category, loaded_table, parts)
	print("resource_loaded_callback", category, inspect(loaded_table), inspect(parts))
	local loaded_category = self._category_resource_loaded[category]
	if loaded_category then
		Application:debug("[BlackMarketManager] resource_loaded_callback(): Unloading old blueprint", inspect(loaded_category))
		for part_id, unload in pairs(loaded_category) do
			if unload.package then
				managers.weapon_factory:unload_package(unload.package)
			else
				managers.dyn_resource:unload(unpack(unload))
			end
		end
	end
	self._category_resource_loaded[category] = loaded_table
end

function BlackMarketManager:release_preloaded_blueprints()
	Application:debug("[BlackMarketManager] release_preloaded_blueprints(): Unloading all blueprints", inspect(self._category_resource_loaded))
	for category, data in pairs(self._category_resource_loaded) do
		for part_id, unload in pairs(data) do
			if unload.package then
				managers.weapon_factory:unload_package(unload.package)
			else
				managers.dyn_resource:unload(unpack(unload))
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
					if next_in_line.package then
						if self._preload_ws then
							self._preload_ws:panel():script().step_progress()
						end
						managers.weapon_factory:load_package(next_in_line.package)
					else
						managers.dyn_resource:load(unpack(next_in_line.load_me))
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
			self._global.new_item_type_unlocked[category] = false
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
		local uses_parts = managers.weapon_factory:get_parts_from_factory_id(id)
		for type, parts in pairs(uses_parts) do
			for _, part in ipairs(parts) do
				if self:check_new_drop("normal", "weapon_mods", part) then
					return true
				end
				if self:check_new_drop("infamous", "weapon_mods", part) then
					return true
				end
			end
		end
	elseif category_ids == Idstring("weapon_mods") then
		if self:check_new_drop("normal", "weapon_mods", id) then
			return true
		end
		if self:check_new_drop("infamous", "weapon_mods", id) then
			return true
		end
	elseif category_ids == Idstring("weapon_tabs") then
		local uses_parts = managers.weapon_factory:get_parts_from_factory_id(id)
		local tab_parts = uses_parts[global_value] or {}
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
	if remove_mod then
		managers.weapon_factory:remove_part_from_blueprint(part_id, blueprint)
	else
		managers.weapon_factory:change_part_blueprint_only(weapon.factory_id, part_id, blueprint)
	end
	local weapon_stats = managers.weapon_factory:get_stats(weapon.factory_id, blueprint)
	for stat, value in pairs(weapon_tweak_data.stats) do
		weapon_stats[stat] = (weapon_stats[stat] or 0) + weapon_tweak_data.stats[stat]
	end
	return weapon_stats
end

function BlackMarketManager:calculate_weapon_concealment(weapon)
	if type(weapon) == "string" then
		weapon = weapon == "primaries" and self:equipped_primary() or weapon == "secondaries" and self:equipped_secondary()
	end
	return self:_calculate_weapon_concealment(weapon)
end

function BlackMarketManager:calculate_armor_concealment(armor)
	return self:_calculate_armor_concealment(armor or self:equipped_armor())
end

function BlackMarketManager:_calculate_weapon_concealment(weapon)
	local factory_id = weapon.factory_id
	local weapon_id = weapon.weapon_id or managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
	local blueprint = weapon.blueprint
	local base_stats = tweak_data.weapon[weapon_id].stats
	if not base_stats or not base_stats.concealment then
		return 0
	end
	local parts_stats = managers.weapon_factory:get_stats(factory_id, blueprint)
	local stats_tweak_data = tweak_data.weapon.stats
	local concealment = math.max(#stats_tweak_data.concealment - (base_stats.concealment + (parts_stats.concealment or 0)), 0)
	return concealment
end

function BlackMarketManager:_calculate_armor_concealment(armor)
	local stats_tweak_data = tweak_data.weapon.stats
	return math.max(#stats_tweak_data.concealment - tweak_data.blackmarket.armors[armor].concealment, 0)
end

function BlackMarketManager:_get_concealment(primary, secondary, armor, modifier)
	local stats_tweak_data = tweak_data.weapon.stats
	local primary_concealment = self:_calculate_weapon_concealment(primary)
	local secondary_concealment = self:_calculate_weapon_concealment(secondary)
	local armor_concealment = self:_calculate_armor_concealment(armor)
	local modifier = modifier or 0
	local total_concealment = math.clamp(primary_concealment + secondary_concealment + armor_concealment + modifier + 3, 1, #stats_tweak_data.concealment)
	return stats_tweak_data.concealment[total_concealment], total_concealment
end

function BlackMarketManager:_get_concealment_from_local_player()
	return self:_get_concealment(self:equipped_primary(), self:equipped_secondary(), self:equipped_armor(), self:concealment_modifiers())
end

function BlackMarketManager:_get_concealment_from_peer(peer)
	local outfit = peer:blackmarket_outfit()
	return self:_get_concealment(outfit.primary, outfit.secondary, outfit.armor, outfit.concealment_modifier)
end

function BlackMarketManager:get_real_concealment_index_from_custom_data(data)
	local primary_concealment = self:calculate_weapon_concealment(data.primaries or "primaries")
	local secondary_concealment = self:calculate_weapon_concealment(data.secondaries or "secondaries")
	local armor_concealment = self:calculate_armor_concealment(data.armors)
	local modifier = self:concealment_modifiers()
	return primary_concealment + secondary_concealment + armor_concealment + modifier + 3
end

function BlackMarketManager:get_real_concealment_index_of_local_player()
	local primary_concealment = self:calculate_weapon_concealment("primaries")
	local secondary_concealment = self:calculate_weapon_concealment("secondaries")
	local armor_concealment = self:calculate_armor_concealment()
	local modifier = self:concealment_modifiers()
	return primary_concealment + secondary_concealment + armor_concealment + modifier + 3
end

function BlackMarketManager:get_suspicion_of_local_player()
	return self:_get_concealment_from_local_player()
end

function BlackMarketManager:get_suspicion_of_peer(peer)
	return self:_get_concealment_from_peer(peer)
end

function BlackMarketManager:concealment_modifiers()
	local skill_bonuses = 0
	return skill_bonuses
end

function BlackMarketManager:get_dropable_mods_by_weapon_id(weapon_id)
	local parts_tweak_data = tweak_data.weapon.factory.parts
	local all_mods = tweak_data.blackmarket.weapon_mods
	local weapon_mods = managers.weapon_factory:get_parts_from_weapon_id(weapon_id)
	local dropable_mods = {}
	local dlc_mods = {}
	for id, data in pairs(weapon_mods) do
		dropable_mods[id] = dropable_mods[id] or {}
		for _, mod in ipairs(data) do
			local my_mod = all_mods[mod]
			if my_mod and (my_mod.pcs or my_mod.pc) then
				local is_dlc = my_mod.dlcs or my_mod.dlc
				if not is_dlc or my_mod.infamous then
					table.insert(dropable_mods[id], {
						mod,
						all_mods.infamous and "infamous" or "normal"
					})
				end
			end
		end
	end
	local content, loot_drops
	for package_id, dlc in pairs(tweak_data.dlc) do
		local global_value = dlc.content and dlc.content.loot_global_value or package_id
		if (dlc.free or managers.dlc:has_dlc(global_value)) and global_value ~= "normal" and global_value ~= "infamous" then
			content = dlc.content
			loot_drops = content and content.loot_drops or {}
			for _, item_data in ipairs(loot_drops) do
				if item_data.type_items == "weapon_mods" then
					local part_id = item_data.item_entry
					local part_type = parts_tweak_data[part_id] and parts_tweak_data[part_id].type
					if part_type then
						dropable_mods[part_type] = dropable_mods[part_type] or {}
						local got_mod = weapon_mods[part_type] and table.contains(weapon_mods[part_type], part_id)
						if got_mod then
							table.insert(dropable_mods[part_type], {part_id, global_value})
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
	material:set_texture("material_texture", material_texture)
	local reflection = tweak_data.blackmarket.materials[material_id].texture
	local material_amount = tweak_data.blackmarket.materials[material_id].material_amount or 1
	local reflection_texture = TextureCache:retrieve(reflection, "normal")
	material:set_texture("reflection_texture", reflection_texture)
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

function BlackMarketManager:_get_free_weapon_slot(category)
	if not self._global.crafted_items[category] then
		return 1
	end
	for i = 1, 9 do
		if not self._global.crafted_items[category][i] then
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
	elseif not loading and id ~= "saw" then
		print("on_aquired_weapon_platform", inspect(upgrade), id)
		self._global.new_drops.normal = self._global.new_drops.normal or {}
		self._global.new_drops.normal[category] = self._global.new_drops.normal[category] or {}
		self._global.new_drops.normal[category][id] = true
		self._global.new_item_type_unlocked[category] = upgrade.factory_id
	end
end

function BlackMarketManager:on_unaquired_weapon_platform(upgrade, id)
	self._global.weapons[id].unlocked = false
	if not managers.blackmarket:equipped_primary() then
		return
	end
	if managers.blackmarket:equipped_primary().weapon_id == id then
		managers.blackmarket:equipped_primary().equipped = false
		self:_verfify_equipped_category("primaries")
		self:_update_menu_scene_primary()
	end
end

function BlackMarketManager:aquire_default_weapons()
	print("BlackMarketManager:aquire_default_weapons()")
	local glock_17 = self._global and self._global.weapons and self._global.weapons.glock_17
	if glock_17 and (not self._global.crafted_items.secondaries or not glock_17.unlocked) and not managers.upgrades:aquired("glock_17") then
		managers.upgrades:aquire("glock_17")
	end
	local amcar = self._global and self._global.weapons and self._global.weapons.amcar
	if amcar and (not self._global.crafted_items.primaries or not amcar.unlocked) and not managers.upgrades:aquired("amcar") then
		managers.upgrades:aquire("amcar")
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
	end
end

function BlackMarketManager:on_sell_weapon_part(part_id, global_value)
	managers.money:on_sell_weapon_part(part_id, global_value)
	self:alter_global_value_item(global_value, "weapon_mods", nil, part_id, INV_REMOVE)
	self:remove_item(global_value, "weapon_mods", part_id)
end

function BlackMarketManager:on_sell_weapon(category, slot)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		return
	end
	local global_values = self._global.crafted_items[category][slot].global_values or {}
	local blueprint = self._global.crafted_items[category][slot].blueprint
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(self._global.crafted_items[category][slot].factory_id)
	for _, default_part in ipairs(default_blueprint) do
		table.delete(blueprint, default_part)
	end
	for _, part_id in pairs(blueprint) do
		local global_value = global_values[part_id] or "normal"
		self:add_to_inventory(global_value, "weapon_mods", part_id, true)
		self:alter_global_value_item(global_value, category, slot, part_id, CRAFT_REMOVE)
	end
	managers.money:on_sell_weapon(category, slot)
	self._global.crafted_items[category][slot] = nil
	self:_verfify_equipped_category(category)
	if category == "primaries" then
		self:_update_menu_scene_primary()
	elseif category == "secondaries" then
		self:_update_menu_scene_secondary()
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

function BlackMarketManager:get_modify_weapon_consequence(category, slot, part_id)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:get_modify_weapon_consequence] Weapon doesn't exist", category, slot)
		return
	end
	local craft_data = self._global.crafted_items[category][slot]
	local replaces = managers.weapon_factory:get_replaces_parts(craft_data.factory_id, part_id, craft_data.blueprint)
	local removes = managers.weapon_factory:get_removes_parts(craft_data.factory_id, part_id, craft_data.blueprint)
	return replaces, removes
end

function BlackMarketManager:can_modify_weapon(category, slot, part_id)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:can_modify_weapon] Weapon doesn't exist", category, slot)
		return
	end
	local craft_data = self._global.crafted_items[category][slot]
	local forbids = managers.weapon_factory:can_add_part(craft_data.factory_id, part_id, craft_data.blueprint)
	return forbids
end

function BlackMarketManager:remove_weapon_part(category, slot, global_value, part_id)
	if not (part_id and self._global.crafted_items[category]) or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:remove_weapon_part] Trying to remove part", part_id, "from weapon that doesn't exist", category, slot)
		return false
	end
	local craft_data = self._global.crafted_items[category][slot]
	managers.weapon_factory:remove_part_from_blueprint(part_id, craft_data.blueprint)
	self:_on_modified_weapon(category, slot)
	local given_global_value = global_value
	local global_value = craft_data.global_values or {}
	global_value = global_value[part_id] or "normal"
	if given_global_value and global_value ~= given_global_value then
		Application:error("[BlackMarketManager] remove_weapon_part(): global_value mismatch", given_global_value, global_value)
	end
	self:alter_global_value_item(global_value, category, slot, part_id, CRAFT_REMOVE)
	self:add_to_inventory(global_value, "weapon_mods", part_id, true)
	return true
end

function BlackMarketManager:modify_weapon(category, slot, global_value, part_id)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:modify_weapon] Trying to modify weapon that doesn't exist", category, slot)
		return
	end
	local replaces, removes = self:get_modify_weapon_consequence(category, slot, part_id)
	local craft_data = self._global.crafted_items[category][slot]
	managers.weapon_factory:change_part_blueprint_only(craft_data.factory_id, part_id, craft_data.blueprint)
	craft_data.global_values = craft_data.global_values or {}
	local old_gv = "" .. (craft_data.global_values[part_id] or "normal")
	craft_data.global_values[part_id] = global_value or "normal"
	local removed_parts = {}
	for _, part in pairs(replaces) do
		table.insert(removed_parts, part)
	end
	for _, part in pairs(removes) do
		table.insert(removed_parts, part)
	end
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(craft_data.factory_id)
	for _, default_part in ipairs(default_blueprint) do
		table.delete(removed_parts, default_part)
	end
	local global_value = "normal"
	for _, removed_part_id in pairs(removed_parts) do
		if removed_part_id == part_id then
			global_value = old_gv or "normal"
		else
			global_value = craft_data.global_values[removed_part_id] or "normal"
			craft_data.global_values[removed_part_id] = nil
		end
		self:add_to_inventory(global_value, "weapon_mods", removed_part_id, true)
		self:alter_global_value_item(global_value, category, slot, removed_part_id, CRAFT_REMOVE)
	end
	self:_on_modified_weapon(category, slot)
end

function BlackMarketManager:buy_and_modify_weapon(category, slot, global_value, part_id, free_of_charge)
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		Application:error("[BlackMarketManager:modify_weapon] Trying to buy and modify weapon that doesn't exist", category, slot)
		return
	end
	self:modify_weapon(category, slot, global_value, part_id)
	if not free_of_charge then
		managers.money:on_buy_weapon_modification(self._global.crafted_items[category][slot].weapon_id, part_id, global_value)
		self:remove_item(global_value, "weapon_mods", part_id)
		self:alter_global_value_item(global_value, "weapon_mods", slot, part_id, INV_REMOVE)
		self:alter_global_value_item(global_value, category, slot, part_id, CRAFT_ADD)
		managers.achievment:award("would_you_like_your_receipt")
	else
	end
end

function BlackMarketManager:_on_modified_weapon(category, slot)
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
	self:preload_weapon_blueprint("preview", weapon.factory_id, weapon.blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(weapon.factory_id, weapon.blueprint)
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
	managers.weapon_factory:change_part_blueprint_only(weapon.factory_id, part_id, blueprint)
	self:preload_weapon_blueprint("preview", weapon.factory_id, weapon.blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(weapon.factory_id, blueprint)
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
	managers.weapon_factory:remove_part_from_blueprint(part_id, blueprint)
	self:preload_weapon_blueprint("preview", weapon.factory_id, blueprint)
	table.insert(self._preloading_list, {
		done_cb = function()
			managers.menu_scene:spawn_item_weapon(weapon.factory_id, blueprint)
		end
	})
	table.insert(self._preloading_list, {done_cb = open_node_cb})
end

function BlackMarketManager:on_aquired_armor(upgrade, id, loading)
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
	if managers.menu_scene then
		managers.menu_scene:on_set_preferred_character()
	end
end

function BlackMarketManager:get_preferred_character()
	return self._global._preferred_character
end

function BlackMarketManager:get_preferred_character_real_name()
	return managers.localization:text("menu_" .. tostring(self._global._preferred_character or "russian"))
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
	self._customize_mask.textures = {
		id = "no_color_full_material",
		global_value = "normal"
	}
	self:view_mask(slot)
end

function BlackMarketManager:select_customize_mask(category, id, global_value)
	print("select_customize_mask", category, id)
	self._customize_mask[category] = {
		id = id,
		global_value = global_value or "normal"
	}
	if self:can_view_customized_mask() then
		managers.menu_scene:update_mask(self:get_customized_mask_blueprint())
	end
end

function BlackMarketManager:customize_mask_category_id(category)
	if not self._customize_mask then
		Application:error("BlackMarketManager:customize_mask_category_id( category ), self._customize_mask is nil", category)
		return
	end
	return self._customize_mask[category] and self._customize_mask[category].id or ""
end

function BlackMarketManager:customize_mask_category_default(category)
	if category == "colors" then
	elseif category == "textures" then
		return {
			id = "no_color_full_material",
			global_value = "normal"
		}
	elseif category == "materials" then
		return {id = "plastic", global_value = "normal"}
	end
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

function BlackMarketManager:info_customize_mask()
	local got_material = self._customize_mask.materials
	local got_pattern = self._customize_mask.textures
	local got_color = self._customize_mask.colors
	local status = {}
	table.insert(status, {
		name = "materials",
		text = got_material and tweak_data.blackmarket.materials[self._customize_mask.materials.id].name_id or "bm_menu_materials",
		color = got_material and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1,
		id = got_material and self._customize_mask.materials.id,
		is_good = got_material and true or false
	})
	table.insert(status, {
		name = "textures",
		text = got_pattern and tweak_data.blackmarket.textures[self._customize_mask.textures.id].name_id or "bm_menu_textures",
		color = got_pattern and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1,
		id = got_pattern and self._customize_mask.textures.id,
		is_good = got_pattern and true or false
	})
	table.insert(status, {
		name = "colors",
		text = got_color and tweak_data.blackmarket.colors[self._customize_mask.colors.id].name_id or "bm_menu_colors",
		color = got_color and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1,
		id = got_color and self._customize_mask.colors.id,
		is_good = got_color and true or false
	})
	if got_material then
		status[1].price = managers.money:get_mask_part_price_modified("materials", self._customize_mask.materials.id, self._customize_mask.materials.global_value)
	end
	if got_pattern then
		status[2].price = managers.money:get_mask_part_price_modified("textures", self._customize_mask.textures.id, self._customize_mask.textures.global_value)
	end
	if got_color then
		status[3].price = managers.money:get_mask_part_price_modified("colors", self._customize_mask.colors.id, self._customize_mask.colors.global_value)
	end
	if status[2].is_good and Idstring(self._customize_mask.textures.id) == Idstring("no_color_full_material") then
		status[2].override = "colors"
		status[3].overwritten = true
	end
	if status[2].is_good and Idstring(self._customize_mask.textures.id) == Idstring("solidfirst") then
		status[2].override = "materials"
		status[1].overwritten = true
	end
	if status[2].is_good and Idstring(self._customize_mask.textures.id) == Idstring("solidsecond") then
		status[2].override = "materials"
		status[1].overwritten = true
	end
	return status
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
		blueprint.color = {id = "nothing", global_value = "normal"}
	end
	self:view_mask_with_blueprint(slot, blueprint)
end

function BlackMarketManager:get_customized_mask_blueprint()
	local blueprint = {}
	blueprint.color = self._customize_mask.colors
	blueprint.pattern = self._customize_mask.textures
	blueprint.material = self._customize_mask.materials
	if not blueprint.color then
		blueprint.color = {id = "nothing", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) == Idstring("no_color_full_material") then
		blueprint.color = {id = "nothing", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) == Idstring("solidfirst") then
		blueprint.material = {id = "plastic", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) == Idstring("solidsecond") then
		blueprint.material = {id = "plastic", global_value = "normal"}
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
	local slot = self._customize_mask.slot
	managers.money:on_buy_mask(self._customize_mask.mask_id, self._customize_mask.global_value, blueprint)
	self._customize_mask.textures = self._customize_mask.textures or {
		id = "no_color_full_material",
		global_value = "normal"
	}
	self._customize_mask.materials = self._customize_mask.materials or {id = "plastic", global_value = "normal"}
	if Idstring(blueprint.pattern.id) ~= Idstring("no_color_full_material") then
		self:remove_item(blueprint.color.global_value, "colors", blueprint.color.id)
		self:alter_global_value_item(blueprint.color.global_value, "colors", slot, blueprint.color.id, INV_TO_CRAFT)
		self:remove_item(blueprint.pattern.global_value, "textures", blueprint.pattern.id)
		self:alter_global_value_item(blueprint.pattern.global_value, "textures", slot, blueprint.pattern.id, INV_TO_CRAFT)
	else
		blueprint.color = {id = "nothing", global_value = "normal"}
	end
	if Idstring(blueprint.pattern.id) ~= Idstring("solidfirst") and Idstring(blueprint.pattern.id) ~= Idstring("solidsecond") then
		self:remove_item(blueprint.material.global_value, "materials", blueprint.material.id)
		self:alter_global_value_item(blueprint.material.global_value, "materials", slot, blueprint.material.id, INV_TO_CRAFT)
	else
		blueprint.material = {id = "plastic", global_value = "normal"}
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
	local blueprint = {}
	blueprint.color = {id = "nothing", global_value = "normal"}
	blueprint.pattern = {
		id = "no_color_no_material",
		global_value = "normal"
	}
	blueprint.material = {id = "plastic", global_value = "normal"}
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
	managers.money:on_sell_mask(mask_id, global_value, blueprint)
	self:remove_item(global_value, "masks", mask_id)
	self:alter_global_value_item(global_value, "masks", nil, mask_id, INV_REMOVE)
end

function BlackMarketManager:on_sell_mask(slot)
	local category = "masks"
	if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot] then
		return
	end
	local mask = self._global.crafted_items[category][slot]
	managers.money:on_sell_mask(mask.mask_id, mask.global_value, mask.blueprint)
	if slot == self:equipped_mask_slot() then
		self:equip_mask(1)
	end
	local blueprint = mask.blueprint or {}
	for category, part in pairs(blueprint) do
		local converted_category = category == "color" and "colors" or category == "material" and "materials" or category == "pattern" and "textures" or category
		Application:debug(part.global_value, converted_category, slot, part.id, CRAFT_REMOVE)
		self:alter_global_value_item(part.global_value, converted_category, slot, part.id, CRAFT_REMOVE)
	end
	self:alter_global_value_item(mask.global_value, category, slot, mask.mask_id, CRAFT_REMOVE)
	self._global.crafted_items[category][slot] = nil
	self:_verfify_equipped_category(category)
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

function BlackMarketManager:mask_unit_name_by_mask_id(mask_id, peer_id)
	if mask_id ~= "character_locked" then
		return tweak_data.blackmarket.masks[mask_id].unit
	end
	local character = self:get_preferred_character()
	if managers.network and managers.network:session() and peer_id then
		print("HERE", managers.network:session(), peer_id)
		character = managers.network:session():peer(peer_id):character()
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	return tweak_data.blackmarket.masks[mask_id][character]
end

function BlackMarketManager:character_sequence_by_character_id(character_id, peer_id)
	if character_id ~= "locked" then
		return tweak_data.blackmarket.characters[character_id].sequence
	end
	local character = self:get_preferred_character()
	if managers.network and managers.network:session() and peer_id then
		print("character_sequence_by_character_id", managers.network:session(), peer_id, character)
		local peer = managers.network:session():peer(peer_id)
		if peer then
			character = peer:character()
		end
	end
	character = CriminalsManager.convert_old_to_new_character_workname(character)
	print("character_sequence_by_character_id", "character", character, "character_id", character_id)
	return tweak_data.blackmarket.characters[character_id][character].sequence
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
	self:_setup_track_global_values()
	self:aquire_default_weapons()
	self:aquire_default_masks()
	self:_verfify_equipped()
	if managers.menu_scene then
		managers.menu_scene:on_blackmarket_reset()
	end
end

function BlackMarketManager:save(data)
	local save_data = deep_clone(self._global)
	save_data.equipped_armor = self:equipped_armor()
	save_data.armors = nil
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
		self._global.armors[self._global.equipped_armor or self._defaults.armor].equipped = true
		self._global.equipped_armor = nil
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
		self._global._preferred_character = self._global._preferred_character or self._defaults.preferred_character
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
		self._global.new_drops = self._global.new_drops or {}
		self._global.new_item_type_unlocked = self._global.new_item_type_unlocked or {}
		if not self._global.global_value_items then
			self:_setup_track_global_values()
		end
	end
end

function BlackMarketManager:_load_done()
	Application:debug("BlackMarketManager:_load_done()")
	self:aquire_default_weapons()
	self:aquire_default_masks()
	self:_verfify_equipped()
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
		local secondary = self:equipped_secondary()
		if secondary then
			managers.menu_scene:set_character_equipped_weapon(nil, secondary.factory_id, secondary.blueprint, "secondary")
		end
		local primary = self:equipped_primary()
		if primary then
			managers.menu_scene:set_character_equipped_weapon(nil, primary.factory_id, primary.blueprint, "primary")
		end
	end
end

function BlackMarketManager:verify_dlc_items()
	self:_verify_dlc_items()
end

function BlackMarketManager:_verify_dlc_items()
	Application:debug("-----------------------BlackMarketManager:_verify_dlc_items-----------------------")
	local owns_dlc
	for package_id, data in pairs(tweak_data.dlc) do
		if tweak_data.lootdrop.global_values[package_id] then
			owns_dlc = tweak_data.lootdrop.global_values[package_id].dlc and (data.free or managers.dlc:has_dlc(package_id))
			print(owns_dlc, tweak_data.lootdrop.global_values[package_id].dlc, not data.free, not managers.dlc:has_dlc(package_id))
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
								self:buy_and_modify_weapon("primaries", slot, "normal", default_mod, true)
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
								self:buy_and_modify_weapon("secondaries", slot, "normal", default_mod, true)
							else
								self:remove_weapon_part("secondaries", slot, package_id, part_id)
							end
							managers.money:refund_weapon_part(crafted.weapon_id, part_id, package_id)
						end
					end
				end
				local mask = managers.blackmarket:equipped_mask()
				local is_locked = mask.global_value == package_id
				if not is_locked then
					for _, part in pairs(mask.blueprint) do
						print(package_id, inspect(part))
						is_locked = part.global_value == package_id
						if is_locked then
							break
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

function BlackMarketManager:_verfify_equipped()
	self:_verfify_equipped_category("secondaries")
	self:_verfify_equipped_category("primaries")
	self:_verfify_equipped_category("masks")
	self:_verfify_equipped_category("armors")
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
