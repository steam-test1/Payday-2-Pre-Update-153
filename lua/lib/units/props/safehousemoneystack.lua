SafehouseMoneyStack = SafehouseMoneyStack or class(UnitBase)
SafehouseMoneyStack.SMALL_MAX_SUM = 1000000
SafehouseMoneyStack.MAX_SUM = 10000000 + SafehouseMoneyStack.SMALL_MAX_SUM - 1
SafehouseMoneyStack.STEPS = 19
SafehouseMoneyStack.SMALL_STEPS = 85

function SafehouseMoneyStack:init(unit)
	UnitBase.init(self, unit, false)
	self._unit = unit
	self:_setup()
end

function SafehouseMoneyStack:_setup()
	self._small_sequences = {}
	for i = 1, SafehouseMoneyStack.SMALL_STEPS do
		local post_fix = (i < 10 and "0" or "") .. i
		table.insert(self._small_sequences, "var_small_money_grow_" .. post_fix)
	end
	self._sequences = {}
	for i = 1, SafehouseMoneyStack.STEPS do
		local post_fix = (i < 10 and "0" or "") .. i
		table.insert(self._sequences, "var_money_grow_" .. post_fix)
	end
	local money = managers.money:total()
	self:_run_sequences(money)
end

function SafehouseMoneyStack:_run_sequences(money)
	local small_sum = math.mod(money, SafehouseMoneyStack.SMALL_MAX_SUM)
	local where = math.min(small_sum / SafehouseMoneyStack.SMALL_MAX_SUM, 1)
	local sequence_index = math.ceil(where * #self._small_sequences)
	print("where small", where, sequence_index)
	local sequence = sequence_index == 0 and "var_small_money_grow_00" or self._small_sequences[math.clamp(sequence_index, 1, #self._small_sequences)]
	self._unit:damage():run_sequence_simple(sequence)
	money = money - small_sum
	local where = math.min(money / SafehouseMoneyStack.MAX_SUM, 1)
	local sequence_index = math.ceil(where * #self._sequences)
	local sequence = sequence_index == 0 and "var_money_grow_00" or self._sequences[math.clamp(sequence_index, 1, #self._sequences)]
	self._unit:damage():run_sequence_simple(sequence)
end

function SafehouseMoneyStack:debug_test()
	self._test_money = 0
	self._unit:set_extension_update_enabled(Idstring("base"), true)
end

function SafehouseMoneyStack:update()
	if self._test_money then
		self:_run_sequences(self._test_money)
		self._test_money = self._test_money + 25000
		if self._test_money >= SafehouseMoneyStack.MAX_SUM then
			self._test_money = nil
		end
	end
end

function SafehouseMoneyStack:destroy()
end
