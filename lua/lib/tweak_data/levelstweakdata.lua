LevelsTweakData = LevelsTweakData or class()

function LevelsTweakData:init()
	self.framing_frame_1 = {}
	self.framing_frame_1.name_id = "heist_framing_frame_1_hl"
	self.framing_frame_1.briefing_id = "heist_framing_frame_1_briefing"
	self.framing_frame_1.briefing_dialog = "Play_pln_framing_stage1_brief"
	self.framing_frame_1.world_name = "narratives/e_framing_frame/stage_1"
	self.framing_frame_1.intro_event = "Play_pln_framing_stage1_intro_a"
	self.framing_frame_1.outro_event = {
		"Play_pln_framing_stage1_end_a",
		"Play_pln_framing_stage1_end_b"
	}
	self.framing_frame_1.music = "heist"
	self.framing_frame_1.package = {
		"packages/narr_framing_1"
	}
	self.framing_frame_1.cube = "cube_apply_heist_bank"
	self.framing_frame_2 = {}
	self.framing_frame_2.name_id = "heist_framing_frame_2_hl"
	self.framing_frame_2.briefing_id = "heist_framing_frame_2_briefing"
	self.framing_frame_2.briefing_dialog = "Play_pln_framing_stage2_brief"
	self.framing_frame_2.world_name = "narratives/e_framing_frame/stage_2"
	self.framing_frame_2.intro_event = "Play_pln_framing_stage2_intro_a"
	self.framing_frame_2.outro_event = {
		"Play_pln_framing_stage2_end_a",
		"Play_pln_framing_stage2_end_b"
	}
	self.framing_frame_2.music = "heist"
	self.framing_frame_2.package = {
		"packages/narr_framing_2"
	}
	self.framing_frame_2.cube = "cube_apply_heist_bank"
	self.framing_frame_3 = {}
	self.framing_frame_3.name_id = "heist_framing_frame_3_hl"
	self.framing_frame_3.briefing_id = "heist_framing_frame_3_briefing"
	self.framing_frame_3.briefing_dialog = "Play_pln_framing_stage3_brief"
	self.framing_frame_3.world_name = "narratives/e_framing_frame/stage_3"
	self.framing_frame_3.intro_event = "Play_pln_framing_stage3_intro"
	self.framing_frame_3.outro_event = {
		"Play_pln_framing_stage3_end_a",
		"Play_pln_framing_stage3_end_b",
		"Play_pln_framing_stage3_end_c"
	}
	self.framing_frame_3.music = "heist"
	self.framing_frame_3.package = "packages/narr_framing_3"
	self.framing_frame_3.cube = "cube_apply_heist_bank"
	self.election_day_1 = {}
	self.election_day_1.name_id = "heist_election_day_1_hl"
	self.election_day_1.briefing_id = "heist_election_day_1_briefing"
	self.election_day_1.briefing_dialog = "Play_pln_election_stage1_brief"
	self.election_day_1.world_name = "narratives/e_election_day/stage_1"
	self.election_day_1.intro_event = "Play_pln_election_stage1_intro_a"
	self.election_day_1.outro_event = {
		"Play_pln_election_stage1_end_a",
		"Play_pln_election_stage1_end_b"
	}
	self.election_day_1.music = "heist"
	self.election_day_1.package = {
		"packages/narr_election1"
	}
	self.election_day_1.cube = "cube_apply_heist_bank"
	self.election_day_2 = {}
	self.election_day_2.name_id = "heist_election_day_2_hl"
	self.election_day_2.briefing_id = "heist_election_day_2_briefing"
	self.election_day_2.briefing_dialog = "Play_pln_election_stage2_brief"
	self.election_day_2.world_name = "narratives/e_election_day/stage_2"
	self.election_day_2.intro_event = "Play_pln_election_stage2_intro_a"
	self.election_day_2.outro_event = {
		"Play_pln_election_stage2_end_a",
		"Play_pln_election_stage2_end_b"
	}
	self.election_day_2.music = "heist"
	self.election_day_2.package = {
		"packages/narr_election2"
	}
	self.election_day_2.cube = "cube_apply_heist_bank"
	self.election_day_3 = {}
	self.election_day_3.name_id = "heist_election_day_3_hl"
	self.election_day_3.briefing_id = "heist_election_day_3_briefing"
	self.election_day_3.briefing_dialog = "Play_pln_election_stage3_brief"
	self.election_day_3.world_name = "narratives/e_election_day/stage_3"
	self.election_day_3.intro_event = "Play_pln_election_stage3_intro_a"
	self.election_day_3.outro_event = {
		"Play_pln_election_stage3_end_a",
		"Play_pln_election_stage3_end_b"
	}
	self.election_day_3.music = "heist"
	self.election_day_3.package = "packages/narr_election3"
	self.election_day_3.cube = "cube_apply_heist_bank"
	self.alex_1 = {}
	self.alex_1.name_id = "heist_alex_1_hl"
	self.alex_1.briefing_id = "heist_alex_1_briefing"
	self.alex_1.briefing_dialog = "Play_pln_rat_stage1_brief"
	self.alex_1.world_name = "narratives/h_alex_must_die/stage_1"
	self.alex_1.intro_event = "Play_pln_rat_stage1_intro_a"
	self.alex_1.outro_event = {
		"Play_pln_rat_stage1_end_a",
		"Play_pln_rat_stage1_end_b",
		"Play_pln_rat_stage1_end_c"
	}
	self.alex_1.music = "heist"
	self.alex_1.package = "packages/narr_alex1"
	self.alex_1.cube = "cube_apply_heist_bank"
	self.alex_2 = {}
	self.alex_2.name_id = "heist_alex_2_hl"
	self.alex_2.briefing_id = "heist_alex_2_briefing"
	self.alex_2.briefing_dialog = "Play_pln_rat_stage2_brief"
	self.alex_2.world_name = "narratives/h_alex_must_die/stage_2"
	self.alex_2.intro_event = "Play_pln_rat_stage2_intro_a"
	self.alex_2.outro_event = {
		"Play_pln_rat_stage2_end_a",
		"Play_pln_rat_stage2_end_b",
		"Play_pln_rat_stage2_end_c",
		"Play_pln_rat_stage2_end_d",
		"Play_pln_rat_stage2_end_e"
	}
	self.alex_2.music = "heist"
	self.alex_2.package = "packages/narr_alex2"
	self.alex_2.cube = "cube_apply_heist_bank"
	self.alex_3 = {}
	self.alex_3.name_id = "heist_alex_3_hl"
	self.alex_3.briefing_id = "heist_alex_3_briefing"
	self.alex_3.briefing_dialog = "Play_pln_rat_stage3_brief"
	self.alex_3.world_name = "narratives/h_alex_must_die/stage_3"
	self.alex_3.intro_event = "Play_pln_rat_stage3_intro_a"
	self.alex_3.outro_event = {
		"Play_pln_rat_stage3_end_a",
		"Play_pln_rat_stage3_end_b",
		"Play_pln_rat_stage3_end_c"
	}
	self.alex_3.music = "heist"
	self.alex_3.package = "packages/narr_alex3"
	self.alex_3.cube = "cube_apply_heist_bank"
	self.watchdogs_1 = {}
	self.watchdogs_1.name_id = "heist_watchdogs_1_hl"
	self.watchdogs_1.briefing_id = "heist_watchdogs_1_briefing"
	self.watchdogs_1.briefing_dialog = "Play_pln_watchdogs_new_stage1_brief"
	self.watchdogs_1.briefing_assets_gui = Idstring("guis/mission_briefing/preload_stage_watchdogs_1")
	self.watchdogs_1.world_name = "narratives/h_watchdogs/stage_1"
	self.watchdogs_1.intro_event = "Play_pln_watchdogs_new_stage1_intro_a"
	self.watchdogs_1.outro_event = {
		"Play_pln_watchdogs_new_stage1_end_a",
		"Play_pln_watchdogs_new_stage1_end_b"
	}
	self.watchdogs_1.music = "heist"
	self.watchdogs_1.package = {
		"packages/narr_watchdogs1"
	}
	self.watchdogs_1.cube = "cube_apply_heist_bank"
	self.watchdogs_2 = {}
	self.watchdogs_2.name_id = "heist_watchdogs_2_hl"
	self.watchdogs_2.briefing_id = "heist_watchdogs_2_briefing"
	self.watchdogs_2.briefing_dialog = "Play_pln_watchdogs_new_stage2_brief"
	self.watchdogs_2.briefing_assets_gui = Idstring("guis/mission_briefing/preload_stage_watchdogs_2")
	self.watchdogs_2.world_name = "narratives/h_watchdogs/stage_2"
	self.watchdogs_2.intro_event = {
		"Play_pln_watchdogs_new_stage2_intro_a",
		"Play_pln_watchdogs_new_stage2_intro_b"
	}
	self.watchdogs_2.outro_event = {
		"Play_pln_watchdogs_new_stage2_end_a",
		"Play_pln_watchdogs_new_stage2_end_b"
	}
	self.watchdogs_2.music = "heist"
	self.watchdogs_2.package = {
		"packages/narr_watchdogs2"
	}
	self.watchdogs_2.cube = "cube_apply_heist_bank"
	self.firestarter_1 = {}
	self.firestarter_1.name_id = "heist_firestarter_1_hl"
	self.firestarter_1.briefing_id = "heist_firestarter_1_briefing"
	self.firestarter_1.briefing_dialog = "Play_pln_firestarter_stage1_brief"
	self.firestarter_1.world_name = "narratives/h_firestarter/stage_1"
	self.firestarter_1.intro_event = "Play_pln_firestarter_stage1_intro_a"
	self.firestarter_1.outro_event = {
		"Play_pln_firestarter_stage1_end_a",
		"Play_pln_firestarter_stage1_end_b"
	}
	self.firestarter_1.music = "heist"
	self.firestarter_1.package = "packages/narr_firestarter1"
	self.firestarter_1.cube = "cube_apply_heist_bank"
	self.firestarter_2 = {}
	self.firestarter_2.name_id = "heist_firestarter_2_hl"
	self.firestarter_2.briefing_id = "heist_firestarter_2_briefing"
	self.firestarter_2.briefing_dialog = "Play_pln_firestarter_stage2_brief"
	self.firestarter_2.world_name = "narratives/h_firestarter/stage_2"
	self.firestarter_2.intro_event = "Play_pln_firestarter_stage2_intro_a"
	self.firestarter_2.outro_event = {
		"Play_pln_firestarter_stage2_end_a",
		"Play_pln_firestarter_stage2_end_b"
	}
	self.firestarter_2.music = "heist"
	self.firestarter_2.package = "packages/narr_firestarter2"
	self.firestarter_2.cube = "cube_apply_heist_bank"
	self.firestarter_3 = {}
	self.firestarter_3.name_id = "heist_firestarter_3_hl"
	self.firestarter_3.briefing_id = "heist_firestarter_3_briefing"
	self.firestarter_3.briefing_dialog = "Play_pln_firestarter_stage3_brief"
	self.firestarter_3.world_name = "narratives/h_firestarter/stage_3"
	self.firestarter_3.intro_event = "Play_pln_firestarter_stage3_intro_a"
	self.firestarter_3.outro_event = {
		"Play_pln_firestarter_stage3_end_a",
		"Play_pln_firestarter_stage3_end_b"
	}
	self.firestarter_3.music = "heist"
	self.firestarter_3.package = "packages/narr_firestarter3"
	self.firestarter_3.cube = "cube_apply_heist_bank"
	self.firestarter_3.mission_data = {
		{mission = "default"}
	}
	self.welcome_to_the_jungle_1 = {}
	self.welcome_to_the_jungle_1.name_id = "heist_welcome_to_the_jungle_1_hl"
	self.welcome_to_the_jungle_1.briefing_id = "heist_welcome_to_the_jungle_1_briefing"
	self.welcome_to_the_jungle_1.briefing_dialog = "Play_pln_bigoil_stage1_brief"
	self.welcome_to_the_jungle_1.briefing_assets_gui = Idstring("guis/mission_briefing/preload_stage_welcome_to_the_jungle_1")
	self.welcome_to_the_jungle_1.world_name = "narratives/e_welcome_to_the_jungle/stage_1"
	self.welcome_to_the_jungle_1.intro_event = "Play_pln_bigoil_stage1_intro_a"
	self.welcome_to_the_jungle_1.outro_event = {
		"Play_pln_bigoil_stage1_end_a",
		"Play_pln_bigoil_stage1_end_b"
	}
	self.welcome_to_the_jungle_1.music = "heist"
	self.welcome_to_the_jungle_1.package = {
		"packages/narr_jungle1"
	}
	self.welcome_to_the_jungle_1.cube = "cube_apply_heist_bank"
	self.welcome_to_the_jungle_2 = {}
	self.welcome_to_the_jungle_2.name_id = "heist_welcome_to_the_jungle_2_hl"
	self.welcome_to_the_jungle_2.briefing_id = "heist_welcome_to_the_jungle_2_briefing"
	self.welcome_to_the_jungle_2.briefing_dialog = "Play_pln_bigoil_stage2_brief"
	self.welcome_to_the_jungle_2.briefing_assets_gui = Idstring("guis/mission_briefing/preload_stage_welcome_to_the_jungle_2")
	self.welcome_to_the_jungle_2.world_name = "narratives/e_welcome_to_the_jungle/stage_2"
	self.welcome_to_the_jungle_2.intro_event = "Play_pln_bigoil_stage2_intro_a"
	self.welcome_to_the_jungle_2.outro_event = {
		"Play_pln_bigoil_stage2_end_a",
		"Play_pln_bigoil_stage2_end_b"
	}
	self.welcome_to_the_jungle_2.music = "heist"
	self.welcome_to_the_jungle_2.package = {
		"packages/narr_jungle2"
	}
	self.welcome_to_the_jungle_2.cube = "cube_apply_heist_bank"
	self.ukrainian_job = {}
	self.ukrainian_job.name_id = "heist_ukrainian_job_hl"
	self.ukrainian_job.briefing_id = "heist_ukrainian_job_briefing"
	self.ukrainian_job.briefing_dialog = "Play_pln_ukranian_stage1_brief"
	self.ukrainian_job.briefing_assets_gui = Idstring("guis/mission_briefing/preload_stage_quick_diamond")
	self.ukrainian_job.world_name = "narratives/vlad/ukrainian_job"
	self.ukrainian_job.intro_event = "Play_pln_ukranian_stage1_intro_a"
	self.ukrainian_job.outro_event = {
		"Play_pln_ukranian_stage1_end_a",
		"Play_pln_ukranian_stage1_end_b",
		"Play_pln_ukranian_stage1_end_c"
	}
	self.ukrainian_job.music = "heist"
	self.ukrainian_job.package = {
		"packages/ukrainian_job"
	}
	self.ukrainian_job.cube = "cube_apply_heist_bank"
	self.ukrainian_job.group_ai_preset = "small_urban"
	self.four_stores = {}
	self.four_stores.name_id = "heist_four_stores_hl"
	self.four_stores.briefing_id = "heist_four_stores_briefing"
	self.four_stores.briefing_dialog = "Play_pln_fourstores_stage1_brief"
	self.four_stores.world_name = "narratives/vlad/four_stores"
	self.four_stores.intro_event = "Play_pln_fourstores_stage1_intro_a"
	self.four_stores.outro_event = {
		"Play_pln_fourstores_stage1_end_a",
		"Play_pln_fourstores_stage1_end_b"
	}
	self.four_stores.music = "heist"
	self.four_stores.package = "packages/vlad_four_stores"
	self.four_stores.cube = "cube_apply_heist_bank"
	self.jewelry_store = {}
	self.jewelry_store.name_id = "heist_jewelry_store_hl"
	self.jewelry_store.briefing_id = "heist_jewelry_store_briefing"
	self.jewelry_store.briefing_dialog = "pln_jewelerystore_stage1_brief"
	self.jewelry_store.world_name = "narratives/vlad/jewelry_store"
	self.jewelry_store.intro_event = {
		"pln_jewelrystore_stage1_intro_01",
		"pln_jewelrystore_stage1_intro_02",
		"pln_jewelrystore_stage1_intro_03",
		"pln_jewelrystore_stage1_intro_04",
		"pln_jewelrystore_stage1_intro_05",
		"pln_jewelrystore_stage1_intro_06"
	}
	self.jewelry_store.outro_event = "pln_jewelerystore_stage1_end"
	self.jewelry_store.music = "heist"
	self.jewelry_store.package = "packages/ukrainian_job"
	self.jewelry_store.cube = "cube_apply_heist_bank"
	self.mallcrasher = {}
	self.mallcrasher.name_id = "heist_mallcrasher_hl"
	self.mallcrasher.briefing_id = "heist_mallcrasher_briefing"
	self.mallcrasher.briefing_dialog = "Play_pln_mallcrasch_stage1_brief"
	self.mallcrasher.world_name = "narratives/vlad/mallcrasher"
	self.mallcrasher.intro_event = "Play_pln_mallcrasch_stage1_intro_a"
	self.mallcrasher.outro_event = {
		"Play_pln_mallcrasch_stage1_end_a",
		"Play_pln_mallcrasch_stage1_end_b"
	}
	self.mallcrasher.music = "heist"
	self.mallcrasher.package = "packages/vlad_mallcrasher"
	self.mallcrasher.cube = "cube_apply_heist_bank"
	self.nightclub = {}
	self.nightclub.name_id = "heist_nightclub_hl"
	self.nightclub.briefing_id = "heist_nightclub_briefing"
	self.nightclub.briefing_dialog = "Play_pln_nightclub_stage1_brief"
	self.nightclub.world_name = "narratives/vlad/nightclub"
	self.nightclub.intro_event = "Play_pln_nightclub_stage1_intro_a"
	self.nightclub.outro_event = {
		"Play_pln_nightclub_stage1_end_a",
		"Play_pln_nightclub_stage1_end_b"
	}
	self.nightclub.music = "heist"
	self.nightclub.package = "packages/vlad_nightclub"
	self.nightclub.cube = "cube_apply_heist_bank"
	self.branchbank = {}
	self.branchbank.name_id = "heist_branchbank_hl"
	self.branchbank.briefing_id = "heist_branchbank_briefing"
	self.branchbank.briefing_dialog = "Play_pln_branchbank_random_stage1_brief"
	self.branchbank.world_name = "narratives/h_firestarter/stage_3"
	self.branchbank.intro_event = {
		"Play_pln_branchbank_random_a_intro_a",
		"Play_pln_branchbank_gold_a_intro_a",
		"Play_pln_branchbank_depositbox_a_intro_a",
		"Play_pln_branchbank_cash_stage1_intro_a"
	}
	self.branchbank.outro_event = "Play_pln_branchbank_stage1_end"
	self.branchbank.music = "heist"
	self.branchbank.package = "packages/narr_firestarter3"
	self.branchbank.cube = "cube_apply_heist_bank"
	self.branchbank.mission_data = {
		{mission = "standalone"}
	}
	self.fwb = {}
	self.fwb.name_id = "heist_fwb_hl"
	self.fwb.briefing_id = "heist_fwb_briefing"
	self.fwb.world_name = "narratives/vlad/fwb"
	self.fwb.intro_event = "nothing"
	self.fwb.outro_event = "nothing"
	self.fwb.music = "heist"
	self.fwb.package = "packages/vlad_fwb"
	self.fwb.cube = "cube_apply_heist_bank"
	self.escape_cafe = {}
	self.escape_cafe.name_id = "heist_escape_cafe_hl"
	self.escape_cafe.briefing_id = "heist_escape_cafe_briefing"
	self.escape_cafe.briefing_dialog = "nothing"
	self.escape_cafe.world_name = "narratives/escapes/escape_cafe"
	self.escape_cafe.intro_event = "Play_dr1_a01"
	self.escape_cafe.outro_event = "nothing"
	self.escape_cafe.music = "heist"
	self.escape_cafe.package = "packages/escape_cafe"
	self.escape_cafe.cube = "cube_apply_heist_bank"
	self.escape_park = {}
	self.escape_park.name_id = "heist_escape_park_hl"
	self.escape_park.briefing_id = "heist_escape_park_briefing"
	self.escape_park.briefing_dialog = "nothing"
	self.escape_park.world_name = "narratives/escapes/escape_park"
	self.escape_park.intro_event = "Play_dr1_a01"
	self.escape_park.outro_event = "nothing"
	self.escape_park.music = "heist"
	self.escape_park.package = "packages/escape_park"
	self.escape_park.cube = "cube_apply_heist_bank"
	self.escape_street = {}
	self.escape_street.name_id = "heist_escape_street_hl"
	self.escape_street.briefing_id = "heist_escape_street_briefing"
	self.escape_street.briefing_dialog = "nothing"
	self.escape_street.world_name = "narratives/escapes/escape_street"
	self.escape_street.intro_event = "Play_dr1_a01"
	self.escape_street.outro_event = "nothing"
	self.escape_street.music = "heist"
	self.escape_street.package = "packages/escape_street"
	self.escape_street.cube = "cube_apply_heist_bank"
	self.escape_overpass = {}
	self.escape_overpass.name_id = "heist_escape_overpass_hl"
	self.escape_overpass.briefing_id = "heist_escape_overpass_briefing"
	self.escape_overpass.briefing_dialog = "nothing"
	self.escape_overpass.world_name = "narratives/escapes/escape_overpass"
	self.escape_overpass.intro_event = "Play_dr1_a01"
	self.escape_overpass.outro_event = "nothing"
	self.escape_overpass.music = "heist"
	self.escape_overpass.package = "packages/escape_overpass"
	self.escape_overpass.cube = "cube_apply_heist_bank"
	self.escape_overpass_night = deep_clone(self.escape_overpass)
	self.escape_garage = {}
	self.escape_garage.name_id = "heist_escape_garage_hl"
	self.escape_garage.briefing_id = "heist_escape_garage_briefing"
	self.escape_garage.briefing_dialog = "nothing"
	self.escape_garage.world_name = "narratives/escapes/escape_garage"
	self.escape_garage.intro_event = "Play_dr1_a01"
	self.escape_garage.outro_event = "nothing"
	self.escape_garage.music = "heist"
	self.escape_garage.package = "packages/escape_garage"
	self.escape_garage.cube = "cube_apply_heist_bank"
	self.safehouse = {}
	self.safehouse.name_id = "heist_safehouse_hl"
	self.safehouse.briefing_id = "heist_safehouse_briefing"
	self.safehouse.briefing_dialog = "Play_pln_sh_intro"
	self.safehouse.world_name = "narratives/safehouse"
	self.safehouse.intro_event = "nothing"
	self.safehouse.outro_event = "nothing"
	self.safehouse.music = "heist"
	self.safehouse.package = "packages/safehouse"
	self.safehouse.cube = "cube_apply_heist_bank"
	self.test01 = {}
	self.test01.name_id = "heist_test01_hl"
	self.test01.briefing_id = "heist_test01"
	self.test01.world_name = "tests/sound_environment_test"
	self.test01.intro_event = "nothing"
	self.test01.outro_event = "nothing"
	self.test01.music = "heist"
	self.test01.package = "packages/level_debug"
	self.test01.cube = "cube_apply_heist_bank"
	self.test02 = {}
	self.test02.name_id = "heist_test02_hl"
	self.test02.briefing_id = "heist_test02"
	self.test02.world_name = "narratives/h_bring_me_the_head_of_armando_garcia/stage_2"
	self.test02.intro_event = "nothing"
	self.test02.outro_event = "nothing"
	self.test02.music = "heist"
	self.test02.package = "packages/level_debug"
	self.test02.cube = "cube_apply_heist_bank"
	self.test03 = {}
	self.test03.name_id = "heist_test03_hl"
	self.test03.briefing_id = "heist_test03"
	self.test03.world_name = "tests/trailer_bank_b"
	self.test03.intro_event = "nothing"
	self.test03.outro_event = "nothing"
	self.test03.music = "heist"
	self.test03.package = "packages/level_debug"
	self.test03.cube = "cube_apply_heist_bank"
	self.test04 = {}
	self.test04.name_id = "heist_test04_hl"
	self.test04.briefing_id = "heist_test04"
	self.test04.world_name = "narratives/escapes/escape_cafe"
	self.test04.intro_event = "nothing"
	self.test04.outro_event = "nothing"
	self.test04.music = "heist"
	self.test04.package = "packages/level_debug"
	self.test04.cube = "cube_apply_heist_bank"
	self.test05 = {}
	self.test05.name_id = "heist_test05_hl"
	self.test05.briefing_id = "heist_test05"
	self.test05.world_name = "payday2/apartment_c"
	self.test05.intro_event = "nothing"
	self.test05.outro_event = "nothing"
	self.test05.music = "heist"
	self.test05.package = "packages/level_debug"
	self.test05.cube = "cube_apply_heist_bank"
	self.test06 = {}
	self.test06.name_id = "heist_test06_hl"
	self.test06.briefing_id = "heist_test06"
	self.test06.world_name = "narratives/escapes/escape_garage"
	self.test06.intro_event = "nothing"
	self.test06.outro_event = "nothing"
	self.test06.music = "heist"
	self.test06.package = "packages/level_debug"
	self.test06.cube = "cube_apply_heist_bank"
	self.test07 = {}
	self.test07.name_id = "heist_test07_hl"
	self.test07.briefing_id = "heist_test07"
	self.test07.world_name = "tests/character_showcase"
	self.test07.intro_event = "nothing"
	self.test07.outro_event = "nothing"
	self.test07.music = "heist"
	self.test07.package = "packages/level_debug"
	self.test07.cube = "cube_apply_heist_bank"
	self.test08 = {}
	self.test08.name_id = "heist_test08_hl"
	self.test08.briefing_id = "heist_test08"
	self.test08.world_name = "tests/narrative/stage1"
	self.test08.intro_event = "nothing"
	self.test08.outro_event = "nothing"
	self.test08.music = "heist"
	self.test08.package = "packages/level_debug"
	self.test08.cube = "cube_apply_heist_bank"
	self.test09 = {}
	self.test09.name_id = "heist_test09_hl"
	self.test09.briefing_id = "heist_test09"
	self.test09.world_name = "tests/narrative/stage2"
	self.test09.intro_event = "nothing"
	self.test09.outro_event = "nothing"
	self.test09.music = "heist"
	self.test09.package = "packages/narr_watchdogs1"
	self.test09.cube = "cube_apply_heist_bank"
	self.test10 = {}
	self.test10.name_id = "heist_test10_hl"
	self.test10.briefing_id = "heist_test10"
	self.test10.world_name = "tests/graph_difference_test"
	self.test10.intro_event = "nothing"
	self.test10.outro_event = "nothing"
	self.test10.music = "heist"
	self.test10.package = "packages/level_debug"
	self.test10.cube = "cube_apply_heist_bank"
	self.vehicle_van_test = {}
	self.vehicle_van_test.name_id = "heist_vehicle_van_test_hl"
	self.vehicle_van_test.briefing_id = "heist_vehicle_van_test"
	self.vehicle_van_test.world_name = "tests/vehicle_van_test"
	self.vehicle_van_test.intro_event = "nothing"
	self.vehicle_van_test.outro_event = "nothing"
	self.vehicle_van_test.music = "heist"
	self.vehicle_van_test.package = "packages/level_debug"
	self.vehicle_van_test.cube = "cube_apply_heist_bank"
	self.escape_chain_test_1 = {}
	self.escape_chain_test_1.name_id = "heist_escape_chain_test_1_hl"
	self.escape_chain_test_1.briefing_id = "heist_escape_chain_test_1_briefing"
	self.escape_chain_test_1.world_name = "narratives/escapes/esc_testchain/stage_1"
	self.escape_chain_test_1.intro_event = "nothing"
	self.escape_chain_test_1.outro_event = "nothing"
	self.escape_chain_test_1.music = "heist"
	self.escape_chain_test_1.package = "packages/level_debug"
	self.escape_chain_test_1.cube = "cube_apply_heist_bank"
	self.escape_chain_test_2 = {}
	self.escape_chain_test_2.name_id = "heist_escape_chain_test_2_hl"
	self.escape_chain_test_2.briefing_id = "heist_escape_chain_test_2_briefing"
	self.escape_chain_test_2.world_name = "narratives/escapes/esc_testchain/stage_2"
	self.escape_chain_test_2.intro_event = "nothing"
	self.escape_chain_test_2.outro_event = "nothing"
	self.escape_chain_test_2.music = "heist"
	self.escape_chain_test_2.package = "packages/level_debug"
	self.escape_chain_test_2.cube = "cube_apply_heist_bank"
	self.bank = {}
	self.bank.name_id = "debug_bank"
	self.bank.briefing_id = "debug_bank_briefing"
	self.bank.ticker_id = "debug_bank_ticker"
	self.bank.world_name = SystemInfo:platform() == Idstring("PS3") and "bank_ps3" or "bank"
	self.bank.intro_event = "Play_1wb_ban_01x_any"
	self.bank.intro_cues = {
		"intro_bank01",
		"intro_bank02",
		"intro_bank03",
		"intro_bank04"
	}
	self.bank.intro_text_id = "intro_bank"
	self.bank.music = "heist"
	self.bank.package = "packages/level_bank"
	self.bank.megaphone_pos = Vector3(-6202, 32, 88)
	self.bank.cube = "cube_apply_bank"
	self.bank.load_data = {
		package = "packages/load_bank",
		image = "guis/textures/loading/loading_bank"
	}
	self.heat_street = {}
	self.heat_street.name_id = "debug_street"
	self.heat_street.world_name = SystemInfo:platform() == Idstring("PS3") and "street_ps3" or "street"
	self.heat_street.intro_event = "str_blackscreen"
	self.heat_street.intro_cues = {
		"intro_street01",
		"intro_street02",
		"intro_street03",
		"intro_street04",
		"intro_street05"
	}
	self.heat_street.intro_text_id = "intro_street"
	self.heat_street.music = "heist"
	self.heat_street.briefing_id = "debug_street_briefing"
	self.heat_street.package = "packages/level_street"
	self.heat_street.cube = "cube_apply_street"
	self.bridge = {}
	self.bridge.name_id = "debug_bridge"
	self.bridge.world_name = SystemInfo:platform() == Idstring("PS3") and "bridge_ps3" or "bridge"
	self.bridge.intro_event = "bri_blackscreen"
	self.bridge.intro_cues = {
		"intro_bridge01",
		"intro_bridge02"
	}
	self.bridge.intro_text_id = "intro_bridge"
	self.bridge.briefing_id = "debug_bridge_briefing"
	self.bridge.package = "packages/level_bridge"
	self.bridge.equipment = {"saw"}
	self.bridge.music = "heist"
	self.bridge.flashlights_on = true
	self.bridge.unit_suit = "raincoat"
	self.bridge.environment_effects = {
		"rain",
		"raindrop_screen",
		"lightning"
	}
	self.bridge.cube = "cube_apply_bridge"
	self.apartment = {}
	self.apartment.name_id = "debug_apartment"
	self.apartment.world_name = SystemInfo:platform() == Idstring("PS3") and "tests/n_drop_in" or "tests/n_drop_in"
	self.apartment.briefing_id = "debug_apartment_briefing"
	self.apartment.equipment = {"saw"}
	self.apartment.intro_event = "Play_apa_rbx_00x_any"
	self.apartment.intro_cues = {
		"intro_apartment01",
		"intro_apartment02",
		"intro_apartment03",
		"intro_apartment04"
	}
	self.apartment.intro_text_id = "intro_apartment"
	self.apartment.music = "heist"
	self.apartment.package = "packages/level_debug"
	self.apartment.megaphone_pos = Vector3(-444, -1502, 206)
	self.apartment.cube = "cube_apply_apartment"
	self.apartment.load_data = {
		package = "packages/load_apartment",
		image = "guis/textures/loading/loading_apartment"
	}
	self.apartment.mission_data = {
		{mission = "version2"}
	}
	self.apartment_night = deep_clone(self.apartment)
	self.apartment_night.env_params = {
		environment = "environments/env_watchdogs_2_4/env_watchdogs_2_4"
	}
	self.diamond_heist = {}
	self.diamond_heist.name_id = "debug_diamond_heist"
	self.diamond_heist.world_name = SystemInfo:platform() == Idstring("PS3") and "diamondheist_ps3" or "diamondheist"
	self.diamond_heist.intro_event = "dim_blackscreen"
	self.diamond_heist.intro_cues = {
		"intro_diamondheist01",
		"intro_diamondheist02",
		"intro_diamondheist03"
	}
	self.diamond_heist.intro_text_id = "intro_diamondheist"
	self.diamond_heist.music = "heist"
	self.diamond_heist.briefing_id = "debug_diamond_heist_briefing"
	self.diamond_heist.package = "packages/level_diamond_heist"
	self.diamond_heist.unit_suit = "cat_suit"
	self.diamond_heist.cube = "cube_apply_diamond"
	self.slaughter_house = {}
	self.slaughter_house.name_id = "debug_slaughter_house"
	self.slaughter_house.world_name = SystemInfo:platform() == Idstring("PS3") and "slaughterhouse_ps3" or "slaughterhouse"
	self.slaughter_house.intro_event = "slh_blackscreen"
	self.slaughter_house.intro_cues = {
		"intro_slaughterhouse01",
		"intro_slaughterhouse03",
		"intro_slaughterhouse05"
	}
	self.slaughter_house.intro_text_id = "intro_slaughterhouse"
	self.slaughter_house.briefing_id = "debug_slaughter_house_briefing"
	self.slaughter_house.package = "packages/level_slaughterhouse"
	self.slaughter_house.equipment = {"drill"}
	self.slaughter_house.music = "heist"
	self.slaughter_house.unit_suit = "cat_suit"
	self.slaughter_house.cube = "cube_apply_slaughter"
	self.suburbia = {}
	self.suburbia.name_id = "debug_suburbia"
	self.suburbia.world_name = "suburbia"
	self.suburbia.intro_event = "cft_blackscreen"
	self.suburbia.intro_cues = {
		"intro_suburbia01",
		"intro_suburbia02",
		"intro_suburbia03",
		"intro_suburbia04",
		"intro_suburbia05",
		"intro_suburbia06"
	}
	self.suburbia.intro_text_id = "intro_suburbia"
	self.suburbia.briefing_id = "debug_suburbia_briefing"
	self.suburbia.package = "packages/level_suburbia"
	self.suburbia.equipment = {"drill"}
	self.suburbia.music = "heist"
	self.suburbia.unit_suit = "suburbia"
	self.suburbia.cube = "cube_apply_suburbia"
	self.suburbia.dlc = "dlc2"
	self.secret_stash = {}
	self.secret_stash.name_id = "debug_secret_stash"
	self.secret_stash.world_name = "secret_stash"
	self.secret_stash.intro_event = "und_blackscreen"
	self.secret_stash.intro_cues = {
		"intro_secret_stash01",
		"intro_secret_stash02",
		"intro_secret_stash03",
		"intro_secret_stash04",
		"intro_secret_stash05",
		"intro_secret_stash06",
		"intro_secret_stash07"
	}
	self.secret_stash.intro_text_id = "intro_secret_stash"
	self.secret_stash.briefing_id = "debug_secret_stash_briefing"
	self.secret_stash.package = "packages/level_secret_stash"
	self.secret_stash.equipment = {"saw"}
	self.secret_stash.music = "heist"
	self.secret_stash.cube = "cube_apply_secret_stash"
	self.secret_stash.dlc = "dlc3"
	self.secret_stash.unit_suit = "cat_suit"
	self.hospital = {}
	self.hospital.name_id = "debug_hospital"
	self.hospital.world_name = "l4d"
	self.hospital.intro_event = {
		"hos_blackscreen",
		"hos_blackscreen_bill_01",
		"hos_blackscreen_bill_02",
		"hos_blackscreen_bill_03",
		"hos_blackscreen_bill_04",
		"hos_blackscreen_bill_05",
		"hos_blackscreen_bill_06",
		"hos_blackscreen_bill_07",
		"hos_blackscreen_bill_08",
		"hos_blackscreen_bill_09",
		"hos_blackscreen_bill_10",
		"hos_blackscreen_bill_11",
		"hos_blackscreen_bill_12",
		"hos_blackscreen_bill_13",
		"hos_blackscreen_bill_14"
	}
	self.hospital.intro_cues = {
		{
			"intro_hospital00",
			"intro_hospital01",
			"intro_hospital02",
			"intro_hospital03",
			"intro_hospital04",
			"intro_hospital05",
			"intro_hospital06",
			"intro_hospital07",
			"intro_hospital08",
			"intro_hospital09"
		},
		{
			"intro_hospital10",
			"intro_hospital11",
			"intro_hospital12",
			"intro_hospital13",
			"intro_hospital14",
			"intro_hospital15",
			"intro_hospital16",
			"intro_hospital17",
			"intro_hospital18",
			"intro_hospital19"
		},
		{
			"intro_hospital20",
			"intro_hospital21",
			"intro_hospital22",
			"intro_hospital23",
			"intro_hospital24",
			"intro_hospital25",
			"intro_hospital26",
			"intro_hospital27",
			"intro_hospital28",
			"intro_hospital29"
		},
		{
			"intro_hospital30",
			"intro_hospital31",
			"intro_hospital32",
			"intro_hospital33",
			"intro_hospital34",
			"intro_hospital35",
			"intro_hospital36",
			"intro_hospital37",
			"intro_hospital38",
			"intro_hospital39"
		},
		{
			"intro_hospital40",
			"intro_hospital41",
			"intro_hospital42",
			"intro_hospital43",
			"intro_hospital44",
			"intro_hospital45",
			"intro_hospital46",
			"intro_hospital47",
			"intro_hospital48",
			"intro_hospital49"
		},
		{
			"intro_hospital50",
			"intro_hospital51",
			"intro_hospital52",
			"intro_hospital53",
			"intro_hospital54",
			"intro_hospital55",
			"intro_hospital56",
			"intro_hospital57",
			"intro_hospital58",
			"intro_hospital59"
		},
		{
			"intro_hospital60",
			"intro_hospital61",
			"intro_hospital62",
			"intro_hospital63",
			"intro_hospital64",
			"intro_hospital65",
			"intro_hospital66",
			"intro_hospital67",
			"intro_hospital68",
			"intro_hospital69"
		},
		{
			"intro_hospital70",
			"intro_hospital71",
			"intro_hospital72",
			"intro_hospital73",
			"intro_hospital74",
			"intro_hospital75",
			"intro_hospital76",
			"intro_hospital77",
			"intro_hospital78",
			"intro_hospital79"
		},
		{
			"intro_hospital80",
			"intro_hospital81",
			"intro_hospital82",
			"intro_hospital83",
			"intro_hospital84",
			"intro_hospital85",
			"intro_hospital86",
			"intro_hospital87",
			"intro_hospital88",
			"intro_hospital89"
		},
		{
			"intro_hospital90",
			"intro_hospital91",
			"intro_hospital92",
			"intro_hospital93",
			"intro_hospital94",
			"intro_hospital95",
			"intro_hospital96",
			"intro_hospital97",
			"intro_hospital98",
			"intro_hospital99"
		},
		{
			"intro_hospital100",
			"intro_hospital101",
			"intro_hospital102",
			"intro_hospital103",
			"intro_hospital104",
			"intro_hospital105",
			"intro_hospital106",
			"intro_hospital107",
			"intro_hospital108",
			"intro_hospital109"
		},
		{
			"intro_hospital110",
			"intro_hospital111",
			"intro_hospital112",
			"intro_hospital113",
			"intro_hospital114",
			"intro_hospital115",
			"intro_hospital116",
			"intro_hospital117",
			"intro_hospital118",
			"intro_hospital119"
		},
		{
			"intro_hospital120",
			"intro_hospital121",
			"intro_hospital122",
			"intro_hospital123",
			"intro_hospital124",
			"intro_hospital125",
			"intro_hospital126",
			"intro_hospital127",
			"intro_hospital128",
			"intro_hospital129"
		},
		{
			"intro_hospital130",
			"intro_hospital131",
			"intro_hospital132",
			"intro_hospital133",
			"intro_hospital134",
			"intro_hospital135",
			"intro_hospital136",
			"intro_hospital137",
			"intro_hospital138",
			"intro_hospital139"
		},
		{
			"intro_hospital140",
			"intro_hospital141",
			"intro_hospital142",
			"intro_hospital143",
			"intro_hospital144",
			"intro_hospital145",
			"intro_hospital146",
			"intro_hospital147",
			"intro_hospital148",
			"intro_hospital149"
		}
	}
	self.hospital.intro_text_id = "intro_hospital"
	self.hospital.briefing_id = "debug_hospital_briefing"
	self.hospital.package = "packages/level_hospital"
	self.hospital.music = "heist"
	self.hospital.unit_suit = "scrubs"
	self.hospital.cube = "cube_apply_slaughter"
	self.hospital.dlc = "dlc4"
	self._level_index = {
		"welcome_to_the_jungle_1",
		"welcome_to_the_jungle_2",
		"framing_frame_1",
		"framing_frame_2",
		"framing_frame_3",
		"election_day_1",
		"election_day_2",
		"election_day_3",
		"watchdogs_1",
		"watchdogs_2",
		"alex_1",
		"alex_2",
		"alex_3",
		"firestarter_1",
		"firestarter_2",
		"firestarter_3",
		"ukrainian_job",
		"jewelry_store",
		"four_stores",
		"mallcrasher",
		"nightclub",
		"branchbank",
		"fwb",
		"escape_cafe",
		"escape_park",
		"escape_street",
		"escape_overpass",
		"escape_garage",
		"escape_overpass_night",
		"safehouse",
		"test01",
		"test02",
		"test03",
		"test04",
		"test05",
		"test06",
		"test07",
		"test08",
		"test09",
		"test10",
		"escape_chain_test_1",
		"escape_chain_test_2",
		"vehicle_van_test"
	}
	self.escape_levels = {
		"escape_cafe",
		"escape_park",
		"escape_street",
		"escape_overpass",
		"escape_garage",
		"escape_overpass_night"
	}
