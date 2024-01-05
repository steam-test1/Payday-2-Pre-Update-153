BlackMarketTweakData = BlackMarketTweakData or class()

function BlackMarketTweakData:init(tweak_data)
	self:_init_colors()
	self:_init_materials()
	self:_init_textures()
	self:_init_masks()
	self:_init_characters()
	self:_init_cash()
	self:_init_xp()
	self:_init_weapon_mods(tweak_data)
	self:_init_armors()
	self:_init_deployables(tweak_data)
	self:_init_grenades()
end

function BlackMarketTweakData:print_missing_strings(skip_print_id)
	if Application:production_build() then
		local ignore_name = {"xp", "cash"}
		local ignore_desc = {
			"xp",
			"cash",
			"weapon_mods"
		}
		for id, data in pairs(self) do
			for i, d in pairs(data) do
				if id ~= "weapon_mods" or tweak_data.weapon.factory.parts[i].pc or tweak_data.weapon.factory.parts[i].pcs then
					local name_id = d.name_id
					if not table.contains(ignore_name, id) and name_id and not managers.localization:exists(name_id) then
						if skip_print_id then
							Application:debug(name_id)
						else
							Application:debug(name_id, "", "", id)
						end
					end
					local desc_id = d.desc_id
					if not table.contains(ignore_desc, id) and desc_id and not managers.localization:exists(desc_id) then
						if skip_print_id then
							Application:debug(desc_id)
						else
							Application:debug(desc_id, "", "", id)
						end
					end
				end
			end
		end
	end
end

function BlackMarketTweakData:_add_desc_from_name_macro(tweak_data)
	for id, data in pairs(tweak_data) do
		if data.name_id and not data.desc_id then
			data.desc_id = tostring(data.name_id) .. "_desc"
		end
		if not data.name_id then
		end
	end
end

function BlackMarketTweakData:_init_weapon_mods(tweak_data)
	self.weapon_mods = {}
	for id, data in pairs(tweak_data.weapon.factory.parts) do
		self.weapon_mods[id] = {
			max_in_inventory = 2,
			pc = data.pc,
			pcs = data.pcs,
			dlc = data.dlc,
			dlcs = data.dlcs,
			name_id = data.name_id,
			desc_id = data.desc_id,
			infamous = data.infamous,
			value = data.stats and data.stats.value or 1,
			weight = data.weight,
			texture_bundle_folder = data.texture_bundle_folder
		}
	end
	self:_add_desc_from_name_macro(self.weapon_mods)
	if Application:production_build() and managers.lootdrop then
		managers.lootdrop:add_qlvl_to_weapon_mods(self.weapon_mods)
	end
end

