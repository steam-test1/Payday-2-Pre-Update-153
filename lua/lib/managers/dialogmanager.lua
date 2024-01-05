DialogManager = DialogManager or class()

function DialogManager:init()
	self._current_dialog = nil
	self._next_dialog = nil
	self._bain_unit = World:spawn_unit(Idstring("units/payday2/characters/fps_mover/bain"), Vector3(), Rotation())
end

function DialogManager:init_finalize()
	self._dialog_list = {}
	self:_load_dialogs()
end

function DialogManager:queue_dialog(id, params)
	if not self._dialog_list[id] then
		debug_pause("The dialog script tries to queue a dialog with id '" .. tostring(id) .. "' which doesn't seem to exist!")
		return false
	end
	if not self._current_dialog then
		self._current_dialog = {id = id, params = params}
		self:_play_dialog(self._dialog_list[id], params)
	else
		local dialog = self._dialog_list[id]
		if self._next_dialog and dialog.priority > self._dialog_list[self._next_dialog.id].priority then
			self:_call_done_callback(params and params.done_cbk, "skipped")
			return false
		end
		if dialog.priority < self._dialog_list[self._current_dialog.id].priority then
			if self._next_dialog then
				self:_call_done_callback(self._dialog_list[self._next_dialog.id].params and self._dialog_list[self._next_dialog.id].params.done_cbk, "skipped")
			end
			self._next_dialog = {id = id, params = params}
		else
			self:_call_done_callback(params and params.done_cbk, "skipped")
		end
	end
	return true
end

function DialogManager:finished()
	self:_stop_dialog()
	if self._current_dialog.params and self._current_dialog.params.done_cbk then
		self:_call_done_callback(self._current_dialog.params.done_cbk, "done")
	end
	if self._next_dialog then
		self._current_dialog = self._next_dialog
		self._next_dialog = nil
		self:_play_dialog(self._dialog_list[self._current_dialog.id], self._current_dialog.params)
	else
		self._current_dialog = nil
	end
end

function DialogManager:quit_dialog(no_done_cbk)
	managers.subtitle:set_visible(false)
	managers.subtitle:set_enabled(false)
	self:_stop_dialog()
	if not no_done_cbk and self._current_dialog and self._current_dialog.params then
		self:_call_done_callback(self._current_dialog.params.done_cbk, "done")
	end
	self._current_dialog = nil
	self._next_dialog = nil
end

function DialogManager:conversation_names()
	local t = {}
	for name, _ in pairs(self._dialog_list) do
		table.insert(t, name)
	end
	table.sort(t)
	return t
end

function DialogManager:on_simulation_ended()
	self:quit_dialog(true)
end

function DialogManager:_play_dialog(dialog, params)
	local unit = not params.on_unit and params.override_characters and managers.player:player_unit()
	if not alive(unit) then
		if dialog.character then
			unit = managers.criminals:character_unit_by_name(dialog.character)
		else
			unit = managers.dialog._bain_unit
		end
	end
	self._current_dialog.unit = unit
	if not alive(unit) then
		Application:error("The dialog script tries to access a unit named '" .. tostring(dialog.character) .. "', which doesn't seem to exist. Line will be skipped.")
	end
	if alive(unit) then
		if dialog.string_id then
			unit:drama():play_subtitle(dialog.string_id)
		end
		if dialog.sound then
			unit:drama():play_sound(dialog.sound, dialog.sound_source)
		end
	end
end

function DialogManager:_stop_dialog()
	if self._current_dialog and self._current_dialog.unit then
		self._current_dialog.unit:drama():stop_cue()
	end
end

function DialogManager:_call_done_callback(done_cbk, reason)
	if done_cbk then
		done_cbk(reason)
	end
end

function DialogManager:_load_dialogs()
	local file_name = "gamedata/dialogs/index"
	local data = PackageManager:script_data(Idstring("dialog_index"), file_name:id())
	for _, c in ipairs(data) do
		if c.name then
			self:_load_dialog_data(c.name)
		end
	end
end

function DialogManager:_load_dialog_data(name)
	local file_name = "gamedata/dialogs/" .. name
	local data = PackageManager:script_data(Idstring("dialog"), file_name:id())
	for _, node in ipairs(data) do
		if node._meta == "dialog" then
			if node.id then
				self._dialog_list[node.id] = {
					id = node.id,
					character = node.character,
					sound = node.sound,
					string_id = node.string_id,
					priority = node.priority and tonumber(node.priority) or tweak_data.dialog.DEFAULT_PRIORITY
				}
			else
				Application:throw_exception("Error in '" .. file_name .. "'! A node definition must have an id parameter!")
			end
		end
	end
end
