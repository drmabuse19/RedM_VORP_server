local time = 0
local count = 0

--==================================
--==== SAFE ZONE SCRIPT MADE BY ====
--====      Le Bookmaker        ====
--====      Bonermanceer        ====
--====         ENJOY            ====
--==================================

-- Disable Weapon Attack and Melee Attack
Citizen.CreateThread(function()	
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end		
	while true do 
		Citizen.Wait(10)	 
		for i = 1, #Config.zones, 1 do
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local betweencoords = GetDistanceBetweenCoords(coords, Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, true)
			local distance = false
			--print(betweencoords)
			if betweencoords <= Config.safeRadius then
				time = 0
				count = 0
				TriggerEvent('vorp_safeZone:startTimerIn')
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
			end
			if betweencoords >= Config.safeRadius then 
				if time < 100 then
					time = time + 1
					--print(count)
					DrawTxt(Language.translate[Config.lang]['out'], 0.50, 0.95, 0.3, 0.3, true, 255, 255, 255, 255, true)
					NetworkSetFriendlyFireOption(true)
					if time == 100 then
						count = count + 1
						if count < 8 then
							time = 0							
						end
						if count > 8 then 
							Citizen.Wait(30000)
							count = 0 
							time = 0
							break
						end						
					end	
				end 			
			end
		end
	end
end)

RegisterNetEvent('vorp_safeZone:startTimerIn')
AddEventHandler('vorp_safeZone:startTimerIn', function()
		--print('InSafeZone')
		DrawTxt(Language.translate[Config.lang]['in'], 0.50, 0.95, 0.3, 0.3, true, 255, 255, 255, 255, true)
		DisablePlayerFiring(playerPed, true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
      	DisableControlAction(0, 0x07CE1E61, true) -- Disable attack  control
      	DisableControlAction(0, 0xB2F377E8, true) -- Disable MeleeAttack control
end)

-- Creating Blip at the locations. 
Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	for i = 1, #Config.zones, 1 do
		--Citizen.InvokeNative(0x554d9d53f696d002, 1560611276, Config.zones[i].x, Config.zones[i].y, Config.zones[i].z) -- Add blip icon<
		Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, Config.safeRadius) -- Add yellow zone
	end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then 
		SetTextDropshadow(1, 0, 0, 0, 255) 
	end
	Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(str, x, y)
end