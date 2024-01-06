PlayerTweakData = PlayerTweakData or class()

function PlayerTweakData:_set_easy()
	self.damage.automatic_respawn_time = 150
end

function PlayerTweakData:_set_normal()
	self.damage.automatic_respawn_time = 120
end

function PlayerTweakData:_set_hard()
	self.damage.automatic_respawn_time = 220
	self.damage.DOWNED_TIME_DEC = 7
	self.damage.DOWNED_TIME_MIN = 5
end

function PlayerTweakData:_set_overkill()
	self.damage.DOWNED_TIME_DEC = 10
	self.damage.DOWNED_TIME_MIN = 5
end

function PlayerTweakData:_set_overkill_145()
	self.damage.DOWNED_TIME_DEC = 15
	self.damage.DOWNED_TIME_MIN = 1
end

function PlayerTweakData:_set_overkill_290()
	self.damage.DOWNED_TIME_DEC = 20
	self.damage.DOWNED_TIME_MIN = 1
	self.suspicion.max_value = 12
	self.suspicion.range_mul = 1.4
	self.suspicion.buildup_mul = 1.4
	self.damage.BLEED_OT_TIME = 10
	self.damage.LIVES_INIT = 4
	self.damage.MIN_DAMAGE_INTERVAL = 0.35
	self.damage.REVIVE_HEALTH_STEPS = {0.1}
end

function PlayerTweakData:_set_singleplayer()
	self.damage.REGENERATE_TIME = 1.75
end

function PlayerTweakData:_set_multiplayer()
end

