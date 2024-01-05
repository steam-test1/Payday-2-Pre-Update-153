core:module("CoreEnvironmentAreaManager")
core:import("CoreShapeManager")
core:import("CoreEnvironmentFeeder")
EnvironmentAreaManager = EnvironmentAreaManager or class()
EnvironmentAreaManager.POSITION_OFFSET = 50

function EnvironmentAreaManager:init()
	self._areas = {}
	self._blocks = 0
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

function EnvironmentAreaManager:add_area(area_params)
	local area = EnvironmentArea:new(area_params)
	table.insert(self._areas, area)
	return area
end

function EnvironmentAreaManager:remove_area(area)
	for _, vp in ipairs(managers.viewport:viewports()) do
		vp:on_environment_area_removed(area)
	end
	table.delete(self._areas, area)
end

function EnvironmentAreaManager:update(t, dt)
	local vps = managers.viewport:all_really_active_viewports()
	for _, vp in ipairs(vps) do
		if self._blocks > 0 then
			return
		end
		vp:update_environment_area(self._areas, self.POSITION_OFFSET)
	end
end

function EnvironmentAreaManager:environment_at_position(pos)
	local environment = managers.viewport:default_environment()
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

EnvironmentArea = EnvironmentArea or class(CoreShapeManager.ShapeBox)

function EnvironmentArea:init(params)
	params.type = "box"
	EnvironmentArea.super.init(self, params)
	self._properties.environment = params.environment or managers.viewport:game_default_environment()
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
