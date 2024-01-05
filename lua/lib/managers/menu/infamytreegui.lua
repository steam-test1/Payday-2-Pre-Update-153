require("lib/managers/menu/WalletGuiObject")
local WIDTH_MULTIPLIER = SystemInfo:platform() == Idstring("WIN32") and 0.6 or 0.5
InfamyTreeGui = InfamyTreeGui or class()

function InfamyTreeGui:init(ws, fullscreen_ws, node)
	managers.menu:active_menu().renderer.ws:hide()
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._init_layer = self._ws:panel():layer()
	managers.menu_component:close_contract_gui()
	self:_setup()
	self:set_layer(1000)
end

InfamyTreeGui.tree_rows = 3
InfamyTreeGui.tree_cols = 4

function InfamyTreeGui:_setup()
	if alive(self._panel) then
		self._ws:panel():remove(self._panel)
	end
	self._panel = self._ws:panel():panel({
		visible = true,
		layer = self._init_layer,
		valign = "center"
	})
	self._fullscreen_panel = self._fullscreen_ws:panel():panel()
	self._requested_textures = {}
	WalletGuiObject.set_wallet(self._panel)
	local title_text = self._panel:text({
		name = "infamytree_text",
		text = utf8.to_upper(managers.localization:text("menu_infamytree")),
		align = "left",
		vertical = "top",
		h = tweak_data.menu.pd2_large_font_size,
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text
	})
	local title_bg_text = self._fullscreen_panel:text({
		name = "infamytree_text",
		text = utf8.to_upper(managers.localization:text("menu_infamytree")),
		h = 90,
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_massive_font_size,
		font = tweak_data.menu.pd2_massive_font,
		color = tweak_data.screen_colors.button_stage_3,
		alpha = 0.4,
		blend_mode = "add",
		layer = 1
	})
	local x, y = managers.gui_data:safe_to_full_16_9(title_text:world_x(), title_text:world_center_y())
	title_bg_text:set_world_left(x)
	title_bg_text:set_world_center_y(y)
	title_bg_text:move(-13, 9)
	MenuBackdropGUI.animate_bg_text(self, title_bg_text)
	self._tree_panel = self._panel:panel({name = "tree_panel"})
	self._tree_panel:set_w(math.round(self._panel:w() * WIDTH_MULTIPLIER - 10))
	self._tree_panel:set_h(math.round(self._panel:h() * 0.75))
	self._tree_panel:set_top(title_text:bottom() + 32)
	BoxGuiObject:new(self._tree_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._description_panel = self._panel:panel({
		name = "description_panel"
	})
	self._description_panel:set_w(math.round(self._panel:w() * (1 - WIDTH_MULTIPLIER) - 10))
	self._description_panel:set_h(math.round(self._panel:h() * 0.75))
	self._description_panel:set_top(title_text:bottom() + 32)
	self._description_panel:set_right(self._panel:w())
	self._description_panel:text({
		name = "description_title",
		text = "",
		x = 10,
		y = 10,
		layer = 1,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale",
		wrap = true,
		word_wrap = true,
		color = tweak_data.screen_colors.text
	})
	self._description_panel:text({
		name = "description_warning",
		text = "",
		x = 10,
		y = 10,
		layer = 1,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale",
		wrap = true,
		word_wrap = true,
		color = tweak_data.screen_colors.important_1
	})
	self._description_panel:text({
		name = "description_text",
		text = "",
		x = 10,
		y = 10,
		layer = 1,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale",
		wrap = true,
		word_wrap = true,
		color = tweak_data.screen_colors.text,
		h = tweak_data.menu.pd2_small_font_size + 10
	})
	BoxGuiObject:new(self._description_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	local tree_rows = InfamyTreeGui.tree_rows
	local tree_cols = InfamyTreeGui.tree_cols
	local item_width = self._tree_panel:w() / tree_cols
	local item_height = self._tree_panel:h() / (tree_rows + 2)
	local x = 0
	local y = item_height * (tree_rows + 1)
	self._tree_items = {}
	local x = self._tree_panel:w() / 2 - item_width / 2
	local y = y
	local item = {
		panel = self._tree_panel:panel({
			x = x,
			y = y,
			w = item_width,
			h = item_height
		})
	}
	table.insert(self._tree_items, item)
	x = 0
	y = y - item_height
	for count = 1, tree_rows * tree_cols do
		item = {
			panel = self._tree_panel:panel({
				x = x,
				y = y,
				w = item_width,
				h = item_height
			})
		}
		table.insert(self._tree_items, item)
		x = x + item_width
		if x >= self._tree_panel:w() then
			x = 0
			y = y - item_height
		end
	end
	x = self._tree_panel:w() / 2 - item_width / 2
	item = {
		panel = self._tree_panel:panel({
			x = x,
			y = y,
			w = item_width,
			h = item_height
		})
	}
	table.insert(self._tree_items, item)
	local border_size = 2
	local size = item_height - border_size
	local pos = item_width / 2 - size / 2
	local secret_count = 1
	for index, item in pairs(self._tree_items) do
		if tweak_data.infamy.tree[index] then
			local infamy_tweak = tweak_data.infamy.items[tweak_data.infamy.tree[index]]
			local texture_rect_x = infamy_tweak.icon_xy and infamy_tweak.icon_xy[1] or 0
			local texture_rect_y = infamy_tweak.icon_xy and infamy_tweak.icon_xy[2] or 0
			item.owned = managers.infamy:owned(tweak_data.infamy.tree[index])
			item.unlocked = managers.infamy:available(tweak_data.infamy.tree[index])
			local color = item.owned and tweak_data.screen_colors.item_stage_1 or item.unlocked and tweak_data.screen_colors.item_stage_2 or tweak_data.screen_colors.item_stage_3
			item.panel:bitmap({
				name = "image",
				x = pos,
				y = border_size,
				w = size,
				h = size,
				texture = "guis/dlcs/infamous/textures/pd2/infamous_tree/infamous_tree_atlas",
				texture_rect = {
					texture_rect_x * 128,
					texture_rect_y * 128,
					128,
					128
				},
				color = color,
				layer = 1,
				blend_mode = "add"
			})
			item.panel:text({
				name = "text",
				x = 0,
				y = item_height - tweak_data.menu.pd2_small_font_size - border_size,
				w = item_width,
				text = "",
				layer = 1,
				wrap = false,
				word_wrap = false,
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				align = "center"
			})
			local glow = item.panel:bitmap({
				name = "unlock_glow",
				w = size * 2,
				h = size * 2,
				texture = "guis/textures/pd2/crimenet_marker_glow",
				blend_mode = "add",
				color = tweak_data.screen_colors.button_stage_3,
				rotation = 360
			})
			glow:set_center(item.panel:child("image"):center_x(), item.panel:child("image"):center_y() - 25)
			glow:set_visible(item.owned)
			local anim_pulse_glow = function(o)
				local t = 0
				local dt = 0
				while true do
					dt = coroutine.yield()
					t = (t + dt * 0.5) % 1
					o:set_alpha((math.sin(t * 180) * 0.5 + 0.5) * 0.8)
				end
			end
			glow:animate(anim_pulse_glow)
		else
			local infamy_tweak = tweak_data.infamy.items["infamy_secret_" .. secret_count]
			secret_count = secret_count + 1
			local texture_rect_x = infamy_tweak.icon_xy and infamy_tweak.icon_xy[1] or 0
			local texture_rect_y = infamy_tweak.icon_xy and infamy_tweak.icon_xy[2] or 0
			item.owned = false
			item.unlocked = false
			item.panel:bitmap({
				name = "image",
				x = pos,
				y = border_size,
				w = size,
				h = size,
				texture = "guis/dlcs/infamous/textures/pd2/infamous_tree/infamous_tree_atlas",
				texture_rect = {
					texture_rect_x * 128,
					texture_rect_y * 128,
					128,
					128
				},
				color = tweak_data.screen_colors.item_stage_3,
				layer = 1,
				blend_mode = "add"
			})
			item.panel:text({
				name = "text",
				x = 0,
				y = item_height - tweak_data.menu.pd2_small_font_size - border_size,
				w = item_width,
				text = "",
				layer = 1,
				wrap = false,
				word_wrap = false,
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				align = "center"
			})
		end
		item.border = BoxGuiObject:new(item.panel, {
			sides = {
				0,
				0,
				0,
				0
			}
		})
	end
	local points_text = self._panel:text({
		name = "points",
		text = utf8.to_upper(managers.localization:text("st_menu_infamy_available_points", {
			points = managers.infamy:points()
		})),
		layer = 1,
		wrap = false,
		word_wrap = false,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text,
		align = "right"
	})
	local _, _, w, h = points_text:text_rect()
	points_text:set_size(self._tree_panel:w(), h)
	points_text:set_top(self._tree_panel:bottom() + 5)
	points_text:set_right(self._tree_panel:right())
	if managers.menu:is_pc_controller() then
		local back_text = self._panel:text({
			name = "back_button",
			text = utf8.to_upper(managers.localization:text("menu_back")),
			align = "right",
			vertical = "bottom",
			h = tweak_data.menu.pd2_large_font_size,
			font_size = tweak_data.menu.pd2_large_font_size,
			font = tweak_data.menu.pd2_large_font,
			blend_mode = "add",
			color = tweak_data.screen_colors.button_stage_3
		})
		local _, _, w, h = back_text:text_rect()
		back_text:set_size(w, h)
		back_text:set_position(math.round(back_text:x()), math.round(back_text:y()))
		back_text:set_right(self._panel:w())
		back_text:set_bottom(self._panel:h())
		local bg_back = self._fullscreen_panel:text({
			name = "back_button",
			text = utf8.to_upper(managers.localization:text("menu_back")),
			h = 90,
			align = "right",
			vertical = "bottom",
			blend_mode = "add",
			font_size = tweak_data.menu.pd2_massive_font_size,
			font = tweak_data.menu.pd2_massive_font,
			color = tweak_data.screen_colors.button_stage_3,
			alpha = 0.4,
			layer = 1
		})
		local x, y = managers.gui_data:safe_to_full_16_9(self._panel:child("back_button"):world_right(), self._panel:child("back_button"):world_center_y())
		bg_back:set_world_right(x)
		bg_back:set_world_center_y(y)
		bg_back:move(13, -9)
		MenuBackdropGUI.animate_bg_text(self, bg_back)
	end
	local black_rect = self._fullscreen_panel:rect({
		color = Color(0.4, 0, 0, 0),
		layer = 1
	})
	local blur = self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_ws:panel():w(),
		h = self._fullscreen_ws:panel():h(),
		render_template = "VertexColorTexturedBlur3D",
		layer = -1
	})
	local func = function(o)
		over(0.6, function(p)
			o:set_alpha(p)
		end)
	end
	blur:animate(func)
	self:_select_item(1)
	if managers.experience:current_rank() == 0 then
		managers.menu:show_infamous_message(MenuCallbackHandler:can_become_infamous() and managers.money:offshore() >= Application:digest_value(tweak_data.infamy.ranks[managers.experience:current_rank() + 1], false))
	end
