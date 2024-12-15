MedicDamage = MedicDamage or class(CopDamage)

function MedicDamage:init(...)
	MedicDamage.super.init(self, ...)
	self._heal_cooldown_t = 0
end

function MedicDamage:update(t, dt)
end

function MedicDamage:heal_unit(unit)
	local t = Application:time()
	local cooldown = tweak_data.medic.cooldown
	if t < self._heal_cooldown_t + cooldown then
		return false
	end
	if self._unit:anim_data() and self._unit:anim_data().act then
		return false
	end
	local tweak_table = unit:base()._tweak_table
	if table.contains(tweak_data.medic.disabled_units, tweak_table) then
		return false
	end
	if unit:brain() and unit:brain()._logic_data then
		local team = unit:brain()._logic_data.team
		if team and team.id ~= "law1" and (not team.friends or not team.friends.law1) then
			return false
		end
	end
	if unit:brain() and unit:brain()._logic_data and unit:brain()._logic_data.is_converted then
		return false
	end
	local cop_dmg = unit:character_damage()
	cop_dmg._health = cop_dmg._HEALTH_INIT
	cop_dmg._health_ratio = 1
	self._heal_cooldown_t = t
	print("[MedicDamage:heal_unit] Unit successfully healed")
	local action_data = {
		type = "heal",
		body_part = 3,
		client_interrupt = Network:is_client() and true or false
	}
	self._unit:movement():action_request(action_data)
	managers.network:session():send_to_peers("sync_medic_heal", self._unit)
	return true
end
