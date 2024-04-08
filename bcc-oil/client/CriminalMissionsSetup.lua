local T = Translation.Langs[Config.Lang]

------- Oil Wagon Robbery Setup -----
Robableoilwagon, Roboilwagondeadcheck = 0, false
local fillcoords = nil
RegisterNetEvent('bcc-oil:RobOilWagon', function()
  Inmission = true

  Robableoilwagon = joaat('oilwagon02x')
  modelload(Robableoilwagon)

  --Coord Randomization
  fillcoords = CoordRandom(Config.OilWagonrobberyLocations)

  --Wagon Spawn
  Robableoilwagon = CreateVehicle(Robableoilwagon, fillcoords.wagonLocation, fillcoords.wagonHeading, true, true)
  TriggerEvent('bcc-oil:roboilwagonhelper')
  Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, Robableoilwagon)
  FreezeEntityPosition(Robableoilwagon, true)
  VORPcore.NotifyRightTip(T.RobOilWagonOpeningtext, 4000)

  --Waypoint Setup
  VORPutils.Gps:SetGps(fillcoords.wagonLocation)

  --Distance Check Setup
  local cw = GetEntityCoords(Robableoilwagon)
  distcheck(cw.x, cw.y, cw.z, 30, PlayerPedId())
  ClearGpsMultiRoute()
  if Roboilwagondeadcheck then
    VORPcore.NotifyRightTip(T.Missionfailed, 4000)
    DeleteEntity(Robableoilwagon) return
  end
  VORPcore.NotifyRightTip(T.RobOilWagonKillGaurds, 4000)

  --Spawning enemy Peds
  MutltiPedSpawnDeadCheck(fillcoords.pedlocation, 'wagonrob')
end)

function roboilwagonreturnwagon()
  --Init Setup
  FreezeEntityPosition(Robableoilwagon, false)
  VORPcore.NotifyRightTip(T.RobOilWagonReturnWagon, 4000)

  --Blip and Waypoint Setup
  local blip1 = BlipWaypoin(fillcoords.returnlocation.x, fillcoords.returnlocation.y, fillcoords.returnlocation.z, T.RobOilWagonReturnBlip)

  --Distance Check Setup for returning the wagon
  distcheck(fillcoords.returnlocation.x, fillcoords.returnlocation.y, fillcoords.returnlocation.z, 10, Robableoilwagon)
  ClearGpsMultiRoute()
  if Roboilwagondeadcheck then
    RemoveBlip(blip1)
    VORPcore.NotifyRightTip(T.Missionfailed, 4000)
    DeleteEntity(Robableoilwagon) return
  end

  --End of mission setup
  Inmission = false
  FreezeEntityPosition(Robableoilwagon, true)
  RemoveBlip(blip1)
  TaskLeaveAnyVehicle(PlayerPedId(), 0, 0)
  Wait(4000)
  DeleteEntity(Robableoilwagon)
  VORPcore.NotifyRightTip(T.RobOilWagonSuccess, 4000)
  TriggerServerEvent('bcc-oil:RobberyPayout')
end

function finishOilCompanyRobbery()
  Inmission = false
  VORPcore.NotifyRightTip(T.RobberySuccess, 4000)
  TriggerServerEvent('bcc-oil:RobberyPayout')
end

--Deadcheck event
AddEventHandler('bcc-oil:roboilwagonhelper', function()
  Wait(400)
  while Inmission do
    Wait(100)
    if IsEntityDead(PlayerPedId()) or GetEntityHealth(Robableoilwagon) == 0 or not DoesEntityExist(Robableoilwagon) then
      Roboilwagondeadcheck = true
      Inmission = false
      Wait(3000)
      Roboilwagondeadcheck = false break
    end
  end
end)

