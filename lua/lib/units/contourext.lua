ContourExt = ContourExt or class()
local idstr_contour = Idstring("contour")
local idstr_material = Idstring("material")
local idstr_contour_color = Idstring("contour_color")
local idstr_contour_opacity = Idstring("contour_opacity")
ContourExt._types = {
	teammate = {
		priority = 5,
		ray_check = true,
		persistence = 0.3
	},
	teammate_downed = {
		priority = 4,
		color = tweak_data.contour.character.downed_color
	},
	teammate_downed_selected = {
		priority = 3,
		color = tweak_data.contour.character_interactable.selected_color
	},
	teammate_dead = {
		priority = 4,
		color = tweak_data.contour.character.dead_color
	},
	teammate_cuffed = {
		priority = 4,
		color = tweak_data.contour.character.downed_color
	},
	friendly = {
		priority = 3,
		material_swap_required = true,
		color = tweak_data.contour.character.friendly_color
	},
	mark_unit = {
		priority = 4,
		color = tweak_data.contour.character.dangerous_color,
		fadeout = 4.5
	},
	mark_unit_friendly = {
		priority = 3,
		color = tweak_data.contour.character.friendly_color
	},
	mark_enemy = {
		priority = 5,
		material_swap_required = true,
		color = tweak_data.contour.character.dangerous_color,
		fadeout_silent = 13.5,
		fadeout = 4.5
	},
	mark_enemy_damage_bonus = {
		priority = 4,
		material_swap_required = true,
		color = tweak_data.contour.character.more_dangerous_color,
		fadeout_silent = 13.5,
		fadeout = 4.5,
		damage_bonus = true
	},
	highlight = {
		priority = 4,
		color = tweak_data.contour.interactable.standard_color
	},
	generic_interactable = {
		priority = 2,
		material_swap_required = true,
		color = tweak_data.contour.character_interactable.standard_color
	},
	generic_interactable_selected = {
		priority = 1,
		material_swap_required = true,
		color = tweak_data.contour.character_interactable.selected_color
	},
	hostage_trade = {
		priority = 1,
		material_swap_required = true,
		color = tweak_data.contour.character_interactable.standard_color
	}
}
ContourExt.indexed_types = {}
for name, preset in pairs(ContourExt._types) do
	table.insert(ContourExt.indexed_types, name)
end
if #ContourExt.indexed_types > 32 then
	Application:error("[ContourExt] max # contour presets exceeded!")
end
ContourExt._MAX_ID = 100000
ContourExt._next_id = 1

function ContourExt:init(unit)
	self._unit = unit
	self._unit:set_extension_update_enabled(idstr_contour, false)
	ContourExt._slotmask_world_geometry = ContourExt._slotmask_world_geometry or managers.slot:get_mask("world_geometry")
end

function ContourExt:add(type, sync, multiplier)
	local data = self._types[type]
	local fadeout = data.fadeout
	if data.fadeout_silent and self._unit:base():char_tweak().silent_priority_shout then
		fadeout = data.fadeout_silent
	end
	if multiplier and 1 < multiplier then
		fadeout = fadeout * multiplier
	end
	self._contour_list = self._contour_list or {}
	if sync then
		local u_id = self._unit:id()
		if u_id == -1 then
			u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
		end
		managers.network:session():send_to_peers_synched("sync_contour_state", self._unit, u_id, table.index_of(ContourExt.indexed_types, type), true, multiplier or 1)
	end
	for _, setup in ipairs(self._contour_list) do
		if setup.type == type then
			if fadeout then
				setup.fadeout_t = TimerManager:game():time() + fadeout
			else
				setup.ref_c = (setup.ref_c or 0) + 1
			end
			return setup
		end
	end
	local setup = {
		type = type,
		fadeout_t = fadeout and TimerManager:game():time() + fadeout or nil,
		ref_c = 1
	}
	local old_preset_type = self._contour_list[1] and self._contour_list[1].type
	local i = 1
	while self._contour_list[i] and self._types[self._contour_list[i].type].priority <= data.priority do
		i = i + 1
	end
	table.insert(self._contour_list, i, setup)
	if old_preset_type ~= setup.type then
		self:_apply_top_preset()
	end
	if not self._update_enabled then
		self:_chk_update_state()
	end
	return setup
end

function ContourExt:change_color(type, color)
	for i, setup in ipairs(self._contour_list) do
		if setup.type == type then
			setup.color = color
			self:_upd_color()
			break
		end
	end
end

function ContourExt:flash(type_or_id, frequency)
	if not self._contour_list then
		return
	end
	for i, setup in ipairs(self._contour_list) do
		if setup.type == type_or_id or setup == type_or_id then
			setup.flash_frequency = frequency and 0 < frequency and frequency or nil
			setup.flash_t = setup.flash_frequency and TimerManager:game():time() + setup.flash_frequency or nil
			setup.flash_on = nil
			self:_chk_update_state()
			break
		end
	end
end

function ContourExt:is_flashing()
	if not self._contour_list then
		return
	end
	for i, setup in ipairs(self._contour_list) do
		if setup.flash_frequency then
			return true
		end
	end
end

function ContourExt:remove(type, sync)
	if not self._contour_list then
		return
	end
	for i, setup in ipairs(self._contour_list) do
		if setup.type == type then
			self:_remove(i, sync)
			if self._update_enabled then
				self:_chk_update_state()
			end
			return
		end
	end
