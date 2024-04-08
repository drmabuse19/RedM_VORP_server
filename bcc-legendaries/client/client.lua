--------- Legendary Animal Spawn Setup -----------
function spawnanimal()
    local secondaryanimals = {}
    local model = joaat(Data.pedmodel)
    local coords = Data.coordinates

    modelload(model)

    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, coords.x, coords.y, coords.z, 130.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('Lastlocationblip'))
    VORPutils.Gps:SetGps(coords.x, coords.y, coords.z)

    distcheck(coords.x, coords.y, coords.z, 40, PlayerPedId())
    if StopAll then
        RemoveBlip(blip)
        VORPutils.Gps:RemoveGps()
        VORPcore.NotifyRightTip(_U('Deadtext'), 4000) return
    end
    RemoveBlip(blip)
    VORPutils.Gps:RemoveGps()

    if Data.SecondaryAnimals.secondaryanimals then
        for o, e in pairs(Data.SecondaryAnimals.Animalspawns) do
            secondaryanimals[o] = spawnPed(Data.SecondaryAnimals.animalmodel, e.x, e.y, e.z, true)
        end
    end
    Createdped2 = spawnPed(model, coords.x, coords.y, coords.z, true)
    VORPcore.NotifyRightTip(_U('LegAnimalSpawned'), 4000)
    SetEntityHealth(Createdped2, Data.Leganimalhealth, 0)

    while true do
        Wait(100)
        if StopAll then break end
        if IsEntityDead(Createdped2) then
            Inmission = false
            skinnedped() break
        end
    end
    if StopAll then
        if Data.SecondaryAnimals.secondaryanimals then
            for e, u in pairs(secondaryanimals) do
                DeletePed(u)
            end
        end
        DeletePed(Createdped2)
        VORPcore.NotifyRightTip(_U('Deadtext'), 4000) return
    end
end