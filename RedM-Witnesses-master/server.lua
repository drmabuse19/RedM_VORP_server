RegisterNetEvent("Witness:CheckJob")
AddEventHandler("Witness:CheckJob", function(players, coords)
    for each, player in ipairs(players) do
        TriggerEvent("vorp:getCharacter", player, function(user)
            if user ~= nil then

				
 exports.ghmattimysql:execute("SELECT * FROM jobs WHERE identifier = @identifier", {['@identifier'] = user.identifier}, function(results)
        local jobFound = false -- Flag to track if the expected job is found

        for _, result in ipairs(results) do
	    if result.name == "politi" then
		
                TriggerClientEvent("Witness:ToggleNotification", player, coords)

                break -- Exit the loop once the expected job is found
            end
        end

     
            end)




            end
        end)
    end
end)



