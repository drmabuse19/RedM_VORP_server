local switched = false

function MainMenu(station)
    VORPMenu.CloseAll()
    DisplayRadar(false)
    local elements = {
        { label = _U('ownedTrains'),     value = 'owned',     desc = _U('ownedTrains_desc') },
        { label = _U('buyTrains'),       value = 'buy',       desc = _U('buyTrains_desc') },
        { label = _U('sellTrains'),       value = 'sell',       desc = _U('sellTrains_desc') },
        { label = _U('deliveryMission'), value = 'deliveryMission', desc = _U('deliveryMission_desc') }
    }
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = Stations[station].shop.name,
        subtext = '',
        align = 'top-left',
        elements = elements,
        itemHeight = '3.0vh',
        lastmenu = '',
    },function(data, menu)
        if data.current == 'backup' then
            return _G[data.trigger]()
        end
        if data.current.value == 'owned' then
            local myTrains = VORPcore.Callback.TriggerAwait('bcc-train:GetMyTrains')
            if #myTrains <= 0 then
                VORPcore.NotifyRightTip(_U('noOwnedTrains'), 4000)
            else
                OwnedMenu(myTrains, station)
            end

        elseif data.current.value == 'buy' then
            local myTrains = VORPcore.Callback.TriggerAwait('bcc-train:GetMyTrains')
            local maxTrains = Config.maxTrains
            if #myTrains >= maxTrains then
                VORPcore.NotifyRightTip(_U('trainLimit') .. maxTrains .. _U('trains'), 4000)
            else
                BuyMenu(myTrains, station)
            end

        elseif data.current.value == 'sell' then
            local myTrains = VORPcore.Callback.TriggerAwait('bcc-train:GetMyTrains')
            if #myTrains <= 0 then
                VORPcore.NotifyRightTip(_U('noOwnedTrains'), 4000)
            else
                SellMenu(myTrains, station)
            end

        elseif data.current.value == 'deliveryMission' then
            if not MyTrain then
                VORPcore.NotifyRightTip(_U('noTrain'), 4000)
                return
            end
            if InMission then
                VORPcore.NotifyRightTip(_U('inMission'), 4000)
                return
            end
            local onCooldown = VORPcore.Callback.TriggerAwait('bcc-train:CheckPlayerCooldown', 'delivery')
            if onCooldown then
                VORPcore.NotifyRightTip(_U('cooldown'), 4000)
                return
            end
            InMission = true
            menu.close()
            DisplayRadar(true)
            DeliveryMission(station)
        end
    end,
    function(data, menu)
        menu.close()
        DisplayRadar(true)
    end)
end

function BuyMenu(myTrains, station)
    VORPMenu.CloseAll()
    local elements = {}
    if #myTrains <= 0 then
        for train, trainCfg in pairs(Trains) do
            elements[#elements + 1] = {
                label = trainCfg.label,
                value = train,
                desc = _U('price') .. trainCfg.price .. '<br>' .. '<br>' .. _U('maxSpeed') .. trainCfg.maxSpeed,
                info = trainCfg
            }
        end
    else
        for train, trainCfg in pairs(Trains) do
            local insert = true
            for _, myTrainData in pairs(myTrains) do
                if trainCfg.model == myTrainData.trainModel then
                    insert = false
                end
            end
            if insert then
                elements[#elements + 1] = {
                    label = trainCfg.label,
                    value = train,
                    desc = _U('price') .. trainCfg.price .. '<br>' .. '<br>' .. _U('maxSpeed') .. trainCfg.maxSpeed,
                    info = trainCfg
                }
            end
        end
        if #elements <= 0 then
            elements = {
                { label = _U('ownAllTrains'),     value = 'noBuy',     desc = '' }
            }
        end
    end
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = Stations[station].shop.name,
        subtext = _U('purchase'),
        align = 'top-left',
        elements = elements,
        itemHeight = '3vh',
        lastmenu = 'MainMenu',
    },function(data, menu)
        if data.current == 'backup' then
            return _G[data.trigger](station)
        end
        if data.current.value ~= 'noBuy' then
            TriggerServerEvent('bcc-train:BuyTrain', data.current.info)
            MainMenu(station)
        else
            MainMenu(station)
        end
    end,
    function(data, menu)
        menu.close()
        DisplayRadar(true)
    end)
end

