local car

RegisterNetEvent('syn_cannon:spawncannon')
AddEventHandler('syn_cannon:spawncannon', function(type)
    if car ~= nil then 
        DeleteVehicle(car)
    end

    if type == 1 then 
        local ped = PlayerPedId()
        local car_start = GetEntityCoords(ped)
        local car_name = "breach_cannon"
        local carHash = GetHashKey(car_name)
        RequestModel(carHash)

        while not HasModelLoaded(carHash) do
            Citizen.Wait(0)
        end
        car = CreateVehicle(carHash, car_start.x + 1, car_start.y + 1, car_start.z, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(car)
        Wait(200)
        SetModelAsNoLongerNeeded(carHash) 

    elseif type == 2 then
        local ped = PlayerPedId()
        local car_start = GetEntityCoords(ped)
        local car_name = "hotchkiss_cannon"
        local carHash = GetHashKey(car_name)
        RequestModel(carHash)

        while not HasModelLoaded(carHash) do
            Citizen.Wait(0)
        end

        car = CreateVehicle(carHash, car_start.x + 1, car_start.y + 1, car_start.z, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(car)
        Wait(200)
        SetModelAsNoLongerNeeded(carHash) 

    end
end)

RegisterNetEvent('syn_cannon:rotate')
AddEventHandler('syn_cannon:rotate', function(rotation)
    if car ~= nil then 
        local pedRot = GetEntityHeading(car) + rotation
        SetEntityHeading(car, pedRot % 360)
    end

end)

