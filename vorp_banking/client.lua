local prompts = GetRandomIntInRange(0, 0xffffff)
local PromptGroup2 = GetRandomIntInRange(0, 0xffffff)
local openmenu
local CloseBanks
local inmenu = false
local bankinfo = {}
local blips = {}

local T = TranslationBanking.Langs[Lang]

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

AddEventHandler('menuapi:closemenu', function()
    if inmenu then
        inmenu = false
        bankinfo = nil
        ClearPedTasks(PlayerPedId())
        DisplayRadar(true)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for i, v in pairs(Config.banks) do
            if v.BlipHandle then
                RemoveBlip(v.BlipHandle)
            end
            if v.NPC then
                DeleteEntity(v.NPC)
                DeletePed(v.NPC)
                SetEntityAsNoLongerNeeded(v.NPC)
            end
        end
        DisplayRadar(true)
        MenuData.CloseAll()
        inmenu = false
        ClearPedTasks(PlayerPedId())
    end
end)

---------------- BLIPS ---------------------
function AddBlip(index)
    if Config.banks[index].blipAllowed then
        Config.banks[index].BlipHandle = N_0x554d9d53f696d002(1664425300, Config.banks[index].x, Config.banks[index].y,
            Config.banks[index].z)
        SetBlipSprite(Config.banks[index].BlipHandle, Config.banks[index].blipsprite, 1)
        SetBlipScale(Config.banks[index].BlipHandle, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, Config.banks[index].BlipHandle, Config.banks[index].name)
    end
end

---------------- NPC ---------------------
function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(100)
    end
end

