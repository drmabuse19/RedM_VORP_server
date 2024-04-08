BlipAPI = {}

function BlipAPI:SetBlip(name, sprite, scale, x, y, z, blipVector)
    local BlipClass = {}

    if not blipVector then
        BlipClass.rawblip =  Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(x, y, z))
        BlipClass.x = x
        BlipClass.y = y
        BlipClass.z = z
    else
        BlipClass.rawblip =  Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, blipVector)
        BlipClass.vector3 = blipVector
    end

    if type(sprite) == "string" then
        sprite = joaat(sprite)
    end
    SetBlipSprite(BlipClass.rawblip, sprite, true)
    SetBlipScale(BlipClass.rawblip, scale)
    Citizen.InvokeNative(0x9CB1A1623062F402, BlipClass.rawblip, name)

    function BlipClass:Get()
        return self.rawblip
    end

    function BlipClass:Remove()
        RemoveBlip(self.rawblip)
        self.rawblip = nil
    end

    return BlipClass
end

function BlipAPI:SetRadius(hash, radius, x, y, z)
    local RadiusClass = {}

    RadiusClass.rawrad = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, x, y, z, radius)

    if hash then
        Citizen.InvokeNative(0x74F74D3207ED525C, RadiusClass.rawrad, hash or -1282792512, true)
    end

    RadiusClass.x = x
    RadiusClass.y = y
    RadiusClass.z = z
    
    function RadiusClass:Get()
        return self.rawrad
    end

    function RadiusClass:Remove()
        RemoveBlip(self.rawrad)
        self.rawrad = nil
    end

    return RadiusClass
end

function BlipAPI:RemoveBlip(blip)
    RemoveBlip(blip)
end