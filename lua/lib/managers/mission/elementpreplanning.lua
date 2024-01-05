core:import("CoreMissionScriptElement")
ElementPrePlanning = ElementPrePlanning or class(CoreMissionScriptElement.MissionScriptElement)

function ElementPrePlanning:init(...)
	ElementPrePlanning.super.init(self, ...)
end

function ElementPrePlanning:on_script_activated()
	if self._values.enabled then
		managers.preplanning:register_element(self)
	end
end

function ElementPrePlanning:on_executed(instigator, ...)
	if not self._values.enabled then
		return
	end
	ElementPrePlanning.super.on_executed(self, instigator, ...)
end
