--------------------- Pulling Essentials --------------------
local VORPcore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()

------------ Hint Management -----------------
local HintCooldown = false
RegisterServerEvent('bcc-nazar:BuyHint', function(cost)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    if not HintCooldown then
        if Character.money >= cost then
            Character.removeCurrency(0, cost)
            TriggerClientEvent('bcc-nazar:OpenChest', _source)
        else
            VORPcore.NotifyRightTip(_source, _U('NoMoney'), 4000)
            return
        end
        HintCooldown = true
        Wait(Config.NazarSetup.hintCooldown)
        HintCooldown = false
    else
        VORPcore.NotifyBottomRight(_source, _U('NoHintNotify'), 4000)
    end
end)

--------- Nazar Spawn Coords Handler (Done Server Side so its same location for all players) ---------------
local randomizedCoords, d = 0, 0
local nspawn
RegisterServerEvent('bcc-nazar:LocationSet', function()
    if randomizedCoords == 0 then
        d = math.random(1, #Config.NazarSetup.nazarspawn)
        nspawn = Config.NazarSetup.nazarspawn[d]
        randomizedCoords = randomizedCoords + 1
    end
    TriggerClientEvent('bcc-nazar:PedSpawn', source, nspawn)
end)


---------------------- Selling Items Setup ----------------------
RegisterServerEvent('bcc-nazar:GetPlayerDataForSell', function(qty, itemName, price, currencyType)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local itemCount = exports.vorp_inventory:getItemCount(_source, nil, itemName)
    local amountCatch = 0
    local currency = 0
    if (currencyType == 'gold') then
        currency = 1
    end -- added by mrtb edited
    if itemCount >= tonumber(qty) then
        exports.vorp_inventory:subItem(_source, itemName, qty)
        repeat
        Wait(0)
        Character.addCurrency(currency, tonumber(price))
        amountCatch = amountCatch + 1
        until amountCatch >= qty
        VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier,
            ShopWebhook, 'Items Sold ' .. itemName .. ' Amount sold ' .. qty .. ' Sold for ' .. tonumber(price))
    elseif itemCount < tonumber(qty) then
        VORPcore.NotifyBottomRight(_source, _U('NoItem'), 4000)
    end
end)

----------- Handles Giving Items When Chest Is Opened ------------
local ChestCooldown = false
RegisterServerEvent('bcc-nazar:GetRewards', function(V)
    local _source = source
    local items = ''
    local Character = VORPcore.getUser(_source).getUsedCharacter
    if not ChestCooldown then
        for _, v in pairs(V.Reward) do
            exports.vorp_inventory:addItem(_source, v.name, v.count)
            items = items .. v.displayname .. ','
        end
        VORPcore.NotifyRightTip(_source, _U('ChestLooted') .. items, 4000)
        VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier, ChestWebhook, 'chest Opened ' .. V.huntname)
        ChestCooldown = true
        Wait(Config.NazarSetup.hintCooldown)
        ChestCooldown = false
    end
end)

------------ This will actually sell the items -----------------
RegisterServerEvent('bcc-nazar:BuyFromNazar', function(qty, itemName, price, currencyType)
    local _source = source
    local totalAmount = qty * price --multiplies the qty by the price to get the total amount of cash it should cost
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local currency = 0
    local currmoney = Character.money
    if (currencyType == 'gold') then
        currency = 1
        currmoney = Character.gold
    end -- added by mrtb end
    if currmoney >= totalAmount then
        exports.vorp_inventory:addItem(_source, itemName, qty)
        Character.removeCurrency(currency, totalAmount)
        VORPcore.AddWebhook(Character.firstname .. " " .. Character.lastname .. " " .. Character.identifier,
            ShopWebhook, 'Items bought ' .. itemName .. ' Item price ' .. tostring(price) .. ' Amount bought ' .. tostring(qty))
    elseif currmoney < totalAmount then
        if (currencyType == 'cash') then --- added by mrtb start
            VORPcore.NotifyBottomRight(_source, _U('NoMoney'), 4000)
        elseif (currencyType == 'gold') then
            VORPcore.NotifyBottomRight(_source, _U('NoGold'), 4000)
        end -- added by mrtb end
    end
end)

exports.vorp_inventory:registerUsableItem('collector_card', function(data)
    local _source = data.source
    exports.vorp_inventory:closeInventory(_source)
    TriggerClientEvent('bcc-nazar:UseCard', _source, data.item['metadata'].model)
end)

RegisterServerEvent("bcc-nazar:GetCard", function(cardname, model)
    local _source = source
    local canCarry = exports.vorp_inventory:canCarryItem(_source, ConfigCards.Item, 1)
    if canCarry then
        local hasSpace = exports.vorp_inventory:canCarryItems(_source, 1)
        if hasSpace then
            VORPcore.NotifyLeft(_source, _U('CardCollected'), _U('YouCollected'), "INVENTORY_ITEMS", "document_cig_card_act", 4000, "Color_white")
            exports.vorp_inventory:addItem(_source, ConfigCards.Item, 1, { description = cardname, model = model })
        else
            VORPcore.NotifyRightTip(_source, _U('InvFull'), 4000)
        end
    else
        VORPcore.NotifyRightTip(_source, _U('StackFull'), 4000)
    end
end)

local CardCooldown = {}
VORPcore.Callback.Register('bcc-nazar:CardCooldown', function(source, cb, cardId)
    if CardCooldown[cardId] then
        if os.difftime(os.time(), CardCooldown[cardId]) >= ConfigCards.CardTime * 60 then
            CardCooldown[cardId] = os.time()
          cb(false)
        else
          cb(true)
        end
    else
        CardCooldown[cardId] = os.time() --Store the current time
        cb(false)
    end
end)

--This handles the version check
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-nazar')
