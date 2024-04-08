---------Pulling Essnetials----------------------
local VORPInv = {}
VORPInv = exports.vorp_inventory:vorp_inventoryApi()
local bccUtils = exports['bcc-utils'].initiate()

--Registering item as usable
CreateThread(function()
    for key, v in pairs(Config.DrugItems) do
      VORPInv.RegisterUsableItem(v.name, function(data)
        VORPInv.subItem(data.source, v.name, 1)
        local _source = data.source
        if Config.RandomDrugChance then
            if math.random(1, 4) == 1 then
                TriggerClientEvent('bcc-acidtrip:Open', _source)
            else
                TriggerClientEvent('bcc-acidtrip:ScreenEffectOnly', _source, v.effectime)
            end
        else
            TriggerClientEvent('bcc-acidtrip:Open', _source)
        end
      end)
    end
end)

--This handles the version check
bccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-acidtrip')