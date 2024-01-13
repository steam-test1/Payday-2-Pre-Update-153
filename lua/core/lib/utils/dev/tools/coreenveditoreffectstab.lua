core:import("CoreEnvironmentFeeder")
CoreEnvEditor = CoreEnvEditor or class()

function CoreEnvEditor:init_effects_tab()
	self:create_effects_tab()
end

function CoreEnvEditor:create_effects_tab()
	self:create_tab("Effects")
	local gui = self:add_post_processors_param("deferred", "deferred_lighting", "apply_ambient", "bloom_threshold", SingelSlider:new(self, self:get_tab("Effects"), "Bloom threshold", nil, 0, 1000, 1000, 1000))
	self:add_gui_element(gui, "Effects", "Bloom")
	gui = self:add_post_processors_param("bloom_combine_post_processor", "bloom_combine", "bloom_lense", "bloom_intensity", SingelSlider:new(self, self:get_tab("Effects"), "Bloom intensity", nil, 0, 10000, 1000, 1000))
	self:add_gui_element(gui, "Effects", "Bloom")
	gui = self:add_post_processors_param("bloom_combine_post_processor", "bloom_combine", "bloom_lense", "bloom_blur_size", SingelSlider:new(self, self:get_tab("Effects"), "Bloom blur size", nil, 1, 4, 1, 1))
	self:add_gui_element(gui, "Effects", "Bloom")
	gui = self:add_post_processors_param("bloom_combine_post_processor", "bloom_combine", "bloom_lense", "lense_intensity", SingelSlider:new(self, self:get_tab("Effects"), "Lense intensity", nil, 0, 1000, 1000, 1000))
	self:add_gui_element(gui, "Effects", "Lense")
	self:build_tab("Effects")
end
