NewShotgunBase = NewShotgunBase or class(NewRaycastWeaponBase)

function NewShotgunBase:init(...)
	NewShotgunBase.super.init(self, ...)
	self:setup_default()
	self._player_run_and_shoot = managers.player:has_category_upgrade("player", "run_and_shoot")
	self._run_and_shoot = managers.player:has_category_upgrade("shotgun", "hip_run_and_shoot") or self._player_run_and_shoot
	self._hip_fire_rate_inc = 0
end

function NewShotgunBase:setup_default()
	self._damage_near = tweak_data.weapon[self._name_id].damage_near
	self._damage_far = tweak_data.weapon[self._name_id].damage_far
	self._rays = tweak_data.weapon[self._name_id].rays or self._ammo_data.rays or 6
	self._range = self._damage_far
	self._use_shotgun_reload = self._use_shotgun_reload or self._use_shotgun_reload == nil
	if not self:weapon_tweak_data().has_magazine then
		self._hip_fire_rate_inc = managers.player:upgrade_value("shotgun", "hip_rate_of_fire", 0)
	end
end

function NewShotgunBase:_create_use_setups()
	local use_data = {}
	local player_setup = {}
	player_setup.selection_index = tweak_data.weapon[self._name_id].use_data.selection_index
	player_setup.equip = {
		align_place = tweak_data.weapon[self._name_id].use_data.align_place or "left_hand"
	}
	player_setup.unequip = {align_place = "back"}
	use_data.player = player_setup
	self._use_data = use_data
end

function NewShotgunBase:fire_rate_multiplier()
	local fire_rate_mul = self._fire_rate_multiplier
	if self._hip_fire_rate_inc ~= 0 then
		local user_unit = self._setup and self._setup.user_unit
		local current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state
		if current_state and not current_state:in_steelsight() then
			fire_rate_mul = fire_rate_mul + (1 - self._hip_fire_rate_inc)
			fire_rate_mul = self:_convert_add_to_mul(fire_rate_mul)
		end
	end
	return fire_rate_mul
end

function NewShotgunBase:on_equip(user_unit)
	NewShotgunBase.super.on_equip(self, user_unit)
	if user_unit and not self._player_run_and_shoot then
		managers.player.RUN_AND_SHOOT = self._run_and_shoot
	end
end

function NewShotgunBase:on_unequip(user_unit)
	NewShotgunBase.super.on_unequip(self, user_unit)
	if user_unit and not self._player_run_and_shoot and not managers.player:has_category_upgrade("player", "run_and_shoot") then
		managers.player.RUN_AND_SHOOT = false
	end
end

function NewShotgunBase:_update_stats_values()
	NewShotgunBase.super._update_stats_values(self)
	self:setup_default()
	if self._ammo_data then
		if self._ammo_data.rays ~= nil then
			self._rays = self._ammo_data.rays
		end
		if self._ammo_data.damage_near ~= nil then
			self._damage_near = self._ammo_data.damage_near
		end
		if self._ammo_data.damage_near_mul ~= nil then
			self._damage_near = self._damage_near * self._ammo_data.damage_near_mul
		end
		if self._ammo_data.damage_far ~= nil then
			self._damage_far = self._ammo_data.damage_far
		end
		if self._ammo_data.damage_far_mul ~= nil then
			self._damage_far = self._damage_far * self._ammo_data.damage_far_mul
		end
		self._range = self._damage_far
	end
end

function NewShotgunBase:get_damage_falloff(damage, col_ray, user_unit)
	local distance = col_ray.distance or mvector3.distance(col_ray.unit:position(), user_unit:position())
	local inc_range_mul = 1
	local current_state = user_unit:movement()._current_state
	if current_state and current_state:in_steelsight() then
		inc_range_mul = managers.player:upgrade_value("shotgun", "steelsight_range_inc", 1)
	end
	return (1 - math.min(1, math.max(0, distance - self._damage_near * inc_range_mul) / (self._damage_far * inc_range_mul))) * damage
end

local mvec_temp = Vector3()
local mvec_to = Vector3()
local mvec_direction = Vector3()
local mvec_spread_direction = Vector3()

function NewShotgunBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, shoot_through_data)
	local result
	local hit_enemies = {}
	local hit_objects = {}
	local hit_something, col_rays
	if self._alert_events then
		col_rays = {}
	end
	local damage = self:_get_current_damage(dmg_mul)
	local autoaim, dodge_enemies = self:check_autoaim(from_pos, direction, self._range)
	local weight = 0.1
	local enemy_died = false
	
	local function hit_enemy(col_ray)
		if col_ray.unit:character_damage() then
			local enemy_key = col_ray.unit:key()
			if not hit_enemies[enemy_key] or col_ray.unit:character_damage().is_head and col_ray.unit:character_damage():is_head(col_ray.body) then
				hit_enemies[enemy_key] = col_ray
			end
		else
			local add_shoot_through_bullet = self._can_shoot_through_shield or self._can_shoot_through_wall
			if add_shoot_through_bullet then
				hit_objects[col_ray.unit:key()] = hit_objects[col_ray.unit:key()] or {}
				table.insert(hit_objects[col_ray.unit:key()], col_ray)
			else
				self._bullet_class:on_collision(col_ray, self._unit, user_unit, damage)
			end
		end
	end
	
	local spread = self:_get_spread(user_unit)
	mvector3.set(mvec_direction, direction)
	for i = 1, shoot_through_data and 1 or self._rays do
		mvector3.set(mvec_spread_direction, mvec_direction)
		if spread then
			mvector3.spread(mvec_spread_direction, spread * (spread_mul or 1))
		end
		mvector3.set(mvec_to, mvec_spread_direction)
		mvector3.multiply(mvec_to, 20000)
		mvector3.add(mvec_to, from_pos)
		local ray_from_unit = shoot_through_data and alive(shoot_through_data.ray_from_unit) and shoot_through_data.ray_from_unit or nil
		local col_ray = (ray_from_unit or World):raycast("ray", from_pos, mvec_to, "slot_mask", self._bullet_slotmask, "ignore_unit", self._setup.ignore_units)
		if col_rays then
			if col_ray then
				table.insert(col_rays, col_ray)
			else
				local ray_to = mvector3.copy(mvec_to)
				local spread_direction = mvector3.copy(mvec_spread_direction)
				table.insert(col_rays, {position = ray_to, ray = spread_direction})
			end
		end
		if self._autoaim and autoaim then
			if col_ray and col_ray.unit:in_slot(managers.slot:get_mask("enemies")) then
				self._autohit_current = (self._autohit_current + weight) / (1 + weight)
				hit_enemy(col_ray)
				autoaim = false
			else
				autoaim = false
				local autohit = self:check_autoaim(from_pos, direction, self._range)
				if autohit then
					local autohit_chance = 1 - math.clamp((self._autohit_current - self._autohit_data.MIN_RATIO) / (self._autohit_data.MAX_RATIO - self._autohit_data.MIN_RATIO), 0, 1)
					if autohit_chance > math.random() then
						self._autohit_current = (self._autohit_current + weight) / (1 + weight)
						hit_something = true
						hit_enemy(autohit)
					else
						self._autohit_current = self._autohit_current / (1 + weight)
					end
				elseif col_ray then
					hit_something = true
					hit_enemy(col_ray)
				end
			end
		elseif col_ray then
			hit_something = true
			hit_enemy(col_ray)
		end
	end
	for _, col_rays in pairs(hit_objects) do
		local center_ray = col_rays[1]
		if 1 < #col_rays then
			mvector3.set_static(mvec_temp, center_ray)
			for _, col_ray in ipairs(col_rays) do
				mvector3.add(mvec_temp, col_ray.position)
			end
			mvector3.divide(mvec_temp, #col_rays)
			local closest_dist_sq = mvector3.distance_sq(mvec_temp, center_ray.position)
			local dist_sq
			for _, col_ray in ipairs(col_rays) do
				dist_sq = mvector3.distance_sq(mvec_temp, col_ray.position)
				if closest_dist_sq > dist_sq then
					closest_dist_sq = dist_sq
					center_ray = col_ray
				end
			end
		end
		NewShotgunBase.super._fire_raycast(self, user_unit, from_pos, center_ray.ray, dmg_mul, shoot_player, 0, autohit_mul, suppr_mul, shoot_through_data)
	end
	for _, col_ray in pairs(hit_enemies) do
		local damage = self:get_damage_falloff(damage, col_ray, user_unit)
		if 0 < damage then
			local my_result
			local add_shoot_through_bullet = self._can_shoot_through_shield or self._can_shoot_through_enemy or self._can_shoot_through_wall
			if add_shoot_through_bullet then
				my_result = NewShotgunBase.super._fire_raycast(self, user_unit, from_pos, col_ray.ray, dmg_mul, shoot_player, 0, autohit_mul, suppr_mul, shoot_through_data)
			else
				my_result = self._bullet_class:on_collision(col_ray, self._unit, user_unit, damage)
			end
			my_result = managers.mutators:modify_value("NewShotgunBase:_fire_raycast", my_result)
			if my_result and my_result.type == "death" then
				managers.game_play_central:do_shotgun_push(col_ray.unit, col_ray.position, col_ray.ray, col_ray.distance, user_unit)
			end
		end
	end
	if dodge_enemies and self._suppression then
		for enemy_data, dis_error in pairs(dodge_enemies) do
			enemy_data.unit:character_damage():build_suppression(suppr_mul * dis_error * self._suppression, self._panic_suppression_chance)
		end
	end
	if not result then
		result = {}
		result.hit_enemy = next(hit_enemies) and true or false
		if self._alert_events then
			result.rays = 0 < #col_rays and col_rays
		end
	end
	if not shoot_through_data then
		managers.statistics:shot_fired({
			hit = false,
			weapon_unit = self._unit
		})
	end
	for _, _ in pairs(hit_enemies) do
		managers.statistics:shot_fired({
			hit = true,
			weapon_unit = self._unit,
			skip_bullet_count = true
		})
	end
	return result
end

SaigaShotgun = SaigaShotgun or class(NewShotgunBase)

function SaigaShotgun:init(...)
	SaigaShotgun.super.init(self, ...)
	self._use_shotgun_reload = false
end

InstantElectricBulletBase = InstantElectricBulletBase or class(InstantBulletBase)

function InstantElectricBulletBase:give_impact_damage(col_ray, weapon_unit, user_unit, damage, armor_piercing)
	local hit_unit = col_ray.unit
	local action_data = {}
	action_data.damage = 0
	action_data.weapon_unit = weapon_unit
	action_data.attacker_unit = user_unit
	action_data.col_ray = col_ray
	action_data.armor_piercing = armor_piercing
	action_data.attacker_unit = user_unit
	action_data.attack_dir = col_ray.ray
	action_data.variant = weapon_unit:base() and weapon_unit:base().get_tase_strength and weapon_unit:base():get_tase_strength() or "light"
	local defense_data = hit_unit and hit_unit:character_damage().damage_tase and hit_unit:character_damage():damage_tase(action_data)
	return defense_data
end
