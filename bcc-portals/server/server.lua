local VORPcore = exports.vorp_core:GetCore()

VORPcore.Callback.Register('bcc-portals:GetTravelData', function(source, cb, travelInfo)
    local travelLoc = travelInfo.location
    local distance = #(travelInfo.coords - Config.shops[travelLoc].npc.coords)
    local cashPrice = 0
    local goldPrice = 0
    if Config.price > 0 then
        cashPrice = math.ceil(distance * Config.price)
        goldPrice = math.ceil(cashPrice / 20.67) -- 1899 Gold Price = $20.67
    end
    local time = math.floor(distance * Config.time)
    local displayTime = ConvertToTime(time)
    local travelData = { location = travelLoc, cash = cashPrice, gold = goldPrice, timeMs = time, dispTime = displayTime }

    cb(travelData)
end)

function ConvertToTime(ms)
    local seconds = math.ceil(ms / 1000)
    local mins = math.floor(seconds / 60)
    local secs = math.ceil(seconds % 60)
    local realTime = { minutes = mins, seconds = secs }
    return realTime
end

VORPcore.Callback.Register('bcc-portals:GetPlayerCanTravel', function(source, cb, canTravelInfo)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local currency = canTravelInfo.currency
    local price = canTravelInfo.price

    if currency == 'cash' then
        if Character.money >= price then
            Character.removeCurrency(0, price)
            cb(true)
        else
            VORPcore.NotifyRightTip(src, _U('shortCash'), 4000)
            cb(false)
        end
    elseif currency == 'gold' then
        if Character.gold >= price then
            Character.removeCurrency(1, price)
            cb(true)
        else
            VORPcore.NotifyRightTip(src, _U('shortGold'), 4000)
            cb(false)
        end
    elseif currency == 'free' then
        cb(true)
    end
end)

VORPcore.Callback.Register('bcc-portals:CheckJob', function(source, cb, portal)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local charJob = Character.job
    local jobGrade = Character.jobGrade
    if not charJob then
        cb(false)
        return
    end
    local hasJob = false
    hasJob = CheckPlayerJob(charJob, jobGrade, portal)
    if hasJob then
        cb(true)
    else
        VORPcore.NotifyRightTip(src, _U('needJob'), 4000)
        cb(false)
    end
end)

function CheckPlayerJob(charJob, jobGrade, portal)
    for _, job in pairs(Config.shops[portal].shop.jobs) do
        if (charJob == job.name) and (tonumber(jobGrade) >= tonumber(job.grade)) then
            return true
        end
    end
end
