local VorpCore = {}
local VorpInv
local data = {}


if Config.vorp then
    Citizen.CreateThread(function()
        Wait(500)
        TriggerEvent("getCore",function(core)
            VorpCore = core
        end)
        VorpInv = exports.vorp_inventory:vorp_inventoryApi()

        VorpInv.RegisterUsableItem("parasol", function(data)
        
            TriggerClientEvent("vorp:TipRight", data.source, "You're using parasol", 5000)
            TriggerClientEvent('ricx_parasol:start',data.source)
        end)
    end)


          
elseif Config.redm then

    TriggerEvent("redemrp_inventory:getData",function(call)
        data = call
    end)

    RegisterServerEvent("RegisterUsableItem:parasol")
    AddEventHandler("RegisterUsableItem:parasol", function(source)
        TriggerClientEvent('ricx_parasol:start', source)
    end)
end   
