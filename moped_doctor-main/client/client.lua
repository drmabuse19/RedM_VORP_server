local currentCam = nil
local spawnped = nil
local spawnrec = nil
local starttime = nil

local function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(7)
    SetTextColor(255, 255, 255, 215)
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.085+ factor, 0.03, 41, 11, 41, 68)
end

local function DrawText(text, x, y, fontscale, fontsize, r, g, b, alpha, textcentred, shadow)
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(fontscale, fontsize)
    SetTextColor(r, g, b, alpha)
    SetTextCentre(textcentred)
    if shadow then 
        SetTextDropshadow(1, 0, 0, 255)
    end
    SetTextFontForCurrentCommand(1)
    DisplayText(str, x, y)
end

local pressed = false
Citizen.CreateThread(function()
	while true do
		
		local ped = PlayerPedId()
		local playerCoords = GetEntityCoords(ped)
		local distance = #(playerCoords - Config.ReceptionistLoc.xyz)
		local sleep = 1000

		if distance < 15 and not spawnrec then

			RequestModel(Config.Receptionist)
			while not HasModelLoaded(Config.Receptionist) do
				Wait(100)
			end
			spawnrec = CreatePed(Config.Receptionist, Config.ReceptionistLoc.x, Config.ReceptionistLoc.y, Config.ReceptionistLoc.z - 1.0, Config.ReceptionistLoc.w, false, true)
			SetEntityAlpha(spawnrec, 255, false)
			SetPedRandomComponentVariation(spawnrec, 0)
			FreezeEntityPosition(spawnrec, true)
			SetEntityInvincible(spawnrec, true)			
			SetBlockingOfNonTemporaryEvents(spawnrec, true)
			TaskStartScenarioAtPosition(spawnrec, Config.ReceptionistScenario, Config.ReceptionistLoc.x, Config.ReceptionistLoc.y, Config.ReceptionistLoc.z - 1.0, Config.ReceptionistLoc.w, -1, false, true)
		end
		if distance >= 15 and spawnrec then
			DeletePed(spawnrec)
			SetModelAsNoLongerNeeded(Config.Receptionist)
			spawnrec = nil
		end

		if distance < 2 and not pressed then
			sleep = 0
			DrawText3D(Config.ReceptionistLoc.x,Config.ReceptionistLoc.y,Config.ReceptionistLoc.z, Config.Locales.press)
			if IsControlJustReleased(0, Config.InteractControl) then
				pressed = true

				if GetEntityHealth(PlayerPedId()) ~= GetEntityMaxHealth(PlayerPedId()) then
					TriggerServerEvent('moped_doctor:checkin')
				else
					SendNotification(Config.Locales.healthy)
					pressed = false
				end
			end
		end


		Wait(sleep)
	end
end)

RegisterNetEvent('moped_doctor:notenoughmoney')
AddEventHandler('moped_doctor:notenoughmoney', function(money)
	SendNotification(Config.Locales.notenough..money..'$')
	pressed = false
end)

RegisterNetEvent('moped_doctor:toomuchpeoplewithjob')
AddEventHandler('moped_doctor:toomuchpeoplewithjob', function()
	SendNotification(Config.Locales.job)
	pressed = false
end)

RegisterNetEvent('moped_doctor:occupied')
AddEventHandler('moped_doctor:occupied', function()
	SendNotification(Config.Locales.occupied)
	pressed = false
end)


