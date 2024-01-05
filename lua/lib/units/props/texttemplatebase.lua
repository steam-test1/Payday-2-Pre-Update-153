TextTemplateBase = TextTemplateBase or class(UnitBase)

function TextTemplateBase:init(unit)
	TextTemplateBase.super.init(self, unit, false)
	self:_apply_template()
end

function TextTemplateBase:_apply_template()
	if self.TEMPLATE == "stocks" then
		self:_stock_ticker()
	elseif self.TEMPLATE == "big_bank_welcome" then
		self:_big_bank_welcome()
	end
end

function TextTemplateBase:set_template(template)
	self.TEMPLATE = template
	self:_apply_template()
end

function TextTemplateBase:_stock_ticker()
	for i = 1, self._unit:text_gui().ROWS do
		self._unit:text_gui():set_row_gap(i, 20)
		self._unit:text_gui():clear_row_and_guis(i)
		self._unit:text_gui():set_row_speed(i, i * 100 + 40 + 120 * math.rand(1))
	end
	local companies = {
		"Big bank",
		"Starbeeze",
		"Overkill",
		"GenSEC",
		"505",
		"Google",
		"Apple",
		"Microsoft",
		"Ilija CORP",
		"New York RNGRS",
		"Nissan",
		"Nintendo",
		"WPC",
		"Murky Water",
		"Beer Company",
		"Ivan food sollution systems",
		"Catfight",
		"LOL"
	}
	if not TextTemplateBase.STOCK_PERCENT then
		TextTemplateBase.STOCK_PERCENT = {}
		for i, company in ipairs(companies) do
			TextTemplateBase.STOCK_PERCENT[i] = 10 - math.rand(20)
		end
	end
	for i, company in ipairs(companies) do
		local j = TextTemplateBase.STOCK_PERCENT[i]
		local row = math.mod(i, self._unit:text_gui().ROWS) + 1
		self._unit:text_gui():add_text(row, company, "white")
		self._unit:text_gui():add_text(row, "" .. (j < 0 and "" or "+") .. string.format("%.2f", j) .. "%", j < 0 and "light_red" or "light_green", self._unit:text_gui().FONT_SIZE / 1.5, "bottom", nil)
		self._unit:text_gui():add_text(row, "  ", "white")
	end
end

function TextTemplateBase:_big_bank_welcome()
	self._unit:text_gui():set_row_speed(1, 100)
	self._unit:text_gui():set_row_speed(2, 240 + 120 * math.rand(1))
	self._unit:text_gui():set_row_gap(1, 320)
	for i = 1, self._unit:text_gui().ROWS do
		self._unit:text_gui():clear_row_and_guis(i)
	end
	local texts = {
		"Welcome to Big Bank"
	}
	local texts2 = {
		"Loan",
		"Invest",
		"Market",
		"Stock",
		"Currencies",
		"Global Markets",
		"Sell",
		"Buy",
		"Portfolio",
		"Funds",
		"Inflation"
	}
	for i, text in ipairs(texts) do
		self._unit:text_gui():add_text(1, text, "green")
	end
	for i, text in ipairs(texts2) do
		self._unit:text_gui():add_text(2, text, "light_green")
		self._unit:text_gui():add_text(2, " - ", "light_green")
	end
end

function TextTemplateBase:destroy()
end

function TextTemplateBase:save(data)
	local state = {}
	state.template = self.TEMPLATE
	data.TextTemplateBase = state
end

function TextTemplateBase:load(data)
	local state = data.TextTemplateBase
	if state.template and state.TEMPLATE ~= self.TEMPLATE then
		self:set_template(state.template)
	end
end
