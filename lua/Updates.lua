local superblt = false
for _, mod in pairs(BLT and BLT.Mods:Mods() or {}) do
	if mod:GetName() == "SuperBLT" and mod:IsEnabled() then
		superblt = true
		break
	end			
end
if superblt == false then
	if UpdateThisMod then
		UpdateThisMod:Add({
			mod_id = 'Real Weapon Names',
			data = {
				modworkshop_id = 19958,
				dl_url = 'https://raw.githubusercontent.com/xDarkWolf/PD2-Real-Weapon-Names/blob/master/RWN.zip',
				info_url = 'https://raw.githubusercontent.com/xDarkWolf/PD2-Real-Weapon-Names/master/mod.txt'
			}
		})
	end

end