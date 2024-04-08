local jailed = false
local jail_time

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    TriggerServerEvent("poke_adminjail:check_jail")
end)

RegisterNetEvent("poke_adminjail:request")
AddEventHandler("poke_adminjail:request", function(target_id, time)
    TriggerServerEvent("poke_adminjail:jail", target_id, time)
end)

RegisterNetEvent("poke_adminjail:jail_player")
AddEventHandler("poke_adminjail:jail_player", function(time)
    local ped = PlayerPedId()
    local time_minutes = math.floor(time/60)

    for k, v in pairs(Config.Jails) do
        if not jailed then
            SetEntityCoords(ped, v.x, v.y, v.z)
            FreezeEntityPosition(ped, true)
            jail_time = time
            jailed = true
            TriggerEvent("vorp:Tip", _U('jailed_player', time_minutes), 5000)
            Citizen.Wait(1000)
            FreezeEntityPosition(ped, false)
        end
    end
end)

RegisterNetEvent("poke_adminjail:unjail_player")
AddEventHandler("poke_adminjail:unjail_player", function()
    local local_ped = PlayerPedId()
    local local_player = PlayerId()

    TriggerEvent("vorp:Tip", _U('released_player'), 5000)
    jailed = false
    jail_time = nil
    SetEntityCoords(local_ped, Config.ExitFromJail.x, Config.ExitFromJail.y, Config.ExitFromJail.z)
    SetPlayerInvincible(local_player, false)
end)

Citizen.CreateThread(function ()
    while true do
        if jailed then
            DrawTxt(_U('on_prison', jail_time), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
        else
            Citizen.Wait(500)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if jailed then
            local ped = PlayerPedId()
            local local_player = PlayerId()
            local player_coords = GetEntityCoords(ped, true)

            for k,v in pairs(Config.Jails) do
                if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxJailDistance then
                    SetEntityCoords(ped, v.x, v.y, v.z)
                    FreezeEntityPosition(ped, true)
                    Citizen.Wait(1000)
                    FreezeEntityPosition(ped, false)
                    if Config.IncreaseSentence then
                        local player_server_id = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('poke_adminjail:increasetime', player_server_id, jail_time, Config.IncreaseTime*60)
                        jail_time = jail_time + Config.IncreaseTime*60
                    end
                end
            end

            if not GetPlayerInvincible(local_player) then
                SetPlayerInvincible(local_player, true)
            end
            
            if jail_time ~= nil then
                if jail_time <= 0 then
                    local player_server_id = GetPlayerServerId(PlayerId())
                    TriggerServerEvent("poke_adminjail:unjail", player_server_id)
                else
                    jail_time = jail_time - 1
                end
            end
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end