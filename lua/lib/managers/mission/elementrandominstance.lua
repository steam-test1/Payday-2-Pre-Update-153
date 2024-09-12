ElementRandomInstance = ElementRandomInstance or class(CoreMissionScriptElement.MissionScriptElement)
ElementRandomInstance._type = "input"

function ElementRandomInstance:init(...)
	ElementRandomInstance.super.init(self, ...)
	self._instances = {}
end

function ElementRandomInstance:client_on_executed(...)
end

function ElementRandomInstance:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	self._unused_randoms = {}
	for i, element_data in ipairs(self._values.instances) do
		table.insert(self._unused_randoms, i)
	end
	local amount = self:_calc_amount()
	for i = 1, math.min(amount, #self._values.instances) do
		table.insert(self._instances, self._values.instances[self:_get_random_elements()])
	end
	for i, instance_data in ipairs(self._instances) do
		local elements
		if self._type == "input" then
			elements = managers.world_instance:get_registered_input_elements(instance_data.instance, instance_data.event)
		else
			elements = managers.world_instance:get_registered_output_event_elements(instance_data.instance, instance_data.event)
		end
		if elements then
			for _, element in ipairs(elements) do
				element:on_executed(instigator)
			end
		end
	end
	ElementRandomInstance.super.on_executed(self, instigator)
end

function ElementRandomInstance:_calc_amount()
	local amount = self._values.amount or 1
	if self._values.amount_random and self._values.amount_random > 0 then
		amount = amount + math.random(self._values.amount_random + 1) - 1
	end
	return amount
end

function ElementRandomInstance:_get_random_elements()
	local t = {}
	local rand = math.random(#self._unused_randoms)
	return table.remove(self._unused_randoms, rand)
end

ElementRandomInstanceInputEvent = ElementRandomInstanceInputEvent or class(CoreMissionScriptElement.MissionScriptElement)
ElementRandomInstanceInputEvent._type = "input"
ElementRandomInstanceOutputEvent = ElementRandomInstanceOutputEvent or class(CoreMissionScriptElement.MissionScriptElement)
ElementRandomInstanceOutputEvent._type = "output"
