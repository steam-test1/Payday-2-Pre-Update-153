local ids_unit = Idstring("unit")
WeaponFactoryManager = WeaponFactoryManager or class()

function WeaponFactoryManager:init()
	self:_setup()
	self._tasks = {}
	self._uses_tasks = true
end

function WeaponFactoryManager:_setup()
	if not Global.weapon_factory then
		Global.weapon_factory = {}
	end
	self._global = Global.weapon_factory
	Global.weapon_factory.loaded_packages = Global.weapon_factory.loaded_packages or {}
	self._loaded_packages = Global.weapon_factory.loaded_packages
	self:_read_factory_data()
end

function WeaponFactoryManager:update(t, dt)
	if self._active_task then
		if self:_update_task(self._active_task) then
			self._active_task = nil
			self:_check_task()
		end
	elseif next(self._tasks) then
		self:_check_task()
	end
end

function WeaponFactoryManager:_read_factory_data()
	self._parts_by_type = {}
	for id, data in pairs(tweak_data.weapon.factory.parts) do
		self._parts_by_type[data.type] = self._parts_by_type[data.type] or {}
		self._parts_by_type[data.type][id] = true
	end
	self._parts_by_weapon = {}
	self._part_used_by_weapons = {}
	for factory_id, data in pairs(tweak_data.weapon.factory) do
		if factory_id ~= "parts" then
			self._parts_by_weapon[factory_id] = self._parts_by_weapon[factory_id] or {}
			for _, part_id in ipairs(data.uses_parts) do
				local type = tweak_data.weapon.factory.parts[part_id].type
				self._parts_by_weapon[factory_id][type] = self._parts_by_weapon[factory_id][type] or {}
				table.insert(self._parts_by_weapon[factory_id][type], part_id)
				if not string.match(factory_id, "_npc") then
					self._part_used_by_weapons[part_id] = self._part_used_by_weapons[part_id] or {}
					table.insert(self._part_used_by_weapons[part_id], factory_id)
				end
			end
		end
	end
end

function WeaponFactoryManager:get_weapons_uses_part(part_id)
	return self._part_used_by_weapons[part_id]
end

function WeaponFactoryManager:get_weapon_id_by_factory_id(factory_id)
	local upgrade = managers.upgrades:weapon_upgrade_by_factory_id(factory_id)
	if not upgrade then
		Application:error("[WeaponFactoryManager:get_weapon_id_by_factory_id] Found no upgrade for factory id", factory_id)
		return
	end
	return upgrade.weapon_id
end

function WeaponFactoryManager:get_weapon_name_by_factory_id(factory_id)
	local upgrade = managers.upgrades:weapon_upgrade_by_factory_id(factory_id)
	if not upgrade then
		Application:error("[WeaponFactoryManager:get_weapon_name_by_factory_id] Found no upgrade for factory id", factory_id)
		return
	end
	local weapon_id = upgrade.weapon_id
	return managers.localization:text(tweak_data.weapon[weapon_id].name_id)
end

function WeaponFactoryManager:get_factory_id_by_weapon_id(weapon_id)
	local upgrade = managers.upgrades:weapon_upgrade_by_weapon_id(weapon_id)
	if not upgrade then
		Application:error("[WeaponFactoryManager:get_factory_id_by_weapon_id] Found no upgrade for factory id", weapon_id)
		return
	end
	return upgrade.factory_id
end

function WeaponFactoryManager:get_default_blueprint_by_factory_id(factory_id)
	return tweak_data.weapon.factory[factory_id].default_blueprint
end

