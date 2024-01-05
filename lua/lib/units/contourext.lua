ContourExt = ContourExt or class()
local idstr_material = Idstring("material")
local idstr_contour_color = Idstring("contour_color")
local idstr_contour_opacity = Idstring("contour_opacity")
ContourExt._types = {
	teammate = {
		priority = 3,
		player = true,
		color = tweak_data.contour.character.standard_color,
		color_downed = tweak_data.contour.character.downed_color,
		color_dead = tweak_data.contour.character.dead_color,
		opacity = 0,
		fadeout = 6
	},
	friendly = {
		priority = 1,
		character = true,
		color = tweak_data.contour.character.friendly_color
	},
	mark_unit = {
		priority = 2,
		color = tweak_data.contour.character.dangerous_color,
		opacity = 1.5,
		fadeout = 0.3
	},
	mark_enemy = {
		priority = 2,
		character = true,
		color = tweak_data.contour.character.dangerous_color,
		color_strength = tweak_data.contour.character.more_dangerous_color,
		opacity = 1.5,
		opacity_silent = 4.5,
		fadeout = 0.3
	},
	highlight = {
		priority = 3,
		color = tweak_data.contour.interactable.standard_color
	}
}

function ContourExt:init(unit)
	self._unit = unit
	self._materials = nil
	self._contour_list = nil
	self._current = nil
	self._slotmask_world_geometry = managers.slot:get_mask("world_geometry")
end

function ContourExt:add(type, marking_strength, time_multiplier)
	local data = self._types[type]
	local opacity = data.opacity
	if data.opacity_silent and data.character and tweak_data.character[self._unit:base()._tweak_table].silent_priority_shout then
		opacity = data.opacity_silent
	end
	if time_multiplier then
		opacity = opacity * (time_multiplier or 1)
	end
	self._contour_list = self._contour_list or {}
	for _, setup in ipairs(self._contour_list) do
		if setup.type == type then
			setup.marking_strength = marking_strength
			setup.opacity = opacity
			setup.target_opacity = opacity and 0
			return
		end
	end
	table.insert(self._contour_list, {
		type = type,
		marking_strength = marking_strength,
		opacity = opacity,
		target_opacity = opacity and 0
	})
	self:_change()
end

function ContourExt:remove(type)
	for id, setup in ipairs(self._contour_list) do
		if setup.type == type then
			self:_remove(id)
			return
		end
	end
end

function ContourExt:update_materials()
	if self._materials then
		self._materials = self._unit:get_objects_by_type(idstr_material)
		if self._current then
			local setup = self._contour_list[self._current]
			local data = self._types[setup.type]
			local opacity = data.opacity
			if data.opacity_silent and data.character and tweak_data.character[self._unit:base()._tweak_table].silent_priority_shout then
				opacity = data.opacity_silent
			end
			setup.color = nil
			setup.target_color = nil
			setup.opacity = opacity
			setup.target_opacity = opacity and 0
			local color = setup.marking_strength and data.color_strength or data.color
			for _, material in ipairs(self._materials) do
				material:set_variable(idstr_contour_color, color)
				material:set_variable(idstr_contour_opacity, setup.opacity and 0 or 1)
			end
		end
	end
end

function ContourExt:clear()
	self._contour_list = nil
	self._materials = nil
end

function ContourExt:_change()
	if not self._contour_list then
		return
	end
	local id, priority
	for key, data in ipairs(self._contour_list) do
		if not id or priority > self._types[data.type].priority then
			id = key
			priority = self._types[data.type].priority
		end
	end
	if id == self._current then
		return
	end
	local setup = self._contour_list[id]
	local data = self._types[setup.type]
	if data.character then
		if not self._current then
			self._unit:base():swap_material_config()
			managers.occlusion:remove_occlusion(self._unit)
			self._unit:base():set_allow_invisible(false)
		elseif self._unit:base():is_in_original_material() then
			self._unit:base():swap_material_config()
		end
	elseif not self._current then
		managers.occlusion:remove_occlusion(self._unit)
	end
	if setup.marking_strength then
		self._unit:character_damage():on_marked_state(setup.marking_strength)
	end
	local color = setup.marking_strength and data.color_strength or data.color
	self._materials = self._materials or self._unit:get_objects_by_type(idstr_material)
	for _, material in ipairs(self._materials) do
		material:set_variable(idstr_contour_color, color)
		material:set_variable(idstr_contour_opacity, setup.opacity and 0 or 1)
	end
	self._current = id
end

function ContourExt:_remove(id)
	if #self._contour_list == 1 then
		local setup = self._contour_list[id]
		local data = self._types[setup.type]
		managers.occlusion:add_occlusion(self._unit)
		if data.character then
			self._unit:base():swap_material_config()
			self._unit:base():set_allow_invisible(true)
		end
		if setup.marking_strength then
			self._unit:character_damage():on_marked_state(false)
		end
		self._current = nil
	end
	table.remove(self._contour_list, id)
	if #self._contour_list == 0 then
		self:clear()
	end
end

function ContourExt:update(unit, t, dt)
	local id = 1
	while self._contour_list and id <= #self._contour_list do
		local remove
		local setup = self._contour_list[id]
		local data = self._types[setup.type]
		local is_current = self._current == id
		if data.player then
			local cam_pos = managers.viewport:get_current_camera_position()
			if cam_pos then
				local anim_data = unit:anim_data()
				local downed = anim_data.bleedout or anim_data.fatal
				local dead = anim_data.death
				local hands_tied = anim_data.hands_tied
				if downed or dead or hands_tied then
					setup.target_opacity = 1
				else
					setup.target_opacity = 0
					if mvector3.distance_sq(cam_pos, unit:movement():m_com()) > 16000000 then
						setup.target_opacity = 0.65
					else
						setup.target_opacity = unit:raycast("ray", unit:movement():m_com(), cam_pos, "slot_mask", self._slotmask_world_geometry, "report") and 0.65 or 0
					end
				end
				local color_id = managers.criminals:character_color_id_by_unit(unit)
				setup.target_color = dead and data.color_dead or (hands_tied or downed) and data.color_downed or color_id and tweak_data.peer_vector_colors[color_id] or data.color
			end
		end
		if setup.color ~= setup.target_color then
			setup.color = math.step(setup.color or data.color, setup.target_color, data.fadeout * dt)
			if is_current then
				for _, material in ipairs(self._materials) do
					material:set_variable(idstr_contour_color, setup.color)
				end
			end
		end
		if setup.opacity then
			if setup.opacity ~= setup.target_opacity then
				setup.opacity = math.step(setup.opacity, setup.target_opacity, data.fadeout * dt)
				if is_current then
					for _, material in ipairs(self._materials) do
						material:set_variable(idstr_contour_opacity, math.min(1.5, setup.opacity))
					end
				end
			end
			if not data.player and setup.opacity == setup.target_opacity then
				remove = true
				if is_current then
					self:_change()
				end
			end
		end
		if not remove and data.character and unit:character_damage() and unit:character_damage():dead() then
			remove = true
		end
		if remove then
			self:_remove(id)
		else
			id = id + 1
		end
	end
end

function ContourExt:save(data)
	if self._contour_list then
		data.contour_list = deep_clone(self._contour_list)
	end
end

function ContourExt:load(data)
	if data.contour_list then
		self._contour_list = deep_clone(data.contour_list)
		self:_change()
	end
end
