CarryTweakData = CarryTweakData or class()

function CarryTweakData:init(tweak_data)
	self.value_multiplier = tweak_data.money_manager.bag_value_multiplier
	self.dye = {}
	self.dye.chance = 0.5
	self.dye.value_multiplier = 60
	self.types = {}
	self.types.being = {}
	self.types.being.move_speed_modifier = 0.5
	self.types.being.jump_modifier = 0.5
	self.types.being.can_run = false
	self.types.being.throw_distance_multiplier = 0.5
	self.types.mega_heavy = {}
	self.types.mega_heavy.move_speed_modifier = 0.25
	self.types.mega_heavy.jump_modifier = 0.25
	self.types.mega_heavy.can_run = false
	self.types.mega_heavy.throw_distance_multiplier = 0.125
	self.types.very_heavy = {}
	self.types.very_heavy.move_speed_modifier = 0.25
	self.types.very_heavy.jump_modifier = 0.25
	self.types.very_heavy.can_run = false
	self.types.very_heavy.throw_distance_multiplier = 0.3
	self.types.slightly_very_heavy = deep_clone(self.types.very_heavy)
	self.types.slightly_very_heavy.throw_distance_multiplier = 0.65
	self.types.slightly_very_heavy.move_speed_modifier = 0.5
	self.types.heavy = {}
	self.types.heavy.move_speed_modifier = 0.5
	self.types.heavy.jump_modifier = 0.5
	self.types.heavy.can_run = false
	self.types.heavy.throw_distance_multiplier = 0.5
	self.types.medium = {}
	self.types.medium.move_speed_modifier = 0.75
	self.types.medium.jump_modifier = 1
	self.types.medium.can_run = false
	self.types.medium.throw_distance_multiplier = 1
	self.types.light = {}
	self.types.light.move_speed_modifier = 1
	self.types.light.jump_modifier = 1
	self.types.light.can_run = true
	self.types.light.throw_distance_multiplier = 1
	self.types.coke_light = {}
	self.types.coke_light.move_speed_modifier = self.types.light.move_speed_modifier
	self.types.coke_light.jump_modifier = self.types.light.jump_modifier
	self.types.coke_light.can_run = self.types.light.can_run
	self.types.coke_light.throw_distance_multiplier = self.types.light.throw_distance_multiplier
	self.types.explosives = deep_clone(self.types.medium)
	self.types.explosives.can_explode = true
	self.small_loot = {}
	self.small_loot.money_bundle = tweak_data:get_value("money_manager", "small_loot", "money_bundle")
	self.small_loot.ring_band = tweak_data:get_value("money_manager", "small_loot", "ring_band")
	self.small_loot.diamondheist_vault_bust = tweak_data:get_value("money_manager", "small_loot", "diamondheist_vault_bust")
	self.small_loot.diamondheist_vault_diamond = tweak_data:get_value("money_manager", "small_loot", "diamondheist_vault_diamond")
	self.small_loot.diamondheist_big_diamond = tweak_data:get_value("money_manager", "small_loot", "diamondheist_big_diamond")
	self.small_loot.mus_small_artifact = tweak_data:get_value("money_manager", "small_loot", "mus_small_artifact")
	self.small_loot.value_gold = tweak_data:get_value("money_manager", "small_loot", "value_gold")
	self.small_loot.gen_atm = tweak_data:get_value("money_manager", "small_loot", "gen_atm")
	self.small_loot.special_deposit_box = tweak_data:get_value("money_manager", "small_loot", "special_deposit_box")
	self.small_loot.slot_machine_payout = tweak_data:get_value("money_manager", "small_loot", "slot_machine_payout")
	self.small_loot.vault_loot_chest = tweak_data:get_value("money_manager", "small_loot", "vault_loot_chest")
	self.small_loot.vault_loot_diamond_chest = tweak_data:get_value("money_manager", "small_loot", "vault_loot_diamond_chest")
	self.small_loot.vault_loot_banknotes = tweak_data:get_value("money_manager", "small_loot", "vault_loot_banknotes")
	self.small_loot.vault_loot_silver = tweak_data:get_value("money_manager", "small_loot", "vault_loot_silver")
	self.small_loot.vault_loot_diamond_collection = tweak_data:get_value("money_manager", "small_loot", "vault_loot_diamond_collection")
	self.small_loot.vault_loot_trophy = tweak_data:get_value("money_manager", "small_loot", "vault_loot_trophy")
	self.small_loot.money_wrap_single_bundle_vscaled = tweak_data:get_value("money_manager", "small_loot", "money_wrap_single_bundle_vscaled")
	self.small_loot.spawn_bucket_of_money = tweak_data:get_value("money_manager", "small_loot", "spawn_bucket_of_money")
	self.small_loot.vault_loot_gold = tweak_data:get_value("money_manager", "small_loot", "vault_loot_gold")
	self.small_loot.vault_loot_cash = tweak_data:get_value("money_manager", "small_loot", "vault_loot_cash")
	self.small_loot.vault_loot_coins = tweak_data:get_value("money_manager", "small_loot", "vault_loot_coins")
	self.small_loot.vault_loot_ring = tweak_data:get_value("money_manager", "small_loot", "vault_loot_ring")
	self.small_loot.vault_loot_jewels = tweak_data:get_value("money_manager", "small_loot", "vault_loot_jewels")
	self.small_loot.vault_loot_macka = tweak_data:get_value("money_manager", "small_loot", "vault_loot_macka")
	self.gold = {}
	self.gold.type = "heavy"
	self.gold.name_id = "hud_carry_gold"
	self.gold.bag_value = "gold"
	self.gold.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.gold.AI_carry = {SO_category = "enemies"}
	self.money = {}
	self.money.type = "medium"
	self.money.name_id = "hud_carry_money"
	self.money.bag_value = "money"
	self.money.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.money.dye = true
	self.money.AI_carry = {SO_category = "enemies"}
	self.diamonds = {}
	self.diamonds.type = "light"
	self.diamonds.name_id = "hud_carry_diamonds"
	self.diamonds.bag_value = "diamonds"
	self.diamonds.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.diamonds.AI_carry = {SO_category = "enemies"}
	self.painting = {}
	self.painting.type = "light"
	self.painting.name_id = "hud_carry_painting"
	self.painting.bag_value = "painting"
	self.painting.unit = "units/payday2/pickups/gen_pku_canvasbag/gen_pku_canvasbag"
	self.painting.visual_unit_name = "units/payday2/characters/npc_acc_canvas_bag_1/npc_acc_canvas_bag_1"
	self.painting.AI_carry = {SO_category = "enemies"}
	self.coke = {}
	self.coke.type = "coke_light"
	self.coke.name_id = "hud_carry_coke"
	self.coke.bag_value = "coke"
	self.coke.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.coke.AI_carry = {SO_category = "enemies"}
	self.meth = {}
	self.meth.type = "coke_light"
	self.meth.name_id = "hud_carry_meth"
	self.meth.bag_value = "meth"
	self.meth.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.meth.AI_carry = {SO_category = "enemies"}
	self.lance_bag = {}
	self.lance_bag.type = "medium"
	self.lance_bag.name_id = "hud_carry_lance_bag"
	self.lance_bag.skip_exit_secure = true
	self.lance_bag.unit = "units/payday2/pickups/gen_pku_toolbag/gen_pku_toolbag"
	self.lance_bag.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_1/npc_acc_tools_bag_1"
	self.lance_bag_large = {}
	self.lance_bag_large.type = "heavy"
	self.lance_bag_large.name_id = "hud_carry_huge_bag"
	self.lance_bag_large.skip_exit_secure = true
	self.lance_bag_large.unit = "units/payday2/pickups/gen_pku_toolbag_large/gen_pku_toolbag_large"
	self.lance_bag_large.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_large_1/npc_acc_tools_bag_large_1"
	self.cage_bag = {}
	self.cage_bag.type = "medium"
	self.cage_bag.name_id = "hud_carry_cage_bag"
	self.cage_bag.skip_exit_secure = true
	self.cage_bag.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.cage_bag.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.weapon = {}
	self.weapon.type = "heavy"
	self.weapon.name_id = "hud_carry_weapon"
	self.weapon.bag_value = "weapons"
	self.weapon.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.weapons = {}
	self.weapons.type = "heavy"
	self.weapons.bag_value = "weapons"
	self.weapons.name_id = "hud_carry_weapons"
	self.weapons.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.grenades = {}
	self.grenades.type = "explosives"
	self.grenades.name_id = "hud_carry_grenades"
	self.grenades.bag_value = "weapons"
	self.grenades.unit = "units/pd2_dlc1/pickups/gen_pku_explosivesbag/gen_pku_explosivesbag"
	self.grenades.visual_unit_name = "units/payday2/characters/npc_acc_explosives_bag_1/npc_acc_explosives_bag_1"
	self.grenades.AI_carry = {SO_category = "enemies"}
	self.person = {}
	self.person.type = "being"
	self.person.name_id = "hud_carry_person"
	self.person.unit = "units/payday2/pickups/gen_pku_bodybag/gen_pku_bodybag"
	self.person.visual_unit_name = "units/payday2/characters/npc_acc_body_bag_1/npc_acc_body_bag_1"
	self.person.default_value = 1
	self.person.is_unique_loot = true
	self.person.skip_exit_secure = true
	self.special_person = {}
	self.special_person.type = "being"
	self.special_person.name_id = "hud_carry_special_person"
	self.special_person.unit = "units/payday2/pickups/gen_pku_bodybag/gen_pku_bodybag"
	self.special_person.visual_unit_name = "units/payday2/characters/npc_acc_body_bag_1/npc_acc_body_bag_1"
	self.special_person.default_value = 1
	self.special_person.is_unique_loot = true
	self.special_person.skip_exit_secure = true
	self.circuit = {}
	self.circuit.type = "heavy"
	self.circuit.name_id = "hud_carry_circuit"
	self.circuit.bag_value = "circuit"
	self.circuit.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_01 = {}
	self.engine_01.type = "heavy"
	self.engine_01.name_id = "hud_carry_engine_1"
	self.engine_01.skip_exit_secure = true
	self.engine_01.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_01.AI_carry = {SO_category = "enemies"}
	self.engine_02 = {}
	self.engine_02.type = "heavy"
	self.engine_02.name_id = "hud_carry_engine_2"
	self.engine_02.skip_exit_secure = true
	self.engine_02.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_02.AI_carry = {SO_category = "enemies"}
	self.engine_03 = {}
	self.engine_03.type = "heavy"
	self.engine_03.name_id = "hud_carry_engine_3"
	self.engine_03.skip_exit_secure = true
	self.engine_03.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_03.AI_carry = {SO_category = "enemies"}
	self.engine_04 = {}
	self.engine_04.type = "heavy"
	self.engine_04.name_id = "hud_carry_engine_4"
	self.engine_04.skip_exit_secure = true
	self.engine_04.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_04.AI_carry = {SO_category = "enemies"}
	self.engine_05 = {}
	self.engine_05.type = "heavy"
	self.engine_05.name_id = "hud_carry_engine_5"
	self.engine_05.skip_exit_secure = true
	self.engine_05.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_05.AI_carry = {SO_category = "enemies"}
	self.engine_06 = {}
	self.engine_06.type = "heavy"
	self.engine_06.name_id = "hud_carry_engine_6"
	self.engine_06.skip_exit_secure = true
	self.engine_06.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_06.AI_carry = {SO_category = "enemies"}
	self.engine_07 = {}
	self.engine_07.type = "heavy"
	self.engine_07.name_id = "hud_carry_engine_7"
	self.engine_07.skip_exit_secure = true
	self.engine_07.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_07.AI_carry = {SO_category = "enemies"}
	self.engine_08 = {}
	self.engine_08.type = "heavy"
	self.engine_08.name_id = "hud_carry_engine_8"
	self.engine_08.skip_exit_secure = true
	self.engine_08.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_08.AI_carry = {SO_category = "enemies"}
	self.engine_09 = {}
	self.engine_09.type = "heavy"
	self.engine_09.name_id = "hud_carry_engine_9"
	self.engine_09.skip_exit_secure = true
	self.engine_09.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_09.AI_carry = {SO_category = "enemies"}
	self.engine_10 = {}
	self.engine_10.type = "heavy"
	self.engine_10.name_id = "hud_carry_engine_10"
	self.engine_10.skip_exit_secure = true
	self.engine_10.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_10.AI_carry = {SO_category = "enemies"}
	self.engine_11 = {}
	self.engine_11.type = "heavy"
	self.engine_11.name_id = "hud_carry_engine_11"
	self.engine_11.skip_exit_secure = true
	self.engine_11.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_11.AI_carry = {SO_category = "enemies"}
	self.engine_12 = {}
	self.engine_12.type = "heavy"
	self.engine_12.name_id = "hud_carry_engine_12"
	self.engine_12.skip_exit_secure = true
	self.engine_12.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.engine_12.AI_carry = {SO_category = "enemies"}
	self.turret = {}
	self.turret.type = "heavy"
	self.turret.name_id = "hud_carry_turret"
	self.turret.bag_value = "turret"
	self.turret.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.turret.AI_carry = {SO_category = "enemies"}
	self.ammo = {}
	self.ammo.type = "medium"
	self.ammo.name_id = "hud_carry_ammo"
	self.ammo.bag_value = "shells"
	self.ammo.unit = "units/pd2_dlc1/pickups/gen_pku_explosivesbag/gen_pku_explosivesbag"
	self.ammo.visual_unit_name = "units/payday2/characters/npc_acc_explosives_bag_1/npc_acc_explosives_bag_1"
	self.ammo.AI_carry = {SO_category = "enemies"}
	self.artifact_statue = {}
	self.artifact_statue.type = "very_heavy"
	self.artifact_statue.name_id = "hud_carry_artifact"
	self.artifact_statue.bag_value = "artifact_statue"
	self.artifact_statue.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.artifact_statue.AI_carry = {SO_category = "enemies"}
	self.mus_artifact = {}
	self.mus_artifact.type = "medium"
	self.mus_artifact.name_id = "hud_carry_artifact"
	self.mus_artifact.bag_value = "mus_artifact_bag"
	self.mus_artifact.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.mus_artifact.AI_carry = {SO_category = "enemies"}
	self.mus_artifact_paint = {}
	self.mus_artifact_paint.type = "light"
	self.mus_artifact_paint.name_id = "hud_carry_artifact"
	self.mus_artifact_paint.bag_value = "mus_artifact_bag"
	self.mus_artifact_paint.unit = "units/payday2/pickups/gen_pku_canvasbag/gen_pku_canvasbag"
	self.mus_artifact_paint.visual_unit_name = "units/payday2/characters/npc_acc_canvas_bag_1/npc_acc_canvas_bag_1"
	self.mus_artifact_paint.AI_carry = {SO_category = "enemies"}
	self.samurai_suit = {}
	self.samurai_suit.type = "medium"
	self.samurai_suit.name_id = "hud_carry_samurai"
	self.samurai_suit.bag_value = "samurai_suit"
	self.samurai_suit.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.samurai_suit.AI_carry = {SO_category = "enemies"}
	self.equipment_bag = {}
	self.equipment_bag.type = "medium"
	self.equipment_bag.name_id = "hud_carry_equipment_bag"
	self.equipment_bag.skip_exit_secure = true
	self.equipment_bag.unit = "units/payday2/pickups/gen_pku_toolbag/gen_pku_toolbag"
	self.equipment_bag.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_1/npc_acc_tools_bag_1"
	self.coke_pure = {}
	self.coke_pure.type = "coke_light"
	self.coke_pure.name_id = "hud_carry_coke_pure"
	self.coke_pure.bag_value = "coke_pure"
	self.coke_pure.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.coke_pure.AI_carry = {SO_category = "enemies"}
	self.evidence_bag = {}
	self.evidence_bag.type = "light"
	self.evidence_bag.name_id = "hud_carry_evidence_bag"
	self.evidence_bag.bag_value = "evidence_bag"
	self.evidence_bag.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.evidence_bag.AI_carry = {SO_category = "enemies"}
	self.sandwich = {}
	self.sandwich.type = "very_heavy"
	self.sandwich.name_id = "hud_carry_sandwich"
	self.sandwich.bag_value = "sandwich"
	self.sandwich.AI_carry = {SO_category = "enemies"}
	self.sandwich.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.sandwich.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.hope_diamond = {}
	self.hope_diamond.type = "coke_light"
	self.hope_diamond.name_id = "hud_carry_hope_diamond"
	self.hope_diamond.bag_value = "hope_diamond"
	self.hope_diamond.AI_carry = {SO_category = "enemies"}
	self.hope_diamond.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.hope_diamond.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.cro_loot1 = {}
	self.cro_loot1.type = "medium"
	self.cro_loot1.name_id = "hud_carry_cro_loot"
	self.cro_loot1.bag_value = "cro_loot"
	self.cro_loot1.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.cro_loot1.AI_carry = {SO_category = "enemies"}
	self.cro_loot2 = {}
	self.cro_loot2.type = "heavy"
	self.cro_loot2.name_id = "hud_carry_cro_loot"
	self.cro_loot2.bag_value = "cro_loot"
	self.cro_loot2.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.cro_loot2.AI_carry = {SO_category = "enemies"}
	self.ladder_bag = {}
	self.ladder_bag.type = "light"
	self.ladder_bag.name_id = "hud_carry_ladder_bag"
	self.ladder_bag.skip_exit_secure = true
	self.ladder_bag.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.ladder_bag.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.ladder_bag.AI_carry = {SO_category = "enemies"}
	self.vehicle_falcogini = {}
	self.vehicle_falcogini.type = "light"
	self.vehicle_falcogini.name_id = "hud_carry_vehicle_falcogini"
	self.vehicle_falcogini.skip_exit_secure = false
	self.vehicle_falcogini.is_vehicle = true
	self.vehicle_falcogini.visual_object = ""
	self.vehicle_falcogini.unit = ""
	self.vehicle_falcogini.bag_value = "vehicle_falcogini"
	self.vehicle_falcogini.AI_carry = {SO_category = ""}
	self.warhead = {}
	self.warhead.type = "very_heavy"
	self.warhead.name_id = "hud_carry_warhead"
	self.warhead.bag_value = "warhead"
	self.warhead.unit = "units/pd2_dlc1/pickups/gen_pku_explosivesbag/gen_pku_explosivesbag"
	self.warhead.visual_unit_name = "units/payday2/characters/npc_acc_explosives_bag_1/npc_acc_explosives_bag_1"
	self.winch_part = {}
	self.winch_part.type = "heavy"
	self.winch_part.name_id = "hud_carry_winch_bag"
	self.winch_part.skip_exit_secure = true
	self.winch_part.unit = "units/payday2/pickups/gen_pku_toolbag_large/gen_pku_toolbag_large"
	self.winch_part.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_large_1/npc_acc_tools_bag_large_1"
	self.fireworks = {}
	self.fireworks.type = "light"
	self.fireworks.name_id = "hud_carry_fireworks_bag"
	self.fireworks.skip_exit_secure = true
	self.fireworks.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.fireworks.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.watertank_empty = {}
	self.watertank_empty.type = "light"
	self.watertank_empty.name_id = "hud_carry_watertank_empty_bag"
	self.watertank_empty.skip_exit_secure = true
	self.watertank_empty.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.watertank_empty.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.watertank_full = {}
	self.watertank_full.type = "heavy"
	self.watertank_full.name_id = "hud_carry_watertank_full_bag"
	self.watertank_full.skip_exit_secure = true
	self.watertank_full.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.watertank_full.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.unknown = {}
	self.unknown.type = "heavy"
	self.unknown.name_id = "hud_carry_???"
	self.unknown.skip_exit_secure = false
	self.unknown.AI_carry = {SO_category = "enemies"}
	self.unknown.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.unknown.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.safe_wpn = {}
	self.safe_wpn.type = "slightly_very_heavy"
	self.safe_wpn.name_id = "hud_carry_safe"
	self.safe_wpn.unit = "units/pd2_dlc_jolly/pickups/gen_pku_safe_wpn_bag/gen_pku_safe_wpn_bag"
	self.safe_wpn.visual_unit_name = "units/payday2/characters/npc_acc_safe_wpn_1/npc_acc_safe_wpn_1"
	self.safe_ovk = {}
	self.safe_ovk.type = "slightly_very_heavy"
	self.safe_ovk.name_id = "hud_carry_compl_ovk_safe"
	self.safe_ovk.unit = "units/pd2_dlc_jolly/pickups/gen_pku_safe_ovk_bag/gen_pku_safe_ovk_bag"
	self.safe_ovk.visual_unit_name = "units/payday2/characters/npc_acc_safe_ovk_1/npc_acc_safe_ovk_1"
	self.safe_secure_dummy = {}
	self.safe_secure_dummy.type = "slightly_very_heavy"
	self.safe_secure_dummy.name_id = "hud_carry_safe"
	self.safe_secure_dummy.bag_value = "safe"
	self.safe_secure_dummy.unit = "units/pd2_dlc_jolly/pickups/gen_safe_secure_dummy/gen_safe_secure_dummy"
	self.safe_secure_dummy.visual_unit_name = "units/payday2/characters/npc_acc_safe_wpn_1/npc_acc_safe_wpn_1"
	self.din_pig = {}
	self.din_pig.type = "heavy"
	self.din_pig.name_id = "hud_carry_pig"
	self.din_pig.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.din_pig.AI_carry = {SO_category = "enemies"}
	self.nail_muriatic_acid = {}
	self.nail_muriatic_acid.type = "light"
	self.nail_muriatic_acid.name_id = "hud_int_equipment_acid"
	self.nail_muriatic_acid.skip_exit_secure = true
	self.nail_muriatic_acid.unit = "units/payday2/pickups/gen_pku_toolbag/gen_pku_toolbag"
	self.nail_muriatic_acid.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_1/npc_acc_tools_bag_1"
	self.nail_muriatic_acid.AI_carry = {SO_category = "enemies"}
	self.nail_caustic_soda = {}
	self.nail_caustic_soda.type = "light"
	self.nail_caustic_soda.name_id = "hud_int_equipment_caustic_soda"
	self.nail_caustic_soda.skip_exit_secure = true
	self.nail_caustic_soda.unit = "units/payday2/pickups/gen_pku_toolbag_large/gen_pku_toolbag_large"
	self.nail_caustic_soda.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_large_1/npc_acc_tools_bag_large_1"
	self.nail_caustic_soda.AI_carry = {SO_category = "enemies"}
	self.nail_hydrogen_chloride = {}
	self.nail_hydrogen_chloride.type = "light"
	self.nail_hydrogen_chloride.name_id = "hud_int_equipment_hydrogen_chloride"
	self.nail_hydrogen_chloride.skip_exit_secure = true
	self.nail_hydrogen_chloride.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.nail_hydrogen_chloride.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.nail_hydrogen_chloride.AI_carry = {SO_category = "enemies"}
	self.nail_euphadrine_pills = {}
	self.nail_euphadrine_pills.type = "light"
	self.nail_euphadrine_pills.name_id = "hud_carry_euphadrine_pills"
	self.nail_euphadrine_pills.skip_exit_secure = true
	self.nail_euphadrine_pills.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.nail_euphadrine_pills.AI_carry = {SO_category = "enemies"}
	self.meth_half = {}
	self.meth_half.type = "coke_light"
	self.meth_half.name_id = "hud_carry_meth"
	self.meth_half.bag_value = "meth_half"
	self.meth_half.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.meth_half.AI_carry = {SO_category = "enemies"}
	self.equipment_bag_global_event = {}
	self.equipment_bag_global_event.type = "medium"
	self.equipment_bag_global_event.name_id = "hud_carry_equipment_bag"
	self.equipment_bag_global_event.skip_exit_secure = true
	self.equipment_bag_global_event.unit = "units/pd2_dlc_cane/pickups/gen_pku_toolbag_global_event/gen_pku_toolbag_global_event"
	self.equipment_bag_global_event.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_1/npc_acc_tools_bag_1"
	self.present = {}
	self.present.type = "coke_light"
	self.present.name_id = "hud_carry_present"
	self.present.bag_value = "present"
	self.present.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.present.AI_carry = {SO_category = "enemies"}
	self.paper_roll = {}
	self.paper_roll.type = "medium"
	self.paper_roll.name_id = "hud_carry_paper_roll"
	self.paper_roll.skip_exit_secure = true
	self.paper_roll.unit = "units/payday2/pickups/gen_pku_toolbag/gen_pku_toolbag"
	self.paper_roll.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_1/npc_acc_tools_bag_1"
	self.counterfeit_money = {}
	self.counterfeit_money.type = "medium"
	self.counterfeit_money.name_id = "hud_carry_counterfeit_money"
	self.counterfeit_money.bag_value = "counterfeit_money"
	self.counterfeit_money.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.counterfeit_money.AI_carry = {SO_category = "enemies"}
	self.goat = {}
	self.goat.type = "medium"
	self.goat.name_id = "hud_carry_goat"
	self.goat.unit = "units/pd2_dlc_peta/pickups/pta_pku_goatbag/pta_pku_goatbag"
	self.goat.visual_unit_name = "units/pd2_dlc_peta/characters/npc_acc_goat_bag_1/npc_acc_goat_bag_1"
	self.goat.AI_carry = {SO_category = "enemies"}
	self.masterpiece_painting = {}
	self.masterpiece_painting.type = "light"
	self.masterpiece_painting.name_id = "hud_carry_masterpiece_painting"
	self.masterpiece_painting.bag_value = "masterpiece_painting"
	self.masterpiece_painting.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.masterpiece_painting.AI_carry = {SO_category = "enemies"}
	self.breaching_charges = {}
	self.breaching_charges.type = "medium"
	self.breaching_charges.name_id = "hud_carry_breaching_charges"
	self.breaching_charges.skip_exit_secure = true
	self.breaching_charges.unit = "units/payday2/pickups/gen_pku_toolbag/gen_pku_toolbag"
	self.breaching_charges.visual_unit_name = "units/payday2/characters/npc_acc_tools_bag_1/npc_acc_tools_bag_1"
	self.prototype = {}
	self.prototype.type = "medium"
	self.prototype.name_id = "hud_carry_prototype"
	self.prototype.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.prototype.AI_carry = {SO_category = "enemies"}
	self.master_server = {}
	self.master_server.type = "heavy"
	self.master_server.name_id = "hud_carry_master_server"
	self.master_server.bag_value = "master_server"
	self.master_server.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.master_server.AI_carry = {SO_category = "enemies"}
	self.lost_artifact = {}
	self.lost_artifact.type = "medium"
	self.lost_artifact.name_id = "hud_carry_lost_artifact"
	self.lost_artifact.bag_value = "lost_artifact"
	self.lost_artifact.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.lost_artifact.AI_carry = {SO_category = "enemies"}
	self.parachute = {}
	self.parachute.type = "light"
	self.parachute.name_id = "hud_carry_parachute"
	self.parachute.skip_exit_secure = true
	self.parachute.visual_unit_name = "units/pd2_dlc_jerry/characters/npc_acc_parachute_1/npc_acc_parachute_1"
	self.parachute.unit = "units/pd2_dlc_jerry/pickups/gen_pku_parachute_bag/gen_pku_parachute_bag"
	self.parachute.AI_carry = {SO_category = "enemies"}
	self.drk_bomb_part = {}
	self.drk_bomb_part.type = "medium"
	self.drk_bomb_part.name_id = "hud_carry_cro_loot"
	self.drk_bomb_part.bag_value = "drk_bomb_part"
	self.drk_bomb_part.unit = "units/pd2_dlc1/pickups/gen_pku_explosivesbag/gen_pku_explosivesbag"
	self.drk_bomb_part.visual_unit_name = "units/payday2/characters/npc_acc_explosives_bag_1/npc_acc_explosives_bag_1"
	self.drk_bomb_part.AI_carry = {SO_category = "enemies"}
	self.weapon_glock = {}
	self.weapon_glock.type = "light"
	self.weapon_glock.name_id = "hud_carry_weapon_glock"
	self.weapon_glock.bag_value = "weapon_glock"
	self.weapon_glock.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.weapon_scar = {}
	self.weapon_scar.type = "medium"
	self.weapon_scar.name_id = "hud_carry_weapon_scar"
	self.weapon_scar.bag_value = "weapon_scar"
	self.weapon_scar.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.mad_master_server_value_1 = {}
	self.mad_master_server_value_1.type = "heavy"
	self.mad_master_server_value_1.name_id = "hud_carry_master_server"
	self.mad_master_server_value_1.bag_value = "mad_master_server_value_1"
	self.mad_master_server_value_1.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.mad_master_server_value_1.AI_carry = {SO_category = "enemies"}
	self.mad_master_server_value_2 = {}
	self.mad_master_server_value_2.type = "heavy"
	self.mad_master_server_value_2.name_id = "hud_carry_master_server"
	self.mad_master_server_value_2.bag_value = "mad_master_server_value_2"
	self.mad_master_server_value_2.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.mad_master_server_value_2.AI_carry = {SO_category = "enemies"}
	self.mad_master_server_value_3 = {}
	self.mad_master_server_value_3.type = "heavy"
	self.mad_master_server_value_3.name_id = "hud_carry_master_server"
	self.mad_master_server_value_3.bag_value = "mad_master_server_value_3"
	self.mad_master_server_value_3.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.mad_master_server_value_3.AI_carry = {SO_category = "enemies"}
	self.mad_master_server_value_4 = {}
	self.mad_master_server_value_4.type = "heavy"
	self.mad_master_server_value_4.name_id = "hud_carry_master_server"
	self.mad_master_server_value_4.bag_value = "mad_master_server_value_4"
	self.mad_master_server_value_4.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.mad_master_server_value_4.AI_carry = {SO_category = "enemies"}
	self.bike_part_light = {}
	self.bike_part_light.type = "light"
	self.bike_part_light.name_id = "hud_carry_bike_part"
	self.bike_part_light.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.bike_part_light.AI_carry = {SO_category = "enemies"}
	self.bike_part_heavy = {}
	self.bike_part_heavy.type = "heavy"
	self.bike_part_heavy.name_id = "hud_carry_bike_part"
	self.bike_part_heavy.visual_unit_name = "units/payday2/characters/npc_acc_loot_bag_1/npc_acc_loot_bag_1"
	self.bike_part_heavy.AI_carry = {SO_category = "enemies"}
	self.drone_control_helmet = {}
	self.drone_control_helmet.type = "light"
	self.drone_control_helmet.name_id = "hud_carry_helmet"
	self.drone_control_helmet.bag_value = "mad_master_server_value_4"
	self.drone_control_helmet.unit = "units/payday2/pickups/gen_pku_cage_bag/gen_pku_cage_bag"
	self.drone_control_helmet.visual_unit_name = "units/payday2/characters/npc_acc_cage_bag_1/npc_acc_cage_bag_1"
	self.drone_control_helmet.AI_carry = {SO_category = "enemies"}
end

function CarryTweakData:get_carry_ids()
	local t = {}
	for id, _ in pairs(tweak_data.carry) do
		if type(tweak_data.carry[id]) == "table" and tweak_data.carry[id].type then
			table.insert(t, id)
		end
	end
	table.sort(t)
	return t
end

function CarryTweakData:get_zipline_offset(carry_id)
	local unit_name = tweak_data.carry[carry_id].unit or "units/payday2/pickups/gen_pku_lootbag/gen_pku_lootbag"
	if unit_name == "units/payday2/pickups/gen_pku_bodybag/gen_pku_bodybag" then
		return Vector3(0, 0, -17)
	elseif unit_name == "units/payday2/pickups/gen_pku_canvasbag/gen_pku_canvasbag" then
		return Vector3(0, 0, 0)
	end
	return Vector3(15, 0, -8)
end
