MenuNodeCrimenetGui = MenuNodeCrimenetGui or class(MenuNodeGui)

function MenuNodeCrimenetGui:init(node, layer, parameters)
	parameters.font = tweak_data.menu.pd2_small_font
	parameters.font_size = tweak_data.menu.pd2_small_font_size
	parameters.align = "left"
	parameters.row_item_blend_mode = "add"
	parameters.row_item_color = tweak_data.screen_colors.button_stage_3
	parameters.row_item_hightlight_color = tweak_data.screen_colors.button_stage_2
	parameters.marker_alpha = 1
	parameters.to_upper = true
	MenuNodeCrimenetGui.super.init(self, node, layer, parameters)
end

function MenuNodeCrimenetGui:_setup_item_panel(safe_rect, res)
	MenuNodeHiddenGui.super._setup_item_panel(self, safe_rect, res)
	local width = 760
	local height = 540
	if SystemInfo:platform() ~= Idstring("WIN32") then
		width = 800
		height = 500
	end
	self.item_panel:set_rightbottom(self.item_panel:parent():w() * 0.5 + width / 2 - 10, self.item_panel:parent():h() * 0.5 + height / 2 - 10)
	self:_set_topic_position()
end

MenuNodeCrimenetFiltersGui = MenuNodeCrimenetFiltersGui or class(MenuNodeGui)

function MenuNodeCrimenetFiltersGui:init(node, layer, parameters)
	parameters.font = tweak_data.menu.pd2_small_font
	parameters.font_size = tweak_data.menu.pd2_small_font_size
	parameters.align = "left"
	parameters.row_item_blend_mode = "add"
	parameters.row_item_color = tweak_data.screen_colors.button_stage_3
	parameters.row_item_hightlight_color = tweak_data.screen_colors.button_stage_2
	parameters.marker_alpha = 1
	parameters.to_upper = true
	MenuNodeCrimenetFiltersGui.super.init(self, node, layer, parameters)
end

function MenuNodeCrimenetFiltersGui:close(...)
	MenuNodeCrimenetFiltersGui.super.close(self, ...)
end

function MenuNodeCrimenetFiltersGui:_setup_item_panel(safe_rect, res)
	MenuNodeCrimenetFiltersGui.super._setup_item_panel(self, safe_rect, res)
	self:_set_topic_position()
	local max_layer = 10000
	local min_layer = 0
	local child_layer = 0
	for _, child in ipairs(self.item_panel:children()) do
		child:set_halign("right")
		child_layer = child:layer()
		if 0 < child_layer then
			min_layer = math.min(min_layer, child_layer)
		end
		max_layer = math.max(max_layer, child_layer)
	end
	for _, child in ipairs(self.item_panel:children()) do
	end
	self.item_panel:set_w(safe_rect.width * (1 - self._align_line_proportions))
	self.item_panel:set_center(self.item_panel:parent():w() / 2, self.item_panel:parent():h() / 2)
	self.box_panel = self.item_panel:parent():panel()
	self.box_panel:set_shape(self.item_panel:shape())
	self.box_panel:set_layer(51)
	self.box_panel:grow(20, 20)
	self.box_panel:move(-10, -10)
	self.boxgui = BoxGuiObject:new(self.box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self.box_panel:rect({
		color = Color.black,
		alpha = 0.6
	})
end

function MenuNodeCrimenetFiltersGui:reload_item(item)
	MenuNodeCrimenetFiltersGui.super.reload_item(self, item)
	local row_item = self:row_item(item)
	row_item.gui_panel:set_right(self.item_panel:w())
end

function MenuNodeCrimenetFiltersGui:_align_marker(row_item)
	MenuNodeCrimenetFiltersGui.super._align_marker(self, row_item)
	self._marker_data.marker:set_world_right(self.item_panel:world_right())
end
