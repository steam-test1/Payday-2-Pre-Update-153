NarrativeTweakData = NarrativeTweakData or class()

function NarrativeTweakData:init()
	self.STARS = {}
	self.STARS[1] = {
		jcs = {
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[2] = {
		jcs = {
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[3] = {
		jcs = {
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[4] = {
		jcs = {
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[5] = {
		jcs = {
			100,
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[6] = {
		jcs = {
			100,
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[7] = {
		jcs = {
			100,
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[8] = {
		jcs = {
			100,
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[9] = {
		jcs = {
			100,
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS[10] = {
		jcs = {
			100,
			90,
			80,
			70,
			60,
			50,
			40,
			30,
			20,
			10
		}
	}
	self.STARS_CURVES = {
		1.6,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.4,
		1.3,
		1.2
	}
	self.JC_CHANCE = 0.01
	self.JC_PICKS = 35
	self.CONTRACT_COOLDOWN_TIME = 300
	self.contacts = {}
	self.contacts.dallas = {}
	self.contacts.dallas.name_id = "heist_contact_dallas"
	self.contacts.dallas.description_id = "heist_contact_dallas_description"
	self.contacts.dallas.image = "guis/textures/pd2/crimenet_portrait_dallas"
	self.contacts.dallas.package = "packages/contact_dallas"
	self.contacts.dallas.assets_gui = Idstring("guis/mission_briefing/preload_contact_dallas")
	self.contacts.vlad = {}
	self.contacts.vlad.name_id = "heist_contact_vlad"
	self.contacts.vlad.description_id = "heist_contact_vlad_description"
	self.contacts.vlad.image = "guis/textures/pd2/crimenet_portrait_vlad"
	self.contacts.vlad.package = "packages/contact_vlad"
	self.contacts.vlad.assets_gui = Idstring("guis/mission_briefing/preload_contact_vlad")
	self.contacts.hector = {}
	self.contacts.hector.name_id = "heist_contact_hector"
	self.contacts.hector.description_id = "heist_contact_hector_description"
	self.contacts.hector.image = "guis/textures/pd2/crimenet_portrait_hector"
	self.contacts.hector.package = "packages/contact_hector"
	self.contacts.hector.assets_gui = Idstring("guis/mission_briefing/preload_contact_hector")
	self.contacts.the_elephant = {}
	self.contacts.the_elephant.name_id = "heist_contact_the_elephant"
	self.contacts.the_elephant.description_id = "heist_contact_the_elephant_description"
	self.contacts.the_elephant.image = "guis/textures/pd2/crimenet_portrait_the_elephant"
	self.contacts.the_elephant.package = "packages/contact_the_elephant"
	self.contacts.the_elephant.assets_gui = Idstring("guis/mission_briefing/preload_contact_the_elephant")
	self.contacts.bain = {}
	self.contacts.bain.name_id = "heist_contact_bain"
	self.contacts.bain.description_id = "heist_contact_bain_description"
	self.contacts.bain.image = "guis/textures/pd2/crimenet_portrait_vlad"
	self.contacts.bain.package = "packages/contact_bain"
	self.contacts.bain.assets_gui = Idstring("guis/mission_briefing/preload_contact_bain")
	self.contacts.interupt = {}
	self.contacts.interupt.name_id = "heist_contact_interupt"
	self.contacts.interupt.description_id = "heist_contact_interupt_description"
	self.contacts.interupt.image = "guis/textures/pd2/crimenet_portrait_vlad"
	self.contacts.interupt.package = "packages/contact_interupt"
	self.contacts.interupt.assets_gui = Idstring("guis/mission_briefing/preload_contact_interupt")
	self.jobs = {}
	self.jobs.firestarter = {}
	self.jobs.firestarter.name_id = "heist_firestarter"
	self.jobs.firestarter.briefing_id = "heist_firestarter_crimenet"
	self.jobs.firestarter.contact = "hector"
	self.jobs.firestarter.jc = 50
	self.jobs.firestarter.chain = {
		{
			level_id = "firestarter_1",
			type_id = "heist_type_hijack",
			type = "d"
		},
		{
			level_id = "firestarter_2",
			type_id = "heist_type_stealth",
			type = "d"
		},
		{
			level_id = "firestarter_3",
			type_id = "heist_type_knockover",
			type = "d",
			mission = "default",
			mission_filter = {5}
		}
	}
	self.jobs.firestarter.briefing_event = "hct_firestarter_brf"
	self.jobs.firestarter.debrief_event = "hct_firestarter_debrief"
	self.jobs.firestarter.crimenet_callouts = {
		"hct_firestarter_cnc_01",
		"hct_firestarter_cnc_02",
		"hct_firestarter_cnc_03"
	}
	self.jobs.firestarter.crimenet_videos = {
		"cn_fires1",
		"cn_fires2",
		"cn_fires3"
	}
	self.jobs.firestarter_prof = deep_clone(self.jobs.firestarter)
	self.jobs.firestarter_prof.jc = 70
	self.jobs.firestarter_prof.professional = true
	self.jobs.firestarter_prof.region = "professional"
	self.jobs.alex = {}
	self.jobs.alex.name_id = "heist_alex"
	self.jobs.alex.briefing_id = "heist_alex_crimenet"
	self.jobs.alex.contact = "hector"
	self.jobs.alex.jc = 50
	self.jobs.alex.chain = {
		{
			level_id = "alex_1",
			type_id = "heist_type_survive",
			type = "d"
		},
		{
			level_id = "alex_2",
			type_id = "heist_type_survive",
			type = "d"
		},
		{
			level_id = "alex_3",
			type_id = "heist_type_assault",
			type = "d"
		}
	}
	self.jobs.alex.briefing_event = "hct_rats_brf_speak"
	self.jobs.alex.debrief_event = "hct_rats_debrief"
	self.jobs.alex.crimenet_callouts = {
		"hct_rats_cnc_01",
		"hct_rats_cnc_02",
		"hct_rats_cnc_03"
	}
	self.jobs.alex.crimenet_videos = {
		"cn_rat1",
		"cn_rat2",
		"cn_rat3"
	}
	self.jobs.alex_prof = deep_clone(self.jobs.alex)
	self.jobs.alex_prof.jc = 70
	self.jobs.alex_prof.professional = true
	self.jobs.alex_prof.region = "professional"
	self.jobs.welcome_to_the_jungle = {}
	self.jobs.welcome_to_the_jungle.name_id = "heist_welcome_to_the_jungle"
	self.jobs.welcome_to_the_jungle.briefing_id = "heist_welcome_to_the_jungle_crimenet"
	self.jobs.welcome_to_the_jungle.contact = "the_elephant"
	self.jobs.welcome_to_the_jungle.jc = 50
	self.jobs.welcome_to_the_jungle.chain = {
		{
			level_id = "welcome_to_the_jungle_1",
			type_id = "heist_type_assault",
			type = "e",
			mission_filter = {1}
		},
		{
			level_id = "welcome_to_the_jungle_2",
			type_id = "heist_type_stealth",
			type = "e",
			mission_filter = {1}
		}
	}
	self.jobs.welcome_to_the_jungle.briefing_event = "elp_bigoil_brf"
	self.jobs.welcome_to_the_jungle.debrief_event = "elp_bigoil_debrief"
	self.jobs.welcome_to_the_jungle.crimenet_callouts = {
		"elp_bigoil_cnc_01",
		"elp_bigoil_cnc_02",
		"elp_bigoil_cnc_03"
	}
	self.jobs.welcome_to_the_jungle.crimenet_videos = {
		"cn_bigoil1",
		"cn_bigoil2",
		"cn_bigoil3"
	}
	self.jobs.welcome_to_the_jungle_prof = deep_clone(self.jobs.welcome_to_the_jungle)
	self.jobs.welcome_to_the_jungle_prof.jc = 70
	self.jobs.welcome_to_the_jungle_prof.professional = true
	self.jobs.welcome_to_the_jungle_prof.region = "professional"
	self.jobs.framing_frame = {}
	self.jobs.framing_frame.name_id = "heist_framing_frame"
	self.jobs.framing_frame.briefing_id = "heist_framing_frame_crimenet"
	self.jobs.framing_frame.contact = "the_elephant"
	self.jobs.framing_frame.jc = 40
	self.jobs.framing_frame.chain = {
		{
			level_id = "framing_frame_1",
			type_id = "heist_type_knockover",
			type = "e",
			mission_filter = {1}
		},
		{
			level_id = "framing_frame_2",
			type_id = "heist_type_trade",
			type = "e",
			mission_filter = {1}
		},
		{
			level_id = "framing_frame_3",
			type_id = "heist_type_stealth",
			type = "e",
			mission_filter = {1}
		}
	}
	self.jobs.framing_frame.briefing_event = "elp_framing_brf"
	self.jobs.framing_frame.debrief_event = "elp_framing_debrief"
	self.jobs.framing_frame.crimenet_callouts = {
		"elp_framing_cmc_01",
		"elp_framing_cmc_02",
		"elp_framing_cmc_03"
	}
	self.jobs.framing_frame.crimenet_videos = {
		"cn_framingframe1",
		"cn_framingframe2",
		"cn_framingframe3"
	}
	self.jobs.framing_frame_prof = deep_clone(self.jobs.framing_frame)
	self.jobs.framing_frame_prof.jc = 60
	self.jobs.framing_frame_prof.professional = true
	self.jobs.framing_frame_prof.region = "professional"
	self.jobs.watchdogs = {}
	self.jobs.watchdogs.name_id = "heist_watchdogs"
	self.jobs.watchdogs.briefing_id = "heist_watchdogs_crimenet"
	self.jobs.watchdogs.contact = "hector"
	self.jobs.watchdogs.region = "dock"
	self.jobs.watchdogs.jc = 40
	self.jobs.watchdogs.chain = {
		{
			level_id = "watchdogs_1",
			type_id = "heist_type_survive",
			type = "d"
		},
		{
			level_id = "watchdogs_2",
			type_id = "heist_type_survive",
			type = "d"
		}
	}
	self.jobs.watchdogs.briefing_event = "hct_watchdogs_brf_speak"
	self.jobs.watchdogs.debrief_event = "hct_watchdogs_debrief"
	self.jobs.watchdogs.crimenet_callouts = {
		"hct_watchdogs_cnc_01",
		"hct_watchdogs_cnc_02",
		"hct_watchdogs_cnc_03"
	}
	self.jobs.watchdogs.crimenet_videos = {
		"cn_watchdog1",
		"cn_watchdog2",
		"cn_watchdog3"
	}
	self.jobs.watchdogs_prof = deep_clone(self.jobs.watchdogs)
	self.jobs.watchdogs_prof.jc = 60
	self.jobs.watchdogs_prof.professional = true
	self.jobs.nightclub = {}
	self.jobs.nightclub.name_id = "heist_nightclub"
	self.jobs.nightclub.briefing_id = "heist_nightclub_crimenet"
	self.jobs.nightclub.region = "street"
	self.jobs.nightclub.contact = "vlad"
	self.jobs.nightclub.jc = 30
	self.jobs.nightclub.chain = {
		{
			level_id = "nightclub",
			type_id = "heist_type_assault",
			type = "d"
		}
	}
	self.jobs.nightclub.briefing_event = "vld_nightclub_brf"
	self.jobs.nightclub.debrief_event = "vld_nightclub_debrief"
	self.jobs.nightclub.crimenet_callouts = {
		"vld_nightclub_cnc_01",
		"vld_nightclub_cnc_02",
		"vld_nightclub_cnc_03"
	}
	self.jobs.nightclub.crimenet_videos = {
		"cn_nightc1",
		"cn_nightc2",
		"cn_nightc3"
	}
	self.jobs.nightclub_prof = deep_clone(self.jobs.nightclub)
	self.jobs.nightclub_prof.jc = 40
	self.jobs.nightclub_prof.professional = true
	self.jobs.nightclub_prof.region = "professional"
	self.jobs.ukrainian_job = {}
	self.jobs.ukrainian_job.name_id = "heist_ukrainian_job"
	self.jobs.ukrainian_job.briefing_id = "heist_ukrainian_job_crimenet"
	self.jobs.ukrainian_job.contact = "vlad"
	self.jobs.ukrainian_job.region = "street"
	self.jobs.ukrainian_job.jc = 30
	self.jobs.ukrainian_job.chain = {
		{
			level_id = "ukrainian_job",
			type_id = "heist_type_assault",
			type = "d"
		}
	}
	self.jobs.ukrainian_job.briefing_event = "vld_ukranian_brf"
	self.jobs.ukrainian_job.debrief_event = "vld_ukranian_debrief"
	self.jobs.ukrainian_job.crimenet_callouts = {
		"vld_ukranian_cnc_01",
		"vld_ukranian_cnc_02",
		"vld_ukranian_cnc_03",
		"vld_ukranian_cnc_04"
	}
	self.jobs.ukrainian_job.crimenet_videos = {
		"cn_ukr1",
		"cn_ukr2",
		"cn_ukr3"
	}
	self.jobs.ukrainian_job_prof = deep_clone(self.jobs.ukrainian_job)
	self.jobs.ukrainian_job_prof.jc = 30
	self.jobs.ukrainian_job_prof.professional = true
	self.jobs.ukrainian_job_prof.region = "professional"
	self.jobs.jewelry_store = {}
	self.jobs.jewelry_store.name_id = "heist_jewelry_store"
	self.jobs.jewelry_store.briefing_id = "heist_jewelry_store_crimenet"
	self.jobs.jewelry_store.contact = "bain"
	self.jobs.jewelry_store.region = "street"
	self.jobs.jewelry_store.jc = 10
	self.jobs.jewelry_store.chain = {
		{
			level_id = "jewelry_store",
			type_id = "heist_type_assault",
			type = "d"
		}
	}
	self.jobs.jewelry_store.briefing_event = "pln_jewelrystore_stage1_brf_speak"
	self.jobs.jewelry_store.debrief_event = nil
	self.jobs.jewelry_store.crimenet_callouts = {
		"pln_jewelrystore_stage1_cnc_01",
		"pln_jewelrystore_stage1_cnc_02",
		"pln_jewelrystore_stage1_cnc_03"
	}
	self.jobs.jewelry_store.crimenet_videos = {
		"cn_jewel1",
		"cn_jewel2",
		"cn_jewel3"
	}
	self.jobs.jewelry_store_prof = deep_clone(self.jobs.jewelry_store)
	self.jobs.jewelry_store_prof.jc = 20
	self.jobs.jewelry_store_prof.professional = true
	self.jobs.jewelry_store_prof.region = "professional"
	self.jobs.four_stores = {}
	self.jobs.four_stores.name_id = "heist_four_stores"
	self.jobs.four_stores.briefing_id = "heist_four_stores_crimenet"
	self.jobs.four_stores.contact = "vlad"
	self.jobs.four_stores.region = "street"
	self.jobs.four_stores.jc = 10
	self.jobs.four_stores.chain = {
		{
			level_id = "four_stores",
			type_id = "heist_type_assault",
			type = "d"
		}
	}
	self.jobs.four_stores.briefing_event = "vld_fourstores_brf"
	self.jobs.four_stores.debrief_event = "vld_fourstores_debrief"
	self.jobs.four_stores.crimenet_callouts = {
		"vld_fourstores_cnc_01",
		"vld_fourstores_cnc_02",
		"vld_fourstores_cnc_03"
	}
	self.jobs.four_stores.crimenet_videos = {
		"cn_fours1",
		"cn_fours2",
		"cn_fours3"
	}
	self.jobs.four_stores_prof = deep_clone(self.jobs.four_stores)
	self.jobs.four_stores_prof.jc = 20
	self.jobs.four_stores_prof.professional = true
	self.jobs.four_stores_prof.region = "professional"
	self.jobs.mallcrasher = {}
	self.jobs.mallcrasher.name_id = "heist_mallcrasher"
	self.jobs.mallcrasher.briefing_id = "heist_mallcrasher_crimenet"
	self.jobs.mallcrasher.contact = "vlad"
	self.jobs.mallcrasher.region = "street"
	self.jobs.mallcrasher.jc = 20
	self.jobs.mallcrasher.chain = {
		{
			level_id = "mallcrasher",
			type_id = "heist_type_assault",
			type = "d"
		}
	}
	self.jobs.mallcrasher.briefing_event = "vld_mallcrashers_brf"
	self.jobs.mallcrasher.debrief_event = "vld_mallcrashers_debrief"
	self.jobs.mallcrasher.crimenet_callouts = {
		"vld_mallcrashers_cnc_01",
		"vld_mallcrashers_cnc_02",
		"vld_mallcrashers_cnc_03"
	}
	self.jobs.mallcrasher.crimenet_videos = {
		"cn_mallcrash1",
		"cn_mallcrash2",
		"cn_mallcrash3"
	}
	self.jobs.mallcrasher_prof = deep_clone(self.jobs.mallcrasher)
	self.jobs.mallcrasher_prof.jc = 30
	self.jobs.mallcrasher_prof.professional = true
	self.jobs.mallcrasher_prof.region = "professional"
	self.jobs.branchbank = {}
	self.jobs.branchbank.name_id = "heist_branchbank"
	self.jobs.branchbank.briefing_id = "heist_branchbank_crimenet"
	self.jobs.branchbank.contact = "bain"
	self.jobs.branchbank.region = "street"
	self.jobs.branchbank.jc = 40
	self.jobs.branchbank.chain = {
		{
			level_id = "branchbank",
			type_id = "heist_type_assault",
			type = "d",
			mission = "standalone",
			mission_filter = {4},
			briefing_dialog = nil
		}
	}
	self.jobs.branchbank.briefing_event = "pln_branchbank_random_brf_speak"
	self.jobs.branchbank.debrief_event = nil
	self.jobs.branchbank.crimenet_callouts = {
		"pln_branchbank_random_cnc_01",
		"pln_branchbank_random_cnc_02",
		"pln_branchbank_random_cnc_03",
		"pln_branchbank_random_cnc_04",
		"pln_branchbank_random_cnc_05",
		"pln_branchbank_random_cnc_06"
	}
	self.jobs.branchbank.crimenet_videos = {
		"cn_branchbank1",
		"cn_branchbank2",
		"cn_branchbank3"
	}
	self.jobs.branchbank_prof = deep_clone(self.jobs.branchbank)
	self.jobs.branchbank_prof.jc = 40
	self.jobs.branchbank_prof.professional = true
	self.jobs.branchbank_prof.region = "professional"
	self.jobs.branchbank_deposit = {}
	self.jobs.branchbank_deposit.name_id = "heist_branchbank_deposit"
	self.jobs.branchbank_deposit.briefing_id = "heist_branchbank_deposit_crimenet"
	self.jobs.branchbank_deposit.contact = "bain"
	self.jobs.branchbank_deposit.region = "street"
	self.jobs.branchbank_deposit.jc = 30
	self.jobs.branchbank_deposit.chain = {
		{
			level_id = "branchbank",
			type_id = "heist_type_assault",
			type = "d",
			mission = "standalone",
			mission_filter = {1},
			briefing_dialog = "Play_pln_branchbank_depositbox_stage1_brief",
			briefing_id = "heist_branchbank_deposit_briefing"
		}
	}
	self.jobs.branchbank_deposit.briefing_event = "pln_branchbank_depositbox_brf_speak"
	self.jobs.branchbank_deposit.debrief_event = nil
	self.jobs.branchbank_deposit.crimenet_callouts = {
		"pln_branchbank_deposit_cnc_01",
		"pln_branchbank_deposit_cnc_02",
		"pln_branchbank_deposit_cnc_03",
		"pln_branchbank_deposit_cnc_04",
		"pln_branchbank_deposit_cnc_05",
		"pln_branchbank_deposit_cnc_06"
	}
	self.jobs.branchbank_deposit.crimenet_videos = {
		"cn_branchbank1",
		"cn_branchbank2",
		"cn_branchbank3"
	}
	self.jobs.branchbank_deposit_prof = deep_clone(self.jobs.branchbank_deposit)
	self.jobs.branchbank_deposit_prof.jc = 40
	self.jobs.branchbank_deposit_prof.professional = true
	self.jobs.branchbank_deposit_prof.region = "professional"
	self.jobs.branchbank_cash = {}
	self.jobs.branchbank_cash.name_id = "heist_branchbank_cash"
	self.jobs.branchbank_cash.briefing_id = "heist_branchbank_cash_crimenet"
	self.jobs.branchbank_cash.contact = "bain"
	self.jobs.branchbank_cash.region = "street"
	self.jobs.branchbank_cash.jc = 30
	self.jobs.branchbank_cash.chain = {
		{
			level_id = "branchbank",
			type_id = "heist_type_assault",
			type = "d",
			mission = "standalone",
			mission_filter = {2},
			briefing_dialog = "Play_pln_branchbank_cash_stage1_brief",
			briefing_id = "heist_branchbank_cash_briefing"
		}
	}
	self.jobs.branchbank_cash.briefing_event = "pln_branchbank_cash_brf_speak"
	self.jobs.branchbank_cash.debrief_event = nil
	self.jobs.branchbank_cash.crimenet_callouts = {
		"pln_branchbank_cash_cnc_01",
		"pln_branchbank_cash_cnc_02",
		"pln_branchbank_cash_cnc_03",
		"pln_branchbank_cash_cnc_04",
		"pln_branchbank_cash_cnc_05",
		"pln_branchbank_cash_cnc_06",
		"pln_branchbank_cash_cnc_07"
	}
	self.jobs.branchbank_cash.crimenet_videos = {
		"cn_branchbank1",
		"cn_branchbank2",
		"cn_branchbank3"
	}
	self.jobs.branchbank_cash_prof = deep_clone(self.jobs.branchbank_cash)
	self.jobs.branchbank_cash_prof.jc = 40
	self.jobs.branchbank_cash_prof.professional = true
	self.jobs.branchbank_cash_prof.region = "professional"
	self.jobs.branchbank_gold = {}
	self.jobs.branchbank_gold.name_id = "heist_branchbank_gold"
	self.jobs.branchbank_gold.briefing_id = "heist_branchbank_gold_crimenet"
	self.jobs.branchbank_gold.contact = "bain"
	self.jobs.branchbank_gold.region = "street"
	self.jobs.branchbank_gold.jc = 30
	self.jobs.branchbank_gold.chain = {
		{
			level_id = "branchbank",
			type_id = "heist_type_assault",
			type = "d",
			mission = "standalone",
			mission_filter = {3},
			briefing_dialog = "Play_pln_branchbank_gold_stage1_brief",
			briefing_id = "heist_branchbank_gold_briefing"
		}
	}
	self.jobs.branchbank_gold.briefing_event = "pln_branchbank_gold_brf_speak"
	self.jobs.branchbank_gold.debrief_event = nil
	self.jobs.branchbank_gold.crimenet_callouts = {
		"pln_branchbank_gold_cnc_01",
		"pln_branchbank_gold_cnc_02",
		"pln_branchbank_gold_cnc_03",
		"pln_branchbank_gold_cnc_04",
		"pln_branchbank_gold_cnc_05",
		"pln_branchbank_gold_cnc_06",
		"pln_branchbank_gold_cnc_07"
	}
	self.jobs.branchbank_gold.crimenet_videos = {
		"cn_branchbank1",
		"cn_branchbank2",
		"cn_branchbank3"
	}
	self.jobs.branchbank_gold_prof = deep_clone(self.jobs.branchbank_gold)
	self.jobs.branchbank_gold_prof.jc = 30
	self.jobs.branchbank_gold_prof.professional = true
	self.jobs.branchbank_gold_prof.region = "professional"
	self.jobs.election_day = {}
	self.jobs.election_day.name_id = "heist_election_day"
	self.jobs.election_day.briefing_id = "heist_election_day_crimenet"
	self.jobs.election_day.contact = "the_elephant"
	self.jobs.election_day.jc = 50
	self.jobs.election_day.chain = {
		{
			level_id = "election_day_1",
			type_id = "heist_type_assault",
			type = "e",
			mission_filter = {1}
		},
		{
			{
				level_id = "election_day_2",
				type_id = "heist_type_assault",
				type = "e",
				mission_filter = {1}
			},
			{
				level_id = "election_day_3",
				type_id = "heist_type_knockover",
				type = "e",
				mission_filter = {1}
			}
		}
	}
	self.jobs.election_day.briefing_event = "elp_election_brf"
	self.jobs.election_day.debrief_event = "elp_election_debrief"
	self.jobs.election_day.crimenet_callouts = {
		"elp_election_cmc_01",
		"elp_election_cmc_02",
		"elp_election_cmc_03"
	}
	self.jobs.election_day.crimenet_videos = {
		"cn_elcday1",
		"cn_elcday2",
		"cn_elcday3"
	}
	self.jobs.election_day_prof = deep_clone(self.jobs.election_day)
	self.jobs.election_day_prof.jc = 60
	self.jobs.election_day_prof.professional = true
	self.jobs.election_day_prof.region = "professional"
	self.jobs.safehouse = {}
	self.jobs.safehouse.name_id = "heist_safehouse"
	self.jobs.safehouse.briefing_id = "heist_safehouse_crimenet"
	self.jobs.safehouse.contact = "bain"
	self.jobs.safehouse.jc = 5
	self.jobs.safehouse.chain = {
		{
			level_id = "safehouse",
			type_id = "heist_type_assault",
			type = "d",
			briefing_id = Global.mission_manager and Global.mission_manager.saved_job_values.playedSafeHouseBefore and "heist_safehouse_briefing_2" or nil
		}
	}
	self.jobs.safehouse.briefing_event = nil
	self.jobs.safehouse.debrief_event = nil
	self.jobs.safehouse.crimenet_callouts = {}
	self.jobs.escape_chain_test = {}
	self.jobs.escape_chain_test.name_id = "heist_escape_chain_test"
	self.jobs.escape_chain_test.briefing_id = "heist_escape_chain_test_briefing"
	self.jobs.escape_chain_test.contact = "hector"
	self.jobs.escape_chain_test.jc = 20
	self.jobs.escape_chain_test.chain = {
		{
			level_id = "escape_chain_test_1",
			type_id = "heist_type_survive",
			type = "d"
		},
		{
			level_id = "escape_chain_test_2",
			type_id = "heist_type_survive",
			type = "d"
		}
	}
	self.jobs.escape_chain_test.briefing_event = nil
	self.jobs.escape_chain_test.debrief_event = nil
	self.jobs.escape_chain_test.crimenet_callouts = {}
	self.jobs.escape_chain_test_prof = deep_clone(self.jobs.escape_chain_test)
	self.jobs.escape_chain_test_prof.jc = 50
	self.jobs.escape_chain_test_prof.professional = true
	self._jobs_index = {
		"welcome_to_the_jungle_prof",
		"framing_frame",
		"framing_frame_prof",
		"watchdogs",
		"watchdogs_prof",
		"alex",
		"alex_prof",
		"firestarter",
		"firestarter_prof",
		"ukrainian_job_prof",
		"jewelry_store",
		"four_stores",
		"nightclub",
		"mallcrasher",
		"branchbank_deposit",
		"branchbank_cash",
		"branchbank_gold_prof",
		"branchbank_prof"
	}
end

function NarrativeTweakData:get_jobs_index()
	return self._jobs_index
end

function NarrativeTweakData:get_index_from_job_id(job_id)
	for index, entry_name in ipairs(self._jobs_index) do
		if entry_name == job_id then
			return index
		end
	end
	return 0
end

function NarrativeTweakData:get_job_name_from_index(index)
	return self._jobs_index[index]
end
