------------------- Pulling Essentials ----------
BccUtils = exports['bcc-utils'].initiate()

-------------- Variables -------------------
local blip, createdped, object

------------- Location Setting ---------------
CreateThread(function()
    TriggerServerEvent('bcc-nazar:LocationSet')
end)

--------------- Nazar Spawn Setup -------------------
RegisterNetEvent('bcc-nazar:PedSpawn', function(nspawn)
    local audioplay, wagonspawn = false, nspawn.nazarwagonspawncoords
    Nspawn = nspawn.nazarspawncoords

    if Config.NazarSetup.nazarswagon then
        object = CreateObject('mp005_p_collectorwagon01', wagonspawn.x, wagonspawn.y, wagonspawn.z - 1, false, false, false)
        RequestModel(object, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, object, true) -- PlaceObjectOnGroundProperly
    end

    if Config.NazarSetup.blip then
        --Pulled from mrterabytes oil fork
        blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, Nspawn.x, Nspawn.y, Nspawn.z) -- This create a blip with a defualt blip hash we given
        SetBlipSprite(blip, Config.NazarSetup.BlipHash, 1) -- This sets the blip hash to the given in config.
        SetBlipScale(blip, 0.8)
        Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(Config.BlipColors[Config.NazarSetup.BlipColor])) -- BlipAddModifier
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.NazarSetup.BlipName) -- SetBlipName
    end

    local model = joaat(Config.NazarSetup.Model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    createdped = CreatePed(model, Nspawn.x, Nspawn.y, Nspawn.z - 1, Nspawn.h, false, true, true, true) --creates ped the minus one makes it so its standing on the ground not floating
    Citizen.InvokeNative(0x283978A15512B2FE, createdped, true) -- sets ped into random outfit, stops it being invis
    BccUtils.Ped.SetStatic(createdped)
    TaskStartScenarioInPlace(createdped, joaat("WORLD_HUMAN_SMOKE_NAZAR"), -1)

    while true do
        Wait(0)
        local sleep = true
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(Nspawn.x, Nspawn.y, Nspawn.z))
        if distance <= 10 then
            sleep = false
            if Config.NazarSetup.Music then
                if not audioplay then
                    audioplay = true
                    BccUtils.YtAudioPlayer.PlayAudio('https://www.youtube.com/embed/IgSBKjBz7Qw', 'IgSBKjBz7Qw', Config.NazarSetup.MusicVolume, 1)
                end
            end
        else
            if Config.NazarSetup.Music then
                if audioplay then
                    audioplay = false
                    BccUtils.YtAudioPlayer.StopAudio()
                end
            end
        end
        if distance <= 2 then
            BccUtils.Misc.DrawText3D(Nspawn.x, Nspawn.y, Nspawn.z, _U('TalkToNPCText'))
            if IsControlJustReleased(0, Config.keys.nazar) then -- [G]
                MainMenu() --opens the menu
                DisplayRadar(false)
            end
        end
        if sleep then
            Wait(1000)
        end
    end
end)

------------- Cleanup ----------------
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        DeletePed(createdped)
        RemoveBlip(blip)
        DeleteEntity(object)
    end
end)