FeatherMenu =  exports['feather-menu'].initiate()

local ClientRPC = exports.vorp_core:ClientRpcCall()

local MenuPrompt
local PromptGroup = GetRandomIntInRange(0, 0xffffff)
local HasJob = false
-- Start Portals
CreateThread(function()
    StartPrompt()
    while true do
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)
        local sleep = 1000
        local hour = GetClockHours()

        if IsEntityDead(playerPed) then
            goto continue
        end
        for portal, portalCfg in pairs(Config.shops) do
            if portalCfg.shop.hours.active then
                -- Using Shop Hours - Shop Closed
                if hour >= portalCfg.shop.hours.close or hour < portalCfg.shop.hours.open then
                    if portalCfg.blip.show and portalCfg.blip.showClosed then
                        if not Config.shops[portal].Blip then
                            AddBlip(portal)
                        end
                        Citizen.InvokeNative(0x662D364ABF16DE2F, Config.shops[portal].Blip, joaat(Config.BlipColors[portalCfg.blip.color.closed])) -- BlipAddModifier
                    else
                        if Config.shops[portal].Blip then
                            RemoveBlip(Config.shops[portal].Blip)
                            Config.shops[portal].Blip = nil
                        end
                    end
                    if portalCfg.NPC then
                        DeleteEntity(portalCfg.NPC)
                        portalCfg.NPC = nil
                    end
                    local distance = #(pCoords - portalCfg.npc.coords)
                    if distance <= portalCfg.shop.distance then
                        sleep = 0
                        local shopClosed = CreateVarString(10, 'LITERAL_STRING', portalCfg.shop.name .. _U('hours') .. portalCfg.shop.hours.open .. _U('to') .. portalCfg.shop.hours.close .. _U('hundred'))
                        PromptSetActiveGroupThisFrame(PromptGroup, shopClosed)
                        PromptSetEnabled(MenuPrompt, false)
                    end
                elseif hour >= portalCfg.shop.hours.open then
                    -- Using Shop Hours - Shop Open
                    if portalCfg.blip.show then
                        if not Config.shops[portal].Blip then
                            AddBlip(portal)
                        end
                        Citizen.InvokeNative(0x662D364ABF16DE2F, Config.shops[portal].Blip, joaat(Config.BlipColors[portalCfg.blip.color.open])) -- BlipAddModifier
                    end
                    if not (portalCfg.shop.jobsEnabled) then
                        local distance = #(pCoords - portalCfg.npc.coords)
                        if portalCfg.npc.active then
                            if distance <= portalCfg.npc.distance then
                                if not portalCfg.NPC then
                                    AddNPC(portal)
                                end
                            else
                                if portalCfg.NPC then
                                    DeleteEntity(portalCfg.NPC)
                                    portalCfg.NPC = nil
                                end
                            end
                        end
                        if distance <= portalCfg.shop.distance then
                            sleep = 0
                            local shopOpen = CreateVarString(10, 'LITERAL_STRING', portalCfg.shop.prompt)
                            PromptSetActiveGroupThisFrame(PromptGroup, shopOpen)
                            PromptSetEnabled(MenuPrompt, true)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- UiPromptHasStandardModeCompleted
                                MainMenu(pCoords, portal)
                            end
                        end
                    else
                        -- Using Shop Hours - Shop Open - Job Locked
                        if Config.shops[portal].Blip then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Config.shops[portal].Blip, joaat(Config.BlipColors[portalCfg.blip.color.job])) -- BlipAddModifier
                        end
                        local distance = #(pCoords - portalCfg.npc.coords)
                        if portalCfg.npc.active then
                            if distance <= portalCfg.npc.distance then
                                if not portalCfg.NPC then
                                    AddNPC(portal)
                                end
                            else
                                if portalCfg.NPC then
                                    DeleteEntity(portalCfg.NPC)
                                    portalCfg.NPC = nil
                                end
                            end
                        end
                        if distance <= portalCfg.shop.distance then
                            sleep = 0
                            local shopOpen = CreateVarString(10, 'LITERAL_STRING', portalCfg.shop.prompt)
                            PromptSetActiveGroupThisFrame(PromptGroup, shopOpen)
                            PromptSetEnabled(MenuPrompt, true)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- UiPromptHasStandardModeCompleted
                                CheckPlayerJob(portal)
                                if HasJob then
                                    MainMenu(pCoords, portal)
                                end
                            end
                        end
                    end
                end
            else
                -- Not Using Shop Hours - Shop Always Open
                if portalCfg.blip.show then
                    if not Config.shops[portal].Blip then
                        AddBlip(portal)
                    end
                    Citizen.InvokeNative(0x662D364ABF16DE2F, Config.shops[portal].Blip, joaat(Config.BlipColors[portalCfg.blip.color.open])) -- BlipAddModifier
                end
                if not (portalCfg.shop.jobsEnabled) then
                    local distance = #(pCoords - portalCfg.npc.coords)
                    if portalCfg.npc.active then
                        if distance <= portalCfg.npc.distance then
                            if not portalCfg.NPC then
                                AddNPC(portal)
                            end
                        else
                            if portalCfg.NPC then
                                DeleteEntity(portalCfg.NPC)
                                portalCfg.NPC = nil
                            end
                        end
                    end
                    if distance <= portalCfg.shop.distance then
                        sleep = 0
                        local shopOpen = CreateVarString(10, 'LITERAL_STRING', portalCfg.shop.prompt)
                        PromptSetActiveGroupThisFrame(PromptGroup, shopOpen)
                        PromptSetEnabled(MenuPrompt, true)

                        if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- UiPromptHasStandardModeCompleted
                            MainMenu(pCoords, portal)
                        end
                    end
                else
                    -- Not Using Shop Hours - Shop Always Open - Job Locked
                    if Config.shops[portal].Blip then
                        Citizen.InvokeNative(0x662D364ABF16DE2F, Config.shops[portal].Blip, joaat(Config.BlipColors[portalCfg.blip.color.job])) -- BlipAddModifier
                    end
                    local distance = #(pCoords - portalCfg.npc.coords)
                    if portalCfg.npc.active then
                        if distance <= portalCfg.npc.distance then
                            if not portalCfg.NPC then
                                AddNPC(portal)
                            end
                        else
                            if portalCfg.NPC then
                                DeleteEntity(portalCfg.NPC)
                                portalCfg.NPC = nil
                            end
                        end
                    end
                    if distance <= portalCfg.shop.distance then
                        sleep = 0
                        local shopOpen = CreateVarString(10, 'LITERAL_STRING', portalCfg.shop.prompt)
                        PromptSetActiveGroupThisFrame(PromptGroup, shopOpen)
                        PromptSetEnabled(MenuPrompt, true)

                        if Citizen.InvokeNative(0xC92AC953F0A982AE, MenuPrompt) then -- UiPromptHasStandardModeCompleted
                            CheckPlayerJob(portal)
                            if HasJob then
                                MainMenu(pCoords,portal)
                            end
                        end
                    end
                end
            end
        end
        ::continue::
        Wait(sleep)
    end
