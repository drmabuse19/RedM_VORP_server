local VorpCore = {}

TriggerEvent('getCore', function(core)
    VorpCore = core
end)

local T = Translation.Langs[Config.Lang]

RegisterServerEvent('xakra_steal:MoneyOpenMenu')
AddEventHandler('xakra_steal:MoneyOpenMenu', function(steal_source)
    local _source = source
    local Character = VorpCore.getUser(steal_source).getUsedCharacter

    local Amount = 0

    for _, player in pairs(GetPlayers()) do
        local Character2 = VorpCore.getUser(player).getUsedCharacter

        for _, job in pairs(Config.RequiredJobs.Jobs) do
            if Character2.job == job then
                Amount = Amount + 1
                break
            end
        end
    end

    if Amount < Config.RequiredJobs.Amount then
        VorpCore.NotifyObjective(_source, T.NotJobs, 4000)
        return
    end

    TriggerClientEvent('xakra_steal:OpenMenu', _source, Character.money, true)
    TriggerClientEvent('xakra_steal:StealingPlayers', -1, steal_source)
end)

RegisterServerEvent('xakra_steal:CallDelStealingPlayers')
AddEventHandler('xakra_steal:CallDelStealingPlayers', function(steal_source)
    TriggerClientEvent('xakra_steal:DelStealingPlayers', -1, steal_source)
end)

RegisterServerEvent('xakra_steal:StealMoney')
AddEventHandler('xakra_steal:StealMoney', function(steal_source, amount)
    local _source = source
    local _steal_source = steal_source
    local StealCharacter = VorpCore.getUser(steal_source).getUsedCharacter
    local steal_money = StealCharacter.money

    if CheckLimit(_source, _steal_source, 'Money', amount) then
        StealCharacter.removeCurrency(0, amount)
        steal_money = StealCharacter.money - amount

        local Character = VorpCore.getUser(_source).getUsedCharacter
        Character.addCurrency(0, amount)

        VorpCore.NotifyAvanced(_source, T.StealMoney .. ' ' .. amount .. "$", "menu_textures", "log_gang_bag", "COLOR_PURE_WHITE", 2000)

        DiscordLog(string.format(T.WebhooksLang.DiscordStealMoney, amount, GetPlayerName(_source), GetPlayerName(_steal_source)))
    end

    TriggerClientEvent('xakra_steal:OpenMenu', _source, steal_money)
end)

