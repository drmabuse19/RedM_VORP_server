RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Citizen.Wait(2000)
	TriggerServerEvent('bulgarxmas:syncsrv')
end)

RegisterNetEvent('bulgarxmas:sync')
AddEventHandler('bulgarxmas:sync', function(pogoda)
	SetRandomWeatherType(false, false)
	Wait(500)
	SetSnowLevel(-1)
	SetSnowCoverageType(3)
	Wait(500)
	SetWeatherType(pogoda)
end)

function SetSnowCoverageType(type)
	return Citizen.InvokeNative(0xF02A9C330BBFC5C7, type)
end

function SetSnowLevel(type)
	return Citizen.InvokeNative(0xF6BEE7E80EC5CA40, type)
end

function SetWeatherType(pogoda)
	Citizen.InvokeNative(0x59174F1AFE095B5A, GetHashKey(pogoda), false, true, true, 60.0, false)
	Citizen.InvokeNative(0xD74ACDF7DB8114AF, true)
end