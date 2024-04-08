local hasPrison = false
FrameWork = Config.FrameWork


RegisterNetEvent("d-labs:c:setclothes") -- prison outfit event
AddEventHandler("d-labs:c:setclothes", function()
    local ped = PlayerPedId()
    RequestAnimDict('mech_inventory@clothing@outfit_change')
    while not HasAnimDictLoaded('mech_inventory@clothing@outfit_change') do
        Citizen.Wait(0)
    end

    RemoveAllPedWeapons(ped, true, true)

    TaskPlayAnim(ped, 'mech_inventory@clothing@outfit_change', 'outfit_change_unarmed', 4.0, 4.0, -1, 25, 0, false, false, false) -- start animace )¨

    Citizen.Wait(1000)


    if hasPrison == false then
        TriggerEvent("Notification:left", 'success', Config.Translation.PrisonOn, Config.Notif.alert[1], Config.Notif.alert[2], 4000)
        hasPrison = true

        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3F7F3587, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x49C89D9B, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x4A73515C, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x514ADCEA, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x5FC29285, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x79D7DF96, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x7A96FACA, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x877A2CF7, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x9925C067, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x485EE834, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x18729F39, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3107499B, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3C1A74CD, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x3F1F01E5, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x9B2C8B89, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xA6D134C6, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xE06D30CE, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x662AC34, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xAF14310B, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x72E6EF74, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xEABE0032, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0x2026C46D, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xB6B6122D, true, true, true)
        Citizen.InvokeNative(0xDF631E4BCE1B1FC4, ped, 0xB9E2FA01, true, true, true)

        if IsPedMale(ped) then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x5BA76CCF, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x216612F0, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x1CCEE58D, true, true, true)
        else
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x6AB27695, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x75BC0CF5, true, true, true)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x14683CDF, true, true, true)
        end

    else
        TriggerEvent("Notification:left", 'success', Config.Translation.PrisonOff, Config.Notif.alert[1], Config.Notif.alert[2], 4000)
        hasPrison = false

        if FrameWork == 'RSG' then
            ExecuteCommand("db")

        elseif FrameWork == 'VORP' then
            ExecuteCommand("rc")
        else 
            ExecuteCommand(Config.Reset)
        end
    end

    ClearPedTasks(ped)
    
end)


RegisterNetEvent('Notification:left')
AddEventHandler('Notification:left', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Citizen.Wait(5)
        end
    end
    if txtr ~= nil then
        exports.d_labs_prisonclothes.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.d_labs_prisonclothes.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)
