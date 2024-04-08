local picked = {}
local closestree = false
local pickmango_prompt = Uiprompt:new(`INPUT_INTERACT_OPTION1`, "Pick Mango")
local sharedItems = exports['qbr-core']:GetItems()
function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

pickmango_prompt:setStandardMode(true)
pickmango_prompt:setOnStandardModeJustCompleted(function()
pickmango_prompt:setEnabledAndVisible(false)
    picked[closestree] = true
    loadAnimDict("mech_pickup@plant@orchid_tree")
    TaskPlayAnim(PlayerPedId(), "mech_pickup@plant@orchid_tree", "base", 8.0, -4.0, -1, 1, 0.0, false, 0, false, 0, false)  
    Wait(6000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('QBCore:Server:AddItem', "mango", math.random(1,5))
    TriggerEvent("inventory:client:ItemBox", sharedItems["mango"], "add")
end)

pickmango_prompt:setEnabledAndVisible(false)
function onEntermango(self)
    closestree = self.id
    if picked[self.id] == nil then
        pickmango_prompt:setEnabledAndVisible(true)
    end
end

function onExitmango(self)
    pickmango_prompt:setEnabledAndVisible(false)
end

function inside(self)
    pickmango_prompt:handleEvents(PlayerPedId())
end

local pickmango_sphere1 = lib.zones.sphere({
    coords = vec3(993.7138, -6961.25, 43.272),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere2 = lib.zones.sphere({
    coords = vec3(986.7717, -6962.26, 43.377),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere3 = lib.zones.sphere({
    coords = vec3(977.5544, -6961.02, 43.223),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere4 = lib.zones.sphere({
    coords = vec3(969.6485, -6965.95, 43.138),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere5 = lib.zones.sphere({
    coords = vec3(961.6228, -6958.76, 43.157),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere6 = lib.zones.sphere({
    coords = vec3(969.3676, -6956.97, 43.119),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere7 = lib.zones.sphere({
    coords = vec3(979.6033, -6955.06, 43.197),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere8 = lib.zones.sphere({
    coords = vec3(988.3757, -6952.36, 43.149),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere9 = lib.zones.sphere({
    coords = vec3(983.5478, -6947.66, 43.024),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere10 = lib.zones.sphere({
    coords = vec3(974.9394, -6950.54, 43.120),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere11 = lib.zones.sphere({
    coords = vec3(967.8331, -6948.36, 43.090),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere12 = lib.zones.sphere({
    coords = vec3(967.2100, -6940.35, 43.057),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere13 = lib.zones.sphere({
    coords = vec3(975.0281, -6942.74, 43.052),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere14 = lib.zones.sphere({
    coords = vec3(982.3746, -6940.63, 42.884),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere15 = lib.zones.sphere({
    coords = vec3(977.8351, -6935.47, 42.945),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere16 = lib.zones.sphere({
    coords = vec3(968.0994, -6939.77, 43.040),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere17 = lib.zones.sphere({
    coords = vec3(969.6158, -6933.83, 43.014),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere18 = lib.zones.sphere({
    coords = vec3(963.6723, -6934.24, 43.147),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})
local pickmango_sphere19 = lib.zones.sphere({
    coords = vec3(965.9651, -6927.70, 43.001),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntermango,
    onExit = onExitmango

})