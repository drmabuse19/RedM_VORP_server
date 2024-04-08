-- Start Train
CreateThread(function()
    StartMainPrompts()
    SetRandomTrains(false)
    TriggerServerEvent('bcc-train:BridgeFallHandler', true)
    while true do
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)
        local hour = GetClockHours()
        local sleep = 1000

        if IsEntityDead(playerPed) then
            goto continue
        end
        for station, stationCfg in pairs(Stations) do
            if stationCfg.shop.hours.active then
                -- Using Shop Hours - Shop Closed
                if hour >= stationCfg.shop.hours.close or hour < stationCfg.shop.hours.open then
                    if stationCfg.blip.show and stationCfg.blip.showClosed then
                        if not Stations[station].Blip then
                            AddBlip(station)
                        end
                        Citizen.InvokeNative(0x662D364ABF16DE2F, Stations[station].Blip, joaat(Config.blipColors[stationCfg.blip.color.closed])) -- BlipAddModifier
                    else
                        if Stations[station].Blip then
                            RemoveBlip(Stations[station].Blip)
                            Stations[station].Blip = nil
                        end
                    end
                    if stationCfg.NPC then
                        DeleteEntity(stationCfg.NPC)
                        stationCfg.NPC = nil
                    end
                    local distance = #(pCoords - stationCfg.npc.coords)
                    if distance <= stationCfg.shop.distance then
                        sleep = 0
                        local shopClosed = CreateVarString(10, 'LITERAL_STRING',
                            stationCfg.shop.name .. _U('hours') .. stationCfg.shop.hours.open .. _U('to') .. stationCfg.shop.hours.close .. _U('hundred'))
                        PromptSetActiveGroupThisFrame(MenuGroup, shopClosed)
                        PromptSetEnabled(MenuPrompt, false)
                    end
                elseif hour >= stationCfg.shop.hours.open then
                    -- Using Shop Hours - Shop Open
                    if stationCfg.blip.show then
                        if not Stations[station].Blip then
                            AddBlip(station)
                        end
                        Citizen.InvokeNative(0x662D364ABF16DE2F, Stations[station].Blip, joaat(Config.blipColors[stationCfg.blip.color.open])) -- BlipAddModifier
                    end
                    if not stationCfg.shop.jobsEnabled then
                        local distance = #(pCoords - stationCfg.npc.coords)
                        if stationCfg.npc.active then
                            if distance <= stationCfg.npc.distance then
                                if not stationCfg.NPC then
                                    AddNPC(station)
                                end
                            else
                                if stationCfg.NPC then
                                    DeleteEntity(stationCfg.NPC)
                                    stationCfg.NPC = nil
                                end
                            end
                        end
                        if distance <= stationCfg.shop.distance then
                            sleep = 0
                            local shopOpen = CreateVarString(10, 'LITERAL_STRING', stationCfg.shop.prompt)
                            PromptSetActiveGroupThisFrame(MenuGroup, shopOpen)
                            PromptSetEnabled(MenuPrompt, true)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- PromptHasStandardModeCompleted
                                MainMenu(station)
                            end
                        end
                    else
                        -- Using Shop Hours - Shop Open - Job Locked
                        if Stations[station].Blip then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Stations[station].Blip, joaat(Config.blipColors[stationCfg.blip.color.job])) -- BlipAddModifier
                        end
                        local distance = #(pCoords - stationCfg.npc.coords)
                        if stationCfg.npc.active then
                            if distance <= stationCfg.npc.distance then
                                if not stationCfg.NPC then
                                    AddNPC(station)
                                end
                            else
                                if stationCfg.NPC then
                                    DeleteEntity(stationCfg.NPC)
                                    stationCfg.NPC = nil
                                end
                            end
                        end
                        if distance <= stationCfg.shop.distance then
                            sleep = 0
                            local shopOpen = CreateVarString(10, 'LITERAL_STRING', stationCfg.shop.prompt)
                            PromptSetActiveGroupThisFrame(MenuGroup, shopOpen)
                            PromptSetEnabled(MenuPrompt, true)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- PromptHasStandardModeCompleted
                                local hasJob = VORPcore.Callback.TriggerAwait('bcc-train:JobCheck', station)
                                if hasJob then
                                    MainMenu(station)
                                else
                                    VORPcore.NotifyRightTip(_U('wrongJob'), 4000)
                                end
                            end
                        end
                    end
                end
            else
                -- Not Using Shop Hours - Shop Always Open
                if stationCfg.blip.show then
                    if not Stations[station].Blip then
                        AddBlip(station)
                    end
                    Citizen.InvokeNative(0x662D364ABF16DE2F, Stations[station].Blip, joaat(Config.blipColors[stationCfg.blip.color.open])) -- BlipAddModifier
                end
                if not stationCfg.shop.jobsEnabled then
                    local distance = #(pCoords - stationCfg.npc.coords)
                    if stationCfg.npc.active then
                        if distance <= stationCfg.npc.distance then
                            if not stationCfg.NPC then
                                AddNPC(station)
                            end
                        else
                            if stationCfg.NPC then
                                DeleteEntity(stationCfg.NPC)
                                stationCfg.NPC = nil
                            end
                        end
                    end
                    if distance <= stationCfg.shop.distance then
                        sleep = 0
                        local shopOpen = CreateVarString(10, 'LITERAL_STRING', stationCfg.shop.prompt)
                        PromptSetActiveGroupThisFrame(MenuGroup, shopOpen)
                        PromptSetEnabled(MenuPrompt, true)

                        if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- PromptHasStandardModeCompleted
                            MainMenu(station)
                        end
                    end
                else
                    -- Not Using Shop Hours - Shop Always Open - Job Locked
                    if Stations[station].Blip then
                        Citizen.InvokeNative(0x662D364ABF16DE2F, Stations[station].Blip, joaat(Config.blipColors[stationCfg.blip.color.job])) -- BlipAddModifier
                    end
                    local distance = #(pCoords - stationCfg.npc.coords)
                    if stationCfg.npc.active then
                        if distance <= stationCfg.npc.distance then
                            if not stationCfg.NPC then
                                AddNPC(station)
                            end
                        else
                            if stationCfg.NPC then
                                DeleteEntity(stationCfg.NPC)
                                stationCfg.NPC = nil
                            end
                        end
                    end
                    if distance <= stationCfg.shop.distance then
                        sleep = 0
                        local shopOpen = CreateVarString(10, 'LITERAL_STRING', stationCfg.shop.prompt)
                        PromptSetActiveGroupThisFrame(MenuGroup, shopOpen)
                        PromptSetEnabled(MenuPrompt, true)

                        if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- PromptHasStandardModeCompleted
                            local hasJob = VORPcore.Callback.TriggerAwait('bcc-train:JobCheck', station)
                            if hasJob then
                                MainMenu(station)
                            else
                                VORPcore.NotifyRightTip(_U('wrongJob'), 4000)
                            end
                        end
                    end
                end
            end
        end
        ::continue::
        Wait(sleep)
    end
