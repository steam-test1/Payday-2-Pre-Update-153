ShieldCopActionWalk = ShieldCopActionWalk or class(CopActionWalk)
ShieldCopActionWalk._walk_anim_velocities = {
	stand = {
		cbt = {
			walk = {
				fwd = 194.2,
				bwd = 187.5,
				l = 186.589,
				r = 191.379
			},
			run = {
				fwd = 348.3,
				bwd = 333.33,
				l = 333.33,
				r = 340.62
			},
			sprint = {
				fwd = 546,
				bwd = 434.1,
				l = 368.116,
				r = 470.636
			}
		}
	}
}
ShieldCopActionWalk._walk_anim_velocities.stand.ntl = ShieldCopActionWalk._walk_anim_velocities.stand.cbt
ShieldCopActionWalk._walk_anim_velocities.stand.hos = ShieldCopActionWalk._walk_anim_velocities.stand.cbt
ShieldCopActionWalk._walk_anim_velocities.stand.wnd = ShieldCopActionWalk._walk_anim_velocities.stand.cbt
ShieldCopActionWalk._walk_anim_velocities.crouch = ShieldCopActionWalk._walk_anim_velocities.stand
ShieldCopActionWalk._walk_anim_lengths = {
	stand = {
		cbt = {
			walk = {
				fwd = 29,
				bwd = 27,
				l = 29,
				r = 29
			},
			run = {
				fwd = 22,
				bwd = 18,
				l = 18,
				r = 20
			},
			sprint = {
				fwd = 18,
				bwd = 15,
				l = 18,
				r = 19
			},
			run_start = {
				fwd = 31,
				bwd = 26,
				l = 27,
				r = 29
			},
			run_start_turn = {
				bwd = 26,
				l = 37,
				r = 26
			},
			run_stop = {
				fwd = 28,
				bwd = 29,
				l = 34,
				r = 30
			}
		}
	}
}
for pose, stances in pairs(ShieldCopActionWalk._walk_anim_lengths) do
	for stance, speeds in pairs(stances) do
		for speed, sides in pairs(speeds) do
			for side, speed in pairs(sides) do
				sides[side] = speed * 0.03333
			end
		end
	end
end
ShieldCopActionWalk._walk_anim_lengths.stand.ntl = ShieldCopActionWalk._walk_anim_lengths.stand.cbt
ShieldCopActionWalk._walk_anim_lengths.stand.hos = ShieldCopActionWalk._walk_anim_lengths.stand.cbt
ShieldCopActionWalk._walk_anim_lengths.stand.wnd = ShieldCopActionWalk._walk_anim_lengths.stand.cbt
ShieldCopActionWalk._walk_anim_lengths.crouch = ShieldCopActionWalk._walk_anim_lengths.stand
