MissionDoorTweakData = MissionDoorTweakData or class()

function MissionDoorTweakData:init()
	self.default = {}
	self.default.devices = {}
	self.default.devices.drill = {
		{
			align = "a_drill_1",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 20
		},
		{
			align = "a_drill_2",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small")
		}
	}
	self.default.devices.c4 = {
		{
			align = "a_c4_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_c4_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_c4_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.test = deep_clone(self.default)
	self.bank_door_test = {}
	self.bank_door_test.devices = {}
	self.bank_door_test.devices.drill = {
		{
			align = "a_drill_a",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 20
		}
	}
	self.crossing_armored_vehicle = {}
	self.crossing_armored_vehicle.devices = {}
	self.crossing_armored_vehicle.devices.drill = {
		{
			align = "a_drill_1",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 180
		}
	}
	self.reinforced_door = {}
	self.reinforced_door.devices = {}
	self.reinforced_door.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.reinforced_door_single = {}
	self.reinforced_door_single.devices = {}
	self.reinforced_door_single.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge_single")
		}
	}
	self.reinforced_door_mcm = {}
	self.reinforced_door_mcm.devices = {}
	self.reinforced_door_mcm.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.reinforced_door_mcm_single = {}
	self.reinforced_door_mcm_single.devices = {}
	self.reinforced_door_mcm_single.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.keycard_door = {}
	self.keycard_door.devices = {}
	self.keycard_door.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.keycard_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 180
		}
	}
	self.keycard_door.devices.key = {
		{
			align = "a_keycard",
			unit = Idstring("units/payday2/equipment/gen_interactable_panel_keycard/gen_interactable_panel_keycard")
		}
	}
	self.keycard_door.devices.ecm = {
		{
			align = "a_ecm_hack",
			unit = Idstring("units/payday2/equipment/gen_interactable_door_keycard/gen_interactable_door_keycard_jammer")
		}
	}
	self.drill_door = {}
	self.drill_door.devices = {}
	self.drill_door.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.drill_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 120
		}
	}
	self.keycard_door_single = {}
	self.keycard_door_single.devices = {}
	self.keycard_door_single.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge_single")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge_single")
		}
	}
	self.keycard_door_single.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small_jam_once"),
			can_jam = true,
			timer = 60
		}
	}
	self.keycard_door_single.devices.key = {
		{
			align = "a_keycard",
			unit = Idstring("units/payday2/equipment/gen_interactable_panel_keycard/gen_interactable_panel_keycard")
		}
	}
	self.keycard_door_single.devices.ecm = {
		{
			align = "a_ecm_hack",
			unit = Idstring("units/payday2/equipment/gen_interactable_door_keycard/gen_interactable_door_keycard_jammer")
		}
	}
	self.keycard_ecm = {}
	self.keycard_ecm.devices = {}
	self.keycard_ecm.devices.key = {
		{
			align = "a_keycard",
			unit = Idstring("units/payday2/equipment/gen_interactable_panel_keycard/item_panel_keycard_double")
		}
	}
	self.keycard_ecm.devices.ecm = {
		{
			align = "a_ecm_hack",
			unit = Idstring("units/payday2/equipment/gen_interactable_door_keycard/item_door_keycard_jammer_double")
		}
	}
	self.atm = {}
	self.atm.devices = {}
	self.atm.devices.ecm = {
		{
			align = "a_ecm_hack",
			unit = Idstring("units/payday2/props/gen_prop_bank_atm_standing/gen_prop_bank_atm_jammer")
		}
	}
	self.safe_small = {}
	self.safe_small.devices = {}
	self.safe_small.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 180
		}
	}
	self.safe_small.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.safe_small_titan = {}
	self.safe_small_titan.devices = {}
	self.safe_small_titan.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 240
		}
	}
	self.safe_medium = {}
	self.safe_medium.devices = {}
	self.safe_medium.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 240
		}
	}
	self.safe_medium.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.safe_medium_titan = {}
	self.safe_medium_titan.devices = {}
	self.safe_medium_titan.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 300
		}
	}
	self.safe_large = {}
	self.safe_large.devices = {}
	self.safe_large.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 300
		}
	}
	self.safe_large.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.safe_giga = {}
	self.safe_giga.devices = {}
	self.safe_giga.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 300
		}
	}
	self.safe_giga.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_4",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.safe_giga_titan = {}
	self.safe_giga_titan.devices = {}
	self.safe_giga_titan.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 360
		}
	}
	self.safe = {}
	self.safe.devices = {}
	self.safe.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 300
		}
	}
	self.safe.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_4",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.safe_titan = {}
	self.safe_titan.devices = {}
	self.safe_titan.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 360
		}
	}
	self.safe_deposit_titan = {}
	self.safe_deposit_titan.devices = {}
	self.safe_deposit_titan.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 666
		}
	}
	self.safe_deposit_titan2 = {}
	self.safe_deposit_titan2.devices = {}
	self.safe_deposit_titan2.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 300
		}
	}
	self.security_panel = {}
	self.security_panel.devices = {}
	self.security_panel.devices.ecm = {
		{
			align = "a_ecm_hack",
			unit = Idstring("units/payday2/equipment/gen_interactable_door_keycard/gen_interactable_door_keycard_jammer")
		}
	}
	self.vault_door = {}
	self.vault_door.devices = {}
	self.vault_door.devices.drill = {
		{
			align = "a_lance_1",
			unit = Idstring("units/payday2/equipment/gen_interactable_drill_large_thermic/gen_interactable_drill_large_thermic"),
			can_jam = true,
			timer = 360
		}
	}
	self.train_door = {}
	self.train_door.devices = {}
	self.train_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 60
		}
	}
	self.shape_and_drill = {}
	self.shape_and_drill.devices = {}
	self.shape_and_drill.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 180
		}
	}
	self.shape_and_drill.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.shape_and_drill_30 = {}
	self.shape_and_drill_30.devices = {}
	self.shape_and_drill_30.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = false,
			timer = 30
		}
	}
	self.shape_and_drill_30.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.drill = {}
	self.drill.devices = {}
	self.drill.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 60
		}
	}
	self.drill_120 = {}
	self.drill_120.devices = {}
	self.drill_120.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 120
		}
	}
	self.truck = {}
	self.truck.devices = {}
	self.truck.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 120
		}
	}
	self.truck.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.arm_trans = {}
	self.arm_trans.devices = {}
	self.arm_trans.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 200
		}
	}
	self.arm_trans.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_4",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.train_cargo_door = {}
	self.train_cargo_door.devices = {}
	self.train_cargo_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = false,
			timer = 60
		}
	}
	self.train_cargo_door.devices.key = {
		{
			align = "a_keycard",
			unit = Idstring("units/payday2/equipment/gen_interactable_panel_keycard/gen_interactable_panel_keycard")
		}
	}
	self.train_cargo_door.devices.ecm = {
		{
			align = "a_ecm_hack",
			unit = Idstring("units/payday2/equipment/gen_interactable_door_keycard/gen_interactable_door_keycard_jammer")
		}
	}
	self.cage_door = {}
	self.cage_door.devices = {}
	self.cage_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 60
		}
	}
	self.cage_door_deluxe = {}
	self.cage_door_deluxe.devices = {}
	self.cage_door_deluxe.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = true,
			timer = 60
		}
	}
	self.cage_door_deluxe.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge_single")
		}
	}
	self.c4_door = {}
	self.c4_door.devices = {}
	self.c4_door.devices.c4 = {
		{
			align = "a_c4_placement",
			unit = Idstring("units/equipment/c4_charge/c4_mission_door")
		}
	}
	self.c4_3_door = {}
	self.c4_3_door.devices = {}
	self.c4_3_door.devices.c4 = {
		{
			align = "a_c4_placement_1",
			unit = Idstring("units/equipment/c4_charge/c4_mission_door")
		},
		{
			align = "a_c4_placement_2",
			unit = Idstring("units/equipment/c4_charge/c4_mission_door")
		},
		{
			align = "a_c4_placement_3",
			unit = Idstring("units/equipment/c4_charge/c4_mission_door")
		}
	}
	self.gov_d_int_door_shape = {}
	self.gov_d_int_door_shape.devices = {}
	self.gov_d_int_door_shape.devices.c4 = {
		{
			align = "a_c4_placement_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_c4_placement_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.cuttable_tree = {}
	self.cuttable_tree.devices = {}
	self.cuttable_tree.devices.c4 = {
		{
			align = "c4_icon_locator",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.single_shape_charge = {}
	self.single_shape_charge.devices = {}
	self.single_shape_charge.devices.c4 = {
		{
			align = "a_shp_charge",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.cas_safe_giga = {}
	self.cas_safe_giga.devices = {}
	self.cas_safe_giga.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = false,
			timer = 60
		}
	}
	self.cas_safe_giga.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_3",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_4",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.cas_security_door = {}
	self.cas_security_door.devices = {}
	self.cas_security_door.devices.c4 = {
		{
			align = "a_shp_charge_1",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		},
		{
			align = "a_shp_charge_2",
			unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		}
	}
	self.cas_security_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = false,
			timer = 60
		}
	}
	self.cas_moneycounter_door = {}
	self.cas_moneycounter_door.devices = {}
	self.cas_moneycounter_door.devices.drill = {
		{
			align = "a_drill",
			unit = Idstring("units/payday2/equipment/item_door_drill_small/item_door_drill_small"),
			can_jam = false,
			timer = 60
		}
	}
end
