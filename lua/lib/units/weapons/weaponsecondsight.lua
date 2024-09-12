WeaponSecondSight = WeaponSecondSight or class(WeaponGadgetBase)
WeaponSecondSight.GADGET_TYPE = "second_sight"

function WeaponSecondSight:init(unit)
	WeaponSecondSight.super.init(self, unit)
end

function WeaponSecondSight:_check_state(current_state)
	if current_state and current_state.in_steelsight and current_state:in_steelsight() then
		current_state:_start_action_steelsight(Application:time())
	end
	WeaponSecondSight.super._check_state(self, current_state)
end

function WeaponSecondSight:toggle_requires_stance_update()
	return true
end

function WeaponSecondSight:destroy(unit)
	WeaponSecondSight.super.destroy(self, unit)
end
