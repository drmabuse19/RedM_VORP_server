local blips = {}
local currentPlayers = {}
local appready = false
local received = false

function clear_blips()
    for k, _ in pairs(blips) do                    -- Loop through current map blips
        if currentPlayers[tostring(k)] == nil then -- Check if the key still exists in current users
            RemoveBlip(blips[tostring(k)])         -- Clear Map Blip
            blips[tostring(k)] = nil               -- Set Value to Nil
        end
    end
end

function GetPlayers()
    received = false                                 -- reset to ensure the check is done each time getplayers is called
    TriggerServerEvent("bcc-playerblips:GetPlayers") -- Ask the server for the players list

    while received == false do                       -- Ensure that the server has responded
        Citizen.Wait(5)
    end
end

RegisterNetEvent("bcc-playerblips:SendPlayers", function(result)
    currentPlayers = result
    received = true
end)

-- User Fetch Thread
Citizen.CreateThread(function()
    while true do
        if Config.Enable then
            GetPlayers()                                      -- Get list of players

            if currentPlayers["1"] and appready == false then --Check to make sure at least one player is in the list before starting the blip thread
                appready = true                               --Let the blip thread know it can now start
            end
        end

        Citizen.Wait(Config.PlayersRefreshTime)
    end
end)

-- Blip Thread
Citizen.CreateThread(function()
    while true do
        if Config.Enable and appready then
            -- Get all players
            local id = GetPlayerServerId(PlayerId())                                        -- Get Server ID of Client
            for _, player in pairs(currentPlayers) do
                if tostring(id) ~= player.serverId then                                     -- Don't create blips for the current user
                    if blips[player.serverId] then                                          -- Check if blip already exists
                        SetBlipCoords(blips[player.serverId], player.x, player.y, player.z) -- Move it to new coords
                    else                                                                    --Create Blip if one doesn't
                        -- Get Style Hash
                        local blip_style = GetHashKey("BLIP_STYLE_TEAM_WAYPOINT")

                        -- BLIP_ADD_FOR_COORDS
                        local blip = Citizen.InvokeNative(0x554D9D53F696D002, blip_style, player.x, player.y, player.z)
                        -- Set Sprite
                        Citizen.InvokeNative(0x74F74D3207ED525C, blip, -1025216818, true)
                        -- Set Scale (Not working)
                        Citizen.InvokeNative(0xD38744167B2FA257, blip, 0.01)
                        -- Set Blip Name from Player String
                        Citizen.InvokeNative(0x9CB1A1623062F402, blip, player.PlayerName)
                        -- Store a table of blips to delete on next update
                        blips[player.serverId] = blip
                        -- table.insert(blips, { player = blip })
                    end
                end
            end
            -- Clean up old blips
            if next(blips) ~= nil then
                clear_blips()
            end
        end
        Citizen.Wait(Config.WaitTime)
    end
end)
