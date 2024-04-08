AllPlants = {} -- AllPlants is a table that will contain all the plants in the server

---@param plantData table
---@param plantCoords vector3
---@param fertilized boolean
RegisterServerEvent("bcc-farming:AddPlant", function(plantData, plantCoords, fertilized)
    local _source = source
    local character = VORPcore.getUser(_source).getUsedCharacter
    local plantId = MySQL.insert.await("INSERT INTO bcc_farming (plant_coords, plant_type, plant_watered, time_left, plant_owner) VALUES (?, ?, ?, ?, ?)", { json.encode(plantCoords), plantData.seedName, "false", plantData.timeToGrow, character.charIdentifier })
    if fertilized then
        VorpInv.subItem(_source, plantData.fertilizerName, 1)
    end
    VorpInv.subItem(_source, plantData.seedName, 1)
    if Config.plantSetup.lockedToPlanter then
        TriggerClientEvent('bcc-farming:PlantPlanted', _source, plantId, plantData, plantCoords, plantData.timeToGrow, false, _source)
    else
        TriggerClientEvent('bcc-farming:PlantPlanted', -1, plantId, plantData, plantCoords, plantData.timeToGrow, false, _source)
    end
end)

RegisterServerEvent("bcc-farming:NewClientConnected", function()
    local _source = source
    if not Config.plantSetup.lockedToPlanter then
        if #AllPlants > 0 then
            for k, v in pairs(AllPlants) do
                for e, u in pairs(Config.plantSetup.plants) do
                    if v.plant_type == u.seedName then
                        TriggerClientEvent('bcc-farming:PlantPlanted', _source, v.plant_id, u, json.decode(v.plant_coords), v.time_left, v.plant_watered, _source) break
                    end
                end
            end
        end
    else
        local character = VORPcore.getUser(_source).getUsedCharacter
        if #AllPlants > 0 then
            for k, v in pairs(AllPlants) do
                if v.plant_owner == character.charIdentifier then
                    for e, u in pairs(Config.plantSetup.plants) do
                        if v.plant_type == u.seedName then
                            TriggerClientEvent('bcc-farming:PlantPlanted', _source, v.plant_id, u, json.decode(v.plant_coords), v.time_left, v.plant_watered, _source) break
                        end
                    end
                end
            end
        end
    end
end)

---@param plantId integer
RegisterServerEvent("bcc-farming:UpdatePlantWateredStatus", function(plantId)
    local _source = source
    local waterBucketCount = VorpInv.getItemCount(_source, Config.fullWaterBucketItem)
    if waterBucketCount > 0 then
        VorpInv.subItem(_source, Config.fullWaterBucketItem, 1)
        VorpInv.addItem(_source, Config.emptyWaterBucketItem, 1)
        MySQL.query.await("UPDATE bcc_farming SET plant_watered = ? WHERE plant_id = ?", { 'true', plantId })
        TriggerClientEvent("bcc-farming:UpdatePlantWateredStatus", -1, plantId)
    else
        VORPcore.NotifyRightTip(_source, _U("noWaterBucket"), 4000)
    end
end)

---@param plantId integer
---@param plantData table
---@param destroy boolean
RegisterServerEvent('bcc-farming:HarvestPlant', function(plantId, plantData, destroy)
    local _source = source
    if not destroy then
        for k, v in pairs(plantData.rewards) do
            VorpInv.addItem(_source, v.itemName, v.amount)
        end
    end
    MySQL.query.await("DELETE FROM bcc_farming WHERE plant_id = ?", { plantId })
    TriggerClientEvent("bcc-farming:RemovePlantClient", -1, plantId)
end)

CreateThread(function()
    while true do
        Wait(1000)
        local allPlants = MySQL.query.await("SELECT * FROM bcc_farming")
        AllPlants = allPlants
        if #allPlants > 0 then
            for k, v in pairs(allPlants) do
                if v.plant_watered == "true" and tonumber(v.time_left) > 0 then
                    exports.oxmysql:execute("UPDATE bcc_farming SET time_left = time_left - ? WHERE plant_id = ?", { 1, v.plant_id })
                end
            end
        end
    end
end)