PrePlanningTweakData = PrePlanningTweakData or class()

function PrePlanningTweakData:init(tweak_data)
	self.location_groups = {
		"a",
		"b",
		"c",
		"d",
		"e",
		"f"
	}
	self.types = {}
	self.types.ammo_bag = {}
	self.types.ammo_bag.name_id = "menu_asset_ammo"
	self.types.ammo_bag.deployable_id = "ammo_bag"
	self.types.health_bag = {}
	self.types.health_bag.name_id = "menu_asset_health"
	self.types.health_bag.deployable_id = "doctor_bag"
	self.types.bodybags_bag = {}
	self.types.bodybags_bag.name_id = "menu_asset_bodybags_bag"
	self.types.bodybags_bag.deployable_id = "bodybags_bag"
	self.types.grenade_crate = {}
	self.types.grenade_crate.name_id = "menu_asset_grenade_crate"
	self.types.grenade_crate.deployable_id = "grenade_crate"
	self.types.car = {}
end
