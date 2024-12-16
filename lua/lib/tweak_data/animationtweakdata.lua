AnimationTweakData = AnimationTweakData or class()

function AnimationTweakData:init()
	self.hold_types = {}
	self.hold_types.bullpup = {weight = 1000}
	self.hold_types.uzi = {weight = 1001}
	self.animation_redirects = {
		m4 = "new_m4",
		g17 = "glock_17",
		m14 = "new_m14",
		mp5 = "new_mp5",
		c45 = "colt_1911",
		beretta92 = "b92fs",
		raging_bull = "new_raging_bull",
		ben = "benelli"
	}
end
