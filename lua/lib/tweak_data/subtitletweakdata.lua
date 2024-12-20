SubtitleTweakData = SubtitleTweakData or class()

function SubtitleTweakData:init(tweak_data)
	self.additional_time = 1
	self.jobs = {}
	self:_init_moon()
end

function SubtitleTweakData:_init_moon()
	self.jobs.moon = {
		vld_moon_intro_01 = 12.25,
		vld_moon_intro_02 = 5.02,
		vld_moon_intro_03 = 8.28,
		vld_moon_01_01 = 4.18,
		vld_moon_01_02 = 5.13,
		vld_moon_01_03 = 6.24,
		vld_moon_02_01 = 5.05,
		vld_moon_02_02 = 4.25,
		vld_moon_02_03 = 4.12,
		vld_moon_03_01 = 6.19,
		vld_moon_03_02 = 4.07,
		vld_moon_03_03 = 6.03,
		vld_moon_04_01 = 2.22,
		vld_moon_04_02 = 2.16,
		vld_moon_04_03 = 5.02,
		vld_moon_04_04 = 2.09,
		vld_moon_04_05 = 5.24,
		vld_moon_04_06 = 2.16,
		vld_moon_05_01 = 3.04,
		vld_moon_05_02 = 6.03,
		vld_moon_05_03 = 3.16,
		vld_moon_06_01 = 3.27,
		vld_moon_06_02 = 4.28,
		vld_moon_06_03 = 5.08,
		vld_moon_07_01 = 6.01,
		vld_moon_07_02 = 1.26,
		vld_moon_07_03 = 5.27,
		vld_moon_08_01 = 2.06,
		vld_moon_08_02 = 4.01,
		vld_moon_08_03 = 9,
		vld_moon_09_01 = 2.29,
		vld_moon_09_02 = 4.18,
		vld_moon_09_03 = 8.06,
		vld_moon_10_01 = 2.05,
		vld_moon_10_02 = 1.2,
		vld_moon_10_03 = 3.21,
		vld_moon_11_01 = 3.12,
		vld_moon_11_02 = 2.26,
		vld_moon_11_03 = 2.04,
		vld_moon_12_01 = 3.09,
		vld_moon_12_02 = 3.14,
		vld_moon_12_03 = 9.06,
		vld_moon_13_01 = 8.22,
		vld_moon_13_02 = 3.14,
		vld_moon_13_03 = 4.17,
		vld_moon_14_01 = 4.27,
		vld_moon_14_02 = 3.2,
		vld_moon_14_03 = 4.13,
		vld_moon_15_01 = 3.09,
		vld_moon_15_02 = 1.2,
		vld_moon_15_03 = 3.27,
		vld_moon_16_01 = 2.16,
		vld_moon_16_02 = 1.29,
		vld_moon_16_03 = 5.07,
		vld_moon_17_01 = 5.05,
		vld_moon_17_02 = 1.15,
		vld_moon_17_03 = 3.19,
		vld_moon_18_01 = 3.17,
		vld_moon_18_02 = 5.12,
		vld_moon_18_03 = 2.24,
		vld_moon_19_01 = 4.19,
		vld_moon_19_02 = 4.19,
		vld_moon_19_03 = 3.14,
		vld_moon_20_01 = 1.24,
		vld_moon_20_02 = 2.06,
		vld_moon_20_03 = 1.14,
		vld_moon_21_01 = 2.28,
		vld_moon_21_02 = 4.05,
		vld_moon_21_03 = 1.05,
		vld_moon_22_01 = 2.11,
		vld_moon_22_02 = 1.18,
		vld_moon_22_03 = 4.21,
		vld_moon_23_01 = 3.14,
		vld_moon_23_02 = 6.1,
		vld_moon_23_03 = 5.25,
		vld_moon_24_01 = 4.08,
		vld_moon_24_02 = 6.16,
		vld_moon_24_03 = 4.26,
		vld_moon_25_01 = 3.23,
		vld_moon_25_02 = 3.24,
		vld_moon_25_03 = 7.25,
		vld_moon_26_01 = 3,
		vld_moon_26_02 = 3.01,
		vld_moon_26_03 = 2.09,
		vld_moon_27_01 = 6.27,
		vld_moon_27_02 = 5.25,
		vld_moon_27_03 = 5.15,
		vld_moon_28_01 = 3.26,
		vld_moon_28_02 = 7.07,
		vld_moon_28_03 = 9.05,
		vld_moon_29_01 = 5.2,
		vld_moon_29_02 = 3.11,
		vld_moon_29_03 = 2.16,
		vld_moon_30_01 = 3.07,
		vld_moon_30_02 = 6.1,
		vld_moon_30_03 = 4.27,
		vld_moon_31_01 = 10.18,
		vld_moon_31_02 = 9.03,
		vld_moon_31_03 = 5.17,
		vld_moon_32_01 = 4.13,
		vld_moon_32_02 = 4.01,
		vld_moon_32_03 = 4.02,
		vld_moon_33_01 = 3.28,
		vld_moon_33_02 = 3.18,
		vld_moon_33_03 = 5.15,
		vld_moon_34_01 = 4.14,
		vld_moon_34_02 = 3.09,
		vld_moon_34_03 = 6.03,
		vld_moon_35_01 = 5.01,
		vld_moon_35_02 = 5.08,
		vld_moon_35_03 = 2.15,
		vld_moon_36_01 = 4.02,
		vld_moon_36_02 = 2.28,
		vld_moon_36_03 = 4.28,
		vld_moon_37_01 = 3.12,
		vld_moon_37_02 = 5.14,
		vld_moon_37_03 = 4,
		vld_moon_end_01 = 8.27,
		vld_moon_end_02 = 20.01,
		vld_moon_end_03 = 14.26,
		vld_moon_38_01 = 8.06,
		vld_moon_38_02 = 17.27,
		vld_moon_38_03 = 8.03,
		vld_moon_38_04 = 8.06,
		vld_moon_38_05 = 7.24,
		vld_moon_38_06 = 9.01,
		vld_moon_38_07 = 7.22,
		vld_moon_38_08 = 6.15,
		vld_moon_38_09 = 6.13,
		vld_moon_38_10 = 6.22,
		vld_moon_39_01 = 2.06,
		vld_moon_39_02 = 2.21,
		vld_moon_39_03 = 4.01,
		vld_moon_39_04 = 7.02,
		vld_moon_39_05 = 2.25,
		vld_moon_39_06 = 4.08,
		vld_moon_39_07 = 3.1,
		vld_moon_39_08 = 4.17,
		vld_moon_39_09 = 1.24,
		vld_moon_39_10 = 3.02
	}
end
