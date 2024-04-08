local ChestPrompt
local ChestGroup = GetRandomIntInRange(0, 0xffffff)
local PromptStarted = false

------------ Main Chest Hunt Setup ----------------
RegisterNetEvent('bcc-nazar:OpenChest', function()
    if not PromptStarted then
        StartChestPrompt()
    end
    VORPcore.NotifyBottomRight(_U('HintNotify'), 6000)

    local chest = CreateObject(joaat('p_chest01x'), C.x, C.y, C.z - 1, false, false, false, false, false)
    Citizen.InvokeNative(0x58A850EAEE20FAA3, chest, true) -- PlaceObjectOnGroundProperly
    Wait(500)
    FreezeEntityPosition(chest, true)

    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, C.x, C.y, C.z, 100.0) -- BlipAddForRadius
    Citizen.InvokeNative(0x9CB1A1623062F402, _U('TreasureBlipName')) -- SetBlipName
    while true do
        Wait(0)
        local sleep = true
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(C.x, C.y, C.z))
        if distance <= 3 then
            sleep = false
            local promptText = CreateVarString(10, 'LITERAL_STRING', _U('TreasurePromptTitle'))
            PromptSetActiveGroupThisFrame(ChestGroup, promptText)
            if Citizen.InvokeNative(0xE0F65F0640EF0617, ChestPrompt) then  -- PromptHasHoldModeCompleted
                local dict = 'mech_ransack@chest@med@open@crouch@b'
                LoadAnim(dict)
                TaskPlayAnim(PlayerPedId(), dict, 'base', 1.0, 1.0, 5000, 17, 1.0, false, false, false)
                RemoveBlip(blip)
                Wait(5000)
                TriggerServerEvent('bcc-nazar:GetRewards', V)
                DeleteEntity(chest)
                break
            end
        end
        if sleep then
            Wait(1000)
        end
    end
end)

function LoadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function StartChestPrompt()
    local str = CreateVarString(10, 'LITERAL_STRING', _U('TreasurePrompt_search'))
    ChestPrompt = PromptRegisterBegin()
    PromptSetControlAction(ChestPrompt, Config.keys.chest) -- [G]
    PromptSetText(ChestPrompt, str)
    PromptSetVisible(ChestPrompt, true)
    PromptSetEnabled(ChestPrompt, true)
    PromptSetHoldMode(ChestPrompt, 2000)
    PromptSetGroup(ChestPrompt, ChestGroup)
    PromptRegisterEnd(ChestPrompt)

    PromptStarted = true
end