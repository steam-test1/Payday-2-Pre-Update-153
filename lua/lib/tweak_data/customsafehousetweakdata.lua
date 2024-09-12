CustomSafehouseTweakData = CustomSafehouseTweakData or class()

function CustomSafehouseTweakData:init(tweak_data)
	self.prices = {}
	self.prices.rooms = {
		0,
		12,
		24
	}
	self.prices.weapon_mod = 6
	self.rewards = {}
	self.rewards.initial = self.prices.rooms[2] * 1
	self.rewards.challenge = 6
	self.rewards.daily_complete = 6
	self.rewards.raid = 6
	self.rewards.experience_ratio = 1000000
	self.level_limit = 25
	self.combat = {}
	self.combat.waves = {
		easy = 3,
		normal = 3,
		hard = 3,
		overkill = 3,
		overkill_145 = 3,
		easy_wish = 3,
		overkill_290 = 3,
		sm_wish = 3
	}
	self:_init_heisters(tweak_data)
	self:_init_safehouse_contractors(tweak_data)
	self:_init_safehouse_rooms(tweak_data)
	self:_init_trophies(tweak_data)
	self:_init_dailies(tweak_data)
	self:_init_map(tweak_data)
	self.daily_redirects = {
		daily_tapes = "daily_spacetime",
		daily_sewers = "daily_helicopter",
		daily_art = "daily_mortage"
	}
end

function CustomSafehouseTweakData:_init_heisters(tweak_data)
	self.heisters = {}
	self.heisters.base = {}
	self.heisters.base.idle_line_dist = 500
	self.heisters.base.idle_line_time = {15, 20}
	self.heisters.base.answer_lines = {
		{
			sound_event = "Play_{voice}_answering",
			priority = 0
		}
	}
	self.heisters.base.idle_lines = {
		{
			sound_event = "Play_{voice}_idle",
			priority = 0
		}
	}
	self.heisters.dallas = clone(self.heisters.base)
	self.heisters.dallas.character_material = "var_mtr_dallas"
	self.heisters.dallas.voice = self:get_voice(tweak_data, "russian")
	self.heisters.chains = clone(self.heisters.base)
	self.heisters.chains.character_material = "var_mtr_chains"
	self.heisters.chains.voice = self:get_voice(tweak_data, "spanish")
	self.heisters.hoxton = clone(self.heisters.base)
	self.heisters.hoxton.character_material = "var_mtr_hoxton"
	self.heisters.hoxton.voice = self:get_voice(tweak_data, "american")
	self.heisters.hoxton.answer_lines = {
		{
			sound_event = "Play_{voice}_answering",
			priority = 0
		},
		{
			sound_event = "Play_{voice}_answering_longfellow",
			priority = 10,
			requirements = {
				tiers = {3},
				trophies = {
					"trophy_longfellow"
				}
			}
		}
	}
	self.heisters.wolf = clone(self.heisters.base)
	self.heisters.wolf.character_material = "var_mtr_wolf"
	self.heisters.wolf.voice = self:get_voice(tweak_data, "german")
	self.heisters.jowi = clone(self.heisters.base)
	self.heisters.jowi.character_material = "var_mtr_john_wick"
	self.heisters.jowi.voice = self:get_voice(tweak_data, "jowi")
	self.heisters.old_hoxton = clone(self.heisters.base)
	self.heisters.old_hoxton.character_material = "var_mtr_old_hoxton"
	self.heisters.old_hoxton.voice = self:get_voice(tweak_data, "old_hoxton")
	self.heisters.clover = clone(self.heisters.base)
	self.heisters.clover.character_material = "var_mtr_fem1"
	self.heisters.clover.voice = self:get_voice(tweak_data, "female_1")
	self.heisters.dragan = clone(self.heisters.base)
	self.heisters.dragan.character_material = "var_mtr_dragan"
	self.heisters.dragan.voice = self:get_voice(tweak_data, "dragan")
	self.heisters.jacket = clone(self.heisters.base)
	self.heisters.jacket.character_material = "var_mtr_jacket"
	self.heisters.jacket.voice = self:get_voice(tweak_data, "jacket")
	self.heisters.bonnie = clone(self.heisters.base)
	self.heisters.bonnie.character_material = "var_mtr_bonnie"
	self.heisters.bonnie.voice = self:get_voice(tweak_data, "bonnie")
	self.heisters.sokol = clone(self.heisters.base)
	self.heisters.sokol.character_material = "var_mtr_sokol"
	self.heisters.sokol.voice = self:get_voice(tweak_data, "sokol")
	self.heisters.dragon = clone(self.heisters.base)
	self.heisters.dragon.character_material = "var_mtr_jiro"
	self.heisters.dragon.voice = self:get_voice(tweak_data, "dragon")
	self.heisters.bodhi = clone(self.heisters.base)
	self.heisters.bodhi.character_material = "var_mtr_bodhi"
	self.heisters.bodhi.voice = self:get_voice(tweak_data, "bodhi")
	self.heisters.jimmy = clone(self.heisters.base)
	self.heisters.jimmy.character_material = "var_mtr_jimmy"
	self.heisters.jimmy.voice = self:get_voice(tweak_data, "jimmy")
	self.heisters.sydney = clone(self.heisters.base)
	self.heisters.sydney.character_material = "var_mtr_sydney"
	self.heisters.sydney.voice = self:get_voice(tweak_data, "sydney")
	self.heisters.wild = clone(self.heisters.base)
	self.heisters.wild.character_material = "var_mtr_wild"
	self.heisters.wild.voice = self:get_voice(tweak_data, "wild")
	self.heisters.butler = clone(self.heisters.base)
	self.heisters.butler.character_material = ""
	self.heisters.butler.voice = self:get_voice(tweak_data, "butler")
