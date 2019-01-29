if not _G.RWNLoc then
_G.RWNLoc = _G.RWNLoc or {}
RWNLoc._path = ModPath .. "lua/loc/"

-- Supported languages
Hooks:Add("LocalizationManagerPostInit", "RWNLoc_LocalizationManagerPostInit", function(loc)
    local current_language = nil
    local supported_languages = {
        ["chinese"] = "ch",
        ["german"] = "de",
        ["english"] = "en",
        ["spanish"] = "es",
        ["french"] = "fr",
        ["italian"] = "it",
        ["russian"] = "ru",
		["thai"] = "th"
    }
    for k,v in pairs(supported_languages) do
        if Idstring(k):key() == SystemInfo:language():key() then
            current_language = v
        end
    end
	--custom language stuff thx to NewPJzuza for help
	for _, mod in pairs(BLT and BLT.Mods:Mods() or {}) do
			if mod:GetName() == "PAYDAY 2 THAI LANGUAGE Mod" and mod:IsEnabled() then
				current_language = "th" 
				break
			end
			if mod:GetName() == "ChnMod (Patch)" and mod:IsEnabled() then
				current_language = "ch" 
				break
			end	
			if mod:GetName() == "Ultimate Localization Manager & 正體中文化" and mod:IsEnabled() then
				current_language = "ch" 
				break
			end		
	end

    if current_language then -- Check current language
		log("RWN: Current language is: " .. current_language)
        local _path = RWNLoc._path .. current_language .. ".json"

        if io.file_is_readable(_path) then -- Does the corresponding file exist?
            loc:load_localization_file(RWNLoc._path .. current_language .. ".json") -- current_language == file name!
            loc:load_localization_file(RWNLoc._path .. "en.json", false) -- If a string is not localized, load the english one
        else -- If the mod is not localized load the default one
            loc:load_localization_file(RWNLoc._path .. "en.json")
        end
    end
end)

end
