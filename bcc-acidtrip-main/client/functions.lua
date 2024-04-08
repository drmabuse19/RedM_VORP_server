---------- Pulling Essesntials --------------
VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

------Functions----
local deadCheck = false
function SmokeCloudOnPed(ped) --This creates a function that when called will make smoke appear on a ped(you pass the ped too it)
    local new_ptfx_dictionary = "scr_odd_fellows"
    local new_ptfx_name = "scr_river5_magician_smoke"
    local is_particle_effect_active = false
    local current_ptfx_dictionary = new_ptfx_dictionary
    local current_ptfx_name = new_ptfx_name
    local current_ptfx_handle_id = false
    local ptfx_offcet_x = 0.0
    local ptfx_offcet_y = 0.0
    local ptfx_offcet_z = -1.0
    local ptfx_rot_x = -90.0
    local ptfx_rot_y = 0.0
    local ptfx_rot_z = 0.0
    local ptfx_scale = 1.0
    local ptfx_axis_x = 0
    local ptfx_axis_y = 0
    local ptfx_axis_z = 0
    if not is_particle_effect_active then
        current_ptfx_dictionary = new_ptfx_dictionary
        current_ptfx_name = new_ptfx_name
        if not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) then -- HasNamedPtfxAssetLoaded
            Citizen.InvokeNative(0xF2B2353BBC0D4E8F, GetHashKey(current_ptfx_dictionary))   --RequestNamedPtfxAsset
            local counter = 0
            while not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) and counter <= 300 do   --while not HasNamedPtfxAssetLoaded
                Wait(0)
            end
        end
        if Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) then  -- HasNamedPtfxAssetLoaded
            Citizen.InvokeNative(0xA10DB07FC234DD12, current_ptfx_dictionary)  --UseParticleFxAsset
            current_ptfx_handle_id =  Citizen.InvokeNative(0xE6CFE43937061143,current_ptfx_name,ped,ptfx_offcet_x,ptfx_offcet_y,ptfx_offcet_z,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)     --StartNetworkedParticleFxNonLoopedOnEntity
            is_particle_effect_active = true
        else
            print("cant load ptfx dictionary!")
        end
    else
        if current_ptfx_handle_id then
            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, current_ptfx_handle_id) then    --DoesParticleFxLoopedExist
                Citizen.InvokeNative(0x459598F579C98929, current_ptfx_handle_id, false)    --RemoveParticleFx
            end
        end
    current_ptfx_handle_id = false
    is_particle_effect_active = false
    end
end

--This function will spawn as many peds as set in a table, and detect when they are dead, when they all die it will trigger an event
function PedTableAllDead(pedCoordTable, model, event)
    TriggerEvent('bcc-acidtrip:DeadCheck')
    local createdPed, count, runOnceThing = {}, {}, false
    modelLoad(model)
    for k, v in pairs(pedCoordTable) do
        Wait(1000)
        createdPed[k] = CreatePed(model, v.x, v.y, v.z, false, true)
        Citizen.InvokeNative(0x283978A15512B2FE, createdPed[k], true)
        Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdPed[k])
        TaskCombatPed(createdPed[k], PlayerPedId())
        if Config.SmokeOnNpcSpawn then
            SmokeCloudOnPed(createdPed[k])
        end
        count[k] = createdPed[k]
        if not runOnceThing then
            runOnceThing = true
            CreateThread(function() --thread required to run this code asyn and allow for loop to continue
                local x = #pedCoordTable
                while true do
                    Wait(150)
                    if deadCheck then break end
                    for k, v in pairs(createdPed) do
                        if IsEntityDead(v) then
                            if count[k] ~= nil then
                                x = x - 1
                                count[k] = nil
                                if x == 0 then
                                    TriggerEvent(event, model)
                                    runOnceThing = false break
                                end
                            end
                        end
                    end
                end
                if deadCheck then
                    for key, value in pairs(createdPed) do
                        DeletePed(value)
                    end
                    deadCheck = false
                    TriggerEvent('bcc-acidtrip:WakeUp/End')
                end
            end)
        end
    end
end

RegisterNetEvent('bcc-acidtrip:DeadCheck')
AddEventHandler('bcc-acidtrip:DeadCheck', function()
    while true do
        Wait(100)
        if IsEntityDead(PlayerPedId()) then
            deadCheck = true break
        end
    end
end)

function PlayerPedchange(multichange, model, time, event, smokeexplosion) --Function to handle changing the players ped for a set time, and triggers an event once ped reset
    local changingModel = function(model3)
        if smokeexplosion then
            SmokeCloudOnPed(PlayerPedId())
        end
        if not IsModelValid(model3) then return end
        modelLoad(model3)
        Citizen.InvokeNative(0xED40380076A31506, PlayerId(), model3, false)
        Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
	    SetModelAsNoLongerNeeded(model3)
        Wait(time)
    end

    if multichange then
        for k, v in pairs(AnimalHashes) do
            local model2 = joaat(v.model)
            changingModel(model2)
        end
        ExecuteCommand('rc') --uses the /rc command reseting the players ped
        Wait(200)
        TriggerEvent(event)
    else
        local model2 = joaat(model)
        changingModel(model2)
        ExecuteCommand('rc')
        Wait(200)
        TriggerEvent(event)
    end
end

function modelLoad(model) --loads model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

-------------Tables-----------------------------
AnimalHashes = {
    {model = 'A_C_Bear_01'},
    {model = 'mp_a_c_deer_01'},
    {model = 'A_C_Duck_01'},
    {model = 'a_c_snakeredboa10ft_01'},
    {model = 'A_C_Alligator_01'},
    {model = 'A_C_Elk_01'},
    {model = 'A_C_Wolf'},
    {model = 'MP_A_C_WOLF_01'},
    {model = 'cs_dutch'},
    {model = 'cs_crackpotrobot'}
}