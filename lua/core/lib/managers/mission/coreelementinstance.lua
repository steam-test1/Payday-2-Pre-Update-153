core:module("CoreElementInstance")
core:import("CoreMissionScriptElement")
ElementInstanceInput = ElementInstanceInput or class(CoreMissionScriptElement.MissionScriptElement)

function ElementInstanceInput:init(...)
	ElementInstanceInput.super.init(self, ...)
	managers.world_instance:register_input_element(self._values.instance_name, self._values.event, self)
end

function ElementInstanceInput:client_on_executed(...)
end

function ElementInstanceInput:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	ElementInstanceInput.super.on_executed(self, instigator)
end

ElementInstanceOutput = ElementInstanceOutput or class(CoreMissionScriptElement.MissionScriptElement)

function ElementInstanceOutput:init(...)
	ElementInstanceOutput.super.init(self, ...)
end

function ElementInstanceOutput:on_created()
	print("ElementInstanceOutput:on_created()")
	self._output_elements = managers.world_instance:get_registered_output_event_elements(self._values.instance_name, self._values.event)
end

function ElementInstanceOutput:client_on_executed(...)
end

function ElementInstanceOutput:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	print("ElementInstanceOutput:on_executed", instigator)
	if self._output_elements then
		for _, element in ipairs(self._output_elements) do
			element:on_executed(instigator)
		end
	end
	ElementInstanceOutput.super.on_executed(self, instigator)
end

ElementInstanceInputEvent = ElementInstanceInputEvent or class(CoreMissionScriptElement.MissionScriptElement)

function ElementInstanceInputEvent:init(...)
	ElementInstanceInputEvent.super.init(self, ...)
end

function ElementInstanceInputEvent:on_created()
	print("ElementInstanceInputEvent:on_created()")
	self._input_elements = managers.world_instance:get_registered_input_elements(self._values.instance, self._values.event)
end

function ElementInstanceInputEvent:client_on_executed(...)
end

function ElementInstanceInputEvent:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	if self._input_elements then
		for _, element in ipairs(self._input_elements) do
			element:on_executed(instigator)
		end
	end
	ElementInstanceInputEvent.super.on_executed(self, instigator)
end

ElementInstanceOutputEvent = ElementInstanceOutputEvent or class(CoreMissionScriptElement.MissionScriptElement)

function ElementInstanceOutputEvent:init(...)
	ElementInstanceOutputEvent.super.init(self, ...)
	managers.world_instance:register_output_event_element(self._values.instance, self._values.event, self)
end

function ElementInstanceOutputEvent:client_on_executed(...)
end

function ElementInstanceOutputEvent:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	ElementInstanceOutputEvent.super.on_executed(self, instigator)
end
