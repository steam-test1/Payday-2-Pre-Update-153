MissionAssetsManager = MissionAssetsManager or class()
MissionAssetsManager.ALLOW_CLIENTS_UNLOCK = false

function MissionAssetsManager:init()
	self:_setup()
end

function MissionAssetsManager:_setup()
	self._asset_textures_in_loading = {}
	self._asset_textures_loaded = {}
	local assets = {}
	Global.asset_manager = {}
	Global.asset_manager.assets = assets
	self._global = Global.asset_manager
	self._tweak_data = tweak_data.assets
	self._money_spent = 0
	self._triggers = {}
	self:_setup_mission_assets()
end

function MissionAssetsManager:_setup_mission_assets()
	local is_host = Network:is_server() or Global.game_settings.single_player
	local current_stage = managers.job:current_level_id()
	if not current_stage or not is_host then
		return
	end
	for id, asset in pairs(self._tweak_data) do
		if asset.stages and (asset.stages == "all" or table.contains(asset.stages, current_stage)) then
			local requirements = {}
			requirements.saved_job_lock = nil
			requirements.job_lock = nil
			requirements.money_lock = nil
			requirements.upgrade_lock = nil
			requirements.achievment_lock = nil
			requirements.risk_lock = nil
			local can_unlock = false
			local require_to_unlock = asset.require_to_unlock or "all"
			if asset.money_lock then
				requirements.money_lock = false
				can_unlock = true
			end
			if asset.saved_job_lock then
				requirements.saved_job_lock = managers.mission:get_saved_job_value(asset.saved_job_lock) or false
				can_unlock = requirements.saved_job_lock and can_unlock or false
			end
			if asset.job_lock then
				requirements.job_lock = managers.mission:get_job_value(asset.job_lock) or false
				can_unlock = requirements.job_lock and can_unlock or false
			end
			if asset.upgrade_lock then
				requirements.upgrade_lock = managers.player:has_category_upgrade(asset.upgrade_lock.category, asset.upgrade_lock.upgrade)
				can_unlock = requirements.upgrade_lock and can_unlock or false
			end
			if asset.achievment_lock then
				requirements.achievment_lock = managers.achievment:exists(asset.achievment_lock) and managers.achievment:get_info(asset.achievment_lock).awarded
				can_unlock = requirements.achievment_lock and can_unlock or false
			end
			if asset.risk_lock then
				requirements.risk_lock = current_stage ~= "safehouse" and managers.job:current_difficulty_stars() == asset.risk_lock
				can_unlock = current_stage ~= "safehouse" and requirements.risk_lock and can_unlock or false
			end
			local needs_any = Idstring(require_to_unlock) == Idstring("any")
			local unlocked = true
			if needs_any and asset.money_lock then
				can_unlock = true
			end
			for id, exist in pairs(requirements) do
				if exist then
					if needs_any then
						unlocked = true
						break
					end
				else
					unlocked = false
					if not needs_any then
						break
					end
				end
			end
			local show = unlocked or can_unlock or asset.visible_if_locked
			table.insert(self._global.assets, {
				id = id,
				unlocked = unlocked,
				show = show,
				can_unlock = can_unlock,
				no_mystery = asset.no_mystery
			})
		end
	end
	table.sort(self._global.assets, function(x, y)
		if x.show ~= y.show then
			return x.show
		elseif x.unlocked ~= y.unlocked then
			return x.unlocked
		elseif x.can_unlock ~= y.can_unlock then
			return x.can_unlock
		end
		if x.no_mystery ~= y.no_mystery then
			return x.no_mystery
		end
		if self._tweak_data[x.id].money_lock and self._tweak_data[y.id].money_lock then
			return self._tweak_data[x.id].money_lock < self._tweak_data[y.id].money_lock
		elseif self._tweak_data[x.id].money_lock then
			return true
		elseif self._tweak_data[y.id].money_lock then
			return false
		else
			return x.id < y.id
		end
	end)
end

