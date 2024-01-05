require("lib/managers/menu/renderers/MenuNodeBaseGui")
MenuNodePrePlanningGui = MenuNodePrePlanningGui or class(MenuNodeBaseGui)

function MenuNodePrePlanningGui:init(node, layer, parameters)
	parameters.font = tweak_data.menu.pd2_small_font
	parameters.font_size = tweak_data.menu.pd2_small_font_size
	parameters.align = "left"
	parameters.row_item_blend_mode = "add"
	parameters.row_item_color = tweak_data.screen_colors.button_stage_3
	parameters.row_item_hightlight_color = tweak_data.screen_colors.button_stage_2
	parameters.marker_alpha = 1
	parameters.to_upper = true
	parameters._align_line_proportions = 0.8
	MenuNodePrePlanningGui.super.init(self, node, layer, parameters)
end

function MenuNodePrePlanningGui:setup()
	MenuNodePrePlanningGui.super.setup(self)
	self:create_text_button({
		right = self.safe_rect_panel:w() - 10,
		bottom = self.safe_rect_panel:h() - 10,
		font = self.large_font,
		font_size = self.large_font_size,
		text_id = "menu_back",
		text_to_upper = true,
		clbk = callback(MenuCallbackHandler, MenuCallbackHandler, "menu_back")
	})
end

function MenuNodePrePlanningGui:_setup_item_panel(safe_rect, res)
	MenuNodePrePlanningGui.super._setup_item_panel(self, safe_rect, res)
	self.item_panel:set_w(safe_rect.width * (1 - self._align_line_proportions))
	self.item_panel:set_right(self.item_panel:parent():w() - 20)
	self.item_panel:set_top(20)
	self:_rec_round_object(self.item_panel)
	if alive(self.box_panel) then
		self.item_panel:parent():remove(self.box_panel)
		self.box_panel = nil
	end
	self.box_panel = self.item_panel:parent():panel()
	self.box_panel:set_x(self.item_panel:x())
	self.box_panel:set_w(self.item_panel:w())
	if self.item_panel:h() > self._align_data.panel:h() then
		self.box_panel:set_y(0)
		self.box_panel:set_h(self.item_panel:parent():h())
	else
		self.box_panel:set_y(self.item_panel:top())
		self.box_panel:set_h(self.item_panel:h())
	end
	self.box_panel:grow(20, 20)
	self.box_panel:move(-10, -10)
	self.box_panel:set_layer(self.layers.background)
	self.boxgui = BoxGuiObject:new(self.box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self.boxgui:set_clipping(false)
	self.boxgui:set_layer(1000)
	self.box_panel:rect({
		color = Color.black,
		alpha = 0.6,
		rotation = 360
	})
	self.box_panel:bitmap({
		name = "blur",
		texture = "guis/textures/test_blur_df",
		render_template = "VertexColorTexturedBlur3D",
		layer = -1,
		w = self.box_panel:w(),
		h = self.box_panel:h()
	})
	self._align_data.panel:set_left(self.box_panel:left())
	self:_set_topic_position()
	self:set_row_item_icon()
end

function MenuNodePrePlanningGui:_setup_item_panel_parent(safe_rect, shape)
	shape = shape or {}
	shape.x = shape.x or safe_rect.x
	shape.y = shape.y or safe_rect.y + 0
	shape.w = shape.w or safe_rect.width
	shape.h = shape.h or safe_rect.height - 0
	MenuNodePrePlanningGui.super._setup_item_panel_parent(self, safe_rect, shape)
end

function MenuNodePrePlanningGui:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function MenuNodePrePlanningGui:reload_item(item)
	MenuNodePrePlanningGui.super.reload_item(self, item)
	local row_item = self:row_item(item)
	if row_item and alive(row_item.gui_panel) then
		row_item.gui_panel:set_halign("right")
		row_item.gui_panel:set_right(self.item_panel:w())
	end
end

function MenuNodePrePlanningGui:highlight_item(item, mouse_over)
	MenuNodePrePlanningGui.super.highlight_item(self, item, mouse_over)
	managers.menu_component:set_preplanning_selected_element_item(item)
end

function MenuNodePrePlanningGui:_fade_row_item(row_item)
	MenuNodePrePlanningGui.super._fade_row_item(self, row_item)
	if row_item.icon then
		row_item.icon:set_left(-2)
	end
end

function MenuNodePrePlanningGui:_highlight_row_item(row_item, mouse_over)
	MenuNodePrePlanningGui.super._highlight_row_item(self, row_item, mouse_over)
	if row_item.icon then
		row_item.icon:set_left(-2)
	end
end

function MenuNodePrePlanningGui:refresh_gui(node)
	MenuNodePrePlanningGui.super.refresh_gui(self, node)
	self:set_row_item_icon()
end

function MenuNodePrePlanningGui:set_row_item_icon()
	for _, row_item in pairs(self.row_items) do
		if alive(row_item.icon) then
			row_item.icon:set_left(-2)
		end
	end
end

function MenuNodePrePlanningGui:test_clbk(...)
	print(inspect({
		...
	}))
end

function MenuNodePrePlanningGui:mouse_moved(o, x, y)
	local used, icon = MenuNodePrePlanningGui.super.mouse_moved(self, o, x, y)
	return used, icon
end

function MenuNodePrePlanningGui:mouse_pressed(button, x, y)
	if MenuNodePrePlanningGui.super.mouse_pressed(self, button, x, y) then
		return true
	end
end

function MenuNodePrePlanningGui:mouse_released(button, x, y)
	if button == Idstring("1") then
		for _, row_item in pairs(self.row_items) do
			if row_item.gui_panel and row_item.gui_panel:inside(x, y) and row_item.type ~= "divider" then
				managers.menu_component:set_preplanning_map_position_to_item(row_item.item)
			end
		end
	end
	if MenuNodePrePlanningGui.super.mouse_released(self, button, x, y) then
		return true
	end
end

function MenuNodePrePlanningGui:confirm_pressed()
	MenuNodePrePlanningGui.super.confirm_pressed(self)
end

function MenuNodePrePlanningGui:previous_page()
	MenuNodePrePlanningGui.super.previous_page(self)
end

function MenuNodePrePlanningGui:next_page()
	MenuNodePrePlanningGui.super.next_page(self)
end

function MenuNodePrePlanningGui:move_up()
	MenuNodePrePlanningGui.super.move_up(self)
end

function MenuNodePrePlanningGui:move_down()
	MenuNodePrePlanningGui.super.move_down(self)
end

function MenuNodePrePlanningGui:move_left()
	MenuNodePrePlanningGui.super.move_left(self)
end

function MenuNodePrePlanningGui:move_right()
	MenuNodePrePlanningGui.super.move_right(self)
end

function MenuNodePrePlanningGui:close()
	MenuNodePrePlanningGui.super.close(self)
end
