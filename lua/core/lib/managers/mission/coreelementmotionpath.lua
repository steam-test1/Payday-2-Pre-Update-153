core:module("CoreElementMotionPath")
core:import("CoreMissionScriptElement")
ElementMotionPathOperator = ElementMotionPathOperator or class(CoreMissionScriptElement.MissionScriptElement)

function ElementMotionPathOperator:init(...)
	ElementMotionPathOperator.super.init(self, ...)
end

function ElementMotionPathOperator:client_on_executed(...)
end

function ElementMotionPathOperator:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	for _, id in ipairs(self._values.elements) do
		local element = self:get_mission_element(id)
		if element and self._values.operation == "goto_marker" then
			element:motion_operation_goto_marker(element:id(), self._values.marker_ids[self._values.marker])
		end
	end
	ElementMotionPathOperator.super.on_executed(self, instigator)
end

ElementMotionPathTrigger = ElementMotionPathTrigger or class(CoreMissionScriptElement.MissionScriptElement)

function ElementMotionPathTrigger:init(...)
	ElementMotionPathTrigger.super.init(self, ...)
end

function ElementMotionPathTrigger:on_script_activated()
	for _, id in ipairs(self._values.elements) do
		local element = self:get_mission_element(id)
		element:add_trigger(self._id, self._values.outcome, callback(self, self, "on_executed"))
	end
end

function ElementMotionPathTrigger:client_on_executed(...)
end

function ElementMotionPathTrigger:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	ElementMotionPathTrigger.super.on_executed(self, instigator)
end
