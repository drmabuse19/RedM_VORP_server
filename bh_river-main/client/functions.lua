StartWash = function(dic, anim)
  LoadAnim(dic)
  TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 5000, 0, 0.0, false, false, false)
  Citizen.Wait(5000)
  ClearPedTasks(PlayerPedId())
  Citizen.InvokeNative(0x6585D955A68452A5, PlayerPedId())
  Citizen.InvokeNative(0x9C720776DAA43E7E, PlayerPedId())
  Citizen.InvokeNative(0x8FE22675A5A45817, PlayerPedId())
end

LoadAnim = function(dic)
  RequestAnimDict(dic)

  while not (HasAnimDictLoaded(dic)) do
      Citizen.Wait(0)
  end
end

function whenKeyJustPressed(key)
  if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
      return true
  else
      return false
  end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
  local str = CreateVarString(10, "LITERAL_STRING", str)
  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  SetTextFontForCurrentCommand(15) 
  if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
  DisplayText(str, x, y)
end

