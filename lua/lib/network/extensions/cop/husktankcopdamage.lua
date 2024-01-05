HuskTankCopDamage = HuskTankCopDamage or class(HuskCopDamage)

function HuskTankCopDamage:damage_melee(attack_data)
	return
end

function HuskTankCopDamage:sync_damage_melee(attacker_unit, damage_percent, damage_effect_percent, i_body, hit_offset_height)
	return
end

function HuskTankCopDamage:seq_clbk_vizor_shatter()
	TankCopDamage.seq_clbk_vizor_shatter(self)
end
