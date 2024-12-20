local is_nextgen_console = SystemInfo:platform() == Idstring("PS4") or SystemInfo:platform() == Idstring("XB1")
local allow_halloween_lootdrop = is_nextgen_console

function BlackMarketTweakData:_init_masks(tweak_data)
	self.masks = {}
	self.masks.character_locked = {}
	self.masks.character_locked.name_id = "bm_msk_character_locked"
	self.masks.character_locked.inaccessible = true
	self.masks.character_locked.dallas = "dallas"
	self.masks.character_locked.wolf = "wolf"
	self.masks.character_locked.hoxton = "hoxton"
	self.masks.character_locked.chains = "chains"
	self.masks.character_locked.jowi = "jw_shades"
	self.masks.character_locked.old_hoxton = "old_hoxton"
	self.masks.character_locked.female_1 = "msk_grizel"
	self.masks.character_locked.dragan = "dragan"
	self.masks.character_locked.jacket = "richard_returns"
	self.masks.character_locked.bonnie = "bonnie"
	self.masks.character_locked.sokol = "sokol"
	self.masks.character_locked.dragon = "jiro"
	self.masks.character_locked.bodhi = "bodhi"
	self.masks.character_locked.jimmy = "jimmy_duct"
	self.masks.character_locked.sydney = "sydney"
	self.masks.character_locked.wild = "rust"
	self.masks.character_locked.chico = "chc_terry"
	self.masks.character_locked.max = "max"
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
	self.masks.old_hoxton = {}
	self.masks.old_hoxton.unit = "units/pd2_dlc_old_hoxton/masks/old_hoxton/msk_old_hoxton"
	self.masks.old_hoxton.name_id = "bm_msk_old_hoxton"
	self.masks.old_hoxton.pcs = {}
	self.masks.old_hoxton.value = 0
	self.masks.old_hoxton.global_value = "infamous"
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
	self.masks.dragan = {}
	self.masks.dragan.unit = "units/pd2_dlc_dragan/masks/dragan/msk_dragan"
	self.masks.dragan.name_id = "bm_msk_dragan"
	self.masks.dragan.pcs = {}
	self.masks.dragan.value = 0
	self.masks.dragan.texture_bundle_folder = "character_pack_dragan"
	self.masks.dragan.dlc = "character_pack_dragan"
	self.masks.dragan_begins = {}
	self.masks.dragan_begins.unit = "units/pd2_dlc_dragan/masks/dragan_begins/msk_dragan_begins"
	self.masks.dragan_begins.name_id = "bm_msk_dragan_begins"
	self.masks.dragan_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.dragan_begins.value = 0
	self.masks.dragan_begins.texture_bundle_folder = "character_pack_dragan"
	self.masks.dragan_begins.dlc = "character_pack_dragan"
	self.masks.bonnie = {}
	self.masks.bonnie.unit = "units/pd2_dlc_bonnie/masks/bonnie/msk_bonnie"
	self.masks.bonnie.name_id = "bm_msk_bonnie"
	self.masks.bonnie.pcs = {}
	self.masks.bonnie.value = 0
	self.masks.bonnie.global_value = "infamous"
	self.masks.bonnie.texture_bundle_folder = "character_pack_bonnie"
	self.masks.bonnie_begins = {}
	self.masks.bonnie_begins.unit = "units/pd2_dlc_bonnie/masks/bonnie_begins/msk_bonnie_begins"
	self.masks.bonnie_begins.name_id = "bm_msk_bonnie_begins"
	self.masks.bonnie_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.bonnie_begins.value = 0
	self.masks.bonnie_begins.global_value = "infamous"
	self.masks.bonnie_begins.texture_bundle_folder = "character_pack_bonnie"
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
	self.masks.pumpkin_king = {}
	self.masks.pumpkin_king.unit = "units/payday2/masks/msk_pumpkin_king/msk_pumpkin_king"
	self.masks.pumpkin_king.name_id = "bm_msk_pumpkin_king"
	if allow_halloween_lootdrop then
		self.masks.pumpkin_king.pcs = {
			10,
			20,
			30,
			40
		}
	else
		self.masks.pumpkin_king.pcs = nil
		self.masks.pumpkin_king.weight = 1000
		self.masks.pumpkin_king.got_item_weight_mod = 0.001
	end
	self.masks.pumpkin_king.global_value = "halloween"
	self.masks.pumpkin_king.value = 0
	self.masks.pumpkin_king.qlvl = 0
	self.masks.pumpkin_king.sort_number = 1
	self.masks.witch = {}
	self.masks.witch.unit = "units/payday2/masks/msk_witch/msk_witch"
	self.masks.witch.name_id = "bm_msk_witch"
	if allow_halloween_lootdrop then
		self.masks.witch.pcs = {
			10,
			20,
			30,
			40
		}
	else
		self.masks.witch.pcs = nil
		self.masks.witch.weight = 1000
		self.masks.witch.got_item_weight_mod = 0.001
	end
	self.masks.witch.global_value = "halloween"
	self.masks.witch.value = 0
	self.masks.witch.qlvl = 0
	self.masks.witch.sort_number = 1
	self.masks.venomorph = {}
	self.masks.venomorph.unit = "units/payday2/masks/msk_venomorph/msk_venomorph"
	self.masks.venomorph.name_id = "bm_msk_venomorph"
	if allow_halloween_lootdrop then
		self.masks.venomorph.pcs = {
			10,
			20,
			30,
			40
		}
	else
		self.masks.venomorph.pcs = nil
		self.masks.venomorph.weight = 1000
		self.masks.venomorph.got_item_weight_mod = 0.001
	end
	self.masks.venomorph.global_value = "halloween"
	self.masks.venomorph.value = 0
	self.masks.venomorph.qlvl = 0
	self.masks.venomorph.sort_number = 1
	self.masks.frank = {}
	self.masks.frank.unit = "units/payday2/masks/msk_frank/msk_frank"
	self.masks.frank.name_id = "bm_msk_frank"
	if allow_halloween_lootdrop then
		self.masks.frank.pcs = {
			10,
			20,
			30,
			40
		}
	else
		self.masks.frank.pcs = nil
		self.masks.frank.weight = 1000
		self.masks.frank.got_item_weight_mod = 0.001
	end
	self.masks.frank.global_value = "halloween"
	self.masks.frank.value = 0
	self.masks.frank.qlvl = 0
	self.masks.frank.sort_number = 1
	self.masks.brazil_baby = {}
	self.masks.brazil_baby.unit = "units/payday2/masks/msk_brazil_baby/msk_brazil_baby"
	self.masks.brazil_baby.name_id = "bm_msk_brazil_baby"
	self.masks.brazil_baby.global_value = "halloween"
	self.masks.brazil_baby.value = 0
	self.masks.brazil_baby.qlvl = 0
	self.masks.brazil_baby.sort_number = 2
	self.masks.baby_angry = {}
	self.masks.baby_angry.unit = "units/payday2/masks/msk_baby_angry/msk_baby_angry"
	self.masks.baby_angry.name_id = "bm_msk_baby_angry"
	self.masks.baby_angry.global_value = "halloween"
	self.masks.baby_angry.value = 0
	self.masks.baby_angry.qlvl = 0
	self.masks.baby_angry.sort_number = 2
	self.masks.baby_cry = {}
	self.masks.baby_cry.unit = "units/payday2/masks/msk_baby_cry/msk_baby_cry"
	self.masks.baby_cry.name_id = "bm_msk_baby_cry"
	self.masks.baby_cry.global_value = "halloween"
	self.masks.baby_cry.value = 0
	self.masks.baby_cry.qlvl = 0
	self.masks.baby_cry.sort_number = 2
	self.masks.baby_happy = {}
	self.masks.baby_happy.unit = "units/payday2/masks/msk_baby_happy/msk_baby_happy"
	self.masks.baby_happy.name_id = "bm_msk_baby_happy"
	self.masks.baby_happy.global_value = "halloween"
	self.masks.baby_happy.value = 0
	self.masks.baby_happy.qlvl = 0
	self.masks.baby_happy.sort_number = 2
	self.masks.the_one_below = {}
	self.masks.the_one_below.unit = "units/pd2_humble_halloween/masks/the_one_below/msk_the_one_below"
	self.masks.the_one_below.name_id = "bm_msk_onebelow"
	self.masks.the_one_below.pcs = {}
	self.masks.the_one_below.dlc = "humble_pack2"
	self.masks.the_one_below.value = 0
	self.masks.the_one_below.sort_number = 4
	self.masks.lycan = {}
	self.masks.lycan.unit = "units/pd2_humble_halloween/masks/lycan/msk_lycan"
	self.masks.lycan.name_id = "bm_msk_lycanwulf"
	self.masks.lycan.pcs = {}
	self.masks.lycan.dlc = "humble_pack2"
	self.masks.lycan.value = 0
	self.masks.lycan.sort_number = 4
	self.masks.krampus = {}
	self.masks.krampus.unit = "units/pd2_dlc_pines/masks/krampus/msk_krampus"
	self.masks.krampus.name_id = "bm_msk_krampus"
	self.masks.krampus.pcs = {}
	self.masks.krampus.value = 0
	self.masks.krampus.sort_number = 1
	self.masks.krampus.texture_bundle_folder = "pines"
	self.masks.mrs_claus = {}
	self.masks.mrs_claus.unit = "units/pd2_dlc_pines/masks/mrs_claus/msk_mrs_claus"
	self.masks.mrs_claus.name_id = "bm_msk_mrs_claus"
	self.masks.mrs_claus.pcs = {}
	self.masks.mrs_claus.value = 0
	self.masks.mrs_claus.sort_number = 1
	self.masks.mrs_claus.texture_bundle_folder = "pines"
	self.masks.strinch = {}
	self.masks.strinch.unit = "units/pd2_dlc_pines/masks/strinch/msk_the_strinch"
	self.masks.strinch.name_id = "bm_msk_the_strinch"
	self.masks.strinch.pcs = {}
	self.masks.strinch.type = "helmet"
	self.masks.strinch.value = 0
	self.masks.strinch.sort_number = 1
	self.masks.strinch.texture_bundle_folder = "pines"
	self.masks.almirs_beard = {}
	self.masks.almirs_beard.unit = "units/pd2_dlc_pines/masks/almirs_beard/msk_almirs_beard"
	self.masks.almirs_beard.name_id = "bm_msk_almirs_beard"
	self.masks.almirs_beard.pcs = {}
	self.masks.almirs_beard.type = "beard"
	self.masks.almirs_beard.skip_mask_on_sequence = true
	self.masks.almirs_beard.value = 0
	self.masks.almirs_beard.sort_number = 1
	self.masks.almirs_beard.texture_bundle_folder = "pines"
	self.masks.robo_santa = {}
	self.masks.robo_santa.unit = "units/pd2_dlc_pines/masks/robo_santa/msk_robo_santa"
	self.masks.robo_santa.name_id = "bm_msk_robo_santa"
	self.masks.robo_santa.pcs = {}
	self.masks.robo_santa.value = 0
	self.masks.robo_santa.sort_number = 1
	self.masks.robo_santa.texture_bundle_folder = "pines"
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
	self.masks.heat.sort_number = 2
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
	self.masks.bear.dlc = "pd2_clan"
	self.masks.bear.sort_number = 1
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
	self.masks.santa_happy.sort_number = 3
	self.masks.santa_mad = {}
	self.masks.santa_mad.unit = "units/pd2_dlc_xmas/masks/msk_santa_mad/msk_santa_mad"
	self.masks.santa_mad.name_id = "bm_msk_santa_mad"
	self.masks.santa_mad.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.santa_mad.value = 4
	self.masks.santa_mad.dlc = "xmas_soundtrack"
	self.masks.santa_drunk = {}
	self.masks.santa_drunk.unit = "units/pd2_dlc_xmas/masks/msk_santa_drunk/msk_santa_drunk"
	self.masks.santa_drunk.name_id = "bm_msk_santa_drunk"
	self.masks.santa_drunk.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.santa_drunk.value = 4
	self.masks.santa_drunk.dlc = "xmas_soundtrack"
	self.masks.santa_surprise = {}
	self.masks.santa_surprise.unit = "units/pd2_dlc_xmas/masks/msk_santa_suprise/msk_santa_suprise"
	self.masks.santa_surprise.name_id = "bm_msk_santa_surprise"
	self.masks.santa_surprise.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.santa_surprise.value = 4
	self.masks.santa_surprise.dlc = "xmas_soundtrack"
	self.masks.aviator = {}
	self.masks.aviator.unit = "units/pd2_dlc_infamy/masks/msk_aviator/msk_aviator"
	self.masks.aviator.name_id = "bm_msk_aviator"
	self.masks.aviator.pcs = {}
	self.masks.aviator.value = 0
	self.masks.aviator.type = "glasses"
	self.masks.aviator.skip_mask_on_sequence = true
	self.masks.aviator.global_value = "infamy"
	self.masks.aviator.texture_bundle_folder = "infamous"
	self.masks.aviator.infamy_lock = "infamy_root"
	self.masks.ghost = {}
	self.masks.ghost.unit = "units/pd2_dlc_infamy/masks/msk_ghost/msk_ghost"
	self.masks.ghost.name_id = "bm_msk_ghost"
	self.masks.ghost.pcs = {}
	self.masks.ghost.value = 0
	self.masks.ghost.global_value = "infamy"
	self.masks.ghost.texture_bundle_folder = "infamous"
	self.masks.ghost.type = "helmet"
	self.masks.ghost.infamy_lock = "infamy_ghost"
	self.masks.welder = {}
	self.masks.welder.unit = "units/pd2_dlc_infamy/masks/msk_welder/msk_welder"
	self.masks.welder.name_id = "bm_msk_welder"
	self.masks.welder.pcs = {}
	self.masks.welder.value = 0
	self.masks.welder.global_value = "infamy"
	self.masks.welder.texture_bundle_folder = "infamous"
	self.masks.welder.infamy_lock = "infamy_enforcer"
	self.masks.plague = {}
	self.masks.plague.unit = "units/pd2_dlc_infamy/masks/msk_plague/msk_plague"
	self.masks.plague.name_id = "bm_msk_plague"
	self.masks.plague.pcs = {}
	self.masks.plague.value = 0
	self.masks.plague.global_value = "infamy"
	self.masks.plague.texture_bundle_folder = "infamous"
	self.masks.plague.infamy_lock = "infamy_mastermind"
	self.masks.smoker = {}
	self.masks.smoker.unit = "units/pd2_dlc_infamy/masks/msk_smoker/msk_smoker"
	self.masks.smoker.name_id = "bm_msk_smoker"
	self.masks.smoker.pcs = {}
	self.masks.smoker.value = 0
	self.masks.smoker.global_value = "infamy"
	self.masks.smoker.texture_bundle_folder = "infamous"
	self.masks.smoker.infamy_lock = "infamy_technician"
	self.masks.cloth_commander = {}
	self.masks.cloth_commander.unit = "units/pd2_dlc_gage_lmg/masks/cloth_commander/msk_cloth_commander"
	self.masks.cloth_commander.name_id = "bm_msk_cloth_commander"
	self.masks.cloth_commander.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.cloth_commander.value = 4
	self.masks.cloth_commander.qlvl = 0
	self.masks.cloth_commander.dlc = "gage_pack_lmg"
	self.masks.cloth_commander.texture_bundle_folder = "gage_pack_lmg"
	self.masks.gage_blade = {}
	self.masks.gage_blade.unit = "units/pd2_dlc_gage_lmg/masks/msk_gage_blade/msk_gage_blade"
	self.masks.gage_blade.name_id = "bm_msk_gage_blade"
	self.masks.gage_blade.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.gage_blade.value = 4
	self.masks.gage_blade.qlvl = 0
	self.masks.gage_blade.texture_bundle_folder = "gage_pack_lmg"
	self.masks.gage_blade.dlc = "gage_pack_lmg"
	self.masks.gage_rambo = {}
	self.masks.gage_rambo.unit = "units/pd2_dlc_gage_lmg/masks/msk_gage_rambo/msk_gage_rambo"
	self.masks.gage_rambo.name_id = "bm_msk_rambo"
	self.masks.gage_rambo.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.gage_rambo.value = 4
	self.masks.gage_rambo.qlvl = 0
	self.masks.gage_rambo.texture_bundle_folder = "gage_pack_lmg"
	self.masks.gage_rambo.dlc = "gage_pack_lmg"
	self.masks.gage_deltaforce = {}
	self.masks.gage_deltaforce.unit = "units/pd2_dlc_gage_lmg/masks/msk_gage_deltaforce/msk_gage_deltaforce"
	self.masks.gage_deltaforce.name_id = "bm_msk_deltaforce"
	self.masks.gage_deltaforce.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.gage_deltaforce.value = 4
	self.masks.gage_deltaforce.qlvl = 0
	self.masks.gage_deltaforce.texture_bundle_folder = "gage_pack_lmg"
	self.masks.gage_deltaforce.dlc = "gage_pack_lmg"
	self.masks.robberfly = {}
	self.masks.robberfly.unit = "units/pd2_dlc_gage_snp/masks/msk_robberfly/msk_robberfly"
	self.masks.robberfly.name_id = "bm_msk_robberfly"
	self.masks.robberfly.pcs = {}
	self.masks.robberfly.value = 0
	self.masks.robberfly.qlvl = 0
	self.masks.robberfly.texture_bundle_folder = "gage_pack_snp"
	self.masks.robberfly.dlc = "gage_pack_snp"
	self.masks.spider = {}
	self.masks.spider.unit = "units/pd2_dlc_gage_snp/masks/msk_spider/msk_spider"
	self.masks.spider.name_id = "bm_msk_spider"
	self.masks.spider.pcs = {}
	self.masks.spider.value = 0
	self.masks.spider.qlvl = 0
	self.masks.spider.texture_bundle_folder = "gage_pack_snp"
	self.masks.spider.dlc = "gage_pack_snp"
	self.masks.mantis = {}
	self.masks.mantis.unit = "units/pd2_dlc_gage_snp/masks/msk_mantis/msk_mantis"
	self.masks.mantis.name_id = "bm_msk_mantis"
	self.masks.mantis.pcs = {}
	self.masks.mantis.value = 0
	self.masks.mantis.qlvl = 0
	self.masks.mantis.texture_bundle_folder = "gage_pack_snp"
	self.masks.mantis.dlc = "gage_pack_snp"
	self.masks.wasp = {}
	self.masks.wasp.unit = "units/pd2_dlc_gage_snp/masks/msk_wasp/msk_wasp"
	self.masks.wasp.name_id = "bm_msk_wasp"
	self.masks.wasp.pcs = {}
	self.masks.wasp.value = 0
	self.masks.wasp.qlvl = 0
	self.masks.wasp.texture_bundle_folder = "gage_pack_snp"
	self.masks.wasp.dlc = "gage_pack_snp"
	self.masks.skullhard = {}
	self.masks.skullhard.unit = "units/payday2/masks/msk_skullhard/msk_skullhard"
	self.masks.skullhard.name_id = "bm_msk_skullhard"
	self.masks.skullhard.pcs = {}
	self.masks.skullhard.value = 0
	self.masks.skullhard.qlvl = 0
	self.masks.skullhard.infamous = true
	self.masks.skullhard.sort_number = 30
	self.masks.skullveryhard = {}
	self.masks.skullveryhard.unit = "units/payday2/masks/msk_skullveryhard/msk_skullveryhard"
	self.masks.skullveryhard.name_id = "bm_msk_skullveryhard"
	self.masks.skullveryhard.pcs = {}
	self.masks.skullveryhard.value = 0
	self.masks.skullveryhard.qlvl = 0
	self.masks.skullveryhard.infamous = true
	self.masks.skullveryhard.sort_number = 31
	self.masks.skulloverkill = {}
	self.masks.skulloverkill.unit = "units/payday2/masks/msk_skulloverkill/msk_skulloverkill"
	self.masks.skulloverkill.name_id = "bm_msk_skulloverkill"
	self.masks.skulloverkill.pcs = {}
	self.masks.skulloverkill.value = 0
	self.masks.skulloverkill.qlvl = 0
	self.masks.skulloverkill.infamous = true
	self.masks.skulloverkill.sort_number = 32
	self.masks.gitgud_e_wish = {}
	self.masks.gitgud_e_wish.unit = "units/pd2_dlc_gitgud/masks/e_wish/msk_gitgud_e_wish"
	self.masks.gitgud_e_wish.name_id = "bm_e_wish"
	self.masks.gitgud_e_wish.pcs = {}
	self.masks.gitgud_e_wish.value = 0
	self.masks.gitgud_e_wish.qlvl = 0
	self.masks.gitgud_e_wish.infamous = true
	self.masks.gitgud_e_wish.texture_bundle_folder = "gitgud"
	self.masks.gitgud_e_wish.sort_number = 33
	self.masks.skulloverkillplus = {}
	self.masks.skulloverkillplus.unit = "units/payday2/masks/msk_skulloverkillplus/msk_skulloverkillplus"
	self.masks.skulloverkillplus.name_id = "bm_msk_skulloverkillplus"
	self.masks.skulloverkillplus.pcs = {}
	self.masks.skulloverkillplus.value = 0
	self.masks.skulloverkillplus.qlvl = 0
	self.masks.skulloverkillplus.infamous = true
	self.masks.skulloverkillplus.sort_number = 34
	self.masks.gitgud_sm_wish = {}
	self.masks.gitgud_sm_wish.unit = "units/pd2_dlc_gitgud/masks/sm_wish/msk_gitgud_sm_wish"
	self.masks.gitgud_sm_wish.name_id = "bm_sm_wish"
	self.masks.gitgud_sm_wish.pcs = {}
	self.masks.gitgud_sm_wish.value = 0
	self.masks.gitgud_sm_wish.qlvl = 0
	self.masks.gitgud_sm_wish.infamous = true
	self.masks.gitgud_sm_wish.texture_bundle_folder = "gitgud"
	self.masks.gitgud_sm_wish.sort_number = 35
	self.masks.metalhead = {}
	self.masks.metalhead.unit = "units/pd2_poetry_winners/masks/veggie/msk_metalhead"
	self.masks.metalhead.name_id = "bm_msk_metalhead"
	self.masks.metalhead.pcs = {}
	self.masks.metalhead.value = 0
	self.masks.metalhead.dlc = "poetry_soundtrack"
	self.masks.metalhead.global_value = "poetry_soundtrack"
	self.masks.tcn = {}
	self.masks.tcn.unit = "units/pd2_poetry_winners/masks/tcn/msk_tcn"
	self.masks.tcn.name_id = "bm_msk_tcn"
	self.masks.tcn.pcs = {}
	self.masks.tcn.value = 0
	self.masks.tcn.dlc = "poetry_soundtrack"
	self.masks.tcn.global_value = "poetry_soundtrack"
	self.masks.surprise = {}
	self.masks.surprise.unit = "units/pd2_poetry_winners/masks/shaegro/msk_surprise"
	self.masks.surprise.name_id = "bm_msk_surprise"
	self.masks.surprise.pcs = {}
	self.masks.surprise.value = 0
	self.masks.surprise.dlc = "poetry_soundtrack"
	self.masks.surprise.global_value = "poetry_soundtrack"
	self.masks.optimist_prime = {}
	self.masks.optimist_prime.unit = "units/pd2_poetry_winners/masks/optimist_prime/msk_optimist_prime"
	self.masks.optimist_prime.name_id = "bm_msk_optimist_prime"
	self.masks.optimist_prime.pcs = {}
	self.masks.optimist_prime.value = 0
	self.masks.optimist_prime.dlc = "poetry_soundtrack"
	self.masks.optimist_prime.global_value = "poetry_soundtrack"
	self.masks.samurai = {}
	self.masks.samurai.unit = "units/payday2/masks/msk_samurai/msk_samurai"
	self.masks.samurai.name_id = "bm_msk_samurai"
	self.masks.samurai.pcs = {}
	self.masks.samurai.value = 0
	self.masks.samurai.qlvl = 0
	self.masks.samurai.infamous = true
	self.masks.twitch_orc = {}
	self.masks.twitch_orc.unit = "units/pd2_twitch_pack/masks/msk_twitch_orc/msk_twitch_orc"
	self.masks.twitch_orc.name_id = "bm_msk_twitch_orc"
	self.masks.twitch_orc.pcs = {}
	self.masks.twitch_orc.value = 0
	self.masks.twitch_orc.qlvl = 0
	self.masks.twitch_orc.texture_bundle_folder = "twitch_pack"
	self.masks.twitch_orc.dlc = "twitch_pack"
	self.masks.twitch_orc.sort_number = 3
	self.masks.ancient = {}
	self.masks.ancient.unit = "units/pd2_twitch_pack/masks/msk_ancient/msk_ancient"
	self.masks.ancient.name_id = "bm_msk_ancient"
	self.masks.ancient.pcs = {}
	self.masks.ancient.value = 0
	self.masks.ancient.qlvl = 0
	self.masks.ancient.texture_bundle_folder = "twitch_pack"
	self.masks.ancient.dlc = "twitch_pack"
	self.masks.ancient.sort_number = 3
	self.masks.unicorn = {}
	self.masks.unicorn.unit = "units/payday2/masks/msk_unicorn/msk_unicorn"
	self.masks.unicorn.name_id = "bm_msk_unicorn"
	self.masks.unicorn.pcs = {}
	self.masks.unicorn.value = 0
	self.masks.unicorn.dlc = "pd2_clan"
	self.masks.unicorn.sort_number = 4
	self.masks.franklin = {}
	self.masks.franklin.unit = "units/pd2_dlc_big/masks/msk_franklin/msk_franklin"
	self.masks.franklin.name_id = "bm_msk_franklin"
	self.masks.franklin.pcs = {}
	self.masks.franklin.value = 0
	self.masks.franklin.qlvl = 0
	self.masks.franklin.dlc = "big_bank"
	self.masks.franklin.texture_bundle_folder = "big_bank"
	self.masks.lincoln = {}
	self.masks.lincoln.unit = "units/pd2_dlc_big/masks/msk_lincoln/msk_lincoln"
	self.masks.lincoln.name_id = "bm_msk_lincoln"
	self.masks.lincoln.pcs = {}
	self.masks.lincoln.value = 0
	self.masks.lincoln.qlvl = 0
	self.masks.lincoln.dlc = "big_bank"
	self.masks.lincoln.texture_bundle_folder = "big_bank"
	self.masks.grant = {}
	self.masks.grant.unit = "units/pd2_dlc_big/masks/msk_grant/msk_grant"
	self.masks.grant.name_id = "bm_msk_grant"
	self.masks.grant.pcs = {}
	self.masks.grant.value = 0
	self.masks.grant.qlvl = 0
	self.masks.grant.dlc = "big_bank"
	self.masks.grant.texture_bundle_folder = "big_bank"
	self.masks.washington = {}
	self.masks.washington.unit = "units/pd2_dlc_big/masks/msk_washington/msk_washington"
	self.masks.washington.name_id = "bm_msk_washington"
	self.masks.washington.pcs = {}
	self.masks.washington.value = 0
	self.masks.washington.qlvl = 0
	self.masks.washington.dlc = "big_bank"
	self.masks.washington.texture_bundle_folder = "big_bank"
	self.masks.silverback = {}
	self.masks.silverback.unit = "units/pd2_dlc_gage_shot/masks/silverback/msk_silverback"
	self.masks.silverback.name_id = "bm_msk_silverback"
	self.masks.silverback.pcs = {}
	self.masks.silverback.value = 0
	self.masks.silverback.dlc = "gage_pack_shotgun"
	self.masks.silverback.texture_bundle_folder = "gage_pack_shotgun"
	self.masks.mandril = {}
	self.masks.mandril.unit = "units/pd2_dlc_gage_shot/masks/mandrill/msk_mandril"
	self.masks.mandril.name_id = "bm_msk_mandril"
	self.masks.mandril.pcs = {}
	self.masks.mandril.value = 0
	self.masks.mandril.dlc = "gage_pack_shotgun"
	self.masks.mandril.texture_bundle_folder = "gage_pack_shotgun"
	self.masks.skullmonkey = {}
	self.masks.skullmonkey.unit = "units/pd2_dlc_gage_shot/masks/skullmonkey/msk_skullmonkey"
	self.masks.skullmonkey.name_id = "bm_msk_skullmonkey"
	self.masks.skullmonkey.pcs = {}
	self.masks.skullmonkey.value = 0
	self.masks.skullmonkey.dlc = "gage_pack_shotgun"
	self.masks.skullmonkey.texture_bundle_folder = "gage_pack_shotgun"
	self.masks.orangutang = {}
	self.masks.orangutang.unit = "units/pd2_dlc_gage_shot/masks/orangutang/msk_orangutang"
	self.masks.orangutang.name_id = "bm_msk_orangutang"
	self.masks.orangutang.pcs = {}
	self.masks.orangutang.value = 0
	self.masks.orangutang.dlc = "gage_pack_shotgun"
	self.masks.orangutang.texture_bundle_folder = "gage_pack_shotgun"
	self.masks.galax = {}
	self.masks.galax.unit = "units/pd2_dlc_gage_assault/masks/msk_galax/msk_galax"
	self.masks.galax.name_id = "bm_msk_galax"
	self.masks.galax.pcs = {}
	self.masks.galax.value = 0
	self.masks.galax.dlc = "gage_pack_assault"
	self.masks.galax.texture_bundle_folder = "gage_pack_assault"
	self.masks.crowgoblin = {}
	self.masks.crowgoblin.unit = "units/pd2_dlc_gage_assault/masks/msk_crowgoblin/msk_crowgoblin"
	self.masks.crowgoblin.name_id = "bm_msk_crowgoblin"
	self.masks.crowgoblin.pcs = {}
	self.masks.crowgoblin.value = 0
	self.masks.crowgoblin.dlc = "gage_pack_assault"
	self.masks.crowgoblin.texture_bundle_folder = "gage_pack_assault"
	self.masks.evil = {}
	self.masks.evil.unit = "units/pd2_dlc_gage_assault/masks/msk_evil/msk_evil"
	self.masks.evil.name_id = "bm_msk_evil"
	self.masks.evil.pcs = {}
	self.masks.evil.value = 0
	self.masks.evil.dlc = "gage_pack_assault"
	self.masks.evil.texture_bundle_folder = "gage_pack_assault"
	self.masks.volt = {}
	self.masks.volt.unit = "units/pd2_dlc_gage_assault/masks/msk_volt/msk_volt"
	self.masks.volt.name_id = "bm_msk_volt"
	self.masks.volt.pcs = {}
	self.masks.volt.value = 0
	self.masks.volt.dlc = "gage_pack_assault"
	self.masks.volt.texture_bundle_folder = "gage_pack_assault"
	self.masks.white_wolf = {}
	self.masks.white_wolf.unit = "units/pd2_dlc_miami/masks/msk_white_wolf/msk_white_wolf"
	self.masks.white_wolf.name_id = "bm_msk_white_wolf"
	self.masks.white_wolf.pcs = {}
	self.masks.white_wolf.value = 0
	self.masks.white_wolf.dlc = "hl_miami"
	self.masks.white_wolf.texture_bundle_folder = "hl_miami"
	self.masks.owl = {}
	self.masks.owl.unit = "units/pd2_dlc_miami/masks/msk_owl/msk_owl"
	self.masks.owl.name_id = "bm_msk_owl"
	self.masks.owl.pcs = {}
	self.masks.owl.value = 0
	self.masks.owl.dlc = "hl_miami"
	self.masks.owl.texture_bundle_folder = "hl_miami"
	self.masks.rabbit = {}
	self.masks.rabbit.unit = "units/pd2_dlc_miami/masks/msk_rabbit/msk_rabbit"
	self.masks.rabbit.name_id = "bm_msk_rabbit"
	self.masks.rabbit.pcs = {}
	self.masks.rabbit.value = 0
	self.masks.rabbit.dlc = "hl_miami"
	self.masks.rabbit.texture_bundle_folder = "hl_miami"
	self.masks.pig = {}
	self.masks.pig.unit = "units/pd2_dlc_miami/masks/msk_pig/msk_pig"
	self.masks.pig.name_id = "bm_msk_pig"
	self.masks.pig.pcs = {}
	self.masks.pig.value = 0
	self.masks.pig.dlc = "hl_miami"
	self.masks.pig.texture_bundle_folder = "hl_miami"
	self.masks.panther = {}
	self.masks.panther.unit = "units/pd2_dlc_miami/masks/msk_panther/msk_panther"
	self.masks.panther.name_id = "bm_msk_panther"
	self.masks.panther.pcs = {}
	self.masks.panther.value = 0
	self.masks.panther.dlc = "hlm_game"
	self.masks.panther.texture_bundle_folder = "hl_miami"
	self.masks.rooster = {}
	self.masks.rooster.unit = "units/pd2_dlc_miami/masks/msk_rooster/msk_rooster"
	self.masks.rooster.name_id = "bm_msk_rooster"
	self.masks.rooster.pcs = {}
	self.masks.rooster.value = 0
	self.masks.rooster.dlc = "hlm_game"
	self.masks.rooster.texture_bundle_folder = "hl_miami"
	self.masks.horse = {}
	self.masks.horse.unit = "units/pd2_dlc_miami/masks/msk_horse/msk_horse"
	self.masks.horse.name_id = "bm_msk_horse"
	self.masks.horse.pcs = {}
	self.masks.horse.value = 0
	self.masks.horse.dlc = "hlm_game"
	self.masks.horse.texture_bundle_folder = "hl_miami"
	self.masks.tiger = {}
	self.masks.tiger.unit = "units/pd2_dlc_miami/masks/msk_tiger/msk_tiger"
	self.masks.tiger.name_id = "bm_msk_tiger"
	self.masks.tiger.pcs = {}
	self.masks.tiger.value = 0
	self.masks.tiger.dlc = "hlm_game"
	self.masks.tiger.texture_bundle_folder = "hl_miami"
	self.masks.combusto = {}
	self.masks.combusto.unit = "units/pd2_crimefest_2014/oct19/masks/combusto/msk_combusto"
	self.masks.combusto.name_id = "bm_msk_combusto"
	self.masks.combusto.pcs = {}
	self.masks.combusto.dlc = "pd2_clan"
	self.masks.combusto.value = 0
	self.masks.combusto.sort_number = 5
	self.masks.spackle = {}
	self.masks.spackle.unit = "units/pd2_crimefest_2014/oct19/masks/spackle/msk_spackle"
	self.masks.spackle.name_id = "bm_msk_spackle"
	self.masks.spackle.pcs = {}
	self.masks.spackle.dlc = "pd2_clan"
	self.masks.spackle.value = 0
	self.masks.spackle.sort_number = 5
	self.masks.jw_shades = {}
	self.masks.jw_shades.unit = "units/pd2_crimefest_2014/oct22/masks/jw_shades/msk_jw_shades"
	self.masks.jw_shades.name_id = "bm_msk_jw_shades"
	self.masks.jw_shades.pcs = {}
	self.masks.jw_shades.value = 0
	self.masks.jw_shades.type = "glasses"
	self.masks.jw_shades.skip_mask_on_sequence = true
	self.masks.jw_shades.global_value = "infamous"
	self.masks.stoneface = {}
	self.masks.stoneface.unit = "units/pd2_crimefest_2014/oct22/masks/stoneface/msk_stoneface"
	self.masks.stoneface.name_id = "bm_msk_stoneface"
	self.masks.stoneface.pcs = {}
	self.masks.stoneface.value = 0
	self.masks.stoneface.dlc = "pd2_clan"
	self.masks.stoneface.type = "glasses"
	self.masks.stoneface.skip_mask_on_sequence = true
	self.masks.stoneface.sort_number = 7
	self.masks.wayfarer = {}
	self.masks.wayfarer.unit = "units/pd2_crimefest_2014/oct22/masks/wayfarer/msk_wayfarer"
	self.masks.wayfarer.name_id = "bm_msk_wayfarer"
	self.masks.wayfarer.pcs = {}
	self.masks.wayfarer.value = 0
	self.masks.wayfarer.dlc = "pd2_clan"
	self.masks.wayfarer.type = "glasses"
	self.masks.wayfarer.skip_mask_on_sequence = true
	self.masks.wayfarer.sort_number = 7
	self.masks.smiley = {}
	self.masks.smiley.unit = "units/pd2_crimefest_2014/oct23/masks/smiley/msk_smiley"
	self.masks.smiley.name_id = "bm_msk_smiley"
	self.masks.smiley.pcs = {}
	self.masks.smiley.dlc = "pd2_clan"
	self.masks.smiley.value = 0
	self.masks.smiley.sort_number = 6
	self.masks.gumbo = {}
	self.masks.gumbo.unit = "units/pd2_crimefest_2014/oct23/masks/gumbo/msk_gumbo"
	self.masks.gumbo.name_id = "bm_msk_gumbo"
	self.masks.gumbo.pcs = {}
	self.masks.gumbo.dlc = "pd2_clan"
	self.masks.gumbo.value = 0
	self.masks.gumbo.sort_number = 6
	self.masks.crazy_lion = {}
	self.masks.crazy_lion.unit = "units/pd2_crimefest_2014/oct26/masks/msk_crazy_lion/crazy_lion_mask"
	self.masks.crazy_lion.name_id = "bm_msk_crazy_lion"
	self.masks.crazy_lion.pcs = {}
	self.masks.crazy_lion.dlc = "pd2_clan"
	self.masks.crazy_lion.value = 0
	self.masks.crazy_lion.sort_number = 8
	self.masks.churchill = {}
	self.masks.churchill.unit = "units/pd2_dlc_gage_historical/masks/churchill/msk_churchill"
	self.masks.churchill.name_id = "bm_msk_churchill"
	self.masks.churchill.pcs = {}
	self.masks.churchill.value = 0
	self.masks.churchill.dlc = "gage_pack_historical"
	self.masks.churchill.texture_bundle_folder = "gage_pack_historical"
	self.masks.red_hurricane = {}
	self.masks.red_hurricane.unit = "units/pd2_dlc_gage_historical/masks/red_hurricane/msk_red_hurricane"
	self.masks.red_hurricane.name_id = "bm_msk_red_hurricane"
	self.masks.red_hurricane.pcs = {}
	self.masks.red_hurricane.value = 0
	self.masks.red_hurricane.dlc = "gage_pack_historical"
	self.masks.red_hurricane.texture_bundle_folder = "gage_pack_historical"
	self.masks.patton = {}
	self.masks.patton.unit = "units/pd2_dlc_gage_historical/masks/patton/msk_patton"
	self.masks.patton.name_id = "bm_msk_patton"
	self.masks.patton.pcs = {}
	self.masks.patton.value = 0
	self.masks.patton.dlc = "gage_pack_historical"
	self.masks.patton.texture_bundle_folder = "gage_pack_historical"
	self.masks.de_gaulle = {}
	self.masks.de_gaulle.unit = "units/pd2_dlc_gage_historical/masks/de_gaulle/msk_de_gaulle"
	self.masks.de_gaulle.name_id = "bm_msk_de_gaulle"
	self.masks.de_gaulle.pcs = {}
	self.masks.de_gaulle.value = 0
	self.masks.de_gaulle.dlc = "gage_pack_historical"
	self.masks.de_gaulle.texture_bundle_folder = "gage_pack_historical"
	self.masks.msk_grizel = {}
	self.masks.msk_grizel.unit = "units/pd2_dlc_clover/masks/msk_grizel/msk_grizel"
	self.masks.msk_grizel.name_id = "bm_msk_msk_grizel"
	self.masks.msk_grizel.pcs = {}
	self.masks.msk_grizel.value = 0
	self.masks.msk_grizel.dlc = "character_pack_clover"
	self.masks.msk_grizel.texture_bundle_folder = "character_pack_clover"
	self.masks.grizel_clean = {}
	self.masks.grizel_clean.unit = "units/pd2_dlc_clover/masks/msk_clover_begins/msk_clover_begins"
	self.masks.grizel_clean.name_id = "bm_msk_grizel_clean"
	self.masks.grizel_clean.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.grizel_clean.value = 0
	self.masks.grizel_clean.dlc = "character_pack_clover"
	self.masks.grizel_clean.texture_bundle_folder = "character_pack_clover"
	self.masks.medusa = {}
	self.masks.medusa.unit = "units/pd2_indiana/masks/medusa/msk_medusa"
	self.masks.medusa.name_id = "bm_msk_medusa"
	self.masks.medusa.pcs = {}
	self.masks.medusa.value = 0
	self.masks.medusa.dlc = "hope_diamond"
	self.masks.medusa.texture_bundle_folder = "character_pack_clover"
	self.masks.anubis = {}
	self.masks.anubis.unit = "units/pd2_indiana/masks/anubis/msk_anubis"
	self.masks.anubis.name_id = "bm_msk_anubis"
	self.masks.anubis.type = "helmet"
	self.masks.anubis.pcs = {}
	self.masks.anubis.value = 0
	self.masks.anubis.dlc = "hope_diamond"
	self.masks.anubis.texture_bundle_folder = "character_pack_clover"
	self.masks.pazuzu = {}
	self.masks.pazuzu.unit = "units/pd2_indiana/masks/pazuzu/msk_pazuzu"
	self.masks.pazuzu.name_id = "bm_msk_pazuzu"
	self.masks.pazuzu.pcs = {}
	self.masks.pazuzu.value = 0
	self.masks.pazuzu.dlc = "hope_diamond"
	self.masks.pazuzu.texture_bundle_folder = "character_pack_clover"
	self.masks.cursed_crown = {}
	self.masks.cursed_crown.unit = "units/pd2_indiana/masks/msk_cursed_crown/msk_cursed_crown"
	self.masks.cursed_crown.name_id = "bm_msk_cursed_crown"
	self.masks.cursed_crown.pcs = {}
	self.masks.cursed_crown.value = 0
	self.masks.cursed_crown.dlc = "hope_diamond"
	self.masks.cursed_crown.texture_bundle_folder = "character_pack_clover"
	self.masks.butcher = {}
	self.masks.butcher.unit = "units/pd2_dlc_dragan/masks/butcher/msk_butcher"
	self.masks.butcher.name_id = "bm_msk_butcher"
	self.masks.butcher.pcs = {}
	self.masks.butcher.value = 0
	self.masks.butcher.dlc = "the_bomb"
	self.masks.butcher.texture_bundle_folder = "the_bomb"
	self.masks.doctor = {}
	self.masks.doctor.unit = "units/pd2_dlc_cro/masks/msk_doctor/msk_doctor"
	self.masks.doctor.name_id = "bm_msk_doctor"
	self.masks.doctor.pcs = {}
	self.masks.doctor.value = 0
	self.masks.doctor.dlc = "the_bomb"
	self.masks.doctor.type = "helmet"
	self.masks.doctor.texture_bundle_folder = "the_bomb"
	self.masks.doctor.skip_mask_on_sequence = true
	self.masks.tech_lion = {}
	self.masks.tech_lion.unit = "units/pd2_dlc_cro/masks/msk_tech_lion/msk_tech_lion"
	self.masks.tech_lion.name_id = "bm_msk_tech_lion"
	self.masks.tech_lion.pcs = {}
	self.masks.tech_lion.value = 0
	self.masks.tech_lion.dlc = "the_bomb"
	self.masks.tech_lion.texture_bundle_folder = "the_bomb"
	self.masks.lady_butcher = {}
	self.masks.lady_butcher.unit = "units/pd2_dlc_cro/masks/msk_butcher/msk_butcher"
	self.masks.lady_butcher.name_id = "bm_msk_lady_butcher"
	self.masks.lady_butcher.pcs = {}
	self.masks.lady_butcher.value = 0
	self.masks.lady_butcher.dlc = "the_bomb"
	self.masks.lady_butcher.texture_bundle_folder = "the_bomb"
	self.masks.nun_town = {}
	self.masks.nun_town.unit = "units/pd2_dlc_goty/masks/nun_town/msk_nun_town"
	self.masks.nun_town.name_id = "bm_msk_nun_town"
	self.masks.nun_town.pcs = {}
	self.masks.nun_town.value = 0
	self.masks.nun_town.dlc = "goty_heist_bundle_2014"
	self.masks.nun_town.dlc_list = {
		"armored_transport",
		"big_bank",
		"hl_miami",
		"hope_diamond"
	}
	self.masks.nun_town.texture_bundle_folder = "pd2_goty"
	self.masks.robo_arnold = {}
	self.masks.robo_arnold.unit = "units/pd2_dlc_goty/masks/robo_arnold/msk_robo_arnold"
	self.masks.robo_arnold.name_id = "bm_msk_robo_arnold"
	self.masks.robo_arnold.pcs = {}
	self.masks.robo_arnold.value = 0
	self.masks.robo_arnold.dlc = "goty_weapon_bundle_2014"
	self.masks.robo_arnold.dlc_list = {
		"gage_pack",
		"gage_pack_lmg",
		"gage_pack_jobs",
		"gage_pack_snp",
		"gage_pack_shotgun",
		"gage_pack_assault",
		"gage_pack_historical"
	}
	self.masks.robo_arnold.texture_bundle_folder = "pd2_goty"
	self.masks.arch_nemesis = {}
	self.masks.arch_nemesis.unit = "units/pd2_dlc_goty/masks/arch_nemesis/msk_arch_nemesis"
	self.masks.arch_nemesis.name_id = "bm_msk_arch_nemesis"
	self.masks.arch_nemesis.pcs = {}
	self.masks.arch_nemesis.value = 0
	self.masks.arch_nemesis.type = "helmet"
	self.masks.arch_nemesis.default_blueprint = {
		textures = "no_color_full_material",
		materials = "deep_bronze"
	}
	self.masks.arch_nemesis.dlc = "goty_dlc_bundle_2014"
	self.masks.arch_nemesis.dlc_list = {
		"character_pack_clover",
		"armored_transport",
		"big_bank",
		"hl_miami",
		"hope_diamond",
		"gage_pack",
		"gage_pack_lmg",
		"gage_pack_jobs",
		"gage_pack_snp",
		"gage_pack_shotgun",
		"gage_pack_assault",
		"gage_pack_historical"
	}
	self.masks.arch_nemesis.texture_bundle_folder = "pd2_goty"
	self.masks.carnotaurus = {}
	self.masks.carnotaurus.unit = "units/pd2_dlc_akm4_modpack/masks/carnotaurus/msk_carnotaurus"
	self.masks.carnotaurus.name_id = "bm_msk_carnotaurus"
	self.masks.carnotaurus.pcs = {}
	self.masks.carnotaurus.value = 0
	self.masks.carnotaurus.texture_bundle_folder = "dlc_akm4"
	self.masks.carnotaurus.dlc = "akm4_pack"
	self.masks.triceratops = {}
	self.masks.triceratops.unit = "units/pd2_dlc_akm4_modpack/masks/triceratops/msk_triceratops"
	self.masks.triceratops.name_id = "bm_msk_triceratops"
	self.masks.triceratops.pcs = {}
	self.masks.triceratops.value = 0
	self.masks.triceratops.texture_bundle_folder = "dlc_akm4"
	self.masks.triceratops.dlc = "akm4_pack"
	self.masks.pachy = {}
	self.masks.pachy.unit = "units/pd2_dlc_akm4_modpack/masks/pachy/msk_pachy"
	self.masks.pachy.name_id = "bm_msk_pachy"
	self.masks.pachy.pcs = {}
	self.masks.pachy.value = 0
	self.masks.pachy.texture_bundle_folder = "dlc_akm4"
	self.masks.pachy.dlc = "akm4_pack"
	self.masks.velociraptor = {}
	self.masks.velociraptor.unit = "units/pd2_dlc_akm4_modpack/masks/velociraptor/msk_velociraptor"
	self.masks.velociraptor.name_id = "bm_msk_velociraptor"
	self.masks.velociraptor.pcs = {}
	self.masks.velociraptor.value = 0
	self.masks.velociraptor.texture_bundle_folder = "dlc_akm4"
	self.masks.velociraptor.dlc = "akm4_pack"
	self.masks.champion_dallas = {}
	self.masks.champion_dallas.unit = "units/pd2_hw_boxing/masks/champion_dallas/msk_champion_dallas"
	self.masks.champion_dallas.name_id = "bm_msk_champion_dallas"
	self.masks.champion_dallas.pcs = {}
	self.masks.champion_dallas.value = 0
	self.masks.champion_dallas.dlc = nil
	self.masks.champion_dallas.texture_bundle_folder = "pd2_hw_boxing"
	self.masks.champion_dallas.sort_number = 10
	if SystemInfo:distribution() == Idstring("STEAM") then
		self.masks.area51 = {}
		self.masks.area51.unit = "units/pd2_dlc_alienware/masks/area51/msk_area51"
		self.masks.area51.name_id = "bm_msk_area51"
		self.masks.area51.texture_bundle_folder = "alienware_alpha"
		self.masks.area51.pcs = {}
		self.masks.area51.value = 0
		self.masks.area51.dlc = "alienware_alpha"
		self.masks.area51.type = "helmet"
		self.masks.area51.sort_number = 5
		self.masks.alien_helmet = {}
		self.masks.alien_helmet.unit = "units/pd2_dlc_alienware/masks/alien_helmet/msk_alien_helmet"
		self.masks.alien_helmet.name_id = "bm_msk_alien_helmet"
		self.masks.alien_helmet.texture_bundle_folder = "alienware_alpha"
		self.masks.alien_helmet.pcs = {}
		self.masks.alien_helmet.value = 0
		self.masks.alien_helmet.dlc = "alienware_alpha"
		self.masks.alien_helmet.type = "helmet"
		self.masks.alien_helmet.default_blueprint = {
			textures = "no_color_full_material",
			materials = "gunmetal"
		}
		self.masks.alien_helmet.sort_number = 5
	end
	self.masks.infamy_lurker = {}
	self.masks.infamy_lurker.unit = "units/pd2_dlc_infamy/masks/msk_infamy_lurker/msk_infamy_lurker"
	self.masks.infamy_lurker.name_id = "bm_msk_infamy_lurker"
	self.masks.infamy_lurker.global_value = "infamy"
	self.masks.infamy_lurker.texture_bundle_folder = "infamous"
	self.masks.infamy_lurker.pcs = {}
	self.masks.infamy_lurker.value = 0
	self.masks.infamy_lurker.infamy_lock = "infamy_maskpack_lurker"
	self.masks.infamy_hood = {}
	self.masks.infamy_hood.unit = "units/pd2_dlc_infamy/masks/msk_infamy_hood/msk_infamy_hood"
	self.masks.infamy_hood.name_id = "bm_msk_infamy_hood"
	self.masks.infamy_hood.global_value = "infamy"
	self.masks.infamy_hood.texture_bundle_folder = "infamous"
	self.masks.infamy_hood.pcs = {}
	self.masks.infamy_hood.value = 0
	self.masks.infamy_hood.type = "helmet"
	self.masks.infamy_hood.infamy_lock = "infamy_maskpack_hood"
	self.masks.ranger = {}
	self.masks.ranger.unit = "units/pd2_dlc_infamy/masks/ranger/msk_ranger"
	self.masks.ranger.name_id = "bm_msk_ranger"
	self.masks.ranger.global_value = "infamy"
	self.masks.ranger.texture_bundle_folder = "infamous"
	self.masks.ranger.pcs = {}
	self.masks.ranger.value = 0
	self.masks.ranger.type = "helmet"
	self.masks.ranger.infamy_lock = "infamy_maskpack_ranger"
	self.masks.punk = {}
	self.masks.punk.unit = "units/pd2_dlc_infamy/masks/punk/msk_punk"
	self.masks.punk.name_id = "bm_msk_punk"
	self.masks.punk.global_value = "infamy"
	self.masks.punk.texture_bundle_folder = "infamous"
	self.masks.punk.pcs = {}
	self.masks.punk.value = 0
	self.masks.punk.infamy_lock = "infamy_maskpack_punk"
	self.masks.daft = {}
	self.masks.daft.unit = "units/pd2_dlc_infamy/masks/daft/msk_daft"
	self.masks.daft.name_id = "bm_msk_daft"
	self.masks.daft.global_value = "infamy"
	self.masks.daft.texture_bundle_folder = "infamous"
	self.masks.daft.pcs = {}
	self.masks.daft.value = 0
	self.masks.daft.infamy_lock = "infamy_maskpack_daft"
	self.masks.pain = {}
	self.masks.pain.unit = "units/pd2_dlc_infamy/masks/pain/msk_pain"
	self.masks.pain.name_id = "bm_msk_pain"
	self.masks.pain.global_value = "infamy"
	self.masks.pain.texture_bundle_folder = "infamous"
	self.masks.pain.pcs = {}
	self.masks.pain.value = 0
	self.masks.pain.type = "helmet"
	self.masks.pain.skip_mask_on_sequence = true
	self.masks.pain.infamy_lock = "infamy_maskpack_pain"
	self.masks.destroyer = {}
	self.masks.destroyer.unit = "units/pd2_dlc_infamy/masks/destroyer/msk_destroyer"
	self.masks.destroyer.name_id = "bm_msk_destroyer"
	self.masks.destroyer.global_value = "infamy"
	self.masks.destroyer.texture_bundle_folder = "infamous"
	self.masks.destroyer.pcs = {}
	self.masks.destroyer.value = 0
	self.masks.destroyer.infamy_lock = "infamy_maskpack_destroyer"
	self.masks.balaclava_chains = {}
	self.masks.balaclava_chains.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_chains/msk_balaclava_chains"
	self.masks.balaclava_chains.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_chains.type = "helmet"
	self.masks.balaclava_chains.inaccessible = true
	self.masks.balaclava_wolf = {}
	self.masks.balaclava_wolf.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_wolf/msk_balaclava_wolf"
	self.masks.balaclava_wolf.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_wolf.type = "helmet"
	self.masks.balaclava_wolf.inaccessible = true
	self.masks.balaclava_clover = {}
	self.masks.balaclava_clover.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_clover/msk_balaclava_clover"
	self.masks.balaclava_clover.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_clover.type = "helmet"
	self.masks.balaclava_clover.inaccessible = true
	self.masks.balaclava_dallas = {}
	self.masks.balaclava_dallas.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_dallas/msk_balaclava_dallas"
	self.masks.balaclava_dallas.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_dallas.type = "helmet"
	self.masks.balaclava_dallas.inaccessible = true
	self.masks.balaclava_dragan = {}
	self.masks.balaclava_dragan.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_dragan/msk_balaclava_dragan"
	self.masks.balaclava_dragan.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_dragan.type = "helmet"
	self.masks.balaclava_dragan.inaccessible = true
	self.masks.balaclava_hoxton = {}
	self.masks.balaclava_hoxton.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_hoxton/msk_balaclava_hoxton"
	self.masks.balaclava_hoxton.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_hoxton.type = "helmet"
	self.masks.balaclava_hoxton.inaccessible = true
	self.masks.balaclava_john_wick = {}
	self.masks.balaclava_john_wick.unit = "units/pd2_dlc_infamy/masks/msk_balaclava_john_wick/msk_balaclava_john_wick"
	self.masks.balaclava_john_wick.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_john_wick.type = "helmet"
	self.masks.balaclava_john_wick.inaccessible = true
	self.masks.balaclava_sokol = {}
	self.masks.balaclava_sokol.unit = "units/pd2_dlc_character_sokol/masks/msk_balaclava_sokol/msk_balaclava_sokol"
	self.masks.balaclava_sokol.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_sokol.type = "helmet"
	self.masks.balaclava_sokol.inaccessible = true
	self.masks.balaclava_wild = {}
	self.masks.balaclava_wild.unit = "units/pd2_dlc_wild/masks/msk_balaclava_wild/msk_balaclava_wild"
	self.masks.balaclava_wild.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_wild.type = "helmet"
	self.masks.balaclava_wild.inaccessible = true
	self.masks.balaclava_chico = {}
	self.masks.balaclava_chico.unit = "units/pd2_dlc_chico/masks/msk_balaclava_chico/msk_balaclava_chico"
	self.masks.balaclava_chico.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_chico.type = "helmet"
	self.masks.balaclava_chico.inaccessible = true
	self.masks.balaclava_max = {}
	self.masks.balaclava_max.unit = "units/pd2_dlc_max/masks/msk_balaclava_max/msk_balaclava_max"
	self.masks.balaclava_max.name_id = "bm_msk_cheat_error"
	self.masks.balaclava_max.type = "helmet"
	self.masks.balaclava_max.inaccessible = true
	self.masks.balaclava = {}
	self.masks.balaclava.name_id = "bm_msk_balaclava"
	self.masks.balaclava.global_value = "infamy"
	self.masks.balaclava.value = 0
	self.masks.balaclava.pcs = {}
	self.masks.balaclava.type = "helmet"
	self.masks.balaclava.texture_bundle_folder = "infamous"
	self.masks.balaclava.infamy_lock = "infamy_maskpack_balaclava"
	self.masks.balaclava.characters = {
		dallas = "balaclava_dallas",
		wolf = "balaclava_wolf",
		hoxton = "balaclava_dragan",
		chains = "balaclava_chains",
		jowi = "balaclava_john_wick",
		old_hoxton = "balaclava_hoxton",
		female_1 = "balaclava_clover",
		dragan = "balaclava_dragan",
		jacket = "balaclava_wolf",
		bonnie = "balaclava_dallas",
		sokol = "balaclava_sokol",
		dragon = "balaclava_dallas",
		bodhi = "balaclava_dallas",
		jimmy = "balaclava_dallas",
		sydney = "balaclava_sokol",
		wild = "balaclava_wild",
		chico = "balaclava_chico",
		max = "balaclava_dallas"
	}
	self.masks.the_overkill_mask = {}
	self.masks.the_overkill_mask.unit = "units/pd2_dlc_overkill_pack/masks/msk_the_overkill_mask/msk_the_overkill_mask"
	self.masks.the_overkill_mask.name_id = "bm_msk_the_overkill_mask"
	self.masks.the_overkill_mask.pcs = {}
	self.masks.the_overkill_mask.value = 0
	self.masks.the_overkill_mask.dlc = "overkill_pack"
	self.masks.the_overkill_mask.texture_bundle_folder = "dlc_pack_overkill"
	self.masks.the_overkill_mask.type = "glasses"
	self.masks.dallas_glow = {}
	self.masks.dallas_glow.unit = "units/pd2_dlc_cop/masks/msk_dallas_glow/msk_dallas_glow"
	self.masks.dallas_glow.name_id = "bm_msk_dallas_glow"
	self.masks.dallas_glow.pcs = {}
	self.masks.dallas_glow.dlc = "complete_overkill_pack"
	self.masks.dallas_glow.texture_bundle_folder = "dlc_pack_overkill"
	self.masks.dallas_glow.value = 0
	self.masks.wolf_glow = {}
	self.masks.wolf_glow.unit = "units/pd2_dlc_cop/masks/msk_wolf_glow/msk_wolf_glow"
	self.masks.wolf_glow.name_id = "bm_msk_wolf_glow"
	self.masks.wolf_glow.pcs = {}
	self.masks.wolf_glow.dlc = "complete_overkill_pack"
	self.masks.wolf_glow.texture_bundle_folder = "dlc_pack_overkill"
	self.masks.wolf_glow.value = 0
	self.masks.hoxton_glow = {}
	self.masks.hoxton_glow.unit = "units/pd2_dlc_cop/masks/msk_hoxton_glow/msk_hoxton_glow"
	self.masks.hoxton_glow.name_id = "bm_msk_hoxton_glow"
	self.masks.hoxton_glow.pcs = {}
	self.masks.hoxton_glow.dlc = "complete_overkill_pack"
	self.masks.hoxton_glow.texture_bundle_folder = "dlc_pack_overkill"
	self.masks.hoxton_glow.value = 0
	self.masks.chains_glow = {}
	self.masks.chains_glow.unit = "units/pd2_dlc_cop/masks/msk_chains_glow/msk_chains_glow"
	self.masks.chains_glow.name_id = "bm_msk_chains_glow"
	self.masks.chains_glow.pcs = {}
	self.masks.chains_glow.dlc = "complete_overkill_pack"
	self.masks.chains_glow.texture_bundle_folder = "dlc_pack_overkill"
	self.masks.chains_glow.value = 0
	self.masks.jake = {}
	self.masks.jake.unit = "units/pd2_dlc_hotline2/masks/jake/msk_jake"
	self.masks.jake.name_id = "bm_msk_jake"
	self.masks.jake.pcs = {}
	self.masks.jake.texture_bundle_folder = "hlm2"
	self.masks.jake.dlc = "hlm2"
	self.masks.jake.value = 0
	self.masks.richter = {}
	self.masks.richter.unit = "units/pd2_dlc_hotline2/masks/richter/msk_richter"
	self.masks.richter.name_id = "bm_msk_richter"
	self.masks.richter.pcs = {}
	self.masks.richter.texture_bundle_folder = "hlm2"
	self.masks.richter.dlc = "hlm2"
	self.masks.richter.value = 0
	self.masks.biker = {}
	self.masks.biker.unit = "units/pd2_dlc_hotline2/masks/biker/msk_biker"
	self.masks.biker.name_id = "bm_msk_biker"
	self.masks.biker.pcs = {}
	self.masks.biker.texture_bundle_folder = "hlm2"
	self.masks.biker.dlc = "hlm2"
	self.masks.biker.value = 0
	self.masks.biker.type = "helmet"
	self.masks.alex = {}
	self.masks.alex.unit = "units/pd2_dlc_hotline2/masks/alex/msk_alex"
	self.masks.alex.name_id = "bm_msk_alex"
	self.masks.alex.pcs = {}
	self.masks.alex.texture_bundle_folder = "hlm2"
	self.masks.alex.dlc = "hlm2"
	self.masks.alex.value = 0
	self.masks.corey = {}
	self.masks.corey.unit = "units/pd2_dlc_hotline2/masks/corey/msk_corey"
	self.masks.corey.name_id = "bm_msk_corey"
	self.masks.corey.pcs = {}
	self.masks.corey.texture_bundle_folder = "hlm2"
	self.masks.corey.dlc = "hlm2"
	self.masks.corey.value = 0
	self.masks.tonys_revenge = {}
	self.masks.tonys_revenge.unit = "units/pd2_dlc_hotline2/masks/tonys_revenge/msk_tonys_revenge"
	self.masks.tonys_revenge.name_id = "bm_msk_tonys_revenge"
	self.masks.tonys_revenge.pcs = {}
	self.masks.tonys_revenge.texture_bundle_folder = "hlm2"
	self.masks.tonys_revenge.dlc = "hlm2"
	self.masks.tonys_revenge.value = 0
	self.masks.richard_returns = {}
	self.masks.richard_returns.unit = "units/pd2_dlc_hotline2/masks/richard_returns/msk_richard_returns"
	self.masks.richard_returns.name_id = "bm_msk_richard_returns"
	self.masks.richard_returns.pcs = {}
	self.masks.richard_returns.texture_bundle_folder = "hlm2"
	self.masks.richard_returns.dlc = "hlm2_deluxe"
	self.masks.richard_returns.value = 0
	self.masks.richard_returns.type = "helmet"
	self.masks.richard_begins = {}
	self.masks.richard_begins.unit = "units/pd2_dlc_hotline2/masks/richard_begins/msk_richard_begins"
	self.masks.richard_begins.name_id = "bm_msk_richard_begins"
	self.masks.richard_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.richard_begins.texture_bundle_folder = "hlm2"
	self.masks.richard_begins.dlc = "hlm2_deluxe"
	self.masks.richard_begins.value = 0
	self.masks.richard_begins.type = "helmet"
	self.masks.simpson = {}
	self.masks.simpson.unit = "units/pd2_dlc_cage/masks/simpson/msk_simpson"
	self.masks.simpson.name_id = "bm_msk_simpson"
	self.masks.simpson.pcs = {}
	self.masks.simpson.type = "helmet"
	self.masks.simpson.value = 0
	self.masks.hothead = {}
	self.masks.hothead.unit = "units/pd2_speedrunners/masks/hothead/msk_hothead"
	self.masks.hothead.name_id = "bm_msk_hothead"
	self.masks.hothead.pcs = {}
	self.masks.hothead.texture_bundle_folder = "speedrunners"
	self.masks.hothead.dlc = "speedrunners"
	self.masks.hothead.value = 0
	self.masks.falcon = {}
	self.masks.falcon.unit = "units/pd2_speedrunners/masks/falcon/msk_falcon"
	self.masks.falcon.name_id = "bm_msk_falcon"
	self.masks.falcon.pcs = {}
	self.masks.falcon.type = "helmet"
	self.masks.falcon.texture_bundle_folder = "speedrunners"
	self.masks.falcon.dlc = "speedrunners"
	self.masks.falcon.value = 0
	self.masks.unic = {}
	self.masks.unic.unit = "units/pd2_speedrunners/masks/unic/msk_unic"
	self.masks.unic.name_id = "bm_msk_unic"
	self.masks.unic.pcs = {}
	self.masks.unic.type = "helmet"
	self.masks.unic.texture_bundle_folder = "speedrunners"
	self.masks.unic.dlc = "speedrunners"
	self.masks.unic.value = 0
	self.masks.speedrunner = {}
	self.masks.speedrunner.unit = "units/pd2_speedrunners/masks/speedrunner/msk_speedrunner"
	self.masks.speedrunner.name_id = "bm_msk_speedrunner"
	self.masks.speedrunner.pcs = {}
	self.masks.speedrunner.type = "helmet"
	self.masks.speedrunner.texture_bundle_folder = "speedrunners"
	self.masks.speedrunner.dlc = "speedrunners"
	self.masks.speedrunner.value = 0
	self.masks.hectors_helmet = {}
	self.masks.hectors_helmet.unit = "units/pd2_mcmansion/masks/msk_hectors_helmet/msk_hectors_helmet"
	self.masks.hectors_helmet.name_id = "bm_msk_hectors_helmet"
	self.masks.hectors_helmet.type = "helmet"
	self.masks.hectors_helmet.infamous = true
	self.masks.hectors_helmet.pcs = {}
	self.masks.hectors_helmet.value = 0
	self.masks.hectors_helmet.texture_bundle_folder = "hoxton_revenge"
	self.masks.old_hoxton_begins = {}
	self.masks.old_hoxton_begins.unit = "units/pd2_mcmansion/masks/old_hoxton_begins/msk_old_hoxton_begins"
	self.masks.old_hoxton_begins.name_id = "bm_msk_old_hoxton_begins"
	self.masks.old_hoxton_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.old_hoxton_begins.global_value = "infamous"
	self.masks.old_hoxton_begins.value = 0
	self.masks.old_hoxton_begins.texture_bundle_folder = "hoxton_revenge"
	self.masks.firedemon = {}
	self.masks.firedemon.unit = "units/pd2_dlc_bbq/masks/msk_firedemon/msk_firedemon"
	self.masks.firedemon.name_id = "bm_msk_firedemon"
	self.masks.firedemon.pcs = {}
	self.masks.firedemon.value = 0
	self.masks.firedemon.dlc = "bbq"
	self.masks.firedemon.texture_bundle_folder = "bbq"
	self.masks.gasmask = {}
	self.masks.gasmask.unit = "units/pd2_dlc_bbq/masks/msk_gasmask/msk_gasmask"
	self.masks.gasmask.name_id = "bm_msk_gasmask"
	self.masks.gasmask.pcs = {}
	self.masks.gasmask.value = 0
	self.masks.gasmask.dlc = "bbq"
	self.masks.gasmask.texture_bundle_folder = "bbq"
	self.masks.firemask = {}
	self.masks.firemask.unit = "units/pd2_dlc_bbq/masks/msk_firemask/msk_firemask"
	self.masks.firemask.name_id = "bm_msk_firemask"
	self.masks.firemask.pcs = {}
	self.masks.firemask.value = 0
	self.masks.firemask.dlc = "bbq"
	self.masks.firemask.texture_bundle_folder = "bbq"
	self.masks.chef_hat = {}
	self.masks.chef_hat.unit = "units/pd2_dlc_bbq/masks/msk_chef_hat/msk_chef_hat"
	self.masks.chef_hat.name_id = "bm_msk_chef_hat"
	self.masks.chef_hat.pcs = {}
	self.masks.chef_hat.value = 0
	self.masks.chef_hat.dlc = "bbq"
	self.masks.chef_hat.texture_bundle_folder = "bbq"
	self.masks.chef_hat.type = "helmet"
	self.masks.bandit = {}
	self.masks.bandit.unit = "units/pd2_dlc_west/masks/msk_bandit/msk_bandit"
	self.masks.bandit.name_id = "bm_msk_bandit"
	self.masks.bandit.pcs = {}
	self.masks.bandit.dlc = "west"
	self.masks.bandit.texture_bundle_folder = "west"
	self.masks.bandit.value = 0
	self.masks.bandit.type = "helmet"
	self.masks.bullskull = {}
	self.masks.bullskull.unit = "units/pd2_dlc_west/masks/msk_bullskull/msk_bullskull"
	self.masks.bullskull.name_id = "bm_msk_bullskull"
	self.masks.bullskull.pcs = {}
	self.masks.bullskull.dlc = "west"
	self.masks.bullskull.texture_bundle_folder = "west"
	self.masks.bullskull.value = 0
	self.masks.kangee = {}
	self.masks.kangee.unit = "units/pd2_dlc_west/masks/msk_kangee/msk_kangee"
	self.masks.kangee.name_id = "bm_msk_kangee"
	self.masks.kangee.pcs = {}
	self.masks.kangee.dlc = "west"
	self.masks.kangee.texture_bundle_folder = "west"
	self.masks.kangee.value = 0
	self.masks.lone = {}
	self.masks.lone.unit = "units/pd2_dlc_west/masks/msk_lone/msk_lone"
	self.masks.lone.name_id = "bm_msk_lone"
	self.masks.lone.pcs = {}
	self.masks.lone.dlc = "west"
	self.masks.lone.texture_bundle_folder = "west"
	self.masks.lone.value = 0
	self.masks.lone.type = "helmet"
	self.masks.lone.skip_mask_on_sequence = true
	self.masks.grendel = {}
	self.masks.grendel.unit = "units/pd2_dlc_shoutout_raid/masks/grendel/msk_grendel"
	self.masks.grendel.name_id = "bm_msk_grendel"
	self.masks.grendel.pcs = {}
	self.masks.grendel.value = 0
	self.masks.grendel.global_value = "infamous"
	self.masks.concert_male = {}
	self.masks.concert_male.unit = "units/pd2_dlc_arena/masks/concert_male/msk_concert_male"
	self.masks.concert_male.name_id = "bm_msk_concert_male"
	self.masks.concert_male.pcs = {}
	self.masks.concert_male.value = 0
	self.masks.concert_male.dlc = "arena"
	self.masks.concert_male.texture_bundle_folder = "dlc_arena"
	self.masks.concert_female = {}
	self.masks.concert_female.unit = "units/pd2_dlc_arena/masks/concert_female/msk_concert_female"
	self.masks.concert_female.name_id = "bm_msk_concert_female"
	self.masks.concert_female.pcs = {}
	self.masks.concert_female.value = 0
	self.masks.concert_female.dlc = "arena"
	self.masks.concert_female.texture_bundle_folder = "dlc_arena"
	self.masks.boombox = {}
	self.masks.boombox.unit = "units/pd2_dlc_arena/masks/boombox/msk_boombox"
	self.masks.boombox.name_id = "bm_msk_boombox"
	self.masks.boombox.pcs = {}
	self.masks.boombox.value = 0
	self.masks.boombox.dlc = "arena"
	self.masks.boombox.texture_bundle_folder = "dlc_arena"
	self.masks.cantus = {}
	self.masks.cantus.unit = "units/pd2_dlc_arena/masks/cantus/msk_cantus"
	self.masks.cantus.name_id = "bm_msk_cantus"
	self.masks.cantus.pcs = {}
	self.masks.cantus.value = 0
	self.masks.cantus.dlc = "arena"
	self.masks.cantus.texture_bundle_folder = "dlc_arena"
	self.masks.titan = {}
	self.masks.titan.unit = "units/pd2_dlc_humble_summer15/masks/titan/msk_titan"
	self.masks.titan.name_id = "bm_msk_titan"
	self.masks.titan.pcs = {}
	self.masks.titan.value = 0
	self.masks.titan.dlc = "humble_pack3"
	self.masks.titan.texture_bundle_folder = "humble_summer_2015"
	self.masks.titan.sort_number = 6
	self.masks.pokachu = {}
	self.masks.pokachu.unit = "units/pd2_dlc_humble_summer15/masks/pokachu/msk_pokachu"
	self.masks.pokachu.name_id = "bm_msk_pokachu"
	self.masks.pokachu.pcs = {}
	self.masks.pokachu.value = 0
	self.masks.pokachu.dlc = "humble_pack3"
	self.masks.pokachu.texture_bundle_folder = "humble_summer_2015"
	self.masks.pokachu.sort_number = 6
	self.masks.moon = {}
	self.masks.moon.unit = "units/pd2_dlc_humble_summer15/masks/moon/msk_moon"
	self.masks.moon.name_id = "bm_msk_moon"
	self.masks.moon.pcs = {}
	self.masks.moon.value = 0
	self.masks.moon.dlc = "humble_pack4"
	self.masks.moon.texture_bundle_folder = "humble_summer_2015"
	self.masks.moon.sort_number = 7
	self.masks.borsuk = {}
	self.masks.borsuk.unit = "units/pd2_dlc_humble_summer15/masks/borsuk/msk_borsuk"
	self.masks.borsuk.name_id = "bm_msk_borsuk"
	self.masks.borsuk.pcs = {}
	self.masks.borsuk.value = 0
	self.masks.borsuk.dlc = "humble_pack4"
	self.masks.borsuk.texture_bundle_folder = "humble_summer_2015"
	self.masks.borsuk.sort_number = 7
	self.masks.card_jack = {}
	self.masks.card_jack.unit = "units/pd2_dlc_playingcards/masks/msk_card_jack/msk_card_jack"
	self.masks.card_jack.name_id = "bm_msk_card_jack"
	self.masks.card_jack.pcs = {}
	self.masks.card_jack.dlc = "e3_s15a"
	self.masks.card_jack.texture_bundle_folder = "humble_summer_2015"
	self.masks.card_jack.value = 0
	self.masks.card_jack.sort_number = 8
	self.masks.card_queen = {}
	self.masks.card_queen.unit = "units/pd2_dlc_playingcards/masks/msk_card_queen/msk_card_queen"
	self.masks.card_queen.name_id = "bm_msk_card_queen"
	self.masks.card_queen.pcs = {}
	self.masks.card_queen.dlc = "e3_s15b"
	self.masks.card_queen.texture_bundle_folder = "humble_summer_2015"
	self.masks.card_queen.value = 0
	self.masks.card_queen.sort_number = 8
	self.masks.card_king = {}
	self.masks.card_king.unit = "units/pd2_dlc_playingcards/masks/msk_card_king/msk_card_king"
	self.masks.card_king.name_id = "bm_msk_card_king"
	self.masks.card_king.pcs = {}
	self.masks.card_king.dlc = "e3_s15c"
	self.masks.card_king.texture_bundle_folder = "humble_summer_2015"
	self.masks.card_king.value = 0
	self.masks.card_king.sort_number = 8
	self.masks.card_joker = {}
	self.masks.card_joker.unit = "units/pd2_dlc_playingcards/masks/msk_card_joker/msk_card_joker"
	self.masks.card_joker.name_id = "bm_msk_card_joker"
	self.masks.card_joker.pcs = {}
	self.masks.card_joker.dlc = "e3_s15d"
	self.masks.card_joker.texture_bundle_folder = "humble_summer_2015"
	self.masks.card_joker.value = 0
	self.masks.card_joker.sort_number = 8
	self.masks.king_of_jesters = {}
	self.masks.king_of_jesters.unit = "units/pd2_dlc_paydaycon2015/masks/king_of_jesters/msk_king_of_jesters"
	self.masks.king_of_jesters.name_id = "bm_msk_king_of_jesters"
	self.masks.king_of_jesters.pcs = {}
	self.masks.king_of_jesters.dlc = "pdcon_2015"
	self.masks.king_of_jesters.value = 0
	self.masks.king_of_jesters.sort_number = 9
	self.masks.sokol = {}
	self.masks.sokol.unit = "units/pd2_dlc_character_sokol/masks/sokol/msk_sokol"
	self.masks.sokol.name_id = "bm_msk_sokol"
	self.masks.sokol.pcs = {}
	self.masks.sokol.value = 0
	self.masks.sokol.texture_bundle_folder = "character_pack_sokol"
	self.masks.sokol.dlc = "character_pack_sokol"
	self.masks.sokol_begins = {}
	self.masks.sokol_begins.unit = "units/pd2_dlc_character_sokol/masks/sokol_begins/msk_sokol_begins"
	self.masks.sokol_begins.name_id = "bm_msk_sokol_begins"
	self.masks.sokol_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sokol_begins.value = 0
	self.masks.sokol_begins.texture_bundle_folder = "character_pack_sokol"
	self.masks.sokol_begins.dlc = "character_pack_sokol"
	self.masks.jiro = {}
	self.masks.jiro.unit = "units/pd2_dlc_dragon/masks/jiro/msk_jiro"
	self.masks.jiro.name_id = "bm_msk_jiro"
	self.masks.jiro.pcs = {}
	self.masks.jiro.value = 0
	self.masks.jiro.texture_bundle_folder = "dragon"
	self.masks.jiro.dlc = "dragon"
	self.masks.jiro_begins = {}
	self.masks.jiro_begins.unit = "units/pd2_dlc_dragon/masks/jiro_begins/msk_jiro_begins"
	self.masks.jiro_begins.name_id = "bm_msk_jiro_begins"
	self.masks.jiro_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.jiro_begins.value = 0
	self.masks.jiro_begins.texture_bundle_folder = "dragon"
	self.masks.jiro_begins.dlc = "dragon"
	self.masks.croupier_hat = {}
	self.masks.croupier_hat.unit = "units/pd2_dlc_casino/masks/msk_croupier_hat/msk_croupier_hat"
	self.masks.croupier_hat.name_id = "bm_msk_croupier_hat"
	self.masks.croupier_hat.pcs = {}
	self.masks.croupier_hat.value = 0
	self.masks.croupier_hat.dlc = "kenaz"
	self.masks.croupier_hat.texture_bundle_folder = "kenaz"
	self.masks.croupier_hat.type = "glasses"
	self.masks.gladiator_helmet = {}
	self.masks.gladiator_helmet.unit = "units/pd2_dlc_casino/masks/msk_gladiator/msk_gladiator"
	self.masks.gladiator_helmet.name_id = "bm_msk_gladiator_helmet"
	self.masks.gladiator_helmet.pcs = {}
	self.masks.gladiator_helmet.value = 0
	self.masks.gladiator_helmet.dlc = "kenaz"
	self.masks.gladiator_helmet.texture_bundle_folder = "kenaz"
	self.masks.gladiator_helmet.type = "helmet"
	self.masks.the_king_mask = {}
	self.masks.the_king_mask.unit = "units/pd2_dlc_casino/masks/msk_the_king/msk_the_king"
	self.masks.the_king_mask.name_id = "bm_msk_the_king_mask"
	self.masks.the_king_mask.pcs = {}
	self.masks.the_king_mask.value = 0
	self.masks.the_king_mask.dlc = "kenaz"
	self.masks.the_king_mask.texture_bundle_folder = "kenaz"
	self.masks.the_king_mask.type = "helmet"
	self.masks.sports_utility_mask = {}
	self.masks.sports_utility_mask.unit = "units/pd2_dlc_casino/masks/msk_sports_utility/msk_sports_utility"
	self.masks.sports_utility_mask.name_id = "bm_msk_sports_utility_mask"
	self.masks.sports_utility_mask.pcs = {}
	self.masks.sports_utility_mask.value = 0
	self.masks.sports_utility_mask.dlc = "kenaz"
	self.masks.sports_utility_mask.texture_bundle_folder = "kenaz"
	self.masks.starvr = {}
	self.masks.starvr.unit = "units/pd2_dlc_humble_summer15/masks/starvr/msk_starvr"
	self.masks.starvr.name_id = "bm_msk_starvr"
	self.masks.starvr.pcs = {}
	self.masks.starvr.value = 0
	self.masks.starvr.infamous = true
	self.masks.starvr.texture_bundle_folder = "humble_summer_2015"
	self.masks.starvr.type = "helmet"
	self.masks.slicer = {}
	self.masks.slicer.unit = "units/pd2_dlc_turtles/masks/slicer/msk_slicer"
	self.masks.slicer.name_id = "bm_msk_slicer"
	self.masks.slicer.pcs = {}
	self.masks.slicer.value = 0
	self.masks.slicer.texture_bundle_folder = "turtles"
	self.masks.slicer.dlc = "turtles"
	self.masks.kage = {}
	self.masks.kage.unit = "units/pd2_dlc_turtles/masks/kage/msk_kage"
	self.masks.kage.name_id = "bm_msk_kage"
	self.masks.kage.pcs = {}
	self.masks.kage.value = 0
	self.masks.kage.texture_bundle_folder = "turtles"
	self.masks.kage.dlc = "turtles"
	self.masks.ninja_hood = {}
	self.masks.ninja_hood.unit = "units/pd2_dlc_turtles/masks/ninja_hood/msk_ninja_hood"
	self.masks.ninja_hood.name_id = "bm_msk_ninja_hood"
	self.masks.ninja_hood.pcs = {}
	self.masks.ninja_hood.value = 0
	self.masks.ninja_hood.type = "helmet"
	self.masks.ninja_hood.texture_bundle_folder = "turtles"
	self.masks.ninja_hood.dlc = "turtles"
	self.masks.shirai = {}
	self.masks.shirai.unit = "units/pd2_dlc_turtles/masks/shirai/msk_shirai"
	self.masks.shirai.name_id = "bm_msk_shirai"
	self.masks.shirai.pcs = {}
	self.masks.shirai.value = 0
	self.masks.shirai.type = "helmet"
	self.masks.shirai.skip_mask_on_sequence = true
	self.masks.shirai.texture_bundle_folder = "turtles"
	self.masks.shirai.dlc = "turtles"
	self.masks.bobblehead_dozer = {}
	self.masks.bobblehead_dozer.unit = "units/pd2_merchandise/masks/msk_bobblehead_dozer/msk_bobblehead_dozer"
	self.masks.bobblehead_dozer.name_id = "bm_msk_bobblehead_dozer"
	self.masks.bobblehead_dozer.pcs = {}
	self.masks.bobblehead_dozer.value = 0
	self.masks.bobblehead_dozer.texture_bundle_folder = "merchandise"
	self.masks.bobblehead_dozer.dlc = "bobblehead"
	self.masks.bobblehead_dozer.type = "helmet"
	self.masks.bobblehead_dozer.sort_number = 9
	self.masks.mason_knight_veteran = {}
	self.masks.mason_knight_veteran.unit = "units/pd2_dlc_steel/masks/mason_knight_veteran/msk_mason_knight_veteran"
	self.masks.mason_knight_veteran.name_id = "bm_msk_mason_knight_veteran"
	self.masks.mason_knight_veteran.pcs = {}
	self.masks.mason_knight_veteran.value = 0
	self.masks.mason_knight_veteran.dlc = "steel"
	self.masks.mason_knight_veteran.texture_bundle_folder = "steel"
	self.masks.mason_knight_veteran.type = "helmet"
	self.masks.agatha_knight = {}
	self.masks.agatha_knight.unit = "units/pd2_dlc_steel/masks/agatha_knight/msk_agatha_knight"
	self.masks.agatha_knight.name_id = "bm_msk_agatha_knight"
	self.masks.agatha_knight.pcs = {}
	self.masks.agatha_knight.value = 0
	self.masks.agatha_knight.dlc = "steel"
	self.masks.agatha_knight.texture_bundle_folder = "steel"
	self.masks.agatha_knight.type = "helmet"
	self.masks.agatha_vanguard_veteran = {}
	self.masks.agatha_vanguard_veteran.unit = "units/pd2_dlc_steel/masks/agatha_vanguard_veteran/msk_agatha_vanguard_veteran"
	self.masks.agatha_vanguard_veteran.name_id = "bm_msk_agatha_vanguard_veteran"
	self.masks.agatha_vanguard_veteran.pcs = {}
	self.masks.agatha_vanguard_veteran.value = 0
	self.masks.agatha_vanguard_veteran.dlc = "steel"
	self.masks.agatha_vanguard_veteran.texture_bundle_folder = "steel"
	self.masks.agatha_vanguard_veteran.type = "helmet"
	self.masks.mason_vanguard_veteran = {}
	self.masks.mason_vanguard_veteran.unit = "units/pd2_dlc_steel/masks/mason_vanguard_veteran/msk_mason_vanguard_veteran"
	self.masks.mason_vanguard_veteran.name_id = "bm_msk_mason_vanguard_veteran"
	self.masks.mason_vanguard_veteran.pcs = {}
	self.masks.mason_vanguard_veteran.value = 0
	self.masks.mason_vanguard_veteran.dlc = "steel"
	self.masks.mason_vanguard_veteran.texture_bundle_folder = "steel"
	self.masks.mason_vanguard_veteran.type = "helmet"
	self.masks.rus_hat = {}
	self.masks.rus_hat.unit = "units/pd2_crimefest_2015/update_2/masks/rus_hat/msk_rus_hat"
	self.masks.rus_hat.name_id = "bm_msk_rus_hat"
	self.masks.rus_hat.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.rus_hat.sort_number = 8
	self.masks.rus_hat.value = 0
	self.masks.rus_hat.type = "helmet"
	self.masks.sputnik = {}
	self.masks.sputnik.unit = "units/pd2_crimefest_2015/update_2/masks/sputnik/msk_sputnik"
	self.masks.sputnik.name_id = "bm_msk_sputnik"
	self.masks.sputnik.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sputnik.sort_number = 8
	self.masks.sputnik.value = 0
	self.masks.sputnik.type = "helmet"
	self.masks.tiara = {}
	self.masks.tiara.unit = "units/pd2_crimefest_2015/update_2/masks/tiara/msk_tiara"
	self.masks.tiara.name_id = "bm_msk_tiara"
	self.masks.tiara.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.tiara.sort_number = 8
	self.masks.tiara.value = 0
	self.masks.tiara.type = "tiara"
	self.masks.tiara.skip_mask_on_sequence = true
	self.masks.baba_yaga = {}
	self.masks.baba_yaga.unit = "units/pd2_crimefest_2015/update_2/masks/baba_yaga/msk_baba_yaga"
	self.masks.baba_yaga.name_id = "bm_msk_baba_yaga"
	self.masks.baba_yaga.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.baba_yaga.sort_number = 8
	self.masks.baba_yaga.value = 0
	self.masks.vlad_armor = {}
	self.masks.vlad_armor.unit = "units/pd2_crimefest_2015/update_2/masks/vlad_armor/msk_vlad_armor"
	self.masks.vlad_armor.name_id = "bm_msk_vlad_armor"
	self.masks.vlad_armor.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.vlad_armor.value = 0
	self.masks.vlad_armor.sort_number = 8
	self.masks.vlad_armor.type = "helmet"
	self.masks.lcv = {}
	self.masks.lcv.unit = "units/pd2_dlc_rave/masks/msk_lcv"
	self.masks.lcv.name_id = "bm_msk_lcv"
	self.masks.lcv.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.lcv.value = 0
	self.masks.lcv.sort_number = 9
	self.masks.lcv.texture_bundle_folder = "rave"
	self.masks.pirate_skull = {}
	self.masks.pirate_skull.unit = "units/pd2_crimefest_2015/update_8/masks/pirate_skull/msk_pirate_skull"
	self.masks.pirate_skull.name_id = "bm_msk_pirate_skull"
	self.masks.pirate_skull.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.pirate_skull.value = 0
	self.masks.pirate_skull.sort_number = 10
	self.masks.pirate_skull.type = "helmet"
	self.masks.fatboy = {}
	self.masks.fatboy.unit = "units/pd2_crimefest_2015/update_8/masks/msk_fatboy/msk_fatboy"
	self.masks.fatboy.name_id = "bm_msk_fatboy"
	self.masks.fatboy.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.fatboy.value = 0
	self.masks.fatboy.sort_number = 10
	self.masks.oliver = {}
	self.masks.oliver.unit = "units/pd2_crimefest_2015/update_8/masks/oliver/msk_oliver"
	self.masks.oliver.name_id = "bm_msk_oliver"
	self.masks.oliver.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.oliver.value = 0
	self.masks.oliver.sort_number = 10
	self.masks.oliver.default_blueprint = {
		textures = "no_color_full_material",
		materials = "deep_bronze"
	}
	self.masks.eggian = {}
	self.masks.eggian.unit = "units/pd2_crimefest_2015/update_8/masks/eggian/msk_eggian"
	self.masks.eggian.name_id = "bm_msk_eggian"
	self.masks.eggian.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.eggian.value = 0
	self.masks.eggian.sort_number = 10
	self.masks.groucho_glasses = {}
	self.masks.groucho_glasses.unit = "units/pd2_crimefest_2015/update_9/masks/msk_groucho_glasses/msk_groucho_glasses"
	self.masks.groucho_glasses.name_id = "bm_msk_groucho"
	self.masks.groucho_glasses.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.groucho_glasses.value = 0
	self.masks.groucho_glasses.type = "glasses"
	self.masks.groucho_glasses.sort_number = 11
	self.masks.groucho_glasses.skip_mask_on_sequence = true
	self.masks.glasses_tinted_love = {}
	self.masks.glasses_tinted_love.unit = "units/pd2_crimefest_2015/update_9/masks/msk_tinted_love/msk_glasses_tinted_love"
	self.masks.glasses_tinted_love.name_id = "bm_msk_tinted_love"
	self.masks.glasses_tinted_love.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.glasses_tinted_love.value = 0
	self.masks.glasses_tinted_love.type = "glasses"
	self.masks.glasses_tinted_love.sort_number = 11
	self.masks.glasses_tinted_love.skip_mask_on_sequence = true
	self.masks.baitface = {}
	self.masks.baitface.unit = "units/pd2_crimefest_2015/update_10/masks/baitface/msk_baitface"
	self.masks.baitface.name_id = "bm_msk_baitface"
	self.masks.baitface.pcs = {}
	self.masks.baitface.value = 0
	self.masks.baitface.sort_number = 12
	self.masks.nomegusta = {}
	self.masks.nomegusta.unit = "units/pd2_crimefest_2015/update_10/masks/nomegusta/msk_nomegusta"
	self.masks.nomegusta.name_id = "bm_msk_nomegusta"
	self.masks.nomegusta.pcs = {}
	self.masks.nomegusta.value = 0
	self.masks.nomegusta.sort_number = 12
	self.masks.rageface = {}
	self.masks.rageface.unit = "units/pd2_crimefest_2015/update_10/masks/rageface/msk_rageface"
	self.masks.rageface.name_id = "bm_msk_rageface"
	self.masks.rageface.pcs = {}
	self.masks.rageface.value = 0
	self.masks.rageface.sort_number = 12
	self.masks.dawg = {}
	self.masks.dawg.unit = "units/pd2_crimefest_2015/update_10/masks/msk_dawg/msk_dawg"
	self.masks.dawg.name_id = "bm_msk_dawg"
	self.masks.dawg.pcs = {}
	self.masks.dawg.value = 0
	self.masks.dawg.sort_number = 12
	self.masks.invader = {}
	self.masks.invader.unit = "units/pd2_dlc_nails/masks/invader/msk_invader"
	self.masks.invader.name_id = "bm_msk_invader"
	self.masks.invader.global_value = "halloween"
	self.masks.invader.texture_bundle_folder = "nails"
	self.masks.invader.sort_number = 3
	self.masks.invader.value = 0
	self.masks.satan = {}
	self.masks.satan.unit = "units/pd2_dlc_nails/masks/satan/msk_satan"
	self.masks.satan.name_id = "bm_msk_satan"
	self.masks.satan.global_value = "halloween"
	self.masks.satan.texture_bundle_folder = "nails"
	self.masks.satan.sort_number = 3
	self.masks.satan.value = 0
	self.masks.tormentor = {}
	self.masks.tormentor.unit = "units/pd2_dlc_tormentor_mask/masks/tormentor/msk_tormentor"
	self.masks.tormentor.name_id = "bm_msk_tormentor"
	self.masks.tormentor.pcs = {}
	self.masks.tormentor.value = 0
	self.masks.tormentor.sort_number = 12
	self.masks.bodhi = {}
	self.masks.bodhi.unit = "units/pd2_dlc_rip/masks/bodhi/msk_bodhi"
	self.masks.bodhi.name_id = "bm_msk_bodhi"
	self.masks.bodhi.pcs = {}
	self.masks.bodhi.value = 0
	self.masks.bodhi.global_value = "infamous"
	self.masks.bodhi.texture_bundle_folder = "rip"
	self.masks.bodhi_begins = {}
	self.masks.bodhi_begins.unit = "units/pd2_dlc_rip/masks/bodhi_begins/msk_bodhi_begins"
	self.masks.bodhi_begins.name_id = "bm_msk_bodhi_begins"
	self.masks.bodhi_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.bodhi_begins.value = 0
	self.masks.bodhi_begins.global_value = "infamous"
	self.masks.bodhi_begins.texture_bundle_folder = "rip"
	self.masks.water_spirit = {}
	self.masks.water_spirit.unit = "units/pd2_dlc_jerry/masks/msk_water_spirit/msk_water_spirit"
	self.masks.water_spirit.name_id = "bm_msk_water_spirit"
	self.masks.water_spirit.pcs = {}
	self.masks.water_spirit.value = 0
	self.masks.water_spirit.dlc = "berry"
	self.masks.water_spirit.texture_bundle_folder = "berry"
	self.masks.tane = {}
	self.masks.tane.unit = "units/pd2_dlc_jerry/masks/tane/msk_tane"
	self.masks.tane.name_id = "bm_msk_tane"
	self.masks.tane.pcs = {}
	self.masks.tane.value = 0
	self.masks.tane.dlc = "berry"
	self.masks.tane.texture_bundle_folder = "berry"
	self.masks.oro = {}
	self.masks.oro.unit = "units/pd2_dlc_jerry/masks/oro/msk_oro"
	self.masks.oro.name_id = "bm_msk_oro"
	self.masks.oro.pcs = {}
	self.masks.oro.value = 0
	self.masks.oro.dlc = "berry"
	self.masks.oro.texture_bundle_folder = "berry"
	self.masks.maui = {}
	self.masks.maui.unit = "units/pd2_dlc_jerry/masks/maui/msk_maui"
	self.masks.maui.name_id = "bm_msk_maui"
	self.masks.maui.pcs = {}
	self.masks.maui.value = 0
	self.masks.maui.dlc = "berry"
	self.masks.maui.texture_bundle_folder = "berry"
	self.masks.rudeolph = {}
	self.masks.rudeolph.unit = "units/pd2_dlc_cane/masks/rudeolph/msk_rudeolph"
	self.masks.rudeolph.name_id = "bm_msk_rudeolph"
	self.masks.rudeolph.type = "tiara"
	self.masks.rudeolph.pcs = {}
	self.masks.rudeolph.value = 0
	self.masks.rudeolph.sort_number = 13
	self.masks.greedy_the_elf = {}
	self.masks.greedy_the_elf.unit = "units/pd2_dlc_cane/masks/greedy_the_elf/msk_greedy_the_elf"
	self.masks.greedy_the_elf.name_id = "bm_msk_greedy_the_elf"
	self.masks.greedy_the_elf.type = "hat"
	self.masks.greedy_the_elf.pcs = {}
	self.masks.greedy_the_elf.value = 0
	self.masks.greedy_the_elf.sort_number = 13
	self.masks.tall_goat = {}
	self.masks.tall_goat.unit = "units/pd2_dlc_peta/masks/mask_tall_goat/msk_tall_goat"
	self.masks.tall_goat.name_id = "bm_msk_tall_goat"
	self.masks.tall_goat.pcs = {}
	self.masks.tall_goat.value = 0
	self.masks.tall_goat.sort_number = 14
	self.masks.tall_goat.dlc = "peta"
	self.masks.tall_goat.texture_bundle_folder = "peta"
	self.masks.goat_goat = {}
	self.masks.goat_goat.unit = "units/pd2_dlc_peta/masks/mask_goat/msk_goat_goat"
	self.masks.goat_goat.name_id = "bm_msk_goat_goat"
	self.masks.goat_goat.pcs = {}
	self.masks.goat_goat.value = 0
	self.masks.goat_goat.sort_number = 14
	self.masks.goat_goat.dlc = "peta"
	self.masks.goat_goat.texture_bundle_folder = "peta"
	self.masks.wet_goat = {}
	self.masks.wet_goat.unit = "units/pd2_dlc_peta/masks/mask_wet_goat/msk_wet_goat"
	self.masks.wet_goat.name_id = "bm_msk_slimy_goat"
	self.masks.wet_goat.pcs = {}
	self.masks.wet_goat.value = 0
	self.masks.wet_goat.sort_number = 14
	self.masks.wet_goat.dlc = "peta"
	self.masks.wet_goat.texture_bundle_folder = "peta"
	self.masks.fancy_goat = {}
	self.masks.fancy_goat.unit = "units/pd2_dlc_peta/masks/mask_fancy_goat/msk_fancy_goat"
	self.masks.fancy_goat.name_id = "bm_msk_fancy_goat"
	self.masks.fancy_goat.pcs = {}
	self.masks.fancy_goat.value = 0
	self.masks.fancy_goat.sort_number = 14
	self.masks.fancy_goat.dlc = "peta"
	self.masks.fancy_goat.texture_bundle_folder = "peta"
	self.masks.devourer = {}
	self.masks.devourer.unit = "units/pd2_dlc_dbd_community/masks/devourer/msk_devourer"
	self.masks.devourer.name_id = "bm_msk_devourer"
	self.masks.devourer.pcs = {}
	self.masks.devourer.value = 0
	self.masks.devourer.dlc = "dbd_clan"
	self.masks.devourer.texture_bundle_folder = "daylight"
	self.masks.unborn = {}
	self.masks.unborn.unit = "units/pd2_dlc_dbd_community/masks/unborn/msk_unborn"
	self.masks.unborn.name_id = "bm_msk_unborn"
	self.masks.unborn.pcs = {}
	self.masks.unborn.value = 0
	self.masks.unborn.dlc = "dbd_clan"
	self.masks.unborn.texture_bundle_folder = "daylight"
	self.masks.horned_king = {}
	self.masks.horned_king.unit = "units/pd2_dlc_lupus/masks/lupus_horned_king/msk_horned_king"
	self.masks.horned_king.name_id = "bm_msk_horned_king"
	self.masks.horned_king.type = "tiara"
	self.masks.horned_king.pcs = {}
	self.masks.horned_king.value = 0
	self.masks.horned_king.dlc = "pal"
	self.masks.horned_king.texture_bundle_folder = "lupus"
	self.masks.horned_king.sort_number = 15
	self.masks.viking = {}
	self.masks.viking.unit = "units/pd2_dlc_lupus/masks/lupus_viking/msk_viking"
	self.masks.viking.name_id = "bm_msk_viking"
	self.masks.viking.pcs = {}
	self.masks.viking.value = 0
	self.masks.viking.dlc = "pal"
	self.masks.viking.texture_bundle_folder = "lupus"
	self.masks.viking.sort_number = 15
	self.masks.nutcracker = {}
	self.masks.nutcracker.unit = "units/pd2_dlc_lupus/masks/lupus_nutcracker/msk_nutcracker"
	self.masks.nutcracker.name_id = "bm_msk_nutcracker"
	self.masks.nutcracker.pcs = {}
	self.masks.nutcracker.value = 0
	self.masks.nutcracker.dlc = "pal"
	self.masks.nutcracker.texture_bundle_folder = "lupus"
	self.masks.nutcracker.sort_number = 15
	self.masks.divided = {}
	self.masks.divided.unit = "units/pd2_dlc_lupus/masks/lupus_divided/msk_divided"
	self.masks.divided.name_id = "bm_msk_divided"
	self.masks.divided.pcs = {}
	self.masks.divided.value = 0
	self.masks.divided.dlc = "pal"
	self.masks.divided.texture_bundle_folder = "lupus"
	self.masks.divided.sort_number = 15
	self.masks.megacthulhu = {}
	self.masks.megacthulhu.unit = "units/pd2_dlc_super/masks/megacthulu/msk_megacthulhu"
	self.masks.megacthulhu.name_id = "bm_msk_megacthulhu"
	self.masks.megacthulhu.pcs = {}
	self.masks.megacthulhu.dlc = "complete_overkill_pack"
	self.masks.megacthulhu.texture_bundle_folder = "super"
	self.masks.megacthulhu.value = 0
	self.masks.hunter = {}
	self.masks.hunter.unit = "units/pd2_dlc_super/masks/hunter/msk_hunter"
	self.masks.hunter.name_id = "bm_msk_hunter"
	self.masks.hunter.pcs = {}
	self.masks.hunter.dlc = "complete_overkill_pack"
	self.masks.hunter.texture_bundle_folder = "super"
	self.masks.hunter.value = 0
	self.masks.cop_skull = {}
	self.masks.cop_skull.unit = "units/pd2_dlc_super/masks/cop_skull/msk_cop_skull"
	self.masks.cop_skull.name_id = "bm_cop_mega_skull"
	self.masks.cop_skull.pcs = {}
	self.masks.cop_skull.dlc = "complete_overkill_pack"
	self.masks.cop_skull.texture_bundle_folder = "super"
	self.masks.cop_skull.value = 0
	self.masks.cop_plague_doctor = {}
	self.masks.cop_plague_doctor.unit = "units/pd2_dlc_super/masks/cop_plague_doctor/msk_cop_plague_doctor"
	self.masks.cop_plague_doctor.name_id = "bm_cop_plague_doctor"
	self.masks.cop_plague_doctor.pcs = {}
	self.masks.cop_plague_doctor.dlc = "complete_overkill_pack"
	self.masks.cop_plague_doctor.texture_bundle_folder = "super"
	self.masks.cop_plague_doctor.value = 0
	self.masks.cop_kawaii = {}
	self.masks.cop_kawaii.unit = "units/pd2_dlc_super/masks/cop_kawaii/msk_cop_kawaii"
	self.masks.cop_kawaii.name_id = "bm_cop_kawaii"
	self.masks.cop_kawaii.pcs = {}
	self.masks.cop_kawaii.dlc = "complete_overkill_pack"
	self.masks.cop_kawaii.texture_bundle_folder = "super"
	self.masks.cop_kawaii.value = 0
	self.masks.jimmy = {}
	self.masks.jimmy.unit = "units/pd2_dlc_coco/masks/jimmy/msk_jimmy"
	self.masks.jimmy.name_id = "bm_msk_jimmy"
	self.masks.jimmy.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.jimmy.value = 0
	self.masks.jimmy.global_value = "infamous"
	self.masks.jimmy.texture_bundle_folder = "coco"
	self.masks.jimmy.sort_number = 16
	self.masks.jimmy_duct = {}
	self.masks.jimmy_duct.unit = "units/pd2_dlc_coco/masks/jimmy_duct/msk_jimmy_duct"
	self.masks.jimmy_duct.name_id = "bm_msk_jimmy_duct"
	self.masks.jimmy_duct.pcs = {}
	self.masks.jimmy_duct.value = 0
	self.masks.jimmy_duct.global_value = "infamous"
	self.masks.jimmy_duct.texture_bundle_folder = "coco"
	self.masks.jimmy_duct.sort_number = 16
	self.masks.half_mask = {}
	self.masks.half_mask.unit = "units/pd2_dlc_mad/masks/mad_halv_mask/msk_half_mask"
	self.masks.half_mask.name_id = "bm_msk_andromeda"
	self.masks.half_mask.pcs = {}
	self.masks.half_mask.value = 0
	self.masks.half_mask.type = "helmet"
	self.masks.half_mask.texture_bundle_folder = "mad"
	self.masks.half_mask.sort_number = 17
	self.masks.visor = {}
	self.masks.visor.unit = "units/pd2_dlc_mad/masks/mad_helmet_mask/msk_visor"
	self.masks.visor.name_id = "bm_msk_visor"
	self.masks.visor.pcs = {}
	self.masks.visor.value = 0
	self.masks.visor.type = "helmet"
	self.masks.visor.texture_bundle_folder = "mad"
	self.masks.visor.sort_number = 17
	self.masks.mad_goggles = {}
	self.masks.mad_goggles.unit = "units/pd2_dlc_mad/masks/mad_goggles/msk_mad_goggles"
	self.masks.mad_goggles.name_id = "bm_msk_goggles"
	self.masks.mad_goggles.pcs = {}
	self.masks.mad_goggles.value = 0
	self.masks.mad_goggles.type = "helmet"
	self.masks.mad_goggles.texture_bundle_folder = "mad"
	self.masks.mad_goggles.sort_number = 17
	self.masks.mad_mask = {}
	self.masks.mad_mask.unit = "units/pd2_dlc_mad/masks/mad_mask/msk_mad_mask"
	self.masks.mad_mask.name_id = "bm_msk_mad_mask"
	self.masks.mad_mask.pcs = {}
	self.masks.mad_mask.value = 0
	self.masks.mad_mask.texture_bundle_folder = "mad"
	self.masks.mad_mask.sort_number = 17
	self.masks.dbd_01 = {}
	self.masks.dbd_01.unit = "units/pd2_dlc_boo_1/masks/msk_dbd_01"
	self.masks.dbd_01.name_id = "bm_msk_dbd_01"
	self.masks.dbd_01.pcs = {}
	self.masks.dbd_01.value = 0
	self.masks.dbd_01.type = "helmet"
	self.masks.dbd_01.texture_bundle_folder = "boo_1"
	self.masks.dbd_01.dlc = "dbd_clan"
	self.masks.dbd_01.sort_number = 18
	self.masks.dbd_02 = {}
	self.masks.dbd_02.unit = "units/pd2_dlc_boo_2/masks/msk_dbd_02"
	self.masks.dbd_02.name_id = "bm_msk_dbd_02"
	self.masks.dbd_02.pcs = {}
	self.masks.dbd_02.value = 0
	self.masks.dbd_02.texture_bundle_folder = "boo_2"
	self.masks.dbd_02.dlc = "dbd_deluxe"
	self.masks.dbd_02.sort_number = 18
	self.masks.dbd_03 = {}
	self.masks.dbd_03.unit = "units/pd2_dlc_boo_3/masks/msk_dbd_03"
	self.masks.dbd_03.name_id = "bm_msk_dbd_03"
	self.masks.dbd_03.pcs = {}
	self.masks.dbd_03.value = 0
	self.masks.dbd_03.texture_bundle_folder = "boo_3"
	self.masks.dbd_03.dlc = "dbd_deluxe"
	self.masks.dbd_03.sort_number = 18
	self.masks.dbd_04 = {}
	self.masks.dbd_04.unit = "units/pd2_dlc_boo/masks/dbd_04/msk_boo_dbd_04"
	self.masks.dbd_04.name_id = "bm_msk_dbd_00"
	self.masks.dbd_04.pcs = {}
	self.masks.dbd_04.value = 0
	self.masks.dbd_04.texture_bundle_folder = "boo"
	self.masks.dbd_04.dlc = "dbd_clan"
	self.masks.dbd_04.sort_number = 18
	self.masks.dbd_slasher = {}
	self.masks.dbd_slasher.unit = "units/pd2_dlc_boo_4/masks/msk_dbd_slasher"
	self.masks.dbd_slasher.name_id = "bm_msk_dbd_04"
	self.masks.dbd_slasher.pcs = {}
	self.masks.dbd_slasher.value = 0
	self.masks.dbd_slasher.type = "helmet"
	self.masks.dbd_slasher.texture_bundle_folder = "boo_4"
	self.masks.dbd_slasher.dlc = "dbd_clan"
	self.masks.dbd_slasher.sort_number = 18
	self.masks.sydney = {}
	self.masks.sydney.unit = "units/pd2_dlc_opera/masks/sydney/msk_sydney"
	self.masks.sydney.name_id = "bm_msk_sydney"
	self.masks.sydney.pcs = {}
	self.masks.sydney.value = 0
	self.masks.sydney.dlc = "opera"
	self.masks.sydney.texture_bundle_folder = "opera"
	self.masks.sydney.sort_number = 19
	self.masks.sydney_begins = {}
	self.masks.sydney_begins.unit = "units/pd2_dlc_opera/masks/sydney_begins/msk_sydney_begins"
	self.masks.sydney_begins.name_id = "bm_msk_sydney_begins"
	self.masks.sydney_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sydney_begins.value = 0
	self.masks.sydney_begins.dlc = "opera"
	self.masks.sydney_begins.texture_bundle_folder = "opera"
	self.masks.sydney_begins.sort_number = 19
	self.masks.jig_01 = {}
	self.masks.jig_01.unit = "units/pd2_dlc_jigg/masks/mask_jigg_01/msk_jig_01"
	self.masks.jig_01.name_id = "bm_msk_jig_01"
	self.masks.jig_01.value = 0
	self.masks.jig_01.texture_bundle_folder = "jigg"
	self.masks.jig_01.dlc = "jigg"
	self.masks.jig_01.sort_number = 20
	self.masks.jig_02 = {}
	self.masks.jig_02.unit = "units/pd2_dlc_jigg/masks/mask_jigg_02/msk_jig_02"
	self.masks.jig_02.name_id = "bm_msk_jig_02"
	self.masks.jig_02.value = 0
	self.masks.jig_02.texture_bundle_folder = "jigg"
	self.masks.jig_02.type = "helmet"
	self.masks.jig_02.dlc = "jigg"
	self.masks.jig_02.sort_number = 20
	self.masks.damned = {}
	self.masks.damned.unit = "units/pd2_dlc_jigg/masks/damned/msk_damned"
	self.masks.damned.name_id = "bm_msk_damned"
	self.masks.damned.value = 0
	self.masks.damned.texture_bundle_folder = "jigg"
	self.masks.damned.dlc = "jigg"
	self.masks.damned.sort_number = 20
	self.masks.born_biker_01 = {}
	self.masks.born_biker_01.unit = "units/pd2_dlc_born/masks/born_01/msk_born_biker_01"
	self.masks.born_biker_01.name_id = "bm_msk_biker_classic"
	self.masks.born_biker_01.pcs = {}
	self.masks.born_biker_01.value = 0
	self.masks.born_biker_01.type = "helmet"
	self.masks.born_biker_01.texture_bundle_folder = "born"
	self.masks.born_biker_01.sort_number = 21
	self.masks.born_biker_01.dlc = "born"
	self.masks.born_biker_02 = {}
	self.masks.born_biker_02.unit = "units/pd2_dlc_born/masks/born_02/msk_born_biker_02"
	self.masks.born_biker_02.name_id = "bm_msk_speed_demon"
	self.masks.born_biker_02.pcs = {}
	self.masks.born_biker_02.value = 0
	self.masks.born_biker_02.texture_bundle_folder = "born"
	self.masks.born_biker_02.sort_number = 21
	self.masks.born_biker_02.dlc = "born"
	self.masks.born_biker_03 = {}
	self.masks.born_biker_03.unit = "units/pd2_dlc_born/masks/born_03/msk_born_biker_03"
	self.masks.born_biker_03.name_id = "bm_msk_rage_demon"
	self.masks.born_biker_03.pcs = {}
	self.masks.born_biker_03.value = 0
	self.masks.born_biker_03.type = "helmet"
	self.masks.born_biker_03.texture_bundle_folder = "born"
	self.masks.born_biker_03.sort_number = 21
	self.masks.born_biker_03.dlc = "born"
	self.masks.brutal = {}
	self.masks.brutal.unit = "units/pd2_dlc_born/masks/brutal/msk_brutal"
	self.masks.brutal.name_id = "bm_msk_brutal"
	self.masks.brutal.pcs = {}
	self.masks.brutal.value = 0
	self.masks.brutal.texture_bundle_folder = "born"
	self.masks.brutal.sort_number = 21
	self.masks.brutal.dlc = "born"
	self.masks.rust = {}
	self.masks.rust.unit = "units/pd2_dlc_wild/masks/rust/msk_rust"
	self.masks.rust.name_id = "bm_msk_rust"
	self.masks.rust.pcs = {}
	self.masks.rust.value = 0
	self.masks.rust.texture_bundle_folder = "wild"
	self.masks.rust.sort_number = 22
	self.masks.rust.dlc = "wild"
	self.masks.rust_begins = {}
	self.masks.rust_begins.unit = "units/pd2_dlc_wild/masks/rust_begins/msk_rust_begins"
	self.masks.rust_begins.name_id = "bm_msk_rust_begins"
	self.masks.rust_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.rust_begins.value = 0
	self.masks.rust_begins.texture_bundle_folder = "wild"
	self.masks.rust_begins.sort_number = 22
	self.masks.rust_begins.dlc = "wild"
	self.masks.fab_mega_grin = {}
	self.masks.fab_mega_grin.unit = "units/pd2_dlc_fab/masks/mega_grin/msk_fab_mega_grin"
	self.masks.fab_mega_grin.name_id = "bm_msk_mega_grin"
	self.masks.fab_mega_grin.pcs = {}
	self.masks.fab_mega_grin.value = 0
	self.masks.fab_mega_grin.texture_bundle_folder = "fab"
	self.masks.fab_mega_grin.dlc = "complete_overkill_pack"
	self.masks.fab_mega_doctor = {}
	self.masks.fab_mega_doctor.unit = "units/pd2_dlc_fab/masks/mega_doctor/msk_fab_mega_doctor"
	self.masks.fab_mega_doctor.name_id = "bm_msk_mega_doctor"
	self.masks.fab_mega_doctor.pcs = {}
	self.masks.fab_mega_doctor.value = 0
	self.masks.fab_mega_doctor.texture_bundle_folder = "fab"
	self.masks.fab_mega_doctor.dlc = "complete_overkill_pack"
	self.masks.fab_mega_alien = {}
	self.masks.fab_mega_alien.unit = "units/pd2_dlc_fab/masks/mega_alien/msk_fab_mega_alien"
	self.masks.fab_mega_alien.name_id = "bm_msk_mega_alien"
	self.masks.fab_mega_alien.pcs = {}
	self.masks.fab_mega_alien.value = 0
	self.masks.fab_mega_alien.texture_bundle_folder = "fab"
	self.masks.fab_mega_alien.dlc = "complete_overkill_pack"
	self.masks.cop_mega_gage_blade = {}
	self.masks.cop_mega_gage_blade.unit = "units/pd2_dlc_fab/masks/cop_mega_gage_blade/msk_cop_mega_gage_blade"
	self.masks.cop_mega_gage_blade.name_id = "bm_msk_mega_blade"
	self.masks.cop_mega_gage_blade.pcs = {}
	self.masks.cop_mega_gage_blade.value = 0
	self.masks.cop_mega_gage_blade.texture_bundle_folder = "fab"
	self.masks.cop_mega_gage_blade.dlc = "complete_overkill_pack"
	self.masks.fab_mega_mark = {}
	self.masks.fab_mega_mark.unit = "units/pd2_dlc_fab/masks/mega_bear/msk_fab_mega_mark"
	self.masks.fab_mega_mark.name_id = "bm_msk_mega_mark"
	self.masks.fab_mega_mark.pcs = {}
	self.masks.fab_mega_mark.value = 0
	self.masks.fab_mega_mark.texture_bundle_folder = "fab"
	self.masks.fab_mega_mark.dlc = "complete_overkill_pack"
	self.masks.solus = {}
	self.masks.solus.unit = "units/pd2_dlc_solus/masks/msk_solus"
	self.masks.solus.name_id = "bm_msk_solus"
	self.masks.solus.pcs = {}
	self.masks.solus.value = 0
	self.masks.solus.texture_bundle_folder = "solus"
	self.masks.solus.sort_number = 23
	self.masks.solus.dlc = "solus_clan"
	self.masks.mig_death = {}
	self.masks.mig_death.unit = "units/pd2_dlc_migg/masks/migg_death/msk_mig_death"
	self.masks.mig_death.name_id = "bm_msk_death_rider"
	self.masks.mig_death.pcs = {}
	self.masks.mig_death.value = 0
	self.masks.mig_death.texture_bundle_folder = "migg"
	self.masks.mig_death.sort_number = 24
	self.masks.mig_death.dlc = "pd2_clan"
	self.masks.mig_war = {}
	self.masks.mig_war.unit = "units/pd2_dlc_migg/masks/migg_war/msk_mig_war"
	self.masks.mig_war.name_id = "bm_msk_war"
	self.masks.mig_war.pcs = {}
	self.masks.mig_war.value = 0
	self.masks.mig_war.type = "helmet"
	self.masks.mig_war.texture_bundle_folder = "migg"
	self.masks.mig_war.sort_number = 24
	self.masks.mig_war.dlc = "pd2_clan"
	self.masks.mig_conquest = {}
	self.masks.mig_conquest.unit = "units/pd2_dlc_migg/masks/migg_conquest/msk_mig_conquest"
	self.masks.mig_conquest.name_id = "bm_msk_conquest"
	self.masks.mig_conquest.pcs = {}
	self.masks.mig_conquest.value = 0
	self.masks.mig_conquest.texture_bundle_folder = "migg"
	self.masks.mig_conquest.sort_number = 24
	self.masks.mig_conquest.dlc = "pd2_clan"
	self.masks.mig_famine = {}
	self.masks.mig_famine.unit = "units/pd2_dlc_migg/masks/migg_famine/msk_mig_famine"
	self.masks.mig_famine.name_id = "bm_msk_famine"
	self.masks.mig_famine.pcs = {}
	self.masks.mig_famine.value = 0
	self.masks.mig_famine.texture_bundle_folder = "migg"
	self.masks.mig_famine.sort_number = 24
	self.masks.mig_famine.dlc = "pd2_clan"
	self.masks.fib_fox = {}
	self.masks.fib_fox.unit = "units/pd2_dlc_fibb/masks/fib_fox_mask/msk_fib_fox"
	self.masks.fib_fox.name_id = "bm_msk_fable_fox"
	self.masks.fib_fox.pcs = {}
	self.masks.fib_fox.value = 0
	self.masks.fib_fox.texture_bundle_folder = "fibb"
	self.masks.fib_fox.sort_number = 25
	self.masks.fib_fox.dlc = "pd2_clan"
	self.masks.fib_cat = {}
	self.masks.fib_cat.unit = "units/pd2_dlc_fibb/masks/fib_cat_mask/msk_fib_cat"
	self.masks.fib_cat.name_id = "bm_msk_fable_cat"
	self.masks.fib_cat.pcs = {}
	self.masks.fib_cat.value = 0
	self.masks.fib_cat.texture_bundle_folder = "fibb"
	self.masks.fib_cat.sort_number = 25
	self.masks.fib_cat.dlc = "pd2_clan"
	self.masks.fib_mouse = {}
	self.masks.fib_mouse.unit = "units/pd2_dlc_fibb/masks/fib_mouse_mask/msk_fib_mouse"
	self.masks.fib_mouse.name_id = "bm_msk_fable_mouse"
	self.masks.fib_mouse.pcs = {}
	self.masks.fib_mouse.value = 0
	self.masks.fib_mouse.texture_bundle_folder = "fibb"
	self.masks.fib_mouse.sort_number = 25
	self.masks.fib_mouse.dlc = "pd2_clan"
	self.masks.fib_hare = {}
	self.masks.fib_hare.unit = "units/pd2_dlc_fibb/masks/fib_hare_mask/msk_fib_hare"
	self.masks.fib_hare.name_id = "bm_msk_fable_hare"
	self.masks.fib_hare.pcs = {}
	self.masks.fib_hare.value = 0
	self.masks.fib_hare.texture_bundle_folder = "fibb"
	self.masks.fib_hare.sort_number = 25
	self.masks.fib_hare.dlc = "pd2_clan"
	self.masks.pim_dog = {}
	self.masks.pim_dog.unit = "units/pd2_dlc_pim/masks/pim_dog_mask/msk_pim_dog"
	self.masks.pim_dog.name_id = "bm_msk_pim_daisy"
	self.masks.pim_dog.pcs = {}
	self.masks.pim_dog.value = 0
	self.masks.pim_dog.texture_bundle_folder = "pim"
	self.masks.pim_dog.sort_number = 26
	self.masks.pim_dog.dlc = "pim"
	self.masks.pim_russian_ballistic = {}
	self.masks.pim_russian_ballistic.unit = "units/pd2_dlc_pim/masks/pim_russian_ballistic_mask/msk_pim_russian_ballistic"
	self.masks.pim_russian_ballistic.name_id = "bm_msk_pim_dirty_russian"
	self.masks.pim_russian_ballistic.pcs = {}
	self.masks.pim_russian_ballistic.value = 0
	self.masks.pim_russian_ballistic.texture_bundle_folder = "pim"
	self.masks.pim_russian_ballistic.sort_number = 26
	self.masks.pim_russian_ballistic.dlc = "pim"
	self.masks.pim_hotelier = {}
	self.masks.pim_hotelier.unit = "units/pd2_dlc_pim/masks/pim_hotelier_mask/msk_pim_hotelier"
	self.masks.pim_hotelier.name_id = "bm_msk_pim_hotelier"
	self.masks.pim_hotelier.pcs = {}
	self.masks.pim_hotelier.value = 0
	self.masks.pim_hotelier.texture_bundle_folder = "pim"
	self.masks.pim_hotelier.sort_number = 26
	self.masks.pim_hotelier.dlc = "pim"
	self.masks.pim_mustang = {}
	self.masks.pim_mustang.unit = "units/pd2_dlc_pim/masks/pim_mustang_mask/msk_pim_mustang"
	self.masks.pim_mustang.name_id = "bm_msk_pim_mustang"
	self.masks.pim_mustang.pcs = {}
	self.masks.pim_mustang.value = 0
	self.masks.pim_mustang.type = "helmet"
	self.masks.pim_mustang.texture_bundle_folder = "pim"
	self.masks.pim_mustang.sort_number = 26
	self.masks.pim_mustang.dlc = "pim"
	self.masks.nyck_cap = {}
	self.masks.nyck_cap.unit = "units/pd2_crimefest_2016/nyck/masks/nyck_cap_mask/msk_nck_cap"
	self.masks.nyck_cap.name_id = "bm_jar_head"
	self.masks.nyck_cap.pcs = {}
	self.masks.nyck_cap.value = 0
	self.masks.nyck_cap.type = "tiara"
	self.masks.nyck_cap.texture_bundle_folder = "nyck"
	self.masks.nyck_cap.sort_number = 27
	self.masks.nyck_ace = {}
	self.masks.nyck_ace.unit = "units/pd2_crimefest_2016/nyck/masks/nyck_ace_mask/msk_nck_ace"
	self.masks.nyck_ace.name_id = "bm_ace"
	self.masks.nyck_ace.pcs = {}
	self.masks.nyck_ace.value = 0
	self.masks.nyck_ace.type = "helmet"
	self.masks.nyck_ace.texture_bundle_folder = "nyck"
	self.masks.nyck_ace.sort_number = 27
	self.masks.nyck_beret = {}
	self.masks.nyck_beret.unit = "units/pd2_crimefest_2016/nyck/masks/nyck_beret_mask/msk_nck_beret"
	self.masks.nyck_beret.name_id = "bm_beret"
	self.masks.nyck_beret.pcs = {}
	self.masks.nyck_beret.value = 0
	self.masks.nyck_beret.type = "tiara"
	self.masks.nyck_beret.texture_bundle_folder = "nyck"
	self.masks.nyck_beret.sort_number = 27
	self.masks.nyck_pickle = {}
	self.masks.nyck_pickle.unit = "units/pd2_crimefest_2016/nyck/masks/nyck_pickle_mask/msk_nck_pickle"
	self.masks.nyck_pickle.name_id = "bm_mr_pickle"
	self.masks.nyck_pickle.pcs = {}
	self.masks.nyck_pickle.value = 0
	self.masks.nyck_pickle.texture_bundle_folder = "nyck"
	self.masks.nyck_pickle.sort_number = 27
	self.masks.spk_party = {}
	self.masks.spk_party.unit = "units/pd2_dlc_sparkle/masks/sparkle_party/msk_spk_party"
	self.masks.spk_party.name_id = "bm_sparkle_party"
	self.masks.spk_party.pcs = {}
	self.masks.spk_party.value = 0
	self.masks.spk_party.type = "tiara"
	self.masks.spk_party.texture_bundle_folder = "sparkle"
	self.masks.spk_party.sort_number = 28
	self.masks.spk_party.dlc = "sparkle"
	self.masks.gti_al_capone = {}
	self.masks.gti_al_capone.unit = "units/pd2_dlc_gotti/masks/al_capone/msk_gti_al_capone"
	self.masks.gti_al_capone.name_id = "bm_al_pacino"
	self.masks.gti_al_capone.pcs = {}
	self.masks.gti_al_capone.value = 0
	self.masks.gti_al_capone.texture_bundle_folder = "gotti"
	self.masks.gti_al_capone.sort_number = 29
	self.masks.gti_bugsy = {}
	self.masks.gti_bugsy.unit = "units/pd2_dlc_gotti/masks/bugsy/msk_gti_bugsy"
	self.masks.gti_bugsy.name_id = "bm_bugsy"
	self.masks.gti_bugsy.pcs = {}
	self.masks.gti_bugsy.value = 0
	self.masks.gti_bugsy.texture_bundle_folder = "gotti"
	self.masks.gti_bugsy.sort_number = 29
	self.masks.gti_madame_st_claire = {}
	self.masks.gti_madame_st_claire.unit = "units/pd2_dlc_gotti/masks/madame/msk_gti_madame_st_claire"
	self.masks.gti_madame_st_claire.name_id = "bm_madame_st_claire"
	self.masks.gti_madame_st_claire.pcs = {}
	self.masks.gti_madame_st_claire.value = 0
	self.masks.gti_madame_st_claire.texture_bundle_folder = "gotti"
	self.masks.gti_madame_st_claire.sort_number = 29
	self.masks.gti_lucky_luciano = {}
	self.masks.gti_lucky_luciano.unit = "units/pd2_dlc_gotti/masks/lucky_luciano/msk_gti_lucky_luciano"
	self.masks.gti_lucky_luciano.name_id = "bm_lucky_luciano"
	self.masks.gti_lucky_luciano.pcs = {}
	self.masks.gti_lucky_luciano.value = 0
	self.masks.gti_lucky_luciano.texture_bundle_folder = "gotti"
	self.masks.gti_lucky_luciano.sort_number = 29
	self.masks.urf_seal = {}
	self.masks.urf_seal.unit = "units/pd2_dlc_urf/masks/msk_urf_seal"
	self.masks.urf_seal.name_id = "bm_sad_seal"
	self.masks.urf_seal.pcs = {}
	self.masks.urf_seal.value = 0
	self.masks.urf_seal.texture_bundle_folder = "urf"
	self.masks.urf_seal.sort_number = 31
	self.masks.hwl_dallas_zombie = {}
	self.masks.hwl_dallas_zombie.unit = "units/pd2_dlc_howl/masks/dallas_zombie/msk_hwl_dallas_zombie"
	self.masks.hwl_dallas_zombie.name_id = "bm_dallas_rising"
	self.masks.hwl_dallas_zombie.pcs = {}
	self.masks.hwl_dallas_zombie.value = 0
	self.masks.hwl_dallas_zombie.texture_bundle_folder = "howl"
	self.masks.hwl_dallas_zombie.sort_number = 32
	self.masks.hwl_dallas_zombie.global_value = "halloween"
	self.masks.hwl_wolf_zombie = {}
	self.masks.hwl_wolf_zombie.unit = "units/pd2_dlc_howl/masks/wolf_zombie/msk_hwl_wolf_zombie"
	self.masks.hwl_wolf_zombie.name_id = "bm_wolf_rising"
	self.masks.hwl_wolf_zombie.pcs = {}
	self.masks.hwl_wolf_zombie.value = 0
	self.masks.hwl_wolf_zombie.texture_bundle_folder = "howl"
	self.masks.hwl_wolf_zombie.sort_number = 32
	self.masks.hwl_wolf_zombie.global_value = "halloween"
	self.masks.hwl_hoxton_zombie = {}
	self.masks.hwl_hoxton_zombie.unit = "units/pd2_dlc_howl/masks/hoxton_zombie/msk_hwl_hoxton_zombie"
	self.masks.hwl_hoxton_zombie.name_id = "bm_hoxton_rising"
	self.masks.hwl_hoxton_zombie.pcs = {}
	self.masks.hwl_hoxton_zombie.value = 0
	self.masks.hwl_hoxton_zombie.texture_bundle_folder = "howl"
	self.masks.hwl_hoxton_zombie.sort_number = 32
	self.masks.hwl_hoxton_zombie.global_value = "halloween"
	self.masks.howl_chains_zombie = {}
	self.masks.howl_chains_zombie.unit = "units/pd2_dlc_howl/masks/chains_zombie/msk_howl_chains_zombie"
	self.masks.howl_chains_zombie.name_id = "bm_chains_rising"
	self.masks.howl_chains_zombie.pcs = {}
	self.masks.howl_chains_zombie.value = 0
	self.masks.howl_chains_zombie.texture_bundle_folder = "howl"
	self.masks.howl_chains_zombie.sort_number = 32
	self.masks.howl_chains_zombie.global_value = "halloween"
	self.masks.pdc16_clover = {}
	self.masks.pdc16_clover.unit = "units/pd2_dlc_paydaycon2016/masks/msk_pdc16_clover"
	self.masks.pdc16_clover.name_id = "bm_mega_clover"
	self.masks.pdc16_clover.pcs = {}
	self.masks.pdc16_clover.value = 0
	self.masks.pdc16_clover.texture_bundle_folder = "pdc16"
	self.masks.pdc16_clover.sort_number = 33
	self.masks.pdc16_clover.global_value = "pdcon_2016"
	self.masks.pdc16_clover.dlc = "pdcon_2016"
	self.masks.win_donald = {}
	self.masks.win_donald.unit = "units/pd2_dlc_win/masks/msk_win_donald/msk_win_donald"
	self.masks.win_donald.name_id = "bm_donald"
	self.masks.win_donald.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.win_donald.value = 0
	self.masks.win_donald.texture_bundle_folder = "win"
	self.masks.win_donald.sort_number = 34
	self.masks.win_donald_mega = {}
	self.masks.win_donald_mega.unit = "units/pd2_dlc_win/masks/msk_win_donald_mega/msk_win_donald_mega"
	self.masks.win_donald_mega.name_id = "bm_donald_mega"
	self.masks.win_donald_mega.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.win_donald_mega.value = 0
	self.masks.win_donald_mega.texture_bundle_folder = "win"
	self.masks.win_donald_mega.sort_number = 34
	self.masks.tng_bandana = {}
	self.masks.tng_bandana.unit = "units/pd2_dlc_tng/masks/tng_bandana/msk_tng_bandana"
	self.masks.tng_bandana.name_id = "bm_bandana"
	self.masks.tng_bandana.pcs = {}
	self.masks.tng_bandana.value = 0
	self.masks.tng_bandana.type = "tiara"
	self.masks.tng_bandana.texture_bundle_folder = "tng"
	self.masks.tng_bandana.sort_number = 35
	self.masks.tng_bandana.skip_mask_on_sequence = true
	self.masks.tng_bandana.dlc = "tango"
	self.masks.tng_cloaker = {}
	self.masks.tng_cloaker.unit = "units/pd2_dlc_tng/masks/tng_cloaker/msk_tng_cloaker"
	self.masks.tng_cloaker.name_id = "bm_cloaker"
	self.masks.tng_cloaker.pcs = {}
	self.masks.tng_cloaker.value = 0
	self.masks.tng_cloaker.type = "helmet"
	self.masks.tng_cloaker.texture_bundle_folder = "tng"
	self.masks.tng_cloaker.sort_number = 35
	self.masks.tng_cloaker.dlc = "tango"
	self.masks.tng_zeal_swat_mask = {}
	self.masks.tng_zeal_swat_mask.unit = "units/pd2_dlc_tng/masks/tng_zeal_swat_mask/msk_tng_zeal_swat_mask"
	self.masks.tng_zeal_swat_mask.name_id = "bm_zeal_mask"
	self.masks.tng_zeal_swat_mask.pcs = {}
	self.masks.tng_zeal_swat_mask.value = 0
	self.masks.tng_zeal_swat_mask.type = "helmet"
	self.masks.tng_zeal_swat_mask.texture_bundle_folder = "tng"
	self.masks.tng_zeal_swat_mask.sort_number = 35
	self.masks.tng_zeal_swat_mask.dlc = "tango"
	self.masks.tng_cap = {}
	self.masks.tng_cap.unit = "units/pd2_dlc_tng/masks/tng_cap/msk_tng_cap"
	self.masks.tng_cap.name_id = "bm_cap_n_beard"
	self.masks.tng_cap.pcs = {}
	self.masks.tng_cap.value = 0
	self.masks.tng_cap.type = "helmet"
	self.masks.tng_cap.texture_bundle_folder = "tng"
	self.masks.tng_cap.sort_number = 35
	self.masks.tng_cap.dlc = "tango"
	self.masks.moon_paycheck_dallas = {}
	self.masks.moon_paycheck_dallas.unit = "units/pd2_dlc_moon/masks/paycheck_dallas/msk_moon_paycheck_dallas"
	self.masks.moon_paycheck_dallas.name_id = "bm_paycheck_dallas"
	self.masks.moon_paycheck_dallas.pcs = {}
	self.masks.moon_paycheck_dallas.value = 0
	self.masks.moon_paycheck_dallas.texture_bundle_folder = "moon"
	self.masks.moon_paycheck_dallas.sort_number = 36
	self.masks.moon_paycheck_chains = {}
	self.masks.moon_paycheck_chains.unit = "units/pd2_dlc_moon/masks/paycheck_chains/msk_moon_paycheck_chains"
	self.masks.moon_paycheck_chains.name_id = "bm_paycheck_chains"
	self.masks.moon_paycheck_chains.pcs = {}
	self.masks.moon_paycheck_chains.value = 0
	self.masks.moon_paycheck_chains.texture_bundle_folder = "moon"
	self.masks.moon_paycheck_chains.sort_number = 36
	self.masks.sfm_01 = {}
	self.masks.sfm_01.unit = "units/pd2_dlc_friend/masks/sfm_01/msk_sfm_01"
	self.masks.sfm_01.name_id = "bm_sfm_01"
	self.masks.sfm_01.pcs = {}
	self.masks.sfm_01.value = 0
	self.masks.sfm_01.texture_bundle_folder = "friend"
	self.masks.sfm_01.sort_number = 37
	self.masks.sfm_01.dlc = "friend"
	self.masks.sfm_02 = {}
	self.masks.sfm_02.unit = "units/pd2_dlc_friend/masks/sfm_02/msk_sfm_02"
	self.masks.sfm_02.name_id = "bm_sfm_02"
	self.masks.sfm_02.pcs = {}
	self.masks.sfm_02.value = 0
	self.masks.sfm_02.texture_bundle_folder = "friend"
	self.masks.sfm_02.sort_number = 37
	self.masks.sfm_02.dlc = "friend"
	self.masks.sfm_03 = {}
	self.masks.sfm_03.unit = "units/pd2_dlc_friend/masks/sfm_03/msk_sfm_03"
	self.masks.sfm_03.name_id = "bm_sfm_03"
	self.masks.sfm_03.pcs = {}
	self.masks.sfm_03.value = 0
	self.masks.sfm_03.texture_bundle_folder = "friend"
	self.masks.sfm_03.type = "glasses"
	self.masks.sfm_03.skip_mask_on_sequence = true
	self.masks.sfm_03.sort_number = 37
	self.masks.sfm_03.dlc = "friend"
	self.masks.sfm_04 = {}
	self.masks.sfm_04.unit = "units/pd2_dlc_friend/masks/sfm_04/msk_sfm_04"
	self.masks.sfm_04.name_id = "bm_sfm_04"
	self.masks.sfm_04.pcs = {}
	self.masks.sfm_04.value = 0
	self.masks.sfm_04.texture_bundle_folder = "friend"
	self.masks.sfm_04.sort_number = 37
	self.masks.sfm_04.dlc = "friend"
	self.masks.chc_terry = {}
	self.masks.chc_terry.unit = "units/pd2_dlc_chico/masks/terry/msk_chc_terry"
	self.masks.chc_terry.name_id = "bm_msk_chico"
	self.masks.chc_terry.pcs = {}
	self.masks.chc_terry.value = 0
	self.masks.chc_terry.texture_bundle_folder = "chico"
	self.masks.chc_terry.sort_number = 38
	self.masks.chc_terry.dlc = "chico"
	self.masks.chc_terry_begins = {}
	self.masks.chc_terry_begins.unit = "units/pd2_dlc_chico/masks/terry_begins/msk_chc_terry_begins"
	self.masks.chc_terry_begins.name_id = "bm_msk_chico_begins"
	self.masks.chc_terry_begins.pcs = {}
	self.masks.chc_terry_begins.value = 0
	self.masks.chc_terry_begins.dlc = "chico"
	self.masks.chc_terry_begins.texture_bundle_folder = "chico"
	self.masks.chc_terry_begins.sort_number = 38
	self.masks.swm_sydney = {}
	self.masks.swm_sydney.unit = "units/pd2_dlc_swm/masks/msk_swm_sydney"
	self.masks.swm_sydney.name_id = "bm_msk_mega_sydney"
	self.masks.swm_sydney.pcs = {}
	self.masks.swm_sydney.value = 0
	self.masks.swm_sydney.texture_bundle_folder = "swm"
	self.masks.swm_sydney.sort_number = 39
	self.masks.swm_sydney.dlc = "swm"
	self.masks.swm_sydney.global_value = "swm"
	self.masks.sha_01 = {}
	self.masks.sha_01.unit = "units/pd2_dlc_sha/masks/sha_01/msk_sha_01"
	self.masks.sha_01.name_id = "bm_sha_01"
	self.masks.sha_01.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sha_01.value = 0
	self.masks.sha_01.texture_bundle_folder = "sha"
	self.masks.sha_01.sort_number = 40
	self.masks.sha_01.global_value = "sha"
	self.masks.sha_02 = {}
	self.masks.sha_02.unit = "units/pd2_dlc_sha/masks/sha_02/msk_sha_02"
	self.masks.sha_02.name_id = "bm_sha_02"
	self.masks.sha_02.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sha_02.value = 0
	self.masks.sha_02.texture_bundle_folder = "sha"
	self.masks.sha_02.sort_number = 40
	self.masks.sha_02.global_value = "sha"
	self.masks.sha_03 = {}
	self.masks.sha_03.unit = "units/pd2_dlc_sha/masks/sha_03/msk_sha_03"
	self.masks.sha_03.name_id = "bm_sha_03"
	self.masks.sha_03.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sha_03.value = 0
	self.masks.sha_03.texture_bundle_folder = "sha"
	self.masks.sha_03.sort_number = 40
	self.masks.sha_03.global_value = "sha"
	self.masks.sha_04 = {}
	self.masks.sha_04.unit = "units/pd2_dlc_sha/masks/sha_04/msk_sha_04"
	self.masks.sha_04.name_id = "bm_sha_04"
	self.masks.sha_04.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.sha_04.value = 0
	self.masks.sha_04.texture_bundle_folder = "sha"
	self.masks.sha_04.sort_number = 40
	self.masks.sha_04.global_value = "sha"
	self.masks.spa_01 = {}
	self.masks.spa_01.unit = "units/pd2_dlc_spa/masks/spa_01/msk_spa_01"
	self.masks.spa_01.name_id = "bm_msk_spa_01"
	self.masks.spa_01.pcs = {}
	self.masks.spa_01.value = 0
	self.masks.spa_01.texture_bundle_folder = "spa"
	self.masks.spa_01.type = "helmet"
	self.masks.spa_01.sort_number = 41
	self.masks.spa_01.dlc = "spa"
	self.masks.spa_01.global_value = "spa"
	self.masks.spa_02 = {}
	self.masks.spa_02.unit = "units/pd2_dlc_spa/masks/spa_02/msk_spa_02"
	self.masks.spa_02.name_id = "bm_msk_spa_02"
	self.masks.spa_02.pcs = {}
	self.masks.spa_02.value = 0
	self.masks.spa_02.texture_bundle_folder = "spa"
	self.masks.spa_02.type = "helmet"
	self.masks.spa_02.sort_number = 41
	self.masks.spa_02.dlc = "spa"
	self.masks.spa_02.global_value = "spa"
	self.masks.spa_02.offsets = {
		jacket = {
			Vector3(0, -0.160978, -0.160978),
			Rotation(0, 0, 0)
		},
		dallas = {
			Vector3(0, -0.75721, -0.518717),
			Rotation(0, 0, 0)
		},
		sydney = {
			Vector3(-2.06892, -0.637963, 2.82018),
			Rotation(-10.6034, -14.0376, -1.06722E-7)
		},
		dragon = {
			Vector3(-0.160978, -0.399471, -0.280224),
			Rotation(0, 0, 0)
		},
		wild = {
			Vector3(0, -1.47269, -0.75721),
			Rotation(0, 0, 0)
		},
		female_1 = {
			Vector3(-0.399471, 1.38922, -0.995702),
			Rotation(-0.300467, 5.70955, 1.41668)
		},
		hoxton = {
			Vector3(0, -0.995702, -0.0417315),
			Rotation(0, 0, 0)
		},
		sokol = {
			Vector3(0.0775149, -0.518717, -0.399471),
			Rotation(0, 0, 0)
		},
		chico = {
			Vector3(0.673747, -0.637963, -0.518717),
			Rotation(3.9924, 1.41668, 4.85098)
		},
		wolf = {
			Vector3(0, -0.637963, 0.196761),
			Rotation(0, 0, 0)
		},
		jimmy = {
			Vector3(0.0775149, 0.435254, -0.518717),
			Rotation(0, 0, 0)
		},
		bodhi = {
			Vector3(0, -0.518717, -0.399471),
			Rotation(0, 0, 0)
		},
		jowi = {
			Vector3(0, -1.2342, 0.0775149),
			Rotation(0, 0, 0)
		},
		chains = {
			Vector3(0, -0.876456, -0.518717),
			Rotation(0, 0, 0)
		},
		old_hoxton = {
			Vector3(0, -1.11495, -0.637963),
			Rotation(0, 0, 0)
		}
	}
	self.masks.spa_03 = {}
	self.masks.spa_03.unit = "units/pd2_dlc_spa/masks/spa_03/msk_spa_03"
	self.masks.spa_03.name_id = "bm_msk_spa_03"
	self.masks.spa_03.pcs = {}
	self.masks.spa_03.value = 0
	self.masks.spa_03.texture_bundle_folder = "spa"
	self.masks.spa_03.sort_number = 41
	self.masks.spa_03.dlc = "spa"
	self.masks.spa_03.global_value = "spa"
	self.masks.spa_04 = {}
	self.masks.spa_04.unit = "units/pd2_dlc_spa/masks/spa_04/msk_spa_04"
	self.masks.spa_04.name_id = "bm_msk_spa_04"
	self.masks.spa_04.pcs = {}
	self.masks.spa_04.value = 0
	self.masks.spa_04.texture_bundle_folder = "spa"
	self.masks.spa_04.sort_number = 41
	self.masks.spa_04.dlc = "spa"
	self.masks.spa_04.global_value = "spa"
	self.masks.yor = {}
	self.masks.yor.unit = "units/pd2_dlc_yor/masks/yor/msk_yor"
	self.masks.yor.name_id = "bm_msk_yor"
	self.masks.yor.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.yor.value = 0
	self.masks.yor.texture_bundle_folder = "yor"
	self.masks.yor.sort_number = 42
	self.masks.grv_01_bodhi = {}
	self.masks.grv_01_bodhi.unit = "units/pd2_dlc_grv/masks/grv_01/grv_01_bodhi/msk_grv_01_bodhi"
	self.masks.grv_01_bodhi.name_id = "bm_msk_cheat_error2"
	self.masks.grv_01_bodhi.type = "helmet"
	self.masks.grv_01_bodhi.inaccessible = true
	self.masks.grv_01_bodhi.offsets = {
		dallas = {
			Vector3(0, -0.518717, 0.673747),
			Rotation(0, 0, 0)
		},
		sydney = {
			Vector3(-0.280224, -0.518717, 1.15073),
			Rotation(-0.300467, -0.300467, 0.558107)
		},
		dragon = {
			Vector3(-0.280224, 0.196761, 0.435254),
			Rotation(0, 0, 0)
		},
		female_1 = {
			Vector3(0, 0, 0.435254),
			Rotation(0, 2.27525, 0)
		},
		hoxton = {
			Vector3(0, -0.160978, 0.912239),
			Rotation(0, 0, 0)
		},
		wild = {
			Vector3(0, -1.71118, 1.03149),
			Rotation(0, -6.31048, 0)
		},
		chains = {
			Vector3(-0.280224, -0.995702, 0.435254),
			Rotation(0, 0.558107, 0)
		},
		chico = {
			Vector3(-0.0417315, -0.518717, 0.912239),
			Rotation(0, 0, 0)
		},
		old_hoxton = {
			Vector3(0, 0.196761, 0.0775149),
			Rotation(0, 3.9924, 0)
		},
		bodhi = {
			Vector3(0.196761, -0.280224, 0.5545),
			Rotation(0, 0, 0)
		},
		dragan = {
			Vector3(0, -0.160978, 0.912239),
			Rotation(0, 0, 0)
		},
		max = {
			Vector3(0, -0.160978, 0.912239),
			Rotation(0, 0, 0)
		}
	}
	self.masks.grv_01_bonnie = {}
	self.masks.grv_01_bonnie.unit = "units/pd2_dlc_grv/masks/grv_01/grv_01_bonnie/msk_grv_01_bonnie"
	self.masks.grv_01_bonnie.name_id = "bm_msk_cheat_error2"
	self.masks.grv_01_bonnie.type = "helmet"
	self.masks.grv_01_bonnie.inaccessible = true
	self.masks.grv_01_bonnie.offsets = {
		jacket = {
			Vector3(0, 0, 0.196761),
			Rotation(0, 0, 0)
		},
		wolf = {
			Vector3(0, -0.518717, 1.03149),
			Rotation(0, -1.15904, 0)
		},
		jowi = {
			Vector3(-0.160978, -0.160978, 0.792993),
			Rotation(0, 0, 0)
		},
		jimmy = {
			Vector3(-0.0417315, 0.5545, -0.160978),
			Rotation(0, 2.27525, 0)
		},
		sokol = {
			Vector3(0, 0, 0.316008),
			Rotation(0, 0, 0)
		},
		bonnie = {
			Vector3(0.0775149, 0.673747, 0.435254),
			Rotation(0, 0, 0)
		}
	}
	self.masks.grv_01 = {}
	self.masks.grv_01.name_id = "bm_msk_grv_01"
	self.masks.grv_01.value = 0
	self.masks.grv_01.pcs = {}
	self.masks.grv_01.type = "helmet"
	self.masks.grv_01.texture_bundle_folder = "grv"
	self.masks.grv_01.sort_number = 43
	self.masks.grv_01.dlc = "grv"
	self.masks.grv_01.global_value = "grv"
	self.masks.grv_01.characters = {
		dallas = "grv_01_bodhi",
		wolf = "grv_01_bonnie",
		hoxton = "grv_01_bodhi",
		chains = "grv_01_bonnie",
		jowi = "grv_01_bonnie",
		old_hoxton = "grv_01_bodhi",
		female_1 = "grv_01_bodhi",
		dragan = "grv_01_bodhi",
		jacket = "grv_01_bonnie",
		sokol = "grv_01_bonnie",
		dragon = "grv_01_bodhi",
		jimmy = "grv_01_bonnie",
		sydney = "grv_01_bodhi",
		wild = "grv_01_bodhi",
		chico = "grv_01_bodhi",
		chains = "grv_01_bodhi",
		bodhi = "grv_01_bodhi",
		bonnie = "grv_01_bonnie",
		max = "grv_01_bodhi"
	}
	self.masks.grv_02 = {}
	self.masks.grv_02.unit = "units/pd2_dlc_grv/masks/grv_02/msk_grv_02"
	self.masks.grv_02.name_id = "bm_msk_grv_02"
	self.masks.grv_02.pcs = {}
	self.masks.grv_02.value = 0
	self.masks.grv_02.texture_bundle_folder = "grv"
	self.masks.grv_02.sort_number = 43
	self.masks.grv_02.dlc = "grv"
	self.masks.grv_02.global_value = "grv"
	self.masks.grv_03 = {}
	self.masks.grv_03.unit = "units/pd2_dlc_grv/masks/grv_03/msk_grv_03"
	self.masks.grv_03.name_id = "bm_msk_grv_03"
	self.masks.grv_03.pcs = {}
	self.masks.grv_03.value = 0
	self.masks.grv_03.texture_bundle_folder = "grv"
	self.masks.grv_03.type = "tiara"
	self.masks.grv_03.skip_mask_on_sequence = true
	self.masks.grv_03.sort_number = 43
	self.masks.grv_03.dlc = "grv"
	self.masks.grv_03.global_value = "grv"
	self.masks.grv_04 = {}
	self.masks.grv_04.unit = "units/pd2_dlc_grv/masks/grv_04/msk_grv_04"
	self.masks.grv_04.name_id = "bm_msk_grv_04"
	self.masks.grv_04.pcs = {}
	self.masks.grv_04.value = 0
	self.masks.grv_04.type = "helmet"
	self.masks.grv_04.texture_bundle_folder = "grv"
	self.masks.grv_04.sort_number = 43
	self.masks.grv_04.dlc = "grv"
	self.masks.grv_04.offsets = {
		sydney = {
			Vector3(-0.0417333, -1.59194, 1.03148),
			Rotation(0, 0, -1.15905)
		},
		chains = {
			Vector3(0, -1.59194, 0.435252),
			Rotation(0, -3.73477, 0)
		},
		female_1 = {
			Vector3(0, -1.83043, 0.673745),
			Rotation(0, 0, 0)
		},
		hoxton = {
			Vector3(0, -2.30741, 1.38922),
			Rotation(0, -8.02764, 0)
		},
		wild = {
			Vector3(0, -1.83043, 0),
			Rotation(1.41667, -3.73477, 0)
		},
		wolf = {
			Vector3(0, -1.35344, 0.673745),
			Rotation(0, 0, 0)
		},
		bodhi = {
			Vector3(-0.399472, -2.42666, 0),
			Rotation(0, 0, 0)
		},
		jowi = {
			Vector3(0, -1.35344, 0),
			Rotation(0, 0, 0)
		},
		jacket = {
			Vector3(0, -1.35344, 0.077513),
			Rotation(0, 0, 0)
		},
		dallas = {
			Vector3(0, -1.71118, 0.554498),
			Rotation(0, 0, 0)
		},
		old_hoxton = {
			Vector3(0, -1.94967, -0.995704),
			Rotation(0, 2.27524, 0)
		},
		bonnie = {
			Vector3(0.196759, -0.757211, 0.196759),
			Rotation(1.41667, -0.30048, -8.33763E-10)
		},
		sokol = {
			Vector3(0, -1.94967, 1.15073),
			Rotation(-3.3351E-9, -6.3105, -0.30048)
		},
		chico = {
			Vector3(0, -1.83043, 0.792991),
			Rotation(0, -3.73477, 0)
		},
		dragon = {
			Vector3(0, -0.995704, 1.15073),
			Rotation(0, -7.16907, 0)
		},
		jimmy = {
			Vector3(0.435252, -1.47269, 0),
			Rotation(2.27524, 2.08444E-9, -0.30048)
		},
		dragan = {
			Vector3(0, -1.35344, 0.554498),
			Rotation(0, 0, 0)
		}
	}
	self.masks.amp_01 = {}
	self.masks.amp_01.unit = "units/pd2_dlc_amp/masks/amp_01/msk_amp_01"
	self.masks.amp_01.name_id = "bm_msk_amp_01"
	self.masks.amp_01.pcs = {}
	self.masks.amp_01.value = 0
	self.masks.amp_01.texture_bundle_folder = "amp"
	self.masks.amp_01.sort_number = 43
	self.masks.amp_02 = {}
	self.masks.amp_02.unit = "units/pd2_dlc_amp/masks/amp_02/msk_amp_02"
	self.masks.amp_02.name_id = "bm_msk_amp_02"
	self.masks.amp_02.pcs = {}
	self.masks.amp_02.value = 0
	self.masks.amp_02.texture_bundle_folder = "amp"
	self.masks.amp_02.sort_number = 43
	self.masks.amp_03 = {}
	self.masks.amp_03.unit = "units/pd2_dlc_amp/masks/amp_03/msk_amp_03"
	self.masks.amp_03.name_id = "bm_msk_amp_03"
	self.masks.amp_03.pcs = {}
	self.masks.amp_03.value = 0
	self.masks.amp_03.texture_bundle_folder = "amp"
	self.masks.amp_03.sort_number = 43
	self.masks.amp_04 = {}
	self.masks.amp_04.unit = "units/pd2_dlc_amp/masks/amp_04/msk_amp_04"
	self.masks.amp_04.name_id = "bm_msk_amp_04"
	self.masks.amp_04.pcs = {}
	self.masks.amp_04.value = 0
	self.masks.amp_04.texture_bundle_folder = "amp"
	self.masks.amp_04.sort_number = 43
	self.masks.mp2_01 = {}
	self.masks.mp2_01.unit = "units/pd2_dlc_mp2/masks/mp2_01/msk_mp2_01"
	self.masks.mp2_01.name_id = "bm_msk_mp2_01"
	self.masks.mp2_01.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.mp2_01.value = 0
	self.masks.mp2_01.texture_bundle_folder = "mp2"
	self.masks.mp2_01.sort_number = 44
	self.masks.mp2_01.offsets = {
		female_1 = {
			Vector3(0, 0.435252, 0),
			Rotation(0, 0, 0)
		}
	}
	self.masks.mp2_02 = {}
	self.masks.mp2_02.unit = "units/pd2_dlc_mp2/masks/mp2_02/msk_mp2_02"
	self.masks.mp2_02.name_id = "bm_msk_mp2_02"
	self.masks.mp2_02.pcs = {}
	self.masks.mp2_02.value = 0
	self.masks.mp2_02.texture_bundle_folder = "mp2"
	self.masks.mp2_02.sort_number = 44
	self.masks.mp2_03 = {}
	self.masks.mp2_03.unit = "units/pd2_dlc_mp2/masks/mp2_03/msk_mp2_03"
	self.masks.mp2_03.name_id = "bm_msk_mp2_03"
	self.masks.mp2_03.pcs = {}
	self.masks.mp2_03.value = 0
	self.masks.mp2_03.texture_bundle_folder = "mp2"
	self.masks.mp2_03.sort_number = 44
	self.masks.mp2_04 = {}
	self.masks.mp2_04.unit = "units/pd2_dlc_mp2/masks/mp2_04/msk_mp2_04"
	self.masks.mp2_04.name_id = "bm_msk_mp2_04"
	self.masks.mp2_04.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.mp2_04.value = 0
	self.masks.mp2_04.texture_bundle_folder = "mp2"
	self.masks.mp2_04.sort_number = 44
	self.masks.mrm = {}
	self.masks.mrm.unit = "units/pd2_dlc_mrm/masks/msk_mrm"
	self.masks.mrm.name_id = "bm_msk_mrm"
	self.masks.mrm.pcs = {}
	self.masks.mrm.value = 0
	self.masks.mrm.texture_bundle_folder = "mrm"
	self.masks.mrm.sort_number = 45
	self.masks.mrm.infamous = true
	self.masks.bny_01_bonnie = {}
	self.masks.bny_01_bonnie.unit = "units/pd2_dlc_bny/masks/bny_01/msk_bny_01_bonnie"
	self.masks.bny_01_bonnie.name_id = "bm_msk_bny_01a"
	self.masks.bny_01_bonnie.type = "helmet"
	self.masks.bny_01_bonnie.inaccessible = true
	self.masks.bny_01_bonnie.offsets = {
		wolf = {
			Vector3(0, 3.41641, 0.435254),
			Rotation(0, -3.73476, 0)
		},
		sydney = {
			Vector3(0, 3.53566, 0.435254),
			Rotation(0, -4.59333, 0)
		},
		chico = {
			Vector3(0, 3.65491, -1.47269),
			Rotation(0.558107, -0.300467, -0.041893)
		},
		jimmy = {
			Vector3(0, 4.48963, -2.06892),
			Rotation(0, 2.27525, 0)
		},
		bonnie = {
			Vector3(0, 3.77415, 0),
			Rotation(0, -8.02763, 0)
		}
	}
	self.masks.bny_01_bodhi = {}
	self.masks.bny_01_bodhi.unit = "units/pd2_dlc_bny/masks/bny_01/msk_bny_01_bodhi"
	self.masks.bny_01_bodhi.name_id = "bm_msk_bny_01b"
	self.masks.bny_01_bodhi.type = "helmet"
	self.masks.bny_01_bodhi.inaccessible = true
	self.masks.bny_01_bodhi.offsets = {
		dragon = {
			Vector3(0, 3.8934, -0.637963),
			Rotation(0, -5.45191, 0)
		},
		hoxton = {
			Vector3(0, 3.41641, 0.435254),
			Rotation(0, -11.4619, 0)
		},
		wild = {
			Vector3(0, 3.77415, -0.518717),
			Rotation(0, -8.8862, 0)
		},
		sokol = {
			Vector3(0, 2.82018, 0.316008),
			Rotation(0, -4.59333, 0)
		},
		old_hoxton = {
			Vector3(0, 4.25114, -2.54591),
			Rotation(0, 8.28527, 0)
		},
		bodhi = {
			Vector3(0, 4.48963, -0.637963),
			Rotation(0, -4.59333, 0)
		},
		jowi = {
			Vector3(0, 4.13189, -1.59193),
			Rotation(0, 3.13383, 0)
		},
		chains = {
			Vector3(0, 3.41641, 1.03149),
			Rotation(0, -12.3205, 0)
		},
		dragan = {
			Vector3(0, 4.13189, -0.0417315),
			Rotation(0, -6.31048, 0)
		},
		max = {
			Vector3(0, 4.13189, -0.0417315),
			Rotation(0, -6.31048, 0)
		}
	}
	self.masks.bny_01_clover = {}
	self.masks.bny_01_clover.unit = "units/pd2_dlc_bny/masks/bny_01/msk_bny_01_clover"
	self.masks.bny_01_clover.name_id = "bm_msk_bny_01c"
	self.masks.bny_01_clover.type = "helmet"
	self.masks.bny_01_clover.inaccessible = true
	self.masks.bny_01_clover.offsets = {
		chico = {
			Vector3(0.00826851, 1.74696, -1.59193),
			Rotation(-0.300467, 5.70955, -0.300467)
		},
		dallas = {
			Vector3(0, 1.38922, 2.1047),
			Rotation(0, -16.6134, 0)
		},
		jacket = {
			Vector3(0, 1.03149, -1.2342),
			Rotation(0.0409595, 5.70955, -4.16882E-10)
		}
	}
	self.masks.bny_01_clover_b = {}
	self.masks.bny_01_clover_b.unit = "units/pd2_dlc_bny/masks/bny_01/msk_bny_01_clover_b"
	self.masks.bny_01_clover_b.name_id = "bm_msk_bny_01d"
	self.masks.bny_01_clover_b.type = "helmet"
	self.masks.bny_01_clover_b.inaccessible = true
	self.masks.bny_01 = {}
	self.masks.bny_01.name_id = "bm_msk_bny_01"
	self.masks.bny_01.value = 0
	self.masks.bny_01.pcs = {}
	self.masks.bny_01.type = "helmet"
	self.masks.bny_01.texture_bundle_folder = "bny"
	self.masks.bny_01.sort_number = 46
	self.masks.bny_01.characters = {
		dallas = "bny_01_clover",
		wolf = "bny_01_bonnie",
		hoxton = "bny_01_bodhi",
		chains = "bny_01_bodhi",
		jowi = "bny_01_bodhi",
		old_hoxton = "bny_01_bodhi",
		female_1 = "bny_01_clover_b",
		dragan = "bny_01_bodhi",
		jacket = "bny_01_clover",
		sokol = "bny_01_bodhi",
		dragon = "bny_01_bodhi",
		jimmy = "bny_01_bonnie",
		sydney = "bny_01_bonnie",
		wild = "bny_01_bodhi",
		chico = "bny_01_bonnie",
		bodhi = "bny_01_bodhi",
		bonnie = "bny_01_bonnie",
		max = "bny_01_bodhi"
	}
	self.masks.bny_02_bonnie = {}
	self.masks.bny_02_bonnie.unit = "units/pd2_dlc_bny/masks/bny_02/msk_bny_02_bonnie"
	self.masks.bny_02_bonnie.name_id = "bm_msk_bny_02a"
	self.masks.bny_02_bonnie.type = "helmet"
	self.masks.bny_02_bonnie.inaccessible = true
	self.masks.bny_02_bonnie.offsets = {
		jacket = {
			Vector3(0, 2.22395, -0.518717),
			Rotation(-4.6676E-4, -8.8862, -3.25689E-12)
		},
		sydney = {
			Vector3(0, 2.3432, -0.0417315),
			Rotation(1.0422E-10, -6.31048, 0.030943)
		},
		dragon = {
			Vector3(0, 1.86621, -0.399471),
			Rotation(0, -9.74478, 0)
		},
		wild = {
			Vector3(0, 2.46244, 0.5545),
			Rotation(0, -14.8962, 0)
		},
		dragan = {
			Vector3(0, 1.86621, -0.0417315),
			Rotation(0, -8.02763, 0)
		},
		wolf = {
			Vector3(0, 1.98546, -0.637963),
			Rotation(0, -3.73476, 0)
		},
		sokol = {
			Vector3(0, 0.792993, -0.0417315),
			Rotation(0, -8.8862, 0)
		},
		chico = {
			Vector3(0, 1.74696, 0.5545),
			Rotation(0, -15.7548, 0)
		},
		jimmy = {
			Vector3(0, 2.82018, -0.876456),
			Rotation(-0.041893, -9.74478, 4.16882E-10)
		},
		jowi = {
			Vector3(0, 2.22395, -0.160978),
			Rotation(0, -8.02763, 0)
		},
		bonnie = {
			Vector3(0, 2.58169, -0.637963),
			Rotation(0, -5.45191, 0)
		}
	}
	self.masks.bny_02_bodhi = {}
	self.masks.bny_02_bodhi.unit = "units/pd2_dlc_bny/masks/bny_02/msk_bny_02_bodhi"
	self.masks.bny_02_bodhi.name_id = "bm_msk_bny_02b"
	self.masks.bny_02_bodhi.type = "helmet"
	self.masks.bny_02_bodhi.inaccessible = true
	self.masks.bny_02_bodhi.offsets = {
		dallas = {
			Vector3(0, 2.58169, -0.0417315),
			Rotation(-0.041893, -4.59334, 1.0422E-10)
		},
		chains = {
			Vector3(0, 2.3432, -0.637963),
			Rotation(0, -2.87619, 0)
		},
		hoxton = {
			Vector3(0, 2.3432, -0.995702),
			Rotation(0, 0, 0)
		},
		bodhi = {
			Vector3(0, 1.98546, 0.792993),
			Rotation(-0.041893, -8.8862, -2.08441E-10)
		},
		old_hoxton = {
			Vector3(0, 2.1047, -1.83043),
			Rotation(0, 3.9924, 0)
		},
		max = {
			Vector3(0, 2.82018, -1.35344),
			Rotation(0, 0, 0)
		}
	}
	self.masks.bny_02_clover = {}
	self.masks.bny_02_clover.unit = "units/pd2_dlc_bny/masks/bny_02/msk_bny_02_clover"
	self.masks.bny_02_clover.name_id = "bm_msk_bny_02c"
	self.masks.bny_02_clover.type = "helmet"
	self.masks.bny_02_clover.inaccessible = true
	self.masks.bny_02_clover.offsets = {
		female_1 = {
			Vector3(0, 0, 0),
			Rotation(0, -3.73476, 0)
		}
	}
	self.masks.bny_02 = {}
	self.masks.bny_02.name_id = "bm_msk_bny_02"
	self.masks.bny_02.value = 0
	self.masks.bny_02.pcs = {}
	self.masks.bny_02.type = "helmet"
	self.masks.bny_02.texture_bundle_folder = "bny"
	self.masks.bny_02.sort_number = 46
	self.masks.bny_02.characters = {
		dallas = "bny_02_bodhi",
		wolf = "bny_02_bonnie",
		hoxton = "bny_02_bodhi",
		chains = "bny_02_bodhi",
		jowi = "bny_02_bonnie",
		old_hoxton = "bny_02_bodhi",
		female_1 = "bny_02_clover",
		dragan = "bny_02_bonnie",
		jacket = "bny_02_bonnie",
		sokol = "bny_02_bonnie",
		dragon = "bny_02_bonnie",
		jimmy = "bny_02_bonnie",
		sydney = "bny_02_bonnie",
		wild = "bny_02_bonnie",
		chico = "bny_02_bonnie",
		bodhi = "bny_02_bodhi",
		bonnie = "bny_02_bonnie",
		max = "bny_02_bodhi"
	}
	self.masks.bny_03_clover = {}
	self.masks.bny_03_clover.unit = "units/pd2_dlc_bny/masks/bny_03/msk_bny_03_clover"
	self.masks.bny_03_clover.name_id = "bm_msk_bny_03a"
	self.masks.bny_03_clover.type = "helmet"
	self.masks.bny_03_clover.inaccessible = true
	self.masks.bny_03_clover.offsets = {
		jacket = {
			Vector3(0, 2.1047, -2.18817),
			Rotation(0, 7.4267, 0)
		},
		dallas = {
			Vector3(0, 1.50847, -0.399471),
			Rotation(0, 0, 0)
		},
		female_1 = {
			Vector3(0.5545, 2.46244, -3.49988),
			Rotation(0, 11.7196, 0)
		}
	}
	self.masks.bny_03_bodhi = {}
	self.masks.bny_03_bodhi.unit = "units/pd2_dlc_bny/masks/bny_03/msk_bny_03_bodhi"
	self.masks.bny_03_bodhi.name_id = "bm_msk_bny_03b"
	self.masks.bny_03_bodhi.type = "helmet"
	self.masks.bny_03_bodhi.inaccessible = true
	self.masks.bny_03_bodhi.offsets = {
		dragan = {
			Vector3(0, 2.1047, 0.792993),
			Rotation(0, 0, 0)
		},
		sydney = {
			Vector3(0, 3.65491, 1.86621),
			Rotation(0, -6.31048, 0)
		},
		chains = {
			Vector3(0, 1.62772, 1.15073),
			Rotation(0, -3.73476, 0)
		},
		dragon = {
			Vector3(0, 2.46244, 1.15073),
			Rotation(-0.0347619, -6.31048, -2.08441E-10)
		},
		jowi = {
			Vector3(0, 2.70093, -0.876456),
			Rotation(0, 3.13383, 0)
		},
		old_hoxton = {
			Vector3(0, 3.17792, -1.94967),
			Rotation(0, 7.4267, 0)
		},
		sokol = {
			Vector3(0, 2.1047, 0.912239),
			Rotation(0, -5.45191, 0)
		},
		chico = {
			Vector3(0, 1.74696, 0.792993),
			Rotation(0, -2.87619, 0)
		},
		wolf = {
			Vector3(0, 2.1047, 1.38922),
			Rotation(0, 0, 0)
		},
		wild = {
			Vector3(0, 2.46244, -0.160978),
			Rotation(0, 0, 0)
		},
		bodhi = {
			Vector3(0, 1.74696, 1.15073),
			Rotation(0.0409595, -5.45191, 6.25322E-10)
		},
		jimmy = {
			Vector3(0, 3.8934, -0.876456),
			Rotation(0, 0, 0)
		},
		hoxton = {
			Vector3(0, 1.50847, 1.98546),
			Rotation(0, -11.4619, 0)
		},
		bonnie = {
			Vector3(0, 3.17792, 0.316008),
			Rotation(0, 0, 0)
		},
		max = {
			Vector3(0, 3.17792, 0.316008),
			Rotation(0, 0, 0)
		}
	}
	self.masks.bny_03 = {}
	self.masks.bny_03.name_id = "bm_msk_bny_03"
	self.masks.bny_03.value = 0
	self.masks.bny_03.pcs = {}
	self.masks.bny_03.type = "helmet"
	self.masks.bny_03.texture_bundle_folder = "bny"
	self.masks.bny_03.sort_number = 46
	self.masks.bny_03.characters = {
		dallas = "bny_03_clover",
		wolf = "bny_03_bodhi",
		hoxton = "bny_03_bodhi",
		chains = "bny_03_bodhi",
		jowi = "bny_03_bodhi",
		old_hoxton = "bny_03_bodhi",
		female_1 = "bny_03_clover",
		dragan = "bny_03_bodhi",
		jacket = "bny_03_clover",
		sokol = "bny_03_bodhi",
		dragon = "bny_03_bodhi",
		jimmy = "bny_03_bodhi",
		sydney = "bny_03_bodhi",
		wild = "bny_03_bodhi",
		chico = "bny_03_bodhi",
		bodhi = "bny_03_bodhi",
		bonnie = "bny_03_bodhi",
		max = "bny_03_bodhi"
	}
	self.masks.bny_04 = {}
	self.masks.bny_04.unit = "units/pd2_dlc_bny/masks/bny_04/msk_bny_04"
	self.masks.bny_04.name_id = "bm_msk_bny_04"
	self.masks.bny_04.pcs = {}
	self.masks.bny_04.value = 0
	self.masks.bny_04.texture_bundle_folder = "bny"
	self.masks.bny_04.sort_number = 46
	self.masks.bny_04.type = "helmet"
	self.masks.mdm = {}
	self.masks.mdm.unit = "units/pd2_dlc_mdm/masks/msk_mdm/msk_mdm"
	self.masks.mdm.name_id = "bm_msk_mdm"
	self.masks.mdm.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.mdm.value = 0
	self.masks.mdm.texture_bundle_folder = "mdm"
	self.masks.mdm.sort_number = 47
	self.masks.mdm.infamous = true
	self.masks.mdm.global_value = "infamous"
	self.masks.max = {}
	self.masks.max.unit = "units/pd2_dlc_max/masks/msk_max"
	self.masks.max.name_id = "bm_msk_max"
	self.masks.max.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.max.value = 0
	self.masks.max.texture_bundle_folder = "max"
	self.masks.max.sort_number = 48
	self.masks.max.infamous = true
	self.masks.max.global_value = "infamous"
	self.masks.max_begins = {}
	self.masks.max_begins.unit = "units/pd2_dlc_max/masks/msk_max_begins"
	self.masks.max_begins.name_id = "bm_msk_max_begins"
	self.masks.max_begins.pcs = {
		10,
		20,
		30,
		40
	}
	self.masks.max_begins.value = 0
	self.masks.max_begins.texture_bundle_folder = "max"
	self.masks.max_begins.sort_number = 49
	self.masks.max_begins.infamous = true
	self.masks.max_begins.global_value = "infamous"
	self.masks.ant_01 = {}
	self.masks.ant_01.unit = "units/pd2_dlc_ant/masks/ant_01/msk_ant_01"
	self.masks.ant_01.name_id = "bm_msk_ant_01"
	self.masks.ant_01.pcs = {}
	self.masks.ant_01.value = 0
	self.masks.ant_01.texture_bundle_folder = "ant"
	self.masks.ant_01.sort_number = 49
	self.masks.ant_01.type = "helmet"
	self.masks.ant_01.dlc = "ant"
	self.masks.ant_01.global_value = "ant"
	self.masks.ant_02 = {}
	self.masks.ant_02.unit = "units/pd2_dlc_ant/masks/ant_02/msk_ant_02"
	self.masks.ant_02.name_id = "bm_msk_ant_02"
	self.masks.ant_02.pcs = {}
	self.masks.ant_02.value = 0
	self.masks.ant_02.texture_bundle_folder = "ant"
	self.masks.ant_02.sort_number = 49
	self.masks.ant_02.type = "helmet"
	self.masks.ant_02.dlc = "ant"
	self.masks.ant_02.global_value = "ant"
	self.masks.ant_03 = {}
	self.masks.ant_03.unit = "units/pd2_dlc_ant/masks/ant_03/msk_ant_03"
	self.masks.ant_03.name_id = "bm_msk_ant_03"
	self.masks.ant_03.pcs = {}
	self.masks.ant_03.value = 0
	self.masks.ant_03.texture_bundle_folder = "ant"
	self.masks.ant_03.sort_number = 49
	self.masks.ant_03.type = "helmet"
	self.masks.ant_03.dlc = "ant"
	self.masks.ant_03.global_value = "ant"
	self.masks.ant_04 = {}
	self.masks.ant_04.unit = "units/pd2_dlc_ant/masks/ant_04/msk_ant_04"
	self.masks.ant_04.name_id = "bm_msk_ant_04"
	self.masks.ant_04.pcs = {}
	self.masks.ant_04.value = 0
	self.masks.ant_04.texture_bundle_folder = "ant"
	self.masks.ant_04.sort_number = 49
	self.masks.ant_04.type = "helmet"
	self.masks.ant_04.dlc = "ant"
	self.masks.ant_04.global_value = "ant"
	self.masks.ant_05 = {}
	self.masks.ant_05.unit = "units/pd2_dlc_ant/masks/ant_05/msk_ant_05"
	self.masks.ant_05.name_id = "bm_msk_ant_05"
	self.masks.ant_05.pcs = {}
	self.masks.ant_05.value = 0
	self.masks.ant_05.texture_bundle_folder = "ant"
	self.masks.ant_05.sort_number = 50
	self.masks.ant_05.type = "helmet"
	self.masks.ant_05.global_value = "ant_free"
	self.masks.ant_06 = {}
	self.masks.ant_06.unit = "units/pd2_dlc_ant/masks/ant_06/msk_ant_06"
	self.masks.ant_06.name_id = "bm_msk_ant_06"
	self.masks.ant_06.pcs = {}
	self.masks.ant_06.value = 0
	self.masks.ant_06.texture_bundle_folder = "ant"
	self.masks.ant_06.sort_number = 49
	self.masks.ant_06.type = "helmet"
	self.masks.ant_06.dlc = "ant"
	self.masks.ant_06.global_value = "ant"
	self.masks.ant_07 = {}
	self.masks.ant_07.unit = "units/pd2_dlc_ant/masks/ant_07/msk_ant_07"
	self.masks.ant_07.name_id = "bm_msk_ant_07"
	self.masks.ant_07.pcs = {}
	self.masks.ant_07.value = 0
	self.masks.ant_07.texture_bundle_folder = "ant"
	self.masks.ant_07.sort_number = 50
	self.masks.ant_07.type = "helmet"
	self.masks.ant_07.global_value = "ant_free"
	self.masks.ant_08 = {}
	self.masks.ant_08.unit = "units/pd2_dlc_ant/masks/ant_08/msk_ant_08"
	self.masks.ant_08.name_id = "bm_msk_ant_08"
	self.masks.ant_08.pcs = {}
	self.masks.ant_08.value = 0
	self.masks.ant_08.texture_bundle_folder = "ant"
	self.masks.ant_08.sort_number = 49
	self.masks.ant_08.type = "helmet"
	self.masks.ant_08.dlc = "ant"
	self.masks.ant_08.global_value = "ant"
	self.masks.dgm = {}
	self.masks.dgm.unit = "units/pd2_dlc_dgm/masks/msk_dgm"
	self.masks.dgm.name_id = "bm_msk_dgm"
	self.masks.dgm.pcs = {}
	self.masks.dgm.value = 0
	self.masks.dgm.texture_bundle_folder = "dgm"
	self.masks.dgm.sort_number = 50
	self.masks.dgm.global_value = "pd2_clan"
	self.masks.gcm = {}
	self.masks.gcm.unit = "units/pd2_dlc_gcm/masks/msk_gcm"
	self.masks.gcm.name_id = "bm_msk_gcm"
	self.masks.gcm.pcs = {}
	self.masks.gcm.value = 0
	self.masks.gcm.texture_bundle_folder = "gcm"
	self.masks.gcm.sort_number = 53
	self.masks.gcm.global_value = "pd2_clan"
	local free_dlcs = tweak_data:free_dlc_list()
	for _, data in pairs(self.masks) do
		if free_dlcs[data.dlc] then
			data.dlc = nil
		end
	end
	self:_add_desc_from_name_macro(self.masks)
end
