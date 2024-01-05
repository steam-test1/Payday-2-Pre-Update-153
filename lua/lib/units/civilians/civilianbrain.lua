require("lib/units/enemies/cop/logics/CopLogicBase")
require("lib/units/civilians/logics/CivilianLogicInactive")
require("lib/units/civilians/logics/CivilianLogicIdle")
require("lib/units/civilians/logics/CivilianLogicFlee")
require("lib/units/civilians/logics/CivilianLogicSurrender")
require("lib/units/civilians/logics/CivilianLogicEscort")
require("lib/units/civilians/logics/CivilianLogicTravel")
require("lib/units/civilians/logics/CivilianLogicTrade")
CivilianBrain = CivilianBrain or class(CopBrain)
CivilianBrain._logics = {
	inactive = CivilianLogicInactive,
	idle = CivilianLogicIdle,
	surrender = CivilianLogicSurrender,
	flee = CivilianLogicFlee,
	escort = CivilianLogicEscort,
	travel = CivilianLogicTravel,
	trade = CivilianLogicTrade
}

function CivilianBrain:init(unit)
	self._unit = unit
	self._timer = TimerManager:game()
	self:set_update_enabled_state(false)
	self._current_logic = nil
	self._current_logic_name = nil
	self._active = true
	self._SO_access = managers.navigation:convert_access_flag(tweak_data.character[unit:base()._tweak_table].access)
	self._slotmask_enemies = managers.slot:get_mask("criminals")
	CopBrain._reload_clbks[unit:key()] = callback(self, self, "on_reload")
end

function CivilianBrain:update(unit, t, dt)
	local logic = self._current_logic
	if logic.update then
		local l_data = self._logic_data
		l_data.t = t
		l_data.dt = dt
		logic.update(l_data)
	end
end

function CivilianBrain:_reset_logic_data()
	CopBrain._reset_logic_data(self)
	self._logic_data.enemy_slotmask = nil
end

function CivilianBrain:is_available_for_assignment(objective)
	return self._current_logic.is_available_for_assignment(self._logic_data, objective)
end

function CivilianBrain:cancel_trade()
	self:set_logic("surrender")
end

function CivilianBrain:on_rescue_allowed_state(state)
	if self._current_logic.on_rescue_allowed_state then
		self._current_logic.on_rescue_allowed_state(self._logic_data, state)
	end
end

function CivilianBrain:wants_rescue()
	if self._current_logic.wants_rescue then
		return self._current_logic.wants_rescue(self._logic_data)
	end
end

function CivilianBrain:on_cool_state_changed(state)
	if self._logic_data then
		self._logic_data.cool = state
	end
	if self._alert_listen_key then
		managers.groupai:state():remove_alert_listener(self._alert_listen_key)
	else
		self._alert_listen_key = "CopBrain" .. tostring(self._unit:key())
	end
	local alert_listen_filter, alert_types
	if state then
		alert_listen_filter = managers.groupai:state():get_unit_type_filter("criminals_enemies_civilians")
		alert_types = {
			footstep = true,
			bullet = true,
			vo_cbt = true,
			vo_intimidate = true,
			vo_distress = true,
			aggression = true
		}
	else
		alert_listen_filter = managers.groupai:state():get_unit_type_filter("criminal")
		alert_types = {bullet = true}
	end
	managers.groupai:state():add_alert_listener(self._alert_listen_key, callback(self, self, "on_alert"), alert_listen_filter, alert_types, self._unit:movement():m_head_pos())
end

function CivilianBrain:set_attention_settings(att_settings)
	PlayerMovement.set_attention_settings(self, att_settings)
end
