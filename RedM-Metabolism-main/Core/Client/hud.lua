--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
function Wait(args) Citizen.Wait(args) end
function Invoke(args, bool) Citizen.InvokeNative(args, bool) end
--------------------------------------------------------------------------------
-- Event Register
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do Wait(1)
  Invoke(0x50C803A4CD5932C5, true)
  local User = PlayerPedId()
  local coords = GetEntityCoords(User)
  local temp = GetTemperatureAtCoords(coords)
  local format = Temperature.Format
  if format == 'c' or format == 'C' then
    SendNUIMessage({
      action = 'SetHud',
      show = not IsRadarHidden(),
      hunger = _Hunger,
      thirst = _Thirst,
      --stress = mystress,
      --cash = money,
      temp = math.floor(temp).."°C",
    }) Wait(1000)
  elseif format == 'f' or format == 'F' then
    SendNUIMessage({
      action = 'SetHud',
      show = not IsRadarHidden(),
      hunger = _Hunger,
      thirst = _Thirst,
      --stress = mystress,
      --cash = money,
      temp = math.floor(temp * 1.8 + 32.0).."°F",
    }) Wait(1000)
  else
    SendNUIMessage({
      action = 'SetHud',
      show = not IsRadarHidden(),
      hunger = _Hunger,
      thirst = _Thirst,
      --stress = mystress,
      --cash = money,
      temp = "Incorrect_Format_Check_Config",
    }) Wait(1000)
  end
end
end)