function BlackMarketTweakData:_init_masks()
	self.masks = {}
	self.masks.character_locked = {}
	self.masks.character_locked.name_id = "bm_msk_character_locked"
	self.masks.character_locked.dallas = "units/payday2/masks/msk_dallas/msk_dallas"
	self.masks.character_locked.wolf = "units/payday2/masks/msk_wolf/msk_wolf"
	self.masks.character_locked.hoxton = "units/payday2/masks/msk_hoxton/msk_hoxton"
	self.masks.character_locked.chains = "units/payday2/masks/msk_chains/msk_chains"
	self.masks.character_locked.statistics = true
	self.masks.skull = {}
	self.masks.skull.unit = "units/payday2/masks/msk_skull/msk_skull"
	self.masks.skull.name_id = "bm_msk_skull"
	self.masks.skull.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.skull.dlc = "preorder"
	self.masks.skull.value = 1
	self.masks.skull.statistics = true
	self.masks.wolf_clean = {}
	self.masks.wolf_clean.unit = "units/payday2/masks/msk_wolf_clean/msk_wolf_clean"
	self.masks.wolf_clean.name_id = "bm_msk_wolf_clean"
	self.masks.wolf_clean.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.wolf_clean.infamous = true
	self.masks.wolf_clean.value = 9
	self.masks.wolf_clean.qlvl = 0
	self.masks.wolf_clean.statistics = true
	self.masks.hoxton_clean = {}
	self.masks.hoxton_clean.unit = "units/payday2/masks/msk_hoxton_clean/msk_hoxton_clean"
	self.masks.hoxton_clean.name_id = "bm_msk_hoxton_clean"
	self.masks.hoxton_clean.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.hoxton_clean.infamous = true
	self.masks.hoxton_clean.value = 9
	self.masks.hoxton_clean.qlvl = 0
	self.masks.hoxton_clean.statistics = true
	self.masks.dallas_clean = {}
	self.masks.dallas_clean.unit = "units/payday2/masks/msk_dallas_clean/msk_dallas_clean"
	self.masks.dallas_clean.name_id = "bm_msk_dallas_clean"
	self.masks.dallas_clean.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.dallas_clean.infamous = true
	self.masks.dallas_clean.value = 10
	self.masks.dallas_clean.qlvl = 0
	self.masks.dallas_clean.statistics = true
	self.masks.chains_clean = {}
	self.masks.chains_clean.unit = "units/payday2/masks/msk_chains_clean/msk_chains_clean"
	self.masks.chains_clean.name_id = "bm_msk_chains_clean"
	self.masks.chains_clean.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.chains_clean.infamous = true
	self.masks.chains_clean.value = 9
	self.masks.chains_clean.qlvl = 0
	self.masks.chains_clean.statistics = true
	self.masks.dallas = {}
	self.masks.dallas.unit = "units/payday2/masks/msk_dallas/msk_dallas"
	self.masks.dallas.name_id = "bm_msk_dallas"
	self.masks.dallas.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.dallas.infamous = true
	self.masks.dallas.value = 7
	self.masks.dallas.statistics = true
	self.masks.hoxton = {}
	self.masks.hoxton.unit = "units/payday2/masks/msk_hoxton/msk_hoxton"
	self.masks.hoxton.name_id = "bm_msk_hoxton"
	self.masks.hoxton.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.hoxton.infamous = true
	self.masks.hoxton.value = 7
	self.masks.hoxton.statistics = true
	self.masks.chains = {}
	self.masks.chains.unit = "units/payday2/masks/msk_chains/msk_chains"
	self.masks.chains.name_id = "bm_msk_chains"
	self.masks.chains.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.chains.infamous = true
	self.masks.chains.value = 7
	self.masks.chains.statistics = true
	self.masks.wolf = {}
	self.masks.wolf.unit = "units/payday2/masks/msk_wolf/msk_wolf"
	self.masks.wolf.name_id = "bm_msk_wolf"
	self.masks.wolf.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.wolf.infamous = true
	self.masks.wolf.value = 7
	self.masks.wolf.statistics = true
	self.masks.cthulhu = {}
	self.masks.cthulhu.unit = "units/payday2/masks/msk_cthulhu/msk_cthulhu"
	self.masks.cthulhu.name_id = "bm_msk_cthulhu"
	self.masks.cthulhu.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.cthulhu.infamous = true
	self.masks.cthulhu.value = 8
	self.masks.cthulhu.qlvl = 0
	self.masks.cthulhu.statistics = true
	self.masks.grin = {}
	self.masks.grin.unit = "units/payday2/masks/msk_grin/msk_grin"
	self.masks.grin.name_id = "bm_msk_grin"
	self.masks.grin.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.grin.infamous = true
	self.masks.grin.value = 8
	self.masks.grin.qlvl = 0
	self.masks.grin.statistics = true
	self.masks.anonymous = {}
	self.masks.anonymous.unit = "units/payday2/masks/msk_anonymous/msk_anonymous"
	self.masks.anonymous.name_id = "bm_msk_anonymous"
	self.masks.anonymous.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.anonymous.infamous = true
	self.masks.anonymous.value = 6
	self.masks.anonymous.qlvl = 0
	self.masks.anonymous.statistics = true
	self.masks.dillinger_death_mask = {}
	self.masks.dillinger_death_mask.unit = "units/payday2/masks/msk_dillinger_death_mask/msk_dillinger_death_mask"
	self.masks.dillinger_death_mask.name_id = "bm_msk_dillinger_death_mask"
	self.masks.dillinger_death_mask.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.dillinger_death_mask.infamous = true
	self.masks.dillinger_death_mask.value = 9
	self.masks.dillinger_death_mask.qlvl = 0
	self.masks.dillinger_death_mask.statistics = true
	self.masks.alienware = {}
	self.masks.alienware.unit = "units/payday2/masks/msk_alienware/msk_alienware"
	self.masks.alienware.name_id = "bm_msk_alienware"
	self.masks.alienware.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.alienware.value = 3
	self.masks.alienware.statistics = true
	self.masks.greek_tragedy = {}
	self.masks.greek_tragedy.unit = "units/payday2/masks/msk_greek_tragedy/msk_greek_tragedy"
	self.masks.greek_tragedy.name_id = "bm_msk_greek_tragedy"
	self.masks.greek_tragedy.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.greek_tragedy.value = 7
	self.masks.greek_tragedy.qlvl = 0
	self.masks.greek_tragedy.statistics = true
	self.masks.jaw = {}
	self.masks.jaw.unit = "units/payday2/masks/msk_jaw/msk_jaw"
	self.masks.jaw.name_id = "bm_msk_jaw"
	self.masks.jaw.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.jaw.value = 4
	self.masks.jaw.statistics = true
	self.masks.hockey = {}
	self.masks.hockey.unit = "units/payday2/masks/msk_hockey_a/msk_hockey_a_mask"
	self.masks.hockey.name_id = "bm_msk_hockey"
	self.masks.hockey.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.hockey.value = 5
	self.masks.hockey.statistics = true
	self.masks.troll = {}
	self.masks.troll.unit = "units/payday2/masks/msk_troll/msk_troll"
	self.masks.troll.name_id = "bm_msk_troll"
	self.masks.troll.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.troll.value = 3
	self.masks.troll.statistics = true
	self.masks.gagball = {}
	self.masks.gagball.unit = "units/payday2/masks/msk_gagball/msk_gagball"
	self.masks.gagball.name_id = "bm_msk_gagball"
	self.masks.gagball.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.gagball.value = 4
	self.masks.gagball.statistics = true
	self.masks.tounge = {}
	self.masks.tounge.unit = "units/payday2/masks/msk_tounge/msk_tounge"
	self.masks.tounge.name_id = "bm_msk_tounge"
	self.masks.tounge.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.tounge.value = 2
	self.masks.tounge.statistics = true
	self.masks.zipper = {}
	self.masks.zipper.unit = "units/payday2/masks/msk_zipper/msk_zipper"
	self.masks.zipper.name_id = "bm_msk_zipper"
	self.masks.zipper.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.zipper.value = 5
	self.masks.zipper.statistics = true
	self.masks.biglips = {}
	self.masks.biglips.unit = "units/payday2/masks/msk_biglips/msk_biglips"
	self.masks.biglips.name_id = "bm_msk_biglips"
	self.masks.biglips.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.biglips.value = 3
	self.masks.biglips.statistics = true
	self.masks.clowncry = {}
	self.masks.clowncry.unit = "units/payday2/masks/msk_clowncry/msk_clowncry"
	self.masks.clowncry.name_id = "bm_msk_clowncry"
	self.masks.clowncry.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.clowncry.value = 4
	self.masks.clowncry.statistics = true
	self.masks.mr_sinister = {}
	self.masks.mr_sinister.unit = "units/payday2/masks/msk_mr_sinister/msk_mr_sinister"
	self.masks.mr_sinister.name_id = "bm_msk_mr_sinister"
	self.masks.mr_sinister.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.mr_sinister.value = 5
	self.masks.mr_sinister.statistics = true
	self.masks.clown_56 = {}
	self.masks.clown_56.unit = "units/payday2/masks/msk_clown_56/msk_clown_56"
	self.masks.clown_56.name_id = "bm_msk_clown_56"
	self.masks.clown_56.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.clown_56.value = 3
	self.masks.clown_56.statistics = true
	self.masks.dripper = {}
	self.masks.dripper.unit = "units/payday2/masks/msk_dripper/msk_dripper"
	self.masks.dripper.name_id = "bm_msk_dripper"
	self.masks.dripper.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.dripper.value = 8
	self.masks.dripper.qlvl = 0
	self.masks.dripper.statistics = true
	self.masks.buha = {}
	self.masks.buha.unit = "units/payday2/masks/msk_buha/msk_buha"
	self.masks.buha.name_id = "bm_msk_buha"
	self.masks.buha.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.buha.value = 5
	self.masks.buha.statistics = true
	self.masks.shogun = {}
	self.masks.shogun.unit = "units/payday2/masks/msk_shogun/msk_shogun"
	self.masks.shogun.name_id = "bm_msk_shogun"
	self.masks.shogun.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.shogun.value = 6
	self.masks.shogun.statistics = true
	self.masks.oni = {}
	self.masks.oni.unit = "units/payday2/masks/msk_oni/msk_oni"
	self.masks.oni.name_id = "bm_msk_oni"
	self.masks.oni.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.oni.value = 4
	self.masks.oni.statistics = true
	self.masks.monkeybiss = {}
	self.masks.monkeybiss.unit = "units/payday2/masks/msk_monkeybiss/msk_monkeybiss"
	self.masks.monkeybiss.name_id = "bm_msk_monkeybiss"
	self.masks.monkeybiss.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.monkeybiss.value = 5
	self.masks.monkeybiss.statistics = true
	self.masks.babyrhino = {}
	self.masks.babyrhino.unit = "units/payday2/masks/msk_babyrhino/msk_babyrhino"
	self.masks.babyrhino.name_id = "bm_msk_babyrhino"
	self.masks.babyrhino.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.babyrhino.value = 3
	self.masks.babyrhino.statistics = true
	self.masks.hog = {}
	self.masks.hog.unit = "units/payday2/masks/msk_hog/msk_hog"
	self.masks.hog.name_id = "bm_msk_hog"
	self.masks.hog.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.hog.value = 3
	self.masks.hog.qlvl = 0
	self.masks.hog.statistics = true
	self.masks.outlandish_a = {}
	self.masks.outlandish_a.unit = "units/payday2/masks/msk_outlandish_a/msk_outlandish_a"
	self.masks.outlandish_a.name_id = "bm_msk_outlandish_a"
	self.masks.outlandish_a.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.outlandish_a.value = 2
	self.masks.outlandish_a.statistics = true
	self.masks.outlandish_b = {}
	self.masks.outlandish_b.unit = "units/payday2/masks/msk_outlandish_b/msk_outlandish_b"
	self.masks.outlandish_b.name_id = "bm_msk_outlandish_b"
	self.masks.outlandish_b.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.outlandish_b.value = 3
	self.masks.outlandish_b.statistics = true
	self.masks.outlandish_c = {}
	self.masks.outlandish_c.unit = "units/payday2/masks/msk_outlandish_c/msk_outlandish_c"
	self.masks.outlandish_c.name_id = "bm_msk_outlandish_c"
	self.masks.outlandish_c.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.outlandish_c.value = 4
	self.masks.outlandish_c.statistics = true
	self.masks.bullet = {}
	self.masks.bullet.unit = "units/payday2/masks/msk_bullet/msk_bullet"
	self.masks.bullet.name_id = "bm_msk_bullet"
	self.masks.bullet.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.bullet.value = 3
	self.masks.bullet.statistics = true
	self.masks.shrunken = {}
	self.masks.shrunken.unit = "units/payday2/masks/msk_shrunken/msk_shrunken"
	self.masks.shrunken.name_id = "bm_msk_shrunken"
	self.masks.shrunken.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.shrunken.value = 3
	self.masks.shrunken.statistics = true
	self.masks.brainiack = {}
	self.masks.brainiack.unit = "units/payday2/masks/msk_brainiack/msk_brainiack"
	self.masks.brainiack.name_id = "bm_msk_brainiack"
	self.masks.brainiack.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.brainiack.value = 6
	self.masks.brainiack.statistics = true
	self.masks.zombie = {}
	self.masks.zombie.unit = "units/payday2/masks/msk_zombie/msk_zombie"
	self.masks.zombie.name_id = "bm_msk_zombie"
	self.masks.zombie.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.zombie.value = 3
	self.masks.zombie.statistics = true
	self.masks.scarecrow = {}
	self.masks.scarecrow.unit = "units/payday2/masks/msk_scarecrow/msk_scarecrow"
	self.masks.scarecrow.name_id = "bm_msk_scarecrow"
	self.masks.scarecrow.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.scarecrow.value = 7
	self.masks.scarecrow.qlvl = 0
	self.masks.scarecrow.statistics = true
	self.masks.mummy = {}
	self.masks.mummy.unit = "units/payday2/masks/msk_mummy/msk_mummy"
	self.masks.mummy.name_id = "bm_msk_mummy"
	self.masks.mummy.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.mummy.value = 3
	self.masks.mummy.statistics = true
	self.masks.vampire = {}
	self.masks.vampire.unit = "units/payday2/masks/msk_vampire/msk_vampire"
	self.masks.vampire.name_id = "bm_msk_vampire"
	self.masks.vampire.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.vampire.value = 2
	self.masks.vampire.statistics = true
	self.masks.day_of_the_dead = {}
	self.masks.day_of_the_dead.unit = "units/payday2/masks/msk_day_of_the_dead/msk_day_of_the_dead"
	self.masks.day_of_the_dead.name_id = "bm_msk_day_of_the_dead"
	self.masks.day_of_the_dead.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.day_of_the_dead.value = 3
	self.masks.day_of_the_dead.qlvl = 0
	self.masks.day_of_the_dead.statistics = true
	self.masks.dawn_of_the_dead = {}
	self.masks.dawn_of_the_dead.unit = "units/payday2/masks/msk_dawn_of_the_dead/msk_dawn_of_the_dead"
	self.masks.dawn_of_the_dead.name_id = "bm_msk_dawn_of_the_dead"
	self.masks.dawn_of_the_dead.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.dawn_of_the_dead.value = 2
	self.masks.dawn_of_the_dead.statistics = true
	self.masks.demon = {}
	self.masks.demon.unit = "units/payday2/masks/msk_demon/msk_demon"
	self.masks.demon.name_id = "bm_msk_demon"
	self.masks.demon.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.demon.value = 10
	self.masks.demon.qlvl = 0
	self.masks.demon.statistics = true
	self.masks.stonekisses = {}
	self.masks.stonekisses.unit = "units/payday2/masks/msk_stonekisses/msk_stonekisses"
	self.masks.stonekisses.name_id = "bm_msk_stonekisses"
	self.masks.stonekisses.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.stonekisses.value = 4
	self.masks.stonekisses.statistics = true
	self.masks.demonictender = {}
	self.masks.demonictender.unit = "units/payday2/masks/msk_demonictender/msk_demonictender"
	self.masks.demonictender.name_id = "bm_msk_demonictender"
	self.masks.demonictender.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.demonictender.value = 3
	self.masks.demonictender.statistics = true
	self.masks.kawaii = {}
	self.masks.kawaii.unit = "units/payday2/masks/msk_kawaii/msk_kawaii"
	self.masks.kawaii.name_id = "bm_msk_kawaii"
	self.masks.kawaii.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.kawaii.value = 3
	self.masks.kawaii.statistics = true
	self.masks.irondoom = {}
	self.masks.irondoom.unit = "units/payday2/masks/msk_irondoom/msk_irondoom"
	self.masks.irondoom.name_id = "bm_msk_irondoom"
	self.masks.irondoom.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.irondoom.value = 3
	self.masks.irondoom.statistics = true
	self.masks.rubber_male = {}
	self.masks.rubber_male.unit = "units/payday2/masks/msk_rubber_male/msk_rubber_male"
	self.masks.rubber_male.name_id = "bm_msk_rubber_male"
	self.masks.rubber_male.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.rubber_male.value = 3
	self.masks.rubber_male.statistics = true
	self.masks.rubber_female = {}
	self.masks.rubber_female.unit = "units/payday2/masks/msk_rubber_female/msk_rubber_female"
	self.masks.rubber_female.name_id = "bm_msk_rubber_female"
	self.masks.rubber_female.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.rubber_female.value = 3
	self.masks.rubber_female.statistics = true
	self.masks.pumpkin_king = {}
	self.masks.pumpkin_king.unit = "units/payday2/masks/msk_pumpkin_king/msk_pumpkin_king"
	self.masks.pumpkin_king.name_id = "bm_msk_pumpkin_king"
	self.masks.pumpkin_king.weight = 1000
	self.masks.pumpkin_king.got_item_weight_mod = 0.01
	self.masks.pumpkin_king.global_value = "halloween"
	self.masks.pumpkin_king.value = 5
	self.masks.pumpkin_king.qlvl = 0
	self.masks.pumpkin_king.statistics = true
	self.masks.witch = {}
	self.masks.witch.unit = "units/payday2/masks/msk_witch/msk_witch"
	self.masks.witch.name_id = "bm_msk_witch"
	self.masks.witch.weight = 1000
	self.masks.witch.got_item_weight_mod = 0.01
	self.masks.witch.global_value = "halloween"
	self.masks.witch.value = 5
	self.masks.witch.qlvl = 0
	self.masks.witch.statistics = true
	self.masks.venomorph = {}
	self.masks.venomorph.unit = "units/payday2/masks/msk_venomorph/msk_venomorph"
	self.masks.venomorph.name_id = "bm_msk_venomorph"
	self.masks.venomorph.weight = 1000
	self.masks.venomorph.got_item_weight_mod = 0.01
	self.masks.venomorph.global_value = "halloween"
	self.masks.venomorph.value = 5
	self.masks.venomorph.qlvl = 0
	self.masks.venomorph.statistics = true
	self.masks.frank = {}
	self.masks.frank.unit = "units/payday2/masks/msk_frank/msk_frank"
	self.masks.frank.name_id = "bm_msk_frank"
	self.masks.frank.weight = 1000
	self.masks.frank.got_item_weight_mod = 0.01
	self.masks.frank.global_value = "halloween"
	self.masks.frank.value = 5
	self.masks.frank.qlvl = 0
	self.masks.frank.statistics = true
	self.masks.brazil_baby = {}
	self.masks.brazil_baby.unit = "units/payday2/masks/msk_brazil_baby/msk_brazil_baby"
	self.masks.brazil_baby.name_id = "bm_msk_brazil_baby"
	self.masks.brazil_baby.global_value = "halloween"
	self.masks.brazil_baby.value = 8
	self.masks.brazil_baby.qlvl = 0
	self.masks.brazil_baby.statistics = true
	self.masks.baby_angry = {}
	self.masks.baby_angry.unit = "units/payday2/masks/msk_baby_angry/msk_baby_angry"
	self.masks.baby_angry.name_id = "bm_msk_baby_angry"
	self.masks.baby_angry.global_value = "halloween"
	self.masks.baby_angry.value = 8
	self.masks.baby_angry.qlvl = 0
	self.masks.baby_angry.statistics = true
	self.masks.baby_cry = {}
	self.masks.baby_cry.unit = "units/payday2/masks/msk_baby_cry/msk_baby_cry"
	self.masks.baby_cry.name_id = "bm_msk_baby_cry"
	self.masks.baby_cry.global_value = "halloween"
	self.masks.baby_cry.value = 8
	self.masks.baby_cry.qlvl = 0
	self.masks.baby_cry.statistics = true
	self.masks.baby_happy = {}
	self.masks.baby_happy.unit = "units/payday2/masks/msk_baby_happy/msk_baby_happy"
	self.masks.baby_happy.name_id = "bm_msk_baby_happy"
	self.masks.baby_happy.global_value = "halloween"
	self.masks.baby_happy.value = 8
	self.masks.baby_happy.qlvl = 0
	self.masks.baby_happy.statistics = true
	self.masks.heat = {}
	self.masks.heat.unit = "units/pd2_dlc1/masks/msk_hockey_b/msk_hockey_b"
	self.masks.heat.name_id = "bm_msk_heat"
	self.masks.heat.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.heat.value = 6
	self.masks.heat.dlc = "pd2_clan"
	self.masks.heat.statistics = true
	self.masks.bear = {}
	self.masks.bear.unit = "units/payday2/masks/msk_bear/msk_bear"
	self.masks.bear.name_id = "bm_msk_bear"
	self.masks.bear.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.bear.value = 3
	self.masks.bear.qlvl = 0
	self.masks.bear.dlcs = {"pd2_clan"}
	self.masks.bear.statistics = true
	self.masks.clinton = {}
	self.masks.clinton.unit = "units/pd2_dlc1/masks/msk_clinton/msk_clinton"
	self.masks.clinton.name_id = "bm_msk_clinton"
	self.masks.clinton.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.clinton.value = 6
	self.masks.clinton.dlc = "armored_transport"
	self.masks.clinton.texture_bundle_folder = "dlc1"
	self.masks.clinton.statistics = true
	self.masks.bush = {}
	self.masks.bush.unit = "units/pd2_dlc1/masks/msk_bush/msk_bush"
	self.masks.bush.name_id = "bm_msk_bush"
	self.masks.bush.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.bush.value = 6
	self.masks.bush.dlc = "armored_transport"
	self.masks.bush.texture_bundle_folder = "dlc1"
	self.masks.bush.statistics = true
	self.masks.obama = {}
	self.masks.obama.unit = "units/pd2_dlc1/masks/msk_obama/msk_obama"
	self.masks.obama.name_id = "bm_msk_obama"
	self.masks.obama.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.obama.value = 6
	self.masks.obama.dlc = "armored_transport"
	self.masks.obama.texture_bundle_folder = "dlc1"
	self.masks.obama.statistics = true
	self.masks.nixon = {}
	self.masks.nixon.unit = "units/pd2_dlc1/masks/msk_nixon/msk_nixon"
	self.masks.nixon.name_id = "bm_msk_nixon"
	self.masks.nixon.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.nixon.value = 6
	self.masks.nixon.dlc = "armored_transport"
	self.masks.nixon.texture_bundle_folder = "dlc1"
	self.masks.nixon.statistics = true
	self.masks.goat = {}
	self.masks.goat.unit = "units/pd2_dlc_dec5/masks/msk_goat/msk_goat"
	self.masks.goat.name_id = "bm_msk_goat"
	self.masks.goat.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.goat.value = 4
	self.masks.goat.texture_bundle_folder = "gage_pack"
	self.masks.goat.dlc = "gage_pack"
	self.masks.panda = {}
	self.masks.panda.unit = "units/pd2_dlc_dec5/masks/msk_panda/msk_panda"
	self.masks.panda.name_id = "bm_msk_panda"
	self.masks.panda.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.panda.value = 4
	self.masks.panda.texture_bundle_folder = "gage_pack"
	self.masks.panda.dlc = "gage_pack"
	self.masks.pitbull = {}
	self.masks.pitbull.unit = "units/pd2_dlc_dec5/masks/msk_pitbull/msk_pitbull"
	self.masks.pitbull.name_id = "bm_msk_pitbull"
	self.masks.pitbull.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.pitbull.value = 4
	self.masks.pitbull.texture_bundle_folder = "gage_pack"
	self.masks.pitbull.dlc = "gage_pack"
	self.masks.eagle = {}
	self.masks.eagle.unit = "units/pd2_dlc_dec5/masks/msk_eagle/msk_eagle"
	self.masks.eagle.name_id = "bm_msk_eagle"
	self.masks.eagle.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.eagle.value = 4
	self.masks.eagle.qlvl = 0
	self.masks.eagle.texture_bundle_folder = "gage_pack"
	self.masks.eagle.dlc = "gage_pack"
	self.masks.santa_happy = {}
	self.masks.santa_happy.unit = "units/pd2_dlc2/masks/msk_santa_happy/msk_santa_happy"
	self.masks.santa_happy.name_id = "bm_msk_santa_happy"
	self.masks.santa_happy.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.santa_happy.value = 4
	self.masks.santa_happy.dlc = "pd2_clan"
	self.masks.santa_happy.global_value = "pd2_clan"
	if SystemInfo:platform() == Idstring("PS3") then
		self.masks.sweettooth = {}
		self.masks.sweettooth.unit = "units/payday2/masks/msk_sweettooth/msk_sweettooth"
		self.masks.sweettooth.name_id = "bm_msk_sweettooth"
		self.masks.sweettooth.pcs = {
			10,
			20,
			30,
			40
		}
		self.masks.sweettooth.dlc = "sweettooth"
		self.masks.sweettooth.value = 1
	end
	self:_add_desc_from_name_macro(self.masks)
end

