RidePreviewRef = nil
local instanceCam = nil

RegisterNuiCallback("buyRide", function(data, callback)
    if PlayerStable:isFull(Stable, data.rideType) then
        return TriggerEvent("vorp:TipRight", Config.Lang.TipStableFull, 4000);
    end

    TriggerEvent("vorpinputs:getInput", Config.Lang.Ok, Config.Lang.PlaceHolderRideName,
        function(rideName)
            if #rideName < 3 then
                TriggerEvent("vorp:TipRight", "~e~" .. Config.Lang.TipNameTooShort, 3000);
            else
                TriggerServerEvent(Events.onBuyRide, rideName, data.rideModel, data.rideType, data.price);
            end
        end)
end)

RegisterNuiCallback("showRide", function(data, callback)
    Citizen.CreateThread(function()
        local entityRef
        local rideHash = GetHashKey(data.rideName)

        LoadModel(rideHash)
        DeletePed(RidePreviewRef)
        DeleteVehicle(RidePreviewRef)
        Wait(500)

        if data.rideType == "horse" then

            local x, y, z, h = table.unpack(Config.Stables[CurrentVendorIndex].SpawnHorse)
            entityRef = CreatePed(rideHash, x, y, z, h, false, true, true, true)
            Citizen.InvokeNative(0x283978A15512B2FE, entityRef, true)
            if data.rideComps ~= nil then
                for compType, comp in pairs(data.rideComps) do
                    ApplyShopItemToPed(entityRef, comp)
                end
            else
                Citizen.InvokeNative(0xC8A9481A01E63C28, entityRef, 1);
            end

        elseif data.rideType == "cart" then

            local x, y, z, h = table.unpack(Config.Stables[CurrentVendorIndex].SpawnCart)
            entityRef = CreateVehicle(rideHash, x, y, z, h, false, true, true, true)
            Citizen.InvokeNative(0xAF35D0D2583051B0, entityRef, true)

        end

        SetEntityCanBeDamaged(horsePed, false)
        SetEntityInvincible(horsePed, true)
        FreezeEntityPosition(horsePed, true)
        SetModelAsNoLongerNeeded(hashPed)

        RidePreviewRef = entityRef
    end)
end)

RegisterNuiCallback("activateCam", function(data, callback)
    FreezeEntityPosition(PlayerPedId(), true);

    local x, y, z, rx, ry, rz, fov
    if data.rideType == "horse" then
        x, y, z, rx, ry, rz = table.unpack(Config.Stables[CurrentVendorIndex].CamHorse)
        fov = 70.0
    elseif data.rideType == "cart" then
        x, y, z, rx, ry, rz = table.unpack(Config.Stables[CurrentVendorIndex].CamCart)
        fov = 50.0
    end


    DestroyCam(instanceCam, true)
    instanceCam = Citizen.InvokeNative(0x40C23491CE83708E,"DEFAULT_SCRIPTED_CAMERA", x, y, z, rx, ry, rz, fov, false, 0);
    SetCamActive(instanceCam, true);
    RenderScriptCams(true, true, 1000, true, true, 0);

end)

local currentlyPreviewedCompModel = nil

RegisterNuiCallback("viewComp", function(data, callback)
    ReloadCompFromCurrent(currentlyPreviewedCompModel, tonumber(data.modelHash))
    currentlyPreviewedCompModel = data.modelHash
end)

RegisterNuiCallback("removeAllComps", function(data, callback)
    print(data.rideId)
    TriggerServerEvent(Events.onRemoveComps, data.rideId)
    for k, ride in pairs(Stable.rides) do
        if(ride.id == data.rideId) then
            Citizen.InvokeNative(0xC8A9481A01E63C28, RidePreviewRef, false)
            ride.comps = {}
            break
        end
    end
end)

RegisterNuiCallback("buyComp", function(data, callback)
    local currentRide
    for k, ride in pairs(Stable.rides) do
        if(ride.id == data.horseId) then
            currentRide = ride
            break
        end
    end
    TriggerServerEvent(Events.onBuyComp, data.compModel, data.compType, data.price, data.horseId, currentRide.comps, Stable.availableComps);
end)

RegisterNuiCallback("setDefault", function(data, callback)
    TriggerServerEvent(Events.setDefault, data.newRide, data.prevRide)
end)

RegisterNuiCallback("transfer", function(data, callback)
    local actPlayers = {}
    for i, v in ipairs(GetActivePlayers()) do
        actPlayers[i] = GetPlayerServerId(v)
    end
    TriggerServerEvent(Events.onTransfer, data.rideId, data.selectedChar, data.price, actPlayers)
end)

RegisterNuiCallback("transferRecieve", function(data, callback)local actPlayers = {}
    local actPlayers = {}
    for i, v in ipairs(GetActivePlayers()) do
        actPlayers[i] = GetPlayerServerId(v)
    end
    TriggerServerEvent(Events.onTransferRecieve, data.rideId, data.state, data.price, actPlayers)
end)

RegisterNuiCallback("free", function(data, callback)
    DeletePed(RidePreviewRef)
    DeleteVehicle(RidePreviewRef)
    TriggerServerEvent(Events.onDelete, data.rideId)
end)

function ApplyShopItemToPed(entity, model)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, entity, model, true, true, true);
end

function RemoveShopItemFromPed(entity, model)
    Citizen.InvokeNative(0x0D7FFA1B2F69ED82, entity, model, true, true);
end

function UpdatePedVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0);
end

function ReloadCompFromCurrent(previousModel, model)
    RemoveShopItemFromPed(RidePreviewRef, tonumber(previousModel))
    ApplyShopItemToPed(RidePreviewRef, model)
    UpdatePedVariation(RidePreviewRef)
end

RegisterNuiCallback("exit", function(data, callback)
    DeletePed(RidePreviewRef)
    DeleteVehicle(RidePreviewRef)
    FreezeEntityPosition(PlayerPedId(), false);
    TriggerEvent("vorp:setInstancePlayer", false);
    DestroyAllCams(true)
    SetNuiFocus(false)
end)

function LoadModel(hash)
    if IsModelValid(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100);
        end
        return true
    else
        return false
    end

end
