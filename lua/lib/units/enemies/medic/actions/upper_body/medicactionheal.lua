MedicActionHeal = MedicActionHeal or class()

function MedicActionHeal:init(action_desc, common_data)
	self._common_data = common_data
	self._ext_movement = common_data.ext_movement
	self._ext_inventory = common_data.ext_inventory
	self._ext_anim = common_data.ext_anim
	self._body_part = action_desc.body_part
	self._unit = common_data.unit
	self._machine = common_data.machine
	self._attention = common_data.attention
	self._action_desc = action_desc
	self._ext_movement:play_redirect("heal")
	self._unit:sound():say("heal", true)
	self._done = false
	return true
end

function MedicActionHeal:on_exit()
	if self._unit:contour() then
		self._unit:contour():remove("medic_healing", true)
	end
end

function MedicActionHeal:update(t)
	if not self._unit:anim_data().healing then
		self._done = true
		self._ext_movement:play_redirect("idle")
		self._ext_movement:action_request({type = "idle", body_part = 2})
	end
end

function MedicActionHeal:type()
	return "heal"
end

function MedicActionHeal:expired()
	return self._expired
end

function MedicActionHeal:chk_block(action_type, t)
	if action_type == "heavy_hurt" or action_type == "hurt" or action_type == "death" then
		return false
	end
	return not self._done
end

function MedicActionHeal:on_attention(attention)
	self._attention = attention
end

function MedicActionHeal:body_part()
	return self._body_part
end

function MedicActionHeal:need_upd()
	return true
end

function MedicActionHeal:save(save_data)
	for i, k in pairs(self._action_desc) do
		if type_name(k) ~= "Unit" or alive(k) then
			save_data[i] = k
		end
	end
end
