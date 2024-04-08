RegisterNetEvent("lightning-attacks:strike")

local function getPlayerId(nameOrId)
	local players = GetPlayers()

	for _, playerId in ipairs(players) do
		if playerId == nameOrId then
			return tonumber(playerId)
		end
	end

	nameOrId = string.lower(nameOrId)

	for _, playerId in ipairs(players) do
		if string.lower(GetPlayerName(playerId)) == nameOrId then
			return tonumber(playerId)
		end
	end
end

AddEventHandler("lightning-attacks:strike", function(targetPos)
	for _, player in ipairs(GetPlayers()) do
		if player == source then
			TriggerClientEvent("lightning-attacks:strike", player, targetPos, true)
		else
			TriggerClientEvent("lightning-attacks:strike", player, targetPos, false)
		end
	end
end)

RegisterCommand("lightningattacks", function(source, args, raw)
	TriggerClientEvent("lightning-attacks:toggle", source)
end, true)

RegisterCommand("smite", function(source, args, raw)
	local id = getPlayerId(args[1])

	if id then
		TriggerClientEvent("lightning-attacks:smite", id)
	end
end, true)