end)

-- Portal Menus
function MainMenu(pCoords, portal)
    local portalCfg = Config.shops[portal]
    local mainMenu = FeatherMenu:RegisterMenu('bcc-portals:MainMenu', {
        top = '10%',
        left = '5%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {},
        contentslot = {
            style = {
                ['height'] = '325px',
                ['min-height'] = '325px'
            }
        },
        draggable = true,
        canclose = true
    })

    local destinations = mainMenu:RegisterPage('first:page')

    destinations:RegisterElement('header', {
        value = portalCfg.shop.name,
        slot = 'header',
        style = {
            ['color'] = '#999'
        }
    })

    destinations:RegisterElement('subheader', {
        value = _U('destinations'),
        slot = 'header',
        style = {
            ['color'] = '#CC9900',
            ['font-size'] = '18px'
        }
    })

    destinations:RegisterElement('line', {
        slot = 'header'
    })

    for outlet, outletCfg in pairs(portalCfg.outlets) do
        destinations:RegisterElement('button', {
            label = outletCfg.label,
            style = {
                ['color'] = '#E0E0E0'
            },
            id = outlet
        }, function(data)
            local travelInfo = { location = data.id, coords = pCoords }
            local travelData = ClientRPC.Callback.TriggerAwait('bcc-portals:GetTravelData', travelInfo)
            if travelData then
                TravelMenu(travelData, portal, pCoords)
            end
        end)
    end

    destinations:RegisterElement('bottomline', {
        slot = 'footer',
    })

    TextDisplay = destinations:RegisterElement('textdisplay', {
        value = _U('choose'),
        slot = 'footer',
        style = {
            ['color'] = '#C0C0C0'
        }
    })

    mainMenu:Open({
        startupPage = destinations
    })
