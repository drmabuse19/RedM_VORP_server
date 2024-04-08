TriggerEvent("getCore", function(core)
	VorpCore = core
end)


RegisterServerEvent('wvrp_bountyhunting:AddSomeMoney')
AddEventHandler('wvrp_bountyhunting:AddSomeMoney', function()
local _source = source
local Character = VorpCore.getUser(_source).getUsedCharacter

Character.addCurrency(0,10
)
end)

