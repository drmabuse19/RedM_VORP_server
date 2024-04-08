MathAPI = {}

function MathAPI.GetDistanceBetween(first, second)
    return #(first - second)
end

function MathAPI:instanced()
    local inst = {
        usedInts = {}
    }

    function inst:GetRandomInt()
        local rando = math.random(1, 2000)

        while self.usedInts[rando] do
            rando = math.random(1, 2000)
            Citizen.Wait(1)
        end

        return rando
    end

    return inst
end