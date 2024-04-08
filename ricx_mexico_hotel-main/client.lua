----------------------------REDEMRP_MENU----------------------------
MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)
----------------------------END REDEMRP_MENU----------------------------
local TEXTS = Config.Texts 
local TEXTURES = Config.Textures
local menuOpen = false 

local pcoords = nil 
local isdead = nil

local BlipEntities

local PromptKey 
local PromptGroup = GetRandomIntInRange(0, 0xffffff)

local prompts = {}

function TableNum(tbl) 
    local c = 0
    for i,v in pairs(tbl) do 
        c = c + 1
    end
    return c
end

function LoadPrompts()
    local str = TEXTS.Enter
    PromptKey = PromptRegisterBegin()
    PromptSetControlAction(PromptKey, Config.Prompts.Enter)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(PromptKey, str)
    PromptSetEnabled(PromptKey, 1)
    PromptSetVisible(PromptKey, 1)
	PromptSetStandardMode(PromptKey,1)
	PromptSetGroup(PromptKey, PromptGroup)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,PromptKey,true)
	PromptRegisterEnd(PromptKey)
    prompts[#prompts+1] = PromptKey
end

Citizen.CreateThread(function()
    for i, v in pairs(Config.Coords) do
        if v.blip.enable == true then
            local sprite = v.blip.sprite
            BlipEntities[i] = N_0x554d9d53f696d002(1664425300, v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(BlipEntities[i], sprite, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, BlipEntities[i], "Blip:"..v.name)
        end
    end  
    LoadPrompts()
    while true do 
        Citizen.Wait(500)
        pcoords = GetEntityCoords(PlayerPedId())
        isdead = IsEntityDead(PlayerPedId())
    end
end)

Citizen.CreateThread(function()
    while true do
        local t = 5 
        if pcoords ~= nil and (isdead ~= nil and isdead == false) and menuOpen == false then 
            for i,v in pairs(Config.DoorPairs) do 
                local dist = #(pcoords-v[1])
                local dist2 = #(pcoords-v[2])
                if dist < 5.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v[1].x, v[1].y, v[1].z-0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.3, 126, 0, 0, 255, 0, 0, 2, 0, 0, 0, 0)
                end
                if dist2 < 2.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v[2].x, v[2].y, v[2].z-0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.3, 126, 0, 0, 255, 0, 0, 2, 0, 0, 0, 0)
                end
                if dist < 0.9 then 
                    local label  = CreateVarString(10, 'LITERAL_STRING', "Mexicana Hotel".." "..v[3])
                    PromptSetActiveGroupThisFrame(PromptGroup, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE,PromptKey) then
                        local h = GetEntityHeading(PlayerPedId())
                        Citizen.Wait(100)
                        SetEntityCoords(PlayerPedId(), v[2].x, v[2].y, v[2].z-0.9)
                        SetEntityHeading(PlayerPedId(), h)
                        Citizen.Wait(2000)
                    end
                end
                if dist2 < 0.9 then 
                    local label  = CreateVarString(10, 'LITERAL_STRING', "Mexicana Hotel".." "..v[3])
                    PromptSetActiveGroupThisFrame(PromptGroup, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE,PromptKey) then
                        local h = GetEntityHeading(PlayerPedId())
                        Citizen.Wait(100)
                        SetEntityCoords(PlayerPedId(), v[1].x, v[2].y, v[1].z-0.9)
                        SetEntityHeading(PlayerPedId(), h)
                        Citizen.Wait(2000)
                    end
                end
            end
        else
            t = 1500
        end
        Citizen.Wait(t)
    end
end)