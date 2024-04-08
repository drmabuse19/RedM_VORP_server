local OutfitVar = Config.OutfitVariation
local BlipSize = Config.BlipSize
local PedCollision = Config.PedCollision

local keys = {
    -- Letter E
    ["E"] = 0xCEFD9220,
}

local chatarra = Config.Chatarra

local function IsNearZone ( location )

	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for i = 1, #location do
		if #(playerloc - location[i]) < 2.2 then
			return true, i
		end
	end

end

---- spawn ped 
Citizen.CreateThread(function()
	local hashModel = GetHashKey(Config.Ped)
        -- Loading Model
    	if IsModelValid(hashModel) then 
           RequestModel(hashModel)
        while not HasModelLoaded(hashModel) do                
           Wait(100)
        end
    	end        
       -- Spawn Ped
		for k, v in pairs(Config.Blips) do
    		local npc = CreatePed(hashModel, v.x, v.y, v.z, v.h, false, true, true, true)
    		Citizen.InvokeNative(0x283978A15512B2FE, npc, OutfitVar) -- SetRandomOutfitVariation
    		SetEntityNoCollisionEntity(PlayerPedId(), npc, PedCollision)
    		SetEntityCanBeDamaged(npc, false)
    		SetEntityInvincible(npc, true)
    		Wait(1000)
    		FreezeEntityPosition(npc, true) -- NPC can't escape
    		SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
		end
end)



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

Citizen.CreateThread( function()
	WarMenu.CreateMenu('fence', 'Gold Exchange')
		repeat
		if WarMenu.IsMenuOpened('fence') then
			for i = 1, #chatarra do
				if WarMenu.Button(chatarra[i]['Text'], chatarra[i]['SubText'], chatarra[i]['Desc']) then
					TriggerServerEvent('gold:vender', chatarra[i]['Param']) 
				--	WarMenu.CloseMenu()
				end
				if WarMenu.Button(chatarra[i]['Text2'], chatarra[i]['SubText2'], chatarra[i]['Desc2']) then
					TriggerServerEvent('gold:revender', chatarra[i]['Param']) 
				--	WarMenu.CloseMenu()
				end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	until false
end)

Citizen.CreateThread(function()
	while true do
	local IsZone, IdZone = IsNearZone(Config.Coords)      
        if IsZone then 
		DisplayHelp(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
        if IsControlJustPressed(0, keys['E']) then
                WarMenu.OpenMenu('fence')
            end
        end
	Citizen.Wait(0)
	end
end)

RegisterNetEvent('UI:NotificaVenta')
AddEventHandler('UI:NotificaVenta', function( _message )
	TriggerEvent("vorp:TipRight", _message, 100)
end)

Citizen.CreateThread(function()
	while true do
		if Config.BlipToggle == True then
			Wait(1000)
		else
		for k, v in pairs(Config.Blips) do
        	local blip = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
				SetBlipSprite(blip, Config.BlipSprite, 1)
				SetBlipScale(blip, BlipSize)
				Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
			end
		end
	end
end)
