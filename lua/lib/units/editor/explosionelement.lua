ExplosionUnitElement = ExplosionUnitElement or class(FeedbackUnitElement)

function ExplosionUnitElement:init(unit)
	ExplosionUnitElement.super.init(self, unit)
	self._hed.damage = 40
	self._hed.player_damage = 10
	self._hed.explosion_effect = "effects/particles/explosions/explosion_grenade_launcher"
	table.insert(self._save_values, "damage")
	table.insert(self._save_values, "player_damage")
	table.insert(self._save_values, "explosion_effect")
end

function ExplosionUnitElement:update_selected(...)
	ExplosionUnitElement.super.update_selected(self)
end

function ExplosionUnitElement:select_explosion_effect_btn()
	local dialog = SelectNameModal:new("Select effect", self:_effect_options())
	if dialog:cancelled() then
		return
	end
	for _, effect in ipairs(dialog:_selected_item_assets()) do
		self._hed.explosion_effect = effect
		CoreEws.change_combobox_value(self._explosion_effect_params, self._hed.explosion_effect)
	end
end

function ExplosionUnitElement:_build_panel(panel, panel_sizer)
	self:_create_panel()
	panel = panel or self._panel
	panel_sizer = panel_sizer or self._panel_sizer
	local damage_params = {
		name = "Damage:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.damage,
		floats = 0,
		tooltip = "The damage from the explosion",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local damage = CoreEws.number_controller(damage_params)
	damage:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {ctrlr = damage, value = "damage"})
	damage:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {ctrlr = damage, value = "damage"})
	local player_damage_params = {
		name = "Player damage:",
		panel = panel,
		sizer = panel_sizer,
		value = self._hed.player_damage,
		floats = 0,
		tooltip = "The player damage from the explosion",
		min = 0,
		name_proportions = 1,
		ctrlr_proportions = 2
	}
	local player_damage = CoreEws.number_controller(player_damage_params)
	player_damage:connect("EVT_COMMAND_TEXT_ENTER", callback(self, self, "set_element_data"), {
		ctrlr = player_damage,
		value = "player_damage"
	})
	player_damage:connect("EVT_KILL_FOCUS", callback(self, self, "set_element_data"), {
		ctrlr = player_damage,
		value = "player_damage"
	})
	local explosion_effect_sizer = EWS:BoxSizer("HORIZONTAL")
	panel_sizer:add(explosion_effect_sizer, 0, 1, "EXPAND,LEFT")
	local explosion_effect_params = {
		name = "Explosion effect:",
		panel = panel,
		sizer = explosion_effect_sizer,
		default = "none",
		options = self:_effect_options(),
		value = self._hed.explosion_effect,
		tooltip = "Select and explosion effect from the combobox",
		name_proportions = 1,
		ctrlr_proportions = 2,
		sizer_proportions = 1,
		sorted = true
	}
	local explosion_effect = CoreEWS.combobox(explosion_effect_params)
	self._explosion_effect_params = explosion_effect_params
	explosion_effect:connect("EVT_COMMAND_COMBOBOX_SELECTED", callback(self, self, "set_element_data"), {
		ctrlr = explosion_effect,
		value = "explosion_effect"
	})
	local toolbar = EWS:ToolBar(panel, "", "TB_FLAT,TB_NODIVIDER")
	toolbar:add_tool("SELECT_EXPLOSION_EFFECT", "Select explosion effect", CoreEws.image_path("world_editor\\unit_by_name_list.png"), nil)
	toolbar:connect("SELECT_EXPLOSION_EFFECT", "EVT_COMMAND_MENU_SELECTED", callback(self, self, "select_explosion_effect_btn"), nil)
	toolbar:realize()
	explosion_effect_sizer:add(toolbar, 0, 1, "EXPAND,LEFT")
	ExplosionUnitElement.super._build_panel(self, panel, panel_sizer)
end

function ExplosionUnitElement:add_to_mission_package()
	ExplosionUnitElement.super.add_to_mission_package(self)
	if self._hed.explosion_effect ~= "none" then
		managers.editor:add_to_world_package({
			category = "effects",
			name = self._hed.explosion_effect,
			continent = self._unit:unit_data().continent
		})
	end
end
