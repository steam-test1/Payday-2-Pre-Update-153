HUDTeammate = HUDTeammate or class()

function HUDTeammate:init(i, teammates_panel, is_player, width)
	self._id = i
	local small_gap = 8
	local gap = 0
	local pad = 4
	local main_player = i == HUDManager.PLAYER_PANEL
	self._main_player = main_player
	local names = {
		"WWWWWWWWWWWWQWWW",
		"AI Teammate",
		"FutureCatCar",
		"WWWWWWWWWWWWQWWW"
	}
	local teammate_panel = teammates_panel:panel({
		visible = false,
		name = "" .. i,
		w = math.round(width),
		x = 0,
		halign = "right"
	})
	if not main_player then
		teammate_panel:set_h(84)
		teammate_panel:set_bottom(teammates_panel:h())
		teammate_panel:set_halign("left")
	end
	self._player_panel = teammate_panel:panel({name = "player"})
	local name = teammate_panel:text({
		name = "name",
		text = " " .. names[i],
		layer = 1,
		color = Color.white,
		y = 0,
		vertical = "bottom",
		font_size = tweak_data.hud_players.name_size,
		font = tweak_data.hud_players.name_font
	})
	local _, _, name_w, _ = name:text_rect()
	managers.hud:make_fine_text(name)
	name:set_leftbottom(name:h(), teammate_panel:h() - 70)
	if not main_player then
		name:set_x(48 + name:h() + 4)
		name:set_bottom(teammate_panel:h() - 30)
	end
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = {
		84,
		0,
		44,
		32
	}
	local cs_rect = {
		84,
		34,
		19,
		19
	}
	local csbg_rect = {
		105,
		34,
		19,
		19
	}
	local bg_color = Color.white / 3
	teammate_panel:bitmap({
		name = "name_bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		x = name:x(),
		y = name:y() - 1,
		w = name_w + 4,
		h = name:h()
	})
	teammate_panel:bitmap({
		name = "callsign_bg",
		texture = tabs_texture,
		texture_rect = csbg_rect,
		layer = 0,
		color = bg_color,
		blend_mode = "normal",
		x = name:x() - name:h(),
		y = name:y() + 1,
		w = name:h() - 2,
		h = name:h() - 2
	})
	teammate_panel:bitmap({
		name = "callsign",
		texture = tabs_texture,
		texture_rect = cs_rect,
		layer = 1,
		color = (tweak_data.chat_colors[i] or tweak_data.chat_colors[#tweak_data.chat_colors]):with_alpha(1),
		blend_mode = "normal",
		x = name:x() - name:h(),
		y = name:y() + 1,
		w = name:h() - 2,
		h = name:h() - 2
	})
	local box_ai_bg = teammate_panel:bitmap({
		visible = false,
		name = "box_ai_bg",
		texture = "guis/textures/pd2/box_ai_bg",
		color = Color.white,
		alpha = 0,
		y = 0,
		w = teammate_panel:w()
	})
	box_ai_bg:set_bottom(name:top())
	local box_bg = teammate_panel:bitmap({
		visible = false,
		name = "box_bg",
		texture = "guis/textures/pd2/box_bg",
		color = Color.white,
		y = 0,
		w = teammate_panel:w()
	})
	box_bg:set_bottom(name:top())
	local texture, rect = tweak_data.hud_icons:get_icon_data("pd2_mask_" .. i)
	local size = 64
	local mask_pad = 2
	local mask_pad_x = 3
	local y = teammate_panel:h() - name:h() - size + mask_pad
	local mask = teammate_panel:bitmap({
		visible = false,
		name = "mask",
		layer = 1,
		color = Color.white,
		texture = texture,
		texture_rect = rect,
		x = -mask_pad_x,
		w = size,
		h = size,
		y = y
	})
	local radial_size = main_player and 64 or 48
	local radial_health_panel = self._player_panel:panel({
		name = "radial_health_panel",
		layer = 1,
		w = radial_size + 4,
		h = radial_size + 4,
		x = 0,
		y = mask:y()
	})
	radial_health_panel:set_bottom(self._player_panel:h())
	local radial_bg = radial_health_panel:bitmap({
		name = "radial_bg",
		texture = "guis/textures/pd2/hud_radialbg",
		alpha = 1,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 0
	})
	local radial_health = radial_health_panel:bitmap({
		name = "radial_health",
		texture = "guis/textures/pd2/hud_health",
		texture_rect = {
			64,
			0,
			-64,
			64
		},
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		alpha = 1,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 2
	})
	radial_health:set_color(Color(1, 1, 0, 0))
	local radial_shield = radial_health_panel:bitmap({
		name = "radial_shield",
		texture = "guis/textures/pd2/hud_shield",
		texture_rect = {
			64,
			0,
			-64,
			64
		},
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		alpha = 1,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 1
	})
	radial_shield:set_color(Color(1, 1, 0, 0))
	local damage_indicator = radial_health_panel:bitmap({
		name = "damage_indicator",
		texture = "guis/textures/pd2/hud_radial_rim",
		blend_mode = "add",
		alpha = 0,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 1
	})
	damage_indicator:set_color(Color(1, 1, 1, 1))
	local radial_custom = radial_health_panel:bitmap({
		name = "radial_custom",
		texture = "guis/textures/pd2/hud_swansong",
		texture_rect = {
			0,
			0,
			64,
			64
		},
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		alpha = 1,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 5
	})
	radial_custom:set_color(Color(1, 0, 0, 0))
	radial_custom:hide()
	local radial_ability = radial_health_panel:bitmap({
		name = "radial_ability",
		texture = "guis/dlcs/chico/textures/pd2/hud_fearless",
		texture_rect = {
			0,
			0,
			64,
			64
		},
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		alpha = 1,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		layer = 5
	})
	radial_ability:set_color(Color(1, 0, 0, 0))
	radial_ability:hide()
	if main_player then
		local radial_rip = radial_health_panel:bitmap({
			name = "radial_rip",
			texture = "guis/textures/pd2/hud_rip",
			texture_rect = {
				64,
				0,
				-64,
				64
			},
			render_template = "VertexColorTexturedRadial",
			blend_mode = "add",
			alpha = 1,
			w = radial_health_panel:w(),
			h = radial_health_panel:h(),
			layer = 3
		})
		radial_rip:set_color(Color(1, 0, 0, 0))
		radial_rip:hide()
		local radial_rip_bg = radial_health_panel:bitmap({
			name = "radial_rip_bg",
			texture = "guis/textures/pd2/hud_rip_bg",
			texture_rect = {
				64,
				0,
				-64,
				64
			},
			render_template = "VertexColorTexturedRadial",
			blend_mode = "normal",
			alpha = 1,
			w = radial_health_panel:w(),
			h = radial_health_panel:h(),
			layer = 1
		})
		radial_rip_bg:set_color(Color(1, 0, 0, 0))
		radial_rip_bg:hide()
	end
	do
		local radial_absorb_shield_active = radial_health_panel:bitmap({
			name = "radial_absorb_shield_active",
			texture = "guis/dlcs/coco/textures/pd2/hud_absorb_shield",
			texture_rect = {
				0,
				0,
				64,
				64
			},
			render_template = "VertexColorTexturedRadial",
			blend_mode = "normal",
			alpha = 1,
			w = radial_health_panel:w(),
			h = radial_health_panel:h(),
			layer = 5
		})
		radial_absorb_shield_active:set_color(Color(1, 0, 0, 0))
		radial_absorb_shield_active:hide()
		local radial_absorb_health_active = radial_health_panel:bitmap({
			name = "radial_absorb_health_active",
			texture = "guis/dlcs/coco/textures/pd2/hud_absorb_health",
			texture_rect = {
				0,
				0,
				64,
				64
			},
			render_template = "VertexColorTexturedRadial",
			blend_mode = "normal",
			alpha = 1,
			w = radial_health_panel:w(),
			h = radial_health_panel:h(),
			layer = 5
		})
		radial_absorb_health_active:set_color(Color(1, 0, 0, 0))
		radial_absorb_health_active:hide()
		radial_absorb_health_active:animate(callback(self, self, "animate_update_absorb_active"))
		local radial_info_meter = radial_health_panel:bitmap({
			name = "radial_info_meter",
			texture = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_fg",
			texture_rect = {
				0,
				0,
				64,
				64
			},
			render_template = "VertexColorTexturedRadial",
			blend_mode = "add",
			alpha = 1,
			w = radial_health_panel:w(),
			h = radial_health_panel:h(),
			layer = 3
		})
		radial_info_meter:set_color(Color(1, 0, 0, 0))
		radial_info_meter:hide()
		local radial_info_meter_bg = radial_health_panel:bitmap({
			name = "radial_info_meter_bg",
			texture = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_bg",
			texture_rect = {
				64,
				0,
				-64,
				64
			},
			render_template = "VertexColorTexturedRadial",
			blend_mode = "normal",
			alpha = 1,
			w = radial_health_panel:w(),
			h = radial_health_panel:h(),
			layer = 1
		})
		radial_info_meter_bg:set_color(Color(1, 0, 0, 0))
		radial_info_meter_bg:hide()
	end
	local x, y, w, h = radial_health_panel:shape()
	teammate_panel:bitmap({
		name = "condition_icon",
		layer = 4,
		visible = false,
		color = Color.white,
		x = x,
		y = y,
		w = w,
		h = h
	})
	local condition_timer = teammate_panel:text({
		name = "condition_timer",
		visible = false,
		text = "000",
		layer = 5,
		color = Color.white,
		y = 0,
		align = "center",
		vertical = "center",
		font_size = tweak_data.hud_players.timer_size,
		font = tweak_data.hud_players.timer_font
	})
	condition_timer:set_shape(radial_health_panel:shape())
	local w_selection_w = 12
	local weapon_panel_w = 80
	local extra_clip_w = 4
	local ammo_text_w = (weapon_panel_w - w_selection_w) / 2
	local font_bottom_align_correction = 3
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = {
		0,
		0,
		67,
		32
	}
	local weapon_selection_rect1 = {
		68,
		0,
		12,
		32
	}
	local weapon_selection_rect2 = {
		68,
		32,
		12,
		32
	}
	local weapons_panel = self._player_panel:panel({
		name = "weapons_panel",
		visible = true,
		layer = 0,
		w = weapon_panel_w,
		h = radial_health_panel:h(),
		x = radial_health_panel:right() + 4,
		y = radial_health_panel:y()
	})
	local primary_weapon_panel = weapons_panel:panel({
		name = "primary_weapon_panel",
		visible = false,
		layer = 1,
		w = weapon_panel_w,
		h = 32,
		x = 0,
		y = 0
	})
	primary_weapon_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = weapon_panel_w,
		x = 0
	})
	primary_weapon_panel:text({
		name = "ammo_clip",
		visible = main_player and true,
		text = "0" .. math.random(40),
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = ammo_text_w + extra_clip_w,
		h = primary_weapon_panel:h(),
		x = 0,
		y = 0 + font_bottom_align_correction,
		vertical = "bottom",
		align = "center",
		font_size = 32,
		font = tweak_data.hud_players.ammo_font
	})
	primary_weapon_panel:text({
		name = "ammo_total",
		visible = true,
		text = "000",
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = ammo_text_w - extra_clip_w,
		h = primary_weapon_panel:h(),
		x = ammo_text_w + extra_clip_w,
		y = 0 + font_bottom_align_correction,
		vertical = "bottom",
		align = "center",
		font_size = 24,
		font = tweak_data.hud_players.ammo_font
	})
	local weapon_selection_panel = primary_weapon_panel:panel({
		name = "weapon_selection",
		layer = 1,
		visible = main_player and true,
		w = w_selection_w,
		x = weapon_panel_w - w_selection_w
	})
	weapon_selection_panel:bitmap({
		name = "weapon_selection",
		texture = tabs_texture,
		texture_rect = weapon_selection_rect1,
		color = Color.white,
		w = w_selection_w
	})
	self:_create_primary_weapon_firemode()
	if not main_player then
		local ammo_total = primary_weapon_panel:child("ammo_total")
		local _x, _y, _w, _h = ammo_total:text_rect()
		primary_weapon_panel:set_size(_w + 8, _h)
		ammo_total:set_shape(0, 0, primary_weapon_panel:size())
		ammo_total:move(0, font_bottom_align_correction)
		primary_weapon_panel:set_x(0)
		primary_weapon_panel:set_bottom(weapons_panel:h())
		local eq_rect = {
			84,
			0,
			44,
			32
		}
		primary_weapon_panel:child("bg"):set_image(tabs_texture, eq_rect[1], eq_rect[2], eq_rect[3], eq_rect[4])
		primary_weapon_panel:child("bg"):set_size(primary_weapon_panel:size())
	end
	local secondary_weapon_panel = weapons_panel:panel({
		name = "secondary_weapon_panel",
		visible = false,
		layer = 1,
		w = weapon_panel_w,
		h = 32,
		x = 0,
		y = primary_weapon_panel:bottom()
	})
	secondary_weapon_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = weapon_panel_w,
		x = 0
	})
	secondary_weapon_panel:text({
		name = "ammo_clip",
		visible = main_player and true,
		text = "" .. math.random(40),
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = ammo_text_w + extra_clip_w,
		h = secondary_weapon_panel:h(),
		x = 0,
		y = 0 + font_bottom_align_correction,
		vertical = "bottom",
		align = "center",
		font_size = 32,
		font = tweak_data.hud_players.ammo_font
	})
	secondary_weapon_panel:text({
		name = "ammo_total",
		visible = true,
		text = "000",
		color = Color.white,
		blend_mode = "normal",
		layer = 1,
		w = ammo_text_w - extra_clip_w,
		h = secondary_weapon_panel:h(),
		x = ammo_text_w + extra_clip_w,
		y = 0 + font_bottom_align_correction,
		vertical = "bottom",
		align = "center",
		font_size = 24,
		font = tweak_data.hud_players.ammo_font
	})
	local weapon_selection_panel = secondary_weapon_panel:panel({
		name = "weapon_selection",
		layer = 1,
		visible = main_player and true,
		w = w_selection_w,
		x = weapon_panel_w - w_selection_w
	})
	weapon_selection_panel:bitmap({
		name = "weapon_selection",
		texture = tabs_texture,
		texture_rect = weapon_selection_rect2,
		color = Color.white,
		w = w_selection_w
	})
	secondary_weapon_panel:set_bottom(weapons_panel:h())
	self:_create_secondary_weapon_firemode()
	if not main_player then
		local ammo_total = secondary_weapon_panel:child("ammo_total")
		local _x, _y, _w, _h = ammo_total:text_rect()
		secondary_weapon_panel:set_size(_w + 8, _h)
		ammo_total:set_shape(0, 0, secondary_weapon_panel:size())
		ammo_total:move(0, font_bottom_align_correction)
		secondary_weapon_panel:set_x(primary_weapon_panel:right())
		secondary_weapon_panel:set_bottom(weapons_panel:h())
		local eq_rect = {
			84,
			0,
			44,
			32
		}
		secondary_weapon_panel:child("bg"):set_image(tabs_texture, eq_rect[1], eq_rect[2], eq_rect[3], eq_rect[4])
		secondary_weapon_panel:child("bg"):set_size(secondary_weapon_panel:size())
	end
	local eq_rect = {
		84,
		0,
		44,
		32
	}
	local temp_scale = 1
	local eq_h = 64 / (PlayerBase.USE_GRENADES and 3 or 2)
	local eq_w = 48
	local eq_tm_scale = PlayerBase.USE_GRENADES and 1 or 0.75
	local deployable_equipment_panel = self._player_panel:panel({
		name = "deployable_equipment_panel",
		layer = 1,
		w = eq_w,
		h = eq_h,
		x = weapons_panel:right() + 4,
		y = weapons_panel:y()
	})
	deployable_equipment_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = eq_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = deployable_equipment_panel:w(),
		x = 0
	})
	local equipment = deployable_equipment_panel:bitmap({
		name = "equipment",
		visible = false,
		layer = 1,
		color = Color.white,
		w = deployable_equipment_panel:h() * temp_scale,
		h = deployable_equipment_panel:h() * temp_scale,
		x = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2,
		y = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2
	})
	local amount = deployable_equipment_panel:text({
		name = "amount",
		visible = false,
		text = tostring(12),
		font = "fonts/font_medium_mf",
		font_size = 22,
		color = Color.white,
		align = "right",
		vertical = "center",
		layer = 2,
		x = -2,
		y = 2,
		w = deployable_equipment_panel:w(),
		h = deployable_equipment_panel:h()
	})
	if not main_player then
		local scale = eq_tm_scale
		deployable_equipment_panel:set_size(deployable_equipment_panel:w() * 0.9, deployable_equipment_panel:h() * scale)
		equipment:set_size(equipment:w() * scale, equipment:h() * scale)
		equipment:set_center_y(deployable_equipment_panel:h() / 2)
		equipment:set_x(equipment:x() + 4)
		amount:set_center_y(deployable_equipment_panel:h() / 2)
		amount:set_right(deployable_equipment_panel:w() - 4)
		deployable_equipment_panel:set_x(weapons_panel:right() - 8)
		deployable_equipment_panel:set_bottom(weapons_panel:bottom())
		local bg = deployable_equipment_panel:child("bg")
		bg:set_size(deployable_equipment_panel:size())
	end
	local texture, rect = tweak_data.hud_icons:get_icon_data(tweak_data.equipments.specials.cable_tie.icon)
	local cable_ties_panel = self._player_panel:panel({
		name = "cable_ties_panel",
		visible = true,
		layer = 1,
		w = eq_w,
		h = eq_h,
		x = weapons_panel:right() + 4,
		y = weapons_panel:y()
	})
	cable_ties_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = eq_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = deployable_equipment_panel:w(),
		x = 0
	})
	local cable_ties = cable_ties_panel:bitmap({
		name = "cable_ties",
		visible = false,
		texture = texture,
		texture_rect = rect,
		layer = 1,
		color = Color.white,
		w = deployable_equipment_panel:h() * temp_scale,
		h = deployable_equipment_panel:h() * temp_scale,
		x = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2,
		y = -(deployable_equipment_panel:h() * temp_scale - deployable_equipment_panel:h()) / 2
	})
	local amount = cable_ties_panel:text({
		name = "amount",
		visible = false,
		text = tostring(12),
		font = "fonts/font_medium_mf",
		font_size = 22,
		color = Color.white,
		align = "right",
		vertical = "center",
		layer = 2,
		x = -2,
		y = 2,
		w = deployable_equipment_panel:w(),
		h = deployable_equipment_panel:h()
	})
	if PlayerBase.USE_GRENADES then
		cable_ties_panel:set_center_y(weapons_panel:center_y())
	else
		cable_ties_panel:set_bottom(weapons_panel:bottom())
	end
	if not main_player then
		local scale = eq_tm_scale
		cable_ties_panel:set_size(cable_ties_panel:w() * 0.9, cable_ties_panel:h() * scale)
		cable_ties:set_size(cable_ties:w() * scale, cable_ties:h() * scale)
		cable_ties:set_center_y(cable_ties_panel:h() / 2)
		cable_ties:set_x(cable_ties:x() + 4)
		amount:set_center_y(cable_ties_panel:h() / 2)
		amount:set_right(cable_ties_panel:w() - 4)
		cable_ties_panel:set_x(deployable_equipment_panel:right())
		cable_ties_panel:set_bottom(deployable_equipment_panel:bottom())
		local bg = cable_ties_panel:child("bg")
		bg:set_size(cable_ties_panel:size())
	end
	if PlayerBase.USE_GRENADES then
		local texture, rect = tweak_data.hud_icons:get_icon_data("frag_grenade")
		local grenades_panel = self._player_panel:panel({
			name = "grenades_panel",
			visible = true,
			layer = 1,
			w = eq_w,
			h = eq_h,
			x = weapons_panel:right() + 4,
			y = weapons_panel:y()
		})
		grenades_panel:bitmap({
			name = "bg",
			texture = tabs_texture,
			texture_rect = eq_rect,
			visible = true,
			layer = 0,
			color = bg_color,
			w = cable_ties_panel:w(),
			x = 0
		})
		local grenades = grenades_panel:bitmap({
			name = "grenades",
			visible = true,
			texture = texture,
			texture_rect = rect,
			layer = 1,
			color = Color.white,
			w = cable_ties_panel:h() * temp_scale,
			h = cable_ties_panel:h() * temp_scale,
			x = -(cable_ties_panel:h() * temp_scale - cable_ties_panel:h()) / 2,
			y = -(cable_ties_panel:h() * temp_scale - cable_ties_panel:h()) / 2
		})
		local amount = grenades_panel:text({
			name = "amount",
			visible = true,
			text = tostring("03"),
			font = "fonts/font_medium_mf",
			font_size = 22,
			color = Color.white,
			align = "right",
			vertical = "center",
			layer = 2,
			x = -2,
			y = 2,
			w = grenades_panel:w(),
			h = grenades_panel:h()
		})
		grenades_panel:set_bottom(weapons_panel:bottom())
		if not main_player then
			local scale = eq_tm_scale
			grenades_panel:set_size(grenades_panel:w() * 0.9, grenades_panel:h() * scale)
			grenades:set_size(grenades:w() * scale, grenades:h() * scale)
			grenades:set_center_y(grenades_panel:h() / 2)
			grenades:set_x(grenades:x() + 4)
			amount:set_center_y(grenades_panel:h() / 2)
			amount:set_right(grenades_panel:w() - 4)
			grenades_panel:set_x(cable_ties_panel:right())
			grenades_panel:set_bottom(cable_ties_panel:bottom())
			local bg = grenades_panel:child("bg")
			bg:set_size(grenades_panel:size())
		end
	end
	local bag_rect = {
		32,
		33,
		32,
		31
	}
	local bg_rect = {
		84,
		0,
		44,
		32
	}
	local bag_w = bag_rect[3]
	local bag_h = bag_rect[4]
	local carry_panel = self._player_panel:panel({
		name = "carry_panel",
		visible = false,
		layer = 1,
		w = bag_w,
		h = bag_h + 2,
		x = 0,
		y = radial_health_panel:top() - bag_h
	})
	carry_panel:set_x(24 - bag_w / 2)
	carry_panel:set_center_x(radial_health_panel:center_x())
	carry_panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = false,
		layer = 0,
		color = bg_color,
		x = 0,
		y = 0,
		w = 100,
		h = carry_panel:h()
	})
	carry_panel:bitmap({
		name = "bag",
		texture = tabs_texture,
		w = bag_w,
		h = bag_h,
		texture_rect = bag_rect,
		visible = true,
		layer = 0,
		color = Color.white,
		x = 1,
		y = 1
	})
	carry_panel:text({
		name = "value",
		visible = false,
		text = "",
		layer = 0,
		color = Color.white,
		x = bag_rect[3] + 4,
		y = 0,
		vertical = "center",
		font_size = tweak_data.hud.small_font_size,
		font = "fonts/font_small_mf"
	})
	local interact_panel = self._player_panel:panel({
		name = "interact_panel",
		visible = false,
		layer = 3
	})
	interact_panel:set_shape(weapons_panel:shape())
	interact_panel:set_shape(radial_health_panel:shape())
	interact_panel:set_size(radial_size * 1.25, radial_size * 1.25)
	interact_panel:set_center(radial_health_panel:center())
	local radius = interact_panel:h() / 2 - 4
	self._interact = CircleBitmapGuiObject:new(interact_panel, {
		use_bg = true,
		rotation = 360,
		radius = radius,
		blend_mode = "add",
		color = Color.white,
		layer = 0
	})
	self._interact:set_position(4, 4)
	self._special_equipment = {}
	self._panel = teammate_panel
	self:create_waiting_panel(teammates_panel)