function PlayerTweakData:init()
	local is_console = SystemInfo:platform() ~= Idstring("WIN32")
	self.arrest = {arrest_timeout = 240, aggression_timeout = 60}
	self.put_on_mask_time = 2
	self.damage = {}
	if is_console then
		self.damage.ARMOR_INIT = 5
	else
		self.damage.ARMOR_INIT = 2
	end
	self.damage.DODGE_INIT = 0
	self.damage.HEALTH_REGEN = 0
	self.damage.ARMOR_STEPS = 1
	self.damage.ARMOR_DAMAGE_REDUCTION = 0
	self.damage.ARMOR_DAMAGE_REDUCTION_STEPS = {
		1,
		0.6,
		0.7,
		0.8,
		0.9,
		0.95,
		0.96,
		0.97,
		0.98,
		0.99
	}
	self.damage.HEALTH_INIT = 23
	self.damage.LIVES_INIT = 4
	if is_console then
		self.damage.REGENERATE_TIME = 2.35
	else
		self.damage.REGENERATE_TIME = 3
	end
	self.damage.REVIVE_HEALTH_STEPS = {0.4}
	self.damage.BLEED_OT_TIME = 40
	self.damage.TASED_TIME = 10
	self.damage.TASED_RECOVER_TIME = 1
	self.damage.BLEED_OUT_HEALTH_INIT = 10
	self.damage.DOWNED_TIME = 30
	self.damage.DOWNED_TIME_DEC = 5
	self.damage.DOWNED_TIME_MIN = 10
	self.damage.ARRESTED_TIME = 60
	self.damage.INCAPACITATED_TIME = 30
	self.damage.MIN_DAMAGE_INTERVAL = 0.45
	self.damage.respawn_time_penalty = 30
	self.damage.base_respawn_time_penalty = 5
	self.fall_health_damage = 4
	self.fall_damage_alert_size = 250
	self.SUSPICION_OFFSET_LERP = 0.75
	self.long_dis_interaction = {
		intimidate_strength = 0.5,
		highlight_range = 3000,
		intimidate_range_enemies = 1000,
		intimidate_range_civilians = 1000
	}
	self.suppression = {
		max_value = 20,
		decay_start_delay = 1,
		receive_mul = 10,
		spread_mul = 1,
		autohit_chance_mul = 1,
		tolerance = 1
	}
	self.suspicion = {
		max_value = 8,
		range_mul = 1,
		buildup_mul = 1
	}
	self.alarm_pager = {
		first_call_delay = {2, 4},
		call_duration = {
			{6, 6},
			{6, 6}
		},
		nr_of_calls = {2, 2},
		bluff_success_chance = {
			1,
			1,
			1,
			1,
			0
		},
		bluff_success_chance_w_skill = {
			1,
			1,
			1,
			1,
			0
		}
	}
	self.max_nr_following_hostages = 1
	self.TRANSITION_DURATION = 0.23
	self.stances = {
		default = {
			standard = {
				head = {},
				shoulders = {},
				vel_overshot = {}
			},
			crouched = {
				head = {},
				shoulders = {},
				vel_overshot = {}
			},
			steelsight = {
				shoulders = {},
				vel_overshot = {}
			}
		}
	}
	self.stances.default.standard.head.translation = Vector3(0, 0, 145)
	self.stances.default.standard.head.rotation = Rotation()
	self.stances.default.standard.shakers = {}
	self.stances.default.standard.shakers.breathing = {}
	self.stances.default.standard.shakers.breathing.amplitude = 0.3
	self.stances.default.crouched.shakers = {}
	self.stances.default.crouched.shakers.breathing = {}
	self.stances.default.crouched.shakers.breathing.amplitude = 0.25
	self.stances.default.steelsight.shakers = {}
	self.stances.default.steelsight.shakers.breathing = {}
	self.stances.default.steelsight.shakers.breathing.amplitude = 0.025
	self.stances.default.mask_off = deep_clone(self.stances.default.standard)
	self.stances.default.mask_off.head.translation = Vector3(0, 0, 160)
	self.stances.default.clean = deep_clone(self.stances.default.mask_off)
	self.stances.default.civilian = deep_clone(self.stances.default.mask_off)
	local pivot_head_translation = Vector3()
	local pivot_head_rotation = Rotation()
	local pivot_shoulder_translation = Vector3()
	local pivot_shoulder_rotation = Rotation()
	self.stances.default.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.default.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.default.standard.vel_overshot.yaw_neg = 6
	self.stances.default.standard.vel_overshot.yaw_pos = -6
	self.stances.default.standard.vel_overshot.pitch_neg = -10
	self.stances.default.standard.vel_overshot.pitch_pos = 10
	self.stances.default.standard.vel_overshot.pivot = Vector3(0, 0, 0)
	self.stances.default.standard.FOV = 65
	self.stances.default.crouched.head.translation = Vector3(0, 0, 75)
	self.stances.default.crouched.head.rotation = Rotation()
	local pivot_head_translation = Vector3()
	local pivot_head_rotation = Rotation()
	self.stances.default.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.default.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.default.crouched.vel_overshot.yaw_neg = 6
	self.stances.default.crouched.vel_overshot.yaw_pos = -6
	self.stances.default.crouched.vel_overshot.pitch_neg = -10
	self.stances.default.crouched.vel_overshot.pitch_pos = 10
	self.stances.default.crouched.vel_overshot.pivot = Vector3(0, 0, 0)
	self.stances.default.crouched.FOV = self.stances.default.standard.FOV
	local pivot_head_translation = Vector3(0, 0, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.default.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.default.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.default.steelsight.vel_overshot.yaw_neg = 4
	self.stances.default.steelsight.vel_overshot.yaw_pos = -4
	self.stances.default.steelsight.vel_overshot.pitch_neg = -2
	self.stances.default.steelsight.vel_overshot.pitch_pos = 2
	self.stances.default.steelsight.vel_overshot.pivot = pivot_shoulder_translation
	self.stances.default.steelsight.zoom_fov = true
	self.stances.default.steelsight.FOV = self.stances.default.standard.FOV
	self.stances.jowi = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.391, 45.0507, -3.38766)
	local pivot_shoulder_rotation = Rotation(-0.326422, 0.247368, -0.0156885)
	local pivot_head_translation = Vector3(10.95, 30, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.jowi.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.jowi.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.jowi.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10.95, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.jowi.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.jowi.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.jowi.steelsight.zoom_fov = false
	self.stances.jowi.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.jowi.steelsight.vel_overshot.yaw_neg = 5
	self.stances.jowi.steelsight.vel_overshot.yaw_pos = -5
	self.stances.jowi.steelsight.vel_overshot.pitch_neg = -12
	self.stances.jowi.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.jowi.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.jowi.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.jowi.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self:_init_new_stances()
	self.movement_state = {}
	self.movement_state.standard = {}
	self.movement_state.standard.movement = {
		speed = {},
		jump_velocity = {
			xy = {}
		}
	}
	self.movement_state.standard.movement.speed.STANDARD_MAX = 350
	self.movement_state.standard.movement.speed.RUNNING_MAX = 575
	self.movement_state.standard.movement.speed.CROUCHING_MAX = 225
	self.movement_state.standard.movement.speed.STEELSIGHT_MAX = 185
	self.movement_state.standard.movement.speed.INAIR_MAX = 185
	self.movement_state.standard.movement.speed.CLIMBING_MAX = 200
	self.movement_state.standard.movement.jump_velocity.z = 470
	self.movement_state.standard.movement.jump_velocity.xy.run = self.movement_state.standard.movement.speed.RUNNING_MAX * 1
	self.movement_state.standard.movement.jump_velocity.xy.walk = self.movement_state.standard.movement.speed.STANDARD_MAX * 1.2
	self.movement_state.interaction_delay = 1.5
	self.movement_state.stamina = {}
	self.movement_state.stamina.STAMINA_INIT = 20
	self.movement_state.stamina.STAMINA_REGEN_RATE = 3
	self.movement_state.stamina.STAMINA_DRAIN_RATE = 2
	self.movement_state.stamina.REGENERATE_TIME = 1
	self.movement_state.stamina.MIN_STAMINA_THRESHOLD = 4
	self.movement_state.stamina.JUMP_STAMINA_DRAIN = 2
	self.camera = {}
	self.camera.MIN_SENSITIVITY = 0.3
	self.camera.MAX_SENSITIVITY = 1.7
	self.omniscience = {}
	self.omniscience.start_t = 3.5
	self.omniscience.interval_t = 1
	self.omniscience.sense_radius = 1000
	self.omniscience.target_resense_t = 15
end

function PlayerTweakData:_init_new_stances()
	self.stances.new_m4 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7288, 23.0125, -1.8891)
	local pivot_shoulder_rotation = Rotation(0.106607, -0.0844486, 0.629199)
	local pivot_head_translation = Vector3(7.5, 17, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_m4.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_m4.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_m4.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.new_m4.steelsight.vel_overshot.pitch_neg = -17
	self.stances.new_m4.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(0, 10, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_m4.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_m4.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_m4.steelsight.FOV = self.stances.new_m4.standard.FOV
	self.stances.new_m4.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -7, 0)
	self.stances.new_m4.steelsight.vel_overshot.yaw_neg = 8
	self.stances.new_m4.steelsight.vel_overshot.yaw_pos = -8
	self.stances.new_m4.steelsight.vel_overshot.pitch_neg = -17
	self.stances.new_m4.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(6.5, 15.5, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_m4.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_m4.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_m4.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.glock_18c = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.49051, 38.6474, -5.09399)
	local pivot_shoulder_rotation = Rotation(0.0999949, -0.687702, 0.630304)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.glock_18c.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.glock_18c.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.glock_18c.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.glock_18c.standard.vel_overshot.yaw_neg = 10
	self.stances.glock_18c.standard.vel_overshot.yaw_pos = -10
	self.stances.glock_18c.standard.vel_overshot.pitch_neg = -13
	self.stances.glock_18c.standard.vel_overshot.pitch_pos = 13
	local pivot_head_translation = Vector3(0, 37, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.glock_18c.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.glock_18c.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.glock_18c.steelsight.FOV = self.stances.glock_18c.standard.FOV
	self.stances.glock_18c.steelsight.zoom_fov = false
	self.stances.glock_18c.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.glock_18c.steelsight.vel_overshot.yaw_neg = 8
	self.stances.glock_18c.steelsight.vel_overshot.yaw_pos = -8
	self.stances.glock_18c.steelsight.vel_overshot.pitch_neg = -8
	self.stances.glock_18c.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(4, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.glock_18c.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.glock_18c.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.glock_18c.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.amcar = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7338, 23.0132, -1.4367)
	local pivot_shoulder_rotation = Rotation(0.10663, -0.0844277, 0.629211)
	local pivot_head_translation = Vector3(7.5, 17, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.amcar.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.amcar.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.amcar.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.amcar.standard.vel_overshot.yaw_neg = -6
	self.stances.amcar.standard.vel_overshot.yaw_pos = 6
	self.stances.amcar.standard.vel_overshot.pitch_neg = 5
	self.stances.amcar.standard.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 14, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.amcar.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.amcar.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.amcar.steelsight.FOV = self.stances.amcar.standard.FOV
	self.stances.amcar.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -7, 0)
	self.stances.amcar.steelsight.vel_overshot.yaw_neg = -2
	self.stances.amcar.steelsight.vel_overshot.yaw_pos = 4
	self.stances.amcar.steelsight.vel_overshot.pitch_neg = 5
	self.stances.amcar.steelsight.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(6.5, 15.5, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.amcar.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.amcar.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.amcar.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.amcar.crouched.vel_overshot.yaw_neg = -6
	self.stances.amcar.crouched.vel_overshot.yaw_pos = 6
	self.stances.amcar.crouched.vel_overshot.pitch_neg = 5
	self.stances.amcar.crouched.vel_overshot.pitch_pos = -5
	self.stances.m16 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7353, 23.0139, -1.43553)
	local pivot_shoulder_rotation = Rotation(0.106665, -0.0845104, 0.629231)
	local pivot_head_translation = Vector3(7.5, 17, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m16.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m16.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m16.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.m16.standard.vel_overshot.yaw_neg = -6
	self.stances.m16.standard.vel_overshot.yaw_pos = 6
	self.stances.m16.standard.vel_overshot.pitch_neg = 10
	self.stances.m16.standard.vel_overshot.pitch_pos = -10
	local pivot_head_translation = Vector3(0, 14, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m16.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m16.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m16.steelsight.FOV = self.stances.m16.standard.FOV
	self.stances.m16.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -7, 0)
	self.stances.m16.steelsight.vel_overshot.yaw_neg = -4
	self.stances.m16.steelsight.vel_overshot.yaw_pos = 4
	self.stances.m16.steelsight.vel_overshot.pitch_neg = 8
	self.stances.m16.steelsight.vel_overshot.pitch_pos = -8
	local pivot_head_translation = Vector3(6.5, 15.5, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m16.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m16.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m16.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.m16.crouched.vel_overshot.yaw_neg = -4
	self.stances.m16.crouched.vel_overshot.yaw_pos = 4
	self.stances.m16.crouched.vel_overshot.pitch_neg = 8
	self.stances.m16.crouched.vel_overshot.pitch_pos = -8
	self.stances.olympic = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7335, 23.013, -1.43651)
	local pivot_shoulder_rotation = Rotation(0.106626, -0.0833779, 0.62919)
	local pivot_head_translation = Vector3(8, 16, -1.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.olympic.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.olympic.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.olympic.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	local pivot_head_translation = Vector3(0, 14, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.olympic.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.olympic.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.olympic.steelsight.FOV = self.stances.olympic.standard.FOV
	self.stances.olympic.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -7, 0)
	self.stances.olympic.steelsight.vel_overshot.yaw_neg = 8
	self.stances.olympic.steelsight.vel_overshot.yaw_pos = -8
	self.stances.olympic.steelsight.vel_overshot.pitch_neg = -17
	self.stances.olympic.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(7, 15, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.olympic.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.olympic.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.olympic.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -7, 0)
	self.stances.ak74 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6635, 40.3795, -4.93265)
	local pivot_shoulder_rotation = Rotation(0.10668, -0.0844958, 0.629228)
	local pivot_head_translation = Vector3(7, 33, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ak74.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ak74.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ak74.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.ak74.standard.vel_overshot.yaw_neg = -5
	self.stances.ak74.standard.vel_overshot.yaw_pos = 5
	self.stances.ak74.standard.vel_overshot.pitch_neg = 7
	self.stances.ak74.standard.vel_overshot.pitch_pos = -7
	local pivot_head_translation = Vector3(6, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ak74.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ak74.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ak74.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.ak74.crouched.vel_overshot.yaw_neg = -4
	self.stances.ak74.crouched.vel_overshot.yaw_pos = 4
	self.stances.ak74.crouched.vel_overshot.pitch_neg = 5
	self.stances.ak74.crouched.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ak74.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ak74.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ak74.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.ak74.steelsight.vel_overshot.yaw_neg = -4
	self.stances.ak74.steelsight.vel_overshot.yaw_pos = 4
	self.stances.ak74.steelsight.vel_overshot.pitch_neg = 5
	self.stances.ak74.steelsight.vel_overshot.pitch_pos = -5
	self.stances.akm = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6677, 40.3885, -4.94216)
	local pivot_shoulder_rotation = Rotation(0.10664, -0.0844285, 0.629212)
	local pivot_head_translation = Vector3(7, 33, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.akm.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akm.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akm.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akm.standard.vel_overshot.yaw_neg = -5
	self.stances.akm.standard.vel_overshot.yaw_pos = 5
	self.stances.akm.standard.vel_overshot.pitch_neg = 7
	self.stances.akm.standard.vel_overshot.pitch_pos = -7
	local pivot_head_translation = Vector3(6, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.akm.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akm.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akm.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akm.crouched.vel_overshot.yaw_neg = -4
	self.stances.akm.crouched.vel_overshot.yaw_pos = 4
	self.stances.akm.crouched.vel_overshot.pitch_neg = 5
	self.stances.akm.crouched.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.akm.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akm.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akm.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akm.steelsight.vel_overshot.yaw_neg = -4
	self.stances.akm.steelsight.vel_overshot.yaw_pos = 4
	self.stances.akm.steelsight.vel_overshot.pitch_neg = 5
	self.stances.akm.steelsight.vel_overshot.pitch_pos = -5
	self.stances.akmsu = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6646, 40.3785, -4.67554)
	local pivot_shoulder_rotation = Rotation(0.10634, -0.0854686, 0.628928)
	local pivot_head_translation = Vector3(8, 33, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.akmsu.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akmsu.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akmsu.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akmsu.standard.vel_overshot.yaw_neg = 10
	self.stances.akmsu.standard.vel_overshot.yaw_pos = -10
	self.stances.akmsu.standard.vel_overshot.pitch_neg = -20
	self.stances.akmsu.standard.vel_overshot.pitch_pos = 20
	local pivot_head_translation = Vector3(7, 32, -3)
	local pivot_head_rotation = Rotation(0.2, 0.2, 0)
	self.stances.akmsu.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akmsu.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akmsu.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.akmsu.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akmsu.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akmsu.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akmsu.steelsight.vel_overshot.yaw_neg = 10
	self.stances.akmsu.steelsight.vel_overshot.yaw_pos = -10
	self.stances.akmsu.steelsight.vel_overshot.pitch_neg = -20
	self.stances.akmsu.steelsight.vel_overshot.pitch_pos = 20
	self.stances.saiga = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(7.41774, 29.7226, -1.95727)
	local pivot_shoulder_rotation = Rotation(0.106196, -0.0625882, 0.630612)
	local pivot_head_translation = Vector3(8.5, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.saiga.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.saiga.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.saiga.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	local pivot_head_translation = Vector3(7.5, 31, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.saiga.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.saiga.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.saiga.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.saiga.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.saiga.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.saiga.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.saiga.steelsight.vel_overshot.yaw_neg = 10
	self.stances.saiga.steelsight.vel_overshot.yaw_pos = -10
	self.stances.saiga.steelsight.vel_overshot.pitch_neg = -20
	self.stances.saiga.steelsight.vel_overshot.pitch_pos = 20
	self.stances.ak5 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7331, 15.6146, -2.75547)
	local pivot_shoulder_rotation = Rotation(0.106611, -0.431014, 0.6292)
	local pivot_head_translation = Vector3(8, 11, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ak5.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ak5.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ak5.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.ak5.standard.vel_overshot.yaw_neg = 10
	self.stances.ak5.standard.vel_overshot.yaw_pos = -10
	self.stances.ak5.standard.vel_overshot.pitch_neg = -10
	self.stances.ak5.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(-0.017, 18, 0)
	local pivot_head_rotation = Rotation(0.035, 0, 0)
	self.stances.ak5.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ak5.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ak5.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.ak5.steelsight.vel_overshot.yaw_neg = 4
	self.stances.ak5.steelsight.vel_overshot.yaw_pos = -4
	self.stances.ak5.steelsight.vel_overshot.pitch_neg = -17
	self.stances.ak5.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(7, 10, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ak5.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ak5.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ak5.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.aug = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.80945, 14.8857, -4.39332)
	local pivot_shoulder_rotation = Rotation(0.106486, -0.0841679, 0.627838)
	local pivot_head_translation = Vector3(8.5, 16, -3.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.aug.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.aug.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.aug.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.aug.standard.vel_overshot.yaw_neg = 8
	self.stances.aug.standard.vel_overshot.yaw_pos = -8
	self.stances.aug.standard.vel_overshot.pitch_neg = -10
	self.stances.aug.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 17, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.aug.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.aug.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.aug.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.aug.steelsight.vel_overshot.yaw_neg = 4
	self.stances.aug.steelsight.vel_overshot.yaw_pos = -4
	self.stances.aug.steelsight.vel_overshot.pitch_neg = -17
	self.stances.aug.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(7, 14, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.aug.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.aug.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.aug.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.g36 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.5658, 24.8768, -1.07923)
	local pivot_shoulder_rotation = Rotation(-3.13746E-4, 8.13967E-4, -2.7678E-4)
	local pivot_head_translation = Vector3(8, 16, -1.25)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g36.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g36.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g36.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
	local pivot_head_translation = Vector3(0, 17, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g36.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g36.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g36.steelsight.FOV = self.stances.g36.standard.FOV
	self.stances.g36.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.g36.steelsight.vel_overshot.yaw_neg = 5
	self.stances.g36.steelsight.vel_overshot.yaw_pos = -5
	self.stances.g36.steelsight.vel_overshot.pitch_neg = -17
	self.stances.g36.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(7, 15, -2.25)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g36.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g36.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g36.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
	self.stances.p90 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.0002, 24.3293, -0.962641)
	local pivot_shoulder_rotation = Rotation(0.21279, 0.970214, 0.197877)
	local pivot_head_translation = Vector3(7, 21, -1.5)
	local pivot_head_rotation = Rotation(0, 0, -1)
	self.stances.p90.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.p90.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.p90.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
	self.stances.p90.standard.vel_overshot.yaw_neg = 10
	self.stances.p90.standard.vel_overshot.yaw_pos = -10
	self.stances.p90.standard.vel_overshot.pitch_neg = -15
	self.stances.p90.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 20, 0)
	local pivot_head_rotation = Rotation(0, 0, -0.5)
	self.stances.p90.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.p90.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.p90.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.p90.steelsight.vel_overshot.yaw_neg = 5
	self.stances.p90.steelsight.vel_overshot.yaw_pos = -5
	self.stances.p90.steelsight.vel_overshot.pitch_neg = -17
	self.stances.p90.steelsight.vel_overshot.pitch_pos = 17
	local pivot_head_translation = Vector3(6, 19, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.p90.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.p90.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.p90.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
	self.stances.new_m14 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7037, 23.0304, -4.44631)
	local pivot_shoulder_rotation = Rotation(0.10663, -0.0844432, 0.629197)
	local pivot_head_translation = Vector3(9, 15, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_m14.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_m14.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_m14.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -12, 0)
	self.stances.new_m14.standard.vel_overshot.yaw_neg = -5
	self.stances.new_m14.standard.vel_overshot.yaw_pos = 5
	self.stances.new_m14.standard.vel_overshot.pitch_neg = 5
	self.stances.new_m14.standard.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 10, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_m14.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_m14.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_m14.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -5, 0)
	self.stances.new_m14.steelsight.vel_overshot.yaw_neg = -4
	self.stances.new_m14.steelsight.vel_overshot.yaw_pos = 4
	self.stances.new_m14.steelsight.vel_overshot.pitch_neg = 3
	self.stances.new_m14.steelsight.vel_overshot.pitch_pos = -3
	local pivot_head_translation = Vector3(8, 14, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_m14.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_m14.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_m14.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -12, 0)
	self.stances.new_m14.crouched.vel_overshot.yaw_neg = -6
	self.stances.new_m14.crouched.vel_overshot.yaw_pos = 6
	self.stances.new_m14.crouched.vel_overshot.pitch_neg = 4
	self.stances.new_m14.crouched.vel_overshot.pitch_pos = -4
	self.stances.mp9 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7095, 13.7143, -7.28688)
	local pivot_shoulder_rotation = Rotation(0.106632, -0.0844457, 0.629207)
	local pivot_head_translation = Vector3(7, 10, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mp9.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mp9.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mp9.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.mp9.standard.vel_overshot.yaw_neg = 10
	self.stances.mp9.standard.vel_overshot.yaw_pos = -10
	self.stances.mp9.standard.vel_overshot.pitch_neg = -5
	self.stances.mp9.standard.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(0, 10, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mp9.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mp9.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mp9.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -5, 0)
	self.stances.mp9.steelsight.vel_overshot.yaw_neg = 4
	self.stances.mp9.steelsight.vel_overshot.yaw_pos = -4
	self.stances.mp9.steelsight.vel_overshot.pitch_neg = -8
	self.stances.mp9.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(6, 8, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mp9.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mp9.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mp9.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.deagle = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.51744, 40.6489, -2.66934)
	local pivot_shoulder_rotation = Rotation(0.100008, -0.687698, 0.630289)
	local pivot_head_translation = Vector3(6, 30, -2.25)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.deagle.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.deagle.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.deagle.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.deagle.standard.vel_overshot.yaw_neg = -5
	self.stances.deagle.standard.vel_overshot.yaw_pos = 5
	self.stances.deagle.standard.vel_overshot.pitch_neg = 4
	self.stances.deagle.standard.vel_overshot.pitch_pos = -4
	local pivot_head_translation = Vector3(-0.02, 35, 0.25)
	local pivot_head_rotation = Rotation(0, 0.5, 0)
	self.stances.deagle.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.deagle.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.deagle.steelsight.zoom_fov = false
	self.stances.deagle.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.deagle.steelsight.vel_overshot.yaw_neg = -4
	self.stances.deagle.steelsight.vel_overshot.yaw_pos = 2
	self.stances.deagle.steelsight.vel_overshot.pitch_neg = 2
	self.stances.deagle.steelsight.vel_overshot.pitch_pos = -2
	local pivot_head_translation = Vector3(5, 28, -2.75)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.deagle.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.deagle.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.deagle.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.new_mp5 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7414, 18.4543, -3.29175)
	local pivot_shoulder_rotation = Rotation(0.106934, -0.220015, 0.629729)
	local pivot_head_translation = Vector3(8, 14, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_mp5.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_mp5.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_mp5.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.new_mp5.standard.vel_overshot.yaw_neg = 10
	self.stances.new_mp5.standard.vel_overshot.yaw_pos = -10
	self.stances.new_mp5.standard.vel_overshot.pitch_neg = -5
	self.stances.new_mp5.standard.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(0, 10, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_mp5.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_mp5.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_mp5.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -5, 0)
	self.stances.new_mp5.steelsight.vel_overshot.yaw_neg = 4
	self.stances.new_mp5.steelsight.vel_overshot.yaw_pos = -4
	self.stances.new_mp5.steelsight.vel_overshot.pitch_neg = -8
	self.stances.new_mp5.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(7, 13, -3.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_mp5.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_mp5.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_mp5.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.colt_1911 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.51072, 41.1823, -3.19592)
	local pivot_shoulder_rotation = Rotation(0.0999825, -0.688529, 0.630296)
	local pivot_head_translation = Vector3(5, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.colt_1911.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.colt_1911.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.colt_1911.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.colt_1911.standard.vel_overshot.yaw_neg = 10
	self.stances.colt_1911.standard.vel_overshot.yaw_pos = -10
	self.stances.colt_1911.standard.vel_overshot.pitch_neg = -8
	self.stances.colt_1911.standard.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(0, 42, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.colt_1911.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.colt_1911.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.colt_1911.steelsight.zoom_fov = false
	self.stances.colt_1911.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.colt_1911.steelsight.vel_overshot.yaw_neg = 8
	self.stances.colt_1911.steelsight.vel_overshot.yaw_pos = -8
	self.stances.colt_1911.steelsight.vel_overshot.pitch_neg = -12
	self.stances.colt_1911.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 30, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.colt_1911.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.colt_1911.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.colt_1911.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.mac10 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.66375, 35.7106, -2.84375)
	local pivot_shoulder_rotation = Rotation(0.110006, -0.898579, 0.630296)
	local pivot_head_translation = Vector3(8, 22, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mac10.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mac10.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mac10.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.mac10.standard.vel_overshot.yaw_neg = 15
	self.stances.mac10.standard.vel_overshot.yaw_pos = -15
	self.stances.mac10.standard.vel_overshot.pitch_neg = -15
	self.stances.mac10.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 23, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mac10.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mac10.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mac10.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.mac10.steelsight.vel_overshot.yaw_neg = 15
	self.stances.mac10.steelsight.vel_overshot.yaw_pos = -15
	self.stances.mac10.steelsight.vel_overshot.pitch_neg = -18
	self.stances.mac10.steelsight.vel_overshot.pitch_pos = 18
	local pivot_head_translation = Vector3(6, 18, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mac10.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mac10.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mac10.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.r870 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7362, 12.88858, -4.29568)
	local pivot_shoulder_rotation = Rotation(0.106618, -0.0844415, 0.629205)
	local pivot_head_translation = Vector3(7.5, 12, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.r870.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.r870.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.r870.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.r870.standard.vel_overshot.yaw_neg = -5
	self.stances.r870.standard.vel_overshot.yaw_pos = 3
	self.stances.r870.standard.vel_overshot.pitch_neg = 2
	self.stances.r870.standard.vel_overshot.pitch_pos = -3
	local pivot_head_translation = Vector3(-0.01, 15, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.r870.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.r870.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.r870.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.r870.steelsight.vel_overshot.yaw_neg = -3
	self.stances.r870.steelsight.vel_overshot.yaw_pos = 3
	self.stances.r870.steelsight.vel_overshot.pitch_neg = 2
	self.stances.r870.steelsight.vel_overshot.pitch_pos = -2
	local pivot_head_translation = Vector3(6.5, 11, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.r870.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.r870.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.r870.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.glock_17 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.48582, 38.7727, -5.49358)
	local pivot_shoulder_rotation = Rotation(0.100007, -0.687692, 0.630291)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.glock_17.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.glock_17.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.glock_17.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.glock_17.standard.vel_overshot.yaw_neg = 10
	self.stances.glock_17.standard.vel_overshot.yaw_pos = -10
	self.stances.glock_17.standard.vel_overshot.pitch_neg = -13
	self.stances.glock_17.standard.vel_overshot.pitch_pos = 13
	local pivot_head_translation = Vector3(0, 35, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.glock_17.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.glock_17.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.glock_17.steelsight.FOV = self.stances.glock_17.standard.FOV
	self.stances.glock_17.steelsight.zoom_fov = false
	self.stances.glock_17.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.glock_17.steelsight.vel_overshot.yaw_neg = 8
	self.stances.glock_17.steelsight.vel_overshot.yaw_pos = -8
	self.stances.glock_17.steelsight.vel_overshot.pitch_neg = -8
	self.stances.glock_17.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(3, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.glock_17.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.glock_17.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.glock_17.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.huntsman = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6562, 32.9715, -6.73279)
	local pivot_shoulder_rotation = Rotation(0.106667, -0.0844876, 0.629223)
	local pivot_head_translation = Vector3(7, 22, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.huntsman.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.huntsman.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.huntsman.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	local pivot_head_translation = Vector3(0, 20, -0.4)
	local pivot_head_rotation = Rotation(0, 1, 0)
	self.stances.huntsman.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.huntsman.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.huntsman.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.huntsman.steelsight.vel_overshot.yaw_neg = 12
	self.stances.huntsman.steelsight.vel_overshot.yaw_pos = -12
	self.stances.huntsman.steelsight.vel_overshot.pitch_neg = -12
	self.stances.huntsman.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 17, -2)
	local pivot_head_rotation = Rotation(-2, -2, 0)
	self.stances.huntsman.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.huntsman.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.huntsman.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.b92fs = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.50078, 40.9225, -4.15296)
	local pivot_shoulder_rotation = Rotation(0.100096, -0.687684, 0.630857)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.b92fs.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.b92fs.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.b92fs.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	local pivot_head_translation = Vector3(0, 37, 0.1)
	local pivot_head_rotation = Rotation(0, 0.5, 0)
	self.stances.b92fs.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.b92fs.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.b92fs.steelsight.zoom_fov = false
	self.stances.b92fs.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.b92fs.steelsight.vel_overshot.yaw_neg = 5
	self.stances.b92fs.steelsight.vel_overshot.yaw_pos = -5
	self.stances.b92fs.steelsight.vel_overshot.pitch_neg = -12
	self.stances.b92fs.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(3, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.b92fs.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.b92fs.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.b92fs.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.new_raging_bull = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.48834, 43.8612, -2.19366)
	local pivot_shoulder_rotation = Rotation(0.0999871, -0.68716, 0.629919)
	local pivot_head_translation = Vector3(7, 33, -3.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_raging_bull.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_raging_bull.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_raging_bull.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.new_raging_bull.standard.vel_overshot.yaw_neg = -5
	self.stances.new_raging_bull.standard.vel_overshot.yaw_pos = 2
	self.stances.new_raging_bull.standard.vel_overshot.pitch_neg = 5
	self.stances.new_raging_bull.standard.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 36, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_raging_bull.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_raging_bull.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_raging_bull.steelsight.zoom_fov = false
	self.stances.new_raging_bull.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.new_raging_bull.steelsight.vel_overshot.yaw_neg = -5
	self.stances.new_raging_bull.steelsight.vel_overshot.yaw_pos = 2
	self.stances.new_raging_bull.steelsight.vel_overshot.pitch_neg = 5
	self.stances.new_raging_bull.steelsight.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(6, 32, -4.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.new_raging_bull.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.new_raging_bull.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.new_raging_bull.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self:_init_saw()
	self:_init_serbu()
	self:_init_usp()
	self:_init_g22c()
	self:_init_judge()
	self:_init_m45()
	self:_init_s552()
	self:_init_ppk()
	self:_init_mp7()
	self:_init_scar()
	self:_init_p226()
	self:_init_hk21()
	self:_init_m249()
	self:_init_rpk()
	self:_init_m95()
	self:_init_msr()
	self:_init_r93()
	self:_init_akm_gold()
	self:_init_fal()
	self:_init_benelli()
	self:_init_striker()
	self:_init_ksg()
	self:_init_scorpion()
	self:_init_tec9()
	self:_init_uzi()
	self:_init_gre_m79()
	self:_init_g3()
	self:_init_galil()
	self:_init_famas()
	self:_init_x_1911()
	self:_init_x_b92fs()
	self:_init_x_deagle()
	self:_init_g26()
	self:_init_spas12()
	self:_init_mg42()
	self:_init_c96()
	self:_init_sterling()
	self:_init_mosin()
	self:_init_m1928()
	self:_init_hs2000()
	self:_init_vhs()
	self:_init_l85a2()
	self:_init_hs2000()
	self:_init_vhs()
	self:_init_m134()
	self:_init_rpg7()
	self:_init_cobray()
	self:_init_b682()
	self:_init_x_g22c()
	self:_init_x_g17()
	self:_init_x_usp()
	self:_init_flamethrower_mk2()
	self:_init_m32()
	self:_init_aa12()
	self:_init_peacemaker()
	self:_init_winchester1874()
	self:_init_plainsrider()
	self:_init_mateba()
	self:_init_asval()
	self:_init_sub2000()
	self:_init_wa2000()
	self:_init_polymer()
	self:_init_hunter()
	self:_init_baka()
	self:_init_arblast()
	self:_init_frankish()
	self:_init_long()
end

function PlayerTweakData:_init_hs2000()
	self.stances.hs2000 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.48582, 38.7727, -5.49358)
	local pivot_shoulder_rotation = Rotation(0.100007, -0.687692, 0.630291)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hs2000.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hs2000.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hs2000.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.hs2000.standard.vel_overshot.yaw_neg = 10
	self.stances.hs2000.standard.vel_overshot.yaw_pos = -10
	self.stances.hs2000.standard.vel_overshot.pitch_neg = -13
	self.stances.hs2000.standard.vel_overshot.pitch_pos = 13
	local pivot_head_translation = Vector3(0, 35, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hs2000.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hs2000.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hs2000.steelsight.FOV = self.stances.hs2000.standard.FOV
	self.stances.hs2000.steelsight.zoom_fov = false
	self.stances.hs2000.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.hs2000.steelsight.vel_overshot.yaw_neg = 8
	self.stances.hs2000.steelsight.vel_overshot.yaw_pos = -8
	self.stances.hs2000.steelsight.vel_overshot.pitch_neg = -8
	self.stances.hs2000.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(4, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hs2000.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hs2000.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hs2000.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
end

function PlayerTweakData:_init_mg42()
	self.stances.mg42 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.713, 47.8277, 0.873785)
	local pivot_shoulder_rotation = Rotation(0.10662, -0.0844545, 0.629209)
	local pivot_head_translation = Vector3(8, 46, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mg42.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mg42.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mg42.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.mg42.standard.vel_overshot.yaw_neg = 10
	self.stances.mg42.standard.vel_overshot.yaw_pos = -10
	self.stances.mg42.standard.vel_overshot.pitch_neg = -10
	self.stances.mg42.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(3, 40, -2)
	local pivot_head_rotation = Rotation(0, 0, -2)
	self.stances.mg42.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mg42.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mg42.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -58, 0)
	self.stances.mg42.steelsight.vel_overshot.yaw_neg = 10
	self.stances.mg42.steelsight.vel_overshot.yaw_pos = -10
	self.stances.mg42.steelsight.vel_overshot.pitch_neg = -10
	self.stances.mg42.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6, 44, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mg42.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mg42.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mg42.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -55, 0)
	self.stances.mg42.bipod = {
		shoulders = {},
		vel_overshot = {}
	}
	local pivot_head_translation = Vector3(0, 0, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mg42.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mg42.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mg42.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
	self.stances.mg42.bipod.vel_overshot.yaw_neg = 0
	self.stances.mg42.bipod.vel_overshot.yaw_pos = 0
	self.stances.mg42.bipod.vel_overshot.pitch_neg = 0
	self.stances.mg42.bipod.vel_overshot.pitch_pos = 0
	self.stances.mg42.bipod.FOV = 50
end

function PlayerTweakData:_init_c96()
	self.stances.c96 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.49335, 44.033, -4.32192)
	local pivot_shoulder_rotation = Rotation(0.100005, -0.687696, 0.630292)
	local pivot_head_translation = Vector3(8, 36, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.c96.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.c96.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.c96.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.c96.standard.vel_overshot.yaw_neg = 10
	self.stances.c96.standard.vel_overshot.yaw_pos = -10
	self.stances.c96.standard.vel_overshot.pitch_neg = -10
	self.stances.c96.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.c96.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.c96.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.c96.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -58, 0)
	self.stances.c96.steelsight.vel_overshot.yaw_neg = 10
	self.stances.c96.steelsight.vel_overshot.yaw_pos = -10
	self.stances.c96.steelsight.vel_overshot.pitch_neg = -10
	self.stances.c96.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6, 34, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.c96.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.c96.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.c96.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -55, 0)
end

function PlayerTweakData:_init_sterling()
	self.stances.sterling = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(7.87354, 11.0128, -5.21259)
	local pivot_shoulder_rotation = Rotation(-0.0789313, 0.143449, -7.47492)
	local pivot_head_translation = Vector3(6, 11, -5)
	local pivot_head_rotation = Rotation(0, 0, -15)
	self.stances.sterling.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.sterling.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.sterling.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.sterling.standard.vel_overshot.yaw_neg = 10
	self.stances.sterling.standard.vel_overshot.yaw_pos = -10
	self.stances.sterling.standard.vel_overshot.pitch_neg = -10
	self.stances.sterling.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 20, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.sterling.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.sterling.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.sterling.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -38, 0)
	self.stances.sterling.steelsight.vel_overshot.yaw_neg = 10
	self.stances.sterling.steelsight.vel_overshot.yaw_pos = -10
	self.stances.sterling.steelsight.vel_overshot.pitch_neg = -10
	self.stances.sterling.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(5, 12, -4)
	local pivot_head_rotation = Rotation(0, 0, -13)
	self.stances.sterling.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.sterling.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.sterling.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
end

function PlayerTweakData:_init_mosin()
	self.stances.mosin = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.73391, 40.3748, -4.10975)
	local pivot_shoulder_rotation = Rotation(0.106649, -0.0843498, 0.629165)
	local pivot_head_translation = Vector3(8, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mosin.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mosin.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mosin.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.mosin.standard.vel_overshot.yaw_neg = 15
	self.stances.mosin.standard.vel_overshot.yaw_pos = -15
	self.stances.mosin.standard.vel_overshot.pitch_neg = -15
	self.stances.mosin.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 35, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mosin.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mosin.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mosin.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.mosin.steelsight.vel_overshot.yaw_neg = 0
	self.stances.mosin.steelsight.vel_overshot.yaw_pos = 0
	self.stances.mosin.steelsight.vel_overshot.pitch_neg = 0
	self.stances.mosin.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(8, 35, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mosin.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mosin.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mosin.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_g26()
	self.stances.g26 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.49051, 38.6474, -5.09399)
	local pivot_shoulder_rotation = Rotation(0.0999949, -0.687702, 0.630304)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g26.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g26.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g26.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.g26.standard.vel_overshot.yaw_neg = 10
	self.stances.g26.standard.vel_overshot.yaw_pos = -10
	self.stances.g26.standard.vel_overshot.pitch_neg = -13
	self.stances.g26.standard.vel_overshot.pitch_pos = 13
	local pivot_head_translation = Vector3(0, 37, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g26.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g26.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g26.steelsight.FOV = self.stances.g26.standard.FOV
	self.stances.g26.steelsight.zoom_fov = false
	self.stances.g26.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.g26.steelsight.vel_overshot.yaw_neg = 8
	self.stances.g26.steelsight.vel_overshot.yaw_pos = -8
	self.stances.g26.steelsight.vel_overshot.pitch_neg = -8
	self.stances.g26.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(4, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g26.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g26.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g26.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_x_1911()
	self.stances.x_1911 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.4939, 42.8789, -1.11447)
	local pivot_shoulder_rotation = Rotation(-0.347954, 0.253161, 0.281029)
	local pivot_head_translation = Vector3(10.95, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_1911.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_1911.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_1911.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10.95, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_1911.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_1911.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_1911.steelsight.zoom_fov = false
	self.stances.x_1911.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.x_1911.steelsight.vel_overshot.yaw_neg = 5
	self.stances.x_1911.steelsight.vel_overshot.yaw_pos = -5
	self.stances.x_1911.steelsight.vel_overshot.pitch_neg = -12
	self.stances.x_1911.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_1911.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_1911.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_1911.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_x_b92fs()
	self.stances.x_b92fs = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.1926, 42.656, -1.92934)
	local pivot_shoulder_rotation = Rotation(-0.291899, 0.237935, -0.510313)
	local pivot_head_translation = Vector3(11, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_b92fs.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_b92fs.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_b92fs.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_b92fs.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_b92fs.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_b92fs.steelsight.zoom_fov = false
	self.stances.x_b92fs.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.x_b92fs.steelsight.vel_overshot.yaw_neg = 5
	self.stances.x_b92fs.steelsight.vel_overshot.yaw_pos = -5
	self.stances.x_b92fs.steelsight.vel_overshot.pitch_neg = -12
	self.stances.x_b92fs.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_b92fs.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_b92fs.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_b92fs.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_x_deagle()
	self.stances.x_deagle = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.4931, 42.3369, -0.596629)
	local pivot_shoulder_rotation = Rotation(-0.34809, 0.254047, 0.28066)
	local pivot_head_translation = Vector3(10.95, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_deagle.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_deagle.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_deagle.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10.95, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_deagle.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_deagle.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_deagle.steelsight.zoom_fov = false
	self.stances.x_deagle.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.x_deagle.steelsight.vel_overshot.yaw_neg = 5
	self.stances.x_deagle.steelsight.vel_overshot.yaw_pos = -5
	self.stances.x_deagle.steelsight.vel_overshot.pitch_neg = -12
	self.stances.x_deagle.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_deagle.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_deagle.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_deagle.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_spas12()
	self.stances.spas12 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6588, 45.1588, -4.51644)
	local pivot_shoulder_rotation = Rotation(0.106619, -0.0844517, 0.629206)
	local pivot_head_translation = Vector3(8, 44, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.spas12.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.spas12.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.spas12.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.spas12.standard.vel_overshot.yaw_neg = 10
	self.stances.spas12.standard.vel_overshot.yaw_pos = -10
	self.stances.spas12.standard.vel_overshot.pitch_neg = -10
	self.stances.spas12.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 45, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.spas12.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.spas12.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.spas12.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -58, 0)
	self.stances.spas12.steelsight.vel_overshot.yaw_neg = 10
	self.stances.spas12.steelsight.vel_overshot.yaw_pos = -10
	self.stances.spas12.steelsight.vel_overshot.pitch_neg = -10
	self.stances.spas12.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6, 43, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.spas12.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.spas12.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.spas12.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -55, 0)
end

function PlayerTweakData:_init_saw()
	self.stances.saw = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.1399, 11.1007, -9.93544)
	local pivot_shoulder_rotation = Rotation(0.145081, 4.12987, 0.620396)
	local pivot_head_translation = Vector3(10, 3, -7)
	local pivot_head_rotation = Rotation(3, 3, 0)
	self.stances.saw.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.saw.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.saw.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
	self.stances.saw.standard.vel_overshot.yaw_neg = -5
	self.stances.saw.standard.vel_overshot.yaw_pos = 5
	self.stances.saw.standard.vel_overshot.pitch_neg = 5
	self.stances.saw.standard.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(8, 2, -5)
	local pivot_head_rotation = Rotation(3, 3, 0)
	self.stances.saw.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.saw.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.saw.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
	self.stances.saw.steelsight.zoom_fov = false
	self.stances.saw.steelsight.vel_overshot.yaw_neg = -5
	self.stances.saw.steelsight.vel_overshot.yaw_pos = 5
	self.stances.saw.steelsight.vel_overshot.pitch_neg = 5
	self.stances.saw.steelsight.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(9, 2, -8)
	local pivot_head_rotation = Rotation(3, 3, 0)
	self.stances.saw.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.saw.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.saw.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
end

function PlayerTweakData:_init_serbu()
	self.stances.serbu = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.71, 18.7035, -4.30218)
	local pivot_shoulder_rotation = Rotation(0.106838, -0.0844692, 0.629273)
	local pivot_head_translation = Vector3(7, 15, -3.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.serbu.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.serbu.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.serbu.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.serbu.standard.vel_overshot.yaw_neg = 6
	self.stances.serbu.standard.vel_overshot.yaw_pos = -6
	self.stances.serbu.standard.vel_overshot.pitch_neg = -4
	self.stances.serbu.standard.vel_overshot.pitch_pos = 4
	local pivot_head_translation = Vector3(0, 24, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.serbu.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.serbu.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.serbu.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.serbu.steelsight.vel_overshot.yaw_neg = 5
	self.stances.serbu.steelsight.vel_overshot.yaw_pos = -4
	self.stances.serbu.steelsight.vel_overshot.pitch_neg = -5
	self.stances.serbu.steelsight.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(6, 17, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.serbu.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.serbu.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.serbu.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_usp()
	self.stances.usp = deep_clone(self.stances.colt_1911)
	local pivot_shoulder_translation = Vector3(8.51087, 41.182, -3.19589)
	local pivot_shoulder_rotation = Rotation(0.0996996, -0.686868, 0.630304)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.usp.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.usp.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.usp.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.usp.standard.vel_overshot.yaw_neg = 10
	self.stances.usp.standard.vel_overshot.yaw_pos = -10
	self.stances.usp.standard.vel_overshot.pitch_neg = -8
	self.stances.usp.standard.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(0, 38, 0.1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.usp.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.usp.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.usp.steelsight.zoom_fov = false
	self.stances.usp.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.usp.steelsight.vel_overshot.yaw_neg = 8
	self.stances.usp.steelsight.vel_overshot.yaw_pos = -8
	self.stances.usp.steelsight.vel_overshot.pitch_neg = -12
	self.stances.usp.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(3, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.usp.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.usp.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.usp.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_g22c()
	self.stances.g22c = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.49051, 38.6474, -5.09399)
	local pivot_shoulder_rotation = Rotation(0.0999949, -0.687702, 0.630304)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g22c.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g22c.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g22c.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.g22c.standard.vel_overshot.yaw_neg = 10
	self.stances.g22c.standard.vel_overshot.yaw_pos = -10
	self.stances.g22c.standard.vel_overshot.pitch_neg = -13
	self.stances.g22c.standard.vel_overshot.pitch_pos = 13
	local pivot_head_translation = Vector3(-0.005, 37, 0.3)
	local pivot_head_rotation = Rotation(0, 0.3, 0)
	self.stances.g22c.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g22c.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g22c.steelsight.FOV = self.stances.g22c.standard.FOV
	self.stances.g22c.steelsight.zoom_fov = false
	self.stances.g22c.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.g22c.steelsight.vel_overshot.yaw_neg = 8
	self.stances.g22c.steelsight.vel_overshot.yaw_pos = -8
	self.stances.g22c.steelsight.vel_overshot.pitch_neg = -8
	self.stances.g22c.steelsight.vel_overshot.pitch_pos = 8
	local pivot_head_translation = Vector3(4, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g22c.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g22c.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g22c.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_judge()
	self.stances.judge = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.51217, 43.8759, -2.44869)
	local pivot_shoulder_rotation = Rotation(0.0994018, -0.689525, 0.618385)
	local pivot_head_translation = Vector3(7, 31, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.judge.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.judge.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.judge.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.judge.standard.vel_overshot.yaw_neg = -5
	self.stances.judge.standard.vel_overshot.yaw_pos = 2
	self.stances.judge.standard.vel_overshot.pitch_neg = 5
	self.stances.judge.standard.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 36, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.judge.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.judge.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.judge.steelsight.zoom_fov = false
	self.stances.judge.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -35, 0)
	self.stances.judge.steelsight.vel_overshot.yaw_neg = -5
	self.stances.judge.steelsight.vel_overshot.yaw_pos = 2
	self.stances.judge.steelsight.vel_overshot.pitch_neg = 5
	self.stances.judge.steelsight.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(6, 30, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.judge.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.judge.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.judge.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_m45()
	self.stances.m45 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6536, 33.375, -6.99766)
	local pivot_shoulder_rotation = Rotation(0.106609, -0.0844488, 0.629209)
	local pivot_head_translation = Vector3(7, 31, -4)
	local pivot_head_rotation = Rotation(0.4, 0.4, 0)
	self.stances.m45.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m45.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m45.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.m45.standard.vel_overshot.yaw_neg = 15
	self.stances.m45.standard.vel_overshot.yaw_pos = -15
	self.stances.m45.standard.vel_overshot.pitch_neg = -15
	self.stances.m45.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 23, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m45.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m45.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m45.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.m45.steelsight.vel_overshot.yaw_neg = 10
	self.stances.m45.steelsight.vel_overshot.yaw_pos = -10
	self.stances.m45.steelsight.vel_overshot.pitch_neg = -10
	self.stances.m45.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(4, 26, -2)
	local pivot_head_rotation = Rotation(0.2, 0.2, 0)
	self.stances.m45.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m45.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m45.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_s552()
	self.stances.s552 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6642, 22.0789, -3.95194)
	local pivot_shoulder_rotation = Rotation(0.106285, -0.08453, 0.630167)
	local pivot_head_translation = Vector3(8.5, 14, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.s552.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.s552.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.s552.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.s552.standard.vel_overshot.yaw_neg = 12
	self.stances.s552.standard.vel_overshot.yaw_pos = -12
	self.stances.s552.standard.vel_overshot.pitch_neg = -12
	self.stances.s552.standard.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(0, 12, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.s552.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.s552.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.s552.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.s552.steelsight.vel_overshot.yaw_neg = 10
	self.stances.s552.steelsight.vel_overshot.yaw_pos = -10
	self.stances.s552.steelsight.vel_overshot.pitch_neg = -10
	self.stances.s552.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7.5, 13, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.s552.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.s552.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.s552.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_ppk()
	self.stances.ppk = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.49608, 40.6427, -4.65654)
	local pivot_shoulder_rotation = Rotation(0.0989007, -0.686519, 0.631465)
	local pivot_head_translation = Vector3(5, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ppk.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ppk.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ppk.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	local pivot_head_translation = Vector3(0, 37, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ppk.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ppk.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ppk.steelsight.zoom_fov = false
	self.stances.ppk.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.ppk.steelsight.vel_overshot.yaw_neg = 5
	self.stances.ppk.steelsight.vel_overshot.yaw_pos = -5
	self.stances.ppk.steelsight.vel_overshot.pitch_neg = -12
	self.stances.ppk.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 30, -4.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ppk.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ppk.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ppk.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_mp7()
	self.stances.mp7 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7255, 18.222, -5.70686)
	local pivot_shoulder_rotation = Rotation(0.106402, -0.084293, 0.629528)
	local pivot_head_translation = Vector3(7.5, 14, -3.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mp7.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mp7.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mp7.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.mp7.standard.vel_overshot.yaw_neg = 15
	self.stances.mp7.standard.vel_overshot.yaw_pos = -15
	self.stances.mp7.standard.vel_overshot.pitch_neg = -15
	self.stances.mp7.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 14, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mp7.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mp7.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mp7.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.mp7.steelsight.vel_overshot.yaw_neg = 10
	self.stances.mp7.steelsight.vel_overshot.yaw_pos = -10
	self.stances.mp7.steelsight.vel_overshot.pitch_neg = -10
	self.stances.mp7.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6.5, 12, -4.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mp7.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mp7.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mp7.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_scar()
	self.stances.scar = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7779, 19.512, 0.0239211)
	local pivot_shoulder_rotation = Rotation(0.107705, -0.0837022, 0.629766)
	local pivot_head_translation = Vector3(8, 16.5, -1)
	local pivot_head_rotation = Rotation(0.4, 0.4, 0)
	self.stances.scar.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.scar.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.scar.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.scar.standard.vel_overshot.yaw_neg = 10
	self.stances.scar.standard.vel_overshot.yaw_pos = -10
	self.stances.scar.standard.vel_overshot.pitch_neg = -10
	self.stances.scar.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 12, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.scar.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.scar.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.scar.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.scar.steelsight.vel_overshot.yaw_neg = 10
	self.stances.scar.steelsight.vel_overshot.yaw_pos = -10
	self.stances.scar.steelsight.vel_overshot.pitch_neg = -10
	self.stances.scar.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 15.5, -2)
	local pivot_head_rotation = Rotation(0.2, 0.2, 0)
	self.stances.scar.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.scar.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.scar.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_p226()
	self.stances.p226 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.5121, 38.8014, -3.46065)
	local pivot_shoulder_rotation = Rotation(0.10024, -0.688283, 0.631346)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.p226.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.p226.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.p226.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	local pivot_head_translation = Vector3(0, 37, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.p226.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.p226.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.p226.steelsight.zoom_fov = false
	self.stances.p226.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.p226.steelsight.vel_overshot.yaw_neg = 5
	self.stances.p226.steelsight.vel_overshot.yaw_pos = -5
	self.stances.p226.steelsight.vel_overshot.pitch_neg = -12
	self.stances.p226.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.p226.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.p226.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.p226.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_hk21()
	self.stances.hk21 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.59464, 11.3996, -3.26142)
	local pivot_shoulder_rotation = Rotation(7.08051E-6, 0.00559065, 3.07211E-4)
	local pivot_head_translation = Vector3(8, 10, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hk21.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hk21.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hk21.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.hk21.standard.vel_overshot.yaw_neg = 15
	self.stances.hk21.standard.vel_overshot.yaw_pos = -15
	self.stances.hk21.standard.vel_overshot.pitch_neg = -15
	self.stances.hk21.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(8, 10, -1)
	local pivot_head_rotation = Rotation(0.2, 0.2, -8)
	self.stances.hk21.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hk21.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hk21.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.hk21.steelsight.vel_overshot.yaw_neg = 10
	self.stances.hk21.steelsight.vel_overshot.yaw_pos = -10
	self.stances.hk21.steelsight.vel_overshot.pitch_neg = -10
	self.stances.hk21.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 9, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hk21.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hk21.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hk21.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.hk21.bipod = {
		shoulders = {},
		vel_overshot = {}
	}
	local pivot_head_translation = Vector3(0, 0, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hk21.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hk21.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hk21.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
	self.stances.hk21.bipod.vel_overshot.yaw_neg = 0
	self.stances.hk21.bipod.vel_overshot.yaw_pos = 0
	self.stances.hk21.bipod.vel_overshot.pitch_neg = 0
	self.stances.hk21.bipod.vel_overshot.pitch_pos = 0
	self.stances.hk21.bipod.FOV = 50
	self.stances.hk21.bipod.shakers = {}
	self.stances.hk21.bipod.shakers.breathing = {}
	self.stances.hk21.bipod.shakers.breathing.amplitude = 0
end

function PlayerTweakData:_init_m249()
	self.stances.m249 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7806, 4.38612, -0.718837)
	local pivot_shoulder_rotation = Rotation(0.106596, -0.0844502, 0.629187)
	local pivot_head_translation = Vector3(10, 14, -3)
	local pivot_head_rotation = Rotation(0.4, 0.4, 0)
	self.stances.m249.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m249.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m249.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.m249.standard.vel_overshot.yaw_neg = 15
	self.stances.m249.standard.vel_overshot.yaw_pos = -15
	self.stances.m249.standard.vel_overshot.pitch_neg = -15
	self.stances.m249.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(10, 12, -2)
	local pivot_head_rotation = Rotation(0, 0, -5)
	self.stances.m249.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m249.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m249.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.m249.steelsight.vel_overshot.yaw_neg = 10
	self.stances.m249.steelsight.vel_overshot.yaw_pos = -10
	self.stances.m249.steelsight.vel_overshot.pitch_neg = -10
	self.stances.m249.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6, 12, -1)
	local pivot_head_rotation = Rotation(0.2, 0.2, 0)
	self.stances.m249.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m249.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m249.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.m249.bipod = {
		shoulders = {},
		vel_overshot = {}
	}
	local pivot_head_translation = Vector3(0, 6, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m249.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m249.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m249.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
	self.stances.m249.bipod.vel_overshot.yaw_neg = 0
	self.stances.m249.bipod.vel_overshot.yaw_pos = 0
	self.stances.m249.bipod.vel_overshot.pitch_neg = 0
	self.stances.m249.bipod.vel_overshot.pitch_pos = 0
	self.stances.m249.bipod.FOV = 50
	self.stances.m249.bipod.shakers = {}
	self.stances.m249.bipod.shakers.breathing = {}
	self.stances.m249.bipod.shakers.breathing.amplitude = 0
end

function PlayerTweakData:_init_rpk()
	self.stances.rpk = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6725, 27.7166, -4.93564)
	local pivot_shoulder_rotation = Rotation(0.1067, -0.0850111, 0.629008)
	local pivot_head_translation = Vector3(10, 35, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.rpk.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpk.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpk.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.rpk.standard.vel_overshot.yaw_neg = 15
	self.stances.rpk.standard.vel_overshot.yaw_pos = -15
	self.stances.rpk.standard.vel_overshot.pitch_neg = -15
	self.stances.rpk.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(6, 30, -1)
	local pivot_head_rotation = Rotation(0, 0, -5)
	self.stances.rpk.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpk.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpk.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.rpk.steelsight.vel_overshot.yaw_neg = 10
	self.stances.rpk.steelsight.vel_overshot.yaw_pos = -10
	self.stances.rpk.steelsight.vel_overshot.pitch_neg = -10
	self.stances.rpk.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(8, 35, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.rpk.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpk.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpk.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.rpk.bipod = {
		shoulders = {},
		vel_overshot = {}
	}
	local pivot_head_translation = Vector3(0, 0, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.rpk.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpk.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpk.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, 0, 0)
	self.stances.rpk.bipod.vel_overshot.yaw_neg = 0
	self.stances.rpk.bipod.vel_overshot.yaw_pos = 0
	self.stances.rpk.bipod.vel_overshot.pitch_neg = 0
	self.stances.rpk.bipod.vel_overshot.pitch_pos = 0
	self.stances.rpk.bipod.FOV = 50
end

function PlayerTweakData:_init_m95()
	self.stances.m95 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(12.9429, 21.4699, -2.48515)
	local pivot_shoulder_rotation = Rotation(0.113195, 0.518822, 0.628052)
	local pivot_head_translation = Vector3(11, 25, -4.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m95.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m95.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m95.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.m95.standard.vel_overshot.yaw_neg = 15
	self.stances.m95.standard.vel_overshot.yaw_pos = -15
	self.stances.m95.standard.vel_overshot.pitch_neg = -15
	self.stances.m95.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 0, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m95.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m95.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m95.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.m95.steelsight.vel_overshot.yaw_neg = 0
	self.stances.m95.steelsight.vel_overshot.yaw_pos = 0
	self.stances.m95.steelsight.vel_overshot.pitch_neg = 0
	self.stances.m95.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(10, 23, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m95.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m95.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m95.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_msr()
	self.stances.msr = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.74673, 40.7228, -3.34979)
	local pivot_shoulder_rotation = Rotation(0.106658, -0.0843346, 0.62918)
	local pivot_head_translation = Vector3(13, 34, -4.75)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.msr.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.msr.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.msr.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.msr.standard.vel_overshot.yaw_neg = 15
	self.stances.msr.standard.vel_overshot.yaw_pos = -15
	self.stances.msr.standard.vel_overshot.pitch_neg = -15
	self.stances.msr.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 35, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.msr.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.msr.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.msr.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.msr.steelsight.vel_overshot.yaw_neg = 0
	self.stances.msr.steelsight.vel_overshot.yaw_pos = 0
	self.stances.msr.steelsight.vel_overshot.pitch_neg = 0
	self.stances.msr.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(11.5, 37, -4.75)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.msr.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.msr.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.msr.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_r93()
	self.stances.r93 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6978, 45.3183, -4.51382)
	local pivot_shoulder_rotation = Rotation(0.107839, -0.0834037, 0.628987)
	local pivot_head_translation = Vector3(10, 35, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.r93.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.r93.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.r93.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.r93.standard.vel_overshot.yaw_neg = 15
	self.stances.r93.standard.vel_overshot.yaw_pos = -15
	self.stances.r93.standard.vel_overshot.pitch_neg = -15
	self.stances.r93.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.r93.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.r93.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.r93.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.r93.steelsight.vel_overshot.yaw_neg = 0
	self.stances.r93.steelsight.vel_overshot.yaw_pos = 0
	self.stances.r93.steelsight.vel_overshot.pitch_neg = 0
	self.stances.r93.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(8, 35, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.r93.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.r93.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.r93.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_akm_gold()
	self.stances.akm_gold = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6677, 40.3885, -4.94216)
	local pivot_shoulder_rotation = Rotation(0.10664, -0.0844285, 0.629212)
	local pivot_head_translation = Vector3(8, 33, -2.5)
	local pivot_head_rotation = Rotation(0.4, 0.4, 0)
	self.stances.akm_gold.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akm_gold.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akm_gold.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akm_gold.standard.vel_overshot.yaw_neg = -5
	self.stances.akm_gold.standard.vel_overshot.yaw_pos = 5
	self.stances.akm_gold.standard.vel_overshot.pitch_neg = 7
	self.stances.akm_gold.standard.vel_overshot.pitch_pos = -7
	local pivot_head_translation = Vector3(6, 36, -1)
	local pivot_head_rotation = Rotation(0.2, 0.2, 0)
	self.stances.akm_gold.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akm_gold.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akm_gold.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akm_gold.crouched.vel_overshot.yaw_neg = -4
	self.stances.akm_gold.crouched.vel_overshot.yaw_pos = 4
	self.stances.akm_gold.crouched.vel_overshot.pitch_neg = 5
	self.stances.akm_gold.crouched.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.akm_gold.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.akm_gold.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.akm_gold.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.akm_gold.steelsight.vel_overshot.yaw_neg = -4
	self.stances.akm_gold.steelsight.vel_overshot.yaw_pos = 4
	self.stances.akm_gold.steelsight.vel_overshot.pitch_neg = 5
	self.stances.akm_gold.steelsight.vel_overshot.pitch_pos = -5
end

function PlayerTweakData:_init_fal()
	self.stances.fal = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6889, 30.1129, -4.31372)
	local pivot_shoulder_rotation = Rotation(0.106623, -0.0844514, 0.629209)
	local pivot_head_translation = Vector3(8, 25, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.fal.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.fal.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.fal.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.fal.standard.vel_overshot.yaw_neg = 10
	self.stances.fal.standard.vel_overshot.yaw_pos = -10
	self.stances.fal.standard.vel_overshot.pitch_neg = -10
	self.stances.fal.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 22, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.fal.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.fal.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.fal.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.fal.steelsight.vel_overshot.yaw_neg = 10
	self.stances.fal.steelsight.vel_overshot.yaw_pos = -10
	self.stances.fal.steelsight.vel_overshot.pitch_neg = -10
	self.stances.fal.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 24, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.fal.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.fal.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.fal.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_benelli()
	self.stances.benelli = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7073, 26.1675, -5.32389)
	local pivot_shoulder_rotation = Rotation(0.107094, -0.0844561, 0.62985)
	local pivot_head_translation = Vector3(8, 26, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.benelli.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.benelli.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.benelli.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.benelli.standard.vel_overshot.yaw_neg = 10
	self.stances.benelli.standard.vel_overshot.yaw_pos = -10
	self.stances.benelli.standard.vel_overshot.pitch_neg = -10
	self.stances.benelli.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 28, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.benelli.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.benelli.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.benelli.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.benelli.steelsight.vel_overshot.yaw_neg = 10
	self.stances.benelli.steelsight.vel_overshot.yaw_pos = -10
	self.stances.benelli.steelsight.vel_overshot.pitch_neg = -10
	self.stances.benelli.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 25, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.benelli.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.benelli.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.benelli.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
end

function PlayerTweakData:_init_striker()
	self.stances.striker = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.761, 11.8207, -3.78517)
	local pivot_shoulder_rotation = Rotation(0.106622, -0.0844409, 0.629204)
	local pivot_head_translation = Vector3(8, 16, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.striker.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.striker.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.striker.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.striker.standard.vel_overshot.yaw_neg = 10
	self.stances.striker.standard.vel_overshot.yaw_pos = -10
	self.stances.striker.standard.vel_overshot.pitch_neg = -10
	self.stances.striker.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 22, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.striker.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.striker.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.striker.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.striker.steelsight.vel_overshot.yaw_neg = 10
	self.stances.striker.steelsight.vel_overshot.yaw_pos = -10
	self.stances.striker.steelsight.vel_overshot.pitch_neg = -10
	self.stances.striker.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 15, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.striker.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.striker.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.striker.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_ksg()
	self.stances.ksg = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(7.46753, 41.4613, -0.60714)
	local pivot_shoulder_rotation = Rotation(-2.09266E-5, 7.14203E-4, 2.76649E-4)
	local pivot_head_translation = Vector3(8, 22, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ksg.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ksg.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ksg.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.ksg.standard.vel_overshot.yaw_neg = 10
	self.stances.ksg.standard.vel_overshot.yaw_pos = -10
	self.stances.ksg.standard.vel_overshot.pitch_neg = -10
	self.stances.ksg.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 26, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ksg.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ksg.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ksg.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.ksg.steelsight.vel_overshot.yaw_neg = 10
	self.stances.ksg.steelsight.vel_overshot.yaw_pos = -10
	self.stances.ksg.steelsight.vel_overshot.pitch_neg = -10
	self.stances.ksg.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 21, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.ksg.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.ksg.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.ksg.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
end

function PlayerTweakData:_init_scorpion()
	self.stances.scorpion = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6943, 28.787, -6.49269)
	local pivot_shoulder_rotation = Rotation(0.106445, -0.0842811, 0.629473)
	local pivot_head_translation = Vector3(8, 19, -3.25)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.scorpion.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.scorpion.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.scorpion.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.scorpion.standard.vel_overshot.yaw_neg = 10
	self.stances.scorpion.standard.vel_overshot.yaw_pos = -10
	self.stances.scorpion.standard.vel_overshot.pitch_neg = -10
	self.stances.scorpion.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 15, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.scorpion.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.scorpion.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.scorpion.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.scorpion.steelsight.vel_overshot.yaw_neg = 10
	self.stances.scorpion.steelsight.vel_overshot.yaw_pos = -10
	self.stances.scorpion.steelsight.vel_overshot.pitch_neg = -10
	self.stances.scorpion.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 17, -4.25)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.scorpion.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.scorpion.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.scorpion.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
end

function PlayerTweakData:_init_tec9()
	self.stances.tec9 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.60825, 44.5082, -5.26645)
	local pivot_shoulder_rotation = Rotation(0.11042, 0.0131379, 0.63049)
	local pivot_head_translation = Vector3(6, 26, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.tec9.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.tec9.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.tec9.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.tec9.standard.vel_overshot.yaw_neg = 15
	self.stances.tec9.standard.vel_overshot.yaw_pos = -15
	self.stances.tec9.standard.vel_overshot.pitch_neg = -15
	self.stances.tec9.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 20, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.tec9.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.tec9.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.tec9.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -15, 0)
	self.stances.tec9.steelsight.vel_overshot.yaw_neg = 15
	self.stances.tec9.steelsight.vel_overshot.yaw_pos = -15
	self.stances.tec9.steelsight.vel_overshot.pitch_neg = -18
	self.stances.tec9.steelsight.vel_overshot.pitch_pos = 18
	local pivot_head_translation = Vector3(5, 25, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.tec9.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.tec9.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.tec9.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_uzi()
	self.stances.uzi = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7319, 15.1611, -5.78384)
	local pivot_shoulder_rotation = Rotation(0.1059, -0.083914, 0.628742)
	local pivot_head_translation = Vector3(8.5, 15, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.uzi.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.uzi.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.uzi.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.uzi.standard.vel_overshot.yaw_neg = 10
	self.stances.uzi.standard.vel_overshot.yaw_pos = -10
	self.stances.uzi.standard.vel_overshot.pitch_neg = -10
	self.stances.uzi.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 16, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.uzi.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.uzi.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.uzi.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.uzi.steelsight.vel_overshot.yaw_neg = 10
	self.stances.uzi.steelsight.vel_overshot.yaw_pos = -10
	self.stances.uzi.steelsight.vel_overshot.pitch_neg = -10
	self.stances.uzi.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7.5, 14, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.uzi.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.uzi.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.uzi.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
end

function PlayerTweakData:_init_gre_m79()
	self.stances.gre_m79 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6363, 52.3198, -7.34957)
	local pivot_shoulder_rotation = Rotation(0.106995, -2.19204, 0.629449)
	local pivot_head_translation = Vector3(6, 46, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.gre_m79.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.gre_m79.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.gre_m79.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	local pivot_head_translation = Vector3(0, 40, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.gre_m79.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.gre_m79.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.gre_m79.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.gre_m79.steelsight.vel_overshot.yaw_neg = 12
	self.stances.gre_m79.steelsight.vel_overshot.yaw_pos = -12
	self.stances.gre_m79.steelsight.vel_overshot.pitch_neg = -12
	self.stances.gre_m79.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 44, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.gre_m79.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.gre_m79.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.gre_m79.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
end

function PlayerTweakData:_init_g3()
	self.stances.g3 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7158, 21.5452, -1.67945)
	local pivot_shoulder_rotation = Rotation(0.107438, -0.0837396, 0.629882)
	local pivot_head_translation = Vector3(8.5, 15, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g3.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g3.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g3.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.g3.standard.vel_overshot.yaw_neg = 10
	self.stances.g3.standard.vel_overshot.yaw_pos = -10
	self.stances.g3.standard.vel_overshot.pitch_neg = -5
	self.stances.g3.standard.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(-0.03, 17, 0.16)
	local pivot_head_rotation = Rotation(0.01, 0, 0)
	self.stances.g3.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g3.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g3.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -28, 0)
	self.stances.g3.steelsight.vel_overshot.yaw_neg = 10
	self.stances.g3.steelsight.vel_overshot.yaw_pos = -10
	self.stances.g3.steelsight.vel_overshot.pitch_neg = -5
	self.stances.g3.steelsight.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(7.5, 14, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.g3.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.g3.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.g3.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_galil()
	self.stances.galil = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7344, 22.1028, -3.71493)
	local pivot_shoulder_rotation = Rotation(0.107212, -0.0843867, 0.629332)
	local pivot_head_translation = Vector3(7.5, 16, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.galil.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.galil.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.galil.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.galil.standard.vel_overshot.yaw_neg = 10
	self.stances.galil.standard.vel_overshot.yaw_pos = -10
	self.stances.galil.standard.vel_overshot.pitch_neg = -10
	self.stances.galil.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 8, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.galil.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.galil.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.galil.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -28, 0)
	self.stances.galil.steelsight.vel_overshot.yaw_neg = 10
	self.stances.galil.steelsight.vel_overshot.yaw_pos = -10
	self.stances.galil.steelsight.vel_overshot.pitch_neg = -10
	self.stances.galil.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6.5, 15, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.galil.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.galil.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.galil.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_famas()
	self.stances.famas = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(12.4978, 36.9949, -1.6971)
	local pivot_shoulder_rotation = Rotation(2.58401, -0.0831424, 0.629405)
	local pivot_head_translation = Vector3(9, 34, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.famas.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.famas.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.famas.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.famas.standard.vel_overshot.yaw_neg = 10
	self.stances.famas.standard.vel_overshot.yaw_pos = -10
	self.stances.famas.standard.vel_overshot.pitch_neg = -10
	self.stances.famas.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 30, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.famas.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.famas.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.famas.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -38, 0)
	self.stances.famas.steelsight.vel_overshot.yaw_neg = 10
	self.stances.famas.steelsight.vel_overshot.yaw_pos = -10
	self.stances.famas.steelsight.vel_overshot.pitch_neg = -10
	self.stances.famas.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(8, 33, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.famas.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.famas.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.famas.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_m1928()
	self.stances.m1928 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.4985, 11.6288, -3.91554)
	local pivot_shoulder_rotation = Rotation(1.8476E-5, 0.00110369, 3.2262E-4)
	local pivot_head_translation = Vector3(6, 10, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m1928.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m1928.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m1928.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.m1928.standard.vel_overshot.yaw_neg = 10
	self.stances.m1928.standard.vel_overshot.yaw_pos = -3
	self.stances.m1928.standard.vel_overshot.pitch_neg = -10
	self.stances.m1928.standard.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(0, 12, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m1928.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m1928.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m1928.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.m1928.steelsight.vel_overshot.yaw_neg = 5
	self.stances.m1928.steelsight.vel_overshot.yaw_pos = -5
	self.stances.m1928.steelsight.vel_overshot.pitch_neg = -5
	self.stances.m1928.steelsight.vel_overshot.pitch_pos = 5
	local pivot_head_translation = Vector3(4, 10, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m1928.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m1928.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m1928.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
end

function PlayerTweakData:_init_l85a2()
	self.stances.l85a2 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.494, 25.5678, -0.986251)
	local pivot_shoulder_rotation = Rotation(0.00116616, 0.00248113, 6.06522E-4)
	local pivot_head_translation = Vector3(7, 24, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.l85a2.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.l85a2.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.l85a2.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.l85a2.standard.vel_overshot.yaw_neg = 10
	self.stances.l85a2.standard.vel_overshot.yaw_pos = -10
	self.stances.l85a2.standard.vel_overshot.pitch_neg = -10
	self.stances.l85a2.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 18, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.l85a2.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.l85a2.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.l85a2.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.l85a2.steelsight.vel_overshot.yaw_neg = 10
	self.stances.l85a2.steelsight.vel_overshot.yaw_pos = -10
	self.stances.l85a2.steelsight.vel_overshot.pitch_neg = -10
	self.stances.l85a2.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(4, 20, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.l85a2.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.l85a2.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.l85a2.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_hs2000()
	self.stances.hs2000 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.49184, 38.238, -5.36848)
	local pivot_shoulder_rotation = Rotation(0.100076, -0.685838, 0.630525)
	local pivot_head_translation = Vector3(5, 32, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hs2000.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hs2000.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hs2000.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	local pivot_head_translation = Vector3(0, 37, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hs2000.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hs2000.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hs2000.steelsight.zoom_fov = false
	self.stances.hs2000.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.hs2000.steelsight.vel_overshot.yaw_neg = 5
	self.stances.hs2000.steelsight.vel_overshot.yaw_pos = -5
	self.stances.hs2000.steelsight.vel_overshot.pitch_neg = -12
	self.stances.hs2000.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hs2000.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hs2000.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hs2000.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_vhs()
	self.stances.vhs = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.11614, 8.59096, -0.476531)
	local pivot_shoulder_rotation = Rotation(1.99016E-5, 0.00109528, 3.12054E-4)
	local pivot_head_translation = Vector3(7, 16, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.vhs.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.vhs.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.vhs.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.vhs.standard.vel_overshot.yaw_neg = 10
	self.stances.vhs.standard.vel_overshot.yaw_pos = -10
	self.stances.vhs.standard.vel_overshot.pitch_neg = -10
	self.stances.vhs.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 12, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.vhs.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.vhs.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.vhs.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.vhs.steelsight.vel_overshot.yaw_neg = 4
	self.stances.vhs.steelsight.vel_overshot.yaw_pos = -4
	self.stances.vhs.steelsight.vel_overshot.pitch_neg = -4
	self.stances.vhs.steelsight.vel_overshot.pitch_pos = 4
	local pivot_head_translation = Vector3(7, 15, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.vhs.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.vhs.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.vhs.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_m134()
	self.stances.m134 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(4.11438, 35.5734, -13.4323)
	local pivot_shoulder_rotation = Rotation(-1.22503E-5, 0.00110689, 2.82252E-4)
	local pivot_head_translation = Vector3(2, 24, -14)
	local pivot_head_rotation = Rotation(0, 0, -14)
	self.stances.m134.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m134.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m134.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.m134.standard.vel_overshot.yaw_neg = 20
	self.stances.m134.standard.vel_overshot.yaw_pos = -20
	self.stances.m134.standard.vel_overshot.pitch_neg = -20
	self.stances.m134.standard.vel_overshot.pitch_pos = 20
	local pivot_head_translation = Vector3(0, 21, -12)
	local pivot_head_rotation = Rotation(0, 0, -12)
	self.stances.m134.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m134.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m134.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.m134.steelsight.vel_overshot.yaw_neg = 10
	self.stances.m134.steelsight.vel_overshot.yaw_pos = -10
	self.stances.m134.steelsight.vel_overshot.pitch_neg = -10
	self.stances.m134.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 22, -10)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m134.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m134.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m134.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_rpg7()
	self.stances.rpg7 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.65215, 14.1036, 1.91009)
	local pivot_shoulder_rotation = Rotation(-2.176E-4, 0.00147512, -1.03691E-4)
	local pivot_head_translation = Vector3(8, 12, 3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.rpg7.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpg7.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpg7.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.rpg7.standard.vel_overshot.yaw_neg = 4
	self.stances.rpg7.standard.vel_overshot.yaw_pos = -4
	self.stances.rpg7.standard.vel_overshot.pitch_neg = -4
	self.stances.rpg7.standard.vel_overshot.pitch_pos = 4
	local pivot_head_translation = Vector3(0, 12, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.rpg7.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpg7.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpg7.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.rpg7.steelsight.vel_overshot.yaw_neg = 10
	self.stances.rpg7.steelsight.vel_overshot.yaw_pos = -10
	self.stances.rpg7.steelsight.vel_overshot.pitch_neg = -10
	self.stances.rpg7.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(8, 13, 4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.rpg7.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpg7.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.rpg7.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_cobray()
	self.stances.cobray = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.3342, 14.4687, -5.79688)
	local pivot_shoulder_rotation = Rotation(-7.67834E-4, 0.00181087, 0.00114593)
	local pivot_head_translation = Vector3(7, 14, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.cobray.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.cobray.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.cobray.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.cobray.standard.vel_overshot.yaw_neg = 10
	self.stances.cobray.standard.vel_overshot.yaw_pos = -10
	self.stances.cobray.standard.vel_overshot.pitch_neg = -10
	self.stances.cobray.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 18, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.cobray.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.cobray.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.cobray.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.cobray.steelsight.vel_overshot.yaw_neg = 10
	self.stances.cobray.steelsight.vel_overshot.yaw_pos = -10
	self.stances.cobray.steelsight.vel_overshot.pitch_neg = -10
	self.stances.cobray.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(4, 12, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.cobray.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.cobray.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.cobray.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_b682()
	self.stances.b682 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.47311, 22.1434, -6.31211)
	local pivot_shoulder_rotation = Rotation(-1.83462E-5, 0.00105637, 3.52956E-4)
	local pivot_head_translation = Vector3(7, 22, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.b682.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.b682.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.b682.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.b682.standard.vel_overshot.yaw_neg = 14
	self.stances.b682.standard.vel_overshot.yaw_pos = -14
	self.stances.b682.standard.vel_overshot.pitch_neg = -14
	self.stances.b682.standard.vel_overshot.pitch_pos = 14
	local pivot_head_translation = Vector3(0, 24.8, -0.5)
	local pivot_head_rotation = Rotation(0, 0.3, 0)
	self.stances.b682.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.b682.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.b682.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.b682.steelsight.vel_overshot.yaw_neg = 10
	self.stances.b682.steelsight.vel_overshot.yaw_pos = -10
	self.stances.b682.steelsight.vel_overshot.pitch_neg = -10
	self.stances.b682.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(4, 16, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.b682.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.b682.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.b682.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_x_g22c()
	self.stances.x_g22c = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.4939, 42.8789, -1.11447)
	local pivot_shoulder_rotation = Rotation(-0.347954, 0.253161, 0.281029)
	local pivot_head_translation = Vector3(10.95, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_g22c.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_g22c.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_g22c.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10.95, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_g22c.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_g22c.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_g22c.steelsight.zoom_fov = false
	self.stances.x_g22c.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.x_g22c.steelsight.vel_overshot.yaw_neg = 5
	self.stances.x_g22c.steelsight.vel_overshot.yaw_pos = -5
	self.stances.x_g22c.steelsight.vel_overshot.pitch_neg = -12
	self.stances.x_g22c.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_g22c.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_g22c.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_g22c.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_x_g17()
	self.stances.x_g17 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.4939, 42.8789, -1.11447)
	local pivot_shoulder_rotation = Rotation(-0.347954, 0.253161, 0.281029)
	local pivot_head_translation = Vector3(10.95, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_g17.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_g17.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_g17.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10.95, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_g17.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_g17.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_g17.steelsight.zoom_fov = false
	self.stances.x_g17.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.x_g17.steelsight.vel_overshot.yaw_neg = 5
	self.stances.x_g17.steelsight.vel_overshot.yaw_pos = -5
	self.stances.x_g17.steelsight.vel_overshot.pitch_neg = -12
	self.stances.x_g17.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_g17.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_g17.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_g17.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_x_usp()
	self.stances.x_usp = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.4939, 42.8789, -1.11447)
	local pivot_shoulder_rotation = Rotation(-0.347954, 0.253161, 0.281029)
	local pivot_head_translation = Vector3(10.95, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_usp.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_usp.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_usp.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(10.95, 42, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_usp.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_usp.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_usp.steelsight.zoom_fov = false
	self.stances.x_usp.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.x_usp.steelsight.vel_overshot.yaw_neg = 5
	self.stances.x_usp.steelsight.vel_overshot.yaw_pos = -5
	self.stances.x_usp.steelsight.vel_overshot.pitch_neg = -12
	self.stances.x_usp.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10.95, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.x_usp.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.x_usp.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.x_usp.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_flamethrower_mk2()
	self.stances.flamethrower_mk2 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.7639, 15.2768, -1.63551)
	local pivot_shoulder_rotation = Rotation(0.108359, -0.086669, 0.631366)
	local pivot_head_translation = Vector3(12, 15, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.flamethrower_mk2.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.flamethrower_mk2.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.flamethrower_mk2.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	local pivot_head_translation = Vector3(5, 15, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.flamethrower_mk2.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.flamethrower_mk2.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.flamethrower_mk2.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.flamethrower_mk2.steelsight.vel_overshot.yaw_neg = 12
	self.stances.flamethrower_mk2.steelsight.vel_overshot.yaw_pos = -12
	self.stances.flamethrower_mk2.steelsight.vel_overshot.pitch_neg = -12
	self.stances.flamethrower_mk2.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(11, 14, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.flamethrower_mk2.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.flamethrower_mk2.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.flamethrower_mk2.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_m32()
	self.stances.m32 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.71578, 20.864, -3.15926)
	local pivot_shoulder_rotation = Rotation(-3.7146E-6, 0.00110462, 3.00785E-4)
	local pivot_head_translation = Vector3(8.5, 22, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m32.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m32.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m32.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.m32.standard.vel_overshot.yaw_neg = 10
	self.stances.m32.standard.vel_overshot.yaw_pos = -10
	self.stances.m32.standard.vel_overshot.pitch_neg = -10
	self.stances.m32.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 18, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m32.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m32.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m32.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.m32.steelsight.vel_overshot.yaw_neg = 10
	self.stances.m32.steelsight.vel_overshot.yaw_pos = -10
	self.stances.m32.steelsight.vel_overshot.pitch_neg = -10
	self.stances.m32.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7.5, 21, -3.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m32.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m32.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.m32.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_aa12()
	self.stances.aa12 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.9866, 17.7262, -1.21375)
	local pivot_shoulder_rotation = Rotation(1.26918, 0.0466027, -0.0824729)
	local pivot_head_translation = Vector3(8, 16, -1.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.aa12.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.aa12.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.aa12.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.aa12.standard.vel_overshot.yaw_neg = 10
	self.stances.aa12.standard.vel_overshot.yaw_pos = -10
	self.stances.aa12.standard.vel_overshot.pitch_neg = -10
	self.stances.aa12.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 18, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.aa12.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.aa12.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.aa12.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.aa12.steelsight.vel_overshot.yaw_neg = 10
	self.stances.aa12.steelsight.vel_overshot.yaw_pos = -10
	self.stances.aa12.steelsight.vel_overshot.pitch_neg = -10
	self.stances.aa12.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 15, -2.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.aa12.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.aa12.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.aa12.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_peacemaker()
	self.stances.peacemaker = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.51249, 54.0571, -3.47982)
	local pivot_shoulder_rotation = Rotation(0.0999728, -0.687715, 0.630303)
	local pivot_head_translation = Vector3(6, 42, -2)
	local pivot_head_rotation = Rotation(1, 1, -5)
	self.stances.peacemaker.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.peacemaker.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.peacemaker.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.peacemaker.standard.vel_overshot.yaw_neg = -5
	self.stances.peacemaker.standard.vel_overshot.yaw_pos = 2
	self.stances.peacemaker.standard.vel_overshot.pitch_neg = 5
	self.stances.peacemaker.standard.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(0, 40, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.peacemaker.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.peacemaker.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.peacemaker.steelsight.zoom_fov = false
	self.stances.peacemaker.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -37, 0)
	self.stances.peacemaker.steelsight.vel_overshot.yaw_neg = -5
	self.stances.peacemaker.steelsight.vel_overshot.yaw_pos = 2
	self.stances.peacemaker.steelsight.vel_overshot.pitch_neg = 5
	self.stances.peacemaker.steelsight.vel_overshot.pitch_pos = -5
	local pivot_head_translation = Vector3(4, 42, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.peacemaker.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.peacemaker.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.peacemaker.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_winchester1874()
	self.stances.winchester1874 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6159, 49.1194, -8.52048)
	local pivot_shoulder_rotation = Rotation(8.06175E-4, -0.0850935, 0.631465)
	local pivot_head_translation = Vector3(8, 52, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.winchester1874.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.winchester1874.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.winchester1874.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.winchester1874.standard.vel_overshot.yaw_neg = 15
	self.stances.winchester1874.standard.vel_overshot.yaw_pos = -15
	self.stances.winchester1874.standard.vel_overshot.pitch_neg = -15
	self.stances.winchester1874.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(0, 42, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.winchester1874.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.winchester1874.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.winchester1874.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.winchester1874.steelsight.vel_overshot.yaw_neg = 0
	self.stances.winchester1874.steelsight.vel_overshot.yaw_pos = 0
	self.stances.winchester1874.steelsight.vel_overshot.pitch_neg = 0
	self.stances.winchester1874.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(8, 52, -2)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.winchester1874.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.winchester1874.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.winchester1874.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
end

function PlayerTweakData:_init_plainsrider()
	self.stances.plainsrider = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(6.53874, 36.6672, -17.3943)
	local pivot_shoulder_rotation = Rotation(0.00233964, 0.00195501, 55.0004)
	local pivot_head_translation = Vector3(10, 42, -14)
	local pivot_head_rotation = Rotation(0, 0, 35)
	self.stances.plainsrider.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.plainsrider.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.plainsrider.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.plainsrider.standard.vel_overshot.yaw_neg = 15
	self.stances.plainsrider.standard.vel_overshot.yaw_pos = -15
	self.stances.plainsrider.standard.vel_overshot.pitch_neg = -15
	self.stances.plainsrider.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(1.1, 48, -3)
	local pivot_head_rotation = Rotation(3, 8.5, 35)
	self.stances.plainsrider.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.plainsrider.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.plainsrider.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.plainsrider.steelsight.vel_overshot.yaw_neg = 12
	self.stances.plainsrider.steelsight.vel_overshot.yaw_pos = -12
	self.stances.plainsrider.steelsight.vel_overshot.pitch_neg = -12
	self.stances.plainsrider.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10, 42, -14)
	local pivot_head_rotation = Rotation(0, 0, 42)
	self.stances.plainsrider.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.plainsrider.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.plainsrider.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
end

function PlayerTweakData:_init_mateba()
	self.stances.mateba = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(8.52839, 40.2153, -3.77382)
	local pivot_shoulder_rotation = Rotation(0.0991125, -0.687691, 0.607803)
	local pivot_head_translation = Vector3(6, 32, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mateba.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mateba.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mateba.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(0, 42, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mateba.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mateba.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mateba.steelsight.zoom_fov = false
	self.stances.mateba.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.mateba.steelsight.vel_overshot.yaw_neg = 5
	self.stances.mateba.steelsight.vel_overshot.yaw_pos = -5
	self.stances.mateba.steelsight.vel_overshot.pitch_neg = -12
	self.stances.mateba.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(4, 34, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.mateba.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mateba.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.mateba.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_asval()
	self.stances.asval = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.6379, 44.277, -6.34431)
	local pivot_shoulder_rotation = Rotation(0.108542, -0.0846267, 0.631398)
	local pivot_head_translation = Vector3(8, 43, -5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.asval.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.asval.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.asval.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(0, 41, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.asval.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.asval.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.asval.steelsight.zoom_fov = false
	self.stances.asval.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.asval.steelsight.vel_overshot.yaw_neg = 5
	self.stances.asval.steelsight.vel_overshot.yaw_pos = -5
	self.stances.asval.steelsight.vel_overshot.pitch_neg = -12
	self.stances.asval.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(7, 42, -3.7)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.asval.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.asval.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.asval.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_sub2000()
	self.stances.sub2000 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.579, 18.1015, -4.96283)
	local pivot_shoulder_rotation = Rotation(6.05534E-4, 0.00148493, 6.76394E-4)
	local pivot_head_translation = Vector3(6, 20, -4)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.sub2000.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.sub2000.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.sub2000.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(0, 22, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.sub2000.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.sub2000.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.sub2000.steelsight.zoom_fov = false
	self.stances.sub2000.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
	self.stances.sub2000.steelsight.vel_overshot.yaw_neg = 5
	self.stances.sub2000.steelsight.vel_overshot.yaw_pos = -5
	self.stances.sub2000.steelsight.vel_overshot.pitch_neg = -12
	self.stances.sub2000.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(5, 19, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.sub2000.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.sub2000.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.sub2000.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_wa2000()
	self.stances.wa2000 = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.5502, 10.5337, 0.275142)
	local pivot_shoulder_rotation = Rotation(-2.25784E-4, 0.00162484, -1.92709E-4)
	local pivot_head_translation = Vector3(10, 14, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.wa2000.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.wa2000.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.wa2000.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(0, 20, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.wa2000.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.wa2000.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.wa2000.steelsight.zoom_fov = false
	self.stances.wa2000.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.wa2000.steelsight.vel_overshot.yaw_neg = 0
	self.stances.wa2000.steelsight.vel_overshot.yaw_pos = 0
	self.stances.wa2000.steelsight.vel_overshot.pitch_neg = 0
	self.stances.wa2000.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(9, 13, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.wa2000.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.wa2000.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.wa2000.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)
end

function PlayerTweakData:_init_polymer()
	self.stances.polymer = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.00921, 13.825, -1.23709)
	local pivot_shoulder_rotation = Rotation(-1.555E-4, 1.91465, 2.96338E-4)
	local pivot_head_translation = Vector3(6, 15, 0)
	local pivot_head_rotation = Rotation(0, 0, 2)
	self.stances.polymer.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.polymer.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.polymer.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.polymer.standard.vel_overshot.yaw_neg = 10
	self.stances.polymer.standard.vel_overshot.yaw_pos = -2
	self.stances.polymer.standard.vel_overshot.pitch_neg = -10
	self.stances.polymer.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 10, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.polymer.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.polymer.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.polymer.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -10, 0)
	self.stances.polymer.steelsight.vel_overshot.yaw_neg = 10
	self.stances.polymer.steelsight.vel_overshot.yaw_pos = -10
	self.stances.polymer.steelsight.vel_overshot.pitch_neg = -10
	self.stances.polymer.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(7, 16, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.polymer.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.polymer.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.polymer.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
end

function PlayerTweakData:_init_hunter()
	self.stances.hunter = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.5686, 37.1867, -5.35351)
	local pivot_shoulder_rotation = Rotation(3.90198E-5, 0.00112517, 3.1088E-4)
	local pivot_head_translation = Vector3(5, 30, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hunter.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hunter.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hunter.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.hunter.standard.vel_overshot.yaw_neg = 10
	self.stances.hunter.standard.vel_overshot.yaw_pos = -10
	self.stances.hunter.standard.vel_overshot.pitch_neg = -10
	self.stances.hunter.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 10, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hunter.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hunter.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hunter.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -20, 0)
	self.stances.hunter.steelsight.vel_overshot.yaw_neg = 10
	self.stances.hunter.steelsight.vel_overshot.yaw_pos = -10
	self.stances.hunter.steelsight.vel_overshot.pitch_neg = -10
	self.stances.hunter.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(4, 32, -3)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.hunter.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hunter.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.hunter.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_baka()
	self.stances.baka = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(9.33471, 13.913, -0.0159556)
	local pivot_shoulder_rotation = Rotation(0.001265, 0.00210433, -3.65091E-4)
	local pivot_head_translation = Vector3(7, 16, 1.5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.baka.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.baka.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.baka.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
	self.stances.baka.standard.vel_overshot.yaw_neg = 9
	self.stances.baka.standard.vel_overshot.yaw_pos = -9
	self.stances.baka.standard.vel_overshot.pitch_neg = -9
	self.stances.baka.standard.vel_overshot.pitch_pos = 9
	local pivot_head_translation = Vector3(-1.88, 16, 5)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.baka.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.baka.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.baka.steelsight.zoom_fov = false
	self.stances.baka.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.baka.steelsight.vel_overshot.yaw_neg = 15
	self.stances.baka.steelsight.vel_overshot.yaw_pos = -15
	self.stances.baka.steelsight.vel_overshot.pitch_neg = -15
	self.stances.baka.steelsight.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(6, 15, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.baka.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.baka.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.baka.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -40, 0)
end

function PlayerTweakData:_init_arblast()
	self.stances.arblast = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.3759, 27.2897, -11.445)
	local pivot_shoulder_rotation = Rotation(-2.2432E-5, 0.00111043, 3.02449E-4)
	local pivot_head_translation = Vector3(7, 25, -8)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.arblast.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.arblast.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.arblast.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.arblast.standard.vel_overshot.yaw_neg = 10
	self.stances.arblast.standard.vel_overshot.yaw_pos = -10
	self.stances.arblast.standard.vel_overshot.pitch_neg = -10
	self.stances.arblast.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 22, -4)
	local pivot_head_rotation = Rotation(0, 5, 0)
	self.stances.arblast.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.arblast.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.arblast.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.arblast.steelsight.vel_overshot.yaw_neg = 10
	self.stances.arblast.steelsight.vel_overshot.yaw_pos = -10
	self.stances.arblast.steelsight.vel_overshot.pitch_neg = -10
	self.stances.arblast.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6, 24, -9)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.arblast.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.arblast.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.arblast.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
end

function PlayerTweakData:_init_frankish()
	self.stances.frankish = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(11.376, 27.2898, -11.4456)
	local pivot_shoulder_rotation = Rotation(5.81843E-4, 4.85653E-4, 1.57514E-4)
	local pivot_head_translation = Vector3(7, 25, -8)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.frankish.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.frankish.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.frankish.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -30, 0)
	self.stances.frankish.standard.vel_overshot.yaw_neg = 10
	self.stances.frankish.standard.vel_overshot.yaw_pos = -10
	self.stances.frankish.standard.vel_overshot.pitch_neg = -10
	self.stances.frankish.standard.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(0, 32, -4)
	local pivot_head_rotation = Rotation(0, 5, 0)
	self.stances.frankish.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.frankish.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.frankish.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -18, 0)
	self.stances.frankish.steelsight.vel_overshot.yaw_neg = 10
	self.stances.frankish.steelsight.vel_overshot.yaw_pos = -10
	self.stances.frankish.steelsight.vel_overshot.pitch_neg = -10
	self.stances.frankish.steelsight.vel_overshot.pitch_pos = 10
	local pivot_head_translation = Vector3(6, 24, -9)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.frankish.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.frankish.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.frankish.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -25, 0)
end

function PlayerTweakData:_init_long()
	self.stances.long = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(6.50446, 35.57, -17.2983)
	local pivot_shoulder_rotation = Rotation(0.00224909, 0.00268967, 54.9997)
	local pivot_head_translation = Vector3(10, 42, -14)
	local pivot_head_rotation = Rotation(0, 0, 35)
	self.stances.long.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.long.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.long.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.long.standard.vel_overshot.yaw_neg = 15
	self.stances.long.standard.vel_overshot.yaw_pos = -15
	self.stances.long.standard.vel_overshot.pitch_neg = -15
	self.stances.long.standard.vel_overshot.pitch_pos = 15
	local pivot_head_translation = Vector3(2.1, 48, -4)
	local pivot_head_rotation = Rotation(1.2, 5.5, 35)
	self.stances.long.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.long.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.long.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.long.steelsight.vel_overshot.yaw_neg = 12
	self.stances.long.steelsight.vel_overshot.yaw_pos = -12
	self.stances.long.steelsight.vel_overshot.pitch_neg = -12
	self.stances.long.steelsight.vel_overshot.pitch_pos = 12
	local pivot_head_translation = Vector3(10, 42, -14)
	local pivot_head_rotation = Rotation(0, 0, 42)
	self.stances.long.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.long.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.long.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
end