function BlackMarketTweakData:_init_characters()
	self.characters = {}
	self.characters.locked = {}
	self.characters.locked.fps_unit = "units/payday2/characters/fps_mover/fps_mover"
	self.characters.locked.npc_unit = "units/payday2/characters/npc_criminals_suit_1/npc_criminals_suit_1"
	self.characters.locked.menu_unit = "units/payday2/characters/npc_criminals_suit_1/npc_criminals_suit_1_menu"
	self.characters.locked.sequence = "var_material_01"
	self.characters.locked.name_id = "bm_character_locked"
	self.characters.locked.dallas = {
		sequence = "var_mtr_dallas"
	}
	self.characters.locked.wolf = {
		sequence = "var_mtr_wolf"
	}
	self.characters.locked.hoxton = {
		sequence = "var_mtr_hoxton"
	}
	self.characters.locked.chains = {
		sequence = "var_mtr_chains"
	}
	self.characters.ai_hoxton = {}
	self.characters.ai_hoxton.npc_unit = "units/payday2/characters/npc_criminals_suit_1/hoxton/npc_criminal_suit_hoxton"
	self.characters.ai_hoxton.sequence = "var_mtr_hoxton"
	self.characters.ai_hoxton.name_id = "bm_character_ai_hoxton"
	self.characters.ai_chains = {}
	self.characters.ai_chains.npc_unit = "units/payday2/characters/npc_criminals_suit_1/chains/npc_criminal_suit_chains"
	self.characters.ai_chains.sequence = "var_mtr_chains"
	self.characters.ai_chains.name_id = "bm_character_ai_chains"
	self.characters.ai_dallas = {}
	self.characters.ai_dallas.npc_unit = "units/payday2/characters/npc_criminals_suit_1/dallas/npc_criminal_suit_dallas"
	self.characters.ai_dallas.sequence = "var_mtr_dallas"
	self.characters.ai_dallas.name_id = "bm_character_ai_dallas"
	self.characters.ai_wolf = {}
	self.characters.ai_wolf.npc_unit = "units/payday2/characters/npc_criminals_suit_1/wolf/npc_criminal_suit_wolf"
	self.characters.ai_wolf.sequence = "var_mtr_wolf"
	self.characters.ai_wolf.name_id = "bm_character_ai_/wolf"
end

