-- Train Delivery Mission
function DeliveryMission(station)
    local destination = {}
    local locations = {}
    local messageSent = false
    for _, locationCfg in pairs(Config.deliveryLocations) do
        if locationCfg.outWest == Stations[station].train.outWest then
            table.insert(locations, locationCfg)
        end
    end
    destination = locations[math.random(1, #locations)]
    DestinationBlip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, destination.trainCoords, 10.0) -- BlipAddForRadius
    Citizen.InvokeNative(0x9CB1A1623062F402, DestinationBlip, _U('deliverySpot')) -- SetBlipName

    VORPcore.NotifyRightTip(_U('goToDeliverSpot'), 4000)
    local beenIn = false
    while InMission do
        local sleep = 1000
        local distance = #(GetEntityCoords(MyTrain) - destination.trainCoords)
        if distance <= destination.radius then
            sleep = 0
            if not messageSent then
                VORPcore.NotifyRightTip(_U('goDeliver'), 4000)
                messageSent = true
            end
            beenIn = true
            if Citizen.InvokeNative(0x78C3311A73135241, MyTrain) then -- IsVehicleStopped
                RemoveBlip(DestinationBlip)
                TriggerEvent('bcc-train:PlayerDelivery', destination)
                break
            end
        end
        if beenIn and distance > destination.radius then
            beenIn = false
            messageSent = false
            VORPcore.NotifyRightTip(_U('trainTooFar'), 4000)
        end
        Wait(sleep)
    end
end

AddEventHandler('bcc-train:PlayerDelivery', function(destination)
    StartDeliveryPrompt()
    DeliveryBlip = Citizen.InvokeNative(0x554D9D53F696D002, -1282792512, destination.deliveryCoords) -- BlipAddForCoords
    Citizen.InvokeNative(0x9CB1A1623062F402, DeliveryBlip, _U('deliverySpot')) -- SetBlipName
    while InMission do
        local sleep = 1000
        local distance = #(GetEntityCoords(PlayerPedId()) - destination.deliveryCoords)
        if distance <= 2 then
            sleep = 0
            PromptSetActiveGroupThisFrame(DeliveryGroup, CreateVarString(10, 'LITERAL_STRING', _U('completeDelivery')))
            if Citizen.InvokeNative(0xE0F65F0640EF0617, DeliveryPrompt) then -- PromptHasHoldModeCompleted
                Wait(500)
                MiniGame.Start('skillcheck', Config.minigame, function(result)
                    if result.passed then
                        VORPcore.NotifyRightTip(_U('deliveryDone') .. destination.pay, 4000)
                        TriggerServerEvent('bcc-train:DeliveryPay', destination)
                        TriggerServerEvent('bcc-train:SetPlayerCooldown', 'delivery')
                    else
                        VORPcore.NotifyRightTip(_U('missionFailed'), 4000)
                    end
                    RemoveBlip(DeliveryBlip)
                    InMission = false
                end)
                break
            end
        end
        Wait(sleep)
    end
end)

AddEventHandler('bcc-train:DeliveryHelper', function()
    while InMission do
        Wait(1000)
        if IsEntityDead(PlayerPedId()) or not MyTrain then
            TriggerEvent('bcc-train:ResetTrain')
            break
        end
    end
end)

-- Blow-up Bacchus Bridge
RegisterNetEvent('bcc-train:BridgeFall', function()
    local ran = 0
    repeat
        local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 10000.0, 'des_trn3_bridge')
        SetStateOfRayfireMapObject(object, 4)
        Wait(100)
        AddExplosion(521.13, 1754.46, 187.65, 28, 1.0, true, false, true)
        AddExplosion(507.28, 1762.3, 187.77, 28, 1.0, true, false, true)
        AddExplosion(527.21, 1748.86, 187.8, 28, 1.0, true, false, true)
        Wait(100)
        SetStateOfRayfireMapObject(object, 6)
        ran = ran + 1
    until ran == 2 --has to run twice no idea why

    --Spawning ghost train model as the game engine wont allow trains to hit each other this will slow the trains down automatically if near the exploded part of the bridge
    Wait(1000)
    local trainHash = joaat('engine_config')
    LoadTrainCars(trainHash)
    local ghostTrain = Citizen.InvokeNative(0xc239dbd9a57d2a71, trainHash, 499.69, 1768.78, 188.77, false, false, true, false) -- CreateMissionTrain

    -- Freeze Train on Spawn
    Citizen.InvokeNative(0xDFBA6BBFF7CCAFBB, ghostTrain, 0.0) -- SetTrainSpeed
    Citizen.InvokeNative(0x01021EB2E96B793C, ghostTrain, 0.0) -- SetTrainCruiseSpeed

    SetEntityVisible(ghostTrain, false)
    SetEntityCollision(ghostTrain, false, false)
end)

CreateThread(function()
    if Config.bacchusBridge.enabled then
        while true do
            local sleep = 1000
            local distance = #(GetEntityCoords(PlayerPedId()) - Config.bacchusBridge.coords)
            if distance <= 2 then
                sleep = 0
                PromptSetActiveGroupThisFrame(BridgeGroup, CreateVarString(10, 'LITERAL_STRING', _U('bacchusBridge')))
                if Citizen.InvokeNative(0xE0F65F0640EF0617, BridgePrompt) then -- PromptHasHoldModeCompleted
                    Wait(500)
                    TriggerServerEvent('bcc-train:BridgeFallHandler', false)
                end
            end
            Wait(sleep)
        end
    end
end)