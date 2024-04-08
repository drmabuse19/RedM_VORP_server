function LoadAnimDict(dict)
    if DoesAnimDictExist(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end
end

function crowling()
    LoadAnimDict("mech_crawl@base")
    while true do
        if IsControlJustPressed(0, 0x26E9DC00) and not IsControlPressed(0, 0xDB096B85) then -- E
            break
        end
        if IsControlPressed(0, 0x8FD015D8) then -- W
            if IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "idle", 3) and
                (not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_r4", 3) or
                    not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_l4", 3)) then
                TaskPlayAnim(PlayerPedId(), "mech_crawl@base", "walk", 1.0, 1.0, -1, 1, 0, false, false, false, '',
                    false)
            end
        end
        if IsControlPressed(0, 0x7065027D) then -- A 
            if (IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "idle", 3) or
                IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk", 3)) and
                not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_r4", 3) then
                TaskPlayAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_l4", 1.0, 1.0, 1500, 0, 0, false, false,
                    false, '', false)
            end
        end
        if IsControlPressed(0, 0xB4E465B4) then -- D
            if (IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "idle", 3) or
                IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk", 3)) and
                not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_l4", 3) then
                TaskPlayAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_r4", 1.0, 1.0, 1500, 0, 0, false, false,
                    false, '', false)
            end
        end
        if IsControlPressed(0, 0xD27782E3) then -- S
            if IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "idle", 3) then
                TaskPlayAnim(PlayerPedId(), "mech_crawl@base", "onfront_bwd", 1.0, 1.0, -1, 1, 0, false, false, false,
                    '', false)
            end
        end
        if (not IsControlPressed(0, 0xD27782E3) and not IsControlPressed(0, 0xB4E465B4) and
            not IsControlPressed(0, 0x7065027D) and not IsControlPressed(0, 0x8FD015D8)) or
            (not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "idle", 3) and
            not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk", 3) and
            not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_r4", 3) and
            not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "walk_turn_l4", 3) and
            not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "onfront_bwd", 3)) then
            if not IsEntityPlayingAnim(PlayerPedId(), "mech_crawl@base", "idle", 3) then
                TaskPlayAnim(PlayerPedId(), "mech_crawl@base", "idle", 1.0, 1.0, -1, 1, 0, false, false, false, '',
                    false)
            end
        end
        Wait(1)
    end
    ClearPedTasks(PlayerPedId())
    RemoveAnimDict("mech_crawl@base")
end


Citizen.CreateThread(function()
    while true do
        Wait(100)
        if IsControlPressed(0, 0x26E9DC00) and IsControlPressed(0, 0xDB096B85) then
            crowling()
        end
    end
end)