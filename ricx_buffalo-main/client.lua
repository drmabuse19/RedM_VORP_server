
local buffalo = nil
local riding = false 

local EnterPrompt
local BuffaloEnterPrompts = GetRandomIntInRange(0, 0xffffff)

local ExitPrompt
local GoPrompt
local BuffaloPrompts = GetRandomIntInRange(0, 0xffffff)

local RentPrompt
local BuffaloRentPrompts = GetRandomIntInRange(0, 0xffffff)

function BuffaloPromptSet()
    local str = 'Go'
    GoPrompt = PromptRegisterBegin()
    PromptSetControlAction(GoPrompt, 0x05CA7C52)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(GoPrompt, str)
    PromptSetEnabled(GoPrompt, 1)
    PromptSetVisible(GoPrompt, 1)
	PromptSetStandardMode(GoPrompt,1)
	PromptSetGroup(GoPrompt, BuffaloPrompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,GoPrompt,true)
	PromptRegisterEnd(GoPrompt)

    local str2 = 'Leave'
    ExitPrompt = PromptRegisterBegin()
    PromptSetControlAction(ExitPrompt, 0xD9D0E1C0)
    str2 = CreateVarString(10, 'LITERAL_STRING', str2)
    PromptSetText(ExitPrompt, str2)
    PromptSetEnabled(ExitPrompt, 1)
    PromptSetVisible(ExitPrompt, 1)
	PromptSetStandardMode(ExitPrompt,1)
	PromptSetGroup(ExitPrompt, BuffaloPrompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,ExitPrompt,true)
	PromptRegisterEnd(ExitPrompt)

    local str3 = 'Mount'
    EnterPrompt = PromptRegisterBegin()
    PromptSetControlAction(EnterPrompt, 0xD9D0E1C0)
    str3 = CreateVarString(10, 'LITERAL_STRING', str3)
    PromptSetText(EnterPrompt, str3)
    PromptSetEnabled(EnterPrompt, 1)
    PromptSetVisible(EnterPrompt, 1)
	PromptSetStandardMode(EnterPrompt,1)
	PromptSetGroup(EnterPrompt, BuffaloEnterPrompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,EnterPrompt,true)
	PromptRegisterEnd(EnterPrompt)

    local str4 = 'Rent Buffalo'
    RentPrompt = PromptRegisterBegin()
    PromptSetControlAction(RentPrompt, 0xD9D0E1C0)
    str4 = CreateVarString(10, 'LITERAL_STRING', str4)
    PromptSetText(RentPrompt, str4)
    PromptSetEnabled(RentPrompt, 1)
    PromptSetVisible(RentPrompt, 1)
	PromptSetStandardMode(RentPrompt,1)
	PromptSetGroup(RentPrompt, BuffaloRentPrompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,RentPrompt,true)
	PromptRegisterEnd(RentPrompt)
end

function ExitBuffalo()
    riding = false
    ClearPedTasks(PlayerPedId())
    ClearPedTasksImmediately(buffalo)
    DetachEntity(PlayerPedId(), 1, 1)
end

function EnterBuffalo()
    riding = true
    RequestAnimDict("cnv_camp@rcbch@mus@ccabijck_sng1_wild_rover")
	while not HasAnimDictLoaded("cnv_camp@rcbch@mus@ccabijck_sng1_wild_rover") do
		Citizen.Wait(5)
	end
    SetModelAsNoLongerNeeded(animalHash)
	AttachEntityToEntity(PlayerPedId(), buffalo, 215, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
	TaskPlayAnim(PlayerPedId(), "cnv_camp@rcbch@mus@ccabijck_sng1_wild_rover", "jack_action", 8.0, -8.0, -1, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(200)
    RemoveAnimDict("cnv_camp@rcbch@mus@ccabijck_sng1_wild_rover")
end

function CreateRentBuffalo()
    
    Citizen.Wait(100)
	local pped = PlayerPedId()
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(pped, 0.0, 2.0, 0.1))
    local animalHash = GetHashKey("a_c_buffalo_01")
    RequestModel(animalHash)
    while not HasModelLoaded(animalHash) do
        Citizen.Wait(1)
    end
	buffalo = CreatePed(animalHash, x, y, z, GetEntityHeading(pped)+90, 1, 0)
    Citizen.InvokeNative(0x283978A15512B2FE, buffalo, true)
	Citizen.InvokeNative(0x77FF8D35EEC6BBC4,buffalo, 0) 
	while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, buffalo) do 
		Citizen.Wait(1)
	end
    Citizen.InvokeNative(0x704C908E9C405136, buffalo)
	Citizen.InvokeNative(0xAAB86462966168CE, buffalo, 1)
	Citizen.InvokeNative(0x90D2156198831D69, buffalo, true)
end

function RemoveBuffalo()
    DeleteEntity(buffalo)
    SetEntityAsNoLongerNeeded(buffalo)
    buffalo = nil
 if riding == true then 
        riding = false
    end
end

local pcoords = nil
local pdead = nil

