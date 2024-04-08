MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local TEXTS = Config.Texts

local ShopPrompt
local ShopGroup = GetRandomIntInRange(0, 0xffffff)
local IsShop = false
local blips = {}
local coords = nil

function SetupPeltPrompt()
    local str = TEXTS.Sellitems
    ShopPrompt = PromptRegisterBegin()
    PromptSetControlAction(ShopPrompt, 0x39336A4F)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(ShopPrompt, str)
    PromptSetEnabled(ShopPrompt, 1)
    PromptSetVisible(ShopPrompt, 1)
    PromptSetStandardMode(ShopPrompt,1)
    PromptSetGroup(ShopPrompt, ShopGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C,ShopPrompt,true)
    PromptRegisterEnd(ShopPrompt)

    for i, v in pairs(Config.SellShops) do
        if v.blip then
            blips[i] = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
            SetBlipSprite(blips[i], v.sprite, 1)
            SetBlipScale(blips[i], 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, blips[i], v.name)
        end
    end  
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        coords = GetEntityCoords(PlayerPedId())
    end
end)

Citizen.CreateThread(function() --
    SetupPeltPrompt()
    while true do
        Citizen.Wait(4)
        if coords ~= nil then
            if IsShop == false and not IsEntityDead(PlayerPedId()) then
                for i, v in pairs(Config.SellShops) do
                    if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x,v.y,v.z,true) < 2.0)  then
                        local label  = CreateVarString(10, 'LITERAL_STRING', v.name)
                        PromptSetActiveGroupThisFrame(ShopGroup, label)
                        if Citizen.InvokeNative(0xC92AC953F0A982AE,ShopPrompt) then
                            TriggerEvent("ricx_sellshop:open",i)
                        end
                    end
                end
            end
        end
    end
end)


RegisterNetEvent("ricx_sellshop:open")
AddEventHandler("ricx_sellshop:open", function(id)
    MenuData.CloseAll()
    TaskStandStill(PlayerPedId(), -1)
    IsShop = true
    local elements = {}

    for i,v in pairs(Config.sellItems[id]) do
        elements[i] = {label = v[1].." $"..v[3], value = "item"..i, desc = TEXTS.Sellitem, info = v}
    end

    MenuData.Open('default', GetCurrentResourceName(), 'sellshop'..id,{
        title    = Config.SellShops[id].name,
        subtext    = TEXTS.Selectsell,
        align    = 'top-'..Config.MenuPos,
        elements = elements,
    },
    function(data, menu)
        TriggerServerEvent("ricx_shopsell:sell", data.current.info[1], data.current.info[2], data.current.info[3])
    end,
    function(data, menu)
        menu.close()
        ClearPedTasksImmediately(PlayerPedId())
        IsShop = false
    end)
end)
------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if IsShop == true then
        ClearPedTasksImmediately(PlayerPedId())
        MenuData.CloseAll()
    end
    for i, v in pairs(blips) do
        RemoveBlip(v)
    end
    blips = {}
end)
--Notification
------------------------------------
RegisterNetEvent('Notification:left_sellshop')
AddEventHandler('Notification:left_sellshop', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if txtr ~= nil then
        exports.ricx_sellshops_vorp.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.ricx_sellshops_vorp.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)