end

function HUDTeammate:recreate_weapon_firemode()
	self:_create_primary_weapon_firemode()
	self:_create_secondary_weapon_firemode()
end

function HUDTeammate:_create_equipment(panel, icon_name, scale)
	scale = scale or 1
	local icon, rect
	if icon_name then
		icon, rect = tweak_data.hud_icons:get_icon_data(icon_name)
	end
	local eq_h = 21.333334
	local eq_w = 48
	local eq_rect = {
		84,
		0,
		44,
		32
	}
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_color = Color.white / 3
	panel:set_w(eq_w * scale)
	panel:set_h(eq_h * scale)
	local vis_at_start = true
	local bg = panel:bitmap({
		name = "bg",
		texture = tabs_texture,
		texture_rect = eq_rect,
		visible = true,
		layer = 0,
		color = bg_color,
		w = panel:w(),
		h = panel:h(),
		x = 0
	})
	local icon = panel:bitmap({
		name = "icon",
		texture = icon,
		texture_rect = rect,
		visible = vis_at_start,
		layer = 1,
		color = Color.white,
		w = panel:h() * scale,
		h = panel:h() * scale,
		x = 2
	})
	local amount = panel:text({
		name = "amount",
		visible = vis_at_start,
		text = "00",
		font = "fonts/font_medium_mf",
		font_size = 22,
		color = Color.white,
		align = "center",
		vertical = "center",
		layer = 2,
		w = panel:w(),
		h = panel:h()
	})
	managers.hud:make_fine_text(amount)
	amount:set_right(bg:right() - 2)
	amount:set_center_y(bg:center_y() + 1)
