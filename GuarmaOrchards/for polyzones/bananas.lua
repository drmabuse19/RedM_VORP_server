local picked = {}
local closestree = false
local pickbanana_prompt = Uiprompt:new(`INPUT_INTERACT_OPTION1`, "Pick Banana")
local sharedItems = exports['qbr-core']:GetItems()
function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

pickbanana_prompt:setStandardMode(true)
pickbanana_prompt:setOnStandardModeJustCompleted(function()
pickbanana_prompt:setEnabledAndVisible(false)
    picked[closestree] = true
    loadAnimDict("mech_pickup@plant@orchid_tree")
    TaskPlayAnim(PlayerPedId(), "mech_pickup@plant@orchid_tree", "base", 8.0, -4.0, -1, 1, 0.0, false, 0, false, 0, false)  
    Wait(6000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('QBCore:Server:AddItem', "banana", math.random(1,5))
    TriggerEvent("inventory:client:ItemBox", sharedItems["banana"], "add")
end)


pickbanana_prompt:setEnabledAndVisible(false)
function onEnterbanana(self)
    closestree = self.id
    if picked[self.id] == nil then
        pickbanana_prompt:setEnabledAndVisible(true)
    end
end

function onExitbanana(self)
    pickbanana_prompt:setEnabledAndVisible(false)
end

function inside(self)
    pickbanana_prompt:handleEvents(PlayerPedId())
end

local pickbanana_sphere1 = lib.zones.sphere({
    coords = vec3(1112.684, -7075.41, 48.626),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere2 = lib.zones.sphere({
    coords = vec3(1115.126, -7080.10, 48.639),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere3 = lib.zones.sphere({
    coords = vec3(1116.916, -7083.63, 48.599),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere4 = lib.zones.sphere({
    coords = vec3(1119.013, -7086.69, 48.494),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere5 = lib.zones.sphere({
    coords = vec3(1122.003, -7089.21, 48.256),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere6 = lib.zones.sphere({
    coords = vec3(1126.734, -7092.05, 47.611),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere7 = lib.zones.sphere({
    coords = vec3(1130.963, -7095.85, 46.299),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere8 = lib.zones.sphere({
    coords = vec3(1134.692, -7098.61, 45.992),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere9 = lib.zones.sphere({
    coords = vec3(1137.743, -7101.00, 46.588),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere10 = lib.zones.sphere({
    coords = vec3(1129.199, -7106.79, 47.842),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere11 = lib.zones.sphere({
    coords = vec3(1124.575, -7102.47, 48.661),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere12 = lib.zones.sphere({
    coords = vec3(1120.529, -7099.26, 49.018),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere13 = lib.zones.sphere({
    coords = vec3(1116.770, -7096.09, 49.215),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere14 = lib.zones.sphere({
    coords = vec3(1112.572, -7093.31, 49.419),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere15 = lib.zones.sphere({
    coords = vec3(1108.272, -7090.21, 49.672),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
local pickbanana_sphere16 = lib.zones.sphere({
    coords = vec3(1105.284, -7087.14, 49.634),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEnterbanana,
    onExit = onExitbanana

})
