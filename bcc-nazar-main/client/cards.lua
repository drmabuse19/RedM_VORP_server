local CardPrompt
local CardGroup = GetRandomIntInRange(0, 0xffffff)
local CardMade = false
local NearSoundActivate = false

if ConfigCards.Enabled then
    CreateThread(function()
        StartCardPrompt()

        local is_particle_effect_active = false
        local current_ptfx_handle_id = false

        while true do
            local sleep = 1000
            local player = PlayerId()
            local playerPed = PlayerPedId()
            if IsEntityDead(playerPed) then
                goto continue
            end
            for card, cardCfg in pairs(ConfigCards.Cards) do
                local distance = #(GetEntityCoords(playerPed) - cardCfg.coords)
                if distance <= 15 then
                    sleep = 0
                    if not cardCfg.propEntity then
                        SpawnCard(card)
                    end
                    if distance <= 2 then
                        local promptText = CreateVarString(10, 'LITERAL_STRING', cardCfg.name .. ' ' .. cardCfg.number)
                        PromptSetActiveGroupThisFrame(CardGroup, promptText)
                        if Citizen.InvokeNative(0xE0F65F0640EF0617, CardPrompt) then -- PromptHasHoldModeCompleted
                            local onCooldown = VORPcore.Callback.TriggerAwait('bcc-nazar:CardCooldown', cardCfg.model)
                            if Citizen.InvokeNative(0x45AB66D02B601FA7, player) then
                                Citizen.InvokeNative(0x64FF4BF9AF59E139, player, true) -- _SECONDARY_SPECIAL_ABILITY_SET_DISABLED
                                Citizen.InvokeNative(0xC0B21F235C02139C, player)       -- _SPECIAL_ABILITY_SET_EAGLE_EYE_DISABLED
                            end

                            if not onCooldown then
                                TriggerServerEvent('bcc-nazar:GetCard', cardCfg.name .. ' ' .. cardCfg.number,
                                    cardCfg.model)
                            else
                                VORPcore.NotifyRightTip(_U('CantCollectCard'), 4000)
                            end
                        end
                    end

                    if Citizen.InvokeNative(0x45AB66D02B601FA7, player) and ConfigCards.ptfx.enabled then
                        -- Eagle Eyes : ON
                        if not is_particle_effect_active then
                            if not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(ConfigCards.ptfx.dict)) then                         -- HasNamedPtfxAssetLoaded
                                Citizen.InvokeNative(0xF2B2353BBC0D4E8F, GetHashKey(ConfigCards.ptfx.dict))                                 -- RequestNamedPtfxAsset
                                local counter = 0
                                while not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(ConfigCards.ptfx.dict)) and counter <= 300 do -- while not HasNamedPtfxAssetLoaded
                                    Citizen.Wait(0)
                                end
                            end
                            if Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(ConfigCards.ptfx.dict)) then -- HasNamedPtfxAssetLoaded
                                Citizen.InvokeNative(0xA10DB07FC234DD12, ConfigCards.ptfx.dict)                 -- UseParticleFxAsset
                                current_ptfx_handle_id = Citizen.InvokeNative(0x8F90AB32E1944BDE, ConfigCards.ptfx.name,
                                    cardCfg.propEntity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigCards.ptfx.scale, false,
                                    false, false) -- StartNetworkedParticleFxLoopedOnEntity
                                is_particle_effect_active = true
                            end
                        end
                        -- Sound
                        if not NearSoundActivate then
                            NearSoundActivate = true
                            StartCardSoundHint(card)
                        end
                    else
                        -- Eagle Eyes : OFF
                        if current_ptfx_handle_id then
                            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, current_ptfx_handle_id) then    -- DoesParticleFxLoopedExist
                                Citizen.InvokeNative(0x459598F579C98929, current_ptfx_handle_id, false) -- RemoveParticleFx
                            end
                        end
                        current_ptfx_handle_id = false
                        is_particle_effect_active = false
                        NearSoundActivate = false
                    end
                else
                    if cardCfg.propEntity then
                        DeleteEntity(cardCfg.propEntity)
                        cardCfg.propEntity = nil
                    end
                    if CardMade then
                        if IsControlJustPressed(0, 0x308588E6) then -- INPUT_GAME_MENU_CANCEL / ESC - BACKSPACE
                            ClearPedTasks(playerPed)
                            CardMade = false
                        end
                    end
                end
            end
            ::continue::
            Wait(sleep)
        end
    end)
