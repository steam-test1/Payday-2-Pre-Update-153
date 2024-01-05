SpawnDeployableUnitElement = SpawnDeployableUnitElement or class(MissionElement)

function SpawnDeployableUnitElement:init(unit)
	MissionElement.init(self, unit)
	self._hed.deployable_id = "none"
	table.insert(self._save_values, "deployable_id")
end

function SpawnDeployableUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local deployable_id_params = {
		name = "Deployable id:",
		panel = panel,
		sizer = panel_sizer,
		options = {"doctor_bag", "ammo_bag"},
		value = self._hed.deployable_id,
		default = "none",
		tooltip = "Select a deployable_id to be spawned.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local deployable_id = CoreEWS.combobox(deployable_id_params)
	deployable_id:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = deployable_id,
		value = "deployable_id"
	})
end
