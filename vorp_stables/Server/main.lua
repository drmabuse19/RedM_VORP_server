-- SERVER_MAIN
local db = exports.oxmysql

local VorpCore
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

RegisterNetEvent(Events.loadStable, function(charid)
    local src = source
    LoadStableContent(src, charid, true)
end)

RegisterNetEvent(Events.loadStableRuntime, function()
    local src = source
    local id = VorpCore.getUser(src).getUsedCharacter.charIdentifier
    LoadStableContent(src, id, true)
end)

-- Everytime a DB action is made, this function gets called to sync data on the client with data in the DB
function LoadStableContent(src, charId, regInvs)
    -- Retrieve owned rides, and rides transfered to this player
    db:execute(
        "SELECT * FROM stables WHERE `charidentifier`=? OR `status` LIKE '%\"transferTarget\":?,%' OR `status` LIKE '%\"transferTarget\":?}'",
        {charId, charId, charId}, function(result)
            db:execute("SELECT `complements` FROM horse_complements WHERE `charidentifier`=?", {charId},
                function(compsResult)
                    local comps
                    if (#compsResult == 0) then
                        comps = {}
                        db:execute(
                            "INSERT INTO  horse_complements (`charidentifier`, `complements`, `identifier`) VALUES (?,?,?)",
                            {charId, "[]", tostring(charId)})
                    else
                        comps = compsResult[1]["complements"]
                    end
                    local ownedRides = {}
                    local waitingRides = {}
                    for k, v in ipairs(result) do
                        if v.charidentifier == charId then
                            table.insert(ownedRides, 1, v)
                        else
                            table.insert(waitingRides, 1, v)
                        end
                    end
                    local out = {
                        rides = ownedRides,
                        transferedRides = waitingRides,
                        availableComps = comps,
                        charId = charId
                    }
                    TriggerClientEvent(Events.onStableLoaded, src, out)
                end)
            if regInvs ~= nil then
                for k, ride in pairs(result) do
                    local limit
                    if Config.CustomMaxWeight[ride.modelname] then
                        limit = Config.CustomMaxWeight[ride.modelname]
                    else
                        limit = Config.DefaultMaxWeight
                    end
                    print("Registering inv for " .. ride.name)
                    VorpInv.registerInventory(ride.name, ride.name, limit, true, Config.ShareInv[ride.type], Config.StackInvIgnore[ride.type])
                end
            end
        end)

    db:execute("SELECT charidentifier, firstname, lastname, job FROM characters", function(result)
        TriggerClientEvent("charsLoaded", src, result)
    end)
end

RegisterNetEvent(Events.onBuyRide, function(rideName, rideModel, rideType, price)
    price = tonumber(price)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier

    if price > player.money then
        return TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford, 4000)
    end

    player.removeCurrency(0, price)
    db:execute(
        "INSERT INTO stables (`charidentifier`, `name`, `type`, `modelname`, `identifier`) VALUES (?, ?, ?, ?, 'steam:')",
        {id, rideName, rideType, rideModel}, function(result)
            if result.affectedRows > 0 then
                TriggerClientEvent("vorp:TipRight", src,
                Config.Lang.TipRidePurchased:gsub("%{rideName}", rideName):gsub("%{price}", price), 4000)
                local limit
                    if Config.CustomMaxWeight[rideModel] ~= nil then
                        limit = Config.CustomMaxWeight[rideModel]
                    else
                        limit = Config.DefaultMaxWeight
                    end
                VorpInv.registerInventory(rideName, rideName, limit, true, Config.ShareInv[rideType], false)
                LoadStableContent(src, id)
            end
        end)
end)

RegisterNetEvent(Events.onBuyComp, function(compModel, compType, price, horseId, horseComps, playerAvailableComps)
    price = tonumber(price)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier

    if price > player.money then
        return TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford, 4000)
    end
    compModel = tonumber(compModel)
    local compsForDB = {}
    horseComps[compType] = compModel
    local alreadyHasComp = false

    -- When a comp is bought, check the comps the player already owns
    -- If not owned, add to table, else set alReadyHasComp to true to prevent a DB operation
    for compTypeName, compModels in pairs(playerAvailableComps) do
        for compModelName, comps in pairs(compModels) do
            for k, comp in ipairs(comps) do
                local compHash = tonumber(comp)
                table.insert(compsForDB, 1, compHash)
                if comp == compModel then
                    alreadyHasComp = true
                    break
                end
            end
        end
    end

    -- This removes the equipement of the horse if the translation key has changed to avoid doubles
    -- //TODO replace with the current key rather than deleting for QOL (keep in mind that the players keep their stuff in horse_complements)

    for k, v in pairs(horseComps) do
        if Config.StaticData.Complements[k] == nil then
            horseComps[k] = nil
        end
    end

    db:execute("UPDATE stables SET `gear` = ? WHERE `id` = ?", {json.encode(horseComps), horseId}, function(result)
        if result.affectedRows > 0 then
            player.removeCurrency(0, price)
            TriggerClientEvent("vorp:TipRight", src,
                Config.Lang.TipSuccessfulBuyComp:gsub("%{0}", compType):gsub("%{1}", price), 4000)
            if not alreadyHasComp then
                table.insert(compsForDB, 1, compModel)
                db:execute("UPDATE horse_complements SET `complements` = ? WHERE `charidentifier` = ?",
                    {json.encode(compsForDB), id}, function(result)
                        if result.affectedRows > 0 then
                            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipAddedToStable, 4000)
                        else
                            TriggerClientEvent("vorp:TipRight", src,
                                Config.Lang.TipErrorOnAdd, 4000)
                        end
                        LoadStableContent(src, id)
                    end)
            else
                LoadStableContent(src, id)
            end
        else
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnPurchase, 4000)
        end
    end)

