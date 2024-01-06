GrenadeLauncherBase = GrenadeLauncherBase or class(NewRaycastWeaponBase)

function GrenadeLauncherBase:init(...)
	GrenadeLauncherBase.super.init(self, ...)
end

local mvec_spread_direction = Vector3()

function GrenadeLauncherBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, shoot_through_data)
	local unit
	local spread = self:_get_spread(user_unit)
	mvector3.set(mvec_spread_direction, direction)
	if spread then
		mvector3.spread(mvec_spread_direction, spread * (spread_mul or 1))
	end
	local grenade_type_index = self._grenade_type_index or 2
	if self._ammo_data and self._ammo_data.launcher_grenade then
		grenade_type_index = tweak_data.blackmarket:get_index_from_grenade_id(self._ammo_data.launcher_grenade)
	end
	mvec_spread_direction = mvec_spread_direction * (grenade_type_index == 3 and 10 or 5)
	if Network:is_client() then
		managers.network:session():send_to_host("server_throw_grenade", grenade_type_index, from_pos, mvec_spread_direction)
	else
		unit = GrenadeBase.server_throw_grenade(grenade_type_index, from_pos, mvec_spread_direction, managers.network:session():local_peer():id())
	end
	managers.statistics:shot_fired({
		hit = false,
		weapon_unit = self._unit
	})
	return {}
end

GrenadeLauncherContinousReloadBase = GrenadeLauncherContinousReloadBase or class(NewShotgunBase)

function GrenadeLauncherContinousReloadBase:_fire_raycast(...)
	return GrenadeLauncherBase._fire_raycast(self, ...)
end

function GrenadeLauncherContinousReloadBase:shotgun_shell_data()
	return nil
end