function BlackMarketTweakData:_init_colors()
	self.colors = {}
	local white = Color.white
	local black = Color.black
	local red = Color.red
	local green = Color.green
	local blue = Color.blue
	local yellow = Color.yellow
	local magenta = Color(255, 255, 0, 255) / 255
	local cyan = Color(255, 0, 255, 255) / 255
	local light_gray = Color(255, 191, 191, 191) / 255
	local gray = Color(255, 128, 128, 128) / 255
	local dark_gray = Color(255, 64, 64, 64) / 255
	local blood_red = Color(255, 138, 17, 9) / 255
	local orange = Color(255, 255, 94, 15) / 255
	local light_brown = Color(255, 204, 115, 35) / 255
	local bright_yellow = Color(255, 255, 207, 76) / 255
	local lime_green = Color(255, 0, 166, 81) / 255
	local purple = Color(255, 154, 68, 220) / 255
	local pink = Color(255, 255, 122, 230) / 255
	local brown = Color(255, 128, 70, 13) / 255
	local navy_blue = Color(255, 40, 52, 86) / 255
	local matte_blue = Color(255, 56, 97, 168) / 255
	local olive_green = Color(255, 72, 90, 50) / 255
	local gray_blue = Color(255, 12, 68, 84) / 255
	local light_blue = Color(255, 126, 198, 238) / 255
	local bone_white = Color(255, 255, 238, 151) / 255
	local turquoise = Color(255, 0, 209, 157) / 255
	local matte_purple = Color(255, 107, 84, 144) / 255
	local coral_red = Color(255, 213, 36, 53) / 255
	local leaf_green = Color(255, 104, 191, 54) / 255
	local dark_green = Color(255, 7, 61, 9) / 255
	local warm_yellow = Color(255, 250, 157, 7) / 255
	local dark_red = Color(255, 110, 15, 22) / 255
	local cobalt_blue = Color(255, 0, 93, 199) / 255
	local toxic_green = Color(255, 167, 248, 87) / 255
	local nothing = Color(0, 0, 0, 0) / 255
	self.colors.white_solid = {}
	self.colors.white_solid.colors = {white, white}
	self.colors.white_solid.name_id = "bm_clr_white_solid"
	self.colors.white_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_solid.value = 7
	self.colors.black_solid = {}
	self.colors.black_solid.colors = {black, black}
	self.colors.black_solid.name_id = "bm_clr_black_solid"
	self.colors.black_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_solid.infamous = true
	self.colors.black_solid.value = 10
	self.colors.red_solid = {}
	self.colors.red_solid.colors = {red, red}
	self.colors.red_solid.name_id = "bm_clr_red_solid"
	self.colors.red_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_solid.value = 5
	self.colors.blue_solid = {}
	self.colors.blue_solid.colors = {blue, blue}
	self.colors.blue_solid.name_id = "bm_clr_blue_solid"
	self.colors.blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blue_solid.value = 8
	self.colors.green_solid = {}
	self.colors.green_solid.colors = {green, green}
	self.colors.green_solid.name_id = "bm_clr_green_solid"
	self.colors.green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_solid.value = 8
	self.colors.cyan_solid = {}
	self.colors.cyan_solid.colors = {cyan, cyan}
	self.colors.cyan_solid.name_id = "bm_clr_cyan_solid"
	self.colors.cyan_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_solid.value = 8
	self.colors.magenta_solid = {}
	self.colors.magenta_solid.colors = {magenta, magenta}
	self.colors.magenta_solid.name_id = "bm_clr_magenta_solid"
	self.colors.magenta_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.magenta_solid.infamous = true
	self.colors.magenta_solid.value = 7
	self.colors.yellow_solid = {}
	self.colors.yellow_solid.colors = {yellow, yellow}
	self.colors.yellow_solid.name_id = "bm_clr_yellow_solid"
	self.colors.yellow_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_solid.value = 6
	self.colors.light_gray_solid = {}
	self.colors.light_gray_solid.colors = {light_gray, light_gray}
	self.colors.light_gray_solid.name_id = "bm_clr_light_gray_solid"
	self.colors.light_gray_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_solid.value = 7
	self.colors.dark_gray_solid = {}
	self.colors.dark_gray_solid.colors = {dark_gray, dark_gray}
	self.colors.dark_gray_solid.name_id = "bm_clr_dark_gray_solid"
	self.colors.dark_gray_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_gray_solid.infamous = true
	self.colors.dark_gray_solid.value = 8
	self.colors.gray_solid = {}
	self.colors.gray_solid.colors = {gray, gray}
	self.colors.gray_solid.name_id = "bm_clr_gray_solid"
	self.colors.gray_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.gray_solid.value = 6
	self.colors.pink_solid = {}
	self.colors.pink_solid.colors = {pink, pink}
	self.colors.pink_solid.name_id = "bm_clr_pink_solid"
	self.colors.pink_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.pink_solid.infamous = true
	self.colors.pink_solid.value = 7
	self.colors.purple_solid = {}
	self.colors.purple_solid.colors = {purple, purple}
	self.colors.purple_solid.name_id = "bm_clr_purple_solid"
	self.colors.purple_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.purple_solid.value = 8
	self.colors.blood_red_solid = {}
	self.colors.blood_red_solid.colors = {blood_red, blood_red}
	self.colors.blood_red_solid.name_id = "bm_clr_blood_red_solid"
	self.colors.blood_red_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blood_red_solid.infamous = true
	self.colors.blood_red_solid.value = 9
	self.colors.orange_solid = {}
	self.colors.orange_solid.colors = {orange, orange}
	self.colors.orange_solid.name_id = "bm_clr_orange_solid"
	self.colors.orange_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_solid.value = 8
	self.colors.light_brown_solid = {}
	self.colors.light_brown_solid.colors = {light_brown, light_brown}
	self.colors.light_brown_solid.name_id = "bm_clr_light_brown_solid"
	self.colors.light_brown_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_solid.value = 6
	self.colors.brown_solid = {}
	self.colors.brown_solid.colors = {brown, brown}
	self.colors.brown_solid.name_id = "bm_clr_brown_solid"
	self.colors.brown_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.brown_solid.value = 8
	self.colors.navy_blue_solid = {}
	self.colors.navy_blue_solid.colors = {navy_blue, navy_blue}
	self.colors.navy_blue_solid.name_id = "bm_clr_navy_blue_solid"
	self.colors.navy_blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.navy_blue_solid.infamous = true
	self.colors.navy_blue_solid.value = 7
	self.colors.light_blue_solid = {}
	self.colors.light_blue_solid.colors = {light_blue, light_blue}
	self.colors.light_blue_solid.name_id = "bm_clr_light_blue_solid"
	self.colors.light_blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_solid.value = 5
	self.colors.leaf_green_solid = {}
	self.colors.leaf_green_solid.colors = {leaf_green, leaf_green}
	self.colors.leaf_green_solid.name_id = "bm_clr_leaf_green_solid"
	self.colors.leaf_green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.leaf_green_solid.value = 8
	self.colors.warm_yellow_solid = {}
	self.colors.warm_yellow_solid.colors = {warm_yellow, warm_yellow}
	self.colors.warm_yellow_solid.name_id = "bm_clr_warm_yellow_solid"
	self.colors.warm_yellow_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_solid.infamous = true
	self.colors.warm_yellow_solid.value = 6
	self.colors.dark_red_solid = {}
	self.colors.dark_red_solid.colors = {dark_red, dark_red}
	self.colors.dark_red_solid.name_id = "bm_clr_dark_red_solid"
	self.colors.dark_red_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_red_solid.value = 5
	self.colors.dark_green_solid = {}
	self.colors.dark_green_solid.colors = {dark_green, dark_green}
	self.colors.dark_green_solid.name_id = "bm_clr_dark_green_solid"
	self.colors.dark_green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_green_solid.infamous = true
	self.colors.dark_green_solid.value = 6
	self.colors.nothing = {}
	self.colors.nothing.colors = {nothing, nothing}
	self.colors.nothing.name_id = "bm_clr_nothing"
	self.colors.nothing.value = 0
	self.colors.black_white = {}
	self.colors.black_white.colors = {black, white}
	self.colors.black_white.name_id = "bm_clr_black_white"
	self.colors.black_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_white.infamous = true
	self.colors.black_white.value = 3
	self.colors.red_black = {}
	self.colors.red_black.colors = {red, black}
	self.colors.red_black.name_id = "bm_clr_red_black"
	self.colors.red_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_black.dlc = "preorder"
	self.colors.red_black.value = 1
	self.colors.yellow_blue = {}
	self.colors.yellow_blue.colors = {yellow, blue}
	self.colors.yellow_blue.name_id = "bm_clr_yellow_blue"
	self.colors.yellow_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_blue.value = 5
	self.colors.red_blue = {}
	self.colors.red_blue.colors = {red, blue}
	self.colors.red_blue.name_id = "bm_clr_red_blue"
	self.colors.red_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_blue.value = 2
	self.colors.light_gray_dark_gray = {}
	self.colors.light_gray_dark_gray.colors = {light_gray, dark_gray}
	self.colors.light_gray_dark_gray.name_id = "bm_clr_light_gray_dark_gray"
	self.colors.light_gray_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_dark_gray.value = 3
	self.colors.magenta_cyan = {}
	self.colors.magenta_cyan.colors = {magenta, cyan}
	self.colors.magenta_cyan.name_id = "bm_clr_magenta_cyan"
	self.colors.magenta_cyan.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.magenta_cyan.value = 4
	self.colors.green_red = {}
	self.colors.green_red.colors = {green, red}
	self.colors.green_red.name_id = "bm_clr_green_red"
	self.colors.green_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_red.value = 2
	self.colors.orange_blue = {}
	self.colors.orange_blue.colors = {orange, blue}
	self.colors.orange_blue.name_id = "bm_clr_orange_blue"
	self.colors.orange_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_blue.value = 3
	self.colors.green_olive_green = {}
	self.colors.green_olive_green.colors = {green, olive_green}
	self.colors.green_olive_green.name_id = "bm_clr_green_olive_green"
	self.colors.green_olive_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_olive_green.value = 4
	self.colors.yellow_orange = {}
	self.colors.yellow_orange.colors = {yellow, orange}
	self.colors.yellow_orange.name_id = "bm_clr_yellow_orange"
	self.colors.yellow_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_orange.value = 2
	self.colors.light_brown_matte_blue = {}
	self.colors.light_brown_matte_blue.colors = {light_brown, matte_blue}
	self.colors.light_brown_matte_blue.name_id = "bm_clr_light_brown_matte_blue"
	self.colors.light_brown_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_matte_blue.value = 3
	self.colors.turquoise_purple = {}
	self.colors.turquoise_purple.colors = {turquoise, purple}
	self.colors.turquoise_purple.name_id = "bm_clr_turquoise_purple"
	self.colors.turquoise_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.turquoise_purple.value = 2
	self.colors.orange_gray_blue = {}
	self.colors.orange_gray_blue.colors = {orange, gray_blue}
	self.colors.orange_gray_blue.name_id = "bm_clr_orange_gray_blue"
	self.colors.orange_gray_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_gray_blue.value = 4
	self.colors.coral_red_matte_blue = {}
	self.colors.coral_red_matte_blue.colors = {coral_red, matte_blue}
	self.colors.coral_red_matte_blue.name_id = "bm_clr_coral_red_matte_blue"
	self.colors.coral_red_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_matte_blue.value = 3
	self.colors.toxic_green_dark_green = {}
	self.colors.toxic_green_dark_green.colors = {toxic_green, dark_green}
	self.colors.toxic_green_dark_green.name_id = "bm_clr_toxic_green_dark_green"
	self.colors.toxic_green_dark_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.toxic_green_dark_green.value = 4
	self.colors.warm_yellow_matte_purple = {}
	self.colors.warm_yellow_matte_purple.colors = {warm_yellow, matte_purple}
	self.colors.warm_yellow_matte_purple.name_id = "bm_clr_warm_yellow_matte_purple"
	self.colors.warm_yellow_matte_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_matte_purple.value = 3
	self.colors.bright_yellow_brown = {}
	self.colors.bright_yellow_brown.colors = {bright_yellow, brown}
	self.colors.bright_yellow_brown.name_id = "bm_clr_bright_yellow_brown"
	self.colors.bright_yellow_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_brown.value = 2
	self.colors.coral_red_lime_green = {}
	self.colors.coral_red_lime_green.colors = {coral_red, lime_green}
	self.colors.coral_red_lime_green.name_id = "bm_clr_coral_red_lime_green"
	self.colors.coral_red_lime_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_lime_green.value = 3
	self.colors.white_matte_blue = {}
	self.colors.white_matte_blue.colors = {white, matte_blue}
	self.colors.white_matte_blue.name_id = "bm_clr_white_matte_blue"
	self.colors.white_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_matte_blue.value = 4
	self.colors.red_dark_red = {}
	self.colors.red_dark_red.colors = {red, dark_red}
	self.colors.red_dark_red.name_id = "bm_clr_red_dark_red"
	self.colors.red_dark_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_dark_red.value = 2
	self.colors.bone_white_magenta = {}
	self.colors.bone_white_magenta.colors = {bone_white, magenta}
	self.colors.bone_white_magenta.name_id = "bm_clr_bone_white_magenta"
	self.colors.bone_white_magenta.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_magenta.value = 3
	self.colors.cobalt_blue_navy_blue = {}
	self.colors.cobalt_blue_navy_blue.colors = {cobalt_blue, navy_blue}
	self.colors.cobalt_blue_navy_blue.name_id = "bm_clr_cobalt_blue_navy_blue"
	self.colors.cobalt_blue_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cobalt_blue_navy_blue.value = 4
	self.colors.toxic_green_leaf_green = {}
	self.colors.toxic_green_leaf_green.colors = {toxic_green, leaf_green}
	self.colors.toxic_green_leaf_green.name_id = "bm_clr_toxic_green_leaf_green"
	self.colors.toxic_green_leaf_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.toxic_green_leaf_green.value = 2
	self.colors.light_brown_brown = {}
	self.colors.light_brown_brown.colors = {light_brown, brown}
	self.colors.light_brown_brown.name_id = "bm_clr_light_brown_brown"
	self.colors.light_brown_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_brown.value = 3
	self.colors.bright_yellow_turquoise = {}
	self.colors.bright_yellow_turquoise.colors = {bright_yellow, turquoise}
	self.colors.bright_yellow_turquoise.name_id = "bm_clr_bright_yellow_turquoise"
	self.colors.bright_yellow_turquoise.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_turquoise.value = 4
	self.colors.light_blue_gray_blue = {}
	self.colors.light_blue_gray_blue.colors = {light_blue, gray_blue}
	self.colors.light_blue_gray_blue.name_id = "bm_clr_light_blue_gray_blue"
	self.colors.light_blue_gray_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_gray_blue.value = 3
	self.colors.pink_matte_purple = {}
	self.colors.pink_matte_purple.colors = {pink, matte_purple}
	self.colors.pink_matte_purple.name_id = "bm_clr_pink_matte_purple"
	self.colors.pink_matte_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.pink_matte_purple.value = 2
	self.colors.bone_white_purple = {}
	self.colors.bone_white_purple.colors = {bone_white, purple}
	self.colors.bone_white_purple.name_id = "bm_clr_bone_white_purple"
	self.colors.bone_white_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_purple.value = 4
	self.colors.light_blue_cobalt_blue = {}
	self.colors.light_blue_cobalt_blue.colors = {light_blue, cobalt_blue}
	self.colors.light_blue_cobalt_blue.name_id = "bm_clr_light_blue_cobalt_blue"
	self.colors.light_blue_cobalt_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_cobalt_blue.value = 3
	self.colors.coral_red_gray_blue = {}
	self.colors.coral_red_gray_blue.colors = {coral_red, gray_blue}
	self.colors.coral_red_gray_blue.name_id = "bm_clr_coral_red_gray_blue"
	self.colors.coral_red_gray_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_gray_blue.value = 2
	self.colors.leaf_green_blood_red = {}
	self.colors.leaf_green_blood_red.colors = {leaf_green, blood_red}
	self.colors.leaf_green_blood_red.name_id = "bm_clr_leaf_green_blood_red"
	self.colors.leaf_green_blood_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.leaf_green_blood_red.value = 3
	self.colors.cobalt_blue_pink = {}
	self.colors.cobalt_blue_pink.colors = {cobalt_blue, pink}
	self.colors.cobalt_blue_pink.name_id = "bm_clr_cobalt_blue_pink"
	self.colors.cobalt_blue_pink.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cobalt_blue_pink.value = 2
	self.colors.bright_yellow_olive_green = {}
	self.colors.bright_yellow_olive_green.colors = {bright_yellow, olive_green}
	self.colors.bright_yellow_olive_green.name_id = "bm_clr_bright_yellow_olive_green"
	self.colors.bright_yellow_olive_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_olive_green.value = 1
	self.colors.bone_white_light_blue = {}
	self.colors.bone_white_light_blue.colors = {bone_white, light_blue}
	self.colors.bone_white_light_blue.name_id = "bm_clr_bone_white_light_blue"
	self.colors.bone_white_light_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_light_blue.value = 1
	self.colors.coral_red_dark_red = {}
	self.colors.coral_red_dark_red.colors = {coral_red, dark_red}
	self.colors.coral_red_dark_red.name_id = "bm_clr_coral_red_dark_red"
	self.colors.coral_red_dark_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_dark_red.value = 2
	self.colors.turquoise_pink = {}
	self.colors.turquoise_pink.colors = {turquoise, pink}
	self.colors.turquoise_pink.name_id = "bm_clr_turquoise_pink"
	self.colors.turquoise_pink.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.turquoise_pink.value = 1
	self.colors.white_brown = {}
	self.colors.white_brown.colors = {white, brown}
	self.colors.white_brown.name_id = "bm_clr_white_brown"
	self.colors.white_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_brown.value = 1
	self.colors.blue_light_blue = {}
	self.colors.blue_light_blue.colors = {blue, light_blue}
	self.colors.blue_light_blue.name_id = "bm_clr_blue_light_blue"
	self.colors.blue_light_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blue_light_blue.value = 2
	self.colors.toxic_green_matte_purple = {}
	self.colors.toxic_green_matte_purple.colors = {toxic_green, matte_purple}
	self.colors.toxic_green_matte_purple.name_id = "bm_clr_toxic_green_matte_purple"
	self.colors.toxic_green_matte_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.toxic_green_matte_purple.value = 2
	self.colors.orange_matte_blue = {}
	self.colors.orange_matte_blue.colors = {orange, matte_blue}
	self.colors.orange_matte_blue.name_id = "bm_clr_orange_matte_blue"
	self.colors.orange_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_matte_blue.value = 3
	self.colors.warm_yellow_navy_blue = {}
	self.colors.warm_yellow_navy_blue.colors = {warm_yellow, navy_blue}
	self.colors.warm_yellow_navy_blue.name_id = "bm_clr_warm_yellow_navy_blue"
	self.colors.warm_yellow_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_navy_blue.value = 3
	self.colors.bright_yellow_dark_gray = {}
	self.colors.bright_yellow_dark_gray.colors = {bright_yellow, dark_gray}
	self.colors.bright_yellow_dark_gray.name_id = "bm_clr_bright_yellow_dark_gray"
	self.colors.bright_yellow_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_dark_gray.value = 2
	self.colors.white_magenta = {}
	self.colors.white_magenta.colors = {white, magenta}
	self.colors.white_magenta.name_id = "bm_clr_white_magenta"
	self.colors.white_magenta.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_magenta.value = 4
	self.colors.cyan_purple = {}
	self.colors.cyan_purple.colors = {cyan, purple}
	self.colors.cyan_purple.name_id = "bm_clr_cyan_purple"
	self.colors.cyan_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_purple.value = 5
	self.colors.white_black = {}
	self.colors.white_black.colors = {white, black}
	self.colors.white_black.name_id = "bm_clr_white_black"
	self.colors.white_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_black.infamous = true
	self.colors.white_black.value = 3
	self.colors.light_gray_blood_red = {}
	self.colors.light_gray_blood_red.colors = {light_gray, blood_red}
	self.colors.light_gray_blood_red.name_id = "bm_clr_light_gray_blood_red"
	self.colors.light_gray_blood_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_blood_red.value = 6
	self.colors.blood_red_white = {}
	self.colors.blood_red_white.colors = {blood_red, white}
	self.colors.blood_red_white.name_id = "bm_clr_blood_red_white"
	self.colors.blood_red_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blood_red_white.infamous = true
	self.colors.blood_red_white.value = 6
	self.colors.bone_white_navy_blue = {}
	self.colors.bone_white_navy_blue.colors = {bone_white, navy_blue}
	self.colors.bone_white_navy_blue.name_id = "bm_clr_bone_white_navy_blue"
	self.colors.bone_white_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_navy_blue.value = 5
	self.colors.warm_yellow_olive_green = {}
	self.colors.warm_yellow_olive_green.colors = {warm_yellow, olive_green}
	self.colors.warm_yellow_olive_green.name_id = "bm_clr_warm_yellow_olive_green"
	self.colors.warm_yellow_olive_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_olive_green.value = 4
	self.colors.cyan_orange = {}
	self.colors.cyan_orange.colors = {cyan, orange}
	self.colors.cyan_orange.name_id = "bm_clr_cyan_orange"
	self.colors.cyan_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_orange.value = 3
	self.colors.dark_gray_orange = {}
	self.colors.dark_gray_orange.colors = {dark_gray, orange}
	self.colors.dark_gray_orange.name_id = "bm_clr_dark_gray_orange"
	self.colors.dark_gray_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_gray_orange.value = 2
	self.colors.light_brown_navy_blue = {}
	self.colors.light_brown_navy_blue.colors = {light_brown, navy_blue}
	self.colors.light_brown_navy_blue.name_id = "bm_clr_light_brown_navy_blue"
	self.colors.light_brown_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_navy_blue.value = 2
	self.colors.orange_purple = {}
	self.colors.orange_purple.colors = {orange, purple}
	self.colors.orange_purple.name_id = "bm_clr_orange_purple"
	self.colors.orange_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_purple.value = 2
	self.colors.light_blue_brown = {}
	self.colors.light_blue_brown.colors = {light_blue, brown}
	self.colors.light_blue_brown.name_id = "bm_clr_light_blue_brown"
	self.colors.light_blue_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_brown.value = 3
	self.colors.green_blood_red = {}
	self.colors.green_blood_red.colors = {green, blood_red}
	self.colors.green_blood_red.name_id = "bm_clr_green_blood_red"
	self.colors.green_blood_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_blood_red.value = 4
	self.colors.cyan_blue = {}
	self.colors.cyan_blue.colors = {cyan, blue}
	self.colors.cyan_blue.name_id = "bm_clr_cyan_blue"
	self.colors.cyan_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_blue.value = 5
	self.colors.yellow_orange = {}
	self.colors.yellow_orange.colors = {yellow, orange}
	self.colors.yellow_orange.name_id = "bm_clr_yellow_orange"
	self.colors.yellow_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_orange.value = 6
	self.colors.light_gray_dark_gray = {}
	self.colors.light_gray_dark_gray.colors = {light_gray, dark_gray}
	self.colors.light_gray_dark_gray.name_id = "bm_clr_light_gray_dark_gray"
	self.colors.light_gray_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_dark_gray.value = 2
	self.colors.gray_black = {}
	self.colors.gray_black.colors = {gray, black}
	self.colors.gray_black.name_id = "bm_clr_gray_black"
	self.colors.gray_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.gray_black.value = 3
	self.colors.white_dark_gray = {}
	self.colors.white_dark_gray.colors = {white, dark_gray}
	self.colors.white_dark_gray.name_id = "bm_clr_white_dark_gray"
	self.colors.white_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_dark_gray.value = 6
	self.colors.white_brown = {}
	self.colors.white_brown.colors = {white, brown}
	self.colors.white_brown.name_id = "bm_clr_white_brown"
	self.colors.white_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_brown.value = 3
	self.colors.white_navy_blue = {}
	self.colors.white_navy_blue.colors = {white, navy_blue}
	self.colors.white_navy_blue.name_id = "bm_clr_white_navy_blue"
	self.colors.white_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_navy_blue.value = 4
	self.colors.white_purple = {}
	self.colors.white_purple.colors = {white, purple}
	self.colors.white_purple.name_id = "bm_clr_white_purple"
	self.colors.white_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_purple.value = 2
	self.colors.black_coral_red = {}
	self.colors.black_coral_red.colors = {black, coral_red}
	self.colors.black_coral_red.name_id = "bm_clr_black_coral_red"
	self.colors.black_coral_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_coral_red.value = 3
	self.colors.black_orange = {}
	self.colors.black_orange.colors = {black, orange}
	self.colors.black_orange.name_id = "bm_clr_black_orange"
	self.colors.black_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_orange.value = 4
	self.colors.black_cobalt_blue = {}
	self.colors.black_cobalt_blue.colors = {black, cobalt_blue}
	self.colors.black_cobalt_blue.name_id = "bm_clr_black_cobalt_blue"
	self.colors.black_cobalt_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_cobalt_blue.value = 2
	self.colors.black_leaf_green = {}
	self.colors.black_leaf_green.colors = {black, leaf_green}
	self.colors.black_leaf_green.name_id = "bm_clr_black_leaf_green"
	self.colors.black_leaf_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_leaf_green.value = 3
	self.colors.red_white = {}
	self.colors.red_white.colors = {red, white}
	self.colors.red_white.name_id = "bm_clr_red_white"
	self.colors.red_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_white.value = 4
	self.colors.leaf_green_white = {}
	self.colors.leaf_green_white.colors = {leaf_green, white}
	self.colors.leaf_green_white.name_id = "bm_clr_leaf_green_white"
	self.colors.leaf_green_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.leaf_green_white.value = 2
	self.colors.orange_white = {}
	self.colors.orange_white.colors = {orange, white}
	self.colors.orange_white.name_id = "bm_clr_orange_white"
	self.colors.orange_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_white.value = 3
	self.colors.cobalt_blue_white = {}
	self.colors.cobalt_blue_white.colors = {cobalt_blue, white}
	self.colors.cobalt_blue_white.name_id = "bm_clr_cobalt_blue_white"
	self.colors.cobalt_blue_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cobalt_blue_white.value = 4
	self.colors.warm_yellow_white = {}
	self.colors.warm_yellow_white.colors = {warm_yellow, white}
	self.colors.warm_yellow_white.name_id = "bm_clr_warm_yellow_white"
	self.colors.warm_yellow_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_white.value = 3
	self.colors.black_bright_yellow = {}
	self.colors.black_bright_yellow.colors = {black, bright_yellow}
	self.colors.black_bright_yellow.name_id = "bm_clr_black_bright_yellow"
	self.colors.black_bright_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_bright_yellow.value = 2
	self.colors.warm_yellow_bright_yellow = {}
	self.colors.warm_yellow_bright_yellow.colors = {warm_yellow, bright_yellow}
	self.colors.warm_yellow_bright_yellow.name_id = "bm_clr_warm_yellow_bright_yellow"
	self.colors.warm_yellow_bright_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_bright_yellow.value = 3
	self.colors.black_magenta = {}
	self.colors.black_magenta.colors = {black, magenta}
	self.colors.black_magenta.name_id = "bm_clr_black_magenta"
	self.colors.black_magenta.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_magenta.value = 4
	self.colors.navy_blue_light_blue = {}
	self.colors.navy_blue_light_blue.colors = {navy_blue, light_blue}
	self.colors.navy_blue_light_blue.name_id = "bm_clr_navy_blue_light_blue"
	self.colors.navy_blue_light_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.navy_blue_light_blue.value = 2
	self.colors.dark_red_orange = {}
	self.colors.dark_red_orange.colors = {dark_red, orange}
	self.colors.dark_red_orange.name_id = "bm_clr_dark_red_orange"
	self.colors.dark_red_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_red_orange.value = 3