end

function LevelsTweakData:get_level_index()
	return self._level_index
end

function LevelsTweakData:get_world_name_from_index(index)
	if not self._level_index[index] then
		return
	end
	return self[self._level_index[index]].world_name
end

function LevelsTweakData:get_level_name_from_index(index)
	return self._level_index[index]
end

function LevelsTweakData:get_index_from_world_name(world_name)
	for index, entry_name in ipairs(self._level_index) do
		if world_name == self[entry_name].world_name then
			return index
		end
	end
end

function LevelsTweakData:get_index_from_level_id(level_id)
	for index, entry_name in ipairs(self._level_index) do
		if entry_name == level_id then
			return index
		end
	end
end

function LevelsTweakData:requires_dlc(level_id)
	return self[level_id].dlc
end

function LevelsTweakData:requires_dlc_by_index(index)
	return self[self._level_index[index]].dlc
end

function LevelsTweakData:get_level_name_from_world_name(world_name)
	for _, entry_name in ipairs(self._level_index) do
		if world_name == self[entry_name].world_name then
			return entry_name
		end
	end
end

function LevelsTweakData:get_localized_level_name_from_world_name(world_name)
	for _, entry_name in ipairs(self._level_index) do
		if world_name == self[entry_name].world_name then
			return managers.localization:text(self[entry_name].name_id)
		end
	end
end

function LevelsTweakData:get_localized_level_name_from_level_id(level_id)
	for _, entry_name in ipairs(self._level_index) do
		if level_id == entry_name then
			return managers.localization:text(self[entry_name].name_id)
		end
	end
end

function LevelsTweakData:get_music_switches()
	if not Global.level_data then
		return nil
	end
	local level_data = Global.level_data.level_id and tweak_data.levels[Global.level_data.level_id]
	local music_id = level_data and level_data.music or "default"
	return tweak_data.music[music_id].switches
end

function LevelsTweakData:get_music_event(stage)
	local level_data = Global.level_data.level_id and tweak_data.levels[Global.level_data.level_id]
	local music_id = level_data and level_data.music or "default"
	return tweak_data.music[music_id][stage]
end
