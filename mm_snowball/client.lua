local animDict = "mech_weapons_thrown@base"
local animName = "throw_m_fb_stand"
local snowballHash = GetHashKey("p_cs_snowball01x")

Citizen.CreateThread(function()
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(50)
    end

    RequestModel(snowballHash)
    while not HasModelLoaded(snowballHash) do
        Citizen.Wait(50)
    end
end)

function playThrowAnimation()
    local ped = PlayerPedId()
    TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 0, 0, false, false, false)
    Citizen.Wait(600) -- Adjust the timing as needed
    StopAnimTask(ped, animDict, animName, -4.0)
end

function spawnSnowballProjectile()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local snowball = CreateObject(snowballHash, pos.x, pos.y, pos.z + 0.5, true, true, true)
    local forwardVector = GetEntityForwardVector(playerPed)
    local velocity = forwardVector * 20.0 -- Adjust velocity as needed
    SetEntityVelocity(snowball, velocity.x, velocity.y, velocity.z)
end

RegisterCommand("snowball", function()
    playThrowAnimation()
    spawnSnowballProjectile()
end, false)
