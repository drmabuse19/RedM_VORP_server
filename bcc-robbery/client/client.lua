--Variables
Inmission = false
local robberyenable = false


----- Registering Command To enable and disable robberies ----
RegisterCommand(Config.RobberyCommand, function()
    TriggerServerEvent('bcc-robbery:JobCheck')
end)

--Event the serv will trigger if the player is not a restricted job
RegisterNetEvent('bcc-robbery:RobberyEnabler', function()
    if not robberyenable then
        robberyenable = true
        VORPcore.NotifyRightTip(_U('RobberyEnable'), 4000)
    else
        robberyenable = false
        VORPcore.NotifyRightTip(_U('RobberyDisable'), 4000)
    end
end)

----- Thread to trigger the events -----
CreateThread(function()
    for k, v in pairs(Config.Robberies) do
        TriggerEvent('bcc-robbery:MainHandler', v)
    end
end)

------ Main Event Handler Triggers the robberies ------
AddEventHandler('bcc-robbery:MainHandler', function(v)
    while true do
        Wait(200)
        if robberyenable then
            local plc = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(v.StartingCoords.x, v.StartingCoords.y, v.StartingCoords.z, plc.x, plc.y, plc.z) < 5 then
                while true do
                    Wait(5)
                    if GetDistanceBetweenCoords(v.StartingCoords.x, v.StartingCoords.y, v.StartingCoords.z, plc.x, plc.y, plc.z) > 5 then break end
                    if not Inmission then
                        if IsPedShooting(PlayerPedId()) then
                            TriggerServerEvent('bcc-robbery:ServerCooldownCheck', v.Id, v)
                            Wait(5000) break
                        end
                    end
                end
            end
        end
    end
end)

---------- Robbery Setup -----------
RegisterNetEvent('bcc-robbery:RobberyHandler', function(v)
    Inmission = true
    TriggerEvent('bcc-robbery:DeadCheck', v.StartingCoords)
    VORPcore.NotifyRightTip(_U('RobberyStart'), 4000)

    if v.EnemyNpcs then
        TriggerEvent('bcc-robbery:EnemyPeds', v.EnemyNpcCoords)
    end

    local waittimer = v.WaitBeforeLoot
    while true do
        Wait(10)
        local pl = GetEntityCoords(PlayerPedId())

        if PlayerDead then break end

        waittimer = waittimer - 20
        local roundedtimer = waittimer / 60000
        local rounded2 = (math.floor(roundedtimer * 100) / 100)

        BccUtils.Misc.DrawText3D(pl.x, pl.y, pl.z, _U('HoldOutBeforeLooting') .. ' ' .. tostring(rounded2) .. ' ' .. _U('HoldOutBeforeLooting2'))
        if waittimer <= 0 then
            VORPcore.NotifyRightTip(_U('LootMarked'), 4000) break
        end
    end

    if PlayerDead then
        Inmission = false
        VORPcore.NotifyRightTip(_U('RobberyFail'), 4000)
        Wait(5000)
        PlayerDead = false return
    end


    for k, e in pairs(v.LootLocations) do
        TriggerEvent('bcc-robbery:LootHandler', e)
    end
end)

---------- Loot Locations Setup ---------
AddEventHandler('bcc-robbery:LootHandler', function(e)
    math.randomseed(GetGameTimer()) --Create a new seed for math.random

    local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --registers a prompt group using vorp_utils
    local firstprompt = PromptGroup:RegisterPrompt(_U('Rob'), 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
    local cfg = {
        focus = true, -- Should minigame take nui focus
        cursor = true, -- Should minigame have cursor  (required for lockpick)
        maxattempts = Config.LockPick.MaxAttemptsPerLock, -- How many fail attempts are allowed before game over
        threshold = Config.LockPick.difficulty, -- +- threshold to the stage degree (bigger number means easier)
        hintdelay = Config.LockPick.hintdelay, --milliseconds delay on when the circle will shake to show lockpick is in the right position.
        stages = Config.LockPick.pins
    }

    if Config.LockPick.randomPins == true then
        cfg.stages = {
            {
                deg = math.random(0, 360) -- 0-360 degrees
            },
            {
                deg = math.random(0, 360) -- 0-360 degrees
            },
            {
                deg = math.random(0, 360) -- 0-360 degrees
            }
        }
    end

    while true do
        Wait(5)
        if PlayerDead then break end


        local plc = GetEntityCoords(PlayerPedId())
        
        local dist = GetDistanceBetweenCoords(plc.x, plc.y, plc.z, e.LootCoordinates.x, e.LootCoordinates.y, e.LootCoordinates.z, true)
        if dist < 6 then
            BccUtils.Misc.DrawText3D(e.LootCoordinates.x, e.LootCoordinates.y, e.LootCoordinates.z, _U('Robbery'))
        end
        if dist < 2 then
            PromptGroup:ShowGroup(_U('Robbery'))
            if firstprompt:HasCompleted() then

                MiniGame.Start('lockpick', cfg, function(result)
                    if result.unlocked then
                        if e.CashReward > 0 then
                            TriggerServerEvent('bcc-robbery:CashPayout', e.CashReward)
                        end
                        TriggerServerEvent('bcc-robbery:ItemsPayout', e)
                        Inmission = false
                    else
                        VORPcore.NotifyRightTip(_U('PickFailed'), 4000)
                        Inmission = false
                    end
                end) break
            end
        end
    end
end)