core:import("CoreMissionScriptElement")
ElementMoney = ElementMoney or class(CoreMissionScriptElement.MissionScriptElement)
ElementMoney.NONE = "none"
ElementMoney.ADD_OFFSHORE = "AddOffshore"
ElementMoney.DEDUCT_OFFSHORE = "DeductOffshore"

function ElementMoney:init(...)
	ElementMoney.super.init(self, ...)
end

function ElementMoney:client_on_executed(...)
	self:on_executed(...)
end

function ElementMoney:on_executed(instigator)
	if not self._values.enabled or not self._values.amount then
		return
	end
	if self._values.only_local_player and instigator ~= managers.player:local_player() then
		print("ElementMoney ", self, "can only run if the local player instigates the event!", instigator, managers.player:local_player())
		return
	end
	if self._values.action == ElementMoney.ADD_OFFSHORE then
		managers.money:add_to_offshore(self._values.amount)
	elseif self._values.action == ElementMoney.DEDUCT_OFFSHORE then
		managers.money:deduct_from_offshore(self._values.amount)
	elseif self._values.action ~= ElementMoney.NONE then
		managers.editor:output_error("Cant perform money action " .. self._values.action .. " in element " .. self._editor_name .. ".")
	end
	ElementMoney.super.on_executed(self, instigator)
end