end

function BlackMarketTweakData:_init_materials()
	self.materials = {}
	self.materials.plastic = {}
	self.materials.plastic.name_id = "bm_mtl_plastic"
	self.materials.plastic.texture = "units/payday2/matcaps/matcap_plastic_df"
	self.materials.plastic.value = 0
	self.materials.titanium = {}
	self.materials.titanium.name_id = "bm_mtl_titanium"
	self.materials.titanium.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.titanium.texture = "units/payday2/matcaps/matcap_titanium_df"
	self.materials.titanium.infamous = true
	self.materials.titanium.value = 5
	self.materials.mercury = {}
	self.materials.mercury.name_id = "bm_mtl_mercury"
	self.materials.mercury.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.mercury.texture = "units/payday2/matcaps/matcap_mercury_df"
	self.materials.mercury.value = 3
	self.materials.oxide_bronze = {}
	self.materials.oxide_bronze.name_id = "bm_mtl_oxide_bronze"
	self.materials.oxide_bronze.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.oxide_bronze.texture = "units/payday2/matcaps/matcap_oxide_bronze_df"
	self.materials.oxide_bronze.value = 4
	self.materials.deep_bronze = {}
	self.materials.deep_bronze.name_id = "bm_mtl_deep_bronze"
	self.materials.deep_bronze.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.deep_bronze.texture = "units/payday2/matcaps/matcap_deep_bronze_df"
	self.materials.deep_bronze.infamous = true
	self.materials.deep_bronze.value = 5
	self.materials.slime = {}
	self.materials.slime.name_id = "bm_mtl_slime"
	self.materials.slime.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.slime.texture = "units/payday2/matcaps/matcap_slime_df"
	self.materials.slime.infamous = true
	self.materials.slime.value = 2
	self.materials.gold_clean = {}
	self.materials.gold_clean.name_id = "bm_mtl_gold_clean"
	self.materials.gold_clean.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.gold_clean.texture = "units/payday2/matcaps/matcap_gold_clean_df"
	self.materials.gold_clean.infamous = true
	self.materials.gold_clean.value = 10
	self.materials.concrete1 = {}
	self.materials.concrete1.name_id = "bm_mtl_concrete1"
	self.materials.concrete1.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.concrete1.texture = "units/payday2/matcaps/matcap_concrete1_df"
	self.materials.concrete1.material_amount = 0
	self.materials.concrete1.value = 2
	self.materials.rock1 = {}
	self.materials.rock1.name_id = "bm_mtl_rock1"
	self.materials.rock1.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.rock1.texture = "units/payday2/matcaps/matcap_rock1_df"
	self.materials.rock1.material_amount = 0
	self.materials.rock1.value = 3
	self.materials.rock2 = {}
	self.materials.rock2.name_id = "bm_mtl_rock2"
	self.materials.rock2.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.rock2.texture = "units/payday2/matcaps/matcap_rock2_df"
	self.materials.rock2.material_amount = 0
	self.materials.rock2.value = 2
	self.materials.rock3 = {}
	self.materials.rock3.name_id = "bm_mtl_rock3"
	self.materials.rock3.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.rock3.texture = "units/payday2/matcaps/matcap_rock3_df"
	self.materials.rock3.material_amount = 0
	self.materials.rock3.value = 2
	self.materials.whiterock = {}
	self.materials.whiterock.name_id = "bm_mtl_whiterock"
	self.materials.whiterock.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.whiterock.texture = "units/payday2/matcaps/matcap_whiterock_df"
	self.materials.whiterock.material_amount = 0
	self.materials.whiterock.value = 3
	self.materials.metal1 = {}
	self.materials.metal1.name_id = "bm_mtl_metal1"
	self.materials.metal1.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.metal1.texture = "units/payday2/matcaps/matcap_metal1_df"
	self.materials.metal1.material_amount = 0
	self.materials.metal1.value = 6
	self.materials.cracks1 = {}
	self.materials.cracks1.name_id = "bm_mtl_cracks1"
	self.materials.cracks1.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.cracks1.texture = "units/payday2/matcaps/matcap_cracks1_df"
	self.materials.cracks1.material_amount = 0
	self.materials.cracks1.value = 2
	self.materials.wicker1 = {}
	self.materials.wicker1.name_id = "bm_mtl_wicker1"
	self.materials.wicker1.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.wicker1.texture = "units/payday2/matcaps/matcap_wicker1_df"
	self.materials.wicker1.material_amount = 0
	self.materials.wicker1.value = 3
	self.materials.scales = {}
	self.materials.scales.name_id = "bm_mtl_scales"
	self.materials.scales.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.scales.texture = "units/payday2/matcaps/matcap_scales_df"
	self.materials.scales.infamous = true
	self.materials.scales.material_amount = 0
	self.materials.scales.value = 7
	self.materials.oldbronze = {}
	self.materials.oldbronze.name_id = "bm_mtl_oldbronze"
	self.materials.oldbronze.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.oldbronze.texture = "units/payday2/matcaps/matcap_oldbronze_df"
	self.materials.oldbronze.material_amount = 0
	self.materials.oldbronze.infamous = true
	self.materials.oldbronze.value = 8
	self.materials.bark1 = {}
	self.materials.bark1.name_id = "bm_mtl_bark1"
	self.materials.bark1.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.bark1.texture = "units/payday2/matcaps/matcap_bark1_df"
	self.materials.bark1.material_amount = 0
	self.materials.bark1.value = 4
	self.materials.bark2 = {}
	self.materials.bark2.name_id = "bm_mtl_bark2"
	self.materials.bark2.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.bark2.texture = "units/payday2/matcaps/matcap_bark2_df"
	self.materials.bark2.material_amount = 0
	self.materials.bark2.value = 3
	self.materials.bark3 = {}
	self.materials.bark3.name_id = "bm_mtl_bark3"
	self.materials.bark3.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.bark3.texture = "units/payday2/matcaps/matcap_bark3_df"
	self.materials.bark3.material_amount = 0
	self.materials.bark3.value = 2
	self.materials.carbon = {}
	self.materials.carbon.name_id = "bm_mtl_carbon"
	self.materials.carbon.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.carbon.texture = "units/payday2/matcaps/matcap_carbon_df"
	self.materials.carbon.material_amount = 0
	self.materials.carbon.value = 6
	self.materials.leather = {}
	self.materials.leather.name_id = "bm_mtl_leather1"
	self.materials.leather.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.leather.texture = "units/payday2/matcaps/matcap_leather1_df"
	self.materials.leather.material_amount = 0
	self.materials.leather.value = 6
	self.materials.bloodred = {}
	self.materials.bloodred.name_id = "bm_mtl_bloodred"
	self.materials.bloodred.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.bloodred.texture = "units/payday2/matcaps/matcap_bloodred_df"
	self.materials.bloodred.value = 8
	self.materials.waterblue = {}
	self.materials.waterblue.name_id = "bm_mtl_waterblue"
	self.materials.waterblue.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.waterblue.texture = "units/payday2/matcaps/matcap_waterblue_df"
	self.materials.waterblue.value = 4
	self.materials.matteblack = {}
	self.materials.matteblack.name_id = "bm_mtl_matteblack"
	self.materials.matteblack.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.matteblack.texture = "units/payday2/matcaps/matcap_matteblack_df"
	self.materials.matteblack.value = 9
	self.materials.pianoblack = {}
	self.materials.pianoblack.name_id = "bm_mtl_pianoblack"
	self.materials.pianoblack.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.pianoblack.texture = "units/payday2/matcaps/matcap_pianoblack_df"
	self.materials.pianoblack.infamous = true
	self.materials.pianoblack.value = 10
	self.materials.twoblue = {}
	self.materials.twoblue.name_id = "bm_mtl_twoblue"
	self.materials.twoblue.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.twoblue.texture = "units/payday2/matcaps/matcap_twoblue_df"
	self.materials.twoblue.value = 6
	self.materials.rainbow = {}
	self.materials.rainbow.name_id = "bm_mtl_rainbow"
	self.materials.rainbow.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.rainbow.texture = "units/payday2/matcaps/matcap_rainbow_df"
	self.materials.rainbow.infamous = true
	self.materials.rainbow.value = 3
	self.materials.magma = {}
	self.materials.magma.name_id = "bm_mtl_magma"
	self.materials.magma.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.magma.texture = "units/payday2/matcaps/matcap_magma_df"
	self.materials.magma.value = 6
	self.materials.radioactive = {}
	self.materials.radioactive.name_id = "bm_mtl_radioactive"
	self.materials.radioactive.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.radioactive.texture = "units/payday2/matcaps/matcap_radioactive_df"
	self.materials.radioactive.infamous = true
	self.materials.radioactive.value = 7
	self.materials.bismuth = {}
	self.materials.bismuth.name_id = "bm_mtl_bismuth"
	self.materials.bismuth.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.bismuth.texture = "units/payday2/matcaps/matcap_bismuth_df"
	self.materials.bismuth.value = 3
	self.materials.greygloss = {}
	self.materials.greygloss.name_id = "bm_mtl_greygloss"
	self.materials.greygloss.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.greygloss.texture = "units/payday2/matcaps/matcap_greygloss_df"
	self.materials.greygloss.value = 5
	self.materials.finewood = {}
	self.materials.finewood.name_id = "bm_mtl_finewood"
	self.materials.finewood.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.finewood.texture = "units/payday2/matcaps/matcap_finewood_df"
	self.materials.finewood.material_amount = 0
	self.materials.finewood.value = 8
	self.materials.skin = {}
	self.materials.skin.name_id = "bm_mtl_skin"
	self.materials.skin.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.skin.texture = "units/payday2/matcaps/matcap_skin_df"
	self.materials.skin.material_amount = 0
	self.materials.skin.value = 6
	self.materials.alligator = {}
	self.materials.alligator.name_id = "bm_mtl_alligator"
	self.materials.alligator.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.alligator.texture = "units/payday2/matcaps/matcap_alligator_df"
	self.materials.alligator.material_amount = 0
	self.materials.alligator.value = 6
	self.materials.denim = {}
	self.materials.denim.name_id = "bm_mtl_denim"
	self.materials.denim.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.denim.texture = "units/payday2/matcaps/matcap_denim_df"
	self.materials.denim.material_amount = 0
	self.materials.denim.value = 2
	self.materials.candy = {}
	self.materials.candy.name_id = "bm_mtl_candy"
	self.materials.candy.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.candy.texture = "units/payday2/matcaps/matcap_candy_df"
	self.materials.candy.value = 5
	self.materials.chrome_purple = {}
	self.materials.chrome_purple.name_id = "bm_mtl_chrome_purple"
	self.materials.chrome_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.chrome_purple.texture = "units/payday2/matcaps/matcap_chrome_purple_df"
	self.materials.chrome_purple.value = 5
	self.materials.hot_cold = {}
	self.materials.hot_cold.name_id = "bm_mtl_hot_cold"
	self.materials.hot_cold.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.hot_cold.texture = "units/payday2/matcaps/matcap_hot_cold_df"
	self.materials.hot_cold.value = 5
	self.materials.orchish = {}
	self.materials.orchish.name_id = "bm_mtl_orchish"
	self.materials.orchish.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.orchish.texture = "units/payday2/matcaps/matcap_orcish_df"
	self.materials.orchish.value = 5
	self.materials.cash = {}
	self.materials.cash.name_id = "bm_mtl_cash"
	self.materials.cash.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.cash.texture = "units/pd2_dlc1/matcaps/matcap_cash_df"
	self.materials.cash.material_amount = 0
	self.materials.cash.value = 5
	self.materials.cash.dlc = "armored_transport"
	self.materials.jade = {}
	self.materials.jade.name_id = "bm_mtl_jade"
	self.materials.jade.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.jade.texture = "units/pd2_dlc1/matcaps/matcap_jade_df"
	self.materials.jade.value = 5
	self.materials.jade.dlc = "armored_transport"
	self.materials.redwhiteblue = {}
	self.materials.redwhiteblue.name_id = "bm_mtl_redwhiteblue"
	self.materials.redwhiteblue.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.redwhiteblue.texture = "units/pd2_dlc1/matcaps/matcap_redwhiteblue_df"
	self.materials.redwhiteblue.value = 5
	self.materials.redwhiteblue.dlc = "armored_transport"
	self.materials.marble = {}
	self.materials.marble.name_id = "bm_mtl_marble"
	self.materials.marble.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.marble.texture = "units/pd2_dlc1/matcaps/matcap_marble_df"
	self.materials.marble.value = 5
	self.materials.marble.dlc = "armored_transport"
	self.materials.fur = {}
	self.materials.fur.name_id = "bm_mtl_fur"
	self.materials.fur.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.fur.texture = "units/pd2_dlc_dec5/matcaps/matcap_fur_df"
	self.materials.fur.material_amount = 0
	self.materials.fur.value = 5
	self.materials.fur.dlc = "gage_pack"
	self.materials.galvanized = {}
	self.materials.galvanized.name_id = "bm_mtl_galvanized"
	self.materials.galvanized.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.galvanized.texture = "units/pd2_dlc_dec5/matcaps/matcap_galvanized_df"
	self.materials.galvanized.material_amount = 0
	self.materials.galvanized.value = 5
	self.materials.galvanized.dlc = "gage_pack"
	self.materials.heavymetal = {}
	self.materials.heavymetal.name_id = "bm_mtl_heavymetal"
	self.materials.heavymetal.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.heavymetal.texture = "units/pd2_dlc_dec5/matcaps/matcap_heavymetal_df"
	self.materials.heavymetal.material_amount = 0
	self.materials.heavymetal.value = 5
	self.materials.heavymetal.dlc = "gage_pack"
	self.materials.oilmetal = {}
	self.materials.oilmetal.name_id = "bm_mtl_oilmetal"
	self.materials.oilmetal.pcs = {
		10,
		20,
		30,
		40
	}
	self.materials.oilmetal.texture = "units/pd2_dlc_dec5/matcaps/matcap_oilmetal_df"
	self.materials.oilmetal.value = 5
	self.materials.oilmetal.dlc = "gage_pack"
