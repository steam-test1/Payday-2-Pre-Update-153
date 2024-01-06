SentryGunDamage = SentryGunDamage or class()
SentryGunDamage._HEALTH_GRANULARITY = CopDamage._HEALTH_GRANULARITY
SentryGunDamage._ATTACK_VARIANTS = CopDamage._ATTACK_VARIANTS

function SentryGunDamage:init(unit)
	self._unit = unit
	self._ext_movement = unit:movement()
	unit:base():post_init()
	unit:brain():post_init()
	unit:movement():post_init()
	self._HEALTH_INIT = 10000
	self._SHIELD_HEALTH_INIT = 10000
	if self._shield_body_name then
		self._shield_body_name_ids = Idstring(self._shield_body_name)
	end
	if self._bag_body_name then
		self._bag_body_name_ids = Idstring(self._bag_body_name)
	end
	if self._invulnerable_body_names then
		self._invulnerable_bodies = {}
		local names_split = string.split(self._invulnerable_body_names, " ")
		for _, name_ids in ipairs(names_split) do
			self._invulnerable_bodies[name_ids:key()] = true
		end
	end
	self._health = self._HEALTH_INIT
	self._shield_health = self._SHIELD_HEALTH_INIT
	self._sync_dmg_leftover = 0
	if self._ignore_client_damage then
		if Network:is_server() then
			self._HEALTH_GRANULARITY = 5
		else
			self._health_ratio = 1
		end
	end
	self._HEALTH_INIT_PERCENT = self._HEALTH_INIT / self._HEALTH_GRANULARITY
	self._SHIELD_HEALTH_INIT_PERCENT = self._SHIELD_HEALTH_INIT / self._HEALTH_GRANULARITY
end

function SentryGunDamage:set_health(amount, shield_health_amount)
	self._health = amount
	self._HEALTH_INIT = amount
	self._HEALTH_INIT_PERCENT = self._HEALTH_INIT / self._HEALTH_GRANULARITY
	self._shield_health = shield_health_amount
	self._SHIELD_HEALTH_INIT = shield_health_amount
	self._SHIELD_HEALTH_INIT_PERCENT = self._SHIELD_HEALTH_INIT / self._HEALTH_GRANULARITY
end

function SentryGunDamage:sync_health(health_ratio)
	self._health_ratio = health_ratio / self._HEALTH_GRANULARITY
	if health_ratio == 0 then
		self:die()
	end
end

function SentryGunDamage:shoot_pos_mid(m_pos)
	mvector3.set(m_pos, self._ext_movement:m_head_pos())
end

function SentryGunDamage:damage_bullet(attack_data)
	if self._dead or self._invulnerable or Network:is_client() and self._ignore_client_damage or PlayerDamage.is_friendly_fire(self, attack_data.attacker_unit) then
		return
	end
	local hit_body = attack_data.col_ray.body
	local hit_body_name = hit_body:name()
	if self._invulnerable_bodies and self._invulnerable_bodies[hit_body_name:key()] then
		return
	end
	local hit_shield = attack_data.col_ray.body and hit_body_name == self._shield_body_name_ids
	local hit_bag = attack_data.col_ray.body and hit_body_name == self._bag_body_name_ids
	local dmg_adjusted = attack_data.damage
	if attack_data.attacker_unit == managers.player:player_unit() then
		self._char_tweak = tweak_data.weapon[self._unit:base():get_name_id()]
		local critical_hit, damage = CopDamage.roll_critical_hit(self, dmg_adjusted)
		dmg_adjusted = damage
		if critical_hit then
			managers.hud:on_crit_confirmed()
		else
			managers.hud:on_hit_confirmed()
		end
	end
	if hit_shield then
		dmg_adjusted = dmg_adjusted * tweak_data.weapon[self._unit:base():get_name_id()].SHIELD_DMG_MUL
	elseif hit_bag then
		dmg_adjusted = dmg_adjusted * tweak_data.weapon[self._unit:base():get_name_id()].BAG_DMG_MUL
		if self._bag_hit_snd_event then
			self._unit:sound_source():post_event(self._bag_hit_snd_event)
		end
	end
	dmg_adjusted = dmg_adjusted + self._sync_dmg_leftover
	local dmg_shield
	if hit_shield and self._shield_health > 0 then
		dmg_shield = true
	end
	local damage_sync = self:_apply_damage(dmg_adjusted, dmg_shield, not dmg_shield, true)
	if self._ignore_client_damage then
		local health_percent = math.ceil(self._health / self._HEALTH_INIT_PERCENT)
		self._unit:network():send("sentrygun_health", health_percent)
	else
		if not damage_sync or damage_sync == 0 then
			return
		end
		local attacker = attack_data.attacker_unit
		if attacker:id() == -1 then
			attacker = self._unit
		end
		local body_index = self._unit:get_body_index(hit_body_name)
		self._unit:network():send("damage_bullet", attacker, damage_sync, body_index, 0, self._dead and true or false)
	end
	if not self._dead then
		self._unit:brain():on_damage_received(attack_data.attacker_unit)
	end
end

