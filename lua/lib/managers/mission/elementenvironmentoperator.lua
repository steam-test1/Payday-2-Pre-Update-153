ElementEnvironmentOperator = ElementEnvironmentOperator or class(CoreMissionScriptElement.MissionScriptElement)

function ElementEnvironmentOperator:init(...)
	ElementEnvironmentOperator.super.init(self, ...)
end

function ElementEnvironmentOperator:stop_simulation(...)
	if self._old_default_environment then
		managers.viewport:set_default_environment(self._old_default_environment, nil, nil)
	end
	ElementEnvironmentOperator.super.destroy(self, ...)
end

function ElementEnvironmentOperator:client_on_executed(...)
	self:on_executed(...)
end

function ElementEnvironmentOperator:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	self._old_default_environment = managers.viewport:default_environment()
	managers.viewport:set_default_environment(self._values.environment, nil, nil)
	ElementEnvironmentOperator.super.on_executed(self, instigator)
end
