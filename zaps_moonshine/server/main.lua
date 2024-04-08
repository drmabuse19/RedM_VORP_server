

RegisterNetEvent('moonshine:server:brew')
AddEventHandler('moonshine:server:brew', function()
    local _source = source
    if vorp then 
     User = VORPcore.getUser(_source)
end 
    local player = User.getUsedCharacter

    local hasAllRequirements = true
    for _, req in pairs(Config.Brewing.Requirements) do
        local itemCount = Inventory.getItemCount(_source, req.item)
        if itemCount < req.quantity then
            hasAllRequirements = false
            break
        end
    end
    

    if hasAllRequirements then
        for _, req in pairs(Config.Brewing.Requirements) do
            Inventory.subItem(_source, req.item, req.quantity)
        end

        local brewSuccess = math.random() > Config.Brewing.FailureRate

        if brewSuccess then
            for _, reward in pairs(Config.Brewing.Rewards) do
                Inventory.addItem(_source, reward.item, reward.quantity)
            end
            if vorp then 
                TriggerClientEvent("vorp:TipRight", _source, "Successfully brewed moonshine!", 4000)
            end 
            else
            if Config.Brewing.FailurePenalty.removeRequirements then
                for _, req in pairs(Config.Brewing.Requirements) do
                    Inventory.subItem(_source, req.item, req.quantity)
                end
            end
            for _, reward in pairs(Config.Brewing.Rewards) do
                local reducedQuantity = reward.quantity - Config.Brewing.FailurePenalty.rewardReduction
                if reducedQuantity > 0 then
                    Inventory.addItem(_source, reward.item, reducedQuantity)
                end
            end
            if vorp then 
                TriggerClientEvent("vorp:TipRight", _source, "Brewing failed!", 4000)
            end
        end
    else
        if vorp then 

        TriggerClientEvent("vorp:TipRight", _source, "You don't have the required items for brewing.", 4000)
    end
    end
end)


local UsableItems = Config.UsableItems

local function registerItem(itemName, itemConfig)
    exports.vorp_inventory:registerUsableItem(itemName, function(data)
        local _source = data.source

        for _, removeItem in pairs(itemConfig.removeItems) do
            exports.vorp_inventory:subItem(_source, removeItem.item, removeItem.count, cb)
        end

        for _, addItem in pairs(itemConfig.addItems) do
            exports.vorp_inventory:addItem(_source, addItem.item, addItem.count, cb)
        end

        if itemConfig.clientEvent then
            TriggerClientEvent(itemConfig.clientEvent, _source)
        end

        TriggerClientEvent('chat:addMessage', _source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw 0; background-color: rgba(28, 32, 33, 0.6); border-radius: 3px;">{0}</div>',
            args = { itemConfig.notification }
        })
            end)
end

for itemName, itemConfig in pairs(UsableItems) do
    registerItem(itemName, itemConfig)
end


function zapsupdatee()
    local githubRawUrl = "https://raw.githubusercontent.com/Zaps6000/base/main/api.json"
    local resourceName = "moonshine" 
    
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
                    print("Link to Updates:  https://discord.gg/cfxdev")
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
        if resource == 'zaps_moonshine' then
            zapsupdatee()
        else 
            print("[ALERT!!! Please rename your resource to zaps_moonshine") -- Please do not edit this is how I keep track of how many servers use it.
        end
    end)