end)

RegisterNetEvent(Events.onRemoveComps, function(rideId) 
    db:execute("UPDATE stables SET `gear` = '{}' WHERE `id` = ?", {rideId})
end)

RegisterNetEvent(Events.onDelete, function(rideId)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    db:execute("DELETE FROM stables WHERE `id` = ?", {rideId}, function()
        TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipHorseFreed, 4000)
        LoadStableContent(src, id)
    end)
end)

RegisterNetEvent(Events.onTransfer, function(rideId, targetChar, price, activePlayers)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    local targetSource = nil
    -- Check if recieving player is connected so their stable content gets refreshed
    for k, v in ipairs(activePlayers) do
        local u = VorpCore.getUser(v)
        if u ~= nil then
            local p = u.getUsedCharacter
            local i = p.charIdentifier
            if i == targetChar then
                targetSource = v
                break
            end
        end
    end

    -- The ride isn't directly transfered, the offer is stored in the ride status for the recieving player to accept or not
    db:execute("UPDATE stables SET status = ? WHERE `id` = ?", {json.encode({
        transferTarget = targetChar,
        price = price
    }), rideId}, function()
        TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipOfferSent, 4000)
        LoadStableContent(src, id)
        if targetSource ~= nil then
            LoadStableContent(targetSource, targetChar)
        end
    end)
end)

RegisterNetEvent(Events.onTransferRecieve, function(rideId, accepted, price, activePlayers)
    price = tonumber(price)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    local targetSource = nil
    for k, v in ipairs(activePlayers) do
        local u = VorpCore.getUser(v)
        if u ~= nil then
            local p = u.getUsedCharacter
            local i = p.charIdentifier
            if i == targetChar then
                targetSource = v
                break
            end
        end
    end
    if not accepted then
        db:execute("UPDATE stables SET status = NULL WHERE `id` = ?", {rideId}, function()
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipOfferDeclined, 4000)
            LoadStableContent(src, id)
        end)
    elseif player.money >= price then
        db:execute("UPDATE stables SET status = NULL, charidentifier = ? WHERE `id` = ?", {id, rideId}, function()
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipOfferAccepted:gsub("%{price}", price), 4000)
            LoadStableContent(src, id)
            player.removeCurrency(0, price)
            if targetSource ~= nil then
                local tPlayer = VorpCore.getUser(targetSource).getUsedCharacter
                tPlayer.addCurrency(0, price)
                LoadStableContent(targetSource, targetChar)
            end
            -- //TODO add currency to seller if disconnected
        end)
    elseif player.money < price then
        TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford .. " " .. Config.Lang.TipOfferStillOn, 4000)
    end
end)

RegisterNetEvent(Events.openInventory, function(rideName)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    VorpInv.OpenInv(src, rideName)
end)

RegisterNetEvent(Events.setDefault, function(newRide, prevRide)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    db:execute("UPDATE stables SET `isDefault` = 1 WHERE `id` = ?", {newRide}, function(updated, b)

        if updated.affectedRows > 0 and prevRide ~= nil then
            db:execute("UPDATE stables SET `isDefault` = 0 WHERE `id` = ?", {prevRide}, function(secondUpdate)
                if secondUpdate.affectedRows > 0 then
                    TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipChanged, 4000)
                    LoadStableContent(src, id)
                else
                    TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnUpdate, 4000)
                    LoadStableContent(src, id)
                end
            end)
        elseif updated.affectedRows > 0 then
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipChanged, 4000)
            LoadStableContent(src, id)
        else
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnUpdate, 4000)
        end
    end)
end)

RegisterNetEvent(Events.onHorseDown, function(rideId, killerObjectHash)
    -- HardDeath management
    if not Config.HardDeath then
        return
    end
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    print("Killed by " .. tostring(killerObjectHash))
    local LTDamages = DeathReasons[killerObjectHash] or DeathReasons.Default
    db:execute("UPDATE stables SET injured = injured + ? WHERE `id` = ?", {LTDamages, rideId}, function(updated)
        if updated.affectedRows > 0 then
            db:execute("SELECT injured FROM stables WHERE `id` = ?", {rideId}, function(result)
                if result[1].injured >= Config.LongTermHealth then
                    db:execute("DELETE FROM stables WHERE `id` = ?", {rideId}, function(deleted)
                        if deleted.affectedRows > 0 then
                            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipHorseDeadDefinitive, 4000)
                            LoadStableContent(src, id)
                        end
                    end)
                end
            end)
        end
    end)

end)

