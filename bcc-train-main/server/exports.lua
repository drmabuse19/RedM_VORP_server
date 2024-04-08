-- Check If train is spawned or in use
exports('CheckIfTrainIsSpawned', function()
    if TrainSpawned then
        return true
    else
        return false
    end
end)

-- Get Train Entity
exports('GetTrainEntity', function()
    if TrainSpawned then
        if TrainEntity then
            return TrainEntity
        end
    else
        return false
    end
end)

-- Check if baccus bridge destroyed
exports('BacchusBridgeDestroyed', function()
    if BridgeDestroyed then
        return true
    else
        return false
    end
end)