require("lib/tweak_data/WeaponFactoryTweakData")
WeaponTweakData = WeaponTweakData or class()

function WeaponTweakData:init()
	self:_create_table_structure()
	self:_init_data_player_weapons()
	self:_init_data_m4_npc()
	self:_init_data_m14_npc()
	self:_init_data_m14_sniper_npc()
	self:_init_data_c45_npc()
	self:_init_data_beretta92_npc()
	self:_init_data_raging_bull_npc()
	self:_init_data_r870_npc()
	self:_init_data_mossberg_npc()
	self:_init_data_mp5_npc()
	self:_init_data_mac11_npc()
	self:_init_data_glock_18_npc()
	self:_init_data_ak47_npc()
	self:_init_data_g36_npc()
	self:_init_data_g17_npc()
	self:_init_data_mp9_npc()
	self:_init_data_olympic_npc()
	self:_init_data_m16_npc()
	self:_init_data_aug_npc()
	self:_init_data_ak74_npc()
	self:_init_data_ak5_npc()
	self:_init_data_p90_npc()
	self:_init_data_amcar_npc()
	self:_init_data_mac10_npc()
	self:_init_data_akmsu_npc()
	self:_init_data_akm_npc()
	self:_init_data_deagle_npc()
	self:_init_data_serbu_npc()
	self:_init_data_saiga_npc()
	self:_init_data_huntsman_npc()
	self:_init_data_saw_npc()
	self:_init_data_sentry_gun_npc()
	self:_precalculate_values()
end

function WeaponTweakData:_init_data_c45_npc()
	self.c45_npc.sounds.prefix = "c45_npc"
	self.c45_npc.use_data.selection_index = 1
	self.c45_npc.DAMAGE = 1
	self.c45_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.c45_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.c45_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.c45_npc.CLIP_AMMO_MAX = 10
	self.c45_npc.NR_CLIPS_MAX = 5
	self.c45_npc.hold = "pistol"
	self.c45_npc.hud_icon = "c45"
	self.c45_npc.alert_size = 2500
	self.c45_npc.suppression = 1
end

function WeaponTweakData:_init_data_beretta92_npc()
	self.beretta92_npc.sounds.prefix = "beretta_npc"
	self.beretta92_npc.use_data.selection_index = 1
	self.beretta92_npc.DAMAGE = 1
	self.beretta92_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.beretta92_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.beretta92_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.beretta92_npc.CLIP_AMMO_MAX = 14
	self.beretta92_npc.NR_CLIPS_MAX = 4
	self.beretta92_npc.hold = "pistol"
	self.beretta92_npc.hud_icon = "beretta92"
	self.beretta92_npc.alert_size = 300
	self.beretta92_npc.suppression = 0.3
end

function WeaponTweakData:_init_data_glock_18_npc()
	self.glock_18_npc.sounds.prefix = "g18c_npc"
	self.glock_18_npc.use_data.selection_index = 1
	self.glock_18_npc.DAMAGE = 1
	self.glock_18_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.glock_18_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.glock_18_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.glock_18_npc.CLIP_AMMO_MAX = 20
	self.glock_18_npc.NR_CLIPS_MAX = 8
	self.glock_18_npc.hold = "pistol"
	self.glock_18_npc.hud_icon = "glock"
	self.glock_18_npc.alert_size = 2500
	self.glock_18_npc.suppression = 0.45
end

function WeaponTweakData:_init_data_raging_bull_npc()
	self.raging_bull_npc.sounds.prefix = "rbull_npc"
	self.raging_bull_npc.use_data.selection_index = 1
	self.raging_bull_npc.DAMAGE = 4
	self.raging_bull_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.raging_bull_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.raging_bull_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	self.raging_bull_npc.CLIP_AMMO_MAX = 6
	self.raging_bull_npc.NR_CLIPS_MAX = 8
	self.raging_bull_npc.hold = "pistol"
	self.raging_bull_npc.hud_icon = "raging_bull"
	self.raging_bull_npc.alert_size = 5000
	self.raging_bull_npc.suppression = 1.8
end

function WeaponTweakData:_init_data_m4_npc()
	self.m4_npc.sounds.prefix = "m4_npc"
	self.m4_npc.use_data.selection_index = 2
	self.m4_npc.DAMAGE = 2
	self.m4_npc.muzzleflash = "effects/payday2/particles/weapons/556_auto"
	self.m4_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.m4_npc.CLIP_AMMO_MAX = 20
	self.m4_npc.NR_CLIPS_MAX = 5
	self.m4_npc.auto.fire_rate = 0.175
	self.m4_npc.hold = "rifle"
	self.m4_npc.hud_icon = "m4"
	self.m4_npc.alert_size = 5000
	self.m4_npc.suppression = 1
end

function WeaponTweakData:_init_data_ak47_npc()
	self.ak47_npc.sounds.prefix = "akm_npc"
	self.ak47_npc.use_data.selection_index = 2
	self.ak47_npc.DAMAGE = 3
	self.ak47_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.ak47_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.ak47_npc.CLIP_AMMO_MAX = 20
	self.ak47_npc.NR_CLIPS_MAX = 5
	self.ak47_npc.auto.fire_rate = 0.2
	self.ak47_npc.hold = "rifle"
	self.ak47_npc.hud_icon = "ak"
	self.ak47_npc.alert_size = 5000
	self.ak47_npc.suppression = 1
end

function WeaponTweakData:_init_data_m14_npc()
	self.m14_npc.sounds.prefix = "m14_npc"
	self.m14_npc.use_data.selection_index = 2
	self.m14_npc.DAMAGE = 4
	self.m14_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.m14_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.m14_npc.CLIP_AMMO_MAX = 12
	self.m14_npc.NR_CLIPS_MAX = 8
	self.m14_npc.auto.fire_rate = 0.2
	self.m14_npc.hold = "rifle"
	self.m14_npc.hud_icon = "m14"
	self.m14_npc.alert_size = 5000
	self.m14_npc.suppression = 1
end

function WeaponTweakData:_init_data_m14_sniper_npc()
	self.m14_sniper_npc.sounds.prefix = "sniper_npc"
	self.m14_sniper_npc.use_data.selection_index = 2
	self.m14_sniper_npc.DAMAGE = 7
	self.m14_sniper_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.m14_sniper_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.m14_sniper_npc.CLIP_AMMO_MAX = 6
	self.m14_sniper_npc.NR_CLIPS_MAX = 8
	self.m14_sniper_npc.hold = "rifle"
	self.m14_sniper_npc.hud_icon = "m14"
	self.m14_sniper_npc.alert_size = 5000
	self.m14_sniper_npc.suppression = 1
end

function WeaponTweakData:_init_data_r870_npc()
	self.r870_npc.sounds.prefix = "remington_npc"
	self.r870_npc.use_data.selection_index = 2
	self.r870_npc.DAMAGE = 7
	self.r870_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.r870_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	self.r870_npc.CLIP_AMMO_MAX = 6
	self.r870_npc.NR_CLIPS_MAX = 4
	self.r870_npc.hold = "rifle"
	self.r870_npc.hud_icon = "r870_shotgun"
	self.r870_npc.alert_size = 4500
	self.r870_npc.suppression = 1.8
end

function WeaponTweakData:_init_data_mossberg_npc()
	self.mossberg_npc.sounds.prefix = "mossberg_npc"
	self.mossberg_npc.use_data.selection_index = 2
	self.mossberg_npc.DAMAGE = 6
	self.mossberg_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.mossberg_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	self.mossberg_npc.CLIP_AMMO_MAX = 4
	self.mossberg_npc.NR_CLIPS_MAX = 6
	self.mossberg_npc.hold = "rifle"
	self.mossberg_npc.hud_icon = "mossberg"
	self.mossberg_npc.alert_size = 3000
	self.mossberg_npc.suppression = 2
end

function WeaponTweakData:_init_data_mp5_npc()
	self.mp5_npc.sounds.prefix = "mp5_npc"
	self.mp5_npc.use_data.selection_index = 1
	self.mp5_npc.DAMAGE = 1
	self.mp5_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.mp5_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.mp5_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.mp5_npc.CLIP_AMMO_MAX = 30
	self.mp5_npc.NR_CLIPS_MAX = 5
	self.mp5_npc.auto.fire_rate = 0.1
	self.mp5_npc.hold = "rifle"
	self.mp5_npc.hud_icon = "mp5"
	self.mp5_npc.alert_size = 2500
	self.mp5_npc.suppression = 1
end

function WeaponTweakData:_init_data_mac11_npc()
	self.mac11_npc.sounds.prefix = "mp5_npc"
	self.mac11_npc.use_data.selection_index = 1
	self.mac11_npc.DAMAGE = 1
	self.mac11_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.mac11_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.mac11_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.mac11_npc.CLIP_AMMO_MAX = 32
	self.mac11_npc.NR_CLIPS_MAX = 5
	self.mac11_npc.auto.fire_rate = 0.1
	self.mac11_npc.hold = "pistol"
	self.mac11_npc.hud_icon = "mac11"
	self.mac11_npc.alert_size = 2500
	self.mac11_npc.suppression = 1
end

function WeaponTweakData:_init_data_g36_npc()
	self.g36_npc.sounds.prefix = "g36_npc"
	self.g36_npc.use_data.selection_index = 2
	self.g36_npc.DAMAGE = 2
	self.g36_npc.muzzleflash = "effects/payday2/particles/weapons/556_auto"
	self.g36_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.g36_npc.CLIP_AMMO_MAX = 20
	self.g36_npc.NR_CLIPS_MAX = 5
	self.g36_npc.auto.fire_rate = 0.15
	self.g36_npc.hold = "rifle"
	self.g36_npc.hud_icon = "m4"
	self.g36_npc.alert_size = 5000
	self.g36_npc.suppression = 1
end

function WeaponTweakData:_init_data_g17_npc()
	self.g17_npc.sounds.prefix = "g17_npc"
	self.g17_npc.use_data.selection_index = 1
	self.g17_npc.DAMAGE = 1
	self.g17_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.g17_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.g17_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.g17_npc.CLIP_AMMO_MAX = 10
	self.g17_npc.NR_CLIPS_MAX = 5
	self.g17_npc.hold = "pistol"
	self.g17_npc.hud_icon = "c45"
	self.g17_npc.alert_size = 2500
	self.g17_npc.suppression = 1
end

function WeaponTweakData:_init_data_mp9_npc()
	self.mp9_npc.sounds.prefix = "mp9_npc"
	self.mp9_npc.use_data.selection_index = 1
	self.mp9_npc.DAMAGE = 1
	self.mp9_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.mp9_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.mp9_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.mp9_npc.CLIP_AMMO_MAX = 32
	self.mp9_npc.NR_CLIPS_MAX = 5
	self.mp9_npc.auto.fire_rate = 0.125
	self.mp9_npc.hold = "pistol"
	self.mp9_npc.hud_icon = "mac11"
	self.mp9_npc.alert_size = 1000
	self.mp9_npc.suppression = 1
end

function WeaponTweakData:_init_data_olympic_npc()
	self.olympic_npc.sounds.prefix = "m4_olympic_npc"
	self.olympic_npc.use_data.selection_index = 1
	self.olympic_npc.DAMAGE = 1.5
	self.olympic_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.olympic_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.olympic_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.olympic_npc.CLIP_AMMO_MAX = 32
	self.olympic_npc.NR_CLIPS_MAX = 5
	self.olympic_npc.auto.fire_rate = 0.115
	self.olympic_npc.hold = "rifle"
	self.olympic_npc.hud_icon = "mac11"
	self.olympic_npc.alert_size = 1000
	self.olympic_npc.suppression = 1
end

function WeaponTweakData:_init_data_m16_npc()
	self.m16_npc.sounds.prefix = "m16_npc"
	self.m16_npc.use_data.selection_index = 2
	self.m16_npc.DAMAGE = 3
	self.m16_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.m16_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.m16_npc.CLIP_AMMO_MAX = 12
	self.m16_npc.NR_CLIPS_MAX = 8
	self.m16_npc.auto.fire_rate = 0.215
	self.m16_npc.hold = "rifle"
	self.m16_npc.hud_icon = "m14"
	self.m16_npc.alert_size = 5000
	self.m16_npc.suppression = 1
end

function WeaponTweakData:_init_data_aug_npc()
	self.aug_npc.sounds.prefix = "aug_npc"
	self.aug_npc.use_data.selection_index = 2
	self.aug_npc.DAMAGE = 2
	self.aug_npc.muzzleflash = "effects/payday2/particles/weapons/556_auto"
	self.aug_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.aug_npc.CLIP_AMMO_MAX = 20
	self.aug_npc.NR_CLIPS_MAX = 5
	self.aug_npc.auto.fire_rate = 0.185
	self.aug_npc.hold = "rifle"
	self.aug_npc.hud_icon = "m4"
	self.aug_npc.alert_size = 5000
	self.aug_npc.suppression = 1
end

function WeaponTweakData:_init_data_ak74_npc()
	self.ak74_npc.sounds.prefix = "ak74_npc"
	self.ak74_npc.use_data.selection_index = 2
	self.ak74_npc.DAMAGE = 2
	self.ak74_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.ak74_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.ak74_npc.CLIP_AMMO_MAX = 20
	self.ak74_npc.NR_CLIPS_MAX = 5
	self.ak74_npc.auto.fire_rate = 0.19
	self.ak74_npc.hold = "rifle"
	self.ak74_npc.hud_icon = "ak"
	self.ak74_npc.alert_size = 5000
	self.ak74_npc.suppression = 1
end

function WeaponTweakData:_init_data_ak5_npc()
	self.ak5_npc.sounds.prefix = "ak5_npc"
	self.ak5_npc.use_data.selection_index = 2
	self.ak5_npc.DAMAGE = 2
	self.ak5_npc.muzzleflash = "effects/payday2/particles/weapons/556_auto"
	self.ak5_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.ak5_npc.CLIP_AMMO_MAX = 20
	self.ak5_npc.NR_CLIPS_MAX = 5
	self.ak5_npc.auto.fire_rate = 0.2
	self.ak5_npc.hold = "rifle"
	self.ak5_npc.hud_icon = "m4"
	self.ak5_npc.alert_size = 5000
	self.ak5_npc.suppression = 1
end

function WeaponTweakData:_init_data_p90_npc()
	self.p90_npc.sounds.prefix = "p90_npc"
	self.p90_npc.use_data.selection_index = 1
	self.p90_npc.DAMAGE = 1
	self.p90_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.p90_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.p90_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.p90_npc.CLIP_AMMO_MAX = 32
	self.p90_npc.NR_CLIPS_MAX = 5
	self.p90_npc.auto.fire_rate = 0.11
	self.p90_npc.hold = "rifle"
	self.p90_npc.hud_icon = "mac11"
	self.p90_npc.alert_size = 1000
	self.p90_npc.suppression = 1
end

function WeaponTweakData:_init_data_amcar_npc()
	self.amcar_npc.sounds.prefix = "amcar_npc"
	self.amcar_npc.use_data.selection_index = 2
	self.amcar_npc.DAMAGE = 2
	self.amcar_npc.muzzleflash = "effects/payday2/particles/weapons/556_auto"
	self.amcar_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.amcar_npc.CLIP_AMMO_MAX = 20
	self.amcar_npc.NR_CLIPS_MAX = 5
	self.amcar_npc.auto.fire_rate = 0.2
	self.amcar_npc.hold = "rifle"
	self.amcar_npc.hud_icon = "m4"
	self.amcar_npc.alert_size = 5000
	self.amcar_npc.suppression = 1
end

function WeaponTweakData:_init_data_mac10_npc()
	self.mac10_npc.sounds.prefix = "mac10_npc"
	self.mac10_npc.use_data.selection_index = 1
	self.mac10_npc.DAMAGE = 1
	self.mac10_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.mac10_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.mac10_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.mac10_npc.CLIP_AMMO_MAX = 32
	self.mac10_npc.NR_CLIPS_MAX = 5
	self.mac10_npc.auto.fire_rate = 0.9
	self.mac10_npc.hold = "pistol"
	self.mac10_npc.hud_icon = "mac11"
	self.mac10_npc.alert_size = 1000
	self.mac10_npc.suppression = 1
end

