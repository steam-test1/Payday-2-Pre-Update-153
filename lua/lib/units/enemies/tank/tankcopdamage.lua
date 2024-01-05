TankCopDamage = TankCopDamage or class(CopDamage)

function TankCopDamage:damage_melee(attack_data)
	return
end

function TankCopDamage:sync_damage_melee(attacker_unit, damage_percent, damage_effect_percent, i_body, hit_offset_height)
	return
end

function TankCopDamage:seq_clbk_vizor_shatter()
	if not self._unit:character_damage():dead() then
		self._unit:sound():say("visor_lost")
	end
end