end

function CustomSafehouseTweakData:get_voice(tweak_data, character_name)
	for i, data in ipairs(tweak_data.criminals.characters) do
		if data.name == character_name then
			return data.static_data.voice
		end
	end
end

function CustomSafehouseTweakData:_init_safehouse_contractors(tweak_data)
	local heister_weighting = 98 / #tweak_data.criminals.character_names
	local butler_weighting = 2
	self.contractors = {}
	table.insert(self.contractors, {
		name_id = "menu_russian",
		character = "russian",
		character_name = "dallas",
		image_name = "dallas",
		weighting = heister_weighting,
		dailies = {
			"daily_classics",
			"daily_discord"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_spanish",
		character = "spanish",
		character_name = "chains",
		image_name = "chains",
		weighting = heister_weighting,
		dailies = {
			"daily_grenades",
			"daily_phobia"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_german",
		character = "german",
		character_name = "wolf",
		image_name = "wolf",
		weighting = heister_weighting,
		dailies = {
			"daily_fwtd",
			"daily_gears"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_american",
		character = "american",
		character_name = "houston",
		image_name = "houston",
		weighting = heister_weighting,
		dailies = {
			"daily_mortage",
			"daily_art"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_old_hoxton",
		character = "old_hoxton",
		image_name = "hoxton",
		weighting = heister_weighting,
		dailies = {
			"daily_spacetime",
			"daily_tapes"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_jowi",
		character = "jowi",
		image_name = "john",
		weighting = heister_weighting,
		dailies = {
			"daily_akimbo",
			"daily_professional"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_clover",
		character = "female_1",
		character_name = "clover",
		image_name = "clover",
		weighting = heister_weighting,
		dailies = {
			"daily_toast",
			"daily_heirloom"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_dragan",
		character = "dragan",
		image_name = "dragan",
		weighting = heister_weighting,
		dailies = {}
	})
	table.insert(self.contractors, {
		name_id = "menu_jacket",
		character = "jacket",
		image_name = "jacket",
		weighting = heister_weighting,
		dailies = {
			"daily_night_out",
			"daily_secret_identity"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_sokol",
		character = "sokol",
		image_name = "sokol",
		weighting = heister_weighting,
		dailies = {
			"daily_rush",
			"daily_naked"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_bonnie",
		character = "bonnie",
		image_name = "bonnie",
		weighting = heister_weighting,
		dailies = {
			"daily_lodsofemone",
			"daily_hangover"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_dragon",
		character = "dragon",
		image_name = "jiro",
		weighting = heister_weighting,
		dailies = {
			"daily_honorable",
			"daily_ninja"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_bodhi",
		character = "bodhi",
		image_name = "bodhi",
		weighting = heister_weighting,
		dailies = {
			"daily_cake",
			"daily_my_bodhi_is_ready"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_jimmy",
		character = "jimmy",
		image_name = "jimmy",
		weighting = heister_weighting,
		dailies = {
			"daily_tasty",
			"daily_candy"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_sydney",
		character = "sydney",
		image_name = "sydney",
		weighting = heister_weighting,
		dailies = {
			"daily_dosh",
			"daily_snake"
		}
	})
	table.insert(self.contractors, {
		name_id = "menu_wild",
		character = "wild",
		image_name = "rust",
		weighting = heister_weighting,
		dailies = {}
	})
	table.insert(self.contractors, {
		name_id = "menu_butler",
		character = "butler",
		weighting = butler_weighting,
		dailies = {}
	})
end

function CustomSafehouseTweakData:_init_safehouse_rooms(tweak_data)
	self.rooms = {}
	table.insert(self.rooms, {
		room_id = "russian",
		name_id = "menu_russian",
		title_id = "menu_cs_title_dallas",
		help_id = "menu_cs_help_dallas",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_dallas_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_dallas_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_dallas_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "spanish",
		name_id = "menu_spanish",
		title_id = "menu_cs_title_chains",
		help_id = "menu_cs_help_chains",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_chains_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_chains_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_chains_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "german",
		name_id = "menu_german",
		title_id = "menu_cs_title_wolf",
		help_id = "menu_cs_help_wolf",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_wolf_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_wolf_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_wolf_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "american",
		name_id = "menu_american",
		title_id = "menu_cs_title_houston",
		help_id = "menu_cs_help_houston",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_houston_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_houston_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_houston_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "old_hoxton",
		name_id = "menu_old_hoxton",
		title_id = "menu_cs_title_hoxton",
		help_id = "menu_cs_help_hoxton",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_hoxton_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_hoxton_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_hoxton_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "jowi",
		name_id = "menu_jowi",
		title_id = "menu_cs_title_jowi",
		help_id = "menu_cs_help_jowi",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_wick_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_wick_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_wick_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "clover",
		name_id = "menu_clover",
		title_id = "menu_cs_title_clover",
		help_id = "menu_cs_help_clover",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_clover_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_clover_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_clover_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "dragan",
		name_id = "menu_dragan",
		title_id = "menu_cs_title_dragan",
		help_id = "menu_cs_help_dragan",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_dragan_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_dragan_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_dragan_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "jacket",
		name_id = "menu_jacket",
		title_id = "menu_cs_title_jacket",
		help_id = "menu_cs_help_jacket",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jacket_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jacket_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jacket_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "sokol",
		name_id = "menu_sokol",
		title_id = "menu_cs_title_sokol",
		help_id = "menu_cs_help_sokol",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_sokol_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_sokol_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_sokol_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "bonnie",
		name_id = "menu_bonnie",
		title_id = "menu_cs_title_bonnie",
		help_id = "menu_cs_help_bonnie",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_bonnie_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_bonnie_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_bonnie_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "dragon",
		name_id = "menu_dragon",
		title_id = "menu_cs_title_dragon",
		help_id = "menu_cs_help_dragon",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jiro_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jiro_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jiro_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "bodhi",
		name_id = "menu_bodhi",
		title_id = "menu_cs_title_bodhi",
		help_id = "menu_cs_help_bodhi",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_bodhi_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_bodhi_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_bodhi_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "jimmy",
		name_id = "menu_jimmy",
		title_id = "menu_cs_title_jimmy",
		help_id = "menu_cs_help_jimmy",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jimmy_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jimmy_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_jimmy_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "sydney",
		name_id = "menu_sydney",
		title_id = "menu_cs_title_sydney",
		help_id = "menu_cs_help_sydney",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_sydney_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_sydney_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_sydney_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "wild",
		name_id = "menu_wild",
		title_id = "menu_cs_title_rust",
		help_id = "menu_cs_help_rust",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_rust_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_rust_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_rust_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "vault",
		name_id = "menu_cs_vault",
		title_id = "menu_cs_title_vault",
		help_id = "menu_cs_help_vault",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_vault_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_vault_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_vault_lvl3"
		}
	})
	table.insert(self.rooms, {
		room_id = "livingroom",
		name_id = "menu_cs_common_room",
		title_id = "menu_cs_title_common_room",
		help_id = "menu_cs_help_common_room",
		tier_max = 3,
		images = {
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_common_rooms_lvl1",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_common_rooms_lvl2",
			"guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_common_rooms_lvl3"
		}
	})
end

function CustomSafehouseTweakData:_create_objective(data)
	local save_values = {
		"achievement_id",
		"progress_id",
		"completed",
		"progress"
	}
	if data.save_values then
		for idx, value in ipairs(data.save_values) do
			table.insert(save_values, value)
		end
	end
	local obj = {
		achievement_id = data.achievement_id,
		name_id = data.name_id,
		desc_id = data.desc_id,
		completed = false,
		displayed = true,
		progress_id = data.progress_id,
		max_progress = data.progress_id and data.max_progress or 1,
		progress = 0,
		verify = data.verify,
		save_values = save_values
	}
	return obj
end

function CustomSafehouseTweakData:_achievement(achievement_id, data)
	data = data or {}
	data.achievement_id = achievement_id
	return self:_create_objective(data)
end

function CustomSafehouseTweakData:_progress(progress_id, max_progress, data)
	data = data or {}
	data.progress_id = progress_id
	data.max_progress = max_progress or 1
	return self:_create_objective(data)
end

function CustomSafehouseTweakData:_init_trophies(tweak_data)
	self.trophies = {}
	table.insert(self.trophies, {
		id = "trophy_falcogini",
		name_id = "trophy_falcogini",
		desc_id = "trophy_falcogini_desc",
		objective_id = "trophy_falcogini_objective",
		objectives = {
			self:_progress("trophy_car_shop", 1)
		},
		image_id = "safehouse_trophies_preview_falcogini"
	})
	table.insert(self.trophies, {
		id = "trophy_dartboard",
		name_id = "trophy_dartboard",
		desc_id = "trophy_dartboard_desc",
		objective_id = "trophy_dartboard_objective",
		objectives = {
			self:_progress("trophy_headshots", 500, {
				name_id = "trophy_dartboard_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_dartboard"
	})
	table.insert(self.trophies, {
		id = "trophy_hockey_team",
		name_id = "trophy_hockey_team",
		desc_id = "trophy_hockey_team_desc",
		objective_id = "trophy_hockey_team_objective",
		objectives = {
			self:_achievement("the_first_line")
		},
		image_id = "safehouse_trophies_preview_hockey_team"
	})
	table.insert(self.trophies, {
		id = "trophy_escape_van",
		name_id = "trophy_escape_van",
		desc_id = "trophy_escape_van_desc",
		objective_id = "trophy_escape_van_objective",
		objectives = {
			self:_progress("trophy_escapes", 10, {
				name_id = "trophy_escape_van_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_escape_van"
	})
	table.insert(self.trophies, {
		id = "trophy_meth_cookbook",
		name_id = "trophy_meth_cookbook",
		desc_id = "trophy_meth_cookbook_desc",
		objective_id = "trophy_meth_cookbook_objective",
		objectives = {
			self:_achievement("voff_5")
		},
		image_id = "safehouse_trophies_preview_meth_cookbook"
	})
	table.insert(self.trophies, {
		id = "trophy_diamonds",
		name_id = "trophy_diamonds",
		desc_id = "trophy_diamonds_desc",
		objective_id = "trophy_diamonds_objective",
		objectives = {
			self:_progress("trophy_diamond_store_heist", 1)
		},
		image_id = "safehouse_trophies_preview_diamonds"
	})
	table.insert(self.trophies, {
		id = "trophy_stealth",
		name_id = "trophy_stealth",
		desc_id = "trophy_stealth_desc",
		objective_id = "trophy_stealth_objective",
		objectives = {
			self:_progress("trophy_stealth", 15, {
				name_id = "trophy_stealth_progress",
				verify = "_verify_unique_heist",
				save_values = {
					"completed_heists"
				}
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_stealth"
	})
	table.insert(self.trophies, {
		id = "trophy_tiara",
		name_id = "trophy_tiara",
		desc_id = "trophy_tiara_desc",
		objective_id = "trophy_tiara_objective",
		objectives = {
			self:_progress("trophy_ukranian_dw", 1)
		},
		image_id = "safehouse_trophies_preview_tiara"
	})
	table.insert(self.trophies, {
		id = "trophy_hobo_knife",
		name_id = "trophy_hobo_knife",
		desc_id = "trophy_hobo_knife_desc",
		objective_id = "trophy_hobo_knife_objective",
		objectives = {
			self:_achievement("sinus_1")
		},
		image_id = "safehouse_trophies_preview_hobo_knife"
	})
	table.insert(self.trophies, {
		id = "trophy_transports",
		name_id = "trophy_transports",
		desc_id = "trophy_transports_desc",
		objective_id = "trophy_transports_objective",
		objectives = {
			self:_progress("trophy_transport_crossroads", 1, {
				name_id = "heist_arm_cro"
			}),
			self:_progress("trophy_transport_downtown", 1, {
				name_id = "heist_arm_hcm"
			}),
			self:_progress("trophy_transport_harbor", 1, {
				name_id = "heist_arm_fac"
			}),
			self:_progress("trophy_transport_park", 1, {
				name_id = "heist_arm_par"
			}),
			self:_progress("trophy_transport_underpass", 1, {
				name_id = "heist_arm_und"
			}),
			self:_progress("trophy_transport_train", 1, {
				name_id = "heist_arm_for"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_transports"
	})
	table.insert(self.trophies, {
		id = "trophy_golden_grin",
		name_id = "trophy_golden_grin",
		desc_id = "trophy_golden_grin_desc",
		objective_id = "trophy_golden_grin_objective",
		objectives = {
			self:_progress("trophy_stealth_grin_dw", 1)
		},
		image_id = "safehouse_trophies_preview_golden_grin"
	})
	table.insert(self.trophies, {
		id = "trophy_pacifier",
		name_id = "trophy_pacifier",
		desc_id = "trophy_pacifier_desc",
		objective_id = "trophy_pacifier_objective",
		objectives = {
			self:_progress("trophy_basics_stealth", 1, {
				name_id = "heist_short1"
			}),
			self:_progress("trophy_basics_loud", 1, {
				name_id = "heist_short2"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_pacifier"
	})
	table.insert(self.trophies, {
		id = "trophy_discoball",
		name_id = "trophy_discoball",
		desc_id = "trophy_discoball_desc",
		objective_id = "trophy_discoball_objective",
		objectives = {
			self:_progress("trophy_nightclub_dw", 1)
		},
		image_id = "safehouse_trophies_preview_discoball"
	})
	table.insert(self.trophies, {
		id = "trophy_boxing_gloves",
		name_id = "trophy_boxing_gloves",
		desc_id = "trophy_boxing_gloves_desc",
		objective_id = "trophy_boxing_gloves_objective",
		objectives = {
			self:_progress("trophy_knockouts", 5, {
				name_id = "trophy_boxing_gloves_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_boxing_gloves"
	})
	table.insert(self.trophies, {
		id = "trophy_ring",
		name_id = "trophy_ring",
		desc_id = "trophy_ring_desc",
		objective_id = "trophy_ring_objective",
		objectives = {
			self:_achievement("voff_4")
		},
		image_id = "safehouse_trophies_preview_ring"
	})
	table.insert(self.trophies, {
		id = "trophy_dozer_helmet",
		name_id = "trophy_dozer_helmet",
		desc_id = "trophy_dozer_helmet_desc",
		objective_id = "trophy_dozer_helmet_objective",
		objectives = {
			self:_progress("trophy_special_kills", 100, {
				name_id = "trophy_dozer_helmet_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_dozer_helmet"
	})
	table.insert(self.trophies, {
		id = "trophy_goat",
		name_id = "trophy_goat",
		desc_id = "trophy_goat_desc",
		objective_id = "trophy_goat_objective",
		objectives = {
			self:_progress("trophy_goats_extracted", 25, {
				name_id = "trophy_goat_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_goat"
	})
	table.insert(self.trophies, {
		id = "trophy_tfturret",
		name_id = "trophy_tfturret",
		desc_id = "trophy_tfturret_desc",
		objective_id = "trophy_tfturret_objective",
		objectives = {
			self:_progress("trophy_tfturret", 1)
		},
		image_id = "safehouse_trophies_preview_tfturret"
	})
	table.insert(self.trophies, {
		id = "trophy_train_bomb",
		name_id = "trophy_train_bomb",
		desc_id = "trophy_train_bomb_desc",
		objective_id = "trophy_train_bomb_objective",
		objectives = {
			self:_achievement("trophy_train_bomb")
		},
		image_id = "safehouse_trophies_preview_train_bomb"
	})
	table.insert(self.trophies, {
		id = "trophy_computer",
		name_id = "trophy_computer",
		desc_id = "trophy_computer_desc",
		objective_id = "trophy_computer_objective",
		objectives = {
			self:_progress("trophy_ed_computer_full_hack", 1)
		},
		image_id = "safehouse_trophies_preview_computer"
	})
	table.insert(self.trophies, {
		id = "trophy_longfellow",
		name_id = "trophy_longfellow",
		desc_id = "trophy_longfellow_desc",
		objective_id = "trophy_longfellow_objective",
		objectives = {
			self:_progress("trophy_shoutout", 1)
		},
		image_id = "safehouse_trophies_preview_longfellow"
	})
	table.insert(self.trophies, {
		id = "trophy_bank_heists",
		name_id = "trophy_bank_heists",
		desc_id = "trophy_bank_heists_desc",
		objective_id = "trophy_bank_heists_objective",
		objectives = {
			self:_progress("trophy_bank_heists", 1)
		},
		image_id = "safehouse_trophies_preview_bank_heists"
	})
	table.insert(self.trophies, {
		id = "trophy_carshop_stealth",
		name_id = "trophy_carshop_stealth",
		desc_id = "trophy_carshop_stealth_desc",
		objective_id = "trophy_carshop_stealth_objective",
		objectives = {
			self:_progress("trophy_carshop_stealth", 1)
		},
		image_id = "safehouse_trophies_preview_carshop_stealth"
	})
	table.insert(self.trophies, {
		id = "trophy_ace",
		name_id = "trophy_ace",
		desc_id = "trophy_ace_desc",
		objective_id = "trophy_ace_objective",
		objectives = {
			self:_progress("trophy_ace", 100, {
				name_id = "trophy_ace_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_ace"
	})
	table.insert(self.trophies, {
		id = "trophy_washington",
		name_id = "trophy_washington",
		desc_id = "trophy_washington_desc",
		objective_id = "trophy_washington_objective",
		objectives = {
			self:_progress("trophy_washington", 658893, {
				name_id = "trophy_ace_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_hoxton_statue"
	})
	table.insert(self.trophies, {
		id = "trophy_watchout",
		name_id = "trophy_watchout",
		desc_id = "trophy_watchout_desc",
		objective_id = "trophy_watchout_objective",
		objectives = {
			self:_progress("trophy_watchout", 1)
		},
		image_id = "safehouse_trophies_preview_watchout"
	})
	table.insert(self.trophies, {
		id = "trophy_piggy_bank",
		name_id = "trophy_piggy_bank",
		desc_id = "trophy_piggy_bank_desc",
		objective_id = "trophy_piggy_bank_objective",
		objectives = {
			self:_progress("trophy_piggy_bank", 1)
		},
		image_id = "safehouse_trophies_preview_piggy_bank"
	})
	table.insert(self.trophies, {
		id = "trophy_dance",
		name_id = "trophy_dance",
		desc_id = "trophy_dance_desc",
		objective_id = "trophy_dance_objective",
		objectives = {
			self:_progress("trophy_dance", 1)
		},
		image_id = "safehouse_trophies_preview_dances"
	})
	table.insert(self.trophies, {
		id = "trophy_fbi",
		name_id = "trophy_fbi",
		desc_id = "trophy_fbi_desc",
		objective_id = "trophy_fbi_objective",
		objectives = {
			self:_progress("trophy_fbi", 1)
		},
		image_id = "safehouse_trophies_preview_fbi"
	})
	table.insert(self.trophies, {
		id = "trophy_jfk",
		name_id = "trophy_jfk",
		desc_id = "trophy_jfk_desc",
		objective_id = "trophy_jfk_objective",
		objectives = {
			self:_progress("trophy_jfk", 1)
		},
		image_id = "safehouse_trophies_preview_jfk"
	})
	table.insert(self.trophies, {
		id = "trophy_smg",
		name_id = "trophy_smg",
		desc_id = "trophy_smg_desc",
		objective_id = "trophy_smg_objective",
		objectives = {
			self:_progress("trophy_smg", 1)
		},
		image_id = "safehouse_trophies_preview_smg"
	})
	table.insert(self.trophies, {
		id = "trophy_host",
		name_id = "trophy_host",
		desc_id = "trophy_host_desc",
		objective_id = "trophy_host_objective",
		objectives = {
			self:_progress("trophy_host", 10, {
				name_id = "trophy_host_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_host"
	})
	table.insert(self.trophies, {
		id = "trophy_framing_frame",
		name_id = "trophy_framing_frame",
		desc_id = "trophy_framing_frame_desc",
		objective_id = "trophy_framing_frame_objective",
		objectives = {
			self:_progress("trophy_framing_frame", 1)
		},
		image_id = "safehouse_trophies_preview_framing_frame"
	})
	table.insert(self.trophies, {
		id = "trophy_sandwich",
		name_id = "trophy_sandwich",
		desc_id = "trophy_sandwich_desc",
		objective_id = "trophy_sandwich_objective",
		objectives = {
			self:_progress("trophy_sandwich", 1)
		},
		image_id = "safehouse_trophies_preview_sandwich"
	})
	table.insert(self.trophies, {
		id = "trophy_planmaker",
		name_id = "trophy_planmaker",
		desc_id = "trophy_planmaker_desc",
		objective_id = "trophy_planmaker_objective",
		objectives = {
			self:_progress("trophy_planmaker", 1)
		},
		image_id = "safehouse_trophies_preview_planmaker"
	})
	table.insert(self.trophies, {
		id = "trophy_bonfire",
		name_id = "trophy_bonfire",
		desc_id = "trophy_bonfire_desc",
		objective_id = "trophy_bonfire_objective",
		objectives = {
			self:_progress("trophy_bonfire", 1)
		},
		secret = true,
		image_id = "safehouse_trophies_preview_bonfire"
	})
	table.insert(self.trophies, {
		id = "trophy_smwish",
		name_id = "trophy_smwish",
		desc_id = "trophy_smwish_desc",
		objective_id = "trophy_smwish_objective",
		objectives = {
			self:_progress("trophy_smwish", 1)
		},
		image_id = "safehouse_trophies_preview_dallas_statue"
	})
	table.insert(self.trophies, {
		id = "trophy_medic",
		name_id = "trophy_medic",
		desc_id = "trophy_medic_desc",
		objective_id = "trophy_medic_objective",
		objectives = {
			self:_progress("trophy_medic", 100, {
				name_id = "trophy_medic_progress"
			})
		},
		show_progress = true,
		image_id = "safehouse_trophies_preview_medic"
	})
	table.insert(self.trophies, {
		id = "trophy_courtesy",
		name_id = "trophy_courtesy",
		desc_id = "trophy_courtesy_desc",
		objective_id = "trophy_courtesy_objective",
		objectives = {
			self:_progress("trophy_courtesy", 1)
		},
		image_id = "safehouse_trophies_preview_courtesy"
	})
	table.insert(self.trophies, {
		id = "trophy_evolution",
		name_id = "trophy_evolution",
		desc_id = "trophy_evolution_desc",
		objective_id = "trophy_evolution_objective",
		objectives = {
			self:_progress("trophy_evolution", 1)
		},
		image_id = "safehouse_trophies_preview_evolution"
	})
	table.insert(self.trophies, {
		id = "trophy_flawless",
		name_id = "trophy_flawless",
		desc_id = "trophy_flawless_desc",
		objective_id = "trophy_flawless_objective",
		objectives = {
			self:_progress("trophy_flawless", 1)
		},
		image_id = "safehouse_trophies_preview_flawless"
	})
	table.insert(self.trophies, {
		id = "trophy_defender",
		name_id = "trophy_defender",
		desc_id = "trophy_defender_desc",
		objective_id = "trophy_defender_objective",
		objectives = {
			self:_progress("trophy_defender", 1)
		},
		image_id = "safehouse_trophies_preview_barbwire"
	})
	table.insert(self.trophies, {
		id = "trophy_tooth",
		name_id = "trophy_tooth",
		desc_id = "trophy_tooth_desc",
		objective_id = "trophy_tooth_objective",
		objectives = {
			self:_achievement("flat_3")
		},
		image_id = "safehouse_trophies_preview_toothbrush"
	})
end

function CustomSafehouseTweakData:get_trophy_data(id)
	for idx, trophy in ipairs(self.trophies) do
		if trophy.id == id then
			return trophy
		end
	end
	return self:get_daily_data(id)
end

function CustomSafehouseTweakData:_verify_unique_heist(trophy_objective)
	trophy_objective.completed_heists = trophy_objective.completed_heists or {}
	local job_id = managers.job:current_job_id()
	if job_id and not table.contains(trophy_objective.completed_heists, job_id) then
		table.insert(trophy_objective.completed_heists, job_id)
		return true
	else
		return false
	end
end

function CustomSafehouseTweakData:_init_dailies(tweak_data)
	self.dailies = {}
	table.insert(self.dailies, {
		id = "daily_classics",
		name_id = "daily_classics",
		desc_id = "daily_classics_desc",
		objective_id = "daily_classics_objective",
		objectives = {
			self:_progress("daily_classics", 2, {
				name_id = "daily_classics_progress",
				verify = "_verify_unique_heist",
				save_values = {
					"completed_heists"
				}
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_discord",
		name_id = "daily_discord",
		desc_id = "daily_discord_desc",
		objective_id = "daily_discord_objective",
		objectives = {
			self:_progress("daily_discord", 3, {
				name_id = "daily_discord_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_fwtd",
		name_id = "daily_fwtd",
		desc_id = "daily_fwtd_desc",
		objective_id = "daily_fwtd_objective",
		objectives = {
			self:_progress("daily_fwtd", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_gears",
		name_id = "daily_gears",
		desc_id = "daily_gears_desc",
		objective_id = "daily_gears_objective",
		objectives = {
			self:_progress("daily_gears", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_grenades",
		name_id = "daily_grenades",
		desc_id = "daily_grenades_desc",
		objective_id = "daily_grenades_objective",
		objectives = {
			self:_progress("daily_grenades", 25, {
				name_id = "daily_grenades_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_phobia",
		name_id = "daily_phobia",
		desc_id = "daily_phobia_desc",
		objective_id = "daily_phobia_objective",
		objectives = {
			self:_progress("daily_phobia", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_mortage",
		name_id = "daily_mortage",
		desc_id = "daily_mortage_desc",
		objective_id = "daily_mortage_objective",
		objectives = {
			self:_progress("daily_mortage", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_art",
		name_id = "daily_art",
		desc_id = "daily_art_desc",
		objective_id = "daily_art_objective",
		objectives = {
			self:_progress("daily_art", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_akimbo",
		name_id = "daily_akimbo",
		desc_id = "daily_akimbo_desc",
		objective_id = "daily_akimbo_objective",
		objectives = {
			self:_progress("daily_akimbo", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_professional",
		name_id = "daily_professional",
		desc_id = "daily_professional_desc",
		objective_id = "daily_professional_objective",
		objectives = {
			self:_progress("daily_professional", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_spacetime",
		name_id = "daily_spacetime",
		desc_id = "daily_spacetime_desc",
		objective_id = "daily_spacetime_objective",
		objectives = {
			self:_progress("daily_spacetime", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_tapes",
		name_id = "daily_tapes",
		desc_id = "daily_tapes_desc",
		objective_id = "daily_tapes_objective",
		objectives = {
			self:_progress("daily_tapes", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_toast",
		name_id = "daily_toast",
		desc_id = "daily_toast_desc",
		objective_id = "daily_toast_objective",
		objectives = {
			self:_progress("daily_toast", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_heirloom",
		name_id = "daily_heirloom",
		desc_id = "daily_heirloom_desc",
		objective_id = "daily_heirloom_objective",
		objectives = {
			self:_progress("daily_heirloom", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_helicopter",
		name_id = "daily_helicopter",
		desc_id = "daily_helicopter_desc",
		objective_id = "daily_helicopter_objective",
		objectives = {
			self:_progress("daily_helicopter", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_sewers",
		name_id = "daily_sewers",
		desc_id = "daily_sewers_desc",
		objective_id = "daily_sewers_objective",
		objectives = {
			self:_progress("daily_sewers", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_night_out",
		name_id = "daily_night_out",
		desc_id = "daily_night_out_desc",
		objective_id = "daily_night_out_objective",
		objectives = {
			self:_progress("daily_night_out", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_secret_identity",
		name_id = "daily_secret_identity",
		desc_id = "daily_secret_identity_desc",
		objective_id = "daily_secret_identity_objective",
		objectives = {
			self:_progress("daily_secret_identity", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_lodsofemone",
		name_id = "daily_lodsofemone",
		desc_id = "daily_lodsofemone_desc",
		objective_id = "daily_lodsofemone_objective",
		objectives = {
			self:_progress("daily_lodsofemone", 20, {
				name_id = "daily_lodsofemone_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_hangover",
		name_id = "daily_hangover",
		desc_id = "daily_hangover_desc",
		objective_id = "daily_hangover_objective",
		objectives = {
			self:_progress("daily_hangover", 25, {
				name_id = "daily_hangover_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_rush",
		name_id = "daily_rush",
		desc_id = "daily_rush_desc",
		objective_id = "daily_rush_objective",
		objectives = {
			self:_progress("daily_rush", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_naked",
		name_id = "daily_naked",
		desc_id = "daily_naked_desc",
		objective_id = "daily_naked_objective",
		objectives = {
			self:_progress("daily_naked", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_honorable",
		name_id = "daily_honorable",
		desc_id = "daily_honorable_desc",
		objective_id = "daily_honorable_objective",
		objectives = {
			self:_progress("daily_honorable", 10, {
				name_id = "daily_honorable_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_ninja",
		name_id = "daily_ninja",
		desc_id = "daily_ninja_desc",
		objective_id = "daily_ninja_objective",
		objectives = {
			self:_progress("daily_ninja", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_cake",
		name_id = "daily_cake",
		desc_id = "daily_cake_desc",
		objective_id = "daily_cake_objective",
		objectives = {
			self:_progress("daily_cake", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_my_bodhi_is_ready",
		name_id = "daily_my_bodhi_is_ready",
		desc_id = "daily_my_bodhi_is_ready_desc",
		objective_id = "daily_my_bodhi_is_ready_objective",
		objectives = {
			self:_progress("corpse_dispose", 10, {
				name_id = "daily_my_bodhi_is_ready_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_tasty",
		name_id = "daily_tasty",
		desc_id = "daily_tasty_desc",
		objective_id = "daily_tasty_objective",
		objectives = {
			self:_progress("daily_tasty", 20, {
				name_id = "daily_tasty_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_candy",
		name_id = "daily_candy",
		desc_id = "daily_candy_desc",
		objective_id = "daily_candy_objective",
		objectives = {
			self:_progress("daily_candy", 10, {
				name_id = "daily_candy_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_dosh",
		name_id = "daily_dosh",
		desc_id = "daily_dosh_desc",
		objective_id = "daily_dosh_objective",
		objectives = {
			self:_achievement("pal_2")
		}
	})
	table.insert(self.dailies, {
		id = "daily_snake",
		name_id = "daily_snake",
		desc_id = "daily_snake_desc",
		objective_id = "daily_snake_objective",
		objectives = {
			self:_progress("gmod_5_stats", 10, {
				name_id = "daily_snake_progress"
			})
		},
		show_progress = true
	})
	table.insert(self.dailies, {
		id = "daily_coke_run",
		name_id = "daily_coke_run",
		desc_id = "daily_coke_run_desc",
		objective_id = "daily_coke_run_objective",
		objectives = {
			self:_progress("daily_coke_run", 1)
		}
	})
	table.insert(self.dailies, {
		id = "daily_whats_stealth",
		name_id = "daily_whats_stealth",
		desc_id = "daily_whats_stealth_desc",
		objective_id = "daily_whats_stealth_objective",
		objectives = {
			self:_progress("daily_whats_stealth", 1)
		}
	})
end

function CustomSafehouseTweakData:get_daily_data(id)
	for idx, daily in ipairs(self.dailies) do
		if daily.id == id then
			return daily
		end
	end
end

function CustomSafehouseTweakData:_init_map(tweak_data)
	self.map = {}
	self.map.size = 2000
	self.map.frame_texture = {
		"guis/dlcs/chill/textures/pd2/character_icon/safehouse_character_lvl_indicator1",
		"guis/dlcs/chill/textures/pd2/character_icon/safehouse_character_lvl_indicator2",
		"guis/dlcs/chill/textures/pd2/character_icon/safehouse_character_lvl_indicator3"
	}
	self.map.rooms = {}
	self.map.floors = {}
	table.insert(self.map.floors, {
		texture = "guis/dlcs/chill/textures/pd2/safehouse/chill_map_top_floor",
		name_id = "menu_cs_top_floor",
		desc_id = "menu_cs_top_floor_desc",
		min_zoom = 1,
		start_zoom = 1.2,
		shape = {
			0.4,
			0.22,
			0.88,
			0.56
		},
		controller_shape = {
			0.4,
			0.22,
			0.88,
			0.61
		},
		alpha_limit = 0.05,
		rooms = {
			"old_hoxton",
			"russian",
			"clover"
		}
	})
	table.insert(self.map.floors, {
		texture = "guis/dlcs/chill/textures/pd2/safehouse/chill_map_ground_floor",
		name_id = "menu_cs_ground_floor",
		desc_id = "menu_cs_ground_floor_desc",
		min_zoom = 0.8,
		start_zoom = 1,
		shape = {
			0.29,
			0.21,
			0.88,
			0.63
		},
		controller_shape = {
			0.29,
			0.16,
			0.93,
			0.73
		},
		alpha_limit = 0.05,
		rooms = {
			"bonnie",
			"dragon",
			"jimmy",
			"spanish",
			"american",
			"sydney",
			"wild",
			"livingroom"
		}
	})
	table.insert(self.map.floors, {
		texture = "guis/dlcs/chill/textures/pd2/safehouse/chill_map_basement",
		name_id = "menu_cs_basement",
		desc_id = "menu_cs_basement_desc",
		min_zoom = 0.6,
		start_zoom = 0.8,
		shape = {
			0.19,
			0.19,
			0.9,
			0.63
		},
		controller_shape = {
			0.14,
			0.09,
			1,
			0.78
		},
		alpha_limit = 0.03,
		rooms = {
			"dragan",
			"german",
			"sokol",
			"bodhi",
			"vault",
			"jacket",
			"jowi"
		}
	})
	self.map.rooms.dragan = {
		x = 1150,
		y = 730,
		icon = "safehouse_character_icon_dragan"
	}
	self.map.rooms.german = {
		x = 1237,
		y = 1108,
		icon = "safehouse_character_icon_wolf"
	}
	self.map.rooms.sokol = {
		x = 1260,
		y = 690,
		icon = "safehouse_character_icon_sokol"
	}
	self.map.rooms.bodhi = {
		x = 1300,
		y = 550,
		icon = "safehouse_character_icon_bodhi"
	}
	self.map.rooms.vault = {
		x = 902,
		y = 653,
		icon = "safehouse_character_icon_vault"
	}
	self.map.rooms.jacket = {
		x = 1402,
		y = 660,
		icon = "safehouse_character_icon_jacket"
	}
	self.map.rooms.jowi = {
		x = 1045,
		y = 1108,
		icon = "safehouse_character_icon_wick"
	}
	self.map.rooms.bonnie = {
		x = 1320,
		y = 815,
		icon = "safehouse_character_icon_bonnie"
	}
	self.map.rooms.dragon = {
		x = 1400,
		y = 803,
		icon = "safehouse_character_icon_jiro"
	}
	self.map.rooms.jimmy = {
		x = 1380,
		y = 910,
		icon = "safehouse_character_icon_jimmy"
	}
	self.map.rooms.spanish = {
		x = 1205,
		y = 1108,
		icon = "safehouse_character_icon_chains"
	}
	self.map.rooms.american = {
		x = 1160,
		y = 640,
		icon = "safehouse_character_icon_houston"
	}
	self.map.rooms.sydney = {
		x = 1240,
		y = 640,
		icon = "safehouse_character_icon_sydney"
	}
	self.map.rooms.wild = {
		x = 1240,
		y = 750,
		icon = "safehouse_character_icon_rust"
	}
	self.map.rooms.livingroom = {
		x = 1140,
		y = 830,
		icon = "safehouse_character_icon_livingroom"
	}
	self.map.rooms.old_hoxton = {
		x = 1290,
		y = 850,
		icon = "safehouse_character_icon_reborn"
	}
	self.map.rooms.russian = {
		x = 1353,
		y = 810,
		icon = "safehouse_character_icon_dallas"
	}
	self.map.rooms.clover = {
		x = 1350,
		y = 900,
		icon = "safehouse_character_icon_clover"
	}
end
