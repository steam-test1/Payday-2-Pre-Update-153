InfamyManager = InfamyManager or class()
InfamyManager.VERSION = 1

function InfamyManager:init()
	self:_setup()
end

function InfamyManager:_setup(reset)
	if not Global.infamy_manager or reset then
		Global.infamy_manager = {}
		Global.infamy_manager.points = Application:digest_value(0, true)
		Global.infamy_manager.VERSION = InfamyManager.VERSION
		Global.infamy_manager.reset_message = false
		self._global = Global.infamy_manager
		self._global.unlocks = {}
		for item_id, item_name in pairs(tweak_data.infamy.tree) do
			self._global.unlocks[item_name] = false
		end
	end
	self._global = Global.infamy_manager
end

function InfamyManager:points()
	return Application:digest_value(self._global.points, false)
end

function InfamyManager:aquire_point()
	self:_set_points(self:points() + 1)
end

function InfamyManager:_set_points(value)
	self._global.points = Application:digest_value(value, true)
end

function InfamyManager:_reset_points()
	self:_set_points(0)
end

function InfamyManager:required_points(item)
	if tweak_data.infamy.items[item] then
		return self:points() >= Application:digest_value(tweak_data.infamy.items[item].cost, false)
	end
end

function InfamyManager:unlock_item(item)
	local infamy_item = tweak_data.infamy.items[item]
	if not infamy_item then
		debug_pause("InfamyManager:unlock_item]: Missing item = '" .. tostring(item) .. "'")
		return
	end
	if self:points() >= Application:digest_value(infamy_item.cost, false) then
		for bonus, item in ipairs(infamy_item.upgrades) do
			local global_value = item[1]
			local category = item[2]
			local item_id = item[3]
			local item_tweak = tweak_data.blackmarket[category][item_id]
			managers.blackmarket:add_to_inventory(global_value or item_tweak.global_value or "normal", category, item_id)
		end
		self:_set_points(self:points() - Application:digest_value(infamy_item.cost, false))
		self._global.unlocks[item] = true
	end
end

function InfamyManager:owned(item)
	return self._global.unlocks[item] or false
end

function InfamyManager:available(item)
	local tier_count = 0
	local points_curr_tier = 0
	local points_prev_tier = 0
	if tweak_data.infamy.tree[1] == item then
		return true
	end
	for index, name in pairs(tweak_data.infamy.tree) do
		if item == name then
			return 0 < points_prev_tier
		end
		points_curr_tier = points_curr_tier + (self._global.unlocks[name] and 1 or 0)
		tier_count = tier_count + 1
		if index == 1 or tier_count == 4 then
			tier_count = 0
			points_prev_tier = points_curr_tier
			points_curr_tier = 0
		end
	end
	return false
end

function InfamyManager:reset_items()
	self:_reset_points()
	self._global.VERSION = InfamyManager.VERSION
	self._global.reset_message = true
end

function InfamyManager:check_reset_message()
	local show_reset_message = self._global.reset_message and true or false
	if show_reset_message then
		managers.menu:show_infamytree_reseted()
		self._global.reset_message = false
		MenuCallbackHandler:save_progress()
	end
end

function InfamyManager:save(data)
	local state = {
		points = self._global.points,
		unlocks = self._global.unlocks,
		VERSION = self._global.VERSION or 0,
		reset_message = self._global.reset_message
	}
	data.InfamyManager = state
end

function InfamyManager:load(data, version)
	local state = data.InfamyManager
	if state then
		self._global.points = state.points
		for item_id, item_data in pairs(state.unlocks) do
			self._global.unlocks[item_id] = item_data
		end
		self._global.VERSION = state.VERSION
		self._global.reset_message = state.reset_message
		if not self._global.VERSION or self._global.VERSION < InfamyManager.VERSION then
			managers.savefile:add_load_done_callback(callback(self, self, "reset_items"))
		end
	end
end

function InfamyManager:reset()
	Global.infamy_manager = nil
	self:_setup()
end
