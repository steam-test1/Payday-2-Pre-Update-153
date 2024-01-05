core:import("CoreMissionScriptElement")
ElementSpotter = ElementSpotter or class(CoreMissionScriptElement.MissionScriptElement)

function ElementSpotter:init(...)
	ElementSpotter.super.init(self, ...)
	self._forward = self._values.rotation:y()
	self._enemy_contours = {}
end

function ElementSpotter:on_script_activated()
	if self._values.enabled then
		self:add_callback()
	end
end

function ElementSpotter:set_enabled(enabled)
	ElementSpotter.super.set_enabled(self, enabled)
	if enabled then
		self:add_callback()
	else
		self:remove_callback()
	end
end

function ElementSpotter:add_callback()
	if not Network:is_server() then
		return
	end
	if not self._callback then
		self._callback = self._mission_script:add(callback(self, self, "update_spotter"), 0.1)
	end
end

function ElementSpotter:remove_callback()
	if self._callback then
		self._mission_script:remove(self._callback)
		self._callback = nil
	end
end

function ElementSpotter:on_executed(instigator, ...)
	if not self._values.enabled then
		return
	end
	ElementSpotter.super.on_executed(self, instigator, ...)
end

local mvec1 = Vector3()

function ElementSpotter:update_spotter()
	if not self._values.enabled then
		return
	end
	if not managers.groupai:state():whisper_mode() then
		self:remove_callback()
		return
	end
	if self._found_units then
		local unit = table.remove(self._found_units, 1)
		if alive(unit) and not unit:character_damage():dead() then
			mvector3.set(mvec1, unit:movement():m_head_pos())
			mvector3.subtract(mvec1, self._values.position)
			mvector3.normalize(mvec1)
			local angle = mvector3.angle(self._forward, mvec1)
			if angle < 45 then
				local ray = World:raycast("ray", unit:movement():m_head_pos(), self._values.position, "ray_type", "ai_vision", "slot_mask", managers.slot:get_mask("world_geometry"), "report")
				if not ray and unit:base()._tweak_table and (tweak_data.character[unit:base()._tweak_table].silent_priority_shout or tweak_data.character[unit:base()._tweak_table].priority_shout) then
					self:add_enemy_contour(unit)
					self:on_executed(unit, "on_spotted")
				end
			end
		end
		self._found_units = #self._found_units > 0 and self._found_units or nil
	else
		self._found_units = World:find_units_quick("all", managers.slot:get_mask("enemies"))
		self._found_units = #self._found_units > 0 and self._found_units or nil
	end
end

function ElementSpotter:add_enemy_contour(unit)
	if self._enemy_contours[unit:key()] and self._enemy_contours[unit:key()] > Application:time() then
		return
	end
	self:on_executed(unit, "on_outlined")
	self._enemy_contours[unit:key()] = Application:time() + 9
	if not unit:contour() then
		debug_pause_unit(unit, "[IngameAccessCamera:add_enemy_contour]: Unit doesn't have Contour Extension")
	end
	unit:contour():add("mark_enemy", true, 1)
end
