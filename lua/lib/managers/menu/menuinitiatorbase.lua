MenuInitiatorBase = MenuInitiatorBase or class()

function MenuInitiatorBase:modify_node(original_node, data)
	return original_node
end

function MenuInitiatorBase:create_divider(node, id, text_id, size, color)
	local params = {
		name = "divider_" .. id,
		no_text = not text_id,
		text_id = text_id,
		size = size or 8,
		color = color
	}
	local data_node = {
		type = "MenuItemDivider"
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	return new_item
end

function MenuInitiatorBase:create_toggle(node, params, index)
	local data_node = {
		type = "CoreMenuItemToggle.ItemToggle",
		{
			_meta = "option",
			icon = "guis/textures/menu_tickbox",
			value = "on",
			x = 24,
			y = 0,
			w = 24,
			h = 24,
			s_icon = "guis/textures/menu_tickbox",
			s_x = 24,
			s_y = 24,
			s_w = 24,
			s_h = 24
		},
		{
			_meta = "option",
			icon = "guis/textures/menu_tickbox",
			value = "off",
			x = 0,
			y = 0,
			w = 24,
			h = 24,
			s_icon = "guis/textures/menu_tickbox",
			s_x = 0,
			s_y = 24,
			s_w = 24,
			s_h = 24
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	if index then
		node:insert_item(new_item, index)
	else
		node:add_item(new_item)
	end
	return new_item
end

function MenuInitiatorBase:create_item(node, params)
	local data_node = {}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	node:add_item(new_item)
	return new_item
end

function MenuInitiatorBase:create_multichoice(node, choices, params, index)
	if #choices == 0 then
		return
	end
	local data_node = {
		type = "MenuItemMultiChoice"
	}
	for _, choice in ipairs(choices) do
		table.insert(data_node, choice)
	end
	local new_item = node:create_item(data_node, params)
	new_item:set_value(choices[1].value)
	if index then
		node:insert_item(new_item, index)
	else
		node:add_item(new_item)
	end
	return new_item
end

function MenuInitiatorBase:create_slider(node, params)
	local data_node = {
		type = "CoreMenuItemSlider.ItemSlider",
		show_value = params.show_value,
		min = params.min,
		max = params.max,
		step = params.step,
		show_value = params.show_value
	}
	local new_item = node:create_item(data_node, params)
	node:add_item(new_item)
	return new_item
end

function MenuInitiatorBase:create_input(node, params)
	local data_node = {
		type = "MenuItemInput"
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	node:add_item(new_item)
	return new_item
end

function MenuInitiatorBase:create_textbox(node, params)
	local data_node = {
		type = "MenuItemTextBox"
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_enabled(params.enabled)
	node:add_item(new_item)
	return new_item
end

function MenuInitiatorBase:add_back_button(node)
	node:delete_item("back")
	local params = {
		name = "back",
		text_id = "menu_back",
		visible_callback = "is_pc_controller",
		last_item = true,
		back = true,
		previous_node = true
	}
	local new_item = node:create_item(nil, params)
	node:add_item(new_item)
	return new_item
end
