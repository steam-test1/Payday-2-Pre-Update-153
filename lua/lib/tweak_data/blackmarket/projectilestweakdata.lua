function BlackMarketTweakData:_init_bullets(tweak_data)
	self.bullets = {}
end

function BlackMarketTweakData:_init_projectiles(tweak_data)
	self.projectiles = {}
	self.projectiles.frag = {}
	self.projectiles.frag.name_id = "bm_grenade_frag"
	self.projectiles.frag.unit = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade"
	self.projectiles.frag.unit_dummy = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade_husk"
	self.projectiles.frag.sprint_unit = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade_sprint"
	self.projectiles.frag.icon = "frag_grenade"
	self.projectiles.frag.dlc = "gage_pack"
	self.projectiles.frag.throwable = true
	self.projectiles.frag.max_amount = 3
	self.projectiles.frag.animation = "throw_grenade"
	self.projectiles.frag.anim_global_param = "projectile_frag"
	self.projectiles.frag.throw_allowed_expire_t = 0.1
	self.projectiles.frag.expire_t = 1.1
	self.projectiles.frag.repeat_expire_t = 1.5
	self.projectiles.frag.is_a_grenade = true
	self.projectiles.concussion = {}
	self.projectiles.concussion.name_id = "bm_concussion"
	self.projectiles.concussion.unit = "units/pd2_crimefest_2016/fez1/weapons/wpn_fps_gre_pressure/wpn_third_gre_pressure"
	self.projectiles.concussion.unit_dummy = "units/pd2_crimefest_2016/fez1/weapons/wpn_fps_gre_pressure/wpn_fps_gre_pressure_husk"
	self.projectiles.concussion.sprint_unit = "units/pd2_crimefest_2016/fez1/weapons/wpn_fps_gre_pressure/wpn_third_gre_pressure_sprint"
	self.projectiles.concussion.icon = "concussion_grenade"
	self.projectiles.concussion.throwable = true
	self.projectiles.concussion.max_amount = 6
	self.projectiles.concussion.animation = "throw_concussion"
	self.projectiles.concussion.anim_global_param = "projectile_frag"
	self.projectiles.concussion.texture_bundle_folder = "fez1"
	self.projectiles.concussion.throw_allowed_expire_t = 0.1
	self.projectiles.concussion.expire_t = 0.9
	self.projectiles.concussion.repeat_expire_t = 1.5
	self.projectiles.concussion.is_a_grenade = true
	self.projectiles.molotov = {}
	self.projectiles.molotov.name_id = "bm_grenade_molotov"
	self.projectiles.molotov.unit = "units/pd2_dlc_bbq/weapons/molotov_cocktail/wpn_molotov_third"
	self.projectiles.molotov.unit_dummy = "units/pd2_dlc_bbq/weapons/molotov_cocktail/wpn_molotov_husk"
	self.projectiles.molotov.icon = "molotov_grenade"
	self.projectiles.molotov.dlc = "bbq"
	self.projectiles.molotov.no_cheat_count = true
	self.projectiles.molotov.impact_detonation = true
	self.projectiles.molotov.time_cheat = 1
	self.projectiles.molotov.throwable = true
	self.projectiles.molotov.max_amount = 3
	self.projectiles.molotov.texture_bundle_folder = "bbq"
	self.projectiles.molotov.physic_effect = Idstring("physic_effects/molotov_throw")
	self.projectiles.molotov.animation = "throw_molotov"
	self.projectiles.molotov.anim_global_param = "projectile_molotov"
	self.projectiles.molotov.throw_allowed_expire_t = 0.1
	self.projectiles.molotov.expire_t = 1.3
	self.projectiles.molotov.repeat_expire_t = 1.5
	self.projectiles.molotov.is_a_grenade = true
	self.projectiles.dynamite = {}
	self.projectiles.dynamite.name_id = "bm_dynamite"
	self.projectiles.dynamite.unit = "units/pd2_dlc_west/weapons/wpn_gre_dynamite/wpn_gre_dynamite"
	self.projectiles.dynamite.unit_dummy = "units/pd2_dlc_west/weapons/wpn_gre_dynamite/wpn_gre_dynamite_husk"
	self.projectiles.dynamite.icon = "dynamite_grenade"
	self.projectiles.dynamite.dlc = "west"
	self.projectiles.dynamite.texture_bundle_folder = "west"
	self.projectiles.dynamite.max_amount = 3
	self.projectiles.dynamite.throwable = true
	self.projectiles.dynamite.animation = "throw_dynamite"
	self.projectiles.dynamite.anim_global_param = "projectile_dynamite"
	self.projectiles.dynamite.throw_allowed_expire_t = 0.1
	self.projectiles.dynamite.expire_t = 1.3
	self.projectiles.dynamite.repeat_expire_t = 1.5
	self.projectiles.dynamite.is_a_grenade = true
	self.projectiles.wpn_prj_four = {}
	self.projectiles.wpn_prj_four.name_id = "bm_wpn_prj_four"
	self.projectiles.wpn_prj_four.unit = "units/pd2_dlc_turtles/weapons/wpn_prj_four/wpn_prj_four"
	self.projectiles.wpn_prj_four.unit_dummy = "units/pd2_dlc_turtles/weapons/wpn_prj_four/wpn_prj_four_husk"
	self.projectiles.wpn_prj_four.local_unit = "units/pd2_dlc_turtles/weapons/wpn_prj_four/wpn_prj_four_local"
	self.projectiles.wpn_prj_four.icon = "four_projectile"
	self.projectiles.wpn_prj_four.throw_shout = true
	self.projectiles.wpn_prj_four.no_cheat_count = true
	self.projectiles.wpn_prj_four.impact_detonation = true
	self.projectiles.wpn_prj_four.client_authoritative = true
	self.projectiles.wpn_prj_four.add_trail_effect = true
	self.projectiles.wpn_prj_four.throwable = true
	self.projectiles.wpn_prj_four.texture_bundle_folder = "turtles"
	self.projectiles.wpn_prj_four.dlc = "turtles"
	self.projectiles.wpn_prj_four.max_amount = 10
	self.projectiles.wpn_prj_four.anim_global_param = "projectile_four"
	self.projectiles.wpn_prj_four.throw_allowed_expire_t = 0.15
	self.projectiles.wpn_prj_four.expire_t = 1.1
	self.projectiles.wpn_prj_four.repeat_expire_t = 0.5
	self.projectiles.wpn_prj_ace = {}
	self.projectiles.wpn_prj_ace.name_id = "bm_wpn_prj_ace"
	self.projectiles.wpn_prj_ace.unit = "units/pd2_dlc_cake/weapons/wpn_prj_ace/wpn_prj_ace"
	self.projectiles.wpn_prj_ace.unit_dummy = "units/pd2_dlc_cake/weapons/wpn_prj_ace/wpn_prj_ace_husk"
	self.projectiles.wpn_prj_ace.local_unit = "units/pd2_dlc_cake/weapons/wpn_prj_ace/wpn_prj_ace_local"
	self.projectiles.wpn_prj_ace.icon = "ace_projectile"
	self.projectiles.wpn_prj_ace.throw_shout = true
	self.projectiles.wpn_prj_ace.no_cheat_count = true
	self.projectiles.wpn_prj_ace.impact_detonation = true
	self.projectiles.wpn_prj_ace.client_authoritative = true
	self.projectiles.wpn_prj_ace.add_trail_effect = true
	self.projectiles.wpn_prj_ace.throwable = true
	self.projectiles.wpn_prj_ace.dlc = "pd2_clan"
	self.projectiles.wpn_prj_ace.max_amount = 21
	self.projectiles.wpn_prj_ace.anim_global_param = "projectile_four"
	self.projectiles.wpn_prj_ace.throw_allowed_expire_t = 0.15
	self.projectiles.wpn_prj_ace.expire_t = 1.1
	self.projectiles.wpn_prj_ace.repeat_expire_t = 0.3
	self.projectiles.launcher_frag = {}
	self.projectiles.launcher_frag.name_id = "bm_launcher_frag"
	self.projectiles.launcher_frag.unit = "units/pd2_dlc_gage_assault/weapons/wpn_launcher_frag_grenade/wpn_launcher_frag_grenade"
	self.projectiles.launcher_frag.weapon_id = "gre_m79"
	self.projectiles.launcher_frag.no_cheat_count = true
	self.projectiles.launcher_frag.impact_detonation = true
	self.projectiles.launcher_frag.time_cheat = 1
	self.projectiles.rocket_frag = {}
	self.projectiles.rocket_frag.name_id = "bm_rocket_frag"
	self.projectiles.rocket_frag.unit = "units/pd2_dlc_overkill_pack/weapons/wpn_third_rpg7_fired_rocket/wpn_third_rpg7_fired_rocket"
	self.projectiles.rocket_frag.weapon_id = "rpg7"
	self.projectiles.rocket_frag.no_cheat_count = true
	self.projectiles.rocket_frag.impact_detonation = true
	self.projectiles.rocket_frag.time_cheat = 1
	self.projectiles.rocket_frag.physic_effect = Idstring("physic_effects/anti_gravitate")
	self.projectiles.rocket_frag.adjust_z = 0
	self.projectiles.launcher_incendiary = {}
	self.projectiles.launcher_incendiary.name_id = "bm_launcher_incendiary"
	self.projectiles.launcher_incendiary.unit = "units/pd2_dlc_bbq/weapons/wpn_launcher_incendiary_grenade/wpn_launcher_incendiary_grenade"
	self.projectiles.launcher_incendiary.weapon_id = "gre_m79"
	self.projectiles.launcher_incendiary.no_cheat_count = true
	self.projectiles.launcher_incendiary.impact_detonation = true
	self.projectiles.launcher_incendiary.time_cheat = 1
	self.projectiles.launcher_frag_m32 = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_frag_m32.weapon_id = "m32"
	self.projectiles.launcher_incendiary_m32 = deep_clone(self.projectiles.launcher_incendiary)
	self.projectiles.launcher_incendiary_m32.weapon_id = "m32"
	self.projectiles.launcher_frag_china = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_frag_china.weapon_id = "china"
	self.projectiles.launcher_incendiary_china = deep_clone(self.projectiles.launcher_incendiary)
	self.projectiles.launcher_incendiary_china.weapon_id = "china"
	self.projectiles.launcher_frag_arbiter = {}
	self.projectiles.launcher_frag_arbiter.name_id = "bm_launcher_frag"
	self.projectiles.launcher_frag_arbiter.unit = "units/pd2_dlc_tng/weapons/wpn_arbiter_frag_grenade/wpn_arbiter_frag_grenade"
	self.projectiles.launcher_frag_arbiter.weapon_id = "arbiter"
	self.projectiles.launcher_frag_arbiter.no_cheat_count = true
	self.projectiles.launcher_frag_arbiter.impact_detonation = true
	self.projectiles.launcher_frag_arbiter.time_cheat = 0.2
	self.projectiles.launcher_frag_arbiter.adjust_z = 0
	self.projectiles.launcher_incendiary_arbiter = {}
	self.projectiles.launcher_incendiary_arbiter.name_id = "bm_launcher_incendiary"
	self.projectiles.launcher_incendiary_arbiter.unit = "units/pd2_dlc_tng/weapons/wpn_arbiter_frag_incendiary_grenade/wpn_arbiter_frag_incendiary_grenade"
	self.projectiles.launcher_incendiary_arbiter.weapon_id = "arbiter"
	self.projectiles.launcher_incendiary_arbiter.no_cheat_count = true
	self.projectiles.launcher_incendiary_arbiter.impact_detonation = true
	self.projectiles.launcher_incendiary_arbiter.time_cheat = 0.2
	self.projectiles.launcher_incendiary_arbiter.adjust_z = 0
	self.projectiles.rocket_ray_frag = {}
	self.projectiles.rocket_ray_frag.name_id = "bm_rocket_frag"
	self.projectiles.rocket_ray_frag.unit = "units/pd2_dlc_friend/weapons/wpn_third_ray_fired_rocket/wpn_third_ray_fired_rocket"
	self.projectiles.rocket_ray_frag.weapon_id = "ray"
	self.projectiles.rocket_ray_frag.no_cheat_count = true
	self.projectiles.rocket_ray_frag.impact_detonation = true
	self.projectiles.rocket_ray_frag.time_cheat = 1
	self.projectiles.rocket_ray_frag.physic_effect = Idstring("physic_effects/anti_gravitate")
	self.projectiles.rocket_ray_frag.adjust_z = 0
	self.projectiles.west_arrow = {}
	self.projectiles.west_arrow.name_id = "bm_launcher_frag"
	self.projectiles.west_arrow.unit = "units/pd2_dlc_west/weapons/wpn_prj_west_arrow/wpn_prj_west_arrow"
	self.projectiles.west_arrow.local_unit = "units/pd2_dlc_west/weapons/wpn_prj_west_arrow/wpn_prj_west_arrow_local"
	self.projectiles.west_arrow.weapon_id = "plainsrider"
	self.projectiles.west_arrow.no_cheat_count = true
	self.projectiles.west_arrow.impact_detonation = true
	self.projectiles.west_arrow.client_authoritative = true
	self.projectiles.west_arrow_exp = {}
	self.projectiles.west_arrow_exp.name_id = "bm_launcher_frag"
	self.projectiles.west_arrow_exp.unit = "units/pd2_dlc_west/weapons/wpn_prj_west_arrow/wpn_prj_west_arrow_exp"
	self.projectiles.west_arrow_exp.local_unit = "units/pd2_dlc_west/weapons/wpn_prj_west_arrow/wpn_prj_west_arrow_exp_local"
	self.projectiles.west_arrow_exp.weapon_id = "plainsrider"
	self.projectiles.west_arrow_exp.no_cheat_count = true
	self.projectiles.west_arrow_exp.impact_detonation = true
	self.projectiles.west_arrow_exp.client_authoritative = true
	self.projectiles.bow_poison_arrow = {}
	self.projectiles.bow_poison_arrow.unit = "units/pd2_dlc_turtles/weapons/wpn_prj_bow_poison_arrow/wpn_prj_bow_poison_arrow"
	self.projectiles.bow_poison_arrow.local_unit = "units/pd2_dlc_turtles/weapons/wpn_prj_bow_poison_arrow/wpn_prj_bow_poison_arrow_local"
	self.projectiles.bow_poison_arrow.weapon_id = "plainsrider"
	self.projectiles.bow_poison_arrow.no_cheat_count = true
	self.projectiles.bow_poison_arrow.impact_detonation = true
	self.projectiles.bow_poison_arrow.client_authoritative = true
	self.projectiles.crossbow_arrow = {}
	self.projectiles.crossbow_arrow.unit = "units/pd2_dlc_turtles/weapons/wpn_prj_crossbow_arrow/wpn_prj_crossbow_arrow"
	self.projectiles.crossbow_arrow.local_unit = "units/pd2_dlc_turtles/weapons/wpn_prj_crossbow_arrow/wpn_prj_crossbow_arrow_local"
	self.projectiles.crossbow_arrow.weapon_id = "hunter"
	self.projectiles.crossbow_arrow.no_cheat_count = true
	self.projectiles.crossbow_arrow.impact_detonation = true
	self.projectiles.crossbow_arrow.client_authoritative = true
	self.projectiles.crossbow_poison_arrow = {}
	self.projectiles.crossbow_poison_arrow.unit = "units/pd2_dlc_turtles/weapons/wpn_prj_crossbow_poison_arrow/wpn_prj_crossbow_poison_arrow"
	self.projectiles.crossbow_poison_arrow.local_unit = "units/pd2_dlc_turtles/weapons/wpn_prj_crossbow_poison_arrow/wpn_prj_crossbow_poison_arrow_local"
	self.projectiles.crossbow_poison_arrow.weapon_id = "hunter"
	self.projectiles.crossbow_poison_arrow.no_cheat_count = true
	self.projectiles.crossbow_poison_arrow.impact_detonation = true
	self.projectiles.crossbow_poison_arrow.client_authoritative = true
	self.projectiles.crossbow_arrow_exp = {}
	self.projectiles.crossbow_arrow_exp.unit = "units/pd2_dlc_turtles/weapons/wpn_prj_crossbow_arrow_exp/wpn_prj_crossbow_arrow_exp"
	self.projectiles.crossbow_arrow_exp.local_unit = "units/pd2_dlc_turtles/weapons/wpn_prj_crossbow_arrow_exp/wpn_prj_crossbow_arrow_exp_local"
	self.projectiles.crossbow_arrow_exp.weapon_id = "hunter"
	self.projectiles.crossbow_arrow_exp.no_cheat_count = true
	self.projectiles.crossbow_arrow_exp.impact_detonation = true
	self.projectiles.crossbow_arrow_exp.client_authoritative = true
	self.projectiles.wpn_prj_jav = {}
	self.projectiles.wpn_prj_jav.name_id = "bm_wpn_prj_jav"
	self.projectiles.wpn_prj_jav.unit = "units/pd2_dlc_steel/weapons/wpn_prj_jav/wpn_prj_jav"
	self.projectiles.wpn_prj_jav.unit_dummy = "units/pd2_dlc_steel/weapons/wpn_prj_jav/wpn_prj_jav_husk"
	self.projectiles.wpn_prj_jav.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_jav/wpn_prj_jav_local"
	self.projectiles.wpn_prj_jav.icon = "jav_projectile"
	self.projectiles.wpn_prj_jav.throw_shout = true
	self.projectiles.wpn_prj_jav.no_cheat_count = true
	self.projectiles.wpn_prj_jav.impact_detonation = true
	self.projectiles.wpn_prj_jav.client_authoritative = true
	self.projectiles.wpn_prj_jav.add_trail_effect = true
	self.projectiles.wpn_prj_jav.throwable = true
	self.projectiles.wpn_prj_jav.texture_bundle_folder = "steel"
	self.projectiles.wpn_prj_jav.dlc = "steel"
	self.projectiles.wpn_prj_jav.max_amount = 3
	self.projectiles.wpn_prj_jav.anim_global_param = "projectile_jav"
	self.projectiles.wpn_prj_jav.throw_allowed_expire_t = 0.4
	self.projectiles.wpn_prj_jav.expire_t = 1.1
	self.projectiles.wpn_prj_jav.repeat_expire_t = 1
	self.projectiles.arblast_arrow = {}
	self.projectiles.arblast_arrow.unit = "units/pd2_dlc_steel/weapons/wpn_prj_arblast_arrow/wpn_prj_arblast_arrow"
	self.projectiles.arblast_arrow.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_arblast_arrow/wpn_prj_arblast_arrow_local"
	self.projectiles.arblast_arrow.weapon_id = "arblast"
	self.projectiles.arblast_arrow.no_cheat_count = true
	self.projectiles.arblast_arrow.impact_detonation = true
	self.projectiles.arblast_arrow.client_authoritative = true
	self.projectiles.arblast_poison_arrow = {}
	self.projectiles.arblast_poison_arrow.unit = "units/pd2_dlc_steel/weapons/wpn_prj_arblast_poison_arrow/wpn_prj_arblast_poison_arrow"
	self.projectiles.arblast_poison_arrow.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_arblast_poison_arrow/wpn_prj_arblast_poison_arrow_local"
	self.projectiles.arblast_poison_arrow.weapon_id = "arblast"
	self.projectiles.arblast_poison_arrow.no_cheat_count = true
	self.projectiles.arblast_poison_arrow.impact_detonation = true
	self.projectiles.arblast_poison_arrow.client_authoritative = true
	self.projectiles.arblast_arrow_exp = {}
	self.projectiles.arblast_arrow_exp.unit = "units/pd2_dlc_steel/weapons/wpn_prj_arblast_arrow_exp/wpn_prj_arblast_arrow_exp"
	self.projectiles.arblast_arrow_exp.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_arblast_arrow_exp/wpn_prj_arblast_arrow_exp_local"
	self.projectiles.arblast_arrow_exp.weapon_id = "arblast"
	self.projectiles.arblast_arrow_exp.no_cheat_count = true
	self.projectiles.arblast_arrow_exp.impact_detonation = true
	self.projectiles.arblast_arrow_exp.client_authoritative = true
	self.projectiles.frankish_arrow = {}
	self.projectiles.frankish_arrow.unit = "units/pd2_dlc_steel/weapons/wpn_prj_frankish_arrow/wpn_prj_frankish_arrow"
	self.projectiles.frankish_arrow.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_frankish_arrow/wpn_prj_frankish_arrow_local"
	self.projectiles.frankish_arrow.weapon_id = "frankish"
	self.projectiles.frankish_arrow.no_cheat_count = true
	self.projectiles.frankish_arrow.impact_detonation = true
	self.projectiles.frankish_arrow.client_authoritative = true
	self.projectiles.frankish_poison_arrow = {}
	self.projectiles.frankish_poison_arrow.unit = "units/pd2_dlc_steel/weapons/wpn_prj_frankish_poison_arrow/wpn_prj_frankish_poison_arrow"
	self.projectiles.frankish_poison_arrow.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_frankish_poison_arrow/wpn_prj_frankish_poison_arrow_local"
	self.projectiles.frankish_poison_arrow.weapon_id = "frankish"
	self.projectiles.frankish_poison_arrow.no_cheat_count = true
	self.projectiles.frankish_poison_arrow.impact_detonation = true
	self.projectiles.frankish_poison_arrow.client_authoritative = true
	self.projectiles.frankish_arrow_exp = {}
	self.projectiles.frankish_arrow_exp.unit = "units/pd2_dlc_steel/weapons/wpn_prj_frankish_arrow_exp/wpn_prj_frankish_arrow_exp"
	self.projectiles.frankish_arrow_exp.local_unit = "units/pd2_dlc_steel/weapons/wpn_prj_frankish_arrow_exp/wpn_prj_frankish_arrow_exp_local"
	self.projectiles.frankish_arrow_exp.weapon_id = "frankish"
	self.projectiles.frankish_arrow_exp.no_cheat_count = true
	self.projectiles.frankish_arrow_exp.impact_detonation = true
	self.projectiles.frankish_arrow_exp.client_authoritative = true
	self.projectiles.long_arrow = {}
	self.projectiles.long_arrow.unit = "units/pd2_dlc_steel/weapons/wpn_fps_bow_long_pts/wpn_prj_long_arrow"
	self.projectiles.long_arrow.local_unit = "units/pd2_dlc_steel/weapons/wpn_fps_bow_long_pts/wpn_prj_long_arrow_local"
	self.projectiles.long_arrow.weapon_id = "long"
	self.projectiles.long_arrow.no_cheat_count = true
	self.projectiles.long_arrow.impact_detonation = true
	self.projectiles.long_arrow.client_authoritative = true
	self.projectiles.long_poison_arrow = {}
	self.projectiles.long_poison_arrow.unit = "units/pd2_dlc_steel/weapons/wpn_fps_bow_long_pts/wpn_prj_long_poison_arrow"
	self.projectiles.long_poison_arrow.local_unit = "units/pd2_dlc_steel/weapons/wpn_fps_bow_long_pts/wpn_prj_long_poison_arrow_local"
	self.projectiles.long_poison_arrow.weapon_id = "long"
	self.projectiles.long_poison_arrow.no_cheat_count = true
	self.projectiles.long_poison_arrow.impact_detonation = true
	self.projectiles.long_poison_arrow.client_authoritative = true
	self.projectiles.long_arrow_exp = {}
	self.projectiles.long_arrow_exp.unit = "units/pd2_dlc_steel/weapons/wpn_fps_bow_long_pts/wpn_prj_long_arrow_exp"
	self.projectiles.long_arrow_exp.local_unit = "units/pd2_dlc_steel/weapons/wpn_fps_bow_long_pts/wpn_prj_long_arrow_exp_local"
	self.projectiles.long_arrow_exp.weapon_id = "long"
	self.projectiles.long_arrow_exp.no_cheat_count = true
	self.projectiles.long_arrow_exp.impact_detonation = true
	self.projectiles.long_arrow_exp.client_authoritative = true
	self.projectiles.wpn_prj_hur = {}
	self.projectiles.wpn_prj_hur.name_id = "bm_wpn_prj_hur"
	self.projectiles.wpn_prj_hur.unit = "units/pd2_dlc_born/weapons/wpn_fps_mel_hur/wpn_prj_hur"
	self.projectiles.wpn_prj_hur.unit_dummy = "units/pd2_dlc_born/weapons/wpn_fps_mel_hur/wpn_prj_hur_husk"
	self.projectiles.wpn_prj_hur.local_unit = "units/pd2_dlc_born/weapons/wpn_fps_mel_hur/wpn_prj_hur_local"
	self.projectiles.wpn_prj_hur.icon = "throwing_axe"
	self.projectiles.wpn_prj_hur.throw_shout = true
	self.projectiles.wpn_prj_hur.no_cheat_count = true
	self.projectiles.wpn_prj_hur.impact_detonation = true
	self.projectiles.wpn_prj_hur.client_authoritative = true
	self.projectiles.wpn_prj_hur.add_trail_effect = true
	self.projectiles.wpn_prj_hur.throwable = true
	self.projectiles.wpn_prj_hur.texture_bundle_folder = "born"
	self.projectiles.wpn_prj_hur.dlc = "born"
	self.projectiles.wpn_prj_hur.max_amount = 3
	self.projectiles.wpn_prj_hur.anim_global_param = "projectile_four"
	self.projectiles.wpn_prj_hur.throw_allowed_expire_t = 0.15
	self.projectiles.wpn_prj_hur.expire_t = 1.1
	self.projectiles.wpn_prj_hur.repeat_expire_t = 0.5
	self.projectiles.wpn_prj_target = {}
	self.projectiles.wpn_prj_target.name_id = "bm_wpn_prj_target"
	self.projectiles.wpn_prj_target.unit = "units/pd2_dlc_pim/weapons/wpn_prj_target/wpn_prj_target"
	self.projectiles.wpn_prj_target.unit_dummy = "units/pd2_dlc_pim/weapons/wpn_prj_target/wpn_prj_target_husk"
	self.projectiles.wpn_prj_target.local_unit = "units/pd2_dlc_pim/weapons/wpn_prj_target/wpn_prj_target_husk_local"
	self.projectiles.wpn_prj_target.icon = "hobby_knife"
	self.projectiles.wpn_prj_target.throw_shout = true
	self.projectiles.wpn_prj_target.no_cheat_count = true
	self.projectiles.wpn_prj_target.impact_detonation = true
	self.projectiles.wpn_prj_target.client_authoritative = true
	self.projectiles.wpn_prj_target.add_trail_effect = true
	self.projectiles.wpn_prj_target.throwable = true
	self.projectiles.wpn_prj_target.texture_bundle_folder = "pim"
	self.projectiles.wpn_prj_target.dlc = "pim"
	self.projectiles.wpn_prj_target.max_amount = 6
	self.projectiles.wpn_prj_target.anim_global_param = "projectile_target"
	self.projectiles.wpn_prj_target.throw_allowed_expire_t = 0.1
	self.projectiles.wpn_prj_target.expire_t = 0.8
	self.projectiles.wpn_prj_target.repeat_expire_t = 0.6
	self.projectiles.frag_com = {}
	self.projectiles.frag_com.name_id = "bm_grenade_frag_com"
	self.projectiles.frag_com.desc_id = "bm_grenade_frag_com_desc"
	self.projectiles.frag_com.unit = "units/payday2/weapons/wpn_frag_grenade_com/wpn_frag_grenade_com"
	self.projectiles.frag_com.unit_dummy = "units/payday2/weapons/wpn_frag_grenade_com/wpn_frag_grenade_com_husk"
	self.projectiles.frag_com.sprint_unit = "units/payday2/weapons/wpn_frag_grenade_com/wpn_frag_grenade_com_sprint"
	self.projectiles.frag_com.icon = "frag_grenade"
	self.projectiles.frag_com.throwable = true
	self.projectiles.frag_com.max_amount = 3
	self.projectiles.frag_com.animation = "throw_grenade_com"
	self.projectiles.frag_com.anim_global_param = "projectile_frag_com"
	self.projectiles.frag_com.throw_allowed_expire_t = 0.1
	self.projectiles.frag_com.expire_t = 1.1
	self.projectiles.frag_com.repeat_expire_t = 1.5
	self.projectiles.frag_com.is_a_grenade = true
	self.projectiles.frag_com.dlc = "pd2_clan"
	self.projectiles.fir_com = {}
	self.projectiles.fir_com.name_id = "bm_grenade_fir_com"
	self.projectiles.fir_com.desc_id = "bm_grenade_fir_com_desc"
	self.projectiles.fir_com.unit = "units/pd2_dlc_fir/weapons/wpn_fps_gre_white/wpn_third_gre_white"
	self.projectiles.fir_com.unit_dummy = "units/pd2_dlc_fir/weapons/wpn_fps_gre_white/wpn_fps_gre_white_husk"
	self.projectiles.fir_com.sprint_unit = "units/pd2_dlc_fir/weapons/wpn_fps_gre_white/wpn_third_gre_white_sprint"
	self.projectiles.fir_com.icon = "fir_grenade"
	self.projectiles.fir_com.throwable = true
	self.projectiles.fir_com.max_amount = 6
	self.projectiles.fir_com.animation = "throw_concussion"
	self.projectiles.fir_com.anim_global_param = "projectile_frag"
	self.projectiles.fir_com.throw_allowed_expire_t = 0.1
	self.projectiles.fir_com.expire_t = 1.1
	self.projectiles.fir_com.repeat_expire_t = 1.5
	self.projectiles.fir_com.is_a_grenade = true
	self.projectiles.fir_com.dlc = "pd2_clan"
	self.projectiles.fir_com.texture_bundle_folder = "fir"
	self.projectiles.chico_injector = {}
	self.projectiles.chico_injector.name_id = "bm_ability_chico_injector"
	self.projectiles.chico_injector.desc_id = "bm_ability_chico_injector_desc"
	self.projectiles.chico_injector.icon = "chico_injector"
	self.projectiles.chico_injector.ability = "chico_injector"
	self.projectiles.chico_injector.texture_bundle_folder = "chico"
	self.projectiles.chico_injector.dlc = "chico"
	self.projectiles.chico_injector.base_cooldown = 30
	self.projectiles.chico_injector.max_amount = 1
	self.projectiles.chico_injector.sounds = {
		activate = "perkdeck_activate",
		cooldown = "perkdeck_cooldown_over"
	}
	self.projectiles.launcher_m203 = deep_clone(self.projectiles.launcher_frag)
	self.projectiles.launcher_m203.unit = "units/pd2_dlc_chico/weapons/wpn_launcher_frag_m203/wpn_launcher_frag_m203"
	self.projectiles.launcher_m203.add_trail_effect = true
	self.projectiles.launcher_m203.dlc = "chico"
	self.projectiles.launcher_m203.weapon_id = "contraband_m203"
	self.projectiles.launcher_m203.time_cheat = 0.1
	self.projectiles.smoke_screen_grenade = {}
	self.projectiles.smoke_screen_grenade.name_id = "bm_grenade_smoke_screen_grenade"
	self.projectiles.smoke_screen_grenade.desc_id = "bm_grenade_smoke_screen_grenade_desc"
	self.projectiles.smoke_screen_grenade.unit = "units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_third_smoke_screen_grenade"
	self.projectiles.smoke_screen_grenade.unit_dummy = "units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_fps_smoke_screen_grenade_husk"
	self.projectiles.smoke_screen_grenade.sprint_unit = "units/pd2_dlc_max/weapons/wpn_fps_smoke_screen_grenade/wpn_third_smoke_screen_grenade_sprint"
	self.projectiles.smoke_screen_grenade.icon = "smoke_screen_grenade"
	self.projectiles.smoke_screen_grenade.texture_bundle_folder = "max"
	self.projectiles.smoke_screen_grenade.dlc = "max"
	self.projectiles.smoke_screen_grenade.base_cooldown = 30
	self.projectiles.smoke_screen_grenade.max_amount = 1
	self.projectiles.smoke_screen_grenade.is_a_grenade = true
	self.projectiles.smoke_screen_grenade.throwable = true
	self.projectiles.smoke_screen_grenade.no_shouting = true
	self._projectiles_index = {
		"frag",
		"launcher_frag",
		"rocket_frag",
		"molotov",
		"launcher_incendiary",
		"launcher_frag_m32",
		"west_arrow",
		"west_arrow_exp",
		"dynamite",
		"bow_poison_arrow",
		"crossbow_arrow",
		"crossbow_poison_arrow",
		"crossbow_arrow_exp",
		"wpn_prj_four",
		"wpn_prj_ace",
		"wpn_prj_jav",
		"arblast_arrow",
		"arblast_poison_arrow",
		"arblast_arrow_exp",
		"frankish_arrow",
		"frankish_poison_arrow",
		"frankish_arrow_exp",
		"long_arrow",
		"long_poison_arrow",
		"long_arrow_exp",
		"launcher_incendiary_m32",
		"launcher_frag_china",
		"launcher_incendiary_china",
		"wpn_prj_hur",
		"wpn_prj_target",
		"frag_com",
		"concussion",
		"launcher_frag_arbiter",
		"launcher_incendiary_arbiter",
		"chico_injector",
		"launcher_m203",
		"rocket_ray_frag",
		"fir_com",
		"smoke_screen_grenade"
	}
	local free_dlcs = tweak_data:free_dlc_list()
	for _, data in pairs(self.projectiles) do
		if free_dlcs[data.dlc] then
			data.dlc = nil
		end
	end
	self:_add_desc_from_name_macro(self.projectiles)
end

function BlackMarketTweakData:get_projectiles_index()
	return self._projectiles_index
end

function BlackMarketTweakData:get_index_from_projectile_id(projectile_id)
	for index, entry_name in ipairs(self._projectiles_index) do
		if entry_name == projectile_id then
			return index
		end
	end
	return 0
end

function BlackMarketTweakData:get_projectile_name_from_index(index)
	return self._projectiles_index[index]
end