end

function InfamyTreeGui:_flash_item(item)
	local text = item.panel:child("text")
	local image = item.panel:child("image")
	local border = item.border
	
	local function flash_anim()
		local color = tweak_data.screen_colors.item_stage_1
		local lerp_color
		over(0.5, function(t)
			lerp_color = math.lerp(color, tweak_data.screen_colors.important_1, math.min(1, math.sin(t * 180) * 2))
			text:set_color(lerp_color)
			image:set_color(lerp_color)
			border:set_color(lerp_color)
		end)
		text:set_color(color)
		image:set_color(color)
		border:set_color(color)
	end
	
	managers.menu_component:post_event("menu_error")
	item.panel:stop()
	item.panel:animate(flash_anim)
end

function InfamyTreeGui:_update_description(name, unlocked)
	local desc_title = self._description_panel:child("description_title")
	local desc_text = self._description_panel:child("description_text")
	local desc_warning = self._description_panel:child("description_warning")
	local desc_upgrade = self._description_panel:child("description_upgrade")
	if desc_upgrade then
		for i, data in pairs(self._requested_textures) do
			managers.menu_component:unretrieve_texture(data.texture, data.texture_count)
		end
		self._requested_textures = {}
		self._description_panel:remove(desc_upgrade)
	end
	if name then
		local infamy_tweak = tweak_data.infamy.items[name]
		local params = deep_clone(infamy_tweak.desc_params)
		if infamy_tweak.upgrades and infamy_tweak.upgrades.infamous_lootdrop then
			local stars = managers.experience:level_to_stars()
			local item_pc = tweak_data.lootdrop.STARS[stars].pcs[1]
			local skip_types = {cash = true, xp = true}
			local droppable_items = managers.lootdrop:droppable_items(item_pc, true, skip_types)
			local items_total = 0
			local items_infamous = 0
			for type, items in pairs(droppable_items) do
				items_total = items_total + #items
				for _, item in pairs(items) do
					if item.global_value == "infamous" then
						items_infamous = items_infamous + 1
					end
				end
			end
			local _, infamous_base_chance, infamous_mod = managers.lootdrop:infamous_chance()
			local infamous_chance = 0 < items_total and infamous_base_chance * (items_infamous / items_total) or 0
			local mult = 10
			local base_text = math.floor(infamous_chance * 100 * mult + 0.5) / mult
			local buffed_text = base_text * infamy_tweak.upgrades.infamous_lootdrop
			params.base_chance = string.format("%.1f", base_text) .. "%"
			params.buffed_chance = string.format("%.1f", buffed_text) .. "%"
		end
		local title_text = utf8.to_upper(managers.localization:text(infamy_tweak.name_id))
		if infamy_tweak.add_tier then
			local index = table.get_key(tweak_data.infamy.tree, name) or 0
			if 0 < index then
				local tier = math.floor((index + 2) / InfamyTreeGui.tree_cols)
				title_text = managers.localization:to_upper_text("st_menu_tier", {
					tier = string.format("%02d", tier)
				}) .. ": " .. title_text
			end
		end
		desc_title:set_text(title_text)
		desc_warning:set_text(unlocked and "" or utf8.to_upper(managers.localization:text("menu_infamy_unlock_prev_tier")))
		desc_text:set_text((managers.localization:text(infamy_tweak.desc_id, params)))
		managers.menu_component:add_colors_to_text_object(desc_text, tweak_data.screen_colors.resource)
	else
		desc_title:set_text(utf8.to_upper(managers.localization:text("st_menu_infamy_secret")))
		desc_warning:set_text("")
		desc_text:set_text(managers.localization:text("st_menu_infamy_secret_desc"))
	end
	local _, _, _, h = desc_title:text_rect()
	desc_title:set_size(self._description_panel:w() - 20, h)
	local _, _, _, h = desc_warning:text_rect()
	desc_warning:set_size(self._description_panel:w() - 20, h)
	desc_warning:set_top(desc_title:bottom() + 20)
	local _, _, _, h = desc_text:text_rect()
	desc_text:set_size(self._description_panel:w() - 20, h)
	desc_text:set_top(desc_warning:bottom() + 10)
	if name then
		desc_upgrade = self._description_panel:panel({
			name = "description_upgrade"
		})
		local infamy_tweak = tweak_data.infamy.items[name]
		local category_list = {
			mask = "masks",
			texture = "textures",
			material = "materials",
			color = "colors"
		}
		local icon_size = 64
		local y = desc_text:bottom() + 10
		for bonus, item in ipairs(infamy_tweak.upgrades) do
			local global_value = item[1]
			local category = item[2]
			local item_id = item[3]
			local item_tweak_data = tweak_data.blackmarket[category][item_id]
			local guis_catalog = "guis/"
			local bundle_folder = item_tweak_data and item_tweak_data.texture_bundle_folder
			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end
			if category == "colors" then
				desc_upgrade:bitmap({
					name = item_id .. "_color_bg",
					x = 10,
					y = y,
					w = icon_size,
					h = icon_size,
					texture = "guis/textures/pd2/blackmarket/icons/colors/color_bg",
					layer = 2
				})
				desc_upgrade:bitmap({
					name = item_id .. "_color_1",
					x = 10,
					y = y,
					w = icon_size,
					h = icon_size,
					texture = "guis/textures/pd2/blackmarket/icons/colors/color_02",
					layer = 1,
					color = tweak_data.blackmarket.colors[item_id].colors[1]
				})
				desc_upgrade:bitmap({
					name = item_id .. "_color_2",
					x = 10,
					y = y,
					w = icon_size,
					h = icon_size,
					texture = "guis/textures/pd2/blackmarket/icons/colors/color_01",
					layer = 1,
					color = tweak_data.blackmarket.colors[item_id].colors[2]
				})
			elseif category == "textures" then
				local icon_texture = tweak_data.blackmarket.textures[item_id].texture
				if DB:has(Idstring("texture"), icon_texture) then
					local panel = desc_upgrade:panel({
						name = item_id .. "_image",
						x = 10,
						y = y,
						w = icon_size,
						h = icon_size,
						layer = 1
					})
					local texture_count = managers.menu_component:request_texture(icon_texture, callback(self, self, "_texture_done_clbk", {
						panel = panel,
						render_template = "VertexColorTexturedPatterns"
					}))
					table.insert(self._requested_textures, {texture_count = texture_count, texture = icon_texture})
				end
			else
				local icon_texture = guis_catalog .. "textures/pd2/blackmarket/icons/" .. category .. "/" .. item_id
				if DB:has(Idstring("texture"), icon_texture) then
					if category == "materials" then
						local panel = desc_upgrade:panel({
							name = item_id .. "_image",
							x = 10,
							y = y,
							w = icon_size,
							h = icon_size,
							layer = 1
						})
						local texture_count = managers.menu_component:request_texture(icon_texture, callback(self, self, "_texture_done_clbk", {panel = panel}))
						table.insert(self._requested_textures, {texture_count = texture_count, texture = icon_texture})
					else
						desc_upgrade:bitmap({
							name = item_id .. "_image",
							x = 10,
							y = y,
							w = icon_size,
							h = icon_size,
							texture = icon_texture,
							layer = 1
						})
					end
				end
			end
			local icon_text = desc_upgrade:text({
				name = item_id .. "_text",
				x = icon_size + 20,
				y = y,
				h = icon_size,
				layer = 1,
				wrap = false,
				word_wrap = false,
				font = tweak_data.menu.pd2_medium_font,
				font_size = tweak_data.menu.pd2_medium_font_size,
				vertical = "center"
			})
			icon_text:set_text(managers.localization:text(item_tweak_data.name_id))
			y = y + icon_size
		end
	end
