require("lib/managers/menu/WalletGuiObject")
SkillTreeLogic = SkillTreeLogic or class()
local NOT_WIN_32 = SystemInfo:platform() ~= Idstring("WIN32")
local WIDTH_MULTIPLIER = NOT_WIN_32 and 0.6 or 0.6
local CONSOLE_PAGE_ADJUSTMENT = NOT_WIN_32 and 1 or 0
local BOX_GAP = 54
SkillTreeItem = SkillTreeItem or class()

function SkillTreeItem:init()
	self._left_item = nil
	self._right_item = nil
	self._up_item = nil
	self._down_item = nil
end

function SkillTreeItem:refresh()
end

function SkillTreeItem:inside()
end

function SkillTreeItem:select(no_sound)
	if not self._selected then
		self._selected = true
		self:refresh()
		if not no_sound then
			managers.menu_component:post_event("highlight")
		end
	end
end

function SkillTreeItem:deselect()
	if self._selected then
		self._selected = false
		self:refresh()
	end
end

function SkillTreeItem:trigger()
	managers.menu_component:post_event("menu_enter")
	self:refresh()
end

function SkillTreeItem:flash()
end

SkillTreeTabItem = SkillTreeTabItem or class(SkillTreeItem)

function SkillTreeTabItem:init(tree_tabs_panel, tree, data, w, x)
	SkillTreeTabItem.super.init(self)
	self._tree = tree
	self._tree_tab = tree_tabs_panel:panel({
		name = "" .. tree,
		w = w,
		x = x
	})
	self._tree_tab:text({
		name = "tree_tab_name",
		text = utf8.to_upper(managers.localization:text(data.name_id)),
		layer = 1,
		wrap = false,
		word_wrap = false,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.button_stage_3,
		align = "center",
		vertical = "center"
	})
	local _, _, tw, th = self._tree_tab:child("tree_tab_name"):text_rect()
	self._tree_tab:set_size(tw + 15, th + 10)
	self._tree_tab:child("tree_tab_name"):set_size(self._tree_tab:size())
	self._tree_tab:bitmap({
		name = "tree_tab_select_rect",
		texture = "guis/textures/pd2/shared_tab_box",
		w = self._tree_tab:w(),
		h = self._tree_tab:h(),
		layer = 0,
		color = tweak_data.screen_colors.text,
		visible = false
	})
	self._tree_tab:move(0, 0)
end

function SkillTreeTabItem:set_active(active)
	self._active = active
	self:refresh()
end

function SkillTreeTabItem:tree()
	return self._tree
end

function SkillTreeTabItem:inside(x, y)
	return self._tree_tab:inside(x, y)
end

function SkillTreeTabItem:refresh()
	if self._active then
		self._tree_tab:child("tree_tab_select_rect"):show()
		self._tree_tab:child("tree_tab_name"):set_color(tweak_data.screen_colors.button_stage_1)
		self._tree_tab:child("tree_tab_name"):set_blend_mode("normal")
	elseif self._selected then
		self._tree_tab:child("tree_tab_select_rect"):hide()
		self._tree_tab:child("tree_tab_name"):set_color(tweak_data.screen_colors.button_stage_2)
		self._tree_tab:child("tree_tab_name"):set_blend_mode("add")
	else
		self._tree_tab:child("tree_tab_select_rect"):hide()
		self._tree_tab:child("tree_tab_name"):set_color(tweak_data.screen_colors.button_stage_3)
		self._tree_tab:child("tree_tab_name"):set_blend_mode("add")
	end
end

SkillTreeSkillItem = SkillTreeSkillItem or class(SkillTreeItem)

