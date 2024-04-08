local starting = false
local already = false
local createdped = {}
local count = {}
local pressing = false

function missionstart()
							
	starting = true
	animals = {
	{hash = 0xF90FDED2, x = -277.64, y = 816.81, z = 119.13, true, true}
			  }
			  
	for k,item in pairs(animals) do
		createdped[k] = CreatePed(item.hash, item.x, item.y, item.z, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, createdped[k], true)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped[k])
		count[k] = (createdped[k])
	end

	Citizen.CreateThread(function()
		local x = #animals
			while starting == true do
			Citizen.Wait(0)
			for k,v in pairs(createdped) do
					if IsEntityDead(v) then
						if count[k] ~= nil then
							x = x - 1
							count[k] = nil
							if x == 0 then
							TriggerServerEvent('wvrp_bountyhunting:AddSomeMoney')
							Citizen.InvokeNative(0x4AD96EF928BD4F9A, hash)
							stopmission()
						end
					end
				end
			end
		end
	end)
end

function stopmission()
	pressing = false
	starting = false
	already = false
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

function startdialog()
	Citizen.CreateThread(function()
	  local timetocheck = 600
		while timetocheck >= 0  do
			Citizen.Wait(0)
			DrawTxt(Config.KillingMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			timetocheck = timetocheck - 1
		end
	end)
end

function startscenario()
		DisplayHud(true)
	DisplayRadar(true)
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords,  -277.52,  815.38, 119.23, true)
		if betweencoords < 2.0 and not already then
			DrawTxt(Config.HuntingMessage, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustPressed(2, 0xCEFD9220) and not pressing then
				pressing = true
								
				missionstart()
				already = true
				startscenario()
			end
		end
	end
end)



