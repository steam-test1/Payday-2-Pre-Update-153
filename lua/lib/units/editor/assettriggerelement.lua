AssetTriggerUnitElement = AssetTriggerUnitElement or class(MissionElement)
AssetTriggerUnitElement.SAVE_UNIT_POSITION = false
AssetTriggerUnitElement.SAVE_UNIT_ROTATION = false

function AssetTriggerUnitElement:init(unit)
	AssetTriggerUnitElement.super.init(self, unit)
	self._hed.trigger_times = 1
	self._hed.id = managers.assets:get_default_asset_id()
	table.insert(self._save_values, "id")
end

function AssetTriggerUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local ids_params = {
		name = "Asset Id:",
		panel = panel,
		sizer = panel_sizer,
		options = managers.assets:get_every_asset_ids(),
		value = self._hed.id,
		tooltip = "Select an asset id from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local ids = CoreEWS.combobox(ids_params)
	ids:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = ids, value = "id"})
	local help = {}
	help.text = "Set the asset that the element should trigger on."
	help.panel = panel
	help.sizer = panel_sizer
	self:add_help_text(help)
end