function SentryGunDamage:damage_fire(attack_data)
	if self._dead or self._invulnerable or Network:is_client() and self._ignore_client_damage or attack_data.variant == "stun" or not tweak_data.weapon[self._unit:base():get_name_id()].FIRE_DMG_MUL then
		return
	end
	local attacker_unit = attack_data.attacker_unit
	if attacker_unit and attacker_unit:base() and attacker_unit:base().thrower_unit then
		attacker_unit = attacker_unit:base():thrower_unit()
	end
	if attacker_unit and PlayerDamage.is_friendly_fire(self, attacker_unit) then
		return
	end
	local damage = attack_data.damage * tweak_data.weapon[self._unit:base():get_name_id()].FIRE_DMG_MUL
	damage = damage + self._sync_dmg_leftover
	local damage_sync = self:_apply_damage(damage, true, true, true)
	if self._ignore_client_damage then
		local health_percent = math.ceil(self._health / self._HEALTH_INIT_PERCENT)
		self._unit:network():send("sentrygun_health", health_percent)
	else
		if not damage_sync or damage_sync == 0 then
			return
		end
		local attacker = attack_data.attacker_unit
		if attacker:id() == -1 then
			attacker = self._unit
		end
		local i_attack_variant = CopDamage._get_attack_variant_index(self, attack_data.variant)
		self._unit:network():send("damage_fire", attacker, damage_sync, self._dead and true or false, attack_data.col_ray.ray, nil, nil)
	end
	if not self._dead then
		self._unit:brain():on_damage_received(attack_data.attacker_unit)
	end
end

function SentryGunDamage:damage_explosion(attack_data)
	if self._dead or self._invulnerable or Network:is_client() and self._ignore_client_damage or attack_data.variant == "stun" or not tweak_data.weapon[self._unit:base():get_name_id()].EXPLOSION_DMG_MUL then
		return
	end
	local attacker_unit = attack_data.attacker_unit
	if attacker_unit and attacker_unit:base() and attacker_unit:base().thrower_unit then
		attacker_unit = attacker_unit:base():thrower_unit()
	end
	if attacker_unit and PlayerDamage.is_friendly_fire(self, attacker_unit) then
		return
	end
	local damage = attack_data.damage * tweak_data.weapon[self._unit:base():get_name_id()].EXPLOSION_DMG_MUL
	if attacker_unit and attacker_unit == managers.player:player_unit() then
		self._char_tweak = tweak_data.weapon[self._unit:base():get_name_id()]
		local critical_hit, crit_damage = CopDamage.roll_critical_hit(self, damage)
		damage = crit_damage
		if critical_hit then
			managers.hud:on_crit_confirmed()
		else
			managers.hud:on_hit_confirmed()
		end
	end
	damage = damage + self._sync_dmg_leftover
	local damage_sync = self:_apply_damage(damage, true, true, true)
	if self._ignore_client_damage then
		local health_percent = math.ceil(self._health / self._HEALTH_INIT_PERCENT)
		self._unit:network():send("sentrygun_health", health_percent)
	else
		if not damage_sync or damage_sync == 0 then
			return
		end
		local attacker = attack_data.attacker_unit
		if attacker:id() == -1 then
			attacker = self._unit
		end
		local i_attack_variant = CopDamage._get_attack_variant_index(self, attack_data.variant)
		self._unit:network():send("damage_explosion_fire", attacker, damage_sync, i_attack_variant, self._dead and true or false, attack_data.col_ray.ray)
	end
	if not self._dead then
		self._unit:brain():on_damage_received(attacker_unit)
	end
end

function SentryGunDamage:dead()
	return self._dead
end

function SentryGunDamage:health_ratio()
	return self._health / self._HEALTH_INIT
end

function SentryGunDamage:focus_delay_mul()
	return 1
end

function SentryGunDamage:die()
	self._health = 0
	self._dead = true
	self._unit:set_slot(26)
	self._unit:brain():set_active(false)
	self._unit:movement():set_active(false)
	self._unit:movement():on_death()
	managers.groupai:state():on_criminal_neutralized(self._unit)
	self._unit:base():on_death()
	self._unit:sound_source():post_event(self._breakdown_snd_event)
	if self._unit:base():has_shield() and self._death_with_shield_sequence_name then
		self._unit:damage():run_sequence_simple(self._death_with_shield_sequence_name)
	elseif self._death_sequence_name then
		self._unit:damage():run_sequence_simple(self._death_sequence_name)
	end
	if self._unit:interaction() then
		self._unit:interaction():set_tweak_data("sentry_gun_revive")
	end
end

function SentryGunDamage:sync_damage_bullet(attacker_unit, damage_percent, i_body, hit_offset_height, death)
	if self._dead then
		return
	end
	if death then
		self:die()
		return
	end
	local hit_body = self._unit:body(i_body)
	local hit_shield = hit_body:name() == self._shield_body_name_ids
	local dmg_shield = hit_shield and self._shield_health > 0
	local damage = death and "death" or damage_percent * (dmg_shield and self._SHIELD_HEALTH_INIT_PERCENT or self._HEALTH_INIT_PERCENT)
	self:_apply_damage(damage, dmg_shield, not dmg_shield, false)
	if not self._dead then
		self._unit:brain():on_damage_received(attacker_unit)
	end
