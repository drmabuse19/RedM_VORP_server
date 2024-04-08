local T = Translation.Langs[Config.Lang]

------ Handles spawning of main peds ------
local npcs, blips = {}, {}

local createBlip = function(x, y, z, color, blipHash, blipName)
  local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z)
  SetBlipSprite(blip, blipHash, 1)
  SetBlipScale(blip, 0.8)
  Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(color))
  Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipName)
  table.insert(blips, blip)
end

CreateThread(function()
  local model = joaat(Config.ManagerPedModel)
  if Config.ManagerBlip then
    createBlip(OilWagonTable.ManagerSpawn.x, OilWagonTable.ManagerSpawn.y, OilWagonTable.ManagerSpawn.z, Config.ManagerBlipColor, Config.ManagerBlipHash, T.ManagerBlip)
  end
  modelload(model)
  local createdped = CreatePed(model, OilWagonTable.ManagerSpawn.x, OilWagonTable.ManagerSpawn.y, OilWagonTable.ManagerSpawn.z - 1, OilWagonTable.ManagerSpawn.h, false, true, true, true)
  Citizen.InvokeNative(0x283978A15512B2FE, createdped, true)
  BccUtils.Ped.SetStatic(createdped)
  while true do
    Wait(5)
    local playercoord = GetEntityCoords(PlayerPedId())
    local dist = GetDistanceBetweenCoords(playercoord.x, playercoord.y, playercoord.z, OilWagonTable.ManagerSpawn.x, OilWagonTable.ManagerSpawn.y, OilWagonTable.ManagerSpawn.z, true)
    if dist < 5 then
      BccUtils.Misc.DrawText3D(OilWagonTable.ManagerSpawn.x, OilWagonTable.ManagerSpawn.y, OilWagonTable.ManagerSpawn.z, T.ManagerDrawText)
      if IsControlJustReleased(0, 0x760A9C6F) then
        SetNuiFocus(true, true)
        SendNUIMessage({
          type = 'open',
          config = Config,
          language = T
        })
        TriggerServerEvent('bcc:oil:DBCheck')
      end
    elseif dist > 200 then
      Wait(2000)
    end
  end
end)

--Criminal Ped Spawn Setup
CreateThread(function()
  local model = joaat(Config.CriminalPedModel)
  if Config.CriminalPedBlip then
    createBlip(Config.CriminalPedSpawn.x, Config.CriminalPedSpawn.y, Config.CriminalPedSpawn.z, Config.CriminalBlipColor, Config.CriminalBlipHash, T.CriminalPedBlip)
  end
  modelload(model)
  local createdped = CreatePed(model, Config.CriminalPedSpawn.x, Config.CriminalPedSpawn.y, Config.CriminalPedSpawn.z - 1, Config.CriminalPedSpawn.h, false, true, true, true)
  Citizen.InvokeNative(0x283978A15512B2FE, createdped, true)
  BccUtils.Ped.SetStatic(createdped)
  while true do
    Wait(5)
    local pl = GetEntityCoords(PlayerPedId())
    local dist = GetDistanceBetweenCoords(pl.x, pl.y, pl.z, Config.CriminalPedSpawn.x, Config.CriminalPedSpawn.y, Config.CriminalPedSpawn.z, true)
    if dist < 5 then
      BccUtils.Misc.DrawText3D(Config.CriminalPedSpawn.x, Config.CriminalPedSpawn.y, Config.CriminalPedSpawn.z, T.CriminalDrawText) --draws text on the manager
      if IsControlJustReleased(0, 0x760A9C6F) then --if g is pressed then
        SetNuiFocus(true, true) --sets nui focus gives you mouse control
        SendNUIMessage({ --sends a nui message triggering the js script
          type = 'open2', --sends the type var as open2
          config = Config, --sends the config table too the js file
          language = T
        })
        TriggerServerEvent('bcc:oil:DBCheck')
      end
    elseif dist > 200 then
      Wait(2000)
    end
  end
end)

------ Cleanup ------
AddEventHandler("onResourceStop", function(resource)
  if resource == GetCurrentResourceName() then
    for k, v in pairs(npcs) do
      DeletePed(v)
    end
    for k, v in pairs(blips) do
      RemoveBlip(v)
    end
  end
end)
