--Creates the search chest function that is used twice in the script
function searchsetupmain(type, x, y, z)
    --Spawning Object Setup
    local object = CreateObject('p_chest01x', x, y, z - 1, true, false, false)
    RequestModel(object, true)

    --Prompt Group Setup
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(_U('ChestPrompt'), 0x760A9C6F, 1, 1, true, 'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    
    --Blip and Waypoint Setup
    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, x, y, z, 100.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('Lastlocationblip'))
    VORPutils.Gps:SetGps(x, y, z)

    --Distance Tracker Setup
    while true do
        Wait(5)
        if StopAll then break end
        local pl = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(pl.x ,pl.y, pl.z, x, y, z, true)
        if dist < 3 then
            --Handles showing prompt, and prompt completion
            PromptGroup:ShowGroup(_U('ChestPrompt'))
            if firstprompt:HasCompleted() then
                RemoveBlip(blip)
                ClearGpsMultiRoute()
                --Playing Animation
                RequestAnimDict('mech_ransack@chest@med@open@crouch@b')
                while not HasAnimDictLoaded('mech_ransack@chest@med@open@crouch@b') do
                    Wait(0)
                end
                TaskPlayAnim(PlayerPedId(), 'mech_ransack@chest@med@open@crouch@b', 'base', 8.0, 8.0, 1000, 17, 0.2, false, false, false)
                VORPcore.NotifyRightTip(_U('Cluefound'), 4000) break
            end
        elseif dist > 200 then
            Wait(2000)
        end
    end
    if StopAll then
        RemoveBlip(blip)
        ClearGpsMultiRoute()
        firstprompt:DeletePrompt()
        VORPcore.NotifyRightTip(_U('Deadtext'), 4000) return
    end

    --Type detection setup
    if type == 'InitSearch' then
        if Data.enemynpc then
            npc()
        else
            spawnanimal()
        end
    elseif type == 'NpcSearch' then
        spawnanimal()
    end
end