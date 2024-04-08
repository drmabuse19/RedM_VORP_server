local T = Translation.Langs[Config.Lang]

--[[######################Nui callbacks####################################]]
--this callback is for when the menu closes giving player control of mouse in game back
Inmission = false
RegisterNuiCallback('closemenu', function(data, cb)
    cb('ok')
    SetNuiFocus(false, false)
end)

--This callback is for purchasing an oil wagon
RegisterNuiCallback('BuyOilWagon', function(data, cb)
    cb('ok')
    if not Inmission then
        local type, action = 'oilwagon', 'buy'
        TriggerServerEvent('bcc:oil:WagonManagement', type, action)
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

--This callback is for selling an oil wagon
RegisterNuiCallback('SellOilWagon', function(data, cb)
    cb('ok')
    if not Inmission then
        local type, action = 'oilwagon', 'sell'
        TriggerServerEvent('bcc:oil:WagonManagement', type, action)
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

--this callback is for starting an oil delivery mission
RegisterNuiCallback('OilDeliveryMission', function(data, cb)
    cb('ok')
    if not Inmission then
        local type, action = 'oilwagon', 'spawn'
        TriggerServerEvent('bcc:oil:WagonManagement', type, action)
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

--this callback is for buying a supply wagon
RegisterNuiCallback('BuySupplyWagon', function(data, cb)
    cb('ok')
    if not Inmission then
        local type, action = 'supplywagon', 'buy'
        TriggerServerEvent('bcc:oil:WagonManagement', type, action)
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

--this callback is for selling a supply wagon
RegisterNuiCallback('SellSupplyWagon', function(data, cb)
    cb('ok')
    if not Inmission then
        local type, action = 'supplywagon', 'sell'
        TriggerServerEvent('bcc:oil:WagonManagement', type, action)
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

--this callback is for starting a supply delivery mission
RegisterNuiCallback('SupplyDelivery', function(data, cb)
    cb('ok')
    if not Inmission then
        local type, action = 'supplywagon', 'spawn'
        TriggerServerEvent('bcc:oil:WagonManagement', type, action)
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

-----------Criminal Callbacks--------
RegisterNuiCallback('RobOilWagon', function(data, cb)
    cb('ok')
    if not Inmission then
        TriggerServerEvent('bcc-oil:CrimCooldowns', 'wagonrob')
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)

RegisterNuiCallback('RobOilCompany', function(data, cb)
    cb('ok')
    if not Inmission then
        TriggerServerEvent('bcc-oil:CrimCooldowns', 'corob')
    else
        VORPcore.NotifyRightTip(T.AlreadyInMission, 4000)
    end
end)
