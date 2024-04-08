local VorpCore
local VorpInv


TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VorpInv = exports.vorp_inventory:vorp_inventoryApi()


local TEXTS = Config.Texts

RegisterServerEvent('ricx_shopsell:sell')
AddEventHandler('ricx_shopsell:sell', function(label, name, price)
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter

    local _itemname = tostring(name)
    local _price = tonumber(price)

    local count = VorpInv.getItemCount(_source,_itemname)

    local _label = tostring(label) 

    local sellprice 

    if count == 0 then
        TriggerClientEvent("Notification:left_sellshop", _source, TEXTS.NotifTitle, TEXTS.DontHave.." ".._label.." "..TEXTS.ToSell, 'menu_textures', 'stamp_locked_rank', 2000)
        return
    end
    if count >= 1 then
      
        VorpInv.subItem(_source, _itemname, count)

        sellprice = _price*count

        Character.addCurrency(0, sellprice)

        TriggerClientEvent("Notification:left_sellshop", _source, TEXTS.NotifTitle, TEXTS.YouSold.." ".._label.." ("..count..")".."\n~COLOR_GOLD~+$"..sellprice, "scoretimer_textures", "scoretimer_generic_tick", 2000)
    else
        TriggerClientEvent("Notification:left_sellshop", _source, TEXTS.NotifTitle, TEXTS.DontHave.." ".._label.." "..TEXTS.ToSell, 'menu_textures', 'stamp_locked_rank', 2000)
    end
end)