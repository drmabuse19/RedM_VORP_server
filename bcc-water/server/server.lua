local VORPcore = exports.vorp_core:GetCore()

local Needs = {}
TriggerEvent('Outsider_Needs', function(cb)
    Needs = cb
end)

VORPcore.Callback.Register('bcc-water:GetCanteenLevel', function(source, cb)
	local _source = source
    local itemCanteen = Config.canteen
    local canteen = exports.vorp_inventory:getItem(_source, itemCanteen)
    if canteen ~= nil then
        local meta = canteen['metadata']
        if next(meta) == nil then
            exports.vorp_inventory:subItem(_source, itemCanteen, 1, {})
            exports.vorp_inventory:addItem(_source, itemCanteen, 1, {
                description = Config.lang.level .. ' : ' .. '<span style=color:green;>' .. Config.lang.full .. '</span>', level = 5
            })
        else
            local level = meta.level
            if level < 5 then
                exports.vorp_inventory:subItem(_source, itemCanteen, 1, meta)
                exports.vorp_inventory:addItem(_source, itemCanteen, 1, {
                    description = Config.lang.level .. ' : ' .. '<span style=color:green;>' .. Config.lang.full .. '</span>', level = 5
                })
            else
                VORPcore.NotifyRightTip(_source, _U('notEmpty'), 4000)
                cb(false)
                return
            end
        end
        cb(true)
    else
        VORPcore.NotifyRightTip(_source, _U('needCanteen'), 4000)
        cb(false)
    end
end)

exports.vorp_inventory:registerUsableItem(Config.canteen, function(data)
    local _source = data.source
    exports.vorp_inventory:closeInventory(_source)
    TriggerClientEvent('bcc-water:UseCanteen', _source)
end)

VORPcore.Callback.Register('bcc-water:UpdateCanteen', function(source, cb)
    local _source = source
    local itemCanteen = Config.canteen
    local canteen = exports.vorp_inventory:getItem(_source, itemCanteen)
    local meta = canteen['metadata']
    local level = meta.level
    local canteenUpdate = {
        [1] = function()
            VORPcore.NotifyRightTip(_source, _U('message_1'), 4000)
        end,
        [2] = function()
            exports.vorp_inventory:subItem(_source, itemCanteen, 1, meta)
            exports.vorp_inventory:addItem(_source, itemCanteen, 1, {
                description = Config.lang.level .. ' : ' .. '<span style=color:red;>' .. Config.lang.empty .. '</span>', level = 1
            })
        end,
        [3] = function()
            exports.vorp_inventory:subItem(_source, itemCanteen, 1, meta)
            exports.vorp_inventory:addItem(_source, itemCanteen, 1, {
                description = Config.lang.level .. ' : ' .. '<span style=color:green;>' .. '25%' .. '</span>', level = 2
            })
        end,
        [4] = function()
            exports.vorp_inventory:subItem(_source, itemCanteen, 1, meta)
            exports.vorp_inventory:addItem(_source, itemCanteen, 1, {
                description = Config.lang.level .. ' : ' .. '<span style=color:green;>' .. '50%' .. '</span>', level = 3
            })
        end,
        [5] = function()
            exports.vorp_inventory:subItem(_source, itemCanteen, 1, meta)
            exports.vorp_inventory:addItem(_source, itemCanteen, 1, {
                description = Config.lang.level .. ' : ' .. '<span style=color:green;>' .. '75%' .. '</span>', level = 4
            })
        end
    }
    if canteenUpdate[level] then
	    canteenUpdate[level]()
    end
    if not level then
        VORPcore.NotifyRightTip(_source, _U('message_1'), 4000)
        cb(false)
    elseif level > 1 then
        cb(level)
    end
end)

-- Check if Player has an Empty Bucket and Update
VORPcore.Callback.Register('bcc-water:GetBucket', function(source, cb)
    local _source = source
    local hasItem = exports.vorp_inventory:getItem(_source, Config.emptyBucket)
    if hasItem then
        exports.vorp_inventory:subItem(_source, Config.emptyBucket, 1)
        exports.vorp_inventory:addItem(_source, Config.fullBucket, 1)
        cb(true)
    else
        VORPcore.NotifyRightTip(_source, _U('needBucket'))
        cb(false)
    end
end)

RegisterNetEvent('outsider_needs:Thirst', function(wild)
    local _source = source
    local data = {}
    if wild then
        data = {water = Config.wildThirst}
    else
        data = {water = Config.thirst}
    end
    Needs.addStats(_source, data)
end)

