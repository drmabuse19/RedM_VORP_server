--Pulling Essentials
VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)
VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
BccUtils = exports['bcc-utils'].initiate()
FeatherMenu =  exports['feather-menu'].initiate()
BCCLegendarieshMenu = FeatherMenu:RegisterMenu('bcc-legendaries:Menu', {
    top = '40%',
    left = '20%',
    ['720width'] = '500px',
    ['1080width'] = '600px',
    ['2kwidth'] = '700px',
    ['4kwidth'] = '900px',
    style = {},
    contentslot = {
        style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
            ['height'] = '500px',
            ['min-height'] = '500px'
        }
    },
    draggable = true
})

function modelload(model) --Function To load the model
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(100)
    end
end

function distcheck(x, y, z, dist, entity) --Function used to handle distance checking
    while true do
        if StopAll then break end
        Wait(200)
        local ec = GetEntityCoords(entity)
        if GetDistanceBetweenCoords(ec.x, ec.y, ec.z, x, y, z, true) < dist then break end
    end
end

function spawnPed(model, x, y, z, networked)
    local createdped = CreatePed(model, x, y, z, networked, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, createdped, true)
    Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped)
    return createdped
end