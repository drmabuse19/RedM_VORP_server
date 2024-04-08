local currentZoom = 1
local change_zoom = false

local radar_configs = {
    [1] = 0x25B517BF,   -- zoom 0.00000000"
    [2] = 0x7BFC01D8,   -- zoom 1.10000000"
    [3] = 0x8997C4AF,   -- zoom 2.20000000"
    [4] = 0x8C251CF0,   -- zoom 2.50000000"
    [5] = 0x1B2D4031,   -- zoom 3.00000000"
    [6] = 0x874D8F10,   -- zoom 3.50000000"
    [7] = 0xEF4631D2,   -- zoom 4.00000000"
    [8] = 0xF4BB863C,   -- zoom 5.00000000"
    [9] = 0xD0F4B483,   -- zoom 7.00000000"
    [10] = 0xDF5DB58C,   -- zoom 10.00000000"
}
  
Citizen.CreateThread(function()
    Citizen.InvokeNative(0x9C113883487FD53C, radar_configs[currentZoom], 0)
    while true do
        Citizen.Wait(1)
        if change_zoom == false then 
            DisableControlAction(0, 3156927250, true) --Disable control key "4", this key has 2 hashes
            if Citizen.InvokeNative(0x580417101DDB492F, 0, 2875386263) then --control key "5"
                change_zoom = true
                currentZoom = currentZoom +1
                if currentZoom > #radar_configs then 
                    currentZoom = 1
                end
                Citizen.InvokeNative(0x9C113883487FD53C, radar_configs[currentZoom], 0)
                Citizen.Wait(600)
                change_zoom = false
            elseif Citizen.InvokeNative(0x580417101DDB492F, 0, 2409602648) then --control key "4"
                change_zoom = true
                currentZoom = currentZoom - 1
                if currentZoom <= 0 then 
                    currentZoom = #radar_configs
                end
                Citizen.InvokeNative(0x9C113883487FD53C, radar_configs[currentZoom], 0)
                Citizen.Wait(600)
                change_zoom = false
            end
        end
    end
end)
