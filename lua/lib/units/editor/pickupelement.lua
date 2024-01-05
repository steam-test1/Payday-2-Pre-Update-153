PickupUnitElement = PickupUnitElement or class(MissionElement)
PickupUnitElement.SAVE_UNIT_POSITION = false
PickupUnitElement.SAVE_UNIT_ROTATION = false

function PickupUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.pickup = "remove"
	table.insert(self._save_values, "pickup")
end

function PickupUnitElement.get_options()
	local pickups = {}
	for name, _ in pairs(tweak_data.pickups) do
		table.insert(pickups, name)
	end
	return pickups
end

function PickupUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local pickup_params = {
		name = "Pickup:",
		panel = panel,
		sizer = panel_sizer,
		options = PickupUnitElement.get_options(),
		value = self._hed.pickup,
		default = "remove",
		tooltip = "Select a pickup to be set or remove.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local pickup = CoreEWS.combobox(pickup_params)
	pickup:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = pickup, value = "pickup"})
end
