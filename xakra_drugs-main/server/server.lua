local VORPcore = {}
TriggerEvent("getCore", function(core)
	VORPcore = core
end)

local VORPInv = {}
VORPInv = exports.vorp_inventory:vorp_inventoryApi()

VORPInv.RegisterUsableItem(Config.Joint, function(data)
	VORPInv.CloseInv(data.source)

	VORPInv.subItem(data.source, Config.Joint, 1)

	TriggerClientEvent("vorpmetabolism:changeValue", data.source, "Hunger", -200)   -- Establecer la sed.

	TriggerClientEvent('xakra_drugs:JointAnim', data.source)
end)

VORPInv.RegisterUsableItem(Config.Opium, function(data)
	VORPInv.CloseInv(data.source)

	local itemCount = VORPInv.getItemCount(data.source, Config.OpiumPipe)
	if itemCount >= 1 then
		VORPInv.subItem(data.source, Config.Opium, 1)
		TriggerClientEvent('xakra_drugs:Opium', data.source)
	else
		VORPcore.NotifyLeft(data.source, Config.OpiumTxt['Opium'], Config.OpiumTxt['NeedPipe'], 'generic_textures', 'lock', 3000, "COLOR_PURE_WHITE")
	end
end)

VORPInv.RegisterUsableItem(Config.Mushroom, function(data)
	VORPInv.CloseInv(data.source)

	VORPInv.subItem(data.source, Config.Mushroom, 1)

	TriggerClientEvent('xakra_drugs:Mushroom', data.source)
end)