function OwnedMenu(myTrains, station)
    VORPMenu.CloseAll()
    local elements = {}
    for _, trainCfg in pairs(Trains) do
        for myTrain, myTrainData in pairs(myTrains) do
            if myTrainData.trainModel == trainCfg.model then
                elements[#elements + 1] = {
                    label = trainCfg.label,
                    value = myTrain,
                    desc  = _U('maxSpeed') .. trainCfg.maxSpeed,
                    info  = myTrainData
                }
            end
        end
    end
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = Stations[station].shop.name,
        subtext = _U('selectTrain'),
        align = 'top-left',
        elements = elements,
        itemHeight = '3vh',
        lastmenu = 'MainMenu',
    },
    function(data, menu)
        if data.current == 'backup' then
            return _G[data.trigger](station)
        end
        if data.current.value then
            local canSpawn = VORPcore.Callback.TriggerAwait('bcc-train:CheckTrainSpawn')
            if canSpawn then
                menu.close() --have to be called above funct
                local trainData = nil
                for _, trainCfg in pairs(Trains) do
                    if data.current.info.trainModel == trainCfg.model then
                        trainData = trainCfg
                        break
                    end
                end
                DirectionMenu(trainData, data.current.info, station, myTrains)
            else
                VORPcore.NotifyRightTip(_U('trainSpawnedAlrady'), 4000)
            end
        end
    end,
    function(data, menu)
        menu.close()
        DisplayRadar(true)
    end)
end

function SellMenu(myTrains, station)
    VORPMenu.CloseAll()
    local elements = {}
    for _, trainCfg in pairs(Trains) do
        for myTrain, myTrainData in pairs(myTrains) do
            if myTrainData.trainModel == trainCfg.model then
                elements[#elements + 1] = {
                    label = trainCfg.label,
                    value = myTrain,
                    desc  = _U('sellPrice') .. math.floor(trainCfg.price * Config.sellPrice),
                    info  = myTrainData
                }
            end
        end
    end
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = Stations[station].shop.name,
        subtext = _U('sellTrains_sub'),
        align = 'top-left',
        elements = elements,
        itemHeight = '3vh',
        lastmenu = 'MainMenu',
    },
    function(data, menu)
        if data.current == 'backup' then
            return _G[data.trigger](station)
        end
        if data.current.value then
            local sold = VORPcore.Callback.TriggerAwait('bcc-train:SellTrain', data.current.info)
            if sold then
                MainMenu(station)
            end
        end
    end,
    function(data, menu)
        menu.close()
        DisplayRadar(true)
    end)
end

function DirectionMenu(trainCfg, myTrainData, station, myTrains)
    VORPMenu.CloseAll()
    local elements = {
        { label = _U('changeSpawnDir'),   value = 'reverse',   desc = _U('changeSpawnDir_desc') },
        { label = _U('noChangeSpawnDir'), value = 'noChange', desc = _U('noChangeSpawnDir_desc') }
    }
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title      = Stations[station].shop.name,
        subtext    = '',
        align      = 'top-left',
        elements   = elements,
        itemHeight = '3vh',
        lastmenu   = 'OwnedMenu'
    },
    function(data, menu)
        if data.current == 'backup' then
            return _G[data.trigger](myTrains, station)
        end
        if data.current.value == 'reverse' then
            menu.close()
            DisplayRadar(true)
            SpawnTrain(trainCfg, myTrainData, true, station)
        else
            menu.close()
            DisplayRadar(true)
            SpawnTrain(trainCfg, myTrainData, false, station)
        end
    end,
    function(data, menu)
        menu.close()
        DisplayRadar(true)
    end)
end

