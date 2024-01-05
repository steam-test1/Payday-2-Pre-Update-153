HuskTankCopDamage = HuskTankCopDamage or class(HuskCopDamage)

function HuskTankCopDamage:damage_melee(attack_data)
	if tweak_data.blackmarket.melee_weapons[attack_data.name_id].type == "knife" then
		HuskTankCopDamage.super.damage_melee(self, attack_data)
	else
		return
	end
end

function HuskTankCopDamage:seq_clbk_vizor_shatter()
	TankCopDamage.seq_clbk_vizor_shatter(self)
end
