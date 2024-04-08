
RegisterServerEvent('buy:guard')
AddEventHandler('buy:guard', function(price,gard)
local _source = source
        TriggerClientEvent('loadguard', source, gard)
       end)
end)