RegisterNetEvent('moped_doctor:start')
AddEventHandler('moped_doctor:start', function()
	local ped = PlayerPedId()
	DoScreenFadeOut(4000)
	TaskGoToCoordAnyMeans(ped, -288.79, 810.56, 118.79, 1.0, 0,0,786603)
	Wait(4000)
	RequestAnimDict("script_rc@dopn@ig@ig4_rsc2_enterdoctorsoffice")
	while not HasAnimDictLoaded("script_rc@dopn@ig@ig4_rsc2_enterdoctorsoffice") do Wait(100) end
	RequestModel(Config.Doctor)
    while not HasModelLoaded(Config.Doctor) do
        Wait(100)
    end
	ClearPedTasks(ped)
	SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
	SetEntityCoordsNoOffset(ped, vector3(-288.79, 810.56, 118.79))
	SetEntityHeading(ped, 130.74)
    spawnped = CreatePed(Config.Doctor, -287.38, 811.04, 119.39, 79.93, true, true)
    FreezeEntityPosition(spawnped, false)
    SetPedRandomComponentVariation(spawnped, 0)
    SetBlockingOfNonTemporaryEvents(spawnped, true)
    SetEntityInvincible(spawnped, true)
    SetEntityCanBeDamaged(spawnped, false)
    SetEntityNoCollisionEntity(ped, spawnped, true)
	TaskPlayAnimAdvanced(ped, "script_rc@dopn@ig@ig4_rsc2_enterdoctorsoffice", 'ig4_edo_arthursitsinchair_arthur', -288.89, 810.71, 119.79, 0, 0, 130.74, 1.0, 1.0, -1, 2, 0.0, 0, 0)
	currentCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(currentCam, vector3(-288.47, 812.15, 118.69))
	PointCamAtCoord(currentCam, vector3(-289.83, 810.09, 119.20))
	SetCamFov(currentCam, 40.0)
	SetCamActive(currentCam, true)
	RenderScriptCams(true, false, 1, 1, 1)
	if Config.BlackBars then
		Citizen.InvokeNative(0x69D65E89FFD72313, true,true)
	end
	TaskGoToCoordAnyMeans(spawnped, -289.58, 810.65, 119.39, 1.0, 0,0,786603) 
	Wait(725)
	DoScreenFadeIn(3000)
	Wait(2500)
	TaskPlayAnimAdvanced(ped, "script_rc@dopn@ig@ig4_rsc2_enterdoctorsoffice", 'ig4_edo_arthursitsinchair_arthur', -289.88, 810.19, 119.89, 0, 0, 349.44, 1.0, 1.0, -1, 2, 0.99, 0, 0)
	RemoveAnimDict("script_rc@dopn@ig@ig4_rsc2_enterdoctorsoffice")
	Wait(50)
	SetEntityHeading(ped, 349.44)
	TaskAchieveHeading(spawnped, 146.94, 5000)
	FreezeEntityPosition(ped, true)
	Wait(800)
	TaskPedSlideToCoord(spawnped, -289.35, 810.74, 119.39, 146.94, 800)
	Wait(800)
	RequestAnimDict("script_re@injured_rider@dr_office")
	while not HasAnimDictLoaded("script_re@injured_rider@dr_office") do Wait(100) end
	TaskPlayAnim(spawnped, "script_re@injured_rider@dr_office", 'surgery_idle_var02_doc', 1.0, 1.0, -1, 1, 0, true, 0, false, 0, false)
	RemoveAnimDict("script_re@injured_rider@dr_office")
	local doing = false
	Citizen.CreateThread(function()
		while currentCam ~= nil do
			Wait(0)
			if starttime == nil then
				starttime = GetGameTimer()
			end
			if GetGameTimer() < starttime + Config.Time * 1000 then
				local timeremaining = starttime + Config.Time * 1000 - GetGameTimer()
				local seconds = (timeremaining / 1000) % 60
				if seconds > 100 then
					seconds = string.sub(seconds,1,3)
				elseif seconds > 10 then
					seconds = string.sub(seconds,1,2)
				else
					seconds = string.sub(seconds,1,1)
				end
				DrawText(Config.Locales.doctorpatching..'\n'..Config.Locales.youhave..' '..seconds..' '..Config.Locales.seconds, 0.5, 0.75, 0.7, 0.7, 255, 255, 255, 255, true, true)
			elseif GetGameTimer() > starttime + Config.Time * 1000 and not doing then
				doing = true
				ClearPedTasks(spawnped)
				TaskGoToCoordAnyMeans(spawnped, -289.33, 813.0, 119.39, 1.0, 0,0,786603)
				Wait(1000)
				DoScreenFadeOut(1000)
				Wait(1000)
				ClearPedTasks(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), false)
				SetEntityCoords(ped, 2717.812,-1233.314,50.36658)
				SetEntityHeading(ped, 207.46)
				Wait(1000)
				DoScreenFadeIn(1000)
				--TaskPedSlideToCoord(spawnped, -287.3, 808.62, 119.39, 207.86, 800)
				RenderScriptCams(0,1,4000)
				SetCamActive(currentCam, false)
				DestroyCam(currentCam, false)
				ClearFocus()
				Citizen.InvokeNative(0x69D65E89FFD72313, false,false)
				SetEntityHealth(ped, GetEntityMaxHealth(ped))
				Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, (GetAttributeCoreValue(ped, 0) + 100))
				currentCam = nil
				DeleteEntity(spawnped)
				SetModelAsNoLongerNeeded(Config.Doctor)
				pressed = false
				spawnped = nil
				starttime = nil
				TriggerServerEvent('moped_doctor:checkout')
				break
			end
			DisableAllControlActions(0)
			if #Config.EnabledControls > 1 and Config.EnabledControls then 
				for i = 1, #Config.EnabledControls do
					EnableControlAction(0, Config.EnabledControls[i], true)
				end
			end
		end
	end)
end)
