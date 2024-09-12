core:module("CoreEditorCommand")
EditorCommand = EditorCommand or class()
EditorCommand.UnitValues = {}

function EditorCommand:init(layer)
	self._layer = layer
	self._values = {}
end

function EditorCommand:__tostring()
	return "[Command base]"
end

function EditorCommand:execute()
	print("Execute not implemented for EditorCommand")
end

function EditorCommand:undo()
	print("Undo not implemented for EditorCommand")
end

function EditorCommand:layer()
	return self._layer
end

function EditorCommand:value(val, default)
	self._values = self._values or {}
	local v = self._values[val]
	if v ~= nil then
		return v
	else
		return default
	end
end

function EditorCommand:delete_unit(deleted_unit_id)
	for i, key in ipairs(self.UnitValues) do
		if self._values[key] then
			local key_type = type(self._values[key])
			if key_type == "table" then
				for i, unit in pairs(self._values[key]) do
					if type(unit) ~= "number" and unit:unit_data().unit_id == deleted_unit_id then
						self._values[key][i] = deleted_unit_id
					end
				end
			elseif key_type ~= "number" and alive(self._values[key]) and self._values[key]:unit_data().unit_id == deleted_unit_id then
				self._values[key] = deleted_unit_id
			end
		end
	end
end

function EditorCommand:restore_unit(previous_id, restored_unit)
	for i, key in ipairs(self.UnitValues) do
		if self._values[key] then
			if type(self._values[key]) == "table" then
				for i, unit_or_id in pairs(self._values[key]) do
					if type(unit_or_id) == "number" and unit_or_id == previous_id then
						self._values[key][i] = restored_unit
					end
				end
			elseif type(self._values[key]) == "number" and self._values[key] == previous_id then
				self._values[key] = restored_unit
			end
		end
	end
end

function EditorCommand:do_unit_restore(old_id, new_unit)
	self:layer():on_unit_restored(old_id, new_unit)
	managers.editor:send_message_now(_G.EditorMessage.OnUnitRestored, nil, old_id, new_unit)
end

ReferenceUnitCommand = ReferenceUnitCommand or class(EditorCommand)
ReferenceUnitCommand.UnitValues = {
	"reference_unit",
	"selected_units"
}

function ReferenceUnitCommand:execute()
	if not self:are_unit_values_set() then
		self:save_unit_values()
	end
end

function ReferenceUnitCommand:are_unit_values_set()
	return self._values.__set
end

function ReferenceUnitCommand:save_unit_values()
	self._values.reference_unit = self._layer._selected_unit
	self._values.selected_units = {}
	for _, unit in ipairs(self._layer._selected_units) do
		table.insert(self._values.selected_units, unit)
	end
	self._values.__set = true
end

MoveUnitCommand = MoveUnitCommand or class(ReferenceUnitCommand)
MoveUnitCommand.UnitValues = {
	"reference_unit",
	"selected_units"
}

function MoveUnitCommand:init(layer, command)
	MoveUnitCommand.super.init(self, layer)
	if command and command:are_unit_values_set() then
		self._values = command._values
	end
end

function MoveUnitCommand:save_unit_values()
	MoveUnitCommand.super.save_unit_values(self)
	self._values.original_pos = self._values.reference_unit:unit_data().world_pos
end

function MoveUnitCommand:execute(pos)
	MoveUnitCommand.super.execute(self)
	self._values.target_pos = pos or self._values.target_pos
	self:perform_move(self:value("target_pos"), self:value("reference_unit"), self:value("selected_units"))
end

function MoveUnitCommand:undo()
	self:perform_move(self:value("original_pos"), self:value("reference_unit"), self:value("selected_units"))
end

function MoveUnitCommand:perform_move(pos, reference, units)
	for _, unit in ipairs(units) do
		if unit ~= reference then
			self:layer():set_unit_position(unit, pos, reference:rotation())
		end
	end
	reference:set_position(pos)
	reference:unit_data().world_pos = pos
	self:layer():_on_unit_moved(reference, pos)
end

function MoveUnitCommand:__tostring()
	return string.format("[Command MoveUnit target: %s]", tostring(self:value("target_pos")))
end

RotateUnitCommand = RotateUnitCommand or class(ReferenceUnitCommand)
RotateUnitCommand.UnitValues = {
	"reference_unit",
	"selected_units"
}

function RotateUnitCommand:init(layer, command)
	RotateUnitCommand.super.init(self, layer)
	if command and command:are_unit_values_set() then
		self._values = _G.clone(command._values)
	end
end

function RotateUnitCommand:save_unit_values()
	MoveUnitCommand.super.save_unit_values(self)
	self._values.rot_add = Rotation()
end