end

function ContourExt:remove_by_id(id, sync)
	if not self._contour_list then
		return
	end
	for i, setup in ipairs(self._contour_list) do
		if setup == id then
			self:_remove(i, sync)
			if self._update_enabled then
				self:_chk_update_state()
			end
			return
		end
	end
end

function ContourExt:_clear()
	self._contour_list = nil
	self._materials = nil
end

function ContourExt:_remove(index, sync)
	local setup = self._contour_list[index]
	local contour_type = setup.type
	local data = self._types[setup.type]
	if setup.ref_c and setup.ref_c > 1 then
		setup.ref_c = setup.ref_c - 1
		return
	end
	if #self._contour_list == 1 then
		managers.occlusion:add_occlusion(self._unit)
		if data.material_swap_required then
			self._unit:base():set_material_state(true)
			self._unit:base():set_allow_invisible(true)
		else
			for _, material in ipairs(self._materials) do
				material:set_variable(idstr_contour_opacity, 0)
			end
		end
		if data.damage_bonus then
			self._unit:character_damage():on_marked_state(false)
		end
	end
	self._last_opacity = nil
	table.remove(self._contour_list, index)
	if #self._contour_list == 0 then
		self:_clear()
	elseif index == 1 then
		self:_apply_top_preset()
	end
	if sync then
		local u_id = self._unit:id()
		if u_id == -1 then
			u_id = managers.enemy:get_corpse_unit_data_from_key(self._unit:key()).u_id
		end
		managers.network:session():send_to_peers_synched("sync_contour_state", self._unit, u_id, table.index_of(ContourExt.indexed_types, contour_type), false, 1)
	end
end

function ContourExt:update(unit, t, dt)
	local index = 1
	while self._contour_list and index <= #self._contour_list do
		local setup = self._contour_list[index]
		local data = self._types[setup.type]
		local is_current = index == 1
		if data.ray_check then
			local turn_on
			if is_current then
				local cam_pos = managers.viewport:get_current_camera_position()
				if cam_pos then
					turn_on = mvector3.distance_sq(cam_pos, unit:movement():m_com()) > 16000000
					turn_on = turn_on or unit:raycast("ray", unit:movement():m_com(), cam_pos, "slot_mask", self._slotmask_world_geometry, "report")
				end
			end
			if turn_on then
				self:_upd_opacity(1)
				setup.last_turned_on_t = t
			elseif not setup.last_turned_on_t or t - setup.last_turned_on_t > data.persistence then
				if is_current then
					self:_upd_opacity(0)
				end
				setup.last_turned_on_t = nil
			end
		end
		if setup.flash_t and t > setup.flash_t then
			setup.flash_t = t + setup.flash_frequency
			setup.flash_on = not setup.flash_on
			self:_upd_opacity(setup.flash_on and 1 or 0)
		end
		if setup.fadeout_t and t > setup.fadeout_t then
			self:_remove(index)
			self:_chk_update_state()
		else
			index = index + 1
		end
	end
end

function ContourExt:_upd_opacity(opacity)
	if opacity == self._last_opacity then
		return
	end
	self._last_opacity = opacity
	self._materials = self._materials or self._unit:get_objects_by_type(idstr_material)
	for _, material in ipairs(self._materials) do
		material:set_variable(idstr_contour_opacity, opacity)
	end
end

function ContourExt:_upd_color()
	local color = self._types[self._contour_list[1].type].color or self._contour_list[1].color
	if not color then
		return
	end
	self._materials = self._materials or self._unit:get_objects_by_type(idstr_material)
	for _, material in ipairs(self._materials) do
		material:set_variable(idstr_contour_color, color)
	end
end

function ContourExt:_apply_top_preset()
	local setup = self._contour_list[1]
	local data = self._types[setup.type]
	self._last_opacity = nil
	if data.material_swap_required then
		self._materials = nil
		self._last_opacity = nil
		if self._unit:base():is_in_original_material() then
			self._unit:base():swap_material_config(callback(self, ContourExt, "material_applied", true))
		else
			self:material_applied()
		end
	else
		managers.occlusion:remove_occlusion(self._unit)
		self:material_applied()
	end
end

function ContourExt:material_applied(material_was_swapped)
	if material_was_swapped then
		managers.occlusion:remove_occlusion(self._unit)
		self._unit:base():set_allow_invisible(false)
	end
	local setup = self._contour_list[1]
	local data = self._types[setup.type]
	if data.damage_bonus then
		self._unit:character_damage():on_marked_state(true)
	end
	self:_upd_color()
	if not data.ray_check then
		self:_upd_opacity(1)
	end
end

function ContourExt:_chk_update_state()
	local needs_update
	if self._contour_list and next(self._contour_list) then
		for i, setup in ipairs(self._contour_list) do
			if setup.fadeout_t or self._types[setup.type].ray_check or setup.flash_t then
				needs_update = true
				break
			end
		end
	end
	if self._update_enabled ~= needs_update then
		self._update_enabled = needs_update
		self._unit:set_extension_update_enabled(idstr_contour, needs_update and true or false)
	end
end

function ContourExt:update_materials()
	if self._contour_list and next(self._contour_list) then
		self._materials = nil
		self:_upd_color()
		self._last_opacity = nil
		self:_upd_opacity(1)
	end
end