function MissionAssetsManager:init_finalize()
	local is_server = Network:is_server() or Global.game_settings.single_player
	local current_stage = managers.job:current_level_id()
	if not current_stage or not is_server then
		return
	end
	self:create_asset_textures()
	self:_check_triggers("asset")
end

function MissionAssetsManager:clear()
	Global.asset_manager = nil
	self._money_spent = 0
end

function MissionAssetsManager:reset()
	Global.asset_manager = nil
	self:_setup()
	self:_check_triggers("asset")
end

function MissionAssetsManager:on_simulation_ended()
	self:reset()
end

function MissionAssetsManager:add_trigger(id, type, asset_id, callback)
	self._triggers[type] = self._triggers[type] or {}
	self._triggers[type][id] = {id = asset_id, callback = callback}
end

function MissionAssetsManager:_check_triggers(type)
	if not self._triggers[type] then
		return
	end
	for id, cb_data in pairs(self._triggers[type]) do
		local asset = self:_get_asset_by_id(cb_data.id)
		if type ~= "asset" or asset and asset.unlocked and not asset.is_triggered then
			cb_data.callback()
			if asset then
				asset.is_triggered = true
			end
		end
	end
end

function MissionAssetsManager:unlock_asset(asset_id)
	if Idstring(asset_id) == Idstring("none") then
		return
	end
	if Network:is_server() and not self:get_asset_triggered_by_id(asset_id) then
		self._money_spent = self._money_spent + managers.money:on_buy_mission_asset(asset_id)
		self:server_unlock_asset(asset_id)
	elseif self.ALLOW_CLIENTS_UNLOCK and not self:get_asset_unlocked_by_id(asset_id) then
		self._money_spent = self._money_spent + managers.money:on_buy_mission_asset(asset_id)
		managers.network:session():send_to_host("server_unlock_asset", asset_id)
	end
	if WalletGuiObject then
		WalletGuiObject.refresh()
	end
end

function MissionAssetsManager:get_money_spent()
	return self._money_spent
end

function MissionAssetsManager:server_unlock_asset(asset_id)
	managers.network:session():send_to_peers_synched("sync_unlock_asset", asset_id)
	self:sync_unlock_asset(asset_id)
	self:_check_triggers("asset")
end

function MissionAssetsManager:sync_unlock_asset(asset_id)
	local asset = self:_get_asset_by_id(asset_id)
	if not asset then
		Application:error("sync_set_asset_enabled: No asset with id:", asset_id)
		return
	end
	if asset.unlocked then
		Application:error("sync_set_asset_enabled: Asset already unlocked:", asset_id)
		return
	end
	asset.unlocked = true
	managers.menu_component:unlock_asset_mission_briefing_gui(asset_id)
end

function MissionAssetsManager:get_every_asset_ids()
	local asset_ids = {}
	for id, asset in pairs(tweak_data.assets) do
		table.insert(asset_ids, id)
	end
	return asset_ids
end

function MissionAssetsManager:get_all_asset_ids(only_visible)
	local asset_ids = {}
	for _, asset in ipairs(self._global.assets) do
		if not only_visible or asset.show then
			table.insert(asset_ids, asset.id)
		end
	end
	return asset_ids
end

function MissionAssetsManager:get_default_asset_id()
	return "none"
end

function MissionAssetsManager:_get_asset_by_id(id)
	for _, asset in pairs(self._global.assets) do
		if asset.id == id then
			return asset
		end
	end
end

function MissionAssetsManager:get_asset_can_unlock_by_id(id)
	local asset = self:_get_asset_by_id(id)
	return asset and asset.can_unlock or false
end

function MissionAssetsManager:get_asset_visible_by_id(id)
	local asset = self:_get_asset_by_id(id)
	return asset and asset.show or false
end

function MissionAssetsManager:get_asset_unlocked_by_id(id)
	local asset = self:_get_asset_by_id(id)
	return asset and asset.unlocked or false
end

function MissionAssetsManager:get_asset_triggered_by_id(id)
	local asset = self:_get_asset_by_id(id)
	return asset and asset.is_triggered or false
end

