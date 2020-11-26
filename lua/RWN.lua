_G.RWNLoc = _G.RWNLoc or {}
RWNLoc._path = ModPath .. "lua/loc/"
RWNLoc._menufile = ModPath .. "lua/menu/options.json"
RWNLoc.settings_path = SavePath .. "RWN.json"
RWNLoc.settings = {}


function RWNLoc:Save()
        local file = io.open(self.settings_path, "w+")
        if file then
            file:write(json.encode(self.settings))
        end
end

function RWNLoc:LoadDefaults()
        self.settings = {
            rwn_menu_langchoice_value = 1,
			rwn_menu_parts_weapons_value = "on",
			rwn_menu_parts_mods_value = "on",
			rwn_menu_parts_melee_value = "on",
			rwn_menu_parts_throwables_value = "on"
        }
end

function RWNLoc:LoadValues(rwn_table, file_table)
    for k, v in pairs(file_table) do -- Loads values to the table
        rwn_table[k] = v
    end
end

function RWNLoc:Load()
        self:LoadDefaults()
        local file = io.open(self.settings_path, "r")
        if file then
            self:LoadValues(self.settings, json.decode(file:read('*all')) or {})
            file:close()
        end
end

-- menu
Hooks:Add(
"MenuManagerInitialize",
"RWNLoc_MenuManagerInitialize",
function( menu_manager )

    MenuCallbackHandler.rwn_menu_langchoice_callback = function(self, item)
            RWNLoc.settings.rwn_menu_langchoice_value = item:value()
    end
	
	MenuCallbackHandler.rwn_menu_parts_weapons_callback = function(self, item)
			RWNLoc.settings.rwn_menu_parts_weapons_value = (item:value() == "on")
	end
	
	MenuCallbackHandler.rwn_menu_parts_mods_callback = function(self, item)
			RWNLoc.settings.rwn_menu_parts_mods_value = (item:value() == "on")
	end
	
	MenuCallbackHandler.rwn_menu_parts_melee_callback = function(self, item)
			RWNLoc.settings.rwn_menu_parts_melee_value = (item:value() == "on")
	end
	
	MenuCallbackHandler.rwn_menu_parts_throwables_callback = function(self, item)
			RWNLoc.settings.rwn_menu_parts_throwables_value = (item:value() == "on")
	end
    
    MenuCallbackHandler.rwnloc_save = function(self, item)
            RWNLoc:Save()
    end
    
    RWNLoc:Load()
    MenuHelper:LoadFromJsonFile(RWNLoc._menufile, RWNLoc, RWNLoc.settings)
end
)

-- Supported languages
Hooks:Add(
    "LocalizationManagerPostInit",
    "RWNLoc_LocalizationManagerPostInit",
    function(loc)
        local current_language = nil
        RWNLoc:Load()
        if RWNLoc.settings.rwn_menu_langchoice_value == 1 then
            -- automatic language selection
            local supported_languages = {
                ["chinese"] = "zh",
                ["german"] = "de",
                ["english"] = "en",
                ["spanish"] = "es",
                ["french"] = "fr",
                ["italian"] = "it",
                ["russian"] = "ru",
                ["thai"] = "th"
            }
            for k, v in pairs(supported_languages) do
                if Idstring(k):key() == SystemInfo:language():key() then
                    current_language = v
                end
            end

            -- Custom language stuff
            -- thx to NewPJzuza for help
            for _, mod in pairs(BLT and BLT.Mods:Mods() or {}) do
                if mod:GetName() == "PAYDAY 2 THAI LANGUAGE Mod" and mod:IsEnabled() then
                    current_language = "th"
                    break
                end
                if mod:GetName() == "ChnMod (Patch)" and mod:IsEnabled() then
                    current_language = "zh"
                    break
                end
                if mod:GetName() == "Ultimate Localization Manager & 正體中文化" and mod:IsEnabled() then
                    current_language = "zh"
                    break
                end
            end
        else
            -- manual language selection
            local supported_languages = {
                [2] = "en",
                [3] = "de",
                [4] = "es",
                [5] = "fr",
                [6] = "it",
                [7] = "ru"
            }
            if supported_languages[RWNLoc.settings.rwn_menu_langchoice_value] then
                current_language = supported_languages[RWNLoc.settings.rwn_menu_langchoice_value]
            end
        end
        
        -- Check current language
        if current_language then
            log("RWN: Current language is: " .. current_language)
            local _path = RWNLoc._path .. "util." .. current_language .. ".json"

            -- Does the corresponding file exist?
            if io.file_is_readable(_path) then
				if RWNLoc.settings.rwn_menu_parts_weapons_value == true or RWNLoc.settings.rwn_menu_parts_weapons_value == "on" then -- load weapons if enabled
					loc:load_localization_file(RWNLoc._path .. "weapons." .. current_language .. ".json")
					loc:load_localization_file(RWNLoc._path .. "weapons.en.json", false)
				end
				if RWNLoc.settings.rwn_menu_parts_mods_value == true or RWNLoc.settings.rwn_menu_parts_mods_value == "on" then -- load weapon mods if enabled
					loc:load_localization_file(RWNLoc._path .. "mods." .. current_language .. ".json")
					loc:load_localization_file(RWNLoc._path .. "mods.en.json", false)
				end
				if RWNLoc.settings.rwn_menu_parts_melee_value == true or RWNLoc.settings.rwn_menu_parts_melee_value == "on" then -- load melee weapons if enabled
					loc:load_localization_file(RWNLoc._path .. "melee." .. current_language .. ".json")
					loc:load_localization_file(RWNLoc._path .. "melee.en.json", false)
				end
				if RWNLoc.settings.rwn_menu_parts_throwables_value == true or RWNLoc.settings.rwn_menu_parts_throwables_value == "on" then -- load throwables if enabled
					loc:load_localization_file(RWNLoc._path .. "throwables." .. current_language .. ".json")
					loc:load_localization_file(RWNLoc._path .. "throwables.en.json", false)
				end
                -- load utils strings
                loc:load_localization_file(RWNLoc._path .. "util." .. current_language .. ".json")
                loc:load_localization_file(RWNLoc._path .. "util.en.json", false)
            end
        end
    end
)
