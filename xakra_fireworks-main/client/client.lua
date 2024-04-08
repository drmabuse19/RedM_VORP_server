function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(5)
	end
end

-- BIG FIREWORKS
RegisterNetEvent('xakra_fireworks:big_fireworks')
AddEventHandler('xakra_fireworks:big_fireworks', function()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 7000, true, false, false, false)
    Wait(7000)

    local big_fireworks_object = CreateObject("p_wickerbox01x", GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0), true, true, false)
    PlaceObjectOnGroundProperly(big_fireworks_object)
    SetEntityHeading(big_fireworks_object, GetEntityHeading(PlayerPedId()))

    Wait(5000)
    TriggerServerEvent("xakra_fireworks:players", GetEntityCoords(big_fireworks_object), "big_fireworks")

    Wait(Config.big_fireworks_time * 1000 + 10000)
    DeleteObject(big_fireworks_object)
end)

RegisterNetEvent('xakra_fireworks:big_fireworks_players')
AddEventHandler('xakra_fireworks:big_fireworks_players', function(coords)
    RequestNamedPtfxAsset(GetHashKey('scr_ind1'))
    while not HasNamedPtfxAssetLoaded(GetHashKey('scr_ind1')) do
        Wait(10)
    end
    UseParticleFxAsset('scr_ind1')
    local fireworks = StartParticleFxLoopedAtCoord('scr_ind1_firework', coords, 0.0, 0.0, 0.0, 1.0, false, false, false, true) 

    local stop
    Citizen.CreateThread(function()
        Wait(Config.big_fireworks_time * 1000)
        stop = true
    end)

    while not stop do
        Citizen.InvokeNative(0x53BA259F3A67A99E, coords, 32, 0xF36AD9AC, 0.0, Config.EnableSound, false, true, 0.0)   -- AddExplosionWithUserVfx
        Wait(100)
        Citizen.InvokeNative(0x53BA259F3A67A99E, coords.x, coords.y, coords.z + 60, 25, 0xF36AD9AC, 0.0, Config.EnableSound, true, true, 0.0)   -- AddExplosionWithUserVfx

        Wait(math.random(100,800))
    end

    StopParticleFxLooped(fireworks, true)

    Wait(500)
    Citizen.InvokeNative(0x53BA259F3A67A99E, coords, 32, 0xF36AD9AC, 0.0, Config.EnableSound, false, true, 0.0)   -- AddExplosionWithUserVfx
    Wait(100)
    Citizen.InvokeNative(0x53BA259F3A67A99E, coords.x, coords.y, coords.z + 60, 25, 0xF36AD9AC, 0.0, Config.EnableSound, true, true, 0.0)   -- AddExplosionWithUserVfx
end)

-- SMALL FIREWORKS
RegisterNetEvent('xakra_fireworks:small_fireworks')
AddEventHandler('xakra_fireworks:small_fireworks', function()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 7000, true, false, false, false)
    Wait(7000)

    local small_fireworks_object = CreateObject("p_wickerbox01x", GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0), true, true, false)
    PlaceObjectOnGroundProperly(small_fireworks_object)
    SetEntityHeading(small_fireworks_object, GetEntityHeading(PlayerPedId()))

    Wait(5000)
    TriggerServerEvent("xakra_fireworks:players", GetEntityCoords(small_fireworks_object), "small_fireworks")

    Wait(Config.small_fireworks_time * 1000 + 10000)
    DeleteObject(small_fireworks_object)
end)

RegisterNetEvent('xakra_fireworks:small_fireworks_players')
AddEventHandler('xakra_fireworks:small_fireworks_players', function(coords)
    RequestNamedPtfxAsset(GetHashKey('anm_ind'))
    while not HasNamedPtfxAssetLoaded(GetHashKey('anm_ind')) do
        Wait(10)
    end
    UseParticleFxAsset('anm_ind')
    local fireworks = StartParticleFxLoopedAtCoord('ent_anim_ind_firework', coords, 0.0, 0.0, 0.0, 0.20, false, false, false, true) 

    local stop
    Citizen.CreateThread(function()
        Wait(Config.small_fireworks_time * 1000)
        stop = true
    end)

    while not stop do
        Citizen.InvokeNative(0x53BA259F3A67A99E, coords, 32, 0xF36AD9AC, 0.0, Config.EnableSound, false, true, 0.0)    -- AddExplosionWithUserVfx
        Wait(100)
        Citizen.InvokeNative(0x53BA259F3A67A99E, coords.x, coords.y, coords.z + 10, 12, 0xF36AD9AC, 0.0, Config.EnableSound, true, true, 0.0)  -- AddExplosionWithUserVfxn
        Wait(math.random(100,800))
    end

    StopParticleFxLooped(fireworks, true)

    Wait(500)
    Citizen.InvokeNative(0x53BA259F3A67A99E, coords, 32, 0xF36AD9AC, 0.0, Config.EnableSound, false, true, 0.0)    -- AddExplosionWithUserVfx
    Wait(100)
    Citizen.InvokeNative(0x53BA259F3A67A99E, coords.x, coords.y, coords.z + 10, 12, 0xF36AD9AC, 0.0, Config.EnableSound, true, true, 0.0)  -- AddExplosionWithUserVfx
end)

