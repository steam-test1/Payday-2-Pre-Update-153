core:import("CoreMissionScriptElement")
ElementExplosion = ElementExplosion or class(ElementFeedback)

function ElementExplosion:init(...)
	ElementExplosion.super.init(self, ...)
	if Application:editor() and self._values.explosion_effect ~= "none" then
		CoreEngineAccess._editor_load(self.IDS_EFFECT, self._values.explosion_effect:id())
	end
end

function ElementExplosion:client_on_executed(...)
	self:on_executed(...)
end

function ElementExplosion:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	print("ElementExplosion:on_executed( instigator )")
	local player = managers.player:player_unit()
	if player then
		player:character_damage():damage_explosion({
			position = self._values.position,
			range = self._values.range,
			damage = self._values.player_damage
		})
	end
	GrenadeBase._spawn_sound_and_effects(self._values.position, self._values.rotation:z(), self._values.range, self._values.explosion_effect)
	if Network:is_server() then
		GrenadeBase._detect_and_give_dmg({
			_range = self._values.range,
			_collision_slotmask = managers.slot:get_mask("bullet_impact_targets"),
			_curve_pow = 5,
			_damage = self._values.damage,
			_player_damage = 0
		}, self._values.position)
		managers.network:session():send_to_peers_synched("element_explode_on_client", self._values.position, self._values.rotation:z(), self._values.damage, self._values.range, 5)
	end
	ElementExplosion.super.on_executed(self, instigator)
end
