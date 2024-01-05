DynamicResourceManager = DynamicResourceManager or class()
DynamicResourceManager.DYN_RESOURCES_PACKAGE = "packages/dyn_resources"

function DynamicResourceManager:init()
	self._dyn_resources = Global.dyn_resource_manager_data or {}
	Global.dyn_resource_manager_data = self._dyn_resources
	self._to_unload = nil
end

function DynamicResourceManager:update()
	if self._to_unload then
		for _, unload_params in ipairs(self._to_unload) do
			PackageManager:package(unload_params.package_name):unload_resource(unload_params.resource_type, unload_params.resource_name, unload_params.keep_using)
		end
		self._to_unload = nil
	end
end

function DynamicResourceManager:is_ready_to_close()
	return not self._to_unload
end

function DynamicResourceManager:load(resource_type, resource_name, package_name, complete_clbk)
	local resource_type_key = resource_type:key()
	local resource_name_key = resource_name:key()
	for _package_name, resource_types in pairs(self._dyn_resources) do
		if _package_name ~= package_name and resource_types[resource_type_key] then
			for _resource_name, ref_count in pairs(resource_types[resource_type_key]) do
				if _resource_name == resource_name_key then
					debug_pause("[DynamicResourceManager:load] resource ", resource_name .. "." .. resource_type, "already loaded in", _package_name)
					return
				end
			end
		end
	end
	self._dyn_resources[package_name] = self._dyn_resources[package_name] or {}
	self._dyn_resources[package_name][resource_type_key] = self._dyn_resources[package_name][resource_type_key] or {}
	local ref_count = 1 + (self._dyn_resources[package_name][resource_type_key][resource_name_key] or 0)
	self._dyn_resources[package_name][resource_type_key][resource_name_key] = ref_count
	if ref_count == 1 then
		local needs_loading = true
		if self._to_unload then
			for i, unload_params in ipairs(self._to_unload) do
				if unload_params.package_name == package_name and unload_params.resource_type == resource_type and unload_params.resource_name == resource_name then
					needs_loading = false
					table.remove(self._to_unload, i)
					if not next(self._to_unload) then
						self._to_unload = nil
					end
					break
				end
			end
		end
		if needs_loading then
			PackageManager:package(package_name):load_temp_resource(resource_type, resource_name, complete_clbk)
		end
	end
end

function DynamicResourceManager:unload(resource_type, resource_name, package_name, keep_using)
	local resource_type_key = resource_type:key()
	local resource_name_key = resource_name:key()
	if not self._dyn_resources[package_name] then
		debug_pause("[DynamicResourceManager:unload]", resource_type, resource_name, package_name, [[
.
package has no dynamic resources]])
		return
	end
	if not self._dyn_resources[package_name][resource_type_key] then
		debug_pause("[DynamicResourceManager:unload]", resource_type, resource_name, package_name, [[
.
 no dynamic resources of this type]])
		return
	end
	if not self._dyn_resources[package_name][resource_type_key][resource_name_key] then
		debug_pause("[DynamicResourceManager:unload]", resource_type, resource_name, package_name, [[
.
 no dynamic resources of this name]])
		return
	end
	local ref_count = self._dyn_resources[package_name][resource_type_key][resource_name_key] - 1
	if ref_count == 0 then
		self._dyn_resources[package_name][resource_type_key][resource_name_key] = nil
		if not next(self._dyn_resources[package_name][resource_type_key]) then
			self._dyn_resources[package_name][resource_type_key] = nil
			if not next(self._dyn_resources[package_name]) then
				self._dyn_resources[package_name] = nil
			end
		end
		self._to_unload = self._to_unload or {}
		table.insert(self._to_unload, {
			package_name = package_name,
			resource_type = resource_type,
			resource_name = resource_name,
			keep_using = keep_using
		})
	else
		self._dyn_resources[package_name][resource_type_key][resource_name_key] = ref_count
	end
end

function DynamicResourceManager:has_resource(resource_type, resource_name, package_name)
	local resource_type_key = resource_type:key()
	local resource_name_key = resource_name:key()
	return self._dyn_resources[package_name] and self._dyn_resources[package_name][resource_type_key] and self._dyn_resources[package_name][resource_type_key][resource_name_key] and true or false
end