--Rob Oil Company Variables Setup
Roboilcodeadcheck = false
local fillcoords2, missionoverend3dtext = nil, false
RegisterNetEvent('bcc-oil:RobOilCo', function()
  VORPcore.NotifyRightTip(T.RobOilCoBlip, 4000)
  Inmission = true
  TriggerEvent('bcc-oil:roboilcohelper')

  --Coord Randomization
  fillcoords2 = CoordRandom(Config.RobOilCompany)

  --Blip and Waypoint Setup
  local blip1 = BlipWaypoin(fillcoords2.lootlocation.x, fillcoords2.lootlocation.y, fillcoords2.lootlocation.z, T.RobOilCoBlip)

  --Distance Check Setup for close to lockpick Location
  distcheck(fillcoords2.lootlocation.x, fillcoords2.lootlocation.y, fillcoords2.lootlocation.z, 5, PlayerPedId())
  ClearGpsMultiRoute()
  if Roboilcodeadcheck then
    RemoveBlip(blip1)
    VORPcore.NotifyRightTip(T.Missionfailed, 4000) return
  end
  RemoveBlip(blip1)
  local cfg = {
    focus = true, -- Should minigame take nui focus
    cursor = true, -- Should minigame have cursor  (required for lockpick)
    maxattempts = Config.LockPick.MaxAttemptsPerLock, -- How many fail attempts are allowed before game over
    threshold = Config.LockPick.difficulty, -- +- threshold to the stage degree (bigger number means easier)
    hintdelay = Config.LockPick.hintdelay, --milliseconds delay on when the circle will shake to show lockpick is in the right position.
    stages = {
      {
        deg = 25 -- 0-360 degrees
      },
      {
        deg = 0 -- 0-360 degrees
      },
      {
        deg = 300 -- 0-360 degrees
      }
    }
  }
  while true do
    Wait(5)
    local pl = GetEntityCoords(PlayerPedId())
    local dist = GetDistanceBetweenCoords(fillcoords2.lootlocation.x, fillcoords2.lootlocation.y, fillcoords2.lootlocation.z, pl.x, pl.y, pl.z, true)
    if dist < 3 then
      if IsControlJustReleased(0, 0x760A9C6F) then
        MiniGame.Start('lockpick', cfg, function(result)
          if result.unlocked then
            if not Config.RobOilCoEnemyPeds then
              missionoverend3dtext = true --sets var true which is used to disable the 3d text from showing
              Inmission = false
              VORPcore.NotifyRightTip(T.RobberySuccess, 4000)
              TriggerServerEvent('bcc-oil:OilCoRobberyPayout', fillcoords2)
            else
              MutltiPedSpawnDeadCheck(Config.RobOilCoEnemyPedsLocations, 'oilcorob')
              Inmission = false
            end
          else
            if not Config.RobOilCoEnemyPeds then
              missionoverend3dtext = true --sets var true which is used to disable the 3d text from showing
              Inmission = false
              VORPcore.NotifyRightTip(T.Missionfailed, 4000)
            else
              MutltiPedSpawnDeadCheck(Config.RobOilCoEnemyPedsLocations, 'oilcorob')
              Inmission = false
            end
          end
        end) break
      end
    elseif dist > 200 then
      Wait(2000)
    end
  end
end)

AddEventHandler('bcc-oil:roboilcohelper', function()
  while Inmission do
    Wait(5)
    local pl = GetEntityCoords(PlayerPedId())
    local dist = GetDistanceBetweenCoords(pl.x, pl.y, pl.z, fillcoords2.lootlocation.x, fillcoords2.lootlocation.y, fillcoords2.lootlocation.z, true)
    if dist < 15 then
      if not missionoverend3dtext then
        BccUtils.Misc.DrawText3D(fillcoords2.lootlocation.x, fillcoords2.lootlocation.y, fillcoords2.lootlocation.z, T.PressGToLockPick)
      else
        missionoverend3dtext = false break
      end
    elseif dist > 200 then
      Wait(2000)
    end
    if IsEntityDead(PlayerPedId()) then
      Inmission = false
      Roboilcodeadcheck = true
      Wait(10000)
      Roboilcodeadcheck = false
    end
  end
end)