function SpawnNPC(index)
    local v = Config.banks[index]
    LoadModel(v.NpcModel)
    if v.NpcAllowed then
        local npc = CreatePed(v.NpcModel, v.Nx, v.Ny, v.Nz, v.Nh, false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        Wait(1000)
        TaskStandStill(npc, 10, -1)
        -- FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        Config.banks[index].NPC = npc
    end
end

function PromptSetUp()
    local str = T.openmenu
    openmenu = PromptRegisterBegin()
    PromptSetControlAction(openmenu, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(openmenu, str)
    PromptSetEnabled(openmenu, 1)
    PromptSetVisible(openmenu, 1)
    PromptSetStandardMode(openmenu, 1)
    PromptSetGroup(openmenu, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, openmenu, true)
    PromptRegisterEnd(openmenu)
end

function PromptSetUp2()
    local str = T.closemenu
    CloseBanks = PromptRegisterBegin()
    PromptSetControlAction(CloseBanks, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(CloseBanks, str)
    PromptSetEnabled(CloseBanks, 1)
    PromptSetVisible(CloseBanks, 1)
    PromptSetStandardMode(CloseBanks, 1)
    PromptSetGroup(CloseBanks, PromptGroup2)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, CloseBanks, true)
    PromptRegisterEnd(CloseBanks)
end

RegisterNetEvent("vorp_bank:recinfo")
AddEventHandler("vorp_bank:recinfo", function(data, name, allbanks)
    bankinfo = data
    Openbank(name, allbanks)
end)

RegisterNetEvent("vorp_bank:ready", function()
    DisplayRadar(true)
    inmenu = false
end)

Citizen.CreateThread(function()
    PromptSetUp()
    PromptSetUp2()
    while true do
        Citizen.Wait(0)
        local sleep = true
        local player = PlayerPedId()
        local coords = GetEntityCoords(PlayerPedId())
        local hour = GetClockHours()
        local dead = IsEntityDead(player)

        if not inmenu and not dead then
            for index, bankConfig in pairs(Config.banks) do
                if bankConfig.StoreHoursAllowed then
                    if hour >= bankConfig.StoreClose or hour < bankConfig.StoreOpen then
                        if not Config.banks[index].BlipHandle and bankConfig.blipAllowed then
                            AddBlip(index)
                        end
                        if Config.banks[index].BlipHandle then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Config.banks[index].BlipHandle,
                                GetHashKey('BLIP_MODIFIER_MP_COLOR_10'))
                        end
                        if Config.banks[index].NPC then
                            DeleteEntity(Config.banks[index].NPC)
                            DeletePed(Config.banks[index].NPC)
                            SetEntityAsNoLongerNeeded(Config.banks[index].NPC)
                            Config.banks[index].NPC = nil
                        end
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(bankConfig.x, bankConfig.y, bankConfig.z)
                        local distance = #(coordsDist - coordsStore)
                        if distance <= bankConfig.distOpen then
                            sleep = false

                            local label2 = CreateVarString(10, 'LITERAL_STRING',
                                T.openHours ..
                                " " ..
                                bankConfig.StoreOpen .. T.amTimeZone .. " - " .. bankConfig.StoreClose .. T.pmTimeZone)
                            PromptSetActiveGroupThisFrame(PromptGroup2, label2)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, CloseBanks) then
                                Wait(100)
                                TriggerEvent("vorp:TipRight", T.closed, 6000)
                            end
                        end
                    elseif hour >= bankConfig.StoreOpen then
                        if not Config.banks[index].BlipHandle and bankConfig.blipAllowed then
                            AddBlip(index)
                        end
                        if Config.banks[index].BlipHandle then
                            Citizen.InvokeNative(0x662D364ABF16DE2F, Config.banks[index].BlipHandle,
                                GetHashKey('BLIP_MODIFIER_MP_COLOR_32'))
                        end
                        if not Config.banks[index].NPC and bankConfig.NpcAllowed then
                            SpawnNPC(index)
                        end

                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(bankConfig.x, bankConfig.y, bankConfig.z)
                        local distance = #(coordsDist - coordsStore)

                        if distance <= bankConfig.distOpen then
                            sleep = false

                            local label = CreateVarString(10, 'LITERAL_STRING', T.bank .. " " .. bankConfig.name)
                            PromptSetActiveGroupThisFrame(prompts, label)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, openmenu) then
                                inmenu = true

                                TriggerServerEvent("vorp_bank:getinfo", bankConfig.city)
                                Wait(400) -- needed
                                TaskStandStill(PlayerPedId(), -1)
                                DisplayRadar(false)
                                --Openbank(bankConfig.name, index)
                            end
                        end
                    end
                else
                    if not Config.banks[index].BlipHandle and bankConfig.blipAllowed then
                        AddBlip(index)
                    end
                    if not Config.banks[index].NPC and bankConfig.NpcAllowed then
                        SpawnNPC(index)
                    end
                    local coordsDist = vector3(coords.x, coords.y, coords.z)
                    local coordsStore = vector3(bankConfig.x, bankConfig.y, bankConfig.z)
                    local distance = #(coordsDist - coordsStore)

                    if distance <= bankConfig.distOpen then
                        sleep = false

                        local label = CreateVarString(10, 'LITERAL_STRING', T.bank .. " " .. bankConfig.name)
                        PromptSetActiveGroupThisFrame(prompts, label)

                        if Citizen.InvokeNative(0xC92AC953F0A982AE, openmenu) then
                            inmenu = true
                            TriggerServerEvent("vorp_bank:getinfo", bankConfig.city)
                            Wait(200)
                            TaskStandStill(PlayerPedId(), -1)
                            DisplayRadar(false)
                            --Openbank(bankConfig.name, index)
                        end
                    end
                end
            end
        end
        if sleep then
            Citizen.Wait(500)
        end
    end
end)

