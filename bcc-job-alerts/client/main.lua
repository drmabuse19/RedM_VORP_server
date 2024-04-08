RegisterNetEvent('bcc:alertplayer')
AddEventHandler('bcc:alertplayer', function(msg, time, job, bliphash, x, y, z, shape, radius, bliptime)
    TriggerEvent("vorp:NotifyLeft", job, msg, 'generic_textures', shape, time)
    local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, bliphash, x, y, z, radius)
    Wait(bliptime)
	RemoveBlip(blip)
end)


RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Wait(1000)
    TriggerServerEvent('bcc:alerts:register')

end)