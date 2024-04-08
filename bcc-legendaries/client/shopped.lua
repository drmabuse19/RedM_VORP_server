local npcs, blips = {}, {}

CreateThread(function()
    for k, v in pairs(Config.shop) do
        local model = joaat('mp_re_slumpedhunter_males_01')
        modelload(model)

        local npc = CreatePed(model, v.Pos.x, v.Pos.y, v.Pos.z - 1.0, v.Pos.h, false, false, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
        BccUtils.Ped.SetStatic(npc)
        
        if v.allowblip then
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, v.BlipHash, 1)
            SetBlipScale(blip, 0.8)
            Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(v.BlipColor))
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.BlipName)
            table.insert(blips, blip)
        end

        table.insert(npcs, npc)
    end
end)

-- Call the DeleteNPCs function when the resource stops
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end
        for k, v in pairs(npcs) do
            DeletePed(v)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(5)
        local coords = GetEntityCoords(PlayerPedId())
        local sleep = true
        for k, v in pairs(Config.shop) do
            if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 2.5 then
                sleep = false
                BccUtils.Misc.DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, _U("Shoptext"))
            end
        end
        if sleep then
            Wait(1500)
        end
    end
end)