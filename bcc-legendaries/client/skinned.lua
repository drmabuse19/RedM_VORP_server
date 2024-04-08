--Pulled from vorp_hunting and modified to function the way i wanted it too
function skinnedped()
    while true do
        Wait(2)
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for index = 0, size - 1 do
                local event = GetEventAtIndex(0, index)
                if event == 1376140891 then
                    local view = exports["bcc-legendaries"]:DataViewNativeGetEventData(0, index, 3) --for it to work in otehr codes changehorizon legend to the file name
                    local pedGathered = view['2']
                    local ped = view['0']
                    local model = GetEntityModel(pedGathered)
                    local model2 = GetEntityModel(Createdped2)
                    -- Bool to let you know if animation/longpress was enacted.
                    local bool_unk = view['4']
                    -- Ensure the player who enacted the event is the one who gets the rewards
                    local player = PlayerPedId()
                    local playergate = player == ped
                    if playergate == true and bool_unk == 1 and model == model2 then --if the varaible Animal is the gator then
                        TriggerServerEvent('bcc:legendaries:giveitemsbear', Data.GivenItems)
                        Wait(300000)
                        DeletePed(Createdped2)
                        break
                    end
                end
            end
        end
    end
end