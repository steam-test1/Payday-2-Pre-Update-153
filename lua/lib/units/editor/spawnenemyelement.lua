core:import("CoreEditorUtils")
SpawnEnemyUnitElement = SpawnEnemyUnitElement or class(MissionElement)

function SpawnEnemyUnitElement:init(unit)
	SpawnEnemyUnitElement.super.init(self, unit)
	self._enemies = {}
	self._options = {
		"units/test/payday2/previs/previs_npc_chains/previs_npc_chains",
		"units/test/payday2/previs/previs_npc_dallas/previs_npc_dallas",
		"units/test/payday2/previs/previs_npc_wolf/previs_npc_wolf",
		"units/payday2/characters/ene_biker_1/ene_biker_1",
		"units/payday2/characters/ene_biker_2/ene_biker_2",
		"units/payday2/characters/ene_biker_3/ene_biker_3",
		"units/payday2/characters/ene_biker_4/ene_biker_4",
		"units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1",
		"units/payday2/characters/ene_cop_1/ene_cop_1",
		"units/payday2/characters/ene_cop_2/ene_cop_2",
		"units/payday2/characters/ene_cop_3/ene_cop_3",
		"units/payday2/characters/ene_cop_4/ene_cop_4",
		"units/payday2/characters/ene_fbi_1/ene_fbi_1",
		"units/payday2/characters/ene_fbi_2/ene_fbi_2",
		"units/payday2/characters/ene_fbi_3/ene_fbi_3",
		"units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1",
		"units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1",
		"units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2",
		"units/payday2/characters/ene_gang_black_1/ene_gang_black_1",
		"units/payday2/characters/ene_gang_black_2/ene_gang_black_2",
		"units/payday2/characters/ene_gang_black_3/ene_gang_black_3",
		"units/payday2/characters/ene_gang_black_4/ene_gang_black_4",
		"units/payday2/characters/ene_gang_mexican_1/ene_gang_mexican_1",
		"units/payday2/characters/ene_gang_mexican_2/ene_gang_mexican_2",
		"units/payday2/characters/ene_gang_mexican_3/ene_gang_mexican_3",
		"units/payday2/characters/ene_gang_mexican_4/ene_gang_mexican_4",
		"units/payday2/characters/ene_gang_russian_1/ene_gang_russian_1",
		"units/payday2/characters/ene_gang_russian_2/ene_gang_russian_2",
		"units/payday2/characters/ene_gang_russian_3/ene_gang_russian_3",
		"units/payday2/characters/ene_gang_russian_4/ene_gang_russian_4",
		"units/payday2/characters/ene_gang_russian_5/ene_gang_russian_5",
		"units/payday2/characters/ene_secret_service_1/ene_secret_service_1",
		"units/payday2/characters/ene_secret_service_2/ene_secret_service_2",
		"units/payday2/characters/ene_security_1/ene_security_1",
		"units/payday2/characters/ene_security_2/ene_security_2",
		"units/payday2/characters/ene_security_3/ene_security_3",
		"units/payday2/characters/ene_shield_1/ene_shield_1",
		"units/payday2/characters/ene_shield_2/ene_shield_2",
		"units/payday2/characters/ene_sniper_1/ene_sniper_1",
		"units/payday2/characters/ene_sniper_2/ene_sniper_2",
		"units/payday2/characters/ene_spook_1/ene_spook_1",
		"units/payday2/characters/ene_swat_1/ene_swat_1",
		"units/payday2/characters/ene_swat_2/ene_swat_2",
		"units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1",
		"units/payday2/characters/ene_tazer_1/ene_tazer_1",
		"units/payday2/characters/ene_biker_escape/ene_biker_escape"
	}
	self._hed.enemy = "units/payday2/characters/ene_swat_1/ene_swat_1"
	self._hed.force_pickup = "none"
	self._hed.spawn_action = "none"
	self._hed.participate_to_group_ai = true
	self._hed.interval = 5
	self._hed.amount = 0
	self._hed.accessibility = "any"
	table.insert(self._save_values, "enemy")
	table.insert(self._save_values, "force_pickup")
	table.insert(self._save_values, "spawn_action")
	table.insert(self._save_values, "participate_to_group_ai")
	table.insert(self._save_values, "interval")
	table.insert(self._save_values, "amount")
	table.insert(self._save_values, "accessibility")
end

function SpawnEnemyUnitElement:post_init(...)
	SpawnEnemyUnitElement.super.post_init(self, ...)
	self:_load_pickup()
end

function SpawnEnemyUnitElement:test_element()
	if self._hed.enemy ~= "none" then
		local enemy = safe_spawn_unit(Idstring(self._hed.enemy), self._unit:position(), self._unit:rotation())
		table.insert(self._enemies, enemy)
		ElementSpawnEnemyDummy.produce_test(self._hed, enemy)
	end
end

function SpawnEnemyUnitElement:stop_test_element()
	for _, enemy in ipairs(self._enemies) do
		enemy:set_slot(0)
	end
	self._enemies = {}
end

function SpawnEnemyUnitElement:add_unit_list_btn()
	local dialog = SelectNameModal:new("Select unit", self._options)
	if dialog:cancelled() then
		return
	end
	for _, unit in ipairs(dialog:_selected_item_assets()) do
		self._hed.enemy = unit
		CoreEws.change_combobox_value(self._enemies_params, self._hed.enemy)
	end
