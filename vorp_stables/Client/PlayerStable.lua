Ride = {
    id = 0,
    name = "",
    model = "",
    type = "",
    isDefault = 0,
    comps = {},
    owner = 0
}

PlayerStable = {
    characterId = 0,
    rides = {},
    transferedRides = {},
    availableComps = {}
}

function Ride:new(rideFromDB)
    local ride = {
        id = rideFromDB.id,
        name = rideFromDB.name,
        model = rideFromDB.modelname,
        type = rideFromDB.type,
        isDefault = rideFromDB.isDefault,
        comps = json.decode(rideFromDB.gear),
        owner = rideFromDB.charidentifier,
        lth = rideFromDB.injured
    }
    setmetatable(ride, self)
    self.__index = self
    return ride
end

function PlayerStable:new(ridesAsDBList, charId, availableComps, waitingRides)
    if type(availableComps) == "string" then
        availableComps = json.decode(availableComps)
    end
    local playerStable = {
        characterId = charId,
        availableComps = {},
        rides = {},
        transferedRides = {}
    }

    -- Initialize comps from DB table horse_complements so it follows the same structure
    -- It will leave a lot of empty tables but we'll deal with them further down the line
    -- I might as well get rid of these by iterating a 3rd time but I might need it at some point so leave as is for now
    for compFamily, compModels in pairs(Config.StaticData.Complements) do
        playerStable.availableComps[compFamily] = {}
    end

    for k, compHash in pairs(availableComps) do
        for compFamily, compModels in pairs(Config.StaticData.Complements) do
            for modelName, modelVariants in pairs(compModels) do
                local currTable = {}
                for variantIndex, variantHash in ipairs(modelVariants) do
                    if tonumber(variantHash) == compHash then
                        table.insert(currTable, 1, compHash)
                    end
                end
                if #currTable > 0 then
                    playerStable.availableComps[compFamily][modelName] = currTable
                end
            end
        end
    end

    for k, rideFromDB in ipairs(ridesAsDBList) do
        local rideData = Ride:new(rideFromDB)
        if rideFromDB.isDefault > 0 then
            if rideFromDB.type == "horse" then
                local entity
                if CurrentHorse ~= nil then
                    entity = CurrentHorse.pedId
                end
                CurrentHorse = rideData
                CurrentHorse.pedId = entity
            elseif rideFromDB.type == "cart" then
                local entity
                if CurrentCart ~= nil then
                    entity = CurrentCart.pedId
                end
                CurrentCart = rideData
                CurrentCart.pedId = entity
            end
        end

        table.insert(playerStable.rides, 1, rideData)
    end

    for k, rideFromDB in ipairs(waitingRides) do
        local rideData = Ride:new(rideFromDB)
        rideData.price = json.decode(rideFromDB.status).price
        table.insert(playerStable.transferedRides, 1, rideData)
    end

    if (CurrentHorse ~= nil) then

    end
    setmetatable(playerStable, self)
    self.__index = self
    return playerStable
end

function PlayerStable:horseCount(stable)
    local count = 0
    for k, v in ipairs(stable.rides) do
        if (v.type == "horse") then
            count = count + 1
        end
    end
    return count
end

function PlayerStable:cartCount(stable)
    local count = 0
    for k, v in ipairs(stable.rides) do
        if (v.type == "cart") then
            count = count + 1
        end
    end
    return count
end

function PlayerStable:isFull(stable, rideType)
    local retval = ((rideType == "horse" and PlayerStable:horseCount(stable) <= Config.MaxHorses) or
               (rideType == "cart" and PlayerStable:cartCount(stable) <= Config.MaxCarts)) and
               (stable.rides ~= nil and #stable.rides <= Config.StableSlots)
    return not retval
end
