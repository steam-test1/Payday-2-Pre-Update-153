DLCManager = DLCManager or class()
DLCManager.PLATFORM_CLASS_MAP = {}

function DLCManager:new(...)
	local platform = SystemInfo:platform()
	return (self.PLATFORM_CLASS_MAP[platform:key()] or GenericDLCManager):new(...)
end

GenericDLCManager = GenericDLCManager or class()

function GenericDLCManager:init()
	self._debug_on = Application:production_build()
	self:_set_dlc_save_table()
end

function GenericDLCManager:_set_dlc_save_table()
	if not Global.dlc_save then
		Global.dlc_save = {
			packages = {}
		}
	end
end

function GenericDLCManager:init_finalize()
	managers.savefile:add_load_sequence_done_callback_handler(callback(self, self, "_load_done"))
end

function GenericDLCManager:_load_done(...)
	self:give_dlc_package()
	if managers.blackmarket then
		managers.blackmarket:verify_dlc_items()
	else
		Application:error("[GenericDLCManager] _load_done(): BlackMarketManager not yet initialized!")
	end
end

function GenericDLCManager:give_dlc_package()
	for package_id, data in pairs(tweak_data.dlc) do
		if data.free or self[data.dlc](self) then
			print("[DLC] Ownes dlc", data.free, data.dlc)
			if not Global.dlc_save.packages[package_id] then
				Global.dlc_save.packages[package_id] = true
				for _, loot_drop in ipairs(data.content.loot_drops or {}) do
					for i = 1, loot_drop.amount do
						local entry = tweak_data.blackmarket[loot_drop.type_items][loot_drop.item_entry]
						local global_value = loot_drop.global_value or data.content.loot_global_value or package_id
						print(i .. "  give", loot_drop.type_items, loot_drop.item_entry, global_value)
						managers.blackmarket:add_to_inventory(global_value, loot_drop.type_items, loot_drop.item_entry)
					end
				end
			else
				print("[DLC] Allready been given dlc package", package_id)
			end
			for _, upgrade in ipairs(data.content.upgrades or {}) do
				managers.upgrades:aquire_default(upgrade)
			end
		else
			print("[DLC] Didn't own DLC package", package_id)
		end
	end
end

function GenericDLCManager:save(data)
	data.dlc_save = Global.dlc_save
end

function GenericDLCManager:load(data)
	if data.dlc_save and data.dlc_save.packages then
		Global.dlc_save = data.dlc_save
	end
end

function GenericDLCManager:on_reset_profile()
	Global.dlc_save = nil
	self:_set_dlc_save_table()
	self:give_dlc_package()
end

function GenericDLCManager:on_signin_complete()
end

function GenericDLCManager:has_dlc(dlc)
	local dlc_data = Global.dlc_manager.all_dlc_data[dlc]
	if not dlc_data then
		Application:error("Didn't have dlc data for", dlc)
		return false
	end
	return dlc_data.verified
end

function GenericDLCManager:has_full_game()
	return Global.dlc_manager.all_dlc_data.full_game.verified
end

function GenericDLCManager:is_trial()
	return not self:has_full_game()
end

function GenericDLCManager:dlcs_string()
	local s = ""
	s = s .. (self:has_preorder() and "preorder " or "")
	return s
end

function GenericDLCManager:has_corrupt_data()
	return self._has_corrupt_data
end

function GenericDLCManager:has_preorder()
	return Global.dlc_manager.all_dlc_data.preorder.verified
end

PS3DLCManager = PS3DLCManager or class(GenericDLCManager)
DLCManager.PLATFORM_CLASS_MAP[Idstring("PS3"):key()] = PS3DLCManager
PS3DLCManager.SERVICE_ID = "EP4040-BLES01902_00"

function PS3DLCManager:init()
	PS3DLCManager.super.init(self)
	if not Global.dlc_manager then
		Global.dlc_manager = {}
		Global.dlc_manager.all_dlc_data = {
			full_game = {
				filename = "full_game_key.edat",
				product_id = "EP4040-BLES01902_00-PAYDAY2NPEU00000"
			},
			preorder = {
				filename = "preorder_dlc_key.edat",
				product_id = "EP4040-BLES01902_00-PPAYDAY2XX000006"
			}
		}
		self:_verify_dlcs()
	end
end

function PS3DLCManager:_verify_dlcs()
	local all_dlc = {}
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if not dlc_data.verified then
			table.insert(all_dlc, dlc_data.filename)
		end
	end
	local verified_dlcs = PS3:check_dlc_availability(all_dlc)
	Global.dlc_manager.verified_dlcs = verified_dlcs
	for _, verified_filename in pairs(verified_dlcs) do
		for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
			if dlc_data.filename == verified_filename then
				print("DLC verified:", verified_filename)
				dlc_data.verified = true
				break
			end
		end
	end
end

function PS3DLCManager:_init_NPCommerce()
	PS3:set_service_id(self.SERVICE_ID)
	local result = NPCommerce:init()
	print("init result", result)
	if not result then
		MenuManager:show_np_commerce_init_fail()
		NPCommerce:destroy()
		return
	end
	local result = NPCommerce:open(callback(self, self, "cb_NPCommerce"))
	print("open result", result)
	if result < 0 then
		MenuManager:show_np_commerce_init_fail()
		NPCommerce:destroy()
		return
	end
	return true
