BaseModifier = BaseModifier or class()
BaseModifier._type = "BaseModifier"
BaseModifier.name_id = "none"
BaseModifier.desc_id = "none"
BaseModifier.default_value = nil

function BaseModifier:get_description(modifier_id)
	local data = managers.crime_spree:get_modifier(modifier_id) or {}
	local params = {}
	for key, dat in pairs(data.data) do
		params[key] = dat[1]
	end
	return managers.localization:text(self.desc_id, params)
end

function BaseModifier:init(data)
	self._data = data
end

function BaseModifier:destroy()
end

function BaseModifier:value(id)
	id = id or self.default_value
	return self._data[id]
end

function BaseModifier:is_active()
	for _, mod in ipairs(managers.crime_spree:active_modifier_classes()) do
		if mod._type == self._type then
			return true
		end
	end
	return false
end
