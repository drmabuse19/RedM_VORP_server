local current = nil

RegisterNetEvent('moped_doctor:checkin')
AddEventHandler('moped_doctor:checkin', function()
    local src = source
    local jobcount = 0
    if not current then
        if Config.Framework == 'vorp' then
            if Config.JobCheck then
                for _, playerId in pairs(GetPlayers()) do
                    for k,v in pairs(Config.JobName) do 
                        TriggerEvent("vorp:getCharacter",playerId,function(user)
                            if user.job == v then jobcount = jobcount + 1 end
                        end)
                    end
                end
            end

            if jobcount < Config.JobCount or not Config.JobCheck then
                local VORP = exports.vorp_core:vorpAPI()
                local user = VORP.getCharacter(src)
                local money = user.money
                local newmoney = money - Config.Money
                if newmoney >= 0 then
                    if not current then
                        VORP.removeMoney(src, 0, Config.Money)
                        current = src
                        TriggerClientEvent('moped_doctor:start', src)
                    else
                        TriggerClientEvent('moped_doctor:occupied', src)
                    end
                else
                    TriggerClientEvent('moped_doctor:notenoughmoney', src, tostring(newmoney):gsub("-",""))
                end
            else
                TriggerClientEvent('moped_doctor:toomuchpeoplewithjob', src)
            end
        elseif Config.Framework == 'redemrp' then
            if Config.JobCheck then
                for _, playerId in pairs(GetPlayers()) do
                    for k,v in pairs(Config.JobName) do 
                        TriggerEvent("redemrp:getPlayerFromId", playerId, function(user)
                            local job = user.getJob()
                            if job == v then jobcount = jobcount + 1 end
                        end)
                    end
                end
            end
            
            if jobcount < Config.JobCount or not Config.JobCheck then
                TriggerEvent('redemrp:getPlayerFromId', src, function(user)
                    local money = user.getMoney()
                    local newmoney = money - Config.Money
                    if newmoney >= 0 then
                        if not current then
                            user.removeMoney(Config.Money)
                            current = src
                            TriggerClientEvent('moped_doctor:start', src)                      
                        else
                            TriggerClientEvent('moped_doctor:occupied', src)
                        end
                    else 
                        TriggerClientEvent('moped_doctor:notenoughmoney', src, tostring(newmoney):gsub("-",""))
                    end
                end)
            else
                TriggerClientEvent('moped_doctor:toomuchpeoplewithjob', src)
            end
        elseif Config.Framework == 'standalone' then
            if not current then
                current = src
                TriggerClientEvent('moped_doctor:start', src)
            else
                TriggerClientEvent('moped_doctor:occupied', src)
            end
        end
    else
        TriggerClientEvent('moped_doctor:occupied', src)
    end
end)

RegisterNetEvent('moped_doctor:checkout')
AddEventHandler('moped_doctor:checkout', function()
    local src = source
    if current == src then
        current = nil
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if current == src then
        print('Player ' .. src .. ' dropped while doctor was taking care of them. Removing them from being the current pacient. (Reason: ' .. reason .. ')')
        current = nil
    end
end)