---------------- Initialize Vorpcore ----------------
local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)
---------------- Initialize Vorpcore Inventory API ----------------
VORP = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("canteen_empty", function(data)
		TriggerClientEvent('green:StartFilling', data.source)
	end)
end)
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("wateringcan_empty", function(data)
		TriggerClientEvent('green:StartFilling', data.source)
	end)
end)

local notifyDura = Config.Notifications["duration"] * 1000

RegisterNetEvent("fillup1")
AddEventHandler("fillup1", function()
  local item = "canteen_dirty"
  local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local empty_canteen = VORP.getItemCount(_source, 'canteen_empty')
  if empty_canteen > 0 then
    VORP.subItem(_source, "canteen_empty", 1)
    VORP.addItem(_source, item, 1)
    TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("fillsuccess"), notifyDura)
  end
end)

RegisterNetEvent("fillup1_80")
AddEventHandler("fillup1_80", function()
  local item = "canteen_dirty"
  local _source = source 
  local Character = VorpCore.getUser(_source).getUsedCharacter
	local canteen_80 = VORP.getItemCount(_source, 'canteen_80')
  if canteen_80 > 0 then
    VORP.subItem(_source, "canteen_80", 1)
    VORP.addItem(_source, item, 1)
    TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("fillsuccess"), notifyDura)
  end
end)

RegisterNetEvent("fillup1_60")
AddEventHandler("fillup1_60", function()
  local item = "canteen_dirty"
  local _source = source 
  local Character = VorpCore.getUser(_source).getUsedCharacter
	local canteen_60 = VORP.getItemCount(_source, 'canteen_60')
  if canteen_60 > 0 then
    VORP.subItem(_source, "canteen_60", 1)
    VORP.addItem(_source, item, 1)
    TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("fillsuccess"), notifyDura)
  end
end)

RegisterNetEvent("fillup1_40")
AddEventHandler("fillup1_40", function()
  local item = "canteen_dirty"
  local _source = source 
  local Character = VorpCore.getUser(_source).getUsedCharacter
	local canteen_40 = VORP.getItemCount(_source, 'canteen_40')
  if canteen_40 > 0 then
    VORP.subItem(_source, "canteen_40", 1)
    VORP.addItem(_source, item, 1)
    TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("fillsuccess"), notifyDura)
  end
end)

RegisterNetEvent("fillup1_20")
AddEventHandler("fillup1_20", function()
  local item = "canteen_dirty"
  local _source = source 
  local Character = VorpCore.getUser(_source).getUsedCharacter
	local canteen_20 = VORP.getItemCount(_source, 'canteen_20')
  if canteen_20 > 0 then
    VORP.subItem(_source, "canteen_20", 1)
    VORP.addItem(_source, item, 1)
    TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("fillsuccess"), notifyDura)
  end
end)

RegisterNetEvent("fillup2")
AddEventHandler("fillup2", function()
  local item = "wateringcan_dirtywater"
	local r = 1
  local _source = source 
  if r then
  VORP.subItem(_source, "wateringcan_empty", 1)
      VORP.addItem(_source, item, 1)
      TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("fillsuccess"), notifyDura)
  end
end)

RegisterServerEvent("checkcanteen")
AddEventHandler("checkcanteen", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local empty = VORP.getItemCount(_source, 'canteen_empty')
  local canteen_80 = VORP.getItemCount(_source, 'canteen_80')
  local canteen_60 = VORP.getItemCount(_source, 'canteen_60')
  local canteen_40 = VORP.getItemCount(_source, 'canteen_40')
  local canteen_20 = VORP.getItemCount(_source, 'canteen_20')
  local canteen_full = VORP.getItemCount(_source, 'canteen_full')

	if empty > 0 then
		TriggerClientEvent("canteencheck", _source)
   elseif canteen_full > 0 then
    TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("youalreadyfill"), notifyDura)
  else
		TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("youneeditemto"), notifyDura)
	end
end)

RegisterServerEvent("checkbucket")
AddEventHandler("checkbucket", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local empty = VORP.getItemCount(_source, 'wateringcan_empty')

	if empty > 0 then
		TriggerClientEvent("bucketcheck", _source)
	else
		TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("youalreadyfillb"), notifyDura)
	end
end)

RegisterServerEvent("checkdrink")
AddEventHandler("checkdrink", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	
	TriggerClientEvent("drinkcheck", _source)
    
end)

RegisterServerEvent("drinkmsg")
AddEventHandler("drinkmsg", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	


  TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("finishdrink"), notifyDura)

end)

RegisterServerEvent("wash:start")
AddEventHandler("wash:start", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter

  TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("washStart"), notifyDura)

end)

RegisterServerEvent("wash:end")
AddEventHandler("wash:end", function(rock)
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter

  TriggerClientEvent("vorp:" .. Config.Notifications["position"] .. "", _source, _U("washEnd"), notifyDura)

end)
