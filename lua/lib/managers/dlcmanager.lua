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

function GenericDLCManager:setup()
	self:_modify_locked_content()
	self:_create_achievement_locked_content_table()
end

function GenericDLCManager:_create_achievement_locked_content_table()
	self._achievement_locked_content = {}
	self._dlc_locked_content = {}
	for name, dlc in pairs(tweak_data.dlc) do
		local content = dlc.content
		if content then
			local loot_drops = content.loot_drops
			if loot_drops then
				for _, loot_drop in ipairs(loot_drops) do
					if loot_drop.type_items then
						if dlc.achievement_id then
							self._achievement_locked_content[loot_drop.type_items] = self._achievement_locked_content[loot_drop.type_items] or {}
							self._achievement_locked_content[loot_drop.type_items][loot_drop.item_entry] = name
						else
							self._dlc_locked_content[loot_drop.type_items] = self._dlc_locked_content[loot_drop.type_items] or {}
							self._dlc_locked_content[loot_drop.type_items][loot_drop.item_entry] = name
						end
					end
				end
			end
		end
	end
end

function GenericDLCManager:_modify_locked_content()
	if SystemInfo:platform() == Idstring("WIN32") then
		return
	end
	local _modify_loot_drop = function(loot_drop)
		local entry = tweak_data.blackmarket[loot_drop.type_items] and tweak_data.blackmarket[loot_drop.type_items][loot_drop.item_entry]
		if entry then
			if not entry.pc and (not entry.pcs or #entry.pcs == 0) then
				entry.pcs = {
					10,
					20,
					30,
					40
				}
				if loot_drop.type_items == "weapon_mods" then
					tweak_data.weapon.factory.parts[loot_drop.item_entry].pcs = {
						10,
						20,
						30,
						40
					}
				end
			end
		else
			print(" -- entry not exists")
		end
	end
	for name, dlc in pairs(tweak_data.dlc) do
		if not dlc.content_on_consoles then
			local content = dlc.content
			if content then
				local loot_drops = content.loot_drops
				if loot_drops then
					for _, loot_drop in ipairs(loot_drops) do
						if 0 < #loot_drop then
							for _, lp in ipairs(loot_drop) do
								_modify_loot_drop(lp)
							end
						else
							_modify_loot_drop(loot_drop)
						end
					end
					content.loot_drops = {}
				end
			end
		end
	end
end

function GenericDLCManager:achievement_locked_content()
	return self._achievement_locked_content
end

function GenericDLCManager:is_mask_achievement_locked(mask_id)
	return self._achievement_locked_content.masks and self._achievement_locked_content.masks[mask_id]
end

function GenericDLCManager:is_material_achievement_locked(material_id)
	return self._achievement_locked_content.materials and self._achievement_locked_content.materials[material_id]
end

function GenericDLCManager:is_texture_achievement_locked(texture_id)
	return self._achievement_locked_content.textures and self._achievement_locked_content.textures[texture_id]
end

function GenericDLCManager:is_weapon_mod_achievement_locked(weapon_mod_id)
	return self._achievement_locked_content.weapon_mods and self._achievement_locked_content.weapon_mods[weapon_mod_id]
end

function GenericDLCManager:on_tweak_data_reloaded()
	self:setup()
end

function GenericDLCManager:init_finalize()
	managers.savefile:add_load_sequence_done_callback_handler(callback(self, self, "_load_done"))
end

function GenericDLCManager:chk_content_updated()
end

function GenericDLCManager:give_dlc_and_verify_blackmarket()
	self:give_dlc_package()
	managers.network.account:inventory_reward_dlc()
	if managers.blackmarket then
		managers.blackmarket:verify_dlc_items()
	else
		Application:error("[GenericDLCManager] _load_done(): BlackMarketManager not yet initialized!")
	end
end

function GenericDLCManager:_load_done(...)
	self:give_dlc_and_verify_blackmarket()
end

function GenericDLCManager:give_dlc_package()
	for package_id, data in pairs(tweak_data.dlc) do
		print("package_id", package_id, inspect(data))
		if data.free or self[data.dlc](self, data) then
			print("[DLC] Ownes dlc", data.free, data.dlc)
			if not Global.dlc_save.packages[package_id] then
				Global.dlc_save.packages[package_id] = true
				for _, loot_drop in ipairs(data.content.loot_drops or {}) do
					print("  loot_drop", inspect(loot_drop))
					local loot_drop = 0 < #loot_drop and loot_drop[math.random(#loot_drop)] or loot_drop
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
			local identifier = UpgradesManager.AQUIRE_STRINGS[5] .. tostring(package_id)
			for _, upgrade in ipairs(data.content.upgrades or {}) do
				if not managers.upgrades:aquired(upgrade, identifier) then
					managers.upgrades:aquire_default(upgrade, identifier)
				end
			end
		else
			print("[DLC] Didn't own DLC package", package_id)
			local identifier = UpgradesManager.AQUIRE_STRINGS[5] .. tostring(package_id)
			for _, upgrade in ipairs(data.content.upgrades or {}) do
				if managers.upgrades:aquired(upgrade, identifier) then
					managers.upgrades:unaquire(upgrade, identifier)
				end
			end
		end
	end
end

function GenericDLCManager:give_missing_package()
	local name_converter = {
		colors = "color",
		materials = "material",
		textures = "pattern"
	}
	local entry, global_value, passed, has_item, name
	for package_id, data in pairs(tweak_data.dlc) do
		if Global.dlc_save.packages[package_id] and (data.free or self[data.dlc](self, data)) then
			for _, loot_drop in ipairs(data.content and data.content.loot_drops or {}) do
				if #loot_drop == 0 then
					entry = tweak_data.blackmarket[loot_drop.type_items][loot_drop.item_entry]
					global_value = loot_drop.global_value or data.content.loot_global_value or package_id
					passed = false
					if loot_drop.type_items == "weapon_mods" and entry.is_a_unlockable then
						has_item = 0 < managers.blackmarket:get_item_amount(global_value, loot_drop.type_items, loot_drop.item_entry, true)
						passed = not has_item
					elseif loot_drop.type_items ~= "weapon_mods" and entry.value == 0 then
						has_item = 0 < managers.blackmarket:get_item_amount(global_value, loot_drop.type_items, loot_drop.item_entry, true)
						if not has_item then
							if loot_drop.type_items == "masks" then
								for slot, crafted in pairs(Global.blackmarket_manager.crafted_items.masks) do
									if slot ~= 1 and crafted.mask_id == loot_drop.item_entry and crafted.global_value == global_value then
										has_item = true
										break
									end
								end
							elseif loot_drop.type_items == "materials" or loot_drop.type_items == "textures" or loot_drop.type_items == "colors" then
								for slot, crafted in pairs(Global.blackmarket_manager.crafted_items.masks) do
									if slot ~= 1 then
										name = name_converter[loot_drop.type_items]
										if crafted.blueprint[name].id == loot_drop.item_entry and crafted.blueprint[name].global_value == global_value then
											has_item = true
											break
										end
									end
								end
							end
							passed = not has_item
						end
					end
					if passed then
						print("[GenericDLCManager:give_missing_package] Found missing Item!", loot_drop.amount, global_value, loot_drop.type_items, loot_drop.item_entry)
						for i = 1, loot_drop.amount do
							managers.blackmarket:add_to_inventory(global_value, loot_drop.type_items, loot_drop.item_entry)
						end
					end
				end
			end
		end
	end
end

function GenericDLCManager:list_dlc_package(dlcs)
	local t = {}
	for package_id, data in pairs(tweak_data.dlc) do
		if not dlcs or dlcs[package_id] or table.contains(dlcs, package_id) then
			for _, loot_drop in ipairs(data.content.loot_drops or {}) do
				t.items = t.items or {}
				if 0 < #loot_drop then
				else
					local global_value = loot_drop.global_value or data.content.loot_global_value or package_id
					local category = loot_drop.type_items
					local entry = loot_drop.item_entry
					local amount = loot_drop.amount
					table.insert(t.items, {
						global_value,
						category,
						entry,
						amount
					})
				end
			end
			for _, upgrade in ipairs(data.content.upgrades or {}) do
				t.upgrades = t.upgrades or {}
				table.insert(t.upgrades, upgrade)
			end
		end
	end
	return t
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

function GenericDLCManager:on_achievement_award_loot()
	Application:debug("GenericDLCManager:on_achievement_award_loot()")
	self:give_dlc_package()
end

function GenericDLCManager:on_signin_complete()
end

function GenericDLCManager:is_dlc_unlocked(dlc)
	return tweak_data.dlc[dlc] and tweak_data.dlc[dlc].free or self:has_dlc(dlc)
end

function GenericDLCManager:has_dlc(dlc)
	if tweak_data.dlc[dlc] and tweak_data.dlc[dlc].use_custom_func and tweak_data.dlc[dlc].dlc then
		return self[tweak_data.dlc[dlc].dlc](self, tweak_data.dlc[dlc])
	end
	if dlc == "cce" then
		dlc = "career_criminal_edition"
	end
	local dlc_data = Global.dlc_manager.all_dlc_data[dlc]
	if not dlc_data then
		Application:error("Didn't have dlc data for", dlc)
		Application:stack_dump()
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

function GenericDLCManager:is_installing()
	if not DB:is_bundled() or SystemInfo:platform() == Idstring("WIN32") then
		return false, 1
	end
	local install_progress = Application:installer():get_progress()
	local is_installing = install_progress < 1
	return is_installing, install_progress
end

function GenericDLCManager:dlcs_string()
	local s = ""
	s = s .. (self:has_preorder() and "preorder " or "")
	return s
end

function GenericDLCManager:has_corrupt_data()
	return self._has_corrupt_data
end

function GenericDLCManager:has_all_dlcs()
	return self:has_armored_transport() and self:has_gage_pack()
end

function GenericDLCManager:has_preorder()
	return Global.dlc_manager.all_dlc_data.preorder and Global.dlc_manager.all_dlc_data.preorder.verified
end

function GenericDLCManager:has_cce()
	return Global.dlc_manager.all_dlc_data.career_criminal_edition and Global.dlc_manager.all_dlc_data.career_criminal_edition.verified
end

function GenericDLCManager:has_goty_weapon_bundle_2014()
	return self:has_gage_pack() and self:has_gage_pack_lmg() and self:has_gage_pack_jobs() and self:has_gage_pack_snp() and self:has_gage_pack_shotgun() and self:has_gage_pack_assault() and self:has_gage_pack_historical()
end

function GenericDLCManager:has_goty_heist_bundle_2014()
	return self:has_armored_transport() and self:has_big_bank() and self:has_hl_miami() and self:has_hope_diamond()
end

function GenericDLCManager:has_goty_all_dlc_bundle_2014()
	return self:has_goty_weapon_bundle_2014() and self:has_goty_heist_bundle_2014() and self:has_soundtrack_or_cce() and self:has_xmas_soundtrack() and self:has_character_pack_clover()
end

function GenericDLCManager:has_soundtrack()
	return Global.dlc_manager.all_dlc_data.soundtrack and Global.dlc_manager.all_dlc_data.soundtrack.verified
end

function GenericDLCManager:has_soundtrack_or_cce()
	return self:has_soundtrack() or self:has_cce()
end

function GenericDLCManager:has_pdth_soundtrack()
	return Global.dlc_manager.all_dlc_data.pdth_soundtrack and Global.dlc_manager.all_dlc_data.pdth_soundtrack.verified
end

function GenericDLCManager:has_pd2_clan()
	return Global.dlc_manager.all_dlc_data.pd2_clan and Global.dlc_manager.all_dlc_data.pd2_clan.verified
end

function GenericDLCManager:has_freed_old_hoxton(data)
	if SystemInfo:platform() == Idstring("WIN32") then
		return self:has_pd2_clan() and self:has_achievement(data)
	end
	return true
end

function GenericDLCManager:has_sweettooth()
	return Global.dlc_manager.all_dlc_data.sweettooth and Global.dlc_manager.all_dlc_data.sweettooth.verified
end

function GenericDLCManager:has_alienware_alpha()
	return Global.dlc_manager.all_dlc_data.alienware_alpha and Global.dlc_manager.all_dlc_data.alienware_alpha.verified
end

function GenericDLCManager:has_alienware_alpha_promo()
	return Global.dlc_manager.all_dlc_data.alienware_alpha_promo and Global.dlc_manager.all_dlc_data.alienware_alpha_promo.verified
end

function GenericDLCManager:has_armored_transport()
	return Global.dlc_manager.all_dlc_data.armored_transport and Global.dlc_manager.all_dlc_data.armored_transport.verified
end

function GenericDLCManager:has_armored_transport_and_intel(data)
	return self:has_armored_transport() and self:has_achievement(data)
end

function GenericDLCManager:has_gage_pack()
	return Global.dlc_manager.all_dlc_data.gage_pack and Global.dlc_manager.all_dlc_data.gage_pack.verified
end

function GenericDLCManager:has_gage_pack_lmg()
	return Global.dlc_manager.all_dlc_data.gage_pack_lmg and Global.dlc_manager.all_dlc_data.gage_pack_lmg.verified
end

function GenericDLCManager:has_gage_pack_jobs()
	return Global.dlc_manager.all_dlc_data.gage_pack_jobs and Global.dlc_manager.all_dlc_data.gage_pack_jobs.verified
end

function GenericDLCManager:has_gage_pack_snp()
	return Global.dlc_manager.all_dlc_data.gage_pack_snp and Global.dlc_manager.all_dlc_data.gage_pack_snp.verified
end

function GenericDLCManager:has_gage_pack_shotgun()
	return Global.dlc_manager.all_dlc_data.gage_pack_shotgun and Global.dlc_manager.all_dlc_data.gage_pack_shotgun.verified
end

function GenericDLCManager:has_gage_pack_assault()
	return Global.dlc_manager.all_dlc_data.gage_pack_assault and Global.dlc_manager.all_dlc_data.gage_pack_assault.verified
end

function GenericDLCManager:has_overkill_pack()
	return Global.dlc_manager.all_dlc_data.overkill_pack and Global.dlc_manager.all_dlc_data.overkill_pack.verified
end

function GenericDLCManager:has_complete_overkill_pack()
	return Global.dlc_manager.all_dlc_data.complete_overkill_pack and Global.dlc_manager.all_dlc_data.complete_overkill_pack.verified
end

function GenericDLCManager:has_akm4_pack()
	return Global.dlc_manager.all_dlc_data.akm4_pack and Global.dlc_manager.all_dlc_data.akm4_pack.verified
end

function GenericDLCManager:has_big_bank()
	return Global.dlc_manager.all_dlc_data.big_bank and Global.dlc_manager.all_dlc_data.big_bank.verified
end

function GenericDLCManager:has_hl_miami()
	return Global.dlc_manager.all_dlc_data.hl_miami and Global.dlc_manager.all_dlc_data.hl_miami.verified
end

function GenericDLCManager:has_hlm_game()
	return Global.dlc_manager.all_dlc_data.hlm_game and Global.dlc_manager.all_dlc_data.hlm_game.verified
end

function GenericDLCManager:has_hlm2()
	return (not Global.dlc_manager.all_dlc_data.hlm2 or not Global.dlc_manager.all_dlc_data.hlm2.verified) and Global.dlc_manager.all_dlc_data.hlm2_aus and Global.dlc_manager.all_dlc_data.hlm2_aus.verified
end

function GenericDLCManager:has_hlm2_deluxe()
	return (not Global.dlc_manager.all_dlc_data.hlm2_deluxe or not Global.dlc_manager.all_dlc_data.hlm2_deluxe.verified) and Global.dlc_manager.all_dlc_data.hlm2_aus and Global.dlc_manager.all_dlc_data.hlm2_aus.verified
end

function GenericDLCManager:has_speedrunners()
	return Global.dlc_manager.all_dlc_data.speedrunners and Global.dlc_manager.all_dlc_data.speedrunners.verified
end

function GenericDLCManager:has_character_pack_clover()
	return Global.dlc_manager.all_dlc_data.character_pack_clover and Global.dlc_manager.all_dlc_data.character_pack_clover.verified
end

function GenericDLCManager:has_character_pack_dragan()
	return Global.dlc_manager.all_dlc_data.character_pack_dragan and Global.dlc_manager.all_dlc_data.character_pack_dragan.verified
end

function GenericDLCManager:has_hope_diamond()
	return Global.dlc_manager.all_dlc_data.hope_diamond and Global.dlc_manager.all_dlc_data.hope_diamond.verified
end

function GenericDLCManager:has_the_bomb()
	return Global.dlc_manager.all_dlc_data.the_bomb and Global.dlc_manager.all_dlc_data.the_bomb.verified
end

function GenericDLCManager:has_bbq()
	return Global.dlc_manager.all_dlc_data.bbq and Global.dlc_manager.all_dlc_data.bbq.verified
end

function GenericDLCManager:has_west()
	return Global.dlc_manager.all_dlc_data.west and Global.dlc_manager.all_dlc_data.west.verified
end

function GenericDLCManager:has_arena()
	return Global.dlc_manager.all_dlc_data.arena and Global.dlc_manager.all_dlc_data.arena.verified
end

function GenericDLCManager:has_character_pack_sokol()
	return Global.dlc_manager.all_dlc_data.character_pack_sokol and Global.dlc_manager.all_dlc_data.character_pack_sokol.verified
end

function GenericDLCManager:has_kenaz()
	return Global.dlc_manager.all_dlc_data.kenaz and Global.dlc_manager.all_dlc_data.kenaz.verified
end

function GenericDLCManager:has_turtles()
	return Global.dlc_manager.all_dlc_data.turtles and Global.dlc_manager.all_dlc_data.turtles.verified
end

function GenericDLCManager:has_dragon()
	return Global.dlc_manager.all_dlc_data.dragon and Global.dlc_manager.all_dlc_data.dragon.verified
end

function GenericDLCManager:has_xmas_soundtrack()
	return Global.dlc_manager.all_dlc_data.xmas_soundtrack and Global.dlc_manager.all_dlc_data.xmas_soundtrack.verified
end

function GenericDLCManager:has_bsides_soundtrack()
	return Global.dlc_manager.all_dlc_data.bsides_soundtrack and Global.dlc_manager.all_dlc_data.bsides_soundtrack.verified
end

function GenericDLCManager:has_twitch_pack()
	return Global.dlc_manager.all_dlc_data.twitch_pack and Global.dlc_manager.all_dlc_data.twitch_pack.verified
end

function GenericDLCManager:has_humble_pack2()
	return Global.dlc_manager.all_dlc_data.humble_pack2 and Global.dlc_manager.all_dlc_data.humble_pack2.verified
end

function GenericDLCManager:has_humble_pack3()
	return Global.dlc_manager.all_dlc_data.humble_pack3 and Global.dlc_manager.all_dlc_data.humble_pack3.verified
end

function GenericDLCManager:has_humble_pack4()
	return Global.dlc_manager.all_dlc_data.humble_pack4 and Global.dlc_manager.all_dlc_data.humble_pack4.verified
end

function GenericDLCManager:has_e3_s15a()
	return Global.dlc_manager.all_dlc_data.e3_s15a and Global.dlc_manager.all_dlc_data.e3_s15a.verified
end

function GenericDLCManager:has_e3_s15b()
	return Global.dlc_manager.all_dlc_data.e3_s15b and Global.dlc_manager.all_dlc_data.e3_s15b.verified
end

function GenericDLCManager:has_e3_s15c()
	return Global.dlc_manager.all_dlc_data.e3_s15c and Global.dlc_manager.all_dlc_data.e3_s15c.verified
end

function GenericDLCManager:has_e3_s15d()
	return Global.dlc_manager.all_dlc_data.e3_s15d and Global.dlc_manager.all_dlc_data.e3_s15d.verified
end

function GenericDLCManager:has_gage_pack_historical()
	return Global.dlc_manager.all_dlc_data.gage_pack_historical and Global.dlc_manager.all_dlc_data.gage_pack_historical.verified
end

function GenericDLCManager:has_steel()
	return Global.dlc_manager.all_dlc_data.steel and Global.dlc_manager.all_dlc_data.steel.verified
end

function GenericDLCManager:has_bobblehead()
	return Global.dlc_manager.all_dlc_data.bobblehead and Global.dlc_manager.all_dlc_data.bobblehead.verified
end

function GenericDLCManager:has_pdcon_2015()
	return Global.dlc_manager.all_dlc_data.pdcon_2015 and Global.dlc_manager.all_dlc_data.pdcon_2015.verified
end

function GenericDLCManager:has_achievement(data)
	local achievement = managers.achievment and data and data.achievement_id and managers.achievment:get_info(data.achievement_id)
	return achievement and achievement.awarded or false
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
				product_id = self.SERVICE_ID .. "-PAYDAY2NPEU00000"
			},
			preorder = {
				filename = "preorder_dlc_key.edat",
				product_id = self.SERVICE_ID .. "-PPAYDAY2XX000006"
			},
			sweettooth = {
				filename = "sweettooth_dlc_key.edat",
				product_id = self.SERVICE_ID .. "-PPAYDAY2SWTTOOTH"
			},
			armored_transport = {
				filename = "armored_transport_dlc_key.edat",
				product_id = self.SERVICE_ID .. "-PPAYDAY2ARMORDTR"
			},
			gage_pack = {
				filename = "gagepack_1_dlc_key.edat",
				product_id = self.SERVICE_ID .. "-PPAYDAY2GAGEPAK1"
			},
			gage_pack_lmg = {
				filename = "gagepack_2_dlc_key.edat",
				product_id = self.SERVICE_ID .. "-PPAYDAY2GAGEPAK2"
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
	print("[X360DLCManager:_verify_dlcs] found DLC:")
	for i, k in pairs(found_dlc) do
		print(i, k)
	end
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if found_dlc[dlc_data.index] == "corrupt" then
			print("[X360DLCManager:_verify_dlcs] Found corrupt DLC:", dlc_name)
			dlc_data.is_corrupt = true
		elseif dlc_data.is_default or found_dlc[dlc_data.index] == true then
			dlc_data.verified = true
		else
			dlc_data.verified = false
		end
	end
	if found_dlc.has_corrupt_data then
		print("[X360DLCManager:_verify_dlcs] Found at least one corrupt DLC.")
		self._has_corrupt_data = true
	end
end

function X360DLCManager:on_signin_complete()
	self:_verify_dlcs()
end

PS4DLCManager = PS4DLCManager or class(GenericDLCManager)
DLCManager.PLATFORM_CLASS_MAP[Idstring("PS4"):key()] = PS4DLCManager
PS4DLCManager.SERVICE_ID = "EP4040-BLES01902_00"

function PS4DLCManager:init()
	PS4DLCManager.super.init(self)
	if not Global.dlc_manager then
		Global.dlc_manager = {}
		Global.dlc_manager.all_dlc_data = {
			full_game = {
				filename = "full_game_key.edat",
				app_id = "218620",
				verified = true
			},
			preorder = {
				filename = "preorder.edat",
				app_id = "247450",
				product_id = "PAYDAYLOOTBAGDLC",
				no_install = true
			},
			career_criminal_edition = {
				filename = "career_criminal_edition.edat",
				app_id = "218630",
				verified = true,
				no_install = true
			},
			alienware_alpha = {
				filename = "alienware_alpha.edat",
				app_id = "328861",
				verified = true,
				no_install = true
			},
			alienware_alpha_promo = {
				filename = "alienware_alpha_promo.edat",
				app_id = "318720",
				verified = true,
				no_install = true
			},
			soundtrack = {
				filename = "soundtrack.edat",
				app_id = "254260",
				verified = true,
				no_install = true
			},
			pdth_soundtrack = {
				filename = "pdth_soundtrack.edat",
				app_id = "207816",
				verified = true,
				no_install = true
			},
			armored_transport = {
				filename = "armored_transport.edat",
				app_id = "264610",
				verified = true,
				no_install = true
			},
			gage_pack = {
				filename = "gage_pack.edat",
				app_id = "267380",
				verified = true,
				no_install = true
			},
			gage_pack_lmg = {
				filename = "gage_pack_lmg.edat",
				app_id = "275590",
				verified = true,
				no_install = true
			},
			gage_pack_jobs = {
				filename = "gage_pack_jobs.edat",
				app_id = "259381",
				verified = true,
				no_install = true
			},
			gage_pack_snp = {
				filename = "gage_pack_snp.edat",
				app_id = "259380",
				verified = true,
				no_install = true
			},
			gage_pack_shotgun = {
				filename = "gage_pack_shotgun.edat",
				app_id = "311050",
				verified = true,
				no_install = true
			},
			gage_pack_assault = {
				filename = "gage_pack_assault.edat",
				app_id = "320030",
				verified = true,
				no_install = true
			},
			big_bank = {
				filename = "big_bank.edat",
				app_id = "306690",
				verified = true,
				no_install = true
			},
			hl_miami = {
				filename = "hi_miami.edat",
				app_id = "323500",
				verified = true,
				no_install = true
			},
			hlm_game = {
				filename = "hlm_game.edat",
				app_id = "219150",
				no_install = true,
				verified = true,
				external = true
			},
			character_pack_clover = {
				filename = "character_pack_clover.edat",
				app_id = "337661",
				verified = true,
				no_install = true
			},
			character_pack_dragan = {
				filename = "character_pack_dragan.edat",
				app_id = "344140",
				verified = true,
				no_install = true
			},
			hope_diamond = {
				filename = "hope_diamond.edat",
				app_id = "337660",
				verified = true,
				no_install = true
			},
			the_bomb = {
				filename = "the_bomb.edat",
				app_id = "339480",
				verified = true,
				no_install = true
			},
			xmas_soundtrack = {
				filename = "xmas_soundtrack.edat",
				app_id = "267381",
				verified = true,
				no_install = true
			},
			twitch_pack = {
				filename = "twitch_pack.edat",
				app_id = "306110",
				verified = true,
				no_install = true
			},
			humble_pack2 = {
				filename = "humble_pack2.edat",
				app_id = "331040",
				verified = true,
				no_install = true
			},
			gage_pack_historical = {
				filename = "gage_pack_historical.edat",
				app_id = "331900",
				verified = true,
				no_install = true
			},
			pd2_clan = {
				filename = "pd2_clan.edat",
				verified = true,
				source_id = "103582791433980119"
			}
		}
		self:_verify_dlcs()
	end
end

function PS4DLCManager:_verify_dlcs()
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if dlc_data.is_default or dlc_data.verified == true then
			dlc_data.verified = true
		else
			dlc_data.verified = PS3:has_entitlement(dlc_data.product_id)
		end
	end
end

function PS4DLCManager:_init_NPCommerce()
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

function PS4DLCManager:buy_full_game()
	print("[PS4DLCManager:buy_full_game]")
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

function PS4DLCManager:buy_product(product_name)
	print("[PS4DLCManager:buy_product]", product_name)
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

function PS4DLCManager:cb_NPCommerce(result, info)
	print("[PS4DLCManager:cb_NPCommerce]", result, info)
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
	print("/[PS4DLCManager:cb_NPCommerce]")
end

function PS4DLCManager:_close_NPCommerce()
	print("[PS4DLCManager:_close_NPCommerce]")
	NPCommerce:destroy()
end

function PS4DLCManager:cb_confirm_purchase_yes(sku_data)
	NPCommerce:checkout(sku_data.skuid)
end

function PS4DLCManager:cb_confirm_purchase_no()
	self._activity = nil
	self:_close_NPCommerce()
end

XB1DLCManager = XB1DLCManager or class(GenericDLCManager)
DLCManager.PLATFORM_CLASS_MAP[Idstring("XB1"):key()] = XB1DLCManager

function XB1DLCManager:init()
	XB1DLCManager.super.init(self)
	if not Global.dlc_manager then
		Global.dlc_manager = {}
		Global.dlc_manager.all_dlc_data = {
			preorder = {
				index = 1,
				is_default = false,
				product_id = "f4bfed8e-a74c-4bd5-baad-5b985d0ef15d",
				no_install = true
			},
			full_game = {
				index = 0,
				is_default = true,
				verified = true
			},
			career_criminal_edition = {
				index = 2,
				is_default = true,
				no_install = true
			},
			alienware_alpha = {
				index = 3,
				is_default = true,
				no_install = true
			},
			alienware_alpha_promo = {
				index = 4,
				is_default = true,
				no_install = true
			},
			soundtrack = {
				index = 5,
				is_default = true,
				no_install = true
			},
			pdth_soundtrack = {
				index = 6,
				is_default = true,
				no_install = true
			},
			armored_transport = {
				index = 7,
				is_default = true,
				no_install = true
			},
			gage_pack = {
				index = 8,
				is_default = true,
				no_install = true
			},
			gage_pack_lmg = {
				index = 9,
				is_default = true,
				no_install = true
			},
			gage_pack_jobs = {
				index = 10,
				is_default = true,
				no_install = true
			},
			gage_pack_snp = {
				index = 11,
				is_default = true,
				no_install = true
			},
			gage_pack_shotgun = {
				index = 12,
				is_default = true,
				no_install = true
			},
			gage_pack_assault = {
				index = 13,
				is_default = true,
				no_install = true
			},
			big_bank = {
				index = 14,
				is_default = true,
				no_install = true
			},
			hl_miami = {
				index = 15,
				is_default = true,
				no_install = true
			},
			hlm_game = {
				index = 16,
				is_default = true,
				external = true
			},
			character_pack_clover = {
				index = 17,
				is_default = true,
				no_install = true
			},
			character_pack_dragan = {
				index = 18,
				is_default = true,
				no_install = true
			},
			hope_diamond = {
				index = 19,
				is_default = true,
				no_install = true
			},
			the_bomb = {
				index = 20,
				is_default = true,
				no_install = true
			},
			xmas_soundtrack = {
				index = 21,
				is_default = true,
				no_install = true
			},
			twitch_pack = {
				index = 22,
				is_default = true,
				no_install = true
			},
			humble_pack2 = {
				index = 23,
				is_default = true,
				no_install = true
			},
			gage_pack_historical = {
				index = 24,
				is_default = true,
				no_install = true
			},
			pd2_clan = {
				index = 25,
				is_default = true,
				no_install = true
			}
		}
		self:_verify_dlcs()
	end
end

function XB1DLCManager:_verify_dlcs()
	local dlc_content_updated = false
	local old_verified
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		old_verified = dlc_data.verified or false
		if dlc_data.is_default then
			dlc_data.verified = true
		else
			dlc_data.verified = XboxLive:check_dlc(dlc_data.product_id)
		end
		dlc_content_updated = dlc_content_updated or old_verified ~= dlc_data.verified
	end
	return dlc_content_updated
end

function XB1DLCManager:chk_content_updated()
	print("[XB1DLCManager:chk_content_updated]")
	if not managers.blackmarket:currently_customizing_mask() and self:_verify_dlcs() then
		print("[XB1DLCManager:chk_content_updated] content updated")
		if managers.experience and managers.upgrades then
			for level = 1, managers.experience:current_level() do
				managers.upgrades:aquire_from_level_tree(level, true)
				managers.upgrades:verify_level_tree(level, true)
			end
		end
		self:give_dlc_and_verify_blackmarket()
		if managers.crimenet then
			managers.crimenet:reset_seed()
		end
	end
end

function XB1DLCManager:on_signin_complete()
	self:chk_content_updated()
end

WINDLCManager = WINDLCManager or class(GenericDLCManager)
DLCManager.PLATFORM_CLASS_MAP[Idstring("WIN32"):key()] = WINDLCManager

function WINDLCManager:init()
	WINDLCManager.super.init(self)
	if not Global.dlc_manager then
		Global.dlc_manager = {}
		Global.dlc_manager.all_dlc_data = {
			full_game = {app_id = "218620", verified = true},
			preorder = {app_id = "247450", no_install = true},
			career_criminal_edition = {app_id = "218630", no_install = true},
			alienware_alpha = {app_id = "328861", no_install = true},
			alienware_alpha_promo = {app_id = "318720", no_install = true},
			soundtrack = {app_id = "254260", no_install = true},
			pdth_soundtrack = {app_id = "207816", no_install = true},
			armored_transport = {app_id = "264610", no_install = true},
			gage_pack = {app_id = "267380", no_install = true},
			gage_pack_lmg = {app_id = "275590", no_install = true},
			gage_pack_jobs = {app_id = "259381", no_install = true},
			gage_pack_snp = {app_id = "259380", no_install = true},
			gage_pack_shotgun = {app_id = "311050", no_install = true},
			gage_pack_assault = {app_id = "320030", no_install = true},
			overkill_pack = {app_id = "348090", no_install = true},
			complete_overkill_pack = {app_id = "348091", no_install = true},
			akm4_pack = {app_id = "351890", no_install = true},
			big_bank = {app_id = "306690", no_install = true},
			hl_miami = {app_id = "323500", no_install = true},
			hlm_game = {
				app_id = "219150",
				no_install = true,
				external = true
			},
			hlm2 = {
				app_id = "274170",
				no_install = true,
				external = true
			},
			hlm2_deluxe = {
				app_id = "355390",
				no_install = true,
				external = true
			},
			hlm2_aus = {
				app_id = "338951",
				no_install = true,
				external = true
			},
			speedrunners = {
				app_id = "207140",
				no_install = true,
				external = true
			},
			character_pack_clover = {app_id = "337661", no_install = true},
			character_pack_dragan = {app_id = "344140", no_install = true},
			character_pack_sokol = {app_id = "374301", no_install = true},
			hope_diamond = {app_id = "337660", no_install = true},
			the_bomb = {app_id = "339480", no_install = true},
			bbq = {app_id = "358150", no_install = true},
			west = {app_id = "349830", no_install = true},
			arena = {app_id = "366660", no_install = true},
			kenaz = {app_id = "374300", no_install = true},
			turtles = {app_id = "384021", no_install = true},
			dragon = {app_id = "384020", no_install = true},
			xmas_soundtrack = {app_id = "267381", no_install = true},
			bsides_soundtrack = {app_id = "368870", no_install = true},
			twitch_pack = {app_id = "306110", no_install = true},
			humble_pack2 = {app_id = "331040", no_install = true},
			humble_pack3 = {app_id = "375380", no_install = true},
			humble_pack4 = {app_id = "375381", no_install = true},
			e3_s15a = {app_id = "375382", no_install = true},
			e3_s15b = {app_id = "375383", no_install = true},
			e3_s15c = {app_id = "375384", no_install = true},
			e3_s15d = {app_id = "375385", no_install = true},
			pdcon_2015 = {app_id = "338950", no_install = true},
			gage_pack_historical = {app_id = "331900", no_install = true},
			steel = {app_id = "401650", no_install = true},
			bobblehead = {app_id = "328860", no_install = true},
			pd2_clan = {
				source_id = "103582791433980119"
			}
		}
		self:_verify_dlcs()
	end
end

function WINDLCManager:_check_dlc_data(dlc_data)
	if dlc_data.app_id then
		if dlc_data.no_install then
			if Steam:is_product_owned(dlc_data.app_id) then
				return true
			end
		elseif Steam:is_product_installed(dlc_data.app_id) then
			return true
		end
	elseif dlc_data.source_id and Steam:is_user_in_source(Steam:userid(), dlc_data.source_id) then
		return true
	end
end

function WINDLCManager:_verify_dlcs()
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if not dlc_data.verified and self:_check_dlc_data(dlc_data) then
			dlc_data.verified = true
		end
	end
end

function WINDLCManager:chk_content_updated()
	for dlc_name, dlc_data in pairs(Global.dlc_manager.all_dlc_data) do
		if not dlc_data.verified and self:_check_dlc_data(dlc_data) then
			managers.menu:show_dlc_require_restart()
			break
		end
	end
end
