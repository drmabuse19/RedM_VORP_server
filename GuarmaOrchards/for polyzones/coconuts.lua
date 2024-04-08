local picked = {}
local closestree = false
local pickcoconut_prompt = Uiprompt:new(`INPUT_INTERACT_OPTION1`, "Pick Coconut")
local sharedItems = exports['qbr-core']:GetItems()
function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

pickcoconut_prompt:setStandardMode(true)
pickcoconut_prompt:setOnStandardModeJustCompleted(function()
pickcoconut_prompt:setEnabledAndVisible(false)
    picked[closestree] = true
    loadAnimDict("mech_pickup@plant@orchid_tree")
    TaskPlayAnim(PlayerPedId(), "mech_pickup@plant@orchid_tree", "base", 8.0, -4.0, -1, 1, 0.0, false, 0, false, 0, false)  
    Wait(6000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('QBCore:Server:AddItem', "coconut", math.random(1,5))
    TriggerEvent("inventory:client:ItemBox", sharedItems["coconut"], "add")
end)


pickcoconut_prompt:setEnabledAndVisible(false)
function onEntercoconut(self)
    closestree = self.id
    if picked[self.id] == nil then
        pickcoconut_prompt:setEnabledAndVisible(true)
    end
end

function onExitcoconut(self)
    pickcoconut_prompt:setEnabledAndVisible(false)
end

function inside(self)
    pickcoconut_prompt:handleEvents(PlayerPedId())
end

local pickcoconut_sphere1 = lib.zones.sphere({
    coords = vec3(770.6440, -6995.19, 44.621),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere2 = lib.zones.sphere({
    coords = vec3(758.2105, -6994.77, 42.955),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere3 = lib.zones.sphere({
    coords = vec3(778.9721, -7012.38, 47.025),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere4 = lib.zones.sphere({
    coords = vec3(768.5157, -7008.54, 45.573),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere5 = lib.zones.sphere({
    coords = vec3(760.2705, -7008.90, 44.496),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere6 = lib.zones.sphere({
    coords = vec3(752.0808, -7013.67, 43.473),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere7 = lib.zones.sphere({
    coords = vec3(780.9247, -7026.58, 48.448),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere8 = lib.zones.sphere({
    coords = vec3(771.9117, -7019.48, 46.695),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere9 = lib.zones.sphere({
    coords = vec3(751.9584, -7014.26, 43.470),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere10 = lib.zones.sphere({
    coords = vec3(758.4132, -7019.82, 45.024),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere11 = lib.zones.sphere({
    coords = vec3(782.8190, -7038.79, 49.653),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere12 = lib.zones.sphere({
    coords = vec3(763.9779, -7034.88, 46.487),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere13 = lib.zones.sphere({
    coords = vec3(759.5576, -7027.52, 45.425),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere14 = lib.zones.sphere({
    coords = vec3(741.4963, -7021.30, 42.111),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere15 = lib.zones.sphere({
    coords = vec3(768.4639, -7044.16, 47.716),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere16 = lib.zones.sphere({
    coords = vec3(755.1141, -7042.22, 45.809),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere17 = lib.zones.sphere({
    coords = vec3(750.5385, -7033.72, 44.356),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere18 = lib.zones.sphere({
    coords = vec3(741.8433, -7022.08, 42.194),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere19 = lib.zones.sphere({
    coords = vec3(738.7088, -7033.30, 42.303),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere20 = lib.zones.sphere({
    coords = vec3(754.6987, -7042.05, 45.722),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere21 = lib.zones.sphere({
    coords = vec3(758.2083, -7050.50, 46.907),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere22 = lib.zones.sphere({
    coords = vec3(745.5186, -7044.47, 44.133),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere23 = lib.zones.sphere({
    coords = vec3(746.9084, -7056.52, 45.424),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere24 = lib.zones.sphere({
    coords = vec3(733.4519, -7048.42, 42.923),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere25 = lib.zones.sphere({
    coords = vec3(736.2438, -7055.23, 43.457),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere26 = lib.zones.sphere({
    coords = vec3(749.9609, -7065.05, 46.289),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere27 = lib.zones.sphere({
    coords = vec3(735.4831, -7063.16, 44.059),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})
local pickcoconut_sphere28 = lib.zones.sphere({
    coords = vec3(741.1201, -7073.95, 45.629),
    radius = 2,
    debug = false,
    inside = inside,
    onEnter = onEntercoconut,
    onExit = onExitcoconut

})