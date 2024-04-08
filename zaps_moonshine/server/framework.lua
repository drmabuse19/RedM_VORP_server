if GetResourceState('vorp_core') ~= 'missing' then
    vorp = true 
else 
    vorp = false 
end
if vorp then 
local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)
Inventory = exports.vorp_inventory:vorp_inventoryApi()
    print('Framework: VORP')
end

if GetResourceState('redem_roleplay') ~= 'missing' then
    Core = exports["redem_roleplay"]:RedEM()
    redem = true

else
    redem = false 
end
