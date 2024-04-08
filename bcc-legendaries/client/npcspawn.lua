--npc spawn setup
function npc()
    local createdped, count = {}, {}
    local model = joaat('a_m_m_huntertravelers_cool_01')

    modelload(model)

    --Blip and waypoint setup
    local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, -1282792512, Data.npcblipcoord.x, Data.npcblipcoord.y, Data.npcblipcoord.z, 100.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('Lastlocationblip'))
    VORPutils.Gps:SetGps(Data.npcblipcoord.x, Data.npcblipcoord.y, Data.npcblipcoord.z)

    --Distance Tracker Setup
    distcheck(Data.npcblipcoord.x, Data.npcblipcoord.y, Data.npcblipcoord.z, 200, PlayerPedId())
    if StopAll then
        RemoveBlip(blip)
        VORPutils.Gps:RemoveGps()
        VORPcore.NotifyRightTip(_U('Deadtext'), 4000) return
    end
    ClearGpsMultiRoute()
    RemoveBlip(blip)

    --Spawning Ped Setup
    for k, v in pairs(Data.Npccoords) do
        createdped[k] = spawnPed(model, v.x, v.y, v.z, true)
        TaskCombatPed(createdped[k], PlayerPedId())
        count[k] = createdped[k]
    end
    VORPcore.NotifyRightTip(_U('Poachersattack'), 6000)
    
    --DeadCheckSetup
    local x = #Data.Npccoords
    while true do
        Wait(100)
        if StopAll then break end
        for k, v in pairs(createdped) do
            if IsEntityDead(v) then
                if count[k] ~= nil then
                    x = x - 1
                    count[k] = nil
                    if x == 0 then
                        VORPcore.NotifyRightTip(_U('Poachersdead'), 6000)
                        searchsetupmain('NpcSearch', Data.npcschest.x, Data.npcschest.y, Data.npcschest.z) break
                    end
                end
            end
        end
    end
    if StopAll then
        for k, v in pairs(createdped) do
            DeletePed(v)
        end
        VORPcore.NotifyRightTip(_U('Deadtext'), 4000) return
    end
end