-- BIG FIRECRACKER
RegisterNetEvent('xakra_fireworks:big_firecracker')
AddEventHandler('xakra_fireworks:big_firecracker', function()
    local animDict = "amb_camp@world_camp_jack_throws_rocks_casual@male_a@wip_base"
    local animName = "base"
    local duration = 6500
    local flags = 2
    loadAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 3.0, duration, flags, 0, 0, 0, 0)
    
    local big_firecracker_object = CreateObject(GetHashKey("w_throw_dynamite01"), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "IK_R_Hand")
    AttachEntityToEntity(big_firecracker_object, PlayerPedId(), righthand, 0.06, 0.0, -0.05, -90.0, 0.0, -45.0, true, true, false, true, 1, true)

    Wait(4500)
    DeleteObject(big_firecracker_object)
    Wait(1500)

    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 15.0, 0.0)
    local _, z = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z + 100)
    TriggerServerEvent("xakra_fireworks:players", vector3(coords.x, coords.y, z), "big_firecracker")
end)

RegisterNetEvent('xakra_fireworks:big_firecracker_players')
AddEventHandler('xakra_fireworks:big_firecracker_players', function(coords)
    Citizen.InvokeNative(0x53BA259F3A67A99E, coords, 31, 0xC22E127D, 0.0, true, false, true, 0.0)   -- AddExplosionWithUserVfx
end)

-- SMALL FIRECRACKER
RegisterNetEvent('xakra_fireworks:small_firecracker')
AddEventHandler('xakra_fireworks:small_firecracker', function()
    local animDict = "amb_camp@world_camp_jack_throws_rocks_casual@male_a@wip_base"
    local animName = "base"
    local duration = 6500
    local flags = 2
    loadAnimDict(animDict) -- Función para cargar animación.
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 3.0, duration, flags, 0, 0, 0, 0)

    local small_firecracker_object = CreateObject(GetHashKey("mp001_p_mp_dynamite01x_noexp"), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "IK_R_Hand")
    AttachEntityToEntity(small_firecracker_object, PlayerPedId(), righthand, 0.09, 0.0, -0.04, -90.0, 0.0, -43.0, true, true, false, true, 1, true)

    Wait(4500) -- Espera para animaciones.
    DeleteObject(small_firecracker_object)
    Wait(1500) -- Espera para animaciones.

    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 15.0, 0.0)
    local _, z = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z + 100)
    TriggerServerEvent("xakra_fireworks:players", vector3(coords.x, coords.y, z), "small_firecracker")
end)

RegisterNetEvent('xakra_fireworks:small_firecracker_players')
AddEventHandler('xakra_fireworks:small_firecracker_players', function(coords)
    for i = 1, 3 do
        Citizen.InvokeNative(0x53BA259F3A67A99E, coords, 12, 0x2FDA2B4A, 0.0, true, false, true, 0.0)  -- AddExplosionWithUserVfx
        Wait(300)
    end
end)

-- SMOKE CAMPFIRE
RegisterNetEvent('xakra_fireworks:smoke_campfire')
AddEventHandler('xakra_fireworks:smoke_campfire', function()
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)

    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 12000, true, false, false, false)
    Wait(12000)

    local smoke_campfire_object = CreateObject("p_campfire01x", coords, true, true, false)
    PlaceObjectOnGroundProperly(smoke_campfire_object)
    SetEntityHeading(smoke_campfire_object, GetEntityHeading(PlayerPedId()))

    TriggerServerEvent("xakra_fireworks:players", GetEntityCoords(smoke_campfire_object), "smoke_campfire")

    Wait(Config.smoke_campfire_time * 1000 + 10000)
    DeleteObject(smoke_campfire_object)
end)

RegisterNetEvent('xakra_fireworks:smoke_campfire_players')
AddEventHandler('xakra_fireworks:smoke_campfire_players', function(coords)
    RequestNamedPtfxAsset(GetHashKey('SCR_ADV_SOK'))
    while not HasNamedPtfxAssetLoaded(GetHashKey('SCR_ADV_SOK')) do
        Wait(10)
    end

    UseParticleFxAsset("SCR_ADV_SOK")
    local smoke = StartParticleFxLoopedAtCoord("scr_adv_sok_torchsmoke", coords.x, coords.y, coords.z - 6.22, 0.0,0.0,0.0, 8.0, false, false, false, true)
    
    Wait(Config.smoke_campfire_time * 1000)
    StopParticleFxLooped(smoke, true)
end)