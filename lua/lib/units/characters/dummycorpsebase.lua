DummyCorpseBase = DummyCorpseBase or class(UnitBase)

function DummyCorpseBase:init(unit)
	UnitBase.init(self, unit, false)
end

function DummyCorpseBase:set_material_state(original)
end