end

function InfamyTreeGui:_texture_done_clbk(params, texture_ids)
	if alive(params.panel) then
		params.panel:bitmap({
			texture = texture_ids,
			w = params.panel:w(),
			h = params.panel:h(),
			render_template = params.render_template
		})
	end
end

function InfamyTreeGui:_unlock_item(index)
	if not self._tree_items[index] then
		return
	end
	if not self._tree_items[index].unlocked then
		self:_flash_item(self._tree_items[index])
		return
	end
	if self._tree_items[index].owned then
		return
	end
	local infamy_name = tweak_data.infamy.tree[index]
	if managers.infamy:required_points(infamy_name) then
		local params = {}
		params.text_string = "dialog_unlock_infamyitem"
		params.infamy_item = managers.localization:to_upper_text(tweak_data.infamy.items[infamy_name].name_id)
		params.points = Application:digest_value(tweak_data.infamy.items[infamy_name].cost, false)
		params.remaining_points = managers.infamy:points()
		params.yes_func = callback(self, self, "_dialog_confirm_yes", index)
		managers.menu:show_confirm_infamypoints(params)
	else
		self:_flash_item(self._tree_items[index])
	end
end

function InfamyTreeGui:_select_item(index)
	if self._selected_item ~= index then
		if self._selected_item then
			local selected_item = self._tree_items[self._selected_item]
			selected_item.panel:stop()
			selected_item.border:create_sides(selected_item.panel, {
				sides = {
					0,
					0,
					0,
					0
				}
			})
			selected_item.panel:child("image"):set_color(self._tree_items[self._selected_item].owned and tweak_data.screen_colors.item_stage_1 or self._tree_items[self._selected_item].unlocked and tweak_data.screen_colors.item_stage_2 or tweak_data.screen_colors.item_stage_3)
			selected_item.panel:child("text"):set_text("")
		end
		self._selected_item = index
		local infamy_name = tweak_data.infamy.tree[index]
		local item = self._tree_items[index]
		local text = infamy_name and (item.owned and "st_menu_skill_owned" or item.unlocked and "st_menu_point" or "st_menu_skill_locked") or "st_menu_infamy_secret"
		item.panel:child("text"):set_text(utf8.to_upper(managers.localization:text(text, {
			points = infamy_name and Application:digest_value(tweak_data.infamy.items[infamy_name].cost, false) or 0
		})))
		item.panel:child("text"):set_color(tweak_data.screen_colors.text)
		item.panel:child("image"):set_color(tweak_data.screen_colors.item_stage_1)
		item.border:create_sides(item.panel, {
			sides = {
				2,
				2,
				2,
				2
			}
		})
		self:_update_description(infamy_name, item.unlocked)
	end
