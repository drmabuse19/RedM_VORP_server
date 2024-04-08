VORP = exports.vorp_inventory:vorp_inventoryApi()



VORP.RegisterUsableItem("fan", function(data)
	TriggerClientEvent('prop:fan', data.source)
end)


