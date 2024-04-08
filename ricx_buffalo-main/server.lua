
 
ServerFramework = "vorp" -- "redemrp" or "vorp" or "qbr" or "qbr2" or "rsg" or "redemrp-reboot"

local VorpCore, QRCore, RSGCore, RedEM
if ServerFramework == "vorp" then
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)
elseif ServerFramework == "redemrp-reboot" then
    RedEM = exports["redem_roleplay"]:RedEM()
elseif ServerFramework == "qbr2" then
    QRCore = exports["qr-core"]:GetCoreObject()
elseif ServerFramework == "rsg" then
    RSGCore = exports["rsg-core"]:GetCoreObject()
end

ServerRents = {
    [1] = {
        name = "Hearthlands Buffalo",
        price = 100,
    },
    [2] = {
        name = "New Austin Buffalos",
        price = 50,
    },
}

RegisterServerEvent("ricx_buffalo:check_rent")
AddEventHandler("ricx_buffalo:check_rent", function(id)
	local _source = source
    local _id = tonumber(id)
    local price = ServerRents[_id].price
    if ServerFramework == "redemrp" then
        TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
            local money = user.getMoney()
            if money >= price then 
                user.removeMoney(price)
                TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
            else
                return
            end
        end)
    elseif ServerFramework == "redemrp-reboot" then
        local Player = RedEM.GetPlayer(_source)
	if Player.money >= price then 
                Player.RemoveMoney(price)
		TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
	else
                return	
	end
    elseif ServerFramework == "qbr2" then
        local User = QRCore.Functions.GetPlayer(_source)
	if User.PlayerData.money.cash >= price then 
                User.Functions.RemoveMoney("cash", price, "RicX Buffalo: Remove Money")
		TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
	else
                return	
	end	
    elseif ServerFramework == "rsg" then
        local User = RSGCore.Functions.GetPlayer(_source)
	if User.PlayerData.money.cash >= price then 
                User.Functions.RemoveMoney("cash", price, "RicX Buffalo: Remove Money")
		TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
	else
                return	
	end		
    elseif ServerFramework == "vorp" then
        local Character = VorpCore.getUser(_source).getUsedCharacter
        local money = Character.money
        if money >= price then 
            Character.removeCurrency(0 , tonumber(price))
            TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
        else
            return
        end
    elseif ServerFramework == "qbr" then
        local User = exports['qbr-core']:GetPlayer(_source)
        local money = User.Functions.GetMoney("cash")
        if money >= price then 
	    User.Functions.RemoveMoney("cash", tonumber(price), "desc")
            TriggerClientEvent("ricx_buffalo:rented_buffalo", _source)
        else
            return
        end
    end
end)
