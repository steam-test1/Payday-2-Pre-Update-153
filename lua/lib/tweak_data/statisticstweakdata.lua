StatisticsTweakData = StatisticsTweakData or class()

function StatisticsTweakData:init()
	self.session = {}
	self.killed = {
		civilian = {
			total = {count = 0, type = "normal"},
			head_shots = {count = 0, type = "normal"},
			session = {count = 0, type = "session"}
		},
		civilian = {count = 0, head_shots = 0},
		security = {count = 0, head_shots = 0},
		cop = {count = 0, head_shots = 0},
		swat = {count = 0, head_shots = 0},
		total = {count = 0, head_shots = 0}
	}
end

function StatisticsTweakData:statistics_specializations()
	return 16
end

function StatisticsTweakData:statistics_table()
	local level_list = {
		"safehouse",
		"jewelry_store",
		"four_stores",
		"nightclub",
		"mallcrasher",
		"ukrainian_job",
		"branchbank",
		"framing_frame_1",
		"framing_frame_2",
		"framing_frame_3",
		"alex_1",
		"alex_2",
		"alex_3",
		"watchdogs_1",
		"watchdogs_2",
		"watchdogs_1_night",
		"watchdogs_2_day",
		"firestarter_1",
		"firestarter_2",
		"firestarter_3",
		"welcome_to_the_jungle_1",
		"welcome_to_the_jungle_1_night",
		"welcome_to_the_jungle_2",
		"escape_cafe_day",
		"escape_park_day",
		"escape_cafe",
		"escape_park",
		"escape_street",
		"escape_overpass",
		"escape_garage",
		"family",
		"arm_cro",
		"arm_und",
		"arm_hcm",
		"arm_par",
		"arm_fac",
		"arm_for",
		"roberts",
		"election_day_1",
		"election_day_2",
		"election_day_3_skip1",
		"election_day_3_skip2",
		"kosugi",
		"big",
		"mia_1",
		"mia_2",
		"hox_1",
		"hox_2",
		"mus",
		"gallery",
		"haunted",
		"pines",
		"crojob2",
		"crojob3",
		"crojob3_night",
		"rat",
		"cage",
		"hox_3",
		"shoutout_raid",
		"arena",
		"kenaz",
		"jolly",
		"red2",
		"dinner",
		"nail",
		"pbr",
		"pbr2",
		"cane",
		"peta",
		"peta2",
		"pal",
		"man",
		"dark",
		"mad",
		"born",
		"chew"
	}
	local job_list = {
		"jewelry_store",
		"four_stores",
		"nightclub",
		"mallcrasher",
		"ukrainian_job_prof",
		"branchbank_deposit",
		"branchbank_cash",
		"branchbank_gold_prof",
		"branchbank_prof",
		"framing_frame",
		"framing_frame_prof",
		"alex",
		"alex_prof",
		"watchdogs",
		"watchdogs_prof",
		"watchdogs_night",
		"watchdogs_night_prof",
		"firestarter",
		"firestarter_prof",
		"welcome_to_the_jungle_prof",
		"welcome_to_the_jungle_night_prof",
		"family",
		"arm_fac",
		"arm_par",
		"arm_hcm",
		"arm_und",
		"arm_cro",
		"roberts",
		"election_day",
		"election_day_prof",
		"kosugi",
		"big",
		"mia",
		"mia_prof",
		"hox",
		"hox_prof",
		"mus",
		"gallery",
		"haunted",
		"pines",
		"crojob1",
		"crojob2",
		"crojob2_night",
		"rat",
		"arm_for",
		"cage",
		"hox_3",
		"shoutout_raid",
		"arena",
		"kenaz",
		"jolly",
		"nail",
		"red2",
		"dinner",
		"pbr",
		"pbr2",
		"cane",
		"peta",
		"peta_prof",
		"pal",
		"man",
		"dark",
		"mad",
		"born",
		"born_pro"
	}
	local mask_list = {
		"character_locked",
		"alienware",
		"babyrhino",
		"biglips",
		"brainiack",
		"buha",
		"bullet",
		"clown_56",
		"clowncry",
		"dawn_of_the_dead",
		"day_of_the_dead",
		"demon",
		"demonictender",
		"dripper",
		"gagball",
		"greek_tragedy",
		"hockey",
		"hog",
		"jaw",
		"monkeybiss",
		"mr_sinister",
		"mummy",
		"oni",
		"outlandish_a",
		"outlandish_b",
		"outlandish_c",
		"scarecrow",
		"shogun",
		"shrunken",
		"skull",
		"stonekisses",
		"tounge",
		"troll",
		"vampire",
		"zipper",
		"zombie",
		"dallas",
		"wolf",
		"chains",
		"hoxton",
		"dallas_clean",
		"wolf_clean",
		"chains_clean",
		"hoxton_clean",
		"anonymous",
		"cthulhu",
		"dillinger_death_mask",
		"grin",
		"kawaii",
		"irondoom",
		"rubber_male",
		"rubber_female",
		"pumpkin_king",
		"witch",
		"venomorph",
		"frank",
		"baby_happy",
		"baby_angry",
		"baby_cry",
		"brazil_baby",
		"heat",
		"bear",
		"clinton",
		"bush",
		"obama",
		"nixon",
		"goat",
		"panda",
		"pitbull",
		"eagle",
		"santa_happy",
		"santa_mad",
		"santa_drunk",
		"santa_surprise",
		"aviator",
		"ghost",
		"welder",
		"plague",
		"smoker",
		"cloth_commander",
		"gage_blade",
		"gage_rambo",
		"gage_deltaforce",
		"robberfly",
		"spider",
		"mantis",
		"wasp",
		"skullhard",
		"skullveryhard",
		"skulloverkill",
		"skulloverkillplus",
		"samurai",
		"twitch_orc",
		"ancient",
		"franklin",
		"lincoln",
		"grant",
		"washington",
		"metalhead",
		"tcn",
		"surprise",
		"optimist_prime",
		"silverback",
		"mandril",
		"skullmonkey",
		"orangutang",
		"unicorn",
		"galax",
		"crowgoblin",
		"evil",
		"volt",
		"white_wolf",
		"owl",
		"rabbit",
		"pig",
		"panther",
		"rooster",
		"horse",
		"tiger",
		"combusto",
		"spackle",
		"stoneface",
		"wayfarer",
		"jw_shades",
		"smiley",
		"gumbo",
		"crazy_lion",
		"old_hoxton",
		"the_one_below",
		"lycan",
		"churchill",
		"red_hurricane",
		"patton",
		"de_gaulle",
		"area51",
		"alien_helmet",
		"krampus",
		"mrs_claus",
		"strinch",
		"robo_santa",
		"almirs_beard",
		"msk_grizel",
		"grizel_clean",
		"medusa",
		"anubis",
		"pazuzu",
		"cursed_crown",
		"nun_town",
		"robo_arnold",
		"arch_nemesis",
		"champion_dallas",
		"dragan",
		"dragan_begins",
		"butcher",
		"doctor",
		"tech_lion",
		"lady_butcher",
		"carnotaurus",
		"triceratops",
		"pachy",
		"velociraptor",
		"the_overkill_mask",
		"dallas_glow",
		"wolf_glow",
		"hoxton_glow",
		"chains_glow",
		"destroyer",
		"punk",
		"pain",
		"infamy_lurker",
		"daft",
		"ranger",
		"infamy_hood",
		"balaclava",
		"jake",
		"richter",
		"biker",
		"alex",
		"corey",
		"tonys_revenge",
		"richard_returns",
		"richard_begins",
		"bonnie",
		"bonnie_begins",
		"simpson",
		"hothead",
		"falcon",
		"unic",
		"speedrunner",
		"hectors_helmet",
		"old_hoxton_begins",
		"firedemon",
		"gasmask",
		"firemask",
		"chef_hat",
		"bandit",
		"bullskull",
		"kangee",
		"lone",
		"grendel",
		"concert_male",
		"concert_female",
		"boombox",
		"cantus",
		"titan",
		"pokachu",
		"moon",
		"borsuk",
		"card_jack",
		"card_queen",
		"card_king",
		"card_joker",
		"sokol",
		"sokol_begins",
		"croupier_hat",
		"gladiator_helmet",
		"the_king_mask",
		"sports_utility_mask",
		"starvr",
		"ninja_hood",
		"shirai",
		"kage",
		"slicer",
		"bobblehead_dozer",
		"jiro",
		"jiro_begins",
		"king_of_jesters",
		"mason_vanguard_veteran",
		"agatha_knight",
		"agatha_vanguard_veteran",
		"mason_knight_veteran",
		"vlad_armor",
		"sputnik",
		"tiara",
		"rus_hat",
		"baba_yaga",
		"lcv",
		"oliver",
		"eggian",
		"fatboy",
		"pirate_skull",
		"glasses_tinted_love",
		"groucho_glasses",
		"rageface",
		"dawg",
		"baitface",
		"nomegusta",
		"satan",
		"invader",
		"tormentor",
		"bodhi",
		"bodhi_begins",
		"oro",
		"water_spirit",
		"maui",
		"tane",
		"rudeolph",
		"greedy_the_elf",
		"goat_goat",
		"fancy_goat",
		"tall_goat",
		"wet_goat",
		"unborn",
		"devourer",
		"divided",
		"viking",
		"nutcracker",
		"horned_king",
		"hunter",
		"megacthulhu",
		"cop_skull",
		"cop_plague_doctor",
		"cop_kawaii",
		"jimmy",
		"jimmy_duct",
		"mad_mask",
		"half_mask",
		"mad_goggles",
		"visor",
		"dbd_slasher",
		"sydney",
		"sydney_begins",
		"born_biker_01",
		"born_biker_02",
		"born_biker_03",
		"brutal",
		"rust",
		"rust_begins",
		"solus",
		"dbd_01",
		"dbd_02",
		"dbd_03",
		"dbd_04",
		"jig_01",
		"jig_02",
		"damned",
		"mig_war",
		"cop_mega_gage_blade",
		"mig_famine",
		"mig_conquest",
		"mig_death",
		"fab_mega_mark",
		"fab_mega_alien",
		"fab_mega_doctor",
		"fab_mega_grin"
	}
	local weapon_list = {
		"ak5",
		"ak74",
		"akm",
		"akmsu",
		"amcar",
		"aug",
		"b92fs",
		"colt_1911",
		"deagle",
		"g22c",
		"g36",
		"glock_17",
		"glock_18c",
		"huntsman",
		"m16",
		"mac10",
		"mp9",
		"new_m14",
		"new_m4",
		"new_mp5",
		"new_raging_bull",
		"olympic",
		"p90",
		"r870",
		"saiga",
		"saw",
		"saw_secondary",
		"serbu",
		"usp",
		"m45",
		"s552",
		"ppk",
		"mp7",
		"scar",
		"p226",
		"akm_gold",
		"hk21",
		"m249",
		"rpk",
		"m95",
		"msr",
		"r93",
		"fal",
		"benelli",
		"striker",
		"ksg",
		"judge",
		"gre_m79",
		"g3",
		"galil",
		"famas",
		"scorpion",
		"tec9",
		"uzi",
		"jowi",
		"x_1911",
		"x_b92fs",
		"x_deagle",
		"g26",
		"spas12",
		"mg42",
		"c96",
		"sterling",
		"mosin",
		"m1928",
		"l85a2",
		"vhs",
		"hs2000",
		"m134",
		"rpg7",
		"cobray",
		"b682",
		"x_g22c",
		"x_g17",
		"x_usp",
		"flamethrower_mk2",
		"m32",
		"aa12",
		"peacemaker",
		"winchester1874",
		"plainsrider",
		"mateba",
		"asval",
		"sub2000",
		"hunter",
		"wa2000",
		"polymer",
		"arblast",
		"long",
		"frankish",
		"baka",
		"par",
		"model70",
		"sparrow",
		"m37",
		"china",
		"sr2",
		"x_sr2",
		"pl14",
		"x_mp5",
		"x_akmsu",
		"tecci",
		"hajk",
		"boot"
	}
	local melee_list = {
		"weapon",
		"fists",
		"kabar",
		"rambo",
		"gerber",
		"kampfmesser",
		"brass_knuckles",
		"tomahawk",
		"baton",
		"shovel",
		"becker",
		"moneybundle",
		"barbedwire",
		"x46",
		"dingdong",
		"bayonet",
		"bullseye",
		"baseballbat",
		"cleaver",
		"fireaxe",
		"machete",
		"briefcase",
		"kabartanto",
		"toothbrush",
		"chef",
		"fairbair",
		"freedom",
		"model24",
		"swagger",
		"alien_maul",
		"shillelagh",
		"boxing_gloves",
		"meat_cleaver",
		"hammer",
		"whiskey",
		"fork",
		"poker",
		"spatula",
		"tenderizer",
		"scalper",
		"mining_pick",
		"branding_iron",
		"bowie",
		"microphone",
		"detector",
		"micstand",
		"oldbaton",
		"hockey",
		"switchblade",
		"taser",
		"slot_lever",
		"croupier_rake",
		"twins",
		"tiger",
		"fight",
		"cqc",
		"sandsteel",
		"buck",
		"beardy",
		"great",
		"morning",
		"gator",
		"pugio",
		"selfie",
		"cutters",
		"boxcutter",
		"iceaxe",
		"stick",
		"pitchfork",
		"scoutknife",
		"shawn",
		"nin",
		"ballistic",
		"zeus",
		"wing",
		"road"
	}
	local grenade_list = {
		"frag",
		"molotov",
		"dynamite",
		"wpn_prj_four",
		"wpn_prj_ace",
		"wpn_prj_jav",
		"frag_com",
		"wpn_prj_hur"
	}
	local enemy_list = {
		"civilian",
		"civilian_female",
		"cop",
		"fbi",
		"fbi_swat",
		"fbi_heavy_swat",
		"swat",
		"heavy_swat",
		"city_swat",
		"security",
		"gensec",
		"gangster",
		"biker_escape",
		"sniper",
		"shield",
		"spooc",
		"tank",
		"taser",
		"mobster",
		"mobster_boss",
		"tank_hw",
		"hector_boss",
		"hector_boss_no_armor",
		"tank_green",
		"tank_black",
		"tank_skull",
		"hostage_rescue",
		"murkywater",
		"phalanx_vip",
		"phalanx_minion",
		"biker",
		"inside_man",
		"bank_manager",
		"cop_scared",
		"biker_boss",
		"cop_female",
		"security_undominatable"
	}
	local armor_list = {
		"level_1",
		"level_2",
		"level_3",
		"level_4",
		"level_5",
		"level_6",
		"level_7"
	}
	local character_list = {
		"russian",
		"german",
		"spanish",
		"american",
		"jowi",
		"old_hoxton",
		"female_1",
		"dragan",
		"jacket",
		"bonnie",
		"sokol",
		"dragon",
		"bodhi",
		"jimmy",
		"sydney",
		"wild"
	}
	local deployable_list = {
		"ammo_bag",
		"doctor_bag",
		"trip_mine",
		"sentry_gun",
		"ecm_jammer",
		"first_aid_kit",
		"bodybags_bag",
		"armor_kit",
		"sentry_gun_silent"
	}
	return level_list, job_list, mask_list, weapon_list, melee_list, grenade_list, enemy_list, armor_list, character_list, deployable_list
end

function StatisticsTweakData:resolution_statistics_table()
	return {
		"2560x1440",
		"1920x1200",
		"1920x1080",
		"1680x1050",
		"1600x900",
		"1536x864",
		"1440x900",
		"1366x768",
		"1360x768",
		"1280x1024",
		"1280x800",
		"1280x720",
		"1024x768"
	}
end

function StatisticsTweakData:mission_statistics_table()
	return {"labrat"}
end
