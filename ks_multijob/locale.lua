Locales = {}

function _(str, ...) -- Translate string

	if Locales[Config.defaultLang] ~= nil then

		if Locales[Config.defaultLang][str] ~= nil then
			return string.format(Locales[Config.defaultLang][str], ...)
		else
			return 'Translation [' .. Config.defaultLang .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. Config.defaultLang .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end