core:module("CoreEnvironmentAreaManager")
core:import("CoreShapeManager")
core:import("CoreEnvironmentFeeder")
EnvironmentAreaManager = EnvironmentAreaManager or class()

function EnvironmentAreaManager:init()
	self._areas = {}
	self._current_area = nil
	self._area_iterator = 1
	self._areas_per_frame = 1
	self._blocks = 0
	self.GAME_DEFAULT_ENVIRONMENT = "core/environments/default"
	self._default_environment = self.GAME_DEFAULT_ENVIRONMENT
	self._current_environment = self.GAME_DEFAULT_ENVIRONMENT
	managers.viewport:preload_environment(self.GAME_DEFAULT_ENVIRONMENT)
	for _, vp in ipairs(managers.viewport:viewports()) do
		self:_set_environment(self.GAME_DEFAULT_ENVIRONMENT, 0, vp, nil, nil, nil)
	end
	self._environment_changed_callback = {}
	self:set_default_transition_time(0.1)
	self:set_default_bezier_curve({
		0,
		0,
		1,
		1
	})
	local default_filter_list = {}
	for name, data_path_key_list in pairs(managers.viewport:get_predefined_environment_filter_map()) do
		if name ~= CoreEnvironmentFeeder.UnderlayPathFeeder.FILTER_CATEGORY and name ~= CoreEnvironmentFeeder.CubeMapTextureFeeder.FILTER_CATEGORY and name ~= CoreEnvironmentFeeder.PostShadowSlice0Feeder.FILTER_CATEGORY then
			for _, data_path_key in ipairs(data_path_key_list) do
				table.insert(default_filter_list, data_path_key)
			end
		end
	end
	self:set_default_filter_list(default_filter_list)
	self.POSITION_OFFSET = 50
end

function EnvironmentAreaManager:set_default_transition_time(time)
	self._default_transition_time = time
end

function EnvironmentAreaManager:default_transition_time()
	return self._default_transition_time
end

function EnvironmentAreaManager:set_default_bezier_curve(bezier_curve)
	self._default_bezier_curve = bezier_curve
end

function EnvironmentAreaManager:default_bezier_curve()
	return self._default_bezier_curve
end

function EnvironmentAreaManager:set_default_filter_list(filter_list)
	self._default_filter_list = filter_list
end

function EnvironmentAreaManager:default_filter_list()
	if self._default_filter_list then
		return table.list_copy(self._default_filter_list)
	else
		return nil
	end
end

function EnvironmentAreaManager:areas()
	return self._areas
end

function EnvironmentAreaManager:game_default_environment()
	return self.GAME_DEFAULT_ENVIRONMENT
end

function EnvironmentAreaManager:default_environment()
	return self._default_environment
end

function EnvironmentAreaManager:set_default_environment(environment, time, vp, bezier_curve, filter_list)
	self._default_environment = environment
	if not self._current_area then
		if not vp then
			for _, viewport in ipairs(managers.viewport:viewports()) do
				self:_set_environment(self._default_environment, time, viewport, bezier_curve, filter_list, nil)
			end
		else
			self:_set_environment(self._default_environment, time, vp, bezier_curve, filter_list, nil)
		end
	end
end

function EnvironmentAreaManager:set_to_current_environment(vp)
	self:_set_environment(self._current_environment, nil, vp, nil, nil, nil)
end

function EnvironmentAreaManager:_set_environment(environment, time, vp, bezier_curve, filter_list, apply_default_environment_on_unfiltered)
	self._current_environment = environment
	vp:set_environment(environment, time, bezier_curve, filter_list, apply_default_environment_on_unfiltered and self._default_environment)
end

function EnvironmentAreaManager:current_environment()
	return self._current_environment
end

function EnvironmentAreaManager:set_to_default()
	local vps = managers.viewport:active_viewports()
	for _, vp in ipairs(vps) do
		self:set_default_environment(self.GAME_DEFAULT_ENVIRONMENT, nil, vp, nil, nil)
	end
end

function EnvironmentAreaManager:add_area(area_params)
	local area = EnvironmentArea:new(area_params)
	table.insert(self._areas, area)
	return area
end

function EnvironmentAreaManager:remove_area(area)
	if area == self._current_area then
		self:_leave_current_area(self._current_area:transition_time(), nil, nil, nil)
	end
	table.delete(self._areas, area)
	self._area_iterator = 1
end

local mvec1 = Vector3()
local mvec2 = Vector3()

