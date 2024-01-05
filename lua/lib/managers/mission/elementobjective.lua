core:import("CoreMissionScriptElement")
ElementObjective = ElementObjective or class(CoreMissionScriptElement.MissionScriptElement)

function ElementObjective:init(...)
	ElementObjective.super.init(self, ...)
end

function ElementObjective:on_script_activated()
	self._mission_script:add_save_state_cb(self._id)
end

function ElementObjective:client_on_executed(...)
	self:on_executed(...)
end

function ElementObjective:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	if self._values.objective ~= "none" then
		if self._values.state == "activate" then
			local amount = self._values.amount and self._values.amount > 0 and self._values.amount or nil
			managers.objectives:activate_objective(self._values.objective, nil, {amount = amount})
		elseif self._values.state == "complete" then
			if self._values.sub_objective and self._values.sub_objective ~= "none" then
				managers.objectives:complete_sub_objective(self._values.objective, self._values.sub_objective)
			else
				managers.objectives:complete_objective(self._values.objective)
			end
		elseif self._values.state == "update" then
			managers.objectives:update_objective(self._values.objective)
		elseif self._values.state == "remove" then
			managers.objectives:remove_objective(self._values.objective)
		end
	elseif Application:editor() then
		managers.editor:output_error("Cant operate on objective " .. self._values.objective .. " in element " .. self._editor_name .. ".")
	end
	ElementObjective.super.on_executed(self, instigator)
end

function ElementObjective:apply_job_value(amount)
	local type = CoreClass.type_name(amount)
	if type ~= "number" then
		Application:error("[ElementObjective:apply_job_value] " .. self._id .. "(" .. self._editor_name .. ") Can't apply job value of type " .. type)
		return
	end
	self._values.amount = amount
end

function ElementObjective:save(data)
	data.enabled = self._values.enabled
end

function ElementObjective:load(data)
	self:set_enabled(data.enabled)
end