end

function InfamyTreeGui:_dialog_confirm_yes(index)
	local infamy_item = self._tree_items[index]
	local infamy_name = tweak_data.infamy.tree[index]
	managers.infamy:unlock_item(infamy_name)
	infamy_item.owned = true
	infamy_item.panel:child("image"):set_color(tweak_data.screen_colors.item_stage_1)
	infamy_item.panel:child("unlock_glow"):show()
	managers.menu_component:post_event("menu_skill_investment")
	SimpleGUIEffectSpewer.infamous_up(infamy_item.panel:child("image"):center_x(), infamy_item.panel:child("image"):center_y() - 20, infamy_item.panel)
	self._panel:child("points"):set_text(utf8.to_upper(managers.localization:text("st_menu_infamy_available_points", {
		points = managers.infamy:points()
	})))
	if self._selected_item == index then
		infamy_item.panel:child("text"):set_text(utf8.to_upper(managers.localization:text("st_menu_skill_owned")))
	end
	for index, item in pairs(self._tree_items) do
		item.unlocked = managers.infamy:available(tweak_data.infamy.tree[index])
		item.panel:child("image"):set_color(item.owned and tweak_data.screen_colors.item_stage_1 or item.unlocked and tweak_data.screen_colors.item_stage_2 or tweak_data.screen_colors.item_stage_3)
	end