end

function BlackMarketTweakData:_init_textures()
	self.textures = {}
	self.textures.no_color_no_material = {}
	self.textures.no_color_no_material.name_id = "bm_txt_no_color_no_material"
	self.textures.no_color_no_material.texture = "units/payday2/masks/shared_textures/patterns/pattern_no_color_no_material_df"
	self.textures.no_color_no_material.value = 0
	self.textures.no_color_full_material = {}
	self.textures.no_color_full_material.name_id = "bm_txt_no_color_full_material"
	self.textures.no_color_full_material.texture = "units/payday2/masks/shared_textures/patterns/pattern_no_color_full_material_df"
	self.textures.no_color_full_material.value = 1
	self.textures.big_skull = {}
	self.textures.big_skull.name_id = "bm_txt_big_skull"
	self.textures.big_skull.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.big_skull.texture = "units/payday2/masks/shared_textures/patterns/pattern_big_skull_df"
	self.textures.big_skull.value = 4
	self.textures.eightball = {}
	self.textures.eightball.name_id = "bm_txt_eightball"
	self.textures.eightball.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.eightball.texture = "units/payday2/masks/shared_textures/patterns/pattern_eightball_df"
	self.textures.eightball.value = 8
	self.textures.zebra = {}
	self.textures.zebra.name_id = "bm_txt_zebra"
	self.textures.zebra.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.zebra.texture = "units/payday2/masks/shared_textures/patterns/pattern_zebra_df"
	self.textures.zebra.value = 3
	self.textures.overkill = {}
	self.textures.overkill.name_id = "bm_txt_overkill"
	self.textures.overkill.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.overkill.texture = "units/payday2/masks/shared_textures/patterns/pattern_overkill_df"
	self.textures.overkill.infamous = true
	self.textures.overkill.value = 10
	self.textures.spawn = {}
	self.textures.spawn.name_id = "bm_txt_spawn"
	self.textures.spawn.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.spawn.texture = "units/payday2/masks/shared_textures/patterns/pattern_spawn_df"
	self.textures.spawn.infamous = true
	self.textures.spawn.value = 4
	self.textures.marv = {}
	self.textures.marv.name_id = "bm_txt_marv"
	self.textures.marv.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.marv.texture = "units/payday2/masks/shared_textures/patterns/pattern_marv_df"
	self.textures.marv.value = 5
	self.textures.starbreeze = {}
	self.textures.starbreeze.name_id = "bm_txt_starbreeze"
	self.textures.starbreeze.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.starbreeze.texture = "units/payday2/masks/shared_textures/patterns/pattern_starbreeze_df"
	self.textures.starbreeze.value = 3
	self.textures.cobrakai = {}
	self.textures.cobrakai.name_id = "bm_txt_cobrakai"
	self.textures.cobrakai.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.cobrakai.texture = "units/payday2/masks/shared_textures/patterns/pattern_cobrakai_df"
	self.textures.cobrakai.infamous = true
	self.textures.cobrakai.value = 4
	self.textures.flames = {}
	self.textures.flames.name_id = "bm_txt_flames"
	self.textures.flames.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.flames.texture = "units/payday2/masks/shared_textures/patterns/pattern_flames_df"
	self.textures.flames.value = 6
	self.textures.tribal = {}
	self.textures.tribal.name_id = "bm_txt_tribal"
	self.textures.tribal.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.tribal.texture = "units/payday2/masks/shared_textures/patterns/pattern_tribal_df"
	self.textures.tribal.value = 7
	self.textures.skull = {}
	self.textures.skull.name_id = "bm_txt_skull"
	self.textures.skull.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.skull.texture = "units/payday2/masks/shared_textures/patterns/pattern_skull_df"
	self.textures.skull.value = 8
	self.textures.arrow = {}
	self.textures.arrow.name_id = "bm_txt_arrow"
	self.textures.arrow.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.arrow.texture = "units/payday2/masks/shared_textures/patterns/pattern_arrow_df"
	self.textures.arrow.value = 3
	self.textures.usa = {}
	self.textures.usa.name_id = "bm_txt_usa"
	self.textures.usa.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.usa.texture = "units/payday2/masks/shared_textures/patterns/pattern_usa_df"
	self.textures.usa.value = 5
	self.textures.unionjack = {}
	self.textures.unionjack.name_id = "bm_txt_unionjack"
	self.textures.unionjack.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.unionjack.texture = "units/payday2/masks/shared_textures/patterns/pattern_unionjack_df"
	self.textures.unionjack.value = 6
	self.textures.fleur = {}
	self.textures.fleur.name_id = "bm_txt_fleur"
	self.textures.fleur.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.fleur.texture = "units/payday2/masks/shared_textures/patterns/pattern_fleur_df"
	self.textures.fleur.value = 7
	self.textures.hearts = {}
	self.textures.hearts.name_id = "bm_txt_hearts"
	self.textures.hearts.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hearts.texture = "units/payday2/masks/shared_textures/patterns/pattern_hearts_df"
	self.textures.hearts.value = 4
	self.textures.electric = {}
	self.textures.electric.name_id = "bm_txt_electric"
	self.textures.electric.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.electric.texture = "units/payday2/masks/shared_textures/patterns/pattern_electric_df"
	self.textures.electric.value = 3
	self.textures.electric.infamous = true
	self.textures.puzzle = {}
	self.textures.puzzle.name_id = "bm_txt_puzzle"
	self.textures.puzzle.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.puzzle.texture = "units/payday2/masks/shared_textures/patterns/pattern_puzzle_df"
	self.textures.puzzle.value = 5
	self.textures.swe_camo = {}
	self.textures.swe_camo.name_id = "bm_txt_swe_camo"
	self.textures.swe_camo.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.swe_camo.texture = "units/payday2/masks/shared_textures/patterns/pattern_swe_camo_df"
	self.textures.swe_camo.value = 6
	self.textures.japan = {}
	self.textures.japan.name_id = "bm_txt_japan"
	self.textures.japan.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.japan.texture = "units/payday2/masks/shared_textures/patterns/pattern_japan_df"
	self.textures.japan.value = 7
	self.textures.celtic1 = {}
	self.textures.celtic1.name_id = "bm_txt_celtic1"
	self.textures.celtic1.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.celtic1.texture = "units/payday2/masks/shared_textures/patterns/pattern_celtic1_df"
	self.textures.celtic1.value = 3
	self.textures.dragon_full = {}
	self.textures.dragon_full.name_id = "bm_txt_dragon_full"
	self.textures.dragon_full.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.dragon_full.texture = "units/payday2/masks/shared_textures/patterns/pattern_dragon_full_df"
	self.textures.dragon_full.infamous = true
	self.textures.dragon_full.value = 9
	self.textures.dragon_split = {}
	self.textures.dragon_split.name_id = "bm_txt_dragon_split"
	self.textures.dragon_split.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.dragon_split.texture = "units/payday2/masks/shared_textures/patterns/pattern_dragon_split_df"
	self.textures.dragon_split.value = 5
	self.textures.horizon_circle = {}
	self.textures.horizon_circle.name_id = "bm_txt_horizon_circle"
	self.textures.horizon_circle.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.horizon_circle.texture = "units/payday2/masks/shared_textures/patterns/pattern_horizon_circle_df"
	self.textures.horizon_circle.value = 4
	self.textures.tribal2 = {}
	self.textures.tribal2.name_id = "bm_txt_tribal2"
	self.textures.tribal2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.tribal2.texture = "units/payday2/masks/shared_textures/patterns/pattern_tribal2_df"
	self.textures.tribal2.value = 8
	self.textures.vertical = {}
	self.textures.vertical.name_id = "bm_txt_vertical"
	self.textures.vertical.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.vertical.texture = "units/payday2/masks/shared_textures/patterns/pattern_vertical_df"
	self.textures.vertical.value = 4
	self.textures.celtic2 = {}
	self.textures.celtic2.name_id = "bm_txt_celtic2"
	self.textures.celtic2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.celtic2.texture = "units/payday2/masks/shared_textures/patterns/pattern_celtic2_df"
	self.textures.celtic2.value = 2
	self.textures.beast = {}
	self.textures.beast.name_id = "bm_txt_beast"
	self.textures.beast.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.beast.texture = "units/payday2/masks/shared_textures/patterns/pattern_beast_df"
	self.textures.beast.value = 3
	self.textures.headshot = {}
	self.textures.headshot.name_id = "bm_txt_headshot"
	self.textures.headshot.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.headshot.texture = "units/payday2/masks/shared_textures/patterns/pattern_headshot_df"
	self.textures.headshot.value = 5
	self.textures.circuit = {}
	self.textures.circuit.name_id = "bm_txt_circuit"
	self.textures.circuit.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.circuit.texture = "units/payday2/masks/shared_textures/patterns/pattern_circuit_df"
	self.textures.circuit.value = 3
	self.textures.paint1 = {}
	self.textures.paint1.name_id = "bm_txt_paint1"
	self.textures.paint1.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.paint1.texture = "units/payday2/masks/shared_textures/patterns/pattern_paint1_df"
	self.textures.paint1.value = 2
	self.textures.chains = {}
	self.textures.chains.name_id = "bm_txt_chains"
	self.textures.chains.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.chains.texture = "units/payday2/masks/shared_textures/patterns/pattern_chains_df"
	self.textures.chains.value = 4
	self.textures.yinyang = {}
	self.textures.yinyang.name_id = "bm_txt_yinyang"
	self.textures.yinyang.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.yinyang.texture = "units/payday2/masks/shared_textures/patterns/pattern_yinyang_df"
	self.textures.yinyang.value = 6
	self.textures.rorschach = {}
	self.textures.rorschach.name_id = "bm_txt_rorschach"
	self.textures.rorschach.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.rorschach.texture = "units/payday2/masks/shared_textures/patterns/pattern_rorschach_df"
	self.textures.rorschach.infamous = true
	self.textures.rorschach.value = 6
	self.textures.zipper = {}
	self.textures.zipper.name_id = "bm_txt_zipper"
	self.textures.zipper.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.zipper.texture = "units/payday2/masks/shared_textures/patterns/pattern_zipper_df"
	self.textures.zipper.value = 2
	self.textures.daniel = {}
	self.textures.daniel.name_id = "bm_txt_daniel"
	self.textures.daniel.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.daniel.texture = "units/payday2/masks/shared_textures/patterns/pattern_daniel_df"
	self.textures.daniel.value = 2
	self.textures.ouroboros = {}
	self.textures.ouroboros.name_id = "bm_txt_ouroboros"
	self.textures.ouroboros.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.ouroboros.texture = "units/payday2/masks/shared_textures/patterns/pattern_ouroboros_df"
	self.textures.ouroboros.value = 7
	self.textures.ouro = {}
	self.textures.ouro.name_id = "bm_txt_ouro"
	self.textures.ouro.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.ouro.texture = "units/payday2/masks/shared_textures/patterns/pattern_ouro_df"
	self.textures.ouro.value = 5
	self.textures.cat = {}
	self.textures.cat.name_id = "bm_txt_cat"
	self.textures.cat.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.cat.texture = "units/payday2/masks/shared_textures/patterns/pattern_cat_df"
	self.textures.cat.infamous = true
	self.textures.cat.value = 6
	self.textures.clown = {}
	self.textures.clown.name_id = "bm_txt_clown"
	self.textures.clown.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.clown.texture = "units/payday2/masks/shared_textures/patterns/pattern_clown_df"
	self.textures.clown.value = 2
	self.textures.paint2 = {}
	self.textures.paint2.name_id = "bm_txt_ouroboros"
	self.textures.paint2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.paint2.texture = "units/payday2/masks/shared_textures/patterns/pattern_paint2_df"
	self.textures.paint2.value = 2
	self.textures.spider = {}
	self.textures.spider.name_id = "bm_txt_spider"
	self.textures.spider.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.spider.texture = "units/payday2/masks/shared_textures/patterns/pattern_spider_df"
	self.textures.spider.value = 7
	self.textures.target = {}
	self.textures.target.name_id = "bm_txt_target"
	self.textures.target.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.target.texture = "units/payday2/masks/shared_textures/patterns/pattern_target_df"
	self.textures.target.value = 5
	self.textures.illuminati = {}
	self.textures.illuminati.name_id = "bm_txt_illuminati"
	self.textures.illuminati.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.illuminati.texture = "units/payday2/masks/shared_textures/patterns/pattern_illuminati_df"
	self.textures.illuminati.value = 7
	self.textures.hypnotic = {}
	self.textures.hypnotic.name_id = "bm_txt_hypnotic"
	self.textures.hypnotic.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hypnotic.texture = "units/payday2/masks/shared_textures/patterns/pattern_hypnotic_df"
	self.textures.hypnotic.value = 3
	self.textures.hexagon = {}
	self.textures.hexagon.name_id = "bm_txt_hexagon"
	self.textures.hexagon.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hexagon.texture = "units/payday2/masks/shared_textures/patterns/pattern_hexagon_df"
	self.textures.hexagon.value = 4
	self.textures.messatsu = {}
	self.textures.messatsu.name_id = "bm_txt_messatsu"
	self.textures.messatsu.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.messatsu.texture = "units/payday2/masks/shared_textures/patterns/pattern_messatsu_df"
	self.textures.messatsu.value = 2
	self.textures.shazam = {}
	self.textures.shazam.name_id = "bm_txt_shazam"
	self.textures.shazam.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.shazam.texture = "units/payday2/masks/shared_textures/patterns/pattern_shazam_df"
	self.textures.shazam.value = 2
	self.textures.emblem1 = {}
	self.textures.emblem1.name_id = "bm_txt_emblem1"
	self.textures.emblem1.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.emblem1.texture = "units/payday2/masks/shared_textures/patterns/pattern_emblem1_df"
	self.textures.emblem1.value = 1
	self.textures.emblem2 = {}
	self.textures.emblem2.name_id = "bm_txt_emblem2"
	self.textures.emblem2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.emblem2.texture = "units/payday2/masks/shared_textures/patterns/pattern_emblem2_df"
	self.textures.emblem2.value = 2
	self.textures.emblem3 = {}
	self.textures.emblem3.name_id = "bm_txt_emblem3"
	self.textures.emblem3.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.emblem3.texture = "units/payday2/masks/shared_textures/patterns/pattern_emblem3_df"
	self.textures.emblem3.value = 3
	self.textures.swirl = {}
	self.textures.swirl.name_id = "bm_txt_swirl"
	self.textures.swirl.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.swirl.texture = "units/payday2/masks/shared_textures/patterns/pattern_swirl_df"
	self.textures.swirl.value = 4
	self.textures.kabuki1 = {}
	self.textures.kabuki1.name_id = "bm_txt_kabuki1"
	self.textures.kabuki1.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.kabuki1.texture = "units/payday2/masks/shared_textures/patterns/pattern_kabuki1_df"
	self.textures.kabuki1.value = 5
	self.textures.ultimaterobber = {}
	self.textures.ultimaterobber.name_id = "bm_txt_ultimaterobber"
	self.textures.ultimaterobber.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.ultimaterobber.texture = "units/payday2/masks/shared_textures/patterns/pattern_ultimaterobber_df"
	self.textures.ultimaterobber.infamous = true
	self.textures.ultimaterobber.value = 6
	self.textures.nuclear = {}
	self.textures.nuclear.name_id = "bm_txt_nuclear"
	self.textures.nuclear.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.nuclear.texture = "units/payday2/masks/shared_textures/patterns/pattern_nuclear_df"
	self.textures.nuclear.value = 7
	self.textures.gearhead = {}
	self.textures.gearhead.name_id = "bm_txt_gearhead"
	self.textures.gearhead.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.gearhead.texture = "units/payday2/masks/shared_textures/patterns/pattern_gearhead_df"
	self.textures.gearhead.value = 6
	self.textures.atom = {}
	self.textures.atom.name_id = "bm_txt_atom"
	self.textures.atom.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.atom.texture = "units/payday2/masks/shared_textures/patterns/pattern_atom_df"
	self.textures.atom.value = 5
	self.textures.hand = {}
	self.textures.hand.name_id = "bm_txt_hand"
	self.textures.hand.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hand.texture = "units/payday2/masks/shared_textures/patterns/pattern_hand_df"
	self.textures.hand.value = 4
	self.textures.scars = {}
	self.textures.scars.name_id = "bm_txt_scars"
	self.textures.scars.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.scars.texture = "units/payday2/masks/shared_textures/patterns/pattern_scars_df"
	self.textures.scars.value = 3
	self.textures.pirate = {}
	self.textures.pirate.name_id = "bm_txt_pirate"
	self.textures.pirate.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.pirate.texture = "units/payday2/masks/shared_textures/patterns/pattern_pirate_df"
	self.textures.pirate.value = 2
	self.textures.foot = {}
	self.textures.foot.name_id = "bm_txt_foot"
	self.textures.foot.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.foot.texture = "units/payday2/masks/shared_textures/patterns/pattern_foot_df"
	self.textures.foot.value = 7
	self.textures.star = {}
	self.textures.star.name_id = "bm_txt_star"
	self.textures.star.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.star.texture = "units/payday2/masks/shared_textures/patterns/pattern_star_df"
	self.textures.star.value = 8
	self.textures.portal = {}
	self.textures.portal.name_id = "bm_txt_portal"
	self.textures.portal.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.portal.texture = "units/payday2/masks/shared_textures/patterns/pattern_portal_df"
	self.textures.portal.value = 6
	self.textures.aperture = {}
	self.textures.aperture.name_id = "bm_txt_aperture"
	self.textures.aperture.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.aperture.texture = "units/payday2/masks/shared_textures/patterns/pattern_aperture_df"
	self.textures.aperture.value = 5
	self.textures.girlsandboys = {}
	self.textures.girlsandboys.name_id = "bm_txt_girlsandboys"
	self.textures.girlsandboys.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.girlsandboys.texture = "units/payday2/masks/shared_textures/patterns/pattern_girlsandboys_df"
	self.textures.girlsandboys.value = 4
	self.textures.loverboy = {}
	self.textures.loverboy.name_id = "bm_txt_loverboy"
	self.textures.loverboy.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.loverboy.texture = "units/payday2/masks/shared_textures/patterns/pattern_loverboy_df"
	self.textures.loverboy.value = 3
	self.textures.cogs = {}
	self.textures.cogs.name_id = "bm_txt_cogs"
	self.textures.cogs.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.cogs.texture = "units/payday2/masks/shared_textures/patterns/pattern_cogs_df"
	self.textures.cogs.value = 4
	self.textures.ace = {}
	self.textures.ace.name_id = "bm_txt_ace"
	self.textures.ace.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.ace.texture = "units/payday2/masks/shared_textures/patterns/pattern_ace_df"
	self.textures.ace.infamous = true
	self.textures.ace.value = 5
	self.textures.compass = {}
	self.textures.compass.name_id = "bm_txt_compass"
	self.textures.compass.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.compass.texture = "units/payday2/masks/shared_textures/patterns/pattern_compass_df"
	self.textures.compass.value = 2
	self.textures.fan = {}
	self.textures.fan.name_id = "bm_txt_fan"
	self.textures.fan.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.fan.dlc = "preorder"
	self.textures.fan.texture = "units/payday2/masks/shared_textures/patterns/pattern_fan_df"
	self.textures.fan.value = 1
	self.textures.pd2 = {}
	self.textures.pd2.name_id = "bm_txt_pd2"
	self.textures.pd2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.pd2.texture = "units/payday2/masks/shared_textures/patterns/pattern_pd2_df"
	self.textures.pd2.value = 4
	self.textures.fingerprint = {}
	self.textures.fingerprint.name_id = "bm_txt_fingerprint"
	self.textures.fingerprint.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.fingerprint.texture = "units/payday2/masks/shared_textures/patterns/pattern_fingerprint_df"
	self.textures.fingerprint.infamous = true
	self.textures.fingerprint.value = 3
	self.textures.biohazard = {}
	self.textures.biohazard.name_id = "bm_txt_biohazard"
	self.textures.biohazard.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.biohazard.texture = "units/payday2/masks/shared_textures/patterns/pattern_biohazard_df"
	self.textures.biohazard.value = 2
	self.textures.tf2 = {}
	self.textures.tf2.name_id = "bm_txt_tf2"
	self.textures.tf2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.tf2.texture = "units/payday2/masks/shared_textures/patterns/pattern_tf2_df"
	self.textures.tf2.value = 3
	self.textures.cake = {}
	self.textures.cake.name_id = "bm_txt_cake"
	self.textures.cake.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.cake.texture = "units/payday2/masks/shared_textures/patterns/pattern_cake_df"
	self.textures.cake.value = 4
	self.textures.companioncube = {}
	self.textures.companioncube.name_id = "bm_txt_companioncube"
	self.textures.companioncube.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.companioncube.texture = "units/payday2/masks/shared_textures/patterns/pattern_companioncube_df"
	self.textures.companioncube.value = 6
	self.textures.two = {}
	self.textures.two.name_id = "bm_txt_two"
	self.textures.two.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.two.texture = "units/payday2/masks/shared_textures/patterns/pattern_two_df"
	self.textures.two.value = 5
	self.textures.striped = {}
	self.textures.striped.name_id = "bm_txt_striped"
	self.textures.striped.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.striped.texture = "units/payday2/masks/shared_textures/patterns/pattern_striped_df"
	self.textures.striped.value = 3
	self.textures.solidfirst = {}
	self.textures.solidfirst.name_id = "bm_txt_solidfirst"
	self.textures.solidfirst.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.solidfirst.texture = "units/payday2/masks/shared_textures/patterns/pattern_solidfirst_df"
	self.textures.solidfirst.infamous = true
	self.textures.solidfirst.value = 6
	self.textures.solidsecond = {}
	self.textures.solidsecond.name_id = "bm_txt_solidsecond"
	self.textures.solidsecond.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.solidsecond.texture = "units/payday2/masks/shared_textures/patterns/pattern_solidsecond_df"
	self.textures.solidsecond.infamous = true
	self.textures.solidsecond.value = 6
	self.textures.mantis = {}
	self.textures.mantis.name_id = "bm_txt_mantis"
	self.textures.mantis.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.mantis.texture = "units/payday2/masks/shared_textures/patterns/pattern_mantis_df"
	self.textures.mantis.value = 7
	self.textures.bite = {}
	self.textures.bite.name_id = "bm_txt_bite"
	self.textures.bite.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.bite.texture = "units/payday2/masks/shared_textures/patterns/pattern_bite_df"
	self.textures.bite.value = 3
	self.textures.wtf = {}
	self.textures.wtf.name_id = "bm_txt_wtf"
	self.textures.wtf.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.wtf.texture = "units/payday2/masks/shared_textures/patterns/pattern_wtf_df"
	self.textures.wtf.value = 4
	self.textures.bloodsucker = {}
	self.textures.bloodsucker.name_id = "bm_txt_bloodsucker"
	self.textures.bloodsucker.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.bloodsucker.texture = "units/payday2/masks/shared_textures/patterns/pattern_bloodsucker_df"
	self.textures.bloodsucker.value = 2
	self.textures.hawk = {}
	self.textures.hawk.name_id = "bm_txt_hawk"
	self.textures.hawk.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hawk.texture = "units/payday2/masks/shared_textures/patterns/pattern_hawk_df"
	self.textures.hawk.value = 4
	self.textures.magnet = {}
	self.textures.magnet.name_id = "bm_txt_magnet"
	self.textures.magnet.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.magnet.texture = "units/payday2/masks/shared_textures/patterns/pattern_magnet_df"
	self.textures.magnet.value = 2
	self.textures.diamond = {}
	self.textures.diamond.name_id = "bm_txt_diamond"
	self.textures.diamond.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.diamond.texture = "units/payday2/masks/shared_textures/patterns/pattern_diamond_df"
	self.textures.diamond.value = 3
	self.textures.luchador = {}
	self.textures.luchador.name_id = "bm_txt_luchador"
	self.textures.luchador.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.luchador.texture = "units/payday2/masks/shared_textures/patterns/pattern_luchador_df"
	self.textures.luchador.value = 1
	self.textures.maskedfalcon = {}
	self.textures.maskedfalcon.name_id = "bm_txt_maskedfalcon"
	self.textures.maskedfalcon.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.maskedfalcon.texture = "units/payday2/masks/shared_textures/patterns/pattern_maskedfalcon_df"
	self.textures.maskedfalcon.value = 3
	self.textures.grayson = {}
	self.textures.grayson.name_id = "bm_txt_grayson"
	self.textures.grayson.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.grayson.texture = "units/payday2/masks/shared_textures/patterns/pattern_grayson_df"
	self.textures.grayson.value = 2
	self.textures.sidestripe = {}
	self.textures.sidestripe.name_id = "bm_txt_sidestripe"
	self.textures.sidestripe.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.sidestripe.texture = "units/payday2/masks/shared_textures/patterns/pattern_sidestripe_df"
	self.textures.sidestripe.value = 5
	self.textures.gradient = {}
	self.textures.gradient.name_id = "bm_txt_gradient"
	self.textures.gradient.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.gradient.texture = "units/payday2/masks/shared_textures/patterns/pattern_gradient_df"
	self.textures.gradient.value = 4
	self.textures.spikes = {}
	self.textures.spikes.name_id = "bm_txt_spikes"
	self.textures.spikes.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.spikes.texture = "units/payday2/masks/shared_textures/patterns/pattern_spikes_df"
	self.textures.spikes.value = 3
	self.textures.barbarian = {}
	self.textures.barbarian.name_id = "bm_txt_barbarian"
	self.textures.barbarian.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.barbarian.texture = "units/payday2/masks/shared_textures/patterns/pattern_barbarian_df"
	self.textures.barbarian.value = 2
	self.textures.reaper = {}
	self.textures.reaper.name_id = "bm_txt_reaper"
	self.textures.reaper.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.reaper.texture = "units/payday2/masks/shared_textures/patterns/pattern_reaper_df"
	self.textures.reaper.value = 4
	self.textures.whiner = {}
	self.textures.whiner.name_id = "bm_txt_whiner"
	self.textures.whiner.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.whiner.texture = "units/payday2/masks/shared_textures/patterns/pattern_whiner_df"
	self.textures.whiner.value = 3
	self.textures.emblem4 = {}
	self.textures.emblem4.name_id = "bm_txt_emblem4"
	self.textures.emblem4.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.emblem4.texture = "units/payday2/masks/shared_textures/patterns/pattern_emblem4_df"
	self.textures.emblem4.value = 2
	self.textures.daft_heart = {}
	self.textures.daft_heart.name_id = "bm_txt_daft_heart"
	self.textures.daft_heart.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.daft_heart.texture = "units/payday2/masks/shared_textures/patterns/pattern_daft_heart_df"
	self.textures.daft_heart.value = 3
	self.textures.anarchy = {}
	self.textures.anarchy.name_id = "bm_txt_anarchy"
	self.textures.anarchy.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.anarchy.texture = "units/payday2/masks/shared_textures/patterns/pattern_anarchy_df"
	self.textures.anarchy.value = 4
	self.textures.molecule = {}
	self.textures.molecule.name_id = "bm_txt_molecule"
	self.textures.molecule.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.molecule.texture = "units/payday2/masks/shared_textures/patterns/pattern_molecule_df"
	self.textures.molecule.value = 3
	self.textures.fleur2 = {}
	self.textures.fleur2.name_id = "bm_txt_fleur2"
	self.textures.fleur2.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.fleur2.texture = "units/payday2/masks/shared_textures/patterns/pattern_fleur2_df"
	self.textures.fleur2.infamous = true
	self.textures.fleur2.value = 3
	self.textures.trekronor = {}
	self.textures.trekronor.name_id = "bm_txt_trekronor"
	self.textures.trekronor.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.trekronor.texture = "units/payday2/masks/shared_textures/patterns/pattern_trekronor_df"
	self.textures.trekronor.value = 2
	self.textures.raster = {}
	self.textures.raster.name_id = "bm_txt_raster"
	self.textures.raster.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.raster.texture = "units/payday2/masks/shared_textures/patterns/pattern_raster_df"
	self.textures.raster.value = 1
	self.textures.flag = {}
	self.textures.flag.name_id = "bm_txt_flag"
	self.textures.flag.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.flag.texture = "units/payday2/masks/shared_textures/patterns/pattern_flag_df"
	self.textures.flag.value = 4
	self.textures.cracker = {}
	self.textures.cracker.name_id = "bm_txt_cracker"
	self.textures.cracker.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.cracker.texture = "units/payday2/masks/shared_textures/patterns/pattern_cracker_df"
	self.textures.cracker.value = 4
	self.textures.hellish = {}
	self.textures.hellish.name_id = "bm_txt_hellish"
	self.textures.hellish.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hellish.texture = "units/payday2/masks/shared_textures/patterns/pattern_hellish_df"
	self.textures.hellish.value = 4
	self.textures.poison = {}
	self.textures.poison.name_id = "bm_txt_poison"
	self.textures.poison.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.poison.texture = "units/payday2/masks/shared_textures/patterns/pattern_poison_df"
	self.textures.poison.value = 4
	self.textures.yggdrasil = {}
	self.textures.yggdrasil.name_id = "bm_txt_yggdrasil"
	self.textures.yggdrasil.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.yggdrasil.texture = "units/payday2/masks/shared_textures/patterns/pattern_yggdrasil_df"
	self.textures.yggdrasil.value = 4
	self.textures.pumpgrin = {}
	self.textures.pumpgrin.name_id = "bm_txt_pumpgrin"
	self.textures.pumpgrin.weight = 2
	self.textures.pumpgrin.texture = "units/payday2/masks/shared_textures/patterns/pattern_pumpgrin_df"
	self.textures.pumpgrin.global_value = "halloween"
	self.textures.pumpgrin.value = 5
	self.textures.shout = {}
	self.textures.shout.name_id = "bm_txt_shout"
	self.textures.shout.weight = 2
	self.textures.shout.texture = "units/payday2/masks/shared_textures/patterns/pattern_shout_df"
	self.textures.shout.global_value = "halloween"
	self.textures.shout.value = 5
	self.textures.webbed = {}
	self.textures.webbed.name_id = "bm_txt_webbed"
	self.textures.webbed.weight = 2
	self.textures.webbed.texture = "units/payday2/masks/shared_textures/patterns/pattern_webbed_df"
	self.textures.webbed.global_value = "halloween"
	self.textures.webbed.value = 5
	self.textures.hannibalistic = {}
	self.textures.hannibalistic.name_id = "bm_txt_hannibalistic"
	self.textures.hannibalistic.weight = 2
	self.textures.hannibalistic.texture = "units/payday2/masks/shared_textures/patterns/pattern_hannibalistic_df"
	self.textures.hannibalistic.global_value = "halloween"
	self.textures.hannibalistic.value = 5
	self.textures.stitches = {}
	self.textures.stitches.name_id = "bm_txt_stitches"
	self.textures.stitches.weight = 2
	self.textures.stitches.texture = "units/payday2/masks/shared_textures/patterns/pattern_stitches_df"
	self.textures.stitches.global_value = "halloween"
	self.textures.stitches.value = 4
	self.textures.doomweaver = {}
	self.textures.doomweaver.name_id = "bm_txt_doomweaver"
	self.textures.doomweaver.weight = 2
	self.textures.doomweaver.texture = "units/payday2/masks/shared_textures/patterns/pattern_doomweaver_df"
	self.textures.doomweaver.global_value = "halloween"
	self.textures.doomweaver.value = 4
	self.textures.racestripes = {}
	self.textures.racestripes.name_id = "bm_txt_racestripes"
	self.textures.racestripes.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.racestripes.texture = "units/pd2_dlc1/masks/patterns/pattern_racestripes_df"
	self.textures.racestripes.value = 4
	self.textures.racestripes.dlc = "armored_transport"
	self.textures.americaneagle = {}
	self.textures.americaneagle.name_id = "bm_txt_americaneagle"
	self.textures.americaneagle.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.americaneagle.texture = "units/pd2_dlc1/masks/patterns/pattern_americaneagle_df"
	self.textures.americaneagle.value = 4
	self.textures.americaneagle.dlc = "armored_transport"
	self.textures.stars = {}
	self.textures.stars.name_id = "bm_txt_stars"
	self.textures.stars.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.stars.texture = "units/pd2_dlc1/masks/patterns/pattern_stars_df"
	self.textures.stars.value = 4
	self.textures.stars.dlc = "armored_transport"
	self.textures.forestcamo = {}
	self.textures.forestcamo.name_id = "bm_txt_forestcamo"
	self.textures.forestcamo.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.forestcamo.texture = "units/pd2_dlc1/masks/patterns/pattern_forestcamo_df"
	self.textures.forestcamo.value = 4
	self.textures.forestcamo.dlc = "armored_transport"
	self.textures.army = {}
	self.textures.army.name_id = "bm_txt_army"
	self.textures.army.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.army.texture = "units/pd2_dlc_dec5/masks/patterns/pattern_army_df"
	self.textures.army.value = 4
	self.textures.army.dlc = "gage_pack"
	self.textures.commando = {}
	self.textures.commando.name_id = "bm_txt_commando"
	self.textures.commando.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.commando.texture = "units/pd2_dlc_dec5/masks/patterns/pattern_commando_df"
	self.textures.commando.value = 4
	self.textures.commando.dlc = "gage_pack"
	self.textures.hunter = {}
	self.textures.hunter.name_id = "bm_txt_hunter"
	self.textures.hunter.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.hunter.texture = "units/pd2_dlc_dec5/masks/patterns/pattern_hunter_df"
	self.textures.hunter.value = 4
	self.textures.hunter.dlc = "gage_pack"
	self.textures.digitalcamo = {}
	self.textures.digitalcamo.name_id = "bm_txt_digitalcamo"
	self.textures.digitalcamo.pcs = {
		10,
		20,
		30,
		40
	}
	self.textures.digitalcamo.texture = "units/pd2_dlc_dec5/masks/patterns/pattern_digitalcamo_df"
	self.textures.digitalcamo.value = 4
	self.textures.digitalcamo.dlc = "gage_pack"
