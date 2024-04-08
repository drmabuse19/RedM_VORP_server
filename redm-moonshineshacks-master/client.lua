local ClosestTeleport

local PromptGroup = UipromptGroup:new("Moonshine Shack")
local Prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Enter", PromptGroup)
Prompt:setHoldMode(true)
Prompt:setOnHoldModeJustCompleted(function(prompt, destination)
	SetEntityCoordsAndHeadingNoOffset(PlayerPedId(), ClosestTeleport.destination)
end)

function SetEntityCoordsAndHeadingNoOffset(entity, xPos, yPos, zPos, heading, p5, p6)
	return Citizen.InvokeNative(0x0918E3565C20F03C, entity, xPos, yPos, zPos, heading, p5, p6)
end

function BlipAddForCoord(blipHash, x, y, z)
	return Citizen.InvokeNative(0x554D9D53F696D002, blipHash, x, y, z)
end

function ActivateMoonshineShack(shack)
	for _, imap in ipairs(shack.imaps) do
		RequestImap(imap)
	end

	if IsValidInterior(shack.interiorId) then
		if IsInteriorEntitySetActive(shack.interiorId, shack.interiorEntitySets[1]) then
			print(shack.label .. " interior is already active")
		else
			for _, set in ipairs(shack.interiorEntitySets) do
				ActivateInteriorEntitySet(shack.interiorId, set)
			end

			print(shack.label .. " interior activated")
		end
	end

	shack.blip = BlipAddForCoord(1664425300, shack.entrance.xyz)
	SetBlipSprite(shack.blip, Config.BlipSprite, true)
end

function DeactivateMoonshineShack(shack)
	for _, imap in ipairs(shack.imaps) do
		RemoveImap(imap)
	end

	if IsValidInterior(shack.interiorId) then
		if IsInteriorEntitySetActive(shack.interiorId, shack.interiorEntitySets[1]) then
			for _, set in ipairs(shack.interiorEntitySets) do
				DeactivateInteriorEntitySet(shack.interiorId, set, true)
			end

			print(shack.label .. " interior deactived")
		else

			print(shack.label .. " interior is not active")
		end
	end

	RemoveBlip(shack.blip)
end

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		for _, shack in ipairs(Config.MoonshineShacks) do
			DeactivateMoonshineShack(shack)
		end
	end
end)

CreateThread(function()
	for _, shack in ipairs(Config.MoonshineShacks) do
		ActivateMoonshineShack(shack)
	end
end)

CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())
		local closestTeleport

		for _, shack in ipairs(Config.MoonshineShacks) do
			local distance = #(playerCoords - shack.entrance.xyz)

			if distance < Config.TeleportDistance then
				closestTeleport = {
					action = "Enter",
					label = shack.label,
					destination = shack.exit
				}

				break
			end

			distance = #(playerCoords - shack.exit.xyz)

			if distance < Config.TeleportDistance then
				closestTeleport = {
					action = "Exit",
					label = shack.label,
					destination = shack.entrance
				}

				break
			end
		end

		ClosestTeleport = closestTeleport

		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		if ClosestTeleport then
			PromptGroup:setText(ClosestTeleport.label)
			Prompt:setText(ClosestTeleport.action)
			PromptGroup:handleEvents(ClosestTeleport.destination)
		end

		Wait(0)
	end
end)
