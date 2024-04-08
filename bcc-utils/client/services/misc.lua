MiscAPI = {}

function MiscAPI.DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.30, 0.30)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        DisplayText(str,_x,_y)
        local factor = (string.len(text)) / 225
        DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
    end
end

function MiscAPI.DistanceCheckEntity(x, y, z, entity, dist, usez)
    while true do
        Citizen.Wait(50)
        local ce = GetEntityCoords(entity)
        if GetDistanceBetweenCoords(x, y, z, ce.x, ce.y, ce.z, usez) < dist then return true end
        if IsEntityDead(entity) then return false end
    end
end

function MiscAPI.SetGps(x, y, z)
    local x2,y2,z2 = table.unpack(GetEntityCoords(PlayerPedId()))
    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(x2, y2, z2)
    AddPointToGpsMultiRoute(x, y, z)
    SetGpsMultiRouteRender(true)
end

function MiscAPI.RemoveGps()
    ClearGpsMultiRoute()
end