function WeaponTweakData:_init_data_akmsu_npc()
	self.akmsu_npc.sounds.prefix = "akmsu_npc"
	self.akmsu_npc.use_data.selection_index = 1
	self.akmsu_npc.DAMAGE = 3
	self.akmsu_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.akmsu_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.akmsu_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.akmsu_npc.CLIP_AMMO_MAX = 32
	self.akmsu_npc.NR_CLIPS_MAX = 5
	self.akmsu_npc.auto.fire_rate = 0.1
	self.akmsu_npc.hold = "rifle"
	self.akmsu_npc.hud_icon = "mac11"
	self.akmsu_npc.alert_size = 1000
	self.akmsu_npc.suppression = 1
end

function WeaponTweakData:_init_data_akm_npc()
	self.akm_npc.sounds.prefix = "akm_npc"
	self.akm_npc.use_data.selection_index = 2
	self.akm_npc.DAMAGE = 3
	self.akm_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.akm_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.akm_npc.CLIP_AMMO_MAX = 20
	self.akm_npc.NR_CLIPS_MAX = 5
	self.akm_npc.auto.fire_rate = 0.2
	self.akm_npc.hold = "rifle"
	self.akm_npc.hud_icon = "ak"
	self.akm_npc.alert_size = 5000
	self.akm_npc.suppression = 1
end

function WeaponTweakData:_init_data_deagle_npc()
	self.deagle_npc.sounds.prefix = "deagle_npc"
	self.deagle_npc.use_data.selection_index = 1
	self.deagle_npc.DAMAGE = 4
	self.deagle_npc.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.deagle_npc.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.deagle_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.deagle_npc.CLIP_AMMO_MAX = 10
	self.deagle_npc.NR_CLIPS_MAX = 5
	self.deagle_npc.hold = "pistol"
	self.deagle_npc.hud_icon = "c45"
	self.deagle_npc.alert_size = 2500
	self.deagle_npc.suppression = 1
end

function WeaponTweakData:_init_data_serbu_npc()
	self.serbu_npc.sounds.prefix = "serbu_npc"
	self.serbu_npc.use_data.selection_index = 1
	self.serbu_npc.DAMAGE = 5
	self.serbu_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.serbu_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	self.serbu_npc.CLIP_AMMO_MAX = 6
	self.serbu_npc.NR_CLIPS_MAX = 4
	self.serbu_npc.hold = "rifle"
	self.serbu_npc.hud_icon = "r870_shotgun"
	self.serbu_npc.alert_size = 4500
	self.serbu_npc.suppression = 1.8
end

function WeaponTweakData:_init_data_saiga_npc()
	self.saiga_npc.sounds.prefix = "saiga_npc"
	self.saiga_npc.use_data.selection_index = 2
	self.saiga_npc.DAMAGE = 5
	self.saiga_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.saiga_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug"
	self.saiga_npc.CLIP_AMMO_MAX = 6
	self.saiga_npc.NR_CLIPS_MAX = 4
	self.saiga_npc.hold = "rifle"
	self.saiga_npc.hud_icon = "r870_shotgun"
	self.saiga_npc.alert_size = 4500
	self.saiga_npc.suppression = 1.8
end

function WeaponTweakData:_init_data_huntsman_npc()
	self.huntsman_npc.sounds.prefix = "huntsman_npc"
	self.huntsman_npc.use_data.selection_index = 2
	self.huntsman_npc.DAMAGE = 12
	self.huntsman_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.huntsman_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	self.huntsman_npc.CLIP_AMMO_MAX = 2
	self.huntsman_npc.NR_CLIPS_MAX = 4
	self.huntsman_npc.hold = "rifle"
	self.huntsman_npc.hud_icon = "r870_shotgun"
	self.huntsman_npc.alert_size = 4500
	self.huntsman_npc.suppression = 1.8
end

function WeaponTweakData:_init_data_saw_npc()
	self.saw_npc.sounds.prefix = "saw_npc"
	self.saw_npc.sounds.fire = "Play_npc_saw_handheld_start"
	self.saw_npc.sounds.stop_fire = "Play_npc_saw_handheld_end"
	self.saw_npc.use_data.selection_index = 2
	self.saw_npc.DAMAGE = 1
	self.saw_npc.muzzleflash = "effects/payday2/particles/weapons/762_auto"
	self.saw_npc.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	self.saw_npc.CLIP_AMMO_MAX = 2
	self.saw_npc.NR_CLIPS_MAX = 4
	self.saw_npc.hold = "rifle"
	self.saw_npc.hud_icon = "r870_shotgun"
	self.saw_npc.alert_size = 4500
	self.saw_npc.suppression = 1.8
end

function WeaponTweakData:_init_data_sentry_gun_npc()
	self.sentry_gun.name_id = "debug_sentry_gun"
	self.sentry_gun.DAMAGE = 1
	self.sentry_gun.SPREAD = 5
	self.sentry_gun.FIRE_RANGE = 5000
	self.sentry_gun.muzzleflash = "effects/payday2/particles/weapons/9mm_auto"
	self.sentry_gun.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence"
	self.sentry_gun.auto.fire_rate = 0.15
	self.sentry_gun.alert_size = 2500
	self.sentry_gun.BAG_DMG_MUL = 0.25
	self.sentry_gun.SHIELD_DMG_MUL = 0
	self.sentry_gun.LOST_SIGHT_VERIFICATION = 0.1
	self.sentry_gun.DEATH_VERIFICATION = {0.4, 0.75}
	self.sentry_gun.DETECTION_RANGE = 1800
	self.sentry_gun.KEEP_FIRE_ANGLE = 0.8
	self.sentry_gun.MAX_VEL_SPIN = 120
	self.sentry_gun.MIN_VEL_SPIN = self.sentry_gun.MAX_VEL_SPIN * 0.05
	self.sentry_gun.SLOWDOWN_ANGLE_SPIN = 30
	self.sentry_gun.ACC_SPIN = self.sentry_gun.MAX_VEL_SPIN * 5
	self.sentry_gun.MAX_VEL_PITCH = 100
	self.sentry_gun.MIN_VEL_PITCH = self.sentry_gun.MAX_VEL_PITCH * 0.05
	self.sentry_gun.SLOWDOWN_ANGLE_PITCH = 20
	self.sentry_gun.ACC_PITCH = self.sentry_gun.MAX_VEL_PITCH * 5
	self.sentry_gun.recoil = {}
	self.sentry_gun.recoil.horizontal = {
		2,
		3,
		0,
		3
	}
	self.sentry_gun.recoil.vertical = {
		1,
		2,
		0,
		4
	}
	self.sentry_gun.challenges = {}
	self.sentry_gun.challenges.group = "sentry_gun"
	self.sentry_gun.challenges.weapon = "sentry_gun"
	self.sentry_gun.suppression = 0.8
end

function WeaponTweakData:_init_data_player_weapons()
	local autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default
	if SystemInfo:platform() == Idstring("WIN32") then
		autohit_rifle_default = {
			MIN_RATIO = 0.75,
			MAX_RATIO = 0.85,
			INIT_RATIO = 0.15,
			far_dis = 5000,
			far_angle = 1.5,
			near_angle = 3
		}
		autohit_pistol_default = {
			MIN_RATIO = 0.82,
			MAX_RATIO = 0.95,
			INIT_RATIO = 0.15,
			far_dis = 5000,
			far_angle = 1.5,
			near_angle = 3
		}
		autohit_shotgun_default = {
			MIN_RATIO = 0.6,
			MAX_RATIO = 0.7,
			INIT_RATIO = 0.15,
			far_dis = 5000,
			far_angle = 1.5,
			near_angle = 3
		}
	else
		autohit_rifle_default = {
			MIN_RATIO = 0.25,
			MAX_RATIO = 0.6,
			INIT_RATIO = 0.6,
			far_dis = 5000,
			far_angle = 3,
			near_angle = 3
		}
		autohit_pistol_default = {
			MIN_RATIO = 0.25,
			MAX_RATIO = 0.6,
			INIT_RATIO = 0.6,
			far_dis = 2500,
			far_angle = 3,
			near_angle = 3
		}
		autohit_shotgun_default = {
			MIN_RATIO = 0.15,
			MAX_RATIO = 0.3,
			INIT_RATIO = 0.3,
			far_dis = 5000,
			far_angle = 5,
			near_angle = 3
		}
	end
	aim_assist_rifle_default = deep_clone(autohit_rifle_default)
	aim_assist_pistol_default = deep_clone(autohit_pistol_default)
	aim_assist_shotgun_default = deep_clone(autohit_shotgun_default)
	aim_assist_rifle_default.near_angle = 40
	aim_assist_pistol_default.near_angle = 40
	aim_assist_shotgun_default.near_angle = 40
	self.crosshair = {}
	self.crosshair.MIN_OFFSET = 18
	self.crosshair.MAX_OFFSET = 150
	self.crosshair.MIN_KICK_OFFSET = 0
	self.crosshair.MAX_KICK_OFFSET = 100
	self.crosshair.DEFAULT_OFFSET = 0.16
	self.crosshair.DEFAULT_KICK_OFFSET = 0.6
	local damage_melee_default = 1.5
	local damage_melee_effect_multiplier_default = 1.75
	self.trip_mines = {}
	self.trip_mines.delay = 0.3
	self.trip_mines.damage = 100
	self.trip_mines.damage_size = 300
	self.trip_mines.alert_radius = 5000
	self:_init_stats()
	self.factory = WeaponFactoryTweakData:new()
	self:_init_new_weapons(autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default)
end

function WeaponTweakData:_init_stats()
	self.stats = {}
	self.stats.alert_size = {
		30000,
		20000,
		15000,
		10000,
		7500,
		6000,
		4500,
		4000,
		3500,
		1800,
		1500,
		1200,
		1000,
		850,
		700,
		500,
		350,
		200,
		100,
		0
	}
	self.stats.suppression = {
		4.5,
		3.9,
		3.6,
		3.3,
		3,
		2.8,
		2.6,
		2.4,
		2.2,
		1.6,
		1.5,
		1.4,
		1.3,
		1.2,
		1.1,
		1,
		0.8,
		0.6,
		0.4,
		0.2
	}
	self.stats.damage = {
		1,
		1.1,
		1.2,
		1.3,
		1.4,
		1.5,
		1.6,
		1.75,
		2,
		2.25,
		2.5,
		2.75,
		3,
		3.25,
		3.5,
		3.75,
		4,
		4.25,
		4.5,
		4.75,
		5,
		5.5,
		6,
		6.5,
		7,
		7.5,
		8,
		8.5,
		9,
		9.5,
		10,
		10.5,
		11,
		11.5,
		12
	}
	self.stats.zoom = {
		63,
		60,
		55,
		50,
		45,
		40,
		35,
		30,
		25,
		20
	}
	self.stats.spread = {
		2,
		1.8,
		1.6,
		1.4,
		1.2,
		1,
		0.8,
		0.6,
		0.4,
		0.2
	}
	self.stats.spread_moving = {
		3,
		2.7,
		2.4,
		2.2,
		2,
		1.7,
		1.4,
		1.2,
		1,
		0.9,
		0.8,
		0.7,
		0.6,
		0.5
	}
	self.stats.recoil = {
		3,
		2.7,
		2.4,
		2.2,
		1.75,
		1.5,
		1.25,
		1.1,
		1,
		1,
		0.9,
		0.8,
		0.7,
		0.6,
		0.5
	}
	self.stats.value = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	}
	self.stats.concealment = {
		0.5,
		0.5,
		0.75,
		0.75,
		0.75,
		0.75,
		0.75,
		0.75,
		0.75,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.15,
		1.35,
		1.35,
		1.35,
		1.35,
		1.35,
		1.35,
		1.35,
		1.35,
		1.5,
		1.5
	}
	self.stats.extra_ammo = {}
	for i = -10, 50, 2 do
		table.insert(self.stats.extra_ammo, i)
	end
end

function WeaponTweakData:_pickup_chance(max_ammo, selection_index)
	local low, high
	if selection_index == 2 then
		low = 0.02
		high = 0.05
	else
		low = 0.02
		high = 0.05
	end
	return {
		max_ammo * low,
		max_ammo * high
	}
end