function WeaponFactoryManager:create_limited_blueprints(factory_id)
	local i_table = self:_indexed_parts(factory_id)
	local all_parts_used_once = {}
	for j = 1, #i_table do
		for k = j == 1 and 1 or 2, #i_table[j].parts do
			local perm = {}
			local part = i_table[j].parts[k]
			if part ~= "" then
				table.insert(perm, i_table[j].parts[k])
			end
			for l = 1, #i_table do
				if j ~= l then
					local part = i_table[l].parts[1]
					if part ~= "" then
						table.insert(perm, i_table[l].parts[1])
					end
				end
			end
			table.insert(all_parts_used_once, perm)
		end
	end
	print("Limited", #all_parts_used_once)
	return all_parts_used_once
end

function WeaponFactoryManager:create_blueprints(factory_id)
	local i_table = self:_indexed_parts(factory_id)
	
	local function dump(i_category, result, new_combination_in)
		for i_pryl, pryl_name in ipairs(i_table[i_category].parts) do
			local new_combination = clone(new_combination_in)
			if pryl_name ~= "" then
				table.insert(new_combination, pryl_name)
			end
			if i_category == #i_table then
				table.insert(result, new_combination)
			else
				dump(i_category + 1, result, new_combination)
			end
		end
	end
	
	local result = {}
	dump(1, result, {})
	print("Combinations", #result)
	return result
end

function WeaponFactoryManager:_indexed_parts(factory_id)
	local i_table = {}
	local all_parts = self._parts_by_weapon[factory_id]
	local optional_types = tweak_data.weapon.factory[factory_id].optional_types or {}
	local num_variations = 1
	local tot_parts = 0
	for type, parts in pairs(all_parts) do
		print(type, parts)
		if type ~= "foregrip_ext" and type ~= "stock_adapter" and type ~= "sight_special" and type ~= "extra" then
			parts = clone(parts)
			if table.contains(optional_types, type) then
				table.insert(parts, "")
			end
			table.insert(i_table, {
				parts = parts,
				i = 1,
				amount = #parts
			})
			num_variations = num_variations * #parts
			tot_parts = tot_parts + #parts
		end
	end
	print("num_variations", num_variations, "tot_parts", tot_parts)
	return i_table
end

function WeaponFactoryManager:_check_task()
	if not self._active_task and #self._tasks > 0 then
		self._active_task = table.remove(self._tasks, 1)
		if not alive(self._active_task.p_unit) then
			self._active_task = nil
			self:_check_task()
		end
	end
end

function WeaponFactoryManager:preload_blueprint(factory_id, blueprint, third_person, done_cb, only_record)
	return self:_preload_blueprint(factory_id, blueprint, third_person, done_cb, only_record)
end

function WeaponFactoryManager:_preload_blueprint(factory_id, blueprint, third_person, done_cb, only_record)
	if not done_cb then
		Application:error("[WeaponFactoryManager] _preload_blueprint(): No done_cb!", "factory_id: " .. factory_id, "blueprint: " .. inspect(blueprint))
		Application:stack_dump()
	end
	local factory = tweak_data.weapon.factory
	local factory_weapon = factory[factory_id]
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	return self:_preload_parts(factory_id, factory_weapon, blueprint, forbidden, third_person, done_cb, only_record)
end

function WeaponFactoryManager:_preload_parts(factory_id, factory_weapon, blueprint, forbidden, third_person, done_cb, only_record)
	self._tasks = self._tasks or {}
	local parts = {}
	local need_parent = {}
	local override = self:_get_override_parts(factory_id, blueprint)
	for _, part_id in ipairs(blueprint) do
		self:_preload_part(factory_id, part_id, forbidden, override, parts, third_person, need_parent, only_record)
	end
	for _, part_id in ipairs(need_parent) do
		self:_preload_part(factory_id, part_id, forbidden, override, parts, third_person, need_parent, only_record)
	end
	done_cb(parts, blueprint)
	return parts, blueprint
end

function WeaponFactoryManager:_preload_part(factory_id, part_id, forbidden, override, parts, third_person, need_parent, only_record)
	if forbidden[part_id] then
		return
	end
	local factory = tweak_data.weapon.factory
	local part = self:_part_data(part_id, factory_id, override)
	if factory[factory_id].adds and factory[factory_id].adds[part_id] then
		for _, add_id in ipairs(factory[factory_id].adds[part_id]) do
			self:_preload_part(factory_id, add_id, forbidden, override, parts, third_person, need_parent, only_record)
		end
	end
	if part.adds_type then
		for _, add_type in ipairs(part.adds_type) do
			local add_id = factory[factory_id][add_type]
			self:_preload_part(factory_id, add_id, forbidden, override, parts, third_person, need_parent, only_record)
		end
	end
	if part.adds then
		for _, add_id in ipairs(part.adds) do
			self:_preload_part(factory_id, add_id, forbidden, override, parts, third_person, need_parent, only_record)
		end
	end
	if parts[part_id] then
		return
	end
	if part.parent and not self:get_part_from_weapon_by_type(part.parent, parts) then
		table.insert(need_parent, part_id)
		return
	end
	local unit_name = third_person and part.third_unit or part.unit
	local ids_unit_name = Idstring(unit_name)
	local package
	if not third_person then
		package = "packages/fps_weapon_parts/" .. part_id
		if DB:has(Idstring("package"), Idstring(package)) then
			parts[part_id] = {package = package}
			if not only_record then
				self:load_package(parts[part_id].package)
			end
		else
			Application:error("Expected weapon part packages for", part_id)
			package = nil
		end
	end
	if not package then
		parts[part_id] = {
			ids_unit,
			ids_unit_name,
			"packages/dyn_resources",
			false
		}
		if not only_record then
			managers.dyn_resource:load(unpack(parts[part_id]))
		end
	end
end

function WeaponFactoryManager:assemble_default(factory_id, p_unit, third_person, done_cb, skip_queue)
	local blueprint = clone(tweak_data.weapon.factory[factory_id].default_blueprint)
	return self:_assemble(factory_id, p_unit, blueprint, third_person, done_cb, skip_queue), blueprint
end

function WeaponFactoryManager:assemble_from_blueprint(factory_id, p_unit, blueprint, third_person, done_cb, skip_queue)
	return self:_assemble(factory_id, p_unit, blueprint, third_person, done_cb, skip_queue)
end

function WeaponFactoryManager:_assemble(factory_id, p_unit, blueprint, third_person, done_cb, skip_queue)
	if not done_cb then
		Application:error("-----------------------------")
		Application:stack_dump()
	end
	local factory = tweak_data.weapon.factory
	local factory_weapon = factory[factory_id]
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	return self:_add_parts(p_unit, factory_id, factory_weapon, blueprint, forbidden, third_person, done_cb, skip_queue)
end

function WeaponFactoryManager:_get_forbidden_parts(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local forbidden = {}
	for _, part_id in ipairs(blueprint) do
		local part = self:_part_data(part_id, factory_id)
		if part.forbids then
			for _, forbidden_id in ipairs(part.forbids) do
				forbidden[forbidden_id] = true
			end
		end
	end
	return forbidden
end

function WeaponFactoryManager:_get_override_parts(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local overridden = {}
	for _, part_id in ipairs(blueprint) do
		local part = self:_part_data(part_id, factory_id)
		if part.override then
			for override_id, override_data in pairs(part.override) do
				overridden[override_id] = override_data
			end
		end
	end
	return overridden
end

function WeaponFactoryManager:_update_task(task)
	if not alive(task.p_unit) then
		return true
	end
	if task.blueprint_i <= #task.blueprint then
		local part_id = task.blueprint[task.blueprint_i]
		self:_add_part(task.p_unit, task.factory_id, part_id, task.forbidden, task.override, task.parts, task.third_person, task.need_parent)
		task.blueprint_i = task.blueprint_i + 1
		return
	end
	if task.need_parent_i <= #task.need_parent then
		local part_id = task.need_parent[task.need_parent_i]
		self:_add_part(task.p_unit, task.factory_id, part_id, task.forbidden, task.override, task.parts, task.third_person, task.need_parent)
		task.need_parent_i = task.need_parent_i + 1
		return
	end
	print("WeaponFactoryManager:_update_task done")
	task.done_cb(task.parts, task.blueprint)
	return true
end

function WeaponFactoryManager:_add_parts(p_unit, factory_id, factory_weapon, blueprint, forbidden, third_person, done_cb, skip_queue)
	self._tasks = self._tasks or {}
	local parts = {}
	local need_parent = {}
	local override = self:_get_override_parts(factory_id, blueprint)
	if self._uses_tasks and not skip_queue then
		table.insert(self._tasks, {
			done_cb = done_cb,
			p_unit = p_unit,
			factory_id = factory_id,
			blueprint = blueprint,
			blueprint_i = 1,
			forbidden = forbidden,
			third_person = third_person,
			parts = parts,
			need_parent = need_parent,
			need_parent_i = 1,
			override = override
		})
	else
		for _, part_id in ipairs(blueprint) do
			self:_add_part(p_unit, factory_id, part_id, forbidden, override, parts, third_person, need_parent)
		end
		for _, part_id in ipairs(need_parent) do
			self:_add_part(p_unit, factory_id, part_id, forbidden, override, parts, third_person, need_parent)
		end
		done_cb(parts, blueprint)
	end
	return parts, blueprint
end

function WeaponFactoryManager:_part_data(part_id, factory_id, override)
	local factory = tweak_data.weapon.factory
	local part = deep_clone(factory.parts[part_id])
	if factory[factory_id].override and factory[factory_id].override[part_id] then
		for d, v in pairs(factory[factory_id].override[part_id]) do
			part[d] = v
		end
	end
	if override and override[part_id] then
		for d, v in pairs(override[part_id]) do
			part[d] = v
		end
	end
	return part
end

function WeaponFactoryManager:_add_part(p_unit, factory_id, part_id, forbidden, override, parts, third_person, need_parent)
	if forbidden[part_id] then
		return
	end
	local factory = tweak_data.weapon.factory
	local part = self:_part_data(part_id, factory_id, override)
	if factory[factory_id].adds and factory[factory_id].adds[part_id] then
		for _, add_id in ipairs(factory[factory_id].adds[part_id]) do
			self:_add_part(p_unit, factory_id, add_id, forbidden, override, parts, third_person, need_parent)
		end
	end
	if part.adds_type then
		for _, add_type in ipairs(part.adds_type) do
			local add_id = factory[factory_id][add_type]
			self:_add_part(p_unit, factory_id, add_id, forbidden, override, parts, third_person, need_parent)
		end
	end
	if part.adds then
		for _, add_id in ipairs(part.adds) do
			self:_add_part(p_unit, factory_id, add_id, forbidden, override, parts, third_person, need_parent)
		end
	end
	if parts[part_id] then
		return
	end
	local link_to_unit = p_unit
	if part.parent then
		local parent_part = self:get_part_from_weapon_by_type(part.parent, parts)
		if parent_part then
			link_to_unit = parent_part.unit
		else
			table.insert(need_parent, part_id)
			return
		end
	end
	local unit_name = third_person and part.third_unit or part.unit
	local ids_unit_name = Idstring(unit_name)
	local package
	if not third_person then
		package = "packages/fps_weapon_parts/" .. part_id
		if DB:has(Idstring("package"), Idstring(package)) then
			print("HAS PART AS PACKAGE")
			self:load_package(package)
		else
			Application:error("Expected weapon part packages for", part_id)
			package = nil
		end
	end
	if not package then
		managers.dyn_resource:load(ids_unit, ids_unit_name, "packages/dyn_resources", false)
	end
	local u_name = Idstring(unit_name)
	local unit = World:spawn_unit(u_name, Vector3(), Rotation())
	local res = link_to_unit:link(Idstring(part.a_obj), unit, unit:orientation_object():name())
	if managers.occlusion and not third_person then
		managers.occlusion:remove_occlusion(unit)
	end
	parts[part_id] = {
		unit = unit,
		animations = part.animations,
		name = u_name,
		package = package
	}
end

function WeaponFactoryManager:load_package(package)
	print("WeaponFactoryManager:_load_package", package)
	if not self._loaded_packages[package] then
		print("  Load for real", package)
		PackageManager:load(package)
		self._loaded_packages[package] = 1
	else
		self._loaded_packages[package] = self._loaded_packages[package] + 1
	end
end

function WeaponFactoryManager:unload_package(package)
	print("WeaponFactoryManager:_unload_package", package)
	if not self._loaded_packages[package] then
		Application:error("Trying to unload package that wasn't loaded")
		return
	end
	self._loaded_packages[package] = self._loaded_packages[package] - 1
	if self._loaded_packages[package] <= 0 then
		print("  Unload for real", package)
		PackageManager:unload(package)
		self._loaded_packages[package] = nil
	end
end

function WeaponFactoryManager:get_part_from_weapon_by_type(type, parts)
	local factory = tweak_data.weapon.factory
	for id, data in pairs(parts) do
		if factory.parts[id].type == type then
			return parts[id]
		end
	end
	return false
end

function WeaponFactoryManager:get_parts_from_factory_id(factory_id)
	return self._parts_by_weapon[factory_id]
end

function WeaponFactoryManager:get_parts_from_weapon_id(weapon_id)
	local factory_id = self:get_factory_id_by_weapon_id(weapon_id)
	return self._parts_by_weapon[factory_id]
end

function WeaponFactoryManager:get_part_name_by_part_id(part_id)
	local part_tweak_data = tweak_data.weapon.factory.parts[part_id]
	if not part_tweak_data then
		Application:error("[WeaponFactoryManager:get_part_name_by_part_id] Found no part with part id", part_id)
		return
	end
	return managers.localization:text(part_tweak_data.name_id)
end

function WeaponFactoryManager:change_part(p_unit, factory_id, part_id, parts, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:change_part Part", part_id, "doesn't exist!")
		return parts
	end
	local type = part.type
	if self._parts_by_weapon[factory_id][type] then
		if table.contains(self._parts_by_weapon[factory_id][type], part_id) then
			for rem_id, rem_data in pairs(parts) do
				if factory.parts[rem_id].type == type then
					table.delete(blueprint, rem_id)
					break
				end
			end
			table.insert(blueprint, part_id)
			self:disassemble(parts)
			return self:assemble_from_blueprint(factory_id, p_unit, blueprint)
		else
			Application:error("WeaponFactoryManager:change_part Part", part_id, "not allowed for weapon", factory_id, "!")
		end
	else
		Application:error("WeaponFactoryManager:change_part Part", part_id, "not allowed for weapon", factory_id, "!")
	end
	return parts
end

function WeaponFactoryManager:remove_part_from_blueprint(part_id, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:remove_part_from_blueprint Part", part_id, "doesn't exist!")
		return
	end
	table.delete(blueprint, part_id)
end

function WeaponFactoryManager:change_part_blueprint_only(factory_id, part_id, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:change_part Part", part_id, " doesn't exist!")
		return false
	end
	local type = part.type
	if self._parts_by_weapon[factory_id][type] then
		if table.contains(self._parts_by_weapon[factory_id][type], part_id) then
			for _, rem_id in ipairs(blueprint) do
				if factory.parts[rem_id].type == type then
					table.delete(blueprint, rem_id)
					break
				end
			end
			table.insert(blueprint, part_id)
			local forbidden = WeaponFactoryManager:_get_forbidden_parts(factory_id, blueprint) or {}
			for _, rem_id in ipairs(blueprint) do
				if forbidden[rem_id] then
					table.delete(blueprint, rem_id)
				end
			end
			return true
		else
			Application:error("WeaponFactoryManager:change_part Part", part_id, "not allowed for weapon", factory_id, "!")
		end
	else
		Application:error("WeaponFactoryManager:change_part Part", part_id, "not allowed for weapon", factory_id, "!")
	end
	return false
end

function WeaponFactoryManager:get_replaces_parts(factory_id, part_id, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:change_part Part", part_id, " doesn't exist!")
		return nil
	end
	local replaces = {}
	local type = part.type
	if self._parts_by_weapon[factory_id][type] then
		if table.contains(self._parts_by_weapon[factory_id][type], part_id) then
			for _, rep_id in ipairs(blueprint) do
				if factory.parts[rep_id].type == type then
					table.insert(replaces, rep_id)
					break
				end
			end
		else
			Application:error("WeaponFactoryManager:check_replaces_part Part", part_id, "not allowed for weapon", factory_id, "!")
		end
	else
		Application:error("WeaponFactoryManager:check_replaces_part Part", part_id, "not allowed for weapon", factory_id, "!")
	end
	return replaces
end

function WeaponFactoryManager:get_removes_parts(factory_id, part_id, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:get_removes_parts Part", part_id, " doesn't exist!")
		return nil
	end
	local removes = {}
	for _, b_id in ipairs(blueprint) do
		if part.forbids and table.contains(part.forbids, b_id) then
			table.insert(removes, b_id)
		end
	end
	return removes
end

function WeaponFactoryManager:can_add_part(factory_id, part_id, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:can_add_part Part", part_id, " doesn't exist!")
		return nil
	end
	local forbids = {}
	for _, b_id in ipairs(blueprint) do
		local part = factory.parts[b_id]
		if part.forbids and table.contains(part.forbids, part_id) then
			table.insert(forbids, b_id)
		end
	end
	return forbids
end

function WeaponFactoryManager:remove_part(p_unit, factory_id, part_id, parts, blueprint)
	local factory = tweak_data.weapon.factory
	local part = factory.parts[part_id]
	if not part then
		Application:error("WeaponFactoryManager:remove_part Part", part_id, "doesn't exist!")
		return parts
	end
	table.delete(blueprint, part_id)
	self:disassemble(parts)
	return self:assemble_from_blueprint(factory_id, p_unit, blueprint)
end

function WeaponFactoryManager:remove_part_by_type(p_unit, factory_id, type, parts, blueprint)
	local factory = tweak_data.weapon.factory
	for part_id, part_data in pairs(parts) do
		if factory.parts[part_id].type == type then
			table.delete(blueprint, part_id)
			break
		end
	end
	self:disassemble(parts)
	return self:assemble_from_blueprint(factory_id, p_unit, blueprint)
end

function WeaponFactoryManager:change_blueprint(p_unit, factory_id, parts, blueprint)
	self:disassemble(parts)
	return self:assemble_from_blueprint(factory_id, p_unit, blueprint)
end

function WeaponFactoryManager:blueprint_to_string(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local index_table = {}
	for i, part_id in ipairs(factory[factory_id].uses_parts) do
		index_table[part_id] = i
	end
	local s = ""
	for _, part_id in ipairs(blueprint) do
		s = s .. index_table[part_id] .. " "
	end
	return s
end

function WeaponFactoryManager:unpack_blueprint_from_string(factory_id, blueprint_string)
	local factory = tweak_data.weapon.factory
	local index_table = string.split(blueprint_string, " ")
	local blueprint = {}
	for _, part_index in ipairs(index_table) do
		table.insert(blueprint, factory[factory_id].uses_parts[tonumber(part_index)])
	end
	return blueprint
end

function WeaponFactoryManager:get_stats(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	local override = self:_get_override_parts(factory_id, blueprint)
	local stats = {}
	for _, part_id in ipairs(blueprint) do
		if not forbidden[part_id] and factory.parts[part_id].stats then
			local part = self:_part_data(part_id, factory_id)
			for stat_type, value in pairs(part.stats) do
				stats[stat_type] = stats[stat_type] or 0
				stats[stat_type] = stats[stat_type] + value
			end
		end
	end
	return stats
end

function WeaponFactoryManager:has_perk(perk_name, factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	for _, part_id in ipairs(blueprint) do
		if not forbidden[part_id] and factory.parts[part_id].perks then
			for _, perk in ipairs(factory.parts[part_id].perks) do
				if perk == perk_name then
					return true
				end
			end
		end
	end
	return false
end

function WeaponFactoryManager:get_perks_from_part_id(part_id)
	local factory = tweak_data.weapon.factory
	if not factory.parts[part_id] then
		return {}
	end
	local perks = {}
	if factory.parts[part_id].perks then
		for _, perk in ipairs(factory.parts[part_id].perks) do
			perks[perk] = true
		end
	end
	return perks
end

function WeaponFactoryManager:get_perks(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	local perks = {}
	for _, part_id in ipairs(blueprint) do
		if not forbidden[part_id] and factory.parts[part_id].perks then
			for _, perk in ipairs(factory.parts[part_id].perks) do
				perks[perk] = true
			end
		end
	end
	return perks
end

function WeaponFactoryManager:get_sound_switch(switch_group, factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	for _, part_id in ipairs(blueprint) do
		if not forbidden[part_id] and factory.parts[part_id].sound_switch and factory.parts[part_id].sound_switch[switch_group] then
			return factory.parts[part_id].sound_switch[switch_group]
		end
	end
	return nil
end

function WeaponFactoryManager:disassemble(parts)
	local names = {}
	if parts then
		for part_id, data in pairs(parts) do
			if data.package then
				self:unload_package(data.package)
			else
				table.insert(names, data.name)
			end
			if alive(data.unit) then
				World:delete_unit(data.unit)
			end
		end
	end
	parts = {}
	for _, name in pairs(names) do
		managers.dyn_resource:unload(Idstring("unit"), name, "packages/dyn_resources", false)
	end
end

function WeaponFactoryManager:save(data)
	data.weapon_factory = self._global
end

function WeaponFactoryManager:load(data)
	self._global = data.weapon_factory
end

function WeaponFactoryManager:debug_get_stats(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local forbidden = self:_get_forbidden_parts(factory_id, blueprint)
	local stats = {}
	for _, part_id in ipairs(blueprint) do
		if not forbidden[part_id] then
			stats[part_id] = factory.parts[part_id].stats
		end
	end
	return stats
end
