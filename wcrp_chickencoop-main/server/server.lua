VORP = exports.vorp_inventory:vorp_inventoryApi()



RegisterServerEvent('wcrpgathering:eggs')
AddEventHandler("wcrpgathering:eggs", function()
    local _source = source
      
    TriggerClientEvent('wcrpgathering:eggs', _source)

    Wait(27000)
        
    VORP.addItem(_source, "egg", 2)
        

    Wait(200)

    TriggerClientEvent("vorp:TipBottom", _source, "You Gathered some Eggs", 4000)

    
end)