RegisterServerEvent('xakra_steal:ReloadInventory')
AddEventHandler('xakra_steal:ReloadInventory', function(steal_source, player_source)
    local _steal_source = steal_source
    local _source
    if not player_source then
        _source = source
    else
        _source = player_source
    end

    local Character = VorpCore.getUser(_steal_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    local identifier = Character.identifier

    local inventory = {}

    TriggerEvent('vorpCore:getUserInventory', tonumber(_steal_source), function(getInventory)
        for _, item in pairs(getInventory) do
            local data_item = {
                count = item.count,
                name = item.name,
                limit = item.limit,
                type = item.type,
                label = item.label,
                metadata = item.metadata,
            }
            table.insert(inventory, data_item)
        end
    end)
    TriggerEvent('vorpCore:getUserWeapons', tonumber(_steal_source), function(getUserWeapons)
        for _, weapon in pairs(getUserWeapons) do
            local data_weapon = {
                count = -1,
                name = weapon.name,
                limit = -1,
                type = 'item_weapon',
                label = '',
                id = weapon.id,
            }
            table.insert(inventory, data_weapon)
        end
    end)

    local data = {
        itemList = inventory,
        action = 'setSecondInventoryItems',
    }
    TriggerClientEvent('vorp_inventory:ReloadstealInventory', _source, json.encode(data))
end)

RegisterServerEvent('xakra_steal:OpenInventory')
AddEventHandler('xakra_steal:OpenInventory', function(steal_source)
    local _source = source
    local Character = VorpCore.getUser(steal_source).getUsedCharacter

    TriggerClientEvent('vorp_inventory:OpenstealInventory', _source, T.MenuTitle, Character.charIdentifier)
end)

RegisterServerEvent('syn_search:MoveTosteal')
AddEventHandler('syn_search:MoveTosteal', function(obj)
    local _source = source
    TriggerClientEvent('xakra_steal:GetSourceSteal', _source, obj, 'move')
end)

RegisterServerEvent('xakra_steal:MoveTosteal')
AddEventHandler('xakra_steal:MoveTosteal', function(obj, steal_source)
    local _steal_source = steal_source
    local _source = source

    local decode_obj = json.decode(obj)
    decode_obj.number = tonumber(decode_obj.number)

    if decode_obj.type == 'item_standard' and decode_obj.number > 0 and decode_obj.number <= tonumber(decode_obj.item.count) then
        local canCarrys = exports.vorp_inventory:canCarryItems(_steal_source, decode_obj.number)
        local canCarry = exports.vorp_inventory:canCarryItem(_steal_source, decode_obj.item.name, decode_obj.number)
        if canCarrys and canCarry then
            exports.vorp_inventory:subItem(_source, decode_obj.item.name, decode_obj.number, decode_obj.item.metadata)
            exports.vorp_inventory:addItem(_steal_source, decode_obj.item.name, decode_obj.number, decode_obj.item.metadata)
            Wait(100)
            TriggerEvent('xakra_steal:ReloadInventory', _steal_source, _source)
            DiscordLog(string.format(T.WebhooksLang.DiscordMoveItem, decode_obj.number, decode_obj.item.label, GetPlayerName(_source), GetPlayerName(_steal_source)))
        else
            VorpCore.NotifyObjective(_source, T.NotStealCarryItems, 4000)
        end
    elseif decode_obj.type == 'item_weapon' then
        local canCarry = exports.vorp_inventory:canCarryWeapons(_steal_source, 1)
        if canCarry then
            -- exports.vorp_inventory:subWeapon(_source, decode_obj.item.id)
            exports.vorp_inventory:giveWeapon(_steal_source, decode_obj.item.id, _source)
            Wait(100)
            TriggerEvent('xakra_steal:ReloadInventory', _steal_source, _source)
            DiscordLog(string.format(T.WebhooksLang.DiscordMoveWeapon, decode_obj.item.label, GetPlayerName(_source), GetPlayerName(_steal_source)))
        else
            VorpCore.NotifyObjective(_source, T.NotStealCarryWeapon, 4000)
        end
    end
end)

RegisterServerEvent('syn_search:TakeFromsteal')
AddEventHandler('syn_search:TakeFromsteal', function(obj)
    local _source = source
    TriggerClientEvent('xakra_steal:GetSourceSteal', _source, obj, 'take')
end)

RegisterServerEvent('xakra_steal:TakeFromsteal')
AddEventHandler('xakra_steal:TakeFromsteal', function(obj, steal_source)
    local _steal_source = steal_source
    local _source = source

    local decode_obj = json.decode(obj)
    decode_obj.number = tonumber(decode_obj.number)

    local inblacklist = false
    for _, item in pairs(Config.ItemsBlackList) do
        if item == decode_obj.item.name then
            inblacklist = true
            VorpCore.NotifyObjective(_source, T.ItemInBlackList, 4000)
        end
    end

    if decode_obj.type == 'item_standard' and not inblacklist and decode_obj.number > 0 and decode_obj.number <= tonumber(decode_obj.item.count) then
        if not CheckLimit(_source, _steal_source, 'Items', decode_obj.number) then
            return
        end

        local canCarrys = exports.vorp_inventory:canCarryItems(_source, decode_obj.number)
        local canCarry = exports.vorp_inventory:canCarryItem(_source, decode_obj.item.name, decode_obj.number)
        if canCarrys and canCarry then
            exports.vorp_inventory:subItem(_steal_source, decode_obj.item.name, decode_obj.number, decode_obj.item.metadata)
            exports.vorp_inventory:addItem(_source, decode_obj.item.name, decode_obj.number, decode_obj.item.metadata)
            Wait(100)
            TriggerEvent('xakra_steal:ReloadInventory', _steal_source, _source)
            DiscordLog(string.format(T.WebhooksLang.DiscordStealItem, decode_obj.number, decode_obj.item.label, GetPlayerName(_source), GetPlayerName(_steal_source)))
        else
            VorpCore.NotifyObjective(_source, T.NotCarryItems, 4000)
        end
    elseif decode_obj.type == 'item_weapon' and not inblacklist then
        if not CheckLimit(_source, _steal_source, 'Weapons', 1) then
            return
        end

        local canCarry = exports.vorp_inventory:canCarryWeapons(_source, 1)
        if canCarry then
            -- exports.vorp_inventory:subWeapon(_steal_source, decode_obj.item.id)
            exports.vorp_inventory:giveWeapon(_source, decode_obj.item.id, _steal_source)
            Wait(100)
            TriggerEvent('xakra_steal:ReloadInventory', _steal_source, _source)
            DiscordLog(string.format(T.WebhooksLang.DiscordStealWeapon, decode_obj.item.label, GetPlayerName(_source), GetPlayerName(_steal_source)))
        else
            VorpCore.NotifyObjective(_source, T.NotCarryWeapon, 4000)
        end
    end
end)

RegisterServerEvent('xakra_steal:CloseInventory')
AddEventHandler('xakra_steal:CloseInventory', function(steal_source)
    local _source = source
    exports.vorp_inventory:closeInventory(_source)
end)

local PlayersLimit = {}

function CheckLimit(source, steal_source, Limit, amount)
    if Config.Limit[Limit] then
        local Character = VorpCore.getUser(steal_source).getUsedCharacter

        if not PlayersLimit[Character.charIdentifier] then
            PlayersLimit[Character.charIdentifier] = {
                Money = 0,
                Weapons = 0,
                Items = 0,
            }
        end

        if (PlayersLimit[Character.charIdentifier][Limit] + amount) > Config.Limit[Limit] then
            VorpCore.NotifyObjective(source, T.Limit .. ' ' .. PlayersLimit[Character.charIdentifier][Limit] .. '/' .. Config.Limit[Limit], 4000)
            DiscordLog(string.format(T.WebhooksLang.DiscordStealLimit, Limit, GetPlayerName(source), PlayersLimit[Character.charIdentifier][Limit], Config.Limit[Limit]))
            return false
        end

        PlayersLimit[Character.charIdentifier][Limit] = PlayersLimit[Character.charIdentifier][Limit] + amount

        return true
    end

    return true
end

function DiscordLog(message)
	if Config.Webhook.UseWebhook then
		VorpCore.AddWebhook(
			Config.Webhook.WebhookTitle,
			Config.Webhook.WebhookUrl,
			message,
			Config.Webhook.WebhookColor,
			Config.Webhook.WebhookName,
			Config.Webhook.WebhookLogo,
			Config.Webhook.WebhookLogoFooter,
			Config.Webhook.WebhookAvatar
		)
	end
end
