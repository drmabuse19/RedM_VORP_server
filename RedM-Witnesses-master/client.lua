local debug = false

RegisterNetEvent("Witness:ToggleNotification")
AddEventHandler("Witness:ToggleNotification", function(coords)
		TriggerEvent("vorp:Tip", 'A witness needs help!', 3000)

	Wait(120000)
	RemoveBlip(blip)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if IsPedShooting(PlayerPedId()) then
            local retval, target = GetEntityPlayerIsFreeAimingAt(PlayerId())

            
				local random = math.random(1, 100)

				if random <= 60 then -- 3/10 chance a witness will see player
					CreateWitness(target)
				end
                    end
    end
end)

function CreateWitness(target)
    local coords = GetEntityCoords(PlayerPedId())

	local witness = GetClosestPed(target, coords)

	if witness ~= nil then
		Debug("WITNESS CREATED")

        
        Wait(500)

		HandleBlips(witness)
Wait(1000)

       

        if IsPedDeadOrDying(witness) then
			Debug("WITNESS KILLED AFTER 30 SECONDS")
			DeleteWitness(blip, witness, crow)
        else
			Debug("NOTIFYING SHERIFF")
			DeleteWitness(blip, witness, crow)
            TriggerServerEvent("Witness:CheckJob", GetPlayers(), coords)
        end
	else
		Debug("NO WITNESS NEARBY")
	end
end

function CreateCrow(coords)
	local model = GetHashKey("A_C_Crow_01")

	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(100)
	end

	crow = CreatePed(model, coords.x, coords.y + 100.0, coords.z, 87.496, true, true, true, true)
	Citizen.InvokeNative(0x283978A15512B2FE, crow, true)
end

function HandleBlips(witness)
	for i = 1, 5 do
		if not IsPedDeadOrDying(witness) then
			Debug("FLASHING BLIP")
			local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, 1260140857, witness)
			Wait(1000)
		else
			Debug("WITNESS WAS KILLED")
		end
	end
end

function GetClosestPed(target, coords)
	local itemSet = CreateItemset(true)
	local size = Citizen.InvokeNative(0x59B57C4B06531E1E, coords, 20.0, itemSet, 1, Citizen.ResultAsInteger())

	if size > 0 then
		for index = 0, size - 1 do
			local entity = GetIndexedItemInItemset(index, itemSet)

			if not IsPedAPlayer(entity) then
				if entity ~= target then
					if GetPedType(entity) == 4 or GetPedType(entity) == 5 and IsPedOnFoot(entity) then
						print(entity)
						print(entity, target)
						print(GetPedType(entity))

						return entity
					end
				end
			end
		end
	else
		Debug("ITEMSET NATIVE BROKEN")
	end

	if IsItemsetValid(itemSet) then
	   DestroyItemset(itemSet)
	end
end

function DeleteWitness(blip, witness, crow)
	RemoveBlip(blip)
	DeletePed(crow)
	SetPedAsNoLongerNeeded(witness)
end

function Debug(text)
	if debug then
		local timer = 100

		Citizen.CreateThread(function()
			while timer > 0 do
				Citizen.Wait(0)
				local string = CreateVarString(10, "LITERAL_STRING", "DEBUG: " .. text)
				SetTextColor(255, 255, 255, 255)
				SetTextFontForCurrentCommand(0)
				SetTextScale(0.3, 0.3)
				SetTextDropshadow(1, 0, 0, 0, 255)
				SetTextCentre(true)
				DisplayText(string, 0.5, 0.85)
				timer = timer - 1
			end
		end)
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end
