require("lib/units/enemies/cop/logics/CopLogicBase")
CivilianLogicBase = class(CopLogicBase)

function CivilianLogicBase.on_objective_unit_destroyed(data, unit)
	if not alive(data.unit) then
		debug_pause("dead unit did not remove destroy listener", data.debug_name, inspect(data.objective), data.name)
		return
	end
	data.objective.destroy_clbk_key = nil
	data.objective.death_clbk_key = nil
	managers.groupai:state():on_civilian_objective_failed(data.unit, data.objective)
end