function EnvironmentAreaManager:update(t, dt)
	local vps = managers.viewport:active_viewports()
	for _, vp in ipairs(vps) do
		local camera = vp:camera()
		if not camera then
			return
		end
		if self._blocks > 0 then
			return
		end
		local check_pos = mvec1
		local c_fwd = mvec2
		camera:m_position(check_pos)
		mrotation.y(camera:rotation(), c_fwd)
		mvector3.multiply(c_fwd, self.POSITION_OFFSET)
		mvector3.add(check_pos, c_fwd)
		local still_inside
		if self._current_area then
			still_inside = self._current_area:still_inside(check_pos)
			if still_inside then
				return
			end
			local transition_time = self._current_area:transition_time()
			local bezier_curve = self._current_area:bezier_curve()
			local filter_list = self._current_area:filter_list()
			if self:_check_inside(check_pos, vp) then
				return
			else
				self._current_area = nil
			end
			self:_leave_current_area(transition_time, vp, nil, nil)
		end
		self:_check_inside(check_pos, vp)
	end
end

function EnvironmentAreaManager:_check_inside(check_pos, vp)
	if #self._areas > 0 then
		for i = 1, self._areas_per_frame do
			local area = self._areas[self._area_iterator]
			self._area_iterator = math.mod(self._area_iterator, #self._areas) + 1
			if area:is_inside(check_pos) then
				if self._current_area ~= area then
					if area:permanent() then
						local environment = area:environment()
						local transition_time = area:transition_time()
						local bezier_curve = area:bezier_curve()
						local filter_list = area:filter_list()
						self:set_default_environment(environment, transition_time, vp, bezier_curve, filter_list)
						if self._current_area then
							self:_set_environment(environment, transition_time, vp, bezier_curve, filter_list, true)
						end
					else
						self:_set_environment(area:environment(), area:transition_time(), vp, area:bezier_curve(), area:filter_list(), self._current_area ~= nil)
					end
				end
				self._current_area = area
				return true
			end
		end
	end
	return false
end

function EnvironmentAreaManager:_leave_current_area(transition_time, vp, bezier_curve, filter_list)
	self._current_area = nil
	if self._default_environment ~= self._current_environment then
		self:_set_environment(self._default_environment, transition_time, vp, bezier_curve, filter_list, nil)
	end
end

function EnvironmentAreaManager:environment_at_position(pos)
	local environment = self._default_environment
	for _, area in ipairs(self._areas) do
		if area:is_inside(pos) then
			environment = area:environment()
			break
		end
	end
	return environment
end

function EnvironmentAreaManager:add_block()
	self._blocks = self._blocks + 1
end

function EnvironmentAreaManager:remove_block()
	self._blocks = self._blocks - 1
end

function EnvironmentAreaManager:add_environment_changed_callback(func)
	table.insert(self._environment_changed_callback, func)
end

function EnvironmentAreaManager:remove_environment_changed_callback(func)
	table.delete(self._environment_changed_callback, func)
end

EnvironmentArea = EnvironmentArea or class(CoreShapeManager.ShapeBox)

function EnvironmentArea:init(params)
	params.type = "box"
	EnvironmentArea.super.init(self, params)
	self._properties.environment = params.environment or managers.environment_area:game_default_environment()
	self._properties.permanent = params.permanent or false
	self._properties.transition_time = params.transition_time or managers.environment_area:default_transition_time()
	self._properties.bezier_curve = params.bezier_curve or managers.environment_area:default_bezier_curve()
	self._properties.filter_list = params.filter_list or managers.environment_area:default_filter_list()
end

function EnvironmentArea:name()
	return self._unit and self._unit:unit_data().name_id or self._name
end

function EnvironmentArea:environment()
	return self:property("environment")
end

function EnvironmentArea:set_environment(environment)
	self:set_property_string("environment", environment)
end

function EnvironmentArea:permanent()
	return self:property("permanent")
end

function EnvironmentArea:set_permanent(permanent)
	self._properties.permanent = permanent
end

function EnvironmentArea:transition_time()
	return self:property("transition_time")
end

function EnvironmentArea:set_transition_time(time)
	self._properties.transition_time = time
end

function EnvironmentArea:bezier_curve()
	return self:property("bezier_curve")
end

function EnvironmentArea:set_bezier_curve(bezier_curve)
	self._properties.bezier_curve = bezier_curve
end

function EnvironmentArea:filter_list()
	return self:property("filter_list")
end

function EnvironmentArea:set_filter_list(filter_list)
	self._properties.filter_list = filter_list
end