end

function BlackMarketTweakData:_init_cash()
	self.cash = {}
	self.cash.cash10 = {}
	self.cash.cash10.name_id = "bm_csh_cash10"
	self.cash.cash10.value_id = "cash10"
	self.cash.cash10.multiplier = 1
	self.cash.cash10.pcs = {10, 40}
	self.cash.cash20 = {}
	self.cash.cash20.name_id = "bm_csh_cash20"
	self.cash.cash20.value_id = "cash20"
	self.cash.cash20.multiplier = 1
	self.cash.cash20.pcs = {20, 40}
	self.cash.cash30 = {}
	self.cash.cash30.name_id = "bm_csh_cash30"
	self.cash.cash30.multiplier = 1
	self.cash.cash30.value_id = "cash30"
	self.cash.cash30.pcs = {30, 40}
	self.cash.cash40 = {}
	self.cash.cash40.name_id = "bm_csh_cash40"
	self.cash.cash40.multiplier = 1
	self.cash.cash40.value_id = "cash40"
	self.cash.cash40.pcs = {
		20,
		30,
		40
	}
	self.cash.cash50 = {}
	self.cash.cash50.name_id = "bm_csh_cash50"
	self.cash.cash50.multiplier = 1
	self.cash.cash50.value_id = "cash50"
	self.cash.cash50.pcs = {
		30,
		40,
		50
	}
	self.cash.cash60 = {}
	self.cash.cash60.name_id = "bm_csh_cash60"
	self.cash.cash60.value_id = "cash60"
	self.cash.cash60.multiplier = 1
	self.cash.cash60.pcs = {
		40,
		50,
		60
	}
	self.cash.cash70 = {}
	self.cash.cash70.name_id = "bm_csh_cash70"
	self.cash.cash70.value_id = "cash70"
	self.cash.cash70.multiplier = 1
	self.cash.cash70.pcs = {
		50,
		60,
		70
	}
	self.cash.cash80 = {}
	self.cash.cash80.name_id = "bm_csh_cash80"
	self.cash.cash80.value_id = "cash80"
	self.cash.cash80.multiplier = 1
	self.cash.cash80.pcs = {
		60,
		70,
		80
	}
	self.cash.cash90 = {}
	self.cash.cash90.name_id = "bm_csh_cash90"
	self.cash.cash90.value_id = "cash90"
	self.cash.cash90.multiplier = 1
	self.cash.cash90.pcs = {
		70,
		80,
		90
	}
	self.cash.cash100 = {}
	self.cash.cash100.name_id = "bm_csh_cash100"
	self.cash.cash100.value_id = "cash100"
	self.cash.cash100.multiplier = 1
	self.cash.cash100.pcs = {
		80,
		90,
		100
	}
	self.cash.cash_preorder = {}
	self.cash.cash_preorder.name_id = "bm_csh_cash_preorder"
	self.cash.cash_preorder.value_id = "cash_preorder"
	self.cash.cash_preorder.multiplier = 1.2
