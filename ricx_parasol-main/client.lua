
local parasolout = false
local EndPrompt
local ParasolGroup = GetRandomIntInRange(0, 0xffffff)
local parasolObj

function CreateParasol()
    if parasolObj ~= nil then
        DeleteEntity(parasolObj)
        SetEntityAsNoLongerNeeded(parasolObj)
        parasolObj = nil
    end
    local pedp = PlayerPedId()
    local pc = GetEntityCoords(pedp)
    local model = Config.Parasol.model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    local boneIndex
    local Attach
    if IsPedMale(pedp) then 
        boneIndex = Config.Parasol.male.BoneIndex
        Attach = Config.Parasol.male.Attach
    else
        boneIndex = Config.Parasol.female.BoneIndex
        Attach = Config.Parasol.female.Attach
    end

    parasolObj = CreateObject(model, pc.x,pc.y,pc.z, true, true, true)
    AttachEntityToEntity(parasolObj, pedp, boneIndex, Attach[1], Attach[2], Attach[3], Attach[4], Attach[5], Attach[6], false, false, false, true, 2, true)
    SetModelAsNoLongerNeeded(model)

    if not HasAnimDictLoaded(Config.Parasol.anim[1]) then 
        RequestAnimDict(Config.Parasol.anim[1])
        while not HasAnimDictLoaded(Config.Parasol.anim[1]) do 
            Citizen.Wait(1)
        end
    end

    TaskPlayAnim(pedp, Config.Parasol.anim[1], Config.Parasol.anim[2], 5.0, 5.0, -1, 31, 0)
    Citizen.Wait(100)
    RemoveAnimDict(Config.Parasol.anim[1])
end

function EndParasol()
    if parasolout == true then
        if parasolObj ~= nil then
            DeleteEntity(parasolObj)
            SetEntityAsNoLongerNeeded(parasolObj)
            parasolObj = nil
        end
        ClearPedTasksImmediately(PlayerPedId())
        parasolout = false
        return
    end
end

function SetupParasolPrompt()
        local str2 = Config.Prompts.StopName
        EndPrompt = PromptRegisterBegin()
        PromptSetControlAction(EndPrompt, Config.Prompts.StopPrompt) 
        str2 = CreateVarString(10, 'LITERAL_STRING', str2)
        PromptSetText(EndPrompt, str2)
        PromptSetEnabled(EndPrompt, 1)
        PromptSetVisible(EndPrompt, 1)
		PromptSetStandardMode(EndPrompt,1)
		PromptSetGroup(EndPrompt, ParasolGroup)
		Citizen.InvokeNative(0xC5F428EE08FA7F2C,EndPrompt,true)
		PromptRegisterEnd(EndPrompt)
end

Citizen.CreateThread(function() --
    SetupParasolPrompt()
	while true do
		local t = 5
		if parasolout == true then
            local label  = CreateVarString(10, 'LITERAL_STRING', Config.Prompts.Title)
            PromptSetActiveGroupThisFrame(ParasolGroup, label)
            DisableControlAction(0, 0x8FFC75D6, 1)
            DisableControlAction(0, 0xD9D0E1C0, 1)

            if Citizen.InvokeNative(0xC92AC953F0A982AE,EndPrompt) then
                EndParasol()
            end
            if IsPedSwimming(PlayerPedId()) or IsPedFalling(PlayerPedId()) or IsEntityDead(PlayerPedId()) then
                EndParasol()
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)


RegisterNetEvent('ricx_parasol:start')
AddEventHandler('ricx_parasol:start', function()
    local playerp = PlayerPedId()
    if  not IsEntityDead(playerp) and parasolout == false and GetMount(playerp) == 0 and not IsPedSwimming(playerp) and not IsPedClimbing(playerp) and not IsPedFalling(playerp) then
        parasolout = true
        CreateParasol()
    else
        TriggerEvent("Notification:left_parasol", Config.Messages.Title, Config.Messages.NoParasol, 'menu_textures', 'stamp_locked_rank', 3000)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if parasolout == true then
        if parasolObj ~= nil then
            DeleteObject(parasolObj)        
            SetObjectAsNoLongerNeeded(parasolObj)
            ClearPedTasksImmediately(PlayerPedId())
            parasolObj = nil
        end
    end
    PromptDelete(EndPrompt)
end)

--Basic Notification
RegisterNetEvent('Notification:left_parasol')
AddEventHandler('Notification:left_parasol', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Citizen.Wait(5)
        end
    end
    if txtr ~= nil then
        exports.ricx_parasol.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.ricx_parasol.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
    SetStreamedTextureDictAsNoLongerNeeded(dict)
end)