end)

function SpawnTrain(trainCfg, myTrainData, dirChange, station) --credit to rsg_trains for some of the logic here
    local model = trainCfg.model
    local trainHash = joaat(model)
    TrainFuel = myTrainData.fuel
    TrainCondition = myTrainData.condition
    TrainId = myTrainData.trainid

    LoadTrainCars(trainHash)
    MyTrain = Citizen.InvokeNative(0xc239dbd9a57d2a71, trainHash, Stations[station].train.coords, dirChange, false, true, false) -- CreateMissionTrain
    SetModelAsNoLongerNeeded(model)
    -- Freeze Train on Spawn
    Citizen.InvokeNative(0xDFBA6BBFF7CCAFBB, MyTrain, 0.0) -- SetTrainSpeed
    Citizen.InvokeNative(0x01021EB2E96B793C, MyTrain, 0.0) -- SetTrainCruiseSpeed

    TriggerServerEvent('bcc-train:UpdateTrainSpawnVar', true, MyTrain)

    if trainCfg.blip.show then
        local trainBlip = Citizen.InvokeNative(0x23f74c2fda6e7c61, -1749618580, MyTrain) -- BlipAddForEntity
        SetBlipSprite(trainBlip, joaat(trainCfg.blip.sprite), true)
        Citizen.InvokeNative(0x9CB1A1623062F402, trainBlip, trainCfg.blip.name) -- SetBlipNameFromPlayerString
        Citizen.InvokeNative(0x662D364ABF16DE2F, trainBlip, joaat(Config.blipColors[trainCfg.blip.color])) -- BlipAddModifier
    end

    if trainCfg.inventory.enabled then
        TriggerServerEvent('bcc-train:RegisterInventory', TrainId, model)
    end

    if trainCfg.fuel.enabled then
        TriggerEvent('bcc-train:FuelDecreaseHandler', trainCfg, myTrainData)
    end

    if trainCfg.condition.enabled then
        TriggerEvent('bcc-train:CondDecreaseHandler', trainCfg, myTrainData)
    end

    if trainCfg.fuel.enabled or trainCfg.condition.enabled then
        TriggerEvent('bcc-train:TargetMenu', trainCfg)
    end
    TriggerEvent('bcc-train:TrainHandler', trainCfg, myTrainData)
    TriggerEvent('bcc-train:TrainActions')
end