Citizen.CreateThread(function() --
    BuffaloPromptSet()
	while true do
		Citizen.Wait(500)
        pcoords = GetEntityCoords(PlayerPedId())
        pdead = IsEntityDead(PlayerPedId())
        if pdead ~= nil and pdead == 1 then 
            if riding == true then 
                ExitBuffalo()
            end
        end
        if buffalo ~= nil then 
            local dist = GetDistanceBetweenCoords(pcoords, GetEntityCoords(buffalo), 1)
            if dist > Config.DeleteDistance then 
		if riding == true then 
                    ClearPedTasksImmediately(PlayerPedId())
                end
		RemoveBuffalo()
            else
                if IsEntityDead(buffalo) then 
		if riding == true then 
                    ClearPedTasksImmediately(PlayerPedId())
                end
                    RemoveBuffalo()
                end
            end
            
        end
    end
end)

Citizen.CreateThread(function() --
	while true do
		local t = 4
		if buffalo == nil and riding == false and pcoords ~= nil and (pdead ~= nil and pdead ~= 1) then
            for i,v in pairs(Config.Rents) do 
                local dist = GetDistanceBetweenCoords(pcoords, v.coords, 1)
                if dist < 10.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.coords.x, v.coords.y, v.coords.z-0.9 , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.3, 126, 0, 0, 200, 0, 0, 2, 0, 0, 0, 0)
                end
                if dist < 1.7 then 
                    local label  = CreateVarString(10, 'LITERAL_STRING', "Buffalo Rent $"..v.price_label)
                    PromptSetActiveGroupThisFrame(BuffaloRentPrompts, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE,RentPrompt) then
                        TriggerServerEvent("ricx_buffalo:check_rent", i)
                    end
                end
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function() --
	while true do
		local t = 4
		if buffalo ~= nil and riding == false and pcoords ~= nil and (pdead ~= nil and pdead ~= 1) then
            local dist = GetDistanceBetweenCoords(pcoords, GetEntityCoords(buffalo), 1)
            if dist < 1.8 then
                local label  = CreateVarString(10, 'LITERAL_STRING', "Buffalo")
                PromptSetActiveGroupThisFrame(BuffaloEnterPrompts, label)
                if Citizen.InvokeNative(0xC92AC953F0A982AE,EnterPrompt) then
                    EnterBuffalo()
                    Citizen.Wait(2000)
                end
            else
                t = 1500
            end
        else
            t = 2000
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function() --
	while true do
		local t = 4
		if buffalo ~= nil and riding == true and pcoords ~= nil and (pdead ~= nil and pdead ~= 1) then

                local label  = CreateVarString(10, 'LITERAL_STRING', "Buffalo")
                PromptSetActiveGroupThisFrame(BuffaloPrompts, label)
                DisableControlAction(0, 0xAC4BD4F1, true) -- TAB 
                DisableControlAction(0, 0x4CC0E2FE, true) -- B 
                if Citizen.InvokeNative(0xC92AC953F0A982AE,ExitPrompt) then
                    ExitBuffalo()
                    Citizen.Wait(2000)
                end
                if Citizen.InvokeNative(0xC92AC953F0A982AE,GoPrompt) then
                    local gps = GetWaypointCoords()
                    local cc = GetEntityCoords(PlayerPedId())
                    local dist = GetDistanceBetweenCoords(gps.x, gps.y, cc.z, cc.x, cc.y, cc.z, false)
                    local a,b,c = GetGroundZAndNormalFor_3dCoord(gps.x, gps.y, gps.z+500.0,1,1)
                    print(a,b,c, gps.x, gps.y, gps.z, dist)
                    if gps.x ~= 0.0 and gps.y ~= 0.0 and b ~= 0.0 and dist < 140.0 then 
                        ClearPedTasksImmediately(buffalo)
                        TaskGoToCoordAnyMeansExtraParams(buffalo, gps.x, gps.y, b, 3.0, 0, false, 524311, -1, 0, 1101004800, 192, 500.0)
                        Citizen.Wait(2000)
                    else
                        print("Buffalo Move: there is no Waypoint data or the Waypoint is far away, buffalo cant make it")
                        Citizen.Wait(2000)
                    end
                end

		else
			t = 2000
		end
		Citizen.Wait(t)
	end
end)

RegisterNetEvent("ricx_buffalo:rented_buffalo")
AddEventHandler("ricx_buffalo:rented_buffalo", function()
    CreateRentBuffalo()
end)

function RemoveBuffaloPrompts()
    PromptDelete(EnterPrompt)
    PromptDelete(ExitPrompt)
    PromptDelete(GoPrompt)
    PromptDelete(RentPrompt)
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if riding == true then 
        DetachEntity(PlayerPedId(), 1, 1)
        ClearPedTasksImmediately(PlayerPedId())
    end

	if buffalo ~= nil then 
		DeleteEntity(buffalo)
		SetEntityAsNoLongerNeeded(buffalo)
	end
    RemoveBuffaloPrompts()
end)
