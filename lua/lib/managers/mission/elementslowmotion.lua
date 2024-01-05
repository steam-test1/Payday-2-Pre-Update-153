core:import("CoreMissionScriptElement")
ElementSlowMotion = ElementSlowMotion or class(CoreMissionScriptElement.MissionScriptElement)

function ElementSlowMotion:on_executed(instigator)
	print("came here 1")
	if not self._values.enabled then
		return
	end
	print("came here 2")
	local eff_desc = tweak_data.timespeed.mission_effects[self._values.eff_name]
	if not eff_desc then
		debug_pause("[ElementSlowMotion] could not find effect", self._values.eff_name)
		return
	end
	print("came here 3")
	local eff_id = "ElementSlowMotion_" .. tostring(self._id)
	managers.time_speed:play_effect(eff_id, eff_desc)
	print("came here 4")
	ElementSlowMotion.super.on_executed(self, instigator)
end
