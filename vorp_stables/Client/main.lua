-- CLIENT_MAIN
Stable = nil
CurrentVendorIndex = nil
local vendorHandles = {}
local blipHandles = {}

local PromptGroup = GetRandomIntInRange(0, 0xffffff)
local PromptOpenVendor

function inDistance(a, b, d)
    local sqrMag = math.pow(a[1] - b[1], 2) + math.pow(a[2] - b[2], 2) + math.pow(a[3] - b[3], 2)
    return sqrMag <= d * d
end

local stableInRange = nil
function CheckNearStable()
    local t = 1000
    if stableInRange == nil then
        for index, stable in pairs(Config.Stables) do
            local pCoords = GetEntityCoords(PlayerPedId());
            local sCoords = stable.EnterStable
            local radius = sCoords[4]
            if inDistance(pCoords, sCoords, radius) then
                stableInRange = stable
                CurrentVendorIndex = index
                return
            end
        end
    else
        local pCoords = GetEntityCoords(PlayerPedId());
        local sCoords = stableInRange.EnterStable
        local radius = sCoords[4]
        if not inDistance(pCoords, sCoords, radius) then
            stableInRange = nil
        elseif not IsNuiFocused() then
            local GroupName = CreateVarString(10, "LITERAL_STRING", stableInRange.Name)
            PromptSetActiveGroupThisFrame(PromptGroup, GroupName)
            if PromptHasHoldModeCompleted(PromptOpenVendor) then
                TriggerEvent("vorp:setInstancePlayer", true)
                SendNUIMessage(json.encode({
                    type = "open",
                    content = {
                        player = Stable,
                        current = stableInRange
                    }
                }));

                SetNuiFocus(true, true)
            end
        end
        t = 0
    end

    Citizen.Wait(t)
end

function InitPlugin()

    local pedModelHash = GetHashKey("U_M_M_BwmStablehand_01")

    while not HasModelLoaded(pedModelHash) do
        RequestModel(pedModelHash, true)
        Citizen.Wait(100)
    end

    for index, stable in pairs(Config.Stables) do
        local sCoords = stable.EnterStable
        local radius = sCoords[4]
        local x = sCoords[1]
        local y = sCoords[2]
        local z = sCoords[3]
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z)
        table.insert(blipHandles, 1, blip)
        Citizen.InvokeNative(0x74F74D3207ED525C, blip, stable.BlipIcon, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, stable.Name)

        local vendorPed = CreatePed(pedModelHash, stable.StableNPC[1], stable.StableNPC[2], stable.StableNPC[3],
            stable.StableNPC[4], false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, vendorPed, true)
        SetEntityNoCollisionEntity(PlayerPedId(), vendorPed, false)
        SetEntityCanBeDamaged(vendorPed, false)
        SetEntityInvincible(vendorPed, true)
        FreezeEntityPosition(vendorPed, true)
        table.insert(vendorHandles, 1, vendorPed)
    end

    SetModelAsNoLongerNeeded(pedModelHash)

    SendNUIMessage(json.encode({
        type = "registerConfig",
        content = Config
    }))

    local str = Config.Lang.Stable
    PromptOpenVendor = PromptRegisterBegin()
    PromptSetControlAction(PromptOpenVendor, 0x760A9C6F)
    str = CreateVarString(10, "LITERAL_STRING", str)
    PromptSetText(PromptOpenVendor, str)
    PromptSetEnabled(PromptOpenVendor, true)
    PromptSetVisible(PromptOpenVendor, true)
    PromptSetHoldMode(PromptOpenVendor, true)
    PromptSetGroup(PromptOpenVendor, PromptGroup)
    PromptRegisterEnd(PromptOpenVendor)

end

function Main()
    Citizen.Wait(2000)
    InitPlugin()
    while true do
        CheckNearStable()
    end
end

Citizen.CreateThread(Main)

RegisterNetEvent("vorp:SelectedCharacter", function(charId)
    TriggerServerEvent(Events.loadStable, charId)
end)

RegisterNetEvent(Events.onStableLoaded, function(result)
    Stable = PlayerStable:new(result.rides, result.charId, result.availableComps, result.transferedRides)
    SendNUIMessage(json.encode({
        type = "refresh",
        content = {
            player = Stable,
            current = stableInRange
        }
    }))
end)

RegisterNetEvent("charsLoaded", function(allChars)
    Data.Characters = allChars
    local message = json.encode({
        type = "refreshChars",
        content = allChars
    })
    SendNUIMessage(message)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if (resourceName == GetCurrentResourceName()) then
        if CurrentHorse ~= nil then
            DeletePed(CurrentHorse.pedId)
        end
        if CurrentCart ~= nil then
            DeleteVehicle(CurrentCart.pedId)
        end
        DeletePed(RidePreviewRef)
        DeleteVehicle(RidePreviewRef)
        FreezeEntityPosition(PlayerPedId(), false);
        TriggerEvent("vorp:setInstancePlayer", false);
        DestroyAllCams(true)
        if resourceName == GetCurrentResourceName() then

            for k, v in ipairs(vendorHandles) do
                DeletePed(v)
            end

            for k, v in ipairs(blipHandles) do
                RemoveBlip(v)
            end
        end
    end
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() and Config.DevMode then
        TriggerServerEvent(Events.loadStableRuntime)
    end
end)