function MissionAssetsManager:get_asset_no_mystery_by_id(id)
	local asset = self:_get_asset_by_id(id)
	return asset and asset.no_mystery or false
end

function MissionAssetsManager:get_asset_tweak_data_by_id(id)
	return self._tweak_data[id]
end

function MissionAssetsManager:get_asset_unlock_text_by_id(id)
	local asset_tweak_data = self._tweak_data[id]
	local prefix = "menu_asset_lock_"
	local text = "unable_to_unlock"
	if asset_tweak_data.no_mystery then
		if asset_tweak_data.upgrade_lock then
			text = asset_tweak_data.upgrade_lock.upgrade
		elseif asset_tweak_data.achievment_lock then
			text = "achv_" .. asset_tweak_data.achievment_lock
		elseif asset_tweak_data.job_lock then
			text = "jval_" .. asset_tweak_data.job_lock
		elseif asset_tweak_data.saved_job_lock then
			text = "sjval_" .. asset_tweak_data.saved_job_lock
		end
	end
	return prefix .. text
end

function MissionAssetsManager:sync_save(data)
	data.MissionAssetsManager = self._global
end

function MissionAssetsManager:sync_load(data)
	self._global = data.MissionAssetsManager
	self:create_asset_textures()
end

function MissionAssetsManager:clear_asset_textures()
	if self._asset_textures_loaded then
		for texture_key, texture in pairs(self._asset_textures_loaded) do
			TextureCache:unretrieve(texture)
		end
	end
	if self._asset_textures_in_loading then
		for texture_key, texture_data in pairs(self._asset_textures_in_loading) do
			TextureCache:unretrieve(Idstring(texture_data[2]))
		end
	end
	self._asset_textures_in_loading = {}
	self._asset_textures_loaded = {}
end

function MissionAssetsManager:create_asset_textures()
	if managers.platform:presence() == "Playing" then
		Application:debug("[MissionAssetsManager] create_asset_textures(): ", managers.platform:presence())
		return
	end
	local all_visible_assets = self:get_all_asset_ids(true)
	local texture_loaded_clbk = callback(self, self, "texture_loaded_clbk")
	local texture
	for _, asset_id in ipairs(all_visible_assets) do
		texture = self._tweak_data[asset_id].texture
		self._asset_textures_in_loading[Idstring(texture):key()] = {asset_id, texture}
		TextureCache:request(texture, "NORMAL", texture_loaded_clbk)
	end
end

function MissionAssetsManager:get_asset_texture(asset_id)
	local texture = self._asset_textures_loaded[asset_id]
	if not texture then
		Application:error("[MissionAssetsManager] get_asset_texture(): Asset texture not loaded!", asset_id)
	end
	return texture
end

function MissionAssetsManager:texture_loaded_clbk(texture_idstring)
	if not self._asset_textures_in_loading[texture_idstring:key()] then
		TextureCache:unretrieve(texture_idstring)
		return
	end
	local asset_texture_data = self._asset_textures_in_loading[texture_idstring:key()]
	local asset_id = asset_texture_data[1]
	local texture_path = asset_texture_data[2]
	if self._asset_textures_loaded[asset_id] then
		Application:debug("[MissionAssetsManager] texture_loaded_clbk() Asset already got texture loaded.")
		TextureCache:unretrieve(texture_idstring)
		return
	end
	self._asset_textures_loaded[asset_id] = texture_idstring
	self._asset_textures_in_loading[texture_idstring:key()] = nil
	Application:debug("[MissionAssetsManager] Texture loaded for asset", asset_id)
	self:check_all_textures_loaded()
end

function MissionAssetsManager:check_all_textures_loaded()
	if self:is_all_textures_loaded() then
		Application:debug("[MissionAssetsManager] Creating mission assets")
		managers.menu_component:create_asset_mission_briefing_gui()
	end
end

function MissionAssetsManager:is_all_textures_loaded()
	if not self._asset_textures_in_loading or not self._asset_textures_loaded then
		return false
	end
	return table.size(self._asset_textures_in_loading) == 0 and table.size(self._asset_textures_loaded) ~= 0
end
