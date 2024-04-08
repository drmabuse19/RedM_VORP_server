local activeJob = nil
local jobStarted = false
local farm = false
local vehicule = false
local livraison = false
local farmId = 1
local vehiculeId = 1

Citizen.CreateThread(function()
	--draw blips on maps
	for _, info in pairs(Config.jobs) do
        local blip = N_0x554d9d53f696d002(1664425300, info.blipsMap.x, info.blipsMap.y, info.blipsMap.z)
        SetBlipSprite(blip, info.blipsMap.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.blipsMap.name)
    end  
end)

Citizen.CreateThread(function()
	--draw contract blips on maps
	for _, info in pairs(Config.changeJob) do
		for _, v in pairs(info.pos) do
			local blip = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
			SetBlipSprite(blip, -1043855483, 1)
			SetBlipScale(blip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.title)
		end
    end  
end)

Citizen.CreateThread(function()
	--give job title
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		for _, info in pairs(Config.changeJob) do
			local title = info.title
			for _, place in pairs(info.pos) do
				--create npc here?
				local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, place.x, place.y, place.z, true)
				if betweencoords <= 2.2 then
					DrawTxt(info.startWorkMsg, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
					--suppr
					if IsControlJustPressed(2, 0x4AF4D473)then
						--TriggerServerEvent('jobMaster:isJob', title, function(is)
						--	if not is then
						--		TriggerServerEvent('jobMaster:setJob', title)
						--	end
						--end)
						TriggerServerEvent('jobMaster:setJob', title)
						TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['youre']..title..Language.translate[Config.lang]['now'], 5)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	--job task
	while true do
		Citizen.Wait(0)
		
		local pos = GetEntityCoords(PlayerPedId())
		if not jobStarted then
			for _, info in pairs(Config.jobs) do
				if (Vdist(pos.x, pos.y, pos.z, info.init.x, info.init.y, info.init.z) < 3.0) then
					DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
					--enter
					if IsControlJustPressed(0, 0xC7B5340A) then
						activeJob = info
						jobStarted = true
						farm = true
						TriggerServerEvent('jobMaster:startjob',activeJob)
					end
				end
			end
		else
			if farm then
				if (Vdist(pos.x, pos.y, pos.z, activeJob.farm[farmId].x, activeJob.farm[farmId].y, activeJob.farm[farmId].z) < 3.0) then
					DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
					--enter
					if IsControlJustPressed(0, 0xC7B5340A) then
						animation(activeJob.farm[farmId].anim, activeJob.farm[farmId].time,activeJob.farm[farmId].text)
						RemoveBlip(blip)
						farmId = farmId + 1
						if activeJob.farm[farmId] ~= nil then
							TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5)
							blip = N_0x554d9d53f696d002(203020899, activeJob.farm[farmId].x, activeJob.farm[farmId].y, activeJob.farm[farmId].z)
							SetBlipSprite(blip, -570710357, 1)
						else
							farm = false
							farmId = 1
							if activeJob.vehiculeSpawn[1] ~= nil then
								vehicule = true
								RemoveBlip(blip)
								blip = N_0x554d9d53f696d002(203020899, activeJob.vehiculeSpawn[vehiculeId].x, activeJob.vehiculeSpawn[vehiculeId].y, activeJob.vehiculeSpawn[vehiculeId].z)
								SetBlipSprite(blip, -570710357, 1)
								TriggerEvent('jobMaster:car',activeJob,vehiculeId)
							else
								livraison = true
								TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['carry'], 5)
								RemoveBlip(blip)
								blip = N_0x554d9d53f696d002(203020899, activeJob.livraison.x, activeJob.livraison.y, activeJob.livraison.z)
								SetBlipSprite(blip, -570710357, 1)
							end
						end
					end
				end
			end
			if vehicule then
				if (Vdist(pos.x, pos.y, pos.z, activeJob.vehiculeSpawn[vehiculeId].x, activeJob.vehiculeSpawn[vehiculeId].y, activeJob.vehiculeSpawn[vehiculeId].z) < 3.0) then
					DrawTxt(Language.translate[Config.lang]['pressc'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
					--entrer
					if IsControlJustPressed(0, 0xC7B5340A) then
						animation(activeJob.animationVehicule, activeJob.VehiculeTime,Language.translate[Config.lang]['placing'])
						TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['carry'], 5)
						RemoveBlip(blip)
						blip = N_0x554d9d53f696d002(203020899, activeJob.livraison.x, activeJob.livraison.y, activeJob.livraison.z)
						SetBlipSprite(blip, -570710357, 1)
						vehicule = false
						livraison = true
					end
				end
			end
			if livraison then
				if (Vdist(pos.x, pos.y, pos.z, activeJob.livraison.x, activeJob.livraison.y, activeJob.livraison.z) < 3.0) then
					DrawTxt(Language.translate[Config.lang]['pressf'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
					--entrer
					if IsControlJustPressed(0, 0xC7B5340A) then
						if IsPedInAnyVehicle(PlayerPedId(), true) or activeJob.vehiculeSpawn[1] == nil then
							local money = math.random(activeJob.money.min, activeJob.money.max)
							local xp = math.random(activeJob.xp.min, activeJob.xp.max)
							if activeJob.vehiculeSpawn[1] ~= nil then
								DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
							end
							TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['completejob'] ..money.."$ | "..xp.."XP", 5)
							RemoveBlip(blip)
							TriggerServerEvent('jobMaster:paid', money, xp)
							livraison = false
							jobStarted = false
							activeJob = nil
						else
							TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['noveh'], 5)
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('jobMaster:start')
AddEventHandler('jobMaster:start', function(source)
	if activeJob ~= nil and activeJob.farm[1] ~= nil then
		blip = N_0x554d9d53f696d002(203020899, activeJob.farm[1].x, activeJob.farm[1].y, activeJob.farm[1].z)
		SetBlipSprite(blip, -570710357, 1)
	else
		TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['nofarmzone'], 10)
	end
end)

RegisterNetEvent('jobMaster:car')
AddEventHandler('jobMaster:car', function(job,spawnID)
	Citizen.Wait(0)

	local player = PlayerPedId()
	local vehicule = GetHashKey(activeJob.vehicule)
	RequestModel(vehicule)

	while not HasModelLoaded(vehicule) do
		Citizen.Wait(0)
	end

	spawncar = CreateVehicle(vehicule, activeJob.vehiculeSpawn[spawnID].x, activeJob.vehiculeSpawn[spawnID].y, activeJob.vehiculeSpawn[spawnID].z, activeJob.vehiculeSpawn[spawnID].heading, true, false)
	SetVehicleOnGroundProperly(spawncar)
	SetModelAsNoLongerNeeded(vehicule)
end)

function animation(anim,time,text)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(anim), time, true, false, false, false)
    exports['progressBars']:startUI(time, text)
    Wait(time)
    Wait(100)
    ClearPedTasksImmediately(PlayerPedId())
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end