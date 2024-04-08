local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local coachModel;
local coachSpawn = {}
local NumberCoachSpawn = 0

local Coaches = {
	[1] = {
		['Text'] = "$20 SMALL CART level require [0]",
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 20,
			['Model'] = "CART02",
			['Level'] = 0
		}
	},
	[2] = {
		['Text'] = "$35 BIG COACH level require [3]",
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 35,
			['Model'] = "COACH2",
			['Level'] = 3
		}
	}
	
}

local function CreateBlips ( )
	for k,v in pairs(Config.Coords) do
		local blip = Citizen.InvokeNative( 0x554d9d53f696d002, 631964804, v.x, v.y, v.z)
	end
end

local function IsNearZone ( location )

	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for i=1,#location do
		if #(playerloc - location[i]) < 1.0 then
			return true
		end
	end

end

local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('id_Coach', 'Shop Coaches')
	while true do
		if WarMenu.IsMenuOpened('id_Coach') then
			for i = 1, #Coaches do
				if WarMenu.Button(Coaches[i]['Text'], Coaches[i]['SubText']) then
					TriggerServerEvent('elrp:buycoach', Coaches[i]['Param'])
			end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do

		if IsNearZone( Config.Coords ) then
			DisplayHelp(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
			if IsControlJustReleased(0, keys['E']) then
				WarMenu.OpenMenu('id_Coach')
			end
		end

		Citizen.Wait(0)
	end
end)

-- | Blips | --

Citizen.CreateThread(function()
	CreateBlips ( )
end)

-- | Notification | --

RegisterNetEvent('UI:DrawNotification')
AddEventHandler('UI:DrawNotification', function( _message )
	ShowNotification( _message )
end)

-- | Spawn Coach | --

RegisterNetEvent( 'elrp:spawnCoach' )
AddEventHandler( 'elrp:spawnCoach', function ( coach )

	local player = PlayerPedId()

	local model = GetHashKey( coach )
	local x,y,z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, 4.0, 0.5 ) )

	local heading = GetEntityHeading( player ) + 90

	local oldIdOfTheCoach = idOfTheCoach
	
	local idOfTheCoach = NumberCoachSpawn + 1

	RequestModel( model )

	while not HasModelLoaded( model ) do
		Wait(500)
	end

	if ( coachSpawn[idOfTheCoach] ~= oldIdOfTheCoach ) then
		DeleteEntity( coachSpawn[idOfTheCoach].model )
	end

	coachModel = CreateVehicle( model, x, y, z, heading, 1, 1 )

	SET_PED_DEFAULT_OUTFIT (coachModel)
	Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, coachModel)
	
	coachSpawn[idOfTheCoach] = { id = idOfTheCoach, model = coachModel }

end )


function SET_PED_DEFAULT_OUTFIT ( coach )
	return Citizen.InvokeNative(0xAF35D0D2583051B0, coach, true )
end



-- | Timer | --

RegisterCommand("callcoach", function(source, args, raw)
    if recentlySpawned <= 0 then
				recentlySpawned = 10
				TriggerServerEvent('elrp:loadcoach')
			else
				TriggerEvent('chat:systemMessage', 'Please wait ' .. recentlySpawned .. ' seconds before calling your coach.')
				TriggerEvent('chat:addMessage', {
					color = { 171, 59, 36 },
					multiline = true,
					args = {"Anti-Spam", 'Please wait ' .. recentlySpawned .. ' seconds before calling your coach.'}
				})
			end
   end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if recentlySpawned > 0 then
			recentlySpawned = recentlySpawned - 1
		end
    end
end)