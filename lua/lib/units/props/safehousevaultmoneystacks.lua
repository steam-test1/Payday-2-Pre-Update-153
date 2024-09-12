SafehouseVaultMoneyStacks = SafehouseVaultMoneyStacks or class(UnitBase)
SafehouseVaultMoneyStacks.CHUNKS = 5
SafehouseVaultMoneyStacks.MONEY_STEPS = {
	100000,
	1000000,
	5000000,
	10000000,
	20000000,
	50000000,
	100000000,
	150000000,
	200000000,
	250000000,
	300000000,
	350000000,
	400000000,
	500000000,
	1000000000
}

function SafehouseVaultMoneyStacks:init(unit)
	UnitBase.init(self, unit, false)
	self._unit = unit
	self:_setup()
end

function SafehouseVaultMoneyStacks:_setup()
	self._tiers = {}
	local cash_index = (self.tier - 1) * self.CHUNKS
	for i = 1, self.CHUNKS do
		local body = self._unit:body("body_money_chunk_" .. tostring(i))
		if body then
			local objects = {}
			local obj = self._unit:get_object(Idstring("g_money_chunk_" .. tostring(i)))
			if obj then
				table.insert(objects, obj)
			end
			table.insert(self._tiers, {
				body = body,
				objects = objects,
				cash = self.MONEY_STEPS[cash_index + i]
			})
		end
	end
	local total = managers.money:total()
	local found_body = false
	for i = #self._tiers, 1, -1 do
		local data = self._tiers[i]
		if total < data.cash then
			self:_set_tier_enabled(data, false)
		elseif not found_body then
			self:_set_tier_enabled(data, true)
			found_body = true
		else
			self:_set_tier_enabled(data, false)
		end
	end
end

function SafehouseVaultMoneyStacks:_set_tier_enabled(tier_data, enable)
	tier_data.body:set_enabled(enable)
	for i, obj in ipairs(tier_data.objects) do
		obj:set_visibility(enable)
	end
end
