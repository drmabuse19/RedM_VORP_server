if GetResourceState('vorp_core') ~= 'missing' then
    vorp = false 
else 
    vorp = true
end
if vorp then 
local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)
else 
    
end


if GetResourceState('redem_roleplay') ~= 'missing' then
    redem = false
else 
    Core = exports["redem_roleplay"]:RedEM()
    redem = true
end