function DrivingMenu(trainCfg, myTrainData)
    VORPMenu.CloseAll()
    local speed = 0
    local elements = {
        {
            label = _U('speed'),
            value = speed,
            desc = '',
            type = 'slider',
            min = 0,
            max = trainCfg.maxSpeed,
            hop = 1
        },
        { label = _U('switchTrack'),  value = 'switchtrack', desc = '' },
    }
    if Config.cruiseControl then
        table.insert(elements, { label = _U('forward'), value = 'forward', desc = '' })
        table.insert(elements, { label = _U('backward'), value = 'backward', desc = '' })
    end
    if EngineStarted then
        table.insert(elements, { label = _U('stopEngine'),   value = 'stopEngine',  desc = '' })
    else
        table.insert(elements, { label = _U('startEngine'),  value = 'startEngine', desc = '' })
    end

    table.insert(elements, { label = _U('deleteTrain'), value = 'deleteTrain', desc = '' }) --done here to ensure this is at the bottom of menu

    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title      = _U('drivingMenu'),
        subtext    = '',
        align      = 'top-left',
        elements   = elements,
        itemHeight = '3vh',
        lastmenu   = ''
    },
    function(data)
        if data.current == 'backup' then
            return _G[data.trigger]()
        end
        local selectedOption = {
            ['forward'] = function()
                if not EngineStarted then
                    VORPcore.NotifyRightTip(_U('engineMustBeStarted'), 4000)
                    ForwardActive = false
                    return
                end
                if BackwardActive then
                    VORPcore.NotifyRightTip(_U('backwardsIsOn'), 4000)
                    return
                end
                if ForwardActive then
                    VORPcore.NotifyRightTip(_U('forwardDisbaled'), 4000)
                    ForwardActive = false
                    return
                end
                if TrainFuel <= 0 then
                    VORPcore.NotifyRightTip(_U('noCruiseNoFuel'), 4000)
                    ForwardActive = false
                    return
                end
                ForwardActive = true
                VORPcore.NotifyRightTip(_U('forwardEnabled'), 4000)
                while ForwardActive do
                    Wait(100)
                    local distance = #(GetEntityCoords(MyTrain) - vector3(517.56, 1757.27, 188.34)) -- Bacchus Bridge
                    if distance <= 1000 then
                        VORPcore.NotifyRightTip(_U('cruiseDisabledInRegion'), 4000)
                        ForwardActive = false
                        break
                    end
                    if speed >= 1 then
                        Citizen.InvokeNative(0xDFBA6BBFF7CCAFBB, MyTrain, speed + 0.1) -- SetTrainSpeed
                    end
                end
            end,
            ['backward'] = function()
                if not EngineStarted then
                    VORPcore.NotifyRightTip(_U('engineMustBeStarted'), 4000)
                    BackwardActive = false
                    return
                end
                if ForwardActive then
                    VORPcore.NotifyRightTip(_U('forwardsIsOn'), 4000)
                    return
                end
                if BackwardActive then
                    VORPcore.NotifyRightTip(_U('backwardDisabled'), 4000)
                    BackwardActive = false
                    return
                end
                if TrainFuel <= 0 then
                    VORPcore.NotifyRightTip(_U('noCruiseNoFuel'), 4000)
                    BackwardActive = false
                    return
                end
                BackwardActive = true
                VORPcore.NotifyRightTip(_U('backwardEnabled'), 4000)
                while BackwardActive do
                    Wait(100)
                    local distance = #(GetEntityCoords(MyTrain) - vector3(517.56, 1757.27, 188.34)) -- Bacchus Bridge
                    if distance <= 1000 then
                        VORPcore.NotifyRightTip(_U('cruiseDisabledInRegion'), 4000)
                        BackwardActive = false
                        break
                    end
                    if speed >= 1 then
                        Citizen.InvokeNative(0xDFBA6BBFF7CCAFBB, MyTrain, (speed + 0.1) - ((speed + 0.1) * 2)) -- SetTrainSpeed
                    end
                end
            end,
            ['switchtrack'] = function()
                if not switched then
                    TrackSwitch(true)
                    switched = true
                    VORPcore.NotifyRightTip(_U('switchingOn'), 4000)
                else
                    TrackSwitch(false)
                    switched = false
                    VORPcore.NotifyRightTip(_U('switchingOn'), 4000)
                end
            end,
            ['stopEngine'] = function()
                VORPcore.NotifyRightTip(_U('engineStopped'), 4000)
                EngineStarted = false
                DrivingMenu(trainCfg, myTrainData)
                Citizen.InvokeNative(0x9F29999DFDF2AEB8, MyTrain, 0.0) -- SetTrainMaxSpeed
            end,
            ['startEngine'] = function()
                if TrainFuel >= 1 and TrainCondition >=1 then
                    VORPcore.NotifyRightTip(_U('engineStarted'), 4000)
                    EngineStarted = true
                    DrivingMenu(trainCfg, myTrainData)
                    MaxSpeedCalc(speed)
                else
                    VORPcore.NotifyRightTip(_U('checkTrain'), 4000)
                end
            end,
            ['deleteTrain'] = function()
                TriggerEvent('bcc-train:ResetTrain')
                HideHUD()
            end
        }
        if selectedOption[data.current.value] then
            selectedOption[data.current.value]()
        else --has to be done this way to get a vector menu option
            speed = data.current.value
            MaxSpeedCalc(speed)
        end
    end)
end

function MaxSpeedCalc(speed)
    local setMaxSpeed = speed + 0.1
    if setMaxSpeed >= 30.0 then
        setMaxSpeed = 29.9
    end
    Citizen.InvokeNative(0x9F29999DFDF2AEB8, MyTrain, setMaxSpeed) -- SetTrainMaxSpeed
end
