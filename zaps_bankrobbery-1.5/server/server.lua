
local playerRobberyTimestamps = {}
local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)


RegisterServerEvent('zaps:payday')
AddEventHandler('zaps:payday', function(amount)
    local source = source
    local xPlayer = VORPcore.getUser(source)
    local currentTime = os.time()

    local hasRequiredItem = Inventory.getItemCount(source, Config.ItemRequirement )


    if  hasRequiredItem > 1 then
        TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, 'You need the required item to start this event.')
        return
    end

    local lastRobberyTime = playerRobberyTimestamps[source]
    if lastRobberyTime then
        if currentTime - lastRobberyTime < 200 then
            print(('Player %s tried to finish the robbery too quickly'):format(xPlayer.identifier))
            DropPlayer(source, 'Player %s tried to finish the robbery too quickly'):format(xPlayer.identifier)
            return
        end
    end

    playerRobberyTimestamps[source] = currentTime

    if xPlayer then
        if amount > 1500 then
            print(('Player %s tried to claim an invalid amount: %s'):format(xPlayer.identifier, amount))
            DropPlayer(source, 'Player %s tried to claim an invalid amount: %s'):format(xPlayer.identifier, amount)
            return
        end
        local Player = VORPcore.getUser(source).getUsedCharacter
        Player.addCurrency(0, Config.rewardAmount)
    end
end)



RegisterNetEvent('zaps:storeRobberyStarted')
AddEventHandler('zaps:storeRobberyStarted', function(storeName)
    local _source = source
    local xPlayers = GetPlayers()
    
    for i = 1, #xPlayers, 1 do
        local xPlayer = VORPcore.getUser(xPlayers[i])
        local Character = xPlayer.getUsedCharacter -- Get the character data

        if Character.job == 'admin' then

            local message = string.format("A store is being robbed! Respond immediately.")
            
            TriggerClientEvent('chat:addMessage', xPlayers[i], {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-exclamation-circle"></i> {0}</div>',
                args = { message }
            })
        end
    end
end)



function zapsupdatee()
    local githubRawUrl = "https://raw.githubusercontent.com/Zaps6000/base/main/api.json"
    local resourceName = "bankrobbery" 
    
    PerformHttpRequest(githubRawUrl, function(statusCode, responseText, headers)
        if statusCode == 200 then
            local responseData = json.decode(responseText)
    
            if responseData[resourceName] then
                local remoteVersion = responseData[resourceName].version
                local description = responseData[resourceName].description
                local changelog = responseData[resourceName].changelog
    
                local manifestVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
    
                print("Resource: " .. resourceName)
                print("Manifest Version: " .. manifestVersion)
                print("Remote Version: " .. remoteVersion)
                print("Description: " .. description)
    
                if manifestVersion ~= remoteVersion then
                    print("Status: Out of Date (New Version: " .. remoteVersion .. ")")
                    print("Changelog:")
                    for _, change in ipairs(changelog) do
                        print("- " .. change)
                    end
                    print("Link to Updates: https://zaps6000.tebex.io/ https://discord.gg/cfxdev")
                else
                    print("Status: Up to Date")
                end
            else
                print("Resource name not found in the response.")
            end
        else
            print("HTTP request failed with status code: " .. statusCode)
        end
    end, "GET", nil, json.encode({}), {})
    end
    AddEventHandler('onResourceStart', function(resource)
        if resource == 'zaps_bankrobbery' then
            zapsupdatee()
        else 
            print("[ALERT!!! Please rename your resource to zaps_bankrobbery") -- Please do not edit this is how I keep track of how many servers use it.
        end
    end)

