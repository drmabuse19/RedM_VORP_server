-- Dependencies
VORPcore = exports.vorp_core:GetCore()
VORPMenu = {}
TriggerEvent('vorp_menu:getData', function(cb)
    VORPMenu = cb
end)
BccUtils = exports['bcc-utils'].initiate()
MiniGame = exports['bcc-minigames'].initiate()
-- Prompts
MenuPrompt = nil
MenuGroup = GetRandomIntInRange(0, 0xffffff)
BridgePrompt = nil
BridgeGroup = GetRandomIntInRange(0, 0xffffff)
DeliveryPrompt = nil
DeliveryGroup = GetRandomIntInRange(0, 0xffffff)
DeliveryPromptStarted = false
TargetPromptsStarted = false
-- Train Globals
MyTrain = nil
TrainId = nil
TrainFuel = nil
TrainCondition = nil
DrivingMenuOpened = false
FuelTarget = nil
RepairTarget = nil
InMission = false
EngineStarted = false
ForwardActive = false
BackwardActive = false

function AddBlip(station)
    local stationCfg = Stations[station]
    stationCfg.Blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, stationCfg.npc.coords) -- BlipAddForCoords
    SetBlipSprite(stationCfg.Blip, stationCfg.blip.sprite, true)
    SetBlipScale(stationCfg.Blip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, stationCfg.Blip, stationCfg.blip.name) -- SetBlipNameFromPlayerString
end

function AddNPC(station)
    local stationCfg = Stations[station]
    LoadModel(stationCfg.npc.model)
    stationCfg.NPC = CreatePed(stationCfg.npc.model, stationCfg.npc.coords.x, stationCfg.npc.coords.y, stationCfg.npc.coords.z - 1, stationCfg.npc.heading, false, false, false, false)
    Citizen.InvokeNative(0x283978A15512B2FE, stationCfg.NPC, true) -- SetRandomOutfitVariation
    SetEntityCanBeDamaged(stationCfg.NPC, false)
    SetEntityInvincible(stationCfg.NPC, true)
    Wait(500)
    FreezeEntityPosition(stationCfg.NPC, true)
    SetBlockingOfNonTemporaryEvents(stationCfg.NPC, true)
end

function LoadModel(model)
    local hash = joaat(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end
end

function ShowHUD(condition, maxCondition, fuel, maxFuel)
  SendNUIMessage({
    type = 'toggleHUD',
    HUDvisible = true,
    condition = condition,
    maxCondition = maxCondition,
    fuel = fuel,
    maxFuel = maxFuel
  })
end

function UpdateHUD(condition, fuel)
  SendNUIMessage({
    type = 'update',
    condition = condition,
    fuel = fuel
  })
end

function HideHUD()
  SendNUIMessage({
    type = 'toggleHUD',
    HUDvisible = false,
  })
end

function FuelUpdate(fuel)
    TrainFuel = fuel
    UpdateHUD(nil, fuel)
end

function ConditionUpdate(cond)
    TrainCondition = cond
    UpdateHUD(cond, nil)
end

function LoadTrainCars(trainHash)
    local cars = Citizen.InvokeNative(0x635423d55ca84fc8, trainHash) -- GetNumCarsFromTrainConfig
    for index = 0, cars - 1 do
        local model = Citizen.InvokeNative(0x8df5f6a19f99f0d5, trainHash, index) -- GetTrainModelFromTrainConfigByCarIndex
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(10)
        end
    end
end

function TrackSwitch(toggle)
    local trackModels = {
        { model = 'FREIGHT_GROUP' },
        { model = 'TRAINS3' },
        { model = 'BRAITHWAITES2_TRACK_CONFIG' },
        { model = 'TRAINS_OLD_WEST01' },
        { model = 'TRAINS_OLD_WEST03' },
        { model = 'TRAINS_NB1' },
        { model = 'TRAINS_INTERSECTION1_ANN' },
    }
    local counter = 0
    repeat
    for _, v in pairs(trackModels) do
        local trackHash = joaat(v.model)
        Citizen.InvokeNative(0xE6C5E2125EB210C1, trackHash, counter, toggle)
    end
    counter = counter + 1
    until counter >= 25
end

AddEventHandler('bcc-train:ResetTrain', function()
    if MyTrain then
        DeleteEntity(MyTrain)
        MyTrain = nil
    end
    HideHUD()
    if InMission then
        VORPcore.NotifyRightTip(_U('missionFailed'), 4000)
        InMission = false
    end
    VORPMenu.CloseAll()
    TargetPromptsStarted = false
    EngineStarted = false
    FuelTarget = nil
    RepairTarget = nil
    ForwardActive = false
    BackwardActive = false
    if DestinationBlip then
        RemoveBlip(DestinationBlip)
        DestinationBlip = nil
    end
    if DeliveryBlip then
        RemoveBlip(DeliveryBlip)
        DeliveryBlip = nil
    end
    TriggerServerEvent('bcc-train:UpdateTrainSpawnVar', false)
end)

-- Menu for Train Maintenance
AddEventHandler('bcc-train:TargetMenu', function(trainCfg)
    local playerPed = PlayerPedId()
    local player = PlayerId()
    while MyTrain do
        local sleep = 1000
        local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(MyTrain))
        if dist >= 6 or not Citizen.InvokeNative(0xEC5F66E459AF3BB2, playerPed, MyTrain) then -- IsPedOnSpecificVehicle
            Citizen.InvokeNative(0x05254BA0B44ADC16, MyTrain, false) -- SetVehicleCanBeTargetted
            goto continue
        end
        Citizen.InvokeNative(0x05254BA0B44ADC16, MyTrain, true) -- SetVehicleCanBeTargetted
        if Citizen.InvokeNative(0x27F89FDC16688A7A, player, MyTrain, 0) then -- IsPlayerTargettingEntity
            sleep = 0
            local trainGroup = Citizen.InvokeNative(0xB796970BD125FCE8, MyTrain) -- PromptGetGroupIdForTargetEntity
            TriggerEvent('bcc-train:TargetPrompts', trainGroup, trainCfg)

            if Citizen.InvokeNative(0x580417101DDB492F, 0, Config.keys.fuel) then -- IsControlJustPressed
                local fuel = VORPcore.Callback.TriggerAwait('bcc-train:FuelTrain', TrainId, TrainFuel, trainCfg)
                if fuel then
                    FuelUpdate(fuel)
                end

            elseif Citizen.InvokeNative(0x580417101DDB492F, 0, Config.keys.repair) then -- IsControlJustPressed
                local cond = VORPcore.Callback.TriggerAwait('bcc-train:RepairTrain', TrainId, TrainCondition, trainCfg)
                if cond then
                    ConditionUpdate(cond)
                end
            end
        end
        ::continue::
        Wait(sleep)
    end
end)

