
function EconomyTweakData:create_weapon_skin_market_search_url(weapon_id, cosmetic_id)
	local cosmetic_name = tweak_data.blackmarket.weapon_skins[cosmetic_id] and managers.localization:text(tweak_data.blackmarket.weapon_skins[cosmetic_id].name_id)
	local weapon_name = managers.localization.orig.text(managers.localization, tweak_data.weapon[weapon_id].name_id) -- bypass custom localizations
	if cosmetic_name and weapon_name then
		cosmetic_name = string.gsub(cosmetic_name, " ", "+")
		weapon_name = string.gsub(weapon_name, " ", "+")
		return string.gsub("https://steamcommunity.com/market/search?appid=218620&q=" .. cosmetic_name .. "+" .. weapon_name, "++", "+")
	end
	return nil
end
