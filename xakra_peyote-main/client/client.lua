local VORPcore = exports.vorp_core:GetCore()

-- ############# PEYOTE EFFECT #############
local ActivePeyote = false

RegisterNetEvent("xakra_peyote:set_animal")
AddEventHandler("xakra_peyote:set_animal", function(PeyoteEffect)
    if ActivePeyote then
        return
    end

    ActivePeyote = true

    AnimpostfxStop("PlayerDrunk01")
    AnimpostfxStop("DeathFailMP01")

    VORPcore.NotifyObjective(PeyoteEffect.Notify, 6000)

    TaskAnim("mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese", "quick_right_hand", 2, 3000)
    Wait(3000)

    AnimpostfxPlay("PlayerDrunk01")
    TaskAnim("amb_misc@world_human_vomit_kneel@male_a@idle_c", "idle_h", 2, 11000)
    Wait(11000)

    ClearPedTasks(PlayerPedId())

    if math.random(100) <= PeyoteEffect.ProbabilityOfDying then
        SetEntityHealth(PlayerPedId(), 0)
        AnimpostfxStop("PlayerDrunk01")

    else
        local RagdollTime = 5

        CreateThread(function()
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0) 
            while RagdollTime > 0 do 
                ResetPedRagdollTimer(PlayerPedId())
                Wait(500)
            end
        end)

        while RagdollTime > 0 do
            Wait(1000)
            RagdollTime = RagdollTime - 1
        end

        AnimpostfxPlay("PlayerWakeUpDrunk")
        AnimpostfxStop("PlayerDrunk01")
    
        SetMonModel(PeyoteEffect.Peds[math.random(#PeyoteEffect.Peds)])

        Wait(PeyoteEffect.Time)

        AnimpostfxPlay("PlayerWakeUpDrunk")

        -- if IsPedMale(PlayerPedId()) then
        --     SetMonModel('mp_male')
        -- else
        --     SetMonModel('mp_female')
        -- end

        -- Wait(500)

        ExecuteCommand("rc")
        Wait(500)

        TaskAnim("amb_rest@world_human_passed_out_floor@male_a@base", "base", 2, 15000)
        Wait(15000)
        
        TaskAnim("amb_rest@world_human_passed_out_floor@male_a@stand_exit", "exit_front", 2, 6000)
        Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, 1.0)
        Wait(30000)

        Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0)
    end

    ActivePeyote = false
end)


function SetMonModel(name)
    local model = joaat(name)
    local player = PlayerId()
        
    if not IsModelValid(model) then return end
    PerformRequest(model)
        
    if HasModelLoaded(model) then
        Citizen.InvokeNative(0xED40380076A31506, player, model, false)  -- SetPlayerModel
        Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)   -- SetRandomOutfitVariation
        SetModelAsNoLongerNeeded(model)
    end
 end

function PerformRequest(modelHash)
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
    end
end

function TaskAnim(animDict, animName, flags, duration)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end
    end

    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 3.0, duration, flags, 0, 0, 0, 0)
    RemoveAnimDict(animDict)
end

--########################### STOP RESOURCE ###########################
AddEventHandler('onResourceStop', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        if ActivePeyote then
            AnimpostfxStop("PlayerWakeUpDrunk")
            AnimpostfxStop("PlayerDrunk01")
            AnimpostfxStop("DeathFailMP01")
            Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0)  -- SetPedDrunkness

            -- if IsPedMale(PlayerPedId()) then
            --     SetMonModel('mp_male')
            -- else
            --     SetMonModel('mp_female')
            -- end
            ExecuteCommand("rc")
        end
    end
end)