end

RegisterNetEvent('bcc-nazar:UseCard', function(model)
    local playerPed = PlayerPedId()
    Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 2, true)                                     -- HidePedWeapons
    local propEntity = CreateObject(joaat(model), GetEntityCoords(playerPed), false, false, false, false, false)
    Citizen.InvokeNative(0xCB9401F918CB0F75, playerPed, 'GENERIC_DOCUMENT_FLIP_AVAILABLE', true, -1) -- SetPedBlackboardBool
    TaskItemInteraction_2(playerPed, joaat(model), propEntity, joaat('PrimaryItem'),
        joaat('CIGARETTE_CARD_W6-5_H10-7_SINGLE_INTRO'), 1, 0, -1.0)
    CardMade = true
end)

function SpawnCard(card)
    local cardCfg = ConfigCards.Cards[card]
    cardCfg.propEntity = CreateObject(joaat(cardCfg.model), cardCfg.coords, false, false, false, false, false)
    Citizen.InvokeNative(0x9587913B9E772D29, cardCfg.propEntity, true)             -- PlaceEntityOnGroundProperly
    Citizen.InvokeNative(0x543DFE14BE720027, PlayerId(), cardCfg.propEntity, true) -- REGISTER_EAGLE_EYE_FOR_ENTITY
    Citizen.InvokeNative(0x62ED71E133B6C9F1, cardCfg.propEntity, 255, 255, 0)      -- EAGLE_EYE_SET_CUSTOM_ENTITY_TINT
    Citizen.InvokeNative(0x907B16B3834C69E2, cardCfg.propEntity, 50.0)             -- EagleEyeSetCustomDistance
    Wait(1500)
    FreezeEntityPosition(cardCfg.propEntity, true)
end

function StartCardPrompt()
    CardPrompt = PromptRegisterBegin()
    PromptSetControlAction(CardPrompt, Config.keys.collect) -- [G]
    PromptSetText(CardPrompt, CreateVarString(10, 'LITERAL_STRING', _U('Pickup')))
    PromptSetVisible(CardPrompt, true)
    PromptSetEnabled(CardPrompt, true)
    PromptSetHoldMode(CardPrompt, 2000)
    PromptSetGroup(CardPrompt, CardGroup)
    PromptRegisterEnd(CardPrompt)
end

function StartCardSoundHint(card)
    local frontend_soundset_ref = ConfigCards.ptfx.soundset_ref
    local frontend_soundset_name = ConfigCards.ptfx.soundset_name
    local cardCfg = ConfigCards.Cards[card]

    if frontend_soundset_ref ~= 0 then
        Citizen.InvokeNative(0x0F2A2175734926D8, frontend_soundset_name, frontend_soundset_ref); -- load sound frontend
    end
    while Citizen.InvokeNative(0x45AB66D02B601FA7, PlayerId()) do
        Citizen.InvokeNative(0x67C540AA08E4A6F5, frontend_soundset_name, frontend_soundset_ref, true, 0); -- play sound frontend
        Citizen.Wait(#(GetEntityCoords(PlayerPedId() - cardCfg.coords)) * ConfigCards.ptfx.soundset_delay)
    end
    Citizen.InvokeNative(0x9D746964E0CF2C5F, frontend_soundset_name, frontend_soundset_ref)     -- stop audio
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    ClearPedTasksImmediately(PlayerPedId())
    for _, cardCfg in pairs(ConfigCards.Cards) do
        if cardCfg.propEntity then
            DeleteEntity(cardCfg.propEntity)
        end
    end
end)