end

function BlackMarketTweakData:_init_xp()
	self.xp = {}
	self.xp.xp10 = {}
	self.xp.xp10.name_id = "bm_exp_xp10"
	self.xp.xp10.value_id = "xp10"
	self.xp.xp10.multiplier = 1
	self.xp.xp10.pcs = {10, 40}
	self.xp.xp20 = {}
	self.xp.xp20.name_id = "bm_exp_xp20"
	self.xp.xp20.value_id = "xp20"
	self.xp.xp20.multiplier = 1
	self.xp.xp20.pcs = {20, 40}
	self.xp.xp30 = {}
	self.xp.xp30.name_id = "bm_exp_xp30"
	self.xp.xp30.multiplier = 1
	self.xp.xp30.value_id = "xp30"
	self.xp.xp30.pcs = {30, 40}
	self.xp.xp40 = {}
	self.xp.xp40.name_id = "bm_exp_xp40"
	self.xp.xp40.multiplier = 1
	self.xp.xp40.value_id = "xp40"
	self.xp.xp40.pcs = {
		20,
		30,
		40
	}
	self.xp.xp50 = {}
	self.xp.xp50.name_id = "bm_exp_xp50"
	self.xp.xp50.multiplier = 1
	self.xp.xp50.value_id = "xp50"
	self.xp.xp50.pcs = {
		30,
		40,
		50
	}
	self.xp.xp60 = {}
	self.xp.xp60.name_id = "bm_exp_xp60"
	self.xp.xp60.value_id = "xp60"
	self.xp.xp60.multiplier = 1
	self.xp.xp60.pcs = {
		40,
		50,
		60
	}
	self.xp.xp70 = {}
	self.xp.xp70.name_id = "bm_exp_xp70"
	self.xp.xp70.value_id = "xp70"
	self.xp.xp70.multiplier = 1
	self.xp.xp70.pcs = {
		50,
		60,
		70
	}
	self.xp.xp80 = {}
	self.xp.xp80.name_id = "bm_exp_xp80"
	self.xp.xp80.value_id = "xp80"
	self.xp.xp80.multiplier = 1
	self.xp.xp80.pcs = {
		60,
		70,
		80
	}
	self.xp.xp90 = {}
	self.xp.xp90.name_id = "bm_exp_xp90"
	self.xp.xp90.value_id = "xp90"
	self.xp.xp90.multiplier = 1
	self.xp.xp90.pcs = {
		70,
		80,
		90
	}
	self.xp.xp100 = {}
	self.xp.xp100.name_id = "bm_exp_xp100"
	self.xp.xp100.value_id = "xp100"
	self.xp.xp100.multiplier = 1
	self.xp.xp100.pcs = {
		80,
		90,
		100
	}
end

function BlackMarketTweakData:_init_armors()
	self.armors = {}
	self.armors.level_1 = {}
	self.armors.level_1.name_id = "bm_armor_level_1"
	self.armors.level_1.sequence = "var_model_01"
	self.armors.level_1.upgrade_level = 1
	self.armors.level_2 = {}
	self.armors.level_2.name_id = "bm_armor_level_2"
	self.armors.level_2.sequence = "var_model_02"
	self.armors.level_2.upgrade_level = 2
	self.armors.level_3 = {}
	self.armors.level_3.name_id = "bm_armor_level_3"
	self.armors.level_3.sequence = "var_model_03"
	self.armors.level_3.upgrade_level = 3
	self.armors.level_4 = {}
	self.armors.level_4.name_id = "bm_armor_level_4"
	self.armors.level_4.sequence = "var_model_04"
	self.armors.level_4.upgrade_level = 4
	self.armors.level_5 = {}
	self.armors.level_5.name_id = "bm_armor_level_5"
	self.armors.level_5.sequence = "var_model_05"
	self.armors.level_5.upgrade_level = 5
	self.armors.level_6 = {}
	self.armors.level_6.name_id = "bm_armor_level_6"
	self.armors.level_6.sequence = "var_model_06"
	self.armors.level_6.upgrade_level = 6
	self.armors.level_7 = {}
	self.armors.level_7.name_id = "bm_armor_level_7"
	self.armors.level_7.sequence = "var_model_07"
	self.armors.level_7.upgrade_level = 7
	self:_add_desc_from_name_macro(self.armors)
end

function BlackMarketTweakData:_init_deployables(tweak_data)
	self.deployables = {}
	self.deployables.doctor_bag = {}
	self.deployables.doctor_bag.name_id = "bm_equipment_doctor_bag"
	self.deployables.ammo_bag = {}
	self.deployables.ammo_bag.name_id = "bm_equipment_ammo_bag"
	self.deployables.ecm_jammer = {}
	self.deployables.ecm_jammer.name_id = "bm_equipment_ecm_jammer"
	self.deployables.sentry_gun = {}
	self.deployables.sentry_gun.name_id = "bm_equipment_sentry_gun"
	self.deployables.trip_mine = {}
	self.deployables.trip_mine.name_id = "bm_equipment_trip_mine"
	self:_add_desc_from_name_macro(self.deployables)
end

function BlackMarketTweakData:_init_grenades()
	self.grenades = {}
	self.grenades.frag = {}
	self.grenades.frag.name_id = "bm_grenade_frag"
	self.grenades.frag.unit = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade"
	self.grenades.frag.unit_dummy = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade_husk"
	self.grenades.frag.sprint_unit = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade_sprint"
	self.grenades.frag.icon = "frag_grenade"
	self.grenades.frag.dlc = "gage_pack"
end
