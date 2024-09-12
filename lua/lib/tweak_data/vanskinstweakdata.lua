VanSkinsTweakData = VanSkinsTweakData or class()

function VanSkinsTweakData:init(tweak_data)
	self.skins = {}
	self.default_skin_id = "default"
	self.skins.default = {}
	self.skins.default.dlc = nil
	self.skins.default.sequence_name = "mat_normal"
	self.skins.overkill = {}
	self.skins.overkill.dlc = "overkill_pack"
	self.skins.overkill.sequence_name = "mat_overkill"
end