function RotateUnitCommand:execute(rot)
	RotateUnitCommand.super.execute(self)
	self._values.rot_add = rot and self._values.rot_add * rot or self._values.rot_add
	rot = rot or self._values.rot_add
	self:perform_rotation(rot or self._values.rot_add, self:value("reference_unit"), self:value("selected_units"))
end

function RotateUnitCommand:undo()
	self:perform_rotation(self:value("rot_add"):inverse(), self:value("reference_unit"), self:value("selected_units"))
end

function RotateUnitCommand:perform_rotation(rot, reference, units)
	local rot = rot * reference:rotation()
	reference:set_rotation(rot)
	self:layer():_on_unit_rotated(reference, rot)
	for _, unit in ipairs(units) do
		if unit ~= reference then
			self:layer():set_unit_position(unit, reference:position(), rot)
			self:layer():set_unit_rotation(unit, rot)
		end
	end
end

function RotateUnitCommand:__tostring()
	return string.format("[Command RotateUnit target: %s]", tostring(self:value("rot_add")))
end

HideUnitsCommand = HideUnitsCommand or class(EditorCommand)
HideUnitsCommand.UnitValues = {"units"}

function HideUnitsCommand:execute(units, hidden)
	if not self._values.units then
		self._values.units = {}
		for _, unit in pairs(units) do
			table.insert(self._values.units, unit)
		end
		self._values.hide = hidden
	end
	if hidden == nil then
		hidden = self:value("hide")
	end
	self:hide_units(units or self:value("units"), hidden)
end

function HideUnitsCommand:undo()
	self:hide_units(self:value("units"), not self:value("hide"))
end

function HideUnitsCommand:hide_units(units, hidden)
	for _, unit in pairs(units) do
		if unit:enabled() then
			managers.editor:set_unit_visible(unit, not hidden)
		end
	end
end

function RotateUnitCommand:__tostring()
	return string.format("[Command HideUnits hidden: %s]", tostring(self:value("hide")))
end

SpawnUnitCommand = SpawnUnitCommand or class(EditorCommand)
SpawnUnitCommand.UnitValues = {
	"spawned_unit"
}

function SpawnUnitCommand:execute(name, pos, rot, to_continent_name)
	if name and pos and rot then
		self._values.args = {
			name,
			pos,
			rot,
			to_continent_name
		}
	end
	local unit = self:layer():create_unit(unpack(self._values.args))
	table.insert(self:layer()._created_units, unit)
	self:layer()._created_units_pairs[unit:unit_data().unit_id] = unit
	self:layer():set_select_unit(unit)
	self._values.spawned_unit = unit
	if self._values.spawned_unit_id then
		self:do_unit_restore(self:value("spawned_unit_id"), unit)
	end
	return unit
end

function SpawnUnitCommand:undo()
	local unit = self:value("spawned_unit")
	if alive(unit) then
		self._values.spawned_unit_id = unit:unit_data().unit_id
		self:layer():delete_unit(unit, true)
	end
end

function SpawnUnitCommand:__tostring()
	return string.format("[Command SpawnUnit %s]", tostring(self._values.args[1]))
end

DeleteStaticUnitCommand = DeleteStaticUnitCommand or class(EditorCommand)
DeleteStaticUnitCommand.UnitValues = {"unit"}
DeleteStaticUnitCommand.IgnoredRestoreKeys = {"id", "name_id"}

function DeleteStaticUnitCommand:execute(unit)
	unit = unit or self._values.unit
	self._values.unit = unit
	self._values.id = unit:unit_data().unit_id
	self._values.name = unit:name()
	self._values.pos = unit:position()
	self._values.rot = unit:rotation()
	self._values.continent = unit:unit_data().continent
	self._values.unit_data = unit:unit_data()
	managers.editor:send_message_now(_G.EditorMessage.OnUnitRemoved, nil, unit)
	if self:layer():selected_unit() == unit then
		self:layer():set_reference_unit(nil)
		self:layer():update_unit_settings()
	end
	table.delete(self:layer()._created_units, unit)
	self:layer()._created_units_pairs[unit:unit_data().unit_id] = nil
	self:layer():remove_unit(unit)
end

function DeleteStaticUnitCommand:undo()
	local unit = self:layer():do_spawn_unit(self:value("name"), self:value("pos"), self:value("rot"), self:value("continent"), true)
	for key, value in pairs(self._values.unit_data) do
		if not table.contains(self.IgnoredRestoreKeys, key) then
			unit:unit_data()[key] = value
		end
	end
	self:layer():set_name_id(unit, self._values.unit_data.name_id)
	self:do_unit_restore(self:value("id"), unit)
	self:layer():clone_edited_values(unit, unit)
	self._values.unit = unit
end

function DeleteStaticUnitCommand:__tostring()
	return string.format("[Command DeleteUnit %s(%s)]", tostring(self._values.name), tostring(self._values.id))
end