end

function TravelMenu(travelData, portal, pCoords)
    local travelLoc = travelData.location
    local cashPrice = travelData.cash
    local goldPrice = travelData.gold
    local currencyData = 'cash'
    local travelPrice = cashPrice

    local travelMenu = FeatherMenu:RegisterMenu('bcc-portals:TravelMenu', {
        top = '10%',
        left = '5%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {},
        contentslot = {
            style = {
                ['height'] = '325px',
                ['min-height'] = '325px'
            }
        },
        draggable = true,
        canclose = true
    })

    local travelInfo = travelMenu:RegisterPage('first:page')

    travelInfo:RegisterElement('header', {
        value = Config.shops[portal].shop.name,
        slot = 'header',
        style = {
            ['color'] = '#999'
        }
    })

    travelInfo:RegisterElement('subheader', {
        value = _U('travelInfo'),
        slot = 'header',
        style = {
            ['color'] = '#CC9900',
            ['font-size'] = '18px'
        }
    })

    travelInfo:RegisterElement('line', {
        slot = 'header'
    })

    LocDisplay = travelInfo:RegisterElement('textdisplay', {
        value = Config.shops[travelLoc].shop.name,
        style = {
            ['color'] = '#C0C0C0',
            ['font-size'] = '20px',
            ['font-variant'] = 'small-caps',
            ['font-weight'] = '500',
            ['letter-spacing'] = '2px'
        },
        id = 'location'
    })

    PriceDisplay = travelInfo:RegisterElement('textdisplay', {
        value = _U('price') .. ' $' .. cashPrice,
        style = {
            ['color'] = '#C0C0C0',
            ['font-variant'] = 'small-caps',
            ['font-size'] = '16px'
        },
        id = 'price'
    })

    local minutes = tonumber(travelData.dispTime.minutes)
    local seconds = tonumber(travelData.dispTime.seconds)
    local travelTime = nil
    if minutes >= 1 then
        travelTime = minutes .. _U('minutes') .. ' ' .. seconds .. _U('seconds')
    else
        travelTime = seconds .. _U('seconds')
    end

    TimeDisplay = travelInfo:RegisterElement('textdisplay', {
        value = _U('time') .. travelTime,
        style = {
            ['color'] = '#C0C0C0',
            ['font-variant'] = 'small-caps',
            ['font-size'] = '16px'
        },
        id = 'time'
    })

    local currencyType = Config.shops[portal].shop.currency
    local currency = {
        [1] = function() -- Cash-Only
            currencyData = 'cash'
            travelPrice = cashPrice
        end,
        [2] = function() -- Gold-Only
            PriceDisplay:update({
                value = _U('price') .. goldPrice .. _U('nugget'),
                style = {},
            })
            currencyData = 'gold'
            travelPrice = goldPrice
        end,
        [3] = function() -- Cash and Gold
            travelInfo:RegisterElement('arrows', {
                label = _U('currency'),
                start = 1,
                options = {
                    {
                        display = _U('cash'),
                        extra = 'cash'
                    },
                    {
                        display = _U('gold'),
                        extra = 'gold'
                    }
                },
                style = {
                    ['color'] = '#E0E0E0'
                },
                persist = false,
            }, function(data)
                if data.value.extra == 'cash' then
                    PriceDisplay:update({
                        value = _U('price') .. ' $' .. cashPrice,
                        style = {},
                    })
                    currencyData = 'cash'
                    travelPrice = cashPrice
                elseif data.value.extra == 'gold' then
                    PriceDisplay:update({
                        value = _U('price') .. goldPrice .. _U('nugget'),
                        style = {},
                    })
                    currencyData = 'gold'
                    travelPrice = goldPrice
                end
            end)
        end,
        [4] = function() -- Free
            PriceDisplay:update({
                value = _U('price') .. _U('free'),
                style = {},
            })
            currencyData = 'free'
        end
    }
    if currency[currencyType] then
        currency[currencyType]()
    end

    travelInfo:RegisterElement('button', {
        label = _U('go'),
        style = {
            ['color'] = '#E0E0E0'
        },
        id = 'go'
    }, function(data)
        local canTravelInfo = { currency = currencyData, price = travelPrice }
        local canTravel = ClientRPC.Callback.TriggerAwait('bcc-portals:GetPlayerCanTravel', canTravelInfo)
        if canTravel then
            travelMenu.Close()
            SendPlayer(travelLoc, travelData.timeMs)
        end
    end)

    travelInfo:RegisterElement('button', {
        label = _U('back'),
        style = {
            ['color'] = '#E0E0E0'
        },
        id = 'back'
    }, function(data)
        MainMenu(pCoords, portal)
    end)

    travelInfo:RegisterElement('bottomline', {
        slot = 'footer',
    })

    travelMenu:Open({
        startupPage = travelInfo
    })
