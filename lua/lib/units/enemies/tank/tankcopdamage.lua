TankCopDamage = TankCopDamage or class(CopDamage)

function TankCopDamage:damage_melee(attack_data)
	if tweak_data.blackmarket.melee_weapons[attack_data.name_id] and tweak_data.blackmarket.melee_weapons[attack_data.name_id].type == "knife" then
		TankCopDamage.super.damage_melee(self, attack_data)
	else
		return
	end
end

function TankCopDamage:seq_clbk_vizor_shatter()
	if not self._unit:character_damage():dead() then
		self._unit:sound():say("visor_lost")
	end
end
