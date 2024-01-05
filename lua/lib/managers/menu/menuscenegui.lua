MenuSceneGui = MenuSceneGui or class()

function MenuSceneGui:init(ws, fullscreen_ws, node)
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	self._node = node
	self._panel = self._ws:panel():panel()
	self._fullscreen_panel = self._fullscreen_ws:panel():panel()
	if not managers.menu:is_pc_controller() then
		self:_setup_controller_input()
	end
end

function MenuSceneGui:_setup_controller_input()
	self._left_axis_vector = Vector3()
	self._right_axis_vector = Vector3()
	self._ws:connect_controller(managers.menu:active_menu().input:get_controller(), true)
	self._panel:axis_move(callback(self, self, "_axis_move"))
end

function MenuSceneGui:_destroy_controller_unput()
	self._ws:disconnect_all_controllers()
	if alive(self._panel) then
		self._panel:axis_move(nil)
	end
end

function MenuSceneGui:_axis_move(o, axis_name, axis_vector, controller)
	if axis_name == Idstring("left") then
		mvector3.set(self._left_axis_vector, axis_vector)
	elseif axis_name == Idstring("right") then
		mvector3.set(self._right_axis_vector, axis_vector)
	end
end

function MenuSceneGui:update(t, dt)
	if managers.menu:is_pc_controller() then
		return
	end
	if mvector3.is_zero(self._left_axis_vector) then
		managers.menu_scene:stop_controller_move()
	else
		local x = mvector3.x(self._left_axis_vector)
		local y = mvector3.y(self._left_axis_vector)
		managers.menu_scene:controller_move(x * dt, y * dt)
	end
	if mvector3.is_zero(self._right_axis_vector) then
	else
		local y = mvector3.y(self._right_axis_vector)
		managers.menu_scene:controller_zoom(y * dt)
	end
end

function MenuSceneGui:close()
	self:_destroy_controller_unput()
	if alive(self._panel) then
		self._ws:panel():remove(self._panel)
		self._panel = nil
	end
	if alive(self._fullscreen_panel) then
		self._fullscreen_ws:panel():remove(self._fullscreen_panel)
		self._fullscreen_panel = nil
	end
end
