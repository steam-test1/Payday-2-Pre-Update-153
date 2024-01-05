core:import("CoreMissionScriptElement")
ElementAiGlobalEvent = ElementAiGlobalEvent or class(CoreMissionScriptElement.MissionScriptElement)

function ElementAiGlobalEvent:init(...)
	ElementAiGlobalEvent.super.init(self, ...)
	if self._values.event then
		self._values.wave_mode = self._values.event
		self._values.event = nil
	end
end

function ElementAiGlobalEvent:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	if self._values.wave_mode and self._values.wave_mode ~= "none" then
		managers.groupai:state():set_wave_mode(self._values.wave_mode)
	end
	if not self._values.blame or self._values.blame == "none" then
		Application:error("ElementAiGlobalEvent needs to be updated with blame parameter, and not none", inspect(self._values))
	end
	if self._values.AI_event and self._values.AI_event ~= "none" then
		if self._values.AI_event == "police_called" then
			managers.groupai:state():on_police_called(managers.groupai:state().analyse_giveaway(self._values.blame, instigator, {"vo_cbt"}))
		elseif self._values.AI_event == "police_weapons_hot" then
			managers.groupai:state():on_police_weapons_hot(managers.groupai:state().analyse_giveaway(self._values.blame, instigator, {"vo_cbt"}))
		elseif self._values.AI_event == "gangsters_called" then
			managers.groupai:state():on_gangsters_called(managers.groupai:state().analyse_giveaway(self._values.blame, instigator, {"vo_cbt"}))
		elseif self._values.AI_event == "gangster_weapons_hot" then
			managers.groupai:state():on_gangster_weapons_hot(managers.groupai:state().analyse_giveaway(self._values.blame, instigator, {"vo_cbt"}))
		end
	end
	ElementAiGlobalEvent.super.on_executed(self, instigator)
end
