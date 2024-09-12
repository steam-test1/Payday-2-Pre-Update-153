function BlackMarketTweakData:_init_colors(tweak_data)
	self.colors = {}
	
	local white = Color.white
	local black = Color.black
	local red = Color.red
	local green = Color.green
	local blue = Color.blue
	local yellow = Color.yellow
	local magenta = Color(255, 255, 0, 255) / 255
	local cyan = Color(255, 0, 255, 255) / 255
	local light_gray = Color(255, 191, 191, 191) / 255
	local gray = Color(255, 128, 128, 128) / 255
	local dark_gray = Color(255, 64, 64, 64) / 255
	local blood_red = Color(255, 138, 17, 9) / 255
	local orange = Color(255, 255, 94, 15) / 255
	local light_brown = Color(255, 204, 115, 35) / 255
	local bright_yellow = Color(255, 255, 207, 76) / 255
	local lime_green = Color(255, 0, 166, 81) / 255
	local purple = Color(255, 154, 68, 220) / 255
	local pink = Color(255, 255, 122, 230) / 255
	local brown = Color(255, 128, 70, 13) / 255
	local navy_blue = Color(255, 40, 52, 86) / 255
	local matte_blue = Color(255, 56, 97, 168) / 255
	local olive_green = Color(255, 72, 90, 50) / 255
	local gray_blue = Color(255, 12, 68, 84) / 255
	local light_blue = Color(255, 126, 198, 238) / 255
	local bone_white = Color(255, 255, 238, 151) / 255
	local turquoise = Color(255, 0, 209, 157) / 255
	local matte_purple = Color(255, 107, 84, 144) / 255
	local coral_red = Color(255, 213, 36, 53) / 255
	local leaf_green = Color(255, 104, 191, 54) / 255
	local dark_green = Color(255, 7, 61, 9) / 255
	local warm_yellow = Color(255, 250, 157, 7) / 255
	local dark_red = Color(255, 110, 15, 22) / 255
	local cobalt_blue = Color(255, 0, 93, 199) / 255
	local toxic_green = Color(255, 167, 248, 87) / 255
	local nothing = Color(0, 0, 0, 0) / 255
	local skin_pink = Color(255, 230, 147, 140) / 255
	local sea_blue = Color(255, 6, 55, 56) / 255
	local dark_purple = Color(255, 107, 0, 74) / 255
	local scary_green = Color(255, 92, 255, 117) / 255
	self.colors.white_solid = {}
	self.colors.white_solid.colors = {white, white}
	self.colors.white_solid.name_id = "bm_clr_white_solid"
	self.colors.white_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_solid.value = 7
	self.colors.black_solid = {}
	self.colors.black_solid.colors = {black, black}
	self.colors.black_solid.name_id = "bm_clr_black_solid"
	self.colors.black_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_solid.value = 10
	self.colors.red_solid = {}
	self.colors.red_solid.colors = {red, red}
	self.colors.red_solid.name_id = "bm_clr_red_solid"
	self.colors.red_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_solid.value = 5
	self.colors.blue_solid = {}
	self.colors.blue_solid.colors = {blue, blue}
	self.colors.blue_solid.name_id = "bm_clr_blue_solid"
	self.colors.blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blue_solid.value = 8
	self.colors.green_solid = {}
	self.colors.green_solid.colors = {green, green}
	self.colors.green_solid.name_id = "bm_clr_green_solid"
	self.colors.green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_solid.value = 8
	self.colors.cyan_solid = {}
	self.colors.cyan_solid.colors = {cyan, cyan}
	self.colors.cyan_solid.name_id = "bm_clr_cyan_solid"
	self.colors.cyan_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_solid.value = 8
	self.colors.magenta_solid = {}
	self.colors.magenta_solid.colors = {magenta, magenta}
	self.colors.magenta_solid.name_id = "bm_clr_magenta_solid"
	self.colors.magenta_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.magenta_solid.value = 7
	self.colors.yellow_solid = {}
	self.colors.yellow_solid.colors = {yellow, yellow}
	self.colors.yellow_solid.name_id = "bm_clr_yellow_solid"
	self.colors.yellow_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_solid.value = 6
	self.colors.light_gray_solid = {}
	self.colors.light_gray_solid.colors = {light_gray, light_gray}
	self.colors.light_gray_solid.name_id = "bm_clr_light_gray_solid"
	self.colors.light_gray_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_solid.value = 7
	self.colors.dark_gray_solid = {}
	self.colors.dark_gray_solid.colors = {dark_gray, dark_gray}
	self.colors.dark_gray_solid.name_id = "bm_clr_dark_gray_solid"
	self.colors.dark_gray_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_gray_solid.value = 8
	self.colors.gray_solid = {}
	self.colors.gray_solid.colors = {gray, gray}
	self.colors.gray_solid.name_id = "bm_clr_gray_solid"
	self.colors.gray_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.gray_solid.value = 6
	self.colors.pink_solid = {}
	self.colors.pink_solid.colors = {pink, pink}
	self.colors.pink_solid.name_id = "bm_clr_pink_solid"
	self.colors.pink_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.pink_solid.value = 7
	self.colors.purple_solid = {}
	self.colors.purple_solid.colors = {purple, purple}
	self.colors.purple_solid.name_id = "bm_clr_purple_solid"
	self.colors.purple_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.purple_solid.value = 8
	self.colors.blood_red_solid = {}
	self.colors.blood_red_solid.colors = {blood_red, blood_red}
	self.colors.blood_red_solid.name_id = "bm_clr_blood_red_solid"
	self.colors.blood_red_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blood_red_solid.value = 9
	self.colors.orange_solid = {}
	self.colors.orange_solid.colors = {orange, orange}
	self.colors.orange_solid.name_id = "bm_clr_orange_solid"
	self.colors.orange_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_solid.value = 8
	self.colors.light_brown_solid = {}
	self.colors.light_brown_solid.colors = {light_brown, light_brown}
	self.colors.light_brown_solid.name_id = "bm_clr_light_brown_solid"
	self.colors.light_brown_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_solid.value = 6
	self.colors.brown_solid = {}
	self.colors.brown_solid.colors = {brown, brown}
	self.colors.brown_solid.name_id = "bm_clr_brown_solid"
	self.colors.brown_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.brown_solid.value = 8
	self.colors.navy_blue_solid = {}
	self.colors.navy_blue_solid.colors = {navy_blue, navy_blue}
	self.colors.navy_blue_solid.name_id = "bm_clr_navy_blue_solid"
	self.colors.navy_blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.navy_blue_solid.value = 7
	self.colors.light_blue_solid = {}
	self.colors.light_blue_solid.colors = {light_blue, light_blue}
	self.colors.light_blue_solid.name_id = "bm_clr_light_blue_solid"
	self.colors.light_blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_solid.value = 5
	self.colors.leaf_green_solid = {}
	self.colors.leaf_green_solid.colors = {leaf_green, leaf_green}
	self.colors.leaf_green_solid.name_id = "bm_clr_leaf_green_solid"
	self.colors.leaf_green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.leaf_green_solid.value = 8
	self.colors.warm_yellow_solid = {}
	self.colors.warm_yellow_solid.colors = {warm_yellow, warm_yellow}
	self.colors.warm_yellow_solid.name_id = "bm_clr_warm_yellow_solid"
	self.colors.warm_yellow_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_solid.value = 6
	self.colors.dark_red_solid = {}
	self.colors.dark_red_solid.colors = {dark_red, dark_red}
	self.colors.dark_red_solid.name_id = "bm_clr_dark_red_solid"
	self.colors.dark_red_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_red_solid.value = 5
	self.colors.dark_green_solid = {}
	self.colors.dark_green_solid.colors = {dark_green, dark_green}
	self.colors.dark_green_solid.name_id = "bm_clr_dark_green_solid"
	self.colors.dark_green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_green_solid.value = 6
	self.colors.nothing = {}
	self.colors.nothing.colors = {nothing, nothing}
	self.colors.nothing.name_id = "bm_clr_nothing"
	self.colors.nothing.value = 0
	self.colors.black_white = {}
	self.colors.black_white.colors = {black, white}
	self.colors.black_white.name_id = "bm_clr_black_white"
	self.colors.black_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_white.value = 3
	self.colors.red_black = {}
	self.colors.red_black.colors = {red, black}
	self.colors.red_black.name_id = "bm_clr_red_black"
	self.colors.red_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_black.dlc = "preorder"
	self.colors.red_black.value = 1
	self.colors.yellow_blue = {}
	self.colors.yellow_blue.colors = {yellow, blue}
	self.colors.yellow_blue.name_id = "bm_clr_yellow_blue"
	self.colors.yellow_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_blue.value = 5
	self.colors.red_blue = {}
	self.colors.red_blue.colors = {red, blue}
	self.colors.red_blue.name_id = "bm_clr_red_blue"
	self.colors.red_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_blue.value = 2
	self.colors.light_gray_dark_gray = {}
	self.colors.light_gray_dark_gray.colors = {light_gray, dark_gray}
	self.colors.light_gray_dark_gray.name_id = "bm_clr_light_gray_dark_gray"
	self.colors.light_gray_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_dark_gray.value = 3
	self.colors.magenta_cyan = {}
	self.colors.magenta_cyan.colors = {magenta, cyan}
	self.colors.magenta_cyan.name_id = "bm_clr_magenta_cyan"
	self.colors.magenta_cyan.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.magenta_cyan.value = 4
	self.colors.green_red = {}
	self.colors.green_red.colors = {green, red}
	self.colors.green_red.name_id = "bm_clr_green_red"
	self.colors.green_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_red.value = 2
	self.colors.orange_blue = {}
	self.colors.orange_blue.colors = {orange, blue}
	self.colors.orange_blue.name_id = "bm_clr_orange_blue"
	self.colors.orange_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_blue.value = 3
	self.colors.green_olive_green = {}
	self.colors.green_olive_green.colors = {green, olive_green}
	self.colors.green_olive_green.name_id = "bm_clr_green_olive_green"
	self.colors.green_olive_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_olive_green.value = 4
	self.colors.yellow_orange = {}
	self.colors.yellow_orange.colors = {yellow, orange}
	self.colors.yellow_orange.name_id = "bm_clr_yellow_orange"
	self.colors.yellow_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_orange.value = 2
	self.colors.light_brown_matte_blue = {}
	self.colors.light_brown_matte_blue.colors = {light_brown, matte_blue}
	self.colors.light_brown_matte_blue.name_id = "bm_clr_light_brown_matte_blue"
	self.colors.light_brown_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_matte_blue.value = 3
	self.colors.turquoise_purple = {}
	self.colors.turquoise_purple.colors = {turquoise, purple}
	self.colors.turquoise_purple.name_id = "bm_clr_turquoise_purple"
	self.colors.turquoise_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.turquoise_purple.value = 2
	self.colors.orange_gray_blue = {}
	self.colors.orange_gray_blue.colors = {orange, gray_blue}
	self.colors.orange_gray_blue.name_id = "bm_clr_orange_gray_blue"
	self.colors.orange_gray_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_gray_blue.value = 4
	self.colors.coral_red_matte_blue = {}
	self.colors.coral_red_matte_blue.colors = {coral_red, matte_blue}
	self.colors.coral_red_matte_blue.name_id = "bm_clr_coral_red_matte_blue"
	self.colors.coral_red_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_matte_blue.value = 3
	self.colors.toxic_green_dark_green = {}
	self.colors.toxic_green_dark_green.colors = {toxic_green, dark_green}
	self.colors.toxic_green_dark_green.name_id = "bm_clr_toxic_green_dark_green"
	self.colors.toxic_green_dark_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.toxic_green_dark_green.value = 4
	self.colors.warm_yellow_matte_purple = {}
	self.colors.warm_yellow_matte_purple.colors = {warm_yellow, matte_purple}
	self.colors.warm_yellow_matte_purple.name_id = "bm_clr_warm_yellow_matte_purple"
	self.colors.warm_yellow_matte_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_matte_purple.value = 3
	self.colors.bright_yellow_brown = {}
	self.colors.bright_yellow_brown.colors = {bright_yellow, brown}
	self.colors.bright_yellow_brown.name_id = "bm_clr_bright_yellow_brown"
	self.colors.bright_yellow_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_brown.value = 2
	self.colors.coral_red_lime_green = {}
	self.colors.coral_red_lime_green.colors = {coral_red, lime_green}
	self.colors.coral_red_lime_green.name_id = "bm_clr_coral_red_lime_green"
	self.colors.coral_red_lime_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_lime_green.value = 3
	self.colors.white_matte_blue = {}
	self.colors.white_matte_blue.colors = {white, matte_blue}
	self.colors.white_matte_blue.name_id = "bm_clr_white_matte_blue"
	self.colors.white_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_matte_blue.value = 4
	self.colors.red_dark_red = {}
	self.colors.red_dark_red.colors = {red, dark_red}
	self.colors.red_dark_red.name_id = "bm_clr_red_dark_red"
	self.colors.red_dark_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_dark_red.value = 2
	self.colors.bone_white_magenta = {}
	self.colors.bone_white_magenta.colors = {bone_white, magenta}
	self.colors.bone_white_magenta.name_id = "bm_clr_bone_white_magenta"
	self.colors.bone_white_magenta.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_magenta.value = 3
	self.colors.cobalt_blue_navy_blue = {}
	self.colors.cobalt_blue_navy_blue.colors = {cobalt_blue, navy_blue}
	self.colors.cobalt_blue_navy_blue.name_id = "bm_clr_cobalt_blue_navy_blue"
	self.colors.cobalt_blue_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cobalt_blue_navy_blue.value = 4
	self.colors.toxic_green_leaf_green = {}
	self.colors.toxic_green_leaf_green.colors = {toxic_green, leaf_green}
	self.colors.toxic_green_leaf_green.name_id = "bm_clr_toxic_green_leaf_green"
	self.colors.toxic_green_leaf_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.toxic_green_leaf_green.value = 2
	self.colors.light_brown_brown = {}
	self.colors.light_brown_brown.colors = {light_brown, brown}
	self.colors.light_brown_brown.name_id = "bm_clr_light_brown_brown"
	self.colors.light_brown_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_brown.value = 3
	self.colors.bright_yellow_turquoise = {}
	self.colors.bright_yellow_turquoise.colors = {bright_yellow, turquoise}
	self.colors.bright_yellow_turquoise.name_id = "bm_clr_bright_yellow_turquoise"
	self.colors.bright_yellow_turquoise.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_turquoise.value = 4
	self.colors.light_blue_gray_blue = {}
	self.colors.light_blue_gray_blue.colors = {light_blue, gray_blue}
	self.colors.light_blue_gray_blue.name_id = "bm_clr_light_blue_gray_blue"
	self.colors.light_blue_gray_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_gray_blue.value = 3
	self.colors.pink_matte_purple = {}
	self.colors.pink_matte_purple.colors = {pink, matte_purple}
	self.colors.pink_matte_purple.name_id = "bm_clr_pink_matte_purple"
	self.colors.pink_matte_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.pink_matte_purple.value = 2
	self.colors.bone_white_purple = {}
	self.colors.bone_white_purple.colors = {bone_white, purple}
	self.colors.bone_white_purple.name_id = "bm_clr_bone_white_purple"
	self.colors.bone_white_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_purple.value = 4
	self.colors.light_blue_cobalt_blue = {}
	self.colors.light_blue_cobalt_blue.colors = {light_blue, cobalt_blue}
	self.colors.light_blue_cobalt_blue.name_id = "bm_clr_light_blue_cobalt_blue"
	self.colors.light_blue_cobalt_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_cobalt_blue.value = 3
	self.colors.coral_red_gray_blue = {}
	self.colors.coral_red_gray_blue.colors = {coral_red, gray_blue}
	self.colors.coral_red_gray_blue.name_id = "bm_clr_coral_red_gray_blue"
	self.colors.coral_red_gray_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_gray_blue.value = 2
	self.colors.leaf_green_blood_red = {}
	self.colors.leaf_green_blood_red.colors = {leaf_green, blood_red}
	self.colors.leaf_green_blood_red.name_id = "bm_clr_leaf_green_blood_red"
	self.colors.leaf_green_blood_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.leaf_green_blood_red.value = 3
	self.colors.cobalt_blue_pink = {}
	self.colors.cobalt_blue_pink.colors = {cobalt_blue, pink}
	self.colors.cobalt_blue_pink.name_id = "bm_clr_cobalt_blue_pink"
	self.colors.cobalt_blue_pink.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cobalt_blue_pink.value = 2
	self.colors.bright_yellow_olive_green = {}
	self.colors.bright_yellow_olive_green.colors = {bright_yellow, olive_green}
	self.colors.bright_yellow_olive_green.name_id = "bm_clr_bright_yellow_olive_green"
	self.colors.bright_yellow_olive_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_olive_green.value = 1
	self.colors.bone_white_light_blue = {}
	self.colors.bone_white_light_blue.colors = {bone_white, light_blue}
	self.colors.bone_white_light_blue.name_id = "bm_clr_bone_white_light_blue"
	self.colors.bone_white_light_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_light_blue.value = 1
	self.colors.coral_red_dark_red = {}
	self.colors.coral_red_dark_red.colors = {coral_red, dark_red}
	self.colors.coral_red_dark_red.name_id = "bm_clr_coral_red_dark_red"
	self.colors.coral_red_dark_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.coral_red_dark_red.value = 2
	self.colors.turquoise_pink = {}
	self.colors.turquoise_pink.colors = {turquoise, pink}
	self.colors.turquoise_pink.name_id = "bm_clr_turquoise_pink"
	self.colors.turquoise_pink.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.turquoise_pink.value = 1
	self.colors.white_brown = {}
	self.colors.white_brown.colors = {white, brown}
	self.colors.white_brown.name_id = "bm_clr_white_brown"
	self.colors.white_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_brown.value = 1
	self.colors.blue_light_blue = {}
	self.colors.blue_light_blue.colors = {blue, light_blue}
	self.colors.blue_light_blue.name_id = "bm_clr_blue_light_blue"
	self.colors.blue_light_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blue_light_blue.value = 2
	self.colors.toxic_green_matte_purple = {}
	self.colors.toxic_green_matte_purple.colors = {toxic_green, matte_purple}
	self.colors.toxic_green_matte_purple.name_id = "bm_clr_toxic_green_matte_purple"
	self.colors.toxic_green_matte_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.toxic_green_matte_purple.value = 2
	self.colors.orange_matte_blue = {}
	self.colors.orange_matte_blue.colors = {orange, matte_blue}
	self.colors.orange_matte_blue.name_id = "bm_clr_orange_matte_blue"
	self.colors.orange_matte_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_matte_blue.value = 3
	self.colors.warm_yellow_navy_blue = {}
	self.colors.warm_yellow_navy_blue.colors = {warm_yellow, navy_blue}
	self.colors.warm_yellow_navy_blue.name_id = "bm_clr_warm_yellow_navy_blue"
	self.colors.warm_yellow_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_navy_blue.value = 3
	self.colors.bright_yellow_dark_gray = {}
	self.colors.bright_yellow_dark_gray.colors = {bright_yellow, dark_gray}
	self.colors.bright_yellow_dark_gray.name_id = "bm_clr_bright_yellow_dark_gray"
	self.colors.bright_yellow_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_dark_gray.value = 2
	self.colors.white_magenta = {}
	self.colors.white_magenta.colors = {white, magenta}
	self.colors.white_magenta.name_id = "bm_clr_white_magenta"
	self.colors.white_magenta.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_magenta.value = 4
	self.colors.cyan_purple = {}
	self.colors.cyan_purple.colors = {cyan, purple}
	self.colors.cyan_purple.name_id = "bm_clr_cyan_purple"
	self.colors.cyan_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_purple.value = 5
	self.colors.white_black = {}
	self.colors.white_black.colors = {white, black}
	self.colors.white_black.name_id = "bm_clr_white_black"
	self.colors.white_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_black.value = 3
	self.colors.light_gray_blood_red = {}
	self.colors.light_gray_blood_red.colors = {light_gray, blood_red}
	self.colors.light_gray_blood_red.name_id = "bm_clr_light_gray_blood_red"
	self.colors.light_gray_blood_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_blood_red.value = 6
	self.colors.blood_red_white = {}
	self.colors.blood_red_white.colors = {blood_red, white}
	self.colors.blood_red_white.name_id = "bm_clr_blood_red_white"
	self.colors.blood_red_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blood_red_white.value = 6
	self.colors.bone_white_navy_blue = {}
	self.colors.bone_white_navy_blue.colors = {bone_white, navy_blue}
	self.colors.bone_white_navy_blue.name_id = "bm_clr_bone_white_navy_blue"
	self.colors.bone_white_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bone_white_navy_blue.value = 5
	self.colors.warm_yellow_olive_green = {}
	self.colors.warm_yellow_olive_green.colors = {warm_yellow, olive_green}
	self.colors.warm_yellow_olive_green.name_id = "bm_clr_warm_yellow_olive_green"
	self.colors.warm_yellow_olive_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_olive_green.value = 4
	self.colors.cyan_orange = {}
	self.colors.cyan_orange.colors = {cyan, orange}
	self.colors.cyan_orange.name_id = "bm_clr_cyan_orange"
	self.colors.cyan_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_orange.value = 3
	self.colors.dark_gray_orange = {}
	self.colors.dark_gray_orange.colors = {dark_gray, orange}
	self.colors.dark_gray_orange.name_id = "bm_clr_dark_gray_orange"
	self.colors.dark_gray_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_gray_orange.value = 2
	self.colors.light_brown_navy_blue = {}
	self.colors.light_brown_navy_blue.colors = {light_brown, navy_blue}
	self.colors.light_brown_navy_blue.name_id = "bm_clr_light_brown_navy_blue"
	self.colors.light_brown_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_brown_navy_blue.value = 2
	self.colors.orange_purple = {}
	self.colors.orange_purple.colors = {orange, purple}
	self.colors.orange_purple.name_id = "bm_clr_orange_purple"
	self.colors.orange_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_purple.value = 2
	self.colors.light_blue_brown = {}
	self.colors.light_blue_brown.colors = {light_blue, brown}
	self.colors.light_blue_brown.name_id = "bm_clr_light_blue_brown"
	self.colors.light_blue_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_blue_brown.value = 3
	self.colors.green_blood_red = {}
	self.colors.green_blood_red.colors = {green, blood_red}
	self.colors.green_blood_red.name_id = "bm_clr_green_blood_red"
	self.colors.green_blood_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.green_blood_red.value = 4
	self.colors.cyan_blue = {}
	self.colors.cyan_blue.colors = {cyan, blue}
	self.colors.cyan_blue.name_id = "bm_clr_cyan_blue"
	self.colors.cyan_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cyan_blue.value = 5
	self.colors.yellow_orange = {}
	self.colors.yellow_orange.colors = {yellow, orange}
	self.colors.yellow_orange.name_id = "bm_clr_yellow_orange"
	self.colors.yellow_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.yellow_orange.value = 6
	self.colors.light_gray_dark_gray = {}
	self.colors.light_gray_dark_gray.colors = {light_gray, dark_gray}
	self.colors.light_gray_dark_gray.name_id = "bm_clr_light_gray_dark_gray"
	self.colors.light_gray_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.light_gray_dark_gray.value = 2
	self.colors.gray_black = {}
	self.colors.gray_black.colors = {gray, black}
	self.colors.gray_black.name_id = "bm_clr_gray_black"
	self.colors.gray_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.gray_black.value = 3
	self.colors.white_dark_gray = {}
	self.colors.white_dark_gray.colors = {white, dark_gray}
	self.colors.white_dark_gray.name_id = "bm_clr_white_dark_gray"
	self.colors.white_dark_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_dark_gray.value = 6
	self.colors.white_brown = {}
	self.colors.white_brown.colors = {white, brown}
	self.colors.white_brown.name_id = "bm_clr_white_brown"
	self.colors.white_brown.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_brown.value = 3
	self.colors.white_navy_blue = {}
	self.colors.white_navy_blue.colors = {white, navy_blue}
	self.colors.white_navy_blue.name_id = "bm_clr_white_navy_blue"
	self.colors.white_navy_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_navy_blue.value = 4
	self.colors.white_purple = {}
	self.colors.white_purple.colors = {white, purple}
	self.colors.white_purple.name_id = "bm_clr_white_purple"
	self.colors.white_purple.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_purple.value = 2
	self.colors.black_coral_red = {}
	self.colors.black_coral_red.colors = {black, coral_red}
	self.colors.black_coral_red.name_id = "bm_clr_black_coral_red"
	self.colors.black_coral_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_coral_red.value = 3
	self.colors.black_orange = {}
	self.colors.black_orange.colors = {black, orange}
	self.colors.black_orange.name_id = "bm_clr_black_orange"
	self.colors.black_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_orange.value = 4
	self.colors.black_cobalt_blue = {}
	self.colors.black_cobalt_blue.colors = {black, cobalt_blue}
	self.colors.black_cobalt_blue.name_id = "bm_clr_black_cobalt_blue"
	self.colors.black_cobalt_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_cobalt_blue.value = 2
	self.colors.black_leaf_green = {}
	self.colors.black_leaf_green.colors = {black, leaf_green}
	self.colors.black_leaf_green.name_id = "bm_clr_black_leaf_green"
	self.colors.black_leaf_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_leaf_green.value = 3
	self.colors.red_white = {}
	self.colors.red_white.colors = {red, white}
	self.colors.red_white.name_id = "bm_clr_red_white"
	self.colors.red_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.red_white.value = 4
	self.colors.leaf_green_white = {}
	self.colors.leaf_green_white.colors = {leaf_green, white}
	self.colors.leaf_green_white.name_id = "bm_clr_leaf_green_white"
	self.colors.leaf_green_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.leaf_green_white.value = 2
	self.colors.orange_white = {}
	self.colors.orange_white.colors = {orange, white}
	self.colors.orange_white.name_id = "bm_clr_orange_white"
	self.colors.orange_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_white.value = 3
	self.colors.cobalt_blue_white = {}
	self.colors.cobalt_blue_white.colors = {cobalt_blue, white}
	self.colors.cobalt_blue_white.name_id = "bm_clr_cobalt_blue_white"
	self.colors.cobalt_blue_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.cobalt_blue_white.value = 4
	self.colors.warm_yellow_white = {}
	self.colors.warm_yellow_white.colors = {warm_yellow, white}
	self.colors.warm_yellow_white.name_id = "bm_clr_warm_yellow_white"
	self.colors.warm_yellow_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_white.value = 3
	self.colors.black_bright_yellow = {}
	self.colors.black_bright_yellow.colors = {black, bright_yellow}
	self.colors.black_bright_yellow.name_id = "bm_clr_black_bright_yellow"
	self.colors.black_bright_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_bright_yellow.value = 2
	self.colors.warm_yellow_bright_yellow = {}
	self.colors.warm_yellow_bright_yellow.colors = {warm_yellow, bright_yellow}
	self.colors.warm_yellow_bright_yellow.name_id = "bm_clr_warm_yellow_bright_yellow"
	self.colors.warm_yellow_bright_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.warm_yellow_bright_yellow.value = 3
	self.colors.black_magenta = {}
	self.colors.black_magenta.colors = {black, magenta}
	self.colors.black_magenta.name_id = "bm_clr_black_magenta"
	self.colors.black_magenta.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_magenta.value = 4
	self.colors.navy_blue_light_blue = {}
	self.colors.navy_blue_light_blue.colors = {navy_blue, light_blue}
	self.colors.navy_blue_light_blue.name_id = "bm_clr_navy_blue_light_blue"
	self.colors.navy_blue_light_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.navy_blue_light_blue.value = 2
	self.colors.dark_red_orange = {}
	self.colors.dark_red_orange.colors = {dark_red, orange}
	self.colors.dark_red_orange.name_id = "bm_clr_dark_red_orange"
	self.colors.dark_red_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_red_orange.value = 3
	self.colors.scary_green_solid = {}
	self.colors.scary_green_solid.colors = {scary_green, scary_green}
	self.colors.scary_green_solid.name_id = "bm_clr_scary_green"
	self.colors.scary_green_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_solid.value = 5
	self.colors.dark_purple_solid = {}
	self.colors.dark_purple_solid.colors = {dark_purple, dark_purple}
	self.colors.dark_purple_solid.name_id = "bm_clr_dark_purple"
	self.colors.dark_purple_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_solid.value = 5
	self.colors.sea_blue_solid = {}
	self.colors.sea_blue_solid.colors = {sea_blue, sea_blue}
	self.colors.sea_blue_solid.name_id = "bm_clr_sea_blue"
	self.colors.sea_blue_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_solid.value = 5
	self.colors.skin_pink_solid = {}
	self.colors.skin_pink_solid.colors = {skin_pink, skin_pink}
	self.colors.skin_pink_solid.name_id = "bm_clr_skin_pink"
	self.colors.skin_pink_solid.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_solid.value = 5
	self.colors.black_red = {}
	self.colors.black_red.colors = {black, red}
	self.colors.black_red.name_id = "bm_clr_black_red"
	self.colors.black_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_red.value = 1
	self.colors.blue_yellow = {}
	self.colors.blue_yellow.colors = {blue, yellow}
	self.colors.blue_yellow.name_id = "bm_clr_blue_yellow"
	self.colors.blue_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blue_yellow.value = 5
	self.colors.blue_red = {}
	self.colors.blue_red.colors = {blue, red}
	self.colors.blue_red.name_id = "bm_clr_blue_red"
	self.colors.blue_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.blue_red.value = 2
	self.colors.dark_grey_light_gray = {}
	self.colors.dark_grey_light_gray.colors = {dark_gray, light_gray}
	self.colors.dark_grey_light_gray.name_id = "bm_clr_dark_grey_light_gray"
	self.colors.dark_grey_light_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_grey_light_gray.value = 3
	self.colors.orange_yellow = {}
	self.colors.orange_yellow.colors = {orange, yellow}
	self.colors.orange_yellow.name_id = "bm_clr_orange_yellow"
	self.colors.orange_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_yellow.value = 6
	self.colors.black_gray = {}
	self.colors.black_gray.colors = {black, gray}
	self.colors.black_gray.name_id = "bm_clr_black_gray"
	self.colors.black_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.black_gray.value = 3
	self.colors.orange_black = {}
	self.colors.orange_black.colors = {orange, black}
	self.colors.orange_black.name_id = "bm_clr_orange_black"
	self.colors.orange_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.orange_black.value = 4
	self.colors.white_red = {}
	self.colors.white_red.colors = {white, red}
	self.colors.white_red.name_id = "bm_clr_white_red"
	self.colors.white_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.white_red.value = 4
	self.colors.bright_yellow_black = {}
	self.colors.bright_yellow_black.colors = {bright_yellow, black}
	self.colors.bright_yellow_black.name_id = "bm_clr_bright_yellow_black"
	self.colors.bright_yellow_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.bright_yellow_black.value = 2
	self.colors.scary_green_black = {}
	self.colors.scary_green_black.colors = {scary_green, black}
	self.colors.scary_green_black.name_id = "bm_clr_scary_green_black"
	self.colors.scary_green_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_black.value = 3
	self.colors.skin_pink_black = {}
	self.colors.skin_pink_black.colors = {skin_pink, black}
	self.colors.skin_pink_black.name_id = "bm_clr_skin_pink_black"
	self.colors.skin_pink_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_black.value = 3
	self.colors.sea_blue_black = {}
	self.colors.sea_blue_black.colors = {sea_blue, black}
	self.colors.sea_blue_black.name_id = "bm_clr_sea_blue_black"
	self.colors.sea_blue_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_black.value = 3
	self.colors.dark_purple_black = {}
	self.colors.dark_purple_black.colors = {dark_purple, black}
	self.colors.dark_purple_black.name_id = "bm_clr_dark_purple_black"
	self.colors.dark_purple_black.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_black.value = 3
	self.colors.scary_green_white = {}
	self.colors.scary_green_white.colors = {scary_green, white}
	self.colors.scary_green_white.name_id = "bm_clr_scary_green_white"
	self.colors.scary_green_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_white.value = 3
	self.colors.skin_pink_white = {}
	self.colors.skin_pink_white.colors = {skin_pink, white}
	self.colors.skin_pink_white.name_id = "bm_clr_skin_pink_white"
	self.colors.skin_pink_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_white.value = 3
	self.colors.sea_blue_white = {}
	self.colors.sea_blue_white.colors = {sea_blue, white}
	self.colors.sea_blue_white.name_id = "bm_clr_sea_blue_white"
	self.colors.sea_blue_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_white.value = 3
	self.colors.dark_purple_white = {}
	self.colors.dark_purple_white.colors = {dark_purple, white}
	self.colors.dark_purple_white.name_id = "bm_clr_dark_purple_white"
	self.colors.dark_purple_white.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_white.value = 3
	self.colors.scary_green_red = {}
	self.colors.scary_green_red.colors = {scary_green, red}
	self.colors.scary_green_red.name_id = "bm_clr_scary_green_red"
	self.colors.scary_green_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_red.value = 3
	self.colors.skin_pink_red = {}
	self.colors.skin_pink_red.colors = {skin_pink, red}
	self.colors.skin_pink_red.name_id = "bm_clr_skin_pink_red"
	self.colors.skin_pink_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_red.value = 3
	self.colors.sea_blue_red = {}
	self.colors.sea_blue_red.colors = {sea_blue, red}
	self.colors.sea_blue_red.name_id = "bm_clr_sea_blue_red"
	self.colors.sea_blue_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_red.value = 3
	self.colors.dark_purple_red = {}
	self.colors.dark_purple_red.colors = {dark_purple, red}
	self.colors.dark_purple_red.name_id = "bm_clr_dark_purple_red"
	self.colors.dark_purple_red.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_red.value = 3
	self.colors.scary_green_green = {}
	self.colors.scary_green_green.colors = {scary_green, green}
	self.colors.scary_green_green.name_id = "bm_clr_scary_green_green"
	self.colors.scary_green_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_green.value = 3
	self.colors.skin_pink_green = {}
	self.colors.skin_pink_green.colors = {skin_pink, green}
	self.colors.skin_pink_green.name_id = "bm_clr_skin_pink_green"
	self.colors.skin_pink_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_green.value = 3
	self.colors.sea_blue_green = {}
	self.colors.sea_blue_green.colors = {sea_blue, green}
	self.colors.sea_blue_green.name_id = "bm_clr_sea_blue_green"
	self.colors.sea_blue_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_green.value = 3
	self.colors.dark_purple_green = {}
	self.colors.dark_purple_green.colors = {dark_purple, green}
	self.colors.dark_purple_green.name_id = "bm_clr_dark_purple_green"
	self.colors.dark_purple_green.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_green.value = 3
	self.colors.scary_green_blue = {}
	self.colors.scary_green_blue.colors = {scary_green, blue}
	self.colors.scary_green_blue.name_id = "bm_clr_scary_green_blue"
	self.colors.scary_green_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_blue.value = 3
	self.colors.skin_pink_blue = {}
	self.colors.skin_pink_blue.colors = {skin_pink, blue}
	self.colors.skin_pink_blue.name_id = "bm_clr_skin_pink_blue"
	self.colors.skin_pink_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_blue.value = 3
	self.colors.sea_blue_blue = {}
	self.colors.sea_blue_blue.colors = {sea_blue, blue}
	self.colors.sea_blue_blue.name_id = "bm_clr_sea_blue_blue"
	self.colors.sea_blue_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_blue.value = 3
	self.colors.dark_purple_blue = {}
	self.colors.dark_purple_blue.colors = {dark_purple, blue}
	self.colors.dark_purple_blue.name_id = "bm_clr_dark_purple_blue"
	self.colors.dark_purple_blue.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_blue.value = 3
	self.colors.scary_green_yellow = {}
	self.colors.scary_green_yellow.colors = {scary_green, yellow}
	self.colors.scary_green_yellow.name_id = "bm_clr_scary_green_yellow"
	self.colors.scary_green_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_yellow.value = 3
	self.colors.skin_pink_yellow = {}
	self.colors.skin_pink_yellow.colors = {skin_pink, yellow}
	self.colors.skin_pink_yellow.name_id = "bm_clr_skin_pink_yellow"
	self.colors.skin_pink_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_yellow.value = 3
	self.colors.sea_blue_yellow = {}
	self.colors.sea_blue_yellow.colors = {sea_blue, yellow}
	self.colors.sea_blue_yellow.name_id = "bm_clr_sea_blue_yellow"
	self.colors.sea_blue_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_yellow.value = 3
	self.colors.dark_purple_yellow = {}
	self.colors.dark_purple_yellow.colors = {dark_purple, yellow}
	self.colors.dark_purple_yellow.name_id = "bm_clr_dark_purple_yellow"
	self.colors.dark_purple_yellow.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_yellow.value = 3
	self.colors.scary_green_gray = {}
	self.colors.scary_green_gray.colors = {scary_green, gray}
	self.colors.scary_green_gray.name_id = "bm_clr_scary_green_gray"
	self.colors.scary_green_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_gray.value = 3
	self.colors.skin_pink_gray = {}
	self.colors.skin_pink_gray.colors = {skin_pink, gray}
	self.colors.skin_pink_gray.name_id = "bm_clr_skin_pink_gray"
	self.colors.skin_pink_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_gray.value = 3
	self.colors.sea_blue_gray = {}
	self.colors.sea_blue_gray.colors = {sea_blue, gray}
	self.colors.sea_blue_gray.name_id = "bm_clr_sea_blue_gray"
	self.colors.sea_blue_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_gray.value = 3
	self.colors.dark_purple_gray = {}
	self.colors.dark_purple_gray.colors = {dark_purple, gray}
	self.colors.dark_purple_gray.name_id = "bm_clr_dark_purple_gray"
	self.colors.dark_purple_gray.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_gray.value = 3
	self.colors.scary_green_orange = {}
	self.colors.scary_green_orange.colors = {scary_green, orange}
	self.colors.scary_green_orange.name_id = "bm_clr_scary_green_orange"
	self.colors.scary_green_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.scary_green_orange.value = 3
	self.colors.skin_pink_orange = {}
	self.colors.skin_pink_orange.colors = {skin_pink, orange}
	self.colors.skin_pink_orange.name_id = "bm_clr_skin_pink_orange"
	self.colors.skin_pink_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.skin_pink_orange.value = 3
	self.colors.sea_blue_orange = {}
	self.colors.sea_blue_orange.colors = {sea_blue, orange}
	self.colors.sea_blue_orange.name_id = "bm_clr_sea_blue_orange"
	self.colors.sea_blue_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.sea_blue_orange.value = 3
	self.colors.dark_purple_orange = {}
	self.colors.dark_purple_orange.colors = {dark_purple, orange}
	self.colors.dark_purple_orange.name_id = "bm_clr_dark_purple_orange"
	self.colors.dark_purple_orange.pcs = {
		10,
		20,
		30,
		40
	}
	self.colors.dark_purple_orange.value = 3
	local free_dlcs = tweak_data:free_dlc_list()
	for _, data in pairs(self.colors) do
		if free_dlcs[data.dlc] then
			data.dlc = nil
		end
	end
end