end

function PS3DLCManager:buy_full_game()
	print("[PS3DLCManager:buy_full_game]")
	if self._activity then
		return
	end
	if not self:_init_NPCommerce() then
		return
	end
	managers.menu:show_waiting_NPCommerce_open()
	self._request = {
		type = "buy_product",
		product = "full_game"
	}
	self._activity = {type = "open"}
end

function PS3DLCManager:buy_product(product_name)
	print("[PS3DLCManager:buy_product]", product_name)
	if self._activity then
		return
	end
	if not self:_init_NPCommerce() then
		return
	end
	managers.menu:show_waiting_NPCommerce_open()
	self._request = {
		type = "buy_product",
		product = product_name
	}
	self._activity = {type = "open"}
end

function PS3DLCManager:cb_NPCommerce(result, info)
	print("[PS3DLCManager:cb_NPCommerce]", result, info)
	for i, k in pairs(info) do
		print(i, k)
	end
	self._NPCommerce_cb_results = self._NPCommerce_cb_results or {}
	print("self._activity", self._activity and inspect(self._activity))
	table.insert(self._NPCommerce_cb_results, {result, info})
	if not self._activity then
		return
	elseif self._activity.type == "open" then
		if info.category_error or info.category_done == false then
			self._activity = nil
			managers.system_menu:close("waiting_for_NPCommerce_open")
			self:_close_NPCommerce()
		else
			managers.system_menu:close("waiting_for_NPCommerce_open")
			local product_id = Global.dlc_manager.all_dlc_data[self._request.product].product_id
			print("starting storebrowse", product_id)
			local ret = NPCommerce:storebrowse("product", product_id, true)
			if not ret then
				self._activity = nil
				managers.menu:show_NPCommerce_checkout_fail()
				self:_close_NPCommerce()
			end
			self._activity = {type = "browse"}
		end
	elseif self._activity.type == "browse" then
		if info.browse_succes then
			self._activity = nil
			managers.menu:show_NPCommerce_browse_success()
			self:_close_NPCommerce()
		elseif info.browse_back then
			self._activity = nil
			self:_close_NPCommerce()
		elseif info.category_error then
			self._activity = nil
			managers.menu:show_NPCommerce_browse_fail()
			self:_close_NPCommerce()
		end
	elseif self._activity.type == "checkout" then
		if info.checkout_error then
			self._activity = nil
			managers.menu:show_NPCommerce_checkout_fail()
			self:_close_NPCommerce()
		elseif info.checkout_cancel then
			self._activity = nil
			self:_close_NPCommerce()
		elseif info.checkout_success then
			self._activity = nil
			self:_close_NPCommerce()
		end
	end
	print("/[PS3DLCManager:cb_NPCommerce]")
end

function PS3DLCManager:_close_NPCommerce()
	print("[PS3DLCManager:_close_NPCommerce]")
	NPCommerce:destroy()
end

function PS3DLCManager:cb_confirm_purchase_yes(sku_data)
	NPCommerce:checkout(sku_data.skuid)
end

function PS3DLCManager:cb_confirm_purchase_no()
	self._activity = nil
	self:_close_NPCommerce()
end

X360DLCManager = X360DLCManager or class(GenericDLCManager)
DLCManager.PLATFORM_CLASS_MAP[Idstring("X360"):key()] = X360DLCManager

function X360DLCManager:init()
	X360DLCManager.super.init(self)
	if not Global.dlc_manager then
		Global.dlc_manager = {}
		Global.dlc_manager.all_dlc_data = {
			full_game = {
				is_default = true,
				verified = true,
				index = 0
			},
			preorder = {
				is_default = false,
				verified = nil,
				index = 1
			}
		}
		self:_verify_dlcs()
	end
end

function X360DLCManager:_verify_dlcs()
	local found_dlc = {}
	local status = XboxLive:check_dlc_availability(0, 100, found_dlc)
	if not status then
		Application:error("XboxLive:check_dlc_availability failed", inspect(found_dlc))
		return
	end
	print("[X360DLCManager:_verify_dlcs] found dlc:", inspect(found_dlc))
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if dlc_data.is_default or found_dlc[dlc_data.index] then
			dlc_data.verified = true
		else
			dlc_data.verified = false
		end
	end
	if found_dlc.has_corrupt_data then
		self._has_corrupt_data = true
	end
end

function X360DLCManager:on_signin_complete()
	self:_verify_dlcs()
end

WINDLCManager = WINDLCManager or class(GenericDLCManager)
DLCManager.PLATFORM_CLASS_MAP[Idstring("WIN32"):key()] = WINDLCManager

function WINDLCManager:init()
	WINDLCManager.super.init(self)
	if not Global.dlc_manager then
		Global.dlc_manager = {}
		Global.dlc_manager.all_dlc_data = {
			full_game = {app_id = "218620", verified = true},
			preorder = {app_id = "247450", no_install = true}
		}
		self:_verify_dlcs()
	end
end

function WINDLCManager:_verify_dlcs()
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if not dlc_data.verified then
			if dlc_data.no_install then
				if Steam:is_product_owned(dlc_data.app_id) then
					dlc_data.verified = true
				end
			elseif Steam:is_product_installed(dlc_data.app_id) then
				dlc_data.verified = true
			end
		end
	end
end
