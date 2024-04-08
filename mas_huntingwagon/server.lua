local WagonList = {}

local function GenerateWagonId(identifier)
    local newId = lib.string.random("1A1A")
    for id in pairs(WagonList) do
        if id == newId then
            return GenerateWagonId(identifier)
        end
    end
    return newId
end

local function IsRentedWagon(source)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    for id, data in pairs(WagonList) do
        if data.owner == identifier then
            return true, id
        end
    end
    return false, 0
end

local function IsWagonIdValid(wagonId)
    if not WagonList?[wagonId] then
        return false
    end
    return true
end

local function GetCargoItemWeight(model)
    local itemWeight = Config.WagonCargo[model].size
    return itemWeight or 2
end

local function GetWagonCargoWeight(wagonId)
    local cargo = WagonList[wagonId].cargo
    local total = 0
    for i = 1, #cargo do
        local itemSize = GetCargoItemWeight(cargo[i].model)
        total += itemSize
    end
    return total
end

local function CheckCargoWeight(wagonId, model)
    local newItemSize = GetCargoItemWeight(model)
    local weight = GetWagonCargoWeight(wagonId)

    if (weight + newItemSize) > Config.MaxCargo then
        return false
    end

    return true
end

AddEventHandler('playerConnecting', function(_, _, deferrals)
    local source = source
    local isRented, wagonId = IsRentedWagon(source)
    SetTimeout(15000, function()
        if not isRented then return end
        local wagon = WagonList?[wagonId]
        TriggerClientEvent("mas_huntingwagon:client:setBlip", source, wagon.netid)
    end)
end)

RegisterNetEvent('mas_huntingwagon:server:SetWagonId', function(netId)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    local wagon = Entity(NetworkGetEntityFromNetworkId(netId)).state
    local wagonId = GenerateWagonId(identifier)
    wagon.wagonId = wagonId
    wagon.owner = identifier

    WagonList[wagonId] = {}
    WagonList[wagonId].cargo = {}
    WagonList[wagonId].owner = identifier
    WagonList[wagonId].netid = netId
end)

RegisterNetEvent('mas_huntingwagon:server:RemoveWagonId', function(netId)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    if not netId then
        for key, data in pairs(WagonList) do
            if data.owner == identifier then
                TriggerClientEvent("mas_huntingwagon:client:deletetWagon", source, data.netid)
                WagonList[key] = nil
                return
            end
        end
    else
        -- local amount = Config.RentPrice / 2
        -- AddMoney(amount) --On my server, I give him half of the money if he returns the wagon.

        local wagon = Entity(NetworkGetEntityFromNetworkId(netId)).state
        local wagonId = wagon.wagonId
        local owner = wagon.owner
        if owner == identifier then
            WagonList[wagonId] = nil
        end
    end
end)

lib.callback.register('mas_huntingwagon:getIdentifier', function(source)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    return identifier
end)

lib.callback.register('mas_huntingwagon:addWagonItem', function(source, netId, wagonId, data)
    if not IsWagonIdValid(wagonId) then
        TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "error", text = "This is a ghost wagon!" })
        return 0, false
    end
    local wagon = NetworkGetEntityFromNetworkId(netId)
    local cargo = WagonList[wagonId].cargo
    if not CheckCargoWeight(wagonId, data.model) then
        return #cargo, true
    end
    cargo[#cargo+1] = data
    Entity(wagon).state.capacity = GetWagonCargoWeight(wagonId)
    return #cargo, false
end)

lib.callback.register('mas_huntingwagon:getWagonItem', function(source, netId, wagonId)
    if not IsWagonIdValid(wagonId) then
        TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "error", text = "This is a ghost wagon!" })
        return -1, {}
    end
    local wagon = NetworkGetEntityFromNetworkId(netId)
    local cargo = WagonList[wagonId].cargo
    if #cargo < 1 then return -1, {} end
    local item = cargo[#cargo]
    cargo[#cargo] = nil
    Entity(wagon).state.capacity = GetWagonCargoWeight(wagonId)
    return #cargo, item
end)

lib.callback.register("mas_huntingwagon:payRent", function(source)
    -- local money = GetMoney() --replace with your own function
    -- if money < Config.RentPrice then
    --     return false
    -- end
    if IsRentedWagon(source) then
        TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "error", text = "You already rented a wagon earlier!" })
        return false
    end
    -- RemoveMoney(Config.RentPrice) --replace with your own function
    return true
end)