end

function SendPlayer(location, time)
    local portalCfg = Config.shops[location]
    DoScreenFadeOut(1000)
    Wait(1000)
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, _U('traveling') .. portalCfg.shop.name, '', '') -- DisplayLoadingScreens
    Wait(time)
    Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), portalCfg.player.coords, portalCfg.player.heading, false, false, false) -- SetEntityCoordsAndHeading
    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)
    Wait(1000)
    SetCinematicModeActive(false)
end

function CheckPlayerJob(portal)
    HasJob = false
    local result = ClientRPC.Callback.TriggerAwait('bcc-portals:CheckJob', portal)
    if result then
        HasJob = true
    end
end

function StartPrompt()
    MenuPrompt = PromptRegisterBegin()
    PromptSetControlAction(MenuPrompt, Config.key)
    PromptSetText(MenuPrompt, CreateVarString(10, 'LITERAL_STRING', _U('portPrompt')))
    PromptSetVisible(MenuPrompt, true)
    PromptSetStandardMode(MenuPrompt, true)
    PromptSetGroup(MenuPrompt, PromptGroup)
    PromptRegisterEnd(MenuPrompt)
end

function AddBlip(portal)
    local portalCfg = Config.shops[portal]
    portalCfg.Blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, portalCfg.npc.coords) -- BlipAddForCoords
    SetBlipSprite(portalCfg.Blip, portalCfg.blip.sprite, true)
    SetBlipScale(portalCfg.Blip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, portalCfg.Blip, portalCfg.blip.name) -- SetBlipNameFromPlayerString
end

function AddNPC(portal)
    local portalCfg = Config.shops[portal]
    local model = joaat(portalCfg.npc.model)
    LoadModel(model)
    portalCfg.NPC = CreatePed(model, portalCfg.npc.coords, portalCfg.npc.heading, false, false, false, false)
    Citizen.InvokeNative(0x283978A15512B2FE, portalCfg.NPC, true) -- SetRandomOutfitVariation
    SetEntityCanBeDamaged(portalCfg.NPC, false)
    SetEntityInvincible(portalCfg.NPC, true)
    Wait(500)
    FreezeEntityPosition(portalCfg.NPC, true)
    SetBlockingOfNonTemporaryEvents(portalCfg.NPC, true)
end

function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for _, portalCfg in pairs(Config.shops) do
        if portalCfg.Blip then
            RemoveBlip(portalCfg.Blip)
            portalCfg.Blip = nil
        end
        if portalCfg.NPC then
            DeleteEntity(portalCfg.NPC)
            portalCfg.NPC = nil
        end
    end
end)

