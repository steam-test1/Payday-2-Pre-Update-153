HUDHitConfirm = HUDHitConfirm or class()

function HUDHitConfirm:init(hud)
	self._hud_panel = hud.panel
	if self._hud_panel:child("hit_confirm") then
		self._hud_panel:remove(self._hud_panel:child("hit_confirm"))
	end
	if self._hud_panel:child("headshot_confirm") then
		self._hud_panel:remove(self._hud_panel:child("headshot_confirm"))
	end
	if self._hud_panel:child("crit_confirm") then
		self._hud_panel:remove(self._hud_panel:child("crit_confirm"))
	end
	self._hit_confirm = self._hud_panel:bitmap({
		valign = "center",
		halign = "center",
		visible = false,
		name = "hit_confirm",
		texture = "guis/textures/pd2/hitconfirm",
		color = Color.white,
		layer = 0,
		blend_mode = "add"
	})
	self._hit_confirm:set_center(self._hud_panel:w() / 2, self._hud_panel:h() / 2)
	self._crit_confirm = self._hud_panel:bitmap({
		valign = "center",
		halign = "center",
		visible = false,
		name = "crit_confirm",
		texture = "guis/textures/pd2/hitconfirm_crit",
		color = Color.white,
		layer = 0,
		blend_mode = "add"
	})
	self._crit_confirm:set_center(self._hud_panel:w() / 2, self._hud_panel:h() / 2)
end

function HUDHitConfirm:on_hit_confirmed()
	self._hit_confirm:stop()
	self._hit_confirm:animate(callback(self, self, "_animate_show"), callback(self, self, "show_done"), 0.25)
end

function HUDHitConfirm:on_headshot_confirmed()
	self._hit_confirm:stop()
	self._hit_confirm:animate(callback(self, self, "_animate_show"), callback(self, self, "show_done"), 0.25)
end

function HUDHitConfirm:on_crit_confirmed()
	self._crit_confirm:stop()
	self._crit_confirm:animate(callback(self, self, "_animate_show"), callback(self, self, "show_done"), 0.25)
end

function HUDHitConfirm:_animate_show(hint_confirm, done_cb, seconds)
	hint_confirm:set_visible(true)
	hint_confirm:set_alpha(1)
	local t = seconds
	while 0 < t do
		local dt = coroutine.yield()
		t = t - dt
		hint_confirm:set_alpha(t / seconds)
	end
	hint_confirm:set_visible(false)
	done_cb()
end

function HUDHitConfirm:show_done()
end
