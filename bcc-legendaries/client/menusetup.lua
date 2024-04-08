StopAll, Inmission = false, false
local level, subtractamoount, inmenu = 0, 0, false

----- Bspace to exit menu -----
AddEventHandler('bcc-legendaries:MenuClose', function()
    while inmenu do
        Wait(5)
        if IsControlJustReleased(0, 0x156F7119) then
            BCCLegendarieshMenu:Close()
            inmenu = false
        end
    end
end)

local huntlocation
AddEventHandler('bcc:legendaries:openmenu', function(location)
    huntlocation = location
    local requiredLevel = nil
    inmenu = true
    TriggerEvent('bcc-legendaries:MenuClose')
    BCCLegendarieshMenu:Close()
    local legendariesMainMenu = BCCLegendarieshMenu:RegisterPage("bcc-legendares:MainPage")
    legendariesMainMenu:RegisterElement('header', {
        value = _U('Menuname'),
        slot = 'header',
        style = {}
    })

    for k, items in pairs(Config.locations) do
        if items.location == huntlocation then
            requiredLevel = items.level
            if Config.LevelSystem then
                if items.level <= level then
                    Cost = items.hintcost - subtractamoount
                    legendariesMainMenu:RegisterElement("button", {
                        label = items.huntname .. ' ' .. Cost .. '$',
                        style = {}
                    }, function()
                        if Config.LevelSystem then
                            if items.level <= level then
                                Cost = items.hintcost - subtractamoount
                            end
                        else
                            Cost = items.hintcost
                        end
                        if not Inmission then
                            TriggerServerEvent('bcc:legendaries:menuopen5', Cost, items.huntname, items.CooldownTime)
                            Data = items
                        else
                            VORPcore.NotifyBottomRight(_U('AlreadyInMission'), 4000)
                        end
                    end)
                end
            else
                Cost = items.hintcost
                legendariesMainMenu:RegisterElement("button", {
                    label = items.huntname .. ' ' .. Cost .. '$',
                    style = {}
                }, function()
                    if Config.LevelSystem then
                        if items.level <= level then
                            Cost = items.hintcost - subtractamoount
                        end
                    else
                        Cost = items.hintcost
                    end
                    if not Inmission then
                        TriggerServerEvent('bcc:legendaries:menuopen5', Cost, items.huntname, items.CooldownTime)
                        Data = items
                    else
                        VORPcore.NotifyBottomRight(_U('AlreadyInMission'), 4000)
                    end
                end)
            end
        end
    end
    if requiredLevel > level then
        VORPcore.NotifyBottomRight(_U('Nolevel'), 6000)
    else
        BCCLegendarieshMenu:Open({
            startupPage = legendariesMainMenu
        })
    end
end)

---------- Event That Starts the hunt
RegisterNetEvent('bcc:legendaries:menuopen4', function()
    Inmission = true
    VORPcore.NotifyBottomRight(_U('Initialblipmark'), 2000)
    TriggerEvent('bcc-legendaries:DeadCheck')
    searchsetupmain('InitSearch', Data.investigationspot.x, Data.investigationspot.y, Data.investigationspot.z)
end)

---------------- Creates a thread(runs on start) to check if your near the coords an hit the g button -----------------------
CreateThread(function()
    while true do
        Wait(5)
        for k, v in pairs(Config.shop) do
            if GetDistanceBetweenCoords(v.Pos.x, v.Pos.y, v.Pos.z, GetEntityCoords(PlayerPedId()), false) < 2 then
                if IsControlJustReleased(0, 0x760A9C6F) then
                    if Config.LevelSystem then
                        TriggerServerEvent('bcc:legendaries:DBCheck', v.name)
                        Wait(200)
                    else
                        TriggerEvent('bcc:legendaries:openmenu', v.name)
                    end
                end
            end
        end
    end
end)

------------------------------------ Dead check Setup -------------------------------
AddEventHandler('bcc-legendaries:DeadCheck', function()
    while true do
        Wait(1000)
        if IsPedDeadOrDying(PlayerPedId()) then
            StopAll = true break
        end
    end
end)

-------------------------------- Detecting Level -----------------------------
RegisterNetEvent('bcc-legendaries:ClientLevelCatch', function(trust, name)
    level = trust
    Wait(100)
    for key, v in pairs(Config.Levels) do
        if level >= v.level and level < v.nextlevel then
            subtractamoount = v.costreduction break
        elseif level < v.level then break end
    end
    TriggerEvent('bcc:legendaries:openmenu', name)
end)

---- Cleanup ------
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    BCCLegendarieshMenu:Close()
end)