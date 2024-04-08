local VORPcore = {}
TriggerEvent("getCore", function(core)
	VORPcore = core
end)

local VORPInv = exports.vorp_inventory:vorp_inventoryApi()

for _, v in pairs(Config.PocketWatches) do
	VORPInv.RegisterUsableItem(v.item, function(data)
		VORPInv.CloseInv(data.source)
		TriggerClientEvent('xakra_pocketwatch:PocketWatch', data.source, v)
	end)
end