end

function SpawnEnemyUnitElement:select_spawn_action_btn()
	local dialog = SelectNameModal:new("Select unit", clone(CopActionAct._act_redirects.enemy_spawn))
	if dialog:cancelled() then
		return
	end
	for _, action in ipairs(dialog:_selected_item_assets()) do
		self._hed.spawn_action = action
		CoreEws.change_combobox_value(self._spawn_action_params, self._hed.spawn_action)
	end
end

function SpawnEnemyUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local enemy_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(enemy_sizer, 0, 1, "EXPAND,LEFT")
	local enemies_params = {
		name = "Enemy:",
		panel = panel,
		sizer = enemy_sizer,
		options = self._options,
		value = self._hed.enemy,
		tooltip = "Select an enemy from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local enemies = CoreEWS.combobox(enemies_params)
	enemies:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {ctrlr = enemies, value = "enemy"})
	self._enemies_params = enemies_params
	local toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	toolbar:add_tool("ADD_UNIT_LIST", "Add unit from unit list", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	toolbar:connect("ADD_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "add_unit_list_btn"), nil)
	toolbar:realize()
	enemy_sizer:add(toolbar, 0, 1, "EXPAND,LEFT")
	local participate_to_group_ai = EWS:CheckBox(panel, "Participate to group ai", "")
	participate_to_group_ai:set_value(self._hed.participate_to_group_ai)
	participate_to_group_ai:connect("EVT_COMMAND_CHECKBOX_CLICKED", callback(self, self, "set_element_data"), {
		ctrlr = participate_to_group_ai,
		value = "participate_to_group_ai"
	})
	panel_sizer:add(participate_to_group_ai, 0, 0, "EXPAND")
	local spawn_action_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(spawn_action_sizer, 0, 1, "EXPAND,LEFT")
	local spawn_action_params = {
		name = "Spawn action:",
		panel = panel,
		sizer = spawn_action_sizer,
		options = clone(CopActionAct._act_redirects.enemy_spawn),
		value = self._hed.spawn_action,
		default = "none",
		tooltip = "Select a action that the unit should start with.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local spawn_action = CoreEWS.combobox(spawn_action_params)
	self._spawn_action_params = spawn_action_params
	spawn_action:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = spawn_action,
		value = "spawn_action"
	})
	local toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	toolbar:add_tool("ADD_UNIT_LIST", "Select spawn action", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	toolbar:connect("ADD_UNIT_LIST", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "select_spawn_action_btn"), nil)
	toolbar:realize()
	spawn_action_sizer:add(toolbar, 0, 1, "EXPAND,LEFT")
	local interval_params = {
		name = "Interval:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.interval,
		floats = 2,
		tooltip = "Used to specify how often this spawn can be used. 0 means no interval",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local interval = CoreEWS.number_controller(interval_params)
	interval:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = interval, value = "interval"})
	interval:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = interval, value = "interval"})
	local amount_params = {
		name = "Amount:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.amount,
		floats = 0,
		tooltip = "Used to specify how many enemies can be spawned. 0 means no limit",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local amount = CoreEWS.number_controller(amount_params)
	amount:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	amount:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = amount, value = "amount"})
	local accessibility_params = {
		name = "Accessibility:",
		panel = panel,
		sizer = panel_sizer,
		options = {
			"any",
			"walk",
			"acrobatic"
		},
		value = self._hed.accessibility,
		tooltip = "Only units with this movement type will be spawned from this element.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local accessibility = CoreEWS.combobox(accessibility_params)
	accessibility:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = accessibility,
		value = "accessibility"
	})
	local pickups = {}
	for name, _ in pairs(tweak_data.pickups) do
		table.insert(pickups, name)
	end
	local pickup_params = {
		name = "Force Pickup:",
		panel = panel,
		sizer = panel_sizer,
		options = pickups,
		value = self._hed.force_pickup,
		default = "none",
		tooltip = "Select a pickup to be forced spawned when characters from this element dies.",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sorted = true
	}
	local force_pickup = CoreEWS.combobox(pickup_params)
	force_pickup:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = force_pickup,
		value = "force_pickup"
	})
	force_pickup:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "_load_pickup"), nil)
end

function SpawnEnemyUnitElement:_load_pickup()
	if self._hed.force_pickup ~= "none" then
		local unit_name = tweak_data.pickups[self._hed.force_pickup].unit
		CoreUnit.editor_load_unit(unit_name)
	end
end

function SpawnEnemyUnitElement:add_to_mission_package()
	if self._hed.force_pickup ~= "none" then
		local unit_name = tweak_data.pickups[self._hed.force_pickup].unit
		managers.editor:add_to_world_package({
			category = "units",
			name = unit_name:s(),
			continent = self._unit:unit_data().continent
		})
		local sequence_files = {}
		CoreEditorUtils.get_sequence_files_by_unit_name(unit_name, sequence_files)
		for _, file in ipairs(sequence_files) do
			managers.editor:add_to_world_package({
				category = "script_data",
				name = file:s() .. ".sequence_manager",
				continent = self._unit:unit_data().continent,
				init = true
			})
		end
	end
end

function SpawnEnemyUnitElement:destroy(...)
	SpawnEnemyUnitElement.super.destroy(self, ...)
	self:stop_test_element()
end
