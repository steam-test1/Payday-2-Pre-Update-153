CustomSafehouseGui = CustomSafehouseGui or class(MenuGuiComponentGeneric)

function CustomSafehouseGui:init(...)
	self._in_game = Global.game_settings.is_playing
	CustomSafehouseGui.super.init(self, ...)
	if self._in_game then
		self._bg = self._fullscreen_panel:gradient({
			visible = true,
			valign = "center",
			y = 0,
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h(),
			orientation = "vertical",
			gradient_points = {
				0,
				Color(1, 0, 0, 0),
				0.25,
				Color(0.5, 0, 0, 0),
				1,
				Color(1, 0, 0, 0)
			},
			blend_mode = "normal"
		})
	end
end

function CustomSafehouseGui:_start_page_data()
	local data = {}
	data.topic_id = "menu_custom_safehouse"
	return data
end

function CustomSafehouseGui:_setup(is_start_page, component_data)
	CustomSafehouseGui.super._setup(self, is_start_page, self:_start_page_data())
end

function CustomSafehouseGui:populate_tabs_data(tabs_data)
	if not self._in_game then
		table.insert(tabs_data, {
			name_id = "menu_cs_map",
			page_class = "CustomSafehouseGuiPageMap"
		})
	end
	table.insert(tabs_data, {
		name_id = "menu_cs_trophies",
		page_class = "CustomSafehouseGuiPageTrophies"
	})
	table.insert(tabs_data, {
		name_id = "menu_cs_daily_challenge",
		page_class = "CustomSafehouseGuiPageDaily",
		width_multiplier = 1
	})
end
