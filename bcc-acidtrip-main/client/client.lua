--This will be called if the chance determines only to give you the high screen effect
RegisterNetEvent('bcc-acidtrip:ScreenEffectOnly', function(effectTime)
    AnimpostfxPlay('MP_BountyLagrasSwamp')
    Wait(effectTime)
    AnimpostfxStopAll()
end)

--This will instance the player, teleport them to the set coords, and play the high anims
RegisterNetEvent('bcc-acidtrip:Open', function()
    VORPcore.instancePlayers(tonumber(GetPlayerServerId(PlayerId()))+ 575132)
    SetEntityCoords(PlayerPedId(), Config.PlayerWakeUpCoords.x, Config.PlayerWakeUpCoords.y, Config.PlayerWakeUpCoords.z)
    AnimpostfxPlay('PlayerWakeUpKnockout')
    exports.weathersync:setMyTime(0, 0, 0, 0, 0, 1) --sets the time to midnight and freezes the time(this can be done and only effect the one player as the player has been instanced!)
    Wait(7000)
    AnimpostfxStop('PlayerWakeUpKnockout')
    AnimpostfxPlay('MP_BountyLagrasSwamp')
    TriggerEvent('bcc-acidtrip:Wave1')
end)

------Enemy Npc Waves setup!-------
AddEventHandler('bcc-acidtrip:Wave1', function()
    local model = joaat('re_fleeingfamily_males_01')
    PedTableAllDead(Config.PedSpawnCoordsWave1, model, 'bcc-acidtrip:Wave2')
end)

AddEventHandler('bcc-acidtrip:Wave2', function(model)
    PedTableAllDead(Config.PedSpawnCoordsWave2, model, 'bcc-acidtrip:Wave3')
end)

--Wave3
AddEventHandler('bcc-acidtrip:Wave3', function(model)
    PedTableAllDead(Config.PedSpawnCoordsWave2, model, 'bcc-acidtrip:TurnIntoAnimal')
end)

-----This is what will happen when the waves are defeated------
AddEventHandler('bcc-acidtrip:TurnIntoAnimal', function()
    AnimpostfxPlay('MP_NATURALISTANIMALTRANSFORMSTART')
    TaskStartScenarioInPlace(PlayerPedId(), joaat("WORLD_HUMAN_DRUNK_PASSED_OUT_FLOOR"), 7000, true, false, false, false)
    Wait(5000)
    AnimpostfxStop('MP_NATURALISTANIMALTRANSFORMSTART')
    ClearPedTasksImmediately(PlayerPedId())
    PlayerPedchange(false, Config.AnimalTransformationModel, Config.TimeAsAnimal, 'bcc-acidtrip:TurnIntoAnimalSpam', Config.SmokeExplosionDuringPedChange)
end)

--This will happen after the initial animal transformation event is over
AddEventHandler('bcc-acidtrip:TurnIntoAnimalSpam', function()
    PlayerPedchange(true, Config.AnimalTransformationModel, 1000, 'bcc-acidtrip:WakeUp/End', Config.SmokeExplosionDuringPedChange)
end)

--This function will handle waking the player up
AddEventHandler('bcc-acidtrip:WakeUp/End', function()
    AnimpostfxPlay('skytl_0300_04storm')
    Wait(6000)
    AnimpostfxStopAll()
    VORPcore.instancePlayers(0)
    local wakeUpCoords = Config.WakeUpLocations[math.random(1, #Config.WakeUpLocations)]
    SetEntityCoords(PlayerPedId(), wakeUpCoords.x, wakeUpCoords.y, wakeUpCoords.z)
    AnimpostfxPlay('PlayerWakeUpDrunk')
    Wait(1000)
    exports.weathersync:setSyncEnabled(true) --this will sync the time of day, and weather to the instance with all the players (only run this after players leaves instance)
    Wait(15000)
    AnimpostfxStopAll()
end)