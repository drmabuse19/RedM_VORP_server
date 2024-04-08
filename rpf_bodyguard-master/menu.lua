-- RPFSTUDIO BODYGUARD 1.0 WIP

-- Blips på kartet
local blips = {
   {title="Valentine", id=1560611276, x=-360.20, y=740.00, z=116.00},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = Citizen.InvokeNative(0x554D9D53F696D002, info.id, info.x, info.y, info.z)
    end      
end)

-- Klesbutikk
Citizen.CreateThread(function()
    WarMenu.CreateMenu('guard', "Leibvakt")
    WarMenu.SetSubTitle('guard', 'Lei tjenesten hans')
    WarMenu.CreateSubMenu('ped', 'guard', 'Leibvakt')

    while true do
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('guard') then
            if WarMenu.MenuButton('Er tilgjengelig', 'ped') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('ped') then
            if WarMenu.Button('Kall for 2 $') then
                TriggerServerEvent("buy:guard", 2) 
            end

            WarMenu.Display()
        elseif (Vdist(coords.x, coords.y, coords.z, -360.20, 740.00, 116.00) < 2.0) then
               TriggerEvent("enter:guard")
               if IsControlJustReleased(0, 0xC7B5340A) then
                WarMenu.OpenMenu('guard')
               end
        end
        Citizen.Wait(0)
    end
end)

-- Tilbakemelding for når du ikke har nok penger
RegisterNetEvent('cancel')
AddEventHandler('cancel', function()
    SetTextScale(0.5, 0.5)
    local msg = "Du har ikke nok penger!!!"
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

-- Tilbakemelding for å åpne meny
RegisterNetEvent('enter:guard')
AddEventHandler('enter:guard', function()
    SetTextScale(0.5, 0.5)
    local msg = "Trykk Enter for å åpne menyen"
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

-- Laster inn leibvakt
RegisterNetEvent('loadguard')
AddEventHandler('loadguard', function() 
   TriggerEvent("bart", true)
end)

-- Lager NPC
local function PerformRequest(hash)
    print("forespør modell " .. hash)

    RequestModel(hash, 0)

    local times = 1
    print("forespurt " .. times .. " ganger")

    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0)

        times = times + 1
        print("forespurt " .. times .. " ganger")

        Citizen.Wait(0)
        
        if times >= 100 then break end
    end
end
        
function lePlayerModel(name)
    local model = GetHashKey(name)
    local player = PlayerId()
    
    if not IsModelValid(model) then return end
    PerformRequest(model)
    
    if HasModelLoaded(model) then
        Citizen.InvokeNative(0xED40380076A31506, player, model, false)
        Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
        SetModelAsNoLongerNeeded(model)
    end
end

RegisterNetEvent('bart')
AddEventHandler('bart', function(source, args) 
    CreateThread(function()
        local model = `mp_male`
        PerformRequest(model)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 0))
        bart = CreatePed(model, x+2, y+2, z, 0.0, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, bart, true)
        
        SetPedOutfitPreset(bart, 38)
        Citizen.Wait(500)
        SetPedAsCharacter(bart, "bart")
        Citizen.Wait(500)
        
        PerformRequest("w_shotgun_doublebarrel01")
        GiveWeapon(bart, "WEAPON_SHOTGUN_DOUBLEBARREL", 500, false, 1, false, 0.0)
        SetModelAsNoLongerNeeded("w_shotgun_doublebarrel01")
        
        Citizen.Wait(500)
        
        SetPedAsGroupMember(bart, GetPedGroupIndex(PlayerPedId()))
    end)
end)
