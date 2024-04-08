RegisterNetEvent("fixanimals:attack")

AddEventHandler("fixanimals:attack", function(target, entity)
	TriggerClientEvent("fixanimals:attack", target, source, entity)
end)