function WeaponTweakData:_init_new_weapons(autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default)
	local total_damage_primary = 300
	local total_damage_secondary = 150
	self.new_m4 = {}
	self.new_m4.category = "assault_rifle"
	self.new_m4.damage_melee = damage_melee_default
	self.new_m4.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.new_m4.sounds = {}
	self.new_m4.sounds.fire = "m4_fire"
	self.new_m4.sounds.stop_fire = "m4_stop"
	self.new_m4.sounds.dryfire = "m4_dryfire"
	self.new_m4.sounds.enter_steelsight = "m4_tighten"
	self.new_m4.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.new_m4.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.new_m4.timers = {}
	self.new_m4.timers.reload_not_empty = 2.25
	self.new_m4.timers.reload_empty = 3
	self.new_m4.timers.unequip = 0.7
	self.new_m4.timers.equip = 0.66
	self.new_m4.name_id = "bm_w_m4"
	self.new_m4.desc_id = "bm_w_m4_desc"
	self.new_m4.hud_icon = "m4"
	self.new_m4.description_id = "des_m4"
	self.new_m4.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.new_m4.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.new_m4.use_data = {}
	self.new_m4.use_data.selection_index = 2
	self.new_m4.DAMAGE = 1
	self.new_m4.CLIP_AMMO_MAX = 30
	self.new_m4.NR_CLIPS_MAX = math.round(total_damage_primary / 2 / self.new_m4.CLIP_AMMO_MAX)
	self.new_m4.AMMO_MAX = self.new_m4.CLIP_AMMO_MAX * self.new_m4.NR_CLIPS_MAX
	self.new_m4.AMMO_PICKUP = self:_pickup_chance(self.new_m4.AMMO_MAX, 2)
	self.new_m4.auto = {}
	self.new_m4.auto.fire_rate = 0.11
	self.new_m4.spread = {}
	self.new_m4.spread.standing = 3.5
	self.new_m4.spread.crouching = self.new_m4.spread.standing
	self.new_m4.spread.steelsight = 1
	self.new_m4.spread.moving_standing = self.new_m4.spread.standing
	self.new_m4.spread.moving_crouching = self.new_m4.spread.standing
	self.new_m4.spread.moving_steelsight = self.new_m4.spread.steelsight * 2
	self.new_m4.kick = {}
	self.new_m4.kick.standing = {
		0.6,
		0.8,
		-1,
		1
	}
	self.new_m4.kick.crouching = self.new_m4.kick.standing
	self.new_m4.kick.steelsight = self.new_m4.kick.standing
	self.new_m4.shake = {}
	self.new_m4.shake.fire_multiplier = 1
	self.new_m4.shake.fire_steelsight_multiplier = -1
	self.new_m4.autohit = autohit_rifle_default
	self.new_m4.aim_assist = aim_assist_rifle_default
	self.new_m4.animations = {}
	self.new_m4.animations.reload = "reload"
	self.new_m4.animations.reload_not_empty = "reload_not_empty"
	self.new_m4.animations.equip_id = "equip_m4"
	self.new_m4.animations.recoil_steelsight = false
	self.new_m4.transition_duration = 0.02
	self.new_m4.statistics = true
	self.new_m4.stats = {
		damage = 10,
		spread = 7,
		recoil = 8,
		spread_moving = 6,
		zoom = 3,
		concealment = 24,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.glock_17 = {}
	self.glock_17.category = "pistol"
	self.glock_17.damage_melee = damage_melee_default
	self.glock_17.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.glock_17.sounds = {}
	self.glock_17.sounds.fire = "g17_fire"
	self.glock_17.sounds.dryfire = "g17_dryfire"
	self.glock_17.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.glock_17.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.glock_17.single = {}
	self.glock_17.single.fire_rate = 0.12
	self.glock_17.timers = {}
	self.glock_17.timers.reload_not_empty = 1.47
	self.glock_17.timers.reload_empty = 2.12
	self.glock_17.timers.unequip = 0.5
	self.glock_17.timers.equip = 0.5
	self.glock_17.name_id = "bm_w_glock_17"
	self.glock_17.desc_id = "bm_w_glock_17_desc"
	self.glock_17.hud_icon = "c45"
	self.glock_17.description_id = "des_glock_17"
	self.glock_17.hud_ammo = "guis/textures/ammo_9mm"
	self.glock_17.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.glock_17.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.glock_17.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.glock_17.use_data = {}
	self.glock_17.use_data.selection_index = 1
	self.glock_17.DAMAGE = 1
	self.glock_17.CLIP_AMMO_MAX = 17
	self.glock_17.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.glock_17.CLIP_AMMO_MAX)
	self.glock_17.AMMO_MAX = self.glock_17.CLIP_AMMO_MAX * self.glock_17.NR_CLIPS_MAX
	self.glock_17.AMMO_PICKUP = self:_pickup_chance(self.glock_17.AMMO_MAX, 1)
	self.glock_17.spread = {}
	self.glock_17.spread.standing = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.crouching = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.steelsight = self.new_m4.spread.steelsight
	self.glock_17.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.glock_17.kick = {}
	self.glock_17.kick.standing = {
		1.2,
		1.8,
		-0.5,
		0.5
	}
	self.glock_17.kick.crouching = self.glock_17.kick.standing
	self.glock_17.kick.steelsight = self.glock_17.kick.standing
	self.glock_17.crosshair = {}
	self.glock_17.crosshair.standing = {}
	self.glock_17.crosshair.crouching = {}
	self.glock_17.crosshair.steelsight = {}
	self.glock_17.crosshair.standing.offset = 0.175
	self.glock_17.crosshair.standing.moving_offset = 0.6
	self.glock_17.crosshair.standing.kick_offset = 0.4
	self.glock_17.crosshair.crouching.offset = 0.1
	self.glock_17.crosshair.crouching.moving_offset = 0.6
	self.glock_17.crosshair.crouching.kick_offset = 0.3
	self.glock_17.crosshair.steelsight.hidden = true
	self.glock_17.crosshair.steelsight.offset = 0
	self.glock_17.crosshair.steelsight.moving_offset = 0
	self.glock_17.crosshair.steelsight.kick_offset = 0.1
	self.glock_17.shake = {}
	self.glock_17.shake.fire_multiplier = 1
	self.glock_17.shake.fire_steelsight_multiplier = 1
	self.glock_17.autohit = autohit_pistol_default
	self.glock_17.aim_assist = aim_assist_pistol_default
	self.glock_17.weapon_hold = "glock"
	self.glock_17.animations = {}
	self.glock_17.animations.equip_id = "equip_glock"
	self.glock_17.animations.recoil_steelsight = true
	self.glock_17.transition_duration = 0
	self.glock_17.statistics = true
	self.glock_17.stats = {
		damage = 6,
		spread = 7,
		recoil = 7,
		spread_moving = 7,
		zoom = 1,
		concealment = 30,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.mp9 = {}
	self.mp9.category = "smg"
	self.mp9.damage_melee = damage_melee_default
	self.mp9.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.mp9.sounds = {}
	self.mp9.sounds.fire = "mp9_fire"
	self.mp9.sounds.stop_fire = "mp9_stop"
	self.mp9.sounds.dryfire = "mk11_dryfire"
	self.mp9.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.mp9.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.mp9.timers = {}
	self.mp9.timers.reload_not_empty = 1.51
	self.mp9.timers.reload_empty = 2.48
	self.mp9.timers.unequip = 0.75
	self.mp9.timers.equip = 0.5
	self.mp9.name_id = "bm_w_mp9"
	self.mp9.desc_id = "bm_w_mp9_desc"
	self.mp9.hud_icon = "mac11"
	self.mp9.description_id = "des_mp9"
	self.mp9.hud_ammo = "guis/textures/ammo_small_9mm"
	self.mp9.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.mp9.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.mp9.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.mp9.use_data = {}
	self.mp9.use_data.selection_index = 1
	self.mp9.DAMAGE = 1
	self.mp9.CLIP_AMMO_MAX = 30
	self.mp9.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.mp9.CLIP_AMMO_MAX)
	self.mp9.AMMO_MAX = self.mp9.CLIP_AMMO_MAX * self.mp9.NR_CLIPS_MAX
	self.mp9.AMMO_PICKUP = self:_pickup_chance(self.mp9.AMMO_MAX, 1)
	self.mp9.auto = {}
	self.mp9.auto.fire_rate = 0.0675
	self.mp9.spread = {}
	self.mp9.spread.standing = self.new_m4.spread.standing * 0.75
	self.mp9.spread.crouching = self.new_m4.spread.standing * 0.75
	self.mp9.spread.steelsight = self.new_m4.spread.steelsight
	self.mp9.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.mp9.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.mp9.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.mp9.kick = {}
	self.mp9.kick.standing = {
		-1.2,
		1.2,
		-1,
		1
	}
	self.mp9.kick.crouching = self.mp9.kick.standing
	self.mp9.kick.steelsight = self.mp9.kick.standing
	self.mp9.crosshair = {}
	self.mp9.crosshair.standing = {}
	self.mp9.crosshair.crouching = {}
	self.mp9.crosshair.steelsight = {}
	self.mp9.crosshair.standing.offset = 0.4
	self.mp9.crosshair.standing.moving_offset = 0.7
	self.mp9.crosshair.standing.kick_offset = 0.6
	self.mp9.crosshair.crouching.offset = 0.3
	self.mp9.crosshair.crouching.moving_offset = 0.6
	self.mp9.crosshair.crouching.kick_offset = 0.4
	self.mp9.crosshair.steelsight.hidden = true
	self.mp9.crosshair.steelsight.offset = 0
	self.mp9.crosshair.steelsight.moving_offset = 0
	self.mp9.crosshair.steelsight.kick_offset = 0.4
	self.mp9.shake = {}
	self.mp9.shake.fire_multiplier = 1
	self.mp9.shake.fire_steelsight_multiplier = -1
	self.mp9.autohit = autohit_pistol_default
	self.mp9.aim_assist = aim_assist_pistol_default
	self.mp9.animations = {}
	self.mp9.animations.equip_id = "equip_mac11_rifle"
	self.mp9.animations.recoil_steelsight = false
	self.mp9.statistics = true
	self.mp9.stats = {
		damage = 7,
		spread = 6,
		recoil = 8,
		spread_moving = 8,
		zoom = 3,
		concealment = 27,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.r870 = {}
	self.r870.category = "shotgun"
	self.r870.damage_melee = damage_melee_default
	self.r870.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.r870.sounds = {}
	self.r870.sounds.fire = "remington_fire"
	self.r870.sounds.dryfire = "remington_dryfire"
	self.r870.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.r870.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.r870.timers = {}
	self.r870.timers.unequip = 0.7
	self.r870.timers.equip = 0.6
	self.r870.name_id = "bm_w_r870"
	self.r870.desc_id = "bm_w_r870_desc"
	self.r870.hud_icon = "r870_shotgun"
	self.r870.description_id = "des_r870"
	self.r870.hud_ammo = "guis/textures/ammo_shell"
	self.r870.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.r870.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	self.r870.use_data = {}
	self.r870.use_data.selection_index = 2
	self.r870.use_data.align_place = "right_hand"
	self.r870.DAMAGE = 6
	self.r870.damage_near = 700
	self.r870.damage_far = 1500
	self.r870.rays = 5
	self.r870.CLIP_AMMO_MAX = 6
	self.r870.NR_CLIPS_MAX = math.round(total_damage_primary / 6.5 / self.r870.CLIP_AMMO_MAX)
	self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
	self.r870.AMMO_PICKUP = self:_pickup_chance(self.r870.AMMO_MAX, 2)
	self.r870.single = {}
	self.r870.single.fire_rate = 0.575
	self.r870.spread = {}
	self.r870.spread.standing = self.new_m4.spread.standing * 1
	self.r870.spread.crouching = self.new_m4.spread.standing * 1
	self.r870.spread.steelsight = self.new_m4.spread.standing * 0.8
	self.r870.spread.moving_standing = self.new_m4.spread.standing * 1
	self.r870.spread.moving_crouching = self.new_m4.spread.standing * 1
	self.r870.spread.moving_steelsight = self.new_m4.spread.standing * 0.8
	self.r870.kick = {}
	self.r870.kick.standing = {
		1.9,
		2,
		-0.2,
		0.2
	}
	self.r870.kick.crouching = self.r870.kick.standing
	self.r870.kick.steelsight = {
		1.5,
		1.7,
		-0.2,
		0.2
	}
	self.r870.crosshair = {}
	self.r870.crosshair.standing = {}
	self.r870.crosshair.crouching = {}
	self.r870.crosshair.steelsight = {}
	self.r870.crosshair.standing.offset = 0.7
	self.r870.crosshair.standing.moving_offset = 0.7
	self.r870.crosshair.standing.kick_offset = 0.8
	self.r870.crosshair.crouching.offset = 0.65
	self.r870.crosshair.crouching.moving_offset = 0.65
	self.r870.crosshair.crouching.kick_offset = 0.75
	self.r870.crosshair.steelsight.hidden = true
	self.r870.crosshair.steelsight.offset = 0
	self.r870.crosshair.steelsight.moving_offset = 0
	self.r870.crosshair.steelsight.kick_offset = 0
	self.r870.shake = {}
	self.r870.shake.fire_multiplier = 1
	self.r870.shake.fire_steelsight_multiplier = -1
	self.r870.autohit = autohit_shotgun_default
	self.r870.aim_assist = aim_assist_shotgun_default
	self.r870.weapon_hold = "r870_shotgun"
	self.r870.animations = {}
	self.r870.animations.equip_id = "equip_r870_shotgun"
	self.r870.animations.recoil_steelsight = true
	self.r870.statistics = true
	self.r870.stats = {
		damage = 23,
		spread = 8,
		recoil = 3,
		spread_moving = 6,
		zoom = 3,
		concealment = 21,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.glock_18c = {}
	self.glock_18c.category = "pistol"
	self.glock_18c.damage_melee = damage_melee_default
	self.glock_18c.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.glock_18c.sounds = {}
	self.glock_18c.sounds.fire = "g18c_fire"
	self.glock_18c.sounds.stop_fire = "g18c_stop"
	self.glock_18c.sounds.dryfire = "stryk_dryfire"
	self.glock_18c.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.glock_18c.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.glock_18c.timers = {}
	self.glock_18c.timers.reload_not_empty = 1.47
	self.glock_18c.timers.reload_empty = 2.12
	self.glock_18c.timers.unequip = 0.55
	self.glock_18c.timers.equip = 0.55
	self.glock_18c.name_id = "bm_w_glock_18c"
	self.glock_18c.desc_id = "bm_w_glock_18c_desc"
	self.glock_18c.hud_icon = "glock"
	self.glock_18c.description_id = "des_glock"
	self.glock_18c.hud_ammo = "guis/textures/ammo_small_9mm"
	self.glock_18c.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.glock_18c.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.glock_18c.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.glock_18c.use_data = {}
	self.glock_18c.use_data.selection_index = 1
	self.glock_18c.DAMAGE = 1
	self.glock_18c.CLIP_AMMO_MAX = 20
	self.glock_18c.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.glock_18c.CLIP_AMMO_MAX)
	self.glock_18c.AMMO_MAX = self.glock_18c.CLIP_AMMO_MAX * self.glock_18c.NR_CLIPS_MAX
	self.glock_18c.AMMO_PICKUP = self:_pickup_chance(self.glock_18c.AMMO_MAX, 1)
	self.glock_18c.auto = {}
	self.glock_18c.auto.fire_rate = 0.06
	self.glock_18c.spread = {}
	self.glock_18c.spread.standing = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.crouching = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.steelsight = self.new_m4.spread.steelsight
	self.glock_18c.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.glock_18c.kick = {}
	self.glock_18c.kick.standing = self.glock_17.kick.standing
	self.glock_18c.kick.crouching = self.glock_18c.kick.standing
	self.glock_18c.kick.steelsight = self.glock_18c.kick.standing
	self.glock_18c.crosshair = {}
	self.glock_18c.crosshair.standing = {}
	self.glock_18c.crosshair.crouching = {}
	self.glock_18c.crosshair.steelsight = {}
	self.glock_18c.crosshair.standing.offset = 0.3
	self.glock_18c.crosshair.standing.moving_offset = 0.5
	self.glock_18c.crosshair.standing.kick_offset = 0.6
	self.glock_18c.crosshair.crouching.offset = 0.2
	self.glock_18c.crosshair.crouching.moving_offset = 0.5
	self.glock_18c.crosshair.crouching.kick_offset = 0.3
	self.glock_18c.crosshair.steelsight.hidden = true
	self.glock_18c.crosshair.steelsight.offset = 0.2
	self.glock_18c.crosshair.steelsight.moving_offset = 0.2
	self.glock_18c.crosshair.steelsight.kick_offset = 0.3
	self.glock_18c.shake = {}
	self.glock_18c.shake.fire_multiplier = 1
	self.glock_18c.shake.fire_steelsight_multiplier = 1
	self.glock_18c.autohit = autohit_pistol_default
	self.glock_18c.aim_assist = aim_assist_pistol_default
	self.glock_18c.weapon_hold = "glock"
	self.glock_18c.animations = {}
	self.glock_18c.animations.fire = "recoil"
	self.glock_18c.animations.reload = "reload"
	self.glock_18c.animations.reload_not_empty = "reload_not_empty"
	self.glock_18c.animations.equip_id = "equip_glock"
	self.glock_18c.animations.recoil_steelsight = true
	self.glock_18c.challenges = {}
	self.glock_18c.challenges.group = "handgun"
	self.glock_18c.challenges.weapon = "glock"
	self.glock_18c.transition_duration = 0
	self.glock_18c.statistics = true
	self.glock_18c.stats = {
		damage = 8,
		spread = 5,
		recoil = 6,
		spread_moving = 9,
		zoom = 1,
		concealment = 30,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.amcar = {}
	self.amcar.category = "assault_rifle"
	self.amcar.damage_melee = damage_melee_default
	self.amcar.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.amcar.sounds = {}
	self.amcar.sounds.fire = "amcar_fire"
	self.amcar.sounds.stop_fire = "amcar_stop"
	self.amcar.sounds.dryfire = "m4_dryfire"
	self.amcar.sounds.enter_steelsight = "m4_tighten"
	self.amcar.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.amcar.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.amcar.timers = {}
	self.amcar.timers.reload_not_empty = 2.25
	self.amcar.timers.reload_empty = 3
	self.amcar.timers.unequip = 0.8
	self.amcar.timers.equip = 0.7
	self.amcar.name_id = "bm_w_amcar"
	self.amcar.desc_id = "bm_w_amcar_desc"
	self.amcar.hud_icon = "m4"
	self.amcar.description_id = "des_m4"
	self.amcar.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.amcar.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.amcar.use_data = {}
	self.amcar.use_data.selection_index = 2
	self.amcar.DAMAGE = 1
	self.amcar.CLIP_AMMO_MAX = 20
	self.amcar.NR_CLIPS_MAX = math.round(total_damage_primary / 1.6 / self.amcar.CLIP_AMMO_MAX)
	self.amcar.AMMO_MAX = self.amcar.CLIP_AMMO_MAX * self.amcar.NR_CLIPS_MAX
	self.amcar.AMMO_PICKUP = self:_pickup_chance(self.amcar.AMMO_MAX, 2)
	self.amcar.auto = {}
	self.amcar.auto.fire_rate = 0.12
	self.amcar.spread = {}
	self.amcar.spread.standing = self.new_m4.spread.standing
	self.amcar.spread.crouching = self.new_m4.spread.standing
	self.amcar.spread.steelsight = self.new_m4.spread.steelsight
	self.amcar.spread.moving_standing = self.new_m4.spread.standing
	self.amcar.spread.moving_crouching = self.new_m4.spread.standing
	self.amcar.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.amcar.kick = {}
	self.amcar.kick.standing = self.new_m4.kick.standing
	self.amcar.kick.crouching = self.amcar.kick.standing
	self.amcar.kick.steelsight = self.amcar.kick.standing
	self.amcar.crosshair = {}
	self.amcar.crosshair.standing = {}
	self.amcar.crosshair.crouching = {}
	self.amcar.crosshair.steelsight = {}
	self.amcar.crosshair.standing.offset = 0.16
	self.amcar.crosshair.standing.moving_offset = 0.8
	self.amcar.crosshair.standing.kick_offset = 0.6
	self.amcar.crosshair.crouching.offset = 0.08
	self.amcar.crosshair.crouching.moving_offset = 0.7
	self.amcar.crosshair.crouching.kick_offset = 0.4
	self.amcar.crosshair.steelsight.hidden = true
	self.amcar.crosshair.steelsight.offset = 0
	self.amcar.crosshair.steelsight.moving_offset = 0
	self.amcar.crosshair.steelsight.kick_offset = 0.1
	self.amcar.shake = {}
	self.amcar.shake.fire_multiplier = 1
	self.amcar.shake.fire_steelsight_multiplier = -1
	self.amcar.autohit = autohit_rifle_default
	self.amcar.aim_assist = aim_assist_rifle_default
	self.amcar.weapon_hold = "m4"
	self.amcar.animations = {}
	self.amcar.animations.reload = "reload"
	self.amcar.animations.reload_not_empty = "reload_not_empty"
	self.amcar.animations.equip_id = "equip_m4"
	self.amcar.animations.recoil_steelsight = false
	self.amcar.statistics = true
	self.amcar.stats = {
		damage = 7,
		spread = 6,
		recoil = 8,
		spread_moving = 6,
		zoom = 3,
		concealment = 24,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.m16 = {}
	self.m16.category = "assault_rifle"
	self.m16.damage_melee = damage_melee_default
	self.m16.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.m16.sounds = {}
	self.m16.sounds.fire = "m16_fire"
	self.m16.sounds.stop_fire = "m16_stop"
	self.m16.sounds.dryfire = "m4_dryfire"
	self.m16.sounds.enter_steelsight = "m4_tighten"
	self.m16.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.m16.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.m16.timers = {}
	self.m16.timers.reload_not_empty = 2.25
	self.m16.timers.reload_empty = 3
	self.m16.timers.unequip = 0.85
	self.m16.timers.equip = 0.75
	self.m16.name_id = "bm_w_m16"
	self.m16.desc_id = "bm_w_m16_desc"
	self.m16.hud_icon = "m4"
	self.m16.description_id = "des_m4"
	self.m16.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.m16.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.m16.use_data = {}
	self.m16.use_data.selection_index = 2
	self.m16.DAMAGE = 1
	self.m16.CLIP_AMMO_MAX = 30
	self.m16.NR_CLIPS_MAX = math.round(total_damage_primary / 3 / self.m16.CLIP_AMMO_MAX)
	self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
	self.m16.AMMO_PICKUP = self:_pickup_chance(self.m16.AMMO_MAX, 2)
	self.m16.auto = {}
	self.m16.auto.fire_rate = 0.11
	self.m16.spread = {}
	self.m16.spread.standing = self.new_m4.spread.standing
	self.m16.spread.crouching = self.new_m4.spread.standing
	self.m16.spread.steelsight = self.new_m4.spread.steelsight
	self.m16.spread.moving_standing = self.new_m4.spread.standing
	self.m16.spread.moving_crouching = self.new_m4.spread.standing
	self.m16.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.m16.kick = {}
	self.m16.kick.standing = self.new_m4.kick.standing
	self.m16.kick.crouching = self.m16.kick.standing
	self.m16.kick.steelsight = self.m16.kick.standing
	self.m16.crosshair = {}
	self.m16.crosshair.standing = {}
	self.m16.crosshair.crouching = {}
	self.m16.crosshair.steelsight = {}
	self.m16.crosshair.standing.offset = 0.16
	self.m16.crosshair.standing.moving_offset = 0.8
	self.m16.crosshair.standing.kick_offset = 0.6
	self.m16.crosshair.crouching.offset = 0.08
	self.m16.crosshair.crouching.moving_offset = 0.7
	self.m16.crosshair.crouching.kick_offset = 0.4
	self.m16.crosshair.steelsight.hidden = true
	self.m16.crosshair.steelsight.offset = 0
	self.m16.crosshair.steelsight.moving_offset = 0
	self.m16.crosshair.steelsight.kick_offset = 0.1
	self.m16.shake = {}
	self.m16.shake.fire_multiplier = 1
	self.m16.shake.fire_steelsight_multiplier = -1
	self.m16.autohit = autohit_rifle_default
	self.m16.aim_assist = aim_assist_rifle_default
	self.m16.weapon_hold = "m4"
	self.m16.animations = {}
	self.m16.animations.reload = "reload"
	self.m16.animations.reload_not_empty = "reload_not_empty"
	self.m16.animations.equip_id = "equip_m4"
	self.m16.animations.recoil_steelsight = false
	self.m16.statistics = true
	self.m16.stats = {
		damage = 14,
		spread = 7,
		recoil = 11,
		spread_moving = 6,
		zoom = 4,
		concealment = 21,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.olympic = {}
	self.olympic.category = "smg"
	self.olympic.damage_melee = damage_melee_default
	self.olympic.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.olympic.sounds = {}
	self.olympic.sounds.fire = "m4_olympic_fire"
	self.olympic.sounds.stop_fire = "m4_olympic_stop"
	self.olympic.sounds.dryfire = "m4_dryfire"
	self.olympic.sounds.enter_steelsight = "m4_tighten"
	self.olympic.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.olympic.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.olympic.timers = {}
	self.olympic.timers.reload_not_empty = 2.535
	self.olympic.timers.reload_empty = 3.49
	self.olympic.timers.unequip = 0.6
	self.olympic.timers.equip = 0.5
	self.olympic.name_id = "bm_w_olympic"
	self.olympic.desc_id = "bm_w_olympic_desc"
	self.olympic.hud_icon = "m4"
	self.olympic.description_id = "des_m4"
	self.olympic.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.olympic.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.olympic.use_data = {}
	self.olympic.use_data.selection_index = 1
	self.olympic.DAMAGE = 1
	self.olympic.CLIP_AMMO_MAX = 25
	self.olympic.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.6 / self.olympic.CLIP_AMMO_MAX)
	self.olympic.AMMO_MAX = self.olympic.CLIP_AMMO_MAX * self.olympic.NR_CLIPS_MAX
	self.olympic.AMMO_PICKUP = self:_pickup_chance(self.olympic.AMMO_MAX, 1)
	self.olympic.auto = {}
	self.olympic.auto.fire_rate = 0.0925
	self.olympic.spread = {}
	self.olympic.spread.standing = self.new_m4.spread.standing * 0.8
	self.olympic.spread.crouching = self.new_m4.spread.standing * 0.8
	self.olympic.spread.steelsight = self.new_m4.spread.steelsight
	self.olympic.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.olympic.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.olympic.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.olympic.kick = {}
	self.olympic.kick.standing = self.new_m4.kick.standing
	self.olympic.kick.crouching = self.olympic.kick.standing
	self.olympic.kick.steelsight = self.olympic.kick.standing
	self.olympic.crosshair = {}
	self.olympic.crosshair.standing = {}
	self.olympic.crosshair.crouching = {}
	self.olympic.crosshair.steelsight = {}
	self.olympic.crosshair.standing.offset = 0.16
	self.olympic.crosshair.standing.moving_offset = 0.8
	self.olympic.crosshair.standing.kick_offset = 0.6
	self.olympic.crosshair.crouching.offset = 0.08
	self.olympic.crosshair.crouching.moving_offset = 0.7
	self.olympic.crosshair.crouching.kick_offset = 0.4
	self.olympic.crosshair.steelsight.hidden = true
	self.olympic.crosshair.steelsight.offset = 0
	self.olympic.crosshair.steelsight.moving_offset = 0
	self.olympic.crosshair.steelsight.kick_offset = 0.1
	self.olympic.shake = {}
	self.olympic.shake.fire_multiplier = 1
	self.olympic.shake.fire_steelsight_multiplier = -1
	self.olympic.autohit = autohit_rifle_default
	self.olympic.aim_assist = aim_assist_rifle_default
	self.olympic.weapon_hold = "m4"
	self.olympic.animations = {}
	self.olympic.animations.reload = "reload"
	self.olympic.animations.reload_not_empty = "reload_not_empty"
	self.olympic.animations.equip_id = "equip_mp5"
	self.olympic.animations.recoil_steelsight = false
	self.olympic.statistics = true
	self.olympic.stats = {
		damage = 8,
		spread = 8,
		recoil = 10,
		spread_moving = 8,
		zoom = 3,
		concealment = 27,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.ak74 = {}
	self.ak74.category = "assault_rifle"
	self.ak74.damage_melee = damage_melee_default
	self.ak74.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.ak74.sounds = {}
	self.ak74.sounds.fire = "ak74_fire"
	self.ak74.sounds.stop_fire = "ak74_stop"
	self.ak74.sounds.dryfire = "ak47_dryfire"
	self.ak74.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.ak74.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.ak74.timers = {}
	self.ak74.timers.reload_not_empty = 2.3
	self.ak74.timers.reload_empty = 3.4
	self.ak74.timers.unequip = 0.7
	self.ak74.timers.equip = 0.5
	self.ak74.name_id = "bm_w_ak74"
	self.ak74.desc_id = "bm_w_ak74_desc"
	self.ak74.hud_icon = "ak"
	self.ak74.description_id = "des_ak47"
	self.ak74.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.ak74.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.ak74.use_data = {}
	self.ak74.use_data.selection_index = 2
	self.ak74.DAMAGE = 1
	self.ak74.CLIP_AMMO_MAX = 30
	self.ak74.NR_CLIPS_MAX = math.round(total_damage_primary / 2.5 / self.ak74.CLIP_AMMO_MAX)
	self.ak74.AMMO_MAX = self.ak74.CLIP_AMMO_MAX * self.ak74.NR_CLIPS_MAX
	self.ak74.AMMO_PICKUP = self:_pickup_chance(self.ak74.AMMO_MAX, 2)
	self.ak74.auto = {}
	self.ak74.auto.fire_rate = 0.125
	self.ak74.spread = {}
	self.ak74.spread.standing = self.new_m4.spread.standing
	self.ak74.spread.crouching = self.new_m4.spread.standing
	self.ak74.spread.steelsight = self.new_m4.spread.steelsight
	self.ak74.spread.moving_standing = self.new_m4.spread.standing
	self.ak74.spread.moving_crouching = self.new_m4.spread.standing
	self.ak74.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.ak74.kick = {}
	self.ak74.kick.standing = self.new_m4.kick.standing
	self.ak74.kick.crouching = self.ak74.kick.standing
	self.ak74.kick.steelsight = self.ak74.kick.standing
	self.ak74.crosshair = {}
	self.ak74.crosshair.standing = {}
	self.ak74.crosshair.crouching = {}
	self.ak74.crosshair.steelsight = {}
	self.ak74.crosshair.standing.offset = 0.16
	self.ak74.crosshair.standing.moving_offset = 0.8
	self.ak74.crosshair.standing.kick_offset = 0.6
	self.ak74.crosshair.crouching.offset = 0.08
	self.ak74.crosshair.crouching.moving_offset = 0.7
	self.ak74.crosshair.crouching.kick_offset = 0.4
	self.ak74.crosshair.steelsight.hidden = true
	self.ak74.crosshair.steelsight.offset = 0
	self.ak74.crosshair.steelsight.moving_offset = 0
	self.ak74.crosshair.steelsight.kick_offset = 0.1
	self.ak74.shake = {}
	self.ak74.shake.fire_multiplier = 1
	self.ak74.shake.fire_steelsight_multiplier = -1
	self.ak74.autohit = autohit_rifle_default
	self.ak74.aim_assist = aim_assist_rifle_default
	self.ak74.weapon_hold = "ak47"
	self.ak74.animations = {}
	self.ak74.animations.equip_id = "equip_ak47"
	self.ak74.animations.recoil_steelsight = false
	self.ak74.challenges = {}
	self.ak74.challenges.group = "rifle"
	self.ak74.challenges.weapon = "ak47"
	self.ak74.statistics = true
	self.ak74.stats = {
		damage = 12,
		spread = 6,
		recoil = 6,
		spread_moving = 6,
		zoom = 3,
		concealment = 18,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.akm = {}
	self.akm.category = "assault_rifle"
	self.akm.damage_melee = damage_melee_default
	self.akm.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.akm.sounds = {}
	self.akm.sounds.fire = "akm_fire"
	self.akm.sounds.stop_fire = "akm_stop"
	self.akm.sounds.dryfire = "ak47_dryfire"
	self.akm.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.akm.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.akm.timers = {}
	self.akm.timers.reload_not_empty = 2.3
	self.akm.timers.reload_empty = 3.4
	self.akm.timers.unequip = 0.8
	self.akm.timers.equip = 0.5
	self.akm.name_id = "bm_w_akm"
	self.akm.desc_id = "bm_w_akm_desc"
	self.akm.hud_icon = "ak"
	self.akm.description_id = "des_ak47"
	self.akm.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.akm.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.akm.use_data = {}
	self.akm.use_data.selection_index = 2
	self.akm.DAMAGE = 1.25
	self.akm.CLIP_AMMO_MAX = 30
	self.akm.NR_CLIPS_MAX = math.round(total_damage_primary / 4 / self.akm.CLIP_AMMO_MAX)
	self.akm.AMMO_MAX = self.akm.CLIP_AMMO_MAX * self.akm.NR_CLIPS_MAX
	self.akm.AMMO_PICKUP = self:_pickup_chance(self.akm.AMMO_MAX, 2)
	self.akm.auto = {}
	self.akm.auto.fire_rate = 0.14
	self.akm.spread = {}
	self.akm.spread.standing = self.new_m4.spread.standing
	self.akm.spread.crouching = self.new_m4.spread.standing
	self.akm.spread.steelsight = self.new_m4.spread.steelsight
	self.akm.spread.moving_standing = self.new_m4.spread.standing
	self.akm.spread.moving_crouching = self.new_m4.spread.standing
	self.akm.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.akm.kick = {}
	self.akm.kick.standing = self.new_m4.kick.standing
	self.akm.kick.crouching = self.akm.kick.standing
	self.akm.kick.steelsight = self.akm.kick.standing
	self.akm.crosshair = {}
	self.akm.crosshair.standing = {}
	self.akm.crosshair.crouching = {}
	self.akm.crosshair.steelsight = {}
	self.akm.crosshair.standing.offset = 0.16
	self.akm.crosshair.standing.moving_offset = 0.8
	self.akm.crosshair.standing.kick_offset = 0.6
	self.akm.crosshair.crouching.offset = 0.08
	self.akm.crosshair.crouching.moving_offset = 0.7
	self.akm.crosshair.crouching.kick_offset = 0.4
	self.akm.crosshair.steelsight.hidden = true
	self.akm.crosshair.steelsight.offset = 0
	self.akm.crosshair.steelsight.moving_offset = 0
	self.akm.crosshair.steelsight.kick_offset = 0.1
	self.akm.shake = {}
	self.akm.shake.fire_multiplier = 1
	self.akm.shake.fire_steelsight_multiplier = -1
	self.akm.autohit = autohit_rifle_default
	self.akm.aim_assist = aim_assist_rifle_default
	self.akm.weapon_hold = "ak47"
	self.akm.animations = {}
	self.akm.animations.equip_id = "equip_ak47"
	self.akm.animations.recoil_steelsight = false
	self.akm.statistics = true
	self.akm.challenges = {}
	self.akm.challenges.group = "rifle"
	self.akm.challenges.weapon = "ak47"
	self.akm.stats = {
		damage = 16,
		spread = 6,
		recoil = 5,
		spread_moving = 6,
		zoom = 3,
		concealment = 12,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.akmsu = {}
	self.akmsu.category = "smg"
	self.akmsu.damage_melee = damage_melee_default
	self.akmsu.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.akmsu.sounds = {}
	self.akmsu.sounds.fire = "akmsu_fire"
	self.akmsu.sounds.stop_fire = "akmsu_stop"
	self.akmsu.sounds.dryfire = "ak47_dryfire"
	self.akmsu.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.akmsu.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.akmsu.timers = {}
	self.akmsu.timers.reload_not_empty = 2.3
	self.akmsu.timers.reload_empty = 3.4
	self.akmsu.timers.unequip = 0.65
	self.akmsu.timers.equip = 0.5
	self.akmsu.name_id = "bm_w_akmsu"
	self.akmsu.desc_id = "bm_w_akmsu_desc"
	self.akmsu.hud_icon = "ak"
	self.akmsu.description_id = "des_ak47"
	self.akmsu.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.akmsu.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.akmsu.use_data = {}
	self.akmsu.use_data.selection_index = 1
	self.akmsu.DAMAGE = 1
	self.akmsu.CLIP_AMMO_MAX = 30
	self.akmsu.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.75 / self.akmsu.CLIP_AMMO_MAX)
	self.akmsu.AMMO_MAX = self.akmsu.CLIP_AMMO_MAX * self.akmsu.NR_CLIPS_MAX
	self.akmsu.AMMO_PICKUP = self:_pickup_chance(self.akmsu.AMMO_MAX, 1)
	self.akmsu.auto = {}
	self.akmsu.auto.fire_rate = 0.11
	self.akmsu.spread = {}
	self.akmsu.spread.standing = self.new_m4.spread.standing
	self.akmsu.spread.crouching = self.new_m4.spread.standing
	self.akmsu.spread.steelsight = self.new_m4.spread.steelsight
	self.akmsu.spread.moving_standing = self.new_m4.spread.standing
	self.akmsu.spread.moving_crouching = self.new_m4.spread.standing
	self.akmsu.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.akmsu.kick = {}
	self.akmsu.kick.standing = self.new_m4.kick.standing
	self.akmsu.kick.crouching = self.akmsu.kick.standing
	self.akmsu.kick.steelsight = self.akmsu.kick.standing
	self.akmsu.crosshair = {}
	self.akmsu.crosshair.standing = {}
	self.akmsu.crosshair.crouching = {}
	self.akmsu.crosshair.steelsight = {}
	self.akmsu.crosshair.standing.offset = 0.16
	self.akmsu.crosshair.standing.moving_offset = 0.8
	self.akmsu.crosshair.standing.kick_offset = 0.6
	self.akmsu.crosshair.crouching.offset = 0.08
	self.akmsu.crosshair.crouching.moving_offset = 0.7
	self.akmsu.crosshair.crouching.kick_offset = 0.4
	self.akmsu.crosshair.steelsight.hidden = true
	self.akmsu.crosshair.steelsight.offset = 0
	self.akmsu.crosshair.steelsight.moving_offset = 0
	self.akmsu.crosshair.steelsight.kick_offset = 0.1
	self.akmsu.shake = {}
	self.akmsu.shake.fire_multiplier = 1
	self.akmsu.shake.fire_steelsight_multiplier = -1
	self.akmsu.autohit = autohit_rifle_default
	self.akmsu.aim_assist = aim_assist_rifle_default
	self.akmsu.weapon_hold = "ak47"
	self.akmsu.animations = {}
	self.akmsu.animations.equip_id = "equip_ak47"
	self.akmsu.animations.recoil_steelsight = false
	self.akmsu.statistics = true
	self.akmsu.challenges = {}
	self.akmsu.challenges.group = "rifle"
	self.akmsu.challenges.weapon = "ak47"
	self.akmsu.stats = {
		damage = 11,
		spread = 7,
		recoil = 6,
		spread_moving = 9,
		zoom = 3,
		concealment = 24,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.saiga = {}
	self.saiga.category = "shotgun"
	self.saiga.damage_melee = damage_melee_default
	self.saiga.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.saiga.sounds = {}
	self.saiga.sounds.fire = "saiga_play"
	self.saiga.sounds.dryfire = "remington_dryfire"
	self.saiga.sounds.stop_fire = "saiga_stop"
	self.saiga.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.saiga.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.saiga.timers = {}
	self.saiga.timers.reload_not_empty = 2.3
	self.saiga.timers.reload_empty = 3.4
	self.saiga.timers.unequip = 0.8
	self.saiga.timers.equip = 0.8
	self.saiga.name_id = "bm_w_saiga"
	self.saiga.desc_id = "bm_w_saiga_desc"
	self.saiga.hud_icon = "r870_shotgun"
	self.saiga.description_id = "des_saiga"
	self.saiga.hud_ammo = "guis/textures/ammo_shell"
	self.saiga.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.saiga.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug"
	self.saiga.use_data = {}
	self.saiga.use_data.selection_index = 2
	self.saiga.use_data.align_place = "right_hand"
	self.saiga.DAMAGE = 6
	self.saiga.damage_near = 600
	self.saiga.damage_far = 1800
	self.saiga.rays = 5
	self.saiga.CLIP_AMMO_MAX = 7
	self.saiga.NR_CLIPS_MAX = math.round(total_damage_primary / 4.5 / self.saiga.CLIP_AMMO_MAX)
	self.saiga.AMMO_MAX = self.saiga.CLIP_AMMO_MAX * self.saiga.NR_CLIPS_MAX
	self.saiga.AMMO_PICKUP = self:_pickup_chance(self.saiga.AMMO_MAX, 2)
	self.saiga.auto = {}
	self.saiga.auto.fire_rate = 0.18
	self.saiga.spread = {}
	self.saiga.spread.standing = self.r870.spread.standing
	self.saiga.spread.crouching = self.r870.spread.crouching
	self.saiga.spread.steelsight = self.r870.spread.steelsight
	self.saiga.spread.moving_standing = self.r870.spread.moving_standing
	self.saiga.spread.moving_crouching = self.r870.spread.moving_crouching
	self.saiga.spread.moving_steelsight = self.r870.spread.moving_steelsight
	self.saiga.kick = {}
	self.saiga.kick.standing = self.r870.kick.standing
	self.saiga.kick.crouching = self.saiga.kick.standing
	self.saiga.kick.steelsight = self.r870.kick.steelsight
	self.saiga.crosshair = {}
	self.saiga.crosshair.standing = {}
	self.saiga.crosshair.crouching = {}
	self.saiga.crosshair.steelsight = {}
	self.saiga.crosshair.standing.offset = 0.7
	self.saiga.crosshair.standing.moving_offset = 0.7
	self.saiga.crosshair.standing.kick_offset = 0.8
	self.saiga.crosshair.crouching.offset = 0.65
	self.saiga.crosshair.crouching.moving_offset = 0.65
	self.saiga.crosshair.crouching.kick_offset = 0.75
	self.saiga.crosshair.steelsight.hidden = true
	self.saiga.crosshair.steelsight.offset = 0
	self.saiga.crosshair.steelsight.moving_offset = 0
	self.saiga.crosshair.steelsight.kick_offset = 0
	self.saiga.shake = {}
	self.saiga.shake.fire_multiplier = 2
	self.saiga.shake.fire_steelsight_multiplier = 1.25
	self.saiga.autohit = autohit_shotgun_default
	self.saiga.aim_assist = aim_assist_shotgun_default
	self.saiga.weapon_hold = "ak47"
	self.saiga.animations = {}
	self.saiga.animations.equip_id = "equip_r870_shotgun"
	self.saiga.animations.recoil_steelsight = true
	self.saiga.statistics = true
	self.saiga.stats = {
		damage = 18,
		spread = 6,
		recoil = 9,
		spread_moving = 7,
		zoom = 3,
		concealment = 15,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.ak5 = {}
	self.ak5.category = "assault_rifle"
	self.ak5.damage_melee = damage_melee_default
	self.ak5.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.ak5.sounds = {}
	self.ak5.sounds.fire = "ak5_fire"
	self.ak5.sounds.stop_fire = "ak5_stop"
	self.ak5.sounds.dryfire = "m4_dryfire"
	self.ak5.sounds.enter_steelsight = "m4_tighten"
	self.ak5.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.ak5.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.ak5.timers = {}
	self.ak5.timers.reload_not_empty = 2.25
	self.ak5.timers.reload_empty = 3.47
	self.ak5.timers.unequip = 0.7
	self.ak5.timers.equip = 0.5
	self.ak5.name_id = "bm_w_ak5"
	self.ak5.desc_id = "bm_w_ak5_desc"
	self.ak5.hud_icon = "m4"
	self.ak5.description_id = "des_m4"
	self.ak5.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.ak5.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.ak5.use_data = {}
	self.ak5.use_data.selection_index = 2
	self.ak5.DAMAGE = 1
	self.ak5.CLIP_AMMO_MAX = 30
	self.ak5.NR_CLIPS_MAX = math.round(total_damage_primary / 2 / self.ak5.CLIP_AMMO_MAX)
	self.ak5.AMMO_MAX = self.ak5.CLIP_AMMO_MAX * self.ak5.NR_CLIPS_MAX
	self.ak5.AMMO_PICKUP = self:_pickup_chance(self.ak5.AMMO_MAX, 2)
	self.ak5.auto = {}
	self.ak5.auto.fire_rate = 0.13
	self.ak5.spread = {}
	self.ak5.spread.standing = self.new_m4.spread.standing
	self.ak5.spread.crouching = self.new_m4.spread.standing
	self.ak5.spread.steelsight = self.new_m4.spread.steelsight
	self.ak5.spread.moving_standing = self.new_m4.spread.standing
	self.ak5.spread.moving_crouching = self.new_m4.spread.standing
	self.ak5.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.ak5.kick = {}
	self.ak5.kick.standing = self.new_m4.kick.standing
	self.ak5.kick.crouching = self.ak5.kick.standing
	self.ak5.kick.steelsight = self.ak5.kick.standing
	self.ak5.crosshair = {}
	self.ak5.crosshair.standing = {}
	self.ak5.crosshair.crouching = {}
	self.ak5.crosshair.steelsight = {}
	self.ak5.crosshair.standing.offset = 0.16
	self.ak5.crosshair.standing.moving_offset = 0.8
	self.ak5.crosshair.standing.kick_offset = 0.6
	self.ak5.crosshair.crouching.offset = 0.08
	self.ak5.crosshair.crouching.moving_offset = 0.7
	self.ak5.crosshair.crouching.kick_offset = 0.4
	self.ak5.crosshair.steelsight.hidden = true
	self.ak5.crosshair.steelsight.offset = 0
	self.ak5.crosshair.steelsight.moving_offset = 0
	self.ak5.crosshair.steelsight.kick_offset = 0.1
	self.ak5.shake = {}
	self.ak5.shake.fire_multiplier = 1
	self.ak5.shake.fire_steelsight_multiplier = 1
	self.ak5.autohit = autohit_rifle_default
	self.ak5.aim_assist = aim_assist_rifle_default
	self.ak5.weapon_hold = "m4"
	self.ak5.animations = {}
	self.ak5.animations.reload_not_empty = "reload_not_empty"
	self.ak5.animations.reload = "reload"
	self.ak5.animations.equip_id = "equip_m4"
	self.ak5.animations.recoil_steelsight = false
	self.ak5.statistics = true
	self.ak5.stats = {
		damage = 9,
		spread = 9,
		recoil = 13,
		spread_moving = 6,
		zoom = 3,
		concealment = 18,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.aug = {}
	self.aug.category = "assault_rifle"
	self.aug.damage_melee = damage_melee_default
	self.aug.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.aug.sounds = {}
	self.aug.sounds.fire = "aug_fire"
	self.aug.sounds.stop_fire = "aug_stop"
	self.aug.sounds.dryfire = "mp5_dryfire"
	self.aug.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.aug.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.aug.timers = {}
	self.aug.timers.reload_not_empty = 2.5
	self.aug.timers.reload_empty = 3.3
	self.aug.timers.unequip = 0.72
	self.aug.timers.equip = 0.6
	self.aug.name_id = "bm_w_aug"
	self.aug.desc_id = "bm_w_aug_desc"
	self.aug.hud_icon = "mp5"
	self.aug.description_id = "des_aug"
	self.aug.hud_ammo = "guis/textures/ammo_9mm"
	self.aug.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.aug.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.aug.use_data = {}
	self.aug.use_data.selection_index = 2
	self.aug.DAMAGE = 1
	self.aug.CLIP_AMMO_MAX = 30
	self.aug.NR_CLIPS_MAX = math.round(total_damage_primary / 2.25 / self.aug.CLIP_AMMO_MAX)
	self.aug.AMMO_MAX = self.aug.CLIP_AMMO_MAX * self.aug.NR_CLIPS_MAX
	self.aug.AMMO_PICKUP = self:_pickup_chance(self.aug.AMMO_MAX, 2)
	self.aug.auto = {}
	self.aug.auto.fire_rate = 0.125
	self.aug.spread = {}
	self.aug.spread.standing = self.new_m4.spread.standing * 2.5
	self.aug.spread.crouching = self.new_m4.spread.standing * 2.5
	self.aug.spread.steelsight = self.new_m4.spread.steelsight
	self.aug.spread.moving_standing = self.new_m4.spread.standing * 3.5
	self.aug.spread.moving_crouching = self.new_m4.spread.standing * 3.5
	self.aug.spread.moving_steelsight = self.new_m4.spread.moving_steelsight * 1.5
	self.aug.kick = {}
	self.aug.kick.standing = self.new_m4.kick.standing
	self.aug.kick.crouching = self.aug.kick.standing
	self.aug.kick.steelsight = self.aug.kick.standing
	self.aug.crosshair = {}
	self.aug.crosshair.standing = {}
	self.aug.crosshair.crouching = {}
	self.aug.crosshair.steelsight = {}
	self.aug.crosshair.standing.offset = 0.5
	self.aug.crosshair.standing.moving_offset = 0.6
	self.aug.crosshair.standing.kick_offset = 0.7
	self.aug.crosshair.crouching.offset = 0.4
	self.aug.crosshair.crouching.moving_offset = 0.5
	self.aug.crosshair.crouching.kick_offset = 0.6
	self.aug.crosshair.steelsight.hidden = true
	self.aug.crosshair.steelsight.offset = 0
	self.aug.crosshair.steelsight.moving_offset = 0
	self.aug.crosshair.steelsight.kick_offset = 0
	self.aug.shake = {}
	self.aug.shake.fire_multiplier = 1
	self.aug.shake.fire_steelsight_multiplier = 1
	self.aug.autohit = autohit_pistol_default
	self.aug.aim_assist = aim_assist_pistol_default
	self.aug.animations = {}
	self.aug.animations.equip_id = "equip_mp5_rifle"
	self.aug.animations.recoil_steelsight = false
	self.aug.statistics = true
	self.aug.stats = {
		damage = 12,
		spread = 8,
		recoil = 5,
		spread_moving = 6,
		zoom = 3,
		concealment = 21,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.g36 = {}
	self.g36.category = "assault_rifle"
	self.g36.damage_melee = damage_melee_default
	self.g36.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.g36.sounds = {}
	self.g36.sounds.fire = "g36_fire"
	self.g36.sounds.stop_fire = "g36_stop"
	self.g36.sounds.dryfire = "m4_dryfire"
	self.g36.sounds.enter_steelsight = "m4_tighten"
	self.g36.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.g36.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.g36.timers = {}
	self.g36.timers.reload_not_empty = 2.5
	self.g36.timers.reload_empty = 3.45
	self.g36.timers.unequip = 0.75
	self.g36.timers.equip = 0.5
	self.g36.name_id = "bm_w_g36"
	self.g36.desc_id = "bm_w_g36_desc"
	self.g36.hud_icon = "m4"
	self.g36.description_id = "des_m4"
	self.g36.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.g36.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.g36.use_data = {}
	self.g36.use_data.selection_index = 2
	self.g36.DAMAGE = 1
	self.g36.CLIP_AMMO_MAX = 30
	self.g36.NR_CLIPS_MAX = math.round(total_damage_primary / 1.75 / self.g36.CLIP_AMMO_MAX)
	self.g36.AMMO_MAX = self.g36.CLIP_AMMO_MAX * self.g36.NR_CLIPS_MAX
	self.g36.AMMO_PICKUP = self:_pickup_chance(self.g36.AMMO_MAX, 2)
	self.g36.auto = {}
	self.g36.auto.fire_rate = 0.1175
	self.g36.spread = {}
	self.g36.spread.standing = self.new_m4.spread.standing * 0.8
	self.g36.spread.crouching = self.new_m4.spread.standing * 0.8
	self.g36.spread.steelsight = self.new_m4.spread.steelsight
	self.g36.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.g36.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.g36.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.g36.kick = {}
	self.g36.kick.standing = self.new_m4.kick.standing
	self.g36.kick.crouching = self.g36.kick.standing
	self.g36.kick.steelsight = self.g36.kick.standing
	self.g36.crosshair = {}
	self.g36.crosshair.standing = {}
	self.g36.crosshair.crouching = {}
	self.g36.crosshair.steelsight = {}
	self.g36.crosshair.standing.offset = 0.16
	self.g36.crosshair.standing.moving_offset = 0.8
	self.g36.crosshair.standing.kick_offset = 0.6
	self.g36.crosshair.crouching.offset = 0.08
	self.g36.crosshair.crouching.moving_offset = 0.7
	self.g36.crosshair.crouching.kick_offset = 0.4
	self.g36.crosshair.steelsight.hidden = true
	self.g36.crosshair.steelsight.offset = 0
	self.g36.crosshair.steelsight.moving_offset = 0
	self.g36.crosshair.steelsight.kick_offset = 0.1
	self.g36.shake = {}
	self.g36.shake.fire_multiplier = 1
	self.g36.shake.fire_steelsight_multiplier = -1
	self.g36.autohit = autohit_rifle_default
	self.g36.aim_assist = aim_assist_rifle_default
	self.g36.animations = {}
	self.g36.animations.equip_id = "equip_m4"
	self.g36.animations.recoil_steelsight = false
	self.g36.statistics = true
	self.g36.stats = {
		damage = 11,
		spread = 7,
		recoil = 8,
		spread_moving = 7,
		zoom = 3,
		concealment = 21,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.p90 = {}
	self.p90.category = "smg"
	self.p90.damage_melee = damage_melee_default
	self.p90.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.p90.sounds = {}
	self.p90.sounds.fire = "p90_fire"
	self.p90.sounds.stop_fire = "p90_stop"
	self.p90.sounds.dryfire = "m4_dryfire"
	self.p90.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.p90.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.p90.timers = {}
	self.p90.timers.reload_not_empty = 2.9
	self.p90.timers.reload_empty = 3.9
	self.p90.timers.unequip = 0.7
	self.p90.timers.equip = 0.5
	self.p90.name_id = "bm_w_p90"
	self.p90.desc_id = "bm_w_p90_desc"
	self.p90.hud_icon = "mac11"
	self.p90.description_id = "des_p90"
	self.p90.hud_ammo = "guis/textures/ammo_small_9mm"
	self.p90.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.p90.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.p90.use_data = {}
	self.p90.use_data.selection_index = 1
	self.p90.DAMAGE = 1
	self.p90.CLIP_AMMO_MAX = 50
	self.p90.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.45 / self.p90.CLIP_AMMO_MAX)
	self.p90.AMMO_MAX = self.p90.CLIP_AMMO_MAX * self.p90.NR_CLIPS_MAX
	self.p90.AMMO_PICKUP = self:_pickup_chance(self.p90.AMMO_MAX, 1)
	self.p90.auto = {}
	self.p90.auto.fire_rate = 0.095
	self.p90.spread = {}
	self.p90.spread.standing = self.new_m4.spread.standing * 1.35
	self.p90.spread.crouching = self.new_m4.spread.standing * 1.35
	self.p90.spread.steelsight = self.new_m4.spread.steelsight
	self.p90.spread.moving_standing = self.new_m4.spread.standing * 1.35
	self.p90.spread.moving_crouching = self.new_m4.spread.standing * 1.35
	self.p90.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.p90.kick = {}
	self.p90.kick.standing = self.new_m4.kick.standing
	self.p90.kick.crouching = self.p90.kick.standing
	self.p90.kick.steelsight = self.p90.kick.standing
	self.p90.crosshair = {}
	self.p90.crosshair.standing = {}
	self.p90.crosshair.crouching = {}
	self.p90.crosshair.steelsight = {}
	self.p90.crosshair.standing.offset = 0.4
	self.p90.crosshair.standing.moving_offset = 0.7
	self.p90.crosshair.standing.kick_offset = 0.6
	self.p90.crosshair.crouching.offset = 0.3
	self.p90.crosshair.crouching.moving_offset = 0.6
	self.p90.crosshair.crouching.kick_offset = 0.4
	self.p90.crosshair.steelsight.hidden = true
	self.p90.crosshair.steelsight.offset = 0
	self.p90.crosshair.steelsight.moving_offset = 0
	self.p90.crosshair.steelsight.kick_offset = 0.4
	self.p90.shake = {}
	self.p90.shake.fire_multiplier = 1
	self.p90.shake.fire_steelsight_multiplier = 1
	self.p90.autohit = autohit_pistol_default
	self.p90.aim_assist = aim_assist_pistol_default
	self.p90.animations = {}
	self.p90.animations.equip_id = "equip_mac11_rifle"
	self.p90.animations.recoil_steelsight = false
	self.p90.statistics = true
	self.p90.stats = {
		damage = 9,
		spread = 8,
		recoil = 10,
		spread_moving = 8,
		zoom = 3,
		concealment = 27,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.new_m14 = {}
	self.new_m14.category = "assault_rifle"
	self.new_m14.damage_melee = damage_melee_default
	self.new_m14.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.new_m14.sounds = {}
	self.new_m14.sounds.fire = "m14_fire"
	self.new_m14.sounds.dryfire = "m14_dryfire"
	self.new_m14.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.new_m14.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.new_m14.timers = {}
	self.new_m14.timers.reload_not_empty = 1.97
	self.new_m14.timers.reload_empty = 3.1
	self.new_m14.timers.unequip = 0.8
	self.new_m14.timers.equip = 0.65
	self.new_m14.name_id = "bm_w_m14"
	self.new_m14.desc_id = "bm_w_m14_desc"
	self.new_m14.hud_icon = "m14"
	self.new_m14.description_id = "des_m14"
	self.new_m14.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.new_m14.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	self.new_m14.use_data = {}
	self.new_m14.use_data.selection_index = 2
	self.new_m14.DAMAGE = 2
	self.new_m14.CLIP_AMMO_MAX = 10
	self.new_m14.NR_CLIPS_MAX = math.round(total_damage_primary / 8 / self.new_m14.CLIP_AMMO_MAX)
	self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
	self.new_m14.AMMO_PICKUP = self:_pickup_chance(self.new_m14.AMMO_MAX, 2)
	self.new_m14.single = {}
	self.new_m14.single.fire_rate = 0.14
	self.new_m14.spread = {}
	self.new_m14.spread.standing = self.new_m4.spread.standing * 2
	self.new_m14.spread.crouching = self.new_m4.spread.standing * 2
	self.new_m14.spread.steelsight = self.new_m4.spread.steelsight
	self.new_m14.spread.moving_standing = self.new_m4.spread.standing * 2.5
	self.new_m14.spread.moving_crouching = self.new_m4.spread.standing * 2.5
	self.new_m14.spread.moving_steelsight = self.new_m4.spread.moving_steelsight * 1.5
	self.new_m14.kick = {}
	self.new_m14.kick.standing = self.new_m4.kick.standing
	self.new_m14.kick.crouching = self.new_m14.kick.standing
	self.new_m14.kick.steelsight = self.new_m14.kick.standing
	self.new_m14.crosshair = {}
	self.new_m14.crosshair.standing = {}
	self.new_m14.crosshair.crouching = {}
	self.new_m14.crosshair.steelsight = {}
	self.new_m14.crosshair.standing.offset = 0.16
	self.new_m14.crosshair.standing.moving_offset = 0.8
	self.new_m14.crosshair.standing.kick_offset = 0.6
	self.new_m14.crosshair.crouching.offset = 0.08
	self.new_m14.crosshair.crouching.moving_offset = 0.7
	self.new_m14.crosshair.crouching.kick_offset = 0.4
	self.new_m14.crosshair.steelsight.hidden = true
	self.new_m14.crosshair.steelsight.offset = 0
	self.new_m14.crosshair.steelsight.moving_offset = 0
	self.new_m14.crosshair.steelsight.kick_offset = 0.1
	self.new_m14.shake = {}
	self.new_m14.shake.fire_multiplier = 1
	self.new_m14.shake.fire_steelsight_multiplier = 1
	self.new_m14.autohit = autohit_rifle_default
	self.new_m14.aim_assist = aim_assist_rifle_default
	self.new_m14.animations = {}
	self.new_m14.animations.fire = "recoil"
	self.new_m14.animations.equip_id = "equip_m14_rifle"
	self.new_m14.animations.recoil_steelsight = true
	self.new_m14.statistics = true
	self.new_m14.stats = {
		damage = 26,
		spread = 9,
		recoil = 2,
		spread_moving = 5,
		zoom = 3,
		concealment = 9,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.deagle = {}
	self.deagle.category = "pistol"
	self.deagle.damage_melee = damage_melee_default
	self.deagle.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.deagle.sounds = {}
	self.deagle.sounds.fire = "deagle_fire"
	self.deagle.sounds.dryfire = "c45_dryfire"
	self.deagle.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.deagle.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.deagle.single = {}
	self.deagle.single.fire_rate = 0.15
	self.deagle.timers = {}
	self.deagle.timers.reload_not_empty = 1.85
	self.deagle.timers.reload_empty = 2.75
	self.deagle.timers.unequip = 0.6
	self.deagle.timers.equip = 0.6
	self.deagle.name_id = "bm_w_deagle"
	self.deagle.desc_id = "bm_w_deagle_desc"
	self.deagle.hud_icon = "c45"
	self.deagle.description_id = "des_deagle"
	self.deagle.hud_ammo = "guis/textures/ammo_9mm"
	self.deagle.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.deagle.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.deagle.use_data = {}
	self.deagle.use_data.selection_index = 1
	self.deagle.DAMAGE = 2
	self.deagle.CLIP_AMMO_MAX = 10
	self.deagle.NR_CLIPS_MAX = math.round(total_damage_secondary / 4.5 / self.deagle.CLIP_AMMO_MAX)
	self.deagle.AMMO_MAX = self.deagle.CLIP_AMMO_MAX * self.deagle.NR_CLIPS_MAX
	self.deagle.AMMO_PICKUP = self:_pickup_chance(self.deagle.AMMO_MAX, 1)
	self.deagle.spread = {}
	self.deagle.spread.standing = self.new_m4.spread.standing
	self.deagle.spread.crouching = self.new_m4.spread.standing
	self.deagle.spread.steelsight = self.new_m4.spread.steelsight
	self.deagle.spread.moving_standing = self.new_m4.spread.standing
	self.deagle.spread.moving_crouching = self.new_m4.spread.standing
	self.deagle.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.deagle.kick = {}
	self.deagle.kick.standing = self.glock_17.kick.standing
	self.deagle.kick.crouching = self.deagle.kick.standing
	self.deagle.kick.steelsight = self.deagle.kick.standing
	self.deagle.crosshair = {}
	self.deagle.crosshair.standing = {}
	self.deagle.crosshair.crouching = {}
	self.deagle.crosshair.steelsight = {}
	self.deagle.crosshair.standing.offset = 0.2
	self.deagle.crosshair.standing.moving_offset = 0.6
	self.deagle.crosshair.standing.kick_offset = 0.4
	self.deagle.crosshair.crouching.offset = 0.1
	self.deagle.crosshair.crouching.moving_offset = 0.6
	self.deagle.crosshair.crouching.kick_offset = 0.3
	self.deagle.crosshair.steelsight.hidden = true
	self.deagle.crosshair.steelsight.offset = 0
	self.deagle.crosshair.steelsight.moving_offset = 0
	self.deagle.crosshair.steelsight.kick_offset = 0.1
	self.deagle.shake = {}
	self.deagle.shake.fire_multiplier = -1
	self.deagle.shake.fire_steelsight_multiplier = -1
	self.deagle.autohit = autohit_pistol_default
	self.deagle.aim_assist = aim_assist_pistol_default
	self.deagle.animations = {}
	self.deagle.animations.equip_id = "equip_glock"
	self.deagle.animations.recoil_steelsight = true
	self.deagle.statistics = true
	self.deagle.stats = {
		damage = 18,
		spread = 6,
		recoil = 4,
		spread_moving = 6,
		zoom = 3,
		concealment = 27,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.new_mp5 = {}
	self.new_mp5.category = "smg"
	self.new_mp5.damage_melee = damage_melee_default
	self.new_mp5.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.new_mp5.sounds = {}
	self.new_mp5.sounds.fire = "mp5_fire"
	self.new_mp5.sounds.stop_fire = "mp5_stop"
	self.new_mp5.sounds.dryfire = "mp5_dryfire"
	self.new_mp5.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.new_mp5.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.new_mp5.timers = {}
	self.new_mp5.timers.reload_not_empty = 2.4
	self.new_mp5.timers.reload_empty = 3.3
	self.new_mp5.timers.unequip = 0.7
	self.new_mp5.timers.equip = 0.5
	self.new_mp5.name_id = "bm_w_mp5"
	self.new_mp5.desc_id = "bm_w_mp5_desc"
	self.new_mp5.hud_icon = "mp5"
	self.new_mp5.description_id = "des_mp5"
	self.new_mp5.hud_ammo = "guis/textures/ammo_9mm"
	self.new_mp5.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.new_mp5.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.new_mp5.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.new_mp5.use_data = {}
	self.new_mp5.use_data.selection_index = 1
	self.new_mp5.DAMAGE = 1
	self.new_mp5.CLIP_AMMO_MAX = 30
	self.new_mp5.NR_CLIPS_MAX = math.round(total_damage_secondary / 1 / self.new_mp5.CLIP_AMMO_MAX)
	self.new_mp5.AMMO_MAX = self.new_mp5.CLIP_AMMO_MAX * self.new_mp5.NR_CLIPS_MAX
	self.new_mp5.AMMO_PICKUP = self:_pickup_chance(self.new_mp5.AMMO_MAX, 1)
	self.new_mp5.auto = {}
	self.new_mp5.auto.fire_rate = 0.1075
	self.new_mp5.spread = {}
	self.new_mp5.spread.standing = self.new_m4.spread.standing
	self.new_mp5.spread.crouching = self.new_m4.spread.standing
	self.new_mp5.spread.steelsight = self.new_m4.spread.steelsight
	self.new_mp5.spread.moving_standing = self.new_m4.spread.standing
	self.new_mp5.spread.moving_crouching = self.new_m4.spread.standing
	self.new_mp5.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.new_mp5.kick = {}
	self.new_mp5.kick.standing = self.new_m4.kick.standing
	self.new_mp5.kick.crouching = self.new_mp5.kick.standing
	self.new_mp5.kick.steelsight = self.new_mp5.kick.standing
	self.new_mp5.crosshair = {}
	self.new_mp5.crosshair.standing = {}
	self.new_mp5.crosshair.crouching = {}
	self.new_mp5.crosshair.steelsight = {}
	self.new_mp5.crosshair.standing.offset = 0.5
	self.new_mp5.crosshair.standing.moving_offset = 0.6
	self.new_mp5.crosshair.standing.kick_offset = 0.7
	self.new_mp5.crosshair.crouching.offset = 0.4
	self.new_mp5.crosshair.crouching.moving_offset = 0.5
	self.new_mp5.crosshair.crouching.kick_offset = 0.6
	self.new_mp5.crosshair.steelsight.hidden = true
	self.new_mp5.crosshair.steelsight.offset = 0
	self.new_mp5.crosshair.steelsight.moving_offset = 0
	self.new_mp5.crosshair.steelsight.kick_offset = 0
	self.new_mp5.shake = {}
	self.new_mp5.shake.fire_multiplier = 1
	self.new_mp5.shake.fire_steelsight_multiplier = 0.5
	self.new_mp5.autohit = autohit_pistol_default
	self.new_mp5.aim_assist = aim_assist_pistol_default
	self.new_mp5.weapon_hold = "mp5"
	self.new_mp5.animations = {}
	self.new_mp5.animations.equip_id = "equip_mp5_rifle"
	self.new_mp5.animations.recoil_steelsight = false
	self.new_mp5.statistics = true
	self.new_mp5.stats = {
		damage = 8,
		spread = 7,
		recoil = 11,
		spread_moving = 8,
		zoom = 3,
		concealment = 24,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.colt_1911 = {}
	self.colt_1911.category = "pistol"
	self.colt_1911.damage_melee = damage_melee_default
	self.colt_1911.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.colt_1911.sounds = {}
	self.colt_1911.sounds.fire = "c45_fire"
	self.colt_1911.sounds.dryfire = "c45_dryfire"
	self.colt_1911.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.colt_1911.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.colt_1911.single = {}
	self.colt_1911.single.fire_rate = 0.12
	self.colt_1911.timers = {}
	self.colt_1911.timers.reload_not_empty = 1.47
	self.colt_1911.timers.reload_empty = 2.12
	self.colt_1911.timers.unequip = 0.5
	self.colt_1911.timers.equip = 0.5
	self.colt_1911.name_id = "bm_w_colt_1911"
	self.colt_1911.desc_id = "bm_w_colt_1911_desc"
	self.colt_1911.hud_icon = "c45"
	self.colt_1911.description_id = "des_colt_1911"
	self.colt_1911.hud_ammo = "guis/textures/ammo_9mm"
	self.colt_1911.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.colt_1911.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.colt_1911.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.colt_1911.use_data = {}
	self.colt_1911.use_data.selection_index = 1
	self.colt_1911.DAMAGE = 1
	self.colt_1911.CLIP_AMMO_MAX = 10
	self.colt_1911.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.5 / self.colt_1911.CLIP_AMMO_MAX)
	self.colt_1911.AMMO_MAX = self.colt_1911.CLIP_AMMO_MAX * self.colt_1911.NR_CLIPS_MAX
	self.colt_1911.AMMO_PICKUP = self:_pickup_chance(self.colt_1911.AMMO_MAX, 1)
	self.colt_1911.spread = {}
	self.colt_1911.spread.standing = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.crouching = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.steelsight = self.new_m4.spread.steelsight
	self.colt_1911.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.colt_1911.kick = {}
	self.colt_1911.kick.standing = self.glock_17.kick.standing
	self.colt_1911.kick.crouching = self.colt_1911.kick.standing
	self.colt_1911.kick.steelsight = self.colt_1911.kick.standing
	self.colt_1911.crosshair = {}
	self.colt_1911.crosshair.standing = {}
	self.colt_1911.crosshair.crouching = {}
	self.colt_1911.crosshair.steelsight = {}
	self.colt_1911.crosshair.standing.offset = 0.2
	self.colt_1911.crosshair.standing.moving_offset = 0.6
	self.colt_1911.crosshair.standing.kick_offset = 0.4
	self.colt_1911.crosshair.crouching.offset = 0.1
	self.colt_1911.crosshair.crouching.moving_offset = 0.6
	self.colt_1911.crosshair.crouching.kick_offset = 0.3
	self.colt_1911.crosshair.steelsight.hidden = true
	self.colt_1911.crosshair.steelsight.offset = 0
	self.colt_1911.crosshair.steelsight.moving_offset = 0
	self.colt_1911.crosshair.steelsight.kick_offset = 0.1
	self.colt_1911.shake = {}
	self.colt_1911.shake.fire_multiplier = 1
	self.colt_1911.shake.fire_steelsight_multiplier = -1
	self.colt_1911.autohit = autohit_pistol_default
	self.colt_1911.aim_assist = aim_assist_pistol_default
	self.colt_1911.animations = {}
	self.colt_1911.animations.reload = "reload"
	self.colt_1911.animations.reload_not_empty = "reload_not_empty"
	self.colt_1911.animations.equip_id = "equip_glock"
	self.colt_1911.animations.recoil_steelsight = true
	self.colt_1911.statistics = true
	self.colt_1911.stats = {
		damage = 10,
		spread = 7,
		recoil = 5,
		spread_moving = 5,
		zoom = 3,
		concealment = 30,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.mac10 = {}
	self.mac10.category = "smg"
	self.mac10.damage_melee = damage_melee_default
	self.mac10.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.mac10.sounds = {}
	self.mac10.sounds.fire = "mac10_fire"
	self.mac10.sounds.stop_fire = "mac10_stop"
	self.mac10.sounds.dryfire = "mk11_dryfire"
	self.mac10.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.mac10.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.mac10.timers = {}
	self.mac10.timers.reload_not_empty = 1.7
	self.mac10.timers.reload_empty = 2.5
	self.mac10.timers.unequip = 0.7
	self.mac10.timers.equip = 0.5
	self.mac10.name_id = "bm_w_mac10"
	self.mac10.desc_id = "bm_w_mac10_desc"
	self.mac10.hud_icon = "mac11"
	self.mac10.description_id = "des_mac10"
	self.mac10.hud_ammo = "guis/textures/ammo_small_9mm"
	self.mac10.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.mac10.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.mac10.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.mac10.use_data = {}
	self.mac10.use_data.selection_index = 1
	self.mac10.DAMAGE = 1
	self.mac10.CLIP_AMMO_MAX = 40
	self.mac10.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.25 / self.mac10.CLIP_AMMO_MAX)
	self.mac10.AMMO_MAX = self.mac10.CLIP_AMMO_MAX * self.mac10.NR_CLIPS_MAX
	self.mac10.AMMO_PICKUP = self:_pickup_chance(self.mac10.AMMO_MAX, 1)
	self.mac10.auto = {}
	self.mac10.auto.fire_rate = 0.065
	self.mac10.spread = {}
	self.mac10.spread.standing = self.new_m4.spread.standing * 0.75
	self.mac10.spread.crouching = self.new_m4.spread.standing * 0.75
	self.mac10.spread.steelsight = self.new_m4.spread.steelsight
	self.mac10.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.mac10.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.mac10.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.mac10.kick = {}
	self.mac10.kick.standing = self.mp9.kick.standing
	self.mac10.kick.crouching = self.mac10.kick.standing
	self.mac10.kick.steelsight = self.mac10.kick.standing
	self.mac10.crosshair = {}
	self.mac10.crosshair.standing = {}
	self.mac10.crosshair.crouching = {}
	self.mac10.crosshair.steelsight = {}
	self.mac10.crosshair.standing.offset = 0.4
	self.mac10.crosshair.standing.moving_offset = 0.7
	self.mac10.crosshair.standing.kick_offset = 0.6
	self.mac10.crosshair.crouching.offset = 0.3
	self.mac10.crosshair.crouching.moving_offset = 0.6
	self.mac10.crosshair.crouching.kick_offset = 0.4
	self.mac10.crosshair.steelsight.hidden = true
	self.mac10.crosshair.steelsight.offset = 0
	self.mac10.crosshair.steelsight.moving_offset = 0
	self.mac10.crosshair.steelsight.kick_offset = 0.4
	self.mac10.shake = {}
	self.mac10.shake.fire_multiplier = 1
	self.mac10.shake.fire_steelsight_multiplier = -1
	self.mac10.autohit = autohit_pistol_default
	self.mac10.aim_assist = aim_assist_pistol_default
	self.mac10.weapon_hold = "mac11"
	self.mac10.animations = {}
	self.mac10.animations.equip_id = "equip_mac11_rifle"
	self.mac10.animations.recoil_steelsight = false
	self.mac10.statistics = true
	self.mac10.stats = {
		damage = 10,
		spread = 3,
		recoil = 5,
		spread_moving = 8,
		zoom = 3,
		concealment = 27,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.serbu = {}
	self.serbu.category = "shotgun"
	self.serbu.damage_melee = damage_melee_default
	self.serbu.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.serbu.sounds = {}
	self.serbu.sounds.fire = "serbu_fire"
	self.serbu.sounds.dryfire = "remington_dryfire"
	self.serbu.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.serbu.sounds.leave_steelsight = "primary_steel_sight_exit"
	self.serbu.timers = {}
	self.serbu.timers.unequip = 0.7
	self.serbu.timers.equip = 0.6
	self.serbu.name_id = "bm_w_serbu"
	self.serbu.desc_id = "bm_w_serbu_desc"
	self.serbu.hud_icon = "r870_shotgun"
	self.serbu.description_id = "des_r870"
	self.serbu.hud_ammo = "guis/textures/ammo_shell"
	self.serbu.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.serbu.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	self.serbu.use_data = {}
	self.serbu.use_data.selection_index = 1
	self.serbu.use_data.align_place = "right_hand"
	self.serbu.DAMAGE = 6
	self.serbu.damage_near = 300
	self.serbu.damage_far = 1000
	self.serbu.rays = 6
	self.serbu.CLIP_AMMO_MAX = 6
	self.serbu.NR_CLIPS_MAX = math.round(total_damage_secondary / 5.5 / self.serbu.CLIP_AMMO_MAX)
	self.serbu.AMMO_MAX = self.serbu.CLIP_AMMO_MAX * self.serbu.NR_CLIPS_MAX
	self.serbu.AMMO_PICKUP = self:_pickup_chance(self.serbu.AMMO_MAX, 1)
	self.serbu.single = {}
	self.serbu.single.fire_rate = 0.375
	self.serbu.spread = {}
	self.serbu.spread.standing = self.r870.spread.standing
	self.serbu.spread.crouching = self.r870.spread.crouching
	self.serbu.spread.steelsight = self.r870.spread.steelsight
	self.serbu.spread.moving_standing = self.r870.spread.moving_standing
	self.serbu.spread.moving_crouching = self.r870.spread.moving_crouching
	self.serbu.spread.moving_steelsight = self.r870.spread.moving_steelsight
	self.serbu.kick = {}
	self.serbu.kick.standing = self.r870.kick.standing
	self.serbu.kick.crouching = self.serbu.kick.standing
	self.serbu.kick.steelsight = self.serbu.kick.standing
	self.serbu.crosshair = {}
	self.serbu.crosshair.standing = {}
	self.serbu.crosshair.crouching = {}
	self.serbu.crosshair.steelsight = {}
	self.serbu.crosshair.standing.offset = 0.7
	self.serbu.crosshair.standing.moving_offset = 0.7
	self.serbu.crosshair.standing.kick_offset = 0.8
	self.serbu.crosshair.crouching.offset = 0.65
	self.serbu.crosshair.crouching.moving_offset = 0.65
	self.serbu.crosshair.crouching.kick_offset = 0.75
	self.serbu.crosshair.steelsight.hidden = true
	self.serbu.crosshair.steelsight.offset = 0
	self.serbu.crosshair.steelsight.moving_offset = 0
	self.serbu.crosshair.steelsight.kick_offset = 0
	self.serbu.shake = {}
	self.serbu.shake.fire_multiplier = 1
	self.serbu.shake.fire_steelsight_multiplier = -1
	self.serbu.autohit = autohit_shotgun_default
	self.serbu.aim_assist = aim_assist_shotgun_default
	self.serbu.weapon_hold = "r870_shotgun"
	self.serbu.animations = {}
	self.serbu.animations.equip_id = "equip_r870_shotgun"
	self.serbu.animations.recoil_steelsight = true
	self.serbu.statistics = true
	self.serbu.stats = {
		damage = 24,
		spread = 5,
		recoil = 3,
		spread_moving = 6,
		zoom = 3,
		concealment = 24,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.huntsman = {}
	self.huntsman.category = "shotgun"
	self.huntsman.upgrade_blocks = {
		weapon = {
			"clip_ammo_increase"
		}
	}
	self.huntsman.damage_melee = damage_melee_default
	self.huntsman.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.huntsman.sounds = {}
	self.huntsman.sounds.fire = "huntsman_fire"
	self.huntsman.sounds.dryfire = "remington_dryfire"
	self.huntsman.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.huntsman.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.huntsman.timers = {}
	self.huntsman.timers.reload_not_empty = 2.5
	self.huntsman.timers.reload_empty = self.huntsman.timers.reload_not_empty
	self.huntsman.timers.unequip = 0.7
	self.huntsman.timers.equip = 0.6
	self.huntsman.name_id = "bm_w_huntsman"
	self.huntsman.desc_id = "bm_w_huntsman_desc"
	self.huntsman.hud_icon = "m79"
	self.huntsman.description_id = "des_huntsman"
	self.huntsman.hud_ammo = "guis/textures/ammo_grenade"
	self.huntsman.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.huntsman.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	self.huntsman.use_data = {}
	self.huntsman.use_data.selection_index = 2
	self.huntsman.use_data.align_place = "right_hand"
	self.huntsman.DAMAGE = 6
	self.huntsman.damage_near = 1000
	self.huntsman.damage_far = 2000
	self.huntsman.rays = 6
	self.huntsman.CLIP_AMMO_MAX = 2
	self.huntsman.NR_CLIPS_MAX = math.round(total_damage_primary / 12 / self.huntsman.CLIP_AMMO_MAX)
	self.huntsman.AMMO_MAX = self.huntsman.CLIP_AMMO_MAX * self.huntsman.NR_CLIPS_MAX
	self.huntsman.AMMO_PICKUP = self:_pickup_chance(self.huntsman.AMMO_MAX, 1)
	self.huntsman.single = {}
	self.huntsman.single.fire_rate = 0.12
	self.huntsman.spread = {}
	self.huntsman.spread.standing = self.r870.spread.standing
	self.huntsman.spread.crouching = self.r870.spread.crouching
	self.huntsman.spread.steelsight = self.r870.spread.steelsight
	self.huntsman.spread.moving_standing = self.r870.spread.moving_standing
	self.huntsman.spread.moving_crouching = self.r870.spread.moving_crouching
	self.huntsman.spread.moving_steelsight = self.r870.spread.moving_steelsight
	self.huntsman.kick = {}
	self.huntsman.kick.standing = {
		2.9,
		3,
		-0.5,
		0.5
	}
	self.huntsman.kick.crouching = self.huntsman.kick.standing
	self.huntsman.kick.steelsight = self.huntsman.kick.standing
	self.huntsman.crosshair = {}
	self.huntsman.crosshair.standing = {}
	self.huntsman.crosshair.crouching = {}
	self.huntsman.crosshair.steelsight = {}
	self.huntsman.crosshair.standing.offset = 0.16
	self.huntsman.crosshair.standing.moving_offset = 0.8
	self.huntsman.crosshair.standing.kick_offset = 0.6
	self.huntsman.crosshair.standing.hidden = true
	self.huntsman.crosshair.crouching.offset = 0.08
	self.huntsman.crosshair.crouching.moving_offset = 0.7
	self.huntsman.crosshair.crouching.kick_offset = 0.4
	self.huntsman.crosshair.crouching.hidden = true
	self.huntsman.crosshair.steelsight.hidden = true
	self.huntsman.crosshair.steelsight.offset = 0
	self.huntsman.crosshair.steelsight.moving_offset = 0
	self.huntsman.crosshair.steelsight.kick_offset = 0.1
	self.huntsman.shake = {}
	self.huntsman.shake.fire_multiplier = 2
	self.huntsman.shake.fire_steelsight_multiplier = 2
	self.huntsman.autohit = autohit_rifle_default
	self.huntsman.aim_assist = aim_assist_rifle_default
	self.huntsman.animations = {}
	self.huntsman.animations.fire = "recoil"
	self.huntsman.animations.reload = "reload"
	self.huntsman.animations.reload_not_empty = "reload"
	self.huntsman.animations.equip_id = "equip_huntsman"
	self.huntsman.animations.recoil_steelsight = true
	self.huntsman.statistics = true
	self.huntsman.stats = {
		damage = 30,
		spread = 7,
		recoil = 2,
		spread_moving = 6,
		zoom = 3,
		concealment = 6,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.b92fs = {}
	self.b92fs.category = "pistol"
	self.b92fs.damage_melee = damage_melee_default
	self.b92fs.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.b92fs.sounds = {}
	self.b92fs.sounds.fire = "beretta_fire"
	self.b92fs.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.b92fs.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.b92fs.sounds.dryfire = "beretta_dryfire"
	self.b92fs.timers = {}
	self.b92fs.timers.reload_not_empty = 1.47
	self.b92fs.timers.reload_empty = 2.12
	self.b92fs.timers.unequip = 0.55
	self.b92fs.timers.equip = 0.55
	self.b92fs.name_id = "bm_w_b92fs"
	self.b92fs.desc_id = "bm_w_b92fs_desc"
	self.b92fs.hud_icon = "beretta92"
	self.b92fs.description_id = "des_b92fs"
	self.b92fs.hud_ammo = "guis/textures/ammo_9mm"
	self.b92fs.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.b92fs.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.b92fs.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	self.b92fs.use_data = {}
	self.b92fs.use_data.selection_index = 1
	self.b92fs.DAMAGE = 1
	self.b92fs.CLIP_AMMO_MAX = 14
	self.b92fs.NR_CLIPS_MAX = math.round(total_damage_secondary / 1 / self.b92fs.CLIP_AMMO_MAX)
	self.b92fs.AMMO_MAX = self.b92fs.CLIP_AMMO_MAX * self.b92fs.NR_CLIPS_MAX
	self.b92fs.AMMO_PICKUP = self:_pickup_chance(self.b92fs.AMMO_MAX, 1)
	self.b92fs.single = {}
	self.b92fs.single.fire_rate = 0.09
	self.b92fs.spread = {}
	self.b92fs.spread.standing = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.crouching = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.steelsight = self.new_m4.spread.steelsight
	self.b92fs.spread.moving_standing = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.moving_crouching = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.b92fs.kick = {}
	self.b92fs.kick.standing = self.glock_17.kick.standing
	self.b92fs.kick.crouching = self.b92fs.kick.standing
	self.b92fs.kick.steelsight = self.b92fs.kick.standing
	self.b92fs.crosshair = {}
	self.b92fs.crosshair.standing = {}
	self.b92fs.crosshair.crouching = {}
	self.b92fs.crosshair.steelsight = {}
	self.b92fs.crosshair.standing.offset = 0.2
	self.b92fs.crosshair.standing.moving_offset = 0.6
	self.b92fs.crosshair.standing.kick_offset = 0.4
	self.b92fs.crosshair.crouching.offset = 0.1
	self.b92fs.crosshair.crouching.moving_offset = 0.6
	self.b92fs.crosshair.crouching.kick_offset = 0.3
	self.b92fs.crosshair.steelsight.hidden = true
	self.b92fs.crosshair.steelsight.offset = 0
	self.b92fs.crosshair.steelsight.moving_offset = 0
	self.b92fs.crosshair.steelsight.kick_offset = 0.1
	self.b92fs.shake = {}
	self.b92fs.shake.fire_multiplier = 1
	self.b92fs.shake.fire_steelsight_multiplier = -1
	self.b92fs.autohit = autohit_pistol_default
	self.b92fs.aim_assist = aim_assist_pistol_default
	self.b92fs.weapon_hold = "glock"
	self.b92fs.animations = {}
	self.b92fs.animations.equip_id = "equip_glock"
	self.b92fs.animations.recoil_steelsight = true
	self.b92fs.statistics = true
	self.b92fs.stats = {
		damage = 6,
		spread = 8,
		recoil = 10,
		spread_moving = 5,
		zoom = 3,
		concealment = 30,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.new_raging_bull = {}
	self.new_raging_bull.category = "pistol"
	self.new_raging_bull.upgrade_blocks = {
		weapon = {
			"clip_ammo_increase"
		}
	}
	self.new_raging_bull.damage_melee = damage_melee_default
	self.new_raging_bull.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.new_raging_bull.sounds = {}
	self.new_raging_bull.sounds.fire = "rbull_fire"
	self.new_raging_bull.sounds.dryfire = "rbull_dryfire"
	self.new_raging_bull.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.new_raging_bull.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.new_raging_bull.timers = {}
	self.new_raging_bull.timers.reload_not_empty = 2.25
	self.new_raging_bull.timers.reload_empty = 2.25
	self.new_raging_bull.timers.unequip = 0.5
	self.new_raging_bull.timers.equip = 0.5
	self.new_raging_bull.single = {}
	self.new_raging_bull.single.fire_rate = 0.21
	self.new_raging_bull.name_id = "bm_w_raging_bull"
	self.new_raging_bull.desc_id = "bm_w_raging_bull_desc"
	self.new_raging_bull.hud_icon = "raging_bull"
	self.new_raging_bull.description_id = "des_new_raging_bull"
	self.new_raging_bull.hud_ammo = "guis/textures/ammo_9mm"
	self.new_raging_bull.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.new_raging_bull.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	self.new_raging_bull.use_data = {}
	self.new_raging_bull.use_data.selection_index = 1
	self.new_raging_bull.DAMAGE = 2
	self.new_raging_bull.CLIP_AMMO_MAX = 6
	self.new_raging_bull.NR_CLIPS_MAX = math.round(total_damage_secondary / 4.7 / self.new_raging_bull.CLIP_AMMO_MAX)
	self.new_raging_bull.AMMO_MAX = self.new_raging_bull.CLIP_AMMO_MAX * self.new_raging_bull.NR_CLIPS_MAX
	self.new_raging_bull.AMMO_PICKUP = self:_pickup_chance(self.new_raging_bull.AMMO_MAX, 1)
	self.new_raging_bull.spread = {}
	self.new_raging_bull.spread.standing = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.crouching = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.steelsight = self.new_m4.spread.steelsight
	self.new_raging_bull.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	self.new_raging_bull.kick = {}
	self.new_raging_bull.kick.standing = self.glock_17.kick.standing
	self.new_raging_bull.kick.crouching = self.new_raging_bull.kick.standing
	self.new_raging_bull.kick.steelsight = self.new_raging_bull.kick.standing
	self.new_raging_bull.crosshair = {}
	self.new_raging_bull.crosshair.standing = {}
	self.new_raging_bull.crosshair.crouching = {}
	self.new_raging_bull.crosshair.steelsight = {}
	self.new_raging_bull.crosshair.standing.offset = 0.2
	self.new_raging_bull.crosshair.standing.moving_offset = 0.6
	self.new_raging_bull.crosshair.standing.kick_offset = 0.4
	self.new_raging_bull.crosshair.crouching.offset = 0.1
	self.new_raging_bull.crosshair.crouching.moving_offset = 0.6
	self.new_raging_bull.crosshair.crouching.kick_offset = 0.3
	self.new_raging_bull.crosshair.steelsight.hidden = true
	self.new_raging_bull.crosshair.steelsight.offset = 0
	self.new_raging_bull.crosshair.steelsight.moving_offset = 0
	self.new_raging_bull.crosshair.steelsight.kick_offset = 0.1
	self.new_raging_bull.shake = {}
	self.new_raging_bull.shake.fire_multiplier = 1
	self.new_raging_bull.shake.fire_steelsight_multiplier = -1
	self.new_raging_bull.autohit = autohit_pistol_default
	self.new_raging_bull.aim_assist = aim_assist_pistol_default
	self.new_raging_bull.weapon_hold = "raging_bull"
	self.new_raging_bull.animations = {}
	self.new_raging_bull.animations.equip_id = "equip_raging_bull"
	self.new_raging_bull.animations.recoil_steelsight = true
	self.new_raging_bull.statistics = true
	self.new_raging_bull.stats = {
		damage = 22,
		spread = 7,
		recoil = 2,
		spread_moving = 5,
		zoom = 3,
		concealment = 24,
		suppression = 7,
		extra_ammo = 6,
		value = 1
	}
	self.saw = {}
	self.saw.category = "saw"
	self.saw.upgrade_blocks = {
		weapon = {
			"clip_ammo_increase"
		}
	}
	self.saw.damage_melee = damage_melee_default
	self.saw.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	self.saw.sounds = {}
	self.saw.sounds.fire = "Play_saw_handheld_start"
	self.saw.sounds.stop_fire = "Play_saw_handheld_end"
	self.saw.sounds.dryfire = "mp5_dryfire"
	self.saw.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.saw.sounds.leave_steelsight = "secondary_steel_sight_exit"
	self.saw.timers = {}
	self.saw.timers.reload_not_empty = 3.2
	self.saw.timers.reload_empty = 3.2
	self.saw.timers.unequip = 0.7
	self.saw.timers.equip = 0.5
	self.saw.name_id = "bm_w_saw"
	self.saw.desc_id = "bm_w_saw_desc"
	self.saw.hud_icon = "equipment_saw"
	self.saw.description_id = "des_mp5"
	self.saw.hud_ammo = "guis/textures/ammo_9mm"
	self.saw.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.saw.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.saw.use_data = {}
	self.saw.use_data.selection_index = 2
	self.saw.DAMAGE = 0.05
	self.saw.CLIP_AMMO_MAX = 150
	self.saw.NR_CLIPS_MAX = 2
	self.saw.AMMO_MAX = self.saw.CLIP_AMMO_MAX * self.saw.NR_CLIPS_MAX
	self.saw.AMMO_PICKUP = {0, 0}
	self.saw.auto = {}
	self.saw.auto.fire_rate = 0.15
	self.saw.spread = {}
	self.saw.spread.standing = 1
	self.saw.spread.crouching = 0.71
	self.saw.spread.steelsight = 0.48
	self.saw.spread.moving_standing = 1.28
	self.saw.spread.moving_crouching = 1.52
	self.saw.spread.moving_steelsight = 0.48
	self.saw.kick = {}
	self.saw.kick.standing = {
		1,
		-1,
		-1,
		1
	}
	self.saw.kick.crouching = {
		1,
		-1,
		-1,
		1
	}
	self.saw.kick.steelsight = {
		0.725,
		-0.725,
		-0.725,
		0.725
	}
	self.saw.crosshair = {}
	self.saw.crosshair.standing = {}
	self.saw.crosshair.crouching = {}
	self.saw.crosshair.steelsight = {}
	self.saw.crosshair.standing.offset = 0.5
	self.saw.crosshair.standing.moving_offset = 0.6
	self.saw.crosshair.standing.kick_offset = 0.7
	self.saw.crosshair.crouching.offset = 0.4
	self.saw.crosshair.crouching.moving_offset = 0.5
	self.saw.crosshair.crouching.kick_offset = 0.6
	self.saw.crosshair.steelsight.hidden = true
	self.saw.crosshair.steelsight.offset = 0
	self.saw.crosshair.steelsight.moving_offset = 0
	self.saw.crosshair.steelsight.kick_offset = 0
	self.saw.shake = {}
	self.saw.shake.fire_multiplier = 1
	self.saw.shake.fire_steelsight_multiplier = 1
	self.saw.autohit = autohit_pistol_default
	self.saw.aim_assist = aim_assist_pistol_default
	self.saw.weapon_hold = "saw"
	self.saw.animations = {}
	self.saw.animations.equip_id = "equip_saw"
	self.saw.animations.recoil_steelsight = false
	self.saw.statistics = true
	self.saw.stats = {
		suppression = 9,
		zoom = 1,
		spread = 3,
		recoil = 7,
		spread_moving = 7,
		damage = 10,
		concealment = 6,
		value = 1,
		extra_ammo = 6
	}
	self.saw.hit_alert_size_increase = 4
end

function WeaponTweakData:_create_table_structure()
	self.c45_npc = {
		usage = "c45",
		sounds = {},
		use_data = {}
	}
	self.beretta92_npc = {
		usage = "beretta92",
		sounds = {},
		use_data = {}
	}
	self.raging_bull_npc = {
		usage = "raging_bull",
		sounds = {},
		use_data = {}
	}
	self.m4_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.m14_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.m14_sniper_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.r870_npc = {
		usage = "r870",
		sounds = {},
		use_data = {}
	}
	self.mossberg_npc = {
		usage = "mossberg",
		sounds = {},
		use_data = {}
	}
	self.mp5_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.mac11_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.m79_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.glock_18_npc = {
		usage = "glock18",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.ak47_npc = {
		usage = "ak47",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.g36_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.g17_npc = {
		usage = "c45",
		sounds = {},
		use_data = {}
	}
	self.mp9_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.olympic_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.m16_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.aug_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.ak74_npc = {
		usage = "ak47",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.ak5_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.p90_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.amcar_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.mac10_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.akmsu_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.akm_npc = {
		usage = "m4",
		sounds = {},
		use_data = {},
		auto = {}
	}
	self.deagle_npc = {
		usage = "raging_bull",
		sounds = {},
		use_data = {}
	}
	self.serbu_npc = {
		usage = "r870",
		sounds = {},
		use_data = {}
	}
	self.saiga_npc = {
		usage = "r870",
		sounds = {},
		use_data = {}
	}
	self.huntsman_npc = {
		usage = "r870",
		sounds = {},
		use_data = {}
	}
	self.saw_npc = {
		usage = "mp5",
		sounds = {},
		use_data = {}
	}
	self.sentry_gun = {
		sounds = {},
		auto = {}
	}
end

function WeaponTweakData:_precalculate_values()
	self.m4_npc.AMMO_MAX = self.m4_npc.CLIP_AMMO_MAX * self.m4_npc.NR_CLIPS_MAX
	self.m14_npc.AMMO_MAX = self.m14_npc.CLIP_AMMO_MAX * self.m14_npc.NR_CLIPS_MAX
	self.m14_sniper_npc.AMMO_MAX = self.m14_sniper_npc.CLIP_AMMO_MAX * self.m14_sniper_npc.NR_CLIPS_MAX
	self.c45_npc.AMMO_MAX = self.c45_npc.CLIP_AMMO_MAX * self.c45_npc.NR_CLIPS_MAX
	self.beretta92_npc.AMMO_MAX = self.beretta92_npc.CLIP_AMMO_MAX * self.beretta92_npc.NR_CLIPS_MAX
	self.raging_bull_npc.AMMO_MAX = self.raging_bull_npc.CLIP_AMMO_MAX * self.raging_bull_npc.NR_CLIPS_MAX
	self.r870_npc.AMMO_MAX = self.r870_npc.CLIP_AMMO_MAX * self.r870_npc.NR_CLIPS_MAX
	self.mossberg_npc.AMMO_MAX = self.mossberg_npc.CLIP_AMMO_MAX * self.mossberg_npc.NR_CLIPS_MAX
	self.mp5_npc.AMMO_MAX = self.mp5_npc.CLIP_AMMO_MAX * self.mp5_npc.NR_CLIPS_MAX
	self.mac11_npc.AMMO_MAX = self.mac11_npc.CLIP_AMMO_MAX * self.mac11_npc.NR_CLIPS_MAX
	self.glock_18_npc.AMMO_MAX = self.glock_18_npc.CLIP_AMMO_MAX * self.glock_18_npc.NR_CLIPS_MAX
	self.ak47_npc.AMMO_MAX = self.ak47_npc.CLIP_AMMO_MAX * self.ak47_npc.NR_CLIPS_MAX
	self.g36_npc.AMMO_MAX = self.g36_npc.CLIP_AMMO_MAX * self.g36_npc.NR_CLIPS_MAX
	self.g17_npc.AMMO_MAX = self.g17_npc.CLIP_AMMO_MAX * self.g17_npc.NR_CLIPS_MAX
	self.mp9_npc.AMMO_MAX = self.mp9_npc.CLIP_AMMO_MAX * self.mp9_npc.NR_CLIPS_MAX
	self.olympic_npc.AMMO_MAX = self.olympic_npc.CLIP_AMMO_MAX * self.olympic_npc.NR_CLIPS_MAX
	self.m16_npc.AMMO_MAX = self.m16_npc.CLIP_AMMO_MAX * self.m16_npc.NR_CLIPS_MAX
	self.aug_npc.AMMO_MAX = self.aug_npc.CLIP_AMMO_MAX * self.aug_npc.NR_CLIPS_MAX
	self.ak74_npc.AMMO_MAX = self.ak74_npc.CLIP_AMMO_MAX * self.ak74_npc.NR_CLIPS_MAX
	self.ak5_npc.AMMO_MAX = self.ak5_npc.CLIP_AMMO_MAX * self.ak5_npc.NR_CLIPS_MAX
	self.p90_npc.AMMO_MAX = self.p90_npc.CLIP_AMMO_MAX * self.p90_npc.NR_CLIPS_MAX
	self.amcar_npc.AMMO_MAX = self.amcar_npc.CLIP_AMMO_MAX * self.amcar_npc.NR_CLIPS_MAX
	self.mac10_npc.AMMO_MAX = self.mac10_npc.CLIP_AMMO_MAX * self.mac10_npc.NR_CLIPS_MAX
	self.akmsu_npc.AMMO_MAX = self.akmsu_npc.CLIP_AMMO_MAX * self.akmsu_npc.NR_CLIPS_MAX
	self.akm_npc.AMMO_MAX = self.akm_npc.CLIP_AMMO_MAX * self.akm_npc.NR_CLIPS_MAX
	self.deagle_npc.AMMO_MAX = self.deagle_npc.CLIP_AMMO_MAX * self.deagle_npc.NR_CLIPS_MAX
	self.serbu_npc.AMMO_MAX = self.serbu_npc.CLIP_AMMO_MAX * self.serbu_npc.NR_CLIPS_MAX
	self.saiga_npc.AMMO_MAX = self.saiga_npc.CLIP_AMMO_MAX * self.saiga_npc.NR_CLIPS_MAX
	self.huntsman_npc.AMMO_MAX = self.huntsman_npc.CLIP_AMMO_MAX * self.huntsman_npc.NR_CLIPS_MAX
	self.saw_npc.AMMO_MAX = self.saw_npc.CLIP_AMMO_MAX * self.saw_npc.NR_CLIPS_MAX
end
