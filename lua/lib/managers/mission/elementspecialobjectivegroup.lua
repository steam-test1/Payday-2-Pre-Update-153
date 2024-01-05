core:import("CoreMissionScriptElement")
ElementSpecialObjectiveGroup = ElementSpecialObjectiveGroup or class(CoreMissionScriptElement.MissionScriptElement)

function ElementSpecialObjectiveGroup:init(...)
	ElementSpecialObjectiveGroup.super.init(self, ...)
	if self._values.SO_access then
		local access_filter_version = self._values.access_flag_version or 1
		if access_filter_version ~= managers.navigation.ACCESS_FLAGS_VERSION then
			print("[ElementSpecialObjectiveGroup:init] converting access flag", access_filter_version, self._values.SO_access)
			self._values.SO_access = managers.navigation:upgrade_access_filter(tonumber(self._values.SO_access), access_filter_version)
			print("[ElementSpecialObjectiveGroup:init] converted to", self._values.SO_access)
		else
			self._values.SO_access = tonumber(self._values.SO_access)
		end
	end
end

function ElementSpecialObjectiveGroup:clbk_verify_administration(unit)
	return ElementSpecialObjective.clbk_verify_administration(self, unit)
end

function ElementSpecialObjectiveGroup:on_executed(instigator)
	if not self._values.enabled or Network:is_client() then
		return
	end
	if not managers.groupai:state():is_AI_enabled() and not Application:editor() then
	elseif self._values.spawn_instigator_ids and next(self._values.spawn_instigator_ids) then
		local chosen_units = self:_select_units_from_spawners()
		if chosen_units then
			for _, chosen_unit in ipairs(chosen_units) do
				self:_execute_random_SO(chosen_unit)
			end
		end
	elseif self._values.use_instigator then
		if alive(instigator) then
			if instigator:brain() then
				if not instigator:character_damage() or not instigator:character_damage():dead() then
					self:_execute_random_SO(instigator)
				end
			else
				Application:error("[ElementSpecialObjectiveGroup:on_executed] Special Objective instigator is not an AI unit. Possibly improper \"use instigator\" flag use. Element id:", self._id)
			end
		elseif not instigator then
			Application:error("[ElementSpecialObjectiveGroup:on_executed] Special Objective missing instigator. Possibly improper \"use instigator\" flag use. Element id:", self._id)
		end
	else
		self:_execute_random_SO(nil)
	end
	ElementSpecialObjectiveGroup.super.on_executed(self, instigator)
end

function ElementSpecialObjectiveGroup:operation_remove()
	for _, followup_element_id in ipairs(self._values.followup_elements) do
		managers.groupai:state():remove_special_objective(followup_element_id)
	end
end

function ElementSpecialObjectiveGroup:_select_units_from_spawners()
	return ElementSpecialObjective._select_units_from_spawners(self)
end

function ElementSpecialObjectiveGroup:choose_followup_SO(unit, skip_element_ids)
	if skip_element_ids and skip_element_ids[self._id] then
		return
	end
	skip_element_ids[self._id] = true
	return ElementSpecialObjective.choose_followup_SO(self, unit, skip_element_ids)
end

function ElementSpecialObjectiveGroup:get_as_followup(unit, skip_element_ids)
	if skip_element_ids[self._id] then
		return
	end
	skip_element_ids[self._id] = true
	return ElementSpecialObjective.choose_followup_SO(self, unit, skip_element_ids), self._values.base_chance
end

function ElementSpecialObjectiveGroup:_execute_random_SO(instigator)
	local random_SO = ElementSpecialObjective.choose_followup_SO(self, instigator, {
		[self._id] = true
	})
	if random_SO then
		random_SO:on_executed(instigator)
	end
end