function Openbank(bankName, allbanks)
    
    MenuData.CloseAll()
    if not bankinfo.money then
        DisplayRadar(true)
        ClearPedTasks(PlayerPedId())
        inmenu = false
        return
    end

    local elements = {
        { label = T.cashbalance .. bankinfo.money, value = 'nothing', desc = T.cashbalance2 },
        { label = T.depocash,                      value = 'dcash',   desc = T.depocash2 },
        { label = T.takecash,                      value = 'wcash',   desc = T.takecash2 }
    }

    if Config.banktransfer and #allbanks > 1 then
        elements[#elements + 1] = {
        label = T.bankacc,
        value = 'others', 
        desc = T.bankaccinfo
        }
    end

    if Config.banks[bankName].items then
        elements[#elements + 1] = {
            label = T.depoitem,
            value = 'bitem',
            desc = T.depoitem2 .. bankinfo.invspace
        }
    end

    if Config.banks[bankName].upgrade then
        elements[#elements + 1] = {
            label = T.upgradeitem,
            value = 'upitem',
            desc = T.upgradeitem2 .. Config.banks[bankName].costslot
        }
    end

    if Config.banks[bankName].gold then
        elements[#elements + 1] = {
            label = T.goldbalance .. bankinfo.gold,
            value = 'nothing',
            desc = T.cashbalance2
        }
        elements[#elements + 1] = {
            label = T.depogold,
            value = 'dgold',
            desc = T.depogold2
        }
        elements[#elements + 1] = {
            label = T.takegold,
            value = 'wgold',
            desc = T.takegold2
        }
    end


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = bankName,
            subtext  = T.welcome,
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            if (data.current.value == 'dcash') then
                local myInput = {
                    type = "enableinput",                                               -- don't touch
                    inputType = "input",                                                -- input type
                    button = T.inputsLang.confirmCash,                                  -- button name
                    placeholder = T.inputsLang.insertAmountCash,                        -- placeholder name
                    style = "block",                                                    -- don't touch
                    attributes = {
                        inputHeader = T.inputsLang.depositCash,                         -- header
                        type = "text",                                                  -- inputype text, number,date,textarea
                        pattern = "[0-9.]{1,10}",                                       -- only numbers "[0-9]" | for letters only "[A-Za-z]+"
                        title = T.inputsLang.numOnlyCash,                               -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;" -- style
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tonumber(cb)
                    if result ~= nil and result > 0 then
                        TriggerServerEvent("vorp_bank:depositcash", result, Config.banks[bankName].city, bankinfo)
                        DisplayRadar(true)
                        inmenu = false
                        MenuData.CloseAll()
                        ClearPedTasks(PlayerPedId())
                    else
                        TriggerEvent("vorp:TipBottom", T.invalid, 6000)
                    end
                end)
            end
            if (data.current.value == 'dgold') then
                local myInput = {
                    type = "enableinput",                                               -- don't touch
                    inputType = "input",                                                -- input type
                    button = T.inputsLang.confirmGold,                                  -- button name
                    placeholder = T.inputsLang.insertAmountGold,                        -- placeholder name
                    style = "block",                                                    -- don't touch
                    attributes = {
                        inputHeader = T.inputsLang.depositGold,                         -- header
                        type = "text",                                                  -- inputype text, number,date,textarea
                        pattern = "[0-9.]{1,10}",                                       -- only numbers "[0-9]" | for letters only "[A-Za-z]+"
                        title = T.inputsLang.numOnlyGold,                               -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;" -- style
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tonumber(cb)
                    if result ~= nil and result > 0 then
                        TriggerServerEvent("vorp_bank:depositgold", result, Config.banks[bankName].city, bankinfo)
                        DisplayRadar(true)
                        inmenu = false
                        MenuData.CloseAll()
                        ClearPedTasks(PlayerPedId())
                    else
                        TriggerEvent("vorp:TipBottom", T.invalid, 6000)
                    end
                end)
            end
            if (data.current.value == 'wcash') then
                local myInput = {
                    type = "enableinput",                                               -- don't touch
                    inputType = "input",                                                -- input type
                    button = T.inputsLang.confirmCashW,                                 -- button name
                    placeholder = T.inputsLang.insertAmountCashW,                       -- placeholder name
                    style = "block",                                                    -- don't touch
                    attributes = {
                        inputHeader = T.inputsLang.withdrawCash,                        -- header
                        type = "text",                                                  -- inputype text, number,date,textarea
                        pattern = "[0-9.]{1,10}",                                       -- only numbers "[0-9]" | for letters only "[A-Za-z]+"
                        title = T.inputsLang.numOnlyCashW,                              -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;" -- style
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tonumber(cb)
                    if result ~= nil and result > 0 then
                        TriggerServerEvent("vorp_bank:withcash", result, Config.banks[bankName].city, bankinfo)
                        DisplayRadar(true)
                        inmenu = false
                        MenuData.CloseAll()
                        ClearPedTasks(PlayerPedId())
                    else
                        TriggerEvent("vorp:TipBottom", T.invalid, 6000)
                    end
                end)
            end
            if (data.current.value == 'wgold') then
                local myInput = {
                    type = "enableinput",                                               -- don't touch
                    inputType = "input",                                                -- input type
                    button = T.inputsLang.confirmGoldW,                                 -- button name
                    placeholder = T.inputsLang.insertAmountGoldW,                       -- placeholder name
                    style = "block",                                                    -- don't touch
                    attributes = {
                        inputHeader = T.inputsLang.withdrawGold,                        -- header
                        type = "text",                                                  -- inputype text, number,date,textarea
                        pattern = "[0-9.]{1,10}",                                       -- only numbers "[0-9]" | for letters only "[A-Za-z]+"
                        title = T.inputsLang.numOnlyGoldW,                              -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;" -- style
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tonumber(cb)
                    if result ~= nil and result > 0 then
                        TriggerServerEvent("vorp_bank:withgold", result, Config.banks[bankName].city, bankinfo)
                        DisplayRadar(true)
                        inmenu = false
                        MenuData.CloseAll()
                        ClearPedTasks(PlayerPedId())
                    else
                        TriggerEvent("vorp:TipBottom", T.invalid, 6000)
                    end
                end)
            end
            if (data.current.value == 'bitem') then
                TriggerServerEvent("vorp_bank:ReloadBankInventory", Config.banks[bankName].city)
                Wait(300)
                TriggerEvent("vorp_inventory:OpenBankInventory", T.namebank, Config.banks[bankName].city, bankinfo.invspace)
                menu.close()
                DisplayRadar(true)
                inmenu = false
                ClearPedTasks(PlayerPedId())
            end
            if (data.current.value == 'upitem') then
                local invspace = bankinfo.invspace
                local maxslots = Config.banks[bankName].maxslots
                local costslot = Config.banks[bankName].costslot
                local myInput = {
                    type = "enableinput",                                               -- don't touch
                    inputType = "input",                                                -- input type
                    button = T.inputsLang.confirmUp,                                    -- button name
                    placeholder = T.inputsLang.insertAmountUp,                          -- placeholder name
                    style = "block",                                                    -- don't touch
                    attributes = {
                        inputHeader = T.inputsLang.upgradeSlots,                        -- header
                        type = "text",                                                  -- inputype text, number,date,textarea
                        pattern = "[0-9]{1,10}",                                        --  only numbers "[0-9]" | for letters only "[A-Za-z]+"
                        title = T.inputsLang.numOnlyUp,                                 -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;" -- style
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tonumber(cb)
                    if result ~= nil and result > 0 then
                        TriggerServerEvent("vorp_bank:UpgradeSafeBox", costslot, maxslots, math.floor(result), Config.banks[bankName].city, invspace)
                        DisplayRadar(true)
                        inmenu = false
                        MenuData.CloseAll()
                        ClearPedTasks(PlayerPedId())
                    else
                        TriggerEvent("vorp:TipBottom", T.invalid, 6000)
                    end
                end)
            end
            if (data.current.value == 'others') then
            Openallbanks(bankName, allbanks)
        end
        end,
        function(data, menu)
            menu.close()
            DisplayRadar(true)
            inmenu = false
            ClearPedTasks(PlayerPedId())
        end)
end

function Openallbanks(bankName, allbanks)
    MenuData.CloseAll()
    local elements = {}

    for _, bank in pairs(allbanks) do
        if bankName ~= bank.name then
            table.insert(elements, { label = bank.name .. " : " .. bank.money .. "$", value = 'transfer', desc = T.transferinfo, info = bank.name })
        end
    end

        MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = bankName,
            subtext  = T.welcome,
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            if (data.current.value == 'transfer') then
                local myInput = {
                    type = "enableinput",                                               -- don't touch
                    inputType = "input",                                                -- input type
                    button = T.inputsLang.Transfer,                                  -- button name
                    placeholder = T.inputsLang.insertAmountCash,                        -- placeholder name
                    style = "block",                                                    -- don't touch
                    attributes = {
                        inputHeader = T.inputsLang.depositTransfer,                         -- header
                        type = "text",                                                  -- inputype text, number,date,textarea
                        pattern = "[0-9.]{1,10}",                                       -- only numbers "[0-9]" | for letters only "[A-Za-z]+"
                        title = T.inputsLang.numOnlyCash,                               -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;" -- style
                    }
                }
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tonumber(cb)
                    if result ~= nil and result > 0 then
                        TriggerServerEvent("vorp_bank:transfer", result, data.current.info, bankName)
                    else
                        TriggerEvent("vorp:TipBottom", T.invalid, 6000)
                    end
                end)
            end
        end,
        function(data, menu)
            Openbank(bankName, allbanks)
        end)
end

-- open doors
CreateThread(function()
    for door, state in pairs(Config.Doors) do
        if not IsDoorRegisteredWithSystem(door) then
            Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0)
        end
        DoorSystemSetDoorState(door, state)
    end
end)
