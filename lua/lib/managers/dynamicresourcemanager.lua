DynamicResourceManager = DynamicResourceManager or class()
DynamicResourceManager.DYN_RESOURCES_PACKAGE = "packages/dyn_resources"
DynamicResourceManager.listener_events = {file_streamer_workload = 1}

function DynamicResourceManager:init()
	self._dyn_resources = Global.dyn_resource_manager_data or {}
	Global.dyn_resource_manager_data = self._dyn_resources
	self._to_unload = nil
	self._temp_resource_requests = {}
	self._listener_holder = EventListenerHolder:new()
	self._max_streaming_chunk_kb = 256
	self:set_file_streaming_settings(self._max_streaming_chunk_kb, 3)
end

function DynamicResourceManager:update()
	if self._to_unload then
		for _, unload_params in ipairs(self._to_unload) do
			PackageManager:package(unload_params.package_name):unload_resource(unload_params.resource_type, unload_params.resource_name, unload_params.keep_using)
		end
		self._to_unload = nil
	end
	if self._listener_holder:has_listeners_for_event(self.listener_events.file_streamer_workload) then
		self:_check_file_streamer_status()
	end
end

function DynamicResourceManager:is_ready_to_close()
	if self._to_unload then
		print("[DynamicResourceManager:is_ready_to_close] still unloading")
		return false
	end
	local filestreamer_workload = Application:file_streamer_workload()
	if 0 < filestreamer_workload then
		print("[DynamicResourceManager:is_ready_to_close] filestreamer_workload", filestreamer_workload)
		return false
	end
	return true
end

function DynamicResourceManager._get_resource_key(resource_type, resource_name, package_name)
	return package_name .. resource_name:key() .. resource_type:key()
end

function DynamicResourceManager:load(resource_type, resource_name, package_name, complete_clbk)
	local key = self._get_resource_key(resource_type, resource_name, package_name)
	local entry = self._temp_resource_requests[key]
	if not entry then
		entry = {ref_c = 0}
		self._temp_resource_requests[key] = entry
	end
	entry.ref_c = entry.ref_c + 1
	if complete_clbk then
		entry.callbacks = entry.callbacks or {}
		table.insert(entry.callbacks, complete_clbk)
	end
	PackageManager:package(package_name):load_temp_resource(resource_type, resource_name, complete_clbk and callback(self, self, "clbk_resource_loaded") or nil)
end

function DynamicResourceManager:unload(resource_type, resource_name, package_name, keep_using)
	local key = self._get_resource_key(resource_type, resource_name, package_name)
	local entry = self._temp_resource_requests[key]
	if entry.ref_c == 1 then
		self._temp_resource_requests[key] = nil
	else
		entry.ref_c = entry.ref_c - 1
	end
	self._to_unload = self._to_unload or {}
	table.insert(self._to_unload, {
		package_name = package_name,
		resource_type = resource_type,
		resource_name = resource_name,
		keep_using = keep_using
	})
end

function DynamicResourceManager:has_resource(resource_type, resource_name, package_name)
	local key = self._get_resource_key(resource_type, resource_name, package_name)
	return self._temp_resource_requests[key] and true or false
end

function DynamicResourceManager:clbk_resource_loaded(status, resource_type, resource_name, package_name)
	local key = self._get_resource_key(resource_type, resource_name, package_name)
	local entry = self._temp_resource_requests[key]
	local callbacks = entry.callbacks
	entry.callbacks = nil
	for _, clbk in ipairs(callbacks) do
		clbk(status, resource_type, resource_name)
	end
end

function DynamicResourceManager:change_material_config(name, unit)
	unit:set_material_config(name, true, callback(self, self, "on_material_applied", unit))
end

function DynamicResourceManager:on_material_applied(unit)
	if alive(unit) then
		if unit:interaction() then
			unit:interaction():refresh_material()
		end
		if unit:contour() then
			unit:contour():update_materials()
		end
	end
end

function DynamicResourceManager:_check_file_streamer_status()
	local nr_tasks = Application:file_streamer_workload()
	self._listener_holder:call(self.listener_events.file_streamer_workload, nr_tasks)
end

function DynamicResourceManager:is_file_streamer_idle()
	local nr_tasks = Application:file_streamer_workload()
	return nr_tasks == 0
end

function DynamicResourceManager:set_file_streaming_settings(chunk_size_kb, sleep_time)
	chunk_size_kb = math.min(chunk_size_kb, self._max_streaming_chunk_kb)
	Application:set_file_streamer_settings(chunk_size_kb * 1024, sleep_time)
end

function DynamicResourceManager:add_listener(key, events, clbk)
	self._listener_holder:add(key, events, clbk)
end

function DynamicResourceManager:remove_listener(key)
	self._listener_holder:remove(key)
end

function DynamicResourceManager:set_max_streaming_chunk(size_kb)
	self._max_streaming_chunk_kb = size_kb
end

function DynamicResourceManager:max_streaming_chunk()
	return self._max_streaming_chunk_kb
end
