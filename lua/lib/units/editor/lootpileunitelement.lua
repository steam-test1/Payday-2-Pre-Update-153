LootPileUnitElement = LootPileUnitElement or class(MissionElement)
LootPileUnitElement.USES_POINT_ORIENTATION = true

function LootPileUnitElement:init(unit)
	LootPileUnitElement.super.init(self, unit)
	self._hed.carry_id = ""
	self._hed.max_loot = -1
	table.insert(self._save_values, "carry_id")
	table.insert(self._save_values, "max_loot")
end

function LootPileUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	self:_build_value_number(panel, panel_sizer, "max_loot", {min = -1}, "The maximum number of bags that can be picked up from this loot pile. -1 for unlimited.")
	self:_build_value_combobox(panel, panel_sizer, "carry_id", table.list_add({"none"}, tweak_data.carry:get_carry_ids()), "Select a carry_id to be created.")
end