end

function SentryGunDamage:sync_damage_fire(attacker_unit, damage_percent, death, direction)
	if self._dead then
		return
	end
	if death then
		self:die()
		return
	end
	local damage = death and "death" or damage_percent * self._HEALTH_INIT_PERCENT
	self:_apply_damage(damage, true, true, false)
	if not self._dead then
		self._unit:brain():on_damage_received(attacker_unit)
	end
end

function SentryGunDamage:sync_damage_explosion(attacker_unit, damage_percent, i_attack_variant, death, direction)
	if self._dead then
		return
	end
	if death then
		self:die()
		return
	end
	local variant = self._ATTACK_VARIANTS[i_attack_variant]
	local damage = death and "death" or damage_percent * self._HEALTH_INIT_PERCENT
	self:_apply_damage(damage, true, true, false)
	if not self._dead then
		self._unit:brain():on_damage_received(attacker_unit)
	end
end

function SentryGunDamage:_apply_damage(damage, dmg_shield, dmg_body, is_local)
	if dmg_shield and self._shield_health > 0 then
		local damage_percent
		local shield_dmg = damage ~= "death" and damage or self._SHIELD_HEALTH_INIT
		if tweak_data.weapon[self._unit:base():get_name_id()].SHIELD_DAMAGE_CLAMP then
			shield_dmg = math.min(shield_dmg, tweak_data.weapon[self._unit:base():get_name_id()].SHIELD_DAMAGE_CLAMP)
		end
		if is_local then
			shield_dmg = shield_dmg * tweak_data.weapon[self._unit:base():get_name_id()].SHIELD_DMG_MUL
			local health_init_percent = self._SHIELD_HEALTH_INIT_PERCENT
			damage_percent = math.clamp(shield_dmg / health_init_percent, 0, self._HEALTH_GRANULARITY)
			local leftover_percent = damage_percent - math.floor(damage_percent)
			self._sync_dmg_leftover = leftover_percent * health_init_percent
			damage_percent = math.floor(damage_percent)
			shield_dmg = damage_percent * health_init_percent
		end
		if 0 < shield_dmg then
			if shield_dmg >= self._shield_health then
				self._shield_health = 0
				self._sync_dmg_leftover = 0
				if self._shield_destroyed_sequence_name then
					self._unit:damage():run_sequence_simple(self._shield_destroyed_sequence_name)
				end
				if self._shield_destroyed_snd_event then
					self._unit:sound_source():post_event(self._shield_destroyed_snd_event)
				end
			else
				self._shield_health = self._shield_health - shield_dmg
			end
			if not dmg_body then
				return damage_percent
			end
		end
	end
	if dmg_body then
		local damage_percent
		local body_damage = damage ~= "death" and damage or self._HEALTH_INIT
		if is_local then
			local health_init_percent = self._HEALTH_INIT_PERCENT
			damage_percent = math.clamp(body_damage / health_init_percent, 0, self._HEALTH_GRANULARITY)
			local leftover_percent = damage_percent - math.floor(damage_percent)
			self._sync_dmg_leftover = leftover_percent * health_init_percent
			damage_percent = math.floor(damage_percent)
			body_damage = damage_percent * health_init_percent
		end
		if body_damage == 0 then
			return
		end
		local previous_health_ratio = self:health_ratio()
		if body_damage >= self._health then
			self:die()
		else
			self._health = self._health - body_damage
		end
		if not self._dead and 0.75 <= previous_health_ratio and self:health_ratio() < 0.75 and self._damaged_sequence_name then
			self._unit:damage():run_sequence_simple(self._damaged_sequence_name)
		end
		return damage_percent
	end
end

function SentryGunDamage:save(save_data)
	local my_save_data = {}
	save_data.char_damage = my_save_data
	my_save_data.ignore_client_damage = self._ignore_client_damage
	my_save_data.health = self._health
	my_save_data.shield_health = self._shield_health
	my_save_data.HEALTH_INIT = self._HEALTH_INIT
	my_save_data.SHIELD_HEALTH_INIT = self._SHIELD_HEALTH_INIT
end

function SentryGunDamage:load(save_data)
	if not save_data or not save_data.char_damage then
		return
	end
	local my_save_data = save_data.char_damage
	self._ignore_client_damage = my_save_data.ignore_client_damage
	self._health = my_save_data.health
	self._shield_health = my_save_data.shield_health
	self._HEALTH_INIT = my_save_data.HEALTH_INIT
	self._SHIELD_HEALTH_INIT = my_save_data.SHIELD_HEALTH_INIT
	self._HEALTH_INIT_PERCENT = self._HEALTH_INIT / self._HEALTH_GRANULARITY
	self._SHIELD_HEALTH_INIT_PERCENT = self._SHIELD_HEALTH_INIT / self._HEALTH_GRANULARITY
	if self._health == 0 then
		self:die()
	end
end

function SentryGunDamage:destroy(unit)
	unit:brain():pre_destroy()
	unit:movement():pre_destroy()
	unit:base():pre_destroy()
end
