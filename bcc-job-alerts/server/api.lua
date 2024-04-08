local RegisterAlert = function(alert)
    local AlertClass = {}
    AlertClass.alert = alert

    RegisterAlert(alert)

    function AlertClass:SendAlert(src)
        AlertPlayer(src, self.alert)
    end

    return AlertClass
end

exports('RegisterAlert', RegisterAlert)