function SkillTreeSkillItem:init(skill_id, tier_panel, num_skills, i, tree, tier, w, h, skill_refresh_skills)
	SkillTreeSkillItem.super.init(self)
	self._skill_id = skill_id
	self._tree = tree
	self._tier = tier
	local skill_panel = tier_panel:panel({
		name = skill_id,
		w = w,
		h = h
	})
	self._skill_panel = skill_panel
	self._skill_refresh_skills = skill_refresh_skills
	local skill = tweak_data.skilltree.skills[skill_id]
	self._skill_name = managers.localization:text(skill.name_id)
	local texture_rect_x = skill.icon_xy and skill.icon_xy[1] or 0
	local texture_rect_y = skill.icon_xy and skill.icon_xy[2] or 0
	self._base_size = h - 10
	local state_image = skill_panel:bitmap({
		name = "state_image",
		texture = "guis/textures/pd2/skilltree/icons_atlas",
		texture_rect = {
			texture_rect_x * 64,
			texture_rect_y * 64,
			64,
			64
		},
		color = tweak_data.screen_colors.item_stage_3,
		layer = 1
	})
	state_image:set_size(self._base_size, self._base_size)
	state_image:set_blend_mode("add")
	local skill_text = skill_panel:text({
		name = "skill_text",
		text = "",
		layer = 3,
		wrap = true,
		word_wrap = true,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		align = "left",
		vertical = "center",
		color = tweak_data.screen_colors.text,
		blend_mode = "add",
		x = self._base_size + 10,
		w = skill_panel:w() - self._base_size - 10
	})
	state_image:set_x(5)
	state_image:set_center_y(skill_panel:h() / 2)
	self._inside_panel = skill_panel:panel({
		w = w - 10,
		h = h - 10
	})
	self._inside_panel:set_center(skill_panel:w() / 2, skill_panel:h() / 2)
	local cx = tier_panel:w() / num_skills
	skill_panel:set_x((i - 1) * w)
	self._box = BoxGuiObject:new(skill_panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	self._box:hide()
	local state_indicator = skill_panel:bitmap({
		name = "state_indicator",
		texture = "guis/textures/pd2/skilltree/ace",
		alpha = 0,
		color = Color.white:with_alpha(1),
		layer = 0
	})
	state_indicator:set_size(state_image:w() * 2, state_image:h() * 2)
	state_indicator:set_blend_mode("add")
	state_indicator:set_rotation(360)
	state_indicator:set_center(state_image:center())
end

function SkillTreeSkillItem:tier()
	return self._tier
end

function SkillTreeSkillItem:skill_id()
	return self._skill_id
end

function SkillTreeSkillItem:tree()
	return self._tree
end

function SkillTreeSkillItem:link(i, items)
	if i == 1 then
		self._left_item = items[2]
		self._up_item = items[3]
		self._right_item = items[4]
	else
		self._left_item = i % 3 ~= 2 and items[i - 1]
		self._right_item = i % 3 ~= 1 and items[i + 1]
		self._up_item = items[math.max(1, i + 3)]
		self._down_item = items[math.max(1, i - 3)]
	end
end

function SkillTreeSkillItem:inside(x, y)
	return self._inside_panel:inside(x, y)
end

function SkillTreeSkillItem:flash()
	local skill_text = self._skill_panel:child("skill_text")
	local state_image = self._skill_panel:child("state_image")
	local box = self._box
	
	local function flash_anim(panel)
		local st_color = skill_text:color()
		local si_color = state_image:color()
		local b_color = box:color()
		local s = 0
		over(0.5, function(t)
			s = math.min(1, math.sin(t * 180) * 2)
			skill_text:set_color(math.lerp(st_color, tweak_data.screen_colors.important_1, s))
			state_image:set_color(math.lerp(si_color, tweak_data.screen_colors.important_1, s))
			box:set_color(math.lerp(b_color, tweak_data.screen_colors.important_1, s))
		end)
		skill_text:set_color(st_color)
		state_image:set_color(si_color)
		box:set_color(b_color)
	end
	
	managers.menu_component:post_event("selection_next")
	self:refresh(self._locked)
	self._skill_panel:animate(flash_anim)
end

function SkillTreeSkillItem:refresh(locked)
	if not alive(self._skill_panel) then
		return
	end
	local skill_id = self._skill_panel:name()
	self._skill_panel:stop()
	local step = managers.skilltree:next_skill_step(skill_id)
	local unlocked = managers.skilltree:skill_unlocked(nil, skill_id) or not self._tier
	local completed = managers.skilltree:skill_completed(skill_id)
	local talent = tweak_data.skilltree.skills[skill_id]
	self._locked = locked
	if Application:production_build() then
	end
	local selected = self._selected
	self._box:set_visible(selected)
	self._box:set_color(tweak_data.screen_colors.item_stage_1)
	local skill_text = self._skill_panel:child("skill_text")
	local skill_text_string = ""
	if selected then
		if not self._tier then
			if step == 1 then
				skill_text_string = managers.localization:text("st_menu_unlock_profession", {
					profession = managers.localization:text(tweak_data.skilltree.trees[self._tree].name_id),
					points = managers.skilltree:get_skill_points(self._skill_id, 1)
				})
			else
				skill_text_string = managers.localization:text("st_menu_profession_unlocked", {
					profession = managers.localization:text(tweak_data.skilltree.trees[self._tree].name_id)
				})
			end
		elseif completed then
			skill_text_string = managers.localization:text("st_menu_skill_maxed")
		elseif step == 2 then
			local points = managers.skilltree:get_skill_points(self._skill_id, 2)
			local cost = managers.money:get_skillpoint_cost(self._tree, self._tier, points)
			skill_text_string = managers.localization:text("st_menu_buy_skill_pro" .. (1 < points and "_plural" or ""), {
				cost = managers.experience:cash_string(cost),
				points = points
			})
		elseif not unlocked then
			skill_text_string = managers.localization:text("st_menu_skill_locked")
		elseif step == 1 then
			local points = managers.skilltree:get_skill_points(self._skill_id, 1)
			local cost = managers.money:get_skillpoint_cost(self._tree, self._tier, points)
			skill_text_string = managers.localization:text("st_menu_buy_skill_basic" .. (1 < points and "_plural" or ""), {
				cost = managers.experience:cash_string(cost),
				points = points
			})
		else
			skill_text_string = "MISSING"
		end
	elseif self._tier then
		if completed then
			skill_text_string = managers.localization:text("st_menu_skill_maxed")
		elseif step == 2 then
			skill_text_string = managers.localization:text("st_menu_skill_owned")
		end
	end
	skill_text:set_text(utf8.to_upper(skill_text_string))
	skill_text:set_color(tweak_data.screen_colors.item_stage_1)
	if not self._tier then
		self._skill_panel:child("state_indicator"):set_alpha(0)
		self._skill_panel:child("state_image"):set_color(tweak_data.screen_colors[(1 < step or selected) and "item_stage_1" or "item_stage_2"])
		return
	end
	local color = (completed or selected or 1 < step) and tweak_data.screen_colors.item_stage_1 or unlocked and tweak_data.screen_colors.item_stage_2 or tweak_data.screen_colors.item_stage_3
	self._skill_panel:child("state_image"):set_color(color)
	if completed then
		self._skill_panel:child("state_indicator"):set_alpha(1)
		return
	end
	if unlocked then
		if step == 2 then
		else
			self._skill_panel:child("state_indicator"):set_alpha(0)
		end
	else
		if selected then
		else
		end
	end
	if unlocked then
		local prerequisites = talent.prerequisites or {}
		for _, prerequisite in ipairs(prerequisites) do
			local req_unlocked = managers.skilltree:skill_step(prerequisite)
			if req_unlocked and req_unlocked == 0 then
				self._skill_panel:child("state_image"):set_color(tweak_data.screen_colors[selected and "important_1" or "important_2"])
				self._box:set_color(tweak_data.screen_colors[selected and "important_1" or "important_2"])
				if selected then
					skill_text:set_color(tweak_data.screen_colors.important_1)
					skill_text:set_text(utf8.to_upper(managers.localization:text("st_menu_skill_locked")))
				end
				break
			end
		end
	end
end

function SkillTreeSkillItem:trigger()
	if managers.skilltree:tier_unlocked(self._tree, self._tier) then
		managers.skilltree:unlock(self._tree, self._skill_id)
	end
	self:refresh(self._locked)
	return self._skill_refresh_skills
end

SkillTreeUnlockItem = SkillTreeUnlockItem or class(SkillTreeSkillItem)

function SkillTreeUnlockItem:init(skill_id, parent_panel, tree, base_size, h)
	SkillTreeUnlockItem.super.init(self, skill_id, parent_panel, 1, 2, tree, nil, base_size, h)
end

function SkillTreeUnlockItem:trigger()
	if not managers.skilltree:tree_unlocked(self._tree) then
		managers.skilltree:unlock_tree(self._tree)
		self:refresh(self._locked)
	end
end

SkillTreePage = SkillTreePage or class()

function SkillTreePage:init(tree, data, parent_panel, fullscreen_panel, tree_tab_h, skill_prerequisites)
	self._items = {}
	self._selected_item = nil
	self._tree = tree
	local tree_panel = parent_panel:panel({
		name = tostring(tree),
		visible = false,
		y = 0,
		w = math.round(parent_panel:w() * WIDTH_MULTIPLIER)
	})
	self._tree_panel = tree_panel
	self._bg_image = fullscreen_panel:bitmap({
		name = "bg_image",
		texture = data.background_texture,
		w = fullscreen_panel:w(),
		h = fullscreen_panel:h(),
		layer = 1,
		blend_mode = "add"
	})
	self._bg_image:set_alpha(0.6)
	local aspect = fullscreen_panel:w() / fullscreen_panel:h()
	local texture_width = self._bg_image:texture_width()
	local texture_height = self._bg_image:texture_height()
	local sw = math.max(texture_width, texture_height * aspect)
	local sh = math.max(texture_height, texture_width / aspect)
	local dw = texture_width / sw
	local dh = texture_height / sh
	self._bg_image:set_size(dw * fullscreen_panel:w(), dh * fullscreen_panel:h())
	self._bg_image:set_right(fullscreen_panel:w())
	self._bg_image:set_center_y(fullscreen_panel:h() / 2)
	local panel_h = 0
	local h = (parent_panel:h() - tree_tab_h - 70) / (8 - CONSOLE_PAGE_ADJUSTMENT)
	for i = 1, 7 do
		local color = Color.black
		local rect = tree_panel:rect({
			name = "rect" .. i,
			color = color,
			h = 2,
			blend_mode = "add"
		})
		repeat
			rect:set_bottom(tree_panel:h() - (i - CONSOLE_PAGE_ADJUSTMENT) * h)
			break -- pseudo-goto
		until true
		if i == 1 then
			rect:set_alpha(0)
			rect:hide()
		end
	end
	local tier_panels = tree_panel:panel({
		name = "tier_panels"
	})
	if data.skill then
		local tier_panel = tier_panels:panel({
			name = "tier_panel0",
			h = h
		})
		tier_panel:set_bottom(tree_panel:child("rect1"):top())
		local item = SkillTreeUnlockItem:new(data.skill, tier_panel, tree, tier_panel:w() / 3, h)
		table.insert(self._items, item)
		item:refresh(false)
	end
	for tier, tier_data in ipairs(data.tiers) do
		local unlocked = managers.skilltree:tier_unlocked(tree, tier)
		local tier_panel = tier_panels:panel({
			name = "tier_panel" .. tier,
			h = h
		})
		local num_skills = #tier_data
		tier_panel:set_bottom(tree_panel:child("rect" .. tostring(tier + 1)):top())
		local base_size = h
		local base_w = tier_panel:w() / math.max(#tier_data, 1)
		for i, skill_id in ipairs(tier_data) do
			local item = SkillTreeSkillItem:new(skill_id, tier_panel, num_skills, i, tree, tier, base_w, base_size, skill_prerequisites[skill_id])
			table.insert(self._items, item)
			item:refresh(not unlocked)
		end
		local tier_string = tostring(tier)
		local debug_text = tier_panel:text({
			name = "debug_text",
			text = tier_string,
			layer = 2,
			wrap = false,
			word_wrap = false,
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			h = tweak_data.menu.pd2_small_font_size,
			align = "right",
			vertical = "bottom",
			color = tweak_data.screen_colors.item_stage_3,
			blend_mode = "add",
			rotation = 360
		})
		debug_text:set_world_bottom(tree_panel:child("rect" .. tostring(tier + 1)):world_top() + 2)
		local _, _, tw, _ = debug_text:text_rect()
		debug_text:move(tw * 2, 0)
		local lock_image = tier_panel:bitmap({
			name = "lock",
			texture = "guis/textures/pd2/skilltree/padlock",
			layer = 3,
			w = tweak_data.menu.pd2_small_font_size,
			h = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.item_stage_3
		})
		lock_image:set_blend_mode("add")
		lock_image:set_rotation(360)
		lock_image:set_world_position(debug_text:world_right(), debug_text:world_y() - 2)
		lock_image:set_visible(false)
		local cost_string = (managers.skilltree:tier_cost(tree, tier) < 10 and "0" or "") .. tostring(managers.skilltree:tier_cost(tree, tier))
		local cost_text = tier_panel:text({
			name = "cost_text",
			text = cost_string,
			layer = 2,
			wrap = false,
			word_wrap = false,
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			h = tweak_data.menu.pd2_small_font_size,
			align = "left",
			vertical = "bottom",
			color = tweak_data.screen_colors.item_stage_3,
			blend_mode = "add",
			rotation = 360
		})
		cost_text:set_world_bottom(tree_panel:child("rect" .. tostring(tier + 1)):world_top() + 2)
		cost_text:set_x(debug_text:right() + tw * 3)
		local color = unlocked and tweak_data.screen_colors.item_stage_1 or tweak_data.screen_colors.item_stage_2
		debug_text:set_color(color)
		cost_text:set_color(color)
		if not unlocked then
		end
	end
	local ps = managers.skilltree:points_spent(self._tree)
	local max_points = 1
	for _, tier in ipairs(tweak_data.skilltree.trees[self._tree].tiers) do
		for _, skill in ipairs(tier) do
			for to_unlock, _ in ipairs(tweak_data.skilltree.skills[skill]) do
				max_points = max_points + managers.skilltree:get_skill_points(skill, to_unlock)
			end
		end
	end
	local prev_tier_p = 0
	local next_tier_p = max_points
	local ct = 0
	for i = 1, 6 do
		local tier_unlocks = managers.skilltree:tier_cost(self._tree, i)
		if ps < tier_unlocks then
			next_tier_p = tier_unlocks
			break
		end
		ct = i
		prev_tier_p = tier_unlocks
	end
	local diff_p = next_tier_p - prev_tier_p
	local diff_ps = ps - prev_tier_p
	local dh = self._tree_panel:child("rect2"):bottom()
	local prev_tier_object = self._tree_panel:child("rect" .. tostring(ct + 1))
	local next_tier_object = self._tree_panel:child("rect" .. tostring(ct + 2))
	local prev_tier_y = prev_tier_object and prev_tier_object:top() or 0
	local next_tier_y = next_tier_object and next_tier_object:top() or 0
	if not next_tier_object then
		next_tier_object = self._tree_panel:child("rect" .. tostring(ct))
		next_tier_y = next_tier_object and next_tier_object:top() or 0
		next_tier_y = 2 * prev_tier_y - next_tier_y
	end
	if 0 < ct then
		dh = math.max(2, tier_panels:child("tier_panel1"):world_bottom() - math.lerp(prev_tier_y, next_tier_y, diff_ps / diff_p))
	else
		dh = 0
	end
	local points_spent_panel = tree_panel:panel({
		name = "points_spent_panel",
		w = 4,
		h = dh
	})
	self._points_spent_line = BoxGuiObject:new(points_spent_panel, {
		sides = {
			2,
			2,
			0,
			0
		}
	})
	self._points_spent_line:set_clipping(dh == 0)
	points_spent_panel:set_world_center_x(tier_panels:child("tier_panel1"):child("lock"):world_center())
	points_spent_panel:set_world_bottom(tier_panels:child("tier_panel1"):world_bottom())
	for i, item in ipairs(self._items) do
		item:link(i, self._items)
	end
end

function SkillTreePage:unlock_tier(tier)
	local tier_panels = self._tree_panel:child("tier_panels")
	local tier_panel = tier_panels:child("tier_panel" .. tier)
	tier_panel:child("lock"):hide()
	local color = tweak_data.screen_colors.item_stage_1
	self._tree_panel:child("rect" .. tostring(tier + 1)):set_color(color)
	tier_panel:child("debug_text"):set_color(color)
	tier_panel:child("cost_text"):set_color(color)
	for _, item in ipairs(self._items) do
		item:refresh(false)
	end
end

function SkillTreePage:on_points_spent()
	local points_spent_panel = self._tree_panel:child("points_spent_panel")
	local tier_panels = self._tree_panel:child("tier_panels")
	local ps = managers.skilltree:points_spent(self._tree)
	local max_points = 1
	for _, tier in ipairs(tweak_data.skilltree.trees[self._tree].tiers) do
		for _, skill in ipairs(tier) do
			for to_unlock, _ in ipairs(tweak_data.skilltree.skills[skill]) do
				max_points = max_points + managers.skilltree:get_skill_points(skill, to_unlock)
			end
		end
	end
	local prev_tier_p = 0
	local next_tier_p = max_points
	local ct = 0
	for i = 1, 6 do
		local tier_unlocks = managers.skilltree:tier_cost(self._tree, i)
		if ps < tier_unlocks then
			next_tier_p = tier_unlocks
			break
		end
		ct = i
		prev_tier_p = tier_unlocks
	end
	local diff_p = next_tier_p - prev_tier_p
	local diff_ps = ps - prev_tier_p
	local dh = self._tree_panel:child("rect2"):bottom()
	local prev_tier_object = self._tree_panel:child("rect" .. tostring(ct + 1))
	local next_tier_object = self._tree_panel:child("rect" .. tostring(ct + 2))
	local prev_tier_y = prev_tier_object and prev_tier_object:top() or 0
	local next_tier_y = next_tier_object and next_tier_object:top() or 0
	if not next_tier_object then
		next_tier_object = self._tree_panel:child("rect" .. tostring(ct))
		next_tier_y = next_tier_object and next_tier_object:top() or 0
		next_tier_y = 2 * prev_tier_y - next_tier_y
	end
	if 0 < ct then
		dh = math.max(2, tier_panels:child("tier_panel1"):world_bottom() - math.lerp(prev_tier_y, next_tier_y, diff_ps / diff_p))
	else
		dh = 0
	end
	points_spent_panel:set_h(dh)
	self._points_spent_line:create_sides(points_spent_panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	self._points_spent_line:set_clipping(dh == 0)
	points_spent_panel:set_world_center_x(tier_panels:child("tier_panel1"):child("lock"):world_center())
	points_spent_panel:set_world_bottom(tier_panels:child("tier_panel1"):world_bottom())
end

function SkillTreePage:item(item)
	return self._items[item or 1]
end

function SkillTreePage:activate()
	self._tree_panel:set_visible(true)
	self._bg_image:set_visible(true)
end

function SkillTreePage:deactivate()
	self._tree_panel:set_visible(false)
	self._bg_image:set_visible(false)
end

SkillTreeGui = SkillTreeGui or class()

function SkillTreeGui:init(ws, fullscreen_ws, node)
	managers.menu:active_menu().renderer.ws:hide()
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._node = node
	self._init_layer = self._ws:panel():layer()
	self._selected_item = nil
	self._active_page = nil
	self._active_tree = nil
	self._prerequisites_links = {}
	managers.menu_component:close_contract_gui()
	self:_setup()
	self:set_layer(1000)
end

function SkillTreeGui:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end

function SkillTreeGui:_setup()
	if alive(self._panel) then
		self._ws:panel():remove(self._panel)
	end
	local scaled_size = managers.gui_data:scaled_size()
	self._panel = self._ws:panel():panel({
		visible = true,
		layer = self._init_layer,
		valign = "center"
	})
	self._fullscreen_panel = self._fullscreen_ws:panel():panel()
	WalletGuiObject.set_wallet(self._panel)
	self._panel:text({
		name = "skilltree_text",
		text = utf8.to_upper(managers.localization:text("menu_skilltree")),
		align = "left",
		vertical = "top",
		h = tweak_data.menu.pd2_large_font_size,
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text
	})
	local bg_text = self._fullscreen_panel:text({
		name = "skilltree_text",
		text = utf8.to_upper(managers.localization:text("menu_skilltree")),
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
	local x, y = managers.gui_data:safe_to_full_16_9(self._panel:child("skilltree_text"):world_x(), self._panel:child("skilltree_text"):world_center_y())
	bg_text:set_world_left(x)
	bg_text:set_world_center_y(y)
	bg_text:move(-13, 9)
	MenuBackdropGUI.animate_bg_text(self, bg_text)
	local points_text = self._panel:text({
		name = "points_text",
		text = utf8.to_upper(managers.localization:text("st_menu_available_skill_points", {
			points = managers.skilltree:points()
		})),
		layer = 1,
		wrap = false,
		word_wrap = false,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text,
		align = "left",
		vertical = "top"
	})
	points_text:set_left(self._panel:w() * WIDTH_MULTIPLIER * 2 / 3 + 10)
	if managers.menu:is_pc_controller() then
		self._panel:text({
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
		self:make_fine_text(self._panel:child("back_button"))
		self._panel:child("back_button"):set_right(self._panel:w())
		self._panel:child("back_button"):set_bottom(self._panel:h())
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
	local prefix = not managers.menu:is_pc_controller() and managers.localization:get_default_macro("BTN_Y") or ""
	self._panel:text({
		name = "respec_tree_button",
		text = prefix .. managers.localization:to_upper_text("st_menu_respec_tree"),
		align = "left",
		vertical = "top",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = Color.black,
		blend_mode = "add"
	})
	self:make_fine_text(self._panel:child("respec_tree_button"))
	self._panel:child("respec_tree_button"):set_left(points_text:left())
	self._respec_text_id = "st_menu_respec_tree"
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
	local tree_tab_h = math.round(self._panel:h() / 14)
	local tree_tabs_panel = self._panel:panel({
		name = "tree_tabs_panel",
		h = tree_tab_h,
		y = 71
	})
	local skill_title_panel = self._panel:panel({
		name = "skill_title_panel",
		w = math.round(self._panel:w() * 0.4 - 54),
		h = math.round(tweak_data.menu.pd2_medium_font_size * 2)
	})
	self._skill_title_panel = skill_title_panel
	skill_title_panel:text({
		name = "text",
		text = "",
		layer = 1,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text,
		align = "left",
		vertical = "top",
		wrap = true,
		word_wrap = true,
		blend_mode = "add"
	})
	local skill_description_panel = self._panel:panel({
		name = "skill_description_panel",
		w = math.round(self._panel:w() * (1 - WIDTH_MULTIPLIER) - BOX_GAP),
		h = math.round(self._panel:h() * 0.8)
	})
	self._skill_description_panel = skill_description_panel
	skill_description_panel:text({
		name = "text",
		text = "",
		layer = 1,
		wrap = false,
		word_wrap = false,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.text,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale",
		wrap = true,
		word_wrap = true
	})
	skill_description_panel:text({
		name = "prerequisites_text",
		text = "",
		layer = 1,
		wrap = false,
		word_wrap = false,
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		h = tweak_data.menu.pd2_small_font_size + 10,
		color = tweak_data.screen_colors.important_1,
		align = "left",
		vertical = "top",
		halign = "scale",
		valign = "scale",
		wrap = true,
		word_wrap = true
	})
	self._tab_items = {}
	self._pages_order = {}
	self._pages = {}
	local tab_x = 0
	if not managers.menu:is_pc_controller() then
		local prev_page = tree_tabs_panel:text({
			name = "prev_page",
			y = 0,
			w = 0,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			layer = 2,
			text = managers.localization:get_default_macro("BTN_BOTTOM_L")
		})
		local _, _, w = prev_page:text_rect()
		prev_page:set_w(w)
		prev_page:set_left(tab_x)
		tab_x = math.round(tab_x + w + 15)
	end
	local skill_prerequisites = {}
	for skill_id, data in pairs(tweak_data.skilltree.skills) do
		if data.prerequisites then
			for _, id in ipairs(data.prerequisites) do
				skill_prerequisites[id] = skill_prerequisites[id] or {}
				table.insert(skill_prerequisites[id], skill_id)
			end
		end
	end
	for tree, data in pairs(tweak_data.skilltree.trees) do
		local w = math.round(tree_tabs_panel:w() / #tweak_data.skilltree.trees * WIDTH_MULTIPLIER)
		local tab_item = SkillTreeTabItem:new(tree_tabs_panel, tree, data, w, tab_x)
		table.insert(self._tab_items, tab_item)
		local page = SkillTreePage:new(tree, data, self._panel, self._fullscreen_panel, tab_item._tree_tab:h(), skill_prerequisites)
		table.insert(self._pages_order, tree)
		self._pages[tree] = page
		local _, _, tw, _ = self._tab_items[tree]._tree_tab:child("tree_tab_name"):text_rect()
		tab_x = math.round(tab_x + tw + 15 + 5)
	end
	local top_tier_panel = self._panel:child("1"):child("tier_panels"):child("tier_panel" .. tostring(#tweak_data.skilltree.trees[1].tiers))
	local bottom_tier_panel = self._panel:child("1"):child("tier_panels"):child("tier_panel1")
	skill_description_panel:set_right(self._panel:w())
	skill_description_panel:set_h(bottom_tier_panel:world_bottom() - top_tier_panel:world_top())
	skill_description_panel:set_world_top(top_tier_panel:world_top())
	local skill_box_panel = self._panel:panel({
		w = skill_description_panel:w(),
		h = skill_description_panel:h()
	})
	skill_box_panel:set_position(skill_description_panel:position())
	BoxGuiObject:new(skill_box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	points_text:set_top(skill_box_panel:bottom() + 10)
	local _, _, _, pth = points_text:text_rect()
	points_text:set_h(pth)
	local respec_tree_button = self._panel:child("respec_tree_button")
	if alive(respec_tree_button) then
		respec_tree_button:set_top(points_text:bottom())
	end
	skill_title_panel:set_left(skill_box_panel:left() + 10)
	skill_title_panel:set_top(skill_box_panel:top() + 10)
	skill_title_panel:set_w(skill_box_panel:w() - 20)
	skill_description_panel:set_top(skill_title_panel:bottom())
	skill_description_panel:set_h(skill_box_panel:h() - 20 - skill_title_panel:h())
	skill_description_panel:set_left(skill_box_panel:left() + 10)
	skill_description_panel:set_w(skill_box_panel:w() - 20)
	local tiers_box_panel = self._panel:panel({
		name = "tiers_box_panel"
	})
	tiers_box_panel:set_world_shape(top_tier_panel:world_left(), top_tier_panel:world_top(), top_tier_panel:w(), bottom_tier_panel:world_bottom() - top_tier_panel:world_top())
	BoxGuiObject:new(tiers_box_panel, {
		sides = {
			1,
			1,
			2,
			1
		}
	})
	if not managers.menu:is_pc_controller() then
		local next_page = tree_tabs_panel:text({
			name = "next_page",
			y = 0,
			w = 0,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			layer = 2,
			text = managers.localization:get_default_macro("BTN_BOTTOM_R")
		})
		local _, _, w = next_page:text_rect()
		next_page:set_w(w)
		next_page:set_right(tree_tabs_panel:w() * WIDTH_MULTIPLIER)
	end
	self:set_active_page(managers.skilltree:get_most_progressed_tree())
	self:set_selected_item(self._active_page:item(), true)
	self:_rec_round_object(self._panel)
end

function SkillTreeGui:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function SkillTreeGui:activate_next_tree_panel(play_sound)
	for i, tree_name in ipairs(self._pages_order) do
		if tree_name == self._active_tree then
			if i == #self._pages_order then
				return
			end
			local next_i = i + 1
			self:set_active_page(self._pages_order[next_i], play_sound)
			return true
		end
	end
end

function SkillTreeGui:activate_prev_tree_panel(play_sound)
	for i, tree_name in ipairs(self._pages_order) do
		if tree_name == self._active_tree then
			if i == 1 then
				return
			end
			local prev_i = i - 1
			self:set_active_page(self._pages_order[prev_i], play_sound)
			return true
		end
	end
end

function SkillTreeGui:set_active_page(tree_panel_name, play_sound)
	for tree, page in pairs(self._pages) do
		if tree == tree_panel_name then
			if self._selected_item then
				self._selected_item:deselect()
				self._selected_item = nil
			end
			local item = page:activate()
		else
			page:deactivate()
		end
	end
	self._active_page = self._pages[tree_panel_name]
	self._active_tree = tree_panel_name
	local prev_page_button = self._panel:child("tree_tabs_panel"):child("prev_page")
	local next_page_button = self._panel:child("tree_tabs_panel"):child("next_page")
	if prev_page_button then
		prev_page_button:set_visible(self._active_tree > 1)
	end
	if next_page_button then
		next_page_button:set_visible(self._active_tree < #self._pages)
	end
	local respec_cost_text = self._panel:child("respec_cost_text")
	if alive(respec_cost_text) then
		respec_cost_text:set_text(managers.localization:text("st_menu_respec_cost", {
			cost = managers.experience:cash_string(managers.money:get_skilltree_tree_respec_cost(tree_panel_name))
		}))
		self:make_fine_text(respec_cost_text)
		respec_cost_text:set_bottom(self._panel:child("money_text"):top())
	end
	self:check_respec_button(nil, nil, true)
	if play_sound then
		managers.menu_component:post_event("highlight")
	end
	for _, tab_item in ipairs(self._tab_items) do
		tab_item:set_active(tree_panel_name == tab_item:tree())
	end
end

function SkillTreeGui:set_layer(layer)
	self._panel:set_layer(self._init_layer + layer)
end

function SkillTreeGui:layer()
	return self._panel:layer()
end

function SkillTreeGui:set_selected_item(item, no_sound)
	if self._selected_item ~= item then
		if self._selected_item then
			self._selected_item:deselect()
		end
		if item then
			if item.tree then
				no_sound = no_sound and self._active_tree == item:tree()
			end
			item:select(no_sound)
			self._selected_item = item
		end
	end
	local text = ""
	local prerequisite_text = ""
	local title_text = ""
	self._prerequisites_links = self._prerequisites_links or {}
	for _, data in ipairs(self._prerequisites_links) do
		if data ~= item then
			data:refresh()
		end
	end
	self._prerequisites_links = {}
	local skill_stat_color = tweak_data.screen_colors.resource
	local color_replace_table = {}
	local tier_bonus_text = ""
	if self._selected_item and self._selected_item._skill_panel then
		local skill_id = self._selected_item._skill_id
		local tweak_data_skill = tweak_data.skilltree.skills[skill_id]
		local points = managers.skilltree:points() or 0
		local basic_cost = managers.skilltree:get_skill_points(skill_id, 1) or 0
		local pro_cost = managers.skilltree:get_skill_points(skill_id, 2) or 0
		local talent = tweak_data.skilltree.skills[skill_id]
		local unlocked = managers.skilltree:skill_unlocked(nil, skill_id)
		local step = managers.skilltree:next_skill_step(skill_id)
		local completed = managers.skilltree:skill_completed(skill_id)
		local points = managers.skilltree:points()
		local spending_money = managers.money:total()
		local skill_descs = tweak_data.upgrades.skill_descs[skill_id] or {0, 0}
		local basic_color_index = 1
		local pro_color_index = 2 + (skill_descs[1] or 0)
		if 1 < step then
			basic_cost = utf8.to_upper(managers.localization:text("st_menu_skill_owned"))
			color_replace_table[basic_color_index] = tweak_data.screen_colors.resource
		else
			local money_cost = managers.money:get_skillpoint_cost(self._selected_item._tree, self._selected_item._tier, basic_cost)
			local can_afford = points >= basic_cost and spending_money >= money_cost
			color_replace_table[basic_color_index] = can_afford and tweak_data.screen_colors.resource or tweak_data.screen_colors.important_1
			basic_cost = managers.localization:text(basic_cost == 1 and "st_menu_point" or "st_menu_point_plural", {points = basic_cost}) .. " / " .. managers.experience:cash_string(money_cost)
		end
		if 2 < step then
			pro_cost = utf8.to_upper(managers.localization:text("st_menu_skill_owned"))
			color_replace_table[pro_color_index] = tweak_data.screen_colors.resource
		else
			local money_cost = managers.money:get_skillpoint_cost(self._selected_item._tree, self._selected_item._tier, pro_cost)
			local can_afford = points >= pro_cost and spending_money >= money_cost
			color_replace_table[pro_color_index] = can_afford and tweak_data.screen_colors.resource or tweak_data.screen_colors.important_1
			pro_cost = managers.localization:text(pro_cost == 1 and "st_menu_point" or "st_menu_point_plural", {points = pro_cost}) .. " / " .. managers.experience:cash_string(money_cost)
		end
		local macroes = {basic = basic_cost, pro = pro_cost}
		for i, d in pairs(skill_descs) do
			macroes[i] = d
		end
		title_text = utf8.to_upper(managers.localization:text(tweak_data.skilltree.skills[skill_id].name_id))
		text = managers.localization:text(tweak_data_skill.desc_id, macroes)
		if self._selected_item._tier then
			if not unlocked then
				local point_spent = managers.skilltree:points_spent(self._selected_item._tree) or 0
				local tier_unlocks = managers.skilltree:tier_cost(self._selected_item._tree, self._selected_item._tier) or 0
				prerequisite_text = prerequisite_text .. managers.localization:text("st_menu_points_to_unlock_tier", {
					points = tier_unlocks - point_spent,
					tier = self._selected_item._tier
				}) .. "\n"
			end
			local skilltree = tweak_data.skilltree.trees[self._active_tree] and tweak_data.skilltree.trees[self._active_tree].skill or "NIL"
			local tier_descs = tweak_data.upgrades.skill_descs[tostring(skilltree) .. "_tier" .. tostring(self._selected_item._tier)]
			tier_bonus_text = [[


]] .. utf8.to_upper(managers.localization:text(unlocked and "st_menu_tier_unlocked" or "st_menu_tier_locked")) .. "\n" .. managers.localization:text(tweak_data.skilltree.skills[tweak_data.skilltree.trees[self._selected_item._tree].skill][self._selected_item._tier].desc_id, tier_descs)
		end
		text = text .. tier_bonus_text
		local prerequisites = talent.prerequisites or {}
		local add_prerequisite = true
		for _, prerequisite in ipairs(prerequisites) do
			local unlocked = managers.skilltree:skill_step(prerequisite)
			if unlocked and unlocked == 0 then
				if add_prerequisite then
					prerequisite_text = prerequisite_text .. managers.localization:text("st_menu_prerequisite_following_skill" .. (1 < #prerequisites and "_plural" or ""))
					add_prerequisite = nil
				end
				prerequisite_text = prerequisite_text .. "   " .. managers.localization:text(tweak_data.skilltree.skills[prerequisite].name_id) .. "\n"
				if self._active_page then
					for _, item in ipairs(self._active_page._items) do
						if item._skill_id == prerequisite then
							item._skill_panel:child("state_image"):set_color(tweak_data.screen_colors.important_1)
							table.insert(self._prerequisites_links, item)
						end
					end
				end
			end
		end
	end
	self._skill_title_panel:child("text"):set_text(title_text)
	local desc_pre_text = self._skill_description_panel:child("prerequisites_text")
	if prerequisite_text == "" then
		desc_pre_text:hide()
		desc_pre_text:set_h(0)
	else
		prerequisite_text = utf8.to_upper(prerequisite_text)
		desc_pre_text:show()
		desc_pre_text:set_text(prerequisite_text)
		local x, y, w, h = desc_pre_text:text_rect()
		desc_pre_text:set_h(h)
	end
	local text_dissected = utf8.characters(text)
	local idsp = Idstring("#")
	local start_ci = {}
	local end_ci = {}
	local first_ci = true
	for i, c in ipairs(text_dissected) do
		if Idstring(c) == idsp then
			local next_c = text_dissected[i + 1]
			if next_c and Idstring(next_c) == idsp then
				if first_ci then
					table.insert(start_ci, i)
				else
					table.insert(end_ci, i)
				end
				first_ci = not first_ci
			end
		end
	end
	if #start_ci ~= #end_ci then
	else
		for i = 1, #start_ci do
			start_ci[i] = start_ci[i] - ((i - 1) * 4 + 1)
			end_ci[i] = end_ci[i] - (i * 4 - 1)
		end
	end
	text = string.gsub(text, "##", "")
	local desc_text = self._skill_description_panel:child("text")
	desc_text:set_text(text)
	desc_text:set_y(math.round(desc_pre_text:h() * 1.15))
	desc_text:clear_range_color(1, utf8.len(text))
	if #start_ci ~= #end_ci then
		Application:error("SkillTreeGui: Not even amount of ##'s in skill description string!", #start_ci, #end_ci)
	else
		for i = 1, #start_ci do
			desc_text:set_range_color(start_ci[i], end_ci[i], color_replace_table[i] or skill_stat_color)
		end
	end
end

function SkillTreeGui:check_respec_button(x, y, force_text_update)
	local text_id = "st_menu_respec_tree"
	local prefix = not managers.menu:is_pc_controller() and managers.localization:get_default_macro("BTN_Y") or ""
	local macroes = {}
	if not managers.menu:is_pc_controller() then
		self._panel:child("respec_tree_button"):set_color(tweak_data.screen_colors.text)
	end
	if managers.skilltree:points_spent(self._active_tree) == 0 then
		self._panel:child("respec_tree_button"):set_color(Color.black)
		self._respec_highlight = false
		prefix = ""
	elseif x and y and self._panel:child("respec_tree_button"):inside(x, y) then
		if not self._respec_highlight then
			self._respec_highlight = true
			self._panel:child("respec_tree_button"):set_color(tweak_data.screen_colors.button_stage_2)
			managers.menu_component:post_event("highlight")
		end
	else
		self._respec_highlight = false
		if not managers.menu:is_pc_controller() then
			self._panel:child("respec_tree_button"):set_color(tweak_data.screen_colors.text)
		else
			self._panel:child("respec_tree_button"):set_color(tweak_data.screen_colors.button_stage_3)
		end
	end
	if self._respec_text_id ~= text_id or force_text_update then
		self._respec_text_id = text_id
		self._panel:child("respec_tree_button"):set_text(prefix .. managers.localization:to_upper_text(text_id, macroes))
		self:make_fine_text(self._panel:child("respec_tree_button"))
	end
end

function SkillTreeGui:mouse_moved(o, x, y)
	self:check_respec_button(x, y)
	if self._active_page then
		for _, item in ipairs(self._active_page._items) do
			if item:inside(x, y) then
				self:set_selected_item(item)
				return true
			end
		end
	end
	for _, tab_item in ipairs(self._tab_items) do
		if tab_item:inside(x, y) then
			self:set_selected_item(tab_item, true)
			return true
		end
	end
	if managers.menu:is_pc_controller() then
		if self._panel:child("back_button"):inside(x, y) then
			if not self._back_highlight then
				self._back_highlight = true
				self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end
		else
			self._back_highlight = false
			self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_3)
		end
	end
	if self._panel:inside(x, y) then
		return true
	end
end

function SkillTreeGui:mouse_released(button, x, y)
end

function SkillTreeGui:mouse_pressed(button, x, y)
	if button == Idstring("mouse wheel down") then
		self:activate_next_tree_panel()
		return
	elseif button == Idstring("mouse wheel up") then
		self:activate_prev_tree_panel()
		return
	end
	if button == Idstring("0") then
		if self._panel:child("back_button"):inside(x, y) then
			managers.menu:back()
			return
		end
		if self._panel:child("respec_tree_button"):inside(x, y) then
			self:respec_active_tree()
			return
		end
		if self._active_page then
			for _, item in ipairs(self._active_page._items) do
				if item:inside(x, y) then
					self:place_point(item)
					return true
				end
			end
		end
		for _, tab_item in ipairs(self._tab_items) do
			if tab_item:inside(x, y) then
				if self._active_tree ~= tab_item:tree() then
					self:set_active_page(tab_item:tree(), true)
				end
				return true
			end
		end
	end
end

function SkillTreeGui:move_up()
	if not self._selected_item and self._active_page then
		self:set_selected_item(self._active_page:item())
	elseif self._selected_item and self._selected_item._up_item then
		self:set_selected_item(self._selected_item._up_item)
	end
end

function SkillTreeGui:move_down()
	if not self._selected_item and self._active_page then
		self:set_selected_item(self._active_page:item())
	elseif self._selected_item and self._selected_item._down_item then
		self:set_selected_item(self._selected_item._down_item)
	end
end

function SkillTreeGui:move_left()
	if not self._selected_item and self._active_page then
		self:set_selected_item(self._active_page:item())
	elseif self._selected_item and self._selected_item._left_item then
		self:set_selected_item(self._selected_item._left_item)
	end
end

function SkillTreeGui:move_right()
	if not self._selected_item and self._active_page then
		self:set_selected_item(self._active_page:item())
	elseif self._selected_item and self._selected_item._right_item then
		self:set_selected_item(self._selected_item._right_item)
	end
end

function SkillTreeGui:next_page(play_sound)
	if self:activate_next_tree_panel(play_sound) then
		self:set_selected_item(self._active_page:item(), true)
	end
end

function SkillTreeGui:previous_page(play_sound)
	if self:activate_prev_tree_panel(play_sound) then
		self:set_selected_item(self._active_page:item(), true)
	end
end

function SkillTreeGui:confirm_pressed()
	if self._selected_item and self._selected_item._skill_panel then
		self:place_point(self._selected_item)
		return true
	end
	return false
end

function SkillTreeGui:special_btn_pressed(button)
	if button == Idstring("menu_respec_tree") then
		self:respec_active_tree()
		return true
	end
	return false
end

function SkillTreeGui:flash_item(item)
	item:flash()
end

function SkillTreeGui:place_point(item)
	local tree = item:tree()
	local tier = item:tier()
	local skill_id = item:skill_id()
	if tier and not managers.skilltree:tree_unlocked(tree) then
		self:flash_item(item)
		return
	end
	if managers.skilltree:skill_completed(skill_id) then
		return
	end
	if not tier and managers.skilltree:tree_unlocked(tree) then
		return
	end
	local params = {}
	local to_unlock = managers.skilltree:next_skill_step(skill_id)
	local talent = tweak_data.skilltree.skills[skill_id]
	local skill = talent[to_unlock]
	local points = managers.skilltree:get_skill_points(skill_id, to_unlock) or 0
	local point_cost = managers.money:get_skillpoint_cost(tree, tier, points)
	local prerequisites = talent.prerequisites or {}
	for _, prerequisite in ipairs(prerequisites) do
		local unlocked = managers.skilltree:skill_step(prerequisite)
		if unlocked and unlocked == 0 then
			self:flash_item(item)
			return
		end
	end
	if not managers.money:can_afford_spend_skillpoint(tree, tier, points) then
		self:flash_item(item)
		return
	end
	if tier then
		if points > managers.skilltree:points() then
			self:flash_item(item)
			return
		end
		if managers.skilltree:tier_unlocked(tree, tier) then
			params.skill_name_localized = item._skill_name
			params.points = points
			params.cost = point_cost
			params.remaining_points = managers.skilltree:points()
			params.text_string = "dialog_allocate_skillpoint"
		end
	elseif points <= managers.skilltree:points() then
		params.skill_name_localized = item._skill_name
		params.points = points
		params.cost = point_cost
		params.remaining_points = managers.skilltree:points()
		params.text_string = "dialog_unlock_skilltree"
	end
	if params.text_string then
		params.yes_func = callback(self, self, "_dialog_confirm_yes", item)
		params.no_func = callback(self, self, "_dialog_confirm_no")
		managers.menu:show_confirm_skillpoints(params)
	else
		self:flash_item(item)
	end
end

function SkillTreeGui:_dialog_confirm_yes(item)
	if item then
		local skill_refresh_skills = item:trigger() or {}
		for _, id in ipairs(skill_refresh_skills) do
			for _, item in ipairs(self._active_page._items) do
				if item._skill_id == id then
					item:refresh()
					break
				end
			end
		end
	end
end

function SkillTreeGui:_dialog_confirm_no(item)
end

function SkillTreeGui:on_tier_unlocked(tree, tier)
	self._pages[tree]:unlock_tier(tier)
end

function SkillTreeGui:on_skill_unlocked(tree, skill_id)
end

function SkillTreeGui:on_points_spent()
	local points_text = self._panel:child("points_text")
	points_text:set_text(utf8.to_upper(managers.localization:text("st_menu_available_skill_points", {
		points = managers.skilltree:points()
	})))
	WalletGuiObject.set_object_visible("wallet_skillpoint_icon", managers.skilltree:points() > 0)
	WalletGuiObject.set_object_visible("wallet_skillpoint_text", managers.skilltree:points() > 0)
	local respec_cost_text = self._panel:child("respec_cost_text")
	if alive(respec_cost_text) then
		respec_cost_text:set_text(managers.localization:text("st_menu_respec_cost", {
			cost = managers.experience:cash_string(managers.money:get_skilltree_tree_respec_cost(self._active_tree))
		}))
		self:make_fine_text(respec_cost_text)
		respec_cost_text:set_bottom(self._panel:child("money_text"):top())
	end
	self._active_page:on_points_spent()
	self:check_respec_button(nil, nil, true)
	self:set_selected_item(self._selected_item, true)
	WalletGuiObject.refresh()
end

function SkillTreeGui:respec_active_tree()
	if not managers.money:can_afford_respec_skilltree(self._active_tree) or managers.skilltree:points_spent(self._active_tree) == 0 then
		return
	end
	self:respec_tree(self._active_tree)
end

function SkillTreeGui:respec_tree(tree)
	local params = {}
	params.tree = tree
	params.yes_func = callback(self, self, "_dialog_respec_yes", tree)
	params.no_func = callback(self, self, "_dialog_respec_no")
	managers.menu:show_confirm_respec_skilltree(params)
end

function SkillTreeGui:_dialog_respec_yes(tree)
	SkillTreeGui._respec_tree(self, tree)
end

function SkillTreeGui:_dialog_respec_no()
end

function SkillTreeGui:_respec_tree(tree)
	managers.skilltree:on_respec_tree(tree)
	self:_pre_reload()
	SkillTreeGui.init(self, self._ws, self._fullscreen_ws, self._node)
	self:_post_reload()
	self:set_active_page(tree)
	self:set_selected_item(self._active_page:item(), true)
end

function SkillTreeGui:_pre_reload()
	self._temp_panel = self._panel
	self._temp_fullscreen_panel = self._fullscreen_panel
	self._panel = nil
	self._fullscreen_panel = nil
	self._temp_panel:hide()
	self._temp_fullscreen_panel:hide()
end

function SkillTreeGui:_post_reload()
	self._ws:panel():remove(self._temp_panel)
	self._fullscreen_ws:panel():remove(self._temp_fullscreen_panel)
end

function SkillTreeGui:input_focus()
	return 1
end

function SkillTreeGui:visible()
	return self._visible
end

function SkillTreeGui:close()
	managers.menu:active_menu().renderer.ws:show()
	WalletGuiObject.close_wallet(self._panel)
	self._ws:panel():remove(self._panel)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
end
