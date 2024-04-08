HorseAPI = {}

function HorseAPI:Create(modelHash, x, y, z, heading, gender, safeground, networked, vector4)
  local HorseClass = {}

  if not x and not y and not z and not heading then
    x, y, z, heading = table.unpack(vector4)
  end

  if CheckVar(safeground, true) then
    local groundCheck, ground = nil, nil
    for height = 1, 1000 do
      groundCheck, ground = GetGroundZAndNormalFor_3dCoord(x, y, height + 0.0)
      if groundCheck then
        break
      end
    end
    z = ground
  end

  local countToBreak = 100
  if not IsModelInCdimage(modelHash) then
    error('Invalid Model')
  end

  while not HasModelLoaded(modelHash) do
    RequestModel(modelHash)
    countToBreak = countToBreak - 1
    if countToBreak == 0 then
      break
    end
    Wait(50)
  end

  local hash
  if type(modelHash) == "string" then
    hash = joaat(modelHash)
    if not Citizen.InvokeNative(0x772A1969F649E902, hash) then
      error('The provided model hash is not a horse!')
      return
    end
  end

  HorseClass.Ped = CreatePed(hash, x, y, z, CheckVar(heading, GetEntityHeading(PlayerPedId())),
    CheckVar(networked, true), true, false, false)

  Citizen.InvokeNative(0x58A850EAEE20FAA3, HorseClass.Ped, true)
  Citizen.InvokeNative(0x283978A15512B2FE, HorseClass.Ped, true)
  if gender == 'female' then
    Citizen.InvokeNative(0x5653AB26C82938CF, HorseClass.Ped, 41611, 1.0)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, HorseClass.Ped)
  end

  function HorseClass:Freeze(state)
    FreezeEntityPosition(self.Ped, CheckVar(state, true))
  end

  function HorseClass:Invincible(state)
    SetEntityInvincible(self.Ped, CheckVar(state, true))
  end

  function HorseClass:CanBeDamaged(state)
    SetEntityCanBeDamaged(self.Ped, CheckVar(state, true))
  end

  function HorseClass:SetBlockingOfNonTemporaryEvents(state)
    SetBlockingOfNonTemporaryEvents(self.Ped, CheckVar(state, false))
  end

  function HorseClass:SetHeading(head)
    SetEntityHeading(self.Ped, CheckVar(head, 0))
  end

  function HorseClass:CanBeMounted(state)
    Citizen.InvokeNative(0x2D64376CF437363E, self.Ped, CheckVar(state, true))
  end

  function HorseClass:SetBlip(title, blipHash)
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, CheckVar(blipHash, -1230993421), self.Ped)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, CheckVar(title, 'MyHorse'))
  end

  function HorseClass:SetPromptName(title)
    SetPedPromptName(self.Ped, CheckVar(title, 'MyHorse'))
  end

  function HorseClass:UpdatePedVariation()
    Citizen.InvokeNative(0xCC8CA3E88256E58F, self.Ped, false, true, true, true, false)
  end

  function HorseClass:EquipMetaPedOutfit(outfitHash)
    if not joaat(tonumber(outfitHash)) then
      error('Invalid Hash!')
      return
    end
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, self.Ped, joaat(tonumber(outfitHash)))
  end

  function HorseClass:SetComponentEnabled(component, now)
    if not tonumber(component) then
      error('Component hash is required!')
      return
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, self.Ped, tonumber(component), CheckVar(now, true), true, true)
  end

  function HorseClass:RemoveComponent(component)
    if not component then
      error('Component is required!')
      return
    end
    Citizen.InvokeNative(0x0D7FFA1B2F69ED82, self.Ped, tonumber(component), 0, 0)
  end

  function HorseClass:IsMountSeatFree(seat)
    return Citizen.InvokeNative(0xAAB0FE202E9FC9F0, self.Ped, CheckVar(seat, -1))
  end

  function HorseClass:SetTag(title)
    local tag = Citizen.InvokeNative(0xE961BF23EAB76B12, self.Ped, CheckVar(title, 'MyHorse'))
    Citizen.InvokeNative(0x5F57522BC1EB9D9D, tag, joaat('PLAYER_HORSE'))
    Citizen.InvokeNative(0xA0D7CE5F83259663, tag)
  end

  function HorseClass:SetTagVisibility(tag, state)
    Citizen.InvokeNative(0x93171DDDAB274EB8, tag, CheckVar(state, 2))
  end

  function HorseClass:IsTagActive(tag)
    Citizen.InvokeNative(0x502E1591A504F843, tag, self.Ped)
  end

  function HorseClass:SetPlayerOwnsMount(playerPed)
    Citizen.InvokeNative(0xE6D4E435B56D5BD0, CheckVar(playerPed, PlayerPedId()), self.Ped)
  end

  function HorseClass:DisableShockingEvents(value)
    Citizen.InvokeNative(0x1913FE4CBF41C463, self.Ped, 113, CheckVar(value, true))
  end

  function HorseClass:ForceLockOn(value)
    Citizen.InvokeNative(0x1913FE4CBF41C463, self.Ped, 297, CheckVar(value, true))
  end

  function HorseClass:DisableFleeFromGunshot(value)
    Citizen.InvokeNative(0x1913FE4CBF41C463, self.Ped, 312, CheckVar(value, true))
  end

  function HorseClass:IsWild()
    return Citizen.InvokeNative(0x3B005FF0538ED2A9, self.Ped)
  end

  function HorseClass:SetWild(value)
    Citizen.InvokeNative(0xAEB97D84CDF3C00B, self.Ped, CheckVar(value, true))
  end

  function HorseClass:SetBondingLevel(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0xA69899995997A63B, self.Ped, CheckVar(value, 0))
  end

  function HorseClass:GetOwner()
    return Citizen.InvokeNative(0xAD03B03737CE6810, self.Ped)
  end

  function HorseClass:Clean()
    Citizen.InvokeNative(0x6585D955A68452A5, self.Ped)
  end

  function HorseClass:ClearDamage()
    Citizen.InvokeNative(0x523C79AEEFCC4A2A, self.Ped, 10, 'ALL')
  end

  function HorseClass:ClearBloodDamage()
    Citizen.InvokeNative(0x8FE22675A5A45817, self.Ped)
  end

  function HorseClass:GetHorseTamingState()
    return Citizen.InvokeNative(0x454AD4DA6C41B5BD, self.Ped)
  end

  function HorseClass:SetPeltForHorse(peltId)
    if not tonumber(peltId) then
      error('peltId is required!')
    end
    Citizen.InvokeNative(0xA73F50E8796150D5, self.Ped, peltId)
  end

  function HorseClass:GetPeltFromHorse(index)
    if not tonumber(index) then
      error('Index is required!')
    end
    return Citizen.InvokeNative(0x0CEEB6F4780B1F2F, self.Ped, index)
  end

  function HorseClass:ClearPeltFromHorse(peltId)
    if not tonumber(peltId) then
      error('peltId is required!')
    end
    Citizen.InvokeNative(0x627F7F3A0C4C51FF, self.Ped, peltId)
  end

  function HorseClass:AgitateHorse(throwRider)
    Citizen.InvokeNative(0xBAE08F00021BFFB2, self.Ped, CheckVar(throwRider, false))
  end

  function HorseClass:HorseAction(action)
    Citizen.InvokeNative(0xA09CFD29100F06C3, self.Ped, CheckVar(action, 1), 0, 0)
  end

  function HorseClass:SetAvoidanceLevel(level)
    Citizen.InvokeNative(0xDDCF6FEA5D7ACC17, self.Ped, CheckVar(level, -1))
  end

  function HorseClass:ResetAvoidanceLevel()
    Citizen.InvokeNative(0x2A5AFD2B8381A6E1, self.Ped)
  end

  -- Stamina
  function HorseClass:GetMaxStamina()
    return Citizen.InvokeNative(0xCB42AFE2B613EE55, self.Ped)
  end

  function HorseClass:GetStamina()
    return Citizen.InvokeNative(0x775A1CA7893AA8B5, self.Ped)
  end

  function HorseClass:ChangeStamina(value)
    Citizen.InvokeNative(0xC3D4B754C0E86B9E, CheckVar(value, 0))
  end

  function HorseClass:RestoreStamina(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0x675680D089BFA21F, self.Ped, CheckVar(value, 100.0) + 0.0)
  end

  function HorseClass:GetStaminaDepletionMultiplier()
    return Citizen.InvokeNative(0x825F6DD559A0895B, self.Ped)
  end

  function HorseClass:SetStaminaDepletionMultiplier(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0xEF5A3D2285D8924B, self.Ped, CheckVar(value, self.GetStaminaDepletionMultiplier(self)) + 0.0)
  end

  function HorseClass:GetStaminaRechargeMultiplier()
    return Citizen.InvokeNative(0xE7687EB2F634ABF0, self.Ped)
  end

  function HorseClass:SetStaminaRechargeMultiplier(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0x345C9F993A8AB4A4, self.Ped, CheckVar(value, self.GetStaminaRechargeMultiplier(self)) + 0.0)
  end

  -- Health
  function HorseClass:GetMaxHealth()
    return Citizen.InvokeNative(0x4700A416E8324EF3, self.Ped)
  end

  function HorseClass:SetMaxHealth(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0xF5F6378C4F3419D3, self.Ped, CheckVar(value, self.GetMaxHealth(self)))
  end

  function HorseClass:GetHealth()
    return Citizen.InvokeNative(0x82368787EA73C0F7, self.Ped)
  end

  function HorseClass:ChangeHealth(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0x835F131E7DC8F97A, CheckVar(value, 0), 0, 0)
  end

  function HorseClass:GetHealthRechargeMultiplier()
    return Citizen.InvokeNative(0x95B8E397B8F4360F, self.Ped)
  end

  function HorseClass:SetHealthRechargeMultiplier(value)
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0xDE1B1907A83A1550, self.Ped, CheckVar(value, self.GetStaminaRechargeMultiplier(self)) + 0.0)
  end

  -- Inner Cores
  function HorseClass:GetCoreValue(type)
    return Citizen.InvokeNative(0x36731AC041289BB1, self.Ped, CheckVar(type))
  end

  function HorseClass:SetCoreValue(type, value)
    if value > 100 then value = 100 end
    if value < 0 then value = 0 end
    Citizen.InvokeNative(0xC6258F41D86676E0, self.Ped, CheckVar(type, 0), CheckVar(value, 100))
  end

  function HorseClass:PlayAnimation(playerPed, animationHash, itemName, skip)
    if not animationHash then
      error('Animation hash is required!')
      return
    end

    if not itemName then
      error('Animation hash is required!')
      return
    end
    Citizen.InvokeNative(0xCD181A959CFDD7F4, CheckVar(playerPed, PlayerPedId()), self.Ped, joaat(animationHash),
      joaat(itemName), CheckVar(skip, true))
  end

  function HorseClass:StartScenario(scenarioHash)
    if not scenarioHash then
      error('Scenario has is required!!')
      return
    end
    Citizen.InvokeNative(0x524B54361229154F, self.Ped, joaat(scenarioHash), -1, true, 0, -1, false)
  end

  function HorseClass:ClearTasks()
    ClearPedTasks(self.Ped)
  end

  function HorseClass:SetPedConfigFlag(flag, active)
    Citizen.InvokeNative(0x1913FE4CBF41C463, self.Ped, CheckVar(flag, 207), CheckVar(active, 1))
  end

  function HorseClass:GetHorse()
    return self.Ped
  end

  function HorseClass:Remove()
    DeletePed(self.Ped)
    DeleteEntity(self.Ped)
    Citizen.InvokeNative(0x5E94EA09E7207C16, self.Ped)
    self.Ped = nil
    self.Tag = nil
  end

  return HorseClass
end
