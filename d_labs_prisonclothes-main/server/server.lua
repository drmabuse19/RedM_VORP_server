
FrameWork = Config.FrameWork

local RSGCore
local VORP
local VorpCore
local VorpInv


if FrameWork == 'RSG' then  
    RSGCore = exports['rsg-core']:GetCoreObject() 
elseif FrameWork == 'VORP' then
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)
    VorpInv = exports.vorp_inventory:vorp_inventoryApi()  
else -- Custom Framework


end


if FrameWork == 'VORP' then  
    VorpInv.RegisterUsableItem(Config.Item, function(data)
        TriggerClientEvent("d-labs:c:setclothes",data.source)
    end)
elseif FrameWork == 'RSG' then   
    RSGCore.Functions.CreateUseableItem(Config.Item, function(source, item)
        TriggerClientEvent("d-labs:c:setclothes",source)
    end)
else 
    -- Custom Create usable item
    print("You don't have the item logic set up please go to > Server > Server and set up the administrative logic that calls the usable item")


end
