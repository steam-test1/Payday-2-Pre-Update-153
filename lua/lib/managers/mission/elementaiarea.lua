core:import("CoreMissionScriptElement")
ElementAIArea = ElementAIArea or class(CoreMissionScriptElement.MissionScriptElement)

function ElementAIArea:on_executed(instigator)
	if not (self._values.enabled and not Network:is_client() and managers.groupai:state():is_AI_enabled() and self._values.nav_segs) or #self._values.nav_segs == 0 then
		return
	end
	managers.groupai:state():add_area(self._id, self._values.nav_segs, self._values.position)
	ElementAIArea.super.on_executed(self, instigator)
end
