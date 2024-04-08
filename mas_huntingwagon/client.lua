local promptGroup = UipromptGroup:new("Hunting Wagon")
local promptGroup2 = UipromptGroup:new("Wagon Owner")
local stowPrompt = Uiprompt:new(`INPUT_RELOAD`, "Stow", promptGroup)
local takePrompt = Uiprompt:new(`INPUT_RELOAD`, "Take", promptGroup)
local askPrompt = Uiprompt:new(`INPUT_LOOT`, "Talk", promptGroup2)
local lastWagonId = 0
local rentBlip = {}
local NpcList = {}
stowPrompt:setHoldMode(true)
takePrompt:setHoldMode(true)

local function GetNumComponentsInPed(ped)
    return Citizen.InvokeNative(0x90403E8107B60E81, ped, Citizen.ResultAsInteger())
end

local function GetMetaPedAssetGuids(ped, index)
    return Citizen.InvokeNative(0xA9C28516A6DC9D56, ped, index, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
end

local function GetMetaPedAssetTint(ped, index)
    return Citizen.InvokeNative(0xE7998FEC53A33BBE, ped, index, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
end

local function SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    return Citizen.InvokeNative(0xBC6DF00D7A4A6819, ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
end

local function GetPedDamageCleanliness(ped)
    return Citizen.InvokeNative(0x88EFFED5FE8B0B4A, ped, Citizen.ResultAsInteger())
end

local function SetPedDamageCleanliness(ped, damageCleanliness)
    return Citizen.InvokeNative(0x7528720101A807A5, ped, damageCleanliness)
end

local function GetPedQuality(ped)
    return Citizen.InvokeNative(0x7BCC6087D130312A, ped)
end

local function SetPedQuality(ped, quality)
    return Citizen.InvokeNative(0xCE6B874286D640BB, ped, quality)
end

local function GetPedMetaOutfitHash(ped)
    return Citizen.InvokeNative(0x30569F348D126A5A, ped, Citizen.ResultAsInteger())
end

local function EquipMetaPedOutfit(ped, hash)
    return Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, hash)
end

local function UpdatePedVariation(ped)
    Citizen.InvokeNative(0xAAB86462966168CE, ped, true)                           -- UNKNOWN "Fixes outfit"- always paired with _UPDATE_PED_VARIATION
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false) -- _UPDATE_PED_VARIATION
end

local function IsEntityFullyLooted(entity)
    return Citizen.InvokeNative(0x8DE41E9902E85756, entity)
end

local function GetIsCarriablePelt(entity)
    return Citizen.InvokeNative(0x255B6DB4E3AD3C3E, entity)
end

local function GetCarriableFromEntity(entity)
    return Citizen.InvokeNative(0x31FEF6A20F00B963, entity)
end

local function GetFirstEntityPedIsCarrying(ped)
    return Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
end

local function SetBatchTarpHeight(vehicle, height, immediately)
    return Citizen.InvokeNative(0x31F343383F19C987, vehicle, height, immediately)
end

local function CalculateTarpHeight(totalItem)
    if not totalItem then return 0.0 end
    local num = totalItem / Config.MaxCargo
    local rounded_num = math.floor(num * 100 + 0.5) / 100
    return rounded_num
end

local function WagonCapaityText(totalItem)
    local capacity = CalculateTarpHeight(totalItem) * 100
    capacity = math.floor(capacity)
    local text = ""
    if capacity < 50 then
        text = "~COLOR_GREEN~" .. capacity .. "%"
    elseif capacity > 50 and capacity < 75 then
        text = "~COLOR_YELLOW~" .. capacity .. "%"
    elseif capacity > 75 and capacity < 90 then
        text = "~COLOR_ORANGE~" .. capacity .. "%"
    elseif capacity > 90 then
        text = "~COLOR_RED~" .. capacity .. "%"
    end
    return text
end

local function GetCarcassMetaTag(entity)
    local metatag = {}
    local numComponents = GetNumComponentsInPed(entity)
    for i = 0, numComponents - 1, 1 do
        local drawable, albedo, normal, material = GetMetaPedAssetGuids(entity, i)
        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(entity, i)
        metatag[i] = {
            drawable = drawable,
            albedo = albedo,
            normal = normal,
            material = material,
            palette = palette,
            tint0 = tint0,
            tint1 = tint1,
            tint2 = tint2
        }
        -- print(i, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    end
    return metatag
end

local function ApplyCarcasMetaTag(entity, metatag)
    if #metatag < 1 then return end
    -- TriggerEvent('table', metatag)
    for i = 0, #metatag, 1 do
        local data = metatag[i]
        SetMetaPedTag(entity, data.drawable, data.albedo, data.normal, data.material, data.palette, data.tint0, data.tint1, data.tint2)
        -- print(i, data.drawable, data.albedo, data.normal, data.material, data.palette, data.tint0, data.tint1, data.tint2)
    end
    UpdatePedVariation(entity)
end

local function IsItemStowable(model)
    if not Config.WagonCargo?[model] then
        print("Mistake? Screenshot This - nonstowable : " .. model)
        return false
    end
    return true
end

local function CreateWagonBlip(wagon)
    if GetBlipFromEntity(wagon) ~= 0 then return end
    local wagonBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, `BLIP_STYLE_MP_PLAYER`, wagon)
    SetBlipSprite(wagonBlip, `blip_mp_player_wagon`, true)
    SetBlipScale(wagonBlip, 1.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, wagonBlip, "Hunting Wagon") --SetBlipName
end

local function CreateRentBlip(x, y, z)
    blipId = Citizen.InvokeNative(0x554D9D53F696D002, `BLIP_STYLE_SHOP`, x, y, z)
    rentBlip[#rentBlip + 1] = blipId
    SetBlipSprite(blipId, `blip_shop_coach_fencing`, true)
    SetBlipScale(blipId, 1.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blipId, "Rent Hunting Wagon") --SetBlipName
end


AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for i = 1, #rentBlip do
            RemoveBlip(rentBlip[i])
        end
        for i = 1, #NpcList do
            DeleteEntity(NpcList[i])
        end
        promptGroup:delete()
        promptGroup2:delete()
    end
end)

AddStateBagChangeHandler("capacity", nil, function(bagName, key, value)
    local wagon = GetEntityFromStateBagName(bagName)
    local wagonId = Entity(wagon).state.wagonId
    if entity == 0 then return end
    local wagonText = string.format("Hunting Wagon | ~COLOR_BLUE~%s~s~ | %s", wagonId, WagonCapaityText(value))
    promptGroup:setText(wagonText)
end)

CreateThread(function()
    for i = 1, #Config.RentLocation do
        local data = Config.RentLocation[i]
        CreateRentBlip(data.ped.x, data.ped.y, data.ped.z)

        lib.requestModel(`u_m_m_story_emeraldranch_01`)
        local npc = CreatePed(`u_m_m_story_emeraldranch_01`, data.ped.x, data.ped.y, data.ped.z, data.ped.w, false, false)

        local point = lib.points.new({
            coords = vector3(data.ped.x, data.ped.y, data.ped.z),
            distance = 3,
        })
        function point:nearby()
            if self.currentDistance < 2 then
                promptGroup2:setActiveThisFrame()
                askPrompt:handleEvents(i)
            end
        end

        Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
        FreezeEntityPosition(npc, true)
        SetPedConfigFlag(npc, 169, true)
        SetPedConfigFlag(npc, 26, true)
        -- SetPedPromptName(npc, "Wagon Owner")
        NpcList[#NpcList+1] = npc
    end

    while true do
        local sleep = 2000
        local coords = GetEntityCoords(cache.ped)
        local carriedEntity = GetFirstEntityPedIsCarrying(cache.ped)
        local wagon, wagonCoords = lib.getClosestVehicle(coords, 3)
        if GetEntityModel(wagon) == `HUNTERCART01` then
            local wagonId = Entity(wagon).state.wagonId
            local capacity = Entity(wagon).state.capacity
            if wagonId then
                sleep = 1000
                local bootCoords = GetOffsetFromEntityInWorldCoords(wagon, 0.0, -2.3, 0.5)
                -- Citizen.InvokeNative(0x2A32FAA57B937173, 0x50638AB9, bootCoords.x, bootCoords.y, bootCoords.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 255, 0, 255, false, false, 0, false, false) --Debug
                local distance = #(coords - bootCoords)
                if not lastWagonId or lastWagonId ~= wagonId then
                    lastWagonId = wagonId
                    local wagonText = string.format("Hunting Wagon | ~COLOR_BLUE~%s~s~ | %s", wagonId, WagonCapaityText(capacity))
                    promptGroup:setText(wagonText)
                end
                if distance < 2.0 then
                    sleep = 5
                    promptGroup:setActiveThisFrame()
                    if carriedEntity and (not IsPedHuman(carriedEntity) or not IsEntityAPed(carriedEntity)) then
                        stowPrompt:setEnabledAndVisible(true)
                        takePrompt:setEnabledAndVisible(false)
                        stowPrompt:handleEvents(wagon, wagonId)
                    else
                        stowPrompt:setEnabledAndVisible(false)
                        takePrompt:setEnabledAndVisible(true)
                        takePrompt:handleEvents(wagon, wagonId)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    stowPrompt:setOnHoldModeJustCompleted(function(prompt, wagon, wagonId)
        local carriedEntity = GetFirstEntityPedIsCarrying(cache.ped)
        local carriedModel = GetEntityModel(carriedEntity)

        if not IsItemStowable(carriedModel) then
            return lib.notify({ description = "This thing can't be stowed", type = 'error' })
        end

        local isPelt = GetIsCarriablePelt(carriedEntity)
        local height = 0
        local offset = GetOffsetFromEntityInWorldCoords(wagon, 0.0, -2.7, 0.0)

        TaskTurnPedToFaceEntity(cache.ped, wagon, 100)
        lib.waitFor(function()
            if GetScriptTaskStatus(cache.ped, `SCRIPT_TASK_TURN_PED_TO_FACE_ENTITY`, true) == 8 then
                return 'ok'
            end
        end)

        local data = {
            model = carriedModel,
        }
        if isPelt then
            data.peltquality = GetCarriableFromEntity(carriedEntity)
        else
            data.metatag = GetCarcassMetaTag(carriedEntity)
            data.outfit = GetPedMetaOutfitHash(carriedEntity)
            data.skinned = IsEntityFullyLooted(carriedEntity) or false
            data.damage = GetPedDamageCleanliness(carriedEntity) or 0
            data.quality = GetPedQuality(carriedEntity) or 0
        end
        local totalItem, isFull = lib.callback.await('mas_huntingwagon:addWagonItem', false, NetworkGetNetworkIdFromEntity(wagon), wagonId, data)
        if isFull then return lib.notify({ description = "Wagon Full!", type = 'error' }) end
        height = CalculateTarpHeight(totalItem)

        TaskGoStraightToCoord(cache.ped, offset.x, offset.y, offset.z, 3.0, 1000, GetEntityHeading(wagon), 0)
        lib.waitFor(function() if GetScriptTaskStatus(cache.ped, `SCRIPT_TASK_GO_STRAIGHT_TO_COORD`, true) == 8 then return 'ok' end end)
        TaskPlaceCarriedEntityAtCoord(cache.ped, carriedEntity, GetEntityCoords(wagon), 1.0, 5)
        lib.waitFor(function() if GetScriptTaskStatus(cache.ped, `SCRIPT_TASK_PLACE_CARRIED_ENTITY_AT_COORD`, true) == 8 then return 'ok' end end)

        DeleteEntity(carriedEntity)
        SetBatchTarpHeight(wagon, height, false)
    end)
    takePrompt:setOnHoldModeJustCompleted(function(prompt, wagon, wagonId)
        local coords = GetEntityCoords(cache.ped)
        local height, cargo = 0, 0

        local totalItem, data = lib.callback.await('mas_huntingwagon:getWagonItem', false, NetworkGetNetworkIdFromEntity(wagon), wagonId)
        if totalItem == -1 then return lib.notify({ description = 'Wagon empty', type = 'error' }) end
        height = CalculateTarpHeight(totalItem)
        lib.requestModel(data.model)
        if IsModelAPed(data.model) then
            cargo = CreatePed(data.model, coords.x, coords.y, coords.z, 0, true, true)
            SetEntityHealth(cargo, 0, cache.ped)
            SetPedQuality(cargo, data.quality)
            SetPedDamageCleanliness(cargo, data.damage)
            if data.skinned then
                SetTimeout(1000, function()
                    Citizen.InvokeNative(0x6BCF5F3D8FFE988D, cargo, true) --SetEntityFullyLooted
                    ApplyCarcasMetaTag(cargo, data.metatag)
                end)
            else
                EquipMetaPedOutfit(cargo, data.outfit)
                UpdatePedVariation(cargo)
            end
        else
            cargo = CreateObject(data.model, coords.x, coords.y, coords.z, true, true, true, 0, 0)
            Citizen.InvokeNative(0x78B4567E18B54480, cargo)                                                                        -- MakeObjectCarriable
            Citizen.InvokeNative(0xF0B4F759F35CC7F5, cargo, Citizen.InvokeNative(0x34F008A7E48C496B, cargo, 0), cache.ped, 7, 512) -- TaskCarriable
            Citizen.InvokeNative(0x399657ED871B3A6C, cargo, data.peltquality)                                                      -- SetEntityCarcassType https://pastebin.com/C1WvQjCy
        end

        Citizen.InvokeNative(0x18FF3110CF47115D, cargo, 21, true) --SetEntityCarryingFlag
        TaskPickupCarriableEntity(cache.ped, cargo)
        SetEntityVisible(cargo, false)
        FreezeEntityPosition(cargo, true)

        lib.waitFor(function()
            if GetScriptTaskStatus(cache.ped, `SCRIPT_TASK_PICKUP_CARRIABLE_ENTITY`, true) == 8 then
                return 'ok'
            end
        end)

        FreezeEntityPosition(cargo, false)
        SetEntityVisible(cargo, true)
        Citizen.InvokeNative(0x18FF3110CF47115D, cargo, 21, false) --SetEntityCarryingFlag
        SetBatchTarpHeight(wagon, height, false)
    end)
    askPrompt:setOnControlJustReleased(function(prompt, index)
        RentMenu(index)
    end)
end)

RegisterNetEvent('mas_huntingwagon:client:setBlip', function()
    local wagonNetId = lib.callback.await("mas_huntingwagon:getHuntingWagon")
    local wagon = NetworkGetEntityFromNetworkId(wagonNetId)
    if DoesEntityExist(wagon) then
        CreateWagonBlip(wagon)
    end
end)

RegisterNetEvent('mas_huntingwagon:client:deletetWagon', function(netId)
    local wagon = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(wagon) then
        NetworkRequestControlOfEntity(wagon)
        DeleteVehicle(wagon)
    end
end)

local function RentWagon(index)
    local dialog = lib.alertDialog({
        header = "Rent Hunting Wagon?",
        content = "Before you decide to rent the wagon, \n **I must warn you that if you lose the wagon, the cargo in it will be lost too.** \n You will not be refunded.",
        centered = true,
        cancel = true,
        labels = { cancel = "No", confirm = "Yes" }
    })
    if dialog == 'cancel' then return end

    local result = lib.callback.await("mas_huntingwagon:payRent", false)
    if not result then return lib.notify({ description = 'I dont have enough money!', type = 'error' }) end

    local wagonSpawn = Config.RentLocation[index].wagon
    local cartModel = `HUNTERCART01`
    local tarpPropSet = `PG_MP005_HUNTINGWAGONTARP01`
    local lightPropSet = `PG_VEH_CART06_LANTERNS01`
    local veh, _ = lib.getClosestVehicle(vector3(wagonSpawn.x, wagonSpawn.y, wagonSpawn.z), 1)
    local peds = lib.getNearbyPeds(vector3(wagonSpawn.x, wagonSpawn.y, wagonSpawn.z), 5)
    for i = 1, #peds do
        local ped = peds[i].ped
        if IsEntityDead(ped) then
            NetworkRequestControlOfEntity(ped)
            DeletePed(ped)
        end
    end
    if veh then return lib.notify({ description = "Something in the barn is blocking the way!", type = 'error' }) end
    lib.requestModel(cartModel)
    local wagon = CreateVehicle(cartModel, wagonSpawn.x, wagonSpawn.y, wagonSpawn.z, wagonSpawn.w, true, true, false, false)
    Wait(250)
    Citizen.InvokeNative(0x75F90E4051CC084C, wagon, tarpPropSet)  -- AddAdditionalPropSetForVehicle
    Citizen.InvokeNative(0xC0F0417A90402742, wagon, lightPropSet) -- AddLightPropSetToVehicle
    Wait(250)
    SetBatchTarpHeight(wagon, 0.1, false)
    SetEntityAsMissionEntity(wagon, true, true)
    SetModelAsNoLongerNeeded(cartModel)
    TriggerServerEvent("mas_huntingwagon:server:SetWagonId", NetworkGetNetworkIdFromEntity(wagon))
    CreateWagonBlip(wagon)
end

local function ReturnWagon(index)
    local wagonSpawn = Config.RentLocation[index].wagon
    local spawnPos = vector3(wagonSpawn.x, wagonSpawn.y, wagonSpawn.z)
    local vehicles = lib.getNearbyVehicles(spawnPos, 30)
    local identifier = lib.callback.await("mas_huntingwagon:getIdentifier", false)
    for i = 1, #vehicles do
        local wagon = vehicles[i].vehicle
        local owner = Entity(wagon).state.owner
        if owner == identifier then
            NetworkRequestControlOfEntity(wagon)
            TriggerServerEvent("mas_huntingwagon:server:RemoveWagonId", NetworkGetNetworkIdFromEntity(wagon))
            DeleteVehicle(wagon)
            return lib.notify({ description = "Thanks for returning the wagon", type = 'success' })
        end
    end
    lib.notify({ description = "Which one is your wagon?, try bring it closer to the barn", type = 'error' })
end

local function LostWagon()
    local dialog = lib.alertDialog({
        header = 'Lost Your Wagon?',
        content = "If your wagon is lost then its gone \n **cargo on your lost wagon and your money you deposited earlier won't be recovered** \n you can rent a new one after this",
        centered = true,
        cancel = true,
        labels = { cancel = "No", confirm = "Yes" }
    })
    if dialog == 'cancel' then return end
    TriggerServerEvent("mas_huntingwagon:server:RemoveWagonId")
end

function RentMenu(index)
    lib.registerContext({
        id = 'rent_menu',
        title = 'Rent menu',
        options = {
            {
                title = 'Rent Hunting Wagon',
                description = 'Just rent for now! | $' .. Config.RentPrice,
                icon = 'dollar-sign',
                onSelect = function()
                    RentWagon(index)
                end,
            },
            {
                title = 'Return Hunting Wagon',
                description = 'Get half of your money back!',
                icon = 'rotate-left',
                onSelect = function()
                    ReturnWagon(index)
                end,
            },
            {
                title = 'Lost Hunting Wagon',
                description = "I'm sorry I lost your wagon" ,
                icon = 'question',
                onSelect = LostWagon,
            },
        }
    })

    lib.showContext('rent_menu')
end
