local original_text = LocalizationManager.text
local test_strings = false

function LocalizationManager:text(string_id, ...)

return test_strings == true and string_id or
	original_text(self, string_id, ...)

end