end

function HUDTeammate:_create_primary_weapon_firemode()
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	local weapon_selection_panel = primary_weapon_panel:child("weapon_selection")
	local old_single = weapon_selection_panel:child("firemode_single")
	local old_auto = weapon_selection_panel:child("firemode_auto")
	if alive(old_single) then
		weapon_selection_panel:remove(old_single)
	end
	if alive(old_auto) then
		weapon_selection_panel:remove(old_auto)
	end
	if self._main_player then
		local equipped_primary = managers.blackmarket:equipped_primary()
		local weapon_tweak_data = tweak_data.weapon[equipped_primary.weapon_id]
		local fire_mode = weapon_tweak_data.FIRE_MODE
		local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE
		local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped_primary.factory_id, equipped_primary.blueprint)
		local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped_primary.factory_id, equipped_primary.blueprint)
		local single_id = "firemode_single" .. ((not can_toggle_firemode or locked_to_single) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(single_id)
		local firemode_single = weapon_selection_panel:bitmap({
			name = "firemode_single",
			texture = texture,
			texture_rect = texture_rect,
			x = 2,
			blend_mode = "mul",
			layer = 1
		})
		firemode_single:set_bottom(weapon_selection_panel:h() - 2)
		firemode_single:hide()
		local auto_id = "firemode_auto" .. ((not can_toggle_firemode or locked_to_auto) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(auto_id)
		local firemode_auto = weapon_selection_panel:bitmap({
			name = "firemode_auto",
			texture = texture,
			texture_rect = texture_rect,
			x = 2,
			blend_mode = "mul",
			layer = 1
		})
		firemode_auto:set_bottom(weapon_selection_panel:h() - 2)
		firemode_auto:hide()
		if locked_to_single or not locked_to_auto and fire_mode == "single" then
			firemode_single:show()
		else
			firemode_auto:show()
		end
	end
end

function HUDTeammate:_create_secondary_weapon_firemode()
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local weapon_selection_panel = secondary_weapon_panel:child("weapon_selection")
	local old_single = weapon_selection_panel:child("firemode_single")
	local old_auto = weapon_selection_panel:child("firemode_auto")
	if alive(old_single) then
		weapon_selection_panel:remove(old_single)
	end
	if alive(old_auto) then
		weapon_selection_panel:remove(old_auto)
	end
	if self._main_player then
		local equipped_secondary = managers.blackmarket:equipped_secondary()
		local weapon_tweak_data = tweak_data.weapon[equipped_secondary.weapon_id]
		local fire_mode = weapon_tweak_data.FIRE_MODE
		local can_toggle_firemode = weapon_tweak_data.CAN_TOGGLE_FIREMODE
		local locked_to_auto = managers.weapon_factory:has_perk("fire_mode_auto", equipped_secondary.factory_id, equipped_secondary.blueprint)
		local locked_to_single = managers.weapon_factory:has_perk("fire_mode_single", equipped_secondary.factory_id, equipped_secondary.blueprint)
		local single_id = "firemode_single" .. ((not can_toggle_firemode or locked_to_single) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(single_id)
		local firemode_single = weapon_selection_panel:bitmap({
			name = "firemode_single",
			texture = texture,
			texture_rect = texture_rect,
			x = 2,
			blend_mode = "mul",
			layer = 1
		})
		firemode_single:set_bottom(weapon_selection_panel:h() - 2)
		firemode_single:hide()
		local auto_id = "firemode_auto" .. ((not can_toggle_firemode or locked_to_auto) and "_locked" or "")
		local texture, texture_rect = tweak_data.hud_icons:get_icon_data(auto_id)
		local firemode_auto = weapon_selection_panel:bitmap({
			name = "firemode_auto",
			texture = texture,
			texture_rect = texture_rect,
			x = 2,
			blend_mode = "mul",
			layer = 1
		})
		firemode_auto:set_bottom(weapon_selection_panel:h() - 2)
		firemode_auto:hide()
		if locked_to_single or not locked_to_auto and fire_mode == "single" then
			firemode_single:show()
		else
			firemode_auto:show()
		end
	end
end

function HUDTeammate:_rec_round_object(object)
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
	local x, y = object:position()
	object:set_position(math.round(x), math.round(y))
end

function HUDTeammate:panel()
	return self._panel
end

function HUDTeammate:create_waiting_panel(parent_panel)
	local PADD = 2
	local panel = parent_panel:panel()
	print(self._panel:lefttop())
	print(panel:lefttop())
	print(self._panel:world_x(), self._panel:world_y())
	print(panel:world_x(), panel:world_y())
	panel:set_visible(false)
	panel:set_lefttop(self._panel:lefttop())
	local name = panel:text({
		name = "name",
		font_size = tweak_data.hud_players.name_size,
		font = tweak_data.hud_players.name_font
	})
	local player_panel = self._panel:child("player")
	local health_panel = player_panel:child("radial_health_panel")
	local detection = panel:panel({
		name = "detection",
		w = health_panel:w(),
		h = health_panel:h()
	})
	detection:set_lefttop(health_panel:lefttop())
	local detection_ring_left_bg = detection:bitmap({
		name = "detection_left_bg",
		texture = "guis/textures/pd2/mission_briefing/inv_detection_meter",
		alpha = 0.2,
		blend_mode = "add",
		w = detection:w(),
		h = detection:h()
	})
	local detection_ring_right_bg = detection:bitmap({
		name = "detection_right_bg",
		texture = "guis/textures/pd2/mission_briefing/inv_detection_meter",
		alpha = 0.2,
		blend_mode = "add",
		w = detection:w(),
		h = detection:h()
	})
	detection_ring_right_bg:set_texture_rect(detection_ring_right_bg:texture_width(), 0, -detection_ring_right_bg:texture_width(), detection_ring_right_bg:texture_height())
	local detection_ring_left = detection:bitmap({
		name = "detection_left",
		texture = "guis/textures/pd2/mission_briefing/inv_detection_meter",
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1,
		w = detection:w(),
		h = detection:h()
	})
	local detection_ring_right = detection:bitmap({
		name = "detection_right",
		texture = "guis/textures/pd2/mission_briefing/inv_detection_meter",
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1,
		w = detection:w(),
		h = detection:h()
	})
	detection_ring_right:set_texture_rect(detection_ring_right:texture_width(), 0, -detection_ring_right:texture_width(), detection_ring_right:texture_height())
	local detection_value = panel:text({
		name = "detection_value",
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		align = "center",
		vertical = "center"
	})
	detection_value:set_center_x(detection:left() + detection:w() / 2)
	detection_value:set_center_y(detection:top() + detection:h() / 2 + 2)
	local bg_rect = {
		84,
		0,
		44,
		32
	}
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_color = Color.white / 3
	name:set_lefttop(detection:right() + PADD, detection:top())
	local bg = panel:bitmap({
		name = "name_bg",
		texture = tabs_texture,
		texture_rect = bg_rect,
		visible = true,
		layer = -1,
		color = bg_color,
		y = name:y() - PADD
	})
	bg:set_lefttop(detection:right() + PADD, detection:top())
	local deploy_panel = panel:panel({name = "deploy"})
	local throw_panel = panel:panel({name = "throw"})
	local perk_panel = panel:panel({name = "perk"})
	self:_create_equipment(deploy_panel, "frag_grenade")
	self:_create_equipment(throw_panel, "frag_grenade")
	self:_create_equipment(perk_panel, "frag_grenade")
	deploy_panel:set_lefttop(detection:right() + PADD, detection:center_y())
	throw_panel:set_lefttop(deploy_panel:right() + PADD, deploy_panel:top())
	perk_panel:set_lefttop(throw_panel:right() + PADD, deploy_panel:top())
	self._wait_panel = panel
end

local set_icon_data = function(image, icon, rect)
	if rect then
		image:set_image(icon, unpack(rect))
		return
	end
	local text, rect = tweak_data.hud_icons:get_icon_data(icon or "fallback")
	image:set_image(text, unpack(rect))
end

function HUDTeammate:set_waiting(waiting, peer)
	local my_peer = managers.network:session():peer(self._peer_id)
	peer = peer or my_peer
	if self._wait_panel then
		if waiting then
			self._panel:set_visible(false)
			self._wait_panel:set_lefttop(self._panel:lefttop())
			local name = self._wait_panel:child("name")
			local name_bg = self._wait_panel:child("name_bg")
			local detection = self._wait_panel:child("detection")
			local detection_value = self._wait_panel:child("detection_value")
			local current, reached = managers.blackmarket:get_suspicion_offset_of_peer(peer, tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
			detection:child("detection_left"):set_color(Color(0.5 + current * 0.5, 1, 1))
			detection:child("detection_right"):set_color(Color(0.5 + current * 0.5, 1, 1))
			detection_value:set_text(math.round(current * 100))
			if reached then
				detection_value:set_color(Color(255, 255, 42, 0) / 255)
			else
				detection_value:set_color(tweak_data.screen_colors.text)
			end
			local outfit = peer:profile().outfit
			outfit = outfit or managers.blackmarket:unpack_outfit_from_string(peer:profile().outfit_string) or {}
			name:set_text(" " .. peer:name() .. "  " .. (0 < peer:rank() and managers.experience:rank_string(peer:rank()) .. "-" or "") .. (peer:level() or "") .. "")
			managers.hud:make_fine_text(name)
			name_bg:set_w(name:w() + 4)
			name_bg:set_h(name:h())
			local has_deployable = outfit.deployable and outfit.deployable ~= "nil"
			self._wait_panel:child("deploy"):child("amount"):set_text(has_deployable and outfit.deployable_amount or "")
			self._wait_panel:child("throw"):child("amount"):set_text(managers.player:get_max_grenades(peer:grenade_id()))
			self._wait_panel:child("perk"):child("amount"):set_text(outfit.skills.specializations[2])
			local deploy_image = self._wait_panel:child("deploy"):child("icon")
			if has_deployable then
				set_icon_data(deploy_image, tweak_data.equipments[outfit.deployable].icon)
				deploy_image:set_position(0, 0)
			else
				set_icon_data(deploy_image, "none_icon")
				deploy_image:set_world_center(self._wait_panel:child("deploy"):world_center())
			end
			set_icon_data(self._wait_panel:child("throw"):child("icon"), outfit.grenade and tweak_data.blackmarket.projectiles[outfit.grenade].icon)
			set_icon_data(self._wait_panel:child("perk"):child("icon"), tweak_data.skilltree:get_specialization_icon_data(tonumber(outfit.skills.specializations[1])))
		elseif self._ai or my_peer and my_peer:unit() then
			self._panel:set_visible(true)
		end
		self._wait_panel:set_visible(waiting)
	end
end

function HUDTeammate:is_waiting()
	return self._wait_panel:visible()
end

function HUDTeammate:add_panel()
	local teammate_panel = self._panel
	if not self._wait_panel:visible() then
		teammate_panel:set_visible(true)
	end
end

function HUDTeammate:remove_panel()
	local teammate_panel = self._panel
	teammate_panel:set_visible(false)
	local special_equipment = self._special_equipment
	while special_equipment[1] do
		teammate_panel:remove(table.remove(special_equipment))
	end
	self:set_condition("mugshot_normal")
	self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):set_visible(false)
	self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):set_visible(false)
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	deployable_equipment_panel:child("equipment"):set_visible(false)
	deployable_equipment_panel:child("amount"):set_visible(false)
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	cable_ties_panel:child("cable_ties"):set_visible(false)
	cable_ties_panel:child("amount"):set_visible(false)
	self._player_panel:child("carry_panel"):set_visible(false)
	self._player_panel:child("carry_panel"):child("value"):set_text("")
	self:set_cheater(false)
	self:set_info_meter({
		current = 0,
		total = 0,
		max = 1
	})
	self:stop_timer()
	self:teammate_progress(false, false, false, false)
	self._peer_id = nil
	self._ai = nil
end

function HUDTeammate:peer_id()
	return self._peer_id
end

function HUDTeammate:set_peer_id(peer_id)
	self._peer_id = peer_id
end

function HUDTeammate:set_ai(ai)
	self._ai = ai
end

function HUDTeammate:_set_weapon_selected(id, hud_icon)
	local is_secondary = id == 1
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	primary_weapon_panel:set_alpha(is_secondary and 0.5 or 1)
	secondary_weapon_panel:set_alpha(is_secondary and 1 or 0.5)
end

function HUDTeammate:set_weapon_selected(id, hud_icon)
	self:_set_weapon_selected(id, hud_icon)
end

function HUDTeammate:set_weapon_firemode(id, firemode)
	local is_secondary = id == 1
	local secondary_weapon_panel = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel")
	local primary_weapon_panel = self._player_panel:child("weapons_panel"):child("primary_weapon_panel")
	local weapon_selection = is_secondary and secondary_weapon_panel:child("weapon_selection") or primary_weapon_panel:child("weapon_selection")
	if alive(weapon_selection) then
		local firemode_single = weapon_selection:child("firemode_single")
		local firemode_auto = weapon_selection:child("firemode_auto")
		if alive(firemode_single) and alive(firemode_auto) then
			if firemode == "single" then
				firemode_single:show()
				firemode_auto:hide()
			else
				firemode_single:hide()
				firemode_auto:show()
			end
		end
	end
end

function HUDTeammate:set_ammo_amount_by_type(type, max_clip, current_clip, current_left, max)
	local weapon_panel = self._player_panel:child("weapons_panel"):child(type .. "_weapon_panel")
	weapon_panel:set_visible(true)
	local low_ammo = current_left <= math.round(max_clip / 2)
	local low_ammo_clip = current_clip <= math.round(max_clip / 4)
	local out_of_ammo_clip = current_clip <= 0
	local out_of_ammo = current_left <= 0
	local color_total = out_of_ammo and Color(1, 0.9, 0.3, 0.3)
	color_total = color_total or low_ammo and Color(1, 0.9, 0.9, 0.3)
	color_total = color_total or Color.white
	local color_clip = out_of_ammo_clip and Color(1, 0.9, 0.3, 0.3)
	color_clip = color_clip or low_ammo_clip and Color(1, 0.9, 0.9, 0.3)
	color_clip = color_clip or Color.white
	local ammo_clip = weapon_panel:child("ammo_clip")
	local zero = current_clip < 10 and "00" or current_clip < 100 and "0" or ""
	ammo_clip:set_text(zero .. tostring(current_clip))
	ammo_clip:set_color(color_clip)
	ammo_clip:set_range_color(0, string.len(zero), color_clip:with_alpha(0.5))
	local ammo_total = weapon_panel:child("ammo_total")
	local zero = current_left < 10 and "00" or current_left < 100 and "0" or ""
	ammo_total:set_text(zero .. tostring(current_left))
	ammo_total:set_color(color_total)
	ammo_total:set_range_color(0, string.len(zero), color_total:with_alpha(0.5))
end

function HUDTeammate:set_health(data)
	self._health_data = data
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_rip = radial_health_panel:child("radial_rip")
	local radial_rip_bg = radial_health_panel:child("radial_rip_bg")
	local red = data.current / data.total
	radial_health:stop()
	if red < radial_health:color().red then
		self:_damage_taken()
		radial_health:set_color(Color(1, red, 1, 1))
		if alive(radial_rip) then
			radial_rip:set_rotation((1 - radial_health:color().r) * 360)
			radial_rip_bg:set_rotation((1 - radial_health:color().r) * 360)
		end
	else
		radial_health:animate(function(o)
			local s = radial_health:color().r
			local e = red
			over(0.2, function(p)
				radial_health:set_color(Color(1, math.lerp(s, e, p), 1, 1))
				if alive(radial_rip) then
					radial_rip:set_rotation((1 - radial_health:color().r) * 360)
					radial_rip_bg:set_rotation((1 - radial_health:color().r) * 360)
				end
			end)
		end)
	end
end

function HUDTeammate:set_armor(data)
	local teammate_panel = self._panel:child("player")
	self._armor_data = data
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_shield = radial_health_panel:child("radial_shield")
	local red = data.current / data.total
	radial_shield:set_color(Color(1, red, 1, 1))
end

function HUDTeammate:set_custom_radial(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_custom = radial_health_panel:child("radial_custom")
	local red = data.current / data.total
	radial_custom:set_color(Color(1, red, 1, 1))
	radial_custom:set_visible(0 < red)
end

function HUDTeammate:_damage_taken()
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local damage_indicator = radial_health_panel:child("damage_indicator")
	damage_indicator:stop()
	damage_indicator:animate(callback(self, self, "_animate_damage_taken"))
end

function HUDTeammate:_animate_damage_taken(damage_indicator)
	damage_indicator:set_alpha(1)
	local st = 3
	local t = st
	local st_red_t = 0.5
	local red_t = st_red_t
	while 0 < t do
		local dt = coroutine.yield()
		t = t - dt
		red_t = math.clamp(red_t - dt, 0, 1)
		damage_indicator:set_color(Color(1, red_t / st_red_t, red_t / st_red_t))
		damage_indicator:set_alpha(t / st)
	end
	damage_indicator:set_alpha(0)
end

function HUDTeammate:set_name(teammate_name)
	local teammate_panel = self._panel
	local name = teammate_panel:child("name")
	local name_bg = teammate_panel:child("name_bg")
	local callsign = teammate_panel:child("callsign")
	name:set_text(" " .. teammate_name)
	local h = name:h()
	managers.hud:make_fine_text(name)
	name:set_h(h)
	name_bg:set_w(name:w() + 4)
end

function HUDTeammate:set_cheater(state)
	self._panel:child("name"):set_color(state and tweak_data.screen_colors.pro_color or Color.white)
end

function HUDTeammate:set_callsign(id)
	local teammate_panel = self._panel
	local callsign = teammate_panel:child("callsign")
	local alpha = callsign:color().a
	callsign:set_color((tweak_data.chat_colors[id] or tweak_data.chat_colors[#tweak_data.chat_colors]):with_alpha(alpha))
end

function HUDTeammate:set_cable_tie(data)
	local teammate_panel = self._panel:child("player")
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	local cable_ties2 = cable_ties_panel:child("cable_ties")
	cable_ties2:set_image(icon, unpack(texture_rect))
	cable_ties2:set_visible(true)
	self:set_cable_ties_amount(data.amount)
	return nil
end

function HUDTeammate:set_cable_ties_amount(amount)
	local visible = amount ~= 0
	local cable_ties_panel = self._player_panel:child("cable_ties_panel")
	local cable_ties_amount = cable_ties_panel:child("amount")
	cable_ties_amount:set_visible(visible)
	if amount == -1 then
		cable_ties_amount:set_text("--")
	else
		self:_set_amount_string(cable_ties_amount, amount)
	end
	local cable_ties = cable_ties_panel:child("cable_ties")
	cable_ties:set_visible(visible)
end

function HUDTeammate:_set_amount_string(text, amount)
	if not PlayerBase.USE_GRENADES then
		text:set_text(tostring(amount))
		return
	end
	local zero = self._main_player and amount < 10 and "0" or ""
	text:set_text(zero .. amount)
	text:set_range_color(0, string.len(zero), Color.white:with_alpha(0.5))
end

function HUDTeammate:set_state(state)
	local teammate_panel = self._panel
	local is_player = state == "player"
	teammate_panel:child("player"):set_alpha(is_player and 1 or 0)
	local name = teammate_panel:child("name")
	local name_bg = teammate_panel:child("name_bg")
	local callsign_bg = teammate_panel:child("callsign_bg")
	local callsign = teammate_panel:child("callsign")
	if not self._main_player then
		if is_player then
			name:set_x(48 + name:h() + 4)
			name:set_bottom(teammate_panel:h() - 30)
		else
			name:set_x(48 + name:h() + 4)
			name:set_bottom(teammate_panel:h())
		end
		name_bg:set_position(name:x(), name:y() - 1)
		callsign_bg:set_position(name:x() - name:h(), name:y() + 1)
		callsign:set_position(name:x() - name:h(), name:y() + 1)
	end
end

function HUDTeammate:set_deployable_equipment(data)
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	local equipment = deployable_equipment_panel:child("equipment")
	equipment:set_visible(true)
	equipment:set_image(icon, unpack(texture_rect))
	self:set_deployable_equipment_amount(1, data)
end

function HUDTeammate:set_deployable_equipment_from_string(data)
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	local equipment = deployable_equipment_panel:child("equipment")
	equipment:set_visible(true)
	equipment:set_image(icon, unpack(texture_rect))
	self:set_deployable_equipment_amount_from_string(1, data)
end

function HUDTeammate:set_deployable_equipment_amount(index, data)
	local teammate_panel = self._panel:child("player")
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	local amount = deployable_equipment_panel:child("amount")
	deployable_equipment_panel:child("equipment"):set_visible(data.amount ~= 0)
	self:_set_amount_string(amount, data.amount)
	amount:set_visible(data.amount ~= 0)
end

function HUDTeammate:set_deployable_equipment_amount_from_string(index, data)
	local teammate_panel = self._panel:child("player")
	local deployable_equipment_panel = self._player_panel:child("deployable_equipment_panel")
	local amount = deployable_equipment_panel:child("amount")
	local visible = false
	for i = 1, #data.amount do
		if data.amount[i] > 0 then
			visible = true
		end
	end
	deployable_equipment_panel:child("equipment"):set_visible(visible)
	amount:set_text(data.amount_str)
	amount:set_visible(visible)
end

function HUDTeammate:set_grenades(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	local grenades_panel = self._player_panel:child("grenades_panel")
	local grenades = grenades_panel:child("grenades")
	grenades:set_visible(true)
	grenades:set_image(icon, unpack(texture_rect))
	self:set_grenades_amount(data)
end

function HUDTeammate:set_ability_cooldown(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
	data.cooldown = data.cooldown and math.ceil(data.cooldown) or 0
	local teammate_panel = self._panel:child("player")
	local grenades_panel = self._player_panel:child("grenades_panel")
	local amount = grenades_panel:child("amount")
	self:_set_amount_string(amount, data.cooldown)
	amount:set_visible(data.cooldown > 0)
end

function HUDTeammate:set_ability_radial(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_ability = radial_health_panel:child("radial_ability")
	local red = data.current / data.total
	radial_ability:set_color(Color(1, red, 1, 1))
	radial_ability:set_visible(0 < red)
end

function HUDTeammate:activate_ability_radial(time)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_ability = radial_health_panel:child("radial_ability")
	
	local function anim(o)
		radial_ability:set_visible(true)
		over(time, function(p)
			radial_ability:set_color(Color(1, math.lerp(1, 0, p), 1, 1))
		end)
		radial_ability:set_visible(false)
	end
	
	radial_ability:animate(anim)
end

function HUDTeammate:set_grenades_amount(data)
	if not PlayerBase.USE_GRENADES then
		return
	end
	if data.has_cooldown then
		self:set_ability_cooldown(data)
		return
	end
	local teammate_panel = self._panel:child("player")
	local grenades_panel = self._player_panel:child("grenades_panel")
	local amount = grenades_panel:child("amount")
	grenades_panel:child("grenades"):set_visible(data.amount ~= 0)
	self:_set_amount_string(amount, data.amount)
	amount:set_visible(data.amount ~= 0)
end

function HUDTeammate:set_carry_info(carry_id, value)
	local carry_panel = self._player_panel:child("carry_panel")
	carry_panel:set_visible(true)
	local value_text = carry_panel:child("value")
	value_text:set_text(managers.experience:cash_string(value))
	local _, _, w, _ = value_text:text_rect()
	local bg = carry_panel:child("bg")
	bg:set_w(carry_panel:child("bag"):w() + w + 4)
end

function HUDTeammate:remove_carry_info()
	local carry_panel = self._player_panel:child("carry_panel")
	carry_panel:set_visible(false)
end

function HUDTeammate:add_special_equipment(data)
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	local id = data.id
	local equipment_panel = teammate_panel:panel({
		name = id,
		layer = 0,
		y = 0
	})
	local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
	equipment_panel:set_size(32, 32)
	local bitmap = equipment_panel:bitmap({
		name = "bitmap",
		texture = icon,
		color = Color.white,
		texture_rect = texture_rect,
		layer = 0,
		w = equipment_panel:w(),
		h = equipment_panel:h(),
		rotation = 360
	})
	local flash_icon = equipment_panel:bitmap({
		name = "bitmap",
		texture = icon,
		color = tweak_data.hud.prime_color,
		texture_rect = texture_rect,
		layer = 1,
		w = equipment_panel:w() + 2,
		h = equipment_panel:h() + 2,
		rotation = 360
	})
	local w = teammate_panel:w()
	equipment_panel:set_x(w - (equipment_panel:w() + 0) * #special_equipment)
	table.insert(special_equipment, equipment_panel)
	local amount, amount_bg
	if data.amount then
		amount_bg = equipment_panel:child("amount_bg") or equipment_panel:bitmap({
			name = "amount_bg",
			texture = "guis/textures/pd2/equip_count",
			color = Color.white,
			layer = 2,
			rotation = 360
		})
		amount = equipment_panel:child("amount") or equipment_panel:text({
			name = "amount",
			text = tostring(data.amount),
			font = "fonts/font_small_noshadow_mf",
			font_size = 12,
			color = Color.black,
			align = "center",
			vertical = "center",
			layer = 3,
			w = equipment_panel:w(),
			h = equipment_panel:h(),
			rotation = 360
		})
		amount_bg:set_center(bitmap:center())
		amount_bg:move(7, 7)
		amount_bg:set_visible(1 < data.amount)
		amount:set_center(amount_bg:center())
		amount:set_visible(1 < data.amount)
	end
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	flash_icon:set_center(bitmap:center())
	flash_icon:animate(hud.flash_icon, nil, equipment_panel)
	self:layout_special_equipments()
end

function HUDTeammate:remove_special_equipment(equipment)
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	for i, panel in ipairs(special_equipment) do
		if panel:name() == equipment then
			local data = table.remove(special_equipment, i)
			teammate_panel:remove(panel)
			self:layout_special_equipments()
			return
		end
	end
end

function HUDTeammate:layout_special_equipments()
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	local container_width = teammate_panel:w()
	local row_width = math.floor(container_width / 32)
	for i, panel in ipairs(special_equipment) do
		local zi = i - 1
		local y_pos = -math.floor(zi / row_width) * panel:h()
		if self._main_player then
			panel:set_x(container_width - (panel:w() + 0) * (zi % row_width + 1))
			panel:set_y(y_pos)
		else
			panel:set_x(48 + panel:w() * (zi % row_width))
			panel:set_y(y_pos)
		end
	end
end

function HUDTeammate:set_special_equipment_amount(equipment_id, amount)
	local teammate_panel = self._panel
	local special_equipment = self._special_equipment
	for i, panel in ipairs(special_equipment) do
		if panel:name() == equipment_id then
			panel:child("amount"):set_text(tostring(amount))
			panel:child("amount"):set_visible(1 < amount)
			panel:child("amount_bg"):set_visible(1 < amount)
			return
		end
	end
end

function HUDTeammate:clear_special_equipment()
	self:remove_panel()
	self:add_panel()
end

function HUDTeammate:set_condition(icon_data, text)
	local condition_icon = self._panel:child("condition_icon")
	if icon_data == "mugshot_normal" then
		condition_icon:set_visible(false)
	else
		condition_icon:set_visible(true)
		local icon, texture_rect = tweak_data.hud_icons:get_icon_data(icon_data)
		condition_icon:set_image(icon, texture_rect[1], texture_rect[2], texture_rect[3], texture_rect[4])
	end
end

function HUDTeammate:teammate_progress(enabled, tweak_data_id, timer, success)
	self._player_panel:child("radial_health_panel"):set_alpha(enabled and 0.2 or 1)
	self._player_panel:child("interact_panel"):stop()
	self._player_panel:child("interact_panel"):set_visible(enabled)
	if enabled then
		self._player_panel:child("interact_panel"):animate(callback(HUDManager, HUDManager, "_animate_label_interact"), self._interact, timer)
	elseif success then
		local panel = self._player_panel
		local bitmap = panel:bitmap({
			rotation = 360,
			texture = "guis/textures/pd2/hud_progress_active",
			blend_mode = "add",
			align = "center",
			valign = "center",
			layer = 2
		})
		bitmap:set_size(self._interact:size())
		bitmap:set_position(self._player_panel:child("interact_panel"):x() + 4, self._player_panel:child("interact_panel"):y() + 4)
		local radius = self._interact:radius()
		local circle = CircleBitmapGuiObject:new(panel, {
			rotation = 360,
			radius = radius,
			color = Color.white:with_alpha(1),
			blend_mode = "normal",
			layer = 3
		})
		circle:set_position(bitmap:position())
		bitmap:animate(callback(HUDInteraction, HUDInteraction, "_animate_interaction_complete"), circle)
	end
end

function HUDTeammate:start_timer(time)
	self._timer_paused = 0
	self._timer = time
	self._panel:child("condition_timer"):set_font_size(tweak_data.hud_players.timer_size)
	self._panel:child("condition_timer"):set_color(Color.white)
	self._panel:child("condition_timer"):stop()
	self._panel:child("condition_timer"):set_visible(true)
	self._panel:child("condition_timer"):animate(callback(self, self, "_animate_timer"))
end

function HUDTeammate:set_pause_timer(pause)
	if not self._timer_paused then
		return
	end
	self._timer_paused = self._timer_paused + (pause and 1 or -1)
end

function HUDTeammate:stop_timer()
	if not alive(self._panel) then
		return
	end
	self._panel:child("condition_timer"):set_visible(false)
	self._panel:child("condition_timer"):stop()
end

function HUDTeammate:is_timer_running()
	return self._panel:child("condition_timer"):visible()
end

function HUDTeammate:_animate_timer()
	local rounded_timer = math.round(self._timer)
	while self._timer >= 0 do
		local dt = coroutine.yield()
		if self._timer_paused == 0 then
			self._timer = self._timer - dt
			local text = self._timer < 0 and "00" or (math.round(self._timer) < 10 and "0" or "") .. math.round(self._timer)
			self._panel:child("condition_timer"):set_text(text)
			if rounded_timer > math.round(self._timer) then
				rounded_timer = math.round(self._timer)
				if rounded_timer < 11 then
					self._panel:child("condition_timer"):animate(callback(self, self, "_animate_timer_flash"))
				end
			end
		end
	end
end

function HUDTeammate:_animate_timer_flash()
	local t = 0
	local condition_timer = self._panel:child("condition_timer")
	while t < 0.5 do
		t = t + coroutine.yield()
		local n = 1 - math.sin(t * 180)
		local r = math.lerp(1 or self._point_of_no_return_color.r, 1, n)
		local g = math.lerp(0 or self._point_of_no_return_color.g, 0.8, n)
		local b = math.lerp(0 or self._point_of_no_return_color.b, 0.2, n)
		condition_timer:set_color(Color(r, g, b))
		condition_timer:set_font_size(math.lerp(tweak_data.hud_players.timer_size, tweak_data.hud_players.timer_flash_size, n))
	end
	condition_timer:set_font_size(30)
end

function HUDTeammate:set_stored_health_max(stored_health_ratio)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_rip_bg = radial_health_panel:child("radial_rip_bg")
	if alive(radial_rip_bg) then
		local red = math.min(stored_health_ratio, 1)
		radial_rip_bg:set_visible(0 < red)
		radial_rip_bg:set_color(Color(1, red, 1, 1))
	end
end

function HUDTeammate:set_stored_health(stored_health_ratio)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_rip = radial_health_panel:child("radial_rip")
	if alive(radial_rip) then
		local radial_health = radial_health_panel:child("radial_health")
		local radial_rip_bg = radial_health_panel:child("radial_rip_bg")
		local red = math.min(stored_health_ratio, 1)
		radial_rip:set_visible(0 < red)
		radial_rip:stop()
		radial_rip:set_rotation((1 - radial_health:color().r) * 360)
		radial_rip_bg:set_rotation((1 - radial_health:color().r) * 360)
		if red < radial_rip:color().red then
			radial_rip:set_color(Color(1, red, 1, 1))
		else
			radial_rip:animate(function(o)
				local s = radial_rip:color().r
				local e = red
				over(0.2, function(p)
					radial_rip:set_color(Color(1, math.lerp(s, e, p), 1, 1))
				end)
			end)
		end
	end
end

function HUDTeammate:_animate_update_absorb(o, radial_absorb_shield_name, radial_absorb_health_name, var_name, blink)
	repeat
		coroutine.yield()
	until alive(self._panel) and self[var_name] and self._armor_data and self._health_data
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_shield = radial_health_panel:child("radial_shield")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_absorb_shield = radial_health_panel:child(radial_absorb_shield_name)
	local radial_absorb_health = radial_health_panel:child(radial_absorb_health_name)
	local radial_shield_rot = radial_shield:color().r
	local radial_health_rot = radial_health:color().r
	radial_absorb_shield:set_rotation((1 - radial_shield_rot) * 360)
	radial_absorb_health:set_rotation((1 - radial_health_rot) * 360)
	local current_absorb = 0
	local current_shield, current_health
	local step_speed = 1
	local lerp_speed = 1
	local dt, update_absorb
	local t = 0
	while alive(teammate_panel) do
		dt = coroutine.yield()
		if self[var_name] and self._armor_data and self._health_data then
			update_absorb = false
			current_shield = self._armor_data.current
			current_health = self._health_data.current
			if radial_shield:color().r ~= radial_shield_rot or radial_health:color().r ~= radial_health_rot then
				radial_shield_rot = radial_shield:color().r
				radial_health_rot = radial_health:color().r
				radial_absorb_shield:set_rotation((1 - radial_shield_rot) * 360)
				radial_absorb_health:set_rotation((1 - radial_health_rot) * 360)
				update_absorb = true
			end
			if current_absorb ~= self[var_name] then
				current_absorb = math.lerp(current_absorb, self[var_name], lerp_speed * dt)
				current_absorb = math.step(current_absorb, self[var_name], step_speed * dt)
				update_absorb = true
			end
			if blink then
				t = (t + dt * 0.5) % 1
				radial_absorb_shield:set_alpha(math.abs(math.sin(t * 180)) * 0.25 + 0.75)
				radial_absorb_health:set_alpha(math.abs(math.sin(t * 180)) * 0.25 + 0.75)
			end
			if update_absorb and 0 < current_absorb then
				local shield_ratio = current_shield == 0 and 0 or math.min(current_absorb / current_shield, 1)
				local health_ratio = current_health == 0 and 0 or math.min((current_absorb - shield_ratio * current_shield) / current_health, 1)
				local shield = math.clamp(shield_ratio * radial_shield_rot, 0, 1)
				local health = math.clamp(health_ratio * radial_health_rot, 0, 1)
				radial_absorb_shield:set_color(Color(1, shield, 1, 1))
				radial_absorb_health:set_color(Color(1, health, 1, 1))
				radial_absorb_shield:set_visible(0 < shield)
				radial_absorb_health:set_visible(0 < health)
			end
		end
	end
end

function HUDTeammate:animate_update_absorb_max(o)
	self:_animate_update_absorb(o, "radial_absorb_shield_max", "radial_absorb_health_max", "_absorb_max_amount")
end

function HUDTeammate:animate_update_absorb(o)
	self:_animate_update_absorb(o, "radial_absorb_shield", "radial_absorb_health", "_absorb_personal_amount")
end

function HUDTeammate:animate_update_absorb_active(o)
	self:_animate_update_absorb(o, "radial_absorb_shield_active", "radial_absorb_health_active", "_absorb_active_amount", true)
end

function HUDTeammate:set_absorb_max(absorb_amount)
	self._absorb_max_amount = absorb_amount
end

function HUDTeammate:set_absorb_personal(absorb_amount)
	self._absorb_personal_amount = absorb_amount
end

function HUDTeammate:set_absorb_active(absorb_amount)
	self._absorb_active_amount = absorb_amount
end

function HUDTeammate:set_info_meter(data)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local radial_info_meter = radial_health_panel:child("radial_info_meter")
	local radial_info_meter_bg = radial_health_panel:child("radial_info_meter_bg")
	local red = math.clamp(data.total / data.max, 0, 1)
	radial_info_meter_bg:set_color(Color(1, red, 1, 1))
	radial_info_meter_bg:set_visible(0 < red)
	radial_info_meter_bg:set_rotation(red * 360)
	local red = math.clamp(data.current / data.max, 0, 1)
	radial_info_meter:stop()
	radial_info_meter:animate(function(o)
		local s = radial_info_meter:color().r
		local e = red
		over(0.2, function(p)
			local c = math.lerp(s, e, p)
			radial_info_meter:set_color(Color(1, c, 1, 1))
			radial_info_meter:set_visible(0 < c)
		end)
	end)
end
