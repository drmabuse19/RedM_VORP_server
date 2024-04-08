-- function a() return 'b' end
-- local minutes = 20
-- --> Minutos to give. By default is 15

-- -- RegisterNetEvent("vorp:SelectedCharacter")
-- -- AddEventHandler("vorp:SelectedCharacter", function(charid)
-- --     -- Code here will be executed once the event is triggered.
-- --     -- Like a getcharacter or load db data, etc ....
-- -- 	Citizen.CreateThread(function(...)
-- -- 		while true do
-- -- 		Citizen.Wait(minutes*60000)
-- -- 			TriggerServerEvent('salaryJobs:GIVE',"0x089027928098908_", a());
-- -- 		end
-- -- 	end)
-- -- end)


function a() return 'b' end
local minutes = 20
--> Minutos to give. By default is 15
Citizen.CreateThread(function(...)
	while true do
	Citizen.Wait(minutes*60000)
		TriggerServerEvent('salaryJobs:GIVE',"0x089027928098908_", a());
	end
end)
