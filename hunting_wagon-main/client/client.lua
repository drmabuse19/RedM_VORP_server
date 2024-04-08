local prompt = false
local AnimalPrompt


local cart = {
   "huntercart01",
    "ArmySupplyWagon",
    "buggy01",
    "buggy02",
    "buggy03",
    "cart01",
    "cart02",
    "cart03",
    "cart04",
    "cart05",
    "cart06",
    "cart07",
    "cart08",
    "chuckwagon000x",
    "chuckwagon002x",
    "gatchuck",
    "utilliwag",
    "wagon02x",
    "wagon03x",
    "wagon04x",
    "wagon05x",
    "wagon06x",
    "coach2",
    "coach3",
    "coach4",
    "coach5",
    "coach6",
    "coal_wagon",
    "logwagon",
    "logwagon2",
    "oilWagon01x",
    "oilWagon02x",
    "stagecoach001x",
    "stagecoach002x",
    "stagecoach003x",
    "stagecoach004x",
    "stagecoach005x",
    "stagecoach006x",
    "supplywagon",
    "supplywagon2",
    "wagonarmoured01x",
    "wagonCircus01x",
    "wagonCircus02x",
    "wagondairy01x",
    "wagondoc01x",
    "wagonPrison01x",
    "wagontraveller01x",
    "wagonwork01x",
 }



function SetupAnimalPrompt()
    Citizen.CreateThread(function()
        local str = 'Put in cart'
        AnimalPrompt = PromptRegisterBegin()
        PromptSetControlAction(AnimalPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(AnimalPrompt, str)
        PromptSetEnabled(AnimalPrompt, false)
        PromptSetVisible(AnimalPrompt, false)
        PromptSetHoldMode(AnimalPrompt, true)
        PromptRegisterEnd(AnimalPrompt)

    end)
end
-- Define a list of predefined positions for up to 10 animals
local predefinedPositions = {
    {y = -1.25, x = -0.2}, {y = -0.75, x = -0.2}, {y = -0.25, x = -0.2}, {y = 0.50, x = -0.2}, -- First 5 positions on base layer
   {y = -1.25, x = 0.2}, {y = -0.75, x = 0.2}, {y = -0.25, x = 0.2}, {y = 0.50, x = 0.2} -- Next 5 positions on upper layer
}

-- Keep track of the number of animals stored
local animalCount = 0

-- Function to get the next predefined position
function getNextPosition()
    animalCount = animalCount + 1
    local pos = predefinedPositions[animalCount]
    if animalCount <= 5 then
        return pos.x, pos.y, 0 -- Base layer
    else
        return pos.x, pos.y, 0.25 -- Upper layer
    end
end
Citizen.CreateThread(function()
	SetupAnimalPrompt()
	while true do 
		Wait(100)
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
		forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
		local Pos2 = GetEntityCoords(ped)
		local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
		local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
		local A,hit,C,C,spot = GetShapeTestResult(rayCast) 
		local veh = GetVehiclePedIsIn(ped, true) 
		
		--local model = veh
		local model = GetEntityModel(spot)
		cartcoords = GetEntityCoords(spot)
		for i,v in pairs(cart) do
			if model == GetHashKey(v) then
		--if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, cartcoords.x, cartcoords.y, cartcoords.z,  true) < 5.0 then
			--print('asdsads')
				if model ~= nil then --1347283941 : cart03 --1758092337 : WAGON05X
					local animal = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
					if animal ~= false then
						if prompt == false then
							PromptSetEnabled(AnimalPrompt, true)
							PromptSetVisible(AnimalPrompt, true)
							prompt = true
						end
						if PromptHasHoldModeCompleted(AnimalPrompt) then
							PromptSetEnabled(AnimalPrompt, false)
							PromptSetVisible(AnimalPrompt, false)
							prompt = false
							animalcheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
							pedid = NetworkGetNetworkIdFromEntity(animalcheck)
							Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), animalcheck, GetEntityCoords(PlayerPedId()), 10.0, true)
							--DoScreenFadeOut(1800)
							Wait(2000)
							-- Inside your if PromptHasHoldModeCompleted(AnimalPrompt) then block, after checking the number of animals:
							if animalCount < 8 then
   								local xOffset, yOffset, zOffset = getNextPosition()

  							  	-- Now use xOffset, yOffset, and zOffset when setting the animal's position and attaching it to the cart
 								local finalX = cartcoords.x + xOffset
    								local finalY = cartcoords.y + yOffset
    								local finalZ = cartcoords.z + zOffset
    								TriggerServerEvent('EveryoneTeleportEntity', pedid, finalX, finalY, finalZ)
    								SetEntityCoords(animalcheck, finalX, finalY, finalZ, false)
   								AttachEntityToEntity(animalcheck, spot, 0, xOffset, yOffset, zOffset + 0.5, -90.0, 0.0, 0.0, false, true, false, false, 2, true)
							end
							--DoScreenFadeIn(3000)
							Wait(2000)
						end

						forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
						local Pos2 = GetOffsetFromEntityInWorldCoords(ped, -0.0, 0.0,0.5)
						local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
						local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
						A,hit,B,C,spot = GetShapeTestResult(rayCast)
						NetworkRequestControlOfEntity(animalcheck)
						model = GetEntityModel(spot)
					else
						PromptSetEnabled(AnimalPrompt, false)
						PromptSetVisible(AnimalPrompt, false)
						prompt = false
					end
				else
					PromptSetEnabled(AnimalPrompt, false)
					PromptSetVisible(AnimalPrompt, false)
					prompt = false
				end
			end
		end
		-- else
		-- 		PromptSetEnabled(AnimalPrompt, false)
		-- 		PromptSetVisible(AnimalPrompt, false)
		-- 		prompt = false
		-- end
	end
end)


RegisterNetEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(netid,x,y,z)
	ent = NetworkGetEntityFromNetworkId(netid)
	Wait(150)
	SetEntityCoords(ent,x,y,z)
end)	