FireTweakData = FireTweakData or class()

function FireTweakData:init(tweak_data)
	self.fire_bones = {
		"Spine",
		"LeftArm",
		"RightArm",
		"LeftLeg",
		"RightLeg"
	}
	self.effects = {
		endless = {
			expensive = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_endless",
			normal = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_endless_no_light",
			cheap = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_endless_cheap"
		},
		short = {
			expensive = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire",
			normal = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_cheap",
			cheap = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_cheap"
		},
		[5] = {
			expensive = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_5s",
			normal = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_5s_cheap",
			cheap = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_5s_cheap"
		},
		[7] = {
			expensive = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_7s",
			normal = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_7s_cheap",
			cheap = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_7s_cheap"
		},
		[9] = {
			expensive = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_9s",
			normal = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_9s_cheap",
			cheap = "effects/payday2/particles/explosions/molotov_grenade_enemy_on_fire_9s_cheap"
		}
	}
	self.effects_cost = {
		"expensive",
		"normal",
		"normal",
		"cheap",
		"cheap"
	}
	self.fire_death_anims = {
		[0] = {effect = "short", duration = 3},
		[1] = {effect = 9, duration = 9},
		[2] = {effect = 5, duration = 5},
		[3] = {effect = 5, duration = 5},
		[4] = {effect = 7, duration = 7},
		[5] = {effect = "short", duration = 3}
	}
end
