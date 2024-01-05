core:import("CoreMissionScriptElement")
ElementAwardAchievment = ElementAwardAchievment or class(CoreMissionScriptElement.MissionScriptElement)

function ElementAwardAchievment:init(...)
	ElementAwardAchievment.super.init(self, ...)
end

function ElementAwardAchievment:client_on_executed_end_screen(...)
	self:on_executed(...)
end

function ElementAwardAchievment:client_on_executed(...)
	self:on_executed(...)
end

function ElementAwardAchievment:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	managers.achievment:award(self._values.achievment)
	ElementAwardAchievment.super.on_executed(self, instigator)
end