AddEventHandler('bcc-train:TrainHandler', function(trainCfg, myTrainData)
    DrivingMenuOpened = false
    while MyTrain do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local isDead = IsEntityDead(playerPed)
        local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(MyTrain))
        if distance >= Config.despawnDist or isDead then
            if MyTrain then
                if not isDead then
                    VORPcore.NotifyRightTip(_U('tooFarFromTrain'), 4000)
                end
                TriggerEvent('bcc-train:ResetTrain')
                break
            end
        elseif distance <= 10 then
            sleep = 0
            if not Citizen.InvokeNative(0xE052C1B1CAA4ECE4, MyTrain, -1) and GetPedInVehicleSeat(MyTrain, -1) == playerPed then -- IsVehicleSeatFree
                if not DrivingMenuOpened then
                    DrivingMenuOpened = true
                    DrivingMenu(trainCfg, myTrainData)
                    ShowHUD(TrainCondition, trainCfg.condition.maxAmount, TrainFuel, trainCfg.fuel.maxAmount)
                end
            else
                if DrivingMenuOpened then
                    DrivingMenuOpened = false
                    VORPMenu.CloseAll()
                    HideHUD()
                    ForwardActive = false
                    BackwardActive = false
                end
            end
        end
        Wait(sleep)
    end
end)

AddEventHandler('bcc-train:FuelDecreaseHandler', function(trainCfg, myTrainData)
    local fuelEmpty = false
    while MyTrain do
        Wait(1000)
        if EngineStarted and TrainFuel >= 1 then
            Wait(trainCfg.fuel.decreaseTime * 1000)
            local fuel = VORPcore.Callback.TriggerAwait('bcc-train:DecTrainFuel', TrainId, TrainFuel, trainCfg)
            if fuel then
                FuelUpdate(fuel)
            end
        else
            Citizen.InvokeNative(0x9F29999DFDF2AEB8, MyTrain, 0.0) -- SetTrainMaxSpeed
        end
        if TrainFuel <= 0 and not fuelEmpty then
            fuelEmpty = true
            EngineStarted = false
            Citizen.InvokeNative(0x9F29999DFDF2AEB8, MyTrain, 0.0) -- SetTrainMaxSpeed
            if DrivingMenuOpened then
                DrivingMenu(trainCfg, myTrainData)
            end
        elseif fuelEmpty and TrainFuel >= 1 then
            fuelEmpty = false
        end
    end
end)

AddEventHandler('bcc-train:CondDecreaseHandler', function(trainCfg, myTrainData)
    local conditionEmpty = false
    while MyTrain do
        Wait(1000)
        if EngineStarted and TrainCondition >= 1 then
            Wait(trainCfg.condition.decreaseTime * 1000)
            local cond = VORPcore.Callback.TriggerAwait('bcc-train:DecTrainCond', TrainId, TrainCondition, trainCfg)
            if cond then
                ConditionUpdate(cond)
            end
        else
            Citizen.InvokeNative(0x9F29999DFDF2AEB8, MyTrain, 0.0) -- SetTrainMaxSpeed
        end
        if TrainCondition <= 0 and not conditionEmpty then
            conditionEmpty = true
            EngineStarted = false
            Citizen.InvokeNative(0x9F29999DFDF2AEB8, MyTrain, 0.0) -- SetTrainMaxSpeed
            if DrivingMenuOpened then
                DrivingMenu(trainCfg, myTrainData)
            end
        elseif conditionEmpty and TrainCondition >= 1 then
            conditionEmpty = false
        end
    end
end)

-- Open Train Inventory
AddEventHandler('bcc-train:TrainActions', function()
    local invKey = Config.keys.inventory
    while MyTrain do
        local playerPed = PlayerPedId()
        Wait(0)
        if Citizen.InvokeNative(0x580417101DDB492F, 0, invKey) then -- IsControlJustPressed
            if not Citizen.InvokeNative(0x6F972C1AB75A1ED0, playerPed) then -- IsPedInAnyTrain
                goto continue
            end
            local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(MyTrain))
            if dist <= 10 then
                TriggerServerEvent('bcc-train:OpenInventory', TrainId)
            end
            ::continue::
        end
    end
end)

-- Cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if MyTrain then
        DeleteEntity(MyTrain)
        HideHUD()
    end
    for _, stationCfg in pairs(Stations) do
        if stationCfg.Blip then
            RemoveBlip(stationCfg.Blip)
            stationCfg.Blip = nil
        end
        if stationCfg.NPC then
            DeleteEntity(stationCfg.NPC)
            stationCfg.NPC = nil
        end
    end
    VORPMenu.CloseAll()
    DisplayRadar(true)
    if DestinationBlip then
        RemoveBlip(DestinationBlip)
        DestinationBlip = nil
    end
    if DeliveryBlip then
        RemoveBlip(DeliveryBlip)
        DeliveryBlip = nil
    end
end)

AddEventHandler('playerDropped', function ()
    if MyTrain then
        DeleteEntity(MyTrain)
        MyTrain = nil
        TriggerServerEvent('bcc-train:UpdateTrainSpawnVar', false)
    end
end)
