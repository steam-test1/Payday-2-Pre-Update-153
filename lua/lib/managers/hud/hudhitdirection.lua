HUDHitDirection = HUDHitDirection or class()
HUDHitDirection.UNIT_TYPE_HIT_PLAYER = 1
HUDHitDirection.UNIT_TYPE_HIT_VEHICLE = 2

function HUDHitDirection:init(hud)
	self._hud_panel = hud.panel
	if self._hud_panel:child("hit_direction_panel") then
		self._hud_panel:remove(self._hud_panel:child("hit_direction_panel"))
	end
	self._hit_direction_panel = self._hud_panel:panel({
		visible = true,
		name = "hit_direction_panel",
		w = 256,
		h = 256,
		valign = "center",
		halign = "center",
		layer = -5
	})
	self._hit_direction_panel:set_center(self._hit_direction_panel:parent():w() / 2, self._hit_direction_panel:parent():h() / 2)
	local right = self._hit_direction_panel:bitmap({
		name = "right",
		visible = true,
		texture = "guis/textures/pd2/hitdirection",
		color = Color.white,
		blend_mode = "add",
		alpha = 0,
		halign = "right"
	})
	right:set_right(right:parent():w())
	local tw = right:texture_width()
	local th = right:texture_height()
	local left = self._hit_direction_panel:bitmap({
		name = "left",
		rotation = 180,
		visible = true,
		texture = "guis/textures/pd2/hitdirection",
		color = Color.white,
		blend_mode = "add",
		alpha = 0,
		halign = "right"
	})
	left:set_left(0)
	local up = self._hit_direction_panel:bitmap({
		name = "up",
		rotation = -90,
		visible = true,
		texture = "guis/textures/pd2/hitdirection",
		color = Color.white,
		blend_mode = "add",
		alpha = 0,
		halign = "right"
	})
	up:set_top(-tw * 1.5)
	up:set_center_x(up:parent():w() / 2)
	local down = self._hit_direction_panel:bitmap({
		name = "down",
		rotation = 90,
		visible = true,
		texture = "guis/textures/pd2/hitdirection",
		color = Color.white,
		blend_mode = "add",
		alpha = 0,
		halign = "right"
	})
	down:set_y(tw * 1.5)
	down:set_center_x(down:parent():w() / 2)
	self._unit_type_hit = HUDHitDirection.UNIT_TYPE_HIT_PLAYER
end

function HUDHitDirection:on_hit_direction(dir, unit_type_hit)
	self._unit_type_hit = unit_type_hit
	local direction = self._hit_direction_panel:child(dir)
	direction:stop()
	direction:animate(callback(self, self, "_animate_hit_direction"))
end

function HUDHitDirection:_animate_hit_direction(direction)
	direction:set_alpha(1)
	local st = 0.6
	local t = st
	local st_red_t = 0.4
	local red_t = st_red_t
	while 0 < t do
		local dt = coroutine.yield()
		t = t - dt
		red_t = math.clamp(red_t - dt, 0, 1)
		if self._unit_type_hit == HUDHitDirection.UNIT_TYPE_HIT_VEHICLE then
			direction:set_color(Color(1, 1, red_t / st_red_t))
		else
			direction:set_color(Color(1, red_t / st_red_t, red_t / st_red_t))
		end
		direction:set_alpha(t / st)
	end
	direction:set_alpha(0)
end
