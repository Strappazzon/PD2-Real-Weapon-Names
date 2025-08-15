-- From Snh20's string_id Revealer mod
-- //modworkshop.net/mydownloads.php?action=view_down&did=14801
if not StringIDReveal_InChat or StringIDReveal_InChat() then
	return
end

if String_ShowTranslated == nil then
	String_ShowTranslated = false
else
	String_ShowTranslated = not String_ShowTranslated
end
