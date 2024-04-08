MapAPI = {}

function MapAPI.setFOW(toggle)
    SetMinimapHideFow(
        toggle
    )
end

function MapAPI.DisplayRadar(toggle)
    DisplayRadar(toggle)
end

function MapAPI.StartGps(start, finish)
    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(start.x, start.y, start.z)
    AddPointToGpsMultiRoute(finish.x, finish.y, finish.z)
    SetGpsMultiRouteRender(true)
end

function MapAPI.StopGps()
    ClearGpsMultiRoute()
end