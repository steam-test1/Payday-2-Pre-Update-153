require("lib/units/enemies/cop/logics/CopLogicInactive")
CivilianLogicInactive = class(CopLogicInactive)

function CivilianLogicInactive.on_enemy_weapons_hot(_, data)
	data.unit:brain():set_attention_settings(nil)
end

function CivilianLogicInactive._register_attention(data, my_data)
	if data.unit:character_damage():dead() and not managers.groupai:state():enemy_weapons_hot() then
		my_data.weapons_hot_listener_key = "CopLogicInactive_corpse" .. tostring(data.key)
		managers.groupai:state():add_listener(my_data.weapons_hot_listener_key, {
			"enemy_weapons_hot"
		}, callback(CivilianLogicInactive, CivilianLogicInactive, "on_enemy_weapons_hot", data))
		data.unit:brain():set_attention_settings({
			"civ_enemy_corpse_sneak"
		})
	else
		data.unit:brain():set_attention_settings(nil)
	end
end

function CivilianLogicInactive._set_interaction(data, my_data)
	if data.unit:character_damage():dead() and not managers.groupai:state():enemy_weapons_hot() then
		data.unit:interaction():set_tweak_data("corpse_dispose")
		data.unit:interaction():set_active(true, true, true)
	end
end
