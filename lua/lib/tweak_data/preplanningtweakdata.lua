PrePlanningTweakData = PrePlanningTweakData or class()

function PrePlanningTweakData:init(tweak_data)
	self:_create_locations(tweak_data)
	self.plans = {}
	self.categories = {}
	self.types = {}
end

function PrePlanningTweakData:_create_locations(tweak_data)
	self.location_groups = {
		"a",
		"b",
		"c",
		"d",
		"e",
		"f"
	}
	self.locations = {}
end

function PrePlanningTweakData:get_level_data(level_id)
	return self.locations[level_id] or {}
end
