require("lib/managers/BlackMarketManager")
MaskExt = MaskExt or class()
local mvec1 = Vector3()
local mvec2 = Vector3()

function MaskExt:init(unit)
	self._unit = unit
	self._blueprint = {}
	Application:debug("MaskExt:new()")
end

function MaskExt:apply_blueprint(blueprint)
	if not blueprint then
		return
	end
	local materials = self._unit:get_objects_by_type(Idstring("material"))
	local material = materials[#materials]
	local tint_color_a = mvec1
	local tint_color_b = mvec2
	local pattern_id = blueprint.pattern.id
	local material_id = blueprint.material.id
	local color_data = tweak_data.blackmarket.colors[blueprint.color.id]
	mvector3.set_static(tint_color_a, color_data.colors[1]:unpack())
	mvector3.set_static(tint_color_b, color_data.colors[2]:unpack())
	material:set_variable(Idstring("tint_color_a"), tint_color_a)
	material:set_variable(Idstring("tint_color_b"), tint_color_b)
	local old_pattern = self._blueprint[1]
	local pattern = tweak_data.blackmarket.textures[pattern_id].texture
	if old_pattern ~= Idstring(pattern) then
		local pattern_texture = TextureCache:retrieve(pattern, "normal")
		material:set_texture("material_texture", pattern_texture)
	end
	local old_reflection = self._blueprint[2]
	local reflection = tweak_data.blackmarket.materials[material_id].texture
	if old_reflection ~= Idstring(reflection) then
		local reflection_texture = TextureCache:retrieve(reflection, "normal")
		material:set_texture("reflection_texture", reflection_texture)
	end
	local material_amount = tweak_data.blackmarket.materials[material_id].material_amount or 1
	material:set_variable(Idstring("material_amount"), material_amount)
	local new_blueprint = {
		Idstring(pattern),
		Idstring(reflection)
	}
	self:unretrieve_blueprint(new_blueprint)
	self._blueprint = new_blueprint
end

function MaskExt:unretrieve_blueprint(new_blueprint)
	if self._blueprint then
		for index, texture_ids in pairs(self._blueprint) do
			if new_blueprint and new_blueprint[index] == texture_ids then
			else
				TextureCache:unretrieve(texture_ids)
			end
		end
	end
	self._blueprint = {}
end

function MaskExt:destroy(unit)
	print("MaskExt:destroy")
	self:unretrieve_blueprint()
end

function MaskExt:pre_destroy(unit)
	print("MaskExt:pre_destroy")
	self:unretrieve_blueprint()
end