-- Prompts
AddEventHandler('bcc-train:TargetPrompts', function(trainGroup, trainCfg)

    if not TargetPromptsStarted then
        local fuelStr = CreateVarString(10, 'LITERAL_STRING', _U('addFuel'))
        FuelTarget = PromptRegisterBegin()
        PromptSetControlAction(FuelTarget, Config.keys.fuel)
        PromptSetText(FuelTarget, fuelStr)
        PromptSetEnabled(FuelTarget, true)
        PromptSetVisible(FuelTarget, true)
        PromptSetStandardMode(FuelTarget, true)
        PromptSetGroup(FuelTarget, trainGroup)
        PromptRegisterEnd(FuelTarget)

        local repairStr = CreateVarString(10, 'LITERAL_STRING', _U('repairTrain'))
        RepairTarget = PromptRegisterBegin()
        PromptSetControlAction(RepairTarget, Config.keys.repair)
        PromptSetText(RepairTarget, repairStr)
        PromptSetEnabled(RepairTarget, true)
        PromptSetVisible(RepairTarget, true)
        PromptSetStandardMode(RepairTarget, true)
        PromptSetGroup(RepairTarget, trainGroup)
        PromptRegisterEnd(RepairTarget)

        TargetPromptsStarted = true
    end

    if trainCfg.fuel.enabled then
        PromptSetVisible(FuelTarget, true)
    else
        PromptSetVisible(FuelTarget, false)
    end

    if trainCfg.condition.enabled then
        PromptSetVisible(RepairTarget, true)
    else
        PromptSetVisible(RepairTarget, false)
    end
end)

function StartMainPrompts()
    MenuPrompt = PromptRegisterBegin()
    PromptSetControlAction(MenuPrompt, Config.keys.station)
    PromptSetText(MenuPrompt, CreateVarString(10, 'LITERAL_STRING', _U('openMainMenu')))
    PromptSetVisible(MenuPrompt, true)
    PromptSetStandardMode(MenuPrompt, true)
    PromptSetGroup(MenuPrompt, MenuGroup)
    PromptRegisterEnd(MenuPrompt)

    BridgePrompt = PromptRegisterBegin()
    PromptSetControlAction(BridgePrompt, Config.keys.bridge)
    PromptSetText(BridgePrompt, CreateVarString(10, 'LITERAL_STRING', _U('blowUpBridge')))
    PromptSetEnabled(BridgePrompt, true)
    PromptSetVisible(BridgePrompt, true)
    Citizen.InvokeNative(0x74C7D7B72ED0D3CF, BridgePrompt, 'MEDIUM_TIMED_EVENT') -- PromptSetStandardizedHoldMode
    PromptSetGroup(BridgePrompt, BridgeGroup)
    PromptRegisterEnd(BridgePrompt)
end

function StartDeliveryPrompt()
    if not DeliveryPromptStarted then
        DeliveryPrompt = PromptRegisterBegin()
        PromptSetControlAction(DeliveryPrompt, Config.keys.delivery)
        PromptSetText(DeliveryPrompt, CreateVarString(10, 'LITERAL_STRING', _U('start')))
        PromptSetEnabled(DeliveryPrompt, true)
        PromptSetVisible(DeliveryPrompt, true)
        Citizen.InvokeNative(0x74C7D7B72ED0D3CF, DeliveryPrompt, 'MEDIUM_TIMED_EVENT') -- PromptSetStandardizedHoldMode
        PromptSetGroup(DeliveryPrompt, DeliveryGroup)
        PromptRegisterEnd(DeliveryPrompt)

        DeliveryPromptStarted = true
    end
end