end

function InfamyTreeGui:set_layer(layer)
	self._panel:set_layer(self._init_layer + layer)
end

function InfamyTreeGui:input_focus()
	return 1
end

function InfamyTreeGui:mouse_moved(o, x, y)
	for index, item in pairs(self._tree_items) do
		if item.panel:inside(x, y) then
			self:_select_item(index)
			return true
		end
	end
	if managers.menu:is_pc_controller() then
		local back_button = self._panel:child("back_button")
		if back_button:inside(x, y) then
			if not self._back_highlight then
				self._back_highlight = true
				back_button:set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end
		else
			self._back_highlight = false
			back_button:set_color(tweak_data.screen_colors.button_stage_3)
		end
	end
	if self._panel:inside(x, y) then
		return true
	end
end

function InfamyTreeGui:mouse_pressed(button, x, y)
	if button == Idstring("0") then
		if self._panel:child("back_button"):inside(x, y) then
			managers.menu:back()
			return
		end
		if self._selected_item then
			local infamy_item = self._tree_items[self._selected_item]
			if infamy_item and infamy_item.panel:inside(x, y) then
				self:_unlock_item(self._selected_item)
			end
		end
	end
end

function InfamyTreeGui:move_up()
	if not self._selected_item then
		self:_select_item(1)
	elseif self._selected_item == 1 then
		self:_select_item(3)
	elseif self._selected_item + 4 <= #self._tree_items - 1 then
		self:_select_item(self._selected_item + 4)
	else
		self:_select_item(#self._tree_items)
	end
end

function InfamyTreeGui:move_down()
	if not self._selected_item then
		self:_select_item(1)
	elseif self._selected_item == #self._tree_items then
		self:_select_item(#self._tree_items - 2)
	elseif self._selected_item > 1 then
		self:_select_item(math.max(1, self._selected_item - 4))
	end
end

function InfamyTreeGui:move_left()
	if not self._selected_item then
		self:_select_item(1)
	elseif self._selected_item == 1 then
		self:_select_item(2)
	elseif self._selected_item == #self._tree_items then
		self:_select_item(#self._tree_items - 4)
	elseif self._selected_item % 4 ~= 2 then
		self:_select_item(self._selected_item - 1)
	end
end

function InfamyTreeGui:move_right()
	if not self._selected_item then
		self:_select_item(1)
	elseif self._selected_item == 1 then
		self:_select_item(5)
	elseif self._selected_item == #self._tree_items then
		self:_select_item(#self._tree_items - 1)
	elseif self._selected_item % 4 ~= 1 then
		self:_select_item(self._selected_item + 1)
	end
end

function InfamyTreeGui:confirm_pressed()
	if self._selected_item then
		self:_unlock_item(self._selected_item)
	end
	return false
end

function InfamyTreeGui:close()
	managers.menu:active_menu().renderer.ws:show()
	WalletGuiObject.close_wallet(self._panel)
	for i, data in pairs(self._requested_textures) do
		managers.menu_component:unretrieve_texture(data.texture, data.texture_count)
	end
	self._requested_textures = {}
	for _, item in pairs(self._tree_items) do
		item.border:close()
	end
	self._ws:panel():remove(self._panel)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
end
