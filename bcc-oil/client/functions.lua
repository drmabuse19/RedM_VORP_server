local T = Translation.Langs[Config.Lang]

--Pulling Essentials
VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
VORPutils = {}
TriggerEvent("getUtils", function(utils)
  VORPutils = utils
end)
BccUtils = exports['bcc-utils'].initiate()
MiniGame = exports['bcc-minigames'].initiate()

function distcheck(x, y, z, dist, entity) --Function used to handle distance checking
    while true do
        if Playerdead or WagonDestroyed or Roboilwagondeadcheck or Roboilcodeadcheck then break end
        Wait(100)
        local ec = GetEntityCoords(entity)
        local dist2 = GetDistanceBetweenCoords(ec.x, ec.y, ec.z, x, y, z, true)
        if dist2 < dist then
            break
        elseif dist2 > dist + 100 then
            Wait(1000)
        end
    end
end

function PlayerCarryBox(props) --Function for making player carry a box
    SetEntityAsMissionEntity(props, true, true)
    RequestAnimDict("mech_carry_box")
    while not HasAnimDictLoaded("mech_carry_box") do
        Wait(100)
    end
    local pl = PlayerPedId()
    Citizen.InvokeNative(0xEA47FE3719165B94, pl ,"mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
    Citizen.InvokeNative(0x6B9BBD38AB0796DF, props, pl ,GetEntityBoneIndexByName(pl,"SKEL_R_Finger12"), 0.20, 0.028, -0.15, 100.0, 205.0, 20.0, true, true, false, true, 1, true)
end

function modelload(model) --Function to load model
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(100)
    end
end

function MutltiPedSpawnDeadCheck(pedstable, type) --function for spawning multiple peds and checking if they are dead
    local model = joaat('a_m_m_huntertravelers_cool_01')
    modelload(model)
    local count, roboilwagonpeds = {}, {}
    for k, v in pairs(pedstable) do
        roboilwagonpeds[k] = CreatePed(model, v.x, v.y, v.z, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, roboilwagonpeds[k], true)
        TaskCombatPed(roboilwagonpeds[k], PlayerPedId())
        Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, roboilwagonpeds[k])
        count[k] = roboilwagonpeds[k]
    end
    local x = #pedstable
    while not Roboilwagondeadcheck and not Roboilcodeadcheck do
        Wait(60)
        for k, v in pairs(roboilwagonpeds) do
            if IsEntityDead(v) then
                if count[k] ~= nil then
                    x = x - 1
                    count[k] = nil
                    if x == 0 then
                        if type == 'wagonrob' then
                            roboilwagonreturnwagon()
                        elseif type == 'oilcorob' then
                            finishOilCompanyRobbery()
                        end
                        break
                    end
                end
            end
        end
    end
    if Roboilwagondeadcheck or Roboilcodeadcheck then
        for k, v in pairs(roboilwagonpeds) do
          DeletePed(v)
        end
        DeleteEntity(Robableoilwagon)
        VORPcore.NotifyRightTip(T.Missionfailed, 4000) return
    end
end

function BlipWaypoin(x, y, z, blipname) --func to make blip and waypoint and return the blip
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, -1282792512, x, y, z, 5)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipname)
    VORPutils.Gps:SetGps(x, y, z)
    return blip
end

function CoordRandom(coordstable) --funct to pick random coords from table
    local mathr1 = math.random(1, #coordstable)
    return coordstable[mathr1]
end
