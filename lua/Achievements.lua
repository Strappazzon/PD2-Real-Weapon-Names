String_ShowTranslated = String_ShowTranslated or false
local text_actual = LocalizationManager.text
local t = {
	-- Pistols
	["bm_w_c96"]             = "Broomstick Pistol",
	["bm_w_usp"]             = "Interceptor 45 Pistol",
	["bm_w_ppk"]             = "Gruber Kurz Pistol",
	["bm_w_colt_1911"]       = "Crosskill Pistol",
	["bm_w_p226"]            = "Signature .40 Pistol",
	["bm_w_g22c"]            = "Chimano Custom Pistol",
	["bm_wp_pis_g26"]        = "Chimano 88 Pistol",
	["bm_w_b92fs"]           = "Bernetti 9 Pistol",
	["bm_w_packrat"]         = "Contractor Pistol",
	["bm_w_peacemaker"]      = "Peacemaker .45 Revolver",
	["bm_w_x_b92fs"]         = "Akimbo Bernetti 9 Pistols",
	["bm_w_chinchilla"]      = "Castigo .44 Revolver",
	-- Attachments
	["bm_wp_c96_nozzle"]      = "Damper.L 44 Nozzle",
	["bm_wp_c96_sight"]       = "Barrel Sight 44",
	["bm_wp_upg_o_spot"]      = "Reconnaissance Sight",
	["bm_wpn_fps_upg_o_45rds"] = "45 Degree Red Dot Sight",
	["bm_wp_ns_duck"]         = "Donald's Horizontal Leveller",
	-- Assault rifles
	["bm_w_akm_gold"] = "Golden AK.762 Rifle",
	["bm_w_s552"]     = "Commando 553 Rifle",
	["bm_w_ak5"]      = "AK5 Rifle",
	["bm_w_aug"]      = "UAR Rifle",
	["bm_w_scar"]     = "Eagle Heavy Rifle",
	["bm_w_m4"]       = "CAR-4 Rifle",
	["bm_w_g3"]       = "Gewehr 3 Rifle",
	["bm_w_galil"]    = "Gecko 7.62 Rifle",
	["bm_w_famas"]    = "Clarion Rifle",
	["bm_w_ak74"]     = "AK Rifle",
	["bm_w_amcar"]    = "AMCAR Rifle",
	["bm_w_corgi"]    = "Union 5.56 Rifle",
	-- Submachineguns
	["bm_w_mp7"]     = "SpecOps Submachine Gun",
	["bm_w_m45"]     = "Swedish K Submachine Gun",
	["bm_w_p90"]     = "Kobus 90 Submachine Gun",
	["bm_w_m1928"]   = "Chicago Typewriter Submachine Gun",
	["bm_w_olympic"] = "Para Submachine Gun",
	["bm_w_polymer"] = "Kross Vertex Submachine Gun",
	["bm_w_schakal"] = "Jackal Submachine Gun",
	["bm_w_coal"]    = "Tatonka Submachine Gun",
	-- Sniper rifles
	["bm_w_msr"]       = "Rattlesnake Sniper Rifle",
	["bm_w_m95"]       = "Thanatos .50 cal Sniper Rifle",
	["bm_w_r93"]       = "R93 Sniper Rifle",
	["bm_w_desertfox"] = "Desertfox Sniper Rifle",
	["bm_w_mosin"]     = "Nagant Sniper Rifle",
	["bm_w_model70"]    = "Platypus 70 Sniper Rifle",
	["bm_w_wa2000"]    = "Lebensauger .308 Sniper Rifle",
	-- Shotguns
	["bm_w_serbu"]    = "Locomotive 12G Shotgun",
	["bm_w_judge"]    = "The Judge Shotgun",
	["bm_w_striker"]  = "Street Sweeper Shotgun",
	["bm_w_r870"]     = "Reinfeld 880 Shotgun",
	["bm_w_huntsman"] = "Mosconi 12G Shotgun",
	["bm_w_saiga"]    = "Izhma 12G Shotgun",
	["bm_w_ksg"]      = "Raven Shotgun",
	["bm_w_benelli"]  = "M1014 Shotgun",
	["bm_w_sko12"]    = "VD-12 Shotgun",
	-- LMGs
	["bm_w_mg42"] = "Buzzsaw 42 Light Machine Gun",
	-- Throwables
	["bm_dynamite"]                   = "Dynamite",
	["bm_wpn_prj_jav"]                = "Javelin",
	["bm_wpn_prj_target"]             = "Throwing Knife",
	["bm_wpn_prj_four"]               = "Shuriken",
	["bm_grenade_poison_gas_grenade"] = "Viper Grenade",
	-- Specials
	["bm_w_m134"]      = "Vulcan Minigun",
	["bm_w_gre_m79"]   = "GL40 Grenade Launcher",
	["bm_w_rpg7"]      = "HRL-7 Rocket Launcher",
	["bm_w_m32"]       = "Piglet Grenade Launcher",
	["bm_w_saw"]       = "OVE9000 Saw",
	["bm_w_arbiter"]   = "Arbiter Grenade Launcher",
	["bm_w_ray"]       = "Commando 101 Rocket Launcher",
	["bm_w_slap"]      = "Compact 40mm Grenade Launcher",
	["bm_w_hailstorm"] = "Hailstorm Mk 5",
	-- Melees
	["bm_melee_baton"]         = "Telescopic Baton",
	["bm_melee_shovel"]        = "K.L.A.S. Shovel",
	["bm_melee_dingdong"]      = "Ding Dong Breaching Tool",
	["bm_melee_bat"]           = "Baseball Bat",
	["bm_melee_toothbrush"]    = "Nova's Shank",
	["bm_melee_fairbair"]      = "Trench Knife",
	["bm_melee_boxing_gloves"] = "OVERKILL Boxing Gloves",
	["bm_melee_fork"]          = "The Motherforker",
	["bm_melee_great"]         = "Great Sword",
	["bm_melee_moneybundle"]   = "Money Bundle",
	["bm_melee_taser"]         = "Buzzer",
	["bm_melee_zeus"]          = "Electrical Brass Knuckles",
	["bm_melee_clean"]         = "Alabama Razor"
}
local function achievement_string(self, string_id, ...)
	if String_ShowTranslated == true then
		if t[string_id] then
			return text_actual(self, "RWN_" .. string_id, ...)
		end
	end
	return text_actual(self, string_id, ...)
end

-- From Snh20's string_id Revealer mod
-- //modworkshop.net/mydownloads.php?action=view_down&did=14801
function LocalizationManager:text(string_id, ...)
	return true and achievement_string(self, string_id, ...)
end

-- Helper functions used by the toggle.lua script
local function IsInHUDChat()
	if managers.hud ~= nil and managers.hud._chat_focus == true then
		return true
	end
	return false
end

local function IsInLobbyChat()
	if managers.menu_component ~= nil and managers.menu_component._game_chat_gui ~= nil and managers.menu_component._game_chat_gui:input_focus() == true then
		return true
	end
	return false
end

function StringIDReveal_InChat()
	return IsInHUDChat() or IsInLobbyChat()
end
