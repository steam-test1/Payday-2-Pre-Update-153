SmokeScreenGrenade = SmokeScreenGrenade or class(FragGrenade)

function SmokeScreenGrenade:_detonate(tag, unit, body, other_unit, other_body, position, normal, collision_velocity, velocity, other_velocity, new_velocity, direction, damage, ...)
	local pos = self._unit:position()
	local normal = math.UP
	local range = self._range
	if Network:is_server() then
		managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "base", GrenadeBase.EVENT_IDS.detonate)
	end
	local has_dodge_bonus = self._thrower_unit ~= managers.player:player_unit() and self._thrower_unit:base():upgrade_value("player", "sicario_multiplier")
	managers.player:spawn_smoke_screen(pos, normal, self._unit, has_dodge_bonus)
	managers.groupai:state():propagate_alert({
		"explosion",
		pos,
		range,
		managers.groupai:state("civilian_enemies"),
		self._unit
	})
end

function SmokeScreenGrenade:bullet_hit()
end

function SmokeScreenGrenade:_detonate_on_client()
	self:_detonate()
end

function SmokeScreenGrenade:update(unit, t, dt)
	if self._timer then
		self._timer = self._timer - dt
		if self._timer <= 0 and not self._unit:body("static_body"):active() then
			self._timer = nil
			self:_detonate()
		end
	end
	ProjectileBase.update(self, unit, t, dt)
end
