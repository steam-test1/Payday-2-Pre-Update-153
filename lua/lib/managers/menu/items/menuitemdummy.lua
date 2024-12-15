core:import("CoreMenuItem")
MenuItemDummy = MenuItemDummy or class(CoreMenuItem.Item)
MenuItemDummy.TYPE = "dummy"

function MenuItemDummy:init(data_node, parameters)
	CoreMenuItem.Item.init(self, data_node, parameters)
	self._type = MenuItemDummy.TYPE
	self.hide_highlight = true
end

function MenuItemDummy:setup_gui(node, row_item)
	row_item.gui_panel = node.item_panel:panel({w = 0, h = 0})
	row_item.gui_panel:set_left(node._mid_align(node))
	self.no_mouse_select = true
	return true
end

function MenuItemDummy:trigger()
	MenuItemDummy.super.trigger(self)
	if self._actual_item and self._actual_item.dummy_trigger then
		self._actual_item:dummy_trigger()
	end
end

function MenuItemDummy:set_actual_item(item)
	self._actual_item = item
end

function MenuItemDummy:highlight_row_item(node, row_item, mouse_over)
	if self._actual_item and self._actual_item.dummy_set_highlight then
		self._actual_item:dummy_set_highlight(true, node, row_item, mouse_over)
	end
	return true
end

function MenuItemDummy:fade_row_item(node, row_item, mouse_over)
	if self._actual_item and self._actual_item.dummy_set_highlight then
		self._actual_item:dummy_set_highlight(false, node, row_item, mouse_over)
	end
	return true
end

function MenuItemDummy:reload()
	return true
end

function MenuItemDummy:menu_unselected_visible()
	return false
end
