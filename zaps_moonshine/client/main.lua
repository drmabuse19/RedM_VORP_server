CreateThread(function()
    while true do
        local wa = 3000
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        local isNearStill = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, joaat(Config.brewProp), true)
        local isNearBarrel = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, joaat(Config.mashProp), true)
        local stillEntity = GetClosestObjectOfType(x, y, z, 1.5, joaat(Config.brewProp), false, false, false)
        local damageHealth = GetObjectFragmentDamageHealth(stillEntity, true)

        if isNearStill and damageHealth > 0.38533836603165  then
            wa = 3  
            DrawTxt(Config.Translation.createAlcohol, 0.50, 0.75, 1.9, 0.5, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0xCEFD9220) then
                TriggerEvent('moonshine:brewAlcohol')
            end
            DrawTxt(Config.Translation.destroyStill, 0.50, 0.85, 0.7, 0.5, true, 255, 0, 0, 255, true)
            if IsControlJustReleased(0, 0x3B24C470) then  -- Assuming 0x3FEF770D corresponds to the "F" key
                print("still: Debug")
                TriggerEvent('moonshine:destroyStill')
                
            end        
        elseif isNearBarrel then
            wa = 3  
            DrawTxt(Config.Translation.createMash, 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then
                print("Mash: Debug")
                TriggerEvent('moonshine:createMash')
            end
        end
        Citizen.Wait(wa)
    end
end)

RegisterNetEvent('moonshine:brewAlcohol')
AddEventHandler('moonshine:brewAlcohol', function()
    Citizen.CreateThread(function()
while not HasAnimDictLoaded('script_re@moonshine_camp@player_put_in_herbs') do
    RequestAnimDict('script_re@moonshine_camp@player_put_in_herbs')
    Citizen.Wait(100)
end

local animDict = "script_re@moonshine_camp@player_put_in_herbs"
local animName = "put_in_still" 
TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
Citizen.Wait(Config.brewTime)
local chanceOfExplosion = Config.Brewing.FailureRate 
local randomNumber = math.random()
if randomNumber <= chanceOfExplosion then
    TriggerExplosion()
else
    TriggerServerEvent('moonshine:server:brew')
end
    end)
end)
RegisterNetEvent('moonshine:createMash')
AddEventHandler('moonshine:createMash', function()
    Citizen.CreateThread(function()
        Citizen.Wait(Config.mashTime)
    end)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

RegisterNetEvent('moonshine:destroyStill')
AddEventHandler('moonshine:destroyStill', function()
    while not HasAnimDictLoaded('mini_games@story@beechers@build_floor@john') do
        RequestAnimDict('mini_games@story@beechers@build_floor@john')
        Citizen.Wait(100)
    end

    local animDict = "mini_games@story@beechers@build_floor@john"
local animName = "intro_pickup" 
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local stillObj = GetClosestObjectOfType(x, y, z, 1.5, joaat(Config.brewProp), false, false, false)
    if stillObj and stillObj ~= 0 then
       TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
Wait(2000)
        SetEntityAsMissionEntity(stillObj, true, true)
        DeleteEntity(stillObj)
    end
end)

RegisterNetEvent('moonshine:client:placeStill')
AddEventHandler('moonshine:client:placeStill', function()
 
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local forward = GetEntityForwardVector(playerPed)
    local x, y, z = table.unpack(pos + forward * 2) 

    local object = CreateObject(joaat(Config.brewProp), x, y, z, true, false, true)  
    SetEntityHeading(object, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(object)
end)

RegisterCommand('placestill', function()
TriggerEvent('moonshine:client:placeStill')

end, false)


function TriggerExplosion()
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed, false))

    AddExplosion(x, y, z, 1, 1.0, true, false, 1.0)
end

