NewShotgunBase = NewShotgunBase or class(NewRaycastWeaponBase)

function NewShotgunBase:init(...)
	NewShotgunBase.super.init(self, ...)
end

SaigaShotgun = SaigaShotgun or class(NewShotgunBase)
