----------------------------MENU------------------------------------
MenuData = {}
if Config.framework == "rsg" then
    TriggerEvent("rsg-menubase:getData",function(call)
        MenuData = call
end)
elseif Config.framework == "redemrp" then
    TriggerEvent("redemrp_menu_base:getData",function(call)
        MenuData = call
end)
end
----------------------------END MENU---------------------------------
local TEXTS = Config.Texts
local menuOpen = false 

RegisterCommand("emotes",function(src,args,raw)
    TriggerEvent("redm_emotes:menu")
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("redm_emotes:sub_menu", function(val)
    MenuData.CloseAll()
    menuOpen = true
    local elements = {}

    for i,v in pairs(Config.Emotes[val]) do 
        elements[i] = {label = v[1], value = v[2], desc = "Play Emote"}
    end 

    MenuData.Open('default', GetCurrentResourceName(), 'menu_id',{
         title    = "Emotes",
         subtext    = TEXTS[val],
         align    = "top-right",
         elements = elements,
     },
     function(data, menu)
        if data.current.value then 
            if Citizen.InvokeNative(0xCF9B71C0AF824036, PlayerPedId(),1) then 
                Citizen.InvokeNative(0xBDFEEB7600BCD938, PlayerPedId())
                Wait(1000)
            end
            Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(),1,2, data.current.value,0,0,0,0,0)
        end
     end,
     function(data, menu)
        TriggerEvent("redm_emotes:menu")
     end)
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("redm_emotes:menu", function()
    MenuData.CloseAll()
    menuOpen = true
    local elements = {}

    for i,v in pairs(Config.Emotes) do 
        elements[#elements+1] = {label = TEXTS[i], value = i, desc = "Open Category"}
    end 

    MenuData.Open('default', GetCurrentResourceName(), 'redm_emotes_menu',{
         title    = "Emotes",
         subtext    = "Categories",
         align    = "top-right",
         elements = elements,
     },
     function(data, menu)
        if data.current.value then 
            TriggerEvent("redm_emotes:sub_menu", data.current.value)
        end
     end,
     function(data, menu)
        menuOpen = false
        menu.close()
     end)
end)
--------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if menuOpen then 
        MenuData.CloseAll()
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
